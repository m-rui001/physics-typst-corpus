#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#align(center)[
  #text(17pt, weight: "bold", [Non-Gaussianity and the induced gravitational wave background])   #v(1.2em)
  #text(10.5pt)[Peter Adshead,]
  
]

#v(1.2em)



= Introduction
<introduction>


The paradigm of cosmic inflation@1979JETPL..30..682S @PhysRevD.23.347 @Sato:1980yn @Mukhanov:1981xt @LINDE1982389 @PhysRevLett.48.1220 @1983PhLB..129..177L, together with the $Lambda$ cold dark matter ($Lambda$CDM) model, provides a precise description of the Universe on cosmic scales@Aghanim:2018eyx @Alam:2016hwk @Scolnic:2017caz @Akrami:2018odb. This model, in which the Universe expands from a hot and dense state following inflation, successfully predicts both the primordial elemental abundances via big bang nucleosynthesis (BBN)@Steigman:2007xt @Cyburt:2015mya as well as the cosmic microwave background radiation (CMB). Furthermore, measurements of the temperature anisotropies of the CMB reveal a red-tilted spectrum of adiabatic and highly Gaussian density fluctuations in excellent agreement with the predictions of standard slow roll inflation@Akrami:2018odb.


The large ($10 - 10^4$ Mpc) scales measured in the CMB and large-scale structure directly probe (and constrain) the dynamics of inflation around $50 - 60$ $e$-folds before its end@Kite:2020uix. The later stages of inflation are only weakly constrained by (the nonobservation of) spectral distortions in the CMB@Chluba:2015bqa, as well as the absence of high-energy $gamma$ rays from ultracompact minihalos@Bringmann:2011ut. Moreover, the abundances of light elements are insensitive to the state of the Universe prior to BBN and neutrino decoupling (before redshift $z tilde 10^10$)@Steigman:2007xt. In fact, successful BBN requires only that the Universe was in local thermal equilibrium and expanding in a radiation dominated state by a temperature of around $T tilde 4.1$ MeV @Ichikawa:2005vw @deSalas:2015glj @Hasegawa:2019jsa.


Gravitational waves (GW) offer a unique means to study inhomogeneities on smaller scales and thereby constrain both the later stages of inflation@Inomata:2018epa and the evolution of the Universe before BBN@Domenech:2019quo @Inomata:2019zqy @Inomata:2019ivs @Hajkarim:2019nbx @Domenech:2020kqm @Allahverdi:2020bys. Aside from direct production mechanisms, density perturbations act as a secondary source of stochastic GW backgrounds@10.1143_PTP.37.831 @PhysRevD.47.1311 @Matarrese:1993zf @Matarrese:1997ay @Carbone:2004iv @Ananda:2006af @Baumann:2007zm @Saito:2008jc. Future experiments@2017arXiv170200786A @Seto:2001qf @Yagi:2011wg @Maggiore:2019uih @Reitze:2019iox @Lentati:2015qwp @Bian:2020bps @Aggarwal:2020olq will probe these "induced" GWs at a variety of frequencies@Bugaev:2009zh @Bugaev:2010bb @Alabidi:2012ex @Alabidi:2013lya @Garcia-Bellido:2016dkw @Inomata:2016rbd @Orlofsky:2016vbd @Nakama:2016gzw @Garcia-Bellido:2017aan @Domenech:2017ems @Kohri:2018awv @Clesse:2018ogk @Inomata:2019zqy @Inomata:2019ivs @Chen:2019xse @Domenech:2019quo @Ota:2020vfn @Cai:2019jah @Yuan:2019wwo @Cai:2019elf @Cai:2019amo @Bartolo:2019zvb @Bhattacharya:2019bvk @Ozsoy:2019lyy @Pi:2020otn @Xu:2019bdp @Yuan:2020iwf @Ballesteros:2020qam @Liu:2020oqe @Braglia:2020eai @Braglia:2020taf @Fumagalli:2020nvq @Gow:2020bzo @Riccardi:2021rlf @Atal:2021jyo, providing valuable information about scales that exit the horizon during inflation long after the modes that eventually seed the CMB anisotropies. These modes reenter the horizon before BBN and subsequently induce gravitational waves at second order in cosmological perturbation theory. Enticingly, the pulsar timing array experiment NANOGrav recently presented evidence for a common process@Arzoumanian:2020vkk which, though currently lacking Bayesian evidence for the requisite quadrupolar correlations, may well be due to a stochastic GW background@Vaskonen:2020lbd @DeLuca:2020agl @Kohri:2020qqd @Vagnozzi:2020gtf @Domenech:2020ers @Bhattacharya:2020lhc @Inomata:2020xad @Atal:2020yic @Pandey:2020gjy.


The expected level of GWs induced from a red-tilted spectrum of curvature perturbations extrapolated to small scales, with amplitude $Delta_(cal(R))^2 ( k_star.op ) approx 10^(- 10)$ at $k_star.op = 0.05 thin h$ Mpc$""^(- 1)$ required by the CMB anisotropies, is unobservably tiny @Ananda:2006af @Baumann:2007zm. However, there is no a priori reason to expect that such an extrapolation is appropriate over such a large range of scales. In particular, induced GWs are expected to be significant in scenarios where primordial black holes (PBHs) form via the gravitational collapse of small-scale curvature perturbations@Espinosa:2018eve @Cai:2018dig @Bartolo:2018rku @Unal:2018yaa @Yuan:2019udt. GWs therefore provide a powerful probe not only of the initial conditions and expansion history of the Universe but also of the abundance of PBHs and their potential to constitute a sizable fraction of the dark matter@Carr:2016drx @Inomata:2017okj @Green:2020jor. For recent reviews, see Refs.@Carr:2020gox @Carr:2020xqk @Sasaki:2018dmp @Yuan:2021qgz.


While the running of the spectral index typically suppresses power on very small scales in canonical models of inflation (see, e.g.@Adshead:2010mc), a number of scenarios can enhance the curvature power spectrum on small scales. Examples of modifications to the minimal slow roll scenario include multifield inflation@Frampton:2010sw @Kawasaki:2012kn, inflaton couplings leading to particle production@Anber:2009ua @Linde:2012bt @Bugaev:2013fya @Garcia-Bellido:2016dkw @Domcke:2017fix @Garcia-Bellido:2017aan @Garcia:2020mwi @Ozsoy:2020ccy @Ozsoy:2020kat, a plateau in the inflaton potential that causes a period of ultra slow roll@PhysRevD.50.7173 @Byrnes:2018txb @Ozsoy:2018flq @Ragavendra:2020sop, and a brief downward step in the potential@Inomata:2021uqj. In these scenarios the curvature perturbation is often non-Gaussian on these scales, impacting not only PBH formation (which is sensitive to the tail of the probability distribution of density perturbations) but also the induced GW signal.


In this work we revisit the problem of GW backgrounds induced by non-Gaussian curvature perturbations@Nakama:2016gzw @Garcia-Bellido:2017aan @Unal:2018yaa @Cai:2018dig @Cai:2019amo @Yuan:2020iwf @Ragavendra:2020sop @Atal:2021jyo. We focus on local-type non-Gaussianity@Unal:2018yaa @Cai:2018dig @Cai:2019amo @Yuan:2020iwf @Ragavendra:2020sop @Atal:2021jyo and show that the induced GW spectrum is in general sensitive to all contributions to the primordial trispectrum. In particular, in addition to the disconnected part of the curvature perturbation's 4-point correlation function (arising solely via the non-Gaussian modification to the curvature power spectrum itself), the connected component is a nontrivial and important contribution to the induced GW signal, often unaccounted for in the literature.


This paper is organized as follows. In Sec. #ref(<sec:background>) we briefly review the calculation of the dimensionless power spectrum $cal(P)_lambda$ of GWs induced by a generic curvature perturbation $cal(R)$, leaving additional details to App. #ref(<app:cpt>). We proceed to present the complete contribution of the (connected and disconnected parts of the) 4-point correlation function of $cal(R)$ to $cal(P)_lambda$. We then specialize to the case of local non-Gaussianity. App. #ref(<app:trispectrum>) outlines the derivation in more detail, presenting a diagrammatic interpretation of individual terms. We present results for a variety of primordial curvature power spectra in Sec. #ref(<sec:results>) and conclude in Sec. #ref(<sec:conclusion>).


= Gravitational waves induced by scalar perturbations
<sec:background>


