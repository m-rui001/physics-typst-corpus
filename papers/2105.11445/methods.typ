#let c(..keys) = super(keys.pos().map(k => cite(k)).join(", "))
#let gc = [\[PR95\] 30244]

#heading(level: 1)[Methods]

#heading(level: 2)[Observations and Data reduction]

#heading(level: 3)[VLBI observations]

As part of our ongoing very long baseline interferometry (VLBI) campaign called PRECISE (Pinpointing
REpeating ChIme Sources with the EVN), we observed the field centred on the coordinates from the
discovery#c(<bhardwaj_2021_apjl>) of FRB 20200120E: RA (J2000) $= 09^"h" 57^"m" 56.688^"s"$, Dec
(J2000) $= 68° 49′ 31.8″$. The quoted 90% confidence interval#c(<bhardwaj_2021_apjl>) of radius
$tilde 1.5′$ is well covered by the field of view of the _ad-hoc_ interferometric array we used to
observe, which is comprised of dishes that are also part of the EVN. We observed the field 15 times
between February and May 2021 (@tab:all-precise-runs-on-m81), with burst detections in the data that
were taken on 2021 February 20 UT 17:00--22:00 (project code PR141A), 2021 March 7 UT 15:45--20:45
(PR143A), and 2021 April 28 UT 11:00--22:00 (PR158A). We observed in the 21-cm band
($tilde 1.4$ GHz) with slightly different array setups in each run. Depending on the capabilities
at each station, we recorded either 128 or 256 MHz of total bandwidth, divided into 8 or 16
subbands of 16 MHz each. The participating stations and their respective frequency coverage are
summarised in @tab:stations. We ran regular phase-referencing observations with a cycle time of
7.5 min; that is, 5.5 minutes on target and 2.0 minutes on the phase calibrator
(J0955$+$6903, at $approx 0.32°$ separation). In total, we spent 2.93 hrs on the target field in
each of PR141A and PR143A, and 6.73 hrs in PR158A. The calibrator source J1048$+$7143 served as
fringe finder and bandpass calibrator and was observed twice for 5 minutes in each run. For
verification and single-dish time-domain calibration purposes we observed the pulsar B0355$+$54 for
2 minutes in PR141A and PR143A. In PR158A the pulsar B2255$+$58 was observed for 5 minutes for
the same reason.

We recorded raw voltages (‘baseband’ data, dual circular polarisation, 2-bit sampling) in
VDIF#c(<whitney_2010_ivs>) or Mark5B#c(<whitney_2004_evn>) format at all stations. At Effelsberg we
also recorded total intensity filterbanks with the PSRIX pulsar backend#c(<lazarus_2016_mnras>) in
parallel to the voltage data. These data span the frequency range of $1255$--$1505$ MHz with a
time and frequency resolution of 102.4 $"µs"$ and 0.49 MHz, respectively. Similarly, at SRT we also
recorded in parallel baseband data and total intensity filterbanks (with the local Digital Filter
Bank system, DFB). These DFB-filterbanks have a time and frequency resolution of 128 $"µs"$ and
1 MHz, respectively, covering the frequency range of 1140.5--2163.5 MHz out of which we search
the usable range of 1210.5--1739.5 MHz.

The data from both Effelsberg and SRT were searched for bursts in two independent pipelines. The
baseband data were processed with the pipeline outlined in Kirsten et al.#c(<kirsten_2021_natas>),
which converts the raw voltages to filterbank format (in this case, total intensity with time
resolution 64 $"µs"$ and frequency resolution 125 kHz) and searches those with _Heimdall_ within
$plus.minus 50$ pc cm^(-3) of the expected $"DM" = 87.818$ pc cm^(-3), as found by Bhardwaj et
al.#c(<bhardwaj_2021_apjl>). The burst candidates are classified as either radio frequency
interference (RFI) or potential FRBs using the neural network classifier FETCH#c(<agarwal_2020_mnras>).
The filterbanks as recorded with the respective pulsar backends were searched with a pipeline that
uses the PRESTO suite of tools#c(<ransom_2001_phdt>, <ransom_2011_ascl>) and a classifier based on
work by Michilli et al.#c(<michilli_2018_mnras>).

Correlation of the data was performed at the Joint Institute for VLBI ERIC (JIVE; in the
Netherlands) under proposal EK048 (with codes EK048B for PR141A, EK048C for PR143A, and EK048F for
PR158A). In total, we ran three correlator passes using the software
correlator SFXC#c(<keimpema_2015_exa>): in the first run we correlate all scans containing the
calibrator sources with a standard 2-s time integration and 64 channels per 16-MHz subband. A second
correlation pass was performed only on the data containing bursts (their arrival times were
determined via the search described above), with a higher frequency resolution (8 192 channels per
subband) and time resolution (the correlation gates around the bursts were chosen manually to
optimise the signal-to-noise for each burst, @tab:pol_properties). The strongest bursts allowed a
direct fringe fit on their data, which provided a first estimate of their sky position to a level of
a few arcseconds: RA (J2000) $approx 09^"h" 57^"m" 54.8^"s"$, Dec (J2000)
$approx 68° 49′ 03″$. We then used this position to re-correlate the burst data at the same frequency
resolution as in the first correlation pass. This allowed us to directly apply the calibration
performed on the first pass (containing the calibrator sources) to the data containing bursts.

