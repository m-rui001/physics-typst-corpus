#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: (..n) => if n.pos().first() <= 2 { "" } else { str(n.pos().first() - 2) }, paper: "a4", margin: (left: 2.94cm, right: 2.94cm, top: 3.00cm, bottom: 4.18cm))
#set page(footer: context {
  let n = counter(page).get().first()
  if n > 2 { align(center)[#text(10.9pt)[– #(n - 2) –]] }
})
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.9em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.71em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#align(left)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0em)
  #grid(columns: (1fr, 1fr), [
    Prepared for submission to JHEP
  ], align(right)[
    IFT-UAM/CSIC-24-140, YITP-SB-2024-24, \
    IPPP/24/64
  ])
  #v(7.4em)
  #set text(hyphenate: false)
  #text(17.2pt, weight: "bold")[NuFit-6.0: Updated global analysis of three-flavor \
  neutrino oscillations]   #v(4.2em)
  #text(10.5pt)[Ivan Esteban#super[a,b], M. C. Gonzalez-Garcia#super[c,d,e], Michele Maltoni#super[f], Ivan Martinez-Soler#super[g], Joao Paulo Pinheiro#super[c], Thomas Schwetz#super[h]]
  #v(1.0em)
  #set par(leading: 0.72em, spacing: 0.25em, hanging-indent: 0.8em)
  #text(7.5pt)[
    #super[a] Department of Physics, University of the Basque Country UPV/EHU, PO Box 644, 48080 Bilbao, Spain \
    #super[b] EHU Quantum Center, University of the Basque Country UPV/EHU, PO Box 644, 48080 Bilbao, Spain \
    #super[c] Departament de Física Quàntica i Astrofísica and Institut de Ciencies del Cosmos, Universitat de Barcelona, Diagonal 647, E-08028 Barcelona, Spain \
    #super[d] Institució Catalana de Recerca i Estudis Avançats (ICREA), Pg. Lluis Companys 23, 08010 Barcelona, Spain \
    #super[e] C.N. Yang Institute for Theoretical Physics, State University of New York at Stony Brook, Stony Brook, NY 11794-3840, USA \
    #super[f] Instituto de Física Teórica UAM/CSIC, Calle de Nicolás Cabrera 13–15, Universidad Autónoma de Madrid, Cantoblanco, E-28049 Madrid, Spain \
    #super[g] Institute for Particle Physics Phenomenology, Durham University, South Road, DH1 3LE, Durham, UK \
    #super[h] Institut für Astroteilchenphysik, Karlsruher Institut für Technologie (KIT), 76021 Karlsruhe, Germany
  ]
  #v(1.2em)
  #set par(hanging-indent: 0em, justify: false)
  #text(10.9pt)[E-mail: ivan.esteban\@ehu.eus, concha.gonzalez-garcia\@stonybrook.edu, michele.maltoni\@csic.es, ivan.j.martinez-soler\@durham.ac.uk, joaopaulo.pinheiro\@fqa.ub.edu, schwetz\@kit.edu]

]
#pagebreak()

#block[
  #set par(first-line-indent: 0em, leading: 0.72em, justify: true)
  #text(10.9pt)[
    *Abstract:* We present an updated global analysis of neutrino oscillation data as of September 2024. The parameters $theta_12$, $theta_13$, $Delta m^2_21$, and $|Delta m^2_(3 ell)|$ ($ell = 1, 2$) are well-determined with relative precision at $3 sigma$ of about 13%, 8%, 15%, and 6%, respectively. The third mixing angle $theta_23$ still suffers from the octant ambiguity, with no clear indication of whether it is larger or smaller than $45 degree$. The determination of the leptonic CP phase $delta_"CP"$ depends on the neutrino mass ordering: for normal ordering the global fit is consistent with CP conservation within $1 sigma$, whereas for inverted ordering CP-violating values of $delta_"CP"$ around $270 degree$ are favored against CP conservation at more than $3.6 sigma$. While the present data has in principle $2.5$--$3 sigma$ sensitivity to the neutrino mass ordering, there are different tendencies in the global data that reduce the discrimination power: T2K and NOvA appearance data individually favor normal ordering, but they are more consistent with each other for inverted ordering. Conversely, the joint determination of $|Delta m^2_(3 ell)|$ from global disappearance data prefers normal ordering. Altogether, the global fit including long-baseline, reactor and IceCube atmospheric data results into an almost equally good fit for both orderings. Only when the $chi^2$ table for atmospheric neutrino data from Super-Kamiokande is added to our $chi^2$, the global fit prefers normal ordering with $Delta chi^2 = 6.1$. We provide also updated ranges and correlations for the effective parameters sensitive to the absolute neutrino mass from $beta$-decay, neutrinoless double-beta decay, and cosmology.
  ]
]
#v(0.9em)
#text(10.9pt)[*Keywords:* neutrino oscillations, solar and atmospheric neutrinos]

#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em, leading: 0.65em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 1.0em, it) } else { it }
  }
  #outline(title: none, depth: 2)
]

= Introduction <introduction>

The global analysis of neutrino oscillation data provides us with the unique comprehensive description of the non-trivial flavor structure of leptons. Although in the last years some efforts are being put forward by the experimental collaborations for combined analysis of their results @T2K:2024wfn, @T2K:nu24 @NOvA:nu24, the main task still falls on the work of phenomenological groups @Esteban:2020cvm @deSalas:2020pgw @Capozzi:2018ubv. Over the last decade these global analyses have provided consistent results with very good quantitative agreement on the dominant effects. In a nutshell, it is found that mass-driven oscillations between three neutrino states of different mass and three different mixing angles account for the vast majority of the results. And, when redundant, the results from different experiments on the dominant effects in this picture are statistically compatible.

In addition, three-flavor oscillation effects which are subdominant or quantitatively small in present experiments include the mass ordering (MO) of the three states, the possible maximality of one of the mixing angles ($theta_23$ in the standard parametrization), and the amount of leptonic CP violation. They remain open questions in the present experimental landscape and constitute the main goal of the upcoming generation of experiments @JUNO:2024jaw @DUNE:2020jqi @Hyper-Kamiokande:2018ofw. The phenomenological analysis finds minor differences in these subdominant effects, and their statistical significance has been varying with time as the running experiments accumulate more statistics and update their analyses. This, in fact, is one of the main motivations for the redundancy of the global phenomenological analysis, providing unbiased tests for the consistency over time of the emerging picture.

In this effort, this work contains the latest analysis within the NuFIT program, NuFIT~6.0, which incorporates a number of changes and updates since our last published analysis in 2020 @Esteban:2020cvm.  In the solar neutrino sector, the new generation of Standard Solar Models @B23Fluxes are now used for the predictions, and the full day-night spectrum from the phase-IV of Super-Kamiokande @Super-Kamiokande:2023jbt together with the final spectra from Borexino phases-II @Borexino:2017rsf and III @BOREXINO:2022abl are included. For the long baseline (LBL) reactor data, we have updated the reactor antineutrino fluxes used for the predictions to the latest Daya-Bay measurements @DayaBay:2021dqj, and results from SNO+ @SNO:2024wzq @SNO-:nu24 @SNO-poster:nu24 are included in the global analysis for the first time. From reactors at medium baseline (MBL), we include the most up-to-date Daya-Bay spectral data @DayaBay:2022orm. Updates in the LBL accelerator analysis include incorporating the latest samples and simulation updates of T2K @T2K:nu24, and the doubled statistics of NOvA neutrino samples @NOvA:nu24. A new independent analysis of atmospheric neutrinos from 3 years of IceCube/DeepCore data @IceCube:2019dyb @IceCube:2019dqi has been incorporated. Finally, the effect of the updated $chi^2$ maps provided by the collaborations for the analysis of the latest atmospheric neutrino samples in Super-Kamiokande @IceCube:2024xjj @IC:data2024 and IceCube/DeepCore @IceCube:2024xjj @IC:data2024 is accounted for.

The outline of the paper is as follows. In @sec:global24 we present the results of our global analysis, providing best-fit values and 1-dimensional and 2-dimensional confidence regions for the 6 oscillation parameters, and we discuss the global determination of leptonic CP violation. In @sec:atm we discuss in some detail the various tendencies in the global data, focusing on experiments sensitive to the large mass splitting $Delta m^2_(3 ell)$ ($ell = 1, 2$). In @sec:lbl we discuss the compatibility among T2K and NOvA appearance data, whereas in @sec:reacatm we consider the global combination of disappearance data (which includes accelerator, reactor and atmospheric neutrinos), presenting a detailed study of the compatibility among different combinations of datasets. In @sec:MO we discuss in detail the sensitivity to the neutrino mass ordering in terms of a proper hypothesis test. @sec:solar focuses on the "solar sector" governed by $Delta m^2_(21)$, especially in light of the latest developments in solar models. In @sec:absmass we provide the relevant correlations between absolute neutrino mass observables. We summarize our results in @sec:conclu, and provide a list of all the used data in @sec:conclu.    In @sec:app_IC we describe our analysis of IceCube data, and in @sec:app-T we provide more details on the mass ordering test.

= Global analysis <sec:global24>

We start by presenting the results of the NuFIT~6.0 global fit. Parametrization conventions and technical details on our global analysis can be found in @Esteban:2018azc. In particular, we use the standard parametrization of the $3 times 3$ unitary leptonic mixing matrix @Maki:1962mu @Kobayashi:1973fv.

$ U = mat(1, 0, 0; 0, c_23, s_23; 0, -s_23, c_23)
    dot mat(c_13, 0, s_13 e^(-i delta_"CP"); 0, 1, 0; -s_13 e^(i delta_"CP"), 0, c_13)
    dot mat(c_12, s_12, 0; -s_12, c_12, 0; 0, 0, 1)
    dot cal(P) $
<eq:U3m>

where $c_(i j) equiv cos theta_(i j)$ and $s_(i j) equiv sin theta_(i j)$, with angles $theta_(i j) in [0, pi\/2]$ and phase $delta_"CP" in [0, 2 pi]$, such that $delta_"CP" != 0, pi$ implies CP violation in neutrino oscillations in vacuum @Cabibbo:1977nk @Bilenky:1980cx @Barger:1980jm. Here $cal(P) = I$ for Dirac neutrinos and $cal(P) = mat(e^(i alpha_1), 0, 0; 0, e^(i alpha_2), 0; 0, 0, 1)$ for Majorana neutrinos, a matrix that plays no role in neutrino oscillations @Bilenky:1980cx @Langacker:1986jv. In this convention, there are two non-equivalent orderings for the neutrino masses, namely normal ordering (NO) with $m_1 < m_2 < m_3$, and inverted ordering (IO) with $m_3 < m_1 < m_2$. In particular, in what follows we use the definition

$ Delta m^2_(3 ell) quad "with" quad cases(
  ell_("er") = 1 & "for" Delta m^2_(3 ell) > 0 ": normal ordering (NO)",
  ell_("er") = 2 & "for" Delta m^2_(3 ell) < 0 ": inverted ordering (IO)."
) $

The analysis includes all data available up to September 2024 which, for convenience, we list in @sec:appendix-data24 with the corresponding references. As is customary in the NuFIT analysis since v4.0 @Esteban:2018azc, we show two versions of the analysis. These versions differ in the inclusion of atmospheric neutrino results, for which there is not enough information for us to make an independent analysis comparable to that performed by the collaborations. In NuFIT~6.0, this is the case for the atmospheric neutrino data from Super-Kamiokande phases 1-5 (SK-atm) and from the latest 9.3-year result from IceCube/DeepCore (IC24). For those, we use their tabulated $chi^2$ maps provided in @SKatm:data2024 and @IC:data2024, respectively, which we can combine with our global analysis for the solar, reactor and LBL experiments. We note that for IceCube/DeepCore we have performed an independent analysis of their previous 3-year atmospheric neutrino data sample @IceCube:2019dyb @IceCube:2019dqi, which we do include in the version of the analysis without tabulated $chi^2$ maps. In what follows, we refer as \<\<IC19 w/o SK-atm\>\> to our independent analysis variant without tabulated $chi^2$ maps, and as \<\<IC24 with SK-atm\>\> to the comprehensive analysis variant that includes the tabulated SK-atm and IC24 $chi^2$ maps instead of our 3-year IceCube/DeepCore analysis.

A selection of the results of our global fit are displayed in @fig:chisq-glob24 (one-dimensional $Delta chi^2$ curves) and @fig:region-glob24 (two-dimensional projections of confidence regions). In @fig:region-glob24 we give the best-fit values as well as $1 sigma$ and $3 sigma$ confidence intervals for the oscillation parameters in both mass orderings, relative to the local best-fit points in each ordering. Additional figures and tables corresponding to this global analysis can be found in the NuFIT webpage @nufit.

// [figvision] imgs/fig-chisq-glob.png - 3x2 Delta chi^2 projections (NuFIT 6.0).
// Legend: solid red NO / solid blue IO (IC19 w/o SK-atm); dashed red/blue
// (IC24 with SK-atm).
// Top-left sin^2 theta_12 (0.2-0.4): minima near 0.307; dashed blue minimum
//   raised to Delta chi^2 ~7.5.
// Top-right Delta m^2_21 (6.5-8.5)e-5 eV^2: minima near 7.5, dashed blue ~6.5.
// Mid-left sin^2 theta_23 (0.4-0.65): NO minimum at 0.45 with a local minimum
//   near 0.51 (Delta chi^2 ~5 solid); IO double minimum at 0.45 and 0.57.
// Mid-right Delta m^2_32/31 ([-2.6,-2.3] and [2.4,2.6])e-3 eV^2: IO at -2.5,
//   NO at +2.5, vertical dashed reference lines at +/-2.45.
// Bottom-left sin^2 theta_13 (0.018-0.026): minimum at 0.022.
// Bottom-right delta_CP (0-360 deg): NO minimum at 180, IO minima near 90/270.
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

#figure(placement: top, image("imgs/fig-chisq-glob.png", width: 86%), caption: [Global $3 nu$ oscillation analysis. We show $Delta chi^2$ profiles minimized with respect to all undisplayed parameters. The red (blue) curves correspond to Normal (Inverted) Ordering. Solid and dashed curves correspond to the two variants of the analysis as described in the labels (notice that in the upper two panels the red-dashed and blue-solid lines almost completely overlap).],) <fig:chisq-glob24>

// [figvision] imgs/fig-region-glob.png - 3x2 global allowed regions (NuFIT 6.0).
// Top row: Delta m^2_31 vs Delta m^2_32 for IO (left) and NO (right), nested
//   1sigma..3sigma contours in cyan, magenta, blue, pink, red and black; star and
//   triangle best-fit markers; dashed horizontal separation at |Delta m^2| ~2.45.
// Middle row: delta_CP vs sin^2 theta_23 (0.3-0.7): IO one elongated lobe near
//   delta ~270 with sin^2 theta_23 ~0.55; NO a multi-lobe structure at 180 and
//   270 spanning sin^2 theta_23 0.45-0.57.
// Bottom row: Delta m^2_21 vs sin^2 theta_12 (ellipses near 7.5 and 0.30) and vs
//   sin^2 theta_13 (near 0.022); same colour coding for the two analysis variants.
#figure(placement: top, image("imgs/fig-region-glob.png", width: 81%), caption: [Global $3 nu$ oscillation analysis. Each panel shows the two-dimensional projection of the allowed six-dimensional region after minimization with respect to the undisplayed parameters. The regions in the four lower panels are obtained from $Delta chi^2$ minimized with respect to the mass ordering. The different contours correspond to $1 sigma$, 90\%, $2 sigma$, 99\%, $3 sigma$ CL (2 dof). Colored regions (black contours) correspond to the variant with IC19 and without SK-atm (with IC24 and with SK-atm).],) <fig:region-glob24>

#block[
]

With these results, we obtain the following $3 sigma$ relative precision of each parameter $x$, defined as $2 ( x^"up" - x^"low" ) \/ ( x^"up" + x^"low" )$, where $x^"up"$ ($x^"low"$) is the upper (lower) bound on $x$ at the $3 sigma$ level:

$ theta_12 &: 13 \%, quad theta_13 &: cases("NO" & 8.1 \%, "IO" & 7.8 \%), quad theta_23 &: cases("NO" & 21 \%, "IO" & 20 \%), \
  Delta m^2_(21) &: 15 \%, quad abs(Delta m^2_(3 ell)) &: cases("NO" & 5.6 \%, "IO" & 5.8 \%), quad delta_"CP" &: cases("NO" & 100 \%, "IO" & 54 \%) $
<eq:precision24>

where the numbers between brackets show the impact of including IC24 and SK-atm. We note that given the non-Gaussianity of $Delta chi^2 (delta_"CP")$, the above estimated precision for $delta_"CP"$ can only be taken as indicative, in particular for NO.

Altogether, we derive the following $3 sigma$ ranges on the magnitude of the elements of the leptonic mixing matrix (see @GonzalezGarcia:2003qf for details on how we derive the ranges and their correlations):

$ |U|_(3 sigma)^"IC19 w/o SK-atm" &= mat(0.801 → 0.842, 0.519 → 0.580, 0.142 → 0.155;
    0.248 → 0.505, 0.473 → 0.682, 0.649 → 0.764;
    0.270 → 0.521, 0.483 → 0.690, 0.628 → 0.746) \
  |U|_(3 sigma)^"IC24 with SK-atm" &= mat(0.801 → 0.842, 0.519 → 0.580, 0.142 → 0.155;
    0.252 → 0.501, 0.496 → 0.680, 0.652 → 0.756;
    0.276 → 0.518, 0.485 → 0.673, 0.637 → 0.743) $
<eq:umatrix24>