We work with a perturbed FLRW spacetime in the conformal Newtonian gauge, $ upright(d) s^2 & = a ( tau )^2 (- [1 + 2 Phi] upright(d) tau^2 + [( 1 - 2 Phi ) delta_(i j) + 1 / 2 h_(i j)] upright(d) x^i upright(d) x^j) , $ neglecting vector perturbations and first-order tensor perturbations. That is, we consider only tensors sourced at second order in perturbation theory and ignore those at leading order, e.g., a primordial background from inflation. We set $c = ℏ = k_B = 1$, define the reduced Planck mass $m_(upright("Pl")) = 1 / sqrt(8 pi G_N)$, and use primes to denote derivatives with respect to conformal time $tau$. Repeated Latin indices denote a contraction with the Kronecker delta regardless of placement. We assume a fixed equation of state \$w = "mkern" 1.25mu"macron"("mkern"-1.25muP"mkern"-1.25mu)"mkern" 1.25mu / "mkern" 1.25mu"macron"("mkern"-1.25murho"mkern"-1.25mu)"mkern" 1.25mu\$, with \$"mkern" 1.25mu"macron"("mkern"-1.25muP"mkern"-1.25mu)"mkern" 1.25mu\$ and \$"mkern" 1.25mu"macron"("mkern"-1.25murho"mkern"-1.25mu)"mkern" 1.25mu\$ the background pressure and energy density, so the scale factor evolves according to $ a ( tau ) & = a_0 (tau / tau_0)^alpha , $<eqn:scale-factor-fixed-eos> where $alpha = 2 / ( 1 + 3 w )$. The conformal-time Hubble parameter is thus $ cal(H) ( tau ) equiv frac(a' ( tau ), a ( tau )) & = alpha / tau . $


We expand the GWs in Fourier modes as $ h_(i j) ( tau , upright(bold(x)) ) & = sum_(lambda = + , times) integral frac(upright(d)^3 k, ( 2 pi )^(3 / 2)) e^(i upright(bold(k)) dot.op upright(bold(x))) epsilon.alt_(i j)^lambda ( upright(bold(k)) ) h_lambda ( tau , upright(bold(k)) ) , $ where the polarization tensors are $
  epsilon.alt_(i j)^(+) ( upright(bold(k)) ) &  & 
$ <eqn:q-basis-def> and $epsilon.alt_i ( upright(bold(k)) )$ and \$"mkern" 1.25mu"macron"("mkern"-1.25muepsilon"mkern"-1.25mu)"mkern" 1.25mu\_(i)("bold"("k"))\$ form an orthonormal basis transverse to $upright(bold(k))$. Note that $epsilon.alt_(i j)^lambda ( upright(bold(k)) )$ are traceless and transverse to $upright(bold(k))$ by construction. The power spectrum of GWs is then defined as $ chevron.l h_(lambda_1) ( tau , upright(bold(k))_1 ) h_(lambda_2) ( tau , upright(bold(k))_2 ) chevron.r & = delta^3 ( upright(bold(k))_1 + upright(bold(k))_2 ) delta^(lambda_1 lambda_2) cal(P)_(lambda_1) ( tau , k_1 ) . $ We also define the dimensionless GW power spectrum, $ chevron.l h_(lambda_1) ( tau , upright(bold(k))_1 ) h_(lambda_2) ( tau , upright(bold(k))_2 ) chevron.r & = delta^3 ( upright(bold(k))_1 + upright(bold(k))_2 ) delta^(lambda_1 lambda_2) frac(2 pi^2, k_1^3) Delta_(lambda_1)^2 ( tau , k_1 ) . $


The spatially averaged energy density of gravitational waves on subhorizon scales is $
  rho_(upright(G W)) ( tau ) & 
$ where the overbar denotes a time average (i.e., over oscillations). The fractional energy density in GWs per logarithmic wavenumber is $
  
$ The spectrum that would be observed today (assuming emission after reheating) is obtained via the transfer function $ Omega_(upright("GW") , 0) ( k ) h^2 & = Omega_(upright("rad") , 0) h^2 (g_(star.op , 0) / g_(star.op , upright(e)))^(1 / 3) Omega_(upright("GW") , upright(e)) ( k ) , $<eqn:gw-amplitude-transfer-function> which for comoving momentum $k$ would be observed at the present-day frequency $ f = frac(k / 2 pi a_(upright(e)), sqrt(H_(upright(e)) m_(upright("Pl")))) (Omega_(upright("rad") , 0) H_0^2 m_(upright("Pl"))^2)^(1 / 4) (g_(star.op , 0) / g_(star.op , upright(e)))^(1 / 12) . $ Here $g_star.op$ is the number of relativistic degrees of freedom in energy density, $Omega_(upright("rad") , 0)$ the present-day abundance of radiation, and $H$ the Hubble parameter; subscripts $upright(e)$ and $0$ denote the time of emission and the present day, respectively. Note that $Omega_(upright("rad") , 0) h^2 approx 4.2 times 10^(- 5)$ with $h = H_0 / 100 thin upright("km") upright(s)^(- 1) / upright("Mpc")$.


== Induced gravitational wave solution
<sec:GWdyn>


The induced gravitational waves evolve according to $ h''_lambda ( tau , upright(bold(k)) ) + 2 cal(H) h'_lambda ( tau , upright(bold(k)) ) + k^2 h_lambda ( tau , upright(bold(k)) ) & = 4 cal(S)_lambda ( tau , upright(bold(k)) ) , $<eq:GWeom> where the source $cal(S)_lambda$ comprises the terms of the (transverse, traceless part of the) Einstein equation that are second order in scalar perturbations. To make contact with primordial physics, it is conventional to express the gravitational potential in terms of the primordial curvature perturbation $cal(R)$ and a transfer function $Phi ( k tau )$, $ Phi ( tau , upright(bold(k)) ) & = frac(3 + 3 w, 5 + 3 w) Phi ( k tau ) cal(R) ( upright(bold(k)) ) . $<eqn:transfer-times-curvature> The transfer function $Phi ( k tau )$ encodes the linear evolution of the Newtonian potential after horizon reentry. In these terms, the source is@Ananda:2006af @Baumann:2007zm $ cal(S)_lambda ( tau , upright(bold(k)) ) & = integral frac(upright(d)^3 q, ( 2 pi )^(3 / 2)) Q_lambda ( upright(bold(k)) , upright(bold(q)) ) f ( \| upright(bold(k)) - upright(bold(q)) \| , q , tau ) cal(R) ( upright(bold(q)) ) cal(R) ( upright(bold(k)) - upright(bold(q)) ) , $<eq:S> where $f ( \| upright(bold(k)) - upright(bold(q)) \| , q , tau )$ is given by $ f ( p , q , tau ) & = frac(3 ( 1 + w ), ( 5 + 3 w )^2) \[ 2 ( 5 + 3 w ) Phi ( p tau ) Phi ( q tau ) + tau^2 (1 + 3 w)^2 Phi' ( p tau ) Phi' ( q tau )\
 & + 2 tau (1 + 3 w) (Phi ( p tau ) Phi' ( q tau ) + Phi' ( p tau ) Phi ( q tau )) \] . $<eqn:source-function-p-q-tau> Note that $f ( p , q , tau )$ is symmetric under exchange of $q$ and $p$. The projection factors are $ Q_lambda ( upright(bold(k)) , upright(bold(q)) ) & equiv epsilon.alt_(i j)^lambda ( upright(bold(k)) ) q_i q_j . $<eqn:projection-factor-def> Taking $upright(bold(k))$ in the $hat(z)$ direction and writing $ upright(bold(q)) & = q [sin theta cos phi.alt , sin theta sin phi.alt , cos theta] , $ the projection factors evaluate to $ Q_lambda ( upright(bold(k)) , upright(bold(q)) ) & = q^2 / sqrt(2) sin^2 ( theta ) times cases(delim: "{", cos ( 2 phi.alt ) & lambda = +, sin ( 2 phi.alt ) & lambda = times .) $<eqn:projection-factor-ito-angles> We note that the $cos ( 2 phi.alt )$ and $sin ( 2 phi.alt )$ terms are absent in some of the intermediate steps in Ref.@Baumann:2007zm.


The induced GWs are the particular solution of Eq. #ref(<eq:GWeom>), $
  
$ <eq:h> where the Green function \$G\_"bold"("k ")(tau,"mkern" 1.25mu"macron"("mkern"-1.25mutau"mkern"-1.25mu)"mkern" 1.25mu)\$ obeys the equation of motion $
   & 
$ <eqn:green-function-eom> Hence, the power spectrum of the induced GWs is given by $ chevron.l h_(upright(bold(k))_1)^(lambda_1) h_(upright(bold(k))_2)^(lambda_2) chevron.r & = 16 integral frac(upright(d)^3 q_1, ( 2 pi )^(3 / 2)) frac(upright(d)^3 q_2, ( 2 pi )^(3 / 2)) chevron.l cal(R) ( upright(bold(q))_1 ) cal(R) ( upright(bold(k))_1 - upright(bold(q))_1 ) cal(R) ( upright(bold(q))_2 ) cal(R) ( upright(bold(k))_2 - upright(bold(q))_2 ) chevron.r Q_(lambda_1) ( upright(bold(k))_1 , upright(bold(q))_1 ) Q_(lambda_2) ( upright(bold(k))_2 , upright(bold(q))_2 )\
 & times I ( lr(|upright(bold(k))_1 - upright(bold(q))_1|) , q_1 , tau_1 ) I ( lr(|upright(bold(k))_2 - upright(bold(q))_2|) , q_2 , tau_2 ) , $<eqn:gw-power-spectrum-generic> having defined $
  I ( p \, q \, tau ) & 
$ <eqn:I-def> By treating the scalar perturbations to linear order, the time dependence of the induced GW spectrum is decoupled from the primordial curvature power spectrum. For a fixed equation of state, the integrals $I ( p , q , tau )$ can be computed analytically@Kohri:2018awv.


If we impose statistical homogeneity and isotropy on the curvature perturbation $cal(R)$ and assume $chevron.l cal(R) chevron.r = 0$, then its 4-point function splits into disconnected and connected components: $ chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r & = chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r_(upright(d)) + chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r_(upright(c))\
chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r_(upright(d)) & = chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) chevron.r chevron.l cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r + chevron.l cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) chevron.r chevron.l cal(R) ( upright(bold(k))_4 ) cal(R) ( upright(bold(k))_1 ) chevron.r\
 & + chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_3 ) chevron.r chevron.l cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_4 ) chevron.r\
chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) cal(R) ( upright(bold(k))_3 ) cal(R) ( upright(bold(k))_4 ) chevron.r_(upright(c)) & = delta^3 ( upright(bold(k))_1 + upright(bold(k))_2 + upright(bold(k))_3 + upright(bold(k))_4 ) cal(T) ( upright(bold(k))_1 , upright(bold(k))_2 , upright(bold(k))_3 , upright(bold(k))_4 ) , $ where $ chevron.l cal(R) ( upright(bold(k))_1 ) cal(R) ( upright(bold(k))_2 ) chevron.r = delta^3 ( upright(bold(k))_1 + upright(bold(k))_2 ) cal(P)_(cal(R)) ( k_1 ) , $ defines the power spectrum of the curvature perturbation and $cal(T) ( upright(bold(k))_1 , upright(bold(k))_2 , upright(bold(k))_3 , upright(bold(k))_4 )$ stands for the connected trispectrum. We similarly decompose the induced GW power spectrum into its parts sourced by the disconnected and connected trispectrum:#footnote[Note that nonlinear terms at higher order (in $Phi$) in the source term, Eq. #ref(<eq:S>), are neglected here. Provided $F_(upright("NL")) > cal(O) ( 1 )$ (see Eq. #ref(<eq:RNG>) below), the contribution from primordial non-Gaussianity dominates.] $ cal(P)_lambda ( k ) & = cal(P)_lambda ( k )\|_(upright(d)) + cal(P)_lambda ( k )\|_(upright(c)) . $ The disconnected component represents that arising from the curvature power spectrum, including its contribution from non-Gaussianity (the exact form of which we have yet to specify). This term takes the form $ cal(P)_lambda ( k )\|_(upright(d)) & = 32 integral frac(upright(d)^3 q, ( 2 pi )^3) Q_lambda ( upright(bold(k)) , upright(bold(q)) )^2 I ( lr(|upright(bold(k)) - upright(bold(q))|) , q , tau )^2 cal(P)_(cal(R)) ( q ) cal(P)_(cal(R)) ( lr(|upright(bold(k)) - upright(bold(q))|) ) . $<eqn:P-h-disc-generic> In the case that $cal(R)$ is a Gaussian field, Eq. #ref(<eqn:P-h-disc-generic>) reproduces the standard result@Ananda:2006af @Baumann:2007zm @Kohri:2018awv. The connected component is $ cal(P)_lambda ( k )\|_(upright(c)) & = 16 integral frac(upright(d)^3 q_1, ( 2 pi )^(3 / 2)) frac(upright(d)^3 q_2, ( 2 pi )^(3 / 2)) Q_lambda ( upright(bold(k)) , upright(bold(q))_1 ) Q_lambda ( upright(bold(k)) , upright(bold(q))_2 ) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau ) I ( lr(|upright(bold(k)) - upright(bold(q))_2|) , q_2 , tau )\
 & times cal(T) ( upright(bold(q))_1 , upright(bold(k)) - upright(bold(q))_1 , - upright(bold(q))_2 , upright(bold(q))_2 - upright(bold(k)) ) . $<eqn:P-h-conn-generic> We stress that the connected trispectrum contribution to the induced GWs power spectrum, Eq. #ref(<eqn:P-h-conn-generic>), does not vanish in general. As we demonstrate explicitly below, the connected trispectrum generally has nontrivial dependence on the azimuthal angles of $upright(bold(q))_1$ and $upright(bold(q))_2$. Were this not the case, the azimuthal dependence would arise solely via Eq. #ref(<eqn:projection-factor-ito-angles>), and therefore the integrals over $phi.alt_1$ and $phi.alt_2$ would each vanish.#footnote[In Refs.@Cai:2018dig @Cai:2019amo @Ragavendra:2020sop, the contribution of the connected part of the trispectrum is neglected. Refs.@Cai:2018dig @Cai:2019amo claim that the contribution from the connected terms vanishes due to the integrals over the azimuthal angles, regardless of the form of the trispectrum.] Finally, extracting the observable GW signal requires taking the time average of the right-hand side; see App. #ref(<app:cpt>) for details.


== Local-type non-Gaussian curvature as a source of GWs
<sec:NGGWdyn>


We now specialize to the case of local-type non-Gaussianity, $ cal(R) ( upright(bold(x)) ) & = cal(R)_g ( upright(bold(x)) ) + F_(upright("NL")) (cal(R)_g ( upright(bold(x)) )^2 - chevron.l cal(R)_g ( upright(bold(x)) )^2 chevron.r) , $<eq:RNG> where the Gaussian field $cal(R)_g$ is completely specified by its power spectrum, defined by $ ⟨cal(R)_g ( upright(bold(k))_1 ) cal(R)_g ( upright(bold(k))_2 )⟩ & = delta^3 ( upright(bold(k))_1 + upright(bold(k))_2 ) cal(P)_g ( k_1 ) . $ The one-loop power spectrum of $cal(R)$ is $ cal(P)_(cal(R)) ( k ) & = cal(P)_g ( k ) + 2 F_(upright("NL"))^2 integral frac(upright(d)^3 q, ( 2 pi )^3) cal(P)_g ( q ) cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))|) ) . $ Thus, there are three unique, disconnected contributions to the induced GW spectrum: the standard Gaussian term, $ cal(P)_lambda ( k )_(upright("Gaussian")) & = 2^5 integral frac(upright(d)^3 q, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))|) , q , tau )^2 Q_lambda ( upright(bold(k)) , upright(bold(q)) )^2 cal(P)_g ( q ) cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))|) ) , $<eqn:P-lambda-gaussian> an $cal(O) ( F_(upright("NL"))^2 )$ "hybrid" term, $ cal(P)_lambda ( k )_(upright("hybrid")) & = 2^7 F_(upright("NL"))^2 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau )^2 Q_lambda ( upright(bold(k)) , upright(bold(q))_1 )^2 cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))_1|) ) cal(P)_g ( q_2 ) cal(P)_g ( lr(|upright(bold(q))_1 - upright(bold(q))_2|) ) , $<eqn:P-lambda-hybrid> and an $cal(O) ( F_(upright("NL"))^4 )$ "reducible" term, $ cal(P)_lambda ( k )_(upright("reducible")) & = 2^7 F_(upright("NL"))^4 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) frac(upright(d)^3 q_3, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau )^2 Q_lambda ( upright(bold(k)) , upright(bold(q))_1 )^2\
 & times cal(P)_g ( q_2 ) cal(P)_g ( q_3 ) cal(P)_g ( lr(|upright(bold(q))_1 - upright(bold(q))_2|) ) cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))_1 - upright(bold(q))_3|) ) . $<eqn:P-lambda-reducible> The connected contributions comprise an $cal(O) ( F_(upright("NL"))^2 )$ "C" term, $ cal(P)_lambda ( k )_(upright("C")) & = 2^8 F_(upright("NL"))^2 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau ) I ( lr(|upright(bold(k)) - upright(bold(q))_2|) , q_2 , tau ) Q_lambda ( upright(bold(k)) , upright(bold(q))_1 ) Q_lambda ( upright(bold(k)) , upright(bold(q))_2 )\
 & times cal(P)_g ( q_2 ) cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))_2|) ) cal(P)_g ( lr(|upright(bold(q))_1 - upright(bold(q))_2|) ) , $<eqn:P-lambda-4-vertex> an $cal(O) ( F_(upright("NL"))^2 )$ "Z" term, $ cal(P)_lambda ( k )_(upright("Z")) & = 2^8 F_(upright("NL"))^2 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau ) I ( lr(|upright(bold(k)) - upright(bold(q))_2|) , q_2 , tau ) Q_lambda ( upright(bold(k)) , upright(bold(q))_1 ) Q_lambda ( upright(bold(k)) , upright(bold(q))_2 )\
 & times cal(P)_g ( q_1 ) cal(P)_g ( q_2 ) cal(P)_g ( lr(|upright(bold(k)) - ( upright(bold(q))_1 + upright(bold(q))_2 )|) ) , $<eqn:P-lambda-sunset> an $cal(O) ( F_(upright("NL"))^4 )$ "planar" term, $ cal(P)_lambda ( k )_(upright("planar")) & = 2^9 F_(upright("NL"))^4 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) frac(upright(d)^3 q_3, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau ) I ( lr(|upright(bold(k)) - upright(bold(q))_2|) , q_2 , tau ) Q_lambda ( upright(bold(k)) , upright(bold(q))_1 ) Q_lambda ( upright(bold(k)) , upright(bold(q))_2 )\
 & times cal(P)_g ( q_3 ) cal(P)_g ( lr(|upright(bold(q))_1 - upright(bold(q))_3|) ) cal(P)_g ( lr(|upright(bold(q))_2 - upright(bold(q))_3|) ) cal(P)_g ( lr(|upright(bold(k)) - upright(bold(q))_3|) ) , $<eqn:P-lambda-planar> and an $cal(O) ( F_(upright("NL"))^4 )$ "nonplanar" term, $ cal(P)_lambda ( k )_(upright("nonplanar")) & = 2^8 F_(upright("NL"))^4 integral frac(upright(d)^3 q_1, ( 2 pi )^3) frac(upright(d)^3 q_2, ( 2 pi )^3) frac(upright(d)^3 q_3, ( 2 pi )^3) I ( lr(|upright(bold(k)) - upright(bold(q))_1|) , q_1 , tau ) I ( lr(|upright(bold(k)) - upright(bold(q))_2|) , q_2 , tau ) Q_lambda ( upright(bold(k)) , upright(bold(q))_1 ) Q_lambda ( upright(bold(k)) , upright(bold(q))_2 )\
 & times cal(P)_g ( q_3 ) cal(P)_g ( lr(|upright(bold(q))_1 - upright(bold(q))_3|) ) cal(P)_g ( lr(|upright(bold(q))_2 - upright(bold(q))_3|) ) cal(P)_g ( lr(|upright(bold(k)) - ( upright(bold(q))_1 + upright(bold(q))_2 ) + upright(bold(q))_3|) ) . $<eqn:P-lambda-nonplanar> Ref.@Atal:2021jyo refers to $cal(P)_lambda ( k )_(upright("Z"))$ as having a "walnut" topology; in App. #ref(<app:trispectrum>) we provide a complete prescription for assigning Feynman-type diagrams to the above integrals (from which we derive the labels Z and C). The "walnut" integral of Ref.@Unal:2018yaa appears to be our $cal(P)_lambda ( k )_(upright("C"))$. Furthermore, $cal(P)_lambda ( k )_(upright("C"))$ does not appear in Ref.@Atal:2021jyo, while $cal(P)_lambda ( k )_(upright("Z"))$ does not appear in Ref.@Unal:2018yaa. In App. #ref(<app:recasting-the-integrals>) we recast these integrals into a form suitable for numerical integration.


= Results
<sec:results>


