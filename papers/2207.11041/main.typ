#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: (..n) => if n.pos().first() <= 1 { "" } else { str(n.pos().first() - 1) }, paper: "a4", margin: (left: 3.15cm, right: 3.15cm, top: 3.65cm, bottom: 5.28cm))
#set page(footer: context {
  let n = counter(page).get().first()
  if n > 1 { align(center)[#text(10pt)[– #(n - 1) –]] }
})
#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 1.0em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
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
  #text(24.8pt, weight: "bold", [Gravitational waves induced from primordial black hole fluctuations: The effect of an extended mass function])   #v(1.2em)
  #text(10.5pt)[Theodoros Papanikolaou]

]

#v(1.2em)





#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 12.0pt)
  #set par(first-line-indent: 0em, leading: 0.5em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 0.85em, it) } else { it }
  }
  #outline(title: none, depth: 2)
]

= Introduction
<sec:intro>
Primordial black holes (PBHs), firstly introduced in the early ‘70s~@1967SvA....10..602Z @Carr:1974nx @1975ApJ...201....1C, are formed in the early Universe before the period of star formation, out of the collapse of enhanced cosmological perturbations whose energy density is larger than a critical threshold~@Harada:2013epa @Musco:2018rwt @Papanikolaou:2022cvo. These objects have recently rekindled the interest of the scientific community since they can address a number of issues of modern cosmology. They may indeed account for a part or the totality of dark matter @Chapline:1975ojl, while additionally they can explain the large-scale structure formation through Poisson fluctuations @Meszaros:1975ef @Afshordi:2003zb. Furthermore, they can potentially seed the supermassive black holes residing in the galactic centers~@1984MNRAS.206..315C @Bean:2002kx, while at the same time they can act as viable candidates for the progenitors of black-hole merging events~@LIGOScientific:2018mvr. Other indications in favor of the PBH scenario can be found in~@Clesse:2017bsw.


On the other hand, given the huge progress in the field of GW astronomy there were numerous attempts connecting PBHs with gravitational waves~@Sasaki:2018dmp. Interestingly, one can connect PBHs with GWs associated to PBH merging events~@Nakamura:1997sm @Ioka:1998nz @Eroshenko:2016hmn @Raidal:2017mfl @Zagorac:2019ekv @Hooper:2020evu, with the SGWB of PBH Hawking radiated-gravitons~@Anantua:2008am @Dong:2015yjs as well as with GWs associated with an early matter-dominated era~@Jedamzik:2010hq @Assadullahi:2009nf @Dalianis:2020gup during which PBHs can be abundantly produced. In particular, within the last decade there has been witnessed an intense interest regarding the connection of PBHs with non linearly scalar induced gravitational waves (SIGW) generated at second order in cosmological perturbation theory~@Bugaev:2009zh @Saito_2009 @Nakama_2015 @Yuan:2019udt @Fumagalli:2020nvq given the fact that the same scalar perturbations that once enhanced collapse and form PBHs they can couple at second order with tensor perturbations and generate GWs \[See~@Domenech:2021ztg for a recent review\].


However, apart from the aforementioned connection channels of PBHs with GW signals, it has been recently noted in @Papanikolaou:2020qtd, and further studied within GR @Domenech:2020ssp@Kozaczuk:2021wcl and modified gravity setups @Papanikolaou:2021uhe@Papanikolaou:2022hkg, that initially PBH Poisson isocurvature perturbations during a radiation-dominated (RD) era can be converted to adiabatic curvature perturbations in a subsequent PBH-dominated era and induce non-linearly a second order GW background at scales much larger than the PBH mean separation scale.


In this paper, we investigate this aspect by accounting for extended PBH mass functions. In particular, after giving in @sec:PBH_formation the basics of the PBH formation formalism and computing the PBH mass function from a cosmologically motivated primordial curvature power spectrum we study in @sec:dynamical_Omega_PBH the dynamical evolution of the background. Followingly, in @sec:PBH_grav_potential we extract the PBH gravitational potential, acting as the source of the SIGWs, while in @sec:dynamical_PBH_grav_potential we account for its dynamical evolution. Then, in @sec:SIGW we deduce the respective GW signal by checking as well its potential detectability with LISA. Finally, @sec:conclusions is devoted to conclusions.


= The primordial black hole formation formalism
<sec:PBH_formation>
== From the comoving curvature perturbation to the energy density contrast
<sec:delta_vs_zeta>
Assuming spherical symmetry on superhorizon scales, the overdensity region which collapses to form a black hole can be described by the following asymptotic form of the metric


$ upright(d) s^2 = - upright(d) t^2 + a^2 ( t ) e^(zeta ( r )) [upright(d) r^2 + r^2 upright(d) Omega^2] , $


where $a ( t )$ is the scale factor and $zeta ( r )$ is the comoving curvature perturbation which is conserved on superhorizon scales. This curvature perturbation is directly related with the energy density contrast in the comoving gauge, the one standardly used in the PBH literature, though the following expression:


$ frac(delta rho, rho_(upright(b))) & equiv & frac(rho ( r , t ) - rho_(upright(b)) ( t ), rho_(upright(b)) ( t )) = - (frac(1, a H))^2 frac(4 ( 1 + w ), 5 + 3 w) e^(- 5 zeta ( r ) / 2) nabla^2 e^(zeta ( r ) / 2) , $<eq:zeta_vs_delta:non_linear>


where $H ( t ) = dot(a) ( t ) / a ( t )$ is the Hubble parameter and $w$ is the equation-of-state parameter defined as the ratio between the total pressure $p$ and the total energy density $rho$, i.e. $w equiv p / rho$. In the linear regime where $zeta lt.double 1$ @eq:zeta_vs_delta:non_linear is reduced to


$ frac(delta rho, rho_(upright(b))) tilde.eq - frac(1, a^2 H^2) frac(2 ( 1 + w ), 5 + 3 w) nabla^2 zeta ( r ) arrow.r.double delta_k = - frac(k^2, a^2 H^2) frac(2 ( 1 + w ), 5 + 3 w) zeta_k . $<eq:zeta_vs_delta:linear>


From the above relation, one sees that there is an one-to-one correspondence between $zeta_k$ and $delta_k$ meaning that statistical properties of $zeta_k$ are inherited to $delta_k$. Thus, assuming a Gaussian statistical distribution for $zeta_k$ as suggested from the observations entails the gaussianity of the energy density perturbations as well. However, the process of PBH formation is a non linear process and one expects that the amplitude of the critical threshold $delta_(upright(c))$ to be in general non-linear. Consequently, one one should consider the full non-linear relation between $zeta$ and $delta$ given by @eq:zeta_vs_delta:non_linear. At the end, one can show that the smoothed energy density contrast $delta_(upright(m))$ is related with the linear Gaussian energy density contrast $delta_l$ through the following expression ~@DeLuca:2019qsy @Young:2019yug


$ delta_(upright(m)) = delta_l - 3 / 8 delta_l^2 . $<eq:delta_m_smoothed>


At this point, we should highlight the fact that the use of $zeta$ for the computation of the PBH mass function vastly overestimates the number of PBHs since scales larger than the PBH scale which are unobservable are not removed when the PBH distribution is smoothed~@Young:2014ana. Consequently, one should use $delta$ instead given the $k^2$ damping on large scales as it can be seen by @eq:zeta_vs_delta:linear.


== Smoothing the energy density perturbation
<sec:smoothing>


In order now to proceed to the extraction of the PBH mass function due to the gravitational collapse of non-Gaussian energy density perturbations, we make use of @eq:delta_m_smoothed and we work with the linear Gaussian energy density contrast denoted as $delta_l$. To do so, we smooth firstly the energy density contrast $delta_l$ with a window function over scales smaller than the horizon scale avoiding in this way the formation of PBHs on small scales. The large scales which remain unobservable are naturally removed due to the $k^2$ damping of $delta$ as it can be seen in @eq:zeta_vs_delta:linear. Thus, one can write the smoothed energy density contrast as follows:


$ delta_l^R = integral upright(d)^3 arrow(x)' W ( arrow(x) , R ) delta ( arrow(x) - arrow(x)' ) = integral_0^oo 4 pi r^2 W ( r , R ) delta ( r ) upright(d) r , $


where the first and the second equalities are in cartesian and spherical coordinates respectively and the function $W ( arrow(x) , R )$ is the smoothing window function. Throughout the paper, we will assume a volume-normalised Gaussian window function, whose Fourier transform is given by ~@Young:2014ana


$ tilde(W) ( R , k ) = e^(- k^2 R^2 / 2) , $<eq:Gaussian_window_function>


with the smoothing scale $R$ being equal to the horizon scale, i.e. $R = ( a H )^(- 1)$. Regarding now the smoothed variance of the energy density field, it can be recast as


$ sigma^2 equiv chevron.l (delta_l^R)^2 chevron.r = integral_0^oo frac(upright(d) k, k) cal(P)_(delta_l) ( k , R ) = frac(4 ( 1 + w )^2, ( 5 + 3 w )^2) integral_0^oo frac(upright(d) k, k) ( k R )^4 tilde(W)^2 ( k , R ) cal(P)_zeta ( k ) . $<eq:sigma>


where in the last equality we have used @eq:zeta_vs_delta:linear and $cal(P)_(delta_l) ( k , R )$ and $cal(P)_zeta ( k )$ stand for the reduced energy density and curvature power spectra respectively.


As regards the PBH mass, it is generally considered to be of the order of the horizon mass at PBH formation time, namely the horizon crossing time. More precisely, as it has been demonstrated in~@Niemeyer:1997mt @Niemeyer:1999ak @Musco:2008hv @Musco:2012au, the PBH mass spectrum should follow a critical collapse scaling law which reads as


