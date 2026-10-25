#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: (..n) => if n.pos().first() <= 1 { "" } else { str(n.pos().first() - 1) }, paper: "a4", margin: (left: 3.00cm, right: 2.54cm, top: 3.08cm, bottom: 4.08cm))
#set page(footer: context {
  let n = counter(page).get().first()
  if n > 1 { align(center)[#text(10.9pt)[– #(n - 1) –]] }
})
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.58em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.2em, below: 0.8em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show figure.caption: set text(size: 10pt)
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
  #text(24.8pt, weight: "bold", [Anatomy of single-field inflationary models for primordial black holes])   #v(1.2em)
  #text(10.5pt)[Alexandros Karam,#super[1], Niko Koivunen,#super[1], Eemeli Tomberg,#super[1], Ville Vaskonen,#super[1], and Hardi Veermäe#super[1]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] NICPB, Rävala 10, 10143 Tallinn, Estonia] \
  #text(9pt)[#super[2] Institut de Fisica d'Altes Energies, Campus UAB, 08193 Bellaterra, Barcelona, Spain] \
]
#v(1.2em)




















#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em, leading: 0.6em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 1.0em, it) } else { it }
  }
  #outline(title: none, depth: 2)
]

= Introduction
<sec:intro>


The existence of dark matter (DM) has been clearly established via its gravitational effect on cosmic structures, yet its nature and origin has eluded us for almost a century~@Bertone:2016nfn. The LIGO-Virgo collaboration's discovery of gravitational waves (GWs)~@LIGOScientific:2016aoc @LIGOScientific:2018mvr @LIGOScientific:2020ibl @LIGOScientific:2021djp originating from binary black hole (BH) mergers together with the absence of observational signatures of particle DM has reinvigorated interest on primordial black holes (PBHs)~@Hawking:1971ei @Carr:1974nx as a potential DM candidate~@Bird:2016dcv @Clesse:2016vqa @Sasaki:2016jop. However, numerous experiments have placed bounds on the PBH abundance (see #emph[e.g.]~@Carr:2020gox for a recent review) and PBHs are allowed to make up the entirety of DM only in the asteroid mass window $10^17 thin upright(g) lt.tilde M_(upright("PBH")) lt.tilde 10^21 thin upright(g)$ @Niikura:2017zjd @Katz:2018zrn @Montero-Camacho:2019jte. Nevertheless, PBHs in the solar mass range could still contribute to the LIGO-Virgo merger events if solar mass PBHs make up about 0.1\% of the DM energy budget~@Raidal:2017mfl @Ali-Haimoud:2017rtz @Raidal:2018bbj @Vaskonen:2019jpv @DeLuca:2020bjf @Hall:2020daa @Wong:2020yig @Hutsi:2020sol @DeLuca:2021wjr @Franciolini:2021tla @Franciolini:2021xbq @Franciolini:2022iaa. PBHs heavier than $10^3 M_⊙$ can provide seeds for supermassive BHs~@Duechting:2004dk @Kawasaki:2012kn @Carr:2018rid and play a role in generating cosmic structures~@Carr:2018rid.


