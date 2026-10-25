// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.36cm), columns: 1)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set text(size: 9pt)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(size: 12pt, weight: "bold")[Improved measurement of neutrino oscillation parameters by the NOvA experiment]
]

#v(0.9em)

#align(center)[
  #set text(size: 10pt)
  #show super: set text(size: 7pt)
  #par(justify: true, leading: 0.59em)[M. A. Acero,#super[2] P. Adamson,#super[12] L. Aliaga,#super[12] N. Anfimov,#super[26] A. Antoshkin,#super[26] E. Arrieta-Diaz,#super[28] L. Asquith,#super[41] A. Aurisano,#super[6] A. Back,#super[20, 24] C. Backhouse,#super[45] M. Baird,#super[20, 41, 46] N. Balashov,#super[26] P. Baldi,#super[25] B. A. Bambah,#super[17] S. Bashar,#super[44] K. Bays,#super[4, 19] R. Bernstein,#super[12] V. Bhatnagar,#super[34] D. Bhattarai,#super[32] B. Bhuyan,#super[14] J. Bian,#super[25, 31] J. Blair,#super[16] A. C. Booth,#super[41] R. Bowles,#super[20] C. Bromberg,#super[29] N. Buchanan,#super[8] A. Butkevich,#super[22] S. Calvez,#super[8] T. J. Carroll,#super[43, 49] E. Catano-Mur,#super[48] B. C. Choudhary,#super[10] A. Christensen,#super[8] T. E. Coan,#super[39] M. Colo,#super[48] L. Cremonesi,#super[36, 45] G. S. Davies,#super[32, 20] P. F. Derwent,#super[12] P. Ding,#super[12] Z. Djurcic,#super[1] M. Dolce,#super[44] D. Doyle,#super[8] D. Dueñas Tonguino,#super[6] E. C. Dukes,#super[46] H. Duyang,#super[38] R. Ehrlich,#super[46] M. Elkins,#super[24] E. Ewart,#super[20] G. J. Feldman,#super[15] P. Filip,#super[23] J. Franc,#super[9] M. J. Frank,#super[37] H. R. Gallagher,#super[44] R. Gandrajula,#super[29, 46] F. Gao,#super[35] A. Giri,#super[18] R. A. Gomes,#super[13] M. C. Goodman,#super[1] V. Grichine,#super[27] M. Groh,#super[8, 20] R. Group,#super[46] B. Guo,#super[38] A. Habig,#super[30] F. Hakl,#super[21] A. Hall,#super[46] J. Hartnell,#super[41] R. Hatcher,#super[12] H. Hausner,#super[49] M. He,#super[16] K. Heller,#super[31] V Hewes,#super[6] A. Himmel,#super[12] A. Holin,#super[45] J. Huang,#super[43] B. Jargowsky,#super[25] J. Jarosz,#super[8] F. Jediny,#super[9] C. Johnson,#super[8] M. Judah,#super[8, 35] I. Kakorin,#super[26] D. M. Kaplan,#super[19] A. Kalitkina,#super[26] R. Keloth,#super[7] O. Klimov,#super[26] L. W. Koerner,#super[16] L. Kolupaeva,#super[26] S. Kotelnikov,#super[27] R. Kralik,#super[41] Ch. Kullenberg,#super[26] M. Kubu,#super[9] A. Kumar,#super[34] C. D. Kuruppu,#super[38] V. Kus,#super[9] T. Lackey,#super[20] K. Lang,#super[43] P. Lasorak,#super[41] J. Lesmeister,#super[16] S. Lin,#super[8] A. Lister,#super[49] J. Liu,#super[25] M. Lokajicek,#super[23] S. Magill,#super[1] M. Manrique Plata,#super[20] W. A. Mann,#super[44] M. L. Marshak,#super[31] M. Martinez-Casales,#super[24] V. Matveev,#super[22] B. Mayes,#super[41] D. P. Méndez,#super[41] M. D. Messier,#super[20] H. Meyer,#super[47] T. Miao,#super[12] W. H. Miller,#super[31] S. R. Mishra,#super[38] A. Mislivec,#super[31] R. Mohanta,#super[17] A. Moren,#super[30] A. Morozova,#super[26] W. Mu,#super[12] L. Mualem,#super[4] M. Muether,#super[47] S. Mufson,#super[20] K. Mulder,#super[45] D. Naples,#super[35] N. Nayak,#super[25] J. K. Nelson,#super[48] R. Nichol,#super[45] E. Niner,#super[12] A. Norman,#super[12] A. Norrick,#super[12] T. Nosek,#super[5] H. Oh,#super[6] A. Olshevskiy,#super[26] T. Olson,#super[44] J. Ott,#super[25] J. Paley,#super[12] R. B. Patterson,#super[4] G. Pawloski,#super[31] O. Petrova,#super[26] R. Petti,#super[38] D. D. Phan,#super[43, 45] R. K. Plunkett,#super[12] J. C. C. Porter,#super[41] A. Rafique,#super[1] F. Psihas,#super[20, 43] V. Raj,#super[4] M. Rajaoalisoa,#super[6] B. Ramson,#super[12] B. Rebel,#super[12, 49] P. Rojas,#super[8] P. Roy,#super[47] V. Ryabov,#super[27] O. Samoylov,#super[26] M. C. Sanchez,#super[24] S. Sánchez Falero,#super[24] P. Shanahan,#super[12] A. Sheshukov,#super[26] P. Singh,#super[10] V. Singh,#super[3] E. Smith,#super[20] J. Smolik,#super[9] P. Snopok,#super[19] N. Solomey,#super[47] A. Sousa,#super[6] K. Soustruznik,#super[5] M. Strait,#super[31] L. Suter,#super[12] A. Sutton,#super[46] S. Swain,#super[33] C. Sweeney,#super[45] A. Sztuc,#super[45] R. L. Talaga,#super[1] B. Tapia Oregui,#super[43] P. Tas,#super[5] T. Thakore,#super[6] R. B. Thayyullathil,#super[7] J. Thomas,#super[45, 49] E. Tiras,#super[11, 24] J. Tripathi,#super[34] J. Trokan-Tenorio,#super[48] A. Tsaris,#super[12] Y. Torun,#super[19] J. Urheim,#super[20] P. Vahle,#super[48] Z. Vallari,#super[4] J. Vasel,#super[20] P. Vokac,#super[9] T. Vrba,#super[9] M. Wallbank,#super[6] T. K. Warburton,#super[24] M. Wetstein,#super[24] D. Whittington,#super[42, 20] D. A. Wickremasinghe,#super[12] S. G. Wojcicki,#super[40] J. Wolcott,#super[44] W. Wu,#super[25] Y. Xiao,#super[25] A. Yallappa Dombara,#super[42] A. Yankelevich,#super[25] K. Yonehara,#super[12] S. Yu,#super[1, 19] Y. Yu,#super[19] S. Zadorozhnyy,#super[22] J. Zalesak,#super[23] Y. Zhang,#super[41] R. Zwaska,#super[12]]
]

#v(0.4em)

#align(center)[#text(size: 10pt)[(The NOvA Collaboration)]]

#v(0.7em)