#figure(cetz.canvas({
  import cetz.draw: *
  let w = 6.2
  let h = 4.6
  let gap = 1.25
  let fL = (x, y) => ((x - 0.030) / 0.007 * w, y / 16.0 * h)
  let fR = (x, y) => (gap + w + (x + 0.04) / 0.08 * w, y / 16.0 * h)
  let gcol = rgb(184,184,184)
  let gst = (paint: gcol, thickness: .4pt)
  let ast = (paint: black, thickness: .8pt)
  let crv = (f, pts, col, dash) => line(..pts.chunks(2).map(p => f(p.at(0), p.at(1))), stroke: (paint: col, thickness: .9pt, dash: dash))
  let tickx = (f, x, ybot, len) => line(f(x, ybot), f(x, ybot + (if ybot == 0 { len } else { -len })), stroke: ast)
  let ticky = (f, x0, x1, y, len, right) => line(if right { (f(x1, y).at(0) - len, f(x1, y).at(1)) } else { f(x0, y) }, if right { f(x1, y) } else { (f(x0, y).at(0) + len, f(x0, y).at(1)) }, stroke: ast)
  let cNO19 = (0.03115,16.00,0.03121,15.16,0.03121,15.16,0.03133,13.52,0.03133,13.52,0.03145,11.97,0.03145,11.97,0.03157,10.54,0.03157,10.54,0.03169,9.19,0.03169,9.19,0.03181,7.93,0.03181,7.93,0.03194,6.75,0.03194,6.75,0.03206,5.68,0.03206,5.68,0.03217,4.72,0.03217,4.72,0.03230,3.81,0.03230,3.81,0.03241,3.01,0.03241,3.01,0.03253,2.31,0.03253,2.31,0.03265,1.69,0.03265,1.69,0.03278,1.17,0.03278,1.17,0.03290,0.77,0.03290,0.77,0.03302,0.42,0.03302,0.42,0.03314,0.18,0.03314,0.18,0.03326,0.04,0.03326,0.04,0.03335,0.00,0.03335,0.00,0.03339,0.00,0.03339,0.00,0.03350,0.05,0.03350,0.05,0.03362,0.19,0.03362,0.19,0.03374,0.42,0.03374,0.42,0.03386,0.74,0.03386,0.74,0.03398,1.15,0.03398,1.15,0.03410,1.67,0.03410,1.67,0.03422,2.26,0.03422,2.26,0.03434,2.96,0.03434,2.96,0.03446,3.73,0.03446,3.73,0.03458,4.61,0.03458,4.61,0.03470,5.61,0.03470,5.61,0.03482,6.68,0.03482,6.68,0.03494,7.85,0.03494,7.85,0.03506,9.12,0.03506,9.12,0.03518,10.49,0.03518,10.49,0.03530,11.96,0.03530,11.96,0.03542,13.29,0.03542,13.29,0.03555,14.71,0.03555,14.71,0.03565,16.00)
  let cIO19 = (0.03098,16.00,0.03109,14.50,0.03109,14.50,0.03121,12.95,0.03121,12.95,0.03133,11.48,0.03133,11.48,0.03145,10.14,0.03145,10.14,0.03157,8.84,0.03157,8.84,0.03169,7.65,0.03169,7.65,0.03181,6.55,0.03181,6.55,0.03194,5.55,0.03194,5.55,0.03205,4.65,0.03205,4.65,0.03217,3.83,0.03217,3.83,0.03230,3.09,0.03230,3.09,0.03241,2.45,0.03241,2.45,0.03253,1.93,0.03253,1.93,0.03265,1.48,0.03265,1.48,0.03278,1.12,0.03278,1.12,0.03290,0.86,0.03290,0.86,0.03302,0.68,0.03302,0.68,0.03313,0.60,0.03313,0.60,0.03316,0.59,0.03316,0.59,0.03327,0.62,0.03327,0.62,0.03339,0.73,0.03339,0.73,0.03350,0.94,0.03350,0.94,0.03362,1.24,0.03362,1.24,0.03374,1.63,0.03374,1.63,0.03386,2.03,0.03386,2.03,0.03398,2.40,0.03398,2.40,0.03410,2.84,0.03410,2.84,0.03422,3.38,0.03422,3.38,0.03434,4.03,0.03434,4.03,0.03446,4.78,0.03446,4.78,0.03458,5.63,0.03458,5.63,0.03470,6.56,0.03470,6.56,0.03482,7.61,0.03482,7.61,0.03494,8.76,0.03494,8.76,0.03506,10.01,0.03506,10.01,0.03518,11.35,0.03518,11.35,0.03530,12.79,0.03530,12.79,0.03542,14.35,0.03542,14.35,0.03555,15.98,0.03555,15.98,0.03555,16.00)
  let cNO24 = (0.03177,16.00,0.03181,15.52,0.03181,15.52,0.03194,14.25,0.03194,14.25,0.03206,13.04,0.03206,13.04,0.03218,11.96,0.03218,11.96,0.03230,10.97,0.03230,10.97,0.03241,10.07,0.03241,10.07,0.03253,9.26,0.03253,9.26,0.03265,8.55,0.03265,8.55,0.03278,7.89,0.03278,7.89,0.03290,7.34,0.03290,7.34,0.03301,6.91,0.03301,6.91,0.03313,6.56,0.03313,6.56,0.03326,6.30,0.03326,6.30,0.03338,6.15,0.03338,6.15,0.03348,6.08,0.03348,6.08,0.03352,6.07,0.03352,6.07,0.03362,6.11,0.03362,6.11,0.03374,6.24,0.03374,6.24,0.03386,6.45,0.03386,6.45,0.03399,6.77,0.03399,6.77,0.03410,7.16,0.03410,7.16,0.03422,7.67,0.03422,7.67,0.03434,8.26,0.03434,8.26,0.03446,8.96,0.03446,8.96,0.03458,9.74,0.03458,9.74,0.03470,10.61,0.03470,10.61,0.03482,11.39,0.03482,11.39,0.03495,12.29,0.03495,12.29,0.03506,13.27,0.03506,13.27,0.03518,14.34,0.03518,14.34,0.03530,15.51,0.03530,15.51,0.03535,16.00)
  let cIO24 = (0.03107,16.00,0.03109,15.69,0.03109,15.69,0.03121,14.06,0.03121,14.06,0.03133,12.55,0.03133,12.55,0.03145,11.09,0.03145,11.09,0.03157,9.75,0.03157,9.75,0.03169,8.49,0.03169,8.49,0.03181,7.32,0.03181,7.32,0.03193,6.24,0.03193,6.24,0.03205,5.26,0.03205,5.26,0.03217,4.37,0.03217,4.37,0.03229,3.58,0.03229,3.58,0.03241,2.88,0.03241,2.88,0.03253,2.26,0.03253,2.26,0.03265,1.72,0.03265,1.72,0.03277,1.30,0.03277,1.30,0.03290,0.94,0.03290,0.94,0.03302,0.70,0.03302,0.70,0.03313,0.47,0.03313,0.47,0.03326,0.21,0.03326,0.21,0.03337,0.07,0.03337,0.07,0.03349,0.00,0.03349,0.00,0.03351,0.00,0.03351,0.00,0.03363,0.04,0.03363,0.04,0.03374,0.18,0.03374,0.18,0.03386,0.40,0.03386,0.40,0.03398,0.73,0.03398,0.73,0.03410,1.16,0.03410,1.16,0.03422,1.67,0.03422,1.67,0.03434,2.30,0.03434,2.30,0.03446,3.02,0.03446,3.02,0.03458,3.85,0.03458,3.85,0.03470,4.76,0.03470,4.76,0.03482,5.79,0.03482,5.79,0.03494,6.91,0.03494,6.91,0.03507,8.15,0.03507,8.15,0.03518,9.45,0.03518,9.45,0.03530,10.87,0.03530,10.87,0.03542,12.39,0.03542,12.39,0.03554,14.01,0.03554,14.01,0.03567,15.75,0.03567,15.75,0.03568,16.00)
  let dNO19 = (-0.03165,16.00,-0.03143,12.65,-0.03143,12.65,-0.03101,7.71,-0.03101,7.71,-0.03058,3.70,-0.03058,3.70,-0.03014,1.23,-0.03014,1.23,-0.02971,0.24,-0.02971,0.24,-0.02929,0.06,-0.02929,0.06,-0.02888,0.01,-0.02888,0.01,-0.02849,0.00,-0.02849,0.00,-0.02839,0.00,-0.02839,0.00,-0.02799,0.02,-0.02799,0.02,-0.02753,0.05,-0.02753,0.05,-0.02711,0.09,-0.02711,0.09,-0.02667,0.15,-0.02667,0.15,-0.02628,0.22,-0.02628,0.22,-0.02587,0.28,-0.02587,0.28,-0.02542,0.37,-0.02542,0.37,-0.02498,0.46,-0.02498,0.46,-0.02456,0.57,-0.02456,0.57,-0.02417,0.67,-0.02417,0.67,-0.02366,0.78,-0.02366,0.78,-0.02330,0.88,-0.02330,0.88,-0.02286,0.99,-0.02286,0.99,-0.02245,1.12,-0.02245,1.12,-0.02200,1.25,-0.02200,1.25,-0.02156,1.38,-0.02156,1.38,-0.02114,1.51,-0.02114,1.51,-0.02071,1.67,-0.02071,1.67,-0.02027,1.82,-0.02027,1.82,-0.01988,1.97,-0.01988,1.97,-0.01940,2.13,-0.01940,2.13,-0.01899,2.27,-0.01899,2.27,-0.01858,2.45,-0.01858,2.45,-0.01811,2.62,-0.01811,2.62,-0.01773,2.78,-0.01773,2.78,-0.01731,2.95,-0.01731,2.95,-0.01685,3.14,-0.01685,3.14,-0.01646,3.31,-0.01646,3.31,-0.01603,3.50,-0.01603,3.50,-0.01561,3.68,-0.01561,3.68,-0.01516,3.89,-0.01516,3.89,-0.01474,4.08,-0.01474,4.08,-0.01430,4.30,-0.01430,4.30,-0.01385,4.51,-0.01385,4.51,-0.01346,4.72,-0.01346,4.72,-0.01304,4.92,-0.01304,4.92,-0.01261,5.15,-0.01261,5.15,-0.01217,5.37,-0.01217,5.37,-0.01174,5.59,-0.01174,5.59,-0.01132,5.82,-0.01132,5.82,-0.01088,6.06,-0.01088,6.06,-0.01047,6.29,-0.01047,6.29,-0.00999,6.54,-0.00999,6.54,-0.00962,6.77,-0.00962,6.77,-0.00916,7.02,-0.00916,7.02,-0.00875,7.26,-0.00875,7.26,-0.00832,7.52,-0.00832,7.52,-0.00791,7.78,-0.00791,7.78,-0.00749,8.03,-0.00749,8.03,-0.00703,8.31,-0.00703,8.31,-0.00660,8.58,-0.00660,8.58,-0.00620,8.85,-0.00620,8.85,-0.00575,9.15,-0.00575,9.15,-0.00533,9.41,-0.00533,9.41,-0.00492,9.70,-0.00492,9.70,-0.00448,9.99,-0.00448,9.99,-0.00403,10.28,-0.00403,10.28,-0.00363,10.57,-0.00363,10.57,-0.00318,10.88,-0.00318,10.88,-0.00276,11.17,-0.00276,11.17,-0.00233,11.49,-0.00233,11.49,-0.00189,11.80,-0.00189,11.80,-0.00148,12.11,-0.00148,12.11,-0.00106,12.42,-0.00106,12.42,-0.00061,12.75,-0.00061,12.75,-0.00019,13.08,-0.00019,13.08,0.00022,13.39,0.00022,13.39,0.00065,13.72,0.00065,13.72,0.00107,14.06,0.00107,14.06,0.00150,14.40,0.00150,14.40,0.00194,14.76,0.00194,14.76,0.00236,15.09,0.00236,15.09,0.00279,15.44,0.00279,15.44,0.00327,15.84,0.00327,15.84,0.00345,16.00)
  let dIO19 = (-0.03116,16.00,-0.03101,13.56,-0.03101,13.56,-0.03056,9.00,-0.03056,9.00,-0.03014,6.09,-0.03014,6.09,-0.02973,4.77,-0.02973,4.77,-0.02929,4.43,-0.02929,4.43,-0.02888,4.21,-0.02888,4.21,-0.02845,4.02,-0.02845,4.02,-0.02803,3.84,-0.02803,3.84,-0.02759,3.68,-0.02759,3.68,-0.02716,3.53,-0.02716,3.53,-0.02673,3.39,-0.02673,3.39,-0.02631,3.27,-0.02631,3.27,-0.02588,3.14,-0.02588,3.14,-0.02546,3.02,-0.02546,3.02,-0.02502,2.90,-0.02502,2.90,-0.02461,2.80,-0.02461,2.80,-0.02418,2.70,-0.02418,2.70,-0.02377,2.61,-0.02377,2.61,-0.02335,2.50,-0.02335,2.50,-0.02289,2.41,-0.02289,2.41,-0.02246,2.32,-0.02246,2.32,-0.02206,2.26,-0.02206,2.26,-0.02160,2.17,-0.02160,2.17,-0.02117,2.10,-0.02117,2.10,-0.02080,2.05,-0.02080,2.05,-0.02034,1.99,-0.02034,1.99,-0.01988,1.92,-0.01988,1.92,-0.01952,1.88,-0.01952,1.88,-0.01904,1.82,-0.01904,1.82,-0.01863,1.78,-0.01863,1.78,-0.01819,1.73,-0.01819,1.73,-0.01777,1.69,-0.01777,1.69,-0.01743,1.66,-0.01743,1.66,-0.01692,1.63,-0.01692,1.63,-0.01666,1.61,-0.01666,1.61,-0.01605,1.58,-0.01605,1.58,-0.01567,1.57,-0.01567,1.57,-0.01521,1.56,-0.01521,1.56,-0.01499,1.56,-0.01499,1.56,-0.01440,1.55,-0.01440,1.55,-0.01416,1.55,-0.01416,1.55,-0.01385,1.55,-0.01385,1.55,-0.01341,1.56,-0.01341,1.56,-0.01299,1.56,-0.01299,1.56,-0.01241,1.58,-0.01241,1.58,-0.01215,1.59,-0.01215,1.59,-0.01154,1.61,-0.01154,1.61,-0.01127,1.62,-0.01127,1.62,-0.01091,1.66,-0.01091,1.66,-0.01036,1.68,-0.01036,1.68,-0.00990,1.72,-0.00990,1.72,-0.00962,1.75,-0.00962,1.75,-0.00877,1.66,-0.00877,1.66,-0.00836,1.58,-0.00836,1.58,-0.00791,1.50,-0.00791,1.50,-0.00751,1.41,-0.00751,1.41,-0.00710,1.35,-0.00710,1.35,-0.00664,1.28,-0.00664,1.28,-0.00626,1.22,-0.00626,1.22,-0.00582,1.15,-0.00582,1.15,-0.00540,1.09,-0.00540,1.09,-0.00494,1.04,-0.00494,1.04,-0.00460,0.99,-0.00460,0.99,-0.00410,0.94,-0.00410,0.94,-0.00373,0.89,-0.00373,0.89,-0.00327,0.84,-0.00327,0.84,-0.00281,0.80,-0.00281,0.80,-0.00243,0.77,-0.00243,0.77,-0.00194,0.73,-0.00194,0.73,-0.00162,0.70,-0.00162,0.70,-0.00126,0.68,-0.00126,0.68,-0.00066,0.64,-0.00066,0.64,-0.00038,0.63,-0.00038,0.63,0.00017,0.61,0.00017,0.61,0.00059,0.60,0.00059,0.60,0.00080,0.60,0.00080,0.60,0.00148,0.59,0.00148,0.59,0.00156,0.59,0.00156,0.59,0.00219,0.60,0.00219,0.60,0.00276,0.60,0.00276,0.60,0.00284,0.61,0.00284,0.61,0.00327,0.61,0.00327,0.61,0.00374,0.63,0.00374,0.63,0.00415,0.65,0.00415,0.65,0.00456,0.67,0.00456,0.67,0.00493,0.69,0.00493,0.69,0.00536,0.72,0.00536,0.72,0.00578,0.75,0.00578,0.75,0.00626,0.79,0.00626,0.79,0.00664,0.82,0.00664,0.82,0.00708,0.87,0.00708,0.87,0.00749,0.92,0.00749,0.92,0.00791,0.96,0.00791,0.96,0.00835,1.02,0.00835,1.02,0.00885,1.09,0.00885,1.09,0.00924,1.14,0.00924,1.14,0.00963,1.20,0.00963,1.20,0.01012,1.29,0.01012,1.29,0.01050,1.36,0.01050,1.36,0.01091,1.44,0.01091,1.44,0.01137,1.53,0.01137,1.53,0.01181,1.62,0.01181,1.62,0.01218,1.69,0.01218,1.69,0.01268,1.80,0.01268,1.80,0.01307,1.89,0.01307,1.89,0.01346,1.98,0.01346,1.98,0.01392,2.09,0.01392,2.09,0.01433,2.19,0.01433,2.19,0.01475,2.29,0.01475,2.29,0.01520,2.43,0.01520,2.43,0.01567,2.55,0.01567,2.55,0.01606,2.67,0.01606,2.67,0.01649,2.80,0.01649,2.80,0.01693,2.95,0.01693,2.95,0.01734,3.08,0.01734,3.08,0.01775,3.22,0.01775,3.22,0.01821,3.37,0.01821,3.37,0.01863,3.53,0.01863,3.53,0.01904,3.68,0.01904,3.68,0.01945,3.84,0.01945,3.84,0.01989,4.00,0.01989,4.00,0.02032,4.18,0.02032,4.18,0.02074,4.35,0.02074,4.35,0.02118,4.53,0.02118,4.53,0.02159,4.72,0.02159,4.72,0.02202,4.90,0.02202,4.90,0.02246,5.09,0.02246,5.09,0.02294,5.32,0.02294,5.32,0.02333,5.52,0.02333,5.52,0.02374,5.74,0.02374,5.74,0.02416,5.97,0.02416,5.97,0.02459,6.17,0.02459,6.17,0.02501,6.40,0.02501,6.40,0.02547,6.65,0.02547,6.65,0.02586,6.89,0.02586,6.89,0.02629,7.15,0.02629,7.15,0.02673,7.39,0.02673,7.39,0.02716,7.66,0.02716,7.66,0.02758,7.98,0.02758,7.98,0.02801,8.26,0.02801,8.26,0.02843,8.60,0.02843,8.60,0.02886,8.93,0.02886,8.93,0.02929,9.32,0.02929,9.32,0.02971,9.82,0.02971,9.82,0.03014,11.01,0.03014,11.01,0.03058,13.62,0.03058,13.62,0.03082,16.00)
  let dNO24 = (-0.03141,16.00,-0.03101,11.83,-0.03101,11.83,-0.03058,8.65,-0.03058,8.65,-0.03016,6.64,-0.03016,6.64,-0.02973,6.07,-0.02973,6.07,-0.02970,6.07,-0.02970,6.07,-0.02927,6.16,-0.02927,6.16,-0.02886,6.30,-0.02886,6.30,-0.02844,6.45,-0.02844,6.45,-0.02801,6.61,-0.02801,6.61,-0.02757,6.76,-0.02757,6.76,-0.02714,6.92,-0.02714,6.92,-0.02670,7.12,-0.02670,7.12,-0.02628,7.30,-0.02628,7.30,-0.02587,7.48,-0.02587,7.48,-0.02541,7.68,-0.02541,7.68,-0.02500,7.88,-0.02500,7.88,-0.02456,8.08,-0.02456,8.08,-0.02415,8.27,-0.02415,8.27,-0.02372,8.47,-0.02372,8.47,-0.02330,8.69,-0.02330,8.69,-0.02287,8.90,-0.02287,8.90,-0.02243,9.13,-0.02243,9.13,-0.02199,9.34,-0.02199,9.34,-0.02156,9.58,-0.02156,9.58,-0.02117,9.79,-0.02117,9.79,-0.02075,9.97,-0.02075,9.97,-0.02029,10.17,-0.02029,10.17,-0.01984,10.38,-0.01984,10.38,-0.01945,10.58,-0.01945,10.58,-0.01903,10.77,-0.01903,10.77,-0.01860,10.95,-0.01860,10.95,-0.01814,11.17,-0.01814,11.17,-0.01773,11.38,-0.01773,11.38,-0.01726,11.60,-0.01726,11.60,-0.01686,11.78,-0.01686,11.78,-0.01644,12.00,-0.01644,12.00,-0.01601,12.20,-0.01601,12.20,-0.01561,12.42,-0.01561,12.42,-0.01518,12.64,-0.01518,12.64,-0.01474,12.87,-0.01474,12.87,-0.01431,13.08,-0.01431,13.08,-0.01387,13.32,-0.01387,13.32,-0.01344,13.55,-0.01344,13.55,-0.01304,13.79,-0.01304,13.79,-0.01261,14.01,-0.01261,14.01,-0.01215,14.25,-0.01215,14.25,-0.01174,14.50,-0.01174,14.50,-0.01132,14.73,-0.01132,14.73,-0.01089,14.97,-0.01089,14.97,-0.01047,15.23,-0.01047,15.23,-0.01002,15.48,-0.01002,15.48,-0.00962,15.74,-0.00962,15.74,-0.00917,15.98,-0.00917,15.98,-0.00914,16.00)
  let dIO24 = (-0.03138,16.00,-0.03101,10.71,-0.03101,10.71,-0.03056,6.29,-0.03056,6.29,-0.03014,3.59,-0.03014,3.59,-0.02971,2.42,-0.02971,2.42,-0.02930,2.13,-0.02930,2.13,-0.02886,1.93,-0.02886,1.93,-0.02844,1.77,-0.02844,1.77,-0.02805,1.63,-0.02805,1.63,-0.02759,1.50,-0.02759,1.50,-0.02716,1.37,-0.02716,1.37,-0.02673,1.25,-0.02673,1.25,-0.02638,1.16,-0.02638,1.16,-0.02590,1.06,-0.02590,1.06,-0.02546,0.98,-0.02546,0.98,-0.02502,0.88,-0.02502,0.88,-0.02459,0.80,-0.02459,0.80,-0.02418,0.73,-0.02418,0.73,-0.02376,0.66,-0.02376,0.66,-0.02333,0.57,-0.02333,0.57,-0.02294,0.51,-0.02294,0.51,-0.02246,0.46,-0.02246,0.46,-0.02209,0.39,-0.02209,0.39,-0.02165,0.34,-0.02165,0.34,-0.02119,0.31,-0.02119,0.31,-0.02076,0.26,-0.02076,0.26,-0.02035,0.22,-0.02035,0.22,-0.02000,0.18,-0.02000,0.18,-0.01952,0.15,-0.01952,0.15,-0.01913,0.12,-0.01913,0.12,-0.01862,0.08,-0.01862,0.08,-0.01823,0.07,-0.01823,0.07,-0.01778,0.04,-0.01778,0.04,-0.01739,0.02,-0.01739,0.02,-0.01705,0.02,-0.01705,0.02,-0.01675,0.01,-0.01675,0.01,-0.01630,0.00,-0.01630,0.00,-0.01583,0.00,-0.01583,0.00,-0.01542,0.00,-0.01542,0.00,-0.01515,0.00,-0.01515,0.00,-0.01467,0.02,-0.01467,0.02,-0.01426,0.02,-0.01426,0.02,-0.01382,0.04,-0.01382,0.04,-0.01346,0.06,-0.01346,0.06,-0.01299,0.08,-0.01299,0.08,-0.01261,0.11,-0.01261,0.11,-0.01217,0.14,-0.01217,0.14,-0.01173,0.17,-0.01173,0.17,-0.01127,0.20,-0.01127,0.20,-0.01079,0.25,-0.01079,0.25,-0.01042,0.28,-0.01042,0.28,-0.01001,0.33,-0.01001,0.33,-0.00958,0.39,-0.00958,0.39,-0.00914,0.44,-0.00914,0.44,-0.00877,0.49,-0.00877,0.49,-0.00831,0.55,-0.00831,0.55,-0.00783,0.62,-0.00783,0.62,-0.00749,0.69,-0.00749,0.69,-0.00671,0.66,-0.00671,0.66,-0.00631,0.63,-0.00631,0.63,-0.00586,0.61,-0.00586,0.61,-0.00546,0.58,-0.00546,0.58,-0.00494,0.56,-0.00494,0.56,-0.00465,0.54,-0.00465,0.54,-0.00422,0.52,-0.00422,0.52,-0.00380,0.50,-0.00380,0.50,-0.00340,0.50,-0.00340,0.50,-0.00283,0.49,-0.00283,0.49,-0.00237,0.49,-0.00237,0.49,-0.00203,0.48,-0.00203,0.48,-0.00182,0.49,-0.00182,0.49,-0.00143,0.50,-0.00143,0.50,-0.00106,0.50,-0.00106,0.50,-0.00056,0.52,-0.00056,0.52,-0.00015,0.54,-0.00015,0.54,0.00034,0.56,0.00034,0.56,0.00066,0.58,0.00066,0.58,0.00112,0.62,0.00112,0.62,0.00153,0.65,0.00153,0.65,0.00196,0.68,0.00196,0.68,0.00252,0.74,0.00252,0.74,0.00279,0.77,0.00279,0.77,0.00332,0.82,0.00332,0.82,0.00373,0.87,0.00373,0.87,0.00407,0.92,0.00407,0.92,0.00451,0.99,0.00451,0.99,0.00492,1.05,0.00492,1.05,0.00534,1.11,0.00534,1.11,0.00577,1.19,0.00577,1.19,0.00621,1.25,0.00621,1.25,0.00674,1.36,0.00674,1.36,0.00710,1.41,0.00710,1.41,0.00752,1.51,0.00752,1.51,0.00795,1.59,0.00795,1.59,0.00837,1.69,0.00837,1.69,0.00878,1.79,0.00878,1.79,0.00919,1.89,0.00919,1.89,0.00966,2.01,0.00966,2.01,0.01006,2.11,0.01006,2.11,0.01058,2.26,0.01058,2.26,0.01092,2.37,0.01092,2.37,0.01133,2.48,0.01133,2.48,0.01177,2.63,0.01177,2.63,0.01223,2.75,0.01223,2.75,0.01264,2.89,0.01264,2.89,0.01307,3.03,0.01307,3.03,0.01349,3.17,0.01349,3.17,0.01392,3.33,0.01392,3.33,0.01433,3.47,0.01433,3.47,0.01480,3.65,0.01480,3.65,0.01521,3.81,0.01521,3.81,0.01567,4.01,0.01567,4.01,0.01605,4.14,0.01605,4.14,0.01647,4.35,0.01647,4.35,0.01690,4.51,0.01690,4.51,0.01732,4.70,0.01732,4.70,0.01780,4.92,0.01780,4.92,0.01817,5.11,0.01817,5.11,0.01862,5.32,0.01862,5.32,0.01904,5.52,0.01904,5.52,0.01945,5.75,0.01945,5.75,0.01989,5.98,0.01989,5.98,0.02032,6.20,0.02032,6.20,0.02078,6.44,0.02078,6.44,0.02118,6.66,0.02118,6.66,0.02159,6.91,0.02159,6.91,0.02204,7.17,0.02204,7.17,0.02244,7.43,0.02244,7.43,0.02289,7.70,0.02289,7.70,0.02331,7.98,0.02331,7.98,0.02372,8.25,0.02372,8.25,0.02416,8.57,0.02416,8.57,0.02459,8.86,0.02459,8.86,0.02503,9.18,0.02503,9.18,0.02544,9.50,0.02544,9.50,0.02586,9.82,0.02586,9.82,0.02631,10.17,0.02631,10.17,0.02673,10.51,0.02673,10.51,0.02716,10.88,0.02716,10.88,0.02758,11.28,0.02758,11.28,0.02801,11.70,0.02801,11.70,0.02843,12.13,0.02843,12.13,0.02886,12.60,0.02886,12.60,0.02929,13.13,0.02929,13.13,0.02971,13.81,0.02971,13.81,0.03015,14.89,0.03015,14.89,0.03036,16.00)
  // ---- left panel ----
  rect(fL(0.030, 0), fL(0.037, 16), stroke: ast, fill: none)
  for y in (5.0, 10.0, 15.0) { line(fL(0.030, y), fL(0.037, y), stroke: gst) }
  for x in (0.032, 0.034, 0.036) { line(fL(x, 0), fL(x, 16), stroke: gst) }
  for y in range(1, 16) { ticky(fL, 0.030, 0.037, y + 0.0, 0.06, false); ticky(fL, 0.030, 0.037, y + 0.0, 0.06, true) }
  for y in (0.0, 5.0, 10.0, 15.0) { ticky(fL, 0.030, 0.037, y, 0.14, false); ticky(fL, 0.030, 0.037, y, 0.14, true)
    content(fL(0.030, y), anchor: "east", offset: (-0.1cm, 0), std.text(size: 8pt, str(int(y)))) }
  for x in (0.030, 0.031, 0.032, 0.033, 0.034, 0.035, 0.036, 0.037) { tickx(fL, x, 0, 0.08); tickx(fL, x, 16, 0.08) }
  for x in (0.030, 0.032, 0.034, 0.036) { tickx(fL, x, 0, 0.16); tickx(fL, x, 16, 0.16)
    content(fL(x, 0), anchor: if x == 0.030 { "north-west" } else { "north" }, offset: (0, -0.12cm), std.text(size: 8pt, if x == 0.030 { "0.03" } else { str(x).slice(0, 5) })) }
  crv(fL, cNO19, blue, ())
  crv(fL, cIO19, red, ())
  crv(fL, cNO24, blue, "dashed")
  crv(fL, cIO24, red, "dashed")
  // ---- right panel ----
  rect(fR(-0.04, 0), fR(0.04, 16), stroke: ast, fill: none)
  for y in (5.0, 10.0, 15.0) { line(fR(-0.04, y), fR(0.04, y), stroke: gst) }
  for x in (-0.02, 0.0, 0.02) { line(fR(x, 0), fR(x, 16), stroke: gst) }
  for y in range(1, 16) { ticky(fR, -0.04, 0.04, y + 0.0, 0.06, false); ticky(fR, -0.04, 0.04, y + 0.0, 0.06, true) }
  for x in (-0.04, -0.03, -0.02, -0.01, 0.0, 0.01, 0.02, 0.03, 0.04) { tickx(fR, x, 0, 0.08); tickx(fR, x, 16, 0.08) }
  for x in (-0.04, -0.02, 0.0, 0.02, 0.04) { tickx(fR, x, 0, 0.16); tickx(fR, x, 16, 0.16)
    content(fR(x, 0), anchor: if x == -0.04 { "north-west" } else if x == 0.04 { "north-east" } else { "north" }, offset: (0, -0.12cm), std.text(size: 8pt, if x == 0.0 { "0" } else { if x < 0 { "-" + str(-x).slice(0, 4) } else { str(x).slice(0, 4) } })) }
  crv(fR, dNO19, blue, ())
  crv(fR, dIO19, red, ())
  crv(fR, dNO24, blue, "dashed")
  crv(fR, dIO24, red, "dashed")
  // ---- shared y label & x labels ----
  content((-0.65, h / 2), anchor: "center", std.rotate(90deg, std.text(size: 10pt, [$Delta chi^2$])))
  content((w / 2, -0.95), anchor: "center", std.text(size: 10pt, [$J_"CP"^"max" = c_12 s_12 c_23 s_23 c_13^2 s_13$]))
  content((gap + w + w / 2, -0.95), anchor: "center", std.text(size: 10pt, [$J_"CP" = J_"CP"^"max" sin delta_"CP"$]))
  // ---- legend ----
  let ly1 = h + 1.0
  let ly2 = h + 0.55
  line((0.25, ly1 + 0.06), (1.75, ly1 + 0.06), stroke: (paint: red, thickness: 1.1pt))
  line((0.25, ly1 - 0.06), (1.75, ly1 - 0.06), stroke: (paint: blue, thickness: 1.1pt))
  line((0.25, ly2), (1.75, ly2), stroke: (paint: red, thickness: 1.1pt, dash: "dashed"))
  line((0.25, ly2), (1.75, ly2), stroke: (paint: blue, thickness: 1.1pt, dash: "dashed"))
  content((1.9, ly1), anchor: "west", std.text(size: 10pt, [NO, IO (IC19 w/o SK-atm)]))
  content((1.9, ly2), anchor: "west", std.text(size: 10pt, [NO, IO (IC24 with SK-atm)]))
  // ---- NuFIT box ----
  let bx = (gap + w + 3.9, h + 0.42)
  let bxy = (2 * w + gap - 0.05, h + 1.12)
  rect(bx, bxy, fill: rgb(250, 250, 175), stroke: ast)
  content(((bx.at(0) + bxy.at(0)) / 2, (bx.at(1) + bxy.at(1)) / 2), anchor: "center", std.text(size: 10pt, [NuFIT 6.0 (2024)]))
}),
  caption: [
    Dependence of the global $Delta chi^2$ function on the Jarlskog invariant. The red (blue) curves are for NO (IO). Solid (dashed) curves are for the \<\<IC19 w/o SK-atm\>\> (\<\<IC24 with SK-atm\>\>) $Delta chi^2$.
  ]
) <fig:chisq-viola>