PBHs can form via various channels in the early Universe (see #emph[e.g.]~@Khlopov:2008qy @Carr:2020gox for reviews). The most commonly considered scenario involves the collapse of large density perturbations generated during inflation~@Carr:1975qj @Garcia-Bellido:1996mdl @Alabidi:2009bk @Kawasaki:2012wr @Clesse:2015wea @Garcia-Bellido:2016dkw @Carr:2017edp @Dimopoulos:2019wew @Ivanov:1994pa @Carr:1994ar @Bullock:1996at @Kawasaki:1997ju @Kawasaki:1998vx @Yokoyama:1998pt @Kohri:2007qn @Saito:2008em @Bugaev:2008bi @Drees:2011hb @Drees:2011yz @Kawasaki:2016pql @Garcia-Bellido:2017mdw @Domcke:2017fix @Ezquiaga:2017fvi @Kannike:2017bxn @Germani:2017bcs @Motohashi:2017kbs @Di:2017ndc @Ballesteros:2017fsr @Ballesteros:2020qam @Hertzberg:2017dkh @Cicoli:2018asa @Ozsoy:2018flq @Biagetti:2018pjj @Ezquiaga:2018gbw @Dalianis:2018frf @Gao:2018pvq @Rasanen:2018fom @Ballesteros:2018wlw @Carr:2018poi @Passaglia:2018ixg @Dalianis:2019asr @Atal:2019cdz @Drees:2019xpp @Kuhnel:2019xes @Bhaumik:2019tvl @Fu:2019ttf @Atal:2019erb @Arya:2019wck @Mahbub:2019uhl @Mishra:2019pzq @Ballesteros:2019hus @Ashoorioon:2019xqc @Fu:2019vqc @Fu:2020lob @Nanopoulos:2020nnh @Ozsoy:2020kat @Ragavendra:2020sop @Kefala:2020xsx @Ng:2021hll @Solbi:2021wbo @Inomata:2021uqj @Stamou:2021qdk @Wu:2021zta @Bastero-Gil:2021fac @Dalianis:2021iig @Solbi:2021rse @Zheng:2021vda @Cheng:2021lif @Teimoori:2021pte @Heydari:2021gea @Kawai:2021edk @Gangopadhyay:2021kmf @Rezazadeh:2021clf @Inomata:2021tpx @Heydari:2021qsr @Figueroa:2021zah @Wang:2021kbh @Iacconi:2021ltm @Sarkar:2021tsa @Cai:2021zsp @Cicoli:2022sih @Frolovsky:2022ewg, but they may be produced also in cosmological phase transitions~@Hawking:1982ga @Kodama:1982sf @Baker:2021nyl, by the collapse of cosmic strings~@Hawking:1987bn @Polnarev:1988dh @Garriga:1993gj @Caldwell:1995fu @MacGibbon:1997pu @Helfer:2018qgv @Jenkins:2020ctp, false vacuum bubbles~@Garriga:2015fdk @Deng:2017uwc @Deng:2020mds @Kusenko:2020pcg @Ashoorioon:2020hln @Maeso:2021xvl or domain walls~@Rubin:2001yw @Vachaspati:2017hjw @Ferrer:2018uiu @Ge:2019ihf @Deng:2016vzb, or post-inflationary scalar field fragmentation~@Cotner:2018vug @Cotner:2016cvr @Cotner:2019ykd. These PBH formation scenarios could be probed indirectly via the associated GW background. In particular, large scalar perturbations during inflation induce a stochastic GW background via mode coupling at the second perturbative order~@Matarrese:1993zf @Matarrese:1997ay @Nakamura:2004rm @Ananda:2006af @Baumann:2007zm (for a recent review, see~@Domenech:2021ztg). This GW background has not been seen so far by LIGO-Virgo~@Kapadia:2020pnr @Romero-Rodriguez:2021aws, but it has been suggested that the recent signal from pulsar timing experiments at nHz frequencies~@NANOGrav:2020bcs @Goncharov:2021oub @Chen:2021rqp @Antoniadis:2022pcn could be related to GWs accompanying PBH formation from large inflationary scalar perturbations~@Vaskonen:2020lbd @DeLuca:2020agl @Kohri:2020qqd @Domenech:2020ers.


In this paper, we will focus on single-field inflationary scenarios for PBHs, which typically require potentials with specific features capable of inducing peaks in the curvature power spectrum. Over the past three decades, a large number of such models have been proposed~@Ivanov:1994pa @Carr:1994ar @Bullock:1996at @Kawasaki:1997ju @Kawasaki:1998vx @Yokoyama:1998pt @Kohri:2007qn @Saito:2008em @Bugaev:2008bi @Drees:2011hb @Drees:2011yz @Kawasaki:2016pql @Garcia-Bellido:2017mdw @Domcke:2017fix @Ezquiaga:2017fvi @Kannike:2017bxn @Germani:2017bcs @Motohashi:2017kbs @Di:2017ndc @Ballesteros:2017fsr @Ballesteros:2020qam @Hertzberg:2017dkh @Cicoli:2018asa @Ozsoy:2018flq @Biagetti:2018pjj @Ezquiaga:2018gbw @Dalianis:2018frf @Gao:2018pvq @Rasanen:2018fom @Ballesteros:2018wlw @Carr:2018poi @Passaglia:2018ixg @Dalianis:2019asr @Atal:2019cdz @Drees:2019xpp @Kuhnel:2019xes @Bhaumik:2019tvl @Fu:2019ttf @Atal:2019erb @Arya:2019wck @Mahbub:2019uhl @Mishra:2019pzq @Ballesteros:2019hus @Ashoorioon:2019xqc @Fu:2019vqc @Fu:2020lob @Nanopoulos:2020nnh @Ozsoy:2020kat @Ragavendra:2020sop @Kefala:2020xsx @Ng:2021hll @Solbi:2021wbo @Inomata:2021uqj @Stamou:2021qdk @Wu:2021zta @Bastero-Gil:2021fac @Dalianis:2021iig @Solbi:2021rse @Zheng:2021vda @Cheng:2021lif @Teimoori:2021pte @Heydari:2021gea @Kawai:2021edk @Gangopadhyay:2021kmf @Rezazadeh:2021clf @Inomata:2021tpx @Heydari:2021qsr @Figueroa:2021zah @Wang:2021kbh @Iacconi:2021ltm @Sarkar:2021tsa @Cai:2021zsp @Cicoli:2022sih @Frolovsky:2022ewg. We will briefly review them in the following.


The first toy model was developed in 1994 by Ivanov et al.~@Ivanov:1994pa, where they considered a potential with two power-law regions separated by a plateau. Similarly, an early toy model assumed a cliff-like feature where the slope becomes abruptly steeper~@Bullock:1996at. Although these models can produce large spikes in the power spectrum, they also predict a blue tilt at the CMB scales, which is now excluded.


The first theoretically-motivated model was proposed in the context of supergravity~@Kawasaki:1997ju (and was further developed in~@Kawasaki:1998vx @Kawasaki:2016pql). In this scenario, a specific choice for the superpotential generates a polynomial inflaton potential, which, together with a complicated “pre-inflation” phase, produces a power spectrum with a high amplitude and a shallow slope ($n_s < 1$) on small scales and a low amplitude and a nearly scale-invariant spectrum ($n_s tilde 1$) on large scales.


Inflation from a Coleman-Weinberg type potential $V prop phi.alt^4 ln ( phi.alt^2 / mu^2 )$ could produce two inflationary phases~@Yokoyama:1998pt @Saito:2008em @Bugaev:2008bi#h(0pt)---inflation followed by crossing the minimum and a near-stop close to the origin which causes a second phase of inflation. A similar scenario is possible with the double well potential~@Bugaev:2008bi (see also~@Fu:2020lob). Unfortunately, the Coleman-Weinberg potential predicts a very large tensor-to-scalar ratio ($r > 0.3$) and a quite small scalar spectral index ($n_s < 0.94$).


In the running mass model~@Kohri:2007qn @Drees:2011hb @Drees:2011yz (see also~@Motohashi:2017kbs), $V ( phi.alt ) = V_0 plus.minus m^2 ( phi.alt ) phi.alt^2 / 2$, obtained from softly broken global supersymmetry, the power spectrum does not feature a peak, but instead it grows continuously on small scales. This feature can produce an overabundance of PBHs and, furthermore, result in eternal inflation unless a “waterfall” field is introduced to force inflation to end.


More recently, a simple, theoretically well-motivated scenario involving a non-minimally coupled inflaton with a general quartic potential has been considered~@Kannike:2017bxn @Ballesteros:2017fsr @Ballesteros:2020qam. In this scenario, the Einstein frame possesses a quasi-inflection point (a small local maximum) for PBH production, and the non-minimal coupling leads to a plateau at large field values guaranteeing a small tensor-to-scalar ratio. However, non-minimal polynomial inflation with at most quartic terms will generally give a small scalar spectral index ($n_s < 0.95$) when it produces PBHs with lifetimes exceeding the age of the Universe~@Kannike:2017bxn @Ballesteros:2017fsr @Ballesteros:2020qam. This issue can be solved by quantum corrections, such as threshold effects in running couplings~@Kannike:2017bxn or effective higher-order operators~@Ballesteros:2020qam. A very similar scenario was initially considered in Ref.~@Garcia-Bellido:2017mdw (see also~@Di:2017ndc @Hertzberg:2017dkh @Kuhnel:2019xes @Bhaumik:2019tvl @Ng:2021hll), in which the Einstein frame potential of non-minimal quartic inflation was used, but without the field redefinition that arises when moving from the Jordan frame to the Einstein frame.


In the context of quasi-inflection point scenarios, it was shown that, around the small maximum, the slow-roll (SR) conditions fail, and the inflaton enters a temporary ultra-slow-roll (USR) phase during which it will slow down considerably~@Kannike:2017bxn @Germani:2017bcs @Motohashi:2017kbs. During this process, a sizeable peak in the spectrum can be generated. As a result, the usual SR approximation for the curvature power spectrum breaks down, and the Mukhanov-Sasaki equation must be solved numerically to obtain accurate results. In most cases, the potential parameters must be tuned to the precision of several significant digits as the field has to be balanced on top of a small local maximum for tens of $e$-folds before rolling over it.


Once it became widely understood that an asymptotically flat potential that features a quasi-inflection point at smaller field values can potentially produce PBHs and drive otherwise observationally successful inflation, a plethora of new models were suggested. Perhaps the most physically-motivated and economic of them is Critical Higgs Inflation~@Ezquiaga:2017fvi (see also~@Ballesteros:2017fsr @Drees:2019xpp). In this model, the non-minimally coupled Standard Model Higgs field is taken to be the inflaton. It has a simple quartic potential which gets logarithmic corrections once one considers the RG running of the quartic and non-minimal couplings. However, in~@Rasanen:2018fom, the model was studied carefully in both metric and Palatini formalisms and it was shown that one could obtain inflationary predictions in agreement with the experimental constraints only if $M_(upright("PBH")) < 10^6 med upright(g)$.


Inflaton potentials with a quasi-inflection point can also arise in models of string inflation~@Cicoli:2018asa @Ozsoy:2018flq @Cicoli:2022sih, string-inspired axion monodromy~@Ballesteros:2019hus, superconformal attractors~@Dalianis:2018frf @Dalianis:2019asr (see also~@Ragavendra:2020sop @Iacconi:2021ltm), and no-scale supergravity~@Gao:2018pvq @Nanopoulos:2020nnh @Stamou:2021qdk @Wu:2021zta. Most of these models comply with the inflationary constraints and predict PBH DM in the asteroid mass window, $M_(upright("PBH")) tilde 10^(- 16) med M_⊙ - 10^(- 13) med M_⊙$.


Large peaks in the power spectrum can also be induced by introducing a dump/dip#footnote[Note that introducing bumps/dips are mathematically equivalent to constructing potentials with small maxima (quasi-inflection points).] or a step to the potential. In the bumpy/dippy models~@Atal:2019cdz @Atal:2019erb @Mishra:2019pzq @Zheng:2021vda @Rezazadeh:2021clf @Wang:2021kbh, a small, often a Gaussian bump/dip multiplies a base potential. As bumps and dips can be placed anywhere in the potential, they can produce PBHs in a wide range of masses. Interestingly, a base potential with $n_s gt.eq 0.98$, excluded by CMB observations~@Planck:2018jri, becomes favoured when modified by the bump/dip. This is because the inflaton typically spends an extra $10 - 15 e$-folds during the power spectrum amplification near the bump/dip, reducing the length of the remaining SR period to at most 45-50 $e$-folds and thus results in a decrease in the value of $n_s$ as it is determined only by the latter. Similarly, one (or multiple) steep step(s) in the potential can lead to a strongly enhanced oscillating power spectrum~@Kefala:2020xsx @Inomata:2021uqj @Dalianis:2021iig @Inomata:2021tpx @Cai:2021zsp.


All models discussed above contain a feature in the potential. An alternative is to keep the potential simple and featureless but modify the gravitational component of the action beyond a simple non-minimal coupling. Examples of these models include $F ( R )$ gravity~@Frolovsky:2022ewg, Dirac-Born-Infeld inflation~@Ballesteros:2018wlw, a non-minimal derivative coupling between the inflaton and gravity~@Fu:2019ttf @Fu:2019vqc @Heydari:2021gea @Heydari:2021qsr, Gauss-Bonnet inflation~@Kawai:2021edk, warm inflation~@Arya:2019wck @Bastero-Gil:2021fac, axion inflation with gauge fields~@Ozsoy:2020kat, $G$- or $k$-inflation~@Solbi:2021wbo @Solbi:2021rse @Teimoori:2021pte. Typically, in these models, the enhancement of the power spectrum arises due to its modified expression, which, apart from the potential, also depends on the extra non-minimal functions of the scalar field.


To sum up, inflationary models used for PBH production can be classified into two general categories:


+ Models where the (Einstein frame) inflationary potential contains a feature. These, in turn, can be subdivided into three categories:

  - Small local maximum (which includes upward steps and quasi-inflection points)~@Kannike:2017bxn @Ballesteros:2017fsr @Ballesteros:2020qam @Garcia-Bellido:2017mdw @Di:2017ndc @Hertzberg:2017dkh @Kuhnel:2019xes @Bhaumik:2019tvl @Ng:2021hll @Germani:2017bcs @Motohashi:2017kbs @Ezquiaga:2017fvi @Drees:2019xpp @Rasanen:2018fom @Cicoli:2018asa @Ozsoy:2018flq @Cicoli:2022sih @Ballesteros:2019hus @Dalianis:2018frf @Dalianis:2019asr @Ragavendra:2020sop @Iacconi:2021ltm @Gao:2018pvq @Nanopoulos:2020nnh @Stamou:2021qdk @Wu:2021zta @Atal:2019cdz @Atal:2019erb @Mishra:2019pzq @Zheng:2021vda @Rezazadeh:2021clf @Wang:2021kbh @Cai:2021zsp

  - Downward steps~@Kefala:2020xsx @Inomata:2021uqj @Dalianis:2021iig @Inomata:2021tpx

  - Rolling through the global minimum~@Yokoyama:1998pt @Saito:2008em @Bugaev:2008bi @Fu:2020lob

  - Potentials with multiple features stacked on top of each other, for instance, rapid oscillations~@Cai:2019bmk (see also~@Tasinato:2020vdk).

+ Modified gravity (beyond non-minimally coupled inflaton) with features in terms other than the inflaton potential or the non-minimal coupling~@Frolovsky:2022ewg @Ballesteros:2018wlw @Fu:2019ttf @Fu:2019vqc @Heydari:2021gea @Heydari:2021qsr @Kawai:2021edk @Arya:2019wck @Ashoorioon:2019xqc @Bastero-Gil:2021fac @Ozsoy:2020kat @Solbi:2021wbo @Solbi:2021rse @Teimoori:2021pte.


The general behaviour of the power spectrum during the rapid transition from SR inflation to non-attractor inflation is of great importance for the resulting PBH phenomenology. Consequently, it is desirable to have analytic models for said behaviour. This is possible if one considers toy models in which the evolution of SR parameters is postulated instead of derived from solving the field equations. For example, in~@Byrnes:2018txb it was shown that in single-field inflation, independently of the shape of the inflaton potential, the steepest possible growth of the primordial power spectrum is $n_s - 1 = 4$, or equivalently, $k^4$, with $k$ being the comoving scale. A further refined analysis~@Carrilho:2019oqg, however, showed that a steeper $k^5 (log k)^2$ growth can be possible (see also~@Cai:2019bmk @Liu:2020oqe @Ozsoy:2019lyy @Ballesteros:2020sre @Ragavendra:2020sop @Tasinato:2020vdk @Ng:2021hll @Ozsoy:2021pws). However, growth steeper than $k^4$ will not have any measurable impact on the PBH mass function~@Cole:2022xqc and, as we will show, requires an initial phase of inflation with a blue-tilted spectrum.


In this paper, we consider the general class of single-field inflation models in which an Einstein frame can be defined. We outline the essential qualitative features of these scenarios and propose a novel, analytically solvable model capable of capturing these features. Our analytic method uses the Wands duality~@Wands:1998yp between the USR and the subsequent constant-roll (CR) (or SR) phase, which is present in most single-field models for PBHs. Thus, it improves upon existing analytic approaches built around specific ansätze for the second SR parameter~@Byrnes:2018txb @Carrilho:2019oqg @Cole:2022xqc. Moreover, we show that our analytic model corresponds to a continuous potential constructed by gluing together two parabolas and can thus be seen as a limiting case of realistic inflationary scenarios. It can also be thought of as a generalization of the Starobinsky model~@Starobinsky:1992ts, in which the potential consists of two linear segments with different slopes. Although we will not consider models with multiple features, the proposed analytic approach can be straightforwardly generalized to include such scenarios.


Having approximate analytic tools at hand is beneficial not only for theoretical studies but also for inflationary model building and PBH phenomenology. Using various shapes for the power spectra, we analyse the potential of future GW experiments for probing the GW background induced by the large scalar perturbations in single-field inflation, showing that the windows where the PBHs could constitute all DM and where they could contribute to the LIGO-Virgo GW events, can be probed with the future GW interferometers and pulsar timing arrays, respectively~@Saito:2008jc @Assadullahi:2009jc @Bugaev:2010bb @Alabidi:2012ex @Inomata:2016rbd @Orlofsky:2016vbd @Espinosa:2018eve @Inomata:2018epa @Byrnes:2018txb @Cai:2018dig @Bartolo:2018rku @Wang:2019kaf @Yuan:2019udt @Chen:2019xse @Lewicki:2021xku. These analytical tools can also be applied to improve limits on heavy PBH scenarios, #emph[e.g.], by using COBE/Firas $mu$-distortion constraints~@Fixsen:1996nj @Chluba:2012we @Chluba:2013dna.


The paper is structured as follows: @sec:theory outlines the general mathematical framework of inflation, cosmological perturbations and the general phases of single-field inflationary models for PBHs. In @sec:insta, we introduce the instantaneous SR to USR approximation, derive the corresponding analytic curvature power spectrum, and construct the corresponding inflationary potential. Non-instantaneous SR to USR transitions and the application of our analytic approximations to the study of spectra for general potentials are discussed in @sec:spectrum_approximation. @sec:pheno deals with the resulting PBH and GW phenomenology. We conclude in @sec:concl. We use natural units $c = ℏ = 1$.


= General considerations
<sec:theory>


Inflationary PBH production within single-field inflation typically requires for inflation to proceed in two or more phases of SR or constant-roll (CR), separated by a brief exit from SR and a transient USR phase. The latter is responsible for the super-horizon enhancement of the scalar modes that exited the cosmological horizon around this transient phase~@Leach:2000yw @Leach:2001zf and will ultimately determine the position and height of the peak in the power spectrum responsible for PBH creation. The slope of the enhanced peak at the end of the USR phase generally mimics the spectrum created in the subsequent CR phase due to the Wands duality~@Wands:1998yp. This makes it possible to infer the qualitative features of the power spectrum, #emph[e.g.], the height and the position of the generated peak, from background evolution alone, similarly to SR inflation. However, an accurate estimate of the shape of the peak requires a numerical approach to the evolution of individual modes, #emph[i.e.], via applying the Mukhanov-Sasaki (MS) equation.


== Background evolution in single-field inflation
<background-evolution-in-single-field-inflation>


In the Einstein frame, single-field inflation is described by the following action:


$ cal(S) = integral upright(d) x^4 sqrt(- g) (M_(upright(P))^2 / 2 R - 1 / 2 partial^mu phi.alt partial_mu phi.alt - V ( phi.alt )) thin , $<eq:S_standard>


where $R$ is the Ricci scalar, $V ( phi.alt )$ is the inflaton potential and $M_(upright(P))$ the reduced Planck mass. We consider a flat FLRW background geometry $upright("ds")^2 = - upright("dt")^2 + a^2 upright(d) x_i^2$, where $a$ is the scale factor. The evolution of the scale factor and the inflaton are governed by the Friedmann equation $3 M_(upright(P))^2 H^2 = dot(phi.alt)^2 / 2 + V ( phi.alt )$, and the Klein-Gordon equation $dot.double(phi.alt) + 3 H dot(phi.alt) + V' = 0$, respectively. The overdot indicates differentiation with respect to the cosmic time $t$, a prime denotes differentiation with respect to the scalar field $phi.alt$ and $H equiv dot(a) / a$ is the Hubble parameter. This approach includes all models in which the Einstein frame exists, #emph[e.g.], non-minimally coupled inflatons or non-canonical inflaton kinetic terms. Theories with higher-order Einstein frame kinetic terms, such as $( partial phi.alt )^4$, may be approximated by this class, if these higher-order terms are subdominant even when SR is violated, #emph[e.g.], as in Palatini $R^2$ gravity~@Enckell:2018hmo @Antoniadis:2018ywb @Tenkanen:2020cvw @Karam:2021sno. Permitting disformal transformations~@Bekenstein:1992pj @Minamitsuji:2014waa @Tsujikawa:2014uza @Domenech:2015hka, this also includes some Horndeski theories~@Sato:2017qau @Gialamas:2020vto.


In the following, we will measure time in $e$-folds, $N equiv ln a$. The field equations can be then be recast as


$ partial_N y + (3 - y^2 / 2) (y + M_(upright(P)) V' / V) = 0 , #h(2em) y equiv frac(partial_N phi.alt, M_(upright(P))) thin , $<eq:eom_inf_N>


and the Hubble parameter can be expressed as a function of $phi.alt$ and $y$ via $M_(upright(P))^2 H^2 = V ( phi.alt ) ( 3 - y^2 / 2 )^(- 1)$. The SR approximation is obtained by ignoring the $partial_N y$ term in @eq:eom_inf_N and the field equations are given by setting the last bracket in @eq:eom_inf_N to zero, #emph[i.e.] , $y + M_(upright(P)) partial_phi.alt ln V = 0$. SR and deviations from it are conveniently described in terms of the Hubble SR parameters


$ epsilon.alt_H equiv 1 / 2 y^2 = - dot(H) / H^2 thin , #h(2em) eta_H = - partial_N ln y + epsilon.alt_H = - frac(dot.double(H), 2 H dot(H)) thin . $<HRSPs>


Inflation occurs as long as $epsilon.alt_H < 1$, while the SR approximation holds as long as both SR parameters are small ($epsilon.alt_H , eta_H lt.double 1$). For future reference we will also define the potential SR parameters


$ epsilon.alt_V equiv M_(upright(P))^2 / 2 (V' / V)^2 thin , #h(2em) eta_(upright(V)) equiv M_(upright(P))^2 thin V'' / V thin thin , $<PRSPs>


which satisfy $epsilon.alt_V approx epsilon.alt_H thin , eta_V approx eta_H + epsilon.alt_H thin$ at the leading order in SR.


== Evolution of the curvature perturbations
<sec:perturbation_evolution>


The evolution of the scalar curvature perturbation $cal(R)_c$ is conveniently studied using the so-called Mukhanov field $u equiv z cal(R)_c$, where


$ z equiv a dot(phi.alt) / H = a y M_(upright(P)) thin . $


The Fourier modes of $u$ evolve according to the MS equation~@Mukhanov:1985rz @Sasaki:1986hm @Mukhanov:1990me,


$ u''_k + (k^2 - z'' / z) u_k = 0 thin , $<eq:MS>


where the prime denotes differentiation with respect to conformal time#footnote[Not to be confused with $V'$ in which case the prime corresponds to a derivative with respect to the field.], $upright(d) tau = upright("dt") / a$. The second term in the parenthesis of the MS equation @eq:MS is recast in terms of the SR parameters as#footnote[In terms of the higher-order Hubble SR parameters, $epsilon.alt_(i + 1) equiv partial_N ln epsilon.alt_i$ with $epsilon.alt_1 equiv epsilon.alt_H$, the effective mass can be recast as $z'' / z = cal(H)^2 (2 - epsilon.alt_1 + 3 epsilon.alt_2 / 2 - epsilon.alt_1 epsilon.alt_2 / 2 + epsilon.alt_2^2 / 4 + epsilon.alt_2 epsilon.alt_3 / 2)$. In @eq:zpp, $epsilon.alt_2$ is replaced with $eta_H$, while $epsilon.alt_3$ is eliminated using @eq:eom_inf_N in favor of the potential SR parameter $eta_V$.]


$ z'' / z & = cal(H)^2 [2 - (3 - epsilon.alt_H) eta_V + epsilon.alt_H (5 + 2 epsilon.alt_H - 4 eta_H)] thin , $<eq:zpp>


where $cal(H) equiv a' / a = a H$. We stress that this expression is exact to all orders in the SR parameters. In the SR phase, the SR parameters are small, implying $z'' / z approx 2 cal(H)^2$. The limits $k^2 gt.double z'' / z$ and $k^2 lt.double z'' / z$ correspond to the sub-horizon and super-horizon evolution of the mode, respectively. Both $z$ and $z'' / z$ are monotonously growing functions during SR, so these limits occur at $N arrow.r - oo$ and $N arrow.r + oo$, respectively. However, if the inflationary universe contains a SR-violating phase such as USR, which is generally needed for producing a non-negligible PBH abundance, then $z$ may temporarily decrease, affecting the modes that exit the horizon around that time. Nevertheless, both $z$ and $z'' / z$ will still be monotonously growing functions of time in the asymptotic past and future.


In the sub-horizon regime, when $k^2 gt.double z'' / z$, the effect of the curvature of spacetime is negligible and thus the mode $u_k$ behaves as a free field on flat spacetime. In the Bunch-Davies vacuum, the normalized solution asymptotes to


$ u_k = 1 / sqrt(2 k) e^(- i k tau) thin $<eq:BD_cond>


in the limit $tau arrow.r - oo$. This serves as the initial condition for the MS equation.


// [figvision-cn] imgs/realistic_example_grid.png
// 这是一幅包含三行三列共九个面板的科学论文插图，按列分为
// 模型 I、模型 II 和模型 III，按行显示不同物理量随演化参
// 数的变化。图中垂向色带在所有面板中含义一致：绿色带（标
// 注为 USR）对应超慢滚（Ultra-Slow-Roll）阶段，浅黄色带
// 对应从慢滚（SR）进入 USR 的过渡阶段，浅绿色带对应从
// USR 退出进入后续恒定滚（CR）阶段的过渡阶段；灰色竖直虚
// 线标注为 CMB，表示宇宙微波背景对应的尺度。 第一行子图
// （a、b、c）为曲线图，分别对应模型 I、II、III。纵轴为 \
// (V/V_{\rm CMB}\)，线性标度，范围从 0 到 1.3 左右，表示
// 势能相对于 CMB 尺度的归一化值；横轴为 \(\phi/M_P\)，线
// 性标度，表示暴胀场以普朗克质量为单位的值。模型 I 的横
// 轴范围约为 0 到 7.5，曲线从约 0.05 起步，在 \(\phi/M_P
// \approx0.5\) 前有一段接近平坦的平台（对应 USR，有绿色
// 竖带并标注 USR），随后平滑上升至约 1.05；CMB 虚线在横
// 轴约 6.5 处。模型 II 的横轴范围约为 0 到 6.5，曲线在 \
// (\phi/M_P\approx1.5\) 前为接近零的平台（带标注 USR），
// 随后上升至约 1.02，CMB 虚线在约 5.8 处。模型 III 的横
// 轴范围约为 0 到 3.5，主曲线在约 0.7 之前上升，之后出现
// 一个极窄的台阶，图中另用局部放大插图（虚线框指示放大区
// 域）展示该台阶：放大框内可见 USS 带（绿色竖带）覆盖的
// 台阶结构，出台阶后曲线在约 1 附近缓升，CMB 虚线在约
// 3.1 处。 第二行子图（d、e、f）为曲线图，分别对应三个模
// 型，展示标量功率谱。纵轴为 \(\mathcal{P}_{\mathcal{R}}
// (k)\)，对数标度，范围从 \(10^{-13}\) 到约 \(10^{-1}\)；
// 横轴为 \(k/{\rm Mpc}^{-1}\)，对数标度，范围从约 \(10^{
// -3}\) 到 \(10^{24}\)。顶部横轴为 \(M_{\rm PBH}/{\rm g}
// \)，对数标度，范围从 \(10^{50}\) 到 1，对应 PBH 质量。
// 谱线在低 k 端近似平坦（约 \(10^{-9}\)），随后出现一个
// 深谷，在 CMB 虚线（k 约 0.05 Mpc⁻¹）左侧；深谷后谱线急
// 剧上升，在 USR 色带（k 约 \(10^{10}\)–\(10^{13}\) Mpc⁻
// ¹）内达到峰值，三个模型的峰值分别约为 \(10^{-1}\)、\(
// 10^{-2}\)、\(10^{-2}\)；之后谱线快速下降，在 k 约 \(10
// ^{15}\)–\(10^{20}\) Mpc⁻¹ 处出现第二个下凹，再趋于平缓。
// 对应图注说明，USR 色带标出了产生小行星质量窗口 PBH 的
// 尺度范围（顶部横轴显示该尺度对应的 PBH 质量约在 \(10^{
// 17}\)–\(10^{21}\) g 之间）。 第三行子图（g、h、i）为三
// 条曲线叠加的曲线图，分别对应三个模型，展示背景演化量随
// e 折数 N 的变化。纵轴为线性标度，范围约从 -5 到 5；横
// 轴为 \(N\)，线性标度，范围从 -5 到 60。三条曲线：蓝色
// 曲线表示 \(\mathcal{H}^{-2} z''/z\)，在本图例范围内大
// 部分为约 2 的水平段，在 USR 阶段（绿色带，N 约 33–36）
// 出现剧烈尖峰并迅速回落；红色曲线表示 \(\eta_H\)，大部
// 分在 0 附近，在 USR 阶段出现一个向上的尖峰然后快速下降
// 至负值；黄色曲线表示 \(\epsilon_H\)，在大部分区间约等
// 于 0，在 USR 阶段出现一个窄峰。三个模型的尖峰位置略有
// 差异：模型 I 的尖峰在 N≈34–36，模型 II 在 N≈33–36，模
// 型 III 在 N≈34–37；模型 III 在 N≈50 处还出现另一次较弱
// 的蓝色曲线尖峰。图中所有标注文字包括各列顶部模型名、行
// 内 USR 与 CMB 标注、第三行图例中的公式，以及顶部和右侧
// 的坐标轴标签和刻度。总体趋势为：三个模型均通过一个窄的
// USR 阶段产生功率谱尖峰，对应小行星质量窗口的 PBH 形成，
// 同时背景量在该阶段出现短暂的剧烈变化。
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

#figure(image("imgs/realistic_example_grid.png", width: 93.0%),
  caption: [
    Examples of three inflationary models from the literature producing PBHs in the asteroid mass window~@Kannike:2017bxn @Ballesteros:2017fsr @Ballesteros:2020qam @Dalianis:2018frf @Mishra:2019pzq. The models and their parameters are detailed in @app:examples. The vertical bands correspond to different non-SR epochs: the USR epoch (green), the transition from SR to USR (yellow) and the transition out of USR to the subsequent CR phase (light green). For the power spectrum, they highlight the modes that exited during the corresponding epoch. The dashed vertical line corresponds to the CMB scale. The dotted vertical line in the top panel corresponds to the end of inflation; in the other panels, the end of inflation coincides with the right edge of the plot. In the bottom panel, $N$ denotes the number of e-folds of expansion starting from the CMB scale. All three potentials exhibit a local maximum around the USR scales.
  ]
)
<fig:example_models>



In the super-horizon regime, that is when $k^2 lt.double z'' / z$, the general solution $u_k = A_(1 , k) u_0^(( 1 )) + A_(2 , k) u_0^(( 2 ))$ comprises a mode that grows during SR, here $u_0^(( 1 ))$, and a decaying mode $u_0^(( 2 ))$, given by


$ u_0^(( 1 )) prop z , #h(2em) u_0^(( 2 )) prop z integral_tau^0 frac(upright(d) tau', z ( tau' )^2) . $<eq:SH_modes>


The former will eventually dominate. Consequently, the amplitude of the curvature perturbations is frozen, that is, $\| cal(R)_(c thin k) \| = lr(|u_k / z|) = upright("const")$. As alluded to above, if SR is momentarily violated in such a way that $z$ starts to decrease, then the growing and decreasing $u_k$ modes can be mixed. Therefore, the second mode may come to dominate temporarily, potentially leading to super-horizon evolution of $cal(R)_c$\; however, eventually $z$ starts to grow again and $cal(R)_c$ freezes. This makes it possible to relate the observable perturbations at horizon re-entry with the perturbations produced during inflation while being ignorant about the details of the reheating phase.


The primordial power spectrum is evaluated after horizon crossing


$ cal(P)_(cal(R)) = frac(k^3, 2 pi^2) frac(\| u_k \|^2, z^2)\|_(cal(H) gt.double k) approx^(upright("SR")) frac(H^2, 8 pi^2 M_(upright(P))^2 epsilon.alt_H)\|_(k = cal(H)) thin , $<eq:PR_from_u>


where the second expressions shows the result at leading order in the SR approximation, in which case $\| u_k \|^2 arrow.r ( cal(H) / k )^2 / ( 2 k )$ and $y$ are evaluated at horizon crossing, #emph[i.e.] , when $k = cal(H)$. During SR, the Hubble SR parameters~@HRSPs can be replaced by the potential ones~@PRSPs, and the scalar spectral index $n_s$ and the tensor-to-scalar ratio $r$ are given by the well known expressions


$ n_s approx 1 + 2 eta_V - 6 epsilon.alt_V thin , #h(2em) r approx 16 epsilon.alt_V thin , $<eq:SR_ns_and_r>


at the leading order in SR. The curvature power spectrum is relatively unconstrained, except at scales relevant for the CMB. The latest observational constraints~@Planck:2018jri @BICEP:2021xfz imply


$ A_s & = ( 2.10 plus.minus 0.03 ) times 10^(- 9) , quad n_s = 0.9649 plus.minus 0.0042 , quad r < 0.036 #h(2em) $<eq:CMB_observables>


at the scale $k_(upright("pivot")) = 0.05 med upright("Mpc")^(- 1)$ and at $68 "%"$ CL for $A_s$ and $n_s$ and $95 "%"$ for $r$. When running of $n_s$ is permitted, the constraints are slightly relaxed to $n_s = 0.9625 plus.minus 0.0048$. Throughout this paper, we will fix $A_s equiv cal(P)_(cal(R)) ( k_(upright("pivot")) ) = 2.1 times 10^(- 9)$, when the power spectrum predictions involve the CMB scales.


== Phases of single-field inflation for PBHs
<sec:phases>


In the models under consideration, we identify the following phases of inflation:

/ SR: #block[
We will consider models in which inflation begins with a #emph[SR phase].#footnote[Although other types of initial inflationary phases are permissible and would not significantly affect our results, we will label this initial phase as SR for definiteness.] At almost all times during this phase, the SR parameters remain small $epsilon.alt_H , \| eta_H \| lt.double 1$ and $eta_H$ slightly negative. For definiteness, we define the initial SR phase via the conditions $ \| epsilon.alt_H \| , thin \| eta_H \| , thin \| epsilon.alt_3 \| < 1 thin , $<eq:SR_cond> where $epsilon.alt_3 equiv partial_N ln ( epsilon.alt_H - eta_H )$ denotes the third SR parameter, which takes large values in particular when $eta_H$ changes rapidly. With these conventions, we find that the initial SR phase typically ends by violating the $\| epsilon.alt_3 \| < 1$ condition in PBH models. Note the enhancement of modes that exit at the end of the SR phase in @fig:example_models. This is due to super-horizon effects induced during the subsequent phases~@Leach:2001zf, that is, the breakdown of the SR approximation for the power spectrum @eq:PR_from_u begins already during the SR phase.
]

/ T1: #block[
The next phase is the #emph[transition from SR to USR], which we label as T1. This phase is initiated by a feature in the potential that triggers the exit from SR, that is, its onset is signalled by the violation of any of the SR conditions @eq:SR_cond. Typically, it is characterized by $ \| epsilon.alt_3 \| > 1 thin , $ so that at the beginning of this phase, $epsilon.alt_3 = - 1$ and $eta_H$ starts to increase rapidly. When $epsilon.alt_H - eta_H = 0$, $epsilon.alt_3$ diverges and changes sign. The phase ends when $epsilon.alt_3$ decreases to $1$. During this period, $cal(H)^(- 2) z'' / z < 0$ has a sharp dip, as can be observed in @fig:example_models in which the T1 phase is indicated by yellow bands. As can be seen in the upper panels of @fig:example_models, the field excursions during this transition tend to be larger than in the following phases. However, as the field is rapidly moving, it's generally much shorter than any other phase. The variations in model building tend to affect this phase the most. On top of the models considered in @fig:example_models, all of which contain a small local maximum in the potential, this phase can entail rolling through the global minimum~@Yokoyama:1998pt @Saito:2008em @Bugaev:2008bi or falling down from steep steps in the potential~@Kefala:2020xsx @Inomata:2021uqj @Dalianis:2021iig @Inomata:2021tpx @Cai:2021zsp. Inflation may end ($epsilon.alt_H > 1$) briefly during this phase (however, it does not in models shown in @fig:example_models).
]

