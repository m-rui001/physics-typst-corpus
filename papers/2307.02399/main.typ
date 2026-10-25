#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.79cm, bottom: 2.38cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: none)
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
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

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Cosmological Background Interpretation of Pulsar Timing Array Data])   #v(1.2em)
    #text(10.5pt)[Daniel G. Figueroa, Mauro Pieroni, Angelo Ricciardone, Peera Simakachorn]
  
  ]

  #v(1.2em)














// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: April 29, 2024)]]

  We discuss the interpretation of the detected signal by Pulsar Timing Array (PTA) observations as a gravitational wave background (GWB) of cosmological origin. We combine `NANOGrav 15-years` and `EPTA-DR2new` data sets and confront them against backgrounds from supermassive black hole binaries (SMBHBs), and cosmological signals from inflation, cosmic (super)strings, first-order phase transitions, Gaussian and non-Gaussian large scalar fluctuations, and audible axions. We find that scalar-induced, and to a lesser extent audible axion and cosmic superstring signals, provide a better fit than SMBHBs. These results depend, however, on modeling assumptions, so further data and analysis are needed to reach robust conclusions. Independently of the signal origin, the data strongly constrain the parameter space of cosmological signals, for example, setting an upper bound on primordial non-Gaussianity at PTA scales as $| f_(mono(n l)) | lt.tilde 2.34$ at 95\% CL.
]











#strong[Introduction.--] Pulsar timing array (PTA) collaborations, NANOGrav, EPTA/InPTA, PPTA, and CPTA, have presented evidence~@NANOGrav:2023gor @Antoniadis:2023ott @Reardon:2023gzh @Xu:2023wog for an isotropic stochastic gravitational wave background (GWB), thanks to measuring to $tilde ( 3 - 4 ) sigma$ the expected #emph[Hellings-Downs] angular correlation between pulsars' line of sights~@Hellings:1983fr @Jenet:2014bea.


This event represents a milestone in physics and marks the dawn of #emph[early universe gravitational wave (GW) astronomy], as it offers unprecedented opportunities for high-energy physics and early universe cosmology. Namely, early universe dynamics operate at energies unreachable by terrestrial means, emitting GWs that carry information about their source. These are referred to as #emph[cosmological] GWBs, in contrast with #emph[astrophysical] backgrounds. The detection of a cosmological GWB offers a new window into the physics #emph[beyond the standard model] (BSM) that characterize the early Universe~@Caprini:2018mtu. Cosmological GWBs are expected from vacuum fluctuations~@Grishchuk:1974ny @Starobinsky:1979ty @Rubakov:1982df @Fabbri:1983us or particle production during inflation~@Anber:2006xt @Sorbo:2011rz @Pajer:2013fsa @Adshead:2013qp @Adshead:2013nka @Maleknejad:2016qjz @Dimastrogiovanni:2016fuu @Namba:2015gja @Ferreira:2015omg @Peloso:2016gqs @Domcke:2016bkh @Caldwell:2017chz @Guzzetti:2016mkm @Bartolo:2016ami @DAmico:2021zdd @DAmico:2021vka, and from preheating~@Easther:2006gt @GarciaBellido:2007dg @GarciaBellido:2007af @Dufaux:2007pt @Dufaux:2008dn @Dufaux:2010cf @Bethke:2013aba @Bethke:2013vca @Figueroa:2017vfa @Adshead:2018doq @Adshead:2019lbr @Adshead:2019igv, kination-domination~@Giovannini:1998bp @Giovannini:1999bh @Boyle:2007zx @Li:2016mmc @Li:2021htg @Figueroa:2018twl @Figueroa:2019paj @Gouttenoire:2021wzu @Co:2021lkc @Gouttenoire:2021jhk @Oikonomou:2023qfz, thermal plasma~@Ghiglieri:2015nfa @Ghiglieri:2020mhm @Ringwald:2020ist @Ghiglieri:2022rfp, oscillons~@Zhou:2013tsa @Antusch:2016con @Antusch:2017vga @Liu:2017hua @Amin:2018xfe, first order Phase Transitions (PhTs)~@Kamionkowski:1993fg @Caprini:2007xq @Huber:2008hg @Hindmarsh:2013xza @Hindmarsh:2015qta @Caprini:2015zlo @Hindmarsh:2017gnf @Cutting:2018tjt @Cutting:2019zws @Pol:2019yex @Caprini:2019egz @Cutting:2020nla @Han:2023olf @Ashoorioon:2022raz @Athron:2023mer @Li:2023yaj, cosmic defects~@Vachaspati:1984gt @Sakellariadou:1990ne @Damour:2000wa @Damour:2001bk @Damour:2004kw @Figueroa:2012kw @Hiramatsu:2013qaa @Blanco-Pillado:2017oxo @Auclair:2019wcv @Gouttenoire:2019kij @Figueroa:2020lvo @Gorghetto:2021fsn @Chang:2021afa @Yamada:2022aax @Yamada:2022imq @Kitajima:2023cek, or large scalar fluctuations~@Matarrese:1992rp @Matarrese:1993zf @Matarrese:1997ay @Nakamura:2004rm @Ananda:2006af @Baumann:2007zm @Domenech:2021ztg @Dandoy:2023jot, see~@Caprini:2018mtu for a comprehensive review.


In this #emph[Letter] we combine the NANOGrav 15-year (`NG15`)~@NANOGrav:2023hde and EPTA `DR2new`~@Antoniadis:2023utw data sets, performing a Bayesian search for astrophysical backgrounds from supermassive black hole binaries (SMBHBs) and cosmological signals from inflation, cosmic (super)strings, first order PhTs, Gaussian and non-Gaussian scalar fluctuations, and audible axions, leading to tighter (compared to single data sets alone) constraints on the parameters of such cosmological scenarios~@NANOGrav:2023hvm @Antoniadis:2023xlr. We also provide new constraints, #emph[e.g.],~establishing an upper bound on primordial non-Gaussianity at PTA scales or stringent constraints on audible axions. We find that Gaussian and non-Gaussian scalar-induced and, to a lower degree, audible axion or superstring signals fit the data better than SMBHBs with large Bayes factors. This depends, however, on modeling assumptions, which highlight that more data and analysis are needed to discern between a cosmological or an astrophysical origin of the signal.


#strong[GWB signals.--] Signal candidates to explain PTA data can be classified according to their spectrum today:


#emph[i) SMBHBs]. The GWB spectrum at PTA frequencies ($f_(upright("yr")) = 1 / upright("year")$) from SMBHBs can be parametrized as


$ Omega_(upright("GW"))^(( 0 )) ( f ) = cal(A)_(upright("SMBHB"))^(( * )) (f / f_(upright("yr")))^(2 / 3 ( 1 + delta )) thin , $<eq:SMBHBsignal>


with $cal(A)_(upright("SMBHB"))^(( * ))$ subject to large uncertainties~@Sesana:2004sp @Sesana:2012ak @Burke-Spolaor:2018bvk, $delta = 0$ for highly populated circular GW-driven SMBHBs~@Phinney:2001di, and $delta eq.not 0$ in other circumstances (which include more complex shapes beyond a power law), see~@NANOGrav:2023hfp and references therein.


#emph[ii) Inflation]. Canonically-normalized single-field slow-roll models -- #emph[Vanilla] scenarios --, predict a spectrum as


$ Omega_(upright("GW"))^(( 0 )) ( f ) = cal(A)_(upright("inf"))^(( * )) (f / f_(*))^(n_(upright(t))) thin , $<eq:infl_signal>


with a small amplitude $cal(A)_(upright("inf"))^(( * )) < 2.2 dot.op 10^(- 16)$ at cosmic microwave background (CMB) scales around $f_(*) tilde 5 dot.op 10^(- 17)$ Hz~@BICEP:2021xfz @Campeti:2022vom @Galloni:2022mok. While vanilla models admit only a tiny red-tilt $n_(upright(t)) lt.tilde - 0.0035$, more elaborate scenarios may develop a 'sizeable' blue tilt at small scales~@Bartolo:2016ami @Guzzetti:2016mkm @Caprini:2018mtu. We will use @eq:infl_signal as a simple parametrization for any such scenario.


#emph[iii) PhTs]. First order PhTs can generate a GWB via bubble collisions, sound waves, and turbulence~@Hindmarsh:2013xza @Hindmarsh:2015qta @Hindmarsh:2017gnf @Weir:2017wfa @Caprini:2019egz @Cutting:2018tjt @Cutting:2019zws @Pol:2019yex @Cutting:2020nla @Cai:2023guc. While the GWB from dark sectors can be peaked across a wide frequency range~@Schwaller:2015tja, magneto-hydrodynamic (MHD) turbulence at the QCD scale generates GWs exactly around the $tilde$#emph[nHz] window~@Neronov:2020qrl. Denoting $alpha$, $beta$, and $T_(*)$, the strength, (inverse) duration, and temperature of the PhT, respectively, the GWB today can be written as $Omega_(upright("GW"))^(( 0 )) = Omega_(upright("rad"))^(( 0 )) cal(G) ( T_(*) ) sum_i Omega_(upright("GW") , i)$, where $Omega_(upright("rad"))^(( 0 )) tilde.eq 9.2 dot.op 10^(- 5)$, $cal(G) ( T ) equiv ( g ( T ) / g_0 ) ( g_(s , 0) / g_s ( T ) )^(4 / 3)$ weights the number of degrees of freedom at temperature $T$, $i = upright(b)$ (bubbles), $i = upright("sw")$ (sound waves) and $i = upright("tb")$ (turbulence), and


$ Omega_(upright("GW") , i) ( f ) tilde.eq cal(N)_i thin Delta_i ( v_(upright(w)) ) (frac(kappa_i thin alpha, 1 + alpha))^(p_i) (H / beta)^(q_i) s_i ( f ) thin , $<eq:spectrumPhT>


with $cal(N)_i$ a normalization factor, $p_i , q_i$ fixed exponents, $Delta_i ( v_(upright(w)) )$ a function of the wall velocity $v_(upright(w))$, $kappa_i$ an efficiency factor, and $s_i ( f )$ a spectral shape function, see @tab:PhT.


#emph[iv) Audible Axions (AA)]. Production of a dark-$U ( 1 )$ gauge field~@Machado:2018nqk @Machado:2019xuc @Co:2021rhi @Fonseca:2019ypl @Chatrchyan:2020pzh @Ratzinger:2020oct @Eroncel:2022vjg @Madge:2021abk coupled via $frac(alpha, 4 f_a) phi.alt F_(mu nu) tilde(F)^(mu nu)$ to an oscillatory axion, can generate a large GWB~@Machado:2018nqk @Guo:2023hyp. The GWB peak frequency and amplitude depend on axion mass $m_a$ and its decay constant $f_a$, as


$ f_(*) tilde.eq 3.8 dot.op 10^(- 9) thin upright("Hz") ( alpha theta / 10 )^(2 / 3) ( m_a / 10^(- 12) thin upright("meV") )^(1 / 2) thin ,\
cal(A)_(*) tilde.eq 3.41 dot.op 10^(- 6) ( f_a / m_p )^4 theta^(8 / 3) ( 10 / alpha )^(4 / 3) , med med med $


with $alpha gt.tilde cal(O) ( 10 )$ and $theta tilde cal(O) ( 1 )$ the initial misalignment angle @Machado:2018nqk. The spectrum today can be fitted as~@Machado:2019xuc


