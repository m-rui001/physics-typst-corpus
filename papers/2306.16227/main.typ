#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 1.30cm, right: 1.30cm, top: 2.01cm, bottom: 2.87cm), columns: 2)
#set page(header-ascent: 16pt, header: context {
  let n = counter(page).get().first()
  if n > 1 {
    let mid = if calc.odd(n) [EPTA+InPTA: GWB Interpretation] else [A&A proofs: manuscript no. eptaDR2_interpretation]
    align(center, text(9pt, mid))
  }
})
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 0.77em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.44em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9pt)

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(16.4pt, weight: "bold", [The second data release from the European Pulsar Timing Array])   #v(1.2em)
    #text(8.5pt)[
  J. Antoniadis#super[1,2], P. Arumugam#super[3], S. Arumugam#super[4], P. Auclair#super[5], S. Babak#super[6], M. Bagchi#super[7,8], A.-S. Bak Nielsen#super[2,9], E. Barausse#super[10], C. G. Bassa#super[11], A. Bathula#super[12], A. Berthereau#super[13,14], M. Bonetti#super[15], E. Bortolas#super[15], P. R. Brook#super[16], M. Burgay, R. N. Caballero#super[17], C. Caprini#super[18,19], A. Chalumeau#super[15], D. J. Champion#super[2], S. Chanlaridis#super[1], S. Chen#super[20], I. Cognard#super[13,14], M. Crisostomi#super[10], S. Dandapat#super[21], D. Deb#super[7], S. Desai#super[22], G. Desvignes#super[2], N. Dhanda-Batra#super[23], C. Dwivedi#super[24], M. Falxa#super[6,13], F. Fastidio#super[15,25], I. Ferranti#super[6,15], R. D. Ferdman#super[26], A. Franchini#super[15], J. R. Gair#super[27], B. Goncharov#super[28,29], E. Graikou#super[2], J.-M. Grießmeier#super[13,14], A. Gualandris#super[25], L. Guillemot#super[13,14], Y. J. Guo#super[2], Y. Gupta#super[30], S. Hisano#super[31], H. Hu#super[2], F. Iraci#super[32], D. Izquierdo-Villalba#super[15], J. Jang#super[2], J. Jawor#super[2], G. H. Janssen#super[11,33], A. Jessner#super[2], B. C. Joshi#super[3,30], F. Kareem#super[34,35], R. Karuppusamy#super[2], E. F. Keane#super[36], M. J. Keith#super[37], D. Kharbanda#super[22], T. Khizriev, T. Kikunaga#super[31], N. Kolhe#super[38], M. Kramer#super[2,37], M. A. Krishnakumar#super[2,9], K. Lackeos#super[2], K. J. Lee#super[39,40], K. Liu#super[2], Y. Liu#super[9,40], A. G. Lyne#super[37], J. W. McKee#super[41,42], Y. Maan#super[30], R. A. Main#super[2], S. Manzini#super[6,15], M. B. Mickaliger#super[37], H. Middleton#super[16], A. Neronov#super[6,43], I. C. Niţu#super[37], K. Nobleson#super[44], A. K. Paladi#super[45], A. Parthasarathy#super[2], B. B. P. Perera#super[46], D. Perrodin, A. Petiteau#super[6,47], N. K. Porayko#super[2,15], A. Possenti, T. Prabu#super[48], K. Postnov#super[49,50], H. Quelquejay Leclere#super[6], P. Rana#super[21], A. Roper Pol#super[18], A. Samajdar, S. A. Sanidas#super[37], D. Semikoz#super[6], A. Sesana#super[15], G. Shaifullah#super[15], J. Singha#super[3], C. Smarra#super[10], L. Speri#super[27], R. Spiewak#super[37], A. Srivastava#super[22], B. W. Stappers#super[37], D. A. Steer#super[6], S. C. Susarla#super[51], A. Susobhanan#super[52], K. Takahashi#super[53,54], C. Tiburzi, R. J. Truant#super[15], E. van der Wateren#super[11,33], S. Valtolina#super[55], A. Vecchio#super[16], V. Venkatraman Krishnan#super[2], J. P. W. Verbiest#super[2,9,56], J. Wang#super[9,57,58], L. Wang#super[37]
    ]
    #v(0.6em)
    #text(7pt)[#grid(
      columns: (1fr, 1fr),
      column-gutter: 1.2em,
      [
      #super[1] Institute of Astrophysics, FORTH, N. Plastira 100, 70013, Heraklion, Greece \
      #super[2] Max-Planck-Institut für Radioastronomie, Auf dem Hügel 69, 53121 Bonn, Germany \
      #super[3] Department of Physics, Indian Institute of Technology Roorkee, Roorkee-247667, India \
      #super[4] Department of Electrical Engineering, IIT Hyderabad, Kandi, Telangana 502284, India \
      #super[5] Cosmology, Universe and Relativity at Louvain (CURL), Institute of Mathematics and Physics, University of Louvain, 2 Chemin du Cyclotron, 1348 Louvain-la-Neuve, Belgium \
      #super[6] Université Paris Cité, CNRS, Astroparticule et Cosmologie, 75013 Paris, France \
      #super[7] The Institute of Mathematical Sciences, C. I. T. Campus, Taramani, Chennai 600113, India \
      #super[8] Homi Bhabha National Institute, Training School Complex, Anushakti Nagar, Mumbai 400094, India \
      #super[9] Fakultät für Physik, Universität Bielefeld, Postfach 100131, 33501 Bielefeld, Germany \
      #super[10] Scuola Internazionale Superiore di Studi Avanzati: Via Bonomea 265, I-34136 Trieste, Italy and INFN Sezione di Trieste \
      #super[11] ASTRON, Netherlands Institute for Radio Astronomy, Oude Hoogeveensedijk 4, 7991 PD, Dwingeloo, The Netherlands \
      #super[12] Department of Physical Sciences, Indian Institute of Science Education and Research, Mohali, Punjab 140306, India \
      #super[13] Laboratoire de Physique et Chimie de l'Environnement et de l'Espace, Université d'Orléans / CNRS, 45071 Orléans Cedex 02, France \
      #super[14] Observatoire Radioastronomique de Nançay, Observatoire de Paris, Université PSL, Université d'Orléans, CNRS, 18330 Nançay, France \
      #super[15] Dipartimento di Fisica “G. Occhialini”, Universitá degli Studi di Milano-Bicocca, Piazza della Scienza 3, I-20126 Milano, Italy \
      #super[16] Institute for Gravitational Wave Astronomy and School of Physics and Astronomy, University of Birmingham, Edgbaston, Birmingham B15 2TT, UK \
      #super[17] Hellenic Open University, School of Science and Technology, 26335 Patras, Greece \
      #super[18] Université de Genève, Département de Physique Théorique and Centre for Astroparticle Physics, 24 quai Ernest-Ansermet, CH-1211 Genéve 4, Switzerland \
      #super[19] CERN, Theoretical Physics Department, 1 Esplanade des Particules, CH-1211 Genéve 23, Switzerland \
      #super[20] Kavli Institute for Astronomy and Astrophysics, Peking University, Beijing 100871, P. R. China \
      #super[21] Department of Astronomy and Astrophysics, Tata Institute of Fundamental Research, Homi Bhabha Road, Navy Nagar, Colaba, Mumbai 400005, India \
      #super[22] Department of Physics, IIT Hyderabad, Kandi, Telangana 502284, India \
      #super[23] Department of Physics and Astrophysics, University of Delhi, Delhi 110007, India \
      #super[24] Department of Earth and Space Sciences, Indian Institute of Space Science and Technology, Valiamala, Thiruvananthapuram, Kerala 695547,India \
      #super[25] School of Mathematics and Physics, Faculty of Engineering and Physical Science, University of Surrey, Guildford GU2 7XH, UK \
      #super[26] School of Physics, Faculty of Science, University of East Anglia, Norwich NR4 7TJ, UK \
      #super[27] Max Planck Institute for Gravitational Physics (Albert Einstein Institute), Am Mühlenberg 1, 14476 Potsdam, Germany \
      #super[28] Gran Sasso Science Institute (GSSI), I-67100 L'Aquila, Italy \
      #super[29] INFN, Laboratori Nazionali del Gran Sasso, I-67100 Assergi, Italy 
      ],
      [
      #super[30] National Centre for Radio Astrophysics, Pune University Campus, Pune 411007, India \
      #super[31] Kumamoto University, Graduate School of Science and Technology, Kumamoto, 860-8555, Japan \
      #super[32] Universitá di Cagliari, Dipartimento di Fisica, S.P. Monserrato-Sestu Km 0,700 - 09042 Monserrato (CA), Italy \
      #super[33] Department of Astrophysics/IMAPP, Radboud University Nijmegen, P.O. Box 9010, 6500 GL Nijmegen, The Netherlands \
      #super[34] Department of Physical Sciences, Indian Institute of Science Education and Research Kolkata, Mohanpur, 741246, India \
      #super[35] Center of Excellence in Space Sciences India, Indian Institute of Science Education and Research Kolkata, 741246, India \
      #super[36] School of Physics, Trinity College Dublin, College Green, Dublin 2, D02 PN40, Ireland \
      #super[37] Jodrell Bank Centre for Astrophysics, Department of Physics and Astronomy, University of Manchester, Manchester M13 9PL, UK \
      #super[38] Department of Physics, St. Xavier’s College (Autonomous), Mumbai 400001, India \
      #super[39] Department of Astronomy, School of Physics, Peking University, Beijing 100871, P. R. China \
      #super[40] National Astronomical Observatories, Chinese Academy of Sciences, Beijing 100101, P. R. China \
      #super[41] E.A. Milne Centre for Astrophysics, University of Hull, Cottingham Road, Kingston-upon-Hull, HU6 7RX, UK \
      #super[42] Centre of Excellence for Data Science, Artificial Intelligence and Modelling (DAIM), University of Hull, Cottingham Road, Kingston-upon-Hull, HU6 7RX, UK \
      #super[43] Laboratory of Astrophysics, École Polytechnique Fédérale de Lausanne, CH-1015 Lausanne, Switzerland \
      #super[44] Department of Physics, BITS Pilani Hyderabad Campus, Hyderabad 500078, Telangana, India \
      #super[45] Joint Astronomy Programme, Indian Institute of Science, Bengaluru, Karnataka, 560012, India \
      #super[46] Arecibo Observatory, HC3 Box 53995, Arecibo, PR 00612, USA \
      #super[47] IRFU, CEA, Université Paris-Saclay, F-91191 Gif-sur-Yvette, France \
      #super[48] Raman Research Institute India, Bengaluru, Karnataka, 560080, India \
      #super[49] Sternberg Astronomical Institute, Moscow State University, Universitetsky pr., 13, Moscow 119234, Russia \
      #super[50] Kazan Federal University, 18 Kremlyovskaya, 420008 Kazan, Russia \
      #super[51] Ollscoil na Gaillimhe --- University of Galway, University Road, Galway, H91 TK33, Ireland \
      #super[52] Center for Gravitation, Cosmology, and Astrophysics, University of Wisconsin-Milwaukee, Milwaukee, WI 53211, USA \
      #super[53] Division of Natural Science, Faculty of Advanced Science and Technology, Kumamoto University, 2-39-1 Kurokami, Kumamoto 860-8555, Japan \
      #super[54] International Research Organization for Advanced Science and Technology, Kumamoto University, 2-39-1 Kurokami, Kumamoto 860-8555, Japan \
      #super[55] Max Planck Institute for Gravitational Physics (Albert Einstein Institute), Leibniz Universität Hannover, Callinstrasse 38, D-30167, Hannover, Germany \
      #super[56] Florida Space Institute, University of Central Florida, 12354 Research Parkway, Partnership 1 Building, Suite 214, Orlando, 32826-0650, FL, USA \
      #super[57] Ruhr University Bochum, Faculty of Physics and Astronomy, Astronomical Institute (AIRUB), 44780 Bochum, Germany \
      #super[58] Advanced Institute of Natural Sciences, Beijing Normal University, Zhuhai 519087, China 
      ],
    )]

  ]
  #v(1.0em)

  #set text(size: 9pt)
// abshead
#align(center)[#text(8.5pt, weight: "bold")[ABSTRACT]]

  The European Pulsar Timing Array (EPTA) and Indian Pulsar Timing Array (InPTA) collaborations have measured a low-frequency common signal in the combination of their second and first data releases, respectively, with the correlation properties of a gravitational wave background (GWB). Such a signal may have its origin in a number of physical processes including a cosmic population of inspiralling supermassive black hole binaries (SMBHBs); inflation, phase transitions, cosmic strings, and tensor mode generation by the non-linear evolution of scalar perturbations in the early Universe; and oscillations of the Galactic potential in the presence of ultra-light dark matter (ULDM). At the current stage of emerging evidence, it is impossible to discriminate among the different origins. Therefore, for this paper, we consider each process separately, and investigated the implications of the signal under the hypothesis that it is generated by that specific process. We find that the signal is consistent with a cosmic population of inspiralling SMBHBs, and its relatively high amplitude can be used to place constraints on binary merger timescales and the SMBH-host galaxy scaling relations. If this origin is confirmed, this would be the first direct evidence that SMBHBs merge in nature, adding an important observational piece to the puzzle of structure formation and galaxy evolution. As for early Universe processes, the measurement would place tight constraints on the cosmic string tension and on the level of turbulence developed by first-order phase transitions. Other processes would require non-standard scenarios, such as a blue-tilted inflationary spectrum or an excess in the primordial spectrum of scalar perturbations at large wavenumbers. Finally, a ULDM origin of the detected signal is disfavoured, which leads to direct constraints on the abundance of ULDM in our Galaxy.
]

= Introduction <introduction>
The recent observation of a common signal with excess power in the nanohertz frequency ranges ~@ng12p5gwb-20 @gsr-2021@ccg-21 in pulsar timing array (PTA) datasets, with emerging evidence for quadrupolar correlations#footnote[Readers can refer to @wm3    for more details on inter-pulsar correlations.] opens a new era in the exploration of the Universe.

This important milestone has been achieved thanks to the efforts of the European Pulsar Timing Array @dcl-16, the Indian PTA @bgp-22, the North American Nanohertz Observatory for Gravitational Waves @mcl2013, the Parkes PTA @mhb-2013, and the Chinese PTA @2016ASPC..502...19L. Although the significance of the signal does not yet reach the 5 $sigma$ mark, which is generally accepted as the 'golden rule' for a firm detection claim, the evidence reported by the different collaborations ranges between $2 sigma$ and $4 sigma$ @wm3 @ng15yr @pptadr3 @cptadr1, strongly suggesting a genuine gravitational wave (GW) origin. Awaiting decisive confirmation within the International PTA @vlh-2016 @pdd-2019 framework, with the additional contribution of the MeerKAT PTA @2023MNRAS.519.3976M, we are hearing, for the first time, the faint murmur of the GW Universe at frequencies of 1-to-30 nano-Hz, which is ten orders of magnitude lower than the frequencies currently probed by ground-based interferometers @abb2016. This opens a completely new window onto the Universe, allowing us to look at different phenomena, probe new astrophysical and cosmological sources, and, potentially, new physics as well.

By monitoring an array of millisecond pulsars (MSPs) for decades with a weekly cadence, PTAs are sensitive to GWs in the $10^(- 9)$--$10^(- 7)$ Hz range @fb1990. At those frequencies, the most anticipated signal to be detected is a stochastic GW background (GWB) produced by the incoherent superposition of waves emitted by adiabatically inspiralling supermassive black hole binaries @fb1990. The signal manifests as a stochastic Gaussian process characterised by a power-law Fourier spectrum of delays-advances to pulse arrival times, with characteristic inter-pulsar correlations of general relativity identified by @hd1983. The statistical properties of the signal are expected to significantly deviate from the typical isotropy, Gaussianity and perhaps even stationarity that is typical of many stochastic signals from the early Universe @hd1983. In fact, due the shape of the SMBHB mass function and their redshift distribution, the overall signal is often dominated by a few sources, and particularly massive, nearby SMBHBs might result in loud enough signals to be individually resolved as continuous GWs @2009MNRAS.394.2255S @Babak:2011mr @2018MNRAS.477..964K emerging from the GWB. The exact amplitude and spectral shape of the spectrum are intimately related to the cosmological galaxy merger rate and to the dynamical properties of the emitting binaries forming in the aftermath of the merger process @2007PThPh.117..241E @2011MNRAS.411.1467K @2013CQGra..30v4014S @ses2013 @2014MNRAS.442...56R. Therefore, the demonstration of an SMBHB origin of the signal observed by PTAs provides invaluable insights into the formation, evolution, and dynamics of these objects. Moreover, it brings decisive evidence that SMBHBs merge in nature, thus overcoming the 'final parsec problem' @2003ApJ...596..860M, which is still an open question in our understanding of galaxy and structure formation.

Beyond SMBHBs, a number of processes (potentially) occurring in the early Universe can also produce a stochastic GWB at nanohertz frequencies. Tensor modes can be produced as early as during the first tiny fraction of a second after the Big Bang through quantum fluctuations of the gravitational field stretched by the accelerated expansion of inflation @1975JETP...40..409G @1982PhLB..115..189R @1985SvAL...11..133S @1983PhLB..125..445F @1984NuPhB.244..541A. In the literature, these GWs are referred to as 'primordial'. In this case, the shape of the power spectrum is defined by the specific model of inflation. Classical tensor mode production invoking the presence of a source term in the GW equation of motion can also take place in the early Universe. There are a plethora of physical processes that can lead to such a source term, and trigger the production of GWs. Topological defects, for example decaying cosmic string loops @2000csot.book.....V @2001PhRvD..64f4008D @2003PhLB..563....6J @2004JCAP...03..010D @2005PhRvD..71f3510D, particle production during inflation @2011JCAP...06..003S @2012PhRvD..86j3508B @2013JCAP...11..047C @2012PhRvD..85l3537A, (magneto-)hydrodynamic turbulence ((M)HD, Kamionkowski et al. 1994; Kosowsky et al. 2002; Dolgov et al. 2002; Caprini & Durrer 2006; Gogoberidze et al. 2007; Caprini et al. 2009), the collision of bubble walls during a first-order primordial phase transition @1992PhRvD..45.4514K @1993PhRvD..47.4372K @2008PhRvD..77l4015C @2008JCAP...09..022H @2017PhRvD..95b4009J @2018PhRvD..97l3513C, sound waves in the aftermath of a first-order phase transition @2014PhRvL.112d1301H @2015PhRvD..92l3009H @2017PhRvD..96j3520H, as well as scalar perturbations at second order in cosmological perturbation theory @2007PhRvD..76h4019B @2007PhRvD..75l3518A, are among the most commonly considered scenarios. GWs decouple from the rest of the matter and radiation immediately after their generation at essentially any temperature in the Universe, so that in the case of clear observational evidence for these types of signals, we can infer nearly unaltered information on the physical processes occurring during or just after the birth of the Universe @2018CQGra..35p3001C.

Contrary to the incoherent superposition of GWs from SMBHBs, the stochastic GWB from sources in the early Universe is usually assumed to be statistically homogeneous and isotropic, unpolarised, and Gaussian @Allen:1996vm @Maggiore:1999vm @2018CQGra..35p3001C  Statistical homogeneity and isotropy are inherited from the same property of the FLRW Universe. The absence of polarisation holds provided no macroscopic source of parity violation is present in the Universe. Gaussianity follows by the central limit theorem in most cases of GWBs generated by processes operating independently in many uncorrelated, sub-horizon regions. This also applies to the irreducible GWB generated during inflation in the simplest scenarios, when the tensor metric perturbation can be quantised as a free field, and hence with Gaussian probability distribution for the amplitude. There are, however, notable exceptions, among which for example rare GWB bursts from cosmic strings cusps and kinks @2000PhRvL..85.3761D @2001PhRvD..64f4008D, or the GWB from particle production during inflation @2000PhRvL..85.3761D @2001PhRvD..64f4008D @Cook:2013xea @Sorbo:2011rz @Anber:2012du. Therefore, although statistical properties might be useful for discriminating between SMBHBs and several processes in the early Universe, a full assessment of the nature of the GW signal will not be trivial.

Spatially correlated delays of the time of arrivals (TOAs) in an array of MSPs are not a unique imprint of GWs. For example, it is well known @thk-2016 that such delays can emerge due to the imperfect fitting of the solar system ephemerides (dipolar correlated noise), or due to a miscalibration of the time standard to which the measured TOAs are referred (monopolar correlated noise). Furthermore, individual Fourier harmonics of a common signal in PTA data may include contributions from the oscillations of the gravitational potential associated with the presence of ultralight dark matter #footnote[In the pulsar timing community, it is customary to refer to the dispersion measure with the acronym DM. Please note that in this paper, DM will exclusively stand for Dark Matter.], also known as #emph[fuzzy] dark matter (FDM), in the Galactic halo @Khmelnitsky_2014. The existence of ultralight scalars, generally motivated by string-theoretical frameworks @Green_1987 @Svrcek_2006 @Arvanitaki_2010, is also particularly appealing from the astrophysical and cosmological point of view. In fact, several potential issues in the small-scale structure of the Universe, such as the cusp vs core @Flores_1994 @Moore_1994 @Karukes_2015 @Klypin_1999 @Moore_1999 or the missing satellite @Klypin_1999 @Moore_1999 problems, could be disposed of or, at least, mitigated assuming that dark matter is made of ultralight particles. As predicated by @Khmelnitsky_2014, the presence of ULDM induces harmonic delays in the arrival times, with a frequency proportional to the ultralight boson mass.

In this paper, we provide a broad overview of the implications of the signal observed in the second data release of the EPTA+InPTA @wm1 for the different physical processes mentioned above. More in-depth analysis of several of these scenarios will be the subject of separate future publications. Unless otherwise stated, we consider each process separately, and we discuss the implications of the detected signal under the hypothesis that it is generated by that specific process. We do not attempt any Bayesian model selection on the signal origin, although a general framework for that is being developed @2021NatAs...5.1268M. The main reason for this choice is that, at this stage of data taking and analysis, the information carried by the signal is not particularly constraining; the evidence of the measurement is still at $approx 3 sigma$, and the amplitude and spectral shape of the signal are not very well measured. With these premises, the result of any model selection is bound to be severely influenced by the priors employed for each of the models under examination. This exercise becomes more meaningful as data get more informative, which we strive to achieve with the analysis of the third release of the combined IPTA data, which is now being assembled.

The paper is organised as follows. In @sec:data, we describe the signal observed by EPTA+InPTA and its main features, including its free spectrum and best-fit parameters. We then proceed with detailing the main implications of the detected signals under the assumption that it is generated by a cosmic population of SMBHBs (@sec:SMBHBs) or by a number of processes occurring in the early Universe (@sec:early_universe). In @sec:dark_matter, we investigate the compatibility of the observed signal with a DM origin and place constraints on ULDM candidates. Finally, in @sec:conclusions, we summarise our main results and discuss future prospects.

= The observed signal in the EPTA DR2 dataset <sec:data>

// [figvision-cn] imgs/fig_EPTAfreespec.png
// 这是单幅图，没有 a、b 等子图标记。图由左右两个面板组成，
// 图注分别对应左面板的“自由谱”和右面板的“联合后验分布”。
// 需要特别指出：所提供的图像裁剪不完整，右侧面板（关于 γ
// 和 A 的二维后验）在图像中被截掉了，完全没有显示。以下
// 仅描述可见的左面板。 左面板是一张曲线图，图类型为带每
// 个频点后验分布的频谱图。纵轴名称为“log10 (RMS/seconds)
// ”，范围从 -9.5 到 -5.5，主刻度间隔 0.5，单位是秒的常用
// 对数。横轴名称为“f [Hz]”，横轴采用对数刻度，可见的主刻
// 度只有 10^-8，可见范围约从 4×10^-9 到 3×10^-7 Hz。 图
// 中数据由若干橙色填充的“小提琴”形核密度估计图组成，代表
// 每个频率分辨率 bin 中由超额相关信号引起的 RMS 的后验分
// 布。这些 bin 的宽度在标注中定义为数据时间跨度的倒数，
// 即频率分辨率。图中可见约 14 个 bin，分别位于约 5×10^-9、
// 7×10^-9、1.5×10^-8、3×10^-8、5×10^-8、7×10^-8、9×10^-8、
// 1.1×10^-7、1.4×10^-7、1.7×10^-7、2×10^-7、2.3×10^-7、
// 2.6×10^-7、3×10^-7 Hz 附近。每个小提琴图的宽度表示概率
// 密度，所有分布都延伸到图的下边界 -9.5，即这些 bin 只有
// 上限，或者后验分布的下尾被截断。 一条橙色实线从约 5×10
// ^-9 Hz 处的 log10(RMS) ≈ -6.6 穿过各频段，线性下降至约
// 2×10^-7 Hz 处的 log10(RMS) ≈ -7.9，这是对自由谱数据的
// 最佳幂律拟合直线；在双对数坐标中为直线，表示 RMS 随频
// 率增加而下降。 图中有一条垂直黑色虚线，位于 f ≈ 3.15×
// 10^-7 Hz 处，图例中标注为“f = 1/yr”，对应一年周期的频
// 率。 图例位于左面板左下角，包含两项：黑色虚线标注“f =
// 1/yr”；橙色填充块标注“EPTA DR2new”。 该子图传达的趋势
// 和结论是：由 EPTA DR2new 数据得到的超额相关信号的 RMS
// 随频率升高呈幂律下降，与一条直拟合线一致；最高频段接近
// 1/yr 的垂直虚线指示该分析关注年周期附近的行为，而右侧
// 的二维联合后验图在此裁剪中缺失。
// [figvision-cn] imgs/fig_EPTAfreespec.png
// 这是单幅图，没有 a、b 等子图标记。图由左右两个面板组成，
// 图注分别对应左面板的“自由谱”和右面板的“联合后验分布”。
// 需要特别指出：所提供的图像裁剪不完整，右侧面板（关于 γ
// 和 A 的二维后验）在图像中被截掉了，完全没有显示。以下
// 仅描述可见的左面板。 左面板是一张曲线图，图类型为带每
// 个频点后验分布的频谱图。纵轴名称为“log10 (RMS/seconds)
// ”，范围从 -9.5 到 -5.5，主刻度间隔 0.5，单位是秒的常用
// 对数。横轴名称为“f [Hz]”，横轴采用对数刻度，可见的主刻
// 度只有 10^-8，可见范围约从 4×10^-9 到 3×10^-7 Hz。 图
// 中数据由若干橙色填充的“小提琴”形核密度估计图组成，代表
// 每个频率分辨率 bin 中由超额相关信号引起的 RMS 的后验分
// 布。这些 bin 的宽度在标注中定义为数据时间跨度的倒数，
// 即频率分辨率。图中可见约 14 个 bin，分别位于约 5×10^-9、
// 7×10^-9、1.5×10^-8、3×10^-8、5×10^-8、7×10^-8、9×10^-8、
// 1.1×10^-7、1.4×10^-7、1.7×10^-7、2×10^-7、2.3×10^-7、
// 2.6×10^-7、3×10^-7 Hz 附近。每个小提琴图的宽度表示概率
// 密度，所有分布都延伸到图的下边界 -9.5，即这些 bin 只有
// 上限，或者后验分布的下尾被截断。 一条橙色实线从约 5×10
// ^-9 Hz 处的 log10(RMS) ≈ -6.6 穿过各频段，线性下降至约
// 2×10^-7 Hz 处的 log10(RMS) ≈ -7.9，这是对自由谱数据的
// 最佳幂律拟合直线；在双对数坐标中为直线，表示 RMS 随频
// 率增加而下降。 图中有一条垂直黑色虚线，位于 f ≈ 3.15×
// 10^-7 Hz 处，图例中标注为“f = 1/yr”，对应一年周期的频
// 率。 图例位于左面板左下角，包含两项：黑色虚线标注“f =
// 1/yr”；橙色填充块标注“EPTA DR2new”。 该子图传达的趋势
// 和结论是：由 EPTA DR2new 数据得到的超额相关信号的 RMS
// 随频率升高呈幂律下降，与一条直拟合线一致；最高频段接近
// 1/yr 的垂直虚线指示该分析关注年周期附近的行为，而右侧
// 的二维联合后验图在此裁剪中缺失。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Fig. #context it.counter.display(it.numbering): #it.body]
}

#figure(scope: "parent", placement: top, [#box(image("imgs/fig_EPTAfreespec.png", width: 50.0%)) #box(image("imgs/fig_corner_EPTADR2.png", width: 40.0%))

  ],
  caption: [
    Properties of the common correlated signal detected in `DR2new`. Left panel: free spectrum of the RMS induced by the excess correlated signal in each frequency resolution bin (with width defined by the inverse of the data span, $Delta f = T^(- 1)$). The straight line is the best power-law fit to the data. Right panel: joint posterior distribution in the $A - gamma$ plane. #emph[Note that we normalise $A$ to a pivotal frequency $f_0=10"yr"^(-1)$.]
  ]
) <fig:EPTADR2>

Our investigation is based on the results reported in #cite(<wm3>, form: "prose", supplement: [hereinafter PaperIII]), which analyses the data of 25 MSPs collected by the EPTA using five of the largest radio telescopes in Europe: the Lovell telescope at the Jodrell Bank Observatory, the Nançay decimetric radio telescope, the Westerbork synthesis radio telescope, the Effelsberg 100 m radio telescope, and the Sardinia radio telescope. The dataset also includes the Large European Array for Pulsars (LEAP) data, in which individual telescope observations are coherently phased to form an equivalent dish with a diameter of up to 194 m @bjk-16. These data are complemented by low-frequency observations of a subset of 10 MSPs performed by the InPTA using the upgraded Giant Metrewave Radio Telescope (uGMRT) and covering about 3.5 years.

The data of each individual pulsar are combined as described in @wm1 and the noise properties of each pulsar are then extracted according to the optimised custom noise models presented in @wm2. The final result is a dataset of unprecedented sensitivity spanning up to 24.7 years. Four versions of the dataset were analyzed:

+ `DR2full`. 24.7 years of data taken by the EPTA;

+ `DR2new`. 10.3 years of data collected by the EPTA using new-generation wide-band backends;

+ `DR2full+`. The same as `DR2full`, but with the addition of InPTA data;

+ `DR2new+`. The same as `DR2new`, but with the addition of InPTA data.