/ USR: #block[
The #emph[USR period] starts when the field begins to slow down at a plateau or a hillside in the potential (see examples in @fig:example_models). Since $V' lt.tilde 0$ and $epsilon.alt_H lt.double 1$, @eq:eom_inf_N implies that $partial_N y + 3 y lt.tilde 0$ and thus $eta_H gt.tilde 3$ (see discussion below). Throughout this phase, $eta_H$ is approximately constant, and $epsilon.alt_H prop a^(- 2 eta_H)$ decreases rapidly#footnote[We remark that sometimes the term USR implies a specific growth $epsilon.alt_H prop a^(- 6)$. Here we do not make this restriction. In particular, the equation $dot.double(phi.alt) + 3 H phi.alt approx 0$ holds only when $eta_H = 3$. When $eta_H > 3$, the field is not oblivious to the potential and gets slowed down both by Hubble friction and rolling up the potential.]. The USR phase, depicted by a green band in @fig:example_models, is quite brief, typically lasting for a few $e$-folds. The peak of the spectrum consists typically of modes that exited during this phase.
]

/ T2: #block[
The #emph[dual USR to CR transition], which we label as T2, is characterized by a sharp decline of $eta_H$. Like T1, we define it via the condition $\| epsilon.alt_3 \| > 1$. However, unlike in T1, now also always $epsilon.alt_H lt.double 1$. In @fig:example_models, this phase is denoted by a light green band. One can observe that $cal(H)^(- 2) z'' / z$ remains constant throughout this phase---because the background evolution enters the MS equation @eq:MS only through this quantity, the evolution of the $u_k$ modes is unaffected by this transition, and no discernible features are generated in the spectrum during this period.
]

/ CR: #block[
The final #emph[CR period] begins when $\| epsilon.alt_3 \| < 1$. It is characterized by an almost constant and negative second SR parameter, $eta_H < 0$. Note that if $\| eta_H \| lt.double 1$, this can be considered a second period of SR inflation. Nevertheless, we will use the label CR throughout the article. Note that $cal(H)^(- 2) z'' / z$ stays constant throughout the USR, T2 and CR phases, indicating that the CR phase is dual to the USR phase. Since the curvature power spectrum during this phase can be estimated analytically, one can use the duality to infer parts of the spectrum in the two earlier phases. In models considered in the literature (#emph[e.g.], Model I and II in @fig:example_models), this CR phase often lasts until the end of inflation. However, there can be another phase of SR inflation after the CR phase (#emph[e.g.], Model III in @fig:example_models).
]


The potentials, the power spectra and the evolution of the background quantities $cal(H)^(- 2) z'' / z$, $epsilon.alt_H$, and $eta_H$ for three example models are shown in @fig:example_models (for details, see @app:examples). We highlight the regions T1, USR, and T2 by yellow, green and light green bands, respectively (this colour convention will be followed throughout the paper).


In all cases, we observe that $cal(H)^(- 2) z'' / z$ is constant throughout the USR, T2 and CR phases, implying that these phases are dual~@Wands:1998yp and relating the spectra produced during the USR and CR periods. To understand this duality better, note that the MS equation depends on the background evolution only via the quantity $z'' / z$. Analogously to @eq:SH_modes, there are also two independent realizations of $z$, corresponding to two independent expansion histories, that will result in mathematically identical MS equations. In an inflating background, one of these will be exponentially increasing, corresponding to the SR or CR phase, while the other is exponentially decreasing---it will describe a USR like phase that is dual to the CR phase. This simple feature lies at the centre of the theory of peaks in the power spectra from single-field inflation.


The duality dictates that dual phases share the same solutions for $u_k$. The particular solution $u_k$, coming from the initial conditions, stays the same as it evolves through the dual phases. Let us take a closer look at super-horizon evolution during the USR phase. As these modes have exited the horizon, $u_k$ is a superposition of $u_0^(( 1 ))$ and $u_0^(( 2 ))$ given @eq:SH_modes and does not necessarily have to follow $z$ which is temporarily decaying during the USR phase. If the $u_k$ follows $u_0^(( 2 ))$, then the curvature perturbation $cal(R)_(c thin k) = u_k / z$ may be enhanced. We will return to this point later (#emph[e.g.], see @fig:mode_evolution).


On a more quantitative note, consider the behaviour of the field as it rolls over a small maximum in the potential during the USR+T2+CR phases. To a good approximation, we can assume that $epsilon.alt_H lt.double 1$. Expanding the potential around the maximum $phi.alt = phi.alt_(upright(m))$, the background evolves as~@eq:eom_inf_N


$ partial_N^2 phi.alt + 3 partial_N phi.alt + 3 eta_V ( phi.alt_(upright(m)) ) (phi.alt - phi.alt_(upright(m))) approx 0 thin , $<eq:phi_max_eom>


where $eta_V ( phi.alt_m )$ is the second potential SR parameter at the maximum. This term is typically of the same order as the first two and cannot be neglected in general. The field thus evolves as


$ phi.alt - phi.alt_(upright(m)) = a^(- 3 / 2) (phi.alt_(+) e^(lambda N) + phi.alt_(-) e^(- lambda N)) thin , #h(2em) lambda equiv 3 / 2 sqrt(1 - 4 / 3 eta_V ( phi.alt_(upright(m)) )) thin , $<eq:phi_max_solution>


where $phi.alt_plus.minus$ are constant coefficients. Since $eta_V ( phi.alt_(upright(m)) ) lt.eq 0$ at a maximum, we have $lambda gt.eq 3 / 2$. The '$-$' branch describes the USR phase with $epsilon.alt_H prop a^(3 - 2 lambda)$ and the '$+$' branch the CR phase with $epsilon.alt_H prop a^(3 + 2 lambda)$. Importantly, ignoring small changes in $H$, we find that


$ cal(H)^(- 2) z'' / z = lambda^2 - 1 / 4 $<eq:zpp_max_solution>


is constant as the field rolls over the maximum, independently of $phi.alt_plus.minus$. This indicates the duality between the corresponding USR and CR phases (and that the T2 phase does not need any special attention). For instance, $eta_V ( phi.alt_(upright(m)) ) lt.double 0$ gives the usual SR and the most typical USR behaviour ($epsilon.alt_H prop a^(- 6)$ or, equivalently, $dot.double(phi.alt) + 3 H dot(phi.alt) approx 0$), indicating that that the dual of SR is USR with $epsilon.alt_H prop a^(- 6)$. This behaviour is expected if the PBH-generating feature in the potential is not a maximum, #emph[e.g.], the USR phase during which the field slows down takes place on a plateau with a negligible slope and curvature.


We stress that all the listed phases are present in single-field models for PBHs considered here, and, strictly speaking, one should not credit a single phase for the peak in the power spectrum. Although the power spectrum reaches its height for modes that exited during the USR phase in quasi-inflection point models shown in @fig:example_models, the evolution of these modes is critically affected by the previous T1 phase, and the spectrum is also tightly linked to the following CR phase via the Wands duality. In models with downward steps~@Kefala:2020xsx @Inomata:2021uqj @Dalianis:2021iig @Inomata:2021tpx @Cai:2021zsp, in which the enhancement is dominantly due to the \"fast\" rolling of the inflaton at the step, the downward step is preceded by a USR phase, during which the field slows down by Hubble friction, and finally transitions to an SR phase (or, by our current conventions, to a CR phase) dual to the USR. As an exception, in models with multiple features appearing in rapid succession, the phases listed above may overlap or interact with each other in a non-trivial way~@Tasinato:2020vdk leading to qualitative differences from the scenarios considered here.


= The instantaneous transition approximation
<sec:insta>


Typical models of single-field inflation producing peaks in the power spectrum exhibit a rapid transition from the initial SR phase to the subsequent USR like phase, as is also illustrated in @fig:example_models. The approximation in which this transition is instantaneous can be described by the ansatz $ 1 / cal(H)^2 z'' / z = - cal(A) delta ( N - N_c ) + cases(
    lambda_1^2 - 1 / 4 , & quad N < N_c,
    lambda_2^2 - 1 / 4 , & quad N > N_c
  ) thin , $<eq:insta> where $N_c$ is the moment of the transition and $cal(A)$ is a positive constant. The delta peak is added to describe the 'dip' in $cal(H)^(- 2) z'' / z$ visible in the examples of @fig:example_models. We can shift the $N$ and set $N_c = 0$. Informed by @eq:zpp_max_solution, we included the terms $- 1 / 4$ to simplify later expressions. Imposing continuity, the ansatz @eq:insta implies that $ z = cases(
    zeta_1 e^(( lambda_1 - 1 / 2 ) ( N - N_c )) thin , & quad N < N_c,
    zeta_2 e^(( lambda_2 - 1 / 2 ) ( N - N_c )) + ( zeta_1 - zeta_2 ) e^(( - lambda_2 - 1 / 2 ) ( N - N_c )) thin , & quad N > N_c
  ) thin , $<eq:z_toy> with the coefficients $zeta_i$ related by $cal(A) = lambda_1 + (1 - 2 zeta_2 / zeta_1) lambda_2$. We assumed that the geometry is almost de Sitter during inflation and took $H$ to be constant. As we will show explicitly below, $lambda = 3 / 2$ leads to exact de Sitter behaviour with a scale-invariant power spectrum, while $lambda > 3 / 2$ ($lambda < 3 / 2$) correspond to red-tilted (blue-tilted) power spectra.


The ansatz @eq:insta can be intuitively understood via mechanical analogues: The parameter $z$ is initially exponentially growing until it receives a kick with strength $cal(A)$ that slows it down. Strong kicks can invert the velocity and produce a period in which the decaying $z$ mode can dominate, that is, USR. Furthermore, since @eq:insta appears in the MS equation~@eq:MS, similar reasoning holds for all $u_k$ modes. The main difference is that when $k$ is large enough, the modes will oscillate instead of growing or decaying, weakening the kick's effect on their amplitude.


To quantify the inflationary evolution during the different epochs, we compute the second SR parameter, $eta_H approx 1 - partial_N ln \| z \|$, where we neglected $epsilon.alt_H approx 0$. To a good approximation, USR transitions to CR when $eta_H = 1$ (or equivalently $partial_N z = 0$), thus the duration of the USR phase is


$ Delta N_(upright("USR")) approx frac(1, 2 lambda_2) ln [frac(lambda_2 + 1 / 2, lambda_2 - 1 / 2) (zeta_1 / zeta_2 - 1)] thin . $<eq:N_USR>


A long USR period with a boosted power spectrum corresponds to $\| zeta_2 \| lt.double \| zeta_1 \|$ implying that $cal(A)$ in @eq:insta is tuned to lie slightly below $lambda_1 + lambda_2$. Outside the transitions, different terms in @eq:z_toy dominate, and we obtain CR inflation with#footnote[The fact that the Universe passes through different CR phases according to @eq:etaH_regions can be used to construct an ansatz for $eta_H$ for which the curvature power spectrum can be analytically obtained~@Byrnes:2018txb. An ansatz on $eta_H$ instead on $z'' / z$, however, will fail to capture the Wands duality between the last two phases and thus it will introduce additional numerical artefacts into the power spectrum. As we show in the following, the ansatz @eq:insta of $z'' / z$ results from a specific potential and the modulation of the curvature power spectrum can, in our case, be traced back to sharp jumps in the first derivative of this potential.] $ eta_H approx cases(
    3 / 2 - lambda_1 thin , & quad N < N_c & #h(2em) upright("(SR phase)"),
    3 / 2 + lambda_2 thin , & quad N_c < N < N_c + Delta N_(upright("USR")) & #h(2em) upright("(USR phase)"),
    3 / 2 - lambda_2 thin , & quad N gt.double N_c + Delta N_(upright("USR")) & #h(2em) upright("(CR phase)")
  ) thin , $<eq:etaH_regions> as illustrated in @fig:delta_sketches. In the typical scenarios discussed above (see @fig:example_models), we have $lambda_1 approx 3 / 2$, leading to an initial SR phase with $eta_H approx 0$, and $lambda_2 gt.tilde 3 / 2$, leading to USR with $eta_H gt.tilde 3$ and a final CR phase with $eta_H lt.tilde 0$.


The ansatz @eq:insta guarantees the Wands duality between the intermediary USR regime and the final CR. It has the following consequences: First, the respective second SR parameters satisfy


$ eta_(H , upright(U) S R) + eta_(H , upright("CR")) = 3 thin , $


as can be seen from @eq:etaH_regions. This follows from the fact that $cal(H)^(- 2) z'' / z$ is the same for both phases, as shown in @fig:delta_sketches, linking the two $z$ modes in the $N > N_c$ region. Second, since the MS equation~@eq:MS depends only on the combination $cal(H)^(- 2) z'' / z$, this has important implications for the curvature power spectrum---the spectral properties of curvature fluctuations generated during the USR and the subsequent CR phase are nearly identical. As stated above, the duality is not limited to the simplified model @eq:z_toy, but applies to all models in which the peak in the power spectrum is generated when the inflaton rolls over a plateau or a smooth local maximum of its potential, as illustrated in @fig:example_models. The main simplification in the ansatz @eq:insta lies in the introduction of the delta function that enforces an instantaneous SR to USR transition.


// [figvision-cn] imgs/delta_sketches.png
// 本图由三个并排的子图组成，从左至右依次为a、b、c。三个
// 子图共享相同的横轴变量N（未标注具体数值范围与单位，仅
// 标注原点在左端），并在N=N_c处画有一条竖直黄色虚线，该
// 虚线右侧为浅绿色与亮绿色交替的竖直条带区域（条带宽度相
// 等，深浅绿色循环出现），在此区域顶部标注“USR”；这三个
// 子图的绿色条带配色完全一致。以下逐图说明。 子图a：曲线
// 图。纵轴标注为“H^{-2} z''/z”，带负号与量纲符号，横轴为
// N。图中有一条深蓝色实线：当N<N_c时，曲线保持水平，其高
// 度标注为“λ₁²−1/4”；在N=N_c处，曲线垂直向下跳变（用向下
// 箭头标出），跳变后保持水平，高度标注为“λ₂²−1/4”；该水
// 平线向右延伸穿过整个USR绿色条带区及其后区域。图中另有
// 一条水平虚线，对应纵轴值0（右侧标有数字0），该虚线位于
// 两条实线水平段之间，即λ₂²−1/4 < 0 < λ₁²−1/4。横轴在N_c
// 处标有“N_c”。结论：该量在USR期间及之后保持恒定，但在
// N_c处发生从λ₁²−1/4到λ₂²−1/4的瞬时跳变。 子图b：曲线图。
// 纵轴标注为“ln|z|”，横轴为N。图中有一条深蓝色实线：当N<
// N_c时，曲线为一条斜率为正的直线段，从图左下角上升至N=
// N_c处的峰值；该峰值处有一条水平虚线向左延伸，并标注“
// log|ζ₁|”。在N=N_c处曲线不连续，随后在USR绿色条带区内迅
// 速下降至一个局部极小值（极小值位于亮绿色条带内），之后
// 转为近似线性上升，穿过浅绿色条带并延伸至图右上角，在右
// 侧边界处达到全图最高点。横轴在N_c处标有“N_c”。结论：ln
// |z|在N_c处达到log|ζ₁|后突然下降，在USR期间出现一个极小
// 值，随后持续上升。 子图c：曲线图。纵轴标注为“η_H”，横
// 轴为N。纵轴右侧标有三个刻度值：0、3/2、3（自下而上分布），
// 图中对应有三条水平虚线。深蓝色实线在N<N_c时为水平段，
// 其高度略高于0（对应标注为λ₁的竖直箭头下端）；在N=N_c处
// 曲线从该水平段的上端点（有一红色圆点标记）开始，先保持
// 近似水平（略微上升），随后在USR绿色条带区内以S形快速下
// 降，穿过3/2水平虚线，最终在亮绿色条带内降至0附近并保持
// 水平（末端有一红色圆点标记）。图中用竖直箭头标注了三个
// 量：λ₁为N_c左侧水平段到3/2虚线之间的高度差（箭头位于
// N_c左侧）；λ₂为N_c处红色圆点（高约3）到下方3/2虚线之间
// 的高度差（箭头位于USR区内）；另一个λ₂为右侧下降后曲线
// 平台（约0）到上方3/2虚线之间的高度差（箭头位于右侧浅绿
// 色条带内），即λ₂在下降前后分别对应两个不同高度区间。横
// 轴在N_c处标有“N_c”。结论：η_H在N_c处约为3，在USR期间由
// 约3快速下降至约0，下降幅度由λ₂表征，而N_c之前平台与3/2
// 的间距由λ₁表征。
#figure(image("imgs/delta_sketches.png", width: 100%),
  caption: [
    Sketches of $cal(H)^(- 2) z'' / z$ from @eq:insta, $z$ from @eq:z_toy, and $eta_H approx 1 - partial_N ln \| z \|$ in the instantaneous T1 transition model. Note that $cal(H)^(- 2) z'' / z$ stays constant throughout USR and afterwards, even though $z$ and $eta_H$ exhibit non-trivial features. The colour coding of vertical bands is the same as in @fig:example_models.
  ]
)
<fig:delta_sketches>



We now move to solve the MS equation~@eq:MS with the ansatz~@eq:insta. The general solution is $ u_k = cases(
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_1 )) [ c_(1 +) J_(- lambda_1) ( k / cal(H) ) + c_(1 -) J_(lambda_1) ( k / cal(H) ) ] thin , & quad N < N_c,
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_2 )) [ c_(2 +) J_(- lambda_2) ( k / cal(H) ) + c_(2 -) J_(lambda_2) ( k / cal(H) ) ] thin , & quad N > N_c
  ) thin , $<eq:uk> where $J_lambda$ is a Bessel function of the first kind. The Bunch-Davies vacuum implies $\| c_(1 +) \| = 1$, $c_(1 -) = - e^(- i pi lambda_1) c_(1 +)$, and the coefficients $c_(2 plus.minus)$ are determined by demanding continuity of $u_k$ at $N_c$ and setting $u'_k$ to jump there as determined by the delta function in @eq:insta. The coefficients can be expressed as


$ c_(2 plus.minus) / zeta_2 & = minus.plus frac(pi lambda_2, zeta_1) J_(plus.minus lambda_2) H_(lambda_1) + pi / zeta_2 frac(k, 2 cal(H)_c) (plus.minus J_(plus.minus lambda_2) H_(lambda_1 - 1) + J_(plus.minus lambda_2 plus.minus 1) H_(lambda_1))\|_(N = N_c) thin , $<c2PlusDelta>