$ Omega_(upright("GW"))^(( 0 )) ( f ) = frac(6.3 thin cal(A)_(*), [frac(f, 2 f_(*))]^(- 3 / 2) + exp [12.9 (frac(f, 2 f_(*)) - 1)]) . $
<eq:audible_axion_shape>


#emph[v) Cosmic Strings (CS)]. These are one-dimensional topological defects that may arise after a PhT in the early Universe~@Kibble:1976sj @Vilenkin:2000jqa, or in string theory scenarios~@Witten:1985fp @Dvali:2003zj @Copeland:2003bj. A network of CSs emits a GWB~@Vilenkin:1981bx @Hogan:1984is @Vachaspati:1984gt with spectrum today~@Blanco-Pillado:2017oxo @Blanco-Pillado:2017rnf @Auclair:2019wcv


$ Omega_(upright("GW"))^(( 0 )) ( f ) equiv frac(16 pi Gamma ( G mu )^2, 3 p H_0^2) 1 / f sum_(j = 1)^oo frac(cal(C)_j ( f ), j^(q - 1) zeta ( q )) thin thin ,\
cal(C)_j ( f ) = integral frac(d z', H ( z' ) ( 1 + z' )^6) thin n (frac(2 j, ( 1 + z' ) f) , t_e ( z' )) , $<eq:strings>


with $G mu$ the string tension (in Planck units), $G$ Newton's constant, $zeta ( q )$ the #emph[Riemann zeta] function, $p$ the #emph[intercommutation] probability, $H ( z )$ and $H_0$ the Hubble rate at #emph[redshift] $z$ and today, and $n ( l_e ( z ) , t_e ( z ) )$ the #emph[number density] of loops of size $l_e ( z )$ at time $t_e ( z )$. To evaluate the signal we consider #emph[Model I] of Ref.~@Auclair:2019wcv, with loop birth length $l = 0.1 / H$~@Blanco-Pillado:2013qja, $Gamma tilde.eq 50$ @Blanco-Pillado:2017oxo and $q = 4 / 3$ corresponding to cusps. We consider $p = 1$ for field theory strings and $10^(- 3) lt.eq p < 1$ for superstrings.


#emph[vi) Large Scalar Fluctuations]. The coupling at second order between curvature fluctuation $zeta$ modes leads to a GWB~@Matarrese:1997ay @Nakamura:2004rm @Ananda:2006af @Baumann:2007zm @Domenech:2021ztg. If $zeta$ is Gaussian, the spectrum today reads


$ Omega_(upright("GW"))^(( 0 )) ( f ) = frac(Omega_(upright("rad"))^(( 0 )) cal(G) ( eta_c ), 24) (frac(2 pi f, a ( eta_c ) H ( eta_c )))^2 overline(cal(P)_h^(upright("ind")) ( eta_c , 2 pi f ))\
overline(cal(P)_h^(upright("ind")) ( eta , k )) = 2 integral_0^oo d t integral_(- 1)^1 d s [frac(t ( 2 + t ) ( s^2 - 1 ), ( 1 - s + t ) ( 1 + s + t ))]^2\
times med overline(I^2 ( u , v , k , eta )) thin cal(P)_zeta^(upright("(") thin upright("G") thin upright(")")) ( k u ) thin cal(P)_zeta^(upright("(") thin upright("G") thin upright(")")) ( k v ) , $<eq:transfer>


with $eta$ conformal time, “c” indicating #emph[horizon crossing], and $cal(P)_zeta^(upright("(") thin upright("G") thin upright(")")) ( k )$ and $overline(cal(P)_h^(upright("ind")) ( eta , k ))$ the power spectra of the curvature perturbation and of the induced tensors, with $u = ( 1 + s + t ) / 2$ and $v = ( 1 - s + t ) / 2$, and $overline(I^2)$ given by Eq.~(27) of Ref.~@Kohri:2018awv. We consider two cases,


$ cal(P)_zeta^(upright("(") thin upright("G") thin upright(")")) ( k ) = {cal(A)_(l n) / sqrt(2 pi sigma_(cal(R))^2) e^(- frac(( ln k / k_(*) )^2, 2 sigma_(cal(R))^2)) & med upright("(") thin upright("Bump") thin upright(")")\
cal(A)_(s i) Theta ( k - k_s ) Theta ( k_l - k ) & med upright("(") thin upright("Flat") thin upright(")") , $<eq:gaussian_scalar>


representing a single peak (#emph[Bump])~@Pi:2020otn @Vaskonen:2020lbd @Kohri:2020qqd, and a scale-invariant spectrum (#emph[Flat]) within the range $k_s lt.eq k lt.eq k_l$, $k_s lt.double k_l$~@DeLuca:2020ioi @DeLuca:2020agl. For broader generality, we also consider a curvature perturbation with #emph[primordial non-Gaussianity] (pNG) as $zeta ( upright(bold(x)) ) = zeta_(upright(G)) ( upright(bold(x)) ) + f_(mono(n l)) ( zeta_(upright(G))^2 ( upright(bold(x)) ) - chevron.l zeta_(upright(G))^2 ( upright(bold(x)) ) chevron.r )$, with $zeta_(upright(G))$ Gaussian~@Cai:2018dig @Unal:2018yaa. In this case, the GWB spectrum is given by Eqs.~(2.33)-(2.39) from Ref.~@Adshead:2021hnm.


// [figvision] imgs/sumplot1.png
// Panel (A) is a line plot showing two probability distribution functions on the y-axis against an x-axis
// labeled 'x' ranging from -10.5 to -8.5. A solid dark red curve, labeled 'Cosmic strings', peaks sharply at
// approximately x = -10.0. A dashed red curve, labeled 'SMBHBs', peaks sharply at approximately x = -8.4. The
// legend identifies the solid line as x equals log base 10 of G mu and the dashed line as x equals log base 10
// of A SMBHB. Panel (B) displays a contour plot with the x-axis labeled log base 10 of h squared Omega GW zero
// ranging from -9 to -6, and the y-axis labeled n sub T ranging from -1 to 3. Three nested ellipses represent
// confidence regions: grey for EPTA, cyan for NANOGrav, and orange for their combination, all tilted diagonally
// upwards. An orange text label reads 'Power law'. Two horizontal error bars are shown near y equals 0.6: a
// black dot for Flat n sub T equals 0 and a red bar for SMBHBs n sub T equals 2/3. Panel (C) is a contour plot
// featuring a single diagonal band of concentric green regions. The x-axis is labeled log base 10 of m sub a
// over meV, spanning -11 to -9. The y-axis is labeled log base 10 of f sub a over m sub P, spanning -0.5 to 0.0.
// The contours run from bottom-left to top-right. Green text in the upper left corner reads 'Audible axion'.
// [figvision] imgs/sumplot2.png
// Panel (D) is a two-dimensional contour plot titled "Superstrings" in purple text. The horizontal axis
// represents log10(Gμ) ranging from -12.0 to -11.0, and the vertical axis represents log10(P) from -3.0 to -1.0.
// Two nested confidence regions are shown: an inner dark purple region and an outer light purple region. Both
// contours are elongated diagonally from the bottom-left to the top-right, indicating a positive correlation
// where higher Gμ values correspond to higher P values. Panel (E) displays a corner plot for the "gSIGWB (bump)"
// model using blue shaded contours. It shows three subplots with axes labeled log10(A_R), log10(f*/nHz), and
// log10(σ_R). The diagonal plots show marginalized distributions, while off-diagonal plots show correlations.
// Specifically, the top-left plot shows a strong positive correlation between A_R and f*. The bottom row shows
// negative correlations between σ_R and both A_R and f*, indicated by downward-sloping elliptical shapes. Panel
// (F) presents a similar corner plot structure for the "ngSIGWB (bump)" model, distinguished by deep purple
// shading. The axes correspond to log10(A_R), log10(f*/nHz), log10(σ_R), and log10|f_NL|. Unlike Panel E, this
// panel includes an additional parameter, |f_NL|. The contours indicate that σ_R is strongly constrained near
// zero, while A_R and f* show a positive correlation. The relationship between |f_NL| and other parameters
// appears relatively flat or unconstrained compared to the tight constraints on σ_R.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering). #it.body]
}

#figure(scope: "parent", [#box(image("imgs/sumplot1.png", width: 91.5%))
  #box(image("imgs/sumplot2.png", width: 97.5%))],
  caption: [
    #emph[\(A)] 1D posteriors of field theory CSs and SMBHBs with $n_t = 2 / 3$, #emph[\(B)] 2D posterior for a PL signal (black and gray lines indicate the error band for $n_t = 0$ and $2 / 3$, respectively) #emph[\(C)] 2D posterior for AA, #emph[\(D)] 2D posterior for superstrings, #emph[\(E)] and #emph[\(F)] 2D posteriors for Gaussian and non-Gaussian SIGWB bump, respectively.
  ]
)
<fig:Constraints>



#strong[Analysis.--] For simplicity, and similarly to~@InternationalPulsarTimingArray:2023mzf, we consider the data sets `NG15` and `EPTA-DR2new` as independent, though we acknowledge the impact of overlapping pulsars on our findings. We extract physical information from free spectra chains, using Bayesian inference techniques, assuming each frequency point $f_i$ is independent, see #emph[supplementary material]. In the following, we derive parameter constraints for scenarios $i ) - v i )$.


#underline[#emph[Power Law (PL)]]. The spectrum from canonical SMBHBs, inflation, and large scalar fluctuations with #emph[flat spectrum] (scenarios $( i )$, $( i i )$ and $( v i )$, respectively) correspond to $Omega_(upright("GW"))^(( 0 )) = cal(A)_(*) ( f / f_(upright("yr")) )^(n_(upright(t)))$, with free amplitude $cal(A)_(*)$ at $f = f_(upright("yr"))$ and tilt $n_t = 2 / 3$, free and $0$, respectively. Fitting simultaneously $( cal(A)_(*) , n_t )$ we obtain $cal(A)_(*) = 4.25_(- 1.92)^(+ 3.05) dot.op 10^(- 8)$ and $n_t = 2.08_(- 0.30)^(+ 0.32)$, at 68% CL. Fitting $cal(A)_(*)$ while fixing $n_t = 2 / 3$ or $n_t = 0$, leads to $cal(A)_(*) |_(2 / 3) = 4.28_(- 0.97)^(+ 0.99) dot.op 10^(- 9)$ and $cal(A)_(*) |_0 = 1.03_(- 0.26)^(+ 0.39) dot.op 10^(- 9)$, at 68% CL. #ref(<fig:Constraints>)-(A) shows the probability distribution function of $cal(A)_(upright("SMBHB"))$ (for $n_t = 2 / 3$). #ref(<fig:Constraints>)-(B) shows the 1-$sigma$ and 2-$sigma$ contours of the full parameter space.


#underline[#emph[Broken Power Law (BPL)]]. PhT from scenario $( i i i )$ correspond to a BPL with $Omega_(upright("GW"))^(( 0 )) ( f ) prop f^(n_1)$ and $Omega_(upright("GW"))^(( 0 )) ( f ) prop f^(n_2)$ at low- ($f lt.double f_(*)$) and high-frequencies ($f gt.double f_(*)$), respectively. For each PhT contribution, the tilts $( n_1 , n_2 )$ are fixed. The peak's frequency $f_(*)$ and amplitude $cal(A)_(*) equiv h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) )$ are set uniquely by $alpha$, $beta$ and $T_(*)$. As the data constrains directly $( f_(*) , cal(A)_(*) )$, we have a clear handle on these fundamental parameters, see #emph[supplemental material]. We obtain, at 68% CL, $T_(*) in [ 6.2 dot.op 10^(- 3) , 9.0 ]$ GeV and $beta / H_(*) in [ 2.2 , 500 ]$ for bubble collisions (with $alpha gt.double 1$), $T_(*) in [ 5.5 , 360 ]$ MeV and $beta / H_(*) in [ 1.0 , 15 ]$ for a signal from sound-waves + turbulence (with $alpha in [ 0.017 , 0.060 ]$), and $T_(*) in [ 10^(- 3) , 3.2 ]$ GeV for MHD turbulence.


#underline[#emph[Power Law with Cutoff (PLc)]]. The AA spectrum of scenario #emph[\(iv)] scales as $prop f^(3 / 2)$ till it dies off exponentially at higher frequencies $f > f_(*)$. Fitting the cutoff frequency and peak amplitude $( f_(*) , cal(A)_(*) )$ from @eq:audible_axion_shape, leads to lower bounds on the axion mass and decay constant at 68% CL, as $m_a gt.tilde 8.0 dot.op 10^(- 11)$ meV and $f_a gt.tilde 1.3 dot.op 10^18$ GeV, see #ref(<fig:Constraints>)-(C).


#underline[#emph[Cosmic Strings (CS)]]. The broad spectrum in the CS scenario $( v )$, #emph[cf.]~@eq:strings, may exhibit a different frequency dependence than a PL in the PTA window. For field theory strings we find $log_10 ( G mu ) = - 9.90_(- 0.19)^(+ 0.11)$, at 68% CL, see #ref(<fig:Constraints>)-(A). For superstrings instead, we find $log_10 ( G mu ) = - 11.83_(- 0.15)^(+ 0.27)$ and $log_10 p = - 2.63_(- 0.31)^(+ 0.49)$, at 68% CL, see #ref(<fig:Constraints>)-(D).


// [figvision] imgs/all_recs_m.png
// Panel a, titled SMBHBs, is a log-log plot showing the gravitational wave energy density parameter h-squared
// Omega-GW on the y-axis ranging from 10 to the power of negative twelve to 10 to the power of negative six. The
// x-axis represents frequency f in Hertz, spanning roughly 10 to the power of negative ten to 10 to the power of
// negative seven. A solid red line indicates the central value for supermassive black hole binaries, rising
// slightly from approximately 2 times 10 to the power of negative ten at low frequencies to 6 times 10 to the
// power of negative nine at high frequencies. Surrounding this line are shaded regions representing confidence
// intervals: a darker red band for the 68% interval and a lighter red band for the 95% interval. Vertical gray
// bars represent data points with error bars from EPTA (dark gray) and NANOGrav (light gray), scattered across
// the frequency range. Panel b, labeled Power law, displays a similar log-log plot structure. The y-axis spans
// 10 to the power of negative twelve to 10 to the power of negative six for h-squared Omega-GW, while the x-axis
// covers frequencies from about 10 to the power of negative ten to 10 to the power of negative seven Hertz. An
// orange solid line depicts the central value of a power-law model, increasing steadily from around 10 to the
// power of negative ten to nearly 10 to the power of negative eight as frequency increases. Lighter and darker
// orange shading denotes the 95% and 68% confidence levels respectively. Gray vertical lines again show
// observational constraints from EPTA and NANOGrav datasets, distributed throughout the frequency domain. Panel
// c, Cosmic strings, presents another log-log graph with identical axis scales: h-squared Omega-GW from 10^-12
// to 10^-6 versus frequency f [Hz] from ~10^-10 to ~10^-7 Hz. A flat orange solid line runs horizontally near 3
// times 10 to the power of negative ten, indicating constant energy density across frequencies for cosmic string
// models. Shaded bands in light and dark orange enclose the 95% and 68% confidence intervals around this
// plateau. Observational data from EPTA and NANOGrav appear as vertical gray error bars, mostly consistent with
// or below the predicted signal level across all plotted frequencies. Panel d, Superstrings, uses the same
// coordinate system: logarithmic y-axis for h-squared Omega-GW between 10^-12 and 10^-6, and x-axis for
// frequency f [Hz] from approximately 10^-10 to 10^-7 Hz. A magenta solid line rises gently from about 2 times
// 10 to the power of negative ten at low frequencies to 8 times 10 to the power of negative nine at higher ones,
// reflecting the superstring prediction. Magenta-shaded regions indicate 68% (darker) and 95% (lighter)
// confidence intervals. Vertical gray bars representing EPTA and NANOGrav measurements are overlaid, generally
// lying within or just outside the upper bounds of the theoretical uncertainty bands. Panel e, gSIGWB (flat),
// shows a horizontal yellow solid line centered near 4 times 10 to the power of negative ten across the entire
// frequency range from ~10^-10 to ~10^-7 Hz on the x-axis, with y-axis scaled identically to previous panels.
// This represents a flat stochastic background model. Yellow shading defines the 68% and 95% confidence
// intervals flanking the central line. Gray vertical error bars from EPTA and NANOGrav observations are plotted,
// many overlapping with the predicted region, suggesting compatibility with current experimental limits despite
// some scatter at higher frequencies. Panel f, gSIGWB (bump), features a cyan solid line that ascends linearly
// on the log-log scale from roughly 10 to the power of negative ten at 10^-10 Hz to about 2 times 10 to the
// power of negative eight at 10^-7 Hz, modeling a bump-shaped spectrum. Cyan-colored shaded areas denote 68% and
// 95% confidence intervals widening toward higher frequencies. Vertical gray bars from EPTA and NANOGrav data
// lie predominantly beneath or intersecting the lower edge of the 95% band, implying potential tension with
// observed upper limits unless systematic uncertainties are large enough to reconcile them. Panel g, Audible
// axions, plots a green solid line rising gradually from approximately 1.5 times 10 to the power of negative ten
// at 10^-10 Hz to 1.5 times 10 to the power of negative eight at 10^-7 Hz, corresponding to audible axion
// predictions. Green-shaded regions mark 68% and 95% confidence intervals expanding slightly with frequency.
// Overlaid gray vertical error bars from EPTA and NANOGrav fall largely within or marginally above the 95% band,
// particularly at intermediate frequencies, indicating partial consistency but possible mild exclusion depending
// on analysis assumptions. Panel h, PhT Runaway in vacuum, exhibits a blue solid line climbing steeply from
// about 8 times 10 to the power of negative eleven at 10^-10 Hz to 3 times 10 to the power of negative eight at
// 10^-7 Hz, representing phase transition runaway scenarios in vacuum. Blue-shaded zones define 68% and 95%
#pagebreak()
// [figvision-cn] imgs/all_recs_m.png
// 这是一张由八个子图组成的 4 行 2 列科学论文插图。所有子
// 图均为双对数坐标系下的曲线图，横轴表示频率 f [Hz]，范
// 围约为 10^-9 至 10^-7 Hz；纵轴表示随机引力波背景的今日
// 能量密度 h^2 Ω_GW^(0)，范围从 10^-12 到 10^-6。每个子
// 图中，深灰色和浅灰色的“小提琴”状图形分别代表 EPTA 和
// NANOGrav 的自由谱数据，其垂直分布表示不同频率 bin 下的
// 后验概率密度。各子图中的实线表示中心值，半透明阴影区域
// 表示置信区间，最浅色为 95% 置信水平，中间色为 68% 置信
// 水平。 子图 a（第一行左）：标题为“SMBHs”。中心趋势线为
// 红色实线。曲线在横轴范围为 10^-9 至 10^-7 Hz 内呈缓慢
// 上升趋势，从 10^-9 Hz 处的约 10^-9 上升至 10^-7 Hz 处
// 的约 10^-8。68% 和 95% 置信区间阴影随频率增加而显著变
// 宽，尤其在 10^-8 Hz 以上区域。 子图 b（第一行右）：标
// 题为“Power law”。中心趋势线为橙色实线。曲线呈明显的幂
// 律上升趋势，从 10^-9 Hz 处的约 10^-10 上升至 10^-7 Hz
// 处的接近 10^-7，斜率大于子图 a。置信区间阴影较窄，主要
// 集中在中心线附近。 子图 c（第二行左）：标题为“Cosmic
// strings”。中心趋势线为深红色实线。曲线在 10^-9 至 10^
// -7 Hz 范围内几乎水平，维持在 10^-9 左右。置信区间阴影
// 较窄。 子图 d（第二行右）：标题为“Superstrings”。中心
// 趋势线为洋红色实线。曲线呈明显上升趋势，从 10^-9 Hz 处
// 的约 10^-10 上升至 10^-7 Hz 处的约 10^-7。置信区间阴影
// 较窄。 子图 e（第三行左）：标题为“gSIGWB (flat)”。中心
// 趋势线为黄色实线。曲线在整个频率范围内呈完全水平直线，
// 位于 10^-9 附近。置信区间阴影较窄。 子图 f（第三行右）：
// 标题为“gSIGWB (bump)”。中心趋势线为浅蓝色实线。曲线呈
// 上升趋势，从 10^-9 Hz 处的约 10^-10 上升至 10^-7 Hz 处
// 的约 10^-7。置信区间阴影较窄。 子图 g（第四行左）：标
// 题为“Audible axions”。中心趋势线为绿色实线。曲线呈上升
// 趋势，从 10^-9 Hz 处的约 10^-10 上升至 10^-7 Hz 处的接
// 近 10^-7。置信区间阴影在低频端较窄，高频端变宽。 子图
// h（第四行右）：标题为“PhT Runaway in vacuum”。中心趋势
// 线为深蓝色实线。曲线呈最陡峭的上升趋势，从 10^-9 Hz 处
// 的约 10^-10 上升至 10^-7 Hz 处的约 10^-6。置信区间阴影
// 较窄。 整体趋势：所有模型均被绘制在同一组 EPTA 和
// NANOGrav 数据背景下。不同模型在低频端（10^-9 Hz）的预
// 测值差异较大，从 10^-10 到 10^-9 不等；而在高频端（10^
// -7 Hz），除“Cosmic strings”和“gSIGWB (flat)”模型外，其
// 余模型均呈现上升趋势，且部分模型（如 Power law 和 PhT
// Runaway）的上升斜率更陡。灰色小提琴图显示数据在 10^-8
// Hz 附近有较强的约束力。
#figure(placement: top, image("imgs/all_recs_m.png", width: 100%),
  caption: [
    $h^2 Omega_(upright("GW"))^(( 0 )) ( f )$ for various cases. Solid-colored lines represent central values, while lighter (lightest) regions the 68% (95%) CL intervals. Dark and light gray violins are the EPTA and NANOGrav free spectrum data, respectively.
  ]
)
<fig:spectra_all>