The analysis presented in this paper refers to the `DR2new` dataset only. We do not consider `DR2full` and `DR2full+` because evidence of quadrupolar correlation (usually referred to as HD correlation, from #cite(<hd1983>, style: "aas_noparen.csl")) of the common process is weaker in those datasets, potentially due to the lower quality of early data that were collected with narrowband backends (see discussion in PaperIII). On the other hand, although the analysis of `DR2new+` produced results in broad agreement with `DR2new`, that dataset was assembled relatively recently and has not been analysed as thoroughly. For example, the binned free-spectra that we will use in some of the following analyses have only been produced after this work was completed.

Before proceeding with the description of the signal detected in `DR2new`, here we summarise some notations used in PTA analysis for the benefit of the reader. The perturbation affecting the TOAs, whether produced by GWs or DM, is described in terms of its dimensionless strain $h$. A broad-band stochastic perturbation is defined by its characteristic dimensionless strain $h_c ( f )$, often modelled as a power law

$
  h_c ( f ) = A (f \/ f_0)^alpha .
$ <eq:hc>

 For example, a population of GW-driven circular SMBHBs produces a spectrum with $alpha = -2\/3$ and amplitude $A approx 10^(- 15)$, assuming $f_0=1"yr"^(-1)$. $h_c ( f )$ is connected to the differential energy content of the signal per logarithmic frequency through the equation:

$
  Omega ( f ) = frac(2 pi^2, 3 H_0^2) f^2 h_c^2 ( f )
$<eq:omega>

 where $H_0$ is today's Hubble expansion parameter. We note that $h_c ( f )$ and $Omega ( f )$ provide equivalent parametrizations of the spectrum. The former is more popular in the astrophysics domain, whereas the latter is the preferred choice for early Universe and cosmology.

Given $h_c ( f )$, the one-sided power spectral density induced by the GW signal in the timing residuals is given by @ltm-2015.

$
  S ( f ) = frac(h_c^2 ( f ), 12 pi^2 f^3) = frac(A^2, 12 pi^2 f_0^(2 alpha)) f^(- gamma)
$ <eq:sh>

 where $gamma = 3 - 2 alpha$. PTAs search for HD correlated time delays with such a power spectrum in the data, and measure the parameters $A$ and $gamma$. For an observation timespan $T$, measurements are discretised in frequency bins $Delta f_i = f_(i + 1) - f_i$, where $f_i = i T$. It is then customary to convert $S ( f )$ in RMS residual induced in the TOAs in each frequency bin:

$
  "RMS"_i = (integral_(Delta f_i) S(f) "d"f)^(1\/2) approx (S(f_i) Delta f_i)^(1\/2) = (frac(S(f_i), T))^(1\/2)
$<eq:RMS>

The main properties of the GWB signal observed in `DR2new` and examined in this paper are shown in @fig:EPTADR2. The length of the dataset is $T =$ 10.3 years, and excess common correlated power is detected in several frequency bins up to $approx 30 #h(0.17em)$ nHz (@fig:EPTADR2 left panel). Conversely, some bins are unconstrained, which results in a relatively loose determination of the spectral properties of the observed signal. In the literature, $h_c$ and $S$ in @eq:hc and @eq:sh are usually anchored to the pivotal frequency $f_0=1"yr"^(-1)$. The data are, however, most informative at the lowest frequencies, while the common power at $1"yr"^(-1)$ is essentially unconstrained. This naturally leads to a strong degeneracy of the $A - gamma$ 2D posterior, as shown for example in Figure 1 of PaperIII. Therefore, unless otherwise stated, we change the reference frequency to $f_0=10"yr"^(-1)$, where the data are actually constraining, which results in a weaker dependence of $A$ upon $gamma$, as shown in the right panel of @fig:EPTADR2.

In the following three sections, we discuss three possible contributions to the signal, probing completely different epochs and scales of our Universe, and the implications for the associated physical processes. Namely, the cosmic population of SMBHBs (at redshifts $z lt.tilde 1$), the early Universe ($z > 1000$), and DM (within our Galaxy).

= Implications I: supermassive black hole binaries <sec:SMBHBs>

A cosmic population of SMBHBs is the primary astrophysical candidate to produce a signal in the nanohertz band detectable by PTAs. If we define $"d"^5N\/("d"z"d"m_1"d"q"d"e"d"t_r)$ as the cosmic merger rate of SMBHBs as a function of redshift, primary black hole mass, mass ratio, and eccentricity, the general form of the generated GWB as a function of observed frequency $f$ can be written as @2013CQGra..30v4014S.

$
  h_c^2 (f) = integral_0^oo "d"z integral_0^oo "d"m_1 integral_0^1 "d"q frac("d"^5 N, "d"z "d"m_1 "d"q "d"e "d"t_r) frac("d"t_r, "d""ln" f_("K",r)) times \
  h^2 (f_("K",r)) sum_(n=1)^oo frac(g [n, e (f_("K",r))], (n\/2)^2) |_(f_(K,r)=f(1+z)\/n)
$<eq:hch2>

Here, $"d"t_r\/("d""ln"f_("K",r))$ is the time spent by the shrinking binary within a given logarithmic orbital frequency bin, which converts the merger rate into the distribution of rest-frame orbital frequencies of the emitting population. This quantity depends on the physical processes driving the evolution of the SMBHBs including, besides GW emission, interaction with the stellar and gaseous environment surrounding them. As such, it is generally a function of the binary parameters $m_1 , q , e$, and extra parameters describing the environment, such as the stellar density in the nucleus of the galaxy host @eq:hch2.

The second line of @eq:hch2 is the strain amplitude produced by each individual eccentric SMBHB binary, cast as the sum of harmonics fulfilling the condition $f_(K r) = f ( 1 + z ) n$. In that expression, $h ( f_(K r) )$ is the strain of the equivalent circular binary emitted at twice the orbital frequency of the system, as given in Eq. 4-7 of @2015MNRAS.451.2417R, and $g ( n , e )$ is a combination of Bessel functions @2020PhRvD.102j3023B (for details).

For a distribution of circular, GW-driven binaries, the only relevant mass parameter is the chirp mass $cal(M) = (m_1 m_2)^(3 \/ 5) (m_1 + m_2)^(1 \/ 5)$, and @eq:hch2 takes the familiar form @eq:hch2.

$
  h_c^2 (f) = integral_0^oo "d"z integral_0^oo "d"cal(M) frac("d"^3 N, "d"z "d"cal(M) "d""ln" f_r) h^2 (f_r)
$<eq:hch2_circ>

This can be recast in terms of the comoving number density of merging binaries $"d"^2 n\/("d"z "d"cal(M))$ @Phinney:2001.

$
  h_c^2 (f) = frac(4 G^(5 \/ 3), 3 pi^(1 \/ 3) c^2) f^(- 4 \/ 3) integral dif cal(M) integral dif z (1 + z)^(- 1 \/ 3) cal(M)^(5 \/ 3) frac("d"^2 n, "d"z "d"cal(M)) ,
$
which highlights that, in this case, the expected spectrum follows a power law $h_c prop f^(- 2 \/ 3)$, and the only free parameter is its overall amplitude. The latter is set by the function $"d"^2 n\/("d"z "d"cal(M))$, which contains all the astrophysical knowledge of the cosmic population of merging SMBHBs, and is determined by the cosmological hierarchical assembly of galaxies and their central SMBHs. Conversely, in the most general case described by @eq:hch2 there is also information in the spectral shape of the signal, since coupling with the environment as well as eccentricity affect the function $"d"t_r\/("d""ln"f_("K",r))$, suppressing signal at the lowest frequencies. Moreover, eccentricity distributes the GW power at several higher harmonics of the orbital frequency, slightly modifying the power-law behaviour at high frequencies. In general, the GWB cannot be cast in term of a simple analytical form, although a broken power-law is a sufficient approximation for most situations @2014MNRAS.442...56R @2015ASSP...40..147S @kbh-2017 @csd2017.

The literature investigating the GWB produced by a population of SMBHBs is vast, dating back to the mid-nineties and early 2000s @rr1995 @jb2003 @wl2003 @ses-2004, and predictions have been made by employing different models and techniques. Models can be broadly classified into two categories: self-consistent theoretical models for SMBH evolution within their galaxies @svc08 @2009MNRAS.394.2255S @2012ApJ...761...84R @2015ApJ...799..178K @kbh-2017 @2018MNRAS.477.2599B @2020MNRAS.498..537S @2022MNRAS.509.3488I, and empirical models based on observed properties of galaxy pairs coupled to SMBH-host galaxy relations @ses2013 @2015MNRAS.451.2417R @2015MNRAS.447.2772R @2023ApJ...949L..24S, or on the evolution of the SMBH mass function inferred from observations @2014ApJ...789..156M. Note that we group both semianalytic models (SAMs) and large cosmological simulations in the first class. The main difference between these two classes is that self-consistent models are constructed to reproduce a large array of observations related to galaxies and the SMBH they host, such as the redshift-dependent galaxy mass function, quasar luminosity function, and so on. Conversely, empirical models are, by construction, consistent with the observations upon which they are based, but are usually not tested against independent constraints. As a consequence, they can generally produce a wider distribution of GWB amplitudes, but consistency with other observations is not necessarily guaranteed.

In this Section, we investigate the implications of the signal observed in the `DR2new` dataset for representative models of the two classes. In @sec:MBHB_rosado, we perform a semi-quantitative comparison between the measured signal and predictions of an extended version of the @2015MNRAS.451.2417R models (hereinafter RSG15) including binary eccentricity and environmental coupling. In @sec:MBHB_inference, we exploit the framework developed in @2016MNRAS.455L..72M @2017MNRAS.468..404C @csc2019 to draw inference on SMBHB astrophysics from the data, either by assuming astrophysical priors from independent observations, or by using a completely generic model for the SMBHB mass function with minimal assumptions. In @sec:MBHB_SAM, we demonstrate how the measured signal can inform galaxy and SMBH formation models by examining its constraining power on two state-of-the-art SAMs, namely `L-galaxies` @2015MNRAS.451.2663H and the model developed by Barausse and collaborators @2015MNRAS.451.2663H @B-18 @B-20. We discuss caveats and future directions of improvement in @B12 @B-18 @B-20.

== Qualitative analysis of empirical SMBHB population models <sec:MBHB_rosado>

To carry out a semi-quantitative comparison between observations and empirical models, we use an extended set of SMBHB populations based on the work of @ses2013 (S13 hereinafter) and RSG15.

=== Description of the models <description-of-the-models>
As described in S13, the models are constructed around the number density of merging SMBHs per unit primary mass, mass ratio, and redshift, $"d"^3n\/("d"m_1"d"q"d"z)$ obtained by combining different observations of the galaxy mass function and pair fraction, estimated galaxy pair merger timescales, SMBH-host galaxy relations, and prescription for SMBH accretion during mergers (see Section 2 of S13 for full details). Given the large uncertainties in all of the ingredients, the models predict a broad distribution of expected GW amplitudes, as shown in @fig:A_Rosado.

#figure(cetz.canvas(length: 0.54cm, {
    import cetz.draw: *

    // data-space -> canvas mapping of the RSG15 amplitude distributions
    let X(v) = (v + 16.30) * 5.0
    let Y(v) = v * 3.077
    let ytop = Y(2.5)
    let xlo = X(-16.30)
    let xhi = X(-13.80)
    let pts(arr) = arr.map(p => (X(p.at(0)), Y(p.at(1))))

    // full set of RSG15 models (thin dashed yellow)
    let yellow = (
      (-16.30, 0), (-16.136, 0.006), (-16.077, 0.011), (-16.049, 0.018), (-15.980, 0.031),
      (-15.921, 0.053), (-15.893, 0.063), (-15.834, 0.097), (-15.776, 0.134), (-15.723, 0.184),
      (-15.695, 0.210), (-15.642, 0.273), (-15.592, 0.347), (-15.545, 0.427), (-15.500, 0.521),
      (-15.458, 0.611), (-15.416, 0.702), (-15.375, 0.795), (-15.331, 0.895), (-15.300, 0.953),
      (-15.266, 1.011), (-15.219, 1.097), (-15.173, 1.148), (-15.145, 1.179), (-15.110, 1.208),
      (-15.082, 1.218), (-15.045, 1.208), (-15.017, 1.197), (-14.969, 1.161), (-14.938, 1.103),
      (-14.892, 1.052), (-14.851, 0.973), (-14.813, 0.890), (-14.772, 0.789), (-14.730, 0.698),
      (-14.688, 0.602), (-14.649, 0.515), (-14.615, 0.464), (-14.584, 0.390), (-14.542, 0.326),
      (-14.502, 0.287), (-14.475, 0.232), (-14.439, 0.184), (-14.411, 0.155), (-14.368, 0.110),
      (-14.334, 0.085), (-14.287, 0.050), (-14.247, 0.034), (-14.218, 0.018), (-14.168, 0.006),
      (-14.125, 0.006), (-13.80, 0),
    )
    // down-selected subset of 108 models (thick dashed orange)
    let orange = (
      (-16.30, 0), (-15.470, 0.006), (-15.442, 0.008), (-15.414, 0.011), (-15.379, 0.016),
      (-15.321, 0.050), (-15.294, 0.073), (-15.266, 0.102), (-15.223, 0.171), (-15.195, 0.221),
      (-15.167, 0.279), (-15.132, 0.384), (-15.104, 0.465), (-15.068, 0.576), (-15.041, 0.677),
      (-15.009, 0.808), (-14.961, 0.985), (-14.934, 1.097), (-14.904, 1.232), (-14.872, 1.363),
      (-14.845, 1.463), (-14.811, 1.585), (-14.783, 1.644), (-14.730, 1.773), (-14.702, 1.777),
      (-14.675, 1.771), (-14.631, 1.694), (-14.603, 1.624), (-14.576, 1.563), (-14.542, 1.419),
      (-14.512, 1.287), (-14.485, 1.160), (-14.441, 0.952), (-14.413, 0.806), (-14.384, 0.648),
      (-14.356, 0.537), (-14.324, 0.406), (-14.297, 0.313), (-14.263, 0.206), (-14.235, 0.145),
      (-14.188, 0.069), (-14.160, 0.040), (-14.133, 0.021), (-14.105, 0.010), (-13.80, 0),
    )
    // 108 down-selected sample used in the analysis (solid blue)
    let blue = (
      (-16.30, 0), (-15.274, 0.006), (-15.246, 0.031), (-15.219, 0.065), (-15.191, 0.102),
      (-15.163, 0.150), (-15.136, 0.221), (-15.108, 0.292), (-15.080, 0.363), (-15.052, 0.461),
      (-15.025, 0.576), (-14.997, 0.777), (-14.969, 0.994), (-14.942, 1.242), (-14.914, 1.424),
      (-14.886, 1.495), (-14.859, 1.566), (-14.831, 1.640), (-14.803, 1.655), (-14.775, 1.674),
      (-14.748, 1.931), (-14.720, 2.165), (-14.692, 2.165), (-14.665, 2.153), (-14.637, 2.118),
      (-14.609, 2.034), (-14.582, 1.884), (-14.554, 1.690), (-14.526, 1.481), (-14.499, 1.298),
      (-14.471, 1.106), (-14.443, 0.827), (-14.415, 0.590), (-14.388, 0.448), (-14.360, 0.306),
      (-14.332, 0.165), (-14.305, 0.073), (-14.277, 0.011), (-13.80, 0),
    )

    line(..pts(yellow), stroke: (thickness: 0.7pt, paint: rgb("#FFA400"), dash: ((3pt, 2.5pt))))
    line(..pts(orange), stroke: (thickness: 1.8pt, paint: rgb("#FF4400"), dash: ((6pt, 4.5pt))))
    line(..pts(blue), stroke: (thickness: 1.5pt, paint: rgb("#00CED1")))

    // median A at f_0 = 1 yr^-1 from PaperIII (gamma = 13/3)
    line((X(-14.6077), 0), (X(-14.6077), ytop),
      stroke: (thickness: 1pt, paint: black, dash: "dotted"))

    // frame with minor and major ticks pointing inwards on all four sides
    rect((xlo, 0), (xhi, ytop), stroke: (thickness: 1.4pt, paint: black), fill: none)
    let d1(v) = calc.round(v * 10) / 10
    for i in range(0, 24) {
      let x = (-162 + i) / 10.0
      let major = calc.rem(i + 3, 5) == 0
      let len = if major { 0.3 } else { 0.15 }
      line((X(x), 0), (X(x), len), stroke: (thickness: 1pt, paint: black))
      if major {
        content((X(x), -0.35), anchor: "north", text(size: 7pt)[$#x$])
      }
    }
    // upper axis: same scale shifted by 0.666 dex (A normalised at 10 yr^-1)
    for i in range(0, 24) {
      let x = (-1617 + i * 10) / 100.0
      let major = calc.rem(i, 5) == 0
      let len = if major { 0.3 } else { 0.15 }
      line((X(x), ytop), (X(x), ytop - len), stroke: (thickness: 1pt, paint: black))
      if major {
        content((X(x), ytop + 0.35), anchor: "south",
          text(size: 7pt)[$#d1((-155 + i)/10.0)$])
      }
    }
    for i in range(0, 26) {
      let y = i / 10.0
      let major = calc.rem(i, 5) == 0
      let len = if major { 0.3 } else { 0.15 }
      line((xlo, Y(y)), (xlo + len, Y(y)), stroke: (thickness: 1pt, paint: black))
      line((xhi, Y(y)), (xhi - len, Y(y)), stroke: (thickness: 1pt, paint: black))
      if major {
        content((xlo - 0.32, Y(y)), anchor: "east", text(size: 7pt)[$#y$])
      }
    }
    content(((xlo + xhi) / 2, -1.35), text(size: 8.5pt)[$log_(10)( A_( f = 1\/1 "yr" ) )$])
    content(((xlo + xhi) / 2, ytop + 1.35), text(size: 8.5pt)[$log_(10)( A_( f = 1\/10 "yr" ) )$])
    content((xlo - 1.5, ytop / 2), angle: 90deg, text(size: 8.5pt)[probability distribution])
  }),
  caption: [
    GWB amplitude distributions predicted by the RSG15 models. The thin-dashed yellow line is for the full set of models in RSG15, whereas the thick-dashed orange line is for the subset considered here. The solid blue line is the distribution predicted by the 108 down-selected sample used in the analysis. The vertical line marks the median value of $A$ at $f_0=1"yr"^(-1)$ reported in PaperIII when fixing $gamma = 13 3$ in the search. Note that the lower $x$-axis scale is for A at $f_0=1"yr"^(-1)$, whereas the upper $x$-axis is for A at $f_0=10"yr"^(-1)$ (the normalization used in this paper). Since $alpha = -2\/3$ for circular GW-driven binaries, there is a shift of 0.666 dex between the two.
  ]
) <fig:A_Rosado>

Guided by the relatively large amplitude of the detected signal and by theoretical and observational advancements in the last decade, we select a sub-sample of those models, as we now justify. First, hydrodynamical simulations of merging galaxies at different scales as well as deep X-ray observations of merging galaxies support accretion activation onto the individual SMBHs prior to merger (e.g. #cite(<2017MNRAS.469.4437C>, style: "aas_noparen.csl") #cite(<2018Natur.563..214K>, style: "aas_noparen.csl")). Moreover, hydrodynamical simulations of sub-pc scale binaries, have found most of the accretion to occur on the secondary (i.e. less massive) SMBH @2014ApJ...783..134F. We therefore restrict the analysis to models where SMBHs accrete prior to the merger, either with an equal Eddington ratio or with preferential accretion onto the secondary.#footnote[This is implemented according to a simple scheme whereby accretion is quenched on the primary SMBH until the binary becomes equal mass. If/when this occurs, further accretion is equally distributed among the two (now equal mass) binary components.] Second, observations of overmassive black holes in the centre of large ellipticals @2011Natur.480..215M has led to an upward revision of the SMBH-galaxy relations. Contrary to S13 and RSG15, here we consider only those revised realations, namely the ones reported by #cite(<2013ARA-A..51..511K>) @2013ApJ...764..184M @2013ApJ...764..151G. Finally, given the large number of models, to save computing power, we perform an ad hoc down-selection of 108 models that preserves the overall distribution of the expected GWB amplitudes, as shown in @fig:A_Rosado.

As opposed to RSG15, we go beyond the circular-GW driven binary approximation and consider the self-consistent evolution of SMBHBs within their stellar environment.#footnote[Most of the signal comes from SMBHBs hosted in massive, low-redshift galaxies (but see #cite(<2023ApJ...949L..24S>, style: "aas_noparen.csl")), which are relatively gas-poor.] This is done by employing the hardening models of @2010ApJ...719..851S that self-consistently evolve the SMBHB semimajor axis and eccentricity under the combined effect of stellar hardening and GW emission, once a given initial eccentricity $e_0$ at binary formation is given. Those evolutionary tracks allow us to evaluate the term $"d"t\/("d""ln"f_("K",r))$ in @eq:hch2, and thus to reconstruct from the density distribution of merging binaries, $"d"^3n\/("d"m_1"d"q"d"z)$, the numerical distribution of systems emitting at any time in the whole sky as a function of mass, mass ratio, redshift, orbital frequency and eccentricity, $"d"^5N\/("d"m_1"d"q"d"z"d"f"d"e)$. For each model, we consider 10 values of $e_0 = 0, 0.1 . . 0.9$ and three different normalizations of the stellar density profile, described as $rho = C times rho_0 ( r r_0 )^(- 1.5)$, with $C = 0.1 1 10$

In total, we explore 108 $times$ 10 $times$ 3 $= 3240$ models, spanning different eccentricities and densities of the stellar environment. For each model, we draw 100 Monte Carlo samplings of the distribution of the emitting binaries, we discretise the frequency domain in bins of $Delta(f)=10.3"yr"^(-1)$, and add the signals of binaries falling in the same bin in quadrature. This leads to the binned characteristic strain spectrum $h_c ( f )$ that we then convert in $S ( f )$ and RMS residuals using @eq:sh and @eq:RMS. The full procedure is described in @2010MNRAS.402.2308A @2020PhRvD.102j3023B. In this way, we generate a grand total of 324k Monte Carlo realizations of the predicted GW spectrum in the PTA band.

=== Comparison with the observed signal <comparison-with-the-observed-signal>

// [figvision-cn] imgs/fig_violins_wholesignals.png
// 这是一幅名为“自由谱小提琴图”的科学图表，用于比较实测信
// 号与预期信号。图表没有子图，为单一坐标系下的复合图形。
// 坐标轴：横轴为频率 f，单位赫兹（Hz），采用对数刻度，主
// 要刻度标注为 10^-8，整体范围大致覆盖 2×10^-9 至 1×10^
// -7 Hz。纵轴为信号幅度，标注为 log10 (RMS/seconds)，即
// 均方根秒数的以10为底的对数，范围从 -10 到 -5，线性刻度。
// 图例与数据元素： 细灰线：标注为“MC realizations”，表示
// 100次蒙特卡洛实现，这100条细线在图中形成密集的灰色线束，
// 大部分在低频区（约 3×10^-9 至 10^-8 Hz）紧密聚集、随频
// 率下降，在高频区（>10^-8 Hz）则散开成扇形。 黑色虚线：
// 标注为“f = 1/yr”，是一条垂直虚线，位于 f ≈ 3.17×10^-8
// Hz 处，贯穿整个纵轴。 橙色小提琴图：标注为“EPTA DR2new
// ”，表示实测信号。其宽度代表信号强度的概率密度分布。在
// 低频区（10^-8 Hz 以下），橙色分布较窄，中心位置从约
// -6.7 下降到 -7.6；在接近和超过 f = 1/yr 的高频区，橙色
// 分布变得极宽，从 -7.2 向下延伸至 -9.5，向上延伸至 -6.2，
// 显示出很大的不确定性。 绿色小提琴图：标注为“SMBHB
// models”，表示超大质量双黑洞模型的预期信号。在低频区，
// 绿色分布与橙色分布位置接近，中心从约 -6.7 下降至 -7.8，
// 但绿色分布整体更窄（垂直方向更集中），且向下延伸的尾部
// 较短（最低至 -8 左右）。在高频区，绿色分布也变得宽泛，
// 且部分与橙色分布重叠。 图中的特殊高亮： 在这些小提琴图
// 上，叠加了100条细灰线，其中一条被加粗的深灰色/蓝灰色折
// 线是特例。图注说明这条粗线代表一个与数据在所有频率上测
// 得的超量功率均一致的 SMBHB 信号示例。这条粗线与细灰线
// 组成的线束趋势一致，从低频的约 -6.7 开始，随频率增加而
// 下降，在 f ≈ 2×10^-8 Hz 附近有一个约 -7.4 的局部峰值，
// 随后在接近 f = 1/yr 时降至约 -8.6。 趋势与结论：在低于
// f = 1/yr 的频率范围内，绿色模型预期的中位信号略低于橙
// 色实测信号，但两者的分布有显著重叠；而在高于 f = 1/yr
// 的频率范围，橙色实测信号的中心值（约 -8 至 -9）显著低
// 于绿色模型预测值的中心区间（约 -6.5 至 -7.5），但橙色
// 分布具有更长的向下尾部。粗线示例展示了实测超量功率可以
// 被特定SMBHB模型在全部频段上拟合。
#figure(image("imgs/fig_violins_wholesignals.png", width: 50.0%),
  caption: [
    Free spectrum violin plot comparing measured (orange) and expected (green) signals. Overlaid to the violins are the 100 Monte Carlo realizations of one specific model; among those, the thick one represents an example of a SMBHB signal consistent with the excess power measured in the data at all frequencies.
  ]
) <fig:violin_allsignal>

The binned spectrum shown in @fig:violin_allsignal contrasts expectations from the 324k models (green) to the measured correlated signal in `DR2new` (orange). The two sets of violin plots are in good agreement in the few lowest frequency bins, where measurements are the most constraining. Note that the model prediction distributions are highly non-Gaussian and asymmetric, with long tails extending upwards. This is due to the fact that sparse very massive/nearby binaries can sometimes produce exceptionally loud signals, as illustrated by the 100 individual GWBs overplotted to the violins. In fact, this might explain the extra power measured in the 4th and, most strikingly, in the 9th lowest bins compared to the bulk of the model predictions. We caution that the 9th bin is close to the 1yr $""^(- 1)$ mark, where PTAs are blind due to fitting for the Earth orbital motion, and leakage from imperfect fitting might affect that measurement. In any case, if this extra power is indeed due to GWs, it can be easily accommodated by theoretical models, as demonstrated by the realization highlighted by the tick grey line.

// [figvision-cn] imgs/fig_violins_singlesources.png
// 图像由上下两个子图组成，两者共享横轴，横轴标注为频率 f
// [Hz]，刻度为 0.5、1.0、1.5、2.0、2.5、3.0、3.5，右下角
// 标有 ×10⁻⁸，范围约为 0.2×10⁻⁸ 至 3.5×10⁻⁸ Hz。 子图 a
// （上图）为小提琴图（曲线分布图），纵轴标注为 log₁₀ (
// RMS/seconds)，刻度为 −10、−8、−6、−4，范围约 −10.5 至
// −4。图例包含三项：绿色实心小提琴“prediction single
// source”、黑色实心小提琴“prediction GWB”、橙色实心小提
// 琴“data”。图中共有 10 组频率位置的小提琴，每组自左至右
// 依次为绿色、黑色、橙色；绿色和橙色小提琴为实心填充并带
// 有竖向宽度分布轮廓，黑色小提琴以细轮廓线表示填充较窄。
// 橙色数据小提琴在约 0.3、1.0、1.5、3.0×10⁻⁸ Hz 处宽度较
// 大（分布较宽，可延伸至 log₁₀ 值约 −10），在 0.5、0.8、
// 1.3、1.8、2.2、2.5×10⁻⁸ Hz 处分布较窄；绿色单源预测小
// 提琴在各频率处多呈较窄的峰，峰值位置约在 −7 至 −8；黑
// 色 GWB 预测小提琴轮廓较窄且峰值接近 −7 至 −9。图中无其
// 他文字标注。 子图 b（下图）为双纵轴散点图，横轴与上图
// 相同，左纵轴标注为 Probability，采用对数刻度，刻度为
// 10⁻⁴、10⁻³、10⁻²、10⁻¹，范围约 10⁻⁴ 至 5×10⁻¹；右纵轴
// 标注为 Mean S/N，刻度为 4、5、6，范围约 4 至 6。图例为
// 绿色圆点“Probability”与红色叉号“< S/N >”。绿色圆点表示
// 探测概率随频率的变化，在约 0.3×10⁻⁸ Hz 处最高（约 2×10
// ⁻¹），随频率升高总体下降至约 1×10⁻³ 至 3×10⁻³。红色叉
// 号表示平均信噪比，数值在约 4.5 至 5 之间波动，无明显单
// 调趋势。图中无其他文字标注。 整体趋势：上图比较了实测
// 数据与单源及 GWB 预测的 RMS 分布，显示数据分布宽度随频
// 率变化；下图给出探测概率随频率下降、平均信噪比大致平稳
// 的结论。
#figure(image("imgs/fig_violins_singlesources.png", width: 48.0%),
  caption: [
    Expected properties of CGWs as a function of frequency. Top panel: free spectrum violin plot comparing the measured signal (orange) to the power distribution of CGWs (green). Empty violins show the full GWB produced by the models for comparison. Bottom panel: the probability of detecting a CGW with S/N $> 3$ as a function of frequency (green circles, left $y -$ axis scale). The average S/N of CGWs is also shown as red crosses (right $y -$ axis scale).
  ]
) <fig:violin_single>

Our Monte Carlo approach to generate the SMBHB population and its associated GW signal also allows us to investigate the occurrence of CGWs in the data, for which evidence in `DR2new` is found to be inconclusive @wm4. Since the search performed in that paper was limited to circular binaries, we only carry out this analysis for the 32.4k models with $e_0 = 0$.#footnote[For binaries starting with $e_0 = 0$, eccentricities remain well below $0.1$ in the course of stellar hardening-driven evolution, and the GW signals can be approximated as monochromatic.] A full assessment of the detectability of CGWs requires the evaluation of the detection probability of each individual binary for a given false alarm rate, as detailed in RSG15. For the sake of simplicity, and given the qualitative nature of this analysis, we just compute the signal-to-noise ratio (S/N) of each individual binary according to Eq.~(46) of RSG15 (thus also restricting to the Earth term only). When computing the S/N of a source, we model each pulsar noise by using the maximum likelihood values of the single pulsar noise analysis presented in @wm2, and add the GWB produced by all of the other binaries to the noise spectral density. We arbitrarily set the detectability threshold at S/N $= 3$ in the following.

Results are shown in @fig:violin_single, which compares the power distribution of resolvable CGWs to the binned spectra of the overall predicted GW signal and of the `DR2new` measurements. In line with RSG15, the probability of detecting a CGW is maximum at the lowest frequency, rapidly decaying to less than 0.01 past the 6th bin. Although this seems to suggests that the feature observed at the 9th frequency bin is unlikely to be due to a CGW, it should be noticed that we considered here a threshold of $S N = 3$. The overall GW signal in our data has a total $S N approx 3.5 - 4$ @wm3, mostly accumulated at the lowest frequency bins. It might still be the case that the feature at the 9th bin is due to an unresolved CGW with S/N $< 3$, which would be a more common occurrence in the data. Note that the average S/N of CGWs slightly increases at higher frequencies, which is primarily due to the frequency dependence of the CGW characteristic strain, $h_c prop f^(7 \/ 6)$. If $p_i$ is the probability of having a CGW of S/N $> 3$ in the $i$-th bin, we can compute the probability of detecting #emph[at least] one CGW with S/N $> 3$ in `DR2new` according to these models as $p = 1 - product ( 1 - p_i )$, which gives $p = 0.49$. It is therefore quite possible that the observed signal is dominated by few bright sources, which might be resolvable in the future with more sensitive datasets. Thus far, searches for CGWs on the current dataset yielded inconclusive evidence @wm4. This probability is obviously S/N threshold dependent. For example, by increasing this threshold to S/N $> 5$, we get $p = 0.13$. This is comparable to the 6% chance found by @2022ApJ...941..119B and the slightly larger probability in our models is likely due to the louder overall amplitudes of the signals considered here. We stress, however, that these findings apply to models where binaries remain essentially circular. The number of resolvable CGWs, tends, in fact, to slightly decrease when the eccentricity increases (Truant et al. in preparation).

// [figvision-cn] imgs/corner_9bins.png
// 该图由四个面板组成，中央为主等高线图，上方和右侧为边缘
// 分布直方图。中央面板的横轴标注为γ = 3 − 2α（无单位），
// 刻度从左至右为1.5、3.0、4.5、6.0；纵轴标注为log₁₀ A_t
// (t = 1/10 yr)（单位无量纲，因取对数），刻度从下至上为−
// 15.0、−14.5、−14.0、−13.5、−13.0。该面板显示两组二维后
// 验分布：橙色/黄色区域标注为“Posterior (PTMCMC)”，绿色
// 区域标注为“Models”。每组均包含两个轮廓层：浅色外层为2σ
// 轮廓，深色内层为1σ轮廓。橙色分布的1σ区域呈狭长椭圆形，
// 中央位置约在γ ≈ 2.5、log₁₀ A_t ≈ −14.2处，其2σ轮廓延伸
// 至γ ≈ 1.3至3.3、纵向约−14.5至−13.9。绿色分布的1σ区域近
// 似卵形，中央位置约在γ ≈ 4.0、log₁₀ A_t ≈ −14.1处，2σ轮
// 廓延伸至γ ≈ 2.7至5.5、纵向约−14.8至−13.6。中央面板中央
// 有一条黑色竖直虚线，位于γ ≈ 4.1处，贯穿上下边界，并延
// 伸至上方和右侧的边缘分布面板中。图顶部中央有标题“
// Powerlaw fitted to 9 bins”。 上方边缘分布面板：横轴与
// 中央面板的γ轴对齐但无刻度标签，纵轴为概率密度（无刻度）。
// 橙色曲线呈钟形，峰值位于γ ≈ 2.7，曲线下1σ可信区间以浅
// 橙色阴影填充（约γ ≈ 2.1至3.3）。绿色曲线呈较宽钟形，峰
// 值位于γ ≈ 4.0，1σ区间以浅绿色阴影填充（约γ ≈ 3.3至4.8）。
// 两条曲线在γ ≈ 3.4处相交。黑色竖直虚线位于γ ≈ 4.1，贯穿
// 该面板全高。 右侧边缘分布面板：纵轴与中央面板的log₁₀
// A_t轴对齐但无刻度标签，横轴为概率密度（无刻度）。橙色
// 曲线呈较宽钟形，峰值位于log₁₀ A_t ≈ −14.1，1σ区间以浅
// 橙色阴影填充（约−14.3至−13.9）。绿色曲线呈较窄钟形，峰
// 值位于log₁₀ A_t ≈ −14.2，1σ区间以浅绿色阴影填充（约−
// 14.4至−14.0）。黑色竖直虚线位于该面板约中央位置，贯穿
// 全高。 图中所传达的趋势为：PTMCMC后验分布（橙色）与模
// 型预测分布（绿色）在二维参数空间中存在部分重叠但中心位
// 置偏移，尤其在γ方向上模型预测偏向更大的值（峰值约4.0而
// 实测后验约2.7），而在log₁₀ A_t方向上两者中心接近（约−
// 14.1至−14.2），模型预测的分布范围更宽。竖直虚线位于γ ≈
// 4.1，可能对应某一参考值或先验中心。
#figure(image("imgs/corner_9bins.png", width: 50.0%),
  caption: [
    $A - gamma$ distribution of the measured signal (orange) compared to model predictions (green). 1 $sigma$ and 2 $sigma$ contours are displayed. Shown are also the marginalised $A$ (left) and $gamma$ (right) distributions, with their 1 $sigma$ credible intervals highlighted as shaded areas.
  ]
) <fig:corner_A10yr_gamma>

Finally, we once again propose the comparison first shown by @msc-2021, who contrasted the measured 2D $A - gamma$ posterior to model expectations. For the latter, we just fit the 9 lowest frequency bins of the GWB spectrum of each Monte Carlo realization of the Universe with a straight line in the $"log"A-"log"f$ plane. As described in @sec:data, we normalise the measurement to $f_0 = 10$ yr $""^(- 1)$, where our data are informative, which alleviates the $A - gamma$ degeneracy in the posterior. Results are shown in @fig:corner_A10yr_gamma. Although the measured spectrum tends to be shallower than the theoretical one (see also @sec:considerations), the contours overlap at 2 $sigma$ and the marginalised amplitudes are broadly consistent.

== Inference on the SMBHB population. <sec:MBHB_inference>

After checking the general compatibility of the observed signal with expectations from empirical SMBHB population models, we take a more quantitative approach and exploit Bayesian inference to constrain the properties of SMBHBs from the data. We repeat the analysis carried out by @msc-2021 on the common signal detected in the NANOGrav 12.5 year dataset @ng12p5gwb-20, exploiting the framework laid out in @2016MNRAS.455L..72M @2017MNRAS.468..404C @csc2019. The SMBHB population of a given model #strong[M] is described by a set of parameters $( theta )$, we then use Bayesian inference to find the posterior distribution $p(theta|d, bold(M))$ for the parameters $theta$ of model $bold(M)$ given the observation data $d$:

$ p (theta | d, bold(M)) = frac(p (theta | bold(M)) p (d | theta, bold(M)), p (d | bold(M))) $ <eq:posterior>

 Here, $p(theta|bold(M))$ is the prior distribution on the model parameters, $p(d|theta,bold(M))$ is the likelihood of model $bold(M)$ with parameters $theta$ of producing the data, and $p(d|bold(M))$ is the evidence. For each set of $theta$, the likelihood is computed by comparing the signal amplitude produced by $bold(M)$ at frequencies $f_i=i\/(10.3"yr"), i=1,...,9$, to the posterior distribution of the correlated signal measured in `DR2new` at the same frequencies. We treat each bin as independent, therefore the likelihood takes the form

$ "log"_10 p (d | theta, bold(M)) = sum_(i=1)^9 "log"_10 p (A, f_i) |_(A = A_(bold(M))) $ <eq:loglike>

 where $p ( A f_i )$ is the probability density of the amplitude $A$ of the correlated signal measured in the $i$-th bin, and it is evaluated at the value $A_bold(M)$ predicted by the model. We estimate the likelihood in each bin using a KDE estimate of the `DR2new` posteriors, similar to the method used in @2021NatAs...5.1268M

Note that the models we use are deterministic in the sense that they have a 1:1 correspondence between $theta$ and the predicted $h_c ( f )$. In reality, given $theta$, the ensemble of SMBHBs generating the signal is statistically drawn from the deterministic distribution function, which results in a significant scatter of $h_c ( f )$, as demonstrated by the individual spectra shown in @fig:violin_allsignal. We caution that this variance is not captured by these models, and its inclusion in the Bayesian inference pipeline is the subject of ongoing work.

As in~@msc-2021, we use two models to describe the SMBHB population, which are described in turn below.

=== Agnostic SMBHB population model <agnostic-smbhb-population-model>

The agnostic model, developed in~@2016MNRAS.455L..72M, makes minimal assumptions about the underlying population of SMBHBs. Binaries are assumed to be circular, GW-driven and the characteristic strain is computed according to @eq:hch2_circ where the source distribution is described by a Schechter function @1976ApJ...203..297S in $z$ and $M$,

$
  frac(d^2 n, d z d log_10 cal(M)) = dot(n)_0 [(cal(M) \/ 10^7 M_⊙)^(-alpha_M) e^(-cal(M) \/ M_star)] [(1 + z)^(beta_z) e^(-z \/ z_0)] \
  frac(d t_R, d z) ,
$ <eq:schechter>

where $t_R$ is the time in the source frame and we assume cosmological parameters from Planck18 #cite(<2020A-A...641A...6P>).

The five model parameters are $theta = lr(( dot(n)_0, alpha_(cal(M)), cal(M)_(star), beta_(z), z_0 ))$, where $dot(n)_0$ is the merger rate per unit rest-frame time, co-moving volume, and logarithmic $cal(M)$ interval, and the parameter pairs $lr(( alpha_M, cal(M)_(star) ))$ and $lr(( beta_(z), z_0 ))$ control the shape of the $cal(M)$ and $z$ distributions, respectively.
The integration limits in $cal(M)$ and $z$ are $10^6 lt.eq cal(M) M_⊙ lt.eq 10^(11)$ and $0 lt.eq z lt.eq 5$, respectively. The prior ranges of the five model parameters are identical to those used in @msc-2021.

=== Astrophysically-informed SMBHB population model <sec:smbhb_informed>

The astrophysically-informed model was developed in @csc2019. This model captures the interaction between the SMBHBs and their environment and allows for eccentric orbits, both of which lead to a characteristic amplitude that does not follow a simple single power law, as in @eq:hch2. The model has $18$ parameters, $16$ of which describe astrophysical observables linking the number of SMBHB mergers to the number of galaxy mergers. The galaxy stellar mass function is modelled as a redshift-dependent Schechter function defined by five parameters: $(Phi_"0", Phi_I, M_0, alpha_"0", alpha_"I")$. Both the galaxy pair fraction and merger timescales have power law dependencies on the primary galaxy stellar mass $M$, mass ratio $q$ and redshift function $( 1 + z )$ and each of them is defined by a set of four parameters: $(f_"0", alpha_"f", beta_"f", gamma_"f")$ for the pair fraction, and $(tau_0, alpha_"tau", beta_"tau", gamma_"tau")$ for the merger timescale:

$
  f_"pair" = f_0 (M (10^(11) "M"_⊙))^(alpha_f) (1+z)^(beta_f), "with" f_0 = f'_0 integral q^(gamma_f) "d"q
$

$
  tau = tau_0 (M (10^(11) "M"_⊙))^(alpha_tau) (1+z)^(beta_tau) q^(gamma_tau)
$

 Galaxy pairs are then populated with SMBHs of mass $m$ following a standard black hole to stellar bulge mass relation of the form

$
  m = cal(N) lr(( M_("*") (M_b (10^(11) "M"_⊙))^(alpha_("*")), epsilon ))
$

 where $cal(N)(x,y)$ is a log normal distribution with mean value $x$ and standard deviation $y$, which adds three further parameters, $( M_(*) alpha_(*) epsilon.alt )$, to the model. The final two parameters describe the eccentricity at SMBHB pairing $(e_"0")$ and the density of the stellar environment $(zeta_"0")$. For the 18 parameters listed above, in the analysis presented here, we use the #emph[extended prior] intervals listed in Table I of @csc2019

=== Results of the inference <results-of-the-inference>

// [figvision-cn] imgs/nhistogram_nFreq9.png
// 这是一张单一坐标轴的直方图与阶梯曲线叠加图，无子图划分。
// 横轴名称为 log₁₀(ṅ₀ / Mpc⁻³Gyr⁻¹)，表示每立方兆秒差距
// 每吉年发生率的以10为底的对数，范围从 -12.5 到 2.5，刻
// 度间隔为 2.5。纵轴名称为 Normalised counts，表示归一化
// 计数，范围从 0.0 到 1.0，刻度间隔为 0.2。 图例位于左上
// 角，包含三个条目：Agnostic posterior 对应橙色实线阶梯
// 曲线；Astro-informed posterior 对应深绿色实线阶梯曲线；
// Astro-informed prior 对应浅绿色填充直方图。 浅绿色填充
// 直方图（Astro-informed prior）分布在横轴约 -6.0 到
// -2.8 之间，呈单峰分布，峰值位于约 -5.0 处，峰高约 0.8，
// 分布在该区间内较为宽泛。 深绿色实线阶梯曲线（
// Astro-informed posterior）分布在横轴约 -4.8 到 -2.8 之
// 间，呈极窄的单峰分布，峰值位于约 -3.8 处，峰高约 1.0，
// 曲线在峰值两侧陡峭下降。 橙色实线阶梯曲线（Agnostic
// posterior）分布在横轴约 -12.5 到 2.5 的整个区间，呈宽
// 缓的多峰或长尾分布，主峰位于约 -1.0 处，峰高约 0.25，
// 曲线在 -12.5 到 -5.0 之间保持约 0.02 至 0.05 的低值，
// 在 -5.0 之后逐渐上升至主峰，随后在 0.0 之后缓慢下降至
// 2.5 处接近 0.0。 图中有四条垂直虚线：一条橙色虚线位于
// 横轴约 -7.8 处，对应 Agnostic posterior 的低百分位；一
// 条橙色虚线位于横轴约 1.2 处，对应 Agnostic posterior
// 的高百分位；一条深绿色虚线位于横轴约 -4.3 处，对应
// Astro-informed posterior 的低百分位；一条深绿色虚线位
// 于横轴约 -3.2 处，对应 Astro-informed posterior 的高百
// 分位。 该图传达的趋势是：Astro-informed 先验分布较宽，
// 其对应的后验分布相比先验显著收窄并右移，集中在约 -3.8
// 附近；而 Agnostic 后验分布则非常宽泛，主峰位于约 -1.0
// 附近，且其百分位区间远宽于 Astro-informed 后验的百分位
// 区间。
#figure(image("imgs/nhistogram_nFreq9.png", width: 48.0%),
  caption: [Marginalised posterior distributions for $dot(n)_0$ using two SMBHB population models. The orange and green open histograms show marginalised posteriors for the agnostic and astrophysically-informed models, respectively. The filled-green histogram shows the prior for the astrophysically-informed model (the prior for the agnostic model is uniform in the range $[-20, 3]$). The vertical dotted lines show the $5"th"$ and $95"th"$ percentiles of the posteriors.],
) <fig:smbhb_numberofmergers>

// [figvision-cn] imgs/mlines_nFreq9.png
// 这是一张单面板的对数-对数坐标曲线图，展示双超大质量黑
// 洞双星并合时啁啾质量函数的后验概率分布。 横轴为啁啾质
// 量 ℳ，单位为太阳质量（M_⊙），范围从 10^6 到 10^11，采
// 用对数刻度。纵轴为啁啾质量函数的对数微分密度 dn/dlog10
// ℳ，单位为 Mpc^-3，范围从 10^-9 到 10^3，同样采用对数刻
// 度。 图中共有三种数据系列，通过颜色和线型区分： 橙色系
// 列代表“不可知模型的后验分布（Agnostic posterior）”。橙
// 色虚线表示该后验分布的中位数曲线，其形态为：在 ℳ ≈ 3×
// 10^6 M_⊙ 处起始于约 3×10^0 Mpc^-3，随 ℳ 增大而单调下降，
// 在 ℳ ≈ 10^9 M_⊙ 处降至约 10^-8 Mpc^-3 以下。橙色虚线周
// 围有两个橙色阴影带：内部较深的橙色区域表示 50% 可信区
// 间，外部较浅的橙色区域表示 90% 可信区间。该 90% 区间在
// 低质量端（ℳ = 10^6 M_⊙）极宽，上边界接近 10^3 Mpc^-3，
// 下边界约 10^-8 Mpc^-3，表明不可知模型对低啁啾质量端的
// 约束非常弱。 绿色系列代表“天体物理信息模型的后验分布（
// Astrophysically-informed posterior）”。绿色虚线表示其
// 中位数曲线，形态为：在 ℳ ≈ 10^6 M_⊙ 处约为 10^-2 Mpc^
// -3，在 ℳ ≈ 10^7 M_⊙ 处达到峰值约 10^-1 Mpc^-3，随后缓
// 慢下降，在 ℳ ≈ 10^10 M_⊙ 处降至约 10^-7 Mpc^-3，在 ℳ ≈
// 3×10^10 M_⊙ 处降至 10^-9 Mpc^-3 以下。绿色虚线周围同样
// 有深绿色（50% 可信区间）和浅绿色（90% 可信区间）阴影带。
// 相比橙色带，绿色带明显更窄，说明天体物理信息模型给出了
// 更紧的约束。 黑色点线代表“天体物理信息模型的先验分布（
// Astrophysically-informed prior）”。该曲线在 ℳ ≈ 2×10^6
// M_⊙ 处从 10^-9 Mpc^-3 以下开始上升，在 ℳ ≈ 2×10^7 M_⊙
// 处达到峰值约 10^-5 Mpc^-3，随后下降，在 ℳ ≈ 3×10^8 M_⊙
// 处降至 10^-9 Mpc^-3 以下。黑色点线在图中仅表示先验的中
// 心趋势，没有阴影带。 图例位于右上角，包含三个条目：浅
// 橙色方块标注“Agnostic posterior”，浅绿色方块标注“
// Astrophysically-informed posterior”，黑色点线标注“
// Astrophysically-informed prior”。 整体趋势与结论：不可
// 知模型（橙色）的后验在低质量端（ℳ < 10^7 M_⊙）分布极宽
// 且中位数偏高，而天体物理信息模型（绿色）的后验在 ℳ ≈
// 10^7 M_⊙ 附近呈现明显的峰值，且整体分布更窄、约束更强。
// 两个模型在 ℳ ≈ 10^8–10^9 M_⊙ 区间的中位数曲线较为接近，
// 但在低质量端和高质量端存在显著差异。天体物理先验（黑色
// 点线）的峰值位置（ℳ ≈ 2×10^7 M_⊙）与绿色后验的峰值位置
// 大致吻合，但先验的幅度远低于后验，表明数据对先验进行了
// 显著更新。
#figure(image("imgs/mlines_nFreq9.png", width: 51.0%),
  caption: [
    Posterior distribution of the chirp mass function of merging SMBHBs for both the agnostic (orange) and astrophysically informed (green) models. For both models, shaded areas are the central 50% and 90% credible regions and the dashed lines show the medias. The black-dotted lines show the central 99% region for the astrophysical prior.
  ]
) <fig:smbhb_dndlogm>

