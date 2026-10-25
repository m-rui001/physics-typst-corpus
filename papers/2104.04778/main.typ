// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: (..n) => if n.pos().first() <= 1 { "" } else { str(n.pos().first() - 1) }, paper: "us-letter", margin: (left: 3.02cm, right: 3.02cm, top: 2.88cm, bottom: 3.66cm))
#set page(footer: context {
  let n = counter(page).get().first()
  if n > 1 { align(center)[#text(10.9pt)[– #(n - 1) –]] }
})
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.71em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.71em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show figure.caption: set align(left)
#show figure.where(kind: table): set figure.caption(position: top)
#set math.equation(numbering: "(1)", supplement: none)

#align(center)[
  #text(17pt, weight: "bold")[Exploring the Early Universe with Gaia and THEIA]
  #v(1.2em)
  #text(10.5pt)[Juan Garcia-Bellido,]
]

#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em, leading: 0.72em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 1.0em, it) } else { it }
  }
  #outline(title: none, depth: 2)
]

= Introduction
<introduction>

It has recently been shown that large surveys of stars such as Gaia~@Brown:2018dum and the proposed upgrade, THEIA (Telescope for Habitable Exoplanets and Interstellar/Intergalactic Astronomy)~@10.3389-fspas.2018.00011, can be powerful probes of gravitational waves (GW)~@Moore:2017ity. GWs affect the apparent position of a star, and the multiple subsequent measurements of the same star can be used to turn Gaia into a GW observatory~@Moore:2017ity @Mihaylov:2018uqm @Mihaylov:2019lft. The dimensionless strain sensitivity of Gaia is expected to be a constant~@Moore:2017ity and scale inversely with the lifetime of the experiment~@Book:2010pf. This is in contrast to pulsar timing arrays, whose strain sensitivity scales as the inverse square root of the observation time. The scaling with the mission lifetime comes from the fact that Gaia monitors the position of $N$ sources in the sky with angular resolution $Delta theta$ over a time $T$. For a single source, one could detect an angular velocity (proper motion) of order $Delta theta \/ T$, and for $N$ sources, a #emph[correlated] angular velocity of order $Delta theta \/ (T sqrt(N))$ should be detectable. It follows~@Book:2010pf that one should obtain an upper limit

$ Omega_("gw")(f tilde 1\/T) lt.tilde (Delta theta)^2 \/ (N T^2 H_0^2) $

on the GW energy density from a SGWB. Moreover, the analysis of Ref.~@Moore:2017ity seems to indicate that the cadence of the astrometric survey does not change the strain sensitivity appreciably, at least not more than an order of magnitude.

The constant strain sensitivity makes astrometry a powerful tool for filling the sensitivity gap between nanohertz frequencies probed at pulsar timing arrays~@Lentati:2015qwp @Arzoumanian:2020vkk, and millihertz frequencies probed by the LISA mission~@Bartolo:2016ami. Furthermore, the efficient scaling with the mission time makes upgrades to Gaia competitive with even the square kilometer array at probing the nanohertz range. In this paper we discuss the cosmological opportunities of using Gaia and THEIA as GW observatories. In particular, various dark matter models based on the Strongly-Interacting Massive Particles (SIMP) paradigm are expected to feature a confining transition that could leave a observable background gravitational wave spectrum that typically peaks between the sensitivity ranges of LISA and pulsar timing arrays, precisely the frequency range where astrometry can contribute. Asymmetric dark matter is also expected to include physics at a similar scale. Further we explore the potential of primordial black hole detection with an emphasis of primordial black hole production during such a confining transition. We also discuss the potential to observe gravitational wave backgrounds generated from topological defects such as domain walls and strings. Finally, motivated by the recent hint of a possible SGWB signal at NANOGrav @Arzoumanian:2020vkk, we discuss the timescale for Gaia to give complementary information on the tentative signal.

The structure of this paper is as follows. @sec-curves we give the sensitivity curves for Gaia and its upgrades, we then discuss the potential to observe cosmological phase transitions indirectly with astrometry in @sec-pt. Note that in that section we discuss specific models that can be detected, focusing on dark sectors. Next, in @sec-defects, we discuss cosmological defects and the potential reach of astrometry as well as a discussion of the recent NANOGrav results. In @sec-pbh we discuss the effect that phase transitions have on the Primordial Black Hole (PBH) mass spectrum as a complementary cosmological probe before concluding in @sec-conclusions. We describe in the Appendices the low-energy effective models associated with confinement transitions.

= Sensitivity curves for Gaia and THEIA
<sec-curves>

Experimental designs typically specify a strain sensitivity, whereas cosmologists are typically interested in the gravitational wave abundance. The strain sensitivity, $h_("gw")$, can be conveniently converted to the abundance, $Omega_("GW")$, via the relation

$ Omega_("gw")(f) thin h^2 = frac(2 pi^2, 3 H_0^2) f^2 h_("gw")^2 (f) h^2 $

where $h = 0.67$, i.e. $H_0 = 67$ (km/s)/Mpc, is the value of Hubble observed today and $f$ is the frequency. For Gaia we can take the constant sensitivity derived in ref. @Moore:2017ity

$ h_("GW") = 10^(-14) (frac(5 "years", T_M)), quad forall thin f > 1\/T_M $

where $T_M$ is the mission lifetime, which we will generously take to be $med 20$ years. For THEIA, we estimate that one will observe a hundred times as many stars with an angular velocity resolution that is superior by a factor of 60. This results in a strain sensitivity of

$ h_("GW") = 1.6 times 10^(-16) (frac(5 "years", T_M)), quad forall thin f > 1\/T_M . $

When searching for a specific signal, the sensitivity of Gaia can be dramatically improved by comparing the signal for multiple frequencies. We present the peak integrated sensitivity curve~@Schmitz:2020syl relevant for phase transitions and the power law sensitivity curve~@Thrane:2013oya relevant for strings in @fig-sensitivity. In both cases the integrated sensitiviity curve can be obtained by