We quantify the presence of leptonic CP violation in neutrino propagation in vacuum in a convention-independent form in terms of the leptonic Jarlskog invariant @Krastev:1988yu:

$ J_"CP" & equiv "Im" | U_(alpha i) U_(alpha j)^"*" U_(beta i)^"*" U_(beta j) | \
  & equiv J_"CP"^"max" sin delta_"CP" = cos theta_12 sin theta_12 cos theta_23 sin theta_23 cos^2 theta_13 sin theta_13 sin delta_"CP" $
<eq:jcplep>

Its present determination is shown in @fig:chisq-viola, from which we read its maximum value

$
  J_"CP"^"max" = 0.0333 ± 0.0007 (± 0.0017)
$
<eq:jmax>

at $1 sigma$ ($3 sigma$) for both orderings. $J_"CP"$ is totally analogous to the invariant introduced @Jarlskog:1985ht for the description of CP-violating effects in the quark sector, presently determined to be $J_"CP"^"quarks" = (3.12^(-0.12)^(+0.13)) times 10^(-5)$ @PDG.

@fig:chisq-viola also shows that in NO the best-fit value $J_"CP"^"best" = 0.0017 (-0.018)$ (where the value in parenthesis corresponds to the analysis with IC24 and SK-atm) is only favored over CP conservation $J_"CP" = 0$ with $Delta chi^2 = 0.02 (0.55)$. In contrast, in IO CP conservation is disfavored with respect to $J_"CP"^"best" = -0.032$ with $Delta chi^2 = 13 (16)$, which corresponds to $3.6 sigma$ ($4 sigma$) when evaluated for 1 dof.

= Status of neutrino mass ordering, leptonic CP violation, and $bold(theta_23)$<sec:atm>

== Updates from T2K and NOvA <sec:lbl>