#underline[#emph[Scalar Induced GWB (SIGWB)]]. #ref(<fig:Constraints>)-(E) shows the 1-$sigma$ and 2-$sigma$ contours, and @fig:spectra_all the reconstructed spectrum for the best-fit parameters, with 1-$sigma$ and 2-$sigma$ error bands for a Gaussian bump in scenario $( v i )$. The peak frequency is constrained to be $f_(*) in [ 0.07 , 1.44 ] med mu upright("Hz")$, corresponding to a scale $k_(*) in [ 4.57 , 88 ] dot.op 10^7$ Mpc$"rm" ^(-1)$, at 68% CL. The amplitude $A_(cal(R))$ is quite large, though this depends on the value of $sigma_(cal(R))$. We obtain $A_(cal(R)) in [ 0.10 , 2.82 ]$ with $sigma_(cal(R)) in [ 0.11 , 0.82 ]$ at 68% CL.


Concerning SIGWBs with pNG, we have considered a Gaussian component with bump spectrum, considering the non-linear relation between the smoothed density contrast and the linear curvature perturbation, extended to pNG~@Young:2022phe. The parameter space is ${ sigma_(cal(R))$, $f_(*)$, $A_(cal(R)) , f_(mono(n l)) }$, subject to the perturbativity condition $A_(cal(R)) f_(mono(n l))^2 < 1$~@Adshead:2021hnm. The data impose $| f_(mono(n l)) | lt.tilde 2.34$ at 95% CL, see #ref(<fig:Constraints>)-(F).