$ cal(N)(f) &= (3 H_0^2 integral_(f_("min") = 1\/T)^(f_("max")) (frac(f', f))^3 (frac(7, 4 + 3 (4 + 3 (frac(f', f))^2)))^(7\/2) frac(dif f', 2 pi^2 (f')^3 h_("GW")^2 h^2))^(-1) \
  cal(N)(f) &= "Max"(n) [(frac(f, f_("min")))^n (3 H_0^2 integral_(f_("min") = 1\/T)^(f_("max")) frac((f' \/ f_("min"))^n, 2 pi^2 (f')^3 h_("GW")^2 h^2) dif f')^(-1)] , $

for a broken and an envelope of power laws respectively. The sensitivity we show in @fig-sensitivity alongside pulsar timing arrays as well as other proposed experiments including Lisa and aLIGO. THEIA is almost unmatched in its potential sensitivity and both astrometry experiments have reach in between that seen by pulsar timing arrays and LISA.

// [figvision] imgs/sensitivity_curves.png
// The figure is a plot showing sensitivity curves for various astronomical observation methods. The x-axis
// represents frequency in Hz, ranging from 10^-10 to 10^4. The y-axis represents Ωgw(f) h^2, ranging from 10^-20
// to 10^0. There are two types of bands: power law integrated sensitivity curves in lighter shades and peak
// integrated sensitivity curves in darker shades, both corresponding to a signal-to-noise ratio between 1 and
// 10. Each curve is labeled with the name of an observatory or mission: NANOGrav, EPTA, SKA, GAIA, THEIA, LISA,
// DECIGO, BBO, aLIGO, and ET. The trend shows that each observatory or mission has a unique sensitivity curve,
// with some having a peak sensitivity at certain frequencies. The message is a comparison of the sensitivity of
// different astronomical observation methods across a wide range of frequencies.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering):* #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [*Table #context it.counter.display(it.numbering):* #it.body]
}

#figure(
  image("imgs/sensitivity_curves.png", width: 100%),
  caption: [
    Power law and peak integrated sensitivity curves for pulsar timing arrays @vanHaasteren:2011ni @Janssen:2014dka @Lazio:2018ukb against astrometry methods such as Gaia and THEIA. The bands correspond to a signal to noise ratio between 1 and 10, the lighter bands are power law integrated sensitivity curves while the darker bands correspond to the peak integrated sensitivity bands. Also included are space based missions, Lisa @Caprini:2019egz, BBO @Yagi:2011wg and Decigo @Kawamura:2006up @Kawamura:2020pcg where for the latter we have used the ultimate specifications. Additionally, we included high frequency detectors in aLIGO @TheLIGOScientific:2014jea and the Einstein telecope @Punturo:2010zz. Note that THEIA has sensitivity in the range beween pulsar timing arrays and LISA. By extending the cadence of THEIA down to days one could fill the gap between PTA and LISA frequencies.
  ],
  placement: top,
) <fig-sensitivity>

= Phase transitions
<sec-pt>

For any given phase transition, the dominant source is widely believed to be the acoustic source @Hindmarsh:2013xza @Hindmarsh:2015qta @Hindmarsh:2017gnf. The spectral form is model independent with the peak amplitude and frequency depending just on four thermal parameters - the bubble wall velocity, $v_w$, the inverse timescale of the transition, $beta$, the change in the trace anomaly normalized by the radiation density, $alpha$, and the temperature at which percolation occurs, $T_p$. The peak amplitude depends on the thermal parameters as follows @Hindmarsh:2013xza @Hindmarsh:2015qta @Hindmarsh:2017gnf @Guo:2020grp #footnote[Note that the method we use in this paper is common, but has some non-trivial uncertainties, as it neglects vorticity and reheating effects @Cutting:2019zws, assumes a bag model @Giese:2020znk @Giese:2020rtr and is not always an accurate estimate of the nucleation temperature @Guo:2021qcq]

$ h^2 Omega_("GW") = 8.5 times 10^(-6) (frac(100, g_s (T_e)))^(1\/3) Gamma^2 macron(U)_f^4 [frac(H_s, beta (v_w))] v_w times Upsilon , $

where $Gamma tilde 4\/3$ is the adiabatic index and $Upsilon$ is the suppression factor arising from the finite lifetime, $tau_("sh")$, of the sound waves, given by

$ Upsilon = 1 - frac(1, sqrt(1 + 2 tau_("sh") H_s)) . $

== Motivating first order transitions detectable with astrometry
<motivating-first-order-transitions>

The range of frequencies that Gaia is sensitive to is ideal for a phase transition occurring between an MeV and a GeV. This is precisely the scale we would expect a confinement transition to occur in either QCD, a hidden sector involving a strongly interacting massive particle (SIMP), or asymmetric dark matter model. In fact, the preferred confinement scale for strongly interacting massive particle (SIMP) dark matter is precisely in this range @Hochberg:2014dra. We will focus mostly on hidden sector models here, but let us begin with the QCD transition, which can also in principle be a strong first order transition and can give us insight to what sort of phase transitions can lead to a gravitational wave signature.

In the standard model, the cosmological QCD transition is unfortunately not expected to be strongly first order @Bazavov:2011nk @Gupta:2011wh. However, in principle, extensions to the standard model or unusual conditions in the early Universe could modify this. Confinement transitions are not as easy to model as transitions involving fundamental scalars, where effective potential methods provide a powerful and intuitive guide and are known to describe low scale QCD reasonably well @GellMann:1960np @Nambu:1961tp @Nambu:1961fr @Fukushima:2003fw.#footnote[Note that transitions concerning fundamental scalars involve their own set of theoretical problems that can create large uncertainties in perturbative methods @Croon:2020cgk.] In the absence of lattice calculations, it is a natural to consider an effective scalar theory and model confinement transitions in an analogous manner. From such an effective theory, one can make a qualitative check of that nature of the transition by searching for stable infrared fixed points @Pisarski:1983ms. Between lattice calculations and effective methods of the condensate one can derive three scenarios that can make a cosmological confinement transition first order

- Having at least three quarks that are effectively massless compared to the confinement scale. In QCD, this can occur if $u$, $d$, $s$ quarks are made lighter in the early Universe @Davoudiasl:2019ugw.

- Having a pure Yang--Mills transition where quarks are either absent or heavy.

- The baryon chemical potential is large in the early Universe. This can be achieved through a large lepton asymmetry @Schwarz:2009ii which can be made compatible with BBN bounds @Barenboim:2016shh. In principle a confinement transition in a SIMP model can be similarly influenced by a large asymmetry in the early Universe.

Although the calculations we present here will suffer from theoretical uncertainty, results do seem to agree with the intuition that the larger the change in relativistic degrees of freedom, the stronger the transition. For example, in the case where glueballs dominate the confining transition, the strength of the transition grows with the number of colors. Similarly, in the case where quark condensates dominate the free energy, prior work has shown some evidence that strength of the transition grows with the number of flavours @Croon:2019iuh. We will also consider the implications of a transition of a fundamental scalar in an asymmetric dark matter model introduced in ref. @Croon:2019rqu.

=== Gravitational waves from chiral symmetry breaking
<gw-chiral-symmetry-breaking>

To estimate the gravitational wave signal in a chiral symmetry breaking transition, we follow the strategy of recent work that relies on low energy effective theories such as the linear sigma model (LSM) and the (p)NJL model @Helmboldt:2019pan. The NJL has the advantage of being sensitive to the number of colours in the theory whereas the LSM is sensitive only to the number of quark flavours. The pNJL model improves on the NJL model yet again by including a potential for Wilson loops whose coefficients can be derived from lattice @Roessner:2006xn. There is to date no lattice calculation to compare the predictions for the gravitational wave signal produced in either model, we therefore simply calculate benchmarks in each model with the expectation that there can be future improvement in the predictions of gravitational waves produced in SIMP models.