// [figvision] src/Figures/fig-nevts.pdf - predicted event rates vs delta_CP.
// 3x2 panels, delta_CP 0-2pi. Left column T2K, right NOvA. Top and middle rows:
// nu_e CCQE samples (T2K ranges 13-25 and 55-110 events; NOvA 22-46 and
// 150-260). Bottom-left: T2K nu_e CC1pi, 6.5-10.5 events.
// Coloured bands span sin^2 theta_23 in [0.44,0.58] (darker edge = 0.58):
// red NO, blue IO. Grey horizontal band = observed +/-1 sigma with dashed
// central line (T2K 15.5, 102, 15.2; NOvA 33, 175 events).
#figure(placement: top, 
  image("src/Figures/fig-nevts.pdf", width: 85%),
  caption: [Predicted number of events as a function of $delta_"CP"$ for the T2K (left) and NOvA (right) appearance data sets. $sin^2 theta_23$ varies between 0.44 and 0.58, where the lower-light (upper-dark) bound of the colored bands corresponds to 0.44 (0.58). Red (blue) bands correspond to NO (IO). For the other oscillation parameters we have adopted $sin^2 theta_13 = 0.0222$, $|Delta m^2_(3 ell)| = 2.5 times 10^(-3) "eV"^2$, $sin^2 theta_12 = 0.32$, $Delta m^2_(21) = 7.5 times 10^(-5) "eV"^2$. The horizontal dashed lines show the observed number of events, with the $± 1 sigma$ statistical error indicated by the gray shaded band.],
) <fig:nevts24>

We start by discussing the implications of the latest data from the T2K and NOvA long-baseline accelerator experiments, presented at the Neutrino 2024 conference. Although our analysis includes the full spectral information provided by the collaborations, qualitative understanding of the results can be obtained from the study of the total number of events in the different appearance samples. To this end, we show in @fig:nevts24 the predicted number of events for these samples as a function of $delta_"CP"$, for varying values of $sin^2 theta_23$, as well as the mass ordering, compared to the observations.

The predictions in @fig:nevts24 are calculated using our simulations of the experiments, that include numerically-computed oscillation probabilities. However, the general behaviour of the curves is well-described by approximate expressions derived in earlier studies @Elevant:2015ska @Esteban:2018azc. These expand the relevant oscillation probabilities in the small parameters $sin theta_13$, $Delta m^2_(21) L\/E_nu$, and $A equiv abs|(2 E_nu V\/Delta m^2_(3 ell))|$ (where $L$ is the baseline, $E_nu$ the neutrino energy and $V$ the effective matter potential @Wolfenstein:1977ue), resulting in the following expressions for the expected number of events:

$ N_(nu_e) approx cal(N)_nu (2 s_23^2 (1 + 2 o A) - C' sin delta_"CP" (1 + o A)) $ <eq:Nnu>

$ N_(bar nu_e) approx cal(N)_(bar nu) (2 s_23^2 (1 - 2 o A) + C' sin delta_"CP" (1 - o A)) $ <eq:Nan>

where $o equiv "sgn"(Delta m^2_(3 ell))$. For T2K the mean neutrino energy gives $A approx 0.05$, whereas for NOvA we find that the approximation works best with the #emph[empirical] value of $A = 0.1$. Furthermore, taking all of the well-determined parameters $theta_13$, $theta_12$, $Delta m^2_(21)$, $|Delta m^2_(3 ell)|$ at their global best-fit points, we obtain numerically $C' approx 0.28$ with negligible dependence on $theta_23$. The normalization constants $cal(N)_(nu macron(nu))$ calculated from our re-analysis of T2K and NOvA are given for the various appearance samples in @tab:app24, along with the corresponding observed event numbers and expected backgrounds. We can obtain insight on the results of the fit by considering the ratio $r equiv ( N_"obs" - N_"bck" ) \/ cal(N)$.

#figure(
  table(
    columns: 7,
    align: center,
    [], table.cell(colspan: 3)[T2K ($nu$)], [T2K ($macron(nu)$)], [NOvA ($nu$)], [NOvA ($macron(nu)$)],
    [], [CCQE], [CC1 $pi$], [Sum], [], [], [],
    [$cal(N)$], [54], [5], [59], [13], [104], [23],
    [$N_("obs")$], [102], [15], [117], [16], [181], [33],
    [$N_("obs") - N_("bck")$], [81.6], [12.5], [94.2], [10], [117.3], [19],
    [$r = frac(N_("obs") - N_("bck"), cal(N))$], [1.5 (1.6)], [2.5 (2.4)], [1.59 (1.65)], [0.77 (0.61)], [1.13 (1.14)], [0.83 (0.83)],
  ),
  kind: table,
  caption: [Normalization coefficients $cal(N)_nu$ and $cal(N)_(macron(nu))$ in @eq:Nnu and @eq:Nan for approximations used to qualitatively describe the appearance event samples for T2K and NOvA. Numbers in parentheses are the corresponding values for the data set used for NuFIT~5.0.],
) <tab:app24>

From the numbers in the table we observe the following:

- T2K data has $r > 1$ for neutrinos and $r < 1$ for antineutrinos, so the square-bracket in @eq:Nnu has to be enhanced and the one in @eq:Nan suppressed. This can be achieved with $delta_"CP" tilde.equiv 3 pi\/2$, with a better fit in NO. This preference has been present since the first T2K results on $nu_e$ appearance. As can be seen in the last line of @tab:app24, although the preference is somewhat weaker in NuFIT~6.0 than it was in NuFIT~5.0, it is still significant; and the strongest observed effect remains in the lower-statistics CC$1 pi$ sample.
- NOvA antineutrino results have not changed since NuFIT~5.0. They have $r < 1$ and can be accommodated with either NO and $delta_"CP" tilde.equiv pi\/2$, or IO and $delta_"CP" tilde.equiv 3 pi\/2$, with a slightly better fit in NO.
- NOvA neutrino results have now 60% more statistics than in NuFIT~5.0, and they still result in $r tilde 1$. This can also be accommodated with either NO and $delta_"CP" tilde.equiv pi\/2$, or IO and $delta_"CP" tilde.equiv 3 pi\/2$, totally compatible with the NOvA antineutrino results. Altogether, the results from NOvA only show a very mild preference for NO.
- The favored values of $delta_"CP"$ in NO by T2K and NOvA do not agree. Consequently, the combination of both experiments is better described in IO with $delta_"CP" tilde.equiv 3 pi\/2$. This was already the case in NuFIT~5.0, and the tendency has strengthened with the updated results.

This is further illustrated in @fig:compare-dcp24, which shows the $Delta chi^2$ profiles as a function of $delta_"CP"$ for the LBL experiments T2K and NOvA and their combination (we also add the information from MBL reactors and from the IC atmospheric samples which we independently analyzed in NuFIT~5.0 and NuFIT~6.0, and will discuss in @sec:reacatm). Comparing the curves of T2K and NOvA in the upper and lower panels, we see that the main difference is in the NOvA neutrino results. Just by themselves, they disfavor NO and $delta_"CP" tilde.equiv 3 pi\/2$ by about 6 units in $chi^2$ (versus 3 units in NuFIT~5.0), whereas comparing the corresponding curves in the left panels we see that for IO the consistent preference of T2K and NOvA for $delta_"CP" tilde.equiv 3 pi\/2$ is now statistically more significant. Altogether, this drives the preference of the LBL combination for IO, with $Delta chi^2 ( "NO" - "IO" ) approx 3.2$ versus 1.5 in NuFIT~5.0.

// [figvision] imgs/Figures_fig-chisq-viola.pdf.wired.png - Delta chi^2 vs delta_CP.
// 2x2 panels: IO (left) and NO (right); upper NuFIT 5.0, lower NuFIT 6.0.
// Left: IO blue and NO red solid/dashed curves, IO minimum near 90 deg and NO
//   near 270 deg with a shallow second minimum.
// Right: NO curves minimum near 180 deg with a secondary minimum at 270 deg;
//   global (cyan) curve overlaid. Dashed curves use IC24.
#figure(placement: top, 
  image("imgs/Figures_fig-chisq-viola.pdf.wired.png", width: 100%),
  caption: [$Delta chi^2$ profiles as a function of $delta_"CP"$ for different data sets and combinations as labeled in the figure. In the curves where the reactors $R$ are not included in the combination we have fixed $sin^2 theta_13 = 0.0222$ as well as the solar parameters and minimized with respect to $theta_23$ and $|Delta m^2_(3 ell)|$. When the reactors are included $theta_13$ is also marginalized. Left (right) panels are for IO (NO) and $Delta chi^2$ is shown with respect to the global best-fit point for each curve. Upper panels are for the NuFIT~5.0 data set, whereas lower panels correspond to the current update.],
) <fig:compare-dcp24>

// [figvision] imgs/fig-snq23_dCP.png - T2K/NOvA region in (delta_CP, sin^2 theta_23).
// IO (left) and NO (right); sin^2 theta_23 0.35-0.65, delta_CP 0-360 deg.
// NOvA 1sigma/2sigma blue shading, T2K salmon/red shading, combined contour
// dashed black. IO: compact region near delta ~270 and sin^2 theta_23 ~0.55,
// with a lower lobe at 0.46. NO: broad blue band across all delta_CP with
// combined lobes near 180 and 270 deg.
#figure(placement: top, image("imgs/fig-snq23_dCP.png", width: 70%),
  caption: [
 $1 sigma$ and $2 sigma$ allowed regions (2 dof) for T2K (red shading), NOvA (blue shading) and their combination (black curves). Contours are defined with respect to the local minimum for IO (left) or NO (right). We fix $sin^2 theta_13 = 0.0222$, $sin^2 theta_12 = 0.31$, $Delta m^2_(21)=7.5times 10^(-5)~"eV"$ and minimize with respect to $|Delta m^2_(3 ell)|$.
  ]
) <fig:sq23-dCP24>

The two-dimensional regions for T2K and NOvA in the ($delta_"CP"$, $sin^2 theta_23$) plane for fixed $theta_13$ are shown in @fig:sq23-dCP24. The better consistency for IO is apparent. For NO we find that, unlike in NuFIT~5.0, the $1 sigma$ regions do not overlap. The 2-dimensional projections in the ($delta_"CP"$, $sin^2 theta_23$) plane from the global analysis of all data are shown in @fig:region-cp23, which resemble to a large extent the features from the combination among T2K and NOvA discussed above. We observe, in particular, non-trivial correlations between these two parameters and the MO. For IO, the preference for $delta_"CP" tilde.eq 270 degree$ is highly significant, whereas for NO a more complicated structure in the ($delta_"CP"$, $sin^2 theta_23$) plane, with several local minima, emerges. The octant degeneracy for $theta_23$ is present with $Delta chi^2 < 4$ for both mass orderings and both data variants, showing local minima around $sin^2 theta_23 approx 0.56$ and 0.47.

// [figvision] src/Figures/fig-region-cp23.pdf - global (delta_CP, sin^2 theta_23).
// IO (left) and NO (right); y 0.35-0.65, x 0-360 deg. Nested 1sigma, 90%, 2sigma,
// 99% and 3sigma contours (cyan, magenta, blue, pink, red) plus a black contour
// for the alternative analysis; star and triangle mark best fits.
// IO: compact lobe at delta ~270, sin^2 theta_23 ~0.55 with a lower lobe at 0.46.
// NO: several lobes near delta ~180 and 270 spanning sin^2 theta_23 0.45-0.55,
// plus a separate region near delta ~0 and sin^2 theta_23 ~0.6.
#figure(placement: top, image("src/Figures/fig-region-cp23.pdf", width: 90.0%),
  caption: [
  Two-dimensional projection of the allowed six-dimensional region from global data in the plane of ($delta_"CP"$, $sin^2 theta_23$) for IO (left) and NO (right) after minimization with respect to the undisplayed parameters. Regions for both orderings are defined with respect to the global best-fit point. The different contours correspond to $1 sigma$, 90%, $2 sigma$, 99%, $3 sigma$ CL (2 dof). Colored regions (black contours) correspond to the variant with IC19 and without SK-atm (with IC24 and with SK-atm).
  ]
) <fig:region-cp23>

An obvious question to address is whether T2K and NOvA are in tension with each other at a worrisome level. Consistency among different data sets can be quantified with the parameter goodness-of-fit (PG) @Maltoni:2003cu. For a number $N$ of different data sets $i$, each depending on $n_i$ model parameters, and globally depending on $n_("glob")$ parameters, it can be shown that the test statistic

$
  chi_"PG"^2 equiv chi_("min,glob")^2 - sum_i^N chi_("min", i)^2
  = min [ sum_i^N chi_i^2 ] - sum_i chi_("min", i)^2 ,
$

follows a $chi^2$ distribution with $n equiv sum_i n_i - n_("glob")$ degrees of freedom @Maltoni:2003cu.

Applying this test to the full NOvA and T2K samples (including both appearance and disappearance data for neutrinos and antineutrinos) we obtain the values in @tab:PG24. We carry out the analysis separately for each mass ordering, in all cases fixing $Delta m^2_(21)$ and $theta_12$ to their best fit. In the results reported in the upper part of the table $theta_13$ is varied in the minimization, so $n_("T2K") = n_("NOvA") = n_("glob=T2K+NOvA") = 4$ (#emph[i.e.], $Delta m^2_(3 ell)$, $theta_23$, $delta_"CP"$, and $theta_13$). In the lower part $theta_13$ is kept fixed to its best fit so $n_("T2K") = n_("NOvA") = n_("glob=T2K+NOvA") = 3$. From the table we read that, as expected, agreement is better in IO, where irrespective on $theta_13$ the samples are compatible at the $0.5 sigma$ level or better. In NO, compatibility arises at $1.7 sigma$ ($2.0 sigma$) for free (fixed) $theta_13$. This is to be compared with the NuFIT~5.0 results of $1.4 sigma$ ($1.7 sigma$) respectively. We conclude that the tension between T2K and NOvA in NO has slightly strengthened with the new results, reaching at most the $2 sigma$ level.

#figure(
  align(center)[#table(
    columns: 7,
    align: (left,center,center,center,center,center,center),
    [Data sets], table.cell(colspan: 3)[*Normal Ordering*], table.cell(colspan: 3)[*Inverted Ordering*],
    [], [$chi_"PG"^2\/n$], [$p$-value], [\# $sigma$], [$chi_"PG"^2\/n$], [$p$-value], [\# $sigma$],
    table.hline(),
    [T2K vs NOvA], [7.9/4], [0.093], [1.7], [2.3/4], [0.67], [0.42],
    [T2K vs React], [0.23/2], [0.89], [0.14], [1.7/2], [0.43], [0.79],
    [NOvA vs React], [1.1/2], [0.58], [0.56], [4.3/2], [0.12], [1.6],
    [T2K vs NOvA vs React], [8.6/6], [0.20], [1.3], [6.0/6], [0.42], [0.80],
    [(T2K & NOvA) vs React], [0.76/2], [0.68], [0.41], [3.4/2], [0.18], [1.3],
    [T2K vs IC19], [2.7/4], [0.61], [0.51], [1.2/4], [0.88], [0.15],
    [NOvA vs IC19], [3.3/4], [0.51], [0.66], [2.3/4], [0.68], [0.41],
    [Reac vs IC19], [2.1/2], [0.35], [0.93], [0.88/2], [0.64], [0.84],
    [NOvA vs T2K vs IC19], [11/8], [0.20], [1.3], [4.3/8], [0.83], [0.21],
    [NOvA vs T2K vs React vs IC19], [11.5/10], [0.33], [0.96], [7.2/10], [0.71], [0.38],
    table.hline(),
    [T2K vs NOvA], [8.0/3], [0.045], [2.0], [1.8/3], [0.61], [0.50],
    [T2K vs NOvA vs React], [8.3/4], [0.081], [1.7], [4.1/4], [0.39], [0.85],
    [(T2K & NOvA) vs React], [0.25/1], [0.62], [0.50], [2.0/1], [0.16], [1.4],
    [T2K vs IC19], [0.72/3], [0.86], [0.16], [0.2/3], [0.98], [0.028],
    [NOvA vs IC19], [1.5/3], [0.68], [0.41], [1.0/3], [0.80], [0.25],
    [NOvA vs T2K vs IC19], [9.3/6], [0.16], [1.4], [2.4/6], [0.88], [0.15],
    [NOvA vs T2K vs React vs IC19], [9.4/7], [0.22], [1.2], [4.5/7], [0.72], [0.36],
    [NOvA vs T2K vs IC24], [9.5/6], [0.15], [1.4], [4.4/6], [0.62], [0.49],
    [NOvA vs T2K vs React vs IC24], [10/7], [0.19], [1.3], [8.2/7], [0.27], [1.1],
  )],
  caption: [Consistency test among different data sets, shown in the first column, assuming either normal or inverted ordering. "React" includes Daya-Bay, RENO and Double-Chooz. In the analyses above the horizontal line, $theta_13$ is a free parameter, whereas below the line we have fixed $sin^2 theta_13 = 0.0222$. See text for more details.],
) <tab:PG24>

== Effects from $nu_mu\/macron(nu)_mu$ versus $macron(nu)_e$ disappearance <sec:reacatm>

