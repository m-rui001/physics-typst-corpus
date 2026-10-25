#set heading(supplement: [Sect.])
#show figure.where(kind: figure): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure(supplement: [Table])
#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 11pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 3.15cm, right: 2.49cm, top: 2.30cm, bottom: 3.64cm), header-ascent: 8pt, header: context {
  if counter(page).get().first() == 1 {
    align(center)[
      #text(10pt)[Prog. Theor. Exp. Phys. 2015, 00000 (156 pages)] \
      #text(10pt)[DOI: 10.1093/ptep/0000000000]
    ]
  }
}, footer: context {
  let p = counter(page).get().first()
  if p == 1 {
    set text(6pt)
    set par(leading: 0.45em)
    align(left)[© The Author(s) 2012. Published by Oxford University Press on behalf of the Physical Society of Japan. \
    This is an Open Access article distributed under the terms of the Creative Commons Attribution License \
    (http://creativecommons.org/licenses/by-nc/3.0), which permits unrestricted use, \
    distribution, and reproduction in any medium, provided the original work is properly cited.]
  } else {
    align(center)[#text(10pt)[#p/156]]
  }
})
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.68em, first-line-indent: 9pt)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.68em)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)

#align(left)[
  #set text(hyphenate: false)
  #set par(first-line-indent: 0em)
  #v(2.9em)
  #block(above: 0pt, below: 0pt)[
    #set par(leading: 0.3em, justify: false)
    #scale(x: 87.2%, reflow: true)[#text(20.7pt, weight: "bold")[Probing Cosmic Inflation with the LiteBIRD \ Cosmic Microwave Background Polarization \ Survey]]
  ]
  #block(above: 15.7pt, below: 1pt)[#text(12pt, weight: "bold")[LiteBIRD Collaboration#super[∗]]]
  #set par(leading: 0.51em, spacing: 0em, justify: true)
  #v(4.8pt)
  #text(12pt)[
E. Allys#super[1], K. Arnold#super[2], J. Aumont#super[3], R. Aurlien#super[4], S. Azzoni#super[5,6], C. Baccigalupi#super[7,8,9], A. J. Banday#super[3], R. Banerji#super[4], R. B. Barreiro#super[10], N. Bartolo#super[11,12,13], L. Bautista#super[3], D. Beck#super[14], S. Beckman#super[15], M. Bersanelli#super[16,17], F. Boulanger#super[1], M. Brilenkov#super[4], M. Bucher#super[18], E. Calabrese#super[19], P. Campeti#super[20], A. Carones#super[21,22], F. J. Casas#super[10], A. Catalano#super[23], V. Chan#super[24], K. Cheung#super[15,25,26], Y.
Chinone#super[6,27], S. E. Clark#super[14,28], F. Columbro#super[29,30], G. D'Alessandro#super[29,30], P. de Bernardis#super[29,30], T. de Haan#super[31], E. de la Hoz#super[10,32], M. De Petris#super[29,30], S. Della Torre#super[33], P. Diego-Palazuelos#super[10,32], M. Dobbs#super[34], T. Dotani#super[35,36], J. M. Duval#super[37], T. Elleflot#super[38], H. K. Eriksen#super[4], J. Errard#super[18], T. Essinger-Hileman#super[39], F. Finelli#super[40,41], R. Flauger#super[2], C. Franceschet#super[16,17], U. Fuskeland#super[4], M. Galloway#super[4], K.
Ganga#super[18], M. Gerbino#super[42], M. Gervasi#super[33,43], R. T. Génova-Santos#super[44,45], T. Ghigna#super[5,6], S. Giardiello#super[46], E. Gjerløw#super[4], J. Grain#super[47], F. Grupp#super[48], A. Gruppuso#super[40,41], J. E. Gudmundsson#super[49], N. W. Halverson#super[50], P. Hargrave#super[19], T. Hasebe#super[6], M. Hasegawa#super[31,36,51], M. Hazumi#super[6,31,35,36,51], S. Henrot-Versillé#super[52], B. Hensley#super[53], L. T. Hergt#super[54], D. Herman#super[4], E. Hivon#super[55], R. A. Hlozek#super[24], A. L. Hornsby#super[15], Y.
Hoshino#super[56], J. Hubmayr#super[57], K. Ichiki#super[58], T. Iida#super[59], H. Imada#super[60], H. Ishino#super[61], G. Jaehnig#super[50], N. Katayama#super[6], A. Kato#super[31], R. Keskitalo#super[15,25,26], T. Kisner#super[26], Y. Kobayashi#super[62], A. Kogut#super[39], K. Kohri#super[31], E. Komatsu#super[6,20], K. Komatsu#super[61], K. Konishi#super[63], N. Krachmalnicoff#super[7,8,9], C. L. Kuo#super[14,64], L. Lamagna#super[29,30], M. Lattanzi#super[42], A. T. Lee#super[15,38,51], C. Leloup#super[18], F. Levrier#super[1], E.
Linder#super[25,38], G. Luzzi#super[65], J. Macias-Perez#super[23], T. Maciaszek#super[66], B. Maffei#super[47], D. Maino#super[16], S. Mandelli#super[16,17], E. Martínez-González#super[10], S. Masi#super[29,30], M. Massa#super[67], S. Matarrese#super[11,12,13,68], F. T. Matsuda#super[35], T. Matsumura#super[6], L. Mele#super[29,30], M. Migliaccio#super[21,22], Y. Minami#super[69], A. Moggi#super[67], J. Montgomery#super[34], L. Montier#super[3], G. Morgante#super[40], B. Mot#super[3], Y. Nagano#super[61], T. Nagasaki#super[31], R. Nagata#super[35], R.
Nakano#super[35,70], T. Namikawa#super[6], F. Nati#super[33,43], P. Natoli#super[42,46], S. Nerval#super[24], F. Noviello#super[19], K. Odagiri#super[35], S. Oguri#super[35], H. Ohsaki#super[62], L. Pagano#super[42,46,47], A. Paiella#super[29,30], D. Paoletti#super[40,41], A. Passerini#super[33,43], G. Patanchon#super[18], F. Piacentini#super[29,30], M. Piat#super[18], G. Pisano#super[19,29,30], G. Polenta#super[65], D. Poletti#super[33,43], T. Prouvé#super[37], G. Puglisi#super[21,26], D. Rambaud#super[3], C. Raum#super[15], S. Realini#super[16], M.
Reinecke#super[20], M. Remazeilles#super[10,71], A. Ritacco#super[1,47,72], G. Roudil#super[3], J. A. Rubino-Martin#super[44,45], M. Russell#super[2], H. Sakurai#super[62], Y. Sakurai#super[6,61], M. Sasaki#super[73], D. Scott#super[54], Y. Sekimoto#super[31,35,70], K. Shinozaki#super[74], M. Shiraishi#super[75], P. Shirron#super[39], G. Signorelli#super[67], F. Spinella#super[67], S. Stever#super[6,61], R. Stompor#super[18,76], S. Sugiyama#super[56], R. M. Sullivan#super[54], A. Suzuki#super[26], T. L. Svalheim#super[4], E. Switzer#super[39], R.
Takaku#super[35,77], H. Takakura#super[35,70], Y. Takase#super[61], A. Tartari#super[67,78], Y. Terao#super[62], J. Thermeau#super[18], H. Thommesen#super[4], K. L. Thompson#super[14,64], M. Tomasi#super[16,17], M. Tominaga#super[35,70], M. Tristram#super[52], M. Tsuji#super[79], M. Tsujimoto#super[35], L. Vacher#super[3], P. Vielva#super[10], N. Vittorio#super[21,22], W. Wang#super[18], K. Watanuki#super[35], I. K. Wehus#super[4], J. Weller#super[48], B. Westbrook#super[15], J. Wilms#super[73], B. Winter#super[80,81], E. J. Wollack#super[39], J.
Yumoto#super[62], M. Zannoni#super[33,43]
]
  #v(0.8em)
  #set par(leading: 0.68em, spacing: 0.44em)
  #text(9pt)[
    #super[1] Laboratoire de Physique de l’École Normale Supérieure, ENS, Université PSL, CNRS, Sorbonne Université, Université de Paris, F-75005 Paris, France \
    #super[2] University of California, San Diego, Department of Physics, San Diego, CA 92093-0424, USA \
    #super[3] IRAP, Université de Toulouse, CNRS, CNES, UPS (Toulouse), 9 avenue du Colonel Roche BP 44346, F-31028 Toulouse Cedex 4, France \
    #super[4] Institute of Theoretical Astrophysics, University of Oslo, Blindern 0315, Oslo, Norway \
    #super[5] Department of Physics, University of Oxford, Denys Wilkinson Building, Keble Road, Oxford OX1 3RH, UK \
    #super[6] Kavli Institute for the Physics and Mathematics of the Universe (Kavli IPMU, WPI), UTIAS, The University of Tokyo, Kashiwa, Chiba 277-8583, Japan \
    #super[7] International School for Advanced Studies (SISSA), Via Bonomea 265, I-34136 Trieste, Italy \
    #super[8] INFN Sezione di Trieste, Via Valerio 2, I-34127 Trieste, Italy \
    #super[9] IFPU, Via Beirut, 2, I-34151 Grignano, Trieste, Italy \
    #super[10] Instituto de Fisica de Cantabria (IFCA, CSIC-UC), Avenida los Castros SN, E-39005 Santander, Spain \
    #super[11] Dipartimento di Fisica e Astronomia “G. Galilei”, Università degli Studi di Padova, Via Marzolo 8, I-35131 Padova, Italy \
    #super[12] INFN Sezione di Padova, via Marzolo 8, I-35131 Padova, Italy \
    #super[13] INAF, Osservatorio Astronomico di Padova, Vicolo dell’Osservatorio 5, I-35122 Padova, Italy \
    #super[14] Stanford University, Department of Physics, CA 94305-4060, USA \
    #super[15] University of California, Berkeley, Department of Physics, Berkeley, CA 94720, USA \
    #super[16] Dipartimento di Fisica, Universita' degli Studi di Milano, Via Celoria 16, I-20133 Milano, Italy \
    #super[17] INFN Sezione di Milano, Via Celoria 16, I-20133 Milano, Italy \
    #super[18] Université de Paris, CNRS, Astroparticule et Cosmologie, F-75013 Paris, France \
    #super[19] School of Physics and Astronomy, Cardiff University, Cardiff CF24 3AA, UK \
    #super[20] Max Planck Institute for Astrophysics, Karl-Schwarzschild-Str. 1, D-85748 Garching, Germany \
    #super[21] Dipartimento di Fisica, Università di Roma Tor Vergata, Via della Ricerca Scientifica 1, I-00133 Roma, Italy \
    #super[22] INFN Sezione di Roma2, Università di Roma Tor Vergata, Via della Ricerca Scientifica 1, I-00133 Roma, Italy \
    #super[23] Univ. Grenoble Alpes, CNRS, LPSC-IN2P3, 53 avenue des Martyrs, F-38000 Grenoble, France \
    #super[24] David A. Dunlap Department of Astronomy and Astrophysics, 50 St George Street, Toronto ON M5S 3H4, Canada \
    #super[25] University of California, Berkeley, Space Sciences Laboratory, Berkeley, CA 94720, USA \
    #super[26] Lawrence Berkeley National Laboratory (LBNL), Computational Cosmology Center, Berkeley, CA 94720, USA \
    #super[27] University of Tokyo, School of Science, Research Center for the Early Universe, RESCEU, Tokyo 113-0033, Japan \
    #super[28] Kavli Institute for Particle Astrophysics and Cosmology (KIPAC), Stanford University, Stanford, CA 94305, USA \
    #super[29] Dipartimento di Fisica, Università La Sapienza, P.le A. Moro 2, I-00185 Roma, Italy \
    #super[30] INFN Sezione di Roma, P.le A. Moro 2, I-00185 Roma, Italy \
    #super[31] Institute of Particle and Nuclear Studies (IPNS), High Energy Accelerator Research Organization (KEK), Tsukuba, Ibaraki 305-0801, Japan \
    #super[32] Dpto. de Física Moderna, Universidad de Cantabria, Avda. los Castros s/n, E-39005 Santander, Spain \
    #super[33] INFN Sezione Milano Bicocca, Piazza della Scienza, 3, I-20126 Milano, Italy \
    #super[34] McGill University, Physics Department, Montreal, QC H3A 0G4, Canada \
    #super[35] Japan Aerospace Exploration Agency (JAXA), Institute of Space and Astronautical Science (ISAS), Sagamihara, Kanagawa 252-5210, Japan \
    #super[36] The Graduate University for Advanced Studies (SOKENDAI), Miura District, Kanagawa 240-0115, Hayama, Japan \
    #super[37] Université Grenoble Alpes, CEA, IRIG-DSBT, F-38000 Grenoble, France \
    #super[38] Lawrence Berkeley National Laboratory (LBNL), Physics Division, Berkeley, CA 94720, USA \
    #super[39] NASA Goddard Space Flight Center, Greenbelt, MD 20771, USA \
    #super[40] INAF - OAS Bologna, Via Piero Gobetti, 93/3, I-40129 Bologna, Italy \
    #super[41] INFN Sezione di Bologna, Viale C. Berti Pichat, 6/2 I-40127 Bologna, Italy \
    #super[42] INFN Sezione di Ferrara, Via Saragat 1, I-44122 Ferrara, Italy \
    #super[43] University of Milano Bicocca, Physics Department, p.zza della Scienza, 3, I-20126 Milan, Italy \
    #super[44] Instituto de Astrofísica de Canarias, E-38200 La Laguna, Tenerife, Canary Islands, Spain \
    #super[45] Departamento de Astrofísica, Universidad de La Laguna (ULL), E-38206 La Laguna, Tenerife, Spain \
    #super[46] Dipartimento di Fisica e Scienze della Terra, Università di Ferrara, Via Saragat 1, I-44122 Ferrara, Italy \
    #super[47] Université Paris-Saclay, CNRS, Institut d’Astrophysique Spatiale, F-91405 Orsay, France. \
    #super[48] Universitäts-Sternwarte, Fakultät für Physik, Ludwig-Maximilians Universität München, Scheinerstr.1, D-81679 München, Germany \
    #super[49] The Oskar Klein Centre, Department of Physics, Stockholm University, SE-106 91 Stockholm, Sweden \
    #super[50] Center for Astrophysics and Space Astronomy, University of Colorado, Boulder, CO 80309, USA \
    #super[51] International Center for Quantum-field Measurement Systems for Studies of the Universe and Particles (QUP), High Energy Accelerator Research Organization (KEK), Tsukuba, Ibaraki 305-0801, Japan \
    #super[52] Université Paris-Saclay, CNRS/IN2P3, IJCLab, F-91405 Orsay, France \
    #super[53] Department of Astrophysical Sciences, Peyton Hall, Princeton University, Princeton, NJ 08544, USA \
    #super[54] Department of Physics and Astronomy, University of British Columbia, 6224 Agricultural Road, Vancouver, BC V6T 1Z1, Canada \
    #super[55] Institut d'Astrophysique de Paris, CNRS/Sorbonne Université, Paris, France \
    #super[56] Saitama University, Saitama 338-8570, Japan \
    #super[57] NIST Quantum Sensors Group, 325 Broadway, Boulder, CO 80305, USA \
    #super[58] Nagoya University, Kobayashi-Masukawa Institute for the Origin of Particle and the Universe, Aichi 464-8602, Japan \
    #super[59] ispace, inc., Tokyo 103-0007, Japan \
    #super[60] National Astronomical Observatory of Japan, Mitaka, Tokyo 181-8588, Japan \
    #super[61] Okayama University, Department of Physics, Okayama 700-8530, Japan \
    #super[62] The Institute for Solid State Physics (ISSP), The University of Tokyo, Kashiwa, Chiba 277-8581, Japan \
    #super[63] The University of Tokyo, Institute for Photon Science and Technology, 113-0033, Japan \
    #super[64] SLAC National Accelerator Laboratory, Kavli Institute for Particle Astrophysics and Cosmology (KIPAC), Menlo Park, CA 94025, USA \
    #super[65] Space Science Data Center, Italian Space Agency, Via del Politecnico, I-00133, Roma, Italy \
    #super[66] Centre National d'Etudes Spatiales (CNES), 18 avenue Edouard Belin 31 401 TOULOUSE CEDEX 4, France \
    #super[67] INFN Sezione di Pisa, Largo Bruno Pontecorvo 3, I-56127 Pisa, Italy \
    #super[68] Gran Sasso Science Institute (GSSI), Viale F. Crispi 7, I-67100, L’Aquila, Italy \
    #super[69] Research Center for Nuclear Physics, Osaka University, Ibaraki, Osaka, 567-0047, Japan \
    #super[70] The University of Tokyo, Department of Astronomy, Tokyo 113-0033, Japan \
    #super[71] Jodrell Bank Centre for Astrophysics, Department of Physics and Astronomy, School of Natural Sciences, The University of Manchester, Oxford Road, Manchester M13 9PL, UK \
    #super[72] INAF-Osservatorio Astronomico di Cagliari, Via della Scienza 5, I-09047 Selargius, Italy \
    #super[73] Remeis-Observatory and Erlangen Centre for Astroparticle Physics, FAU Erlangen-Nürnberg, Sternwartstr. 7, D-96049 Bamberg, Germany \
    #super[74] Japan Aerospace Exploration Agency (JAXA), Research and Development Directorate, Tsukuba, Ibaraki 305-8505, Japan \
    #super[75] School of General and Management Studies, Suwa University of Science, 5000-1 Toyohira, Chino, Nagano 391-0292, Japan \
    #super[76] CNRS-UCB International Research Laboratory, Centre Pierre Binétruy, UMI2007, Berkeley, CA94720, USA \
    #super[77] The University of Tokyo, Department of Physics, Tokyo 113-0033, Japan \
    #super[78] Dipartimento di Fisica, Università di Pisa, Largo B. Pontecorvo 3, I-56127 Pisa, Italy \
    #super[79] National Institute of Technology, Kagawa College, Kagawa 761-8058, Japan \
    #super[80] Physics and Astronomy Dept., University College London (UCL), London \
    #super[81] Mullard Space Science Laboratory, University College London, Surrey RH5 6NT, UK \
  ]
  
]
#v(1.2em)
#block(inset: (left: 2cm))[
  #set text(size: 10pt)
  #set par(first-line-indent: 0em, leading: 0.55em, justify: true, spacing: 0.6em)
  #emph[LiteBIRD], the Lite (Light) satellite for the study of $B$-mode polarization and Inflation from cosmic background Radiation Detection, is a space mission for primordial cosmology and fundamental physics. The Japan Aerospace Exploration Agency (JAXA) selected #emph[LiteBIRD] in May 2019 as a strategic large-class (L-class) mission, with an expected launch in the late 2020s using JAXA's H3 rocket.

  #emph[LiteBIRD] is planned to orbit the Sun-Earth Lagrangian point L2, where it will map the cosmic microwave background (CMB) polarization over the entire sky for three years, with three telescopes in 15 frequency bands between 34 and 448 GHz, to achieve an unprecedented total sensitivity of 2.2 µK-arcmin, with a typical angular resolution of 0.5° at 100 GHz.

  The primary scientific objective of #emph[LiteBIRD] is to search for the signal from cosmic inflation, either making a discovery or ruling out well-motivated inflationary models. The measurements of #emph[LiteBIRD] will also provide us with insight into the quantum nature of gravity and other new physics beyond the standard models of particle physics and cosmology. We provide an overview of the #emph[LiteBIRD] project, including scientific objectives, mission and system requirements, operation concept, spacecraft and payload module design, expected scientific outcomes, potential design extensions and synergies with other projects.
]

#v(0.5em)
#block(inset: (left: 2cm))[
  #set par(first-line-indent: 0em)
  #line(length: 100%, stroke: (thickness: 0.4pt, dash: "dotted"))
  #v(0.3em)
  #grid(columns: (auto, 1fr), column-gutter: 2.4em,
    [#text(font: "CMU Sans Serif", size: 9pt)[Subject Index]],
    [#text(font: "CMU Sans Serif", size: 9pt)[LiteBIRD, cosmic inflation, cosmic microwave background, $B$-mode polarization, primordial gravitational waves, quantum gravity, space telescope]],
  )
]

#v(1.4em)
#block(width: 92%)[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em, leading: 0.72em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    it
  }
  #grid(columns: (1fr, auto),
    align(center)[#text(12pt, weight: "bold")[Contents]],
    align(right)[#text(10.9pt)[PAGE]],
  )
  #v(0.45em)
  #outline(title: none, depth: 3, indent: 2.1em)
]


= Introduction
<s:introduction>


== CMB Polarization as the New Frontier and the #emph[LiteBIRD] Satellite
<ss:intro_cmb_pol>


Observations of CMB temperature fluctuations have played a pivotal role in establishing the standard cosmological model, called the $Lambda$CDM model~#cite(<Weinberg:2008zzc>), and provide insights into the origin of structure, the density of baryons, dark matter, dark energy, the number of neutrino species, and the global properties of spacetime~#cite(<Peebles:2009zz>) #cite(<Sugiyama:2014lga>) #cite(<ScottSmoot>) #cite(<1804633>). Observations have reached a point at which most of the information about the early Universe available in temperature
fluctuations has been exhausted @Planck2018I @komatsu-bennett:2014. However, precise measurements of the fainter CMB polarization anisotropies hold the key to answering many remaining questions about the Universe. Observations have so far only begun to scratch the surface~#cite(<Aiola:2020azj>) #cite(<Adachi:2020knf>) #cite(<Sayre:2019dic>) #cite(<SPT-3G:2021eoc>) #cite(<BK2021>) #cite(<SPIDER:2021ncy>)


Perhaps the biggest remaining question is what mechanism created the small primordial fluctuations that seeded the observed CMB anisotropies and eventually grew into stars and galaxies. The most widely studied idea is "cosmic inflation"~#cite(<starobinsky:1980>) #cite(<sato:1981>) #cite(<guth:1981>) #cite(<albrecht-steinhardt:1982>) #cite(<linde:1982>) #cite(<linde:1983>). According to this idea the primordial fluctuations originated as quantum fluctuations during a period of nearly exponential expansion of the very early
Universe~~#cite(<mukhanov-chibisov:1981>) #cite(<starobinsky:1982>) #cite(<hawking:1982>) #cite(<guth-pi:1982>) #cite(<bardeen-turner-steinhardt:1983>). Eventually this period ended and the Universe became filled with a hot and dense plasma that subsequently cooled and led to the Universe we see around us. As a consequence of the nearly exponential expansion that stretched microscopic regions of spacetimes to macroscopic scales, the plasma is homogeneous and isotropic except for the minute quantum fluctuations that were also stretched to macroscopic
scales.


Cosmic inflation predicts primordial density fluctuations that are consistent with the observed temperature fluctuations~~#cite(<mukhanov-chibisov:1981>) #cite(<starobinsky:1982>) #cite(<hawking:1982>) #cite(<guth-pi:1982>) #cite(<bardeen-turner-steinhardt:1983>). In addition, inflation predicts quantum fluctuations in the fabric of spacetime itself~#cite(<grishchuk:1975>) #cite(<starobinsky:1979>). These primordial gravitational waves lead to a characteristic imprint in CMB polarization, commonly referred to as "$B$-mode"
polarization~@seljak-zaldarriaga:1997~#cite(<seljak-zaldarriaga:1997>) #cite(<kamionkowski-kosowsky-stebbins:1997>) #cite(<HuWhite1997Total>), and many of the best-motivated models predict a signal that is large enough to be detected with #emph[LiteBIRD] (the Lite (Light) satellite for the study of $B$-mode polarization and Inflation from cosmic background Radiation Detection)~@kamionkowski-kovetz:2016.


A detection of this signal would open an unexplored frontier of physics, shedding light on fundamental processes at energies far beyond the reach of CERN's Large Hadron Collider, revolutionizing our understanding of physics and the early Universe ~#cite(<Lyth:1996im>). A detection of primordial gravitational waves with #emph[LiteBIRD] has important implications for many aspects of fundamental physics. A detection would, for example, indicate that inflation occurred near the energy scale associated with grand unified theories, providing additional
evidence in favor of the idea of the unification of forces. Knowledge of the energy scale of inflation also has important implications for several other aspects of fundamental physics, such as axions and, in the context of string theory, the fields that control the shapes and sizes of the compact dimensions.


To search for the imprint of gravitational waves, #emph[LiteBIRD] will conduct a survey of the entire sky that is 30 times more sensitive than previous full-sky experiments, corresponding to a raw sensitivity of nearly 1000 #emph[Planck]~missions.#footnote[This is based on a comparison between the inverse-variance weighted combination of the white noise for CMB polarization of all channels for #emph[LiteBIRD] versus #emph[Planck].] #emph[LiteBIRD] will be the natural next step in the series of CMB space missions, following the NASA's COBE @Smoot1990 and
WMAP @Bennett2003a, and the ESA's #emph[Planck]~@Tauber2010a, each of which has made its own landmark scientific discoveries. See @Peebles:2009zz for a comprehensive list of CMB experiments and their pioneering contributions.


The CMB polarization anisotropies can be decomposed according to their transformation properties under parity transformations into "$E$ modes" and "$B$ modes." The $E$-mode polarization is predominantly caused by acoustic waves present at recombination, and the signal is strongest on angular scales of a few to tens of arcminutes (corresponding to multipoles of $ell tilde 1000$). The $B$-mode polarization pattern imprinted by gravitational waves peaks on degree angular scales (corresponding to multipoles of $ell tilde.eq 80$) and on very large angular
scales (corresponding to multipoles of $ell lt.tilde 10$)~@seljak-zaldarriaga:1997. The "recombination peak" near $ell tilde.eq 80$ is imprinted during the epoch when electrons and protons combine to form hydrogen and the Universe becomes neutral, while the "reionization bump" below $ell tilde.eq 10$ is imprinted around the time when the first stars reionize the Universe~#cite(<zaldarriaga:1997>). At linear order, the density perturbations do not generate $B$-mode polarization, which makes the $B$-mode power spectrum the most natural observable to search
for primordial gravitational waves. However, CMB photons are deflected by the gravitational potentials associated with the matter along the line of sight. This is referred to as weak gravitational lensing and converts some of the "$E$-mode" polarization generated by density perturbations into $B$ modes @zaldarriaga-seljak:1998. Like the $E$ modes, this effect peaks on much smaller scales of a few arcminutes (corresponding to multipoles of $ell tilde.eq 1000$) but must be taken into account. This contribution is well-understood theoretically,
and #emph[LiteBIRD] targets any excess over the lensing signal caused by the imprint of gravitational waves. While ground-based experiments only target the recombination peak, #emph[LiteBIRD] can see both peaks in the $B$-mode power spectrum.


In addition to the $B$ modes caused by weak gravitational lensing of $E$ modes, there are additional "foreground" sources of $B$-mode polarization at microwave frequencies. Thermal emission by interstellar dust grains that are aligned with the Galactic magnetic field and synchrotron emission from electrons spiraling in the Galactic magnetic field provide the dominant contributions. Fortunately, the frequency dependence of the primordial signal and foreground emission differ significantly so that multi-frequency observations allow us to disentangle the
primordial and foreground contributions @Leach2008 ~#cite(<Leach2008>) #cite(<CORE:2017yri>) #cite(<Planck2018IV>)


To separate these primordial and foreground components, #emph[LiteBIRD] will survey the full sky in 15 frequency bands from 34 to 448 GHz, with effective polarization sensitivity of $2 thin mu$K-arcmin and angular resolution of $31$ arcmin (at 140 GHz). Rapid polarization modulation, a densely linked observation strategy, and the stable environment of an orbit around L2 (the second Lagrangian point for the Sun-Earth system), provide unprecedented ability to control systematic errors, especially on the largest angular scales below $ell tilde.eq 10$. Taken
together, the control of foregrounds and systematic errors gives #emph[LiteBIRD] the ability to detect both the reionization and recombination bumps in the $B$-mode power spectrum, giving much higher confidence that a primordial signal has been uncovered. Importantly, if a hint of the recombination peak is seen by a ground-based or balloon-borne experiment, #emph[LiteBIRD] will make a definitive statement on the detection of the signal and greatly improve the quantitative constraints on the physics of inflation. The forecast for #emph[LiteBIRD]'s ability
to measure the primordial $B$-mode power spectrum is shown in @fig:cl, together with currently available measurements.


Even in the absence of gravitational waves, on the largest angular scales, scattering of photons during the reionization epoch at $z tilde.eq 6$--10 generates $E$-mode polarization #cite(<zaldarriaga:1997>) #emph[LiteBIRD] will measure this signal with high precision and will make a definitive determination of the optical depth to the surface of last scattering. The optical depth contains key information about the nature of the epoch of reionization and will, for example, constrain models of the first stars. The optical depth is currently the least
well-constrained parameter of the standard cosmological model and currently limits any constraints that rely on comparisons of the amplitude of CMB anisotropies and clustering of the matter distribution, such as the measurement of the sum of neutrino masses~#cite(<DiValentino:2015sam>) #cite(<allison-etal:2015>) #cite(<Giusarma:2016phn>) #cite(<Archidiacono:2016lnv>) #cite(<boyle-komatsu:2018>) #emph[LiteBIRD] will provide a cosmic-variance-limited measurement#footnote[A measurement is cosmic-variance-limited if the error bar is limited only by the
fraction of sky available for the cosmological analysis and can no longer be decreased by improving the instrument~~#cite(<abbott-wise:1984:2>) #cite(<White:1993jr>) #cite(<ScottSrednickiWhite:1994>) #cite(<Knox:1995>)] of $E$-modes at low multipoles. This will complement measurements by high-resolution ground-based CMB experiments such as the SPO @10.1117-12.2561995, SO #cite(<Ade:2018sbj>), and CMB-S4~#cite(<Abazajian:2016yjj>) and will significantly improve cosmological measurements of the sum of neutrino masses.


Finally, the #emph[LiteBIRD] all-sky polarized maps in 15 frequency bands will be a rich legacy data set for understanding the large-scale magnetic field structure in the Milky Way, having five times greater sensitivity to Galactic magnetic fields than ESA's #emph[Planck] mission~#cite(<Planck2018XI>) #cite(<Planck2018XII>)


== Outline of this Review
<ss:intro_outline>


This paper is arranged as follows. @s:cmb_polarization introduces CMB $B$-mode tests of cosmic inflation, including constraints expected by #emph[LiteBIRD] and an argument for the necessity for CMB $B$-mode measurements from space. @ss:litebird_overview gives a broad overview of the #emph[LiteBIRD] mission, including the science requirements, a description of the instrument, and a description of flight operations. @s:payload describes the #emph[LiteBIRD] instrument, including the telescope designs, the bolometric detector arrays, the readout, the
cryogenics, and calibration strategy. @s:cosmological_forecasts gives a detailed analysis of the statistical and systematic uncertainties in the tensor-to-scalar ratio measurement; this section also includes an analysis of the impact of foregrounds and instrumental uncertainties. @s:scientific_outcomes describes the scientific outcomes of #emph[LiteBIRD] beyond the detection of primoridial gravitational waves, including measurement of the optical depth to reionization, determination of neutrino masses, a search for cosmic birefringence, mapping hot gas
in the Universe, a search for anisotropic CMB spectral distortions, a probe of primordial magnetic fields, and measurements to elucidate the astrophysics of the Milky Way. @s:discussion describes possible extensions to the #emph[LiteBIRD] mission design, including extending the frequency range, as well as synergy with other cosmology and astrophysics projects. @s:conclusions concludes this review.


= CMB #emph[B] Modes as Tests of Cosmic Inflation
<s:cmb_polarization>


== CMB Polarization Power Spectra
<cmb-polarization-power-spectra>


#emph[LiteBIRD] will provide maps of the temperature and polarization anisotropies in 15 frequency bands from 34 to 448 GHz. Fundamental theory does not predict the detailed structure of the maps, only their statistical properties, like the expected correlations between temperature and polarization anisotropies between different points on the sky. Earlier measurements by #emph[WMAP]~and #emph[Planck]~imply that the anisotropies are nearly Gaussian so that their statistical properties are predominantly characterized by the 2-point correlation
functions~#cite(<Komatsu2003>)#cite(<Planck2013XXIV>) #cite(<Planck2015XVII>) #cite(<Planck2018IX>). The observations by #emph[WMAP]~and #emph[Planck]~also tightly constrain departures from statistical isotropy~@Bennett2010 @Planck2013XXI @Planck2015XVI ~#cite(<Bennett2010>) #cite(<Planck2013XXI>) #cite(<Planck2015XVI>) #cite(<Planck2018VII>). Under the assumption that the underlying probability distribution is isotropic, the correlations between anisotropies at different points in the sky only depend on the angle between them.


Given these properties, it is natural to consider angular correlation functions that measure the correlations between different points in the sky as a function of this angular separation. While it would be possible to work with maps and their angular correlation functions, in practice it is more convenient to expand the temperature $T$ maps in terms of spherical harmonics, $ Delta T ( hat(n) ) = sum_(ell  thin  m) a_(ell m)^T Y_(ell m) ( hat(n) ) thin , $ and work with the coefficients of this expansion $a_(ell m)^T$, referred to as multipole coefficients.


Similarly, it is convenient to expand the maps of the Stokes $Q$ and $U$ parameters, which characterize the linear polarization, in terms of spin-weighted spherical harmonics, $zws_2 Y_(ell m)$, $ Q ( hat(n) ) + i U ( hat(n) ) = - sum_(ell  thin  m) ( a_(ell m)^E + i a_(ell m)^B ) thin zws_2 Y_(ell m) ( hat(n) ) thin , $ and work with the expansion coefficients $a_(ell m)^E$ and $a_(ell m)^B$. This decomposition into $E$- and $B$-mode polarization is convenient because $E$- and $B$-mode patterns have distinct parity, i.e., they transform differently under
the inversion of spherical coordinates, $hat(n) arrow.r - hat(n)$. Specifically, the spherical harmonics coefficients transform as $a_(ell m)^E arrow.r ( - 1 )^ell a_(ell m)^E$ and $a_(ell m)^B arrow.r ( - 1 )^(ell + 1) a_(ell m)^B$. As a result, when forming the angular power spectra#footnote[The use of angular power spectra rather than correlation functions is convenient because it leads to a nearly diagonal covariance matrix. For a non-expert review of the physics of the CMB and CMB observables see, for example, @Samtleben:2007zz and for a more
technical overview of CMB polarization see @HuWhite1997Primer. The expressions given here are idealized. In practice, foreground emission near the Galactic plane is too bright and must be masked, the instrument has finite resolution, the maps are pixelized, and so on, all of which lead to (known) corrections to these expressions.] $ C_ell^(X Y) = frac(1, 2 ell + 1) sum_m a_(ell m)^X a_(ell m)^(Y \*) thin , $<eq:Cl> where $X$ and $Y$ are either $T$, $E$, or $B$, there are "parity-even" combinations such as $C_ell^(T T)$, $C_ell^(T E)$, $C_ell^(E E)$, and
$C_ell^(B B)$ that do not change sign under the inversion of spherical coordinates, as well as "parity-odd" combinations such as $C_ell^(T B)$ and $C_ell^(E B)$ that do change sign. All of the parity-even combinations from the density fluctuations (scalar perturbation) have been measured already, as seen in @fig:cl, whereas $C_ell^(B B)$ from the primordial gravitational waves (tensor perturbation), the target of the #emph[LiteBIRD] mission, have not been detected
yet~#cite(<newKeckArrayBicep2>) #cite(<Sayre:2019dic>) #cite(<Tristram:2020wbi>) #cite(<SPIDER:2021ncy>). The parity-odd combinations of the CMB polarization can be used to probe new physics which violates parity symmetry~@lue-wang-kamionkowski:1999@feng-etal:2005@liu-lee-ng:2006@saito-ichiki-taruya:2007@contaldi-magueijo-smolin:2008. While no significant evidence for parity-odd power spectra of the CMB has been found (see~@PlanckIntXLIX@kaufman-keating-johnson:2016@minami-komatsu:2020 for summaries), $C_ell^(T B)$ from the polarized dust emission in our
Galaxy has been found ~@PlanckIntXLIX #cite(<Planck2018XI>)


// [figvision-cn] imgs/LBPTEP.png
// 该图包含三个垂直堆叠的功率谱子图，分别展示宇宙微波背景
// 辐射（CMB）的温度涨落（TT）、E模式偏振（EE）和B模式偏
// 振（BB）。所有子图共享相同的横坐标轴：多极矩 ℓ，对数刻
// 度，范围从 2 到 2000；顶部额外标注了对应的角尺度，从左
// 至右为 90°、18°、3°、1°、0.2°、0.1°。纵坐标轴为约化功
// 率谱 ℓ(ℓ+1)C_ℓ/2π，单位为 μK²，对数刻度，范围从 10⁻ 到
// 10³。 左上角图例说明不同颜色数据点对应实验：灰色圆点为
// WMAP，蓝色为 Planck，橙色为 ACT，黄色为 SPTpol，绿色为
// POLARBEAR，品红色为 BICEP/Keck，黑色粗体文字“LiteBIRD”
// 表示预测灵敏度曲线（无数据点，仅理论线）。 最上方子图
// 为 CMB-TT（温度-温度功率谱）：实线灰线代表最佳拟合 Λ
// CDM 模型（含张量扰动，r=0.04），在低 ℓ（<30）处平台约
// 10³ μK²，随 ℓ 增加缓慢上升，在 ℓ≈200 达到峰值 ~1500 μK
// ²，之后振荡衰减。数据点覆盖全 ℓ 范围，与理论线吻合良好，
// 误差棒较小。 中间子图为 CMB-EE（E模式偏振功率谱）：实
// 线灰线同样为 ΛCDM 模型预测，在 ℓ<10 时低于 10⁻¹ μK²，
// 随 ℓ 增加单调上升，在 ℓ≈80–200 区间达峰值 ~10¹ μK²，后
// 振荡下降。数据点分布密集，尤其在 ℓ>30 区域，Planck（蓝）、
// ACT（橙）、SPTpol（黄）等实验数据与理论线一致，误差棒
// 随 ℓ 增大而增大。 最下方子图为 CMB-BB（B模式偏振功率谱）：
// 包含三条关键曲线。第一条是灰色实线，代表总 BB 功率谱（
// 含引力透镜效应），在 ℓ<10 时约 10⁻⁴ μK²，随 ℓ 上升至 ℓ
// ≈1000 处达峰值 ~10⁻¹ μK²。第二条是灰色虚线，标注“
// Lensing”，表示由引力透镜产生的 BB 贡献，形状类似但幅度
// 较低，在 ℓ≈1000 处峰值约 10⁻² μK²。第三条是更细的灰色
// 虚线，标注“Primordial r=0.004”，表示原初引力波（张量扰
// 动）贡献，在 ℓ<100 处主导，峰值约 10⁻⁵ μK²，随 ℓ 增大
// 迅速衰减。此外，图中有多条垂直彩色线段表示各实验的灵敏
// 度极限：蓝色长竖线（Planck）位于 ℓ≈10，延伸至 10⁻³ μK²；
// 橙色竖线（ACT）位于 ℓ≈900，延伸至 10⁻² μK²；绿色竖线（
// POLARBEAR）位于 ℓ≈1500，延伸至 10⁻¹ μK²；品红色短竖线
// （BICEP/Keck）位于 ℓ≈100，延伸至 10⁻³ μK²。这些数据点
// （黑点带误差棒）集中在 ℓ=2–200 区间，显示当前观测尚未
// 探测到显著原初 B 模式信号，主要受限于噪声和系统误差。
// 整体趋势表明：TT 和 EE 谱已被高精度测量并验证 ΛCDM 模
// 型；BB 谱中目前仅能约束引力透镜成分，原初张量扰动（r=
// 0.004）远低于当前实验灵敏度，未来 LiteBIRD 任务有望探
// 测更低 r 值。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Fig. #context it.counter.display(it.numbering): #it.body]
}

#figure(placement: top, image("imgs/LBPTEP.png", width: 100%),
  caption: [
    CMB power spectra of the temperature anisotropy (top), $E$-mode polarization (middle), and $B$-mode polarization (bottom). The solid lines show the angular power spectra for the best-fit $Lambda$CDM model in the presence of a scale-invariant tensor (gravitational wave) perturbation with a tensor-to-scalar ratio parameter of $r = 0.004$. The thin dashed line shows the contribution to the $B$-mode spectrum from scale-invariant tensor perturbation with $r = 0.004$. A summary of present measurements of CMB power spectra (colored
points)~@hinshaw-etal:2013@Bennett2012 ~#cite(<hinshaw-etal:2013>) #cite(<Bennett2012>) #cite(<Ade:2017uvt>) #cite(<newKeckArrayBicep2>) #cite(<Henning:2017nuy>) #cite(<Planck2018V>) #cite(<Sayre:2019dic>) #cite(<Aiola:2020azj>) #cite(<Choi:2020ccd>) #cite(<Adachi:2020knf>) #cite(<BK2021>) and the expected polarization sensitivity of ~(black points) are also shown.
  ]
)
<fig:cl>


As we briefly mentioned in the introduction, the decomposition into $E$ and $B$ modes is convenient also because, to linear order, the well-measured density perturbations only generate temperature and $E$-mode anisotropies, whereas gravitational waves lead to $B$ modes in addition to temperature anisotropies and $E$ modes. Somewhat heuristically, this can be understood from the fact that $E$ modes behave much like the gradient component of a vector field, whereas the $B$ modes behave like the curl-like component. At linear order, one can construct a
gradient component from density perturbations, but it is impossible to construct a curl-component. For more details, we refer the interested reader to Refs.~@Baumann:2009ds. So $B$ modes provide the cleanest way for CMB experiments to search for primordial gravitational waves.


To see more explicitly how the information about the very early Universe is encoded, note that the contributions of primordial density perturbations to the angular power spectra of temperature or $E$-mode anisotropies are schematically given by $
  C_( s ) , ell^(X X) = integral frac(d k, k) Delta_zeta^2 ( k ) lr(|integral_0^(tau_0) d tau thin S_( s )^X ( k  thin  tau ) thin j_ell [k ( tau_0 - tau )]|)^2 thin ,
$ <eq:clscalar> where $k$ is the wave number of a Fourier mode and $tau$ is the so-called conformal time, which is related to the physical time $t$ as $d tau = d t \/ a ( t )$ with $a ( t )$ being the scale factor for the homogeneous and isotropic expansion of space. The subscript "0" indicates the present-day epoch. The integrand factorizes into three pieces:

- The primordial power spectrum of density perturbations as a function of $k$ (or equivalently radians per distance), $Delta_zeta^2 ( k )$, which contains information about the very early Universe.

- The source functions, $S_( s )^X ( k , tau )$, which contain information about the physics of the medium, largely from recombination to the present.

- The spherical Bessel functions, $j_ell ( x )$, for a spatially flat universe.


Similarly, the contributions of primordial gravitational waves to the angular power spectra of temperature, $E$-mode, and $B$-mode anisotropies are given by $
  C_( t ) , ell^(X X) = integral frac(d k, k) Delta_h^2 ( k ) lr(|integral_0^(tau_0) d tau thin S_( t )^X ( k  thin  tau ) thin chi_ell^X [k ( tau_0 - tau )]|)^2 thin ,
$ <eq:cltensor> where $Delta_h^2 ( k )$ is now the primordial power spectrum of gravitational waves, $S_( t )^X ( k , tau )$ are source functions for tensor perturbations in the medium, and $chi_ell^X ( x )$ is a function of the spherical Bessel functions and their derivatives appropriate for $X = T$, $E$, or $B$~#cite(<Seljak:1996is>) #cite(<Zaldarriaga:1996xe>) #cite(<Kamionkowski:1996ks>) #cite(<HuWhite1997Total>)


A wealth of information about the Universe is contained in the dependence of the source functions and the argument of the spherical Bessel function on cosmological parameters, like the matter density, the number of relativistic degrees of freedom, and so on. Here we are most interested in the information contained in the primordial power spectra, $Delta_zeta^2 ( k )$ and $Delta_h^2 ( k )$, which are conventionally parameterized as~#cite(<Lyth:1998xn>) $
  Delta_zeta^2 ( k ) = Delta_zeta^2 (k \/ k_(*))^(n_s ( k ) - 1) quad "and" quad Delta_h^2 ( k ) = Delta_h^2 (k \/ k_(*))^(n_t ( k )) thin ,
$ where $k_(*)$ is a pivot scale that will be taken to be $k_(*) = 0.05 thin "Mpc"^(- 1)$ throughout this document, and $n_s$ and $n_t$ are referred to as the scalar and tensor spectral indices, respectively. In general $n_s$ and $n_t$ are functions of $k$. However, the scale dependence is expected to be weak, and the default analyses typically report $n_s = n_s ( k_star.op )$. So-called "scale-invariant" spectra correspond to $n_s = 1$ and $n_t = 0$.


Unfortunately,#footnote[for the prospect of detecting primordial B-modes] $B$ modes are not only generated by primordial gravitational waves, but also by weak lensing of the CMB by matter along the line of sight, which converts $E$-modes into $B$-modes~@zaldarriaga-seljak:1998, and by polarized Galactic emission from interstellar dust grains and relativistic electrons~@Leach2008 #cite(<CORE:2017yri>) #cite(<Planck2018IV>). As a consequence, in order to detect the $B$ modes from primordial gravitational waves, both lensing and foreground contributions
must be carefully accounted for. As we will discuss in more detail, #emph[LiteBIRD] employs 15 frequency bands to characterize and remove the foreground emission. The weak lensing signal has the same frequency dependence as the gravitational wave signal, but its angular dependence is theoretically well-understood. Furthermore, because the weak lensing is caused by large-scale structure along the line of sight, some of the weak lensing signal can be removed by combining #emph[LiteBIRD] with other data
sets~@smith-etal:2012@simard-hanson-holder:2015@sherwin-marcel:2015@namikawa-nagata:2015@larsen-etal:2016.


The theoretical predictions and current measurements of the angular power spectra are shown in @fig:cl. The #emph[LiteBIRD] error bars, which are used for the constraints presented in the next sections, include foreground residuals as detailed in @s:cosmological_forecasts.


== Cosmic Inflation
<ss:cmbpol_inflation>


The remarkable insight gained from analysing cosmological data is that all cosmic structures, such as galaxies, stars, planets, and eventually us, appear to have originated from tiny quantum fluctuations in the early Universe. Within this inflationary picture, there was a very early period of nearly exponential expansion that generated the seed fluctuations for today's structure.


According to general relativity, spacetime expands exponentially if the energy budget is dominated by vacuum energy. However, from our existence, we know that this early period of cosmological inflation must have ended. This requires a clock, or more formally a scalar field, that keeps track of time and eventually causes inflation to end. Within quantum mechanics, this scalar field will experience quantum fluctuations, and according to cosmic inflation these initially microscopic quantum fluctuations were stretched to macroscopic scales by the nearly
exponential expansion, serving as the seeds of structure formation ~#cite(<mukhanov-chibisov:1981>) #cite(<starobinsky:1982>) #cite(<hawking:1982>) #cite(<guth-pi:1982>) #cite(<bardeen-turner-steinhardt:1983>)


In this scenario, the matter sector must include a scalar field, the "inflaton", $phi.alt$. For the simplest models of inflation, the action contains $ integral d^4 x sqrt(- g) [- 1 \/ 2 g^(mu nu) partial_mu phi.alt partial_nu phi.alt - V ( phi.alt )] thin , $ and is characterized by the potential $V ( phi.alt )$. As usual, we denote the expansion rate of the universe (called the "Hubble rate") by $H = dot(a) \/ a$, where $a ( t )$ is the scale factor appearing in the flrw line element. For a flat flrw universe this line element is
$d s^2 = - d t^2 + a^2 ( t ) d upright(bold(x))^2$, and the dynamics of the scale factor is governed by the Friedman equation $ H^2 = frac(8 pi G, 3) rho thin , $ where $rho = frac(1, 2) dot(phi.alt)^2 + V ( phi.alt )$ is the energy density in the inflaton.


The slow-roll parameter $epsilon.alt$, the fractional rate of change of the expansion rate in one Hubble time ($1 \/ H$), is given by~#cite(<Lyth:1998xn>) $ epsilon.alt equiv - dot(H) \/ H^2 = frac(3 dot(phi.alt)^2, dot(phi.alt)^2 + 2 V ( phi.alt )) thin . $ If the energy density of the scalar field is dominated by the potential energy density $dot(phi.alt)^2 lt.double V ( phi.alt )$, the slow-roll parameter is small, $epsilon.alt lt.double 1$. In this case the scale factor grows nearly exponentially. To be phenomenologically viable, inflation must last
sufficiently long to solve the horizon and flatness problems~#cite(<guth:1981>). The simplest way to satisfy this requirement is to have a potential that is flat enough so that the fractional rate of change of the inflaton velocity per Hubble time is small. Such models of inflation, based on a single slowly rolling scalar field, predict statistically homogeneous and isotropic, adiabatic, and nearly Gaussian primordial density perturbations with a spectrum of primordial density perturbations given by~#cite(<Lyth:1998xn>) $
  Delta_zeta^2 ( k ) = frac(1, 2 epsilon.alt M_P^2) (frac(H, 2 pi))^2 thin ,
$ <eq:Dz2> where the slow-roll parameter $epsilon.alt$ and the Hubble rate $H$ are to be evaluated at a time when $k = a H$, and $M_P$ is the (reduced) Planck mass. Since both $epsilon.alt$ and $H$ are slowly varying functions of time, the spectrum is expected to be nearly (but not exactly) scale invariant $n_s tilde.eq 1$. Furthermore, as inflation proceeds, the Hubble rate decreases. The slow-roll parameter $epsilon.alt$ is small during inflation, approaches unity as inflation ends, and in the simplest models it increases monotonically. Decreasing $H$
and increasing $epsilon.alt$ implies that the simplest models predict a red spectrum, i.e. an amplitude of the power spectrum that decreases with increasing wave number, corresponding to $n_s < 1$. All these predictions, including the deviation from an exactly scale invariant spectrum, have been confirmed by CMB data from #emph[WMAP]~@Komatsu2009@komatsu-etal:2011@hinshaw-etal:2013, the #emph[Planck] satellite~@Planck2013XXII @Planck2015XX @Planck2018X, and various ground-based observations
@story-etal:2013@sievers-etal:2013@aylor-etal:2017@louis-etal:2017.


So far we have discussed the period during which the Universe expands nearly exponentially. From the Cosmos today, we know that eventually this period must have ended, and the energy density in the inflaton must have been converted to a plasma of standard-model particles. This process is referred to as "reheating"~#cite(<Kofman:1994rk>) #cite(<Kofman:1997yn>) #cite(<Lozanov:2019jxc>). The details of reheating are unknown, but rather remarkably, the observational predictions only mildly depend on these details, at least for the single-field models
discussed here~#cite(<Bardeen:1980kt>) #cite(<Weinberg:2003sw>) #cite(<Weinberg:2004kr>). The main effect on observables arises from the amount by which the Universe expands during reheating. The amount of expansion during this period affects how physical scales today are related to physical scales during inflation, or more quantitatively how long has elapsed before the end of inflation $k_(*) = a H$.


== Primordial Gravitational Waves from Cosmic Inflation
<ss:cmbpol_pgw>


Constraints on the primordial spectrum of density perturbations from observations of temperature and $E$-mode anisotropies provide strong evidence for the quantum mechanical origin of cosmic structure, and to many they already suggest that the early Universe underwent a period of inflation. However, extraordinary claims require extraordinary evidence.


Like the scalar field, the spacetime metric also fluctuates, and just like the fluctuations in the scalar field, the microscopic fluctuations in the spacetime metric were also stretched to macroscopic scales by the inflationary expansion. So inflation predicts a statistically homogeneous and isotropic, nearly Gaussian background of primordial gravitational waves~#cite(<grishchuk:1975>) #cite(<starobinsky:1979>) #cite(<abbott-wise:1984>). For models based on a single slowly rolling scalar field the power spectrum is given by~#cite(<Lyth:1998xn>) $
  Delta_h^2 ( k ) = 8 \/ M_P^2 (frac(H, 2 pi))^2 thin ,
$ <eq:Dh2> where $H$ is again to be evaluated when $k = a H$. Since $H$ is a slowly decreasing function of time, the primordial gravitational wave spectrum is expected to be nearly scale invariant $( n_t tilde.eq 0 )$ and red $( n_t < 0 )$. According to @eq:Dh2, in the context of inflation a detection of a primordial gravitational wave signal would allow a determination of the expansion rate of the Universe during inflation. In single-field slow-roll models, the expansion rate is directly related to the energy scale of inflation, $V tilde.eq 3 H^2 M_P^2$.


These gravitational waves are a remarkable prediction of inflation, and their detection would provide strong independent evidence for inflation, arguably providing definitive confirmation. A detection of this signal would also be the first observation of quantum fluctuations of spacetime itself, and have other important implications to be discussed below.


== Implications of LiteBIRD Power Spectrum Measurements for Inflation
<ss:cmbpol_r>


To discuss the implications of #emph[LiteBIRD]'s $B$-mode power spectrum measurements for inflation, it is convenient to introduce the ratio of the power in primordial gravitational waves, given in @eq:Dh2, to the power in primordial density perturbations, defined in @eq:Dz2, referred to as the "tensor-to-scalar ratio", $ r = frac(Delta_h^2 ( k ), Delta_zeta^2 ( k )) thin . $ Key quantities like the energy scale of inflation and the range traveled by the scalar field are closely related to
this parameter, and different classes of models of inflation make different predictions for $r$.


In single-field slow-roll models, the amplitude of the primordial density perturbations inferred from measurements of temperature and $E$-mode perturbations, together with the Friedmann equation, allows us to express the energy scale of inflation in terms of $r$ through $
  V^(1 \/ 4) = 1.04 times 10^16 "GeV" (r \/ 0.01)^(1 \/ 4) thin .
$ Thus, a detection achievable by #emph[LiteBIRD] would imply that the inflationary energy scale is close to that associated with grand unified theories, and would provide additional evidence for the idea of grand unification~#cite(<Lyth:1996im>)


Under the same assumptions, the tensor-to-scalar ratio not only constrains the energy scale of inflation, but also the distance traveled by the inflaton~#cite(<Lyth:1996im>), $
  frac(Delta phi.alt, M_P) gt.tilde (r \/ 8)^(1 \/ 2) N_(*) thin ,
$ where $N_(*)$ represents the number of "$e$-folds", the natural logarithm of the change in linear scale of the Universe, between the time when $k_(*) = a H$ and the end of inflation. As briefly discussed earlier, the exact time when $k_(*) = a H$, and hence the value of $N_(*)$, depends on the details of reheating, the process that converts the energy density in the inflaton into a hot plasma of standard model particles. This process is not well constrained, but taking $N_(*) = 30$ as a conservative lower limit, we see that a detection of gravitational
waves above $r = 0.01$ would imply an excursion in field space that exceeds $M_P$. Such a detection would significantly constrain theories of quantum gravity, such as superstring theories (see for example, @Obied:2018sgi and references therein).


In the absence of a detection, #emph[LiteBIRD] will set an upper limit of $r < 0.002$ at 95 % C.L. (accounting for both statistical and systematic uncertainties). Since both the energy scale and the field range vary slowly with $r$, an upper limit does not immediately translate into stringent constraints on either the energy scale or the distance traveled by the inflaton. To explain the implications of an upper limit and to understand the motivation for the #emph[LiteBIRD] design sensitivity we will require an additional concept, that of the
characteristic scale of the potential~#cite(<Abazajian:2016yjj>) #cite(<Linde:2016hbb>). To introduce this quantity and highlight its importance, we will begin with an argument that does not involve the microscopic details of a particular model of inflation.


Provided the fractional rate of change of the expansion rate is small compared to the expansion rate, $epsilon.alt lt.double 1$, the tensor-to-scalar ratio $r$ obeys a simple differential equation in terms of the number of $e$-folds $N$ until the end of inflation~#cite(<Mukhanov:2013tua>) #cite(<Roest:2013fha>) #cite(<Creminelli:2014nqa>) $
  frac(d ln r, d N) = [n_s ( N ) - 1] + r \/ 8 thin .
$


The cosmic microwave background allows us to observe a window of a few $e$-folds around $N_(*)$, which we typically expect to be between 50 and 60. The observed departure of the primordial power spectrum from scale invariance is numerically close to $( p + 1 ) \/ N_(*)$, where $p$ is some number of order unity. In the simplest models of inflation, we expect additional small or large numbers beyond $N_(*)$ to be absent, which means that we expect $n_s ( N ) - 1 = - ( p + 1 ) \/ N$. In this case, we can solve the differential equation and find the general
solution up to an integration constant $N_("eq")$. If we continue with the assumption that there are no additional large or small numbers, the solution is well-described by one of two limiting behaviors, $
  r ( N ) = frac(8 p, N) quad quad "and" quad quad r ( N ) = frac(8 p, N) (N_("eq") \/ N)^p thin ,
$ <eq:r_vs_N> where $p$ is constrained to be positive, consistent with the observed red spectrum $n_s < 1$~@hinshaw-etal:2013@Planck2013XXII, and by assumption $N_("eq")$ is expected to be of order unity.


We previously saw that the simplest single-field models are completely characterized by a potential. It is then natural to ask which potentials give rise to these solutions. It can be shown that the first solution in @eq:r_vs_N corresponds to potentials that at least during inflation are well approximated by a monomial $V ( phi.alt ) tilde.eq mu^(4 - 2 p) phi.alt^(2 p)$. For $p$ of order unity, we see that this class of models predicts $r gt.tilde 0.01$, which is easily within reach of #emph[LiteBIRD].


For the second solution, the qualitative behavior depends on the value of $p$. For $p > 1$ the potential corresponds to so-called "hilltop" inflation models~#cite(<Boubekeur:2005zm>) for which the potential near the origin in field space approaches a constant from below like a power of the field set by $p$. Inflation occurs as the field rolls off the hill toward a minimum at larger field values. For $p < 1$ the potentials correspond to so-called "plateau" models, for which the potential approaches a constant from below at large field values, again with a
power set by $p$. In this case inflation occurs as the field rolls off the plateau toward a minimum near the origin.


Rather intriguingly, the current measurement of $n_s$ favors $p tilde.eq 1$, which is a special case. It corresponds to plateau models in which the plateau is approached exponentially, $
  V ( phi.alt ) tilde.eq V_0 (1 - e^(- phi.alt \/ cal(M))) thin .
$ This behavior occurs in many models of inflation, including Starobinsky $R^2$ model for inflation~#cite(<starobinsky:1980>) (discussed in more detail below), models in which inflation is driven by the Higgs boson~#cite(<Bezrukov:2007ep>) #cite(<Ballesteros:2016xej>), or more generally models with a non-minimally coupled inflaton~#cite(<Komatsu:1999mt>), fibre inflation #cite(<Cicoli:2008gp>), Poincaré disk models #cite(<Ferrara:2016fwe>) #cite(<Kallosh:2017ced>), $alpha$-attractors more generally~@kallosh-linde-roest:2013 #cite(<Carrasco:2015pla>)
@Planck2015XX #cite(<Kallosh:2014rga>), or the Goncharov-Linde model~#cite(<Goncharov:1983mw>) #cite(<Goncharov:1985yu>), just to name a few.


The "characteristic scale of the potential," $cal(M)$ is related to the integration constant $N_("eq")$ according to $cal(M) = sqrt(N_("eq")) M_P$. This allows us to express the tensor-to-scalar ratio in this class of models in terms of the characteristic scale as


$
  r tilde.eq 0.0025 (57 \/ N_(*))^2 (cal(M) \/ M_P)^2 thin .
$


Instantaneous reheating corresponds to $N_(*) tilde.eq 57$. Any delay in reheating will decrease $N_(*)$, and hence will increase the expected tensor-to-scalar ratio for a given characteristic scale. As a consequence, for $cal(M) gt.tilde M_P$ we expect $r gt.tilde 0.0025$, so that an upper limit from #emph[LiteBIRD] with $r < 0.002$ at 95 % C.L. (accounting for both statistical and systematic uncertainties) would disfavor any of the simplest models of inflation with a characteristic scale of the potential larger than the Planck scale.


In models such as the Starobinsky model, the Planck scale does not occur by accident, but appears because the characteristic scale and the Planck scale are set by the same dimensionful coefficient in the action, the coefficient of the Einstein-Hilbert term. This makes models with $cal(M) gt.tilde M_P$ a natural target for #emph[LiteBIRD]. In @fig:nsr-detection we take the Starobinsky model as our fiducial model to showcase what a detection of primordial gravitational waves with #emph[LiteBIRD] would look like in the $n_s$--$r$ plane.


// [figvision-cn] imgs/nsrlabeledrp00461_LB_v3.png
// 这是一张二维参数空间约束图，用于展示不同宇宙学模型及观
// 测实验对张量标量比（r）与标量谱指数（ns）的预测或限制。
// 子图类型：曲线图/置信区间图 坐标轴： 横坐标为 ns（标量
// 谱指数），范围从 0.955 到 1.00，刻度标记包括 0.955,
// 0.960, 0.965, 0.970, 0.975, 0.980, 0.985, 0.990, 0.995
// , 1.00。 纵坐标为 r（张量标量比），采用对数标度，范围
// 从 3×10^-4 到 0.1，刻度标记包括 3×10^-4, 0.001, 0.003,
// 0.01, 0.03, 0.1。 图例位于图的右侧，分为三个部分：
// LiteBIRD、BK18/Planck 以及具体的理论模型线型说明。 区
// 域描述（置信区间）： 橙色区域（对应图例 LiteBIRD）：这
// 是一个较宽的椭圆状区域，颜色包含浅橙色和深橙色两种层次。
// 该区域中心大致位于 ns=0.962, r=0.004 附近。浅橙色代表
// 68% 置信水平，深橙色代表 95% 置信水平。该区域表示
// LiteBIRD 卫星单独观测所能达到的限制精度。 绿色区域（对
// 应图例 LiteBIRD/Planck）：这是一个嵌套在橙色区域内的较
// 小椭圆状区域，同样包含浅绿色和深绿色两种层次。其位置与
// 橙色区域中心重合但范围更窄。浅绿色代表 68% 置信水平，
// 深绿色代表 95% 置信水平。该区域表示将 LiteBIRD 数据与
// Planck 卫星数据结合后能达到的更高精度的限制。 浅蓝色区
// 域（对应图例 BK18/Planck）：这是一个巨大的垂直带状区域，
// 覆盖了图中大部分宽度，但主要集中在 ns 小于 0.975 的区
// 域。该区域颜色为单一浅蓝色，代表当前 BK18 数据分析结合
// Planck 数据的观测限制。该区域形状显示目前观测对 r 的上
// 限限制较强，但对 ns 的限制相对较宽。 线条与点描述（理
// 论模型）： 深蓝色虚线（m^2φ^2 模型）：位于图的最上方，
// 是一条短的水平虚线段，r 值约为 0.12，对应 Ns（
// e-folding 数）范围为 47 < Ns < 57。 中蓝色虚线（μ^3φ
// 模型）：位于深蓝色虚线下方，是一条略微向下倾斜的虚线段，
// r 值从约 0.09 降至 0.07，Ns 范围为 47 < Ns < 57。 浅蓝
// 色虚线（μ^(10/3)φ^(2/3) 模型）：位于中蓝色虚线下方，是
// 一条向下倾斜的虚线段，r 值从约 0.05 降至 0.03，Ns 范围
// 为 47 < Ns < 57。 红色实线（R^2 模型）：位于橙色和绿色
// 区域内部，是一条向下倾斜的短线段，穿过绿色区域中心，Ns
// 范围为 42 < Ns < 52。 紫色实线（Poincaré disks 模型）：
// 这是一组平行的紫色短线段，呈阶梯状分布在绿色区域及其上
// 方，共有约 8-9 条线段，整体呈现随 ns 增加 r 减小的趋势。
// 紫色实心圆点（Higgs 模型）：位于绿色区域的右下边缘，具
// 体坐标约为 ns=0.964, r=0.0035，标注 Ns = 57。 其他标注：
// 在图的最右侧，有一条垂直的灰色长虚线，位置在 ns=1.00
// 处，旁边有垂直排列的文字“exact scale-invariance”（精确
// 尺度不变性）。 结论与趋势： 该图展示了未来的 LiteBIRD
// 任务（特别是结合 Planck 数据时，即绿色区域）将能够极大
// 地缩小对 r 和 ns 参数的限制范围，从而区分不同的暴胀模
// 型。目前的观测（浅蓝色区域）尚未排除多种高 r 值的模型，
// 而 LiteBIRD 有望验证或排除如 m^2φ^2 等高 r 模型，并对
// Starobinsky (R^2) 等低 r 模型进行精确检验。
#figure(placement: top, image("imgs/nsrlabeledrp00461_LB_v3.png", width: 100%),
  caption: [
    #emph[LiteBIRD] constraints on the tensor-to-scalar ratio $r$ and the scalar spectral index $n_s$ assuming Starobinsky's $R^2$ model for inflation~#cite(<starobinsky:1980>) with $N_(*) = 51$ (specifically the analytic prediction described in the text) as the fiducial model. The lighter and darker green regions show 68 % and 95 % confidence level limits achievable with #emph[LiteBIRD] and #emph[Planck]. The lighter and darker orange regions (partly hidden behind the green regions) show 68 % and 95 % confidence level limits achievable
with #emph[LiteBIRD] alone. The current limits are shown in light blue. The dotted blue lines show representative cases of the first class of models described in the text, monomial models. The red line and the dark purple dot show the predictions of the Starobinsky model~#cite(<starobinsky:1980>) (labeled as $R^2$) and models that invoke the Higgs field as the inflaton~#cite(<Bezrukov:2007ep>) #cite(<Ballesteros:2016xej>), respectively. The light purple lines shows the prediction for Poincaré disk models #cite(<Ferrara:2016fwe>) #cite(<Kallosh:2017ced>)
  ]
)
<fig:nsr-detection>


For a given reheating history, a model makes a definitive prediction, corresponding to a point in the $n_s$--$r$ plane. However, since the reheating history is uncertain, we represent the predictions of models by bars corresponding to $47 < N_(*) < 57$. One exception to this general rule is the Starobinsky model. Unlike for most models, the underlying idea of this example is that inflation is a consequence of a short-distance modification of the theory of gravity rather than a consequence of the matter sector. Even though the Starobinsky model can be
written as a scalar-tensor theory, like any generic $f ( R )$ theory~#cite(<Sotiriou:2008rp>) #cite(<DeFelice:2010aj>), this idea naturally predicts that the couplings to matter fields responsible for reheating are gravitational couplings in the $f ( R )$ frame. In this case, reheating is somewhat delayed. More detailed studies suggest that the delay corresponds to a change in $N_(*)$ of about 5. Thus, we take $N_(*) = 51$ for our fiducial model. In our simple analytic approximation, this leads to $r tilde.eq 0.0046$ and $n_s tilde.eq 0.961$. Since
reheating is expected to be slower, but the details are uncertain in the Starobinsky model as well, we show the model prediction with $42 < N_(*) < 52$. The second exception to the rule are models in which the inflaton is identified with the Higgs field. In this case we know the couplings to the matter fields, and the reheating history is calculable. To reflect this, we represent these models by a single point in the $n_s$--$r$ plane at $N_(*) = 57$, even though some uncertainty exists here as well.


// [figvision-cn] imgs/nsrlabeledr0_LB_v3.png
// 该图为一张二维参数空间约束图，横坐标为标量谱指数 $n_s$，
// 范围从 0.955 到 1.00；纵坐标为张量-标量比 $r$，采用对
// 数刻度，范围从 $3 \times 10^{-4}$ 到 0.1。图中包含多个
// 彩色区域、一条红色曲线、一个紫色圆点以及两条灰色斜线和
// 一条垂直虚线。 橙色区域（较浅）和深橙色区域（较深，部
// 分被绿色覆盖）分别代表 LiteBIRD 单独观测所能达到的 68%
// 和 95% 置信度上限区域，形状呈倒U型，位于图底部中央，覆
// 盖 $n_s$ 约 0.957 至 0.972、$r$ 约 $10^{-4}$ 至 0.002
// 的范围。 绿色区域（较浅）和深绿色区域（较深）分别代表
// LiteBIRD 与 Planck 联合观测所能达到的 68% 和 95% 置信
// 度上限区域，形状类似但更窄更高，覆盖 $n_s$ 约 0.958 至
// 0.970、$r$ 约 $10^{-4}$ 至 0.003 的范围，完全包含在橙
// 色区域内或与其重叠。 浅蓝色区域代表 BK18/Planck 当前观
// 测限制，形状不规则，覆盖 $n_s$ 约 0.958 至 0.975、$r$
// 约 $10^{-3}$ 至 0.03 的区域，位于绿色区域上方。 深蓝色
// 带状区域代表模型 $\phi^p$（其中 $47 < N_* < 57$），呈
// 弯曲带状，从左上角延伸至右下角，覆盖 $n_s$ 约 0.955 至
// 0.985、$r$ 约 $10^{-3}$ 至 0.1 的广阔区域，其左边界接
// 近 $n_s=0.955, r=0.1$，右边界在 $n_s \approx 0.985, r
// \approx 0.001$ 处收窄。 灰色填充区域代表模型 $V_0 \
// tanh^2(\phi / 2M)$，位于图左侧中部，被两条灰色斜线界定：
// 上斜线标注 “$M = 5 M_P$”，下斜线标注 “$M = M_P$”。该区
// 域覆盖 $n_s$ 约 0.958 至 0.965、$r$ 约 0.001 至 0.03。
// 红色实线代表模型 $R^2$（其中 $43 < N_* < 53$），是一条
// 从左向右轻微下降的直线，起点约 $(n_s=0.955, r=0.005)$，
// 终点约 $(n_s=0.965, r=0.003)$，穿过灰色区域内部。 紫色
// 实心圆点代表 Higgs 模型（$N_* = 57$），位于坐标 $(n_s
// \approx 0.965, r \approx 0.0035)$，处于浅蓝色区域边缘、
// 绿色区域上方、灰色区域右侧。 图右侧有一条垂直虚线，标
// 注 “exact scale-invariance”，对应 $n_s = 1.00$，贯穿整
// 个纵轴范围。 图例位于右上角，依次列出各颜色/符号对应的
// 物理含义：橙色方块对应 LiteBIRD，绿色方块对应 LiteBIRD
// /Planck，浅蓝色方块对应 BK18/Planck，灰色方块对应 $V_0
// \tanh^2(\phi / 2M)$，深蓝色方块对应 $\phi^p\ (47 < N_*
// < 57)$，红色线段对应 $R^2\ (43 < N_* < 53)$，紫色圆点
// 对应 Higgs ($N_* = 57$)。 整体趋势表明，LiteBIRD 单独
// 或联合 Planck 可将宇宙学参数约束至极小范围，尤其对低 $
// r$ 值敏感；不同理论模型预测的参数空间分布各异，Higgs
// 模型点落在当前观测允许范围内，而 $\phi^p$ 模型覆盖更广
// 的高 $r$ 区域，未来观测有望区分这些模型。
#figure(placement: top, image("imgs/nsrlabeledr0_LB_v3.png", width: 100%),
  caption: [
    #emph[LiteBIRD] constraints for a fiducial model with $r = 0$. The lighter and darker green regions show 68 % and 95 % confidence level upper limits achievable with #emph[LiteBIRD] and #emph[Planck]. The lighter and darker orange regions (partly hidden behind the green regions) show 68 % and 95 % confidence level upper limits achievable with #emph[LiteBIRD] alone. The blue band shows the first class of models mentioned in the text, monomial models. The gray band shows a concrete representative second class of plateau models with $p = 1$,
$alpha$-attractors~@kallosh-linde-roest:2013. As discussed in the text, the second class of models depends on the characteristic scale of the potential $cal(M)$. The darker gray lines show $alpha$-attractors with $cal(M) = M_P$ and $cal(M) = 5 M_P$. In the absence of a detection, #emph[LiteBIRD] will exclude the first class of models at high significance, and will exclude models in the second class with a super-Planckian characteristic scale, which includes the Starobinsky model~#cite(<starobinsky:1980>) and models that invoke the Higgs field as the
inflaton~#cite(<Bezrukov:2007ep>) #cite(<Ballesteros:2016xej>), shown as the red line and the purple dot, respectively.
  ]
)
<fig:nsr-upper>


Among the examples given above, the Goncharov-Linde model~#cite(<Goncharov:1983mw>) #cite(<Goncharov:1985yu>) predicts a sub-Planckian characteristic scale, and $alpha$-attractors~~#cite(<kallosh-linde-roest:2013>) #cite(<Carrasco:2015pla>) #cite(<Planck2015XX>) #cite(<Kallosh:2014rga>) with a sub-Planckian characteristic scale also exist. So a detection of primordial gravitational waves with #emph[LiteBIRD] is by no means guaranteed. We thus also showcase what an upper limit would look like in @fig:nsr-upper. Let us note that in addition to being
simpler in the sense that they do not contain a large hierarchy of scales, models with $cal(M) gt.tilde M_P$ are also simpler in a different sense. One may ask whether inflation will begin for general initial conditions for a given model, and it has recently become possible to investigate this question in numerical general relativity, assuming that the description in terms of a single scalar field is already appropriate at that time~#cite(<East:2015ggf>) #cite(<Clough:2016ymm>) #cite(<Clough:2017efm>) #cite(<Aurrekoetxea:2019fhr>). The simulations show
that models with $cal(M) gt.tilde M_P$ are significantly more robust to inhomogeneities and than those with $cal(M)\<M_(P)$~#cite(<Aurrekoetxea:2019fhr>). This does not imply that inflation cannot begin in models with a sub-Planckian characteristic scale, but it does suggest that additional dynamics (which could simply be in the form of another field) is needed to set up initial conditions that are appropriate for inflation to begin in such models. So an upper limit from #emph[LiteBIRD] would disfavor the simplest models of inflation that naturally
predict the observed value of $n_s$ and would also be a milestone for early Universe cosmology that provides key information about the inner workings of the earliest moments of the Cosmos.


== Beyond the #emph[B]-mode Power Spectrum
<ss:cmbpol_beyondpower>


Single-field slow-roll inflation predicts a stochastic background of gravitational waves that originated from quantum vacuum fluctuations in spacetime and is nearly scale invariant, nearly Gaussian, and parity conserving~#cite(<grishchuk:1975>) #cite(<starobinsky:1979>) #cite(<abbott-wise:1984>). The detection of a violation of any of these properties would point to new physics beyond the simplest models of inflation~#cite(<Komatsu:2022nvu>). The first condition can be tested by reconstructing the power spectrum $Delta_h^2 ( k )$ from the observed
$B$-mode power spectrum @hiramatsu-etal:2018@campeti-poletti-baccigalupi:2019, the second property can be tested through measurements of the three-point function (bispectrum)~@shiraishi-etal:2016@agrawal-fujita-komatsu:2018@agrawal-fujita-komatsu:2018b@dimastrogiovanni-etal:2018, and the third property can be tested by parity-violating correlation functions such as the cross-correlation between the temperature and the $B$-mode polarization, between the $E$- and $B$-mode polarizations
@lue-wang-kamionkowski:1999@saito-ichiki-taruya:2007~#cite(<lue-wang-kamionkowski:1999>) #cite(<saito-ichiki-taruya:2007>) #cite(<contaldi-magueijo-smolin:2008>) #cite(<sorbo:2011>) #cite(<thorne-etal:2018>), or parity-violating contributions to the three-point function~#cite(<shiraishi:2019>)


These conditions can be violated when non-minimal couplings of the inflaton are present~~#cite(<lue-wang-kamionkowski:1999>) #cite(<Bartolo:2017szm>) #cite(<Bartolo:2018elp>), or when other fields are present during inflation and source gravitational waves. The energy density in these fields must be sub-dominant compared to the energy density in the inflaton. However, their energy density may still be sufficient to produce gravitational waves with an amplitude within reach of #emph[LiteBIRD].


The additional sources could be scalar fields @cook-sorbo:2012@carney-etal:2012@biagetti-fasiello-riotto:2013@senatore-silverstein-zaldarriaga:2014, a U(1) gauge field #cite(<sorbo:2011>) @anber-sorbo:2012@barnaby-peloso:2011@barnaby-etal:2012@peloso-sorbo-unal:2016 #cite(<Campeti:2022acx>), or an SU(2) gauge field
@maleknejad-sheikh-jabbari:2011@maleknejad-sheikh-jabbari:2013@dimastrogiovanni-peloso:2012@adshead-etal:2013~#cite(<maleknejad-sheikh-jabbari:2011>) #cite(<maleknejad-sheikh-jabbari:2013>) #cite(<dimastrogiovanni-peloso:2012>) #cite(<adshead-etal:2013>) #cite(<adshead-martinec-wyman:2013>) #cite(<maleknejad:2016>) #cite(<obata-soda:2016>) #cite(<dimastrogiovanni-fasiello-fujita:2016>). All these sources can produce strongly scale-dependent gravitational waves (and, in general, density perturbations) that are highly non-Gaussian. The latter two types of
source can produce parity-violating gravitational waves. Hence a stochastic gravitational wave background generated during inflation need not satisfy any of the conditions predicted by single-field slow-roll inflation. If the gravitational waves sourced by the matter fields dominate over the vacuum fluctuations in the metric, then detecting $B$-mode polarization from primordial gravitational waves no longer generally implies the discovery of the quantum nature of space (although the matter that created them was still produced quantum-mechanically).
Nevertheless, such a discovery would still provide definitive evidence for inflation because we need inflation to stretch the wavelengths of gravitational waves to billions of light years.


An example of a U(1) gauge field is the primordial magnetic field, which can source tensor perturbations that are non-scale-invariant, non-Gaussian, and parity-violating (see @shiraishi:2019 and references therein). Magnetic fields can also induce a spatially-dependent rotation of polarization angles of the CMB by means of Faraday rotation. The effect can be detected using multi-frequency data because the Faraday rotation angle is inversely proportional to the square of the frequency. We discuss this possibility further in @ss:pmf.


The axion-SU(2) model described in Ref.~@dimastrogiovanni-fasiello-fujita:2016 provides an example that illustrates the benefits of a satellite mission with full sky coverage and access to the reionization bump. This model contains the inflaton, an axion, and SU(2) gauge fields. The energy density is always dominated by the inflaton field. The axion field $chi$ has a potential of the form $V ( chi ) prop 1 + cos ( chi \/ f )$, where $f$ is the axion decay constant, and the axion is coupled to the gauge fields through a Chern-Simons term,
$chi F tilde(F)$. For time-dependent $chi$, one of the helicities of the gauge field is amplified. This produces chiral gravitational waves~@dimastrogiovanni-peloso:2012@adshead-martinec-wyman:2013@maleknejad-sheikh-jabbari-soda:2013 with parity-violating correlations in the CMB power spectra and circular polarization for laser interferometers @thorne-etal:2018. The shape of the tensor power spectrum is determined by the evolution of $chi$ during inflation, and hence by the shape of $V ( chi )$. For the cosine potential, the axion velocity increases
initially, reaches the maximum at the inflection point, $chi ( t_(\*) ) = pi f \/ 2$, and then decreases. The resulting tensor power spectrum is approximately log-normal @thorne-etal:2018@fujita-sfakianakis-shiraishi:2019, $
  Delta_(h thin L  thin  thin s o u r c e d)^2 ( k ) = r_(*  thin  "sourced") Delta_zeta^2 ( k ) exp (- frac(1, 2 sigma^2) [ln (k \/ k_p)]^2) thin ,
$ <eq:su2power> where $r_(*  thin  "sourced")$ (hereafter $r_(*)$) and $k_p$ are the tensor-to-scalar ratio and the wavenumber at the maximum, and $sigma^2$ is the width of the power spectrum. The subscript "L" (for "left") stands for one of the polarization states (determined by the sign of $dot(chi)$), while the other polarization state is not amplified and is negligible. These quantities are determined by the parameters of the model~@thorne-etal:2018@fujita-sfakianakis-shiraishi:2019. This sourced contribution is added to the vacuum contribution
characterized by the vacuum tensor-to-scalar ratio, $r_("vac")$. The self-interaction of the gauge fields leads to non-Gaussian gravitational waves~@agrawal-fujita-komatsu:2018@agrawal-fujita-komatsu:2018b@dimastrogiovanni-etal:2018.


// [figvision-cn] imgs/axion_PTEP_final.png
// 这是一张对数-对数坐标系的曲线图，展示了宇宙微波背景辐
// 射（CMB）B模式功率谱随多极矩的变化。 横坐标为多极矩 $\
// ell$，范围从约 4 到 300，主刻度标记为 $10^1$ 和 $10^2$。
// 纵坐标为 B模式功率谱 $D_\ell$，单位为微开尔文平方（$\
// mu K^2$），范围从 $10^{-7}$ 到 $10^{-1}$，主刻度标记为
// $10^{-7}, 10^{-6}, \dots, 10^{-1}$。 图中包含三条理论
// 模型预测的曲线和两个表示观测误差的色带区域： 单场慢滚
// BB模型：由黑色点线表示。参数为张标比 $r = 0.00461$，张
// 量谱指数 $n_T = -r/8$，光学深度 $\tau = 0.0544$。该曲
// 线在低 $\ell$ 区域（$\ell < 10$）位于 $D_\ell \approx
// 6 \times 10^{-5} \mu K^2$ 附近，随后下降至 $\ell \
// approx 10$ 处的极小值（约 $1.5 \times 10^{-5} \mu K^2$），
// 之后上升并在 $\ell \approx 80$ 处达到峰值（约 $3 \
// times 10^{-4} \mu K^2$），最后随 $\ell$ 增大而下降。
// 轴子-SU(2) BB模型（第一组参数）：由紫色长虚线表示。参
// 数为真空涨落张标比 $r_{vac} = 10^{-4}$，特征张标比 $r_
// * = 0.00461$，动量尺度 $k_p = 0.01$，宽度参数 $\sigma
// = 1$。该曲线在低 $\ell$ 区域显著低于其他两条曲线（$\
// ell=4$ 时约为 $3 \times 10^{-6} \mu K^2$），随 $\ell$
// 增加迅速上升，在 $\ell \approx 15$ 处与黑色点线相交，
// 并在高 $\ell$ 区域（$\ell > 20$）与黑色点线几乎重合。
// 轴子-SU(2) BB模型（第二组参数）：由橙色点划线表示。参
// 数为 $r_{vac} = 10^{-4}$，$r_* = 0.041$，$k_p = 9 \
// times 10^{-6}$，$\sigma = 3.2$。该曲线在低 $\ell$ 区域
// （$\ell < 10$）数值最高（$\ell=4$ 时约为 $4 \times 10^
// {-4} \mu K^2$），随后急剧下降，在 $\ell \approx 10$ 处
// 降至最低点（约 $2 \times 10^{-5} \mu K^2$），之后上升
// 并与另外两条曲线在高 $\ell$ 区域汇合。 LiteBIRD误差条：
// 由深蓝色阶梯状色带表示，代表LiteBIRD卫星的预期测量误差。
// 该色带覆盖了从 $\ell \approx 4$ 到 $\ell \approx 200$
// 的范围，其高度（即误差大小）在不同 $\ell$ 区间呈阶梯式
// 变化，整体趋势是随着 $\ell$ 增大，误差逐渐减小（色带变
// 窄）。 宇宙方差限制误差条：由浅灰色阶梯状色带表示，代
// 表仅考虑宇宙学原理导致的根本性测量极限（包括原初涨落和
// 引力透镜效应）。该色带同样呈阶梯状分布，覆盖范围与深蓝
// 色色带类似，但在大部分区域比深蓝色色带更宽，表明宇宙方
// 差是比仪器噪声更主要的限制因素，尤其是在高 $\ell$ 区域。
// 结论：该图比较了不同暴胀模型对CMB B模式功率谱的预测，
// 并评估了未来LiteBIRD卫星及宇宙方差限制对这些模型的探测
// 能力。结果显示，在低 $\ell$ 区域，不同模型的预测差异显
// 著，特别是轴子-SU(2)模型的第二组参数预测远高于其他模型；
// 而在高 $\ell$ 区域（$\ell > 20$），所有模型的预测趋于
// 一致。LiteBIRD的误差条（深蓝色）在大部分区域小于或接近
// 宇宙方差限制（浅灰色），表明其设计灵敏度足以探测这些信
// 号，但受限于宇宙方差。
#figure(placement: top, image("imgs/axion_PTEP_final.png", width: 75.0%),
  caption: [
    $B$-mode power spectra, $D_ell = ell ( ell + 1 ) C_ell^(B B) \/ 2 pi$, for the Starobinsky model with $r = 0.00461$ and $n_t = - r \/ 8$ (black dotted line) and for axion-SU(2) inflation with two sets of parameters (see @eq:su2power for the definition): one with $r_(*) = 0.00461$, $k_p = 0.01 thin "Mpc"^(- 1)$ and $sigma = 1$ (purple dashed line) and another with $r_(*) = 0.041$, $k_p = 9 times 10^(- 6) med "Mpc"^(- 1)$ and $sigma = 3.2$ (orange dash-dotted line). The tensor-to-scalar ratio of the vacuum fluctuations is
chosen to be $r_("vac") = 10^(- 4)$. The cosmic-variance-only (including primordial and lensing $B$-mode variance) and total ~$plus.minus 1 thin sigma$ error bars (including foreground residuals) are shown as the gray and blue regions, respectively.
  ]
)
<fig:su2_axion>


In @fig:su2_axion, we compare example $B$-mode power spectra of this model (dot-dashed and dashed lines) and that of the Starobinsky model (dotted line). The parameters are chosen such that they all have indistinguishable recombination bumps ($ell tilde.eq 80$), whereas they are very different in their reionization bumps ($ell tilde.eq 4$). Therefore, a full-sky survey enabled by a space mission such as #emph[LiteBIRD] is necessary for establishing the origin of the primordial gravitational waves: tensor vacuum fluctuation versus sourced gravitational waves.


We conclude that, in the case of a detection, it will be important to confirm the detailed predictions of single-field slow-roll models using the #emph[LiteBIRD] data before claiming discovery of the quantum nature of spacetime. Applying the established methodology for the CMB bispectrum estimation to the #emph[LiteBIRD] $B$-mode data will allow us to improve constraints on tensor non-Gaussianities by several orders of magnitude ~#cite(<shiraishi:2019>). A violation of any of the basic predictions of single-field slow-roll models of inflation for
gravitational waves (i.e., nearly scale invariant, nearly Gaussian, parity conserving) would have profound implications for our understanding of the dynamics of inflation.


== The Need for Measurements from Space
<ss:cmbpol_space>


The #emph[COBE], #emph[WMAP], and #emph[LiteBIRD] data sets are recognized as the reference experiments for their respective CMB science goals. The success of these experiments depended on the advantages of the space environment for making high-fidelity observations of the CMB. These advantages include the following.


All frequencies are accessible, unlike on the ground where water and oxygen lines block access and reduce the ability to build a detailed model of the foreground emission. In particular, space observations can measure frequencies far into the Wien tail of the CMB to distinguish CMB fluctuations from Galactic dust emission.


Detector sensitivity is higher in space than on the ground due to the absence of the atmospheric loading and the disparity increases rapidly with frequency, giving much better per-detector leverage on Galactic dust measurements from space. As a rule of thumb, one detector in space is equivalent to 100 detectors (of the same quality) on the ground.


The absence of atmospheric emission and its large brightness fluctuations in space-based measurements give high-fidelity maps on large angular scales corresponding to $2 lt.eq ell lt.tilde 30$.


Bright sources such as the Earth and Sun are kept far from the boresight of the telescope by a large angle, giving very low systematic errors due to pickup of those sources in the telescope sidelobes.
#emph[LiteBIRD]'s ability to measure the entire sky at the largest angular scales with 15 frequency bands is complementary to that of ground-based experiments, which will focus on deep observations of low-foreground sky to search for an inflationary signal. #emph[LiteBIRD] observations have the potential to detect #emph[both] the recombination peak at $ell thin tilde.eq thin 80$ #emph[and] the reionization peak at $ell thin tilde.eq thin 4$. As highlighted earlier, high significance detections of both peaks would provide firm evidence that we have
detected the signature of inflation. A primary science requirement for #emph[LiteBIRD] is to detect both peaks with greater than $5 thin sigma$ significance for a relatively high value of $r thin = thin 0.01$. Detection of both peaks is necessary to distinguish between cosmological models with a similar recombination peak, as discussed in the previous section. For all detectable values of $r$, the all-sky data from #emph[LiteBIRD] can be tested for isotropy, which is a critical feature of a true cosmological $B$-mode signal.


Finally, #emph[LiteBIRD] can provide valuable foreground information for ground-based experiments. Ground-based experiments can improve #emph[LiteBIRD]'s observations with high-resolution lensing data. The #emph[LiteBIRD] data set will be timely, since it will be available at the same time as ground-based CMB data from Chile and the South Pole, as well as other powerful cosmological data sets such as those from the Vera C. Rubin Observatory, #emph[Euclid], and the #emph[Nancy Grace Roman Space Telescope].


== Comparison with Other Probes
<ss:cmbpol_other_probes>


Several methods have been proposed for observing primordial gravitational waves other than through CMB polarization measurements. These include future projects for a gravitational wave interferometer~#cite(<Moore:2014lga>), a technique using pulsar timing arrays~#cite(<NANOGRAV:2018hou>) #cite(<NANOGrav:2020bcs>), and a method using the 21-cm line~#cite(<Bharadwaj2009>). The sensitivity of the CMB to primordial gravitational waves is much better than those of the other probes, assuming the spectrum expected from standard cosmology; for example, the
sensitivity of #emph[LiteBIRD] is about 10 million times greater than that of #emph[LISA] #cite(<Campeti:2020xwn>). Therefore, the discovery of primordial gravitational waves seems dramatically more likely to come from CMB observations in this case. Once the primordial gravitational waves are discovered with CMB polarization observations, it will give us a concrete target for future projects using other methods. In some non-standard models, primordial gravitational waves can be enhanced at shorter wavelengths. Their observability by various probes
including that of #emph[LiteBIRD] is discussed elsewhere #cite(<Campeti:2020xwn>) with the conclusion that #emph[LiteBIRD] is competitive even in those non-standard models.


= LiteBIRD Overview
<ss:litebird_overview>


== Project Overview
<ss:overview_project>


After some initial conceptual studies~@Hazumi2008AIP @Hazumi2011PTPS @Hazumi2012SPIE @Matsumura2014JLTP @Matsumura2014SPIE that started in 2008, we proposed #emph[LiteBIRD] in 2015 as JAXA's large-class (L-class) mission candidate. JAXA's L-class is for flagship science missions with a 30 Billion Yen cost cap. There will be three L-class missions in about ten years, launched using JAXA's H3 rocket. #emph[LiteBIRD] passed an initial down-selection and completed a two-year Pre-Phase-A2 concept development phase in 2018. JAXA selected #emph[LiteBIRD] in May
2019 as the second L-class mission after #emph[MMX], the Martian Moons Exploration, which will be launched in the mid-2020s.


The #emph[LiteBIRD] Collaboration has more than 300 researchers as of January 2022, based in Japan, North America, and Europe, with experience in CMB experiments, X-ray satellite missions, and other large projects in high-energy physics and astronomy. In particular, a large number of researchers who worked on the #emph[Planck]~satellite are members of #emph[LiteBIRD]. We thus consider #emph[LiteBIRD] to be the successor to the #emph[Planck]~satellite.


#emph[LiteBIRD] will survey the polarization of the CMB radiation over the full sky with unprecedented precision. The full success criterion of #emph[LiteBIRD] is to achieve $delta r < 0.001$ for a fiducial model with $r = 0$, where $delta r$ is the total error on the tensor-to-scalar ratio.


Specifically, we define this as the value covering the 68 % area of the posterior probability function for $r$: $ frac(integral_0^(delta r) L ( r ) d r, integral_0^oo L ( r ) d r) = 0.68 thin . $ The posterior, $L ( r )$, including both statistical and systematic components, will be described in Sect. #ref(<s:cosmological_forecasts>, supplement: none)


This section gives a concise overview of #emph[LiteBIRD]. In @ss:overview_mission, we describe our Level-1 mission requirements, or scientific requirements, and the rationale behind them. In @ss:overview_system, we introduce our measurement requirements and their flow down to system requirements. After describing the launch vehicle (@ss:overview_launch_vehicle), we introduce the spacecraft and the payload module (@ss:overview_spacecraft), the service module (@ss:overview_svm), and the operation concept (@ss:overview_operation)


== Science Requirements
<ss:overview_mission>


In @fig:cl (@s:cmb_polarization above), we summarized the present measurements of the CMB power spectra, including $B$ modes, with the expected polarization sensitivities of #emph[LiteBIRD] displayed. The $B$-mode power is proportional to the tensor-to-scalar ratio, $r$, which has been observationally constrained by BICEP/Keck to be $r < 0.036$ (95 % C.L.)~#cite(<BK2021>), with a recent update folding in a re-analysis of #emph[Planck]~data yielding $r < 0.032$ (95 % C.L.)~#cite(<Tristram:2020wbi>) #cite(<Tristram:2021>) and $r < 0.037$ (95 %
C.L.)~#cite(<Campeti:2022vom>). The next generation of CMB polarization experiments on the ground have the potential to observe the signal around $ell tilde.eq 80$, coming from the recombination epoch. However, if $r$ is less than approximately 0.03, the $B$ modes due to gravitational lensing become dominant. Removing contamination of the lensing $B$ modes, often called "delensing," is needed in this case. In contrast, the other primordial signal, at $ell < 10$, which is due to reionization, is larger than the lensing $B$ modes, even for $r = 0.001$. In
order to access the reionization peak, one needs to survey the full sky, where the advantage of observing in space is clear.


The critical question is: to what precision should $r$ be measured? Here we introduce the total uncertainty on $r$, $delta r$, which consists of five components: (instrumental) statistical uncertainties; systematic uncertainties; uncertainties due to contamination of foreground components; uncertainties due to gravitational lensing; and uncertainties due to observer biases. There are many different inflationary models under active discussion, which predict different values of $r$. Among them, there are well-motivated inflationary models that predict
$r > 0.01$~@kamionkowski-kovetz:2016. If our requirement is $delta r < 0.001$, we can provide more than $10 thin sigma$ detection significance for such models. On the other hand, if #emph[LiteBIRD] finds no primordial $B$ modes and obtains an upper limit on $r$, then this limit will be stringent enough to set severe constraints on the physics of inflation. As discussed in @ss:cmbpol_r, if we obtain an upper limit at $r tilde 0.002$, we can completely rule out one important category of models, namely any single-field model in which the characteristic
field-variation scale of the inflaton potential is greater than the reduced Planck mass.


#figure(
  align(center)[#table(
    columns: 3,
    align: (left,left,left,),
    table.header([ID], [Title], [Requirement description],),
    table.hline(),
    [Lv1.01], [Tensor-to-scalar ratio $r$ measurement sensitivity], [The mission shall measure $r$ with a total uncertainty of $delta r thin < thin 1 times 10^(- 3)$. This value shall include contributions from instrumental statistical noise fluctuations, instrumental systematics, residual foregrounds, lensing $B$ modes, and observer bias, and shall not rely on future external data sets.],
    [Lv1.02], [Polarization angular power spectrum measurement capability], [The mission shall obtain full-sky CMB linear polarization maps for achieving $> thin 5 thin sigma$ significance using $2 thin lt.eq thin ell thin lt.eq thin 10$ and $11 thin lt.eq thin ell thin lt.eq thin 200$ separately, assuming $r thin = thin 0.01$. We adopt a fiducial optical depth of $tau = 0.05$ for this calculation.],
  )]
  , caption: [The two basic science requirements for #emph[LiteBIRD], also called Level~1 (Lv1) mission requirements.]
  , kind: table
  ) <tbl:lv1>



Based on all the considerations described above, we decided to impose the requirements described in @tbl:lv1. The first, Lv1.01, shall be achieved #emph[without] delensing using external data; if external data are available, we may further reduce $delta r$~#cite(<Diego-Palazuelos2020>)


The second requirement, Lv1.02, is essential to cover the case where $r$ turns out to be large. If there are already indications of the primordial $B$ modes before the observations by #emph[LiteBIRD], that would imply a relatively large value of $r$. In this case, data from #emph[LiteBIRD] will allow us to measure the $B$-mode signals from reionization and recombination simultaneously. If the spectral shape is consistent with expectations from the standard cosmology, that will narrow down the list of possible inflationary scenarios, and provide a much
deeper insight into the correct model. If we observe an unexpected power spectrum, beyond the standard model prediction, that will lead to a revolution in our picture of the physics of the early Universe. Lv1.02 also sets the angular resolution requirement for #emph[LiteBIRD].


== Measurement Requirements and System Requirements
<ss:overview_system>


To satisfy the science requirements described in the previous section, we use the requirements flow-down framework shown in @tab:reqflow.

To derive Lv2 measurement requirements from Lv1 science requirements, we also consider program-level constraints, such as the cost cap, which are not controlled by the #emph[LiteBIRD] team. We use agreed-upon assumptions between the #emph[LiteBIRD] team and other parties or within the #emph[LiteBIRD] team; examples include assumptions on the complexity of the astronomical foreground components, the cooling-chain lifetime, and basic system redundancy guidelines. There are in total 11 Lv2 measurement requirements on the statistical uncertainty (Lv2.01),
the systematic uncertainty (Lv2.02), the scan strategy (Lv2.03), the angular resolution (Lv2.04), calibration measurements (Lv2.05), error budget allocation (Lv2.06), systematic error budget allocation (Lv2.07), the duration of the normal observation phase (Lv2.08), the orbit (Lv2.09), observer bias (Lv2.10), and noise-covariance knowledge (Lv2.11).


Our error budget (Lv2.06) is defined such that an equal amount is given to the total statistical error after foreground separation $sigma_("stat")$, and the total systematic error $sigma_("syst")$. The requirements we chose are thus $sigma_("stat") < 0.6 times 10^(- 3)$ on the statistical uncertainty (Lv2.01) and $sigma_("syst") < 0.6 times 10^(- 3)$ on the systematic uncertainty (Lv2.02)#footnote[The requirement allows us to keep a sufficient margin to absorb additional noise penalty due to debiasing as described in @ss:forecasts_delta_r]. Since we
assume no delensing using external data, $sigma_("stat")$ includes uncertainties from the lensing $B$-mode component. Uncertainties due to foreground separation are also in $sigma_("stat")$.


The observer bias (Lv2.10) shall be much smaller than $sigma_("syst")$.


The requirement on the statistical uncertainty (Lv2.01) has six sub-requirements on: (1) CMB sensitivity; (2) dust emission; (3) synchrotron emission; (4) separation of CO lines; (5) the number of observing bands; and (6) the observing frequency range. These are determined through detailed simulation.

We require full-sky surveys (Lv2.03) to obtain the $B$ modes to the lowest multipole of $ell = 2$.


The angular resolution (Lv2.04) shall be better than 80 arcmin fwhm in the lowest frequency band in order to perform precision measurements at $ell thin = thin 200$.


The regular observation phase (Lv2.08) shall be three years, considering the total cost cap and cooling-chain lifetime. The lifetime is determined by the degradation of working gas and moving parts of the mechanical coolers. The degradation is suppressed through our technology development to assure the required lifetime.

The satellite shall be in a Lissajous orbit (Lv2.09) around the Sun-Earth L2 point to avoid the influence of radiation from the Sun, Moon, and Earth (discussed further in @ss:overview_operation).


Requirements on calibration measurements (Lv2.05, Lv2.11) and systematic error budget allocation (Lv2.07) will be explained in @s:payload.


Lv1 and Lv2 requirements are collectively called "mission requirements." In general, several possible designs meet mission requirements, and so we performed implementation trade-off studies to choose the best design. We also considered program-level constraints and assumptions that we used to set Lv2 requirements.


Lv3 integrated system requirements constitute top-level system requirements. An essential distinction between Lv2 and Lv3 is that Lv3 requirements are for the system chosen from trade-off studies, while Lv2 measurement requirements do not assume a specific system in principle. Lv3 requirements include general system requirements not only for mission instruments but also for the bus system,#footnote[Also called the "service module," or "SVM" for short.] ground segments, and ground-support equipment. There are too many Lv3 requirements to list here. The
requirement flow's tree structure is also too detailed to show, since some Lv3 requirements derive from more than one Lv2 requirement; however, we will explain some essential Lv3 requirements in @s:payload.


#figure(
  align(center)[#table(
    columns: 3,
    align: (left,left,left,),
    table.header(table.cell(align: center)[Class], table.cell(align: center)[Symbol], table.cell(align: center)[Description],),
    table.hline(),
    table.cell(align: center, colspan: 3)[Mission requirements],
    table.hline(),
    [Level 1 (Lv1) science requirements], [Lv1.XX (e.g., Lv1.01)], [Top-level quantitative science requirements that are directly connected to the full success of the mission.],
    table.hline(),
    [Level 2 (Lv2) measurement requirements], [Lv2.XX(.YY) (e.g., Lv2.01, Lv2.01.01)], [Measurement requirements to achieve Lv1. No assumption is made on an instrument.],
    table.hline(),
    table.cell(align: center, colspan: 3)[⇊ \ Implementation trade-off studies \ ⇊],
    table.hline(),
    table.cell(align: center, colspan: 3)[System requirements],
    table.hline(),
    [Level 3 (Lv3) integrated system requirements], [Lv3.XX(.YY) (e.g., Lv3.01, Lv3.01.01)], [Top-level implementation requirements for a chosen instrument to achieve Lv2. Between Lv2 and Lv3 are tradeoff studies for instrument selection.],
    table.hline(),
    [Level 4 (Lv4) instrument requirements], [Lv4.XX(.YY) (e.g., Lv4.01, Lv4.01.01)], [Instrument requirements to achieve Lv3.],
    table.hline(),
    [Level 5 (Lv5) unit requirements], [Lv5.XX(.YY) (e.g., Lv5.01, Lv5.01.01)], [Requirements on units composing each instrument to achieve Lv4.],
    table.hline(),
  )]
  , caption: [Definitions of five requirement levels used in LiteBIRD's requirements flow-down. We split the requirements into five levels, from the top-level science requirements (Lv1) to (instrumental) unit requirements (Lv5). Each level is allowed to have a sub-structure; for example, a Level~2 requirement Lv2.01 has six sub-requirements (Lv2.01.01, Lv2.01.02, ...).]
  , kind: table
  ) <tab:reqflow>



== Launch Vehicle
<ss:overview_launch_vehicle>


#emph[LiteBIRD] will be launched on an H3~#cite(<JAXA_H3>), Japan's new flagship rocket. It will achieve greater flexibility, reliability, and performance at a lower cost than the currently used H-IIA rocket. The H3 rocket is under development through its prime contractor, Mitsubishi Heavy Industries, with a maiden flight scheduled in 2022. The first stage of the H3 rocket will adopt the newly-developed liquid engine, LE-9, which achieves a thrust 1.4 times larger than the LE-7A engine currently in use. Its second-stage engine, LE-5B-3, and the solid
rocket booster, SRB-3, will also be improved. The launch capability of the H3 rocket to a geostationary transfer orbit will be the highest ever among JAXA's launch vehicles, exceeding that of the existing H-IIA and H-IIB launch vehicles. The launch facility at Tanegashima Space Center will also be upgraded following the development of H3.


The design of the H3 rocket allows for several different configurations. The rocket type is defined by the combination of the number of first-stage engines (2 or 3), the number of solid rocket boosters (0, 2, or 4), and the length of the fairing (short or long). These setups make it possible to cope with various payload sizes and orbits. Considering the size, weight, and orbit of #emph[LiteBIRD], we plan to adopt the H3-22L configuration, which means two first-stage engines, two boosters, and the long fairing. The estimated launch capability with this
configuration is larger than 3.5 t. We thus set a provisional requirement on the total weight of #emph[LiteBIRD] as $< thin 3.5$ t. This requirement may be updated after the first flight of the H3 rocket.


In most cases, the launch environment of H3 is expected to be similar or more moderate than that of H-IIA. Details of the launch environment may depend on the rocket configuration, especially on the number of solid rocket boosters, the satellite mass, and the flight path. We conservatively assume the launch environment of H-IIA in general for the design of #emph[LiteBIRD]. However, when the launch environment is critical in the design, such as for the mechanical requirement on the fundamental frequency of the satellite, we adopt requirements based on the
current best estimation of the performance of H3.


== Spacecraft Overview
<ss:overview_spacecraft>


// [figvision-cn] imgs/satellite_overview2.png
// 该图包含两个并列的LiteBIRD卫星三维结构示意图，左侧为整
// 体侧视图，右侧为载荷舱内部透视特写。 左侧子图展示卫星
// 的整体构型与外部组件布局。图像主体由后部的灰色大型圆柱
// 体、中部的黄色六边形柱状结构以及前端的深蓝色展开板组成。
// 最左后方是一个巨大的灰色多层圆筒状物体，标注为“Sun
// shield”（遮阳罩）。紧挨着遮阳罩的是黄色的六边形柱体，
// 引线指向其侧面并标注为“Bus system (or Service Module,
// SVM)”（总线系统或称服务模块），该模块在图中呈现为分段
// 结构，包含白色、粉色和黄色的部分。从黄色模块的前端向两
// 侧水平伸出两块巨大的深蓝色矩形板，标注为“Solar panels”
// （太阳能电池板）。在黄色模块的底部前端，伸出一个小型的
// 碟形天线，标注为“High-gain antenna (for data
// transmission)”（高增益天线，用于数据传输）。图像左上角
// 有一个独立的文本框，列出了卫星的关键参数：Mass: 2.6 t
// （质量：2.6吨）、Power: 3.0 kW（功率：3.0千瓦）、Data:
// 17.9 GB/day（数据量：17.9 GB/天）。 右侧子图为载荷舱（
// Payload module）的局部放大透视图，展示了内部望远镜的排
// 列方式。图像中心是一个灰色的八边形金属腔体结构，其外壁
// 上方标注有“V-grooves (for radiative cooling)”（V型槽，
// 用于辐射冷却）。腔体内部安装了三个圆柱形的望远镜设备，
// 通过红色引线分别标注为“LFT”、“HFT”和“MFT”。其中，LFT位
// 于左侧，HFT位于中间偏右，MFT位于右侧。图像右上角提供了
// 这些缩写的定义：LFT代表low frequency telescope（低频望
// 远镜），MFT代表medium frequency telescope（中频望远镜），
// HFT代表high frequency telescope（高频望远镜）。在载荷
// 舱下方的连接处，有一条尺寸线标注了直径为“4.4m”。在右下
// 角的深蓝色面板上，有一个小型的方形传感器，红色引线指向
// 它并标注为“Star tracker”（星敏感器）。整个载荷舱模块被
// 一个大括号括起并标注为“Payload module”。
#figure(placement: top, image("imgs/satellite_overview2.png", width: 100.0%),
  caption: [
    Conceptual design of the #emph[LiteBIRD] spacecraft. The Payload Module houses the LFT, the MFT, and the HFT.
  ]
)
<fig:satellite_overview>


The overall structure of the spacecraft for #emph[LiteBIRD] is determined directly from the mission requirements. The axisymmetric shape of the spacecraft is selected for reducing the moment of inertia to make the spin easier. We chose to place the PLM, including the telescopes, at the top of the spacecraft and the solar panels at its bottom, perpendicular to the spin axis. The high-gain antenna should be placed on the bottom side of the satellite, i.e., opposite the mission instruments, to point to the Earth and reduce interference with the telescopes.
Based on these considerations, we show the basic structure of the spacecraft in @fig_spacecraftBlockDaigram.


In this configuration, the whole spacecraft spins, and the possibility of using a slip-ring to rotate only the PLM is #emph[not] adopted. The main reasons for this selection are to handle large heat dissipation in the PLM and to reduce the possibility of a single-point failure. The PLM is equipped with mechanical coolers, which dissipate a fairly large amount of heat. A radiator of sufficient size to dissipate the heat can be equipped only in the SVM and it is not easy to transfer heat from the spinning PLM through the slip-ring to a non-spinning SVM.
The slip-ring introduces a single point whose failure would be critical for the mission. Furthermore, a slip-ring might produce micro-vibration and could increase the detector noise significantly. For these reasons, we decided to rotate the whole spacecraft and not to adopt the slip-ring.


The spacecraft has a thrust tube at its center, which transfers the PLM launch load to the rocket. We will install the fuel tank inside the thrust tube to utilize the inner space effectively. The insides of the side panels are used to mount various electric components of both the SVM and PLM. PLM components are preferentially placed on the upper parts of the side panels, whereas SVM components are on the lower parts of the side panels. The outer sides of the upper parts of the side panels are used to mount radiators, which radiate the heat dissipated in
the PLM, such as from the mechanical coolers and electronics boxes.


// [figvision-cn] imgs/spacecraftBlockDiagram2.png
// 这是一张LiteBIRD航天器的系统框图，展示了各子系统之间的
// 连接关系。图中实线矩形框代表由多种设备组成的子系统，虚
// 线矩形框代表电子设备，带点状填充的矩形框代表有效载荷模
// 块。连接线和箭头仅表示信号或能量流向，非实际物理布线。
// (a) 通信系统（Communication System）：位于左上角，为实
// 线矩形框。其左侧连接两个蓝色喇叭状天线图标，标注“
// Antennas”，分别指向上下方向，表示双向通信。该模块与中
// 央的卫星管理单元（Satellite Management Unit）之间以双
// 向箭头连接，表示数据双向传输。 (b) 加热器控制器（
// Heater controller）：位于通信系统下方，为实线矩形框。
// 其左侧有一条横线连接至标注“Heaters”的文字，表示控制加
// 热元件。该模块与卫星管理单元之间以双向箭头连接，表明温
// 度控制指令与状态反馈交互。 (c) 太阳能电池板（Solar
// panels）：位于左下角，为一个六边形网格图标，象征光伏阵
// 列。它通过粗黑线连接到右侧的电源控制单元（Power
// Control Unit），表示电能输入。 (d) 电池（Battery）：位
// 于电源控制单元正下方，为虚线矩形框，通过垂直粗黑线与电
// 源控制单元相连，表示储能装置。 (e) 电源控制单元（Power
// Control Unit）：位于中部偏左，为实线矩形框。接收来自太
// 阳能电池板的输入，并向下连接电池；向右通过粗黑线连接至
// 电源分配单元（Power Distribution Unit）。 (f) 电源分配
// 单元（Power Distribution Unit）：位于中心位置，为实线
// 矩形框。从左侧接收电源控制单元的电力，向上连接至卫星管
// 理单元，向右连接至姿态轨道控制系统（Attitude Orbit
// Control System）。此外，该单元底部引出两条粗黑线，分别
// 标注“PLM”和“SVM”，指向下方未命名的接口或负载。 (g) 卫
// 星管理单元（Satellite Management Unit）：位于顶部中央，
// 为最大实线矩形框，是整个系统的中枢。它与以下模块有连接：
// 向左连接通信系统（双向箭头） 向下连接电源分配单元（单
// 向箭头向下） 向右连接数据记录器（Data Recorder，虚线框，
// 双向箭头） 向右连接有效载荷模块（Payload module，点状
// 填充框，双向箭头） 向下连接姿态轨道控制系统（单向箭头
// 向下） (h) 数据记录器（Data Recorder）：位于卫星管理单
// 元右侧，为虚线矩形框，与其双向连接，用于存储遥测与科学
// 数据。 (i) 有效载荷模块（Payload module）：位于右上角，
// 为点状填充矩形框，与卫星管理单元双向连接，代表科学探测
// 仪器部分。 (j) 姿态轨道控制系统（Attitude Orbit
// Control System）：位于右下角区域，为实线矩形框。接收来
// 自电源分配单元的供电，并向右连接反作用轮控制系统（
// Reaction Control System，实线框）。同时，该系统接收多
// 个传感器的输入： 惯性参考单元（Inertia Reference Unit，
// 虚线框）→ 单向箭头向上 反作用轮（Reaction Wheel，虚线
// 框）→ 单向箭头向上 星敏感器（Star Tracker，虚线框）→
// 单向箭头向上 太阳传感器（Sun Sensor，虚线框）→ 单向箭
// 头向上 (k) 反作用轮控制系统（Reaction Control System）：
// 位于最右侧，为实线矩形框，仅作为姿态轨道控制系统的输出
// 执行机构，无其他输入输出标注。 (l) 所有传感器及辅助单
// 元均为虚线框，包括：惯性参考单元、反作用轮、星敏感器、
// 太阳传感器、电池、数据记录器，均表示独立电子设备而非复
// 合子系统。 (m) 图中所有连接线均为直线或直角折线，箭头
// 明确指示信息流或能量流方向。无比例尺、无坐标轴、无数值
// 刻度，纯拓扑结构图。 (n) 整体布局呈树状分层：顶层为管
// 理与载荷层，中层为动力与控制核心，底层为传感与执行单元。
// 所有文字标签使用英文，字体统一，清晰可读。 (o) 结论性
// 趋势：该框图揭示了LiteBIRD航天器的高度模块化设计，其中
// 卫星管理单元为核心枢纽，协调通信、能源、姿态控制与科学
// 载荷；姿态控制系统依赖多源传感器融合实现高精度指向；能
// 源系统采用太阳能+蓄电池冗余配置；所有关键功能模块均有
// 明确接口定义，便于工程集成与故障隔离。
#figure(placement: top, [#block[
  #box(image("imgs/spacecraftBlockDiagram2.png", width: 100.0%))
  ]],
  caption: [
    Block diagram of the spacecraft for #emph[LiteBIRD]. Boxes with broken lines represent electric equipment, while those with solid lines are subsystems composed of multiple equipment types. Lines and arrows connecting boxes are only representative.
  ]
)
<fig_spacecraftBlockDaigram>


We show the block diagram of the spacecraft in @fig_spacecraftBlockDaigram. The #emph[LiteBIRD] spacecraft uses a typical satellite configuration. Observation of the entire sky is conducted through the scan strategy that is detailed in Sect.~#ref(<ss:forecasts_imo>, supplement: none) The slow spin rate of 0.05 rpm makes it possible to adopt three-axis attitude control that satisfies the #emph[LiteBIRD] attitude accuracy requirements, even if the spacecraft spins. The spacecraft will have a total weight of 2.6 t, including the fuel of approximately
400 kg, and a total height of 5.3 m. Thus the current weight has a large margin compared to the rocket's capability. We estimate the total power of the spacecraft to be 3.0 kW. The downlink rate will be 10 Mbps in X-band and will transfer a total of 17.9 GB of scientific data every day. All these parameters are subject to change as the conceptual design of the satellite continues to be developed.


== Service Module
<ss:overview_svm>


The of #emph[LiteBIRD] includes an aocs, thermal control system, communication system, data handling system, power system, and other subsystems. The SVM of #emph[LiteBIRD] utilizes existing technology as much as possible to reduce the development cost and risks. In what follows, we briefly describe some characteristics of the SVM.


#emph[LiteBIRD] is a zero-momentum, 3-axis stabilized spacecraft designed to realize the required pattern of an all-sky survey, i.e., the combination of spin and precession. mws are used to control the attitude of the spacecraft, and the rcs is used to unload the MWs and to control the orbit. Because the spacecraft is operated with zero momentum, relatively large MWs are required to cancel the angular momentum due to the spin. The MWs also cancel the spin-axis component of the angular momentum due to the polarization modulators. Other wheels are used to
control the precession of the spacecraft. The spacecraft receives a small amount of external torque even at L2, mostly from solar radiation. This causes a steady increase or decrease of the rotational frequencies of the MWs, and thus the RCS is used to unload the MWs regularly. The RCS also provides the required $Delta V$ for the initial correction of the orbit and for the orbit insertion at L2. In addition, we use the RCS once every few months to correct orbit errors, since L2 is a gravitational saddle point and any orbit around it is intrinsically
unstable.


The aocs uses stts and irus to determine the spacecraft's attitude because a good attitude solution is required for #emph[LiteBIRD]. The spin rate of 0.05 rpm corresponds to 0.3 deg $sec^(- 1)$. This spin speed is easily handled by the currently available STTs and the degradation of the attitude solution is negligible. The situation is the same for the currently available IRUs. We expect that the STTs can track stars continuously, but the IRUs will be used to interpolate the attitude in case the STTs temporarily fail to track stars.


A thermal control system keeps the temperature of the on-board components in the required range. This is not easy when some of the components have large heat dissipation or require tight temperature stability. Components with large heat dissipation are the mechanical coolers, their drivers, and the signal processing units. Adiabatic demagnetization refrigerator controllers and squid controller units require tight temperature stability. A total heat dissipation of the payload module is about 1.4 kW. Because there is no room in the payload module for
sufficient radiators for this amount of heat dissipation, radiators are placed on the upper parts of the side panels of the spacecraft. The total area of the radiators may be estimated to be approximately 10 $m^2$. Heat pipes may be used to transfer heat from the components to the radiators. When accurate temperature control is required, heaters are used in combination with the radiators.


#emph[LiteBIRD] uses X-band for telemetry and command (and ranging), and also for the downlink of the mission data. The main reason to use X-band for telemetry and command is that the primary great supports only X-band, not S-band, for uplink. We will also use the 34-m antenna at usc as a secondary station. Because GREAT is the only deep space station in Japan, many interplanetary satellites will use the station. The secondary station is useful when GREAT is unavailable due to tracking other satellites. However, the USC 34-m antenna is smaller than GREAT
(54-m antenna), and so the downlink rate at USC 34m will be only 1/3 of that of GREAT. The required downlink rate for the mission data, 10 Mbps, will be achieved only with GREAT. To achieve this rate, we will use a parabolic antenna with a diameter of 0.5 m mounted on a 2-dimensional gimbal with 20 W of output power. The total amount of mission data is estimated to be 17.9 GB $"day"^(- 1)$. This means that approximately 4.5 hours are needed for the downlink of the mission data every day.


The power system and data-handling system of #emph[LiteBIRD] use the heritage of past JAXA science missions, such as ASTRO-H, as much as possible. Thus we adopt Space Wire for the on-board data-handling system. This makes the interface checks of the electronic components easier. We adopt a 50 V unregulated bus for the power system. Because of the scan strategy, the saps receive solar radiation at an incident angle of $45^compose$. This may reduce the efficiency of the SAPs by $1 \/ sqrt(2)$, but we selected fixed panels to make the system simple. We
choose the saps to be close to disk-shaped to avoid diffraction of microwaves from the Sun interfering with the telescopes.


== Operation Concepts
<ss:overview_operation>


=== Basic Principles of Operation
<basic-principles-of-operation>
Because #emph[LiteBIRD] needs to observe the whole sky as much as possible, we adopt the following principles of operation: (1) #emph[LiteBIRD] does not make real-time observations or too observations, but continuously makes an all-sky survey; (2) mission data will be downlinked to the primary tracking station, GREAT, once a day for a duration of about 4.5 hours; (3) observations may be interrupted during the unloading of the MWs and orbit-keeping maneuvers; and (4) precession of the spacecraft may be stopped and observations may be interrupted in the
case of an emergency in the SVM, such as due to a hardware failure.


In what follows, we describe the outline of mission operation for each operations phase.


=== Outline of Operation
<outline-of-operation>
LiteBIRD will be launched from the Tanegashima Space Center with the H3 rocket. It will be directly inserted into an orbit that approaches the L2 point. Soon after separation from the rocket, the spacecraft establishes 3-axis controlled attitude and deploys solar panels to obtain enough power. Then, the spacecraft starts to spin, but not to precess, in order to achieve uniform temperature distribution around the spin axis, which is followed by an initial checkout of the SVM. This initial operations phase and checkout will take approximately a week.


After the initial checkout of the SVM, we will start the health check of the PLM. The launch-locks of the PMUs are released after the health check. The half-wave plate will be supported by the holding mechanism. We then start cooling the telescopes with a combination of radiative cooling and the shield cooler. The JT coolers and the adrs are turned on at the appropriate timing. This initial cooling takes a relatively long time, approximately 70 or 80 days. When the nominal operation temperature of the focal-plane detectors are reached, their function and
performance are checked. Thus most of the cruising phase out to L2, which may last approximately 100 days, will be spent for the initial cooling.


When the spacecraft arrives at L2, an insertion maneuver into the Lissajous orbit will be carried out. Then, test observations are conducted in the all-sky scanning mode, i.e., combination of precession and spin. Various functions and performance of the mission instruments are verified, and operational parameters are optimized.


When the test observations are completed, regular observations begin and continue for 3 years. In this phase, all-sky survey observations are conducted steadily and we obtain as much data as possible. Our scan strategy is described in @ss:forecasts_imo and #ref(<fig:PLM-param-Imo>, supplement: none). As for calibration of the instruments, our baseline plan is to rely on data from the regular observations, not to pause them for special calibration data taking. Our in-flight calibration plan is discussed in more detail in @sss:plm_lft_pmu. After these
regular observations, we may extend the mission, if approved by the jaxa review.


== Data Processing and Analyses
<ss:overview_analysis>


CMB missions typically scan the sky continuously with many detectors at multiple frequencies, measuring temperature and linear polarization, while simultaneously recording the orientation of the telescope. The tod then consist of the time stamp, observation direction determined by satellite attitude monitor, HWP position, thermal and electric monitor for the instruments, and the measured signal for each detector sample. The measured signal includes not just the CMB, but also emission from astrophysical foregrounds, together with other systematic effects, as well as instrumental noise.


#figure(cetz.canvas(length: 0.9cm, {
  import cetz.draw: *

  set-style(stroke: (thickness: 1.1pt), fill: none)

  let box(name, a, b, body) = {
    rect(a, b, name: name)
    content(name, align(center, text(6.8pt, weight: "bold", body)))
  }
  let ell(name, c, r, body) = {
    circle(c, radius: r, name: name)
    content(name, align(center, text(6.8pt, weight: "bold", body)))
  }
  let arrow(..pts) = line(..pts, mark: (end: (symbol: "stealth", fill: black)))

  // main column
  box("pre", (0, 13.95), (4, 14.95), [PRE-PROCESSING])
  box("map", (0, 11.46), (4, 12.46), [MAP-MAKING])
  box("comp", (0, 8.31), (4, 9.36), [COMPONENT SEPARATION])
  box("pow", (0, 5.58), (4, 6.68), [POWER SPECTRUM \ ESTIMATION])
  box("pclean", (0, 3.11), (4, 4.16), [POWER SPECTRUM \ CLEANING])
  box("param", (0, 0.38), (4, 1.43), [PARAMETER ESTIMATION])
  ell("raw", (2, 15.655), (2, 0.555), [RAW \ TIME-ORDERED DATA])
  ell("clean", (2, 13.225), (2, 0.575), [CLEAN \ TIME-ORDERED DATA])
  ell("freq", (2, 10.77), (2, 0.55), [FREQUENCY MAPS])
  ell("CMB", (2, 7.54), (2, 0.57), [CMB MAPS])
  ell("sky", (2, 4.88), (2, 0.55), [SKY SPECTRA])
  ell("cs", (2, 2.38), (2, 0.55), [CMB SPECTRA])
  ell("cosmo", (2, -0.37), (2, 0.6), [COSMOLOGICAL \ PARAMETERS])

  // simulation branch
  box("modeling", (4.47, 15.94), (8.43, 17.03), [MISSION MODELING])
  box("sim", (4.47, 13.73), (8.43, 14.74), [SIMULATION])
  ell("mmodel", (10.93, 15.475), (2.01, 0.585), [MISSION MODEL])
  ell("skymodel", (10.93, 12.945), (2.01, 0.585), [SKY MODEL])
  ell("fg", (6.975, 8.9), (1.975, 0.56), [FOREGROUND MAPS])
  rect((5, 7.06), (8.95, 8.11), name: "astro",
    stroke: (thickness: 1.1pt, dash: "dashed"))
  content("astro", align(center, text(6.8pt, weight: "bold", [ASTROPHYSICS \ STUDIES])))

  // vertical chain
  arrow("raw", "pre")
  arrow("pre", "clean")
  arrow("clean", "map")
  arrow("map", "freq")
  arrow("freq", "comp")
  arrow("comp", "CMB")
  arrow("CMB", "pow")
  arrow("pow", "sky")
  arrow("sky", "pclean")
  arrow("pclean", "cs")
  arrow("cs", "param")
  arrow("param", "cosmo")

  // mission modeling loop
  arrow("raw.north", (2, 16.85), (4.47, 16.85))
  arrow((8.43, 16.85), (10.93, 16.85), "mmodel.north")
  arrow("mmodel.south", ("mmodel.south", "|-", "sim.east"), "sim.east")
  arrow("skymodel.north", (10.93, 13.89), (8.43, 13.89))
  arrow("sim.north", ("sim.north", "|-", "raw.east"), "raw.east")
  arrow((5.47, 13.73), ((5.47, 13.73), "|-", "clean.east"), "clean.east")
  arrow("sim.south", ("sim.south", "|-", "freq.east"), "freq.east")

  // component separation branch
  arrow("comp", "fg")
  arrow("fg", "astro")
  arrow("fg", ("skymodel.south", "|-", "fg"), "skymodel.south")
  arrow("cosmo.east", (11.9, -0.37), (11.9, 12.36))

  // legend
  rect((5.6, 0.96), (10.3, 4.71), fill: rgb("#c9c9c9"), name: "legend")
  content((7.95, 4.0), align(center, text(10pt, weight: "bold", [CMB DATA \ ANALYSIS \ FLOWCHART])))
  circle((7.95, 2.78), radius: (1.95, 0.42), name: "legend-data")
  content("legend-data", align(center, text(6.8pt, weight: "bold", [DATA OBJECT])))
  rect((6.05, 1.31), (9.9, 2.06), name: "legend-step")
  content("legend-step", align(center, text(6.8pt, weight: "bold", [ANALYSIS STEP])))
}),
  caption: [
    Flowchart indicating the sequence of steps leading to the determination of cosmological parameters from mission TOD via several intermediate products that can also be scientifically exploited. Note the iterative nature of the processing.
  ]
)
<fig:DA_Flowchart>


The processing of CMB experimental data can be described as a series of steps that move from the TOD to sky maps at each frequency, which are then separated into different physical components. The statistics of the CMB map are finally compared to the cosmological prediction from theoretical models. These data processing steps, indicated in @fig:DA_Flowchart, reduce the statistical and systematic uncertainties in the data, first reducing the systematic contamination by appropriate mitigation in a given data domain, and then reducing the dimensionality of
the data set by exploiting its redundancies to project onto a lower-dimensional domain.


Systematic mitigations include removing glitches (e.g., from cosmic-ray hits) in the time domain, separating the CMB from the astrophysical foreground components in the map domain, and quantifying contamination from unresolved emission sources in the spectral domain. Throughout the analysis process we also have to account for non-idealities in the instrument, both optical (e.g., from asymmetric and mismatched beams, including side-lobes, differences in the bandpass for each detector) and electronic (e.g., gain drift, non-linearity and crosstalk).


Finally, we need an accurate description of the uncertainties in the products and their correlations. The data volumes we need to amass in order to detect the tiny CMB signals preclude exact analyses, and so we typically use Monte Carlo methods for debiasing and forward propagation of uncertainties. We therefore need to be able to generate and reduce large numbers of very accurate simulated data sets, whose input mission and sky models are themselves informed by our analyses of the satellite data.


With 4508 detectors sampling at 19.1 Hz for 3 years, the #emph[LiteBIRD] mission will gather $8 times 10^12$ detector samples. Manipulating this data volume while capturing all of the correlations in the CMB signals, foregrounds, and instrumental noise and systematics, with sufficient precision to yield reliable, unbiased results, is a computationally challenging task, requiring the use of state-of-the-art high-performance computing systems. Similarly, tracking the provenance of all of the data products, including the myriad data cuts used to check the
robustness of the analysis, requires dedicated databases accessible to all collaboration members. The biggest data challenges for #emph[LiteBIRD] will be removing astrophysical foreground contamination using the sky maps at the 15 observing frequency bands (@ss:forecasts_fg_cleaning), and mitigating systematic effects and precise characterization of their residuals (@ss:forecasts_syst).


= Payload Module of LiteBIRD
<s:payload>


== Overview
<ss:plm_overview>


// [figvision-cn] imgs/PLM.png
// 子图类型：三维计算机辅助设计（CAD）示意图，展示了有效
// 载荷模块的等轴测视图。 整体布局与结构：图像主体为一个
// 巨大的多面体容器结构，占据了画面的绝大部分。该容器外部
// 呈深灰色至黑色，由多个平面拼接而成，呈现出类似截顶锥体
// 的几何形状。容器的底部边缘均匀分布着一圈银灰色的支撑腿，
// 这些支撑腿向外倾斜延伸，末端带有圆盘状脚垫，用于将模块
// 固定在底座上。 内部组件与颜色编码： 前景中央位置：有一
// 个圆形的望远镜组件。其最前端是一个深蓝色的圆形平面，代
// 表主镜或光学窗口。该蓝色圆盘被一个复杂的银色金属环形机
// 械结构包围，环上可见螺栓和连接件细节。该组件安装在一个
// 浅灰色的六边形基座上。根据参考信息，这是低频交叉式
// Dragone望远镜的4.8开尔文（K）封闭舱。 后景右上方：并排
// 排列着两个细长的圆柱形管道结构，向后上方倾斜延伸。这两
// 个管道的顶部是米黄色的喇叭口状开口。向下过渡为亮蓝色的
// 圆筒段，再向下则是淡紫色或白色的圆筒段，最后连接到模块
// 内部。根据参考信息，这两个管道是中频和高频同轴望远镜的
// 4.8 K低温管。 背景/侧壁：在望远镜组件的后方和侧面，可
// 以看到深灰色的内壁结构，构成了所谓的“V型槽”（V-grooves）。
// 这些结构作为被动冷却器，能够将温度降低至30 K。 文字标
// 注：图中没有任何坐标轴、刻度线、数值标签或图例文字。
// 结论：该图直观地展示了科学仪器内部的空间排布，突出了不
// 同频率望远镜（前景的单一大口径与后景的两个细长管）及其
// 对应的低温环境（通过不同颜色的部件区分），以及外围的被
// 动冷却结构。
#figure(placement: top, image("imgs/PLM.png", width: 70.0%),
  caption: [
    Payload module overview showing the surrounding V-grooves acting as passive coolers up to 30 K, with the 4.8-K enclosure of the low-frequency crossed-Dragone telescope in the front, and the two 4.8-K tubes of the mid- and high-frequency on-axis telescopes in the back.
  ]
)
<fig:plm>


The #emph[LiteBIRD] PLM consists of three telescopes -- at low, medium, and high frequencies -- with their respective cryo-structure and focal planes cooled down to 0.1 K. The PLM also includes the global cooling chain from 300 K to 4.8 K, and room-temperature elements, such as drivers and warm readout electronics of the detectors. Requirements for the PLM have been derived from the top-level requirement of achieving a tensor-to-scalar ratio error of $delta r < 0.001$ (see @ss:overview_mission). @tbl:plm:sensitivities gives information on the frequency
bands, beam sizes, and NETs for each of the 15 frequency channels. A discussion of the NET calculations is given in Sect.~#ref(<ss:forecasts_imo>, supplement: none)


The #emph[LiteBIRD] requirements imply technical challenges for the PLM, in terms of sensitivity, optical properties, stability, or even compactness, over a wide range of frequencies, from 34 to 448 GHz. In order to achieve such a challenging set of scientific requirements, an important feature of #emph[LiteBIRD] is its observing strategy, focusing on the largest scales over the sky to maximize the signal expected from the reionization and recombination peaks of the $B$-mode power spectrum, which requires an unprecedented sensitivity over multipoles
$2 lt.eq ell lt.eq 200$. This demands only reasonably low resolution for the telescopes ($< 80$ arcmin), but associated with a strong control of the systematics in order to minimize the $1 \/ f$ noise.


#figure(
  align(center)[#show table: set text(size: 9pt)
  #table(
    columns: 9,
    align: center,
    stroke: 0.4pt,
    table.header(
      [Tel.], [ID], [$nu$], [$delta nu$ ($delta nu\/nu$)], [Beam size], [Det. pixel], [No. of], [NET detector], [NET array],
      [], [], [\[GHz\]], [\[GHz\]], [\[arcmin\]], [size \[mm\]], [bolo], [$mu$K $sqrt(s)$], [$mu$K $sqrt(s)$],
    ),
    [LFT], [1], [40], [12 (0.30)], [70.5], [32], [48], [114.63], [18.50],
    [LFT], [2], [50], [15 (0.30)], [58.5], [32], [24], [72.48], [16.54],
    [LFT], [3], [60], [14 (0.23)], [51.1], [32], [48], [65.28], [10.54],
    [LFT], [4], [68], [16 (0.23)], [41.6], [16], [144], [105.64], [9.84],
    [], [], [], [16 (0.23)], [47.1], [32], [24], [68.81], [15.70],
    [], [], [], [], [], [], [], [], [8.34 (comb.)],
    [LFT], [5], [78], [18 (0.23)], [36.9], [16], [144], [82.51], [7.69],
    [], [], [], [], [43.8], [32], [48], [58.61], [9.46],
    [], [], [], [], [], [], [], [], [5.97 (comb.)],
    [LFT], [6], [89], [20 (0.23)], [33.0], [16], [144], [65.18], [6.07],
    [], [], [], [], [41.5], [32], [24], [62.33], [14.22],
    [], [], [], [], [], [], [], [], [5.58 (comb.)],
    [LFT], [7], [100], [23 (0.23)], [30.2], [16], [144], [54.88], [5.11],
    [MFT], [], [], [], [37.8], [11.6], [366], [71.70], [4.19],
    [], [], [], [], [], [], [], [], [3.24 (comb.)],
    [LFT], [8], [119], [36 (0.30)], [26.3], [16], [144], [40.78], [3.80],
    [MFT], [], [], [], [33.6], [11.6], [488], [55.65], [2.82],
    [], [], [], [], [], [], [], [], [2.26 (comb.)],
    [LFT], [9], [140], [42 (0.30)], [23.7], [16], [144], [38.44], [3.58],
    [MFT], [], [], [], [30.8], [11.6], [366], [54.00], [3.16],
    [], [], [], [], [], [], [], [], [2.37 (comb.)],
    [MFT], [10], [166], [50 (0.30)], [28.9], [11.6], [488], [54.37], [2.75],
    [MFT], [11], [195], [59 (0.30)], [28.0], [11.6], [366], [59.61], [3.48],
    [HFT], [], [], [], [28.6], [6.6], [254], [73.96], [5.19],
    [], [], [], [], [], [], [], [], [2.89 (comb.)],
    [HFT], [12], [235], [71 (0.30)], [24.7], [6.6], [254], [76.06], [5.34],
    [HFT], [13], [280], [84 (0.30)], [22.5], [6.6], [254], [97.26], [6.82],
    [HFT], [14], [337], [101 (0.30)], [20.9], [6.6], [254], [154.64], [10.85],
    [HFT], [15], [402], [92 (0.23)], [17.9], [5.7], [338], [385.69], [23.45],
    [Tot.], [], [], [], [], [], [4508], [], [],
  )]
  , caption: [LiteBIRD sensitivities. We show the values related to the sensitivity in 15 frequency bands. From left to right the columns are: the telescope covering the band; the band identification number; the band center frequency in GHz; the bandwidth in GHz and its ratio; the main beam FWHM in arcmin; the detector pixel size in mm; the number of bolometers used; the NET value of a single detector in $mu$K $sqrt(s)$; and the NET value of the detector array in $mu$K $sqrt(s)$. ]
  , kind: table
  ) <tbl:plm:sensitivities>



In this context, a critical technical choice made for #emph[LiteBIRD] was to use as the first optical element a continuously-rotating hwp. This allows us to distinguish between the instrumental polarized signal and the sky signal, which is modulated at $4 f_("HWP")$. While, without the HWP, data from a pair of detectors mutually orthogonal in their polarization orientations are usually combined, causing leakage from temperature to polarization if there are any differences in the beams, gains, or band-passes between the two detectors; this can be removed
through the use of HWPs that enable us to measure the polarization using a single detector. Lastly, the presence of the continuously-rotating HWP performs an effective suppression of the $1 \/ f$ noise. A detailed trade-off analysis, including the polarization effects induced by the HWP itself, has been carried out between the two cases, i.e., with and without the HWP, demonstrating that the performance without HWP are expected to have potential large systematic effects compared with those with HWP, as described in @sss:syst_intro. Hence, in order to
guarantee appropriate thermal performance in terms of stability and minimal heat load, the three telescopes will be equipped with pmus continuously rotating at a few Hz around a stable temperature below 20 K, using a magnetic levitating mechanism with superconducting bearing, as described in more detail in Sects.~#ref(<sss:plm_lft_pmu>, supplement: none) and #ref(<sss:plm_mhft_subsystems>, supplement: none)


The distribution and the number of bands over the wide range of frequencies, from 34 GHz to 448 GHz, have been optimized to deal with the following constraints: the spectral resolution has to ensure the appropriate characterization of the expected complexity of the spectral energy distribution of the synchrotron and dust Galactic foregrounds, leading to 15 broad and partially overlapping bands; the limited frequency range of HWP materials (sapphire and metal-mesh) and associated anti-reflection coating required us to split into three telescopes; the
spectral mapping of the CO lines has to be optimized by rejecting such molecular lines from some of the bands and including them in others (notice that notch-filters have not been included, since it has been demonstrated that temperature-to-polarization leakage from CO lines is highly reduced by the rotating HWP); and finally an overlap between bands and instruments had to be foreseen to mitigate systematic effects. We ended up with the following distribution: a reflective telescope at low frequency (see @ss:plm_lft), the LFT (34--161 GHz), and two
refractive telescopes at middle and high frequencies (see @ss:plm_mhft), the MFT (89--225 GHz) and HFT (166--448 GHz), as illustrated in @fig:plm. The MFT and HFT telescopes are mounted on the same mechanical structure, and point in the opposite direction compared to the LFT, but cover the same circle over the sky when spinning.


The focal planes of the three telescopes with large field of view ($18^compose times 9^compose$ for LFT, and $28^compose$ diameter for MFT and HFT) are populated with multichroic polarized TES detectors (one to three bands per pixel). This multichroic technology allows for a very compact design with sufficient flexibility on the optimization of the sensitivity per band that is needed to improve the performance of the component-separation techniques. Two detector technologies have been used, lenslet-coupled detectors for the LFT and MFT, and horn-coupled
detectors for the HFT, for a total of 4508 detectors cooled down to 100 mK, as detailed in @ss:plm_detection. The readout electronics takes advantage of the frequency multiplexing scheme to accommodate this large set of detectors without loss of information and minimal power dissipation on the focal planes.


The temperature stability of the instruments is another crucial point for CMB $B$-mode polarization probes because of the following aspects: the temperature fluctuation of the optical components contributes to noise stability and $1 \/ f$ noise; and temperature variation of the mechanical structures has a direct impact on pointing stability. Hence the three #emph[LiteBIRD] telescopes are fully cooled down to 4.8 K, minimizing the heat load on the focal planes. The proposed 300-K to 4.8-K cryogenic chain for #emph[LiteBIRD] is based on the architecture
developed as part of the #emph[SPICA]-SAFARI mission. It combines radiative cooling (V-grooves) down to 30 K combined with mechanical cryo-coolers to provide cooling to temperatures down to about 4.8 K. In its current definition, a 15-K pulse-tube cooler associated with three V-groove radiators, respectively at 160 K, 90 K, and 30 K, intercept part of the thermal loads. Then, one helium JT loop (4-K JT, 4He), pre-cooled by two 2-stage Stirling coolers (100 K / 20 K). All telescopes have intermediate cold stages at 1.75 K and 0.35 K between their
mechanical enclosure at 4.8 K and the detectors at 0.1 K. The 1.75-K cooler is based on 2-K Joule Thompson cooler, to provide a continuous cooling at 1.75 K. The Sub-kelvin cooler is made of two adr stages in series to provide stable and continuous cooling at 0.35 K, combined with two other ADR stages in parallel for the 0.1-K stage. Again the design of this cryo-chain has been optimized to ensure maximum stability of the temperature of the focal planes and the optical elements of the telescopes.


In the following sections, we provide more details on the instrumental setup, following the natural path of the scientific signal, i.e., starting with the optical and mechanical descriptions of the LFT (@ss:plm_lft) and MFT and HFT (@ss:plm_mhft) telescopes. Since the detection chain of the three telescopes follows a common architecture, it is globally described in @ss:plm_detection for LFT, MFT, and HFT, while the global electrical architecture of the PLM is detailed in @ss:plm_electronics. A description of the whole cooling chain, from 300 K down to
100 mK is provided in @ss:plm_cryo. Finally the ground and in-flight calibration plan of the whole instrumental setup is discussed in @ss:plm_calib.


== Low-Frequency Telescope
<ss:plm_lft>


=== Overview
<overview>


With an aperture diameter of 400 mm and an angular resolution ranging from 24 to 71 arcminutes, LFT consists of nine broad frequency bands spanning from 34 to 161 GHz, in order to cover the spectral domains of both CMB and synchrotron radiation emission. It is operated at a cryogenic temperature of 4.8 K to reduce the optical loading, and surrounded by radiators called V-grooves, acting as passive coolers. The LFT optical design follows a crossed-Dragone configuration, with an antenna made of aluminum. As the first optical component, a polarization
modulator unit, consisting of a continuously rotating transmissive half-wave plate, is mounted in front of an aperture stop, allowing us to minimize straylight contamination. The LFT focal plane is based on multi-chroic TES detectors cooled down to 100 mK, as described in @sss:detection_fpu. A frame structure at 5 K supports all components: the PMU; focal plane; primary and secondary reflectors; and absorbers. An overview of the LFT is presented in @fig:LFT-overview, introducing the various components listed above.


// [figvision-cn] imgs/LFT_overview.png
// 该图为低频望远镜（LFT）的三维结构示意图，采用等轴测视
// 角展示望远镜内部组件布局。图中未显示中频和高频望远镜及
// 侧板以保持清晰。图像中心为望远镜主光学系统：底部是一个
// 大型抛物面反射镜，标注为“primary”（主镜），其表面呈深
// 灰色网格状纹理；主镜上方悬挂一个较小的椭圆形反射镜，标
// 注为“secondary”（副镜），通过支撑结构连接至中央框架。
// 在副镜后方、靠近焦平面位置，有一个标有“focal plane”（
// 焦平面）的区域，内含多个彩色矩形模块（红、黄、蓝等色块），
// 代表探测器阵列。焦平面上方安装一个圆柱形装置，标注为“
// PMU”，可能为前置放大单元或控制模块。整个光学系统被一个
// 金属框架包围，标注为“frame”。框架顶部前方设有一个半透
// 明罩状结构，标注为“front hood”（前遮光罩）。望远镜外围
// 环绕多层V型散热槽结构，标注为“V-grooves”，并分别用引线
// 指向不同层级，标注温度：“30K”、“80K”、“160K”，表示这些
// 散热结构对应的热控温区。所有标签均使用黑色无衬线字体，
// 蓝色箭头从文字指向对应部件。整体布局呈现由外向内、由高
// 低温区向核心光学系统的层级结构，传达出望远镜通过多级热
// 屏蔽与精密光学设计实现低温探测的功能架构。
#figure([#block[
  #box(image("imgs/LFT_overview.png", width: 120mm))
  ]],
  caption: [
    Overview of the Low-Frequency Telescope (LFT). The Mid- and High-Frequency telescopes and side panels are not shown for clarity.
  ]
)
<fig:LFT-overview>


Performance requirements of the LFT are described in @Sekimoto2020 and a design flow is shown in @fig:wide-FoV-design-flow. Starting from an optical design satisfying the instrument requirements, we proceeded with physical optics simulations and by completing the structural design to correctly match the interface requirements. A scaled version of LFT has allowed us to validate the models based on the scaled model measurements~#cite(<Takakura2019IEEE>)


// [figvision-cn] imgs/wide_fov_design_flow.png
// 该图展示LFT（大型自由望远镜）的设计流程，由多个模块通
// 过蓝色箭头连接，表示设计步骤的顺序或并行关系。整体布局
// 从左至右、从上到下展开，包含六个主要子区域：仪器需求、
// 光学设计、物理光学仿真、结构设计与接口要求、验证计划、
// 缩比模型测量。 左上角模块：“LFT requirements” 类型：文
// 本框示意图。 内容：一个圆角矩形框内写有“LFT
// requirements”，左侧有一黄色粗箭头指向该框，右侧有一蓝
// 色粗箭头引出，指向“Optical design”模块。下方有一双向蓝
// 色箭头垂直连接至“Verification plan”模块。 含义：代表设
// 计的起点——仪器性能指标与系统需求定义阶段。 中上部模块：
// “Optical design” 类型：光学光路示意图（ray tracing
// diagram）。 坐标轴：无显式坐标轴，但标注了关键尺寸。
// 物体与布局： 左侧为入射光束，经“aperture stop”（孔径光
// 阑）后进入系统。 光线传播路径用多色细线表示（红、绿、
// 蓝等），显示不同波长或视场的光线轨迹。 下方为“
// secondary mirror”（次镜），上方为“primary mirror”（主
// 镜），两者呈折叠反射构型。 光线最终汇聚于“focal plane”
// （焦平面）。 标注尺寸：孔径光阑到次镜距离400 mm，次镜
// 到主镜距离640 mm。 底部小字标注软件信息：“zemax 13.0,
// date: 2018-10-15”。 趋势/结论：展示LFT光学系统的几何光
// 路设计，体现其折返式双镜结构及关键机械尺寸。 右上角模
// 块：“Physical optics simulation” 类型：曲线图（
// diffraction pattern plot）。 横坐标：angle [deg]，范围
// 约从-0.5°到+0.5°（根据峰值位置和对称性推断）。 纵坐标：
// intensity (a.u.)，未标具体数值刻度，但可见相对强度分布。
// 曲线： 黑色实线：理论衍射极限点扩散函数（PSF）轮廓。
// 红色填充区域：实际模拟得到的衍射斑能量分布，呈现中央主
// 峰加两侧旁瓣结构。 蓝色填充区域：可能代表另一通道或条
// 件下的响应，位于主峰一侧，强度较低。 绿色虚线：可能是
// 理想高斯拟合或其他参考曲线。 标注文字：标题“Physical
// optics simulation”，图中无其他文字标签。 趋势/结论：展
// 示基于物理光学的衍射仿真结果，表明系统在焦平面的成像质
// 量接近衍射极限，存在轻微像差导致旁瓣不对称。 右中部模
// 块：“e2e simulation” 类型：文本框示意图。 内容：白色圆
// 角矩形框内写有“e2e simulation”，左侧接收来自“Physical
// optics simulation”的蓝色箭头，右侧输出黄色粗箭头指向“
// Interfaces”模块。 含义：端到端系统级仿真环节，整合光学、
// 热控、电子等子系统性能进行综合评估。 右下角模块：“
// Interfaces” 类型：堆叠文本框示意图。 内容：三个垂直排
// 列的白色圆角矩形框，分别标注： “focal plane” “PMU”（
// Payload Management Unit，载荷管理单元） （最上方空白框，
// 可能预留用于其他接口如电源、通信等） 布局：位于整个流
// 程图最右侧，作为最终交付物之一。 含义：列出LFT系统对外
// 部平台的关键接口定义，包括焦面位置、载荷控制单元等。
// 左下角模块：“Verification plan” 类型：实验装置示意图 +
// 显微照片组合。 左半部分：真空腔体内部结构示意图。 外框
// 标注“Vacuum chamber”，温度梯度标注：顶部100K，右侧30K，
// 底部1K。 内部放置“Gonio stage”（测角仪台），其上安装“
// LFT”原型机。 LFT内部绘有多条彩色光线（红、紫、蓝），模
// 拟不同波段入射与反射路径。 比例尺：底部标注“1.6m”，指
// 示整个装置横向尺寸。 蓝色方框圈出LFT核心光学组件区域。
// 右半部分：两张显微照片并列。 上图：蓝色背景上的两个圆
// 形亮斑，中心亮度最高，向外衰减，应为探测器记录的星点图
// 像；旁边标注“Transmitter XYZ Stage”和“Receiver XYθ
// Stage”。 下图：散点图，横坐标“φ / deg”，纵坐标未标单位，
// 数据点呈钟形分布，叠加一条平滑曲线（可能为高斯拟合），
// 反映角度扫描下的信号响应。 含义：展示地面验证方案，包
// 括低温真空环境测试、发射-接收对准机构、以及实测波前或
// 指向精度数据。 中下部模块：“Scaled model measurement”
// 类型：实物照片 + 数据图表组合。 左列：三张实物照片垂直
// 排列。 上：标有“LFT Scaled Model”的机械结构局部特写，
// 可见金属框架与光学元件支架。 中：标有“Hood”的遮光罩部
// 件，安装在XYZ运动平台上。 下：标有“Receiver”的接收端设
// 备，同样置于XYθ运动平台。 右列：一张二维热图（heatmap）。
// X/Y轴均为空间坐标（像素或mm），颜色从深蓝（低值）到亮
// 黄白（高值）映射信号强度。 图中有两个明显的高亮斑点，
// 对应左右两个探测通道或目标源。 旁边附有坐标轴标签“X”、
// “Y”，但未给定量程。 含义：展示缩比模型的硬件实现与初步
// 光学性能测试结果，验证光学对准与成像能力。 中右部模块：
// “Structural design” 类型：三维CAD装配示意图。 物体与布
// 局： 主体为灰色金属框架（frame），支撑整个光学系统。
// 内部倾斜安装“primary reflector”（主反射镜），表面光滑
// 银色。 前方设置“aperture stop”（孔径光阑），限制入射光
// 束口径。 后方安装“front hood”（前遮光罩），防止杂散光
// 进入。 光轴方向用蓝色箭头标示，贯穿整个系统。 关键部件
// 标注：“PMU”（位于顶部）、“focal plane”（位于底部末端）。
// 角度标注：主镜倾角标记为“α₁”。 含义：展示LFT的结构设计
// 方案，强调各部件的空间布局、光轴对齐及热控/屏蔽考虑。
// 所有模块通过蓝色箭头串联，形成闭环或线性流程：从需求→
// 光学设计→物理仿真→结构实现→接口定义，同时并行开展缩比
// 模型测试与验证计划，最终反馈优化初始设计。黄色箭头突出
// 起始输入与最终输出节点。
#figure(placement: top, image("imgs/wide_fov_design_flow.png", width: 100.0%),
  caption: [
    Design flow of LFT. From the instrument requirements, the optical design, physical optics simulations, structural design, interface requirements, a scaled version of LFT, and verification plan are designed and developed either sequentially or in parallel.
  ]
)
<fig:wide-FoV-design-flow>


=== Optical Design
<optical-design>
The challenges of #emph[LiteBIRD] include its wide FoV and broadband capabilities for millimeter-wave polarization measurements, which are derived from the sensitivity requirements. The wide FoV corresponds to a large focal plane area, so that a detector pixel has different spill-over or edge-taper at reflectors depending on the pixel position on the focal plane. Possible paths of straylight increase with a wider FoV. After various trade-off studies of various optical configurations, including a front-fed Dragone ~#cite(<Bernacki2012>), we concluded that
the crossed-Dragone antenna is the best option for LFT, because it has good beam and polarization performance over the required FoV.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (left,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    [Aperture diameter], [400 mm],
    table.hline(stroke: 0.5pt),
    [Field of view], [$18^compose times 9^compose$],
    [Strehl ratio], [$> 0.95$ at 161 GHz],
    [Focal plane telecentricity], [$< 1.0^compose$],
    [F-number, f$\/ N$], [$2.9 < N < 3.1$],
    [PSF flattening], [$< 5$ %],
    [Cross polarization], [$< - 30$ dB],
    [Rotation of polarization angle across FoV], [$< plus.minus 1.5^compose$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Optical specifications of LFT~#cite(<Sekimoto2020>). The psf flattening is defined as $( sigma_("maj") - sigma_("min") ) \/ ( sigma_("maj") + sigma_("min") )$ where $sigma_("maj")$ and $sigma_("min")$ are for the major and minor axes, respectively.]
  , kind: table
  )

<tbl:lft-specification>


The crossed-Dragone antenna of LFT has been designed with anamorphic aspherical surfaces ~#cite(<Kashima:2017yub>) to achieve the specifications listed in @tbl:lft-specification. A ray diagram of LFT is shown in #ref(<fig:lft>, supplement: none), which has an FoV of $18^compose times 9^compose$. The f/3.0 ratio and crossing angle of $90^compose$ between the aperture to primary and the secondary to focus axes have been chosen after an extensive straylight study. While the requirements on far sidelobe knowledge (about $- 56$ dB) is one of the most
challenging requirements, the optical design has been optimized to achieve far-sidelobe levels as low as possible, ideally below the knowledge requirements threshold, in order to be able to mitigate the need of far-sidelobe high-accuracy measurements. Indeed, the expected beam calibration sequence plans to go through room temperature measurements of far sidelobes, cryogenic measurements of near sidelobes, and in-flight calibration of near sidelobes, where we define the near sidelobes to be the region out to $3^compose$ with respect to the main lobe peak
direction, and the remaining part of the beam is defined as the far sidelobes.


==== Optical Components
<optical-components>
An aperture stop at 4.8 K, with an inner diameter of 400 mm, is made of millimeter absorber, TK-RAM #cite(<TK-RAM>) #cite(<Saily2004>) on aluminum plate. This works to create the desired beam shape and to reduce the photon noise for the configuration with an edge taper of about $3$ dB. Primary and secondary reflectors made of aluminum (A6061) have a rectangular shape of $835 thin "mm" times 795 thin "mm"$ and $872 thin "mm" times 739 thin "mm"$, respectively, with serrations to reduce diffraction patterns from the edges of mirrors.


Millimeter absorbers (to reduce reflections) are attached on the inside surface of the 5-K frame, which plays the role of a cavity. TK-RAM, Simons Observatory meta-material microwave absorber @Xu2021, and 3D-printed absorber @Petroff2019 are candidates for such an absorber as described in Section #ref(<sss:plm_mhft_subsystems>, supplement: none) Eccosorb AN72 and HR10 are also candidates, however, they have large tml and cvcm. According to the NASA outgas database ~#cite(<NASAoutgass>), AN72 washed with ethanol shows reasonable TML and CVCM values. A
front hood whose height is 500 mm reduces straylight to the far sidelobes. The aperture shape of the front hood is described in @Takakura2019IEEE.


==== Optical Simulations
<optical-simulations>
Physical optics simulations of LFT with `GRASP10`~#cite(<GRASP10>) are reported in Ref.~@Imada2018SPIE, with the simulated telescope elements including LFT reflectors and the aperture stop. The feed pattern is assumed to be a Gaussian beam, but the real feed pattern may change the antenna pattern on the sky. At this stage, the HWP, which may generate additional sidelobes, is not taken into account for the physical optics simulations.


// [figvision-cn] imgs/lft_ray_trace.png
// 这是一幅展示LFT（线性聚焦望远镜）光学系统的三维示意图，
// 包含光路追踪和结构布局。图像中心设有一个三维直角坐标系，
// 原点位于黑色实心圆点处，Z轴沿主光轴向右上方延伸，Y轴垂
// 直向下偏右延伸，X轴未明确标出但隐含为水平方向。 在坐标
// 系右侧，是一个由多个透明淡紫色长方体块组成的透镜组或反
// 射镜支撑结构，呈阶梯状排列，表面具有轻微反光效果，表示
// 其为光学元件载体。从该结构左侧射入一束平行光线，分为红、
// 绿、蓝三种颜色，代表不同波长或入射角度的光束。这些光线
// 进入系统后发生折射或反射，在左侧形成一个大型弧形反射镜
// 阵列——该阵列由上下两块对称的弯曲镜面构成，边缘带有橙色
// 边框，镜面内侧密集分布着交叉的红、绿、蓝三色细线，表示
// 光线在镜面上的多次反射路径。 所有光线最终汇聚于左下角
// 一个小型矩形探测器平面，该平面以半透明白色显示，底部有
// 一条红色基线标记焦面位置。探测器平面上可见三条清晰的彩
// 色光斑轨迹：蓝色光斑最靠下，绿色居中，红色最靠上，表明
// 系统对不同波长存在色散效应。 图中标注文字包括：“input
// aperture”指向入射光口区域，“y”、“z”分别标注对应坐标轴
// 方向。无比例尺、无色标图例、无曲线拟合或数据点，纯几何
// 光路示意。整体传达结论为：LFT结构通过多级反射实现宽视
// 场聚焦，且不同波长光线在焦面上呈现空间分离，体现其光谱
// 分辨能力；同时展示了输入孔径到探测器的完整光程与成像几
// 何关系。
// [figvision-cn] imgs/lft_ray_trace.png
// 这是一幅展示LFT（线性聚焦望远镜）光学系统的三维示意图，
// 包含光路追踪和结构布局。图像中心设有一个三维直角坐标系，
// 原点位于黑色实心圆点处，Z轴沿主光轴向右上方延伸，Y轴垂
// 直向下偏右延伸，X轴未明确标出但隐含为水平方向。 在坐标
// 系右侧，是一个由多个透明淡紫色长方体块组成的透镜组或反
// 射镜支撑结构，呈阶梯状排列，表面具有轻微反光效果，表示
// 其为光学元件载体。从该结构左侧射入一束平行光线，分为红、
// 绿、蓝三种颜色，代表不同波长或入射角度的光束。这些光线
// 进入系统后发生折射或反射，在左侧形成一个大型弧形反射镜
// 阵列——该阵列由上下两块对称的弯曲镜面构成，边缘带有橙色
// 边框，镜面内侧密集分布着交叉的红、绿、蓝三色细线，表示
// 光线在镜面上的多次反射路径。 所有光线最终汇聚于左下角
// 一个小型矩形探测器平面，该平面以半透明白色显示，底部有
// 一条红色基线标记焦面位置。探测器平面上可见三条清晰的彩
// 色光斑轨迹：蓝色光斑最靠下，绿色居中，红色最靠上，表明
// 系统对不同波长存在色散效应。 图中标注文字包括：“input
// aperture”指向入射光口区域，“y”、“z”分别标注对应坐标轴
// 方向。无比例尺、无色标图例、无曲线拟合或数据点，纯几何
// 光路示意。整体传达结论为：LFT结构通过多级反射实现宽视
// 场聚焦，且不同波长光线在焦面上呈现空间分离，体现其光谱
// 分辨能力；同时展示了输入孔径到探测器的完整光程与成像几
// 何关系。
#figure(placement: top,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    image("imgs/lft_ray_trace.png", width: 100%),
    image("imgs/lft_structure.png", width: 100%),
  ),
  caption: [
    Ray tracing diagram of LFT (left) and LFT structure (right).
  ]
)
<fig:lft>


==== Structural Design
<structural-design>
The frame and reflectors of LFT are made of aluminum (A6061) in order to shrink similarly by 0.4 % to 4.8 K from 300 K. The telescope is covered with aluminum and absorbers to reduce straylight from the inner surface of the V-groove. The mass of LFT, including the focal plane, is estimated to be approximately $200$ kg. The telescope is supported by trusses made of aluminum on the 4.8-K interface plate, as illustrated in @fig:lft.


=== Scaled Model Demonstration
<sect:LFT-scaled-model>
A quarter (1/4) size scaled model of LFT (see #ref(<fig:LFTqscaleMeasSys>, supplement: none)) has been designed and developed to characterize the antenna pattern in the near field~#cite(<Takakura2019IEEE>). The observed frequencies are also scaled, so that the antenna pattern of the scaled model matches that of the full size one. The measured antenna patterns are then transformed to far fields, as shown in #ref(<fig:LFTqscaleMeasSys>, supplement: none). Based on these scaled model measurements, we confirmed the wide-field performance of LFT and the suppression of far sidelobes.


// [figvision-cn] imgs/HVpol_220G_Xcut.png
// 该图由三个垂直堆叠的曲线子图组成，分别标记为“Pos. A”、
// “Pos. B”和“Pos. C”，展示了在220 GHz频率下（对应全尺寸
// LFT的55 GHz），四分之一LFT模型焦平面上三个不同位置（中
// 心、左上边缘、左下边缘）的远场辐射方向图。 所有子图共
// 享相同的坐标轴定义：横轴为扫描角度θₓ，单位为度（deg），
// 范围从-60°到+60°；纵轴为归一化强度，单位为分贝（dB），
// 范围从-60 dB到0 dB。每个子图中均包含两条数据曲线：橙色
// 实线代表垂直极化（V-pol）分量，蓝色实线代表水平极化（
// H-pol) 分量。此外，每个子图中都有一条红色虚线水平参考
// 线，位于-56 dB处，并在最上方子图中标注有红色文字“-56
// dB”。 子图a（顶部，标签“Pos. A”）： 类型：曲线图。 内
// 容：显示焦平面中心位置（Pos. A）的远场方向图。两条曲线
// （V-pol与H-pol）在θₓ = 0°附近呈现高度重合的主瓣峰值，
// 峰值强度接近0 dB。主瓣两侧对称分布着旁瓣结构，旁瓣电平
// 随角度增大而衰减。在|θₓ| > 20°区域，两条曲线波动剧烈，
// 整体低于-56 dB红线，表明在此角度范围内交叉极化或杂散辐
// 射被有效抑制。趋势结论：中心位置具有高度对称且低旁瓣的
// 主波束，双极化性能一致，符合理想聚焦特性。 子图b（中部，
// 标签“Pos. B”）： 类型：曲线图。 内容：显示焦平面左上边
// 缘位置（Pos. B）的远场方向图。主瓣峰值仍位于θₓ ≈ 0°，
// 但相比Pos. A略有展宽，峰值略低于0 dB（约-1~2 dB）。
// V-pol与H-pol曲线在主瓣区基本重合，但在旁瓣区出现轻微分
// 离，尤其在θₓ < -20°区域，H-pol曲线部分高于V-pol。整体
// 旁瓣电平仍低于-56 dB红线，但局部波动幅度略大于Pos. A。
// 趋势结论：边缘位置主瓣保持良好，但对称性稍弱，存在微小
// 极化失配，但仍满足低旁瓣要求。 子图c（底部，标签“Pos.
// C”）： 类型：曲线图。 内容：显示焦平面左下边缘位置（
// Pos. C）的远场方向图。主瓣峰值同样位于θₓ ≈ 0°，形状与
// Pos. B相似，峰值强度略低于Pos. B（约-2~3 dB）。V-pol与
// H-pol曲线在主瓣区几乎完全重叠，在旁瓣区也保持高度一致
// 性，仅在极端角度（如θₓ < -40°）有微小差异。所有旁瓣均
// 稳定低于-56 dB红线。趋势结论：另一边缘位置表现优异，主
// 瓣清晰，极化纯度高，旁瓣控制良好，说明系统在不同焦平面
// 位置具有鲁棒性。 综合三子图：无论测量点位于焦平面中心
// 还是边缘，四分之一LFT模型在220 GHz下均能产生以0°为中心
// 的窄主瓣，且双极化响应高度一致，旁瓣电平普遍低于-56 dB，
// 验证了其作为缩比模型在远场辐射特性上的有效性与设计目标
// 的达成。
// [figvision-cn] imgs/HVpol_220G_Xcut.png
// 该图由三个垂直堆叠的曲线子图组成，分别标记为“Pos. A”、
// “Pos. B”和“Pos. C”，展示了在220 GHz频率下（对应全尺寸
// LFT的55 GHz），四分之一LFT模型焦平面上三个不同位置（中
// 心、左上边缘、左下边缘）的远场辐射方向图。 所有子图共
// 享相同的坐标轴定义：横轴为扫描角度θₓ，单位为度（deg），
// 范围从-60°到+60°；纵轴为归一化强度，单位为分贝（dB），
// 范围从-60 dB到0 dB。每个子图中均包含两条数据曲线：橙色
// 实线代表垂直极化（V-pol）分量，蓝色实线代表水平极化（
// H-pol) 分量。此外，每个子图中都有一条红色虚线水平参考
// 线，位于-56 dB处，并在最上方子图中标注有红色文字“-56
// dB”。 子图a（顶部，标签“Pos. A”）： 类型：曲线图。 内
// 容：显示焦平面中心位置（Pos. A）的远场方向图。两条曲线
// （V-pol与H-pol）在θₓ = 0°附近呈现高度重合的主瓣峰值，
// 峰值强度接近0 dB。主瓣两侧对称分布着旁瓣结构，旁瓣电平
// 随角度增大而衰减。在|θₓ| > 20°区域，两条曲线波动剧烈，
// 整体低于-56 dB红线，表明在此角度范围内交叉极化或杂散辐
// 射被有效抑制。趋势结论：中心位置具有高度对称且低旁瓣的
// 主波束，双极化性能一致，符合理想聚焦特性。 子图b（中部，
// 标签“Pos. B”）： 类型：曲线图。 内容：显示焦平面左上边
// 缘位置（Pos. B）的远场方向图。主瓣峰值仍位于θₓ ≈ 0°，
// 但相比Pos. A略有展宽，峰值略低于0 dB（约-1~2 dB）。
// V-pol与H-pol曲线在主瓣区基本重合，但在旁瓣区出现轻微分
// 离，尤其在θₓ < -20°区域，H-pol曲线部分高于V-pol。整体
// 旁瓣电平仍低于-56 dB红线，但局部波动幅度略大于Pos. A。
// 趋势结论：边缘位置主瓣保持良好，但对称性稍弱，存在微小
// 极化失配，但仍满足低旁瓣要求。 子图c（底部，标签“Pos.
// C”）： 类型：曲线图。 内容：显示焦平面左下边缘位置（
// Pos. C）的远场方向图。主瓣峰值同样位于θₓ ≈ 0°，形状与
// Pos. B相似，峰值强度略低于Pos. B（约-2~3 dB）。V-pol与
// H-pol曲线在主瓣区几乎完全重叠，在旁瓣区也保持高度一致
// 性，仅在极端角度（如θₓ < -40°）有微小差异。所有旁瓣均
// 稳定低于-56 dB红线。趋势结论：另一边缘位置表现优异，主
// 瓣清晰，极化纯度高，旁瓣控制良好，说明系统在不同焦平面
// 位置具有鲁棒性。 综合三子图：无论测量点位于焦平面中心
// 还是边缘，四分之一LFT模型在220 GHz下均能产生以0°为中心
// 的窄主瓣，且双极化响应高度一致，旁瓣电平普遍低于-56 dB，
// 验证了其作为缩比模型在远场辐射特性上的有效性与设计目标
// 的达成。
#figure(placement: top, 
  grid(columns: (1fr, 1fr), gutter: 8pt,
    image("imgs/LFTqscaleMeasSys.png", width: 100%),
    image("imgs/HVpol_220G_Xcut.png", width: 100%),
  ),
  caption: [
    _Left_: LFT quarter (1/4) scaled model and its near-field measurement system. _Right_: Far field patterns of the quarter LFT at the center (Pos. A), the left upper edge (Pos. B), and the left bottom edge (Pos C) of the focal plane measured at 220 GHz (which corresponds to 55 GHz for the full-scale LFT).
  ]
) <fig:LFTqscaleMeasSys>


=== LFT Polarization Modulation Unit
<sss:plm_lft_pmu>


The baseline configuration of the #emph[LiteBIRD] LFT PMU consists of a Pancharatnam-type multi-layer sapphire stack as an ahwp, which is supported by a cryogenically cooled rotational mechanism. A similar system was employed by a balloon-borne CMB experiment, ebex, and has been under development by multiple ground-based experiments, e.g. POLARBEAR-2 and Simons Observatory ~#cite(<ebex_pmu>) #cite(<pb2b_pmu>) #cite(<so_sat>). Here we describe a summary of the current development status using the PMU BBM during the conceptual design phase. This BBM is
aimed at demonstrating some of the key technological challenges, as we will highlight later. @fig:pmu_overview shows the overview and components of the current PMU BBM; a more detailed overview can be found in Ref.~#cite(<Sakurai2020SPIE>)


The AHWP is continuously rotated by the cryogenic rotation mechanism that consists of the smb and the synchronous motor spinning at a rotation speed of 46 rpm throughout the mission. The AHWP covers the observational frequency band of LFT. The broadband anti-reflection coating is achieved using sub-wavelength structures directly machined by a laser. The small diameter sample demonstration achieved the measured transmittance of 91 % and 97 % for the 40- and 50-GHz LFT bands, respectively, and above 98 % for other frequency bands~#cite(<ryota_JAP2020>).
Most recently, we made a sample with a diameter up to 80 mm ~#cite(<ryota_SPIE2020>). The current machining strategy is scalable in diameter, and the demonstration with larger diameter samples (200 mm and 330 mm) is in progress. The high modulation efficiency is realized using multilayered sapphire plates based on a Pancharatnam recipe. We plan to employ 5-layer sapphire plates, which achieves an averaged modulation efficiency of about 92 % and 96 % for the 40- and 140-GHz LFT bands, respectively, and above 98 % for other frequency bands, as well as
nulling the frequency-dependent fast-axis variation over the LFT bandwidth~#cite(<Kunimoto_JATIS_2020>) #cite(<Kunimoto2020SPIEDemo>) #cite(<Kunimoto2020SPIEDesign>). The multi-layer sapphires will be glued by using a sodium silicate solution. The first preliminary tests with a polished $4 thin "mm" times 4 thin "mm"$ surface show that the mechanical strength is $> 20$ MPa, which is sufficiently high to mechanically treat the multi-layer sapphire stack as one bulk sample under the launch impact~#cite(<Toda2020SPIE>). We also test if there is any effect
to the millimeter-wave transmittance with this bonding scheme using a sapphire sample with a diameter of 100 mm, and we did not find any effect within the noise level of the measurement, equal to 2 % of the signal. We are continuing to address this evaluation with a larger diameter sample and high accuracy millimeter-wave characterization. The AHWP is the first optical element of the LFT and it is held to the telescope structure using both the launch lock system and the cryogenic holder mechanism. The launch lock will be released soon after launch. The
cryogenic holder mechanism is used to maintain the rotor in place during launch and cool-down, before the rotor thermalizes and levitates thanks to the high-temperature superconductor bulks. It also functions as a heat path that thermalizes the rotor to the operating temperature of 4.8 K. The combination of the SMB and the synchronous motor achieves fully contact-free rotation to minimize the heat dissipation from physical contact, as well as giving no wear-and-tear during the mission. The required AHWP temperature during science operations has to be
less than 20 K in order to reduce thermal emission from the AHWP itself. The corresponding maximum heat dissipation that the rotor can accept is $< thin 1$ mW. Despite having no physical contact, a source of heat dissipation can still come from magnetic friction. The key development items are to achieve an uniform magnetic field of the rotor magnet, along with lightweight mechanical and thermal design, without using metal to minimize the eddy currents. The status of this development is detailed in @Sakurai2019JPCS.


The absolute and relative angular positions of the AHWP with respect to the instrument frame are monitored by using a cryogenically compatible optical encoder, which consists of an LED and a photo-diode. We developed an angular encoder readout system, which consists of an optical chopper between the LED and photodiode. The encoder from the photodiode is read using an fpga with an adc and we have demonstrated reconstruction of the position angle to better than 1 arcmin with the dedicated algorithm. This analysis, together with identifying the source of
the position angle uncertainties, are reported in @Sugiyama2020SPIE. The absolute polarization angle referenced to sky coordinates will be calibrated by some other means, e.g., nulling $C_ell^(E B)$ or using polarized astrophysical sources (see @ss:plm_calib).


Mitigation of systematic effects for low-$ell$ reconstruction makes the PMU the key to the success of the mission. Current efforts shall lead the design of the demonstration and engineering models by working with companies that are qualified to procure the flight hardware.


// [figvision-cn] imgs/pmu_overview3.png
// 该图由多个子图组成，展示了LiteBIRD LFT PMU BBM的概览及
// 其组件。 (a) 左上角：显微照片与示意图组合。左侧为两张
// 圆形蓝宝石片的照片，上方一张显示中心有圆孔，下方一张标
// 注直径“35 mm”，并带有红色箭头指示直径方向及坐标轴x、y。
// 右侧为三维表面形貌图，横纵坐标轴范围均为0至2000.0（单
// 位未明确标出，推测为纳米或微米），垂直颜色条表示高度，
// 从蓝色（0.0）到红色（约1760.0）。图中呈现规则排列的锥
// 形突起结构，即蛾眼亚波长光栅结构，用于抗反射。 (b) 中
// 上部：实物照片，展示一个金属机械部件，标签为“Gripper”
// （夹持器）。该部件呈圆盘状，边缘有多个螺栓孔，中央安装
// 复杂机械结构，包含杠杆、弹簧和金色触点，用于抓取或固定
// 物体。 (c) 右上部：实物照片，标签为“Encoder”（编码器）。
// 显示两个绿色外壳的传感器模块，通过线缆连接，安装在金属
// 支架上，用于测量旋转角度或位置。 (d) 右上角：实物照片，
// 标签为“Drive motor”（驱动电机）。展示一个银色金属圆柱
// 形电机，内部可见多极转子结构，外部有接线端子，用于提供
// 旋转动力。 (e) 左中部：曲线图。横坐标为频率[Frequency]，
// 单位GHz，范围0至180；纵坐标为透射率[Transmittance]，无
// 量纲，范围0.0至1.0。图中两条线：红色虚线代表计算值(
// Calculation)，蓝色点线代表测量值(Measurement)。在约40
// GHz以上频段，两者均接近1.0，表明宽带高透射特性。图中标
// 注“Broadband AR”（宽带抗反射）。 (f) 左下部：实物照片
// 与结构示意图组合。左侧为“Sapphire HWP”（蓝宝石半波片）
// 实物照片，标注直径“500 mm”，并用红色箭头指示直径方向。
// 中间为三层堆叠示意图：顶层为带蛾眼结构的蓝宝石板，中层
// 为a-cut蓝宝石基板，底层为另一层带蛾眼结构的蓝宝石板，
// 整体构成“Achromatic HWP”（消色差半波片）。底部为“
// Sapphire holder”（蓝宝石夹具）实物照片，黑色环形结构内
// 嵌白色多孔材料，用于支撑和保护蓝宝石片。 (g) 中部：主
// 装配示意图。中心为一个大型环形装置，内部填充蓝色区域代
// 表光学元件，外圈为白色框架，四周分布多个接口和传感器。
// 红色箭头指向不同组件：顶部箭头指向“Gripper”，右侧箭头
// 指向“Encoder”，右下箭头指向“Launch Lock”（发射锁），底
// 部箭头指向“Superconducting Magnetic Bearing”（超导磁轴
// 承）。该图展示整个AHWP系统的集成布局。 (h) 右中部：实
// 物照片，标签为“Cryogenic Rotation Mechanism”（低温旋转
// 机构）。展示一个直径Φ=380mm的金属环状结构，内部装有绿
// 色电路板，周围布满管线和支架，用于在低温环境下实现精密
// 旋转。 (i) 右下部：两个实物照片并列。左侧为“
// Superconducting Magnetic Bearing”实物，环形结构内嵌线
// 圈，用于无摩擦悬浮支撑。右侧为该轴承剖面图，显示内部铜
// 色线圈和绝缘层结构。 (j) 底部中央：曲线图。横坐标为频
// 率[Frequency]，单位GHz，范围0至200；纵坐标为归一化效率
// [Normalized Efficiency]，无量纲，范围0.0至1.0。图中两
// 条线：红色虚线代表计算值，蓝色点线代表测量值。在约
// 50-150 GHz频段，效率维持在0.8以上，峰值接近1.0，表明高
// 效工作带宽。 所有子图共同传达：AHWP系统由五层直径约
// 500mm的蓝宝石片组成，表面具有蛾眼抗反射结构；采用叶状
// 夹具兼顾热隔离与机械强度；配备编码器、驱动电机、低温旋
// 转机构和超导磁轴承等关键部件；实测透射率和效率与理论计
// 算吻合良好，验证了其在宽频带下的高性能表现。
#figure(placement: top, image("imgs/pmu_overview3.png", width: 100.0%),
  caption: [
    Overview and components of the #emph[LiteBIRD] LFT PMU BBM. The AHWP is composed of five-layer sapphire plates that are about 500 mm in diameter with moth-eye sub-wavelength grating structures for anti-reflection on two outer surfaces. The entire AHWP is held in the leaf-like holder, which accounts for the differential thermal contact and yet is strong enough to survive the launch impact and vibration. The rotational mechanism is composed of the cryogenic holder mechanism (called the "gripper"), the optical encoder for monitoring the rotor position,
and the drive motor mechanism to drive the rotor. The rotation is supported by the superconducting bearing, ring magnet, and ring YBCO. The entire rotor is held by the launch lock in order to survive the launch impact.
  ]
)
<fig:pmu_overview>


== Mid- and High-Frequency Telescopes
<ss:plm_mhft>


=== Overview
<sss:MHFT_Overview>
The optimization of the instrumental design over the mid- and high-frequency range of #emph[LiteBIRD], spanning from 89 GHz to 448 GHz, led to a design with two fully refractive telescopes, as shown in @fig:focalplanes. The frequency bands of the MFT range from 89 to 224 GHz, and from 166 to 448 GHz for the HFT (see Ref.~@Montier2020SPIE for more details). When considered together, the two telescopes are referred to as the mhft.

// [figvision-cn] imgs/Fig15_revised.png
// 这是一张中频和高频望远镜系统的三维结构示意图。图像中心
// 展示了两个呈V字形对称排列的圆柱形望远镜组件，它们围绕
// 一条垂直的中心虚线轴分布。该中心轴顶部标有“Spin axis”
// 字样，并配有一个环绕箭头的圆形符号，表示旋转方向。 左
// 侧为高频望远镜（HFT）组件，右侧为中频望远镜（MFT）组件。
// 每个组件均由多个沿光路排列的光学部件构成，从外向内依次
// 为： 遮光罩（Baffle），标注温度为5K； 半波片（HWP），
// 标注温度小于18K； 冷阑（Cold stop），标注温度为5K； 第
// 一透镜（1st Lens），标注温度为5K； 第二透镜（2nd Lens），
// 标注温度为5K； 焦平面单元（FPU），标注温度为0.1K。 在
// 左侧HFT路径上，红色箭头指示光线从外部进入，经各光学元
// 件后汇聚至HF-FPU；右侧MFT路径同样用红色箭头标示光路走
// 向，最终聚焦于MF-FPU。两条光路均以红色虚线表示视场范围
// （FoV），并在顶端标注“28° FoV”，表明每个望远镜的视场角
// 均为28度。 两个望远镜主体通过蓝色支撑结构连接到底部基
// 座，基座下方设有绿色和棕色支腿用于固定。图像底部有一条
// 双向箭头线段，标注“1 m”，表示整个装置横向跨度约为1米。
// 所有部件均配有引线标签，明确标识其名称与对应工作温度。
// 整体布局清晰展示了两套独立但对称布置的望远镜系统及其热
// 控设计，强调低温环境下的光学性能实现。
#figure(image("imgs/Fig15_revised.png", height: 80mm),
  caption: [
    Overview of the Mid- and High-Frequency Telescopes.
  ]
)
<fig:mhft>


The choice to use two distinct fully refractive telescopes has been mainly driven by the constraints put on the hwp material and the arcs, imposed by the broad frequency coverage and the limited mass budget and volume allocation. Each telescope features its own polarization modulator, in order to mitigate the bandwidth limitations of the HWP mesh technology. The global design specifications of the MFT and HFT are summarized in @tbl:MHFT-specification. This design benefits from the broad expertise gained on many current and upcoming sub-orbital CMB
experiments, such as BICEP/Keck~#cite(<Ade_2015_BKIV>), SPIDER~#cite(<Gualtieri2018>), LSPE~#cite(<Lamagna2020a>), and Simons Observatory~#cite(<Gudmundsson:21>). With these very compact on-axis designs, the MFT and HFT match the volume and weight constraints, mitigate straylight issues, and split the entire frequency range into two bands. This choice also offers more flexibility for an optimal design of the separate filtering chains. Dealing with two smaller compact telescopes will considerably simplify the ait and aiv phases of the project and the
ground calibration activities. On the other hand, careful design and modeling are needed for the pp lenses and transmissive meta-materials, see @sss:MHFT_Optical_design. Finally MFT and HFT assemblies are held on a single mechanical structure cooled down to 4.8 K, which contains the sub-4.8 K parts of the cryo-chain.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([], [MFT], [HFT],),
    table.hline(),
    [Frequency coverage], [89--224 GHz], [166--448 GHz],
    [], [5 observation bands], [5 observation bands],
    [Detectors number], [2074], [1354],
    [Aperture diameter], [300 mm], [200 mm],
    [Rotational HWP speed], [39 rpm], [61 rpm],
    [Field of view], table.cell(align: center, colspan: 2)[Ø$28^compose$],
    [Angular resolution], table.cell(align: center, colspan: 2)[$<$ 30 arcmin],
    [Volume allocation at 5 K], table.cell(align: center, colspan: 2)[$1700 thin "mm" times 1400 thin "mm" times 750 thin "mm"$],
    [Mass budget at 5 K], table.cell(align: center, colspan: 2)[100 kg],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Global design specifications of MFT and HFT. ]
  , kind: table
  )

<tbl:MHFT-specification>


=== Optical Design
<sss:MHFT_Optical_design>


The optical configurations of MFT and HFT are shown in @fig:opt_config. Both telescopes have f/2.2, with an aperture stop (300 mm and 200 mm in diameter, for MFT and HFT, respectively) located skywards of the two lenses. The stop also serves as a convenient location for the transmissive HWP, which is located very close to (but slightly sky-side of) the stop.


// [figvision-cn] imgs/hft_ray.png
// 该图展示了一个标记为“HFT”的望远镜系统的光线追迹示意图。
// 子图类型：光线追迹示意图（二维截面图）。 坐标轴： 横轴
// （z/mm）表示沿光轴的纵向距离，单位为毫米（mm），范围从
// -100到800，主刻度间隔为100。 纵轴（r/mm）表示垂直于光
// 轴的径向高度，单位为毫米（mm），范围从-150到150，主刻
// 度间隔为50。 图中元素与布局： 在 z=0 mm 处有一条垂直的
// 黑线段，代表入射光瞳或孔径限制面，其径向范围大约从 r=
// -100 mm 到 r=100 mm。 在 z≈170 mm 处绘制了一个双凸透镜
// 的轮廓，由两条黑色曲线表示，其顶点分别位于约 r=150 mm
// 和 r=-150 mm 处。 在 z≈580 mm 处绘制了第二个双凸透镜的
// 轮廓，形状与第一个类似。 在 z≈720 mm 处有一条垂直的黑
// 线段，代表焦平面或探测器位置。 光线描述： 图中包含两组
// 不同颜色的直线，代表光线传播路径。 蓝色光线：共11条，
// 起始于 z=0 处的不同径向位置（从 r=-100 到 r=100，间隔
// 均匀）。这些光线穿过两个透镜后，全部汇聚于焦平面上的同
// 一点 (z≈720, r=0)。根据图注说明，蓝色光线代表轴上视场
// （on-axis fields）。 红色光线：共11条，起始于 z=0 处的
// 不同径向位置（从 r=-100 到 r=100）。这些光线穿过两个透
// 镜后，全部汇聚于焦平面上的另一点 (z≈720, r≈115)。根据
// 图注说明，红色光线代表轴外视场（off-axis fields）。 标
// 注文字： 在图表底部中央位置，有大号加粗字体标注“HFT”。
// 左侧纵轴标签为“r/mm”。 底部横轴标签为“z/mm”。 趋势与结
// 论： 该图展示了HFT望远镜系统对轴上和轴外点光源的成像特
// 性。蓝色光线表明轴上物点成像在光轴中心；红色光线表明轴
// 外物点成像在光轴上方约115 mm处，显示出系统具有较大的视
// 场角。所有光线均能会聚成点，表明该系统在该视场范围内具
// 有良好的聚焦能力。透镜材料为聚丙烯（polypropylene），
// 虽然图中未直接显示材质属性，但这是系统设计的一部分。
// [figvision-cn] imgs/hft_ray.png
// 该图展示了一个标记为“HFT”的望远镜系统的光线追迹示意图。
// 子图类型：光线追迹示意图（二维截面图）。 坐标轴： 横轴
// （z/mm）表示沿光轴的纵向距离，单位为毫米（mm），范围从
// -100到800，主刻度间隔为100。 纵轴（r/mm）表示垂直于光
// 轴的径向高度，单位为毫米（mm），范围从-150到150，主刻
// 度间隔为50。 图中元素与布局： 在 z=0 mm 处有一条垂直的
// 黑线段，代表入射光瞳或孔径限制面，其径向范围大约从 r=
// -100 mm 到 r=100 mm。 在 z≈170 mm 处绘制了一个双凸透镜
// 的轮廓，由两条黑色曲线表示，其顶点分别位于约 r=150 mm
// 和 r=-150 mm 处。 在 z≈580 mm 处绘制了第二个双凸透镜的
// 轮廓，形状与第一个类似。 在 z≈720 mm 处有一条垂直的黑
// 线段，代表焦平面或探测器位置。 光线描述： 图中包含两组
// 不同颜色的直线，代表光线传播路径。 蓝色光线：共11条，
// 起始于 z=0 处的不同径向位置（从 r=-100 到 r=100，间隔
// 均匀）。这些光线穿过两个透镜后，全部汇聚于焦平面上的同
// 一点 (z≈720, r=0)。根据图注说明，蓝色光线代表轴上视场
// （on-axis fields）。 红色光线：共11条，起始于 z=0 处的
// 不同径向位置（从 r=-100 到 r=100）。这些光线穿过两个透
// 镜后，全部汇聚于焦平面上的另一点 (z≈720, r≈115)。根据
// 图注说明，红色光线代表轴外视场（off-axis fields）。 标
// 注文字： 在图表底部中央位置，有大号加粗字体标注“HFT”。
// 左侧纵轴标签为“r/mm”。 底部横轴标签为“z/mm”。 趋势与结
// 论： 该图展示了HFT望远镜系统对轴上和轴外点光源的成像特
// 性。蓝色光线表明轴上物点成像在光轴中心；红色光线表明轴
// 外物点成像在光轴上方约115 mm处，显示出系统具有较大的视
// 场角。所有光线均能会聚成点，表明该系统在该视场范围内具
// 有良好的聚焦能力。透镜材料为聚丙烯（polypropylene），
// 虽然图中未直接显示材质属性，但这是系统设计的一部分。
#figure(placement: top, [#figure(
    align(center)[#table(
    stroke: none,
      columns: 2,
      align: (center,center,),
    table.hline(stroke: 0.8pt),
      [#block[
      #box(image("imgs/mft_ray.png", width: 100%))
      ]], [#block[
      #box(image("imgs/hft_ray.png", width: 100%))
      ]],
    table.hline(stroke: 0.8pt),
    table.hline(stroke: 0.5pt),
    )]
    , kind: table
    )

  ],
  caption: [
    Ray-tracing diagrams for MFT (left) and HFT (right). The on-axis and off-axis fields ($14^compose$) are the blue and red rays, respectively. The telescope aperture is located at $z = 0$, with a diameter of 300 mm and 200 mm for MFT and HFT, respectively. The lens material is polypropylene.
  ],
  kind: image,
)
<fig:opt_config>


Both systems are diffraction-limited to the upper edge of their respective bands, across a $28^compose$ diameter field of view, and have telecentric focal planes. Initial physical optics simulations for the MFT also indicate uniform beam shapes, with low cross-polarization and ellipticity smaller than 0.03, across the field of view. The HFT optical performance is very similar. A more detailed review of the performance analysis of the MFT and the HFT systems is discussed in @Lamagna2020SPIE.


An axisymmetrical optical design for the MFT and HFT has been adopted to remain simple with excellent performance, while being relatively relaxed in terms of optical tolerances. However, this creates optical modeling challenges due to refractive surfaces and metamaterials. Some performance validation is needed to address both the issues related to intrinsic frequency-, polarization-, and temperature-dependent properties of the refracting materials. It will be essential to understand the higher-order optical coupling effects arising from a broad set of
non-idealities, like imperfect dielectric-to-vacuum matching at the optical interfaces, imperfectly-absorbing tube surfaces and focal planes, scattering off internal surfaces, and thermal radiation pickup from the payload environment.


==== Half-wave Plate
<half-wave-plate>
While the electromagnetic behavior of the mesh HWP is very well modeled and validated at the subsystem level, the presence of a mesh HWP along the optical path to the focal plane makes it necessary to model the whole system with accuracies beyond what is achievable with currently available simulation software. The need to capture the impact of imperfect and frequency-dependent phase shifts, and the effect of non-normal incidence on the final performance of the device creates an extremely complex modeling effort. The HWP imperfections might modulate the
background and lead to a strong synchronous signal peaked at harmonics of the HWP rotation frequency. Such an hwpss has been observed using Maxima~#cite(<Johnson_2007>), EBEX~#cite(<chapman2014>), POLARBEAR~#cite(<POLARBEAR2016>) and NIKA~#cite(<ritacco2017>), each of which used a continuously rotating HWP, similarly to the #emph[LiteBIRD] case. The parasitic HWPSS can be modeled and subtracted in the data analysis process~#cite(<ritacco2017>). However any residual could act as an additional noise in the polarization data and increase the total error
budget. In order to reach the required accuracy it will be crucial to characterize and model this at the system level as a result of beam propagation through the whole optical chain, including the HWP, quasi-optical filters, optical elements and focal-plane beam formers. This effort is in progress.


==== Optical Ghosts
<optical-ghosts>
Ghosts are detectable effects arising from a variety of non-idealities in the optical system, mostly due to multiple internal reflections that partially re-focus the light away from the intended location on the focal plane. Image and polarization artifacts due to this effect must be clearly identified, modeled and compared with the actual behavior of the optical system. A systematic study on these effects needs to be carried out to evaluate their impact on the final performance of the MHFT instruments. As reported in Ref.~@Lamagna2020SPIE a preliminary
study was performed at 90 GHz on the MFT to characterize multiple reflections off optical surfaces. This analysis showed a diffuse contamination from ghosting across the focal plane at the level of $- 40$ dB of the peak level of the nominal focused image, with resulting artifacts in the reconstructed image at scales of a few degrees on the sky (see @fig:ghost_examples).


// [figvision-cn] imgs/MFT_ghost_beam_sample.png
// 该图像为一张二维极坐标风格的天线远场功率分布热图，展示
// 了90 GHz频率下光学鬼影现象。 横坐标为方位角（Azimuth），
// 单位为度（deg），范围从-5到15；纵坐标为仰角（Elevation），
// 单位为度（deg），范围从-10到10。右侧设有一条垂直颜色条
// （Color Bar），表示功率电平，单位为分贝（dB），数值范
// 围从-30 dB（深紫色/黑色）至+50 dB（亮黄色）。颜色由低
// 到高依次为：深蓝紫、品红、橙红、黄白，代表信号强度递增。
// 图中主波束位于中心区域（约方位角3°、仰角0°附近），呈近
// 似圆形高亮区，核心接近+50 dB，向外逐渐衰减。围绕主波束
// 存在多个同心环状结构，对应旁瓣或干涉条纹，颜色由内向外
// 从橙红过渡到品红再至深紫，表明功率随角度增大而下降。在
// 主波束左侧（约方位角-4°、仰角0°处）可见一个独立的次级
// 波束特征，形状不规则但轮廓清晰，其内部标注有“10”字样，
// 表示该处功率约为+10 dB，与主波束分离明显，构成典型的“
// 鬼影”结构。 图中叠加了白色等高线，用于标示特定功率电平：
// 最内圈标注“30”，次圈“20”，外圈“10”，这些等高线勾勒出主
// 波束和次级波束的边界。此外，在背景中可见大量细密的波浪
// 形纹理，呈螺旋状从中心向外扩散，反映非理想抗反射涂层（
// ARC）与焦平面吸收不良共同导致的复杂干涉效应。 整体趋势
// 显示：除主波束外，系统在偏离主方向约7–8度的位置出现显
// 著次级辐射峰（即鬼影），其功率达+10 dB，远高于背景噪声
// 水平（<-10 dB），证实了在90 GHz工作时因ARC不匹配引发的
// 严重光学伪影问题。
// [figvision-cn] imgs/MFT_ghost_beam_sample.png
// 该图像为一张二维极坐标风格的天线远场功率分布热图，展示
// 了90 GHz频率下光学鬼影现象。 横坐标为方位角（Azimuth），
// 单位为度（deg），范围从-5到15；纵坐标为仰角（Elevation），
// 单位为度（deg），范围从-10到10。右侧设有一条垂直颜色条
// （Color Bar），表示功率电平，单位为分贝（dB），数值范
// 围从-30 dB（深紫色/黑色）至+50 dB（亮黄色）。颜色由低
// 到高依次为：深蓝紫、品红、橙红、黄白，代表信号强度递增。
// 图中主波束位于中心区域（约方位角3°、仰角0°附近），呈近
// 似圆形高亮区，核心接近+50 dB，向外逐渐衰减。围绕主波束
// 存在多个同心环状结构，对应旁瓣或干涉条纹，颜色由内向外
// 从橙红过渡到品红再至深紫，表明功率随角度增大而下降。在
// 主波束左侧（约方位角-4°、仰角0°处）可见一个独立的次级
// 波束特征，形状不规则但轮廓清晰，其内部标注有“10”字样，
// 表示该处功率约为+10 dB，与主波束分离明显，构成典型的“
// 鬼影”结构。 图中叠加了白色等高线，用于标示特定功率电平：
// 最内圈标注“30”，次圈“20”，外圈“10”，这些等高线勾勒出主
// 波束和次级波束的边界。此外，在背景中可见大量细密的波浪
// 形纹理，呈螺旋状从中心向外扩散，反映非理想抗反射涂层（
// ARC）与焦平面吸收不良共同导致的复杂干涉效应。 整体趋势
// 显示：除主波束外，系统在偏离主方向约7–8度的位置出现显
// 著次级辐射峰（即鬼影），其功率达+10 dB，远高于背景噪声
// 水平（<-10 dB），证实了在90 GHz工作时因ARC不匹配引发的
// 严重光学伪影问题。
#figure(placement: top, [#figure(
    align(center)[#table(
    stroke: none,
      columns: 2,
      align: (center,center,),
    table.hline(stroke: 0.8pt),
      [#block[
      #box(image("imgs/MFT_ghost_beam_sample.png", width: 100%))
      ]], [#block[
      #box(image("imgs/MFT_ghost_sample_telescope_plane.png", width: 100%))
      ]],
    table.hline(stroke: 0.8pt),
    table.hline(stroke: 0.5pt),
    )]
    , kind: table
    )

  ],
  caption: [
    #emph[Left]: Example of optical ghosting at 90 GHz, from the combined effect of a non-ideal ARC, (in this case a single-layer ARC optimized for 150 GHz,) on MFT lenses and imperfect absorption on the focal plane, as seen in the telescope far field. A secondary beam-like feature can be shown out of the main beam pattern in this example. #emph[Right]: Corresponding power distribution in the plane of the telescope, as predicted by these simulations.
  ],
  kind: image,
)
<fig:ghost_examples>


=== Sub-systems
<sss:plm_mhft_subsystems>
We detail below the various sub-systems of the two telescopes, starting from the first optical component encountered, the rotating HWP, down to the mechanical structure.


==== PMU design and development
<pmu-design-and-development>
The polarization modulator units (PMUs) for the MFT and HFT are based on spinning HWPs. The mesh-filter technology~#cite(<Pisano1>) provides ultra-light transmissive HWPs and has been adopted for both telescopes. While this technology offers a large gain in mass compared to sapphire HWPs, the current mesh-HWP bandwidth would not cover the whole LFT bandwidth, whereas it can more easily accomodate the MFT and HFT bandwidths. Moreover, facilities already in place allow us to manufacture large diameter devices (up to 60 cm diameter). The mesh HWPs consist
of polypropylene-embedded anisotropic metal grids, AR-coated on both sides (see @fig:HWP). These devices emulate the behavior of birefringent materials by means of orthogonally oriented stacks of capacitive and inductive grids~#cite(<Pisano2>) #cite(<Pisano3>). The expected transmission coefficients and the polarization modulation efficiencies across the MHFT bands are, respectively, approximately 95 % and greater than 95 %, for MFT and HFT, respectively. The estimated weights of the HFT and MFT waveplates are approximately $100 med "g"$ and
$400 med "g"$, respectively. A detailed description of the mesh-HWP design and manufacture can be found in Ref.~#cite(<Pisano4>)


// [figvision-cn] imgs/HWP.png
// 该图片为一张实物照片，展示了一个圆形的网格半波片（Mesh
// HWP）原型器件。图像视角为低角度侧视，背景由两部分组成：
// 下方是浅棕色带有水平木纹纹理的木质桌面，上方是纯红色的
// 背景墙。 主体物体是一个平放的圆盘状结构，位于画面中央。
// 该圆盘顶面呈现均匀的灰白色，表面平整光滑。从侧面观察，
// 圆盘具有明显的厚度，其侧壁呈现出深褐色或红褐色，与顶面
// 的浅色形成对比。在深色侧壁上，可以观察到细微的垂直纹理
// 或分层痕迹，这对应于内部嵌入的电感和电容网格堆叠结构。
// 圆盘边缘切割整齐，底部与木质桌面接触处有轻微的阴影。整
// 个装置看起来非常薄，符合图注中提到的约1毫米厚度的描述。
// 该原型设计用于在100至300 GHz的频率范围内工作。
// [figvision-cn] imgs/HWP.png
// 该图片为一张实物照片，展示了一个圆形的网格半波片（Mesh
// HWP）原型器件。图像视角为低角度侧视，背景由两部分组成：
// 下方是浅棕色带有水平木纹纹理的木质桌面，上方是纯红色的
// 背景墙。 主体物体是一个平放的圆盘状结构，位于画面中央。
// 该圆盘顶面呈现均匀的灰白色，表面平整光滑。从侧面观察，
// 圆盘具有明显的厚度，其侧壁呈现出深褐色或红褐色，与顶面
// 的浅色形成对比。在深色侧壁上，可以观察到细微的垂直纹理
// 或分层痕迹，这对应于内部嵌入的电感和电容网格堆叠结构。
// 圆盘边缘切割整齐，底部与木质桌面接触处有轻微的阴影。整
// 个装置看起来非常薄，符合图注中提到的约1毫米厚度的描述。
// 该原型设计用于在100至300 GHz的频率范围内工作。
#figure(placement: top, [#box(image("imgs/HWP_section.png", height: 45mm, width: 55mm)) #box(image("imgs/HWP.png", height: 40mm, width: 65mm))

  ],
  caption: [
    #emph[Left]: Model showing a small portion of a mesh-HWP with the embedded stacks of capacitive and inductive grids. #emph[Right]: Mesh HWP prototype working between 100 and 300~GHz and being around $3 med "m" "m"$ thick.
  ]
)
<fig:HWP>


The rotation mechanisms have the same design for both MFT and HFT, and shall meet several stringent requirements, in terms of mass ($< 20 med "kg"$), dimension ($< 200 med "m" "m"$ and $< 300 med "m" "m"$), stiffness, power dissipation ($< 4 med "m" "W"$), HWP temperature ($< 20 med "K"$~#cite(<Columbro2019>)), and TRL, for the levitation, driving, and gripping mechanisms, as well as position encoder.


// [figvision-cn] imgs/PMU_overview.png
// 该子图包含左右两个并列的视图，展示PMU（永磁电机）的设
// 计细节。 左侧视图为PMU的整体俯视图，采用三维透视示意图
// 形式，其中线圈环已被移除以显示转子边缘的编码器。图中主
// 体为一个环形结构，外圈为灰色金属外壳，内圈为白色空腔。
// 在环形结构的外缘均匀分布有三个红色圆柱形部件，标注为“
// Launch lock x3”，表示共有三个发射锁紧装置。在环形结构
// 的右侧外缘有一个黑色矩形模块，标注为“Encoder”，表示位
// 置编码器。在环形结构的底部外缘有一个黄色与黑色相间的夹
// 具状部件，标注为“Clamp x3”，表示共有三个夹持装置。在环
// 形结构的内部中心区域，有一条双向箭头线段，标注文字为“
// MFT - 320mm”和“HFT - 220mm”，分别指示最大飞行轨迹直径
// 为320毫米，最小飞行轨迹直径为220毫米。 右侧视图为PMU的
// 横截面示意图，展示其内部层叠结构。从外到内依次为：最外
// 层为灰色外壳，向内为白色绝缘层，再向内为深灰色磁钢层，
// 最内层为浅灰色转子铁芯。各层之间界限清晰，呈同心圆排列。
// 该视图未标注具体尺寸或材料名称，但通过颜色区分不同功能
// 层，传达出PMU具有多层复合结构的设计特点。
// [figvision-cn] imgs/PMU_overview.png
// 该子图包含左右两个并列的视图，展示PMU（永磁电机）的设
// 计细节。 左侧视图为PMU的整体俯视图，采用三维透视示意图
// 形式，其中线圈环已被移除以显示转子边缘的编码器。图中主
// 体为一个环形结构，外圈为灰色金属外壳，内圈为白色空腔。
// 在环形结构的外缘均匀分布有三个红色圆柱形部件，标注为“
// Launch lock x3”，表示共有三个发射锁紧装置。在环形结构
// 的右侧外缘有一个黑色矩形模块，标注为“Encoder”，表示位
// 置编码器。在环形结构的底部外缘有一个黄色与黑色相间的夹
// 具状部件，标注为“Clamp x3”，表示共有三个夹持装置。在环
// 形结构的内部中心区域，有一条双向箭头线段，标注文字为“
// MFT - 320mm”和“HFT - 220mm”，分别指示最大飞行轨迹直径
// 为320毫米，最小飞行轨迹直径为220毫米。 右侧视图为PMU的
// 横截面示意图，展示其内部层叠结构。从外到内依次为：最外
// 层为灰色外壳，向内为白色绝缘层，再向内为深灰色磁钢层，
// 最内层为浅灰色转子铁芯。各层之间界限清晰，呈同心圆排列。
// 该视图未标注具体尺寸或材料名称，但通过颜色区分不同功能
// 层，传达出PMU具有多层复合结构的设计特点。
#figure(placement: top, [#box(image("imgs/PMU_overview.png", height: 50mm, width: 55mm)) #box(image("imgs/PMU_section.png", height: 50mm, width: 65mm))

  ],
  caption: [
    #emph[Left]: Overview of the PMU design. The coil rings are removed to show the encoder on the edge of the rotor. #emph[Right]: PMU cross-section.
  ]
)
<fig:PMU_design>


A very low friction superconducting magnetic bearing~#cite(<Johnson2017>) based on the magnetic levitation between a YBCO superconductor ring (stator) and an SmCo (Samarium-Cobalt) permanent magnet ring (rotor) hosts the HWPs (@fig:PMU_design).


The rotation is driven by an electromagnetic motor, based on the interaction between eight small cylindrical SmCo magnets placed on the edge of the rotor and 64 high purity copper coils placed on the stator. The motor magnets and the hysteresis in the main magnet assembly are the main contributions to the power load on the 5-K stage and must be minimized as much as possible. In addition, the eddy currents induced by the motor coils heat up the rotor, which can be cooled down only by radiation, a process that is not very efficient at cryogenic
temperatures. The total heat load expected #emph[from both mechanisms] is 2.8 mW, which is within the requirement, with a 40 % margin.


The rotor temperature is monitored by capacitive sensors~#cite(<PdB_levitation_measurement2020>) (3 % accuracy), which are also used to monitor the levitation height and the wobble of the rotor (10~μm resolution). A thermal model built by Comsol Multiphysics#footnote[#link("https://www.comsol.com")] shows that after a slow rise the equilibrium temperature should be approximately $16 med "K"$ for both modulators, assuming HWP emissivities of 0.02 and 0.03 for MFT and HFT, respectively, while the assumed emissivity of aluminum is 0.5, achievable with a blackened surface~#cite(<Columbro_SPIE>)


The position readout system uses an optical encoder, with 64 precision slits in the rotor ring periphery. The light from a warm temperature modulated LED is transferred to the rotor via an optical fiber, and the light transmitted through the slits is transferred back to a warm temperature detector via another optical fiber. This configuration minimizes the heat load on the different stages of the cryogenic system~#cite(<2011AA...528A.138S>). The expected angular encoding accuracy is better than 0.1 arcmin and can be improved through a Kalman filter using
the high rotation stability ($< 1 med "m" "Hz"$) and the inertia of the system. A simple and reliable clamp/release system~#cite(<Columbro2018>) (with zero power dissipation while holding the rotor, and zero power dissipation when the rotor is released) has been developed. It is expected to be used only once at the beginning of the flight, nevertheless the system was designed to be able to clamp and release the rotor as many times as needed.


==== Lens components
<lens-components>
The baseline design employs lenses manufactured from polypropylene, and anti-reflection coating with a matching layer of porous ptfe. This coated lens technology has been well characterized and validated through an extensive ESA-funded Technical Research Programme. Lenses of similar sizes have been previously manufactured by members of the project team, and successfully deployed on suborbital CMB polarimetry experiments. In addition, porous PTFE coated lenses have also been deployed in space on the #emph[Herschel]-SPIRE satellite instrument. As such, the
coated lenses demonstrate a high level of technical maturity, operating in a cryogenic vacuum environment. However, over the coming months, we will additionally undertake a significant program of precision characterization of these materials at cryogenic temperature (losses, stress-induced birefringence, etc.).


==== Absorbers
<absorbers>
While far-infrared filters will mainly be used to prevent out-of-band radiation from propagating into the telescope, optical absorbers will also be used to prevent or mitigate spurious in-band reflections across the optics tubes. The need for a reliable, light, thermally uniform, space-qualified material has been recognized as a driver for a dedicated study, meant to investigate a set of candidate absorbing materials and/or metamaterial structures. This study will compare traditional absorber candidates such as Thomas-Keating tiles or Eccosorb HR10/AN72
to micromachined, 3D-printed, and injection molded metamaterials ~#cite(<Wollack2014>) #cite(<Wollack2016>) #cite(<Petroff2019>) #cite(<Xu2021>). The study will include detailed laboratory measurements and commensurate electromagnetic simulations of the candidate absorbers spanning the entire MHFT frequency range. The results of this work will allow us to perform a tradeoff study to select the best solution for absorbers.


==== Filtering scheme
<filtering-scheme>
Although band definition is achieved via on-chip filtering, additional optical filters are required in order to control the out-of-band rejection level, to protect the detectors from straylight and to control the thermal environment. For MFT we are proposing deployment of a chain of four low-pass filters positioned at the 4.8-K, 2-K, 300-mK, and 100-mK stages. It is noted that the HWP also acts as a low-pass filter and we have the option of adding a high-pass element at the detectors should this be required. The average in-band transmission over the
frequency range of the MFT (or HFT) for each of these elements can be targeted to be 95 %.


==== Mechanical structure
<mechanical-structure>
The mechanical structure is composed of two main parts: the two telescope tubes; and an exoskeleton. The telescope tubes are designed to hold the optical elements and the various subsystems, and to ensure optical alignment for each of the two telescopes. The exoskeleton holds the two tubes, connects the telescopes to the payload module and provides the thermal link to the cryochain. All the mechanical elements are made of material compliant with the optical, mechanical, and thermal constraints, such as aluminum and CFRP.


A first series of iterations on the mechanical design has been performed to optimize the mechanical structure, taking into account the various constraints such as minimum eigen-frequencies, total mass, launch load, and thermal conduction (design shown on the left side of @fig:Meca1). In the initial design, the mass of the MHFT is about 118 kg without margins, which is over the allocated 100 kg value. This specification on the mass is mostly driven by the parasitic heat load on the 4.8-K stage due to the thermal conductance of the satellite mechanical structure holding both LFT and MHFT.


// [figvision-cn] imgs/2020_10_22_structure_1.png
// 这是一张三维计算机辅助设计（CAD）示意图，展示了MHFT机
// 械结构的一种设计方案。该方案基于卫星在4.8开尔文（K）温
// 级的机械接口。 整体布局： 图像中心是一个由浅灰色桁架结
// 构支撑的复杂仪器组件，该组件安装在底部的三脚支架上。整
// 个装置相对于水平面呈倾斜姿态。 主要组件描述： HFT望远
// 镜：位于图像左上方，是一个圆柱形光学器件。其最前端是淡
// 蓝色的锥形反射镜或遮光罩，向后连接一个红棕色的环形法兰
// 盘，再连接到米黄色的筒身。该组件被标记为“HFT”。 MFT望
// 远镜：位于图像右上方，与HFT并列安装。其最前端是紫红色
// 的锥形部件，内部可见白色的十字形支撑结构。该组件通过黄
// 绿色的法兰盘和深红色的筒身连接到主结构上。该组件被标记
// 为“MFT”。 低温恒温器/屏蔽层：在HFT和MFT的后方及下方，
// 可以看到两个较大的淡黄色圆柱体，它们构成了仪器的低温部
// 分或热屏蔽层。 支撑结构： 中央框架：一个浅灰色的多边形
// 桁架结构，用于固定HFT、MFT以及后方的圆柱体。 三脚支架：
// 从中央框架向下延伸出三条主要的橙色支柱，形成三脚架形态。
// 这些支柱之间还有紫色的交叉支撑杆件以增加稳定性。 支脚：
// 每条橙色支柱的末端都连接着一个绿色的圆形法兰盘状支脚，
// 用于将仪器固定在卫星平台上。 其他支撑杆：除了主要的橙
// 色支柱外，还有一根细长的米色杆件从左侧的淡黄色圆柱体延
// 伸至底部绿色支脚附近，提供额外的支撑。 标注文字： “HFT
// ”：黑色粗体字，位于左上方蓝色锥体旁。 “MFT”：黑色粗体
// 字，位于右上方紫色锥体旁。 “4.8 K interface”：位于图像
// 左下角。其中“4.8 K”字体较大，“interface”在其下方。有一
// 条黑色的双向箭头线，从文字指向底部的三个绿色支脚，表明
// 这些支脚是4.8 K温级的机械接口位置。 坐标轴指示：在底部
// 中央偏左的位置，有一个小型的三维坐标系符号，显示了x轴
// 的方向。 颜色映射： 图中不同颜色的部件代表不同的功能模
// 块或材料属性，但图例未明确说明具体对应关系。通常在这种
// 工程图中，颜色用于区分不同的子系统或组件。 结论： 该图
// 清晰地展示了MHFT仪器的一种机械结构设计，重点突出了其在
// 4.8 K温级与卫星平台的连接方式。通过三脚支架和多个支撑
// 杆件，确保了HFT和MFT等精密光学元件的稳定性和对准精度。
// [figvision-cn] imgs/2020_10_22_structure_1.png
// 这是一张三维计算机辅助设计（CAD）示意图，展示了MHFT机
// 械结构的一种设计方案。该方案基于卫星在4.8开尔文（K）温
// 级的机械接口。 整体布局： 图像中心是一个由浅灰色桁架结
// 构支撑的复杂仪器组件，该组件安装在底部的三脚支架上。整
// 个装置相对于水平面呈倾斜姿态。 主要组件描述： HFT望远
// 镜：位于图像左上方，是一个圆柱形光学器件。其最前端是淡
// 蓝色的锥形反射镜或遮光罩，向后连接一个红棕色的环形法兰
// 盘，再连接到米黄色的筒身。该组件被标记为“HFT”。 MFT望
// 远镜：位于图像右上方，与HFT并列安装。其最前端是紫红色
// 的锥形部件，内部可见白色的十字形支撑结构。该组件通过黄
// 绿色的法兰盘和深红色的筒身连接到主结构上。该组件被标记
// 为“MFT”。 低温恒温器/屏蔽层：在HFT和MFT的后方及下方，
// 可以看到两个较大的淡黄色圆柱体，它们构成了仪器的低温部
// 分或热屏蔽层。 支撑结构： 中央框架：一个浅灰色的多边形
// 桁架结构，用于固定HFT、MFT以及后方的圆柱体。 三脚支架：
// 从中央框架向下延伸出三条主要的橙色支柱，形成三脚架形态。
// 这些支柱之间还有紫色的交叉支撑杆件以增加稳定性。 支脚：
// 每条橙色支柱的末端都连接着一个绿色的圆形法兰盘状支脚，
// 用于将仪器固定在卫星平台上。 其他支撑杆：除了主要的橙
// 色支柱外，还有一根细长的米色杆件从左侧的淡黄色圆柱体延
// 伸至底部绿色支脚附近，提供额外的支撑。 标注文字： “HFT
// ”：黑色粗体字，位于左上方蓝色锥体旁。 “MFT”：黑色粗体
// 字，位于右上方紫色锥体旁。 “4.8 K interface”：位于图像
// 左下角。其中“4.8 K”字体较大，“interface”在其下方。有一
// 条黑色的双向箭头线，从文字指向底部的三个绿色支脚，表明
// 这些支脚是4.8 K温级的机械接口位置。 坐标轴指示：在底部
// 中央偏左的位置，有一个小型的三维坐标系符号，显示了x轴
// 的方向。 颜色映射： 图中不同颜色的部件代表不同的功能模
// 块或材料属性，但图例未明确说明具体对应关系。通常在这种
// 工程图中，颜色用于区分不同的子系统或组件。 结论： 该图
// 清晰地展示了MHFT仪器的一种机械结构设计，重点突出了其在
// 4.8 K温级与卫星平台的连接方式。通过三脚支架和多个支撑
// 杆件，确保了HFT和MFT等精密光学元件的稳定性和对准精度。
#figure(placement: top, [#block[
  #figure(
    align(center)[#table(
    stroke: none,
      columns: 2,
      align: (center,center,),
    table.hline(stroke: 0.8pt),
      [#box(image("imgs/2020_10_22_structure_1.png", height: 5cm))], [#box(image("imgs/structure_ISO.png", height: 5cm))],
    table.hline(stroke: 0.8pt),
    table.hline(stroke: 0.5pt),
    )]
    , kind: table
    )

  ]],
  caption: [
    Two options of the MHFT mechanical structure design based on a mechanical interface with the satellite at the 4.8-K stage (Left), and at the 30-K stage (Right).
  ],
  kind: image,
)
<fig:Meca1>


To deal with the stringent constraints on the total mass budget at 4.8 K, we decided to study another option, which consists of moving the mechanical interface with the satellite from the 4.8-K stage to the 30-K stage of the PLM. The total mass budget has been revised in the framework of this second option. The heavy 4.8-K interface ring, shared by LFT and MHFT in the first option design, has now been replaced by two 30-K to 4.8-K optimized cryomechanical structures made of CFRP. We designed the 30-K to 4.8-K cryomechanical structure with particular
attention to the thermal conductance. The design of the MHFT tubes is similar to the first option (design shown in the right panel of @fig:Meca1). This solution allows us to drastically reduce the mass of the 4.8-K interface with the satellite, while minimizing the parasitic heat load on the coldest stages. The study of this mechanical structure design shows that the constraints on the eigen-frequencies and on the parasitic heat-load are satisfied.


== Detection Chain
<ss:plm_detection>


#emph[LiteBIRD] will be equipped with 1030 multi-chroic pixels sensitive to polarization, totaling 4508 tess, distributed over the three focal planes of LFT, MFT, and HFT. Detector specifications for each of the #emph[LiteBIRD] bands are show in @tbl:bolospecsgeneral and @tbl:bolospecsbands. The detection chains of the three telescopes have been designed using a very similar architecture that is described in this section for the three telescopes. It includes focal planes and associated readout electronics, both cold and warm parts. More details on the
design and fabrication of the detector modules can be found in Ref.~#cite(<Westbrook2020SPIE>)


#figure(
  align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header([Parameter], [Design value],),
    table.hline(),
    [TES normal resistance], [1.0 #strong[]],
    [TES operating resistance], [0.6--0.8 $Omega$],
    [Parasitic series resistance], [0.05--0.2 $Omega$],
    [FPU ($T_b$)], [0.100 K],
    [Transition temperature ($T_c$)], [0.171 K],
    [Cross wafer $T_c$ variation], [$lt.eq$ 7 %],
    [Minimum operating power], [$2.5 times$ optical power],
    [Pixel in-band optical efficiency], [$gt.eq 70$ %],
    [Thermal carrier], [Phonon ($n = 3$)],
    [Intrinsic time constant ($tau_0$)], [33 ms],
    [Loopgain during operation], [$gt.eq 10$],
    [Common 1/$f$ knee], [$lt.eq 20$ mHz],
    [FPU lifetime], [$gt.eq 3$ years],
    [On-sky end-to-end yield], [$gt.eq$ 80 %],
  )]
  , caption: [Summary of the common optical and bolometric design goals of the #emph[LiteBIRD] detectors. We expect that there will be little deviation from these goals during the development of the FPUs for .]
  , kind: table
  ) <tbl:bolospecsgeneral>



#figure(
  align(center)[#table(
    stroke: none,
    columns: 5,
    align: (center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Pixel ID], [Frequency [GHz]], [Bolometer count], [Bandwidth $Delta_nu \/ nu$], [$P_("opt")$ [pW]]),
    table.hline(),
    [LF1], [#text(fill: rgb(127,9,9))[40/60/78]], [48], [0.30 / 0.23 / 0.23], [0.358 / 0.300 / 0.303],
    [LF2], [#text(fill: rgb(103,102,1))[50/68/89]], [24], [0.30 / 0.23 / 0.23], [0.386 / 0.302 / 0.311],
    [LF3], [#text(fill: rgb(1,102,1))[68/89/119]], [144], [0.23 / 0.23 / 0.30], [0.367 / 0.363 / 0.449],
    [LF4], [#text(fill: rgb(3,4,120))[78/100/140]], [144], [0.23 / 0.23 / 0.30], [0.367 / 0.356 / 0.440],
    [MF1], [#text(fill: rgb(127,9,9))[100/140/195]], [366], [0.23 / 0.30 / 0.30], [0.411 / 0.463 / 0.386],
    [MF2], [#text(fill: rgb(103,102,1))[119/166]], [488], [0.30 / 0.30], [0.496 / 0.416],
    [HF1], [#text(fill: rgb(127,9,9))[195/280]], [254], [0.30 / 0.30], [0.782 / 0.486],
    [HF2], [#text(fill: rgb(1,102,1))[235/337]], [254], [0.30 / 0.30], [0.603 / 0.384],
    [HF3], [#text(fill: rgb(3,4,120))[402]], [338], [0.23], [0.290],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Optical specifications for the #emph[LiteBIRD] detectors. The values listed in this table flow down from the noise specifications listed in @tbl:plm:sensitivities]
  , kind: table
  ) <tbl:bolospecsbands>



=== Focal-Plane Units
<sss:detection_fpu>
LiteBIRD will deploy for each of the telescopes an FPU, which consists of the following components: (i) a fps providing thermal insulation from the jt4 and thermal connections to the jt2 and skadr, which provide the cooling power to the intermediate temperature stages, cooled down to 1.75 K, 350 mK, and 100 mK; (ii) and a set of individual arrays of detectors, the FPM, operated at 100 mK. Each FPM consists of a single detector array, optical coupling hardware (lenslet or horn arrays, backshort wafers, etc.), the cru, and mechanical structures that hold
these parts together and provide an interface to the fps.


=== Focal-Plane Modules
<sss:detection_fpm>


// [figvision-cn] imgs/FPUs_with_Scale_Bar.png
// 该图包含三个子图，分别展示了低频（LF）、中频（MF）和高
// 频（HF）焦平面单元的结构示意图。所有子图均为三维透视图，
// 从侧上方视角展示望远镜筒内部及其底部的探测器阵列布局。
// 图像底部中央有一个长度为300毫米的黑色比例尺。 子图 a)
// LF-FPU： 类型：结构示意图。 物体与布局：展示了一个长方
// 体形状的黑色金属外壳，其顶部开口，内部底部安装有一个矩
// 形的焦平面组件。该组件由多个正方形平铺模块组成一个大的
// 矩形阵列。每个正方形模块表面覆盖着排列整齐的像素点阵。
// 颜色编码与物理含义：像素根据类型分为四种颜色。红色像素
// 位于左下角和右上角的模块区域；绿色像素位于中间下方的两
// 个模块区域；蓝色像素位于中间上方的左侧模块区域；黄色像
// 素位于左上角和右上角的部分区域。这些颜色对应不同类型的
// 探测单元。 标注文字：子图下方标注有“a) LF-FPU”。 子图
// b) MF-FPU： 类型：结构示意图。 物体与布局：展示了一个
// 圆柱形或圆台形的黑色金属外壳，内部底部安装有一个圆形的
// 焦平面组件。该组件由多个正六边形模块以紧密堆积的方式排
// 列成一个近似圆形的大阵列。每个六边形模块表面同样覆盖着
// 密集的像素点阵。 颜色编码与物理含义：像素颜色分布呈现
// 中心对称或分区特征。中心区域主要由红色像素组成的六边形
// 模块占据；外围环绕着由绿色像素组成的六边形模块。 标注
// 文字：子图下方标注有“b) MF-FPU”。 子图 c) HF-FPU： 类
// 型：结构示意图。 物体与布局：展示了一个尺寸较小的圆柱
// 形或圆台形黑色金属外壳，内部底部安装有一个小型的圆形焦
// 平面组件。该组件仅由三个正六边形模块组成，呈品字形排列
// （一个在上，两个在下），彼此紧密接触。 颜色编码与物理
// 含义：顶部的六边形模块由绿色像素组成；左下方的六边形模
// 块由粉红色（或洋红色）像素组成；右下方的六边形模块由蓝
// 色像素组成。 标注文字：子图下方标注有“c) HF-FPU”。
#figure(placement: top, image("imgs/FPUs_with_Scale_Bar.png", width: 100.0%),
  caption: [
    Low-, Mid-, and High-Frequency Focal-Plane Units. The LF-FPU rectangular shape is matched to the LFT's oblong FoV using square FPM tiles. The Mid- and High-Frequency Telescopes both have circular fovs and therefore employ hexagonal arrays arranged in a close-packed pattern. Pixel types are color coded and the details of each can be found in Table #ref(<tbl:focalplanes>, supplement: none)
  ]
)
<fig:focalplanes>


#figure(
  align(center)[#table(
    columns: 8,
    align: (center,center,center,center,center,center,center,center,),
    table.header([Telescope], [Detector type], [Module], [Frequency [GHz]], [Pixel size [mm]], [Module count], [Pixel count], [Detector count]),
    table.hline(),
    [LFT], [Lenslet/ Sinuous], [LF12], [#text(fill: rgb(127,9,9))[40/60/78]], [32], [4], [24], [144],
    [], [], [], [#text(fill: rgb(103,102,1))[50/68/89]], [32], [], [12], [72],
    [], [], [LF34], [#text(fill: rgb(1,102,1))[68/89/119]], [16], [4], [72], [432],
    [], [], [], [#text(fill: rgb(3,4,120))[78/100/140]], [16], [], [72], [432],
    [], [], [], [], [Total LFT], [8], [180], [1080],
    [MFT], [Lenslet/ Sinuous], [MF1], [#text(fill: rgb(127,9,9))[100/140/195]], [11.6], [3], [183], [1098],
    [], [], [MF2], [#text(fill: rgb(103,102,1))[119/166]], [11.6], [4], [244], [976],
    [], [], [], [], [Total MFT], [7], [607], [2074],
    [HFT], [Horn/ OMT], [HF1], [#text(fill: rgb(127,9,9))[195/280]], [6.6], [1], [127], [508],
    [], [], [HF2], [#text(fill: rgb(1,102,1))[235/337]], [6.6], [1], [127], [508],
    [], [], [HF3], [#text(fill: rgb(3,4,120))[402]], [5.7], [1], [169], [338],
    [], [], [], [], [Total HFT], [3], [423], [1354],
    [], [], [], [], [Total mission], [18], [1210], [4508],
  )]
  , caption: [Focal-plane configurations for the lffpu, mffpu, and hffpu. The colors in the frequency column correspond to those in @fig:focalplanes]
  , kind: table
  ) <tbl:focalplanes>



The FPMs of #emph[LiteBIRD] are filled with arrays of lenslet- or horn-coupled TES bolometers fabricated on silicon wafers coupled to a multiplexed readout system. The telescope designs drive the focal plane layouts; the LFT FPU is rectangular to match the oblong illumination pattern of the crossed-Dragone telescope design, while the MFT and HFT FPUs are hexagonal arrays that pack the pixels most efficiently into the axisymmetric MFT and HFT refractive telescopes, as shown in @fig:focalplanes. The electromagnetic coupling structures for each focal plane
are based on the most mature technology for the specific frequency ranges and required bandwidths. The LFT and MFT FPMs share a common architecture of lenslet-coupled sinuous antennas, while the HFT FPMs use horn-coupled orthomode transducers. The dual-polarization antennas of each pixel are coupled to on-chip microstrip bandpass filters that split the signal into two or three frequency bands. The separated signals propagate along superconducting microstrip lines and thermally dissipate at tess on thermally isolated islands for each frequency band and
polarization state. TES electrical bias lines carry the induced signal to the edge of the silicon wafer where it is wire-bonded to a flexible circuit leading to the cold readout. An overview of the two detector architectures is given in @fig:detector_architecture. The TES technology is able to reach the instantaneous sensitivity required by the #emph[LiteBIRD] mission and is a mature design technology for ground-based and sub-orbital CMB experiments heritage~#cite(<arnold2010polarbear>). A demonstration of the noise equivalent power of a prototype AlMn
TES bolometer operated at 100 mK is shown in @fig:tesnoisedemo. The readout used for these measurements utilizes an older DfMux system with SQUIDs at 4.8 K.


// [figvision-cn] imgs/detector_architecture_2.png
// 该图展示了LiteBIRD探测器阵列的两种主要类型：透镜耦合探
// 测器（上半部分）和喇叭耦合探测器（下半部分）。 子图1)
// 类型：三维结构示意图。 描述：展示了一个单个透镜耦合探
// 测器的结构分解图。主体是一个透明的半球形透镜，位于一个
// 矩形基座上方。在透镜正下方是探测器芯片，芯片中心有一个
// 螺旋状的微带天线图案。图中包含三条正交的坐标轴线，分别
// 用红色、绿色和蓝色表示，用于指示空间方向。该图说明了透
// 镜如何将光聚焦到下方的螺旋天线上。 子图2) 类型：显微照
// 片。 描述：展示了一个微加工的蛇形天线耦合探测器的实物
// 照片。背景为粉色。图像中央是一个由同心圆环构成的圆形蛇
// 形天线。在天线的左上、左下和右侧各分布着一个细长的矩形
// 组件，这些组件内部有深色的电路走线。整个器件表面覆盖着
// 精细的网格状金属布线。 子图3) 类型：实物照片。 描述：
// 展示了一个加工好的单晶硅透镜阵列。该阵列呈六边形，安装
// 在一个金色的金属框架内。黑色的基底上整齐排列着数百个微
// 小的半球形透镜，形成密集的矩阵结构。光线照射下，每个小
// 透镜顶部都有反光点。 子图4) 类型：实物照片。 描述：展
// 示了一个镀金的探测器支架及其内部的微加工探测器阵列。支
// 架呈八边形或十二边形的笼状结构，颜色为金色。支架内部承
// 载着一块绿色的基板，上面布满了规则排列的微小像素点，对
// 应探测器单元。 子图5) 类型：三维结构示意图。 描述：展
// 示了一个喇叭耦合探测器的波导结构。这是一个圆锥形的波纹
// 喇叭，从上到下逐渐收缩。底部连接着一个方形的波导截面，
// 截面内部显示了交叉的极化图案。左侧标注了比例尺，刻度从
// 0到4毫米，显示该结构的尺寸范围。 子图6) 类型：二维俯视
// 示意图。 描述：展示了探测器模块的平面布局。整体呈菱形。
// 中心是一个粉红色的圆形区域，内部有一个白色的四叶草形状
// （标记为b），这是辐射接收区。围绕中心区域的是多层不同
// 颜色的几何图形（紫色、绿色等），代表不同的电路层或屏蔽
// 层。图中标注了a、b、c、d、e五个字母，分别指向边缘、中
// 心辐射器、连接线等不同部件。 子图7) 类型：实物照片。
// 描述：展示了一个完整的六边形高频段探测器阵列面板。面板
// 表面呈现出彩虹般的干涉色，表明其具有薄膜涂层或特殊的光
// 学处理。面板上布满了规则的六边形网格孔洞或像素单元。中
// 心有一个明显的十字形标记。 子图8) 类型：实物照片。 描
// 述：展示了另一个角度的六边形探测器阵列，安装在带有螺丝
// 孔的金属板上。基板呈金黄色，表面覆盖着密集的微米级结构。
// 右下角放置了一把标有“NIST”字样的尺子作为参照，刻度显示
// 1厘米的长度，表明该阵列的整体尺寸约为几厘米见方。
#figure(placement: top, image("imgs/detector_architecture_2.png", width: 100.0%),
  caption: [
    #emph[LiteBIRD] detector arrays consist of lenslet-coupled arrays for the LF- and MF-FPUs and horn-coupled detector arrays for the HF-FPU. The individual sub-figures show: (1) a single lenslet-coupled detector; (2) photograph of a microfabricated sinuous antenna-coupled detector; (3) a machined monolithic silicon lenslet array; (4) a microfabricated detector array in a gold-plated detector holder; (5) a single horn-coupled detector; (6) an optical micrograph of a detector with labeled components being (a) planar OMT, (b) coplanar waveguide to
microstrip transition, (c) diplexer, (d) 180 hybrid, and (e) TES bolometer; (7) a photograph of a 432-element array of dichroic horn-coupled detectors and mating; and (8) a silicon platelet feedhorn array.
  ]
)
<fig:detector_architecture>


// [figvision-cn] imgs/TES_noise_demo_cropped.png
// 这是一张双对数坐标曲线图，展示了100毫开尔文（mK）过渡
// 边缘传感器（TES）的噪声等效功率（NEP）随频率变化的特性。
// 横坐标为“Frequency (Hz)”，即频率，单位为赫兹（Hz），采
// 用对数刻度，范围从$10^0$ Hz（1 Hz）延伸至$10^2$ Hz（
// 100 Hz）。主刻度线标记在1、10和100处。纵坐标为“NEP ($
// aW/\sqrt{Hz}$)”，即噪声等效功率，单位为阿瓦特每根号赫
// 兹（$aW/\sqrt{Hz}$），同样采用对数刻度，主要刻度线标记
// 在$10^1$处。图中包含两条灰色辅助网格线：一条垂直线位于
// 10 Hz处，一条水平线位于$10^1$ $aW/\sqrt{Hz}$处。 图例
// 位于右上角，包含三项说明： Data：对应蓝色实线。这条曲
// 线代表实验测量数据。在低频段（约1 Hz至5 Hz），曲线波动
// 剧烈，存在数个明显的尖峰，最高峰值超过$10^1$ $aW/\sqrt
// {Hz}$。随着频率增加，曲线逐渐平稳，在10 Hz至80 Hz范围
// 内呈现白噪声特征，数值围绕6 $aW/\sqrt{Hz}$上下波动。在
// 接近90 Hz时，曲线急剧下降，表明截止频率或滤波器效应。
// NEP: 6.0 aW/$\sqrt{Hz}$：对应绿色实线。这是一条水平直
// 线，横跨图表的中高频区域（约10 Hz至80 Hz），其纵坐标值
// 固定在6.0 $aW/\sqrt{Hz}$，用于标示该器件在白噪声区域的
// 平均性能水平。 Target Range：对应红色半透明矩形区域。
// 该区域横跨整个频率轴，纵坐标范围大致从4 $aW/\sqrt{Hz}$
// 延伸至7 $aW/\sqrt{Hz}$。这代表了LiteBIRD项目对该频段读
// 出的目标噪声指标范围。 该子图传达的主要结论是：所测试
// 的TES器件在10 Hz至80 Hz的频率范围内表现出平坦的白噪声
// 性能，其噪声水平约为6.0 $aW/\sqrt{Hz}$，完全落入并覆盖
// 了LiteBIRD项目的目标范围（红色区域）。此外，所使用的
// 0.5 pW偏置功率符合LiteBIRD最低功率波段的要求。
#figure(placement: top, image("imgs/TES_noise_demo_cropped.png", width: 80.0%),
  caption: [
    Demonstration of a 100-mK TES with white noise performance in the #emph[LiteBIRD] target range for readout and phonon noise contributions in the different frequency bands. The 0.5-pW bias power used is consistent with the lowest power band in #emph[LiteBIRD].
  ]
)
<fig:tesnoisedemo>


Cosmic-ray mitigation is integrated directly into the focal-plane design to limit cosmic-ray impacts on low-$ell$ systematics and data loss, described in detail in @sec:CR-systematics. The transient energy deposition of cosmic rays interacting with the spacecraft can create glitches in the timestream of data sent to the readout system. It is known from the #emph[Planck]~mission that long timescale glitches are produced when cosmic rays interact with the silicon die and short pulse-like glitches result from interactions close to the
thermistor~#cite(<Catalano2014a>). This has yielded a strategy of increasing thermal conductivity between the silicon die and the focal-plane structures to reduce long timescale thermal fluctuations and blocking phonon propagation to the TES for the short glitches. Progress in the lab has been made in blocking the ballistic phonons near the TES by removing and adding metal layers and etching silicon. Tests with radioactive sources in the lab have shown phonon blocking effects by interrupting the phonon conduction paths to the TES~#cite(<beckman2018>).
The array will have dark TES channels interspersed throughout the array to help monitor and remove common-mode fluctuations in the detector responses across the wafer.


=== Focal-Plane Structures
<sss:detection_structure>


Each fps contains two intermediate temperature stages at 1.8 K and 300 mK, between the FPUs at 100 mK and the 4.8-K telescope structures. A free-space low-pass edge filter and a fph are supported by the 1.8-K stage. An aluminized thin film spans the interstage gaps to block RF and residual warm radiation. The requirements include a thermal budget for each stage and mechanical performance to survive launch loads and keep resonances clear of the science band while in operation. Our current baseline includes aluminum, titanium, and copper metalic parts and
CFRP inter-stage support struts. A trade study is in progress to determine whether struts can be designed to survive launch loads without launch locks.


== Readout
<s:readout>
The TES bolometers will be read out using DfMux #cite(<Dobbs2012>). In a DfMux system, each TES is placed in series with an inductor-capacitor (LC) bandpass filter, which separates out the individual biasing sinusoids, allowing the detectors to be operated independently (see @fig:dfmux). In such a system, the TES biasing voltages are provided by sinusoids at MHz frequencies. Up to 68 of these biases are summed together and transmitted to the detector array over a single set of wires, substantially reducing the conductive heat load and enabling large TES focal planes.#footnote[]


The multiplexing factor of $68 times$ is determined largely by the cryogenic electronics design. The digital electronics and associated firmware can support up to $128 times$ multiplexing.






Each TES varies in resistance in response to incident radiative power, amplitude-modulating the biasing tones. Our sky signal is contained in the sidebands, analogous to the way AM radio works.

The resulting current waveforms are amplified using a cryogenic SAA, before being transmitted to non-cryogenic electronics to be further amplified and digitally demodulated. The TES bolometers, LC resonators, SAA, and bias elements are all on the 100-mK cryogenic stage and will be discussed in Sect.~#ref(<ss:cr>, supplement: none)


The #emph[LiteBIRD] implementation of DfMux has over a decade of development and design, spanning four separate implementations deployed on four ground-based telescopes and one balloon-borne telescope~#cite(<Dobbs2008>) #cite(<arnold2010polarbear>) #cite(<Dobbs2012>) #cite(<deHaan2012>) #cite(<Kaneko2020>) #cite(<Bender2014>) #cite(<Carter2018>) #cite(<EBEX2018>) #cite(<montgomery_2015>) #cite(<Montgomery:PhD>)


The success of DfMux is the ability to multiplex large numbers of detectors without a substantial increase in system noise, maintaining the photon-noise limited performance of the instrument as a whole. The #emph[LiteBIRD] design is based on, and improves upon, the design currently used in the SPT-3G (South-Pole Telescope 3rd Generation) instrument, which has demonstrated $68 times$ multiplexing with detector-limited noise performance~#cite(<Carter2018>). Section #ref(<ss:we>, supplement: none) describes the space-qualified implementation of the non-cryogenic portion of this system.


The overall white noise requirement of the readout system is that it should increase the fundamental statistical noise already in the detection chain by no more than 10 % in each band, including yield-reduction due to the readout. Other requirements are that the readout-induced crosstalk be lower than 0.3 % for every bolometer, and that ambient variable magnetic fields in the spacecraft not significantly increase the noise in the detection chain.


=== Cold Readout
<ss:cr>
The #emph[LiteBIRD] readout system is improved compared to previously fielded DfMux systems by making some modifications to the cold circuitry. The previous resistive bias element at 4K has been changed to an inductor on the 100-mK stage and the SAA has also been moved onto the 100-mK stage#footnote[An alternate location for the SAA under consideration is on the 350 mK stage which has more cooling power than the 100mK stage but is still in close physical proximity to the TES bolometers and LC filters at 100mK.]. Since the saas, bias elements, and TES
bolometer are in close physical proximity, parasitic inducatance between the bias element and the LC filters~#cite(<Dobbs2012>) is reduced resulting in reduced crosstalk. In addition, the reduction in parasitic inductance increases the dynamic range of the SAA SQUID elements. The reactive bias element dissipates substantially less power than the resistive bias element, enabling its placement at the 100-mK adr-cooled stage.


System resources impose further requirements on the cold circuit: that the thermal power deposition on the 100-mK stage be less than 410 nW total; that a harness with a length of between 1.8 and 2.5 m (to be determined more precisely later) be supported by the system; and that the system has a mass less than 2 kg.


==== Bias Element and LC Resonator
<bias-element-and-lc-resonator>
Each bolometer is in series with a lithographed planar spiral inductor and interdigitated capacitor, which form a resonance between 1.5 MHz and 4.5 MHz and uniquely identifies the bolometer in series with it. These are fabricated lithographically and a given die will contain all 68 resonators that will be connected to a single SAA. The optimal frequency schedule balancing anticipated scatter and mechanisms of crosstalk is still under study. The LC die must also be shielded by a conductor to ensure consistent inductor values. The LC circuit-boards contain
the low-impedance bias element and connect to the bolometer wafer with a superconducting stripline.


==== SQUID Array Amplifier and Wiring Harness
<squid-array-amplifier-and-wiring-harness>
The SAA will be used as a low-noise transimpedance amplifier to drive the wiring harness that connects the detectors to the warm SCU. Requirements on the SAA to 300K harness, derived from the sensitivity requirement on the readout, are as follows. The transimpedance for the SAA-harness system must be greater than 400 $Omega$ across the operating DfMux frequencies. The noise injected by the SAA must be such that, when integrated with the warm electronics in the detection chain, the high-level sensitivity requirement is satisfied. This requirement must be
achieved including the noise-increasing effect of current sharing, which sets an upper bound on the allowable input impedance of the @SilvaFeaver2018 SAA SQUID elements. In practice, currently demonstrated noise values of $4 thin "pA" thin ( "Hz" )^(- 1 \/ 2)$ meet this requirement. Further refinement in the per-component noise injection allocation, given circuit component optimizations, are underway. Magnetic shielding of the saas is accomplished, as in other DfMux systems, with a hybrid system of niobium foil beneath the SAA to pin magnetic fields when
in the superconducting state, and a $mu$-metal shield around the SAA to reduce field amplitude.


=== Warm Readout
<ss:we>


// [figvision-cn] imgs/readout.jpg
// 该图由左侧的系统原理框图和右侧的两张实物显微照片组成，
// 整体展示了采用数字频分复用技术的低温读出系统架构及芯片
// 细节。 左侧部分为系统原理示意图，背景色块将电路划分为
// 三个温区：红色区域代表室温部分，黄色区域代表中间过渡温
// 区，浅蓝色区域代表亚开尔文（sub-K）低温阶段。在红色区
// 域内，左上角是一个标有“FPGA: Control Demodulation and
// Synthesis”的方框，表示负责控制、解调和合成的现场可编程
// 门阵列。从FPGA引出一条线连接至其右侧的“Carrier DAC”方
// 框，即载波数模转换器，随后通过一个电感符号连接到黄色区
// 域。FPGA下方连接有一个“ADC”方框，即模数转换器。ADC的输
// 出端连接至两个运算放大器符号，其中一个同相输入端（+）
// 直接相连，另一个反相输入端（-）通过电阻反馈回路连接。
// 此外，左下角有一个“Nuller DAC”方框，通过电阻和电容网络
// 与下方的运算放大器相连。在黄色区域中央，绘制了一个带有
// 交叉双箭头的圆圈符号，代表混合器或耦合元件。进入浅蓝色
// 区域后，电路呈现并联结构，包含多个LC谐振支路。每个支路
// 由一个电感符号和一个可变电阻符号串联组成，其中第二个和
// 第三个支路的电感下方还并联了电容符号。最右侧的支路同样
// 包含电感和可变电阻，并在底部并联电容，支路之间用省略号
// 表示还有更多重复单元。 右侧上方是一张矩形芯片的灰度显
// 微照片，展示了40个电感-电容谐振器的阵列布局。照片中可
// 见排列整齐的微小方形结构，呈网格状分布，边缘有金属走线
// 连接。右下角标注有比例尺，显示为“2 mm”。 右侧下方是一
// 张特写显微照片，展示单个梯度SQUID（超导量子干涉器件）
// 的结构。图像中心为对称的四叶草形状，由多层螺旋形超导线
// 圈构成，线圈间通过细窄的约瑟夫森结连接。整个结构具有高
// 度对称性，周围环绕着复杂的互连线路。该图同样配有比例尺，
// 标示为“500 μm”。
#figure(placement: top, image("imgs/readout.jpg", width: 100.0%),
  caption: [
    Schematic overview of the cryogenic readout system with digital frequency-domain multiplexing, as described in @s:readout (left) and images of a chip of 40 inductor-capacitor resonators (right top) and a single gradiometric SQUID (right bottom). The red shading indicates the portion of the circuit located at warm temperature, blue is the portion located at the sub-K temperature stages, and yellow is the twisted-pair wiring harness, which connects them. The variable resistances correspond to the TES bolometers. The nulling line shown here in the left
panel uses active feedback to linearize the SQUID amplifier ~#cite(<deHaan2012>) #cite(<Montgomery:PhD>)
  ]
)
<fig:dfmux>


// [figvision-cn] imgs/Exploded_SPA_Graphic_View.jpg
// 该图为一幅信号处理单元（SPU）的计算机辅助设计（CAD）模
// 型爆炸视图，展示了其内部组件的拆解与空间布局。图像左侧
// 为SPU的完整组装立体图，整体呈长方体结构，外壳为灰色，
// 底部带有散热鳍片状结构，顶部安装有两个米黄色的模块，侧
// 面可见黄色接口。一条黑色的花括号从左侧组装图延伸至右侧，
// 表示右侧为该单元的分解视图。 右侧分解区域按功能组分布：
// 中央下方是一个标有“Signal Processing Assembly”（信号处
// 理组件）的托盘式结构，内部承载一块绿色的印刷电路板（
// PCB），板上可见FPGA芯片及其他电子元件。该组件位于中心
// 位置，是核心处理部分。 在信号处理组件的上方和右方，分
// 布着四块相同的长条形板卡，均标有“2x Digitizer
// Assemblies”（两块数字化器组件）。其中两块位于上方，呈
// 水平排列；另两块位于右侧，呈垂直排列。这些板卡具有金属
// 边框和密集的电子走线，用于信号采集与数字化。 此外，图
// 中还包含若干辅助结构件：包括一块位于左上方的深灰色平板
// （可能为屏蔽罩或安装支架）、一块位于中上方的细密栅格状
// 板（可能为滤波器或连接器阵列）、以及一块位于中部的竖直
// 薄板（可能为隔板或支撑件）。所有组件通过空间分离展示其
// 装配关系，无连接线，但布局暗示了它们在最终组装中的相对
// 位置。 整幅图未提供比例尺、坐标轴或颜色映射，属于纯结
// 构示意图，旨在传达SPU的物理构成与模块化设计，强调其满
// 足发射与飞行环境下的热耗散与振动要求，并支持对15个
// SQUID模块（最多1020个测辐射热计）的数据读出。
#figure(placement: top, image("imgs/Exploded_SPA_Graphic_View.jpg", width: 80.0%),
  caption: [
    Exploded view of the CAD model for the signal-processing unit (SPU). The SPU contains one signal-processing assembly (SPA), on which an FPGA is mounted, and four separate digitizer assemblies. The enclosure is designed to meet thermal dissipation and vibration requirements for launch and flight environments. In total, an SPU performs the readout for 15 SQUID modules, which means up to 1020 bolometers.
  ]
)
<fig:spu>


The #emph[LiteBIRD] WE implement the non-cryogenic portion of the DfMux hardware. This is divided into three separate electronics assemblies, as follows.

- The spa contains the that performs the digital signal processing and communication. Each SPA supports up to 15 multiplexing modules using four digitizer assemblies. This number of a maximum of 15 SQUID modules per SPA is a design requirement, driven by a projection of the FPGA resources of radiation-hardening techniques such as tmr, and ecc.

- The da performs the digital-to-analog conversion to synthesize tones, and analog-to-digital conversion to digitize the resulting waveforms. Each da supports four multiplexing modules.

- The sca houses the SQUID biasing electronics and pre-amplification stages for the SQUID output signals. Each SCA supports four multiplexing modules.


The WE redundancy model duplicates SPA and DA electronics with "cold spares" that we can switch to in flight. They are organized in signal-processing units (SPUs) consisting of one SPA and up to four DAs, plus the enclosure (see @fig:spu). Hence there are four SPUs per telescope (two active and two cold redundant). The SCAs are much simpler, and contain only redundant elements within the electronics, rather than fully redundant spares. This WE design improves on existing DfMUX readout ~#cite(<montgomery_2015>) #cite(<Montgomery:PhD>) in a number of ways:
the multiplexing capability per FPGA board is increased from eight multiplexing modules to 15; and the electronics is implemented with a fully radiation-qualified signal chain, including radiation-tolerant components and redundant firmware designed to be robust to the high-radiation environment. This design meets the requirements for: power consumption (approximately 80 mW per bolometer including power delivery losses and redundancy); reliability (90 % confidence in sufficient yield over the mission lifetime to meet the readout-induced noise
requirements); and readout noise #cite(<Montgomery:PhD>)


== Electronics Architecture
<ss:plm_electronics>


// [figvision-cn] imgs/Archi_v0_6.png
// 该图是一幅系统架构示意图，展示了三个并行的电子学处理链
// 路，分别对应高（H）、中（M）、低（L）频段或通道。图中
// 所有模块均为矩形框，通过黑色实线连接表示信号或控制流向。
// 图的底部设有图例，定义了三种颜色的含义：红色方块代表电
// 源（Power），紫色方块代表标称链路（Nominal link），浅
// 蓝色方块代表冗余链路（Redundant link）。 子图 a（左侧
// 链路，标记为 HFT）： 类型：系统架构图。 布局与组件：
// 顶部是一个浅绿色矩形框，标注为“PMU-H”，上方有一个浅蓝
// 色向下箭头，标注为“Signal from sky”。 PMU-H下方是一个
// 大的虚线框区域，内部包含多个模块。 在虚线框左上角是一
// 个绿色小矩形框，标注为“PMC-H”，其内部有三个小色块：左
// 红、中紫、右浅蓝。 PMC-H右侧是一个浅青色大矩形框，标注
// 为“FP / CRE”。 FP/CRE下方是一个蓝色矩形框，标注为“SCU”。
// 从FP/CRE到SCU有两条垂直连接线，每条线上有一个白色小矩
// 形，标注为“J01”和“J02”。 SCU下方并列排列四个黄色矩形框，
// 每个均标注为“WE”。每个WE模块上方连接到SCU，下方引出连
// 线。每个WE模块内部也有三个小色块：左红、中紫、右浅蓝。
// 整个左侧虚线框区域左侧边缘标注为“HFT”。 所有四个WE模块
// 的输出线汇聚到一个灰色大矩形框，标注为“MDPU-MH”。
// MDPU-MH左侧连接一个紫色矩形框，标注为“0.1K & 0.3K ADR
// Driver”。 MDPU-MH内部嵌入一个淡紫色矩形框，标注为“HAU”。
// HAU左侧有两个绿色小方块，引出线标注为“To HK meas.
// points”。HAU底部有一个蓝色小方块，引出线标注为“To /
// from SVM”。 此外，从PMC-H引出一条线直接连接到MDPU-MH。
// 子图 b（中间链路，标记为 MFT）： 类型：系统架构图。 布
// 局与组件： 结构与子图a几乎完全相同，但所有模块后缀由“H
// ”改为“M”。 顶部是“PMU-M”，上方同样有“Signal from sky”
// 箭头。 虚线框内左上角是“PMC-M”，右侧是“FP / CRE”，下方
// 是“SCU”，再下方是四个“WE”模块。 虚线框左侧标注为“MFT”。
// 所有WE模块输出汇聚到同一个灰色大矩形框“MDPU-MH”（注意
// 此处仍为MH，非MM）。 此链路没有独立的ADR驱动器等外设，
// 仅通过PMC-M和WE模块连接到MDPU-MH。 子图 c（右侧链路，
// 标记为 LFT）： 类型：系统架构图。 布局与组件： 结构与
// 前两路类似，但模块后缀为“L”，且外围设备不同。 顶部是“
// PMU-L”，上方有“Signal from sky”箭头。 虚线框内左上角是
// “PMC-L”，右侧是“FP / CRE”，下方是“SCU”，再下方是四个“
// WE”模块。 虚线框左侧标注为“LFT”。 所有WE模块输出汇聚到
// 一个独立的灰色大矩形框，标注为“MDPU-L”。 MDPU-L右侧连
// 接三个紫色矩形框，从上至下分别为：“Precooler (100K, 20
// stirling cooler) Driver”、“15K PT coolers Driver”、“2K
// & 4K JTD Driver”。 MDPU-L内部嵌入淡紫色“HAU”模块，其左
// 侧两个绿色方块引出线标注为“To HK meas. points”，底部蓝
// 色方块引出线标注为“To / from SVM”。 从PMC-L也引出一条
// 线直接连接到MDPU-L。 整体趋势与结论： 该图展示了一个模
// 块化、分频段的科学仪器电子架构设计。三个独立链路（HFT,
// MFT, LFT）各自处理来自天空的信号，经过前端处理单元（
// PMU）、功率管理控制器（PMC）、焦平面/读出电子（FP/CRE）、
// 星载控制单元（SCU）及四个波形提取器（WE）后，数据被路
// 由至相应的数据处理单元（MDPU-MH用于高和中频段，MDPU-L
// 用于低频段）。各链路具备电源、标称和冗余链路配置（由颜
// 色标识），并在关键节点（如HAU）提供健康状态测量点和与
// SVM（可能是服务模块）的通信接口。低温制冷系统的驱动电
// 路仅在低频段链路（LFT）中明确列出，表明其冷却需求可能
// 集中在该频段。整个系统设计强调冗余性、分段处理和集中式
// 数据处理。
#figure(placement: top, [#block[
  #box(image("imgs/Archi_v0_6.png", width: 100.0%))
  ]],
  caption: [
    Electrical architecture.
  ]
)
<fig:archi_elec>


The electronics architecture is designed to implement the following functions: (i) control and readout of the detectors of the three focal planes; (ii) science signal processing (cosmic-ray glitches capture and scientific signal compression); (iii) control of the cryo-coolers and ADRs; (iv) control of the polarization modulators of the three telescopes; (v) temperature control and monitor of cold stages; (vi) housekeeping acquisition; and (vii) data time-tagging and subsystems synchronization.


To this purpose two mission data-processing units ( and ) will centralize these functions for both the LFT and MHFT telescopes, respectively, as shown in @fig:archi_elec. They will address both the scientific signal and cooling chains, as described below.


On one hand, the scientific signal chain starts with the cre, which is part of the focal-plane subsystem of each of the three telescopes. It then consists of the SCU, which provide bias for detectors and SQUIDs, and the warm electronics (WE), which implements the frequency-domain readout electronics. Then the mdpu provides the last stages of the science signal acquisition; it performs science data preprocessing, compression, detector setup algorithms, focal-plane thermal control (digital part), and sub-systems synchronization. Finally, the hau performs
the acquisition of all housekeeping that cannot be acquired inside the others subsystems. Additionally, three polarization modulation controller subsystems (PMC-L, PMC-M, and PMC-H) control the polarization modulation units of the LFT, MFT, and HFT, respectively.


On the other hand, the 0.1-K and 0.35-K ADRs drivers of the cooling chain, responsible for driving the ADRs for the 0.1-K and 0.35-K stages, respectively, are connected to the MDPU-MH. The MDPU-L addresses the higher-temperature stages of the cooling chain, i.e., the 2-K JT and 4-K JT drivers (JTD), the 15-K Pulse Tube cooler driver, and the pcd. The two JTDs, responsible for driving the Joule-Thomson cryo-coolers for the 1.75-K and 4.8-K stages, provide the AC power for the 3He JT and 4He JT mechanical coolers, respectively, monitor the temperatures
that are provided, and monitor pressures and controlling valves in the JT circuits. The PCD, which is the cooler driver for the Stirling coolers used for the shield and JT pre-cooling, provides AC power for the Stirling mechanical coolers and monitors the temperatures that they are cooling.


== Cryogenic System
<ss:plm_cryo>


// [figvision-cn] imgs/cooler_config_v2.png
// 该图像为一张低温制冷系统的结构示意图，展示了从室温到
// 0.1K亚开尔文温区的多级冷却架构及其控制电子学布局。整个
// 系统沿水平方向排列，左侧为最低温区，右侧为较高温度及驱
// 动部件。 最底部是一条横贯全图的浅灰色长条，标注为“
// Cooler pedestal”（制冷机基座）。其下方并列排布着六个粉
// 红色矩形框，代表各类驱动器，从左至右依次为：“ADR
// driver”、“JTD-2K”（两个）、“PCD”（两个）、“SCD”。这些
// 驱动器通过垂直黑线连接到上方的对应模块。所有驱动器下方
// 由一条水平黑线连接至一个居中的白色矩形框，标注为“
// Synchronize electronics”，表示同步电子控制系统。 在基
// 座之上，从左至右依次布置了多个功能模块： 最左侧是绿色
// 圆角矩形“JTCH”和“JTCM”，分别由下方的“ADR driver”和第一
// 个“JTD-2K”驱动。 接着是两个相同的绿色圆角矩形“JTCL1”和
// “JTCL2”，均由第二个“JTD-2K”驱动。 然后是一对绿色圆角矩
// 形“PC”，由第一个“PCD”驱动；再往右又是一对“PC”，由第二
// 个“PCD”驱动。 中间偏右位置是另一组“JTCH”和“JTCL”，由“
// JTD-4K”驱动。 最右侧是一个较大的绿色圆角矩形“
// Compressor”，由“SCD”驱动。 各模块上方有温度标签指示其
// 工作温区： “JTCH/JTCM”与“JTCL1/2”组合区域上方标有“
// 2K-JT”，并通过两条垂直灰线向上延伸至左上角的“Sub-K ADR
// ”模块（内含“0.1K”字样），表明此部分服务于亚开尔文绝热
// 去磁制冷机。 第一对“PC”模块上方标有“15K”，第二对“PC”模
// 块上方标有“20K”。 “JTCH/JTCL”组合上方标有“4K-JT”。 最
// 右侧“Compressor”模块上方有两个浅蓝色V形结构，分别标注
// 为“V-groove 2”和“V-groove 3”，并附有文字“Shield cooler
// ”，表明这是屏蔽冷却器的V型槽结构。 图中还包含若干浅蓝
// 色半透明矩形块，位于“PC”和“Compressor”模块正上方，可能
// 代表热沉或辐射屏蔽层。其中，“15K”和“20K”处的蓝色块呈阶
// 梯状堆叠，“Compressor”上方的蓝色块则更宽大且带有V形凹
// 槽轮廓。 整体布局清晰呈现了从室温压缩机→4K/2K级联制冷→
// 15K/20K预冷→最终通过ADR实现0.1K极低温的完整路径，同时
// 体现了各阶段对应的驱动电路与同步控制逻辑。所有连接线均
// 为黑色实线，无曲线或虚线；颜色编码统一：绿色代表制冷单
// 元，粉红色代表驱动器，浅蓝色代表热管理组件，灰色代表机
// 械支撑结构。
// [figvision-cn] imgs/cooler_config_v2.png
// 该图像为一张低温制冷系统的结构示意图，展示了从室温到
// 0.1K亚开尔文温区的多级冷却架构及其控制电子学布局。整个
// 系统沿水平方向排列，左侧为最低温区，右侧为较高温度及驱
// 动部件。 最底部是一条横贯全图的浅灰色长条，标注为“
// Cooler pedestal”（制冷机基座）。其下方并列排布着六个粉
// 红色矩形框，代表各类驱动器，从左至右依次为：“ADR
// driver”、“JTD-2K”（两个）、“PCD”（两个）、“SCD”。这些
// 驱动器通过垂直黑线连接到上方的对应模块。所有驱动器下方
// 由一条水平黑线连接至一个居中的白色矩形框，标注为“
// Synchronize electronics”，表示同步电子控制系统。 在基
// 座之上，从左至右依次布置了多个功能模块： 最左侧是绿色
// 圆角矩形“JTCH”和“JTCM”，分别由下方的“ADR driver”和第一
// 个“JTD-2K”驱动。 接着是两个相同的绿色圆角矩形“JTCL1”和
// “JTCL2”，均由第二个“JTD-2K”驱动。 然后是一对绿色圆角矩
// 形“PC”，由第一个“PCD”驱动；再往右又是一对“PC”，由第二
// 个“PCD”驱动。 中间偏右位置是另一组“JTCH”和“JTCL”，由“
// JTD-4K”驱动。 最右侧是一个较大的绿色圆角矩形“
// Compressor”，由“SCD”驱动。 各模块上方有温度标签指示其
// 工作温区： “JTCH/JTCM”与“JTCL1/2”组合区域上方标有“
// 2K-JT”，并通过两条垂直灰线向上延伸至左上角的“Sub-K ADR
// ”模块（内含“0.1K”字样），表明此部分服务于亚开尔文绝热
// 去磁制冷机。 第一对“PC”模块上方标有“15K”，第二对“PC”模
// 块上方标有“20K”。 “JTCH/JTCL”组合上方标有“4K-JT”。 最
// 右侧“Compressor”模块上方有两个浅蓝色V形结构，分别标注
// 为“V-groove 2”和“V-groove 3”，并附有文字“Shield cooler
// ”，表明这是屏蔽冷却器的V型槽结构。 图中还包含若干浅蓝
// 色半透明矩形块，位于“PC”和“Compressor”模块正上方，可能
// 代表热沉或辐射屏蔽层。其中，“15K”和“20K”处的蓝色块呈阶
// 梯状堆叠，“Compressor”上方的蓝色块则更宽大且带有V形凹
// 槽轮廓。 整体布局清晰呈现了从室温压缩机→4K/2K级联制冷→
// 15K/20K预冷→最终通过ADR实现0.1K极低温的完整路径，同时
// 体现了各阶段对应的驱动电路与同步控制逻辑。所有连接线均
// 为黑色实线，无曲线或虚线；颜色编码统一：绿色代表制冷单
// 元，粉红色代表驱动器，浅蓝色代表热管理组件，灰色代表机
// 械支撑结构。
#figure(placement: top, [#block[
  #box(image("imgs/cooler_config_v2.png", width: 100.0%))
  ]
  #block[
  #box(image("imgs/cryo_structure5K.png", width: 100.0%))
  ]],
  caption: [
    Schematic drawing of the cryo-structure and V-grooves.
  ]
)
<fig:cryo-structure5K>


=== Down to 5 K
<down-to-5-k>
The cryogenic telescopes must be cooled to 4.8 K to achieve the required sensitivity. The cooling chain between 4.8 K and the warm temperature (around 300 K) is composed of passive radiative cooling and of active mechanical coolers, as illustrated in #ref(<fig:cryo-structure5K>, supplement: none) The thermal architecture of #emph[LiteBIRD] has a boundary temperature of 300 K in between the warm and cryogenic mission instruments. The cryostructure, made of CFRP, connects the 5-K interface plate and the warm temperature SVM/BUS structure, as shown in
@fig:cryo-structure5K. To reduce the heat loads of the shield cooler and 4K-JT, we employ large thermal shields, which are called "V-grooves." The thermal design of #emph[LiteBIRD] uses the radiative cooling effect as much as possible. The thermal design of the passive radiative cooler for #emph[LiteBIRD] has been studied in @Hasebe2019. The current design has three layers of V-grooves, as shown in @fig:satellite_overview and #ref(<fig:cryo-structure5K>, supplement: none) The second and third (inner) layers are cooled by the first and second stages of
the shield cooler, respectively. The first (outer) layer is partially exposed to solar radiation, and therefore the surface is covered by a multi-layer insulation (MLI) blanket. A Sun shield (@fig:cryo-structure5K) reduces the solar radiation to the outer V-groove. V-groove passive radiators are cooled down to 160, 90, and 30 K, thanks to the favorable radiative environment of the L2 orbit. Additional cooling capacity for shield cooling is provided by a mechanical cooler. A 15-K pulse-tube cooler~#cite(<Pennec2016>) helps to decrease the temperature of
the inner passive radiative enclosure to 30 K.


A 4-K JT and two 2ST (two-stage Stirling) pre-coolers keep the telescopes at 4.8 K. The 4-K JT cooler has a cooling capacity of 40 mW at the cold tip of 4.8 K at the EOL (End Of Life)~#cite(<Sato2010>) #cite(<Sato2012>) #cite(<Sato2014>). The 2ST cooler has a cooling capacity of 200 mW at the 20-K stage at EOL ~#cite(<Sato2010>) #cite(<Sato2012>) #cite(<Sato2014>). Taking into account 33 % margin for the mechanical cooler, the available cooling power at the 4.8-K stage is 30 mW. The 4-K JT cooler and the 2ST cooler have achieved TRL~8. Based on the PLM
structure, the conductive and radiative loads to the 4.8-K stage are estimated to be 13 mW. The available cooling power for the instruments, including LFT, MHFT and the sub-kelvin coolers at 4.8 K, is 17 mW.


=== Below 5 K
<below-5-k>


// [figvision-cn] imgs/chaine_ADR.png
// 该图是一张示意图，展示了从5K到0.1K的低温链及热连接。整
// 个系统被一个标有“Cryomodule”的黑色虚线矩形框包围。图的
// 左侧是输入端，右侧是输出端，中间是核心制冷与热交换区域。
// 在图的左下角有一个图例，定义了图中使用的符号和颜色：
// 一个带叉的圆圈符号代表“heat switch”（热开关）。 品红色
// 方块代表5 K温区。 绿色线条或区域代表2 K温区。 浅青色方
// 块或线条代表0.35 K温区。 深蓝色方块或线条代表0.1 K温区。
// 图的左侧外部有两个垂直排列的粗短管状结构，作为冷源入口。
// 上方为绿色，标注“2K JT”；下方为品红色，标注“5K JT”。
// 从这两个入口引出的管线进入虚线框内： 来自“2K JT”的绿色
// 管线向右水平延伸，横跨整个模块顶部，然后向下折返，连接
// 到右侧的三个输出模块。 来自“5K JT”的品红色管线先向上分
// 出一支连接到绿色管线，主路继续向右，同样横跨顶部后向下
// 折返，连接到右侧的三个输出模块。 在虚线框内部的中部，
// 有一条水平的级联结构，由四个相同的单元串联而成。每个单
// 元由上下两个品红色的矩形块组成，矩形块内部画有交叉的对
// 角线。这四个单元之间通过三个“热开关”符号连接。 第一个
// 单元（最左侧）的左侧连接着一个波浪线符号（可能表示弹簧
// 或柔性连接），并连接到一个热开关。该单元内部标注文字为
// “2K-0.35K”。在第一个单元的左下方，有一个箭头指向该单元，
// 并标注文字“Coils”。 第二个单元内部包含一个浅青色的矩形
// 区域，标注文字为“0.35K”。在该单元的左下方，有一个箭头
// 指向该单元下方的连接线，并标注文字“Continuous 0.3K”。
// 一条浅青色的线从该单元底部引出，向右延伸并向下弯曲，连
// 接到右侧的输出模块。 第三个单元内部标注文字为“
// 0.35K-0.1K”。 第四个单元（最右侧）内部包含一个深蓝色的
// 矩形区域，标注文字为“0.1K”。一条深蓝色的线从该单元右侧
// 引出，向右延伸并向下弯曲，连接到右侧的输出模块。 图的
// 右侧有三个垂直堆叠的矩形框，代表不同的测试或实验模块，
// 从上到下依次标注为“LFT”、“MFT”和“HFT”。 顶部的“LFT”模
// 块：接收来自左侧顶部的绿色管线和品红色管线。 中间的“
// MFT”模块：接收来自左侧顶部的绿色管线和品红色管线，以及
// 来自中部级联结构底部的浅青色管线。 底部的“HFT”模块：接
// 收来自左侧顶部的绿色管线和品红色管线，来自中部级联结构
// 底部的浅青色管线，以及来自中部级联结构最右端的深蓝色管
// 线。在深蓝色管线下方，有一个箭头指向该管线，并标注文字
// “Continuous 0.1K”。 所有管线在进入右侧模块前，都经过一
// 个垂直的汇流区域，该区域由多条平行的彩色竖线表示，显示
// 了不同温度等级的热通道。
#figure(placement: top, image("imgs/chaine_ADR.png", width: 100.0%),
  caption: [
    Overview of the 5-K to 0.1-K cryogenic chain and thermal links.
  ]
)
<fig:cryomodule>


==== Low Temperature Thermal Architecture
<low-temperature-thermal-architecture>
Both MHFT and LFT have intermediate cold stages at 1.75 K and 0.35 K between their outer bodies at 4.8 K and their detectors. In order to have continuous measurements, these intermediate stages have to be cooled continuously as well.


A solution combining a 2-K JT cooler and a sub-K (sub-kelvin) cooler with multiple ADRs, has been selected to cool the instruments below 4.8 K. The two coolers are used for the two instruments, requiring a web of thermal paths shown in @fig:cryomodule, linking these four components. As seen in the figure, the thermal links and the sub-K cooler will be integrated on a cryomodule cooled down to 4.8 K by the 4-K JT cooler. The cryomodule is going to be located on the 4.8-K mechanical stage of the MHFT. The sub-K cooler side of the cryomodule will be placed
close to the focal plane side to minimize the thermal link lengths.


The thermal links have to be designed to minimize parasitic losses. Therefore, heat interception should be used at each of the temperature levels. Coaxial kevlar cord supports are foreseen to be used to limit heat losses at sub-K temperatures, whereas CFRP supports will be use for both the sub-K thermal links and the 1.75-K ones. Highly conductive materials, such as copper and high purity aluminum, will be used and superfluid heat pipes will be evaluated at 1.75 K in comparison with pure aluminum.


==== 2-K JT cooler
<k-jt-cooler>
The 2-K JT cooler is provided by JAXA. It requires pre-cooling stages at 15 K and 90 K. The $""^3$He gas is circulated by four compressors. An engineering model has been fabricated for several verification tests and has allowed this technology to achieve TRL 5 ~#cite(<Sato2016Cryo>). A cooling power of 10 mW at 1.75 K has been confirmed during these tests ~#cite(<Sato2016Cryo>). Its performance has also been demonstrated in combination with a 50 mK sub-Kelvin ADR in the case of the Athena cooling chain. ~#cite(<PROUVE2020>)


==== Sub-kelvin Cooler
<sub-kelvin-cooler>
The sub-K cooler is provided by cea. It works from 1.75 K to 0.1 K, as schematically shown in @fig:cryomodule and has been described in @Duval:2020ADR. The 350-mK continuous cooling stage is obtained thanks to two ADR stages. Similarly, the 100-mK stage is obtained with two additional ADR stages. For low temperatures, continuous cooling is achieved using a series configuration, with one stage being at a stable temperature, while a second stage is used to extract heat from the low temperature and dump it to the highest temperature interface.


== Calibration
<ss:plm_calib>


=== Overall Status and Strategy Description
<overall-status-and-strategy-description>


The strategy of the #emph[LiteBIRD] calibration is to derive a common approach for both instruments, LFT and MHFT, except for some specific items. The global picture, as of today, is illustrated in @fig:calib-stra. Four steps are foreseen. The first is to characterize the performance at the component level. These charaterizations are part of the deliverables of the sub-systems; they will be based on the #emph[LiteBIRD] specifications and carried out prior to integration at the instrument level. The data from these characterizations will be used to build
an instrument model and forecast the in-flight performance as we develop the system. The second step concerns beam calibration. Considering the specific related challenges (linked to the specifications on the beam knowledge and the level of accuracy required for the beam modeling), a dedicated set of measurements is foreseen, identified as "RF characterization" (cf. @beams-calib-section). The next step is the instrument-level calibration, which will be performed for LFT and MHFT independently, in Japan and Europe, respectively, in a cold flight-like
environment. The final step of the ground activites is the final verification that will be carried out at the PLM level (system-level testing), when the LFT and MHFT will be integrated with the satellite PLM, and the SVM, together with the entire #emph[LiteBIRD] cooling system. As is highlighted in @fig:calib-stra, it is planned that some instrumental parameters will be ultimately derived from ground calibration operations (such as the spectral response, for instance), while, for others, the planned accuracy with flight data should allow us to rely on
flight data themselves (e.g., main beam and crosstalk using planets). It is worth noting that we explore the possibility of mitigating the systematic effects through a post-analysis step and to solve for the systematic parameters as part of the map-making or component-separation processes. Nevertheless, the calibration design philosophy is to prioritize the search for a hardware mitigation solution as a starting point. The calibration plans, the error budget allocation for hardware development, and the post-flight analysis mitigation strategies will be
refined as the project evolves.


In this section, we highlight the main calibration challenges, by focussing on some key parameters, namely the beams (@beams-calib-section), the spectral response (@bandpass-calib-section), and the polarization angle (@sss:anglecal). For each of them, we detail the requirements, the prospects for ground calibration and, if relevant, the plans for flight calibration. Finally, in @section:calib-plan, we summarize the means that we foresee to characterize the other instrumental parameters.


// [figvision-cn] imgs/calibstrategy_V6.png
// 该图是一张名为“LiteBIRD Calibration strategy”的甘特图
// 或流程示意图，展示了LiteBIRD项目的校准策略。图像整体布
// 局为横向时间轴与纵向参数列表的组合。 在图像左上角设有
// 图例，定义了三种圆形符号的含义：空心白色圆圈代表“
// Preliminary characterization”（初步表征）；浅蓝色实心
// 圆圈代表“Verification”（验证）；深蓝色实心圆圈代表“
// Final calibration”（最终校准）。 图像最左侧有一列垂直
// 排列的黑色文字标题“LiteBIRD Calibration strategy”。 图
// 像的纵轴由上至下列出了15个具体的校准项目，每个项目名称
// 左侧对应一条水平的时间进度线。这些项目依次为：“Noise”、
// “Sensitivity to T, bkg”、“Time Resp.”、“Resp. Cosmic
// Rays”、“Gains”、“Linearity”、“Cross-talk”、“Main Beams
// ”、“Side lobes”、“Far side lobes”、“Spectral response”、
// “Polarization angle”、“Polarization efficiency”以及“
// Instrumental polarization”。 图像的横轴表示四个校准阶
// 段，从左到右依次标注为：“Component characterization”（
// 组件表征）、“RF characterization”（射频表征）、“
// Cryogenic E2E calibration”（低温端到端校准）和“Flight
// calibration”（飞行校准）。 图中通过连接各阶段的水平蓝
// 线和不同颜色的圆圈来展示每个校准项目的执行流程和时间节
// 点。具体分布如下： Noise：从“Component
// characterization”阶段开始（白色圆圈），跨越中间两个阶
// 段，在“Cryogenic E2E calibration”阶段进行验证（浅蓝色
// 圆圈），并在“Flight calibration”阶段完成最终校准（深蓝
// 色圆圈）。 Sensitivity to T, bkg：起始于“Component
// characterization”（白色圆圈），在“Cryogenic E2E
// calibration”阶段验证（浅蓝色圆圈），在“Flight
// calibration”阶段最终校准（深蓝色圆圈）。 Time Resp.：
// 起始于“Component characterization”（白色圆圈），在“
// Cryogenic E2E calibration”阶段直接进行最终校准（深蓝色
// 圆圈），并在“Flight calibration”阶段进行验证（浅蓝色圆
// 圈）。 Resp. Cosmic Rays：仅在“Component
// characterization”阶段进行最终校准（深蓝色圆圈），并在“
// Flight calibration”阶段进行验证（浅蓝色圆圈）。 Gains：
// 起始于“Component characterization”（白色圆圈），在“
// Cryogenic E2E calibration”阶段验证（浅蓝色圆圈），在“
// Flight calibration”阶段最终校准（深蓝色圆圈）。
// Linearity：起始于“Component characterization”（白色圆
// 圈），在“Cryogenic E2E calibration”阶段最终校准（深蓝
// 色圆圈），并在“Flight calibration”阶段验证（浅蓝色圆圈）。
// Cross-talk：起始于“Component characterization”（白色圆
// 圈），在“Cryogenic E2E calibration”阶段最终校准（深蓝
// 色圆圈），并在“Flight calibration”阶段验证（浅蓝色圆圈）。
// Main Beams：起始于“Component characterization”（白色圆
// 圈），在“RF characterization”阶段进行初步表征（白色圆
// 圈），在“Cryogenic E2E calibration”阶段验证（浅蓝色圆
// 圈），最后在“Flight calibration”阶段最终校准（深蓝色圆
// 圈）。 Side lobes：起始于“RF characterization”（白色圆
// 圈），跨越后续阶段，在“Flight calibration”阶段进行验证
// （浅蓝色圆圈）。 Far side lobes：起始于“RF
// characterization”（白色圆圈），跨越后续阶段，在“Flight
// calibration”阶段最终校准（深蓝色圆圈）。 Spectral
// response：起始于“Component characterization”（白色圆圈），
// 在“RF characterization”阶段进行初步表征（白色圆圈），
// 在“Cryogenic E2E calibration”阶段最终校准（深蓝色圆圈），
// 并在“Flight calibration”阶段验证（浅蓝色圆圈）。
// Polarization angle：起始于“Component characterization”
// （白色圆圈），在“RF characterization”阶段进行初步表征
// （白色圆圈），在“Cryogenic E2E calibration”阶段验证（
// 浅蓝色圆圈），在“Flight calibration”阶段最终校准（深蓝
// 色圆圈）。 Polarization efficiency：起始于“Component
// characterization”（白色圆圈），在“RF characterization”
// 阶段进行初步表征（白色圆圈），在“Cryogenic E2E
// calibration”阶段最终校准（深蓝色圆圈），并在“Flight
// calibration”阶段验证（浅蓝色圆圈）。 Instrumental
// polarization：起始于“Component characterization”（白色
// 圆圈），在“RF characterization”阶段进行初步表征（白色
// 圆圈），在“Cryogenic E2E calibration”阶段验证（浅蓝色
// 圆圈），在“Flight calibration”阶段最终校准（深蓝色圆圈）。
// 该图传达的结论是：不同的校准参数需要在不同的阶段（从组
// 件级到飞行级）分步进行，其中大多数参数需要经历初步表征、
// 验证和最终校准的过程，但部分参数如宇宙射线响应主要在早
// 期阶段完成，而波束相关参数则贯穿多个阶段直至飞行校准。
#figure(placement: top, image("imgs/calibstrategy_V6.png", width: 70.0%),
  caption: [
    Global calibration strategy. The colors of the circles give an indication of the accuracy foreseen for the related calibration operation (white indicates preliminary characterization, light blue is for verification, and dark blue identifies the phase for which the calibration will be ultimately performed). The flight calibration phase can be sub-divided into three categories: the calibration and performance verification phase prior to nominal observations; and calibration during and after the nominal observations. These are not detailed here.
  ]
) <fig:calib-stra>


=== Beam-Pattern Characterization
<beams-calib-section>
This section describes the plans foreseen for the beam-pattern calibration. The strategy relies on optical modeling, tuned and consolidated by ground measurements at various levels, from component, subsystems, instrument, and PLM levels and further fed with flight data, as schematically illustrated in #ref(<fig:beam-calib>, supplement: none). The cross-polar response and the far sidelobes will be characterized by a combination of ground measurements and optical modeling. The co-polar main and near sidelobe beams are planned to be reconstructed from observations of planets.


// [figvision-cn] imgs/Fig31_revised.png
// 这是一张科学流程图，展示了波束模式表征策略及其与环境校
// 准和低温校准操作的关系。该图采用矩阵式布局，由行、列以
// 及底部的模型层构成。 整体布局与坐标轴定义： 图表的垂直
// 方向（行）分为两个主要区域，左侧边缘标注为“ambient”（
// 环境/常温）和“cryogenic”（低温）。 图表的水平方向（列）
// 由顶部的四个浅灰色矩形框定义，从左至右依次为：“
// Component level (incl. combination of components)”（组
// 件级，含组件组合）、“beam specific measurements”（特定
// 波束测量）、“Instrument level End-to-End tests”（仪器
// 级端到端测试）以及“PLM level”（PLM级）。这些列标题文字
// 为红色。 在图表的最右侧，有一个独立的淡黄色高亮矩形框，
// 跨越了“ambient”和“cryogenic”两行的高度，内部文字为“
// in-flight beam calibration using planets”（飞行中利用
// 行星进行的波束校准）。 在图表的最底部，是一个横跨整个
// 宽度的浅灰色长条区域，标记为“Instrument Modeling”（仪
// 器建模）。 子图内容详细描述（按逻辑区块划分）： 第一行
// （ambient/常温部分）： 在“Component level”列下，有一个
// 浅绿色矩形框。框内包含黑色文本列表：“HWP”、“Lens”、“
// Mirror”、“and combinations:”、“2 lenses”、“2 mirrors”。
// 在“beam specific measurements”列下，垂直排列着三个浅绿
// 色圆角矩形框。从上到下依次写着：“Far field main beam +
// FSL”、“Near field main beam +FSL”、“Dimensional”。 “
// Instrument level”和“PLM level”列在此行无具体图形元素，
// 仅显示网格线。 第二行（cryogenic/低温部分）： 在“
// Component level”列下，有一个浅绿色矩形框。框内包含黑色
// 文本列表：“HWP”、“Lens”、“Mirror”。 在“beam specific
// measurements”列下，有一个浅绿色圆角矩形框，内部写着：“
// Far field main beam +side lobes”。在该框下方有红色小字
// 注释：“cryogenic CATR (Compact Antenna Test Range)”。
// 在“Instrument level End-to-End tests”列下，有一个浅绿
// 色圆形框。框内文字为：“cross-check of the beam
// parameters entering the noise model”。 在“PLM level”列
// 下，有一个浅绿色圆形框。框内文字为：“cross-check of
// the beam parameters entering the noise model”。 底部模
// 型层（Instrument Modeling）： 该区域内包含两个带有绿色
// 边框的白色圆角矩形框。 左侧框位于“Component level”和“
// beam specific measurements”列的下方，文字为“Optical
// Model”。 右侧框位于“Instrument level End-to-End tests”
// 和“PLM level”列的下方，文字为“Thermo-Mechanical Model”。
// 连接关系与箭头： 图中存在多组蓝色的双向箭头，表示数据
// 或验证的双向交互。 在“Component level”列下方，有一对蓝
// 色双向箭头，连接上方的绿色方框区域与底部的“Optical
// Model”框。 在“beam specific measurements”列下方，有一
// 对蓝色双向箭头，连接上方的绿色方框区域与底部的“Optical
// Model”框。 在“Instrument level”列下方，有一对蓝色双向
// 箭头，连接上方的绿色圆形框与底部的“Thermo-Mechanical
// Model”框。 在“PLM level”列下方，有一对蓝色双向箭头，连
// 接上方的绿色圆形框与底部的“Thermo-Mechanical Model”框。
// 在最右侧，有一对较长的蓝色双向箭头，垂直连接右侧的淡黄
// 色“in-flight beam calibration”框与底部的模型区域（主要
// 是指向Thermo-Mechanical Model一侧）。 总结趋势与结论：
// 该图传达了一个分层级的验证策略。从最基础的组件级（HWP、
// 透镜、镜子）开始，通过光学模型进行验证；随着集成度提高，
// 进入特定波束测量阶段，同样依赖光学模型；随后进入仪器级
// 端到端测试和PLM级测试，此时引入了热机械模型进行交叉检
// 查；最后，所有地面测试的数据和模型将在飞行阶段通过观测
// 行星进行最终的在轨校准和验证。流程体现了从局部到整体、
// 从理论模型到实际测量的闭环反馈机制。
#figure(placement: top, image("imgs/Fig31_revised.png", width: 100%),
  caption: [
    Beam-pattern characterization strategy, including ambient and cold calibration operations. The different levels of the operations foreseen are identified by the five columns: at component and sub-system level; at telescope level during dedicated beam-scanning campaigns; at telescope level during integrated end-to-end measurements at PLM level; and finally in-flight using planets. The strong links between measurements and modeling are also shown.
  ]
) <fig:beam-calib>


==== Requirements


// [figvision-cn] imgs/LiteBIRD_Areas_100GHw_14deg_270mm.png
// 该图像由左侧的辐射方向图曲线图和右侧的辅助表格及图例组
// 成。 子图（左）： 类型：二维曲线图，背景带有垂直颜色分
// 区。 坐标轴：横轴为“Angle (deg)”，范围从-90度到+90度，
// 刻度间隔为30度；纵轴为“Power (dBi)”，范围从-80 dBi到60
// dBi，刻度间隔为20 dBi。 曲线：图中有一条黑色实线，代表
// MFT在100 GHz频率下的辐射功率随角度的变化。曲线在0度处
// 呈现一个尖锐的主瓣峰值，峰值略低于50 dBi。在主瓣两侧，
// 存在旁瓣结构，功率迅速下降至约-20 dBi至-40 dBi之间。在
// 角度大于约45度和小于约-45度的区域，曲线呈现出高频振荡
// 特征，功率值在-60 dBi至-80 dBi之间波动。 背景与标注：
// 图表背景被垂直划分为四个彩色区域，分别标记为A1、A2、A3
// 和A4。中心最窄的区域A1为粉红色，对应角度范围约为-1度至
// +1度。紧邻A1两侧的区域A2为黄色，覆盖约-10度至-1度以及+
// 1度至+10度。更外侧的区域A3为浅绿色，覆盖约-45度至-10度
// 以及+10度至+45度。最外侧的区域A4为浅蓝色，覆盖剩余的角
// 度范围（-90度至-45度以及+45度至90度）。 趋势与结论：主
// 波束集中在0度附近，能量高度集中。随着角度偏离中心，功
// 率急剧下降。在大角度区域（A4），由于前遮罩（forebaffle）
// 对模拟散射源的遮挡作用，出现了显著的功率跌落和振荡。
// 子图（右）： 类型：信息表格与文字说明。 表格内容：表格
// 标题行包含三列：“Area”、“Approximate angular range (
// deg)”、“Notes*”。 第一行数据：Area为“A1”，角范围为“-1/
// +1”，Notes为“0”。 第二行数据：Area为“A2”，角范围为“-10
// /-1 & +1/+10”，Notes为“1”。 第三行数据：Area为“A3”，角
// 范围为“-45/-10 & +10/+45”，Notes为“1+2”。 第四行数据：
// Area为“A4”，角范围为“-180/-40 & +40/+180”，Notes为“1+2
// +3”。 文字说明部分：标题为“(*) Main components
// conditioning the final results:”，下列出了编号对应的组
// 件： 0 – Lenses (& AR), filters and HWP optical
// properties 1 – Aperture stop and Tube (& internal
// absorber) 2 – Forebaffle 3 – Satellite geometry 功能：
// 该部分解释了左侧图中不同角度区域（A1-A4）所对应的物理
// 组件影响。例如，A1区域主要受透镜和光学元件（注0）影响，
// 而大角度区域A4则受到孔径光阑、前遮罩及卫星几何结构的综
// 合影响（注1+2+3）。
#figure(placement: top, image("imgs/LiteBIRD_Areas_100GHw_14deg_270mm.png", width: 100%),
  caption: [
    Radiation pattern of MFT at 100 GHz for a pixel at the center of the focal plane (including the lenslet-like feed, the two lenses, the stop aperture, and the forebaffle aperture). The sharp dropoff in beam power in the 50--$60^compose$ range is caused by forebaffle shielding of a Lambertian source placed at the aperture to simulate 1 % large-angle scattering. The color scale indicates some qualitative aspects of the beam profile.
  ]
)
<fig:LoK>


With the example of the MHFT telescope at 100 GHz, @fig:LoK shows how each telescope element differently affects the angular regions of the co-polar beam shape. The identified angular ranges and intensity are key ingredients in the estimation of the hierarchy driving the calibration efforts. It also gives indications on the level of accuracy needed in the characterization of each individual optical element, as well as at the integrated level. Last (but not least), it gives guidelines to define a suitable way of parameterizing the instrumental effects
when feeding them into TOD-based simulations for systematics studies.


The derivation of the beam-calibration requirement is detailed in @sec:beam-systematics. The global requirement reads as follows: the calibration measurement uncertainty, as defined by #ref(<sigmacalibbeam>, supplement: none) should be smaller than $- 57$ dB, when the optical response is assumed to be normalized to unity at the main peak, for a pixel of $0.5^compose$ in size.


==== Prospects for Ground Calibration
<Ground-beams>
As discussed above, #ref(<fig:beam-calib>, supplement: none) illustrates the main steps that are foreseen today for beam characterization. To meet these requirements, the plan is to rely on a very tight connection between measurements performed both at warm and cold temperatures, together with the development of accurate software tools for instrumental modeling.

- In the first phase, the plans are to go through characterizations of sub-systems (and combinations of components) at warm and cold temperature to consolidate the design of the instrument as well as its optical modeling, allowing us to build the transfer function between warm and cold temperatures.


The MHFT BBM is an example of activities in this phase of the development plan, with comparable activities being planned for LFT. The purpose of the BBM measurement campaign is to challenge the optical modeling of the MHFT refractive designs, to assess the achievable accuracy both for the modeling and for the rf measurements, to prepare the setups that will be used for the cold measurements, and to study various effects such as, for example, misalignment of components (tolerance analysis), standing waves, and ghosting. The BBM test plan foresees the following two models.

#block[
#set enum(numbering: "(a)", start: 1)
+ BBM-1 (corrugated horn with one lens): simulation and characterization at MFT and HFT frequencies in different labs with a reference common channel as a cross-check. This allows for a verification of the modeling and measurement techniques and facilities.

+ BBM-2 (corrugated horn with two lenses): increase complexity and possible evaluation of "combined" effects due to the coupling of the two lenses. This allows for a verification of the sensitivity to misalignment, AR-coating, etc.
]


The next step is to carry out a 2$pi$ RF characterization campaign of a representative instrument. This is the case for the 1/4-scaled model for LFT, as described in @sect:LFT-scaled-model. The far sidelobe pattern of the 1/4-model LFT has been measured with 1/4 wavelengths or 4 times higher frequencies~#cite(<Takakura2019IEEE>). On the MHFT side, a forthcoming optical RF demonstration model for HFT is being built and will be characterized at warm temperatures. For those measurements, dedicated compact-antenna test ranges (CATRs) are being developed both
in Japan and in Europe, using broadband coherent and blackbody sources. The co- and cross-polarization responses are also assessed using a polarized source. From those measurements, the optical modeling of the instrument will be consolidated.
A cryogenic characterization will then follow to account for the 5-K nominal working temperature of the telescopes (hence the related thermo-mechanical deformations), as well as for sub-systems whose RF characteristics depend on temperature, such as the index of refraction of MHFT lenses for instance. This will allow us to map (within a limited angular range) the beam response using a 5-K compatible detector with a corresponding beam former. Several techniques are under study to measure the beam patterns at cryogenic temperature, e.g., near-field versus
far-field using a CATR with a continuous coherent source or with a blackbody.


During the end-to-end calibration campaign for which each instrument will be fully integrated and cryogenically cooled in a chamber for a characterization of in-flight-like conditions, near-field verifications are also foreseen.

Finally measurements of diffraction effects due to V-grooves and structures of the MHFT/LFT will be performed at the PLM level at room temperature. Those effects are expected to be small (below $- 60 thin$dB from the main peak).


==== Prospects for In-flight Calibration
<prospects-for-in-flight-calibration>
For the main beam, as was the case for ~@Planck2015IV @Planck2015VII, we plan to use the signals of outer planets (Mars, Jupiter, etc.) to reconstruct the most important parameters of the radiation pattern for each detector. The idea is that we can assume that a planet, given its limited angular size with respect to the FWHM of 's beams and its considerable brightness,#footnote[Jupiter, the planet with the largest apparent size, is always smaller than 0.5 arcmin, and the brightness temperature of the outer planets at the frequencies of interest
for #emph[LiteBIRD] are typically two orders of magnitude brighter than the CMB.] can be considered as a bright point source that "samples" the radiation pattern $gamma ( upright(bold(r)) )$. With these assumptions, one can estimate the value of $gamma ( upright(bold(r)) )$ using $ gamma (bold(r)) prop frac(Delta T_("pl") (bold(r)), T_("B,pl")) frac(Omega_b, Omega_("pl")) . $ <eq:beams:inflight:beamFromTemperature> Here $Delta T_("pl")$ represents the component of the signal that is caused by the presence of the planet along direction $upright(bold(r))$,
$Omega_b = integral_(4 pi) gamma (bold(r)) dif Omega$ is the angular beam size, $Omega_("pl")$ is the solid angle subtended by the planet, and $T_("B,pl")$ is the brightness temperature of the planet in the frequency band sampled by the detector.


We have used @eq:beams:inflight:beamFromTemperature to simulate how accurately we can expect to reconstruct the shape of $gamma$, assuming that the radiation pattern has a perfectly symmetric Gaussian profile. Specifically, we simulated the scanning strategy of the #emph[LiteBIRD] spacecraft and computed the amount of observation time spent on Jupiter along each direction $upright(bold(r))$ on the $4 pi$ sphere in the reference frame of the detector. To estimate $T_("B,pl")$, we have used the estimates for Jupiter's
spectral energy distribution published in Refs.~@Maris2021 and #cite(<PlanckIntLII>). A plot of $gamma ( upright(bold(r)) )$ and the related expected error for one of the 40-GHz detectors is shown in @fig:beams:inflight:beammap.


// [figvision-cn] imgs/inflight_beam_cal_gamma.png
// 该图像为一张二维彩色填充等高线图，用于展示LiteBIRD探测
// 器40GHz频段的在轨光束校准模拟中的主波束光学响应。 横坐
// 标轴标记为“U coordinate”，纵坐标轴标记为“V coordinate”，
// 两者单位均为弧度（radians）。两个坐标轴的数值范围均从
// -0.04延伸至0.04，刻度间隔为0.01。 图像背景为纯黑色。图
// 中央呈现一个以原点(0.00, 0.00)为中心的同心圆状分布图案。
// 颜色映射采用渐变色带：中心区域为最亮的灰白色，向外依次
// 过渡为浅青色、蓝灰色、深蓝色，直至边缘的纯黑色。这种颜
// 色分布表示波束响应的振幅强度，中心最强，向四周逐渐衰减。
// 右侧设有一个垂直的颜色条（色标），用于定量指示归一化振
// 幅值。色标底部对应数值0.00（黑色），顶部对应数值1.05（
// 灰白色）。色标上标注了具体的数值刻度：0.00、0.15、0.30、
// 0.45、0.60、0.75、0.90和1.05。 图中绘制了三条红色的闭
// 合等高线，分别代表特定的振幅水平。最内侧的一条红色曲线
// 包围着中心亮区，线上标注有红色文字“0.900”；中间的一条
// 红色曲线位于较暗的蓝灰色区域，标注有红色文字“0.600”；
// 最外侧的一条红色曲线位于深色区域，标注有红色文字“0.300
// ”。这些红色线条精确地界定了相应振幅值的边界位置。
// [figvision-cn] imgs/inflight_beam_cal_gamma_error.png
// 这是一张二维彩色等高线填充图，展示了在U-V坐标系下的光
// 学响应主波束及其重建误差分布。 横坐标轴标记为“U
// coordinate”，纵坐标轴标记为“V coordinate”。两个坐标轴
// 的数值范围均为-0.04到0.04，刻度间隔为0.01，单位均为弧
// 度（radians）。 图像右侧设有一个垂直的颜色条（色标），
// 用于指示图中颜色对应的物理量数值。色标数值范围从底部的
// 0.015到顶部的0.135，刻度标记包括0.015、0.030、0.045、
// 0.060、0.075、0.090、0.105、0.120和0.135。颜色映射采用
// 单色调渐变：数值最低的区域（接近0.015）显示为黑色；随
// 着数值增加，颜色逐渐过渡为深蓝色、蓝灰色、浅青色，最高
// 数值区域（接近0.135）显示为极浅的青白色。 图像背景主要
// 由黑色和深蓝色区域构成，代表较低的数值基底。在此背景上，
// 散布着大量不规则形状的斑点，这些斑点的颜色较亮（呈现蓝
// 灰色至浅青色），表示局部数值较高。其中几个较为显著的亮
// 斑位置大约位于：U=-0.015, V=0.02附近；U=0.005, V=-0.01
// 附近；以及U=0.03, V=-0.025附近。 图像中心叠加了一个灰
// 色的圆环。该圆环以坐标原点(0, 0)为中心，半径约为0.02弧
// 度。圆环线条清晰，覆盖在下方的等高线图之上。 该子图传
// 达了LiteBIRD探测器在飞行中波束校准模拟中的误差分布情况。
// 深色背景表明大部分区域的误差值较低，而散布的亮斑代表了
// 误差较高的特定空间频率点。中心的灰色圆环可能标示了特定
// 的分析区域或波束主瓣的范围。整体趋势显示误差分布是不均
// 匀的，存在局部的峰值。
// [figvision-cn] imgs/inflight_beam_cal_gamma.png
// 该图像为一张二维彩色填充等高线图，用于展示LiteBIRD探测
// 器40GHz频段的在轨光束校准模拟中的主波束光学响应。 横坐
// 标轴标记为“U coordinate”，纵坐标轴标记为“V coordinate”，
// 两者单位均为弧度（radians）。两个坐标轴的数值范围均从
// -0.04延伸至0.04，刻度间隔为0.01。 图像背景为纯黑色。图
// 中央呈现一个以原点(0.00, 0.00)为中心的同心圆状分布图案。
// 颜色映射采用渐变色带：中心区域为最亮的灰白色，向外依次
// 过渡为浅青色、蓝灰色、深蓝色，直至边缘的纯黑色。这种颜
// 色分布表示波束响应的振幅强度，中心最强，向四周逐渐衰减。
// 右侧设有一个垂直的颜色条（色标），用于定量指示归一化振
// 幅值。色标底部对应数值0.00（黑色），顶部对应数值1.05（
// 灰白色）。色标上标注了具体的数值刻度：0.00、0.15、0.30、
// 0.45、0.60、0.75、0.90和1.05。 图中绘制了三条红色的闭
// 合等高线，分别代表特定的振幅水平。最内侧的一条红色曲线
// 包围着中心亮区，线上标注有红色文字“0.900”；中间的一条
// 红色曲线位于较暗的蓝灰色区域，标注有红色文字“0.600”；
// 最外侧的一条红色曲线位于深色区域，标注有红色文字“0.300
// ”。这些红色线条精确地界定了相应振幅值的边界位置。
// 的分析区域或波束主瓣的范围。整体趋势显示误差分布是不均
// 匀的，存在局部的峰值。
#figure(placement: top, [#box(image("imgs/inflight_beam_cal_gamma.png", width: 48.0%)) #box(image("imgs/inflight_beam_cal_gamma_error.png", width: 48.0%)) #box(image("imgs/inflight_beam_cal_gamma_over_error.png", width: 48.0%))

  ],
  caption: [
    #emph[Top left]: Representation of the main beam of the optical response $gamma ( upright(bold(r)) )$ for a 40-GHz #emph[LiteBIRD] detector, in $( u , v )$ coordinates (in radians), used in the simulations of the in-flight beam calibration. Here $upright(bold(r)) = 0$ indicates the position of the maximum amplitude of the beam pattern. #emph[Top right]: Representation of the error on the beam reconstruction ($delta gamma$), calculated on the timespan of the #emph[LiteBIRD] mission. #emph[Bottom]: The quantity $gamma \/ delta gamma$, which is the
signal-to-noise ratio of the measurement on $gamma$. The radius of the white ring is equal to the FWHM of the beam and is shown as a reference.
  ]
)
<fig:beams:inflight:beammap>


We have fitted for the two-dimensional Gaussian FWHM#footnote[Since the term $Omega_b = integral_(4 pi) gamma (bold(r)) thin "d" Omega$ in @eq:beams:inflight:beamFromTemperature depends on the unknown quantity $gamma$, this equation should be typically solved using an iterative algorithm; we chose to neglect this complication and assume that $Omega_b$ is perfectly known in advance.] of the reconstructed beam pattern of 500 Monte Carlo simulations. The following assumptions have been made: (a) the
nominal #emph[LiteBIRD] scanning strategy parameters are used, i.e., we did not study the possibility of dedicated, deep planetary scans; (b) the mission lasts 3 years starting from 1 January 2027; (c) only the part of the $gamma ( upright(bold(r)) )$ map within 3 times the FWHM from the main beam axis was considered for the fit; and (d) the analysis was run for one detector at 40 GHz (LFT), one at 166 GHz (MFT), and one at 402 GHz (HFT).


The results of our simulations are reported in @tab:beams:inflight:MCMCerrors. All the errors are well below 1 %, with the result at 402 GHz being the largest in relative terms (0.4 %). The variability of the error estimates in our results#footnote[In a real-world scenario, part of this variability could also be due to the dependence of the planetary apparent radius on the observed frequency band, at least for gaseous planets.] depends on the combination of several factors: (a) the brightness temperature within the bandwidth of the detector; (b) the FWHM
of the radiation pattern; and (c) the white noise level of the detector.


#figure(
  align(center)[#table(
    columns: 2,
    align: (left,center,),
    table.header([Detector], [Error \[arcmin\]],),
    table.hline(),
    [LFT (40 GHz)], [0.09],
    [MFT (166 GHz)], [0.03],
    [HFT (402 GHz)], [0.07],
  )]
  , caption: [Estimated error on the reconstruction of the FWHM of the radiation pattern for three #emph[LiteBIRD] detectors.]
  , kind: table
  ) <tab:beams:inflight:MCMCerrors>



The estimation of the error does not take into account all sources of errors and systematic effects to be expected from real-world data. Examples include: uncertainty in background subtraction; presence of correlated noise in the timelines variability in the planetary emission; non-Gaussianities of the beams; and non-linearities and saturation of the bolometers. A rough estimation of those effects has been performed while running the same simulation code on #emph[Planck] LFI data. The derived error is 2--2.5 times larger than the one quoted in
@Planck2015IV; therefore, we can expect that a similar degradation will be experienced in the error estimates deduced from flight data.


Assuming a $2.5$ degradation factor for the results in @tab:beams:inflight:MCMCerrors leads to a relative error in the range 0.25--1 %, where the lower bound applies to the channels dominated by cosmological signal. We expect that this error is small enough for data analysis, although a full end-to-end simulation is required to propagate the uncertainties down to the scientific products. Note that the estimation here only relies on a single source, Jupiter, and thus concatinating other planets in future analyses should give a modest improvement in the
statistical error. Should the error be too large, we will consider the possibility to run dedicated observations of planets to increase the integration time.


To complete this picture, a preliminary estimation using data from #emph[Planck] of the additionnel optical loading from head-on observations of Jupiter is approximately 1 % at 40 GHz, 10 % at 140 GHz, and 80 % at 337 GHz of the expected optical loading per band. The global impact of the detector non-linearities and saturation is under study.


For the sidelobes, cross-checks between in-flight data, simulations, and ground-based characterization are foreseen. For example, using Galactic plane crossings and studying the beam shape as a decomposition of multiple functions.


==== Beam Effects Coupling with Other Systematics
<beam-effects-coupling-with-other-systematics>
Some of the systematic effects appear as a combined effect of the beam together with other instrumental effects. Without going into full details, we briefly describe the nature of such effects.

- Frequency-dependent beam shape. This effect can be treated as a photometric gain calibration and will be discussed in a future publication. The detailed study of the photometric gain calibration requirement is described in the next section.

- Bolometer transfer function and beam shape degeneracy in the time domain. This effect is related to both the time constant and to the optical crosstalk. For the former, we expect the nominal time constant of the bolometer to be a few tens of milliseconds~#cite(<Westbrook2020SPIE>). The two effects can be decoupled by simultaneously fitting them with planet observations, as was done for ~#cite(<Planck2013VII>). For the latter, any ghosting effect due to the internal reflections within the optical system can result in an extra beam feature that is
different from the designed main beam. This can be dealt with in the analysis either as an extra sidelobe feature of the beam or as crosstalk over the focal plane. We will use planetary beam observations to monitor this effect, while electrical crosstalk will be calibrated prior to flight. As such, we foresee the ability to separately assess the electrical crosstalk so that it will not be degenerate with the optically induced crosstalk.


=== Bandpasses
<bandpass-calib-section>
==== Requirements
Bandpass frequency-resolution requirements have been studied in Ref.~@Ghigna2020, where an ideal rotating HWP has been assumed. The requirements are driven by the color-correction~@Planck2013IX uncertainty, that results from the calibration of the foreground signal when the CMB dipole is assumed as the photometric calibrator. With decreasing frequency-resolution of the bandpass response, the color-correction uncertainty increases. This appears clear from the expression for the color-correction factor $gamma$:
$ gamma_(d,s) = frac(integral dif nu G(nu) frac(I_(d,s)(nu), I_(d,s)(nu_0)), integral dif nu G(nu) frac(∂ B(nu, T), ∂ T) |_(T_0)) frac(∂ B(nu_0, T), ∂ T) |_(T_0) , $ <eq:colorCorrection> where the indices "d" and "s" refer, respectively, to dust and synchrotron, $G ( nu )$ is the band-pass function, $I_d ( nu )$ ($I_s ( nu )$) is the dust (synchrotron) spectrum, $nu_0$ is the effective central frequency of the given band, $B ( nu , T )$ is the blackbody spectrum, and $T_0$ is the CMB temperature.


In Ref.~@Ghigna2020 the color-correction uncertainty resulting from a given finite spectral resolution of the bandpass response has been propagated to a bias on the reconstructed tensor-to-scalar ratio $r$ for all #emph[LiteBIRD] bands. The results show that the high-frequency channels drive the requirements due to the relative brightness of the dust signal.


In @fig:bandpass_Gamma we illustrate the worst case scenario, which corresponds to a top-hat bandpass (with 30 % bandwidth) for the 337-GHz channel and show the color-correction uncertainty as a function of the frequency resolution. The requirement (red dashed line) is found by imposing the resulting tensor-to-scalar ratio bias (after component separation) to be $lt.eq 5.7 times 10^(- 6)$ and corresponds to $0.2$ GHz. The complete analysis shows that the spectral resolution should be in the range $Delta nu tilde.eq 0.2$--2 GHz, depending on the mean frequency of the band.


// [figvision-cn] imgs/DeltaGamma_TopHat_NOnoise.png
// 该图像为单张对数坐标曲线图，展示色校正误差随频率分辨率
// 变化的关系。横轴标记为“Δν (GHz)”，表示频率分辨率，采用
// 对数刻度，范围从0.10 GHz到10.00 GHz，主刻度线位于0.10、
// 1.00和10.00处。纵轴标记为“δν”，无量纲，同样采用对数刻
// 度，显示范围从低于10⁻³至高于10⁻²，主刻度线标注为10⁻³和
// 10⁻²。 图中包含三条曲线： 蓝色实线代表RMS（均方根）值，
// 对应于100次重采样实现的统计结果。该曲线在Δν = 0.10 GHz
// 时起始于约4×10⁻，随Δν增加而波动上升；在Δν ≈ 0.6 GHz处
// 首次穿越红色虚线阈值，在Δν ≈ 1.0 GHz后持续高于该阈值，
// 并在Δν = 10.00 GHz时达到约3×10⁻²。整条曲线呈现高频振荡
// 特征，振幅随Δν增大而增强。 橙色实线代表||MAX||（最大绝
// 对值），始终位于蓝色实线上方。其在Δν = 0.10 GHz时起始
// 于约7×10⁻⁴，在Δν ≈ 0.3 GHz处即已显著超过红色虚线，并随
// Δν增加单调递增，在Δν = 10.00 GHz时达到约5×10⁻²。该曲线
// 同样具有高频振荡结构，但整体趋势更陡峭。 红色水平虚线
// 标记为“requirement”，表示性能要求阈值，恒定位于δν =
// 1.5×10⁻³处，横跨整个横轴范围。 左上角设有图例框，内含
// 三项说明：第一项为蓝色实线段配文字“RMS”；第二项为橙色
// 实线段配文字“||MAX||”；第三项为红色虚线段配文字“
// requirement”。 该图传达的核心结论是：随着频率分辨率Δν
// 降低（即数值增大），色校正误差δν显著增加。当Δν超过约
// 0.6 GHz时，RMS误差已超过预设要求阈值；而当Δν大于0.3
// GHz时，最大误差已远超该阈值。这表明为满足色校正精度要
// 求，系统需维持较高的频率分辨率（建议Δν < 0.3 GHz）。
// [figvision-cn] imgs/DeltaGamma_TopHat_NOnoise.png
// 该图像为单张对数坐标曲线图，展示色校正误差随频率分辨率
// 变化的关系。横轴标记为“Δν (GHz)”，表示频率分辨率，采用
// 对数刻度，范围从0.10 GHz到10.00 GHz，主刻度线位于0.10、
// 1.00和10.00处。纵轴标记为“δν”，无量纲，同样采用对数刻
// 度，显示范围从低于10⁻³至高于10⁻²，主刻度线标注为10⁻³和
// 10⁻²。 图中包含三条曲线： 蓝色实线代表RMS（均方根）值，
// 对应于100次重采样实现的统计结果。该曲线在Δν = 0.10 GHz
// 时起始于约4×10⁻，随Δν增加而波动上升；在Δν ≈ 0.6 GHz处
// 首次穿越红色虚线阈值，在Δν ≈ 1.0 GHz后持续高于该阈值，
// 并在Δν = 10.00 GHz时达到约3×10⁻²。整条曲线呈现高频振荡
// 特征，振幅随Δν增大而增强。 橙色实线代表||MAX||（最大绝
// 对值），始终位于蓝色实线上方。其在Δν = 0.10 GHz时起始
// 于约7×10⁻⁴，在Δν ≈ 0.3 GHz处即已显著超过红色虚线，并随
// Δν增加单调递增，在Δν = 10.00 GHz时达到约5×10⁻²。该曲线
// 同样具有高频振荡结构，但整体趋势更陡峭。 红色水平虚线
// 标记为“requirement”，表示性能要求阈值，恒定位于δν =
// 1.5×10⁻³处，横跨整个横轴范围。 左上角设有图例框，内含
// 三项说明：第一项为蓝色实线段配文字“RMS”；第二项为橙色
// 实线段配文字“||MAX||”；第三项为红色虚线段配文字“
// requirement”。 该图传达的核心结论是：随着频率分辨率Δν
// 降低（即数值增大），色校正误差δν显著增加。当Δν超过约
// 0.6 GHz时，RMS误差已超过预设要求阈值；而当Δν大于0.3
// GHz时，最大误差已远超该阈值。这表明为满足色校正精度要
// 求，系统需维持较高的频率分辨率（建议Δν < 0.3 GHz）。
#figure(placement: top, [
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    image("imgs/TopHat_NOnoise.png", width: 100%),
    image("imgs/DeltaGamma_TopHat_NOnoise.png", width: 100%),
  )
  ],
  caption: [
    Bandpass and color correction. #emph[Left:] Top-hat bandpass response (in solid blue) at 337 GHz with 30 % bandwidth. A resampling process with 1-GHz resolution is also shown in orange. #emph[Right:] Calculation of the color correction error for dust ($delta gamma_d$) as a function of decreasing resolution for the bandpass response on the left. The blue solid line represents the rms value for 100 realizations of the resampling process with a given resolution, while the orange solid line represents the maximum value among 100 realizations. The
requirement is shown by the red dashed line. Figure from @Ghigna2020
  ]
)
<fig:bandpass_Gamma>


The detailed allocations from the current requirement to each hardware component are yet to be assigned. Comprehensive studies of the requirements, including the effects of more complicated foregrounds, such as CO lines, are beyond the scope of this paper.


==== Prospects for ground calibration
<prospects-for-ground-calibration>
For reference purposes in terms of achievable accuracy for the calibration of a CMB instrument in a space environment, we can consider #emph[Planck]-HFI. The resolution on the reconstruction of the mean frequency of the bandpass was between 0.56 GHz at 100 GHz to 1.57 GHz at 545 GHz, while the bandwidth accuracy was between 0.4 GHz and 3.1 GHz, and the point-per-point spectral resolution of the measurements was sub-GHz~#cite(<Ade2010>). Still, uncertainties in the signal-to-noise (S/N) ratio achieved in these measurements were set by the limitations of
the reference detector used in the calibration facility (see Ref.~@Pajot2010 for a description of the facility). This limitation (especially in the lowest frequency channel, 100 GHz) placed a tension between binning the spectral measurements to gain S/N against having a higher spectral resolution knowledge used in the removal of specific spectral features (such as CO). The strategy for #emph[LiteBIRD] is slightly different. At the component level, the spectral response characterization is planned to be performed using a VNA with extremely high spectral
resolution in order to characterize the potential presence of inherent fringes. At the instrument level, spectral measurements are part of the datacube reconstruction (cf.~@datacube), which should allow us to achieve the required sub-GHz resolution. In addition, the out-of-band rejection (particularly important for component separation), which could be characterized down to levels of $10^(- 12)$, as was done for the #emph[Planck]-HFI filter chains~@Ade2010, will be reconstructed using a combination of component-level and end-to-end cryogenic tests.


=== Polarization Angle
<sss:anglecal>
In this section, we address the calibration of the polarization angle for #emph[LiteBIRD].


==== Requirements


The derivation of the requirements on the relative and absolute polarization angles follows @Vielva_2021. It is driven by the bias on $r$ produced by the miscalibration of polarization angles @wu-etal:2009, taking into account the component separation process. Assuming a given correlation coefficient matrix $rho_(nu_1 nu_2)$ for the angle offset (either relative or absolute angles) of the frequency detector sets $nu_1$ and $nu_2$, it can be shown that the bias on $r$ is related to that matrix by the following expression: $
  chevron.l delta_r chevron.r approx c^2 A (sum_(ell = 2)^(ell_("max")) H_ell) sum_(nu_1 = 1)^(N_("elem")) sum_(nu_2 = 1)^(N_("elem")) rho_(nu_1  thin  nu_2) ,
$ <eq:PVMdeltar2_ave> where $ A &= 4 [sum_(ell = 2)^(ell_("max")) frac((B_ell^("fid"))^2, "Var"(B_ell))]^(-1) , \
  H_ell &= frac(E_ell B_ell^("fid"), "Var"(B_ell)) , $ <eq:PVMcte> in which $B_ell^("fid")$ and $B_ell$ are the fiducial and observed $B$-mode power spectra, respectively, and $E_ell$ is the fiducial $E$-mode power spectrum. @eq:PVMdeltar2_ave provides the requirements on the polarization angle accuracy $sigma_(alpha_nu)$ assuming a bias of $1 thin %$ of the systematics budget in the $r$ parameter.


The requirements on the relative angles refer to the $N_("elem") = 22$ frequency elements that are included in the three focal planes of the LFT, MFT, and HFT (see @ss:forecasts_imo). The following cases are considered:

- Case 0, all 22 elements are uncorrelated, except those within the same telescope, which are fully correlated;

- Case 1, all 22 elements are fully correlated;

- Case 2, all 22 elements are partially correlated ($rho_(nu_1  thin  nu_2) = 0.5$, for any $nu_1 eq.not nu_2$), except those within the same telescope, which are fully correlated;

- Case 3, all 22 elements are uncorrelated (the most ideal case).

The 22 elements correspond to the frequency bands per telescope and per detector pixel size, as listed in @tbl:imo:sensitivities. The results of the relative angle requirements for each of those correlation cases are given in @fig:LBangle_requirement (left panel).


The requirements on the absolute angle consist of a global offset, which accounts for the mismatch between the SVM and the PLM, and three additional ones that account for the mismatch between the PLM and each of the three focal planes. The following cases have been considered:

- Case 0, no correlations;

- Case 1, the four offsets are fully correlated;

- Case 2, the global offset is uncorrelated with any of the three focal plane offsets, and the latter ones are fully correlated.

The corresponding requirements are given in @fig:LBangle_requirement (right panel). They appear less stringent for the high frequency channels, as opposed to the case of most of the other systematic effects, like, for instance, the beam knowledge requirements, which is more stringent at high frequency mainly because of the effect of the higher resolution in these bands.


// [figvision-cn] imgs/figure_pvm_ab_new4_3pt.png
// 该图像包含两个并排的散点图，分别展示不同频率和偏移条件
// 下对极化角度知识的需求。 左侧子图： 类型：散点图（对数
// -对数坐标）。 横轴：频率 [GHz]，范围从约40到400 GHz，
// 刻度标记为50, 100, 150, 200, 250, 300, 350, 400。 纵轴：
// α [arcmin]，表示所需的相对极化角度精度，单位为角分（
// arcmin），对数标度，范围从0.1到100，主刻度线位于0.1, 1
// , 10, 100。 数据系列与符号： LFT频段（低频）：用黑色和
// 绿色数据点表示，分布在约40–90 GHz区间。 MFT频段（中频）：
// 用蓝色数据点表示，分布在约100–220 GHz区间。 HFT频段（
// 高频）：用红色数据点表示，分布在约200–400 GHz区间。 四
// 种相关情形通过不同形状区分： 情形0：方形符号（□） 情形
// 1：圆形符号（○） 情形2：菱形符号（◇） 情形3：三角形符
// 号（△） 趋势与结论：在相同频率下，随着相关情形编号增加
// （0→3），所需相对极化角度精度α增大（即要求更宽松）。在
// 同一相关情形下，随着频率升高，α值总体呈上升趋势，表明
// 高频段需要更高的极化角度知识精度。例如，在情形3（三角
// 形）下，频率从50 GHz增至400 GHz时，α从约20 arcmin上升
// 至超过100 arcmin。 右侧子图： 类型：散点图（线性-线性
// 坐标）。 横轴：类别标签，依次为 GLOBAL、LFT、MFT、HFT，
// 代表四种不同的空间偏移或处理模式。 纵轴：α [arcmin]，
// 表示所需的绝对极化角度精度，单位为角分，线性标度，范围
// 从0到40，主刻度线位于0, 5, 10, 15, 20, 25, 30, 35, 40。
// 数据系列与符号： 三种相关情形通过不同形状区分： 情形0：
// 方形符号（□） 情形1：圆形符号（○） 情形2：三角形符号（
// △） 每个类别（GLOBAL, LFT, MFT, HFT）下均有三个数据点，
// 分别对应上述三种情形。 具体数值近似如下： GLOBAL：情形
// 0 ≈ 4 arcmin，情形1 ≈ 3 arcmin，情形2 ≈ 2 arcmin LFT：
// 情形0 ≈ 14 arcmin，情形1 ≈ 7 arcmin，情形2 ≈ 9 arcmin
// MFT：情形0 ≈ 7 arcmin，情形1 ≈ 4 arcmin，情形2 ≈ 5
// arcmin HFT：情形0 ≈ 36 arcmin，情形1 ≈ 18 arcmin，情形
// 2 ≈ 23 arcmin 趋势与结论：对于所有偏移类型，情形0（方
// 形）所需绝对极化角度精度最高（α最大），情形1（圆形）最
// 低，情形2（三角形）居中。从GLOBAL到HFT，所需精度显著增
// 加，尤其在HFT频段，情形0的α高达约36 arcmin，远高于其他
// 情况。这表明高频段和特定相关情形对绝对极化角度校准提出
// 了更高要求。
#figure(placement: top, image("imgs/figure_pvm_ab_new4_3pt.png", width: 100%),
  caption: [
    #emph[Left:] Required knowledge of the relative polarization angle for the 22 frequency elements within the LFT (black and green), MFT (blue), HFT (red), and the four correlation cases considered: 0 (square); 1 (circle); 2 (diamond); and 3 (triangle). #emph[Right:] Required knowledge of the absolute polarization angle for the four offsets and the three correlation cases considered: 0 (square); 1 (circle); and 2 (triangle). "GLOBAL" stands for the combination of all channels.
  ]
)
<fig:LBangle_requirement>


==== Prospects for In-flight Calibration using $E B$ Cross-correlation
<prospects-for-in-flight-calibration-using-eb-cross-correlation>


For the in-flight absolute angle calibration, we use the methodology of Refs.~#cite(<Minami:2019ruj>) #cite(<Minami:2020xfg>) #cite(<MinamiKomatsu:2020>), which showed that we can calibrate the miscalibration angle, $alpha$, using the #emph[observed] power spectra, including both the CMB and the foreground, using full sky maps. The basic idea is to use the relation between the observed ("o") $E B$ cross correlation and the difference of $E E$ and $B B$ power spectra as
$ chevron.l C_ell^(E B , upright(o)) chevron.r = frac(tan ( 4 alpha ), 2) (chevron.l C_ell^(E E , upright(o)) chevron.r - chevron.l C_ell^(B B , upright(o)) chevron.r) + chevron.l C_ell^(E B) chevron.r , $ where $chevron.l C_ell^(E B) chevron.r$ is the ensemble average of the intrinsic $E B$ cross-correlation, which has been assumed to be zero both for the CMB and the foregrounds. It was shown that we can calibrate the #emph[LiteBIRD] detectors absolute polarization angle with uncertainties of $< 2.7$ arcmin~#cite(<MinamiKomatsu:2020>)


As a part of the feasibility demonstrations, a blind analysis was performed using sky maps that were simulated with a polarization angle offset. This study, summarized in @racpaper2021, showed that the offset angles could be recovered by imposing the null detection of $C_ell^(E B)$, using two different analyses.


This way of calibrating angles, called "self-calibration" @keating-shimon-yadav:2012, eliminates #emph[LiteBIRD]'s ability to probe new parity-violating physics using the cosmological $E B$ correlation. The potential presence of the $E B$ correlation intrinsic to the Galactic foreground emission, which is yet to be found @PlanckIntXLIX @Planck2018XI@huffenberger-rotti-collins:2020@clark-etal:2021, could complicate the analysis further. The method of @Minami:2019ruj can mitigate these complications, restoring 's ability to probe new physics and account
for possible foreground $E B$ signals (see @ss:eb).


==== Prospects for In-flight Calibration using the Crab Nebula
<prospects-for-in-flight-calibration-using-the-crab-nebula>


The Crab Nebula (Tau~A) is one of the brightest compact sources in the sky in the microwave range, and the brightest one in polarization. For this reason, it has been used to calibrate CMB experiments, and is specifically the main target on the sky used to calibrate the polarization direction (together with the $C_ell^(E B)$ technique). Interestingly, recent measurements show a discrepancy of $tilde.eq 1^compose$ between the polarization direction derived through the $C_ell^(E B)$ method and through the use of the Crab~#cite(<2014JCAP...10..007N>) #cite(<2014ApJ...794..171P>)).


@tab:sensitivity_to_crab shows #emph[LiteBIRD]'s expected sensitivities on the measurement of the Crab polarization angle. To obtain these values we have used: (i) a model for the polarization spectrum $S ( nu ) = 79.0 ( nu \/ 1 thin "GHz" )^(- 0.35)$~@2018A-A...616A..35R, and a value of the Crab's secular decrease of $- 0.218 thin % "year"^(- 1)$, derived from #emph[WMAP] data~@Weiland2010; and (ii) #emph[LiteBIRD] mission nominal sensitivities, and a simulation of the satellite scanning strategy that gives the expected integration time at the position
of the source. As can be seen in @tab:sensitivity_to_crab, at the best frequencies the polarization angle of Tau A will be measured with an accuracy of $tilde.eq 1$ arcmin. For comparison, the error in the #emph[Planck]-HFI measurement was $tilde.eq 5$ arcmin~#cite(<Planck2015XXVI>)


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.header([Frequency], table.cell(align: center, colspan: 2)[$Delta gamma$ (arcmin)],),
    table.hline(),
    [2-3 \[GHz\]], [Per frequency band], [Per detector],
    [40], [2.7], [21],
    [50], [2.2], [18],
    [60], [2.6], [21],
    [68], [1.8], [21],
    [78], [1.8], [21],
    [89], [1.7], [21],
    [100], [1.1], [14],
    [119], [1.0], [12],
    [140], [1.2], [14],
    [166], [2.0], [45],
    [195], [2.5], [48],
    [235], [4.9], [79],
    [280], [5.6], [89],
    [337], [6.1], [98],
    [402], [7.1], [130],
  )]
  , caption: [Expected #emph[LiteBIRD] sensitivity (statistical errors) on the measurement of the Crab Nebula polarization angle ($Delta gamma$), per individual bolometer, and when all bolometers in each frequency band are combined.]
  , kind: table
  ) <tab:sensitivity_to_crab>



@tab:sensitivity_to_crab shows that #emph[LiteBIRD] will be able to measure the polarization angle of the Crab with a statistical error that is comparable with the requirement (see @fig:LBangle_requirement), after integration of all detectors in each frequency band. The error per detector is, however, far from the requirement, and therefore precise relative calibration between detectors must be achieved by alternative techniques like ground-based calibration (see below).


An important caveat is that, in this regime of very good statistical accuracy, the error budget will be fully dominated by the uncertainty in the model giving Crab's polarization angle. Currently, the best measurements have statistical errors of $tilde.eq 0.5^compose$~@2010A-A...514A..70A@Planck2015XXVI@2018A-A...616A..35R. However, these observations are dominated by systematic uncertainties, which boost the global error up to to $> 1^compose$~@2020A-A...634A.100A. Recently Ref.~@2018A-A...616A..35R presented a new measurement at 150 GHz obtained with
the NIKA camera mounted on the IRAM 30-m telescope. After combination with previous measurements at different frequencies, and assuming no variation of the polarization angle with frequency, they derived a value for the Crab's polarization angle of $- 87.7^compose plus.minus 0.3^compose$. This error of 18 arcmin is larger than the #emph[LiteBIRD] requirement. Ref.~@2020A-A...634A.100A discussed the prospects for improving the global uncertainty to a level of $tilde.eq 6$ arcmin through the addition of new measurements with individual error bars of around
$0.2^compose$ . This could be attempted through independent ground-based observations, using facilities like NIKA2, SCUBA-2, or SRT~~#cite(<2016SPIE.9914E..03F>) #cite(<doi:10.1142-S2251171715500087>)


Such observations should also allow us to study other possible errors derived from incorrect modeling hypotheses, in particular: (i) the independence of the Crab's polarization angle with frequency; (ii) the time dependence (it is well known that Crab's total-intensity flux density fades with time, but little is known about polarization); and (iii) the impact of the background emission that will affect the #emph[LiteBIRD] measurement due to its coarse beam. Therefore, ideally these observations must: (i) cover a large frequency range; (ii) be spread in
time; and (iii) cover a sufficiently large region around the Crab Nebula ($tilde.eq 2^compose$ across).


The effect of the background contamination is a relevant one, in particular at high frequencies, and we have studied this in detail~#cite(<masi2021crab>). This is illustrated in @fig:crab_reference_angle (left panel), where dust emission in the neighbourhood of the Crab Nebula is evident using 353-GHz data from #emph[LiteBIRD]. This emission is partially polarized, and we have analysed its effect using the Stokes parameter maps measured by #emph[Planck] at the relevant frequencies~@Planck2018II @Planck2018III, convolved with the expected #emph[LiteBIRD]
beams. In order to assess the contribution of surrounding diffuse emission we have estimated the measured polarization angle, after convolving the maps with the beam over increasing radii. The resulting measured angle is significantly different from the polarization angle of the nebula itself, and stabilized for integration radii of the order of 1$""^compose$ (see @fig:crab_reference_angle, center and right panels). The depth of the required surveys of the region has been investigated adding white noise to each 1.7 arcmin pixel in the Stokes $Q$ and $U$
maps, and computing the measured angle obtained by convolution of the $Q$ and $U$ maps with the #emph[LiteBIRD] beams. Repeating the process 10,000 times we find that the standard deviation of the distribution of measured angles is smaller than the required 3 arcmin if the noise per pixel in the reference Stokes parameter maps is below about 30 $mu$K rms at 100 GHz, and 10 $mu$K rms at 337 GHz. These stringent requirements motivate us to explore further detailed measurements of the Crab using forthcoming surveys in order to have the reference maps ready
at the time of the #emph[LiteBIRD] mission.


// [figvision-cn] imgs/crab_reference_angle_V4.png
// 该图由三个子图组成，展示了蟹状星云（Crab Nebula）周围
// 的辐射特性。 左侧子图： 类型：天体物理辐射强度分布图（
// 热图）。 标题：“Planck 343 GHz – Stokes I”。 坐标轴与
// 单位：无显式坐标轴，但底部有一个水平颜色条作为标尺。颜
// 色条范围从0.0030到0.010 Kcmb（亮温度单位）。颜色映射为：
// 绿色代表低强度（0.0030），过渡到蓝色、紫色，最终到洋红
// 色/粉色代表高强度（0.010）。 图像内容：背景显示不同颜
// 色的像素块，中心区域呈现明亮的洋红色十字星形状，对应蟹
// 状星云的高辐射区。周围环绕着蓝绿色的较低辐射背景。 标
// 注与图形元素： 图像中心有一个白色虚线正方形框，内部标
// 注文字“Crab Nebula”。 围绕中心有两个同心圆，均为白色虚
// 线。内圈上方标注“25' FWHM”，外圈上方标注“50' x FWHM”（
// FWHM指半高全宽，单位为角分）。 一个黑色实线正方形框覆
// 盖了大部分中心区域，右上角标注“1°x 1°”，表示该区域的视
// 场大小。 右下角有一个微小的黑色菱形标记。 结论：展示了
// 蟹状星云在343 GHz频率下的Stokes I参数（总强度）分布，
// 并标示了LiteBIRD卫星仪器的波束宽度（25'和50'）以及1度
// 见方的观测区域。 右上侧子图： 类型：散点曲线图。 标题：
// “14HFT”。 纵轴名称：“polarization angle (deg)”（偏振角，
// 单位度），范围从-98到-86。 横轴名称：“integration
// radius (arcmin)”（积分半径，单位角分），范围从0到60。
// 数据系列：图中包含一系列空心菱形符号。 标注：图表左上
// 角标注“f = 337 GHz”，表示频率为337 GHz。 趋势：当积分
// 半径从0增加到约25角分时，偏振角从约-88度迅速下降至-97
// 度左右；当半径超过25角分后，偏振角保持在-97度附近趋于
// 平稳。 右下侧子图： 类型：散点曲线图。 标题：“7MFT”。
// 纵轴名称：“polarization angle (deg)”（偏振角，单位度），
// 范围从-88.0到-87.0。 横轴名称：“integration radius (
// arcmin)”（积分半径，单位角分），范围从0到60。 数据系列：
// 图中包含一系列空心菱形符号。 标注：图表左上角标注“f =
// 100 GHz”，表示频率为100 GHz。 趋势：当积分半径从0增加
// 到约30角分时，偏振角从约-87.0度波动上升至-87.7度左右；
// 当半径超过30角分后，偏振角回升并稳定在-87.0度附近。
#figure(placement: top, image("imgs/crab_reference_angle_V4.png", width: 99.0%),
  caption: [
    Foreground emission surrounding the Crab Nebula. #emph[Left]: 353-GHz #emph[Planck] map (Stokes $I$) centered on the Crab Nebula, displaying foreground emission in its surroundings, compared to the typical beam size of #emph[LiteBIRD]. #emph[Upper Right]: Polarization angle computed by convolving the #emph[Planck] Stokes parameters maps at 337 GHz with the #emph[LiteBIRD]-HFT beam, as a function of the integration radius. #emph[Lower Right]: the same at 100 GHz (MFT).
  ]
)
<fig:crab_reference_angle>


==== Prospects for Ground Calibration
<datacube>
As shown in @fig:calib-stra, the general plan is to characterize the relative polarization angles per focal plane during the end-to-end (E2E) cryogenic operations at the telescope level. Special care will be taken to define a common reference frame or reference transposition from sub-system characteristics to the telescopes, up to the PLM-SVM-integrated instrument.


For reference, the end-to-end ground calibration test campaign for -HFI ultimately achieved an average of $1.5^compose$ accuracy while the sub-system level (i.e., single cooled pixel) testing had achieved an average accuracy of $0.1^compose$~@Rosset2010 #cite(<PlanckIntXLVI>). For #emph[LiteBIRD] since we are using both an HWP and sinuous antenna~#cite(<aritokisuzuki-dthesis>), the bandpasses and the polarization angle are therefore highly coupled. It is possible to test for the overall spectral efficiency of a channel with an unpolarized source, and it
is possible to accurately measure the maximum efficiency angle of a given detector, but for an end-to-end test of the whole instrument, the two effects are combined in a non-trivial way. We therefore plan to cleanly disentangle them via polarized spectroscopy to obtain the two spectro-polarimetric datacubes~#cite(<Savini2009>). The plan is to test the system with two orthogonal inputs (fts, VNA or other coherent source) and to measure spectra at each small variation of HWP angle position in order to be able to reconstruct the expected modulation curve
for any given spectral index source.


The end-to-end calibration operations are complementary to the RF test campaign (cf.~@Ground-beams), which will specifically address the impact of the optical distortion and coating inefficiencies. A measurement campaign has already been performed on the LFT small-scale model and is reported in @Takakura2019IEEE.


In addition, various instrumental parameters may also impact the polarization angle and will be characterized at the component level to check their accuracy with respect to the requirements flowdown, in particular on the knowledge of the encoding angle HWP PMU (cf.~Sects.~#ref(<sss:plm_lft_pmu>, supplement: none) and #ref(<sss:plm_mhft_subsystems>, supplement: none)). In parallel, we are still working on the design and especially on the HWP, since any HWP frequency-dependent fast-axis within the band can result in a mixing of the $Q$ and $U$ polarization
states. Nevertheless, for a sapphire Pancharatnam HWP, there is a recipe that nulls the frequency response, and LFT PMU employs such a recipe to minimize this effect~@Kunimoto2020SPIEDesign, considering the fact that the residual variation may still produce $E$-to-$B$ leakage~#cite(<2012ApJ...747...97B>); the study explicitly for #emph[LiteBIRD] is in progress.


=== Calibration Development Plan
<section:calib-plan>
The previous sections addressed the most challenging operations, but other instrumental parameters will need to be measured in the end-to-end cold integrated campaign. These are summarized in @tbl:calib, together with the experimental setup planned to be used to characterize them and the proposed in-flight reconstruction. A dedicated characterization phase between the launch and arrival at L2 is also planned as a performance-verification phase prior to nominal observations; this phase is not detailed in this paper.


#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    [], [Instrumental param.], [Instrument-level plans], [In-flight plan],
    [], [], [in cryogenic facility], [],
    [Beam], [Far sidelobes], [PLM cross-check], [Absolute gains],
    [(co- and cross-polar)], [Near sidelobes], [RF], [Planet],
    [], [Main Beam], [RF], [Planet],
    [Polarization], [Instrumental polarn.], [E2E/DataCube], [$C_ell^(E B)$ and Crab],
    [], [Absolute angle], [E2E/DataCube], [$C_ell^(E B)$ and Crab],
    [], [Relative angle], [E2E/DataCube], [$C_ell^(E B)$ and Crab],
    [], [Efficiency], [E2E/DataCube], [$C_ell^(E B)$ and Crab],
    [Gain], [Relative gain in time], [E2E/$Delta T$ of the facility], [Correlation with HK],
    [], [Relative and absolute], [E2E/polar. source], [$C_ell$ norm. + Galaxy],
    [], [gains], [], [+ planet + dipole],
    [Cosmic ray], [Cosmic-ray glitches], [], [Glitches],
    [Spectral response], [], [E2E/FTS/DataCube], [],
    [Transfer function], [Noise PSD], [E2E], [All data],
    [], [Detector time const.], [E2E/chopped source], [Glitches, planets],
    [], [Crosstalk], [E2E/polar. source], [Glitches, planets],
    [], [Linearity], [E2E/polar. source], [Glitches, planets],
    [], [Sensitivity to bkg], [E2E/$Delta T$ of the load], [Galactic crossings],
  )]
  , caption: [Instrumental parameters and calibration strategy to assess them in order to meet the accuracy required to meet the systematic budget beyond sub-system testing. ]
  , kind: table
  ) <tbl:calib>



Finally a viability study (not in the baseline plans of the calibration strategy) has been performed for a calibration satellite (L2-CalSat), flying in formation at L2 and able to emit a reference signal~#cite(<Casas_2021>). The calibration satellite is based on the CubeSat standard and has been conceived to travel as a piggy-back integrated on the service platform of the main satellite, #emph[LiteBIRD] itself. A 6U CubeSat is expected to meet the volume needs of the ancillary satellite. An alternative implementation option would be a micro-satellite
capable of reaching L2 autonomously and allowing a major flexibility at the system-design level. However, a major drawback would be the much larger amount of required propellant that would imply a significantly higher cost. The calibration satellite total mass would be 7.2 kg and the required electrical power would be provided by two steerable solar panels and accumulated in a battery module. The solar panels would continuously generate 30 W, enough to feed all the subsystems of L2-CalSat and charge the battery to provide the peak power required during
calibration. L2-CalSat is required to be at a sufficiently far distance, of about 6 km, in order to have thermal power levels at least 4 times lower than the saturation power of the detectors (thermal power levels are maximum at the highest frequency bands). The calibration satellite could help to provide strong control over many systematic errors, since those related to gain, non-linearity, spectral response, pointing, beam patterns, or absolute polarization angle. In particular, our analysis shows that the polar angle error can be reduced below
1 arcmin for each detector. In relation to beam-pattern characterization, the calibration sources could provide noise-floor levels lower than $- 70$ dB in the overall band of interest (from 40 to 400 GHz) with only one calibration session of about 1 day's duration. This would assure a complete and accurate characterization of the beam and in particular of the far sidelobes, placed at more than $10^compose$ from the beam center. We will assess the feasibility as the conceptual study progresses.


= Statistical and Systematic Uncertainties in the Tensor-to-scalar Ratio Measurement
<s:cosmological_forecasts>


This section describes the way that the forecasts on $r$ are derived. @ss:forecasts_imo gives an overview the model of the instrument that is used for the simulations, with a particular focus on the expected statistical noise derivation. @ss:forecasts_fg_cleaning summarizes the assumptions made for the foreground modeling, as well as the strategy concerning component separation. In @ss:forecasts_syst, a review of the main systematic studies and their impact on the derivation of the systematic error on $r$ is detailed. Finally in
Sects.~#ref(<ss:forecasts_delta_r>, supplement: none) and #ref(<ss:extrasuccess>, supplement: none), a summary of the total expected error on $r$ is given, without and with the use of external data sets.


== Instrument Model
<ss:forecasts_imo>




The IMo is a quantitative description of the entire #emph[LiteBIRD] experiment: the three telescopes (LFT, MFT, and HFT); the payload; and the observational strategy. The IMo is used to store and track changes of the instrument design and is used in and interfaced to the forecasts/simulations/data analysis tools. Its use is required to ensure consistency between all the instrumental parameters, and it gives the best current description of the instrumental design. This section gives an overview of the main parameters entering the IMo.


@tbl:imo1 gives the values of the main baseline parameters common to the three telescopes, LFT, MFT, and HFT. The parameters related to the observational scan strategy are further defined by the schematics shown in @fig:PLM-param-Imo. The duration of the mission is assumed to be three years throughout this section, except where explicitly stated otherwise.


We optimize the scan strategy parameters including $alpha$, $beta$, and the spin rate so as to have the distributions as uniform as possible for the hits over the entire sky area and for the scanning directions in individual sky pixels. A spin rate less than 0.05 rpm is found to give non-uniform distributions for both quantities. The precession rate is determined to avoid moire patterns using the procedure described in Ref.~#cite(<Hoang:2017wwv>). The HWP spin rates are set so as not to overlap the HWP harmonics with the science observation frequency
band determined by the beam FWHM. The sampling rate is twice the Nyquist frequency of the HWP modulation.


// [figvision-cn] imgs/LB_scan_at_L2_210622.png
// 这是一张科学示意图，描绘了空间望远镜在日地L2拉格朗日点
// 的观测参数与运动轨迹。图像背景为白色，左侧边缘有一条垂
// 直的黄色色带。 子图内容描述： 整体布局：图像中心偏左位
// 置绘制了一个代表卫星的灰色几何体（类似立方体结构），下
// 方标注文字“L2 point”。一条水平的红色实线贯穿图像中部，
// 穿过卫星中心，向左延伸指向左侧的文字“Sun”（太阳），向
// 右延伸指向右侧的文字“Anti-Sun axis”（反太阳轴）。 左上
// 角区域：有一个灰色的矩形文本框，内部包含三行黑色文字：
// “Observations for 3 years in Sun-Earth L2 Lissajous
// Orbit”（在日地L2李萨如轨道上观测3年）。 左下角区域：有
// 另一个灰色的矩形文本框，内部包含两行黑色文字，定义了角
// 度参数：“Precession angle α = 45 degrees”（进动角α=45
// 度）和“Spin angle β = 50 degrees”（自转角β=50度）。 中
// 心几何关系：从卫星中心引出一条绿色的实线箭头，斜向右上
// 指去，标注为“Spin axis”（自转轴）。该绿色箭头与水平红
// 色轴线之间形成一个夹角，用圆弧标记并标注希腊字母“α”。
// 从卫星中心还引出两条虚线构成的圆锥轮廓，其中一条虚线轴
// 线（Boresight，视轴）与绿色自转轴之间形成夹角，用圆弧
// 标记并标注希腊字母“β”。这两条虚线圆锥代表了望远镜的扫
// 描范围，分别用两个半透明的黄色扇形区域表示，一个指向左
// 上方，一个指向右下方。 运动轨迹与周期： 围绕绿色自转轴
// 的旋转：在绿色箭头周围画有一个黑色的椭圆虚线圈，代表视
// 轴绕自转轴的旋转路径。旁边标注文字“Spin period (20
// min.)”，表示自转周期为20分钟。 围绕反太阳轴的进动：在
// 图像右侧，有一个更大的垂直方向的黑色椭圆虚线圈，其长轴
// 大致沿着垂直方向，短轴沿着水平方向。这个椭圆代表了自转
// 轴绕反太阳轴的进动轨迹。在该椭圆下方标注文字“"
// Precession" period (3.2058 hours)”，表示进动周期为
// 3.2058小时。 右上角区域：标注有大号黑色字体“CMB”（宇宙
// 微波背景辐射）。在图像的最右侧边缘，展示了一个圆形的彩
// 色纹理图的一部分，颜色主要为蓝色、青色和橙色斑点，模拟
// 了CMB的温度涨落分布图，暗示这是望远镜的观测目标。 总结：
// 该图通过几何线条和角度标注，定量展示了卫星如何通过三种
// 运动（自转、进动以及随地球绕太阳公转）来覆盖全天球。具
// 体参数包括自转周期20分钟，进动周期约3.2小时，进动角45
// 度，自转角50度。
#figure(placement: top, image("imgs/LB_scan_at_L2_210622.png", width: 80.0%),
  caption: [
    Schematic of the observational parameters. The telescope boresight is at an angle $beta = 50^compose$ to the spin axis and rotates with a rate of 0.05 rpm. The spin axis is rotated around the anti-Sun direction through precession with an angle $alpha = 45^compose$ in 3.2058 hours. The anti-Sun axis rotates around the Sun in one year. With a combination of the three motions, the boresight can cover the entire sky in half a year.
  ]
)
<fig:PLM-param-Imo>


#figure(
  align(center)[#table(
    columns: 8,
    align: (center,center,center,center,center,center,center,center,),
    table.header([$alpha$], [$beta$], [Precession rate], [Spin rate], table.cell(align: center, colspan: 3)[HWP revolution rate \[rpm\]], [Sampling rate],),
    table.hline(),
    [5-7 \[deg.\]], [\[deg.\]], [\[min.\]], [\[rpm\]], [LFT], [MFT], [HFT], [\[Hz\]],
    [45], [50], [192.348], [0.05], [46], [39], [61], [19],
  )]
  , caption: [Baseline observation strategy and parameters related to the sampling rate.]
  , kind: table
  ) <tbl:imo1>



@tbl:imo:sensitivities summarizes the expected noise and sensitivities of the different frequency bands of #emph[LiteBIRD], together with related key parameters such as beam size (calculated using physical optics simulations similar to those described in @Gudmundsson:20), and number of detectors. The details of the sensitivity calculations are given in Sect.~#ref(<ss:forecasts_imo>, supplement: none) By default the bandpasses are assumed to be tophat functions whose bandwidths are given in the same table.





#figure(
  align(center)[#table(
    columns: 8,
    align: center,
    stroke: 0.4pt,
    [], [ID], [$nu$], [$delta nu$ \[GHz\]], [Beam size], [No. of], [NET$""_("arr")$], [Sensitivity],
    [], [], [\[GHz\]], [($delta nu \/ nu$)], [\[arcmin\]], [detectors], [\[$mu$K $sqrt(s)$\]], [$mu$K-arcmin],
    [LFT], [1], [40], [12 (0.30)], [70.5], [48], [18.50], [37.42],
    [LFT], [2], [50], [15 (0.30)], [58.5], [24], [16.54], [33.46],
    [LFT], [3], [60], [14 (0.23)], [51.1], [48], [10.54], [21.31],
    [LFT], [4], [68], [16 (0.23)], [(41.6, 47.1)], [(144, 24)], [(9.84, 15.70)], [(19.91, 31.77)],
    [comb.], [], [], [], [], [], [8.34], [16.87],
    [LFT], [5], [78], [18 (0.23)], [(36.9, 43.8)], [(144, 48)], [(7.69, 9.46)], [(15.55, 19.13)],
    [comb.], [], [], [], [], [], [5.97], [12.07],
    [LFT], [6], [89], [20 (0.23)], [(33.0, 41.5)], [(144, 24)], [(6.07, 14.22)], [(12.28, 28.77)],
    [comb.], [], [], [], [], [], [5.58], [11.30],
    [LFT/], [7], [100], [23 (0.23)], [30.2/], [144/], [5.11/], [10.34],
    [MFT], [], [], [], [37.8], [366], [4.19], [8.48],
    [comb.], [], [], [], [], [], [3.24], [6.56],
    [LFT/], [8], [119], [36 (0.30)], [26.3/], [144/], [3.8/], [7.69],
    [MFT], [], [], [], [33.6], [488], [2.82], [5.70],
    [comb.], [], [], [], [], [], [2.26], [4.58],
    [LFT/], [9], [140], [42 (0.30)], [23.7/], [144/], [3.58/], [7.25],
    [MFT], [], [], [], [30.8], [366], [3.16], [6.38],
    [comb.], [], [], [], [], [], [2.37], [4.79],
    [MFT], [10], [166], [50 (0.30)], [28.9], [488], [2.75], [5.57],
    [MFT/], [11], [195], [59 (0.30)], [28.0/], [366/], [3.48/], [7.05],
    [HFT], [], [], [], [28.6], [254], [5.19], [10.50],
    [comb.], [], [], [], [], [], [2.89], [5.85],
    [HFT], [12], [235], [71 (0.30)], [24.7], [254], [5.34], [10.79],
    [HFT], [13], [280], [84 (0.30)], [22.5], [254], [6.82], [13.80],
    [HFT], [14], [337], [101 (0.30)], [20.9], [254], [10.85], [21.95],
    [HFT], [15], [402], [92 (0.23)], [17.9], [338], [23.45], [47.45],
    [Total], [], [], [], [], [4508], [], [2.16],
  )]
  , caption: [LiteBIRD sensitivities. We show values related to the sensitivity in 15 observational bands. From left to right the columns are: the telescope covering the band (or "comb." for combined values); the band identification number; the band center frequency in GHz; the bandwidth in GHz and its ratio to the center frequency; the main beam size FWHM in arcmin; the total number of detectors; the array NET in $mu$K $sqrt(s)$; and the sensitivity in $mu$K-arcmin. The two values of the beam size and the sensitivity for the LFT 68-, 78-, and 89-GHz
bands in parentheses are for the two detector pixel sizes of 16 and 32 mm. See @tbl:plm:sensitivities for the detector pixel sizes and detector NETs.]
  , kind: table
  ) <tbl:imo:sensitivities>


The nep of each detector is predicted from a quadrature sum of the expected photon noise ($upright(N E P_("ph"))$), thermal carrier noise of the bolometer ($upright(N E P_("th"))$), readout noise ($upright(N E P_("read"))$), and extra noise ($upright(N E P_("ext"))$) sourced from the environment and unknowns. The NEP of a single detector ($upright(N E P_det)$) may therefore be expressed as $
  upright(N E P_det) = sqrt(upright(N E P_("ph")^2 + N E P_("th")^2 + N E P_("read")^2 + N E P_("ext")^2)) ,
$ <eq:nep> where all the components are assumed to be mutually uncorrelated. The quantity $upright(N E P_("ph"))$ is deduced from the expected loading on the detectors (taking account of the various optical elements, their intrinsic characteristics, and the temperature to which they are cooled), while $upright(N E P_("th"))$ is derived from the temperature of the bath and the expected critical temperature of the bolometers. The readout noise and the external noise are required to increase the internal detector noise (encompassing the detector and the
thermal carrier noise) by no more than 10 % and the total detector noise by 15 %, respectively.


We define the net of a detector as $
  upright(N E T_det) = frac(upright(N E P_det), sqrt(2) thin ( d P \/ d T_("CMB") )) ,
$ where we define the conversion factor from power to CMB thermodynamic temperature through $
  frac(d P, d T_("CMB")) = integral_(nu_1)^(nu_2) #scale(x: 180%, y: 180%)[\[] thin k_B eta ( nu ) #scale(x: 180%, y: 180%)[(] frac(h nu, k_B T_("CMB") ( e^(h nu \/ k_B T_("CMB")) - 1 )) #scale(x: 180%, y: 180%)[)]^2 thin e^(h nu \/ k_B T_("CMB")) thin #scale(x: 180%, y: 180%)[\]] "d" nu .
$ <eq:NETcalculation> The parameters $nu_1$ and $nu_2$ represent the lower and upper edges of the frequency band, respectively, while $eta$ is an overall optical efficiency factor. Detector NETs for each band are shown in @tbl:plm:sensitivities. The NET for an array is calculated as $
  upright(N E T_("arr")) = upright(N E T_det) \/ sqrt(N_det times 0.8) ,
$ where $N_det$ is the number of detectors in the given frequency band and the factor of 0.8 represents a degradation factor for the detector yield. The NETs of a frequency band covered by multiple telescopes are combined into the average $upright(N E T_("comb"))$ as $
  upright(N E T_("comb")) = sqrt(frac(1, sum_i ( 1 \/ upright(N E T_i)^2 ))) ,
$ <eq:ivws> where the index $i$ runs over the telescopes of LFT/MFT/HFT.


Finally, the statistical sensitivity ($sigma_S$) in $mu$K-arcmin is given as $
  sigma_S = sqrt(frac(4 pi f_("sky") thin 2 thin upright(N E T_("comb")^2), t_("obs"))) (10800 \/ pi) ,
$ where we assume the sky coverage fraction $f_("sky") = 1.0$ and $t_("obs") = 3$ years (94,672,800 sec) $times eta$. Here $eta$ is the observation efficiency, derived by taking into account degradation factors on the observation duty cycle ($eta_("duty") = 0.85$), the data loss due to cosmic rays ($eta_("cr") = 0.95$), and a margin $eta_("margin") = 0.95$. Hence we have $eta = eta_("duty") eta_("cr") eta_("margin") = 0.77$. We note that the factor of $upright(sqrt(2))$ here originates from the fact that the polarization is measured using two independent
pieces of data. The total sensitivity is obtained by using the NET values combined with all the NET$""_("comb")$ values of individual frequency channels using @eq:ivws.


== Foreground Cleaning
<ss:forecasts_fg_cleaning>


// [figvision-cn] imgs/LiteBIRD_PTEP_fgs_v03102021.png
// 这是一张对数-对数坐标系的曲线图，展示了LiteBIRD卫星在
// 原始功率谱上的误差条以及相关的宇宙学信号和前景残留。
// 横坐标为角波数 l，采用对数刻度，范围从2延伸至约300，主
// 要刻度标记为2、3、4、5、10、20、30、40、50、100。纵坐
// 标为功率谱 $D_l$，单位为微开尔文平方（$\mu K^2$），同
// 样采用对数刻度，范围从$10^{-7}$到$10^{-1}$，主要刻度标
// 记为$10^{-7}$至$10^{-1}$的整数次幂。 图例位于左上角，
// 包含以下元素： 黑色点状虚线：代表原始B模式（primordial
// BB），参数为张标比 r = 0.00461，光学深度 $\tau$ =
// 0.0544。该曲线在低l值处约为$8 \times 10^{-5} \mu K^2$，
// 随后下降并在l=10附近达到极小值，之后缓慢上升。 黑色长
// 划虚线：代表引力透镜B模式（lensing BB）。该曲线随l增加
// 单调上升，在l=2时约为$1.5 \times 10^{-6} \mu K^2$，在l
// =100时超过$10^{-3} \mu K^2$。 黑色实线：代表总B模式（
// total BB），即上述两条曲线的叠加。 橙色实心区域及中心
// 实线：代表1000个模拟统计前景残差加噪声在前景清理后的结
// 果。橙色实线表示平均值，其周围较浅的橙色区域表示分布范
// 围。该曲线随l增加而显著上升，在l>10后成为主导成分之一。
// 橙色短划虚线：代表前景残差的偏差（bias）。该曲线波动较
// 大，整体呈上升趋势，数值低于橙色平均残差线。 红色矩形
// 块：代表LiteBIRD的总误差条，包含宇宙方差和平均化的有噪
// 前景残差。这些误差条在不同l区间以阶梯状呈现，覆盖了从$
// 10^{-6}$到接近$10^{-3} \mu K^2$的范围，在低l和高l处尤
// 为宽泛。 灰色矩形块：代表宇宙方差极限误差条，仅包含原
// 始和透镜B模式的方差。这些灰色区域被红色误差条部分覆盖，
// 宽度小于红色误差条，表明总误差大于宇宙方差极限。 图中
// 趋势显示：在低l区域（l<10），原始B模式信号占主导；随着
// l增加，透镜B模式和前景残差逐渐增强。LiteBIRD的总误差条
// （红色）在大部分l范围内都远大于宇宙方差极限（灰色），
// 说明前景污染是限制探测精度的主要因素。橙色平均残差线在
// 高l处迅速上升，表明即使经过清理，前景残留仍会显著影响
// 高l区域的测量。
#figure(placement: top, [#block[
  #box(image("imgs/LiteBIRD_PTEP_fgs_v03102021.png", width: 100.0%))
  ]],
  caption: [
    #emph[LiteBIRD] error bars on the primordial $B B$ power spectrum for $r = 0.00461$ and $tau = 0.0544$, where $D_ell = ell ( ell + 1 ) C_ell \/ 2 pi$. There are two types of error bars: cosmic-variance (including primordial and lensing $B$-mode variance) shown as gray boxes; and total error bars (including cosmic variance and averaged, noisy foreground residuals), shown in red. The input foreground maps are described in @sec:reference_skies. The solid orange curve represents the average total residuals (including statistical and systematic foreground
residuals, as well as noise after component separation, accounted as $N_ell$ in @eq:cl-measured-in-likelihood), with the light band corresponding to the scatter across noise simulations. The dashed orange curve represents the noiseless foreground residuals, interpreted as the bias on $B$-mode power, eventually leading to a bias on the tensor-to-scalar ratio. Although the contribution of the statistical foreground residuals, noise, and lensing $B$ modes are included in the error bars, the latter are centered on the
theoretical primordial $B B$ curve.
  ]
)
<fig:xforecast-results-pysm>


In this section, we describe the reference sky we adopt, and which elements from the IMo in @ss:forecasts_imo we exploit in order to generate the -simulated multi-frequency input maps for treatment through component separation. We then describe various methodologies, as well as the products of these analyses that are exploited in the following sections.


=== Reference Skies
<sec:reference_skies>
We adopt a native resolution of all maps corresponding to `HEALPix` $N_("side") = 512$~@gorski-etal:2005. The diffuse emission, corresponding to CMB and Galactic foregrounds, are in thermodynamical CMB temperature units, $mu$K$""_("CMB")$. The CMB angular power spectra correspond to the #emph[Planck] 2018 best-fit parameters @Planck2018VI, with the six $Lambda$CDM parameters corresponding to $H_0 , Omega_b h^2 , Omega_c h^2 , tau , n_s , A_s$ = $67.36 med "km" thin s^(- 1) thin "Mpc"^(- 1) , 0.02237 , 0.12 , 0.0544 , 0.965 , 2.099 times 10^(- 9)$, with
lensing and with no tensors, i.e., $r = 0$.


Diffuse foregrounds are produced with the public package Python Sky Model (`PySM`) with default implementation of the amplitude of foregrounds, and spatially varying spectral indices~#cite(<2017MNRAS.469.2821T>) #cite(<2021arXiv210801444Z>), corresponding to the `d1s1` parametrization in `PySM`. The Galactic polarized emission is composed of thermal dust and synchrotron models, dominating the polarization emission at frequencies higher and lower than about 70 GHz, respectively~@krachmalnicoff-etal:2018. In this work, the polarized synchrotron emission is modeled as $
  \[ Q_s , U_s \] ( hat(n) , nu ) = \[ Q_s , U_s \] ( hat(n) , nu_(*) ) (nu \/ nu_(*))^(beta_s ( hat(n) )) thin ,
$ <eq:synchspectrum> where $\[ Q_s , U_s \] ( hat(n) , nu )$ are the Stokes parameters of synchrotron emission in Rayleigh-Jeans (RJ) temperature units on a given line of sight $hat(n)$ at a frequency $nu$, $nu_(*)$ is a reference frequency, and $beta_s ( hat(n) )$ is the spatially-varying synchrotron spectral index. On the $50 thin %$ sky mask shown in @fig:foreground_masks, the `PySM` template gives $beta_s = - 2.993 plus.minus 0.046$. The polarized thermal dust emission is modeled as a modified blackbody, corresponding to the expressions $
  \[ Q_d , U_d \] ( hat(n) , nu ) = \[ Q_d , U_d \] ( hat(n) , nu_(*) ) (nu \/ nu_(*))^(beta_d ( hat(n) ) - 2) frac(B \[ nu  thin  T_d ( hat(n) ) \], B \[ nu_(*)  thin  T_d ( hat(n) ) \]) thin ,
$ <eq:mbbspectrum> where $\[ Q_d , U_d \] ( hat(n) , nu )$ are the Stokes parameters of thermal dust emission in RJ temperature units, $beta_d ( hat(n) )$ is the dust spectral index (power-law index of dust emissivity), $T_d ( hat(n) )$ is the effective temperature of dust, and $B ( nu , T_d )$ is a blackbody spectrum with a temperature $T_d$. Similarly to the synchrotron spectral index, `PySM` templates show $beta_d = 1.534 plus.minus 0.028$ and $T_d = 22.23 plus.minus 1.56$K variations across the $f_("sky") = 49.5 thin %$ mask shown in
#ref(<fig:foreground_masks>, supplement: none). The total intensity of dust and synchrotron scale in frequency just like polarization. According to predictions~#cite(<Puglisi_2018>) #cite(<li2021>), obtained using the publicly available Point Source ForeCast package,#footnote[#link("giuspugl.github.io/ps4c/index.html")] polarized compact sources are expected not to play a major role in #emph[LiteBIRD] measurements; bright radio sources will need to be removed with dedicated filters, and for the infrared populations only upper limits exist in
polarization ~#cite(<Planck2015XXVI>). Thus, we do not include their treatment in the present work, focusing on the capabilities of #emph[LiteBIRD] to deal with diffuse foregrounds.


=== Input Maps
<sec:input_maps>


The templates of the reference sky described above are scaled in frequency using the `PySM` prescriptions and combined with instrumental features from the IMo. These are specifically:

- bandpass integration;

- beam convolution;

- addition of white noise.

The IMo objects used for the above operations are described in @ss:forecasts_imo and we report here their exploitation for achieving the series of multi-frequency maps to be processed by component separation. All templates are convolved with top-hat bandpasses (see @tbl:imo:sensitivities for the band centers and widths) and co-added to form input sky maps. Concerning beam convolution, two series of maps are produced, for comparison purposes. The first one is a direct convolution with a Gaussian circular beam shape with FWHMs from the IMo. The second one
is a timeline-based series of simulations, generated with the public package toast#footnote[#link("hpc4cmb.github.io/toast")]. The convolution of the signal with the beam simulated in `GRASP` (encoding for the whole $4 pi$ beam pattern) is performed with the `libconviqt`#footnote[#link("https://github.com/hpc4cmb/libconviqt")] library, implementing beam convolution on a sphere based on @Pr_zeau_2010.


For the first set of simulations, the noise was added to the co-added multi-frequency and multi-component maps for the Gaussian circular beam convolutions. A total of 1000 noise and CMB simulations were made available using the procedures described in the next subsection. We use the second set for a study of the beam far sidelobe systematic effects in @sec:beam-systematics.


=== Component Separation
<sec:component_separation>


CMB extraction and diffuse foreground reconstruction may be achieved through broad classes of techniques @Planck2018IV[and references therein]. Parametric fitting consists of constructing a sky model on the basis of a suitable parametrization of foreground and CMB unknowns and estimating the latter by exploiting a multi-frequency data set. Internal linear combination and template-fitting methods consist of the minimization of a linear mixture of the multi-frequency data and the subtraction of foreground templates that come from external data, or are
derived internally, respectively. Baseline results for the present paper were obtained with such a parametric fitting method, as discussed below.


In the parametric map-based component-separation tool "ForeGround Buster" (FGBuster#footnote[#link("github.com/fgbuster/fgbuster")] @stompor-etal:2009), our approach is to assume a foreground model with three spectral parameters determining their seds: a spectral index $beta_d$ and a temperature $T_d$ of a modified blackbody for dust; and the spectral index $beta_s$ of a power law for synchrotron. These spectral parameters are assumed to be constant over `Healpix` pixels at a given $N_("side")$. Of course, this represents an approximation of the model,
whereas the foreground spectral parameters will in general vary smoothly across the sky. In order to balance between the statistical uncertainties sourced by the number of free parameters, and the need for a flexible enough model capturing the input-sky complexity (especially the spatial variability of the SEDs), we fit the different spectral parameters at different resolutions depending on Galactic latitude. Since the optimal balance depends on the sky region, we divide the sky into (almost) isolatitude areas covering 20 % of the sky each; we rank them
by their expected level of foreground contamination and consider only the three least contaminated. The $N_("side")$ parameters for these regions are given in @tab:ThreeNsides. Here the three columns correspond to the three 20 %-parts of the sky, from the lowest to highest Galactic latitudes, defined from the #emph[Planck] post-processing masks adopted for component separation @Planck2018IV, referred to as #emph[GAL20], #emph[GAL40], and #emph[GAL60], available on the Planck Legacy Archive#footnote[#link("pla.esac.esa.int")] and shown in
@fig:foreground_masks. The frequency coverage and sensitivity of #emph[LiteBIRD] allow us to estimate foreground parameters and CMB amplitudes in suitably small sky areas or resolution elements. Thus, the number of non-linear parameters, $beta_d , T_d , beta_s$, as driven by the resolutions in @tab:ThreeNsides, computed in the $f_("sky") = 49 %$ observed sky, is precisely $24 , 545$. The number of $Q$/$U$ amplitudes contained in the recovered CMB, dust and synchrotron maps is $144 , 534$. Therefore, in total, the component-separation process deals with
$169 , 079$ free parameters. This can be compared to the $10^6$-long data vector as formed by the observed $Q$/$U$ amplitudes in the 22 frequency channels.


#block[
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([], table.cell(align: center, colspan: 3)[Galactic latitude],),
    table.hline(),
    [2-4], [Low], [Medium], [High],
    [$beta_d$], [64], [64], [64],
    [$T_d$], [8], [4], [0],
    [$beta_s$], [4], [2], [2],
  )]
  , caption: [Values of $N_("side")$ for foreground parameter variations in three different 20 % large regions of the sky. The $N_("side")$ values are chosen to capture most of the spatial variability of the spectral indices and to keep the resulting foreground bias under control while not increasing the statistical uncertainty. The angular resolution for $beta_d$ is kept to the maximum allowed ($N_("side") = 64$), since #emph[LiteBIRD] turns out to be particularly sensitive to this parameter.]
  , kind: table
  ) <tab:ThreeNsides>

]


The unmodeled foreground component leaks into the CMB reconstruction and sources the foreground systematic residuals reported in @fig:xforecast-results-pysm and eventually can give a non-zero bias on $r$, as introduced in~@stompor-etal:2016. The noisy estimation of the spectral parameters, instead, sources the so-called "statistical foreground residuals" and eventually the uncertainty $sigma ( r )$. We estimate the latter with a Fisher-matrix approach, where the total covariance ${C}$ contains CMB lensing, noise, and statistical residuals. Namely, we
calculate the second derivative of the likelihood as $F = - chevron.l partial^2 log ( cal(L) ) \/ partial r^2 chevron.r$ and obtain $ sigma ( r = 0 ) = 1 \/ sqrt(F) . $<eq:sigma-r-definition> Here, $- 2 log cal(L) = f_("sky") ("tr" C^(- 1) D + log det C)$, where ${D}$ is the simulated data vector~#cite(<Errard:2018ctl>), calculated using the noise and residuals spectra averaged over 1000 foregrounds+noise realizations. For each of them, any non-zero recovered CMB $B$ modes are interpreted as foreground leakage.


// [figvision-cn] imgs/mask_and_regions.png
// 该图像为一幅全天空天球投影示意图，采用椭圆形（
// Mollweide）投影展示整个天球。图中没有坐标轴刻度或数值
// 范围，而是通过颜色区域划分来表示不同数据处理状态的天区
// 分布。 整体布局：图像呈横向椭圆，覆盖从北天极到南天极
// 的完整天球。颜色区域沿银道面（大致水平穿过图像中部）对
// 称分布，但存在局部不规则斑块。 颜色编码与物理含义： 灰
// 色区域：代表被排除在前景分析之外的天空区域。这些区域主
// 要分布在图像中央一条宽阔的带状区域（对应银河系盘面），
// 以及若干分散的不规则斑块。灰色区域总面积约占整个椭圆的
// 60%以上，表明大部分天区因前景污染严重而未纳入后续分析。
// 黄色区域：位于图像顶部和底部边缘，代表具有均匀分辨率的
// 前景光谱参数区域。黄色区域呈连续带状，环绕南北两极，宽
// 度随纬度变化，在极点附近最宽。 青绿色区域：紧邻灰色区
// 域两侧，形成过渡带，同样表示具有均匀分辨率的前景参数区
// 域，但其空间分布比黄色区域更破碎、不规则。 深紫色区域：
// 嵌入在青绿色区域内，呈细碎斑块状，也属于“均匀分辨率”类
// 别，可能代表局部优化或特殊处理后的子区域。 无图例或文
// 字标注直接出现在图像上，所有信息依赖颜色区分。根据图注
// 说明，此图为“用于前景分析的掩膜”，即定义了哪些天区可用
// 于建模和拟合前景模型。 趋势与结论： 该图传达的核心信息
// 是：前景分析仅适用于非灰色区域（黄、青绿、紫三色），且
// 这些可用区域集中在高银纬地区（远离银河系盘面）。灰色区
// 域的广泛分布表明银河系平面附近的前景区复杂度高、难以建
// 模，因此被剔除。彩色区域的连续性（尤其是黄色）暗示在高
// 银纬处数据质量较一致，适合进行全局参数估计；而紫色斑块
// 的零星出现则提示某些局部区域虽可分析，但需单独处理或具
// 有特殊性。 本图不包含比例尺、单位或定量数值，纯粹为定
// 性分区示意，服务于后续残差分析（如中间/底面板所示）的
// 空间有效性界定。
// [figvision-cn] imgs/mask_and_regions.png
// 该图像为一幅全天空天球投影示意图，采用椭圆形（
// Mollweide）投影展示整个天球。图中没有坐标轴刻度或数值
// 范围，而是通过颜色区域划分来表示不同数据处理状态的天区
// 分布。 整体布局：图像呈横向椭圆，覆盖从北天极到南天极
// 的完整天球。颜色区域沿银道面（大致水平穿过图像中部）对
// 称分布，但存在局部不规则斑块。 颜色编码与物理含义： 灰
// 色区域：代表被排除在前景分析之外的天空区域。这些区域主
// 要分布在图像中央一条宽阔的带状区域（对应银河系盘面），
// 以及若干分散的不规则斑块。灰色区域总面积约占整个椭圆的
// 60%以上，表明大部分天区因前景污染严重而未纳入后续分析。
// 黄色区域：位于图像顶部和底部边缘，代表具有均匀分辨率的
// 前景光谱参数区域。黄色区域呈连续带状，环绕南北两极，宽
// 度随纬度变化，在极点附近最宽。 青绿色区域：紧邻灰色区
// 域两侧，形成过渡带，同样表示具有均匀分辨率的前景参数区
// 域，但其空间分布比黄色区域更破碎、不规则。 深紫色区域：
// 嵌入在青绿色区域内，呈细碎斑块状，也属于“均匀分辨率”类
// 别，可能代表局部优化或特殊处理后的子区域。 无图例或文
// 字标注直接出现在图像上，所有信息依赖颜色区分。根据图注
// 说明，此图为“用于前景分析的掩膜”，即定义了哪些天区可用
// 于建模和拟合前景模型。 趋势与结论： 该图传达的核心信息
// 是：前景分析仅适用于非灰色区域（黄、青绿、紫三色），且
// 这些可用区域集中在高银纬地区（远离银河系盘面）。灰色区
// 域的广泛分布表明银河系平面附近的前景区复杂度高、难以建
// 模，因此被剔除。彩色区域的连续性（尤其是黄色）暗示在高
// 银纬处数据质量较一致，适合进行全局参数估计；而紫色斑块
// 的零星出现则提示某些局部区域虽可分析，但需单独处理或具
// 有特殊性。 本图不包含比例尺、单位或定量数值，纯粹为定
// 性分区示意，服务于后续残差分析（如中间/底面板所示）的
// 空间有效性界定。
#figure(placement: top, [#box(image("imgs/mask_and_regions.png", width: 62%)) \
  #v(10pt)
  #box(image("imgs/ptep_maps.png", width: 88%))

  ],
  caption: [
    Top panel: Masks used for foreground analyses. The gray region shows the sky area excluded from the foreground analysis, while the colors show areas with homogeneous resolution for the foreground spectral parameters. Middle (bottom) panel: map of the mean (standard deviation) of the foregrounds residuals.
  ]
)
<fig:foreground_masks>


=== Products
<sec:products>
Once the residuals are estimated on 60 % of the sky, their power spectra are evaluated in a sky region corresponding to $f_("sky") = 49.5 thin %$, obtained by intersecting the 60 % mask with foreground residuals estimated through component separation (see @fig:foreground_masks). The mask is derived by: (1) removing regions with the highest foregrounds residuals; (2) smoothing it with a $2^compose$ beam; and (3) converting it to a binary mask using a threshold equal to 0.5. The threshold for step (1) is chosen so that the bias on $r$ is low enough while
keeping the sky coverage large enough to lower as much as possible the associated $sigma ( r )$. Although this exact methodology will not be applicable to real data sets, a better understanding of foreground morphology, as well as additional observational/theoretical priors on their SEDs, will help us to better define the Galactic masks by the time of the #emph[LiteBIRD] launch. The angular power spectra of the foreground residuals are estimated using pseudo-$C_ell$s corrected for the mask, evaluated using the `Healpy
Anafast`#footnote[#link("https://healpy.readthedocs.io/en/latest/generated/healpy.sphtfunc.anafast.html")] public code. We checked that the power spectra of foreground residuals do not change if they are estimated by the methods such as `NaMaster`#footnote[#link("github.com/LSSTDESC/NaMaster")], mainly because foreground $E$ and $B$ modes have similar amplitudes.


@fig:xforecast-results-pysm shows the result of our foreground-cleaning method applied to the multi-frequency data set specified in @sec:input_maps, in the case of Gaussian beam convolution. We display the expected error bars on the primordial $B B$ spectra for $r = 0.00461$, corresponding to the reference Starobinsky model introduced in Sects.~#ref(<ss:cmbpol_r>, supplement: none), #ref(<ss:cmbpol_beyondpower>, supplement: none)~#cite(<starobinsky:1980>), and $tau = 0.0544$~#cite(<Planck2015XIII>). The error bars are shown for pure cosmic variance,
including the primordial and lensing $B$-mode variance, as well as for the total uncertainty coming from cosmic variance plus noisy foreground residuals. The total residuals from foregrounds and noise after component separation, averaged over the 1000 simulations, are shown in @fig:xforecast-results-pysm (orange area, with average given by the dark orange line), as well as the noiseless foreground residuals (dashed orange line), otherwise known as "systematic foreground residuals." The first element determines the accuracy on $r$ via power spectrum
estimation, namely the statistical error including foreground cleaning and noise, while the second is responsible for the bias on the recovered $B B$ spectrum and thus on $r$. Due to their large amplitudes, the statistical foreground residuals, sourced by statistical errors on the estimated spectral indices, dominate the overall error budget.


From these averaged spectra, the corresponding bias on $r_("FG")$, as well as the accuracy $sigma ( r = 0 )$ after foreground cleaning, is given by $r_("FG") = (3.3 plus.minus 6.2) times 10^(- 4)$. This result is obtained for an input value $r = 0.00$, while the same analysis with an input $r = 0.01$ leads to $sigma ( r = 0.01 ) = 0.0013$. We find $sigma ( r = 0.01 ) = 0.0036$ from the reionization bump only ($ell thin < thin 20$), while $sigma ( r = 0.01 ) = 0.0014$ from the recombination bump ($ell thin > thin 20$). Note that $sigma ( r = 0.01 )$ is
the measurement uncertainty including cosmic variance. Since the posterior probability density of $r$ is asymmetric and falls rapidly towards $r = 0$, we expect detections of both bumps at a significance exceeding $5 thin sigma$ (see @ss:forecasts_delta_r).


Relative to the recombination bump, the reionization feature becomes more relevant as one approaches the Starobinsky limit, since the recombination bump would require substantial delensing in order to be measured. We will come back to delensing effects in @ss:extrasuccess, where the averaged total and noiseless foreground residuals mentioned above are the inputs to the estimation of the total uncertainty on the tensor-to-scalar ratio $r$.


Along with the recovered CMB map, our component-separation approach also provides estimates of the Galactic foregrounds, and in particular of the dust map. This information is used in @ss:forecasts_delta_r to marginalize our estimate of $r$ over the foreground bias.


== Instrumental Systematic Uncertainties
<ss:forecasts_syst>


We describe here our analysis of instrumental systematic effects. Foreground cleaning and systematic residuals will constitute the total error budget, as described in @ss:forecasts_delta_r. Throughout this section, we describe specific definitions and objects for each of the systematic effects we consider. Common to the whole analysis, simulations of the sky include Galactic foreground components as an input, following the model described in @sec:reference_skies, combined as described in @sec:input_maps to produce simulated frequency-channel data.


=== Introduction to Systematic Uncertainties
<sss:syst_intro>
In this section, we describe potential systematic effects for the #emph[LiteBIRD] mission and evaluate their impact on the final results. Systematic effects originate from imperfect knowledge of the foregrounds, combined with incomplete correction of instrumental or environment effects arising from either inaccurate modeling or limited knowledge of instrumental parameters and environmental contributions.


The main objective of #emph[LiteBIRD] is to measure the tensor-to-scalar ratio $r$. We therefore focus our study on the impact of systematic effects on the measurement of this parameter. We particularly estimate the systematic contribution on the measurement bias $Delta r$ under the condition of the true value being $r = 0$. We give the detailed definition of $Delta r$, as well as the total error $delta r$, in the next section.


We divide the systematic effects into several categories. The systematic bias produced by the component-separation residual was described in @ss:forecasts_fg_cleaning. We describe remaining systematic sources in this section. @tbl:syst shows a summary of the most relevant systematic effects as the top level category. Beam systematic effects are mainly caused by imperfections in the calibrated knowledge of the beam. We further divide the beam into three: the main lobe; the near sidelobe; and the far sidelobe. The main lobe is the center of the beam with
width shown in @tbl:imo:sensitivities. We define the near sidelobe to be the region out to $3^compose$ with respect to the main-lobe peak direction. The remaining part of the beam is defined as the far sidelobes. The optical system, consisting of the HWP and lenses, is supposed to produce multiple reflections and hence ghosting images for bright sources. The requirement for the suppression of these images is obtained given the required systematic bias in $Delta r$. The systematic effects of the beam variation and polarization (co-polar and cross-polar)
in the observation band are also studied. For far-sidelobe effects, which give the most sizeable systematic bias, we study the effects for all frequency channels of the three telescopes. We study the HWP systematic effects in terms of the Mueller matrix, consisting of: the instrumental polarization that leaks from temperature into the polarization signal in the measurement band; the transparency; the polarization efficiency due to the retardance (phase difference) uncertainties of the HWP ; and the polarization angle in multiple bands due to mixing of
the two orthogonal polarized signals. We study cosmic-ray effects based on a newly developed simulation tool. Gain-variation systematic effects are also studied. Given the systematic error budget, the requirements are obtained on the focal plane temperature stability and the gain variation in detectors. Polarization angle systematic effects are sourced by the uncertainties of the absolute angle, the relative angles among all bands, the HWP spinning position, and the time variation due to the attitude and HWP position measurement errors. Polarization
efficiency systematic effects for the detector plane antenna and the optical system are additionally studied. The pointing uncertainty is modeled as a constant offset, as well as a random variation. The requirements on the HWP wedge angle and the bandpass calibration uncertainties are also given. The transfer-function category includes systematic effects due to the uncertainties of the detector time constant and the crosstalk among detectors. Details of each of these items are given in the following sections. Some of the systematic error budget of
individual sources can be further divided into the sub-level requirements. One example is the pointing uncertainty, which will be detailed in @sec:other-systematics#footnote[We identify about 70 systematic sources in total including the ones in the sub-levels.]


We note that the estimated systematic bias is approximately a linear sum of individual systematic effect biases, when those power spectra are much smaller than that of the lensing effect. This is because $Delta r$ is approximately proportional to the square of the error of the systematic effects to first order; the details are given in @ss:forecasts_delta_r. The total error budget assigned for the systematic bias $Delta r$ is $0.57 times 10^(- 3)$~#cite(<Hazumi:2019lys>). We assign an error budget of 1 % of the total systematic bias $5.7 times 10^(- 6)$
to individual systematic effects as a nominal error budget in order to account for dozens of potential systematic sources. We note that there are some exceptions including the systematic effects caused by the far sidelobe uncertainty, however.


To give $Delta r$, we employ one of two approaches. One way is to estimate $Delta r$ values based on the expected uncertainties in the calibration in-flight or at the expected precision of measurement devices. The other approach is to impose requirements on the calibration accuracy or of the measurement devices. In @tbl:syst, we divide the systematic sources into two types by assigning "E" (Expectation) and "R" (Requirement), respectively. We show the obtained angular power spectra for systematic effects in @fig:cl_sys_all.


#figure(
  align(center)[#table(
    columns: 5,
    align: (center,center,center,center,center,),
    table.header([Category], [Systematic effect], [$Delta r$], [Source], [Type],),
    table.hline(),
    [Beam], [Far sidelobes], [$4.4 times 10^(- 5)$], [$B arrow.r B$, $E arrow.r B$], [R],
    [], [Near sidelobes], [$5.7 times 10^(- 6)$], [$B arrow.r B$, $E arrow.r B$], [R],
    [], [Main lobe], [$< 10^(- 6)$], [$E arrow.r B$], [E],
    [], [Ghost], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [], [Polarization and shape in band], [$< 10^(- 6)$], [$E arrow.r B$], [R],
    [Cosmic ray], [Cosmic-ray glitches], [Noise], [Power to B, E], [E],
    [HWP], [Instrumental polarization], [$< 10^(- 6)$], [$T arrow.r B$], [E],
    [], [Transparency in band], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [], [Polarization efficiency in band], [$5.7 times 10^(- 6)$], [$B arrow.r B$], [R],
    [], [Polarization angle in band], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [Gain], [Relative gain in time], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [], [Relative gain in detectors], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [], [Absolute gain], [$1.9 times 10^(- 6)$], [$B arrow.r B$], [E],
    [Polarization], [Absolute angle], [$9.1 times 10^(- 6)$], [$E arrow.r B$], [E],
    [angle], [Relative angle], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [E],
    [], [HWP position], [$1.0 times 10^(- 6)$], [$E arrow.r B$], [E],
    [], [Time variation], [$< 10^(- 7)$], [$E arrow.r B$], [E],
    [Pol. efficiency], [Efficiency], [$5.6 times 10^(- 6)$], [$B arrow.r B$], [E],
    [Pointing], [Offset], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [], [Time variation], [$< 10^(- 6)$], [$E arrow.r B$], [E],
    [], [HWP wedge], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
    [Bandpass], [Bandpass efficiency], [$5.3 times 10^(- 6)$], [$E arrow.r B$], [R],
    [Transfer], [Crosstalk], [$5.7 times 10^(- 6)$], [$B arrow.r B$], [R],
    [function], [Detector time constant knowledge], [$5.7 times 10^(- 6)$], [$E arrow.r B$], [R],
  )]
  , caption: [Summary of sources of systematic effects as the top level category. We categorize the systematic effects in the first column. The details of individual categories are shown in the second column. The third column shows the systematic biases on $r$, except for the cosmic rays, which are supposed to yield an extra noise source. The fourth column describes the sources of systematic effects. The last column shows the types. The type "E" and "R" state the expectation and the requirement, respectively, as described in the text. Note that we assign
an error budget of 1 % of the total systematic bias $5.7 times 10^(- 6)$ to individual systematic effects as a nominal error budget in order to account for dozens of potential systematic sources. Details are described in the text. ]
  , kind: table
  ) <tbl:syst>



Our analysis has shown that the employment of the PMU is crucially important to mitigate systematic errors. Without the PMU, data from a pair of detectors mutually orthogonal in the polarization orientation are usually combined, causing leakage from temperature to polarization when there are differences in any features between the two detectors. The features giving outstanding systematic effects include the gain, beam, and bandpass. The systematic errors for these are evaluated assuming that the effects could be mitigated by increasing the number of
detectors $N$ (if the systematic effects on individual detectors are uncorrelated), with the scaling $Delta r prop 1 \/ N$. Existing studies include: bandpass effects~#cite(<Hoang:2017wwv>), yielding $Delta r$ on the order of $10^(- 4)$ with an assumption that the bandpass boundaries have an uncertainty of 1% without any corrections;#footnote[Reference~#cite(<Banerji:2019kbc>) demonstrates the correction of bandpass systematic effects.] the instrumental polarization caused by reflections on the two mirrors in the LFT, giving at most $3 times 10^(- 4)$
for $M_(Q I)$ components in the Mueller matrix ~#cite(<Kashima:2017yub>); and the Carbon Monoxide (CO) line emission contamination, with $Delta r tilde.eq 10^(- 4)$ for a bandpass response mismatch of 10 % without applying notch filters~#cite(<Ghigna2020-dthesis>). We conduct a simulation study of the systematic errors caused by differences for a pair of detectors in gain, pointing, beam ellipticity, beam width, cross-polarization, and sidelobes, and find the systematic bias $Delta r$ to be on the order of $10^(- 6)$. However, these effects would
increase significantly when there is some cross-correlation among the detectors with a correlation coefficient larger than $10^(- 3)$. A time-correlated noise contribution is expected to contaminate detector timestream data at long timescales. If the noise contamination is projected onto the sky map without adequate treatment, it can cause significant degradation of the sensitivity for the lower multipole range. We generate $1 \/ f$-noise simulated data, project it onto the sky map and estimate the degradation to be $delta r tilde.eq 3 times 10^(- 4)$
for a 20-mHz knee frequency. All the effects above are found to be significantly reduced when we use the PMU. For example, Ref.~#cite(<Hoang:2017wwv>) demonstrates this for the bandpass effects. In summary, with the PMU we can suppress almost all outstanding systematic sources that give rise to the leakage from temperature to polarization, as well as the $1 \/ f$ noise that significantly deteriorates the sensitivity in the lower multipole region.


In the rest of this section, we focus on systematic effects with the PMU. Among those we will give details of systematic studies of the beam, cosmic rays, HWP, and gain in the following sections. Other systematic effects are summarized in @sec:other-systematics. We estimate the systematic effects based on simulated sky maps of the CMB and foregrounds described in @sec:input_maps. The basic strategy is to obtain a residual sky map that is a difference between the reconstructed sky maps with and without a particular systematic effect, which mitigates the
model dependence of the sky maps employed.


=== Formalism of the Errors
<sub:ErrorForm>
This section gives the definition of the bias $Delta r$ and the total error $delta r$. We define a likelihood function $L ( r )$ expressed in the multipole domain due to the large sky coverage of the satellite mission. Assuming Gaussian stationary and isotropic fields and hence no coupling between multipoles (which is an approximation in the presence of a mask of the Galactic plane), the likelihood function is given by $
  log L ( r ) = sum_(ell = ell_min)^(ell_max) log P_ell ( r ) ,
$ <eq:global-likelihood> where $ell_min = 2$ and $ell_max = 191$~#footnote[We use $N_("side") = 64$, giving $ell_max = 3 times N_("side") - 1$.]. We define $
  log P_ell ( r ) = - f_("sky") frac(2 ell + 1, 2) [hat(C)_ell \/ C_ell + log C_ell - frac(2 ell - 1, 2 ell + 1) log hat(C)_ell]
$ where $hat(C)_ell$ ($C_ell$) is the measured (modeled) $B$-mode power spectrum~#cite(<PhysRevD.77.103013>). We use a sky mask having $f_("sky") = 0.495$. In order to estimate the potential bias of individual systematic effects on $r$, which we call $Delta r$, we represent the measured $B$-mode spectrum as a sum of the following contributions (assuming no primordial $B$ modes, i.e., $r = 0$): $
  hat(C)_ell = C_ell^("sys") + C_ell^("lens") + N_ell .
$ <eq:cl-measured-in-likelihood> Here $C_ell^("sys")$ is the estimated systematic effects power spectrum, $C_ell^("lens")$ is the lensing $B$-mode power spectrum, and $N_ell$ is the expected noise power spectrum, including the residual noise after the component separation (shown in @fig:xforecast-results-pysm) as well as the cosmic-ray contribution. The modeled power spectrum is given by $
  C_ell = r C_ell^("tens") + C_ell^("lens") + N_ell ,
$ <eq:cl-model-in-likelihood> where $C_ell^("tens")$ is the tensor mode with $r = 1$. We estimate the systematic bias under the condition of the existence of the expected noise $N_ell$ coming from instrumental and foreground residual uncertainties.


The potential systematic bias $Delta r$ is defined as the value giving the maximum of the likelihood function: $ frac(d L ( r ), d r)\|_(r = Delta r) = 0 . $<eq:r-bias-definition> We also define the total error on $r$, $delta r$, as the value covering 68 % of the area of the total likelihood function: $ frac(integral_0^(delta r) L ( r ) d r, integral_0^oo L ( r ) d r) = 0.68 . $<eq:r-total-error-definition>


=== Beam Systematic Effects
<sec:beam-systematics>
Imperfect knowledge of the beam, due to a combination of uncertainties in beam measurements and modeling, are important sources of systematic effects for the measurement of primordial $B$ modes. We model the sky signal $p ( t , nu , hat(n) , hat(s) )$ observed at location $hat(n)$ at time $t$ with frequency $nu$, from a beam centered at location $hat(s)$ in the presence of an ideal HWP, without coupling with other optical elements:
$ p ( t , nu , hat(n) , hat(s) ) & = B_parallel ( t , nu , hat(n) - hat(s) ) \[ I ( nu , hat(n) ) + Q ( nu , hat(n) ) cos 2 phi ( t , nu ) + U ( nu , hat(n) ) sin 2 phi ( t , nu ) \]\
 & quad quad + B_perp ( t , nu , hat(n) - hat(s) ) \[ I ( nu , hat(n) ) - Q ( nu , hat(n) ) cos 2 phi ( t , nu ) - U ( nu , hat(n) ) sin 2 phi ( t , nu ) \] , $ where $phi ( t , nu ) = 4 rho ( t , nu ) - 2 psi ( t , nu )$, $rho ( t , nu )$ is the HWP rotation position, $psi ( t , nu )$ is the polarizer measurement angle with respect to the axis fixed in the sky, and $B_parallel ( t , nu , hat(n) - hat(s) )$ and $B_perp ( t , nu , hat(n) - hat(s) )$ are the co-polar and cross-polar beams, respectively. The measured signal is the integral of
$p ( t , nu , hat(n) , hat(s) )$ over the direction $hat(n)$ and over the frequency $nu$ weighted by the bandpass function. Different regions of the beam kernel have different effects on the data and are also estimated differently during the calibration process (either in-flight or from the ground). We divide the beam into three regions (as shown in @fig:LoK): the main lobe; the near sidelobes; and the far sidelobes. Below we describe systematic effects for the far sidelobes, the near sidelobes, and the main lobe in the order that they are sourced by the
uncertainties in our knowledge of $B_parallel$. We also discuss the possible ghosting effect caused by reflections inside the telescope, and the polarization and beam shape in the observed frequency band.


==== Far-sidelobe Systematic Effects
<far-sidelobe-systematic-effects>
The main effect of uncertainties in the beam fsls measurement or modeling is that it induces unexpected leakage of the Galactic signal coming from the Galactic plane to higher Galactic latitudes. The mismatch of this excess signal between different frequency bands leads to residuals in the recovered CMB Stokes parameter maps after component separation. With the help of the HWP, allowing quasi-instantaneous measurement of the polarization Stokes parameters ($Q$ and $U$), and of the symmetrization of the effective beam on the maps by the diversity of
scanning angle in each pixel of the sky, the dominant systematic effect originates from residual $B$-mode Galactic signal leaking towards the CMB $B$-mode estimate. On top of this effect, uncorrected effective beam asymmetries might potentially lead to small $E$-to-$B$ leakage effects.


Diffraction by optics elements located between the HWP and the detectors is not expected to induce a significant contribution to the cross-polarization beam $B_perp ( t , nu , hat(n) - hat(s) )$. This is because the HWP does not modulate potential generated polarization signal and hence negligible levels of $I$-to-$P$ leakage should be induced. However potential contributions to $B_perp ( t , nu , hat(n) - hat(s) )$ are the HWP itself and external elements such as baffles. Those might induce $I$-to-$P$ leakage, which will be further studied in subsequent works.


In this subsection we evaluate the impact on the tensor-to-scalar ratio $r$ of the uncertainties on the beam knowledge by perturbing the shape of the beam response at different angles from the beam center. Before describing this procedure we will introduce the simulations that were carried out.


==== Description of Simulations
<description-of-simulations>
For this study, we employ the beam-convolved sky maps generated by `TOAST` described in Sect. #ref(<sec:input_maps>, supplement: none) In order to set the requirements on the far-sidelobe beam calibration, we have considered the beam convolution in the angle ranges $5^compose < theta < 10^compose$, $10^compose < theta < 15^compose$, and $15^compose < theta < 90^compose$, where $theta$ is the angle with respect to the main lobe peak. This convolution has been performed for all sets of co-added foreground maps. We do not include noise in the input
simulated maps because we are interested in the estimation of the requirements in terms of a bias on $r$ ($Delta r$) for the beam systematic effects. The time-ordered data (TOD) are simulated for the 22 nominal frequency bands of #emph[LiteBIRD]. A subset of detectors for each frequency band is considered, instead of the full focal plane. The selected detectors are well spread across the arrays so that we can assume that the results are representative of the full focal plane, and therefore a global rescaling of the results is applied at the end.


's scanning strategy with nominal parameters of the IMo (see @ss:forecasts_imo) is simulated and a full-sky convolution of the beams is performed. Input simulated reference beams are calculated using `GRASP` software with a simplified optical model, i.e., no multiple reflections have been included in the beam model. `GRASP` beams have been simulated at the central frequency for each band, neglecting the color effects and hence the differential effects on various sky components. We will describe the possible systematic effects that are not accounted for
in the model above in the last paragraph of this subsection.


==== Impact of FSL Systematic Effects on $B$ Modes
<impact-of-fsl-systematic-effects-on-b-modes>
We now evaluate the impact of the lack of knowledge of the beam shape at large angular scales on the measurement of the tensor-to-scalar ratio $r$. With this goal in mind, we process the previously described simulated band-averaged maps produced with non-Gaussian beam convolution through all the steps leading to the measurement of $r$. The effect of uncertainties on the beam shape will then be translated into a bias $Delta r$ on $r$.


For each perturbed case studied, we proceed with two sets of maps, with and without beam perturbations, which are both processed with component separation to calculate CMB $I$, $Q$, $U$ maps. The first set, including the unperturbed beam, provides reference CMB maps $upright(bold(m))_0$. The second set of simulations includes perturbations of the FSL and are run through the same component-separation code with the same assumptions. The perturbations are performed in a specified angle range and for a given frequency band in the following manner: $
  B_("pert") ( nu , theta , phi.alt ) = mu ( alpha ) ( [1 + alpha W ( theta )] thin B_0 ( nu , theta , phi.alt ) .
$ Here $B_0 ( nu , theta , phi.alt )$ is the reference `GRASP` beam for the frequency band centered at $nu$, at radial and azimuthal angles $theta , phi.alt$, $alpha$ is an amplitude parameter of the perturbation that we are varying to provide the requirements, and $mu ( alpha )$ is a normalization parameter. The window function $W ( theta )$ is chosen to include apodization in order to reduce ringing edge effects and is set to $
  
$ where $i = ( inf , sup )$, for three different angle ranges $[theta_inf , theta_sup]$, namely $[5^compose , 10^compose]$, $[10^compose , 15^compose]$, and $[15^compose , -]$ ($A_sup = 0$ for the third window). With the previous parameters, the window is actually effective, i.e. $W \/ W_max med 0.5$, in the angle ranges $[3.75^compose , 7.5^compose]$, $[7.21^compose , 11.69^compose]$, and $[11.25^compose , 90^compose]$.


The normalization $mu$ is calculated for each value of $alpha$ such that the beam-convolved maps have the same dipole component ($ell = 1$) amplitude as the unperturbed ones. This procedure allows us to isolate the effect of beam mismatch only from calibration uncertainties that are studied in Sect.~#ref(<beams-calib-section>, supplement: none)


In our approach, we find the limiting values $alpha_lim$ independently for each frequency band, i.e., we perturb one beam at one frequency at a time, leaving the others constant, such that the induced bias on the tensor-to-scalar ratio is $Delta r = 1.9 times 10^(- 5)$ divided by 66, the number of frequency channels times the number of windows. The systematic bias $Delta r$ is obtained using @eq:r-bias-definition given $C_ell^("sys")$, which is obtained from the residual sky maps
$delta upright(bold(m)) = upright(bold(m)) - upright(bold(m))_0$ after applying a #emph[Planck]-HFI Galactic mask leaving 51 % of sky area, where $upright(bold(m))$ ($upright(bold(m))_0$) is the sky map convolved by the far sidelobe with (without) the perturbation of individual $alpha$ values.


The results for the three angle ranges are shown in @tab:beamFSLrequir. The $alpha$s are just intermediate parameters and we indicate the values of the beam perturbation amplitudes in the three windows by calculating the following values: $
  delta overline(B)_lim = thin frac(integral delta B_nu (theta  thin  phi.alt) W (theta) d Omega, integral W (theta) d Omega) ; thin "and" thin thin thin thin delta R_lim = thin frac(integral delta B_nu (theta  thin  phi.alt) W (theta) d Omega, integral B_0 (nu  thin  theta  thin  phi.alt) d Omega) .
$ Here the beam perturbation $delta B_nu ( theta , phi.alt ) = alpha_lim B_0 ( nu , theta , phi.alt )$, including the normalization of the input beam at the peak: $B_0 ( nu , theta = 0 ) = 1$. The quoted values $delta overline(B)_lim$ represent the precision that is required on the knowledge of the mean amplitude of the beam in the window $W ( theta )$, while $delta R_lim$ represents the required precision on the beam's relative power in the window angle range specified by $W ( theta )$. Because the amplitude of the beam models used for this analysis
drops drastically at angles larger than around $50^compose$, we have cut the last window for the perturbation $W ( theta )$ above $70^compose$ (to be conservative) for the calculation of $delta overline(B)_lim$ and $delta R_lim$, as well as the estimated calibration precision that we will discuss later.


#figure(
  align(center)[#table(
    columns: 10,
    align: (center,center,center,center,center,center,center,center,center,center,),
    table.header([], [$3^compose < theta < 8^compose$], [$6^compose < theta < 13^compose$], [$10^compose < theta < 50^compose$], [$], [$], [$], [$], [$], [$],),
    table.hline(),
    [2-10], [$delta overline(B)_lim$], [$delta R_lim$], [$sigma_(0.25^square.stroked.tiny)^(cal)$], [$delta overline(B)_lim$], [$delta R_lim$], [$sigma_(0.25^square.stroked.tiny)^(cal)$], [$delta overline(B)_lim$], [$delta R_lim$], [$sigma_(0.25^square.stroked.tiny)^(cal)$],
    [L1-040], [$- 42.55$], [$- 23.54$], [$- 28.20$], [$- 46.62$], [$- 25.41$], [$- 30.68$], [$- 66.40$], [$- 27.49$], [$- 42.79$],
    [L2-050], [$- 34.09$], [$- 13.45$], [$- 19.73$], [$- 38.35$], [$- 15.51$], [$- 22.41$], [$- 57.98$], [$- 17.44$], [$- 34.37$],
    [L1-060], [$- 39.46$], [$- 17.68$], [$- 25.11$], [$- 43.67$], [$- 19.68$], [$- 27.73$], [$- 63.20$], [$- 21.53$], [$- 39.60$],
    [L3-068], [$- 36.70$], [$- 13.27$], [$- 22.34$], [$- 41.38$], [$- 15.75$], [$- 25.44$], [$- 61.52$], [$- 18.20$], [$- 37.92$],
    [L2-068], [$- 30.45$], [$- 8.02$], [$- 16.10$], [$- 35.62$], [$- 10.99$], [$- 19.68$], [$- 56.00$], [$- 13.67$], [$- 32.39$],
    [L4-078], [$- 42.82$], [$- 18.36$], [$- 28.46$], [$- 45.87$], [$- 19.21$], [$- 29.93$], [$- 61.76$], [$- 17.41$], [$- 38.16$],
    [L1-078], [$- 39.42$], [$- 16.43$], [$- 25.07$], [$- 42.48$], [$- 17.28$], [$- 26.53$], [$- 59.07$], [$- 16.18$], [$- 35.46$],
    [L3-089], [$- 48.56$], [$- 23.14$], [$- 34.20$], [$- 51.75$], [$- 24.13$], [$- 35.81$], [$- 68.70$], [$- 23.40$], [$- 45.10$],
    [L2-089], [$- 38.84$], [$- 15.50$], [$- 24.49$], [$- 42.04$], [$- 16.49$], [$- 26.10$], [$- 59.51$], [$- 16.27$], [$- 35.91$],
    [L4-100], [$- 51.80$], [$- 25.61$], [$- 37.45$], [$- 54.98$], [$- 26.59$], [$- 39.04$], [$- 72.09$], [$- 26.01$], [$- 48.49$],
    [L3-119], [$- 54.82$], [$- 27.57$], [$- 40.47$], [$- 57.91$], [$- 28.46$], [$- 41.97$], [$- 75.00$], [$- 27.86$], [$- 51.39$],
    [L4-140], [$- 51.25$], [$- 23.23$], [$- 36.90$], [$- 54.11$], [$- 23.88$], [$- 38.17$], [$- 74.60$], [$- 26.69$], [$- 51.00$],
    [M1-100], [$- 50.65$], [$- 26.84$], [$- 36.30$], [$- 53.91$], [$- 27.90$], [$- 37.97$], [$- 69.44$], [$- 25.74$], [$- 45.84$],
    [M2-119], [$- 54.58$], [$- 29.71$], [$- 40.23$], [$- 57.78$], [$- 30.71$], [$- 41.84$], [$- 73.96$], [$- 29.20$], [$- 50.36$],
    [M1-140], [$- 49.55$], [$- 23.92$], [$- 35.20$], [$- 52.45$], [$- 24.61$], [$- 36.51$], [$- 75.36$], [$- 29.83$], [$- 51.76$],
    [M2-166], [$- 60.87$], [$- 34.64$], [$- 46.52$], [$- 64.07$], [$- 35.63$], [$- 48.13$], [$- 80.06$], [$- 33.91$], [$- 56.45$],
    [M1-195], [$- 63.56$], [$- 37.07$], [$- 49.20$], [$- 66.58$], [$- 37.89$], [$- 50.64$], [$- 80.69$], [$- 34.30$], [$- 57.08$],
    [H1-195], [$- 59.01$], [$- 33.00$], [$- 44.65$], [$- 62.38$], [$- 34.17$], [$- 46.44$], [$- 78.63$], [$- 32.73$], [$- 55.03$],
    [H2-235], [$- 62.92$], [$- 35.65$], [$- 48.57$], [$- 66.07$], [$- 36.60$], [$- 50.13$], [$- 81.55$], [$- 34.38$], [$- 57.95$],
    [H1-280], [$- 60.57$], [$- 32.52$], [$- 46.22$], [$- 63.60$], [$- 33.34$], [$- 47.66$], [$- 75.23$], [$- 27.26$], [$- 51.63$],
    [H2-337], [$- 70.48$], [$- 41.78$], [$- 56.12$], [$- 73.57$], [$- 42.66$], [$- 57.63$], [$- 86.41$], [$- 37.79$], [$- 62.81$],
    [H3-402], [$- 67.91$], [$- 38.03$], [$- 53.56$], [$- 70.77$], [$- 38.68$], [$- 54.83$], [$- 88.72$], [$- 38.93$], [$- 65.12$],
  )]
  , caption: [Beam perturbation requirements for each frequency channel and each of the three angle ranges of the beam perturbations giving $Delta r = 1.9 times 10^(- 5) \/ 66$, fixing the other perturbations for the other frequency channels and angle ranges to 0. Units are dB for $delta overline(B)_lim$ and $sigma_(0.25^square.stroked.tiny)^(cal)$, and dBi for $delta R_lim$. The indicated values of angles in the first row, providing the typical range in which the beam is perturbed, are such that 95 % of the perturbed beam power for a typical CMB channel
is within this range (the value varies from channel to channel as the beam shape varies). This explains why the upper bound for the last window is only $50^compose$ while the window extends to $90^compose$ as the beam drops above 50--$60^compose$, depending on the channel. The calculated values of the required precision $sigma_(0.25^square.stroked.tiny)^(cal)$ are assuming $0.5^compose$ separation between noise-limited measurements. An identical calibration precision of $sigma_(0.25^square.stroked.tiny)^(cal) = - 56.90$ dB for all 66 entries leads to a
similar bias.]
  , kind: table
  ) <tab:beamFSLrequir>



The derived constraints can be translated into required accuracy in beam calibration measurements during ground testing. The quantity effectively measured during the beam calibration can be modeled as $
  P_(cal) ( arrow(r) ) = integral B_nu thin omega ( arrow(r)' - arrow(r) ) thin d Omega' thin frac(1, integral B_nu thin omega ( arrow(r)' ) thin d Omega') + n_(cal) ,
$ with $omega ( arrow(r) )$ a small integration window of the beam and $n_(cal)$ the noise in the beam calibration. We have estimated the precision required on the measured quantity $P_(cal) ( arrow(r) )$ assuming random uncorrelated errors in each measurement (and hence no systematic effects in the calibration), and a grid of measurements at many angles. In this case the calibration measurement uncertainty $sigma_(Omega_("pix"))^(cal) = sqrt(chevron.l n_(cal)^T n_(cal) chevron.r)$ is related to the uncertainty in the beam amplitude averaged over the window area $delta overline(B)_lim$ by $
  sigma_(Omega_("pix"))^(cal) = frac(integral W ( theta ) d Omega, sqrt(sum_(i j) W^2 ( theta_(i j) )) Delta Omega_("pix")) thin delta overline(B)_lim ,
$ <sigmacalibbeam> with $Delta Omega_("pix")$ the solid angle covered by one calibration measurement and $i , j$ the pixel numbers for a pixelized beam calibration map. We assume that the calibration measurements are normalized to unity at the peak (for the beam center). From the previous equation, we can see that the factor ($integral W d Omega \/ sqrt(sum_(i j) W^2 ( theta_(i j) )) Delta Omega_("pix") )^2$ is the effective number of pixels in the window area of the beam perturbation. Assuming a pixel width $sqrt(Delta Omega_("pix")) = 0.5^compose$,
which is the expected beam measurement step size in the ground calibration process, we have calculated the required precision for the calibration measurements and present the values in @tab:beamFSLrequir. The effective numbers of measurements for the three windows are 742.0, 1541.9, and 52943.2.


We can see that the requirements on calibration precision ($sigma_(0.25^square.stroked.tiny)^(cal)$) are more stringent at the highest frequencies for the last window, which covers a larger area of the sphere. This shows that it is necessary to accurately calibrate the fsls of the channels, providing a proxy for the Galactic dust for component separation and for which the fraction of power going into the main lobe is lower, since those have the smallest beam FWHM values. Assuming that we calibrate the whole area of the beam for all the frequency channels
with a constant precision $sigma_(0.25^square.stroked.tiny)^(cal)$, we have evaluated the desired precision is $- 56.90$ dB to have requirements equivalent to what is presented in @tab:beamFSLrequir. The total contribution of $Delta r$ has been estimated with hundred realizations by simultaneously varying individual $alpha$ values with a uniform distribution in the range $\[ max ( - 1 , - sqrt(3) alpha_lim ) ; sqrt(3) alpha_lim \]$, with $alpha_lim$ calculated from #ref(<tab:beamFSLrequir>, supplement: none) The $sqrt(3)$ factor is to keep the same
variance $alpha_lim^2$ as the Gaussian distribution used for @tab:beamFSLrequir to derive requirements. We find the systematic bias resulting from the above assumptions to be $Delta r = 2.2 times 10^(- 5)$.


We want to stress several important limitations of this analysis. Firstly, one of the key assumptions is that the scanning strategy induces enough symmetrization of the beam so that many calibration measurements can be averaged for large $theta$ and that the beam systematic effects are then dominated by uncertainties in the transfer function. This explains why the number of effective calibration points is high for each window. Secondly, in order to be representative of the final results, we have assumed that the bias on $r$ is not too sensitive to the
structure of the beam inside each window $W ( theta )$. Thirdly, the correlation in the overlaped region in @tab:beamFSLrequir is assumed to be negligible. Lastly, we quote the required precision on the calibration measurements assuming that those are limited by calibration noise. This is somewhat unrealistic, since measurements are expected to be limited by systematic effects in the ground measurements. Nevertheless, this analysis still provides a framework for quantifying uncertainties in further studies that might be needed.


We have checked that the results are not sensitive to the component-separation parameters and the model, in particular the effective beam function assumed as input in @ss:forecasts_fg_cleaning. The variations introduced by the change of the recovered component-separation parameters due to the slight difference of the beam transfer-functions in the recovered CMB maps vanish at first order in the difference $upright(bold(m)) - upright(bold(m))_0$.


The beam model used for the simulations contains several uncertainties including the effects of beam asymmetry caused by the multiple reflections and scattering, especially for the detectors placed at the edge of the focal plane. In order to account for the uncertainties, we conservatively multiply by a factor of two the requirements to obtain the FSL total systematic bias of $Delta r = 4.4 times 10^(- 5)$.


==== Near-Sidelobe Effect
<near-sidelobe-effect>
We pursue two approaches to estimate the systematic effects due to inaccuracy of the knowledge of the near sidelobe, i.e., the beam structures in the angle range up to about $3^compose$ with respect to the main-lobe center. In the first method, we model the beam shape having an axially-symmetric Gaussian main beam plus a power-law tail. We convolve the sky (including foregrounds) with the beam and deconvolve the sky map with a beam having a different amplitude of the power-law tail. Then we take a difference of the sky maps before and after this
procedure for the 15 frequency channels, and apply the component-separation procedure to obtain the residual sky map and power spectrum. We find $plus.minus 10$ % variations in the amplitude of the near sidelobe, whose nominal magnitude is less than 1 % of the main lobe, give rise to a systematic bias of $Delta r = 5.7 times 10^(- 6)$. In the second method, we model the beam as the sum of the Gaussian main beam and a ring shape near the sidelobe, whose cross-sectional shape is a Gaussian with a peak height of 1 % of the main-lobe peak. The position,
width, and height of the modeled near-sidelobes are set to values close to those in the `GRASP` simulation. The typical values are $1.7^compose$ from the main-lobe center for the position, $0.6^compose$ for FWHM and $- 20 thin$dB with respect to the main lobe for the height. We repeat a similar analysis by changing the ring position, width, and height, and find that a $plus.minus 20$ % variation from the nominal values corresponds to $Delta r = 5.7 times 10^(- 6)$. In summary, we require a calibration accuracy of better than 10 % for the near sidelobe in
order to have a systematic bias $Delta r < 5.7 times 10^(- 6)$.


==== Main-Lobe Effect
<main-lobe-effect>
At the simplest level, the beam's main lobe is characterized by two quantities, namely the height and the shape. The height corresponds to the gain that we describe in @sec:Gain-systematics. The main-lobe beam has a shape close to elliptical for the detectors located far from the center of the focal plane. We quantify this effect using two parameters, namely the width and the ellipticity or flattening. We conduct a simulation study similar to the one for the near-sidelobe effects. With an expected calibration accuracy of the 1 % for both the width and
the flattening in-flight (see @beams-calib-section), we find that the resulting systematic bias is smaller than $10^(- 6)$.


==== Ghosting Effect
<ghosting-effect>
It is known that the multiple reflections between the focal plane and the optics components, such as lenses and HWP, produce a ghosting image~#cite(<Bierman_2011>). To investigate this, we conduct a simulation study to estimate the systematic effects due to foreground contamination leaking through off-boresight small-scale structure into the beam. We find that a leakage of 0.05 % amplitude through a 30 arcmin diameter spot separated from the beam boresight direction by 900 arcmin produces a systematic bias equivalent to $Delta r = 5.7 times 10^(- 6)$.
The lens reflection effects are included in the discussion regarding the FSL. We note that the ghosting effect can be partly mitigated by tilting the HWP by an angle larger than half of the FoV.


==== Polarization and Beam Shape in Band
<polarization-and-beam-shape-in-band>
Sinuous antennas are sensitive to polarization at specific angles due to their design. However, the angle of the polarization sensitivity has a dependence on the frequency of the incoming light (commonly referred to as the "wobbling effect"). In our case, this effect is of the order of $3^compose$ in the observing band~#cite(<aritokisuzuki-dthesis>). It is known that the wobbling effect can be canceled using four detectors, i.e., two pairs of detectors with mutually mirrored sinuous patterns~#cite(<aritokisuzuki-dthesis>). We study wobble cancelation
effects with the beam patterns obtained from a `GRASP` simulation for 100-GHz detectors with 88, 100, and 112 GHz frequencies, corresponding to the central and edge frequencies in the band. We use the `QuickPol`~#cite(<Hivon2017>) algorithm, in which the #emph[LiteBIRD] scanning strategy is taken into account, to estimate the residual systematic effect when the two mutually mirrored patterned pairs have different polarization efficiencies. We find that a difference of 20 dB produces a residual power spectrum lower by 1 % with respect to the one due to
the lensing effect, corresponding to $Delta r < 10^(- 6)$. Note that the beam calibration will be conducted with a precision of 53 dB, as discussed for the FSL systematic effects. Considering this assumption, this systematic effect can be considered to be negligible.


=== Cosmic-ray Systematic Effects
<sec:CR-systematics>
For the High Frequency Instrument (HFI) of #emph[Planck]  cosmic rays produced glitch signals at a rate of 5 hits $"cm"^(- 2) thin s^(- 1)$~@Planck2013X, giving rise to systematic errors and requiring a deglitching process. For #emph[LiteBIRD], we will use a different detector technology and expect that the outcome of cosmic-ray effects may differ from that of #emph[Planck]-HFI. In order to predict and characterize the potential effects of cosmic-ray glitches, two studies have been conducted: one is to use actual laboratory measurements to estimate the
response of the detectors to energetic particle impacts by irradiating the detectors with alpha particles, $gamma$-rays, or cosmic-ray muons; and the second is to realize an end-to-end simulation to evaluate the propagation of cosmic-ray effects. The former is described in @sss:detection_fpm (see also @beckman2018). Here we describe details for the latter approach (see also Refs.~@Tominaga2020SPIE #cite(<Stever_2021>)).


For #emph[LiteBIRD], we will employ TES arrays on a 10-inch silicon wafer. We estimate the expected cosmic-ray hit-rate on a single silicon substrate using PAMELA data fitted with an Usoskin model at L2 for the cosmic-ray flux determination~#cite(<USOSKIN2001571>) and `GEANT4` for simulating the interaction of particles (mainly protons) in the substrate and the surrounding materials (mainly aluminum), including secondaries and electromagnetic showers. The cosmic-ray rate is expected to be 400 Hz on a single silicon wafer on which the bolometers are
placed. Since the time between hits is comparable to the time constant of the TES (a few ms), individual cosmic-ray hits may not be identified. Hence the net effect is an increase in noise, which may be non-Gaussian.


Cosmic rays impacting the silicon wafer deposit part of their energy of 1.8 MeV on average as heat. The heat propagation in the wafer is simulated using a finite-element thermal model in the commercial software `COMSOL`, assuming the wafer heat capacitance and the heat conductance to the refrigerator's thermal bath is kept at a temperature of 100 mK~#cite(<Stever_2021>). The heat produced by the cosmic-ray impact propagates to the TES through the SiN support structure, producing a transient fluctuation in the TES current. The sensitivity of the detector
is used to convert the TES current to an equivalent signal power. The bolometer analog signal is digitized with a rate of 20 MHz, and down-sampled to about 19 Hz with the application of a digital low-pass filters. In this process, the higher frequency components are dropped without any aliasing effects. The bolometers' signals are read out in the frequency domain using cryogenic resonators. The resonant peak overlap in the frequency domain may cause crosstalk between detectors, since the cosmic-ray glitch signal is fast and has wide bandwidth. In the
simulation study, we implement both effects in the `TOAST` simulator that generates the time-ordered data and projects it onto sky maps~#cite(<Tominaga2020SPIE>)


In this study, we do not include the athermal (ballistic) phonon effect, since this effect is hard to model at this stage. The modeling would require detailed comparisons between the measurements of the athermal phonon signals and the underlying physics models in a simulation. We plan to develop a ray-tracing technique for producing Monte Carlo simulations of athermal phonon propagation effects in the #emph[LiteBIRD] detector wafer, which are currently ongoing. It should be noted, however, that with the expected impact rate of 400 hits s$""^(- 1)$ in the
wafer, the total amount of energy that propagates as athermal phonons will contribute to the same amount of average noise across the wafer, as indicated by modeling the thermal phonons. Furthermore, we note that athermal phonons would produce short pulses smoothed by the TES time constant of a few msec, whose higher frequency components are removed by the digital filters.


In @ss:forecasts_delta_r we show band-weighted averaged angular power spectrum obtained with the technique developed in Refs.~@Tominaga2020SPIE and ~#cite(<Stever_2021>). We take into account this effect as an additional noise in $N_ell$ in @eq:cl-measured-in-likelihood and @eq:cl-model-in-likelihood. The magnitude of the cosmic-ray noise is about 1 % of the total noise estimated with the component separation in @fig:xforecast-results-pysm.


=== HWP Systematic Effects
<sec:HWP-systematics>


The fast rotating HWPs are key elements of #emph[LiteBIRD], allowing quasi-instantaneous estimation of the Stokes parameters $I$, $Q$, and $U$, with individual polarized detectors. An ideal HWP rotates the incident polarization by a known angle. However, due to the complexity of the structure of transmissive broadband HWPs, requiring multiple stacked sapphire plates with arc, dielectrically embedded in a multi-layer structured plate, etc., the transformation of Stokes parameters is more complex, leading to potential artifacts in polarization maps
(specifically, mixing of Stokes parameters). Those imperfections can be described by the Jones formalism connecting the input and output electric fields, before and after the HWP, respectively~@10.1111-j.1365-2966.2007.11558.x: $
  vec(E_(x  thick  o), E_(y  thick  o)) = mat(delim: "(", J_(x x), J_(x y); J_(y x), J_(y y)) vec(E_(x  thick  i), E_(y  thick  i)) ,
$ <eq:jones> as well as the Mueller matrix formalism relating the input and output Stokes parameters: $
  vec(I_o, Q_o, U_o, V_o) = mat(delim: "(", M_(I I), M_(I Q), M_(I U), M_(I V); M_(Q I), M_(Q Q), M_(Q U), M_(Q V); M_(U I), M_(U Q), M_(U U), M_(U V); M_(V I), M_(V Q), M_(V U), M_(V V)) vec(I_i, Q_i, U_i, V_i) .
$ The relation between the Mueller matrix $M$ and the Jones matrix $J$ can be found in Refs.~#cite(<Bryan:10>) and @Leahy2010, for example.


We now introduce different types of perturbations in the coefficients describing the HWP in order to model imperfections. We have carried out two independent studies of the effect of imperfections on the final $B$-mode signal: the first study, based on the Mueller-matrix formalism is focused on the effect of ip for a transmissive HWP; and the second study, based on the Jones formalism, addresses the effects of polarization efficiency and $Q$/$U$ mixing. Other potential systematic effects include HWP rotation-synchronous signal observed in
Refs.~#cite(<Johnson_2007>) #cite(<ritacco2017>), which will be studied in future.


We first focus on the effect of instrumental polarization. For oblique incidence angles, a small fraction of the unpolarized incident intensity is transfered into polarization (due to anisotropic transmission for a transmissive HWP), inducing non-zero $M_(Q I)$ and $M_(U I)$ elements with azimuthal angle dependence in particular at 4 times the HWP rotation frequency. A model of the observations can be written as
$ s = #scale(x: 180%, y: 180%)[(] 1 thin thin cos 2 psi_0 thin thin sin 2 psi_0 thin thin 0 #scale(x: 180%, y: 180%)[)] thin M ( Theta , rho - psi ) thin R ( 2 psi ) vec(I_i, Q_i, U_i, V_i) + n . $<modelDataHWP> The various quantities here are: $s$ is the observed signal on a polarized detector at angle $psi_0$ with respect to a reference axis in the fp coordinates; $psi$ is the rotation angle of the reference axis of the FP with respect to the sky reference frame in which the Stokes parameters $I_i$, $Q_i$, $U_i$ and $V_i$ of the incoming wave are
calculated; $rho = omega_("HWP") thin t + rho_0$ is the HWP rotation angle with respect to the sky reference frame; $Theta$ is the incident angle with respect to the optical axis of the HWP; and $R ( 2 psi )$ is the rotation matrix for Stokes parameters. The HWP Mueller matrix $M$ is written in the frame of the HWP.


The Mueller matrix of the HWP has been calculated using the electromagnetic wave propagation simulation tool rcwa assuming a nine-layer HWP with pyramidal arc optimized for LFT.#footnote[For the HWPs of MHFT, we give a mathematical model using the Jones Matrix, which will be described in the following section.] In an electromagnetic simulation, we find that the Mueller matrix can be expanded into three components consisting of the constant one (0f), one modulated with an angular frequency twice that of the HWP rotation (2f), and one with 4 times that
frequency (4f). Each element of the matrix $M_(i j)$ for a given incident angle $Theta$ is decomposed into sine waves with respect to the angle $rho - psi$, and only the first three terms are shown to be significant: $
  M_(i j) ( Theta , rho - psi ) = M_(i j)^( 0 f ) ( Theta ) thin + thin M_(i j)^( 2 f ) ( Theta ) cos ( 2 rho - 2 psi + phi.alt_(i j)^( 2 f ) ) thin + thin M_(i j)^( 4 f ) ( Theta ) cos ( 4 rho - 4 psi + phi.alt_(i j)^( 4 f ) ) .
$ <eq:M> Coefficients of the three matrices $M^( 0 f )$, $M^( 2 f )$ and $M^( 4 f )$, as well as the phases $phi.alt_(i j)^( 2 f )$ and $phi.alt_(i j)^( 4 f )$#footnote[Those phases are defined for one reference location in the focal plane and are modified for different azimuthal angles around the HWP rotation axis in a fixed frame in the focal plane.] have been estimated for the whole band at 140 GHz and for many angles $Theta$. The IP coefficients of the $M^( 4 f )$ matrix (four times the HWP spinning frequency) are the ones inducing a significant
effect on the final $B$-mode power spectrum. The values of those coefficients $epsilon.alt = M_(Q I)^( 4 f ) = M_(U I)^( 4 f )$ are found to be $tilde.eq 4 times 10^(- 5)$ for $Theta_0 = 10^compose$. The empirical relation $epsilon.alt ( Theta ) = epsilon.alt ( Theta_0 ) (sin Theta \/ sin Theta_0)^2$ is used to extrapolate the coefficients for any $Theta$ values corresponding to various locations of detectors in the focal plane.


We have generated input TOD simulations implementing #ref(<modelDataHWP>, supplement: none), which include polarized CMB anisotropies (with $r = 0$), CMB dipole, and polarized Galactic foregrounds from `PySM` described in @sec:reference_skies, with and without noise.#footnote[Since the model and the map-making relations are linear with respect to the input TOD, the effect of HWP imperfection on the recovered signal can be estimated without noise in the simulations.] We assume the nominal scanning strategy described in @tbl:imo1. Simulated data are
projected into $I$, $Q$, $U$ maps using the optimal GLS map-making method `SANEPIC`~#cite(<Patanchon08>) (see also Ref.~#cite(<deGasperis16>) for a similar derivation and a description of the application for mapping on a sphere) applied to each detector. The residual maps are calculated by differencing the recovered and input maps used for the simulations.


Some cancellation of the leakage contributions is happening when combining several detectors at different location around the HWP rotation axis. This is because for detectors with different azimuthal angles around the HWP rotation axis, the ordinary axis of the HWP is orthogonal to the different detector lines of sight at different times, leading to different phases of the IP contribution for different detectors at a given time. This phase shift is accounted for in our multi-detector simulations. The resulting contribution of the IP to the $B$-mode
spectra after combining all Stokes parameter maps for all detectors at 140 GHz is shown in @fig:IPHWP. The contributions of the dipole and of the other fluctuations are shown separately. An apodized Galactic mask has been applied, considering 50 % of the sky. We have assumed two cases: (i) the optical axis of the HWP is centered in the LFT focal plane; and (ii) the HWP rotation axis is shifted by $5^compose$. There is less cancellation in the second case. The induced bias $Delta r$ on the tensor-to-scalar ratio $r$ using the likelihood described in
@sub:ErrorForm is indicated in @tab:dr_IP.



#figure(
  align(center)[#table(
    columns: 5,
    align: (center,center,center,center,center,),
    table.header([], [HWP centered], [HWP shifted by 5$""^compose$], [Mitigated, model~1], [Mitigated, model~2],),
    table.hline(),
    [$Delta r$], [$1.36 times 10^(- 4)$], [$1.47 times 10^(- 3)$], [$< 1.20 times 10^(- 6)$], [$< 1.84 times 10^(- 7)$],
  )],
  caption: [Contribution of the IP to the $Delta r$ parameter. The most pessimistic case of a shifted HWP is used for evaluation of the effect after correction with two different schemes: for model 1, when the $epsilon_i$ coefficients are estimated independently for each detector; and for model 2 when we use the scaling relation $epsilon (Theta, phi)$ accounting for the exact relative phase dependence of this parameter with respect to the azimuthal angle of the detector locations $phi$ around the HWP rotation axis (two detectors at different locations in
the FP see the same $4 f$ IP effect with a known delay, as described further in the text).],
  kind: table,
  ) <tab:dr_IP>


// [figvision-cn] imgs/resCell_PTEP_210912.png
// 这是一张对数-对数坐标系的曲线图，展示了不同条件下功率
// 谱随多极矩变化的趋势。横轴标记为“ℓ”，代表多极矩，范围
// 从10^0到10^3。纵轴标记为“ℓ(ℓ+1)C_ℓ/2π [μK²]”，代表归一
// 化后的功率谱，单位是微开尔文平方（μK²），范围从10^-10
// 到10^1。图中包含七条不同颜色的曲线，分别代表不同的物理
// 量或模拟情况：蓝色实线表示输入EE模式功率谱，位于图表最
// 上方，数值在10^-2到10^0之间波动；绿色实线表示理论BB模
// 式功率谱（r=0.001），呈现平滑上升趋势，数值在10^-5到10
// ^-4之间；红色锯齿状实线表示单个探测器倾斜6.24°产生的BB
// 偏差，数值在10^-5到10^-4之间剧烈波动；青色锯齿状实线表
// 示偶极子引起的BB偏差，数值在10^-7到10^-5之间波动；紫色
// 锯齿状实线表示存在5°偏移的偶极子引起的BB偏差，数值在10
// ^-7到10^-4之间波动；黄色锯齿状实线表示强度I（ℓ>1）向偏
// 振P转换引起的BB偏差，位于图表底部，数值在10^-9到10^-8
// 之间；黑色锯齿状实线表示存在5°偏移的强度I（ℓ>1）向偏振
// P转换引起的BB偏差，数值在10^-8到10^-7之间。图例位于左
// 上角和右上角，详细列出了每条曲线的含义。整体来看，该图
// 展示了不同误差源对BB模式功率谱的影响程度，其中单个探测
// 器倾斜和偶极子效应影响较大，而强度向偏振转换的影响相对
// 较小。
// [figvision-cn] imgs/resCell_PTEP_210912.png
// 这是一张对数-对数坐标系的曲线图，展示了不同条件下功率
// 谱随多极矩变化的趋势。横轴标记为“ℓ”，代表多极矩，范围
// 从10^0到10^3。纵轴标记为“ℓ(ℓ+1)C_ℓ/2π [μK²]”，代表归一
// 化后的功率谱，单位是微开尔文平方（μK²），范围从10^-10
// 到10^1。图中包含七条不同颜色的曲线，分别代表不同的物理
// 量或模拟情况：蓝色实线表示输入EE模式功率谱，位于图表最
// 上方，数值在10^-2到10^0之间波动；绿色实线表示理论BB模
// 式功率谱（r=0.001），呈现平滑上升趋势，数值在10^-5到10
// ^-4之间；红色锯齿状实线表示单个探测器倾斜6.24°产生的BB
// 偏差，数值在10^-5到10^-4之间剧烈波动；青色锯齿状实线表
// 示偶极子引起的BB偏差，数值在10^-7到10^-5之间波动；紫色
// 锯齿状实线表示存在5°偏移的偶极子引起的BB偏差，数值在10
// ^-7到10^-4之间波动；黄色锯齿状实线表示强度I（ℓ>1）向偏
// 振P转换引起的BB偏差，位于图表底部，数值在10^-9到10^-8
// 之间；黑色锯齿状实线表示存在5°偏移的强度I（ℓ>1）向偏振
// P转换引起的BB偏差，数值在10^-8到10^-7之间。图例位于左
// 上角和右上角，详细列出了每条曲线的含义。整体来看，该图
// 展示了不同误差源对BB模式功率谱的影响程度，其中单个探测
// 器倾斜和偶极子效应影响较大，而强度向偏振转换的影响相对
// 较小。
#figure(placement: top, [#box(image("imgs/resCell_PTEP_210912.png", width: 49.0%)) #box(image("imgs/resCell_PTEP_corr_210912.png", width: 49.0%))

  ],
  caption: [
    #emph[Left]: $B$-mode power spectra of the residual IP leakage. The curves are: the residual power spectrum for one detector at $6.24^compose$ from the HWP rotation axis (red); the combined effect (all detectors at 140 GHz LFT) for the dipole only and a centered HWP (cyan); the combined effect of the dipole and $5^compose$ HWP tilt (violet); and the same as the cyan and violet cases, but for anisotropies without the dipole (yellow and black). #emph[Right]: $B$-mode power spectra of residual IP after correction with the fit of individual detector IP
amplitude in cyan (model~1), and using the $epsilon.alt ( Theta )$ model in violet (model~2). The power spectrum without correction (effect of the dipole and of the anisotropies combined) is shown in red. We used the less favorable case of a $5^compose$ tilt of the HWP rotation axis.
  ]
)
<fig:IPHWP>


A correction method has been implemented and applied to the simulations including noise. With this method, the Stokes parameter maps, as well as the IP coefficients $epsilon.alt$, are jointly estimated by maximizing a global likelihood. The recovered polarization maps are then corrected from the effect. Two models used are: (1) when the $epsilon.alt_i$ coefficients are estimated independently for each detector; and (2) when we use the scaling relation $epsilon.alt ( Theta , phi.alt )$ with the relative phase dependence of this parameter with respect to
the azimuthal angle of the detector locations $phi.alt$ around the HWP rotation axis. The method does not use any external template and exploits from the large intensity signal to recover the $epsilon.alt$ parameters. Because the monopole is not recovered within the map-making process, it is jointly fitted with the $epsilon.alt$ parameters, and so is marginalized over, in order to remove its leakage in the polarization maps. The procedure is described in @Patanchon21. The residual $B$-mode spectra of the IP after correction are shown in @fig:IPHWP and
the values of $Delta r$ are indicated in @tab:dr_IP. Three years of observation is assumed here. We observe that the bias is greatly reduced after mitigation. We argue that the phase of the residual effect in the map is random after mitigation because the errors on $epsilon.alt$ are limited by noise, so if more frequency channels are included in the analysis the net effect after component separation should be reduced. The quoted value in @tab:dr_IP calculated for the 140-GHz LFT channel only is then expected to be pessimistic. We do not consider in this
study the coupling with other systematic effects, such as gain variation that might affect the estimation of the parameters and the efficiency of the subtraction. This is postponed to future studies. In our second study, we only consider orthogonal incidence on the HWP, i.e., $Theta = 0$ and HWP systematic effects other than the IP leakage.


Even if orthogonal propagation through the HWP is assumed, manufacturing imperfections could still lead to systematic effects in the observed CMB signal. The goal of our second study is to set requirements on the accuracy needed to constrain departures of the HWP from the ideal setup. Requirements are set by imposing a threshold on the maximum bias $Delta r$ that we could tolerate being due to a combination of HWP systematic effects, including the effect of frequency-dependent HWP parameters~#cite(<Duivenvoorden2021>) #cite(<giardiello2021hwp>)


We can make explicit the dependence of the Jones matrix in @eq:jones (in the HWP frame) on the HWP non-idealities: $
  J_("HWP") = mat(delim: "(", 1 + h_1, zeta_1 e^(i chi_1); zeta_2 e^(i chi_2), - ( 1 + h_2 ) e^(i beta)) ,
$ <eq:realistic> where the frequency dependence of each parameter is understood. In @eq:realistic, $h_(1  thin  2) < 0$ are loss terms, $beta = psi - pi$, where $psi$ is the phase shift between the orthogonal modes, and $zeta_(1  thin  2)$ and $chi_(1  thin  2)$ are amplitudes and phases responsible for $x - y$ polarization mixing. The phases $chi_(1  thin  2)$ are set to zero in this work, being degenerate at first order with $zeta_(1  thin  2)$. From the Jones matrix, the equivalent Mueller matrix elements
$M^(I X) = M^(I X) ( h_(1  thin  2) , zeta_(1  thin  2) , beta )$ with $X = I , Q , U$ can be derived.


We are considering in the simulation a pair of orthogonal detectors on the boresight with a noise contribution. Since we want to propagate to $r$, we make use of CMB bands, specifically four MFT bands and one band for LFT and HFT, respectively (the closest ones to CMB channels). We make use of simulated mesh HWP profiles in frequency for the parameters ($h_1 ( nu )$, $h_2 ( nu )$, $beta ( nu )$) in the four MFT bands centered at 100, 119, 140, and 166 GHz, respectively. We assume $zeta_(1  thin  2) = 10^(- 2)$, constant in frequency~#cite(<Pisano2>). For the
LFT/HFT band centered at 100/195 GHz, we assume only parameters that are constant in frequency, since our study is not very affected by the frequency dependence of the model profiles. The resolution of those profiles is 1 GHz.


When building the TOD, we perturb the HWP frequency profiles so as to simulate a mismatch with the nominal HWP profile. In particular, we have $M_("TOD")^(I X) equiv M^(I X) ( h_12 + Delta h , zeta_(1  thin  2) + Delta zeta , beta + Delta beta )$, where, again, the frequency dependence in each term is understood. In each frequency bin within a band, the perturbations $Delta x$ are drawn from band- and frequency-independent Gaussian distribution with variance $sigma_(Delta x)^2$, where $x$ stands for either of $h$, $beta$, or $zeta$. Instead, in the
map-making procedure, we make use of the unperturbed, nominal HWP profile, i.e., $M_s^(I X) equiv M^(I X) ( h_(1  thin  2) , zeta_(1  thin  2) , beta )$.


In order not to be dependent on a specific realization of the systematic perturbations, we simulate 10 realizations for each $sigma_(Delta x)$, by always keeping CMB and foreground fixed. For each band, we compute a template map $upright(bold(m))_("templ")$ with $M_("TOD")^(I X) ( nu )$ = $M_s^(I X) ( nu )$ (so, no error on the HWP parameters) from the same foreground and CMB maps as above. These templates are used to obtain residual maps; this yields maps of residuals $upright(bold(m))_("res")$ that are minimally affected by the foreground color effect
and mostly due to the mismatch between $M_("TOD")^(I X) ( nu )$ and $M_s^(I X) ( nu )$.


For each map of residuals, masked with a 70 % Galactic mask, the corresponding $B$-mode spectrum is computed and added to the fiducial CMB $B$-mode spectrum. We use the simple `anafast` pseudo-$C_ell$s for the residuals, since those are not very different from the cases in which corrections for partial sky and $E$-$B$ mixing are applied. We use the angular power spectrum obtained from the sum of the sky maps of the fiducial CMB and the residual as the first term in @eq:cl-measured-in-likelihood to the likelihood function in
@eq:global-likelihood. In the exact likelihood approach, we compute the posterior probability distribution of $r_(Delta x)$ given our data. The likelihood analysis is performed in the range $2 lt.eq ell lt.eq 200$, considering also the foreground residuals and noise from component separation, which allow us to properly weight each multipole. The bias $Delta r$ due to $sigma_(Delta x)$ is finally quantified, as defined in @eq:r-bias-definition.


In @tab:dr_dsyst we report the threshold value of $Delta x$ for each systematic parameter to have a bias $Delta r = 5.7 times 10^(- 6)$, when perturbing each systematic one at a time. We have checked that, for small enough values of $sigma_(Delta x)$, we have $Delta r prop sigma_(Delta x)^2$. In cases where two systematic effects are introduced simultaneously with uncorrelated errors, we expect the resulting systematic bias to be the sum of the biases resulting from individual systematic errors, i.e.,
$Delta r ( sigma_(Delta x) , sigma_(Delta y) ) tilde.eq Delta r ( sigma_(Delta x) ) + Delta r ( sigma_(Delta y) )$, where $x$ and $y$ are selected from $h$, $beta$, and $zeta$. This has been checked by taking 200 realizations for each $sigma_(Delta x)$, causing approximately the same level of $Delta r$, and comparing them with the cases of two systematic effects perturbed at the same time with those $sigma_(Delta x)$ values.


We checked that if we consider the residual maps for each band generated with errors just smaller than or equal to those shown in @tab:dr_dsyst and we add them with the corresponding weights from component separation, the $Delta r$ values associated with that comes out less than half of the error budget of $5.7 times 10^(- 6)$. So, we can assume that properly performing component separation might lead to smaller residuals.


The net effcet of $Delta zeta$ integrated over the bandwidth produces the same effect as a shift of the angle of the HWP $Delta rho$ and so contributes to the global uncertainty on this parameter. Its impact at first order can be reduced by minimizing the $E B$ correlation of the CMB (as described in Ref.~@minami-komatsu:2020). Because of the frequency dependence of $Delta zeta$, color effects between Galactic dust and the CMB might induce residual systematic contributions.



#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (center,center,center,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.cell(rowspan: 2)[Band], [$sigma_(Delta h)$($Delta r = 5.7 times 10^(- 6)$)], [$sigma_(Delta beta)$($Delta r = 5.7 times 10^(- 6)$)], [$sigma_(Delta zeta)$($Delta r = 5.7 times 10^(- 6)$)],
    table.hline(stroke: 0.5pt),
    [\[$sqrt("GHz")$\]], [\[$"deg."$-$sqrt("GHz")$\]], [\[$sqrt("GHz")$\]],
    [100 GHz (LFT)], [$lt.eq 0.0022$], [$lt.eq 2.5$], [$lt.eq 0.0012$],
    [100 GHz (MFT)], [$lt.eq 0.0023$], [$lt.eq 2.0$], [$lt.eq 0.0013$],
    [119 GHz (MFT)], [$lt.eq 0.0031$], [$lt.eq 1.6$], [$lt.eq 0.0011$],
    [140 GHz (MFT)], [$lt.eq 0.0021$], [$lt.eq 0.8$], [$lt.eq 0.0012$],
    [166 GHz (MFT)], [$lt.eq 0.0014$], [$lt.eq 1.1$], [$lt.eq 0.0010$],
    [Total (MFT)], [$lt.eq 0.0014$], [$lt.eq 0.83$], [$lt.eq 0.0010$],
    [195 GHz (HFT)], [$lt.eq 0.0013$], [$lt.eq 0.83$], [$lt.eq 0.0008$],
    table.hline(stroke: 0.8pt),
  )],
  caption: [Accuracy level needed for measurements of HWP parameters $h$, $beta$, and $zeta$ in order to keep the bias on $r$ below $Delta r = 5.7 times 10^(-6)$. Threshold values are given for individual #emph[LiteBIRD] MFT frequency bands and one band for each of LFT and HFT (quoted with their band centers). The total MFT threshold is set by the lowest threshold in the MFT bands.],
  kind: table,
  ) <tab:dr_dsyst>


=== Gain Systematic Effects
<sec:Gain-systematics>


The gain drift, i.e., the variation of the gain in time, is mainly caused by fluctuations in the focal-plane temperature, which is kept around 100 mK. Changes in this temperature cause variation of the operational point of the TES placed on the focal plane and its responsivity. We model the gain for each detector, $i$, as a time-varying gain function, $G_i ( t )$, which is injected in a signal timestream as $ d_i ( t ) = G_i ( t ) thin [I ( t ) + Q ( t ) cos ( 4 rho - 2 psi ) + U ( t ) sin ( 4 rho - 2 psi )] , $ where $rho$ is the HWP rotation angle and
$psi$ is the detector polarization orientation. We model the gain function $G_i ( t )$ as a product of a term $g_i^0$ that is constant in time and varying from detector to detector, and another term $g_i ( T_("bath") ( t ) )$ that depends on the thermal bath temperature $T_("bath") ( t )$, varying in time, i.e., $G_i ( t ) = g_i^0 thin g_i ( T_("bath") ( t ) )$. In a simulation we generate some time variation of $T_("bath") ( t )$ using a model of the power spectrum $P_("bath")$ in the frequency domain: $
  P_("bath") = A_("bath")^2 frac(1 med "Hz", f) ,
$ <eq:gain_datamodel> where $A_("bath")$ is the amplitude of $P_("bath")$ at a frequency $f$ of 1 Hz. The model is a good match to measurements of the temperature power spectrum using a dilution refrigerator. We assume the bath temperature $T_("bath") ( t )$ to be common for all detectors on the same wafer. We assess the systematic effects by simulating realistic #emph[LiteBIRD] detector response in order to convert the focal-plane bath temperature to the responsivity of the detectors. We assume that the detector constant gain $g_i^0$ varies as a
Gaussian distribution with a mean value of unity and a standard deviation of $sigma_g$. The time-varying term $g_i ( T_("bath") ( t ) )$ starts at a value of unity at $t = 0$. Finally, we simulate using the `TOAST` framework the time samples encoding both astrophysical signals and thermal bath fluctuations for the full LFT focal plane frequency channels observing for 1~year with #emph[LiteBIRD]'s scanning strategy.


// [figvision-cn] imgs/Tbath_fluct_all_BB_211213.png
// 该图为单张对数-对数坐标曲线图，展示 LiteBIRD 卫星 LFT
// 100-GHz 通道中由增益漂移和增益标定误差引入的系统性偏差
// 在 B 模功率谱（Cℓ^BB）上的表现。横轴为多极矩 ℓ（
// Multipole moment ℓ），范围从约 2 到 300，刻度标记包括
// 10¹ 和 10²；纵轴为 B 模角功率谱 Cℓ^BB，单位为微开尔文
// 平方（μK²），范围从 10⁻¹² 到 10⁻⁴，采用对数刻度。 图中
// 包含以下元素： 两条参考理论曲线： 点线（dotted line）
// 标注 “r = 10⁻³”，代表张量与标量比 r=10⁻³ 对应的原初引
// 力波 B 模功率谱，起始于 ℓ≈2 时 Cℓ^BB ≈ 10⁻⁵ μK²，随 ℓ
// 增加缓慢下降，在 ℓ≈50 后趋于平缓至 ~10⁻⁷ μK²。 虚线（
// dash-dotted line）标注 “lensing BB”，代表引力透镜效应
// 产生的 B 模功率谱，为水平直线，值恒定在 Cℓ^BB ≈ 1.5×10
// ⁻ μK²，横跨整个 ℓ 范围。 一条粗实线（thick solid red
// line）：表示模拟或实测得到的系统性偏差信号，位于 Cℓ^BB
// ≈ 3–6 × 10⁻¹⁰ μK² 区间内，整体呈轻微波动但基本平坦的趋
// 势，无明显随 ℓ 变化的斜率。 多条细蓝色实线（thin blue
// lines）：共约 20 条，代表不同蒙特卡洛实现或参数扰动下
// 的偏差样本轨迹，它们围绕红色粗线上下波动，形成带状分布，
// 反映不确定性或统计涨落。这些线条被一个半透明浅蓝色填充
// 区域包围，该区域覆盖所有蓝色细线的上下包络，直观显示偏
// 差的离散程度。 另一条虚线（dashed black line）标注 “r
// = 10⁻⁵”：代表更小的张量贡献（r=10⁻⁵）对应的理论 B 模谱，
// 起始于 ℓ≈2 时 Cℓ^BB ≈ 10⁻⁷ μK²，随 ℓ 增加迅速下降，在
// ℓ>100 后低于 10⁻¹⁰ μK²，最终在 ℓ≈300 处降至 10⁻¹¹ μK²
// 以下。 趋势与结论：系统性偏差（红蓝组合）的量级稳定在
// ~10⁻¹⁰ μK²，显著低于 r=10⁻⁵ 的理论信号（尤其在 ℓ>10），
// 更远小于 r=10⁻³ 的信号及透镜背景。这表明当前仪器系统误
// 差尚未达到干扰低 r 值探测的水平，但在高精度测量中仍需
// 控制。同时，偏差在不同 ℓ 上无明显结构，暗示其可能源于
// 全局性校准问题而非空间相关噪声。 注：图中未出现比例尺、
// 颜色条或图例框，所有信息通过线型、颜色和直接文字标注传
// 达。无子图划分，仅一幅主图。
// [figvision-cn] imgs/Tbath_fluct_all_BB_211213.png
// 该图为单张对数-对数坐标曲线图，展示 LiteBIRD 卫星 LFT
// 100-GHz 通道中由增益漂移和增益标定误差引入的系统性偏差
// 在 B 模功率谱（Cℓ^BB）上的表现。横轴为多极矩 ℓ（
// Multipole moment ℓ），范围从约 2 到 300，刻度标记包括
// 10¹ 和 10²；纵轴为 B 模角功率谱 Cℓ^BB，单位为微开尔文
// 平方（μK²），范围从 10⁻¹² 到 10⁻⁴，采用对数刻度。 图中
// 包含以下元素： 两条参考理论曲线： 点线（dotted line）
// 标注 “r = 10⁻³”，代表张量与标量比 r=10⁻³ 对应的原初引
// 力波 B 模功率谱，起始于 ℓ≈2 时 Cℓ^BB ≈ 10⁻⁵ μK²，随 ℓ
// 增加缓慢下降，在 ℓ≈50 后趋于平缓至 ~10⁻⁷ μK²。 虚线（
// dash-dotted line）标注 “lensing BB”，代表引力透镜效应
// 产生的 B 模功率谱，为水平直线，值恒定在 Cℓ^BB ≈ 1.5×10
// ⁻ μK²，横跨整个 ℓ 范围。 一条粗实线（thick solid red
// line）：表示模拟或实测得到的系统性偏差信号，位于 Cℓ^BB
// ≈ 3–6 × 10⁻¹⁰ μK² 区间内，整体呈轻微波动但基本平坦的趋
// 势，无明显随 ℓ 变化的斜率。 多条细蓝色实线（thin blue
// lines）：共约 20 条，代表不同蒙特卡洛实现或参数扰动下
// 的偏差样本轨迹，它们围绕红色粗线上下波动，形成带状分布，
// 反映不确定性或统计涨落。这些线条被一个半透明浅蓝色填充
// 区域包围，该区域覆盖所有蓝色细线的上下包络，直观显示偏
// 差的离散程度。 另一条虚线（dashed black line）标注 “r
// = 10⁻⁵”：代表更小的张量贡献（r=10⁻⁵）对应的理论 B 模谱，
// 起始于 ℓ≈2 时 Cℓ^BB ≈ 10⁻⁷ μK²，随 ℓ 增加迅速下降，在
// ℓ>100 后低于 10⁻¹⁰ μK²，最终在 ℓ≈300 处降至 10⁻¹¹ μK²
// 以下。 趋势与结论：系统性偏差（红蓝组合）的量级稳定在
// ~10⁻¹⁰ μK²，显著低于 r=10⁻⁵ 的理论信号（尤其在 ℓ>10），
// 更远小于 r=10⁻³ 的信号及透镜背景。这表明当前仪器系统误
// 差尚未达到干扰低 r 值探测的水平，但在高精度测量中仍需
// 控制。同时，偏差在不同 ℓ 上无明显结构，暗示其可能源于
// 全局性校准问题而非空间相关噪声。 注：图中未出现比例尺、
// 颜色条或图例框，所有信息通过线型、颜色和直接文字标注传
// 达。无子图划分，仅一幅主图。
#figure(placement: top, [#box(image("imgs/deltaG_vs_tbath_r_req_reio_recomb_211213.png", width: 48.0%)) #box(image("imgs/Tbath_fluct_all_BB_211213.png", width: 48.0%))

  ],
  caption: [
    #emph[Left]: Systematic bias in the tensor-to-scalar ratio, $r$, equivalent to a bias in the $B$-mode power spectrum between $ell = 2$ and $200$ (the range of the recombination peak), coming from the gain drift $A_("bath")$ and the gain miscalibration $sigma_g$ introduced in @sec:Gain-systematics for the #emph[LiteBIRD] LFT 100-GHz channel. The quantity $A_("bath")$ is the amplitude of thermal bath fluctuations of a focal-plane wafer at 1 Hz, while $sigma_g$ is the relative detector gain miscalibration uncertainty. #emph[Right]: $B$-mode power
spectrum showing the bias from unmitigated gain systematic effects in each frequency channel of #emph[LiteBIRD]. The $Lambda$CDM lensing signal is shown as the dash-dotted black line and the tensor signal for $r = 10^(- 3)$ and $r = 10^(- 5)$ in the dotted and dashed black lines, respectively. The blue band shows the range of power of the gain systematic biases for each individual frequency channel. The separate spectra for each channel are shown as faint blue lines. The thick red line is the systematic power spectrum from the noise-weighted average over
each frequency channel.
  ]
)
<fig:systematics_gaindrift_rreq>


In @fig:systematics_gaindrift_rreq (left) we show the bias introduced in the $B$-mode power spectrum between $ell = 2$ and $200$ in terms of the equivalent tensor mode signal and the respective value of $r$ for a simulation of the #emph[LiteBIRD] 100-GHz channel with 144 detectors. We note that thermal bath fluctuations below $A_("bath") = 1 thin mu$K and relative gain miscalibration of $sigma_g = 10 thin %$ (which is consistent with hardware and calibration requirements), produce a bias of $r < 10^(- 5)$. Under the assumption that the gain systematic
effects are mostly uncorrelated between frequency channels of #emph[LiteBIRD], we can take this result for one of the relevant CMB frequency channels as a conservative upper limit on the systematic bias on $r$ from gain systematic effects.


@fig:systematics_gaindrift_rreq (right panel) shows the bias from unmitigated gain systematic effects in the $B$-mode power spectrum. The chosen input parameters for the simulations are $A_("bath") = 1 thin mu$K and $sigma_g = 10 thin %$. The bias in $B$-mode power for each frequency channel resembles mostly a white spectrum and lies within the blue band, while the bias from the noise-weighted average over all frequency bands is shown in red. Over the relevant multipole range this bias is well below the requirement of $r < 10^(- 5)$.


To further lower the residuals several detection and mitigation techniques are now being implemented and tested. They rely on identifying the leakage residuals, estimating these using approximations on the underlying signal, and then mitigating the leakage by subtraction from the data. These mitigation techniques have been shown to reduce the residuals by up to 2 orders of magnitude~#cite(<Puglisi2021>) and will be presented in Ref.~#cite(<puglisi-beck2021>). This is mostly due to the benefit resulting from high sensitivity data and enough cross-linking
redundancy provided by the #emph[LiteBIRD] scanning strategy. The other subdominant potential sources of gain variation in time include fluctuations of the magnetic field, loading power, bias current, and gains of the cold and warm readout electronics. Given the power spectrum models for those fluctuations, we are in principle able to estimate the systematic effects in a similar manner, but this remains future work.


The absolute gain is a conversion factor from the recorded values, usually in volts, to the physical value in units of thermodynamic temperature K$""_("CMB")$. The absolute gain can be calibrated using the solar dipole signal during scans of the sky.#footnote[The orbital dipole can also be used for the absolute gain calibration. We have not yet conducted the study with the existence of possible $1 \/ f$ noise, which remains as future work.] We estimate the expected accuracy of the absolute gain measurement assuming the existence of $1 \/ f$ noise with a
knee frequency of 20 mHz for the channels having the lowest white noise for 1~year. We obtain a value of $5.8 times 10^(- 5)$. We employ the required value of the gain measurement from Ref.~@Ghigna2020, on the order of $10^(- 4)$, to derive a systematic bias of $5.7 times 10^(- 6)$ for the most stringent case in the highest frequency channels. Therefore the expected bias due to the absolute gain systematic effects is $5.7 times 10^(- 6) times ( 5.8 times 10^(- 5) \/ 10^(- 4) )^2 = 1.9 times 10^(- 6)$.


=== Other Systematic Effects
<sec:other-systematics>


==== Polarization Angle
<polarization-angle>
The error in the polarization angle causes mixing of the Stokes parameters between $Q$ and $U$, resulting in leakage from $E$ modes to $B$ modes. Since the power of the $E$ modes is significantly larger than that of the $B$ modes, even a small amount of mixing could cause significant contamination to the $B$ modes. The leakage can be described as $C_ell^(E E) times K_("pol")$, where $C_ell^(E E)$ is the $E$-mode power spectrum and $K_("pol")$ is a factor describing the polarization angle homogeneous offset in the entire sky region. The effect is sourced
by the global offset of the absolute polarization angle determined by the roll angle of the spacecraft attitude or the HWP rotation position. This effect is modeled as $K_("pol") = sin^2 ( 2 theta_g )$, where $theta_g$ is the global offset. We assume that the expected calibration accuracy of $theta_g$ will be 2.7 arcmin, as described in @ss:plm_calib and in @ss:plm_calib, yielding a $Delta r$ value of $9.1 times 10^(- 6)$.


The systematic effect of relative polarization angle uncertainties between frequency channels is studied by @ss:plm_calib and described in Sect. #ref(<ss:plm_calib>, supplement: none) The requirement to give the systematic bias $Delta r = 5.7 times 10^(- 6)$ is shown in @fig:LBangle_requirement. The expected precision of measuring the relative angle with the Crab Nebula is shown in @tab:sensitivity_to_crab. Since the expectation is comparable to the requirement, we assign a $Delta r$ value of $5.7 times 10^(- 6)$ for the systematic uncertainty of the
relative angle. The frequency dependence of the polarization angle in the observation band includes the parameter $zeta$ for the HWP (described in @sec:HWP-systematics) and the sinuous-antenna wobbling effect. The net effect of those effects with an integration within the bandwidth is calibrated by the global and relative angles as described above.


The wobble effect in individual detectors is expected to be smaller than the systematic uncertainties of the HWP $zeta$, if we assume that the uncertainty of the wobble effect is uncorrelated among the detectors, resulting in a reduction of the bias $Delta r$ proportional to the inverse of the number of detectors in the band. We also note that the wobble effect could be canceled further if we use four sinuous antenna patterns~#cite(<aritokisuzuki-dthesis>), mutually rotated by $45^compose$ and inverted. The current focal-plane design employs this technique.


The HWP rotation position is determined by the encoder described in @sss:plm_lft_pmu, with a demonstrated accuracy of less than 1 arcmin, yielding an expected systematic bias of $Delta r = 1.0 times 10^(- 6)$. The time variation of the polarization angle determination accuracy of the star trackers gives negligible systematic effect $Delta r < 10^(- 7)$, if we assume that the variation is Gaussian, since the effect cancels out for longer observation times. This may not be true when there is a long time correlation in the error; however, this systematic
effect is found to still be much smaller than the constant offset effects shown above. The identification of possible error correlations needs further study.


==== Polarization Efficiency
<polarization-efficiency>
The uncertainty of the polarization efficiency is modeled as an uncertainty of the couplings of the Stokes parameters of $Q$ or $U$, described in the Mueller matrix as $M_(Q Q)$ and $M_(U U)$. The polarization efficiency uncertainties are sourced by the HWP and detectors. When the polarization efficiency error of the detectors are uncorrelated, the effect may be scaled proportional to the inverse of the square root of the number of detectors, yielding effects of negligible amplitude. On the other hand, an uncertainty in the HWP gives a significant
impact, since it is common to all the focal-plane detectors. The polarization efficiency is related to the absolute normalization of the $E$- and $B$-mode power spectra. The net effect of including the efficiency from the HWP with the frequency band-average is calibrated using the $E$-mode power spectrum for higher multipoles, while its frequency dependence in the band will be calibrated using the ground facility. The expected calibration accuracy is found to be 0.2 % using the $E$-mode power spectrum for a higher multipole region, given the detector
noise. If we assume that the $B$-mode lensing effect converts to the tensor signal by the amount of the uncertainty, then we expect a systematic bias of $Delta r = 5.6 times 10^(- 6)$. We note that the uncertainties in the frequency dependence of the polarization efficiency in the observation band is taken into account through the uncertainties in the parameter $beta$ in @sec:HWP-systematics.


==== Pointing
<pointing>
Pointing errors can arise for several reasons: measurement uncertainties in the start tracker; mis-alignment between the star tracker and the bore-sight direction of the telescopes; vibration caused by the refrigerators; and deformation of the optical system, which includes the mirrors, lenses, and the support structure. The frequency and direction of the pointing deviation depend on the source of the error. Models of the possible effects on the pointing will be explored in future. Here we consider two simple cases: a static bias in the pointing; and
Gaussian random perturbations at the sampling rate of 19 Hz. The net effect causes polarization leakage from $E$ to $B$ modes, resulting in a residual power spectrum similar to that of gravitational lensing. This effect is also independent of the existence of the PMU. We perform a simulation study for the two cases. For the offset case, we find that a pointing bias in the direction orthogonal to the scanning orientation yields the most stringent requirement of 4.6 arcmin to give $Delta r = 5.7 times 10^(- 6)$. On the other hand, the random disturbances
expected from the star-tracker pointing accuracy of 0.23 arcmin yield a negligible bias of $Delta r < 10^(- 6)$.


The wedge shape of the spinning HWP also causes pointing disturbances, where we define the wedge shape as the lack of parallelism between the plate surfaces. We therefore also conduct a simulation study assuming that the wedge produces a pointing disturbance rotating with the HWP spinning rate around the original detector pointing. This gives a requirement on the allowable maximal wedge angle in the HWP wafer fabrication with the relation $phi.alt = ( n - 1 ) psi$, where $psi$ is the HWP wedge angle, $n$ is the refractive index and $phi.alt$ is the
pointing disturbance angle. For sapphire, having $n = 3.1$ as an example, we set the requirement of $psi$ to be smaller than 4.0 arcmin to give $Delta r = 5.7 times 10^(- 6)$.


==== Bandpass
<bandpass>
We study the impact of uncertainties on the frequency bandpass determination producing inter-frequency mismatch on the measurement of $r$. These uncertainties propagate into uncertainties in the amplitude of components, including leakage, after applying foreground separation. The amplitude offsets are supposed to be an average effect over the full arrays of detectors, therefore the requirement on individual detectors is relaxed by a factor of $sqrt(N)$, where $N$ is the number of detectors in the array, with an assumption that the offset measurements are
uncorrelated. This assumption is not appropriate when the correlation coefficient is larger than $1 \/ N$, however. We describe the bandpass uncertainty using a single parameter $gamma_c$ defined in @eq:colorCorrection, where subscript $c$ is either the dust or synchrotron component. We employ the discussions in Ref.~@Ghigna2020 to give the systematic bias $Delta r$ for the bandpass uncertainty with the usage of the PMU. The systematic effects are evaluated as a function of the uncertainties of $gamma_c$ for 's 15 frequency
channels individually with the application of the foreground subtraction procedure~#cite(<Ghigna2020>). With a requirement of $Delta r$ to be less than $5.7 times 10^(- 6)$, the requirements on the measurement accuracy of $gamma_c$ is in the range of $10^(- 4)$ to $2.5 times 10^(- 3)$, depending on the frequency channels for the detector arrays. The most stringent requirement is given for the two highest frequency channels. Here we assume that we measure the bandpass with the most stringent requirement for all the frequency channels, and calculate the
systematic residual $B$-mode power spectrum to obtain a systematic bias of $Delta r = 5.3 times 10^(- 6)$.


==== Crosstalk
<crosstalk>
The readout system makes use of frequency domain multiplexing, which is described in @ss:we. This scheme can reduce the total number of readout wires and the heat load to the cryogenic detectors, but could also introduce crosstalk effects due to the interference of the frequency comb. Such effects are modeled as a single matrix $W_(i j)$ that describes the leakage of the measured power from detector $j$ to detector $i$. We study the crosstalk effects with a model similar to the SPT-3G design ~#cite(<Montgomery2021>). We explore ten models of detector
readout orders in the frequency domain and detector physical positions in the focal plane to give $W_(i j)$, and find that the systematic effect is almost independent of the models, but does depend on the magnitude of the uncertainties in $W_(i j)$. For the case of the 0.1 % uncertainties on that, the systematic error on the $B$-mode power (lensing) is 0.07 %, corresponding to $Delta r$ of less than $10^(- 7)$ in case of the true $r$ value to be 0 without foregrounds. We assign a systematic error budget of $Delta r = 5.7 times 10^(- 6)$ to this,
requiring the crosstalk knowledge uncertainty to be less than 1 %.


==== Detector Time Constant
<detector-time-constant>
The TES used for #emph[LiteBIRD] is known to have a time constant $tau$ of about 3 ms, which can be well modeled by a single exponential function. The net effect of the convolution in time due to this function is a rotation angle shift $phi.alt$ of the HWP for the $4 f$ modulated signals: $tan ( 4 Delta phi.alt ) = 4 omega_("HWP") tau$, where $omega_("HWP")$ is the angular speed of the spinning HWP. This shift remains after applying polarization angle corrections using the $C_l^(E B)$ power spectrum and has to be further corrected. The uncertainty of
$tau$, $delta tau$, causes a systematic effect, which is given as $delta tau tilde.eq delta phi.alt \/ omega_("HWP")$. For an HWP spinning rate of 1 Hz with the expectation of $delta phi.alt < 1$ arcmin (corresponding to $Delta r = 1.0 times 10^(- 6)$) we obtain $delta tau < 47 thin mu$sec. A measurement of $tau$ may be conducted in flight using the $2 f$-modulated signals caused by the CMB monopole $I arrow.r P$ leakage through the HWP. The LFT HWP is expected to give a $2 f$-modulated signal with an amplitude of $p_0 = 9 tilde.eq 27$ mK. The time
duration $T$ required to measure $tau$ with a precision of $delta tau$ is given by $
  T = 5.7 times 10^2 thin s (frac("NET", 50 thin mu K sqrt(s)))^2 (frac(10 thin "mK", p_0))^2 (frac(1 thin "Hz", nu_("HWP")))^2 (frac(47 thin mu s, delta tau))^2 ,
$ where $nu_("HWP") = omega_("HWP") \/ 2 pi$. The actual time variation in the time constant is not known yet and requires study in the future. We assign $Delta r$ a value of $5.7 times 10^(- 6)$ as the requirement.


== Total Uncertainties of the Tensor-to-Scalar Ratio
<ss:forecasts_delta_r>


This section provides an evaluation of the total uncertainty on the tensor-to-scalar ratio $r$. The power spectrum of the systematic effects in @eq:cl-measured-in-likelihood is given as $
  C_ell^("sys") = sum_i C_ell^("sys" ( i )) + sum_(i eq.not j) chevron.l B_(ell m)^("sys" ( i )) B_(ell m)^("sys" ( j ) *) chevron.r ,
$ <eq:total-systematic-cl> where the first term describes the sum of the $i$th systematic effect power spectrum, and the second term shows the potential correlations between two systematic effects. The factors $B_(ell m)^("sys" ( i ))$ and $B_(ell m)^("sys" ( j ))$ are the $B$-mode coefficients in the spin-harmonic expansion of the $i$th and $j$th systematic residual sky maps, where the residual map is the difference between the sky maps with and without the systematic effects. Therefore, the first term is given as $
  C_ell^("sys" ( i )) = chevron.l B_(ell m)^("sys" ( i )) B_(ell m)^("sys" ( i ) *) chevron.r .
$


With the condition of @eq:r-bias-definition, we may obtain an approximation of small systematic biases: $
  Delta r tilde.eq frac(sum_ell ( 2 ell + 1 ) C_ell^("tens") C_ell^("sys") \/ ( C_ell^n )^2, sum_ell ( 2 ell + 1 ) ( C_ell^("tens") \/ C_ell^n )^2) ,
$ <eq:delta-r-approximation> where $C_ell^("tens")$ is the tensor mode with $r = 1$ and $C_ell^n = C_ell^("lens") + N_ell$ is the sum of the lensing and the noise contributions. The first term in @eq:total-systematic-cl gives the total bias of $r$ as the sum of the individual systematic biases, i.e., $Delta r = sum_i Delta r^( i )$, where $Delta r^( i )$ is obtained from @eq:delta-r-approximation when $C_ell^("sys")$ is replaced by $C_ell^("sys" ( i ))$. The second term is estimated at the map
level by summing up the residual sky maps for individual systematic sources. We evaluate the second term for the systematic effects including the beam far sidelobes, the HWP, and the gain. We compare two $Delta r$ values: one is the sum of individual systematic biases $Delta r^( i )$; and the other is obtained by a single power spectrum from the superimposed residual sky map of individual systematic effects. With 20 realizations, we find that the difference is $plus.minus 20$ %. We therefore assume that the second term in
@eq:total-systematic-cl cancels. An evaluation of the correlation between all systematic effects needs a single combined simulation tool, accounting for all the effects, which is beyond the scope of the current work and remains for future study. In this paper, we assume that the total power spectrum of all systematic effects is given by the first term of @eq:total-systematic-cl. @fig:cl_sys_all shows the power spectra of individual systematic effects, as well as their sum.


Using @eq:total-systematic-cl for all sources of systematic effects, including the gain, the HWP ip, the HWP parameters ($h$, $beta$, and $zeta$), the beam far sidelobes, the polarization angle, the bandpass, pointing, component separation, noise contributions $N_ell$ from foreground subtraction in @fig:xforecast-results-pysm, and noise arising from cosmic-ray effects in @fig:cl_sys_all, we estimate the total error on $r$ to be $delta r = 1.2 times 10^(- 3)$, and the systematic bias to be $Delta r = 0.5 times 10^(- 3)$.
@fig:likelihoods-r shows the likelihood function obtained, as the right blue curve. Other systematic effects including the beam near sidelobe, main lobe, ghosting, beam polarization and shape in band, absolute gain, polarization efficiency, detector time constant, and crosstalk give a bias of $0.03 times 10^(- 3)$, which is obtained by summing the $Delta r$ values in @tbl:syst.


// [figvision-cn] imgs/dl_syst_all_211218.png
// 该图为一幅双对数坐标曲线图，展示了不同物理效应和系统误
// 差源在角功率谱上的表现。 子图类型： 曲线图（对数-对数
// 坐标） 坐标轴说明： 横坐标轴名称为“Multipole moment ℓ”，
// 表示多极矩，范围从约 5 延伸至 300，刻度标记包括 10^1
// 和 10^2，单位无量纲。 纵坐标轴名称为“Dℓ [μK²]”，表示角
// 功率谱幅度，单位为微开尔文平方（μK²），范围从 10^-11
// 到 10^-1，主刻度线以 10 的整数次幂标记（10^-11, 10^-10
// , ..., 10^-1）。 图例与曲线对应关系（按图例从上至下顺
// 序）： Lensing（引力透镜模式）：淡紫色实线。该曲线随 ℓ
// 增加单调上升，在 ℓ=10 时约为 10^-6 μK²，在 ℓ=300 时达
// 到约 10^-2 μK²，是图中在高 ℓ 区域最强的信号之一。 r =
// 0.001（张量模式，张标比 r=0.001）：浅绿色实线。在低 ℓ
// 区（ℓ<20）平坦于约 10^-5 μK²，随后缓慢下降，在 ℓ≈40 后
// 开始回升，在 ℓ>100 后超过部分系统误差曲线，最终在 ℓ=
// 300 时接近 10^-4 μK²。 Gain（增益系统误差）：红色实线。
// 整体呈上升趋势，在 ℓ=10 时约 10^-8 μK²，在 ℓ=300 时升
// 至约 10^-5 μK²。 IP（HWP 仪器偏振）：青色实线。在 ℓ<50
// 时低于 10^-9 μK²，之后波动上升，在 ℓ=300 时约 10^-8 μK
// ²。 HWP h：品红色实线。在 ℓ<100 时低于 10^-8 μK²，之后
// 剧烈振荡并整体上升，在 ℓ=300 时峰值可达 10^-7 μK²。
// HWP β：黄色实线。在 ℓ<100 时低于 10^-8 μK²，之后平缓上
// 升至 ℓ=300 时约 10^-8 μK²。 HWP ζ：棕色实线。行为类似
// HWP β，但略低，在 ℓ=300 时约 10^-8 μK²。 FSL 5-10（远
// 旁瓣，角度范围 5°–10°）：深绿色实线。在 ℓ<50 时低于 10
// ^-8 μK²，之后上升，在 ℓ=300 时约 10^-7 μK²。 FSL 10-15
// （远旁瓣，角度范围 10°–15°）：灰蓝色实线。在 ℓ<100 时
// 低于 10^-8 μK²，之后上升，在 ℓ=300 时约 10^-7 μK²。
// FSL 15-180（远旁瓣，角度范围 15°–180°）：浅蓝灰色实线。
// 在 ℓ<100 时低于 10^-8 μK²，之后上升，在 ℓ=300 时约 10^
// -7 μK²。 Pol. Ang.（偏振角误差）：浅紫色实线。在 ℓ<100
// 时低于 10^-8 μK²，之后平缓上升至 ℓ=300 时约 10^-7 μK²。
// Bandpass（通带误差）：粉红色实线。在 ℓ<100 时低于 10^
// -8 μK²，之后上升，在 ℓ=300 时约 10^-7 μK²。 Pointing（
// 指向误差）：棕褐色实线。在 ℓ<100 时低于 10^-8 μK²，之
// 后上升，在 ℓ=300 时约 10^-7 μK²。 Sum of Syst.（系统误
// 差总和）：黑色粗实线。由上述所有系统误差叠加而成，在 ℓ
// <50 时主导于 10^-6 μK² 附近，在 ℓ>100 后持续上升，在 ℓ
// =300 时达约 10^-4 μK²，与张量模式曲线相交。 CR（宇宙射
// 线背景）：深灰色实线。在 ℓ<100 时低于 10^-7 μK²，之后
// 上升，在 ℓ=300 时约 10^-7 μK²。 趋势与结论： 该图显示，
// 在低多极矩（ℓ < 50）区域，引力透镜模式（Lensing）远低
// 于系统误差总和（Sum of Syst.），而张量模式（r=0.001）
// 则高于多数单个系统误差源但仍低于总系统误差。随着 ℓ 增
// 大，引力透镜模式迅速增长并在 ℓ > 100 后成为主导信号；
// 张量模式在 ℓ > 100 后也显著增强，并与系统误差总和在 ℓ
// ≈ 200 处相交。这表明在高 ℓ 区域，宇宙学信号（尤其是透
// 镜和张量模式）将超越系统误差，但在中低 ℓ 区域需严格控
// 制各类仪器系统误差才能探测微弱张量信号。各系统误差源中，
// “Gain”、“FSL”系列及“Sum of Syst.”贡献最大，尤其在 ℓ >
// 100 区域。
#figure(placement: top, image("imgs/dl_syst_all_211218.png", width: 100.0%),
  caption: [
    Angular power spectra of the sources of systematic effects and cosmological predictions for the lensing and tensor modes, where $D_ell = ell ( ell + 1 ) C_ell \/ 2 pi$. From the top of the legend downwards, we plot: the lensing $B$ modes; the tensor $B$ modes with $r = 0.001$; the systematic effects of the gain; the HWP instrumental polarization (IP); the HWP parameters of $h$, $beta$, and $zeta$; the far sidelobes (FSL) in the angle ranges of $5^compose$--$10^compose$, $10^compose$--$15^compose$, and $15^compose$--$180^compose$; the polarization
angle (Pol.~Ang.); the bandpass effects; the pointing effects; and the sum of all the systematic effects. The final line is the cosmic-ray (CR) contribution as an additional noise source.
  ]
)
<fig:cl_sys_all>


// [figvision-cn] imgs/likelihood_marg_vs_nomarg_211218.png
// 这是一张二维曲线图，展示了似然函数随张量与标量比r变化
// 的趋势。 子图类型：曲线图。 坐标轴信息： 横坐标（X轴）
// 标记为“Tensor-to-scalar ratio r x 10^3”，表示张量与标
// 量比乘以10的3次方。刻度范围从0.0到4.0，主刻度间隔为0.5，
// 具体刻度值为0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5,
// 4.0。 纵坐标（Y轴）标记为“Likelihood”，表示似然度。刻
// 度范围从0.0到1.0，主刻度间隔为0.2，具体刻度值为0.0,
// 0.2, 0.4, 0.6, 0.8, 1.0。 图例与曲线描述： 图的右上角
// 包含图例，解释了两条曲线的含义及对应的统计结论。 第一
// 条曲线： 颜色与线型：浅蓝色实线。 图例文字：“No
// marginalization”（未边缘化），下方标注数值结果“r < 1.2
// x 10^-3 (68%)”。 物理含义：该曲线代表在未进行系统误差
// 边缘化处理的情况下得到的似然分布。 形态特征：曲线起始
// 于x=0处，y值约为0.82；随后迅速上升，在x值约为0.5处达到
// 峰值，峰值高度接近1.0；之后曲线呈下降趋势，随着x值增加
// 逐渐趋近于0。 第二条曲线： 颜色与线型：深蓝色实线。 图
// 例文字：“Systematics marginalized”（系统误差已边缘化），
// 下方标注数值结果“r < 1.0 x 10^-3 (68%)”。 物理含义：该
// 曲线代表在对系统误差进行边缘化处理（即去噪或修正）后得
// 到的似然分布。 形态特征：曲线起始于x=0处，y值为1.0（最
// 高点）；随后单调递减，没有明显的峰值隆起，随着x值增加
// 逐渐趋近于0。 两条曲线的对比关系： 深蓝色曲线整体位于
// 浅蓝色曲线的左侧。在x大于0的区域，深蓝色曲线始终低于浅
// 蓝色曲线。这表明经过系统误差边缘化处理后，似然分布向更
// 小的r值集中，约束范围变得更窄。 图中传达的趋势与结论：
// 该图表明，对系统误差进行边缘化处理（深蓝色线）相比未处
// 理的情况（浅蓝色线），显著降低了对张量与标量比r的上限
// 估计值。具体而言，在68%的置信水平下，未边缘化的上限为
// 1.2 x 10^-3，而边缘化后的上限收紧至1.0 x 10^-3。这暗示
// 了系统误差的存在会高估张量与标量比的概率，去除该系统误
// 差能得出更严格的限制。
#figure(placement: top, image("imgs/likelihood_marg_vs_nomarg_211218.png", width: 80.0%),
  caption: [
    Likelihoods as a function of the tensor-to-scalar ratio $r$. The light blue line is that obtained from @eq:global-likelihood. The dark blue line is obtained after de-bising using marginalization.
  ]
)
<fig:likelihoods-r>


We consider a possible de-biasing of the systematic effects by marginalization. We introduce an additional term $alpha M_ell$ in @eq:cl-model-in-likelihood: $
  C_ell = r C_ell^("tens") + C_ell^("lens") + N_ell + alpha M_ell ,
$ where $M_ell$ is a template power spectrum accounting for the systematic bias, and $alpha$ is a scaling factor to marginalize. We multiply the likelihood $L ( r )$ in @eq:global-likelihood by a function $exp ( - alpha^2 \/ 2 sigma_alpha^2 )$ and integrate over $alpha$ to define a marginalized likelihood function $tilde(L) ( r )$: $
  tilde(L) ( r ) = integral_(alpha_l)^(alpha_u) d alpha L ( r ) e^(- alpha^2 \/ 2 sigma_alpha^2) .
$ <eq:marginalize-integ> The net effect of this procedure is to subtract the systematic bias and to inflate the width of the likelihood function by an increase of the covariance of the power spectrum. The larger $sigma_alpha$ is, the smaller is the systematic bias, since the larger $sigma_alpha$ gives almost no constraint in the $alpha$ value a priori, and is equivalent to fitting $alpha$. We employ the template spectrum $M_ell$ as the dust spectrum, which is evaluated by the component-separation process. We justify this by the fact that the main
systematic effects are caused by polarization leakage from the higher frequency channels where the dust foreground dominates, and the shape of resultant systematic power spectra for those effects is similar to that of the dust component. For some systematic effects, including the pointing and the gain, the spectra are similar to that of lensing, since those effects are mainly caused by leakage from $E$ modes to $B$ modes, as shown in @fig:cl_sys_all. Those effects, however, give rise to power spectra much lower than the others, having a spectral shape
similar to that of the dust component for the lower multipole region. We conduct the marginalization assuming $sigma_alpha = 10$, $alpha_l = 0$, and $alpha_u = + oo$ in @eq:marginalize-integ, and obtain $delta r = 1.0 times 10^(- 3)$. @fig:likelihoods-r shows the likelihood function obtained $tilde(L) ( r )$ as the dark blue line.


We note that the $delta r$ value is unchanged when we increase $sigma_alpha$ to values larger than 10. This is due to the fact that the large value of $sigma_alpha$ allows $alpha$ to move freely, which completely marginalizes over the systematic biases. A more sophisticated method is to marginalize individual systematic effects using estimated power spectrum shapes. However, this requires more precise models of the instruments and the calibration as well as an estimation of $sigma_alpha$s that corresponds to uncertainties of the systematic biases. These issues remain as future work.


We estimate the expected significance of the tensor-to-scalar ratio assuming $r_("true") = 0.01$ as the true value. We modify the measured $B$-mode power spectrum in @eq:cl-measured-in-likelihood: $
  hat(C)_ell = r_("true") C_ell^("tens") + C_ell^("sys") + C_ell^("lens") + N_ell ,
$ <eq:cl-measured-in-likelihood-r0.01> and calculate the likelihood function in @eq:global-likelihood. We do not apply the marginalization because the total bias $Delta r$ is much smaller than $r_("true")$. We define $ chi^2 ( r ) = - 2 log (frac(L ( r ), L ( tilde(r) ))) , $<eq:chi2-definition-for-r-signif> where $tilde(r)$ is the $r$ value giving the maximum of $L ( r )$, and we check the requirement shown in @tbl:lv1, i.e., we calculate the $chi^2 ( r )$ value for two multipole ranges of $ell_min = 2$ and $ell_max = 10$,
and $ell_min = 11$ and $ell_max = 191$; the former range includes the reionization bump and the latter includes the recombination bump. @fig:dchisq-r shows the $chi^2 ( r )$ distributions for the two cases, as well as the combined one. We find that the hypothesis of $r = 0$ is rejected at a significance more than 5 $sigma$ for both cases, implying that the requirement Lv1.02 in @tbl:lv1 is fulfilled. We note that the asymmetric shape of the $chi^2 ( r )$ distribution for the reionization bump measurement is due to the cosmic variance dependence on $r$.
The constraint on $r$ of the recombination bump measurement is stronger than that of the reionization bump for $r_("true") = 0.01$. However, the reionization bump becomes significant for lower $r_("true")$ values due to the contribution of the lensing effect.


// [figvision-cn] imgs/chi2_0p01_211218.png
// 该图展示了一个二维曲线图，用于呈现张量标量比 $r$ 的卡
// 方分布。横坐标为“Tensor-to-scalar ratio $r \times 10^2
// $”，范围从 0.0 到 3.5，单位为无量纲数值乘以 $10^{-2}$
// （即实际 $r$ 值为横坐标读数除以 100）。纵坐标为 $\chi^
// 2$，范围从 0 到 200，无单位。 图中包含三条曲线和一条水
// 平参考线： 深蓝色虚线（--）代表仅使用复合峰（
// recombination bump）对应的多极矩范围所得到的卡方分布。
// 其最小值出现在横坐标约 1.08 处，对应 $r = 1.08^{+0.15}
// _{-0.14} \times 10^{-2}$。该曲线在 $r=0$ 时 $\chi^2 \
// approx 75$，随 $r$ 增大先下降后上升，在 $r > 2.0$ 后迅
// 速攀升至 200 以上。 深蓝色点划线（-. -）代表仅使用再电
// 离峰（reionization bump）对应的多极矩范围所得到的卡方
// 分布。其最小值同样位于横坐标约 1.07 处，对应 $r = 1.07
// ^{+0.76}_{-0.25} \times 10^{-2}$。该曲线在 $r=0$ 时 $\
// chi^2 \approx 50$，整体趋势与第一条相似但更平缓，尤其
// 在右侧增长较慢，在 $r=3.5$ 时 $\chi^2 \approx 10$。 浅
// 蓝色实线（—）代表将上述两个多极矩范围合并后的综合卡方
// 分布。其最小值位于横坐标约 1.08 处，对应 $r = 1.08^{+
// 0.14}_{-0.13} \times 10^{-2}$。该曲线形状介于前两者之
// 间，在左侧略低于深蓝色虚线，在右侧略高于深蓝色点划线，
// 整体拟合优度最佳。 此外，图中有一条黑色水平实线，位于
// $\chi^2 = 25$ 处，标注为“indicates 5$\sigma$
// significance”。该线与三条曲线相交于不同位置：与深蓝色
// 虚线交于约 $r=0.5$ 和 $r=1.8$；与深蓝色点划线交于约 $r
// =0.3$ 和 $r=2.2$；与浅蓝色实线交于约 $r=0.45$ 和 $r=
// 1.9$。这些交点定义了各模型下 $5\sigma$ 置信区间边界。
// 所有曲线均呈 U 形或抛物线状，表明存在一个最优 $r$ 值使
// 卡方最小，偏离该值则拟合变差。结合误差棒信息（由上下不
// 对称误差表示），可推断出各模型对 $r$ 的约束精度：复合
// 峰模型最精确（误差最小），再电离峰模型次之（误差较大且
// 不对称），组合模型精度介于两者之间并接近复合峰结果。
#figure(placement: top, image("imgs/chi2_0p01_211218.png", width: 80.0%),
  caption: [
    $chi^2$ distribution when $r_("true") = 0.01$. The dark blue dashed line is obtained using the multipole range of $11 lt.eq ell lt.eq 191$ containing the recombination bump. The dark blue dot-dashed line is obtained using the multipole range of $2 lt.eq ell lt.eq 10$, containing the reionization bump. The light blue curve is the combined $chi^2$. The horizontal line at $chi^2 = 25$ indicates 5 $sigma$ significance.
  ]
)
<fig:dchisq-r>


== Enhanced Science Case
<ss:extrasuccess>
The criterion for full success of the mission has been defined conservatively and does not rely on any new data sets external to #emph[LiteBIRD]. However, we can reduce $delta r$ further using external data sets, which contribute to the "enhanced science case."#footnote[In JAXA, this is also referred to as "extra success."]


In this section, we focus on reducing the statistical part of the total uncertainty, $sigma ( r = 0 )$, which includes the cosmic variance of the gravitational lensing signal and the noise after the component separation. One way to reduce $sigma ( r = 0 )$ is to "delens" using external data sets @smith-etal:2012@simard-hanson-holder:2015@sherwin-marcel:2015@namikawa-nagata:2015@larsen-etal:2016. Delensing removes the lensing $B$-modes by subtraction at the map level, thus reducing the lensing $B$-mode cosmic variance contribution described above, rather
than simply characterizing its power spectrum~@kesden-cooray-kamionkowski:2002@knox-yong-seon:2002. Successful delensing using the internal CMB data requires a higher angular resolution than that of ~@seljak-hirata:2003@smith-etal:2009, because a low-noise lensing reconstruction requires the imaging of a large number of small-scale modes.


There are several promising ways to delens #emph[LiteBIRD] with external data sets and thus contribute to the enhanced science case. The most conservative option would be to delens using currently available data sets; for instance, using the multi-tracer template obtained by the #emph[Planck] cib map and the #emph[Planck] lensing potential map reconstructed with the help of #emph[WISE]~@yu-hill-sherwin:2017. See @fig:rdelensed for the expected improvements on the constraint in $r$ obtained by applying a 43 % reduction of the lensing $B$-mode power
spectrum as obtained for a large fraction of the sky~@yu-hill-sherwin:2017. The resulting total uncertainty, including systematic effects, is $delta r tilde.eq 0.9 times 10^(- 3)$, which enables us to distinguish no primordial gravitational waves from the Starobinsky model~#cite(<starobinsky:1980>) with a significance greater than $5 thin sigma$. #emph[LiteBIRD] can also help reduce the Galactic dust contamination of the CIB on large angular scales, which may further improve the constraint on $r$. Further reduction of the lensing $B$-mode power spectrum
can be achieved with future lensing measurements from ground-based CMB surveys, such as the CMB-S4 experiment~#cite(<Abazajian:2016yjj>) and its precursors, but only in the sky region that overlaps with #emph[LiteBIRD].


// [figvision-cn] imgs/likelihood_delens_vs_nodelens_211218.png
// 该图像为一个二维曲线图，展示了张量-标量比参数（
// tensor-to-scalar ratio）的边缘后验分布。 子图类型： 这
// 是一个包含两条曲线的二维线图。 坐标轴定义： 横坐标轴标
// 记为“Tensor-to-scalar ratio r x 10^3”，表示张量-标量比
// r乘以10的3次方。刻度范围从0.0到4.0，主刻度间隔为0.5（
// 即0.0, 0.5, 1.0, ..., 4.0）。 纵坐标轴标记为“
// Likelihood”，表示似然度或概率密度归一化值。刻度范围从
// 0.0到1.0，主刻度间隔为0.2（即0.0, 0.2, ..., 1.0）。 曲
// 线描述与物理含义： 图中包含两条平滑下降的实线，均起始
// 于左上角坐标点(0.0, 1.0)，随着横坐标数值增加而向右下方
// 延伸，在横坐标达到3.0左右时趋近于0.0。 第一条曲线为深
// 蓝色实线，代表未进行去透镜化（No delensing）处理的情况。
// 第二条曲线为青色（浅蓝色）实线，代表进行了43%去透镜化
// （43% delensing）处理的情况。 趋势对比： 两条曲线在横
// 坐标0.0至约1.0的区间内几乎重合。当横坐标大于1.0时，青
// 色曲线位于深蓝色曲线下方，下降速度更快，表明经过43%去
// 透镜化处理后，大数值的张量-标量比的似然度更低，约束更
// 紧。 图例与标注文字： 图的右上角区域包含图例，分为上下
// 两组文本和对应的颜色样本： 上方组：显示一段深蓝色短线，
// 右侧文字说明为“No delensing”（无去透镜化），其下方标注
// 了统计结果“r < 1.0 x 10^-3 (68%)”。这表示在无去透镜化
// 情况下，张量-标量比r小于1.0乘以10的负3次方的置信度为68%。
// 下方组：显示一段青色短线，右侧文字说明为“43% delensing
// ”（43%去透镜化），其下方标注了统计结果“r < 0.9 x 10^-3
// (68%)”。这表示在经过43%去透镜化处理后，张量-标量比r小
// 于0.9乘以10的负3次方的置信度为68%。
#figure(placement: top, image("imgs/likelihood_delens_vs_nodelens_211218.png", width: 80.0%),
  caption: [
    Marginalized posterior distributions of the tensor-to-scalar ratio parameter $r$ with (blue) and without (black) a delensing factor, which could be obtained by a multi-tracer template obtained by #emph[Planck] CIB and lensing maps reconstructed with the help of #emph[WISE]~@yu-hill-sherwin:2017. The instrumental systematic uncertainty budget is not included here.
  ]
)
<fig:rdelensed>


The other way to reduce $sigma ( r = 0 )$ is to use external data sets in frequency bands below the lower edge of 's lowest frequency band (34 GHz). Better modeling of the polarized synchrotron emission helps to reduce the foreground residuals. External low-frequency ground-based data sets such as QUIJOTE~@genova-santos-etal:2015@genova-santos-etal:2017, C-BASS~@irfan-etal:2015, and S-PASS~@krachmalnicoff-etal:2018 at frequency bands outside those of ~($nu < 34$ GHz) would be useful for potentially improving foreground cleaning, and hence reducing $sigma ( r = 0 )$.


== Summary of the Statistical and Systematic Uncertainties in the Tensor-to-scalar Ratio Measurement 
<ss:forcast-summary>
Let us now summarize the results obtained in @s:cosmological_forecasts. Based on the sky observation strategy with the detector sensitivity shown in @ss:forecasts_imo, we conducted studies on the foreground component separation in @ss:forecasts_fg_cleaning, and the systematic uncertainties in @ss:forecasts_syst.


As explained in @sec:component_separation, we estimate the statistical foreground residual bias $r_("FG")$ and its error $sigma ( r = 0 )$ is obtained as $
  r_("FG") = ( 3.3 plus.minus 6.2 ) times 10^(- 4) ,
$ where the definition of $sigma ( r = 0 )$ is given in @eq:sigma-r-definition, which is equivalent to the total statistical error $sigma_("stat")$ in the science requirement Lv2.01 in @ss:overview_mission. The obtained error satisfies the requirement.


In @ss:forecasts_syst, we give details of the studies on the systematic effects which are summarized in @tbl:syst. The power spectra of the systematic effects are presented in @fig:cl_sys_all. The bias on $r$ is defined in @eq:r-bias-definition. The total systematic bias is estimated to be $
  Delta r_("syst") = 1.7 times 10^(- 4) ,
$ which is equivalent to the $sigma_("syst")$ in the science requirement Lv2.02 in @ss:overview_mission.


In @ss:forecasts_delta_r, we estimate the total error $delta r$ defined in @eq:r-total-error-definition by accounting for the statistical uncertainties with the component separation and the biases produced by the uncertainties of the foregrounds and instrumental systematic effects with the sky observation fraction of $f_("sky") = 49.5$%. We apply the marginalization defined in @eq:marginalize-integ to conduct a de-biasing procedure, and obtain the total error $ delta r = 1.0 times 10^(- 3) , $
which satisfies the requirement of Lv1.01.


We also estimate the expected significance of $r$ with the assumption that the true value of $r$ is 0.01. We define $chi^2 ( r )$ in @eq:chi2-definition-for-r-signif, and compute it for two cases: the multipole range of $ell_min = 2$ and $ell_max = 10$ covering the reionization bump; and the range of $ell_min = 11$ and $ell_max = 191$ covering the recombination bump. We obtain @fig:dchisq-r and find that both cases reject the hypothesis of $r = 0$ with a significance more than $5 sigma$, fulfilling the requirement of Lv1.02.


We point out that we could further reduce $delta r$ using external data sets as described in the enhanced science case shown in @ss:extrasuccess. We examine one example by applying delensing, and obtain $ delta r = 0.9 times 10^(- 3) , $ with an assumption of 43% reduction of the lensing effect.


= Scientific Outcomes of #emph[LiteBIRD] Beyond Primordial Gravitational Waves
<s:scientific_outcomes>
The primary science goal of the #emph[LiteBIRD] mission is to discover and characterize the signature of the primordial gravitational waves from cosmic inflation in the $B$-mode polarization of the CMB. We have described this goal in detail in @s:cmb_polarization and presented our forecast in @ss:forecasts_delta_r.


In addition to the primary goal, the full sky maps in 15 microwave bands will offer rich new data sets, which will enable exciting breakthroughs in a variety of science areas. We now describe the expected outcomes of the #emph[LiteBIRD] mission for some representative science topics including: the reionization of the Universe (@ss:tau); cosmic birefringence (@ss:eb); the hot gas in the Universe probed using the sz effect (@ss:sz); spatially varying deviations from a perfect Planckian blackbody CMB spectrum (@ss:mu); primordial magnetic fields (@ss:pmf);
tests using polarization of the so-called "anomalies" in the temperature data (@ss:anomaly); and Galactic astrophysics (@ss:galaxy).


== Optical Depth, Reionization of the Universe and Neutrino Masses
<ss:tau>


The hydrogen atoms in the intergalactic medium are fully ionized in the recent Universe ($z lt.tilde 6$). We have multiple lines of evidence for this from the lack of saturated hydrogen absorption lines in the spectra of quasars and afterglows of $gamma$-ray bursts~@gunn-peterson:1965@fan-etal:2006@bolton-etal:2011@chornock-etal:2013@mcgreer-mesinger-dodorico:2015. Given that the Universe became almost completely neutral after the epoch of hydrogen recombination (at $z tilde.eq 1100$), the Universe must have "reionized" during some intermediate epoch.
However, we still have no clear description of the history of this eor. In the current picture, early galaxies reionized hydrogen atoms progressively throughout the entire history between $z tilde.eq 12$ and $z tilde.eq 6$, while quasars took over to reionize helium atoms from $z tilde.eq 6$ to 2~@barkana-loeb:2001.


There are several ways to observe the EoR: the number counts of star-forming galaxies and quasars at $z > 6$, which were presumably producing ionizing photons~@robertson-etal:2015; the shape of the luminosity functions of high-redshift galaxies in the UV bands~#cite(<Ishigaki_2018>); redshifted 21-cm lines from hydrogen atoms before the completion of reionization~@furlanetto-oh-briggs:2006; Doppler shifts of CMB photons by the bulk motion of ionized gas~@park-etal:2013 (called the kinetic Sunyaev-Zeldovich effect~@sunyaev-zeldovich:1980); and finally,
the polarization of the CMB produced by electrons scattering quadrupole temperature anisotropies in a reionized Universe~@PlanckIntXLVII, which will be probed by #emph[LiteBIRD].


// [figvision-cn] imgs/cl_lowlee.png
// 子图a是一张双对数坐标曲线图，展示宇宙微波背景辐射的B模
// 式功率谱。横轴为“Multipole ℓ”，表示多极矩，范围从10^0
// 到10^3，刻度为对数分布；纵轴为“ℓ(ℓ+1)C_ℓ^{EE}/2π [μK²]
// ”，表示归一化的E模式功率谱乘以ℓ(ℓ+1)/2π，单位为微开尔
// 文平方（μK²），范围从10⁻³到10¹，同样为对数刻度。 图中
// 包含三条主要数据表现： 一条黑色实线代表ΛCDM模型在光学
// 深度τ=0.000时的理论预测曲线，该曲线从ℓ≈2处开始上升，在
// ℓ≈10附近达到局部极小值约10⁻³ μK²，随后持续上升，在ℓ≈
// 100时穿过10⁰ μK²，并在ℓ>200后出现振荡结构，峰值可达10¹
// μK²以上。 一条黑色虚线代表同一ΛCDM模型但光学深度τ=
// 0.055的理论预测曲线，其整体形状与实线相似，但在低ℓ区域
// （ℓ<50）数值更高，例如在ℓ=10处约为10⁻² μK²，高于实线的
// 对应值。 一组黑色实心圆点带垂直误差棒的数据点代表
// Planck卫星观测结果，这些点分布在ℓ从约5到约2000的范围内，
// 误差棒长度随ℓ增大而减小，部分点在ℓ<50时位于两条理论曲
// 线之间或略低于虚线，在ℓ>50后紧贴实线波动。 此外，图中
// 有一个浅青色填充带状区域，覆盖ℓ从约2到约200的范围，宽
// 度随ℓ变化，在ℓ≈10处最窄，向上延伸至约0.05 μK²，向下至
// 约0.005 μK²。此区域代表LiteBIRD任务预期在各多极矩上的
// 宇宙方差极限不确定性（假设噪声水平N_ℓ=0）。该带状区域
// 完全覆盖Planck数据点的误差棒，并显著小于Planck数据本身
// 的离散程度，表明LiteBIRD将带来精度提升。 图例位于左上
// 角，明确标注：“— ΛCDM (τ = 0.000)”、“--- ΛCDM (τ =
// 0.055)”、“● Planck”。所有文字均为黑色无衬线字体，清晰
// 可读。 该子图传达的核心结论是：当前Planck数据在低ℓ区域
// 受限于较大误差，无法区分不同τ值的理论模型；而未来
// LiteBIRD任务的预期精度（由青色带表示）将在整个ℓ=2–200
// 区间内实现比Planck更小的不确定性，从而能够精确测量再电
// 离光学深度τ，并对早期宇宙物理提供更强约束。
#figure(placement: top, image("imgs/cl_lowlee.png", width: 80.0%),
  caption: [
    #emph[Planck]~$E$-mode power spectrum~@PlanckIntLVII with optical depths of $tau = 0.055$ and $tau = 0.000$ for constant $exp ( - 2 tau ) A_s$. The cosmological parameters are taken from the best-fitting $Lambda$CDM #emph[Planck]~2018 model. The green band shows the expected #emph[LiteBIRD] uncertainties for each multipole in the range $ell = 2$--200 (the cosmic-variance-limited uncertainties with $f_("sky") = 0.7$), demonstrating significant improvements over the #emph[Planck]~data.
  ]
)
<fig:lowlee>


Thomson scattering between the CMB photons and free electrons generates linear polarization from the quadrupole moment of the CMB radiation field at the scattering epoch. This occurs at recombination as well as during the EoR. Re-scattering of the CMB photons at reionization generates an additional polarization anisotropy at large angular scales, because the horizon size at this epoch subtends a much larger angular size ~#cite(<zaldarriaga:1997>). The CMB is affected by the total column density of free electrons along each line of sight, parameterized by
its Thomson-scattering optical depth, $tau$. The wavenumber of the fluctuations contributing to quadrupole temperature anisotropy, as seen by an electron at a redshift $z$, is given by $k tilde.eq 3 \/ \[ r_L - r ( z ) \]$ where $r_L = 14$ Gpc is the comoving distance from Earth to our last-scattering surface, and $r ( z )$ is the comoving distance to redshift $z$. For example, a redshift of $z = 7.7$ gives $r ( 7.7 ) = 9.1$ Gpc. We observe this wavenumber at a multipole of $ell lt.tilde k thin r ( 7.7 ) tilde.eq 6$, which corresponds to the so-called
"reionization bump" in the polarization power spectra. The effect on the $E$ modes is shown in @fig:lowlee.


// [figvision-cn] imgs/reio_v2.png
// 这是一张二维曲线图，展示了根据星暴星系数量统计的不同模
// 型所预测的汤姆逊光学深度（Thomson Optical Depth, 符号
// 为 τ）随最大红移（Redshift z）变化的函数关系。 坐标轴
// 定义如下： 横轴表示“Redshift z”（红移），数值范围从0到
// 20，主刻度标记在0、5、10、15和20处。 纵轴表示“Thomson
// Optical Depth τ”，数值范围从0.00到0.10以上，主刻度标记
// 在0.00、0.02、0.04、0.06、0.08和0.10处。 图中包含四条
// 主要的数据曲线及其对应的置信区间带，均从原点(0, 0)出发，
// 随红移增加而上升，但在高红移区域表现出不同的渐近行为：
// 蓝色曲线与色带：代表“Robertson et al. 2013”模型的最佳
// 估计值。该曲线由一条实心蓝线表示，周围包裹着浅蓝色的半
// 透明带状区域，表示其不确定性范围。随着红移z的增加，该
// 曲线在z约等于7之后开始趋于平缓，最终稳定在τ约为0.065至
// 0.07之间。标签文字“Robertson et al. 2013”位于曲线右上
// 方的蓝色区域内。 红色曲线与色带：代表更新的2015年最大
// 似然（ML）约束结果。该曲线由一条实心红线表示，周围包裹
// 着红色的半透明带状区域，标签注明为“ML + 68%
// Credibility Interval”。其走势与蓝色曲线相似，但在高红
// 移处略高于蓝色曲线，最终稳定在τ约为0.06左右。 橙色曲线
// 与色带：代表一个被强制拟合以重现WMAP 9年观测数据的模型。
// 该曲线由一条实心橙线表示，周围包裹着橙色的半透明带状区
// 域，标签为“Forced Match to WMAP τ”。此曲线在高红移区域
// 持续上升，没有像前两者那样明显饱和，在z=20时达到τ约等
// 于0.08以上。 浅蓝色底部区域：代表一个截断模型，标签显
// 示为“ρ_SFR Truncated at z>8”。这表现为一条较宽的浅蓝色
// 带状区域，其上限在低红移时与其他曲线重合，但在z大于8后
// 不再增长，保持水平，稳定在τ约为0.05的水平。 背景中还绘
// 制了四个水平的阴影区域或条带，代表不同实验对光学深度的
// 观测限制： 最上方的浅灰色区域：标记为“WMAP 9-year”，位
// 于τ约0.08至0.10之间，上下边界由点状虚线标示。左侧有一
// 个垂直的双向箭头指示该范围。 中间的深灰色区域：标记为“
// Planck 2015”，位于τ约0.055至0.078之间，上下边界由长划
// 线标示。左侧有一个垂直双向箭头。 下方的绿色实线边框区
// 域：标记为“Planck 2018”，位于τ约0.05至0.062之间。左侧
// 有一个垂直双向箭头。 最下方的绿色虚线边框区域：标记为“
// LiteBIRD”，位于τ约0.045至0.055之间。左侧有一个垂直双向
// 箭头。 总体趋势表明，所有模型在低红移（z < 7）时对光学
// 深度的预测基本一致，呈线性增长；而在高红移区域，不同模
// 型因假设的恒星形成率演化不同而产生显著分歧。观测限制条
// 带则提供了当前及未来实验对这些理论模型的检验标准。
#figure(placement: top, image("imgs/reio_v2.png", width: 80.0%),
  caption: [
    Optical depths predicted from various models of the number counts of star-forming galaxies, as a function of the maximum redshift $z$. This figure is adapted from Ref.~@robertson-etal:2015, showing $tau$ inferences from different star-formation rates: the best estimates from 2013 (blue); the updated 2015 ml constraints (red); a model forced to reproduce the 9-year #emph[WMAP]~$tau$ constraints (orange); and a model with a truncated star-formation rate (light blue). The green band shows the expected  68 % and 95 % cl constraints on $tau = 0.054$. The
other bands show the #emph[WMAP] and #emph[Planck] constraints.
  ]
)
<fig:sfr>


The amplitude of the reionization bump is proportional to $tau^2 A_s$ where $A_s$ is the amplitude of the scalar curvature power spectrum. Because scattering washes out small-scale power, which is proportional to $exp ( - 2 tau ) A_s$, increasing $tau$ (while fixing $A_s$) enhances the reionization bump and suppresses the small-scale power. However, since the small-scale power has been measured precisely, the value of $exp ( - 2 tau ) A_s$ is fixed; thus, for a given measured value of the high-$ell$ power spectrum, the amplitude of the reionization bump
scales as $tau^2 A_s prop tau^2 exp ( 2 tau )$. We can use this to determine the value of $tau$, which in turn provides an integrated constraint on the reionization history of the Universe because $tau = sigma_T N_e$, where the column density of electrons is given by $N_e = c integral d t thin n_e$ integrated from today to the beginning of reionization. This number can be compared with the expected number of electrons from ionization by star-forming galaxies and quasars (including X-ray emission from accretion disks around black holes); see @fig:sfr.


// [figvision-cn] imgs/tau_values.png
// 该图为误差条图，展示了不同宇宙微波背景辐射（CMB）功率
// 谱测量结果对再电离光学深度参数τ的约束。横坐标为“
// Reionization Optical Depth (τ)”，无单位，数值范围从
// 0.04至0.14，主刻度间隔为0.02。纵坐标未标注名称，仅用于
// 垂直排列十个独立的测量数据点，每个点对应一个实验或数据
// 集，从上至下依次列出。 图中包含十条水平误差条，每条由
// 中心实心圆点和穿过该点的水平线段组成，代表各次测量的最
// 佳拟合值及其不确定度范围。各误差条颜色与对应标签如下：
// 第一条（最上方）：青色实线，中心点位于τ≈0.085，误差范
// 围约从0.075至0.095，标签为“WMAP (2012)”； 第二条：黄绿
// 色实线，中心点位于τ≈0.075，误差范围约从0.065至0.085，
// 标签为“Planck (2013)”； 第三条：灰色实线，中心点位于τ≈
// 0.068，误差范围约从0.05至0.085，标签为“Planck-LFI (
// 2015)”； 第四条：粉红色实线，中心点位于τ≈0.078，误差范
// 围约从0.06至0.095，标签为“Planck (2015)”； 第五条：棕
// 色实线，中心点位于τ≈0.062，误差范围约从0.05至0.075，标
// 签为“Planck (2016)”； 第六条：紫色实线，中心点位于τ≈
// 0.07，误差范围约从0.05至0.09，标签为“WMAP+LFI (2018)”；
// 第七条：红色实线，中心点位于τ≈0.055，误差范围约从0.045
// 至0.065，标签为“Planck (2018)”； 第八条：绿色实线，中
// 心点位于τ≈0.058，误差范围约从0.05至0.065，标签为“
// Planck-HFI (2019)”； 第九条：橙色实线，中心点位于τ≈
// 0.068，误差范围约从0.055至0.08，标签为“WMAP+LFI (2020)
// ”； 第十条（最下方）：蓝色实线，中心点位于τ≈0.055，误
// 差范围约从0.045至0.065，标签为“Planck (2020)”。 图中左
// 侧有一条贯穿所有误差条高度的浅灰色垂直带状区域，其左右
// 边界分别位于τ≈0.052和τ≈0.058之间，内部含一条黑色虚线，
// 位于τ≈0.055处。该灰色带代表LiteBIRD任务对τ参数的预期不
// 确定性预报范围。 整体趋势显示，随着观测技术进步与数据
// 分析方法改进，τ的最佳拟合值逐渐向更低值收敛，且误差范
// 围显著缩小。早期如WMAP (2012) 和 Planck (2013) 的结果
// 集中在τ>0.07，而近年结果如Planck (2018)、Planck-HFI (
// 2019) 和 Planck (2020) 均接近τ≈0.055–0.058，且误差区间
// 更窄，表明测量精度提升。灰色预报带覆盖了最新几个高精度
// 测量结果，预示未来LiteBIRD任务有望进一步精确约束该参数。
#figure(placement: top, image("imgs/tau_values.png", width: 80.0%),
  caption: [
    Measurements of $tau$ based on the CMB power spectra: #emph[WMAP]~(2012)~@hinshaw-etal:2013; #emph[Planck]~(2013)~@Planck2013XV; #emph[Planck]~(2015)~@Planck2015XIII; #emph[Planck]~(2016)~@PlanckIntXLVII; #emph[WMAP]+LFI (2018)~#cite(<Weiland:2018kon>); #emph[Planck]~(2018)~@Planck2018VI; #emph[Planck]-HFI (2019)~@Pagano2020; #emph[WMAP]+LFI (2020)~#cite(<Natale:2020owc>); and #emph[Planck]~(2020)~#cite(<PlanckIntLVII>). The gray band shows the #emph[LiteBIRD] uncertainty forecast for $tau$.
  ]
)
<fig:taus>


Accurate measurements of $tau$ through the CMB are challenging because of the foreground contamination and instrumental systematic uncertainties~#cite(<Lattanzi:2016dzq>). These are most problematic on large angular scales, where the bulk of the information on $tau$ is constrained. This difficulty is illustrated by the evolution of the constraint over time from the first #emph[WMAP]~release in 2003 ($tau = 0.17 plus.minus 0.06$~@Spergel2003) using the $T E$ cross-correlation, up to the latest #emph[Planck]~collaboration results
($tau = 0.051 plus.minus 0.006$~@PlanckIntLVII, obtained from the "NPIPE" reprocessing of the #emph[Planck]~legacy data) using polarized $E E$ measurements (see @fig:taus for a complication of $tau$ estimates, where time increases from top to bottom).


LiteBIRD will provide a cosmic-variance-limited determination of $tau$, i.e., the sampling variance in the limit of zero instrumental noise. This is the smallest possible error bar, limited only by the fraction of sky ($f_("sky")$) available for the cosmological analysis. While ground-based experiments will provide an independent measurement of $tau$ from gravitational lensing, with an uncertainty similar to the current #emph[Planck]~estimates over the coming years, a new, improved large-scale measurement will come from #emph[LiteBIRD]. Assuming a
fiducial value of $tau = 0.054$ and an available sky fraction of $f_("sky") = 0.7$, the expected $68 thin %$ C.L. uncertainty on $tau$ is $0.002$~#cite(<DiValentino:2016foa>), which is 3 times better than today's tightest bounds from #emph[Planck]~@Pagano2020 @PlanckIntLVII ~#cite(<Pagano2020>) #cite(<PlanckIntLVII>) #cite(<DeBelsunce:2021xcp>). Not only is this a significant improvement over current measurements, but it will also be the definitive and most accurate measurement of $tau$ from the CMB.


Beyond a cosmic-variance-limited measurement of $tau$, the $E$-mode measurements carried out by #emph[LiteBIRD] will constrain the precise reionization history~@zaldarriaga-etal:2008. In particular, the "dip" in the $E$-mode power spectrum at $ell tilde.eq 10$--20 in @fig:lowlee can distinguish between instantaneous reionization at a redshift of $z_("reion")$ and more physical models of reionization~#cite(<Barkana:2006ep>) #cite(<Furlanetto:2004nt>), including those with a reionization history extending to longer durations and earlier onsets at
$z med z_("reion")$. Although the #emph[Planck] measurements have reconciled the value of $tau$ from CMB polarization on large angular scales with the reionization process fueled by star-forming galaxies @Planck2015XIII@robertson-etal:2015@PlanckIntXLVII ~#cite(<Planck2015XIII>) #cite(<robertson-etal:2015>) #cite(<PlanckIntXLVII>) #cite(<Hazra:2019wdn>), there is still considerable uncertainty on its history~#cite(<Miranda:2016trf>) #cite(<obied-etal:2018>) and degeneracies with other cosmological parameters~#cite(<Paoletti:2020ndu>). The #emph[LiteBIRD]
data will provide a significant improvement in constraints on the reionization history models, breaking the remaining degeneracies~#cite(<Hazra:2018eib>) #cite(<Watts:2019uvq>) and taking the joint CMB constraints with complementary astrophysical probes~#cite(<Hazra:2019wdn>) to a higher level of precision. For example, in the case of homogeneous reionization models, #emph[LiteBIRD] will reduce the uncertainty in the duration of reionization, $Delta z_("reion")$, for an asymmetric reionization history by approximately 35 %~#cite(<Hazra:2018eib>) with
respect to the most recent #emph[Planck] measurements~#cite(<Paoletti:2020ndu>). The #emph[LiteBIRD] data will also allow for testing the inhomogeneity of the reionization process and will contribute to characterizing the patchiness of reionization~#cite(<Roy:2018gcv>)


// [figvision-cn] imgs/mnu_tau_lb_ptep.png
// 这是一张二维边际化等高线图，展示了未来宇宙学观测组合对
// 再电离光学深度（τ）与中微子质量总和（Σmν）这两个参数的
// 联合约束能力。 横坐标轴标记为“Σmν [meV]”，代表中微子质
// 量总和，单位为毫电子伏特（meV），刻度范围从0到140，主
// 刻度间隔为20。纵坐标轴标记为“Optical depth to
// reionization, τ”，代表再电离光学深度，无量纲，刻度范围
// 从0.040到0.070，主刻度间隔为0.005。 图中包含四组置信区
// 间，均对应68%置信水平（C.L.），以嵌套或重叠的椭圆形式
// 呈现，所有椭圆的中心均位于一个黑色叉号（×）处，该叉号
// 指示基准值：Σmν = 60 meV，τ = 0.054。 第一组等高线为深
// 灰色虚线椭圆，代表“Planck+CMB-S4+DESI”数据组合的约束区
// 域。该椭圆呈倾斜状，长轴从左下指向右上，表明τ与Σmν之间
// 存在正相关简并关系。其横向跨度约从Σmν=30 meV至95 meV，
// 纵向跨度约从τ=0.043至0.065。 第二组等高线为橙色虚线椭
// 圆，代表“Planck+CMB-S4+LSST”数据组合的约束区域。该椭圆
// 比第一组更小、更紧凑，横向跨度约从Σmν=35 meV至85 meV，
// 纵向跨度约从τ=0.046至0.062，显示加入LSST数据后约束能力
// 提升。 第三组为深灰色实心填充椭圆，标注为“+ LiteBIRD”，
// 表示在“Planck+CMB-S4+DESI”基础上增加LiteBIRD卫星数据后
// 的约束区域。该椭圆显著缩小，横向跨度约从Σmν=45 meV至75
// meV，纵向跨度约从τ=0.051至0.057，表明LiteBIRD大幅降低
// 参数不确定性。 第四组为橙色实心填充椭圆，同样标注为“+
// LiteBIRD”，但基于“Planck+CMB-S4+LSST”基础。该椭圆是四
// 个中最小的，横向跨度约从Σmν=50 meV至70 meV，纵向跨度约
// 从τ=0.052至0.056，显示结合LSST与LiteBIRD可获得最优约束。
// 图右下角设有图例，用不同线型和颜色区分四种情况： 深灰
// 色虚线框：Planck+CMB-S4+DESI 橙色虚线框：Planck+CMB-S4
// +LSST 深灰色实心块：+ LiteBIRD（对应前者） 橙色实心块：
// + LiteBIRD（对应后者） 图中另有一条从左侧延伸至中心叉
// 号的橙色水平箭头，箭头上方标注“5σ”，表示若当前测量值偏
// 离基准值达5倍标准差，则对应于该箭头长度所覆盖的Σmν范围
// （约从Σmν≈10 meV至110 meV），用于示意当前观测精度距离
// 达到宇宙方差极限所需精度的差距。 整体趋势表明：随着更
// 多高精度CMB偏振数据（如LiteBIRD）和大尺度结构巡天数据
// （如DESI、LSST）的加入，τ与Σmν的联合约束椭圆面积显著减
// 小，参数简并性被有效打破，尤其在中微子质量总和方向上约
// 束能力提升明显。最终目标是在未来实现接近宇宙方差极限的
// τ测量精度。
#figure(placement: top, image("imgs/mnu_tau_lb_ptep.png", width: 80.0%),
  caption: [
    Two-dimensional marginalized contour levels at 68 % C.L. for $tau$ and the sum of the neutrino masses as measured by future combinations of CMB and large-scale structure data, for example including bao from DESI or galaxy lensing and clustering from LSST, adapted from @Calabrese2017. The contours are centered on the fiducial values $tau = 0.054$ and $sum m_nu = 60$ meV, as indicated by the cross. A cosmic-variance-limited measurement of $tau$ is reached with ~(i.e., $sigma ( tau ) = 0.002$). This $tau$ limit will enable a better neutrino mass
measurement, reaching a $5 thin sigma$ detection when combined with DESI or LSST.
  ]
)
<fig:tau_mnu>


Beyond reionization, $tau$ impacts the important cosmological and particle physics science topic of determining the sum of the neutrino masses, $sum m_nu$~#cite(<DiValentino:2015sam>) #cite(<allison-etal:2015>) #cite(<Giusarma:2016phn>) #cite(<Archidiacono:2016lnv>) #cite(<Abazajian:2016yjj>) #cite(<boyle-komatsu:2018>). Such a measurement would allow us to establish the absolute scale of the neutrino masses, and also possibly to distinguish the inverted neutrino mass ordering (i.e., two heavy, one light) from the normal ordering (one heavy, two
light)~#cite(<Jimenez:2010ev>) #cite(<Hall:2012kg>) #cite(<Hannestad:2016fog>) #cite(<Gerbino:2016ehw>) #cite(<Gerbino:2017ubx>). Massive neutrinos slow down structure formation~@lesgourgues-pastor:2006 and consequently, we can measure the neutrino mass by comparing the amplitude of fluctuations in the low-redshift Universe with that at the last-scattering surface (i.e., $A_s$). However, we cannot determine $A_s$ unless we know $tau$. This means that cosmological searches for the neutrino masses can be limited by the inability to measure $tau$ with
sufficient precision. For example, the exact knowledge of $tau$ would reduce the uncertainty in the neutrino mass estimates from galaxy redshift surveys by more than a factor of 2 relative to that with #emph[Planck]'s $tau$ measurement (see the appendix of Ref.~@boyle-komatsu:2018). Thus, an improved $tau$ determination from #emph[LiteBIRD] will play a major role in measuring the neutrino mass.


When combined with measurements of the amplitude of density fluctuations at low redshifts, such as those coming from the CMB lensing data and galaxy survey observations of large-scale structure (see below), and possibly with constraints on the expansion history, a cosmic-variance-limited measurement of $tau$ from #emph[LiteBIRD] will enable a statistically significant detection of the neutrino mass, even for the minimum value $sum m_nu tilde.eq 60 thin "meV"$ allowed by flavor-oscillation experiments.


The information on the amplitude of fluctuations in the low-redshift Universe might be provided by the CMB lensing data from observations of the small-scale anisotropies (e.g., those of the future Simons Array~@westbrook-etal:2018, SO~#cite(<Ade:2018sbj>) #cite(<Abitbol:2019nhf>), and CMB-S4~#cite(<Abazajian:2019tiv>) #cite(<Abazajian:2019eic>) experiments), and/or by data from large-scale structure surveys tracing the matter distribution (e.g., galaxy surveys with the DESI~#cite(<desi:2016>) and the LSST~#cite(<lsst:2009>)). Distance measurements, such
as those coming from bao data, will further improve the constraints by adding information about the cosmic expansion history~#cite(<Gerbino:2017ubx>). To give a specific example, combining a cosmic-variance-limited measurement of $tau$ ($sigma ( tau ) = 0.002$) with observations of the small-scale CMB anisotropies from CMB-S4 and either BAO data from the DESI galaxy survey~#cite(<desi:2016>) or galaxy lensing/clustering data from the LSST survey of the Vera Rubin Observatory~#cite(<lsst:2009>), will in both cases yield
$sigma ( sum m_nu ) = 12 thin "meV"$~#cite(<Calabrese2017>). This will result in a detection of the neutrino mass at the $5 thin sigma$ level, for the minimum value of $60 thin "meV"$, or larger. @fig:tau_mnu shows the constraining power of these data combinations in the $( tau , thin sum m_nu )$ plane, highlighting that a cosmic-variance-limited measurement of $tau$ from #emph[LiteBIRD] will be necessary for reaching a statistically significant detection of the neutrino mass from cosmological data.


To complete the picture on the neutrino sector, the expected uncertainty on the effective number of relativistic species, $N_("eff")$, from #emph[LiteBIRD] alone is $sigma ( N_("eff") ) tilde.eq 0.15$~@errard-etal:2016, which is of the same order of magnitude as that obtained by #emph[Planck]~#cite(<Planck2018VI>). On top of that, it would give an independent measurement, and an important cross-check, since any systematic effects would be different from those relevant for the high-$ell$ #emph[Planck] measurements, e.g., the modeling of small-scale
foregrounds (see for example Ref.~@henrot-versille-etal:2019 for a discussion of how these might affect the estimate of $N_("eff")$ provided by #emph[Planck]).


The relevance of measuring $N_("eff")$ goes beyond neutrino physics, since this parameter traces the presence of any radiation-like components at the time of CMB decoupling. Such candidates include thermal axions~#cite(<Turner:1986tb>) #cite(<Chang:1993gm>) and sterile neutrinos~#cite(<Boyarsky:2009ix>), as well as other light species that were in thermal equilibrium with the cosmological plasma at some early point in the history of the Universe~#cite(<Baumann:2016wac>). Measuring $N_("eff")$ also allows us to probe the thermal history of the Universe
with nonstandard particle contents, e.g., the decay of nonrelativistic massive particles~#cite(<Kawasaki:1999na>). A more accurate value of $N_("eff")$ would also help constrain the energy density of the stochastic gravitational wave background~#cite(<Smith:2006nka>) #cite(<henrot-versille-etal:2015>) #cite(<Pagano:2015hma>) because gravitational waves behave as radiation.


== Cosmic Birefringence
<ss:eb>


There exists a distinct possibility that either (or both) of dark matter and dark energy is a pseudoscalar field, $phi$ that changes sign under parity, i.e., inversion of spatial coordinates ~#cite(<marsh:2016>) #cite(<ferreira:2021>). If this is the case then this field could leave a unique signature in the polarization of the CMB. More generally, if the new physics that generated the initial scalar and tensor fluctuations does not violate parity symmetry, and the CMB photons do not experience any parity-violating processes as they propagate for 13.8
billion years from the surface of last scattering to us, then any parity-violating correlation functions such as the temperature-$B$-mode ($T B$) correlation and the $E B$ correlation must vanish. This is because under spatial inversion, the spherical harmonic coefficients transform as $ a_(ell m)^T arrow.r + ( - 1 )^ell a_(ell m)^T thin , quad a_(ell m)^E arrow.r + ( - 1 )^ell a_(ell m)^E thin , quad a_(ell m)^B arrow.r - ( - 1 )^ell a_(ell m)^B thin . $ Consequently, the expectation value of any parity-odd observable, such as the $T B$ and $E B$
correlations, must vanish if the underlying physics is parity conserving. On the other hand, if the underlying physics violates parity, these correlation functions can and generically do have non-vanishing expectation values~@lue-wang-kamionkowski:1999@feng-etal:2005@liu-lee-ng:2006@saito-ichiki-taruya:2007@contaldi-magueijo-smolin:2008.


In this section we describe a physical effect known as "cosmic birefringence"~@carroll-field-jackiw:1990 ~#cite(<Carroll:1991zs>) #cite(<carroll:1998>) @harari-sikivie:1992. See Ref.~#cite(<Komatsu:2022nvu>) for a review. The basic idea is that a new parity-violating coupling of $phi$ to the electromagnetic tensor makes the phase velocities of right- and left-handed polarization modes of photons different. This results in rotation of the direction of linear polarization as the CMB photons propagate through space. In other words, space filled with this
$phi$ field behaves as if it were a birefringent medium. A homogeneous $phi$ field coupled to the electromagnetic field via the Chern-Simons term (i.e., the Lagrangian contains a term $- 1\/4 g_(phi gamma) phi F_(mu nu) tilde(F)^(mu nu)$), rotates the linear polarization direction uniformly over the sky by an angle $beta = 1\/2 g_(phi gamma) integral_(t_L)^(t_0) d t med dot(phi)$ ~#cite(<carroll-field-jackiw:1990>) #cite(<Carroll:1991zs>) #cite(<harari-sikivie:1992>) #cite(<carroll:1998>), converting $E$-mode into $B$-mode polarization. The rotation
angle is defined such that $beta > 0$ corresponds to clockwise rotation on the sky in right-handed coordinates with the $z$-axis taken in the direction of observer's lines of sight. Here, $g_(phi gamma)$ is the coupling constant of the interaction of $phi$ and photons, $F_(mu nu)$ and $tilde(F)_(mu nu)$ are the electromagnetic tensor and its dual, and $t_L$ and $t_0$ are the time of last scattering and the present time, respectively. We would therefore observe a $B$-mode polarization signal even if there were no $B$-mode polarization
initially~@lue-wang-kamionkowski:1999. The $phi$ field can be dark matter, dark energy, or both~#cite(<carroll:1998>) #cite(<Finelli:2008jv>) #cite(<marsh:2016>) #cite(<ferreira:2021>) @fujita-etal:2021; thus, discovery of such a signal would be a major breakthrough in cosmology and fundamental physics.


When $beta$ does not vanish, the observed $E$- and $B$-mode spherical harmonics coefficients of the CMB, $a_(ell m)^(E , "CMB" , o)$ and $a_(ell m)^(B , "CMB" , o)$, are related to those at the surface of last scattering as 

$ a_(ell m)^(E, "CMB", o) &= a_(ell m)^(E, "CMB") cos(2 beta) - a_(ell m)^(B, "CMB") sin(2 beta) , \
  a_(ell m)^(B, "CMB", o) &= a_(ell m)^(E, "CMB") sin(2 beta) + a_(ell m)^(B, "CMB") cos(2 beta) . $



Since the miscalibration angle $alpha$ generates a spurious $B$-mode power spectrum $sin^2 ( 2 alpha ) C_ell^(E E)$, we must calibrate the angles with a precision sufficient to achieve the full science requirements of #emph[LiteBIRD]. As described in @sss:anglecal, there are no strong polarized astrophysical sources on the sky with precisely known polarization angles; thus, the calibration must rely on measurements on the ground, which currently limit the accuracy of calibration to a bit better than $1^compose$. This accuracy is much poorer than the
requirement, which is of order $0.05^compose$, demanding substantial improvements in the ground-calibration methodology. As a result, the option of using the $T B$ and $E B$ correlations (assumed to vanish) to calibrate the instrumental polarization angles~@keating-shimon-yadav:2012 was considered in @sss:anglecal. This method is based on accurate knowledge of the cosmological $T E$ and $E E$ power spectra from the scalar mode, and it is straightforward to fit to the $T B$ and $E B$ power spectra to solve for $alpha$ with arcminute precision. However,
not only does this "self-calibration" procedure eliminate 's sensitivity to the new physics of uniform rotation caused by $phi$, but it can also bias the angle calibration if non-zero $beta$ is present in the data.


A new method ~#cite(<Minami:2019ruj>) #cite(<Minami:2020xfg>) #cite(<MinamiKomatsu:2020>) has been developed to mitigate this issue. The basic idea is to use the polarized Galactic foreground emission as the angle calibrator. Cosmic birefringence is a cumulative effect, whose magnitude is proportional to the path length of photons. Since the origin of the Galactic emission is much closer to Earth than the CMB, we can ignore $beta$ in the Galactic emission (labeled 'fg' below). On the other hand, the miscalibration angle $alpha$ affects both the CMB and the Galactic emission. We thus write


$ a_(ell m)^(E, "o") &= a_(ell m)^(E, "fg") cos(2 alpha) - a_(ell m)^(B, "fg") sin(2 alpha) \
  &quad + a_(ell m)^(E, "CMB") cos(2 alpha + 2 beta) - a_(ell m)^(B, "CMB") sin(2 alpha + 2 beta) , \
  a_(ell m)^(B, "o") &= a_(ell m)^(E, "fg") sin(2 alpha) + a_(ell m)^(B, "fg") cos(2 alpha) \
  &quad + a_(ell m)^(E, "CMB") sin(2 alpha + 2 beta) + a_(ell m)^(B, "CMB") cos(2 alpha + 2 beta) , $


which gives the ensemble average of the observed $E B$ power spectrum as #cite(<Minami:2019ruj>)

$
  angle( C_ell^(E B, "o") ) &= (tan(4 alpha) \/ 2) (angle( C_ell^(E E, "o") ) - angle( C_ell^(B B, "o") )) \
    & + (sin(4 beta) \/ (2 cos(4 alpha))) (angle( C_ell^(E E, "CMB") ) - angle( C_ell^(B B, "CMB") )) \
    &quad quad quad quad quad quad quad + 1 \/ cos(4 alpha) angle( C_ell^(E B, "fg") ) + (cos(4 beta) \/ cos(4 alpha)) angle( C_ell^(E B, "CMB") ) , $

This formula allows us to determine $alpha$ and $beta$ simultaneously. Note that we do not need to know the intrinsic foreground $E E$ and $B B$ power spectra, but only those of the CMB as well as the intrinsic $E B$ spectra of the CMB and the foreground emission. The last term on the right-hand side is the intrinsic $E B$ power spectrum of the CMB at the surface of last scattering. This can be produced by parity-violating gravitational waves from, e.g., the gravitational Chern-Simons term~@lue-wang-kamionkowski:1999 @saito-ichiki-taruya:2007
@contaldi-magueijo-smolin:2008 and Abelian~@sorbo:2011 or non-Abelian~@thorne-etal:2018 gauge fields during inflation (see Sect.~#ref(<ss:cmbpol_beyondpower>, supplement: none)). Because these effects arise from gravitational waves, the shape of the $E B$ power spectrum is completely different from that generated by cosmic birefringence; thus, we can simultaneously fit $beta$ and $C_ell^(E B, "CMB")$ without losing sensitivity~#cite(<Gluscevic:2010vv>) #cite(<thorne-etal:2018>).


The intrinsic $E B$ correlation of the foreground emission, $C_ell^(E B , "fg")$, requires a careful treatment. The worst case scenario is that $C_ell^(E B , "fg")$ is proportional to $C_ell^(E E , "fg") - C_ell^(B B , "fg")$. In this case, fitting the observed $E B$ power spectrum gives $beta - gamma$ rather than $beta$, where $gamma$ is an additional effective angle from the intrinsic foreground $E B$ correlation~#cite(<Minami:2019ruj>). Since the #emph[Planck] data show a positive $T E$ and $T B$ signal for thermal dust emission~@PlanckIntXLIX
@Planck2018XI, we expect a positive $E B$ as well~@huffenberger-rotti-collins:2020, although this is yet to be found and its strength may depend on the Galactic mask ~#cite(<clark-etal:2021>) #cite(<Diego-Palazuelos:2022dsq>)


// [figvision-cn] imgs/ComparisonOfBBWithPlanckBirefringence_withLensed07_N51only_LBerror_Cell2Dell.png
// 该图为单张对数-对数坐标曲线图，横轴为“Multipole ℓ”，范
// 围从约5至10⁴，单位无量纲；纵轴为“ℓ(ℓ+1)C_ℓ^BB/(2π) [μK
// ²_CMB]”，范围从10⁻⁷至10⁰，单位为微开尔文平方。图中包含
// 四条曲线、一个阴影区域和一个阶梯状误差条区域，所有元素
// 均在左上角图例中定义。 蓝色实线表示由EE模式推导出的BB
// 功率谱，对应宇宙双折射参数β=0.35±0.14，其周围环绕浅蓝
// 色半透明阴影带，代表该参数的不确定性范围。该曲线在ℓ≈10
// 处达到局部极小值（约3×10⁻），随后上升，在≈500处出现峰
// 值（约5×10⁻³），之后下降并伴随振荡结构，整体位于红色曲
// 线下方但在高ℓ区与之接近。 黑色点线表示Starobinsky慢滚
// 模型下的原初引力波产生的BB功率谱，无具体r值标注但隐含
// 典型慢滚预测。该曲线在低ℓ区（ℓ<10）约为8×10⁻，随ℓ增加
// 缓慢下降，在ℓ≈200后急剧衰减，于ℓ≈3000时低于10⁻。 绿色
// 点划线表示张标比r=0.001的慢滚模型下原初引力波产生的BB
// 功率谱。该曲线在低ℓ区（ℓ<10）约为1.5×10⁻⁵，略低于黑色
// 点线，随ℓ增加先缓升后降，在ℓ≈100处达峰值（约8×10⁻⁵），
// 之后快速下降，于ℓ≈2000时低于10⁻⁷。 红色实线表示CMB引力
// 透镜效应产生的标量BB功率谱。该曲线单调递增，从ℓ=5时的
// 约2×10⁻上升至ℓ≈1000处的峰值（约0.1 μK²_CMB），之后缓慢
// 下降，在ℓ=10⁴时仍高于10⁻²，是图中最高幅度的信号。 紫色
// 阶梯状填充区域代表LiteBIRD卫星设计的误差棒（error bars），
// 覆盖ℓ从约5到约300的范围，高度从10⁻⁶到约5×10⁻⁴不等，呈
// 分段常数形式，表明仪器灵敏度随多极矩变化。该区域部分覆
// 盖蓝色曲线及两条虚线，显示LiteBIRD设计目标可探测这些信
// 号。 趋势与结论：红色透镜BB谱主导高ℓ区；原初引力波信号
// （黑、绿线）在低ℓ区显著且被LiteBIRD误差棒覆盖，说明其
// 可探测性；蓝色曲线代表观测约束下的宇宙双折射贡献，其幅
// 度介于原初信号与透镜信号之间，并在中高ℓ区显现振荡特征，
// 暗示非标准物理过程的存在可能。
#figure(placement: top, image("imgs/ComparisonOfBBWithPlanckBirefringence_withLensed07_N51only_LBerror_Cell2Dell.png", width: 80.0%),
  caption: [
    The $B$-mode power spectrum from cosmic birefringence with $beta = 0.35^compose plus.minus 0.14^compose$ (the blue shaded area). The dotted and dot-dashed lines show the $B$-mode power spectra from primordial gravitational waves with $r = 0.00461$ (Starobinsky's model~#cite(<starobinsky:1980>)) and 0.001, respectively, both of which are detectable by #emph[LiteBIRD] by design. The red line shows the $B$-mode power spectrum from the gravitational lensing effect of the CMB. The purple shaded regions show the expected constraints from #emph[LiteBIRD],
derived in Sect.~#ref(<ss:forecasts_fg_cleaning>, supplement: none)
  ]
)
<fig:cleb>


Recently, the value $beta - gamma = 0.35^compose plus.minus 0.14^compose$ (68% CL) has been obtained from the #emph[Planck] 2018 data @minami-komatsu:2020. If $gamma > 0$, as implied by the positive $T E$ and $T B$ measurements of the polarized dust emission, the significance of $beta$ would increase further. This has been confirmed by the latest analysis using the #emph[Planck] Public Data Release 4 (PR4) "`NPIPE`" reprocessing~#cite(<PlanckIntLVII>). Thanks to the lower noise and better-characterized systematics, an improved measurement,
$beta - gamma = 0.30^compose plus.minus 0.11^compose$ (68% CL), is obtained for nearly full-sky data~#cite(<Diego-Palazuelos:2022dsq>). Accounting for $C_ell^(E B , "fg")$ using the $T E$ and $T B$ measurements of the polarized dust emission and a physical model of Ref.~@clark-etal:2021, $beta = 0.36^compose$ is found with the same statistical uncertainty. The impact of the known systematics of the #emph[Planck] data on $beta$ is found to be negligible compared to the statistical uncertainty. It is too early to tell if this tentative hint for $beta$ is
due to cosmic birefringence, some unknown systematics in the #emph[Planck] data, some unexpected property of the intrinsic foreground $E B$ correlation, or a combination of them. In any case, #emph[LiteBIRD] can play a decisive role in understanding the origin of any such signal. With #emph[LiteBIRD], we can reduce the statistical uncertainty to below $0.1^compose$~#cite(<MinamiKomatsu:2020>), potentially increasing the statistical significance from 3$thin sigma$ to the level of discovery.


If cosmic birefringence exists at the level of $beta = 0.35^compose$, it will produce $B$-mode polarization of $sin^2 ( 2 beta ) C_ell^(E E)$, which is within reach of 's sensitivity (@fig:cleb). Therefore, #emph[LiteBIRD] can test for the presence of the cosmic birefringence signal, not only via the $E B$ correlation, but also the $B$-mode power spectrum.


So far we have only discussed birefringence that is the same in every direction, but in principle we can also look for an #emph[anisotropy] in $beta$~@li-zhang:2008@pospelov-ritz-constantinos:2009. This can arise from inhomogeneity of dark matter (and possibly also dark energy) made of a pseudoscalar field coupled to the electromagnetic tensor via the Chern-Simons term. This introduces correlations between $T$ and $B$ and between $E$ and $B$ at different multipoles, (i.e., $chevron.l a_(ell m)^T a_(ell' m')^E chevron.r$ and
$chevron.l a_(ell m)^E a_(ell' m')^B chevron.r$), in a manner similar to the gravitational lensing effect of the CMB~#cite(<kamionkowski:2009>) #cite(<Yadav:2009eb>) #cite(<namikawa:2017>). Such a property makes it possible to create a map of $beta$ in each #emph[LiteBIRD] pixel. This map will be useful not only for probing new parity-violating physics, but also for characterizing instrumental systematics (i.e., anisotropy in $alpha$). So far there is no evidence for the anisotropic signal of
$beta$~@contreras-etal:2017@namikawa-etal:2020@bianchini-etal:2020@gruppuso-etal:2020, but #emph[LiteBIRD] can certainly improve upon the constraints, particularly on the largest angular scales.


== Mapping the Hot Gas in the Universe
<ss:sz>


// [figvision-cn] imgs/fig_ydiff.png
// 这是一张展示热苏尼亚耶夫-泽尔多维奇（SZ）效应频谱的二
// 维曲线图。 横坐标轴名称为“Frequency [GHz]”（频率，单位
// 吉赫兹），范围从0延伸至500以上，主刻度标记为0、100、
// 200、300、400和500。纵坐标轴名称为“Brightness
// difference [kJy sr^-1]”（亮度差异，单位千央斯基每球面
// 度），范围从-10到10，主刻度标记为-10、-5、0、5和10。
// 图中包含两条黑色曲线和一组彩色矩形条块。 第一条曲线为
// 黑色实线，代表非相对论极限下的示例频谱。该曲线的物理参
// 数为康普顿y参数 y = 5 × 10^-6。其走势特征如下：在低频
// 段（约0至217 GHz）位于横轴下方，呈现负值；在约130 GHz
// 处达到最小值，约为-5.5 kJy sr^-1；随后曲线上升，在约
// 217 GHz处穿过横轴变为正值；在约380 GHz处达到峰值，数值
// 接近9 kJy sr^-1；之后随频率增加而下降。 第二条曲线为黑
// 色虚线，代表相对于非相对论SZ效应的相对论修正项。该曲线
// 的计算基于光学深度 τ_h = 0.01 和电子温度 T_e = 5 keV（
// 由此得出 y ≈ 1.2 × 10^-3）。此曲线表示全谱与非相对论谱
// 之间的差值。其走势特征如下：在低频段接近0并略低于0；在
// 约180 GHz处穿过横轴；在约300 GHz处急剧下降至最低点，数
// 值约为-10 kJy sr^-1；随后迅速回升，在约420 GHz处再次穿
// 过横轴，并在高频段（大于500 GHz）持续上升至10 kJy sr^
// -1以上。 背景中叠加了一组彩色的矩形条块，这些条块以纵
// 轴零点为中心对称分布或偏移，代表了不同频段的观测窗口或
// 带宽覆盖情况。从左至右依次为： 蓝色条块：中心频率约40
// GHz，高度跨越约-1到1。 橙色条块：中心频率约50 GHz，高
// 度跨越约-1到2。 紫色条块：中心频率约70 GHz，高度跨越约
// -1到1.5。 青色条块：中心频率约90 GHz，高度跨越约-1到
// 1.5。 浅棕色条块：中心频率约120 GHz，高度跨越约-1到1.5。
// 橄榄绿色条块：中心频率约150 GHz，高度跨越约-1到2。 深
// 青色条块：中心频率约180 GHz，高度跨越约-2到0。 淡紫色
// 条块：中心频率约230 GHz，高度跨越约-4到3.5。 红色条块：
// 中心频率约300 GHz，高度跨越约0到5。 粉色条块：中心频率
// 约400 GHz，高度跨越约-7到0。 图左上角有一个图例框，内
// 部标注了两行文字说明：第一行为“Non-relativistic: y = 5
// × 10^-6”，对应实线；第二行为“Rel. correction: τ_h =
// 0.01, T_e = 5 keV”，对应虚线。整张图传达了热SZ效应在不
// 同频率下的亮度变化特征，以及相对论效应在高频段对传统非
// 相对论模型的显著修正作用。
#figure(placement: top, image("imgs/fig_ydiff.png", width: 90.0%),
  caption: [
    Spectrum of the thermal SZ effect. The solid line shows the example spectrum in units of kJy sr$""^(- 1)$ in the non-relativistic limit, $k_B T_e \/ m_e c^2 lt.double 1$, with $y = tau_h k_B T_e \/ m_e c^2 = 5 times 10^(- 6)$. The dashed line shows the spectrum of the relativistic correction for $tau_h = 0.01$ and $k_B T_e = 5 thin "keV"$ (which gives $y = 9.8 times 10^(- 5)$) relative to the non-relativistic SZ effect with $y = 9.5 times 10^(- 5)$, calculated by the `SZpack` package~@chluba-etal:2012@chluba-etal:2013, i.e., the difference between
the full and non-relativistic spectra in units of kJy sr$""^(- 1)$. We show the difference between the relativistic and non-relativistic SZ spectra with two different values of $y$ to highlight the genuine effect of the relativistic correction, which cannot be absorbed by changing the value of $y$. The colored bars show the sensitivity of the 15 partially overlapping bands of the #emph[LiteBIRD] detectors. For clarity we show half of the bands as positive and the other half as negative quantities, but only their absolute values are meaningful.
  ]
)
<fig:sz>


Electrons in the hot ionized gas transfer their energy to CMB photons by inverse Compton scattering, leading to a characteristic distortion of the blackbody spectrum of the CMB (see @fig:sz). This phenomenon is known as the thermal SZ effect~@zeldovich-sunyaev:1969@sunyaev-zeldovich:1972 and has been routinely detected in the directions of galaxy clusters~@carlstrom-holder-reese:2002@kitayama-etal:2014@bleem-etal:2015@Planck2015XXVII@hilton-etal:2021. The amplitude of the thermal SZ effect is characterized by the so-called "Compton $y$ parameter," which
is given by $y = tau_h k_B T_e \/ m_e c^2$ where $tau_h$ is the optical depth of hot gas (which should be distinguished from the optical depth of reionization, $tau$, discussed in @ss:tau) and $T_e$ and $m_e$ are the electron temperature and mass, respectively.


Using the so-called constrained internal linear combination (cILC) method~@remazeilles-etal:2011@remazeilles-etal:2011b@remazeilles-etal:2013@hurier-etal:2013, we can reconstruct an all-sky map of the thermal SZ signal and its angular power spectrum with minimal residual foreground contamination~@Planck2015XXII@madhavacheril-etal:2019@bleem-etal:2022. Applying the same component-separation algorithm that was used on the #emph[Planck] data to the #emph[LiteBIRD] simulations, we find that, while the #emph[Planck] SZ map still contains contamination of
various foreground sources due to the limited number of frequency bands, #emph[LiteBIRD] can faithfully reconstruct the SZ map at $ell > 20$. @fig:clsz shows the power spectrum of the reconstructed SZ map from this simulation. We also find that, while the reconstruction noise in the #emph[Planck] SZ map is comparable to the signal itself, #emph[LiteBIRD] will reduce the noise by an order of magnitude relative to the #emph[Planck] SZ map.


// [figvision-cn] imgs/nilc_power_spectra.png
// 该图为单张双对数坐标曲线图，展示了热太阳风泽效应（SZ）
// 功率谱的模拟重建结果与输入模型及各残差分量的对比。 横
// 轴为“Multipole l”（多极矩），采用对数刻度，范围从约5延
// 伸至1000，主刻度标记为10^1和10^2。纵轴为“10^{12} l(l+1
// )C_l^{yy}/2π”，代表归一化后的功率谱幅值，同样采用对数
// 刻度，范围从10^{-4}至10^2，主刻度间隔为一个数量级。 图
// 中包含九条不同颜色和线型的曲线，具体含义如下： 黑色实
// 线（Input SZE）：代表输入的原始热SZ效应功率谱。该曲线
// 从左下方向右上方单调递增，在l=10处数值约为3×10^{-3}，
// 在l=100处约为0.1，在l=600处接近0.5。 红色实线（
// LiteBIRD constrained NILC SZE）：代表利用LiteBIRD模拟
// 数据通过约束NILC算法重建的SZ功率谱。该曲线整体趋势与黑
// 色实线高度重合，但在l<20的低多极区域略高于黑色曲线，且
// 呈现出更明显的锯齿状波动。 灰色点线（Planck noise
// residuals）：代表Planck卫星的噪声残差。该曲线在l<50的
// 区域处于较高水平（约10^{-2}量级），并在l≈30处出现局部
// 峰值，随后逐渐下降，在l>100后低于其他大部分残差曲线。
// 绿色长虚线（LiteBIRD noise residuals）：代表LiteBIRD的
// 噪声残差。该曲线位于灰色点线下方，随l增加而上升，在l=
// 100处数值约为0.02，表明其噪声水平显著低于Planck。 橙色
// 点划线（LiteBIRD CIB residuals）：代表宇宙红外背景（
// CIB）的残差。该曲线随l增加呈上升趋势，位于绿色噪声线之
// 下，在l=100处数值约为0.01。 品红色短虚线（LiteBIRD
// Galactic residuals）：代表银河系前景辐射的残差。该曲线
// 在l<20时约为10^{-2}，随后下降，在l=100附近达到最低点（
// 约2×10^{-3}），之后缓慢回升。 蓝色点划线（LiteBIRD
// point-source residuals）：代表点源残差。该曲线在低l区
// 域较低，随l增加迅速上升，在l>200后成为主要的残差来源之
// 一。 棕色长虚线（LiteBIRD CMB residuals）：代表宇宙微
// 波背景（CMB）的残差。该曲线在所有曲线中位置最低，数值
// 主要在10^{-4}至10^{-3}之间波动，表明CMB去除了非常干净。
// 总体结论显示，红色重建曲线与黑色输入曲线在大范围内吻合
// 良好，验证了算法的有效性。灰色Planck噪声线在低l处明显
// 高于绿色LiteBIRD噪声线，说明LiteBIRD具有更低的噪声基底。
// 各残差分量（彩色虚线/点线）均远低于信号本身，其中银河
// 系残差在低l处最显著，而CMB残差最小。
#figure(placement: top, image("imgs/nilc_power_spectra.png", width: 100%),
  caption: [
    Reconstructed power spectrum of the thermal SZ effect from a simulation of ~(red line), compared with the input one (black line). Both agree well except at $ell < 20$, which still shows residuals from the Galactic emission; however, such low multipoles suffer from large non-Gaussian cosmic-variance error bars in any case. The noise power spectrum of ~(green dashed line) is much lower than that of #emph[Planck]~(gray dotted line), showing the substantially improved sensitivity and fidelity of the thermal SZ map from #emph[LiteBIRD].
  ]
)
<fig:clsz>


Exploiting the 15 #emph[LiteBIRD] frequency bands will yield a much improved, high-fidelity SZ map over the full sky at $ell lt.eq 200$, essentially free of contamination. This full sky map will show in projection all hot gas in the Universe and will have a lasting impact on astrophysics as legacy data from #emph[LiteBIRD]. An important application of this full sky thermal SZ map will be to cross-correlate it with three-dimensional catalogues of galaxies with the known redshifts, as demonstrated in
Refs.~@vikram-lidz-jain:2017@makiya-ando-komatsu:2018@pandey-etal:2019@koukoufilippas-etal:2019@chiang-etal:2020@yan-etal:2021. This cross-correlation allows us to perform #emph[tomography] of the hot gas in the Universe as a function of cosmic time, which can test theories of structure formation~@chiang-etal:2021. This full-sky thermal SZ map can also be used to search for the whim by stacking at the positions of known galaxy pairs~@degraaff-etal:2019.


The high-fidelity SZ map is also useful for studying an inhomogeneous reionization process via the cross-correlation of the SZ map and fluctuations of the CMB optical depth, $delta tau_h$~@namikawa-etal:2021. The SZ effect can be generated by hot electrons during the reionization epoch and the optical depth has fluctuations due to the spatial variations of the electron density during the reionization epoch. Thus, an inhomogeneous reionization process leads to a correlation between the SZ map and $delta tau_h$. This cross-correlation is much less affected
by late-time galaxy cluster contributions than the SZ auto-power spectrum. In addition, this cross-correlation can constrain the temperature of ionized bubbles, while the kinetic SZ and $delta tau_h$ cannot. The cross-correlation signal would be detectable by comparing the #emph[LiteBIRD] SZ map with a $delta tau_h$ map reconstructed from CMB-S4 for an interesting parameter space for the ionized bubbles, e.g., a characteristic size of $5 thin$Mpc and a temperature of $5 times 10^4 thin$K.


The solid line in @fig:sz shows the SZ spectrum in the non-relativistic limit (where $k_B T_e \/ m_e c^2 lt.double 1$) for an example value of $y = 5 times 10^(- 6)$. The shape is universal and depends only on the mean CMB temperature; however, small relativistic corrections to this shape exist~#cite(<wright:1979>) #cite(<fabbri:1981>) #cite(<rephaeli:1995>) and are proportional to $k_B T_e \/ m_e c^2$ at leading order~@challinor-lasenby:1998@itoh-kohyama-nozawa:1998@sazonov-sunyaev:1998. Detecting this relativistic correction averaged over a full sky SZ
map~@remazeilles-etal:2019@remazeilles-chluba:2020 can yield the mean gas temperature of the Universe, providing an "integral constraint" on physics of the intergalactic medium~@hill-etal:2015 and stringent and robust constraints on the energy feedback from supernovae and agn. This complements information that can be obtained about the relationship between the WHIM and halos from correlating the SZ map with gravitational lensing and other tracers of large-scale structure~#cite(<Ma2015>) #cite(<Lim2018>)


The dashed line in @fig:sz shows the relativistic correction for $tau_h = 0.01$ and $k_B T_e = 5$ keV, relative to the non-relativistic SZ effect with $y = 9.5 times 10^(- 5)$. Note that $tau_h = 0.01$ and $k_B T_e = 5$ keV correspond to $y = 9.8 times 10^(- 5)$. One may wonder why we do not take the difference between the relativistic and non-relativistic SZ spectra with the same $y = 9.8 times 10^(- 5)$. This would give a larger difference at low frequencies, giving the impression that we can detect the relativistic correction without the
high-frequency data; however, this is false, since the difference at low frequencies can be compensated by slightly changing $y$, as we have done here~@chluba-etal:2021, whereas the distortion at high frequencies is genuine and cannot be compensated by changing $y$. Observing above 300 GHz with #emph[LiteBIRD] will thus give a great advantage compared to lower frequency ground-based surveys for detecting the relativistic correction, since the electron-temperature dependence of the relativistic correction manifests itself mostly at high frequencies, as
shown in @fig:sz. Finally, the #emph[LiteBIRD] sensitivity and high-frequency coverage could be used to apply the method proposed in @rephaeli:1980 to improve constraints on the monopole of the $y$-type distortion of the CMB spectrum via the spectrum of the SZ effect.


== Anisotropic CMB Spectral Distortions
<ss:mu>


Although #emph[LiteBIRD] is not sensitive to the spatially uniform (i.e., monopole) component to the distortion of the Planckian spectrum of the CMB, it is very sensitive to any #emph[spatially-varying] component of the spectral distortion. The thermal SZ effect, described in @ss:sz, is one example of such a spectral distortion and can be used to map the distribution of hot gas in the Universe.


Another example of anisotropies with spectral dependence different from that of the CMB is Rayleigh scattering of the CMB photons~@takahara-sasaki:1991@yu-spergel:2001. The CMB decoupled from electrons at a redshift of $z tilde.eq 1090$, leading to the usual "surface of last scattering." Around this epoch the electrons combined with protons to form neutral hydrogen atoms, which also scatter photons via Rayleigh scattering. The cross-section for Rayleigh scattering has a characteristic frequency dependence of
$sigma_R ( nu ) prop nu^4$~#cite(<rayleigh_lord_1881_1431155>), which leaves a frequency-dependent imprint in temperature and polarization anisotropies of the CMB. No monopole spectral distortion is produced by Rayleigh scattering.


The cross-section of Rayleigh scattering is given more explicitly by $
  sigma_R ( nu ) = sigma_T (tilde(nu)^4 + 638 \/ 243 tilde(nu)^6 + dots.h) thin ,
$ where $sigma_T$ is the Thomson cross-section, $tilde(nu) equiv nu \/ ( sqrt(8 \/ 9) c R_oo ) tilde.eq nu \/ ( 3.1 times 10^6 thin "GHz" )$, and $R_oo$ is the Rydberg constant. This additional scattering produces a frequency-dependent shift of the peak of the visibility function to $z < 1090$, which modifies the Silk damping process and shifts the locations of the acoustic peaks in the temperature and $E$-mode polarization power spectra~@yu-spergel:2001.


The Rayleigh-scattering signal can be extracted from the data by cross-correlating the frequency-independent Thomson-scattering component and the frequency-dependent ($nu^4$) Rayleigh-scattering component~#cite(<lewis:2013>) #cite(<beringue-etal:2021>). Since the frequency dependence of these two components is known precisely, we can separate them by expliciting rejecting the other component using the cILC method~@remazeilles-etal:2011@remazeilles-etal:2011b@remazeilles-etal:2013@hurier-etal:2013. The remaining largest contamination is then the cib.
While the expected Rayleigh scattering signal is small in the frequencies observed by #emph[LiteBIRD], the superb sensitivity of #emph[LiteBIRD] allows for detection of the signal at a statistical significance of 25$thin sigma$~@beringue-etal:2021, which is due primarily to the temperature data. The first detection of this signal would not only be a significant achievement in cosmology (because this is a firm prediction of the standard model of cosmology that is yet to be confirmed), but could also improve determination of the cosmological parameters
such as $N_("eff")$ and $sum m_nu$~@beringue-etal:2021, as well as primordial non-Gaussianity~@coulton-beringue-meerburg:2021.


It may also be possible to probe epochs earlier than CMB last-scattering using different spectral information. Let us review the well-known physics of the early Universe (see Refs.~#cite(<tashiro:2014>) @chluba-hamann-patil:2015 for reviews). When the temperature of the Universe exceeded $5 times 10^6 thin$K (or $z > 2 times 10^6$ in terms of redshift), double-Compton scattering (which changes the total photon number) was efficient in relaxing the photon spectrum to a Planck spectrum with a vanishing chemical potential, even if some extra energy was
injected into the plasma~@burigana-danese-dezotti:1991@hu-silk:1993. If the energy was injected in the range $5 times 10^4 < z < 2 times 10^6$, double-Compton scattering would no longer be fast enough to relax the photon spectrum to a blackbody with no chemical potential. Compton scattering is still efficient for redistributing the photon energies so as to maintain an equilibrium distribution (i.e., a Bose-Einstein distribution with #emph[non-zero] chemical potential, also known as the "$mu$ distortion"). If the spectral distortion was caused by an
energy injection after $z = 5 times 10^4$, it would #emph[not] relax to an equilibrium distribution because the energy exchange due to Compton scattering would be inefficient, resulting in, for example, a permanent spectral distortion such as the SZ effect described in @ss:sz.


While there exist many theoretical possibilities for energy injection in the early Universe before $z = 5 times 10^4$~#cite(<tashiro:2014>) #cite(<chluba-hamann-patil:2015>), one mechanism present in the standard model of cosmology is energy injection from the dissipation of sound waves~#cite(<silk:1968>) #cite(<sunyaev-zeldovich:1970>). Because this spectral distortion occurs at second order in the perturbation, the energy injection rate due to the dissipation of sound waves is proportional to the sound wave amplitude squared. This property makes it
possible to constrain the small-scale power of fluctuations from the chemical potential~#cite(<daly:1991>) #cite(<barrow-coles:1991>) #cite(<hu-scott-silk:1994>)


This phenomenon offers the third example of anisotropic spectral distortions of the CMB. While this signal is isotropic in the sky if the fluctuations obey Gaussian statistics, a specific type of non-Gaussian fluctuations, called "squeezed non-Gaussianity," can be produced by certain physical mechanisms during inflation, such as multi-field effects and non-Bunch-Davies vacuum initial conditions, and would generate spectral distortions characterized by a #emph[spatially varying] chemical potential~@pajer-zaldarriaga:2012@ganc-komatsu:2012. #emph[LiteBIRD]
can look for this signal by cross-correlating the measured temperature anisotropies with a map of the chemical potential reconstructed from 's multi-frequency data, since this cross-correlation measures a three-point function (temperature fluctuation on large scales correlated with the squared amplitude of sound waves on small scales). Although the multi-field effect of inflation yields only a small signal-to-noise ratio for #emph[LiteBIRD], given the constraints on this type of non-Gaussianity from the #emph[Planck] data~@Planck2015XVII @Planck2018IX,
non-vacuum effects can yield a large signal-to-noise ratio, offering a powerful test of the physics of inflation at its onset~@ganc-komatsu:2012. Additional sources of anisotropic spectral distortion arise when the background spacetime is itself anisotropic~@ota:2019 @shiraishi-liguori-bartolo:2015@shiraishi-bartolo-liguori:2016.


There may be additional spectral-spatial variations in the CMB that can be probed by #emph[LiteBIRD], including those that affect polarization. As an example, light axion-like particles are converted into photons in the presence of magnetic fields, generating anisotropic distortions in the CMB spectrum~@mukherjee-khatri-wandelt:2018. In particular, "resonant conversion" of axions into photons by the Galactic magnetic field yields #emph[polarized] spectral distortions of the CMB with the spatial distribution of the signal tracking the Galactic magnetic
field. #emph[LiteBIRD] can search for signals of this type.


== Primordial Magnetic Fields
<ss:pmf>


Magnetic fields are ubiquitous in the Universe at all scales from planetary systems to clusters of galaxies, with hints of their presence also in filaments of the large-scale structure~@govoni-etal:2019@vernstrom-etal:2021 as well as in intergalactic voids~@ando-kusenko:2010@essey-etal:2011@dolag-etal:2011. The dynamo is a popular explanation for the origin of the cosmic magnetic fields, but it requires an initial field. In other words, a dynamo does not generate the field from nothing, but amplifies the existing "seed" field (see
Ref.~@kulsrud-zweibel:2008 for a review). Even the simplest adiabatic compression of magnetic fields frozen to plasma could explain the observed strength of $mu$G in galaxy clusters if the pre-compression strength were 0.1 nG ($= 10^(- 10)$ G) in intergalactic space~@grasso-rubinstein:2001. Lower bounds on the intergalactic magnetic fields of $gt.tilde 10^(- 16)$--$10^(- 18)$ G have been inferred from the lack of extended $gamma$-ray halos towards blazars in the GeV energy bands (see @fermi-lat:2018 and references therein). If they exist in intergalactic
space and within filaments of the large-scale structure, where do they come from (see Refs.~#cite(<widrow:2002>) @kandus-kunze-tsagas:2011@widrow-etal:2012@durrer-neronov:2013 ~#cite(<subramanian:2016>) for reviews)?


Cosmic inflation may provide this origin, i.e., the pmfs. In the standard model of elementary particles and fields, massless gauge fields (such as electromagnetism) are conformally coupled to gravity; thus, no metric excitation of spin-1 fields is possible in an expanding Universe, unlike for scalar~@mukhanov-chibisov:1981 and tensor~#cite(<grishchuk:1975>) #cite(<starobinsky:1979>) perturbations. In other words, we must break conformal invariance of the massless gauge fields to generate the PMFs during inflation~@ratra:1992. Although theoretical
challenges remain~@demozzi-mukhanov-rubinstein:2009@barnaby-namba-peloso:2012, searching for the PMFs has profound implications for our understanding of physics of inflation beyond the origin of the scalar and tensor perturbations that we have already discussed extensively in this paper.


The power spectrum of the stochastic PMFs, $P_B ( k )$, is defined by $
  chevron.l B_i ( k ) B_j^(*) ( q ) chevron.r = ( 2 pi )^3 delta_D^( 3 ) ( k - q ) P_B ( k ) (delta_(i j) - frac(k_i k_j, k^2)) thin ,
$ where $delta_D^( 3 ) ( k )$ is the Dirac delta function and $delta_(i j)$ is the Kronecker delta. A power-law power spectrum, $P_B ( k ) = A_B k^(n_B)$, is characterized by its spectral index, $n_B$, and amplitude, $A_B$. Spectral indices generated during inflation are usually negative~@turner-widrow:1988, e.g., a nearly scale-invariant spectrum of $n_B = - 2.9$ (the exact scale invariance $n_B = - 3$ gives a diverging energy density of the magnetic field), whereas they are positive if generated by causal processes such as the electroweak phase
transition~#cite(<vachaspati:1991>) #cite(<joyce-shaposhnikov:1997>) #cite(<ahonen-enqvist:1998>), i.e., an even integer of $n_B gt.eq 2$~@durrer-caprini:2003.


In the literature, the magnetic field strength is usually quoted as the value extrapolated to the present epoch assuming that the fields are frozen to the plasma. Moreover, we often quote the field value smoothed over a length scale $lambda$, calculated from the smoothed energy density of the magnetic field: $ rho_(B  thin  lambda) = integral_0^oo frac(d^3 k, ( 2 pi )^3) P_B ( k ) e^(- k^2 lambda^2) = A_B frac(Gamma \[ ( n_B + 3 ) \/ 2 \], 4 pi^2 lambda^(n_B + 3)) thin . $ Here we choose $lambda = 1 thin "Mpc"$ and compute the field strength, $B_lambda$,
from the energy density $rho_(B  thin  lambda) = B_lambda^2 \/ 2$, in natural units. We then convert the units and quote the value of $B_lambda$ in units of nG. The convenient quantity is the ratio of $rho_(B  thin  lambda)$ to the CMB photon energy density, $rho_gamma$: $
  rho_(B  thin  lambda) \/ rho_gamma = 9.53 times 10^(- 8) (frac(B_lambda, 1 med "nG"))^2 thin ,
$ for the present-day CMB temperature of 2.7255~K.


The sensitive CMB polarization measurements provided by #emph[LiteBIRD] can constrain the PMFs with unprecedented precision, using three of the distinct ways that the PMFs affect the CMB.


+ A stochastic background of PMFs provides the stress-energy source, which gravitationally induces scalar, vector, and tensor perturbations in the CMB, hence the $T T$, $E E$, and $B B$ power spectra (see Refs.~@grasso-rubinstein:2001@yamazaki-kajino-ichiki:2012 for reviews). In addition, helical magnetic fields can produce parity-violating correlations such as the $T B$ and $E B$ power spectra~@pogosian-vachaspati-winitzki:2002@caprini-durrer-kahniashvili:2004@ballardini-finelli-paoletti:2015; Ref.~@Planck2015XIX describes the constraints on helical
fields from the #emph[Planck] data. Because the temperature and polarization anisotropies from the magnetic-field stress-energy tensor are highly non-Gaussian, higher-order correlations are a powerful probe of the PMF~#cite(<shiraishi:2013>) #cite(<shiraishi-sekiguchi:2014>) #cite(<trivedi-subramanian-seshadri:2014>)

+ Dissipation of the fields heats gas in intergalactic space, altering the thermal history of the Universe~@sethi-subramanian:2005. This affects the CMB primarily via the optical depth of electron scattering (@ss:tau)~@kunze-komatsu:2015 and the isotropic (monopole) distortion of the blackbody spectrum of the CMB~@jedamzik-katalinic-olinto:2000@kunze-komatsu:2014.

+ Faraday rotation induces frequency-dependent ($prop nu^(- 2)$) #emph[inhomogeneous] rotation of polarization angles of the CMB over the sky~@kosowsky-loeb:1996@kosowsky-etal:2005@yadav-pogosian-vachaspati:2012, which has been constrained by #emph[Planck]~@Planck2015XIX@gruppuso-etal:2020 and also by ground-based experiments~#cite(<birefringence-polarbear:2015>) #cite(<birefringence-bicep:2017>)

LiteBIRD is sensitive to all of the above effects, except for the monopole spectral distortion of the CMB.


// [figvision-cn] imgs/TestBoxPMF1802V2_80mm.png
// 这是一张对数-对数坐标系的曲线图，展示了宇宙微波背景辐
// 射（CMB）B模式功率谱随多极矩的变化。图中包含一个主图和
// 一个位于左上角的插图。 子图类型： 曲线图（带插图）。
// 坐标轴： 横轴（X轴）： 标记为“Multipole ℓ”，表示多极矩。
// 刻度范围从 $10^0$（即1）到约 $2 \times 10^3$。主要刻度
// 标记为 $10^1$ 和 $10^2$。 纵轴（Y轴）： 标记为 $\ell(\
// ell+1)C_\ell^{BB}/(2\pi)[\mu K_{CMB}^2]$，表示归一化的
// B模式功率谱幅度。刻度范围从 $10^{-7}$ 到 $10^{-1}$。主
// 要刻度标记为 $10^{-6}, 10^{-5}, 10^{-4}, 10^{-3}, 10^{
// -2}, 10^{-1}$。 图例与曲线说明（位于右上角）： 黑色实
// 线： 标记为 $r=0.00461$。代表Starobinsky暴胀模型的原始
// 张量扰动。在主图中，该曲线在低ℓ区域（$\ell < 10$）数值
// 约为 $6 \times 10^{-5}$，随后下降，在 $\ell \approx 80
// $ 处达到峰值（约 $3 \times 10^{-4}$），之后再次下降。
// 黑色虚线（点状）： 标记为 Lensing。代表引力透镜效应。
// 该曲线呈单调上升趋势，从左下方的 $10^{-6}$ 以下开始，
// 随着ℓ的增加线性上升（在对数坐标下），穿过其他曲线，延
// 伸至右上方超过 $10^{-2}$。 红色实线： 标记为 PMF $n_B
// = -2.9$。代表具有红倾斜谱指数（$n_B = -2.9$）的原初磁
// 场（PMF）产生的引力效应。该曲线在低ℓ区域数值较高，维持
// 在 $2 \times 10^{-4}$ 左右，随后略有下降，在 $\ell >
// 10$ 后急剧上升，最终在 $\ell \approx 100$ 附近达到峰值
// （约 $1.5 \times 10^{-3}$），并在高ℓ端下降。 蓝色实线：
// 标记为 PMF $n_B = 2$。代表具有蓝倾斜谱指数（$n_B = 2$）
// 的因果生成原初磁场。该曲线在低ℓ区域极低（低于 $10^{-7}
// $），随ℓ增加而单调快速上升，在 $\ell \approx 300$ 处接
// 近 $10^{-5}$。 背景数据区域： 图中存在浅蓝色的阶梯状阴
// 影区域，覆盖在曲线下方的大部分区域，这代表了观测数据的
// 限制或噪声水平。该区域大致分布在 $10^{-6}$ 到 $10^{-3}
// $ 之间，形状不规则，显示出不同多极矩下的测量灵敏度差异。
// 插图（Inset）： 位置： 位于主图左上角。 内容： 是主图
// 在低多极矩区域（$\ell$ 从 $10^1$ 到 $10^3$）的放大视图。
// 趋势： 清晰地展示了各曲线的交叉关系。红色曲线在此区间
// 内始终高于黑色实线。蓝色曲线从下方迅速上升，在 $\ell \
// approx 200$ 处穿过黑色实线，并继续上升接近红色曲线。黑
// 色虚线（Lensing）在此区间内呈现明显的上升趋势，并最终
// 超过所有实线曲线。 结论传达： 该图比较了不同物理机制（
// 原始张量扰动、引力透镜、不同谱指数的原初磁场）对CMB B
// 模式功率谱的贡献。结果显示，对于红倾斜的PMF（红线），
// 其信号在中等尺度上显著强于标准的Starobinsky模型（黑线）；
// 而对于蓝倾斜的PMF（蓝线），其信号主要集中在小尺度（高ℓ）
// 上。引力透镜（黑虚线）在小尺度上成为主导因素。
#figure(placement: top, image("imgs/TestBoxPMF1802V2_80mm.png", width: 80.0%),
  caption: [
    $B$-mode power spectra from the gravitational effects of an inflationary PMF with $n_B = - 2.9$ (red) and a causally generated PMF with $n_B = 2$ (blue), in comparison to those of the primordial tensor perturbation of the Starobinsky model of inflation with $r = 0.0461$ (solid black)~#cite(<starobinsky:1980>) and gravitational lensing (dotted). The amplitudes of the PMF curves are chosen to match the current limits, $B ( 1 thin "Mpc" ) = 2$ nG and 0.003 nG for $n_B = - 2.9$ and 2, respectively. The blue shaded regions show the expected constraints
from #emph[LiteBIRD], derived in Sect. #ref(<ss:forecasts_fg_cleaning>, supplement: none) The inset shows the power spectra up to higher multipoles.
  ]
)
<fig:pmf>


For the first effect, the study in Ref.~@paoletti-finelli:2019 shows how 's $B$-mode power spectrum can improve upon the constraints on the amplitude of a stochastic background of PMFs, and how in combination with future ground-based experiments it can reach the nG-level field strength for a nearly scale-invariant spectrum ($n_B = - 2.9$), and sub-pG level for causally generated fields ($n_B = 2$). However, since the gravitational contribution of PMFs to the $B$-mode power spectrum can be degenerate with those of primordial gravitational waves and
lensing in the multipole range probed by ~@renzi-etal:2018@paoletti-finelli:2019 (see @fig:pmf), we can use higher-order correlations (i.e., non-Gaussianity) to further constrain PMFs. Using 's $B$-mode information, the sensitivity to the magnetized tensor bispectrum is improved by more than two orders of magnitude compared to the #emph[Planck] results, yielding a 1-nG-level constraint~#cite(<shiraishi:2019>). For the second effect, #emph[LiteBIRD]'s cosmic-variance-limited measurement of $E$ modes at low and intermediate multipoles (@ss:tau) will
significantly tighten the constraints on the post-recombination heating due to PMFs~@kunze-komatsu:2015@chluba-etal:2015@paoletti-etal:2019, going beyond the nG-level constraints. For the third effect, #emph[LiteBIRD] can target Faraday rotation with its unique frequency dependence, $nu^(- 2)$, which can be used to cross-check the PMF constraints from the $B$- and $E$-mode spectra. In particular, using the Faraday rotation angle power spectrum, #emph[LiteBIRD] can improve upon the limit on the amplitude of a nearly scale-invariant PMF by more than an
order of magnitude, reaching the nG threshold, provided that the contamination of Faraday rotation from our Galaxy is properly modeled~@pogosian-etal:2019.


While simultaneous analyses of all of these effects have not been performed in the literature, it is possible that the combination of all information can push the limit down to the 0.1-nG level robustly for a power spectrum with power-law index $n_B = - 2.9$. A comprehensive analysis of the forecasts for #emph[LiteBIRD] including all these effects is left for future work.


== Elucidating Spatial Anomalies with Polarization
<ss:anomaly>


A 6-parameter cosmological model seems to explain the observed structure of the CMB in remarkable detail~@Planck2013XVI @Planck2015XIII #cite(<Planck2018VI>). Nevertheless, there exist some features in the data that exert a mild tension against such a model, potentially providing hints of new physics to be explored. Below, we summarize the most important of these spatial "anomalies," found at modest levels of statistical significance (i.e., $2$--$3 thin sigma$) in the #emph[WMAP]~and #emph[Planck] temperature data~@Bennett2010 @Planck2013XXII @Planck2015XX #cite(<Planck2018X>)


+ #emph[Low-$ell$ power deficit (low variance)]. A simple statistical measure of the data is afforded by the variance of the signal as a function of angular scale. Analysis of low resolution maps reveals a lack of variance when compared to simulations based on the best-fit cosmological model. The map-based variance is dominated by contributions from large-angular scales on the sky, whereas the cosmological parameter fits are insensitive to these modes and mostly determined by scales corresponding to $ell > 50$. The dearth of large-angular-scale power in
the #emph[Planck] power spectrum for $ell < 30$ results in an apparently anomalous variance, with a $p$-value (the probability that simulations yield a lower value than the data) of order 1 %.


#emph[Lack of correlation on large angular scales.] A lack of structure in the angular two-point correlation function is observed for angular separations larger than $60^compose$, with the observed values lying close to zero between $tilde.eq thin 60^compose$ and $tilde.eq thin 170^compose$. This is captured by the use of a posteriori statistic, $S_(1 \/ 2)$, as proposed by the #emph[WMAP]~team and given by the integral of the squared correlation function for angular separations larger than $60^compose$. A corresponding $p$-value of less than 1 % was
determined from the 2018 #emph[Planck] data.


#emph[Alignments of low multipole moments.] Detections of the alignment of the quadrupole and octupole moments of the CMB temperature distribution have been found since #emph[WMAP]'s first release. This is somewhat surprising, given that the temperature anisotropies are expected to have random phases in the standard cosmological model, implying that the multipole moments should be uncorrelated. The analysis in Ref.~@Planck2013XXII finds that the quadrupole and octupole orientations are aligned to within about $10^compose$, with a $p$-value lower than 1 %.


#emph[Hemispherical asymmetry.] The standard cosmological model predicts that the same power spectrum should be measured in different patches of the sky, except for variations connected with sample variance. However, #emph[WMAP]~and #emph[Planck] data show evidence for a hemispherical asymmetry (or dipolar modulation) of power in a particular direction. For the #emph[Planck] data in particular, several methods to test for such asymmetry have been applied and compared @Planck2015XX ~#cite(<Planck2015XX>) #cite(<Planck2018X>). These are sensitive to either
amplitude, directionality, or both, although they do differ in terms of their weighting of power on different scales. Nevertheless, the results are all consistent with a modulation of power of around 7 % between two hemispheres defined by the preferred direction $( l , b ) = ( 209^compose , - 15^compose )$, extending over scales to $ell_("max") tilde.eq 60$ with a significance approaching $3 thin sigma$. Interestingly, one such test, based on the anomalous clustering of directions within bands of multipoles, suggests that this asymmetry holds even to
relatively small scales.


#emph[Parity asymmetry.] To test whether the CMB is symmetric with respect to reflections about the origin, $hat(n) arrow.r - hat(n)$, the CMB anisotropy field can be divided into symmetric and anti-symmetric functions with even and odd parity, corresponding to spherical harmonic modes with even and odd $ell$ values, respectively. On the largest angular scales, the Universe should be parity neutral, yet an odd-parity preference has been established from analysis of the #emph[WMAP]~and #emph[Planck] data sets. By computing the ratio between the sum of
even and sum of odd modes up to a given $ell_("max")$, it was found that the significance varies with the maximum multipole chosen, with $p$-values of about 1 % for $ell_("max") = 20$--30 #cite(<Planck2018X>)


#emph[Cold spot.] A particularly large cold region was originally discovered in the #emph[WMAP]~first-year data from the study of the kurtosis of smhw coefficients over a range of angular scales. It corresponds to an anomalous temperature feature in these coefficients on angular scales of $tilde.eq 10^compose$, with the structure centered at Galactic coordinates $( l , b ) = ( 210^compose , - 57^compose )$. Less than 1 % of simulations based on the standard $Lambda$CDM cosmological model yield a kurtosis at least as large as that seen in the
data~@Planck2015XX, with some dependence on a~posteriori choices.


Novel theories have been invoked to explain the cold spot, including the gravitational effect produced b y a collapsing cosmic texture.






A conservative explanation for these anomalies, given their claimed levels of significance, is that they are mild statistical excursions whose significance is overestimated due to the application of a posteriori statistics. However, whether this is the case, or, alternatively, that they reflect real physical properties of the Universe cannot be elucidated further using the temperature anisotropies, which are already cosmic-variance limited. Instead, new observations are needed that independently probe the fluctuations that source the temperature field.
Maps of the CMB polarization provide exactly such information.


The obvious premise is that much of the progress expected from #emph[LiteBIRD] in this area will stem from working with $E$-mode data (though statistical tests of the $B$-mode maps should also prove very valuable near the cosmic-variance limit). Indeed, #emph[LiteBIRD] should almost double the statistical information concerning these anomalies. Of course, given the modest significance of the temperature anomalies, high significance detections in polarization will still prove challenging; however, only an experiment like #emph[LiteBIRD] has the
possibility of providing statistically independent information on the largest scales.


The first comprehensive search for anomalies in polarization on large angular scales was presented in @Planck2018X. No definitive evidence was found in the polarization data for anomalous features corresponding to those observed in the temperature data. Nevertheless, several tests related to dipolar modulation showed hints of asymmetry on scales up to $ell_max thin tilde.eq thin 250$. More specifically, a variance asymmetry estimator found an alignment between the preferred directions of the temperature and $E$-mode dipolar modulation at a modest
significance. However, although residual systematics did not dominate the signal, as was the case for the 2015 polarization data set @Planck2015IX, it was apparent that the various tests of isotropy continued to be limited by their presence, as well as the dominance of noise over signal in the large-scale #emph[Planck]~polarization data. Indeed, a notable feature of the analyses was the variation in results with the four component-separated maps studied, presumably related to their different responses to noise and systematic residuals, and an incomplete
understanding of the noise properties of the data. Such effects should not be significant in the case of #emph[LiteBIRD] since the $E$-mode signal in particular is expected to be measured at close to the cosmic variance level, with the actual sensitivity defined by the sky fraction available for analysis.


A simple measure of whether ~$E$-mode data are approaching this level of sensitivity can be provided by the inferred error on $tau$, since in the sample-variance limit, this should be of order $0.002$. Estimates from parameter fits to simulated #emph[LiteBIRD] data for 70 % sky coverage and including foreground residuals related to component separation, indicate an error consistent with this expectation (see @ss:tau). Nevertheless, making inferences about the amplitude of anomalous features that might be observed in the #emph[LiteBIRD] polarization data
based on what is seen in temperature is non-trivial. Specifically, predictions must be based on models constructed in three-dimensional position space then propagated to spherical harmonic space. This mapping is different for temperature and polarization~#cite(<2017PhRvD..96l3522C>)


Despite extensive work, it remains the case that no theoretical model of primordial perturbations has been constructed that can explain all of the temperature anomalies. Hence we need to consider general approaches for testing the hints of anomalies in the temperature data. This can be achieved by comparing the distribution of a specific statistic in polarization built from constrained simulations (where the part of the $E$-mode anisotropy correlated with temperature is fixed by observations of the latter) with that constructed from unconstrained
realizations. For example, Ref.~@copi-etal:2013 used constraints from the #emph[WMAP]~7-year temperature power spectrum to compute such distributions for the $S$-statistic due to the cross-correlation between temperature and polarization. They determined that a value of the measured $S^(T Q)$ statistic over the angular separation range $\[ 48^compose , 120^compose \]$ exceeding the value 1.403 $mu K^4$ would allow the hypothesis to be ruled out at the 99 % confidence level. Similarly, @odwyer_Variance_2017 considered the variance of the polarization
amplitude when the $E$-mode signal is constrained by the ~2015 `SMICA` reconstruction of the CMB temperature anisotropy. In this case, the temperature data reveal an anomalously low variance in the northern Ecliptic hemisphere, but the constrained realizations show no evidence of a low amplitude variance in polarization. The measurement of such a signal would argue against the temperature anomaly being merely a statistical excursion.


Irrespective of our expectations, it remains important to search for characteristic signatures of spatial anomalies in the #emph[LiteBIRD] data, whether or not they are related to interesting features of the temperature field. Any detection of anomalies in the polarized sky signal will inevitably hint at physics beyond that captured by the standard model of cosmology.


== Galactic Astrophysics
<ss:galaxy>


Observations of Galactic polarization were among the main outcomes of the #emph[Planck]~space mission. Spectacular images combining the intensity of dust emission with the magnetic field orientation derived from polarization data (so called "drapery" patterns, also called "line integral convolution"~#cite(<CabralLeedom>)) have received worldwide attention and have become part of the general scientific culture~#cite(<Planck2015I>). Beyond this popular impact, the #emph[Planck]~polarization maps have represented a big step forward for Galactic
astrophysics~#cite(<Planck2018XII>). We anticipate a comparable breakthrough with #emph[LiteBIRD], which will provide full-sky maps of Galactic polarized emission with a sensitivity many times better than that of #emph[Planck], both for dust and synchrotron polarization. The data will complement the rich array of other polarization observations including: (1) stellar polarization surveys to be combined with #emph[Gaia] astrometry~#cite(<Tassis18>) to map Galactic dust polarization in 3D; (2) synchrotron observations, together with Faraday-rotation
measurements at radio wavelengths with the SKA and its precursors~#cite(<Haverkorn15>); and (3) ground-based CMB experiments that probe smaller angular scales over restricted parts of the sky with more modest frequency coverage~#cite(<Hensley21>) #cite(<CCAT-Prime:2021>). We now sketch out the expected contributions from #emph[LiteBIRD] to two main directions of Galactic research.


=== Magnetic Fields
<magnetic-fields>


Dust polarization probes the magnetic field orientation in dusty regions, mostly in the cold and warm neutral phases of the ism that account for the bulk of the gas mass and turbulent energy~#cite(<Hennebelle12>). Among the various means available to map the structure of interstellar magnetic fields, dust polarization is particularly good for tracing the dynamical interplay between magnetic fields, turbulence, and gravity in the ISM. This interplay helps define the structure of interstellar matter and star formation. The multiphase magnetized ISM is too
complex to be described by an analytic theory. Our understanding in this research field progresses through observations, mhd simulations, and phenomenological models. Spectroscopic observations obtained from ground-based telescopes give access to the gas column density and its kinematics. #emph[LiteBIRD] will provide complementary data about magnetic fields.


// [figvision-cn] imgs/LB_vs_PLCK_NBands_NH_thetabis.png
// 该图像为一张二维填充等高线图，展示了LiteBIRD卫星和
// Planck卫星在不同角尺度（横轴）和气体柱密度（纵轴）下能
// 够探测到尘埃偏振辐射的频段数量。 横轴表示角尺度θ，单位
// 为角分（arcmin），采用对数标度，范围从10^1到10^3，主刻
// 度线标记为10^1、10^2和10^3。纵轴表示氢原子柱密度N_Hi，
// 单位为10^20 cm^-2，同样采用对数标度，范围从10^-1到10^2，
// 主刻度线标记为10^-1、10^0、10^1和10^2。 图例位于图像右
// 侧，分为两部分： LiteBIRD部分：使用不同颜色的色块表示
// 能探测到的频段数量。颜色从深紫色/灰色过渡到浅紫色、绿
// 色、橙色、浅蓝色至深蓝色。具体对应关系如下： 数字“0”对
// 应白色背景，表示没有频段满足条件。 “1 > 356 GHz”对应深
// 灰色区域。 “2 > 286 GHz”对应中灰色区域。 “3 > 238 GHz”
// 对应浅灰色区域。 “4 > 199 GHz”对应淡紫色区域。 “5 >
// 165 GHz”对应深紫色区域。 “6 > 141 GHz”对应极浅绿色区域。
// “7 > 119 GHz”对应浅绿色区域。 “8 > 101 GHz”对应中绿色
// 区域。 “9 > 88 GHz”对应深绿色区域。 “10 > 79 GHz”对应
// 米色区域。 “11 > 69 GHz”对应浅橙色区域。 “12 > 60 GHz”
// 对应橙色区域。 “13 > 53 GHz”对应浅蓝色区域。 “14 > 42
// GHz”对应深蓝色区域。 图例中的文字格式为“数量 > 频率”，
// 例如“14 > 42 GHz”表示有14个频段的中心频率大于42GHz且满
// 足探测条件。 Planck部分：使用不同的纹理图案表示探测情
// 况，叠加在LiteBIRD的颜色之上。 点状图案（dots）：表示
// 仅在353 GHz频段检测到尘埃偏振（图注原文为“only at GHz”，
// 结合上下文及Planck频段推断应为353 GHz）。 星形图案（
// stars）：表示在217 GHz和353 GHz两个频段均检测到尘埃偏
// 振。 斜线阴影（hatches）：表示在三个频段（143, 217,
// 353 GHz）均检测到尘埃偏振。 图中包含三条红色虚线，分别
// 标记为P1、P2和P3，代表Planck卫星的三个观测通道或特定物
// 理模型边界。 P1线位于左上方，大致连接坐标(θ=20, N_Hi=
// 100)和(θ=40, N_Hi=20)。 P2线位于中间，大致连接坐标(θ=
// 40, N_Hi=20)和(θ=100, N_Hi=5)。 P3线位于右下方，大致连
// 接坐标(θ=100, N_Hi=5)和(θ=400, N_Hi=1)。 此外，图中还
// 有几条蓝色的实线和虚线作为等值线，标注了具体的数值“3”、
// “6”、“12”。 标有“3”的蓝色虚线位于左下角，穿过紫色区域。
// 标有“6”的蓝色虚线位于中部，穿过绿色区域。 标有“12”的蓝
// 色实线位于右上角，穿过橙色和蓝色区域交界处。 整体趋势
// 显示，随着角尺度θ的增加（从左向右）和气体柱密度N_Hi的
// 增加（从下向上），能够探测到尘埃偏振的频段数量逐渐增加。
// LiteBIRD在高频段（>100 GHz）具有更宽的覆盖范围和更高的
// 灵敏度，特别是在小角尺度和低柱密度区域，其探测能力优于
// Planck。Planck的探测区域主要集中在较大的角尺度和较高的
// 柱密度区域，且主要依赖于低频段（<150 GHz）。
#figure(image("imgs/LB_vs_PLCK_NBands_NH_thetabis.png", width: 110.0%),
  caption: [
    's spectral coverage and sensitivity to polarized dust emission at different angular scales. This plot shows how many #emph[LiteBIRD] bands will yield $S \/ N med 1$ as a function of gas column density and angular scale. For comparison, the same information is provided for #emph[Planck], with dots, stars, and hatches delineating regions where dust polarization is detected only at $353 thin$GHz, at both 217 and $353 thin$GHz, and at the three frequencies 143, 217 and $353 thin$GHz, respectively.
  ]
)
<fig:lb_vs_plck_Nbands>


LiteBIRD observations at its five highest frequencies, from 166 to 448 GHz, will improve on the #emph[Planck]~353-GHz sensitivity to dust polarization by an order of magnitude (@fig:lb_vs_plck_Nbands), increasing the dynamic range of observations by a comparable factor. While the analysis of dust polarization from the diffuse ISM at high Galactic latitudes with #emph[Planck]~has been limited to an effective angular resolution of 80 arcmin, #emph[LiteBIRD] has the required sensitivity to map almost the whole sky down to the 17.9 arcmin beam size at
402 GHz (@fig:lb_vs_plck_LIC). The interplay between magnetized turbulence and gas-phase transitions builds the structure of the ISM and seeds the formation of molecular gas; however, these processes are not well understood. #emph[LiteBIRD] will contribute unique polarization maps that will become the new gold standard for analyses of magnetic fields in the diffuse ISM and in the outskirts of nearby molecular clouds. In particular, we expect #emph[LiteBIRD] to reveal coherent magnetic structures that result from the nonlinear interplay between turbulent
gas motions and magnetic fields, and the dissipation of turbulence~#cite(<Wilkin07>) #cite(<Momferratos14>). Much of our current understanding of the turbulent energy cascade in the ISM derives from MHD simulations that are very far from reproducing its high magnetic Reynolds number~#cite(<Federrath16>). The #emph[LiteBIRD] data will be crucial to test how well these simulations match the observations.


Ongoing developments~#cite(<Allys19>) #cite(<Regaldo20>) #cite(<Regaldo21>) promise to yield powerful statistical tools for characterizing the #emph[LiteBIRD] dust data and its comparison with simulations, ultimately leading to improved simulations that fully describe the physical processes in our Galaxy. A specific scientific objective will be to elucidate the origin of parity violation (the TB correlation~@Planck2018XI) of polarized dust emission. Today with the #emph[Planck]~data, we cannot decide whether this is a generic feature of interstellar
turbulence rather than a random statistical fluctuation @clark-etal:2021.


LiteBIRD will improve on #emph[Planck]'s sensitivity to polarized synchrotron emission by a factor of 5 at 40 GHz. This gain will extend the range of scales over which the correlation between dust and synchrotron polarization is characterized ~#cite(<Choi15>) #cite(<PlanckIntXXIII>). More generally, the analysis of #emph[LiteBIRD] dust and synchrotron data will contribute to a community effort directed towards modelling of the 3D structure of the Galactic magnetic field ~#cite(<Imagine18>), in particular within the Solar neighbourhood.


// [figvision-cn] imgs/LB_vs_PLCK_353GHz_lIC_Equivalent_SN3_ter.png
// 该图包含两个并排的子图，分别展示了不同频率下的星际介质
// 尘埃偏振强度模拟图像。 左侧子图（a）： 类型：模拟数据
// 生成的二维热图（伪彩色图像）。 坐标轴：横轴为银经 l，
// 范围从 130°到 120°，刻度标记为 130°、125°0'0"、120°；
// 纵轴为银纬 b，范围从 28°到 40°，刻度标记为 28°、32°、
// 36°0'0"、40°。 物理含义与色标：图像颜色代表偏振强度（
// Polarized intensity），单位是 MJy/sr。右侧共用一个垂直
// 颜色条，数值范围从 0 到 0.14。颜色分布为：深红色对应低
// 值（接近0），依次过渡为橙色、黄色、绿色，高值区域为青
// 色和蓝色（接近0.14）。 图像内容：背景主要呈现深红色至
// 橙色的纤维状纹理结构。在图像下半部分（银纬约30°-34°，
// 银经约120°-126°之间）存在显著的亮斑聚集区，这些区域显
// 示为明亮的黄色、绿色及深蓝色点状或块状结构，表明此处偏
// 振强度较高。 标注文字：图像上方居中位置标注有“Planck
// 353 GHz”。 右侧子图（b）： 类型：模拟数据生成的二维热
// 图（伪彩色图像）。 坐标轴：横轴为银经 l，范围从 130°到
// 120°，刻度标记为 130°、125°0'0"、120°；纵轴为银纬 b，
// 范围从 28°到 40°，刻度标记为 28°、32°、36°0'0"、40°。
// 物理含义与色标：图像颜色代表偏振强度，单位与左图一致。
// 颜色映射逻辑与左图相同，深红色为低值，蓝/青色为高值。
// 图像内容：整体结构与左侧子图相似，均显示出弥漫的纤维状
// 纹理。但在左侧子图中明显的亮斑聚集区（下半部分），在此
// 图中表现为较平滑的绿色和黄色过渡区域，缺乏左图中那种极
// 高强度的深蓝色尖峰特征。 标注文字：图像上方居中位置标
// 注有“LiteBIRD 337 GHz”。 右侧共用组件： 类型：垂直颜色
// 条（Colorbar）。 标签：右侧垂直排列的文字为“Polarized
// intensity [MJy sr⁻¹]”。 刻度：数值从底部的 0 线性增加
// 到顶部的 0.14，中间刻度标记包括 0.02, 0.04, 0.06, 0.08
// , 0.1, 0.12。
#figure(image("imgs/LB_vs_PLCK_353GHz_lIC_Equivalent_SN3_ter.png", width: 130.0%),
  caption: [
    Dust polarization images. #emph[Left]: Simulated #emph[Planck]~353-GHz polarization intensity map of the diffuse ISM at high Galactic latitude computed with the model of @Vansyngel17, and centered close to the Polaris Flare~#cite(<Levrier18>). The local resolution is adjusted to guarantee $S \/ N med 3$ in polarization from pixel to pixel, spanning from 5 arcmin (in the brightest parts) to 140 arcmin (in the more diffuse regions). The lines represent the magnetic field orientation derived from the dust polarization angle and the colors show the dust
polarized intensity. #emph[Right]: Simulation of the 337-GHz #emph[LiteBIRD] polarization intensity map computed with the same model, at the native resolution of 20.9 arcmin, which guarantees $S \/ N med 3$ in the whole region.
  ]
)
<fig:lb_vs_plck_LIC>


=== Interstellar Dust
<interstellar-dust>


The analysis of the #emph[LiteBIRD] data will also yield the spectral characterization of Galactic polarization. The current description of the Galactic contribution to the #emph[Planck]~and #emph[WMAP]~polarization data as arising from two components, namely thermal dust emission and synchrotron~@Planck2018IV @Planck2018XI, is likely to prove inadequate for #emph[LiteBIRD]. By providing data at 15 frequency bands between 34 and 448 GHz #emph[LiteBIRD] will challenge our current understanding of Galactic emission. The gain is most significant for
studying the nature of dust grains and the origin of the so-called ame ~#cite(<Banday2003>) #cite(<PlanckIntXV>)


Interstellar dust is often modeled as a mixture of silicate and carbon grains, but polarization observations in emission provide a stringent test challenging existing models~#cite(<Guillet18>) #cite(<Hensley19>). The analysis of dust polarization at far-IR wavelengths obtained with the balloon-borne experiment BLASTPol~#cite(<Gandilo16>) and at microwave frequencies with #emph[Planck]~@Planck2018XI suggests that dust emission at long wavelengths is dominated by one single type of grain, the same for polarization as for total
intensity~#cite(<Draine2021>). Thanks to its sensitivity in many spectral bands (@fig:lb_vs_plck_Nbands), #emph[LiteBIRD] observations may unravel additional emission components. In particular, if silicates contain magnetic inclusions, or if free-flying magnetic grains are present, Galactic polarization may include a significant contribution from magnetic dipole emission~#cite(<Draine13>)


Dipole emission from spinning dust grains is thought to account for the AME; however, the nature of the carriers remains uncertain~#cite(<Dickinson18>). The competing hypotheses, namely polycyclic aromatic hydrocarbons, small silicates, and magnetic nanoparticles, differ in their predictions for the AME polarization~#cite(<Draine13>) #cite(<Hoang2013>) #cite(<Draine2016>) #cite(<Hoang2016>). A detection of AME polarization will thus constrain the nature of its carriers. The current limit on AME polarization from the diffuse ISM is set by the
cross-correlation between dust and synchrotron polarization~#cite(<PlanckIntXXII>). The #emph[LiteBIRD] data, combined with observations from the ground at lower frequencies from e.g., the C-BASS, QUIJOTE and S-PASS surveys ~#cite(<Jones18>) #cite(<Quijote21>) #cite(<S-PASS19>), promise to establish new constraints.


The emission properties of dust at long wavelengths have been shown by #emph[Planck]~to vary throughout the ISM~@Planck2013XI #cite(<PlanckIntXVII>). Likewise, the alignment efficiency depends on both the local physical conditions and the dust composition~#cite(<Hoang16>). Variations in dust emission properties and alignment efficiency are likely to be correlated with the density structure of the ISM, which in turn is known to be correlated with the magnetic field structure. These couplings break the simple assumption where the spectral frequency
dependence of the Galactic polarization and its angular structure on the sky are separable. If a line of sight intercepts multiple dust clouds with different spectral energy distributions and magnetic field orientations, the frequency scaling of each of the Stokes $Q$ and $U$ parameters of the thermal dust emission may be different. Evidence for this effect has been reported using #emph[Planck]~data #cite(<Pelgrims21>). In this context, the interpretation of #emph[LiteBIRD] data in terms of dust properties in polarization will need to be coupled with the
modeling of the 3D structure of the Galactic magnetic field.


= Potential Design Extensions and Synergies
<s:discussion>


== Possible Extension to the Baseline Mission Design -- Shifting the Highest Frequency Channel
<ss:extensions>


// [figvision-cn] imgs/hfsl_bias_and_sigma_lineplot.png
// 这是一张二维曲线图，展示了张量-标量比（r）的不确定度（
// 实线）和偏差（虚线）随 LiteBIRD 探测器最高频率变化的趋
// 势。 纵轴（Y轴）： 名称为 "r x 10^3"，表示张量-标量比
// r 的数值乘以 1000。刻度范围从 0.0 到 1.0，主刻度间隔为
// 0.2，标记值为 0.0, 0.2, 0.4, 0.6, 0.8, 1.0。 横轴（X轴）：
// 名称为 "LiteBIRD highest frequency"（LiteBIRD 最高频率）。
// 该轴包含一个定性标签和定量频率值。最左侧标记为 "
// Baseline"（基线配置），随后是等间距的频率刻度：440 GHz
// , 480 GHz, 520 GHz, 560 GHz, 600 GHz。根据图注描述，数
// 据实际覆盖范围是从 402 GHz 到 600 GHz。 图例与线条说明：
// 图中包含四种颜色的线条组合，分为两组颜色方案（蓝色系和
// 橙色系），每种颜色对应一种物理量类型（实线代表不确定度
// σ_r，虚线代表偏差 Bias）。 蓝色线条组（对应图例 "
// Baseline component separation"，即基线成分分离方案）：
// 蓝色实线（σ_r，不确定度）：在 "Baseline" 处起始于约
// 0.62。随着频率增加，该曲线缓慢下降，在 480 GHz 附近出
// 现轻微转折后继续平缓下降，至 600 GHz 时降至约 0.36。整
// 体呈下降趋势，表明提高频率有助于降低不确定度。 蓝色虚
// 线（Bias，偏差）：在 "Baseline" 处起始于约 0.30。随着
// 频率增加，该曲线起初缓慢上升，但在超过 480 GHz 后急剧
// 攀升。在 520 GHz 附近穿过蓝色实线和橙色实线，并在约
// 540 GHz 处突破纵轴上限 1.0。这表明在高频率下，基线方案
// 的系统偏差显著增大。 橙色线条组（对应图例 "
// High-resolution fit for T_d"，即高分辨率尘埃温度拟合方
// 案）： 橙色实线（σ_r，不确定度）：在 "Baseline" 处起始
// 于约 0.72，高于蓝色实线。随着频率增加，该曲线持续平稳
// 下降，在 600 GHz 时降至约 0.42。虽然始终高于蓝色实线，
// 但也显示出频率提升带来的不确定度降低效果。 橙色虚线（
// Bias，偏差）：在 "Baseline" 处起始于约 0.30，与蓝色虚
// 线起点相近。随着频率增加，该曲线先略微下降至 480 GHz
// 附近的最低点（约 0.25），随后极其缓慢地回升，在 600
// GHz 时约为 0.28。整体保持在较低水平且变化平缓，未出现
// 剧烈波动。 标注文字： 坐标轴标签及刻度数字已如上述。图
// 例位于图表底部中央区域，明确标识了实线代表 σ_r，虚线代
// 表 Bias，以及两种颜色分别代表的方案名称。 结论与趋势：
// 该图比较了两种数据处理方案在不同最高频率下的性能。蓝色
// 方案（基线成分分离）在低频段具有较低的不确定度，但随着
// 频率升高，其偏差迅速恶化，导致高信噪比测量失效。相比之
// 下，橙色方案（高分辨率尘埃温度拟合）虽然初始不确定度略
// 高，但其偏差在整个频率范围内保持极低且稳定，表现出更好
// 的鲁棒性，特别是在高频段（>480 GHz）避免了严重的系统误
// 差。
#figure(placement: top, image("imgs/hfsl_bias_and_sigma_lineplot.png", width: 80.0%),
  caption: [
    Tensor-to-scalar ratio uncertainty (solid lines) and bias (dashed lines) as a function of the maximum LiteBIRD frequency, ranging between 402 and 600 GHz. The blue line shows the performance of the component separation configuration discussed in @sec:component_separation or a similar one that fits the dust temerature at high resolution.
  ]
)
<fig:sigmar_vs_freq>


As discussed in @ss:overview_mission, the current #emph[LiteBIRD] focal-plane configuration results in a conservative mean Fisher uncertainty of $sigma ( r = 0 ) = sigma_r = 6.2 times 10^(- 4)$ after component separation, which conditionally satisfies the full-success criterion of $delta r < 10^(- 3)$, as defined in @ss:overview_project. A critical design feature of this configuration is a range for the central frequency bands between 40 and 402 GHz (34 and 448 GHz from the edge to edge of the bands), which is a compromise between maximizing our ability
to separate polarized foreground emission from CMB emission while still maintaining a lightweight and thermally efficient instrument. In addition, a relatively compact frequency range allows for good overlap between the three individual instruments, which is useful for internal cross-checks and systematics control.


Nevertheless, it is of great interest for the mission as a whole to reduce $sigma_r$ further in order to increase the margin for other types of systematic errors, both known and unknown. In this respect, we note that one of the dominant sources of uncertainty in the current configuration is a significant degeneracy between CMB and thermal dust emission. With the current focal-plane configuration, we find that statistical uncertainties in the thermal dust temperature (or, equivalently, the second derivative of the thermal dust SED) account for as much as
30--40 % of the total error bar on $r$ after component separation. One straightforward approach to decrease this uncertainty is to extend the overall frequency range to higher frequencies. The CMB spectral energy density (as measured in brightness density units) falls faster than exponentially above 300 GHz, while the thermal dust spectral energy density scales as $nu^1.5$. Even a very modest increase in the maximum frequency can therefore dramatically reduce degeneracies between these two components.


To explore this issue quantitatively, we are currently undertaking a detailed study of alternative extended #emph[LiteBIRD] focal planes, shifting the HFT range to higher frequencies, while leaving the LFT and MFT unchanged. For each configuration, the baseline HFT frequency range is multiplied by some constant factor, such that the ratio between the maximum and minimum frequencies is unchanged, which is essential for the HWP. We consider factors between 1.0 and 1.5 in steps of 0.1. A preliminary example of the outcomes from this study is shown in
@fig:sigmar_vs_freq, where we plot the bias (dashed lines) and uncertainty (solid lines) on the tensor-to-scalar ratio for the six different focal plane configurations as derived by `FGBuster`. While the bias is obtained maximizing the likelihood @eq:global-likelihood (with no systematic marginalized), the $sigma_r$ is a Fisher estimate. This choice allows a decoupling of the statistical uncertainty from the bias, providing two independent figures of merit to compare the instrumental configurations. The colors refer to two
component separation setups: the one discussed in @ss:overview_project; and a similar one that differs only for the resolution at which the thermal dust temperature is reconstructed ($N_("side")$ equal to 32, 16, and 16 instead of 8, 4, 0, see @tab:ThreeNsides). The sky model is the same as that employed in the analysis presented in @sec:component_separation, only evaluated at different frequencies.


We see that the statistical uncertainty drops rapidly when extending the frequency range from 400 to 480 GHz. The flip side is the rise in the bias due to the increased sensitivity to the spatial variations of $T_("d")$. However, increasing the degrees of freedom associated to $T_("d")$ in the fit keeps the bias under control while still improving the statistical constraints in most of the configurations analyzed. The outcomes of this study will be discussed in detail in a dedicated future paper. For now, we note that the statistical uncertainty is for
some #emph[LiteBIRD] configurations 20--30 % lower than for the nominal case. Going beyond 500 GHz, the incremental decrease slows down, and the reason for this is simply the exponential fall-off of the CMB spectrum; at 400 GHz there is still significant sensitivity to CMB fluctuations given the #emph[LiteBIRD] noise level, while at 500 GHz it has effectively vanished. Extending the frequency range further does give some additional sensitivity through better constraints on the thermal dust SED, but this is much slower due to the weak power-law dependence
of thermal dust, as compared to the super-exponential CMB spectrum. These results are independent of analysis pipelines, and we find that they apply equally to both blind and parametric component-separation methods (e.g., `Commander` and `GNILC`).


At the moment, the implications of these issues are being carefully considered by the full #emph[LiteBIRD] collaboration, from hardware through to parameter estimation. The main advantages of a slightly shifted focal plane are obvious, namely that the tensor-to-scalar uncertainty could be reduced by as much as 30 %, and our ability to reject a potentially false detection due to thermal dust mismodeling is greatly improved. A wider frequency range would also significantly increase the legacy value of the #emph[LiteBIRD] mission with respect to
ground-based $B$-mode and Galactic science experiments. However, there are also notable disadvantages associated with shifting the HFT to higher frequencies, the most important of which is a lack of frequency overlap between the MFT and HFT; this could turn out to be important for discovering unknown systematics in either of two instruments when the data actually arrive. A second important drawback of modifying the focal plane at this stage is purely programmatic, in that many current instrument designs would have to be revised if the focal plane is
modified, and this could result in a lower overall TRL. Thirdly, a higher maximum frequency would improve our sensitivity with respect to detailed thermal dust modeling. In the absolutely worst-case scenario in which it turned out to be impossible to model thermal dust emission at 500 GHz or above at the required level of precision, so that we would have to exclude the highest channel from the CMB analysis stage, the final uncertainty on the tensor-to-scalar ratio would #emph[increase] by $lt.tilde$ 5 % compared to the current baseline configuration, due
to slightly lower sensitivity in the overlap region between the MFT and HFT.


== Synergy with Other Projects
<synergy-with-other-projects>


The #emph[LiteBIRD] space mission has strong synergy with ground-based CMB polarization anisotropy experiments including SO, SPO, and CMB-S4. Given the small amplitude of the inflationary $B$-mode signal and the obscuring effects of foregrounds, lensing, and instrumental systematic uncertainties, having highly sensitive data from both #emph[LiteBIRD] and ground-based experiments will contribute to building confidence in the robustness of an inflationary signal detection. Furthermore, #emph[LiteBIRD] provides data on foregrounds at frequencies above the
highest frequency that will be observed by above-mentioned ground-based experiments (280 GHz), and the #emph[LiteBIRD] high-frequency data can be combined with $B$-mode data from the ground improving foreground separation. As well as #emph[LiteBIRD] augmenting ground-based experiments, CMB lensing data from the ground can be combined with #emph[LiteBIRD] data to improve the sensitivity of #emph[LiteBIRD] to primordial $B$ modes at the angular scales of the recombination peak.


Ground-based experiments generally focus on a relatively small region of sky, which has the benefit of giving high S/N per spatial mode but on a relatively low number of spatial modes. #emph[LiteBIRD], in contrast, will measure the entire sky and measure all the spatial modes that are available at moderate S/N. Both deep and wide observations can contribute to our understanding of foreground emission, which is essential in the search for inflationary $B$ modes. Deep measurements give a high S/N characterization of foreground emission, but only on a
relatively small region of the sky. 's measurement of the entire sky will probe the variability of the emission in different directions and test the fidelity of the model. There is a similar complementarity in terms of instrumental systematic uncertainties, where the high S/N per mode of ground-based measurements provides a deep probe for discovering weak systematic errors, whereas #emph[LiteBIRD] has the statistical power to measure many spatial modes, in addition to the advantage of making the observations in the benign and stable environment of space.
Finally, #emph[LiteBIRD] also has the unique ability to detect an inflationary signal at both the reionization peak (where gravitational lensing does not interfere) and at the recombination peak. A detection of a signal at both peaks would greatly increase confidence in these challenging measurements.


= Conclusions
<s:conclusions>


LiteBIRD will provide full-sky CMB polarization maps with unprecedented precision in 15 frequency bands between 34 and 448 GHz. These capabilities will enable #emph[LiteBIRD] to satisfy the basic science requirement on the tensor-to-scalar ratio, $delta r thin < thin 0.001$, by probing both the reionization and recombination bumps in the primordial $B$-mode power spectrum expected from inflationary models. This sensitivity level will lead to either detection of primordial gravitational waves or will rule out a large class of popular inflationary models,
yielding insights into physics at the very highest energies.


The #emph[LiteBIRD] Collaboration has more than 300 researchers from Japan, Europe, and North America, and has successfully completed the Pre-Phase-A2 concept development studies of #emph[LiteBIRD]. Table #ref(<tbl:specifications>, supplement: none) shows baseline specifications of the mission as the result of these studies.

#figure(
  align(center)[#table(
    columns: 2,
    align: (left,left,),
    table.header([Item], [Specification],),
    table.hline(),
    [Science requirement], [$delta r < 0.001$ for $2 lt.eq ell lt.eq 200$],
    [Target launch year], [2029],
    [Launch vehicle], [JAXA H3],
    [Observation type], [All-sky CMB surveys],
    [Observation time], [3 years],
    [Orbit], [L2 Lissajous orbit],
    [Scan and], [$dot.op$ Spin and precession (prec.~angle $alpha = 45^compose$, spin angle $beta = 50^compose$)],
    [data recording], [$dot.op$ Spin period = 20 minutes, precession period = 3.2058 hours],
    [], [$dot.op$ PMU revolution rate = 46/39/61 rpm for LFT/MFT/HFT],
    [], [$dot.op$ Sampling rate = 19.1 Hz],
    [Observing frequencies], [34--448 GHz],
    [Number of bands], [15],
    [Polarization sensitivity], [$2.2 thin mu$K-arcmin (after 3 years)],
    [Angular resolution], [$0.5^compose$ at 100 GHz (FWHM for LFT)],
    [Mission instruments], [$dot.op$ Superconducting detector arrays],
    [], [$dot.op$ Crossed-Dragone mirrors (LFT)],
    [], [\+ two refractive telescopes (MFT and HFT)],
    [], [$dot.op$ PMU with continuously-rotating HWP on each telescope],
    [], [$dot.op$ 0.1-K cooling chain (ST/JT/ADR)],
    [Data size], [$17.9 thin "GB" thin "day"^(- 1)$],
    [Mass], [2.6 t],
    [Power], [3.0 kW],
  )],
  caption: [Main specifications of #emph[LiteBIRD]. Parameters are from the #emph[LiteBIRD] pre-phase-A2 concept development studies and additional studies in 2020, as preparation for the system-requirements review.],
  kind: table
) <tbl:specifications>


#emph[LiteBIRD] is a mission that will set the course for the future of cosmology. There are many different inflationary models under active discussion, which predict different values of $r$. Among them, there are well-motivated inflationary models that predict $r > 0.01$~@kamionkowski-kovetz:2016. Since our requirement is $delta r < 0.001$, we can provide more than $10 thin sigma$ detection significance for these models. On the other hand, if #emph[LiteBIRD] finds no primordial $B$ modes and obtains an upper limit on $r$, this limit should be stringent
enough to set severe constraints on the physics of inflation. As discussed in Ref.~#cite(<Linde:2016hbb>), if we obtain an upper limit at $r tilde.eq 0.003$, we can completely rule out one important category of models, namely any single-field model in which the characteristic field-variation scale of the inflaton potential is greater than the reduced Planck mass.


Once we carry out the observations successfully, we can use #emph[LiteBIRD] data to study many additional topics in cosmology, particle physics, and astronomy. Examples include: (1) statistical characterization of large-scale $B$ modes and $E$ modes, including tests of scale-invariance and non-Gaussianity; (2) investigation of possible power-spectrum features in polarization; (3) sample-variance-limited measurements of large-scale (low $ell$) $E$ modes, with implications for the reionization history and the sum of neutrino masses; (4) searches for cosmic
birefringence and parity violation; (5) maps of cosmological hot gas through the Sunyaev-Zeldovich effects and relativistic corrections; (6) elucidation of large-angle anomalies in polarization; and (7) Galactic astrophysics. #emph[LiteBIRD] has very focused mission requirements, and at the same time will provide rich scientific outcomes.


#heading(level: 1, numbering: none)[Acknowledgment]
<acknowledgment>
This work is supported in Japan by ISAS/JAXA for Pre-Phase A2 studies, by the acceleration program of JAXA research and development directorate, by the World Premier International Research Center Initiative (WPI) of MEXT, by the JSPS Core-to-Core Program, and by JSPS KAKENHI. The Italian #emph[LiteBIRD] phase A contribution is supported by the Italian Space Agency (ASI Grants No. 2020-9-HH.0 and 2016-24-H.1-2018), the National Institute for Nuclear Physics (INFN), the National Institute for Astrophysics (INAF), and a PGR grant from the Italian Ministry
of Foreign Affairs and International Cooperation. The French #emph[LiteBIRD] phase A contribution is supported by the Centre National d'Etudes Spatiale (CNES), by the Centre National de la Recherche Scientifique (CNRS), and by the Commissariat à l'Energie Atomique (CEA). The Canadian contribution is supported by the Canadian Space Agency. The US contribution is supported by NASA grant no. 80NSSC18K0132. Norwegian participation in #emph[LiteBIRD] is supported by the Research Council of Norway (Grant No. 263011). The Spanish #emph[LiteBIRD] phase A
contribution is supported by the Spanish Agencia Estatal de Investigación (AEI), project refs. PID2019-110610RB-C21 and AYA2017-84185-P. Funds that support the Swedish contributions come from the Swedish National Space Agency (SNSA/Rymdstyrelsen) and the Swedish Research Council (Reg. no. 2019-03959). The German participation in #emph[LiteBIRD] is supported in part by the Excellence Cluster ORIGINS, which is funded by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany's Excellence Strategy (Grant No. EXC-2094 -
390783311). #emph[LiteBIRD] work has received funding from the European Research Council (ERC) under the Horizon 2020 Research and Innovation Programme. This research used resources of the Central Computing System owned and operated by the Computing Research Center at KEK, as well as resources of the National Energy Research Scientific Computing Center, a DOE Office of Science User Facility supported by the Office of Science of the U.S. Department of Energy.


#heading(level: 1, numbering: none)[Glossary]
#block(inset: (left: 51.65pt))[
#grid(columns: (70.7pt, 1fr), column-gutter: 0pt, row-gutter: 0pt,
  [ΛCDM], [Λ cold dark matter.],
  [2-K JT], [Joule-Thomson 1.75-K cooled stage.],
  [4-K JT], [Joule-Thomson 4.8-K cooled stage.],
  [ADC], [analog-to-digital converter.],
  [ADR], [adiabatic demagnetization refrigerator.],
  [AGN], [active galactic nuclei.],
  [AHWP], [achromatic half-wave plate.],
  [AIT], [assembly, integration, and testing.],
  [AIV], [assembly, integration, and veriﬁcation.],
  [AME], [anomalous microwave emission.],
  [AOCS], [attitude orbit-control system.],
  [ARC], [anti-reﬂection coating.],
  [BAO], [baryonic accoustic oscillation.],
  [BBM], [breadboard model.],
  [CATR], [compact antenna test range.],
  [CEA], [French Alternative Energies and Atomic Energy Com- mission.],
  [CFRP], [carbon ﬁber reinforced plastic.],
  [CIB], [cosmic infrared background.],
  [CL], [conﬁdence level.],
  [CMB], [cosmic microwave background.],
  [CMB-S4], [CMB Stage-4.],
  [CRE], [cold readout electronics.],
  [CRU], [cryogenic readout units.],
  [CVCM], [collected volatile condensable material.],
  [DA], [digitizer assembly.],
  [DESI], [Dark Energy Spectroscopic Instrument.],
  [DfMux], [digital frequency-domain multiplexing.],
  [EBEX], [E and B EXperiment.],
  [ECC], [error-correcting codes.],
  [EoR], [epoch of reionization.],
  [ESA], [European Space Agency.],
  [FLRW], [Friedmann-Lemaˆıtre-Robertson-Walker.],
  [FoV], [ﬁeld of view.],
  [FP], [focal plane.],
  [FPGA], [ﬁeld-programmable gate array.],
  [FPH], [focal-plane hood.],
  [FPM], [focal-plane module.],
  [FPS], [focal-plane structure.],
  [FPU], [Focal-Plane Unit.],
  [FSL], [far sidelobe.],
  [FTS], [Fourier-transform spectrometer.],
  [FWHM], [full width at half maximum.],
  [GREAT], [GRound station for deep space Exploration And Tele- communication.],
  [HAU], [housekeeping acquisition unit.],
  [HF-FPU], [High-Frequency Focal-Plane Unit.],
  [HFT], [High-Frequency Telescope.],
  [HWP], [half-wave plate.],
  [HWPSS], [HWP synchronous signal.],
  [IMo], [instrument model.],
  [IP], [instrumental polarization.],
  [IRU], [inertial reference unit.],
  [ISM], [interstellar medium.],
  [JAXA], [Japan Aerospace Exploration Agency.],
  [JT], [Joule-Thomson.],
  [LF-FPU], [Low-Frequency Focal-Plane Unit.],
  [LFT], [Low-Frequency Telescope.],
  [LSST], [Legacy Survey of Space and Time.],
  [MDPU], [mission data processing unit.],
  [MF-FPU], [Mid-Frequency Focal-Plane Unit.],
  [MFT], [Mid-Frequency Telescope.],
  [MHD], [magnetohydrodynamic.],
  [MHFT], [Mid- and High-Frequency Telescopes.],
  [ML], [maximum-likelihood.],
  [MW], [momentum wheel.],
  [NASA], [National Aeronautics and Space Administration.],
  [NEP], [noise-equivalent power.],
  [NET], [noise-equivalent temperature.],
  [PCD], [pre-cooler driver.],
  [PLM], [Payload Module.],
  [PMF], [primordial magnetic ﬁeld.],
  [PMU], [polarization modulator unit.],
  [PP], [polypropylene.],
  [PSF], [point spread function.],
  [PTFE], [poly-tetraﬂuoroethane.],
  [RCS], [reaction control system.],
  [RCWA], [rigorous coupled-wave analysis.],
  [RF], [radio-frequency.],
  [SAA], [SQUID array ampliﬁer.],
  [SAP], [solar array panel.],
  [SCA], [SQUID controller assembly.],
  [SCU], [SQUID Controller Unit.],
  [SED], [spectral energy distribution.],
  [SKA], [Square Kilometer Array.],
  [SMB], [superconducting magnetic bearing.],
  [SMHW], [spherical Mexican-hat wavelet.],
  [SO], [Simons Observatory.],
  [SPA], [signal-processing assembly.],
  [SPO], [South Pole Observatory.],
  [SPU], [signal-processing unit.],
  [STT], [star tracker.],
  [Sub-K ADR], [adiabatic demagnetization refrigerator that cools the sub-kelvin stages.],
  [SVM], [Service Module.],
  [SZ], [Sunyaev-Zeldovich.],
  [TES], [transition-edge sensor.],
  [TML], [total mass loss.],
  [TMR], [triple modular redundancy.],
  [TOAST], [Time-Ordered Astrophysics Scalable Tools.],
  [TOD], [time-ordered data.],
  [TOO], [target-of-opportunity.],
  [TRL], [Technology Readiness Level.],
  [USC], [Uchinoura Space Center.],
  [UV], [ultra-violet.],
  [VNA], [vector network analyzer.],
  [WE], [warm electronics.],
  [WHIM], [warm-hot intergalactic medium.],
)
]

#pagebreak()


#{
  set text(size: 9pt)
  set par(leading: 0.565em)
  bibliography("refs.bib", style: "american-institute-of-physics", title: [References])
}