// [figvision-cn] imgs/gal_selectedCorner_fBins9.png
// 这是一张由八个参数构成的三角图（corner plot），用于展
// 示利用自由光谱九个频段推断的天体物理信息模型的选定参数
// 的后验分布。该图呈下三角矩阵布局，包含8个对角子图（一
// 维边缘后验分布）和28个非对角子图（二维联合后验分布）。
// 对角子图（从左上到右下）：均为阶梯状直方图，纵轴表示概
// 率密度（无刻度标签），横轴表示对应参数的取值范围。每个
// 子图上方标注参数名称及后验中位数和上下百分位不确定度（
// 格式为 参数 = 中位数^{+上限}_{-下限}）。图中包含一条绿
// 色实线阶梯（表示概率密度）和两条黑色竖直虚线（表示置信
// 区间边界）。具体参数依次为： τ₀：范围约 0 至 0.6，标注
// τ₀ = 0.29^{+0.79}_{-0.17}。 α_τ：范围约 -0.4 至 0.4，
// 标注 α_τ = -0.17^{+0.59}_{-0.36}。 β_τ：范围约 -2.4 至
// 0.8，标注 β_τ = -2.03^{+2.37}_{-0.89}。 f₀：范围约
// 0.016 至 0.048，标注 f₀ = 0.04^{+0.01}_{-0.02}。 β_f：
// 范围约 0.4 至 2.0，标注 β_f = 1.32^{+0.62}_{-1.11}。
// log₁₀M_*：范围约 7.6 至 8.6，标注 log₁₀M_* = 8.40^{+
// 0.18}_{-0.32}。 e₀：范围约 0.2 至 0.8，标注 e₀ = 0.51^
// {+0.45}_{-0.45}。 log₁₀ζ₀：范围约 -1.6 至 1.0，标注
// log₁₀ζ₀ = 0.26^{+1.60}_{-2.01}。 非对角子图：均为二维
// 等高线图，横轴和纵轴分别对应其所在行和列的参数。图中用
// 灰度深浅表示样本点密度（深色为高密度区），并叠加黑色实
// 线等高线勾勒不同置信水平的边界。部分子图（如 β_τ 与 α_
// τ、f₀ 与 β_τ 等）的等高线呈现明显的非线性或双峰结构，
// 而 log₁₀M_* 与多数参数的二维图显示较集中的高密度区域。
// 所有子图共享坐标轴刻度，横轴刻度标注在最底行，纵轴刻度
// 标注在最左列。
#figure(scope: "parent", placement: top, image("imgs/gal_selectedCorner_fBins9.png", width: 98.0%),
  caption: [
    Posterior distribution of selected parameters for the astrophysically-informed model using nine frequency bins of the free spectrum for the inference. Parameters are described in @sec:smbhb_informed
  ]
) <fig:smbhb_astinformed_selected_corner>

The main results of the inference are shown in @fig:smbhb_numberofmergers, @fig:smbhb_dndlogm and @fig:smbhb_astinformed_selected_corner. @fig:smbhb_numberofmergers shows the marginalised posterior distribution for the normalization of the merger rate density $dot(n)_0$ from the agnostic model compared to an equivalent parameter derived from the astrophysically-informed model. The constraint on the amplitude of the signal imposes an informative constraint on the normalization of the SMBHB merger density.

Using nine frequency bins, the median and central 90\% credible regions for $log_(10) dot(n)_0\/("Mpc"^3 "Gyr")$ are $-1.95^(+2.91)_(-5.87)$ and $-3.51^(+0.59)_(-0.62)$ for the agnostic and astrophysically-informed models, respectively.

The measurement essentially constrains the amplitude of the signal, which imposes an informative constraint on $n_0$.

The astrophysically-informed model clearly shows that the signal favours an $n_0$ at the upper edge of the astrophysical prior.