To study the relative importance of the various non-Gaussian contributions to the induced GW spectrum, we now consider various primordial (Gaussian) curvature power spectra and present numerical results for all terms. In order to clearly illustrate the effects of non-Gaussianity, we typically fix the amplitude $cal(A)_(cal(R))$ and vary $F_(upright("NL"))$. Note, however, that when considering the production of PBHs, non-Gaussianity has a significant impact on their abundance@Byrnes:2012yx @Young:2013oia @Franciolini:2018vbk. In addition, we display results for a range of parameters to study the contributions at each order in $cal(A)_(cal(R)) F_(upright("NL"))^2$ to the full GW spectrum. In reality, for some of the most extreme values we consider, the perturbativity of the underlying theory may break down (when $cal(A)_(cal(R)) F_(upright("NL"))^2 gt.tilde 1$) or higher-order terms in the expansion of the curvature perturbation (beyond the quadratic ansatz in Eq. #ref(<eq:RNG>)) may be important. We retain these cases for illustrative purposes and to compare to existing literature, postponing the consideration of higher-order corrections to future work.


== Monochromatic spectrum
<monochromatic-spectrum>


As a useful benchmark case, we first consider the spectrum of gravitational waves induced by a monochromatic spectrum of density fluctuations, $ Delta_g^2 ( k ) & = cal(A)_(cal(R)) delta ( ln tilde(k) ) , $<eqn:P-g-monochromatic> defining $tilde(k) = k / k_star.op$. The Gaussian result is@Kohri:2018awv $ Omega_(upright("GW")) ( k )_(upright("Gaussian")) & = frac(3 cal(A)_(cal(R))^2, 1024) tilde(k)^2 Theta ( 2 - tilde(k) ) (tilde(k)^2 - 4)^2 (3 tilde(k)^2 - 2)^2\
 & times (pi^2 (3 tilde(k)^2 - 2)^2 Theta (2 sqrt(3) - 3 tilde(k)) + [4 + (3 tilde(k)^2 - 2) ln lr(|frac(4, 3 tilde(k)^2) - 1|)]^2) . $ Though the non-Gaussian terms must still be computed numerically, integrating over the Dirac delta functions substantially reduces the dimensionality of the required integrals. Note that for the nonplanar term, solving for the zeros of the Dirac delta functions requires solving a quartic polynomial for one of the integration variables $s_i$ or $t_i$ (defined in App. #ref(<app:recasting-the-integrals>)). In lieu of this we numerically integrate over one of the four Dirac delta functions, approximated as a narrow lognormal function (Eq. #ref(<eqn:P-g-lognormal>) below). We set $sigma = 1 / 100$, which is more than sufficiently narrow to serve as a good approximation.


We begin by considering each non-Gaussian contribution individually.


#figure(image("src/monochromatic-unscaled-contributions-2-panel-lin-and-log.pdf"),
  caption: [
    Unscaled (i.e., $cal(A)_(cal(R)) = 1$ and $F_(upright("NL")) = 1$) non-Gaussian contributions for a monochromatic source, Eq. #ref(<eqn:P-g-monochromatic>). The dashed lines indicate each contribution at $cal(O) ( F_(upright("NL"))^2 )$ (top panels) and at $cal(O) ( F_(upright("NL"))^4 )$ (bottom panels) with colors denoted in the legend. Solid black lines depict the sum of the individual contributions appearing in each panel. The left and right panels display the results on a linear and a log vertical scale, respectively. Because some individual contributions are negative at some $k$, dashed and dotted lines indicate where the sign is positive and negative, respectively.
  ]
)
<fig:monochromatic-ng-components>



Fig. #ref(<fig:monochromatic-ng-components>) displays the non-Gaussian contributions to the induced GW spectrum, dividing the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms by $cal(A)_(cal(R))^3 F_(upright("NL"))^2$ and $cal(A)_(cal(R))^4 F_(upright("NL"))^4$, respectively. The connected terms clearly contribute as significantly as the disconnected ones, and they peak at differing wavenumbers. In particular, the C and planar terms are substantially larger in the infrared and also contribute comparably to the peaks at $k gt.tilde k_star.op$. In contrast, the Z and nonplanar terms are smaller in magnitude. The C, Z, and nonplanar terms are (for at least some $k$) negative; however, as apparent in the right panels of Fig. #ref(<fig:monochromatic-ng-components>), the summed contributions at each order in $F_(upright("NL"))$ are positive definite.


By comparing the peak heights of the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms in the left panels of Fig. #ref(<fig:monochromatic-ng-components>), we can estimate at what value of $cal(A)_(cal(R)) F_(upright("NL"))^2$ the two contributions are comparable. For instance, aside from the spike in the C term, the ratio of the peaks of the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ contributions is roughly $1 / 2$. In the common range $cal(A)_(cal(R)) tilde 10^(- 2) - 10^(- 3)$ considered for significant PBH production, for $F_(upright("NL")) tilde 5 - 20$ the $cal(O) ( F_(upright("NL"))^4 )$ terms contribute significantly. In the infrared (IR) limit, the ratios of the Gaussian and $cal(O) ( F_(upright("NL"))^2 )$ contributions is roughly $0.43$, while that for the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ ones is about $1.7$.


We investigate the relative contributions of the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms in more detail in Fig. #ref(<fig:monochromatic-gauss-vs-fnl2-vs-fnl4>).


#figure(image("src/monochromatic-gauss-vs-fnl2-vs-fnl4-A-1e-3.pdf"),
  caption: [
    Induced GW spectrum after emission for a monochromatic source with $cal(A)_(cal(R)) = 10^(- 3)$ and various $F_(upright("NL"))$. The Gaussian, $cal(O) ( F_(upright("NL"))^2 )$, and $cal(O) ( F_(upright("NL"))^4 )$ contributions appear in dashed blue, dot-dashed green, and dotted red respectively. The total spectrum is depicted in thin black.
  ]
)
<fig:monochromatic-gauss-vs-fnl2-vs-fnl4>



We fix $cal(A)_(cal(R)) = 10^(- 3)$ and vary $F_(upright("NL"))$ geometrically. For $F_(upright("NL")) = 5$ the Gaussian term dominates, but the non-Gaussian contributions produce "knees" near $k tilde 2 k_star.op$ and $3 k_star.op$ where the Gaussian contribution vanishes. At $F_(upright("NL")) = 10$ and $20$, the structure of the peak(s) is broadened by the $cal(O) ( F_(upright("NL"))^2 )$ terms. Finally, at $F_(upright("NL")) = 40$ the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms contribute comparably and dominate over the Gaussian one, resulting in a more complex peak. Note that much of this structure is smoother in more realistic scenarios with broader scalar power spectrum, as we investigate below.


As pointed out by Ref.@Yuan:2019wwo, the infrared scaling of the induced GW spectrum includes a logarithmic running on top of the typical pure power law behavior. Though we verify that the spectral index of the disconnected non-Gaussian contributions may be approximated as $3 + a ln ( b k )$ for some order-unity $a$ and $b$ (as found in Ref.@Yuan:2020iwf), of the connected terms this form only holds for the subdominant Z and nonplanar ones. The dominant non-Gaussian terms, the C and planar, scale with $k^(2 + a ln ( b k ))$ like the Gaussian term@Yuan:2019wwo.#footnote[The infrared behavior of each contribution can be verified analytically by explicitly integrating over the Dirac delta functions and expanding in the limit $k / k_star.op lt.double 1$, a procedure we summarize in Sec. #ref(<sec:monochromatic-analytic>).] As such, the spectral index of hypothetical GW signals could likely not be used to distinguish one dominated by Gaussian vs. non-Gaussian contributions. Furthermore, studies that neglect the connected terms significantly underestimate the non-Gaussian contributions to the GW spectrum in the IR.


To make contact with potential observations, Fig. #ref(<fig:monochromatic-lisa-ligo-money>) depicts the full, present-day GW signal alongside the sensitivity curves of various experiments@Schmitz:2020syl.#footnote[For simplicity, we compare to the power-law--integrated sensitivity curves provided by Ref.@Schmitz:2020syl.]


#figure(image("src/monochromatic-lisa-ligo-money.pdf"),
  caption: [
    Present-day induced GW spectrum for a monochromatic source with various $F_(upright("NL"))$, plotted against the sensitivity curves of various gravitational wave experiments@Schmitz:2020syl @schmitz_kai_2020_3689582.
  ]
)
<fig:monochromatic-lisa-ligo-money>



To get a sense of the sizes of PBHs that could possibly be produced in such scenarios, the top axis of Fig. #ref(<fig:monochromatic-lisa-ligo-money>) depicts the mass $M_(upright("PBH"))$ of PBHs produced by the collapse of overdensities at horizon reentry on scales $k_star.op = 2 pi f_star.op$@Inomata:2016rbd, $ M_(upright("PBH")) / M_⊙ & = gamma / 0.2 (g_star.op / 10.75)^(- 1 / 6) (frac(f, 2.9 times 10^(- 9) thin upright("Hz")))^(- 2) , $ taking $gamma = 0.2$ and $g_star.op = 106.75$ for frequencies in and above the LISA band. We consider cases where $k_star.op$ corresponds to a frequency of $10^(- 2) thin upright("Hz")$ in the LISA band and $30 thin upright("Hz")$ in the LIGO band.#footnote[Note that, for LIGO-band signals, if the primordial curvature spectrum were associated with PBH production, these PBHs (being lighter than $tilde 10^(- 18) M_⊙$) would have evaporated via Hawking radiation by today@Hawking:1974rv @Hawking:1974sw. In this work, however, we are agnostic as to the role the enhanced curvature spectrum plays in the production of PBHs.] One can observe how the signal shape changes with $F_(upright("NL"))$, with a distinctive three-peak structure arising at large $F_(upright("NL"))$.


== Lognormal spectrum
<sec:lognormal>


We now explore how the features of the GW spectrum induced by an idealized, monochromatic source are modulated when generalizing to a broader, more realistic spectrum. Consider a spectrum with a Gaussian bump in $ln ( k )$, as in, e.g., Ref.@Unal:2018yaa, $ Delta_g^2 ( k ) & = cal(A)_(cal(R)) / sqrt(2 pi sigma^2) exp (- frac(ln^2 ( k / k_star.op ), 2 sigma^2)) , $<eqn:P-g-lognormal> normalized so that $integral upright(d) ln k thin Delta_g^2 ( k ) = cal(A)_(cal(R))$. In Fig. #ref(<fig:lognormal-components-vs-mono>) we first study the effect of increasing $sigma$ on each of the individual non-Gaussian contributions in turn.


#figure(image("src/lognormal-vs-monochromatic-all-contributions-linear.pdf"),
  caption: [
    Unscaled (i.e., $cal(A)_(cal(R)) = 1$ and $F_(upright("NL")) = 1$) non-Gaussian contributions for a lognormal source, Eq. #ref(<eqn:P-g-lognormal>). Solid lines depict results for $sigma$ spanning $1 / 40$ through $1 / 5$ as indicated in the legend. The monochromatic result is overlaid in thin, dashed black.
  ]
)
<fig:lognormal-components-vs-mono>