// [figvision] src/Figures/fig-region-sample.pdf - 95.45% CL regions.
// Left column (two stacked): Delta m^2_31 (upper) and Delta m^2_32 (lower) vs
// sin^2 theta_23 (0.3-0.7). Contours: Super-K dashed light brown, T2K red,
// NOvA purple, IC19 orange, IC24 orange dashed, MINOS green; filled blue region
// is the accelerator+IC19 combination near (0.5, 2.5e-3 eV^2). Dashed horizontal
// split at zero.
// Right column: the same mass splittings vs sin^2 theta_13 (0.015-0.03) with
// DayaBay salmon, Double-Chooz magenta, RENO purple and the combined black
// filled ellipse near 0.022; "[2sigma]" label at lower right.
#figure(placement: top, image("src/Figures/fig-region-sample.pdf", width: 90.0%),
  caption: [
    Confidence regions at 95.45% CL (2~dof) in the plane of $sin^2 theta_23$ ($sin^2 theta_13$) and $Delta m^2_(3 ell))$ in the left (right) panels. For the left panels we use both appearance and disappearance data from MINOS (green), NOvA (purple) and T2K (red), as well as atmospheric data from IC (orange) and Super-Kamiokande (light-brown); the colored region corresponds to the combination of these accelerator data with IC19, whereas the black-dashed contour corresponds to the combination with IC24 and Super-Kamiokande. A prior on $theta_13$ is included to account for the reactor constraint. The right panels show regions using data from Daya-Bay (pink), Double-Chooz (magenta), RENO (violet), and their combination (black regions). In all panels solar, KamLAND and SNO+ data are included to constrain $Delta m^2_(21)$ and $theta_12$. Contours are defined with respect to the global minimum of the two orderings for each data set.
  ]
) <fig:regions-dis>

@fig:regions-dis shows the combined determination of the parameters $sin^2 theta_23$, $sin^2 theta_13$, and $Delta m^2_(3 ell)$ by the interplay of different data samples, namely $nu_mu \/ macron(nu)_mu$ disappearance from long-baseline accelerator and atmospheric neutrino data (left panel) and $macron(nu)_e$ disappearance from medium baseline reactor experiments (right panel). We observe significant synergy from the combination of different data sets (global regions are clearly smaller than individual ones) as well as appealing consistency. This is also reflected by the many compatibility tests reported in @tab:PG24, which all show very good consistency typically well below $2 sigma$.

#figure(placement: top, [
// [figvision] src/Figures/fig-chisq-dma-noIC.pdf - Delta chi^2 vs Delta m^2.
// Two stacked panels: Delta m^2_32 (negative, -3..-2.2) and Delta m^2_31
// (+2.2..3), units 1e-3 eV^2; dashed vertical references at +/-2.5.
// Top: Reactors black, MINOS green, NOvA purple, T2K red, LBL-comb blue; minima
// at -2.55/+2.55 (reactors) and -2.5/+2.5 (others). Bottom: Reactors black plus
// R+MINOS, R+NOvA, R+T2K and R+LBL-comb combinations.
#box(image("src/Figures/fig-chisq-dma-noIC.pdf", width: 49.0%))
// [figvision] src/Figures/fig-chisq-dma-ic.pdf - same axes, IC19 vs IC24.
// Solid = IC19, dashed = IC24. Top: Reactors black, LBL-comb blue, IceCube
// orange (broad, minimum near -2.45), Global cyan (narrow, -2.5/+2.5). Bottom:
// R+ versions; the IceCube curve is shallower and the global curves remain near
// +/-2.5.
#box(image("src/Figures/fig-chisq-dma-ic.pdf", width: 49.0%))],
  caption: [
    $Delta chi^2$ profiles as a function of $Delta m^2_(3 ell)$ for different data sets and combinations as labeled in the figures. In the curves where the reactors $R$ are not included in the combination we have fixed $sin^2 theta_13 = 0.0222$ as well as the solar parameters and minimized with respect to $theta_23$ and $delta_"CP"$. When the reactors are included $theta_13$ is also marginalized. $Delta chi^2$ is shown with respect to the global best-fit point (IO or NO) for each curve. The left set of panels visualizes the reactor/LBL combination, whereas in the right set of panels we are illustrating the impact of the IC19 or IC24 data sets.
  ]
) <fig:chisq-dma>

As in previous analyses, the combination of $nu_mu$ and $macron(nu)_mu$ disappearance data (dominated by LBL accelerator experiments) with $macron(nu)_e$ disappearance from reactors provides complementary information, which is especially relevant for the MO discrimination @Nunokawa:2005nx @Minakata:2006gq.  In short, the effective mass-squared difference relevant for each survival probability depends on the mass ordering, so a global combination allows in principle to determine it. This effect can be seen in 1-dimensional $chi^2$ projections on the parameter $Delta m^2_(3 ell)$, as shown in @fig:chisq-dma.

In the upper panels we show the profiles for various individual data sets. We observe that, individually, the considered data are either insensitive to the MO ($Delta chi^2 < 1$) or show a slight preference for NO. The only exception is the LBL/IC combination, which prefers IO due to the T2K/NOvA tension discussed above. However, by comparing the LBL and reactor results, we observe that the determination of $|Delta m^2_(3 ell)|$ is in better agreement for NO than for IO. Hence, combining reactor and LBL data (bottom-left panels) increases the value of $Delta chi_"IO,NO"^2 equiv chi_"min,IO"^2 - chi_"min,NO"^2$ in favor of NO. As a result, the preference for IO from the T2K/NOvA combination (dominated by appearance data) is nearly exactly compensated by the effects of disappearance data in the LBL/reactor combination, leading to a global result of $Delta chi_"IO,NO"^2 = - 0.6$.

The preference for NO from the accelerator/reactor combination is also visible in the PG tests in @tab:PG24, by considering the consistency among the combined T2K & NOvA sample and reactors. For both $theta_13$ free and fixed, there is slightly better compatibility for NO than IO (although even for IO consistency is very good, $1.3 sigma$ or $1.4 sigma$). This preference is only visible when combining T2K and NOvA #emph[before] testing the consistency (#emph[i.e.], the rows labeled \<\<(T2K & NOvA) vs React\>\>). Otherwise, if they are kept separate (#emph[i.e.], the rows labeled \<\<T2K vs NOvA vs React\>\>) the opposite trend from the combination among T2K and NOvA appearance samples compensates for the tendency from disappearance data.

In the right half of @fig:chisq-dma, we show the impact of the different IceCube data samples. It is clear from the figure that the IC19 3-year data sample @IceCube:2019dyb @IceCube:2019dqi plays very little role in the $nu_mu \/ nu_e$ disappearance complementarity due to its relatively weak constraint on $|Delta m^2_(3 ell)|$. However, when combining the IC24 $chi^2$ table corresponding to 9.3 years of data @IceCube:2024xjj @IC:data2024 with reactor data, this complementarity @Blennow:2013vta @IC:data2024 already provides a preference for NO, with $Delta chi_"IO,NO"^2 approx 4.5$. The result is entirely driven by the $|Delta m^2_(3 ell)|$ determination, as the $chi^2$ tables provided by the collaboration contain no information on the IceCube MO sensitivity (they only provide relative $Delta chi^2$ values with respect to the best fit #emph[in each ordering]). Let us remark, however, that the $Delta chi_"IO,NO"^2 = 4.5$ contribution from combining IC24 and reactors does not simply add up to the value $Delta chi_"IO,NO"^2 = - 0.6$ from combining LBL and reactors. Instead, combining LBL and IC24 leads to a shift in $|Delta m^2_(3 ell)|$ that, when adding reactor data, leads to $Delta chi_"IO,NO"^2 approx 1.5$.

Different to the IC24 data table, the latest Super-Kamiokande atmospheric data @SKatm:data2024 alone shows a preference for NO with $Delta chi_"IO,NO"^2 approx 5.7$. We note, however, that this result seems to emerge from a large statistical fluctuation. Indeed, the probability of obtaining the data is relatively low for both mass orderings, and considering the distribution of the relevant test statistic, the SK collaboration determines a preference for NO over IO at the 92.3%~CL @Super-Kamiokande:2023ahc.  When combining the IC24 and SK atmospheric  $chi^2$ tables with our global fit of the remaining data, we find an overall preference for NO with $Delta chi_"IO,NO"^2 approx 6.1$, see #ref(<sec:global24>, supplement: none).

== Sensitivity to the neutrino mass ordering <sec:MO>

Given the different trends among several determinations of the mass ordering, we now study in more detail the sensitivity of current global data to it. To do so, we follow the methodology in @Blennow:2013oma. As customary, a useful test statistic for this purpose is the $chi^2$ difference among the best-fit points for the two orderings. Following @Blennow:2013oma, we denote it in this Section as $T$,

$
  T equiv Delta chi_"IO,NO"^2 equiv chi_"min,IO"^2 - chi_"min,NO"^2 .
$

Hence, positive values of $T$ favor NO, and negative values favor IO. As shown in @Blennow:2013oma, @Qian:2012zn, under certain conditions $T$ will follow a Gaussian distribution with mean $plus.minus T_0$ and standard deviation $2 sqrt(T_0)$, where $T_0$ is obtained as follows. If $p_i ( o theta )$ is the expected number of events in bin $i$ (where $o in { "NO" "IO" }$ is the mass ordering and $theta$ are the remaining oscillation parameters), $d_i$ is the observed number of events in that bin, and the global $chi^2$ is given by $chi^2 = chi^2 [ p_i (o, theta) ; d_i ]$, then

$
  T_0^"NO" equiv min_theta \{ chi^2 [ p_i ("IO", theta) ; p_i ("NO", theta^"true") ] \} ,
  \
  T_0^"IO" equiv min_theta \{ chi^2 [ p_i ("NO", theta) ; p_i ("IO", theta^"true") ] \} .
$ <eq:T0def>

That is, $T_0$ is determined by replacing the data by the prediction for the opposite mass ordering, given some assumed true values of oscillation parameters. Defined this way, $T_0^o$ is always positive. Hence, for true NO (IO) the expected value of $T$ is $+ T_0^"NO"$ ($- T_0^"IO"$). The conditions under which the aforementioned Gaussian approximation holds are discussed in detail in the Appendix of @Blennow:2013oma, and they are similar to the conditions for Wilks' theorem. In the following, we will study the results of the global fit under the assumption that $T$ is indeed Gaussian-distributed. In addition, the values of $T_0^o$ defined in @eq:T0def depend on the (unknown) true values of the oscillation parameters $theta^"true"$. In the following, we will take them to be the best-fit points of our analysis as given in @tab:bfranges24; we comment on this assumption in Appendix~#ref(<sec:app-T>, supplement: none).

#figure(
  table(
    columns: 5,
    align: center,
    stroke: none,
    inset: (x: 3pt, y: 6.5pt),
    table.hline(stroke: 1pt),
    table.cell(colspan: 5, align: left)[*IC19 without SK atmospheric data*],
    [], table.cell(colspan: 2)[Normal Ordering ($Delta chi^2 = 0.6$)], table.cell(colspan: 2)[Inverted Ordering (best fit)],
    table.hline(stroke: 0.5pt),
    [], [bfp $plus.minus 1 sigma$], [$3 sigma$ range], [bfp $plus.minus 1 sigma$], [$3 sigma$ range],
    table.hline(stroke: 0.5pt),
    [$sin^2 theta_12$], [$0.307_(- 0.011)^(+ 0.012)$], [$0.275 arrow.r 0.345$], [$0.308_(- 0.011)^(+ 0.012)$], [$0.275 arrow.r 0.345$],
    [$theta_12\/degree$], [$33.68_(- 0.70)^(+ 0.73)$], [$31.63 arrow.r 35.95$], [$33.68_(- 0.70)^(+ 0.73)$], [$31.63 arrow.r 35.95$],
    [$sin^2 theta_23$], [$0.561_(- 0.015)^(+ 0.012)$], [$0.430 arrow.r 0.596$], [$0.562_(- 0.015)^(+ 0.012)$], [$0.437 arrow.r 0.597$],
    [$theta_23\/degree$], [$48.5_(- 0.9)^(+ 0.7)$], [$41.0 arrow.r 50.5$], [$48.6_(- 0.9)^(+ 0.7)$], [$41.4 arrow.r 50.6$],
    [$sin^2 theta_13$], [$0.02195_(- 0.00058)^(+ 0.00054)$], [$0.02023 arrow.r 0.02376$], [$0.02224_(- 0.00057)^(+ 0.00056)$], [$0.02053 arrow.r 0.02397$],
    [$theta_13\/degree$], [$8.52_(- 0.11)^(+ 0.11)$], [$8.18 arrow.r 8.87$], [$8.58_(- 0.11)^(+ 0.11)$], [$8.24 arrow.r 8.91$],
    [$delta_"CP"\/degree$], [$177_(- 20)^(+ 19)$], [$96 arrow.r 422$], [$285_(- 28)^(+ 25)$], [$201 arrow.r 348$],
    [$Delta m_21^2 \/ (10^(-5) "eV"^2)$], [$7.49_(- 0.19)^(+ 0.19)$], [$6.92 arrow.r 8.05$], [$7.49_(- 0.19)^(+ 0.19)$], [$6.92 arrow.r 8.05$],
    [$Delta m_(3 ell)^2 \/ (10^(-3) "eV"^2)$], [$+ 2.534_(- 0.023)^(+ 0.025)$], [$+ 2.463 arrow.r + 2.606$], [$- 2.510_(- 0.025)^(+ 0.024)$], [$- 2.584 arrow.r - 2.438$],
    table.hline(stroke: 1pt),
    table.cell(colspan: 5, align: left)[*IC24 with SK atmospheric data*],
    [], table.cell(colspan: 2)[Normal Ordering (best fit)], table.cell(colspan: 2)[Inverted Ordering ($Delta chi^2 = 6.1$)],
    table.hline(stroke: 0.5pt),
    [], [bfp $plus.minus 1 sigma$], [$3 sigma$ range], [bfp $plus.minus 1 sigma$], [$3 sigma$ range],
    table.hline(stroke: 0.5pt),
    [$sin^2 theta_12$], [$0.308_(- 0.011)^(+ 0.012)$], [$0.275 arrow.r 0.345$], [$0.308_(- 0.011)^(+ 0.012)$], [$0.275 arrow.r 0.345$],
    [$theta_12\/degree$], [$33.68_(- 0.70)^(+ 0.73)$], [$31.63 arrow.r 35.95$], [$33.68_(- 0.70)^(+ 0.73)$], [$31.63 arrow.r 35.95$],
    [$sin^2 theta_23$], [$0.470_(- 0.013)^(+ 0.017)$], [$0.435 arrow.r 0.585$], [$0.550_(- 0.015)^(+ 0.012)$], [$0.440 arrow.r 0.584$],
    [$theta_23\/degree$], [$43.3_(- 0.8)^(+ 1.0)$], [$41.3 arrow.r 49.9$], [$47.9_(- 0.9)^(+ 0.7)$], [$41.5 arrow.r 49.8$],
    [$sin^2 theta_13$], [$0.02215_(- 0.00058)^(+ 0.00056)$], [$0.02030 arrow.r 0.02388$], [$0.02231_(- 0.00056)^(+ 0.00056)$], [$0.02060 arrow.r 0.02409$],
    [$theta_13\/degree$], [$8.56_(- 0.11)^(+ 0.11)$], [$8.19 arrow.r 8.89$], [$8.59_(- 0.11)^(+ 0.11)$], [$8.25 arrow.r 8.93$],
    [$delta_"CP"\/degree$], [$212_(- 41)^(+ 26)$], [$124 arrow.r 364$], [$274_(- 25)^(+ 22)$], [$201 arrow.r 335$],
    [$Delta m_21^2 \/ (10^(-5) "eV"^2)$], [$7.49_(- 0.19)^(+ 0.19)$], [$6.92 arrow.r 8.05$], [$7.49_(- 0.19)^(+ 0.19)$], [$6.92 arrow.r 8.05$],
    [$Delta m_(3 ell)^2 \/ (10^(-3) "eV"^2)$], [$+ 2.513_(- 0.019)^(+ 0.021)$], [$+ 2.451 arrow.r + 2.578$], [$- 2.484_(- 0.020)^(+ 0.020)$], [$- 2.547 arrow.r - 2.421$],
    table.hline(stroke: 1pt),
  ),
  caption: [Three-flavor oscillation parameters from our fit to global data for the two variants of the analysis described in the text. The numbers in the 1st (2nd) column are obtained assuming NO (IO), _i.e._, relative to the respective local minimum. Note that $Delta m_(3 ell)^2 equiv Delta m_31^2 > 0$ for NO and $Delta m_(3 ell)^2 equiv Delta m_32^2 < 0$ for IO.],
) <tab:bfranges24>