#strong[Implications and model comparison.--] We have fit PTA data to several GWB spectra. For PL inflationary signal, we can connect $A_(*)$ and $n_t$ at PTA scales to the tensor-to-scalar ratio $r$ at CMB scales, see #emph[supplemental material]. Inputting our best-fit region $( cal(A)_(*) , n_t )$ into @eq:GWB_inflation_in_f leads to $r_0.05 in [ 4.37 dot.op 10^(- 14) , 3.47 dot.op 10^(- 9) ]$ at 68% CL (at the scale $k_(*) = 0.05 med upright("Mpc")^(-1)$), well below current CMB constraints $r_0.05 < 0.032$~@Tristram:2021tvh. Furthermore, a low-reheating temperature $T_(upright("reh")) lt.tilde 10.6$ GeV at 68% CL must be necessarily imposed to respect extra radiation $Delta N_(upright("eff"))$ constraints @Allen:1997ad @Smith:2006nka @Boyle:2007zx @Kuroyanagi:2014nba @Caprini:2018mtu @Ben-Dayan:2019gll, #emph[cf.]~@eq:infl_bound_Treh. While an inflationary signal strongly violating the consistency relation $n_t = - r / 8$, with a blue tilt as large as required by PTA data, $n_t tilde.eq 2$, is not impossible to conceive, adding on top the requisite of a low reheating temperature, makes extremely challenging to construct a viable model. Thus, an inflationary explanation of the PTA signal looks rather implausible.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 5,
    align: (right,center,center,center,center,),
    table.vline(x: 1, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([Template], [$upright("BF")_(upright("NANO"))$], [$upright("BF")_(upright("EPTA"))$], [$upright("BF")_(upright("comb"))$], [$Delta upright("AIC")_(upright("comb"))$],),
    table.hline(),
    [#strong[P]L($n_t = 0$)], [0.02], [0.62], [0.0014], [10.24],
    [#strong[P]L($n_t = 2 / 3$)], [2.6], [3.1], [1.9], [-5.20],
    [#strong[P]L($n_t , cal(A)_(*)$)], [16], [4.1], [180], [-12.25],
    [#strong[field th.~CS]], [0.18], [1.3], [0.019], [5.22],
    [#strong[super CS]], [29], [3.3], [58], [-11.11],
    [#strong[gSIGWB]], [120], [15], [1300], [-13.54],
    [#strong[ngSIGWB]], [66], [8.7], [780], [-6.82],
    [#strong[AA]], [36], [2.7], [130], [-12.36],
    [#strong[BPL]], [17], [1.6], [120], [-0.19],
    [#strong[PhTNR]], [8.5], [8.1], [150], [-12.85],
    [#strong[PhTRV]], [37], [13], [110], [-12.34],
    [#strong[MHD]], [26], [3.9], [210], [-8.77],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Bayes factors $( upright("BF") )$ for NANOGrav, EPTA, and combined data sets, and Akaike Information Criterion $( upright("AIC") )$ for the combined data sets. ]
  , kind: table
  )
<tab:aic>



Two interesting cases emerge when fitting the data with a PL spectrum with fixed tilt $n_t$: a signal from SMBHBs with $n_(upright(t)) = 2 / 3$~@Phinney:2001di, and a SIGWB from large Gaussian scalar fluctuations with #emph[flat spectrum], which leads to a flat spectrum in $Omega_(upright("GW"))^(( 0 ))$ with $n_t = 0$~@DeLuca:2020ioi @DeLuca:2020agl. We obtain that $n_t = 0$ and $n_t = 2 / 3$ are ruled out by the combined data sets at $5.4 sigma$ and $3.9 sigma$, respectively, see #ref(<fig:Constraints>)-(B). Hence, neither of these two scenarios is preferred by the PTA data.


We have also fit the data with a PLc spectrum $prop f^(3 / 2)$ with a cutoff scale $f_(*)$, #emph[cf.] @eq:audible_axion_shape. This corresponds to an audible axion~@Machado:2018nqk @Machado:2019xuc @Co:2021rhi @Fonseca:2019ypl @Chatrchyan:2020pzh @Eroncel:2022vjg @Madge:2021abk. Given the lower bounds on the mass and decay constant of the axion, see #ref(<fig:Constraints>)-(C), imposing a sub-Planckian $f_a lt.eq m_p$ motivated by string theory~@Banks:2003sx, turns PTA data into a very tight constraint as $m_a = 0.32_(- 0.24)^(+ 1.48)$ peV. As pointed out by~@Geller:2023shn, but contrary to previous NANOGrav 12.5-year data analysis~@Madge:2023cak, the preferred parameter region is in tension with axion over-production and $Delta N_(upright("eff"))$ constraints.


Fitting the PTA signal also admits a BPL spectrum, which can be interpreted as a GWB originated in a first-order PhT. In this case, the low- and high-frequency PL tails $( f^(n_1) , f^(n_2) )$ of the spectrum depend on the dominating contribution, with ${ f^2.8$, $f^(- 1) }$ for bubbles in a strong PhT, and ${ f^3$, $f^(- 4) }$ for sound waves plus a subdominant turbulence with ${ f^2$, $f^(- 5 / 3) }$ in a weak PhT. We obtain a central temperature as $T_(*) tilde.eq 20$ MeV ($tilde.eq 94$ MeV) for a strong (weak) PhT, suggesting a first-order PhT at the MeV scale which would be in tension with lattice QCD~@Aoki:2006we and BBN prediction~@Bringmann:2023opz. In the case of magneto-hydrodynamic (MHD) turbulence, the best-fit peak position can be translated~@Neronov:2020qrl into a primordial magnetic field of strength $B_0 tilde.eq 23.3 mu$G and correlation length $l_B tilde.eq 0.25 med upright("pc")$, which is close to current constraints on primordial magnetic fields~@Planck:2015zrl @Jedamzik:2018itu @Neronov:2021xua @MAGIC:2022piy.


Fitting the PTA signal with field theory CSs leads to a very tight constraint of the associated energy scale as $sqrt(mu) tilde.eq 1.32_(- 0.24)^(+ 0.20) dot.op 10^14 med upright("GeV")$. While this is $cal(O) ( 10^(- 2) )$ smaller than standard Grand Unification scales $tilde 10^16 med upright("GeV")$, a wide variety of particle-physics models can still accommodate this value~@Vilenkin:2000jqa, see #emph[e.g.],~@Kofman:1995fi @Buchmuller:2012wn @Buchmuller:2013lra @Long:2019lwl. Besides, the GWB spectrum should be also detectable by higher frequency future experiments, enabling us to learn about the cosmological history and particle physics above the BBN $tilde$MeV scale~@Cui:2017ufi @Cui:2018rwi @Gouttenoire:2019kij @Gouttenoire:2019rtn @Gouttenoire:2021wzu @Gouttenoire:2021jhk @Auclair:2019jip @Auclair:2021jud @Kitajima:2022lre @Ghoshal:2023sfa. As discussed later, the GWB from field theory CS does not fit well the PTA data. A cosmic superstring network, on the other hand, can fit very well the PTA data, thanks to accommodating a smaller energy scale $sqrt(mu) tilde.eq 1.56_(- 0.39)^(+ 0.48) dot.op 10^13 med upright("GeV")$, while suppressing the intercommutation probability to $p = [ 1.13 , 7.06 ] dot.op 10^(- 3)$.


Finally, we have fit PTA data with SIGWBs choosing $sigma_(cal(R)) < 3$ as required by CMB constraints @Inomata:2018epa. The data indicate that a GWB created by a Gaussian curvature perturbation with a bump spectrum (gSIGWB-bump) requires a peak frequency $f_(*) in [ 0.07 , 1.44 ] med mu upright("Hz")$ at 68% CL. We compute the primordial black hole (PBH) abundance considering the non-linear relation between curvature and matter perturbations~@Young:2019yug, and find a PBH distribution peaked around masses $M_H / M_⊙ in [ 1.5 dot.op 10^(- 5) , 5.6 dot.op 10^(- 3) ]$, see #emph[supplemental material]. @fig:SIGW_constraint shows how the region of PTA best-fit is cut by the PBH over-abundance criterion, as well as by gravitational lensing, and LIGO/VIRGO bounds~@Green:2020jor @bradley_j_kavanagh_2019_3538999. As the observational constraints are stronger than the over-abundance bound, our analysis implies that the PTA signal cannot correspond to an interpretation of PBH as the dark-matter totality. In any case, the best-fit PTA region can only survive for $sigma_(cal(R)) > 1$. Future PBH searches could clarify whether the SIGWB could explain the origin of the PTA signal. We have also applied an analogous analysis for the case of a large curvature fluctuation with local pNG and Gaussian component with a bump spectrum (ngSIGWB-bump), see #ref(<fig:Constraints>)-(F). Assuming perturbativity as $A_(cal(R)) f_(mono(n l))^2 < 1$, PTA data provides a stringent constrain on the pNG parameter as $| f_(mono(n l)) | lt.tilde 2.34$ at 95% CL. This is a remarkable constraint on pNG at PTA scales, which we highlight are $tilde 8$ orders of magnitude smaller than CMB scales~@Planck:2019kim. Our bound is conservative compared to bounds from PBH abundance, which depend strongly on the PBH formation and evolution details.


To determine the most favored models we have performed a model selection/comparison Bayesian analysis. We employed two different criteria: the Bayes Factor (BF) $B_i = upright("evidence") [ cal(H)_i ] / upright("evidence") [ cal(H)_(S M B H B) ]$ (where $cal(H)_i$ represents each model $i$ and SMBHB a reference model based on the 2D Gaussian prior from~@NANOGrav:2023hvm) and the Akaike Information Criterion given by $upright("AIC") equiv - 2 ln cal(L) + 2 k$ (where $k$ is the number of parameters of the template) and compared to SMBHB from~@NANOGrav:2023hvm. We report the values for all models analyzed in @tab:aic. We obtain that both for NANOGrav and EPTA, gSIGWB-bump shows the largest BFs, $upright("BF")_(upright("NANO")) = 120$ and $upright("BF")_(upright("EPTA")) = 15$, followed up closely by ngSIGWB-bump, with $upright("BF")_(upright("NANO")) = 66$ and $upright("BF")_(upright("EPTA")) = 8.7$. Additionally, the BF and $Delta$AIC of the combined data indicate a very good fit for both gSIGWB and ngSIGWB signals. There is also "substantial" evidence for the AA and cosmic superstring models, both with $upright("BF")_(upright("NANO")) tilde 30$ and $upright("BF")_(upright("EPTA")) tilde 3$. While the superstring signal fits the data well, as pointed out in~@NANOGrav:2023hvm @Antoniadis:2023xlr, the AA cannot explain the combined data because of its own relic constraints. We also remark that, as already found in~@NANOGrav:2023hvm, a simple PL with $n_t = 2 / 3$ exhibits small BFs of order $tilde 2 - 3$ (also for the combined data set), indicating a poor/low quality fit. The remaining models examined in this paper show lower BF and AIC values, suggesting a reduced ability to fit the new data.


From our analysis, we can conclude that some cosmological models fit the data better than SMBHBs (assuming the simplest model for the latter, see below). Among these, the gSIGWB+bump provides the best fit, with very strong evidence in NANOGrav data and strong in EPTA data, compared to SMBHBs. Decisive evidence shows up when the data sets are combined, with BF$""_(upright("comb")) tilde.eq 1300$, though this number should not be taken too literally, given the caveats of our analysis (#emph[e.g.] overlapping pulsars). Similarly, SIGWB with pNG also fits quite well the data, with BF$""_(upright("comb")) tilde.eq 780$, and most importantly, leading to a stringent bound at the PTA scales as $| f_(mono(n l)) | lt.tilde 2.34$ at 95% CL. Concerning other cosmological models, we observe that, in agreement with Refs.~@NANOGrav:2023hvm @Antoniadis:2023xlr, field theory strings do not fit well the data, whereas superstrings exhibit a good fit (though not as good as SIGWB signals). However, as the superstring signal scaling $prop 1 / p$ is not well established, we advise taking this case with care. If eccentricity, environmental, or population effects are considered, the GWB spectrum is no longer a simple power law, and it might become similar to a broken power law, leading to an improvement of the SMBHBs fit~@NANOGrav:2023hfp @Antoniadis:2023xlr @Ellis:2023dgf, although such modifications are model dependent and currently under discussion. Therefore, no clear conclusion about the origin of the signal can be reached at this point. While the detection of a GWB by PTA collaborations~@NANOGrav:2023gor @Antoniadis:2023ott @Reardon:2023gzh @Xu:2023wog has opened an exciting window for astrophysics, early universe cosmology, and BSM physics, further data and analysis are still needed to reach robust conclusions.


#emph[Note added]: Taken individually, some of our results overlap with the new physics searches by NANOGrav and EPTA collaborations~@NANOGrav:2023hvm @Antoniadis:2023xlr, as well as with recent studies~@Franciolini:2023pbf @Ellis:2023tsl @Franciolini:2023wjm @Vagnozzi:2023lwo @Cai:2023dls. There are however some differences. For example, ours is a NANOGrav and EPTA combined data Bayesian analysis, which improves some of the model constraints. Furthermore, we have considered a smoothing procedure of the GWB spectra per bin. Model-wise, we have extended the search to audible axions and SIGWBs with pNG. The day before we submitted our work, two studies appeared in the ArXiv considering PTA constraints on local pNG~@Liu:2023ymk @Wang:2023ost, both presenting similar constraints on $f_(mono(n l))$.


#emph[Acknowledgements --] We thank Stas Babak, Matthias Koschnitzke, Andrea Mitridate, Gabriele Perna, Hippolyte Quelquejay Leclere, Kai Schmitz, Géraldine Servant, and Zach Weiner for useful discussions. DGF (ORCID 0000-0002-4005-8915) is supported by a Ramón y Cajal contract with Ref.~RYC-2017-23493. This work was supported by Generalitat Valenciana grant PROMETEO/2021/083, and by Spanish Ministerio de Ciencia e Innovacion grant PID2020-113644GB-I00. AR acknowledges financial support from the Supporting TAlent in ReSearch\@University of Padova (STARS\@UNIPD) for the project “Constraining Cosmology and Astrophysics with Gravitational Waves, Cosmic Microwave Background and Large-Scale Structure cross-correlations”.














#bibliography("refs.bib", title: [References])

#pagebreak()
#set page(columns: 1, numbering: (..n) => "S" + str(n.pos().at(0)))
#counter(page).update(1)
#show heading.where(level: 1): set heading(numbering: (..n) => "S" + str(n.pos().at(0)))
#counter(heading).update(0)
#align(center)[#text(14pt, weight: "bold")[Supplemental Material]]


This supplemental material contains more details on the data analysis used in the main text. The translation from the GWB templates' parameters into the particle physics and cosmological parameters is also provided. As examples, we link the power-law and broken power-law templates to the GWB from primordial inflation and first-order PhT, respectively. Lastly, we discuss briefly the primordial black hole and the scalar-perturbation power-spectrum constraints relating to the scalar-induced GWB interpretation.


#strong[Assumptions.--] In all our computations, we have assumed standard $Lambda$CDM cosmology for the cosmic history, with $Omega_(upright("rad"))^(( 0 )) tilde.eq 9.2 dot.op 10^(- 5)$, $h tilde.eq 0.68$, and the evolution of the relativistic degrees of freedom $g_(*) ( T )$ and $g_(* , s) ( T )$ obtained from App.C of @Saikawa:2018rcs. The (reduced) Planck mass is $m_p equiv ( 8 pi G )^(- 1 / 2) tilde.eq 2.44 dot.op 10^18$ GeV.


#strong[Input Data.--] The effect of GWB is characterized, in the PTA time-of-arrival data, as the time-correlated stochastic process, parametrized by the one-sided power spectral density $S ( f_i = i / T_(upright("obs")) )$ for each frequency bin that is a harmonic $i^(upright("th"))$ of the inverse of observational time $T_(upright("obs"))^(- 1)$ @NANOGrav:2023hvm. This turns into the power spectrum of the fraction energy density in GW today as @Allen:1997ad,


$ Omega_(upright("GW"))^(( 0 )) ( f ) = frac(8 pi^4 f_(upright("yr"))^5, H_0^2) S ( f ) (f / f_(upright("yr")))^5 , $


In the case in which the signal PSD can be parametrized with a power law like, we have


$ S ( f ) = frac(A_(upright("CP"))^2, 12 pi^2) (f / f_(upright("yr")))^(- gamma) f_(upright("yr"))^(- 3) med med med med med arrow.l.r.double med med med med Omega_(upright("GW"))^(( 0 )) ( f ) = frac(2 pi^2 f_(upright("yr"))^2, 3 H_0^2) A_(upright("CP"))^2 (f div f_(upright("yr")))^(5 - gamma) thin . $


The “violins” in the plots represent the free spectrum marginalized probability distribution function (PDF) of the amplitude of the sine-cosine Fourier pair (i.e., $sqrt(S ( f ) / T)$ in seconds) for all frequencies $f_i$'s.


= MORE DETAILS ON DATA ANALYSIS
<more-details-on-data-analysis>
This section provides a more detailed explanation of the data analysis technique employed in this work. For what concerns the likelihood definition, we proceed as follows. We start by performing a Gaussian kernel smoothing of the histograms built from the free spectrum chains. The result of this procedure is used to estimate probability distribution functions (PDFs) for signal amplitude in the frequency bins $f_k$, which are thus assumed to be independent from one another. In particular, under these assumptions, the full log-likelihood is represented as


$ ln cal(L) = sum_k ln p_k ( cal(D)_k | arrow(theta) , ) #h(0em) , $<eq:log_likelihood>


where $arrow(theta)$ is the parameter vector of the models, and $cal(D)_k$ and $p_k$ are the data chains and likelihoods respectively. Some signals, such as the scalar-induced GWB, exhibit variations on frequency scales that are (much) smaller than the experiment resolution $Delta f = 1 / T_(upright("tot"))$ (with $T_(upright("tot"))$ as the total observation time). Since detection is based on integrated power within frequency bins of width $Delta f$, the data cannot capture these variations. To account for this, we smooth the templates by averaging over bins of size $Delta f$. The log-posterior is defined as the sum of the log-likelihood in~@eq:log_likelihood and of the (log)-priors, defined in the following section. Finally, the parameter space is sampled using the Nested Sampler `Polychord`~@Handley:2015fda @Handley:2015vkr via the `Cobaya`~@Torrado:2020dgo interface, as well as the MCMC sampler~@Lewis:2013hha.


#strong[Prior.--] For each model, we assign uniform/log-uniform priors to all the parameters, ensuring wide ranges to avoid impact on parameter estimation. A collection of the ranges used in the analysis is reported in~@tab:priors.


#strong[White-noise.--] In analogy with the approach of~@NANOGrav:2023hvm @Antoniadis:2023ott, in the full frequency analysis, we assume that a flat (white noise-like) component might be present in the data. In the referenced works, this additional component was included on top of a low-frequency power law behavior, giving rise to a broken power law model with a flat tilt at large frequencies. In the present work, we add this secondary component to all the models we discuss. This procedure automatically selects the relevant bins to constrain the cosmological signal from the full frequency range and models the high-frequency part of the spectrum in terms of the extra flat component. We have compared the compatibility of the results obtained with the full frequency analysis (including the additional flat component) with the results obtained using only the low frequency part of the spectrum and found good agreement for most models.


= FROM TEMPLATES TO PARTICLE-PHYSICS AND COSMOLOGICAL PARAMETERS
<from-templates-to-particle-physics-and-cosmological-parameters>


This section provides the dictionary between the templates' parameters and the information about particle physics and cosmology. In the main texts, some of the templates are already parametrized as the particle physics parameters, #emph[i.e.,] CSs $G mu$, the audible axion $( m_a , f_a )$, and the scalar-induced GW with the parameters of the curvature-perturbation power spectrum. So we focus on the power-law template, which explains GWB from primordial inflation, and the broken power law, which is compatible with first-order phase transitions in many scenarios. The central value and the error intervals of the physical parameters, quoted in the main text, are obtained by doing an analysis directly on such parameters.


#strong[Power-law.--] Apart from the astrophysical GWB from SMBHBs whose spectral tilt is fixed to $2 / 3$, the GWB from primordial inflation beyond the vanilla slow-roll inflation can lead to an arbitrary tilt.


#emph[Primordial Inflation.] The spectrum of GW energy density fraction today (assuming the $Lambda$CDM cosmology) reads @Caprini:2018mtu,


$ h^2 Omega_(upright("GW"))^(( 0 )) ( k ) = 3 / 128 Omega_(upright("rad"))^(( 0 )) h^2 cal(P)_t ( k ) [1 / 2 (k_(upright("eq")) / k)^2 + 16 / 9] arrow.r^(k gt.double k_(upright("eq"))) frac(Omega_(upright("rad"))^(( 0 )) h^2, 24) cal(P)_t ( k ) , $<eq:GWB_inflation_in_k>


with $cal(P)_t ( k )$ the primordial tensor power spectrum, and $k_(upright("eq")) tilde.eq 1.3 dot.op 10^(- 2) med upright("Mpc")^(-1)$ the comoving scale at matter-radiation equality. The second step is justified because the comoving scale around the PTA scale is much larger than $k_(upright("eq"))$, #emph[i.e.,] the GW wavenumber-frequency conversion is $k = 2 pi f$ or,


$ k = 6.25 dot.op 10^5 med upright("Mpc")^(- 1) (f / upright("nHz")) . $<eq:comoving_scale_freq>


With a power-law primordial tensor perturbation, the GW spectrum is also a power-law. We parametrize it in terms of the CMB measurement at the pivot scale $k_(upright("pivot")) = 0.05 med upright("Mpc")^(-1)$,


$ cal(P)_t ( k ) = r A_s (k / k_(upright("pivot")))^(n_t) , $<eq:tensor_power_spec_param>


where $r$ is the tensor-to-scalar ratio whose upper bound is $r lt.eq 0.032$ \(Planck, BICEP/Keck, BAO) @Tristram:2021tvh, $A_s$ is the primordial scalar perturbation measured at $k_(upright("pivot"))$ whose value is constrained to $A_s tilde.eq 2.1 dot.op 10^(- 9)$ \(TT, TE, EE+low-E+lensing) @Planck:2018jri, and $n_t$ is the spectral tilt as in @eq:infl_signal. We can rewrite @eq:GWB_inflation_in_k in terms of frequency as, using @eq:comoving_scale_freq and @eq:tensor_power_spec_param,


$ h^2 Omega_(upright("GW"))^(( 0 )) ( f ) tilde.eq 1.19 dot.op 10^(- 16) (r / 0.032) (frac(A_s, 2.1 dot.op 10^(- 9))) (f / f_(upright("pivot")))^(n_t) , $<eq:GWB_inflation_in_f>


where $f_(upright("pivot")) tilde.eq 8 dot.op 10^(- 17)$ Hz is the frequency corresponding to the pivot scale $k_(upright("pivot"))$. For given amplitude $Omega_(upright("GW"))^(( 0 )) ( f_(*) )$ and frequency $f_(*)$, an increasing $n_t$ gives a smaller $r$. From the analysis in the main text, the best-fitted spectrum is highly red-tilted and corresponds to the tensor-to-scalar ratio of $r tilde.eq 10^12$, which is firmly excluded by the CMB bound. Nonetheless, the 2$sigma$ region prefers the blue-tilted spectrum and has the tensor-to-scalar ratio of $r in [ 5 times 10^(- 4) , 0.032 ]$\; see @fig:inf_cmb_cons. The highly blue-tilted (large $n_t$) GWB could be in tension with the extra-radiation bound. The total GW energy density fraction should not exceed that of the extra radiation @Allen:1997ad @Smith:2006nka @Boyle:2007zx @Kuroyanagi:2014nba @Caprini:2018mtu @Ben-Dayan:2019gll parametrized by the number of extra neutrino species $Delta N_nu$,


$ integral_(f_(upright("BBN")))^(f_(upright("reh"))) frac(d f, f) Omega_(upright("GW"))^(( 0 )) lt.eq 5.6 dot.op 10^(- 6) Delta N_nu med arrow.r^(upright("Eq") thin upright(".")) med #ref(<eq:GWB_inflation_in_f>) f_(upright("reh")) lt.tilde f_(upright("BBN")) [1 + ( 4.3 dot.op 10^9 ) thin n_t (f_(upright("pivot")) / f_(upright("BBN")))^(n_t) (frac(Delta N_nu, 0.2)) (0.032 / r) (frac(2.1 dot.op 10^(- 9), A_s))]^(1 / n_t) , $<eq:bbn_bound_inflation>


where we integrated from the reheating scale $f_(upright("reh"))$ to BBN (or CMB) scale $f_(upright("BBN"))$ in the second step. Using that the perturbation re-enters the horizon at $k = a ( T ) H ( T )$ when the Universe has temperature $T$, we obtain the conversion,


$ f = 1.84 med upright("nHz") (frac(T, 100 med upright("MeV"))) (frac(g_(*) ( T ), 10.75))^(1 / 2) (frac(g_(* , s) ( T ), 10.75))^(- 1 / 3) . $<eq:freq_temp_relation>


The BBN scale $T_(upright("BBN")) tilde.eq upright("MeV")$ corresponds to $f_(upright("BBN")) tilde.eq 1.84 dot.op 10^(- 11)$ Hz. From @eq:bbn_bound_inflation, the extra-radiation bound becomes a constraint on the reheating temperature of the Universe,


$ T_(upright("reh")) lt.tilde med & 0.68 med upright("MeV") (frac(f_(upright("BBN")), 1.84 dot.op 10^(- 11) med upright("Hz"))) (frac(106.75, g_(*) ( T_(upright("reh")) )))^(1 / 2) (frac(106.75, g_(* , s) ( T_(upright("reh")) )))^(- 1 / 3) times\
 & times [1 + ( 4.3 dot.op 10^9 ) thin n_t (f_(upright("pivot")) / f_(upright("BBN")))^(n_t) (frac(Delta N_nu, 0.2)) (0.032 / r) (frac(2.1 dot.op 10^(- 9), A_s))]^(1 / n_t) . $<eq:infl_bound_Treh>


For a power-law GW spectrum in PTA range -- $h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) ) tilde.eq 10^(- 10)$ and $f_(*) tilde.eq upright("nHz")$ -- with $A_s tilde.eq 2.1 dot.op 10^(- 9)$ and $r = 0.032$, the spectral tilt is $n_t tilde.eq 0.73$ and the bound on the reheating temperature reads $T_(upright("reh")) lt.tilde 44 med upright("TeV")$. From @fig:inf_cmb_cons, the tip of the 2$sigma$ region that survives the CMB constraint on $r$ requires a low-scale reheating temperature $T_(upright("reh")) < 0.1 - 1$ TeV.


// [figvision] imgs/power_law_CMB.png
// This panel is a 2D contour plot titled "NANOGrav + EPTA" that maps the parameter space for gravitational wave
// background models. The horizontal axis represents the energy density parameter h^2_{GW}^{(0)} on a logarithmic
// scale from 10^{-8} to roughly 3 10^{-7}. The vertical axis shows the spectral index n_T linearly ranging from
// 0.5 to 3.0. A central orange shaded region indicates the observed signal, with nested contours for 1 and 2
// confidence levels sloping upward from left to right. Four solid red lines represent constant tensor-to-scalar
// ratios (r), labeled 10^{-17}, 10^{-11}, 10^{-5}, and 0.032, which increase in value moving down the plot. The
// bottom section below r=0.032 is shaded light pink and marked as excluded by an arrow. Additionally, dashed
// blue curves depict reheating temperature bounds (T_{reh}^{max}) at 5, 10, 20, 23, and 2.65 GeV, cutting
// diagonally across the allowed region.
#figure([#block[
  #box(image("imgs/power_law_CMB.png", width: 100%))
  ]
  #block[
  ]],
  caption: [
    The CMB observations tightly constrain the PTA-signal interpretation as the inflationary GWB (blue contours). The bound on the tensor-to-scalar ratio (in red) excludes the region with $r > 0.032$. The BBN-$N_(upright("eff"))$ bound requires a low-scale reheating: $T_(upright("reh")) < 10.6$ GeV, at 68\% CL.
  ]
)
<fig:inf_cmb_cons>



Lastly, the required $T_(upright("reh"))$ in @eq:infl_bound_Treh does not guarantee that the extra-radiation bound is not further violated at $f > f_(upright("reh"))$. Because the completion of reheating#footnote[When the Universe starts its radiation-dominated phase.] and the end of inflation can be separated by the #emph[reheating phase], which is not necessarily radiation-dominated. Assuming the dominant energy density is a fluid of equation-of-state $omega$, the GWB from inflation is affected through its transfer function and receives a tilt @Giovannini:1998bp @Giovannini:1999bh @Boyle:2007zx,


$ Omega_(upright("GW"))^(( 0 )) ( f ) prop cal(P)_t ( f ) f^(- 2 ( 1 - 3 omega ) / ( 1 + 3 omega )) arrow.r^(upright("Eq") thin upright(".")) med #ref(<eq:tensor_power_spec_param>) Omega_(upright("GW"))^(( 0 )) ( f ) prop f^(n_t - 2 ( 1 - 3 omega ) / ( 1 + 3 omega )) . $<eq:eos_bound>


If the extra-radiation bound is saturated at $T_(upright("reh"))$, the reheating phase is required to have $omega lt.tilde ( 2 - n_t ) / ( 6 + 3 n_t )$.


#strong[Broken power law.--] GWBs from short-lasting sources, #emph[e.g.], first-order PhT, and the particle production of the audible axion, usually have a peaked shape. Since the UV tail of the audible axion's spectrum is not a power law but an exponential cut-off in @eq:audible_axion_shape, the broken power-law template represents only the case of PhT#footnote[Although the generic spectrum can appear as many peaks because of the mixing among three contributions, we will only focus on the simplified scenarios.]. The peak position is composed of the peak amplitude today, $Omega_(upright("GW"))^(( 0 )) = Omega_(upright("rad"))^(( 0 )) cal(G) ( T_(*) ) sum_i Omega_(upright("GW") , i)$ with $cal(G) equiv [ g_(*) ( T_(*) ) / g_(*) ( T_0 ) ] [ g_(* , s) ( T_(*) ) / g_(* , s) ( T_0 ) ]^(- 4 / 3)$ and $Omega_(upright("GW") , i)$ in @eq:spectrumPhT, and the peak frequency today $f_(*)$ defined in Tab.~#ref(<tab:PhT>, supplement: none). We can thus convert the fitted template's parameters into the PhT parameters in the three scenarios: a) the bubble-dominated case for a strong PhT, b) the sound-wave-dominated case for a weak PhT, and c) the turbulence-dominated for a medium strength. Moreover, we also consider case c) the turbulence from magneto-hydrodynamic (MHD) eddies, whose GW spectrum relates to the primordial magnetic field and which might or might not rely on PhT.


#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.hline(),
    [], [~ ~ Bubbles @Huber:2008hg ~ ~], [~ ~ Sound-wave @Hindmarsh:2015qta ~ ~], [~ ~ Turbulence @Caprini:2009yp ~ ~],
    table.hline(),
    [$cal(N)_i$], [1], [0.16], [20],
    [$Delta_i ( v_(upright(w)) )$], [$frac(0.11 thin v_(upright(w))^3, 0.42 + v_(upright(w))^2)$], [$v_(upright(w))$], [$v_(upright(w))$],
    [$p_i$], [2], [2], [3/2],
    [$q_i$], [2], [1], [1],
    [$s_i ( f , f_(*) )$], [$frac(3.8 ( f / f_(*) )^2.8, 1 + 2.8 ( f / f_(*) )^3.8)$], [$(f / f_(*))^3 [frac(7, 4 + 3 ( f / f_(*) )^2)]^(7 / 2)$], [$frac(( f / f_(*) )^3, ( 1 + f / f_(*) )^(11 / 3) (1 + 8 pi f / tilde(H)_(*)))$],
    [$f_(*)$], [$11 upright("nHz") (frac(0.62, 1.8 - 0.1 v_(upright(w)) + v_(upright(w))^2)) cal(F)$], [$13 upright("nHz") med v_(upright(w))^(- 1) cal(F)$], [$19 upright("nHz") med v_(upright(w))^(- 1) cal(F)$],
  )]
  , caption: [Parameters and functions---defined around @eq:spectrumPhT in the main text---for three types of the GWB from first-order PhTs, taken or derived from Ref.~@Breitbach:2018ddu.]
  , kind: table
  )


$ upright("with") med med cal(F) & equiv (beta / H_(*)) (frac(T_(*), 0.1 med upright("GeV"))) (frac(g_(*) ( T_(*) ), 10.75))^(1 / 2) (frac(g_(* , s) ( T_(*) ), 10.75))^(- 1 / 3) ,\
upright("and") med med tilde(H)_(*) & equiv H_(*) (a_(*) / a_0) tilde.eq 11 med upright("nHz") (frac(T_(*), 0.1 med upright("GeV"))) (frac(g_(*) ( T_(*) ), 10.75))^(1 / 2) (frac(g_(* , s) ( T_(*) ), 10.75))^(- 1 / 3) . $<tab:PhT>



#emph[a) Bubbles.] According to the #emph[envelope approximation] @Huber:2008hg#footnote[Nonetheless, many numerical simulations and other models found slightly different values ranging from $f^([ - 3 , - 0.9 ]) and $f^([ - 3 , - 1 ]) for the IR and UV slopes, respectively. See Fig.~6.3.1 of Ref.~@Gouttenoire:2022gwi for the summary and references therein.], the shape of the GWB has the IR tail with $Omega_(upright("GW")) prop f^2.8$ and the UV tail with $Omega_(upright("GW")) prop f^(- 1)$. If there is a vacuum-dominated epoch or the so-called #emph[super-cooling phase] ($alpha gt.double 1$), a strong first-order PhT happens in a vacuum, and the collisions among bubble walls source the dominant GW signal. With @eq:spectrumPhT and Tab.~#ref(<tab:PhT>, supplement: none), we translate the peak position -- the peak frequency today $f_(*)$ and the amplitude $Omega_(upright("GW"))^(( 0 )) ( f_(*) )$ -- of the GWB into the PhT parameters:


$ (beta / H_(*))_(upright(b)) & tilde.eq 206 [Delta_(upright(b)) ( v_(upright(w)) ) kappa_(upright(b))^2 cal(G) ( T_(*) ) (frac(10^(- 9), h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) )))]^(1 / 2) ,\
(T_(*))_(upright(b)) & tilde.eq 0.48 med upright("MeV") (frac(f_(*), 10 med upright("nHZ"))) (frac(h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) ), 10^(- 9)))^(1 / 2) (frac(g_(* , s) ( T_(*) ), g_(*) ( T_(*) ))) (frac(1.8 - 0.1 v_(upright(w)) + v_(upright(w))^2, 0.62)) Delta_(upright(b))^(- 1 / 2) kappa_(upright(b))^(- 1) . $