where we defined $cal(H)_c equiv cal(H) ( N_c )$, omitted the argument $k / cal(H)_c$ of the Bessel and Hankel functions $J_lambda$ and $H_lambda$, and neglected an unimportant phase.


The power spectrum is computed at super-horizon scales where $k lt.double cal(H)$ so the Bessel functions in @eq:uk can be approximated with their asymptotic forms. Thus, only the coefficient of the growing mode $c_(2 +)$ enters and the power spectrum reads


$ cal(P)_(cal(R)) & = frac(k^3, 2 pi^2) \| cal(R)_c \|^2 = frac(k^2 Gamma ( lambda_2 )^2, 4 pi^3) lr(|c_(2 +) / zeta_2|)^2 (frac(k, 2 H e^(N_c)))^(1 - 2 lambda_2)\
 & = frac(k^2, 4 pi) \| - frac(Gamma ( 1 + lambda_2 ), zeta_1) (frac(k, 2 cal(H)_c))^(- lambda_2 + 1 / 2) J_(lambda_2) H_(lambda_1)\
 & #h(2em) quad + frac(Gamma ( lambda_2 ), zeta_2) (frac(k, 2 cal(H)_c))^(- lambda_2 + 3 / 2) (J_(lambda_2) H_(lambda_1 - 1) + J_(lambda_2 + 1) H_(lambda_1)) \|_(N = N_c)^2 thin . $<eq:PR_delta>


The first bracketed term is rapidly damped as $k^(- lambda_2 - 1 / 2)$ when $k gt.double cal(H)_c$ and thus it contributes mainly to the $k lt.double cal(H)_c$ power spectrum generated during the initial SR phase, indicating that the $cal(P)_(cal(R))$ peak comes from the second term. Its asymptotic behaviour there gives the slope of the power spectrum during SR. Analogously, the asymptotic limits $k gt.double cal(H)_c$ and $k lt.double cal(H)_c$ in the second term give the slopes of the peak away from the top. The dominant contributions to the slopes of the power spectrum can thus be summarized as $ cal(P)_(cal(R)) prop cases(
    k^(3 - 2 lambda_1) thin , & quad k lt.tilde cal(H)_c,
    k^(5 - 2 \| lambda_1 - 1 \|) thin , & quad cal(H)_c lt.tilde k lt.tilde cal(H)_c e^(N_(upright("USR"))),
    k^(3 - 2 lambda_2) thin , & quad cal(H)_c e^(N_(upright("USR"))) lt.tilde k
  ) thin . $<eq:delta_spectrum_slopes>


// [figvision-cn] imgs/mode_evolution.png
// 该图由左右两个子图组成，分别标记为左侧面板和右侧面板，
// 均采用对数坐标轴。左侧面板展示曲率功率谱，纵轴为 \(\
// mathcal{P_R}(k)\)，范围从 \(10^{-12}\) 到 \(10^{-2}\)；
// 横轴为 \(k/\text{Mpc}^{-1}\)，范围从 \(10^{10}\) 到 \(
// 10^{16}\)。图中有一条蓝色实线表示瞬时跃迁近似下的基准
// 模型#1，其曲线在 \(k \approx 10^{11}\) 处出现一个深谷
// （降至约 \(10^{-11}\)），随后急剧上升，在 \(k \approx
// 10^{13}\) 附近达到峰值（约 \(10^{-3}\)，标有红色五角星），
// 之后以较缓的斜率下降；与之对比的是一条灰色虚线，表示慢
// 滚（SR）近似，其曲线在 \(k < 10^{12}\) 时平缓，在 \(k
// \approx 10^{13}\) 处峰值较低（约 \(10^{-4}\)），随后下
// 降。蓝色曲线上有若干标记点：绿色五角星（约 \(10^{10}\)）、
// 黄色五角星（约 \(10^{11}\)）、橙色五角星（约 \(10^{12}
// \)）、紫色方块（约 \(10^{14}\)）。图中还有一条垂直的绿
// 色阴影带，横跨 \(k \approx 10^{12}\) 至 \(10^{14}\)，
// 内部标注有垂直文字“USR”。右侧面板展示 Sasaki-Mukhanov
// 变量 \(u_k\) 的演化，纵轴为 \(|u_k|\)，范围从 \(10^{-2
// }\) 到 \(10^2\)；横轴为 \(N\)，范围从约 24 到 37。图中
// 包含多条曲线，其中蓝色实线和虚线与左侧面板的标记点对应。
// 图例标注显示：紫色方块为“CR”（对应紫色虚线，在 \(N \
// approx 24-35\) 区间呈水平线，之后上升），橙色方块为“增
// 强”（对应橙色曲线，先上升至峰值后下降再上升），绿色方
// 块为“SR”（对应绿色曲线，先上升后下降再上升），红色方块
// 为“USR”（对应红色曲线，先平坦后下降再急剧上升），黄色
// 方块为“抑制”（对应黄色曲线，先上升后下降再上升），蓝色
// 方块为“z”（对应蓝色曲线，先上升后下降再急剧上升）。图
// 中同样有一条垂直绿色阴影带，横跨 \(N \approx 32\) 至 \
// (34\)，与左侧面板的 USR 区域对应。曲线在阴影带附近表现
// 出明显的振荡特征，且不同颜色的曲线在阴影带内的行为各异，
// 例如橙色和红色曲线出现明显的低谷，而蓝色和绿色曲线则呈
// 现不同的上升趋势。
#figure(image("imgs/mode_evolution.png", width: 100%),
  caption: [
    #emph[Left panel:] The curvature power spectrum @eq:PR_delta in the instantaneous transition approximation for the benchmark model \#1 from @tab:delta_models (blue) and, for comparison, the SR approximation $cal(P)_(cal(R)) = H^2 / ( 8 pi^2 M_(upright(P))^2 epsilon.alt_H )$ with $epsilon.alt_H = z^2 / ( 2 M_(upright(P))^2 a^2 )$ (dashed grey), with a number of modes from different regions highlighted. #emph[Right panel:] Evolution of the Sasaki-Mukhanov variable $u_k$ for the corresponding wave numbers from @eq:uk. The dashed and solid sections correspond to the sub- and super-horizon regions, $cal(H) < k$ and $cal(H) > k$, respectively. The modes are normalized so that their large $N$ asymptotic is the same order as $z$, which in turn is normalized as $z ( N_c ) = 1$. The colour coding of vertical bands is the same as in @fig:example_models.
  ]
)
<fig:mode_evolution>



For small and large $k$, @eq:delta_spectrum_slopes gives a scale invariant spectrum if $lambda_(1 , 2) = 3 / 2$, corresponding to a pure de Sitter case, while $lambda_(1 , 2) > 3 / 2$ ($lambda_(1 , 2) < 3 / 2$) will produce a red-tilted (blue-tilted) power spectrum. The peak's rising slope is sensitive to the behaviour at $N < N_c$ through $lambda_1$. As long as $eta_H < 0$ during the SR phase, that is, $lambda_1 > 3 / 2$ from @eq:etaH_regions, the growth exponent has a maximal value of $4$, consistent with previous studies~@Byrnes:2018txb @Carrilho:2019oqg. In case the spectrum is blue-tilted during the initial phase, #emph[i.e.], $1 < lambda_1 < 3 / 2$, the power spectrum can grow as fast as $cal(P)_(cal(R)) prop k^5$, which is similar to the maximal growth $cal(P)_(cal(R)) prop k^5 log^2 k$ found in Ref.~@Carrilho:2019oqg.


The position and height of the maximum of the power spectrum @eq:PR_delta are given by#footnote[A decent numerical fit is given by $k_(upright("max")) / cal(H)_c = 2.1 + 0.74 lambda_2 - 0.13 lambda_2 ln lambda_2$. It is accurate within 1\% in the range $3 / 2 < lambda_1 < 2$, $3 / 2 < lambda_2 < 30$.]


$ k_(upright("max")) = cal(O) ( 3 ) cal(H)_c thin , #h(2em) cal(P)_(cal(R)) ( k_(upright("max")) ) = cal(O) ( 0.05 ) / zeta_2^2 thin , $


respectively. This estimate has only a mild dependence on $lambda_2$, and is almost independent of $lambda_1$. Importantly, note that the position of the maximum depends only on the comoving horizon scale $cal(H)_c$ at the T1 phase, while the height of the peak depends on $zeta_2$ and thus, by @eq:N_USR, on the duration of USR. This is expected, because the features of the peak in the spectrum @eq:PR_delta arise from the coefficient $c_(+)$ determined by matching of the modes at $N_c$, that is, the shape of the peak is determined by mode evolution during T1 phase.


An example of the power spectrum @eq:PR_delta is displayed in @fig:mode_evolution. The right panel shows the evolution of the $u_k$ modes exiting the horizon at different times. Modes that exit much before or after the USR freeze almost immediately after horizon exit. That is, they follow $z$ so that $cal(R) = u_k / z = upright("const") thin upright(".")$ (see the discussion in @sec:perturbation_evolution and @sec:phases). Modes that exit during or close to USR deviate from $z$ for some time after horizon crossing, briefly following the second solution $u_0^(( 2 ))$ in @eq:SH_modes, which dominates during USR. At $N_c$, we can see the kicks due to the delta function in~@eq:insta. Both $u_k$ and $z$ have a tendency to grow, and the growth of the curvature perturbation $\| cal(R)_(c thin k) \| = lr(|u_k / z|)$ during USR is due to the decrease in $z$ rather than the growth of $u_k$. Indeed, all the modes depicted in @fig:mode_evolution (except the CR mode that exits well after USR) decrease at least momentarily during USR.


Note the super-horizon enhancement of modes that exit a few $e$-folds before the USR phase, at a time when the SR conditions still hold. The power spectrum in the SR approximation @eq:PR_from_u is shown in the left panel of @fig:mode_evolution for comparison---while the SR approximation would predict a flat spectrum before the USR phase, the MS equation shows rapid growth. The power spectrum is also mildly enhanced during the final CR phase when compared to the naive SR expectation.


== Potentials producing instantaneous SR to USR transitions
<sec:delta_potential>


As we will show in this section, the behaviour @eq:insta of $cal(H)^(- 2) z'' / z$ can be realized by a scalar field rolling down a potential consisting of two concave parabolas, sketched in @fig:delta_V_sketch, $ V = cases(
    V_2 ( 1 + frac(1, 2 M_(upright("P"))^2) eta_(V 2) ( phi.alt - phi.alt_2 )^2 ) thin , & quad phi.alt < phi.alt_c,
    V_1 ( 1 + frac(1, 2 M_(upright("P"))^2) eta_(V 1) ( phi.alt - phi.alt_1 )^2 ) thin , & quad phi.alt > phi.alt_c
  ) thin . $<eq:V_humps> Here $eta_(V 1) , eta_(V 2) < 0$ are the potential SR parameters $eta_V$ at the two hilltops at $phi.alt_1$ and $phi.alt_2$. We set $phi.alt_2 < phi.alt_c < phi.alt_1$ and choose $V_1 > V_2$. The transition point $phi.alt_c$ is at the intersection of the two parabolas so that the potential is continuous. We further choose the parameters so that $V ( 0 ) = 0$.


During its evolution, the field starts close to the higher hilltop, at $phi.alt lt.tilde phi.alt_1$, rolls down to the sharp feature at $phi.alt_c$, and continues rolling along the other parabola, crossing the lower hilltop at $phi.alt_2$ and continuing towards $phi.alt = 0$. We require $epsilon.alt_V lt.double 1$ during this evolution; this is possible if both of the hilltops are sufficiently close to $phi.alt_c$. In this limit, $epsilon.alt_H lt.double 1$ for the full duration, and $H$ is approximately a constant, say, $H approx sqrt(V_2 / 3) / M_(upright(P))$, as is $eta_V$ separately on the two parabolas. We will use these approximations repeatedly throughout this section. We also take $\| eta_(V 1) \| < 1$, so that the field starts in SR. The SR approximation is only broken at $phi.alt_c$, where $eta_V$ has a negative delta spike. Comparing this to @eq:zpp and using all the above-mentioned approximations, including $epsilon.alt_H lt.double 1$, we see that $z'' / z$ matches the approximation @eq:insta with#footnote[Note that in SR, $eta_V approx eta_H lt.double 1$, this coincides with the $lambda_i approx 3 / 2 - eta_H$ from @eq:etaH_regions.]


$ lambda_i approx 3 / 2 sqrt(1 - 4 / 3 eta_(V i)) thin , #h(2em) i = 1 , 2 thin , $<eq:lambda_in_etaV>


consistent with @eq:phi_max_solution.


// [figvision-cn] imgs/delta_V_sketch.png
// 该图为单幅曲线示意图，展示瞬时转变模型势能函数 V(φ) 随
// 序参量 φ 的变化关系。横轴标注为 φ，未标注具体数值刻度
// 与单位，范围内从左至右依次标出 φ₂、φ_c、φ₁ 三个位置；
// 纵轴标注为 V(φ)，未标注具体数值刻度与单位，从下至上依
// 次标出 V₂、V₁ 两个能级高度。 图中包含两条蓝色势能曲线，
// 二者在 φ_c 处相交，交点用红色实心圆点标记，对应势能高
// 度 V₂。第一条曲线为虚线，呈单一势垒形状，其峰值位于 φ₂
// 处，峰高为 V₂，该虚线曲线在 φ_c 处与另一曲线相交后继续
// 向右下方延伸。第二条曲线为实线，呈双势垒形状，其左侧局
// 部极大值位于 φ₂ 处，高度为 V₂，随后在 φ_c 处与虚线曲线
// 相交并形成红色圆点，之后继续上升至全局最大值，该全局最
// 大值位于 φ₁ 处，高度为 V₁，且 V₁ 高于 V₂，最后向右下方
// 下降。 图中辅助标记包括：从 V₁ 高度引出的水平虚线延伸
// 至 φ₁ 对应的垂直虚线，标示全局势垒高度；从 V₂ 高度引出
// 的水平虚线延伸至 φ₂ 对应的垂直虚线，标示局部势垒高度；
// 从红色圆点 φ_c 处向下引出垂直虚线至横轴。该图传达的趋
// 势是：在瞬时转变模型中，势能面在 φ₂ 处存在一个高度为 V
// ₂ 的局部势垒，在 φ₁ 处存在一个高度为 V₁ 的主势垒，两条
// 势能曲线在 φ_c 处相交并发生势能面的切换，红色圆点标示
// 了转变发生的临界点。
#figure(image("imgs/delta_V_sketch.png", width: 65.0%),
  caption: [
    A sketch of the instantaneous transition model potential @eq:V_humps.
  ]
)
<fig:delta_V_sketch>



Let us next study the field's evolution more closely. In the process, we will make contact with the rest of the formalism presented in @sec:insta.


Near the first hilltop, the field first traverses from an initial value $phi.alt_(*)$ to the transition point $phi.alt_c$ in SR. The duration of this phase in $e$-folds is approximately


$ N approx integral_(phi.alt_c)^(phi.alt_(*)) frac(upright(d) phi.alt, M_(upright(P)) sqrt(2 epsilon.alt_V)) approx frac(1, \| eta_(V 1) \|) ln frac(Delta phi.alt_1, phi.alt_1 - phi.alt_(*)) thin , $<eq:N_SR_initial>


where we defined $Delta phi.alt_i equiv \| phi.alt_i - phi.alt_c \|$. After SR ends, the field continues to evolve in the general way outlined in @sec:phases. Analogously to the @eq:phi_max_eom, the field obeys


$ partial_N^2 phi.alt + 3 partial_N phi.alt + 3 eta_(V 2) (phi.alt - phi.alt_2) = 0 thin , $<eq:phi_humps_eom>


and thus


$ phi.alt - phi.alt_2 = c_(+) e^(( - 3 / 2 + lambda_2 ) (N - N_c)) + c_(-) e^(( - 3 / 2 - lambda_2 ) (N - N_c)) thin , $<eq:phi_humps_solution>


where we used @eq:lambda_in_etaV. Note that $z = a partial_N phi.alt$, and @eq:phi_humps_solution is indeed consistent with the $z$ approximation @eq:z_toy. The coefficients $c_plus.minus$ are fixed by demanding that $phi.alt = phi.alt_c$ and $N = N_c$ and that the field velocity is continuous. Using the approximation $partial_N phi.alt_c approx - M_(upright(P)) sqrt(2 epsilon.alt_V) approx eta_(V 1) Delta phi.alt_1$ on the SR side#footnote[If one wants to fine-tune the evolution and thus the height of the power spectrum peak to a great degree, it may be necessary to include higher-order SR corrections to $partial_N phi.alt_c$.], we find


$ c_plus.minus = frac(1, 2 lambda_2) (minus.plus \| partial_N phi.alt_c \| + Delta phi.alt_2 ( plus.minus 3 / 2 + lambda_2 )) thin . $<eq:c_plus_minus>


Comparing @eq:phi_humps_solution to the $z$ approximation @eq:z_toy then gives


$ zeta_2 / zeta_1 = frac(lambda_2 - 3 / 2, 2 lambda_2) (1 - ( 3 / 2 + lambda_2 ) frac(Delta phi.alt_2, \| partial_N phi.alt_c \|)) thin . $<eq:match_c_expressions>


@eq:lambda_in_etaV and @eq:match_c_expressions relate the instantaneous transition ansatz @eq:z_toy for $z$ to the piecewise smooth potential @eq:V_humps. This correspondence holds up to shifts in $phi.alt$. The height of the resulting power spectrum $cal(P)_(cal(R))$ can be changed by changing the height of the potential and thus $H$. This corresponds to rescaling $zeta_1$ in @eq:PR_delta.


// [figvision-cn] imgs/delta_example_row.png
// 本图由三个并排的子图组成，展示暴胀模型中势能、慢滚参数
// 与曲率功率谱随场值和e折数的演化，并用绿色竖带统一标出
// 超慢滚（USR）阶段。 子图a为曲线图，横轴为标量场φ，线性
// 刻度，范围约1.71至1.80；纵轴为归一化势能V(φ)/V1，线性
// 刻度，范围约0.9983至0.9992。图中实线为蓝紫色势能曲线，
// 随φ增大单调上升，斜率在φ≈1.744至1.752之间明显减小，形
// 成一段近平台，之后斜率回升。竖带由绿色实线边界和内部绿
// 色阴影组成，位置约φ=1.744至1.752，带内标注USR。竖带边
// 界附近分别标注φ2和φc，并带指示箭头（φ2在左边界，φc在右
// 边界）。该图传达：势能在USR区间变得极平，对应慢滚条件
// 被破坏。 子图b为曲线图，横轴为e折数N，线性刻度，范围约
// -5至55；纵轴为H^{-2}z''/z，线性刻度，范围约-1至6。图中
// 蓝色实线为数值结果（Numerical），红色虚线为解析结果（
// Analytic），两者几乎重合。曲线在N约0至33期间保持在约
// 2.05的平台上；在N≈33处发生跳变，跃升至约4.0的平台，随
// 后在N≈53处急剧上升至超出纵轴上限。绿色竖带位置约N=33至
// 35，标注USR；在N=0附近有一条灰色垂直虚线，标注CMB。图
// 例位于左下角，注明蓝实线和红虚线的含义。该图表明：在
// USR阶段，慢滚参数出现台阶式跃升，随后H^{-2}z''/z急剧增
// 长。 子图c为双对数曲线图，横轴为波数k/Mpc^{-1}，对数刻
// 度，范围约10^{-1}至10^{21}；纵轴为曲率功率谱P_R(k)，对
// 数刻度，范围约10^{-13}至10^{-1}。主图中蓝实线为数值谱，
// 红虚线为解析谱，两者在大部分区间重合；在k≈10^{10} Mpc^
// {-1}处，谱从约10^{-9}急剧下降至约10^{-12}，随后在k≈10^
// {13} Mpc^{-1}附近急剧上升至峰值约10^{-2}，之后以近似幂
// 律下降。绿色竖带位置约k=10^{13}至10^{14} Mpc^{-1}，标
// 注USR；左侧灰色垂直虚线位于k≈0.5 Mpc^{-1}，标注CMB。图
// 内左上角有一个虚线框标示的插图，放大显示了峰值附近的振
// 荡结构，插图中绿带与主图对应位置一致，可见红虚线在峰值
// 附近与蓝实线出现分歧并呈现振荡。该图表明：USR阶段导致
// 功率谱在特定尺度上出现显著增强和振荡。
#figure(image("imgs/delta_example_row.png", width: 98.0%),
  caption: [
    The potential #emph[\(left panel)], $cal(H)^(- 2) z'' / z$ from @eq:zpp #emph[\(middle panel)], and the power spectrum #emph[\(right panel)] for the potential~@eq:V_humps with the parameter values from @tab:delta_models (model \#1). The blue curves correspond to the full numerical solution with the potential~@eq:V_humps, whereas the red, dashed curves correspond to the analytical approximations~@eq:insta, @eq:PR_delta with parameters determined from~@eq:lambda_in_etaV, @eq:match_c_expressions. The colour coding of vertical bands is the same as in @fig:example_models, and the CMB scales have been marked where appropriate. Notice that the potential is shown only close to the feature at $phi.alt_c$. In the middle panel, the $x$-axis marks the number of $e$-folds from the CMB. The inset highlights that the potential~@eq:V_humps perfectly reproduces the oscillations at the $cal(P)_(cal(R))$ peak found in the approximation~@eq:PR_delta.
  ]
)
<fig:delta_row>