#align(center)[#block(width: 100%)[
  #set text(size: 9pt, style: "italic")
  #show super: set text(size: 6pt, style: "normal")
  #set par(justify: true, leading: 0.58em)
  #super[1]Argonne National Laboratory, Argonne, Illinois 60439, USA #linebreak() #super[2]Universidad del Atlantico, Carrera 30 No. 8-49, Puerto Colombia, Atlantico, Colombia #linebreak() #super[3]Department of Physics, Institute of Science, Banaras Hindu University, Varanasi, 221 005, India #linebreak() #super[4]California Institute of Technology, Pasadena, California 91125, USA #linebreak() #super[5]Charles University, Faculty of Mathematics and Physics, Institute of Particle and Nuclear Physics, Prague, Czech Republic #linebreak() #super[6]Department of Physics, University of Cincinnati, Cincinnati, Ohio 45221, USA #linebreak() #super[7]Department of Physics, Cochin University of Science and Technology, Kochi 682 022, India #linebreak() #super[8]Department of Physics, Colorado State University, Fort Collins, CO 80523-1875, USA #linebreak() #super[9]Czech Technical University in Prague, Brehova 7, 115 19 Prague 1, Czech Republic #linebreak() #super[10]Department of Physics and Astrophysics, University of Delhi, Delhi 110007, India #linebreak() #super[11]Department of Physics, Erciyes University, Kayseri 38030, Turkey #linebreak() #super[12]Fermi National Accelerator Laboratory, Batavia, Illinois 60510, USA #linebreak() #super[13]Instituto de Física, Universidade Federal de Goiás, Goiânia, Goiás, 74690-900, Brazil #linebreak() #super[14]Department of Physics, IIT Guwahati, Guwahati, 781 039, India #linebreak() #super[15]Department of Physics, Harvard University, Cambridge, Massachusetts 02138, USA #linebreak() #super[16]Department of Physics, University of Houston, Houston, Texas 77204, USA #linebreak() #super[17]School of Physics, University of Hyderabad, Hyderabad, 500 046, India #linebreak() #super[18]Department of Physics, IIT Hyderabad, Hyderabad, 502 205, India #linebreak() #super[19]Illinois Institute of Technology, Chicago IL 60616, USA #linebreak() #super[20]Indiana University, Bloomington, Indiana 47405, USA #linebreak() #super[21]Institute of Computer Science, The Czech Academy of Sciences, 182 07 Prague, Czech Republic #linebreak() #super[22]Institute for Nuclear Research of Russia, Academy of Sciences 7a, 60th October Anniversary prospect, Moscow 117312, Russia #linebreak() #super[23]Institute of Physics, The Czech Academy of Sciences, 182 21 Prague, Czech Republic #linebreak() #super[24]Department of Physics and Astronomy, Iowa State University, Ames, Iowa 50011, USA #linebreak() #super[25]Department of Physics and Astronomy, University of California at Irvine, Irvine, California 92697, USA #linebreak() #super[26]Joint Institute for Nuclear Research, Dubna, Moscow region 141980, Russia #linebreak() #super[27]Nuclear Physics and Astrophysics Division, Lebedev Physical Institute, Leninsky Prospect 53, 119991 Moscow, Russia #linebreak() #super[28]Universidad del Magdalena, Carrera 32 No 22-08 Santa Marta, Colombia #linebreak() #super[29]Department of Physics and Astronomy, Michigan State University, East Lansing, Michigan 48824, USA #linebreak() #super[30]Department of Physics and Astronomy, University of Minnesota Duluth, Duluth, Minnesota 55812, USA #linebreak() #super[31]School of Physics and Astronomy, University of Minnesota Twin Cities, Minneapolis, Minnesota 55455, USA #linebreak() #super[32]University of Mississippi, University, Mississippi 38677, USA #linebreak() #super[33]National Institute of Science Education and Research, Khurda, 752050, Odisha, India #linebreak() #super[34]Department of Physics, Panjab University, Chandigarh, 160 014, India #linebreak() #super[35]Department of Physics, University of Pittsburgh, Pittsburgh, Pennsylvania 15260, USA #linebreak() #super[36]School of Physics and Astronomy, Queen Mary University of London, London E1 4NS, United Kingdom #linebreak() #super[37]Department of Physics, University of South Alabama, Mobile, Alabama 36688, USA #linebreak() #super[38]Department of Physics and Astronomy, University of South Carolina, Columbia, South Carolina 29208, USA #linebreak() #super[39]Department of Physics, Southern Methodist University, Dallas, Texas 75275, USA #linebreak() #super[40]Department of Physics, Stanford University, Stanford, California 94305, USA #linebreak() #super[41]Department of Physics and Astronomy, University of Sussex, Falmer, Brighton BN1 9QH, United Kingdom #linebreak() #super[42]Department of Physics, Syracuse University, Syracuse NY 13210, USA #linebreak() #super[43]Department of Physics, University of Texas at Austin, Austin, Texas 78712, USA #linebreak() #super[44]Department of Physics and Astronomy, Tufts University, Medford, Massachusetts 02155, USA #linebreak() #super[45]Physics and Astronomy Department, University College London, Gower Street, London WC1E 6BT, United Kingdom #linebreak() #super[46]Department of Physics, University of Virginia, Charlottesville, Virginia 22904, USA #linebreak() #super[47]Department of Mathematics, Statistics, and Physics, Wichita State University, Wichita, Kansas 67206, USA #linebreak() #super[48]Department of Physics, William & Mary, Williamsburg, Virginia 23187, USA #linebreak() #super[49]Department of Physics, University of Wisconsin-Madison, Madison, Wisconsin 53706, USA
]]

#v(0.6em)

#align(center)[#block(width: 80%)[
  #set text(size: 9pt)
  #set par(justify: true, leading: 0.55em)
  #set align(left)
  We present new $nu_mu -> nu_e$, $nu_mu -> nu_mu$, $macron(nu)_mu -> macron(nu)_e$, and $macron(nu)_mu -> macron(nu)_mu$ oscillation measurements by the NOvA experiment, with a 50% increase in neutrino-mode beam exposure over the previously reported results. The additional data, combined with previously published neutrino and antineutrino data, are all analyzed using improved techniques and simulations. A joint fit to the $nu_e$, $nu_mu$, $macron(nu)_e$, and $macron(nu)_mu$ candidate samples within the 3-flavor neutrino oscillation framework continues to yield a best-fit point in the normal mass ordering and the upper octant of the $theta_23$ mixing angle, with $Delta m_32^2 = (2.41 plus.minus 0.07) times 10^(-3) thin "eV"^2$ and $sin^2 theta_23 = 0.57_(-0.04)^(+0.03)$. The data disfavor combinations of oscillation parameters that give rise to a large asymmetry in the rates of $nu_e$ and $macron(nu)_e$ appearance. This includes values of the CP-violating phase in the vicinity of $delta_("CP") = pi / 2$ which are excluded by $> 3 sigma$ for the inverted mass ordering, and values around $delta_("CP") = 3 pi / 2$ in the normal ordering which are disfavored at 2 $sigma$ confidence.
]]

#columns(2, gutter: 15pt)[

= INTRODUCTION <sec:intro>

We report new measurements of neutrino oscillation parameters using neutrino and antineutrino data from the NOvA experiment. The data include a 50% increase in neutrino-mode beam exposure over the previously reported results~@Acero:2019ksn. We perform a joint fit to $nu_mu (macron(nu)_mu) -> nu_e (macron(nu)_e)$ and $nu_mu (macron(nu)_mu) -> nu_mu (macron(nu)_mu)$ oscillations utilizing improvements in the analysis of these data.

Numerous experiments~@Fukuda:1998mi @Fukuda:2002pe @Ahmad:2002jz @Eguchi:2002dm @Michael:2006rx @Abe:2011sj @Abe:2011fz @An:2012eh @Ahn:2012nd corroborate the paradigm in which three neutrino mass eigenstates ($nu_1 , nu_2 , nu_3$) mix to form the three flavor eigenstates ($nu_e$, $nu_mu$, $nu_tau$). The mixing can be expressed by the unitary matrix, $U_("PMNS")$, named for Pontecorvo, Maki, Nakagawa, and Sakata. $U_("PMNS")$ can be parameterized by three mixing angles ($theta_12 , theta_23 , theta_13$) along with a phase ($delta_("CP")$) that, if different from 0 or $pi$, indicates violation of Charge-Parity (CP) symmetry. Neutrino mixing gives rise to oscillations from one flavor state to another, dependent on the mixing parameters and the mass splittings ($Delta m_(i j)^2 equiv m_i^2 - m_j^2$).