$ M_(upright("PBH")) = M_(upright(H)) cal(K) ( delta - delta_(upright(c)) )^gamma , $<eq:PBH_mass_scaling_law>


where $M_(upright(H))$ is the mass within the cosmological horizon at horizon crossing time, and $gamma$ is the critical exponent which depends on the equation-of-state parameter at the time of PBH formation. For radiation it is $gamma tilde.eq 0.36$. The parameter $cal(K)$ is a parameter that depends on the equation-of-state parameter and on the particular shape of the collapsing overdensity region. In the following we consider a representative value of $cal(K) tilde.eq 4$, which corresponds to an initial Mexican-hat energy density perturbation profile with $delta_(upright(c)) tilde.eq 0.55$.


== Calculating the mass function within peak theory
<sec:beta_peak>
One then can proceed to the derivation of the PBH mass function $beta ( M )$. In the following, we choose to work within the context of peak theory where the density of sufficiently rare and large peaks for a random Gaussian density field in spherical symmetry is given by~@Bardeen:1985tr


$ cal(N) ( nu ) = frac(mu^3, 4 pi^2) nu^3 / sigma^3 e^(- nu^2 / 2) , $<eq:peak_density>


where $nu equiv delta / sigma$ and $sigma$ is given by @eq:sigma. The parameter $mu$ is the first moment of the smoothed power spectrum given by


$ mu^2 = integral_0^oo frac(upright(d) k, k) cal(P)_(delta_l) ( k , R ) (frac(k, a H))^2 = frac(4 ( 1 + w )^2, ( 5 + 3 w )^2) integral_0^oo frac(upright(d) k, k) ( k R )^4 tilde(W)^2 ( k , R ) cal(P)_zeta ( k ) (frac(k, a H))^2 . $


At the end, the fraction of the energy of the Universe at a peak of a given height $nu$ which collapses to form a PBH, $beta_nu$ will be given by


$ beta_nu = frac(M_(upright("PBH")) ( nu ), M_(upright(H))) cal(N) ( nu ) Theta ( nu - nu_(upright(c)) ) $


and the total energy fraction of the Universe contained in PBHs of mass $M$ reads as


$ beta ( M ) = integral_(nu_(upright(c)))^(frac(4, 3 sigma)) upright(d) nu frac(cal(K), 4 pi^2) (nu sigma - 3 / 8 nu^2 sigma^2 - delta_(upright(c)))^gamma frac(mu^3 nu^3, sigma^3) e^(- nu^2 / 2) , $<eq:beta_full_non_linear>


where $nu_(upright(c)) = delta_(upright(c) , l) / sigma$ and $delta_(upright(c) , l) = 4 / 3 (1 - sqrt(frac(2 - 3 delta_(upright(c)), 2)))$.


Finally, accounting for the expansion of the Universe which makes the PBH mass function increasing linearly with the scale factor during an RD era, the overall PBH abundance defined as $Omega_(upright("PBH")) equiv rho_(upright("PBH")) / rho_(upright("tot"))$, where $rho_(upright("tot"))$ is the total energy density of the Universe, will be the integrated PBH mass function and will read as follows:


$ Omega_(upright("PBH")) ( t ) = integral_(M_(upright("min")))^(M_(upright("max"))) (frac(M_(upright(H)) ( t ), M))^(1 / 2) beta ( M ) upright(d) ln M , $<eq:Omega_PBH>


where $M_(upright(H)) ( t )$ is the mass within the cosmological horizon at time $t$. Note that in @eq:Omega_PBH we have accounted for the fact that during the RD era $M_(upright(H)) tilde a^2$ while no considering the effect of Hawking evaporation which is studied in the following sections.


== The primordial curvature power spectrum
<the-primordial-curvature-power-spectrum>
In the following, we choose to work with a power-law primordial curvature power spectrum $cal(P)_(upright(zeta)) ( k )$ which can be recast in the following form:


$ cal(P)_(upright(zeta)) ( k ) = A_zeta (k / k_(upright(0)))^(n_(upright(s)) ( k ) - 1) , $<eq:P_zeta_full>


with $A_zeta$ being the amplitude of the comoving curvature perturbation power spectrum, $k_0$ a characteristic pivot scale and $n_(upright(s)) ( k )$ the scalar spectral index. The scale dependence of $n_(upright(s)) ( k )$ can be in general parametrised as follows#cite(<Kosowsky:1995aa>):


$ n_(upright(s)) ( k ) = n_(upright(s), upright(0)) + frac(alpha_(upright(s)), 2 !) ln (k / k_0) - frac(beta_(upright(s)), 3 !) ln^2 (k / k_0) + . . . $


In the following, we will consider the above expansion of $n_(upright(s))$ by considering up to $O [ln (k / k_0)]$ terms.


In the following, given the fact that $A_zeta$ and $n_(upright(s), upright(0))$ are measured with a high statistical significance on the CMB scales, we normalise $A_zeta$ and $n_(upright(s), upright(0))$ in @eq:P_zeta_full with respect to their values $A_zeta = 2.2 times 10^(- 9)$ and $n_(upright(s), upright(0)) = 0.9603$ on the CMB pivot comoving scale, namely $k_0 = 0.05 upright("Mpc")^(- 1)$~@Planck:2018vyg. Thus, in our physical setup the running of the spectral index $alpha_(upright(s))$ is a free parameter of our cosmologically motivated power spectrum being strictly larger than $0$, i.e. $alpha_(upright(s)) > 0$ in order to ensure an enhanced power on small scales where PBHs are assumed to be produced.


One should stress here that one could assume as a first approximation that the spectral index $n_(upright(s))$ is scale-independent transforming it in this way to the free parameter of our physical setup. However, this would entail no running present for an incredibly large hierarchy of scales, namely from the CMB up to the PBH scales, which is rather questionable. For this reason, in the following we consider as a first approximation the running of $n_(upright(s))$ the free parameter of the problem at hand.


Following therefore the procedure described in @sec:delta_vs_zeta, @sec:smoothing, @sec:beta_peak one can derive the PBH mass function \[See @eq:beta_full_non_linear\] which is shown in @fig:beta_alpha within the range of masses we are interested in, namely $M in [ 10 upright(g) , 10^9 upright(g) ]$. As expected there is a higher probability for smaller mass PBHs to form since $alpha_(upright(s)) > 0$. Interestingly, we see as well that an increase in $alpha_(upright(s))$ leads to an increase in the PBH mass function. In particular, for $alpha_(upright(s)) > 3.6 times 10^(- 3)$ one is met with a PBH overproduction issue, that is that the PBH abundance becomes larger than $1$, namely $Omega_(upright("PBH")) > 1$. Consequently, in the sections that follow we will restrict ourselves to $alpha_(upright(s)) lt.eq 3.6 times 10^(- 3)$.


// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering):* #it.body]
}

#figure([#block[
  #box(image("figs/beta_alpha.pdf", height: 8cm, width: 10cm))
  ]],
  caption: [
    The PBH mass function for different values of the running of the spectral index $alpha_(upright(s))$.
  ]
)
<fig:beta_alpha>



= The dynamical evolution of the background
<sec:dynamical_Omega_PBH>
In this work, we consider a gas of initially randomnly distributed in space PBHs with different masses at formation time within the range $M_(upright(f)) in [ 10 upright(g) , 10^9 upright(g) ]$ which form during the RD era and evaporate before BBN~@Kawasaki:1999na @Kawasaki:2000en @Hasegawa:2019jsa @Carr:2020gox. Each black hole evaporates with its mass decreasing according to~@Hawking:1974rv


$ M ( t ) = M_(upright(f)) (1 - frac(t - t_(upright(f)), Delta t_(upright("evap")) ( M_(upright(f)) )))^(1 / 3) thin , $


with $t_(upright(f))$ being the PBH formation time and $Delta t_(upright("evap"))$ being the black hole evaporation time reading as~@Hawking:1974rv


$ Delta t_(upright("evap")) ( M_(upright(f)) ) = frac(160, pi g_(upright("eff"))) M_(upright(f))^3 / M_(upright("Pl"))^4 , $<eq:-t_evap>


with $g_(upright("eff"))$ being the effective number of degrees of freedom. For the epochs we are interested in, namely before BBN it can be approximated as $g_(upright("eff")) tilde 100$ since it is the order of magnitude predicted by the Standard Model before the electroweak phase transition~@Kolb:1990vq.


Knowing therefore the dynamical evolution of the PBH masses, one can derive the dynamical evolution of the PBH abundance $Omega_(upright("PBH")) ( t )$ accounting for the effect of Hawking evaporation. In particular, if $macron(beta)$ denotes the mass fraction in the absence of Hawking evaporation, one can write $Omega_(upright("PBH")) ( t )$ as


$ Omega_(upright("PBH")) ( t ) = integral_(M_(upright("min")))^(M_(upright("max"))) macron(beta) (M , t) (1 - frac(t - t_(upright("ini")), Delta t_(upright("evap")) ( M_(upright(f)) )))^(1 / 3) upright(d) ln M thin , $<eq:OmegaPBH:continuous>


where $t_(upright("ini"))$ stands for the initial time of our problem at hand which is actually the time of formation of the smallest mass PBH. The lower mass bound $M_(upright("min"))$ is given as the maximum between the minimum PBH mass at formation and the PBH mass which evaporates at time $t$ defined as $M_(upright("evap")) ( t ) equiv (frac(pi g_(upright("eff")) M_(upright("Pl"))^4 Delta t_(upright("evap")), 160))^(1 / 3)$. Thus, one gets that $M_(upright("min")) = max [ M_(upright(f), upright("min")) , M_(upright("evap")) ( t ) ]$