In the limit of small $eta_(V 2)$, the length of the USR period @eq:N_USR can be written to leading order as


$ Delta N_(upright("USR")) approx 1 / 3 ln frac(6, - eta_(V 2) (1 - frac(3 Delta phi.alt_2, \| partial_N phi.alt_c \|))) thin . $<eq:N_USR_2>


Substituting this to @eq:phi_humps_solution, the $phi.alt$-value at the end of USR is, to leading order,


$ phi.alt_(upright("CR")) approx phi.alt_2 + c_(+) approx phi.alt_c - \| partial_N phi.alt_c \| / 3 thin . $<eq:phi_int_approx>


Since $c_(+) < 0$, this is located at a field value somewhat smaller than the lower hilltop $phi.alt_2$. At this level of approximation, the result agrees with pure USR, where the potential term in @eq:phi_humps_eom is neglected and the field is left to roll on a plateau until it stops after traversing a field range of $\| partial_N phi.alt_c \| / 3$. If $eta_(V 2)$ is not small, $phi.alt_(upright("CR"))$ can still be solved similarly, but the expressions become lengthy.


The USR phase transitions to CR, where it stays until inflation ends close to $phi.alt = 0$. The remaining number of $e$-folds is approximately~@Martin:2012pe


$ Delta N_(upright("CR")) & approx ( 1 - eta_H / 3 ) integral_0^(phi.alt_(upright("CR"))) frac(upright(d) phi.alt, M_(upright(P)) sqrt(2 epsilon.alt_V))\
 & = (1 / 2 + 1 / 3 lambda_2) [- 1 / eta_(V 2) ln frac(phi.alt_2, phi.alt_2 - phi.alt_(upright("CR"))) - frac(phi.alt_2^2 - ( phi.alt_2 - phi.alt_(upright("CR")) )^2, 4 M_(upright(P))^2)] thin , $<eq:N_SR_final>


where we dropped the constant $H$ approximation, which breaks down after the field leaves the lower hilltop, but retained the CR assumption of a constant $eta_H$. This concludes our description of the inflaton's time evolution.


The potential @eq:V_humps can be considered a generalization of the Starobinsky model~@Starobinsky:1992ts, built out of two linear sections with different slopes. Both models exhibit a similar discontinuity in the first derivative of the potential. Indeed, if we set $phi.alt_2 > phi.alt_c$, so that the potential grows monotonously all the way to $phi.alt_1$, the resulting dynamics would be similar to the Starobinsky case near $phi.alt_c$. However, Starobinsky's scenario cannot support a prolonged period of USR. For that, we need $phi.alt_2 < phi.alt_c$ so that the potential has a secondary maximum, slowing the field down as it rolls over the hilltop. We remark that analogous simplified models involving piecewise quadratic potentials have been used to construct analytic descriptions of preheating in plateau inflation~@Koivunen:2022mem.


== Constructing potentials for PBHs of any mass
<sec:delta_example>


Using the results of the previous sections, we can now tailor a potential to produce PBHs with a desired mass and abundance, simultaneously with desired CMB observables. The full SR parameters of the potential @eq:V_humps read


$ epsilon.alt_V = frac(frac(1, 2 M_(upright(P))^2) (phi.alt - phi.alt_i)^2 eta_(V i)^2, (frac(1, 2 M_(upright(P))^2) (phi.alt - phi.alt_i)^2 eta_(V i) + 1)^2) thin , #h(2em) eta_V = frac(eta_(V i), frac(1, 2 M_(upright(P))^2) (phi.alt - phi.alt_i)^2 eta_(V i) + 1) thin , $<eq:hump_SR_parameters>


where $i = 1$ for $phi.alt > phi.alt_c$ and $i = 2$ for $phi.alt < phi.alt_c$. Starting from the desired values for $n_s$ and $r$, presented in terms of the SR variables in @eq:SR_ns_and_r, we can solve $eta_(V 1)$ and $phi.alt_(upright("CMB")) - phi.alt_1$ from @eq:hump_SR_parameters, where $phi.alt_(upright("CMB"))$ is the CMB field value. Fixing $A_s$ then sets $V_1$ through @eq:PR_from_u using $H^2 = V / ( 3 M_(upright(P))^2 )$ and $epsilon.alt_H approx epsilon.alt_V$. The desired PBH mass gives the position of the power spectrum peak from @eq:M_k below with $Delta N approx Delta ln k$ as $e$-folds from the CMB. The peak will be located roughly at the transition scale $N = N_c$, so @eq:N_SR_initial with $phi.alt_(*) = phi.alt_(upright("CMB"))$ sets $phi.alt_c$. The parameters $eta_(V 2)$ and $Delta phi.alt_2$ can then be used to adjust the height of the power spectrum peak and the remaining number of $e$-folds of inflation, setting the PBH abundance and the total length of inflation. The length of USR @eq:N_USR_2 can be a useful proxy for the abundance, and is mainly sensitive to $Delta phi.alt_2$. In turn, $eta_(V 2)$ controls the remaining number of $e$-folds, approximated by @eq:N_SR_final. The remaining parameters in @eq:V_humps, that is, $V_2$ and $phi.alt_2$, are fixed by the requirements of continuity at $phi.alt_c$ and the requirement $V ( 0 ) = 0$.




#figure(
  align(center)[
    #table(
    stroke: none,
        columns: 7,
        align: (center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
        table.header([Model], [i], [$V_i / M_P^4$], [$eta_(V i)$], [$phi.alt_i$], [$phi.alt_c$], [$phi.alt_(upright("CMB"))$],),
        table.hline(),
        [\#1], [1], [$3.1100369 times 10^(- 12)$], [$- 0.017475$], [$2.10607$], [$1.75215$], [$1.9038$],
        [], [2], [$3.1066362 times 10^(- 12)$], [$- 0.652743$], [$1.75043$], [], [],
        [\#2], [1], [$3.1100369 times 10^(- 12)$], [$- 0.017475$], [$2.62987$], [$2.35685$], [$2.4276$],
        [], [2], [$3.1080125 times 10^(- 12)$], [$- 0.360486$], [$2.35543$], [], [],
    table.hline(stroke: 0.8pt),
      )

    #v(0.8em)
    #table(
    stroke: none,
        columns: 8,
        align: (center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
        table.header([Model], [$n_s$], [$r$], [$N_(upright("CMB"))$], [$k_(upright("peak"))$ (Mpc$""^(- 1)$)], [$cal(P)_(cal(R)) zws_(upright("peak"))$], [$M_(upright("PBH"))$ (g)], [],),
        table.hline(),
        [\#1], [$0.965$], [$0.99 times 10^(- 4)$], [$53.7$], [$1.64 times 10^13$], [$0.0025$], [$1.04 times 10^20$], [],
        [\#2], [$0.965$], [$0.99 times 10^(- 4)$], [$55.6$], [$5.35 times 10^6$], [$0.014$], [$9.75 times 10^32$], [],
    table.hline(stroke: 0.8pt),
      )
  ],
  caption: [Input parameters and the resulting cosmological observables for the potential~@eq:V_humps in two example cases, corresponding to PBHs of approximately $10^20$g (model \#1) and a solar mass (model \#2). For the input parameters, no digits have been omitted: the observables were computed with these exact values. Tuning $cal(P)_(cal(R)) zws_(upright("peak"))$ more finely requires more accuracy in the inputs. The CMB parameters fit the observational constraints @Planck:2018jri.],
  kind: table,
)
<tab:delta_models>






We carried out this exercise and produced two example models, compatible with the CMB observations @eq:CMB_observables and tuned to produce PBHs with masses $10^20$ and $10^33$g. We used the analytical expressions in @sec:delta_potential to fix the CMB and as a starting point for tuning the power spectrum peak, but solved the background evolution numerically starting from the potential @eq:V_humps, and numerically optimized the parameters $Delta phi.alt_1$, $Delta phi.alt_2$, and $eta_(V 2)$. The observables are listed in @tab:delta_models, given the analytical power spectrum @eq:PR_delta. The input parameters for the spectrum were computed from the potential using @eq:lambda_in_etaV and @eq:match_c_expressions. The resulting parameter values for the potential are listed in @tab:delta_models. We then solved the MS equation~@eq:MS numerically for approximately $2000$ modes in model \#1 and compared to the analytical approximation. The results are depicted in @fig:delta_row and show an excellent match between the analytics and the numerics.#footnote[To avoid numerical issues related to the discontinuity in the first derivative of the potential, we used the transformation in Eq.~(3.23) of Ref.~@Rasanen:2018fom.]


The power spectrum shown in @fig:delta_row is typical for a PBH model and, due to its easy-to-manipulate analytical form and a clear connection to a potential, can be used as a proxy for studying observational signals of such models. The only potentially unrealistic feature of the spectrum are the oscillations near the peak, originating from the Bessel functions in~@eq:PR_delta, and induced by the discontinuity at $N_c$. In the next section, we modify the model to reduce the amplitude of these oscillations.


= Approximating the spectra of smooth potentials
<sec:spectrum_approximation>


The instantaneous transition model of the previous section has two shortcomings: first, it produces a spectrum with a constant spectral index in the SR region, which tends to not capture well the spectrum all the way from the CMB to the PBH scale in smooth models such as those depicted in @fig:example_models. Second, it exhibits sharp oscillations in the power spectrum peak, absent in the smooth models. In this section, we attempt to overcome these flaws and approximate the spectra of such smooth models analytically. @fig:model_1_fits shows the resulting example fits.


// [figvision-cn] imgs/model_1_fits.png
// 这是双面板科学示意图，两个面板均为双对数坐标曲线图，共
// 享同一套物理量定义：横轴为共动波数 k，单位为 Mpc⁻¹，纵
// 轴为原初曲率功率谱 𝒫_ℛ(k)，为无量纲量。两图以低波数端
// 功率谱的近似曲线作为基准，对比瞬时跃迁（Instantaneous
// T1）与非瞬时跃迁（Model I）两种模型下原初曲率扰动功率
// 谱的演化特征。 左面板（子图 a）为全波数范围的总览图。
// 横轴覆盖约 10⁻² 至 10²² Mpc⁻¹，纵轴覆盖 10⁻¹³ 至 10⁻¹
// 量级，两者均为对数刻度。图中包含两条核心曲线：红色实线
// 代表瞬时 T1 模型，深灰色虚线代表 Model I 模型；红色实
// 线在峰值两侧的平缓段与虚线完全重合，仅在尖峰与陡降段因
// 跃迁时长差异出现分离。低波数端谱线从约 3×10⁻⁹ 缓慢下降，
// 至 k≈10¹⁰ Mpc⁻¹ 处发生陡降，随后在 10¹⁰ 至 5×10¹⁰ Mpc⁻
// ¹ 区间急剧抬升，于 k≈10¹⁴ Mpc⁻¹ 处达到峰值，峰值高度约
// 3×10⁻²，之后随波数增大快速衰减，在 k≈10²¹ Mpc⁻¹ 附近回
// 落至约 10⁻⁹。图中标注了一条位于 k≈0.5 Mpc⁻¹ 的黑色竖直
// 虚线，旁注“CMB”，表示该波数对应宇宙微波背景可观测的尺
// 度范围；同时以竖直色带标出两个典型阶段：k≈10¹¹ Mpc⁻¹
// 附近为窄黄色色带，k≈10¹⁴ Mpc⁻¹ 附近为窄绿色色带，绿色
// 色带旁标注“USR”，表示超慢滚阶段。左上角图例标明红色实
// 线为“Instantaneous T1”，深灰色虚线为“Model I”，并说明
// 虚线为瞬时跃迁模型的近似结果，二者的差异仅出现在跃迁过
// 渡区域。 右面板（子图 b）是对峰值区域的放大图，重点对
// 比不同 T1 阶段时长下的谱形差异。横轴覆盖 10¹³ 至 10¹⁶
// Mpc⁻¹，纵轴覆盖 10⁻⁴ 至 10⁻¹，均为对数刻度。图中共六条
// 曲线：红色实线为瞬时跃迁基准，曲线在低波数端迅速上升，
// 至 k≈10¹⁴ Mpc⁻¹ 处达到约 2×10⁻¹ 的峰值，随后进入平缓平
// 台，再随波数增大缓慢衰减；其余五条深紫色至蓝色的曲线为
// Model I 在不同 T1 阶段持续时长下的拟合结果，对应图注中
// 从下到上变化的时长倍数，时长依次递增。在低波数端，所有
// 非瞬时曲线整体位于瞬时曲线下方，且时长越长，低波数端功
// 率越低，如最长时长曲线的低波数端功率约为 5×10⁻⁵，比瞬
// 时曲线低约两个量级；所有非瞬时曲线在高波数端均与瞬时曲
// 线逐渐收敛重合，说明跃迁时长主要影响低波数端谱形，高波
// 数端渐近行为不受影响。非瞬时曲线在峰值附近出现振荡结构，
// 即功率随波数的小幅周期性起伏，说明非瞬时跃迁在谱中引入
// 了特征尺度对应的振荡信号。本图同样以竖直色带标出不同暴
// 胀阶段：左侧自 10¹³ 至 8×10¹³ Mpc⁻¹ 为黄色带，中间自 8
// ×10¹³ 至 3×10¹⁴ Mpc⁻¹ 为绿色带，右侧自 3×10¹⁴ 至 3×10¹
// ⁵ Mpc⁻¹ 为浅绿色带，绿色带区域标注“USR”，各色带含义与
// 左图一致，分别对应不同的暴胀阶段。该子图的核心结论为：
// 非瞬时跃迁对功率谱峰值的整体形态改变有限，但会在低波数
// 端压低功率、在峰值附近引入振荡，且 T1 阶段时长越长，低
// 波数端的压低效应越显著，高波数端所有模型趋于一致。
#figure(image("imgs/model_1_fits.png", width: 100%),
  caption: [
    Model I from @fig:example_models compared to the approximation in @eq:PR_delta_approx. On the right hand side, fits using the non-instantaneous transition model are also plotted with varying durations of the T1 phase, $Delta N_(upright(T)) = ( 0.5 , 1 , 1.5 , 2 ) e$-folds from top to bottom. The remaining parameters were chosen to match the slopes of the peak. The colour coding of vertical bands indicating different inflationary phases is the same as in @fig:example_models.
  ]
)
<fig:model_1_fits>



== Fitting the instantaneous transition approximation
<sec:delta_fit>


To apply the instantaneous transition approximation to realistic models of inflation, we will express the spectrum~@eq:PR_delta in terms of SR parameters. In the $k lt.double cal(H)_c$ and $k gt.double cal(H)_c e^(N_(upright("USR")))$ asymptotics of @eq:PR_delta we find that the power spectrum can be approximated by


$ cal(P)_(cal(R))^(( upright(C) R )) ( k   lambda_i ) equiv frac(Gamma ( lambda_i )^2, 2^(4 - 2 lambda_i) pi^3) frac(H^2, M_(upright(P))^2 epsilon.alt_H)\|_(k = cal(H)) , $<eq:PR_CR>


that is, by the usual CR power spectrum~@Kinney:2005vj @Motohashi:2014ppa @Motohashi:2019rhu.#footnote[The $k lt.double cal(H)_c$ asymptotics of Bessel functions give $- frac(Gamma ( 1 + lambda_2 ), zeta_1) J_(lambda_2) H_(lambda_1) (frac(k, 2 cal(H)_c))^(- lambda_2 + 1 / 2) approx i frac(Gamma ( lambda_1 ), pi z) (frac(k, 2 cal(H)))^(- lambda_1 + 1 / 2) thin , $ where we used @eq:z_toy to eliminate $zeta_1$. In the last expression, $z$ and $cal(H)$ can be evaluated at an arbitrary time $N < N_c$. We replace $zeta_1$ and $zeta_2$ in @eq:PR_delta with $epsilon.alt_H = z^2 / ( a M_(upright(P)) )^2 / 2$ (and $z$ given by @eq:z_toy) during the SR or CR phases, respectively.] The SR approximation is recovered by $cal(P)_(cal(R))^(( upright("SR") )) ( k ) equiv cal(P)_(cal(R))^(( upright("CR") )) ( k   3 / 2 )$. In this region, the modes stop evolving after horizon exit, so the usual matching $k = cal(H)$ can be performed. In this way, it is possible to account for an evolving $H$ during the initial SR phase, going beyond the constant $H$ approximation of the previous section. If the $cal(P)_(cal(R))$ peak is due to a small local maximum in the potential, the $lambda_2$ can be read off from the potential using @eq:lambda_in_etaV.#footnote[Having the numerical solution at hand, one may also use $lambda_2 approx 3 / 2 - eta_H$ from @eq:delta_spectrum_slopes instead of $eta_V$ with @eq:lambda_in_etaV. In the example in @fig:model_1_fits, the difference in the $lambda_2$ estimate is only 0.1\%.] During the final CR phase, we can fix the normalization of the second term in~@eq:PR_delta at some fixed scale $k_(upright("CR"))$ from the analytic CR power spectrum~@eq:PR_CR. Assuming that the SR approximation is valid during the initial phase, we can choose $lambda_1 = 3 / 2$. We can then write down an improved version of @eq:PR_delta as


$ cal(P)_(cal(R)) approx \| theta ( cal(H)_c - k ) sqrt(cal(P)_(cal(R))^(( upright(S) R ))) \|_(cal(H) = k) + frac(k thin p ( k / cal(H)_c , lambda_2 ), k_(upright("CR")) thin \| p ( k_(upright("CR")) / cal(H)_c , lambda_2 ) \|) sqrt(cal(P)_(cal(R))^(( upright(C) R )) ( k_(upright("CR"))   lambda_2) ) \|^2 thin , $<eq:PR_delta_approx>


where


$ p ( kappa   lambda_2 ) equiv e^(i kappa) (kappa / 2)^(1 - lambda_2) (- J_(lambda_2) (kappa) + (i - 1 / kappa) J_(lambda_2 + 1) (kappa)) $


describes the peak generated in the instantaneous SR to USR transitions (we expanded $H_(lambda_1)$ and $H_(lambda_1 - 1)$ from @c2PlusDelta with $lambda_1 = 3 / 2$). The step function $theta$ in the first term models the $k gt.double cal(H)_c$ damping of the first term in @eq:PR_delta. As a fit to a realistic model, @eq:PR_delta_approx is fully determined by the evolution of background quantities solved from @eq:eom_inf_N, in particular $H$ and the SR parameters $epsilon.alt_H$ and $eta_H$, together with the transition point given by $cal(H)_c$. We remark that @eq:PR_delta_approx may be improved further by modifying the shape of $p ( kappa   lambda_2 )$.


In @fig:model_1_fits, the approximation @eq:PR_delta_approx is compared to the spectrum from a smooth theoretically well-motivated potential---Model I of @fig:example_models, non-minimal quartic inflation (see @app:examples for details). For this potential, $lambda_2 = 1.916$. Apart from the oscillations at the peak, the instantaneous transition approximation @eq:PR_delta_approx provides a good model of peaked spectra, fitting both the SR and CR regions well.


In single-field inflation, a degree of tuning is typically required to obtain the desired height of the power spectrum peak. @eq:PR_delta_approx can help with this by providing an approximate analytic representation of the power spectra. In this case, the tuning of the potential parameters to several significant digits can be circumvented as the duration of $Delta N_(upright("USR"))$, or equivalently, the height of the $cal(P)_(cal(R))$ peak can be set by hand. The rest of the spectrum in @eq:PR_delta_approx can be estimated using the SR and CR approximations to obtain $epsilon.alt_H$. This method is relatively fast and can be useful, especially in inflationary model building or GW phenomenology when the relevant observables (#emph[e.g.], $r$ and $n_s$) are relatively insensitive to small changes in the height of the $cal(P)_(cal(R))$ peak. On the other hand, the approximation @eq:PR_delta_approx does not capture the shape of the peak perfectly and is not suitable for precision estimates of the PBH abundance, which can be sensitive to minor adjustments in the peak. We will return to this issue in @sec:PBHs.


== Non-instantaneous SR to USR transitions
<sec:non-insta>


// [figvision-cn] imgs/box_sketches.png
// 整幅图由三个并排排列的子图组成，分别标记为 a、b、c。三
// 个子图均为直角坐标曲线图，横轴统一为 N，且仅在轴中央标
// 注字母 N，未给出具体数值范围；纵轴均为无单位物理量。三
// 幅图中各有一条深蓝色实线表示某一模型参量随 N 的演化。
// 三个图均用从下至上贯穿的竖直色带划分区间，颜色编码相同：
// 左侧浅黄色竖带、中央亮绿色竖带、右侧自亮绿向浅绿至白色
// 渐变的竖带。中央竖带内均标注大写字母 USR。横轴下方各有
// 一条水平虚线，标注文字 N₁ 和 N₂，分别对应左黄带与中绿
// 带的分界、中绿带与右渐变带的分界。各图内容如下。 子图
// a：纵轴标注为 ℋ⁻² z''/z，图中央有一条水平虚线，右侧标
// 数值 0。深蓝色实线表明该量随 N 呈分段常数：在 N < N₁
// 时取正值，对应标注 λ₁² − 1/4；在 N₁ < N < N₂ 期间急剧
// 下降至负值，对应标注 −λ̃² − 1/4；在 N > N₂ 时急剧上升
// 至另一正值，对应标注 λ₂² − 1/4，并保持恒定至图右边缘。
// 该图传达：在非瞬时过渡模型中，该有效势项在 USR 阶段由
// 正变负，且数值由 λ₁、λ̃、λ₂ 参数确定。 子图 b：纵轴标
// 注为 ln|z|。深蓝色实线从图左下角开始随 N 单调上升，在
// N₁ 处达到一个极大值，随后在 N₁ 至 N₂ 期间下降并在 N₂
// 附近形成极小值，之后再次单调上升至图右上角。曲线上标有
// 两个红色小圆点：一个位于极大值处（对应 N₁ 附近），另一
// 个位于极小值之前下降段上（对应 N₂ 附近）。该图传达：|z
// | 的对数在 USR 阶段经历一次先增后减的峰谷结构，代表模
// 型中的非瞬时过渡导致该量出现短暂回落。 子图 c：纵轴标
// 注为 η_H，图中有三条水平虚线，从下至上分别标数值 0、3/
// 2、3。深蓝色实线在 N < N₁ 时保持位于 0 附近的低位；在
// N₁ 处急剧上升至接近 3 的高位；在 N₁ 至 N₂ 期间先小幅下
// 降后基本保持平稳；在 N₂ 之后呈 S 型下降，最终回到 0 附
// 近。中央绿色竖带内标注了两个水平双向箭头：左侧箭头标 λ
// ₁，其横向跨度从 N₁ 之前某点延伸至 N₂ 之前某点；右侧箭
// 头标 λ₂，其横向跨度从 N₂ 之前某点延伸至 N₂ 之后某点。
// 该图传达：η_H 在 USR 阶段从约 0 跃升至接近 3 的高位，
// 随后在过渡结束后回落至 0；λ₁ 与 λ₂ 分别量化了进入和退
// 出 USR 阶段过渡过程的持续时间尺度。
#figure(image("imgs/box_sketches.png", width: 100%),
  caption: [
    Sketches of $cal(H)^(- 2) z'' / z$ from @eq:box, $z$ from @eq:z_box, and $eta_H approx 1 - partial_N ln \| z \|$ in the model with non-instantaneous transitions. The colour coding of vertical bands matches @fig:example_models
  ]
)
<fig:box_sketches>



Although the instantaneous transition approximation captures many of the features of the peak in $cal(P)_(cal(R))$, it produces oscillations around the peak that are not observed with non-singular inflaton potentials. In the following, we will show that this modulation is an artefact of the infinitely sharp transition and can be softened. Similar oscillations in $cal(P)_(cal(R))$ have been observed when considering inflationary cosmologies with sharp jumps in $eta_H$ and, in a recent work, they have been shown to disappear once the jumps are smoothed~@Cole:2022xqc.


Instead of an instantaneous kick as in @eq:insta, let us then consider an intermediate T1 phase lasting $Delta N_(upright(T)) equiv N_2 - N_1 e$-folds. This scenario can be modelled by the ansatz $ cal(H)^(- 2) z'' / z = cases(
    lambda_1^2 - 1 / 4 , & quad N < N_1,
    - tilde(lambda)^2 - 1 / 4 , & quad N_1 < N < N_2,
    lambda_2^2 - 1 / 4 , & quad N > N_2
  ) thin , $<eq:box> where the tilde marks quantities during the T1 phase and $lambda_(1 , 2)$ have the same interpretation as in the instantaneous case. The background evolution must now be divided into three epochs, $ z = cases(
    zeta_1 e^(( lambda_1 - 1 / 2 ) ( N - N_1 )) , & quad N < N_1 ,,
    tilde(zeta)_(+) e^(( i tilde(lambda) - 1 / 2 ) ( N - N_1 )) + tilde(zeta)_(-) e^(( - i tilde(lambda) - 1 / 2 ) ( N - N_1 )) , & quad N_1 < N < N_2 ,,
    zeta_(2 +) e^(( lambda_2 - 1 / 2 ) ( N - N_2 )) + zeta_(2 -) e^(( - lambda_2 - 1 / 2 ) ( N - N_2 )) & quad N_2 < N ,
  ) $<eq:z_box> where the coefficients $zeta_i$ are given in @app:box. An example of $z$ evolution @eq:z_box is shown in @fig:box_sketches. This should be compared to @fig:delta_sketches: the sharp features in the instantaneous transition have been eliminated. Setting the end of USR to the point where $eta_H = 1$, the duration of the USR phase is


$ Delta N_(upright("USR")) approx frac(1, 2 lambda_2) ln [frac(lambda_2 + 1 / 2, lambda_2 - 1 / 2) zeta_(2 -) / zeta_(2 +)] thin . $<eq:N_USR_box>


Noting that in the instantaneous case $zeta_(2 -) = zeta_1 - zeta_(2 +)$, this expression is identical to @eq:N_USR. An extended USR period is realized when the growing mode is strongly suppressed at the beginning of the USR phase, #emph[i.e.], $\| zeta_(2 +) \| lt.double \| zeta_(2 -) \|$.


Analogously, the general solution to the MS equation now reads $ u_k = cases(
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_1 )) [ c_(1 +) J_(- lambda_1) ( k / cal(H) ) + c_(1 -) J_(lambda_1) ( k / cal(H) ) ] thin , & quad N < N_1,
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi i tilde(lambda) )) [ tilde(c)_(+) J_(- i tilde(lambda)) ( k / cal(H) ) + tilde(c)_(-) J_(i tilde(lambda)) ( k / cal(H) ) ] thin , & quad N_1 < N < N_2,
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_2 )) [ c_(2 +) J_(- lambda_2) ( k / cal(H) ) + c_(2 -) J_(lambda_2) ( k / cal(H) ) ] thin , & quad N_2 < N
  ) thin , $<eq:MSbox> with the expressions for the coefficients $c_i$ listed in @app:box. The power spectrum is again determined from the coefficient $c_(2 +)$ of the growing mode,