As one might expect, the various features in each contribution become less pronounced, shrinking in amplitude and broadening in shape. In addition, most contributions exhibit a $k^(3 + a ln ( b k ))$ scaling in the infrared. Only for the Gaussian, C, and planar terms does an intermediate regime of $k^(2 + a ln ( b k ))$ behavior become partially evident for $sigma = 1 / 40$, but each transitions to $k^(3 + a ln ( b k ))$ for $k / k_star.op lt.tilde 10^(- 2)$.


We investigate the relative contributions of the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms in more detail in Fig. #ref(<fig:lognormal-tenth-gauss-vs-fnl2-vs-fnl4>), taking $sigma = 1 / 10$.


#figure(image("src/loggaussian-tenth-gauss-vs-fnl2-vs-fnl4-A-1e-3.pdf"),
  caption: [
    Induced GW spectrum after emission for a lognormal source with $sigma = 1 / 10$, $cal(A)_(cal(R)) = 10^(- 3)$ and various $F_(upright("NL"))$. The Gaussian, $cal(O) ( F_(upright("NL"))^2 )$, and $cal(O) ( F_(upright("NL"))^4 )$ contributions appear in dashed blue, dot-dashed green, and dotted red respectively. The total spectrum is depicted in thin black.
  ]
)
<fig:lognormal-tenth-gauss-vs-fnl2-vs-fnl4>



We again fix $cal(A)_(cal(R)) = 10^(- 3)$ and vary $F_(upright("NL"))$. The peak structure is smoothed compared to that for the monochromatic spectrum, Fig. #ref(<fig:monochromatic-gauss-vs-fnl2-vs-fnl4>). However, substantial non-Gaussianity does lead to a broad, nearly flat peak that distinguishes it from the narrower feature evident in the spectrum for a purely Gaussian curvature perturbation.


== Gaussian-shaped spectrum
<gaussian-shaped-spectrum>


We next consider the Gaussian-bump spectrum used in Ref.@Cai:2018dig, $ Delta_g^2 ( k ) & = (k / k_star.op)^3 cal(A)_(cal(R)) / sqrt(2 pi ( sigma / k_star.op )^2) exp (- frac(( k - k_star.op )^2, 2 sigma^2)) , $<eqn:P-g-gaussian-bump> again normalized so that $integral upright(d) ln k thin Delta_g^2 ( k ) = cal(A)_(cal(R))$. In Fig. #ref(<fig:gaussian-peak>) we show the total gravitational wave power spectrum for various values of the non-Gaussianity parameter, $F_(upright("NL"))$. We compare results including and excluding the connected terms, choosing $sigma = k_star.op / 30$, $cal(A)_(cal(R)) = 10^(- 3)$, and $f_star.op = k_star.op / 2 pi = 3 times 10^(- 3) thin upright("Hz")$ to match the choices of Ref.@Cai:2018dig. Even when neglecting the connected terms, we do not reproduce the particular peak structure observed in Ref.@Cai:2018dig, and when including all contributions we observe a more pronounced second peak around $2 f_star.op$. Though the peak amplitude near $f_star.op$ is largely unchanged, neglecting the connected term significantly underestimates the power at lower $k$ (as discussed in the monochromatic case above).


#figure(image("imgs/gaussian_30th_connected_and_not.png", width: 100%),
  caption: [
    Gravitational wave spectra generated by a Gaussian-bump spectrum, Eq. #ref(<eqn:P-g-gaussian-bump>), with $sigma = k_star.op / 30$, $cal(A)_(cal(R)) = 10^(- 3)$, and $k_star.op / 2 pi = 3 times 10^(- 3) thin upright("Hz")$. The left and right panels exclude and include the connected contributions, respectively.
  ]
)
<fig:gaussian-peak>



== Power law spectrum with an exponential cutoff
<power-law-spectrum-with-an-exponential-cutoff>


Another common spectral shape is a power law that is exponentially cut off near some $k_star.op$, $ Delta_g^2 ( k ) & = cal(A)_(cal(R)) ( k / k_star.op )^alpha e^(- alpha ( k / k_star.op - 1 )) . $<eqn:plexp-spectrum> This parameterization peaks at $k_star.op$ with amplitude $cal(A)_(cal(R))$ for any $alpha$. For example, Ref.@Inomata:2021uqj found that, in contrast to the standard ultra slow roll scenario, an inflationary potential with a small step could generate a curvature spectrum with $alpha = 4$ and a peak amplitude as large as $cal(A)_(cal(R)) approx 10^(- 2)$. Eq. #ref(<eqn:plexp-spectrum>) provides a good approximation to the result from Ref.@Inomata:2021uqj, aside from the oscillations in $k$.


We display the individual results for each non-Gaussian term in Fig. #ref(<fig:plexp-3-and-4-ng-components>).


#figure(image("src/plexp-3-and-4-unscaled-contributions.pdf"),
  caption: [
    Unscaled (i.e., $cal(A)_(cal(R)) = 1$ and $F_(upright("NL")) = 1$) non-Gaussian contributions for a power law source with an exponential cutoff, Eq. #ref(<eqn:plexp-spectrum>), for $alpha = 3$ (left panels) and $4$ (right panels). The dashed lines indicate each contribution at $cal(O) ( F_(upright("NL"))^2 )$ (top panels) and at $cal(O) ( F_(upright("NL"))^4 )$ (bottom panels) with colors denoted in the legend. Solid black lines depict the sum of the individual contributions appearing in each panel.
  ]
)
<fig:plexp-3-and-4-ng-components>



Like the monochromatic and lognormal sources, the connected and disconnected contributions peak at differing $k / k_star.op$, but their sum (at each order in $F_(upright("NL"))$) does not exhibit as prominent a multi-peak structure. The results are also not highly sensitive to the value of $alpha$.


We again depict the contributions of the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ terms for various $F_(upright("NL"))$ in Fig. #ref(<fig:plexp-4-gauss-vs-fnl2-vs-fnl4>) for $alpha = 4$.


#figure(image("src/plexp-4-gauss-vs-fnl2-vs-fnl4-A-1e-2.pdf"),
  caption: [
    Induced GW spectrum after emission for a power law source with an exponential cutoff, Eq. #ref(<eqn:plexp-spectrum>), with $alpha = 4$, $cal(A)_(cal(R)) = 10^(- 2)$ and various $F_(upright("NL"))$. The Gaussian, $cal(O) ( F_(upright("NL"))^2 )$, and $cal(O) ( F_(upright("NL"))^4 )$ contributions appear in dashed blue, dot-dashed green, and dotted red respectively. The total spectrum is depicted in thin black.
  ]
)
<fig:plexp-4-gauss-vs-fnl2-vs-fnl4>



In contrast to sources that decay more quickly in the infrared, the shapes of the contributions to different orders in $F_(upright("NL"))$ are similar, each exhibiting a relatively broad peak and an infrared scaling approaching $k^3$ with a moderate running. From the left panel of Fig. #ref(<fig:plexp-4-gauss-vs-fnl2-vs-fnl4>) we may deduce that the $cal(O) ( F_(upright("NL"))^2 )$ contributions are comparable to the Gaussian one when $cal(A)_(cal(R)) F_(upright("NL"))^2 approx 0.3$, while the right panel indicates that the $cal(O) ( F_(upright("NL"))^2 )$ and $cal(O) ( F_(upright("NL"))^4 )$ contributions match when $cal(A)_(cal(R)) F_(upright("NL"))^2 approx 3$. However, the signal is cut off at larger $k / k_star.op$ depending on whether (and which of) the non-Gaussian terms dominate.


Finally, we present results for the benchmark scenario of Ref.@Inomata:2021uqj (for the Gaussian part, including the effects of additional local-Gaussianity for illustrative purposes) in Fig. #ref(<fig:plexp-pta-money>), with a peak frequency of $k_star.op / 2 pi = 3 thin upright("nHz")$ and amplitude $cal(A)_(cal(R)) = 10^(- 2)$ (and $g_star.op = 10.75$).


#figure(image("src/plexp-alpha-4-pta-money.pdf"),
  caption: [
    Present-day induced GW spectrum for a power law ($alpha = 4$) source with an exponential cutoff, setting $cal(A)_(cal(R)) = 10^(- 2)$. The shaded regions indicate the sensitivity curves for the pulsar timing experiments NANOGrav and the Square Kilometer Array (SKA)@Schmitz:2020syl @schmitz_kai_2020_3689582.
  ]
)
<fig:plexp-pta-money>



== Broken power law spectrum
<broken-power-law-spectrum>


We next study a broken power law spectrum, as considered in Ref.@Atal:2021jyo, with parameterization $ Delta_g^2 ( k ) & = frac(cal(A)_(cal(R)), ( k / k_star.op )^(- alpha) + ( k / k_star.op )^beta) , $ scaling with $k^alpha$ in the IR and $k^(- beta)$ in the ultraviolet (UV). All contributions to the GW power exhibit a spectral index of $3 + a ln ( b k )$ in the infrared as in the lognormal case in Sec. #ref(<sec:lognormal>). In the ultraviolet the spectral index approaches $- 2 beta$ for $0 < beta < 4$ and $- 4 - beta$ for $beta > 4$. These scalings agree with Ref.@Atal:2021jyo, which provided estimates of the IR and UV behavior for the hybrid and Z contributions. Aside from decaying as a power law in the UV rather than exponentially, the qualitative features of the induced GW spectrum for this case are similar to that for the exponentially cut off power law.


= Conclusions
<sec:conclusion>


In this work we have carefully computed the effect of local non-Gaussianity on the spectrum of gravitational waves induced by scalar fluctuations. At lowest order in fluctuations, the induced gravitational wave spectrum is sourced by the trispectrum, or 4-point function of curvature fluctuations. We have shown that, contrary to some previous studies, the connected part of the trispectrum makes important contributions to the total spectrum that can neither be entirely neglected nor approximated by a multiple of the disconnected contributions. Our results demonstrate that studies of the induced GW spectrum from non-Gaussian curvature perturbations must carefully consider (and compute) all such contributions. For the power spectrum enhancements that are commonly considered in PBH scenarios (with $cal(A)_(cal(R)) tilde 10^(- 3)$), even modest values of $F_(upright("NL")) tilde cal(O) ( 1 )$ to $cal(O) ( 10 )$ significantly impact the induced GW spectrum.