Let us see now how $macron(beta)$, which is the PBH mass function without accounting for the effect of Hawking evaporation, can be derived. To do so, we should consider the fact that the PBH energy density contained in an infinitesimal range of masses $delta ( ln M )$ is given by $delta macron(rho) = rho_(upright("tot")) macron(beta) (M , t) delta ( ln M )$. Since PBHs behave as matter with zero pressure, in the absence of Hawking evaporation, one has that $accent(delta macron(rho), ̇) + 3 H delta macron(rho) = 0$. Plugging the former expression into the latter, one gets that $(dot(rho)_(upright("tot")) + 3 H rho_(upright("tot"))) macron(beta) (M , t) + rho_(upright("tot")) dot(macron(beta)) (M , t) = 0$. Thus, one has that $macron(rho)_(upright("tot")) = macron(rho)_(upright("PBH")) + macron(rho)_(upright("rad"))$ and that in the absence of Hawking evaporation, $dot(macron(rho))_(upright("tot")) = - 3 H macron(rho)_(upright("PBH")) - 4 H macron(rho)_(upright("rad")) = - 3 H Omega_(upright("PBH")) macron(rho)_(upright("tot")) - 4 H ( 1 - Omega_(upright("PBH")) ) macron(rho)_(upright("tot")) = H macron(rho)_(upright("tot")) ( Omega_(upright("PBH")) - 4 )$. At the end, the equation for the dynamical evolution of $macron(beta)$ can be recast as:


$ dot(macron(beta)) ( M , t ) + H (Omega_(upright("PBH")) - 1) macron(beta) ( M , t ) = 0 thin . $<eq:ode:beta:bar>


Since the above equation is linear and does not depend on the PBH mass explicitly, one can introduce the function $frak(b)$ that satisfies


$ dot(frak(b)) + H (Omega_(upright("PBH")) - 1) frak(b) = 0 quad upright("with") quad frak(b) (t_(upright("instab"))) = 1 thin , $<eq:ode:frakb>


such as that $macron(beta)$ can be redefined as


$ macron(beta) (M , t) equiv macron(beta) (M , t_(upright(f))) frak(b) (t) . $<eq:frakb:beta>


The set of equations~(@eq:OmegaPBH:continuous), (@eq:ode:frakb) and~(@eq:frakb:beta) defines then a system of coupled differential equations that one can integrate numerically. At the end, the PBH and the radiation background energy densities will be given respectively by the following expressions:


$ rho_(upright("PBH")) ( t ) & = & Omega_(upright("PBH")) ( t ) rho_(upright("tot")) ( t )\
rho_(upright(r)) ( t ) & = & [1 - Omega_(upright("PBH")) ( t )] rho_(upright("tot")) ( t ) , $<eq:rho_PBH-rho_r>


where $rho_(upright("tot")) ( t )$ is given by the Friedmann equation $rho_(upright("tot")) = 3 M_(upright("Pl"))^2 H^2$.


As one can see from the left panel of @fig:Omega_PBH_alpha, the PBH abundance as we go from higher to lower energies, i.e. forward in time, increases initially linearly with the scale factor since initially when $Omega_(upright("PBH")) lt.double 1$ and Hawking evaporation is negligible, $Omega_(upright("PBH")) = rho_(upright("PBH")) / rho_(upright("tot")) prop a^(- 3) / a^(- 4) prop a$. Then at some point Hawking evaporation becomes important and $Omega_(upright("PBH"))$ starts its decreasing course. Interestingly, all the curves start to decrease roughly at the same time, which corresponds to the time at which the smallest PBH evaporates completely~@Martin:2019nuw. Furthermore, one may notice that as the running of the spectral index $alpha_(upright(s))$ increases $Omega_(upright("PBH"))$ increases as well, a behavior which is expected since as we can see from @fig:beta_alpha, an increase in $alpha_(upright(s))$ is equivalent with an increase in the PBH mass function $beta ( M )$.


In the right panel of @fig:Omega_PBH_alpha, we see the evolution of $Omega_(upright("PBH"))$ and $Omega_(upright(r))$ by choosing as our time variable the e-folds number $N$ defined as the logarithm of the scale factor $N = ln a$. As one may see, the e-folds passed between the onset of the RD era, i.e. $Omega_(upright(r)) = 0.5$ (magenta dashed vertical line in the right panel of @fig:Omega_PBH_alpha) and the time when we are fully back to the RD Universe, i.e. $Omega_(upright(r)) = 0.99$ (green dashed vertical line in the right panel of @fig:Omega_PBH_alpha) is $Delta N tilde 3$, signaling that the transition between the PBH-dominated era to the RD era is gradual. This phenomenology is kind of expected since now we are not in the monochromatic case. We have a gas of PBHs with different masses which evaporate at different times, hence rendering gradual the transition to the RD era.


#figure([#block[
  #box(image("figs/Omega_PBH_alpha.pdf", width: 49.6%)) #box(image("figs/Omega_PBH_alpha_0_00333.pdf", width: 49.6%))

  ]],
  caption: [
    #emph[Left Panel:] The dynamical evolution of the background PBH energy density for different values of $alpha_(upright(s))$. The dashed horizontal black line stands for transition point from the PBH to the radiation-dominated era, when $Omega_(upright("PBH")) = Omega_(upright(r)) = 0.5$. #emph[Right Panel:] The dynamical evolution of the background PBH and radiation energy densities in terms of the number of e-folds, $N$ for $alpha_(upright(s)) = 3.33 times 10^(- 3)$. The magenta vertical dashed line denotes the time of the onset of the radiation-dominated era, i.e. when $Omega_(upright(r)) = 0.5$ whereas the green dashed vertical line stands for the time when $Omega_(upright(r)) = 0.99$, namely when we are fully back to the radiation-dominated Universe.
  ]
)
<fig:Omega_PBH_alpha>



= The primordial black hole gravitational potential
<sec:PBH_grav_potential>
In this section, following closely~@Papanikolaou:2020qtd we extract the power spectrum of the gravitational potential of a gas of PBHs with different masses.


== The matter power spectrum of PBH Poisson fluctuations
<sec:P_delta_Poisson>


We start by describing the statistics of the PBH density field. To do so, we consider a gas of $N$ PBHs, each of them having a mass $m_i$ different from the mass of the other PBHs. We assume as well that PBHs are randomly distributed in space inside a volume $V$. Thus, the location of each PBH is not correlated with the location of other PBHs, which is equivalent to consider that each black hole behaves as a point-like particle. In this way, we neglect the existence of an apparent horizon around the position of the centre of a black hole, which defines an exclusion zone. However, within this work we will not study scales smaller than the PBH apparent horizon which are not properly described in this setup, hence focusing on scales larger than the black hole size.


Let us now consider a sphere of radius $r$ (and of volume $v = 4 pi r^3 / 3$) within the volume $V$, and denote with $P_n ( r )$ the probability that $n$ PBHs are located inside this volume. For each PBH, the probability to be inside the sphere is given by $v / V$, and the probability to be outside is given by $( V - v ) / V$, so one has


$ P_n ( r ) & = binom(N, n) (v / V)^n (1 - v / V)^(N - n) thin . $


By defining $macron(r)$ as the mean distance between black holes, such as that $V = 4 pi macron(r)^3 N / 3$, the aforementioned probability can be recast as


$ P_n ( r ) & = binom(N, n) (frac(r^3, N macron(r)^3))^n (1 - frac(r^3, N macron(r)^3))^(N - n) arrow.r_(N arrow.r oo) (r / macron(r))^(3 n) frac(e^(- r^3 / macron(r)^3), n !) , $<PDF-for-n-PBHS-inside-r>


where we have taken the large-volume limit. Such statistics are denoted as Poissonian.


The total mass of PBHs contained inside the volume $v$ is then given by $n chevron.l m_(upright("PBH")) chevron.r$ where $chevron.l M chevron.r$ is the mean PBH mass defined through the PBH mass function as


$ chevron.l M chevron.r ( t ) equiv frac(integral_(M_(upright("min")))^(M_(upright("max"))) M macron(beta) (M , t) (1 - frac(t - t_(upright("ini")), Delta t_(upright("evap")) ( M_(upright(f)) )))^(1 / 3) upright(d) ln M, integral_(M_(upright("min")))^(M_(upright("max"))) macron(beta) (M , t) upright(d) ln M) , $<eq:mean_PBH_mass>


where in order to have the correct normalisation we have divided in the denominator with the PBH abundance without the effect of Hawking evaporation \[See @eq:Omega_PBH in the case of a RD dominated Universe\]. Thus, the mean PBH energy density within the volume $v$ can be recast as


$ macron(rho)_(upright("PBH")) ( r ) = frac(n chevron.l M chevron.r, 4 / 3 pi r^3) thin . $


Using now #ref(<PDF-for-n-PBHS-inside-r>), one can obtain the two first moments of this quantity. Therefore, one firstly gets that


$ ⟨macron(rho)_(upright("PBH")) ( r )⟩ = sum_(n = 0)^oo P_n ( r ) frac(n chevron.l M chevron.r, 4 / 3 pi r^3) = frac(chevron.l M chevron.r, 4 / 3 pi macron(r)^3) , $<eq:app:rho_bar>


corresponding to the average energy density. Then, proceeding to the second moment one finds that


$ ⟨macron(rho)_(upright("PBH"))^2 ( r )⟩ = sum_(n = 0)^oo P_n ( r ) (frac(n chevron.l M chevron.r, 4 / 3 pi r^3))^2 = frac(9 chevron.l M chevron.r^2, 16 pi^2 r^6) [(r / macron(r))^3 + (r / macron(r))^6] thin . $