All other parameters of the agnostic model are unconstrained and the posterior is very similar to the prior (see Appendix~#ref(<app:smbhb>, supplement: none) for full posterior distributions for both models).

@fig:smbhb_dndlogm displays the posterior on the SMBHB chirp mass function for the two models integrated over the redshift range $0 < z < 1.5$. Although the agnostic model results in a loosely constrained mass function, the measured PTA signal alone places interesting lower limits on the SMBHB binary merger rate in the Universe. For example, we can say at 95% confidence that for each comoving Gpc $""^3$, there have been at least 10 $""^4$ SMBHB mergers with $cal(M)approx 10^7 M_⊙$ since cosmic noon. When astrophysical priors weights in, the mass function of merging SMBHBs is well constrained by the PTA signal and, as expected from @fig:smbhb_numberofmergers, it lies in the upper range of the astrophysically informed prior. Within this model, the `DR2new` measured signal implies there have been about 10 $""^6$ SMBHB mergers for each comoving Gpc $""^3$, with $cal(M)approx 10^9 M_⊙$ since $z = 1.5$. This points towards a very active merger history of massive galaxies and a very efficient dynamical evolution of the SMBHBs forming in the merger process.

For the astrophysically informed model, `DR2new` also provides interesting information on several model parameters. This is because the astrophysical prior considerably narrows down the range of signal amplitudes allowed by the model, and the measured signal pushes towards the upper bound of this range. This results in informative constraints on several key parameters, related in particular to the SMBHB merger timescale and the SMBH-bulge mass relation. As shown in @fig:smbhb_astinformed_selected_corner, the SMBH merger timescale $tau_0$ following galaxy pairing must be shorter than $approx 1 "Gyr"$ (90% confidence), with the data mildly favouring shorter merger times for massive galaxies at low redshifts (i.e. $alpha_tau beta_tau < 0$). Moreover, the data favour a high normalization of the SMBH-bulge mass relation $"log"_(10)M_("*")approx 8.4_(-0.32)^(+0.18)$, compared to a much wider prior range extending all the way down to $"log"_(10)M_("*")=7.8$. This is in line with the qualitative analysis of @sec:MBHB_rosado, which showed that the signal is consistent with recent, upward-revised, SMBH-galaxy relations. There is also a slight preference for a high normalization of the pair fraction $f_0$ with a positive $z$ dependence, $beta_f > 1$. Despite the low $gamma$ value favoured by the data, indicative of a flatter spectrum compared to the canonical value predicted by circular GW-driven binaries, SMBHB dynamics is largely unconstrained, perhaps with a marginal preference for eccentric binaries evolving in dense environments ($e_0$ and $zeta_0$ posteriors slightly rising towards the right bound of the prior).

Altogether, these results point towards efficient orbital decay of SMBHBs in the aftermath of galaxy mergers, providing direct evidence that the 'final parsec problem' is solved in nature and that compact sub-parsec SMBHBs must be common in the centre of massive galaxies.

== Implications for SAMs <sec:MBHB_SAM>

We now explore the implication of this signal for the joint modelling of the galaxy and SMBH formation and evolution by taking a close look at two state-of-the-art SAMs: the model constructed by Barausse and collaborators @B12 @2014ApJ...794..104S @2015ApJ...806L...8A @K-16 @B-18 @B-20  and `L-Galaxies` @2015MNRAS.451.2663H @2022MNRAS.509.3488I. In this preliminary study, we do not model the dynamical evolution of the binaries and we assume them to be circular and GW driven, thus resulting in a characteristic strain spectrum with $alpha = -2\/3$.

=== SAMs and SMBHB delays <sams-and-smbhb-delays>

#figure(cetz.canvas(length: 0.68cm, {
    import cetz.draw: *

    // data-space -> canvas mapping of the SAM delay comparison
    let X(u) = 10.0 * u
    let Y(v) = (v + 15.05) * 5.0
    let red = rgb("#FF0000")
    let stk = (thickness: 0.8pt, paint: red)
    let ytop = Y(-13.548)
    let ybot = Y(-15.05)
    let labels = (
      "HS-nod-SN-high_accr (B+20)", "LS-nod-noSN (B+20)", "HS-nod-noSN (B+20)",
      "LS-nod (B12)", "HS-nod (B12)", "Q3-nod (K+16)", "popIII-d (K+16)",
      "Q3-d (K+16)", "LS-d (B+18)", "HS-d (B+18)", "LS-noSN-d (B+20)",
      "HS-noSN-d (B+20)", "LS-SN-d (B+20)", "HS-SN-d (B+20)",
    )
    // (x position, upper end of range, lower end, down-triangle, up-triangle, cap on both ends)
    let dat = (
      (0.0665, -13.9906, -14.0606, none, -13.9906, false),
      (0.1334, -14.2696, -14.5080, -14.3416, -14.4370, true),
      (0.1999, -13.6568, -14.4928, -13.7278, -14.4207, true),
      (0.2669, -13.7441, -14.3041, -13.8141, -14.2330, true),
      (0.3338, -13.8130, -14.3528, -13.8830, -14.2828, true),
      (0.4003, -13.6872, -14.3345, -13.7593, -14.2645, true),
      (0.4668, -13.8597, -14.3913, -13.9317, -14.3213, true),
      (0.5337, -13.7725, -14.3933, -13.8425, -14.3233, true),
      (0.6007, -14.1945, -14.3590, -14.2613, -14.2857, true),
      (0.6672, -14.1499, -14.3203, -14.2219, -14.2493, true),
      (0.7341, -14.6754, -14.8823, -14.7454, -14.8123, true),
      (0.8011, -14.6064, -14.8133, -14.6774, -14.7433, true),
      (0.8676, -14.4826, -14.6754, -14.5536, -14.6054, true),
      (0.9345, -14.5496, -14.7464, -14.6196, -14.6764, true),
    )

    // DR2new 95% confidence band
    rect((X(0), Y(-14.0758)), (X(1), Y(-13.8425)), fill: rgb("#CCE5CC"), stroke: none)

    // finite-resolution ranges and infinite/finite resolution predictions
    for d in dat {
      let (u, y1, y2, dn, up, both) = d
      let x = X(u)
      line((x, Y(y1)), (x, Y(y2)), stroke: stk)
      line((x - 0.2, Y(y2)), (x + 0.2, Y(y2)), stroke: stk)
      if both {
        line((x - 0.2, Y(y1)), (x + 0.2, Y(y1)), stroke: stk)
      }
      if dn != none {
        line((x - 0.09, Y(dn) + 0.045), (x + 0.09, Y(dn) + 0.045), (x, Y(dn) - 0.045),
          close: true, fill: red, stroke: none)
      }
      if up != none {
        line((x - 0.09, Y(up) - 0.045), (x + 0.09, Y(up) - 0.045), (x, Y(up) + 0.045),
          close: true, fill: red, stroke: none)
      }
    }

    // separators between the three delay classes
    for s in (0.434, 0.7009) {
      line((X(s), ybot), (X(s), ytop),
        stroke: (thickness: 0.8pt, paint: black, dash: "dashed"))
    }
    content((X(0.217), Y(-14.98)), text(size: 7pt)[No delays])
    content((X(0.567), Y(-14.98)), text(size: 7pt)[Medium delays])
    content((X(0.850), Y(-14.98)), text(size: 7pt)[Long delays])

    // frame, ticks and labels
    rect((X(0), ybot), (X(1), ytop), stroke: (thickness: 1.2pt, paint: black), fill: none)
    for v in (-13.6, -13.8, -14.0, -14.2, -14.4, -14.6, -14.8, -15.0) {
      line((X(0) - 0.12, Y(v)), (X(0), Y(v)), stroke: (thickness: 1pt, paint: black))
      content((X(0) - 0.22, Y(v)), anchor: "east", text(size: 6.5pt)[$#v$])
    }
    for i in range(14) {
      let x = X(dat.at(i).at(0))
      line((x, ybot - 0.12), (x, ybot), stroke: (thickness: 1pt, paint: black))
      content((x, ybot - 0.18), anchor: "east", angle: 90deg, text(size: 6pt)[#labels.at(i)])
    }
    content((X(0) - 1.35, (ytop + ybot) / 2), angle: 90deg,
      text(size: 8pt)[$log_(10) A ( f = 1\/10 "yr" )$])
    content((X(0.5), ybot - 4.3), text(size: 8pt)[Model (delays increasing left to right)])
  }),
  caption: [
    Predictions for the GWB characteristic strain amplitude at $f = 1 10$ yr from a range of SAMs published in the literature, assuming quasicircular orbits and no environmental interactions (i.e. $gamma = 13 3$), but different physical prescriptions for the delays (increasing from left to right) between galaxy mergers and black hole mergers. The "no delays", "medium delays" and "long delays" models correspond respectively to the classes of models #emph[(i), (ii)] and #emph[(iii)] defined in the text. The ranges account for the finite resolution of the models. The shaded area is the DR2new 95% confidence bound. More details about the models are provided in the text.
  ]
) <fig:sam>

In @fig:sam, we show this comparison for the model of #cite(<B12>, form: "prose") in its original version (B12) and its subsequent evolutions, which were used to produce the results of #cite(<K-16>, form: "prose") (K+16), #cite(<B-18>, form: "prose") (B+18) and #cite(<B-20>, form: "prose") (B+20). Besides the specific SAM implementation and (astro)physics, these models mainly differ for the physical prescriptions describing the delays between galaxy and MBH mergers, with #emph[(i)] models "LS-nod (B12)", "HS-nod (B12)", "Q3-nod (K+16)", "LS-nod-noSN (B+20)", "HS-nod-noSN (B+20)" and "HS-nod-SN-high-accr (B+20)" assuming no such delays (except for the delays between the mergers of the halos and those of the corresponding baryonic components)#footnote[Models "LS-nod-noSN (B+20)", "HS-nod-noSN (B+20)" and "HS-nod-SN-high-accr (B+20)" were #emph[not] presented in B+20, but are produced using the model of that paper, setting to zero the delays between galaxy and MBH mergers (except for the dynamical friction timescale -- including tidal effects -- between dark matter halos).]  #emph[(ii)] models "popIII-d (K+16)", "Q3-d (K+16)", "LS-d (B+18)", "HS-d (B+18)" additionally introducing the effect of stellar hardening, triple MBH interactions and gas-driven migration; and #emph[(iii)] models "LS-noSN-d (B+20)", "LS-SN-d (B+20)", "HS-noSN-d (B+20)" and "HS-SN-d (B+20)" accounting for even longer delays (including large contributions from SMBHB separations of hundreds of pc). Note that the labels "SN" (and "noSN") refer respectively to a putative effect of SN feedback on black hole accretion (and the absence thereof), while "LS"/"popIII" and "HS"/"Q3" denote respectively light and heavy high-redshift seeds for the black hole population.

The predictions are computed by summing the gravitational energy spectra of #emph[all] the SMBHBs in each model's theoretical population, assuming quasi-circular orbits. As a result, the spectrum has a slope of $gamma = 13 3$ and has no cosmic variance (i.e. we do not account at this stage for the scatter from one realization of the SMBHB population to another). The range shown for each model represents the uncertainty due to the correction for the finite resolution of the SAM's merger tree. In more detail, the lower end of the range represents a model's prediction at the finite resolution, while the upper end is the extrapolation -- performed as described in Figure 4 of #cite(<K-16>, form: "prose") -- to infinite resolution. The lower arrow (pointing up) should therefore be interpreted as a lower limit, while the upper arrow (pointing down) should be understood as an upper bound (due to the uncertainty of the extrapolation procedure). The extrapolation has not been performed for the model HS-nod-SN-high-accr (B+20), for which we report only the (more robust) prediction at finite resolution. The latter already agrees with the measured amplitude, as a result of a higher accretion rate (by a factor $tilde 4$) for SMBHs.

For two of the models in better qualitative agreement with the data (i.e. "HS-nod-SN-high-accr (B+20)" and "HS-nod-noSN (B+20)"), we compare the predicted signal with the measured `DR2new` free spectrum in @fig:sam2.

Unlike in the case of @fig:sam, these predictions were obtained for multiple specific #emph[realizations] of the SMBHB population, following~#cite(<svc08>, form: "prose")#footnote[Note however that following #cite(<svc08>, form: "prose"), and different from RSG15, we average over sky position and binary inclination.]. The probability distribution function plotted in each bin represents the scatter of these multiple realizations, and should therefore be interpreted as a "cosmic variance". Similarly, in @fig:sam3 we show the theoretical forecasts for $A(f=1\/10"yr")$ from a subset of the models presented above (namely those in qualitative agreement with the data in @fig:sam). These forecasts are obtained by fitting the model predictions (from multiple realizations of the SMBHB population) in the first 9 frequency bins with a power law with $gamma = 13 3$. The error bars represent the 95% confidence regions (accounting for the scatter due to cosmic variance), while the shaded area indicates the 95% confidence region of the posterior for $A(f=1\/10"yr")$ (assuming again $gamma = 13 3$).

// [figvision-cn] imgs/model_com.png
// 这是一张单一子图的科学曲线图，没有子图标记a、b、c等。
// 图注说明该图展示了两种模型“HS-nod-SN-high-accr (B+20)”
// 和“HS-nod-noSN (B+20)”预测的引力波背景（GWB）振幅的分
// 箱谱，分布代表不同超大质量双黑洞（SMBHB）种群实现之间
// 的散布（宇宙方差），同时展示了幂律拟合。 坐标轴：横轴
// 为频率 f，单位 Hz，采用对数坐标，标注的主刻度为 10^-8，
// 数据范围大致从 3×10^-9 到 1×10^-7 Hz。纵轴为 log10(RMS
// /seconds)，采用线性坐标，标注的刻度从 -10 到 -5，每 1
// 个单位一个刻度，实际数据范围约为 -10 到 -4.5。 图例（
// 位于右上方）包含： 黑色虚线：f = 1/10yr，表示频率为每
// 年一次，对应图中一条垂直的黑色虚线，位于横轴约 3.17×10
// ^-9 Hz 处，贯穿整个纵轴范围。 浅蓝色实线：log10 A(f =
// 1/10yr) = -13.99, γ = 4.96，对应“HS-nod-SN-high-accr (
// B+20)”模型的幂律拟合，系数 γ 为谱指数。 浅红色实线：
// log10 A(f = 1/10yr) = -13.59, γ = 4.77，对应“
// HS-nod-noSN (B+20)”模型的幂律拟合。 浅紫色实线：log10
// A(f = 1/10yr) = -14.42, γ = 5.02，对应“HS-nod-noSN (B+
// 20)”有限分辨率模型的拟合。 橙色填充区域：EPTA DR2new，
// 表示欧洲脉冲星计时阵列第二次数据发布的新结果，以橙色带
// 显示。 浅蓝色填充区域：HS-nod-SN-high-accr (B+20)
// finite resolution，对应浅蓝色拟合线附近的分箱数据分布，
// 呈若干垂直的、横向狭窄的椭圆状“小提琴”形分布。 浅红色
// 填充区域：HS-nod-noSN (B+20) infinite resolution，对应
// 浅红色拟合线附近的分箱数据分布，同样呈若干垂直“小提琴”
// 形分布。 浅紫色填充区域：HS-nod-noSN (B+20) finite
// resolution，对应浅紫色拟合线附近的分箱数据分布，同样呈
// 若干垂直“小提琴”形分布。 图中曲线与趋势：三条幂律拟合
// 线（浅蓝、浅红、浅紫）在双对数坐标中表现为直线，均随频
// 率 f 增加而下降（纵轴值减小），斜率由谱指数 γ 决定，γ
// 越大斜率越陡。浅红色线位于最上方，浅蓝色线居中，浅紫色
// 线位于最下方。在 f = 1/10yr 处（垂直虚线位置），三个拟
// 合线对应的纵轴值分别约为 -6.6（浅红）、-6.9（浅蓝）和
// -7.1（浅紫），与图例中给出的 log10 A 值一致（注意此处
// 纵轴是 log10(RMS/seconds)，与 log10 A 有换算关系）。
// 数据分布：浅红、浅蓝、浅紫三种颜色的填充区域沿各自拟合
// 线分布，在每个频率分箱处呈垂直方向拉长的形状，宽度表示
// 该频率下预测振幅的散布（宇宙方差）。这些分箱大致出现在
// 3×10^-9、6×10^-9、1×10^-8、2×10^-8、4×10^-8、8×10^-8
// Hz 等频率处，每个分箱的纵向跨度可达约 1 个数量级（例如
// 浅红色在 10^-8 Hz 附近从约 -7.1 到 -7.4，浅蓝色从约
// -7.4 到 -7.8，浅紫色从约 -7.7 到 -8.0）。随着频率升高，
// 分箱的纵向跨度略有增大，且相邻分箱之间存在间隙。 橙色
// EPTA DR2new 区域：在最低频处（约 3×10^-9 Hz）有一个较
// 宽的纵向分布，纵轴范围约从 -6.9 到 -5.5，中心约在 -6.6；
// 随后在较高频率处出现多个较窄的垂直条带，分别位于约 6×
// 10^-9、1×10^-8、2×10^-8、4×10^-8、8×10^-8 Hz 附近，每
// 个条带的纵向范围大致从 -10 到 -7 之间，并随频率升高整
// 体向下移动。橙色区域与模型预测的填充区域在频率和振幅上
// 有部分重叠，但橙色条带的纵向跨度通常更大。 结论：该图
// 比较了两种 SMBHB 种群模型（有无超新星 kick 及不同吸积
// 模式）预测的 GWB 振幅谱与 EPTA DR2new 观测结果。模型预
// 测的幂律谱斜率 γ 在 4.77 到 5.02 之间，振幅 log10 A 在
// -14.42 到 -13.59 之间。模型预测的振幅散布（宇宙方差）
// 在低频处较窄，高频处略宽。EPTA DR2new 的橙色分布与模型
// 预测在低频处有重叠，但 EPTA 数据在部分频段的纵向散布更
// 大，且中心值偏高或偏低，表明模型预测与观测在振幅和方差
// 上存在一定差异。
#figure(image("imgs/model_com.png", width: 50.0%),
  caption: [
    Binned spectrum of the predicted GWB amplitude for models "HS-nod-SN-high-accr (B+20)" and "HS-nod-noSN (B+20)". The distribution of the predictions represents the scatter among different realizations of the SMBHB population ("cosmic variance"). Also shown are power-law fits to the predictions.
  ]
) <fig:sam2>

Overall, this qualitative comparison, while somewhat dependent on the details of the SAM implementation, suggests that #emph[(i)] large delays arising from the dynamics of black hole pairs at large $tilde 100$ pc separations are disfavoured, #emph[(ii)] SMBHB mergers proceed efficiently after their host galaxies have coalesced. Moreover, these results seem to suggest that #emph[(iii)] accretion onto SMBHs proceeds efficiently, possibly resulting in a larger local SMBH mass function at high masses.

#figure(cetz.canvas(length: 0.68cm, {
    import cetz.draw: *

    // data-space -> canvas mapping of the SAM amplitude forecasts
    let X(u) = 10.0 * u
    let Y(v) = (v + 14.6379) * 6.648
    let red = rgb("#FF0000")
    let stk = (thickness: 0.8pt, paint: red)
    let ytop = Y(-13.5158)
    let ybot = Y(-14.6379)
    let labels = (
      "HS-nod-SN-high_accr (B+20)", "HS-nod-noSN (B+20)", "LS-nod (B12)",
      "HS-nod (B12)", "Q3-nod (K+16)", "popIII-d (K+16)", "Q3-d (K+16)",
    )
    // (x position, higher (infinite-resolution) prediction, lower (finite-resolution) one)
    let dat = (
      (0.0463, (-14.0583, 0.0888), none),
      (0.1979, (-13.6387, 0.0713), (-14.5537, 0.0334)),
      (0.3489, (-13.7480, 0.0509), (-14.3041, 0.0785)),
      (0.5005, (-13.7851, 0.0520), (-14.3352, 0.0694)),
      (0.6521, (-13.7024, 0.0626), (-14.3071, 0.0979)),
      (0.8031, (-13.8443, 0.0645), (-14.3587, 0.0816)),
      (0.9542, (-13.7866, 0.0698), (-14.4232, 0.0573)),
    )

    // 95% confidence interval of the DR2new measurement
    rect((X(0), Y(-14.0772)), (X(1), Y(-13.8436)), fill: rgb("#CCE5CC"), stroke: none)

    // predictions with cosmic-variance error bars
    for d in dat {
      let x = X(d.at(0))
      for p in (d.at(1), d.at(2)) {
        if p != none {
          let (v, e) = p
          line((x, Y(v - e)), (x, Y(v + e)), stroke: stk)
          line((x - 0.11, Y(v + e)), (x + 0.11, Y(v + e)), stroke: stk)
          line((x - 0.11, Y(v - e)), (x + 0.11, Y(v - e)), stroke: stk)
          circle((x, Y(v)), radius: 0.076, fill: red, stroke: none)
        }
      }
    }

    // frame, ticks and labels
    rect((X(0), ybot), (X(1), ytop), stroke: (thickness: 1.2pt, paint: black), fill: none)
    for v in (-13.6, -13.8, -14.0, -14.2, -14.4, -14.6) {
      line((X(0) - 0.12, Y(v)), (X(0), Y(v)), stroke: (thickness: 1pt, paint: black))
      content((X(0) - 0.22, Y(v)), anchor: "east", text(size: 6.5pt)[$#v$])
    }
    for i in range(7) {
      let x = X(dat.at(i).at(0))
      line((x, ybot - 0.12), (x, ybot), stroke: (thickness: 1pt, paint: black))
      content((x, ybot - 0.18), anchor: "east", angle: 90deg, text(size: 6pt)[#labels.at(i)])
    }
    content((X(0) - 1.35, (ytop + ybot) / 2), angle: 90deg,
      text(size: 8pt)[$log_(10) A ( f = 1\/10 "yr" )$])
    content((X(0.5), ybot - 3.4), text(size: 8pt)[model (delays increasing left to right)])
  }),
  caption: [
    Predictions for $A(f=1\/10"yr")$ in various SAMs, obtained by fitting the spectrum in the first 9 frequency bins with $gamma = 13 3$ for multiple realizations of the SMBHB population. The error bars represent the 95% confidence interval for the predictions, and account for the scatter due to cosmic variance. For each model (except for the boosted accretion model HS-nod-SN-high-accr (B+20)), the higher prediction is the extrapolation to infinite SAM resolution, while the lower one is the finite-resolution prediction. The shaded area is the 95% confidence interval for the measurement of $A(f=1\/10"yr")$, fixing $gamma = 13 3$. For HS-nod-SN-high-accr (B+20) we only show the result uncorrected for resolution.
  ]
) <fig:sam3>

=== `L-Galaxies` <l-galaxies>

// [figvision-cn] imgs/SAM_LGalaxies_Predictios.png
// 这是一张单面板（无子图）的散点图，带有误差棒。图表展示
// 了不同半解析模型版本对引力波背景（GWB）特征应变振幅的
// 预测值。 坐标轴说明：纵轴标签为“log10(A @ f = (10 yr)^
// -1)”，表示在频率为10年倒数的参考频率下，特征应变振幅A
// 的以10为底的对数值，单位为无量纲。纵轴刻度范围从-14.8
// 到-13.8，主刻度间隔为0.2。横轴为分类轴，包含8个不同的
// 模型版本名称，标签逆时针旋转约60度以便阅读，从左至右依
// 次为：std、t_DF_x0.1、no_GAS_HARD、growthHDF_x10、
// boostBH1、boostBH1_growthHDF_x10、boostBH2、
// boostBH2_growthHDF_x10。 图内元素：有8个红色实心圆点，
// 代表每个模型版本的GWB特征应变振幅预测中心值。每个红点
// 上下各有一条红色垂直误差棒，误差棒的端点带有水平短横线。
// 误差棒表示考虑宇宙方差后的不确定度，图注说明是通过将
// Millennium模拟盒划分为125个子盒，计算每个子盒的GWB，取
// 这125个值的标准差作为误差棒的延伸。 图中还有两段水平黑
// 色线段，带有垂直端帽，用于对模型进行分类。第一段位于横
// 轴上方，覆盖“t_DF_x0.1”和“no_GAS_HARD”两个标签，下方标
// 注文字“Modification in dynamics”。第二段位于横轴上方，
// 覆盖“growthHDF_x10”到“boostBH1_growthHDF_x10”三个标签，
// 下方标注文字“Modification in growth”。这两段线段指示了
// 对应模型版本所代表的物理修改类型。 图中还有一条浅绿色
// 水平半透明色带，贯穿整个绘图区，范围大约从纵轴-14.07到
// -13.83。这个色带没有图注文字直接标注，推测代表观测或某
// 种参考的允许范围。 趋势与结论：不同模型版本的预测值存
// 在明显差异。基础模型“std”的log10(A)值约为-14.26。修改
// 动力学（Modification in dynamics）的两个模型“t_DF_x0.1
// ”和“no_GAS_HARD”与“std”的预测值非常接近，均在-14.24到
// -14.22之间，误差棒相互重叠。修改增长（Modification in
// growth）的模型“growthHDF_x10”的值约为-14.11，明显高于“
// std”。而“boostBH1”和“boostBH1_growthHDF_x10”的值进一步
// 升高，分别约为-13.96和-13.85，其中“
// boostBH1_growthHDF_x10”的误差棒上端触及色带上沿。最后
// 的“boostBH2”和“boostBH2_growthHDF_x10”值分别约为-14.02
// 和-13.91。总体趋势是，对增长或黑洞的修改（尤其是组合修
// 改）倾向于提高GWB特征应变振幅，而修改动力学对结果影响
// 较小。
#figure(image("imgs/SAM_LGalaxies_Predictios.png", width: 48.0%),
  caption: [
    Predictions for the GWB characteristic strain amplitude at $f = 10$ yr $""^(- 1)$ from a range of `L-Galaxies` semi-analytical model versions, assuming that $h_c ( f ) #h(0.17em) prop #h(0.17em) f^(- 2 3)$. The error bars are computed taking into account the cosmic variance. To this end, we divided the `Millennium` box into 125 sub-boxes and we compute the GWB in each one. The standard deviation provided by the 125 GWBs corresponds to the extension of our error bars.
  ]
) <fig:LGalaxies_SAM>

Next, we explore the implications that the EPTA results have for `L-Galaxies` @2015MNRAS.451.2663H @2022MNRAS.509.3488I, a sophisticated SAM constructed on the dark matter merger trees extracted from the `Millennium` simulation suite @2005Natur.435..629S @2009MNRAS.398.1150B. On top of the galaxy physics, `L-Galaxies` features a comprehensive modelling for the assembly of SMBHs, including gas accretion triggered by galactic mergers and disc instabilities and dynamical evolution of SMBHBs within the galaxy merger process. The latter accounts for dynamical friction (DF), stellar and gas hardening and, eventually, GW emission. All of these processes are governed by a set of parameters that are tuned to reproduce a vast array of observations including, among others, the galaxy mass function and morphological distribution, the quasar luminosity function and the SMBH-host galaxy relations.

@2022MNRAS.509.3488I found that the standard `L-Galaxies` tuning results in a GWB with $log_(10) A = -14.9$ at $f_0=1"yr"^(-1)$, lower than that measured in `DR2new`. Here we perform a systematic investigation of how the stochastic GWB at nanohertz frequencies depends upon the parameters governing the physics of SMBHs and SMBHBs in the SAM. To this aim, we run `L-Galaxies` in the following configurations:

- `std`: standard configuration @2022MNRAS.509.3488I

- `t_DF_x0.1`: SMBH dynamical friction (DF) time reduced by a factor of ten;

- `NO_GAS_HARD`: only stellar hardening;

- `growthDF_x10`: accretion boosted by ten in the DF phase;

- `boostBH1`: gas accretion doubled after galaxy mergers and disc instabilities;

- `boostBH2` gas accretion doubled after galaxy mergers and tripled after disc instabilities.

- `boostBH1_growthDF_x10`: adding accretion boost in the DF phase to model `boostBH1`

- `boostBH2_growthDF_x10`: adding accretion boost in the DF phase to model `boostBH2`

Results are shown in Fig. Changes to the dynamics of SMBHs appear to have a minor effect on the amplitude of the GWB. While shortening the DF time (`t_DF_x0.1`) allows more SMBHBs to merge within the Hubble time, the most massive ones, which are responsible for the bulk of the GW signal, already have short DF timescales, and the overall GW signal is only mildly increased. Turning off gas hardening results in longer-lived SMBHBs that tend to merge at lower redshifts, resulting in louder GW signals. The effect is, however, negligible.

Conversely, the tuning of gas accretion can significantly change the masses of the SMBHBs, resulting in a larger impact on the GWB. Model `growthDF_x10` leaves the general population of SMBHs untouched, only boosting the growth of those in the dynamical friction phase. This alone increases the level of the GWB by a factor $approx 1.5$ compared to model `std`. Finally, the models `boostBH1` and `boostBH2` increase the gas accretion onto the whole population of SMBHs, making the GWB a factor of 2.5 louder with respect to the baseline model. Boosting accretion onto the whole population #emph[and] in the hardening phase further amplifies the expected GWB, reaching the upper bound of the measured value (models `boostBH1_growthDF_x10` and `boostBH2_growthDF_x10` in the figure). Although these models can accommodate the GWB signal measured in PTAs, the boosted accretion and subsequently larger SMBH masses can make it harder to reproduce the observed SMBH mass and quasar luminosity functions @2022MNRAS.509.3488I. Additionally, more work is required to find a model that can reproduce all observational constraints in the light of the PTA GW signal (Izquierdo-Villalba et al. in preparation).

== Further considerations on the measured spectrum: eccentricity and statistical biases. <sec:considerations>

The analyses presented so far give strong indications that the signal is compatible with a cosmic population of SMBHBs swiftly coalescing in the aftermath of galaxy mergers. The relatively flat slope of the measured spectrum might be indicative of strong environmental coupling and high eccentricities, although inference from the data is inconclusive in this respect (see @fig:smbhb_astinformed_selected_corner).

The eccentricity of SMBHBs is of particular relevance as it might carry important information on the dynamical processes driving binary evolution at sub-pc scales (see e.g. #cite(<2012JPhCS.363a2035R>, style: "aas_noparen.csl")). While gas-driven dynamics is expected to saturate the binary eccentricity at a value $e approx 0.4 - 0.6$ @2011MNRAS.415.3033R @2021ApJ...914L..21D, stellar hardening is known to statistically increase eccentricity without any saturation point @1996NewA....1...35Q, potentially leading to extremely eccentric systems @2010ApJ...719..851S. A large binary eccentricity has two important implications for the interpretation of the current data: it flattens the low-frequency spectrum and it speeds up the SMBHB merger process, as inferred by the small $tau_0$ derived in @sec:MBHB_inference.

// [figvision-cn] imgs/Mencl4_bhs_SepAndOrbitalParam_new.png
// 这是一张包含三个纵向排列子图的科学论文插图，展示了一个
// 星系并合过程中形成的超大质量双黑洞（SMBHB）的轨道参数
// 随时间演化的数值模拟结果。三个子图共享相同的横坐标轴，
// 表示时间，单位为 Myr（兆年），范围为 0 到 600。横轴标
// 签为“time [Myr]”，刻度主要标注间隔为 100，次要刻度间隔
// 为 50。 子图 (a) 为曲线图，纵轴标签为“d [kpc]”，表示双
// 黑洞之间的瞬时距离，纵轴采用对数坐标，范围约从 10^-3
// 到略高于 10^1。图的左下角有一个图例，标注红色虚线示意
// 线型对应“a_f”。图中的主导曲线是一条黑色实线，展示了距
// 离随时间的快速且剧烈的变化。该曲线从时间 0 开始，起始
// 值约为 20 kpc，随后缓慢下降。在约 150 Myr 和 260 Myr
// 附近，曲线出现急剧的、深达约 10^-1 kpc 的尖峰（V形下凹）。
// 之后在约 350 Myr 之后，曲线呈现出连续的高频振荡并持续
// 衰减，振幅逐渐减小，最终在时间 600 Myr 时，距离稳定在
// 10^-2 至 10^-3 kpc 之间。在图中约 390 Myr 至 440 Myr
// 的时间段，绘制了一段水平的红色虚线，表示 a_f 的参考值，
// 其对应的纵轴位置约在 4×10^-2 kpc 处。 子图 (b) 为曲线
// 图，纵轴标签为“a [kpc]”，表示双黑洞轨道的半长轴，纵轴
// 同样采用对数坐标，范围与子图 (a) 一致。图中的数据由离
// 散的红色圆点和一条黑色实线组成。红色圆点散布在时间轴的
// 不同位置，它们的值在 0 Myr 时约为 20 kpc，在约 150 Myr
// 和 260 Myr 时保持在约 10 kpc 附近，在 300 Myr 之后逐渐
// 降低到约 1 kpc，在 380 Myr 附近降至 10^-1 kpc 量级。黑
// 色实线主要描绘了 350 Myr 之后的演化趋势，与红点走势基
// 本吻合，但在 200 Myr、350 Myr、380 Myr 和 400 Myr 等几
// 个特定时刻，实线出现了向下的深垂直尖峰，最低可降至 10^
// -1 kpc 以下。曲线在 450 Myr 后稳定在 10^-2 kpc 附近，
// 并伴有小幅振荡。图中的红色圆点代表离散的测量或采样数据
// 点。 子图 (c) 为曲线图，纵轴标签为“e”，表示轨道偏心率，
// 纵轴为线性坐标，范围从 0.0 到 1.0，刻度间隔为 0.2。图
// 的左下角有一个图例，标注蓝色虚线示意线型对应“e_f”。该
// 图同样由蓝色散点和黑色实线组成。在时间 0 至 300 Myr 之
// 间，蓝色散点显示偏心率基本维持在 0.9 到 1.0 之间的高值。
// 随着时间推移，蓝色散点在 300 Myr 后呈下降趋势，在 350
// Myr 时降至 0.6 左右。黑色实线在 350 Myr 之前与散点趋势
// 大体一致，但在 200 Myr 和 360 Myr 附近出现了急剧的向下
// 垂直尖峰，分别降至 0.4 和 0.7 以下。在 400 Myr 之后，
// 曲线出现密集的振荡。在 400 Myr 至 450 Myr 的时间段内，
// 绘制了一段水平的蓝色虚线，对应偏心率值约为 0.8，代表
// e_f 的参考值。最终在 600 Myr 时，偏心率振荡下降至约
// 0.7 到 0.9 之间。
#figure(image("imgs/Mencl4_bhs_SepAndOrbitalParam_new.png", width: 52.0%),
  caption: [
    Orbital parameters (distance between the SMBHs, semi-major axis and eccentricity) of a SMBHB formed in a representative $N$-body simulation of a galactic merger with parameters drawn from progenitors of likely PTA sources in the `IllustrisTNG100-1` cosmological simulation. Mergers are selected from the merger trees of the 100 most massive galaxies at $z = 0$, based on galaxy mass ratio (major mergers with mass ratio $1 : 4$ or higher) and redshift ($z lt.eq 2$). The dashed lines indicate the critical separation $a_f$ and the corresponding eccentricity $e_f$ at the time in the evolution marking approximately the end of the SMBH inspiral due to DF and the beginning of the hardening phase. Dots represent $a$ and $e$ computed from the apoastron-periastron separation of the two SMBHs #emph[before] pairing in a bound binary.
  ]
) <fig:ecc>

// [figvision-cn] imgs/efac_test_1040realinj10y.png
// 图像由三个子图组成，呈倒L形布局：左下方为二维后验分布
// 等高线图，左上方和右下方分别为对应参数的一维边缘后验分
// 布直方图。 二维等高线图（左下）：横轴为 γ=3-2α，范围约
// 2 至 6；纵轴为 log10A(f=1/10yr)，范围约 -14.4 至 -13.8。
// 图中包含橙色、蓝色、绿色三组由散点形成的等高线（1σ 和
// 2σ 置信区间），以及一个位于 (4.33, -14.0) 的灰色方形标
// 记，代表注入值。蓝色和绿色等高线分别对应图中未完全显示
// 的 EFAC 设置。图中还有一条水平蓝线和一条垂直蓝线，分别
// 经过注入值的纵坐标和横坐标。 左上直方图：横轴同二维图
// 横轴，纵轴为概率密度（未标数值）。三条阶梯状曲线（橙色、
// 蓝色、绿色）展示边缘后验分布，橙色分布偏向低值，绿色分
// 布偏向高值。图上方标注文字为 "γ=3 - 2α = 3.66_{-0.52}^
// {+0.56}"。 右下直方图：横轴为 log10A(f=1/10yr)，范围
// -14.4 至 -13.8，刻度标签旋转 45 度；纵轴为概率密度。三
// 条阶梯状曲线展示边缘后验分布。图上方标注文字为 "log10A
// (f=1/10yr) = -14.05_{-0.08}^{+0.08}"。图中有一条垂直蓝
// 线位于 -14.05 处。 整体趋势：注入值（灰色方块）落在蓝
// 色等高线中心附近，表明理想数据集下后验分布无偏；橙色和
// 绿色等高线相对蓝色有偏移，说明高频噪声模型错误（EFAC
// 设置不同）会导致参数恢复出现偏差。
// [figvision-cn] imgs/efac_test_1040realinj10y.png
// 图像由三个子图组成，呈倒L形布局：左下方为二维后验分布
// 等高线图，左上方和右下方分别为对应参数的一维边缘后验分
// 布直方图。 二维等高线图（左下）：横轴为 γ=3-2α，范围约
// 2 至 6；纵轴为 log10A(f=1/10yr)，范围约 -14.4 至 -13.8。
// 图中包含橙色、蓝色、绿色三组由散点形成的等高线（1σ 和
// 2σ 置信区间），以及一个位于 (4.33, -14.0) 的灰色方形标
// 记，代表注入值。蓝色和绿色等高线分别对应图中未完全显示
// 的 EFAC 设置。图中还有一条水平蓝线和一条垂直蓝线，分别
// 经过注入值的纵坐标和横坐标。 左上直方图：横轴同二维图
// 横轴，纵轴为概率密度（未标数值）。三条阶梯状曲线（橙色、
// 蓝色、绿色）展示边缘后验分布，橙色分布偏向低值，绿色分
// 布偏向高值。图上方标注文字为 "γ=3 - 2α = 3.66_{-0.52}^
// {+0.56}"。 右下直方图：横轴为 log10A(f=1/10yr)，范围
// -14.4 至 -13.8，刻度标签旋转 45 度；纵轴为概率密度。三
// 条阶梯状曲线展示边缘后验分布。图上方标注文字为 "log10A
// (f=1/10yr) = -14.05_{-0.08}^{+0.08}"。图中有一条垂直蓝
// 线位于 -14.05 处。 整体趋势：注入值（灰色方块）落在蓝
// 色等高线中心附近，表明理想数据集下后验分布无偏；橙色和
// 绿色等高线相对蓝色有偏移，说明高频噪声模型错误（EFAC
// 设置不同）会导致参数恢复出现偏差。
#figure(placement: top, [#box(image("imgs/posterior10y_univ1004_realinj.png", width: 45.0%)) #box(image("imgs/efac_test_1040realinj10y.png", width: 50.0%))

  ],
  caption: [
    Posterior distributions of the recovered GWB from injections on synthetic data mimicking `DR2new`. Top panel: statistical offset in an ideal dataset. The square marks the injected value and the blue contours are 1 $sigma$ and 2 $sigma$ of the recovered posterior. Bottom panel: effect of high-frequency noise mismodeling on the recovery. The orange, blue and green contours are respectively obtained when EFAC $= 0.8 1, 1.2$ are used for the recovery (injected EFAC $= 1$).
  ]
) <fig:recovery_bias>

Low-redshift massive galaxies are generally gas-poor, and stellar-driven hardening represents the main mechanism driving the evolution of the binaries comprising the bulk of the PTA GW signal. Modelling the whole dynamical evolution, from the first galaxy encounter to black hole pairing and final coalescence, is theoretically and numerically challenging and has been the subject of many studies, e.g., @2011ApJ...732L..26P, @2012ApJ...749..147K, @2016ApJ...828...73K, @2021MNRAS.502.4794N and @2022MNRAS.511.4753G. In particular, the binary eccentricity is very sensitive to the initial orbits of the merging galaxies @2022MNRAS.511.4753G.

In ongoing work (Fastidio et al. in prep), we are connecting the sub-pc dynamics of SMBHBs to the large-scale parameters of the galactic encounters extracted from the `IllustrisTNG100` simulation @2018MNRAS.473.4077P Preliminary results show that mergers of massive galaxies occur preferentially on nearly radial orbits, potentially resulting in highly eccentric binaries. @fig:ecc shows the orbital parameters of a SMBHB formed in a high-accuracy $N$-body simulation of a representative galactic merger with properties taken from a merger tree in `IllustrisTNG100`. Merger trees are selected to represent likely PTA sources at low redshifts. The galactic merger is followed from early times through the inspiral, pairing and hardening of the SMBHs via a hybrid numerical scheme able to model the evolution self-consistently from kpc to mpc scales @2014ComAC...1....1D Despite the intrinsic stochasticity of the processes driving binary formation and hardening @2020MNRAS.497..739N, binaries tend to form with a large eccentricity, which then further grows due to encounters with background stars, as also found by scattering experiments @2010ApJ...719..851S.

Although more work is needed to determine the distribution of expected binary eccentricities and current EPTA data are not yet strongly informative, this pilot study shows the potential of using these measurements in the near future to constrain the physics of galaxy and SMBH mergers.

When drawing conclusions on the physical properties of the sources of the GW signal, it is useful to bear in mind not only that the constraints on the spectrum are relatively loose (see @fig:EPTADR2), but also that the measured parameters can be subject to statistical and systematic biases. To address this, we are conducting an extensive campaign of simulations by injecting and recovering different types of signals in synthetic PTAs mimicking the properties of the EPTA `DR2new` dataset #cite(<2024A-A...683A.201V>). We generated individual noises for 25 pulsars using the maximum likelihood values of the measured white noise and drew the red noise and dispersion measure parameters from the posterior distribution of the customised noise models @wm2. We simulated TOAs from multi-frequency observations and added a GWB spectrum from an astrophysical population of circular SMBHBs producing a nominal GWB with $A_(1"yr"^(-1))=2.5times 10^(-15)$, consistent with the `DR2new` measurement at $gamma = 13 3$. We performed 100 experiments by changing the specific noise realization and the sampling of the injected SMBHB population. The analysis was carried using the `ENTERPRISE` software package @2020zndo...4059815E.

Two illustrative examples of injection-recovery mismatch are shown in @fig:recovery_bias. The top panel shows one of the GWB recoveries. Although the injection did not present particular features (e.g. loud CGWs), for this specific noise realization, the recovered signal has a shallow slope with a median value of $gamma = 3.10$. Similar cases have been observed when injecting a pure $gamma = 13 3$ power law with the `createGWB` function of `libstempo` @2020ascl.soft02017V. This shows that even with an ideal setup when simultaneously fitting multiple parameters (102 in this case) in a complex problem, the stochastic properties of the noise can easily bias the recovered signal, especially if the S/N is low (S/N $approx 3.5$ for `DR2new`). Multiple injections with the realistic GWB model and `createGWB` show systematic biases of recovery of the realistic GWB signal, when modelled with an ideal power law. This is explored in detail in a follow-up work. In the bottom panel of @fig:recovery_bias, we show how the presence of some extra high-frequency noise unaccounted for in the MSP noise model can also influence the recovery of the parameters. The setup is the same as in the left panel, but we simulate high-frequency noise mismatch by setting different values of EFAC $= 0.8 1, 1.2$ in the recovery. Although the posterior of the signal amplitude is hardly affected, $gamma$ can shift significantly depending on whether the high-frequency noise is slightly over- or under-estimated. While these are only two examples, they highlight the complexity of PTA measurements and invite us to be cautious when drawing conclusions that might strongly be influenced by potential biases in the recovered signal.

= Implications II: physics of the early Universe <sec:early_universe>

Although a GWB generated by an ensemble of the putative SMBHBs is the most plausible source of the observed common-red noise process in pulsar data, more exotic explanations are possible, such as signals originated in the early Universe. The various possible types of cosmological backgrounds of GWs associated with early Universe physics are reviewed in @2018CQGra..35p3001C and are found to be stochastic. Similarly to the traditional case invoking SMBHBs, the angular spatial correlation for those scenarios follows the HD curve. However, the spectral shapes of the predicted GW spectra are generally different, which can help to disentangle between different types of backgrounds. In this work, we focus on four possible scenarios:

+ an inflationary GWB from the amplification of quantum fluctuations of the gravitational field,

+ a GWB from a network of cosmic string loops,

+ a GWB from vortical (M)HD turbulence at the QCD energy scale,

+ a scalar-induced GWB arising from inflationary scalar perturbations at the 2nd order in perturbation theory.

Given the low significance of the detected signal and the limited number of probed frequency bins due to the short timespan of the data, one cannot currently perform a reliable model selection. Therefore, throughout the section, we consider these scenarios separately and assume that each of them can fully explain the detected signal independently. Analysis invoking more complex models with simultaneous fits for multiple scenarios as well as opportunities to disentangle between those~@ppta-22 will be considered in a number of future works.

== <sec:inf>Implications on a stochastic background of primordial (inflationary) gravitational waves
<implications-on-a-stochastic-background-of-primordial-inflationary-gravitational-waves>