For the linear sigma model, a large gravitational wave signal is predicted in the case where there is a large hierarchy between the axion and pion mass @Croon:2019iuh. In the case of the (p)NJL model, there is a critical point in the parameter space where it no longer is energetically favourable for chiral symmetry breaking to occur. Near this critical point are the strongest transitions and we choose benchmarks in this region of parameter space. To ascertain the lowest temperature a confinement transition can occur we need to enforce a number of conditions

+ To drain the entropy in the hidden sector we require kinetic equilibrium to be maintained until the freeze out temperature - typically one twentieth the pion mass @Hochberg:2014dra @Hochberg:2015vrg.

+ We enforce the chiral limit, this means the pion mass is much lower than the critical temperature. We do not have a precise criteria, but for our present purposes require that the critical temperature to be ten times the pion mass.

+ Freezeout needs to occur well before BBN. To ensure safety we enforce a conservative bound that $T_("FO") > 2$ MeV.

Let us begin with the first criteria. We must ensure that kinetic equilibrium is maintained at the freeze-out temperature to ensure the entropy is drained. We consider dark photon mediation between mesons and SM fermions as the channel to maintain equilibrium @Hochberg:2015vrg @Kuflik:2015isi. This is achieved when,

$ frac(5, 4) zeta(5) m_pi Gamma_("scatt") lt.tilde frac(H(T_f) m_pi^2, T_f) $

where

$ Gamma_("scatt") = sum_f frac(sigma_f v_("rel"), E_f^2) frac(12 zeta(5), pi^2) frac(15, 16) T_f^5 $

and

$ sigma_f v_("rel") &= 8 pi alpha_D alpha sum frac(Q_pi^2, N_pi) frac(1, c_chi^2) [-(frac(c_zeta^2, m_V^2) + frac(s_zeta^2, m_Z^2)) c_W t_chi Q_f \
  & quad + (frac(c_zeta (s_zeta + s_W t_chi c_zeta), m_V^2) - frac(s_zeta (c_zeta - s_W t_chi s_xi), m_Z^2)) frac(1, s_W c_W) (I_3^f - Q_f s_W^2)] E_f^2 . $

In the above we follow the notational conventions of ref. @Hochberg:2015vrg. Specifically, $(s_x, t_x, c_x)$ denote trigonometric functions where the subscript denotes the argument. The angle, $chi$ is the mixing

$ L supset -frac(sin chi, 2) B^(mu nu) A^(mu nu) , $

and

$ tan 2 zeta = frac(m_Z^2 s_W sin 2 chi, m_V^2 - m_Z^2 (c_chi^2 - s_W^2 s_chi^2)) . $

Furthermore, $pi$ denotes the dark pion, $alpha_D$ denotes the dark sector coupling strength and all Standard Model notation is conventional. It is straightforward to achieve kinetic equilibrium and avoid all possible dark photon constraints @Fradette:2014sza for a remarkably low freezeout temperatures when the mixing is of the order $chi tilde 10^(-4)$.

The second and third constraints are arguably the most restricting. If the freezeout temperature is at least 2 MeV, this implies a pion mass of at least 40 MeV which in turn implies a critical temperature of 400 MeV#footnote[We hope this to be quite conservative since the pion mass is the geometric mean of the quark mass and the confinement temperature which is larger than the quark mass.]. This of course does not necessarily exclude interesting gravitational wave signatures from a SIMP with light quarks involving a much lower critical temperature. The weakness of the limit arising from kinetic equilibrium at freeze-out is very promising. However, the methods for calculating such a gravitational wave signal is even more uncertain than what we present as the chiral limit becomes invalid. With these restrictions in mind, we therefore present the conservative benchmarks presented in @tab-benchmarks with the GW signal plotted in @fig-benchmarks and @fig-benchmarks2. Note that even THEIA requires a reasonably strong phase transition, so in general the percolation temperature can be well below the transition temperature. We take the chiral limit as being valid when the #emph[critical] temperature is $400$ MeV and the transition occurs when kinetic equilibrium is still possible. This can mean in some benchmarks that the mass of the quarks are not too light compared to the transition temperature. There is a theoretical uncertainty that arises from this that needs to be settled either by lattice modelling or substantial theoretical progress.

#figure(
  table(
    columns: 5,
    align: center,
    stroke: none,
    table.header([Model], [$N_C$], [$N_F$], [$Lambda$], [parameters]),
    table.hline(stroke: 0.5pt),
    [LSM], [N/A], [4], [-], [$m_A \/ m_phi.alt = 51.66$],
    [NJL ($B_2$)], [3], [3], [$1.24$ GeV], [$G^(-1) = 0.48$ GeV$zws^2$, $G_D^(-1) = -0.042$ GeV$zws^5$],
    [NJL ($B_3$)], [5], [3], [$4$ GeV], [$G^(-1) = 9.79$ GeV$zws^2$, $G_D^(-1) = -14.72$ GeV$zws^5$],
    [pNJL ($B_4$)], [3], [3], [$6.2$ GeV], [$G^(-1) = 11.97$ GeV$zws^2$, $G_D^(-1) = -131.69$ GeV$zws^5$],
  ),
  caption: [Benchmarks for SIMP models with light quarks. In each case the critical temperature is set to the conservative limit of 400 MeV (see text for explanation). The number of flavours is denoted by $N_F$ and the number of colours by $N_C$. The parameters are found by tuning the critical temperature to 400 MeV and notational conventions are taken from ref. @Hochberg:2015vrg.],
  kind: table,
) <tab-benchmarks>

== Asymmetric dark matter and solitosynthesis
<asymmetric-dark-matter>

If a phase transition has tunneling rate that never becomes large enough compared to the Hubble time to percolate, the phase transition can still complete through a process known as solitosynthesis so long as there is a conserved charge to stabilize sub-critical bubbles @Kusenko:1997hj. If there is a conserved charge, the free energy of a sub-critical bubble is stabilized by a term proportional to the charge density inside the bubble - such a term diverges for vanishing radius. Such a stable field configuration is known as a Q-ball @Coleman:1985ki. As the Universe cools, some sub-critical bubbles become critical and explode, completing the phase transition. The phase transition is typically strong and long lasting @Croon:2019rqu.

If dark matter is asymmetric, matching the dark matter to its observed value fixes a relationship between the asymmetry and the mass of the dark matter,

$ Y_("DM") m_("DM") tilde 5 times 10^(-10) "GeV" . $

The transition temperature is generally within an order of magnitude of the dark matter. This makes pulsar timing arrays ideal for probing such a phase transition that has an asymmetry $Y_("DM") tilde O(10^(-7))$. Gaia is ideal for probing such asymmetric dark matter scenarios when $Y_("DM") tilde O(10^(-7) - 10^(-8))$. Solitosynthesis occurs in a context where the conventional tunneling rate is too slow compared to Hubble. This typically occurs when there is a tree level barrier between a true and false vacuum. The simplest possibility is a dark sector Higgs augmented by a dimension six operator#footnote[A UV completion with the same thermodynamic properties is not guaranteed, but much easier in a dark sector than a visible sector @Postma:2020toi.]