Combining the above expressions, one can find the variance of the energy density fluctuation,


$ ⟨delta macron(rho)_(upright("PBH"))^2 ( r )⟩ = ⟨macron(rho)_(upright("PBH"))^2 ( r )⟩ - ⟨macron(rho)_(upright("PBH")) ( r )⟩^2 = frac(9 chevron.l M chevron.r^2, 16 pi^2 macron(r)^6) (macron(r) / r)^3 thin . $<eq:rho2:1>


Followingly, let us focus on the modeling of the PBH density field. As noted in~@Papanikolaou:2020qtd one can describe the gas of PBHs in terms of a fluid with an energy density $rho_(upright("PBH")) ( bold(x) )$, and density contrast $delta rho_(upright("PBH")) ( bold(x) ) / rho_(upright("tot"))$, where $delta rho_(upright("PBH")) ( bold(x) ) = rho_(upright("PBH")) ( bold(x) ) - ⟨macron(rho)_(upright("PBH"))⟩$ and $rho_(upright("tot"))$ is the mean total energy density. At the end, $macron(rho)_(upright("PBH"))$ can be recast as


$ macron(rho)_(upright("PBH")) ( r ) & = frac(1, 4 / 3 pi r^3) integral_(| bold(x) | < r) upright(d)^3 bold(x) rho_(upright("PBH")) ( bold(x) )\
 & = ⟨macron(rho)_(upright("PBH"))⟩ + frac(rho_(upright("tot")), 4 / 3 pi r^3) integral_(| bold(x) | < r) upright(d)^3 bold(x) frac(delta rho_(upright("PBH")) ( bold(x) ), rho_(upright("tot"))) thin . $<eq:delta:rho:fluid>


Given the fact now that PBHs are randomly distributed in space, the position of PBH at location $bold(x)$ is uncorrelated with the position of a PBH at location $bold(x)'$, which entails that