Here we address the GWB possibly generated during inflation @1975JETP...40..409G @1982PhLB..115..189R @1985SvAL...11..133S @1983PhLB..125..445F @1984NuPhB.244..541A. In the standard inflationary scenario, tensor quantum vacuum fluctuations of the metric are amplified by the accelerated expansion, leading to a GWB as they subsequently re-enter the horizon during the radiation (or matter) era. The cosmic microwave background (CMB) and Big Bang Nucleosynthesis (BBN) provide precise measurements of the radiation energy density, from which one can derive weak upper bounds on the amplitude of such a GWB (see e.g. #cite(<2018CQGra..35p3001C>, style: "aas_noparen.csl"), and references therein). Furthermore, tensor metric perturbations lead to CMB temperature anisotropies and polarisation at large angular scales @1967ApJ...147...73S @1985SvAL...11..133S @1996AnPhy.246...49K @1994PhRvD..50.3713A. Since the anisotropies and polarisation detected so far are due to scalar perturbations, it is possible to constrain the energy density of a GW background by placing an upper limit on the tensor-to-scalar ratio $r$ at CMB scales: recent upper bounds are given e.g.~in @2022PhRvD.105h3524T @2023JCAP...04..062G. Another parameter to consider is the tensor spectral index $n_T$ of the tensor perturbations. In the context of slow-roll single-field inflation, these two parameters are linked via the consistency relation $r = - 8 n_T$. By fixing the consistency relation, @2022PhRvD.105h3524T finds $r < 0.032$ at 95% CL, while by relaxing it, #cite(<2020A-A...641A..10P>) finds $r < 0.076$ and $- 0.55 < n_T < 2.54$ at 95% CL.

Within the slow-roll consistency relation, the GWB spectral slope is therefore slightly red-tilted, causing this signal to be out of reach of most current and planned GW detectors such as PTAs, LISA, aLIGO, aVirgo or the Einstein Telescope. On the other hand, it is fair to consider that the spectral slope could vary over the large frequency span ranging from CMB scales to those probed by GW detectors @2016PhRvX...6a1035L Inflationary scenarios breaking the consistency relation at small scales might therefore produce a detectable GWB, if they lead to a blue-tilted spectrum. In this case, PTAs, LISA and ground-based devices can place upper limits on $n_T$ @2017PhRvL.118l1101A. It is interesting to investigate which kinds of processes could give rise to a blue-tilted GW background while still obeying CMB constraints at large scales. One possibility is the presence, after inflation, of a stiff component in the Universe, with an equation of state $w > 1\/3$@2008PhRvD..78d3531B @1998PhRvD..58h3504G @2008PhRvD..77f3504B. The enhancement of the tensor spectra can also be produced during inflation thanks to processes such as, for example, (i) particle production during inflation (see e.g. #cite(<2011JCAP...06..003S>, style: "aas_noparen.csl") #cite(<2012PhRvD..86j3508B>, style: "aas_noparen.csl") #cite(<2013JCAP...11..047C>, style: "aas_noparen.csl") #cite(<2012PhRvD..85l3537A>, style: "aas_noparen.csl") #cite(<2016JCAP...12..026B>, style: "aas_noparen.csl")) (ii) enhancement of tensor perturbations for example by spectator fields, or space-dependent inflation (see e.g. #cite(<2007PhRvD..76f1302B>, style: "aas_noparen.csl") #cite(<2013PhRvD..88j3518B>, style: "aas_noparen.csl") #cite(<2015JCAP...04..011B>, style: "aas_noparen.csl") #cite(<2015PTEP.2015d3E01F>, style: "aas_noparen.csl")) (iii) modified gravity theories such as $f ( R )$ or Horndeski gravity (#cite(<1974IJTP...10..363H>, style: "aas_noparen.csl") #cite(<2010RvMP...82..451S>, style: "aas_noparen.csl")) and iv) enhanced scalar perturbations at small scales and/or primordial black holes, which are treated in @sec:secondorder.

=== Analysis <analysis>

Similarly to what was done in @sec:secondorder, we constrain the key parameters defining the GWB,

 $r$ and

 $n_T$,

while being agnostic on the underlying process generating the blue-tilted spectrum.

If we assume that the common quadrupolar red noise signal present in EPTA data is of inflationary origin, these two parameters can be estimated using the `DR2new` dataset. Note that the spectral index $n_T$ is expected to vary with the frequency scale considered (see e.g. #cite(<2021PhLB..81536137G>, style: "aas_noparen.csl") #cite(<2023MNRAS.520.1757G>, style: "aas_noparen.csl") #cite(<2022PhRvD.106f3512A>, style: "aas_noparen.csl")). However, for simplicity, here we consider a constant $n_T$ all the way from CMB scales to those corresponding to the (narrow) EPTA frequency band. It is then possible to approximate the fractional characteristic GW energy density using @2016PhRvX...6a1035L @2018CQGra..35p3001C.

$
  Omega_"GW" (f) &= frac(3, 128) Omega_"rad" r cal(P)^("*")_(cal(R)) (f \/ f_("*"))^(n_T) [1\/2 (f_"eq" \/ f)^2 + 16\/9] \
  &approx 1.5 times 10^(-16) (r \/ 0.032) (f \/ f_("*"))^(n_T)
$<eq:infspectrum>

where the second line is valid in the PTA frequency band, and has been obtained by setting $h^2Omega_"rad"=2.47dot 10^(-5)$ with $h = 0.67$, the amplitude of the scalar spectrum $cal(P)_(cal(R))^(*) = 2 dot.op 10^(- 9)$, and $f_(*) approx 7.7 times 10^(- 17)$ Hz related to the CMB pivot scale $k_("*")=0.05\/"Mpc"$#cite(<2014A-A...571A..16P>). $f_"eq"$ denotes the frequency entering the horizon at matter-radiation equality.

We then use the nine lowest frequency posteriors of the RMS free spectrum shown in @fig:EPTADR2 @2021NatAs...5.1268M @Taylor_NFS @Leclere:2023ryt (for details on the method) to fit the inflationary spectrum of @eq:infspectrum and obtain posteriors on $log_10 r$ and $n_T$. Results are reported in @fig:inflation_post. Note that, since $gamma = 5 - n_T$, the correlation between the amplitude and spectral index of the signal is compatible with @fig:corner_A10yr_gamma.

The 90% credible (symmetric) intervals are $log_10 r = - 12.18_(- 7.00)^(+ 8.81)$ and $n_T = 2.29_(- 1.11)^(+ 0.87)$. The obtained value of $n_T$ corresponds to a PSD spectral index of $gamma tilde.eq 2.7$, as in @fig:EPTADR2. The excessively small value of $r$ is a consequence of the simplistic parameterisation of @eq:infspectrum, which assumes a constant $n_T$ at all scales. The fractional energy density spectrum obtained from the maximum a posteriori parameter values is plotted in @fig:spectrum_plot.

We have so far considered a primordial background to be the only source of GWs in our data. We now recall that the most plausible and loud source of a GW background at these frequencies remains that of a SMBHB background. It is therefore likely that any signature for a cosmological background needs to be considered in parallel with a SMBHB background, or in this case more accurately termed 'foreground'. @2022ApJ...938..115K have explored the likelihood of detecting a cosmological background in the presence of a SMBHB foreground using simulations, and found that the shallower the slope of the cosmological background (for example $gamma = 4$ as opposed to $gamma = 5$), the harder it is to detect (and the longer it takes, possibly more than 20 years). According to these simulations, this does not bode well for an even shallower slope, similar to the one detected in `DR2new` with a possible $gamma < 3$.

Here we explore a superposition of these two backgrounds in the `DR2new` dataset. Considering a two-component GWB for the common red noise model, we place constraints on $log_10 r$ for given values of $n_T$ spanning the range $[ - 1, 3 ]$. In this case, our null hypothesis is a GWB from a population of GW-driven circular SMBHBs parameterised only by the PSD amplitude $log_10 A$ of @eq:sh (we fix $gamma = 13 3$). We run several analyses with a fixed $n_T$ for the inflationary background, sampling over $( log_10 r log_10 A )$. For each of the $n_T$ values, we obtain a distribution for $log_10 r$ and take the 95% quantile as an upper bound. As found in @2016PhRvX...6a1035L, $n_T$ and the $log_10 r$ upper bounds are related with good precision by a linear relation: $n_T = a log_10 (r\/0.032) + b .$ Our analysis gives $a = - 0.16$ and $b = 0.70$, which is comparable to the forecast values given in @2016PhRvX...6a1035L (note that they normalise $r$ to 0.11).

=== Discussion <discussion>

From the analysis of the `DR2new` dataset above, we have obtained credible intervals for the tensor-to-scalar ratio $r$ and the spectral index $n_T$. This was performed assuming that reheating is instantaneous, and that inflation is followed directly by the radiation-dominated era, for which the equation of state parameter of the Universe is $w = 1\/3$. Under this assumption, one finds that the best-fit value for the tensor spectral index is $n_T = 5 - gamma tilde.eq 2.3$, which is directly linked to the best-fit PSD spectral index $gamma tilde.eq 2.7$. This high value of $n_T$ is not consistent with slow roll inflation. However, if inflation is followed by a stage in which $w eq.not 1\/3$, the relation between the PSD spectral index $gamma$ and the primordial tensor spectral index $n_T$ changes to @2016ApJ...821...13A @2018CQGra..35p3001C.

$
  gamma = 5 - n_T + frac(2 ( 1 - 3 w ), 3 w + 1)
$<eq:stiff>

 again with $gamma tilde.eq 2.7$. If a stiff fluid component ($w > 1\/3$) were to dominate the Universe for a finite amount of time after inflation, the last term in @eq:stiff would be bounded between 0 and $- 2$. Hence, $n_T gt.tilde 0.3$, meaning that even allowing for the presence of a stiff component after inflation, it does not seem possible to explain the common red noise in the context of slow roll inflation ($n_T tilde.eq 0$) for the best fit value $gamma tilde.eq 2.7$. However, by broadening the range of possible values to $gamma gt.eq 3$, $n_T tilde.eq 0$ does become compatible with the common red noise.

// [figvision-cn] imgs/corner_INF_post.png
// 这是一张由三个子图组成的科学论文二维后验概率分布图，整
// 体布局为一个左下角的二维等高线图（子图b）以及分别位于
// 其上方和右侧的一维边缘直方图（子图a和子图c）。整张图没
// 有显示明显的子图字母标号，但可依据布局和坐标轴进行明确
// 区分。 子图b（左下角二维等高线图）：该图类型为等高线图
// （二维后验概率分布）。横轴名称为 log10 r，表示张标比 r
// 的以10为底的对数，坐标轴刻度范围从约 -35 到 5，主要刻
// 度标记为 -30、-20、-10、0。纵轴名称为 nT，表示在脉冲星
// 计时阵列（PTA）频率范围内的分数能量密度谱指数，坐标轴
// 刻度范围从 0.0 到约 5.0，主要刻度标记为 0.0、1.5、3.0、
// 4.5。图中包含两个填充蓝色的置信区域，颜色映射为单一蓝
// 色系：内部较深的蓝色填充区域代表 68% 的置信区间（
// credible region），外部较浅的蓝色填充区域代表 95% 的置
// 信区间。这两层区域呈左下至右上倾斜的椭圆状，显示 log10
// r 与 nT 之间存在明显的正相关趋势。图中有一条黑色的垂直
// 虚线，位于 log10 r = 0 处（即 r = 1），这条线代表在单
// 场慢滚暴胀（single-field slow-roll inflation）假设下得
// 到的张标比上限。二维等高线区域主要位于这条虚线的左侧，
// 表明数据支持 r 小于 1。 子图a（左上角一维边缘直方图）：
// 该图类型为阶梯状直方图，是子图b横轴变量 log10 r 的一维
// 边缘后验分布。其横轴与下方子图b共享相同的 log10 r 刻度
// （范围 -35 至 5）。纵轴没有显示刻度标签，代表概率密度。
// 直方图由一条蓝色阶梯曲线绘制，呈现单峰分布，峰值大致位
// 于 log10 r = -12 到 -10 之间，分布向右侧（较大的 r 值）
// 延伸并逐渐降至零。图中标注的文字为数学公式：log10 r =
// -12.18^{+8.81}_{-7.00}，表示该参数的后验中位数及上下 1
// σ 不确定度。与子图b相同，在 log10 r = 0 处画有一条黑色
// 垂直虚线，直方图的主体分布均位于该虚线左侧，进一步说明
// r 的取值远低于慢滚暴胀上限。 子图c（右下角一维边缘直方
// 图）：该图类型为阶梯状直方图，是子图b纵轴变量 nT 的一
// 维边缘后验分布。其纵轴与左侧子图b共享相同的 nT 刻度（
// 0.0 至 5.0）。其横轴没有显示刻度标签，代表概率密度。直
// 方图由一条蓝色阶梯曲线绘制，同样呈现单峰分布，峰值位于
// nT 约 2.0 至 2.5 之间，分布向左延伸至 0 附近，向右延伸
// 至约 4.0。图中标注的文字为数学公式：nT = 2.29^{+0.87}_
// {-1.11}，表示 nT 的后验中位数及上下 1σ 不确定度。 总体
// 趋势与结论：该图展示了张标比（以 log10 r 表示）与 PTA
// 频率范围内的谱指数 nT 的联合后验约束。二维和一位分布均
// 显示 log10 r 的取值极低（中位数约 -12.18），且其 95%
// 置信区间完全位于慢滚暴胀预言的上限（log10 r = 0 的垂直
// 虚线）之下，表明当前数据强烈不支持单场慢滚暴胀模型所预
// 言的张标比量级。同时，nT 的后验分布表明该谱指数显著非
// 零（中位数约 2.29），且与 log10 r 呈正相关。
#figure(image("imgs/corner_INF_post.png", width: 46.0%),
  caption: [
    2D posteriors of the tensor-to-scalar ratio (in $log_10$) and the fractional energy density spectral index $n_T$ in the PTA frequency range. The 68% and 95% credible regions are displayed. The black dashed line represents the tensor-to-scalar ratio upper bound found in @2022PhRvD.105h3524T assuming single-field slow-roll inflation.
  ]
) <fig:inflation_post>

== Implications on a background of cosmic strings <implications-on-a-background-of-cosmic-strings>

Cosmic strings are line-like topological defects that may form after a symmetry-breaking phase transition in the early Universe @Kibble:1976sj @Hindmarsh:1994re; they are generic predictions of most Grand Unification Theories scenarios @Jeannerot:2003qv. These 1D objects are characterised by the string tension $G mu$ (or equivalently their energy per unit length) which is related to the energy scale of the phase transition.

Overall, cosmic strings combine relativistic velocities and large energy densities, making them natural sources of GWs. These GWs may take the form of bursts from cusps, kinks and kink-kink collisions on the loops @Damour:2001bk, and have been searched for in the LIGO/Virgo/KAGRA (LVK) detectors @Damour:2001bk @LIGOScientific:2017ikf @LIGOScientific:2021nrg Cusps are points on the string which, in the Nambu-Goto approximation, propagate at the speed of light, and the string doubles back on itself. On the other hand, kinks are discontinuities in the tangent vector of a string and are formed at each intercommutation of strings. The future space-based detector LISA will be sensitive to cosmic string bursts for tensions as low as $G mu tilde 10^(- 11)$@Auclair:2023brk. Most notably, in the event that LISA detects GW bursts from cosmic strings, they will likely repeat multiple times a year due to the periodic nature of the cosmic string loops @Auclair:2023mhe.

The incoherent sum of these GW bursts also produces a stochastic GWB (SGWB), which has been looked for by LVK @LIGOScientific:2017ikf @LIGOScientific:2021nrg LISA is expected to be able to detect a SGWB from cosmic strings with tensions as low as $G mu tilde 10^(- 17)$ @Auclair:2019wcv. The strings background has already been looked for in EPTA @Sanidas:2012ee @Leclere:2023ryt, in NANOGrav @Blasi:2020mfx @Ellis:2020ena and PPTA @Bian:2022tju @Chen:2022azo. These earlier analyses consistently found a good agreement between the common uncorrelated red signal (CURN) present in the data and a SGWB from cosmic strings with tensions $G mu tilde 10^(- 10) - 10^(- 11)$.

=== Description of the models <description-of-the-models-dup2>

Since the SGWB is sourced by sub-horizon cosmic string loops, the central quantity in our analysis is the loop density distribution, $bold("n") ( ell t )$, where $ell$ is the invariant length of the loop (defined by its total energy divided by $mu$) and $t$ is cosmic time. We focus on the most up-to-date loop distributions, calibrated on large scales with Nambu-Goto simulations @Lorenz:2010sm @Blanco-Pillado:2013qja  Loops are formed from the intercommutation of super-Horizon infinite strings, with a maximal size $ell approx 0.1 t$ at time $t$. (Note that the simulations assume an intercommutation probability of $1$, as is the case for field theory strings.) The two models --- which we refer to as BOS @Blanco-Pillado:2015ana and LRS @Blanco-Pillado:2015ana, after the names of their authors --- differ in their treatment of small loops, particularly on scales at which gravitational radiation (not included in numerical simulations) can have important effects. Indeed, compared to the BOS model, the LRS model has an additional population of small loops, which leaves an imprint in the SGWB spectrum @Auclair:2020oww. The explicit expressions for the two loop distributions are given in @Auclair:2020oww, and both have been considered by the LVK @LIGOScientific:2017ikf and LISA @Auclair:2019wcv collaborations. The third observing run of LVK placed constraints on $G mu$, based on the non-detection of a SGWB. These are $G mu lt.tilde 10^(- 8)$ for BOS and $G mu lt.tilde 10^(- 15)$ for LRS. At the frequency of ground-based detectors, the SGWB signal is produced by loops formed during the radiation era. At low PTA frequencies, the SGWB signal is dominated by larger loops, namely those formed at recent times, in transition from the radiation to matter era and also in the matter era @Ringeval:2017eww @Auclair:2020oww @Leclere:2023ryt.

Other than $G mu$, a further parameter appears in $bold("n") ( ell t )$, namely $Gamma$, which describes the rate at which loops lose energy through gravitational radiation: $dot(ell) = - Gamma G mu$. If $Gamma$ is large, fewer loops are present in the distribution since loops decay more rapidly. On the other hand, GWs are emitted more intensively: the final effect is a combination of these two, which impacts the SGWB of the BOS and LRS models in subtly different ways @Auclair:2020oww. The value of $Gamma$ depends on the properties of loops, and in particular on how many cusps, kinks, and kink-kink they contain as #cite(<Damour:2001bk>) #cite(<Siemens:2006yp>) #cite(<Ringeval:2017eww>)

$
  Gamma = N_c Gamma^c + N_k Gamma^k + frac(N_k^2, 4) Gamma^(k k),
$ <eq:total-Gamma>

where $N_(c,k)$ is the number of cusps/kink events per oscillation period of the loop, $N_k^2\/4$ the number of kink-kink collisions, and

$
  Gamma^c = frac(3 (pi g_1^c)^2, 2^(1\/3) g_2^(2\/3)), quad Gamma^k = frac(3 (pi g_1^k)^2, 2^(2\/3) g_2^(1\/3)), quad Gamma^(k k) = 2 (pi g_1^(k k))^2,
$ <eq:different-gamma-values>

where $g_2 = sqrt(3)\/4$, $g_1^c approx 0.85$, $g_1^k approx 0.29$, $g_1^(k k) approx 0.1$.

In this paper, we consider 2 cases. For the first model (i) $N_c = 2$ and $N_k = 0$, for which $Gamma = 57$@Leclere:2023ryt, a value close to that observed in numerical simulations of individual loops @Leclere:2023ryt @Vachaspati:1984gt @Blanco-Pillado:2017oxo. Therefore, the only free parameter for this model is $G mu$. As for the second model (ii), we fix $N_c = 1$ and allow $N_k$ to vary between 1 and 200 (with a uniform prior) so as to account for theoretical uncertainties on the initial number of kinks at loop creation, and on the efficiency of the gravitational backreaction that should smooth out the loops (see the LVK analysis, #cite(<LIGOScientific:2021nrg>, style: "aas_noparen.csl"), for a similar approach). Therefore, this is a two-parameter model $( G mu N_k )$.

The fractional energy density of the SGWB per logarithmic interval of frequency is given by

$
  Omega_"GW" (t_0, f) = frac(16 pi (G mu)^2, 3 H_0^2) sum_b frac(N_b Gamma^(b), zeta(q_b)) \
  times sum_(n=1)^(+oo) integral frac(n^(1-q_b) "d" z, (1+z)^5 H(z)) bold(n) [2n \/ ((1+z) f), t (z)]
$<eq:full-sgwb>

 where $H_0$ is the Hubble constant, $H ( z )$ is the Hubble parameter for which we assume standard $Lambda$ CDM cosmology with the Planck-2018 fiducial parameters @Planck:2018vyg, and $t_0$ is the cosmic time today. The sum is over the cusp, kink and kink-kink contributions (labelled with the index $b$) for which $q_b = 4 3$, $5 3$ and $2$ respectively.

=== Analysis results <analysis-results>

Our analysis follows the one presented in @Leclere:2023ryt, which was based on six pulsars with the best timing precision from the EPTA early Data Release 2 @ccg-21. We now analyse the `DR2new` dataset with $25$ pulsars, using the (computationally heavy) hierarchical likelihood data analysis method described in PaperIII. We sample the SGWB parameters $( G mu )$ or $( G mu N_k )$ as well as the individual pulsar noise parameters.

Solid lines in @fig:cs_gmu_post show the posterior distribution on $log_10 ( G mu )$ in case #emph[(i)], for which $N_k = 0$ and $Gamma = 57$. The string tension 90% credible (symmetric) interval is $log_10 G mu = - 10.07_(- 0.36)^(+ 0.47)$ (resp.~$- 10.63_(- 0.22)^(+ 0.24)$) for the BOS (resp.~LRS) model. The corresponding SGWB spectra are shown in @fig:spectrum_plot where, for each model, we set $G mu$ to their median values. We also consider the two-component SGWB model made of the sum of a background from cosmic strings and one from a population of GW-driven circular SMBHBs characterised by the PSD of @eq:sh. The posteriors of the two background parameters $( log_10 A log_10 G mu )$ are highly correlated, since both provide a possible explanation for the detected signal. As a result, the posterior on $log_10 G mu$ no longer has compact support, but a tail to lower values (see the dashed lines in @fig:spectrum_plot). We therefore extract the 95-quantile of the string tension posterior to obtain an upper bound of $log_10 G mu < - 9.77$ (resp.~$- 10.44 )$ for the BOS (resp.~LRS) models.

The `DR2new` dataset exhibits a shallower slope for the PSD of the common red signal than `DR2full`. While cosmic strings were a good fit to the common red signal of 6 pulsars of `DR2full` @Leclere:2023ryt, this is no longer true for `DR2new`. This is because the predicted SGWB PSD is generally steeper than the measured correlated red signal in the data, as can be seen in @fig:spectrum_plot.

For case #emph[(ii)], we obtain very similar results to those discussed in @Leclere:2023ryt Namely, we obtain quasi non-informative posteriors for $N_k$, showing that the data can be equally explained by a population of kinky loops with $N_k gt.tilde 120$. In other words, we cannot extract any upper bound on the number of kinks, since this quantity is degenerate with $G mu$.

// [figvision-cn] imgs/Gmu_post.png
// 这是一张阶梯状直方图，用于比较两种宇宙弦模型（BOS 和
// LRS）在两种不同背景假设下的弦张力后验分布。图中只有一
// 个子图。 坐标轴：横轴标签为 log₁₀ Gμ，表示无量纲弦张力
// 的以 10 为底的对数值，范围从 -11.5 到 -8.5，主要的刻度
// 标记在 -11.5、-11.0、-10.5、-10.0、-9.5、-9.0 和 -8.5
// 处；纵轴标签为 Posterior distribution（后验分布），范
// 围从 0.0 到 3.0，主要刻度为 0.0、0.5、1.0、1.5、2.0、
// 2.5 和 3.0。 图例位于右上角，说明了四条曲线的含义与线
// 型： 蓝色实线边框矩形代表 BOS model（BOS 模型），对应
// 图中蓝色实线阶梯曲线。该曲线在 log₁₀ Gμ 约为 -10.1 至
// -9.9 之间形成一个单峰，峰值高度约 1.55，分布相对较宽，
// 主要覆盖 -10.6 到 -9.1 区间。 橙色实线边框矩形代表 LRS
// model（LRS 模型），对应图中橙色实线阶梯曲线。该曲线在
// log₁₀ Gμ 约为 -10.7 至 -10.5 之间形成一个尖锐的高峰，
// 峰值高度约 2.9，分布较窄，主要覆盖 -11.0 到 -10.0 区间。
// 蓝色虚线边框矩形代表 BOS+SMBHB model（BOS 加上超大质量
// 双黑洞模型），对应图中蓝色虚线阶梯曲线。该曲线在 log₁₀
// Gμ 约为 -10.2 处形成一个较矮的宽峰，峰值高度约 0.7，分
// 布范围从 -11.9 延伸至 -9.0。 橙色虚线边框矩形代表 LRS+
// SMBHB model（LRS 加上超大质量双黑洞模型），对应图中橙
// 色虚线阶梯曲线。该曲线在 log₁₀ Gμ 约为 -10.7 至 -10.5
// 处形成一个峰，峰值高度约 1.4，分布范围比橙色实线更宽，
// 从约 -11.1 延伸至 -9.8。 所有曲线均为阶梯状（直方图形
// 式），无填充颜色。图中无其他额外标注文字。趋势与结论：
// 在仅考虑宇宙弦背景（实线）时，LRS 模型给出的弦张力后验
// 分布峰值更高、更窄，且峰值位置偏向更小的 log₁₀ Gμ 值（
// 约 -10.6），而 BOS 模型的峰值较低、较宽，且偏向更大的
// 值（约 -10.0）。当同时考虑引力波驱动的圆形超大质量双黑
// 洞种群（虚线）时，两种模型的峰值高度均显著下降，分布变
// 宽；LRS 模型的后验峰值仍然位于比 BOS 模型更小的 log₁₀
// Gμ 处，但两者重叠区域增大。
#figure(image("imgs/Gmu_post.png", width: 48.0%),
  caption: [
    Comparison of the string tension posteriors for the two string models (BOS and LRS) in case #emph[(i)], $N_c = 2$ and $N_k = 0$ ($Gamma = 57$). Solid lines assume only a cosmic string background, dashed lines assume both a population of GW-driven circular SMBHBs and cosmic strings.
  ]
) <fig:cs_gmu_post>

// [figvision-cn] imgs/spectrum_plot.png
// 这是一张单面板科学曲线图（子图类型：带误差/后验分布的
// 曲线图）。图的横轴为频率（Frequency），单位为赫兹（Hz），
// 采用对数坐标，刻度标注有 10^-8，显示范围大致从 3×10^-9
// 到 10^-6 Hz；纵轴为 log10(h^2 Ω_gw)，表示随机引力波背
// 景（SGWB）能量密度的对数值，刻度标注有 -12、-10、-8、
// -6，显示范围从约 -13 到 -5。 图左上角有一个图例框，标
// 明了四条不同模型曲线的线型和颜色： 橙色点线（dotted
// line）代表 CS - BOS 模型； 绿色虚线（dashed line）代表
// CS - LRS 模型； 红色实线（solid line）代表 Turbulence
// model（湍流模型）； 紫色点划线（dash-dot line）代表
// Inflation model（暴胀模型）。 四条曲线随频率变化的趋势
// 和数值特征如下： 橙色点线（CS-BOS）在图中几乎保持水平，
// 纵轴值恒定为约 -9.2，表示该模型的引力波能量密度在观测
// 频段内不随频率变化。 绿色虚线（CS-LRS）同样非常平缓，
// 起始于纵轴约 -9.5，随频率增加有极轻微的上升，在 10^-8
// Hz 处约为 -8.9，在 10^-6 Hz 处约为 -8.5。 紫色点划线（
// Inflation）呈现明显上升趋势，起始于横轴约 3×10^-9 Hz
// 处的纵轴 -10.5，至 10^-8 Hz 处上升至 -8.4，最终到达 10
// ^-6 Hz 处接近 -6.5。 红色实线（Turbulence）呈现先上升
// 后平缓并略微下降的拱形趋势，起始于约 -10.8，在 10^-8
// Hz 处约为 -8.8，在 10^-7 Hz 附近达到最高峰约 -8.0，最
// 终在 10^-6 Hz 处约为 -8.1。 图中叠加了多个灰色的垂直半
// 透明分布带（看起来像是后验概率分布或敏感性窗口的示意），
// 这些灰色带对应于离散的频率位置，呈现出宽度不一、高低不
// 同的竖向分布。在横轴左侧约 3×10^-9 Hz 处有一个灰色带，
// 纵向覆盖约 -10 到 -9，中心横线约在 -9.1。在横轴 10^-8
// Hz 处有一个较宽的灰色带，纵轴跨度异常大，从大约 -12.8
// 延伸至 -8.6，中心横线约在 -9.1。右侧在 10^-8 Hz 到 10^
// -6 Hz 之间分布着多个密集的灰色带（分别位于约 3×10^-8、
// 10^-7、2×10^-7、5×10^-7、10^-6 Hz 附近），这些灰色带形
// 状呈纺锤状，纵向跨度分别从约 -12.5 至 -7.5，它们的中心
// 位置总体随频率增加而略微上移，从 -8.5 升至 -7.0 附近。
// 趋势与结论：图中显示了四种不同早期宇宙引力波模型的能量
// 密度谱。湍流模型和暴胀模型的能量密度在较高频段显著高于
// 宇宙弦模型（BOS/LRS）。其中暴胀模型随频率单调上升，而
// 湍流模型在 10^-7 Hz 附近达到峰值。灰色分布带暗示了未来
// 或现有探测器在不同频率处对 h^2 Ω_gw 的测量灵敏度或参数
// 后验分布，其中 10^-8 Hz 处的灰色带覆盖范围极宽，表明该
// 频段探测不确定性较大，而右侧的多个灰色带显示在更高频段
// 灵敏度收紧，并且中心值与几个模型的预测值存在交集。图中
// 缺乏中文标注，需参考图注理解物理模型的具体参数（如文中
// 所述，图注提到的各类模型参数如张力、谱指数等未在图中直
// 接显示为文字）。
#figure(scope: "parent", placement: top, image("imgs/spectrum_plot.png", width: 75.0%),
  caption: [
    SGWB spectra (in terms of $log_10 h^2 Omega_(g w)$) for four different early Universe SGWB models considered in this paper. BOS/LRS correspond to a cosmic string background with $N_c = 2$ and $N_k = 0$ ($Gamma = 57$), and $log_10 G mu = - 10.1$/$- 10.6$. The GWB from turbulence is plotted in solid line for $lambda_(*) cal(H)_(*) = 1$, $Omega_(*) = 0.3$, and $T_(*) = 140$. The inflationary spectra is shown for $log_10 r = - 13.1$ and $n_T = 2.4$ (maximum a posteriori value). Power spectrum of the 2nd-order GWB from the scalar curvature perturbations described by the powerlaw model with $A_zeta^"10yr" = - 2.9$ and $n_s = 2.1$ is shown with brown puncture-dot line. The nine first Fourier bins posteriors of the common signal are represented by the grey violin areas.
  ]
) <fig:spectrum_plot>

== Implications on background from turbulence around the QCD energy scale <implications-on-background-from-turbulence-around-the-qcd-energy-scale>

Turbulence can arise in the early Universe in the aftermath of a first-order phase transition @2014PhRvL.112d1301H @2015PhRvD..92l3009H @2017PhRvD..96j3520H @Witten:1984rs @Kamionkowski:1993fg, or can be driven by pre-existing primordial magnetic fields @Quashnock:1988vs @Brandenburg:1996fc. If the (magneto-)hydrodynamic turbulence were present around the QCD epoch, when the Universe had a temperature of $T_(*) tilde 100$, it would generate a GWB in the PTA band.

The characteristic scale of the turbulence, determining the characteristic GW frequency, is in fact related to the (comoving) Hubble radius at that epoch $lambda_(*) tilde.eq cal(O) ( cal(H)_(*)^(- 1) )$, where

$
  cal(H)_(*) tilde.eq 10^(-8) frac(T_(*), 100 " MeV") (frac(g_(*), 10))^(1 \/ 6) " Hz" ,
$


If a large lepton asymmetry and/or primordial magnetic fields were present in the early Universe, the QCD phase transition might have been of first order @2009JCAP...11..025S @2018PhRvL.121t1302W @2020arXiv200900036M @2022PhRvD.105l3533M @2021PhRvL.126a2701V @2023PhRvD.107a4021C 

In this case, one would expect additional sources of GWs, from the collision of broken phase bubbles and the subsequent development of sound waves in the primordial fluid @1992PhRvD..45.4514K @1993PhRvD..47.4372K @2008PhRvD..77l4015C @2008JCAP...09..022H @2017PhRvD..95b4009J @2018PhRvD..97l3513C @2014PhRvL.112d1301H @2015PhRvD..92l3009H @2017PhRvD..96j3520H @2021NatAs...5.1268M @NANOGrav:2021flc @Xue:2021gyq. This was analysed for PTAs, e.g.~in @2021NatAs...5.1268M @NANOGrav:2021flc @Xue:2021gyq. In what follows, we focus on the GWB generated by decaying (M)HD turbulence.

=== Description of the model <description-of-the-model>

The presence of bulk velocity and magnetic fields produce anisotropic stresses, which in turn act as a source of GWs @Kamionkowski:1993fg @2002PhRvD..66b4030K @2002PhRvD..66j3505D @2006PhRvD..74f3521C @2007PhRvD..76h3002G @2009JCAP...12..024C. This has been recently studied via numerical simulations in @RoperPol:2018sap @RoperPol:2019wvy @Brandenburg:2021tmp @RoperPol:2022iel. In particular, @RoperPol:2018sap @RoperPol:2019wvy @Brandenburg:2021tmp @RoperPol:2022iel show that the envelope of the GWB produced by decaying MHD turbulence can be estimated analytically, assuming that the anisotropic stresses from the velocity and magnetic fields vary more slowly than the dynamical production of GWs. This was also validated by numerical simulations of purely kinetic turbulence in @Auclair:2022jod. This assumption leads to the following GWB signal:

$
  Omega_"GW" (f) = 3 cal(A) Omega_("*")^2 (lambda_("*") cal(H)_("*"))^2 F_("GW,0") S_"turb" (lambda_("*") f)
$<eq:OMGWturb>

 where $Omega_(*)$ is the ratio of the (M)HD turbulent energy density to the radiation one, and $lambda_("*") cal(H)_("*")$ is the ratio of the characteristic length scale of the turbulence, $lambda_(*)$, to the comoving Hubble horizon $cal(H)_("*")^(-1)$ at the QCD epoch. The parameter $cal(A) ≃ 1.75 times 10^(-3)$ is the efficiency of GW production,#footnote[This estimate is conservative since it only considers the decaying stage of turbulence. Numerical simulations find larger values when including a stage of turbulence production @RoperPol:2019wvy @Kahniashvili:2020jgm @RoperPol:2021xnd] estimated in @RoperPol:2019wvy @Kahniashvili:2020jgm @RoperPol:2021xnd

The function $F_("GW", 0)$ is the fractional radiation energy density at the epoch of GW generation to its value at the present time. It depends on the temperature scale $T_(*)$ via the number of degrees of freedom $g_(*)$,

 $ F_("GW,0") ≃ 8 times 10^(-5) (10 g_("*"))^(13) $

The spectral shape of the GWB signal, $S_"turb" (f)$, is
$
S_("turb")(lambda_* f) = cal(B) (lambda_* f)^3 p_Pi(lambda_* f) times cases(
  ln^2 \[1 + cal(H)_* delta t_"fin" \/ (2 pi)\], "if" f < 1 \/ delta t_"fin",
  ln^2 \[1 + lambda_* cal(H)_* \/ (2 pi lambda_* f)\], "if" f gt.eq 1 \/ delta t_"fin",
)
$ <eq:Sturb>
where $cal(B) approx 50 l(lambda_("*") cal(H)_("*") r)^(-2)$ is a normalising factor, and $delta t_"fin"$ denotes the effective duration of the turbulence. The latter can be estimated, from the numerical simulations performed in @RoperPol:2022iel, to be $delta t_"fin" approx 2 lambda_("*")\/sqrt(1.5 Omega_("*"))$. The function $p_Pi ( lambda_(*) f )$ in @eq:Sturb denotes the spectrum of the anisotropic stresses. For solenoidal fields (e.g. a primordial magnetic field or vortical bulk fluid motion) characterised by a typical correlation scale of the order of the turbulence scale $lambda_(*)$, it is constant for $f < 1\/lambda_(*)$. Furthermore, it decays as $f^(-11\/3)$ for $f gt.tilde 1\/lambda_(*)$, if the turbulence is of the Kolmogorov type, as we assume here. Hence, the resulting spectral shape of the GWB in @eq:OMGWturb presents three power laws: $f^3$ at frequencies below the inverse effective duration of the turbulence $f < 1\/delta t_"fin"$, $f$ at intermediate frequencies $1\/delta t_"fin" < f < 1\/lambda_(*)$, and $f^(-8\/3)$ at large frequencies $f > 1\/lambda_(*)$.

The GWB produced from vortical (M)HD turbulence is therefore determined by three parameters: the temperature scale $T_(*)$, the turbulence strength $Omega_(*)$, and the turbulence characteristic length scale $lambda_("*") cal(H)_("*")$. By causality, $lambda_("*") cal(H)_("*")$ is bound to be smaller than one. In general, also $Omega_(*) lt.tilde 1$, otherwise turbulence would change the dynamics of the Universe. However, note that the template described above has been validated in principle only for non-relativistic plasma motions, for which $Omega_("*") cal(O) (0.1)$.

=== Analysis results <analysis-results-dup2>

As in @sec:inf, here we use the fast free spectrum analysis method on `DR2new` data to constrain the model, considering the nine first Fourier bins of the RMS spectrum of @fig:EPTADR2. We use $log_10$-uniform priors for the model parameters, choosing $log_10 ( lambda_(*) cal(H)_(*) ) in [ - 3, 0 ]$, $log_10 Omega_(*) in [ - 2, 0 ]$, and $log_(10) (T_("*") \/ 1 "MeV") in [1, 3]$. The 2D posteriors obtained are shown in @fig:qcd_post.

For values of $Omega_(*)$ below 0.1, the model can only explain the level of correlated noise at the lowest frequency bin if the amplitude of the spectrum is sufficiently high. This can be achieved only if $lambda_(*) cal(H)_(*)$ is close to 1 and the peak frequency lies within the PTA frequency range, implying $T_(*) tilde 60$.

However, at frequencies around the peak, the signal corresponds to a power spectral density for the residuals steeper than $gamma tilde 4$, which cannot fit the data well.

For this reason, values of $Omega_(*) lt.tilde 0.1$ are disfavoured.

For larger values of $Omega_(*)$, the $f^3$ part of the spectrum at frequencies below $delta t_"fin"^(-1) prop sqrt(Omega_("*"))\/(lambda_("*") cal(H)_("*")) times cal(H)_("*")(T_("*"))$ can enter the PTA band with a sufficiently high amplitude. Furthermore, the distance between the break at $delta t_"fin"^(-1)$ and the spectral peak at $1 lambda_(*)$ becomes minimal in the limit $Omega_(*) tilde 1$. Both of these characteristics lead to a better fit to the data. This is recovered in the posteriors of @fig:qcd_post, together with the degeneracy between $lambda_(*) cal(H)_(*)$ and $Omega_(*)$ from the signal amplitude (see @eq:OMGWturb), and the degeneracy between $lambda_(*) cal(H)_(*)$ and $T_(*)$ from the break at $1\/delta t_"fin"$ (note that the dependence of the latter on $sqrt(Omega_(*))$ is subdominant).

The model therefore provides a good fit to the data in the limit of large $Omega_(*)$, close to the upper bound of the prior. The extension of the dataset to longer observation time will be crucial for further constraining this model at low frequencies.

// [figvision-cn] imgs/QCD_DR2new.png
// 这是一张 3×3 的角图（corner plot），用于展示三个参数的
// 后验概率分布，其中对角线子图为一维边缘后验直方图，非对
// 角线子图为二维联合后验等高线图。整体图由蓝色阶梯状曲线
// 和蓝色填充区域构成，所有坐标轴均为对数尺度（以 10 为底）。
// 图中三个参数分别是 log10(λ*H*)、log10(Ω*) 和 log10(T*/
// MeV)。二维图均显示出 68% 和 95% 的置信区域，分别以深蓝
// 色填充和浅蓝色填充表示，并在边缘用蓝色实线勾勒。 子图
// (a)：位于左上角（第1行第1列），但坐标轴标签省略，仅显
// 示 y 轴为 log10(Ω*)，数值范围从 -1.2 到 -0.3。该图为一
// 维边缘后验直方图（阶梯状曲线），表示 log10(Ω*) 的概率
// 密度。x 轴刻度未显示数值，但可根据对应的下方面板推断。
// 曲线在 log10(Ω*) 约 -0.6 至 -0.3 之间快速上升，并在接
// 近 -0.3 处达到峰值，随后下降或趋于平稳，表明该参数的后
// 验概率密度在较高值处更大。图中无其他标注。 子图 (b)：
// 位于第2行第1列，为二维联合后验等高线图。x 轴为 log10(λ
// *H*)，刻度从 -0.8 到 -0.2，单位无量纲；y 轴为 log10(Ω*
// )，刻度从 -1.2 到 -0.3，单位无量纲。图中显示两个填充区
// 域：深蓝色区域（68% 置信区域）和浅蓝色区域（95% 置信区
// 域），边界由蓝色实线勾勒。深蓝色区域呈向上弯曲的带状，
// 从低 log10(λ*H*) 和高 log10(Ω*) 的区域延伸至较高 log10
// (λ*H*) 和较低 log10(Ω*) 的区域；浅蓝色区域包围深蓝色区
// 域，覆盖范围更广，整体呈现明显的负相关趋势，即 log10(λ
// *H*) 增大时 log10(Ω*) 减小。图中无文字标注。 子图 (c)：
// 位于第2行第2列，为一维边缘后验直方图（阶梯状曲线），表
// 示 log10(Ω*) 的概率密度。x 轴刻度未显示数值，但对应下
// 方子图 (f) 的 x 轴；y 轴未显示，为概率密度。曲线从低值
// 缓慢上升，在 log10(Ω*) 约 -0.6 至 -0.3 之间达到峰值，
// 随后略有下降，表明后验概率密度在较高值处最大。图中无其
// 他标注。 子图 (d)：位于第3行第1列，为二维联合后验等高
// 线图。x 轴为 log10(λ*H*)，刻度从 -0.8 到 -0.2；y 轴为
// log10(T*/MeV)，刻度从 1.2 到 2.4，单位 MeV。深蓝色区域
// （68%）呈倾斜的带状，从低 log10(λ*H*) 和低 log10(T*/
// MeV) 的区域延伸至高 log10(λ*H*) 和高 log10(T*/MeV) 的
// 区域，显示出正相关趋势；浅蓝色区域（95%）包围深蓝色区
// 域，范围更宽，覆盖低至 log10(T*/MeV) 约 1.2 和高至 2.4
// 的区域。图中无文字标注。 子图 (e)：位于第3行第2列，为
// 二维联合后验等高线图。x 轴为 log10(Ω*)，刻度从 -1.2 到
// -0.3；y 轴为 log10(T*/MeV)，刻度从 1.2 到 2.4，单位
// MeV。深蓝色区域（68%）呈弯曲带状，从低 log10(Ω*) 和高
// log10(T*/MeV) 区域延伸至高 log10(Ω*) 和较低 log10(T*/
// MeV) 区域，显示负相关趋势；浅蓝色区域（95%）包围深蓝色
// 区域，覆盖范围更广。图中无文字标注。 子图 (f)：位于第3
// 行第3列，为一维边缘后验直方图（阶梯状曲线），表示
// log10(T*/MeV) 的概率密度。x 轴刻度从 1.2 到 2.4，单位
// MeV；y 轴未显示，为概率密度。曲线从低值上升，在 log10(
// T*/MeV) 约 1.5 至 2.1 之间达到峰值，随后在 2.1 至 2.4
// 之间下降，表明后验概率密度在约 1.8 至 2.1 之间最大。图
// 中无其他标注。 整体趋势：三个参数的后验分布均显示出一
// 定的相关性，log10(λ*H*) 与 log10(Ω*) 呈负相关，log10(λ
// *H*) 与 log10(T*/MeV) 呈正相关，log10(Ω*) 与 log10(T*/
// MeV) 呈负相关。一维直方图显示各参数的后验峰值分别位于
// log10(Ω*) 约 -0.3 至 -0.6、log10(T*/MeV) 约 1.8 至 2.1
// 之间。图中所有置信区域均基于 68% 和 95% 的credible
// regions，通过蓝色填充区分。
#figure(image("imgs/QCD_DR2new.png", width: 45.0%),
  caption: [
    2D posteriors for the parameters of the background from turbulence around the QCD energy scale obtained using a free spectrum fit on `DR2new` data. The 68% and 95% credible regions are displayed.
  ]
) <fig:qcd_post>