#figure(cetz.canvas({
  import cetz.draw: *
  let w = 7.6
  let hb = 3.4
  let ht = 3.6
  let yt = hb + 0.95
  let fT = (x, l) => ((x + 18.0) / 36.0 * w, yt + (l + 4.3) / 4.35 * ht)
  let fB = (x, y) => ((x + 18.0) / 36.0 * w, y / 0.10 * hb)
  let gcol = rgb(150, 150, 150)
  let gst = (paint: gcol, thickness: .4pt)
  let ast = (paint: black, thickness: .8pt)
  let dst = (paint: black, thickness: .9pt, dash: "dashed")
  let crv = (f, pts, col) => line(..pts.chunks(2).map(p => f(p.at(0), p.at(1))), stroke: (paint: col, thickness: 1.1pt))
  let pIO = (-18.0,-0.001,-17.8,-0.001,-17.6,-0.001,-17.3,-0.001,-17.1,-0.001,-16.9,-0.002,-16.6,-0.002,-16.4,-0.002,-16.2,-0.003,-16.0,-0.003,-15.8,-0.003,-15.5,-0.004,-15.3,-0.004,-15.1,-0.005,-14.8,-0.006,-14.6,-0.007,-14.4,-0.008,-14.2,-0.009,-13.9,-0.010,-13.7,-0.011,-13.5,-0.012,-13.3,-0.014,-13.1,-0.016,-12.8,-0.018,-12.6,-0.020,-12.4,-0.022,-12.2,-0.024,-11.9,-0.027,-11.7,-0.030,-11.5,-0.033,-11.2,-0.037,-11.0,-0.041,-10.8,-0.045,-10.6,-0.049,-10.3,-0.054,-10.1,-0.059,-9.9,-0.064,-9.7,-0.070,-9.4,-0.076,-9.2,-0.083,-9.0,-0.090,-8.8,-0.098,-8.6,-0.106,-8.3,-0.115,-8.1,-0.124,-7.9,-0.133,-7.7,-0.143,-7.4,-0.154,-7.2,-0.165,-7.0,-0.177,-6.8,-0.190,-6.5,-0.203,-6.3,-0.216,-6.1,-0.231,-5.8,-0.246,-5.6,-0.262,-5.4,-0.278,-5.2,-0.295,-4.9,-0.313,-4.7,-0.332,-4.5,-0.351,-4.3,-0.371,-4.1,-0.392,-3.8,-0.413,-3.6,-0.436,-3.4,-0.459,-3.2,-0.483,-2.9,-0.508,-2.7,-0.534,-2.5,-0.560,-2.2,-0.587,-2.0,-0.616,-1.8,-0.645,-1.6,-0.675,-1.4,-0.705,-1.1,-0.737,-0.9,-0.770,-0.7,-0.803,-0.4,-0.838,-0.2,-0.873,0.0,-0.909,0.2,-0.947,0.4,-0.985,0.7,-1.024,0.9,-1.064,1.1,-1.105,1.4,-1.147,1.6,-1.190,1.8,-1.233,2.0,-1.278,2.2,-1.324,2.5,-1.371,2.7,-1.419,2.9,-1.467,3.1,-1.517,3.4,-1.568,3.6,-1.620,3.8,-1.672,4.1,-1.726,4.3,-1.781,4.5,-1.837,4.7,-1.894,4.9,-1.951,5.2,-2.010,5.4,-2.070,5.6,-2.131,5.9,-2.193,6.1,-2.256,6.3,-2.320,6.5,-2.385,6.8,-2.451,7.0,-2.518,7.2,-2.586,7.4,-2.656,7.6,-2.726,7.9,-2.797,8.1,-2.870,8.3,-2.943,8.6,-3.018,8.8,-3.093,9.0,-3.170,9.2,-3.247,9.4,-3.326,9.7,-3.406,9.9,-3.487,10.1,-3.569,10.4,-3.652,10.6,-3.736,10.8,-3.821,11.0,-3.907,11.2,-3.995)
  let pNO = (-12.2,-3.950,-11.9,-3.874,-11.7,-3.798,-11.5,-3.724,-11.2,-3.650,-11.0,-3.577,-10.8,-3.504,-10.6,-3.433,-10.3,-3.362,-10.1,-3.293,-9.9,-3.224,-9.7,-3.155,-9.4,-3.088,-9.2,-3.022,-9.0,-2.956,-8.8,-2.891,-8.6,-2.827,-8.3,-2.764,-8.1,-2.702,-7.9,-2.640,-7.7,-2.579,-7.4,-2.519,-7.2,-2.460,-7.0,-2.402,-6.8,-2.344,-6.5,-2.287,-6.3,-2.232,-6.1,-2.176,-5.8,-2.122,-5.6,-2.069,-5.4,-2.016,-5.2,-1.964,-4.9,-1.913,-4.7,-1.862,-4.5,-1.813,-4.3,-1.764,-4.1,-1.716,-3.8,-1.669,-3.6,-1.622,-3.4,-1.577,-3.2,-1.532,-2.9,-1.488,-2.7,-1.445,-2.5,-1.402,-2.2,-1.360,-2.0,-1.319,-1.8,-1.279,-1.6,-1.239,-1.4,-1.201,-1.1,-1.163,-0.9,-1.125,-0.7,-1.089,-0.4,-1.053,-0.2,-1.018,0.0,-0.984,0.2,-0.950,0.4,-0.917,0.7,-0.885,0.9,-0.854,1.1,-0.823,1.4,-0.793,1.6,-0.764,1.8,-0.735,2.0,-0.707,2.2,-0.680,2.5,-0.653,2.7,-0.628,2.9,-0.602,3.1,-0.578,3.4,-0.554,3.6,-0.531,3.8,-0.508,4.1,-0.486,4.3,-0.465,4.5,-0.444,4.7,-0.424,4.9,-0.405,5.2,-0.386,5.4,-0.368,5.6,-0.350,5.9,-0.333,6.1,-0.317,6.3,-0.301,6.5,-0.286,6.8,-0.271,7.0,-0.257,7.2,-0.243,7.4,-0.230,7.6,-0.217,7.9,-0.205,8.1,-0.193,8.3,-0.182,8.6,-0.172,8.8,-0.161,9.0,-0.152,9.2,-0.142,9.4,-0.133,9.7,-0.125,9.9,-0.117,10.1,-0.109,10.4,-0.102,10.6,-0.095,10.8,-0.088,11.0,-0.082,11.2,-0.076,11.5,-0.071,11.7,-0.066,11.9,-0.061,12.1,-0.056,12.4,-0.052,12.6,-0.048,12.8,-0.044,13.1,-0.040,13.3,-0.037,13.5,-0.034,13.7,-0.031,13.9,-0.028,14.2,-0.026,14.4,-0.023,14.6,-0.021,14.9,-0.019,15.1,-0.018,15.3,-0.016,15.5,-0.014,15.8,-0.013,16.0,-0.012,16.2,-0.010,16.4,-0.009,16.6,-0.008,16.9,-0.008,17.1,-0.007,17.3,-0.006,17.5,-0.005,17.8,-0.005,18.0,-0.004)
  let dIO = (-18.0,0.0012,-17.8,0.0014,-17.6,0.0017,-17.3,0.0019,-17.1,0.0022,-16.9,0.0025,-16.6,0.0029,-16.4,0.0033,-16.2,0.0038,-16.0,0.0043,-15.8,0.0048,-15.5,0.0055,-15.3,0.0062,-15.1,0.0069,-14.8,0.0078,-14.6,0.0087,-14.4,0.0097,-14.2,0.0108,-13.9,0.0120,-13.7,0.0133,-13.5,0.0147,-13.3,0.0161,-13.1,0.0177,-12.8,0.0194,-12.6,0.0212,-12.4,0.0231,-12.2,0.0251,-11.9,0.0272,-11.7,0.0294,-11.5,0.0317,-11.2,0.0341,-11.0,0.0366,-10.8,0.0392,-10.6,0.0418,-10.3,0.0445,-10.1,0.0472,-9.9,0.0500,-9.7,0.0528,-9.4,0.0556,-9.2,0.0584,-9.0,0.0612,-8.8,0.0640,-8.6,0.0667,-8.3,0.0693,-8.1,0.0719,-7.9,0.0743,-7.7,0.0767,-7.4,0.0789,-7.2,0.0809,-7.0,0.0828,-6.8,0.0845,-6.5,0.0860,-6.3,0.0874,-6.1,0.0885,-5.8,0.0894,-5.6,0.0900,-5.4,0.0905,-5.2,0.0907,-4.9,0.0906,-4.7,0.0903,-4.5,0.0898,-4.3,0.0891,-4.1,0.0881,-3.8,0.0869,-3.6,0.0856,-3.4,0.0840,-3.2,0.0822,-2.9,0.0802,-2.7,0.0781,-2.5,0.0759,-2.2,0.0735,-2.0,0.0710,-1.8,0.0684,-1.6,0.0658,-1.4,0.0631,-1.1,0.0603,-0.9,0.0575,-0.7,0.0547,-0.4,0.0519,-0.2,0.0491,0.0,0.0463,0.2,0.0436,0.4,0.0409,0.7,0.0383,0.9,0.0358,1.1,0.0333,1.4,0.0310,1.6,0.0287,1.8,0.0265,2.0,0.0244,2.2,0.0225,2.5,0.0206,2.7,0.0188,2.9,0.0172,3.1,0.0156,3.4,0.0142,3.6,0.0128,3.8,0.0116,4.1,0.0104,4.3,0.0094,4.5,0.0084,4.7,0.0075,4.9,0.0067,5.2,0.0059,5.4,0.0053,5.6,0.0046,5.9,0.0041,6.1,0.0036,6.3,0.0032,6.5,0.0028,6.8,0.0024,7.0,0.0021,7.2,0.0018,7.4,0.0016,7.6,0.0014,7.9,0.0012,8.1,0.0010,8.3,0.0009,8.6,0.0007,8.8,0.0006,9.0,0.0005,9.2,0.0005,9.4,0.0004,9.7,0.0003,9.9,0.0003,10.1,0.0002,10.4,0.0002,10.6,0.0002,10.8,0.0001,11.0,0.0001,11.2,0.0001,11.5,0.0001,11.7,0.0001,11.9,0.0001,12.1,0.0000,12.4,0.0000,12.6,0.0000,12.8,0.0000,13.1,0.0000,13.3,0.0000,13.5,0.0000,13.7,0.0000,13.9,0.0000,14.2,0.0000,14.4,0.0000,14.6,0.0000,14.9,0.0000,15.1,0.0000,15.3,0.0000,15.5,0.0000,15.8,0.0000,16.0,0.0000,16.2,0.0000,16.4,0.0000,16.6,0.0000,16.9,0.0000,17.1,0.0000,17.3,0.0000,17.5,0.0000,17.8,0.0000,18.0,0.0000)
  let dNO = (-18.0,0.0000,-17.8,0.0000,-17.6,0.0000,-17.3,0.0000,-17.1,0.0000,-16.9,0.0000,-16.6,0.0000,-16.4,0.0000,-16.2,0.0000,-16.0,0.0000,-15.8,0.0000,-15.5,0.0000,-15.3,0.0000,-15.1,0.0000,-14.8,0.0000,-14.6,0.0000,-14.4,0.0000,-14.2,0.0000,-13.9,0.0000,-13.7,0.0000,-13.5,0.0000,-13.3,0.0000,-13.1,0.0000,-12.8,0.0001,-12.6,0.0001,-12.4,0.0001,-12.2,0.0001,-11.9,0.0001,-11.7,0.0001,-11.5,0.0001,-11.2,0.0002,-11.0,0.0002,-10.8,0.0002,-10.6,0.0003,-10.3,0.0003,-10.1,0.0004,-9.9,0.0004,-9.7,0.0005,-9.4,0.0006,-9.2,0.0006,-9.0,0.0007,-8.8,0.0008,-8.6,0.0010,-8.3,0.0011,-8.1,0.0013,-7.9,0.0014,-7.7,0.0016,-7.4,0.0018,-7.2,0.0021,-7.0,0.0024,-6.8,0.0026,-6.5,0.0030,-6.3,0.0033,-6.1,0.0037,-5.8,0.0042,-5.6,0.0046,-5.4,0.0052,-5.2,0.0057,-4.9,0.0063,-4.7,0.0070,-4.5,0.0077,-4.3,0.0085,-4.1,0.0094,-3.8,0.0103,-3.6,0.0112,-3.4,0.0123,-3.2,0.0134,-2.9,0.0145,-2.7,0.0158,-2.5,0.0171,-2.2,0.0185,-2.0,0.0200,-1.8,0.0215,-1.6,0.0231,-1.4,0.0248,-1.1,0.0265,-0.9,0.0283,-0.7,0.0302,-0.4,0.0321,-0.2,0.0341,0.0,0.0361,0.2,0.0381,0.4,0.0402,0.7,0.0424,0.9,0.0445,1.1,0.0467,1.4,0.0489,1.6,0.0511,1.8,0.0532,2.0,0.0554,2.2,0.0575,2.5,0.0595,2.7,0.0616,2.9,0.0635,3.1,0.0654,3.4,0.0672,3.6,0.0690,3.8,0.0706,4.1,0.0721,4.3,0.0735,4.5,0.0748,4.7,0.0759,4.9,0.0769,5.2,0.0778,5.4,0.0785,5.6,0.0791,5.9,0.0795,6.1,0.0797,6.3,0.0798,6.5,0.0797,6.8,0.0795,7.0,0.0791,7.2,0.0785,7.4,0.0778,7.6,0.0769,7.9,0.0759,8.1,0.0748,8.3,0.0735,8.6,0.0721,8.8,0.0706,9.0,0.0690,9.2,0.0672,9.4,0.0654,9.7,0.0635,9.9,0.0616,10.1,0.0595,10.4,0.0575,10.6,0.0554,10.8,0.0532,11.0,0.0511,11.2,0.0489,11.5,0.0467,11.7,0.0445,11.9,0.0424,12.1,0.0402,12.4,0.0381,12.6,0.0361,12.8,0.0341,13.1,0.0321,13.3,0.0302,13.5,0.0283,13.7,0.0265,13.9,0.0248,14.2,0.0231,14.4,0.0215,14.6,0.0200,14.9,0.0185,15.1,0.0171,15.3,0.0158,15.5,0.0145,15.8,0.0134,16.0,0.0123,16.2,0.0112,16.4,0.0103,16.6,0.0094,16.9,0.0085,17.1,0.0077,17.3,0.0070,17.5,0.0063,17.8,0.0057,18.0,0.0052)
  let fIO = (-5.1,0.0000,-4.9,0.0906,-4.7,0.0903,-4.5,0.0898,-4.3,0.0891,-4.1,0.0881,-3.8,0.0869,-3.6,0.0856,-3.4,0.0840,-3.2,0.0822,-2.9,0.0802,-2.7,0.0781,-2.5,0.0759,-2.2,0.0735,-2.0,0.0710,-1.8,0.0684,-1.6,0.0658,-1.4,0.0631,-1.1,0.0603,-0.9,0.0575,-0.7,0.0547,-0.4,0.0519,-0.2,0.0491,0.0,0.0463,0.0,0.0000)
  let fNO = (0.0,0.0000,0.0,0.0361,0.2,0.0381,0.4,0.0402,0.7,0.0424,0.9,0.0445,1.1,0.0467,1.4,0.0489,1.6,0.0511,1.8,0.0532,2.0,0.0554,2.2,0.0575,2.5,0.0595,2.7,0.0616,2.9,0.0635,3.1,0.0654,3.4,0.0672,3.6,0.0690,3.8,0.0706,4.1,0.0721,4.3,0.0735,4.5,0.0748,4.7,0.0759,4.9,0.0769,5.2,0.0778,5.4,0.0785,5.6,0.0791,5.9,0.0795,6.1,0.0797,6.3,0.0798,6.3,0.0000)
  // ---- top panel (p-value, log scale) ----
  rect(fT(-18, -4.3), fT(18, 0.05), stroke: ast, fill: none)
  for l in (-3.0, -2.0, -1.0) { line(fT(-18, l), fT(18, l), stroke: gst) }
  for l in range(-4, 1) {
    line(fT(-18, l + 0.0), (fT(-18, l).at(0) + 0.16, fT(-18, l).at(1)), stroke: ast)
    line((fT(18, l).at(0) - 0.16, fT(18, l).at(1)), fT(18, l), stroke: ast)
    content(fT(-18, l), anchor: "east", offset: (-0.12cm, 0), std.text(size: 8pt, if l == 0 { [$10^0$] } else { [$10^(-#(str(-int(l))))$] }))
  }
  for x in (-15, -10, -5, 0, 5, 10, 15) {
    line(fT(x, -4.3), (fT(x, -4.3).at(0), fT(x, -4.3).at(1) + 0.16), stroke: ast)
    line((fT(x, 0.05).at(0), fT(x, 0.05).at(1) - 0.16), fT(x, 0.05), stroke: ast)
  }
  for x in range(-17, 18) {
    line(fT(x, -4.3), (fT(x, -4.3).at(0), fT(x, -4.3).at(1) + 0.07), stroke: ast)
    line((fT(x, 0.05).at(0), fT(x, 0.05).at(1) - 0.07), fT(x, 0.05), stroke: ast)
  }
  rect(fT(-13.2, -3), fT(-9.2, -2), fill: rgb(255, 255, 0), stroke: none)
  rect(fT(-9.2, -3), fT(-4.6, -2), fill: rgb(102, 255, 51), stroke: none)
  rect(fT(-4.6, -1), fT(-1.3, 0.0), fill: rgb(255, 255, 0), stroke: none)
  rect(fT(-1.3, -1), fT(3.5, 0.0), fill: rgb(102, 255, 51), stroke: none)
  rect(fT(3.5, -1), fT(13.5, 0.0), fill: rgb(255, 255, 0), stroke: none)
  crv(fT, pIO, blue)
  crv(fT, pNO, red)
  // ---- bottom panel (T distribution) ----
  rect(fB(-18, 0), fB(18, 0.10), stroke: ast, fill: none)
  for y in (0.02, 0.04, 0.06, 0.08) { line(fB(-18, y), fB(18, y), stroke: gst) }
  for y in (0.0, 0.02, 0.04, 0.06, 0.08, 0.10) {
    line(fB(-18, y), (fB(-18, y).at(0) + 0.16, fB(-18, y).at(1)), stroke: ast)
    line((fB(18, y).at(0) - 0.16, fB(18, y).at(1)), fB(18, y), stroke: ast)
    content(fB(-18, y), anchor: "east", offset: (-0.12cm, 0), std.text(size: 8pt, if y == 0.0 { "0.00" } else { if y == 0.1 { "0.10" } else { str(y) } }))
  }
  for x in (-15, -10, -5, 0, 5, 10, 15) {
    line(fB(x, 0), (fB(x, 0).at(0), fB(x, 0).at(1) + 0.16), stroke: ast)
    content(fB(x, 0), anchor: "north", offset: (0, -0.12cm), std.text(size: 8pt, str(int(x))))
  }
  for x in range(-17, 18) {
    line(fB(x, 0), (fB(x, 0).at(0), fB(x, 0).at(1) + 0.07), stroke: ast)
    line((fB(x, 0.10).at(0), fB(x, 0.10).at(1) - 0.07), fB(x, 0.10), stroke: ast)
  }
  let fillpoly(pts, f, col) = {
    line(..pts.chunks(2).map(p => f(p.at(0), p.at(1))), closed: true, fill: col, stroke: none)
  }
  fillpoly(fIO, fB, rgb(140, 140, 255))
  fillpoly(fNO, fB, rgb(255, 140, 140))
  line(fB(0.0, 0.0), fB(-5.1, 0.0), stroke: (paint: black, thickness: .9pt, dash: "dashed"))
  line(fB(0.0, 0.0), fB(6.3, 0.0), stroke: (paint: black, thickness: .9pt, dash: "dashed"))
  line(fB(0.0, 0.0), fB(0.0, 0.10), stroke: (paint: black, thickness: 1.6pt))
  line(fB(-5.1, 0.0), (fB(-5.1, 0.0).at(0), yt - 0.0), stroke: (paint: black, thickness: .9pt, dash: "dashed"))
  line(fB(6.3, 0.0), (fB(6.3, 0.0).at(0), yt - 0.0), stroke: (paint: black, thickness: .9pt, dash: "dashed"))
  line(fB(0.0, 0.0), (fB(0.0, 0.0).at(0), yt + ht), stroke: (paint: black, thickness: 1.6pt))
  let fillpoly(pts, f, col) = {
    line(..pts.chunks(2).map(p => f(p.at(0), p.at(1))), closed: true, fill: col, stroke: none)
  }
  crv(fB, dIO, blue)
  crv(fB, dNO, red)
  // ---- axis labels ----
  content((-0.72, yt + ht / 2), anchor: "center", std.rotate(90deg, std.text(size: 10pt, [$p$-value])))
  content((-0.72, hb / 2), anchor: "center", std.rotate(90deg, std.text(size: 10pt, [$T$ distribution])))
  content((w / 2, -0.85), anchor: "center", std.text(size: 10pt, [$T = chi^2_"IO,min" - chi^2_"NO,min"$]))
  // ---- legend ----
  let lx = w + 0.55
  let ly = yt + ht / 2 - 0.3
  rect((lx - 0.25, ly - 1.55), (lx + 3.1, ly + 1.15), stroke: (paint: gcol, thickness: .6pt), fill: none)
  line((lx, ly + 0.75), (lx + 0.9, ly + 0.75), stroke: (paint: blue, thickness: 1.4pt))
  content((lx + 1.1, ly + 0.75), anchor: "west", std.text(size: 9pt, [IO]))
  line((lx, ly + 0.25), (lx + 0.9, ly + 0.25), stroke: (paint: red, thickness: 1.4pt))
  content((lx + 1.1, ly + 0.25), anchor: "west", std.text(size: 9pt, [NO]))
  line((lx, ly - 0.25), (lx + 0.9, ly - 0.25), stroke: (paint: black, thickness: 1.1pt, dash: "dashed"))
  content((lx + 1.1, ly - 0.25), anchor: "west", std.text(size: 9pt, [median]))
  line((lx, ly - 0.75), (lx + 0.9, ly - 0.75), stroke: (paint: black, thickness: 1.8pt))
  content((lx + 1.1, ly - 0.75), anchor: "west", std.text(size: 9pt, [observed value]))
}),
  caption: [
    $p$-values (top) and distributions (bottom) for the test statistic $T = chi_"IO,min"^2 - chi_"NO,min"^2$ corresponding to the \<\<IC19 w/o SK-atm\>\> analysis, assuming true NO (red) or true IO (blue). The observed value $T_"obs" = - 0.6$ is shown by the solid vertical black line. The corresponding median values are shown by the dashed vertical lines. The green and yellow bands in the top panel ---vertically displaced to avoid graphical overlap--- correspond to the $1 sigma$ and $2 sigma$ intervals for $T$ assuming NO (upwards displaced bands) and IO (downwards displaced bands).
  ]
) <fig:T-test>

This analysis cannot be carried out for the atmospheric neutrino data samples IC24 and Super-Kamiokande, which are included in our global comprehensive fit as numerical $chi^2$ tables. Therefore, in what follows we only consider the data sample denoted by \<\<IC19 w/o SK-atm\>\>.#footnote[This is unfortunate, as the IC24 and SK samples provide relevant sensitivity to the MO (see above).] For the global data combination, we find

$
  T_0^"NO" = 6.47 space space space T_0^"IO" = 4.85
$
<eq:T0>

The corresponding normal distributions for $T$ are shown in the bottom panel of @fig:T-test. For an observed value $T_"obs"$, we compute the $p$-value for a given mass ordering as usual: the $p$-value for IO (NO) is the probability to obtain a value of $T$ larger (smaller) than $T_"obs"$ if the true ordering is IO (NO). Given the observed value for the global fit, $T_"obs" = - 0.6$, the corresponding $p$-values are indicated by shaded areas in the lower panel of @fig:T-test and can be read off from the intersection of the red and blue curves with the $T_"obs"$ value in the upper panel:

$ "NO:" p_"NO" &= 8.2 \%, quad 91.8\% "CL", quad 1.7 sigma \
  "IO:" p_"IO" &= 16.7 \%, quad 83.3\% "CL", quad 1.4 sigma $

As expected for $| T_"obs" | < 1$, the $p$-values for both orderings are similar and we cannot significantly favor one over the other. Indeed, none of the orderings can be rejected at relevant significance; we obtain $p$-values below $2 sigma$ for both orderings, with a slightly smaller $p$-value for NO due to the negative value of $T_"obs"$.

Given the distribution for $T$, we can estimate the sensitivity of the considered data set. In particular, the median sensitivity is obtained by assuming that $T_"obs"$ is given by the mean value of $T$ for a given mass ordering. Hence, the median p-value is given by the intersection of the dashed lines with the corresponding red or blue curves in the top panel of @fig:T-test,

$ "NO:" p_"NO"^"med" &= 1.3 \%, quad 98.7\% "CL", quad 2.5 sigma \
  "IO:" p_"IO"^"med" &= 0.51 \%, quad 99.49\% "CL", quad 2.8 sigma $

= Updates in the "12" sector <sec:solar>

The analyses of the solar experiments and of reactor experiments at $cal(O) ( 100 med "km" )$ distance (which we refer to as LBL reactor experiments) give the dominant contribution to the determination of $Delta m^2_(21)$ and $theta_12$. We show in @fig:sun-tension24 the present determination of these parameters from the global solar analysis in comparison with that of LBL reactor data.

In the solar neutrino sector, new data included since NuFIT~5.0 are the full day-night spectrum from the phase-IV of Super-Kamiokande @Cravens:2008aa, and the final spectra from Borexino phases-II @Borexino:2017rsf and III @BOREXINO:2022abl. As for the predictions required for the solar neutrino analysis, the main update is that we have employed the new generation of Standard Solar Models @B23Fluxes. In brief, for the last two decades solar modeling has suffered from the so-called solar composition problem, associated with the choice of the input for heavy element abundances. They were either taken from the older results from @Grevesse1998 (GS98), which implied a higher metallicity and predicted solar properties in good agreement with helioseismology observations, or the newer abundances (obtained with more modern methodology and techniques) summarized in @Asplund2009 (AGSS09), which implied a lower metallicity and did not agree with helioseismology. Consequently, two different sets of Standard Solar Models were built, each based on the corresponding set of solar abundances @Serenelli:2009yc @Serenelli:2011py @Vinyoles:2016djt. On this front, an update of the AGSS09 results was presented by the same group (AAG21) @Asplund2021, leading only to a slight increase of the solar metallicity. On top of that, a new set of results (MB22)@Magg:2022rxb ---~based on similar methodologies and techniques but with different atomic input data for the critical oxygen lines, among other differences~--- led to a substantial change in solar element abundances with respect to AGSS09, more in agreement with those from GS98. Therefore, the models built following MB22 provide a good description of helioseismology results.

// [figvision] src/Figures/fig-sun-tension.pdf - solar vs KamLAND/SNO+ parameters.
// Left: Delta m^2_21 (0-14)e-5 eV^2 vs sin^2 theta_12 (0.2-0.4). Filled solar
// contours for MB22 (best fit black star), dashed void contours for AAG21
// (white-dot best fit), green KamLAND+SNO+ contours (green star), orange MB22
// without SK day-night data, plus cyan/magenta/navy/pink solar CLs; ellipses
// centred near sin^2 theta_12 ~0.30 and Delta m^2_21 ~6-7.5e-5. Annotation
// sin^2 theta_13 = 0.0222.
// Right: Delta chi^2 vs Delta m^2_21 (2-10): MB22m w/o D/N from SK (orange),
// MB22m (red), AAG21 (black dashed), KamLAND (green), SNO+ (blue), KL & SNO+
// (light green); minima near 4.6, 5.9, 6.0, 7.5 and 9 respectively.
#figure(placement: top, image("src/Figures/fig-sun-tension.pdf", width: 90.0%),
  caption: [
    Left: Allowed parameter regions (at $1 sigma$, 90%, $2 sigma$, 99%, and $3 sigma$ CL for 2 dof) from the combined analysis of solar data for MB22-met model (full regions with best fit marked by black star) and AAG21 model (dashed void contours with best fit marked by a white dot), and for the analysis of the combination of KamLAND and SNO+ data (solid green contours with best fit marked by a green star) for fixed $sin^2 theta_13 = 0.0222$. For comparison we also show as orange contours the results obtained with the MB22-met model without including the results of the day-night variation in SK. Right: $Delta chi^2$ dependence on $Delta m^2_(21)$ for the same four analyses after marginalizing over $theta_12$. In addition we show separately the results from KamLAND and SNO+.
  ]
) <fig:sun-tension24>

In @fig:sun-tension24 we show the present determination of $Delta m^2_(21)$ and $theta_12$ from the global solar analysis performed with the two extreme versions of the Standard Solar Model, namely the one based on the AAG21 abundances and the one based on the MB22-met abundances. From the figure, we see that the determination of the parameters is robust under the changes in the modeling, though the allowed ranges ---~particularly at higher CL~--- is different for the two models. In this respect, it is important to point out that the latest Standard-Solar-Model-independent determination of the solar fluxes performed in @Gonzalez-Garcia:2023kva shows better agreement with the predictions of the MB22 models. For this reason, we adopt the MB22 as the reference model employed for the results reported in NuFIT~6.0.

= Projections on neutrino mass scale observables <sec:absmass>

// [figvision] imgs/fig-region-mbeta-K.png - absolute neutrino mass probes.
// 2x3 log-log panels (NO red, IO blue, grey diagonal reference).
// Top: sum m_nu vs m_light; m_nu_e vs m_light (NO plateau ~0.01 eV, IO ~0.05 eV);
//   m_ee vs m_light (IO band 0.02-0.05 eV; NO band 1e-4-0.02 eV with a notch).
// Bottom: m_nu_e vs sum m_nu; m_ee vs sum m_nu (nested NO/IO wedges); m_ee vs
//   m_nu_e with the same wedge structure. Allowed regions are 95% CL.
#figure(placement: top, image("imgs/fig-region-mbeta-K.png", width: 70%),
  caption: [Upper: 95% CL allowed ranges of the three probes of the absolute neutrino mass $sum m_nu$, $m_(nu_e)$, $m_(e e)$ as a function of the mass of the lightest neutrino obtained from projecting the results of the global analysis of oscillation data. The regions are defined with respect to the minimum for each ordering. Lower: Corresponding 95% CL allowed regions (for 2 dof) in the planes ($m_(nu_e)$, $sum m_nu$), ($m_(e e)$, $sum m_nu$), and ($m_(nu_e)$, $m_(e e)$).],
) <fig:mprobes24>