A number of possible extensions merit attention. We have considered only the standard local-type non-Gaussianity, while more generally other bispectrum shapes may be relevant in detailed constructions, such as Ref.@Inomata:2021uqj. Furthermore, connected contributions must also be considered for higher-order non-Gaussianity, such as that considered in Ref.@Yuan:2020iwf. We leave these considerations for future work.





We gratefully thank Keisuke Inomata for comments on a draft of this manuscript and Caner Unal and Guillem Domenech for useful discussions. This work was supported in part by the US Department of Energy through grant DESC0015655. Z.J.W.~is supported in part by the United States Department of Energy Computational Science Graduate Fellowship, provided under Grant No. DE-FG02-97ER25308. This work made use of the Illinois Campus Cluster, a computing resource that is operated by the Illinois Campus Cluster Program (ICCP) in conjunction with the National Center for Supercomputing Applications (NCSA) and which is supported by funds from the University of Illinois at Urbana-Champaign. This work made use of the Python packages vegas@Lepage:2020tgj, NumPy@harris2020array, SciPy@scipy, matplotlib@matplotlib, and emcee@ForemanMackey:2012ig.





= Cosmological perturbation theory
<app:cpt>


In this appendix we elaborate on the dynamics of cosmological perturbations and the gravitational wave spectrum induced at second order by scalar perturbations. Recall that the background Einstein equations set $
  cal(H)^2 &  & 
$ <eqn:background-einstein-eqns> We define the perturbations to the stress-energy tensor as $
  delta T_(upright("hphantom") 0 0)^0 & = - delta rho \\
  delta T_(upright("hphantom") 0 i)^0 &  & = delta_(i j) delta P
$ <eqn:stress-tensor-decomp-mixed> neglecting vector and tensor perturbations and scalar anisotropic stress. We can solve the first-order Einstein equations for $delta rho$, $delta P$, and $delta u$ as $
  delta rho &  &  & 
$ <eqn:scalar-flucs-ito-metric>


