#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.36cm, bottom: 2.36cm))
#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: (..n) => numbering(if n.len() == 1 { "1." } else if n.len() == 2 { "1.1." } else { "1.1.1." }, ..n), supplement: none)
#set par(justify: true, spacing: 0.97em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.59em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9pt)

#align(center)[
  #text(10pt, weight: "bold", [The Atacama Cosmology Telescope: DR6 Constraints on Extended Cosmological Models])
]
#v(0.8em)
#text(9pt)[
Erminia Calabrese#super[1], J. Colin Hill#super[2,3], Hidde T. Jense#super[1], Adrien La Posta#super[4], Irene Abril-Cabezas#super[5,6], Graeme E. Addison#super[7], Peter A. R. Ade#super[1], Simone Aiola#super[3,8], Tommy Alford#super[9], David Alonso#super[4], Mandana Amiri#super[10], Rui An#super[11], Zachary Atkins#super[8], Jason E. Austermann#super[12], Eleonora Barbavara#super[13], Nicola Barbieri#super[14,15], Nicholas Battaglia#super[16,17], Elia Stefano Battistelli#super[13], James A. Beall#super[12], Rachel Bean#super[16], Ali Beheshti#super[18], Benjamin Beringue#super[17], Tanay Bhandarkar#super[19], Emily Biermann#super[20], Boris Bolliet#super[21,6], J Richard Bond#super[22], Valentina Capalbo#super[13], Felipe Carrero#super[23], Shi-Fan Chen#super[24], Grace Chesmore#super[9], Hsiao-mei Cho#super[25,12], Steve K. Choi#super[26], Susan E. Clark#super[27,28], Nicholas F. Cothard#super[29], Kevin Coughlin#super[9], William Coulton#super[6,5], Devin Crichton#super[30], Kevin T. Crowley#super[31], Omar Darwish#super[32], Mark J. Devlin#super[19], Simon Dicker#super[19], Cody J. Duell#super[33], Shannon M. Duff#super[12], Adriaan J. Duivenvoorden#super[34], Jo Dunkley#super[8,35], Rolando Dunner#super[23], Carmen Embil Villagra#super[5,6], Max Fankhanel#super[36], Gerrit S. Farren#super[37,38], Simone Ferraro#super[37,39,38], Allen Foster#super[8], Rodrigo Freundt#super[16], Brittany Fuzia#super[40], Patricio A. Gallardo#super[9,19], Xavier Garrido#super[41], Martina Gerbino#super[15], Serena Giardiello#super[1], Ajay Gill#super[42], Jahmour Givans#super[35], Vera Gluscevic#super[11], Samuel Goldstein#super[2], Joseph E. Golec#super[9], Yulin Gong#super[16], Yilun Guan#super[43], Mark Halpern#super[10], Ian Harrison#super[1], Matthew Hasselfield#super[3], Adam He#super[11], Erin Healy#super[9,8], Shawn Henderson#super[25], Brandon Hensley#super[44], Carlos Hervías-Caimapo#super[23], Gene C. Hilton#super[12], Matt Hilton#super[45,46], Adam D. Hincks#super[47,48], Renée Hložek#super[43,47], Shuay-Pwu Patty Ho#super[8], John Hood#super[49], Erika Hornecker#super[47], Zachary B. Huber#super[33], Johannes Hubmayr#super[12], Kevin M. Huffenberger#super[50], John P. Hughes#super[51], Margaret Ikape#super[47], Kent Irwin#super[27], Giovanni Isopi#super[13], Neha Joshi#super[19], Ben Keller#super[33], Joshua Kim#super[19], Kenda Knowles#super[52], Brian J. Koopman#super[53], Arthur Kosowsky#super[18], Darby Kramer#super[54], Aleksandra Kusiak#super[55,6], Alex Laguë#super[19], Victoria Lakey#super[56], Massimiliano Lattanzi#super[15], Eunseong Lee#super[19], Yaqiong Li#super[33], Zack Li#super[39,38], Michele Limon#super[19], Martine Lokken#super[57], Thibaut Louis#super[41], Marius Lungu#super[9], Niall MacCrann#super[5,6], Amanda MacInnis#super[58], Mathew S. Madhavacheril#super[19], Diego Maldonado#super[36], Felipe Maldonado#super[40], Maya Mallaby-Kay#super[49], Gabriela A. Marques#super[59,60], Joshiwa van Marrewijk#super[61], Fiona McCarthy#super[5,6], Jeff McMahon#super[60,49,9,62], Yogesh Mehta#super[54], Felipe Menanteau#super[63,64], Kavilan Moodley#super[46], Thomas W. Morris#super[53,65], Tony Mroczkowski#super[66], Sigurd Naess#super[67], Toshiya Namikawa#super[5,6,68], Federico Nati#super[69], Simran K. Nerval#super[47,43], Laura Newburgh#super[53], Andrina Nicola#super[70], Michael D. Niemack#super[33,16], Michael R. Nolta#super[22], John Orlowski-Scherer#super[19], Luca Pagano#super[14,15,71], Lyman A. Page#super[8], Shivam Pandey#super[2], Bruce Partridge#super[72], Karen Perez Sarmiento#super[19], Heather Prince#super[51], Roberto Puddu#super[23], Frank J. Qu#super[27,28,6], Damien C. Ragavan#super[45], Bernardita Ried Guachalla#super[27,28], Keir K. Rogers#super[73,43], Felipe Rojas#super[23], Tai Sakuma#super[8], Emmanuel Schaan#super[25,28], Benjamin L. Schmitt#super[19], Neelima Sehgal#super[58], Shabbir Shaikh#super[54], Blake D. Sherwin#super[5,6], Carlos Sierra#super[9], Jon Sievers#super[74], Cristóbal Sifón, Sara Simon#super[59], Rita Sonka#super[8], David N. Spergel#super[3], Suzanne T. Staggs#super[8], Emilie Storer#super[74,8], Kristen Surrao#super[2], Eric R. Switzer#super[29], Niklas Tampier#super[36], Leander Thiele#super[75,68], Robert Thornton#super[76,19], Hy Trac#super[77], Carole Tucker#super[1], Joel Ullom#super[12], Leila R. Vale#super[12], Alexander Van Engelen#super[54], Jeff Van Lanen#super[12], Cristian Vargas#super[50], Eve M. Vavagiakis#super[78,33], Kasey Wagoner#super[79,8], Yuhan Wang#super[33], Lukas Wenzl#super[16], Edward J. Wollack#super[29], Kaiwen Zheng#super[8]
]
#v(0.5em)
#align(center)[#text(9.5pt)[(Affiliations can be found at the end of the document)]]
#v(0.8em)
#text(8pt)[#emph[Corresponding authors:] Erminia Calabrese (calabresee\@cardiff.ac.uk), Colin Hill (jch2200\@columbia.edu)]
#v(1em)

#align(center)[#text(10pt)[ABSTRACT]]
#block(inset: (left: 34pt, right: 40pt))[#text(10pt)[#set par(leading: 0.55em)
We use new cosmic microwave background (CMB) primary temperature and polarization anisotropy measurements from the Atacama Cosmology Telescope (ACT) Data Release 6 (DR6) to test foundational assumptions of the standard cosmological model, $Lambda"CDM"$, and set constraints on extensions to it. We derive constraints from the ACT DR6 power spectra alone, as well as in combination with legacy data from the #emph[Planck] mission. To break geometric degeneracies, we include ACT and #emph[Planck] CMB lensing data and baryon acoustic oscillation data from DESI Year-1. To test the dependence of our results on non-ACT data, we also explore combinations replacing #emph[Planck] with #emph[WMAP] and DESI with BOSS, and further add supernovae measurements from PantheonPlus for models that affect the late-time expansion history. We verify the near-scale-invariance (running of the spectral index $d n_s / d ln k = 0.0062 plus.minus 0.0052$) and adiabaticity of the primordial perturbations. Neutrino properties are consistent with Standard Model predictions: we find no evidence for new light, relativistic species that are free-streaming ($N_("eff") = 2.86 plus.minus 0.13$, which combined with astrophysical measurements of primordial helium and deuterium abundances becomes $N_("eff") = 2.89 plus.minus 0.11$), for non-zero neutrino masses ($sum m_nu < 0.089$~eV at 95% CL), or for neutrino self-interactions. We also find no evidence for self-interacting dark radiation ($N_(upright(i d r)) < 0.134$), or for early-universe variation of fundamental constants, including the fine-structure constant ($alpha_("EM") / alpha_(upright("EM,0")) = 1.0043 plus.minus 0.0017$) and the electron mass ($m_e / m_(e , 0) = 1.0063 plus.minus 0.0056$). Our data are consistent with standard big bang nucleosynthesis (we find $Y_p = 0.2312 plus.minus 0.0092$), the #emph[COBE/FIRAS]-inferred CMB temperature (we find $T_("CMB") = 2.698 plus.minus 0.016$~K), a dark matter component that is collisionless and with only a small fraction allowed as axion-like particles, a cosmological constant ($w = - 0.986 plus.minus 0.025$), and the late-time growth rate predicted by general relativity ($gamma = 0.663 plus.minus 0.052$). We find no statistically significant preference for a departure from the baseline $Lambda"CDM"$~model. In fits to models invoking early dark energy, primordial magnetic fields, or an arbitrary modified recombination history, we find $H_0 = 69.9_(- 1.5)^(+ 0.8)$, $69.1 plus.minus 0.5$, or $69.6 plus.minus 1.0$~km/s/Mpc, respectively; using BOSS instead of DESI BAO data reduces the central values of these constraints by 1--1.5~km/s/Mpc while only slightly increasing the error bars. In general, models introduced to increase the Hubble constant or to decrease the amplitude of density fluctuations inferred from the primary CMB are not favored over $Lambda"CDM"$~by our data.]]






#align(center)[#text(10pt, weight: "bold")[Contents]]
#v(0.6em)
#show outline.entry.where(level: 1): set block(above: 0.9em)
#columns(2, gutter: 1.06cm)[#outline(title: none, depth: 3)]
#pagebreak()
#columns(2, gutter: 1.06cm)[

= Introduction
<sec:intro>
The $Lambda$ cold dark matter ($Lambda$CDM) cosmological model has emerged as the standard model of cosmology over the past quarter-century, undergirded by precision measurements of the cosmic microwave background (CMB) primary anisotropy power spectra in both temperature and polarization~@wmap_spergel_2003#cite(<bennett-etal-2013>)@Planck_2018_params@rosenberg:2022@hillipop2024@Choi2020@Bakenhol_SPT#cite(<2025arXiv250106890C>, supplement: [and upcoming South Pole Telescope results]), the expansion history of the universe as probed by baryon acoustic oscillations (BAO; ~#cite(<Eisenstein2005>, style: "aas_noparen.csl")#cite(<BOSS2013>, style: "aas_noparen.csl")#cite(<DESI-BAO-III>, style: "aas_noparen.csl")) and Type Ia supernovae measurements (SNIa;~#cite(<Riess1998>, style: "aas_noparen.csl")#cite(<Perlmutter1999>, style: "aas_noparen.csl")#cite(<Union3>, style: "aas_noparen.csl")#cite(<Rubin2023_Union3>, style: "aas_noparen.csl")#cite(<Pantheon>, style: "aas_noparen.csl")#cite(<PantheonPlus>, style: "aas_noparen.csl")#cite(<DES_SN>, style: "aas_noparen.csl")), the growth of structure from gravitational lensing and galaxy clustering measurements~@2004ApJ...606..702T@Smith2007@Das2011@vanEngelen2012@Planck_2018_lensing@Carron_pr4_lensing@SPT_lensing@Qu_dr6_lensing@SPT3G2024@DES_lensing@Amon_2022@Secco_2022@Heymans_2021@Asgari_2021@More_2023@Miyatake_2023@Sugiyama_2023@Dalal_2023@Li_2023@DES_KIDS_shear_2023@BOSS-LRG@eBOSS-LRG@PhilcoxIvanov2022@DESI_fullshape_2024, and a wide array of additional probes. However, there is strong motivation to further test the model and its underlying ingredients, particularly given our lack of microphysical knowledge of the dark sector. The CMB is a uniquely powerful probe of extensions to $Lambda$CDM~@Planck_2018_params@Aiola2020@Balkenhol_SPT_ext, both because of the theoretical accuracy with which new signals can be predicted in the CMB and because the CMB is sensitive to weakly-coupled new physics that is often otherwise difficult to probe.

In this paper, we stress-test $Lambda"CDM"$~using a state-of-the-art CMB dataset built from the new Atacama Cosmology Telescope (ACT) Data Release 6 (DR6) measurements of the small-scale CMB temperature and polarization power spectra. A companion paper presents these data and combines them with the #emph[Planck] mission legacy data~@Planck_2018_overview@Planck_2018_likelihood to form the most statistically constraining CMB power spectrum dataset assembled to date~#cite(<dr6ps>). To validate constraints derived from the combination of ACT and #emph[Planck] data, we also perform analyses combining ACT with legacy data from the #emph[Planck] mission~#cite(<bennett-etal-2013>)#cite(<WMAP9_Hinshaw>). To assist in parameter degeneracy-breaking, we further add gravitational lensing measurements of the CMB from ACT DR6 and #emph[Planck] @Qu_dr6_lensing@Madhavacheril_dr6_lensing@Carron_pr4_lensing, as well as BAO distance measurements from the Dark Energy Spectroscopic Instrument (DESI;~#cite(<DESI-BAO-III>, style: "aas_noparen.csl")#cite(<DESI_BAO_Lya>, style: "aas_noparen.csl")) or the Baryon Oscillation Spectroscopic Survey (BOSS;~#cite(<BOSS-LRG>, style: "aas_noparen.csl")#cite(<eBOSS-LRG>, style: "aas_noparen.csl")), and from the PantheonPlus supernovae compilation~#cite(<PantheonPlus>). Further low-redshift data are used in some analyses as well, where significant additional constraining power can be gained.

We test the cosmological model via both single-parameter extensions of $Lambda"CDM"$~and by relaxing its fundamental assumptions --- for example, considering variations in the underlying particle physics, energy densities of various components, and gravitational and non-gravitational interactions between them. We constrain new physics operating at energy scales ranging from the inflationary epoch to the recombination epoch to the late-time universe, including models that have been constructed with the aim of increasing the value of the Hubble constant or decreasing the amplitude of late-time density fluctuations inferred from the primary CMB, as well as models motivated by more fundamental considerations in particle physics, such as the existence of new light species in the early universe.

This work builds on --- and extends --- previous cosmological explorations performed with ACT CMB power spectrum measurements~@Dunkley2011@Sievers2013@Louis2017@Aiola2020@Thiele2021@Hill_ACT_EDE@An_ACT_DM@Li_ACT_DMB#cite(<Kreisch_ACT_SIN>). The new ACT DR6 data provide higher sensitivity over a broad range of angular scales, allowing us to access potential signals that would previously have been hidden in the noise. In some cases (depending on the model extension), the ACT DR6 sensitivity is comparable to that achieved by the #emph[Planck] legacy dataset~@Planck_2018_params and serves as a useful cross-check of the CMB response to a specific cosmological model. In other cases, because ACT DR6 provides constraining power in a different region of the power spectrum compared to ~(particularly in polarization), the joint fit to both datasets surpasses bounds from #emph[Planck] alone and thus represents a new state of the art.

Figure~#ref(<fig:lcdm_single_extensions_pactlb>, supplement: none) highlights new leading results from ACT DR6 combined with other datasets on a wide range of benchmark single-parameter $Lambda"CDM"$~extensions that are studied in detail later in this paper. This figure is not exhaustive and shows only a small fraction of the extended models analyzed in this work. Figure~#ref(<fig:lcdm_single_extensions_pact>, supplement: none) isolates the specific contributions from the new ACT DR6 data to the primary CMB-derived constraints, by comparing constraints from ACT alone, #emph[Planck] alone, and their combination. It is evident that the new ACT DR6 data have reached a level of precision competitive with that of #emph[Planck]; furthermore, due to the complementarity of the two datasets, their joint analysis yields significant gains over the sensitivity of #emph[Planck] alone, as will be explored throughout this paper.

// [figvision-cn] imgs/fig1.png
// 这是一张由 5 行 6 列共 30 个子图组成的参数约束等高线图
// （相图），用于展示不同数据集对宇宙学单参数扩展模型的限
// 制。所有子图均为二维后验概率分布等高线图。 整体布局：
// 列对应 6 个水平轴参数，行对应 5 个垂直轴参数。从左到右
// 的列水平轴依次为：Ω_b h²（范围 0.0220 至 0.0228，无单
// 位）、Ω_c h²（范围 0.11 至 0.12，无单位）、H_0（范围
// 65 至 75，单位 km/s/Mpc）、n_s（范围 0.96 至 0.98，无
// 单位）、Ω_m（范围 0.25 至 0.30，无单位）、S_8（范围
// 0.80 至 0.83，无单位）。从上到下的行垂直轴依次为：Σm_ν
// （范围 0.00 至 0.15，单位 eV）、N_eff（范围 2.50 至
// 3.25，无单位）、dn_s/dln k（范围 -0.01 至 0.02，无单位）、
// Y_He（范围 0.20 至 0.24，无单位）、w（范围 -1.3 至
// -1.0，无单位）。 颜色与线型：紫色填充等高线代表
// P-ACT-LB 数据集组合（ACT DR6 + Planck + 透镜 + DESI
// BAO），深紫色内圈为 68% 置信区间，浅紫色外圈为 95% 置
// 信区间。金色/橙色填充等高线代表 P-ACT-LBS 数据集组合（
// 在 P-ACT-LB 基础上加入 PantheonPlus 超新星数据），仅出
// 现在最底行（w 为垂直轴）的 6 个子图中，深金色内圈为 68%，
// 浅金色外圈为 95%。每个子图中均有一条灰色水平虚线，对应
// 垂直轴参数的基准值（Σm_ν=0.06 eV、N_eff=3.04、dn_s/dln
// k=0、Y_He=0.245、w=-1）。 各行具体趋势： 第一行（垂直
// 轴 Σm_ν）：紫色等高线在水平轴 Ω_b h²、Ω_c h²、H_0、n_s、
// Ω_m、S_8 上均收敛于约 0.02-0.06 eV 区间，且与灰色虚线
// 0.06 eV 相交或相切，表明数据对 Σm_ν 给出上限约束。第 3
// 列（H_0）的等高线极窄，显示强相关性；第 6 列（S_8）等
// 高线较宽，呈向右上倾斜的椭圆。 第二行（垂直轴 N_eff）：
// 紫色等高线在 Ω_b h² 上呈向右上倾斜的椭圆，在 Ω_c h² 上
// 呈向右下倾斜的椭圆，在 H_0 上极窄且向右上倾斜，在 n_s
// 上呈向右上倾斜的椭圆，在 Ω_m 上呈向右下倾斜的椭圆，在
// S_8 上呈近似圆形的大椭圆。所有等高线均覆盖灰色虚线
// 3.04。 第三行（垂直轴 dn_s/dln k）：紫色等高线在 Ω_b h
// ² 上呈向右上倾斜的椭圆，在 Ω_c h² 上呈垂直窄椭圆，在
// H_0 上极窄近乎垂直，在 n_s 上呈垂直椭圆，在 Ω_m 上呈垂
// 直窄椭圆，在 S_8 上呈近似圆形的大椭圆。所有等高线均覆
// 盖灰色虚线 0。 第四行（垂直轴 Y_He）：紫色等高线在 Ω_b
// h² 上呈向右上倾斜的椭圆，在 Ω_c h² 上呈垂直椭圆，在
// H_0 上极窄垂直，在 n_s 上呈向右上倾斜的椭圆，在 Ω_m 上
// 呈垂直窄椭圆，在 S_8 上呈近似圆形的大椭圆。所有等高线
// 均覆盖灰色虚线 0.245。 第五行（垂直轴 w）：包含紫色和
// 金色两组等高线。在 Ω_b h² 上，紫色等高线呈垂直椭圆，金
// 色等高线呈水平椭圆，两者在 w=-1 附近交叠；在 Ω_c h² 上，
// 紫色呈垂直椭圆，金色呈水平椭圆；在 H_0 上，紫色呈向右
// 下倾斜的窄椭圆，金色呈向右上倾斜的窄椭圆，两者在 w=-1
// 附近交叉；在 n_s 上，紫色呈垂直椭圆，金色呈水平椭圆；
// 在 Ω_m 上，紫色呈向右下倾斜的窄椭圆，金色呈向右上倾斜
// 的窄椭圆；在 S_8 上，紫色呈近似圆形的大椭圆，金色呈水
// 平椭圆。所有紫色和金色等高线均覆盖灰色虚线 w=-1。 结论：
// 该图展示了 P-ACT-LB 和 P-ACT-LBS 数据集对 5 个单参数扩
// 展模型（中微子质量、有效相对论自由度、原初功率谱跑动、
// 氦丰度、暗能量状态方程）的约束，所有参数均与基准值一致，
// 且加入超新星数据后对 w 的约束显著收紧。
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

#figure(image("imgs/fig1.png"),
  caption: [
    Constraints on single-parameter extensions to $Lambda"CDM"$~(vertical axis) versus key $Lambda"CDM"$~parameters (horizontal axis) from the combination of the new ACT DR6 power spectra with #emph[Planck] legacy CMB spectra, CMB lensing from #emph[Planck] and ACT, and BAO from DESI Year-1 data (purple; labeled P-ACT-LB, as defined in~§@sec:glossary). We further add SNIa data from PantheonPlus (gold; with label P-ACT-LBS) for models that affect the late-time expansion history. The rows span over models varying neutrino physics (the summed mass and number of neutrinos with $sum m_nu$ and $N_("eff")$ respectively, §@sec:neutrinos), variation of the primordial scalar perturbation spectral index with scale ($d n_s / d ln k$, §@sec:running), the abundance of primordial helium ($Y_(upright("He"))$, §@sec:bbn), and the dark energy equation of state ($w$, §@sec:de). These are shown across columns against $Lambda"CDM"$~parameters quantifying the baryon, cold dark matter, and total matter densities ($Omega_b h^2$ and $Omega_c h^2$ and $Omega_m$, respectively), the Hubble constant ($H_0$) in km/s/Mpc, the spectral index of primordial scalar perturbations ($n_s$), and the amplitude of density fluctuations ($S_8$). The contours show confidence levels at 68% and 95% (dark and light shade, respectively). The dashed gray lines mark the canonical values expected for these parameters in the standard models of cosmology and particle physics.
  ],
  placement: top,
  scope: "parent"
)
<fig:lcdm_single_extensions_pactlb>

// [figvision-cn] imgs/fig2.png
// 这是一张 5 行 6 列的三角形相关图（corner plot，也称三
// 角图），用于展示宇宙学参数的后验概率分布及两两参数间的
// 相关性。整张图共有 30 个子图，其中 6 个是对角线子图（
// 展示单个参数的边缘概率密度），24 个是非对角线子图（展
// 示两两参数的联合概率分布等高线）。所有子图共用同一套图
// 例：浅蓝色代表 ACT DR6 CMB 功率谱的约束结果，橙色代表
// Planck legacy CMB 功率谱的约束结果，深蓝色（海军蓝）代
// 表两者联合分析（P-ACT）的结果。 整张图中，每个非对角线
// 子图都包含三组填充等高线，分别对应 68% 和 95% 置信区间
// （内层深色、外层浅色）。图中所有子图的横轴和纵轴刻度线
// 均向内，且所有面板之间没有空隙。图中还画有黑色虚线参考
// 线，分别对应每个纵轴参数的特定基准值。 以下逐列说明各
// 子图： 第 1 列（横轴为 Ω_b h²，范围 0.0218 至 0.0229
// 左右，单位无量纲）： 子图 (1,1) 为对角线边缘概率密度曲
// 线，横轴 Ω_b h²，纵轴为概率密度（无刻度）。浅蓝曲线较
// 宽、峰值偏低，橙色曲线更窄、峰值更高，深蓝曲线最窄且峰
// 值最高。 子图 (2,1) 纵轴 N_eff（范围约 1.8 至 3.5），
// 橙色与深蓝色等高线呈左上-右下倾斜的椭圆，浅蓝色区域更
// 大且更向右下延伸。 子图 (3,1) 纵轴 d n_s / d ln k（范
// 围约 -0.05 至 0.12），橙色等高线中心在 0 附近，浅蓝色
// 向正方向延伸更宽，深蓝色收缩在 0 附近。 子图 (4,1) 纵
// 轴 Y_He（范围约 0.17 至 0.26），等高线呈左上-右下倾斜，
// 浅蓝色区域明显大于橙色和深蓝色。 子图 (5,1) 纵轴 w（范
// 围约 -1.6 至 -0.4），橙色和深蓝色等高线中心在 -1.0 附
// 近，浅蓝色向上下两端延伸更宽。 第 2 列（横轴为 Ω_c h²，
// 范围 0.11 至 0.13 左右）： 子图 (1,2) 纵轴 Σm_ν（范围
// 0 至 0.45 左右），橙色、浅蓝、深蓝等高线均呈底部窄、顶
// 部宽的楔形，浅蓝色向高值延伸最多。 子图 (2,2) 纵轴
// N_eff（范围 1.8 至 3.5），等高线呈左上-右下倾斜，浅蓝
// 色区域最大。 子图 (3,2) 纵轴 d n_s / d ln k，橙色和深
// 蓝色中心在 0 附近，浅蓝色向正方向延伸。 子图 (4,2) 纵
// 轴 Y_He，等高线呈左上-右下倾斜，深蓝色最窄。 子图 (5,2
// ) 纵轴 w，橙色和深蓝色中心在 -1.0 附近，浅蓝色向低值延
// 伸更多。 第 3 列（横轴为 H_0，范围 55 至 75 左右，单位
// km/s/Mpc）： 子图 (1,3) 纵轴 Σm_ν，浅蓝色等高线呈从左
// 上到右下的长条状，橙色和深蓝色更窄且集中在低 H_0 端。
// 子图 (2,3) 纵轴 N_eff，等高线呈左上-右下倾斜，浅蓝色区
// 域最大。 子图 (3,3) 纵轴 d n_s / d ln k，橙色和深蓝色
// 中心在 0 附近且非常窄，浅蓝色向正方向延伸。 子图 (4,3)
// 纵轴 Y_He，等高线呈左上-右下倾斜，深蓝色最窄。 子图 (5
// ,3) 纵轴 w，等高线呈左上-右下倾斜的长条状，三种颜色几
// 乎重合，覆盖整个 H_0 范围。 第 4 列（横轴为 n_s，范围
// 约 0.93 至 0.99）： 子图 (1,4) 纵轴 Σm_ν，等高线呈底部
// 窄、顶部宽的楔形，浅蓝色向高值延伸最多。 子图 (2,4) 纵
// 轴 N_eff，等高线呈左上-右下倾斜，深蓝色收缩在中间。 子
// 图 (3,4) 纵轴 d n_s / d ln k，浅蓝色等高线呈左上-右下
// 倾斜的椭圆，橙色和深蓝色非常窄且中心在 0 附近。 子图 (
// 4,4) 纵轴 Y_He，等高线呈左上-右下倾斜，浅蓝色区域最大。
// 子图 (5,4) 纵轴 w，橙色和深蓝色中心在 -1.0 附近且非常
// 窄，浅蓝色向上下两端延伸。 第 5 列（横轴为 Ω_m，范围约
// 0.25 至 0.45 左右）： 子图 (1,5) 纵轴 Σm_ν，等高线呈底
// 部窄、顶部宽的楔形，浅蓝色向高值延伸最多。 子图 (2,5)
// 纵轴 N_eff，等高线呈左上-右下倾斜，深蓝色最窄。 子图 (
// 3,5) 纵轴 d n_s / d ln k，橙色和深蓝色中心在 0 附近，
// 浅蓝色向正方向延伸。 子图 (4,5) 纵轴 Y_He，等高线呈左
// 上-右下倾斜，浅蓝色区域最大。 子图 (5,5) 纵轴 w，等高
// 线呈从左下到右上的弧形长条，三种颜色几乎重合，覆盖整个
// Ω_m 范围。 第 6 列（横轴为 S_8，范围约 0.75 至 0.95 左
// 右）： 子图 (1,6) 纵轴 Σm_ν，等高线呈底部窄、顶部宽的
// 楔形，浅蓝色向高值延伸最多。 子图 (2,6) 纵轴 N_eff，等
// 高线呈左上-右下倾斜，浅蓝色区域最大。 子图 (3,6) 纵轴
// d n_s / d ln k，橙色和深蓝色中心在 0 附近，浅蓝色向正
// 方向延伸。 子图 (4,6) 纵轴 Y_He，等高线呈左上-右下倾斜，
// 浅蓝色区域最大。 子图 (5,6) 纵轴 w，等高线呈从左下到右
// 上的弧形长条，三种颜色几乎重合，覆盖整个 S_8 范围。 总
// 体趋势与结论：浅蓝色（ACT）的约束通常比橙色（Planck）
// 更宽，尤其在 N_eff、Y_He、w 等参数上；深蓝色（P-ACT 联
// 合分析）的等高线面积最小、最窄，表明联合两套数据集可以
// 打破参数间的简并，显著收紧对宇宙学参数的限制。图中黑色
// 虚线分别标出了 Σm_ν=0.06、N_eff=3.044、d n_s/d ln k=0、
// Y_He=0.245、w=-1 等基准值供参考。
#figure(scope: "parent", image("imgs/fig2.png"),
  caption: [
    Similar to Fig.~#ref(<fig:lcdm_single_extensions_pactlb>, supplement: none), but highlighting the specific constraints from the ACT DR6 CMB power spectra (light blue) compared to those from the #emph[Planck] legacy CMB power spectra (orange) and those from a joint analysis of the two datasets (P-ACT, navy blue, as defined in~§@subsec:cmb_spec), which breaks degeneracies and tightens the constraints.
  ],
  placement: top,
)
<fig:lcdm_single_extensions_pact>

Across all model extensions studied in this work, we find no preference for departures from the baseline $Lambda"CDM"$~model. Accordingly, we set new limits on key fundamental physics parameters and theoretical models that deviate from the standard scenario, such as models featuring new particles or fields in the pre-recombination universe. Models introduced to increase the CMB-inferred Hubble constant or to decrease the CMB-inferred amplitude of density fluctuations are not favored by our data.

This paper is part of a suite of ACT DR6 papers, with companion papers describing the maps #cite(<dr6maps>, supplement: [N25 hereafter]), and power spectra, likelihood, and baseline $Lambda"CDM"$~parameter constraints #cite(<dr6ps>, supplement: [L25 hereafter]). Other papers report the power spectrum covariance matrix estimation #cite(<atkins-etal:2024>), beam measurements and modeling (Duivenvoorden et al. in prep), and foreground modeling for the power spectrum #cite(<dr6fg>). The broad set of ACT DR6 papers is summarized in N25 and also includes noise simulations #cite(<atkins-etal:2023>), CMB lensing maps and interpretation @Qu_dr6_lensing@Madhavacheril_dr6_lensing@MacCrann_2024, component-separated CMB temperature, CMB E-mode, and Compton $y$-maps @act_ymap:2024, studies of millimeter transients @act_transient:2023, and upcoming cluster and source catalogs.

The remainder of this paper is organized as follows. In~§@sec:data we summarize the main datasets used in our analysis. The theoretical framework and assumptions of our analyses are covered in §@sec:method, along with an overview of the various computational tools employed. §@sec:inflation–§@sec:late-time contain the main set of constraints on numerous extensions of the standard cosmology, covering primordial perturbations and inflation constraints (§@sec:inflation), modifications of physics prior to and during recombination (§@sec:recomb), properties of known and hypothetical fundamental particles (§@sec:astroparticle), and modifications of gravity or other physics impacting cosmic evolution at late times (§@sec:late-time). We discuss model consistency and the resulting impact on cosmological parameter concordance in §@sec:consistency_concordance. In §@sec:conclusions we provide a brief summary, highlighting the consistency of the ACT and #emph[Planck] CMB power spectra with the standard $Lambda"CDM"$~cosmological model. A set of Appendices provides further technical details.

= Summary of data
<sec:data>
== CMB power spectra
<subsec:cmb_spec>
The ACT DR6 power spectra described in L25 are derived from maps made from five years of observations collected during 2017--2022, using detector arrays sensitive to three frequency bands: f090 ($77 - 112$~GHz), f150 ($124 - 172$~GHz), and f220 ($182 - 277$~GHz). The maps are described in N25. The array-band combinations and the multipole ranges that pass a comprehensive battery of null tests form the nominal DR6 dataset, comprising temperature-temperature power spectra (TT), temperature-E mode polarization power spectra (TE), and polarization-polarization power spectra (EE). These power spectra have white noise levels that improve over those of #emph[Planck] by roughly a factor of three in polarization and a factor of two in temperature, with multi-frequency spectra measured over the multipole range $600 < ell < 8500$ and the CMB signal extracted in the range $600 < ell < 6500$. The spectra and their covariance matrix are used as inputs to a multi-frequency likelihood, `MFLike`, and a CMB-only (foreground-marginalized) likelihood, `ACT-lite`, also described in L25.

To leverage the full multipole range accessible with the CMB for cosmological analyses, we combine ACT with satellite data. A minimal addition used in all analyses of the ACT primary CMB (labeled ACT~throughout) is a #emph[Planck] measurement of the optical depth to reionization from the low-multipole EE power spectrum ($ell < 30$) #link("https://web.fe.infn.it/~pagano/low_ell_datasets/sroll2/")[`Sroll2`] likelihood~#cite(<pagano-etal:2020>). In many cases we compress the information of `Sroll2` into a Gaussian prior on the optical depth, $tau = 0.0566 plus.minus 0.0058$; for models that include parameters degenerate with primordial power spectrum parameters, we use the full likelihood shape. As described in L25, we use a baseline CMB combination, labeled P-ACT, which extends the combined dataset further with the inclusion of #emph[Planck] data on large-to-intermediate scales --- at $ell < 1000$ in TT and $ell < 600$ in TE/EE, truncating the multipole range of the `plik_lite` likelihood~#cite(<Planck_2018_likelihood>) and generating a "$""_(upright("cut"))$" likelihood. This combination is built to increase constraining power while minimizing the overlap between the two experiments and allowing us to neglect their covariance. In cases where it is useful to cross-check the results with a #emph[Planck]-independent CMB combination, we replace #emph[Planck] with #emph[WMAP] data from the final 9-year release~#cite(<bennett-etal-2013>)#cite(<WMAP9_Hinshaw>), with this combination labeled W-ACT. In this case, we truncate the low-$ell$ #emph[WMAP] polarization likelihood, replacing it with the ~`Sroll2` likelihood. We use a Python implementation of the #emph[WMAP] likelihood, #link("https://github.com/HTJense/pyWMAP")[`pyWMAP`], which retains only the data in temperature (on all scales) and at $ell > 23$ in polarization.

== CMB lensing
<subsec:cmb_lens>
Incorporating CMB lensing data into our cosmological constraints provides valuable complementary information to that obtained from the primary CMB power spectra. Gravitational lensing of the CMB probes large-scale structure across a wide range of cosmic history, with a broad peak at $z approx 1$--$2$ and a tail extending to high redshift.

The ACT DR6 CMB lensing release provides the most precise detection of CMB lensing to date, with a $43 sigma$~@Qu_dr6_lensing@Madhavacheril_dr6_lensing measurement of the lensing power spectrum. Lensing is robustly measured across multipoles $40 < L < 763$, with extensive tests confirming stability against systematics and foreground contamination~#cite(<MacCrann_2024>). The associated likelihood conservatively uses only this baseline range to minimize potential systematic impacts.

The #emph[Planck] PR4 dataset provides a CMB lensing measurement comparable to ACT DR6 in signal-to-noise, achieving 42$sigma$ using the reprocessed NPIPE maps across multipole range $8 < L < 400$~#cite(<Carron_pr4_lensing>). Combining #emph[Planck] with ACT DR6 yields a state-of-the-art lensing power spectrum, with ACT adding high-precision data on smaller scales, $L > 400$.

Our analysis uses a Gaussian likelihood framework to combine the ACT DR6 and #emph[Planck] PR4 bandpowers, which appropriately accounts for the small correlation between the two datasets~@Qu_dr6_lensing#cite(<Madhavacheril_dr6_lensing>). The effective signal-to-noise ratio of the combined ACT DR6 + #emph[Planck] NPIPE lensing spectrum, accounting for their joint covariance, corresponds to 58$sigma$. Perturbative adjustments are also applied to correct for the weak dependence of the measurements on cosmological assumptions, following methods outlined in #cite(<2016AandA...594A..15P>, form: "prose")#cite(<Madhavacheril_dr6_lensing>).#footnote[Although the ACT DR6 CMB lensing likelihood corrections have not been recomputed based on the improved knowledge of ACT maps and power spectra presented in this new suite of papers, we do not expect this to impact our results. We explicitly verify that even omitting these corrections altogether has negligible impact on our inferred parameter constraints.]

== BAO
<subsec:bao>
BAO data measure the acoustic scale at $tilde.op 150$ Mpc in the clustering of galaxies in the late-time, $z lt.eq 4$, universe. This feature allows one to constrain distance ratios parallel and perpendicular to the line of sight as a function of redshift. The BAO feature along the line-of-sight direction measures $D_H ( z ) / r_d$, the inverse-ratio between the sound horizon at the baryon drag epoch, $r_d$, and $D_H ( z ) equiv c / H ( z )$; when combined with a calibration of $r_d$ (e.g., from CMB data), this allows a measurement of the Hubble parameter at redshift $z$. The BAO feature in the angular correlation function of galaxies at redshift $z$ measures $D_M ( z ) / r_d$, the ratio between the comoving angular diameter distance and $r_d$, which thus allows inference of $D_M ( z )$ when combined with a calibration of $r_d$. These quantities are often combined to report measurements of the angle-averaged distance $D_V ( z ) / r_d$, with $D_V ( z ) = ( z D_M ( z )^2 D_H ( z ) )^(1 / 3)$. This has a strong dependence on the matter density and other parameters affecting the expansion history of the universe~@EISENSTEIN2005360 @2010deot.book..246B#cite(<2013PhR...530...87W>). Because the main signature is generated during a phase of linear evolution of matter density perturbations, BAO measurements have become the most common cosmological dataset used to break geometric degeneracies in CMB analyses.

Previous analyses used a compilation of BAO data at different redshifts from multiple surveys, such as the Baryon Oscillation Spectroscopic Survey (BOSS)~@BOSS-LRG and the 6dF Galaxy Redshift Survey~#cite(<6dF>). Here, we use the recent DESI Year-1 observations of the BAO feature in galaxy, quasar, and Lyman-$alpha$ forest tracers~@DESI-BAO-III@DESI_BAO_Lya@DESI-BAO-VI as our baseline BAO combination.#footnote[The impact of the more recent DESI Year-3 observations is discussed in~Appendix~@app:newDESI_tau.] This DESI dataset spans $0.1 < z < 4.2$ and includes twelve total data points, of which ten are pairs of $D_H ( z ) / r_d$ and $D_M ( z ) / r_d$, and two are combined $D_V ( z ) / r_d$ measurements, one each at the lowest and highest redshifts. To ensure that our results are not solely driven by DESI, and in light of some $2.5 sigma$ deviations between the DESI luminous red galaxy (LRG) data points and previous measurements at the same redshifts, we also consider analyses with DESI replaced by BOSS/eBOSS BAO data, including both BOSS DR12 LRGs~@BOSS-LRG and eBOSS DR16 LRGs~#cite(<eBOSS-LRG>). We primarily perform such analyses for models in which BAO data have a significant impact on the parameter constraints.

== SNIa
<subsec:SNIa>
Type Ia supernovae (SNIa) are powerful probes of cosmological distances in the modern universe (the last ten billion years). Using SNIa anchored to other cosmological distance indicators, supernovae constrain the luminosity distance across a range of redshifts; even in the absence of absolute calibration, SNIa precisely constrain the relative expansion history of the universe at late times. SNIa are thus sensitive probes of the matter density and the equation of state of dark energy, as well as the spatial curvature when analyzed in tandem with the CMB. To maximize redshift coverage and ensure consistency of calibration of the SNIa, surveys from different groups are combined and re-calibrated, and released with a likelihood including systematic errors from fitting a model of supernova brightness, calibration offsets, and telescope systematics~@Union3@Rubin2023_Union3@DES_SN#cite(<Pantheon>). Here we use the latest SNIa compilation from PantheonPlus~#cite(<PantheonPlus>)#cite(<Panthoen-plus-cosmology>), which brings together 18 samples comprising 1550 spectroscopically-confirmed SNIa spanning $0.001 < z < 2.26$. We primarily include PantheonPlus as an additional dataset when exploring models that affect the expansion history of the late-time universe, and do not explore other SNIa compilations.

== Glossary of data combinations and other additional datasets
<sec:glossary>
In this paper, we analyze the CMB primary anisotropy datasets introduced in §@subsec:cmb_spec alone or combined with CMB lensing from §@subsec:cmb_lens, BAO data from §@subsec:bao, and SNIa data from §@subsec:SNIa. We report the resulting constraints with the label conventions for different dataset combinations summarized in Table~#ref(<tab:labels>, supplement: none). We present the constraints obtained with the most constraining data combination as our baseline results: depending on the model, this combination is either P-ACT-LB~or P-ACT-LBS. We discuss and compare these results with those obtained from the primary CMB anisotropies --- this is slightly different from the approach taken by the #emph[Planck] collaboration, which focused primarily on comparisons between a joint CMB primary-anisotropy and lensing result versus results from the CMB combined with large-scale-structure (LSS) probes. We justify our ability to combine these data in~§@subsec:consistency, showing that the best-fit $Lambda"CDM"$~model to P-ACT~CMB data gives excellent predictions for the low-redshift measurements, and furthermore that the $Lambda"CDM"$~model gives an excellent joint fit to all data.

#figure(
  align(center)[#table(
    columns: 2,
    align: (center,left,),
    table.header([Planck], [#emph[Planck]$""^(upright("TT") / upright("TE") / upright("EE"))$ + Sroll2],),
    table.hline(),
    [ACT], [ACT$""^(upright("TT") / upright("TE") / upright("EE"))$ + Sroll2],
    [P-ACT], [ACT$""^(upright("TT") / upright("TE") / upright("EE"))$ + $""_(upright("cut"))^(upright("TT") / upright("TE") / upright("EE"))$ + Sroll2],
    [W-ACT], [ACT$""^(upright("TT") / upright("TE") / upright("EE"))$ + WMAP$""^(upright("TT") / upright("TE") / upright("EE"))$ + Sroll2],
    table.cell(align: left)[followed by], [],
    [-LB], [when adding CMB lensing and BAO],
    [-LS], [when adding CMB lensing and SNIa],
    [-LBS], [when adding CMB lensing, BAO, and SNIa],
  )]
  , caption: [Dictionary listing the main dataset combinations analyzed in this work. Here, CMB lensing always refers to ACT DR6+~NPIPE lensing; BAO refers to the DESI Year-1 release unless explicitly stated otherwise (e.g., "B$""_(sans("BOSS"))$" referring to BOSS BAO); and SNIa refers to PantheonPlus. All Planck results have been re-run to include an updated version of the `Sroll2` likelihood compared to @Planck_2018_params.]
  , kind: table
  ) <tab:labels>
Depending on the physical signature probed by each model, additional astrophysical and cosmological measurements (beyond CMB lensing, BAO, and SNIa data) can help to further tighten the parameter constraints. These are folded into specific analyses as described in each section of interest below.

As shown in L25, our baseline $Lambda"CDM"$~results confirm a discrepancy between the value of the Hubble constant, $H_0$, derived from the primary CMB and some measurements of this quantity from the local universe --- see @Freedman_review#cite(<2024ARAandA..62..287V>) for relevant reviews. Specifically, the constraint on the Hubble constant using distance ladder methods with Cepheid-calibrated SNIa, from the SH0ES collaboration, $H_0 = 73.17 plus.minus 0.86$~km/s/Mpc~@Riess_SHOES@Breuval:2024lsv, is the most precise local measurement and also the most discrepant with the CMB estimate (L25). The latest value obtained by the CCHP program using tip of the red giant branch stars (TRGB) to calibrate SNIa distances is $H_0 = 70.39 plus.minus 1.94$~km/s/Mpc~@H0Freedman@Freedman_CCHP, which is consistent with the CMB value (and with the SH0ES value), but less precise than the SH0ES constraint. Further recent results from direct measurements can be found in #cite(<2024ARAandA..62..287V>). As a baseline choice, we do not combine our data with local measurements of $H_0$. However, we discuss in detail cases where a given model can accommodate a larger value of the Hubble constant compared to $Lambda"CDM"$~or where there are important parameter degeneracies that impact $H_0$.

Similarly, as shown in L25, our baseline $Lambda"CDM"$~results confirm the value of the fluctuation-amplitude parameter $S_8 equiv sigma_8 sqrt(Omega_m / 0.3)$ (obtained from a combination of the amplitude of matter fluctuations on scales of $8 med h^(- 1)$~Mpc, $sigma_8$, and the total matter density, $Omega_m$) found in previous #emph[Planck] analyses, which lies $2$--$3 sigma$ higher than values found in some weak lensing and galaxy clustering studies (see, e.g.,~#cite(<Madhavacheril_dr6_lensing>, style: "aas_noparen.csl") for a collection of recent $S_8$ results from low-redshift probes). We emphasize that ACT and #emph[Planck] CMB lensing data show no evidence of a low $S_8$ value~@Madhavacheril_dr6_lensing#cite(<Planck_2018_lensing>).#footnote[The results from the KiDS Legacy data~@2025arXiv250319442S@2025arXiv250319441W, which appeared after the first version of this paper was submitted, show full consistency between the $S_8$ value inferred from cosmic shear and that measured from the CMB.] As with $H_0$, as a baseline choice, we do not combine our data with low-redshift measurements of $S_8$. This choice is also motivated by the fact that some extended models alter the shape and/or redshift evolution of the matter power spectrum, and thus a dedicated reanalysis of the relevant data within the context of each model would be necessary in order to derive valid constraints. Nevertheless, for some models it is appropriate to consider external priors on $S_8$ from low-redshift data; where this is useful and allowed by the parameter posteriors, we include in our analysis a prior from the joint analysis of DES and KIDS weak lensing data, $S_8 = 0.797 plus.minus 0.0155$~#cite(<DES_KIDS_shear_2023>).#footnote[This is a symmetrized Gaussian approximation of the fixed-neutrino-mass result from Table 4 of~#cite(<DES_KIDS_shear_2023>, form: "prose").]

= Analysis methodology
<sec:method>
We obtain cosmological parameter constraints using the ACT DR6 multi-frequency or CMB-only likelihood#footnote[As shown in L25, these two likelihoods yield cosmological parameters that agree within $0.1 sigma$.] coupled to #link("https://cobaya.readthedocs.io/en/latest/")[`Cobaya`]~@Cobaya, which itself is coupled to the Einstein-Boltzmann codes #link("https://camb.readthedocs.io/en/latest/")[`camb`]~@Lewis_camb or #link("https://lesgourg.github.io/class_public/class.html")[`class`]~@Lesgourgues_class@CLASS_2011, or to #link("https://alessiospuriomancini.github.io/cosmopower/")[`CosmoPower`] emulators of these codes~@Spurio_Mancini_cosmopower@Bolliet_emulators@Jense_emulators@Qu:2024lpx, to compute the lensed theoretical CMB power spectra at high precision, as described in Appendix~@app:theory. All codes exploring extended models requiring modifications to `camb` and `class` are benchmarked against the respective `camb` and `class` baseline $Lambda"CDM"$~results. In Table~#ref(<tab:models>, supplement: none) in Appendix~@app:theory, we provide a summary of the theory code and likelihood that are used for each model.

Unless explicitly mentioned otherwise, we compute all theory predictions using #link("https://cosmo.nyu.edu/yacine/hyrec/hyrec.html")[`HyRec`]~@Hyrec or #link("https://www.jb.man.ac.uk/~jchluba/Science/CosmoRec/Welcome.html")[`CosmoRec`]~@Cosmorec (in `class` and `camb`, respectively), rather than `Recfast`~@Recfast, to obtain higher precision for recombination physics.#footnote[The Recfast "fudge parameters" were tuned to provide sufficient accuracy for #emph[Planck], but are no longer sufficient for ACT DR6 sensitivity. We test the latest versions of `HyRec` and `CosmoRec` to ensure that they provide accurate recombination calculations when we compute the DR6 likelihood evaluation across the full parameter space, while also cross-checking the two codes against each other. We use `CosmoRec` in `camb` and `HyRec` in `class` because the newest `CosmoRec` version is not yet available within `class`.] As a baseline choice, we compute Big Bang Nucleosynthesis (BBN) predictions using calculations of the primordial helium abundance from #link("https://www2.iap.fr/users/pitrou/primat.htm")[`PRIMAT`]~@2018PhR...754....1P, but in~§@sec:bbn we explore other options and discuss in detail the impact of different helium and deuterium abundance calculations.#footnote[Differences in the exact helium abundance predicted by the most recent BBN codes have a negligible impact on the CMB primary anisotropy spectra and therefore on cosmological parameters inferred from them. We also note that `PRIMAT`-based BBN data were not present in `class` when our analyses were performed (although they now are), so we manually imported a `PRIMAT`-based table from `camb` to use in our `class` calculations. We take care to account for a small difference in the $N_("eff")$ value assumed in the `PRIMAT` BBN table (3.044) and that assumed in the `class` BBN module (3.046).] We also use the latest version of `HMcode`~@Mead2020 (rather than `Halofit`, #cite(<Halofit>, style: "aas_noparen.csl")#cite(<Takahashi2012>, style: "aas_noparen.csl")) for modeling non-linear corrections to the matter power spectrum, unless explicitly stated otherwise. At ACT DR6 precision, the impact of non-linear corrections to CMB lensing are non-negligible even in the primary CMB power spectra~#cite(<McCarthy_2022>). We adopt the dark-matter-only `HMcode` model for the non-linear matter power spectrum, with no baryonic feedback corrections.#footnote[At the time this work was performed, the latest `HMcode` model was not yet implemented in the main branch of `class`; we thank J.~Lesgourgues for providing an updated version with this model implemented (developed from `class v3.2.2`). As of publication, the latest `HMcode` model is now available in the main public branch of `class`.] We note that `HMCode` is not guaranteed to give accurate results when applied to models that alter late-time growth (e.g., models with interactions between dark matter and dark energy in the late universe, as in §@sec:dedm); in such cases, we use custom alternative models or restrict to linear scales. The vast majority of the new-physics models studied in this work alter physics in the early universe, and hence their impact on structure formation is generally captured in a change to the linear matter power spectrum at the onset of structure formation, which in most cases remains close to that in $Lambda"CDM"$. These modeling choices are validated in Appendix~@app:theory.

Our parameter set includes the six basic $Lambda$CDM cosmological parameters: the physical baryon and cold dark matter densities, $Omega_b h^2$ and $Omega_c h^2$, the optical depth due to reionization, $tau$, the amplitude and spectral index of the power spectrum of primordial adiabatic scalar perturbations, $A_s$ and $n_s$, both defined at a pivot scale $k_(*) = 0.05 med upright("Mpc")^(- 1)$,#footnote[This pivot scale is the default choice in many CMB analyses, used by #emph[Planck], ACT, SPT, and other experiments. In some cases, following e.g., #emph[WMAP], #emph[Planck], and BICEP, results are also shown for $k_(*) = 0.002$~Mpc$""^(- 1)$ --- when for example it is important to look at larger scales. This is explicitly mentioned in the relevant sections.] and a parameter that sets the absolute distance scale: (i) in `camb`, an approximation to the angular scale of the acoustic horizon at decoupling, $theta_("MC")$; (ii) in `class`, the angular size of the sound horizon at decoupling, $theta_s$; or (iii) the Hubble constant, $H_0$ in km/s/Mpc (note that the exact definition of the angular scale varies between `camb` and `class` --- see, e.g., the discussion in~#cite(<Bolliet_emulators>, style: "aas_noparen.csl")).#footnote[$H_0$ is expressed throughout this paper in km/s/Mpc; units are generally omitted for brevity.] We adopt broad, flat, uninformative priors on all $Lambda"CDM"$~parameters in every analysis in this paper (except when imposing an `Sroll2`-informed prior on $tau$ in some ACT-only fits). Priors on extended-model parameters are described in each section, and are generally chosen to be uninformative as well. From the sampled parameters, we obtain several derived parameters, including the rms amplitude of linear density fluctuations at $z = 0$ on $8 med h^(- 1) upright("Mpc")$ scales, $sigma_8$, the matter density fraction $Omega_m$, and $S_8 equiv sigma_8 sqrt(Omega_m / 0.3)$. For models in which neutrino physics is not varied, we fix neutrino properties to comprise one massive and two massless particles, with total mass $sum m_nu = 0.06$~eV and effective number of neutrino species $N_("eff")=3.044$. Following #emph[Planck] and the ACT DR6 CMB lensing analyses, we assume three massive eigenstates (zero massless) when analyzing models where the sum of the neutrino masses is a free parameter. Additional, model-specific parameters are added to the base $Lambda"CDM"$~set as explained in each subsection below.

Extra parameters are included in our theoretical model for astrophysical foregrounds, passband uncertainties, calibration, and polarization efficiency factors. These parameters are varied as described in L25 when using the `MFLike` likelihood, or reduced to a minimum set of two varying parameters for overall calibration and polarization efficiency when using the `ACT-lite` likelihood (also described in L25).

MCMC chains are run with theory predictions computed up to $ell_(upright("max")) = 9000$ and with the Gelman-Rubin convergence parameter, $R - 1$, reaching values $tilde.op O ( 10^(- 2) )$ and in nearly all cases smaller than 0.01. Parameter posteriors and statistical results are obtained with #link("https://getdist.readthedocs.io/en/latest/")[`GetDist`]~#cite(<Getdist>). Marginalized confidence intervals (for two-tailed limits) are calculated with the standard credible-interval approach, i.e., the interval between the two points with highest equal marginalized probability density.

Model comparisons are performed with respect to the benchmark $Lambda"CDM"$~results presented in L25. We determine the #emph[maximum a posteriori] (MAP) point in parameter space for each model (note that the ACT DR6 likelihood includes informative priors on some nuisance parameters, and thus the MAP is used, rather than the maximum-likelihood point). The MAP for each model is then compared to the best-fit $Lambda$CDM result for the relevant dataset combination. We take care to discard contributions to the effective MAP $chi^2$ value arising from uninformative priors --- the informative priors placed on nuisance parameters are always identical, and, as noted above, their contributions to the overall $chi^2$ are accounted for in the best-fit model determination. For reference, the best-fit P-ACT~$Lambda$CDM model yields MAP $chi_(Lambda C D M , mono("MFLike"))^2 = 2180.5$ and $chi_(Lambda C D M , mono("ACT-lite"))^2 = 781.9$ for the full P-ACT~dataset (see also L25).

Constraints on parameters of the baseline $Lambda"CDM"$~model are presented in L25. In the following, we report constraints on a large suite of extended cosmological models, organized into four topical sections. In Fig.~#ref(<fig:spec>, supplement: none), we illustrate with a few examples how ACT data push constraints on these models beyond what has been achieved by #emph[Planck]. Some models exhibit features on small scales ($ell gt.eq 2000$) not measured by #emph[Planck]. In other cases, the integrated sensitivity over an extended range of multipoles on small scales, and the sensitive ACT DR6 measurements of TE and EE at intermediate scales, rule out models at high significance that would be allowed within the #emph[Planck] bounds.

// [figvision-cn] imgs/fig3.png
// 这是一张由三个纵向排列的子图组成的科学曲线图，展示不同
// 宇宙学模型相对于基准模型的CMB功率谱理论差异。三个子图
// 共享横轴，横轴标签为 ℓ（多极矩，无量纲），范围从约 200
// 到 4500，主刻度间隔为 500。纵轴均表示相对于基准 ACT 最
// 佳拟合模型的差值，单位为 μK²，横轴和纵轴均为线性刻度。
// 图例位于顶部子图内：蓝线代表自由流黑暗辐射（
// Free-Streaming Dark Radiation），金线代表轴子暗物质（
// Axion Dark Matter），红线代表修改的复合历史（Modified
// Recombination History），浅灰色阴影代表 ACT DR6 CMB 误
// 差（ACT DR6 CMB Errors），黑色虚线阶梯线代表 Planck
// CMB 误差（Planck CMB Errors）。零差值由水平黑色实线标
// 出。 子图 a（顶部）：纵轴标签为 ΔD_ℓ^{TT} [μK²]，范围
// 从 -10 到 60，主刻度间隔为 10。红线在 ℓ<500 处从约 35
// μK² 急剧下降，在 ℓ≈400 处穿过零线，随后在零线附近小幅
// 振荡并趋于平缓。金线从约 20 μK² 开始下降，在 ℓ≈500 处
// 穿过零线，在 ℓ≈800 附近出现约 17 μK² 的峰值，随后在零
// 线附近振荡并衰减。蓝线从约 15 μK² 开始，在 ℓ≈600 处降
// 至约 -6 μK² 的谷值，随后在零线附近小幅振荡。Planck 误
// 差虚线在低 ℓ 处约为 ±20 μK²，随 ℓ 增加逐渐收窄，在 ℓ≈
// 2500 处约为 ±5 μK² 后不再向高 ℓ 延伸。ACT 误差灰色阴影
// 在最低 ℓ 处约为 ±58 μK²，随 ℓ 增加迅速变窄，在 ℓ>2500
// 后保持在约 ±2 μK² 的窄带内。 子图 b（中部）：纵轴标签
// 为 ΔD_ℓ^{TE} [μK²]，范围从 -3 到 3，主刻度间隔为 1。红
// 线从约 1.8 μK² 开始，在 ℓ≈500 处降至约 -1 μK²，随后在
// ℓ≈1200 处升至约 1 μK² 的峰值，在 ℓ≈2000 附近出现约 1.2
// μK² 的次峰，之后缓慢衰减至零。金线从约 1 μK² 开始，在
// ℓ≈600 处降至约 -1.8 μK²，随后在零线附近振荡并衰减。蓝
// 线从约 1 μK² 开始，在 ℓ≈500 处降至约 -1.6 μK²，随后在
// 零线附近小幅振荡。Planck 误差虚线在低 ℓ 处约为 ±2.4 μK
// ²，在 ℓ≈1700 附近扩大至约 ±3.5 μK² 后不再向高 ℓ 延伸。
// ACT 误差灰色阴影在低 ℓ 处约为 ±2.2 μK²，随 ℓ 增加逐渐
// 收窄，在高 ℓ 处约为 ±0.4 μK²。 子图 c（底部）：纵轴标
// 签为 ΔD_ℓ^{EE} [μK²]，范围从 -1.0 到 1.0，主刻度间隔为
// 0.5。红线从约 0.2 μK² 开始，在 ℓ≈400 处升至约 0.7 μK²，
// 在 ℓ≈700 处降至约 -0.1 μK²，在 ℓ≈900 处升至约 0.8 μK²
// 的峰值，随后在零线附近振荡并衰减。金线从约 0.4 μK² 开
// 始，在 ℓ≈600 处降至约 -0.2 μK²，在 ℓ≈800 处升至约 0.7
// μK²，随后振荡衰减。蓝线从约 0.3 μK² 开始，在 ℓ≈600 处
// 降至约 -0.2 μK²，在 ℓ≈800 处升至约 0.5 μK²，随后振荡衰
// 减。Planck 误差虚线在低 ℓ 处约为 ±0.6 μK²，在 ℓ≈900 附
// 近扩大至约 ±1.4 μK² 后不再向高 ℓ 延伸。ACT 误差灰色阴
// 影在低 ℓ 处约为 ±0.7 μK²，随 ℓ 增加逐渐变宽，在 ℓ=4500
// 处约为 ±0.6 μK²。 总体趋势：三种非标准宇宙学模型在低至
// 中等 ℓ（约 200 至 2500）区间内产生相对于基准模型的显著
// 理论差异，这些差异的幅度与 Planck 误差和 ACT 误差在相
// 应尺度上的大小相当或更大，表明 ACT 数据有潜力探测这些
// 模型。在高 ℓ（>2500）区间，理论差异趋近于零，而 ACT 误
// 差仍保持较小，进一步支持高显著性探测的可能性。
#figure(image("imgs/fig3.png"),
  caption: [
    Models of free-streaming dark radiation (blue), axion dark matter (gold), and modified recombination history (red) that are allowed by #emph[Planck] data show differences in TT, TE, and EE compared to the baseline ACT $Lambda"CDM"$~best-fit model (black line, L25), which are detectable by the new ACT data at high significance. We show theory differences for non-standard cosmologies consistent with existing #emph[Planck] constraints relative to ACT's $Lambda"CDM"$~model, and compared to the sensitivity of ACT and #emph[Planck] through their CMB-only bandpower errors. For free-streaming dark radiation we consider a model allowing for an effective number of relativistic species $N_("eff")=3.4$ (see~§@sec:neutrinos);$""^a$ for axion dark matter we take a model with 5% of the total dark matter density in the form of an axion of mass $m_(upright("ax")) = 10^(- 26) thin upright("eV")$ (see~§@sec:axions); for modified recombination history we show a model with a non-standard ionization fraction between redshift $z = 1000$ and $1500$ (see~§@sec:modrec).
  ],
  placement: top,
)
<fig:spec>

We also discuss how ACT DR6 improves on previous ACT releases, in particular for models that showed a hint of a preference over $Lambda"CDM"$~in the previous ACT DR4 dataset~@Hill_ACT_EDE#cite(<Kreisch_ACT_SIN>). Additional comparisons with the DR4 results are shown and discussed in Appendix~@app:dr4dr6comp and Appendix~@app:ede_full_constraints.

= Primordial perturbations and inflation
<sec:inflation>
== Scale invariance of scalar perturbations
<sec:running>
One key prediction of the simplest single-field slow-roll inflation models is an almost scale-invariant spectrum of primordial scalar perturbations --- the scalar spectral index $n_s$ being close to, but crucially different from (and usually less than) unity (see, e.g.,~#cite(<Mukhanov:1981xt>, style: "aas_noparen.csl") #cite(<1992PhR...215..203M>, style: "aas_noparen.csl")#cite(<2000cils.book.....L>, style: "aas_noparen.csl")#cite(<Peiris_2003>, style: "aas_noparen.csl")#cite(<Mukhanov_2007>, style: "aas_noparen.csl")). Analyses of #emph[Planck] CMB data have confirmed this prediction to high precision and shown its robustness across models~@Planck_2018_params#cite(<Planck2018_inflation>). The new constraints on $n_s$ from ACT DR6 are presented and discussed in L25. Here, to test the inflation slow-roll approximation further, we take the common approach of expanding the power-law form of the primordial power spectrum of scalar curvature perturbations around a pivot scale $k_(*)$~@1995PhRvD..52.1739K $ cal(P)_(cal(R)) ( k ) = A_s #scale(x: 180%, y: 180%)[(] k / k_(*) #scale(x: 180%, y: 180%)[)]^(n_s - 1 med + med ( 1 / 2 ) med ( upright("d") n_s / upright("d") ln k ) med ln ( k / k_(*) )) thin , $<eq:pks> and constrain the running of the spectral index, $upright("d") n_s / upright("d") ln k$ --- i.e., the variation of $n_s$ as function of scale $k$, evaluated at $k_(*) = 0.05 med upright("Mpc")^(- 1)$. This is a single-parameter extension to $Lambda"CDM"$, varied in the range $[ - 0.2 , 0.2 ]$.

This parameter was found to be consistent with zero by #emph[Planck], with $upright("d") n_s / upright("d") ln k = - 0.0041 plus.minus 0.0067$ from combining #emph[Planck] CMB, lensing, and BAO data~@Planck_2018_params#cite(<Planck2018_inflation>). With the addition of the new ACT DR6 spectra we confirm a vanishing running of the spectral index and tighten the error bar, finding $ upright("d") n_s / upright("d") ln k & = & 0.0060 plus.minus 0.0055 quad ( 68 % , sans("P-ACT") ) ,\
 & = & 0.0062 plus.minus 0.0052 quad ( 68 % , sans("P-ACT-LB") ) . $ Lacking the measurement of the first acoustic peak, and with both parameters acting to balance the tilt of the spectrum at small scales, ACT alone provides a looser bound on the combined $upright("d") n_s / upright("d") ln k - n_s$ space compared to #emph[Planck], as shown in Fig.~#ref(<fig:lcdm_single_extensions_pact>, supplement: none), giving $upright("d") n_s / upright("d") ln k = 0.034 plus.minus 0.022 med ( 68 % , sans("ACT") )$. With the P-ACT~combination, $n_s$ is firmly constrained and the error bar on the running is tightened by $approx 20 %$. Adding additional datasets has a marginal impact here, with the constraints stabilizing around a vanishing running. Figure~#ref(<fig:nrun>, supplement: none) shows the combined measurement of $upright("d") n_s / upright("d") ln k - n_s$ and projections to 's large scales, at $k_(*) = 0.002 med M p c^(- 1)$. In Fig.~#ref(<fig:pknrun>, supplement: none) we report the same measurements in terms of the scalar primordial power spectrum using ACT, #emph[Planck], and P-ACT-LB. We infer $cal(P)_(cal(R)) ( k )$ (using Eq.~(#ref(<eq:pks>, supplement: none))) by post-processing the chains using the amplitude, spectral index, and running of the spectral index of our runs, and computing the 95% two-tailed confidence interval. All three datasets measure a similar amplitude and spectral index at the pivot scale, but the constraints from #emph[Planck] prefer a slight negative running of the spectral index (due to needing to reconcile constraints from large and small scales --- see the discussion in #cite(<Planck_2018_params>, style: "aas_noparen.csl")), indicated by the concave shape of the mean of the constraints, while ACT~and the combination P-ACT-LB~mildly prefer a slight positive running of the spectral index, changing the overall shape of $cal(P)_(cal(R)) ( k )$ to convex.

// [figvision-cn] imgs/fig4.png
// 这是一张三角图（corner plot），由六个子图组成，排列成
// 三行三列的矩阵，仅显示下三角和对角线部分。该图展示了三
// 个数据集对原初标量扰动尺度不变性参数的限制，涉及三个参
// 数：n_s、n_{s,0.002} 和 dn_s/dlnk。右上角有图例：橙色
// 代表 Planck，深蓝色代表 P-ACT，紫色代表 P-ACT-LB。图中
// 所有等高线区域均包含两个置信水平（内层深色和外层浅色），
// 对角线子图为一维边缘化后验概率密度曲线。 第一行第一列
// （左上角）：一维概率密度曲线图。横轴为 n_s，范围约
// 0.95 到 0.99。纵轴未标注，为概率密度。橙色曲线峰值在
// 0.964 左右，深蓝色曲线峰值在 0.970 左右，紫色曲线峰值
// 在 0.971 左右。深蓝色和紫色曲线几乎重合，且比橙色曲线
// 更窄。 第二行第一列（左中）：二维等高线图。横轴为 n_s，
// 范围约 0.95 到 0.99。纵轴为 n_{s,0.002}，范围约 0.93
// 到 1.01。橙色等高线中心在 (0.964, 0.970) 附近，深蓝色
// 等高线中心在 (0.970, 0.965) 附近，紫色等高线中心在 (
// 0.971, 0.966) 附近。深蓝色和紫色等高线重叠较多，且与橙
// 色等高线有明显偏移。 第二行第二列（中心）：一维概率密
// 度曲线图。横轴为 n_{s,0.002}，范围约 0.94 到 1.01。纵
// 轴未标注。橙色曲线峰值在 0.975 左右，深蓝色曲线峰值在
// 0.966 左右，紫色曲线峰值在 0.967 左右。深蓝色和紫色曲
// 线几乎重合。 第三行第一列（左下）：二维等高线图。横轴
// 为 n_s，范围约 0.95 到 0.99。纵轴为 dn_s/dlnk，范围约
// -0.03 到 0.03。图中有一条水平虚线在 dn_s/dlnk = 0 处。
// 橙色等高线中心在 (0.964, -0.005) 附近，呈倾斜椭圆。深
// 蓝色等高线中心在 (0.970, 0.005) 附近，紫色等高线中心在
// (0.971, 0.006) 附近。深蓝色和紫色等高线重叠，且与橙色
// 等高线在纵轴上明显分离。 第三行第二列（中下）：二维等
// 高线图。横轴为 n_{s,0.002}，范围约 0.94 到 1.01。纵轴
// 为 dn_s/dlnk，范围约 -0.03 到 0.03。水平虚线在 dn_s/
// dlnk = 0 处。橙色等高线呈倾斜椭圆，中心在 (0.975,
// -0.005) 附近。深蓝色等高线中心在 (0.966, 0.005) 附近，
// 紫色等高线中心在 (0.967, 0.006) 附近。深蓝色和紫色等高
// 线重叠，且与橙色等高线在横轴和纵轴上均有偏移。 第三行
// 第三列（右下）：一维概率密度曲线图。横轴为 dn_s/dlnk，
// 范围约 -0.03 到 0.03。纵轴未标注。图中有一条垂直虚线在
// dn_s/dlnk = 0 处。橙色曲线峰值在 -0.005 左右，深蓝色曲
// 线峰值在 0.005 左右，紫色曲线峰值在 0.006 左右。深蓝色
// 和紫色曲线几乎重合，且与橙色曲线有明显偏移。 总体趋势：
// 新的 ACT CMB 数据（P-ACT，深蓝色）将仅使用 Planck 数据
// （橙色）的限制推向更高的 n_s 和 n_{s,0.002} 值，以及更
// 高的 dn_s/dlnk 值。加入透镜数据（P-ACT-LB，紫色）后，
// 限制略有进一步移动，但深蓝色和紫色结果非常接近。所有参
// 数在三个数据集下的限制均显示出一致的偏移方向。
#figure(image("imgs/fig4.png"),
  caption: [
    Constraints on parameters quantifying the scale invariance of primordial scalar perturbations: the scalar spectral index $n_s$ and its running $upright("d") n_s / upright("d") ln k$ at $k_(*) = 0.05 thin upright("Mpc")^(- 1)$. Projections at larger scales (to facilitate comparisons with the #emph[Planck] results) are shown with $n_s$ at $k_(*) = 0.002 thin upright("Mpc")^(- 1)$ computed as a derived parameter. The new ACT CMB spectra move the -alone constraint (orange) towards higher values of both $n_s$ and $upright("d") n_s / upright("d") ln k$, as shown by P-ACT~(navy). The addition of lensing and BAO data shown in P-ACT-LB~(purple) only shifts $n_s$ slightly, leaving the running constraint unchanged. In all cases, we find consistency with the $Lambda"CDM"$~expectation (marked with gray dashed lines).
  ],
  placement: top,
)
<fig:nrun>

// [figvision-cn] imgs/fig5.png
// 这是一张单一子图的科学曲线图，没有分为 a、b、c 等多个
// 子图。图表展示了不同数据集对原初标量曲率扰动功率谱的约
// 束。 图表类型为曲线图。图中包含两个横坐标轴：底部横坐
// 标轴标注为“k [Mpc⁻¹]”，采用对数刻度，范围约为 2×10⁻⁴
// 到 3×10⁻¹；顶部横坐标轴标注为“ℓ”，同样采用对数刻度，范
// 围从 10¹ 到 10³。纵坐标轴标注为“𝒫ℛ(k)”，采用线性刻度，
// 范围从 1.9 到 3.3，在纵轴顶端左侧标注有“1e−9”，表示纵
// 轴数值需乘以 10⁻⁹。图中没有显示网格线。 图例位于右上角，
// 包含五项：黑色虚线代表“P-ACT-LB ΛCDM”；黑色实线代表“Λ
// CDM + dnₛ/dlnk”；蓝色实线代表“ACT”；橙色实线代表“
// Planck”；紫色实线代表“P-ACT-LB”。 图中所有曲线均表现为
// 随 k 增大而下降的趋势，但各曲线的具体形态和边界不同。
// 黑色虚线（P-ACT-LB ΛCDM）是一条平缓下降的直线，从 k≈2×
// 10⁻⁴ 处的 𝒫ℛ(k)≈2.47 降至 k≈3×10⁻¹ 处的 𝒫ℛ(k)≈2.03。紧
// 挨着这条虚线上下各有一条黑色实线，它们分别位于虚线略高
// 和略低的位置，与虚线平行，从 𝒫ℛ(k)≈2.48 和 2.46 下降至
// 2.04 和 2.02。这两条黑色实线之间形成了一个很窄的带状区
// 域。 蓝色实线（ACT）和橙色实线（Planck）各包含上下两条
// 边界线。蓝色实线从 k≈2×10⁻⁴ 处的 𝒫ℛ(k)≈2.43 和 2.02 开
// 始下降，在 k≈10⁻² 处分别降至约 2.18 和 2.20，随后继续
// 下降至 k≈3×10⁻¹ 处的约 1.95 和 1.95。橙色实线从 k≈2×10
// ⁻⁴ 处的 𝒫ℛ(k)≈2.44 和 1.97 开始，下降至 k≈3×10⁻¹ 处的
// 约 1.96 和 1.96。此外，这些实线还向外延伸出较浅颜色的
// 虚线：蓝色虚线从 k≈10⁻³ 处向上延伸至 𝒫ℛ(k)≈3.28；橙色
// 虚线从 k≈2×10⁻⁴ 处向上延伸至 𝒫ℛ(k)≈2.98；还有一条浅蓝
// 色虚线从 k≈2×10⁻⁴ 处向右侧延伸。 紫色实线（P-ACT-LB）
// 也包含上下两条边界线。上方紫色实线从 k≈2×10⁻⁴ 处的 𝒫ℛ(
// k)≈3.25 开始急剧下降，在 k≈10⁻² 处降至约 2.30，然后继
// 续下降至 k≈3×10⁻¹ 处的约 2.05。下方紫色实线从 k≈2×10⁻⁴
// 处的 𝒫ℛ(k)≈2.32 开始平缓下降，到 k≈10⁻¹ 处降至约 2.10。
// 在上下两条紫色实线之间，有一大片淡紫色阴影区域，该区域
// 从 k≈2×10⁻⁴ 处的 2.32 至 3.25 之间开始，随着 k 增大逐
// 渐收窄，到 k≈3×10⁻¹ 处缩小至 2.05 至 2.10 之间。 图表
// 传达的趋势是：不同数据集对原初功率谱的约束范围不同，
// P-ACT-LB 的约束范围（紫色阴影区域）在低 k 处比其他数据
// 集更宽，且所有模型的功率谱均随 k 增大而减小。
#figure(image("imgs/fig5.png"),
  caption: [
    Inferred constraints on the primordial power spectrum of scalar curvature perturbations from ACT~(blue), ~(orange), and P-ACT-LB~(purple), assuming a primordial power spectrum parameterized by an amplitude $A_s$, spectral index $n_s$, and running of the spectral index $upright("d") n_s / upright("d") ln k$, each defined at a pivot scale $k_(*) = 0.05 thin upright("Mpc")^(- 1)$. The constraints shown are the 95% CL allowed by the parametric constraints in Fig.~#ref(<fig:nrun>, supplement: none), with the thick line being the mean and the thin lines the 95% limits. Each data combination is only plotted along the range of scales probed by the experiment, i.e., #emph[Planck] is shown for $2 lt.eq ell lt.eq 2508$, and ACT~is shown with solid blue lines in the range $600 lt.eq ell lt.eq 6500$ probed directly by DR6 and with dashed blue lines extrapolating this down to $ell = 2 - 32$ probed by the inclusion of the Sroll2 data. The results are consistent with a vanishing running, as shown by the P-ACT-LB~$Lambda"CDM"$~best-fit (long-dashed black line).
  ],
  placement: top,
)
<fig:pknrun>

Our constraints on $upright("d") n_s / upright("d") ln k$ disfavor the moderate evidence for negative running of the spectral index seen in combined fits to Lyman-$alpha$ forest and #emph[Planck] data, $upright("d") n_s / upright("d") ln k = - 0.010 plus.minus 0.004$~#cite(<eBOSS_Lya_2020>). From CMB data alone (P-ACT), we exclude $upright("d") n_s / upright("d") ln k = - 0.010$ at over $3 sigma$ significance.

== Primordial power spectrum
<sec:pk>
In order to explore a broader range of deviations from a simple power-law primordial adiabatic power spectrum than those captured solely by the running of the scalar spectral index, we consider a more model-independent approach.

We reconstruct the primordial power spectrum of the scalar perturbations for wavenumber bins centered at $k = 10^(- 4) , 10^(- 3.5) , 10^(- 3) , 10^(- 2.5)$ and then 26 equally-spaced logarithmic bins from $0.011 lt.eq k med / M p c^(- 1) lt.eq 0.43$, where $k_(i + 1) tilde.eq 1.16 k_i$ @2003MNRAS.342L..72B @2011JCAP...08..031G@2012ApJ...749...90H @2013PhRvD..87h3526A@2014JCAP...01..025H @2014PhRvD..89j3502D@2016PhRvD..93b3504M @2016JCAP...09..009H@2017PhRvD..96h3526O@Planck2018_inflation#cite(<2025arXiv250310609R>). Given the degeneracy between the primordial power and the optical depth (often described in terms of the $A_s - tau$ degeneracy), we sample the value of $e^(- 2 tau) P_(cal(R)) ( k_i )$ for each $i^(upright("th"))$ bin. We use the cubic spline interpolation method implemented within `camb` to build the initial power spectrum from our binned values. For $k$ values below our minimum-assumed wavenumber $k_(upright("min"))$, we set the amplitude of the primordial power spectrum to $P_(cal(R)) ( k lt.eq k_(upright("min")) ) = P_(cal(R)) ( k_(upright("min")) )$. This approach removes the scalar spectral amplitude $A_s$ and the scalar index $n_s$ as sampled parameters, but adds the amplitudes within the 30 different bins as described above, leading to 28 additional parameters/degrees of freedom in this model as compared to $Lambda"CDM"$. The prior ranges that we adopt for each $k$ bin are given in Table~#ref(<table:binned_priors>, supplement: none) in Appendix~@app:pkcompilation, and we use the `ACT-lite` likelihood to sample the extended parameter space.

// [figvision-cn] imgs/fig6.png
// 这是一张包含上下两个面板的科学数据图，总标题为“不同数
// 据集下无量纲原初曲率功率谱的分箱重建及 68% 置信区间误
// 差”。整图底部横坐标表示波数 k，单位为 Mpc 的负一次方；
// 顶部横坐标表示多极矩 ℓ，为线性刻度，范围 2 到 4000。纵
// 坐标表示无量纲功率谱量 10^9 e^{-2τ} P_R(k)，采用线性刻
// 度。 图(a)为上方主面板，是包含误差棒的散点图与理论曲线。
// 纵轴范围 1 到 7。主要内容为多组数据点与一条黑色实曲线，
// 黑色曲线图例标注为“P-ACT-LB ΛCDM”。浅橙色矩形阴影区域
// 图例标注为“Planck”，用于表示 Planck 数据的约束范围，覆
// 盖约 k=10^-4 至 2×10^-1 区间，阴影高度在 0.2 至 0.4 之
// 间。蓝色带误差棒的数据点图例标注为“ACT”，深紫色带误差
// 棒的数据点图例标注为“P-ACT”，紫红色带误差棒的数据点图
// 例标注为“P-ACT-LB”。横轴为对数刻度 k，标有 10^-4、10^
// -2、10^-1、2×10^-1、4×10^-1。数据点在高 k 区域存在水平
// 位移以避免重叠：P-ACT 的点向右偏移 4%，P-ACT-LB 的点向
// 左偏移 4%（参考图注）。在低 k 区域（10^-4 附近），
// P-ACT 和 P-ACT-LB 的数据点约为 3.0 并伴有较大垂直误差
// 棒；在中间区域（10^-2 至 2×10^-1），各数据集的数据点集
// 中在 1.7 至 2.2 之间，误差棒较小且与黑色模型曲线一致；
// 在最高 k 区域（接近 4×10^-1），P-ACT 和 P-ACT-LB 的数
// 据点出现极大波动，纵坐标值升至 6.5 到 7 以上或降至 1.3
// 左右，垂直误差棒覆盖范围极宽（例如从 4 到 7.5），表明
// 该区域不确定性极大。 图(b)为下方局部放大面板，是散点图。
// 纵轴范围缩小为 1.76 到 1.96，横轴范围为 4×10^-2 至 3×
// 10^-1，仅标出 6×10^-2、10^-1、2×10^-1。图中重复展示图(
// a)中的数据点，但去掉了高 k 处的极大发散点，重点显示中
// 间波数区间的微小差异。蓝色 ACT 点、紫色 P-ACT 点和紫红
// 色 P-ACT-LB 点在 k=0.06 至 0.2 范围内交替分布，误差棒
// 垂直长度在 0.02 至 0.06 之间。浅橙色 Planck 阴影区域在
// 此面板中表现为多个离散的矩形块，高度约 0.1，其中心值随
// k 增大呈轻微下降趋势。黑色实线（ΛCDM 模型）同样穿过此
// 区间，从约 1.89 缓慢下降至约 1.81。该子图结论是，在中
// 间波数段，各数据集的重建结果在 68% 置信水平下基本一致，
// 且与标准宇宙学模型预测吻合。
#figure(image("imgs/fig6.png"),
  caption: [
    Binned reconstruction of the dimensionless primordial curvature power spectrum with 68% CL errors for different datasets. The new constraints are centered on the P-ACT~measurement; the ACT~(P-ACT-LB) wavenumbers on the $x$-axis are shifted to the left (right) by 4% in order to more easily see the values/errors for each dataset combination. #emph[Planck] is plotted as shaded boxes for comparison up to $k = 0.15 med upright("Mpc")^(- 1)$ --- beyond this wavenumber, #emph[Planck] alone gives unconstrained limits with the posteriors filling the whole prior range. The top panel shows the reconstruction over the full range of wavenumbers considered and highlights the improvement achieved with the addition of the ACT data (navy versus orange). For this panel, the $x$-axis is scaled as $k^0.5$ in order to best show the small scales. The bottom panel zooms into the region where ACT alone (light blue) becomes comparable and then overtakes #emph[Planck] in constraining power. Adding lensing and BAO data (purple) has minimal impact. The binned measurement is consistent with the P-ACT-LB~best-fit $Lambda$CDM power-law spectrum shown in gray.
  ],
  placement: top,
)
<fig:binned-Pk>

// [figvision-cn] imgs/fig7.png
// 这是一张单面板的曲线图，图中无子图标记，以下按曲线图整
// 体描述。图的横轴名称为“10^9 P_R(k = 0.15 Mpc^-1)”，表
// 示波数k=0.15 Mpc^-1处的原初功率谱幅度乘以10的9次方，横
// 轴刻度范围从约1.82到2.30，主要刻度标注为1.9、2.0、2.1、
// 2.2、2.3；纵轴没有标注名称和刻度，表示边缘化后验概率密
// 度（相对幅度），纵轴范围从0到图框顶部，仅显示相对高度。
// 图内有四条钟形曲线：橙色曲线（图例“Planck”）峰值约在横
// 轴1.96–1.97附近，是四条曲线中最宽的，覆盖范围大致为
// 1.82–2.25；蓝色曲线（图例“ACT”）峰值约在2.065附近，宽
// 度明显窄于橙色曲线；深紫色/藏青色曲线（图例“P-ACT”）峰
// 值约在2.07附近，宽度与蓝色曲线相近或略窄；紫色曲线（图
// 例“P-ACT-LB”）峰值与深紫色曲线几乎重合，约在2.07附近，
// 右半侧略宽于深紫色曲线、左半侧更陡，整体略宽于深紫色曲
// 线。图中有一条垂直的灰色虚线，位于横轴约2.075处，从图
// 底延伸到图顶，灰色虚线正上方偏左有灰色文字标注“
// P-ACT-LB ΛCDM”。图例位于右上角，从上到下列出四条曲线对
// 应的颜色：浅蓝色“ACT”、橙色“Planck”、深紫色“P-ACT”、紫
// 色“P-ACT-LB”。趋势与结论：Planck的后验最宽、约束最弱，
// 峰值位置偏低；ACT和P-ACT显著收窄后验，约束更强；
// P-ACT-LB的峰值与P-ACT-LB ΛCDM模型（灰色虚线）一致，其
// 宽度比P-ACT略宽但优于Planck，说明引入透镜化信息（LB）
// 后在保持与ΛCDM最佳拟合模型一致的同时获得了更强且双侧的
// 后验约束。
#figure(image("imgs/fig7.png"),
  caption: [
    Marginalized posterior for the power at wavenumber $k_star.op = 0.15 med M p c^(- 1)$, showing the improvement brought by ACT~over #emph[Planck] and the limit achieved with P-ACT-LB. The results are consistent with the P-ACT-LB~best-fit $Lambda$CDM power-law model (dashed gray line). #emph[Planck] cannot constrain the model above $k_star.op$, while ACT~continues to measure the amplitude of primordial power with a two-sided posterior up to $k = 0.32 med upright("Mpc")^(- 1)$.
  ],
  placement: top,
)
<fig:binned-Pk-1D>

In Fig.~#ref(<fig:binned-Pk>, supplement: none) we present constraints on the binned primordial power spectrum from ACT, #emph[Planck], P-ACT, and P-ACT-LB, compared to the P-ACT-LB~best-fit $Lambda$CDM power law. The constraints from P-ACT~are improved over the -alone measurements wherever ACT~data are included (for $ell gt.eq 850$), with the ratio of P-ACT~to #emph[Planck] error bars ranging between 0.95 and 0.43 for wavenumbers between $0.063 < k med M p c^(- 1) < 0.15$ or ($880 lt.eq ell lt.eq 2140$). This range is chosen as $k = 0.063 med upright("Mpc")^(- 1)$ is the first wavenumber where P-ACT~significantly improves over #emph[Planck] and $k_star.op = 0.15 med upright("Mpc")^(- 1)$ is the highest wavenumber where #emph[Planck] has a two-sided marginalized posterior (rather than an upper limit). The correlations across bins can be very high and present either between direct neighbors or between more distant bins. In particular, we find correlations at the level of $tilde.op 30 - 40 %$, with a significant increase around $k = 0.01$~Mpc$""^(- 1)$ where bins 6--9 are strongly anti-correlated reaching a level of 90%, and above $k = 0.1$~Mpc$""^(- 1)$ where correlations increase again to reach $50 - 60 %$ at small scales.

In Fig.~#ref(<fig:binned-Pk-1D>, supplement: none), we illustrate the improvement in constraining power for $k_star.op = 0.15 med upright("Mpc")^(- 1)$. Above that wavenumber, the #emph[Planck] constraints essentially fill the assumed prior range, while ACT~constrains the amplitude of primordial power with a two-sided marginalized posterior up to $k = 0.32 med upright("Mpc")^(- 1)$ and with a one-sided 95% CL to $k = 0.43 med upright("Mpc")^(- 1)$. The improvements come from the ACT~sensitivity to smaller angular scales ($ell > 2500 ) .$ In particular, at $k_star.op$, we obtain a fractional error of 2.8% and 1.4% on $e^(- 2 tau) P_(cal(R)) ( k )$ for #emph[Planck] alone and ACT alone, respectively, and a fractional error of $ frac(sigma ( e^(- 2 tau) P_(cal(R)) ( k_star.op ) ), e^(- 2 tau) P_(cal(R)) ( k_star.op )) & = & 1.2 % med med ( sans("P-ACT") ) ,\
 & = & 1.1 % med med ( sans("P-ACT-LB") ) , $ with the individual fits consistent with $Lambda$CDM. Our new constraints improve the range of $k$ over which there are significant constraints by about a factor of three compared to #emph[Planck].

We map this measurement onto the linear matter power spectrum and compare with other measurements in Appendix~@app:pkcompilation. \

== Isocurvature perturbations
<sec:isocurvature>
Standard single-field inflation predicts purely adiabatic primordial perturbations, in the sense that all perturbations arise from a single degree of freedom (the local time at which inflation ends). This generally implies that fractional perturbations in the number density of all species are equal on super-horizon scales ($delta n_i / n_i = delta n_j / n_j$). In contrast, isocurvature perturbations --- characterized by variations in the relative number densities or velocities of different species --- can arise in a variety of early-universe scenarios, particularly if there are additional fields present around the time of inflation~@Linde:1985yf@Mollerach:1989hu@Polarski:1994rz@Garcia-Bellido:1995hsq@Linde:1996gt@Lyth:2001nq@Kawasaki:2001in#cite(<Lyth:2002my>). Whereas current cosmological observations are consistent with purely adiabatic perturbations, and a pure isocurvature perturbation has been excluded since early measurements of the large-scale CMB anisotropies~@Stompor:1995py@Enqvist:2000hp@Enqvist:2001fu, it is possible to have models with mixed adiabatic and isocurvature modes, as constrained in previous CMB anisotropy analyses~@Bucher2004@Moodley:2004nz@Bean2006@Planck_2013_params@Planck:2015sxf#cite(<Planck2018_inflation>). In this section, we place constraints on a range of scenarios consisting of a mixture of an adiabatic mode with a single (possibly correlated) isocurvature mode. We refer the reader to Table~#ref(<table:isocurvature_constraints>, supplement: none) in Appendix~@app:isocurvature_full_constraints for a detailed compilation of the isocurvature constraints derived in this work.

There are four possible non-decaying isocurvature modes: cold dark matter density (CDI), baryon density (BDI), neutrino density (NDI), and neutrino velocity (NVI)~#cite(<Bucher:1999re>). At linear order, BDI and CDI modes have an indistinguishable impact on the CMB power, differing only in amplitude; therefore, we do not analyze BDI modes directly.#footnote[Our CDI constraints can be converted to BDI constraints by applying the appropriate factors of $Omega_c$ and $Omega_b$, as discussed in~#cite(<Planck2018_inflation>).] Additionally, we do not consider NVI because it is less theoretically motivated than CDI and NDI. Consequently, we focus on two isocurvature modes: $cal(I)_("CDI")$ and $cal(I)_("NDI")$.

The primordial curvature and isocurvature fluctuations are described by the curvature power spectrum, $cal(P)_(cal(R) cal(R)) ( k )$, the isocurvature power spectrum, $cal(P)_(cal(I) cal(I)) ( k )$, and their cross-power spectrum, $cal(P)_(cal(R) cal(I)) ( k )$. Following #emph[Planck] analyses of isocurvature~@Planck_2013_params@Planck:2015sxf@Planck2018_inflation, we assume power-law primordial power spectra defined in terms of their amplitudes at two scales, $k_1 = 0.002 med upright("Mpc")^(- 1)$ and $k_2 = 0.1 med upright("Mpc")^(- 1)$, hence $ cal(P)_(a b) ( k ) = exp lr([ frac(ln k - ln k_2, ln k_1 - ln k_2) ln cal(P)_(a b)^((1)) + frac(ln k - ln k_1, ln k_2 - ln k_1) ln cal(P)_(a b)^((2)) ]) $<eq:scalar_osc_bispectrum> where $cal(P)_(a b)^(( i )) equiv cal(P)_(a b) ( k_i )$ and $a , b in { cal(R) , cal(I) }$. The mixed adiabatic and isocurvature models are characterized by four new parameters: $cal(P)_(cal(R) cal(I))^(( 1 ))$, $cal(P)_(cal(R) cal(I))^(( 2 ))$, $cal(P)_(cal(I) cal(I))^(( 1 ))$, $cal(P)_(cal(I) cal(I))^(( 2 ))$.

For computational reasons, we focus on models where the adiabatic and isocurvature perturbations are either uncorrelated or fully (anti)-correlated, and thus $cal(P)_(cal(R) cal(I))^(( i ))$ is a derived parameter. These are the most well-motivated isocurvature scenarios. We sample the adiabatic amplitudes $cal(P)_(cal(R) cal(R))^(( 1 ))$ and $cal(P)_(cal(R) cal(R))^(( 2 ))$ assuming uniform priors between $[ 15 , 40 ] times 10^(- 10)$ as a replacement of the amplitude and scalar spectral index of the baseline $Lambda"CDM"$~parameter set. For the isocurvature amplitudes, we sample $cal(P)_(cal(I) cal(I))^(( 1 ))$ and $cal(P)_(cal(I) cal(I))^(( 2 ))$ (for models where $n_(cal(I) cal(I))$ is not fixed) assuming uniform priors between $[ 0 , 100 ] times 10^(- 10)$. We sample the amplitudes at two scales instead of sampling a single amplitude and a spectral index to mitigate prior-volume effects that can arise if the data have no preference for isocurvature modes~#cite(<Moodley:2004nz>).#footnote[We use `class` with the settings described in Appendix~@app:theory to compute theoretical predictions for isocurvature models. Additionally, we set `hmcode_kmax_extra`=100 to address issues in the `HMCode` non-linear power spectrum calculation for blue-tilted isocurvature perturbations. Despite this, the non-linear evaluation can still fail for a small fraction ($< 1$%) of samples in the #emph[Planck]-only uncorrelated CDI constraints with a free spectral index. We exclude this subset of samples from our analysis, slightly affecting #emph[Planck]-alone constraints for this model. The issues with the non-linear computation do not affect any of our constraints including ACT data, which already exclude such blue-tilted models.]

=== Uncorrelated models
<uncorrelated-models>
We first present constraints on an uncorrelated ($cal(P)_(cal(R) cal(I))^(( i )) = 0$) mixture of adiabatic perturbations with a single, possibly scale-invariant, CDI or NDI mode. Scale-invariant CDI perturbations can arise if there are axions or axion-like particles present during inflation~@Turner:1983sj@Axenides:1983hj@Seckel:1985tj@Turner:1990uz@Linde:1991km@Beltran:2006sq#cite(<Hertzberg:2008wr>). Axions can also produce uncorrelated CDI with a blue spectral index~#cite(<Kasuya:2009up>).

For scale-invariant CDI and NDI modes, we vary $cal(P)_(cal(I) cal(I))^(( 1 ))$ and fix $cal(P)_(cal(I) cal(I))^(( 2 )) = cal(P)_(cal(I) cal(I))^(( 1 ))$. The P-ACT~constraint on the amplitude of scale-invariant CDI perturbations is $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 1.1$ (95% CL). This is slightly weaker than the #emph[Planck]-only bound of $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 0.9$ (95% CL), due to the positive correlation between the adiabatic spectral index ($n_(cal(R) cal(R))$) and the CDI amplitude. For NDI, the baseline P-ACT~constraint on the isocurvature amplitude is $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 1.8$ at (95% CL), which is 15% tighter than the #emph[Planck]-only bound, $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 2.1$ (95% CL). Neither of these constraints changes appreciably between P-ACT~and P-ACT-LB.

// [figvision-cn] imgs/fig8.png
// 这是一张三角图（corner plot），由六个子图组成，呈 3×3
// 下三角布局，用于展示混合绝热与不相关 CDI 模式（功率谱
// 为幂律）下原初等曲率功率谱参数的后验约束。右上角图例标
// 明三种数据集组合：橙色代表 Planck，深蓝色代表 P-ACT，
// 紫色代表 P-ACT-LB。 第一行：子图 (a) 位于左上角，展示
// 10^10 p_II^(1) 与 10^10 p_II^(2) 的二维约束。横轴 10^
// 10 p_II^(1) 范围从 0 到 1.0，纵轴 10^10 p_II^(2) 范围
// 从 0 到 100（乘 10^10）。三条曲线分别对应三种数据集，
// 呈指数衰减形态，Planck 曲线衰减最快，P-ACT-LB 曲线衰减
// 最慢。 第二行：子图 (b) 位于左中，展示 10^10 p_II^(1)
// 与 n_II 的二维约束。横轴 10^10 p_II^(1) 范围从 0 到
// 1.0，纵轴 n_II 范围从 1 到 4。图中为填充等高线区域，
// Planck（橙色）区域最宽，P-ACT（深蓝）和 P-ACT-LB（紫色）
// 区域更窄并偏向低 p_II^(1) 值。子图 (c) 位于中上，展示
// 10^10 p_II^(2) 与 n_II 的二维约束。横轴 10^10 p_II^(2)
// 范围从 0 到 80，纵轴 n_II 范围从 1 到 4。等高线形状类
// 似，Planck 区域最宽，P-ACT 和 P-ACT-LB 区域更窄。 第三
// 行：子图 (d) 位于左下，展示 10^10 p_II^(1) 的一维边缘
// 后验分布。横轴 10^10 p_II^(1) 范围从 0 到 1.4，纵轴为
// 概率密度。三条曲线均在低值处有峰值，Planck 曲线峰值最
// 高且最窄。子图 (e) 位于中下，展示 10^10 p_II^(2) 的一
// 维边缘后验分布。横轴 10^10 p_II^(2) 范围从 0 到 100，
// 三条曲线峰值在 20 至 40 之间。子图 (f) 位于右下，展示
// n_II 的一维边缘后验分布。横轴 n_II 范围从 1 到 4，三条
// 曲线均为钟形，P-ACT 和 P-ACT-LB 曲线峰值在 2 附近，
// Planck 曲线峰值在 2.4 附近且分布更宽。 总体趋势表明，
// 添加 P-ACT 和 P-ACT-LB 数据对等曲率功率谱参数给出了比
// Planck 单独更严格的约束，特别是将 n_II 限制在更窄的范
// 围内，并压低了 p_II^(1) 和 p_II^(2) 的上限。
#figure(image("imgs/fig8.png"),
  caption: [
    Constraints on the primordial isocurvature power spectrum parameters for a mixed adiabatic and uncorrelated CDI mode with a power-law power spectrum for several dataset combinations.
  ],
  placement: top,
)
<fig:cdi_posterior>

Figure~#ref(<fig:cdi_posterior>, supplement: none) shows the marginalized posterior distributions for the uncorrelated CDI model with a free spectral index. Combining ACT and #emph[Planck], we find $ mat(delim: "}", align: #left,
  10^10 cal(P)_(cal(I) cal(I))^((1)) < 0.7;
  10^10 cal(P)_(cal(I) cal(I))^((2)) < 26,
) quad ("one-tail" 95%, "P-ACT") $ The P-ACT~constraint on $cal(P)_(cal(I) cal(I))^(( 2 ))$ is a significant improvement over the #emph[Planck]-only constraint of $10^10 cal(P)_(cal(I) cal(I))^(( 2 )) < 59$. Interestingly, the P-ACT~constraint on $cal(P)_(cal(I) cal(I))^(( 1 ))$ is weaker than that from the #emph[Planck] dataset alone. This is a consequence of the anti-correlation between $cal(P)_(cal(I) cal(I))^(( 1 ))$ and $cal(P)_(cal(I) cal(I))^(( 2 ))$, assuming a power-law spectrum. In other words, the large values of $cal(P)_(cal(I) cal(I))^(( 2 ))$ that are consistent with the #emph[Planck] data, but not the P-ACT~combination, drive the #emph[Planck]-only marginalized posterior on $cal(P)_(cal(I) cal(I))^(( 1 ))$ towards zero. The addition of CMB lensing and BAO data does not significantly change the P-ACT~constraints on this model.

// [figvision-cn] imgs/fig9.png
// 这是一张三角图（corner plot），用于展示三个参数的后验
// 概率分布，包含三个数据集（Planck、P-ACT、P-ACT-LB）的
// 对比。图像由六个子图组成，排列成 3×3 的网格，仅显示下
// 三角部分（包括对角线上的 1D 概率密度曲线和下方的 2D 等
// 高线图）。右上角图例显示：橙色代表 Planck，深蓝色代表
// P-ACT，紫色代表 P-ACT-LB。 坐标轴及参数： 横轴（左列和
// 中列底部）：\(10^{10}p_{II}^{(1)}\)，范围约 0.2 到 3.2，
// 刻度为 1, 2, 3。 横轴（中列和右列底部）：\(10^{10}p_{
// II}^{(2)}\)，范围约 1 到 10，刻度为 2, 6, 10。 横轴（
// 右列底部）：\(n_{II}\)，范围约 0 到 3，刻度为 0, 1, 2,
// 3。 纵轴（左列）：\(10^{10}p_{II}^{(2)}\)，范围约 1 到
// 14，刻度为 2, 6, 10。 纵轴（中列）：\(n_{II}\)，范围约
// 0 到 3.2，刻度为 0, 1, 2, 3。 子图类型与内容： 对角线
// 上三个子图（左上、中中、右下）为 1D 后验概率密度曲线。
// 左上图（\(10^{10}p_{II}^{(2)}\) 的 1D 分布）：橙色曲线
// 峰值在约 12，深蓝色曲线峰值在约 10.5，紫色曲线峰值在约
// 11.5，橙色曲线在低值端有更明显的拖尾。中中图（\(10^{10
// }p_{II}^{(1)}\) 的 1D 分布）：橙色曲线峰值在约 2.5，深
// 蓝色峰值在约 1.8，紫色峰值在约 1.9。右下图（\(n_{II}\)
// 的 1D 分布）：橙色曲线峰值在约 1.8，深蓝色峰值在约 1.6，
// 紫色峰值在约 1.6，三条曲线形状相似但中心位置略有偏移。
// 非对角线子图（左下、中下、中左）为 2D 等高线图。左下子
// 图（\(10^{10}p_{II}^{(1)}\) vs \(10^{10}p_{II}^{(2)}\)）：
// 等高线显示负相关趋势，橙色（Planck）的置信区域最宽，紫
// 色（P-ACT-LB）最窄。中下子图（\(10^{10}p_{II}^{(2)}\)
// vs \(n_{II}\)）：等高线呈正相关，橙色区域最宽，紫色最
// 窄。中左子图（\(10^{10}p_{II}^{(1)}\) vs \(n_{II}\)）：
// 等高线呈正相关，橙色区域最宽，紫色最窄。所有 2D 等高线
// 均使用实线绘制，内部填充对应颜色（橙色、深蓝色、紫色），
// 颜色深浅表示概率密度高低。 图中所有标注文字均使用数学
// 符号，无额外文本标签。图例位于右上角，三个色块分别对应
// 不同数据集。各子图传达的趋势是：不同数据集对参数的约束
// 能力不同，P-ACT-LB 给出的约束最紧，Planck 最宽松；参数
// 之间存在一定的相关性。
#figure(image("imgs/fig9.png"),
  caption: [
    Same as Fig.~#ref(<fig:cdi_posterior>, supplement: none) for a primordial isocurvature power spectrum with a mixed adiabatic and uncorrelated NDI mode.
  ],
  placement: top,
)
<fig:ndi_posterior>

Figure~#ref(<fig:ndi_posterior>, supplement: none) presents the marginalized posteriors on the isocurvature amplitudes for an uncorrelated mixture of adiabatic and NDI modes assuming a free spectral index. Combining ACT and #emph[Planck], we find $ mat(delim: "}", align: #left,
  10^10 cal(P)_(cal(I) cal(I))^((1)) < 1.6;
  10^10 cal(P)_(cal(I) cal(I))^((2)) < 6.1,
) quad ("one-tail" 95%, "P-ACT") $ Interestingly, although the #emph[Planck] data alone showed a small, statistically insignificant peak in the posterior at non-zero values of $cal(P)_(cal(I) cal(I))^(( 1 ))$ and $cal(P)_(cal(I) cal(I))^(( 2 ))$, this feature disappears when ACT DR6 data are included. Finally, including CMB lensing and BAO data further improves the constraint on the amplitude of NDI perturbations at $k = 0.1 med upright("Mpc")^(- 1)$ to $10^10 cal(P)_(cal(I) cal(I))^(( 2 )) < 5.4$. In this case, the improvement from CMB lensing and BAO is predominately due to the anti-correlation between $n_(cal(R) cal(R))$ and $10^10 cal(P)_(cal(I) cal(I))^(( 2 ))$, with P-ACT-LB~preferring a slightly larger value of $n_(cal(R) cal(R))$ than P-ACT.

In summary, we find no evidence of uncorrelated CDI or NDI. Nevertheless, including ACT DR6 data leads to stringent bounds on the amplitude of small-scale isocurvature perturbations, highlighting the complementarity of large- and small-scale CMB observations.

=== Correlated models
<correlated-models>
We also present constraints on a correlated mixture of adiabatic and CDI perturbations. We consider the situation where the adiabatic and CDI modes are fully correlated, $cal(P)_(cal(R) cal(I)) ( k ) = sqrt(cal(P)_(cal(R) cal(R)) ( k ) cal(P)_(cal(I) cal(I)) ( k ))$, as well as the fully anti-correlated scenario ($cal(P)_(cal(R) cal(I)) ( k ) = - sqrt(cal(P)_(cal(R) cal(R)) ( k ) cal(P)_(cal(I) cal(I)) ( k ))$). In both cases, we vary only $cal(P)_(cal(I) cal(I))^(( 1 ))$ and fix $cal(P)_(cal(I) cal(I))^(( 2 ))$ assuming $n_(cal(I) cal(I)) = n_(cal(R) cal(R))$. While the high-resolution ACT DR6 spectra are unlikely to significantly improve upon the #emph[Planck]-only constraints on these models as the transfer function for scale-invariant CDI perturbations is significantly suppressed at high multipoles, we explore correlated CDI models because they are theoretically well-motivated. For example, mixed adiabatic and CDI perturbations with large (anti)-correlations arise in the curvaton scenario~@Mollerach:1989hu@Moroi:2001ct@Lyth:2001nq@Bartolo:2002vf#cite(<Lyth:2002my>).

For the fully correlated model, the P-ACT~dataset constrains the isocurvature amplitude to $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 0.025$ (95% CL). Including CMB lensing and BAO data slightly relaxes this bound to $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 0.031$. For the fully anti-correlated model, P-ACT~provides $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 0.027$, improving modestly on the #emph[Planck]-only limit ($< 0.031$). P-ACT-LB~leads to $10^10 cal(P)_(cal(I) cal(I))^(( 1 )) < 0.015$ at 95% confidence.

Overall, we find no evidence of primordial isocurvature perturbations.

== Tensor modes and constraints on inflation models
<sec:tensors>
Tensor perturbations, for example in the form of primordial gravitational waves predicted by inflation models (see, e.g.,~#cite(<2016ARAandA..54..227K>, style: "aas_noparen.csl") for a review), add power on very large scales in the CMB T/E angular power spectra and generate a unique large-scale B-mode polarization signal not measured by ACT. However, the full behavior of the primordial perturbations depends on the ratio/co-existence of tensor and scalar modes, with the latter measured by ACT small-scale data via $n_s$. Here, we study how the updated measurement of $n_s$ presented in L25 affects constraints on inflation models.

The modeling of tensor perturbations is similar to that used for scalars, $cal(P)_t ( k ) = A_t ( k / k_(*) )^(n_t)$, and is usually quantified by the tensor-to-scalar ratio parameter, $r = cal(P)_t ( k_(*) ) / cal(P)_(cal(R)) ( k_(*) )$. Here we set $n_t$ via the inflationary consistency relation, $n_t = - r / 8$. Constraints on $r$ and $n_s$ can be directly related to the potential slow-roll parameters of inflation, $epsilon.alt_V$ and $eta_V$, which are determined by the shape of the inflaton potential, as $ epsilon.alt_V & equiv M_(P l)^2 / 2 (V_(, phi.alt) / V)^2 ,\
eta_V & equiv M_(P l)^2 (V_(, phi.alt phi.alt) / V) thin , $ where $M_(P l)$ is the Planck mass, $V ( phi.alt )$ is the inflaton potential, and $V_(, phi.alt)$ and $V_(, phi.alt phi.alt)$ are its first and second derivatives. These parameters respectively describe the steepness and curvature of the inflaton potential, and they relate to the power spectrum parameters as $ r & = 16 epsilon.alt_V ,\
n_s - 1 & = 2 eta_V - 6 epsilon.alt_V thin . $

// [figvision-cn] imgs/fig10.png
// 这是一张二维参数空间约束图，横轴为标量光谱指数 n_s，范
// 围 0.95 到 1.00，刻度间隔 0.01，无单位；纵轴为张量标量
// 比 r，范围 0.00 到 0.10，刻度间隔 0.02，无单位。图中包
// 含三组彩色置信区：橙色区域对应 Planck-LB-BK18 数据集，
// 蓝色区域对应 ACT-LB-BK18，紫色区域对应 P-ACT-LB-BK18。
// 每组彩色区域由内向外分为三层：最内层为深色实心填充，中
// 间层为半透明填充，最外层为浅色半透明填充并带有同色实线
// 轮廓，分别对应约 68%、95% 和 99% 的置信水平。橙色区域
// 中心约在 n_s=0.968、r=0.022，蓝色区域中心约在 n_s=
// 0.976、r=0.020，紫色区域中心约在 n_s=0.974、r=0.016。
// 图中有一条粗黑实线从左上（n_s≈0.955, r=0.10）斜向右下
// （n_s=1.00, r=0.00），线上带有 4 个黑色实心圆点，按
// n_s 从大到小（r 从高到低）依次标记了 N=50 和 N=60 两种
// 点大小，其中 r≈0.08 和 r≈0.066 处为大的 N=60 点，r≈
// 0.053 和 r≈0.044 处为小的 N=50 点。粗黑实线右侧有一条
// 灰色宽带，边界为细黑虚线，带内包含三个空心小圆点，灰带
// 随黑线平行延伸。另有灰色和浅灰色两条细实线从黑线上 r≈
// 0.053 点附近向右下方延伸，分别标记为 V(φ) ∝ φ^{2/3} 和
// V(φ) ∝ φ^{1/3}；一条深蓝色虚线从 n_s≈0.960、r≈0.004 水
// 平向右延伸至 n_s≈0.966 附近，标记为 R^2，末端带有一个
// 深蓝色实心圆点。粗黑线右下方标注有“Convex”和“Concave”
// 文字，指示黑线两侧的势能曲率方向。右上角图例列出了六项：
// ACT-LB-BK18（蓝色色块）、Planck-LB-BK18（橙色色块）、
// P-ACT-LB-BK18（紫色色块）、V(φ) ∝ φ（黑色实线）、V(φ)
// ∝ φ^{2/3}（灰色实线）、V(φ) ∝ φ^{1/3}（浅灰色实线）、R
// ^2（深蓝色虚线）。左上角图例说明了黑色圆点大小与 N 的
// 关系：小点 N=50，大点 N=60。整体趋势表明，三个数据集对
// n_s 和 r 的约束主要集中在 n_s≈0.96–0.98、r<0.05 的区域，
// 其中 P-ACT-LB-BK18 的约束最紧，Planck-LB-BK18 次之，
// ACT-LB-BK18 最宽；不同势能模型（φ、φ^{2/3}、φ^{1/3}、R
// ^2）的预测线穿过或接近这些置信区，而 N=50 和 N=60 的预
// 测点沿粗黑线分布，灰带表示这些预测的不确定性范围。
#figure(image("imgs/fig10.png"),
  caption: [
    Constraints on the scalar and tensor primordial power spectra at $k_(*) = 0.05 thin upright("Mpc")^(- 1)$, shown in the $r - n_s$ parameter space. The constraints on $r$ are driven by the BK18 data, while the constraints on $n_s$ are driven by ~(orange), ACT~(blue), or P-ACT~(purple). The combined dataset also includes CMB lensing and BAO in all cases. The various circles and solid lines in between the gray band show predictions for different power-law potentials with the number of e-folds of inflation $50 < N < 60$, while the solid black line shows the separation between convex- and concave-shaped potentials. The Starobinsky $R^2$ model is also shown for 50-60 e-folds (dashed navy line); the P-ACT-LB~measurement of $n_s$ disfavors this model at $gt.eq 2 sigma$, for $50 < N < 60$.
  ],
  placement: top,
)
<fig:tensors>

// [figvision-cn] imgs/fig11.png
// 这是一张 3×3 的角图（corner plot），用于展示慢滚参数 ε
// _V 和 η_V 以及标量谱指数 n_s 的联合约束。对角线上是三
// 组数据的一维边缘概率密度曲线，非对角线上是二维置信区间
// 等高线图。右上角空白区域放置图例，文字为：ACT-LB-BK18
// （蓝色）、Planck-LB-BK18（橙色）、P-ACT-LB-BK18（紫色）。
// 所有一维曲线的纵轴均未标数值，仅表示相对概率密度。 第
// 一行三个子图：左上（1,1）为 n_s 的一维边缘分布，横轴范
// 围约 0.955–0.985，无纵轴刻度；橙色曲线峰值在 n_s≈0.970，
// 蓝色曲线峰值在 n_s≈0.976，紫色曲线峰值位于两者之间。中
// 上（1,2）为 ε_V 的一维边缘分布，横轴范围约 0.0005–
// 0.0040；三条曲线几乎完全重合，峰值在 ε_V≈0.0013，曲线
// 在 ε_V≈0.0025 之外迅速衰减。右上（1,3）为 η_V 的一维边
// 缘分布，横轴范围约 −0.017–0.004；橙色曲线峰值在 η_V≈−
// 0.010，蓝色曲线峰值在 η_V≈−0.007，紫色曲线峰值在 η_V≈−
// 0.008。 第二行三个子图：左中（2,1）为 n_s–ε_V 二维等高
// 线，纵轴 ε_V 范围 0–0.004，横轴 n_s 范围约 0.955–0.985；
// 三组等高线均呈纵向拉长的椭圆，中心位于 n_s≈0.972–0.976、
// ε_V≈0.0013，蓝色等高线面积最大，橙色略小，紫色最窄。正
// 中（2,2）为 ε_V–η_V 二维等高线，横轴 ε_V 范围约 0.0005
// –0.0035，纵轴 η_V 范围 −0.020–0.004；等高线呈左下—右上
// 倾斜的椭圆，中心约在 ε_V≈0.0013、η_V≈−0.008，蓝色区域
// 最大，橙色偏向更低 η_V，紫色居中。右中（2,3）为 n_s–η
// _V 二维等高线，横轴 n_s、纵轴 η_V 范围同上；等高线呈左
// 下—右上倾斜的椭圆，中心约在 n_s≈0.973、η_V≈−0.008，蓝
// 色区域最大且向高 n_s、高 η_V 方向延伸，橙色偏向低 n_s、
// 低 η_V，紫色居中。 第三行三个子图：左下（3,1）与右中（
// 2,3）相同，为 n_s–η_V 等高线，横轴 n_s、纵轴 η_V，范围
// 同第二行；三组等高线均呈正相关倾斜，蓝色区域覆盖范围最
// 大，橙色最小。中下（3,2）与正中（2,2）相同，为 ε_V–η_V
// 等高线，横轴 ε_V、纵轴 η_V；蓝色等高线在 ε_V 和 η_V 方
// 向均最宽，橙色较窄，紫色居中。右下（3,3）与右上（1,3）
// 相同，为 η_V 的一维边缘分布，横轴 η_V 范围约 −0.017–
// 0.004；橙色峰值最靠左（约 −0.010），蓝色峰值最靠右（约
// −0.007），紫色介于两者之间。 整体趋势：ε_V 受 BK18 张
// 量—标量比限制驱动，三组数据对其约束几乎一致，峰值约
// 0.0013；η_V 受 ACT、Planck 及 P-ACT-LB 数据驱动，不同
// 数据集导致 η_V 中心值在 −0.010 至 −0.007 之间偏移；n_s
// 的中心值在 0.970–0.976 之间，蓝色（ACT-LB-BK18）倾向于
// 更高的 n_s 和更高的 η_V，橙色（Planck-LB-BK18）倾向于
// 更低的 n_s 和更低的 η_V，紫色（P-ACT-LB-BK18）介于两者
// 之间。二维等高线均显示 n_s 与 η_V 正相关、ε_V 与 η_V
// 正相关。图中未出现显微照片、比例尺或成像通道信息。
#figure(image("imgs/fig11.png"),
  caption: [
    Constraints on the slow-roll parameters $epsilon.alt_V$ and $eta_V$. The first parameter is driven by the BK18 limit on the tensor-to-scalar ratio, while $eta_V$ tracks the contribution to $n_s$ from ACT (blue), ~(orange), and P-ACT-LB~(purple).
  ],
  placement: top,
)
<fig:slow-roll>

To derive new results in the $r - n_s$ plane presented in Fig.~#ref(<fig:tensors>, supplement: none), we vary $r$ in the range $[ 0 , 1 ]$ and we include B-mode measurements from the BICEP and Keck telescopes at the South Pole, which have jointly accumulated more than fifteen years of observations of CMB polarization at degree scales. Their measurements of CMB B-modes are the most precise to date in the field~#cite(<BK18>, supplement: [BK18]) and completely drive the upper limit on $r$, which (combined with $n_s$ from ) strongly excludes monomial inflation models with convex potentials. The inclusion of ACT~data shows a preference for a slightly higher value of $n_s$, indicated by the purple contour shifting to the right of the orange contour in Fig.~#ref(<fig:tensors>, supplement: none), and gives $r < 0.038$ (95%, P-ACT-LB-BK18). As a consequence, P-ACT~can accommodate power-law inflation models with slightly higher power-law indices than those preferred by #emph[Planck] alone (assuming 50--60 e-folds of inflation), i.e., power-law models that are closer to a linear potential and hence possess a second derivative closer to zero. On the contrary, the Starobinsky $R^2$ inflation model~@1980PhLB...91...99S @1992JETPL..55..489S, which predicts lower values of $n_s$ for the standard range of 50--60 e-folds,#footnote[The number of e-folds depends on the (highly uncertain) post-inflation reheating history; see, e.g., the discussion in Sec.~2.4--2.5 of~#cite(<CMB_S4_Science_Book>).] is more disfavored and lies on the $2 sigma$ boundary of P-ACT-LB.

The constraints on the slow-roll parameters are shown in Fig.~#ref(<fig:slow-roll>, supplement: none), with BK18 determining $epsilon.alt_V$ and ACT adding to the constraint on $eta_V$. The slight preference for a higher $n_s$ value implies a value of $eta_V$ closer to zero, $ eta_V & = & ( - 95_(- 30)^(+ 23) ) times 10^(- 4) med ( 68 % , sans("P-ACT-LB-BK18") ) thin , $ and thus implies a preference for a slightly less concave inflaton potential.

The inclusion of running of the spectral index of scalar perturbations does not significantly change these results. \

= Pre- and modified-recombination physics
<sec:recomb>
== Early dark energy
<sec:ede>
The early dark energy (EDE) extension to $Lambda$CDM introduces a new field that acts to accelerate the expansion of the universe prior to recombination, reducing the sound horizon at last scattering and thus increasing the CMB-inferred Hubble constant~@Poulin2019@Lin:2019qug#cite(<Agrawal:2019lmo>). Here, we consider an axion-like EDE model that has been widely studied in the literature, which is described by the potential~@Poulin2019@Smith2019 $ V ( phi.alt ) = m^2 f^2 ( 1 - cos ( phi.alt / f ) )^n thin , $ where $m$ is the mass of the field, $f$ is the axion decay constant, and $n$ is a power-law index. While $n = 1$ is excluded on phenomenological grounds --- as the EDE would act as an additional contribution to dark matter at late times --- values of $n gt.eq 2$ constitute viable models. Here, we consider as baseline the $n = 3$ model, as in previous literature (e.g.,~#cite(<Hill_2020>, style: "aas_noparen.csl")#cite(<Ivanov2020>, style: "aas_noparen.csl")#cite(<DAmico2020>, style: "aas_noparen.csl")#cite(<LaPosta2022>, style: "aas_noparen.csl")#cite(<Hill_ACT_EDE>, style: "aas_noparen.csl")), and discuss the $n = 2$ case below and in Appendix~@app:ede_full_constraints.

Following previous works @Poulin2019@Smith2019@Hill_ACT_EDE, we adopt a phenomenological parametrization that introduces three additional parameters beyond those in $Lambda$CDM: $f_("EDE")$, $z_c$, and $theta_i$, where $ f_("EDE") = 8 pi G rho_("EDE") ( z_c ) / ( 3 H^2 ( z_c ) ) $ is the maximum fractional contribution of EDE to the cosmic energy budget, which is reached at "critical redshift" $z_c$, and the initial field displacement $theta_i = phi.alt_i / f$. The energy density $rho_("EDE")$ is given by $ rho_("EDE") ( z_c ) = 1 / 2 dot(phi.alt) ( z_c )^2 + V ( phi.alt ( z_c ) ) $ and the field $phi.alt$ evolves by the Klein-Gordon equation (dots here denote derivatives with respect to cosmic time) $ dot.double(phi.alt) + 3 H dot(phi.alt) + frac(d V, d phi.alt) = 0 thin . $<eq.KleinGordon> Initially the field is frozen due to Hubble friction. Around redshift $z_c$ when $H tilde.op m$, the field begins to roll.

Several previous studies have constrained this model with various datasets (see, e.g.,~#cite(<Kamionkowski:2022>, style: "aas_noparen.csl")#cite(<Poulin2023EDEreview>, style: "aas_noparen.csl")#cite(<McDonough2024>, style: "aas_noparen.csl") for reviews). @Hill_2020 found that #emph[Planck] alone has no preference for EDE, with $f_("EDE") < 0.087$ (95% CL) and $H_0 = 68.3 plus.minus 1.0$ (68% CL); these -derived bounds were further tightened using NPIPE data in~@McDonough2024#cite(<Efstathiou2024EDE>). However, the ACT DR4 data showed a hint of a preference for the EDE model over $Lambda$CDM at $2$--$3 sigma$ significance~#cite(<Hill_ACT_EDE>). The combination of ACT DR4, large-scale #emph[Planck] TT, #emph[Planck] CMB lensing, and BOSS BAO data yielded $f_("EDE") = 0.091_(- 0.036)^(+ 0.020)$ (68% CL) and $H_0 = 70.9_(- 2.0)^(+ 1.0)$~km/s/Mpc (68% CL)~@Hill_ACT_EDE (see also #cite(<2021PhRvD.104l3550P>, style: "aas_noparen.csl")#cite(<LaPosta2022>, style: "aas_noparen.csl") #cite(<2022PhRvD.106d3526S>, style: "aas_noparen.csl")#cite(<2024PhRvD.109j3506S>, style: "aas_noparen.csl")). However, the statistical weight of #emph[Planck] was sufficiently large compared to DR4 that this mild preference disappeared when combining ACT DR4 with the full #emph[Planck] data.

We re-evaluate here the preference for this model with the new ACT DR6 power spectra. Note that, in general, models with a significant EDE fraction leave imprints in the CMB power spectra on modes that are within (or entering) the horizon at redshifts around $z_c$. While some of these imprints can be absorbed by changes in other cosmological parameters, particularly $Omega_c h^2$ and $n_s$~@Hill_2020, high-resolution polarization data are expected to break these degeneracies and yield strong sensitivity to EDE, should it be present~@Smith2019@Hill_ACT_EDE#cite(<2024PhRvD.109j3506S>). For models with $z_c tilde.op z_(upright("eq"))$, unique features are imprinted in CMB power spectra at $ell tilde.op 400 - 800$, as well as broader imprints extending to smaller angular scales. Indeed, the mild hint of EDE in the ACT DR4 analysis was largely driven by a fluctuation in the EE power spectrum at $ell tilde.op 500$ and a broad trend in the joint ACT and #emph[Planck] TE power spectrum~#cite(<Hill_ACT_EDE>). Our analysis of the new ACT DR6 spectra is a high-precision test as to whether these features were the first hints of a real signal, or simply a statistical fluctuation.

We sample the model parameters with uniform priors $f_("EDE") in [ 0.001 , 0.5 ]$, $log_10 ( z_c ) in [ 3.0 , 4.3 ]$, and $theta_i in [ 0.1 , 3.1 ]$. We compute theoretical predictions using the EDE model implementation in `class`, which itself was merged from the modified version `class_ede`~@Hill_2020,#footnote[#link("https://github.com/mwt5345/class_ede")] as well as using `CosmoPower`-based emulators of the `class` EDE predictions (described in~#cite(<Qu:2024lpx>, style: "aas_noparen.csl")). One important detail to note is that these emulators were trained on theory predictions computed assuming three massive neutrino species, which is different from our baseline convention in this paper of assuming one massive neutrino. This difference leads to very small shifts in the $H_0$ posteriors ($< 0.1$ km/s/Mpc), but otherwise leaves the parameter constraints unaffected, as we verify using full `class` runs. For calculations in the $n = 2$ EDE model, we compute theoretical predictions using the implementation in `camb`, as we find that calculations for this model are more numerically stable in `camb` than in `class` (for some extreme $n = 2$ scenarios, we find that `class` does not run successfully). As a test of the theory codes used for the EDE model, we verify that the $chi_("ACT")^2$ values computed for a benchmark $n = 3$ EDE model with `camb` and `class` agree with one another to within 0.06, nearly as good as the $Lambda"CDM"$~agreement for these codes (see Appendix~@app:theory).

Figures~#ref(<fig:ede_base_triangle>, supplement: none) and~#ref(<fig:ede_kitchen_sink>, supplement: none) show the marginalized posterior distributions for key parameters in the $n = 3$ EDE model, for different dataset combinations. With the new ACT DR6 spectra, we find $ f_("EDE") & < & 0.088 quad ( 95 % , sans("ACT") ) ,\
f_("EDE") & < & 0.12 quad med med ( 95 % , sans("P-ACT") ) , $<eq.ede_f_act> and $ H_0 & = & 67.5_(- 1.7)^(+ 0.9) quad ( 68 % , sans("ACT") ) ,\
H_0 & = & 69.3_(- 1.5)^(+ 0.9) quad ( 68 % , sans("P-ACT") ) thin , $<eq.ede_h0_act> with the W-ACT~case also shown in the figures to allow a -independent assessment of the EDE constraints. We find that ACT~alone shows essentially no shift in $H_0$ within the EDE model, compared to $Lambda"CDM"$~--- the hint of non-zero EDE seen in the DR4 data is not seen in DR6 (comparisons between the DR4 and DR6 EDE constraints can be found in Appendix~@app:ede_full_constraints). When combining with #emph[Planck], the $H_0$ posterior shifts upward, but when combining with #emph[WMAP], this is significantly lessened: we find $H_0 = 68.1_(- 1.6)^(+ 0.8) thin thin ( 68 % , sans("W-ACT") )$. As discussed below, the improvement in quality of fit in all cases is not statistically significant. When we also include CMB lensing and BAO data, we obtain $ f_("EDE") & < & 0.12 quad med med quad ( 95 % , sans("P-ACT-LB") )\
H_0 & = & 69.9_(- 1.5)^(+ 0.8) quad ( 68 % , sans("P-ACT-LB") ) thin , $<eq.ede_f_pactlb> with W-ACT-LB~giving similar results. For comparison, $H_0 = 68.2 plus.minus 0.4$~km/s/Mpc in $Lambda"CDM"$~for P-ACT-LB~(L25). We also consider substituting BOSS BAO for DESI BAO data, which yields $f_("EDE") < 0.10$ (95%, P-ACT-LB#sub[BOSS]) and $H_0 = 69.2_(- 1.3)^(+ 0.7)$~km/s/Mpc (68%, P-ACT-LB#sub[BOSS]), slightly decreasing $H_0$ and tightening the bound on $f_("EDE")$ compared to P-ACT-LB.#footnote[This is consistent with the results of~#cite(<Qu:2024lpx>, form: "prose"), who found that the shift in the best-fit $Omega_m$ between BOSS and DESI BAO data led to a weaker upper limit on EDE from DESI in combination with data from #emph[Planck] and other probes.] We further verify that these results are essentially unchanged with the inclusion of SNIa data in the analysis.

// [figvision-cn] imgs/fig12.png
// 这是一张三角相关图（corner plot），用于展示四个宇宙学
// 参数的后验概率分布及其两两相关性。图中包含四个参数：H0
// （单位未标注，数值范围约 64 至 74）、Ωch2（数值范围约
// 0.115 至 0.145）、S8（数值范围约 0.78 至 0.96）以及
// fEDE（数值范围约 0.01 至 0.19）。图例位于右上角，标明
// 了三种数据集组合：ACT（浅蓝色）、W-ACT（棕红色）和
// P-ACT（深蓝色）。图中每一个参数与自身的分布展示在对角
// 线上（一维边缘化后验），而其他子图则展示参数两两之间的
// 二维置信区间轮廓（68% 和 95% 置信水平）。 对角线上的四
// 个一维后验分布子图（自上而下、自左向右）： 第一个子图
// 展示 H0 的边缘化后验。横轴 H0 范围约 64 至 74。三条曲
// 线均呈近似对称的单峰分布。ACT（浅蓝）峰值约在 67.5，
// W-ACT（棕红）峰值约在 68.5，P-ACT（深蓝）峰值约在 69.5。
// P-ACT 的分布最窄，且相对于 ACT 向高值偏移。 第二个子图
// 展示 Ωch2 的边缘化后验。横轴 Ωch2 范围约 0.115 至
// 0.145。三条曲线峰值集中在 0.125 至 0.132 之间。ACT 峰
// 值约 0.128，W-ACT 峰值约 0.130，P-ACT 峰值约 0.131。
// P-ACT 分布最窄且峰值最高。 第三个子图展示 S8 的边缘化
// 后验。横轴 S8 范围约 0.78 至 0.96。ACT 峰值约 0.88，
// W-ACT 峰值约 0.86，P-ACT 峰值约 0.85。P-ACT 分布最窄，
// 且向低值偏移。 第四个子图展示 fEDE 的边缘化后验。横轴
// fEDE 范围约 0.01 至 0.19。ACT 曲线在 0.01 附近最高，随
// 后单调下降。W-ACT 曲线在 0.01 附近最高，下降较快。
// P-ACT 曲线在 0.01 附近最高，但在 0.06 至 0.08 之间出现
// 一个明显的小峰（bump），随后再下降。该小峰对应图注中提
// 到的 P-ACT 的轻微改进。 二维置信区间轮廓子图（非对角线）：
// 第二行第一列（Ωch2 vs H0）：横轴 H0，纵轴 Ωch2。三个数
// 据集的 68% 和 95% 轮廓均呈正相关（向右上方倾斜）。ACT
// 轮廓最宽，P-ACT 轮廓最窄且位于右上方。 第三行第一列（
// S8 vs H0）：横轴 H0，纵轴 S8。轮廓呈负相关（向右下方倾
// 斜）。ACT 轮廓最宽，P-ACT 轮廓最窄且位于左下方。 第三
// 行第二列（S8 vs Ωch2）：横轴 Ωch2，纵轴 S8。轮廓呈正相
// 关（向右上方倾斜）。ACT 轮廓最宽，P-ACT 轮廓最窄且位于
// 右上方。 第四行第一列（fEDE vs H0）：横轴 H0，纵轴
// fEDE。轮廓呈正相关（向右上方倾斜）。ACT 轮廓较宽，
// P-ACT 轮廓较窄且位于右上方。 第四行第二列（fEDE vs Ω
// ch2）：横轴 Ωch2，纵轴 fEDE。轮廓呈正相关（向右上方倾
// 斜）。ACT 轮廓较宽，P-ACT 轮廓较窄且位于右上方。 第四
// 行第三列（fEDE vs S8）：横轴 S8，纵轴 fEDE。轮廓呈负相
// 关（向右下方倾斜）。ACT 轮廓较宽，P-ACT 轮廓较窄，且
// P-ACT 的轮廓在 fEDE 较高处（约 0.1）有轻微的上翘，对应
// 一维分布中的小峰。 图中所有轮廓均使用实线绘制，内部填
// 充半透明颜色。所有坐标轴均标注了刻度线，但仅最左侧列和
// 最底行标注了轴标签和数值。该图传达的主要趋势是：fEDE
// 与 H0、Ωch2 呈正相关，与 S8 呈负相关；P-ACT 数据集对参
// 数的限制最严格（轮廓最窄），且其 fEDE 后验在 0.06 至
// 0.08 处存在一个真实的小峰，表明在该模型下 P-ACT 对 EDE
// 有轻微的偏好。
#figure(image("imgs/fig12.png"),
  caption: [
    Marginalized contours at 68% and 95% confidence for the EDE fraction showing (well-known) positive correlations with $H_0$, $Omega_c h^2$, and $S_8$ for different dataset combinations (ACT~in blue, W-ACT~in brown, and P-ACT~in navy). The small bump in the marginalized $f_("EDE")$ posterior for P-ACT~is real and arises from the mild EDE improvement in $chi^2$ over $Lambda$CDM in this model --- see Table~#ref(<table:ede_chi2>, supplement: none).
  ],
  placement: top,
)
<fig:ede_base_triangle>

// [figvision-cn] imgs/fig13.png
// 这是一张三角图（corner plot，也称三角相图），用于展示
// 四个宇宙学参数的后验概率分布及其两两相关性约束。图由四
// 个参数构成：H0（单位为 km/s/Mpc）、Ωch2、S8 和 fEDE。
// 图中包含三个数据集的约束结果：W-ACT-LB（灰色）、
// P-ACT-LB（紫色）和 P-ACT-LB-S8（蓝色）。图例位于右上角，
// 用灰色、紫色和蓝色色块分别标识这三个数据集。图中所有等
// 值线（二维）均采用两档填充：内层较深色区域通常对应 68%
// 置信区间，外层较浅色区域对应 95% 置信区间，各数据集的
// 填充色与图例一致。 对角线上的四个子图为各参数的一维边
// 缘后验概率密度曲线，纵轴为概率密度（无刻度标签）。左上
// 角第一行第一列的子图为 H0 的一维分布，横轴范围约为 65
// 到 80，曲线峰值约在 69 km/s/Mpc 处；W-ACT-LB 灰线峰值
// 最高，P-ACT-LB 紫线略低，P-ACT-LB-S8 蓝线次之，且蓝线
// 分布的右侧尾部比紫线和灰线更短。第二行第二列的子图为 Ω
// ch2 的一维分布，横轴范围约为 0.115 到 0.145，峰值在
// 0.125 附近；灰线和紫线的峰值更高、分布较窄，蓝线峰值向
// 右微移且分布展宽，其右侧尾部延伸更远。第三行第三列的子
// 图为 S8 的一维分布，横轴范围约为 0.78 到 0.87，峰值在
// 0.82 到 0.84 之间；蓝线峰值位于三者中最左端，灰线略向
// 右移，紫线峰值最靠右，三条曲线在峰值附近略有交叠。第四
// 行第四列的子图为 fEDE 的一维分布，横轴范围约为 0.0 到
// 0.2，三条曲线均呈左偏分布，峰值在 0.03 到 0.06 之间；
// 蓝线分布最宽、峰值最高，灰线次之，紫线最窄且峰值最低，
// 三者右侧尾部均延伸至 0.15 以上。 非对角线子图为两两参
// 数的二维后验等值线图，横坐标和纵坐标分别对应所在行和列
// 的参数。第二行第一列的子图为 Ωch2 对 H0 的约束，纵轴范
// 围约为 0.115 到 0.145，横轴范围约为 65 到 80。三个数据
// 集的等值线均呈沿正相关方向的椭圆形（右上倾斜）；灰线范
// 围最宽，紫线稍窄并向高 H0 方向延伸，蓝线区域面积最小、
// 最紧凑。第三行第一列的子图为 S8 对 H0 的约束，纵轴范围
// 约为 0.78 到 0.87。灰线等值线覆盖约 0.80 到 0.86 的 S8
// 区间，向低 S8 方向延伸较宽；紫线等值线形状类似，其等高
// 线中心略偏右上方；蓝线等值线面积最小，局限在约 0.80 到
// 0.83 的 S8 和 67 到 71 的 H0 区域内。第三行第二列的子
// 图为 S8 对 Ωch2 的约束，横轴范围约为 0.115 到 0.145。
// 三个数据集的等值线沿正相关方向延伸，形状扁平；灰线区域
// 最大，紫线区域在低 Ωch2 端较窄，蓝线区域最小。第四行第
// 一列的子图为 fEDE 对 H0 的约束，纵轴范围约为 0.0 到
// 0.25。三个数据集的等值线均呈沿正相关方向的细长条带，灰
// 线和紫线的条带几乎重叠，延伸至 fEDE 约 0.18、H0 约 72
// 的范围；蓝线条带较短窄，中心偏向较低的 H0 和 fEDE 值。
// 第四行第二列的子图为 fEDE 对 Ωch2 的约束，三个数据集的
// 等值线呈正相关方向的细长条带，互有重叠。第四行第三列的
// 子图为 fEDE 对 S8 的约束，横轴范围约为 0.78 到 0.87。
// 灰线等值线呈较宽的椭圆，覆盖面积较大；紫线等值线在 S8
// 方向较窄但沿 fEDE 方向延伸较长；蓝线等值线面积显著缩小，
// 集中在 S8 约 0.80 到 0.84、fEDE 约 0.03 到 0.15 范围内。
// 整体趋势表明，加入额外数据集后约束收紧：灰色和紫色区域
// 较大，蓝色区域在多数参数平面上范围最小，说明
// P-ACT-LB-S8 对参数空间的限制最严格。
#figure(image("imgs/fig13.png"),
  caption: [
    Same as Fig.~#ref(<fig:ede_base_triangle>, supplement: none), tightening the limits with additional datasets (W-ACT-LB~in gray, P-ACT-LB~in purple, and P-ACT-LB -S8 in blue).
  ],
  placement: top,
)
<fig:ede_kitchen_sink>

We also obtain constraints for P-ACT-LB -S8,#footnote[Note that we obtain $S_8 = 0.825 plus.minus 0.011$ for P-ACT-LB; this $S_8$ constraint agrees with that from~@DES_KIDS_shear_2023 at $1.5 sigma$.] which includes an external prior on $S_8$ from the joint analysis of DES-Y3 and KiDS-1000 cosmic shear data~@DES_KIDS_shear_2023, as described in §@sec:glossary. @Hill_2020, who also placed constraints on EDE, validated that a simple Gaussian prior on $S_8$ is a sufficiently accurate approximation to the inclusion of a full weak lensing likelihood in such joint analyses with CMB data (see their Appendix B). The inclusion of $S_8$ significantly tightens the upper limit on EDE (see Fig.~#ref(<fig:ede_kitchen_sink>, supplement: none)), as positive $f_("EDE")$ values increase this parameter above its $Lambda"CDM"$~value (the late-time matter power spectrum amplitude is increased due to increases in $Omega_c h^2$ and $n_s$ in the CMB fit), which is in the opposite direction to the preference in the DES and KiDS data~#cite(<Hill_2020>).

#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    table.header([], [$Delta chi^2$], [Pref. in $sigma$], [$H_0^(( E D E ))$], [$f_("EDE")$], [$log_10 z_c$],),
    table.hline(),
    [ACT], [$approx 0.0$], [0.0], [66.5], [0.012], [3.00],
    [W-ACT], [1.9], [0.5], [69.9], [0.089], [3.55],
    [P-ACT], [$4.3$], [$1.2$], [70.4], [0.091], [3.56],
    [W-ACT-LB], [$2.9$], [$0.8$], [70.2], [0.070], [3.52],
    [P-ACT-LB], [$6.6$], [$1.7$], [71.2], [0.093], [3.56],
  )]
  , caption: [The $Delta chi^2 = chi_(Lambda "CDM")^2 - chi_("EDE")^2$ from the `MFLike` likelihood MAP points for the $n = 3$ EDE model compared to $Lambda$CDM for each dataset combination, and preference (in units of $sigma$) for EDE over $Lambda"CDM"$~using the likelihood-ratio test statistic. The values for $H_0$, $f_("EDE")$, and $log_10 z_c$ in the MAP EDE model are also reported. The data show no significant preference for non-zero EDE. For ACT alone, the MAP $chi^2$ for EDE is indistinguishable from that for $Lambda$CDM within our numerical precision, indicating that adding EDE parameters does not improve the fit at all in this case. ]
  , kind: table
  ) <table:ede_chi2>
Switching now to the $n = 2$ EDE model, for ACT alone, we obtain $f_("EDE") < 0.091$ (95%, ACT) with $H_0 = 67.5_(- 1.5)^(+ 0.9)$~km/s/Mpc. Adding #emph[Planck] yields $f_("EDE") < 0.11$ (95%, P-ACT) with $H_0 = 69.3_(- 1.5)^(+ 1.0)$~km/s/Mpc. Finally, adding CMB lensing and BAO data yields $f_("EDE") < 0.11$ (95%, P-ACT-LB) with $H_0 = 70.1_(- 1.5)^(+ 0.9)$~km/s/Mpc. These results are similar to the $n = 3$ case. A full comparison between the two models is discussed in Appendix~@app:ede_full_constraints.

Some past studies (e.g., #cite(<Herold:2021>, style: "aas_noparen.csl")#cite(<Herold:2022>, style: "aas_noparen.csl")#cite(<Poulin2023EDEreview>, style: "aas_noparen.csl")#cite(<Efstathiou2024EDE>, style: "aas_noparen.csl")) have discussed "projection effects," where, in the $Lambda$CDM limit ($f_("EDE") arrow.r 0$), the additional EDE-specific parameters ($z_c$ and $theta_i$) have no impact. These can bias the Bayesian posterior for $f_("EDE")$. Additionally, the exact choice of the $z_c$ prior range can have a significant effect on the final constraints in this model, as large values of $f_("EDE")$ are allowed if $z_c$ is sufficiently high that no dynamical effects are imprinted on the CMB (i.e., the EDE is irrelevant by the recombination epoch, #cite(<LaPosta2022>, style: "aas_noparen.csl")). Finally, the lower bound of $f_("EDE") = 0$ only allows the model fit to increase $H_0$ or leave it unchanged, not decrease it. Therefore, to evaluate whether the data have a meaningful preference for the EDE model, it is useful to compare the effective $chi^2$ value of the MAP EDE model to that of the $Lambda$CDM model, rather than to solely inspect the Bayesian posteriors, as was done in #cite(<Hill_ACT_EDE>). To maximize the posterior, we use both `Cobaya` and `PROSPECT`, a profile likelihood code that can also be used for accurate global optimization #cite(<Holm:2023uwa>).#footnote[For the posterior maximization procedure, we use the full Boltzmann code `class` rather than the emulators, to obtain high numerical precision.] We then take the global MAP from the different minimizer runs.

Performing this exercise, we find no preference for the EDE model from the DR6 data alone or combined with other datasets, as shown in Table~#ref(<table:ede_chi2>, supplement: none) for the $n = 3$ EDE model. For ACT~alone, we do not find an MAP point for the $n = 3$ EDE model with lower $chi^2$ than that found for $Lambda"CDM"$, i.e., the additional parameters of the EDE model provide no meaningful improvement in goodness-of-fit to the ACT data within our numerical precision. The MAP model is nearly indistinguishable from $Lambda"CDM"$, with $f_("EDE") = 0.012$ (very close to the $Lambda"CDM"$~edge of the parameter space) and $log_10 z_c = 3.00$, the lower edge of our prior, where the impact of EDE on the CMB is minimal. In the other cases, we note that in the EDE model there is a narrow degeneracy direction in the parameter space, where parameters may shift while having very similar effective $chi^2$ values. Nevertheless, in none of the cases do we find the improvement in goodness-of-fit over $Lambda"CDM"$~significant.

Using the $Delta chi^2$ values, we compute the equivalent preference in $sigma$ using the likelihood-ratio test as in~#cite(<Hill_ACT_EDE>).#footnote[Because the $Lambda$CDM model is a subset of the EDE model (with $f_("EDE") = 0$), the $Delta chi^2$ between the best-fit EDE and best-fit $Lambda$CDM models follows a chi-squared distribution with three degrees of freedom, corresponding to the three additional free parameters of the EDE model.] We find that in all cases the preference for EDE over $Lambda"CDM"$~is $< 2 sigma$. The $Delta chi^2$ values for the $n = 2$ case, shown in Appendix~@app:ede_full_constraints, yield the same conclusion.

To further circumvent the problem of projection effects, some past works have used a profile likelihood approach (see, e.g., #cite(<Lewis:2002ah>, style: "aas_noparen.csl")#cite(<Audren2013>, style: "aas_noparen.csl") for more detail). However, the $Delta chi^2$ values that we find between the EDE and $Lambda$CDM MAP models are insignificant; as such, we see no evidence of preference for the EDE model in either a Bayesian or frequentist framework. Thus, we conclude that the significant computational expense of a full profile likelihood analysis is not justified, and is unlikely to affect the interpretation of these results.

== Varying fundamental constants
<sec:varconst>
The dynamics of recombination depends critically on the values of fundamental constants during the decoupling epoch, including the fine-structure constant $alpha_("EM")$ and the electron mass $m_e$. High-precision CMB observations thus allow for constraints on possible variations of these constants over vast scales in both distance and time (see, e.g.,~#cite(<SekiguchiTakahashi2021>, style: "aas_noparen.csl")#cite(<HartChluba2020>, style: "aas_noparen.csl")#cite(<HartChluba2018>, style: "aas_noparen.csl")#cite(<2015AandA...580A..22P>, style: "aas_noparen.csl")#cite(<Menegoni2012>, style: "aas_noparen.csl")#cite(<Scoccola2009>, style: "aas_noparen.csl")#cite(<Martins2004>, style: "aas_noparen.csl")#cite(<Rocha2004>, style: "aas_noparen.csl")#cite(<Battye2001>, style: "aas_noparen.csl")#cite(<Avelino2001>, style: "aas_noparen.csl")#cite(<Avelino2000>, style: "aas_noparen.csl")#cite(<Kaplinghat1999>, style: "aas_noparen.csl")#cite(<Hannestad1999>, style: "aas_noparen.csl")). Furthermore, models featuring fundamental constant variations are amongst the few that have had some phenomenological success in increasing the CMB-inferred Hubble constant~@KnoxMillea2020@SekiguchiTakahashi2021@H0_olympics_2022#cite(<2024JCAP...04..059K>). However, we emphasize that these models are not physical, in the sense that the fundamental constant variation is not driven dynamically by a new field or interaction; we simply assume that $alpha_("EM")$ or $m_e$ can take a different value in the early universe than it does today, which opens degeneracies in the CMB. Recently,~@Baryakhtar2024 have found that a first-principles implementation of varying-constant models can yield rather different conclusions than crude phenomenological models, due to (for example) the impact of perturbations in the field driving the constant-variation, as well as its contribution to the cosmic energy budget. However, for simplicity, here we stick to a phenomenological approach in which $alpha_("EM")$ or $m_e$ are simply allowed to vary, thus testing their values at the CMB epoch as compared to today.

We use the new ACT DR6 power spectra to place updated bounds on possible variation of $alpha_("EM")$ and $m_e$ (considered individually). For simplicity, we assume that the value of $alpha_("EM")$ (or $m_e$) undergoes an instantaneous, step-function transition well after recombination is completed, but well before the reionization epoch (specifically, we choose $z = 50$ for the redshift of this transition). The value of the constant after the transition is fixed to the laboratory-measured value~@ParticleDataGroup:2024cfk, while the value before the transition is taken to be a free parameter. The relevant physical effects on the recombination dynamics are treated via the implementation in `HyRec`~@Hyrec, as incorporated in `class` (note that `CosmoRec`~@Cosmorec includes a similarly accurate treatment of these effects). The dominant physical effects are due to changes in the Thomson scattering cross-section, with $sigma_("T") prop alpha_("EM")^2 m_e^(- 2)$, and changes in the energy levels of atomic hydrogen, with $E prop alpha_("EM")^2 m_e$. Many additional, subtle effects arise due to the non-equilibrium nature of cosmological recombination --- see, e.g.,~@HartChluba2018@Chluba_AliHaimoud2016#cite(<2015AandA...580A..22P>) for a thorough discussion. In general, variations of $alpha_("EM")$ or $m_e$ change the timing of recombination, with higher values of these constants associated with earlier recombination. Thus, such variations change the physical scales imprinted in the CMB power spectrum, including the damping scale. The new ACT DR6 spectra allow tests of these effects in a qualitatively new regime, deep into the damping tail in TT and across a wide range of scales in TE and EE.

As pointed out in~@SekiguchiTakahashi2021, a joint variation of $m_e$ and the spatial curvature $Omega_k$ opens up a particularly significant degeneracy with $H_0$ and other cosmological parameters. In principle, such a model has sufficient freedom to accommodate an increased value of $H_0$ while providing a good fit to not only CMB data, but also late-time measurements of the distance-redshift relation from BAO and SNIa data. Here, we revisit this scenario. In addition, we also consider a model in which both $alpha_("EM")$ and $Omega_k$ are allowed to vary.

=== Electron mass
<sec:var_me>
We parametrize a possible deviation of the electron mass from its present-day value by introducing a free parameter $m_e / m_(e , 0)$, where $m_e$ ($m_(e , 0)$) is the mass at $z > 50$ ($z < 50$, including today). We adopt a flat, uninformative prior: $m_e / m_(e , 0) in [0.3 , 1.7]$. Combining ACT and #emph[Planck], we find $ m_e / m_(e , 0) & = & 0.856_(- 0.073)^(+ 0.060) quad ( 68 % , thin sans("P-ACT") ) , $ whereas #emph[Planck] alone yields $m_e / m_(e , 0) = 0.880_(- 0.080)^(+ 0.068)$. While the P-ACT~result lies $2.4 sigma$ below unity, we find that this is driven mostly by the #emph[Planck] data: ACT alone yields $m_e / m_(e , 0) = 1.02_(- 0.15)^(+ 0.11)$, while combining ACT with #emph[WMAP] yields $ m_e / m_(e , 0) & = & 0.921 plus.minus 0.083 quad ( 68 % , thin sans("W-ACT") ) . $ Interpreting the P-ACT~result as a statistical fluctuation, we further include CMB lensing and DESI BAO data to obtain $ mat(delim: "}", align: #left,
  m_e/m_(e,0) = 1.0096 plus.minus 0.0060;
  H_0 = 69.8 plus.minus 1.1,
) quad (68%, "P-ACT-LB") $ Further adding SNIa data slightly tightens the constraints while moving them closer to $Lambda"CDM"$, giving $m_e / m_(e , 0) = 1.0063 plus.minus 0.0056$ and $H_0 = 69.1 plus.minus 1.0$ (68%, P-ACT-LBS).

These bounds represent the tightest constraints to date on the value of the electron mass at the recombination epoch, now approaching the half-percent level. Here, the BAO data are crucial in breaking severe geometric degeneracies that arise in the primary CMB when the electron mass is allowed to vary (see, e.g.,~#cite(<HartChluba2018>, style: "aas_noparen.csl") and~#cite(<SekiguchiTakahashi2021>, style: "aas_noparen.csl") for detailed discussion). These severe degeneracies also allow much more freedom in the Hubble constant, which increases compared to the value found in $Lambda"CDM"$~when fitting these datasets. Nevertheless, we emphasize again that this model is not physical: no dynamical field has been introduced that drives the evolution of $m_e$. \

=== Electron mass and spatial curvature
<sec:var_me_ok>
@SekiguchiTakahashi2021 noted that variation of the electron mass has the unique property of allowing multiple scales in the CMB to be preserved (in combination with other $Lambda"CDM"$~parameters changing), including the acoustic scale and the damping scale. However, this variation will change the late-time expansion history, which is why the inclusion of BAO data plays a key role in the constraints above. This observation motivates further extending the model to allow freedom to adjust the late-time distance-redshift relation. @SekiguchiTakahashi2021 considered scenarios in which either the spatial curvature or the dark energy equation of state were allowed to vary in addition to $m_e$. They found spatial curvature to yield surprising success in accommodating significant variation of $m_e$ (and hence $H_0$) in fits to #emph[Planck] CMB and BOSS BAO data, a result that was further validated in~#cite(<H0_olympics_2022>).

Here, we revisit this model with the new ACT DR6 spectra. We adopt a uniform prior $Omega_k in [- 0.6 , 0.6]$ and the same prior on $m_e$ used above. We compute theoretical predictions using `class`.

// [figvision-cn] imgs/fig14.png
// 这是一张三角图（corner plot），用于展示三个宇宙学参数
// 的后验概率分布及其两两之间的联合约束。图中包含三个数据
// 集：P-ACT-LB（紫色）、W-ACT-LB（灰色）、P-ACT-LBS（绿
// 色）。图中共有6个子图，按3x3矩阵排列，对角线上为1D边缘
// 概率密度曲线，非对角线上为2D置信区间等高线图。 子图（
// 左上，第1行第1列）：1D边缘概率密度曲线。横轴为H0，范围
// 约63至77，单位未在图中明确标注（通常为km/s/Mpc）。纵轴
// 为概率密度（未标注具体刻度）。紫色曲线峰值约在70.5，灰
// 色曲线峰值约在70.2，绿色曲线峰值约在68.8。绿色曲线最窄，
// 紫色和灰色曲线较宽且重叠较多。该图表明P-ACT-LBS对H0的
// 约束最紧，且中心值略低于另外两个数据集。 子图（中上，
// 第1行第2列）：空白区域，无数据。 子图（右上，第1行第3
// 列）：空白区域，无数据。 子图（左中，第2行第1列）：2D
// 联合约束等高线图。横轴为H0，范围约63至77；纵轴为me/me,
// 0，范围约0.96至1.07。紫色、灰色、绿色分别显示1σ和2σ置
// 信区间（填充色深浅表示）。三个数据集的置信椭圆均呈右上
// -左下倾斜，表明H0与me/me,0存在正相关。绿色椭圆最小且最
// 靠左下，紫色椭圆最大且最靠右上。该图表明P-ACT-LBS对这
// 两个参数的联合约束最强，且倾向于较低的H0和me/me,0值。
// 子图（正中，第2行第2列）：1D边缘概率密度曲线。横轴为me
// /me,0，范围约0.98至1.06。纵轴为概率密度。紫色曲线峰值
// 约在1.03，灰色曲线峰值约在1.02，绿色曲线峰值约在1.01。
// 绿色曲线最窄，紫色和灰色曲线较宽。该图表明P-ACT-LBS对
// me/me,0的约束最紧，且中心值最接近1.0。 子图（右中，第2
// 行第3列）：空白区域，无数据。 子图（左下，第3行第1列）：
// 2D联合约束等高线图。横轴为H0，范围约63至77；纵轴为Ωk，
// 范围约-0.015至0.015。三个数据集的置信椭圆均呈左上-右下
// 倾斜，表明H0与Ωk存在负相关。绿色椭圆最小且最靠左下，紫
// 色椭圆最大且最靠右上。该图表明P-ACT-LBS对这两个参数的
// 联合约束最强，且倾向于较低的H0和负的Ωk值。 子图（中下，
// 第3行第2列）：2D联合约束等高线图。横轴为me/me,0，范围
// 约0.98至1.06；纵轴为Ωk，范围约-0.015至0.015。三个数据
// 集的置信椭圆均呈左上-右下倾斜，表明me/me,0与Ωk存在负相
// 关。绿色椭圆最小且最靠左下，紫色椭圆最大且最靠右上。该
// 图表明P-ACT-LBS对这两个参数的联合约束最强，且倾向于较
// 低的me/me,0和负的Ωk值。 子图（右下，第3行第3列）：1D边
// 缘概率密度曲线。横轴为Ωk，范围约-0.015至0.015。纵轴为
// 概率密度。紫色曲线峰值约在-0.005，灰色曲线峰值约在
// -0.003，绿色曲线峰值约在0.002。绿色曲线最窄，紫色和灰
// 色曲线较宽。该图表明P-ACT-LBS对Ωk的约束最紧，且中心值
// 略高于另外两个数据集，接近0。 总体而言，该图展示了在允
// 许电子质量随时间变化且空间曲率非零的非物理模型下，不同
// 数据集对H0、me/me,0和Ωk的约束能力。P-ACT-LBS（绿色）在
// 所有参数上均给出了最紧的约束，且其中心值与另外两个数据
// 集存在一定偏移，表明该模型在CMB和BAO数据中打开了显著的
// 简并性。
#figure(image("imgs/fig14.png"),
  caption: [
    Constraints on a (non-physical) model with time variation of the electron mass and non-zero spatial curvature. This model opens up significant degeneracies in the CMB (and BAO) data. A joint fit to P-ACT-LB~yields a higher value of $H_0$ than in $Lambda"CDM"$, but with a much larger error bar; the same behavior is seen for W-ACT-LB, indicating that the results are not specific to #emph[Planck]. However, inclusion of SNIa data (P-ACT-LBS, green) pushes the results toward $Lambda"CDM"$, disfavoring this approach for increasing the cosmologically-inferred value of $H_0$.
  ],
  placement: top,
)
<fig:me_Omegak_H0>

We find that this two-parameter extension of $Lambda"CDM"$~is highly unconstrained in fits to CMB data alone. We thus focus solely on joint analyses of CMB and late-time data here, with results shown in Fig.~#ref(<fig:me_Omegak_H0>, supplement: none). Our baseline dataset combination yields $ mat(delim: "}", align: #left,
  m_e/m_(e,0) = 1.022 plus.minus 0.016;
  Omega_k = -0.0031 plus.minus 0.0037;
  H_0 = 71.0 plus.minus 1.7,
) quad (68%, "P-ACT-LB") $ While neither non-standard $m_e$ or non-flat $Omega_k$ are detected on their own in this fit, their combined impact allows $H_0$ to take on higher values, consistent with earlier results from @SekiguchiTakahashi2021#cite(<H0_olympics_2022>). To assess the additional constraining power contributed by ACT, note that the error bar on $H_0$ in our P-ACT-LB~analysis is roughly $20 %$ smaller than that found for the same model using #emph[Planck] and BOSS BAO data~#cite(<H0_olympics_2022>). We verify that these results are not driven by the high CMB lensing amplitude in #emph[Planck] by replacing #emph[Planck] with #emph[WMAP] in the dataset combination, finding $ mat(delim: "}", align: #left,
  m_e/m_(e,0) = 1.014 plus.minus 0.015;
  Omega_k = 0.0001 plus.minus 0.0042;
  H_0 = 70.4 plus.minus 1.7,
) quad (68%, "W-ACT-LB") $

The parameter posteriors in these fits are significantly broadened compared to those obtained in $Lambda"CDM"$~(cf.~$H_0 = 68.22 plus.minus 0.36$ for P-ACT-LB~in L25) or $Lambda"CDM"$+$Omega_k$. For comparison, we find $Omega_k = 0.0019 plus.minus 0.0015$ for P-ACT-LB~in §@sec:curv; this bound is weakened by more than a factor of two in the model studied here. Although the central values of some parameters shift compared to $Lambda"CDM"$, the significance of the shifts is counteracted by the increased error bars, and we find that this model does not yield a significant improvement in goodness-of-fit over $Lambda"CDM"$. For the MAP model obtained for P-ACT-LB~(W-ACT-LB), we find $Delta chi^2 = - 2.4$ ($- 1.5$) with respect to $Lambda"CDM"$, with two additional free parameters. These values correspond to a $1.0 sigma$ or $0.7 sigma$ preference over $Lambda"CDM"$, respectively, neither of which is significant.

It is also worth noting that the DESI BAO data play an important role in the central value of the $H_0$ posterior here (and in other models studied in this work). Due to the computational expense of running MCMC chains for this model (which is extremely slow to evaluate in `class`), we use importance-sampling with an approximate version of the BOSS BAO likelihoods to assess how the results would shift if DESI were replaced with BOSS. We find that the central value of the $H_0$ posterior shifts downward by 1--1.5 km/s/Mpc, while the electron mass and spatial curvature shift closer to their $Lambda"CDM"$~values. The error bars on all quantities increase only slightly. Thus, we conclude that the central values of the above parameter constraints are partially driven by the DESI BAO data.

Furthermore, we find that a joint analysis with PantheonPlus SNIa data pulls all parameters toward their $Lambda"CDM"$~values, while tightening the error bars compared to the P-ACT-LB~results: $ mat(delim: "}", align: #left,
  m_e/m_(e,0) = 1.004 plus.minus 0.013;
  Omega_k = 0.0008_(-0.0036)^(+0.0032);
  H_0 = 68.9 plus.minus 1.4,
) quad (68%, "P-ACT-LBS") $ Notably, the $H_0$ value in this fit is fully consistent with its $Lambda"CDM"$~value. From the joint analysis of P-ACT-LBS~and the insignificant improvement in quality of fit to P-ACT-LB, we conclude that there is no evidence for a scenario with spatial curvature and a non-standard electron mass at recombination. The possibility of obtaining a high value of $H_0$ from cosmological data in this model is significantly reduced by these new results.

=== Fine-structure constant
<sec:var_a>
As done above for the electron mass, we parametrize possible deviation of the fine-structure constant from its present-day value by introducing a free parameter $alpha_("EM") / alpha_(E M , 0)$, where $alpha_("EM")$ ($alpha_(E M , 0)$) is the value at $z > 50$ ($z < 50$, including today). We adopt a flat, uninformative prior: $alpha_("EM") / alpha_(E M , 0) in [0.6 , 1.4]$. Combining ACT and #emph[Planck], we find $ alpha_("EM") / alpha_(E M , 0) & = & 1.0037 plus.minus 0.0017 quad ( 68 % , thin sans("P-ACT") ) , $ representing a 30% reduction in the error bar compared to that from #emph[Planck] alone, which yields $alpha_("EM") / alpha_(E M , 0) = 1.0005 plus.minus 0.0025$ (consistent with #cite(<HartChluba2020>, style: "aas_noparen.csl")). ACT alone yields $alpha_("EM") / alpha_(E M , 0) = 1.0046 plus.minus 0.0035$.

Further including CMB lensing and DESI BAO data yields $ alpha_("EM") / alpha_(E M , 0) & = & 1.0043 plus.minus 0.0017 thin thin ( 68 % , thin sans("P-ACT-LB") ) , med med $ thus fluctuating $approx 2.5 sigma$ above unity. Inclusion of SNIa data has negligible effect on this result. As higher $alpha_("EM")$ corresponds to earlier recombination, this result also yields a moderate increase in the Hubble constant, with $H_0 = 69.27 plus.minus 0.54$ km/s/Mpc. Interpreting this result as a statistical fluctuation, these bounds represent the tightest constraints to date on the value of the fine-structure constant at the recombination epoch, approaching the per-mille level.

=== Fine-structure constant and spatial curvature
<sec:var_a_ok>
Unlike the electron mass, variation of the fine-structure constant (in combination with other parameters) can not simultaneously preserve all of the relevant physical scales in the CMB power spectrum; this is largely why the constraints on $alpha_("EM")$ above are tighter than those on $m_e$. This is also why the Hubble constant cannot increase as significantly when varying $alpha_("EM")$ as when varying $m_e$~#cite(<SekiguchiTakahashi2021>). For completeness, and to better understand the results found above for the $m_e$+$Omega_k$ model, here we consider extending the varying-$alpha_("EM")$ model to also allow the spatial curvature to vary. This allows further freedom in the late-time expansion history, allowing wider range of parameter variations to be accommodated in fits to CMB and BAO data.

As above, we compute theoretical predictions for this model using `class`. We adopt an uninformative prior $Omega_k in [- 0.6 , 0.6]$, while allowing $alpha_("EM")$ to vary as in our previous analysis.

As expected, we find that this two-parameter extension is far less degenerate than the $m_e$+$Omega_k$ model studied above. Focusing for simplicity solely on the P-ACT-LB~dataset combination, we find $ mat(delim: "}", align: #left,
  alpha_("EM")/alpha_("EM,0") = 1.0041 plus.minus 0.0017;
  Omega_k = 0.0007 plus.minus 0.0015;
  H_0 = 69.4 plus.minus 0.6,
) quad (68%, "P-ACT-LB") $

Comparing to the results above, it is evident that the constraint on $alpha_("EM")$ is essentially unchanged by the opening of the spatial curvature, which itself is also tightly constrained near zero. Likewise, $H_0$ hardly changes, with the analogous result for fixed spatial curvature yielding $H_0 = 69.3 plus.minus 0.5$~km/s/Mpc.

Contrasting the varying-$alpha_("EM")$ results with the varying-electron-mass case, we find that the degeneracy structure of the two models is remarkably different, with the electron mass possessing much more flexibility in accommodating a wide range of parameter space than the fine-structure constant, consistent with~@HartChluba2018@HartChluba2020#cite(<SekiguchiTakahashi2021>).#footnote[A similar result is found for the small-scale baryon clumping scenario studied in §@sec:pmf --- allowing $Omega_k$ to vary also has little degeneracy with the clumping parameter constraint.] Nevertheless, we note again that all of the varying-constant models studied here are not physical, but rather simply crude phenomenological approximations. These results may be a useful guide in constructing physical models that can achieve similar flexibility in accommodating a wide range of data. \

== Primordial magnetic fields
<sec:pmf>
The existence of primordial magnetic fields (PMFs) is a compelling possibility. Such PMFs could cause inhomogeneities in the baryon distribution around recombination. Thus, the PMF model is an example of a slightly more generic scenario known as "baryon clumping"~@Jedamzik2011#cite(<Jedamzik2019>). Primordial magnetic fields with a blue-tilted power spectrum can naturally have kpc-scale correlation lengths. Once the photon gas dynamically decouples from the baryon fluid on small scales, the magnetic force causes efficient growth of baryon density perturbations to potentially $cal(O) ( 1 )$ contrasts. These kpc-scale perturbations are not directly resolvable in CMB observations, but they cause accelerated recombination due to the quadratic source term in the equation describing the recombination rate~#cite(<1968ApJ...153....1P>). The corresponding decrease in the sound horizon could then partially reconcile CMB-based determinations of the Hubble constant with local universe measurements~#cite(<Jedamzik2020>). As magnetic fields are part of the standard model and their generation during early-universe phase transitions is conceivable, PMFs (or baryon clumping models in general) are a well-motivated scenario to potentially increase the CMB-inferred Hubble constant.#footnote[Note that effects due to Faraday rotation~@2022PhRvD.105f3536C are not considered here and are expected to yield weaker constraints on such models~#cite(<2019PhRvD.100b3507P>).]

Baryon clumping induces changes in the Silk damping tail in addition to the leading-order geometric effect described above. Two counteracting effects are at play~#cite(<Jedamzik2011>): shortened photon diffusion due to accelerated hydrogen recombination suppresses Silk damping, but the previously accelerated helium recombination decreases the ionization fraction and thus increases the damping. These two effects do not generally cancel, and empirically the first one appears to be dominant~#cite(<Thiele2021>). Thus, the high-resolution ACT DR6 data with good signal-to-noise in the damping tail enable stringent constraints on baryon clumping scenarios.

Theoretical modeling of PMF-induced baryon clumping is non-trivial. We adopt a simplified model used in earlier works~@Jedamzik2020@Thiele2021@Rashkovetskyi2021@Galli2022#cite(<Jedamzik2023>). The baryon density distribution function is sampled by three zones in each of which the baryon density is taken as a constant. Taking the zones as indexed by $i = 1 , 2 , 3$, each zone carries a volume fraction $f_i$ and a baryon density $Delta_i equiv rho_(b , i) / chevron.l rho_b chevron.r$. Volume and mass conservation imply the constraints $sum f_i = sum f_i Delta_i = 1$. For each zone, the recombination history is computed separately and the thermal history is then taken as the volume-weighted average over the three zones. This treatment neglects Ly$alpha$ photon mixing~#cite(<Jedamzik2023a>).

Within the three-zone model, we choose to work with the "M1" scenario of~#cite(<Jedamzik2020>): $f_2 = 1 / 3$, $Delta_1 = 0.1$, $Delta_2 = 1$. After applying the constraints described above, the model thus has only a single free parameter, the variance $b$ of the small-scale baryon density fluctuations $ 1 + b equiv sum_i f_i Delta_i^2 thin . $

Recent perturbative and simulation-based works have suggested refinements of this simplified treatment~@Lee2021#cite(<Jedamzik2023a>). @Jedamzik2025 recently presented constraints on primordial magnetic fields using a simulation-informed model for the recombination history. Where comparisons can be made between this method and our three-zone model, there is a remarkably close agreement between the two approaches. In particular, the posteriors for $H_0$ in~@Jedamzik2025 are similar to results found for the three zone-model.

In the absence of a more accurate publicly available model and in order to facilitate comparison with previous constraints, we choose to continue working with the three-zone model. However, we stress that our constraints are to be interpreted in the context of this model and further work will be needed to evaluate the viability of baryon clumping scenarios more generally. Nevertheless, previous work has indicated that increasing the flexibility of the model does not substantially alter the constraint on $b$ or $H_0$~#cite(<Thiele2021>).

// [figvision-cn] imgs/fig15.png
// 这是一张三角图（corner plot），用于展示两个参数（b 和
// H0）的后验概率分布及不同数据集之间的比较。图中包含三个
// 子图：左上方的边缘概率密度曲线图、左下方的二维等高线图
// （置信区间图）、右下方的边缘概率密度曲线图。右上角为图
// 例区域。 图例（右上角方框）：包含三项。深蓝色实心方块
// 标注为“P-ACT”；紫色实心方块标注为“P-ACT-LB”；灰色虚线
// 标注为“Planck(w lens) + SPT [Galli+22]”。 子图（左上方）：
// 曲线图。横轴为参数 b，范围从 0 到 0.7，无单位（或未标
// 注单位）。纵轴为概率密度，无刻度标签。图中包含三条曲线：
// 深蓝色实线（P-ACT）在 b 约 0.2 处达到峰值，曲线较窄；
// 紫色实线（P-ACT-LB）在 b 约 0.25 处达到峰值，曲线略宽
// 于深蓝色线；灰色虚线（Planck+SPT）在 b 约 0.2 处达到峰
// 值，但其右侧尾部明显比前两条曲线更厚，在 b > 0.4 的区
// 域仍保持较高概率密度。三条曲线的峰值位置相近，但灰色虚
// 线在 b 较大区域有显著的非零概率，而深蓝和紫色曲线在 b
// > 0.5 后迅速趋近于零。 子图（左下方）：二维等高线图。
// 横轴为参数 b，范围从 0 到 0.7，与左上图共享横轴。纵轴
// 为参数 H0，范围从 67 到 71，刻度标签为 67、68、69、70、
// 71。图中包含两组填充椭圆等高线。深蓝色填充区域（P-ACT）
// 由内向外颜色变浅，表示 68% 和 95% 置信区间，其中心约在
// (b=0.2, H0=68.0)，椭圆沿对角线方向延伸，显示 b 与 H0
// 存在正相关趋势。紫色填充区域（P-ACT-LB）同样由内向外颜
// 色变浅，中心约在 (b=0.25, H0=69.5)，其椭圆范围比深蓝色
// 区域更大，且整体向右上方偏移。两个区域的置信区间有部分
// 重叠，但中心位置明显不同，紫色区域的 H0 值系统性高于深
// 蓝色区域。 子图（右下方）：曲线图。横轴为参数 H0，范围
// 从 67 到 71，刻度标签为 67、68、69、70、71，与左下图共
// 享纵轴。纵轴为概率密度，无刻度标签。图中包含两条曲线：
// 深蓝色实线（P-ACT）在 H0 约 68.0 处达到峰值；紫色实线
// （P-ACT-LB）在 H0 约 69.0 处达到峰值。两条曲线形状相似，
// 宽度相近，但紫色曲线整体向右偏移约 1 个单位。 图中传达
// 的趋势与结论：P-ACT 和 P-ACT-LB 两个数据集对参数 b 的
// 约束均集中在较低值（约 0.2-0.25），且没有显示存在小尺
// 度重子聚集（b 值显著大于 0）的证据，这与图注中“No
// evidence of clumping is seen in our analysis”一致。然
// 而，两个数据集对 H0 的约束存在明显差异，P-ACT-LB 给出
// 的 H0 值更高。与灰色虚线（Planck+SPT）相比，P-ACT 和
// P-ACT-LB 对 b 的约束更严格，尤其是在 b 较大的区域排除
// 了高概率密度。
#figure(image("imgs/fig15.png"),
  caption: [
    Constraints on the variance $b$ of the small-scale baryon density distribution at recombination from P-ACT~(navy) and P-ACT-LB~(purple), compared with the latest results from ~(including CMB lensing) combined with SPT small-scale polarization (gray dashed line). Primordial magnetic fields would induce baryon clumping on small scales, and hence $b > 0$. No evidence of clumping is seen in our analysis.
  ],
  placement: top,
)
<fig:pmfs>

Figure~#ref(<fig:pmfs>, supplement: none) shows our constraints on the clumping parameter and the Hubble constant, from primary CMB data alone and in combination with CMB lensing and BAO data. We find that the constraint on $b$ is tightened compared to previous analyses: $ b thin & < & thin 0.41 med ( 95 % , sans("P-ACT") ) ,\
thin & < & thin 0.44 med ( 95 % , sans("P-ACT-LB") ) thin . $ For comparison, the #emph[Planck] primary CMB alone constrains $b < 0.51$, and the combination of ~(including CMB lensing) plus SPT-3G gives results consistent with our P-ACT~measurement~#cite(<Galli2022>). If we combine all three datasets (ACT, #emph[Planck], and the public SPT-3G data), there is only a marginal improvement on P-ACT.

Note that the posteriors including ACT data peak at non-zero $b$; thus the improvement in constraining power is larger than what is suggested by comparing the upper limits. As quantified by the standard deviation in $b$, adding ACT~improves upon the -only constraint by about $30 %$. We find no detection of baryon clumping and hence further restrict this model's ability to increase the CMB-inferred $H_0$ value: we find $H_0 = 68.6 plus.minus 0.7$~km/s/Mpc and $H_0 = 69.1 plus.minus 0.5$~km/s/Mpc for P-ACT~and P-ACT-LB~in this model, respectively.

In contrast to the seemingly similar model with varying electron mass, we find that the inclusion of spatial curvature as a free parameter does not appreciably change the $H_0$ posterior in the P-ACT-LB~data combination (see §@sec:var_me_ok for contrasting results in the varying-electron-mass case). The non-trivial small-scale effects in the baryon clumping model constrain $b$ beyond the information contained in the geometric sound-horizon modification.

== Temperature of the CMB
<sec:tcmb>
Several studies @Ivanov:2020mfr@Wen:2020txi@Hill:2023wda have explored the possibility of increasing the CMB-anisotropy-inferred value of the Hubble constant by changing the CMB monopole temperature, $T_("CMB")$. In particular, @Ivanov:2020mfr highlighted a strong negative degeneracy in the $H_0$-$T_("CMB")$ plane when the monopole temperature is left free in analyses of #emph[Planck] data. Setting a SH0ES prior on $H_0$ would then yield a temperature measurement $3 sigma$ lower than the combined measurement of $T_("CMB") = 2.72548 plus.minus 0.00057$~K~@Fixsen2009 from #emph[COBE/FIRAS] and other data.#footnote[Note that the error bar on $T_("CMB")$ from~@Fixsen2009 is sufficiently small that this value is taken as a fixed constant in analyses of $Lambda"CDM"$~(and the extended models studied in this paper).]

Obtaining a higher value of $H_0$ via a decrease in the monopole CMB temperature is difficult. Models with some level of post-recombination reheating can have an impact by allowing a lower value of the monopole temperature in the early universe (e.g.,~#cite(<Hill:2023wda>, style: "aas_noparen.csl") propose to convert a fraction of DM into photons during the dark ages). However, although such a process is straightforward to implement in a phenomenological way, it is hard to find a well-grounded physical mechanism to motivate it such that the blackbody spectrum is preserved #cite(<Chluba:2014wda>).

Nevertheless, these studies have led to the realization that current CMB anisotropy data in combination with BAO data provide, on their own, a powerful probe of the amount of radiation in the universe.#footnote[Note that it is important to self-consistently vary the calibration of the CMB anisotropy data in such analyses, as explained in~#cite(<Ivanov:2020mfr>).] A single-parameter extension to the $Lambda$CDM model, where $T_("CMB")$ is left free, is well constrained. @Ivanov:2020mfr combine #emph[Planck] 2018 CMB anisotropy and lensing data with BOSS DR12 BAO data @eBOSS:2017cqx and find $T_("CMB") = 2.706_(- 0.020)^(+ 0.019)$~K (68% CL). Updating this #emph[Planck] result including BAO from DESI, we find a slightly tighter constraint, $T_("CMB") = 2.696 plus.minus 0.017 med "K"$. With the addition of the new ACT DR6 spectra, we find a similar constraint $ T_("CMB") & = 2.698 plus.minus 0.016 thin "K" thin thin ( 68 % , sans("P-ACT-LB") ) . $ This $0.6 %$ measurement of $T_("CMB")$ is consistent with the direct #emph[COBE/FIRAS] monopole measurement. The corresponding constraint on $H_0$ is consistent with the result in $Lambda"CDM"$, as shown in Fig.~#ref(<fig:Tcmb>, supplement: none). \

// [figvision-cn] imgs/fig16.png
// 这是一张显示二维参数约束的等高线图，用于展示宇宙学参数
// \(T_{\rm CMB}\)（宇宙微波背景单极温度）和 \(H_0\)（哈
// 勃常数）之间的联合置信区间。图中坐标轴为线性刻度，横轴
// 为 \(H_0\)，单位为 km/s/Mpc，范围从 62 到 75（标度间隔
// 为 2）；纵轴为 \(T_{\rm CMB}\)，单位为 K，范围从 2.5
// 到 2.85（标度间隔为 0.1，标有 2.5、2.6、2.7、2.8）。图
// 中数据通过两个填充颜色的置信椭圆区域呈现，通常代表 68%
// 和 95% 的置信水平。第一个是深海军蓝色的长条形区域，标
// 注为“P-ACT”（位于左下角），该约束呈现为一个向左上至右
// 下延伸的狭长椭圆，未在图中完全闭合（部分超出坐标范围），
// 显示出这两个参数之间存在强烈的退化（负相关性）。第二个
// 是紫色的、更紧凑的同心椭圆区域，标注为“P-ACT-LB”，该区
// 域大致位于 \(H_0 \approx 68.5\) km/s/Mpc 和 \(T_{\rm
// CMB} \approx 2.71\) K 附近，并对两个参数给出了更精确的
// 独立约束。图中包含两条垂直和水平的灰色虚线，垂直虚线位
// 于 \(H_0 = 68.1\) km/s/Mpc 处，水平虚线位于 \(T_{\rm
// CMB} = 2.725\) K 处（即 COBE/FIRAS 测量值），这两条线
// 的交点恰好落在紫色 P-ACT-LB 区域的中心附近，表明对于固
// 定 \(T_{\rm CMB}\) 的标准模型（\(\Lambda\)CDM）结果与
// 该测量一致。
#figure(image("imgs/fig16.png"),
  caption: [
    Constraints on the CMB monopole temperature ($T_("CMB")$) and $H_0$. The P-ACT-LB~combination (purple) effectively breaks the degeneracy between these two parameters present in CMB-only analyses (navy) and gives a tight measurement of both parameters, similar to that achieved with CMB data from #emph[Planck] in previous literature. The results are consistent with the $Lambda$CDM case, in which $T_("CMB")$ is fixed to the #emph[COBE/FIRAS] value (gray dashed lines).
  ],
  placement: top,
)
<fig:Tcmb>

== Modified recombination history
<sec:modrec>
In this subsection, we present a model-independent reconstruction of the cosmological recombination history, including ACT DR6 data. Modifications to the standard recombination history have been extensively studied, both as a powerful test of the standard cosmological model and as a potential avenue to increase the value of the Hubble constant inferred from CMB observations~@Lee:2022gzh@Lynch:2024gmp@Lynch:2024_desi@Pogosian:2024ykm#cite(<Mirpoorian:2024fka>). To investigate such modifications, we use the `ModRec` model developed in~@Lynch:2024gmp, which parametrizes departures in the ionization fraction, $X_(upright("e")) ( z ) equiv n_(upright("e")) ( z ) / n_("H") ( z )$, from the standard recombination history, where $n_(upright("e")) ( z )$ and $n_("H") ( z ) = n_("HI") ( z ) + n_("HII") ( z )$ are the number densities of free electrons and hydrogen nuclei, respectively. While phenomenological, the flexible parametrization employed by `ModRec` effectively captures a broad range of physical scenarios, including the effects of primordial magnetic fields, time-varying electron mass, and dark matter annihilation~@Lynch:2024gmp, all of which are also studied separately elsewhere in this paper.

Following~@Lynch:2024gmp, we parameterize departures from the standard ionization fraction $Delta X_(upright("e")) ( z ) = X_(upright("e")) ( z ) - X_(upright("e"))^(upright("std")) ( z )$ at seven control points spanning $z = 533$ to $1600$, leaving reionization and helium recombination unchanged. These control points are interpolated using a cubic spline that enforces physical bounds, $0 lt.eq X_(upright("e")) ( z ) lt.eq X_(upright("e"))^(upright("max"))$, where $X_(upright("e"))^(upright("max"))$ is the maximum allowed ionization fraction. We compute all theoretical predictions using the `class` implementation of `ModRec`, with precision parameters and settings described in Appendix~@app:theory. Our control points and their priors are identical to those used in~#cite(<Lynch:2024_desi>, form: "prose")#cite(<Lynch:2024gmp>).

We present constraints on the `ModRec` model using the Planck-LB~and P-ACT-LB~datasets --- we do not show or discuss discuss P-ACT~alone as BAO data are essential for breaking degeneracies between the modified recombination parameters and standard cosmological parameters~#cite(<Lynch:2024gmp>). We show results for both DESI and BOSS BAO datasets, as the choice of BAO data impacts the reconstructed $X_e ( z )$ due to differences in the inferred values of $r_d H_0$ and $Omega_m$ between BOSS and DESI measurements, assuming $Lambda$CDM~@Lynch:2024_desi#cite(<Pogosian:2024ykm>).

Figure~#ref(<fig:modrec_Xe_recon>, supplement: none) shows the mean and 95% two-tailed CL~constraints on the reconstructed ionization fraction as a function of redshift. Including ACT DR6 data significantly improves the constraints on $X_e ( z )$, with a factor of two reduction in the uncertainty of the highest redshift ($z approx 1467$) control point.#footnote[The modified recombination history cosmology in Fig.~#ref(<fig:spec>, supplement: none) is obtained by selecting a sample from the Planck-LB~chain that has at least a 20% difference in the highest-redshift ionization fraction relative to the standard recombination history and a $Delta chi^2 < 1$ compared to the chain's best-fit cosmology.] This improvement arises because modifications to the ionization fraction impact the polarization and damping tail of the CMB~@Hadzhiyska:2018mwh#cite(<Lynch:2024gmp>). The reconstructed recombination histories are consistent with the standard recombination scenario (black dashed lines).#footnote[The standard recombination history is computed using the best-fit $Lambda$CDM parameters from the P-ACT-LB~dataset. Using the best-fit parameters from other datasets considered in this work has negligible impact on the predicted $X_e ( z )$.]

// [figvision-cn] imgs/fig17.png
// 这是一张由四个纵向排列的子图组成的科学论文插图，展示了
// 宇宙电离分数随红移变化的曲线图。四个子图共享横轴，横轴
// 名称为“z”（红移），范围从约780到1620，刻度标记为800、
// 1000、1200、1400、1600，无单位。纵轴名称为“\(X_e(z)\)”
// （电离分数），取值范围从0.0到1.0，刻度标记为0.0、0.5、
// 1.0。 图中包含统一的图例（见于最上方子图左上角）：橙色
// 实线表示“Mean and 95% CL”（均值及95%置信水平），橙色圆
// 点表示“Control Points”（控制点），黑色虚线表示“
// Standard Recombination”（标准复合）。每个子图均包含一
// 条位于黑色虚线下方的彩色实线（带浅色阴影区域），代表重
// 构的均值及其95%置信区间，并散布着若干彩色圆点（控制点）。
// 所有曲线均从z=800处接近0.0开始，随z增加而上升至1.0附近。
// 子图(a)（最上方）：右下角标注文字为“Planck-LB”。曲线颜
// 色为橙色（对应图例中的均值及95%CL）。黑色虚线标示标准
// 复合历史，从z=800处约0.0平滑上升至z=1600处的1.0。橙色
// 实线起点为（约800, 0.0），在z约1200处上升至约0.28，在z
// 约1380处达到约0.72，随后趋于平缓，在z约1480处达到约
// 0.78，最终在z约1600处达到约0.98。橙色阴影区域（95%置信
// 区间）在z约1400至1500处较宽（上限约0.95，下限约0.60），
// 表示该区间不确定性较大。曲线在z约1450至1550之间高于黑
// 色虚线，之后低于黑色虚线。橙色圆点（控制点）分布在z=
// 800、约940、约1080、约1200、约1480处。 子图(b)（由上往
// 下第二张）：右下角标注文字为“P-ACT-LB”。曲线颜色为紫色。
// 黑色虚线同样从0上升至1.0。紫色实线起点为（约800, 0.0），
// 在z约1200处上升至约0.30，在z约1320处达到约0.62，在z约
// 1450处达到约0.96，最终在z约1600处达到约1.0。紫色阴影区
// 域在z约1300至1450之间较宽（上限约0.98，下限约0.60）。
// 曲线在z约1350之后高于黑色虚线，之后低于黑色虚线。紫色
// 圆点分布在z=800、约940、约1080、约1200、约1320、约1460
// 处。 子图(c)（由上往下第三张）：右下角标注文字为“
// Planck-LB\(_{BOSS}\)”。曲线颜色为橙色。曲线形状与控制
// 点位置与子图(a)几乎相同。橙色实线同样在z约1380处达到约
// 0.72，随后趋于平缓，在z约1480处达到约0.78，最终在z约
// 1600处达到约0.98。橙色阴影区域同样在z约1400至1500处较
// 宽。橙色圆点分布在z=800、约940、约1080、约1200、约1480
// 处。 子图(d)（最下方）：右下角标注文字为“P-ACT-LB\(_{
// BOSS}\)”。曲线颜色为紫色。曲线形状与控制点位置与子图(b
// )几乎相同。紫色实线在z约1320处达到约0.62，在z约1450处
// 达到约0.96，最终在z约1600处达到约1.0。紫色阴影区域在z
// 约1300至1450之间较宽。紫色圆点分布在z=800、约940、约
// 1080、约1200、约1320、约1460处。 整体趋势与结论：四幅
// 子图均显示重构的电离分数随红移增加而单调上升，从0逐渐
// 增至1。标准复合模型（黑色虚线）提供了一个基准。不同数
// 据集（Planck-LB 与 P-ACT-LB，及是否使用BOSS BAO）导致
// 重构曲线在细节上略有不同，但总体趋势一致。橙色和紫色阴
// 影区域在红移约1300至1500处出现展宽，表明该区间的不确定
// 性较大。控制点（圆点）的分布与均值曲线（实线）高度吻合。
#figure(image("imgs/fig17.png"),
  caption: [
    Reconstructed ionization fraction as a function of redshift using the `ModRec` model. The shaded region shows the mean and 95% two-tailed CL. The circles indicate the mean ionization fraction at the control points used in the reconstruction. The top (bottom) two panels use DESI (BOSS) BAO; the orange and purple colors distinguish between using -alone or P-ACT~CMB data. The black dashed line shows the evolution of the ionization fraction for the standard recombination scenario assuming the P-ACT-LB~best-fit $Lambda$CDM parameters. We see no evidence of a deviation from the standard recombination history.
  ],
  placement: top,
)
<fig:modrec_Xe_recon>

Notably, the mean ionization fraction from the P-ACT-LB reconstruction is nearly indistinguishable from the standard recombination scenario across all redshifts analyzed, with all sampled control points agreeing with the standard recombination history within $1 sigma$, except for the highest redshift control point ($z = 1467$), where the ACT data favor a slightly higher ($1.5 sigma$) ionization fraction than the standard model. This is driven by ACT's mild preference for less damping compared to #emph[Planck], as a larger value of $X_e$ at high redshifts leads to a decrease in damping~#cite(<Lynch:2024gmp>). This mild preference for a higher $X_e$ at high redshifts is in the opposite direction of what is generally required by modified recombination models that aim to increase the value of $H_0$ inferred from the primary CMB. Finally, with respect to the MAP $Lambda$CDM model, we find $Delta chi^2 = - 11.6$ ($- 8.4$) for the P-ACT-LB~(P-ACT-LB#sub[BOSS]) datasets, for a model with seven additional free parameters. These values correspond to a preference of $1.6 sigma$ and $1.0 sigma$ over $Lambda$CDM, respectively, and hence are not statistically significant. We present the full set of constraints on the control points in Appendix~@app:modrec_full_constraints.

In Fig.~#ref(<fig:modrec_H0>, supplement: none) we present the marginalized constraints on $H_0$ from the `ModRec` analysis. Including ACT data shifts $H_0$ closer to its $Lambda$CDM value for both BAO datasets, consistent with our findings that ACT data support the standard recombination history. We find $ H_0 &= 69.6 plus.minus 1.0 quad (68%, "P-ACT-LB"), \
      &= 68.1 plus.minus 1.1 quad (68%, "P-ACT"). $ For comparison, $H_0 = 70.1 plus.minus 1.1$ ($68.6 plus.minus 1.2$) km/s/Mpc for the $sans("Planck-LB")$ ($sans("Planck-LB")_(sans("BOSS"))$) dataset combinations. Additionally, we find that the choice of BAO data can lead to a shift of $tilde.op 1.5$ km/s/Mpc in the posterior mean of $H_0$. These findings are consistent with previous studies of the `ModRec` model~@Lynch:2024_desi@Lynch:2024gmp and are representative of a more general trend where the $H_0$ value inferred from models that modify the (pre)-recombination era physics depends sensitively on the BAO data.

// [figvision-cn] imgs/fig18.png
// 这是一张单面板的曲线图（一维边缘化后验概率密度分布图），
// 展示不同数据集组合对哈勃常数 H0 的限制。 横轴名称为“H0
// [km/s/Mpc]”，范围从约 63.5 到 74.5，主要刻度标记为 64、
// 66、68、70、72、74，单位为 km/s/Mpc。纵轴未标出名称和
// 刻度值，表示相对概率密度（后验概率密度），底部基线对应
// 概率为零或接近零，曲线向上凸起。 图中共有四条钟形曲线，
// 图例位于左上角，标注在白色方框内，包含四项：橙色实线表
// 示“Planck-LB”；紫色实线表示“P-ACT-LB”；橙色虚线表示“
// Planck-LB_BOSS”；紫色虚线表示“P-ACT-LB_BOSS”。所有曲线
// 均从横轴基线起始，上升至单一峰值后下降回基线。 图中还
// 有一条垂直的灰色虚线（点线），位于 H0 约 68.1 km/s/Mpc
// 处。在该灰色线左侧、两条实线曲线之间的区域，有一个纵向
// 排列的灰色文字标注“ΛCDM”，文字方向为自下而上。图注提到
// 灰色垂直线表示来自 P-ACT-LB（DESI）数据集的最佳拟合 Λ
// CDM 的 H0 值。 四条曲线的峰值位置和宽度如下：紫色虚线
// （P-ACT-LB_BOSS）峰值约在 H0 = 68.1 km/s/Mpc，分布最窄，
// 峰值最高；橙色虚线（Planck-LB_BOSS）峰值约在 H0 = 68.4
// km/s/Mpc，稍宽于紫色虚线；紫色实线（P-ACT-LB）峰值约在
// H0 = 69.7 km/s/Mpc；橙色实线（Planck-LB）峰值约在 H0 =
// 70.4 km/s/Mpc，位置最靠右，宽度与紫色实线相近。 趋势与
// 结论：使用 DESI BAO 数据（实线）相比使用 BOSS BAO 数据
// （虚线），得到的 H0 值整体向高值方向移动约 1.5–2.0 km/
// s/Mpc。P-ACT-LB 数据集（紫色）相比 Planck-LB 数据集（
// 橙色），无论使用哪种 BAO 数据，其 H0 峰值都略低（约低
// 0.6–0.7 km/s/Mpc）。灰色垂直线（ΛCDM 最佳拟合值约 68.1
// km/s/Mpc）位于 BOSS BAO 约束的峰值附近，但与 DESI BAO
// 约束的峰值有明显偏移，说明 DESI BAO 数据下的 H0 约束与
// ΛCDM 最佳拟合值之间存在张力。
#figure(image("imgs/fig18.png"),
  caption: [
    Marginalized constraints on $H_0$ from the `ModRec` analysis for the P-ACT-LB~(purple) and Planck-LB~(orange) datasets. The solid (dashed) lines use DESI (BOSS) BAO. The vertical gray line denotes the best-fit $Lambda$CDM value of $H_0$ from the P-ACT-LB~(DESI) dataset.
  ],
  placement: top,
)
<fig:modrec_H0>

Finally, given that~@Lynch:2024gmp found that `ModRec` constraints on $Omega_m$ including DESI BAO data prefer a lower value than recent $Omega_m$ constraints from supernova surveys, we comment on the $Omega_m$ constraints for the `ModRec` model. For P-ACT-LB~($sans("Planck-LB")$), we find $Omega_m = 0.296 plus.minus 0.007$ ($0.295 plus.minus 0.007$). Therefore, including ACT data has a negligible impact on the inferred value of $Omega_m$ for the `ModRec` model.

= Particle astrophysics
<sec:astroparticle>
== Neutrinos
<sec:neutrinos>
The CMB is sensitive to a cosmological background of neutrinos produced in the early universe that contribute a significant fraction ($tilde.op 41 %$) of the radiation density. In the Standard Model (SM) of particle physics, these neutrinos are expected to be three flavors of massless active particles that interact weakly with other SM particles but, as explained below, they are known to have non-zero masses.

=== Number and mass
<sec:neu_n_m>
The exact number of neutrinos and their total mass are two key parameters of the cosmological model, and can point to beyond-Standard-Model (BSM) physics.

#block[
#emph[Neutrino number]

]
The effective number of relativistic species quantifies the contribution to the radiation density of neutrinos, or other light particles, during their relativistic phase (including during the BBN epoch and the CMB decoupling epoch), $N_("eff") equiv (8/7) (11/4)^(4/3) rho_nu / rho_gamma$, where $rho_nu$ and $rho_gamma$ are respectively the neutrino and photon energy densities. Three neutrino species undergoing a non-instantaneous decoupling from the primordial plasma correspond to $N_("eff")=3.044$~@Neff3044 @2020JCAP...12..015F@2020JCAP...08..012A @2024JCAP...06..032D, accounting for energy-dependent interactions in the early universe. Numbers greater than this value might indicate the existence of additional light particles or extra free-streaming (dark) radiation --- as postulated by many BSM theories~@PhysRevLett.40.223 @2013arXiv1311.0029E@2013JHEP...12..058B @2012arXiv1204.5379A@2013PhRvL.110x1301W @2015PhRvD..91l5018K#cite(<2016PhRvL.117q1301B>). Values of $N_("eff")$ smaller than $3.044$ are also possible in scenarios where radiation is affected not by the existence of extra particles but by non-standard properties of neutrinos or changes to the standard thermal history. In low-reheating temperature scenarios, for example, the late-time entropy production associated with the decay of a massive particle might delay the beginning of the radiation-dominated era down to a temperature of a few MeV, thus preventing the full thermalization of neutrinos @Kawasaki:1999na@Kawasaki:2000en@Giudice:2000ex @2002PhRvD..66j3508T@Ichikawa:2005vw@Ichikawa:2006vm@DeBernardis:2008zz@deSalas:2015glj@Hasegawa:2019jsa#cite(<Barbieri:2025moq>). Entropy production occurring after neutrino decoupling might also reduce $N_("eff")$ below its standard value by increasing the photon temperature relative to neutrinos (see, e.g., #cite(<2013PhRvD..87j3517S>, style: "aas_noparen.csl"), and also #cite(<Cadamuro:2011fd>, style: "aas_noparen.csl"), for a scenario involving the decay of an axion-like particle). A reduction of the effective number of neutrino species might also be the signature of sterile neutrinos with strong self-interactions #cite(<Mirizzi:2014ama>).

The CMB is able to constrain $N_("eff")$ because its value affects the expansion rate of the universe, especially during the radiation-dominated phase, thereby altering the expansion history just before recombination and the predicted abundances of primordial light elements~#cite(<BashinskyandSeljak>)@Hou2013@Abazajian2015@Pan2016#cite(<Baumann2016>). At the perturbative level, $N_("eff")$ alters the damping tail (high-$ell$ region) of the TT/TE/EE spectra, both because the change to the expansion history alters the timescale for diffusion damping and because the free-streaming nature of the radiation damps the growth of perturbations, with the latter also inducing a characteristic phase shift in the acoustic peaks~#cite(<BashinskyandSeljak>). Combining the #emph[Planck] legacy CMB with #emph[Planck] CMB lensing and BOSS BAO, the neutrino number is measured to be $N_("eff")=2.99plus.minus 0.17$ at 68% CL~@Planck_2018_params, or $N_("eff")=3.06plus.minus 0.17$ at 68% CL when we evaluate this estimate using Planck-LB. Here, and as baseline throughout this paper, we assume a fixed total neutrino mass of 0.06~eV carried by a single massive species.

With the new ACT DR6 spectra we find $N_("eff") = 2.60^(+0.21)_(-0.29)$ at 68% CL, combining into $ N_("eff") &= 2.73 plus.minus 0.14 quad (68%, "P-ACT"), \
            &= 2.86 plus.minus 0.13 quad (68%, "P-ACT-LB") $ and giving $ N_("eff") < 3.08 quad ("one-tail" 95%, "P-ACT-LB"). $ This measurement is consistent with SM predictions for three relativistic neutrinos and the existence of another thermalized particle (irrespective of its spin or decoupling time) lies at the 94% confidence border, as calculated from the likelihood of having a minimal additional contribution of 0.027 from a scalar boson (see below) beyond the expected value of 3.044, as shown in Fig.~#ref(<fig:nnu_1D>, supplement: none). Higher-spin particles are disfavored at higher significance. A strong contribution to this new limit comes from the peak of the ACT $N_("eff")$ distribution shifting to lower values compared to the #emph[Planck] measurement because, as shown in Fig.~#ref(<fig:spec>, supplement: none), the new ACT data prefer somewhat less damping than the #emph[Planck] best-fit model.

// [figvision-cn] imgs/fig19.png
// 这是一张单面板的概率密度曲线图，横轴为有效相对论物种数
// Neff，刻度范围从约 2.45 到 3.75，主要刻度标记为 2.6、
// 2.8、3.0、3.2、3.4、3.6。纵轴未标注名称和刻度，表示概
// 率密度。 图中包含两条一维后验概率密度曲线。紫色实线代
// 表 P-ACT-LB 数据集（ACT DR6 频谱结合其他数据），橙色虚
// 线代表 Planck-LB 数据集（普朗克数据结合 CMB 透镜和 BAO）。
// 两条曲线均为单峰钟形，紫色曲线峰值位于 Neff 约 2.86 处，
// 橙色曲线峰值位于 Neff 约 3.06 处。紫色曲线比橙色曲线更
// 窄，峰更高，表示约束更精确。 在 Neff 约 3.044 处有一条
// 黑色垂直虚线，表示标准模型（SM）预期值，即三种轻味活跃
// 中微子的有效物种数。该线右侧区域为紫色曲线尾部填充的紫
// 色半透明带，起始于该虚线并向右延伸，表示被排除的区域下
// 限。图中标注了两个排除上限：一个灰色竖直箭头指向 Neff
// 约 3.16 处，标注文字为“Spin-0 boson out at 94%”，文字
// 颜色为黑色；另一个灰色竖直箭头指向 Neff 约 3.17 处，标
// 注文字为“Spin-3/2 fermion out at 99%”，文字颜色为紫色。
// 这两个箭头右侧的紫色阴影区域分别对应其排除置信度。图中
// 右侧中部有文字标识：紫色“P-ACT-LB”和橙色“Planck-LB”，
// 分别对应两条曲线。 整体趋势表明，加入 ACT DR6 频谱后，
// 对 Neff 的约束比 Planck 结合 CMB 透镜和 BAO 的测量更精
// 确，且约束结果与标准模型预期一致。
#figure(image("imgs/fig19.png"),
  caption: [
    Constraints on the effective number of relativistic species, $N_("eff")$. With the addition of the ACT DR6 spectra (purple) the constraint is more precise than the measurement from #emph[Planck] combined with CMB lensing and BAO (orange) by $tilde.op 25 %$. The constraint is consistent with the SM expectation of $N_("eff")=3.044$ for three light active neutrinos marked by the dashed vertical line. The purple bands show the region excluding a minimum contribution in extra radiation from another thermalized relativistic species, finding $N_("eff")=3.044+0.027$ from a spin-0 boson at the 94% confidence border (light purple), and the most stringent bound on the existence of another species, disfavoring $N_("eff")=3.044+0.095$ from a spin-3/2 fermion at 99% confidence (dark purple) --- see also Fig.~#ref(<fig:nnu_dec>, supplement: none).
  ],
  placement: top,
)
<fig:nnu_1D>

While our constraints are consistent with the SM expectation --- and the shift is not statistically significant enough to draw strong conclusions --- it is interesting to consider physical models that could yield values of ${N_("eff") lt 3.044}$. Recalling that $N_("eff")$ depends on the neutrino-to-photon energy density ratio, a simple possibility to decrease $N_("eff")$ is an injection of energy into the photon-baryon plasma after neutrino decoupling, but before last scattering (note that this would thus lead to different values for $N_("eff")$ at the BBN and CMB epochs). Taking the central value of our P-ACT~(P-ACT-LB) posterior, the photon energy density would need to be increased by 12% (6%) between neutrino decoupling and last scattering. If this energy injection takes place between redshifts $5 times 10^4 < z < 2 times 10^6$, a $mu$ distortion will be produced in the CMB monopole energy spectrum; if it takes place at lower redshifts $z < 5 times 10^4$, a $y$-type distortion will be produced. Using standard formulae for the distortion amplitudes (e.g.,~#cite(<Chluba2012>, style: "aas_noparen.csl")), the P-ACT~(P-ACT-LB) energy-injection values would yield $mu = 0.16$ or $y = 0.03$ ($mu = 0.09$ or $y = 0.02$). Such large spectral distortions are strongly excluded already by the #emph[COBE/FIRAS] data~@Fixsen1996#cite(<Bianchini2022>).#footnote[The #emph[COBE/FIRAS] spectral distortion bounds are sufficiently tight that only very small increases in the photon energy density are allowed during the $mu$ and $y$ epochs, corresponding roughly to $Delta N_("eff") = -0.0002$ (for both the $mu$ and $y$ limits).] Nevertheless, a low $N_("eff")$ value could still be obtained via energy injection into the photon bath at $2 times 10^6 < z < 10^9$, by cooling the neutrinos via a BSM interaction, or by other, more exotic mechanisms as discussed above.

If we instead start by assuming the existence of the three SM neutrinos and add new, specific light relic particles with mass $lt.eq$ eV --- i.e., only looking at regions of parameter space with $N_("eff")gt 3.044$ --- then we can set limits on the new species' nature by exploiting the fact that the excess in $N_("eff")$ that they generate depends on the spin of the particle and on the temperature at which they decoupled from the thermal bath in the early universe, as shown in Fig.~#ref(<fig:nnu_dec>, supplement: none) (with predictions from~#cite(<2016arXiv160607494B>, style: "aas_noparen.csl") for different species as adopted in previous CMB literature, including~#cite(<Planck_2015_params>, style: "aas_noparen.csl")#cite(<Planck_2018_params>, style: "aas_noparen.csl")#cite(<CMB_S4_Science_Book>, style: "aas_noparen.csl")#cite(<Simons_Observatory>, style: "aas_noparen.csl")). We do this by fitting for the positive $Delta N_("eff")$ that such new species would contribute to $N_("eff")$. We find $Delta N_("eff")lt 0.32$ at 95% CL from ACT, which becomes $ Delta N_("eff") &< 0.14 quad (95%, "P-ACT"), \
                  &< 0.17 quad (95%, "P-ACT-LB") $ where lensing and BAO data relax the bound by moving the overall $N_("eff")$ posterior to higher values as seen previously. The same limit using Planck-LB~is $Delta N_("eff")lt 0.36$ at 95% confidence. Our P-ACT-LB~combination excludes at 95% CL any light particle of spin 0 or 1/2 that decoupled after the start of the QCD phase transition at temperatures $lt.eq 200$ MeV and all light particles with spin 3/2 that decoupled at temperatures $lt.eq 1$ GeV. These are the strongest constraints to date on the possible existence of light, weakly coupled particles in the early universe.

// [figvision-cn] imgs/fig20.png
// 这是一张单面板科学曲线图，没有子图。图表展示的是额外相
// 对论性粒子对辐射能量密度的贡献增量 ΔNeff 随其从热浴中
// 退耦时的温度 Tγ 的变化关系。 坐标轴：横轴为 Tγ [MeV]，
// 采用对数刻度，范围从 10^-2 到 10^6，主要刻度标记为 10^
// -2、10^-1、10^0、10^1、10^2、10^3、10^4、10^5、10^6。
// 纵轴为 ΔNeff，采用对数刻度，范围从约 0.01 到 10，主要
// 刻度标记为 0.1、1、10，并带有表示对数间隔的次级刻度线。
// 数据曲线：图中共有四条实线，均呈现随 Tγ 增大而阶梯式下
// 降的趋势，每条曲线在特定的温度区间出现明显的平台和陡降。
// 曲线颜色与物理含义由右下角的图例给出：土黄色实线表示玻
// 色子，g=1，渐近值 ΔNeff = 0.027；深棕色实线表示玻色子，
// g=2，渐近值 ΔNeff = 0.055；浅蓝色实线表示费米子，g=2，
// 渐近值 ΔNeff = 0.047；深蓝色实线表示费米子，g=4，渐近
// 值 ΔNeff = 0.095。四条曲线在 Tγ 小于 10^-1 MeV 时均处
// 于高位平台，随后在 10^-1 至 10^0 MeV 之间出现第一次下
// 降；在 10^0 至 10^1 MeV 之间形成第二平台；在 10^1 至
// 10^2 MeV 之间再次下降；在 10^2 至 10^3 MeV 之间经历最
// 陡峭的下降；在 Tγ 大于 10^4 MeV 后趋于各自的低值渐近线。
// 深蓝色曲线在低 Tγ 平台处的 ΔNeff 值最高，土黄色曲线最
// 低；四条曲线在 Tγ 约 10^2 MeV 附近发生急剧下降，最终在
// Tγ 约 10^6 MeV 时，深蓝色曲线趋近于 0.1，浅蓝色曲线趋
// 近于 0.047，深棕色曲线趋近于 0.055，土黄色曲线趋近于
// 0.027。 阴影区域与标注：图中有两个垂直的浅灰色半透明阴
// 影带。第一个阴影带覆盖 Tγ 约 5×10^-1 至 3×10^0 MeV 的
// 区间，顶部标注文字为“Neutrino decoupling”，文字旋转 90
// 度排布。第二个阴影带覆盖 Tγ 约 10^2 至 2×10^2 MeV 的区
// 间，顶部标注文字为“QCD”，文字同样旋转 90 度排布。另有
// 一个贯穿全图的水平深紫色半透明阴影带，覆盖纵轴 ΔNeff
// 约 0.15 至 0.45 的区间。图例位于右上角，标题为“
// Excluded at 95% by”，其下有两个色块：浅灰色块对应“
// Planck-LB”，深紫色块对应“P-ACT-LB”。浅灰色块在图中并未
// 作为水平带出现，而是对应垂直阴影带或背景色；深紫色块对
// 应贯穿全图的水平阴影带。 图例与标注：左下角图例列出了
// 四条曲线的颜色、线型（均为实线）、粒子类型、自旋态数目
// g 以及渐近的 ΔNeff 值。图中所有文字均为黑色，坐标轴标
// 签和刻度标签清晰可辨。 趋势与结论：该图表明，额外相对
// 论性粒子对 ΔNeff 的贡献取决于其退耦温度。在 Tγ 高于约
// 10^2 MeV 时退耦的粒子，其 ΔNeff 值较低，且不同自旋态数
// 目的粒子贡献差异较小；而在 Tγ 低于 10^2 MeV 时退耦的粒
// 子，其 ΔNeff 值显著升高。图中深紫色水平阴影带表示被
// P-ACT-LB 在 95% 置信水平排除的参数空间。可以看出，在
// QCD 相变（约 10^2 MeV）之后退耦的粒子，其 ΔNeff 值落入
// 或高于该排除带，因此被排除。具体而言，自旋为 0 和 1/2
// 的轻粒子必须在 Tγ 大于约 10^2 MeV 时退耦，才能避免被当
// 前观测排除。图中四条曲线在 Tγ 约 10^2 MeV 处的陡降与
// QCD 阴影带重合，说明 QCD 相变对粒子退耦过程有显著影响。
#figure(image("imgs/fig20.png"),
  caption: [
    Excess in the contribution to radiation, $Delta N_("eff")$, caused by the existence of additional relativistic species with $g$ independent spin states $s$ (with $g = 2 s + 1$) as a function of the temperature at which they decouple from the thermal bath. Particles decoupling after the QCD phase transition are excluded by our constraints; in particular, light particles of spin 0 and 1/2 must decouple at temperatures $gt.eq 200$ MeV and all light particles of spin 3/2 must decouple at temperatures $gt.eq 1$ GeV. The figure is adapted from the versions in~ and ~ but, differently from those versions, this figure is based on the fit of a positive excess rather than from the tail of the full $N_("eff")$ posterior, i.e., we assume the existence of another species in addition to the three SM neutrinos (varying only $Delta N_("eff") gt 0$).
  ],
  placement: top,
)
<fig:nnu_dec>

As shown in Figs.~#ref(<fig:lcdm_single_extensions_pactlb>, supplement: none) and~#ref(<fig:lcdm_single_extensions_pact>, supplement: none), the region of parameter space preferred by ACT is in the low $H_0$ corner of the ${N_("eff")-H_0}$ correlation --- we find $H_0 = 67.00 plus.minus 0.91$~km/s/Mpc (68%, P-ACT-LB) when varying $N_("eff")$. This is driven by ACT's preference for values of $N_("eff")$ below 3.044, while values higher than the SM expectation would be necessary to increase the expansion rate. Therefore, this model extension is no longer viable to move the CMB-inferred Hubble constant toward the local SH0ES estimate. On the contrary, the P-ACT-LB~constraint is well within the CCHP measurement of $H_0$. If we import this latter measurement as a prior on $H_0$, we find a small pull of the central value of $N_("eff")$ to higher values and negligible tightening of the error bar.

Including also a prior on $S_8$ (as described in~§@sec:glossary) leaves the constraint essentially unchanged. In fact, including all state-of-the-art non-CMB data has limited impact on the precision of this measurement, which is dominated by P-ACT.

$N_("eff")$ is often used as a proxy parameter to explore the sensitivity of small-scale CMB data to physics that impacts the damping tail; conclusions drawn for $N_("eff")$ in fact speak more broadly about patterns in --- and robustness of --- results from small scales. As such, we perform a number of tests to look at the stability of the $N_("eff")$ measurement. In Fig.~#ref(<fig:neff_whisker>, supplement: none), we report the variation in the constraint when comparing our baseline ACT~and P-ACT~datasets with only a subset of the data.#footnote[To allow fair comparisons across values, all these runs are performed with the ACT multi-frequency likelihood; the ACT TE- and EE-only runs allow the polarization efficiencies to vary freely within a 20% uniform prior.] The results are stable across probes, frequencies, and combinations with #emph[Planck]. The overall constraint is dominated by the ACT TT and TE spectra. \

// [figvision-cn] imgs/fig21.png
// 这是一张用于检验ACT测量Neff稳健性的单面板误差棒散点图，
// 无子图划分。纵轴为Neff，刻度范围从1.5到5.0，主刻度间隔
// 为0.5，无单位；横轴为分类轴，共列出13个数据点，标签逆
// 时针旋转约45度，从左至右依次为：Planck、P-ACT、ACT TT+
// TE+EE、ACT TT、P-ACT TT、ACT TE、P-ACT TE、ACT EE、
// P-ACT EE、ACT TE+EE、P-ACT TE+EE、ACT 90 GHz、ACT 150
// GHz。图中有三条贯穿全图的水平参考线：位于Neff≈3.046的
// 黑色虚线，表示标准值；位于Neff≈2.99的深灰色实线，表示
// P-ACT参考值；位于Neff≈2.73的浅灰色实线，但在图中较不明
// 显。两个灰色阴影带分别覆盖Neff≈2.15–3.40（较宽）和Neff
// ≈2.39–3.10（较窄，与P-ACT参考值相关），在横向上仅覆盖
// 部分ACT数据点。数据点由带误差棒的空心圆表示，误差棒颜
// 色与点色一致，较粗的误差棒为1σ不确定度，较细的误差棒为
// 2σ不确定度。各数据点数值与颜色如下：Planck为橙色空心圆，
// Neff≈2.92，粗误差棒约2.62–3.22，细误差棒约2.60–3.24；
// P-ACT为深藏青色点，Neff≈2.76，粗误差棒约2.60–2.92，细
// 误差棒约2.56–2.96；ACT TT+TE+EE为浅蓝色点，Neff≈2.58，
// 粗误差棒约2.30–2.86，细误差棒约2.20–2.96；ACT TT为浅蓝
// 色点，Neff≈2.73，粗误差棒约2.36–3.10，细误差棒约2.20–
// 3.26；P-ACT TT为深藏青色点，Neff≈2.72，粗误差棒约2.54–
// 2.90，细误差棒约2.46–2.98；ACT TE为浅蓝色点，Neff≈2.32，
// 粗误差棒约1.90–2.74，细误差棒约1.50–3.14；P-ACT TE为深
// 藏青色点，Neff≈2.86，粗误差棒约2.66–3.06，细误差棒约
// 2.56–3.16；ACT EE为浅蓝色点，Neff≈3.70，粗误差棒约2.85
// –4.55，细误差棒约2.40–5.00；P-ACT EE为深藏青色点，Neff
// ≈3.50，粗误差棒约2.35–4.65，细误差棒约2.00–5.00；ACT
// TE+EE为浅蓝色点，Neff≈2.58，粗误差棒约2.30–2.86，细误
// 差棒约2.20–2.96；P-ACT TE+EE为深藏青色点，Neff≈2.90，
// 粗误差棒约2.68–3.12，细误差棒约2.56–3.24；ACT 90 GHz为
// 浅蓝色点，Neff≈2.32，粗误差棒约1.95–2.69，细误差棒约
// 1.68–2.96；ACT 150 GHz为浅蓝色点，Neff≈3.04，粗误差棒
// 约2.64–3.44，细误差棒约2.40–3.88。所有测量值均与Neff=
// 3.046的标准值在2σ误差范围内一致，其中ACT EE和P-ACT EE
// 的测量值偏高且误差棒较大，ACT TE和P-ACT EE的误差棒范围
// 最宽，图中未标注比例尺，不涉及显微成像通道。
#figure(image("imgs/fig21.png"),
  caption: [
    Robustness tests of the ACT measurement of $N_("eff")$. The P-ACT~value used as a reference and marked with the solid gray line is compared with the #emph[Planck] estimate (orange), with individual TT, TE, and EE probes within P-ACT~(navy points) and with different subsets of ACT data (light blue points). All measurements are reported with $1$ and $2 sigma$ uncertainties (thicker and thinner colored error bars, respectively) and the SM prediction of $N_("eff")=3.044$ is shown with the dashed black horizontal line. The gray bands show the expected statistical fluctuation incurred when looking only at a subset of the data --- calculated as the $sigma$ difference between the full dataset and the nested subset of data used for each point.
  ],
  placement: top,
)
<fig:neff_whisker>

#block[
#emph[Neutrino mass]

]
The total mass of all neutrino species is parametrized by $sum m_nu$. Measurements of flavor oscillations between neutrinos have provided evidence for a non-zero mass~@Super-Kamiokande_mnu@SNO_mnu and set a lower limit on the value of $sum m_nu$. Depending on the hierarchy (ordering) between mass eigenstates, $sum m_nu gt.eq 60$~meV for the normal hierarchy and $sum m_nu gt.eq 100$~meV for the inverted hierarchy~#cite(<ParticleDataGroup:2024cfk>). The absolute value of the total mass is still unknown but, given that massive neutrinos with masses at sub-eV scales cannot be explained with the mass-generation mechanisms of the SM of particle physics, we already know that new physics is at play. Cosmology and laboratory experiments are highly complementary probes of the neutrino mass scale, being sensitive to different combinations of individual neutrino masses and mixing parameters, and relying on different assumptions in the derivation of the constraints~#cite(<Gerbino:2022nvz>).

Neutrino mass impacts the growth of structures in the universe after the neutrinos become non-relativistic~@2006PhR...429..307L @2012arXiv1212.6154L@2011APh....35..177A @2011ARNPS..61...69W@2017FrP.....5...70G @2019BAAS...51c..64D, suppressing growth at the level of a few percent. This in turn affects the amplitude of density perturbations measurable in the lensing of the CMB temperature and polarization anisotropies. Planck-LB~gives $sum m_nu < 0.077$~eV at 95% confidence~@DESI-BAO-VI, with a significant contribution from the CMB lensing data. With the new ACT DR6 spectra, assuming three massive neutrino species, we find $ sum m_nu & < & 0.089 med upright("eV") quad ( 95 % , sans("P-ACT-LB") ) ,\
 & < & 0.088 med upright("eV") quad ( 95 % , sans("W-ACT-LB") ) . $ The addition of ACT DR6 to #emph[Planck] leaves the bounds almost unchanged. However, the neutrino mass constraints from #emph[Planck] correlate with the high fluctuation of the lensing-like smearing effect in the #emph[Planck] CMB spectra (measured by the $A_(upright("lens"))$ parameter, #cite(<Calabrese2008>, style: "aas_noparen.csl")) so the ACT dataset serves here as a useful cross-check of the result. The impact of extra lensing is mitigated in the P-ACT~combination by the cut in $ell$ that we introduce in #emph[Planck] temperature and is completely avoided in the W-ACT~combination --- since, as shown in L25, ACT DR6 measures $A_(upright("lens"))$ consistent with $Lambda"CDM"$~predictions. Once CMB lensing and BAO data are included, the CMB power spectra contribution to the bound is sub-dominant and the same across experiments. The conclusion that extra lensing-like smearing in the power spectra is not the primary contributor to the very tight bounds on $sum m_nu$ was also reached by #cite(<GreenandMeyers24>), who delve into all the different pieces of data contributing to a neutrino mass constraint (see also~#cite(<2024arXiv241205451G>, style: "aas_noparen.csl")).

// [figvision-cn] imgs/fig22.png
// 这是一张单面板的二维曲线图（概率密度/后验分布图），用
// 于展示不同宇宙学数据集对中微子质量总和 Σm_ν 的限制，并
// 与中微子振荡实验给出的下限进行比较。图中没有子图 a、b、
// c，仅有一个主坐标区。 坐标轴： 横轴（X 轴）标签为“Σm_ν
// [eV]”，表示三种中微子质量本征态的质量之和，单位为电子
// 伏特。刻度从 0.00 到 0.30，主要刻度间隔为 0.05（标注
// 0.00、0.05、0.10、0.15、0.20、0.25、0.30），横轴为线性
// 标度。纵轴没有轴标签、刻度数值和单位，表示相对概率密度
// 或置信度，数值从下到上递增，底边为 0。 曲线与色带： 图
// 中共有四条呈单峰或单调下降形态的曲线，分别对应不同的数
// 据集，并在曲线下方填充了同色半透明色带以表示排除区域：
// 深蓝色曲线（标注 P-ACT）：从横轴 0.00 处的高值开始，单
// 调下降，在 0.30 处趋近于零。其下方填充浅蓝色色带。 紫
// 色曲线（标注 P-ACT-LB）：同样从 0.00 处的高值开始，下
// 降比深蓝曲线更陡峭，在约 0.06 eV 之后急剧下降，在 0.15
// eV 附近已接近零。其下方填充紫色/品红色色带。 浅蓝色虚
// 线曲线（标注 P-ACT-LB_BOSS，下标 BOSS）：形态与深蓝色
// 曲线类似，但整体略靠右/略高，从 0.00 处高值单调下降，
// 在 0.30 处趋近于零。其下方填充浅蓝色色带（与 P-ACT 的
// 色带区域有重叠，但虚线表示其边界）。 黄色/金色曲线（标
// 注 P-ACT-LS）：与其他三条曲线不同，它从 0.00 处的中等
// 值开始，先上升，在约 0.06 eV 附近达到峰值，然后单调下
// 降，在 0.30 处趋近于零。该曲线没有明显的填充色带，仅以
// 线条表示。 垂直参考线与标注： 图中有两条垂直的灰色实线，
// 分别对应中微子振荡实验给出的质量总和下限： 左侧灰色垂
// 直线位于横轴约 0.06 eV 处（对应 Normal Ordering，NO 的
// 下限）。从该线顶部向右有一个灰色箭头，箭头右侧标注文字：
// “NO out at 83% (62%)”，其中“83%”为紫色，“(62%)”为浅蓝
// 色。这表示在 NO 假设下，该下限以上的区域被宇宙学数据排
// 除的置信度。 右侧灰色垂直线位于横轴约 0.10 eV 处（对应
// Inverted Ordering，IO 的下限）。从该线顶部向右有一个灰
// 色箭头，箭头右侧标注文字：“IO out at 98% (88%)”，其中“
// 98%”为紫色，“(88%)”为浅蓝色。 图例与标注文字： 在图的
// 右侧偏上位置，有四行文字作为图例，分别对应四条曲线： “
// P-ACT”（深蓝色） “P-ACT-LB”（紫色） “P-ACT-LB_BOSS”（
// 浅蓝色，BOSS 为下标） “P-ACT-LS”（黄色/金色） 趋势与结
// 论： 该图传达的核心结论是：宇宙学观测对中微子质量总和
// 给出了上限限制。不同数据集给出的限制强度不同，其中
// P-ACT-LB（紫色）给出的上限最严格（曲线下降最快，排除区
// 域最靠左），其排除区域与 NO 下限（约 0.06 eV）有显著重
// 叠，图中标注显示在 NO 情况下，该下限以上的区域被排除的
// 置信度达 83%（括号内 62% 对应 P-ACT-LB_BOSS）。对于 IO
// 下限（约 0.10 eV），排除置信度更高，达到 98%（括号内
// 88% 对应 P-ACT-LB_BOSS）。黄色曲线 P-ACT-LS 的限制最弱，
// 其峰值位于 0.06 eV 附近，表明该数据集对质量总和的约束
// 相对宽松。整体上，宇宙学数据对 IO 的排除置信度高于对
// NO 的排除置信度。
#figure(image("imgs/fig22.png"),
  caption: [
    Upper limits on the sum of the neutrino masses, $Sigma m_nu$, within the $Lambda"CDM"$~model. The gray lines mark the lower bounds coming from neutrino oscillation experiments, assuming a Normal Ordering (NO, $Sigma m_nu > 0.06 med upright("eV")$) or Inverted Ordering (IO, $Sigma m_nu > 0.10 med upright("eV")$), respectively, and the colored bands show the exclusion regions coming from cosmology for each scenario. The most stringent bound is given by P-ACT-LB~(purple), with a significant contribution coming from DESI BAO. For this data combination, and within the assumption of the $Lambda"CDM"$~model, the IO scenario is disfavored at 98% confidence. The limits get more relaxed but still competitive when replacing DESI BAO with BOSS/eBOSS BAO (light blue) or when using SNIa (gold).
  ],
  placement: top,
)
<fig:mnu>

// [figvision-cn] imgs/fig23.png
// 这是一张二维边缘化后验概率分布图，横轴为物质密度参数Ω
// _m，范围0.2至0.5，无单位；纵轴为中微子质量总和Σm_ν，范
// 围0.0至1.5，单位为eV。图中包含四个不同宇宙学探针的置信
// 区间，分别以68%和95%置信水平（CL）的填充带表示。 图例
// 位于右上角，包含四项：CMB lensing+Ω_b h²（深青色）、
// DESI BAO+Ω_b h²（粉红色）、P-ACT（深蓝色）、P-ACT-LB（
// 紫色）。 CMB lensing+Ω_b h²的约束表现为一条从左上向右
// 下倾斜的深青色条带，68% CL为深青色实心区域，95% CL为外
// 围浅青色半透明区域。该条带在Ω_m≈0.3时覆盖Σm_ν约0.0至
// 0.5 eV，在Ω_m≈0.5时覆盖约0.6至1.4 eV，显示出中微子质量
// 与物质密度之间的正相关退化方向。 DESI BAO+Ω_b h²的约束
// 表现为一条近乎垂直的粉红色条带，中心位于Ω_m≈0.29至0.30，
// 68% CL为深粉色窄带，95% CL为更宽的浅粉色带。该条带几乎
// 不随Σm_ν变化，表明BAO数据主要限制总物质密度，对中微子
// 质量不敏感。 P-ACT的约束表现为深蓝色填充的闭合轮廓，位
// 于Ω_m≈0.30、Σm_ν≈0.0附近。68% CL为深蓝色实心小椭圆，95%
// CL为外围浅蓝色半透明椭圆。该轮廓在Σm_ν方向延伸至约0.3
// eV，在Ω_m方向覆盖约0.28至0.33。 P-ACT-LB的约束表现为紫
// 色填充的闭合轮廓，同样位于Ω_m≈0.30、Σm_ν≈0.0附近，但比
// P-ACT的轮廓更紧凑。68% CL为深紫色实心小椭圆，95% CL为
// 外围浅紫色半透明椭圆。该轮廓在Σm_ν方向延伸至约0.2 eV，
// 在Ω_m方向覆盖约0.29至0.32。 图中传达的趋势是：BAO数据
// （粉色）仅约束总物质密度，对中微子质量不敏感；CMB
// lensing（青色）打破了这种退化，将中微子与其他物质组分
// 分离；P-ACT和P-ACT-LB（蓝色和紫色）进一步在低中微子质
// 量区域提供了紧凑的约束，且P-ACT-LB的约束比P-ACT更严格。
#figure(image("imgs/fig23.png"),
  caption: [
    2D marginalized posteriors at 68% and 95% CL highlighting different degeneracy directions between the neutrino mass and the matter density for different cosmological probes. The BAO data (pink) are mostly insensitive to how matter is distributed across different components and only bound the total matter density. CMB lensing (teal) breaks this degeneracy, separating out the neutrinos from other matter components, once the baryon density is anchored by BBN constraints. Together with CMB anisotropies (purple), the combination of these data sets a stringent limit on the sum of the neutrino masses.
  ],
  placement: top,
)
<fig:mnu_omegam>

As shown in Figs.~#ref(<fig:mnu>, supplement: none) and~#ref(<fig:mnu_omegam>, supplement: none), neutrino mass measurements from cosmology need different datasets to come together to disentangle the effect of neutrinos on the geometry of the universe and growth of structure from the late-time expansion effects~#cite(<2024arXiv241000090L>). In particular, DESI's constraint on the total matter fraction $Omega_m$, through measuring the BAO and inferring cosmic distances, plays a large role in these neutrino mass limits, as shown in Fig.~#ref(<fig:mnu_omegam>, supplement: none). The CMB lensing measurement then breaks the degeneracy between the total density in matter and in neutrinos, due to the unique effect of the neutrino on suppressing the clustering at smaller scales. The addition of ACT DR6 spectra confirms the tight limit that @DESI-BAO-VI found with #emph[Planck]. The combination of P-ACT-LB~disfavors at $tilde.op 98 %$ confidence the inverted ordering scenario. This conclusion holds also for an independent-of-~combination, with W-ACT-LB~giving very similar results.

Given the strong impact on these constraints from BAO, we explore other dataset combinations that can help the CMB for neutrino mass constraints. We replace DESI with BOSS BAO and obtain a bound of $ sum m_nu < 0.13 "eV" quad (95%, "P-ACT") $ which is unchanged when replacing #emph[Planck] with #emph[WMAP]. We also exclude BAO completely and instead exploit the information on the matter density coming from SNIa measurements, finding $ sum m_nu < 0.23 med upright("eV") med ( 95 % , sans("P-ACT-LS") ) . $ In both cases, the limits become weaker and raise the likelihood of the inverted ordering (see Fig.~#ref(<fig:mnu>, supplement: none)). The broadening of the bound in P-ACT-LS is due to the preference of a larger value of the matter density exhibited by the supernovae measurements, as described in~#cite(<2024arXiv241000090L>).

// [figvision-cn] imgs/fig24.png
// 该图为一个二维参数空间图，横轴为 Σm_ν [eV]，采用对数坐
// 标，范围从 10^-2 到 10^0；纵轴为 m_ββ [eV]，采用对数坐
// 标，范围从 10^-3 到 10^1。图的左上角区域为浅黄色背景并
// 标有“Excluded by lab searches”，其中包含两条按纵向位置
// 标注的水平区域：“KamLAND-Zen tightest”和“KamLAND-Zen
// loosest”。图例显示灰色实线带代表正常排序（NO），黑色实
// 线带代表倒置排序（IO）。两条带分别从约 Σm_ν=0.05 eV 处
// 向上倾斜向右延伸，灰色带在参数空间中位于黑色带下方，黑
// 色带的上边界约为 m_ββ=10^-1 eV 量级。图中另有两个垂直
// 的棕色阴影带，其内文字分别为“with DESI BAO”和“with
// BOSS BAO”，位置约在 Σm_ν=0.07–0.12 eV 和 0.12–0.2 eV
// 区间。图的右下方为紫色的对角线阴影区域，标有“Excluded
// by ΛCDM+Σm_ν cosmology (P-ACT-LB)”，该区域的边界与灰色
// 和黑色带的下边缘相交。背景中深紫色区域与棕色垂直带重合
// 对比。图中所有线条均为带宽形式，带宽的物理意义是反映
// Majorana 相位知识的缺乏；95% CL 的紫色垂直带在图中显示
// 为最左侧棕色带（“with DESI BAO”）内的深色区域边缘，该
// 区域被宇宙学数据以 95% 置信水平排除。整体趋势表明，宇
// 宙学观测（特别是 P-ACT-LB 数据）能够区分 NO 与 IO 两种
// 质量排序情景，并在 95% CL 下排除图中的垂直带区域。
#figure(image("imgs/fig24.png"),
  caption: [
    Neutrino oscillation experiments require that the neutrino mass scale parameters live in one of the two bands for normal ordering (NO, grey) or inverted ordering (IO, black), with the width of the bands reflecting the lack of knowledge of the Majorana phases. Cosmology helps distinguish between the two scenarios, disfavoring at 95% CL the vertical band in purple, within the $Lambda"CDM"$~model. The dark purple region is disfavored when including BOSS BAO data, while when using DESI BAO data more parameter space is excluded, as shown by the light purple band. Neutrinoless double-beta decay results at 90% CL from KamLAND-Zen~@KamLAND-Zen:2024eml exclude the horizontal gold bands (these account for the uncertainty in the calculation of the nuclear matrix elements when translating the bounds on the xenon half life from KamLAND-Zen to a bound on the effective Majorana mass $m_(beta beta)$). The still viable parameter space is within the colored bands for the two neutrino mass orderings. The new cosmology results presented here reduce the allowed parameter space compared to $0 nu 2 beta$ by excluding within the $Lambda"CDM"$+$sum m_nu$ model the inverted ordering region and a large fraction of the normal ordering region. This result however strongly depends on the use of DESI BAO data; with BOSS BAO the limits are more relaxed.
  ],
  placement: top,
)
<fig:mnu_pp>

In Fig.~#ref(<fig:mnu_pp>, supplement: none), we compare our P-ACT-LB~bounds with constraints on the effective Majorana mass $m_(beta beta)$ from the neutrinoless double-beta decay ($0 nu 2 beta$) experiment KamLAND-Zen~@KamLAND-Zen:2024eml (comparable constraints --- not shown here --- have also been obtained by the GERDA collaboration,~#cite(<GERDA:2020xhi>, style: "aas_noparen.csl")). The viable parameter space, represented by the two colored bands for the two neutrino mass orderings, is cut by the combination of cosmology and $0 nu 2 beta$ results within $Lambda"CDM"$. Assuming that the neutrino mass mechanism leads to the $0 nu 2 beta$ process (which thus assumes neutrinos are Majorana particles), KamLAND-Zen is able to exclude almost entirely the inverted ordering region. Cosmology further excludes the still-allowed IO region and a large fraction of the normal ordering. This sets a challenging target for next-generation $0 nu 2 beta$ searches to probe the region of $m_(beta beta) < 18 thin upright("meV")$ (the lowest value for the Majorana effective mass in the inverted ordering when considering measurements from neutrino oscillation experiments, i.e., the lowest value at the bottom of the black IO band in Fig.~#ref(<fig:mnu_pp>, supplement: none)). However, as discussed in, e.g.,~@DESI-BAO-VI@2024arXiv240902295S, these limits are model-dependent: for example, extended models with time-varying dark energy will relax the bounds on neutrino mass and bring the IO back into the allowed region. Cosmological bounds also assume that neutrinos are long-lived particles with a Fermi-Dirac distribution function. Models that deviate from these assumptions, such as scenarios featuring decaying neutrinos or neutrinos with average momenta larger than that of a thermal distribution~@2016PhRvD..93k3002D @2019PhRvD..99b3501L@2019JCAP...04..049O @2020JHEP...04..020C@2021PhRvD.103d3519C @2021JCAP...03..087B@2022JCAP...02..037A @2022PhRvD.105f3501A@2022arXiv220309075Z @2022JHEP...08..076A, would likely still be compatible with masses in the IO band.

The constraints on both $N_("eff")$ and $sum m_nu$ remain stable when varying both parameters at the same time, with $ mat(delim: "}", align: #left,
  N_("eff") = 2.85 plus.minus 0.25;
  sum m_nu < 0.073 "eV",
) quad (95%, "P-ACT-LB") $ and little correlation in the joint parameter region.

While the constraint on $N_("eff")$ agrees with SM predictions, the most probable value for $sum m_nu$ from cosmology is currently zero, in contrast with oscillation measurements. If this difference were to become significant with more precise data, it would imply a tension between our constraints on neutrino properties in the early universe versus neutrino measurements in the laboratory. Fortunately, with the increasing sensitivity of future CMB and BAO measurements, we can hope to determine the sum of neutrino masses to 0.02--0.03~eV precision~@CMB_S4_Science_Book@Simons_Observatory @2015AAS...22533605E#cite(<Enhanced_SO_2025>). \

=== Neutrino self-interactions
<sec:neu_si>
Neutrino self-interactions can arise in a class of BSM models, for example in models where Majorana neutrinos interact through a (pseudo)scalar, the Majoron $phi.alt$, related to the breaking of lepton number and to the generation of small neutrino masses @Chikashige:1980qk@Chikashige:1980ui#cite(<Schechter:1981cv>). In a wide class of models, the neutrino-Majoron coupling constant $g$, controlling the strength of neutrino self-interactions, is proportional to $m_nu / v_L$, where $m_nu$ is the neutrino mass and $v_L$ is the scale of the new physics that breaks lepton number. In general, a signature of neutrino self-interactions in cosmological observations might point to BSM physics. Here, we study the CMB phenomenology related to neutrino self-interactions arising from neutrino--neutrino scattering processes, which is mostly independent of the spin and parity properties of the mediator. The symbol $phi.alt$ in the following will denote a generic mediator, including the Majoron, unless otherwise stated. We consider interactions among the three active neutrinos that do not couple different mass eigenstates, and with eigenstate-independent strength (in other words, the matrix of couplings is proportional to the identity matrix in the mass basis).

Self-interactions affect the evolution of perturbations by making neutrinos behave, at certain times, as a collisional fluid and not as free-streaming particles. Acoustic oscillations will then propagate in the neutrino fluid and enhance, through gravity, the amplitude of photon fluctuations. Collisions will also cancel the characteristic phase shift imprinted on photon and matter perturbations by neutrino free streaming. These effects are relevant during the radiation-dominated era, when neutrinos provide a non-negligible contribution to the total energy density, and are imprinted at the time when perturbation modes re-enter the horizon. The range of scales affected thus also depends on the energy dependence of the scattering rate, which simplifies in the two limiting scenarios considered in the following: a very light ("massless") or very heavy mediator.

#block[
#emph[Heavy mediator]

]
We consider first the case where the mass $m_phi.alt$ of the mediator is much larger than the neutrino temperature at all times directly probed by CMB anisotropies #cite(<Cyr-Racine:2013jua>). In this case, the neutrino interaction is effectively a four-fermion vertex controlled by a dimensional coupling constant $G_(upright("eff")) = g^2 / m_phi.alt^2$, i.e., the effective low-energy Lagrangian is $cal(L)_(upright("eff")) = G_(upright("eff")) macron(nu) nu macron(nu) nu$. This is analogous to the low-energy behavior of standard weak interactions, just with $G_(upright("eff"))$ taking the place of the Fermi constant $G_("F") tilde.eq 1.17 times 10^(- 5) thin thin upright("GeV")^(- 2)$. This low-energy limit does not depend on the nature of the mediator, so the analysis here naturally encompasses both the scalar and vector cases. The Boltzmann hierarchy for neutrino perturbations including the collision term $cal(L)_(upright("eff"))$ generated by the interaction has been derived by #cite(<Kreisch:2019yzn>, form: "prose").

In this scenario, neutrino free-streaming does not start at the time of weak decoupling, but is instead delayed until $T_(upright("fs")) = T_(nu , upright("dec")) ( G_F / G_(upright("eff")) )^(2 / 3)$, where $T_(nu , upright("dec")) tilde.eq 1 thin upright("MeV")$ is the neutrino decoupling temperature. Neutrino self-interactions through a heavy mediator leave an imprint at angular scales $theta lt.eq theta_(upright("fs"))$ (assuming $theta_(upright("fs")) < theta_(upright("eq"))$), where $theta_(upright("fs"))$ is the scale entering the horizon at $T = T_(upright("fs"))$.

Previous analyses have shown that CMB and BAO data are compatible with, and in some cases prefer, neutrino self-interactions with $G_(upright("eff")) gt.double G_F$ @Cyr-Racine:2013jua@Archidiacono:2013dua@Lancaster:2017ksf@Oldengott:2017fhy@Park:2019ibn@Kreisch:2019yzn@Barenboim:2019tux@Brinckmann:2020bcn@Das:2020xke@Mazumdar:2020ibx@RoyChoudhury:2020dmd#cite(<2025arXiv250310485P>). In fact, the posterior for $G_(upright("eff"))$ has been found to be bimodal, with probability being concentrated in two distinct regions: a moderately interacting (MI$nu$) mode, compatible with no self-interactions, and a strongly interacting (SI$nu$) mode. The analysis of ACT DR4 data showed a slight preference for neutrino self-interactions at the $2 - 3 sigma$ level, finding $G_(upright("eff")) lt.eq 10^(- 3) thin upright("MeV")^(- 2)$ for MI$nu$, and $G_(upright("eff")) tilde.eq 10^(- 1.5) thin upright("MeV")^(- 2)$ for SI$nu$ #cite(<Kreisch_ACT_SIN>).

We start by considering a one-parameter extension of $Lambda"CDM"$, including $G_(upright("eff"))$ as an extra parameter and keeping fixed $sum m_nu = 0.06 thin upright("eV")$ and $N_("eff")=3.044$. To check if the bimodal behavior persists with the ACT DR6 spectra, we split the parameter space in two regions, $G_(upright("eff")) < 10^(- 2) med upright("MeV")^(- 2)$~(MI$nu$) and $G_(upright("eff")) > 10^(- 2) med upright("MeV")^(- 2)$~(SI$nu$), and perform separate MCMC runs with flat priors on $log_10 (G_(upright("eff")) thin "MeV"^2)$: $- 8 lt.eq log_10 (G_(upright("eff")) thin "MeV"^2) lt.eq - 2$ (MI$nu$) and $- 2 lt.eq log_10 (G_(upright("eff")) thin "MeV"^2) lt.eq 0$ (SI$nu$). The logarithmic prior allows us to explore a wide range of values of $G_(upright("eff"))$, spanning several orders of magnitude.

In the MI$nu$ region, the P-ACT~and P-ACT-LB~combinations are compatible with $G_(upright("eff")) = 0$, but show a mild preference for $log_10 (G_(upright("eff")) thin "MeV"^2) tilde.eq - 3$. In contrast, in the SI$nu$ region, the posteriors for the same dataset combinations peak at the lower edge of the prior range, i.e., at $log_10 (G_(upright("eff")) thin "MeV"^2) = - 2.0$. We show the two posteriors in Fig.~#ref(<fig:Geff_posterior>, supplement: none). Since we are performing separate parameter estimation runs for MI$nu$ and SI$nu$, we cannot use the distributions to assess the relative probability of the two scenarios. Instead we compare the effective $chi^2$ of MAP models in the two regions to that of the $Lambda"CDM"$~model, as reported in Table~#ref(<table:selfnu_chi2_transposed>, supplement: none). We find that the SI$nu$ model is never preferred over $Lambda"CDM"$. The MI$nu$ model yields basically no improvement to the goodness-of-fit for the ACT DR6 data alone with respect to $Lambda"CDM"$, while it gives marginal improvement for P-ACT~and P-ACT-LB. Specifically, we find $Delta chi_("MI" nu)^2 = 2.9$ (P-ACT) and $Delta chi_("MI" nu)^2 = 3.1$ (P-ACT-LB), corresponding respectively to a mild $1.7 sigma$ and 1.8$sigma$ preference over $Lambda"CDM"$, as computed using the likelihood-ratio test.

// [figvision-cn] imgs/fig25.png
// 这是一张科学论文中的概率密度（后验分布）曲线图，用于展
// 示不同数据集对中微子自相互作用有效耦合常数 log10(G_eff
// MeV^2) 的限制。全图由单一主坐标区构成（虽未标记 a、b
// 等子图字母，但根据断裂坐标轴分为两个独立归一化采样的区
// 域），视觉上呈现为双面板或断裂坐标轴的一张图表。 图例
// 位于图表正上方，包含两个条目：实线代表模型 “ΛCDM +
// G_eff”；虚线代表扩展模型 “ΛCDM + G_eff + N_eff + ∑m_ν”。
// 坐标轴方面，横轴标题为 “log10(G_eff MeV^2)”，实际使用
// 断裂的横轴将参数空间分成两个不连续区域：左侧区域范围约
// 为 -8 到 -2（刻度标注为 -8、-5、-2），右侧区域范围约为
// -2 到 -1（刻度标注为 -2、-1.5、-1），中间由两条斜线断
// 轴标记隔开。纵轴标题为 “P/P_max”，刻度范围从 0.0 到
// 1.0，间隔 0.2。 图中标注有四个数据集对应的不同颜色：
// ACT 为浅蓝色，Planck 为橙色，P-ACT 为深蓝色，P-ACT-LB
// 为紫色。区域标注文字为：左侧区域（横轴 -8 至 -2）标记
// 为 “MIν”；右侧区域（横轴 -2 至 -1）标记为 “SIν”。 曲线
// 描述与趋势：每种颜色各有两条曲线，实线表示基础模型，虚
// 线表示扩展模型。所有曲线均以各自区域内的最高后验概率点
// 归一化至 P/P_max = 1.0，因此左右两个区域之间不可直接比
// 较高度。在左侧 MIν 区域，P-ACT-LB（紫色）的实线具有最
// 高峰，峰位在 log10(G_eff MeV^2) ≈ -2.5，曲线较窄且近似
// 对称；Planck（橙色）实线峰位偏远，约在 -4.2，曲线非常
// 宽；ACT（浅蓝色）实线峰位在 -3 附近且较宽；P-ACT（深蓝
// 色）实线峰值略低，分布于 -2.8 至 -2.2 之间。对于虚线，
// Planck 的峰值在 -3.3 附近，ACT 的虚线峰位在 -2.9，
// P-ACT-LB 的虚线在约 -2.4 处有一个尖锐的峰。右侧 SIν 区
// 域，ACT 实线呈现最显著的双峰结构，最大值分别位于约
// -1.9 和 -1.7；Planck 实线在 -1.9 附近出现峰值；P-ACT
// 和 P-ACT-LB 实线峰位在 -1.9 左右，且迅速向高耦合常数方
// 向衰减。对于扩展模型的虚线，P-ACT-LB 在约 -1.9 至 -1.6
// 之间呈现较宽的峰，而 Planck 的虚线峰值较低，在 -2.0 至
// -1.6 范围内延伸并衰减。图中所有展示的后验概率均在 2σ
// 水平以内归零或显著衰减，表明数据对这两个模式下的 G_eff
// 均有明确上限。
#figure(image("imgs/fig25.png"),
  caption: [
    Posterior distribution of the neutrino self-interaction effective coupling constant, $G_(upright("eff"))$, for various datasets within the $Lambda "CDM" + G_(upright("eff"))$ model (solid lines) and the more extended case of ${Lambda"CDM"+G_"eff"+N_("eff")+sum m_(nu)}$ (dashed line). The posterior is presented in two distinct regions of parameter space, corresponding to the MI$nu$ and SI$nu$ modes, each independently normalized due to separate sampling. Analysis of the MAP models in the two regions shows that neutrino self-interactions are not preferred over $Lambda"CDM"$~(corresponding to $G_(upright("eff")) = 0$), for any dataset combination. In the $Lambda "CDM" + G_(upright("eff"))$ model, for P-ACT-LB~we find the MI$nu$ at $1.8 sigma$ and no peak for SI$nu$; a similar behavior is also found for the more extended model. Minimal smoothing is applied to the plot to preserve the features of the distribution.
  ],
  placement: top,
)
<fig:Geff_posterior>

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([], [ACT], [P-ACT], [P-ACT-LB],),
    table.hline(),
    [$Delta chi_("MI" nu)^2$], [$- 0.2$], [$2.9$], [$3.1$],
    [$Delta chi_("SI" nu)^2$], [$- 3.2$], [$- 10.6$], [$- 7.3$],
    [$sigma_("MI" nu)$], [--], [1.7], [$1.8$],
    [$sigma_("SI" nu)$], [--], [--], [--],
  )]
  , caption: [$Delta chi^2 equiv chi_(Lambda "CDM")^2 - chi_(Lambda "CDM" + G_("eff"))^2$ from the MAP points of the MI$nu$ and SI$nu$ regions for different data combinations. When self-interacting neutrino models yield an improvement of the fit over $Lambda"CDM"$~we also report the preference for the model in units of $sigma$. We find no statistically significant preference for neutrino self-interactions.]
  , kind: table
  ) <table:selfnu_chi2_transposed>
Since $G_(upright("eff")) = 0$ is compatible with the data, the posterior for the MI$nu$ scenario ideally extends with non-zero probability down to $log_10 (G_(upright("eff")) "MeV"^2) arrow.r - oo$. The posterior is therefore ill-defined with a diverging integrated probability. This prevents the computation of meaningful Bayesian credible intervals. Previous analyses chose to arbitrarily cut the distribution at some lower bound and reported credible intervals depending on this choice. Here, we take a different approach; once the information about the position of the peaks has been acquired from the runs with a logarithmic prior, the proposal density of the MCMC can be correspondingly tuned and we repeat the runs using a uniform prior on $G_(upright("eff"))^2$, namely $0 lt.eq G_(upright("eff"))^2 lt.eq ( 10^(- 2) thin "MeV"^(- 2) )^2$, ensuring a proper posterior. We choose a uniform prior on $G_(upright("eff"))^2$ rather than on $G_(upright("eff"))$ because the former amounts to a uniform prior on the scattering rate $Gamma prop G_"eff"^2$. Adopting this strategy, we find $ G_(upright("eff")) med ( "MI" nu ) < 7.9 times 10^(- 3) thin "MeV"^(- 2) med ( 95 % , sans("P-ACT-LB") ) . $

We repeat the analysis for a model in which only one of the three neutrino families is self-interacting. In this case, we find that both P-ACT~and P-ACT-LB~yield a posterior with a well-defined peak in the SI region; in particular, $log_10 (G_(upright("eff")) thin "MeV"^2) = - 1.33_(- 0.14)^(+ 0.21)$ (68% P-ACT-LB). The posterior in the MI region is instead qualitatively similar to the one found in the scenario with three interacting neutrinos. Both these single interacting-neutrino models are however not significantly preferred over $Lambda"CDM"$, with $Delta chi_("MI" nu)^2 = - 1.2$ and $Delta chi_("SI" nu)^2 = - 5.5$ (P-ACT-LB), corresponding respectively to a 1.1$sigma$ (MI$nu$) and 2.3$sigma$ (SI$nu$) preference over $Lambda"CDM"$.

We further consider a 9-parameter extended model with three interacting neutrinos in which, in addition to the base $Lambda"CDM"$~parameters and $G_(upright("eff"))$, also $N_("eff")$ and $sum m_nu$ are allowed to vary. As in #cite(<Kreisch_ACT_SIN>, form: "prose"), $N_("eff")$ is used to rescale the neutrino temperature. We find results similar to those for the $Lambda"CDM"$$+ G_(upright("eff"))$ model with three interacting neutrinos (see Fig.~#ref(<fig:Geff_posterior>, supplement: none)). In particular, we do not find a peak in the posterior in the SI region, in contrast to the mild preference for such a model seen in the analysis of the ACT DR4 data~#cite(<Kreisch_ACT_SIN>). The mild hint of SI$nu$ in the DR4 analysis was largely driven by a high fluctuation in the EE power spectrum at intermediate scales, $700 < ell < 1000$, which is no longer present in the DR6 spectra (see Appendix~@app:dr4dr6comp).

To summarize, we find that limits on interacting neutrino models are sensitive to the underlying assumptions used to describe the broader physics in the neutrino sector. However, neutrino self-interactions are not detected in any scenario that we consider and not preferred over $Lambda"CDM"$.

This lack of evidence also limits the ability of this model to increase the value of the Hubble constant. For example, a heavy mediator in the MI$nu$ scenario gives $H_0 = 68.2 plus.minus 0.4$~km/s/Mpc ($Lambda"CDM"$$+ G_(upright("eff"))$) and $H_0 = 67.5 plus.minus 1.0$~km/s/Mpc ($Lambda"CDM"$$+G_"eff"+N_("eff")+sum m_(nu)$) using P-ACT-LB. In general, we find no significant shift compared to $Lambda"CDM"$~for the $Lambda"CDM"$$+ G_(upright("eff"))$ model. In the extended case of $Lambda"CDM"$$+G_"eff"+N_("eff")+sum m_(nu)$, the $H_0$ distribution shifts lower by $tilde.op 1$~km/s/Mpc and has a twice larger uncertainty. This is driven by the ${N_("eff") - H_0}$ correlation and by ACT's preference for $N_("eff")lt 3.044$ found in $Lambda"CDM"$+$N_("eff")$ (see~§@sec:neu_n_m), which persists in this model. In the SI$nu$ scenario, we find instead $H_0 = 69.0 plus.minus 0.4$~km/s/Mpc ($Lambda"CDM"$$+ G_(upright("eff"))$) and $H_0 = 67.0 plus.minus 0.9$~km/s/Mpc ($Lambda"CDM"$$+G_"eff"+N_("eff")+sum m_(nu)$) for P-ACT-LB. The $tilde.op 1$~km/s/Mpc upward shift in $H_0$ in the $Lambda"CDM"$$+ G_(upright("eff"))$ model is induced by the positive correlation between $G_(upright("eff"))$ and $theta_s$. In the $Lambda"CDM"$$+G_"eff"+N_("eff")+sum m_(nu)$ model, this effect is countered by a lower value of $N_("eff")$, resulting in a lower value of $H_0$ with respect to the corresponding MI$nu$ scenario.

Laboratory searches, especially double-$beta$ decay experiments and observations of meson and lepton decays, severely constrain the coupling of neutrinos with a new light boson #cite(<Blinov:2019gcj>). Taken at face value, the values of $G_(upright("eff"))$ in the SI$nu$ region, as well as those corresponding to the MI$nu$ peak, are excluded by these searches as shown in Fig.~#ref(<fig:massive_self_nu>, supplement: none), unless the new scalar couples almost exclusively to $tau$ neutrinos.

// [figvision-cn] imgs/fig26.png
// 这是一张科学论文中的参数空间排除图，采用二维对数坐标展
// 示不同观测和实验对标量粒子与中微子耦合的限制。横轴为标
// 量粒子质量 m_φ，单位 MeV，范围从 10^-3 到 10^3，采用对
// 数刻度。纵轴为耦合常数 g，范围从 10^-3 到 10^0，同样采
// 用对数刻度。图中用不同颜色和填充样式的区域表示被排除的
// 参数空间，重叠区域呈现混合颜色。 图的顶部有一个图例框，
// 标题为 "Excluded regions:"，列出五种排除区域：浅蓝色对
// 应 ν_e（电子中微子），浅橙色对应 ν_μ（μ子中微子），浅
// 绿色对应 ν_τ（τ中微子），浅红色对应 BBN（大爆炸核合成），
// 紫色斜线填充对应 P-ACT-LB。图例下方有一个白色小框标注
// "Allowed by cosmo+lab."，对应图中未填充的白色区域。 浅
// 红色 BBN 排除区位于图中左上部分，覆盖 m_φ 从 10^-3 到
// 约 1 MeV、g 从约 10^-3 到 10^0 的范围。该区域在上述质
// 量范围内呈水平带状，其右边界在 m_φ 约 1 MeV 处垂直截断。
// 浅蓝色 ν_e 排除区覆盖 m_φ 约 0.3 MeV 以右的宽质量范围，
// 其下边界在 g 约 2×10^-3 处水平延伸，在 m_φ 约 3×10^0
// 处出现一个阶梯状下降，随后下边界随着质量增加而上升，最
// 终在 m_φ 接近 10^3 MeV 时上边界达到 g 约 10^0。浅橙色
// ν_μ 排除区位于 m_φ 约 1 MeV 以右，其上边界在 g 约 10^0
// 处水平延伸至 m_φ 约 3×10^2 MeV，然后陡峭下降，与浅蓝色
// 区域边缘形成近似垂直的斜率，下边界大致在 g 约 10^-2 附
// 近。浅绿色 ν_τ 排除区位于 m_φ 约 1 MeV 以右，覆盖 g 从
// 约 0.3 到 10^0 的范围，呈水平带状延伸至 m_φ 约 10^3
// MeV。紫色斜线填充的 P-ACT-LB 区域位于图中左下部分，覆
// 盖 m_φ 从 10^-3 到约 1 MeV、g 从 10^-3 到约 10^-2 的范
// 围，其右边界在 m_φ 约 1 MeV 处垂直截断，上边界在 g 约
// 10^-2 处水平延伸，与 BBN 区域重叠。所有排除区域重叠后，
// 图中白色未填充区域表示 "Allowed by cosmo+lab."，主要位
// 于 m_φ 约 1 MeV 以右、g 低于各中微子排除区下边界的区域，
// 以及在 m_φ 约 10^-3 到 1 MeV、g 低于约 0.01 但高于紫色
// 斜线区域下边界的部分。整体趋势显示，标量粒子质量在 MeV
// 量级附近时，耦合常数受到最严格的限制，允许的参数空间被
// 压缩在较小的范围内。
#figure(image("imgs/fig26.png"),
  caption: [
    Cosmological and laboratory limits on neutrino couplings with a new scalar $phi.alt$. The purple band with hatches in the upper left corner corresponds to the region excluded by P-ACT-LB~accounting for both MI and SI neutrinos. The other overlaid color bands are excluded by particle physics and BBN limits. The shaded blue region refers to scalars coupling to electron neutrinos and is excluded by neutrinoless double $beta$ decay searches @Blum:2018ljv@Kharusi:2021jez@NEMO-3:2013pwo@GERDA:2020xhi and measurements of the ratio $upright("Br") ( K^(+) arrow.r e^(+) nu_e ) / upright("Br") ( K^(+) arrow.r mu^(+) nu_mu )$ @Lessa:2007up. The orange shaded region is excluded by laboratory constraints on the decay $K^(+) arrow.r mu^(+) nu_mu phi.alt$ @ParticleDataGroup:2024cfk that apply to scalars coupling to $mu$ neutrinos. The green shaded region is excluded by laboratory constraints on the decay $tau^(-) arrow.r ell_alpha^(+) macron(nu)_alpha nu_tau phi.alt$ @Lessa:2007up, applying to scalars coupling to $tau$ neutrinos. The red-shaded region is excluded by BBN constraints on $N_("eff")$. Together, cosmology and laboratory measurements allow the parameter space remaining in the right bottom corner (in white).
  ],
  placement: top,
)
<fig:massive_self_nu>

#block[
#emph[Light mediator]

]
In this scenario the mediator mass is much smaller than the average neutrino momentum at all times of interest and the scattering rate $Gamma prop g^4 T$, so that the ratio between the scattering and Hubble rates increases with time. Neutrinos will then start free streaming at weak decoupling as usual, and become collisional again at later times @Archidiacono:2013dua@Forastieri:2015paa#cite(<Forastieri:2019cuf>). The effects of collisions are confined to scales between $theta_(upright("coll"))$, the scale entering the horizon when neutrinos stop free streaming at late times, and $theta_(upright("eq"))$. These correspond to intermediate angular scales in the CMB power spectra (larger scales compared to those affected by a heavy mediator) and so we expect less contribution to this limit from ACT DR6.

We write the thermally averaged cross section $chevron.l sigma v chevron.r = xi g^4 / T^2 equiv g_(upright("eff"))^4 / T^2$, where the coefficient $xi$ depends on the details of the interaction, including the nature of the mediator. We consider a one-parameter extension of $Lambda"CDM"$, varying $g_(upright("eff"))^4$ with a flat prior. As in the heavy mediator case, this is equivalent to a flat prior on the neutrino interaction rate $Gamma prop g^4$. We follow the approach of #cite(<Forastieri:2015paa>, form: "prose")@Forastieri:2019cuf where the collision term is approximated using the thermally-averaged scattering rate in the relaxation time approximation. From #emph[Planck] CMB data, we find $g_(upright("eff"))^4 < 1.5 times 10^(- 27)$ at 95% CL. The new ACT DR6 spectra alone give a limit about three times weaker, with $g_(upright("eff"))^4 < 5.2 times 10^(- 27)$ at 95% CL. Combining the two datasets gives a $tilde.op 20 %$ improvement on #emph[Planck] alone, with $ g_(upright("eff"))^4 & < & 1.2 times 10^(- 27) quad ( 95 % , sans("P-ACT") ) ,\
 & < & 1.3 times 10^(- 27) quad ( 95 % , sans("P-ACT-LB") ) , $ or $\| g_(upright("eff")) \| < 1.1 times 10^(- 7)$.

Neutrino couplings with a light scalar can be constrained from $0 nu 2 beta$ experiments and from supernovae explosions. These constraints are expressed in terms of the couplings $g_(alpha beta)$ in the basis of the eigenstates of the weak interaction, with $alpha , thin beta = e , thin mu , tau$, as opposed to the mass basis used in our analysis. The two bases are related through the neutrino mixing matrix. Currently, EXO-200 provides the most stringent laboratory limits on the electron neutrino-Majoron coupling: $\| g_(e e) \| < ( 0.4 - 0.9 ) times 10^(- 5)$ @Kharusi:2021jez, where the range expresses the uncertainty due to nuclear matrix elements. Supernova data can also be used to constrain neutrino-Majoron couplings. In particular, scalar emission might overly shorten the observed neutrino signal from SN1987A. This luminosity argument excludes the range of couplings $3 times 10^(- 7) < \| g_(alpha beta) \| < 2 times 10^(- 5)$ #cite(<Kachelriess:2000qc>). In most of the neutrino parameter space allowed by oscillation experiments, $max ( \| g_(alpha beta) ) \| tilde.op g_(upright("eff"))$ and P-ACT~yields the strongest constraints on neutrino interactions with a light (pseudo)scalar. In Fig.~#ref(<fig:massless_self_nu>, supplement: none), we show the posterior distribution for $g_(upright("eff"))^4$ for various data combinations, and compare with the limit from the luminosity argument. In the same figure we also show the mild correlation between $g_(upright("eff"))$ and the scalar spectral index $n_s$, which we interpret as the result of the additional power at intermediate scales (i.e., on the left of the pivot scale $k_(*)$) for $g_(upright("eff")) > 0$.

// [figvision-cn] imgs/fig27.png
// 该图由三个子图（a、b、c）和右上角图例组成，核心展示有
// 效中微子自耦合参数 \(10^{-27} g_{\rm eff}^4\) 与标量谱
// 指数 \(n_s\) 的联合约束。 子图 a（左上）：一维边缘后验
// 概率密度曲线图。横轴与子图 b 共用，表示 \(10^{-27} g_{
// \rm eff}^4\)，范围 0–10，无单位；纵轴未标注刻度，表示
// 概率密度。图中四条曲线对应不同数据集：紫色（P-ACT-LB）、
// 深蓝色（P-ACT）、橙色（Planck）、浅蓝色（ACT）。四条曲
// 线均在 \(10^{-27} g_{\rm eff}^4 \approx 0.5\)–1 处出现
// 峰值，随后下降；浅蓝色 ACT 曲线在 \(10^{-27} g_{\rm
// eff}^4 > 2\) 后形成明显长尾，衰减最慢；橙色 Planck 曲
// 线衰减最快。图右侧 \(10^{-27} g_{\rm eff}^4 > 8.2\) 区
// 域被红色斜线阴影覆盖，表示 SN1987A 光度论证排除的区域。
// 子图 b（左下）：二维参数置信区间图。横轴 \(10^{-27} g_
// {\rm eff}^4\) 范围 0–10；纵轴 \(n_s\) 范围 0.94–1.02。
// 彩色填充区域为 68% 和 95% 置信区间：紫色（P-ACT-LB）最
// 紧凑，中心约在 \((0.3, 0.974)\)；深蓝色（P-ACT）范围略
// 大；橙色（Planck）向低 \(n_s\) 方向延伸；浅蓝色（ACT）
// 覆盖最大范围（\(10^{-27} g_{\rm eff}^4\) 约 0–6，\(n_s
// \) 约 0.955–0.998），呈向右开口的椭圆。灰色水平带表示
// \(\Lambda\)CDM 模型下 \(n_s\) 的 68% 和 95% 可信区间（
// 约 0.964–0.978 和 0.958–0.984）。一条灰色水平虚线穿过
// 0.968 附近。右侧 \(10^{-27} g_{\rm eff}^4 > 8.2\) 区域
// 同样被红色斜线阴影覆盖。 子图 c（右下）：一维边缘后验
// 概率密度曲线图，为子图 a 旋转 90 度。纵轴 \(n_s\) 范围
// 0.94–1.02，与子图 b 共用；横轴未标注刻度，表示概率密度。
// 四条曲线颜色与子图 a 相同，均以 \(n_s \approx 0.974\)
// 为中心呈近似对称分布；浅蓝色 ACT 曲线最宽，紫色
// P-ACT-LB 最窄。背景灰色水平带同样对应 \(\Lambda\)CDM
// 的 \(n_s\) 约束。 右上角图例：紫色块标注 P-ACT-LB，深
// 蓝色块标注 P-ACT，橙色块标注 Planck，浅蓝色块标注 ACT，
// 浅灰色块标注 ACT（\(\Lambda\)CDM），红色斜线块标注 SN
// 1987A。所有阴影区域与曲线共同表明：除 ACT 外，各数据集
// 对 \(10^{-27} g_{\rm eff}^4\) 的限制均远低于 SN1987A
// 排除边界（8.2），且 \(n_s\) 约束与 \(\Lambda\)CDM 一致；
// ACT 数据允许更大的 \(g_{\rm eff}^4\)，导致 \(n_s\) 向
// 低值偏移，反映了 \(g_{\rm eff}^4\) 与 \(n_s\) 之间的简
// 并性。
#figure(image("imgs/fig27.png"),
  caption: [
    Constraints on the effective neutrino self-coupling, $g_("eff")^4$, in the light mediator limit from multiple data combinations. The hatched area is excluded by a luminosity argument applied to SN1987A. The shaded gray region shows the 68% and 95% credible intervals for $n_s$ in the $Lambda$CDM model (L25). The degeneracy with $n_s$ stems from the fact that large $g_(upright("eff"))$ increases power at scales typically larger than the pivot scale $k_(*) = 0.05 thin upright("Mpc")^(- 1)$, while increasing the slope of the primordial spectrum reduces the power at those scales. The inclusion of ACT shifts the contours to larger values of $n_s$, consistent with what is reported in~§@sec:running, and mildly tightens the bounds on $g_(upright("eff"))$ compared to #emph[Planck] alone.
  ],
  placement: top,
)
<fig:massless_self_nu>

== Helium and deuterium abundances
<sec:bbn>
Light elements formed in the early universe during BBN, with abundances depending on the baryon-to-photon density ratio, $eta_("b") equiv n_("b") / n_gamma$, and the number of relativistic degrees of freedom, $N_("eff")$. Throughout this section we assume no leptonic asymmetry in the electron neutrino sector, i.e., a vanishing chemical potential of electron neutrinos. Given the photon temperature today @Fixsen2009, $eta_("b")$ can be related to the physical baryon density $omega_b equiv Omega_b h^2$.

To compute primordial abundances of light elements as a function of $Omega_b h^2$ and $N_("eff")$ we can use various computational codes, each built upon different underlying assumptions. In this paper we make use of the `PRIMAT` @2018PhR...754....1P and `PRyMordial` @2024EPJC...84...86B codes in three configurations:

#block[
#set enum(numbering: "(a)", start: 1)
+ `PRIMAT_2021`: this is the default BBN computation used in `camb` version `1.5`, but it was not present in the public version of `class` at the time our analyses were performed.#footnote[We manually import `PRIMAT`-based tables from `camb` to use in `class`, as described in~§@sec:method. As of writing, `PRIMAT` has recently been included in the public version of `class`.] We use `PRIMAT` as the baseline BBN code in all analyses presented in this paper. It implements tabulated reaction rates based on theoretical ab-initio calculations (see #cite(<2018PhR...754....1P>, style: "aas_noparen.csl") and references therein for details) and assumes a neutron lifetime value $tau_("N") = ( 879.4 plus.minus 0.6 ) thin thin "s"$, i.e., the average provided in `PDG 2020` @2020PTEP.2020h3C01P;

+ `PRIMAT_2024`: uses the same rates as `PRIMAT_2021`, with an updated value of $tau_("N") = ( 878.4 plus.minus 0.5 ) thin thin "s"$ from `PDG 2024` @ParticleDataGroup:2024cfk;
+ `PRyMordial`: uses a modified version of the `NACRE II` database @2013NuPhA.918...61X for the thermonuclear rates (see #cite(<2024EPJC...84...86B>, style: "aas_noparen.csl") and references therein for details) and the same value of the neutron lifetime used by `PRIMAT_2024`, i.e., $tau_("N") = ( 878.4 plus.minus 0.5 ) thin thin "s"$.
]

These different BBN calculations return the same cosmological parameters and only affect the prediction of BBN abundances, so a distinction and detailed discussion is only required in this section. We focus on BBN predictions for the primordial helium abundance, expressed as the nucleon number density fraction, $Y_p equiv n_("He") / n_("b")$ --- rather than the mass fraction parameter $Y_("He")$ normally used in CMB calculations --- and the primordial deuterium abundance, $"D" / "H" equiv "D" / "H" \|_("p") times 10^5$. Astrophysical determinations of the helium abundance are primarily derived from observations of low-metallicity extragalactic HII regions, whereas deuterium abundances are measured from high-redshift quasar absorption systems. The latest determinations are summarized in `PDG 2024` which also provides average estimates for both elements#footnote[Section 24.3 of @ParticleDataGroup:2024cfk details the averaging procedure. The `PDG 2024` average helium abundance does not incorporate the recent measurements from the EMPRESS survey performed on the Subaru telescope @2022ApJ...941..167M, which indicate a helium abundance, $Y_p = 0.2370 plus.minus 0.0034$, $approx 2.4 sigma$ lower than the `PDG` value.], namely $Y_p = 0.245 plus.minus 0.003$ @2021JCAP...03..027A @2022MNRAS.510..373A@2019ApJ...876...98V @2021MNRAS.505.3624V@2019MNRAS.487.3221F @2021MNRAS.502.3045K@2020ApJ...896...77H and $"D" / "H" = 2.547 plus.minus 0.029$ @2014ApJ...781...31C @2016ApJ...830..148C@2015MNRAS.447.2925R @2016MNRAS.458.2188B#cite(<2017MNRAS.468.3239R>). We do not discuss here abundances of other light elements, such as tritium, $""^3 "He"$, and $""^7 "Li"$; these elements are more uncertain in both their determination and their interpretation @2011ARNPS..61...47F @2020ApJ...901..127I#cite(<ParticleDataGroup:2024cfk>).

=== Abundances assuming standard BBN
<abundances-assuming-standard-bbn>
Fixing the radiation density to its standard value (${N_("eff")=3.044}$), the baryon density in the baseline $Lambda"CDM"$~model can be directly related to the helium fraction. L25 shows that with the new ACT data the baryon density is measured to 0.5% uncertainty; for the three configurations listed above, this leads to#footnote[Note that $Y_p$ is only logarithmically sensitive to the baryon density, which leads to the small error bars here.] $ mat(delim: "}", align: #left,
  "(a)" Y_p = 0.24727;
  quad plus.minus 0.000046 (0.000131);
  "(b)" Y_p = 0.24707;
  quad plus.minus 0.000046 (0.000118);
  "(c)" Y_p = 0.24691;
  quad plus.minus 0.000049 (0.000153),
) quad (68%, "P-ACT-LB") $ where the first set of errors reflect only the uncertainty on $Omega_b h^2$ and the second in parentheses includes the theoretical BBN uncertainty added in quadrature. The shift between (a) and (b) is mainly driven by the different value adopted for the neutron lifetime, while the shift between (b) and (c) reflects the different treatment of the reaction rates and nuclear cross-sections between `PRIMAT` and `PRyMordial`; see @2024JCAP...06..006S for an exhaustive comparison. However, all these shifts are within the theoretical errors provided by the different codes, and encompassed by the `PDG` average of the observational bounds, which shows an order of magnitude larger error bar; see the upper panel of Fig.~#ref(<fig:ydomb>, supplement: none).

We find that relaxing the assumptions on the radiation density by varying $N_("eff")$ weakens the constraints on the helium fraction, substantially absorbing all the discrepancies between different BBN codes: $ mat(delim: "}", align: #left,
  "(a)" Y_p = 0.2448 plus.minus 0.0019;
  "(b)" Y_p = 0.2446 plus.minus 0.0018;
  "(c)" Y_p = 0.2445 plus.minus 0.0018,
) quad (68%, "P-ACT-LB"). $ <eq:bbn_Yp_standardBBN_varyngneff> Here the error is dominated by the uncertainty on $Omega_b h^2$ and $N_("eff")$, and the shift with respect to the $N_("eff")=3.044$ case is driven by the shift of $Omega_b h^2$ between $Lambda"CDM"$~and $Lambda"CDM"$+$N_("eff")$ models.

// [figvision-cn] imgs/fig28.png
// 该图为上下两个面板共享同一横坐标的约束对比图。横坐标为
// Ω_b h²（重子密度参数），范围 0.0215 至 0.0240，无单位。
// 图例位于下面板右侧，包含：Planck（橙色实心带）、P-ACT
// （深蓝色虚线边框带）、P-ACT-LB（紫色实心带）、PRIMAT（
// 绿色实心带）、PRyMordial（绿色空心虚线边框带）、PDG
// 2024（灰色实心带）。 上面板：纵坐标为 Y_p（原初氦质量
// 分数），范围 0.240 至 0.250，刻度间隔 0.002。图中有两
// 条绿色曲线：实线表示 PRIMAT 2021 预测，从 (0.0215,
// 0.2464) 缓慢上升至 (0.0240, 0.2478)；虚线表示
// PRyMordial 预测，从 (0.0215, 0.2462) 上升至 (0.0240,
// 0.2474)。两条绿色曲线几乎平行，实线略高于虚线。两条垂
// 直色带覆盖整个纵轴范围：橙色带（Planck）位于约 0.0222–
// 0.0225，宽度约 0.0003；深蓝色虚线边框带（P-ACT）位于约
// 0.0223–0.0228，宽度约 0.0005；紫色带（P-ACT-LB）位于约
// 0.0222–0.0229，宽度约 0.0007。灰色水平带（PDG 2024）位
// 于 Y_p 约 0.242–0.248，横跨整个横轴范围。绿色曲线在灰
// 色带内穿过，表明预测值与测量值一致。 下面板：纵坐标为
// D/H（氘氢比），范围 2.2 至 3.2，刻度间隔 0.2。图中有两
// 条绿色曲线：实线表示 PRIMAT 2021 预测，从 (0.0215,
// 2.62) 线性下降至 (0.0240, 2.22)；虚线表示 PRyMordial
// 预测，从 (0.0215, 2.80) 下降至 (0.0240, 2.32)。两条绿
// 色曲线斜率不同，虚线始终高于实线。垂直色带与上面板相同：
// 橙色带约 0.0222–0.0225，深蓝色虚线边框带约 0.0223–
// 0.0228，紫色带约 0.0222–0.0229。灰色水平带（PDG 2024）
// 位于 D/H 约 2.52–2.58，横跨整个横轴范围。绿色实线在 Ω
// _b h² 约 0.0225 处穿过灰色带，绿色虚线在 Ω_b h² 约
// 0.0222 处穿过灰色带，表明两种预测在各自对应的重子密度
// 下与测量值一致。图中所有色带均表示 68% 置信区间。
#figure(image("imgs/fig28.png"),
  caption: [
    Comparison of the constraints at 68% confidence on the baryon density $Omega_b h^2$ from ~(orange), P-ACT~(navy), and P-ACT-LB~(purple), versus the measured primordial helium fraction $Y_p$ (top panel) and deuterium fraction $"D" / "H"$ (bottom panel). The green bands show the $1 sigma$ predicted relations between the parameters according to `PRIMAT` 2021 (filled) and `PRyMordial` (empty dashed). The gray bands are the average $68 %$ confidence levels of the astrophysical measurements of these fractions, according to `PDG 2024`.
  ],
  placement: top,
)
<fig:ydomb>

Following the same approach, we can predict the deuterium abundance under the assumption of standard BBN. In the baseline $Lambda"CDM"$~model the baryon density translates into $ mat(delim: "}", align: #left,
  "(a)" "D"/"H" = 2.415 plus.minus 0.019 (0.036);
  "(b)" "D"/"H" = 2.413 plus.minus 0.019 (0.033);
  "(c)" "D"/"H" = 2.480 plus.minus 0.020 (0.104),
) quad (68%, "P-ACT-LB"). $ <eq:bbn_D_standardBBN>

For deuterium, the neutron lifetime value has a negligible impact @2022hnp..book..127G and the shift is substantially caused by differences between `PRIMAT` and `PRyMordial` calculations, and mainly driven by the different choices made for the reaction rates. Theoretical errors also reflect the different choices made in the marginalization procedure by `PRIMAT` and `PRyMordial` --- see again~@2024JCAP...06..006S for an exhaustive comparison. When compared to direct measurements of the deuterium abundance, estimations based on `PRIMAT` exhibit a mild tension, ranging between 2 and 3$sigma$. In contrast, the inferred values obtained using the `PRyMordial` computation are consistent with the `PDG` average, regardless of whether theoretical uncertainties are included; see the lower panel of Fig.~#ref(<fig:ydomb>, supplement: none).

In the $Lambda"CDM"$+$N_("eff")$ model, the scenario remains unchanged, with all constraints being shifted downward due to the higher baryon abundance found in this model $ mat(delim: "}", align: #left,
  "(a)" "D"/"H" = 2.384 plus.minus 0.029 (0.042);
  "(b)" "D"/"H" = 2.383 plus.minus 0.029 (0.040);
  "(c)" "D"/"H" = 2.455 plus.minus 0.028 (0.099),
) quad (68%, "P-ACT-LB"). $ <eq:bbn_D_standardBBN_varyngneff> Again, the deuterium abundance inferred assuming `PRyMordial` is consistent with astrophysical measurements while both `PRIMAT`-based estimates are in mild tension ($tilde.op 3 sigma$).

// [figvision-cn] imgs/fig29.png
// 该图由上下两个子图组成，均为二维参数约束等高线图（置信
// 椭圆），共享横轴 D/H。 子图 a（上子图）： 纵轴为 N_eff，
// 刻度范围从约 2.5 到 3.5（主刻度 2.6, 2.8, 3.0, 3.2,
// 3.4）。 图例位于左上角，包含三项： 紫色实心方块：
// P-ACT-LB (PRIMAT2021) 深灰色实心方块：P-ACT-LB (
// PRyMordial) 黑色虚线空心方块：P-ACT-LB-D-He (
// PRyMordial) 图中数据表现为三组倾斜的置信椭圆，均呈左下
// -右上走向，包含内层深色（约 1σ）和外层浅色（约 2σ）轮
// 廓： 第一组紫色椭圆（PRIMAT2021）中心约在 D/H=2.36，
// N_eff=2.91，其 1σ 椭圆横向跨度约 0.06，纵向跨度约 0.10。
// 第二组深灰色椭圆（PRyMordial）中心约在 D/H=2.44，N_eff
// =2.95，其 1σ 椭圆横向跨度约 0.05，纵向跨度约 0.08。 第
// 三组黑色虚线椭圆（PRyMordial，D-He）中心约在 D/H=2.46，
// N_eff=2.98，位置最靠右上，其 1σ 椭圆横向跨度约 0.06，
// 纵向跨度约 0.09。 背景包含绿色条带和灰色条带。绿色实线
// 带（PRIMAT 2021）和绿色虚线带（PRyMordial）均为斜向分
// 布，与椭圆的长轴方向平行。灰色垂直和水平条带（PDG 2024
// 相关）在图中形成交叉网格，垂直灰色带在 D/H 约 2.35 至
// 2.45 之间，水平灰色带在 N_eff 约 2.7 至 3.1 之间。水平
// 黑虚线位于 N_eff=3.044 处。 子图 b（下子图）： 纵轴为
// Y_p，刻度范围从约 0.238 到 0.252（主刻度 0.240, 0.245,
// 0.250）。 图例位于左上角，包含三项： 浅灰色实心方块：
// PDG 2024 with PRyMordial theoretical error 浅绿色实心
// 方块：PRIMAT 绿色虚线方块：PRyMordial 图中数据同样表现
// 为三组倾斜的置信椭圆，包含内外两层轮廓： 第一组紫色椭
// 圆（与图 a 中同源）中心约在 D/H=2.36，Y_p=0.2435。 第
// 二组深灰色椭圆（与图 a 中同源）中心约在 D/H=2.44，Y_p=
// 0.2445。 第三组黑色虚线椭圆（同图 a）中心约在 D/H=2.46，
// Y_p=0.2450。 背景中，浅灰色水平带（PDG 2024）覆盖 Y_p
// 约 0.242 至 0.247 范围。绿色实线带（PRIMAT）和绿色虚线
// 带（PRyMordial）呈斜向分布，与椭圆走向一致。绿色实线带
// 的位置略低于绿色虚线带。 整体趋势：两个子图展示了 D/H
// 与 N_eff、Y_p 之间的正相关性。不同方法（PRIMAT2021 与
// PRyMordial）给出的约束存在系统性偏移；引入 D-He 数据（
// 黑色虚线）后，约束椭圆向 D/H 和 N_eff/Y_p 更高的方向移
// 动。
#figure(image("imgs/fig29.png"),
  caption: [
    Constraints on the plane $N_("eff")$--$"D" / "H"$ (upper panel) and $Y_p$--$"D" / "H"$ (lower panel) from $sans("P-ACT-LB")$ assuming `PRIMAT` 2021 as BBN consistency (purple), $sans("P-ACT-LB")$ assuming `PRyMordial` (filled black), and $sans("P-ACT-LB-D-He")$ again assuming `PRyMordial` (dashed empty black). The green bands show predicted relations between the parameters according to `PRIMAT` 2021 (filled) and `PRyMordial` (empty dashed), assuming 1$sigma$ error on $Omega_b h^2$ from $sans("P-ACT-LB")$ in the $Lambda"CDM"$~model. The gray bands show the `PDG` averages with 68% and 95% errors obtained combining in quadrature the observational error and the `PRyMordial` theoretical error.
  ],
  placement: top,
)
<fig:yhedneff>

Given these results, we combine direct deuterium measurements, accounting for both observational and theoretical uncertainties, with the posterior distribution of $(Omega_(b) h^2, N_("eff"))$ only under the assumption of `PRyMordial` BBN calculations. This approach yields joint CMB+BBN predictions. After marginalizing over $Omega_b h^2$, we obtain $ N_("eff") = 2.87 plus.minus 0.13 quad (68%, "P-ACT-LB-D"). $ <eq:bbn_Neff_standardBBN_withD> The uncertainty on $N_("eff")$ remains substantially unchanged compared to the limit from P-ACT-LB~(§@sec:neutrinos), as the theoretical error on deuterium dominates. The mean of the distribution is shifted towards slightly higher values, driven by the higher astrophysical measurement of the deuterium abundance as shown in Fig.~#ref(<fig:yhedneff>, supplement: none).

We also expand this to include helium. In this case, the total uncertainty is dominated by the astrophysical measurement, which is only $50 %$ larger than the CMB determination (see Eq.~(#ref(<eq:bbn_Yp_standardBBN_varyngneff>, supplement: none))). Combining the CMB data with the `PDG` averages we get $ N_("eff") = 2.89 plus.minus 0.11 quad (68%, "P-ACT-LB-D-He"), $ <eq:bbn_Neff_standardBBN_withDandHe> which represents the tightest limit on $N_("eff")$ to date.

By assuming the `PDG` averages for helium and deuterium abundances and employing `PRyMordial` as the BBN calculator, we can also derive a pure BBN constraint on $N_("eff")$, finding $N_("eff") = 2.93 plus.minus 0.21 ; (68%,"D-He")$ after marginalizing over $eta_("b")$. This estimate shows that the number of neutrinos at BBN and at the CMB recombination epoch are in very good agreement.

=== Model-independent bounds on the helium fraction
<model-independent-bounds-on-the-helium-fraction>
Instead of deriving the primordial helium abundance from BBN codes using constraints on $(Omega_(b) h^2, N_("eff"))$, we can measure it directly with the CMB. Variations in $Y_("He")$ alter the density of free electrons between helium and hydrogen recombination, thereby affecting the damping tail of the CMB anisotropies. By sampling the $Lambda"CDM"$+$Y_("He")$ model and converting the helium mass fraction into the helium nucleon fraction, we find $ Y_p = 0.2312 plus.minus 0.0092 quad ( 68 % , sans("P-ACT-LB") ) , $ in good agreement with the astrophysical helium abundance measurements. Since both the helium abundance and the number of relativistic degrees of freedom influence the CMB damping tail, allowing both to vary simultaneously leads to weaker constraints $ mat(delim: "}", align: #left,
  Y_p = 0.227 plus.minus 0.014;
  N_("eff") = 3.14 plus.minus 0.25,
) quad (68%, "P-ACT-LB") $ This is still consistent with direct helium abundance measurements and with the expected number of neutrinos, but with larger errors. The relatively low values of $Y_p$ in this case have the same origin as the low value of $N_("eff")$ in the $Lambda"CDM"$+$N_("eff")$ model, since lower values of both of these parameters reduce the damping, which is preferred by the ACT data. The joint constraints in the ${N_("eff")-Y_{"He"}}$ plane are shown in Fig.~#ref(<fig:yheneff>, supplement: none), where the anti-correlation between these two parameters is clearly evident.

Considering the `PDG` collection of helium abundance measurements as an external dataset, it is possible to sample the $Lambda"CDM"$+$N_("eff")$+$Y_("He")$ model imposing a prior on $Y_p$, which leads to $ mat(delim: "}", align: #left,
  Y_p = 0.2444 plus.minus 0.0029;
  N_("eff") = 2.86 plus.minus 0.14,
) quad (68%, "P-ACT-LB-He") $ where the degeneracy between $N_("eff")$ and $Y_("He")$ is efficiently broken by helium measurements (see Fig.~#ref(<fig:yheneff>, supplement: none)) and the retrieved $N_("eff")$ constraint is consistent with the one obtained in the $Lambda"CDM"$+$N_("eff")$ model. \

// [figvision-cn] imgs/fig30.png
// 这是一张二维参数约束图，用于展示不同数据集对原初氦丰度
// Y_He 与有效中微子物种数 N_eff 的联合限制。图的横轴为
// N_eff，采用线性坐标，范围约为 1.5 至 4.3，主刻度标注为
// 2、3、4。纵轴为 Y_He，采用线性坐标，范围约为 0.17 至
// 0.31，主刻度标注为 0.20、0.25、0.30。 图中共有多个二维
// 置信区域，均为倾斜的椭圆，其长轴方向大致沿右下到左上，
// 表明 Y_He 与 N_eff 存在正相关趋势。每个数据集通常用两
// 种深浅不同的同色填充椭圆表示：内侧深色区域对应 68% 置
// 信区间，外侧浅色区域对应 95% 置信区间。 各数据集的颜色
// 与区域如下： 蓝色椭圆表示 ACT 数据，其 95% 区域在
// N_eff 方向覆盖约 1.7 至 3.9，在 Y_He 方向覆盖约 0.18
// 至 0.28，中心大致位于 N_eff≈2.8、Y_He≈0.23。 浅橙色椭
// 圆表示 Planck 数据，95% 区域在 N_eff 方向覆盖约 2.2 至
// 3.8，在 Y_He 方向覆盖约 0.21 至 0.29，中心大致位于
// N_eff≈2.9、Y_He≈0.25。 深蓝色椭圆表示 P-ACT 数据，95%
// 区域在 N_eff 方向覆盖约 2.3 至 3.6，在 Y_He 方向覆盖约
// 0.21 至 0.27。 紫色椭圆表示 P-ACT-LB 数据，95% 区域在
// N_eff 方向覆盖约 2.3 至 3.6，在 Y_He 方向覆盖约 0.21
// 至 0.27，且与 P-ACT 区域高度重叠。 黑色空心椭圆表示
// P-ACT-LB-He 数据，仅有轮廓线、无填充，位于紫色椭圆内部，
// 范围更小，中心大致在 N_eff≈3.0、Y_He≈0.245。 图中有一
// 条水平灰色带，标注为“PDG (2024)”；该带由深灰和浅灰两层
// 组成。深灰带范围约 0.245 至 0.250，对应 68% 误差；浅灰
// 带范围约 0.240 至 0.255，对应 95% 误差。所有数据集椭圆
// 均与该水平带相交，但中心位置略有差异。 图中有两条绿色
// 直线，分别表示理论预测关系。绿色实线标注为 PRIMAT，绿
// 色虚线标注为 PRyMordial。两条线几乎完全重合，从图左下
// 方向右上方延伸，斜率较缓。它们在 N_eff=3 处对应的 Y_He
// 约为 0.247，穿过 PDG 灰色带中心附近，并穿过
// P-ACT-LB-He 黑色空心椭圆区域。 图中有一条垂直黑色虚线，
// 位于 N_eff=3 处，贯穿整个纵轴范围，表示标准中微子物种
// 数的参考值。 图例位于图的左上角，分为三列：第一列从上
// 到下为 ACT（浅蓝色块）、Planck（橙色块）、P-ACT（深蓝
// 色块）；第二列为 P-ACT-LB（紫色块）、P-ACT-LB-He（黑色
// 空心框）；第三列为 PRIMAT（绿色实线）、PRyMordial（绿
// 色虚线）。 整体趋势与结论：各数据集给出的 Y_He 与
// N_eff 置信区域均沿正相关方向倾斜，且与理论预测线方向一
// 致；PDG 观测带与理论线在 N_eff≈3 附近交汇，P-ACT-LB-He
// 的约束最紧，其中心与 PDG 带和理论线的交点非常接近，表
// 明数据支持 N_eff 接近 3 且 Y_He 约在 0.245 附近。
#figure(image("imgs/fig30.png"),
  caption: [
    Constraints on the helium abundance, $Y_(upright("He"))$, and number of effective neutrino species, $N_("eff")$, with both parameters varying freely, for different data combinations. The horizontal bands are the `PDG` average of observational bounds with 68% and 95% errors. The green curves show the predicted relations between the parameters according to `PRIMAT` and `PRyMordial`, assuming the best-fit of P-ACT-LB, and the dashed black line marks the SM prediction of $N_("eff")=3.044$.
  ],
  placement: top,
)
<fig:yheneff>

== Axion-like particles
<sec:axions>
We constrain contributions to the total dark-sector content from ultralight axion-like particles (with masses between $10^(- 28) med < m_(upright("ax")) med / upright("eV") < 10^(- 24)$). This ultralight pseudo-scalar dark matter model is well-motivated by high-energy physics, as axions can generically arise from a variety of broken symmetries or compactified extra dimensions, the so-called "axiverse" @Arvanitaki:2009fg#cite(<Duffy:2009ig>). These ultralight axions suppress structure formation below their de Broglie wavelength, which manifests on astrophysical scales. The axion Jeans scale $lambda_J$, below which structure is smoothed out, depends on the axion mass: $lambda_J prop m_(upright("ax"))^(- 1 / 2)$ #cite(<amendola-etal:2006>)@Duffy:2009ig@Arvanitaki:2009fg#cite(<park-etal:2012>)#cite(<hlozek-etal:2015>)@Marsh:2015xka#cite(<hui-etal:2016>)#cite(<lague-etal:2021>)#cite(<ohare:2024>). The dynamics of the axion are described through the Klein-Gordon equation $ phi.alt^('') + 2 cal(H) phi.alt' + a^2 frac(d V, d phi.alt) = 0 . $<eq:axionEOM> Here $phi.alt$ is the axion field, with $phi.alt_0$ indicating its homogeneous component, and primes denote derivatives with respect to conformal time. In the simplest case with a quadratic axion potential, this simplifies to $ phi.alt^('') + 2 cal(H) phi.alt' + a^2 m_(upright("ax"))^2 phi.alt = 0 , $<eq:quadaxion> where $cal(H) equiv a' / a = a H$ is the conformal Hubble parameter, which acts as a friction term in the oscillator equation governing the axion dynamics. When the Hubble term drops (as the universe cools) to near the axion mass $m_(upright("ax")) tilde.eq 3 H ( a_(upright("osc")) )$, the axion field begins to coherently oscillate, and begins to behave as a dark matter component (with $rho_(upright("ax")) prop a^(- 3)$), whereas it behaves as a frozen-in "dark-energy-like" component at earlier times. This links the axion mass directly to its observational impact on the CMB and large-scale structure clustering. We solve for the relic axion density by solving the field equations given that $ Omega_(upright("ax")) = [1 / 2 (phi.alt'_0 / a)^2 + m_(upright("ax"))^2 / 2 phi.alt_0^2]_(m_(upright("ax")) = 3 H) a_(upright("osc"))^3 / rho_(upright("crit")) thin , $<eq.Omega_ax> where $rho_(upright("crit"))$ is the critical density at $z = 0$. We model the effects of axions via the `axionCAMB` Boltzmann solver,#footnote[#link("https://github.com/dgrin1/axionCAMB")] which has been used in several previous analyses of the impacts of axions on the CMB and LSS~#cite(<hlozek-etal:2015>)#cite(<hlozek-etal:2018>)#cite(<rogers-etal:2023>)#cite(<lague-etal:2021>). There have been several improvements in the full Boltzmann solution #cite(<liu-etal:2025>) that are particularly relevant in extreme ranges of parameter space that we do not consider here. We leave a full comparison between codes for future work.

In order to correctly model the power on small scales #cite(<hlozek-etal:2017>)#cite(<dentler-etal:2022>), we use a modified halo model including mixed dark matter #cite(<vogt-etal:2023>). The computational cost of both the halo model code and `axionCAMB` requires using an emulator for efficient computation. We employ the `axionEmu` emulator,#footnote[#link("https://github.com/keirkwame/axionEmu")] which is based on a modified version of `CosmoPower`.

We present our constraints on the allowed fraction of the dark matter density that is comprised of axions in Fig.~#ref(<fig:ULA>, supplement: none). For the lightest axion species $m_(upright("ax")) lt.eq 10^(- 28) med upright("eV")$ (not studied here, but see, e.g., #cite(<hlozek-etal:2015>, style: "aas_noparen.csl")) this represents a limit on how axions can constitute the dark energy. For the $m_(upright("ax")) gt.eq 10^(- 27) med upright("eV")$ axions that we consider here, constraints on the axion fraction reflect a disentangling of axion effects from standard cold dark matter in large-scale clustering.

Using the primary CMB spectra from #emph[Planck] alone or P-ACT, we find $ m_(upright("ax")) = 10^(- 26) thin thin "eV" : & \
Omega_(upright("ax")) / ( Omega_(upright("ax")) + Omega_c ) & < & 0.070 quad ( 95 % , thin sans("Planck") )\
 & < & 0.052 quad ( 95 % , thin sans("P-ACT") ) . $ The upper limits for $m_(upright("ax")) = 10^(- 27) thin thin upright("eV")$ are comparable between #emph[Planck] and P-ACT~at $4.5 %$, while P-ACT~reduces the allowed fraction of axion-like dark matter to roughly 5% (95% CL) for the mass $m_(upright("ax")) = 10^(- 26) thin upright("eV")$. For masses lighter than $m_(upright("ax")) < 10^(- 26) ,$ the axion starts to roll in its potential at later times, leading to changes in the primary CMB spectra on scales where #emph[Planck] is most constraining. Some of the improvement in the constraints comes from the degeneracy between the axion density and the scalar spectral index. As the preferred value of $n_s$ slightly increases between #emph[Planck] and P-ACT, the limits on the axion density also tighten. The impact of increased sensitivity in the temperature and polarization power spectra is more pronounced for the CMB lensing deflection power spectrum, particularly for $m_(upright("ax")) gt.eq 10^(- 25) thin upright("eV")$. A full presentation of axion constraints including the ACT DR6 lensing power spectrum, and detailed modeling of the nonlinear clustering that impacts the lensing deflection on small scales, will be provided in a future paper~(Laguë et al. in prep). \

// [figvision-cn] imgs/fig31.png
// 这是一张单面板柱状图（条形图），比较了两种数据集对轴子
// 分数（axion fraction）的限制。纵轴为对数刻度，标注为 Ω
// _ax/Ω_DM，表示轴子密度与暗物质密度的比值，范围从 10^-1
// 到 10^0，主要刻度线包括 10^-1 和 10^0，纵轴刻度线向内。
// 横轴为轴子质量，标注为 m_ax [log(m_eV)]，给出三个离散
// 的类别位置：-27、-26 和 -25（单位是对数化的毫电子伏特）。
// 图中包含图例，位于左上角，浅橙色（或浅土黄色）方块标注
// 为 Planck，深藏青色（深蓝色）方块标注为 P-ACT。每个质
// 量位置对应一对并排的柱子：左侧为深藏青色的 P-ACT 限制，
// 右侧为浅橙色的 Planck 限制。所有柱子的顶端均未显示数值
// 标签。在 -27 处，两根柱子都很低，P-ACT 柱略高于 Planck
// 柱，二者均在 10^-1 以下；在 -26 处，P-ACT 柱稍有升高，
// 仍明显低于 Planck 柱，Planck 柱接近 10^-1 但未达到；在
// -25 处，两根柱子均显著升高，P-ACT 柱约为 0.7 左右（介
// 于 10^-1 与 10^0 之间，靠近 10^0），Planck 柱更高，接
// 近但未达到 10^0。总体趋势是随着轴子质量从 -27 增加到
// -25，轴子分数上限显著增大；在 -26 处，P-ACT 的限制比
// Planck 更严格（柱更低），而在 -27 处两者接近，在 -25
// 处 Planck 的限制略宽松（柱更高）。图中不存在误差棒、散
// 点、曲线、色标或显微图像元素，也不包含比例尺或成像通道
// 信息。背景为白色，坐标轴边框为黑色实线，无网格线。图中
// 所有标注文字为：纵轴 Ω_ax/Ω_DM、横轴 m_ax [log(m_eV)]、
// 图例 Planck 和 P-ACT、横轴刻度标签 -27、-26、-25、纵轴
// 刻度标签 10^-1 和 10^0。
#figure(image("imgs/fig31.png"),
  caption: [
    Constraints on the axion fraction using P-ACT~(navy) compared to #emph[Planck] alone (orange). Combining ACT with #emph[Planck] significantly improves the constraints on the axion fraction compared to #emph[Planck] alone for the axion mass of $m_(upright("ax")) = 10^(- 26) thin upright("eV") .$ For lighter masses the axion starts to roll in its potential at later times, leading to changes on scales where #emph[Planck] has the majority of the constraining power. 
  ],
  placement: top,
)
<fig:ULA>

== Dark matter
<sec:dm>
Many compelling dark matter (DM) models can be tested with cosmological probes, including scenarios where DM interacts with baryons or annihilates into photons as described in this section, and scenarios where DM interacts with dark radiation (§@sec:idr) or with dark energy (§@sec:dedm).

=== DM-baryon interactions
<sec:dm-b>
Dark matter models beyond the standard paradigm of cold, collisionless DM (CDM) include scenarios in which DM interacts with baryons @Snowmass_2013@battaglieri2017cosmic@Gluscevic_2019#cite(<akerib2022snowmass2021>). As done in previous ACT analyses~@Li_ACT_DMB, we consider the specific case in which DM elastically scatters with protons @Gluscevic_2018@Boddy_2018 through a contact interaction. These models were previously explored using both linear cosmology @Boehm_2005@Sigurdson2004@Dvorkin2014@Gluscevic_2018@Boddy_2018@Boddy2018@Nguyen2021@Rogers_2022@Li_ACT_DMB@Slatyer_2018@Buen_Abad_2022@Hooper_2022@Becker_2021 and near-field cosmology @Maamari_2021@Nadler_2019@Nadler_2021#cite(<Gluscevic_2019>). In a DM-baryon scattering scenario, the two corresponding cosmological fluids exchange heat and momentum, leading to collisional damping of small-scale perturbations in the early universe. The strength of the interaction is quantified with the momentum-transfer cross-section $sigma_("MT") = sigma_0 ( v / c )^n$, where $v$ is the relative particle velocity (sourced primarily by thermal velocities at the redshifts of interest), $n$ is the power-law index determined by the interaction theory, and the cross-section normalization $sigma_0$ is a free parameter of the model.

We consider models with $n = - 4$, 0, and 2 and fix the DM particle mass to $m_chi = 1$~MeV. We choose a sub-proton mass because direct detection experiments probe values of $m_chi$ greater than 1~GeV, and constraints from $N_(upright("eff"))$ exclude thermal-relic DM with masses lower than $tilde.op 1$~MeV~@LEWIN199687#cite(<An_ACT_DM>). The choice of $m_chi = 1$~MeV allows us to explore the extreme end of what direct detection does not reach. We then choose to explore the set of $n$ values that correspond to the most salient DM-baryon scattering models: millicharged DM ($n = - 4$), a velocity-independent and spin-independent contact interaction ($n = 0$), and DM with a velocity-dependent contact interaction ($n = 2$) #cite(<Dvorkin2014>). We use a modified version of `class` @Gluscevic_2018@Boddy2018 that incorporates the effect of DM-baryon scattering in the linear-theory Einstein-Boltzmann equations. We assume a broad, flat, positive prior on $sigma_0$ for each value of $n$. Each interaction model is thus a single-parameter extension of $Lambda"CDM"$, for a given $n$ and DM particle mass.

// [figvision-cn] imgs/fig32.png
// 这是一张由三个纵向排列的子图组成的科学图表，子图从上到
// 下分别标记为n = -4、n = 0和n = 2。三个子图均为二维曲线
// 图，展示了不同模型下暗物质与质子弹性散射的动量转移截面
// 归一化参数（σ0）的一维边缘化后验概率分布。所有子图的横
// 轴均为σ0，但数值范围和单位不同；纵轴未标注具体名称和刻
// 度，但表示概率密度，所有曲线均从横轴左侧的高概率密度值
// 向右侧逐渐衰减至接近零。 第一个子图（顶部）标记为“n =
// -4”。横轴名称为“10^41 × σ0 [cm^2]”，范围从0.0到1.0，主
// 刻度间隔为0.2。图中包含四条曲线：橙色曲线（代表Planck）、
// 深蓝色曲线（代表P-ACT）、紫色曲线（代表P-ACT-LB）和浅
// 蓝色曲线（代表ACT）。橙色、深蓝色和紫色曲线几乎完全重
// 合，在σ0接近0时达到峰值，随后在σ0约为0.4至0.6之间迅速
// 下降并趋近于零。浅蓝色曲线（ACT）在σ0接近0时与其它曲线
// 起始值相近，但其衰减速度明显更慢，在横轴整个范围内呈平
// 缓下降趋势，在σ0 = 1.0时仍保持较高的概率密度值。 第二
// 个子图（中部）标记为“n = 0”。横轴名称为“10^26 × σ0 [cm
// ^2]”，范围从0.0到3.0，主刻度间隔为0.5。该子图右上角包
// 含图例，列出了四条曲线的颜色与对应标签：浅蓝色为ACT，
// 橙色为Planck，深蓝色为P-ACT，紫色为P-ACT-LB。四条曲线
// 均在σ0接近0时达到峰值。浅蓝色曲线（ACT）衰减最慢，在σ0
// 约为1.5至2.0之间才趋近于零。橙色曲线（Planck）衰减速度
// 居中，在σ0约为2.0至2.5之间趋近于零。深蓝色曲线（P-ACT）
// 和紫色曲线（P-ACT-LB）衰减最快，两条曲线几乎重合，在σ0
// 约为1.0至1.5之间就已趋近于零。 第三个子图（底部）标记
// 为“n = 2”。横轴名称为“10^21 × σ0 [cm^2]”，范围从0.0到
// 2.5，主刻度间隔为0.5。图中包含与中部子图相同的四条曲线。
// 与上面两个子图不同，这里的曲线峰值并不都在σ0 = 0处。橙
// 色曲线（Planck）在σ0接近0时具有最高值，随后单调下降。
// 深蓝色曲线（P-ACT）和紫色曲线（P-ACT-LB）几乎重合，其
// 峰值出现在σ0约为0.2至0.3之间，随后迅速下降，在σ0约为
// 1.0至1.5之间趋近于零。浅蓝色曲线（ACT）的峰值出现在σ0
// 约为0.5至0.6之间，其衰减最慢，在σ0 = 2.5时仍保持一定的
// 概率密度值。 整体趋势表明，对于n = -4和n = 2的情况，
// ACT数据的加入（浅蓝色曲线）并未显著改变P-ACT或P-ACT-LB
// 的约束结果（深蓝色和紫色曲线几乎重合），但ACT自身的约
// 束（浅蓝色曲线）明显弱于其它数据集，表现为曲线更宽、衰
// 减更慢。对于n = 0的情况，ACT数据的约束能力（浅蓝色曲线）
// 与Planck（橙色曲线）相近，但弱于P-ACT和P-ACT-LB（深蓝
// 色和紫色曲线）。
#figure(image("imgs/fig32.png"),
  caption: [
    Constraints on the normalization of the momentum-transfer cross-section $sigma_0$ for DM-proton elastic scattering are shown as 1D marginalized posterior probability distributions for three models: $n = - 4$ (top), $n = 0$ (middle), and $n = 2$ (bottom). In the top and bottom cases, the addition of ACT does not alter the constraint from ~(compare navy and orange lines). In the case of $n = 0$, ACT data (light blue) have similar constraining power to #emph[Planck], leading to a factor of two improvement in the upper bound when the two data sets are analyzed jointly. In all cases, the addition of lensing and BAO data only marginally affects the bounds.
  ],
  placement: top,
)
<fig:three_n_dm>

We present constraints corresponding to the three interaction scenarios in Fig.~#ref(<fig:three_n_dm>, supplement: none). For $n = - 4$, we find that ACT data do not improve on #emph[Planck] constraints, giving $sigma_0 ( n = - 4 ) < 6.1 times 10^(- 42) med upright("cm")^2 med ( 95 % , sans("P-ACT") )$; similarly, the addition of CMB lensing and BAO data has a negligible impact on the constraint. This is because the $n = - 4$ model produces a scale-independent suppression at high $ell$, and the high-multipole measurements from ACT do not add significantly to the signal-to-noise for this scenario. On the other hand, the $n = 0$ model produces a strong $ell$-dependent power suppression in both temperature and polarization~@he2025boundsvelocitydependentdarkmatterbaryon, and thus ACT alone has comparable constraining power to #emph[Planck], leading to an upper bound of $sigma_0 ( n = 0 ) < 1.7 times 10^(- 26) med upright("cm")^2 med ( 95 % , sans("ACT") )$. A combined analysis of ACT and #emph[Planck] data leads to a factor of two improvement in the upper bounds, $ sigma_0 ( n = 0 ) & < & 9.9 times 10^(- 27) thin thin upright("cm")^2 med ( 95 % , sans("P-ACT") ) ,\
 & < & 8.5 times 10^(- 27) thin thin upright("cm")^2 med ( 95 % , sans("P-ACT-LB") ) . $ For $n = 2$, ACT only marginally improves on #emph[Planck] constraints, giving $sigma_0 ( n = 2 ) < 1.5 times 10^(- 21) med upright("cm")^2$~(95%, P-ACT). The addition of CMB lensing and BAO data again has a minimal impact, giving $sigma_0 ( n = 2 ) < 1.2 times 10^(- 21) med upright("cm")^2 med ( 95 % , sans("P-ACT-LB") )$. As ACT data are particularly sensitive to power suppression on small scales, the difference in constraining power for $n = 0$ and $n = 2$ stems from the baryon-loading-like effect occurring in the $n = 2$ model, which leads to an enhancement of power at intermediate multipoles, rather than a strong suppression seen in the $n = 0$ case~#cite(<Boddy2018>).

The limits presented here are the tightest bounds on DM-baryon interactions obtained to date from linear cosmology. In particular, these bounds are consistent with and comparable to the results of joint analyses of #emph[Planck], BOSS, and DES data @he2023s8#cite(<he2025boundsvelocitydependentdarkmatterbaryon>). Meanwhile, the bounds obtained from highly nonlinear systems, such as the Milky Way satellite galaxy population, are stronger for all models that produce strong scale-dependent suppression (in this case, $n = 0 , 2$), as they lead to a notable decrement of small halos in the late universe @Maamari_2021@Nadler_2019#cite(<2024arXiv241003635N>). However, the non-linear modeling required for satellite analyses does not yet allow the exploration of the full cosmological parameter space, and the bounds obtained from near-field cosmology are thus not an apples-to-apples comparison to the present results. Moreover, mixed DM with a subcomponent interacting through velocity-independent ($n = 0$) scattering was also found to yield a lower value of $S_8$, by suppressing the linear matter power spectrum on semi-nonlinear scales~@he2023s8#cite(<he2025boundsvelocitydependentdarkmatterbaryon>). The ACT DR6 analysis results presented here are consistent with the preferred parameter space of interacting DM that reduces $S_8$ by a non-negligible amount, for the case where all DM interacts with protons. However, models that are most interesting in this context feature mixed DM and dedicated analyses of these scenarios are left for future work.

=== DM annihilation
<sec:dm-ann>
If DM annihilates into Standard Model particles, energy released by the annihilation process is injected into the photon-baryon plasma around the time of recombination. This energy injection affects the CMB by altering the ionization history so as to broaden the width of the last-scattering surface and introducing a unique signature in matter clustering. The main observational signatures in the CMB power spectra are: (i) damping of high-$ell$ power in both temperature and polarization; (ii) enhancement of the polarization power spectrum at $ell lt.eq 400$; (iii) shifts of the low-$ell$ acoustic peaks in polarization (e.g.,~#cite(<2005PhRvD..72b3508P>, style: "aas_noparen.csl") #cite(<PhysRevD.89.103508>, style: "aas_noparen.csl")#cite(<2019JCAP...04..025G>, style: "aas_noparen.csl")). The high-$ell$ signature is degenerate with other parameters that alter the damping tail, such as $n_s$; thus, most of the constraining power beyond #emph[Planck] for this model is anticipated to come from large-scale polarization measurements. Because of this, we do not expect major improvements in the constraints for this model from ACT DR6, given the scales probed by our data.

We follow earlier literature @Finkbeiner_2012 @PhysRevD.89.103508 and constrain the annihilation parameter $ p_(upright("ann")) = f_(upright("eff")) frac(chevron.l sigma v chevron.r, m_chi) $<eq:pann> where $m_chi$ is the DM particle mass, $chevron.l sigma v chevron.r$ is the thermally-averaged annihilation cross-section, and $f_(upright("eff"))$ is the fraction of the energy due to annihilation that is injected into the plasma~#cite(<Planck_2018_params>). The transferred energy fraction $f ( z )$ is indeed redshift-dependent, but this redshift dependence only weakly impacts the CMB and can thus be approximated by a constant fraction $f ( z ) approx f_(upright("eff"))$ @Slatyer_2016a#cite(<Slatyer_2016b>). Thus, $f_(upright("eff"))$ corresponds to the energy transferred to the plasma around the redshifts at which the CMB is most sensitive to DM annihilation ($z approx 500 - 600$) #cite(<Finkbeiner_2012>). We assume that this energy from DM annihilation is transferred to the plasma immediately, known as the “on-the-spot approximation” #cite(<Planck_2018_params>). We set a broad, flat prior on $p_(upright("ann")) in [ 0 , 10^(- 26) med upright("cm")^3 / upright("s") / upright("GeV") ]$ and use the implementation of this model in the current standard version of `class`.

// [figvision-cn] imgs/fig33.png
// 这是一张单面板科学曲线图，用于展示暗物质湮灭参数 p_ann
// 的后验概率密度分布。图中没有子图编号。 图表的横轴标注
// 为 p_ann [cm³/s/GeV]，坐标轴为线性刻度，显示范围从 0.0
// 到 2.0，并在横轴右下方标注了乘数 ×10⁻²⁷。因此，横轴实
// 际覆盖的物理量范围是 0 到 2.0×10⁻²⁷ cm³/s/GeV。纵轴没
// 有刻度标签、数值和单位，用于表示概率密度，基线位于底部，
// 各曲线在该基线上方呈现单峰分布。 图中绘制了四条平滑的
// 钟形概率密度曲线，线宽相同、颜色不同，均在横轴左侧（0
// 附近）达到峰值，随后向右侧下降并趋近于零。每条曲线都从
// 纵轴附近（即 p_ann = 0 处）开始急剧上升，在约 0.05×10⁻
// ²⁷ cm³/s/GeV 处达到各自的峰值，然后随着 p_ann 增大而衰
// 减。 具体曲线如下： 橙色曲线，对应图例文字“Planck”。该
// 曲线在峰值后约 0.5×10⁻²⁷ cm³/s/GeV 处衰减到接近基线，
// 是四条曲线中衰减较早的曲线之一，表明 Planck 数据单独给
// 出的后验分布较窄，峰值接近零。 浅蓝色曲线，对应图例文
// 字“ACT”。该曲线与其他三条明显不同，峰值之后衰减得非常
// 缓慢，形成一条向右延伸的长尾，在 1.0 至 2.0×10⁻²⁷ cm³/
// s/GeV 范围内仍维持较高概率密度。这表明仅使用 ACT 数据
// 时，后验分布非常宽且偏向更大的 p_ann 值，对暗物质湮灭
// 的上限约束最弱。 深蓝色曲线，对应图例文字“P-ACT”，即
// Planck 与 ACT 联合数据。该曲线的峰值较橙色曲线略微向右
// 移动，大概在 0.05 到 0.1×10⁻²⁷ cm³/s/GeV 之间，峰值高
// 度与橙色曲线接近，曲线宽度略大于橙色曲线，在约 0.5×10⁻
// ²⁷ cm³/s/GeV 处衰减到接近基线。这表示联合 ACT 与
// Planck 数据后，后验峰值略微偏离零，给出的上限比仅用
// Planck 时稍弱。 紫色曲线，对应图例文字“P-ACT-LB”，代表
// Planck、ACT、CMB 透镜和 DESI BAO 联合数据。该曲线的峰
// 值位置回到零附近，且下降最陡，在约 0.4×10⁻²⁷ cm³/s/GeV
// 处即衰减到接近基线，是四条曲线中最窄的一条，表明加入
// CMB 透镜和 DESI BAO 数据后，峰值被重新推回零，并给出了
// 比仅用 Planck 时略更严格的上限。 图例位于图表右上角，
// 是一个圆角矩形框，内部四行分别对应四条曲线：橙色线“
// Planck”、浅蓝色线“ACT”、深蓝色线“P-ACT”、紫色线“
// P-ACT-LB”。 整体趋势和结论：仅 Planck 数据的后验分布较
// 窄且峰值在零附近；仅 ACT 数据给出宽而长尾的分布；联合
// Planck 与 ACT 后峰值略微右移、上限略放宽；进一步加入
// CMB 透镜和 DESI BAO 数据后，峰值回到零，并给出比
// Planck 单独更紧的上限。
#figure(image("imgs/fig33.png"),
  caption: [
    Constraints on DM annihilation (see Eq.~(#ref(<eq:pann>, supplement: none))). The posterior peak shifts slightly away from zero when combining ACT and #emph[Planck] data, leading to a slightly weaker upper limit than that from #emph[Planck] alone. Including CMB lensing and DESI BAO data pushes the peak back to zero and yields an upper bound slightly tighter than that found with #emph[Planck].
  ],
  placement: top,
)
<fig:DMann>

The results of this analysis are summarized in Fig.~#ref(<fig:DMann>, supplement: none). We find no evidence of DM annihilation from the new ACT DR6 spectra, with $p_(upright("ann")) < 1.4 times 10^(- 27) med upright("cm")^3 / upright("s") / upright("GeV") med ( 95 % , sans("ACT") )$. When combining with #emph[Planck], we find that the joint upper limit does not improve upon the -only constraint of $p_(upright("ann")) < 3.9 times 10^(- 28) med upright("cm")^3 / upright("s") / upright("GeV") med ( 95 % )$,#footnote[We find a slightly weaker bound for #emph[Planck] alone than that in Eq.~(89a) of~@Planck_2018_params; this may be due to a slight shift of the central value arising from our use of `Sroll2` for the low-$ell$ EE data, which is particularly important in constraining this model.] but this is primarily due to the peak of the posterior for $p_(upright("ann"))$ shifting slightly away from zero, as can be seen in Fig.~#ref(<fig:DMann>, supplement: none). The joint constraint gives $p_(upright("ann")) < 4.1 times 10^(- 28) med upright("cm")^3 / upright("s") / upright("GeV") med ( 95 % , sans("P-ACT") )$. The addition of CMB lensing and BAO data helps to tighten the constraints and pushes the peak of the posterior back to zero, yielding $p_(upright("ann")) < 3.6 times 10^(- 28) med upright("cm")^3 / upright("s") / upright("GeV") med ( 95 % , sans("P-ACT-LB") )$. Further addition of SNIa data does not tighten this limit. While the ACT DR6 data do not significantly improve constraints on $p_(upright("ann"))$ beyond those from #emph[Planck], future improvements from large-scale CMB polarization data are expected (see, e.g.,~#cite(<PhysRevD.89.103508>, style: "aas_noparen.csl") #cite(<2019JCAP...04..025G>, style: "aas_noparen.csl")).

== Interacting dark radiation
<sec:idr>
=== Self-interacting DR
<sec:si_dr>
A wide range of dark radiation (DR) models have been constructed, beyond the simple free-streaming case parameterized by $N_(upright("eff"))$~@Jeong_Takahashi_2013@Buen-Abad_2015@Cyr-Racine_2016@Lesgourgues_2016@Aloni_2022@Joseph_2023@Buen-Abad_2023@Rubira_2023@Schoneberg_2023#cite(<Zhou_Weiner_2024>). These models generically involve self-interactions amongst the DR, interactions between the DR and (a subset of) the DM, or combinations thereof, potentially with non-trivial time-dependence (e.g., due to the temperature of the DR-DM sector falling below the mass of a massive mediator particle). As a first step toward investigating these scenarios, we consider a simple model of (strongly) self-interacting DR (SIDR), for example due to a new gauge interaction in the dark sector. At the background level, this model is identical to $N_(upright("eff"))$, with a free parameter $N_(upright("idr")) gt.eq 0$ describing the number of additional relativistic species (and hence the additional DR energy density). However, the SIDR and free-streaming DR models differ at the perturbative level: the SIDR forms a perfect relativistic fluid with $w = 1 / 3 = c_s^2$, with interactions sufficiently strong that no anisotropic stress (or higher-order Boltzmann moments) can be supported. Thus, the perturbative dynamics are characterized fully by the continuity and Euler equations. Unlike free-streaming DR, SIDR can cluster on small scales, thus reducing the impact of Silk damping on the high-$ell$ power spectra (at fixed DR energy density). In addition, SIDR generates a smaller phase shift in the power spectra. Thus, CMB fits to the SIDR model can accommodate larger amounts of DR than the free-streaming DR model, which can thus allow higher values of $H_0$~@Aloni_2022@H0_olympics_2022#cite(<Allali_2024>).

We consider a simple SIDR model parameterized solely by $N_(upright("idr"))$, with $N_(upright("idr")) gt.eq 0$. We assume no interactions between the SIDR and the DM. We use the implementation of this model in `class`#footnote[We set `idm_dr_tight_coupling_trigger_tau_c_over_tau_h = 0.005` and `idm_dr_tight_coupling_trigger_tau_c_over_tau_k = 0.008` to ensure high accuracy, identical to the values we use for the analogous `class` accuracy parameters in the SM sector (see Appendix~@app:theory).] and we adopt a flat, uninformative prior $N_(upright("idr")) in [ 0 , 6 ]$. We assume that the SM neutrino sector consists of one massive state carrying 0.06 eV and two massless states, with $N_(upright("eff")) = 3.044$.

// [figvision-cn] imgs/fig34.png
// 这是一张三角图（corner plot），用于展示两个参数的后验
// 概率分布及其相关性。图中共包含三个子图，分别标记为左上、
// 左下和右下区域（未标注字母a/b/c，按位置描述）。图中图
// 例显示三种数据集：橙色代表Planck，深蓝色代表P-ACT，紫
// 色代表P-ACT-LB。 左上子图为一维边缘概率密度曲线图。横
// 轴为H0（单位未标注，通常为km/s/Mpc），范围约66至72；纵
// 轴为概率密度（无刻度）。三条曲线均为实线，呈近似高斯峰
// 形。橙色曲线峰值约在67.5，分布最宽，右侧长尾延伸至72以
// 上；深蓝色曲线峰值约在68.2，分布较窄；紫色曲线峰值约在
// 68.5，分布最窄。该图表明，加入ACT DR6数据后，H0的约束
// 显著收紧，且对H0>70 km/s/Mpc的值有明显压低。 右下子图
// 为一维边缘概率密度曲线图。横轴为Nidr，范围约0至0.7；纵
// 轴为概率密度（无刻度）。三条曲线均为实线，呈右偏分布。
// 橙色曲线在Nidr=0处起始最高，缓慢下降，在Nidr约0.6处趋
// 近于零；深蓝色曲线下降更陡，在Nidr约0.2处已接近零；紫
// 色曲线下降最陡，在Nidr约0.15处接近零。该图表明，P-ACT
// 和P-ACT-LB对Nidr的上限约束比Planck更严格。 左下子图为
// 二维等高线图（置信区间）。横轴为H0，范围66至72；纵轴为
// Nidr，范围0至0.6。图中显示三组填充等高线：橙色区域最宽，
// 覆盖H0约66.5至71.5、Nidr约0至0.45；深蓝色区域较窄，覆
// 盖H0约66.5至69.5、Nidr约0至0.25；紫色区域最窄，覆盖H0
// 约67至69.5、Nidr约0至0.18。等高线呈左下-右上倾斜的椭圆
// 状，表明H0与Nidr存在正相关趋势。橙色区域在H0>70处仍有
// 较大面积，而深蓝和紫色区域在该区域基本消失，说明ACT数
// 据显著排除了高H0与高Nidr的组合。图中所有标注文字包括图
// 例中的“Planck”、“P-ACT”、“P-ACT-LB”，以及坐标轴标签“H0
// ”和“Nidr”。
#figure(image("imgs/fig34.png"),
  caption: [
    Constraints on the number of strongly self-interacting dark relativistic species, $N_(upright("idr"))$. The addition of ACT DR6 spectra improves the constraint from #emph[Planck] by more than a factor of three (navy versus orange) and notably disfavors values of $H_0$ above 70~km/s/Mpc that are allowed by #emph[Planck] alone. Inclusion of CMB lensing and DESI BAO data (purple) slightly weakens the SIDR upper limit due to small shifts in the best-fit model parameters, but nevertheless further tightens the $H_0$ posterior. These are the tightest bounds on SIDR obtained to date.
  ],
  placement: top,
)
<fig:SIDR>

Constraints on this model are presented in Fig.~#ref(<fig:SIDR>, supplement: none). From the ACT DR6 primary CMB power spectra alone, we find $ N_(upright("idr")) & < & 0.339 quad quad quad med ( 95 % , thin sans("ACT") )\
H_0 & = & 66.85_(- 1.0)^(+ 0.85) thin thin quad ( 68 % , thin sans("ACT") ) . $ Including #emph[Planck] primary CMB power spectra, we obtain $ N_(upright("idr")) & < & 0.114 quad quad quad med ( 95 % , thin sans("P-ACT") )\
H_0 & = & 68.00_(- 0.63)^(+ 0.55) thin quad ( 68 % , thin sans("P-ACT") ) . $ The joint P-ACT~constraint represents more than a factor-of-three improvement over the constraint from #emph[Planck] alone, for which we find $N_(upright("idr")) < 0.379$ at 95% confidence. The origin of this tight constraint is the lack of preference for excess high-$ell$ damping in the DR6 power spectra; since SIDR can only increase damping (due to the physical bound $N_(upright("idr")) > 0$), its existence is thus disfavored by the data. From the primary CMB, we thus see no evidence of additional SIDR species, extending our results for the free-streaming DR case ($N_("eff")$) to a very different physical regime.

Including additional low-redshift datasets does not significantly tighten the bound on $N_(upright("idr"))$, but further tightens the error bar on $H_0$ and other cosmological parameters. From the combination of ACT and #emph[Planck] CMB spectra, ACT and #emph[Planck] CMB lensing, and DESI BAO, we obtain $ N_(upright("idr")) & < & 0.134 quad quad med med ( 95 % , thin sans("P-ACT-LB") )\
H_0 & = & 68.59_(- 0.50)^(+ 0.41) thin med ( 68 % , thin sans("P-ACT-LB") ) . $ The upper limit on $N_(upright("idr"))$ weakens slightly compared to that found for P-ACT~above, due to small shifts in the best-fit parameter values. Further including SNIa data in the analysis yields negligible changes to these constraints.

The MAP SIDR model found for P-ACT, as well as that found for P-ACT-LB, yields negligible improvement in the quality of fit over $Lambda$CDM --- in fact, we find that the MAP SIDR model lies at the $Lambda"CDM"$~limit of the parameter space in both cases, i.e., with $N_(upright("idr")) = 0$, indicating no preference for this model extension. We emphasize again that this lack of preference arises from the lack of excess damping seen at high-$ell$ in ACT: because SIDR can only increase damping over that in $Lambda"CDM"$, the model cannot accommodate decreased damping (unlike $N_(upright("eff"))$, which can do so via a value of $N_(upright("eff")) < 3.044$).

These are the tightest bounds on SIDR presented to date. The ability of this model to increase the value of $H_0$ inferred from cosmological data is strongly limited by these observations, with the new ACT DR6 spectra playing a crucial role in significantly tightening the constraints compared to those from #emph[Planck].

=== Interacting DR-DM
<sec:i_dr_dm>
A wide range of dark sector models have been considered in the literature, featuring various types of interactions between dark radiation and dark matter species~@Cyr-Racine_2016@Buen-Abad_2015#cite(<Lesgourgues_2016>). As a first step in probing this space of models, here we consider the fiducial scenario studied in~#cite(<Rubira_2023>, form: "prose"), in which an SIDR fluid (identical to that studied above) interacts with all of the DM via an interaction with a momentum transfer rate $Gamma ( a ) = Gamma_(0 , n a d m) a^(- 2)$ between the DM and the DR~#cite(<Buen-Abad2018>). Microphysically, such an interaction can be realized in dark-sector models featuring non-Abelian gauge bosons (hence the "nadm" subscript) that mediate interactions between Dirac fermion DM particles~@Buen-Abad_2015#cite(<Lesgourgues_2016>). In this particular model, $Gamma$ has a redshift (or temperature) dependence that matches that of the Hubble rate during radiation domination --- see @Buen-Abad_2015 for an explicit calculation of the momentum transfer rate in the "nadm" model. As a consequence, the interaction between the DR and the DM is relevant while modes covering a broad range of scales enter the horizon (essentially during all of radiation domination), which leads to a roughly scale-invariant suppression of power for such modes. This makes the model a promising candidate to decrease the CMB-inferred value of $S_8$~@Buen-Abad_2015#cite(<Rubira_2023>). The SIDR abundance (set by $N_(upright("idr"))$) determines the scale where power is suppressed, while the interaction strength $Gamma_(0 , n a d m)$ determines the amount of suppression~#cite(<Buen-Abad_2015>).#footnote[Note that the IDR-IDM interaction studied here is not relevant in the late universe, and thus late-time growth is not affected; modifications to structure formation are captured by the change in the linear matter power spectrum.]

// [figvision-cn] imgs/fig35.png
// 这是一张二维参数约束相图（等高线/置信区间图），用于展
// 示不同数据集对IDR-IDM模型参数的限制。横轴为N_idr (IDM)，
// 表示IDR（相互作用暗辐射）的参数，范围从0.0到0.7左右，
// 刻度为0.0、0.2、0.4、0.6，无单位；纵轴为Γ_0,nadm [1/
// Mpc]，表示相互作用强度，范围从0到5×10^-7，刻度为0、1×
// 10^-7、2×10^-7、3×10^-7、4×10^-7、5×10^-7，单位为1/Mpc。
// 图中包含三个填充色区域，代表不同数据集组合的95%置信区
// 间：橙色区域（Planck）、深蓝色区域（P-ACT）、紫色区域
// （P-ACT-LB）。这些区域在图中呈向右展开的扇形，所有区域
// 在N_idr接近0处均收敛于纵轴附近，随着N_idr增大，对Γ_0,
// nadm的约束上限逐渐放宽。橙色区域覆盖范围最广，在N_idr
// 约0.5时Γ_0,nadm上限仍可达约1×10^-7；深蓝色区域显著收缩，
// 在N_idr约0.2时上限已降至约0.5×10^-7；紫色区域进一步收
// 紧，在N_idr约0.1时上限已降至约0.3×10^-7。图中未标注具
// 体数值文字，仅通过色块和坐标轴传达约束范围。该图传达的
// 结论是：加入ACT DR6光谱数据（深蓝色）相比仅使用Planck
// 数据（橙色）能显著改善约束；进一步加入CMB透镜和DESI
// BAO数据（紫色）虽因最佳拟合参数微小偏移而略微放宽上限，
// 但总体上对N_idr的约束更紧。
#figure(image("imgs/fig35.png"),
  caption: [
    Constraints on the IDR-IDM model. Here the interaction strength $Gamma_(0 , n a d m)$ is given in 1/Mpc. The inclusion of ACT DR6 spectra (navy) significantly improves the constraints from #emph[Planck] alone (orange). Inclusion of CMB lensing and DESI BAO data (purple) slightly weakens the $N_(upright("idr"))$ upper limit due to small shifts in the best-fit model parameters, but further tightens the constraint on $Gamma_(0 , n a d m)$. The notation $N_(upright("idr"))$ (IDM) indicates that the IDR in the model constrained here is interacting with the DM, unlike that in Fig.~#ref(<fig:SIDR>, supplement: none).
  ],
  placement: top,
)
<fig:SIDR_IDM>

We use the implementation of this interacting DR -- interacting DM (IDR-IDM) model in `class`~@Lesgourgues_2016#cite(<Archidiacono2019>). The model contains two additional free parameters beyond those of base $Lambda"CDM"$: $N_(upright("idr"))$ (as in the SIDR model above) and $Gamma_(0 , n a d m)$. We adopt the same priors and model assumptions as for the SIDR scenario for all common parameters, while for $Gamma_(0 , n a d m)$, we adopt an uninformative, uniform prior $Gamma_(0 , n a d m) / ( upright("Mpc")^(- 1) ) in [0.0 , 5.0 times 10^(- 7)]$.

We find no preference for the IDR-IDM scenario in the ACT DR6 spectra. Constraints on this model are shown in Fig.~#ref(<fig:SIDR_IDM>, supplement: none). Joint analysis of ACT and #emph[Planck] yields $ mat(delim: "}", align: #left,
  N_("idr") < 0.0977;
  Gamma_(0, "nadm") < 4.45 times 10^(-7) "Mpc"^(-1),
) quad (95%, "P-ACT"). $ This is a significant improvement over analogous results from #emph[Planck] alone, for which we find $N_(upright("idr")) < 0.367$ at 95% CL~and no bound on $Gamma_(0 , n a d m)$ (at 95% CL). We find negligible reduction in $S_8$ in the P-ACT~fit to the IDR-IDM model, with $S_8 = 0.814_(- 0.015)^(+ 0.023)$ at 68% CL. Inclusion of CMB lensing and DESI BAO data in the combined dataset yields: $ mat(delim: "}", align: #left,
  N_("idr") < 0.135;
  Gamma_(0, "nadm") < 4.09 times 10^(-7) "Mpc"^(-1),
) quad (95%, "P-ACT-LB"). $ The bound on $S_8$ tightens considerably compared to P-ACT, with $S_8 = 0.808_(- 0.0095)^(+ 0.013)$ at 68% CL, further limiting this model's ability to yield low values of this parameter.

We note that Bayesian constraints on the IDR-IDM model can suffer from volume effects, since $Gamma_(0 , n a d m)$ becomes degenerate in the $N_(upright("idr")) arrow.r 0$ limit. We thus confirm that the best-fit IDR-IDM model to P-ACT~or P-ACT-LB~does not yield a significantly better fit to these data than $Lambda"CDM"$. In fact, as found for SIDR, we find that the MAP model in the IDR-IDM scenario for both P-ACT~and P-ACT-LB~is indistinguishable from $Lambda"CDM"$~within our numerical precision. Overall, we see no evidence of extended dark-sector physics in this analysis. \

= Gravity and late-time physics
<sec:late-time>
== Geometry: spatial curvature
<sec:curv>
// [figvision-cn] imgs/fig36.png
// 这是一张二维参数约束等高线图（相图/置信区间图），用于
// 展示宇宙学参数 Ω_m（物质密度）与 Ω_k（曲率）的限制情况。
// 横轴为 Ω_m，刻度范围 0.26 至 0.34，主刻度为 0.26、0.28、
// 0.30、0.32、0.34；纵轴为 Ω_k，刻度范围 -0.0075 至
// 0.010，主刻度为 -0.005、0.000、0.005、0.010。纵轴在 Ω
// _k = 0.000 处有一条水平灰色虚线贯穿全图，表示平坦宇宙。
// 图右上角有图例：深蓝色文字 "P-ACT"，橙色文字 "
// Planck-LB"，紫色文字 "P-ACT-LB"。 图中共包含三组等高线
// 区域，均为嵌套的椭圆状，但中心位置和形状不同。 第一组
// 为深蓝色区域（P-ACT），两组嵌套等高线。外层深蓝色等高
// 线大致从横轴 Ω_m ≈ 0.295、纵轴 Ω_k ≈ 0.004 处向下延伸，
// 形成一条指向右下方 Ω_m ≈ 0.34、Ω_k ≈ -0.0075 的狭长宽
// 带，宽度约为 ΔΩ_m ≈ 0.015；内层深蓝色实心区域位于 Ω_m
// ≈ 0.328 至 0.34、Ω_k ≈ -0.006 至 -0.0075 的右下方局部，
// 形状为半椭圆，被图的右边界和下边界截断。该区域整体呈斜
// 向拉长的形状，表明存在 Ω_m 与 Ω_k 之间的参数简并。 第
// 二组为橙色区域（Planck-LB），两组嵌套的椭圆等高线。橙
// 色填充区域中心约在 Ω_m ≈ 0.303、Ω_k ≈ 0.0025 附近，水
// 平方向覆盖 Ω_m ≈ 0.287 至 0.320，垂直方向覆盖 Ω_k ≈
// -0.002 至 0.006。外层橙色轮廓较宽，内层橙色较窄，整个
// 椭圆略微向左上方倾斜。 第三组为紫色区域（P-ACT-LB），
// 两组嵌套的椭圆等高线，位于橙色椭圆内部并与其部分重叠。
// 紫色填充区域中心约在 Ω_m ≈ 0.301、Ω_k ≈ 0.001 附近，水
// 平覆盖 Ω_m ≈ 0.291 至 0.311，垂直覆盖 Ω_k ≈ -0.001 至
// 0.004；内层紫色实心区域进一步缩小，中心约 Ω_m ≈ 0.300、
// Ω_k ≈ 0.001。紫色等高线相对橙色更紧凑，且中心更靠近 Ω
// _k = 0 的虚线；σ8 等参数的影响体现在与深蓝色 P-ACT 区
// 域的结合上，使得整体约束在 Ω_k = 0 附近收窄，从而打破
// 与 Ω_m 的简并。 图下方无标注文字。图中所有标注文字仅包
// 括图例中的 "P-ACT"、"Planck-LB"、"P-ACT-LB" 以及坐标轴
// 标签 Ω_m 和 Ω_k。该图传达的结论是：单独使用 P-ACT 数据
// （深蓝）对 Ω_k 的约束较弱且与 Ω_m 存在明显简并；
// Planck-LB（橙色）与 P-ACT-LB（紫色）的约束均与平坦宇宙
// （Ω_k = 0 虚线）一致，其中 P-ACT-LB 的等高线面积最小，
// 说明联合数据对曲率的限制最严格，且中心紧贴 Ω_k = 0，支
// 持平坦宇宙。
#figure(image("imgs/fig36.png"),
  caption: [
    Curvature can be measured from the CMB alone due to lensing effects in the primary CMB; the new ACT DR6 spectra are consistent with a flat universe (dashed line) both alone and in combination with #emph[Planck], as described in L25 and as shown by the navy contour. The P-ACT-LB~combination (purple) tightens the constraint around zero curvature, further breaking the degeneracy with the matter density and improving on Planck-LB~(orange).
  ],
  placement: top,
)
<fig:omk>

In the inflationary scenario, at the end of inflation the universe is predicted to emerge in a state very close to spatially flat~@LINDE1982389#cite(<PhysRevLett.48.1220>). This hypothesis is tested empirically by allowing the curvature density parameter, $Omega_k$, which is fixed to zero in the baseline $Lambda"CDM"$~model, to be a free parameter. As discussed in L25, the new ACT DR6 power spectra alone prefer a flat geometry, breaking degeneracies via lensing effects in the power spectra; in a joint fit with #emph[Planck], ACT DR6 moves the #emph[Planck] contours toward vanishing curvature. When adding BAO and CMB lensing data to the primary CMB, the degeneracy with the matter density is more effectively broken, as shown in Fig.~#ref(<fig:omk>, supplement: none), and the constraints tighten significantly, yielding $ Omega_k = 0.0019 plus.minus 0.0015 quad ( 68 % , sans("P-ACT-LB") ) , $ similar to $Omega_k = 0.0022 plus.minus 0.0015$ (68%, Planck-LB). These limits derived from the combination of CMB and low-redshift data tightly constrain the universe's spatial geometry, and are fully consistent with spatial flatness.

This result can be converted into a new limit on the present-day radius of spatial curvature of the universe, $R_k = c / H_0 / sqrt(\| Omega_(upright("tot")) - 1 \|)$ where $Omega_(upright("tot"))$ is the total cosmic energy density, such that $Omega_k = 1 - Omega_(upright("tot"))$. With P-ACT-LB~we find at 95% confidence $R_k > 105$~Gpc or equivalently $R_k > 343$ billion light-years for a closed universe ($Omega_(upright("tot")) > 1$ or $Omega_k < 0$) and $R_k > 66$~Gpc or $R_k > 215$ billion light-years for an open universe ($Omega_(upright("tot")) < 1$ or $Omega_k > 0$).

== Late-time dark energy
<sec:de>
Within the $Lambda"CDM"$~model, the dark energy density is constant over time, described by a cosmological constant $Lambda$ with an equation of state $w equiv - 1$ at all times. A common way of exploring the dark energy component is to relax the assumption on its equation of state, considering a time evolution of the pressure-density ratio $P / rho = w ( a )$ with~@Chevallier2001@Linder_w#footnote[See, e.g.,~@Shlivko:2024llw for consideration of time-evolving dark energy beyond the $( w_0 , w_a )$ parametrization.] $ w ( a ) = w_0 + w_a ( 1 - a ) . $ This is equivalent to a cosmological constant $Lambda$ when setting today's value of the equation of state to $w_0 = - 1$ and its time dependence to $w_a = 0$. This expansion can then be used for explorations varying either only $w_0$ or both $w_0$ and $w_a$, as we do below. Opening these degrees of freedom in the dark energy component causes strong degeneracies between parameters when using only CMB data and therefore we mostly report results for combinations with CMB lensing and external probes of the expansion history, including both BAO and SNIa. In particular, as shown in~@DESI-BAO-VI in fits to models with additional degrees of freedom in the dark energy equation of state, SNIa are essential to break degeneracies with $H_0$ and the matter density. We do not expect significant improvements from the new ACT power spectra for late-time dark energy, but we report constraints here given interest in this model following the DESI Year-1 results.

When $w equiv w_0$ is free to vary as a single-parameter extension to $Lambda"CDM"$~(without time dependence --- $w_a = 0$ --- and imposing a flat prior $w_0 in [ - 3 , 1 ]$)#footnote[To get theory predictions for this model we use `camb` with the Parametrized Post-Friedmann approach~@Fang2008 to compute dark energy perturbations (`dark_energy_model=DarkEnergyPPF`).], we obtain the contours shown in Fig.~#ref(<fig:lcdm_single_extensions_pactlb>, supplement: none) for P-ACT-LB. Adding also SNIa data, we find $ w_0 = - 0.986 plus.minus 0.025 #h(0em) ( 68 % , sans("P-ACT-LBS") ) , $ in good agreement with the $Lambda"CDM"$~expectation, and with the same error bar as previous measurements using CMB from ~($w_0 = - 0.997 plus.minus 0.025$, #cite(<DESI-BAO-VI>, style: "aas_noparen.csl")).

When we expand the model further, with both $w_0$ and $w_a$ varying (with a flat prior $w_a in [ - 3 , 2 ]$), we find $ mat(delim: "}", align: #left,
  w_0 = -0.837 plus.minus 0.061;
  w_a = -0.66_(-0.24)^(+0.27),
) quad (68%, "P-ACT-LBS") $ with marginalized posteriors shown in Fig.~#ref(<fig:wcdm_2d>, supplement: none). We see a moderate preference for the $w_0 w_a "CDM"$ model over $Lambda"CDM"$, similar to what was reported in~@DESI-BAO-VI using CMB data from ~($w_0 = - 0.827 plus.minus 0.063$, $w_a = - 0.75_(- 0.25)^(+ 0.29)$).#footnote[Quantitatively, comparing the MAP $w_0 w_a$CDM and $Lambda"CDM"$~models, we find $Delta chi^2 = - 7.0$ ($2.2 sigma$) for P-ACT-LBS, while~@DESI-BAO-VI find $Delta chi^2 = - 8.7$ ($2.5 sigma$) for Planck-LBS.] This result is driven partially by the DESI data and partially by the SNIa data. Substituting the BAO dataset with BOSS BAO, the posteriors are consistent with the cosmological constant scenario. The specific CMB dataset used for this analysis has essentially no impact: #emph[Planck] alone, P-ACT, or W-ACT~yield similar results.

// [figvision-cn] imgs/fig37.png
// 这是一张二维参数约束等值线图，横轴表示暗能量状态方程当
// 前值参数 w0，范围从 -1.4 到 -0.6，刻度间隔为 0.2，单位
// 无量纲；纵轴表示暗能量状态方程随时间变化参数 wa，范围
// 从 -1.5 到 0.5，刻度间隔为 0.5，单位无量纲。横轴 -1.0
// 处有一条贯穿全图的黑色垂直虚线，纵轴 0.0 处有一条贯穿
// 全图的黑色水平虚线，两条虚线交于 (-1.0, 0.0)。图中包含
// 两组置信区域：紫色填充的闭合等值线代表 P-ACT-LBS 数据
// 集，标签文字位于左下角区域；绿色轮廓的闭合等值线代表
// P-ACT-LB BOSS S 数据集，标签文字同样位于左下角区域。紫
// 色区域由深浅两层填充构成，内层为深紫色，对应较高置信水
// 平（约 68%），外层为浅紫色，对应较低置信水平（约 95%），
// 其形状为沿右下方向拉长的椭圆，长轴从约 (-0.95, 0.0) 延
// 伸至 (-0.75, -1.3)，外层轮廓覆盖横轴 -1.0 至 -0.65、纵
// 轴 -1.4 至 0.2 的范围。绿色轮廓同样有内外两层，均为绿
// 色线条，内层线型较粗，外层线型较细，其形状也为沿右下方
// 向拉长的椭圆，外轮廓覆盖横轴 -1.04 至 -0.75、纵轴 -1.1
// 至 0.25 的范围，相对于紫色区域整体向左上方偏移。图中传
// 达的趋势是：P-ACT-LBS 数据集（紫色）对 w0 和 wa 的约束
// 更强，其参数区域更紧凑且偏离 (-1.0, 0.0) 处的宇宙学常
// 数基准（虚线交点），表现出对随时间变化的暗能量的偏好；
// 而用 BOSS BAO 替代 LBS 后（绿色），置信区域明显扩大并
// 向 (-1.0, 0.0) 方向移动，表明对动力学暗能量的偏好被放
// 宽。
#figure(image("imgs/fig37.png"),
  caption: [
    Constraints on the dark energy equation of state parameters, varying both today's value, $w_0$, and its time variation, $w_a$. Similar to other studies, we find that DESI drives a preference for time-varying dark energy (compared to the dashed $Lambda"CDM"$~line), which is relaxed when considering BOSS BAO instead (green contours). The CMB contribution to this measurement is sub-dominant, apart from breaking parameter degeneracies, with Planck, W-ACT, and P-ACT~giving similar results.
  ],
  placement: top,
)
<fig:wcdm_2d>

With the combined P-ACT-LBS~dataset, we find a well-constrained value of $H_0 = 67.73 plus.minus 0.68$~km/s/Mpc and $H_0 = 68.02 plus.minus 0.72$~km/s/Mpc for the $w_0$ and $w_0 - w_a$ extensions, respectively. Similarly to~@DESI-BAO-VI, we also find that SNIa reduce by a factor of $tilde.op 2$ the uncertainty on $H_0$ and shift the mean to lower values by $tilde.op 3$~km/s/Mpc (see Fig.~#ref(<fig:lcdm_single_extensions_pactlb>, supplement: none)).

== Interacting DE-DM
<sec:dedm>
An extension of $Lambda$CDM with kinetic interactions between the DM and DE fluids was initially considered in~#cite(<Simpson2010ScatteringOf>). This model introduces a coupling constant, $Gamma_("DMDE")$, describing pure momentum transfer between the DM and DE. This coupling leaves the homogeneous background cosmological evolution unchanged, but alters the dark sector perturbation evolution equations as follows~#cite(<Simpson2010ScatteringOf>): $ delta'_("DM") & = - theta_("DM") + 3 phi.alt' ,\
delta'_("DE") & = - [( 1 + w ) + 9 cal(H)^2 / k^2 (1 - w^2)] theta_("DE")\
 & #h(0em) #h(0em) #h(0em) #h(0em) + 3 ( 1 + w ) phi.alt' - 3 cal(H) ( 1 - w ) delta_("DE") ,\
theta'_("DM") & = - cal(H) theta_("DM") + k^2 phi.alt + frac(a Gamma_("DMDE"), macron(rho)_("DM")) Delta theta ,\
theta'_("DE") = & 2 cal(H) theta_("DE") + k^2 / (1 + w) delta_("DE") + k^2 phi.alt - frac(a Gamma_("DMDE"), ( 1 + w ) macron(rho)_("DE")) Delta theta , $<eq:DM-dens-deriv> where $w$ is the DE equation of state, $delta equiv rho / macron(rho) - 1$ is the energy density contrast, $theta equiv nabla dot.op bold(v)$ is the velocity divergence, $Delta theta equiv theta_("DE") - theta_("DM")$, $cal(H)$ is the conformal Hubble factor ($cal(H) = a H$), $phi.alt$ is the Newtonian gravitational potential, and $zws'$ denotes differentiation with respect to conformal time.

This type of interaction leads to slower structure growth, and this idea was revisited in~@Beltran2021ProbingElastic@Poulin2023Sigma-8@Beltran2025OnEvidence as a potential way to reduce the value of $S_8$ inferred from CMB and LSS data. The coupling strength needed to appreciably reduce $S_8$ is around $Gamma_("DMDE") / ( H_0 rho_c ) tilde.op 1$ (where $rho_c$ is the critical density). While previous work assumed linear theory, #cite(<Lague2024ConstraintsDMDE>, form: "prose") developed a halo-model approach to characterize the behavior of DM with non-zero $Gamma_("DMDE")$ on semi-linear scales. This model is an adapted version of `HMcode` (still assuming dark matter only) and accounts for changes in halo formation resulting from DE-DM interactions using modified fitting functions for the critical and virial overdensities. A combination of CMB lensing from ACT DR6 and #emph[Planck], BAO from SDSS/BOSS, and CMB primary anisotropy measurements from #emph[Planck] constrains the contribution of $Gamma_("DMDE") / H_0 rho_c < 2.76$ at the 95% CL using this prescription~#cite(<Lague2024ConstraintsDMDE>).

Here, we enlarge the dataset to include the new ACT DR6 primary CMB power spectra, and we replace the BAO likelihood with that of DESI.#footnote[We note here that the interacting DE-DM model is the only case in this paper for which we use the #emph[extended] setting for the ACT DR6 + #emph[Planck] CMB lensing data. To constrain $Gamma_("DMDE")$, we make use of the full CMB lensing likelihood up to $L = 1250$~@Madhavacheril_dr6_lensing#cite(<Qu_dr6_lensing>).] We study two configurations for this model. We first fix the dark energy equation of state to three different values of $w in { - 0.999 , - 0.975 , - 0.95 }$, allowing $Gamma_("DMDE")$ to vary (the model is thus a two-parameter extension of $Lambda$CDM with only one additional degree of freedom). We avoid $w = - 1$ due to a divergence that arises in Eq.~(#ref(<eq:DM-dens-deriv>, supplement: none)) in this case. We then also jointly sample both parameters, but we find that Metropolis-Hastings sampling performs poorly when varying both $w$ and $Gamma_("DMDE")$. This occurs because $w$ can take a very wide range of values when $Gamma_("DMDE")$ goes to $0$.#footnote[In this case, due to the computational expense in this model, we stop the chains at a Gelman-Rubin statistic of $R - 1 < 0.05$; thus, slight variations in the final bounds are expected.] We adopt a flat prior $Gamma_("DMDE") / ( H_0 rho_c ) in [ 10^(- 8) , 50 ]$. We compute theoretical predictions for this scenario using the modified version of `class` from~#cite(<Lague2024ConstraintsDMDE>).#footnote[#link("https://github.com/fmccarthy/Class_DMDE")]

// [figvision-cn] imgs/fig38.png
// 这是一张三角图（corner plot，也称角图），用于展示四个
// 宇宙学参数的后验概率分布及其两两之间的相关性约束。图中
// 包含四个参数：暗物质-暗能量相互作用率 Γ_DMDE/H₀ρ_c、暗
// 能量状态方程参数 w、物质密度参数 Ω_m 和物质团簇参数 S₈。
// 该图由 10 个子图组成，包括 4 个对角线上的单参数一维概
// 率密度曲线图和 6 个非对角线上的两参数二维置信区间轮廓
// 图。 图例位于图的顶部中间偏右位置，包含四种数据组合或
// 模型设定： 橙色实心填充区域：P-ACT-LBS（变动状态方程）。
// 紫色实心填充区域：P-ACT-LB（变动状态方程）。 黑色实线
// 空心轮廓：P-ACT-LB，固定 w = -0.999。 黑色虚线空心轮廓：
// P-ACT-LB，固定 w = -0.95。 实心填充区域包含深浅两层，
// 分别代表 68% 和 95% 的置信区间。 以下是对各个子图的详
// 细描述： 子图 (a)（左上角）：一维概率密度曲线图。横轴
// 为 Γ_DMDE/H₀ρ_c，刻度范围 0 到 6，主刻度为 2、4、6。纵
// 轴为概率密度（未标数值，无刻度）。图中包含一条紫色实线
// 和一条橙色实线。两条曲线均在 Γ_DMDE/H₀ρ_c = 0 处达到最
// 高峰值，随参数值增大迅速下降，在 Γ_DMDE/H₀ρ_c > 2 后趋
// 近于零。紫色曲线在 0 附近的峰值略高于橙色曲线，且橙色
// 曲线在 1 到 2 之间的尾部略厚。结论：数据强烈倾向于 Γ
// _DMDE/H₀ρ_c = 0，即不支持存在显著的暗物质-暗能量相互作
// 用。 子图 (b)（第一行第二列）：二维置信区间轮廓图。横
// 轴为 w，范围 -0.97 到 -0.93，主刻度为 -0.97、-0.93。纵
// 轴为 Γ_DMDE/H₀ρ_c，范围 0 到 6，主刻度为 2、4、6。图中
// 包含橙色实心填充区域、紫色实心填充区域、黑色实线空心轮
// 廓和黑色虚线空心轮廓。所有轮廓均呈现从左上向右下弯曲的
// 形态，在 w 靠近 -0.93 时，Γ_DMDE/H₀ρ_c 均趋近于 0。橙
// 色和紫色填充区域大部分重叠，紫色区域略靠左（更负的 w
// 值）。黑色实线空心轮廓紧贴紫色填充区域的左侧，而黑色虚
// 线空心轮廓则向右延伸，覆盖了更接近 -0.93 的 w 值，同时
// 其 Γ_DMDE/H₀ρ_c 的上限略低。 子图 (c)（第二行第一列）：
// 二维置信区间轮廓图。横轴为 Γ_DMDE/H₀ρ_c，刻度同子图 (a
// )。纵轴为 w，范围 -0.98 到 -0.92，主刻度为 -0.98、
// -0.96、-0.94、-0.92。图中包含橙色实心填充区域、紫色实
// 心填充区域、黑色实线空心轮廓和黑色虚线空心轮廓。橙色和
// 紫色实心区域在 Γ_DMDE/H₀ρ_c 接近 0 时，w 的取值集中在
// -0.95 到 -0.96 附近，并向右下延伸。紫色区域在 w 轴上比
// 橙色区域略宽且中心略低。黑色实线空心轮廓呈狭长的闭合曲
// 线，位于 Γ_DMDE/H₀ρ_c 较小且 w 接近 -0.96 的位置。黑色
// 虚线空心轮廓则向左上方延伸，在 Γ_DMDE/H₀ρ_c 接近 0 时，
// w 值可达 -0.95 以上。 子图 (d)（第二行第二列）：一维概
// 率密度曲线图。横轴为 w，范围 -0.98 到 -0.92，主刻度为
// -0.98、-0.96、-0.94、-0.92。纵轴为概率密度。图中包含紫
// 色实线、橙色实线、黑色实线和黑色虚线。所有曲线均为单峰
// 分布。紫色实线峰值在 -0.96 附近，橙色实线峰值在 -0.955
// 附近且略高于紫色。黑色实线峰值在 -0.96 附近，形态与紫
// 色曲线相似。黑色虚线峰值明显偏向右侧，在 -0.94 附近，
// 且分布更宽。 子图 (e)（第三行第一列）：二维置信区间轮
// 廓图。横轴为 Γ_DMDE/H₀ρ_c，刻度同子图 (a)。纵轴为 Ω_m，
// 范围 0.30 到 0.33，主刻度为 0.30、0.31、0.32、0.33。橙
// 色和紫色实心填充区域在 Γ_DMDE/H₀ρ_c 接近 0 时，Ω_m 集
// 中在 0.31 到 0.32 之间，并向右侧延伸。紫色区域更紧凑，
// 橙色区域向右上方延伸更多。黑色实线空心轮廓呈闭合的弯曲
// 形状，在 Γ_DMDE/H₀ρ_c 较小时 Ω_m 约为 0.31，向右延伸至
// 0.315 左右。黑色虚线空心轮廓位于左侧，在 Γ_DMDE/H₀ρ_c
// 接近 0 时，Ω_m 约为 0.32，且范围更宽。 子图 (f)（第三
// 行第二列）：二维置信区间轮廓图。横轴为 w，刻度同子图 (
// d)。纵轴为 Ω_m，刻度同子图 (e)。橙色和紫色实心填充区域
// 呈水平拉长的椭圆状，w 在 -0.96 到 -0.94 之间，Ω_m 在
// 0.30 到 0.32 之间。紫色区域中心略微偏左，橙色区域向右
// 延伸更多。黑色实线空心轮廓呈狭长的水平椭圆，w 集中在
// -0.96 附近，Ω_m 集中在 0.31 左右。黑色虚线空心轮廓则向
// 右上方倾斜，w 值更高，Ω_m 也略高。 子图 (g)（第三行第
// 三列）：一维概率密度曲线图。横轴为 Ω_m，范围 0.30 到
// 0.33，主刻度为 0.30、0.31、0.32、0.33。纵轴为概率密度。
// 图中包含紫色实线、橙色实线、黑色实线和黑色虚线。紫色实
// 线峰值在 0.315 附近，橙色实线峰值在 0.313 附近。黑色实
// 线峰值在 0.312 附近。黑色虚线峰值明显偏向右侧，在 0.32
// 附近，且分布较宽。 子图 (h)（第四行第一列）：二维置信
// 区间轮廓图。横轴为 Γ_DMDE/H₀ρ_c，刻度同子图 (a)。纵轴
// 为 S₈，范围 0.70 到 0.80，主刻度为 0.7、0.8。橙色和紫
// 色实心填充区域在 Γ_DMDE/H₀ρ_c 接近 0 时，S₈ 集中在
// 0.78 到 0.80 之间，并向右侧延伸。紫色区域更紧凑。黑色
// 实线空心轮廓呈闭合的弯曲形状，位于 Γ_DMDE/H₀ρ_c 较小时
// S₈ 约为 0.78 的位置。黑色虚线空心轮廓向右上方延伸，覆
// 盖了更大的 Γ_DMDE/H₀ρ_c 和 S₈ 值。 子图 (i)（第四行第
// 二列）：二维置信区间轮廓图。横轴为 w，刻度同子图 (d)。
// 纵轴为 S₈，刻度同子图 (h)。橙色和紫色实心填充区域呈弯
// 曲的椭圆状，w 在 -0.96 到 -0.94 之间，S₈ 在 0.76 到
// 0.80 之间。紫色区域中心略偏左，橙色区域向右延伸更多。
// 黑色实线空心轮廓呈狭长的椭圆，w 集中在 -0.96 附近，S₈
// 集中在 0.78 左右。黑色虚线空心轮廓则向右上方延伸，覆盖
// 了更接近 -0.94 的 w 值和更高的 S₈ 值。 子图 (j)（第四
// 行第三列）：二维置信区间轮廓图。横轴为 Ω_m，刻度同子图
// (g)。纵轴为 S₈，刻度同子图 (h)。橙色和紫色实心填充区域
// 呈倾斜的椭圆状，从左上向右下倾斜（Ω_m 增大，S₈ 减小）。
// 紫色区域更紧凑，橙色区域向右上方延伸更多。黑色实线空心
// 轮廓呈类似倾斜的闭合曲线，中心在 Ω_m 约 0.31、S₈ 约
// 0.78 处。黑色虚线空心轮廓则向右上方延伸，覆盖了更高的
// Ω_m 和 S₈ 值，且形状更宽。 子图 (k)（右下角）：一维概
// 率密度曲线图。横轴为 S₈，范围 0.7 到 0.8，主刻度为 0.7、
// 0.8。纵轴为概率密度。图中包含紫色实线、橙色实线、黑色
// 实线和黑色虚线。所有曲线均为单峰分布。紫色实线峰值在
// 0.79 附近，橙色实线峰值在 0.785 附近。黑色实线峰值在
// 0.78 附近。黑色虚线峰值偏向右侧，在 0.80 附近，且分布
// 较宽。 总体趋势与结论：图中所有实心填充区域和黑色实线
// 空心轮廓均显示，暗物质-暗能量相互作用率 Γ_DMDE/H₀ρ_c
// 强烈倾向于零（即无耦合），这与图注中提到的“Preferred
// parameters are in agreement with the ~values of and (
// no coupling between DM and DE)”相符。当状态方程参数 w
// 固定为 -0.999 时，约束结果（黑色实线）与变动状态方程的
// 结果（紫色填充）较为一致。当 w 固定为 -0.95 时，约束结
// 果（黑色虚线）在 Ω_m 和 S₈ 方向上向右上方偏移，且分布
// 更宽，表明 w 的取值对参数约束有显著影响。
#figure(image("imgs/fig38.png"),
  caption: [
    Constraints on the strength of the DM-DE interaction rate for the data combinations P-ACT-LB and P-ACT-LBS, for varying equation of state (filled contours) and two fixed values of $w$ (empty contours and black lines). The preferred parameters are in agreement with the $Lambda"CDM"$~values of $w = - 1$ and $Gamma_("DMDE") = 0$ (no coupling between DM and DE).
  ],
  placement: top,
)
<fig:2w-Gamma-dmde>

We show the parameter posterior distributions for a subset of the runs in Fig.~#ref(<fig:2w-Gamma-dmde>, supplement: none). Given the large degeneracies present in this model when using only CMB data, we focus on results for the data combinations P-ACT-LB~and P-ACT-LBS. For fixed values of $w$, we find that the limit on $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )$ gets tighter moving away from the $w = - 1$ boundary: $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )_(w = - 0.999) < 3.10$, $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )_(w = - 0.975) < 1.64$, and $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )_(w = - 0.95) < 1.64$ (all at 95% CL from P-ACT-LB). Similarly, the $S_8$ limit gets tighter, with the low-end tail of the distribution being more excluded (see Fig.~#ref(<fig:2w-Gamma-dmde>, supplement: none)). When varying $w$ and $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )$ simultaneously, we find $  & Gamma_("DMDE") / ( H_0 rho_(upright("c")) ) < 1.9 #h(0em) ( 95 % , sans("P-ACT-LB") ) ,\
 & S_8 = 0.781_(- 0.02)^(+ 0.04) quad quad quad ( 68 % , sans("P-ACT-LB") ) , $ and when including SNIa data from PantheonPlus $  & Gamma_("DMDE") / ( H_0 rho_(upright("c")) ) < 2.1 #h(0em) ( 95 % , sans("P-ACT-LBS") ) ,\
 & S_8 = 0.780_(- 0.02)^(+ 0.04) quad quad quad ( 68 % , sans("P-ACT-LBS") ) . $

We also perform the same analyses with BOSS BAO data used in place of DESI, finding similar constraints on $S_8$ (with error bars $10$-$30$%~larger) and somewhat weaker bounds on $Gamma_("DMDE")$ (roughly $20$-$50$% larger upper limits). We see no preference for this model over $Lambda$CDM for any dataset combination considered here, with the best-fit model lying at the $Gamma_("DMDE") = 0$ edge of the parameter space (note that there are no projection effects in the Bayesian posteriors in the cases where we fix $w$ to specific values). The inclusion of the ACT DR6 and DESI data tightens the upper limit on $Gamma_("DMDE")$ by 33% compared to the bounds from~@Lague2024ConstraintsDMDE when varying both $w$ and $Gamma_("DMDE")$ using the P-ACT-LB~dataset. The improvement in constraining power comes mainly from using the DESI BAO dataset instead of BOSS and the improved bounds on $Omega_m$ from the primary CMB in ACT DR6. The addition of SNIa data from PantheonPlus does not improve our bounds.

As observed in previous work, the coupling between the DM and DE leads to reduced values of $S_8$, significantly broadening the marginalized posterior for this parameter. When $- w$ approaches unity, the effects of the coupling are delayed to lower redshifts. This makes CMB lensing, which is sensitive to redshifts around $z tilde.op 1 - 2$, less constraining for this model. For this reason, we find a more extended posterior for $Gamma_("DMDE") / ( H_0 rho_(upright("c")) )$ when $w$ is near $- 1$, as shown in Fig.~#ref(<fig:2w-Gamma-dmde>, supplement: none). In general, we find that this model allows values of $S_8$ from P-ACT-LB~that are consistent with values found in galaxy weak lensing surveys, but we caution that a joint analysis with such datasets would require a full model for the nonlinear matter power spectrum in this scenario. \

== Modified gravity
<sec:mg>
The growth rate of large-scale structure $f ( a ) equiv d ln D ( a ) / d ln a$, where $D ( a )$ is the linear growth factor and $a$ is the scale factor, can be accurately approximated in the matter- or dark energy-dominated eras as $ f ( a ) = Omega_m^gamma ( a ) thin , $<eq.gamma> where $gamma$ is the growth index, which takes a canonical value of 0.55 in general relativity (GR) with a flat $Lambda$CDM cosmology~@FRY1985211@Wang_1998#cite(<Linder_2005>). This simple model with values of $gamma$ differing from 0.55 is part of a broader class of modified gravity theories, which generically predict modifications to the growth of structure. Various studies have considered and constrained different prescriptions for the growth and geometry~@Wang:2007fsa@Guzzo:2008ac@Dossett:2010gq@Hudson2012@Rapetti:2012bu@Pouri:2014nta@Ruiz:2014hma@Bernal:2015zom@Johnson:2015aaa@Alam:2015rsa@Moresco:2017hwt@Basilakos:2019hlb@DES:2020iqt@Garcia-Garcia:2021unp@Ruiz-Zapatero:2021rzl@Ruiz-Zapatero:2022zpx@White:2021yvw@Andrade:2021njl@Chen:2022jzq#cite(<DES:2022ccp>). Some studies have found evidence for suppression of the growth of structure, while others have not. One of the most sensitive datasets for such theories is the combination $f sigma_8 ( z )$ (the product of $f ( z )$ and $sigma_8 ( z )$) which is constrained by various redshift-space distortion (RSD) and peculiar velocity surveys. RSD surveys measure the growth rate of structure via the imprint of peculiar velocities on the quadrupole of redshift-space galaxy clustering measurements~@Kaiser1987@Hamilton1998@Percival2009#cite(<Song2009>). Surveys of the peculiar velocities of individual galaxies can be performed at low-to-moderate redshifts, when an estimate of the absolute distance to each galaxy is available (e.g., from Cepheid, TRGB, or SNIa observations), thus allowing the cosmological contribution to the observed redshift to be isolated from the peculiar-velocity contribution~@Miller1992@Riess1998@Turnbull2012@Tully2016#cite(<Stahl2021>). CMB data also contribute constraining power via lensing effects~#cite(<2009PhRvD..80j3516C>).

A recent analysis by @Nguyen:2023fip found moderate evidence of a potential deviation from the GR prediction for $gamma$. They considered measurements of peculiar velocities from @Boruah:2019icj, @Huterer:2016uyq, @Turner:2022mla, and @Said:2020epb, and measurements of RSD from @Beutler2012, @Howlett:2014opa, @Blake2012, @Blake:2013nif, @Pezzotta:2016gbo, @eBOSS-LRG, and #cite(<Okumura:2015lvp>). Combining these with data from #emph[Planck], they found evidence for suppression of the growth of structure at $3.7 sigma$ significance, with $gamma = 0.639_(- 0.025)^(+ 0.024)$. This suppression both significantly reduced $S_8$ and eliminated #emph[Planck]'s (mild) preference for positive spatial curvature.

Here, we study the impact of including the new ACT DR6 spectra on these results, following the approach of #cite(<Nguyen:2023fip>). Since Eq.~#link(<eq.gamma>)[[eq.gamma]] is only valid for sub-horizon perturbations, this approach leaves the unlensed primary CMB perturbations unchanged, but modifies the CMB lensing potential and other late-time observables self-consistently. We use all measurements considered by @Nguyen:2023fip to form a $f sigma_8$ likelihood, consisting of a simple Gaussian likelihood for each survey's constraint on $f sigma_8$. DESI also recently released $f sigma_8$ measurements~@2024desi which we do not include here to facilitate comparison with @Nguyen:2023fip, but we discuss them in~§@subsec:consistency. In combination with ACT and other datasets, we use the $f sigma_8$ likelihood to constrain the growth index $gamma$ as a single-parameter extension to $Lambda$CDM, varied with a uniform prior $gamma in [0 , 2]$. To perform the theoretical calculations, we use the modified version of `camb` released by~#cite(<Nguyen:2023fip>).#footnote[#link("https://github.com/MinhMPA/CAMB_GammaPrime_Growth")]

With the new DR6 spectra, we find the growth index to be $gamma = 0.560 plus.minus 0.110$, with $S_8 = 0.872 plus.minus 0.042 med ( 68 % , sans("ACT") )$. Combining with #emph[Planck], these limits tighten significantly, yielding $gamma = 0.688 plus.minus 0.071$ and $S_8 = 0.812 plus.minus 0.017 #h(0em) ( 68 % , sans("P-ACT") )$. Further adding CMB lensing and DESI BAO data, we obtain $ mat(delim: "}", align: #left,
  gamma = 0.663 plus.minus 0.052;
  S_8 = 0.799 plus.minus 0.012,
) quad (68%, "P-ACT-LB"). $ This value of $gamma$ lies $2.2 sigma$ above the GR prediction, but is nevertheless consistent with it (as shown in Fig.~#ref(<fig:gamma_base_triangle>, supplement: none)).

// [figvision-cn] imgs/fig39.png
// 该图是一张三角形相关图（corner plot），用于展示四个宇
// 宙学参数的后验概率分布：Ω_c h²、H₀、S₈ 和 γ（增长指数）。
// 图中包含三个数据集组合的约束结果，图例位于左上角：紫色
// 代表 P-ACT-LB，浅蓝色代表 P-ACT-LB-fσ₈，深蓝色代表
// W-ACT-LB_BOSS-fσ₈。 对角线子图（从上到下，从左到右）：
// 第一行第一列：Ω_c h² 的一维边缘化概率密度曲线。横轴 Ω
// _c h² 范围为 0.114 至 0.122，无单位。纵轴为概率密度（
// 无标度）。三条曲线均为单峰，紫色峰约在 0.117，浅蓝色峰
// 约在 0.1175，深蓝色峰约在 0.1185。深蓝色曲线最窄，紫色
// 最宽。 第二行第二列：H₀ 的一维概率密度曲线。横轴 H₀ 范
// 围为 67 至 70，单位为 km/s/Mpc。三条曲线均为单峰，紫色
// 峰约在 68.4，浅蓝色峰约在 68.5，深蓝色峰约在 68.7。深
// 蓝色曲线最窄。 第三行第三列：S₈ 的一维概率密度曲线。横
// 轴 S₈ 范围为 0.77 至 0.83，无单位。三条曲线均为单峰，
// 紫色峰约在 0.805，浅蓝色峰约在 0.810，深蓝色峰约在
// 0.815。深蓝色曲线最窄。 第四行第四列：γ 的一维概率密度
// 曲线。横轴 γ 范围为 0.55 至 0.85，无单位。三条曲线均为
// 单峰，紫色峰约在 0.67，浅蓝色峰约在 0.65，深蓝色峰约在
// 0.63。图中有一条灰色虚线位于 γ=0.55 处，标记广义相对论
// （GR）的预测值（γ=0.55）。所有约束均偏离该虚线。 非对
// 角线子图（二维等高线）： 第二行第一列：H₀ 对 Ω_c h² 的
// 二维约束。横轴 Ω_c h² 范围 0.114–0.122，纵轴 H₀ 范围
// 67–70 km/s/Mpc。三个数据集均显示负相关（倾斜的椭圆），
// 深蓝色椭圆最小且最靠右下，紫色椭圆最大且最靠左上。 第
// 三行第一列：S₈ 对 Ω_c h² 的二维约束。横轴 Ω_c h² 范围
// 0.114–0.122，纵轴 S₈ 范围 0.77–0.83。三个数据集均显示
// 正相关（倾斜的椭圆），深蓝色椭圆最小且最靠右上，紫色椭
// 圆最大且最靠左下。 第三行第二列：S₈ 对 H₀ 的二维约束。
// 横轴 H₀ 范围 67–70 km/s/Mpc，纵轴 S₈ 范围 0.77–0.83。
// 三个数据集均显示负相关（倾斜的椭圆），深蓝色椭圆最小且
// 最靠右上，紫色椭圆最大且最靠左下。 第四行第一列：γ 对
// Ω_c h² 的二维约束。横轴 Ω_c h² 范围 0.114–0.122，纵轴
// γ 范围 0.55–0.85 左右。紫色椭圆呈负相关，浅蓝色椭圆呈
// 负相关，深蓝色椭圆接近水平且范围很小。 第四行第二列：γ
// 对 H₀ 的二维约束。横轴 H₀ 范围 67–70 km/s/Mpc，纵轴 γ
// 范围 0.55–0.85。紫色椭圆呈负相关，浅蓝色椭圆呈负相关，
// 深蓝色椭圆接近水平且范围很小。 第四行第三列：γ 对 S₈
// 的二维约束。横轴 S₈ 范围 0.77–0.83，纵轴 γ 范围 0.55–
// 0.85。紫色椭圆呈负相关，浅蓝色椭圆呈负相关，深蓝色椭圆
// 接近水平且范围很小。 图中所有等高线均表示 68% 和 95%
// 置信区间。总体趋势：加入更多测量数据（从紫色到深蓝色）
// 显著减小了参数的不确定性（椭圆变小），并打破了参数间的
// 简并，但将 γ 的约束从广义相对论预测值（灰色虚线）移开。
#figure(image("imgs/fig39.png"),
  caption: [
    Constraints on a modified growth of structure model in which the growth index $gamma$ is allowed to vary, for different dataset combinations (P-ACT-LB~in purple, P-ACT-LB-f$sigma_8$~in light blue, and -f$sigma_8$~in navy). The addition of $f sigma_8$ measurements effectively breaks degeneracies between $gamma$ and other parameters, but moves the constraint away from the GR prediction of $gamma = 0.55$ (marked by the gray dashed line) at $> 3 sigma$. The consistency between P-ACT-LB-f$sigma_8$~and -f$sigma_8$~indicates that the $gamma$ result is not driven strongly by the preference for high $A_(upright("lens"))$ in #emph[Planck], or by DESI BAO.
  ],
  placement: top,
)
<fig:gamma_base_triangle>

When replacing the DESI BAO data with BOSS BAO data, we obtain $gamma = 0.635 plus.minus 0.053$ and $S_8 = 0.812 plus.minus 0.013; (68%,sans("P-ACT-LB")_sans("BOSS"))$, which is consistent with the P-ACT-LB~result but moves closer to the GR expectation. Including now the $f sigma_8$ measurements, we obtain#footnote[We note that when including $f sigma_8$ measurements, for the BOSS likelihood we use a likelihood that combines BAO and RSD data from BOSS DR12 and eBOSS DR16, as described in #cite(<eBOSS:2020yzd>). When we refer to -f$sigma_8$ or -f$sigma_8$, this is the BOSS likelihood that is used.]

$ mat(delim: "}", align: #left,
  gamma = 0.630 plus.minus 0.023;
  S_8 = 0.8050 plus.minus 0.0081,
) quad (68%, "P-ACT-LB-f" sigma_8). $ Replacing DESI BAO data with BOSS has minimal impact, giving $gamma = 0.634 plus.minus 0.024$ and $S_8 = 0.8121 plus.minus 0.0084$ (68%, -f$sigma_8$). The central values of $gamma$ in these constraints deviate from GR at $3.5 sigma$. The data driving this result are those from RSD and peculiar velocity surveys, but the central values are consistent with those found in our analyses without these data.

Note that values of $gamma > 0.55$ can improve concordance between CMB-derived and LSS-derived constraints on $S_8$, compared to those in $Lambda"CDM"$. For example, our P-ACT~result in the modified-growth model ($S_8 = 0.812 plus.minus 0.017$) is lower than that in $Lambda"CDM"$~($S_8 = 0.830 plus.minus 0.014$, L25). We do not run constraints using non-CMB data on their own, but~@Nguyen:2023fip find that the combination of $f sigma_8$, DES-Y1 3$times$2-point, and pre-DESI BAO data yields $S_8 = 0.784_(- 0.016)^(+ 0.017)$ in this model. This agrees with the P-ACT~$S_8$ result at $1.2 sigma$, whereas in $Lambda"CDM"$, the same comparison is discrepant at $3.0 sigma$. The moderate tension is reduced in the modified-growth model both by $tilde.op 1 sigma$ shifts in the central $S_8$ values and small increases in the error bars.

The effects of varying $gamma$ on the lensed CMB power spectrum are similar to those from the phenomenological lensing amplitude parameter, $A_(upright("lens"))$~@Nguyen:2023fip, for which #emph[Planck] has a moderate preference for a value $A_(upright("lens")) > 1$~#cite(<Planck_2018_params>). To assess whether it is the ~$A_(upright("lens"))$ behavior driving the evidence for a high growth index, we swap in #emph[WMAP] for #emph[Planck] data. For the CMB-only combination, we find $gamma = 0.621 plus.minus 0.087$ and $S_8 = 0.840 plus.minus 0.028 #h(0em) ( 68 % , sans("W-ACT") )$. Adding CMB lensing, BOSS BAO, and the $f sigma_8$ data yields $ mat(delim: "}", align: #left,
  gamma = 0.628 plus.minus 0.022;
  S_8 = 0.8122 plus.minus 0.0091,
) quad (68%, "W-ACT-LB-f" sigma_8) $ still finding a $3.5 sigma$ deviation from the GR value of $gamma$. This shows that the current evidence for a non-standard growth index is not driven by #emph[Planck]'s preference for a high CMB lensing amplitude or by DESI BAO data. The precision on this result is driven strongly by the $f sigma_8$ data. We discuss in more detail how this $f sigma_8$ dataset compares with $Lambda"CDM"$~in~§@subsec:consistency. Any preference for this model appears to be largely driven by the $f sigma_8$ data (in fact, by just two of these data points) rather than the ACT data or other CMB data, as discussed further in~§@subsec:consistency. \

= Consistency with low-redshift data and impact on cosmological concordance
<sec:consistency_concordance>
== $Lambda"CDM"$~consistency with low-redshift observations
<subsec:consistency>
Given our findings that no model is significantly preferred over $Lambda"CDM"$, we confirm the consistency of our baseline $Lambda"CDM"$~model (described in L25) with the main low-redshift datasets used here in combination with P-ACT. The agreement between the predictions of the best-fit P-ACT~$Lambda"CDM"$~model and direct measurements of the CMB lensing power spectrum, BAO distances, and SNIa distances provides a powerful consistency test of the cosmological model and justifies our joint inclusion of these datasets in $Lambda"CDM"$~and extended model fits.

// [figvision-cn] imgs/fig40b.png
// 这是一张由上下两个面板组成的科学图表，展示了 DESI BAO
// 距离-红移关系与不同宇宙学模型预测的对比。 上方面板（主
// 图）： 类型：带误差棒的散点图与多条拟合曲线。 纵轴（Y
// 轴）：标签为“D_V(z)/(r_d z^(2/3))”，表示经过标度变换的
// 距离度量。刻度范围从 17 到 21，主刻度间隔为 1。 横轴（
// X轴）：主图底部未标注，但根据整体图表的共享 X 轴，其标
// 签为“Redshift (z)”。刻度范围从 0.0 到 2.5，主刻度间隔
// 为 0.5，次刻度间隔为 0.25。 数据点和曲线： 黑色圆点带
// 垂直误差棒：代表 DESI BAO 的观测数据，图例标注为“DESI
// BAO”。图中显示了 7 个数据点，分别位于红移 z 约为 0.3、
// 0.5、0.7、0.9、1.3、1.5 和 2.3 处。 橙色虚线：图例标注
// 为“Planck prediction (PTE = 2.5%)”，表示来自 Planck 的
// 预测曲线。该曲线从 z=0 处约 16.8 开始，在 z≈1.0 处达到
// 峰值约 20.9，然后下降至 z=2.5 处的约 17.4。 深蓝色虚线：
// 图例标注为“P-ACT prediction (PTE = 6.9%)”，表示来自
// P-ACT 的预测曲线。该曲线形状与橙色虚线相似，但整体略低，
// 在峰值处约为 20.8。 紫色实线：图例标注为“P-ACT-LB fit
// (PTE = 18%)”，表示联合拟合的最佳模型。该曲线与深蓝色虚
// 线几乎重合，在峰值处约为 20.7。 所有曲线在 z=0 到 z=
// 2.5 范围内呈现出先陡峭上升，在 z≈1.0 附近达到峰值（约
// 21），然后平缓下降的形态。观测数据点围绕这些曲线分布，
// 但在 z=0.7 处观察到数据点明显低于所有预测曲线。 下方面
// 板（残差图）： 类型：残差分析图。 纵轴（Y轴）：标签为“
// Residuals”，表示数据相对于拟合模型的残差。刻度范围从
// -0.5 到 0.5，主刻度间隔为 0.5。 横轴（X轴）：标签为“
// Redshift (z)”，范围从 0.0 到 2.5，主刻度间隔为 0.5，次
// 刻度间隔为 0.25。 内容：展示了上方面板中相同数据点相对
// 于不同模型的残差。 橙色虚线：代表相对于 Planck 预测的
// 残差，在低红移处略高于 0，在高红移处接近于 0。 深蓝色
// 虚线：代表相对于 P-ACT 预测的残差，整个范围内基本位于
// 0 附近。 紫色实线：代表相对于 P-ACT-LB 拟合的残差，在
// 零线上保持平稳。 黑色圆点带误差棒：代表实际数据的残差。
// 这些点在 z=0.5 至 z=1.5 之间显示出明显的散布，例如在 z
// =0.7 处残差为负值（约 -0.6），在 z=1.5 处残差为正值（
// 约 0.1），反映了观测数据与模型预测之间的具体偏差。 图
// 中没有显微照片、色标或比例尺，所有标注文字和符号已在上
// 述描述中说明。整体趋势表明，DESI BAO 数据在不同红移下
// 的距离测量值与来自 CMB 的预测模型总体一致，但存在局部
// 偏差，且 P-ACT-LB 联合拟合模型给出的概率值（PTE）最高，
// 为 18%。
#figure([#box(image("figs_final/fig40a.pdf")) #box(image("imgs/fig40b.png"))

  ],
  caption: [
    The ACT DR6 and #emph[Planck] NPIPE CMB lensing power spectra (top panel) and the DESI BAO distance-redshift relation (bottom panel) are compared to $Lambda"CDM"$~predictions from primary CMB anisotropy data (~in orange and P-ACT~in navy). The joint P-ACT-LB~$Lambda"CDM"$~best-fit model is shown in purple. For CMB lensing, we show only the bandpowers used in the baseline likelihood described in~§@subsec:cmb_lens. The DESI dataset is described in~§@subsec:bao and includes twelve total data points; of these twelve points, five pairs of $D_H ( z ) / r_d$ and $D_M ( z ) / r_d$ are combined into five different $D_V ( z ) / r_d$ measurements leading to a total of seven data points in this figure. The PTEs are calculated approximating the number of degrees of freedom to be equal to the number of data points and without propagating uncertainties in theory predictions.
  ],
  placement: top,
)
<fig:lensing_bao_residuals>

In Fig.~#ref(<fig:lensing_bao_residuals>, supplement: none), we show predictions for the two main datasets we combine with: ACT DR6+~NPIPE CMB lensing and DESI BAO. We find that the P-ACT~$Lambda"CDM"$~best-fit model predicts these observations well, and slightly improves the agreement with the DESI data, compared to that seen for the $Lambda"CDM"$~model determined by #emph[Planck] alone. The same figure also shows the combined P-ACT-LB~$Lambda"CDM"$~fit to all datasets, including residuals and the probability to exceed (PTE) for CMB lensing and BAO.#footnote[The three models give very similar PTEs for CMB lensing --- 34.7%, 35.3%, 35.3% for #emph[Planck], P-ACT, and P-ACT-LB, respectively --- which round to the same number when reporting only two significant figures.] We find here and in L25 that the jointly-derived $Lambda"CDM"$~model is a good fit to all datasets. The residuals and best-fit PTE for #emph[Planck] and ACT primary CMB power spectra are discussed in L25.

Figure~#ref(<fig:SNIa_lcdm_comp>, supplement: none) shows the equivalent comparison for the PantheonPlus SNIa compilation. We show the usual Hubble diagram of the distance modulus (corrected apparent magnitude) of all SNIa in the compilation as a function of redshift, and compare it with $Lambda"CDM"$~predictions from the CMB and the joint best-fit model. Differently from #cite(<Panthoen-plus-cosmology>), we do not normalize the distance modulus using the SH0ES calibration. Instead, we separately obtain and correct for the absolute magnitude calibration from the Planck and P-ACT~cosmology. The fit of the joint P-ACT-S~dataset marginalizes over this calibration while sampling the cosmological parameters. We find that all $Lambda"CDM"$~solutions are in good agreement with the whole sample, recovering maximum-likelihood values similar to those reported in the PantheonPlus public chains.

// [figvision-cn] imgs/fig41.png
// 该图由上下两个子图组成，共享横轴，展示了 Pantheon+ 超
// 新星样本的距离模数与红移的关系，并与不同宇宙学模型的预
// 测进行对比。 子图（上）：距离模数-红移图 类型：散点图
// 与曲线拟合图。 横轴：红移 z，采用对数坐标，范围约从 10
// ^-3 到略大于 10^0，主刻度标注为 10^-3、10^-2、10^-1、
// 10^0。 纵轴：距离模数 μ，线性坐标，范围约从 28 到 47，
// 主刻度标注为 30、35、40、45。 数据与曲线： 青色半透明
// 带误差棒的散点：Pantheon+ 超新星样本数据点，分布在红移
// 10^-3 到 2 之间，距离模数从约 29 上升至约 47。低红移端
// 数据点较少且误差棒较大，高红移端数据点密集。 黑色实线：
// P-ACT-S 联合拟合（Planck ACT CMB 加超新星）的最佳拟合
// 预测，贯穿整个红移范围。 深蓝色虚线：P-ACT CMB 预测（
// 基于 P-ACT 各向异性最佳拟合模型），在低红移端与黑色实
// 线几乎重合，高红移端略有偏离。 橙色虚线：Planck CMB 预
// 测（基于 Planck 各向异性最佳拟合模型），与黑色实线高度
// 重合，仅在极高红移处有微小差异。 趋势：三条理论曲线均
// 随红移增加而单调上升，且彼此之间差异极小；Pantheon+ 数
// 据点紧密围绕三条曲线分布，表明观测数据与模型预测高度一
// 致。图中图例标注了四条曲线/数据的名称。 子图（下）：残
// 差图 类型：残差散点图。 横轴：与上图共享，红移 z，对数
// 坐标，范围 10^-3 至 10^0。 纵轴：残差（Residual），线
// 性坐标，范围约从 -0.75 到 0.75，主刻度标注为 -0.50、
// -0.25、0.00、0.25、0.50。 数据与曲线： 青色半透明带误
// 差棒的散点：Pantheon+ 数据点相对于各自最佳拟合宇宙学模
// 型的残差，分布在零线上下，误差棒范围约 ±0.3 至 ±0.7。
// 低红移端（<10^-2）数据点稀疏，误差棒较大；高红移端（>
// 10^-1）数据点密集，误差棒较小。 水平零线：黑色实线，表
// 示残差为零。 橙色虚线：Planck 预测的残差基线，与零线重
// 合。 深蓝色虚线：P-ACT 预测的残差基线，与零线重合。 趋
// 势：残差围绕零线无系统性偏差，表明 Pantheon+ 数据与三
// 种模型预测均吻合良好；残差离散度随红移增加而减小，反映
// 了高红移超新星样本量的增加和测量精度的提升。
#figure(image("imgs/fig41.png"),
  caption: [
    The SNIa Hubble diagram, showing the distance modulus $mu$ as a function of redshift for the PantheonPlus compilation. The full SNIa sample is compared with the CMB anisotropy best-fit $Lambda"CDM"$~model predictions (from either #emph[Planck] or P-ACT), and with the joint P-ACT~CMB plus SNIa $Lambda"CDM"$~best-fit (P-ACT-S~in black). The distance modulus has been calibrated relative to each $Lambda"CDM"$~best-fit cosmology (rather than using SH0ES, as done in ).
  ],
  placement: top,
)
<fig:SNIa_lcdm_comp>

// [figvision-cn] imgs/fig42.png
// 这是一张单一子图的科学数据曲线图，图型为带有误差棒的散
// 点图与理论预测置信带叠加的曲线图。图中未标注子图编号（
// 如a、b、c），整体为单一面板。 坐标轴：横轴为红移 z，范
// 围从 0.0 到 1.5，主刻度间隔 0.5，无单位。纵轴为 fσ8(z)，
// 范围从 0.2 到 0.7，主刻度间隔 0.1，无单位。 图例：位于
// 右上角，包含四项。第一项为红色半透明色块，标注 “ΛCDM
// W-ACT 68% CL”，表示 W-ACT 数据对 ΛCDM 宇宙学模型的最佳
// 拟合在 68% 置信区间内的理论预测带。第二项为蓝色半透明
// 色块，标注 “ΛCDM P-ACT 68% CL”，表示 P-ACT 数据对 ΛCDM
// 模型的最佳拟合在 68% 置信区间内的理论预测带。第三项为
// 灰色实心圆点带竖直误差棒，标注 “Data in fσ8 Likelihood
// ”，表示用于似然分析的 fσ8 测量数据点。第四项为绿色空心
// 圆点带竖直误差棒，标注 “DESI fσ8”，表示 DESI 项目的 fσ
// 8 测量值，图注说明这些数据未用于似然分析。 数据点与误
// 差棒：灰色实心圆点共约 15 个，散布于 z 从 0.0 到 1.5
// 的区间内，误差棒长度差异较大。例如在 z≈0.1 处数据点约
// 为 0.49，误差棒从约 0.42 延伸至 0.69；在 z≈0.5 处数据
// 点约为 0.46，误差棒从约 0.33 延伸至 0.55；在 z≈1.3 处
// 数据点约为 0.50，误差棒从约 0.35 延伸至 0.66；在 z≈1.5
// 处数据点约为 0.46，误差棒从约 0.40 延伸至 0.50。绿色空
// 心圆点共约 6 个，分别位于 z≈0.3（约 0.38）、z≈0.5（约
// 0.52）、z≈0.7（约 0.48）、z≈0.9（约 0.42）、z≈1.3（约
// 0.37）、z≈1.5（约 0.44），每个空心圆点配有绿色竖直误差
// 棒。 理论置信带：红色带与蓝色带在 z=0 至 z=1.5 范围内
// 呈现先上升后下降的平滑曲线形状。在 z=0 处，红色带中心
// 约 0.45，蓝色带中心约 0.44；在 z≈0.3 附近达到峰值，红
// 色带中心约 0.50，蓝色带中心约 0.49；随后缓慢下降，在 z
// =1.5 处红色带中心约 0.39，蓝色带中心约 0.38。红色带整
// 体略高于蓝色带，两条带宽度相近，在纵轴上约覆盖 ±0.02
// 的范围。 趋势与结论：图中显示 fσ8(z) 随红移 z 的演化呈
// 先增后减的形态，在 z≈0.3 附近达到最大值约 0.5。灰色数
// 据点和绿色数据点总体围绕理论置信带分布，但灰色数据点误
// 差棒较大且部分点偏离带外（如 z≈0.1 处偏高、z≈0.8 处偏
// 低）。DESI 绿色数据点在 z≈0.5 处略高于理论带，在 z≈1.3
// 处略低于理论带，但整体与 ΛCDM 模型预测带一致。该图传达
// 的趋势是：观测到的 fσ8 数据与两种 ΛCDM 模型预测在 68%
// 置信区间内基本吻合，且 P-ACT 与 W-ACT 给出的理论预测带
// 非常接近。
#figure(image("imgs/fig42.png"),
  caption: [
    Measurements of $f sigma_8$ used in our likelihood analysis of the modified gravity model (§@sec:mg) with 1$sigma$ error bars (gray). The navy band shows the theoretically-predicted $f sigma_8 ( z )$ with the 68% confidence interval for the best-fit $Lambda"CDM"$~cosmology to P-ACT, with the brown band representing the same for W-ACT. We also show $f sigma_8$ measurements from DESI~@2024desi in green, but note that these are not used in our $f sigma_8$ likelihood analysis and are only shown for comparison.
  ],
  placement: top,
)
<fig:fsigma8_points>

Figure~#ref(<fig:fsigma8_points>, supplement: none) shows the data used in the $f sigma_8$ likelihood from §@sec:mg, compared with the theoretical predictions in $Lambda"CDM"$~for $f sigma_8 ( z )$ from the 68%~CL~constraints for P-ACT~and W-ACT~(L25). It appears that the hint of deviation from $Lambda"CDM"$~found in §@sec:mg is driven by low-$z$ points in the $f sigma_8$ dataset that have small error bars and lie below the CMB expectation for $f sigma_8 ( z )$. To assess the difference between the CMB-predicted $f sigma_8 ( z )$ and the data points from RSD and peculiar velocity surveys, we compute the $chi^2$ between them, finding $chi^2 = 28.0$ with respect to the P-ACT~prediction and $chi^2 = 37.3$ with respect to the W-ACT~prediction, both for 20 degrees of freedom, indicating some discordance (note, however, that these $chi^2$ values do not propagate the theoretical uncertainty on the CMB predictions). These $chi^2$ values decrease significantly if we omit two of the low-$z$ peculiar velocity data points that have the lowest $f sigma_8$ values. These points are at redshifts $z = 0.025$ (from #cite(<Turner:2022mla>, style: "aas_noparen.csl"), with $f sigma_8 = 0.357 plus.minus 0.071$) and $z = 0.035$ (from #cite(<Said:2020epb>, style: "aas_noparen.csl") with $f sigma_8 = 0.338 plus.minus 0.027$). Omitting these points, we find $chi^2 = 14.4$ for the P-ACT~prediction and $chi^2 = 19.1$ for W-ACT, both for 18 degrees of freedom, illustrating no tension. Because of the significant $chi^2$ reduction that results from removing the lowest two redshift points, we conclude that deviations from $Lambda$CDM when including $f sigma_8$ data in §@sec:mg are largely driven by those points. In theory, one could redo the analysis omitting those points from the likelihood. However, we do not perform this exercise here since it is not the ACT DR6 data driving these deviations.

Figure~#ref(<fig:fsigma8_points>, supplement: none) also shows recent $f sigma_8$ measurements from DESI~@2024desi, though these points are not used in our joint likelihood analysis. Assuming a diagonal covariance matrix, we find that the DESI measurements have $chi^2 = 4.0$ with respect to the P-ACT~$Lambda"CDM"$~prediction and $chi^2 = 4.2$ with respect to the W-ACT~$Lambda"CDM"$~prediction, both for 6 degrees of freedom. Thus, the DESI RSD data are in good agreement with $Lambda$CDM, further suggesting that the two outlying $f sigma_8$ points at very low-$z$ are not indicative of new physics.

== Cosmological concordance
<subsec:concordance>
Many of the models studied in this paper impact the value of the Hubble constant inferred from the primary CMB power spectra, and the precision of the $H_0$ measurement changes because of parameter degeneracies in these scenarios. In some cases, such as in models with variations in the particle physics content and/or particle interactions, the degeneracies are due to changes in the ingredients of the universe affecting the expansion history at early times. In other cases, for example for the early dark energy model, the physics prior to or at recombination is changed significantly to reduce the sound horizon and this increases the Hubble constant at the expense of additional degrees of freedom in the cosmological model correlating with $H_0$. While no robust detection of any of these extended models has been made in previous CMB or LSS data, some of these models have previously had non-negligible success in shifting the CMB-derived $H_0$ value toward the local distance ladder estimate from SH0ES. In this work, we have shown that this is generally no longer the case when including the new ACT data. ACT DR6 contributes to limiting the allowed region of parameter space to $66.1 < H_0 < 71.0$~km/s/Mpc within all of the models studied here. This range is calculated as the minimum and maximum value at 68% CL of all the P-ACT-LB~and P-ACT-LBS~results (whichever yields higher precision) from all models explored in this work; the neutrino self-interaction result from §@sec:neu_si sets the lower end of the allowed range and the early dark energy result from §@sec:ede sets the upper end. This range of values is in agreement with the CCHP measurement~@Freedman_CCHP, but lies below the latest SH0ES measurement~#cite(<Breuval:2024lsv>).

// [figvision-cn] imgs/fig43.png
// 这是一张单面板图表（非多子图结构），用于展示不同宇宙学
// 模型类别下推断出的哈勃常数 H0 的测量值范围。 图表类型
// 为水平区间对比图，横轴为 H0，单位为 km/s/Mpc，刻度范围
// 为 66 到 74，主刻度间隔为 1。纵轴无标注，仅用于垂直排
// 列不同模型类别的允许范围。 背景包含两个垂直色带：右侧
// 浅灰色带覆盖 H0 约 72.5 至 74，标注为“SHOES”；中间淡黄
// 色带覆盖 H0 约 68.5 至 72.5，标注为“CCHP”。左侧白色区
// 域无背景标注。 图中包含五个水平矩形框，每个框代表一类
// 模型下 H0 的 68% 允许区间，框内文字标注类别名称。最上
// 方是一个紫色矩形框，标注“ΛCDM (P-ACT-LB)”，其水平范围
// 约为 67.6 至 68.0，框中央有一个紫色空心圆点，两侧带水
// 平误差棒，表示该基准模型的最佳拟合值与 68% 置信区间。
// 其下方依次为：浅紫色框“Primordial perturbations”，范围
// 约 67.8 至 68.8；蓝绿色框“Pre- and modified
// recombination physics”，范围约 68.0 至 71.1；灰绿色框“
// Particle astrophysics”，范围约 66.2 至 69.2；最下方为
// 粉紫色框“Late-time physics”，范围约 67.2 至 69.2。各框
// 之间用细灰色箭头连接，箭头从上方框的底部指向下方框的顶
// 部，表示模型类别的扩展方向，箭头端点落在下方框的上边缘
// 不同位置。 图中所有标注文字包括：顶部“ΛCDM (P-ACT-LB)”，
// 四个类别框内文字“Primordial perturbations”、“Pre- and
// modified recombination physics”、“Particle
// astrophysics”、“Late-time physics”，背景标注“CCHP”和“
// SHOES”，以及横轴标签“H0 [km/s/Mpc]”。 该图传达的趋势是：
// 基准 ΛCDM 模型给出的 H0 值集中在约 67.8 km/s/Mpc，与
// CCHP 区域部分重叠；当引入原初扰动、复合前/修改复合物理、
// 粒子天体物理或晚期物理等扩展模型后，H0 的允许范围向高
// 值方向展宽，其中“Pre- and modified recombination
// physics”类模型的上限可达约 71.1 km/s/Mpc，接近但尚未完
// 全覆盖 SHOES 区域（约 73-74 km/s/Mpc）。各扩展模型类别
// 的下限也可低至约 66.2 km/s/Mpc，表明不同物理机制对 H0
// 的推断方向存在差异。
#figure(image("imgs/fig43.png"),
  caption: [
    Inferred measurements of the Hubble constant across classes of models from P-ACT~primary CMB combined with low-redshift data. Each box captures the range of $H_0$ allowed by all models explored in this paper within that class (§@sec:inflation–§@sec:late-time) --- drawing from the 68% limits obtained with the most stringent data combination for that model, P-ACT-LB~or P-ACT-LBS~depending on the model (see also Fig.~#ref(<fig:H0_1D>, supplement: none)) --- and marks shifts and broadening with respect to the 68% CL estimate in $Lambda"CDM"$~from P-ACT-LB~(purple bar, L25). All estimates are statistically consistent with the CCHP measurement (68%~CL from #cite(<Freedman_CCHP>, style: "aas_noparen.csl"), gold band), but no class of extensions fully meets the bounds from SH0ES (68%~CL from #cite(<Breuval:2024lsv>, style: "aas_noparen.csl"), gray band). See also~#cite(<2024ARAandA..62..287V>) for additional direct $H_0$ measurements.
  ],
  placement: top,
)
<fig:H0_variation>

// [figvision-cn] imgs/fig44.png
// 这是一张水平点线图（森林图），用于展示不同宇宙学模型对
// 哈勃常数 H0 推断值的约束。纵轴为分类模型名称，横轴为
// H0 [km/s/Mpc]，范围约 65 到 75。图中有两条黑色垂直虚线，
// 分别位于 67.4 和 68.5 附近，代表参考值。背景有两个阴影
// 带：浅米色带（约 68.5 到 72.5）标注为 CCHP，浅灰色带（
// 约 72.5 到 74.5）标注为 SH0ES。图中数据点以圆点或方块
// 表示，水平线段为误差棒，实线表示默认约束，虚线表示其他
// 约束。 子图从上到下分为四组： 第一组为参考模型：ΛCDM，
// 黑色实心圆点位于约 67.8，误差棒很短（约 67.5 到 68.1）。
// 第二组为“Early Times”（早期时间，青色），包含 8 个模型：
// EDEn=3 (§5.1)：青色实心圆点位于约 70.0，误差棒约 68.8
// 到 71.2。 EDEn=2 (§5.1)：青色实心圆点位于约 69.8，误差
// 棒约 68.6 到 71.0。 me (§5.2)：青色实心圆点位于约 69.7，
// 误差棒约 68.5 到 70.9。 me + Ωk (§5.2)：青色方块位于约
// 68.7，误差棒为虚线，约 67.4 到 69.9。 αEM (§5.2)：青色
// 实心圆点位于约 69.2，误差棒约 68.0 到 70.4。 PMF (§5.3
// )：青色实心圆点位于约 69.1，误差棒约 68.1 到 70.1。
// TCMB (§5.4)：青色实心圆点位于约 68.6，误差棒约 67.6 到
// 69.6。 ModRec (§5.5)：青色实心圆点位于约 69.9，误差棒
// 约 68.7 到 71.1。 第三组为“Particle Astro.”（粒子天体
// 物理，橄榄绿色），包含 6 个模型： Neff (§6.1)：橄榄绿
// 实心圆点位于约 66.6，误差棒约 65.4 到 67.8。 M1ν +
// Neff + Σmν (§6.1)：橄榄绿实心圆点位于约 66.8，误差棒约
// 65.6 到 68.0。 S1ν + Neff + Σmν (§6.1)：橄榄绿实心圆点
// 位于约 66.8，误差棒约 65.6 到 68.0。 geff (§6.1)：橄榄
// 绿实心圆点位于约 68.6，误差棒约 67.8 到 69.4。 SIDR (§
// 6.5)：橄榄绿实心圆点位于约 68.6，误差棒约 67.8 到 69.4。
// SIDR IDM (§6.5)：橄榄绿实心圆点位于约 68.6，误差棒约
// 67.8 到 69.4。 第四组为“Late Times”（晚期时间，深红色），
// 包含 3 个模型： w (§7.2)：深红色方块位于约 67.4，误差
// 棒为虚线，约 66.3 到 68.5。 w0wa (§7.2)：深红色方块位
// 于约 67.6，误差棒为虚线，约 66.5 到 68.7。 γ (§7.4)：
// 深红色实心圆点位于约 68.4，误差棒约 67.4 到 69.4。 图
// 表传达的趋势是：早期时间模型倾向于将 H0 推断值推向更高
// （约 69-70），粒子天体物理模型倾向于将 H0 推断值推向更
// 低（约 66.5-68.6），晚期时间模型则介于两者之间或接近参
// 考值。
#figure(image("imgs/fig44.png"),
  caption: [
    The three classes of models shown in Fig.~#ref(<fig:H0_variation>, supplement: none) that have an impact on the inferred value of $H_0$ --- changes in early-time physics before or at recombination (teal), new particle astrophysics (olive green), and new physics impacting the late-time expansion of the universe (dark red) --- are broken down here into the constraints for specific models within each class. Solid (dashed) bars are constraints at 68% confidence derived from P-ACT-LB~(P-ACT-LBS).
  ],
  placement: top,
)
<fig:H0_1D>

These results are summarized in Fig.~#ref(<fig:H0_variation>, supplement: none). Figure~#ref(<fig:H0_1D>, supplement: none) provides more details on the full suite of $H_0$ constraints for the three classes of models that have a non-negligible impact on $H_0$. Figure~#ref(<fig:H0-tension>, supplement: none) breaks this result further down into the specific behavior of $H_0$ versus key model parameters in many extended models of interest, and shows that both the CMB-only dataset, P-ACT, and its combination with CMB lensing and BAO, P-ACT-LB, are inconsistent with the SH0ES estimate. Because of correlations with the inferred value of the total matter density $Omega_m$,#footnote[Note that the primary CMB most directly constrains a degenerate combination of $Omega_m$ and $H_0$, roughly $Omega_m h^3$, with the exact value of the exponent depending on the range of angular scales measured, due to the different physical effects at play~@2002MNRAS.337.1068P#cite(<2019ApJ...871...77K>).] BAO data play an important role in determining the central value of $H_0$ in many extended models. Notably, as shown in many of the analyses in §@sec:recomb–§@sec:late-time, using BOSS BAO instead of DESI data reduces the central value of $H_0$ by 1--1.5~km/s/Mpc --- hence moving constraints in the opposite direction of SH0ES --- while only slightly increasing the error bars. Upcoming DESI data will be instrumental in further clarifying this situation.

From a more model-independent perspective, the consistency of the inferred physical matter density $Omega_m h^2$ from #emph[Planck] and ACT (as well as their combination; L25) within $Lambda"CDM"$~provides a strong indication that the $Lambda"CDM"$~model accurately describes physics just prior to recombination. As noted in~@KnoxMillea2020, the shape of the radiation-driving envelope in the CMB power spectra is directly tied to the physics operating around matter-radiation equality. If new physics were present at this epoch, a generic expectation is that $Lambda"CDM"$-based inferences of $Omega_m h^2$ should exhibit deviations when inferred on different angular scale ranges, due to different scales probing $H ( z )$ at different times via radiation driving. We see no such evidence of such deviations in $Omega_m h^2$ (L25), thus providing a strong validation of the physics of $Lambda"CDM"$~in this important redshift range.

// [figvision-cn] imgs/fig45.png
// 这是一张由七个纵向堆叠的子图（面板）组成的科学图表，所
// 有面板共用底部横坐标轴。整体展示了不同扩展宇宙学模型参
// 数与哈勃常数 H0 之间的二维置信区间约束。 全局特征： 底
// 部横坐标为 H0 [km/s/Mpc]，范围约 64 至 76，主刻度分别
// 为 66、68、70、72、74。 图表顶部有两个标签：深蓝色文字
// “P-ACT”和紫色文字“P-ACT-LB”，分别对应图中深蓝色和紫色
// 的等高线轮廓。 贯穿所有面板的垂直背景色带： 棕色半透明
// 垂直带：中心约在 H0=68，宽约 1.5，中心有虚线，代表“
// P-ACT-LB ΛCDM”的约束。 浅黄色垂直带：范围约 H0=67 至
// 73.5，标注文字为“CCHP”。 灰色垂直带：范围约 H0=72.5 至
// 74.5，中心有虚线，标注文字为“SH0ES”。 子图 a（最上方）：
// 纵轴为 Neff，标有刻度 2.5 和 3.0。图中显示两个倾斜的椭
// 圆等高线（内圈 68%，外圈 95%）：深蓝色椭圆向左上倾斜，
// H0 约 65.5-68，Neff 约 2.6-3.1；紫色椭圆略向右侧偏移，
// H0 约 67-69.5，Neff 约 2.5-3.2。图中标有文字“P-ACT-LB
// ΛCDM”位于紫色椭圆下方。该图表明 Neff 与 H0 呈正相关退
// 化。 子图 b： 纵轴为 log10(GeffMeV⁻²)，范围约 -6.5 至
// -3.0，标有刻度 -6 和 -4。图中为垂直方向的椭圆等高线：
// 深蓝色轮廓主要覆盖 H0 约 66-68，纵轴跨度 -6.2 至 -3.2；
// 紫色轮廓主要覆盖 H0 约 67-69.5，纵轴跨度相似。左上角标
// 有文字“Mlν”。约束在 H0 方向较窄，纵向较宽。 子图 c：
// 纵轴为 fEDE，主刻度为 0.05、0.10、0.15。左上角标有文字
// “n = 3”。两个椭圆等高线向右上倾斜，深蓝色覆盖 H0 约
// 65-69.5，纵轴约 0.03-0.13；紫色覆盖 H0 约 67-70.5，纵
// 轴约 0.04-0.15。显示 fEDE 与 H0 呈正相关。 子图 d： 纵
// 轴为 me/me,0，标有刻度 0.98 和 1.02。等高线向右上倾斜，
// 深蓝色椭圆覆盖 H0 约 65-69，纵轴约 0.98-1.015；紫色椭
// 圆覆盖 H0 约 67-70.5，纵轴约 0.99-1.02。显示该参数与
// H0 呈正相关退化。 子图 e： 纵轴为 b，标有刻度 0.2、0.4、
// 0.6。等高线向右上倾斜，深蓝色覆盖 H0 约 66-69.5，纵轴
// 约 0.25-0.45；紫色覆盖 H0 约 67.5-70.5，纵轴约
// 0.3-0.55。显示 b 与 H0 呈正相关。 子图 f： 纵轴为 TcνB
// [K]，标有刻度 2.6、2.7、2.8。等高线向右下倾斜，深蓝色
// 覆盖 H0 约 65-70，纵轴约 2.7-2.82；紫色椭圆覆盖 H0 约
// 68-70，纵轴约 2.66-2.72。显示该参数与 H0 呈负相关退化。
// 子图 g（最下方）： 纵轴为 Ndr，标有刻度 0.1 和 0.2。等
// 高线向右上倾斜，深蓝色覆盖 H0 约 66-69，纵轴约
// 0.05-0.15；紫色覆盖 H0 约 67.5-70.5，纵轴约 0.05-0.18。
// 整体趋势：所有面板中，深蓝色（P-ACT）和紫色（P-ACT-LB）
// 的置信区间均未能延伸到灰色带（SH0ES）的中心区域，表明
// 扩展模型参数的引入并未使 P-ACT 或 P-ACT-LB 的约束与
// SH0ES 的测量结果一致。
#figure(image("imgs/fig45.png"),
  caption: [
    Constraints at 68% and 95% confidence on $H_0$ in select extended models from P-ACT~(navy) and P-ACT-LB~(purple), with the vertical bands indicating the $2 sigma$ limits for the latter data combination within $Lambda"CDM"$. Degeneracies with extended-model parameters do not move the P-ACT~or P-ACT-LB~limits into agreement with the SH0ES constraints ($2 sigma$ region from #cite(<Breuval:2024lsv>, style: "aas_noparen.csl") shown as a gray band), but the constraints are in agreement with the CCHP measurement ($2 sigma$ region from #cite(<Freedman_CCHP>, style: "aas_noparen.csl") shown as a gold band). Note that the MI$nu$ model shown in the second panel also includes varying $N_(upright("eff"))$ and $sum m_nu$.
  ],
  placement: top,
)
<fig:H0-tension>

// [figvision-cn] imgs/fig46.png
// 这是一张竖向排列的六联图，六个子图共享横轴，横轴标注为
// \(S_8\)，刻度范围约0.72至0.88，重点显示0.75、0.80、
// 0.85三个刻度。全图顶部图例显示深蓝色代表P-ACT，紫色代
// 表P-ACT-LB。每个子图均包含深蓝色和紫色的嵌套填充等高线
// 区域，分别表示P-ACT与P-ACT-LB在68%和95%置信度下的约束。
// 图中还包含两条竖向参考带：金色竖带代表DES+KiDS宇宙剪切
// 限制（固定中微子质量情况），紫色竖带代表P-ACT-LB的\(\
// Lambda\)CDM约束。 子图a：纵轴为\(\Sigma m_\nu\) [eV]，
// 刻度范围0.0至0.5，间隔0.1。深蓝色轮廓为从\(S_8\)约0.82
// 处向右延伸并向下弯曲的宽条带，紫色轮廓位于右下方，表示
// 更低的\(S_8\)和\(\Sigma m_\nu\)值。金色和紫色竖带叠加
// 在图中。结论：P-ACT-LB约束更严格，且与DES-Y3+KiDS在\(
// S_8\)上一致。 子图b：纵轴为\(10^{26} \times \sigma_0\)
// [cm²]，刻度范围0.0至1.5，间隔0.5。左上角标注“\(n=0\)”。
// 深蓝色轮廓在\(S_8\)约0.81处形成纵向长椭圆，紫色轮廓更
// 小且偏右下。结论：P-ACT-LB对\(\sigma_0\)的限制更强。
// 子图c：纵轴为\(w\)，刻度范围-1.8至-0.6，间隔0.2。深蓝
// 色轮廓为从左上向右下倾斜的长椭圆，紫色轮廓较小且位于中
// 部。结论：P-ACT-LB显著缩小了状态方程参数的允许范围。
// 子图d：纵轴为\(\gamma\)，刻度范围0.5至0.9，间隔0.1。深
// 蓝色轮廓为向右下倾斜的椭圆，紫色轮廓更紧凑。结论：
// P-ACT-LB对\(\gamma\)的约束更精确。 子图e：纵轴为\(\
// Gamma_{\text{IDM}} / H_0 \rho_c\)，刻度范围0.0至2.0，
// 间隔0.5。深蓝色轮廓为从左上向右下延伸的狭长条带，紫色
// 轮廓较长且覆盖更大范围，中心偏左。结论：两种模型在此参
// 数上存在一定差异，但均与参考带重叠。 子图f：纵轴为\(N_
// {\text{IDM}}\) (IDM)，刻度范围0.05至0.25，间隔0.05。深
// 蓝色和紫色轮廓均为单峰分布，紫色峰更高更窄，中心约在\(
// S_8 \approx 0.81\)。结论：P-ACT-LB对IDM粒子数的约束更
// 集中。 整体趋势：P-ACT-LB（紫色）在所有子图中的约束区
// 域均比P-ACT（深蓝色）更小，表明加入透镜先验后参数限制
// 显著改善，且与DES-Y3+KiDS结果在统计上一致。
#figure(image("imgs/fig46.png"),
  caption: [
    Constraints at 68% and 95% confidence on $S_8$ in select extended models from P-ACT~(navy) and P-ACT-LB~(purple) compared to the DES-Y3+KiDS cosmic shear limit ($2 sigma$ region from the $Lambda"CDM"$~case with fixed neutrino mass from #cite(<DES_KIDS_shear_2023>, style: "aas_noparen.csl") shown as a gold band). The P-ACT-LB~$Lambda"CDM"$~constraint ($2 sigma$ purple vertical band) is already in statistical agreement with DES-Y3+KiDS (see L25). Degeneracies with extended-model parameters do not generally move the P-ACT-LB~central values to even lower $S_8$ values at the center of the DES-Y3+KiDS posterior.
  ],
  placement: top,
)
<fig:S8-tension>

We also find that models that alter the growth of structure are not preferred by our data. In particular, we do not find evidence in any extended model for a significant shift in the CMB-inferred $S_8$ value toward lower late-universe estimates, for example from cosmic shear surveys, as summarized in Fig.~#ref(<fig:S8-tension>, supplement: none). Our results generally lie on the upper end of the limits from DES+KiDS~@DES_KIDS_shear_2023, although it is important to note that the $S_8$ value in $Lambda"CDM"$~is already consistent between P-ACT-LB~and this result.#footnote[The more recent KiDS Legacy measurement, $S_8 = 0.815_(- 0.021)^(+ 0.016)$, shifts to even higher values and is almost perfectly centered on the P-ACT-LB~result.] Also in this case the matter density inferred via DESI BAO will contribute to the location of the maximum-likelihood point. For all models tested, using BOSS instead of DESI BAO data yields qualitatively similar conclusions. In addition, it is important to note that the inference of $S_8$ itself from galaxy weak lensing or other late-time data will generally change in the presence of the new physics shown in these models (e.g., non-GR values of $gamma$ or non-zero $Gamma_("DMDE")$), and thus one should take the comparison shown here with a grain of salt. For a high-precision comparison, constraints from late-time data should be self-consistently derived in these extended models, which we leave to future, dedicated analyses.

= Summary
<sec:conclusions>
In this paper, we have used a state-of-the-art CMB primary anisotropy dataset built from new ACT DR6 power spectra combined with large-scale data from the #emph[Planck] satellite to set constraints on a large suite of extended cosmological models, both testing foundational assumptions made in the standard $Lambda"CDM"$~model and constraining more complex scenarios. We show that the new ACT DR6 data have reached a level of precision competitive with that of #emph[Planck] for the primary CMB contribution to the constraints, and because of the complementarity of the two datasets --- particularly at $ell > 2000$ in TT and on essentially all scales measured by ACT in TE and EE --- their joint analysis yields significant gains over the sensitivity of #emph[Planck] alone. We further include ACT and #emph[Planck] CMB lensing data, BAO data from DESI and SNIa from PantheonPlus to obtain the tightest limits to date on many fundamental physics parameters and cosmological models. To validate the results, we also explore combinations replacing #emph[Planck] with #emph[WMAP] large-scale CMB data, and DESI with BAO data from BOSS.

Key takeaways from this work include:

- We test predictions for the early-universe inflationary epoch, verifying the near-scale-invariance and adiabaticity of the primordial scalar perturbations, and restricting the parameter space for inflation models;

- We tightly bound the presence of early dark energy, or primordial magnetic fields that would impact the pre-recombination period, as well as variations in fundamental constants or in the monopole temperature of the CMB or the standard recombination history;

- We measure the properties of neutrinos and find no evidence for new light, relativistic species that are free-streaming, no evidence for non-zero neutrino masses, and no evidence for neutrino self-interactions. We also set limits on primordial helium and deuterium abundances that are consistent with standard BBN predictions and with astrophysical measurements;

- Dark matter is consistent with the standard collisionless CDM assumption, with no evidence for annihilation or interactions with baryons. We also limit the contribution to DM from ultralight axion-like particles to be no more than 5% at axion masses of $10^(- 26)$~eV;

- We find no evidence for interactions in the dark sector, either within a single dark radiation component, between dark radiation and dark matter components, or between dark matter and dark energy;

- Dark energy and late-time gravity generally behave as expected in the standard model ($w = - 1$ and $gamma = 0.55$), although we find a moderate hint for time-evolving dark energy with P-ACT-LBS, consistent with (and driven by the BAO and SNIa data from)~#cite(<DESI-BAO-VI>). Upcoming BAO and SNIa data are expected to clarify the robustness of this hint.

Assessing the preference for each extended model over $Lambda"CDM"$~via the marginalized posterior for the extended-model parameter (in the case of 1D extensions) or via comparison of the MAP model to that in $Lambda"CDM"$~(in the case of multi-parameter extensions), we find that no extended model is preferred over $Lambda"CDM"$. This conclusion includes a wide range of extended models constructed with the aim of increasing the value of the Hubble constant or decreasing the amplitude of density fluctuations inferred from the primary CMB. With these results providing stringent tests in new observational regimes, the footing of the standard model of cosmology is further solidified.

This work paves the way for further, higher-precision tests of the cosmological model in the coming decade with even more sensitive CMB polarization data, including that expected from the Simons Observatory~@Simons_Observatory@Enhanced_SO_2025, CMB-S4~@CMB_S4_Science_Book@CMBS4DSR, LiteBIRD~@LiteBIRD, and other experiments. The noise levels of these surveys will push nearly an order of magnitude below those of ACT DR6 over the next 10-15 years, enabling precise searches for new physics, including not only the models studied in this work, but also new scenarios yet to be constructed.

Shortly after the appearance of this paper, new BAO measurements from three years of DESI observations and corresponding cosmological interpretation were presented in~@DESI1_DR2#cite(<DESI-DR2>). In Appendix~@app:newDESI_tau, we present updated $Lambda"CDM"$~consistency and evolving dark energy constraints from this new dataset, finding results similar to those presented in the main text with DESI Year-1 observations and consistent with those reported in #cite(<2025arXiv250418464G>). We also present updated constraints on a subset of the extended models studied earlier in the paper. In addition, we show that relaxing the constraint on the optical depth leads to slightly reduced evidence for $w_0 / w_a$ and more relaxed bounds on the neutrino mass.

#heading(level: 1, numbering: none, outlined: false)[ACKNOWLEDGEMENTS]
<acknowledgements>
We are grateful to Julien Lesgourgues for assistance in providing the version of `class` used throughout this work, to Antony Lewis for useful exchanges regarding `camb`, and to Alessio Spurio Mancini for help with `CosmoPower`. We also thank Jens Chluba and Yacine Ali-Haimoud for useful correspondence regarding `CosmoRec` and `HyRec`, and we thank Gabriel Lynch for useful correspondence regarding the Modified Recombination scenario, Henrique Rubira for useful correspondence regarding the IDR-IDM scenario, and Minh Nguyen for useful correspondence regarding the modified-growth-index scenario.

Support for ACT was through the U.S.~National Science Foundation through awards AST-0408698, AST-0965625, and AST-1440226 for the ACT project, as well as awards PHY-0355328, PHY-0855887 and PHY-1214379. Funding was also provided by Princeton University, the University of Pennsylvania, and a Canada Foundation for Innovation (CFI) award to UBC. ACT operated in the Parque Astronómico Atacama in northern Chile under the auspices of the Agencia Nacional de Investigación y Desarrollo (ANID). The development of multichroic detectors and lenses was supported by NASA grants NNX13AE56G and NNX14AB58G. Detector research at NIST was supported by the NIST Innovations in Measurement Science program. Computing for ACT was performed using the Princeton Research Computing resources at Princeton University and the Niagara supercomputer at the SciNet HPC Consortium. SciNet is funded by the CFI under the auspices of Compute Canada, the Government of Ontario, the Ontario Research Fund--Research Excellence, and the University of Toronto. This research also used resources of the National Energy Research Scientific Computing Center (NERSC), a U.S. Department of Energy Office of Science User Facility located at Lawrence Berkeley National Laboratory, operated under Contract No. DE-AC02-05CH11231 using NERSC award HEP-ERCAPmp107 from 2021 to 2025. We thank the Republic of Chile for hosting ACT in the northern Atacama, and the local indigenous Licanantay communities whom we follow in observing and learning from the night sky.

Some cosmological analyses were performed on the Hawk high-performance computing cluster at the Advanced Research Computing at Cardiff (ARCCA). We made extensive use of computational resources at the University of Oxford Department of Physics, funded by the John Fell Oxford University Press Research Fund.

We are grateful to the NASA LAMBDA archive for hosting our data. This work uses data from the Planck satellite, based on observations obtained with Planck (http://www.esa.int/Planck), an ESA science mission with instruments and contributions directly funded by ESA Member States, NASA, and Canada. We acknowledge work done by the Simons Observatory collaboration in developing open-source software used in this paper.

IAC acknowledges support from Fundación Mauricio y Carlota Botton and the Cambridge International Trust. SA, MH and DNS acknowledge the support of the Simons Foundation. ZA and JD acknowledge support from NSF grant AST-2108126. EC, IH and HJ acknowledge support from the Horizon 2020 ERC Starting Grant (Grant agreement No 849169). OD acknowledges support from a SNSF Eccellenza Professorial Fellowship (No. 186879). JD acknowledges support from a Royal Society Wolfson Visiting Fellowship and from the Kavli Institute for Cosmology Cambridge and the Institute of Astronomy, Cambridge. RD and CS acknowledge support from the Agencia Nacional de Investigación y Desarrollo (ANID) through Basal project FB210003. RD acknowledges support from ANID-QUIMAL 240004 and FONDEF ID21I10236. SG acknowledges support from STFC and UKRI (grant numbers ST/W002892/1 and ST/X006360/1). SJG acknowledges support from NSF grant AST-2307727 and acknowledges the Texas Advanced Computing Center (TACC) at the University of Texas at Austin for providing computational resources that have contributed to the research results reported within this paper. V.G. acknowledges the support from NASA through the Astrophysics Theory Program, Award Number 21-ATP21-0135, the National Science Foundation (NSF) CAREER Grant No. PHY2239205, and from the Research Corporation for Science Advancement under the Cottrell Scholar Program.This research was carried out in part at the Jet Propulsion Laboratory, California Institute of Technology, under a contract with the National Aeronautics and Space Administration (80NM0018D0004). JCH acknowledges support from NSF grant AST-2108536, the Sloan Foundation, and the Simons Foundation, and thanks the Scientific Computing Core staff at the Flatiron Institute for computational support. MHi acknowledges support from the National Research Foundation of South Africa (grant no. 137975). ADH acknowledges support from the Sutton Family Chair in Science, Christianity and Cultures, from the Faculty of Arts and Science, University of Toronto, and from the Natural Sciences and Engineering Research Council of Canada (NSERC) [RGPIN-2023-05014, DGECR-2023- 00180]. JPH (George A. and Margaret M. Downsbrough Professor of Astrophysics) acknowledges the Downsbrough heirs and the estate of George Atha Downsbrough for their support. JK, MM and KPS acknowledge support from NSF grants AST-2307727 and AST-2153201. ALP acknowledges support from a Science and Technology Facilities Council (STFC) Consolidated Grant (ST/W000903/1). ML acknowledges that IFAE is partially funded by the CERCA program of the Generalitat de Catalunya. SN acknowledges a grant from the Simons Foundation (CCA 918271, PBL). TN thanks support from JSPS KAKENHI Grant No. JP20H05859, No. JP22K03682, and World Premier International Research Center Initiative (WPI Initiative), MEXT, Japan. FN acknowledges funding from the European Union (ERC, POLOCALC, 101096035). LP acknowledges support from the Wilkinson and Misrahi Funds. KKR is supported by an Ernest Rutherford Fellowship from the UKRI Science and Technology Facilities Council (grant number ST/Z510191/1). NS acknowledges support from DOE award number DE-SC0025309. KMS acknowledges support from the NSF Graduate Research Fellowship Program under Grant No.~DGE 2036197, and acknowledges the use of computing resources from Columbia University's Shared Research Computing Facility project, which is supported by NIH Research Facility Improvement Grant 1G20RR030893-01, and associated funds from the New York State Empire State Development, Division of Science Technology and Innovation (NYSTAR) Contract C090171, both awarded April 15, 2010. NB, MG, ML and LP acknowledge the financial support from the INFN InDark initiative and from the COSMOS network through the ASI (Italian Space Agency) Grants 2016-24-H.0 and 2016-24-H.1-2018. NB, MG and ML are funded by the European Union (ERC, RELiCS, project number 101116027). MG acknowledges support from the PRIN (Progetti di ricerca di Rilevante Interesse Nazionale) number 2022WJ9J33.

We gratefully acknowledge the many publicly available software packages that were essential for parts of this analysis. They include: camb~@Lewis_camb, class~@CLASS_2011@Lesgourgues_class, CosmoPower~@Spurio_Mancini_cosmopower, HyRec~@Hyrec, CosmoRec~@Cosmorec, HMcode~@Mead2020, PRIMAT~@2018PhR...754....1P, Cobaya~@Cobaya, PROSPECT~@Holm:2023uwa, GetDist~@Getdist, numpy~@Numpy, and matplotlib~#cite(<Hunter:2007>).

#counter(heading).update(0)
]
#columns(2, gutter: 1.06cm)[
  #set text(size: 9pt)
  #set par(leading: 0.82em, spacing: 0.82em)
  #show heading.where(level: 1): set align(center)
  #show heading.where(level: 1): set text(size: 12pt, weight: "regular")
  #set heading(outlined: false)
  #bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)
]
#pagebreak()

#set heading(numbering: (..n) => if n.len() == 1 { numbering("A", n.at(0)) } else { numbering("A.1", n.at(0), n.at(1)) })
#set par(spacing: 0.9em)

= Theory specifications
<app:theory>
For the results presented in this paper, we use multiple Einstein-Boltzmann codes to calculate theory predictions. We explore and define settings for both `camb` and `class` to ensure that the uncertainty in the theory calculations is well below the statistical error bars of the DR6 power spectra on all scales. In particular, some of the settings defined for the #emph[Planck] baseline analyses require revision to give unbiased results with our new small-scale measurements, as pointed out in, e.g.,~@Hill_ACT_EDE#cite(<McCarthy_2022>). For this work, we revise precision parameters for the calculation of the lensed CMB spectra, as well as baseline choices for non-linear modeling of the matter power spectrum, effects of baryonic feedback in the non-linear matter power spectrum model, recombination calculations, and the choice of BBN calculations (the latter is described in detail in~§@sec:bbn). We obtain the baseline settings summarized in~§@sec:method and reported in Figs.~#ref(<snip:camb_accuracy>, supplement: none) and #ref(<snip:class_accuracy>, supplement: none) below.

To assess robustness of the theory specifications with respect to the data, we consider both cosmological parameter posteriors using different assumptions and single likelihood evaluations to study the impact on the $chi^2$ of a reference best-fit model. In general, we find that parameter posteriors are unbiased, but $chi^2$ values can vary across the parameter space, for both $Lambda"CDM"$~and extended models. We summarize the results of these investigations here:

- #emph[Numerical accuracy settings---] Accuracy parameters for the calculations of the lensed CMB theory power spectra were studied in previous works and validated for sensitivity levels beyond that of ACT DR6~@Bolliet_emulators#cite(<Jense_emulators>).

- #emph[Recombination---] For recombination modeling, we compare the (previously-used-as-default) `RecFast` code with the alternative `HyRec` and `CosmoRec` codes, both of which can be manually installed within `camb`. When evaluating the DR6 CMB-only likelihood `ACT-lite` at the best-fit $Lambda"CDM"$~point from L25, we find $Delta chi_(R e c f a s t - H y R e c)^2 = 0.37$ and $Delta chi_(R e c f a s t - C o s m o R e c)^2 = 0.49$, and with `HyRec` and `CosmoRec` agreeing within $Delta chi_(H y R e c - C o s m o R e c)^2 = 0.12$. Moving away from the best-fit point, the differences increase and vary across parameter space, with `RecFast` calculations compared to either `HyRec` or `CosmoRec` reaching $Delta chi^2 tilde.op O ( 100 )$. Looking at the contributions to this difference across multipoles, we find that it mostly comes from TT at $ell tilde.op 2000$. No significant difference in parameter posteriors is found. Given that `Recfast` relies on fudge factors optimized for the #emph[Planck] sensitivity but not beyond, and given that `CosmoRec` and `HyRec` have been proven to be consistent for precise calculations of hydrogen recombination --- with `CosmoRec` implementing also more complex helium recombination @2012MNRAS.423.3227C --- we choose to use `CosmoRec` as our baseline for use with `camb`. Since `CosmoRec` is not available with `class`, we use `HyRec` for models using this code.

- #emph[Non-linear matter power spectrum---] Previous CMB analyses~@Choi2020@Planck_2018_params used `Halofit` or the 2016 version of `HMcode` to compute the non-linear matter power spectrum, which is necessary for modeling CMB lensing. Here, we switch to the updated 2020 version of `HMcode`. We adopt the dark-matter-only model with the default parameters. At the $Lambda"CDM"$~best-fit point, we find $Delta chi_(H a l o f i t - H M c o d e 2020)^2 = 0.09$.

- #emph[Baryonic feedback in non-linear modeling---] To assess the impact of parameters describing baryonic feedback in `HMcode`, we run calculations with dark-matter-only versus dark-matter-plus-baryons, with the default settings for baryonic feedback. At the $Lambda"CDM"$~best-fit point, this gives $Delta chi_(D M - D M + b)^2 = 0.20$. We also test the impact of the strength of baryonic feedback, comparing our baseline with DM+baryons and with baryons having `HMcode_logT_AGN=8.0` (rather than 7.8), thus corresponding to a stronger feedback model with larger suppression of the small-scale matter power spectrum at late times. This gives $Delta chi_(D M - D M + b + f)^2 = 0.39$. For future analyses with Simons Observatory and CMB-S4 data, this effect will likely need to be accounted for in the modeling (as found in #cite(<McCarthy_2022>, style: "aas_noparen.csl")).

Figures~#ref(<snip:camb_accuracy>, supplement: none) and #ref(<snip:class_accuracy>, supplement: none) give code snippets from our `Cobaya` yaml files summarizing the baseline analysis settings. These configurations give results within $Delta chi_(mono("camb") - mono("class"))^2 tilde.op O ( 10^(- 2) )$. Figure~#ref(<fig:lcdm_benchmark>, supplement: none) shows validation across Einstein-Boltzmann codes for our baseline $Lambda"CDM"$~parameter constraints, including `camb`, `class`, and `CosmoPower`-based emulators; similar agreement is found also for extended models that are accessible in the three codes. In Table~#ref(<tab:models>, supplement: none) we list all the models explored in this work and enumerate the theory and likelihood codes used for each analysis.

#figure([```yaml
  camb:
    extra_args:
      kmax: 10
      k_per_logint: 130
      nonlinear: true
      lens_potential_accuracy: 8
      lens_margin: 2050
      lAccuracyBoost: 1.2
      min_l_logl_sampling: 6000
      DoLateRadTruncation: false
      recombination_model: CosmoRec
  ```

  ],
  kind: image,
  caption: [
    Baseline settings used for `camb` theory calculations, updating the default assumptions of `camb v1.5`. Note that `halofit_version=mead2020` and BBN consistency from PRIMAT 2021 are already default settings in this `camb` version.
  ]
)
<snip:camb_accuracy>

#figure([```yaml
  classy:
    extra_args:
      N_ncdm: 1
      m_ncdm: 0.06
      N_ur: 2.0308
      T_cmb: 2.7255
      YHe: BBN
      non_linear: hmcode
      hmcode_version: '2020'
      recombination: HyRec
      lensing: 'yes'
      output: lCl,tCl,pCl,mPk
      modes: s
      l_max_scalars: 9500
      delta_l_max: 1800
      P_k_max_h/Mpc: 100.
      l_logstep: 1.025
      l_linstep: 20
      perturbations_sampling_stepsize: 0.05
      l_switch_limber: 30.
      hyper_sampling_flat: 32.
      l_max_g: 40
      l_max_ur: 35
      l_max_pol_g: 60
      ur_fluid_approximation: 2
      ur_fluid_trigger_tau_over_tau_k: 130.
      radiation_streaming_approximation: 2
      radiation_streaming_trigger_tau_over_tau_k: 240.
      hyper_flat_approximation_nu: 7000.
      transfer_neglect_delta_k_S_t0: 0.17
      transfer_neglect_delta_k_S_t1: 0.05
      transfer_neglect_delta_k_S_t2: 0.17
      transfer_neglect_delta_k_S_e: 0.17
      accurate_lensing: 1
      start_small_k_at_tau_c_over_tau_h: 0.0004
      start_large_k_at_tau_h_over_tau_k: 0.05
      tight_coupling_trigger_tau_c_over_tau_h: 0.005
      tight_coupling_trigger_tau_c_over_tau_k: 0.008
      start_sources_at_tau_c_over_tau_h: 0.006
      l_max_ncdm: 30
      tol_ncdm_synchronous: 1.e-6
  ```

  ],
  kind: image,
  caption: [
    Baseline settings used for `class` theory calculations, updating the default assumptions of the public `class` version. In this work, we use a version of the code that has been updated to implement the latest `HMcode-2020` model for the non-linear power spectrum, provided by J.~Lesgourgues (developed from `class v3.2.2`).
  ]
)
<snip:class_accuracy>

// [figvision-cn] imgs/fig49.png
// 这是一张6×6的参数后验分布三角图（corner plot），用于比
// 较三种计算透镜化宇宙微波背景理论功率谱的方法对基线宇宙
// 学参数后验分布的影响。图中包含6个自由参数：H₀、Ω_b h²、
// Ω_c h²、log(10¹⁰A_s)、n_s、τ_reio。对角线上为各参数的
// 一维边缘后验概率密度曲线，非对角线为两两参数的二维联合
// 后验分布等高线。右上角图例标明：蓝色对应ACT ΛCDM (CAMB
// )，橙色对应ACT ΛCDM (CLASS)，绿色对应ACT ΛCDM (
// Cosmopower)。每格中三条曲线或等高线几乎完全重合，表明
// 三种理论计算方式得到的后验分布高度一致。 对角子图（第1
// 至6行第1至6列）均为曲线图：横轴为对应参数值，纵轴为概
// 率密度（未标数值刻度）。曲线呈近似高斯单峰。H₀峰位约
// 66.5，范围约64–68；Ω_b h²峰位约0.0225，范围约0.0215–
// 0.0235；Ω_c h²峰位约0.125，范围约0.115–0.130；log(10¹⁰
// A_s)峰位约3.05，范围约3.00–3.10；n_s峰位约0.97，范围约
// 0.94–0.99；τ_reio峰位约0.055，范围约0.04–0.07。三条线
// （蓝、橙、绿）在峰顶和尾部均重合。 非对角子图均为等高
// 线图：横轴为列参数，纵轴为行参数，范围与对应一维图一致。
// 每格含两层填充等高线：深绿色内层（约68%置信区间）和浅
// 绿色外层（约95%置信区间），外层边缘可见蓝、橙、绿三色
// 细线几乎完全重叠。各子图趋势如下：第2行第1列（Ω_b h²
// vs H₀）呈正相关椭圆；第3行第1列（Ω_c h² vs H₀）呈强负
// 相关细长椭圆；第3行第2列（Ω_c h² vs Ω_b h²）呈正相关椭
// 圆；第4行第1至3列 [log(10¹⁰A_s) vs H₀、Ω_b h²、Ω_c h²]
// 均呈弱正相关近圆形；第5行第1至4列（n_s vs H₀、Ω_b h²、
// Ω_c h²、log(10¹⁰A_s)）均呈正相关椭圆；第6行第1至5列（τ
// _reio vs 前五个参数）中，τ_reio与H₀、Ω_b h²、Ω_c h²、
// n_s呈弱正相关近圆形，与log(10¹⁰A_s)呈明显正相关斜椭圆。
// 所有二维等高线中三种颜色的轮廓线均高度重合。图中无显微
// 照片、示意图或流程图，无比例尺标注。整体结论：使用camb、
// CosmoPower或class计算透镜化CMB理论时，基线参数后验分布
// 几乎无差异，验证了不同方法的等价性。
#figure(image("imgs/fig49.png"),
  caption: [
    Comparison of baseline $Lambda"CDM"$~parameter posteriors, validating different approaches to compute the lensed CMB theory --- using `camb` (blue), `CosmoPower` (green), or `class` (orange).
  ],
  placement: none,

)
<fig:lcdm_benchmark>

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([#strong[Model]], [#strong[Section]], [#strong[Theory Code]], [#strong[Likelihood]],),
    table.hline(),
    [Running of scalar spectral index], [§@sec:running], [`camb`], [`MFLike`/`ACT-lite`],
    [$P_(cal(R)) ( k )$], [§@sec:pk], [`camb`], [`ACT-lite`],
    [Isocurvature perturbations], [§@sec:isocurvature], [`class`], [`MFLike`],
    [Tensor modes], [§@sec:tensors], [`camb`], [`ACT-lite`],
    [Early dark energy], [§@sec:ede], [`class`/`camb`/], [`MFLike`],
    [], [], [class emulators~@Qu:2024lpx], [],
    [Varying electron mass], [§@sec:var_me], [`class`], [`MFLike`],
    [Varying electron mass and curvature], [§@sec:var_me_ok], [`class`], [`MFLike`],
    [Varying fine-structure constant], [§@sec:var_a], [`class`], [`MFLike`],
    [Varying fine-structure constant and curvature], [§@sec:var_a_ok], [`class`], [`MFLike`],
    [Primordial magnetic fields], [§@sec:pmf], [modified `class`], [`MFLike`],
    [CMB temperature], [§@sec:tcmb], [`class`], [`MFLike`],
    [Modified recombination history], [§@sec:modrec], [modified `class`], [`MFLike`],
    [Neutrino number, $N_("eff")$], [§@sec:neu_n_m], [`camb`/], [`MFLike`/`ACT-lite`],
    [], [], [camb emulators~@Jense_emulators], [],
    [Neutrino mass, $sum m_nu$], [§@sec:neu_n_m], [`camb`/], [`MFLike`/`ACT-lite`],
    [], [], [camb emulators~@Jense_emulators], [],
    [$N_("eff")+sum m_(nu)$], [§@sec:neu_n_m], [`camb`/], [`ACT-lite`],
    [], [], [camb emulators~@Jense_emulators], [],
    [Neutrino self-interactions], [§@sec:neu_si], [modified `camb`], [`MFLike`],
    [Helium and deuterium], [§@sec:bbn], [`camb`], [`MFLike`/`ACT-lite`],
    [Axion-like particles], [§@sec:axions], [modified `camb`/], [`ACT-lite`],
    [], [], [camb emulators], [],
    [DM-baryon interactions], [§@sec:dm-b], [modified `class`], [`MFLike`],
    [DM annihilation], [§@sec:dm-ann], [`class`], [`MFLike`],
    [Self-interacting DR], [§@sec:si_dr], [`class`], [`MFLike`],
    [Interacting DR-DM], [§@sec:i_dr_dm], [`class`], [`MFLike`],
    [Spatial curvature], [§@sec:curv], [`camb`], [`MFLike`/`ACT-lite`],
    [Dark energy equation of state, $w$], [§@sec:de], [`camb`], [`MFLike`/`ACT-lite`],
    [Dark energy equation of state, $w_0 / w_(upright("a"))$], [§@sec:de], [`camb`], [`MFLike`],
    [Interacting DE-DM], [§@sec:dedm], [modified `class`], [`MFLike`],
    [Modified gravity], [§@sec:mg], [modified `camb`], [`MFLike`],
  )]
  , caption: [Summary of models explored in this paper. For each case, we list the Einstein-Boltzmann code and likelihood that are used for each model, noting when chains have been run with more than one code (for robustness tests and reproducibility). The likelihood codes and the baseline $Lambda$CDM results are presented in L25.]
  , kind: table, placement: none
  )
<tab:models>

= ACT DR6 versus DR4 cosmology
<app:dr4dr6comp>
// [figvision-cn] imgs/fig50.png
// 这是一张由四个纵向排列的子图组成的参数约束对比图，所有
// 子图共享相同的横轴类别。每个子图均为带误差棒的散点图，
// 用于展示不同数据集对宇宙学参数的后验均值及置信区间。
// 整体布局与共同元素：横轴为离散的数据集标签，从左至右依
// 次为：DR6、DR4、DR4+WMAP、DR4 (l_TT > 2000)、DR4 (l_TE
// > 2000)、DR4 (l_EE > 2000)。所有子图中，DR6 数据点用蓝
// 色圆点表示，并伴随一条蓝色水平实线及浅蓝色水平阴影带，
// 代表 DR6 的中心值与误差范围；其余数据集用不同颜色的圆
// 点表示，并伴随一条灰色水平实线及浅灰色水平阴影带，代表
// 对比基准（通常为 DR4+WMAP 的结果）。每个数据点均带有垂
// 直误差棒，表示 1σ 置信区间。图中无图例，颜色与横轴标签
// 一一对应。 子图 a（最上方）：纵轴为 Ω_b h²，刻度范围约
// 0.0212 至 0.0227，主刻度为 0.0215、0.0220、0.0225。DR6
// （蓝色）中心值约 0.02255，误差棒约 ±0.0001，蓝色水平线
// 位于 0.02255，浅蓝带覆盖约 0.02245 至 0.02265。DR4（灰
// 色）中心值约 0.02155，误差棒约 ±0.00025。DR4+WMAP（橙
// 色）中心值约 0.0224，误差棒约 ±0.0001。DR4 (l_TT >
// 2000)（黄色）中心值约 0.0216，误差棒约 ±0.0003。DR4 (
// l_TE > 2000)（深蓝色）中心值约 0.0219，误差棒约 ±
// 0.0005。DR4 (l_EE > 2000)（棕色）中心值约 0.02155，误
// 差棒约 ±0.0002。灰色水平线位于约 0.02175，浅灰带覆盖约
// 0.0214 至 0.0221。趋势：DR6 的 Ω_b h² 估计值高于 DR4
// 和 DR4 (l_TT > 2000)，与 DR4+WMAP 接近，且误差更小。
// 子图 b：纵轴为 Ω_c h²，刻度范围约 0.105 至 0.128，主刻
// 度为 0.11、0.12。DR6（蓝色）中心值约 0.1235，误差棒约
// ±0.0015，蓝色水平线位于 0.1235，浅蓝带覆盖约 0.122 至
// 0.125。DR4（灰色）中心值约 0.1175，误差棒约 ±0.003。
// DR4+WMAP（橙色）中心值约 0.120，误差棒约 ±0.002。DR4 (
// l_TT > 2000)（黄色）中心值约 0.114，误差棒约 ±0.004。
// DR4 (l_TE > 2000)（深蓝色）中心值约 0.113，误差棒约 ±
// 0.005。DR4 (l_EE > 2000)（棕色）中心值约 0.1225，误差
// 棒约 ±0.004。灰色水平线位于约 0.118，浅灰带覆盖约
// 0.114 至 0.122。趋势：DR6 的 Ω_c h² 估计值最高，与 DR4
// +WMAP 和 DR4 (l_EE > 2000) 接近，明显高于 DR4 和基于
// TE/TT 的 DR4 结果。 子图 c：纵轴为 θ_MC，刻度范围约
// 0.010405 至 0.010435，主刻度为 0.01041、0.01042、
// 0.01043。DR6（蓝色）中心值约 0.010407，误差棒约 ±
// 0.000002，蓝色水平线位于 0.010407，浅蓝带覆盖约
// 0.010405 至 0.010409。DR4（灰色）中心值约 0.010422，误
// 差棒约 ±0.000006。DR4+WMAP（橙色）中心值约 0.010417，
// 误差棒约 ±0.000004。DR4 (l_TT > 2000)（黄色）中心值约
// 0.010425，误差棒约 ±0.000005。DR4 (l_TE > 2000)（深蓝
// 色）中心值约 0.010413，误差棒约 ±0.000006。DR4 (l_EE >
// 2000)（棕色）中心值约 0.010423，误差棒约 ±0.000004。灰
// 色水平线位于约 0.010422，浅灰带覆盖约 0.010416 至
// 0.010428。趋势：DR6 的 θ_MC 估计值显著低于所有其他数据
// 集，且误差棒最小，与灰色基准带无重叠。 子图 d（最下方）：
// 纵轴为 n_s，刻度范围约 0.960 至 1.030，主刻度为 0.975、
// 1.000、1.025。DR6（蓝色）中心值约 0.968，误差棒约 ±
// 0.005，蓝色水平线位于 0.968，浅蓝带覆盖约 0.963 至
// 0.973。DR4（灰色）中心值约 1.005，误差棒约 ±0.015。DR4
// +WMAP（橙色）中心值约 0.972，误差棒约 ±0.006。DR4 (
// l_TT > 2000)（黄色）中心值约 1.000，误差棒约 ±0.017。
// DR4 (l_TE > 2000)（深蓝色）中心值约 1.001，误差棒约 ±
// 0.015。DR4 (l_EE > 2000)（棕色）中心值约 1.005，误差棒
// 约 ±0.013。灰色水平线位于约 1.003，浅灰带覆盖约 0.990
// 至 1.016。趋势：DR6 的 n_s 估计值最低，与 DR4+WMAP 接
// 近，明显低于 DR4 系列和灰色基准带。 总结：该图通过四个
// 参数（Ω_b h²、Ω_c h²、θ_MC、n_s）的对比，表明 DR6 的估
// 计值与 DR4+WMAP 约束总体一致，但 DR6 的误差普遍更小，
// 且在 θ_MC 和 n_s 上表现出与 DR4 系列不同的中心值偏移。
// 所有子图均无网格线，背景为白色。
#figure(
  image("imgs/fig50.png", width: 48%),
  caption: [Comparison of $Lambda"CDM"$ parameters (mean and $1 sigma$ error) estimated from different ACT datasets. The DR6 constraints (blue) are compared with various DR4 results from both ACT alone and ACT + #emph[WMAP],~#cite(<Choi2020>)#cite(<Aiola2020>). In all cases we are combining with a measurement of the optical depth to reionization from #emph[Planck] `Sroll2`. The DR6 estimates are in good agreement with the DR4 + #emph[WMAP] constraints, which comprised the baseline result presented in~#cite(<Aiola2020>), but differ from the ACT-alone DR4 cosmology at $gt 2.8 sigma$, with $Omega_b h^2$ driving most of this difference. The two datasets can be reconciled by discarding the DR4 TE measurements at $ell lt 2000$, which could be impacted by beam modeling.],
) <fig:whisker_cosmology_dr4dr6>
Here we compare results for the baseline $Lambda"CDM"$~model derived in L25 from the DR6 maps with those from DR4 presented in~@Choi2020#cite(<Aiola2020>). Figure~#ref(<fig:whisker_cosmology_dr4dr6>, supplement: none) shows the subset of $Lambda"CDM"$~cosmological parameters measured by ACT for DR6 (L25) and DR4~@Choi2020, with the latter explored also in combination with #emph[Planck] and for different subsets of the data. Considering the 4-dimensional space of these parameters, we find that the DR6 and DR4 ACT-alone parameters differ at the 2.8$sigma$ level if we ignore correlations between the two datasets. This is therefore a lower limit on the difference if covariance were included. In particular, we find that the DR6 measurement of $Omega_b h^2$ shifts upwards by $3 sigma$ compared to DR4. When ACT DR4 is combined with large-scale modes from #emph[WMAP], which was the nominal combination in @Aiola2020, we find that DR6 agrees with the DR4 + #emph[WMAP] $Lambda"CDM"$~best-fit model to within $1 sigma$.#footnote[Comparison of EDE constraints from DR4 and DR6 can be found in Appendix~@app:ede_full_constraints.]

In terms of understanding the difference between the cosmology preferred by ACT-alone for DR4 and the best-fit model for DR6 (or DR4 + #emph[WMAP]), we note that #cite(<Aiola2020>, form: "prose") found that an artificial 5% re-calibration of TE compared to TT (dividing the DR4 TE bandpowers by 1.05) would bring the ACT-alone DR4 parameters into better agreement with DR4 + #emph[WMAP] or #emph[Planck]. This re-calibration had the effect of moving parameters along the degeneracy direction for $Omega_b h^2 - n_s$ (see Fig.~14 of~#cite(<Aiola2020>, style: "aas_noparen.csl")). In comparing CMB power spectra for DR4 and DR6, shown in Fig.~#ref(<fig:residuals_te_omegabns_dr4dr6>, supplement: none), we find good agreement in TT and EE, and note that the TE residuals at $ell < 2000$ with respect to the DR6 best-fit $Lambda"CDM"$~model are predominantly negative, indicating less power in the DR4 spectra compared to DR6. The DR6 TE spectra are more consistent with the model preferred by DR4 + #emph[WMAP] and #emph[Planck]. Although we have not re-analyzed the DR4 data at this stage, we speculate that our improved modeling of temperature-to-polarization leakage between DR4 and DR6 could impact the TE measurement. During the DR6 beam calibration analysis, we determined that the DR4 leakage estimation method was insensitive to low-$ell$ ($ell < 2000$) leakage. Given that in DR6 we find significant leakage at these large angular scales, we have reason to speculate that the $ell < 2000$ leakage in DR4 could have been underestimated, both in central value and in uncertainty. A rough estimate suggests that the $Delta D_ell^("TE")$ from underestimating the leakage has an RMS value between $2$ and $4$~$mu$K$""^2$ for $350 < ell < 1000$ and between $0.2$ and $0.3$~$mu$K$""^2$ for $1000 < ell < 2000$ --- more details are given in~Duivenvoorden et al. in prep. These numbers are estimated from the difference between the nominal DR6 leakage estimate and an estimate made using the DR4 leakage estimation method. Other factors that might have contributed to a difference in TE between DR6 and DR4 are improvements in the map-making procedure (see N25): in DR6 we have not subtracted an estimate of the pickup (due to the ground and potential other sources) during map-making and we have upgraded to a pointing matrix that uses bilinear interpolation instead of nearest-neighbor interpolation. Although it is not understood how these two changes could influence the TE spectrum, it has not been verified that these upgrades would leave the DR4 TE spectrum unchanged. Figure~#ref(<fig:whisker_cosmology_dr4dr6>, supplement: none) and the bottom right panel of Fig.~#ref(<fig:residuals_te_omegabns_dr4dr6>, supplement: none) also show that simply removing data in TE at $ell < 2000$ moves the DR4 limits into closer agreement with DR6. Cutting TT or EE at $ell < 2000$ (Fig.~#ref(<fig:whisker_cosmology_dr4dr6>, supplement: none)) does not yield the same agreement, expanding parameter degeneracies in different directions. This exploration of TT and EE subsets also tests other aspects noted in the DR4 analyses, including the impact of the DR4 lack of power in TT and the $ell < 1000$ region in EE where some deviations from $Lambda"CDM"$~(e.g., early dark energy and self-interacting neutrinos) were moderately preferred.

This assessment has been done assuming that the underlying model is $Lambda"CDM"$; we do not rule out the possibility that the difference between DR4 and DR6 is due to the true model not being $Lambda"CDM"$, as the two datasets do not fully overlap in angular scale, with DR4 having more statistical weight at smaller angular scales than DR6.

// [figvision-cn] imgs/fig51a.png
// 该图由上下两个面板组成，展示的是宇宙微波背景辐射 TT 功
// 率谱的数据与模型对比。上下两图共享横轴，横轴名称为 ℓ（
// 多极矩），范围约 300 至 2500，刻度标有 500、750、1000、
// 1250、1500、1750、2000、2250。 上图纵轴名称为 D_ℓ^TT [
// μK²]，范围从 0 到 4000，刻度为 0、2000、4000。图中有一
// 条黑色实线，表示 DR6 ΛCDM 最佳拟合模型，该曲线在 ℓ≈300
// 处达到峰值约 4000 μK²，随后在 ℓ≈400 降至约 1800，接着
// 在 ℓ≈800 形成第二个峰约 2500，之后随 ℓ 增大逐渐衰减至
// 接近 0。图中还标注了多种数据点：蓝色圆点表示 DR6 TT 数
// 据，橙色菱形表示 DR4 TT (deep) 数据，红色小圆点表示
// DR4 TT (wide) 数据，所有数据点均带有垂直误差棒。可以看
// 到蓝色点与黑色模型曲线高度吻合。 下图纵轴名称为 ΔD_ℓ^
// TT [μK²]，表示残差，范围约 -250 到 500，刻度为 -200、0、
// 200、400。图中有一条 y=0 的水平黑色实线。数据点颜色与
// 上图含义相同。在 ℓ≈600 处，橙色菱形残差约为 +280 μK²，
// 误差棒很大；在 ℓ≈900 处，橙色残差约为 -130 μK²；在 ℓ≈
// 1000 处，橙色残差约为 -200 μK²；蓝色圆点的残差大多接近
// 0，在 ℓ≈600 处约 +100 μK²。整体上，DR4 TT (deep) 的橙
// 色数据点在低 ℓ 区域呈现较大的正负波动，且误差棒显著大
// 于 DR6 TT 的蓝色数据点。 图例位于上图中上部，包含：黑
// 色实线 “DR6 ΛCDM best-fit”、蓝色圆点 “DR6 TT”、橙色菱
// 形 “DR4 TT (deep)”、红色圆点 “DR4 TT (wide)”。
// [figvision-cn] imgs/fig51b.png
// 这是一个上下排列的双面板图，显示的是宇宙微波背景辐射
// EE 极化功率谱。横轴是共享的，为多极矩 ℓ，范围从约 300
// 到 2500，主刻度标记在 500、750、1000、1250、1500、1750、
// 2000、2250。上方面板的纵轴是 D_ℓ^EE，单位为 μK²，范围
// 从 -10 到 50。下方面板的纵轴是 ΔD_ℓ^EE，单位为 μK²，范
// 围从 -5 到 6。 上方面板图例包含四项：黑色实线表示 DR6
// ΛCDM 最佳拟合；蓝色圆点带误差棒表示 DR6 EE；橙色菱形带
// 误差棒表示 DR4 EE (deep)；红色圆点带误差棒表示 DR4 EE
// (wide)。图中黑色曲线呈现多个峰，峰值分别在 ℓ ≈ 400、
// 700、1000、1300、1600 和 1900 附近，最高峰位于 ℓ ≈
// 1000，D_ℓ^EE 约为 44 μK²。所有数据点均紧随黑色曲线。
// 下方面板显示的是相对于最佳拟合模型的残差，有一条水平零
// 线。橙色菱形和红色圆点的误差棒较大，显示出多个偏离零线
// 的点，尤其在 ℓ ≈ 1000 附近，橙色点高达 6 μK²。蓝色圆点
// 的误差棒相对较小，大多聚集在零线附近。
// [figvision-cn] imgs/fig51c.png
// 图注说明该图比较了 DR6 与 DR4 宇宙微波背景（CMB）功率
// 谱相对于 DR6 最佳拟合模型（L25）的差异，包含左上、右上、
// 左下三个功率谱对比子图以及右下参数空间子图，但当前图片
// 仅展示了左下角的 TE 谱及其残差部分。图片由上下两个共享
// 横轴的子图组成，横轴均为多极矩 ℓ，范围约从 200 到 2500，
// 刻度标注为 500、750、1000、1250、1500、1750、2000、
// 2250。上子图纵轴为 D_ℓ^TE，单位 μK²，范围约从 -180 到
// 120；下子图纵轴为 ΔD_ℓ^TE，单位 μK²，范围约从 -42 到
// 32，并有一条黑色水平零线。上子图图例位于右上角，黑色实
// 线表示 DR6 ΛCDM 最佳拟合模型；蓝色圆点带竖直误差棒表示
// DR6 TE 数据；橙色圆点带误差棒表示 DR4 TE (deep)；红色
// 圆点带误差棒表示 DR4 TE (wide)。上子图中，黑色实线呈现
// TE 功率谱的振荡特征，在 ℓ≈200 处为约 115 μK² 的峰，随
// 后在 ℓ≈320 处降至约 -80 μK² 的谷，ℓ≈550 处回升至约 30
// μK² 的峰，ℓ≈720 处降至约 -130 μK² 的谷，ℓ≈950 处升至约
// 55 μK² 的峰，ℓ≈1150 处降至约 -80 μK² 的谷，ℓ≈1400 处升
// 至约 10 μK² 的峰，之后振幅逐渐衰减趋近于零；蓝色、橙色
// 和红色数据点均围绕该黑线分布，在低 ℓ 区域误差棒较大，
// 高 ℓ 区域误差棒减小。下子图显示各数据点相对于黑线的残
// 差，蓝色 DR6 TE 残差在零线附近波动，ℓ<800 时部分点达 +
// 20 μK² 以上，ℓ>800 后多数在 ±10 μK² 内；橙色 DR4 TE (
// deep) 残差在 ℓ<800 时波动较大，最低约 -27 μK²，最高约
// +29 μK²；红色 DR4 TE (wide) 残差整体偏负，ℓ<1000 时多
// 数点在 -20 到 +8 μK² 之间，ℓ>1500 后集中在零线附近。该
// 图传达的趋势是 DR4 TE 残差在低 ℓ 区域整体偏负，与 DR6
// 宇宙学模型存在一定张力，而 DR6 TE 数据与最佳拟合模型吻
// 合较好。
// [figvision-cn] imgs/fig51c.png
// 图注说明该图比较了 DR6 与 DR4 宇宙微波背景（CMB）功率
// 谱相对于 DR6 最佳拟合模型（L25）的差异，包含左上、右上、
// 左下三个功率谱对比子图以及右下参数空间子图，但当前图片
// 仅展示了左下角的 TE 谱及其残差部分。图片由上下两个共享
// 横轴的子图组成，横轴均为多极矩 ℓ，范围约从 200 到 2500，
// 刻度标注为 500、750、1000、1250、1500、1750、2000、
// 2250。上子图纵轴为 D_ℓ^TE，单位 μK²，范围约从 -180 到
// 120；下子图纵轴为 ΔD_ℓ^TE，单位 μK²，范围约从 -42 到
// 32，并有一条黑色水平零线。上子图图例位于右上角，黑色实
// 线表示 DR6 ΛCDM 最佳拟合模型；蓝色圆点带竖直误差棒表示
// DR6 TE 数据；橙色圆点带误差棒表示 DR4 TE (deep)；红色
// 圆点带误差棒表示 DR4 TE (wide)。上子图中，黑色实线呈现
// TE 功率谱的振荡特征，在 ℓ≈200 处为约 115 μK² 的峰，随
// 后在 ℓ≈320 处降至约 -80 μK² 的谷，ℓ≈550 处回升至约 30
// μK² 的峰，ℓ≈720 处降至约 -130 μK² 的谷，ℓ≈950 处升至约
// 55 μK² 的峰，ℓ≈1150 处降至约 -80 μK² 的谷，ℓ≈1400 处升
// 至约 10 μK² 的峰，之后振幅逐渐衰减趋近于零；蓝色、橙色
// 和红色数据点均围绕该黑线分布，在低 ℓ 区域误差棒较大，
// 高 ℓ 区域误差棒减小。下子图显示各数据点相对于黑线的残
// 差，蓝色 DR6 TE 残差在零线附近波动，ℓ<800 时部分点达 +
// 20 μK² 以上，ℓ>800 后多数在 ±10 μK² 内；橙色 DR4 TE (
// deep) 残差在 ℓ<800 时波动较大，最低约 -27 μK²，最高约
// +29 μK²；红色 DR4 TE (wide) 残差整体偏负，ℓ<1000 时多
// 数点在 -20 到 +8 μK² 之间，ℓ>1500 后集中在零线附近。该
// 图传达的趋势是 DR4 TE 残差在低 ℓ 区域整体偏负，与 DR6
// 宇宙学模型存在一定张力，而 DR6 TE 数据与最佳拟合模型吻
// 合较好。
#figure([#box(image("imgs/fig51a.png", width: 49.5%)) #box(image("imgs/fig51b.png", width: 48.0%)) #box(image("imgs/fig51c.png", width: 57.0%)) #box(image("imgs/fig51d.png", width: 35.0%))

  ],
  caption: [
    Comparison of the DR6 and DR4 CMB power spectra (TT in top left, EE in top right, and TE in bottom left) with respect to the DR6 $Lambda"CDM"$~best-fit model (L25). The DR4 residuals in TE are mostly negative at $ell < 2000$, disfavoring the DR6 $Lambda"CDM"$~cosmology. The bottom right panel shows the $Omega_b h^2 - n_s$ parameter space, which, as shown in~, is very sensitive to the amplitude of the TE spectrum. Discarding the DR4 TE data at $ell < 2000$ brings the DR6 and DR4 contours in closer agreement.
  ],
)
<fig:residuals_te_omegabns_dr4dr6>

= Primordial matter power spectrum compilation
<app:pkcompilation>
// [figvision-cn] imgs/fig51a.png
// 该图由上下两个面板组成，展示的是宇宙微波背景辐射 TT 功
// 率谱的数据与模型对比。上下两图共享横轴，横轴名称为 ℓ（
// 多极矩），范围约 300 至 2500，刻度标有 500、750、1000、
// 1250、1500、1750、2000、2250。 上图纵轴名称为 D_ℓ^TT [
// μK²]，范围从 0 到 4000，刻度为 0、2000、4000。图中有一
// 条黑色实线，表示 DR6 ΛCDM 最佳拟合模型，该曲线在 ℓ≈300
// 处达到峰值约 4000 μK²，随后在 ℓ≈400 降至约 1800，接着
// 在 ℓ≈800 形成第二个峰约 2500，之后随 ℓ 增大逐渐衰减至
// 接近 0。图中还标注了多种数据点：蓝色圆点表示 DR6 TT 数
// 据，橙色菱形表示 DR4 TT (deep) 数据，红色小圆点表示
// DR4 TT (wide) 数据，所有数据点均带有垂直误差棒。可以看
// 到蓝色点与黑色模型曲线高度吻合。 下图纵轴名称为 ΔD_ℓ^
// TT [μK²]，表示残差，范围约 -250 到 500，刻度为 -200、0、
// 200、400。图中有一条 y=0 的水平黑色实线。数据点颜色与
// 上图含义相同。在 ℓ≈600 处，橙色菱形残差约为 +280 μK²，
// 误差棒很大；在 ℓ≈900 处，橙色残差约为 -130 μK²；在 ℓ≈
// 1000 处，橙色残差约为 -200 μK²；蓝色圆点的残差大多接近
// 0，在 ℓ≈600 处约 +100 μK²。整体上，DR4 TT (deep) 的橙
// 色数据点在低 ℓ 区域呈现较大的正负波动，且误差棒显著大
// 于 DR6 TT 的蓝色数据点。 图例位于上图中上部，包含：黑
// 色实线 “DR6 ΛCDM best-fit”、蓝色圆点 “DR6 TT”、橙色菱
// 形 “DR4 TT (deep)”、红色圆点 “DR4 TT (wide)”。
// [figvision-cn] imgs/fig51b.png
// 这是一个上下排列的双面板图，显示的是宇宙微波背景辐射
// EE 极化功率谱。横轴是共享的，为多极矩 ℓ，范围从约 300
// 到 2500，主刻度标记在 500、750、1000、1250、1500、1750、
// 2000、2250。上方面板的纵轴是 D_ℓ^EE，单位为 μK²，范围
// 从 -10 到 50。下方面板的纵轴是 ΔD_ℓ^EE，单位为 μK²，范
// 围从 -5 到 6。 上方面板图例包含四项：黑色实线表示 DR6
// ΛCDM 最佳拟合；蓝色圆点带误差棒表示 DR6 EE；橙色菱形带
// 误差棒表示 DR4 EE (deep)；红色圆点带误差棒表示 DR4 EE
// (wide)。图中黑色曲线呈现多个峰，峰值分别在 ℓ ≈ 400、
// 700、1000、1300、1600 和 1900 附近，最高峰位于 ℓ ≈
// 1000，D_ℓ^EE 约为 44 μK²。所有数据点均紧随黑色曲线。
// 下方面板显示的是相对于最佳拟合模型的残差，有一条水平零
// 线。橙色菱形和红色圆点的误差棒较大，显示出多个偏离零线
// 的点，尤其在 ℓ ≈ 1000 附近，橙色点高达 6 μK²。蓝色圆点
// 的误差棒相对较小，大多聚集在零线附近。
#figure(
  align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header([$k$ $times 10^2$ [Mpc$""^(- 1)$]], [$e^(- 2 tau) P_(cal(R)) ( k )$ Prior Range $times 10^9$],),
    table.hline(),
    [0.01], [0.00 -- 15.0],
    [0.03], [0.10 -- 10.0],
    [0.10], [0.30 -- 9.00],
    [0.32], [0.50 -- 8.00],
    [1.06], [1.40 -- 2.60],
    [1.23], [1.40 -- 2.40],
    [1.43], [1.40 -- 2.40],
    [1.66], [1.60 -- 3.30],
    [1.92], [1.60 -- 2.30],
    [2.23], [1.60 -- 2.20],
    [2.59], [1.60 -- 2.20],
    [3.00], [1.60 -- 2.20],
    [3.48], [1.68 -- 2.14],
    [4.03], [1.75 -- 2.06],
    [4.68], [1.50 -- 2.10],
    [5.42], [1.50 -- 2.10],
    [6.29], [1.80 -- 2.05],
    [7.29], [1.70 -- 2.00],
    [8.45], [1.75 -- 2.00],
    [9.81], [1.76 -- 1.95],
    [11.4], [1.70 -- 2.00],
    [13.2], [1.70 -- 1.93],
    [15.3], [1.65 -- 2.00],
    [17.7], [1.51 -- 2.12],
    [20.6], [1.32 -- 2.30],
    [23.8], [1.04 -- 2.55],
    [27.7], [0 -- 4.26],
    [32.1], [0 -- 10.7],
    [37.2], [0 -- 20.0],
    [43.1], [0 -- 8.46],
  )]
  , caption: [Central-bin wavenumber and prior ranges used for sampling $e^(- 2 tau) P_(cal(R)) ( k )$ for each $k$ bin.]
  , kind: table
  ) <table:binned_priors>

The primordial power spectrum constraints presented in~§@sec:pk are derived sampling the primordial power over 30 bins centered on specific $k$ wavenumbers, with individual flat uninformative priors as summarized in Table~#ref(<table:binned_priors>, supplement: none).

The measurement across bins presented in~§@sec:pk can be mapped onto the linear matter power spectrum through the matter transfer function $cal(T) ( k ) equiv T ( k ) / k^2$ via $ P_m ( k , z = 0 ) & = frac(2 pi^2, k^3) P_(cal(R)) ( k ) #scale(x: 240%, y: 240%)[(] frac(T ( k ), k^2) #scale(x: 240%, y: 240%)[)]^2 k^4\
 & = 2 pi^2 k P_(cal(R)) ( k ) cal(T)^2 ( k ) thin , $ where the dimensionless primordial power is converted to units of Mpc$""^3$ through the $2 pi^2 / k^3$ prefactor (note that $T ( k )$ is dimensionless). As done in previous works, we use this relationship to show the CMB constraints on the primordial power spectrum alongside those from late-time probes such as galaxy surveys @2002PhRvD..66j3508T @2004ApJ...606..702T@2012ApJ...749...90H@Planck_2018_overview#cite(<2019MNRAS.489.2247C>). Our main results for the binned $P_(cal(R)) ( k )$ posterior distributions from P-ACT-LB~(Fig.~#ref(<fig:binned-Pk>, supplement: none)) are projected onto the linear matter power spectrum in Fig.~#ref(<fig:matter-power>, supplement: none). We take the samples from our chains of the binned $P_(cal(R)) ( k )$ analysis using P-ACT-LB~and compute the linear matter power spectrum as a derived parameter in order to account for the uncertainties from the cosmology on the transfer function. From Fig.~#ref(<fig:binned-Pk>, supplement: none) we note that P-ACT~would give similar projections. We also show the P-ACT-LB~best-fit $Lambda$CDM model for both the linear and non-linear matter power spectrum.#footnote[We use the `HMcode-2020`~@Mead2020 dark-matter-only model of the non-linear power spectrum.] Other constraints are shown from the Dark Energy Survey (DES) @2018PhRvD..98d3528T, the Sloan Digital Sky Survey (SDSS) @2010MNRAS.404...60R, the extended Baryon Oscillation Spectroscopic Survey (eBOSS) @2018ApJS..235...42A @2019MNRAS.489.2247C, and the Hubble Space Telescope (HST) measurements of the UV galaxy luminosity function (UV LF) #cite(<2022ApJ...928L..20S>). Note that P-ACT-LB~detects non-zero power at $> 95 %$ CL up to $k = 0.43 med upright("Mpc")^(- 1)$ whereas the -alone constraints cut off at $k = 0.15 med upright("Mpc")^(- 1)$. The bottom panel shows the residuals with respect to the P-ACT-LB~best-fit $Lambda"CDM"$~linear power spectrum. At scales $k > 0.1$~Mpc$""^(- 1)$, neighboring bins are more than 50% correlated. The fact that the highest $k$ bins have mostly positive residuals is precisely why we find a slightly positive best-fit value for the running of the spectral index (in~§@sec:running), although this is not statistically significant.

// [figvision-cn] imgs/fig52.png
// 该图由上下两个共享横轴的面板组成，顶部面板展示物质功率
// 谱随波数的变化，底部面板展示重建结果相对于平滑模型的残
// 差。 顶部面板为双对数坐标曲线图。横轴为波数 k，单位是
// Mpc 的倒数（Mpc⁻¹），范围从 10⁻⁴ 到 10¹。纵轴为线性物
// 质功率谱 P_m(k)，单位是 Mpc³，范围从 10⁰ 到 10⁵。图例
// 位于右上角，包含六项：灰色实线代表 P-ACT-LB ΛCDM 模型，
// 紫色带误差棒的点代表 P-ACT-LB 重建数据，粉色半透明矩形
// 代表 DES Y1 宇宙剪切约束，青色半透明矩形代表 SDSS DR7
// LRG 约束，绿色半透明矩形代表 eBOSS DR14 Ly-α 森林约束，
// 灰色半透明矩形代表 UV 光度函数约束。 图中有一条从左下
// 向右上延伸的灰色实线，在 k 约 0.03 Mpc⁻¹ 处达到峰值（
// 纵轴约 10⁵ Mpc³），随后向右下方下降。紫色数据点紧密跟
// 随该灰色实线，带有垂直误差棒，误差棒在低 k 区间较大，
// 在高 k 区间逐渐减小。灰色虚线（代表使用 HMcode 计算的
// 非线性功率谱）在 k 大于 0.1 Mpc⁻¹ 后开始显著偏离并高于
// 灰色实线。粉色、青色、绿色和灰色的半透明矩形分别位于不
// 同 k 区间，提供各自独立的数据约束区间。图中还有一个内
// 嵌子图，放大了 k 从 4×10⁻² 到 2×10⁻¹ Mpc⁻¹、P_m(k) 从
// 10¹ 到 10³ Mpc³ 的范围。 下方面板为线性坐标曲线图。横
// 轴与上方相同，为 k [Mpc⁻¹]。纵轴为相对残差：(P_m(k) -
// P_m^ΛCDM(k)) / P_m^ΛCDM(k)，范围从 -0.50 到 0.50。图中
// 有一条 y=0 的灰色水平基准线。紫色数据点在 k 从 10⁻⁴ 到
// 10⁻² 范围内散落在 0 线两侧，误差棒较大；在 k 从 10⁻²
// 到 10⁻¹ 范围内，数据点及其误差棒收缩并紧密排列在 0 线
// 附近，显示出极好的一致性；在 k 大于 10⁻¹ 后，数据点误
// 差棒再次变大，并出现偏离。相应的粉色、青色、绿色和灰色
// 半透明矩形在本面板中同样出现，在 k 约 10⁻² 到 10⁻¹ 区
// 间内，这些矩形均覆盖在 0 线附近，与紫色数据点的行为一
// 致。
#figure(image("imgs/fig52.png", width: 80.0%),
  caption: [
    Constraints on the linear matter power spectrum. The P-ACT-LB~best-fit $Lambda"CDM"$~linear matter power spectrum prediction is shown as a solid gray line; the dashed gray line shows the non-linear power spectrum computed from this best-fit $Lambda"CDM"$~model using `HMcode`. The extrapolation shown here includes propagation of the cosmological parameter uncertainties on the transfer function. Our P-ACT-LB~reconstruction of the binned linear $P_(cal(R)) ( k )$, presented in Fig.~#ref(<fig:binned-Pk>, supplement: none) in~§@sec:pk, is shown in purple. The P-ACT~CMB dataset dominates this measurement. Other constraints are shown from DES-Y1 cosmic shear~@2018PhRvD..98d3528T, SDSS luminous red galaxies~@2010MNRAS.404...60R, eBOSS Lyman-$alpha$ forest~@2018ApJS..235...42A @2019MNRAS.489.2247C, and HST measurements of the UV galaxy luminosity function (UV LF) @2022ApJ...928L..20S, as labeled. This plot was made based on code from @2022ApJ...928L..20S and @2019MNRAS.489.2247C. The bottom panel shows the fractional residuals with respect to the P-ACT-LB~best-fit $Lambda"CDM"$~linear power spectrum, with the y-axis optimized to highlight the scales more precisely measured.
  ],
  placement: top,
)
<fig:matter-power>

= Additional constraints on isocurvature
<app:isocurvature_full_constraints>
Table~#ref(<table:isocurvature_constraints>, supplement: none) presents the constraints on isocurvature models. In addition to the constraints on the amplitude of the primordial isocurvature power spectrum at two scales, we present constraints on the isocurvature power spectrum spectral index and the primordial isocurvature fraction, $ beta_(upright("iso")) ( k ) equiv frac(cal(P)_(cal(I) cal(I)) ( k ), cal(P)_(cal(R) cal(R)) ( k ) + cal(P)_(cal(I) cal(I)) ( k )) . $ Overall, we find no evidence of isocurvature perturbations and impose stringent constraints on a range of isocurvature scenarios.

#figure(
  align(center)[#table(
    columns: 6,
    align: (left,center,center,center,center,center,),
    table.header(table.cell(align: center)[Model and dataset], [$med 10^10 P_(cal(I) cal(I))^(( 1 )) med$], [$med 10^10 P_(cal(I) cal(I))^(( 2 )) med$], [$med 100 thin beta_(upright("iso"))^(( 1 )) med$], [$med 100 thin beta_(upright("iso"))^(( 2 )) med$], [$med n_(cal(I) cal(I)) med$],),
    table.hline(),
    [#strong[Uncorrelated:] ($n_(cal(I) cal(I))$=1)], [], [], [], [], [],
    [CDI: Planck], [$< 0.9$], [$< 0.9$], [$< 3.7$], [$< 4.2$], [$1$],
    [CDI: P-ACT], [$< 1.1$], [$< 1.1$], [$< 4.4$], [$< 4.9$], [$1$],
    [CDI: P-ACT-LB], [$< 1.1$], [$< 1.1$], [$< 4.7$], [$< 5.1$], [$1$],
    [NDI: Planck], [$< 2.1$], [$< 2.1$], [$< 8.5$], [$< 9.4$], [$1$],
    [NDI: P-ACT], [$< 1.8$], [$< 1.8$], [$< 7.4$], [$< 8.1$], [$1$],
    [NDI: P-ACT-LB], [$< 1.8$], [$< 1.8$], [$< 7.4$], [$< 8.1$], [$1$],
    [#strong[Uncorrelated:] ( $n_(cal(I) cal(I))$)], [], [], [], [], [],
    [CDI: Planck], [$< 0.5$], [$< 59$], [$< 2.0$], [$41_(- 41)^(+ 34)$], [$2.4_(- 1.2)^(+ 1.1)$],
    [CDI: P-ACT], [$< 0.7$], [$< 26$], [$< 3.1$], [$< 55$], [$2.0_(- 1.0)^(+ 1.1)$],
    [CDI: P-ACT-LB], [$< 0.7$], [$< 26$], [$< 3.1$], [$< 55$], [$2.0_(- 0.9)^(+ 1.1)$],
    [NDI: Planck], [$< 1.5$], [$4.1_(- 4.1)^(+ 3.8)$], [$< 6.3$], [$16_(- 14)^(+ 13)$], [$1.5_(- 0.7)^(+ 0.6)$],
    [NDI: P-ACT], [$< 1.6$], [$< 6.1$], [$< 6.7$], [$< 23$], [$1.6_(- 1.0)^(+ 0.8)$],
    [NDI: P-ACT-LB], [$< 1.7$], [$< 5.5$], [$< 6.9$], [$< 21$], [$1.5 plus.minus 0.9$],
    [#strong[Fully correlated:] ($n_(cal(I) cal(I)) = n_(cal(R) cal(R))$)], [], [], [], [], [],
    [CDI: Planck], [$< 0.028$], [$< 0.025$], [$< 0.12$], [$< 0.12$], [$0.970 plus.minus 0.010$],
    [CDI: P-ACT], [$< 0.025$], [$< 0.023$], [$< 0.11$], [$< 0.11$], [$0.975_(- 0.010)^(+ 0.009)$],
    [CDI: P-ACT-LB], [$< 0.031$], [$< 0.029$], [$< 0.14$], [$< 0.14$], [$0.977_(- 0.010)^(+ 0.007)$],
    [#strong[Fully anti-correlated:] ($n_(cal(I) cal(I)) = n_(cal(R) cal(R))$)], [], [], [], [], [],
    [CDI: Planck], [$< 0.031$], [$< 0.026$], [$< 0.13$], [$< 0.13$], [$0.960 plus.minus 0.010$],
    [CDI: P-ACT], [$< 0.027$], [$< 0.023$], [$< 0.11$], [$< 0.11$], [$0.967_(- 0.010)^(+ 0.008)$],
    [CDI: P-ACT-LB], [$< 0.015$], [$< 0.014$], [$< 0.06$], [$< 0.06$], [$0.972_(- 0.010)^(+ 0.007)$],
  )]
  , caption: [Constraints on isocurvature perturbations for the models and dataset combinations considered in §@sec:isocurvature. We report the one-tailed 95% upper bound for parameters that are not detected; otherwise, we report the two-tailed 95% CL (chosen to facilitate comparison with results from Table 14 of #cite(<Planck2018_inflation>, style: "aas_noparen.csl")).]
  , kind: table
  ) <table:isocurvature_constraints>

= Additional constraints on early dark energy models
<app:ede_full_constraints>
Here we compare the constraints for EDE models with $n = 3$ (our baseline) and $n = 2$. Figure~#ref(<fig:eden2n3>, supplement: none) shows the marginalized posterior comparisons for various dataset combinations, and Table~#ref(<table:ede_n2_n3_full>, supplement: none) provides the numerical constraints. As for $n = 3$, we find no evidence of $n = 2$ EDE. The $n = 3$ model is analyzed using `CosmoPower`-based emulators of `class`, whereas the $n = 2$ model is run using `camb` due to instability of `class` for this model. Note that both `class` and `camb` solve the full perturbed Klein-Gordon equation for the EDE model (in `camb` via the `EarlyQuintessence` module). As a validation, we check that the two codes yield very similar constraints for the $n = 3$ model.

To facilitate comparisons with earlier work, we also compare constraints on the $n = 3$ EDE model from ACT DR4 @Hill_ACT_EDE to those obtained here from ACT DR6, as shown in Fig.~#ref(<fig:ede_dr4_comparison>, supplement: none). We show results for ACT alone (DR6 versus DR4), P-ACT~versus the combination of ACT DR4 with ~2018 TT data up to $ell_(upright("max")) = 650$, and #emph[Planck] versus the combination of ACT DR4 with ~2018 TT data ($ell_(upright("max")) = 650$), ~2018 CMB lensing data, and BAO data from BOSS (and pre-BOSS surveys). We consider results using BOSS BAO data here to ease the DR4-DR6 comparison. Significant portions of parameter space allowed by the DR4 data are excluded by the DR6 data, and the moderate hint of non-zero EDE in DR4 is no longer present in the more-sensitive DR6 dataset (see also Appendix~@app:dr4dr6comp). However, we also see a narrow degeneracy direction in the parameter posteriors (e.g., in the $f_("EDE")$--$Omega_c h^2$ panel) that is difficult to probe. Future experiments, such as the Simons Observatory and CMB-S4, will be needed to fully break this degeneracy and robustly detect or exclude pre-recombination EDE (see, e.g.,~#cite(<2025JCAP...01..033K>, style: "aas_noparen.csl")).

// [figvision-cn] imgs/fig53a.png
// 这是一张4×4的角图（corner plot，即三角图），包含10个参
// 数后验分布子图，其中4个为对角线上的单参数一维边缘概率
// 密度曲线，6个为非对角线上的双参数二维置信区间等高线图。
// 所有子图共享相同的参数轴，用于比较两种模型假设下的参数
// 约束：蓝色代表ACT n=2（图例中用蓝色方块标注“ACT n=2”），
// 红色代表ACT n=3（图例中用红色方块标注“ACT n=3”）。二维
// 等高线图的深色填充区域对应约68%置信区间，浅色填充区域
// 对应约95%置信区间。图中未给出具体的数值表格。 整体坐标
// 轴定义（贯穿所有子图）： 横轴（从左至右）：第一列H₀，
// 单位为km/s/Mpc，横轴范围约63至72，刻度标注为65、70；第
// 二列Ω_ch²，无量纲，横轴范围约0.120至0.138，刻度标注为
// 0.123、0.127、0.131、0.137；第三列S₈，无量纲，横轴范围
// 约0.78至0.92，刻度标注为0.8、0.9；第四列f_EDE，无量纲，
// 横轴范围约0.01至0.16，刻度标注为0.05、0.15。 纵轴（从
// 上至下）：第一行Ω_ch²，纵轴范围约0.115至0.145，刻度标
// 注为0.12、0.13、0.14；第二行S₈，纵轴范围约0.77至0.94，
// 刻度标注为0.8、0.9；第三行f_EDE，纵轴范围约0.01至0.16，
// 刻度标注为0.05、0.10、0.15。所有坐标轴单位均为无量纲，
// 除H₀外。 子图按位置逐项描述如下： 第一行（顶部）： 第
// 一个子图，位于最左上角，为单参数一维概率密度曲线图，横
// 轴为H₀，范围约63至72。图中两条曲线分别为蓝色（ACT n=2）
// 和红色（ACT n=3），呈近似对称的单峰分布，峰值位于H₀约
// 67.5处，曲线在峰值处最陡，两侧尾部较快衰减。蓝色曲线峰
// 值略高于红色曲线，红色曲线在H₀约68至70区间略宽。图中“
// ACT n=3”红色方块和“ACT n=2”蓝色方块图例标注放置在该子
// 图右上方的空白区域。该子图传达的结论是：两种模型对H₀的
// 约束非常接近，均集中在约67–68 km/s/Mpc。 第二个子图（
// 第一行第二列）为单参数一维概率密度曲线图，横轴为Ω_ch²，
// 范围约0.120至0.138。蓝色和红色曲线均呈单峰分布，峰值位
// 于约0.128–0.129处，蓝色曲线峰值略高，红色曲线在右侧尾
// 部略宽，尤其是在Ω_ch²约0.132–0.137区间。该子图传达的结
// 论是：两种模型对Ω_ch²的约束高度一致，均集中在约0.128–
// 0.129。 第三子图（第一行第三列）为单参数一维概率密度曲
// 线图，横轴为S₈，范围约0.78至0.92。蓝色和红色曲线峰值均
// 位于约0.88–0.89处，蓝色曲线峰值略高，红色曲线在低S₈侧
// （约0.82–0.86）略宽。图例标注（红色方块“ACT n=3”、蓝色
// 方块“ACT n=2”）放置在该子图右上方的空白区域。该子图传
// 达的结论是：两种模型对S₈的约束高度一致，均集中在约0.88
// –0.89。 第四子图（第一行第四列，最右侧列）为单参数一维
// 概率密度曲线图，横轴为f_EDE，范围约0.01至0.16。蓝色和
// 红色曲线均呈右偏分布，峰值位于约0.03–0.04处，右侧尾部
// 延伸至约0.15。蓝色曲线在f_EDE约0.03–0.08区间略高于红色
// 曲线，红色曲线在较低f_EDE处略高。图例标注放置在该子图
// 右上方的空白区域。该子图传达的结论是：两种模型对f_EDE
// 的约束均偏向较小值，蓝色模型（ACT n=2）的分布中心略偏
// 向更高值。 第二行（从左至右）： 第一个子图（第二行第一
// 列，位于对角线下方）为二维置信区间等高线图，横轴为H₀，
// 纵轴为Ω_ch²。蓝色和红色等高线均呈向右上方倾斜的椭圆状，
// 中心位于H₀约67.5、Ω_ch²约0.128附近。蓝色等高线轮廓（约
// 68%和95%）与红色高度重叠，但红色轮廓在H₀较低、Ω_ch²较
// 低的一侧（左下侧）略有延伸。该子图传达的结论是：H₀与Ω
// _ch²之间存在轻微正相关，两种模型下的二维约束基本一致。
// 第二个子图（第二行第二列，位于对角线下方）为二维置信区
// 间等高线图，横轴为H₀，纵轴为S₈。蓝色和红色等高线均呈向
// 右下方倾斜的椭圆状，中心位于H₀约67.5、S₈约0.88附近。红
// 色轮廓在S₈较低、H₀较低的一侧略有延伸。该子图传达的结论
// 是：H₀与S₈之间存在负相关，两种模型下的二维约束高度重叠。
// 第三个子图（第二行第三列，位于对角线下方）为二维置信区
// 间等高线图，横轴为H₀，纵轴为f_EDE。蓝色和红色等高线均
// 呈向右上方倾斜的窄长条状，中心位于H₀约67.5、f_EDE约
// 0.05附近，向右上方延伸至f_EDE约0.10、H₀约70。蓝色轮廓
// 在f_EDE较高的一侧略宽。该子图传达的结论是：H₀与f_EDE之
// 间存在正相关，两种模型下的二维约束基本一致。 第三行（
// 从左至右）： 第一个子图（第三行第一列）为二维置信区间
// 等高线图，横轴为Ω_ch²，纵轴为S₈。蓝色和红色等高线均呈
// 向右下方倾斜的椭圆状，中心位于Ω_ch²约0.128、S₈约0.88附
// 近。红色轮廓在S₈较低的一侧略有延伸。该子图传达的结论是：
// Ω_ch²与S₈之间存在负相关，两种模型下的二维约束高度重叠。
// 第二个子图（第三行第二列）为二维置信区间等高线图，横轴
// 为Ω_ch²，纵轴为f_EDE。蓝色和红色等高线均呈向右上方倾斜
// 的窄长条状，中心位于Ω_ch²约0.128、f_EDE约0.05附近。蓝
// 色轮廓在f_EDE较高的一侧略宽。该子图传达的结论是：Ω_ch²
// 与f_EDE之间存在正相关，两种模型下的二维约束基本一致。
// 第三个子图（第三行第三列）为二维置信区间等高线图，横轴
// 为S₈，纵轴为f_EDE。蓝色和红色等高线均呈近似竖直的椭圆
// 状，中心位于S₈约0.88、f_EDE约0.05附近，蓝色轮廓在f_EDE
// 较高的一侧略宽。该子图传达的结论是：S₈与f_EDE之间的相
// 关性较弱，两种模型下的二维约束基本一致。 第四行（最底
// 部一行）： 第一个子图（第四行第一列）为二维置信区间等
// 高线图，横轴为f_EDE，纵轴为Ω_ch²。蓝色和红色等高线均呈
// 向右下方倾斜的椭圆状，中心位于f_EDE约0.05、Ω_ch²约
// 0.128附近。红色轮廓在f_EDE较低、Ω_ch²较高的一侧略有延
// 伸。该子图传达的结论是：f_EDE与Ω_ch²之间存在负相关，两
// 种模型下的二维约束基本一致。 第二个子图（第四行第二列）
// 为二维置信区间等高线图，横轴为S₈，纵轴为Ω_ch²。蓝色和
// 红色等高线均呈向右上方倾斜的椭圆状，中心位于S₈约0.88、
// Ω_ch²约0.128附近。红色轮廓在S₈较低、Ω_ch²较低的一侧略
// 有延伸。该子图传达的结论是：S₈与Ω_ch²之间存在正相关，
// 两种模型下的二维约束基本一致。 第三个子图（第四行第三
// 列，最右下角）为二维置信区间等高线图，横轴为f_EDE，纵
// 轴为S₈。蓝色和红色等高线均呈向右上方倾斜的窄长条状，中
// 心位于f_EDE约0.05、S₈约0.88附近。蓝色轮廓在f_EDE较高的
// 一侧略宽。该子图传达的结论是：f_EDE与S₈之间存在正相关，
// 两种模型下的二维约束基本一致。 综上，整张图通过对比红
// 色（ACT n=3）和蓝色（ACT n=2）两种模型下的后验分布，显
// 示两者在H₀、Ω_ch²、S₈和f_EDE四个参数上的约束高度重叠，
// 仅在f_EDE的尾部以及部分二维置信区间边缘存在细微差异。
// [figvision-cn] imgs/fig53b.png
// 这是一张三角图（corner plot），用于展示四个宇宙学参数
// 的后验概率分布及两两之间的联合置信区间。图中包含五个参
// 数：H0、Ωch2、S8、fEDE。图例位于右上角，标明红色代表
// P-ACT n=3，蓝色代表 P-ACT n=2。对角线上的四个子图为边
// 缘一维概率密度曲线，非对角线上的六个子图为二维联合约束
// 等高线图。 子图类型为边缘一维概率密度曲线，位于对角线
// 位置。横轴分别为 H0（单位 km/s/Mpc，范围 67 至 73）、Ω
// ch2（范围 0.121 至 0.136）、S8（范围 0.80 至 0.90）、
// fEDE（范围 0.05 至 0.15）。纵轴为概率密度（无单位，未
// 标刻度数值）。红色曲线和蓝色曲线分别表示 P-ACT n=3 和
// P-ACT n=2 的一维后验分布。所有曲线均呈单峰近似高斯形状。
// 在 H0 子图中，蓝色曲线的峰值略偏右于红色曲线，蓝色峰值
// 约在 69.5，红色峰值约在 69.0。在 Ωch2 子图中，蓝色峰值
// 约 0.128，红色峰值约 0.129。在 S8 子图中，蓝色峰值约
// 0.845，红色峰值约 0.850。在 fEDE 子图中，蓝色分布呈现
// 明显的双峰结构，主峰在 0.06 附近，次峰在 0.11 附近；红
// 色分布则较为平缓，峰值在 0.10 附近。 子图类型为二维联
// 合约束等高线图。非对角线子图展示参数两两之间的 68% 和
// 95% 置信区间。每个子图中，红色和蓝色分别代表 P-ACT n=3
// 和 P-ACT n=2 的约束结果，深色填充区域为 68% 置信区间，
// 浅色填充区域为 95% 置信区间。 第一行第二列子图：横轴
// H0，纵轴 Ωch2。红色和蓝色等高线均呈向右上方倾斜的椭圆
// 形状，表明 H0 与 Ωch2 存在正相关。蓝色等高线整体位于红
// 色等高线的左下方，蓝色 68% 区域中心约在 (69.5, 0.128)，
// 红色 68% 区域中心约在 (69.0, 0.129)。 第二行第一列子图：
// 横轴 H0，纵轴 S8。等高线呈近似圆形，红色和蓝色区域高度
// 重叠，中心约在 (69.5, 0.85)。 第二行第二列子图：横轴 Ω
// ch2，纵轴 S8。等高线呈向右上方倾斜的椭圆，表明 Ωch2 与
// S8 存在正相关。蓝色 68% 区域中心约在 (0.128, 0.845)，
// 红色 68% 区域中心约在 (0.129, 0.850)。 第三行第一列子
// 图：横轴 H0，纵轴 fEDE。等高线呈细长的向右上方倾斜的椭
// 圆，表明 H0 与 fEDE 存在强正相关。蓝色 68% 区域覆盖 H0
// 约 67.5 至 70.5，fEDE 约 0.02 至 0.12；红色 68% 区域覆
// 盖 H0 约 68.0 至 71.5，fEDE 约 0.04 至 0.14。 第三行第
// 二列子图：横轴 Ωch2，纵轴 fEDE。等高线呈细长的向右上方
// 倾斜的椭圆，表明 Ωch2 与 fEDE 存在强正相关。蓝色 68%
// 区域中心约在 (0.128, 0.07)，红色 68% 区域中心约在 (
// 0.129, 0.09)。 第三行第三列子图：横轴 S8，纵轴 fEDE。
// 等高线呈向右上方倾斜的椭圆，表明 S8 与 fEDE 存在正相关。
// 蓝色 68% 区域覆盖 S8 约 0.83 至 0.87，fEDE 约 0.02 至
// 0.12；红色 68% 区域覆盖 S8 约 0.84 至 0.88，fEDE 约
// 0.04 至 0.14。图中未出现任何文字标注，仅通过颜色和等高
// 线层级区分不同数据集和置信水平。所有子图的坐标轴刻度均
// 向内，且非对角线子图的坐标轴刻度与对角线子图对齐。该图
// 传达的趋势是：P-ACT n=3 与 P-ACT n=2 对四个参数的约束
// 结果总体一致，但在 fEDE 参数上存在显著差异，蓝色（n=2）
// 倾向于更低的 fEDE 值并呈现双峰分布，而红色（n=3）倾向
// 于更高的 fEDE 值且分布更宽；同时，H0、Ωch2、S8 与 fEDE
// 之间均存在正相关关系。
// [figvision-cn] imgs/fig53c.png
// 这是一张科学论文中的三角图（corner plot，也称角图），
// 由10个子图组成，排列成4行4列的左下三角形式（对角线为单
// 参数边缘后验分布，非对角线为两参数联合后验分布）。图中
// 比较了两种模型：红色表示 P-ACT-LB n=3，蓝色表示
// P-ACT-LB n=2。图中展示了四个参数：H0、Ωch2、S8、fEDE。
// 对角线子图（从上到下）： 第1行第1列：曲线图。横轴为 H0，
// 范围约 67 到 75，单位 km/s/Mpc，主刻度标有 69、71、73。
// 纵轴为概率密度（未标数值）。红色曲线峰值约在 H0=70.5，
// 蓝色曲线峰值约在 H0=71.5，蓝色曲线整体位于红色曲线右侧，
// 且蓝色曲线更窄。结论：n=2 模型的 H0 中心值略高且约束更
// 紧。 第2行第2列：曲线图。横轴为 Ωch2，范围约 0.115 到
// 0.140，主刻度标有 0.120、0.135。纵轴为概率密度。红色曲
// 线峰值约在 Ωch2=0.126，蓝色曲线峰值约在 Ωch2=0.128，蓝
// 色曲线位于红色右侧且更窄。结论：n=2 模型的 Ωch2 中心值
// 略高且约束更紧。 第3行第3列：曲线图。横轴为 S8，范围约
// 0.78 到 0.87，主刻度标有 0.80、0.85。纵轴为概率密度。
// 红色与蓝色曲线几乎重合，峰值均约在 S8=0.83，蓝色曲线略
// 窄。结论：两种模型对 S8 的约束几乎一致。 第4行第4列：
// 曲线图。横轴为 fEDE，范围约 0 到 0.16，主刻度标有 0.05、
// 0.15。纵轴为概率密度。红色曲线在 fEDE≈0.03 处有峰值，
// 向高值方向有长尾；蓝色曲线在 fEDE≈0.07 处有峰值，形状
// 更宽。结论：n=2 模型允许更高的 fEDE 中心值。 非对角线
// 子图： 第2行第1列：等高线图。横轴 H0，纵轴 Ωch2（范围
// 0.118 到 0.132，主刻度标有 0.12、0.13）。红色和蓝色均
// 显示两个同心椭圆轮廓（内层深色为 68% 置信区间，外层浅
// 色为 95% 置信区间）。蓝色椭圆位于红色椭圆右上方，且更
// 窄。趋势：H0 与 Ωch2 呈正相关，n=2 模型将参数限制在更
// 高值区域。 第3行第1列：等高线图。横轴 H0，纵轴 S8（范
// 围 0.79 到 0.86，主刻度标有 0.80、0.85）。红色和蓝色椭
// 圆几乎重合，蓝色略小。趋势：H0 与 S8 呈弱正相关，两种
// 模型对 S8 的约束相似。 第4行第1列：等高线图。横轴 H0，
// 纵轴 fEDE（范围 0 到 0.16，主刻度标有 0.05、0.10、0.15）。
// 红色和蓝色均为狭长椭圆，沿对角线方向延伸，蓝色位于红色
// 右上方。趋势：H0 与 fEDE 呈正相关，n=2 模型倾向于更高
// 的 H0 和 fEDE。 第3行第2列：等高线图。横轴 Ωch2，纵轴
// S8。红色和蓝色椭圆几乎重合，蓝色略小。趋势：Ωch2 与 S8
// 呈弱正相关，两种模型对 S8 的约束相似。 第4行第2列：等
// 高线图。横轴 Ωch2，纵轴 fEDE。红色和蓝色均为狭长椭圆，
// 沿对角线方向延伸，蓝色位于红色右上方。趋势：Ωch2 与
// fEDE 呈正相关，n=2 模型倾向于更高的 Ωch2 和 fEDE。 第4
// 行第3列：等高线图。横轴 S8，纵轴 fEDE。红色和蓝色均为
// 椭圆，蓝色位于红色右上方且更宽。趋势：S8 与 fEDE 呈正
// 相关，n=2 模型允许更高的 fEDE 和略高的 S8。 图中所有等
// 高线图均使用红色和蓝色分别表示两种模型，内层深色轮廓为
// 68% 置信区间，外层浅色轮廓为 95% 置信区间。图例位于右
// 上角，红色方块标注 P-ACT-LB n=3，蓝色方块标注 P-ACT-LB
// n=2。图中未显示比例尺或显微成像通道。
// [figvision-cn] imgs/fig53d.png
// 这是一张科学论文中的三角图（corner plot），用于展示四
// 个宇宙学参数的后验概率分布及其两两之间的相关性。图像由
// 多个子图组成，包括对角线上的四个一维边缘概率密度曲线图
// 和下方的六个二维等高线图（置信区间图）。整体布局呈下三
// 角矩阵形式。 全局图例位于图像右上角：红色实心方块代表“
// W-ACT-LB n=3”，蓝色实心方块代表“W-ACT-LB n=2”。所有一
// 维曲线和二维等高线均使用这两种颜色区分这两个数据集。
// 坐标轴定义如下：底行从左至右依次为 H0（单位未标明，范
// 围约 68 至 75，刻度标注 70、75）、Ωch²（范围约 0.115
// 至 0.140，刻度标注 0.121、0.137）、S8（范围约 0.78 至
// 0.87，刻度标注 0.80、0.85）、fEDE（范围约 0 至 0.22，
// 刻度标注 0.05、0.15）。左列从上至下依次为 Ωch²（范围约
// 0.115 至 0.145，刻度标注 0.12、0.13、0.14）、S8（范围
// 约 0.78 至 0.87，刻度标注 0.80、0.85）、fEDE（范围约 0
// 至 0.22，刻度标注 0.1、0.2）。 子图 (a)：左上角一维曲
// 线图。横轴对应 H0，纵轴为概率密度（未标数值）。蓝色曲
// 线（n=2）的峰值位置略高于红色曲线（n=3），蓝色峰值约在
// H0=70.5，红色峰值约在 H0=70.0。两条曲线形状相似，蓝色
// 曲线在右侧尾部略宽。 子图 (b)：第二行第一列二维等高线
// 图。横轴 H0，纵轴 Ωch²。蓝色和红色等高线均呈左上至右下
// 的椭圆形状，显示 H0 与 Ωch² 呈负相关。蓝色椭圆（n=2）
// 整体略偏向右上方，即略高的 H0 和略高的 Ωch²。等高线有
// 两个层级：深色内层（约 68% 置信区间）和浅色外层（约 95%
// 置信区间）。 子图 (c)：第三行第一列二维等高线图。横轴
// H0，纵轴 S8。蓝色和红色等高线均呈较宽的椭圆，显示 H0
// 与 S8 呈轻微负相关。蓝色椭圆中心略偏右，红色椭圆中心略
// 偏左。蓝色外层等高线在 H0 较高一侧延伸更远。 子图 (d)：
// 第四行第一列二维等高线图。横轴 H0，纵轴 fEDE。等高线呈
// 细长的左上至右下椭圆，显示 H0 与 fEDE 呈强负相关。蓝色
// 椭圆整体位于红色椭圆的右上方，即蓝色数据倾向于更高的
// H0 和更高的 fEDE。 子图 (e)：第二行第二列一维曲线图。
// 横轴对应 Ωch²，纵轴为概率密度。蓝色和红色曲线几乎重合，
// 峰值均在 Ωch²≈0.125 附近，蓝色曲线峰值略高且略窄。 子
// 图 (f)：第三行第二列二维等高线图。横轴 Ωch²，纵轴 S8。
// 等高线呈左上至右下椭圆，显示 Ωch² 与 S8 呈负相关。蓝色
// 和红色等高线高度重叠，蓝色椭圆略偏向右下方。 子图 (g)：
// 第四行第二列二维等高线图。横轴 Ωch²，纵轴 fEDE。等高线
// 呈细长的左下至右上椭圆，显示 Ωch² 与 fEDE 呈正相关。蓝
// 色和红色等高线几乎完全重叠，蓝色椭圆略偏向右上方。 子
// 图 (h)：第三行第三列一维曲线图。横轴对应 S8，纵轴为概
// 率密度。蓝色和红色曲线几乎完全重合，峰值均在 S8≈0.83
// 附近。 子图 (i)：第四行第三列二维等高线图。横轴 S8，纵
// 轴 fEDE。等高线呈较宽的左下至右上椭圆，显示 S8 与 fEDE
// 呈正相关。蓝色和红色等高线高度重叠，蓝色椭圆略偏向左下
// 方。 子图 (j)：第四行第四列一维曲线图。横轴对应 fEDE，
// 纵轴为概率密度。蓝色曲线（n=2）的峰值位置略高于红色曲
// 线（n=3），蓝色峰值约在 fEDE=0.06，红色峰值约在 fEDE=
// 0.05。蓝色曲线在低 fEDE 一侧的尾部略厚。 整体趋势：两
// 个数据集（n=2 和 n=3）在 Ωch² 和 S8 上的约束非常接近，
// 但在 H0 和 fEDE 上存在微小差异，蓝色数据（n=2）倾向于
// 略高的 H0 和略高的 fEDE。所有二维等高线均显示参数间的
// 相关性，其中 H0 与 fEDE 呈强负相关，Ωch² 与 fEDE 呈强
// 正相关。
// [figvision-cn] imgs/fig53d.png
// 这是一张科学论文中的三角图（corner plot），用于展示四
// 个宇宙学参数的后验概率分布及其两两之间的相关性。图像由
// 多个子图组成，包括对角线上的四个一维边缘概率密度曲线图
// 和下方的六个二维等高线图（置信区间图）。整体布局呈下三
// 角矩阵形式。 全局图例位于图像右上角：红色实心方块代表“
// W-ACT-LB n=3”，蓝色实心方块代表“W-ACT-LB n=2”。所有一
// 维曲线和二维等高线均使用这两种颜色区分这两个数据集。
// 坐标轴定义如下：底行从左至右依次为 H0（单位未标明，范
// 围约 68 至 75，刻度标注 70、75）、Ωch²（范围约 0.115
// 至 0.140，刻度标注 0.121、0.137）、S8（范围约 0.78 至
// 0.87，刻度标注 0.80、0.85）、fEDE（范围约 0 至 0.22，
// 刻度标注 0.05、0.15）。左列从上至下依次为 Ωch²（范围约
// 0.115 至 0.145，刻度标注 0.12、0.13、0.14）、S8（范围
// 约 0.78 至 0.87，刻度标注 0.80、0.85）、fEDE（范围约 0
// 至 0.22，刻度标注 0.1、0.2）。 子图 (a)：左上角一维曲
// 线图。横轴对应 H0，纵轴为概率密度（未标数值）。蓝色曲
// 线（n=2）的峰值位置略高于红色曲线（n=3），蓝色峰值约在
// H0=70.5，红色峰值约在 H0=70.0。两条曲线形状相似，蓝色
// 曲线在右侧尾部略宽。 子图 (b)：第二行第一列二维等高线
// 图。横轴 H0，纵轴 Ωch²。蓝色和红色等高线均呈左上至右下
// 的椭圆形状，显示 H0 与 Ωch² 呈负相关。蓝色椭圆（n=2）
// 整体略偏向右上方，即略高的 H0 和略高的 Ωch²。等高线有
// 两个层级：深色内层（约 68% 置信区间）和浅色外层（约 95%
// 置信区间）。 子图 (c)：第三行第一列二维等高线图。横轴
// H0，纵轴 S8。蓝色和红色等高线均呈较宽的椭圆，显示 H0
// 与 S8 呈轻微负相关。蓝色椭圆中心略偏右，红色椭圆中心略
// 偏左。蓝色外层等高线在 H0 较高一侧延伸更远。 子图 (d)：
// 第四行第一列二维等高线图。横轴 H0，纵轴 fEDE。等高线呈
// 细长的左上至右下椭圆，显示 H0 与 fEDE 呈强负相关。蓝色
// 椭圆整体位于红色椭圆的右上方，即蓝色数据倾向于更高的
// H0 和更高的 fEDE。 子图 (e)：第二行第二列一维曲线图。
// 横轴对应 Ωch²，纵轴为概率密度。蓝色和红色曲线几乎重合，
// 峰值均在 Ωch²≈0.125 附近，蓝色曲线峰值略高且略窄。 子
// 图 (f)：第三行第二列二维等高线图。横轴 Ωch²，纵轴 S8。
// 等高线呈左上至右下椭圆，显示 Ωch² 与 S8 呈负相关。蓝色
// 和红色等高线高度重叠，蓝色椭圆略偏向右下方。 子图 (g)：
// 第四行第二列二维等高线图。横轴 Ωch²，纵轴 fEDE。等高线
// 呈细长的左下至右上椭圆，显示 Ωch² 与 fEDE 呈正相关。蓝
// 色和红色等高线几乎完全重叠，蓝色椭圆略偏向右上方。 子
// 图 (h)：第三行第三列一维曲线图。横轴对应 S8，纵轴为概
// 率密度。蓝色和红色曲线几乎完全重合，峰值均在 S8≈0.83
// 附近。 子图 (i)：第四行第三列二维等高线图。横轴 S8，纵
// 轴 fEDE。等高线呈较宽的左下至右上椭圆，显示 S8 与 fEDE
// 呈正相关。蓝色和红色等高线高度重叠，蓝色椭圆略偏向左下
// 方。 子图 (j)：第四行第四列一维曲线图。横轴对应 fEDE，
// 纵轴为概率密度。蓝色曲线（n=2）的峰值位置略高于红色曲
// 线（n=3），蓝色峰值约在 fEDE=0.06，红色峰值约在 fEDE=
// 0.05。蓝色曲线在低 fEDE 一侧的尾部略厚。 整体趋势：两
// 个数据集（n=2 和 n=3）在 Ωch² 和 S8 上的约束非常接近，
// 但在 H0 和 fEDE 上存在微小差异，蓝色数据（n=2）倾向于
// 略高的 H0 和略高的 fEDE。所有二维等高线均显示参数间的
// 相关性，其中 H0 与 fEDE 呈强负相关，Ωch² 与 fEDE 呈强
// 正相关。
#figure([#box(image("imgs/fig53a.png", width: 40.0%)) #box(image("imgs/fig53b.png", width: 40.0%)) #box(image("imgs/fig53c.png", width: 40.0%)) #box(image("imgs/fig53d.png", width: 40.0%)) #box(image("imgs/fig53e.png", width: 40.0%))

  ],
  caption: [
    Comparison of constraints from ACT~(top left), P-ACT~(top right), P-ACT-LB~(middle left), W-ACT-LB~(middle right), and ~(bottom) for EDE models with $n = 2$ (blue) and $n = 3$ (red).
  ],
// [figvision-cn] imgs/fig53a.png
// 这是一张4×4的角图（corner plot，即三角图），包含10个参
// 数后验分布子图，其中4个为对角线上的单参数一维边缘概率
// 密度曲线，6个为非对角线上的双参数二维置信区间等高线图。
// 所有子图共享相同的参数轴，用于比较两种模型假设下的参数
// 约束：蓝色代表ACT n=2（图例中用蓝色方块标注“ACT n=2”），
// 红色代表ACT n=3（图例中用红色方块标注“ACT n=3”）。二维
// 等高线图的深色填充区域对应约68%置信区间，浅色填充区域
// 对应约95%置信区间。图中未给出具体的数值表格。 整体坐标
// 轴定义（贯穿所有子图）： 横轴（从左至右）：第一列H₀，
// 单位为km/s/Mpc，横轴范围约63至72，刻度标注为65、70；第
// 二列Ω_ch²，无量纲，横轴范围约0.120至0.138，刻度标注为
// 0.123、0.127、0.131、0.137；第三列S₈，无量纲，横轴范围
// 约0.78至0.92，刻度标注为0.8、0.9；第四列f_EDE，无量纲，
// 横轴范围约0.01至0.16，刻度标注为0.05、0.15。 纵轴（从
// 上至下）：第一行Ω_ch²，纵轴范围约0.115至0.145，刻度标
// 注为0.12、0.13、0.14；第二行S₈，纵轴范围约0.77至0.94，
// 刻度标注为0.8、0.9；第三行f_EDE，纵轴范围约0.01至0.16，
// 刻度标注为0.05、0.10、0.15。所有坐标轴单位均为无量纲，
// 除H₀外。 子图按位置逐项描述如下： 第一行（顶部）： 第
// 一个子图，位于最左上角，为单参数一维概率密度曲线图，横
// 轴为H₀，范围约63至72。图中两条曲线分别为蓝色（ACT n=2）
// 和红色（ACT n=3），呈近似对称的单峰分布，峰值位于H₀约
// 67.5处，曲线在峰值处最陡，两侧尾部较快衰减。蓝色曲线峰
// 值略高于红色曲线，红色曲线在H₀约68至70区间略宽。图中“
// ACT n=3”红色方块和“ACT n=2”蓝色方块图例标注放置在该子
// 图右上方的空白区域。该子图传达的结论是：两种模型对H₀的
// 约束非常接近，均集中在约67–68 km/s/Mpc。 第二个子图（
// 第一行第二列）为单参数一维概率密度曲线图，横轴为Ω_ch²，
// 范围约0.120至0.138。蓝色和红色曲线均呈单峰分布，峰值位
// 于约0.128–0.129处，蓝色曲线峰值略高，红色曲线在右侧尾
// 部略宽，尤其是在Ω_ch²约0.132–0.137区间。该子图传达的结
// 论是：两种模型对Ω_ch²的约束高度一致，均集中在约0.128–
// 0.129。 第三子图（第一行第三列）为单参数一维概率密度曲
// 线图，横轴为S₈，范围约0.78至0.92。蓝色和红色曲线峰值均
// 位于约0.88–0.89处，蓝色曲线峰值略高，红色曲线在低S₈侧
// （约0.82–0.86）略宽。图例标注（红色方块“ACT n=3”、蓝色
// 方块“ACT n=2”）放置在该子图右上方的空白区域。该子图传
// 达的结论是：两种模型对S₈的约束高度一致，均集中在约0.88
// –0.89。 第四子图（第一行第四列，最右侧列）为单参数一维
// 概率密度曲线图，横轴为f_EDE，范围约0.01至0.16。蓝色和
// 红色曲线均呈右偏分布，峰值位于约0.03–0.04处，右侧尾部
// 延伸至约0.15。蓝色曲线在f_EDE约0.03–0.08区间略高于红色
// 曲线，红色曲线在较低f_EDE处略高。图例标注放置在该子图
// 右上方的空白区域。该子图传达的结论是：两种模型对f_EDE
// 的约束均偏向较小值，蓝色模型（ACT n=2）的分布中心略偏
// 向更高值。 第二行（从左至右）： 第一个子图（第二行第一
// 列，位于对角线下方）为二维置信区间等高线图，横轴为H₀，
// 纵轴为Ω_ch²。蓝色和红色等高线均呈向右上方倾斜的椭圆状，
// 中心位于H₀约67.5、Ω_ch²约0.128附近。蓝色等高线轮廓（约
// 68%和95%）与红色高度重叠，但红色轮廓在H₀较低、Ω_ch²较
// 低的一侧（左下侧）略有延伸。该子图传达的结论是：H₀与Ω
// _ch²之间存在轻微正相关，两种模型下的二维约束基本一致。
// 第二个子图（第二行第二列，位于对角线下方）为二维置信区
// 间等高线图，横轴为H₀，纵轴为S₈。蓝色和红色等高线均呈向
// 右下方倾斜的椭圆状，中心位于H₀约67.5、S₈约0.88附近。红
// 色轮廓在S₈较低、H₀较低的一侧略有延伸。该子图传达的结论
// 是：H₀与S₈之间存在负相关，两种模型下的二维约束高度重叠。
// 第三个子图（第二行第三列，位于对角线下方）为二维置信区
// 间等高线图，横轴为H₀，纵轴为f_EDE。蓝色和红色等高线均
// 呈向右上方倾斜的窄长条状，中心位于H₀约67.5、f_EDE约
// 0.05附近，向右上方延伸至f_EDE约0.10、H₀约70。蓝色轮廓
// 在f_EDE较高的一侧略宽。该子图传达的结论是：H₀与f_EDE之
// 间存在正相关，两种模型下的二维约束基本一致。 第三行（
// 从左至右）： 第一个子图（第三行第一列）为二维置信区间
// 等高线图，横轴为Ω_ch²，纵轴为S₈。蓝色和红色等高线均呈
// 向右下方倾斜的椭圆状，中心位于Ω_ch²约0.128、S₈约0.88附
// 近。红色轮廓在S₈较低的一侧略有延伸。该子图传达的结论是：
// Ω_ch²与S₈之间存在负相关，两种模型下的二维约束高度重叠。
// 第二个子图（第三行第二列）为二维置信区间等高线图，横轴
// 为Ω_ch²，纵轴为f_EDE。蓝色和红色等高线均呈向右上方倾斜
// 的窄长条状，中心位于Ω_ch²约0.128、f_EDE约0.05附近。蓝
// 色轮廓在f_EDE较高的一侧略宽。该子图传达的结论是：Ω_ch²
// 与f_EDE之间存在正相关，两种模型下的二维约束基本一致。
// 第三个子图（第三行第三列）为二维置信区间等高线图，横轴
// 为S₈，纵轴为f_EDE。蓝色和红色等高线均呈近似竖直的椭圆
// 状，中心位于S₈约0.88、f_EDE约0.05附近，蓝色轮廓在f_EDE
// 较高的一侧略宽。该子图传达的结论是：S₈与f_EDE之间的相
// 关性较弱，两种模型下的二维约束基本一致。 第四行（最底
// 部一行）： 第一个子图（第四行第一列）为二维置信区间等
// 高线图，横轴为f_EDE，纵轴为Ω_ch²。蓝色和红色等高线均呈
// 向右下方倾斜的椭圆状，中心位于f_EDE约0.05、Ω_ch²约
// 0.128附近。红色轮廓在f_EDE较低、Ω_ch²较高的一侧略有延
// 伸。该子图传达的结论是：f_EDE与Ω_ch²之间存在负相关，两
// 种模型下的二维约束基本一致。 第二个子图（第四行第二列）
// 为二维置信区间等高线图，横轴为S₈，纵轴为Ω_ch²。蓝色和
// 红色等高线均呈向右上方倾斜的椭圆状，中心位于S₈约0.88、
// Ω_ch²约0.128附近。红色轮廓在S₈较低、Ω_ch²较低的一侧略
// 有延伸。该子图传达的结论是：S₈与Ω_ch²之间存在正相关，
// 两种模型下的二维约束基本一致。 第三个子图（第四行第三
// 列，最右下角）为二维置信区间等高线图，横轴为f_EDE，纵
// 轴为S₈。蓝色和红色等高线均呈向右上方倾斜的窄长条状，中
// 心位于f_EDE约0.05、S₈约0.88附近。蓝色轮廓在f_EDE较高的
// 一侧略宽。该子图传达的结论是：f_EDE与S₈之间存在正相关，
// 两种模型下的二维约束基本一致。 综上，整张图通过对比红
// 色（ACT n=3）和蓝色（ACT n=2）两种模型下的后验分布，显
// 示两者在H₀、Ω_ch²、S₈和f_EDE四个参数上的约束高度重叠，
// 仅在f_EDE的尾部以及部分二维置信区间边缘存在细微差异。
// [figvision-cn] imgs/fig53b.png
// 这是一张三角图（corner plot），用于展示四个宇宙学参数
// 的后验概率分布及两两之间的联合置信区间。图中包含五个参
// 数：H0、Ωch2、S8、fEDE。图例位于右上角，标明红色代表
// P-ACT n=3，蓝色代表 P-ACT n=2。对角线上的四个子图为边
// 缘一维概率密度曲线，非对角线上的六个子图为二维联合约束
// 等高线图。 子图类型为边缘一维概率密度曲线，位于对角线
// 位置。横轴分别为 H0（单位 km/s/Mpc，范围 67 至 73）、Ω
// ch2（范围 0.121 至 0.136）、S8（范围 0.80 至 0.90）、
// fEDE（范围 0.05 至 0.15）。纵轴为概率密度（无单位，未
// 标刻度数值）。红色曲线和蓝色曲线分别表示 P-ACT n=3 和
// P-ACT n=2 的一维后验分布。所有曲线均呈单峰近似高斯形状。
// 在 H0 子图中，蓝色曲线的峰值略偏右于红色曲线，蓝色峰值
// 约在 69.5，红色峰值约在 69.0。在 Ωch2 子图中，蓝色峰值
// 约 0.128，红色峰值约 0.129。在 S8 子图中，蓝色峰值约
// 0.845，红色峰值约 0.850。在 fEDE 子图中，蓝色分布呈现
// 明显的双峰结构，主峰在 0.06 附近，次峰在 0.11 附近；红
// 色分布则较为平缓，峰值在 0.10 附近。 子图类型为二维联
// 合约束等高线图。非对角线子图展示参数两两之间的 68% 和
// 95% 置信区间。每个子图中，红色和蓝色分别代表 P-ACT n=3
// 和 P-ACT n=2 的约束结果，深色填充区域为 68% 置信区间，
// 浅色填充区域为 95% 置信区间。 第一行第二列子图：横轴
// H0，纵轴 Ωch2。红色和蓝色等高线均呈向右上方倾斜的椭圆
// 形状，表明 H0 与 Ωch2 存在正相关。蓝色等高线整体位于红
// 色等高线的左下方，蓝色 68% 区域中心约在 (69.5, 0.128)，
// 红色 68% 区域中心约在 (69.0, 0.129)。 第二行第一列子图：
// 横轴 H0，纵轴 S8。等高线呈近似圆形，红色和蓝色区域高度
// 重叠，中心约在 (69.5, 0.85)。 第二行第二列子图：横轴 Ω
// ch2，纵轴 S8。等高线呈向右上方倾斜的椭圆，表明 Ωch2 与
// S8 存在正相关。蓝色 68% 区域中心约在 (0.128, 0.845)，
// 红色 68% 区域中心约在 (0.129, 0.850)。 第三行第一列子
// 图：横轴 H0，纵轴 fEDE。等高线呈细长的向右上方倾斜的椭
// 圆，表明 H0 与 fEDE 存在强正相关。蓝色 68% 区域覆盖 H0
// 约 67.5 至 70.5，fEDE 约 0.02 至 0.12；红色 68% 区域覆
// 盖 H0 约 68.0 至 71.5，fEDE 约 0.04 至 0.14。 第三行第
// 二列子图：横轴 Ωch2，纵轴 fEDE。等高线呈细长的向右上方
// 倾斜的椭圆，表明 Ωch2 与 fEDE 存在强正相关。蓝色 68%
// 区域中心约在 (0.128, 0.07)，红色 68% 区域中心约在 (
// 0.129, 0.09)。 第三行第三列子图：横轴 S8，纵轴 fEDE。
// 等高线呈向右上方倾斜的椭圆，表明 S8 与 fEDE 存在正相关。
// 蓝色 68% 区域覆盖 S8 约 0.83 至 0.87，fEDE 约 0.02 至
// 0.12；红色 68% 区域覆盖 S8 约 0.84 至 0.88，fEDE 约
// 0.04 至 0.14。图中未出现任何文字标注，仅通过颜色和等高
// 线层级区分不同数据集和置信水平。所有子图的坐标轴刻度均
// 向内，且非对角线子图的坐标轴刻度与对角线子图对齐。该图
// 传达的趋势是：P-ACT n=3 与 P-ACT n=2 对四个参数的约束
// 结果总体一致，但在 fEDE 参数上存在显著差异，蓝色（n=2）
// 倾向于更低的 fEDE 值并呈现双峰分布，而红色（n=3）倾向
// 于更高的 fEDE 值且分布更宽；同时，H0、Ωch2、S8 与 fEDE
// 之间均存在正相关关系。
// [figvision-cn] imgs/fig53c.png
// 这是一张科学论文中的三角图（corner plot，也称角图），
// 由10个子图组成，排列成4行4列的左下三角形式（对角线为单
// 参数边缘后验分布，非对角线为两参数联合后验分布）。图中
// 比较了两种模型：红色表示 P-ACT-LB n=3，蓝色表示
// P-ACT-LB n=2。图中展示了四个参数：H0、Ωch2、S8、fEDE。
// 对角线子图（从上到下）： 第1行第1列：曲线图。横轴为 H0，
// 范围约 67 到 75，单位 km/s/Mpc，主刻度标有 69、71、73。
// 纵轴为概率密度（未标数值）。红色曲线峰值约在 H0=70.5，
// 蓝色曲线峰值约在 H0=71.5，蓝色曲线整体位于红色曲线右侧，
// 且蓝色曲线更窄。结论：n=2 模型的 H0 中心值略高且约束更
// 紧。 第2行第2列：曲线图。横轴为 Ωch2，范围约 0.115 到
// 0.140，主刻度标有 0.120、0.135。纵轴为概率密度。红色曲
// 线峰值约在 Ωch2=0.126，蓝色曲线峰值约在 Ωch2=0.128，蓝
// 色曲线位于红色右侧且更窄。结论：n=2 模型的 Ωch2 中心值
// 略高且约束更紧。 第3行第3列：曲线图。横轴为 S8，范围约
// 0.78 到 0.87，主刻度标有 0.80、0.85。纵轴为概率密度。
// 红色与蓝色曲线几乎重合，峰值均约在 S8=0.83，蓝色曲线略
// 窄。结论：两种模型对 S8 的约束几乎一致。 第4行第4列：
// 曲线图。横轴为 fEDE，范围约 0 到 0.16，主刻度标有 0.05、
// 0.15。纵轴为概率密度。红色曲线在 fEDE≈0.03 处有峰值，
// 向高值方向有长尾；蓝色曲线在 fEDE≈0.07 处有峰值，形状
// 更宽。结论：n=2 模型允许更高的 fEDE 中心值。 非对角线
// 子图： 第2行第1列：等高线图。横轴 H0，纵轴 Ωch2（范围
// 0.118 到 0.132，主刻度标有 0.12、0.13）。红色和蓝色均
// 显示两个同心椭圆轮廓（内层深色为 68% 置信区间，外层浅
// 色为 95% 置信区间）。蓝色椭圆位于红色椭圆右上方，且更
// 窄。趋势：H0 与 Ωch2 呈正相关，n=2 模型将参数限制在更
// 高值区域。 第3行第1列：等高线图。横轴 H0，纵轴 S8（范
// 围 0.79 到 0.86，主刻度标有 0.80、0.85）。红色和蓝色椭
// 圆几乎重合，蓝色略小。趋势：H0 与 S8 呈弱正相关，两种
// 模型对 S8 的约束相似。 第4行第1列：等高线图。横轴 H0，
// 纵轴 fEDE（范围 0 到 0.16，主刻度标有 0.05、0.10、0.15）。
// 红色和蓝色均为狭长椭圆，沿对角线方向延伸，蓝色位于红色
// 右上方。趋势：H0 与 fEDE 呈正相关，n=2 模型倾向于更高
// 的 H0 和 fEDE。 第3行第2列：等高线图。横轴 Ωch2，纵轴
// S8。红色和蓝色椭圆几乎重合，蓝色略小。趋势：Ωch2 与 S8
// 呈弱正相关，两种模型对 S8 的约束相似。 第4行第2列：等
// 高线图。横轴 Ωch2，纵轴 fEDE。红色和蓝色均为狭长椭圆，
// 沿对角线方向延伸，蓝色位于红色右上方。趋势：Ωch2 与
// fEDE 呈正相关，n=2 模型倾向于更高的 Ωch2 和 fEDE。 第4
// 行第3列：等高线图。横轴 S8，纵轴 fEDE。红色和蓝色均为
// 椭圆，蓝色位于红色右上方且更宽。趋势：S8 与 fEDE 呈正
// 相关，n=2 模型允许更高的 fEDE 和略高的 S8。 图中所有等
// 高线图均使用红色和蓝色分别表示两种模型，内层深色轮廓为
// 68% 置信区间，外层浅色轮廓为 95% 置信区间。图例位于右
// 上角，红色方块标注 P-ACT-LB n=3，蓝色方块标注 P-ACT-LB
// n=2。图中未显示比例尺或显微成像通道。
  placement: none,
)
<fig:eden2n3>

#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    table.header([], [$Delta chi^2$], [Pref. (in $sigma$)], [$H_0^(( E D E ))$], [$f_("EDE")$], [$log_10 z_c$],),
    table.hline(),
    [ACT], [$1.4$], [$0.4$], [$66.4$], [$0.032$], [3.04],
    [P-ACT], [$3.6$], [$1.0$], [$69.0$], [$0.046$], [3.52],
    [P-ACT-LB], [$5.5$], [$1.5$], [$70.3$], [$0.064$], [3.50],
    [W-ACT-LB], [$3.4$], [$1.0$], [$70.1$], [$0.059$], [3.49],
  )]
  , caption: [The $Delta chi^2 = chi_(Lambda "CDM")^2 - chi_("EDE")^2$ from the multifrequency likelihood MAP points for the $n = 2$ EDE model as compared to those found for $Lambda$CDM for each dataset combination, and preference (in units of $sigma$) for EDE using the likelihood-ratio test statistic. The MAP estimates for $H_0$, $f_("EDE")$, and $log_10 z_c$ in the EDE model are also shown. As with the $n = 3$ model, the data show no significant preference for non-zero EDE.]
  , kind: table
  ) <table:ede_chi2_n2>
#figure(
  align(center)[#table(
    columns: 8,
    align: (left,center,center,center,center,center,center,center,),
    table.header(table.cell(align: center)[Dataset], [$Omega_(upright("c")) h^2$], [$Omega_(upright("b")) h^2$], [$ln 10^10 A_s$], [$n_(upright("s"))$], [$H_0$], [$tau$], [$f_("EDE")$],),
    table.hline(),
    [#strong[ACT]], [], [], [], [], [], [], [],
    [$n = 2$], [$0.1272_(- 0.0040)^(+ 0.0026)$], [$0.02259 plus.minus 0.00020$], [$3.061 plus.minus 0.015$], [$0.962_(- 0.012)^(+ 0.020)$], [$67.5_(- 1.5)^(+ 0.9)$], [$0.0574 plus.minus 0.0056$], [$< 0.091$],
    [$n = 3$], [$0.1265_(- 0.0036)^(+ 0.0024)$], [$0.02260 plus.minus 0.00020$], [$3.058 plus.minus 0.015$], [$0.964_(- 0.014)^(+ 0.022)$], [$67.5_(- 1.7)^(+ 0.9)$], [$0.0571 plus.minus 0.0057$], [$< 0.088$],
    [#strong[P-ACT]], [], [], [], [], [], [], [],
    [$n = 2$], [$0.1256_(- 0.0055)^(+ 0.0033)$], [$0.02264_(- 0.00018)^(+ 0.00015)$], [$3.066 plus.minus 0.015$], [$0.9767 plus.minus 0.0059$], [$69.3_(- 1.5)^(+ 1.0)$], [$0.0607_(- 0.0067)^(+ 0.0056)$], [$< 0.11$],
    [$n = 3$], [$0.1251_(- 0.0055)^(+ 0.0031)$], [$0.02267_(- 0.00019)^(+ 0.00017)$], [$3.065 plus.minus 0.015$], [$0.9785_(- 0.0079)^(+ 0.0063)$], [$69.3_(- 1.5)^(+ 0.9)$], [$0.0599_(- 0.0066)^(+ 0.0055)$], [$< 0.12$],
    [#strong[P-ACT-LB]], [], [], [], [], [], [], [],
    [$n = 2$], [$0.1243_(- 0.0053)^(+ 0.0030)$], [$0.02269_(- 0.00017)^(+ 0.00014)$], [$3.070_(- 0.014)^(+ 0.012)$], [$0.9796_(- 0.0055)^(+ 0.0048)$], [$70.1_(- 1.5)^(+ 0.9)$], [$0.0634_(- 0.0068)^(+ 0.0057)$], [$< 0.11$],
    [$n = 3$], [$0.1233_(- 0.0052)^(+ 0.0025)$], [$0.02270_(- 0.00018)^(+ 0.00015)$], [$3.065_(- 0.013)^(+ 0.011)$], [$0.9809_(- 0.0075)^(+ 0.0061)$], [$69.9_(- 1.5)^(+ 0.8)$], [$0.0619_(- 0.0066)^(+ 0.0056)$], [$< 0.12$],
    [#strong[W-ACT-LB]], [], [], [], [], [], [], [],
    [$n = 2$], [$0.1241_(- 0.0056)^(+ 0.0024)$], [$0.02272 plus.minus 0.00018$], [$3.067_(- 0.014)^(+ 0.012)$], [$0.9755 plus.minus 0.0061$], [$69.8_(- 1.6)^(+ 0.8)$], [$0.0630_(- 0.0066)^(+ 0.0057)$], [$< 0.12$],
    [$n = 3$], [$0.1233_(- 0.0050)^(+ 0.0019)$], [$0.02273 plus.minus 0.00019$], [$3.064_(- 0.013)^(+ 0.011)$], [$0.9766_(- 0.0080)^(+ 0.0059)$], [$69.8_(- 1.7)^(+ 0.7)$], [$0.0614_(- 0.0066)^(+ 0.0056)$], [$< 0.12$],
    [#strong[]], [], [], [], [], [], [], [],
    [$n = 2$], [$0.1246_(- 0.0050)^(+ 0.0027)$], [$0.02264_(- 0.00017)^(+ 0.00015)$], [$3.065_(- 0.013)^(+ 0.011)$], [$0.9769_(- 0.0054)^(+ 0.0047)$], [$69.4_(- 1.4)^(+ 0.8)$], [$0.0609_(- 0.0064)^(+ 0.0054)$], [$< 0.11$],
    [$n = 3$], [$0.1233_(- 0.0045)^(+ 0.0021)$], [$0.02265_(- 0.00018)^(+ 0.00015)$], [$3.061_(- 0.012)^(+ 0.011)$], [$0.9777_(- 0.0071)^(+ 0.0053)$], [$69.2_(- 1.3)^(+ 0.7)$], [$0.0600_(- 0.0063)^(+ 0.0052)$], [$< 0.10$],
  )]
  , caption: [Constraints on EDE for $n = 2$ and $n = 3$ models, for various dataset combinations. All numbers are reported as 68% confidence intervals, except $f_("EDE")$, which is given as a 95% upper bound.]
  , kind: table
  ) <table:ede_n2_n3_full>

// [figvision-cn] imgs/fig54a.png
// 这是一张四参数后验概率分布的角图（corner plot），包含
// 四个子图区域，用于比较DR4 ACT（蓝色）与DR6 ACT（棕红色）
// 数据集对宇宙学参数的限制。图中参数为：H0（单位 km/s/
// Mpc，横轴范围约60至90）、Ωch²（范围约0.11至0.17）、S8
// （范围约0.5至1.0）和fEDE（范围约0至0.4）。对角线子图为
// 各参数的一维边缘概率密度曲线，非对角线子图为两两参数的
// 二维置信区间等高线图，深色区域代表68%置信区间，浅色区
// 域代表95%置信区间。 子图 (a)：左上角一维概率密度图，横
// 轴为H0，纵轴为概率密度。蓝色曲线（DR4）峰值约在77，分
// 布较宽（约68-85）；棕红色曲线（DR6）峰值约在69，分布较
// 窄（约66-72）。DR6对H0的限制显著更严格，且中心值向低值
// 偏移。 子图 (b)：顶部中间一维概率密度图，横轴为Ωch²，
// 纵轴为概率密度。蓝色曲线峰值约在0.135，棕红色曲线峰值
// 约在0.130，两者分布宽度相近，但DR6的峰值略低。 子图 (c
// )：右侧顶部一维概率密度图，横轴为S8，纵轴为概率密度。
// 蓝色曲线峰值约在0.82，棕红色曲线峰值约在0.88，DR6分布
// 略窄且中心值偏高。 子图 (d)：最右侧一维概率密度图，横
// 轴为fEDE，纵轴为概率密度。蓝色曲线在fEDE=0附近有主峰，
// 并在约0.25处有一个明显的次峰（双峰分布），表明DR4数据
// 对非零EDE有轻微偏好；棕红色曲线在fEDE=0处呈单峰，且迅
// 速衰减，表明DR6数据与fEDE=0一致，未显示非零EDE的迹象。
// 子图 (e)：第二行第一列二维等高线图，横轴H0，纵轴Ωch²。
// 蓝色68%和95%等高线覆盖较大范围，呈斜向椭圆；棕红色等高
// 线区域显著更小，集中在H0≈69、Ωch²≈0.13附近。DR6对这两
// 个参数的限制更紧，且两者存在正相关。 子图 (f)：第二行
// 第二列二维等高线图，横轴Ωch²，纵轴S8。蓝色区域较大，棕
// 红色区域较小且位于蓝色区域内偏左上位置，显示DR6对Ωch²
// 和S8的限制更严格。 子图 (g)：第二行第三列二维等高线图，
// 横轴S8，纵轴fEDE。蓝色区域在fEDE=0.1-0.2处有延伸，反映
// DR4对非零fEDE的轻微偏好；棕红色区域集中在fEDE=0附近，
// 且S8值较高，表明DR6数据不支持非零fEDE。 子图 (h)：第三
// 行第一列二维等高线图，横轴H0，纵轴fEDE。蓝色区域呈斜向
// 分布，覆盖fEDE=0至0.3；棕红色区域集中在fEDE=0、H0≈69附
// 近，限制更紧。 子图 (i)：第三行第二列二维等高线图，横
// 轴Ωch²，纵轴fEDE。蓝色区域较大，棕红色区域较小且集中在
// fEDE=0附近。 子图 (j)：第三行第三列二维等高线图，横轴
// S8，纵轴fEDE。蓝色区域在fEDE>0处有延伸，棕红色区域集中
// 在fEDE=0附近，且S8值较高。 整体趋势：DR6数据对所有四个
// 参数的限制均比DR4更严格（等高线面积更小、一维分布更窄），
// 且DR6未显示DR4中出现的非零fEDE的轻微迹象，fEDE后验分布
// 与零一致。图例位于右上角，标注“DR4 ACT”（蓝色方块）和“
// DR6 ACT”（棕红色方块）。
// [figvision-cn] imgs/fig54b.png
// 这是一张三角图（corner plot），用于展示四个宇宙学参数
// 的后验概率分布及参数间的相关性。图中包含四个参数：H0（
// 单位 km/s/Mpc，范围约 65-85）、Ωch2（范围约 0.11-0.16）、
// S8（范围约 0.65-0.95）和 fEDE（范围约 0-0.3）。图例位
// 于左上角，蓝色代表“DR4 ACT + Planck 2018 TT (ℓmax =
// 650)”数据集，棕色代表“DR6 P-ACT”数据集。 对角线上的四
// 个子图为一维边缘概率密度曲线图。对于 H0，蓝色曲线峰值
// 约在 76，棕色曲线峰值约在 69，棕色曲线更窄。对于 Ωch2，
// 蓝色和棕色曲线峰值均在 0.13 附近，棕色曲线略窄且峰值稍
// 高。对于 S8，蓝色曲线峰值约在 0.82，棕色曲线峰值约在
// 0.86，棕色曲线更窄。对于 fEDE，蓝色曲线在 0.12 附近有
// 一个明显的峰，而棕色曲线在 0.05 附近有一个峰，且在 0
// 处概率密度较高，棕色曲线整体更窄且更靠近 0。 非对角线
// 上的六个子图为二维等高线图，展示参数两两之间的联合约束。
// 等高线采用填充色表示，深色区域为 68% 置信区间，浅色区
// 域为 95% 置信区间。在 H0 与 Ωch2 的平面中，蓝色轮廓呈
// 倾斜的椭圆，棕色轮廓更小且位于蓝色轮廓的左下方。在 S8
// 与 H0 的平面中，蓝色轮廓呈倾斜椭圆，棕色轮廓更小且位于
// 左上方。在 fEDE 与 H0 的平面中，蓝色轮廓呈倾斜椭圆，棕
// 色轮廓更小且位于左下方。在 S8 与 Ωch2 的平面中，蓝色轮
// 廓呈倾斜椭圆，棕色轮廓更小且位于左上方。在 fEDE 与 Ω
// ch2 的平面中，蓝色轮廓呈倾斜椭圆，棕色轮廓更小且位于左
// 下方。在 fEDE 与 S8 的平面中，蓝色轮廓呈倾斜椭圆，棕色
// 轮廓更小且位于右下方。所有二维图中，棕色等高线区域均显
// 著小于蓝色区域，表明 DR6 P-ACT 数据对参数的限制更严格。
// 此外，棕色轮廓在 fEDE 方向上更靠近 0，与一维图中 fEDE
// 的分布一致，表明 DR6 数据未显示 DR4 数据中出现的非零
// fEDE 迹象。
// [figvision-cn] imgs/fig54b.png
// 这是一张三角图（corner plot），用于展示四个宇宙学参数
// 的后验概率分布及参数间的相关性。图中包含四个参数：H0（
// 单位 km/s/Mpc，范围约 65-85）、Ωch2（范围约 0.11-0.16）、
// S8（范围约 0.65-0.95）和 fEDE（范围约 0-0.3）。图例位
// 于左上角，蓝色代表“DR4 ACT + Planck 2018 TT (ℓmax =
// 650)”数据集，棕色代表“DR6 P-ACT”数据集。 对角线上的四
// 个子图为一维边缘概率密度曲线图。对于 H0，蓝色曲线峰值
// 约在 76，棕色曲线峰值约在 69，棕色曲线更窄。对于 Ωch2，
// 蓝色和棕色曲线峰值均在 0.13 附近，棕色曲线略窄且峰值稍
// 高。对于 S8，蓝色曲线峰值约在 0.82，棕色曲线峰值约在
// 0.86，棕色曲线更窄。对于 fEDE，蓝色曲线在 0.12 附近有
// 一个明显的峰，而棕色曲线在 0.05 附近有一个峰，且在 0
// 处概率密度较高，棕色曲线整体更窄且更靠近 0。 非对角线
// 上的六个子图为二维等高线图，展示参数两两之间的联合约束。
// 等高线采用填充色表示，深色区域为 68% 置信区间，浅色区
// 域为 95% 置信区间。在 H0 与 Ωch2 的平面中，蓝色轮廓呈
// 倾斜的椭圆，棕色轮廓更小且位于蓝色轮廓的左下方。在 S8
// 与 H0 的平面中，蓝色轮廓呈倾斜椭圆，棕色轮廓更小且位于
// 左上方。在 fEDE 与 H0 的平面中，蓝色轮廓呈倾斜椭圆，棕
// 色轮廓更小且位于左下方。在 S8 与 Ωch2 的平面中，蓝色轮
// 廓呈倾斜椭圆，棕色轮廓更小且位于左上方。在 fEDE 与 Ω
// ch2 的平面中，蓝色轮廓呈倾斜椭圆，棕色轮廓更小且位于左
// 下方。在 fEDE 与 S8 的平面中，蓝色轮廓呈倾斜椭圆，棕色
// 轮廓更小且位于右下方。所有二维图中，棕色等高线区域均显
// 著小于蓝色区域，表明 DR6 P-ACT 数据对参数的限制更严格。
// 此外，棕色轮廓在 fEDE 方向上更靠近 0，与一维图中 fEDE
// 的分布一致，表明 DR6 数据未显示 DR4 数据中出现的非零
// fEDE 迹象。
#figure([#box(image("imgs/fig54a.png", width: 40.0%)) #box(image("imgs/fig54b.png", width: 40.0%)) #box(image("imgs/fig54c.png", width: 40.0%))

  ],
  caption: [
    Comparison of constraints on the $n = 3$ EDE model from ACT~(top left), P-ACT~(top right), and ~(bottom) from the DR4 (blue) and DR6 (brown) data. The mild hint of non-zero EDE in DR4~@Hill_ACT_EDE is not seen in the more-sensitive DR6 dataset. Beyond the significantly increased sensitivity, the DR6 dataset also benefits from improved map-making and systematic modeling compared to DR4, resulting in better-understood beams, transfer functions, and leakage corrections (see Appendix~@app:dr4dr6comp for further discussion and details).
  ],
  placement: none,
)
<fig:ede_dr4_comparison>

#pagebreak(weak: true)
= Additional constraints on modified recombination
<app:modrec_full_constraints>
// [figvision-cn] imgs/fig54a.png
// 这是一张四参数后验概率分布的角图（corner plot），包含
// 四个子图区域，用于比较DR4 ACT（蓝色）与DR6 ACT（棕红色）
// 数据集对宇宙学参数的限制。图中参数为：H0（单位 km/s/
// Mpc，横轴范围约60至90）、Ωch²（范围约0.11至0.17）、S8
// （范围约0.5至1.0）和fEDE（范围约0至0.4）。对角线子图为
// 各参数的一维边缘概率密度曲线，非对角线子图为两两参数的
// 二维置信区间等高线图，深色区域代表68%置信区间，浅色区
// 域代表95%置信区间。 子图 (a)：左上角一维概率密度图，横
// 轴为H0，纵轴为概率密度。蓝色曲线（DR4）峰值约在77，分
// 布较宽（约68-85）；棕红色曲线（DR6）峰值约在69，分布较
// 窄（约66-72）。DR6对H0的限制显著更严格，且中心值向低值
// 偏移。 子图 (b)：顶部中间一维概率密度图，横轴为Ωch²，
// 纵轴为概率密度。蓝色曲线峰值约在0.135，棕红色曲线峰值
// 约在0.130，两者分布宽度相近，但DR6的峰值略低。 子图 (c
// )：右侧顶部一维概率密度图，横轴为S8，纵轴为概率密度。
// 蓝色曲线峰值约在0.82，棕红色曲线峰值约在0.88，DR6分布
// 略窄且中心值偏高。 子图 (d)：最右侧一维概率密度图，横
// 轴为fEDE，纵轴为概率密度。蓝色曲线在fEDE=0附近有主峰，
// 并在约0.25处有一个明显的次峰（双峰分布），表明DR4数据
// 对非零EDE有轻微偏好；棕红色曲线在fEDE=0处呈单峰，且迅
// 速衰减，表明DR6数据与fEDE=0一致，未显示非零EDE的迹象。
// 子图 (e)：第二行第一列二维等高线图，横轴H0，纵轴Ωch²。
// 蓝色68%和95%等高线覆盖较大范围，呈斜向椭圆；棕红色等高
// 线区域显著更小，集中在H0≈69、Ωch²≈0.13附近。DR6对这两
// 个参数的限制更紧，且两者存在正相关。 子图 (f)：第二行
// 第二列二维等高线图，横轴Ωch²，纵轴S8。蓝色区域较大，棕
// 红色区域较小且位于蓝色区域内偏左上位置，显示DR6对Ωch²
// 和S8的限制更严格。 子图 (g)：第二行第三列二维等高线图，
// 横轴S8，纵轴fEDE。蓝色区域在fEDE=0.1-0.2处有延伸，反映
// DR4对非零fEDE的轻微偏好；棕红色区域集中在fEDE=0附近，
// 且S8值较高，表明DR6数据不支持非零fEDE。 子图 (h)：第三
// 行第一列二维等高线图，横轴H0，纵轴fEDE。蓝色区域呈斜向
// 分布，覆盖fEDE=0至0.3；棕红色区域集中在fEDE=0、H0≈69附
// 近，限制更紧。 子图 (i)：第三行第二列二维等高线图，横
// 轴Ωch²，纵轴fEDE。蓝色区域较大，棕红色区域较小且集中在
// fEDE=0附近。 子图 (j)：第三行第三列二维等高线图，横轴
// S8，纵轴fEDE。蓝色区域在fEDE>0处有延伸，棕红色区域集中
// 在fEDE=0附近，且S8值较高。 整体趋势：DR6数据对所有四个
// 参数的限制均比DR4更严格（等高线面积更小、一维分布更窄），
// 且DR6未显示DR4中出现的非零fEDE的轻微迹象，fEDE后验分布
// 与零一致。图例位于右上角，标注“DR4 ACT”（蓝色方块）和“
// DR6 ACT”（棕红色方块）。
// 关；q6 与 q7 的联合后验呈正相关倾斜椭圆。填充区域（
// Planck-LB 和 P-ACT-LB）与虚线轮廓（Planck-LBBOSS 和
// P-ACT-LBBOSS）在大多数子图中重叠良好，但 P-ACT 系列（
// 紫色）的轮廓面积明显小于 Planck 系列（橙色），说明 ACT
// 数据的加入显著减小了参数的不确定性。所有二维等高线均未
// 与灰色点线（零点）完全重合，表明这些控制点参数在
// ModRec 场景下偏离标准复合场景。
#figure(image("imgs/fig55.png"),
  caption: [
    Marginalized parameter posteriors for the control points varied in the `ModRec` scenario analyzed in §@sec:modrec. The bottom (top) panels use DESI (BOSS) BAO. The dotted gray lines indicate the standard recombination scenario ($tilde(q)_i = 0$).
  ],
  placement: none,
)
<fig:modrec_control_points>

Figure~#ref(<fig:modrec_control_points>, supplement: none) shows the marginalized parameter posteriors for the control points#footnote[See~@Lynch:2024gmp for the definition of $tilde(q)_i$.] varied in the `ModRec` scenario studied in §@sec:modrec. The lower triangle plot, shown with solid contours, compares the constraints from Planck-LB~(orange) and P-ACT-LB~(purple). The upper triangle plot, shown with dashed contours, compares the constraints from $sans("Planck-LB")_(sans("BOSS"))$ (orange) and ~(purple). Including ACT data significantly improves the constraints on the control points, yielding stringent bounds on the cosmological recombination history, which we find to be consistent with the standard recombination scenario ($tilde(q)_i$=0; dotted gray lines) within 2$sigma$ across all control points analyzed in the `ModRec` model. Note that the control points in neighboring redshift bins can be highly correlated.

#pagebreak(weak: true)
= Impact of DESI DR2 BAO and optical depth measurements.
<app:newDESI_tau>
== DESI DR2
<desi-dr2>
@DESI1_DR2@DESI-DR2 presented new BAO measurements from three years of observations --- DESI DR2, labeled as B$""_(D R 2)$ hereafter --- improving the size of the data sample and parameter sensitivity over the dataset from Year-1 exploited in the main text of this paper. In Fig.~#ref(<fig:desi_dr2_lcdm>, supplement: none), we revisit the consistency of DESI BAO with the best-fit $Lambda"CDM"$~model from #emph[Planck] and from P-ACT. We find that the P-ACT~best-fit model continues to provide an accurate prediction (in fact, even more accurate than for the DESI Year-1 dataset) for these new BAO data and that the joint $Lambda"CDM"$~solution is a good fit to all the datasets. In the same figure, we also compare the $w_0 / w_a$ constraints presented in~§@sec:de with the contours obtained swapping in DESI DR2 for DESI Year-1. We find that the preference for the $w_0 / w_a$ model over $Lambda"CDM"$~remains moderate, at the $2.4 sigma$ level with or without supernovae, i.e., for P-ACT-LB$""_(D R 2)$S and P-ACT-LB$""_(D R 2)$. These results are consistent with what was derived in #cite(<2025arXiv250418464G>). The evidence for evolving dark energy is reduced with P-ACT~compared to combinations of DESI with other CMB likelihoods (i.e., CMB spectra from #emph[Planck] NPIPE, #cite(<rosenberg:2022>, style: "aas_noparen.csl")) because the value of the matter fraction measured by P-ACT~is slightly lower than the value measured by #emph[Planck] alone: $Omega_m = 0.3116 plus.minus 0.0071$ for P-ACT~and $Omega_m = 0.3158 plus.minus 0.0085$ for ~(L25) or $Omega_m = 0.3140 plus.minus 0.0076$ for #emph[Planck] NPIPE~@rosenberg:2022, and thus lies closer to the DESI constraint in $Lambda"CDM"$.

// [figvision-cn] imgs/fig56a.png
// 这是一张分为上下两部分的曲线图，共用同一横轴。 横轴名
// 称为“Redshift (z)”（红移），范围从 0.0 到 2.5，主刻度
// 为 0.0、0.5、1.0、1.5、2.0、2.5。 上半部分纵轴名称为“
// D_V(z)/(r_d z^(2/3))”，范围约从 16.5 到 21.2，主刻度为
// 17、18、19、20、21。 图中有四条线型/符号： 橙色虚线：
// 图例为“Planck prediction (PTE = 1.0%)”，表示 Planck 的
// 预测。 深蓝色虚线：图例为“P-ACT prediction (PTE = 13.1%
// )”，表示 P-ACT 的预测。 浅紫色实线：图例为“
// P-ACT-LB_DR2 fit (PTE = 95.8%)”，表示 P-ACT-LB_DR2 拟
// 合。 带误差棒的紫色实心圆点：图例为“DESI DR2 BAO”，共
// 有 7 个数据点，横坐标约为 0.3、0.5、0.7、0.9、1.3、1.5、
// 2.3，每个点带有垂直误差棒。 橙色和深蓝色虚线在低红移处
// 快速上升，在 z 约 0.9 至 1.0 处达到峰值（纵坐标约 20.9），
// 然后缓慢下降，至 z=2.5 时降至约 17.4。浅紫色实线整体略
// 低于两条虚线预测，在 z 约 0.9 处峰值约 20.7。紫色数据
// 点围绕浅紫色实线波动，但整体趋势一致；其中 z=0.7 处的
// 点明显低于浅紫色拟合线，而 z=1.5 处的点带有一个较长的
// 向上和向下误差棒。 下半部分纵轴名称为“Residuals”（残差），
// 范围从 -0.5 到 0.5，主刻度为 -0.5、0.0、0.5。这里的“残
// 差”指的是各模型预测/拟合值与一个基准的差值。 图中有一
// 条水平实线位于纵坐标 0.0 处，作为基准（对应浅紫色
// P-ACT-LB_DR2 拟合）。 橙色虚线表示的残差在低红移处为正，
// z 约 0.2 处约 0.25，随后逐渐下降，在 z=1.0 后接近 0.1，
// 并在 z=2.5 时降至 0.0 附近。 深蓝色虚线的残差同样在低
// 红移处为正但较小，z 约 0.2 处约 0.12，随后逐渐向 0.0
// 下降，在 z>1.5 后基本贴近 0.0。 橙色和深蓝色虚线在残差
// 图中均高于 0.0 线，说明上半部分图中它们的预测值整体高
// 于浅紫色拟合线。 紫色数据点呈现出相对于 0.0 基准的偏差：
// z≈0.3 残差约为 0.0，z≈0.5 残差约 0.1，z≈0.7 残差约
// -0.3，z≈0.9 残差约 -0.1，z≈1.3 残差约 -0.1，z≈1.5 残差
// 约 0.2（误差棒长，向下至约 -0.1），z≈2.3 残差约 0.1。
// 图中传达的趋势是：P-ACT 预测与 DESI DR2 BAO 数据吻合度
// 较高（PTE=13.1%），而 Planck 预测的 PTE 仅为 1.0%，
// P-ACT-LB_DR2 拟合的 PTE 达到 95.8%，表明该拟合能很好地
// 描述 DESI DR2 数据。
// [figvision-cn] imgs/fig56a.png
// 这是一张分为上下两部分的曲线图，共用同一横轴。 横轴名
// 称为“Redshift (z)”（红移），范围从 0.0 到 2.5，主刻度
// 为 0.0、0.5、1.0、1.5、2.0、2.5。 上半部分纵轴名称为“
// D_V(z)/(r_d z^(2/3))”，范围约从 16.5 到 21.2，主刻度为
// 17、18、19、20、21。 图中有四条线型/符号： 橙色虚线：
// 图例为“Planck prediction (PTE = 1.0%)”，表示 Planck 的
// 预测。 深蓝色虚线：图例为“P-ACT prediction (PTE = 13.1%
// )”，表示 P-ACT 的预测。 浅紫色实线：图例为“
// P-ACT-LB_DR2 fit (PTE = 95.8%)”，表示 P-ACT-LB_DR2 拟
// 合。 带误差棒的紫色实心圆点：图例为“DESI DR2 BAO”，共
// 有 7 个数据点，横坐标约为 0.3、0.5、0.7、0.9、1.3、1.5、
// 2.3，每个点带有垂直误差棒。 橙色和深蓝色虚线在低红移处
// 快速上升，在 z 约 0.9 至 1.0 处达到峰值（纵坐标约 20.9），
// 然后缓慢下降，至 z=2.5 时降至约 17.4。浅紫色实线整体略
// 低于两条虚线预测，在 z 约 0.9 处峰值约 20.7。紫色数据
// 点围绕浅紫色实线波动，但整体趋势一致；其中 z=0.7 处的
// 点明显低于浅紫色拟合线，而 z=1.5 处的点带有一个较长的
// 向上和向下误差棒。 下半部分纵轴名称为“Residuals”（残差），
// 范围从 -0.5 到 0.5，主刻度为 -0.5、0.0、0.5。这里的“残
// 差”指的是各模型预测/拟合值与一个基准的差值。 图中有一
// 条水平实线位于纵坐标 0.0 处，作为基准（对应浅紫色
// P-ACT-LB_DR2 拟合）。 橙色虚线表示的残差在低红移处为正，
// z 约 0.2 处约 0.25，随后逐渐下降，在 z=1.0 后接近 0.1，
// 并在 z=2.5 时降至 0.0 附近。 深蓝色虚线的残差同样在低
// 红移处为正但较小，z 约 0.2 处约 0.12，随后逐渐向 0.0
// 下降，在 z>1.5 后基本贴近 0.0。 橙色和深蓝色虚线在残差
// 图中均高于 0.0 线，说明上半部分图中它们的预测值整体高
// 于浅紫色拟合线。 紫色数据点呈现出相对于 0.0 基准的偏差：
// z≈0.3 残差约为 0.0，z≈0.5 残差约 0.1，z≈0.7 残差约
// -0.3，z≈0.9 残差约 -0.1，z≈1.3 残差约 -0.1，z≈1.5 残差
// 约 0.2（误差棒长，向下至约 -0.1），z≈2.3 残差约 0.1。
// 图中传达的趋势是：P-ACT 预测与 DESI DR2 BAO 数据吻合度
// 较高（PTE=13.1%），而 Planck 预测的 PTE 仅为 1.0%，
// P-ACT-LB_DR2 拟合的 PTE 达到 95.8%，表明该拟合能很好地
// 描述 DESI DR2 数据。
#figure([#box(image("imgs/fig56a.png", width: 48.0%)) #box(image("imgs/fig56b.png", width: 51.0%))

  ],
  caption: [
    #emph[Left]: DESI DR2 BAO measurements combined in seven total data points and compared with CMB $Lambda"CDM"$~predictions (from #emph[Planck] in orange and P-ACT~in navy) and with the joint P-ACT-LB$""_(D R 2)$ fit (light purple), as in Fig.~#ref(<fig:lensing_bao_residuals>, supplement: none). The P-ACT~$Lambda"CDM"$~best-fit model continues to provide good predictions for the DESI DR2 data. #emph[Right]: Comparison of evolving dark energy constraints using one (empty dark purple) or three years (filled light purple) of DESI BAO data, in combination with #emph[Planck], ACT, CMB lensing, and SNIa data (P-ACT-LBS). The evidence for evolving dark energy over $Lambda"CDM"$~remains moderate, shifting from $2.2 sigma$ (one year of DESI BAO) to $2.4 sigma$ (three years of DESI BAO). Relaxing the measurement of the optical depth using a wider prior on $tau$ does not impact these limits: a shift in the central value of $tau$ (as for example measured in the extreme case of removing low-$ell$ polarization data, shown in the green contours) is needed to move the constraints to within $2 sigma$ of $Lambda"CDM"$.
  ],
  placement: none,
)
<fig:desi_dr2_lcdm>

// [figvision-cn] imgs/fig57.png
// 这是一张三角图（corner plot），由7×8个子图矩阵构成：对
// 角线为7个一维边缘后验概率密度曲线，左下三角区为21个二
// 维联合后验概率等高线图，右上三角区为空。所有子图横轴和
// 纵轴分别对应7个控制点参数 q̃₁ 至 q̃₇，各轴刻度范围与单
// 位如下：q̃₁ 为 [-0.0005, 0.0015]（主刻度 -0.0005、0、
// 0.0005、0.001）；q̃₂ 为 [-0.0015, 0.0015]（主刻度
// -0.001、0、0.001）；q̃₃ 为 [-0.012, 0.004]（主刻度
// -0.01、-0.005、0）；q̃₄ 为 [-0.04, 0.02]（主刻度 -0.03、
// -0.02、-0.01、0、0.01）；q̃₅ 为 [-0.15, 0.05]（主刻度
// -0.10、0、0.05）；q̃₆ 为 [-0.2, 0.3]（主刻度 -0.1、0、
// 0.1、0.2）；q̃₇ 为 [-0.5, 0.1]（主刻度 -0.4、-0.2、0、
// 0.1）。图中包含四类数据集或模型组合的后验分布：橙色填
// 充（Planck-LB）、紫色填充（P-ACT-LB）、深蓝色填充（
// P-ACT-LB_DR2）、灰色点线（标准复合场景）。二维图中，橙
// 色、紫色和深蓝色等高线分别表示对应数据集的68%和95%置信
// 区间，灰色点线为参考标准复合场景的精确参数值（q̃₁=0, q
// ̃₂=0, q̃₃=0, q̃₄=0, q̃₅=0, q̃₆=0, q̃₇=0），在图中表现
// 为贯穿对应坐标的垂直和水平虚线。一维图中，曲线为对应数
// 据集的边缘后验概率密度，灰色点线同样标示标准复合场景参
// 数值，曲线峰值位置反映各参数的中心值，曲线宽度反映约束
// 强度。 子图 (a)：左上角一维边缘后验，q̃₁ 的后验密度曲
// 线，橙色峰值在0.0002附近，紫色峰值在0.0001附近，深蓝色
// 峰值在0.00015附近，三者均与灰色点线（0）非常接近，橙色
// 分布最宽，深蓝色最窄。子图 (b)：q̃₁–q̃₂ 二维联合后验，
// 橙色等高线中心在 (0.0002, -0.0002)，紫色和深蓝色中心在
// (0.0001, -0.0002)，三者均与灰色参考线 (0,0) 有微小偏移，
// 置信椭圆沿 q̃₁ 方向拉长。子图 (c)：q̃₂ 的一维边缘后验，
// 橙色峰值在 -0.0002，紫色和深蓝色峰值在 -0.0001，灰色点
// 线为0，橙色分布略宽。子图 (d)：q̃₁–q̃₃ 二维联合后验，
// 橙色中心在 (0.0002, -0.002)，紫色中心在 (0.0001,
// -0.002)，深蓝色中心在 (0.0001, -0.002)，均偏离灰色参考
// 线 (0,0)，置信椭圆沿 q̃₃ 方向拉长。子图 (e)：q̃₂–q̃₃
// 二维联合后验，橙色中心在 (-0.0002, -0.002)，紫色和深蓝
// 色中心在 (-0.0001, -0.002)，均偏离灰色参考线 (0,0)。子
// 图 (f)：q̃₃ 的一维边缘后验，橙色峰值在 -0.002，紫色峰
// 值在 -0.003，深蓝色峰值在 -0.003，灰色点线为0，三者均
// 明显偏离0，橙色分布最宽。子图 (g)：q̃₁–q̃₄ 二维联合后
// 验，橙色中心在 (0.0002, 0.000)，紫色和深蓝色中心在 (
// 0.0001, 0.000)，与灰色参考线 (0,0) 基本一致，置信椭圆
// 较圆。子图 (h)：q̃₂–q̃₄ 二维联合后验，橙色中心在 (
// -0.0002, 0.000)，紫色和深蓝色中心在 (-0.0001, 0.000)，
// 与灰色参考线 (0,0) 一致。子图 (i)：q̃₃–q̃₄ 二维联合后
// 验，橙色中心在 (-0.002, 0.000)，紫色和深蓝色中心在 (
// -0.002, 0.000)，均偏离灰色参考线 (0,0)，置信椭圆沿 q̃₃
// 方向拉长。子图 (j)：q̃₄ 的一维边缘后验，橙色峰值在
// 0.000，紫色峰值在 0.000，深蓝色峰值在 0.000，灰色点线
// 为0，三者均与0一致，橙色分布最宽。子图 (k)：q̃₁–q̃₅ 二
// 维联合后验，橙色中心在 (0.0002, -0.02)，紫色和深蓝色中
// 心在 (0.0001, -0.02)，均偏离灰色参考线 (0,0)，置信椭圆
// 沿 q̃₅ 方向拉长。子图 (l)：q̃₂–q̃₅ 二维联合后验，橙色
// 中心在 (-0.0002, -0.02)，紫色和深蓝色中心在 (-0.0001,
// -0.02)，均偏离灰色参考线 (0,0)。子图 (m)：q̃₃–q̃₅ 二维
// 联合后验，橙色中心在 (-0.002, -0.02)，紫色和深蓝色中心
// 在 (-0.002, -0.02)，均偏离灰色参考线 (0,0)，置信椭圆呈
// 细长条状，沿 q̃₃ 和 q̃₅ 方向均有拉伸。子图 (n)：q̃₄–q̃
// ₅ 二维联合后验，橙色中心在 (0.000, -0.02)，紫色和深蓝
// 色中心在 (0.000, -0.02)，均偏离灰色参考线 (0,0)。子图
// (o)：q̃₅ 的一维边缘后验，橙色峰值在 -0.02，紫色峰值在
// -0.03，深蓝色峰值在 -0.03，灰色点线为0，三者均明显偏离
// 0，橙色分布最宽。子图 (p)：q̃₁–q̃₆ 二维联合后验，橙色
// 中心在 (0.0002, -0.05)，紫色和深蓝色中心在 (0.0001,
// -0.05)，均偏离灰色参考线 (0,0)。子图 (q)：q̃₂–q̃₆ 二维
// 联合后验，橙色中心在 (-0.0002, -0.05)，紫色和深蓝色中
// 心在 (-0.0001, -0.05)，均偏离灰色参考线 (0,0)。子图 (r
// )：q̃₃–q̃₆ 二维联合后验，橙色中心在 (-0.002, -0.05)，
// 紫色和深蓝色中心在 (-0.002, -0.05)，均偏离灰色参考线 (
// 0,0)。子图 (s)：q̃₄–q̃₆ 二维联合后验，橙色中心在 (
// 0.000, -0.05)，紫色和深蓝色中心在 (0.000, -0.05)，均偏
// 离灰色参考线 (0,0)。子图 (t)：q̃₅–q̃₆ 二维联合后验，橙
// 色中心在 (-0.02, -0.05)，紫色和深蓝色中心在 (-0.03,
// -0.05)，均偏离灰色参考线 (0,0)。子图 (u)：q̃₆ 的一维边
// 缘后验，橙色峰值在 -0.05，紫色峰值在 -0.06，深蓝色峰值
// 在 -0.06，灰色点线为0，三者均明显偏离0，橙色分布最宽。
// 子图 (v)：q̃₁–q̃₇ 二维联合后验，橙色中心在 (0.0001,
// -0.2)，紫色和深蓝色中心在 (0.0000, -0.2)，均偏离灰色参
// 考线 (0,0)。子图 (w)：q̃₂–q̃₇ 二维联合后验，橙色中心在
// (-0.0002, -0.2)，紫色和深蓝色中心在 (-0.0001, -0.2)，
// 均偏离灰色参考线 (0,0)。子图 (x)：q̃₃–q̃₇ 二维联合后验，
// 橙色中心在 (-0.002, -0.2)，紫色和深蓝色中心在 (-0.002,
// -0.2)，均偏离灰色参考线 (0,0)。子图 (y)：q̃₄–q̃₇ 二维
// 联合后验，橙色中心在 (0.000, -0.2)，紫色和深蓝色中心在
// (0.000, -0.2)，均偏离灰色参考线 (0,0)。子图 (z)：q̃₅–q
// ̃₇ 二维联合后验，橙色中心在 (-0.02, -0.2)，紫色和深蓝
// 色中心在 (-0.03, -0.2)，均偏离灰色参考线 (0,0)。子图 (
// aa)：q̃₆–q̃₇ 二维联合后验，橙色中心在 (-0.05, -0.2)，
// 紫色和深蓝色中心在 (-0.06, -0.2)，均偏离灰色参考线 (0,
// 0)。子图 (ab)：q̃₇ 的一维边缘后验，橙色峰值在 -0.2，紫
// 色峰值在 -0.1，深蓝色峰值在 -0.1，灰色点线为0，三者均
// 明显偏离0，橙色分布最宽。 整体趋势：所有参数的后验分布
// 均包含标准复合场景值（灰色点线），但多数参数的中心值有
// 微小偏移，且橙色（Planck-LB）约束最弱（分布最宽），深
// 蓝色（P-ACT-LB_DR2）约束最强（分布最窄）；参数 q̃₁ 和
// q̃₄ 的后验与标准值一致性好，而 q̃₂、q̃₃、q̃₅、q̃₆、q̃₇
// 的后验中心均偏离0，尤以 q̃₇ 的偏离最显著（后验中心约
// -0.2 至 -0.1），表明这些控制点在 ModRec 场景下相对于标
// 准复合场景存在系统性偏移。图例位于图表顶部：橙色方块标
// 注 Planck-LB，紫色方块标注 P-ACT-LB，深蓝色方块标注
// P-ACT-LB_DR2。
#figure(image("imgs/fig57.png", width: 70%),
  caption: [
    Marginalized parameter posteriors for the control points varied in the `ModRec` scenario analyzed in §5.5 (as in Fig.~#ref(<fig:modrec_control_points>, supplement: none)) including DESI DR2 BAO (blue). The dotted gray lines indicate the standard recombination scenario ($tilde(q)_i = 0$).
  ],
  placement: none,
)
<fig:modrec_dr2>

// [figvision-cn] imgs/fig58.png
// 这是一张单面板（无子图）的约束曲线图（概率密度曲线图）。
// 横轴名称为“H₀ [km/s/Mpc]”，表示哈勃常数，数值范围从 64
// 至 74，主刻度为 64、66、68、70、72、74。纵轴未显示刻度、
// 标签或单位，通常表示概率密度或相对似然度。 图中包含三
// 组曲线和一个垂直参考线。图例位于左上角，白底边框，包括
// 三个条目：实线橙色代表“Planck-LB”；实线紫色代表“
// P-ACT-LB”；虚线深蓝色代表“P-ACT-LB_DR2”。 图为单峰概率
// 分布曲线。橙色曲线峰值最高，位置约在 H₀ = 70.2 附近，
// 曲线分布范围大致从 65.5 至 73.5。紫色曲线峰值位置约在
// H₀ = 69.6 附近，较橙色曲线左移约 0.6，右侧尾部延伸至约
// 72.8。虚线深蓝色曲线峰值位置进一步左移，约在 H₀ = 69.4
// 附近，且其峰谷形态最窄，右侧尾部在 71.5 处已接近基线。
// 图中有一条垂直灰色点线，位于 H₀ = 68.1 至 68.2 之间（
// 目测约 68.15），贯穿整个绘图区。在该点线左侧，垂直标注
// 了旋转 90 度的灰色文字“ΛCDM”，指示该点线代表 ΛCDM 模型
// 下的参考值。所有曲线在 ΛCDM 参考线位置均处于上升沿或较
// 低概率区域。 趋势与结论：相较于 Plan-LB 和 P-ACT-LB 的
// 重叠区间，P-ACT-LB_DR2（即 DESI DR2 数据加入后）的约束
// 分布整体左移，峰值更靠近 ΛCDM 参考值，并显著收窄了高 H
// ₀ 侧的尾部，表明 DESI DR2 数据对哈勃常数施加了更严格的
// 限制，降低了高 H₀ 值的概率。
#figure(image("imgs/fig58.png"),
  caption: [
    Constraints on the Hubble constant from the `ModRec` analysis as in Fig.~#ref(<fig:modrec_H0>, supplement: none), highlighting the impact of DESI DR2.
  ],
  placement: none,
)
<fig:H0_modrec_dr2>

As an example of the impact of DESI DR2 data on an extended model with new recombination-era physics, here we present updated results for the modified recombination scenario studied in §@sec:modrec. This example is particularly useful due to the sensitivity of the modified recombination constraints to the choice of BAO dataset (see Fig.~#ref(<fig:modrec_Xe_recon>, supplement: none)). Figure~#ref(<fig:modrec_dr2>, supplement: none) shows the marginalized parameter posteriors for the `ModRec` control points with DESI DR2 data (dark blue). The P-ACT-LB$""_(D R 2)$ constraints are consistent with the P-ACT-LB~constraints, as well as the standard recombination scenario. Relative to the DESI Year-1 analysis, the DR2 data yield approximately 10--15% tighter constraints on the control points. Figure~#ref(<fig:H0_modrec_dr2>, supplement: none) shows the marginalized posterior on $H_0$ for the `ModRec` analysis with DESI DR2 data. With the addition of DESI DR2, we find $H_0 = 69.5 plus.minus 0.7 med ( 68 % , sans("P-ACT-LB") )$ which is significantly tighter than the P-ACT-LB~constraint ($69.6 plus.minus 1.0$~km/s/Mpc).

// [figvision-cn] imgs/fig59a.png
// 图中左侧子图为一个二维参数约束图，横轴为标量光谱指数
// n_s，范围从 0.95 到 1.00；纵轴为张量标量比 r，范围从
// 0.00 到 0.10。 图中主要包含四组椭圆形的置信区间区域，
// 用不同颜色填充表示： 蓝色区域代表 ACT-LB-BK18 数据集，
// 其范围较宽且偏向右侧。 橙色区域代表 Planck-LB-BK18 数
// 据集。 紫色区域代表 P-ACT-LB-BK18 数据集，位于中心较窄
// 区域。 绿色空心轮廓线代表 P-ACT-LB_DR2-BK18 数据集，呈
// 现细长椭圆状，位于中心且略微向右下倾斜。 图中还叠加了
// 几条理论预测曲线和线条： 一条黑色实线从左上（r=0.10,
// n_s约0.966）斜向右下延伸至（n_s=1.00, r=0），附近标注
// 有 "Convex" 和 "Concave" 文字。 两条黑色虚线沿实线平行
// 方向延伸，内部夹着一条灰色窄带。 一条灰色实线从 (n_s约
// 0.973, r约0.053) 向下延伸至 (n_s约0.978, r约0.022)。
// 一条深蓝色虚线段，带有两个深蓝色实心圆点，分别位于 (
// n_s=0.963, r=0.005) 和 (n_s约0.968, r=0.0035)。 图例显
// 示： 实心点 N=50 和 N=60 分别表示不同大小的圆点。 颜色
// 块对应不同数据集：ACT-LB-BK18（蓝）、Planck-LB-BK18（
// 橙）、P-ACT-LB-BK18（紫）。 绿色边框方块对应
// P-ACT-LB_DR2-BK18。 黑色实线表示 V(φ) ∝ φ。 灰色实线表
// 示 V(φ) ∝ φ^(2/3) 和 V(φ) ∝ φ^(1/3)。 蓝色虚线表示 R^2。
// 该子图传达了不同观测数据集对 n_s 和 r 的约束，以及这些
// 约束与理论模型（如不同势函数形式和曲率假设）的对比。
// 图中右侧子图仅部分可见，主要显示为左侧图例信息，未提供
// 其坐标轴、数据或具体趋势的完整细节，无法进行详细描述。
// [figvision-cn] imgs/fig59a.png
// 图中左侧子图为一个二维参数约束图，横轴为标量光谱指数
// n_s，范围从 0.95 到 1.00；纵轴为张量标量比 r，范围从
// 0.00 到 0.10。 图中主要包含四组椭圆形的置信区间区域，
// 用不同颜色填充表示： 蓝色区域代表 ACT-LB-BK18 数据集，
// 其范围较宽且偏向右侧。 橙色区域代表 Planck-LB-BK18 数
// 据集。 紫色区域代表 P-ACT-LB-BK18 数据集，位于中心较窄
// 区域。 绿色空心轮廓线代表 P-ACT-LB_DR2-BK18 数据集，呈
// 现细长椭圆状，位于中心且略微向右下倾斜。 图中还叠加了
// 几条理论预测曲线和线条： 一条黑色实线从左上（r=0.10,
// n_s约0.966）斜向右下延伸至（n_s=1.00, r=0），附近标注
// 有 "Convex" 和 "Concave" 文字。 两条黑色虚线沿实线平行
// 方向延伸，内部夹着一条灰色窄带。 一条灰色实线从 (n_s约
// 0.973, r约0.053) 向下延伸至 (n_s约0.978, r约0.022)。
// 一条深蓝色虚线段，带有两个深蓝色实心圆点，分别位于 (
// n_s=0.963, r=0.005) 和 (n_s约0.968, r=0.0035)。 图例显
// 示： 实心点 N=50 和 N=60 分别表示不同大小的圆点。 颜色
// 块对应不同数据集：ACT-LB-BK18（蓝）、Planck-LB-BK18（
// 橙）、P-ACT-LB-BK18（紫）。 绿色边框方块对应
// P-ACT-LB_DR2-BK18。 黑色实线表示 V(φ) ∝ φ。 灰色实线表
// 示 V(φ) ∝ φ^(2/3) 和 V(φ) ∝ φ^(1/3)。 蓝色虚线表示 R^2。
// 该子图传达了不同观测数据集对 n_s 和 r 的约束，以及这些
// 约束与理论模型（如不同势函数形式和曲率假设）的对比。
// 图中右侧子图仅部分可见，主要显示为左侧图例信息，未提供
// 其坐标轴、数据或具体趋势的完整细节，无法进行详细描述。
#figure([#box(image("imgs/fig59a.png", width: 53.0%)) #box(image("imgs/fig60a.png", width: 46.5%))

  ],
  caption: [
    Constraints in the $r - n_s$ plane (left, as in Fig.~#ref(<fig:tensors>, supplement: none)) and on the curvature and matter densities (right, same as Fig.~#ref(<fig:omk>, supplement: none)), with the addition of the combination P-ACT-LB$""_(D R 2)$ using DESI DR2 shown in green. 
  ],
  placement: top,
)
<fig:r_ns_omk_dr2>

The impact of DESI DR2 on most single parameter extensions studied in this paper is minimal. We report here only three cases that exhibit shifts worth noting. The measurement of $N_("eff")$ is only marginally improved with the newer DESI data and the central value shifts towards the standard model predictions, yielding $N_("eff")=2.92plus.minus 0.12$ (68%, P-ACT-LB$""_(D R 2)$). The right panel of Fig.~#ref(<fig:r_ns_omk_dr2>, supplement: none) shows that the measurement of $n_s = 0.9752 plus.minus 0.0030$ obtained with P-ACT-LB$""_(D R 2)$ (see L25) tightens the contours in the $r - n_s$ plane, reducing further the parameter space allowed for Starobinsky-like inflation models (assuming 50--60 e-folds of inflation). A tighter measurement of the matter fraction shrinks the uncertainty on --- and reduces correlations with --- spatial curvature as shown in the left panel of Fig.~#ref(<fig:r_ns_omk_dr2>, supplement: none), yielding $Omega_k = 0.0018 plus.minus 0.0011$ (68%, P-ACT-LB$""_(D R 2)$), in agreement with $Lambda"CDM"$~at $1.6 sigma$.

== Optical Depth
<optical-depth>
Recent works (e.g.,~#cite(<2024arXiv241000090L>, style: "aas_noparen.csl")#cite(<2025arXiv250305691A>, style: "aas_noparen.csl")#cite(<2025arXiv250416932S>, style: "aas_noparen.csl")#cite(<2025arXiv250421813J>, style: "aas_noparen.csl")), have shown that the contribution to tight limits on the neutrino mass sum and the evidence for evolving dark energy stemming from the matter density fraction measured by DESI BAO can be reduced by relaxing the constraint on the optical depth, $tau$. We show the impact of $tau$ on our P-ACT-LB~results by doubling the `Sroll2` uncertainty on $tau$ and using a Gaussian prior of $tau = 0.057 plus.minus 0.012$. This positions $tau$ in between the most stringent limit from `Sroll2` and the recent measurement from CLASS~#cite(<2025arXiv250111904L>). We find that a more uncertain measurement of $tau$ at this level has no impact on the $w_0$/$w_a$ constraints. To reduce further the evidence for evolving dark energy, the central value of the prior needs to shift towards higher values of $tau approx 0.07$ --- this is consistent with the fact that the value of $tau$ preferred by the combination P-ACT-LB$""_(D R 2)$ ($tau = 0.0643_(- 0.0067)^(+ 0.0055)$, L25) is higher compared to the central value of the `Sroll2` measurement. We show this in Fig.~#ref(<fig:desi_dr2_lcdm>, supplement: none) by removing `Sroll2` information altogether and measuring $tau$ from lensing effects in the power spectra, which break the $A_s$--$tau$ degeneracy. The $w_0 / w_a$ limits become broader and move closer to consistency with $Lambda"CDM"$, at the $2 sigma$ level for P-ACT-LB$""_(D R 2)$S, and measure $tau = 0.081 plus.minus 0.016$.

Given the well-known degeneracy between neutrino mass and the power spectrum amplitude, which in turn correlates with $tau$, the neutrino mass limit is also expected to become more relaxed when considering a more uncertain $tau$. We find that a wider prior has minimal impact, yielding $sum m_nu < 0.10$~eV at 95% confidence for P-ACT-LB, which becomes $sum m_nu < 0.19$~eV excluding `Sroll2` completely.

#align(center)[#text(12pt, weight: "bold")[All Authors and Affiliations]]
#v(0.5em)
#text(9pt)[
Erminia Calabrese#super[1], J. Colin Hill#super[2,3], Hidde T. Jense#super[1], Adrien La Posta#super[4], Irene Abril-Cabezas#super[5,6], Graeme E. Addison#super[7], Peter A. R. Ade#super[1], Simone Aiola#super[3,8], Tommy Alford#super[9], David Alonso#super[4], Mandana Amiri#super[10], Rui An#super[11], Zachary Atkins#super[8], Jason E. Austermann#super[12], Eleonora Barbavara#super[13], Nicola Barbieri#super[14,15], Nicholas Battaglia#super[16,17], Elia Stefano Battistelli#super[13], James A. Beall#super[12], Rachel Bean#super[16], Ali Beheshti#super[18], Benjamin Beringue#super[17], Tanay Bhandarkar#super[19], Emily Biermann#super[20], Boris Bolliet#super[21,6], J Richard Bond#super[22], Valentina Capalbo#super[13], Felipe Carrero#super[23], Shi-Fan Chen#super[24], Grace Chesmore#super[9], Hsiao-mei Cho#super[25,12], Steve K. Choi#super[26], Susan E. Clark#super[27,28], Nicholas F. Cothard#super[29], Kevin Coughlin#super[9], William Coulton#super[6,5], Devin Crichton#super[30], Kevin T. Crowley#super[31], Omar Darwish#super[32], Mark J. Devlin#super[19], Simon Dicker#super[19], Cody J. Duell#super[33], Shannon M. Duff#super[12], Adriaan J. Duivenvoorden#super[34], Jo Dunkley#super[8,35], Rolando Dunner#super[23], Carmen Embil Villagra#super[5,6], Max Fankhanel#super[36], Gerrit S. Farren#super[37,38], Simone Ferraro#super[37,39,38], Allen Foster#super[8], Rodrigo Freundt#super[16], Brittany Fuzia#super[40], Patricio A. Gallardo#super[9,19], Xavier Garrido#super[41], Martina Gerbino#super[15], Serena Giardiello#super[1], Ajay Gill#super[42], Jahmour Givans#super[35], Vera Gluscevic#super[11], Samuel Goldstein#super[2], Joseph E. Golec#super[9], Yulin Gong#super[16], Yilun Guan#super[43], Mark Halpern#super[10], Ian Harrison#super[1], Matthew Hasselfield#super[3], Adam He#super[11], Erin Healy#super[9,8], Shawn Henderson#super[25], Brandon Hensley#super[44], Carlos Hervías-Caimapo#super[23], Gene C. Hilton#super[12], Matt Hilton#super[45,46], Adam D. Hincks#super[47,48], Renée Hložek#super[43,47], Shuay-Pwu Patty Ho#super[8], John Hood#super[49], Erika Hornecker#super[47], Zachary B. Huber#super[33], Johannes Hubmayr#super[12], Kevin M. Huffenberger#super[50], John P. Hughes#super[51], Margaret Ikape#super[47], Kent Irwin#super[27], Giovanni Isopi#super[13], Neha Joshi#super[19], Ben Keller#super[33], Joshua Kim#super[19], Kenda Knowles#super[52], Brian J. Koopman#super[53], Arthur Kosowsky#super[18], Darby Kramer#super[54], Aleksandra Kusiak#super[55,6], Alex Laguë#super[19], Victoria Lakey#super[56], Massimiliano Lattanzi#super[15], Eunseong Lee#super[19], Yaqiong Li#super[33], Zack Li#super[39,38], Michele Limon#super[19], Martine Lokken#super[57], Thibaut Louis#super[41], Marius Lungu#super[9], Niall MacCrann#super[5,6], Amanda MacInnis#super[58], Mathew S. Madhavacheril#super[19], Diego Maldonado#super[36], Felipe Maldonado#super[40], Maya Mallaby-Kay#super[49], Gabriela A. Marques#super[59,60], Joshiwa van Marrewijk#super[61], Fiona McCarthy#super[5,6], Jeff McMahon#super[60,49,9,62], Yogesh Mehta#super[54], Felipe Menanteau#super[63,64], Kavilan Moodley#super[46], Thomas W. Morris#super[53,65], Tony Mroczkowski#super[66], Sigurd Naess#super[67], Toshiya Namikawa#super[5,6,68], Federico Nati#super[69], Simran K. Nerval#super[47,43], Laura Newburgh#super[53], Andrina Nicola#super[70], Michael D. Niemack#super[33,16], Michael R. Nolta#super[22], John Orlowski-Scherer#super[19], Luca Pagano#super[14,15,71], Lyman A. Page#super[8], Shivam Pandey#super[2], Bruce Partridge#super[72], Karen Perez Sarmiento#super[19], Heather Prince#super[51], Roberto Puddu#super[23], Frank J. Qu#super[27,28,6], Damien C. Ragavan#super[45], Bernardita Ried Guachalla#super[27,28], Keir K. Rogers#super[73,43], Felipe Rojas#super[23], Tai Sakuma#super[8], Emmanuel Schaan#super[25,28], Benjamin L. Schmitt#super[19], Neelima Sehgal#super[58], Shabbir Shaikh#super[54], Blake D. Sherwin#super[5,6], Carlos Sierra#super[9], Jon Sievers#super[74], Cristóbal Sifón, Sara Simon#super[59], Rita Sonka#super[8], David N. Spergel#super[3], Suzanne T. Staggs#super[8], Emilie Storer#super[74,8], Kristen Surrao#super[2], Eric R. Switzer#super[29], Niklas Tampier#super[36], Leander Thiele#super[75,68], Robert Thornton#super[76,19], Hy Trac#super[77], Carole Tucker#super[1], Joel Ullom#super[12], Leila R. Vale#super[12], Alexander Van Engelen#super[54], Jeff Van Lanen#super[12], Cristian Vargas#super[50], Eve M. Vavagiakis#super[78,33], Kasey Wagoner#super[79,8], Yuhan Wang#super[33], Lukas Wenzl#super[16], Edward J. Wollack#super[29], Kaiwen Zheng#super[8]
]
#v(1em)
#columns(2, gutter: 1.06cm)[#text(8pt)[
#set par(justify: false)
1. School of Physics and Astronomy, Cardiff University, The Parade, Cardiff, Wales, UK CF24 3AA \
2. Department of Physics, Columbia University, New York, NY 10027, USA \
3. Flatiron Institute, 162 5th Avenue, New York, NY 10010 USA \
4. Department of Physics, University of Oxford, Keble Road, Oxford, UK OX1 3RH \
5. DAMTP, Centre for Mathematical Sciences, University of Cambridge, Wilberforce Road, Cambridge CB3 OWA, UK \
6. Kavli Institute for Cosmology Cambridge, Madingley Road, Cambridge CB3 0HA, UK \
7. Dept. of Physics and Astronomy, The Johns Hopkins University, 3400 N. Charles St., Baltimore, MD, USA 21218-2686 \
8. Joseph Henry Laboratories of Physics, Jadwin Hall, Princeton University, Princeton, NJ, USA 08544 \
9. Department of Physics, University of Chicago, Chicago, IL 60637, USA \
10. Department of Physics and Astronomy, University of British Columbia, Vancouver, BC, Canada V6T 1Z4 \
11. Department of Physics and Astronomy, University of Southern California, Los Angeles, CA 90089, USA \
12. NIST Quantum Sensors Group, 325 Broadway Mailcode 817.03, Boulder, CO, USA 80305 \
13. Sapienza University of Rome, Physics Department, Piazzale Aldo Moro 5, 00185 Rome, Italy \
14. Dipartimento di Fisica e Scienze della Terra, Università degli Studi di Ferrara, via Saragat 1, I-44122 Ferrara, Italy \
15. Istituto Nazionale di Fisica Nucleare (INFN), Sezione di Ferrara, Via G. Saragat 1, I-44122 Ferrara, Italy \
16. Department of Astronomy, Cornell University, Ithaca, NY 14853, USA \
17. Universite Paris Cite, CNRS, Astroparticule et Cosmologie, F-75013 Paris, France \
18. Department of Physics and Astronomy, University of Pittsburgh, Pittsburgh, PA, USA 15260 \
19. Department of Physics and Astronomy, University of Pennsylvania, 209 South 33rd Street, Philadelphia, PA, USA 19104 \
20. Los Alamos National Laboratory, Bikini Atoll Rd, Los Alamos, NM, 87545, USA \
21. Department of Physics, Madingley Road, Cambridge CB3 0HA, UK \
22. Canadian Institute for Theoretical Astrophysics, University of Toronto, Toronto, ON, Canada M5S 3H8 \
23. Instituto de Astrofísica and Centro de Astro-Ingeniería, Facultad de Física, Pontificia Universidad Católica de Chile, Av. Vicu\ na Mackenna 4860, 7820436 Macul, Santiago, Chile \
24. Institute for Advanced Study, 1 Einstein Dr, Princeton, NJ 08540 \
25. SLAC National Accelerator Laboratory 2575 Sand Hill Road Menlo Park, California 94025, USA \
26. Department of Physics and Astronomy, University of California, Riverside, CA 92521, USA \
27. Department of Physics, Stanford University, Stanford, CA \
28. Kavli Institute for Particle Astrophysics and Cosmology, 382 Via Pueblo Mall Stanford, CA 94305-4060, USA \
29. NASA/Goddard Space Flight Center, Greenbelt, MD, USA 20771 \
30. Institute for Particle Physics and Astrophysics, ETH Zurich, 8092 Zurich, Switzerland \
31. Department of Astronomy and Astrophysics, University of California San Diego, La Jolla, CA 92093 USA \
32. Université de Genève, Département de Physique Théorique et CAP, 24 quai Ernest-Ansermet, CH-1211 Genève 4, Switzerland \
33. Department of Physics, Cornell University, Ithaca, NY, USA 14853 \
34. Max-Planck-Institut fur Astrophysik, Karl-Schwarzschild-Str. 1, 85748 Garching, Germany \
35. Department of Astrophysical Sciences, Peyton Hall, Princeton University, Princeton, NJ USA 08544 \
36. Camino a Toconao 145-A, Ayllu de Solor, San Pedro de Atacama, Chile \
37. Physics Division, Lawrence Berkeley National Laboratory, Berkeley, CA 94720, USA \
38. Berkeley Center for Cosmological Physics, University of California, Berkeley, CA 94720, USA \
39. Department of Physics, University of California, Berkeley, CA, USA 94720 \
40. Department of Physics, Florida State University, Tallahassee FL, USA 32306 \
41. Université Paris-Saclay, CNRS/IN2P3, IJCLab, 91405 Orsay, France \
42. Department of Aeronautics & Astronautics, Massachusetts Institute of Technology, 77 Mass. Avenue, Cambridge, MA 02139, USA \
43. Dunlap Institute for Astronomy and Astrophysics, University of Toronto, 50 St. George St., Toronto, ON M5S 3H4, Canada \
44. Jet Propulsion Laboratory, California Institute of Technology, 4800 Oak Grove Drive, Pasadena, CA 91109, USA \
45. Wits Centre for Astrophysics, School of Physics, University of the Witwatersrand, Private Bag 3, 2050, Johannesburg, South Africa \
46. Astrophysics Research Centre, School of Mathematics, Statistics and Computer Science, University of KwaZulu-Natal, Durban 4001, South Africa \
47. David A. Dunlap Dept of Astronomy and Astrophysics, University of Toronto, 50 St George Street, Toronto ON, M5S 3H4, Canada \
48. Specola Vaticana (Vatican Observatory), V-00120 Vatican City State \
49. Department of Astronomy and Astrophysics, University of Chicago, 5640 S. Ellis Ave., Chicago, IL 60637, USA \
50. Mitchell Institute for Fundamental Physics & Astronomy and Department of Physics & Astronomy, Texas A&M University, College Station, Texas 77843, USA \
51. Department of Physics and Astronomy, Rutgers, The State University of New Jersey, Piscataway, NJ USA 08854-8019 \
52. Centre for Radio Astronomy Techniques and Technologies, Department of Physics and Electronics, Rhodes University, P.O. Box 94, Makhanda 6140, South Africa \
53. Department of Physics, Yale University, 217 Prospect St, New Haven, CT 06511 \
54. School of Earth and Space Exploration, Arizona State University, Tempe, AZ, USA 85287 \
55. Institute of Astronomy, Madingley Road, Cambridge CB3 0HA, UK \
56. Department of Chemistry and Physics, Lincoln University, PA 19352, USA \
57. Institut de Fisica d'Altes Energies (IFAE), The Barcelona Institute of Science and Technology, Campus UAB, 08193 Bellaterra, Spain \
58. Physics and Astronomy Department, Stony Brook University, Stony Brook, NY USA 11794 \
59. Fermi National Accelerator Laboratory, MS209, P.O. Box 500, Batavia, IL 60510 \
60. Kavli Institute for Cosmological Physics, University of Chicago, 5640 S. Ellis Ave., Chicago, IL 60637, USA \
61. Leiden Observatory, Leiden University, P.O. Box 9513, 2300 RA Leiden, The Netherlands \
62. Enrico Fermi Institute, University of Chicago, Chicago, IL 60637, USA \
63. NCSA, University of Illinois at Urbana-Champaign, 1205 W. Clark St., Urbana, IL, USA, 61801 \
64. Department of Astronomy, University of Illinois at Urbana-Champaign, W. Green Street, Urbana, IL, USA, 61801 \
65. Brookhaven National Laboratory, Upton, NY, USA 11973 \
66. European Southern Observatory, Karl-Schwarzschild-Str. 2, D-85748, Garching, Germany \
67. Institute of Theoretical Astrophysics, University of Oslo, Norway \
68. Kavli IPMU (WPI), UTIAS, The University of Tokyo, Kashiwa, 277-8583, Japan \
69. Department of Physics, University of Milano - Bicocca, Piazza della Scienza, 3 - 20126, Milano (MI), Italy \
70. Argelander Institut fur Astronomie, Universität Bonn, Auf dem Hügel 71, 53121 Bonn, Germany \
71. Université Paris-Saclay, CNRS, Institut d'astrophysique spatiale, 91405, Orsay, France \
72. Department of Physics and Astronomy, Haverford College, Haverford, PA, USA 19041 \
73. Department of Physics, Imperial College London, Blackett Laboratory, Prince Consort Road, London, SW7 2AZ, UK \
74. Physics Department, McGill University, Montreal, QC H3A 0G4, Canada \
75. Center for Data-Driven Discovery, Kavli IPMU (WPI), UTIAS, The University of Tokyo, Kashiwa, Chiba 277-8583, Japan \
76. Department of Physics, West Chester University of Pennsylvania, West Chester, PA, USA 19383 \
77. McWilliams Center for Cosmology, Carnegie Mellon University, Department of Physics, 5000 Forbes Ave., Pittsburgh PA, USA, 15213 \
78. Department of Physics, Duke University, Durham, NC, 27708, USA \
79. Department of Physics, NC State University, Raleigh, North Carolina, USA \
]]