$ cal(P)_(cal(R)) = frac(k^3, 2 pi^2) \| cal(R)_c \|^2 = frac(k^2 Gamma ( lambda_2 )^2, 4 pi^3) lr(|c_(2 +) / zeta_(2 +)|)^2 (frac(k, 2 cal(H)_2))^(1 - 2 lambda_2) thin , $<eq:PR_box>


where $cal(H)_2 equiv cal(H) ( N_2 )$. Due to the complicated form of the expressions, we do not study the details of @eq:PR_box further, but we note that the asymptotic behaviour in the SR and CR regions coincides with the instantaneous transition approximation.


// [figvision-cn] imgs/box_V_sketch.png
// 这是一张科学论文插图，类型为势能曲线图（示意图），用于
// 展示非瞬时SR向USR转变的模型势。图中仅有一个子图，无子
// 图编号。 坐标轴：横轴为 \(\phi\)，表示标量场取值，无单
// 位与具体数值刻度；纵轴为 \(V(\phi)\)，表示势能，无单位
// 与具体数值刻度。 图中主要曲线：一条实线蓝色曲线，表示
// 完整的势能 \(V(\phi)\)，整体呈非对称双峰结构。左侧峰较
// 低，峰值处横坐标为 \(\phi_2\)，对应的势能水平由水平虚
// 线标为 \(V_2\)；右侧峰较高，峰值处横坐标为 \(\phi_1\)，
// 对应的势能水平由水平虚线标为 \(V_1\)。两峰之间有一个局
// 部极小值（谷底），位于横坐标 \(\phi_{c,2}\) 与 \(\phi_
// {c,1}\) 之间。曲线在 \(\phi_2\) 左侧从较低处上升至左侧
// 峰，在 \(\phi_1\) 右侧下降至较低处。 图中还有两条蓝色
// 虚线，呈近似“V”形交叉，代表瞬时转变情形下的势能分支。
// 左侧虚线从图上方左侧下降，穿过实线曲线于一个红色圆点处
// （横坐标约为 \(\phi_{c,2}\)），继续下降至横轴附近；右
// 侧虚线从下方中间位置上升，穿过实线曲线于另一个红色圆点
// 处（横坐标约为 \(\phi_{c,1}\)），继续上升至图上方右侧。
// 两条虚线在横轴上方交叉，交叉点位于两红点之间、实线曲线
// 局部极小值的下方。 图中标注：横轴刻度标签为 \(\phi_2\)、
// \(\phi_{c,2}\)、\(\phi_{c,1}\)、\(\phi_1\)，从左至右排
// 列；纵轴水平虚线标签为 \(V_1\)（较高）和 \(V_2\)（较低）。
// 两个红色实心圆点分别位于实线曲线与两条虚线的交点处，对
// 应横坐标 \(\phi_{c,2}\) 和 \(\phi_{c,1}\)，纵坐标分别
// 低于 \(V_2\) 和介于 \(V_2\) 与 \(V_1\) 之间。图中所有
// 垂直虚线用于指示上述特征横坐标位置。 该图传达的趋势：
// 在非瞬时SR向USR转变模型中，势能曲线在 \(\phi_{c,2}\)
// 和 \(\phi_{c,1}\) 处与瞬时势能分支相交，形成两个临界点
// （红点）；实线势能在两临界点之间出现一个局部极小值，表
// 明转变过程并非瞬时完成，而是经过一个中间谷底阶段，且左
// 右两侧势垒高度不对称（\(V_1 > V_2\)）。
#figure(image("imgs/box_V_sketch.png", width: 65.0%),
  caption: [
    A sketch of the non-instantaneous SR to USR transition model potential @eq:V_humps_2.
  ]
)
<fig:box_V_sketch>



Similarly to the instantaneous transition case, we can build a potential that generates the behaviour~@eq:box. Taking hints from @sec:delta_potential, it is clear that the potential should consist of three parabolas: one for the initial SR and another for the final CR phases as before, and one with a positive second derivative to connect them smoothly. We write it as $ V = cases(
    V_1 ( 1 + 1 / 2 eta_(V 1) ( phi.alt - phi.alt_1 )^2 ) thin , & quad phi.alt_(c , 1) < phi.alt,
    tilde(V) ( 1 + 1 / 2 tilde(eta)_V ( phi.alt - tilde(phi.alt) )^2 ) thin , & quad phi.alt_(c , 2) < phi.alt lt.eq phi.alt_(c , 1),
    V_2 ( 1 + 1 / 2 eta_(V 2) ( phi.alt - phi.alt_2 )^2 ) thin , & quad phi.alt lt.eq phi.alt_(c , 2)
  ) thin , $<eq:V_humps_2> with $lambda_i$ and $eta_(V i)$ related by @eq:lambda_in_etaV, and $tilde(lambda) = ( 3 / 2 ) sqrt(( 4 / 3 ) tilde(eta)_V - 1)$. Requiring $cal(H)^(- 2) z'' / z < 0$ in the intermediary region corresponds to $tilde(eta)_V > 2 / 3$. This makes sense: to break the SR approximation, a value of $eta_V$ of order one is required. This time, $eta_V$ has no delta peaks, only discontinuities, and thus the first derivative of the potential must be continuous everywhere. A sketch of the potential is depicted in @fig:box_V_sketch.


Again, spectra of the form @eq:PR_box can be produced by a potential of the form @eq:V_humps_2. In the intermediary region, a solution similar to @eq:phi_humps_solution applies, and the parameters of the $z$ and $V$ functions there can be straightforwardly matched by expressions similar to @eq:match_c_expressions, paying attention to the continuity of the field velocity. In principle, even more complicated forms of $cal(H)^(- 2) z'' / z$ and the potential can be built and matched with a similar procedure. The details are not very illuminating, and we will not study them here.


The advantage of the “box” model for non-instantaneous transitions is that it reduces the discontinuity of $cal(H)^(- 2) z'' / z$ and thus dampens the oscillations in the power spectrum peak. An example of this is shown in @fig:model_1_fits, where the duration of the transition phase, $Delta N_(upright(T)) = N_2 - N_1$, is varied while fitting the rising and falling slopes of the peak to the smooth Model I. The correct steepness of the slopes was achieved by setting $lambda_1 = 1.8$ and $lambda_2 = 1.916$. To fix the position of the falling slope, the end of USR with $z' = 0$ was matched in the smooth model and in the non-instantaneous approximation. To fix the position of the rising slope, the position of the 'dip' in $cal(H)^(- 2) z'' / z$ was varied by hand. The results show that quick transitions mimic the instantaneous approximation, as expected, while widening the transition smoothens the spectrum, but only to a degree. A spurious 'bump' remains on top of the smooth spectrum, even for wide transitions, and the bump is further modulated by oscillations arising from the sharp edges at $N_1$ and $N_2$.


= Phenomenology
<sec:pheno>


Aided by the analytical expressions for the curvature power spectrum, we will next estimate the abundance of PBHs and GWs induced by the large fluctuations, and consider the constraints from CMB.


== Primordial black holes
<sec:PBHs>


High amplitude curvature perturbations lead to formation of PBHs after their horizon re-entry~@Hawking:1971ei @Carr:1974nx @Carr:1975qj. PBH formation occurs if the smoothed density contrast $delta_m$ exceeds a threshold value $delta_c$~@Carr:1975qj @Musco:2004ak @Polnarev:2006aa @Musco:2008hv @Musco:2012au @Musco:2018rwt @Kehagias:2019eil @Musco:2020jjb. We estimate the fraction of the total energy density $beta_k ( M ) upright(d) ln M$ that collapses into BHs of mass $M$ using the Press-Schechter formalism~@Press:1973iz @Bond:1990iw @Carr:1975qj @Gow:2020bzo:


$ beta_k ( M ) = integral_(delta_(l , c))^oo upright(d) delta_l thin M / M_k thin P_k ( delta_l ) delta_D #h(-1em) [ln frac(M, M ( delta_m ( delta_l ) ))] thin , $<eq:betak_def>


where $delta_D$ denotes the Dirac delta function, $delta_(l , c)$ is the threshold value of $delta_l$, called the linear Gaussian component in the literature, which is related to the density contrast $delta_m$ via~@Young:2019yug @DeLuca:2019qsy @Kawasaki:2019mbl @DeLuca:2022rfz


$ delta_m = delta_l - 3 / 8 delta_l^2 thin , $


and $P_k$ is its probability distribution. Using the critical scaling~@Choptuik:1992jv @Niemeyer:1997mt @Niemeyer:1999ak


$ M ( delta_m ) = kappa M_k (delta_m - delta_c)^gamma thin , $<eq:Mcrit>


where $gamma = 0.36$~@Choptuik:1992jv @Evans:1994pj and $M_k$ is the horizon mass


$ M_k = frac(4 pi M_(upright(P))^2, H_k) approx 1.4 times 10^13 M_⊙ (k / upright("Mpc")^(- 1))^(- 2) thin (frac(g_(* , s)^4 g_(*)^(- 3), 106.75))^(- 1 / 6) thin , $<eq:M_k>


we can express $beta_k ( M )$ as


$ beta_k ( M ) = frac(2 kappa, gamma) frac(q^(1 + 1 / gamma) P_k ( delta_l ( M ) ), 1 - 3 / 4 delta_l ( M )) thin , $<eq:betak>


where $q equiv M / ( kappa M_k )$ and $delta_l ( M )$ is the inversion of the critical scaling law~@eq:Mcrit,


$ delta_l ( M ) = 4 / 3 [1 - sqrt(1 - 3 / 2 (delta_c + q^(1 / gamma)))] thin . $


The threshold density contrast $delta_c$ and the $kappa$ parameter depend on how the primordial perturbations are smoothed~@Young:2019osy @Young:2020xmk @Gow:2020bzo as well as on the shape of individual peaks~@Musco:2018rwt @Young:2019yug @Escriva:2020tak @Escriva:2021pmf. We use $delta_c = 0.55$ and $kappa = 4.0$~@Young:2019yug.


We assume that the curvature perturbations are Gaussian,


$ P_k ( delta_l ) = frac(1, sqrt(2 pi) sigma_k) thin e^(- delta_l^2 / 2 sigma_k^2) thin , $<eq:delta_prob_dist>


where $sigma_k$ is the variance at scale $k$. The assumption of Gaussianity introduces potential inaccuracies as the curvature perturbations can develop non-Gaussianities in the form of an exponential tail in the probability distribution @eq:delta_prob_dist, which can lead the Gaussian expression to underestimate the PBH abundance by several orders of magnitude~@Pattison:2017mbe @Ezquiaga:2019ftu @Figueroa:2020jkf @Figueroa:2021zah.


The correction is model-dependent and requires a non-linear analysis. There is currently no simple semi-analytical way to compute it accurately. We use @eq:delta_prob_dist as a first approximation, keeping in mind that #emph[e.g.]~tuning the power spectrum height slightly can lead to comparable changes in the abundance. Neglecting the contribution of connected correlation functions of the curvature power spectrum~@DeLuca:2022rfz, the variance of $delta_l$ is obtained from the curvature power spectrum $cal(P)_(cal(R)) ( k )$~@Young:2019yug,


$ sigma_k^2 = (4 / 9)^2 integral_0^oo frac(upright(d) k', k') (k' / k)^(#h(-1em) 4) W^2 ( k' / k ) T^2 ( k' / k ) cal(P)_(cal(R)) ( k' ) thin . $<eq:sigmak>