$ ⟨frac(delta rho_(upright("PBH")) ( bold(x) ), rho_(upright("tot"))) frac(delta rho_(upright("PBH")) ( bold(x)' ), rho_(upright("tot")))⟩ = xi thin delta ( bold(x) - bold(x)' ) thin , $<eq:2pt:function:space:ansatz>


with $xi$ depending a priori on $bold(x)$ and $bold(x)'$. However, given the statistical homogeneity and isotropy of the underlying density field, $xi$ depends only on $| bold(x) - bold(x)' |$. Thus, by taking the average of the square of @eq:delta:rho:fluid, one can infer that


$ ⟨delta macron(rho)_(upright("PBH"))^2 ( r )⟩ = frac(9 rho_(upright("tot"))^2, 16 pi^2 r^6) 4 / 3 pi r^3 thin xi thin . $<eq:rho2:2>


By comparing @eq:rho2:1 and~@eq:rho2:2, one can identify $xi$ as $xi = 3 chevron.l M chevron.r^2 / ( 4 pi rho_(upright("tot"))^2 macron(r)^3 )$. Then, by introducing the PBH fractional energy density $Omega_(upright("PBH")) = ⟨macron(rho)_(upright("PBH"))⟩ / rho_(upright("tot"))$, @eq:2pt:function:space:ansatz can thus be recast as


$ ⟨frac(delta rho_(upright("PBH")) ( bold(x) ), rho_(upright("tot"))) frac(delta rho_(upright("PBH")) ( bold(x)' ), rho_(upright("tot")))⟩ = 4 / 3 pi macron(r)^3 Omega_(upright("PBH"))^2 delta ( bold(x) - bold(x)' ) thin , $<eq:2pt:function:real:space>


Going now to the comoving coordinates and defining the PBH density contrast with respect to the PBH energy density, which is the dominant component of the Universe during the eMD era driven by PBHs, one can rearrange the above formula as <eq:2pt:function:comoving:space>


$ ⟨frac(delta rho_(upright("PBH")) ( bold(x) ), rho_(upright("PBH"))) frac(delta rho_(upright("PBH")) ( bold(x)' ), rho_(upright("PBH")))⟩ = 4 / 3 pi (macron(x) / a)^3 delta ( bold(x) - bold(x)' ) thin , $


where $bold(x)$ stands for the comoving coordinates. Finally, defining the power spectrum as $chevron.l delta_(bold(k)) delta_(bold(k)')^(*) chevron.r equiv P_delta ( k ) delta ( bold(k) - bold(k)' )$ where $delta_(bold(k))$ is the Fourier transform of $delta_(upright("PBH"))$ one can obtain that


$ P_delta ( k ) = frac(4 pi, 3) (macron(r) / a)^3 thin . $<eq:delta_PBH_power_spectrum>


As we can see from the above equation, $P_delta ( k )$ is independent of $k$, as expected for Poissonian statistics. At this point we should stress out that the description of the PBH gas in terms of a continuous fluid is only valid at scales larger than the PBH mean separation scale $macron(r)$, in order not to probe the granularity of the PBH density field and stay within the perturbative regime where $P_delta ( k ) < 1$. This consideration imposes an ultra-violet cutoff defined as


$ k_(upright("UV")) equiv a / macron(r) , $<k_UV>


where $macron(r)$ is given by


$ macron(r) ( t ) = (frac(3 chevron.l M ( t ) chevron.r, 4 pi rho_(upright("PBH")) ( t )))^(1 / 3) . $<eq:rbar>


At this point, one should highlight that the UV cutoff scale, usually denoted in the literature as exclusion scale, is defined as the position of the maximum of the matter correlation function, which for large scales goes to zero. Strictly speaking for the case of wide mass distributions this exclusion scale is not a single scale. One in principle should run N-body simulations with compact objects of different masses and determine the exclusion scale as the position of the maximum of the matter correlation function, a calculation which has not been fully performed yet to the best of our knowledge.


Consequently, in our work not aiming to perform computationally high cost N-body simulations for the determination of the exclusion scale, we focus on large scales imposing a UV cutoff scale related with the mean PBH separation scale defined in @eq:rbar, an approximation which works quite well in the case of monochromatic mass functions (see here~@Baldauf:2013hka for the case of large scales structures).


In our present case, given the fact that the PBH mass function is tilted towards the lower masses (as it can be seen from @fig:beta_alpha), the mean PBH mass at time $t$ will be tilted towards the lowest PBH mass present at that time. Thus, the mean PBH separation scale @eq:rbar will be tilted towards its lowest possible value#footnote[Note that in @sec:SIGW the PBH mean separation scale and subsequently the PBH matter power spectrum is computed at PBH domination time and then is evolved through the use of the transfer function. Thus, in @eq:rbar $rho_(upright("PBH")) ( t )$ is an increasing function of time up to PBH domination time.] leading in this way to an underestimation of the PBH matter power spectrum. In this sense, the GW amplitude and the bounds on the running of the spectral index $alpha_(upright(s))$ derived in @sec:GW_spectrum should be regarded as rather conservative.


One needs to comment as well on the possible seeding effect induced from the large mass PBHs. In general, one expects that the cloud-in-cloud phenomenon, for which small mass primordial black holes may be absorbed by bigger mass ones, is actually absent due to the fact that the formation of a primordial black hole is an extremely rare event~@MoradinezhadDizgah:2019wjf. However, in our case as it can be seen from @fig:beta_alpha we can have regimes where $beta ( M )$ can reach values up to $0.1$ so one can not treat PBH formation as a rare event. In this dense PBH formation regime, one should perform high cost numerical simulations within the excursion set formalism in order to extract the real PBH mass distribution~@Auclair:2020csm, something which is beyond the scope of this work. Interestingly, however, as it was shown in~@Auclair:2020csm for values of $beta ( M ) < 0.1$ the real PBH mass distribution differs slightly from the “raw” PBH mass function \[See @eq:beta_full_non_linear\]. The biggest change was observed in the region of small PBH masses wherever there was an extended plateau behavior of $beta ( M )$ at values of order $cal(O) ( 1 )$ - in particular $beta ( M )$ was reduced in this small mass region in order to account for the cloud-in-cloud phenomenon. This feature however is absent in our case where the $beta ( M )$ profiles exhibit a far more abrupt decrease as we go to higher PBH masses #footnote[This behavior can be physically interpreted as follows: In the case where one is met with values of $beta ( M )$ of order $cal(O) ( 1 )$ for a large range of masses the cloud-in-cloud phenomenon is unavoidable. In the case however, where $beta ( M )$ decreases abruptly as we go to higher PBH masses, which happens to be our case, the cloud-in-cloud phenomenon is suppressed since heavier mass PBHs form with a dramatically lower probability compared to smaller mass PBHs.]. For values of $a_(upright(s)) > 3.6 times 10^(- 3)$, one can observe such a plateau behavior, but for these high $a_(upright(s))$ values one is met with PBH overproduction already at formation time. Therefore, as a first approximation, in what it follows the PBH seeding effect driven by heavier PBHs will be neglected.


Concerning now accretion of the surrounding radiation, which would eventually increase the PBH mass, recent analyses~@DeLuca:2020bjf @DeLuca:2020fpg find that within the regime of Bondi-Hoyle type accretion~@1944MNRAS.104..273B accretion is negligible when $m_(upright("PBH")) < O ( 10 ) M_⊙$. Thus, in our case where we consider ultralight PBHs with masses smaller than $10^9 upright(g)$ the effect of accretion can be safely neglected.


== The power spectrum of the PBH gravitational potential
<sec:P_zeta>
We proceed now to the derivation of the power spectrum of the gravitational potential of the gas of PBHs, denoted as $Phi$, connecting it with the PBH matter power spectrum obtained in the previous section. To do so, we assume that PBHs are formed in the RD era which succeeds inflation. Considering now that PBHs are randomly distributed in space, their energy density is inhomogeneous while the total background energy density of radiation is homogeneous. Under these respects, the PBH energy density perturbations can be viewed as isocurvature Poisson fluctuations with the associated Poissonian reduced power spectrum for the PBH density contrast being read as


$ cal(P)_delta ( k ) = frac(k^3, 2 pi^2) P_delta ( k ) = frac(2, 3 pi) (k / k_(upright("UV")))^3 Theta ( k_(upright("UV")) - k ) , $<eq:reduced_P_delta>


where in the last equality we used @eq:delta_PBH_power_spectrum.


Looking now into the dynamical evolution of the PBH abundance as shown in @fig:Omega_PBH_alpha, $Omega_(upright("PBH"))$ initially starts from small values and then increases reaching at some point the value $Omega_(upright("PBH")) tilde.eq 1$. At this point, the Universe enters a PBH-matter dominated era and as a consequence the initial isocurvature PBH perturbations during the RD era will be converted to adiabatic curvature perturbations in the subsequent PBH dominated era~@Kodama:1986fg @Kodama:1986ud.


Following now closely~@Papanikolaou:2020qtd we relate $Phi$ and $delta_(upright("PBH"))$ by introducing the uniform-energy density curvature perturbation for the PBH and radiation fluids~@Wands:2000dp defined as:


$ zeta_(upright(r)) = - Phi + 1 / 4 delta_(upright(r)) $


$ zeta_(upright("PBH")) = - Phi + 1 / 3 delta_(upright("PBH")) , $


where $Phi$ is the Bardeen potential~@Bardeen:1980kt as well as the isocurvature perturbation defined by


$ S = 3 ( zeta_(upright("PBH")) - zeta_(upright(r)) ) = delta_(upright("PBH")) - frac(3 delta_(upright(r)), 4) . $<eq:isocurvature_perturbation>


At super-horizon scales $S$ is conserved, thus it can be evaluated at PBH formation time. For the PBH scales which we are interested in, we ignore the radiation contribution and as a consequence $S$ can be identified with the PBH density contrast at formation time, i.e. $delta_(upright("PBH")) ( t_(upright(f)) )$. Focusing therefore on the PBH contribution one has that $zeta tilde.eq zeta_(upright("PBH")) = zeta_(upright(r)) + S / 3 tilde.eq S / 3$. Consequently, one obtains for super-horizon scales that


$ zeta tilde.eq 1 / 3 delta_(upright("PBH")) ( t_(upright(f)) ) quad upright("for") quad k lt.double cal(H) thin . $<eq:zeta:delta:superH>


Thus, during the PBH-matter dominated era, where $w = 0$ and $Phi$ is constant in time~@Mukhanov:1990me, using the fact that on super-horizon scales $zeta tilde.eq - cal(R)$~@Wands:2000dp, where $cal(R)$ is the comoving curvature perturbation, as well as the relation between $cal(R)$ and $Phi$ in GR~@Mukhanov:1990me, we finally obtain that @Papanikolaou:2020qtd @Papanikolaou:2021uhe


$ Phi tilde.eq - 1 / 5 delta_(upright("PBH")) ( t_(upright(f)) ) quad upright("for") quad k lt.double cal(H) thin . $<eq:Phi:delta:superH00>


On the other hand, at sub-horizon scales the evolution of $delta_(upright("PBH"))$ can be determined by solving the evolution growth equation for the matter density perturbations


$ delta_(upright(m))^('') + cal(H) delta'_(upright(m)) - 4 pi G a^2 macron(rho)_(upright(m)) delta_(upright(m)) = 0 , $<eq:growth:equation:GR>


which, in the case of a Universe with radiation and PBH-matter, takes the form of the so-called Mészaros growth equation#cite(<Meszaros:1974tb>):


$ frac(upright(d)^2 delta_(upright("PBH")), upright(d) s^2) + frac(2 + 3 s, 2 s ( s + 1 )) frac(upright(d) delta_(upright("PBH")), upright(d) s) - frac(3, 2 s ( s + 1 )) delta_(upright("PBH")) = 0 thin . $<eq:Meszaros-in-GR>


By solving the above equation we deduce that the dominant solution is given by


$ delta_(upright("PBH")) = frac(2 + 3 s, 2 + 3 s_(upright(f))) delta_(upright("PBH")) ( t_(upright(f)) ) thin . $


It is important to highlight here that the aforementioned expression for the evolotion of $delta_(upright("PBH"))$ is valid at all scales, and since it does not involve the comoving scale $k$, it entails that the statistical distribution of PBHs remains of Poissonian type, i.e.~ $cal(P)_(delta_(upright("PBH"))) prop k^3$ even after formation time~@Desjacques:2018wuu @Ali-Haimoud:2018dau @MoradinezhadDizgah:2019wjf. Then, deep in the PBH-dominated era, $delta_(upright("PBH"))$ can be approximated as ~@Papanikolaou:2020qtd


$ delta_(upright("PBH")) tilde.eq frac(3 s, 2) delta_(upright("PBH")) ( t_(upright(f)) ) . $<eq:delta_PBH_sub_GR>


Thus, given the fact that the Bardeen potential is related to the PBH density perturbation through the Poisson equation, i.e. $delta_(upright("PBH")) = - 2 / 3 (k / cal(H))^2 Phi$, one can insert @eq:delta_PBH_sub_GR into the Poisson equation in order to find that


$ Phi tilde.eq - 9 / 4 (k_(upright(d)) / k)^2 thin delta_(upright("PBH")) ( t_(upright(f)) ) quad upright("for") quad k gt.double cal(H)_(upright(d)) thin , $<eq:Phi:delta:subH>


with $k_(upright(d)) equiv cal(H)_(upright(d))$ being the conformal Hubble parameter at the PBH domination time. Finally, making a crude interpolating between (@eq:Phi:delta:subH) and (@eq:Phi:delta:superH00), and using (@eq:reduced_P_delta), we obtain that


$ cal(P)_Phi ( k ) equiv frac(k^3, 2 pi^2) P_Phi ( k ) = frac(2, 3 pi) (k / k_(upright("UV")))^3 (5 + 4 / 9 k^2 / k_(upright(d))^2)^(- 2) thin . $<eq:PowerSpectrum:Phi:PBHdom>


= Evolving the primordial black hole gravitational potential
<sec:dynamical_PBH_grav_potential>
In this section, following~@Inomata:2019zqy we account for the evolution of the gravitational potential $Phi$ during the transition from the PBH-dominated era to the RD era following PBH evaporation. This is quite crucial given the fact that $Phi$ acts as the source of the SIGWs so the details of the dynamicall behavior of $Phi$ during the transition will have a huge impact on the resultant GWs.


Our physical system is comprised by matter in form of PBHs which “decays” to radiation through the process of PBH evaporation hence being similar to the decaying dark matter scenario. Consequently, by making the correspondence $rho_(upright(m)) arrow.r rho_(upright("PBH"))$ and neglecting the anisotropic stress of radiation the perturbations can be described from the following system of equations in the Newtonian gauge#footnote[We choose to work in the Newtonian gauge as it is standardly used in the literature within the context of SIGWs. The effect of the gauge dependence of the SIGWs is discussed in~@Hwang_2017 @Tomikawa:2019tvi @DeLuca:2019ufz @Yuan:2019fwv @Inomata:2019yww]#cite(<Poulin:2016nat>):


$ delta'_(upright("PBH")) & = - theta_(upright("PBH")) + 3 Phi' - a Gamma Phi\
theta'_(upright("PBH")) & = - cal(H) theta_(upright("PBH")) + k^2 Phi\
delta'_(upright(r)) & = - 4 / 3 ( theta_(upright(r)) - 3 Phi' ) + a Gamma rho_(upright("PBH")) / rho_(upright(r)) ( delta_(upright("PBH")) - delta_(upright(r)) + Phi )\
theta'_(upright(r)) & = k^2 / 4 delta_(upright(r)) + k^2 Phi - a Gamma frac(3 rho_(upright("PBH")), 4 rho_(upright(r))) (4 / 3 theta_(upright(r)) - theta_(upright("PBH"))) , $<eq:perturbations>


where $delta_alpha$ is the energy density contrast defined as $delta_alpha equiv ( rho_alpha - rho_(upright("tot")) ) / rho_(upright("tot"))$ with $alpha = (upright("PBH") , upright("rad"))$ and $theta$ is the velocity divergence for each fluid component defined as $theta equiv partial v_i / partial x_i$ with $v_i$ being the fluid velocity while primes denote differentiation with respect to the conformal time $eta$ defined as $upright(d) eta equiv upright("dt") / a$.


In the above expressions, $Gamma$ is the PBH evaporation rate. Given the fact that in our problem at hand we have different PBH masses evaporating at different times, one can define a mean PBH evaporation rate defined as


$ chevron.l Gamma chevron.r ( t ) = frac(integral_(t_(upright("evap"), upright("min")))^(t_(upright("evap"), upright("max"))) beta ( t_(upright("evap")) ) Gamma_M ( t_(upright("evap")) , t ) upright(d) ln t_(upright("evap")), integral_(t_(upright("evap"), upright("min")))^(t_(upright("evap"), upright("max"))) beta ( t_(upright("evap")) ) upright(d) ln t_(upright("evap"))) , $<eq:mean_gamma>


where the PBH evaporation rate of a PBH with mass $M$, $Gamma_M ( t_(upright("evap")) , t )$ reads as~@Hawking:1974rv @Inomata:2020lmk


$ Gamma_M ( t_(upright("evap")) , t ) equiv - 1 / M frac(upright(d) M, upright(d) t) = frac(1, 3 ( t_(upright("evap")) - t )) , $<eq:gamma_M>


with $t_(upright("evap"))$ being a function of the PBH mass given by #ref(<eq:-t_evap>). The distribution function of the PBH evaporation times can be constructed by the PBH mass function at formation and accounting for the fact that $t_(upright("evap")) prop M^3$. At the end, considering conservation of probability, i.e. $beta ( M_(upright(f)) ) upright(d) ln M_(upright(f)) = beta ( t_(upright("evap")) ) upright(d) ln t_(upright("evap"))$, one can straightforwardly show that


$ beta ( t_(upright("evap")) ) = beta [M_(upright(f)) ( t_(upright("evap")) )] . $


The time evolution of $Phi$ can be extracted from the Poisson equation and is given by#cite(<Mukhanov:2005sc>):


$ Phi' = - frac(k^2 Phi + 3 cal(H)^2 Phi + 3 / 2 cal(H)^2 (rho_(upright("PBH")) / rho_(upright("tot")) delta_(upright("PBH")) + rho_(upright(r)) / rho_(upright("tot")) delta_(upright(r))), 3 cal(H)) , $<eq:Phi_evolution>


while the time evolution of the background energy densities of PBHs and radiation is dictated by #ref(<eq:rho_PBH-rho_r>).


The above system of equations is solved numerically by adopting the following adiabatic initial conditions for the perturbations:


$ delta_(upright("PBH"), upright("ini")) = - 2 Phi_(upright("ini")) , quad delta_(upright(r), upright("ini")) = 4 / 3 delta_(upright("PBH"), upright("ini")) , quad theta_(upright("PBH"), upright("ini")) = theta_(upright(r), upright("ini")) = 0 . $<eq:initial_conditions>


Restricting ourselves to the linear regime, the overall normalisation of the perturbations does not count. Thus, we take conventionally $Phi_(upright("ini")) = 1$.


#figure([#block[
  #box(image("figs/Phi_alpha_0_00335.pdf", height: 8cm, width: 10cm))
  ]],
  caption: [
    The dynamical evolution of $Phi$ for different values of the comoving scales $k$ for $alpha_(upright(s)) = 3.35 times 10^(- 3)$.
  ]
)
<fig:Phi_alpha_0_00335>



At this point, we should stress out that we work within the linear regime where matter perturbations should be less than unity. During a matter-dominated era, like the one driven by PBHs, the PBH energy density perturbation increases linearly with the scale factor, i.e. $delta_(upright("PBH")) tilde a$, and for some scales $delta_(upright("PBH"))$ will become larger than one already before the end of the PBH-dominated phase. For this reason, one can define the non-linear scale, $k_(upright("NL"))$ as the scale whose perturbation amplitude becomes unity at the onset of the RD era, i.e. $delta_(upright("PBH") , k_(upright("NL"))) ( eta_(upright(r)) ) = 1$. Given the fact now that $| delta_(upright("PBH") , k) | tilde cal(P)_delta^(1 / 2) ( k )$, where $cal(P)_delta ( k )$ is the reduced matter power spectrum defined in @eq:reduced_P_delta, the PBH energy density pertrurbation at PBH domination time of a mode $k$ can be roughly estimated as


$ delta_k ( eta_(upright(d)) ) tilde sqrt(frac(2, 3 pi)) (k / k_(upright("UV")))^(3 / 2) $


and starts growing linearly with the scale factor once the mode enters the horizon at a conformal time $eta_k$. This is because the matter perturbations are frozen on super-Hubble scales and can only grow during the PBH-dominated era. One then can solve $delta_(upright("PBH") k_(upright("NL"))) ( eta_(upright(r)) ) = 1$ and find that the non-linear scale can be recast after a straightforward calculation as


$ k_(upright("NL")) = k_(upright("UV"))^(3 / 7) (frac(3 pi, 2))^(1 / 7) (a_(upright(d)) / a_(upright(r)))^(2 / 7) (frac(4 a_(upright(d))^2, 9 t_(upright(d))^2))^(2 / 7) . $<eq:k_NL>


Concerning now the smallest comoving scale considered in the computation of the SIGWs we want to be quite conservative choosing to work with only the scales which cross the horizon during the PBH-dominated era, namely $k_(upright(r)) lt.eq k lt.eq k_(upright(d))$~@Inomata:2019zqy. Therefore, the smallest scale considered, here or equivalently the larger comoving number, will be given by


$ k_(upright("max")) = min [ k_(upright(d)) , k_(upright("NL")) ] . $


At this point, it is very important to stress out that the PBH scales corresponding to PBH masses $M in [ 10 upright(g) , 10^9 upright(g) ]$ have entered the horizon deep in the early RD era before the onset of the PBH-dominated era. At the end, the power spectrum of the gravitational potential $Phi$ given in @eq:PowerSpectrum:Phi:PBHdom will now read as:


$ cal(P)_Phi ( k ) = frac(2, 75 pi) (k / k_(upright("UV")))^3 . $<eq:PowerSpectrum:Phi:PBHdom:k-k_d>


In @fig:Phi_alpha_0_00335, we show for $alpha_(upright(s)) = 3.35 times 10^(- 3)$ the dynamical evolution of the gravitational potential $Phi$ during the transition from the PBH-dominated era to the RD for different values of the comoving scale $k$. As one may, for modes crossing the horizon during the PBH era, the gravitational potential initially decays and soon after the onset of the RD era it starts to oscillate due to the radiation pressure. Interestingly, for values $k > 5 k_(upright(r))$ where $k_(upright(r))$ is the comoving scale crossing the Hubble radius at the onset of the RD era we see that gradually as we increase the value of $k$ the dynamical profile of $Phi$ converges towards the dynamical profile of the mode crossing the Hubble radius at the onset of the PBH-dominated era, namely $Phi_(k_(upright(d)))$. The same behavior was confirmed as well for other values of the running of spectral index $alpha_(upright(s))$. For this reason, when computing the SIGW signal in the next section we will consider only $Phi_(k_(upright(d)))$ as the dynamical profile of $Phi$ for all values of $k > 5 k_(upright(r))$ underestimating thus $Phi$ at most by a factor of $2$ in the case where $k = 5 k_(upright(r))$ as it can be seen from @fig:Phi_alpha_0_00335.


= Scalar induced gravitational waves
<sec:SIGW>
Having derived in the previous section the dynamical evolution of the gravitational potential $Phi$ which actually seed the scalar induced gravitational waves in this section we move on computing the respective SGWB associated to the PBH Poisson fluctuations.

== The tensor perturbations
<sec:tensor-perturbations>
Working in the Newtonian gauge and assuming zero anisotropic stress, the perturbed metric can be recast in the following form:


$ upright(d) s^2 = a^2 ( eta ) {- ( 1 + 2 Phi ) upright(d) eta^2 + [( 1 - 2 Phi ) delta_(i j) + h_(i j) / 2] upright(d) x^i upright(d) x^j} , $<metric-decomposition-with-tensor-perturbations>


where we have multiplied by a factor $1 / 2$ the second order tensor perturbation as is standard in the literature#footnote[The contribution from the first-order tensor perturbations is not considered in this work.]. Then, by performing a Fourier transform of the tensor perturbation and accounting for the two polarization states of the GWs in GR, the equation of motion for the tensor modes $h_(bold(k))$ reads as


$ h_(bold(k))^(s ,'') + 2 cal(H) h_(bold(k))^(s ,') + k^2 h_(bold(k))^s = 4 S_(bold(k))^s thin , $<Tensor-Eq.-of-Motion>


where $s = ( + ) , ( times )$. The source function $S_(bold(k))^s$ is given by


$ S_(bold(k))^s = integral frac(upright(d)^3 bold(q), ( 2 pi )^(3 / 2)) e_(i j)^s ( bold(k) ) q_i q_j [2 Phi_(bold(q)) Phi_(bold(k - q)) + frac(4, 3 ( 1 + w_(upright("tot")) )) ( cal(H)^(- 1) Phi'_(bold(q)) + Phi_(bold(q)) ) ( cal(H)^(- 1) Phi'_(bold(k - q)) + Phi_(bold(k - q)) )] , $<eq:Source:def>


The polarization tensors $e_(i j)^s ( k )$ are defined as~@Espinosa:2018eve


$ e_(i j)^(( + )) ( bold(k) ) = 1 / sqrt(2) mat(delim: "(", 1, 0, 0; 0, - 1, 0; 0, 0, 0) , quad e_(i j)^(( times )) ( bold(k) ) = 1 / sqrt(2) mat(delim: "(", 0, 1, 0; 1, 0, 0; 0, 0, 0) . $


One now can proceed by writing the Fourier transform of $Phi$, i.e. $Phi_(bold(k)) ( eta )$, as $Phi_(bold(k)) ( eta ) = Phi ( eta ) phi.alt_(bold(k))$, where $phi.alt_(bold(k))$ is the value of the gravitational potential at some initial time (which here we consider it to be the time at which PBHs dominate the energy content of the Universe, $eta_(upright(d))$) and $Phi ( eta )$ is the gravitational potential transfer function being actually the solution of @eq:Phi_evolution. Consequently, @eq:Source:def can be written in a compact form as


$ S_(bold(k))^s = integral frac(upright(d)^3 q, ( 2 pi )^(3 / 2)) e^s ( bold(k) , bold(q) ) F ( bold(q) , bold(k - q) , eta ) phi.alt_(bold(q)) phi.alt_(bold(k - q)) thin , $<Source>


where


$ F ( bold(q) , bold(k - q) , eta ) & equiv 2 Phi ( q eta ) Phi (| bold(k) - bold(q) | eta) + frac(4, 3 ( 1 + w )) [cal(H)^(- 1) Phi' ( q eta ) + Phi ( q eta )]\
 & med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med dot.op [cal(H)^(- 1) Phi' (| bold(k) - bold(q) | eta) + Phi (| bold(k) - bold(q) | eta)] , $<F>


where the prime denotes differentiation with respect to the conformal time, that is, $Phi' ( q eta ) equiv partial Phi ( q eta ) / partial eta = q partial Phi ( q eta ) / partial ( q eta )$. The contraction $e_(i j)^s ( bold(k) ) q_i q_j equiv e^s ( bold(k) , bold(q) )$ can be expressed in terms of the spherical coordinates $( q , theta , phi )$ of the vector $bold(q)$ as $ e^s ( bold(k) , bold(q) ) = cases(
    1 / sqrt(2) q^2 sin^2 theta cos 2 phi thin upright("for") thin s = ( + ),
    1 / sqrt(2) q^2 sin^2 theta sin 2 phi thin upright("for") thin s = ( times )
  ) thin . $At the end, the tensor modes$h_(bold(k))^s$can be obtained using the Green's function formalism where one can write$h_(bold(k))^s$ as


$ h_(bold(k))^s ( eta ) = frac(4, a ( eta )) integral_(eta_(upright(d)))^eta upright(d) macron(eta) thin G_(bold(k))^s ( eta , macron(eta) ) a ( macron(eta) ) S_(bold(k))^s ( macron(eta) ) , $<tensor-mode-function>


where the Green's function $G_(bold(k))^s ( eta , macron(eta) )$ is the solution of the homogeneous equation


$ G_(bold(k))^(s ,'') ( eta , macron(eta) ) + (k^2 - a^('') / a) G_(bold(k))^s ( eta , macron(eta) ) = delta (eta - macron(eta)) , $<Green-function-equation>


with the boundary conditions $lim_(eta arrow.r macron(eta)) G_(bold(k))^s ( eta , macron(eta) ) = 0$ and $lim_(eta arrow.r macron(eta)) G_(bold(k))^(s ,') ( eta , macron(eta) ) = 1$. Below, we will use the Green's functions during the transition from a MD era to an RD era as well as during an RD era. Following closely~@Kohri:2018awv @Inomata:2019zqy one can show that


$ k G_k^(upright("MD") arrow.r upright("RD")) ( x , macron(x) ) = C ( x , x_(upright(r)) ) macron(x) j_1 ( macron(x) ) + D ( x , x_(upright(r)) ) macron(x) y_1 ( macron(x) ) , quad k G_k^(upright("RD")) ( x , macron(x) ) = sin ( x - macron(x) ) , $


where $j_1$ and $y_1$ are the first and second spherical Bessel functions and the coefficients $C$ and $D$ read as


$ C ( x , x_(upright(r)) ) = frac(sin x - 2 x_(upright(r)) ( cos x + x_(upright(r)) sin x ) + sin ( x - 2 x_(upright(r)) ), 2 x_(upright(r))^2) , $


$ D ( x , x_(upright(r)) ) = frac(( 2 x_(upright(r))^2 - 1 ) cos x - 2 x_(upright(r)) sin x + cos ( x - 2 x_(upright(r)) ), 2 x_(upright(r))^2) $


by requiring continuity of the Green function $k G_k^(upright("MD") arrow.r upright("RD")) ( x , macron(x) )$ and its derivative at the transition time $macron(x) = x_(upright(r))$.

== The gravitational-wave spectrum
<sec:GW_spectrum>
Having derived above the tensor perturbations, we derive below the gravitational-wave spectrum. To do so, we extract firstly the tensor power spectrum, $cal(P)_h ( eta , k )$ which is defined through the following relation:


$ chevron.l h_(bold(k))^r ( eta ) h_(bold(k)')^(s , *) ( eta ) chevron.r equiv delta^(( 3 )) ( bold(k) - bold(k)' ) delta^(r s) frac(2 pi^2, k^3) cal(P)_h^s ( eta , k ) , $<tesnor-power-spectrum-definition>


where $s = ( times )$ or $( + )$. Thus, after a straightforward but rather long calculation one acquires that $cal(P)_h ( eta , k )$ for the $( times )$ and $( + )$ polarization states can be recast as ~@Ananda:2006af @Baumann:2007zm @Kohri:2018awv @Espinosa:2018eve


$ cal(P)_h^(( s )) ( eta , k ) = 4 integral_0^oo upright(d) v integral_(| 1 - v |)^(1 + v) upright(d) u [frac(4 v^2 - ( 1 + v^2 - u^2 )^2, 4 u v)]^2 I^2 ( u , v , x ) cal(P)_Phi ( k v ) cal(P)_Phi ( k u ) thin , $<Tensor-Power-Spectrum>


The two auxiliary variables $u$ and $v$ are defined as $u equiv | bold(k) - bold(q) | / k$ and $v equiv q / k$, and the kernel function $I ( u , v , x )$ is given by


$ I ( u , v , x ) = integral_(x_(upright(d)))^x upright(d) macron(x) thin frac(a ( macron(x) ), a ( x )) thin k thin G_k^s ( x , macron(x) ) F_k ( u , v , macron(x) ) . $<I-function>


In the above expressions, $x = k eta$ and $F_k ( u , v , eta ) equiv F ( k , | bold(k) - bold(q) | , eta )$ given the fact that the function $F ( bold(q) , bold(k - q) , eta )$ depends only on the modulus of its first two arguments.


In what follows, by accounting for the transition from the PBH-dominated era to the RD era and the continuity of the scale factor and the Hubble parameter, $a$ and $H$ are given by the following expressions in terms of the cosmic and the conformal times : $ a ( t ) = cases(
    a_(upright("d")) ( t / t_(upright("d")) )^(2 / 3) quad upright("for") thin t < t_(upright("r")),
    a_(upright("r")) ( t / t_(upright("r")) )^(1 / 2) quad upright("for") thin t > t_(upright("r"))
  ) arrow.r^(upright("d") t equiv upright("d") eta) a ( eta ) = {a_(upright("d")) ( frac(eta - eta_(upright("d")), A_1) + 1 )^2 quad upright("for") thin eta < eta_(upright("r"))\
a_(upright("r")) ( frac(eta - eta_(upright("r")), A_2) + 1 ) quad upright("for") thin eta > eta_(upright("r")) $<eq:scale_factor>$ H ( t ) = cases(
    frac(2, 3 t) quad upright("for") thin t < t_(upright("r")),
    frac(1, 2 t) quad upright("for") thin t > t_(upright("r"))
  ) arrow.r^(upright("d") t equiv upright("d") eta) cal(H) ( eta ) equiv a' / a = {frac(2, eta - eta_(upright("d")) + A_1) quad upright("for") thin eta < eta_(upright("r"))\
frac(2 A_2, eta_(upright("r")) - eta_(upright("d")) + A_1) frac(1, eta - eta_(upright("r")) + A_2) quad upright("for") thin eta > eta_(upright("r")) , $<eq:Hubble_parameter> where$""'$denotes differentiation with respect to the conformal time,$A_1 = 3 t_(upright(d)) / a_(upright(d))$and$A_2 = 2 t_(upright(r)) / a_(upright(r))$. Thus, the kernel function in #ref(<I-function>) for times within the RD era, i.e.$x > x_(upright(r))$, can be recast as follows:


$ I ( u , v , x ) & = integral_(x_(upright(d)))^(x_(upright(r))) upright(d) macron(x) (frac(macron(x) - x_(upright(d)) + A_1 k, x_(upright(r)) - x_(upright(d)) + A_1 k))^2 frac(A_2 k, x - x_(upright(r)) + A_2 k) k G_k^(upright("MD") arrow.r upright("RD")) ( x , macron(x) ) F_k ( u , v , macron(x) )\
 & + integral_(x_(upright(r)))^x upright(d) macron(x) frac(macron(x) - x_(upright(r)) + A_2 k, x - x_(upright(r)) + A_2 k) k G_k^(upright("RD")) ( x , macron(x) ) F_k ( u , v , macron(x) ) . $<eq:I_function_expanded_RD>


At the end, using the flat spacetime approximation and treating the tensor perturbations as freely propagating GWs one can find~@Maggiore:1999vm that the GW spectral abundance defined as the GW energy density per logarithmic comoving scale can be recast as~@Kohri:2018awv


$ Omega_(upright("GW")) ( eta , k ) equiv 1 / macron(rho)_(upright("tot")) frac(upright(d) rho_(upright("GW")) ( eta , k ), upright(d) ln k) = 1 / 24 (frac(k, cal(H) ( eta )))^2 overline(cal(P)_h^(( s )) ( eta , k )) , $<Omega_GW>


where $s = ( times )$ or $( + )$.


In order now to compute the GW spectral abundance at our present epoch, one must evolve $Omega_(upright("GW")) ( eta , k )$ from a reference conformal time $eta_(upright(*))$, where GWs start propagating as free waves, up to today. Doing so, one has that


$ Omega_(upright("GW")) ( eta_0 , k ) = frac(rho_(upright("GW")) ( eta_0 , k ), rho_(upright(c)) ( eta_0 )) = frac(rho_(upright("GW")) ( eta_(upright(*)) , k ), rho_(upright(c)) ( eta_(upright(*)) )) (a_(upright(*)) / a_(upright(0)))^4 frac(rho_(upright(c)) ( eta_(upright(*)) ), rho_(upright(c)) ( eta_0 )) = Omega_(upright("GW")) ( eta_(upright(*)) , k ) Omega_(upright(r))^(( 0 )) frac(rho_(upright(r), upright(*)) a_(upright(*))^4, rho_(upright(r), upright(0)) a_0^4) , $


where we have taken into account that $Omega_(upright("GW")) tilde a^(- 4)$, and where the index $0$ refers to the present time. Then, considering that the radiation energy density reads as $rho_r = pi^2 / 15 g_(* upright(rho)) T_(upright(r))^4$ and that the temperature of the radiation bath $T_(upright(r))$, scales as $T_(upright(r)) prop g_(* upright(S))^(- 1 / 3) a^(- 1)$, one finds that


$ Omega_(upright("GW")) ( eta_0 , k ) = Omega_r^(( 0 )) g_(* upright(rho) , upright(*)) / g_(* upright(rho) , 0) (g_(* upright(S) , upright(0)) / g_(* upright(S) , upright(*)))^(4 / 3) Omega_(upright("GW")) ( eta_(upright(*)) , k ) , $<Omega_GW_RD_0>


where $g_(* upright(rho))$ and $g_(* upright(S))$ stand for the energy and entropy relativistic degrees of freedom. In order to choose the reference conformal time $eta_(upright(*))$ after which GWs behave as free waves one should account for the fact that as it can be seen from @fig:Phi_alpha_0_00335 during the RD era, the gravitational potential, which is the source of the SIGWs, decays on subhorizon scales. Consequently, $Omega_(upright("GW"))$ becomes constant after the gravitational potential has sufficiently decayed during RD. As noted in~@Inomata:2019zqy, $eta_(*) tilde cal(O) ( 1 ) eta_r$. Here, being quite conservative we take it $eta_(upright(*)) = 10 eta_(upright(r))$.


In order to ensure an eMD phase driven by PBHs one should require on the one hand that $eta_(upright(r)) gt.eq eta_(upright(d))$. Since now an increase of $alpha_(upright(s))$ entails an increase of the PBH abundance by requiring that $eta_(upright(r)) gt.eq eta_(upright(d))$ one can find a lower bound on $alpha_(upright(s))$. As it was found numerically, in order to have an eMD phase driven by PBHs, $alpha_(upright(s)) gt.eq 3.316 times 10^(- 3)$.


On the other hand, one needs to avoid the GW constraints at BBN as well. In particular, one has that the constraint on the energy density contribution of GWs at BBN time is $Omega_(upright("GW"), upright("BBN")) < 0.05$.#footnote[We used the fact that $Omega_(upright("GW"), upright("BBN")) < 7 / 8 (4 / 11)^(4 / 3) Delta N_(upright("eff")) tilde 0.05$~@Caprini:2018mtu accounting for the latest Planck 2018 upper bound on $Delta N_(upright("eff"))$, namely $Delta N_(upright("eff")) < 0.2$~@Planck:2018vyg.] At the end, one can translate this upper bound on $Omega_(upright("GW"), upright("BBN"))$ on an upper bound on the running of the spectral index $alpha_(upright(s))$ since as explained before an increase in $alpha_(upright(s))$ signals an increase in the duration of the PBH-dominated phase and consequently an increase on the amplitude of the SIGWs associated to PBH Poisson fluctuations. Interestingly, we found numerically that in order to avoid GW overproduction at BBN we obtain that $alpha_(upright(s)) < 3.355 times 10^(- 3)$. At the end, the observationally interesting window for $alpha_(upright(s))$ can be read as follows:


$ 3.316 times 10^(- 3) < alpha_(upright(s)) < 3.355 times 10^(- 3) . $<eq:alpha_constraints_GW_section>


As one can see, it is quite narrow signaling the very high sensitivity of the SIGW signal on the spectral index.


This behavior can be verified in @fig:GW_ns where we show in logarithmic scale the GW amplitude of the SIGWs associated to PBH Poisson fluctuations as a function of the frequency in $upright("Hz")$ for different values of the running of the spectral index $alpha_(upright(s))$ within the observationally interesting window @eq:alpha_constraints_GW_section#footnote[As explained in @sec:dynamical_PBH_grav_potential approximating $Phi$ with $Phi_(k_(upright("kd")))$ underestimates at most by a factor of $2$ its true value. Therefore, since from #ref(<Tensor-Power-Spectrum>) and @Omega_GW, $Omega_(upright("GW")) tilde Phi^4$, in the GW signal curves shown in @fig:GW_ns we have multiplied the GW spectral abundance with a factor $2^4 = 16$ accounting for the underestimation of the gravitational potential $Phi$.]. Astonishingly, an increase in the third digit after comma in $alpha_(upright(s))$ is equivalent with an increase of a factor of $10$ in the amplitude of the GWs! We also find a characteristic oscillatory feature of the SIGW signal which is a characteristic signature of the gradualness of the transition from the PBH-dominated to the RD era as already noted in~@Inomata:2019zqy.


Very interestingly, we find as well that the frequency of the SIGWs studied here lies within the frequency band of LISA~@Audley:2017drz with the respective SIGW amplitude being orders of magnitude higher than the lowest GW amplitude detectable with LISA. Thus, the SIGW signal studied here, constituting a characteristic signature of PBHs given also its oscillatory pattern, can be potentially detectable by LISA.


#figure([#block[
  #box(image("figs/Omega_GW_alpha.pdf", height: 8cm, width: 10cm))
  ]],
  caption: [
    The scalar induced gravitational-wave spectrum for different values of the running of the spectral index $alpha_(upright(s))$. With the magenta dashed curve we show also the LISA gravitational-wave sensitivity curve while with the black dashed horizontal line we show the upper limit on the amplitude of gravitational waves from BBN constraints.
  ]
)
<fig:GW_ns>