$ V(h_D, phi.alt) = kappa phi.alt^2 h_D^2 + Lambda^4 [(2 - 3 alpha) (frac(h_D, v_D))^2 - (frac(h_D, v_D))^4 + alpha (frac(h_D, v_D))^6] . $

We present the benchmarks that use the same model as Ref. @Croon:2019rqu with two benchmarks presented in @tab-solitosynthesis where the parameter $alpha$ is varied between $alpha in (0.5, 2\/3)$. The sensitivity of Gaia and THEIA to these benchmarks are given in @fig-benchmarks and @fig-benchmarks2.

#figure(
  table(
    columns: 4,
    align: center,
    stroke: none,
    table.header([v], [$Lambda$], [$g$], [$eta$]),
    table.hline(stroke: 0.5pt),
    [0.06 GeV], [0.02 GeV], [0.1], [$10^(-7)$],
    [0.7 GeV], [0.2 GeV], [0.1], [$10^(-8)$],
  ),
  caption: [Benchmark parameters used for solitosynthesis following the notational conventions in ref. @Croon:2019rqu.],
  kind: table,
) <tab-solitosynthesis>

=== Glueballs
<glueballs>

// [figvision] imgs/visibility.png
// Panel a: This is a plot showing the relationship between /H and T_{} in MeV. The y-axis ranges from 10^{0} to
// 10^{4} and the x-axis ranges from 1 to 1000 MeV. There are several series: black circles, blue circles, green
// circles labeled with numbers, a red square labeled LSM, and brown circles labeled B_{2} and B_{4}. The
// background has two shaded regions, one in light purple and one in light orange, with a diagonal orange line
// and a diagonal purple line. The trend shows that as T_{} increases, /H decreases. The plot appears to be
// comparing different models or benchmarks.
#figure(
  image("imgs/visibility.png", width: 80%),
  caption: [
    Sensitivity to thermal parameters with $alpha = 1$ and benchmarks for a phase transition from solitosynthesis with asymmetry of $10^(-7) \/ 10^(-8)$ (black/blue circles) glueballs for SU(N) (Olive numbers) and confinement in the LSM model (red squares) and the (p)NJL model. Benchmarks for the (p)NJL model are given in @tab-benchmarks are denoted by $B_x$. All benchmarks are not excluded from current PTAs. More details on the models producing these transitions are given in the text.
  ],
) <fig-benchmarks>

// [figvision] imgs/PT_sensitivity_benchmarks.png
// Panel a: This is a plot showing h^2 against frequency f in Hz on a log-log scale. The y-axis ranges from
// 10^{-16} to 10^{-6} and the x-axis from 10^{-8} to 10^{-6}. There are multiple series: a black, blue, red,
// green, and brown line, each representing different models or scenarios. Additionally, there are shaded regions
// in pink and beige. The trend shows various peaks and intersections across the different series, indicating
// complex relationships between h^2 and f. The plot appears to compare different models against sensitivity
// curves.
#figure(
  image("imgs/PT_sensitivity_benchmarks.png", width: 80%),
  caption: [
    Same models with the same color coding as @fig-benchmarks against Gaia and THEIA sensitivity curves. In the case of Glueballs we take $N_C = 30$ and $N_C = 31$. For solitosynthesis we take the strongest and fifth strongest phase transitions for both values of the dark asymmetry.
  ],
) <fig-benchmarks2>

Hidden sectors frequently include dark gauge symmetries which can confine. If there are no light fermions in the theory, the properties of the transition can be studied on the lattice without the ambiguities that arise from trying to model fermions. Gravitational waves arising from a pure Yang-Mills confinement transition are particularly attractive as the number of parameters in the theory, specifically the rank of the group and the confinement scale, matches the number of observables in the peak amplitude and frequency of a gravitational wave spectrum. The surface tension and the latent heat of pure Yang Mills confinement transition for a SU($N_C$) has been calculated on the lattice for $N_C lt.tilde 8$ @Lucini:2005vg @Datta:2010sq

$ sigma = (0.013 N_C^3 - 0.104) T_C^3, quad L = (0.549 + frac(0.458, N_C^2)) T_C^4 . $

Furthermore, the pressure in each phase is known and the ratio of the pressure to the Stephann-Boltzmann pressure is approximately constant as a function of $N_C$ @Panero:2009tv. We use lattice results for the pressure of an SU(3) confinement transition from ref. @Agasian:2017tag @Borsanyi:2012ve. In spite of this impressive array of lattice knowledge, the surface tension and latent heat are only calculated at the critical temperature. Similarly, the pressure below the critical temperature is only defined in the confined phase. In the early Universe, the temperature is decreasing fast enough that a fair amount of supercooling can occur by the time percolation begins. To estimate the macroscopic thermal parameters at the percolation temperature requires extrapolation of the lattice results for the supercooled phase. This can be estimated either through a toy potential for the Polyakov loop whose properties match lattice results - either a potential based on the Haar measure @Huang:2020mso @Kang:2021epo or a polynomial potential @Halverson:2020xpg @Kang:2021epo. This presents some challenges, as the growth in the surface tension with $N_C$ can be in tension with the fact that the pressure is decreasing much faster than $T^4$ near the critical temperature, combined with the fact that the absolute value of the pressure is expected to be negative for strongly super cooled transitions @Cohen:2020tgr. Another approach is to use classical nucleation theory and extrapolate the pressure to the super cooled phase.

Since we require a fairly strong transition for it to be visible, we require a fair amount of super-cooling which unfortunately means that any method used will need to be taken with a healthy grain of salt until there are lattice calculations for supercooled transitions. Here we will review classical nucleation theory and apply it to the case of glueball nucleation. The free energy of a bubble of radius $R$ is given by

$ F = -Delta p frac(4 pi, 3) R^3 + sigma 4 pi R^2 . $

Here, $Delta p$ is the pressure difference between the phases. There is a critical value of $R$ above which it becomes energetically favourable for the bubble to expand as the pressure overwhelms the surface tension. The nucleation rate per unit volume, per unit time is then given by the exponential of the free energy of a critical bubble divided by the temperature

$ Gamma = T^4 e^(-frac(16 pi sigma^3, 3 T Delta p^2)) . $

To extrapolate the pressure below the critical temperature, we use a linear extrapolation of the pressure, allowing it to go negative. A negative pressure in the supercooled deconfined phase was recently argued for in ref. @Cohen:2020tgr. Finally, the inverse time scale of the transition can then be calculated in the usual way $beta \/ H = T dif [F \/ T] \/ (dif T)$.