Following Ref.~@Young:2019yug, we evaluate the variance using a real-space top-hat window function $W ( x ) = 3 ( sin x - x cos x ) / x^3$, and accounting for the damping of sub-horizon fluctuations with the linear transfer function $T ( x ) = 3 \[ sin ( x / sqrt(3) ) - x / sqrt(3) cos ( x / sqrt(3) ) \] / ( x / sqrt(3) )^3$. Finally, the present day PBH mass function, normalised to the PBH abundance, $integral upright(d) ln M psi ( M ) = Omega_(upright("PBH"))$, is


$ psi ( M ) & = integral upright(d) ln k thin beta_k ( M ) frac(rho_gamma ( T_k ), rho_c) frac(s ( T_0 ), s ( T_k )) thin\
 & tilde.eq frac(4 times 10^(- 12), gamma) #h(-1em) M / M_⊙ integral #h(-1em) frac(upright(d) k thin k^2, upright("Mpc")^(- 3)) frac(q^(1 / gamma) P_k ( delta_l ( M ) ), 1 - 3 / 4 delta_l ( M )) thin , $<eq:psiRD>


where $rho_gamma ( T )$ and $s ( T )$ are the radiation energy and entropy densities, and $rho_c$ denotes the critical energy density of the Universe.


// [figvision-cn] imgs/OmegaGW.png
// 这是一张单面板的对数-对数坐标曲线图，用于展示引力波能
// 量密度随波数变化的谱线。图中没有标记子图编号（如a、b、
// c等），因此按单图描述。 坐标轴方面，横轴为波数比 k/k*
// （无量纲），采用对数刻度，范围覆盖大约 0.02 至 30，主
// 刻度标注为 0.1、1、10；纵轴为 Ω_GW(k)/A_*²，即引力波能
// 量密度谱除以标量扰动振幅平方，同样采用对数刻度，范围从
// 10⁻⁹ 到 10⁻⁴，主刻度依次为 10⁻⁹、10⁻⁸、10⁻⁷、10⁻⁶、10⁻
// ⁵、10⁻⁴。 图中包含多条曲线，按颜色和线型区分： - 深紫
// 色粗实线：代表基准情形（对应正文中的实线情形），其幅值
// 整体最高。 - 红色细实线：代表另一种参数情形。 - 绿色虚
// 线：代表一个基准情形（benchmark case）。 - 橙色点划线：
// 代表另一个基准情形（benchmark case）。 所有曲线在 k/k*
// 接近 1 处呈现峰值特征，但峰值高度略有不同：深紫色实线
// 峰值约 2×10⁻⁵；红色实线、绿色虚线和橙色点划线峰值接近
// 1.5×10⁻⁵。在低波数区（k/k* < 0.1），所有曲线近似重合，
// 均按幂律上升，斜率在 log-log 图上约为 +2，即 Ω_GW ∝ k²。
// 在高波数区（k/k* > 1），曲线出现明显分歧：深紫色实线衰
// 减最慢，红色实线衰减最快（呈较陡的负幂律下降），绿色虚
// 线和橙色点划线介于二者之间；橙色点划线在 k/k* 约 3 之
// 后下降极为陡峭，在 k/k*≈5 附近跌破 10⁻⁹，超出图幅下边
// 界；红色实线在 k/k*≈20 处降至约 10⁻⁸，而深紫色实线在 k
// /k*≈30 处仍高于 10⁻⁸。整体趋势表明：引力波谱在 k/k*≈1
// 处出现峰值，低波数端所有模型趋于一致，高波数端的衰减速
// 率强烈依赖于模型参数——深紫色实线对应最“硬”的高频尾部，
// 橙色点划线对应最“软”的尾部；绿色虚线与橙色点划线在右侧
// 面板中彼此重合，但在本图中二者仅在低波数端重合，高波数
// 端存在显著差异。图中未显示任何额外标注文字、箭头或阴影
// 区域。
// [figvision-cn] imgs/OmegaGW.png
// 这是一张单面板的对数-对数坐标曲线图，用于展示引力波能
// 量密度随波数变化的谱线。图中没有标记子图编号（如a、b、
// c等），因此按单图描述。 坐标轴方面，横轴为波数比 k/k*
// （无量纲），采用对数刻度，范围覆盖大约 0.02 至 30，主
// 刻度标注为 0.1、1、10；纵轴为 Ω_GW(k)/A_*²，即引力波能
// 量密度谱除以标量扰动振幅平方，同样采用对数刻度，范围从
// 10⁻⁹ 到 10⁻⁴，主刻度依次为 10⁻⁹、10⁻⁸、10⁻⁷、10⁻⁶、10⁻
// ⁵、10⁻⁴。 图中包含多条曲线，按颜色和线型区分： - 深紫
// 色粗实线：代表基准情形（对应正文中的实线情形），其幅值
// 整体最高。 - 红色细实线：代表另一种参数情形。 - 绿色虚
// 线：代表一个基准情形（benchmark case）。 - 橙色点划线：
// 代表另一个基准情形（benchmark case）。 所有曲线在 k/k*
// 接近 1 处呈现峰值特征，但峰值高度略有不同：深紫色实线
// 峰值约 2×10⁻⁵；红色实线、绿色虚线和橙色点划线峰值接近
// 1.5×10⁻⁵。在低波数区（k/k* < 0.1），所有曲线近似重合，
// 均按幂律上升，斜率在 log-log 图上约为 +2，即 Ω_GW ∝ k²。
// 在高波数区（k/k* > 1），曲线出现明显分歧：深紫色实线衰
// 减最慢，红色实线衰减最快（呈较陡的负幂律下降），绿色虚
// 线和橙色点划线介于二者之间；橙色点划线在 k/k* 约 3 之
// 后下降极为陡峭，在 k/k*≈5 附近跌破 10⁻⁹，超出图幅下边
// 界；红色实线在 k/k*≈20 处降至约 10⁻⁸，而深紫色实线在 k
// /k*≈30 处仍高于 10⁻⁸。整体趋势表明：引力波谱在 k/k*≈1
// 处出现峰值，低波数端所有模型趋于一致，高波数端的衰减速
// 率强烈依赖于模型参数——深紫色实线对应最“硬”的高频尾部，
// 橙色点划线对应最“软”的尾部；绿色虚线与橙色点划线在右侧
// 面板中彼此重合，但在本图中二者仅在低波数端重合，高波数
// 端存在显著差异。图中未显示任何额外标注文字、箭头或阴影
// 区域。
#figure([#box(image("imgs/OmegaGW.png", height: 40.0%)) #box(image("imgs/OmegaPBH.png", height: 40.0%))

  ],
  caption: [
    The abundance of gravitational waves (left) and primordial black holes (right). The solid curves correspond to $lambda_2 = 1.916$ as in @fig:model_1_fits, the green dashed to $lambda_2 = 1.8$ and the orange dot-dashed to $lambda_2 = 3.0$. The latter two correspond to the benchmark cases shown in @fig:Akplot, and they overlap with the $Delta N_T = 0$ curve in the right panel. For each case $lambda_1 = 1.52$.
  ]
)
<fig:Omega>



Similarly as in Ref.~@Vaskonen:2020lbd, we find that for the curvature power spectrum~@eq:PR_delta, independently of $lambda_2$, the PBH mass function is of the form


$ psi ( M ) prop M^(1 + 1 / gamma) e^(- c_1 ( M / chevron.l M_(upright("PBH")) chevron.r )^(c_2)) thin , $<eq:mf>


where $c_1$ is fixed such that $chevron.l M_(upright("PBH")) chevron.r$ is the average PBH mass, and $c_2 tilde.eq 1$ has a mild dependence on the peak amplitude of the curvature power spectrum. The abundance of PBHs and their mean mass are given in terms of the curvature power spectrum peak position $k_(*)$ and amplitude $A_(*)$ by


$ Omega_(upright("PBH")) & tilde.eq c_Omega A_(*)^(c'_Omega) thin e^(- c_A / A_(*)) thin k_(*) / upright("Mpc")^(- 1) thin ,\
⟨M_(upright("PBH"))⟩ & tilde.eq c_M A_(*)^(c'_M) M_(k_(*)) thin , $<eq:fits>


where $c_Omega approx 30$, $c'_Omega approx 1.3$, $c_A approx 0.4$, $c_M approx 16$ and $c'_M approx 0.34$. As shown in the right panel of @fig:Omega, a non-instantaneous SR to USR transition only slightly changes the value of $A_(*)$ that gives rise to the particular PBH abundance.


In @fig:Akplot we use the spectrum~@eq:PR_delta for instantaneous SR to USR transitions and plot the projection of the PBH constraints in the plane of the amplitude $A_(*)$ and position $k_(*)$ of the maximum in the curvature power spectrum. The gray region in is excluded by the PBH constraints. These constraints arise from Hawking evaporation during big-bang nucleosynthesis and non-observation of extragalactic gamma-ray background from PBH evaporation~@Carr:2009jm @Acharya:2020jbv, microlensing results from Subaru/HSC~@Niikura:2017zjd @Smyth:2019whb, EROS~@Tisserand:2006zx, OGLE~@Niikura:2019kqi, Kepler~@Griest:2013aaa and MACHO~@Allsman:2000kg, GW event rate observed by LIGO-Virgo~@Hutsi:2020sol, lensing of type Ia supernovae~@Zumalacarregui:2017qqd, lensing of LIGO-Virgo events~@Urrutia:2021qak, survival of stars in dwarf galaxies~@Brandt:2016aco @Koushiappas:2017chw, survival of wide binaries~@Monroy-Rodriguez:2014ula, Lyman-$alpha$ forest data~@Afshordi:2003zb @Murgia:2019duy and limits on accretion~@Ricotti:2007au @Horowitz:2016lib @Ali-Haimoud:2016mbv @Poulin:2017bwe @Hektor:2018qqw @Hutsi:2019hlw @Serpico:2020ehh. The envelope of these constraints shown by the gray curve is calculated using the method introduced in~@Carr:2017jsz from the constraints for monochromatic mass functions to the mass function~@eq:mf.


== Gravitational waves
<sec:GWs>


// [figvision-cn] imgs/Akplot.png
// 这是一张用于展示不同观测手段对曲率功率谱峰值幅度限制及
// 未来实验预期灵敏度的双对数坐标图。图中没有子图划分。主
// 图横轴为波数 k*，单位为 Mpc⁻¹，采用对数刻度，范围从 10
// ⁻⁴ 到 10²⁰；纵轴为峰值幅度 A*，采用对数刻度，范围从 10
// ⁻⁹ 到 10⁻¹。图的上方还有一个辅助横轴，标注为 log₁₀[M_k
// */M_⊙]，采用线性刻度，从左至右数值由 18 递减至 -24，与
// 底部横轴相对应。图中包含多条实线和虚线。红色实线为
// Planck 卫星宇宙微波背景辐射观测给出的限制，位于图的左
// 下角，A* 约处于 10⁻⁹ 水平；红色虚线为 Planck 的预期灵
// 敏度，位于红色实线上方。灰色实线横贯图中部偏上，在 A*
// 约 10⁻² 至 10⁻¹ 之间形成一条包络线，标注 τ < t₀；其右
// 侧有一段水平黑色双向箭头并标注 τ < 1s。图中还包含多组
// 不同颜色的曲线，分别对应不同实验或观测手段的限制与预期
// 灵敏度。橙色曲线组包括 COBE/Firas y（实线及虚线）、
// PIXIE-like y（虚线）；蓝色曲线组包括 COBE/Firas μ（实
// 线及深色点线）、PIXIE-like μ（虚线）；紫色曲线组包括
// IPTA（虚线及点线）和 SKA（虚线）；绿色曲线组包括 LISA
// （虚线）；浅蓝色曲线组包括 AEDGE（虚线）；棕色曲线组包
// 括 AION（虚线）和 LIGO（虚线）；黄色曲线组包括 ET（虚
// 线）。图中所有实线表示已有的限制，虚线表示未来实验的预
// 期灵敏度。整体趋势显示，不同观测手段覆盖了从极低波数到
// 极高波数的宽广范围，且对于曲率功率谱峰值幅度给出了从
// 10⁻⁹ 到 10⁻¹ 量级的多样化约束，反映了当前及未来多波段
// 观测对早期宇宙物理过程的联合探测能力。
#figure(image("imgs/Akplot.png", width: 98.0%),
  caption: [
    Constraints (solid lines) and projected sensitivities of future experiments (dashed lines) on the peak amplitude $A_(*)$ of the curvature power spectrum as a function of the peak position $k_(*)$ in the case of an instantaneous SR to USR transition. The red solid and dashed lines in the bottom left corner correspond to $1 sigma$ and $3 sigma$ constraints from Planck CMB observations. The gray solid line corresponds to the envelope of the PBH constraints and the green line highlights the asteroid mass window where all DM could be in PBHs. The PBH lifetime $tau$ is evaluated for the average PBH mass. The parameters of the curvature power spectrum~@eq:PR_delta are fixed to $lambda_1 = 1.52$ and two cases for $lambda_2$ are shown: $lambda_2 = 1.8$ (smaller $A_(*)$ or weaker constraint) and $lambda_2 = 3.0$ (larger $A_(*)$ or stronger constraint).
  ]
)
<fig:Akplot>



Curvature perturbations induce formation of GWs at second order from the mode coupling~@Matarrese:1993zf @Matarrese:1997ay @Nakamura:2004rm @Ananda:2006af @Baumann:2007zm. Recently, these scalar-induced GWs (SIGWs) have been extensively studied (see for instance~@Domenech:2021ztg @Kohri:2018awv @Inomata:2019yww @DeLuca:2019ufz @Yuan:2019fwv @Atal:2021jyo), and the prospects for observing them have been considered~@Saito:2008jc @Assadullahi:2009jc @Bugaev:2010bb @Alabidi:2012ex @Inomata:2016rbd @Orlofsky:2016vbd @Espinosa:2018eve @Inomata:2018epa @Byrnes:2018txb @Cai:2018dig @Bartolo:2018rku @Wang:2019kaf @Yuan:2019udt @Chen:2019xse @Lewicki:2021xku @LISACosmologyWorkingGroup:2022jok. SIGWs have been searched for but not detected by the LIGO-Virgo collaboration~@Kapadia:2020pnr @Romero-Rodriguez:2021aws. However, it has been suggested that the recent NANOGrav result~@NANOGrav:2020bcs could be explained by SIGWs~@Vaskonen:2020lbd @DeLuca:2020agl @Kohri:2020qqd @Domenech:2020ers.


During radiation domination#footnote[We note that the SIGWs generally depend on the expansion history~@Hajkarim:2019nbx @Inomata:2019ivs @Inomata:2019zqy @Domenech:2019quo @Domenech:2020kqm.], GWs decouple from scalar perturbations soon after horizon crossing and their abundance reaches a constant value. The SIGW spectrum today is given by (see e.g.~@Kohri:2018awv @Inomata:2019yww)