Using the definition of $nu_1$ as having the largest $nu_e$ contribution, it has been established that $Delta m_21^2$ is positive, and therefore, the $nu_2$ mass eigenstate is heavier than $nu_1$. However, the sign of the larger mass splitting, $Delta m_32^2$, is unknown. If this term is positive, then the third mass eigenstate is the heaviest, and the mass ordering is labeled as the Normal Ordering (NO) (also referred to as Normal Hierarchy). The alternative is referred to as Inverted Ordering (IO) (or Inverted Hierarchy). Knowing the mass ordering would constrain models of neutrino masses~@Mohapatra:2006gs @Nunokawa:2007qh @Altarelli:2010gt @King:2015aea @Petcov:2017ggy and could aid in the resolution of the Dirac or Majorana nature of the neutrino~@Pascoli:2002xq @Bahcall:2004ip.

The mass ordering affects the rates of $nu_mu -> nu_e$ and $macron(nu)_mu -> macron(nu)_e$ oscillations when neutrinos travel through the Earth as compared to a vacuum. Coherent forward scattering on electrons in the Earth's crust enhances the rate of $nu_mu -> nu_e$ oscillations and suppresses $macron(nu)_mu -> macron(nu)_e$ for the NO while the enhancement and suppression is reversed for the IO. This matter effect~@Wolfenstein:1977ue changes the oscillation probabilities for NOvA by $tilde 20%$. Depending on the value of $delta_("CP")$ and the mass ordering itself, NOvA may be able to exploit the resulting neutrino-antineutrino asymmetry to measure the sign of $Delta m_32^2$ and thus determine the mass ordering.

NOvA also has sensitivity to $delta_("CP")$, which will increase the $nu_mu -> nu_e$ oscillation probability if $sin delta_("CP")$ is positive and suppress oscillations if negative (the effect is reversed for antineutrinos). Additionally, a non-zero value of $sin delta_("CP")$ would identify the neutrino sector as a source of CP violation which is central to some explanations of the matter-antimatter asymmetry observed based on leptogenesis ~@Fukugita:1986hr @Buchmuller:1996pa @Buchmuller:2004nz @Buchmuller:2005eh @Pilaftsis:1997jf. Since a measurement of both the mass ordering and $delta_("CP")$ rely on a comparison of $nu_e$ and $macron(nu)_e$ appearance, certain combinations of $delta_("CP")$ and mass ordering will be degenerate with others for NOvA's oscillation baseline.

Finally, the angle $theta_23$ largely determines the coupling of the $nu_mu$ and $nu_tau$ states to the $nu_3$ mass state. In the case of maximal mixing, $theta_23 = pi / 4$, $nu_mu$ and $nu_tau$ couple equally to $nu_3$~@Harrison:2002et, which suggests a $mu - tau$ symmetry. If non-maximal, $theta_23$ could lie in the upper octant (UO, $theta_23 > pi / 4$) or lower octant (LO, $theta_23 < pi / 4$) with a stronger $nu_mu$ or $nu_tau$ coupling, respectively. Current measurements of $theta_23$ are near maximal mixing~@Acero:2019ksn @Michael:2006rx @Abe:2011sj, but significant uncertainties remain making it the least precisely measured mixing angle.

Here, we reanalyze the data taken in the antineutrino-mode beam from June 29, 2016, to February 26, 2019, with an exposure of $12.5 times 10^20$ protons on target (POT) delivered during 321.1~s of integrated beam-pulse time. These data are combined with an increased, and reanalyzed, neutrino-mode beam exposure of $13.6 times 10^20$~POT from 555.3~s of integrated beam-pulse time recorded between February 6, 2014, to March 20, 2020. During these periods, the proton source achieved an average power of 650~kW, and a peak hourly-averaged power of 756~kW.

In addition to the increased neutrino-mode beam exposure, this analysis introduces various improvements that will be described in detail in the following sections. There are changes to the underlying neutrino interaction simulation, particle propagation, and detector response models. The reconstruction uses a new clustering algorithm and expands the use of neural networks. Furthermore, the Near-to-Far extrapolation method has been expanded to further constrain the FD predictions, which also reduces the impact of systematic uncertainties on the analysis by up to 9% as compared to the previous method. Finally, we have improved some systematic uncertainties and introduced new ones associated with the above changes.

= THE NOvA EXPERIMENT AND SIMULATIONS <sec:nova-sim-calib>

NOvA observes $nu_mu (macron(nu)_mu) -> nu_e (macron(nu)_e)$ appearance and $nu_mu (macron(nu)_mu) -> nu_mu (macron(nu)_mu)$ disappearance oscillations using two functionally-identical tracking calorimeters~@Ayres:2007tu deployed in Fermilab's NuMI beam~@Adamson:2015dkw. Charged particle tracking is accomplished via PVC cells filled with a mineral oil-based liquid scintillator~@Mufson:2015kga. The cells are 6.6~cm $times$ 3.9~cm in cross section and are oriented in alternating vertical and horizontal planes to achieve 3D reconstruction. The 290~ton Near Detector (ND) is located 100~m underground and $tilde$1~km from the production target. The main body of the ND is followed by a muon range stack where the active planes are interleaved with steel plates. The 14~kton Far Detector (FD) is located at Ash River, Minnesota, $tilde$810~km from the source. Being located on the surface with a modest rock overburden, the FD receives a cosmic-ray flux of 130~kHz. This analysis benefits from an updated simulation of the geometries of the detectors and their surroundings that more accurately reflects the surrounding rock composition and detectors as built.