// [figvision] imgs/strings3.png
// Panel a: This is a plot showing the current and projected reach of NANOGrav and Gaia for cosmic strings. The
// y-axis represents G, ranging from 10^{-11} to 10^{-8}, and the x-axis represents time from present in years,
// ranging from 0 to 20. There are two shaded regions: a gray region representing NANOGrav's reach and a red
// region representing Gaia's reach. The red region is bounded by two dashed red lines. The trend shows that
// Gaia's reach decreases over time, while NANOGrav's reach remains constant. The message is that NANOGrav's
// reach surpasses Gaia's around 5 years.
#figure(
  image("imgs/strings3.png", width: 80%),
  caption: [
    Current and projected reach of NANOGrav (gray) against projected reach of Gaia (red) for cosmic strings with the bands corresponding to a signal to noise ratio SNR $in (1, 10)$.
  ],
) <fig-strings>

// [figvision] imgs/DomainW.png
// The figure is a plot showing the relationship between two variables. a. This panel shows a plot with a
// logarithmic scale on both axes. The x-axis represents _{10} (/TeV^3) and ranges from 4 to 17, and the y-axis
// represents _{10} (( V)/MeV^4) and ranges from 0 to 30. There are several series: a green line, a blue line
// labeled N_{eff} > 0.28, a red line labeled > t_{BBN}, and multiple black lines forming a cluster. The green,
// blue, and red lines are solid. The olive and light blue regions are filled. The trend shows that as increases,
// V also increases. The message suggests that certain regions satisfy specific conditions related to N_{eff} and
// .
#figure(
  image("imgs/DomainW.png", width: 75%),
  caption: [
    Bottom: Domain walls, Black lines give the 1,2,3 $sigma$ fits to the potential NANOGrav signal as given in ref @Bian:2020bps, olive region is explored by THEIA, light blue region by Gaia. Below the red line the domain wall decays after BBN and below the Brown line the gravitational wave signal is too strong to be compatible with bounds on $Delta N_("eff")$
  ],
) <fig-dw>

While Gaia and THEIA are sensitive to phase transitions occurring at slightly higher frequencies than what would be visible to pulsar timing arrays, it is still optimal for detectability for the transition to occur as late as possible. If the glueballs are absolutely stable on cosmologically relevant lifetimes (i.e. $tau gt.tilde 10^25$s to avoid cmb constraints @Chen:2003gz @Fradette:2014sza @Yang:2015cva @Coffey:2020oir), such glueballs can in principle be dark matter. However, the gravitational wave spectrum is suppressed by eight powers of the temperature ratio between the two sectors as it depends on the square of the latent heat. The temperature ratio is required to be less than one in order to avoid overclosure @Forestell:2016qhc @Forestell:2017wov. Alternatively, one can make the glueballs short lived, in which case their decay rate must be larger than Hubble before BBN in order to avoid changing the expansion rate of the Universe during BBN. If one works through a Higgs portal, the decay rate for a glueball of around the QCD scale is @Juknevich:2009ji @Forestell:2016qhc

$ Gamma tilde frac(N_C^2 Lambda_x^7 y^2, Lambda^4 v_h^2) , $

where $N_C$ is the number of colors, $Lambda_x$ is the dark confinement scale (we have made the approximation that this is equivalent to the glueball mass) and $y$ is the relevant Yukawa interactions. One can compare this rate to Hubble to find that the minimum scale is the muon threshold, that is $Lambda gt.tilde 2 m_mu$. In the case of vector boson mixing, the rate of Glueball decay is @Juknevich:2009gg @Forestell:2016qhc

$ Gamma tilde alpha_x^2 alpha_i^2, alpha_x^3 alpha_Y N^2 frac(Lambda_x^9, Lambda^8) $

which allows for a confinement scale of around $100$ MeV for a cutoff scale of around $100$ GeV.

We therefore take this latter value to approximate our confinement transition temperature, though note that it is an approximation and a more detailed calculation could move the lowest possible confinement temperature somewhat.

= Cosmic Defects and NANOGrav
<sec-defects>

The recent 12.5 year updated results of NANOGrav observed a stochastic background that is at odds with expected stochastic backgrounds from super massive black hole mergers @Arzoumanian:2020vkk. A promising explanation is that the almost scale invariant background generated by cosmic strings @Ellis:2020ena @Blasi:2020mfx @Datta:2020bht @Chakrabortty:2020otp @Samanta:2020cdk @King:2020hyd. Another possibility is a metastable cosmic string @Buchmuller:2020lbh or a domain wall @Bian:2020bps @Craig:2020bnv, a strong first order phase transition @Brandenburg:2021tmp @Li:2021qer @Lewicki:2020azd @Neronov:2020qrl @Nakai:2020oit @Addazi:2020zcj or primordial black holes @Kohri:2020qqd @Domenech:2020ers @Sugiyama:2020roc @DeLuca:2020agl. In the case of metastable strings or domain walls, the low frequency Gravitational wave power spectrum obeys a cubic scaling. In this case, astrometry is an ideal compliment to PTAs as the sensitivity has a better scaling with frequency. We will here focus on stable cosmic strings and domain walls.

Let us begin with the case of a cosmic string. We use the velocity dependent one scale model of ref. @Martins:1995tg @Martins:1996jp @Martins:2000cs which models the evolution of a loop of length $ell$ as

$ ell = alpha_ell t_i - Gamma G mu (t - t_i) $

where the emission rate, the string tension and the initial loop size is denoted by $Gamma tilde 50$ @Blanco-Pillado:2013qja @Blanco-Pillado:2017oxo, $G mu$ and $alpha_ell tilde 0.1$ respectively, with our choice for $alpha_ell$ motivated partly by recent simulations @Blanco-Pillado:2013qja @Blanco-Pillado:2017oxo. The frequency today ($t_0$) of the gravitational wave spectrum emitted by a given mode, $k$, can be related to the time of emission, $tilde(t)$, via

$ f = frac(a(tilde(t)), a(t_0)) frac(2 k, alpha_ell t_i - Gamma G mu (tilde(t) - t_i)) . $

The gravitational wave abundance is the sum of the gravitational wave spectrum for individual modes

$ Omega_("GW")(f) = sum_(k = 1)^oo k Gamma^((k)) Omega_("GW")^((k))(f) , $

where

$ Gamma^((k)) = frac(Gamma k^(-4\/3), sum_(m = 1)^oo m^(-4\/3)) tilde 13.9 k^(-4\/3) . $

The contribution to the spectrum from each mode has the form

$ Omega_("GW")^((k))(f) &= frac(16 pi, 3 H_0^2) frac(cal(F) (G mu)^2, alpha ell (alpha_ell + Gamma G mu)) frac(1, f) \
  & quad times integral_(t_F)^(t_0) dif tilde(t) frac(C_("eff")(t_i), t_i^4) (frac(alpha(tilde(t)), a(t_0)))^5 (frac(a(t_i), a(tilde(t))))^3 Theta (t_i - t_F) $

where $t_F tilde 0$ is the time of formation, $C_("eff") = 5.4$ controls the number density of the loops and $cal(F) tilde 0.1$ is an efficiency factor. The network can be described by a plateau, where for high frequency one essentially has a scale invariant spectrum that grows linearly with the symmetry breaking scale