Typically, the vacuum energy is efficiently converted into the energy of the bubbles $kappa_(upright(b)) = 1$, and the wall velocity reaches the speed of light $v_(upright(w)) arrow.r 1$ (and $Delta_(upright(b)) approx 0.08$). For the range compatible with PTA observation, this strong PhT following the vacuum-dominated phase completes at $T_(*) tilde$MeV and can obstruct BBN @Bringmann:2023opz.


#emph[b) Sound wave.] According to Ref.~@Hindmarsh:2015qta#footnote[The recent simulations also found the presence of the intermediate scale -- corresponding to the width of the sound shell -- with $prop f^1$ behavior near the peak.], the shape of the GWB has the IR tail with $Omega_(upright("GW")) prop f^3$ and the UV tail with $Omega_(upright("GW")) prop f^(- 4)$. The sound-wave contribution dominates when the PhT is not too strong, and the bubbles expand in the background thermal plasma and reach the terminal velocity (so-called #emph[non-runaway] scenario). The peak position in @eq:spectrumPhT and Tab.~#ref(<tab:PhT>, supplement: none) can be translated into PhT parameters ($alpha$, $beta / H_(*)$, $T_(*)$) by,


$ (beta / H_(*))_(upright("sw")) & tilde.eq 68 (frac(10^(- 9), h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) ))) cal(G) ( T_(*) ) v_(upright(w)) [frac(( 1 + alpha )^2 alpha^(- 2) kappa_(upright("sw"))^(- 2) ( alpha ), 100)]^(- 1) ,\
(T_(*))_(upright("sw")) & tilde.eq 1.5 med upright("MeV") (frac(f_(*), 10 med upright("nHZ"))) (frac(h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) ), 10^(- 9))) [frac(10.75, g_(*) ( T_(*) ))]^(3 / 2) [frac(g_(* , s) ( T_(*) ), 10.75)]^(5 / 3) [frac(( 1 + alpha ) alpha^(- 1) kappa_(upright("sw"))^(- 1) ( alpha ), 10)]^2 . $