Both detectors are centered 14.6~mrad off the beam axis and receive a narrow-band neutrino flux peaked at 1.8~GeV. Magnetic focusing horns are used to select the sign of the neutrino parents, producing a 93% (92%) pure $nu_mu$ ($macron(nu)_mu$) beam between 1~GeV--5~GeV. The majority of contamination is due to "wrong-sign" neutrinos (#emph[i.e.] $macron(nu)_mu$ in a $nu_mu$ selected beam and vice versa). The neutrino flux delivered to the detectors is calculated using #smallcaps[geant4]-based simulations of particle production and transport through the beamline components~@Adamson:2015dkw @Agostinelli:2002hh reweighted to incorporate external measurements using the Package to Predict the Flux (PPFX)~@Aliaga:2016oaz @Paley:2014rpb @Alt:2006fr @Abgrall:2011ae @Barton:1982dg @Seun:2007zz @Tinti:2010zz @Lebedev:2007zz @Baatar:2012fua @Skubic:1978fi @Denisov:1973zv @Carroll:1978hc @Abe:2012av @Gaisser:1975et @Cronin:1957zz @Allaby:1969de @Longo:1962zz @Bobchenko:1979hp @Fedorov:1977an @Abrams:1969jm.

Neutrino interactions are simulated using a custom model configuration of #smallcaps[genie] 3.0.6 @Andreopoulos:2009rq @Andreopoulos:2015wxa tuned to external and NOvA ND data.#footnote[Neutrino interactions in this analysis were inadvertently simulated with event kinematics of GENIE configuration N18\_10j\_00\_000 but integrated rates with configuration N18\_10j\_02\_11a. These two configurations have the same model set and differ only in the tune of the resonant, non-resonant background, and DIS free nucleon cross sections, where the N18\_10j\_00\_000 tune used inclusive neutrino scattering data and the N18\_10j\_02\_11a tune used $1 pi$ and $2 pi$ production in addition to the inclusive neutrino scattering data ~@GENIE:2021zuu @Tena-Vidal:2018misc. The predicted Far Detector event spectra generated using N18\_10j\_02\_11a are consistent with the predictions used in this measurement within the systematic uncertainties.] In this configuration, charged-current (CC) quasi-elastic (QE) scattering is simulated using the model of Nieves #emph[et al.]~@Nieves:2004wx, which includes the effects of long-range nucleon correlations calculated according to the Random Phase Approximation (RPA)~@Martini:2009uj @Nieves:2004wx @Pandey:2014tza. The CCQE axial vector form factor is a $z$-expansion parameterization tuned to neutrino-deuterium scattering data @Meyer:2016oeg. CC interactions with two nucleons producing two holes (2p2h) are given by the IFIC València model~@Nieves:2011pp @Gran:2013kda. The initial nuclear state is represented by a local Fermi gas in both the QE and 2p2h models, and by a global relativistic Fermi gas for all other processes.

Baryon resonance (RES) and coherent pion production are simulated using the Berger-Sehgal models with final-state mass effects taken into account @Berger:2007rq @Berger:2008xs. Deep inelastic scattering (DIS) and non-resonant background below the DIS region are described using the Bodek-Yang model @Bodek:2002ps with hadronization simulated by a data-driven parameterization @Yang:2009zx coupled to #smallcaps[pythia] @Sjostrand:2006za. Bare nucleon cross-sections for RES, DIS, and non-resonant background processes are tuned by #smallcaps[genie] to neutrino scattering data. Final state interactions (FSI) are simulated by the #smallcaps[genie] hN semi-classical intranuclear cascade model in which pion interaction probabilities are assigned according to Oset #emph[et al.]~@Salcedo:1987md and pion-nucleon scattering data.

The 2p2h and FSI models in this #smallcaps[genie] configuration are adjusted to produce a NOvA-specific neutrino interaction model tune. The 2p2h model is fit to $nu_mu$ CC inclusive scattering data from the NOvA ND. Inspired by Gran #emph[et al.]~@Gran:2018fxa, this 2p2h tune enhances the base model as a function of energy and momentum transfer to the nucleus and is applied to all CC 2p2h interactions for both the neutrino and anti-neutrino beams. The parameters governing $pi^plus.minus$ and $pi^0$ FSI are adjusted to obtain agreement with $pi^(+)$ on $""^"12"$C scattering data~@Allardyce:1973ce @Saunders:1996ic @Meirav:1988pn @Levenson:1983xu @Ashery:1981tq @Ashery:1984ne @PinzonGuerra:2016uae.

The propagation of final state particles through the detectors is simulated by an updated version of #smallcaps[geant4] (v10.4) @Geant:2017ats, which provides the input for the detector response simulation~@Aurisano:2015oxj. In addition, a custom patch to the new version implements an exact calculation of the density effect correction to the Bethe equation using Sternheimer's method~@Sternheimer:1952jn as opposed to the approximate parameterization used previously (a 1% or less change to the muon range and energy lost in dead material).

The absolute energy scale for both detectors is calibrated using the minimum ionizing portion of stopping cosmic-ray muon tracks @Singh:2019lqg. The calibration procedure is now applied separately to the data in shorter time periods to account for an observed 0.3% decrease in detected light per year.

= RECONSTRUCTION AND SELECTION <sec:event-reco-select-energy>

The first stage of reconstruction is to group hits, which are measurements of deposited energy in a cell above a preset threshold, into single-neutrino-interaction events. This clustering, performed based on hit proximity in time and space, now uses a new method that reduces the rate of mis-clustered hits in the high occupancy environment of the ND @Pershey:2018gtf. Mis-clustering had previously led to differences in data-MC selection efficiency, which are now reduced to the sub-percent level. The other reconstruction techniques remain unchanged from the previous analysis~@Acero:2019ksn.

For each event, initial selections are applied to ensure basic data quality. Additionally, events are required to be sufficiently far from the edges of the detector such that energy is not lost to exiting final-state particles, and so entering background events are not selected as signal. These containment criteria have been re-optimized for this analysis due to changes in the geometry model and hit grouping algorithm, but follow the same outline as described in Ref.~@Acero:2019ksn.

A convolutional neural network, $"CNN"_"evt"$~@Aurisano:2016jvx, is used to classify neutrino event candidates into $nu_e$ CC, $nu_mu$ CC, NC, or cosmogenic background. The network is trained using simulated calibrated hits that have been clustered into single neutrino interactions, as well as cosmogenic data. Scores from $"CNN"_"evt"$ are used to create two non-overlapping samples of either inclusive $nu_mu (macron(nu)_mu)$~ or $nu_e (macron(nu)_e)$~ candidate events. Updates to this algorithm provide improved performance and decreased dependency on calorimetric energy, the dominant source of systematic uncertainty in the results presented here. This is achieved by scaling up or down the energy of all hits while training the CNN. The scale factors used are drawn on an event-by-event basis from a normal distribution with a 1 $sigma$ range from 0.9--1.1 @Groh:2021qyu. This training procedure reduced the influence of calibration uncertainties on $"CNN"_"evt"$ classification decisions to a negligible level.

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

#figure(
  table(
    columns: 4,
    align: center,
    table.header(
      table.cell(colspan: 2)[Sample bins],
      [Energy res.],
      [Sample purity],
    ),
    table.cell(rowspan: 4)[$nu_e (macron(nu)_e)$], [Core, Low $"CNN"_"evt"$], [14.1% (13.7%)], [51% (36%)],
    [Core, High $"CNN"_"evt"$], [9.4% (8.9%)], [79% (69%)],
    [Peripheral], [--], [57%~(43%)],
    [Combined], [10.7% (8.8%)], [69% (58%)],
    table.cell(rowspan: 5)[$nu_mu (macron(nu)_mu)$], [1 (lowest $E_("frac")$)], [7.8% (8.5%)], [99% (99%)],
    [2], [9.2% (8.9%)], [99% (99%)],
    [3], [10.4% (9.7%)], [97% (98%)],
    [4 (highest $E_("frac")$)], [11.5% (10.2%)], [92% (95%)],
    [Combined], [9.1% (8.2%)], [96% (98%)],
  ),
  caption: [
    FD energy resolution and purity$""^"2"$, in the selected energy ranges (0~GeV--5~GeV for $nu_mu$ and 0~GeV--4~GeV for $nu_e$), for the subsamples used in the Near-to-Far extrapolation and oscillation fits. $E_("frac")$ for the $nu_mu$ samples is defined in the text. The $nu_e (macron(nu)_e)$ peripheral is a rate-only sample, therefore, $E_nu$ is not determined.
  ],
  kind: table,
) <tb:sample-res-pur>

Effective rejection of cosmogenic backgrounds at the FD is paramount due to the significant flux of cosmic-ray particles it receives. A new CNN, trained to identify cosmogenic backgrounds has been introduced, is applied in parallel to cosmic-identifying boosted decision trees (BDTs). The BDTs have been trained on samples selected to contain signal-like cosmogenic particles. Together the CNN and BDTs reduce the cosmic contamination in the selected samples to $< 5%$, a total reduction of 6 orders of magnitude, comparable to the previous analysis. For fully contained $nu_e$ events, the BDT replaces the previous cosmic rejection method, which directly used reconstructed position and kinematic event information.

Neutrino energy, $E_nu$, is determined using different methods for the $nu_e$ and $nu_mu$ CC candidate events. The energies of $nu_e$ CC candidates are parameterized using a quadratic function determined from a 2D fit to the simulated electromagnetic (EM) and hadronic calorimetric energies ($E_"EM"$ and $E_"had"$ respectively). The two components produce different detector responses and are separated using a third CNN classifier that identifies EM-like hit clusters within the event with the remaining clusters being classified as hadronic~@Psihas:2018czu. For $nu_mu$ CC candidates, $E_nu$ is the sum of the muon energy, determined by the track length, and the total calorimetric energy of the hadronic system, $E_("had")$. The muon is identified with a BDT that utilizes track length, multiple Coulomb scattering, and energy deposition, while the hadronic system is taken as all hits not associated with the muon track.

The selection criteria and energy estimation techniques were developed based on ND beam and FD cosmic data, along with simulated samples prior to inspecting the FD beam data distributions. The algorithms were trained separately on neutrino and antineutrino beam modes due to differences in beam purity and interactions.

The sensitivity of the oscillation fit is enhanced by splitting the fully contained $nu_e$ and $macron(nu)_e$ CC, "core", samples into low and high purity bins, based on the scores output by $"CNN"_"evt"$. At the FD, the $nu_e (macron(nu)_e)$ selection efficiency for signal events in the core sample is 54% (64%). To further increase the efficiency of the FD sample, a "peripheral" selection is included, consisting of events that fail the containment or cosmic rejection requirements but pass more strict selection criteria on the cosmic BDT and $"CNN"_"evt"$. This sample increases the total $nu_e (macron(nu)_e)$ selection efficiency to 63% (75%)$""^"2"$ but is included only as an integrated rate in the oscillation fits due to possible energy bias caused by particles leaving the detector. Properties of these subsamples are summarized in #ref(<tb:sample-res-pur>, supplement: [Table]).