The full data reduction was performed using the Astronomical Image Processing System
(AIPS#c(<greisen_2003_assl>)) and _Difmap_#c(<shepherd_1994_baas>) following standard procedures.
_A-priori_ amplitude calibration was performed using the known gain curves and system temperature
measurements recorded at each station during the observation. These data were not available for
Toruń and Irbene in EK048B, and for Urumqi in EK048C. We used nominal system equivalent flux density
values and flat gain curves to perform the amplitude calibration in these cases. In EK048C, the data
from Urumqi were flagged due to the impossibility to properly convert the locally-recorded linear
polarizations into circular ones (as in the rest of the antennas). Ionospheric dispersive delays were
calculated from maps of total electron content provided by the global positioning system satellites
and removed via the _TECOR_ task in _AIPS_. We first corrected for the instrumental delays and
bandpass calibration using the calibrator source J1048+7143, and thereafter fringe-fit the data
using all calibrator sources. The phase calibrator (J0955+6903; displaying a peak brightness of
$tilde 73 "mJy beam"^(-1)$) was then imaged and self-calibrated to improve the final calibration of
the data (for both phases and amplitudes). A common source model for the phase calibrator was used to
improve the calibration of both epochs. The obtained solutions were then transferred to the burst
data, which were finally imaged.

In the third, and final, correlator pass we processed the entire observation, correlating all scans
from the target with the same time and frequency setup as in the first correlator pass, in order to
obtain a deep continuum image of the field.

#figure(
  text(table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: 3pt,
    table.header(
      [Observation], [EVN], [], [],
      [Project code], [Project code], [Start MJD], [Stop MJD],
    ),
    table.hline(),
    [PR141A#super[a]], [EK048B], [59265.708], [59265.916],
    [PR143A#super[a]], [EK048C], [59280.656], [59280.864],
    [PR144A], [], [59283.792], [59284.000],
    [PR145A], [], [59289.750], [59289.958],
    [PR146A], [], [59295.667], [59295.875],
    [PR153A], [], [59314.887], [59314.972],
    [PR158A#super[a]], [EK048F], [59332.458], [59332.916],
    [PR159A], [], [59336.708], [59337.000],
    [PR160A], [], [59341.833], [59342.072],
    [PR161A], [], [59344.771], [59344.875],
    [PR162A], [], [59346.646], [59346.895],
    [PR163A], [], [59347.417], [59347.625],
    [PR164A], [], [59351.917], [59352.166],
    [PR165A], [], [59358.917], [59359.166],
    [PR166A], [], [59360.708], [59360.916],
    table.hline(),
    table.cell(colspan: 4, align: left)[#super[a] Epoch with detection],
  ), size: 7.5pt),
  caption: [Time ranges of PRECISE runs targeting FRB 20200120E between February and May 2021.],
  kind: table, placement: top, scope: "parent",
) <tab:all-precise-runs-on-m81>

#figure(
  text(table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: 3pt,
    table.header(
      [Telescope], [Frequency coverage [MHz]], [Station project code], [EVN project code],
    ),
    table.hline(),
    [Effelsberg (Ef)], [$1254 - 1510$], [94-20], [EK048B/C/F#super[b]],
    [Medicina (Mc)], [$1350 - 1478$], [44-20], [EK048B/C/F#super[c]],
    [Noto (Nt)], [$1318 - 1574$], [44-20], [EK048C],
    [Irbene (Ir)], [$1382 - 1510$], [--], [EK048B/C/F],
    [Toruń (Tr)], [$1254 - 1510$], [DDT#super[a]], [EK048B/C/F#super[b]],
    [Westerbork (Wb)], [$1382 - 1510$], [DDT#super[a]], [EK048B/C/F],
    [Urumqi (Ur)], [$1382 - 1510$], [DDT#super[a]], [EK048C/F],
    [Sardinia (Sr)], [$1360 - 1488$], [44-20], [EK048F],
    [Onsala (O8)], [$1382 - 1510$], [DDT#super[a]], [EK048BF#super[b]],
    [Badary (Bd)], [$1382 - 1510$], [DDT#super[a]], [EK048F],
    [Svetloe (Sv)], [$1382 - 1510$], [DDT#super[a]], [EK048F],
    [Zelenchukskaya (Zc)], [$1382 - 1510$], [DDT#super[a]], [EK048F],
    [VLA-VLITE], [$320 - 384$], [20B-280], [--],
    [VLA-_Realfast_], [$1300 - 1700$], [20B-280], [--],
    table.hline(),
    table.cell(colspan: 4, align: left)[
      #super[a] Director's Discretionary Time \
      #super[b] Only stations recording the part of the band where the burst (B5) was detected
      with significant emission. \
      #super[c] Only one subband overlapping with the part of the band where the burst (B5) was
      detected with significant emission.
    ],
  ), size: 7.5pt),
  caption: [Setups at the different stations during observations used in the analysis.],
  kind: table, placement: top, scope: "parent",
) <tab:stations>

#heading(level: 3)[VLA]

We observed the field of FRB 20200120E with the Karl G. Jansky Very Large Array (VLA) as part of a
program to localise repeating FRBs identified by CHIME/FRB (program 20B-280). The field was observed
in five 1-hour blocks from 2020 December 29 through 2021 January 18. Data were recorded in parallel
at both $1.5$ GHz and $340$ MHz. The VLA antennas were arranged in the A configuration, which
provides baseline lengths up to 30 km and a typical spatial resolution of $1.3″$ and $6.0″$ at
$1.5$ GHz and $340$ MHz, respectively. The total on-target integration time amounts to
200 minutes.

*Realfast.* Visibility data from the VLA observations were recorded with a sampling time of 3 seconds
from 1 to 2 GHz. Simultaneously, a copy of the data with sampling time of 10 ms was streamed into
the _Realfast_ system#c(<law_2018_apjs>). We used _Realfast_ to search this data stream for FRBs in
real time. The typical $1 sigma$ sensitivity of the VLA is $5 "mJy beam"^(-1)$ in 10 ms.

The standard (slow) visibility data were analyzed to search for persistent emission associated with
the FRB location. We calibrated the data with the VLA calibration pipeline (version 2020.1) using
3C147 as a flux calibrator. Calibrated visibilities for all five epochs were combined and imaged with
CASA (version 6.1).

We imaged the data with robust weighting of 0.5 and removed baselines shorter than $100 lambda$ to
reduce the effects of RFI. This produced an image with a synthesized beam size of $2″$ by $1″$ with
position angle of $126°$. The sensitivity in the combined image is $6.5 "µJy beam"^(-1)$, which is
consistent with expectations given the usable bandwidth of $400$ MHz.

*VLITE.* The VLA Low-band Ionosphere and Transient Experiment
(VLITE#c(<polisensky_2016_apj>, <clarke_2016_spie>)) is a commensal instrument on the VLA that
records and correlates data from a 64-MHz subband at a central frequency of $tilde 340$ MHz. It
operates on up to 18 antennas during nearly all regular VLA operations. All VLITE data were processed
within the VLITE-Fast GPU-based real-time system to search the incoming voltage stream for dispersed
transients#c(<bethapudi_2021_rnaas>). For imaging purposes, primary calibration and editing for each
day of visibility data were carried out with the automated VLITE processing pipeline. Due to radio
interference from satellites at the upper end of the band, the final usable bandwidth was
38.2 MHz centred at 340.85 MHz. The data were subsequently combined, imaged and self-calibrated
in amplitude and phase using the _Obit_ task _MFImage_#c(<cotton_2008_pasp>). In order to reduce
artefacts from the bright extended radio galaxy M82 located $tilde 1°$ northwest of the target
position, baselines shorter than 4.0 k$lambda$ were removed at this point. The final image was
created in _WSClean_#c(<offringa_2014_mnras>), and corrected for the offset primary beam response of
VLITE. The image has an rms of $320 "µJy beam"^(-1)$, and a beam of $10.1″$ by $3.6″$ at a position
angle of $132°$.

#heading(level: 3)[Archival optical and high energy data]

*Hyper Suprime-Cam.* The field around M81 has been well-observed over the years by multiple
telescopes. We retrieved archival data from the Hyper Suprime-Cam on the 8.1-m Subaru
telescope#c(<miyazaki_2012_spie>) using the SMOKA interface. We chose images with seeing better than
$0.″7$. We processed the $g′$, $r′$, and $i′$ band images with the `hscpipev8.4`
pipeline#c(<bosch_pasj_2018>). The pipeline uses the PanSTARRs catalogue
(PS1#c(<flewelling_2020_apjs>)) as an astrometric and photometric reference. The typical astrometric
residuals were $tilde 50$--$60$ mas, which is the uncertainty we have assumed to tie the optical and
the radio reference frames.

*Gaia.* #gc also appears in the _Gaia_ Early Data Release 3
Catalogue#c(<gaia_2016_aanda>, <gaia_2021_aanda>) with Source ID 1070264274879949184, and position RA
(J2000) $= 9^"h" 57^"m" 54.71402^"s" plus.minus 1.6 "mas"$, Dec (J2000)
$= 68° 49′ 0.7775″ plus.minus 1.7 "mas"$. This position is consistent (within $< 3 sigma$ confidence
level) with the one we have derived from the Hyper Suprime-Cam data. The observed offset allowed us
to estimate the possible systematic uncertainties in the optical image registration error
($15 "mas"$; by adding in quadrature the observed offset between the the _Gaia_ position and the one
we determined, plus the uncertainties on the positions).

*Chandra X-ray Observatory.* Several deep archival X-ray observations are available for the field
around M81 from _XMM_ and _Chandra_. We selected the archival observation with the longest exposure
time that covers the location of FRB 20200120E, a 26 ks _Chandra_ observation (Obs. ID 9540, taken
with ACIS in FAINT mode#c(<garmire_2003_spie>)) to probe for an X-ray source. The data were reduced
using CIAO version 4.12#c(<fruscione_2006_spie>) following standard procedures. As the source was
located about $14′$ off-axis, events were extracted in a large $10″$-radius region centred on the
position of FRB 20200120E. We also extract events from a $60″$-radius region away from the source at a
similar off-axis angle to estimate the background count rate. The X-ray count-rate in the source
extraction region, $4.4 times 10^(-6)$ $"counts s"^(-1) "arcsec"^(-2)$, is consistent with the
background region rate of $3.9 times 10^(-6)$ $"counts s"^(-1) "arcsec"^(-2)$. To place a limit on an
X-ray source at the location of FRB 20200120E we use the Bayesian method of Kraft et
al.#c(<kraft_1991_apj>), which results in a 0.5--10 keV source count rate upper limit of
$1 times 10^(-3)$ $"counts s"^(-1)$ ($3 sigma$). Taking into account the spectral response for the
off-axis location of the source (via an ancillary response file created by the CIAO tool
_specextract_), and assuming a photoelectrically absorbed power-law source spectrum with a spectral
index of $Gamma = 2$ and a hydrogen column density of $N_("H") = 10^21$ $"cm"^(-2)$, this count rate
limit corresponds to a 0.5--10 keV absorbed flux upper limit of $1 times 10^(-14)$
$"erg cm"^(-2) "s"^(-1)$.

*Fermi-LAT.* The Large Area Telescope (LAT) onboard the _Fermi_ satellite provides a uniform
sensitivity survey of the whole sky in the energy range between 100 MeV and 300 GeV. We searched
all of the publicly available catalogues for counterparts up to the latest
published#c(<ballet_2020_arxiv>) release, 4FGL-DR2, with null results. However, even the most
luminous known Galactic globular cluster (Terzan5), whose luminosity is
$(42.4 plus.minus 1.5) times 10^34$ $"erg s"^(-1)$ in the $0.1$--$100$ GeV energy
range#c(<abdo_2010_AandA>), would have a gamma-ray flux of only
$(2.00 plus.minus 0.07) times 10^(-16)$ $"erg cm"^(-2) "s"^(-1)$ at the distance of M81. This is
nearly three orders of magnitude dimmer than the faintest source detected in the 4FGL-DR2 catalogue.

#heading(level: 2)[Analysis]

#heading(level: 3)[Dispersion measure refinement]

To refine the DM for further analysis, we maximised the signal to noise ratio (S/N) of a very narrow
spike in B3#c(<nimmo_2021_arxiv>) (@fig:bursts#text[g]) and find
$"DM" = 87.7527 plus.minus 0.0003$ pc cm^(-3). This value is comparable to, but formally deviates
from $"DM" = 87.818 plus.minus 0.007$ pc cm^(-3) found by Bhardwaj et
al.#c(<bhardwaj_2021_apjl>), where a weighted average of three bursts was used. Possible explanations
for this discrepancy are the lack of short-timescale structure in the CHIME/FRB
bursts#c(<bhardwaj_2021_apjl>), the potential for non-dispersive time-frequency
drifting#c(<hessels_2019_apjl>) or a time-variable DM.

#heading(level: 3)[Milliarcsecond localization of FRB 20200120E]

We imaged both the individual bursts separately, as well as a data set produced by the combination of
all individual burst visibilities. @fig:localisation-maps#text[a-d] display the dirty maps (i.e. the
inverse Fourier Transform of the visibilities without applying any deconvolution, i.e. ‘CLEANing’) of
the bursts that were detectable in the correlated data, using a natural weighting of the data. B1 was
too faint to produce a useful image, and we therefore exclude it from the localisation analysis. B5
was only detected in the lower half of the observed band, where most of the antennas were not
recording (see @tab:stations). We therefore only used data from this part of the band.
@fig:localisation-maps#text[e] shows the dirty map of the combined data of the visibilities from all
bursts. In this map we obtained an emission pattern consistent with the one expected from the dirty
beam (the inverse Fourier Transform of a point-like source), allowing us to unambiguously identify the
position of FRB 20200120E. The observed emission reached a $12 sigma$ confidence level, with the
secondary sidelobes in the fringe pattern being $tilde 66%$ of the peak emission. This provided a
robust localization in the map, as it would require a noise fluctuation of $gt.tilde 7 sigma$ to
produce such peak emission. We also conducted different approaches during the imaging of the data:
different weighting schemes, and selecting different subsets of antennas in the array. The derived
position of FRB 20200120E was robust across all these approaches. @fig:localisation-maps#text[f]
displays the final, ‘CLEANed’, image of the combined bursts.

The final coordinates of FRB 20200120E are RA (J2000) $= 9^"h" 57^"m" 54.69935^"s" plus.minus 1.2 "mas"$,
Dec (J2000) $= 68° 49′ 0.8529″ plus.minus 1.3 "mas"$. We note that the quoted uncertainties reflect
the statistical uncertainties from the measured position of FRB 20200120E ($0.7$ and $0.4$ mas in
RA and DEC, respectively), the uncertainties in the absolute International Celestial Reference Frame
position of the phase calibrator (J0955$+$6903; 0.11 mas), and the systematic uncertainty associated
with the phase-referencing technique#c(<kirsten_2015_aanda>) of $tilde 0.9$ and $1.2$ mas, in RA
and DEC, respectively.

We combined the continuum VLBI data from the three epochs to produce a deep image of the field around
FRB 20200120E to search for persistent emission. No significant sources above a $5 sigma$ confidence
level (with an rms of $10 "µJy beam"^(-1)$) are detected on milliarcsecond scales
(@fig:continuum-images#text[a]). In the VLA data taken at $1.5$ GHz (@fig:continuum-images#text[b]),
we did identify two sources with peak brightness of $110 "µJy beam"^(-1)$ and
$73 "µJy beam"^(-1)$, and offset by $6″$ and $9″$, respectively. The projected density of radio
sources of this brightness is roughly 1 000 to 3 000 per square degree#c(<condon_2012_apj>).
Therefore, we expect between $1$--$3$ sources within $1′$ of FRB 20200120E by chance. The closer of
the two nearby radio sources is within $0.2″$ of a PS1 source with $i = 21.3 "mag"$. This host galaxy
has a photometric redshift in the PS1 STRM catalogue#c(<beck_2021_mnras>) of $0.67 plus.minus 0.2$, so
it is most likely a background galaxy. The other identified radio source has no PS1 counterpart. We
note that neither of these two sources exhibit significant compact emission on milliarcsecond scales.

#heading(level: 3)[#gc and chance coincidence probability]

We measured the full-width at half maximum (FWHM; “seeing”) of the coadded $i′$, $r′$, and $g′$
images of #gc to be $0.″63$, $0.″57$, and $0.″62$, respectively, using profile fits to bright,
isolated stars. The brightness distribution of #gc has an FWHM of $0.″77$, $0.″70$, and $0.″75$ in the
same three images. Subtracting the FWHMs of the isolated stars in quadrature, we estimate that the
intrinsic FWHM of #gc is about $0.″42$, corresponding to about 7.4 pc at a distance of 3.63 Mpc.

To estimate the probability of chance coincidence#c(<bloom_2002_aj>) for an M81 globular cluster in
the FRB localisation region, we use a circular localisation region with a radius ($R$) = max{2$R_("eff")$ of #gc, maximum
seeing-limited size of #gc in the Hyper Suprime-images} = $0.″77$. Perelmuter & Racine#c(<perelmuter_1995_aj_109>) parameterized the projected areal number
density ($rho_("GC") / "arcmin"^2$) of the M81 globular clusters as a function of their angular offset
from M81 ($r$, in arcmin) as,
$log_10 (rho_("GC")) = -2.07 times log_10 (r) + 0.82 plus.minus 0.05$, for
$0 lt.eq log_10 (r) lt.eq 1.4$. At the offset of FRB 20200120E from M81 ($19.6′$),
$rho_("GC") = 0.014 "arcmin"^(-2) approx 3.8 times 10^(-6) "arcsec"^(-2)$. Assuming a Poisson
distribution of M81 globular clusters at $r = 19.6′$, the probability of finding at least one globular
cluster by chance within a radius $R$ is given by
$P_("cc") = 1 - exp(-pi R^2 rho_("GC")) approx 7 times 10^(-6)$. A more conservative estimate of
$P_("cc")$ can be derived by assuming that all the predicted $300 plus.minus 100$ M81 globular
clusters#c(<harris2013>) are uniformly distributed within the angular area of radius $= 19.6′$ so that
$rho_("GC") = 4.6$--$9.2 times 10^(-5)$, and consequently $P_("cc") = 0.85$--$1.7 times 10^(-4)$.
From such a very low $P_("cc")$ value, we conclude that the association of FRB 20200120E and #gc is
robust.

#heading(level: 3)[Modelling of #gc]

To estimate important physical properties of #gc, such as its stellar mass, metallicity, stellar
population age and V-band extinction, we used the _Prospector_ code#c(<Leja2017>, <prospect2019>) for
stellar population inference. We modelled the SDSS photometry (@filter:maggies, from the SDSS DR12
catalogue#c(<aaa2015>)) of #gc and fit a five-parameter (@tab:sfhmodel) ‘delayed-tau’ model for the
star formation rate $"SFR"(t) prop t exp(-t / tau)$, where $t$ is the time since the formation epoch
of the galaxy, and $tau$ is the characteristic decay time of the star-formation history of
#gc#c(<simha2014>, <carnall2019ApJ>). As we are modelling a globular cluster, we did not include
nebular line emission but only enabled a dust emission model#c(<draine2007>) in our fitting. The
best-fit spectral energy distribution (SED) profile of #gc is shown in @fig:sed. _Prospector_ also
enables Markov Chain Monte Carlo (MCMC) sampling of the posterior to estimate uncertainty in the
best-fit values of the physical properties of #gc. We show the corner plot of the MCMC-analysis in
@fig:mcmc and list the results in @tab:gc-properties. Using the relation#c(<bertelli1994>),
$["Fe/H"] = 1.024 times log(Z/Z_⊙)$, we estimate the [Fe/H] of #gc $= -1.83_(-0.87)^(+0.86)$,
which is in good agreement with earlier estimates#c(<ma_2007_pasp>, <perelmuter_1995_aj_110>). We can
get an estimate of the velocity dispersion ($sigma_("r")$) of #gc using the virial theorem:
$sigma_("r") tilde sqrt(2 G M / (3 R_("eff")))$, where G is the gravitational constant. Using the M
and $R_("eff")$ values of #gc from @tab:gc-properties, we estimate
$sigma_("r") tilde 22 "km s"^(-1)$.

#heading(level: 3)[Possible MIC-models for the formation of FRB 20200120E]

The most likely of the MIC-models is that of a merging WD-WD system as those dominate the cores of
globular clusters#c(<kremer_2021_arxiv>), while a NS-NS progenitor system is less
probable#c(<ye_2020_apjl>). A typical globular cluster with a total mass of
$tilde 2 times 10^5 M_⊙$ can host $10 - 20$ MSPs formed via AIC or MIC#c(<ye_2019_apj>). At birth,
such NSs would be extreme objects with high rotation rates and strong magnetic fields, potentially
capable or generating FRBs. We note that the metallicity limit ($log\["Fe/H"\] > -0.6$) set for the
formation of young NSs in globular clusters#c(<boyles_2011_apj>) is much higher than the metallicity
that we estimate for #gc ($log\["Fe/H"\] = -1.83$, @tab:gc-properties). Nevertheless, non-recycled
pulsars have been found towards some globular
clusters#c(<hessels_2015_aska>, <lyne_1996_apjl>, <boyles_2011_apj>). These young pulsars are formed
at a comparable rate to MSPs in globular clusters, but they have much shorter active lifetimes (Myr
versus Gyr).

#heading(level: 3)[Constraints on the Galactic halo DM and RM]

Since FRB 20200120E is extragalactic, its dispersive delay is probing the full extent of the Milky Way
ISM ($"DM"_("ISM")^("MW")$) and halo ($"DM"_("Halo")^("MW")$) along this line of sight. There are also
extragalactic contributions from the intergalactic medium $"DM"_("IGM")$ and the host galaxy
($"DM"_("M81")$), leading to the total observed
$"DM" = "DM"_("ISM")^("MW") + "DM"_("Halo")^("MW") + "DM"_("IGM") + "DM"_("M81")$. The intergalactic
medium between the Milky Way and M81 contributes on the order#c(<macquart_2020_natur>) of
$"DM"_("IGM") tilde 1$ pc cm^(-3). To estimate $"DM"_("M81")$, we only consider the contribution from
the halo of M81, as both the M81 disk and the globular cluster make negligible contributions to the
measured DM. The M81 halo DM contribution is estimated#c(<bhardwaj_2021_apjl>) to be $tilde 15$--$50$
pc cm^(-3) depending on the choice of a halo density profile and baryon fraction in the M81 halo.
For the Galactic contribution, models of the Milky Way ISM predict
$"DM"_("ISM")^("MW") = 30$--$40$ pc cm^(-3) in this direction#c(<cordes_2002_arxiv>, <yao_2017_apj>)
(with a shallow spacial gradient in the region, @fig:dm_rm_map). Using these estimates, we limit the
Milky Way halo contribution to the FRB sight-line, which is poorly constrained by current
observations#c(<keating_2020_mnras>), to
$"DM"_("Halo")^("MW") = "DM" - "DM"_("ISM")^("MW") - "DM"_("IGM") - "DM"_("M81") lt.tilde 32$--$42$
pc cm^(-3). This is well in line with the models of Yamasaki & Inoue#c(<yamasaki_2020_apj>), which
predict $"DM"_("Halo")^("MW") = 10$--$30$ pc cm^(-3), but lower than predicted in some other
models#c(<prochaska_2019_mnras>).

Similar considerations are also applicable for the rotation measure#c(<bhardwaj_2021_apjl>)
$"RM" = -36.9 "rad m"^(-2)$ as determined in the companion paper by Nimmo et al. (submitted). The
Galactic contribution#c(<hutschenreuter_2021_arxiv>) along the line of sight to FRB 20200120E is
$"RM" = -17 plus.minus 4 "rad m"^(-2)$ (@fig:dm_rm_map). The contribution of the IGM is most likely
minor, leaving only the MW halo, the M81 halo and the local environment of FRB 20200120E as
contributing sources. The RMs of the MW- and M81-halo are likely small ($|"RM"| < 20 "rad m"^(-2)$),
constraining $"RM"_("Local")$ to the range $[+20, -60] "rad m"^(-2)$. This is comparable to earlier
results#c(<chime_2019_apjl>) for FRB 20180916B ($"RM" = -115 "rad m"^(-2)$) but three orders of
magnitude lower than the (highly variable) RM of FRB 20121102A#c(<michilli_2018_natur>). This
indicates that models of FRB sources do not necessarily require extreme magneto-ionic environments,
unless the magnetic fields along the line of sight to both FRB 20200120E and FRB 20180916B are
strongly tangled, such that they result in a low net RM. More likely though, FRB 20121102A resides in
a very different environment giving rise to its observed properties.

// [figvision] imgs/dm_rm_combined_ymw16_hutschenreuter_with_names.png
// Panel a: This plot shows the dispersion measure (DM) contribution from the Galactic disk according to the
// YMW16 model as a green gradient background, with a colorbar ranging from 10 to 100 pc cm^-3. The DM of FRB
// 20200120E is marked by a dark green pentagon. White circles represent known pulsars from the ATNF Pulsar
// Catalogue, labeled with their names (PSR J1137+7528, PSR J0814+7429, PSR J0700+6418, PSR J0750+57, PSR
// J0827+53, PSR J1110+58, PSR J1115+5030). The axes show declination (50-80 degrees) and right ascension (7-12
// hours). The trend shows a decreasing DM from top-left to bottom-right. Panel b: This plot shows the physical
// Galactic Faraday depth as a color-mapped background, ranging from -60 to 60 rad m^-2, with red and blue hues
// indicating positive and negative values, respectively. The FRB 20200120E is marked by a grey pentagon, and
// white circles represent the same pulsars as in panel a. The axes show declination (50-80 degrees) and right
// ascension (7-12 hours). The trend shows a patchy distribution of Faraday depth values, with FRB 20200120E
// located near a region of relatively low values.
#figure(
  image("imgs/dm_rm_combined_ymw16_hutschenreuter_with_names.png", width: 100%),
  caption: [
    *Dispersion measure (DM) and rotation measure (RM) maps around FRB 20200120E:* Panel *a* shows
    the expected Galactic DM contribution (background) according to the YMW16 model (disk
    contribution only#c(<yao_2017_apj>)), the DM of FRB 20200120E (pentagon) and the DMs of known
    pulsars from the ATNF Pulsar Catalogue in this field (circles#c(<hobbs_2004_iaus>)). Panel *b*
    shows the physical Galactic Faraday depth $phi_("g")$ (background#c(<hutschenreuter_2021_arxiv>)),
    the RM of FRB 20200120E (pentagon) and galactic pulsars with a known RM (circles). We assume that
    the RM#c(<bhardwaj_2021_apjl>) of FRB 20200120E is $-36.9 "rad m"^(-2)$ (also see Nimmo et al.
    (submitted) for details).
  ],
  placement: top, scope: "parent",
) <fig:dm_rm_map>

#figure(
  text(table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    inset: 3pt,
    table.header([Property], [Value], [Reference]),
    table.hline(),
    [Metallicity $log[Z / Z_⊙]$], [$-1.74_(-0.90)^(+0.80)$], [this work],
    [Metallicity [Fe/H]], [$-1.83_(-0.87)^(+0.86)$], [this work],
    [Stellar mass $log[M / M_⊙]$], [$5.77_(-0.22)^(+0.19)$], [this work],
    [Effective radius ($R_("eff")$/pc)], [3.7], [this work],
    [Age (Gyr)], [$9.13_(-4.18)^(+3.27)$], [this work],
    [$(u - r)_0^"a"$ (AB mag)], [1.96(2)], [#c(<alam_2015_apjs>)],
    [E($V - B$)#super[b]], [$0.2_(-0.1)^(+0.1)$], [this work],
    [$sigma_("r")$ (km s$"s"^(-1)$)], [22], [this work],
    [Absolute r-band mag. (AB)], [$-8.4$], [--],
    [Luminosity distance (Mpc)], [3.6], [#c(<karachentsev_2005_aj>)],
    table.hline(),
    table.cell(colspan: 3, align: left)[
      #super[b] Milky Way extinction is corrected using a reddening map#c(<sfd1998>). \
      #super[c] Using $R_v = 3.1$.
    ],
  ), size: 7.5pt),
  caption: [Notable properties of #gc.],
  kind: table, placement: top, scope: "parent",
) <tab:gc-properties>

#figure(
  text(table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: 3pt,
    table.header(
      [], [], [Effective], [Flux density],
      [Instrument], [Filter], [Wavelength [Å]], [[maggie]#super[a]],
    ),
    table.hline(),
    [SDSS], [u], [3546], [$2.92 times 10^(-9)$],
    [], [$g$], [4670], [$1.05 times 10^(-8)$],
    [], [$r$], [6156], [$1.77 times 10^(-8)$],
    [], [$i$], [7472], [$2.04 times 10^(-8)$],
    [], [$z$], [8917], [$2.33 times 10^(-8)$],
    table.hline(),
    table.cell(colspan: 4, align: left)[
      #super[a] The flux densities are assigned a 20% fractional uncertainty. Note that 1 maggie
      is defined as the flux density in Jansky divided by 3631.
    ],
  ), size: 7.5pt),
  caption: [Broadband SDSS filters used to model the SED of #gc.],
  kind: table, placement: top, scope: "parent",
) <filter:maggies>

#figure(
  text(table(
    columns: (auto, auto, auto),
    align: (left, left, left),
    inset: 3pt,
    table.header([Parameter], [Description], [Prior]),
    table.hline(),
    [$log(M / M_⊙)$], [total stellar mass formed], [uniform: min=3, max=7],
    [$log(Z / Z_⊙)$], [stellar metallicity], [top-hat: min=-3.5, max=0],
    [dust2], [diffuse V-band dust optical depth], [top-hat: min=0.0, max=2.0],
    [$t_("age")$], [age of #gc], [top-hat: min=0.1, max=13.8],
    [$tau$], [e-folding time of the SFH], [uniform: min=0.1, max=30],
    table.hline(),
  ), size: 7.5pt),
  caption: [Free parameters and their associated priors for the _Prospector_ ‘delayed tau’ model.],
  kind: table, placement: top, scope: "parent",
) <tab:sfhmodel>

// [figvision] imgs/M81R_model_SED_with_uncertainty.png
// Panel a: This is a plot showing the spectral energy distribution. The x-axis represents wavelength in
// Angstroms, ranging from 3000 to 10000. The y-axis represents flux density, with values from 10^-10 to 10^-8,
// multiplied by 3631 Jy. The plot features a blue line for the model spectrum, with a shaded blue region around
// it, and blue squares for model photometry. Red symbols with error bars represent observed photometry. Five
// grey curves show transmission for SDSS-u, g, r, i, z filters. The model spectrum increases with wavelength,
// matching observed photometry within error bars.
#figure(
  image("imgs/M81R_model_SED_with_uncertainty.png", width: 95%),
  caption: [
    *Modelling the SED of #gc.* The Milky Way extinction corrected flux densities of #gc in different
    wavelength bands are plotted along with the best fit `Prospector` model spectrum. To assess the
    quality of the `Prospector` model, the modelled and actual photometric data are also shown. The
    best fit model profile is used to estimate the physical properties of #gc stated in
    @tab:gc-properties. Finally, the shaded region around the best fitted profile is the one-$sigma$
    uncertainty region.
  ],
  placement: top, scope: "parent",
) <fig:sed>

// [figvision] imgs/M81R_model_MCMC_new.png
// Panel a: This is a histogram plot of the posterior probability distribution for log(mass). The x-axis ranges
// from 4.4 to 6.0 and has units of log(mass). There is one series, a grey histogram. Above the histogram, the
// median of the parameter posterior is printed as log(mass) = 5.77, with one-error bars +0.19 and -0.22. The
// trend shows a peak in the posterior probability distribution around log(mass) = 5.7. Panel b: This is a
// histogram plot of the posterior probability distribution for logzsol. The x-axis ranges from -3.2 to -0.8 and
// has units of logzsol. There is one series, a grey histogram. Above the histogram, the median of the parameter
// posterior is printed as logzsol = -1.74, with one-error bars +0.89 and -0.90. The trend shows a peak in the
// posterior probability distribution around logzsol = -1.7. Panel c: This is a histogram plot of the posterior
// probability distribution for dust2. The x-axis ranges from 0.2 to 0.8 and has units of dust2. There is one
// series, a grey histogram. Above the histogram, the median of the parameter posterior is printed as dust2 =
// 0.59, with one-error bars +0.28 and -0.31. The trend shows a relatively flat posterior probability
// distribution. Panel d: This is a histogram plot of the posterior probability distribution for tage. The x-axis
// ranges from 3 to 12 and has units of tage. There is one series, a grey histogram. Above the histogram, the
// median of the parameter posterior is printed as tage = 9.13, with one-error bars +3.27 and -4.18. The trend
// shows a peak in the posterior probability distribution around tage = 9. Panel e: This is a histogram plot of
// the posterior probability distribution for log(tau). The x-axis ranges from -0.5 to 1.0 and has units of
// log(tau). There is one series, a grey histogram. Above the histogram, the median of the parameter posterior is
// printed as log(tau) = -0.37, with one-error bars +0.54 and -0.43. The trend shows a decreasing posterior
// probability distribution. Panel f: This is a contour plot showing the correlation between logzsol and
// log(mass). The x-axis ranges from 4.4 to 6.0 and has units of log(mass), and the y-axis ranges from -3.2 to
// -0.8 and has units of logzsol. There are multiple grey contour levels. The trend shows a negative correlation
// between logzsol and log(mass). Panel g: This is a contour plot showing the correlation between dust2 and
// log(mass). The x-axis ranges from 4.4 to 6.0 and has units of log(mass), and the y-axis ranges from 0.2 to 0.8
// and has units of dust2. There are multiple grey contour levels. The trend shows no clear correlation between
// dust2 and log(mass). Panel h: This is a contour plot showing the correlation between tage and log(mass). The
// x-axis ranges from 4.4 to 6.0 and has units of log(mass), and the y-axis ranges from 3 to 12 and has units of
// tage. There are multiple grey contour levels. The trend shows a positive correlation between tage and
// log(mass). Panel i: This is a contour plot showing the correlation between log(tau) and log(mass). The x-axis
// ranges from 4.4 to 6.0 and has units of log(mass), and the y-axis ranges from -0.5 to 1.0 and has units of
// log(tau). There are multiple grey contour levels. The trend shows a weak positive correlation between log(tau)
// and log(mass). Panel j: This is a contour plot showing the correlation between dust2 and logzsol. The x-axis
// ranges from -3.2 to -0.8 and has units of logzsol, and the y-axis ranges from 0.2 to 0.8 and has units of
// dust2. There are multiple grey contour levels. The trend
#figure(
  image("imgs/M81R_model_MCMC_new.png", width: 95%),
  caption: [
    *MCMC simulation corner plot*, where the posterior probability distributions are shown for each
    of the five model parameters along the diagonal panels, and the correlations between model
    parameter posteriors are shown along the columns. Above each probability distribution, the median
    of the parameter posterior is printed, along with the one-$sigma$ error bars.
  ],
  placement: top, scope: "parent",
) <fig:mcmc>