$ Omega_("GW") h^2 tilde 8 Omega_("rad") h^2 sqrt(frac(G mu, Gamma)) , $

as $G mu tilde v$ for a symmetry breaking scale $v$. In the infrared, the spectrum curves downwards. The frequency at which the plateau occurs is quadratic in the symmetry breaking scale. This makes it more difficult for pulsar timing arrays to observe very low string tensions. We show the amount of time in years it will take for Gaia to have a competitive sensitivity to cosmic strings in @fig-strings. Note that Gaia does poorly in the next two years due to the frequency cutoff of the strain sensitivity being $1 \/ T$ where we took $T = 2.5$ years at the present. Gaia quickly outperforms NANOGrav and should give complimentary data within 5 years.

Domain walls can form when the vacuum manifold is disconnected, for example when there is a spontaneously broken $Z_2$ symmetry. The energy density in a domain wall scales inversely with the scale factor which means that they quickly dominate the energy density of the Universe unless they are unstable. One possibility is that the symmetry was only approximate. In the case of a $Z_2$ discrete symmetry one can for example have $V(phi.alt_("min")) = V(-phi.alt_("min")) plus.minus Delta V$. In this case the domain wall can collapse and the resulting gravitational wave power spectrum is obeys a broken power law @Hiramatsu:2013qaa @Kadota:2015dza @Zhou:2020ojf

$ Omega_("GW")(f) h^2 &= 5.2 times 10^(-20) epsilon_("GW") cal(A)^4 (frac(g_ast, 10.75))^(1\/3) (frac(sigma, "TeV"^3))^4 (frac("MeV"^4, Delta V))^2 \
  & quad times [Theta (f - f_p) (frac(f, f_p))^(-1) + Theta (f_p - f) (frac(f, f_p))^3] , $

where $epsilon_("GW") tilde 0.7$ @Hiramatsu:2013qaa is an efficiency parameter, $cal(A) tilde 1.2$ is an area parameter, $sigma$ is the tension in the wall and the peak frequency is given by

$ f_p = 3.99 thin "nHz" thin A^(-1\/2) (frac("TeV"^3, sigma))^(1\/2) (frac(Delta V, "MeV"^4))^(1\/2) . $

Note that it is possible for the gravitational wave abundance to be an unacceptably large amount of radiation, changing the expansion rate of the Universe at recombination. The constraint on the number of relativistic degrees of freedom can be recast into a constraint on the gravitational wave power spectrum @Opferkuch:2019zbd

$ Delta N_("eff") = frac(8, 7) (frac(11, 4))^(4\/3) integral frac(dif f, f) frac(Omega_("GW"), Omega_("rad")) . $

In @fig-dw we show the projected sensitivity of Gaia and THEIA as well as the current best fit to the NANOGrav signal from ref. @Zhou:2020ojf and the contraint from $Delta N_("eff")$.

= Primordial black holes
<sec-pbh>

The extra components beyond the Standard Model responsible for the strong phase transitions that give rise to a significant Stochastic Gravitational Wave Background (SGWB), as discussed in the previous sections, also modify the number of relativistic degrees of freedom and rate of expansion of the universe around the phase transition. The contribution of these new degrees of freedom change the total pressure and energy density of the plasma and thus the equation of state of the universe. We will assume that the extra phase transition responsible for the SGWB occurs around that of the QCD quark-hadron transition, so that the effect is enhanced. Note that the QCD horizon size gives both a solar mass scale ($M_("hor") = (c^3 \/ G) thin t_("QCD") tilde 1 thin M_sun$) and nanohertz frequencies ($f_("peak") = 1 \/ (2 t_("QCD") (1 + z_("QCD"))) tilde 10$ nHz), which connects LIGO/Virgo GWTC-2 black holes with the Pulsar Timing Array and Gaia/THEIA surveys.

// [figvision] imgs/fPBH_M__Nc5.png
// The figure contains a single panel (a). This is a plot. The x-axis represents M_{ PBH} in units of solar
// masses (M_), with a range from 0.01 to 1000 and a logarithmic scale. The y-axis represents f_{ PBH} in units
// of M, with a range from 10^{-7} to 0.1 and a logarithmic scale. There are two series: one in red labeled "SM"
// and one in blue labeled "Glueballs". Both series are represented by solid lines. The trend shows that the red
// series remains relatively constant around 0.001-0.1, while the blue series has a sharp peak at M_{ PBH} 1 M_.
// The message is a comparison of the PBH mass fraction distribution for SM and Glueballs. The annotation N_c = 5
// is shown in the upper right corner.
// [figvision] imgs/fPBH_M__PNJL.png
// The figure contains a single plot. The plot has a y-axis labeled f_{ PBH} (M) with a range of 0.001 to 1 and a
// logarithmic scale, and an x-axis labeled M_{ PBH} (M_) with a range of 0.01 to 1000 and a logarithmic scale.
// There are two series: a blue line labeled PNJL and a red line labeled SM. The blue line starts at around 0.005
// and increases to a peak of around 0.07 at M_{ PBH} 1 M_, then decreases to around 0.005 at M_{ PBH} = 1000 M_.
// The red line starts at around 0.002 and increases to a peak of around 0.5 at M_{ PBH} 1 M_, then decreases to
// around 0.001 at M_{ PBH} = 1000 M_. There is an annotation = 200 MeV in the top-right corner. The trend shows
// that the PNJL model has a broader and lower peak than the SM model.
// [figvision] imgs/fPBH_M__Soliton.png
// The figure contains a single panel (a). This is a plot. The y-axis ranges from 0.001 to 1 and represents
// f_{PBH} (M). The x-axis is in solar units and ranges from 0.01 to 1000 M_{}, representing M_{PBH}. There are
// two series: a blue line labeled "Solitosynthesis" and a red line labeled "SM". Both lines are solid. The trend
// shows that both lines increase to a peak around 1 M_{} then decrease. The blue line is consistently above the
// red line except at the peak where they intersect. There is an annotation in the top right corner: T_c = 270
// MeV.
// [figvision] imgs/w_PNJL.png
// Panel a: This is a plot of the equation of state (EOS) as a function of temperature. The y-axis represents
// EOS, w(T), ranging from 0.20 to 0.34. The x-axis represents temperature, T, in GeV, on a log scale from 0.001
// to 100. There are two series: one in blue labeled "PNJL" and one in red labeled "SM". Both series have a
// similar trend, starting at around 0.33, decreasing to a minimum, and then increasing back to around 0.33. The
// PNJL series has a shallower minimum than the SM series.
// [figvision] imgs/w_glueball.png
// The figure shows a plot of the equation of state (EOS) w(T) as a function of temperature T in GeV. The y-axis
// ranges from 0.02 to 0.25 and the x-axis from 0.001 to 100 GeV on a log scale. There are four series: SM (red),
// and three Glueball model curves for N_c = 5 (blue), N_c = 10 (brown), and N_c = 30 (green). All series are
// solid lines. The SM series starts at w(T) 0.23 and remains relatively constant. The Glueball model series
// start at w(T) 0.23, decrease to a minimum around T 0.1 GeV, then increase back to w(T) 0.23. The trend shows a
// phase transition around T 0.1 GeV.
// [figvision] imgs/w_soliton.png
// The figure shows a plot of the equation of state (EOS) as a function of temperature. The x-axis represents
// temperature in GeV, ranging from 0.001 to 100, and the y-axis represents EOS, w(T), ranging from 0.20 to 0.34.
// There are two series: one in red labeled "SM" and one in blue labeled "Solitonsynthesis". Both series have a
// similar trend, starting at around 0.33, decreasing to a minimum of around 0.22 at 0.1 GeV, then increasing to
// around 0.32 at 100 GeV, with the blue series having a slightly shallower minimum. The plot has a logarithmic
// x-axis and shows two distinct dips in the EOS around 0.1 and 1 GeV.
#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    image("imgs/w_glueball.png", width: 100%),
    image("imgs/fPBH_M__Nc5.png", width: 100%),
    image("imgs/w_soliton.png", width: 100%),
    image("imgs/fPBH_M__Soliton.png", width: 100%),
    image("imgs/w_PNJL.png", width: 100%),
    image("imgs/fPBH_M__PNJL.png", width: 100%),
  ),
  caption: [
    The equation of state around the phase transition, as a function of the temperature of the Universe, and the PBH mass fraction distribution as a function of BH mass in solar units.
  ],
) <fig-pbh>