For $nu_mu$ CC candidates, the position and amplitude of the oscillation maximum in the FD energy spectra are strongly dependent on $Delta m_32^2$ and $theta_23$, respectively. To maximize the sensitivity to these parameters, the candidates are divided into four equally populated samples based on the hadronic energy fraction, $E_("frac") = E_("had") / E_nu$, which is correlated with energy resolution and background contamination as summarized in #ref(<tb:sample-res-pur>, supplement: [Table]). Sensitivity is further increased by using variably-sized $E_nu$ bins for these samples.

= NEAR-TO-FAR EXTRAPOLATION <sec:near-to-far>

This analysis extracts oscillation parameters using data-driven predictions of the FD spectra largely derived from high statistics measurements in the ND. The $nu_mu (macron(nu)_mu)$ disappearance and $nu_e (macron(nu)_e)$ appearance signal spectra in the FD are predicted using the spectra of $nu_mu (macron(nu)_mu)$~ candidate events in the ND (@fig:nd-data-figure(a)). The procedure begins with reweighting the simulation to obtain agreement with the data in each reconstructed $E_nu$ bin of the ND $nu_mu (macron(nu)_mu)$~ candidate samples. Predicted rates of NC, $nu_e$ CC, and $macron(nu)_e$ CC interactions in the samples ($<$0.5% total) are taken directly from the simulation and subtracted. The wrong-sign component of the samples (2.9% and 10.5% in the neutrino and antineutrino beams respectively) is also taken directly from the simulation. The resulting corrected $nu_mu + macron(nu)_mu$ CC reconstructed $E_nu$ spectra are transformed to true $E_nu$ using the simulation. The spectra are then multiplied by the appropriate far-to-near ratios of the simulated samples in bins of true $E_nu$. This step accounts for beam divergence, differences in selection efficiency and acceptance between the two detectors, and the differences in the $nu_mu$ and $nu_e$ cross sections. Oscillation probabilities are applied to yield the predicted disappearance or appearance signal spectra in true $E_nu$ at the FD. Matter effects are included in the oscillation probability calculations, with the Earth's crust density assumed to be uniformly 2.84~g~cm#super[−3]~@Bassin:2000ats. Finally, the predicted spectra are converted back to reconstructed $E_nu$.

// [figvision] imgs/spectra_nue_nd.png
// Panel a displays the reconstructed neutrino energy spectra for the Near Detector (ND) sample in neutrino mode.
// The vertical axis represents event counts scaled by 10^3, ranging from 0 to 12, while the horizontal axis
// shows reconstructed electron neutrino or antineutrino energy in GeV from approximately 0 to 4.5. Data points
// are plotted as black dots with error bars. These are compared against stacked histograms representing
// interaction types: light orange for electron charged-current, green for muon charged-current, and blue for
// neutral current interactions. A red dotted line indicates uncorrected Monte Carlo simulations. The left
// subplot labeled Low CNN_evt peaks near 1.8 GeV, whereas the right subplot labeled High CNN_evt peaks around
// 2.2 GeV. Panel b presents the corresponding spectra for the ND CC sample, split into low and high sub-samples
// based on CNN_evt values. The layout mirrors Panel a but focuses specifically on charged-current interactions.
// The y-axis scale is reduced, ranging from 0 to 4 events times 10^3. In the low CNN_evt region, the
// distribution peaks at roughly 1.7 GeV, dominated by the blue neutral current component which appears
// unexpectedly here despite the CC label, suggesting potential misclassification or background inclusion. The
// high CNN_evt region shows a peak near 2.0 GeV with significant contributions from both electron and muon
// charged-current channels. Red dashed lines again denote uncorrected MC predictions, generally underestimating
// data yields across bins.
// [figvision] imgs/spectra_numu_nd.png
// Panel (a) displays a histogram plot for the neutrino-beam mode. The horizontal axis represents reconstructed
// muon neutrino energy in GeV, ranging from 0 to 5. The vertical axis indicates event counts scaled by bin
// width, labeled as 10^3 Events / 0.1 GeV, with a range extending to 250. Black circular points with error bars
// represent experimental data. A purple step line depicts the total Monte Carlo simulation, enveloped by a light
// purple shaded region indicating the one-sigma systematic uncertainty. A small green area at the bottom
// signifies wrong-sign interactions. The data and simulation both peak near 1.8 GeV, showing strong agreement.
// Panel (b) presents the corresponding distribution for the antineutrino-beam mode using identical axes and
// scales as panel (a), though the vertical axis maximum is lower at 140. Black data points follow the same trend
// as the top panel but with reduced magnitude, peaking around 1.9 GeV. The purple simulation line and shaded
// uncertainty band closely track the data points. Notably, the green wrong-sign interaction component is visibly
// larger relative to the signal compared to the neutrino beam case. The overall spectral shape remains
// consistent between the two beam configurations.
#figure(placement: top, 
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align(center)[
      #image("imgs/spectra_numu_nd.png", width: 85%)
      #v(0.3em)
      (a)
    ],
    align(center)[
      #image("imgs/spectra_nue_nd.png", width: 85%)
      #v(0.3em)
      (b)
    ],
  ),
  caption: [
    Reconstructed neutrino energy spectra for the (a) ND $nu_mu$~ and (b) ND $nu_e$~CC samples with the neutrino-mode beam on top and antineutrino-mode on the bottom~@supplemental-numu. The $nu_mu$~ $E_("frac")$ sub-samples have been combined. The $nu_e$~CC low and high $"CNN"_"evt"$ sub-samples are shown. Dashed lines in the ND $nu_e$ and $macron(nu)_e$ spectra show the simulated counts before data-driven corrections and the colored regions show the breakdown by interaction type.
  ],
) <fig:nd-data-figure>

// [figvision] imgs/FHC_Selected_RecoPt_2020_Paper.png
// This panel is a histogram plot titled "ν Beam" in the upper left corner. The vertical axis, labeled "Fraction
// of Events," ranges from 0.0 to approximately 0.13 with major ticks at 0.05 and 0.10. The horizontal axis,
// labeled "Reconstructed pT (GeV)," spans from 0.0 to roughly 1.2 GeV with major ticks at 0.0, 0.5, and 1.0.
// Four distributions are shown: ND Data is plotted as black points with error bars connected by lines; ND MC νμ
// + ν̄μ CC is a red step line; FD MC νμ + ν̄μ CC is a blue step line; and FD MC νe + ν̄e CC is a green step
// line. The black data points closely follow the red curve, peaking near 0.4 GeV at a fraction of about 0.12.
// The blue and green curves peak lower, around 0.09, and are shifted slightly higher in momentum compared to the
// red curve.
#figure(placement: top, image("imgs/FHC_Selected_RecoPt_2020_Paper.png", width: 100%),
  caption: [
    Distributions from the neutrino-mode beam of the fraction of selected events versus reconstructed $p_T$ of the final state lepton, for the ND $nu_mu$ CC data and simulation, and for the simulated FD $nu_mu$ and $nu_e$ signal events. The corresponding distributions from the antineutrino-mode beam are similar.
  ]
)
<fig:pt_spectra>