$ Omega_(upright("GW")) ( k ) = 0.387 thin Omega_(upright(R)) (frac(106.75, g_(* , s)^4 g_(*)^(- 3)))^(#h(-1em) 1 / 3) 1 / 6 integral_(- 1)^1 #h(-1em) upright(d) x integral_1^oo #h(-1em) upright(d) y thin cal(P)_(cal(R)) #h(-1em) (frac(x - y, 2) k) cal(P)_(cal(R)) #h(-1em) (frac(x + y, 2) k) F ( x , y ) thin , $


where $Omega_(upright(R)) = 5.38 times 10^(- 5)$ is the radiation abundance~@Planck:2018vyg, the effective number of degrees of freedom are evaluated at the moment when the constant abundance is reached, roughly coinciding with the horizon crossing moment, and


$ F ( x , y ) = & frac(288 ( x^2 + y^2 - 6 )^2 ( x^2 - 1 )^2 ( y^2 - 1 )^2, ( x - y )^8 ( x + y )^8)\
 & times [(x^2 - y^2 + frac(x^2 + y^2 - 6, 2) log lr(|frac(y^2 - 3, x^2 - 3)|))^2 #h(-1em) + frac(pi^2 ( x^2 + y^2 - 6 )^2, 4) theta ( y - sqrt(3) )] . $


In the left panel of @fig:Omega we show the GW spectrum corresponding to the curvature power spectrum~@eq:PR_delta for three benchmark cases. In each case we have fixed $lambda_1 = 1.52$ to match the CMB observations, and for $lambda_2$ we consider three values, $1.8$ (green dashed), $1.916$ (solid) and $3.0$ (orange dot-dashed). Moreover, for $lambda_2 = 1.916$, we consider the GW spectra and PBH abundances for the curvature power spectrum of a non-instantaneous SR to USR transition~@eq:PR_box (compare to @fig:model_1_fits).


For a given shape of the peak in the curvature power spectrum, we can project the sensitivities of different GW observatories on the plane of the curvature power spectrum peak position $k_(*)$ and amplitude $A_(*)$. In @fig:Akplot we show in two benchmark cases of an instantaneous USR to SR transition, corresponding to $lambda_1 = 1.52$, $lambda_2 = 1.8$ and $lambda_1 = 1.52$ and $lambda_2 = 3.0$, these projections for IPTA~@Antoniadis:2022pcn, SKA~@Janssen:2014dka LISA~@LISA:2017pwj, AEDGE~@AEDGE:2019nxb @Badurina:2021rgt, AION~@Badurina:2019hst @Badurina:2021rgt, ET~@Sathyaprakash:2012jk and LIGO~@LIGOScientific:2014pky.#footnote[In @fig:Akplot we show the prospects for probing SIGWs with different future GW detectors. The prospects for probing the GWs from PBH binaries has been considered e.g. in Refs.~@DeLuca:2021hde @Mukherjee:2021itf @Pujolas:2021yaw @LISACosmologyWorkingGroup:2022jok @Ng:2022agi @Franciolini:2022htd.] We characterize the detectability of the GW signal by the signal-to-noise ratio


$ upright("SNR") = sqrt(cal(T) integral upright(d) f [frac(Omega_(upright("GW")) ( f ), Omega_(upright("sens")) ( f ))]^2) thin , $


where $cal(T)$ is the observation time and $Omega_(upright("sens")) ( f )$ the sensitivity of the given detector. We take $cal(T) = 5 thin$years and $upright("SNR") > 10$ for the threshold signal-to-noise ratio. By varying $Delta N_(upright(T))$ in the toy model for non-instantaneous transitions~@eq:PR_box, we checked that the sensitivities shown in @fig:Akplot are only marginally affected by the duration of the transition.


The values $lambda_2 = 1.8$ and $lambda_2 = 3.0$ enclose most of the phenomenologically interesting range. For instance, @tab:delta_models together with @eq:lambda_in_etaV gives the values $lambda_2 = 1.83$ and $lambda_2 = 2.05$---these correspond to spectra with relatively flat $cal(P)_(cal(R))$ peaks producing solar mass PBHs and steeper peaks required for populating the asteroid mass PBH DM window, respectively. However, the identification $lambda_2$ with the PBH mass is not unique and depends on other features of the inflationary scenario, such as the duration of inflation and whether it ends after the dual USR+CR phase during which the peak is produced (compare, for instance, Model I and Model III in @fig:example_models).


== CMB constraints
<sec:CMB>


The CMB observations directly strongly constrain the curvature power spectrum at scales $10^(-4) upright("Mpc")^(-1) gt.tilde k gt.tilde 1 upright("Mpc")^(-1)$. In @fig:Akplot we show with dark red curves the $1 sigma$ and $3 sigma$ Planck constraints on the evolution of the curvature power spectrum from Ref.~@Planck:2018nkj.


At redshifts $z lt.tilde 10^6$ energy injections into the primordial plasma cause persisting spectral distortions in the CMB. These distortions are divided into chemical potential $mu$-type distortions created at early times and Compton $y$-type distortions created at $z lt.tilde 5 times 10^4$. For a given curvature power spectrum $cal(P)_(cal(R)) ( k )$ the $X = mu , y$ spectral distortions are~@Chluba:2012we @Chluba:2013dna


$ X = integral_(k_(upright("min")))^oo frac(upright(d) k, k) thin cal(P)_(cal(R)) ( k ) W_X ( k ) thin , $


where $k_(upright("min")) = 1 thin upright("Mpc")^(- 1)$ and the window functions can be approximated by


$ W_mu ( k ) = 2.2 [e^(- frac(( hat(k) / 1360 )^2, 1 + ( hat(k) / 260 )^0.6 + hat(k) / 340)) - e^(- (hat(k) / 32)^2)] thin , #h(2em) W_y ( k ) = 0.4 e^(- (hat(k) / 32)^2) thin , $


with $hat(k) = k / ( 1 thin upright("Mpc")^(- 1) )$.


The COBE/Firas observations constrain the $mu$ and $y$ distortions as $mu lt.eq 9 times 10^(- 5)$ and $y lt.eq 1.5 times 10^(- 5)$~@Fixsen:1996nj at $95 "%"$ CL. These imply strong constraints on the curvature power spectrum in the range $k lt.tilde 10^4 upright("Mpc")^(- 1)$~@Chluba:2012we @Chluba:2013dna. Moreover, a PIXIE-like detector could probe distortions as small as $mu lt.eq 2 times 10^(- 8)$ and $y lt.eq 0.4 times 10^(- 8)$~@Kogut:2011xw. We show the COBE/Firas constraints as well as the projections of a PIXIE-like detector sensitivity in @fig:Akplot for two benchmark cases of the curvature power spectrum~@eq:PR_delta. We find that the $mu$-distortion constraints exclude single-field formation of PBHs heavier than $10^4 M_⊙$. Importantly, we find that this constraint is negligibly affected by variations in model parameters.


= Conclusions
<sec:concl>


We have considered the general structure of single-field inflationary models capable of producing peaked curvature spectra. We have restricted our study to models in which an Einstein frame exists and the dynamics can be captured by a single function---the Einstein frame potential. In such cases, both numerical and analytic approaches indicate that inflation can be divided into the following epochs:


- #emph[Slow-roll]. Typically the density fluctuations at the CMB scale are produced in this phase.

- #emph[Slow-roll to ultra-slow-roll transition]. This phase will involve violation of the slow-roll conditions or even a brief exit from an inflationary cosmology. The power spectrum begins to grow slightly before this phase. The details of this phase vary the most from model to model. For instance, it can be triggered by a small maximum in the potential or by rolling through its global minimum.

- #emph[Ultra-slow-roll]. The field starts to rapidly lose its velocity either by climbing up a hill in the potential or by rolling down a near plateau. The power spectrum typically reaches its peak during this phase.

- #emph[Constant-roll] (or also slow-roll). The velocity of the field begins to grow as the field begins to roll down the potential constantly (or slowly). If the potential is continuous, this phase is dual to the previous one and sets the declining slope of the power spectrum peak.


We have omitted a transitory period from ultra-slow-roll to constant-roll from the above list because it is entirely described by the duality of its neighbouring phases. All listed phases are present in single-field inflationary models for PBHs and can contribute to the enhanced curvature power spectrum.


Assuming instantaneous slow-roll to ultra-slow-roll transitions, we have constructed an analytically solvable scenario that accounts for the inherent duality between the consecutive ultra-slow-roll and constant-roll phases. Such transitions can arise from piecewise quadratic potentials. The resulting curvature power spectrum can be consistent with CMB observations and can include a high peak that leads to a significant abundance of PBHs of any mass. The curvature power spectrum in this case oscillates at small scales below the peak. Relying on our analytic estimates, we have devised a simple analytic prescription in @eq:PR_delta_approx that allows to approximate peaked power spectra for general single-field inflationary models.


We have studied how the shape of the peak depends on details of the slow-roll to ultra-slow-roll transition by constructing simplified solvable models in which the duration of this transition can be easily varied. The oscillations found in the case of instantaneous transition get smoother for slower transitions. These models can be considered as limiting cases of smooth physical potentials. In particular, we conclude that, in general single-field models for PBHs, the tails of the peak in the power spectrum can be determined from the potential alone via the second potential slow-roll parameter, while the exact shape of the peak (for instance the presence of oscillating features) depends on the details of how the initial slow-roll phase transitions into the subsequent ultra-slow-roll phase.


We have considered how the shape of the peak in the power spectrum affects the PBH abundance and the related scalar-induced GWs. A firm grasp of this relation is crucial for probing PBH phenomenology via GW observations. We have found that, although the details of the peak shape can affect the PBH abundance by a few orders of magnitude, the prospects for the detection of scalar-induced GWs as well the power spectrum amplitude required for abundant PBH production are quite insensitive to it. Next-generation GW detectors such as LISA and AEDGE are expected to probe the entire asteroid mass window for PBH dark matter. The COBE/Firas $mu$-distortion constraints exclude the production of PBHs heavier than $10^4 M_⊙$ in single-field inflation.





#heading(numbering: none)[Acknowledgments]

This work was supported by the Estonian Research Council grants PRG803, PRG1055, PSG761, and MOBTT5, the EU through the European Regional Development Fund CoE program TK133 “The Dark Side of the Universe”, the Spanish MINECO grants IJC2019-041533-I, FPA2017-88915-P and SEV-2016-0588, the Spanish MICINN (PID2020-115845GB-I00/AEI/10.13039/501100011033), and the grant 2017-SGR-1069 from the Generalitat de Catalunya. IFAE is partially funded by the CERCA program of the Generalitat de Catalunya.





= Potentials and parameters for the example models
<app:examples>


The inflationary models given as an example in @fig:example_models of @sec:theory have actions of the form


$ S = integral upright(d)^4 x thin sqrt(- g) (1 / 2 M_(upright(P))^2 Omega ( sigma ) R - 1 / 2 K ( sigma ) ( partial sigma )^2 - V ( sigma )) thin , $


where $sigma$ is the inflaton, $Omega ( sigma )$ contains the non-minimal couplings, $K$ accounts for the possibility of a non-canonical kinetic term, $V$ is the potential, $V ( v ) = 0$ at the vacuum with $sigma = v$, and $M_(upright(P)) = 2.4 times 10^18 upright("GeV")$ is the reduced Planck mass. In the following sections, we specify these functions for the different models. All parameter values are gathered in @tab:example_model_parameters, and the inflationary observables are presented in @tab:example_model_observables. To compute the results, we have performed the appropriate field redefinitions and conformal transformations @Jarv:2016sow to eliminate $Omega$ and $K$ and bring the action back to the standard form @eq:S_standard.


== Model I: non-minimal polynomial inflation
<sec:poly_model>


This model is defined by


$ V = 1 / 2 m^2 sigma^2 + 1 / 3 mu sigma^3 + 1 / 4 lambda sigma^4 , #h(2em) Omega = 1 + xi sigma^2 / M_(upright(P))^2 , #h(2em) K = 1 thin , $


inspired by~@Kannike:2017bxn @Ballesteros:2017fsr @Ballesteros:2020qam. The cubic term can be used to create a small maximum in the potential. Following~@Kannike:2017bxn, we reparametrize the model in terms of the extrema of the Einstein frame potential $V_E equiv V / Omega^2$ at $sigma = v_i$, $i = 1 , 2 , 3$, giving


$ m^2 = 1 / 2 lambda frac(v_2 v_3 ( xi v_2 v_3 + 3 M_(upright(P))^2 ) M_(upright(P))^2, xi^2 v_2^2 v_3^2 - xi ( v_2 - v_3 )^2 M_(upright(P))^2 + 3 M_(upright(P))^4) thin , #h(2em) mu = - frac(lambda ( v_2 + v_3 ) M_(upright(P))^4, xi^2 v_2^2 v_3^2 - xi ( v_2 - v_3 )^2 M_(upright(P))^2 + 3 M_(upright(P))^4) thin . $


We use $v_1 lt.eq v_2 lt.eq v_3$, where, by construction, the trivial extremum lies at the origin, $v_1 = 0$. An exact inflection point corresponds to $v_2 = v_3$. The second potential SR parameter at the local maximum $v_2$ is


$ eta_(V , c) = - frac(4 ( v_3 - v_2 ) ( xi v_2 ( v_2 + 2 v_3 ) + 3 M_(upright(P))^2 ) M_(upright(P))^4, v_2^2 (xi ( 6 xi + 1 ) v_2^2 + M_(upright(P))^2) (2 v_3 M_(upright(P))^2 - v_2 (M_(upright(P))^2 - xi v_3^2))) thin . $


By Eq.'s @eq:PR_CR and @eq:lambda_in_etaV, it gives the high $k$ slope of the $cal(P)_(cal(R))$ peak. The observables of @fig:example_models are computed in the Einstein frame, with the canonical field $phi.alt$ solved numerically from


$ frac(upright(d) phi.alt, upright(d) sigma) = frac(1, Omega ( sigma )) sqrt(Omega ( sigma ) + frac(3 M_(upright(P))^2, 2) (frac(upright(d) Omega ( sigma ), upright(d) sigma))^2) thin . $<eq:field_transforamtion>


#figure([#table(
    stroke: none,
    columns: 5,
    align: (center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Model], table.cell(align: center, colspan: 4)[Parameters],),
    table.hline(),
    [I], [$lambda = 2.10 times 10^(- 5)$], [$xi = 80.0118$], [$v_2 = 0.08 M_(upright(P))$], [$v_3 = 0.0855714 M_(upright(P))$],
    [II], [$V_0 = 1.89 times 10^(- 10) M_(upright(P))^4$], [$alpha = 1$], [$A = 0.130383$], [$f_sigma = 0.129576$],
    [III], [$V_0 = 7.03 times 10^(- 11) M_(upright(P))^4$], [$A = 1.17 times 10^(- 3)$], [$phi.alt_0 = 2.188 M_(upright(P))$], [$Delta = 1.59 times 10^(- 2) M_(upright(P))$],
    table.hline(stroke: 0.8pt),
  )], caption: [Parameter values for the models I, II, and III plotted in @fig:example_models. No digits have been omitted: all numerical computations were performed with these exact values. See @sec:poly_model, @sec:alpha_attr_model, @sec:bump_model for the expressions for the potentials.]
  , kind: table
  )
<tab:example_model_parameters>






== Model II: $alpha$-attractor inflation
<sec:alpha_attr_model>


This model, from @Dalianis:2018frf, is defined in the setup of superconformal $alpha$-attractor models, with the inflaton sector given by


$ V = f^2 (frac(sigma, sqrt(3) M_(upright(P)))) , #h(2em) Omega = 1 , #h(2em) K = frac(2 alpha, (1 - frac(sigma^2, 3 M_(upright(P))^2))^2) thin . $


The kinetic term is canonical for the redefined field


$ phi.alt = sqrt(6 alpha) M_(upright(P)) tanh^(- 1) frac(sigma, sqrt(3) M_(upright(P))) thin , $


and we pick a model with $f ( x ) = lambda (x + A sin x / f_sigma)$ and $alpha = 1$, so that the canonical potential reads


$ V ( phi.alt ) = V_0 [tanh (frac(phi.alt, sqrt(6) M_(upright(P)))) + A sin (f_sigma^(- 1) tanh (frac(phi.alt, sqrt(6) M_(upright(P)))))]^2 thin , #h(2em) V_0 = lambda^2 thin . $<eq:alpha_attr_V>


The sinusoidal modulation produces an inflection point to the otherwise plateau-like potential. In the notation of @Dalianis:2018frf, this is Model II, and we use their parametrization \#1, reproduced in @tab:example_model_parameters.


== Model III: modified KKLT inflation
<sec:bump_model>


This model, from @Mishra:2019pzq, is a modified version of the string theory based KKLT inflation, defined by


$ V = V_0 frac(phi.alt^2, ( M_(upright(P)) / 2 )^2 + phi.alt^2) (1 + epsilon.alt ( phi.alt )) thin , #h(2em) Omega = 1 thin , #h(2em) K = 1 thin . $


Gravity and the kinetic term are canonical from the get-go. The base plateau potential is modified by a small Gaussian bump,


$ epsilon.alt ( phi.alt ) = A thin e^(- ( phi.alt - phi.alt_0 )^2 / ( 2 Delta^2 )) thin , $


and dynamics around this bump enhance the power spectrum. We use one of the parameter sets given in @Mishra:2019pzq.


#figure([#table(
    stroke: none,
    columns: 9,
    align: (center,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Model], [$n_s$], [$r$], [$N_(upright("CMB"))$], [$phi.alt_(upright("CMB")) / M_(upright(P))$], [$k_(upright("peak"))$ (Mpc$""^(- 1)$)], [$cal(P)_(cal(R)) zws_(upright("peak"))$], [$M_(upright("PBH"))$ (g)], [],),
    table.hline(),
    [I], [$0.947$], [$0.023$], [$56.9$], [$6.78$], [$1.25 times 10^14$], [$0.035$], [$1.79 times 10^18$], [],
    [II], [$0.945$], [$0.0075$], [$56.7$], [$5.85$], [$9.09 times 10^13$], [$0.017$], [$3.37 times 10^18$], [],
    [III], [$0.968$], [$0.0022$], [$60.0$], [$3.08$], [$2.18 times 10^14$], [$0.0016$], [$5.88 times 10^17$], [],
    table.hline(stroke: 0.8pt),
  )], caption: [Inflationary observables for the models I, II, and III. For models II and III, these differ slightly from those reported in the original articles @Dalianis:2018frf and @Mishra:2019pzq, presumably due to the limited numerical accuracy of the input parameter values given there.]
  , kind: table
  )
<tab:example_model_observables>






= Solution of the non-instantaneous transition model
<app:box>


The ansatz~@eq:box for $z$ splits the background evolution into three periods as in @eq:z_box, $ z = cases(
    zeta_1 e^(( lambda_1 - 1 / 2 ) ( N - N_1 )) , & quad N < N_1,
    tilde(zeta)_(+) e^(( i tilde(lambda) - 1 / 2 ) ( N - N_1 )) + tilde(zeta)_(-) e^(( - i tilde(lambda) - 1 / 2 ) ( N - N_1 )) , & quad N_1 < N < N_2,
    zeta_(2 +) e^(( lambda_2 - 1 / 2 ) ( N - N_2 )) + zeta_(2 -) e^(( - lambda_2 - 1 / 2 ) ( N - N_2 )) , & quad N_2 < N
  ) thin , $ where the $zeta_i$ coefficients are determined by continuity of $z$ and $z'$. Their explicit forms are $zeta_(1 plus.minus) / zeta_1 = ( 1 minus.plus i lambda_1 / tilde(lambda) ) / 2$ and


$ zeta_(2 plus.minus) / zeta_1 = e^(- Delta N_(upright(T)) / 2) 1 / 2 [(1 plus.minus lambda_1 / lambda_2) cos ( tilde(lambda) Delta N_(upright(T)) ) + (lambda_1 / tilde(lambda) minus.plus tilde(lambda) / lambda_2) sin ( tilde(lambda) Delta N_(upright(T)) )] thin . $


The coefficient $zeta_(2 +)$ enters in the curvature power spectrum. The instantaneous case @eq:insta is obtained in the limit $Delta N_(upright(T)) arrow.r 0$ with $Delta N_(upright(T)) tilde(lambda)^2 equiv cal(A)$ kept constant.


The corresponding general solution of the MS equation~@eq:MS is $ u_k = cases(
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_1 )) [ c_(1 +) J_(- lambda_1) ( k / cal(H) ) + c_(1 -) J_(lambda_1) ( k / cal(H) ) ] , & quad N < N_1,
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi i tilde(lambda) )) [ tilde(c)_(+) J_(- i tilde(lambda)) ( k / cal(H) ) + tilde(c)_(-) J_(i tilde(lambda)) ( k / cal(H) ) ] , & quad N_1 < N < N_2,
    frac(sqrt(pi), sqrt(cal(H)) 2 sin ( pi lambda_2 )) [ c_(2 +) J_(- lambda_2) ( k / cal(H) ) + c_(2 -) J_(lambda_2) ( k / cal(H) ) ] , & quad N_2 < N
  ) thin . $ The solution must match the Bunch-Davies vacuum~@eq:BD_cond at $N arrow.r - oo$. This gives the solution at $N_1$,


$ u_k = 1 / sqrt(cal(H)) sqrt(pi) / 2 e^(i ( nu + 1 / 2 ) pi / 2) H_nu^(( 1 )) (k / cal(H)) thin , #h(2em) N < N_1 . $


The coefficients $c_i$ are solved by demanding continuity of $u_k$ and its first derivative. The coefficients are


$ tilde(c)_plus.minus & = minus.plus pi / 2 e^(i (lambda_1 + 1 / 2) pi / 2) [J'_(plus.minus i tilde(lambda)) H_(lambda_1)^(( 1 )) - J_(plus.minus i tilde(lambda)) H_(lambda_1)^(( 1 ))']\|_(N = N_1) ,\
c_(2 plus.minus) & = minus.plus frac(pi, 2 sin ( pi i tilde(lambda) )) \[ tilde(c)_(+) (J_(- i tilde(lambda)) J'_(plus.minus lambda_2) - J'_(- i tilde(lambda)) J_(plus.minus lambda_2)) + tilde(c)_(-) (J_(i tilde(lambda)) J'_(plus.minus lambda_2) - J'_(i tilde(lambda)) J_(plus.minus lambda_2)) \]\|_(N = N_2) , $


where the prime denotes differentiation with respect to the number of $e$-folds $N$. The coefficient $c_(2 +)$ enters the power spectrum. It can be expressed as


$ c_(2 +) = frac(pi^2 k^2 e^(i (lambda_1 + 1 / 2) pi / 2), 4 cal(H)_1 cal(H)_2 sin ( i pi tilde(lambda) )) & \[ ( B_1 B_2 ) J_(lambda_2) ( x_2 ) H_(lambda_1)^(( 1 )) ( x_1 )\
 & + ( ( B_2 C_1 ) J_(lambda_2) ( x_2 ) H_(lambda_1 - 1)^(( 1 )) ( x_1 ) + ( C_2 B_1 ) J_(lambda_2 - 1) ( x_2 ) H_(lambda_1)^(( 1 )) ( x_1 ) )\
 & + ( C_1 C_2 ) J_(lambda_2 + 1) ( x_2 ) H_(lambda_1 - 1)^(( 1 )) ( x_1 ) - ( i tilde(lambda) arrow.l.r - i tilde(lambda) ) \] , $<c3PlusModified>


where $x_i equiv k / cal(H)_i equiv k / cal(H) ( N_i )$, and


$  & B_1 = 1 / 2 (1 - frac(lambda_1, i tilde(lambda))) J_(- i tilde(lambda) - 1) ( x_1 ) - 1 / 2 (1 + frac(lambda_1, i tilde(lambda))) J_(- i tilde(lambda) + 1) ( x_1 ) ,\
 & B_2 = 1 / 2 (1 - frac(lambda_2, i tilde(lambda))) J_(i tilde(lambda) - 1) ( x_2 ) - 1 / 2 (1 + frac(lambda_2, i tilde(lambda))) J_(i tilde(lambda) + 1) ( x_2 ) ,\
 & C_1 = - J_(- i tilde(lambda)) ( x_1 ) , #h(2em) C_2 = J_(i tilde(lambda)) ( x_2 ) .\
 $


The first term in @c3PlusModified is responsible for the initial CMB part of the power spectrum. However, it also contributes to the peak in the power spectrum. Although its contribution is relatively minor, it is responsible for removing the oscillations from the peak when the duration of the transitional period is sufficiently long.


In the limit $Delta N_(upright(T)) arrow.r 0$ with $Delta N_(upright(T)) tilde(lambda)^2 equiv cal(A)$ fixed, we can use $J_(i tilde(lambda)) ( x ) arrow.r ( x / 2 )^(i tilde(lambda)) / Gamma ( 1 + i tilde(lambda) )$ and we recover $c_(2 +)$ in the instantaneous case @c2PlusDelta.

#show bibliography: set text(size: 10pt)
#show bibliography: set par(leading: 0.48em)
#bibliography("refs.bib", title: [References])