where the efficiency factor is $kappa_(upright("sw")) ( alpha ) tilde.eq alpha ( 0.73 + 0.083 sqrt(alpha) + alpha )^(- 1)$ @Espinosa:2010hh. The numerator of the last bracket in the $T_(*)$ expression is $tilde.eq 84$ and 6.2 for $alpha = 0.1$ and 0.5, respectively. Note that there is degeneration among $alpha$, $beta / H_(*)$, and $T_(*)$, which could be further broken by considering a UV completion of this low-$T$ first-order PhT.


#emph[c) Turbulence.] From Ref.~@Caprini:2009yp, the shape of the GWB is a double-broken power-law spectrum. The slope far from the peak in the IR is $Omega_(upright("GW")) prop f^3$ from causality. The intermediate IR scale $tilde(H)_(*) < f < f_(*)$ with $Omega_(upright("GW")) prop f^2$ corresponding to the time scale of the turbulence, and the UV tail with $Omega_(upright("GW")) prop f^(- 5 / 3)$. Typically during PhT, the GW from turbulence is accompanied by the more dominant sound-wave contribution (i.e., $kappa_(upright("turb")) < kappa_(upright("sw"))$). In our analysis, we consider both sound-wave and turbulence in the case of weak PhT.


#emph[MHD turbulence.--]Usually, the turbulence arises as MHD eddies due to the bubble motion during first-order PhT or some other mechanisms (#emph[e.g.], @Kamada:2019uxp) unrelated to PhT. The GWB is sourced by the magnetic anisotropy#footnote[From the equation of motion of the metric-tensor perturbation in Fourier space: $dot.double(h)_k + 3 H dot(h)_k + k^2 / a^2 h_k = 16 pi G Pi_k^(upright("TT"))$, the energy density of GW is approximate $rho_(upright("GW")) tilde dot(h)^2 / ( 32 pi G ) tilde 8 pi G cal(T)^2 ( Pi^(upright("TT")) )^2$ with $cal(T)$ the duration of the source. Neglecting the contribution from fluid motion, the anisotropic stress is dominated by the magnetic field: $Pi^(upright("TT")) tilde.eq B^2 / 2$. So the GW energy density at production time is $rho_(upright("GW")) tilde.eq 2 pi G B^4 cal(T)^2$.] and has the energy density fraction at the production: $Omega_(upright("GW"))^(*) tilde 3 ( Omega_B^(*) )^2 ( H_(*) cal(T) )^2$ @Neronov:2020qrl where $Omega_B^(*) = B_(*)^2 / ( 2 rho_(c , *) )$ is the magnetic energy-density fraction, $*$ denotes the time of GW emission, and the sourcing-time scale related to size and velocity of turbulence $cal(T) tilde l_(*) / v_A lt.tilde H_(*)^(- 1)$ with $v_A tilde.eq sqrt(2 Omega_B^(*))$ the Alfvén speed. The GW energy density becomes $Omega_(upright("GW"))^(*) tilde 3 / 2 Omega_B^(*) ( H_(*) l_(*) )^2$. Nonetheless, depending on the detail of turbulence, the scaling can vary $Omega_(upright("GW"))^(*) tilde ( Omega_B^(*) )^n ( H_(*) l_(*) )^2$ with $n in [ 1 , 2 ]$. The GW spectrum today peaks at amplitude $Omega_(upright("GW"))^(( 0 )) = Omega_(upright("rad"))^(( 0 )) cal(G) ( T_(*) ) ( Omega_B^(*) )^n ( H_(*) l_(*) )^2$ and frequency today $f_(*) = 2 / l_(*) dot.op a_(*) / a_0$ @Neronov:2020qrl. For simplicity, we consider the case of the largest processed eddies (LPE) #emph[i.e.,] maximized $l_(*) = v_A / H_(*)$ and the GW spectrum. The peak position -- the amplitude and frequency -- is related to the magnetic energy fraction and the temperature of the GW production,