To reduce potential bias and the impact of uncertainties from the neutrino interaction model, the extrapolation to predict the disappearance and appearance signals is performed using variables in addition to $E_nu$. As in the previous analysis, the extrapolations for the disappearance samples are done separately in each reconstructed hadronic energy fraction range (as given in #ref(<tb:sample-res-pur>, supplement: [Table])), enabling neutrino interaction processes that occur in different inelasticity regions to be constrained independently. In this analysis, the extrapolations for both disappearance and appearance samples are additionally performed separately in bins of reconstructed transverse momentum, $p_T$, of the final state charged lepton. The smaller transverse extent of the ND leads to lower acceptance at higher $p_T$ in the ND than in the FD (@fig:pt_spectra), which results in the extrapolated predictions being sensitive to the modeling of the $p_T$-dependence of the neutrino interactions. Extrapolating in bins of $p_T$ reduces this sensitivity by enabling the ND data to constrain the $p_T$-dependence. In the ND samples, the $p_T$ bins divide each $E_nu$ bin into three equal populations for the extrapolation, and the resulting FD predictions are summed over the $p_T$ bins for the oscillation fit.

Background spectra at the FD are also predicted using data-driven techniques. Cosmogenic backgrounds in both the appearance and disappearance samples are estimated using FD data collected outside the NuMI beam time window. Beam-induced backgrounds in the appearance samples are primarily CC interactions from the irreducible $nu_e + macron(nu)_e$ component of the beam, with contributions from mis-identified NC and $nu_mu + macron(nu)_mu$ CC interactions. The FD spectra for these backgrounds are predicted using the spectra of $nu_e (macron(nu)_e)$~ candidate events in the ND (@fig:nd-data-figure(b)). Since the relative event rate between the ND and FD is different for the background components, the relative contribution of the different background components in the data needs to be estimated. In neutrino beam-mode these estimates are data-driven~@NOvA:2018gge @Pershey:2018gtf while they are taken directly form the simulation in antineutrino beam-mode.

// [figvision] imgs/syst_table_pt_vs_no_pt_summary.png
// Panel a is a horizontal bar chart showing systematic uncertainties on the oscillation parameter sin squared
// theta 23. The vertical axis lists eight uncertainty sources from top to bottom: Detector Calibration, Neutron
// Uncertainty, Neutrino Interaction Model, Near-Far Differences, Detector Response, Lepton Reconstruction, Beam
// Flux, and Total Syst. Unc. The horizontal axis ranges from -0.02 to 0.02. For each source, two bars are shown:
// red for analysis without pT bins and orange for with pT bins. Detector Calibration has the largest
// uncertainty, approximately [-0.018, 0.015] in red and [-0.016, 0.014] in orange. The total systematic
// uncertainty at the bottom spans roughly [-0.024, 0.020] in red and [-0.022, 0.018] in orange. Panel b displays
// systematic uncertainties on delta m squared 32, scaled by 10^-3 eV^2. It uses the same vertical layout as
// panel a. The horizontal axis runs from -0.02 to 0.02. Detector Calibration again dominates, with red bars
// extending about [-0.019, 0.021] and orange bars [-0.017, 0.019]. Other sources like Lepton Reconstruction show
// moderate contributions; for example, red is approximately [-0.008, 0.007], orange [-0.007, 0.006]. Total
// systematic uncertainty reaches roughly [-0.025, 0.023] in red and [-0.023, 0.021] in orange, indicating that
// including pT bins slightly reduces overall systematics. Panel c presents uncertainties on delta CP divided by
// pi. Vertical categories match previous panels. Horizontal axis spans -0.2 to 0.2. Detector Calibration
// contributes significantly: red bars cover approximately [-0.12, 0.11], orange [-0.11, 0.10]. Neutrino
// Interaction Model also shows notable impact—red around [-0.05, 0.04], orange [-0.04, 0.03]. Total systematic
// uncertainty extends to about [-0.14, 0.13] in red and [-0.13, 0.12] in orange. Across all three parameters,
// detector calibration remains the dominant systematic, and using pT bins consistently yields smaller
// uncertainties compared to not using them.
#figure(placement: top, image("imgs/syst_table_pt_vs_no_pt_summary.png", width: 6in),
  caption: [
    Systematic uncertainties on $sin^2 theta_23$, $Delta m_32^2$, and $delta_("CP")$ evaluated at the best-fit point. Detector calibration uncertainties, which are less constrained by extrapolation, are dominant for all three oscillation parameters. Uncertainties for extrapolation with (orange) and without (red) $p_T$ bins are shown for comparison. The statistical uncertainties (not shown) are \[-0.033, 0.022\] for $sin^2 theta_23$, \[-0.055, 0.043\] ($times 10^(-3) thin "eV"^2$) for $Delta m_32^2$, and \[-0.87, 0.21\] for $delta_("CP")$.
  ],
  scope: "parent",
)
<fig:syst>

= SYSTEMATIC UNCERTAINTIES <sec:systematics>

The impacts of systematic uncertainties are evaluated by varying the simulation via event reweighting or simulating alternative event samples and repeating the extrapolation procedure. Uncertainties associated with the neutrino flux, neutron modeling, and detector calibrations are unchanged from the previous analysis~@Acero:2019ksn.

Detector calibration uncertainties remain dominant and are driven by a 5% uncertainty in the calorimetric energy scale. Additionally, a new time-dependent calibration uncertainty is included to account for any residual differences remaining after performing the calibration over shorter time periods as mentioned previously.

Neutrino interaction model uncertainties are evaluated using the event reweighting framework in #smallcaps[genie] with additional uncertainties constructed by NOvA as follows. Uncertainties on CCQE RPA, low-$Q^2$ RES suppression, 2p2h, and non-resonant and incoherent N$pi$ production are established for the new model set using methods similar to those in Ref.~@Acero:2020eit. Pion FSI uncertainties are based on comparisons to $pi^(+)$ on $""^"12"$C scattering data~@Allardyce:1973ce @Saunders:1996ic @Meirav:1988pn @Levenson:1983xu @Ashery:1981tq @Ashery:1984ne @PinzonGuerra:2016uae and prior studies using an alternative neutrino interaction generator~@PinzonGuerra:2018rju. Uncertainties on the $nu_e (macron(nu)_e)$ CC cross section relative to the $nu_mu (macron(nu)_mu)$ CC cross section due to radiative corrections and possible second-class currents are unchanged from previous analyses~@NOvA:2018gge.

As in the previous analysis, uncertainties are included that are detector specific or account for differences between the ND and FD: the detector masses, beam exposures, kinematic acceptances, beam-induced pile-up, $nu_e$ CC selection in the ND, and cosmogenic backgrounds in the FD. The improved hit clustering algorithm reduces pile-up effects in the ND, decreasing uncertainties for the associated data-MC selection efficiency differences. An uncertainty for kinematic acceptance differences between the detectors was overestimated in the previous analysis and is subdominant in this analysis after correction. Extrapolating in $p_T$ bins would have substantially reduced the effect of this uncertainty even if left uncorrected.

Uncertainties arising from the custom light model are assigned based on comparison to a more robust response model that was not fully incorporated into the simulation for this analysis. This model is constrained by a sample of ND proton candidates in addition to the muon sample used previously. Differences in the detector response between the proton and muon samples also provide a data-driven uncertainty on the relative production of Cherenkov and scintillation light in the model.

Quantities affected by lepton reconstruction uncertainties include the muon energy scale and lepton angle. The muon energy scale uncertainty now includes a detector mass uncertainty with a component that is uncorrelated between the detectors, plus a correlated component accounting for the Fermi density effect and muon range differences across models. Extrapolating in $p_T$ bins introduces a dependence on the reconstructed lepton angle for which a 10~mrad uncorrelated uncertainty is applied.

@fig:syst shows the impact of the systematic uncertainties on the measurement of $sin^2 theta_23$, $Delta m_32^2$, and $delta_("CP")$ as evaluated at the determined best-fit point. The extrapolation method significantly reduces the impact of the detector correlated beam flux and neutrino interaction model uncertainties. In contrast, energy calibration and uncorrelated uncertainties that reflect ND-FD differences are less constrained by extrapolation. @fig:syst also shows the impact of uncertainties for extrapolation with and without $p_T$ bins. Extrapolating in $p_T$ bins reduces the interaction model uncertainty by 10--30%, and the total systematic uncertainty by up to 9%. Detector calibration, detector response, and neutron modeling uncertainties that affect the reconstructed energy of the recoiling hadronic system, which is correlated with $p_T$, are more modestly reduced. The extrapolation in bins of $p_T$ depends on reconstructed lepton kinematics and results in a marginal increase in the associated uncertainties.

= RESULTS <sec:results>