= Conclusions
<sec:conclusions>
In this paper, we have studied the scalar induced gravitational waves associated to the Poisson energy density fluctuations of ultralight PBHs with masses $M < 10^9 upright(g)$ which evaporate before BBN and can potentially trigger an eMD era. During our analysis, we accounted for the effect of an extended PBH mass function, an aspect which was never studied before in the literature to the best of our knowledge.


Following closely the analysis of~@Papanikolaou:2020qtd we studied carefully the PBH density field and extracted at the end the matter power spectrum of PBHs whose the initial spatial distribution follows Poisson statistics. Then, following~@Inomata:2019zqy, we studied the dynamical behavior of the background and the perturbations accounting carefully for the evolution of the PBH gravitational potential $Phi$, seeding the SIGWs, during the gradual transition from the PBH-dominated era to the RD era.


We focused mainly on the SIGWs which are sourced from the gravitational potential of modes $k$ which cross the Hubble radius during the eMD era driven by PBHs while at the same time we discarded the modes which become non-linear during the PBH-dominated era by imposing an appropriately chosen non-linear cutoff scale $k_(upright("NL"))$.


At the end, we applied our formalism for the computation of the SIGWs by adopting a cosmologically motivated power-law primordial curvature power spectum for the generation of the gas of PBHs. Interestingly, we found an oscillatory GW signal which is quite sensitive on the running of the spectral index $alpha_(upright(s))$ of the power spectrum responsible for the PBH generation. By requiring that PBHs can drive an eMD era and accounting as well for GW constraints from BBN we set an observational window for $alpha_(upright(s))$, namely