A rapid change in the equation of state of the plasma during the QCD transition will decrease the radiation pressure and thus will allow for a few (horizon) domains to collapse to form primordial black holes~@Carr:2019kxo @Garcia-Bellido:2019tvz @Bodeker:2020stj. The sensitivity to the equation of state is exponential and thus a small change in radiation pressure can completely change the PBH mass spectrum. The threshold for gravitational collapse $delta_c (w)$ is a function of the equation-of-state parameter $w(T)$, see Ref.~@Musco:2012au, so the thermal history of the Universe can induce pronounced features in the PBH mass function even for a uniform power spectrum of fluctuations. The reason being that, if the PBH form from Gaussian inhomogeneities with root-mean-square amplitude $delta_("rms")$, then the fraction of horizon patches undergoing collapse to PBH when the temperature of the Universe is $T$ should be @Carr:2019kxo

$ beta(M) approx "Erfc"[frac(delta_c (w [T(M)]), sqrt(2) delta_("rms") (M))] , $

where the temperature is related to the PBH mass by $T approx 200 sqrt(M_sun \/ M) "MeV"$.

This shows that $beta(M)$ is exponentially sensitive to $w(M)$. The present CDM fraction for PBHs of mass $M$ is then

$ f_("PBH")(M) &equiv frac(1, rho_("CDM")) frac(dif rho_("PBH")(M), dif ln M) \
  &approx frac(2 Omega_M, Omega_("CDM")) beta(M) sqrt(frac(M_("eq"), M)) , $

where $M_("eq") = 2.8 times 10^17 M_sun$ is the horizon mass at matter-radiation equality and $rho_("CDM")$ is the CDM density. We have computed the change in EOS,

$ w_i (T) = frac(p_("SM")(T) + p_i (T), rho_("SM")(T) + rho_i (T)) , $

during the thermal evolution of the universe in the three cases discussed above: Glueballs, Solitosynthesis and the PNJL model. Each one gives a different mass spectrum for PBH, when taking into account the exponentially sensitive collapse to PBH as the radiation pressure varies accross the corresponding transitions. In the case of Glueballs, it generates for large $N_c$ a delta function of PBH at a particular scale, which is strongly constrained by astrophysical and cosmological observations. On the other hand, the Solitosynthesis model changes only very slightly the PBH mass spectrum from that of the SM. Finally, the PNJL model is sufficiently different from the SM that the search for signatures of differences in the mass spectrum will eventually be detected in the mass distribution of black holes from GW interferometers like LIGO/Virgo/KAGRA, as well as with current microlensing surveys like OGLE/GAIA and future surveys like LSST.

To test the robustness of our PBH results, we changed the value of the critical temperature $T_c$ and the scale $Lambda$ to lower values (but still above the BBN scale), in order to generate peaks at higher masses, and we found no significant differences with the curves shown in @fig-pbh, which makes these mass spectra rather robust.

= Conclusions
<sec-conclusions>

In this paper, we have discussed the potential of a stochastic gravitational wave background detection at Gaia or future THEIA mission to probe early universe physics. These astrometric surveys open up a new frequency window of gravitational wave detection between LISA and pulsar timing arrays. We pointed out that there are many scenarios of phase transitions associated with dark matter such as SIMP or asymmetric dark matter, solitosynthesis, cosmic defects, and primordial black holes that can lead to detectable signals. Uncertainties in theoretical predictions are spelled out. We hope our work stimulates further discussions for the design of the missions and survey strategy in order to capture exciting physics potential.

= Low energy effective models for modeling confinement transitions
<appendix-models>

== Linear sigma model
<linear-sigma-model>

For convenience we give just the details of the potential for four light flavours

$ V(phi, T) = V_0 (phi) + V_T (phi, T) $

where

$ V_0 (phi) &= frac(1, 32) (-16 m_sigma^2 phi^2 + (kappa + 4 lambda - mu_sigma) phi^4) \
  V_T (phi, T) &= macron(J)_B (frac(m_phi^2, T^2)) + macron(J)_B (frac(m_eta^2, T^2)) + 15 macron(J)_B (frac(m_(X_8)^2, T^2)) + 8 macron(J)_B (frac(m_(X_3)^2, T^2)) + 15 macron(J)_B (frac(m_(pi_8)^2, T^2)) \
  & quad + 8 macron(J)_B (frac(m_(pi_3)^2, T^2)) + macron(J)_B (m_(eta_psi)) + macron(J)_B (frac(m_(eta_chi)^2, T^2)) . $

In the above

$ macron(J)_B (z^2) &= frac(T^4, 2 pi^2) integral_0^oo dif x x^2 log [1 - e^(sqrt(x^2 + z^2))] \
  & quad - frac(T, 12 pi) ((z^2 + frac(1, 12) (3 kappa + 17 lambda) T^2)^(3\/2) - z^3) $

and the masses are