The terms in the space-space components of the Einstein tensor that are second order in the Newtonian potential are $ a^2 delta^(( 2 )) G_i^j & = 4 Phi partial_i partial_j Phi + 2 partial_i Phi partial_j Phi + delta_i^j (20 (cal(H)^2 + cal(H)') Phi^2 + 8 cal(H) Phi Phi' - 4 Phi partial_k partial_k Phi - Phi'^2 - 3 partial_k Phi partial_k Phi) . $ GWs are also sourced by second-order perturbations to the stress-energy tensor, which, using [Eq. #ref(<eqn:scalar-flucs-ito-metric>)], may be expressed in terms of metric perturbations as $
  delta^(( 2 )) T_i^(upright("hphantom") i j) & 
$ Dropping terms proportional to $delta_(i j)$, setting \$"mkern" 1.25mu"macron"("mkern"-1.25muP"mkern"-1.25mu)"mkern" 1.25mu = w "mkern" 1.25mu"macron"("mkern"-1.25murho"mkern"-1.25mu)"mkern" 1.25mu\$, and substituting [Eq. #ref(<eqn:background-einstein-eqns>)], $ cal(S)_(i j) & = 4 Phi partial_i partial_j Phi + frac(2 ( 1 + 3 w ), 3 ( 1 + w )) partial_i Phi partial_j Phi - frac(4, 3 ( 1 + w ) cal(H)^2) [partial_i Phi' partial_j Phi' + cal(H) partial_i Phi partial_j Phi' + cal(H) partial_i Phi' partial_j Phi] . $<eqn:Sij-second-order>


After using Eq. #ref(<eqn:transfer-times-curvature>) to express the Newtonian potential in terms of the comoving curvature perturbation $cal(R) ( upright(bold(k)) )$ and the transfer function $Phi ( k tau )$, taking a Fourier transform, and projecting onto (negative) $epsilon.alt_(i j)^lambda ( upright(bold(k)) )$, we find $ cal(S)_lambda ( tau , upright(bold(k)) ) & equiv - epsilon.alt_(l m)^lambda ( upright(bold(k)) ) cal(S)_(l m) ( upright(bold(k)) )\
 & = integral frac(upright(d)^3 q, ( 2 pi )^(3 / 2)) Q_lambda ( upright(bold(k)) , upright(bold(q)) ) f ( lr(|upright(bold(k)) - upright(bold(q))|) , q , tau ) cal(R) ( upright(bold(q)) ) cal(R) ( upright(bold(k)) - upright(bold(q)) ) , $<eqn:source-definition> with $ f ( p , q , tau ) & equiv frac(3 ( 1 + w ), ( 5 + 3 w )^2) \[ 2 ( 5 + 3 w ) Phi ( p tau ) Phi ( q tau ) + 4 / cal(H)^2 Phi' ( p tau ) Phi' ( q tau )\
 & + 4 / cal(H) (Phi ( p tau ) Phi' ( q tau ) + Phi' ( p tau ) Phi ( q tau )) \] . $<eqn:def-f-general> Substituting $cal(H) = alpha / tau$ (via Eq. #ref(<eqn:scale-factor-fixed-eos>)) yields Eq. #ref(<eqn:source-function-p-q-tau>). The projection factors $Q_lambda$ defined in Eq. #ref(<eqn:projection-factor-def>) obey the symmetries $ Q_lambda ( upright(bold(k)) , upright(bold(q)) ) & = Q_lambda ( upright(bold(k)) , upright(bold(q)) + gamma upright(bold(k)) )\
Q_lambda ( upright(bold(k)) , upright(bold(q)) ) & = Q_lambda ( - upright(bold(k)) , upright(bold(q)) ) = Q_lambda ( upright(bold(k)) , - upright(bold(q)) ) = Q_lambda ( - upright(bold(k)) , - upright(bold(q)) ) . $<eqn:projection-factor-symmetries>


We next require the solution to the equation of motion of the transfer function, $Phi ( k tau )$. In the absence of isocurvature perturbations, the Newtonian potential evolves according to $ Phi'' ( tau , upright(bold(k)) ) + 3 ( 1 + w ) cal(H) Phi' ( tau , upright(bold(k)) ) + w k^2 Phi ( tau , upright(bold(k)) ) & = 0 , $<eqn:newtonian-potential-eom> after setting $delta P = w delta rho$. Using Eq. #ref(<eqn:scale-factor-fixed-eos>), Eq. #ref(<eqn:newtonian-potential-eom>) leads to $ 0 & = frac(upright(d)^2 Phi, upright(d) y^2) + frac(6 ( 1 + w ), 1 + 3 w) 1 / y frac(upright(d) Phi, upright(d) y) + Phi , $<eqn:transfer-eom-ito-alpha> where $y equiv sqrt(w) k tau$. For $w eq.not 0$, the solutions are given in terms of the spherical Bessel functions of the first and second kind, $j_nu$ and $y_nu$: $ Phi ( k tau ) & = frac(C_1 j_(gamma - 1) ( y ) + C_2 y_(gamma - 1) ( y ), y^(gamma - 1)) , $ where $gamma = 3 ( 1 + w ) / ( 1 + 3 w )$. Imposing the superhorizon initial conditions $Phi ( x arrow.r 0 ) = 1$ and $partial_x Phi ( x arrow.r 0 ) = 0$ sets $C_1 = 1$ and $C_2 = 0$. In radiation domination, $gamma = 2$ and $ Phi ( y ) & = frac(sin y - y cos y, y^3) $ In matter domination, the solution to Eq. #ref(<eqn:newtonian-potential-eom>) for the transfer function is instead merely $Phi ( k tau ) = 1 .$


The Green function for the tensor perturbations (i.e., the solution to [Eq. #ref(<eqn:green-function-eom>)]) is constructed via $
   & 
$ where $v_1$ and $v_2$ are the homogeneous solutions to the equation of motion for $v ( k tau ) = a ( tau ) h_lambda ( tau , upright(bold(k)) )$, $ frac(upright(d)^2 v, upright(d) x^2) + (1 - frac(alpha ( alpha - 1 ), x^2)) v = 0 . $ The solutions are $ v_1 ( x ) & = x j_(alpha - 1) ( x )\
v_2 ( x ) & = x y_(alpha - 1) ( x ) , $<eqn:homogeneous-solutions-v> leading to $
   & 
$ In radiation domination where $w = 1 / 3$ and so $alpha = 1$, the Green function is $
  
$


In, e.g., radiation domination, [Eq. #ref(<eqn:I-def>)] can be computed analytically in terms of cosine and sine integrals via repeated integration by parts@Kohri:2018awv. Defining $tilde(I) ( v , u , x ) equiv k^2 I ( v k , u k , x / k )$, the quantity required to compute the observable gravitational wave spectrum is $
  accent(tilde(I) ( v_1 \, u_1 \, x arrow.r oo ) tilde(I) ( v_2 \, u_2 \, x arrow.r oo ), ¯) & = frac(1, 2 x^2) tilde(I)_A ( u_1 \, v_1 ) tilde(I)_A ( u_2 \, v_2 ) #scale(x: 180%, y: 180%)[\[] tilde(I)_B ( u_1 \, v_1 ) tilde(I)_B ( u_2 \, v_2 ) \\
   & upright("hphantom")  =  frac(1, 2 x^2) tilde(I)_A ( u_1 \, v_1 ) tilde(I)_A ( u_2 \, v_2 ) #scale(x: 180%, y: 180%)[\[] + pi^2 tilde(I)_C ( u_1 \, v_1 ) tilde(I)_C ( u_2 \, v_2 ) #scale(x: 180%, y: 180%)[\]]
$ <eqn:late-time-transfer-function-product> where $ tilde(I)_A ( u , v ) & = frac(3 ( u^2 + v^2 - 3 ), 4 u^3 v^3)\
tilde(I)_B ( u , v ) & = - 4 u v + ( u^2 + v^2 - 3 ) ln lr(|frac(3 - ( u + v )^2, 3 - ( u - v )^2)|)\
tilde(I)_C ( u , v ) & = (u^2 + v^2 - 3) Theta ( v + u - sqrt(3) ) . $<eqn:I-B>


= Diagrammatic rules for the gravitational wave spectrum
<app:trispectrum>


In this appendix, we detail the computation of the contributions to the primordial trispectrum that induce gravitational waves. While a direct computation is straightforward, if tedious, we also present a diagrammatic representation of the non-Gaussian contributions. In order to make contact with existing literature, we present explicit Feynman-type rules with which one can represent each of the integrals contributing to the induced GW spectrum.


A complication in this approach is that the transfer functions relate the (nonlinear) curvature perturbation amplitudes to the Newtonian potential. The momenta flowing through the transfer functions must be tracked, and as we demonstrate below this leads to differences in diagrams that are otherwise topologically identical. We denote transfer functions with dashed lines; 3-momenta flow through these in the direction indicated by the arrow. The rules are given in [\[Tab:DiagramRules\]]. They function like regular Feynman rules: one draws all allowed diagrams and integrates over all loop momenta, momentum is conserved at each vertex, and the overall momentum of a diagram is zero.


c \@ c \@ c (i) & & \$\\displaystyle 4 \\int\_{\\tau\_0}^{\\tau} \"d" \\mkern 1.25mu\\overline{\\mkern-1.25mu\\tau\\mkern-1.25mu}\\mkern 1.25mu \\,
        \\frac{a(\\mkern 1.25mu\\overline{\\mkern-1.25mu\\tau\\mkern-1.25mu}\\mkern 1.25mu)}{a(\\tau)}
        G\_\bold(k)(\\tau, \\mkern 1.25mu\\overline{\\mkern-1.25mu\\tau\\mkern-1.25mu}\\mkern 1.25mu)
        Q\_\\lambda(\bold(k), \bold(q))
        f({\\left \\vert  \bold(k) - \bold(q)  \\right \\vert}, q, \\mkern 1.25mu\\overline{\\mkern-1.25mu\\tau\\mkern-1.25mu}\\mkern 1.25mu)\$ \
(ii) & & $1$ \
(iii) & & $F_(upright(N L))$ \
(iv) & & $cal(P)_g \( q \)$


Note that, even when performing the computations algebraically, a diagrammatic representation that accounts for the transfer functions facilitates determining the multiplicity of each term (while keeping in mind the symmetries of the transfer function and Eq. #ref(<eqn:projection-factor-symmetries>)).


The contribution from the purely Gaussian part of the curvature perturbation is shown in Fig. #ref(<fig:FNL0Feynman>).


#figure(image("imgs/FeynGaussian.png", width: 100%),
  caption: [
    The Gaussian diagram, contributing at $cal(O) \( F_(upright(N L))^0 \)$ to the GW power spectrum.
  ]
)
<fig:FNL0Feynman>



The contributions due to the non-Gaussianity of the curvature perturbation are shown in Fig. #ref(<fig:FNL2Feynman>) for those at $cal(O) \( F_(upright(N L))^2 \)$ and in Fig. #ref(<fig:FNL4Feynman>) for those at $cal(O) \( F_(upright(N L))^4 \)$. Contributions at higher order in $F_(upright(N L))$ require expanding the stress-energy tensor itself to higher order in fluctuations and are suppressed by additional powers of the amplitude of the curvature spectrum. We have omitted vanishing diagrams in which the solid lines in rule (iii) are connected; these simply cancel (see Eq. #ref(<eq:RNG>)).


#figure([#box(image("imgs/FeynHybrid.png", width: 100%)) #box(image("imgs/FeynWalnut.png", width: 100%)) #box(image("imgs/Feyn4vertex.png", width: 100%)) #box(image("imgs/FeynVanishing.png", width: 100%))

  ],
  caption: [
    Hybrid (top left), Z (top right), and C (bottom left) diagrams, contributing at $cal(O) \( F_(upright(N L))^2 \)$ to the GW power spectrum. The bottom right diagram vanishes due to the integration over the azimuthal angles of the internal momenta.
  ]
)
<fig:FNL2Feynman>



#figure([#box(image("imgs/Feyndisc3.png", width: 100%)) #box(image("imgs/Feynplanar.png", width: 100%)) #box(image("imgs/Feynnonplanar.png", width: 100%))

  ],
  caption: [
    The reducible (top left), planar (top right), and nonplanar (bottom) diagrams, contributing at $cal(O) \( F_(upright(N L))^4 \)$ to the GW power spectrum.
  ]
)
<fig:FNL4Feynman>



Compared to the diagrams in Ref.@Unal:2018yaa, we can identify the hybrid diagram in Fig. #ref(<fig:FNL2Feynman>) and the disconnected, planar, and nonplanar ones in Fig. #ref(<fig:FNL4Feynman>) by replacing our dashed lines with solid lines. However, the so-called "walnut" diagram of Ref.@Unal:2018yaa could be either of the remaining diagrams in Fig. #ref(<fig:FNL2Feynman>). No rules are provided in Ref.@Unal:2018yaa for converting the diagrams to equations. However, our expression for the C diagram matches the expression for the "walnut" diagram in the supplemental material of Ref.@Unal:2018yaa. (Furthermore, sans transfer functions, the propagator topology of the Z term more closely relates to the standard sunset diagram.)


= Recasting the integrals
<app:recasting-the-integrals>


In this appendix we recast the integrals into a numerically favorable form. Specifically, we present the polarization-summed, dimensionless gravitational wave power spectrum $ Delta_h^2 \( k \) & equiv frac(k^3, 2 pi^2) sum_lambda cal(P)_lambda \( k \) . $ First define the variables $ u & = lr(|upright(bold(k)) - upright(bold(q))|) / k\
v & = q / k . $ The Jacobian of this transformation is $- k u \/ v$, so the integration transforms to $ integral upright(d)^3 q & = k^3 integral_0^oo upright(d) v integral_(lr(|1 - v|))^(1 + v) upright(d) u thin v u integral_0^(2 pi) upright(d) phi.alt . $<eqn:integral-change-vars> In terms of $u$ and $v$, $ sin^2 theta & = frac(4 v^2 - \( 1 + v^2 - u^2 \)^2, 4 v^2) . $ Next define $ s & = u - v\
t & = u + v - 1 . $ The Jacobian for this transformation is $1 \/ 2$, so $ integral_0^oo upright(d) v integral_(lr(|1 - v|))^(1 + v) upright(d) u & = 1 / 2 integral_0^oo upright(d) t integral_(- 1)^1 upright(d) s . $ The integration domain over $s$ and $t$ is rectangular, a requirement of most multidimensional numerical quadrature routines. Though these shall be our integration variables, we retain $u$ and $v$ in expressions for notational convenience.


[Eq. #ref(<eqn:I-def>)] takes the form $ tilde(I) \( v \, u \, x \) equiv k^2 I \( q \, lr(|upright(bold(k)) - upright(bold(q))|) \, x \/ k \) & = integral_(x_0)^x upright(d) tilde(x) thin k G_(upright(bold(k))) \( x \/ k \, tilde(x) \/ k \) frac(a \( tilde(x) \/ k \), a \( x \/ k \)) f \( v k \, u k \, tilde(x) \/ k \) . $<eqn:I-to-I-ito-u-v-x> For further notational convenience, we define $ tilde(J) \( v \, u \, x \) & equiv v^2 sin^2 theta tilde(I) \( v \, u \, x \) = frac(4 v^2 - \[ 1 + v^2 - u^2 \]^2, 4) tilde(I) \( v \, u \, x \) \, $<eqn:J-tilde-def> where $theta$ is the polar angle of $upright(bold(q))$. Namely, $tilde(J) \( v \, u \, x \)$ is equal to $sqrt(2) Q_lambda \( upright(bold(k)) \, upright(bold(q)) \) I \( q \, lr(|upright(bold(k)) - upright(bold(q))|) \, x \/ k \)$ divided by $sin 2 phi.alt$ or $cos 2 phi.alt$ for the plus and cross polarizations, respectively.


== Disconnected contributions
<disconnected-contributions>


With the above definitions, the Gaussian contribution Eq. #ref(<eqn:P-lambda-gaussian>) to the (dimensionless) GW power spectrum (in terms of the dimensionless Gaussian curvature power spectrum $Delta_g^2 \( k \)$) is $ Delta_h^2 \( tau \, k \)_(upright(G a u s s i a n)) & = 4 integral_0^oo upright(d) t integral_(- 1)^1 upright(d) s thin u v tilde(J) \( v \, u \, k tau \)^2 frac(Delta_g \( v k \), v^3) frac(Delta_g \( u k \), u^3) . $ Turning to the hybrid term, define $ u_1 & = lr(|upright(bold(k)) - upright(bold(q))_1|) / k\
v_1 & = q_1 / k\
u_2 & = lr(|upright(bold(q))_1 - upright(bold(q))_2|) / q_1\
v_2 & = q_2 / q_1 . $ Then Eq. #ref(<eqn:P-lambda-hybrid>) yields $ Delta_h^2 \( tau \, k \)_(upright(h y b r i d)) & = 4 F_(upright(N L))^2 integral_0^oo upright(d) t_1 integral_(- 1)^1 upright(d) s_1 integral_0^oo upright(d) t_2 integral_(- 1)^1 upright(d) s_2 thin u_1 v_1^4 u_2 v_2\
 & times tilde(J) \( v_1 \, u_1 \, k tau \)^2 frac(Delta_g^2 \( u_1 k \), u_1^3) frac(Delta_g^2 \( v_2 v_1 k \), \( v_2 v_1 \)^3) frac(Delta_g^2 \( u_2 v_1 k \), \( u_2 v_1 \)^3) . $ Further defining $ v_3 & = q_3 / lr(|upright(bold(k)) - upright(bold(q))_1|)\
u_3 & = lr(|\( upright(bold(k)) - upright(bold(q))_1 \) - upright(bold(q))_3|) / lr(|upright(bold(k)) - upright(bold(q))_1|) . $ the reducible term, Eq. #ref(<eqn:P-lambda-reducible>), contributes as $ Delta_h^2 \( tau \, k \)_(upright(r e d u c i b l e)) & = F_(upright(N L))^4 integral_(- 1)^1 upright(d) s_1 integral_0^oo upright(d) t_1 integral_(- 1)^1 upright(d) s_2 integral_0^oo upright(d) t_2 integral_(- 1)^1 upright(d) s_3 integral_0^oo upright(d) t_3 thin u_1^4 v_1^4 u_2 v_2 u_3 v_3\
 & times tilde(J) \( v_1 \, u_1 \, k tau \)^2 frac(Delta_g^2 \( v_2 v_1 k \), \( v_2 v_1 \)^3) frac(Delta_g^2 \( u_2 v_1 k \), \( u_2 v_1 \)^3) frac(Delta_g^2 \( v_3 u_1 k \), \( v_3 u_1 \)^3) frac(Delta_g^2 \( u_3 u_1 k \), \( u_3 u_1 \)^3) . $


== Connected diagrams
<connected-diagrams>


For the connected diagrams we define $ u_i & = lr(|upright(bold(k)) - upright(bold(q))_i|) / k\
v_i & = q_i / k $ for all $i$. We require the dot products between various $upright(bold(q))_i$, $ frac(upright(bold(q))_i dot.op upright(bold(q))_j, k^2) & = frac(cos \( phi.alt_i - phi.alt_j \), 4) sqrt(t_i \( t_i + 2 \) \( 1 - s_i^2 \) t_j \( t_j + 2 \) \( 1 - s_j^2 \))\
 & + 1 / 4 [1 - s_i \( t_i + 1 \)] [1 - s_j \( t_j + 1 \)] \, $<eqn:qi-dot-qj> as well as between $upright(bold(k))$ and $upright(bold(q))_i$: $ frac(upright(bold(k)) dot.op upright(bold(q))_i, k^2) = 1 / 2 [1 - s_i \( t_i + 1 \)] . $<eqn:k-dot-qi>


Because the integrands only depend on the differences between azimuthal angles, a suitable coordinate transformation renders one of the azimuthal integrals trivial. For the C and Z terms, [Eq. #ref(<eqn:P-lambda-4-vertex>) and Eq. #ref(<eqn:P-lambda-sunset>)], we integrate over $phi = phi.alt_1 - phi.alt_2$, leading to $ Delta_h^2 ( tau , k )_(upright(c) , F_(upright("NL"))^2) & = frac(4 F_(upright("NL"))^2, pi) product_(i = 1)^2 [integral_(- 1)^1 upright(d) s_i integral_0^oo upright(d) t_i thin u_i v_i tilde(J) ( u_i , v_i , k tau )] integral_0^(2 pi) upright(d) phi thin cos 2 phi\
 & times [frac(Delta_g^2 ( v_2 k ), v_2^3) frac(Delta_g^2 ( u_2 k ), u_2^3) frac(Delta_g^2 ( w_a k ), w_a^3) + frac(Delta_g^2 ( v_1 k ), v_1^3) frac(Delta_g^2 ( v_2 k ), v_2^3) frac(Delta_g^2 ( w_b k ), w_b^3)] , $<eqn:connected-fnl-squared-ito-s-and-t> where $ w_a^2 & = v_1^2 + v_2^2 - 2 frac(upright(bold(q))_1 dot.op upright(bold(q))_2, k^2)\
w_b^2 & = 1 + v_1^2 + v_2^2 - 2 frac(upright(bold(k)) dot.op upright(bold(q))_1, k^2) - 2 frac(upright(bold(k)) dot.op upright(bold(q))_2, k^2) + 2 frac(upright(bold(q))_1 dot.op upright(bold(q))_2, k^2) . $


Finally, for the planar and nonplanar terms, [Eq. #ref(<eqn:P-lambda-planar>) and Eq. #ref(<eqn:P-lambda-nonplanar>)], we integrate over $phi_12 equiv phi.alt_1 - phi.alt_2$ and $phi_23 equiv phi.alt_2 - phi.alt_3$. We obtain $ Delta_h^2 ( tau , k )_(upright(c) , F_(upright("NL"))^4) & = frac(F_(upright("NL"))^4, 2 pi^2) product_(i = 1)^3 [integral_(- 1)^1 upright(d) s_i integral_0^oo upright(d) t_i thin u_i v_i] product_(j = 1)^2 [tilde(J) ( u_j , v_j , k tau )] integral_0^(2 pi) upright(d) phi_12 upright(d) phi_23 thin cos 2 phi_12\
 & times (frac(Delta_g^2 ( v_3 k ), v_3^3) frac(Delta_g^2 ( w_13 k ), w_13^3) frac(Delta_g^2 ( w_23 k ), w_23^3) [2 frac(Delta_g^2 ( u_3 k ), u_3^3) + frac(Delta_g^2 ( w_123 k ), w_123^3)]) , $ with the definitions $ w_(i 3)^2 & = v_i^2 + v_3^2 - 2 / k^2 upright(bold(q))_i dot.op upright(bold(q))_3\
w_123^2 & = 1 + v_1^2 + v_2^2 + v_3^2 - 2 frac(upright(bold(k)) dot.op upright(bold(q))_1, k^2) - 2 frac(upright(bold(k)) dot.op upright(bold(q))_2, k^2) + 2 frac(upright(bold(k)) dot.op upright(bold(q))_3, k^2)\
 & - 2 frac(upright(bold(q))_3 dot.op upright(bold(q))_1, k^2) - 2 frac(upright(bold(q))_3 dot.op upright(bold(q))_2, k^2) + 2 frac(upright(bold(q))_1 dot.op upright(bold(q))_2, k^2) . $


We implement the integrals numerically with vegas+@Lepage:2020tgj, performing each for at least 200 external momenta $k$ and with a sufficiently large number of evaluations to achieve a relative precision of $10^(- 3)$. For the higher dimensional integrals (the reducible and all connected terms), we find using a relatively short MCMC sample (implemented with emcee@ForemanMackey:2012ig) as a preconditioner to be an efficient means of generating an optimal vegas map (see the discussion in Ref.@Lepage:2020tgj).


= Monochromatic spectrum: infrared limit
<sec:monochromatic-analytic>


We now sketch a derivation of the IR scaling of the induced GW spectrum for the monochromatic case, considering the C term \[Eq. #ref(<eqn:P-lambda-4-vertex>)\] as an example. Starting from Eq. #ref(<eqn:connected-fnl-squared-ito-s-and-t>), changing integration variables from $phi$ to $c equiv cos phi$, and substituting Eq. #ref(<eqn:P-g-monochromatic>), $ frac(Delta_h^2 ( k , tau )_(upright("C")), F_(upright("NL"))^2 cal(A)_(cal(R))^3) & = 4 / pi product_(i = 1)^2 [integral_(- 1)^1 upright(d) s_i integral_0^oo upright(d) t_i thin u_i v_i tilde(J) ( u_i , v_i , k tau )] 2 integral_(- 1)^1 upright(d) c thin frac(2 c^2 - 1, sqrt(1 - c^2))\
 & times frac(delta ( v_1 tilde(k) - 1 ), v_1^3) frac(delta ( u_1 tilde(k) - 1 ), u_1^3) frac(delta ( w_a tilde(k) - 1 ), w_a^3) . $ Recall that $tilde(k) = k / k_star.op$. Integrating the Dirac delta functions over $s_1$, $t_1$, and $c$ sets $ s_1 & = 0\
t_1 & = 2 / tilde(k) - 1\
c & = frac(- 1 + u_2^2 + v_2^2, 4 v_1 v_2 sin theta_1 sin theta_2) , $<eqn:monochromatic-C-values-for-integration-vars> and introduces a Jacobian factor of $2 w_a / tilde(k)^3 v_1 v_2 sin theta_1 sin theta_2$. Here $theta_i$ is the azimuthal angle of $upright(bold(q))_i$, for which $sin^2 theta_i = t_i ( t_i + 2 ) ( 1 - s_i^2 ) / 4 v_i^2$. Note that Eq. #ref(<eqn:monochromatic-C-values-for-integration-vars>) sets $v_1 sin theta_1 = sqrt(1 - tilde(k)^2 / 4) / tilde(k)$. The leading-order, IR behavior of the product of the (late-time, oscillation-averaged) transfer functions, [Eq. #ref(<eqn:late-time-transfer-function-product>)], resides in the $tilde(I)_A tilde(I)_B$ factors. After substituting Eq. #ref(<eqn:J-tilde-def>) for $tilde(J)$ and evaluating $tilde(I)_A ( u_1 , v_1 ) tilde(I)_B ( u_1 , v_1 )$ at $u_1 = v_1 = 1 / tilde(k)$, $ frac(Delta_h^2 ( k , tau )_(upright("C")), F_(upright("NL"))^2 cal(A)_(cal(R))^3) & approx frac(12 tilde(k)^4, 2 pi ( k tau )^2) ln (frac(4, 3 tilde(k)^2)) Theta ( 2 - tilde(k) )\
 & times integral_(- 1)^1 upright(d) s_2 integral_0^oo upright(d) t_2 thin frac(2 ( 2 c^2 - 1 ) Theta ( 1 - lr(|c|) ), sqrt(1 - c^2)) tilde(I)_A ( u_2 , v_2 ) tilde(I)_B ( u_2 , v_2 ) u_2 v_2^2 sin theta_2 , $ where $c$ is implicitly set by [Eq. #ref(<eqn:monochromatic-C-value-for-c>)].


The $tilde(k)$-dependence of the remaining integral over $s_2$ and $t_2$ arises solely from $c$'s own $tilde(k)$-dependence, affecting both the integrand and the bounds of integration via the Heaviside function $Theta ( 1 - lr(|c|) )$. Inspecting the form of $c$ in [Eq. #ref(<eqn:monochromatic-C-value-for-c>)] (in terms of $s_2$ and $t_2$) shows that this Heaviside factor cuts off the integrals at $t_2 tilde 4 / tilde(k)$. Furthermore, the integrand grows with $t_2$, so the integral is dominated by this upper limit. The integrand depends weakly on $s_2$ and one can show that regardless of $s_2$'s value, to leading order in $tilde(k)$ and $1 / t_2$ the $t_2$-dependence of the integrand is $tilde t_2 ln t_2$. As a result, the integral itself contributes a factor $tilde tilde(k)^(- 2) ln tilde(k)$ and so, to leading order in $tilde(k)$, $ Omega_(upright("GW") , 0) tilde tilde(k)^2 ln^2 tilde(k) . $

#pagebreak(weak: true)
#bibliography("refs.bib", style: "ieee", title: [References])