$ 3.316 times 10^(- 3) < alpha_(upright(s)) < 3.355 times 10^(- 3) . $<eq:alpha_constraints>


Interestingly, we found that the frequency of the SIGWs studied here lies within the frequency band of LISA with the respective GW amplitude being orders of magnitude higher than the lowest GW amplitude detectable by LISA. Thus, the SIGW signal studied here, constituting a characteristic signature of PBHs, can be potentially detectable by LISA.


Here it is important to highlight that our formalism can be generalised to any type of primordial power spectrum responsible for the generation of PBHs triggering an eMD era either within GR~@GarciaBellido:1996qt @Hidalgo:2011fj @Martin:2019nuw @Zagorac:2019ekv or within modified gravity setups~@Banerjee:2022xft @CANTATA:2021ktz. In this way, one can use this portal as a novel probe to constrain on the one hand primordial power spectra on the small PBH scales which are not accesible by CMB or LSS probes~@Kalaja:2019uju and on the other hand gravitational theories responsible for PBH production.


Finally, we need to point out that our analysis can be extended in various ways. In particular, one can study as well the contribution from the modes entering the Hubble radius during the early RD era before the onset of the PBH-dominated phase as well GWs due to Hawking radiated gravitons~@Domenech:2021wkk which will clearly enhance the SIGW signal.


Additionally, given the fact that a large PBH abundance is reached when PBHs come to dominate the energy budget of the Universe, one expects the onset of PBH clustering which will obviously enhance the formation of PBH binaries~@Raidal:2017mfl as well as the formation of small scale virialised structures enhancing subsequently the power spectrum above its Poissonian value and leading in this way to an even larger GW signal than the one extracted in the present work.


Given therefore all these considerations, this work gives a lower bound on the potential GW signatures of the early PBH-domination scenario. The inclusion of all the extra aforementioned effects will clearly enhance the GW signal and subsequently tighten the constraints on $alpha_(upright(s))$ hence rendering our results rather conservative.


#heading(level: 1, numbering: none)[Acknowledgments]
<acknowledgments>
I would like to thank Vincent Vennin and Gabriele Franciolini for stimulating discussions and comments. I acknowledge financial support from the Foundation for Education and European Culture in Greece.

#show bibliography: set text(size: 10pt)
#bibliography("refs.bib", title: [References], full: true)