$ m_phi &= frac(1, 24) (9 kappa phi^2 + 36 lambda phi^2 - 9 mu phi^2 + 6 mu_s - 24 m_Sigma) \
  m_eta &= frac(1, 8) (phi^2 [kappa + 4 lambda + 3 mu] + 2 mu sigma) - m_Sigma \
  m_(X_8) &= frac(1, 8) phi^2 (3 kappa + 4 lambda + mu) - m_Sigma \
  m_(X_3) &= frac(1, 24) (9 kappa phi^2 + 12 lambda phi^2 + 3 mu phi^2 - 24 m_Sigma) \
  m_(pi_8) &= frac(1, 8) phi^2 (kappa + 4 lambda - mu) - m_Sigma \
  m_(pi_3) &= frac(1, 24) (3 kappa phi^2 + 12 lambda phi^2 - 3 mu phi^2 - 24 mu ._Sigma) \
  m_(eta_psi) &= frac(1, 24) (3 phi^2 [3 kappa + 4 lambda + mu] + 18 mu_s - 24 mu_Sigma) \
  m_(eta_chi) &= frac(1, 24) (3 phi^2 [kappa + 4 lambda - mu] + 18 mu_S - 24 m_Sigma) $

== (p)NJL model
<pnjl-model>

The effective potential for the composite field, $sigma$, in both the NJL and PNJL model is as follows

$ V_("eff")^("(P)NJL") (macron(sigma), L, T) = V_0^("(P)NJL") (macron(sigma)) + V_("CW")^("(P)NJL") (macron(sigma)) + V_("FT")^("(P)NJL") (macron(sigma), L, T) $

where

$ V_0^("(P)NJL") (macron(sigma)) &= frac(3, 8 G) macron(sigma)^2 - frac(G_D, 16 G^3) macron(sigma)^3 \
  V_("CW")^("(P)NJL") (macron(sigma)) &= -frac(3 N_C, 16 pi^2) [Lambda^4 log (1 + M^2 \/ Lambda^2) - M^4 log (1 + Lambda^2 \/ M^2) + Lambda^2 M^2] \
  V_("FT")^("(P)NJL") &= -frac(6 T^2, pi^2) integral_0^oo dif x x^2 log (1 + e^(-3 sqrt(x^2 + r^2)) + 3 L e^(-sqrt(x^2 + r^2)) + 3 L e^(-2 sqrt(x^2 + r^2))) \
  & quad + T^4 (-frac(1, 2) a(T) L^2 + b(T) log [1 - 6 L^2 - 3 L^4 + 8 L^3]) . $

The last term is the potential for the glueballs and exists only in the pNJL model where the log term is from the Haar measure. We follow the strategy of ref @Helmboldt:2019pan in minimizing the potential with respect to $L$, for each value of $macron(sigma)$ to reduce the problem to a single field problem. One can choose coefficients such that the potential reproduces the surface tension and the evolution of the pressure for $N_C = 3$

$ a(T) &= a_0 + a_1 frac(T_C, T) + a_2 (frac(T_C, T))^2 \
  b(T) &= b_3 (frac(T_C, T))^3 , $

where

$ a_0 = 3.51, quad a_1 = -2.47, quad a_2 = 15.2, quad b_3 = -1.75 . $

In the above $T_C$ is an input parameter that needs to match the critical temperature of the potential. For each value of $G$ and $G_D$, one can iteratively modify $T_C$ until it matches the physical critical temperature. Finally the field dependent mass is

$ M = macron(sigma) - frac(G_D, 8 G^2) macron(sigma)^2 . $

The field $macron(sigma)$ is composite, thus the Euclidean action has a non-canonical kinetic term

$ S_3 [macron(sigma)] = 4 pi integral r^2 dif r [frac(Z_sigma^(-1), 2) (frac(dif macron(sigma), dif r))^2 + V_("eff") (macron(sigma))] $

where

$ Z_sigma^(-1) = -3 N_C (1 - frac(G_D, 4 G^2) sigma)^2 [-2 A_0 + 2 B_0 + 8 C_0 - 2 ell_A (r) + 2 ell_B (r) + 8 ell_C (r)] . $

In the above $r = |M(macron(sigma))| \/ T$ with

$ A_0 &= frac(1, 16 pi^2) [log (1 + frac(Lambda^2, M^2)) - frac(Lambda^2, Lambda^2 + M^2)] \
  B_0 &= -frac(1, 32 pi^2) frac(Lambda^4, (M^2 + Lambda^2)^2) \
  C_0 &= frac(1, 96 pi^2) frac(3 M^2 Lambda^4 + Lambda^6, (M^2 + Lambda^2)^3) $

finally the relevant thermal integrals are

$ ell_A (r) = -frac(1, 4 pi^2) integral_0^oo (frac(x^2, (x^2 + r^2)^(3\/2)) frac(1, 1 + exp [sqrt(x^2 + r^2)]) + frac(1, 2) frac(x^2, x^2 + r^2) frac(1, 1 + cosh [sqrt(x^2 + r^2)])) $

$ ell_B (r) &= frac(r^2, 16 pi^2) integral_0^oo dif x (frac(3 x^2, (x^2 + r^2)^(5\/2)) frac(1, 1 + exp [sqrt(x^2 + r^2)]) + frac(3 x^2, 2 (x^2 + r^2)^2) frac(1, 1 + cosh sqrt([x^2 + r^2])) \
  & quad + frac(x^2, 2 (x^2 + r^2)^(5\/2)) frac(1, 1 + cosh [sqrt(x^2 + r^2)])) $

$ ell_C (r) &= -frac(r^4, 96 pi^2) integral_0^oo dif x (frac(15 x^2, 2 (x^2 + r^2)^(7\/2)) frac(1, 1 + exp [sqrt(x^2 + r^2)]) + frac(15 x^2, 2 (x^2 + r^2)^3) frac(1, 1 + cosh [sqrt(x^2 + r^2)]) \
  & quad + frac(3 x^2, (x^2 + r^2)^(5\/2)) frac(tanh (frac(1, 2) sqrt(r^2 + x^2)), 1 + cosh [sqrt(x^2 + r^2)]) + frac(x^2, 2 (x^2 + r^2)^2) frac(1, 1 + cosh [sqrt(x^2 + r^2)]) \
  & quad - frac(3 x^2, 2 (x^2 + r^2)^2) frac(1, (1 + cosh sqrt(x^2 + r^2))^2)) $

#heading(level: 1, numbering: none)[Acknowledgements]

The authors would like to thank Eleanor Hall for collaboration at the early stage of this work. GW thanks David Morrissey, Oleg Popov and Djuna Croon for discussions about glueballs. JGB thanks Deyan Mihaylov for enlightening discussions on Gaia sensitivity to a SGWB and also acknowledges funding from the Research Project PGC2018-094773-B-C32 (MINECO-FEDER) and the Centro de Excelencia Severo Ochoa Program SEV-2016-0597. HM was supported by the Director, Office of Science, Office of High Energy Physics of the U.S. Department of Energy under the Contract No. DE-AC02-05CH11231, by the NSF grant PHY-1915314, by the JSPS Grant-in-Aid for Scientific Research JP20K03942, MEXT Grant-in-Aid for Transformative Research Areas (A) JP20H05850, JP20A203, by WPI, MEXT, Japan, and Hamamatsu Photonics, K.K.

#show bibliography: set text(size: 10pt)
#bibliography("refs.bib", title: [References])