== Implications on the 2nd-order GWB produced by primordial curvature perturbations <sec:secondorder>

// [figvision-cn] imgs/delta_P.png
// 这是一张单面板曲线图，横轴为 log10(k/Mpc^-1)，刻度范围
// 约从 -4 到 12，主刻度标注为 -4、0、4、8、12；纵轴为
// log10 Pζ，刻度范围约从 -8.5 到 3.0，主刻度标注为 -7.5、
// -5.0、-2.5、0.0、2.5。 图中包含四组主要元素。第一组是
// 左下角标记为 CMB 的灰色窄带：由两条细灰色曲线围成，在
// 横轴约 -3 到 1 之间呈扁平带状，纵轴值约在 -8.0 附近略
// 微上拱，中心位置有一条黑色实线贯穿，表示 CMB 观测约束
// 的范围。 第二组是中部偏上的紫色宽带，标注文字为 FIRAS，
// 颜色为浅紫填充，带深紫色轮廓。该带在横轴约 1.5 至 5.5
// 之间呈现上宽下窄的漏斗形，纵轴范围大致从 -4.0 延伸至超
// 过 3.0（顶部超出坐标范围），最窄处位于纵轴约 -4.0 附近。
// 第三组是右侧的绿色峰状曲线群，包含三条颜色深浅不同的绿
// 色实线：深绿、中绿、浅绿。三条曲线形状相似，均在横轴约
// 5 至 7 之间形成单峰。深绿色峰值最高，约在横轴 6.5、纵
// 轴 -3.0 处；中绿色峰值约在横轴 6.5、纵轴 -4.0 处；浅绿
// 色峰值最低，约在横轴 6.5、纵轴 -5.0 处。曲线在峰值两侧
// 陡峭下降，左侧下降至纵轴 -8.5 以下，右侧下降至纵轴
// -8.5 以下。 第四组是右上角的橙色阴影带，标注文字为
// DR2New，颜色为橙色。该带从横轴约 7、纵轴约 -3.5 处开始，
// 向右上角延伸至横轴 12、纵轴约 3.0 处，呈斜向宽带。带内
// 包含一条深橙色实线和一条深橙色虚线，两者大致平行，实线
// 位于虚线上方。阴影带边界由细橙色线勾勒。 图中没有可见
// 的比例尺或显微成像通道信息，所有元素均为曲线和填充带。
// 整体趋势显示：CMB 约束位于低 k 端且功率很低；FIRAS 带
// 覆盖中等 k 范围并延伸至高功率；绿色峰状曲线在 k 约 6.5
// 处给出局部功率增强；DR2New 带在高 k 端呈幂律上升趋势。
// [figvision-cn] imgs/delta_P.png
// 这是一张单面板曲线图，横轴为 log10(k/Mpc^-1)，刻度范围
// 约从 -4 到 12，主刻度标注为 -4、0、4、8、12；纵轴为
// log10 Pζ，刻度范围约从 -8.5 到 3.0，主刻度标注为 -7.5、
// -5.0、-2.5、0.0、2.5。 图中包含四组主要元素。第一组是
// 左下角标记为 CMB 的灰色窄带：由两条细灰色曲线围成，在
// 横轴约 -3 到 1 之间呈扁平带状，纵轴值约在 -8.0 附近略
// 微上拱，中心位置有一条黑色实线贯穿，表示 CMB 观测约束
// 的范围。 第二组是中部偏上的紫色宽带，标注文字为 FIRAS，
// 颜色为浅紫填充，带深紫色轮廓。该带在横轴约 1.5 至 5.5
// 之间呈现上宽下窄的漏斗形，纵轴范围大致从 -4.0 延伸至超
// 过 3.0（顶部超出坐标范围），最窄处位于纵轴约 -4.0 附近。
// 第三组是右侧的绿色峰状曲线群，包含三条颜色深浅不同的绿
// 色实线：深绿、中绿、浅绿。三条曲线形状相似，均在横轴约
// 5 至 7 之间形成单峰。深绿色峰值最高，约在横轴 6.5、纵
// 轴 -3.0 处；中绿色峰值约在横轴 6.5、纵轴 -4.0 处；浅绿
// 色峰值最低，约在横轴 6.5、纵轴 -5.0 处。曲线在峰值两侧
// 陡峭下降，左侧下降至纵轴 -8.5 以下，右侧下降至纵轴
// -8.5 以下。 第四组是右上角的橙色阴影带，标注文字为
// DR2New，颜色为橙色。该带从横轴约 7、纵轴约 -3.5 处开始，
// 向右上角延伸至横轴 12、纵轴约 3.0 处，呈斜向宽带。带内
// 包含一条深橙色实线和一条深橙色虚线，两者大致平行，实线
// 位于虚线上方。阴影带边界由细橙色线勾勒。 图中没有可见
// 的比例尺或显微成像通道信息，所有元素均为曲线和填充带。
// 整体趋势显示：CMB 约束位于低 k 端且功率很低；FIRAS 带
// 覆盖中等 k 范围并延伸至高功率；绿色峰状曲线在 k 约 6.5
// 处给出局部功率增强；DR2New 带在高 k 端呈幂律上升趋势。
#figure(scope: "parent", placement: top, [#box(image("imgs/delta_powerlaw_r.png", width: 40.0%)) #box(image("imgs/delta_P.png", width: 40.0%))

  ],
  caption: [
    Results for the monochromatic curvature perturbations described by @eq:monochromatic_sp. Left panel: recovered slopes $gamma$ of a simple power-law model as a function of characteristic scale $k^(*)$ of the injected GWB generated by the monochromatic curvature perturbations. The horizontal lines show the theoretical value of $gamma$ from a population of circular, GW-driven SMBHBs (grey) and the one obtained in PaperIII (orange). Right panel: 1 $sigma$ and 2 $sigma$ contours of the posterior distributions on the amplitude $A_zeta$ and characteristic scale of fluctuations $k^(*)$ for `DR2new` (orange colour). The posterior distribution is overlaid with the current constraints on the primordial power spectrum using Planck data (CMB). The grey colour depicts the 2-$sigma$-confidence intervals. The purple shaded area represents the bounds from spectral distortions @2012ApJ...758...76C. For comparison in green we place the prediction of the primordial spectrum of scalar perturbations in the two-field model of inflation described in @2020JCAP...08..001B for a range of the model parameters. All three models result in PBH mass functions peaked at $tilde 35$~$M_(☼)$ with the brightest line corresponding to the dark matter fraction of PBHs of $tilde 0.01$.
  ]
) <fig:summ_cmb_delta>

// [figvision-cn] imgs/delta_P_powerlaw.png
// 这是一张科学论文中的双面板组合图，包含两个子图（左侧和
// 右侧）。 左侧子图为后验分布等高线图，类型为二维参数约
// 束图。横轴名称为 log10(k/Mpc^-1)，刻度范围约从 -4 到 7，
// 主要刻度标注有 -3、0、3、6。纵轴名称为 log10 P_ζ，刻度
// 范围约从 -9 到 -1，主要刻度标注有 -2、-4、-6、-8。图中
// 包含三个独立的约束区域： 左下角灰色区域，标有“CMB”字样，
// 表现为一个以横轴 log10(k/Mpc^-1) 约 -2.5 至 -0.5、纵轴
// log10 P_ζ 约 -8.5 为中心的窄椭圆，中心有一条黑色实线贯
// 穿，代表均值或最佳拟合，灰色阴影表示 1 和 2 置信区间。
// 中上方紫色区域，标有“FIRAS”字样，是一个向下弯曲的宽条
// 带，横轴范围约从 1 到 4，纵轴覆盖约 -2 到 -4.5，色块表
// 示该实验的约束范围。 右侧绿色曲线区域，标有“DR2New”字
// 样，由三条从右下方陡峭上升至峰值后回落的曲线组成，峰值
// 出现在横轴约 6.5、纵轴约 -1.5 处，三条曲线分别代表不同
// 的置信边界或样本轨迹，其中一条为浅绿色细线，两条为深绿
// 色粗线。 右侧子图为功率谱曲线图，类型为后验推断的功率
// 谱集合。横轴与左图相同，为 log10(k/Mpc^-1)，刻度范围
// -4 至 7。纵轴与左图相同，为 log10 P_ζ，刻度范围 -9 至
// -1。图中包含两组数据： 橙色带区域，标有“DR2New”字样，
// 由两条不规则的曲线界定，形成一个在横轴 6 至 7 之间向上
// 翘起的带状区域，中心区域颜色较深，边缘颜色较浅，表示从
// 后验分布中随机抽取的 1000 个样本的包络。 绿色曲线簇，
// 与左图中的绿色曲线对应，同样由三条曲线组成，呈现出在横
// 轴 3 至 7 之间先上升后下降的峰状结构，峰值位置与左图绿
// 色区域一致，代表该模型下的功率谱预测。图中没有额外的标
// 注文字或符号。整体趋势显示，DR2New 数据在较小尺度（高
// k 值）上对功率谱有显著约束，且与 FIRAS 和 CMB 的约束在
// 参数空间上呈现分离或互补的态势。
// [figvision-cn] imgs/delta_P_powerlaw.png
// 这是一张科学论文中的双面板组合图，包含两个子图（左侧和
// 右侧）。 左侧子图为后验分布等高线图，类型为二维参数约
// 束图。横轴名称为 log10(k/Mpc^-1)，刻度范围约从 -4 到 7，
// 主要刻度标注有 -3、0、3、6。纵轴名称为 log10 P_ζ，刻度
// 范围约从 -9 到 -1，主要刻度标注有 -2、-4、-6、-8。图中
// 包含三个独立的约束区域： 左下角灰色区域，标有“CMB”字样，
// 表现为一个以横轴 log10(k/Mpc^-1) 约 -2.5 至 -0.5、纵轴
// log10 P_ζ 约 -8.5 为中心的窄椭圆，中心有一条黑色实线贯
// 穿，代表均值或最佳拟合，灰色阴影表示 1 和 2 置信区间。
// 中上方紫色区域，标有“FIRAS”字样，是一个向下弯曲的宽条
// 带，横轴范围约从 1 到 4，纵轴覆盖约 -2 到 -4.5，色块表
// 示该实验的约束范围。 右侧绿色曲线区域，标有“DR2New”字
// 样，由三条从右下方陡峭上升至峰值后回落的曲线组成，峰值
// 出现在横轴约 6.5、纵轴约 -1.5 处，三条曲线分别代表不同
// 的置信边界或样本轨迹，其中一条为浅绿色细线，两条为深绿
// 色粗线。 右侧子图为功率谱曲线图，类型为后验推断的功率
// 谱集合。横轴与左图相同，为 log10(k/Mpc^-1)，刻度范围
// -4 至 7。纵轴与左图相同，为 log10 P_ζ，刻度范围 -9 至
// -1。图中包含两组数据： 橙色带区域，标有“DR2New”字样，
// 由两条不规则的曲线界定，形成一个在横轴 6 至 7 之间向上
// 翘起的带状区域，中心区域颜色较深，边缘颜色较浅，表示从
// 后验分布中随机抽取的 1000 个样本的包络。 绿色曲线簇，
// 与左图中的绿色曲线对应，同样由三条曲线组成，呈现出在横
// 轴 3 至 7 之间先上升后下降的峰状结构，峰值位置与左图绿
// 色区域一致，代表该模型下的功率谱预测。图中没有额外的标
// 注文字或符号。整体趋势显示，DR2New 数据在较小尺度（高
// k 值）上对功率谱有显著约束，且与 FIRAS 和 CMB 的约束在
// 参数空间上呈现分离或互补的态势。
#figure(scope: "parent", placement: top, [#box(image("imgs/posterior_scalar_powerlaw.png", width: 40.0%)) #box(image("imgs/delta_P_powerlaw.png", width: 40.0%))

  ],
  caption: [
    Results for the power-law model of the curvature perturbations described by @eq:powerlaw_sp. Left panel: 1 $sigma$ and 2 $sigma$ contours of the posterior distributions on the amplitude $A_zeta$ and the slope of the power spectrum $n_s$ obtained by the analysis of `DR2New`. Right panel: 1 $sigma$ and 2 $sigma$ contours of the power spectra inferred from the `DR2New` analysis by picking 1000 random samples from the posteriors overlaid with the current constraints on the primordial power spectrum using the latest Planck data. The grey colour depicts the 2 $sigma$-confidence intervals. The green lines and purple shaded areas are the same as in @fig:summ_cmb_delta
  ]
) <fig:summ_cmb_powerlaw>

It is well-known that scalar, vector and tensor modes of the perturbed metric do not mix at linear order of the Einstein equations @1946ZhETF..16..587L @baumann_2022. However, scalar curvature perturbations will source propagating tensorial modes (GWs) at the 2nd order in perturbation theory @1967PThPh..37..831T @1993PhRvD..47.1311M @1998PhRvD..58d3504M @2004PhRvD..69j4011N @2005PhRvD..71d3508C @2007PhRvD..75l3518A @2007PhRvD..76h4019B. Such scalar curvature perturbations and associated primordial density fluctuations inevitably exist in the Universe and can be directly constrained by observations of the CMB. The latest Planck data #cite(<2020A-A...641A..10P>) suggests that the power spectrum of the curvature perturbations is nearly scale-invariant with the amplitude $A_zeta tilde 2 times 10^(- 9)$, which implies a marginal energy-density of the generated GWB. Specifically, when projected to the PTA sensitivity band, the fractional contribution of the energy density in the associated GWs becomes $Omega_"gw" tilde 10^(- 24)$, which is practically non-detectable by current experiments. On the other hand, some models of inflation (see, for example, #cite(<2018JCAP...07..007D>, style: "aas_noparen.csl") #cite(<2019JCAP...06..028B>, style: "aas_noparen.csl") #cite(<2020JCAP...08..001B>, style: "aas_noparen.csl") #cite(<2023EPJC...83...82Y>, style: "aas_noparen.csl"), and references therein) make it possible to produce a sharp increase in the power spectrum of primordial curvature perturbations over many orders of magnitude at small scales.

While the CMB is only capable of directly sampling large cosmological scales with $k tilde 10^(- 3) - 10^(- 1)$~Mpc $""^(- 1)$, small scales stay largely uncovered. PTAs provide a unique opportunity to complement the CMB measurements by indirectly probing the scalar curvature perturbations in a scale range $k tilde 10^6 - 10^8$~Mpc $""^(- 1)$ through the second-order generated GWB, and to place bounds on the steepest possible growth of the power spectrum as well as corresponding models of inflation @2009PhRvL.102p1101S @2011PhRvD..83h3521B @2020PhRvL.124y1101C @2023arXiv230207901D @2023Univ....9..157Z 

In this work, we consider two models of the primordial curvature power spectrum: i) monochromatic and ii) powerlaw. For the former, the primordial spectrum is modelled as:

$
  P_zeta = A_zeta delta ( "log" k \/ k^(*) ) #h(0.17em)
$<eq:monochromatic_sp>

 where $A_zeta$ is a dimensionless amplitude and $k^(*)$ is a wavenumber at which the monochromatic power spectrum has a Dirac-delta peak. For the second case:

$
  P_zeta = A_zeta^(10 "yr") (k \/ k_"10yr")^( n_s - 1 ) #h(0.17em)
$<eq:powerlaw_sp>

 where $n_s$ characterises the slope and $k^"10yr"$ is a normalizing scale $k_"10yr" = 2 pi ( 10 y r times c )$, so that $A_zeta^(10 "yr")$ corresponds to dimensionless amplitude at ten years.

In the first scenario, a semi-analytical solution for the induced spectrum of GWB exists and is given by @2018PhRvD..97l3532K @2018JCAP...09..012E.

$ Omega_"GW" (f = frac(k c, 2 pi)) = frac(3 A_zeta^2, 64) (frac(4 - tilde(k)^2, 4))^2 tilde(k)^2 (3 tilde(k)^2 - 2) Theta ( 2 - tilde(k) ) times\
times (pi^2 ( 3 tilde(k)^2 - 2 )^2 Theta ( 2 sqrt(3) - 3 tilde(k) ) + (4 + ( 3 tilde(k)^2 - 2 )^2 log lr(|1 - frac(4, 3 tilde(k)^2)|))^2) thin $ <eq:gwb_monochromatic>

 where $tilde(k) = k k^(*)$ and $Theta$ is the Heaviside theta function. In spite of being nonphysical, the $delta$-function peak approximately describes the maximum of the produced GWB in the inflationary model with the steepest possible $k^4$ growth of a spectral peak in the single-field inflation at small scales

In the second case of a more general (and more realistic) power-law spectrum, the result can only be obtained numerically @2018PhRvD..97l3532K.

$
  Omega_"GW" (f = frac(k c, 2 pi)) = Q ( n_s ) ( A_zeta^"10yr" )^2 (k \/ k_"10yr")^(2 ( n_s - 1 )) #h(0.17em)
$<eq:gwb_powerlaw>

 where $Q ( n_s )$ is the scaling factor which can be evaluated in a range of $n_s$ using interpolation points from Table 1 of @2018PhRvD..97l3532K

After its production, the GWB is damped due to quantum interactions with the particles of the primordial plasma at the radiation-dominated epoch, and redshifted inversely proportionally to the scale factor (as it also occurs to radiation) starting from the epoch of matter-radiation equality @2018JCAP...05..035S. The present value of the fractional energy density is then: $Omega_"GW"^0 = 2 Omega_r^0 (frac(g_(*) ( T ), g_(*) ( T_"eq" ))) (frac(g_(* s) ( T ), g_(* s) ( T_"eq" )))^(- 4\/3) Omega_"GW" #h(0.17em)$ where $T$ is the temperature of the Universe at the moment when structures of a typical size $1 k$ re-enter the horizon#footnote[We conservatively set the temperature at the epoch of production to 17.35 K.], $T_"eq"$ is the temperature of the Universe at the epoch of matter-radiation equality, $g_(*)$ and $g_(* s)$ are relativistic degrees of freedom and degrees of freedom in entropy, respectively. The final expression for the auto-power spectral density of the timing residuals is: $S ( f ) = frac(H_0^2, 8 pi^4) frac(Omega_"GW"^0 ( f ), f^5)$ where $H_0$ is the Hubble constant at the present epoch.

The outlined formalism was applied to the `DR2new` version of the latest EPTA dataset. The number of frequency components which was used for the Fourier representation of the signal was fixed to 9. We have chosen broad uninformative priors for the parameters: uniform in $[ - 6, 3 ]$ for $log_10 A_zeta$ and $log_10 A_zeta^"10yr"$, uniform in $[ 4 12 ]$ for $log_10 ( k^(*) "Mpc"^(- 1) )$, and uniform in $[ 0.4 2.6 ]$ for $n_s$. Boundaries for the latter are constrained by the limitations of the numerical approximation of the power law model. For this analysis, we assumed that the common red noise process detected in the latest EPTA dataset can be fully explained by the 2nd-order scalar-induced GWs.

Results for monochromatic and power law models are shown in @fig:summ_cmb_delta and @fig:summ_cmb_powerlaw, respectively. The 2D posterior distribution of the model parameters of the monochromatic model is depicted with orange contours on the right panel of @fig:summ_cmb_delta. One may notice that the regions of the highest probability are strongly elongated due to a strong positive correlation between $A_zeta$ and $k^(*)$ these parameters are essentially degenerate. Therefore, `DR2new` can only provide lower limits on the characteristic scale and amplitude of the monochromatic model: $log_10 ( k^(* 0.05) "Mpc"^(- 1) ) = 7.6$ and $log_10 A_zeta^0.05 = - 1.7$ meaning that a whole range of models predicting Dirac-delta power spectrum can equally good describe the signal of `DR2new`. This behaviour is explained in the left panel of @fig:summ_cmb_delta, for which we have simulated GWB signal generated by the monochromatic primordial scalar perturbations, @eq:gwb_monochromatic, and attempted to recover a more general power law model of the form $S ( f ) tilde f^(- gamma)$ used in PaperIII to model an arbitrary common red noise process. After a rapid decrease, the recovered slope stabilises at $gamma tilde 3.5$ in the limit of large $k^(*)$, and becomes consistent with both values obtained with `DR2new` and the theoretically predicted 13/3 for the background from circular, GW-driven SMBHBs. This degeneracy can raise important issues when one tries to disentangle one signal from another. For the power-law case, the 2D posteriors are shown in the left panel of @fig:summ_cmb_powerlaw with the following means and 1-$sigma$ uncertainties: $log_10 A_zeta = - 2.94_(- 0.46)^(+ 0.42)$ and $n_s = 2.11_(- 0.32)^(+ 0.25)$.

On the right panels of @fig:summ_cmb_delta and @fig:summ_cmb_powerlaw, we also overplot the inferred primordial power spectrum with the one obtained from the Planck data. The orange areas on the right panel of @fig:summ_cmb_powerlaw are 1 $sigma$ and 2 $sigma$ contours of the power-law model described by @eq:powerlaw_sp reconstructed using 1000 random draws from the posteriors. To explain the observed signatures of the `DR2new` in terms of the second-order GWB from the primordial scalar perturbations, an excess in the primordial spectrum at low scales should be invoked without violating the CMB inflationary parameters. Such excess has been proposed in many papers, e.g. in the aforementioned works by @1994PhRvD..50.7173I @2017PDU....18....6G @2018JCAP...07..007D @2018PhRvL.121h1306C @2018JCAP...07..032B @2019JCAP...06..028B @2020JCAP...03..002M @2020JCAP...08..001B @2023EPJC...83...82Y  Notably, this power excess would lead to a copious production of primordial black holes (PBHs) at the radiation-dominated stage, which is sometimes taken by the authors as the motivation to introduce them as cold dark matter candidates @2016PhRvD..94h3504C (and reference therein). The PBH formation from cosmological perturbations has been extensively explored @2018CQGra..35f3001S. On the radiation-dominated stage, the PBH mass is related to the mass inside the horizon at the time of the perturbation entering, $M m^2≳ 8 M_⊙ (100 ""\/T)^2 (40\/g_("*"))^(1\/2)$, where $m_(P l)$ is the Planckian mass, $T$ is the temperature. In terms of the mode comoving wavenumber at the moment of the horizon crossing, $k = a H$, the part of the horizon mass collapsing into a PBH reads

$
  M (k) approx 30 M_⊙ (10.75 \/ g_("*"))^(-1\/6) (3 times 10^5 "Mpc"^(-1) \/ k)^2