// [figvision] imgs/spectra_nue_fd.png
// Panel a displays the reconstructed neutrino energy spectrum for the FD sample in neutrino-beam mode. The
// horizontal axis represents reconstructed electron neutrino energy in GeV, ranging from 1 to 4. The vertical
// axis counts events from 0 to 50. The plot is divided into three regions: Low CNN evt, High CNN evt (Core), and
// Peripheral. Black points with error bars represent FD Data. Stacked histograms show background contributions:
// green for WS bkg., pink for Beam bkg., and light blue for Cosmic bkg. A purple line indicates the best-fit
// prediction, surrounded by a shaded region representing the 1-sigma systematic range. Panel b shows the
// corresponding spectrum for the antineutrino-beam mode. The axes are identical to panel a, except the vertical
// scale runs from 0 to 15. The layout mirrors panel a with Low CNN evt, High CNN evt (Core), and Peripheral
// sections. Data points and stacked backgrounds follow the same color scheme. The purple best-fit curve and its
// 1-sigma systematic band overlay the data. In this mode, event counts are lower overall, particularly in the
// Core region where the peak sits around 2 GeV.
// [figvision] imgs/spectra_numu_fd.png
// Panel a displays a histogram plot titled v-beam, representing the reconstructed neutrino energy spectrum. The
// vertical axis indicates event counts per 0.1 GeV bin ranging from 0 to 25, while the horizontal axis shows
// reconstructed energy in GeV from 0 to 5. Black dots with error bars represent FD Data points that peak near 2
// GeV with approximately 16 events. A solid purple line depicts the Best-fit Prediction, surrounded by a light
// purple shaded region indicating the one-sigma systematic uncertainty range. A small grey area at the bottom
// represents background events. The data generally follows the prediction trend, showing a rise to a peak and a
// subsequent fall-off. Panel b presents a similar histogram plot titled anti-nu-beam for the antineutrino-mode
// sample. The vertical axis scales from 0 to 10 events per 0.1 GeV, while the horizontal axis maintains the 0 to
// 5 GeV energy range. Black data points show a lower event count than panel a, peaking around 8 events near 2
// GeV. The purple best-fit prediction line and its associated systematic uncertainty band track the data
// distribution closely. Background is negligible compared to the signal. Both panels illustrate that
// experimental data aligns well with theoretical predictions within systematic uncertainties for both beam
// modes.
#figure(placement: top, 
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align(center)[
      #image("imgs/spectra_numu_fd.png", width: 85%)
      #v(0.3em)
      (a)
    ],
    align(center)[
      #image("imgs/spectra_nue_fd.png", width: 85%)
      #v(0.3em)
      (b)
    ],
  ),
  caption: [
    Reconstructed neutrino energy spectra for the FD (a) $nu_mu$~ and (b) $nu_e$~CC samples with the neutrino-mode beam on top and antineutrino-mode on the bottom~@supplemental-numu. The $nu_mu$~ $E_("frac")$ sub-samples have been combined. The $nu_e$~CC low and high $"CNN"_"evt"$, and peripheral sub-samples are shown.
  ],
) <fig:fd-data-figure>

The extrapolated predictions of the FD spectra are recomputed for varying oscillation parameters and compared to data using a Poisson negative log-likelihood ratio,~$-2 ln cal(L)$. The best-fit parameters minimize~$-2 ln cal(L)$. The following solar and reactor neutrino experiment constraints are used: $Delta m_21^2 = 7.53 times 10^(-5) thin "eV"^2$, $sin^2 theta_12 = 0.307$, and $sin^2 theta_13 = 0.0210 plus.minus 0.0011$ @PhysRevD.98.030001. The parameters $Delta m_32^2$, $sin^2 theta_23$, and $delta_("CP")$ are varied without constraints while the 64 systematic uncertainties are assigned penalty terms equal to the square of the number of standard deviations by which they vary from their nominal values. The value of $sin^2 theta_13$ is allowed to float similarly. Feldman-Cousins' unified approach~@Feldman:1997qc @Sousa:2019nhd is used to determine the confidence intervals for the oscillation parameters. All significances given, or plotted, are FC-corrected values. The fitted parameters not shown are profiled over.

#figure(
  table(
    columns: 5,
    align: (left, center, center, center, center),
    [], table.cell(colspan: 2)[Neutrino beam], table.cell(colspan: 2)[Antineutrino beam],
    [], [$nu_mu$~], [$nu_e$~CC], [$macron(nu)_mu$~], [$macron(nu)_e$~],
    [$nu_mu -> nu_mu$], [201.1], [1.7], [26.0], [0.2],
    [$macron(nu)_mu -> macron(nu)_mu$], [12.6], [0.0], [77.2], [0.2],
    [$nu_mu -> nu_e$], [0.1], [59.0], [0.0], [2.3],
    [$macron(nu)_mu -> macron(nu)_e$], [0.0], [1.0], [0.0], [19.2],
    [Beam $nu_e + macron(nu)_e$], [0.0], [14.1], [0.0], [7.3],
    [NC], [2.6], [6.3], [0.8], [2.2],
    [Cosmic], [5.0], [3.1], [0.9], [1.6],
    [Others], [0.9], [0.5], [0.4], [0.3],
    [Signal], [214.1$""_(-14.0)^(+14.4)$], [59.0$""_(-2.5)^(+2.5)$], [103.4$""_(-7.0)^(+7.1)$], [19.2$""_(-0.7)^(+0.6)$],
    [Background], [8.2$""_(-1.7)^(+1.9)$], [26.8$""_(-1.7)^(+1.6)$], [2.1$""_(-0.7)^(+0.7)$], [14.0$""_(-1.0)^(+0.9)$],
    [Best fit], [222.3], [85.8], [105.4], [33.2],
    [Observed], [211], [82], [105], [33],
  ),
  caption: [
    Event counts at the FD, both observed and predicted at the best-fit point (see #ref(<tb:oscillation_parameters_table>, supplement: [Table])).
  ],
  kind: table,
) <tb:event-count-table>

@fig:fd-data-figure shows the energy spectra of the $nu_mu$~, $macron(nu)_mu$~, $nu_e$~CC, and $macron(nu)_e$~ candidates recorded at the FD. The distributions are compared to the oscillation best-fit expectations. #ref(<tb:event-count-table>, supplement: [Table]) summarizes the total event counts and estimated compositions of the selected samples. The CC candidate event samples recorded at the FD include 211 (105) observed $nu_mu (macron(nu)_mu) -> nu_mu (macron(nu)_mu)$ events and 82 (33) $nu_mu (macron(nu)_mu) -> nu_e (macron(nu)_e)$ candidate events. The latter $nu_e (macron(nu)_e)$ appearance sample has an estimated background of $26.8_(-1.7)^(+1.6)$ ($14.0_(-1.0)^(+0.9)$).

#figure(
  table(
    columns: 5,
    align: center,
    [], table.cell(colspan: 2)[Normal ord.], table.cell(colspan: 2)[Inverted ord.],
    [], [UO], [LO], [UO], [LO],
    [$Delta m_32^2 (10^(-3) thin "eV"^2)$], [$+2.41 plus.minus 0.07$], [$+2.39$], [$-2.45$], [$-2.44$],
    [$sin^2 theta_23$], [$0.57_(-0.04)^(+0.03)$], [$0.46$], [$0.56$], [$0.46$],
    [$delta_("CP") (pi)$], [$0.82_(-0.87)^(+0.27)$], [$0.07$], [$1.52$], [$1.41$],
    [Rejection significance], [-], [$1.1 sigma$], [$0.9 sigma$], [$1.1 sigma$],
  ),
  caption: [
    Summary of oscillation parameter best-fit results for different choices of the mass ordering (Normal or Inverted) and upper or lower $theta_23$ octant (UO, LO), along with the FC corrected significance (in units of $sigma$) at which those combinations are disfavored. Full uncertainties are given in @supplemental-tab.
  ],
  kind: table,
) <tb:oscillation_parameters_table>