Because of its quantum-interference nature, mass-induced flavor oscillations are sensitive to the phase differences induced by the mass-squared splittings $Delta m^2_(i j)$ and to misalignment between the detection and propagation eigenstates, #emph[i.e.], to the leptonic mixing matrix elements $U_(alpha j)$. They are, however, insensitive to overall shifts of the energy levels, and hence they cannot provide information on the absolute mass scale of the neutrinos other than the obvious lower bound on the masses of the heaviest states involved in the oscillations.

The most model-independent information on the neutrino mass, rather than on mass differences, is obtained from kinematic studies of reactions in which a neutrino or an antineutrino is involved. In the presence of mixing, the most relevant constraint comes from the study of the end point ($E tilde E_0$) of the electron spectrum in Tritium beta decay $""^3"H" arrow.r ""^3"He" + e^- + macron(nu)_e$. This spectrum can be effectively described by a single parameter, $m_(nu_e)$, if for all neutrino states $E_0 - E >> m_i$:

$ m_(nu_e)^2 equiv frac(sum_i m_i^2 |U_(e i)|^2, sum_i |U_(e i)|^2) = sum_i m_i^2 |U_(e i)|^2 , $ <eq:mbeta>

where the second equality holds if unitarity is assumed. The most recent result on the kinematic search for neutrino mass in tritium decay is from KATRIN @Katrin:2024tvg, which sets an upper limit $m_(nu_e) < 0.45 "eV"$ at 90% CL.

Direct information on neutrino masses can also be obtained from neutrinoless double beta decay $(A, Z) arrow.r (A, Z + 2) + e^- + e^-$. This process violates lepton number by two units, hence in order to induce the $0 nu beta beta$ decay, neutrinos must be Majorana particles. In particular, if the only effective lepton number violation at low energies is induced by a Majorana mass term for neutrinos, the rate of $0 nu beta beta$ decay is proportional to the #emph[effective Majorana mass of $nu_e$]:

$
  m_(e e) = abs(sum_i m_i U_(e i)^2) .
$

Currently the strongest bound on $0 nu beta beta$ decay lifetimes are obtained with Germanium ($T_(1 \/ 2)^(0 nu) > 1.8 times 10^26 "yr"$) by GERDA @GERDA:2020xhi and with Xenon ($T_(1 \/ 2)^(0 nu) > 3.8 times 10^26 "yr"$) by KamLAND-Zen @KamLAND-Zen:2024eml. Depending on the assumed nuclear matrix elements, these correspond to 90% CL limits of $m_(e e) lt.tilde 0.079$--$0.180$ eV @GERDA:2020xhi and $m_(e e) lt.tilde 0.028$--$0.122$ eV @KamLAND-Zen:2024eml, respectively.