$

 For example, in the two-field inflationary model by @2020JCAP...08..001B, a peak around $k tilde 2 times 10^6$~Mpc $""^(- 1)$ could explain the power $A_zeta tilde 10^(- 2)$ and simultaneously lead to the production of PBHs with masses peaked at $tilde 35 M_⊙$@2021PhRvL.126e1303V. Interestingly, such a peak seems to be observed in the chirp mass distribution of LVK merging binary black holes @2023PhRvX..13a1048A A more general list of primordial power spectra, as well as a careful retranslation of them to the PBH abundance and their mass function, will be considered in a follow-up paper (Porayko et al., in prep.).

= Implications III: dark matter <sec:dark_matter>

Unlike spatially and temporally-correlated stochastic processes discussed in @sec:SMBHBs and~@sec:early_universe, in this Section, we explore a possible deterministic contribution to the EPTA signal from ultralight scalar-field dark matter (ULDM). For comparison, the morphology of a putative ULDM signal, predicted by @Khmelnitsky_2014, is similar to a CGW from a SMBHB, that is, it is prominent only in one frequency bin. Given that the signal observed with `DR2new` is mostly apparent in the first two fundamental $T^(- 1)$ frequency bins, it is of interest to consider possible contributions from physical processes with narrowband spectra. Therefore, the analysis presented here complements the CGW interpretation of the signal by @wm4. Additionally, the ULDM search with~`DR2full` is performed in @Smarra_2023.

Dark matter currently constitutes approximately 26% of the energy density of the Universe, as confirmed by, e.g., galactic rotation curves @Rubin_1970 @Rubin_1980 @de_Salas_2019, baryonic acoustic oscillations and cosmic microwave background measurements @Bennett_2013 @Planck:2018vyg @Escudero_2015 as well as galaxy surveys @Escudero_2015. The standard cold dark matter (CDM) picture, whose leading candidates are the Weakly Interacting Massive Particles (WIMPs) @Arcadi_2018 and the QCD axion @Di_Luzio_2020, successfully grasps the large-scale structure of the Universe. However, it presents some well-known issues, when it comes to explaining observations at scales smaller than $cal(O)$(kpc). Among these, the #emph[cusp-core problem] @Flores_1994 @Moore_1994 @Karukes_2015 concerns the inconsistency between the observation of a flat density profile in the centre of galaxies and the power-law-like behavior predicated by CDM, while the mismatch between the simulated and observed number of dwarf galaxies in the proximity of our Milky Way is often referred to as the #emph[missing satellite problem] @Klypin_1999 @Moore_1994.

While a thorough understanding of baryonic physics feedback mechanisms @Klypin_1999 @Moore_1994 @Navarro_1996 @Governato_2012 @Brooks_2013 @Chan_2015 @Onorbe_2015 @Read_2016 @Morganti_2017 might help to alleviate some of these issues, they can be more easily disposed of assuming that DM is an ultralight ($m_phi.alt tilde 10^(- 22)$ eV) scalar/pseudoscalar or axion-like field, whose astrophysically large ($cal(O)$(kpc)) de Broglie wavelength suppresses power on small scales. Moreover, ultralight scalars are also generally present in string theory compactifications @Green_1987 @Svrcek_2006 @Arvanitaki_2010, which makes them interesting candidates for new physics as well. CMB-based arguments are used to constrain $m_phi.alt gt.tilde 10^(- 24)$ eV @Hlozek_2015, while Lyman-$alpha$ bounds push the limit up to $m_phi.alt gt.tilde 10^(- 21)$ eV, provided that the ultralight particles account for more than 30% of the full dark matter budget @Irsic_2017 @Armengaud_2017 @Kobayashi_2017 @Nori_2018 @Rogers_2021 A lower limit of $m_phi.alt tilde 10^(- 19)$ eV is claimed by studies of ultra-faint dwarf (UFD) galaxies @Hayashi_2021 @Dalal_2022, but a wider consensus is yet to be reached. In a seminal work, @Hayashi_2021 @Dalal_2022 showed that the travel time of pulsar radio beams is affected by the gravitational potential induced by ULDM particles, making thus PTAs excellent facilities to investigate the existence of ULDM particles. Moreover, they represent complementary probes which do not suffer from the small-scale structure modelling uncertainties that affect non-CMB bounds @Schive_2014 @Zhang_2019, as the aforementioned Lyman-$alpha$ or UFD limits. In the following, we robustly assume that ULDM interacts only gravitationally, therefore giving rise to periodic oscillations in the TOAs of radio pulses as described in @Khmelnitsky_2014.

Being non-relativistic and with a very large characteristic occupation number, the ULDM scalar field can be described as a classical wave whose oscillation frequency is twice its mass $m_phi.alt$@Khmelnitsky_2014. The periodic displacement that ULDM induces on the TOAs of signal from a pulsar $P$ can be written as follows @Porayko_2018.

$
  delta t ( t ) = frac(Psi_c ( arrow(x) ), 2 m_phi.alt) [ hat(phi.alt)_E^2 sin ( 2 m_phi.alt + gamma_E ) - hat(phi.alt)_P^2 sin ( 2 m_phi.alt + gamma_P ) ]
$ <eq:st>

 where

$
  Psi_c ( arrow(x) ) = frac(pi G rho_phi.alt, m_phi.alt^2) \
  approx 6.52 dot.op 10^(- 18) (frac(10^(- 22) "eV", m_phi.alt))^2 (frac(rho_phi.alt, 0.4 "GeV" \/ "cm"^3))
$<eq:psi_c>

 where $gamma_P$ ($gamma_E$) is a pulsar (Earth) dependent phase and $hat(phi.alt)_P^2$ ($hat(phi.alt)_E^2$) takes into account the stochastic nature of the axion-like field near the pulsar (Earth). The parameters and their priors are summarised in @tab:ULDM_priors. Considering a typical value of $v_phi.alt tilde 10^(- 3)$ for the ULDM velocity, the region in which the scalar field oscillates coherently, i.e. with the same value of $hat(phi.alt)$, is spanned by the #emph[coherence length]:

$
  l_c approx frac(2 pi, m_phi.alt v_phi.alt) approx 0.4 "kpc" (frac(10^(- 22) "eV", m_phi.alt)) .
$<eq:co_length>

 In particular, notice that $hat(phi.alt)_E^2$ and $hat(phi.alt)_P^2$ should be taken as:

- #emph[different] parameters when the average pulsar-Earth and pulsar-pulsar distance is larger than the coherence length.

- the #emph[same] parameter when the average pulsar-Earth and pulsar-pulsar distance is smaller than the coherence length.

Following the procedure in @Smarra_2023, we analyze three separate cases, which we refer to as the #emph[uncorrelated], the #emph[pulsar correlated] and the #emph[correlated] limit. As the average inter-pulsar and Earth-pulsar separation is $tilde$ kpc, the #emph[correlated] and #emph[uncorrelated] scenarios stand out as exact limits at the low mass and high mass end of the PTAs band, respectively. Instead, the #emph[pulsar correlated] limit holds when the coherence length of ULDM is smaller than the Galacto-centric radius probed by rotation curves (inner $tilde 20$ kpc), but larger than the average inter-pulsar and pulsar-Earth distance. More specifically, the #emph[correlated] regime holds for masses lower than $m_phi.alt tilde 2 times 10^(- 24)$ eV; the #emph[pulsar correlated] regime for $2 times 10^(- 24) #h(0.17em) "eV" lt.tilde m_phi.alt lt.tilde 5 times 10^(- 23) #h(0.17em) "eV"$ and the #emph[uncorrelated] limit for $m_phi.alt gt.tilde 5 times 10^(- 23) med "eV"$. We defer a more detailed study to future analysis.

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([#strong[Parameter]], [#strong[Description]], [#strong[Prior]], [#strong[Occurrence]],),
    table.hline(),
    table.cell(align: center, colspan: 4)[White Noise $(sigma = E_f^2 sigma_(T o A)^2 + E_q^2)$],
    [$E_f$], [EFAC per backend/receiver system], [Uniform $[0, 10]$], [1 per pulsar],
    [$E_q$], [EQUAD per backend/receiver system], [Log $""_(10)$-Uniform $[-10,-5]$], [1 per pulsar],
    table.cell(align: center, colspan: 4)[Red Noise],
    [$A_"red"$], [Red noise power-law amplitude], [Log $""_(10)$-Uniform $[-20,-6]$], [1 per pulsar],
    [$gamma_"red"$], [Red noise power-law spectral index], [Uniform $[0, 10]$], [1 per pulsar],
    table.cell(align: center, colspan: 4)[ULDM],
    [$Psi_"c"$], [ULDM amplitude], [Log $""_(10)$-Uniform $[-20,-12]$], [1 for PTA],
    [$m_phi$ [eV]], [ULDM mass], [Log $""_(10)$-Uniform $[-24,-22]$], [1 for PTA],
    [$hat(phi)_E^2$], [Earth factor], [$e^(-x)$], [1 for PTA],
    [$hat(phi)_P^2$], [Pulsar factor], [$e^(-x)$], [1 per pulsar],
    [$gamma_E$], [Earth signal phase], [Uniform $[0, 2 pi]$], [1 per PTA],
    [$gamma_P$], [Pulsar signal phase], [Uniform $[0, 2 pi]$], [1 per pulsar],
    table.cell(align: center, colspan: 4)[Common spatially Uncorrelated Red Noise (CURN)],
    [$A_"GWB"$], [Common process strain amplitude], [Log $""_(10)$-Uniform $[-20,-6]$], [1 for PTA],
  )]
  , kind: table,
  caption: [Parameters used for the search and their respective priors. In the correlated limit, $hat(phi)_E^2 = hat(phi)_P^2$ and can be reabsorbed in a redefinition of $Psi_c$.]
  ) <tab:ULDM_priors>


// [figvision-cn] src/figures/corr_mass.png
// 这是一张单幅科学论文插图，图中仅包含一个子图。该子图为
// 一维阶梯状曲线图（直方图样式），用于展示后验概率分布随
// 对数质量变化的趋势。 横轴（X轴）的名称为“log₁₀ m_φ(eV)
// ”，表示超轻暗物质（ULDM）粒子质量 m_φ 的以电子伏特（eV）
// 为单位的以10为底的对数值。横轴为线性刻度，方向从左向右
// 递增，但刻度标签为倾斜书写。可见的刻度标记共有四个，从
// 左至右依次标注为“−23.2”、“−22.4”、“−21.6”和“−20.8”，相
// 邻刻度之间的间隔为0.8个数量级。横轴范围大致从 −23.4 延
// 伸至 −20.6。 纵轴（Y轴）没有标注刻度数值和物理量名称。
// 根据图注信息，该图的纵轴对应“后验概率”（Posterior
// probabilities）。纵轴范围从底部的基线（概率为零或接近
// 零）向上延伸，基线以上无明显的水平网格线或刻度线。 整
// 个子图仅包含一条黑色实线，以阶梯状（histogram-like
// step curve）绘制，表示在离散的质量区间（bin）内估计得
// 到的后验概率密度或概率值。该曲线首尾与图框的左右边缘相
// 接，水平贯穿整个绘图区域。曲线大部分区段在基线附近形成
// 宽度不等的低矮平台，呈现不规则起伏。最为显著的特征是位
// 于横轴约 −23.0 至 −23.2 之间的一个极高且孤立的窄峰，是
// 整条曲线的最高点，峰高约为其余背景起伏高度的五倍以上。
// 除该主峰外，在刻度 −22.4 右侧附近和 −21.6 附近也存在几
// 个高度相对较低的小峰，但均未超过主峰高度的五分之一。曲
// 线向右侧（数值更大的方向，即 −20.8 及更右侧）延伸时，
// 都维持在低位起伏状态，无显著峰。 图中所有标注文字只有
// 横轴下方的“log₁₀ m_φ(eV)”，字体为无衬线体，倾斜明显。
// 横轴上的刻度数字同样为倾斜书写。纵轴无文字，图内没有图
// 例、箭头或特殊符号。 该图所传达的趋势与结论是：在相关
// 分析（图注对应上排图，即相关分析结果）下，对 DR2new 数
// 据集进行 ULDM 振幅与质量的后验概率重建时，后验概率分布
// 在 log₁₀ m_φ(eV) ≈ −23.1 附近（介于 −23.2 和 −23.0 之
// 间）出现了一个非常尖锐且显著的单峰，表明在此质量取值处
// 存在强烈的后验概率聚集（即模型对该质量值的偏好极高）。
// 其余质量区间（−20.8 至 −22.8 以及 −23.2 以左）的后验概
// 率均处于低水平且接近均匀的起伏状态，未形成有意义的峰值
// 结构。这表明该组数据在相关分析下对 ULDM 质量给出了一个
// 明确且高度局域化的约束，而在其他质量区间则没有可辨别的
// 信号。
// [figvision-cn] src/figures/corr_psic.png
// 这是一张单面板直方图（阶梯曲线图），用于展示超轻暗物质
// （ULDM）振幅的后验概率分布。图中没有子图标记（如 a、b、
// c），也无标题说明属于相关分析还是非相关分析。 坐标轴：
// 横轴标签为“log₁₀ Ψ_c”，表示超轻暗物质振幅 Ψ_c 的以 10
// 为底的对数值。横轴范围约从 -19.5 到 -13.5，刻度标记依
// 次为 -19.5、-18.0、-16.5、-15.0、-13.5，刻度间隔为 1.5
// 个数量级。纵轴没有数值刻度标签，也没有轴名称，但根据图
// 注意为后验概率（概率密度）。 数据表达：图形由一条黑色
// 阶梯状实线构成，表示分箱后的后验概率密度。线型为实线，
// 无虚线或点线。在 -19.5 至 -16.5 区间，阶梯线在低水平上
// 呈现数个高度相近的矩形台阶，每个箱宽约 0.35 个数量级，
// 台阶高度约为背景水平的 0.4 到 0.8 倍。在 -16.5 至
// -15.5 之间，概率密度略升至约背景水平的 0.8 倍，维持几
// 个箱宽。最显著的特征是位于 -15.0 附近的一个尖锐峰：从
// 约 -15.4 开始阶梯上升，峰值出现在约 -14.9 至 -14.8 之
// 间，该峰高度约为背景水平（-19.0 至 -17.0 区域）的 3 到
// 4 倍。峰后概率密度在约 -14.8 至 -14.6 处迅速下降至背景
// 水平，并在 -14.6 至 -13.5 之间进一步阶梯式降至接近零的
// 低水平。 标注：图中除横轴刻度和轴标签外，无其他文字、
// 符号、图例或阴影区域。 结论：该后验概率分布在 log₁₀ Ψ
// _c ≈ -15.0 处存在一个显著的单峰，表明数据支持该振幅值；
// 在更小的振幅范围（-19.5 至 -16.5）存在较低且平缓的概率
// 分布，但不构成显著峰值。
// [figvision-cn] src/figures/uncorr_mass.png
// 这是一张单面板直方图（曲线图），无子图分幅，仅呈现一个
// 统计分布。横轴标注为“log₁₀ m_φ(eV)”，表示超轻暗物质（
// ULDM）质量 m_φ 的以电子伏特为单位的以10为底的对数值，
// 横轴刻度从左至右依次标出 −23.2、−22.4、−21.6、−20.8，
// 每两个相邻刻度间隔 0.8 个数量级，绘图区间约为 −23.5 至
// −20.6。纵轴无轴标签和刻度，表示后验概率密度（相对值）。
// 图中用黑色阶梯型直方图线展示后验概率随质量的变化：在大
// 部分质量区间内概率密度维持在较低的基线水平，形成一条接
// 近平缓、带有小幅阶梯波动的低台；在横轴约 −23.1 至 −
// 23.0 附近出现一个非常窄而高的尖峰，峰值远高于基线（约
// 高出基线一个数量级以上），峰中心对应 log₁₀ m_φ ≈ −23.1
// eV，即 m_φ ≈ 10^(−23.1) eV ≈ 7.9×10^(−24) eV。该尖峰由
// 两个相邻的窄柱构成，峰左侧在约 −23.15 处有一个约半峰高
// 的肩部，峰右侧迅速回落至基线。整体趋势表明：在相关分析
// （图注所述顶行）下，ULDM 质量后验分布在约 −23.1 处具有
// 显著的单峰结构，暗示该质量值被数据强烈偏好，其余质量区
// 间的后验概率很低；图中无其他标注文字、无图例、无符号或
// 不同线型，仅一条黑色阶梯线。图注说明此图对应相关分析（
// 顶行）的 DR2new 数据集结果，脉冲星相关分析未展示但具有
// 相同特征。
// [figvision-cn] src/figures/uncorr_mass.png
// 这是一张单面板直方图（曲线图），无子图分幅，仅呈现一个
// 统计分布。横轴标注为“log₁₀ m_φ(eV)”，表示超轻暗物质（
// ULDM）质量 m_φ 的以电子伏特为单位的以10为底的对数值，
// 横轴刻度从左至右依次标出 −23.2、−22.4、−21.6、−20.8，
// 每两个相邻刻度间隔 0.8 个数量级，绘图区间约为 −23.5 至
// −20.6。纵轴无轴标签和刻度，表示后验概率密度（相对值）。
// 图中用黑色阶梯型直方图线展示后验概率随质量的变化：在大
// 部分质量区间内概率密度维持在较低的基线水平，形成一条接
// 近平缓、带有小幅阶梯波动的低台；在横轴约 −23.1 至 −
// 23.0 附近出现一个非常窄而高的尖峰，峰值远高于基线（约
// 高出基线一个数量级以上），峰中心对应 log₁₀ m_φ ≈ −23.1
// eV，即 m_φ ≈ 10^(−23.1) eV ≈ 7.9×10^(−24) eV。该尖峰由
// 两个相邻的窄柱构成，峰左侧在约 −23.15 处有一个约半峰高
// 的肩部，峰右侧迅速回落至基线。整体趋势表明：在相关分析
// （图注所述顶行）下，ULDM 质量后验分布在约 −23.1 处具有
// 显著的单峰结构，暗示该质量值被数据强烈偏好，其余质量区
// 间的后验概率很低；图中无其他标注文字、无图例、无符号或
// 不同线型，仅一条黑色阶梯线。图注说明此图对应相关分析（
// 顶行）的 DR2new 数据集结果，脉冲星相关分析未展示但具有
// 相同特征。
#figure(placement: top, 
  grid(
// [figvision-cn] src/figures/corr_mass.png
// 这是一张单幅科学论文插图，图中仅包含一个子图。该子图为
// 一维阶梯状曲线图（直方图样式），用于展示后验概率分布随
// 对数质量变化的趋势。 横轴（X轴）的名称为“log₁₀ m_φ(eV)
// ”，表示超轻暗物质（ULDM）粒子质量 m_φ 的以电子伏特（eV）
// 为单位的以10为底的对数值。横轴为线性刻度，方向从左向右
// 递增，但刻度标签为倾斜书写。可见的刻度标记共有四个，从
// 左至右依次标注为“−23.2”、“−22.4”、“−21.6”和“−20.8”，相
// 邻刻度之间的间隔为0.8个数量级。横轴范围大致从 −23.4 延
// 伸至 −20.6。 纵轴（Y轴）没有标注刻度数值和物理量名称。
// 根据图注信息，该图的纵轴对应“后验概率”（Posterior
// probabilities）。纵轴范围从底部的基线（概率为零或接近
// 零）向上延伸，基线以上无明显的水平网格线或刻度线。 整
// 个子图仅包含一条黑色实线，以阶梯状（histogram-like
// step curve）绘制，表示在离散的质量区间（bin）内估计得
// 到的后验概率密度或概率值。该曲线首尾与图框的左右边缘相
// 接，水平贯穿整个绘图区域。曲线大部分区段在基线附近形成
// 宽度不等的低矮平台，呈现不规则起伏。最为显著的特征是位
// 于横轴约 −23.0 至 −23.2 之间的一个极高且孤立的窄峰，是
// 整条曲线的最高点，峰高约为其余背景起伏高度的五倍以上。
// 除该主峰外，在刻度 −22.4 右侧附近和 −21.6 附近也存在几
// 个高度相对较低的小峰，但均未超过主峰高度的五分之一。曲
// 线向右侧（数值更大的方向，即 −20.8 及更右侧）延伸时，
// 都维持在低位起伏状态，无显著峰。 图中所有标注文字只有
// 横轴下方的“log₁₀ m_φ(eV)”，字体为无衬线体，倾斜明显。
// 横轴上的刻度数字同样为倾斜书写。纵轴无文字，图内没有图
// 例、箭头或特殊符号。 该图所传达的趋势与结论是：在相关
// 分析（图注对应上排图，即相关分析结果）下，对 DR2new 数
// 据集进行 ULDM 振幅与质量的后验概率重建时，后验概率分布
// 在 log₁₀ m_φ(eV) ≈ −23.1 附近（介于 −23.2 和 −23.0 之
// 间）出现了一个非常尖锐且显著的单峰，表明在此质量取值处
// 存在强烈的后验概率聚集（即模型对该质量值的偏好极高）。
// 其余质量区间（−20.8 至 −22.8 以及 −23.2 以左）的后验概
// 率均处于低水平且接近均匀的起伏状态，未形成有意义的峰值
// 结构。这表明该组数据在相关分析下对 ULDM 质量给出了一个
// 明确且高度局域化的约束，而在其他质量区间则没有可辨别的
// 信号。
// [figvision-cn] src/figures/corr_psic.png
// 这是一张单面板直方图（阶梯曲线图），用于展示超轻暗物质
// （ULDM）振幅的后验概率分布。图中没有子图标记（如 a、b、
// c），也无标题说明属于相关分析还是非相关分析。 坐标轴：
// 横轴标签为“log₁₀ Ψ_c”，表示超轻暗物质振幅 Ψ_c 的以 10
// 为底的对数值。横轴范围约从 -19.5 到 -13.5，刻度标记依
// 次为 -19.5、-18.0、-16.5、-15.0、-13.5，刻度间隔为 1.5
// 个数量级。纵轴没有数值刻度标签，也没有轴名称，但根据图
// 注意为后验概率（概率密度）。 数据表达：图形由一条黑色
// 阶梯状实线构成，表示分箱后的后验概率密度。线型为实线，
// 无虚线或点线。在 -19.5 至 -16.5 区间，阶梯线在低水平上
// 呈现数个高度相近的矩形台阶，每个箱宽约 0.35 个数量级，
// 台阶高度约为背景水平的 0.4 到 0.8 倍。在 -16.5 至
// -15.5 之间，概率密度略升至约背景水平的 0.8 倍，维持几
// 个箱宽。最显著的特征是位于 -15.0 附近的一个尖锐峰：从
// 约 -15.4 开始阶梯上升，峰值出现在约 -14.9 至 -14.8 之
// 间，该峰高度约为背景水平（-19.0 至 -17.0 区域）的 3 到
// 4 倍。峰后概率密度在约 -14.8 至 -14.6 处迅速下降至背景
// 水平，并在 -14.6 至 -13.5 之间进一步阶梯式降至接近零的
// 低水平。 标注：图中除横轴刻度和轴标签外，无其他文字、
// 符号、图例或阴影区域。 结论：该后验概率分布在 log₁₀ Ψ
// _c ≈ -15.0 处存在一个显著的单峰，表明数据支持该振幅值；
// 在更小的振幅范围（-19.5 至 -16.5）存在较低且平缓的概率
// 分布，但不构成显著峰值。
    columns: (1fr, 1fr),
    gutter: 2pt,
    image("src/figures/corr_psic.png", width: 100%),
    image("src/figures/corr_mass.png", width: 100%),
    image("src/figures/uncorr_psic.png", width: 100%),
    image("src/figures/uncorr_mass.png", width: 100%),
  ),
  caption: [Posterior probabilities for the ULDM amplitude $Psi_c$ and mass $m_phi$, from the correlated (top row) and uncorrelated (bottom row) analysis of the `DR2new` dataset. The pulsar correlated analysis is not shown, but displays the same features.],
) <fig:10yrULDM>

Based on the above, we fit the model from @eq:st to the `DR2new` as in @Smarra_2023.

As an example, marginalised posterior distributions for $Psi_c$ and $m_phi.alt$ are plotted in @Smarra_2023. All the three limits peak at a ULDM mass $m_phi.alt tilde 10^(- 23) "eV"$ with amplitude $Psi_c tilde 10^(- 15)$, which translates into a density $rho_phi.alt tilde.eq 0.6 #h(0.17em) "GeV" "cm"^3$ of the scalar field. While this value is higher than the fiducial local DM density $rho_"DM" approx 0.4 "GeV" "cm"^3$, it is well within the measurement uncertainties @Bovy_2012 @Read_2014 @Sivertsson_2018 @de_Salas_2020 

Additionally, we search for a potential ULDM signature alongside the SMBHB gravitational-wave background. Thus, we introduce a new model that contains ULDM contributions alongside a common red signal to account for gravitational wave contributions. We find no ULDM signal under this hypothesis, in agreement with the fact that the data support HD correlation, which naturally favours GWs over ULDM in a joint search. Thus we put 95% upper limit on the amplitude $Psi_c$ and the density $rho_phi.alt$ of the scalar field.

// [figvision-cn] imgs/psi10.png
// 这是一张单面板二维曲线图（子图 a），用于展示不同分析对
// 超轻暗物质（ULDM）丰度上限的约束随其质量变化的趋势。
// 坐标轴：底边横轴标注为 log₁₀ m_φ(eV)，表示超轻暗物质粒
// 子的质量以电子伏特为单位的以 10 为底的对数值，范围从 −
// 24.0 到 −22.0，主刻度间隔 0.5。顶边横轴标注为 log₁₀ f(
// Hz)，表示引力波频率以赫兹为单位的以 10 为底的对数值，
// 对应范围为 −9.3 到 −7.3，主刻度间隔 0.5。左右纵轴标注
// 为 log₁₀ Ψ_c，表示 ULDM 丰度参数 Ψ_c 的以 10 为底的对
// 数值，范围从 −16 到 −11，主刻度间隔 1。 图中包含多条曲
// 线：蓝色实线代表“Correlated”（相关分析）的 95% 贝叶斯
// 上限；橙色实线代表“Uncorrelated”（不相关分析）的 95%
// 贝叶斯上限；棕色实线代表“Pulsar correlated”（脉冲星相
// 关分析）的 95% 贝叶斯上限。三条 EPTA DR2new 曲线整体呈
// 从左上向右下倾斜的锯齿状波动趋势，数值大致在 −13.5 到
// −15 之间，并在横轴约 −22.2 处出现一个明显的尖峰，其中
// 棕色线峰值最高（约 −12.9），蓝色线峰值最低（约 −13.4）。
// 绿色点划线代表“PPTA Bayes 2018”分析结果，位于三条 EPTA
// 曲线之上，数值大致在 −13.4 到 −14.3 之间波动，同样在 −
// 22.2 附近有尖峰。红色点线代表“NANOGrav 2018”分析结果，
// 整体较高，从左侧约 −12.5 缓慢下降至右侧约 −13.8，并在
// −22.2 处出现一个极高的尖峰（接近 −11.1），为图中最高点。
// 紫色虚线代表“DM density”（暗物质密度），呈一条从左上（
// 约 −13.1）向右下（约 −16.0）平滑下降的直线，仅覆盖横轴
// −24.0 到 −22.6 的区间。 图中其他标注：在横轴约 −23.6
// 处有一条灰色竖直点线，其上方标注公式 f = 1/T_obs。图例
// 位于图的上方中间偏右，包含六项：绿色点划线对应 PPTA
// Bayes 2018，红色点线对应 NANOGrav 2018，蓝色实线对应
// Correlated，橙色实线对应 Uncorrelated，棕色实线对应
// Pulsar correlated，紫色虚线对应 DM density。 该图传达
// 的趋势是：不同分析给出的 Ψ_c 上限随 m_φ 增加而整体下降
// （即约束变强），但在 m_φ 约 10^−22.2 eV 附近所有分析均
// 出现显著峰值，表明该质量处约束变弱；NANOGrav 2018 的约
// 束最弱，PPTA Bayes 2018 次之，EPTA DR2new 的三种分析约
// 束最强且彼此接近，其中相关分析（蓝色）在大部分质量区间
// 给出最低上限。
#figure(image("imgs/psi10.png", width: 50.0%),
  caption: [
    Constraints on $Psi_c$ as a function of $m_phi.alt$ using the EPTA `DR2new` dataset from PaperIII. Previous analyses are shown for comparison, cf. @Porayko_2014 @Porayko_2018 for further details. The blue, orange and brown lines represent the 95% Bayesian upper limit on $Psi_c$ obtained from the EPTA `DR2new` dataset with the correlated, uncorrelated and pulsar correlated analysis, respectively. The purple line shows the expected ULDM abundance computed from @eq:psi_c
  ]
) <fig:24yrULDM>

// [figvision-cn] imgs/rho10.png
// 这是一张单面板科学曲线图，用于展示对超轻暗物质（ULDM）
// 密度上限的约束。图表类型为二维折线图，主坐标轴为底部的
// x 轴和左侧的 y 轴，同时顶部和右侧有辅助坐标轴。 底部 x
// 轴标签为“log₁₀ m_φ(eV)”，表示超轻暗物质粒子的质量以电
// 子伏特为单位的以 10 为底的对数值，范围从 -24.0 到
// -22.6，主刻度间隔为 0.2（-24.0, -23.8, -23.6, -23.4,
// -23.2, -23.0, -22.8, -22.6），并在主刻度之间有次级刻度。
// 左侧 y 轴标签为“ρ_φ / ρ_DM”，表示超轻暗物质密度相对于
// 暗物质背景密度的归一化比值。该轴采用对数刻度，标注范围
// 为 10⁰ 到 10²，即 1 到 100，具体数字标签在 10⁰、10¹、
// 10² 处显示。在 y = 10⁰ 的位置（即比值等于 1）有一条贯
// 穿整个绘图区的水平紫色细点线。 顶部 x 轴标签为“log₁₀ f
// (Hz)”，表示超轻暗物质振荡频率以赫兹为单位的以 10 为底
// 的对数值，刻度标签从左到右依次为 -9.3、-9.1、-8.8、
// -8.6、-8.3、-8.1，这是一个与底部质量轴非线性对应的辅助
// 轴，用于展示频率与质量的关系。 图表左上角有一个包含四
// 项的图例框。列表如下：第一项为蓝色实线（线宽较细），标
// 注“Correlated”；第二项为橙色虚线（短划线），标注“
// Uncorrelated”；第三项为棕色点划线（长划与点交替），标
// 注“Pulsar correlated”；第四项为紫色细点线，标注“DM
// density”。 图中绘制了三条以上升趋势为主的曲线，均表示
// 95% 贝叶斯上限。棕色点划线（Pulsar correlated）在整个
// 质量范围内最高。在 x 轴 -24.0 至 -23.4 之间，该线在 y
// 轴约 1.2 至 2 之间波动，随后在 -23.4 至 -23.1 之间从约
// 2 升至约 5，接着在 -23.1 至 -23.0 附近出现一个显著的高
// 耸双峰结构：在 x ≈ -23.05 处达到约 30，随后在 x ≈
// -23.0 处达到全局最高峰约 100（y 轴顶端）。此后迅速下降
// 至 x ≈ -22.8 处约 9，随后在 -22.7 至 -22.6 附近再次上
// 升至约 20-30。蓝色实线（Correlated）和橙色虚线（
// Uncorrelated）的趋势与棕色线大致相似，但数值更低。蓝色
// 实线在 x < -23.2 时维持在 y ≈ 0.7 至 0.9 之间，在
// -23.2 至 -23.0 之间升至约 8-10 的峰值，之后下降至
// -22.8 处约 3-4，最后在 -22.6 处升至约 20。橙色虚线在大
// 部分质量区间内与蓝色实线紧密重合或略低（例如在 -23.0
// 附近的峰值约为 7），但在 x ≈ -23.2 处有一个明显的下凹，
// 低至约 1.2。紫色点线（DM density）为一条位于 y = 1 处
// 的水平直线，作为参考基准。三条上限曲线在低质量端（x <
// -23.4）均接近或略低于该参考线，而在 x > -23.2 后迅速上
// 升并远高于参考线。
#figure(image("imgs/rho10.png", width: 50.0%),
  caption: [
    Constraints on the ULDM density $rho_phi.alt$ normalised to the DM background value $rho_"DM" = 0.4 "GeV" "cm"^3$. The blue, orange and brown lines represent the 95% Bayesian upper limit on $rho_phi.alt$, obtained from the EPTA `DR2new` dataset with the correlated, uncorrelated and pulsar correlated analysis, respectively. The purple dotted line shows the fiducial local DM density value.
  ]
) <fig:24yrULDM_rho>