This analysis determines a best-fit in the normal mass ordering and upper $theta_23$ octant (significance of 1.0 $sigma$ and 1.2 $sigma$, respectively), where $-2 ln cal(L)$~=~173.55 for 175 degrees of freedom (p-value of 0.705). The data disfavor combinations that lead to a strong asymmetry in the rate of $nu_e$ versus $macron(nu)_e$ appearance; therefore, the inverted mass ordering with $delta_("CP") = pi / 2$ is excluded at more than 3 $sigma$ and the normal mass ordering with $delta_("CP") = 3 pi / 2$ is disfavored at 2 $sigma$ confidence. However, owing to the degeneracies, the 90% confidence level allowed regions cover all values of $delta_("CP")$ given permutations of mass ordering and octant. Thus, the current data do not exhibit a preference concerning CP conservation versus violation. #ref(<tb:oscillation_parameters_table>, supplement: [Table]) shows the best-fit parameter values for each choice of $theta_23$ octant and mass ordering.

// [figvision] imgs/cont_dm32_th23_NH_friends.png
// Single-panel plot comparing allowed oscillation contours in the triangle-hatched plane of sin²θ₂₃ (horizontal
// axis, labeled ticks 0.4, 0.5, 0.6, spanning about 0.33–0.68 with log-like compressed margins) versus Δm²₃₂
// (vertical axis in units of 10⁻³ eV², labeled ticks 2.0, 2.5, 3.0, spanning roughly 1.9–3.3). Five regions are
// superposed: NOvA, a solid black banana-shaped contour bending from about (0.42, 2.52) to (0.63, 2.51) with its
// lower edge near 2.3; T2K Nature 580, a red dashed ellipse centered near (0.52, 2.45); SK 2018, a magenta
// dash-dot-dot contour sweeping widely and rising to about (0.58, 2.95); MINOS+ 2020, a green long-dashed band
// spanning nearly the full width around 2.4–2.6; IceCube 2018, a blue dotted region spanning 0.34–0.62 around
// 2.2–2.6. A filled black best-fit point at approximately (0.58, 2.43), with legend entries and the title
// "Normal Ordering 90% CL" at upper left. All experiments overlap at Δm²₃₂ ≈ 2.4–2.5 × 10⁻³ eV², illustrating
// consistent normal-ordering fits and the upper-octant degeneracy.
#figure(image("imgs/cont_dm32_th23_NH_friends.png", width: 3.41in),
  caption: [
    The 90% confidence level region for $Delta m_32^2$ and $sin^2 theta_23$, with the FC corrected allowed region and best-fit point for NOvA~@supplemental-contours superposed on contours from other experiments.~@Abe:2019vii @Abe:2017aap @MINOS:2020llm @Aartsen:2017nmd$""^"3"$.
  ]
)
<fig:dms32-sstt23-contour>

// [figvision] imgs/cont_th23_dCP_nova_t2k.png
// Panel (a), labelled Normal Ordering, plots sin²θ23 (y axis, 0.3–0.7, ticks every 0.1) against δCP (x axis,
// 0–2π with ticks at 0, π/2, π, 3π/2, 2π). Light teal shading shows NOvA's 90% FC-corrected region, covering
// nearly all δCP for sin²θ23 between about 0.42 and 0.62, with a white notch near δCP ≈ 3π/8–π/2 and a detached
// island near δCP ≈ 2π; darker teal inside marks the 68% region. The NOvA best fit, a dark blue four-pointed
// star, sits at δCP ≈ 0.75π, sin²θ23 ≈ 0.57. Black solid and dotted ellipses are T2K's 90% and 68% contours,
// centred near δCP ≈ 1.3π, sin²θ23 ≈ 0.53, with a black square best fit at δCP ≈ 1.25π, sin²θ23 ≈ 0.53; they
// overlap and partly exclude the teal region. In-panel legends identify both experiments. Panel (b), labelled
// Inverted Ordering, repeats the axes, with δCP labelled beneath the shared bottom axis. The NOvA 90% region,
// light pink fill, occupies only the right half, spanning δCP ≈ 0.95π–2π and sin²θ23 ≈ 0.42–0.62, widest around
// δCP ≈ 1.6π; the darker salmon 68% region lies inside, roughly δCP 1.0π–1.9π and sin²θ23 0.44–0.59. A single
// black solid ellipse shows the T2K 90% contour, about δCP 1.25π–1.75π and sin²θ23 0.49–0.56, overlapping the
// salmon region's centre; no T2K 68% contour or best-fit marker appears in this panel. Legends list T2K (solid
// line, ≤90% CL) and NOvA (light pink 90%, salmon 68%). Left of δCP ≈ 0.95π, the plane is Empty.
#figure(image("imgs/cont_th23_dCP_nova_t2k.png", width: 3.41in),
  caption: [
    The 68% and 90% confidence level contours in $sin^2 theta_23$ vs. $delta_("CP")$ in the (a) normal mass ordering and (b) inverted mass ordering ~@supplemental-dcp. The cross denotes the NOvA best-fit point and colored areas depict the 90% and 68% FC corrected allowed regions for NOvA. Overlaid black solid-line and dashed-line contours depict allowed regions reported by T2K~@Abe:2019vii$""^"3"$.
  ]
)
<fig:sstt23-dcp-islands>

@fig:dms32-sstt23-contour compares the 90% confidence level contours for $Delta m_32^2$ and $sin^2 theta_23$ with those of other experiments~@Abe:2019vii @Abe:2017aap @MINOS:2020llm @Aartsen:2017nmd$""^"3"$. Allowed regions in $sin^2 theta_23$ and $delta_("CP")$ are shown in @fig:sstt23-dcp-islands and are compared with a recent best fit from T2K @Abe:2019vii#footnote[While this paper was in its final internal review, an updated analysis was published by the T2K collaboration~@T2K:2021xwb. Compared to Ref.~@Abe:2019vii, the dataset remains unchanged and the same approach is used. The conclusions drawn from the comparisons of the contours remains unchanged.].

As shown in #ref(<fig:sstt23-dcp-islands>)a, the T2K best-fit point is in the NO but lies in a region that NOvA disfavors. However, some regions of overlap remain. #ref(<fig:sstt23-dcp-islands>)b shows that for IO, the T2K allowed region at 90% confidence level is entirely contained within the corresponding NOvA allowed region. This outcome reflects in part the circumstance that T2K observes a relatively more pronounced asymmetry in $nu_e$ versus $macron(nu)_e$ oscillations.

Although each experiment reports a mild preference for NO, it has been suggested that a joint fit of the two experiments might converge on an IO solution~@Kelly:2020fkv. Some authors have also explored the possibility that the differences in the $nu_mu -> nu_e$ and $macron(nu)_mu -> macron(nu)_e$ rates seen by the experiments are explained by additional non-standard matter effects~@Denton:2020uda @Chatterjee:2020kkm.

In conclusion, we have presented improved measurements of oscillation parameters $Delta m_32^2$, $sin^2 theta_23$, and $delta_("CP")$, including an expanded data set and enhanced analysis techniques with respect to previous publications. These measurements continue to favor the normal mass ordering and upper octant of $sin^2 theta_23$, as well as values of the oscillation parameters that do not lead to a large asymmetry in $nu_mu -> nu_e$ and $macron(nu)_mu -> macron(nu)_e$ oscillation rates.

= ACKNOWLEDGMENTS <sec:acknowledgments>

This document was prepared by the NOvA collaboration using the resources of the Fermi National Accelerator Laboratory (Fermilab), a U.S. Department of Energy, Office of Science, HEP User Facility. Fermilab is managed by Fermi Research Alliance, LLC (FRA), acting under Contract No. DE-AC02-07CH11359. This work was supported by the U.S. Department of Energy; the U.S. National Science Foundation; the Department of Science and Technology, India; the European Research Council; the MSMT CR, GA UK, Czech Republic; the RAS, RFBR, RMES, RSF, and BASIS Foundation, Russia; CNPq and FAPEG, Brazil; STFC, UKRI, and the Royal Society, United Kingdom; and the State and University of Minnesota. We are grateful for the contributions of the staffs of the University of Minnesota at the Ash River Laboratory and of Fermilab.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: none)
]