Finally, neutrino masses also have effects in cosmology. In general, cosmological data mostly gives information on the sum of the neutrino masses, $sum m_nu$, while it has very little to say on their mixing structure and on the ordering of the mass states. At present, no positive evidence of the cosmological effect of a non-zero neutrino mass has been observed, which results into upper bounds on $sum m_nu$ in the range of $sum m_nu lt.tilde 0.04$--$0.3$ eV (see, #emph[e.g.], @Jiang:2024viw, @Naredo-Tuero:2024sgf and references therein for post-DESI @DESI:2024mwx global analyses) depending on, #emph[e.g.], the cosmological data included in the analysis, assumptions on the cosmological model, the statistical approach, the treatment of systematics, or parameter priors.

Within the $3 nu$-mixing scenario, for each mass ordering, the values of these observables can be directly predicted in terms of the parameters determined in the global oscillation analysis and a single mass scale, which is usually taken to be the lightest neutrino mass $m_0$. In addition, the prediction for $m_(e e)$ also depends on the unknown Majorana phases:

$
  m_(nu_e) = sqrt(m_1^2 c_13^2 c_12^2 + m_2^2 c_13^2 s_12^2 + m_3^2 s_13^2) ,
  \
  m_(e e) = abs(m_1 c_13^2 c_12^2 e^(2i (alpha_1 - delta_"CP")) + m_2 c_13^2 s_12^2 e^(2i (alpha_2 - delta_"CP")) + m_3 s_13^2) ,
  \
  sum m_nu = m_1 + m_2 + m_3 ,
  \
  "with" quad "NO:" m_1 = m_0 , quad m_2 = sqrt(m_0^2 + Delta m^2_(21)) , quad m_3 = sqrt(m_0^2 + Delta m^2_(3 ell)) ,
  \
  "IO:" m_3 = m_0 , quad m_2 = sqrt(m_0^2 - Delta m^2_(3 ell)) , quad m_1 = sqrt(m_0^2 - Delta m^2_(3 ell) - Delta m^2_(21)) .
$

We show in the upper panels in @fig:mprobes24 the 95% CL allowed ranges for these three probes obtained from the projection of the results of the NuFIT~6.0 global oscillation analysis as a function of $m_0$. The larger width of the regions for the $m_(e e)$ predictions is due to the unknown Majorana phases. The regions are shown including only the information from the oscillation data (void regions) and also in combination with the results from KATRIN (filled regions). For the latter, we build a $chi^2$ function trivially based on their quoted result $m_(nu_e)^2 = -0.14_(- 0.15)^(+ 0.13) "eV"$ under the assumptions of Gaussianity, applicability of Wilks' theorem (despite the physical boundary $m_(nu_e)^2 gt.eq 0$), and quadratic systematics. Under these assumptions, $chi^2 (m_(nu_e)) = (m_(nu_e)^2 + 0.14)^2 \/ 0.13^2$ yields a 90% CL upper bound $m_(nu_e) lt.eq 0.35 "eV"$ which lies in between the bounds $m_(nu_e) lt.eq 0.45 "eV"$ and $m_(nu_e) lt.eq 0.31 "eV"$ obtained by the collaboration with the Lokhov-Tkachov and Feldman-Cousins methods, respectively.

Using the above expressions, one can substitute $m_0$ by any of the three probes in the expressions of the other two. Thus, within the three-neutrino mixing scenario the predicted values for these three probes are strongly correlated. We show in the lower panels in @fig:mprobes24 the present status of these correlations. As those panels show, with a positive determination of two of these probes one can in principle obtain information on the value of the Majorana phases and/or the mass ordering @Fogli:2004as @Pascoli:2005zb. Furthermore, a sufficiently strong upper bound can provide information about the ordering of the states @Gariazzo:2022ahe.

Quantitatively, the global analysis of oscillation data together with the bound from the KATRIN experiment implies that at 95% CL

$
  0.0085 "eV" lt.eq m_(nu_e) lt.eq 0.4 "eV" quad "for NO", quad 0.048 "eV" lt.eq m_(nu_e) lt.eq 0.4 "eV" quad "for IO",
  \
  0.058 "eV" lt.eq sum m_nu lt.eq 1.2 "eV" quad "for NO", quad 0.098 "eV" lt.eq sum m_nu lt.eq 1.2 "eV" quad "for IO"
$

and for Majorana neutrinos also

$
  0 lt.eq m_(e e) lt.eq 0.41 "eV" quad "for NO", quad 0.015 "eV" lt.eq m_(e e) lt.eq 0.41 "eV" quad "for IO" .
$

= Summary <sec:conclu>

We have presented an updated global analysis of world oscillation data up to September 2024 as listed in Appendix~#ref(<sec:appendix-data24>, supplement: none). Our results are presented in two versions: "IC19 w/o SK-atm" including all the data for which enough information is available to perform an independent accurate fit, and "IC24 with SK-atm" which includes $chi^2$ data tables provided by the IceCube and Super Kamiokande collaborations that we add to our own $chi^2$. The global best-fit values as well as $1 sigma$ and $3 sigma$ ranges for all parameters are given in @tab:bfranges24. The main results can be summarized as follows:

- The determination of the parameters $theta_12$, $theta_13$, $Delta m^2_(21)$, and $|Delta m^2_(3 ell)|$ is very stable, with Gaussian $chi^2$ profiles up to high CL. The relative precision at $3 sigma$ for these parameters is about 13%, 8%, 16%, (5--6)%, respectively.
- For $theta_23$ the precision at $3 sigma$ is still about 20%, and the determination suffers from the octant ambiguity. There is a slight preference for the second octant, $theta_23 > 45 degree$, (except for NO and the "IC24 with SK-atm" data) but for all combinations of datasets and mass orderings, the local minimum in the other octant always has $Delta chi^2 < 4$.
- The determination of the leptonic CP phase $delta_"CP"$ strongly depends on the mass ordering. For NO the best-fit point is very close to the CP-conserving value of $180 degree$ (with $Delta chi^2 < 1$), and the $chi^2$ profile is highly non-Gaussian, with some dependence on the two data variants and on the octant of $theta_23$. For IO, the best fit points for both data variants are close to maximal CP violation $delta_"CP" = 270 degree$ (within $1 sigma$), disfavoring CP conservation at $3.6 sigma$ ($4 sigma$) for the "IC19 w/o SK-atm" ("IC24 with SK-atm") analysis.
- Concerning the mass ordering, we find $Delta chi_("IO,NO")^2 = -0.6 (6.1)$ for the "IC19 w/o SK-atm" ("IC24 with SK-atm") analysis. The indecisive result for the "IC19 w/o SK-atm" analysis emerges from opposite trends in the long-baseline accelerator appearance data from T2K and NOvA on the one hand, and in the combination of the disappearance channels from accelerator and reactor experiments on the other hand. In the former case, the tension between T2K and NOvA for NO has reached $2 sigma$ with the latest NOvA update, whereas they are perfectly consistent for IO. Conversely, the determination of $|Delta m^2_(3 ell)|$ from $nu_mu$ and $nu_e$ disappearance agrees better for NO than for IO. While a sensitivity analysis suggests that global "IC19 w/o SK-atm" data has a median sensitivity of $2.5 sigma$ ($2.8 sigma$) to reject NO (IO), the actual result is only $1.7 sigma$ ($1.4 sigma$) for NO (IO) because of the opposite trends in the data. The addition of IC24 and SK-atm data provides additional preference for NO leading to the above quoted result of $Delta chi_("IO,NO")^2 = 6.1$.

We provide also updated ranges and correlations for the effective parameters sensitive to the absolute neutrino mass from $beta$-decay, neutrinoless double-beta decay, and cosmology. All results and supplementary material such as additional figures and data tables are provided at the NuFit webpage @nufit.
#heading(numbering: none)[Acknowledgments]

We would like to thank Tetiana Kozynets and Philipp Eller for useful discussions about the IceCube simulation. This project is funded by USA-NSF grant PHY-2210533 and by the European Union's through the Horizon 2020 research and innovation program (Marie Skłodowska-Curie grant agreement 860881-HIDDeN) and the Horizon Europe research and innovation programme (Marie Skłodowska-Curie Staff Exchange grant agreement 101086085-ASYMMETRY), and by ERDF "A way of making Europe". It also receives support from grants PID2022-126224NB-C21, PID2022- 136510NB-C33, PID2022-142545NB- C21, PID2021-123703NB-C21, "Unit of Excellence Maria de Maeztu 2020-2023" award to the ICC-UB CEX2019-000918-M, grant IFT "Centro de Excelencia Severo Ochoa" CEX2020-001007-S funded by MCIN/AEI\/\/, as well as from grants 2021-SGR-249 (Generalitat de Catalunya) and from Basque Government (IT1628-22) grant. IMS is supported by the STFC under Grant No.~ST/X003167/1. Part of this work used the Solaris cluster, acquired through the Basque Government IT1628-22 grant.

#pagebreak()
#set heading(numbering: "A")
#counter(heading).update(0)
= List of data used in the analysis <sec:appendix-data24>

#heading(level: 1, numbering: none)[Solar experiments]
<solar-experiments>

- *New.* #emph[External information]: Standard Solar Models #cite(<B23Fluxes>).

- Chlorine total rate #cite(<Cleveland:1998nv>), 1 data point.

- Gallex & GNO total rates #cite(<Kaether:2010ag>), 2 data points.

- SAGE total rate #cite(<Abdurashitov:2009tn>), 1 data point.

- SK1 1496-day energy and zenith spectrum #cite(<Hosaka:2005um>), 44 data points.

- SK2 791-day energy and day/night spectrum #cite(<Cravens:2008aa>), 33 data points.

- SK3 548-day energy and day/night spectrum #cite(<Abe:2010hy>), 42 data points.

- *New.* SK4 2970-day energy and day/night spectrum #cite(<Super-Kamiokande:2023jbt>), 46 data points.

- SNO combined analysis #cite(<Aharmim:2011vm>), 7 data points.

- Borexino Phase-I 741-day low-energy data #cite(<Bellini:2011rx>), 33 data points.

- Borexino Phase-I 246-day high-energy data #cite(<Bellini:2008mr>), 6 data points.

- *New.* Borexino Phase-II 1292-day low-energy data #cite(<Borexino:2017rsf>), 192 data points.

- *New.* Borexino Phase-III 1432-day low-energy data #cite(<BOREXINO:2022abl>), 120 data points.

#heading(level: 1, numbering: none)[Atmospheric experiments]
<atmospheric-experiments>

- #emph[External information]: Atmospheric neutrino fluxes #cite(<Honda:2015fha>).

- *New.* IC19 IceCube/DeepCore 3-year data (2012-2015) #cite(<IceCube:2019dqi>) #cite(<IceCube:2019dyb>), 140 data points.

- *New.* IC24 IceCube/DeepCore 9.3-year data (2012-2021) $chi^2$ map #cite(<IceCube:2024xjj>) #cite(<IC:data2024>) added to our global analysis.

- *New.* SK1-5 484.2 kiloton-year data #cite(<Super-Kamiokande:2023ahc>), $chi^2$ map #cite(<SKatm:data2024>) added to our global analysis.

#heading(level: 1, numbering: none)[Reactor experiments]
<reactor-experiments>

- *New.* KamLAND separate DS1, DS2, DS3 spectra #cite(<Gando:2013nba>) with Daya Bay reactor $nu$ fluxes #cite(<DayaBay:2021dqj>), 69 data points.

- *New.* SNO+ spectrum from partial fill 114 ton-yr #cite(<SNO:2024wzq>) data and full fill 286 ton-yr data #cite(<SNO-:nu24>) #cite(<SNO-poster:nu24>), 17 data points.

- Double-Chooz FD/ND spectral ratio, with 1276-day (FD), 587-day (ND) exposures #cite(<DoubleC:nu2020>), 26 data points.

- *New.* Daya Bay 3158-day separate EH1, EH2, EH3 spectra #cite(<DayaBay:2022orm>), 78 data points.

- Reno 2908-day FD/ND spectral ratio #cite(<RENO:nu2020>), 45 data points.

#heading(level: 1, numbering: none)[Accelerator experiments]
<accelerator-experiments>

- MINOS $10.71 times 10^20$~pot $nu_mu$-disappearance data #cite(<Adamson:2013whj>), 39 data points.

- MINOS $3.36 times 10^20$~pot $macron(nu)_mu$-disappearance data #cite(<Adamson:2013whj>), 14 data points.

- MINOS $10.6 times 10^20$~pot $nu_e$-appearance data #cite(<Adamson:2013ue>), 5 data points.

- MINOS $3.3 times 10^20$~pot $macron(nu)_e$-appearance data #cite(<Adamson:2013ue>), 5 data points.

- *New.* T2K $21.4 times 10^20$ pot $nu_mu$-disappearance data #cite(<T2K:nu24>), 28 data points.

- *New.* T2K $21.4 times 10^20$ pot $nu_e$-appearance data #cite(<T2K:nu24>), 9 data points for the CCQE and 7 data points for the CC1$pi$ samples.

- *New.* T2K $16.3 times 10^20$ pot $macron(nu)_mu$-disappearance data #cite(<T2K:2023mcm>), 19 data points.

- *New.* T2K $16.3 times 10^20$ pot $macron(nu)_e$-appearance data #cite(<T2K:2023smv>), 9 data points.

- *New.* NOvA $26.6 times 10^20$ pot $nu_mu$-disappearance data #cite(<NOvA:nu24>), 22 data points.

- *New.* NOvA $26.6 times 10^20$ pot $nu_e$-appearance data #cite(<NOvA:nu24>), 15 data points.

- NOvA $12.5 times 10^20$ pot $macron(nu)_mu$-disappearance data #cite(<NOvA:nu2020>), 76 data points.

- NOvA $12.5 times 10^20$ pot $macron(nu)_e$-appearance data #cite(<NOvA:nu2020>), 13 data points.

= IceCube 2019 <sec:app_IC>

The IceCube analysis (IC19) is based on Analysis A from @IceCube:2019dqi @IceCube:2019dyb.  This analysis uses data collected over 3-years, from April 2012 to May 2015. Following the public data release @Collaboration_2019, we computed the expected number of events for each bin, where the reconstructed energy is logarithmically distributed between $5.6$~GeV and $56$~GeV across eight bins, and the reconstructed cosine of zenith angle is distributed between $- 1$ and $+ 1$ across ten bins. The events are categorized into two particle identification (PID) types: tracks and cascades. The expected number of events in each bin is given by

$
  N_i = T sum_alpha sum_"MC" phi.alt_alpha^"atm" ( E_nu cos theta ) #h(0.17em) P_(alpha beta) ( E_nu cos theta ) #h(0.17em) A_beta^"eff"
$<eq:Ev>

where the sum is performed over all the Monte Carlo simulated events that contribute to the $i$-th bin and over all initial flavor states, corresponding to electron and muon neutrinos in the case of atmospheric neutrinos. For the atmospheric neutrino flux, we used the Honda flux @Honda:2015fha with the energy spectra modified by a factor of $( E_nu #scale(x: 120%, y: 120%)[\/] 5 med "GeV" )^(- 0.05)$. Both the flux and the oscillation probabilities are evaluated at the true energy and zenith of the simulated events. The constant $T$ denotes the total data-taking time. In addition to the expected event distribution, each bin includes a contribution from the atmospheric muon background, determined by binning the simulated muon background events provided in the public release.

The event distribution in each bin is modified by the detector systematics, which account for the uncertainties in the detector response. These uncertainties include factors such as optical absorption, photon scattering in the ice, DOM efficiency, and the coincidence in reconstruction between neutrinos and atmospheric muons. The systematics are applied to the event distribution as multiplicative reweighting factors for each bin. We have incorporated these uncertainties into our analysis using the information provided in the data release and taking the variable called `reco_coszen` as the negative of the reconstructed zenith angle ($- cos theta_(r e c)$). These systematics apply to both the event and background distributions. For the uncertainties, we used the values specified in the data release. For the nominal prediction, we assumed that the event distribution is corrected by the offset plus $5 times mono("opt_eff_lateral")$.

In addition to detector-related systematics, the analysis incorporates uncertainties associated with the atmospheric neutrino flux. These uncertainties are accounted for as follows:

- Normalization: An uncertainty of 100% was assumed, although the results remain consistent when this parameter is left free.

- Initial flavor composition: A 18% uncertainty was included to account for variations in the initial composition of electron and muon neutrinos.

- Neutrino to antineutrino ratio: An uncertainty of 25% was applied to account for variations in the relative flux of neutrinos and antineutrinos.

- Energy dependence of the flux: This uncertainty is parameterized using the factor $( E_nu \/ E_0 )^gamma$, with $E_0 = 5$~GeV. The central value of $gamma$ is set to zero, and an uncertainty of 5% is applied.

- Upward vs.~horizontal flux ratio: A 10% uncertainty was assumed to account for directional asymmetries in the atmospheric neutrino flux.

// [figvision] imgs/fig-IC19.png - IceCube fit compared with Analysis A.
// Main panel: Delta m^2_32 (2.3-3.0)e-3 eV^2 vs sin^2 theta_23 (0.35-0.65) with
// nested 1sigma/90%/2sigma closed contours; black solid = our fit, blue dashed =
// IceCube Analysis A, almost coincident (best fit sin^2 theta_23 ~0.48, split
// near 2.45e-3). Top strip: Delta chi^2 vs sin^2 theta_23 with minimum ~0.48
// (black and blue dashed). Right strip: Delta chi^2 vs Delta m^2_32 rising
// approximately linearly on both sides.
#figure(placement: top, image("imgs/fig-IC19.png", width: 100%), caption: [Our fit to IceCube Analysis A (blue dashed lines) is compared to the results from IceCube~#cite(<IceCube:2019dqi>) (black lines).],) <fig:IC19>

Assuming a Gaussian $chi^2$ distribution and noting that the variable `reco_coszen` in the data corresponds to the negative of `reco_coszen` in the simulated events, we have computed IceCube's sensitivity to $Delta m^2_(32)$ and $sin^2 theta_23$. The results are presented in @fig:IC19, alongside a comparison with the findings from Analysis A of @IceCube:2019dqi. By comparing the best-fit points for the two neutrino mass orderings we obtain a non-significant preference for the normal ordering with a difference of $0.7$ units in $chi^2$, in excellent agreement with the corresponding result $0.738$ reported in @IceCube:2019dyb.

= Assumed true values for the MO test <sec:app-T>

As mentioned in @sec:MO, the values of $T_0^o$---and therefore the distribution of $T$---depend on the unknown true value of the oscillation parameters, see @eq:T0def. In principle, one needs to consider the distribution of $T$ for all possible values of $theta^"true"$ and the final $p$-value of a MO hypothesis will be given by the largest one among all choices of $theta^"true"$, #emph[i.e.], by the weakest rejection (see the discussion in @Blennow:2013oma). In the main text, we have assumed that the best fit of the real data is representative of the $T$-distribution at the unknown true value of $theta$. Indeed, given the allowed regions of the oscillation parameters, we do not expect $T_0$ to change significantly if we vary $theta^"true"$ within the allowed regions at reasonable confidence level. The only exception may be the sensitivity of LBL data as a function of $delta_"CP"$, which is known to affect the MO sensitivity, especially for NOvA as shown in @fig:nevts24.

For IO, the global fit constrains $delta_"CP"$ reasonably well, so that we do not expect strong variations of $T_0^"IO"$ for true values of $delta_"CP"$ in its allowed range for IO. However, for NO, a significantly larger range of $delta_"CP"$ is allowed, in particular in correlation with $theta_23$, see @fig:region-cp23. Therefore, the question arises, whether the MO test would give largely different results when considering true values for $delta_"CP"$ and $theta_23$ within the allowed region for NO.

From @fig:nevts24, we see that for $delta_"CP" approx 270 degree$ and NO, the number of $nu_e$ events in NOvA is maximal, and its value cannot be obtained by any parameter choice in IO. Therefore, we expect best sensitivity to NO for this value of $delta_"CP"$. In contrast, values around 0 or $180 degree$ can be easily accommodated within IO, and we expect that the sensitivity to NO is weakest around CP-conserving values. We have confirmed this expectation, as we obtain
$
  T_0^"NO" (delta_"CP"^"true" = 270 degree, sin^2 theta_23^"true" = 0.46) = 12.38 ,
$<eq:T0max>
with all other oscillation parameters kept at their best-fit values. This value is significantly larger than the value in @eq:T0 for the best-fit point with $delta_"CP" = 177 degree$, implying higher sensitivity to reject NO. Actually, for the value in @eq:T0max the observed value $T_"obs" = -0.6$ would imply a $p$-value for NO of 3.2%. Since values of $delta_"CP"$ around $90 degree$ are significantly disfavored also for NO, we do not consider them relevant for the MO test.

To summarize, for relevant choices of the oscillation parameters, the sensitivity to the NO is weakest for values of $delta_"CP"$ around $180 degree$. In turn, for IO, $delta_"CP"$ is sufficiently constrained, and we expect only minor variations of $T_0$ within the relevant range around $270 degree$. Therefore, it is appropriate to consider the current best fit points to quote the final $p$-values for both orderings.


#show bibliography: set text(size: 10pt)
#bibliography("refs.bib", title: [References])