$ Omega_B^(*) & tilde.eq [1.4 dot.op 10^(- 5) (frac(h^2 Omega_(upright("GW"))^(( 0 )) ( f_(*) ), 10^(- 9))) (frac(10.75, g_(*) ( T_(*) ))) (frac(g_(* , s) ( T_(*) ), 10.75))^(4 / 3)]^(1 / ( n + 1 )) ,\
f_(*) & tilde.eq 16.1 med upright("nHz") (T_(*) / upright("MeV")) (10^(- 2) / Omega_B^(*))^(1 / 2) , $


We can also characterize the MHD turbulence by the magnetic field strength $B_0$ and the magnetic-field correlation length scale $l_B equiv l_(*) ( a_0 / a_(*) )$ as observed today#footnote[The energy density in magnetic field red-shifts as radiation $Omega_(B , 0) = Omega_B^(*) Omega_(upright("rad")) cal(G) ( T_(*) )$, so approximately $B prop a^(- 2)$.],


$ B_0 = 0.4 med upright("mu") thin upright("G") (Omega_B^(*) / 10^(- 2))^(1 / 2) (frac(g_(*) ( T_(*) ), 10.75))^(1 / 2) (frac(10.75, g_(* , s) ( T_(*) )))^(2 / 3) , med med l_B tilde.eq 1.95 med upright("pc") (frac(10 med upright("nHz"), f_(*))) . $


#strong[Cosmic Strings.--] We assume that a string network loses energy only through GW emission of loops. We sum up to $j = 10^5$ modes of loop oscillations. More complicated CS scenarios, #emph[e.g.],~small-loop population~@Lorenz:2010sm or meta-stable strings~@Buchmuller:2019gfy @Buchmuller:2021mbb @Buchmuller:2020lbh, can alter the fittings to PTA data, see Ref.~@EPTA:2023hof @NANOGrav:2023hvm. We also note that we consider field theory CS from a gauge symmetry, discarding the global symmetry case, whose Goldstone-boson emission leads to a strong $Delta N_(upright("eff"))$ bound~@Chang:2021afa @Gorghetto:2021fsn. See @Servant:2023mwt for the best-fitted result and constraints on global-(axionic)-string SGWB obtained from the recent analysis of the `NG15` data set.


= CONSTRAINTS ON SCALAR-INDUCED GRAVITATIONAL WAVES
<constraints-on-scalar-induced-gravitational-waves>
Large scalar perturbations at small scales, unbounded by CMB, are constrained by their direct consequences and many observations. We classify two types of constraints:


#strong[Primordial black holes.]-- Sourced by the scalar perturbation, the energy density perturbations collapse into the #emph[primordial black holes] (PBH) @Hawking:1971ei @Carr:1974nx @Carr:1975qj whose abundance is subjected to the PBH over-abundance and many observational bounds (#emph[e.g.], gravitational lensing and LVK merger events) @Green:2020jor @bradley_j_kavanagh_2019_3538999. Starting from the scalar perturbation in @eq:gaussian_scalar, we use the #emph[peak theory] method in Ref.~@Young:2019yug with a #emph[real-space top-hat] window function (with $gamma = 0.36$, $kappa = 4$, and $delta_c = 0.55$) to calculate the total PBH abundance today, parametrized by $f_(upright("PBH"))^(upright("tot"))$ the total fraction of the #emph[cold dark matter] today. We also include the non-linear effect between the primordial scalar and the energy density perturbations.