@fig:24yrULDM and @fig:24yrULDM_rho show that the EPTA at current sensitivity is able to constrain the presence of ULDM at the level of the expected DM abundance in the mass range $m_phi.alt tilde [ 10^(- 24) "eV" 10^(- 23.2) "eV" ]$. The `DR2Full` analysis performed in @Smarra_2023 pushes these limits down, thus implying that such ULDM candidates cannot constitute the entire DM. We highlight that our bounds extend below the `DR2new` sampling frequency $f = 1 T approx 3 dot.op 10^(- 9) "Hz"$, with $T approx "10yr"$. In fact, while it might naively be thought that the ULDM field needs to complete an oscillation in the timescale $tau_"PTA"$ of the PTA experiment to produce a detectable effect, we point out that an ULDM wave with frequency $m_phi.alt < 1 tau_"PTA"$ can still be approximated by an expansion in powers of $m_phi.alt t$@Kaplan_2022, though the sensitivity of PTAs will be reduced due to degeneracies with the timing model @Ramani_2020 Relying on the robust CMB bounds mentioned before, we fix the lower end of our search at $m_phi.alt = 10^(- 24) "eV"$. Importantly, we remove the $hat(phi.alt)_E = hat(phi.alt)_P$ parameter from the search in the correlated limit, as it is fully degenerate with $Psi_c$. In other words, building upon the observation that our Galaxy rotation curve measurements are performed within an ULDM coherence length in the correlated limit, we redefine a new variable, $Psi_c^0 = Psi_c phi.alt^2$, which represents the instance of DM in the Milky Way. Finally, as shown by @fig:24yrULDM, we report a bump in upper limits at $m_phi.alt tilde 10^(- 23) "eV"$, which is at around the maximum-a-posteriori boson mass in @fig:10yrULDM. This mass further corresponds to the frequency of the CGW analyzed in @wm4 Looking at the posteriors in this mass range, we also find an additional contribution, on top of the CURN process. A similar bump in upper limits is also present in the `DR2Full` dataset, as discussed in @Smarra_2023. However, the Bayes factor of ln $cal(B) tilde 0.3$ we find in favour of the presence of ULDM signal is still inconclusive. We recommend following up on this bump in future work.

= Discussion and outlook <sec:conclusions>

In this paper, we have explored the implications of the common, correlated low-frequency signal observed in the latest data release of the EPTA+InPTA collaboration. Four different datasets were assembled, and the signal was more significant in those including only broadband, high-quality data taken with telescope backends of the new generation. Therefore, we took, as benchmark for our analysis, the signal measured in the `DR2new` dataset, for which the HD correlation is detected at high significance with a Bayes factor of $approx 60$ or, equivalently, at a $p -$ value of $approx 0.001$, indicative of a $gt.tilde 3 sigma$ confidence. The signal can be modelled by a single power law spectrum $S_h ( f )$ as in @eq:sh, with best-fit parameters $A_(f=1"yr"^(-1))=-13.94_(-0.48)^(+0.23)$ and $gamma = 2.71_(- 0.71)^(+ 1.18)$ (PaperIII).

We considered several physical processes separately, investigating the implications of the detected signal under the hypothesis that it is generated by that specific process. Our main findings can be summarised as follows.

#strong[SMBHBs]. The signal is consistent with a cosmic population of merging SMBHBs. Phenomenological models based on galaxy pairs observations can account for the power spectral distribution of the correlated signal. Those models can also be used to predict the chance to detect CGWs in the current data, for which the search has given inconclusive results so far @wm4 According to those models, there is roughly a 50% chance to detect a CGW in `DR2new` at S/N $> 3$. The relatively high amplitude of the signal can be used to place constraints on key properties of the cosmic SMBHB population. By exploiting the inference framework developed in @2016MNRAS.455L..72M @csc2019, we can infer that SMBHBs merge in less than 1Gyr following galaxy mergers, and that the SMBH-stellar bulge relation has a normalization $log_10 (M_("*") \/ M_⊙) approx 8.4$ at a reference stellar mass bulge of $10^11 M_⊙$, in line with recent compiled results #cite(<2013ARA-A..51..511K>). Finally, we investigated how the detected signal compares with predictions from state-of-the-art galaxy formation SAMs @B12 @2022MNRAS.509.3488I. We found that the high amplitude of the signal imposes non-trivial constraints on galaxy and SMBH evolution models. In particular, boosted SMBH accretion and short SMBHB evolution timescales are needed to match the observed signal, which might lead to difficulties when trying to reproduce independent observables such as the quasar luminosity function. If the SMBHB origin of the observed signal is confirmed, it would be a major breakthrough for observational astrophysics and for our understanding of galaxy formation. This would be the first direct evidence that SMBHBs merge in nature, adding an important observational piece to the puzzle of structure formation and galaxy evolution.

#strong[Early Universe.] The measured signal would have different implications for each of the physical processes considered in this study. An inflationary origin requires non-standard inflationary scenarios breaking the slow-roll consistency relation, leading to a blue-tilted spectrum. In particular, the measured $gamma approx 2.7$ implies $n_T approx 2.3$ for a radiation-dominated universe with $w = 1  3$.

A cosmic string origin would allow narrowing down the string tension to values of $-11 lt.eq log_10 G mu lt.eq -9.5$, depending on the specific distribution of loops in the string network. Conversely, the number of kinks cannot be constrained. A GWB induced by (M)HD turbulence at the QCD energy scale can also potentially explain the common red noise, but requires either high turbulent energy densities, of the same order of the radiation energy density, or a characteristic turbulent scale close to the horizon at the QCD epoch. Finally, the measured signal can be produced by the evolution of scalar perturbations at second order only if an excess of their primordial spectrum is present at large wavenumbers, compared to the level derived from CMB observations at small wave numbers. Notably, such an excess would lead to the production of PBHs which can non-negligibly contribute to the CDM density.

#strong[ULDM.] Finally, we searched for ULDM signatures in `DR2new`. The search returned a prominent peak in the posterior distribution of the ULDM particle mass around $"log"_(10)(m_phi\/"eV")approx -23$. This corresponds to a field oscillation frequency of $"log"_(10)(f\/"Hz")approx -8.3$, which is consistent with the CGW candidate examined in @wm4. When a joint ULDM+GWB search is performed, however, the peak in the ULDM mass posterior distribution vanishes, as the data strongly prefer the presence of an HD correlation in the common power. We therefore conclude that an ULDM origin of the detected signal is disfavoured, placing a direct constraint on the abundance of ULDM in our Galaxy. The non-detection in `DR2new` implies that only about 80% of the DM density in the solar neighbourhood can be attributed to ULDM with $-24<"log"_(10)(m_phi\/"eV")< -23.7$. More stringent constraints are obtained from `DR2full` and are presented in a separate paper @Smarra_2023

It is interesting to remark that the best fit to the measured power-law slope is $gamma = 2.71$, well below the predicted $gamma = 13 3$ expected from a cosmic population of SMBHBs, often indicated as the primary candidate for generating nanohertz GWs. Before leaving the floor to speculations, we caution that this 'inconsistency' might have multiple roots, as mentioned in @sec:considerations. First, $gamma = 13 3$ assumes a population of circular GW-driven binaries. Eccentricity and environmental coupling can easily flatten the low-frequency spectrum. Even for circular binaries, a simple power-law of $gamma = 13 3$ is an ideal limit; small number statistics due to the sparseness of massive, nearby systems results in noisy spectra with a large variance, which can produce different spectral indices when fitted by a power-law. Second, the measured value can be subject to statistical and systematic biases. We have in fact shown that even when a power law with $gamma = 13 3$ is injected into the data, the measured values can be biased due to the statistical realization of the noise. Moreover, the mis-modeling of high-frequency noise can systematically bias the recovered $gamma$, leading to flatter spectra if unaccounted high-frequency noise is present in the data. Therefore, caution should be taken when drawing conclusions from this measurement.

Conversely, a shallow spectral slope might indicate that the GW signal has a different origin, perhaps from some key physical process occurring in the early Universe, as investigated in @sec:early_universe. Another possibility, proposed by @lackeos is that GWs can lose energy while propagating through the intergalactic medium via the acceleration of charged particles. Owing to the much higher thermal velocity of electrons over protons and the presence of an intergalactic medium magnetic field, a significant fraction of the GWs can be converted to EM radiation. The ensuing electromagnetic intensity is inversely proportional to frequency. Partial GW loss via this mechanism could explain a flatter-than-expected GWB spectrum. The efficiency of such a mechanism depends on the strength of the intergalactic medium magnetic field.

It is also possible that the observed signal is coming from multiple overlapping GWBs. In our analyses, we have assumed a single origin for all the observed signal power in the EPTA+InPTA data, however, an overlap of GWBs of different origins can cause the spectral shape of the recovered signal to deviate from the expected value of any single GWB. Searching, disentangling and identifying the underlying physical processes will be part of the spectral characterisation moving forward @2021NatAs...5.1268M @2022ApJ...938..115K 

As time goes by and the PTA experiment improves, the low-frequency GWB will leave an increasingly distinctive signature in the data. Interpreting all of the details of this signature will be necessary to understand the nature of the signal and exploit the full potential of this new window into the Universe. As mentioned in the introduction, a population of SMBHBs is expected to generate a highly non-Gaussian, partially anisotropic and perhaps non-stationary signal. As we increase the timespan of our data, improve our instrumentation and combine more pulsars, the detailed properties of the signal will eventually reveal themselves in the data (e.g. #cite(<2013CQGra..30v4005C>, style: "aas_noparen.csl") #cite(<2013PhRvD..88h4001T>, style: "aas_noparen.csl") #cite(<2020PhRvD.102h4039T>, style: "aas_noparen.csl") #cite(<2022ApJ...940..173P>, style: "aas_noparen.csl")). While many early Universe signals are expected to be isotropic and Gaussian, noticeable exceptions exist, such as GWBs from bursts of cosmic strings. Cross-correlating the power distribution of the nanohertz GW sky to the distribution of massive galaxies and large-scale structures in the low-$z$ universe can eventually provide the key to determining the true nature -- astrophysical vs. early Universe -- of this signal @2014MNRAS.439.3986R @2017NatAs...1..886M. In this respect, combining all of the available high-quality datasets within the IPTA framework is the next step towards the fulfilment of the promises of nanohertz GW science.

#block[
The European Pulsar Timing Array (EPTA) is a collaboration between European and partner institutes, namely ASTRON (NL), INAF/Osservatorio di Cagliari (IT), Max-Planck-Institut für Radioastronomie (GER), Nançay/Paris Observatory (FRA), the University of Manchester (UK), the University of Birmingham (UK), the University of East Anglia (UK), the University of Bielefeld (GER), the University of Paris (FRA), the University of Milan-Bicocca (IT), the Foundation for Research and Technology, Hellas (GR), and Peking University (CHN), with the aim to provide high-precision pulsar timing to work towards the direct detection of low-frequency gravitational waves. An Advanced Grant of the European Research Council allowed to implement the Large European Array for Pulsars (LEAP) under Grant Agreement Number 227947 (PI M. Kramer). The EPTA is part of the International Pulsar Timing Array (IPTA); we thank our IPTA colleagues for their support and help with this paper and the external Detection Committee members for their work on the Detection Checklist.

]

Part of this work is based on observations with the 100-m telescope of the Max-Planck-Institut für Radioastronomie (MPIfR) at Effelsberg in Germany. Pulsar research at the Jodrell Bank Centre for Astrophysics and the observations using the Lovell Telescope are supported by a Consolidated Grant (ST/T000414/1) from the UK's Science and Technology Facilities Council (STFC). ICN is also supported by the STFC doctoral training grant ST/T506291/1. The Nançay radio Observatory is operated by the Paris Observatory, associated with the French Centre National de la Recherche Scientifique (CNRS), and partially supported by the Region Centre in France. We acknowledge financial support from "Programme National de Cosmologie and Galaxies" (PNCG), and "Programme National Hautes Energies" (PNHE) funded by CNRS/INSU-IN2P3-INP, CEA and CNES, France. We acknowledge financial support from Agence Nationale de la Recherche (ANR-18-CE31-0015), France. The Westerbork Synthesis Radio Telescope is operated by the Netherlands Institute for Radio Astronomy (ASTRON) with support from the Netherlands Foundation for Scientific Research (NWO). The Sardinia Radio Telescope (SRT) is funded by the Department of University and Research (MIUR), the Italian Space Agency (ASI), and the Autonomous Region of Sardinia (RAS) and is operated as a National Facility by the National Institute for Astrophysics (INAF).

The work is supported by the National SKA programme of China (2020SKA0120100), Max-Planck Partner Group, NSFC 11690024, CAS Cultivation Project for FAST Scientific. This work is also supported as part of the "LEGACY" MPG-CAS collaboration on low-frequency gravitational wave astronomy. JA acknowledges support from the European Commission (Grant Agreement number: 101094354). JA and SCha were partially supported by the Stavros Niarchos Foundation (SNF) and the Hellenic Foundation for Research and Innovation (H.F.R.I.) under the 2nd Call of the "Science and Society -- Action Always strive for excellence -- Theodoros Papazoglou" (Project Number: 01431). AC acknowledges support from the Paris Île-de-France Region. AC, AF, ASe, ASa, EB, DI, GMS, MBo acknowledge financial support provided under the European Union's H2020 ERC Consolidator Grant "Binary Massive Black Hole Astrophysics" (B Massive, Grant Agreement: 818691). GD, KLi, RK and MK acknowledge support from European Research Council (ERC) Synergy Grant "BlackHoleCam", Grant Agreement Number 610058. This work is supported by the ERC Advanced Grant "LEAP", Grant Agreement Number 227947 (PI M. Kramer). AV and PRB are supported by the UK's Science and Technology Facilities Council (STFC; grant ST/W000946/1). AV also acknowledges the support of the Royal Society and Wolfson Foundation. JPWV acknowledges support by the Deutsche Forschungsgemeinschaft (DFG) through thew Heisenberg programme (Project No. 433075039) and by the NSF through AccelNet award \#2114721. NKP is funded by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) -- Projektnummer PO 2758/1--1, through the Walter--Benjamin programme. ASa thanks the Alexander von Humboldt foundation in Germany for a Humboldt fellowship for postdoctoral researchers. APo, DP and MBu acknowledge support from the research grant "iPeska" (P.I. Andrea Possenti) funded under the INAF national call Prin-SKA/CTA approved with the Presidential Decree 70/2016 (Italy). RNC acknowledges financial support from the Special Account for Research Funds of the Hellenic Open University (ELKE-HOU) under the research programme "GRAVPUL" (grant agreement 319/10-10-2022). EvdW, CGB and GHJ acknowledge support from the Dutch National Science Agenda, NWA Startimpuls -- 400.17.608. BG is supported by the Italian Ministry of Education, University and Research within the PRIN 2017 Research Program Framework, n. 2017SYRTCN. LS acknowledges the use of the HPC system Cobra at the Max Planck Computing and Data Facility.

\>1 The Indian Pulsar Timing Array (InPTA) is an Indo-Japanese collaboration that routinely employs TIFR's upgraded Giant Metrewave Radio Telescope for monitoring a set of IPTA pulsars. BCJ, YG, YM, SD, AG and PR acknowledge the support of the Department of Atomic Energy, Government of India, under Project Identification \# RTI 4002. BCJ, YG and YM acknowledge support of the Department of Atomic Energy, Government of India, under project No. 12-R&D-TFR-5.02-0700 while SD, AG and PR acknowledge support of the Department of Atomic Energy, Government of India, under project no. 12-R&D-TFR-5.02-0200. KT is partially supported by JSPS KAKENHI Grant Numbers 20H00180, 21H01130, and 21H04467, Bilateral Joint Research Projects of JSPS, and the ISM Cooperative Research Program (2021-ISMCRP-2017). AS is supported by the NANOGrav NSF Physics Frontiers Center (awards \#1430284 and 2020265). AKP is supported by CSIR fellowship Grant number 09/0079(15784)/2022-EMR-I. SH is supported by JSPS KAKENHI Grant Number 20J20509. KN is supported by the Birla Institute of Technology & Science Institute fellowship. AmS is supported by CSIR fellowship Grant number 09/1001(12656)/2021-EMR-I and T-641 (DST-ICPS). TK is partially supported by the JSPS Overseas Challenge Program for Young Researchers. We acknowledge the National Supercomputing Mission (NSM) for providing computing resources of 'PARAM Ganga' at the Indian Institute of Technology Roorkee as well as 'PARAM Seva' at IIT Hyderabad, which is implemented by C-DAC and supported by the Ministry of Electronics and Information Technology (MeitY) and Department of Science and Technology (DST), Government of India. DD acknowledges the support from the Department of Atomic Energy, Government of India through Apex Project - Advance Research and Education in Mathematical Sciences at IMSc.

The work presented here is a culmination of many years of data analysis as well as software and instrument development. In particular, we thank Drs. N.~D'Amico, P.~C.~C.~Freire, R.~van Haasteren, C.~Jordan, K.~Lazaridis, P.~Lazarus, L.~Lentati, O.~Löhmer and R.~Smits for their past contributions. We also thank Dr. N. Wex for supporting the calculations of the galactic acceleration as well as the related discussions. We would like to thank Prof. Drs. Alexey Starobinskiy, Sergei Blinnikov and Alexander Dolgov for discussions on the early Universe physics. HM acknowledges the support of the UK Space Agency, Grant No. ST/V002813/1 and ST/X002071/1. Some of the computations described in this paper were performed using the University of Birmingham's BlueBEAR HPC service, which provides a High Performance Computing service to the University's research community. See~#link("http://www.birmingham.ac.uk/bear") for more details. The EPTA is also grateful to staff at its observatories and telescopes who have made the continued observations possible. #emph[Author contributions.] The EPTA is a multi-decade effort and all authors have contributed through conceptualisation, funding acquisition, data-curation, methodology, software and hardware developments as well as (aspects of) the continued running of the observational campaigns, which includes writing and proofreading observing proposals, evaluating observations and observing systems, mentoring students, developing science cases. All authors also helped in (aspects of) verification of the data, analysis and results as well as in finalising the paper draft. Specific contributions from individual EPTA members are listed in the CRediT#footnote[#link("https://credit.niso.org/")] format below.

InPTA members contributed in uGMRT observations and data reduction to create the InPTA data set which is employed while assembling the `DR2full+` and `DR2new+` data sets.

JJan, KLi, GMS equally share the correspondence of the paper.

#emph[CRediT statement:] \

Conceptualisation: APa, APo, AV, BWS, CGB, CT, GHJ, GMS, GT, IC, JA, JJan, JPWV, JW, JWM, KJL, KLi, MK. \
Methodology: APa, AV, DJC, GMS, IC, JA, JJan, JPWV, JWM, KJL, KLi, LG, MK. \
Software: AC, AJ, APa, CGB, DJC, GMS, IC, JA, JJan, JJaw, JPWV, KJL, KLi, LG, MJK, RK. \
Validation: AC, APa, CGB, CT, GMS, GT, IC, JA, JJan, JPWV, JWM, KLi, LG. \
Formal Analysis: APa, CGB, DJC, DP, EvdW, GHJ, GMS, JA, JJan, JPWV, JWM, KLi. \
Investigation: APa, APo, BWS, CGB, DJC, DP, GMS, GT, IC, JA, JJan, JPWV, JWM, KLi, LG, MBM, MBu, MJK, RK. \
Resources: APa, APe, APo, BWS, GHJ, GMS, GT, HH, IC, JA, JJan, JPWV, JWM, KJL, KLi, LG, MJK, MK, RK. \
Data Curation: AC, AJ, APa, BWS, CGB, DJC, DP, EG, EvdW, GHJ, GMS, GT, HH, IC, JA, JJan, JPWV, JWM, KLi, LG, MBM, MBu, MJK, MK, NKP, RK, SChe, YJG. \
Writing -- Original Draft: APa, GMS, JA, JJan, KLi, LG. \
Writing -- Review & Editing: AC, AF, APa, APo, DJC, EB, EFK, GHJ, GMS, GT, JA, JJan, JPWV, JWM, KLi, MK, SChe, VVK. \
Visualisation: APa, GMS, JA, JJan, KLi. \
Supervision: APo, ASe, AV, BWS, CGB, DJC, EFK, GHJ, GMS, GT, IC, JA, JPWV, KJL, KLi, LG, MJK, MK, VVK. \
Project Administration: APo, ASe, AV, BWS, CGB, CT, GHJ, GMS, GT, IC, JJan, JPWV, JWM, KLi, LG, MK. \
Funding Acquisition: APe, APo, ASe, BWS, GHJ, GT, IC, JA, JJan, LG, MJK, MK. \

InPTA members contributed to the discussions that probed the impact of including InPTA data on single pulsar noise analysis. Furthermore, they provided quantitative comparisons of various noise models, wrote a brief description of the underlying `Tensiometer` package, and helped with the related interpretations.

APa, AC, MJK equally share the correspondence of the paper.

#emph[CRediT statement:] \

Conceptualisation: AC, APa, APo, AV, BWS, CT, GMS, GT, JPWV, JWM, KJL, KLi, MJK, MK. \
Methodology: AC, APa, AV, DJC, GMS, IC, JWM, KJL, KLi, LG, MJK, MK, SB, SChe, VVK. \
Software: AC, AJ, APa, APe, GD, GMS, KJL, KLi, MJK, RK, SChe, VVK. \
Validation: AC, APa, BG, GMS, IC, JPWV, JWM, KLi, LG, MJK. \
Formal Analysis: AC, APa, BG, EvdW, GHJ, GMS, JWM, KLi, MJK. \
Investigation: AC, APa, APo, BWS, CGB, DJC, DP, GMS, IC, JPWV, JWM, KLi, LG, MBM, MBu, MJK, RK, VVK. \
Resources: AC, APa, APe, APo, BWS, GHJ, GMS, GT, IC, JPWV, JWM, KJL, KLi, LG, MJK, MK, RK. \
Data Curation: AC, AJ, APa, BWS, CGB, DJC, DP, EvdW, GHJ, GMS, JA, JWM, KLi, MBM, MJK, MK, NKP, RK, SChe. \
Writing -- Original Draft: AC, APa, GMS, MJK. \
Writing -- Review & Editing: AC, AF, APa, APo, BG, EB, EFK, GMS, GT, JA, JPWV, JWM, KLi, MJK, MK, SChe, VVK. \
Visualisation: AC, APa, GMS, KLi, MJK. \
Supervision: AC, APo, ASe, AV, BWS, CGB, DJC, EFK, GHJ, GT, JPWV, KJL, LG, MJK, MK, VVK. \
Project Administration: AC, APo, ASe, AV, BWS, CGB, CT, GHJ, GMS, GT, JPWV, JWM, LG, MJK, MK. \
Funding Acquisition: APe, APo, ASe, BWS, GHJ, GT, IC, LG, MJK, MK. \

Additionally, InPTA members contributed to GWB search efforts with `DR2full+` and `DR2new+` data sets and their interpretations. Further, they provided quantitative comparisons of GWB posteriors that arise from these data sets and multiple pipelines.

For this work specifically, SChen and YJG equally share the correspondence of the paper.

#emph[CRediT statement:] \

Conceptualisation: AC, APa, APe, APo, ASe, AV, BG, CT, GMS, GT, IC, JA, JPWV, JWM, KJL, KLi, MK. \
Methodology: AC, APa, ASe, AV, DJC, GMS, JWM, KJL, KLi, LS, MK, SChe. \
Software: AC, AJ, APa, APe, GD, GMS, KJL, KLi, MJK, RK, SChe, VVK. \
Validation: AC, APa, ASe, AV, BG, GMS, HQL, JPWV, JWM, KLi, LS, SChe, YJG. \
Formal Analysis: AC, APa, ASe, AV, BG, EvdW, GMS, HQL, JWM, KLi, LS, MF, NKP, PRB, SChe, YJG. \
Investigation: APa, APo, ASe, AV, BWS, CGB, DJC, DP, GMS, JWM, KLi, LS, MBM, MBu, MF, PRB, RK, SB, SChe, YJG. \
Resources: AC, APa, APe, APo, ASe, AV, BWS, GHJ, GMS, GT, IC, JPWV, JWM, KJL, KLi, LG, LS, MJK, MK, RK. \
Data Curation: AC, AJ, APa, BWS, CGB, DJC, DP, EvdW, GMS, JA, JWM, KLi, MBM, MJK, MK, RK, SChe. \
Writing -- Original Draft: AC, APa, BG, DJC, GMS, JA, KLi, SB, SChe, YJG. \
Writing -- Review & Editing: AC, AF, APa, APo, ASe, AV, BG, DJC, EB, EFK, GMS, GT, JA, JPWV, JWM, KLi, LS, MBo, MK, NKP, PRB, SChe, VVK, YJG. \
Visualisation: APa, BG, GMS, KLi, MF, PRB, SChe. \
Supervision: APo, ASe, AV, BWS, CGB, DJC, EFK, GHJ, GMS, GT, JPWV, KJL, MK, SB. \
Project Administration: APo, ASe, AV, BWS, CGB, CT, GHJ, GMS, GT, JPWV, JWM, LG, MK, SChe. \
Funding Acquisition: APe, APo, ASe, AV, BWS, GHJ, GT, IC, JA, LG, MJK, MK, SB. \


#block[
= Supermassive black hole binaries - full corner plots <app:smbhb>
]

@fig:astroInformedFullCorner_nFreq9 and @fig:agn_fullCorner show the full posterior results for the astrophysically-informed and agnostic mode, respectively. Individual parameters are listed in the main text.

// [figvision-cn] imgs/gal_fullCorner_fBins9.png
// 这是一张天体物理模型参数后验分布的角图（corner plot），
// 由多个子图拼合而成，整体呈左下三角矩阵布局。该图包含15
// 个参数，因此是一个15×15的矩阵：对角线为15个一维边缘后
// 验分布直方图，左下三角为15×14/2=105个二维联合后验分布
// 等高线图，右上三角为空。所有子图共用同一组参数标签：α
// _1、α_2、log M_c、β、γ、δ、ε、ζ、η、ι、κ、λ、μ、ν、ξ（
// 具体符号依原图为准，此处按图中可辨识的希腊字母与符号记
// 录）。每个一维直方图上方标注了该参数的后验中位数及上下
// 界（如 α_1 = 2.7_{-1.4}^{+1.6}），直方图内灰色填充区域
// 为后验分布，绿色阶梯线为先验分布。二维等高线图中，灰色
// 填充区域与黑色轮廓线表示后验概率密度（通常为1σ、2σ、3σ
// 等值线），绿色轮廓线表示先验约束范围；部分二维图呈现明
// 显的双峰或香蕉形弯曲，表明参数间存在强相关性。图中所有
// 坐标轴均为线性或对数刻度（log M_c 为对数），单位未在图
// 中明确标出，但参数范围可从刻度值读出：α_1 约 0–8，α_2
// 约 -2–6，log M_c 约 0–4，β 约 -4–2，γ 约 -2–4，δ 约 -2
// –2，ε 约 -2–2，ζ 约 -2–2，η 约 -2–2，ι 约 -2–2，κ 约
// -2–2，λ 约 -2–2，μ 约 -2–2，ν 约 -2–2，ξ 约 -2–2。整体
// 趋势显示：多数参数后验分布较先验显著收窄，表明数据对参
// 数有约束；部分参数（如 α_2 与 log M_c、β 与 γ）呈现强
// 正相关或负相关，二维等高线沿对角线拉长；少数参数后验与
// 先验几乎重合，表明数据约束较弱。该图传达的结论是：天体
// 物理信息模型的所有参数后验均已获得，且部分参数间存在显
// 著简并。
#figure(placement: top, image("imgs/gal_fullCorner_fBins9.png", width: 100%),
  caption: [
    Marginalised posterior distributions for all $18$ parameters of the astrophysically-informed model. The posterior and prior are shown in grey and green, respectively.
  ]
) <fig:astroInformedFullCorner_nFreq9>

// [figvision-cn] imgs/agn_fullCorner_fBins9.png
// 这是一张5×5的角图（corner plot），以矩阵形式展示不可知
// 超大质量双黑洞（SMBHB）模型五个参数的边缘化后验概率分
// 布。整个矩阵呈下三角布局：对角线上的五个子图为各参数的
// 一维边缘化后验直方图，对角线以下的十个子图为参数两两组
// 合的二维后验概率密度等值线图，对角线以上的子图留空。所
// 有子图共用同一组参数轴定义，每个参数轴的范围、刻度与标
// 签如下：第一参数 log₁₀(ṅ₀/(Mpc⁻³Gyr⁻¹))，横轴刻度从−12
// 到0，步长4；第二参数 β_z，刻度从0到6，步长2；第三参数
// z₀，刻度从1到4，步长1；第四参数 α_M，刻度从−1.5到1.5，
// 步长1.5；第五参数 log₁₀(M*/M_☉)，刻度从6.6到8.4，步长
// 0.6。所有一维直方图的纵轴为概率密度（无刻度标签）；所
// 有二维图的横轴与纵轴分别对应其所在列与行的参数，刻度与
// 上述定义一致。 对角线上五个一维直方图均以黑色阶梯线绘
// 制，直方图内部用竖直黑色虚线标出后验分布的中位数及置信
// 区间边界（图中表现为一组共三条竖向虚线，分别位于分布的
// 低分位、中位数和高分位处）。各参数的一维分布特征如下：
// log₁₀(ṅ₀) 的直方图峰值位于约−10至−9之间，分布呈单峰、
// 略向左偏，三条竖线分别位于约−11、−9.5和−7.5；β_z 的直
// 方图在约2至3处达到峰值，分布较宽，竖线位于约0.5、3和6；
// z₀ 的直方图在约2.5至3之间达到峰值，分布较窄且单峰，竖
// 线位于约1.2、2.8和4.2；α_M 的直方图在约−1至0之间较为平
// 坦，整体分布宽缓，竖线位于约−1.5、0和1.5；log₁₀(M*/M_☉
// ) 的直方图在约7.2至7.8之间呈宽峰，竖线位于约6.7、7.8和
// 8.4。 对角线以下的二维等值线图均以同一色标绘制，颜色从
// 白色（低密度）到深灰色（高密度）过渡，等值线为黑色实线。
// 各二维图展示的参数相关性如下：log₁₀(ṅ₀) 与 β_z 的二维
// 图显示出一条从左上向右下倾斜的高密度带，说明二者存在负
// 相关趋势，深色区域集中在 log₁₀(ṅ₀)≈−10、β_z≈3 附近；
// log₁₀(ṅ₀) 与 z₀ 的图显示高密度区集中在 z₀≈2.5–3.5、log
// ₁₀(ṅ₀)≈−11至−9，呈近竖直的窄带；log₁₀(ṅ₀) 与 α_M 的图
// 显示高密度区在 α_M 方向较宽，在 log₁₀(ṅ₀) 方向较窄，等
// 值线呈近竖直分布；log₁₀(ṅ₀) 与 log₁₀(M*/M_☉) 的图显示
// 高密度区沿对角线方向延伸，从 log₁₀(ṅ₀)≈−11、log₁₀(M*/
// M_☉)≈7.8 延伸至 log₁₀(ṅ₀)≈−8、log₁₀(M*/M_☉)≈6.8，呈负
// 相关；β_z 与 z₀ 的图显示高密度区集中在 β_z≈2–4、z₀≈2–3
// 的块状区域，等值线较为复杂；β_z 与 α_M 的图显示高密度
// 区在 α_M 方向较宽，在 β_z 方向集中在2–4；β_z 与 log₁₀(
// M*/M_☉) 的图显示高密度区在 log₁₀(M*/M_☉)≈7.5–8.0、β_z≈
// 2–4 附近；z₀ 与 α_M 的图显示高密度区集中在 z₀≈2–3.5、α
// _M≈−1至0.5，等值线在 z₀ 方向较窄；z₀ 与 log₁₀(M*/M_☉)
// 的图显示高密度区集中在 z₀≈2–3.5、log₁₀(M*/M_☉)≈7.5–8.0；
// α_M 与 log₁₀(M*/M_☉) 的图显示高密度区在 α_M 方向较宽，
// 在 log₁₀(M*/M_☉)≈7.5–8.0 附近。总体而言，该图传达的趋
// 势是：log₁₀(ṅ₀)、β_z、z₀ 和 log₁₀(M*/M_☉) 四个参数的后
// 验分布相对集中，而 α_M 的后验分布较宽且与其他参数的相
// 关性较弱；参数间存在若干明显的负相关或聚集区域，例如
// log₁₀(ṅ₀) 与 β_z、log₁₀(ṅ₀) 与 log₁₀(M*/M_☉) 之间的负
// 相关趋势。
#figure(placement: top, [#block[
  #box(image("imgs/agn_fullCorner_fBins9.png", width: 100%))
  ]],
  caption: [
    Marginalised posteriors for all five parameters of the agnostic SMBHB model.
  ]
) <fig:agn_fullCorner>


#show bibliography: set text(size: 8pt)
#show heading.where(level: 1): set align(left)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#show heading.where(level: 1): set align(left)
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)