Since the collapse happens when the scalar perturbation re-enters the horizon, many populations of PBH can be formed from a broad scalar power spectrum along the cosmic history. However, the spectral shape of the PBH abundance over mass range inherits that of the primordial scalar perturbation. For the SIGW peaked at frequency $f_(*)$, the scale of the scalar-perturbation peak re-enters the horizon and collapses into the peak of PBH mass distribution with mass defined by the horizon mass $M_H$, #emph[i.e.,] the total energy density enclosed within the Hubble volume at temperature $T$,


$ M_H = frac(4 pi, 3) H^(- 3) (3 M_(zws_(upright("Pl")))^2 H^2) tilde.eq 44 thin M_⊙ thin (frac(g_(*) ( T ), 10.75))^(1 / 2) (frac(10.75, g_(* s) ( T )))^(2 / 3) (frac(10^(- 9) thin upright("Hz"), f_(*)))^2 , $<eq:horizon_mass>


where $M_⊙ tilde.eq 1.988 times 10^30$ kg is the Solar mass, and we used the frequency-temperature relation @eq:freq_temp_relation. For a typical frequency of SIGW in PTA ($f_(*) tilde.eq 1 - 10$ nHz), the PBH is populated in the mass range of $M_H tilde.eq cal(O) ( 0.4 - 40 ) M_⊙$.


The most conservative constraint is the PBH over-abundance $f_(upright("PBH"))^(upright("tot")) > 1$, while many observations also exclude the PBH abundance for $f_(upright("PBH"))^(upright("tot")) < 1$ over a wide range of masses @Green:2020jor @bradley_j_kavanagh_2019_3538999. There are two dominant constraints for the Solar-mass PBH compatible with PTA interpretation: the LVK mergers, individual events and stochastic background, and the gravitational lensing constraints. We translate the bounds on the monochromatic PBH mass in Ref.~@Green:2020jor using the method outlined in Ref.~@Carr:2017jsz for our extended PBH mass distribution. @fig:SIGW_constraint shows the constraints (PBH over-abundance, lensing, and LVK mergers) on the log-normal scalar perturbation. We also calculate the PBH abundance in the presence of the pNG scalar perturbation by applying the simplifying technique of Ref.~@Young:2022phe to the procedure of the Gaussian case.


#strong[CMB and $mu$-distortion.]-- Though the scalar perturbation power spectrum peaks at the scale of PTA, its tail at scales larger than PTA ($k lt.tilde 10^6 med upright("Mpc")^(- 1)$) can be constrained for a too broad spectrum. First, the sizeable scalar perturbation sources the density fluctuation, dissipating into photon fluid and causing the $mu$-distortion of the CMB spectrum @Chluba:2012we @Kohri:2014lza. Another constraint arises when the spectrum is broad and large to contradict the CMB observations @Hunt:2015iua. By translating the bounds in Ref.~@Inomata:2018epa, we find no such bound entering the shown parameter spaces of @fig:SIGW_constraint.


// [figvision] imgs/pbh_gaussian.png
// Panel a displays a contour plot on logarithmic axes. The horizontal axis represents frequency, f*, in
// nanohertz, ranging from 10 to roughly 200. The vertical axis denotes amplitude, A_R, spanning 10^-2 to 10^-1.
// Two nested blue contours indicate the one-sigma and two-sigma confidence regions for the PTA signal
// interpretation. Overlaid are exclusion limits: a red horizontal line at approximately A_R = 8x10^-2 marks the
// PBH over-abundance constraint, while a purple line below it indicates lensing constraints. An orange marker
// labeled LVK sits near f* = 15 nHz. Faint diagonal lines represent constant spectral index values. Panel b
// shows the same data structure as panel a but with the parameter sigma_R set to 2. The horizontal frequency
// axis spans 10 to 200 nHz, and the vertical amplitude axis ranges from 10^-2 to 10^-1. The blue 1-sigma and
// 2-sigma confidence ellipses shift slightly downward compared to the previous panel. The red PBH over-abundance
// limit remains fixed horizontally near A_R = 8x10^-2, and the purple lensing constraint stays just below it.
// The orange LVK indicator is positioned around 15 nHz. Diagonal grey lines denote constant parameters, showing
// how the allowed region interacts with these physical boundaries. Panel c presents the final variation where
// sigma_R equals 1. The x-axis covers frequencies from 10 to 200 nHz, and the y-axis shows amplitudes from 10^-2
// to 10^-1. The blue 1-sigma and 2-sigma confidence regions are pushed further down and to the left relative to
// the other panels. The red horizontal exclusion band for PBH abundance is located near A_R = 7x10^-2, with the
// purple lensing limit immediately underneath. The orange LVK marker is visible near 15 nHz. Background diagonal
// lines illustrate the parameter space, highlighting that the viable region remains distinct from the exclusion
// zones.
#figure(scope: "parent", [#strong[2nd Order Scalar Induced GWB (Gaussian)] \
  #box(image("imgs/pbh_gaussian.png", width: 100%))

  ],
  caption: [
    Constraints on the Gaussian scalar-perturbation bumps in @eq:gaussian_scalar from PBH abundance (over-abundance, lensing, LVK mergers) and other constraints ($mu$-distortion). The parameters are ${ sigma$, $f_(*)$, $A_(cal(R)) }$. The 2OSI GW interpretation of the PTA signal (in blue) survives but cannot account for the dark matter totality.
  ]
)
<fig:SIGW_constraint>



#figure([#set text(size: 9pt)
  #table(
    columns: 3,
    inset: (x: 5pt, y: 2.5pt),
    align: (center,center,left,),
    table.hline(),
    [#strong[Parameter]], [#strong[Description]], [#strong[Prior]],
    table.hline(),
    [], [#strong[Power law (PL)]], [],
    [$cal(A)_(upright("inf"))^(( * ))$], [Amplitude of the signal at $f_(*) = f_(1 upright("yr"))$], [log-uniform \[$10^(- 20) , 10^(- 4)$\]],
    [$n_t$], [Spectral tilt], [uniform \[$- 4 , 6$\]],
    table.hline(),
    [], [#strong[SMBHBs (PL $n_t = 2 / 3$)]], [],
    [$cal(A)_(upright("2") / upright("3"))^(( * ))$], [Amplitude of the signal at $f_(*) = f_(1 upright("yr"))$], [log-uniform \[$10^(- 14) , 10^(- 6)$\]],
    table.hline(),
    [], [#strong[Flat (PL $n_t = 0$)]], [],
    [$cal(A)_(upright(0))^(( * ))$], [Amplitude of the signal at $f_(*) = f_(1 upright("yr"))$], [log-uniform \[$10^(- 13) , 10^(- 4)$\]],
    table.hline(),
    [], [#strong[Field-theory Cosmic strings (field th. CS)]], [],
    [$G mu$], [Cosmic-string tension], [log-uniform \[$10^(- 14) , 10^(- 6)$\]],
    table.hline(),
    [], [#strong[Cosmic super-strings (super CS)]], [],
    [$G mu$], [Cosmic-string tension], [log-uniform \[$10^(- 14) , 10^(- 6)$\]],
    [$p$], [Inter-commutation probability], [log-uniform \[$10^(- 3) , 1$\]],
    table.hline(),
    [], [#strong[Broken power law (BPL)]], [],
    [$cal(A)_(*)$], [Peak amplitude], [log-uniform \[$10^(- 14) , 10^(- 7)$\]],
    [$f_(*)$ \[nHz\]], [Peak frequency], [log-uniform \[$10^(- 2.5) , 10^4.5$\]],
    [$n_1$], [Low-frequency tilt $f lt.double f_(*)$], [uniform \[$- 8 , 8$\]],
    [$n_2$], [High-frequency tilt $f gt.double f_(*)$], [uniform \[$- 8 , 8$\]],
    table.hline(),
    [], [#strong[Audible axion (AA)]], [],
    [$f_a$ \[$m_p$\]], [Axion decay constant], [log-uniform \[$10^(- 4) , 10^2$\]],
    [$m_a$ \[meV\]], [Axion mass], [log-uniform \[$10^(- 13) , 10^(- 9)$\]],
    table.hline(),
    [], [#strong[Gaussian 2$""^(upright("nd"))$ order scalar-induced GWB: bump (gSIGWB)]], [],
    [$cal(A)_(cal(R))$], [Amplitude of the scalar power spectrum], [log-uniform \[$10^(- 3) , 10$\]],
    [$sigma_(cal(R))$], [Variance of the scalar power spectrum], [log-uniform \[$0.1 , 3$\]],
    [$f_(*)$ \[nHz\]], [Frequency corresponding to $k_(*)$], [log-uniform \[$10^(- 2) , 10^4$\]],
    table.hline(),
    [], [#strong[Non-gaussian 2$""^(upright("nd"))$ order scalar-induced GWB: bump (ngSIGWB)]], [],
    [$cal(A)_(cal(R))$], [Amplitude of the scalar power spectrum], [log-uniform \[$10^(- 3) , 10$\]],
    [$sigma_(cal(R))$], [Variance of the scalar power spectrum], [log-uniform \[$0.025 , 0.2$\]],
    [$f_(*)$ \[nHz\]], [Frequency corresponding to $k_(*)$], [log-uniform \[$10^(- 1) , 10$\]],
    [$f_(upright("nl"))$], [Local non-Gaussianity (and imposing the perturbativity: $A_(cal(R)) f_(mono(n l))^2 lt.tilde 1$ @Adshead:2021hnm)], [log-uniform \[$10^(- 5) , 10^5$\]],
    table.hline(),
    [], [#strong[Strong first-order PhT: bubbles ($alpha gt.double 1$ runaway in vacuum) (PhTRV)]], [],
    [$beta / H_(*)$], [Inverse transition duration], [log-uniform \[$1 , 500$\]],
    [$T_(*)$ \[GeV\]], [Transition temperature], [log-uniform \[$10^(- 3) , 10^5$\]],
    table.hline(),
    [], [#strong[Weak first-order PhT: sound-wave and turbulence (non-runaway) (PhTNR)]], [],
    [$alpha$], [Transition strength], [log-uniform \[$10^(- 2) , 1$\]],
    [$beta / H_(*)$], [Inverse transition duration], [log-uniform \[$1 , 500$\]],
    [$T_(*)$ \[GeV\]], [Transition temperature], [log-uniform \[$10^(- 3) , 10^5$\]],
    table.hline(),
    [], [#strong[Magnetro-hydrodynamics (MHD) turbulence]], [],
    [$T_(*)$ \[GeV\]], [Temperature when turbulence is generated], [log-uniform \[$10^(- 3) , 10^6$\]],
    [$B_0$ \[$mu$G\]], [Magnetic field strength], [log-uniform \[$10^(- 3) , 10^2$\]],
    [$l_B$ \[pc\]], [Magnetic field correlation length], [log-uniform \[$10^(- 6) , 10^3$\]],
  )], caption: [Summary of all priors]
  , kind: table
  )
<tab:priors>



