#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.54cm, right: 2.54cm, top: 2.64cm, bottom: 3.49cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.28em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.78em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#set figure.caption(separator: [ | ])
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(17pt, weight: "bold", [A long-duration gamma-ray burst with a peculiar origin])   #v(1.2em)
  #text(10.5pt)[Jun Yang#super[1, 2], Shunke Ai#super[3, 4], Bin-Bin Zhang#super[1, 2], Bing Zhang#super[3, 4], Zi-Ke Liu#super[1, 2], Xiangyu Ivy Wang#super[1, 2], Yu-Han Yang#super[1, 2], Yi-Han Yin#super[5], Ye Li#super[6], Hou-Jun Lü#super[7]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] School of Astronomy and Space Science, Nanjing University, Nanjing 210093, China] \
  #text(9pt)[#super[2] Key Laboratory of Modern Astronomy and Astrophysics (Nanjing University), Ministry of Education, China] \
  #text(9pt)[#super[3] Nevada Center for Astrophysics, University of Nevada Las Vegas, NV 89154, USA] \
  #text(9pt)[#super[4] Department of Physics and Astronomy, University of Nevada Las Vegas, NV 89154, USA] \
  #text(9pt)[#super[5] School of Physics, Nanjing University, Nanjing 210093, China] \
  #text(9pt)[#super[6] Purple Mountain Observatory, Chinese Academy of Sciences, Nanjing 210023, China] \
  #text(9pt)[#super[7] Guangxi Key Laboratory for Relativistic Astrophysics, School of Physical Science and Technology, Guangxi University, Nanning 530004, China] \
]
#v(1.2em)








It is generally believed that long-duration gamma-ray bursts (GRBs) are associated with massive star core-collapse@Woosley_2006ARAA, whereas short-duration GRBs are associated with mergers of compact star binaries@Berger_2014ARAA. However, growing observations@Gehrels_2006Natur @Della_2006Natur @Zhang_2021NatAs @Ahumada_2021NatAs have suggested that oddball GRBs do exist, and multiple criteria (prompt emission properties, supernova/kilonova associations, and host galaxy properties) rather than burst duration only are needed to classify GRBs physically@Zhang_2009ApJ. A previously reported long-duration burst, GRB 060614@Gehrels_2006Natur, could be viewed as a short GRB with extended emission if it were observed at a larger distance@Zhang_2007ApJ and was associated with a kilonova-like feature@Yang_2015NatCo. As a result, it belongs to the Type-I (compact star merger) GRB category and is likely of the binary neutron star merger origin. Here we report a peculiar long-duration gamma-ray burst, GRB 211211A, whose prompt emission properties in many aspects differ from all known Type-I GRBs, yet its multi-band observations suggest a non-massive-star origin. In particular, significant excess emission in both optical and near-infrared wavelengths has been discovered (see also Ref.@Rastinejad_2022arXiv), which resembles kilonova emission as observed in some Type-I GRBs. These observations point towards a new progenitor type of GRBs. A scenario invoking a white dwarf-neutron star merger with a post-merger magnetar engine provides a self-consistent interpretation for all the observations, including prompt gamma-rays, early X-ray afterglow, as well as the engine-fed @Yu_2013ApJ @Ai_2022arXiv kilonova emission.


GRB 211211A triggered the Gamma-ray Burst Monitor (GBM @Meegan_2009ApJ) onboard #emph[The Fermi Gamma-Ray Space Telescope], the Burst Alert Telescope (BAT @Barthelmy_2005SSRv) onboard #emph[The Neil Gehrels Swift Observatory], and the high energy X-ray Telescope onboard #emph[Insight]-HXMT @Xiao2022arXiv at 13:09:59 Coordinated Universal Time on 11 December 2021 (hereafter $T_(upright(0))$). The burst is characterized by a spiky main emission (ME) phase lasting $tilde 13$ seconds and a longer, weaker extended emission (EE) phase lasting $tilde$ 55 seconds (@fig:anares and @tab:summary). Our detailed spectral analysis (Methods and @tab:summary) shows that the time-integrated spectrum of the ME phase can be fitted by a Band @Band_1993ApJ model with spectral indices $alpha = - 0.996_(- 0.005)^(+ 0.005)$, $beta = - 2.36_(- 0.02)^(+ 0.02)$, and peak energy $E_(upright(p)) = 687.1_(- 11.0)^(+ 12.5)$, and that of the EE phase can be fitted by a Band model with spectral indices $alpha = - 0.97_(- 0.04)^(+ 0.03)$, $beta = - 2.02_(- 0.02)^(+ 0.01)$, and peak energy $E_(upright(p)) = 82.0_(- 2.3)^(+ 3.8)$. Follow-up observations revealed a candidate host galaxy at redshift $z = 0.076$ (Ref.@Rastinejad_2022arXiv).


Despite its long duration, GRB 211211A does not fit into the Type-II (massive star core-collapse) GRB category, to which most long-duration GRBs belong. Instead, multiple pieces of observational evidence place GRB 211211A squarely into the Type-I GRB category. First, GRB 211211A shows tiny spectral lags between the multi-band light curves (Methods and @tab:summary). Such a characteristic is typically observed in Type-I GRBs. Second, the offset between the GRB location and its host galaxy is calculated to be 8.19 kpc, corresponding to a normalized offset value of 9.02 (Methods and @tab:summary). Such a large offset would be very peculiar if GRB 211211A were a Type-II GRB, but it is in agreement with the prediction of a compact object merger origin of the burst, since a supernova associated with the birth of a neutron star member in the binary system likely "kicks" the system away from the star-forming region in the host galaxy. Third, the ME phase of GRB 211211A follows the Type-I (rather than Type-II) GRB track in the Amati relation diagram @Amati_2002AandA (Methods and #ref(<fig:pvp>)b), even though the EE phase follows the track of Type-II GRBs. Fourth, there is an apparent absence of a supernova (Methods and #ref(<fig:agmnmodeling>)a) in the long-term optical data, which rules out the possibility of GRB 211211A being a typical Type-II GRB caused by the core-collapse of a massive star. Lastly, the standard external shock afterglow model, while fitting the overall trend of the multi-wavelength afterglow (especially in X-rays), significantly under-fits the optical and near-infrared band data around 1--10 days (Methods and #ref(<fig:agmnmodeling>)c). Such kind of excess has long been considered as evidence of the existence of an underlying kilonova emission, typically produced from neutron star mergers @Li_1998ApJ @Metzger_2010MNRAS. Indeed, Ref.@Rastinejad_2022arXiv has claimed the detection of a kilonova based on the multi-wavelength excess data, and our analysis independently confirms such an association (Methods and #ref(<fig:agmnmodeling>)c).


Such a GRB has never been observed before. The closest analogy was GRB 060614, a previously-discovered long-duration Type-I burst@Gehrels_2006Natur. GRB 211211A, however, distinguishes itself by its significantly longer ME duration and much harder EE. This is evident from the following observational facts: (1) As listed in @tab:summary, GRB 211211A exhibits a twice longer ME phase and a half shorter EE phase in comparison with GRB 060614 (#ref(<fig:anares>)a). This makes GRB 211211A very different from the short main burst + extended emission pattern as observed in some Type-I GRBs; (2) Most Type-I GRBs have a relatively large "effective amplitude parameter" $f_"eff"$, which suggests that the short duration is not due to a "tip-of-iceberg" effect@Lu_2014MNRAS. GRB 211211A, on the other hand, has a much smaller $f_"eff"$ (@tab:summary), making it fall into the distribution of typical long-duration GRBs in the $f_"eff" - T_(upright(90))$ diagram (Methods and #ref(<fig:pvp>)a), confirming its genuinely long-duration nature. In contrast, GRB 060614 had a relatively large $f_"eff"$ (@tab:summary), making it more resemble short-duration Type-I GRB @Zhang_2007ApJ\; (3) Comparatively speaking, the spectra of GRB 211211A in both the ME and EE phases are much harder than those of GRB 060614 (@tab:summary). The fact that the ME of GRB 211211A is both longer and harder than that of GRB 060614 rules out any possibility that the two events are intrinsically similar but appear differently because of jet structure or viewing angle effects. To summarize, GRB 211211A does not belong to an extreme version of short GRBs with extended emission (as GRB 060614 does). It pushes the envelope of Type-I GRBs to the genuinely long-duration regime.


The unique properties of GRB 211211A call for a new progenitor system that was not invoked to interpret standard short or long GRBs. First, the lack of a supernova explosion signature directly rules out the massive star core-collapse interpretation. Second, whereas the $tilde 6$-s ME duration for GRB 060614 may still allow it to belong to the short GRB category based on the $T_90$ distribution, the $tilde 13$-s ME duration of GRB 211211A rejects it from the short GRB category beyond the $3 sigma$ level (Methods). For an accretion-powered engine, the duration of a burst should scale with the density of the progenitor star@zhang_2018book. The longer-than-short ME duration and the lack of a supernova signature suggest that the progenitor star should have a lower density than a neutron star (NS, which is typically used to interpret short GRBs) but cannot be a massive star. A white dwarf (WD) star naturally falls into such a category. Because the GRB engine needs to be either an NS or a black hole (BH) to reproduce the short variability timescale observed@zhang_2018book (Methods and @tab:summary), the WD needs to evolve to a more compact engine, so the most likely progenitor system would be a WD-NS merger system. Indeed, all other compact star merger scenarios suffer difficulties in interpreting this event (Methods).


Observations also suggest that the merger product is not a BH but rather a rapidly spinning magnetar. First, the 55-s EE with distinct emission properties from the ME (Methods and @tab:summary) requires that the engine is not an accreting black hole but is rather a proto-magnetar (Methods). After the initial accretion phase to power the ME, the proto-magnetar goes through a differential rotation phase during which magnetic bubbles are launched to power the EE@Kluzniak_1998ApJ @Ruderman_2000ApJ @Dai_2006Sci (Methods). A magnetar with an initial differential kinetic energy of $tilde 10^51$ erg is capable of producing tens of similar eruptions, with the interval between two adjacent bubble eruptions being $tau_(upright(b)) tilde.eq ( 1.6 med upright(s) ) ( B_(upright(r)) / 10^13 med upright(G) )^(- 1) ( P_0 / "ms" )$, where $B_(upright(r))$ and $P_0$ are the internal radial magnetic field and the initial spin period of the proto-magnetar @Kluzniak_1998ApJ. Second, the early X-ray afterglow has a plateau lasting up to $tilde$ 6,000 s (Methods), consistent with the existence of a long-lasting central engine. Assuming isotropic emission and $P_0 tilde 1$ ms, we obtain the surface dipolar magnetic field at the pole being $B_(upright(p)) approx 3 times 10^14$ G (Methods). Third, the kilonova light curve can be well modeled by an engine-fed kilonova @Yu_2013ApJ @Ai_2022arXiv with the following parameters: $P_0 = 1$ ms, $B_(upright(p)) = 1.9_(- 0.4)^(+ 1.0) times 10^13$ G, radioactive mass ratio $f_(upright(n)) = 0.80_(- 0.24)^(+ 0.03)$, opacity $kappa = 0.73_(- 0.06)^(+ 0.53)$ $"cm"^2 thin g^(- 1)$, total ejecta mass $M_"ej" = 0.037_(- 0.004)^(+ 0.008)$ $upright(M)_⊙$, and initial ejecta velocity $v_"ej" = 0.24_(- 0.02)^(+ 0.06) thin upright(c)$ (Methods). The smaller fitted $B_(upright(p))$ compared with the X-ray constraint suggests that the X-ray emission is collimated with a beaming factor of 0.004, corresponding to an opening angle of $tilde 5$ degrees. One can see that a WD-NS merger progenitor with a millisecond post-merger magnetar engine provides a self-consistent interpretation for all the data.


Within such a picture, the "kilonova" differs from the traditional picture that only invokes r-process and $beta$-decay nuclear heating. The ejected materials include a neutron-poor component and a neutron-rich component so that only a fraction of the ejecta mass contributes to nuclear heating. In addition, energy injection from the magnetar central engine also provides additional heating to the ejecta @Yu_2013ApJ @Ai_2022arXiv. Our engine-fed kilonova model fitting suggests that about $0.037$ $upright(M)_⊙$ total mass is ejected, with a fraction of $tilde 0.8$ being neutron-rich materials partially powering the kilonova emission. The rarity of the GRB 211211A and the fact that WD-NS mergers are more common than NS-NS mergers suggest that the majority of WD-NS mergers must not produce GRBs. Indeed, only a very small fraction of WD-NS mergers with a mass ratio close to unity could produce the necessary conditions for a magnetar-powered GRB (Methods).


The observations of GRB 211211A suggest that Type-I GRBs can have diverse sub-categories with different progenitor types. WD-NS mergers could be another type of progenitor to power Type-I GRBs. The gravitational-wave (GW) signals from these mergers have a typical frequency of around 0.1 Hz@Toonen_2018AA, which is below the sensitivity of ground-based GW detectors LIGO/Virgo/KAGRA@Buikema_2020PhRvD @Bersanetti_2021Univ @Kagra_2019NatAs. They can, however, potentially be detected by future space missions such as LISA@Amaro_2017arXiv, Taiji@Luo_2020ResPh, and Tianqin@Luo_2016CQGra.













#heading(level: 1, numbering: none)[Methods]
<methods>


== Prompt emission. \
<prompt-emission.>


We retrieved the time-tagged event dataset covering the time range of GRB 211211A from the #emph[Fermi]/GBM public data archive (#link("https://heasarc.gsfc.nasa.gov/FTP/fermi/data/gbm/daily/")). Two sodium iodide (NaI) detectors, namely n2 and na, with the smallest viewing angles in respect to the GRB source direction, are selected for our analysis. Additionally, one bismuth germanium oxide (BGO) detector, b0, closest to the GRB direction, was also selected for spectral analysis. Since GRB 211211A is also detected by #emph[Swift]/BAT, we employ those BAT data in our analysis. #emph[Swift]/BAT data was downloaded from the #emph[Swift] archive website (#link("https://www.swift.ac.uk/archive/ql.php")).


#emph[Light curves]: The BAT light curve is obtained following the standard analysis threads (#link("https://www.swift.ac.uk/analysis/bat/")) using the #emph[HEASoft] tools (version 6.28). We first check the energy conversion of BAT event data using #emph[bateconvert]. Next, #emph[batbinevt], #emph[bathotpix], and #emph[batmaskwtevt] are utilized to generate the detector plane image, remove the hot pixels and apply mask-weighting, respectively. Then the BAT light curve (#ref(<fig:anares>)a) is created with a bin size of 0.2 s and with an energy range of 15--350 keV using #emph[batbinevt]. The $T_(upright(90), "BAT")$ of GRB 211211A is determined by #emph[battblocks] to be $51.00 plus.minus 1.02$ s.


The GBM light curve (#ref(<fig:anares>)b) is derived by binning the photons with a bin size of 0.2 s in the energy range of 10--1,000 keV collected from the selected two NaI detectors (namely, n2 and na). The background level is modeled by the baseline algorithm in the #emph[pybaseline] package (#link("https://github.com/derb12/pybaselines")). The burst duration, $T_(upright(90), "GBM")$, determined by the time difference between the epochs when the total accumulated net photon counts within 10--1,000 (50--300) keV reaches the $5 "%"$ level and the $95 "%"$ level, is calculated to be $43.18_(- 0.06)^(+ 0.06)$ ($36.58_(- 0.02)^(+ 0.02)$) s (@tab:summary and #ref(<fig:anares>)c).


The light curves in @fig:anares exhibit two distinct phases, namely, main emission (ME) and extended emission (EE). The ME is a sharply changing phase (which lasts for approximately 13 s) that is characterized by several hard spikes. Following a relatively quiescent time of $tilde$2 s, the EE phase appears as a decaying tail extending to $T_0 + 70$ s. Such ME+EE feature was also observed in the light curve of GRB 060614 (#ref(<fig:anares>)a). However, GRB 211211A exhibits a twice longer ME and a half shorter EE in comparison with GRB 060614, as listed in @tab:summary. We further explore their prompt light curves in a multi-band manner by extracting them separately within several energy bands from the event data (#ref(<fig:wavelag>)a). The temporal profiles of both bursts appear not to evolve with energy. Contrary to GRB 060614, there is significant emission above 350 keV during the ME phase of GRB 211211A, thanks to the broad energy coverage of #emph[Fermi]/GBM detectors. We also note that the EE phase of GRB 060614 is dominated by photons softer than 50 keV.


// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Figure #context it.counter.display(it.numbering): #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [Table #context it.counter.display(it.numbering): #it.body]
}

#figure(
  align(center)[#set text(size: 8.3pt)
    #table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Observed Properties], [GRB 211211A], [GRB 060614],),
    table.hline(),
    [#strong[Main Emission:]], [], [],
    [Duration ($upright(s)$)], [13], [6],
    [Averaged variability ($"ms"$)], [16], [...],
    [Spectral lag ($"ms"$)], [$10_(- 4)^(+ 3)$], [$3 plus.minus 6$],
    [Spectral index $alpha$], [$- 0.996_(- 0.005)^(+ 0.005)$], [$- 1.57_(- 0.14)^(+ 0.12)$],
    [Spectral index $beta$], [$- 2.36_(- 0.02)^(+ 0.02)$], [...],
    [Peak energy ($"keV"$)], [$687.1_(- 11.0)^(+ 12.5)$], [$302_(- 85)^(+ 214)$],
    [Energy fluence ($"erg" thin "cm"^(- 2)$)], [$3.77_(- 0.01)^(+ 0.01) times 10^(- 4)$], [$8.19_(- 2.52)^(+ 0.56) times 10^(- 6)$],
    [Isotropic energy ($"erg"$)], [$5.30_(- 0.01)^(+ 0.01) times 10^51$], [$3.18_(- 0.98)^(+ 0.22) times 10^50$],
    [#strong[Extended Emission:]], [], [],
    [Duration ($upright(s)$)], [55], [100],
    [Averaged variability ($"ms"$)], [48], [...],
    [Spectral lag ($"ms"$)], [$5_(- 5)^(+ 5)$], [$3 plus.minus 9$],
    [Spectral index $alpha$], [$- 0.97_(- 0.04)^(+ 0.03)$], [$- 2.13 plus.minus 0.05$],
    [Spectral index $beta$], [$- 2.02_(- 0.02)^(+ 0.01)$], [...],
    [Peak energy ($"keV"$)], [$82.0_(- 2.3)^(+ 3.8)$], [$lt.tilde 20$],
    [Peak luminosity ($"erg" thin s^(- 1)$)], [$2.05_(- 0.06)^(+ 0.06) times 10^50$], [...],
    [Isotropic energy ($"erg"$)], [$2.26_(- 0.01)^(+ 0.01) times 10^51$], [$1.27_(- 0.09)^(+ 0.06) times 10^51$],
    [#strong[Whole Burst:]], [], [],
    [$T_90$ ($upright(s)$)], [$43.18_(- 0.06)^(+ 0.06)$], [$102 plus.minus 5$],
    [Spectral lag ($"ms"$)], [$12 plus.minus 10$], [...],
    [$f_"eff"$ parameter], [$1.24 plus.minus 0.07$], [$2.26 plus.minus 0.23$],
    [Spectral index $alpha$], [$- 1.20_(- 0.01)^(+ 0.01)$], [...],
    [Spectral index $beta$], [$- 2.05_(- 0.02)^(+ 0.02)$], [...],
    [Peak energy ($"keV"$)], [$399.3_(- 16.1)^(+ 14.0)$], [$10 - 100$],
    [Peak flux ($"erg" thin "cm"^(- 2) thin s^(- 1)$)], [$1.38_(- 0.02)^(+ 0.02) times 10^(- 4)$], [$4.50_(- 1.53)^(+ 0.72) times 10^(- 6)$],
    [Total fluence ($"erg" thin "cm"^(- 2)$)], [$( 5.42 plus.minus 0.08 ) times 10^(- 4)$], [$4.09_(- 0.34)^(+ 0.18) times 10^(- 5)$],
    [Peak luminosity ($"erg" thin s^(- 1)$)], [$1.94_(- 0.03)^(+ 0.03) times 10^51$], [$1.74_(- 0.59)^(+ 0.28) times 10^50$],
    [Isotropic energy ($"erg"$)], [$( 7.61 plus.minus 0.11 ) times 10^51$], [$1.59_(- 0.13)^(+ 0.07) times 10^51$],
    [#strong[Host Galaxy:]], [], [],
    [Redshift], [0.076], [0.125],
    [Half-light radius ($"kpc"$)], [0.91], [0.87],
    [Offset ($"kpc"$)], [8.19], [0.80],
    [Normalized offset], [9.02], [1.09],
    [#strong[Associations:]], [], [],
    [Kilonova], [Yes], [Yes],
    [Supernova], [No], [No],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Summary of the observed properties of GRB 211211A in comparison with GRB 060614@GCN5264 @Della_2006Natur @Amati_2007AA @Yang_2015NatCo @Blanchard_2016ApJ @Lu_2014MNRAS.]]
  , kind: table
  )
 <tab:summary>








// [figvision-cn] imgs/Figure_1.png
// 该图由六个垂直堆叠的子图（a 至 f）组成，所有子图共享同
// 一横坐标轴。横坐标轴位于最底部，标签为“T - T0 (s)”，表
// 示相对于触发时间的时间延迟，单位为秒，范围从-10到80，
// 主刻度间隔为10。 子图 a： 类型：曲线图。 左侧纵坐标轴：
// 标签为“counts/s/det”，范围从0到20，主刻度间隔为10。 右
// 侧纵坐标轴：标签为“counts/s/det”，范围从0到2，主刻度间
// 隔为1。 曲线与数据：包含两条线。一条洋红色实线代表
// Swift/BAT探测到的GRB 211211A的光变曲线，对应左侧纵坐标；
// 另一条黑色实线代表Swift/BAT探测到的GRB 060614的光变曲
// 线，对应右侧纵坐标。 趋势与特征：洋红色曲线在时间约3秒
// 至9秒之间出现剧烈爆发，峰值接近20 counts/s/det，随后迅
// 速衰减并在约15秒后降至低水平背景噪声。黑色曲线在时间约
// 3秒至8秒之间同样出现爆发，峰值约为1.8 counts/s/det，随
// 后呈现长时段的缓慢衰减，在80秒时仍保持在0.5 counts/s/
// det以上。 图例：位于右上角，标注了洋红色线为“BAT-GRB
// 211211A”，黑色线为“BAT-GRB 060614”。 子图 b： 类型：带
// 背景填充区域的曲线图。 纵坐标轴：标签为“counts/s”，范
// 围从0到50,000，主刻度间隔为25,000。 曲线与区域：一条蓝
// 色实线代表Fermi/GBM探测到的GRB 211211A的净光变曲线。图
// 中有两个着色背景区域：浅青色矩形区域覆盖时间约2秒至12
// 秒，代表主辐射（main emission）阶段；灰色矩形区域紧随
// 其后，覆盖时间约12秒至70秒，代表延展辐射（extended
// emission）阶段。 趋势与特征：蓝色曲线在浅青色区域内表
// 现出快速且剧烈的波动，最高峰值超过60,000 counts/s；进
// 入灰色区域后，信号强度显著下降并趋于平缓，维持在较低水
// 平。 图例：位于右上角，标注了蓝色线为“GBM-GRB 211211A”，
// 浅青色块为“main emission”，灰色块为“extended emission”。
// 子图 c： 类型：累积计数曲线图。 纵坐标轴：标签为“
// accumulated counts”，范围从0到400,000以上，主刻度标记
// 为0、200,000、400,000。 曲线：一条蓝色实线表示累积计数
// 随时间的变化。 辅助线与标注：有两条垂直虚线分别位于时
// 间约2秒和约45秒处，界定了一个区间。在该区间右侧标注有
// 文字“T90, GBM = 43.18 +0.06 -0.06 s”。还有两条水平虚线
// 分别穿过曲线的起始点和终点，用于指示计数的起止范围。
// 趋势与特征：曲线从时间约2秒开始上升，斜率在主辐射阶段
// 较大，在延展辐射阶段逐渐变缓，最终在约45秒后达到饱和平
// 台。 子图 d： 类型：散点图与平滑曲线叠加图。 纵坐标轴：
// 标签为希腊字母“α”（alpha），范围从-1.75到-0.75，主刻度
// 间隔为0.25。 数据点与曲线：蓝色实心圆点带有垂直误差棒，
// 代表光谱指数α的测量值。灰色细线代表另一种参考或拟合趋
// 势。 趋势与特征：在时间2秒至10秒的主辐射期间，α值主要
// 在-1.0至-1.25之间波动。在10秒之后，α值整体呈现下降趋势
// （变得更负），数值分布在-1.25至-1.75之间，表明谱形随时
// 间变软。 子图 e： 类型：散点图与平滑曲线叠加图。 纵坐
// 标轴：标签为“Ep (keV)”，范围从0到2,000，主刻度间隔为1,
// 000。 数据点与曲线：蓝色实心圆点带有垂直误差棒，代表峰
// 值能量Ep。灰色细线作为参考背景。 趋势与特征：在时间2秒
// 至10秒的主辐射期间，Ep值极高，多次超过1,000 keV，甚至
// 接近2,000 keV。随着时间推移，Ep值迅速下降，在10秒后降
// 至500 keV以下，并持续缓慢降低。 子图 f： 类型：散点图
// 与平滑曲线叠加图。 纵坐标轴：标签为“flux (erg cm^-2 s^
// -1)”，采用对数标度，范围从10^-6到10^-4，主刻度标记为10
// ^-6、10^-5、10^-4。 数据点与曲线：蓝色实心圆点带有垂直
// 误差棒，代表能流密度。灰色细线作为参考背景。 趋势与特
// 征：能流密度的变化趋势与子图b中的光变曲线高度一致。在
// 时间2秒至10秒期间，能流密度达到峰值，数量级为10^-4 erg
// cm^-2 s^-1。随后急剧下降，在延展辐射阶段（10秒至70秒）
// 呈幂律衰减趋势，数值从10^-5逐渐降至10^-6附近。
#figure(placement: top, [#block[
  #box(image("imgs/Figure_1.png", width: 67%))
  ]],
  caption: [
    #strong[The temporal and spectral behaviors of GRB 211211A.] #strong[a], The net light curves of GRB 211211A (magenta line) and GRB 060614 (black line) obtained from #emph[Swift]/BAT data. For comparison, we reduce the trigger time of GRB 060614 by 5 seconds. #strong[b], The net light curve (blue line) of GRB 211211A obtained from #emph[Fermi]/GBM data. The cyan and grey shaded areas represent main emission (ME) and extended emission (EE) phases, respectively. #strong[c]: The accumulated counts (blue line) of the #emph[Fermi]/GBM net light curve. The grey horizontal dashed (solid) lines are drawn at $5 "%"$ ($0 "%"$) and $95 "%"$ ($100 "%"$) of the total accumulated counts. The $T_(upright(90), "GBM")$ interval is marked by the grey vertical dashed lines. #strong[d], #strong[e] and #strong[f] show the evolution of spectral index $alpha$, peak energy $E_(upright(p))$ and energy flux. The #emph[Fermi]/GBM net light curve (grey line) is plotted in the background as a reference. All error bars represent the 1$sigma$ confidence level.
  ]
)
<fig:anares>


// [figvision-cn] imgs/Figure_2.png
// 该图包含两个子图，分别标记为a和b，展示了关于伽马射线暴
// （GRB）的分类和相关性分析。 子图 a： 这是一个散点图，
// 用于展示有效谱指数（f_eff）与持续时间（T_90）之间的关
// 系。 坐标轴： 横轴（X轴）：标记为 T_90 (s)，表示以秒（
// s）为单位的90%能量释放时间。该轴采用对数标度，范围从10
// ^-1到10^3，主刻度线位于10^-1, 10^0, 10^1, 10^2, 10^3。
// 纵轴（Y轴）：标记为 f_eff，表示有效谱指数。该轴采用对
// 数标度，范围从10^0到10^1，主刻度线位于10^0和10^1。 数
// 据点与符号： 长伽马射线暴（long GRBs）：由黑色的实心菱
// 形表示。这些数据点主要集中在横轴大于2秒的区域，且f_eff
// 值大多在1.0附近。 短伽马射线暴（short GRBs）：由蓝色的
// 实心菱形表示。这些数据点主要分布在横轴小于2秒的区域，
// f_eff值分布较广，从约1.0到接近10。 GRB 060614：由一个
// 橙色的实心正方形特别标示出来。它位于横轴约10^2秒处，
// f_eff值约为1.5。 GRB 211211A：由一个红色的五角星特别标
// 示出来。它位于横轴约30-40秒处，f_eff值略高于1.0。 辅助
// 线与标注： 一条灰色的垂直虚线位于横轴T_90 = 2 s的位置，
// 作为区分长暴和短暴的分界线。 图的右上角有一个图例框，
// 说明了不同符号的含义：黑色菱形代表“long GRBs”，蓝色菱
// 形代表“short GRBs”，橙色方块代表“GRB 060614”，红色五角
// 星代表“GRB 211211A”。 趋势与结论： 该图显示了长暴和短
// 暴在T_90 - f_eff平面上大致分离的趋势，但也存在一些中间
// 态或异常事件，如被高亮显示的GRB 060614和GRB 211211A，
// 它们跨越了传统的分类界限。 子图 b： 这是一个散点图，叠
// 加了拟合曲线，用于展示峰值能量红移修正后（E_p(1+z)）与
// 各向同性等效辐射能量（E_gamma,iso）之间的相关性。 坐标
// 轴： 横轴（X轴）：标记为 E_gamma,iso (erg)，表示各向同
// 性等效辐射能量，单位为尔格（erg）。该轴采用对数标度，
// 范围从10^48到10^55，主刻度线位于10^48至10^55的每个数量
// 级。 纵轴（Y轴）：标记为 E_p(1+z) (keV)，表示经过红移
// 修正的峰值能量，单位为千电子伏特（keV）。该轴采用对数
// 标度，范围从10^0到10^4，主刻度线位于10^0至10^4的每个数
// 量级。 数据点与符号： Type-I GRBs（I型伽马射线暴，通常
// 指短暴）：由蓝色的十字形符号表示。这些点主要分布在图的
// 左上部分。 Type-II GRBs（II型伽马射线暴，通常指长暴）：
// 由黑色的十字形符号表示。这些点主要分布在图的右下部分，
// 显示出明显的正相关趋势。 GRB 060614的相关测量值：用橙
// 色空心符号表示。包括一个实心圆点（ME, 可能代表中值）、
// 一个实心方块（EE, 可能代表整个爆发）和一个空心圆圈（
// whole burst, 整个爆发）。 GRB 211211A的相关测量值：用
// 红色空心符号表示。包括一个实心五角星（ME）、一个实心圆
// 圈（EE）和一个空心圆圈（whole burst）。 拟合线与置信区
// 间： 针对Type-I GRBs（蓝色数据点），有一条蓝色的实线表
// 示最佳拟合线性关系，两侧有两条蓝色虚线表示对应的3σ置信
// 区间带。 针对Type-II GRBs（黑色数据点），有一条黑色的
// 实线表示最佳拟合线性关系，两侧有两条黑色虚线表示对应的
// 3σ置信区间带。 图例： 图的右下角有一个详细的图例框，解
// 释了所有符号的含义： 蓝色十字：Type-I GRBs 黑色十字：
// Type-II GRBs 橙色实心圆：ME of GRB 060614 橙色实心方块：
// EE of GRB 060614 橙色空心圆：whole burst of GRB 060614
// 红色实心五角星：ME of GRB 211211A 红色实心圆：EE of
// GRB 211211A 红色空心圆：whole burst of GRB 211211A 趋
// 势与结论： 该图展示了经典的Amati关系（对于长暴/Type-II）
// 以及短暴（Type-I）的不同相关性。GRB 060614和GRB
// 211211A这两个特殊事件的测量值被用来检验它们是否符合其
// 中某一种相关性，或者是否处于两者之间。从图中看，GRB
// 211211A的某些测量点似乎更靠近Type-II GRBs的相关性带。
#figure(placement: top, image("imgs/Figure_2.png", width: 100%),
  caption: [
    #strong[GRB 211211A in already classified clusters.] #strong[a], The $f_"eff"$ and $T_(upright(90))$ diagram. Long and short GRBs are presented by black and blue circles, respectively. The grey vertical line is the division line at 2 s. GRB 211211A and GRB 060614 are highlighted by the red star and orange square, respectively. #strong[b], The $E_(upright(p), upright(z))$ (or $E_(upright(p)) ( 1 + z )$) and $E_("gamma", "iso")$ correlation diagram. The best-fit correlations (solid lines) and corresponding 3$sigma$ confidence bands (dashed lines) are presented for Type-I (blue circles) and Type-II (black circles) GRB populations, respectively. The main emission (ME), extended emission (EE), and the whole burst for GRB 211211A (red) and GRB 060614 (orange) are highlighted by stars, squares, and circles, respectively. All error bars on data points represent their 1$sigma$ confidence level.
  ]
)
<fig:pvp>


// [figvision-cn] imgs/Figure_3.png
// 图a为双对数坐标的光变曲线图。横轴表示爆发后的天数（
// days after burst），范围从10的负3次方到10的2次方；纵轴
// 表示流量密度Fν，单位为毫央斯基（mJy），范围从10的负5次
// 方到10的2次方。图中包含四组数据系列：红色加号代表GRB
// 211211A在R波段的观测数据，蓝色加号代表GRB 060614在R波
// 段红移至z=0.076时的观测数据，黑色实线是GRB 211211A X射
// 线（1 keV）光变曲线的平滑断幂律拟合模型，品红色实线是
// GRB 060614 X射线（1 keV）光变曲线在红移z=0.076处的拟合
// 模型。此外，图中还有四条青色波浪线位于右上方，代表R波
// 段坍缩星模型的预测曲线。背景中有四条垂直的红色虚线，将
// 时间轴划分为四个区域，分别标注为I、II、III、IV。数据显
// 示，X射线流量随时间呈幂律衰减，而光学波段（R band）在
// 早期表现出快速衰减后进入平台期或缓慢衰减阶段。 图b为半
// 对数坐标的光子指数演化图。横轴与图a相同，为爆发后的天
// 数（days after burst），范围从10的负3次方到10的2次方；
// 纵轴为光子指数（photon index），线性刻度，范围从1到3。
// 图中红色十字标记代表GRB 211211A的光子指数测量值，蓝色
// 十字标记代表GRB 060614的对应测量值。两条水平实线分别表
// 示两个伽马暴在不同时间段内的平均光子指数及其误差范围。
// 整体趋势显示，光子指数在爆发初期较低（约1.5-2.0），随
// 后逐渐升高并趋于稳定（约1.8-2.0），表明辐射机制可能由
// 同步辐射主导转向其他过程。 图c为多波段光变曲线叠加图，
// 采用线性-对数混合坐标。横轴为爆发后的天数（days after
// burst），对数刻度，范围从10的负1次方到10的1次方以上；
// 纵轴为AB星等加上常数偏移量（AB magnitude + constant），
// 线性刻度，数值越小表示越亮，范围从15到35。图中包含多条
// 彩色曲线和对应颜色的散点数据，每种颜色代表一个特定波段，
// 包括紫外（UVM2+5, UVW1+4, U+3）、可见光（g+1, V, r-1,
// i-2, z-3, J-4, H-5, K-6）及近红外波段。实线表示“吸积盘
// +引擎驱动千新星”（AG + engine-fed kilonova）模型拟合结
// 果，虚线表示仅吸积盘（AG）模型。所有数据点均带有误差棒，
// 部分数据点以向下箭头表示上限限制。整体趋势显示，各波段
// 亮度随时间逐渐变暗，且长波长（如K-6）比短波长（如UVM2+
// 5）衰减更慢，符合热辐射冷却特征。模型曲线较好地覆盖了
// 观测数据，尤其在后期（>1天）吻合度较高。
#figure(placement: top, image("imgs/Figure_3.png", width: 100%),
  caption: [
    #strong[The multi-wavelength observations and fitting models.] #strong[a], The X-ray (1 keV) and $R$ band afterglows, and the $R$ band collapsars. The observed (fitted with the smoothed broken-power-law model) X-ray light curves for GRB 211211A and GRB 060614 are shown with red pluses (black lines) and blue pluses (magenta lines), respectively. The $R$ band observations for GRB 211211A and GRB 060614 are shown with red and blue solid circles (downward arrows for upper limits), respectively. The cyan lines represent the $R$ band collapsars, including SN 1998bw/GRB 980425, SN 2006aj/GRB 060218A, SN 2010bh/GRB 100316D. The vertical red dashed lines are drawn at the edges of each phase in the X-ray light curve of GRB 211211A. #strong[b], The evolution of X-ray photon index of GRB 211211A (red pluses) and GRB 060614 (blue pluses). #strong[c], The fittings to multi-wavelength observations. The detections and upper limits of the multi-wavelength data of GRB 211211A are shown with solid circles and downward arrows, respectively. The best-fit afterglow (AG) and AG plus engine-fed kilonova models are shown with dotted and solid lines, respectively.
  ]
)
<fig:agmnmodeling>

#emph[$T_90$ distributions]: To quantify how likely GRB 211211A and GRB 060614 are to belong to the short GRB population, we place their ME phases in the duration distributions of the GRB sample from the fourth #emph[Fermi]/GBM catalog @von_2020ApJ. In the first case, as shown in #ref(<fig:t90pdf>)a, we fit the $T_(upright(90))$ distribution of the short GRB ($T_(upright(90)) < 2 med upright(s)$) sample with a single log-normal distribution. Here we denote the normal distribution as $N ( mu , med sigma^2 )$, where $mu$ and $sigma$ are the mean and standard deviation of the normal distribution, respectively, all in logarithmic space. Based on the fitted normal distribution of $N ( - 0.27 , med 0.36^2 )$, the p-values corresponding to 6 s and 13 s are $1.73 times 10^(- 3)$ and $5.61 times 10^(- 5)$, respectively. This implies that GRB 060614 and GRB 211211A are rejected from being a short GRB with a confidence level of $2.92 sigma$ and $3.86 sigma$, respectively. In the second case, as shown in #ref(<fig:t90pdf>)b, we fit the $T_(upright(90))$ distribution of the whole sample with a two-component log-normal mixture model. The two components, namely $N ( - 0.24 , med 0.40^2 )$ and $N ( 1.40 , med 0.50^2 )$, are responsible for short and long GRB populations, respectively. Based on the fitted model, one can evaluate the probabilities for GRB 060614 and GRB 211211A to belong to the short GRB class (denoted as $P_"sGRB"$), which are $1.78 times 10^(- 2)$ and $7.68 times 10^(- 4)$, respectively. The confidence levels of rejecting GRB 060614 and GRB 211211A from the short GRB population are $2.57 sigma$ and $3.42 sigma$, respectively. In both cases, the probability of a GRB with $T_90 = 13$ s (the case of ME of GRB 211211A) is almost two orders of magnitude smaller than a GRB with $T_90 = 6$ s (the case of ME of GRB 060614), even though the difference in duration is only by a factor of two. And the $tilde 13$-s ME duration of GRB 211211A firmly rejects it from the short GRB category beyond the $3 sigma$ level.


#emph[Variability timescale]: To quantify the fluctuations of temporal profiles, we calculate the averaged variability time scales of the ME and EE phases. We apply the Bayesian block method @Scargle_2013ApJ to the un-binned event data of both ME and EE phases and take half of the averaged block size as the mean variability time scale @Vianello_2018ApJ. Our results yield $tau_"var" tilde 16$ ms for the ME phase and $tau_"var" tilde 48$ ms for the EE phase (@tab:summary), suggesting a much smoother time profile in the latter phase. The ME phase exhibits a three times smaller averaged variability time scale than that of the EE phase, implying two distinct physical origins of radiation.


#emph[Amplitude parameter]: The amplitude parameter@Lu_2014MNRAS is defined as $f = F_(upright(p)) / F_(upright(b))$, where $F_(upright(p))$ and $F_(upright(b))$ stand for the peak flux and background flux at the same epoch, respectively. In order to distinguish intrinsically short Type-I GRBs from disguised short-duration GRBs due to the tip-of-iceberg effect, an effective amplitude parameter, $f_"eff"$, for long-duration GRBs, can be defined as $f_"eff" = F'_(upright(p)) / F_(upright(b))$, which is the $f$ value of "pseudo GRBs" whose signal flux is re-scaled so that $T_90$ is shorter than 2 s. For short-duration GRBs, $f$ and $f_"eff"$ are the same by definition. Following the calculation procedure presented in Ref.@Lu_2014MNRAS, we obtain the effective amplitude as $f_"eff" = 1.24 plus.minus 0.07$ for GRB 211211A. Such a small $f_"eff"$ places GRB 211211A to be consistent with the long-duration GRBs in the $f_"eff" - T_(upright(90))$ diagram (#ref(<fig:pvp>)a), confirming the genuinely long-duration feature of the burst. On the contrary, the value of $f_"eff"$ of GRB 060614 is significantly higher than those of other long-duration GRBs (#ref(<fig:pvp>)a), supporting that it is an intrinsically short-duration Type-I GRB @Zhang_2007ApJ.


#emph[Spectral fitting]: We perform detailed time-resolved and time-integrated spectral fitting using the GBM data from detectors n2, na, and b0. According to the criterion that the average number of net photons per energy channel is not less than 20 @Zhang_2018NatAs, the time interval from $T_0 + 0.5$ to $T_0 + 70$ s is divided into 85 time slices for time-resolved spectral fitting. We additionally bracket three time slices for time-integrated spectral fitting, which span the ME phase, EE phase, and whole burst, respectively. For each time slice, the source and background spectra are acquired by summing the total photons and background photons for each energy channel, where the background photon number is derived by applying the baseline algorithm to each energy channel. The detector response matrix is generated by the #emph[gbm\_drm\_gen] package @Burgess_2018MNRAS @Berlato_2019ApJ. Then we use a self-developed software package, #emph[MySpecFit], to perform the spectral fitting. #emph[MySpecFit] employs the nested sampler #emph[Multinest] @Feroz_2008MNRAS @Feroz_2009MNRAS@Buchner_2014AandA@Feroz_2019OJAp as the fitting engine and PGSTAT @Arnaud_1996ASPC as the statistic to estimate uncertainties of the best-fit parameters. The cutoff power law (CPL) and band (Band @Band_1993ApJ) function are adopted to fit time-resolved spectra and time-integrated spectra, respectively. The CPL & Band models can be expressed as $ N ( E ) = A E^alpha "exp" ( - E / E_(upright(c)) ) $ and $ N (E) = cases(
  A (E \/ (100 "keV"))^alpha exp(-E \/ E_c), & E < (alpha - beta) E_c,
  A ((alpha - beta) E_c \/ (100 "keV"))^(alpha - beta) exp(beta - alpha) (E \/ (100 "keV"))^beta, & E >= (alpha - beta) E_c,
) $ respectively, where $alpha$ and $beta$ are low-energy and high-energy photon spectral indices. The peak energy $E_(upright(p))$ is related to the cut-off energy, $E_(upright(c))$, through $E_(upright(p)) = \( 2 + alpha \) E_(upright(c))$.


@tab:specfit lists the spectral fitting results as well as the corresponding energy fluxes between 10 and 1,000 keV. The time-integrated spectrum of the ME (EE) phase can be fitted by the Band model with spectral indices $alpha = - 0.996_(- 0.005)^(+ 0.005)$ $( - 0.97_(- 0.04)^(+ 0.03) )$, $beta = - 2.36_(- 0.02)^(+ 0.02)$ $( - 2.02_(- 0.02)^(+ 0.01) )$, and peak energy $E_(upright(p)) = 687.1_(- 11.0)^(+ 12.5)$ $( 82.0_(- 2.3)^(+ 3.8) )$ keV. Comparatively, the spectra in both phases are much harder than those in the ME and EE phases of GRB 060614 (@tab:summary). Thus, a soft extended emission cannot be attributed to the long-duration of GRB 211211A, as had been the case in GRB 060614. As shown in #ref(<fig:alpha_Ep_flux>)f, the time-resolved $E_(upright(p))$ distributes in a wide range between 60 keV and 1.9 MeV. The hardest time-resolved spectrum measured from $T_0 + 7.7$ to $T_0 + 7.8$ s corresponds to the 0.1-s peak flux of $1.38_(- 0.02)^(+ 0.02) times 10^(- 4)$ $"erg" thin "cm"^(- 2) thin s^(- 1)$. Summing up all the fluence values derived from time-resolved spectral fitting, we further calculate the total fluence to be $( 5.42 plus.minus 0.08 ) times 10^(- 4)$ $"erg" thin "cm"^(- 2)$.


#emph[Spectral evolution]: In #ref(<fig:anares>)d-f, both $alpha$ and $E_(upright(p))$ exhibit the same "flux-tracking" @Lu_2012ApJ @Li_2019ApJ evolution patterns simultaneously ("double-tracking") across the entire burst. The correlations between any pair of $alpha$, $E_(upright(p))$, and energy flux $F$ are fitted by using a linear model for both ME and EE phases, as well as the entire burst. We also fit the correlation between time-resolved rest-frame peak energy $E_(upright(p), upright(z)) = E_(upright(p)) ( 1 + z )$ and time-resolved isotropic energy $E_("gamma", "iso")$. The fitting process is implemented by the python module #emph[emcee]@Foreman_2013PASP. The fitting results are listed in @tab:alpha_Ep_flux and illustrated in @fig:alpha_Ep_flux. As shown in @tab:alpha_Ep_flux, the slopes between the ME and EE phases are generally consistent, suggesting that the two phases may share similar radiation mechanisms. Such spectral evolution suggests that the synchrotron model is the most likely explanation of GRB 211211A due to the following reasons: (1). As listed in @tab:specfit and plotted in #ref(<fig:alpha_Ep_flux>)e, the values of lower energy photon index, $alpha$, are typically distributed at $tilde - 1.2$ and never exceed the so-called line of death ($- 2 / 3$ @Preece_1998ApJ) of synchrotron radiation. Such an $alpha$ distribution is fully consistent with the synchrotron model but not consistent with the simplest photosphere model @Meszaros_2000ApJ, which predicts a thermal-like spectrum with a much harder $alpha$ above the synchrotron death line. To reproduce the soft spectrum as observed, one has to introduce some contrived new ingredients within the photosphere model framework @Deng_2014ApJ\; (2). The values of the slopes in $E_(upright(p)) prop F^k$ relation are $tilde 0.6$, which is consistent with the predicted relation of $E_(upright(p)) prop L^(1 / 2)$ by synchrotron models @Zhang_2002ApJ. Comparably, photosphere models predict $E_(upright(p)) prop L^(1 / 4)$ for $R_"ph" < R_(upright(s))$, and $E_(upright(p)) prop L^(- 5 / 12)$ for $R_"ph" > R_(upright(s))$, where $R_"ph"$ is photosphere radius and $R_(upright(s))$ is saturation radius @Meszaros_2000ApJ\; (3). The $alpha$ tracking behavior can be naturally interpreted as synchrotron radiation, as suggested by Ref.@Uhm_2014NatPh, and specifically, the one-zone Internal-Collision-induced MAgnetic Reconnection and Turbulence (ICMART) model @Zhang_2011ApJ.


#emph[Spectral lags]: Spectral lag refers to the systematic time delay of the soft-band light curve relative to the hard-band light curve. Type-II GRBs are often associated with significant spectral lags, whereas Type-I GRBs tend to have zero delays or even negative lags @Yi_2006MNRAS @Bernardini_2015MNRAS. We utilize the discrete cross-correlation function (DCCF @Norris_2000ApJ @Ukwatta_2010ApJ @Zhang_2012ApJ) to measure the cross-correlation between the light curves of the softest band and each harder band in #ref(<fig:wavelag>)a at different time delays. The DCCF values for different delays are fitted with a 3-order polynomial function to determine the spectral lag, which is defined as the time delay corresponding to the maximum cross-correlation. We calculate spectral lags separately for the ME phase ($T_0 + \[ - 0.5 , thin 14.0 \]$ s; #ref(<fig:wavelag>)b), EE phase ($T_0 + \[ 14.0 , thin 70.0 \]$ s; #ref(<fig:wavelag>)c), and whole burst ($T_0 + \[ - 0.5 , thin 70.0 \]$ s; #ref(<fig:wavelag>)d). #ref(<fig:wavelag>)b-d show that the spectral lags derived from GBM and BAT data are in good agreement with each other, although the former has smaller uncertainties. As a comparison, we obtain the lags of GRB 060614 from Ref.@Gehrels_2006Natur and also display them in #ref(<fig:wavelag>)b-c. We note that both GRBs exhibit tiny lags, a characteristic typically associated with Type-I GRBs @Yi_2006MNRAS @Bernardini_2015MNRAS @Shao_2017ApJ.


#emph[Amati relation]: In #ref(<fig:pvp>)b, we re-plot the $E_(upright(p), upright(z)) - E_("gamma", "iso")$ diagram (a.k.a. Amati relation @Amati_2002AandA) using the Type-I and Type-II GRBs with known redshifts @Amati_2002AandA@Zhang_2009ApJ, where $E_(upright(p), upright(z)) = E_(upright(p)) ( 1 + z )$ is the rest-frame peak energy and $E_("gamma", "iso")$ is the isotropic energy of prompt emission. We employ the python module #emph[emcee] @Foreman_2013PASP to fit the model $"log" E_(upright(p), upright(z)) = b + k "log" E_("gamma", "iso")$ to both GRB samples. The best-fitting parameters with 3$sigma$ uncertainties are $k = 0.45_(- 0.06)^(+ 0.05)$ and $b = - 19.85_(- 2.48)^(+ 2.87)$ for Type-I GRBs, and $k = 0.52_(- 0.02)^(+ 0.03)$ and $b = - 24.96_(- 1.45)^(+ 1.30)$ for Type-II GRBs. The best-fit correlations and corresponding 3$sigma$ confidence bands are presented in #ref(<fig:pvp>)b. Given a redshift of 0.076, the isotropic energy and peak luminosity of prompt emission of the burst can be calculated as $E_("gamma", "iso") = ( 7.61 plus.minus 0.11 ) times 10^51$ erg and $L_("gamma", upright(p)) = 1.94_(- 0.03)^(+ 0.03) times 10^51$ $"erg" thin s^(- 1)$, respectively. We over-plot GRB 211211A onto the $E_(upright(p), upright(z)) - E_("gamma", "iso")$ diagram. GRBs of different physical origins typically follow different tracks in such a diagram. We find that the whole burst of GRB 211211A resides in the area between the Type-I and Type-II GRB tracks. It is interesting to note that, similar to GRB 060614, the ME and the EE of GRB 211211A are located differently. As can be seen from #ref(<fig:pvp>)b, the ME phase of GRB 211211A follows the track of Type-I GRBs, while the EE phase follows the track of Type-II GRBs. We note that GRB 211211A systematically resides higher in the Amati relation and poses higher total energy and harder spectra in both the ME and EE phases, suggesting that, although the two bursts may share similar physical origins, GRB 211211A is likely a more intense event. Notice that all the above discussion is based on the assumption that the source is at $z = 0.076$ (Ref. @GCN31221 @Rastinejad_2022arXiv). This redshift was indirectly inferred. Even though the possibility that the source is at a much higher redshift is not ruled out, this redshift is consistent with an independent estimate based on the gamma-ray data @GCN31230. It also provides a self-consistent explanation for the galactic location, rapid optical fading, and red color of the source @GCN31235.


== Host galaxy. \
<host-galaxy.>


A candidate of the optical counterpart of GRB 211211A is reportedly located very close to a Sloan Digital Sky Survey galaxy (SDSS J140910.47+275320.8; #link("http://skyserver.sdss.org/dr12/en/tools/explore/summary.aspx")) with an offset of $R_"off" tilde.eq$ $5.50^('')$ @GCN31203 @GCN31221. This galaxy has a magnitude of $m$=19.53 mag in the $r$ band and a half-light radius of $R_50 = 0.61^('')$ @Adelman_2008ApJS. We assume that the surface distributions of galaxies and GRBs are uniform and follow Poisson distributions @Bloom_2002AJ @Stalder_2017ApJ. The probability of one or more random coincidences is given by $ P = 1 - e^(- lambda) approx lambda thin ( lambda tilde 0 ) , $ where $lambda$ is the expectation number of coincidences. To establish the associations between GRB 211211A, the afterglow candidates, and the SDSS galaxy, the probabilities of chance coincidence (PCC) that the afterglow candidates are unrelated to GRB 211211A (defined as $P_(upright("cc" 1))$), and that this galaxy is independent of the afterglow candidates (defined as $P_(upright("cc" 2))$) can be calculated as follows.


#emph[The calculation for $P_(upright("cc" 1))$]: To derive $P_(upright("cc" 1))$, $lambda$ can be regarded as the average number of GRBs occurring within a time window and sky area, and it is the product of the following three quantities:

- $r_1$: the detection rate of GRB over the whole sky. The latest #emph[Fermi]/GBM @von_2020ApJ and #emph[Swift]/BAT @Lien_2016ApJ burst catalogs provide 236 and 92.2 bursts per year detected by the two instruments, respectively. Considering the fact that $13.6 "%"$ of #emph[Fermi]/GBM bursts are co-detected by #emph[Swift]/BAT @Bhat_2016ApJS, we estimate a joint detection rate to be $r_1 tilde 0.8$ bursts per day over the whole sky.

- $r_2$: the ratio between the localization error circle and the whole sky. Using the localization uncertainty of $theta = 1^compose$ for GRB 211211A @GCN31201, one can calculate this ratio to be $r_2 = ( 1 - "cos" theta ) / 2 = 7.62 times 10^(- 5)$.

- $r_3$: the time window in which the GRB occurs prior to the optical afterglow. Based on the optical afterglow gallery @Kann_2011ApJ, we utilize a relatively long time window of one day ($r_3 = 1$) to avoid underestimating $P_(upright("cc" 1))$.

Based on the above values, one can calculate $P_(upright("cc" 1)) approx lambda = Pi_(upright(i = 1))^3 r_(upright(i))$ to be $6.09 times 10^(- 5)$. Such probability allows us to rule out a chance coincidence between the afterglow candidates and the burst at the $4.01 sigma$ confidence level.


#emph[The calculation for $P_(upright("cc" 2))$]: For $P_(upright("cc" 2))$, $lambda$ is the expected number of galaxies brighter than $m$ and within a circle with a radius of $Delta R$, and it can be derived by the two quantities:

- $sigma ( lt.eq m )$: the number density of galaxies brighter than $m$. Following Ref.@Berger_2010ApJ, we calculate the number density $sigma ( lt.eq m ) = 1.6 times 10^(- 4) thin "arcsec"^(- 2)$ based on the results of deep optical galaxy surveys @Hogg_1997MNRAS @Beckwith_2006AJ, i.e., $ sigma ( lt.eq m ) = frac(10^(0.33 ( m - 24 ) - 2.44), 0.33 times "ln" ( 10 )) thin "arcsec"^(- 2) . $

- $Delta R$: the maximum effective angular radius that the host galaxy is far from the optical counterpart. We take $Delta R approx ( R_"off"^2 + 4 R_50^2 )^(1 / 2) = 5.63$ arcsec based on the fact that the optical counterpart is outside of the galaxy @Bloom_2002AJ.

Therefore, we calculate $P_(upright("cc" 2))$ through $lambda = pi ( Delta R )^2 sigma ( lt.eq m )$ to be $1.60 times 10^(- 2)$, which is consistent with the result in Ref.@Rastinejad_2022arXiv. This value implies a random association between the optical counterpart and the galaxy can be ruled out at the $2.41 sigma$ level. We note that such a PCC is much smaller than those of other galaxies near the position of the GRB. Therefore, we take this galaxy as the host galaxy of GRB 211211A.


#emph[Offset]: Ref.@GCN31221 @Rastinejad_2022arXiv has reported a redshift of $z = 0.076$ of the host galaxy. Thus the offset in projection can be calculated as 8.19 kpc. And the normalized offset, defined by $R_"off" / R_50$, is 9.02. The large offset of GRB 211211A would be very peculiar if it were a Type-II GRB. On the other hand, Type-I GRBs have substantially larger offsets relative to the host galaxies than Type-II GRBs @Bloom_2002AJ @Fong_2013ApJ @Berger_2014ARAA, which is in agreement with the prediction of the merger origin of compact binary where the neutron star member undergoes a supernova "kick" as it forms. The offset (normalized offset) of GRB 211211A is larger than $tilde$70% ($tilde$85%) of the offsets (normalized offsets) of Type-I GRBs @Fong_2013ApJ. Therefore, GRB 211211A is more likely to originate from a compact star merger event based on its host galaxy information.


== Multi-wavelength afterglow. \
<multi-wavelength-afterglow.>


#emph[X-ray afterglow]: The #emph[Swift] X-ray Telescope (XRT @Burrows_2005SSRv) began to observe the BAT field from 69 s after the BAT trigger and identified a bright, uncatalogued X-ray source located at RA=$14^(upright(h)) 09^(upright(m)) 10.09^(upright(s))$ and DEC=$+ 27^compose 53' 18.8^('')$ (J2000) with an uncertainty of $2.1^('')$ @GCN31205. #ref(<fig:agmnmodeling>)a and #ref(<fig:agmnmodeling>)b shows the X-ray light curve and photon index evolution of GRB 211211A obtained from the #emph[Swift]/XRT GRB light curve repository (#link("https://www.swift.ac.uk/xrt_curves/")) and #emph[Swift]/XRT GRB spectrum repository (#link("https://www.swift.ac.uk/xrt_spectra/")), respectively. Note that we convert the 0.3--10 keV flux into the 1 keV flux density using the time-averaged photon index for each of both the Windowed Timing (WT) mode and Photon Counting (PC) mode. A convention of $f_nu prop t^(- alpha_(upright(X))) v^(- Gamma_(upright(X)) + 1)$ is employed here, where $alpha_(upright(X))$ is the decay slope of the light curve and $Gamma_(upright(X))$ is defined as the photon index of the X-ray spectrum. Due to the long gap between the WT mode and PC mode, we fit the light curves in WT and PC modes separately using a multi-segment smoothed broken-power-law (SBPL@Liang_2007ApJ @Xiao_2018ApJ) model. The fitting process is implemented by the python module #emph[emcee]@Foreman_2013PASP. We perform the model comparison based on the Bayesian information criterion@Schwarz_1978AnSta (BIC, defined as $"BIC" = - 2 "ln" cal(L) + k "ln" N$, where $cal(L)$ is the maximum likelihood, $k$ is the number of parameters of the model, and $N$ is the number of data points) and Akaike information criterion @Akaike1974 @sugiura1978 (here we use the variant AICc corrected for small sample sizes, defined as $"AICc" = - 2 "ln" cal(L) + 2 k + 2 k ( k + 1 ) / ( N - k - 1 )$). Generally speaking, the model with the lower BIC or AICc is the preferred model. The 2-segment SBPL can model the light curve in WT mode well. For the light curve in PC mode, the 3-segment SBPL model (stat/dof=40.81/46, BIC=64.52, AICc=54.68) provides a better fit than the 2-segment SBPL model (stat/dof=51.25/48, BIC=67.06, AICc=60.10) as shown in @fig:xrtfit. The differences in BIC and AICc between the 2-segment and 3-segment SBPL models are $Delta "BIC" = 2.54$ and $Delta "AICc" = 5.42$, respectively. Such "strength of evidence" (i.e., $Delta "BIC"$ and $Delta "AICc"$) positively supports the 3-segment SBPL model. Based on our fits, the X-ray light curve of GRB 211211A can be divided into four phases (#ref(<fig:agmnmodeling>)a). The time range, power-law decay index of the light curve ($alpha_(upright(X))$), and photon index of the spectrum ($Gamma_(upright(X))$) of each phase are listed in @tab:xprofile. These four phases match up well with a canonical GRB X-ray light curve@Zhang_2006ApJ @Nousek_2006ApJ. Details of each phase are further itemized below.


- Phase I -- the steep decay. The sharp decay slopes ($alpha_(upright(X)) gt.eq 3$) and strong spectral evolution can be interpreted by the higher latitude effect @Kumar_2000ApJ @Dermer_2004ApJ of the tail of the prompt emission with an intrinsically curved spectral shape @BBZhang_2007ApJ @BBZhang_2009ApJ. The spectra in Phase I were claimed to be consistent with the fast-cooling synchrotron emission@gompertz2022.

- Phase II -- the plateau. With a decay index $alpha_(upright(X)) tilde 0$, Phase II is a well-defined plateau, as seen in many previous GRB X-ray light curves. Physically speaking, X-ray plateaus can be divided into two categories, namely, external plateaus and internal plateaus. The external plateau is followed by a normal decay phase and can be interpreted by invoking a continuous energy injection caused by a long-lasting central engine @Dai_1998PhRvL @Zhang_2001ApJ or stratified ejecta @Rees_1998ApJ @Sari_2000ApJ within the external forward shock model @Zhang_2006ApJ @Nousek_2006ApJ. The internal plateaus are usually followed by a late-time steep decay segment and are inconsistent with the standard external shock model. One has to introduce an internal dissipation process (e.g., the formation of a black hole from a magnetar @Troja_2007ApJ @Lyons_2010MNRAS) to explain the sudden change of decay slopes. The plateau of GRB 211211A fits the former case as it is followed by a normal decay phase, and no significant spectral evolution is observed between the two phases (#ref(<fig:agmnmodeling>)b). This suggests that Phase II is likely powered by the continuous energy injection in an external shock. The leading scenario is that the energy injection is from a long-lasting central engine@Zhang_2006ApJ @Nousek_2006ApJ.

- Phase III -- the normal decay. With $alpha_(upright(X)) = 1.57$ and $Gamma_(upright(X)) = 1.54$, the normal decay phase is well consistent with the prediction of the standard external shock afterglow model @Zhang_2006ApJ @Nousek_2006ApJ.

- Phase IV -- post jet-break decay. A break appears at $tilde$ 0.8 days, a typical time as a jet break @Racusin_2009ApJ. The break is followed by a slightly steeper decay phase with $alpha_X tilde 3.33$ that lasts until $tilde$ 2 days. As modeled with the afterglow model (see below), we found a slightly off-axis afterglow from a structured jet succeeds in interpreting the observed data.


Comparatively, we analyze the #emph[Swift]/XRT light curve of GRB 060614 and list the fitting results in @tab:xprofile. We also re-scale the X-ray afterglow of GRB 060614 to the redshift of 0.076 and over-plot it in #ref(<fig:agmnmodeling>)a. We note that both bursts exhibit similar temporal and spectral profiles in the X-ray bands. Nevertheless, the flux of GRB 211211A is generally weaker than that of GRB 060614, except during the plateau phase in the X-ray band, when the energy injection of GRB 211211A is stronger but lasts for a shorter period of time.


#emph[Ultraviolet, optical, and near-infrared afterglows]: We collect all ultraviolet, optical, and near-infrared observations at the #emph[Swift]/XRT coordinate as listed in @tab:uvoniobs. The #emph[Swift] Ultraviolet and Optical Telescope (UVOT @Roming_2005SSRv) performed five rounds of observations in the field of GRB 211211A from 92 seconds to $tilde 3$ days after the BAT trigger @GCN31222. The UVOT data are obtained from the #emph[Swift] archive website (#link("https://www.swift.ac.uk/archive/ql.php")) and listed in @tab:uvoniobs. The white filter data in UVOT observations are excluded from this study due to its flat transmission function. Additionally, we only employ the tightest upper limit when several time bins are very close together. The detections and upper limits reported in GCN circulars (#link("https://gcn.gsfc.nasa.gov/other/211211A.gcn3")) by multiple facilities, including KAIT@GCN31203, MITSuME/Akeno@GCN31217, HCT@GCN31227, LCO/Sinistro@GCN31214, GMG@GCN31232, DOT@GCN31299, GIT@GCN31227, AbAO@GCN31233, Zeiss-1000@GCN31234, and TNG/NICS@GCN31242, are collected in @tab:uvoniobs. We also collect additional optical and near-infrared data from Ref.@Rastinejad_2022arXiv @Xiao2022arXiv and list the magnitudes uncorrected for foreground Galactic extinction in @tab:uvoniobs.


#ref(<fig:agmnmodeling>)a shows the $R$ band light curve of GRB 211211A. The initial 11-hour photometric data does not show significant decay. Afterward, it decays as a power law with an index of 1.00 until 1.56 days. The final two detections in the $R$ band indicate a fast power-law decay with an index of 2.80. We also collected the $R$ band light curve of GRB 060614 from Ref.@Gal-Yam_2006Natur @Fynbo_2006Natur and over-plot it in #ref(<fig:agmnmodeling>)a by re-scaling it to the redshift of 0.076. In comparison with GRB 060614, the optical afterglow of GRB 211211A has a similar temporal profile but is generally weaker by about one order of magnitude. Regarding the multi-band behavior, GRB 060614 appears to behave normally, whereas GRB 211211A shows a significant chromatic feature, that is, the light curves of different bands break at different times. Given that the breaks themselves are not of spectral origins (#ref(<fig:agmnmodeling>)b), the chromatic behavior cannot be interpreted by the standard external shock afterglow model, which predicts achromatic breaks. We will further show the deviation between the afterglow data and the standard model by modeling the multi-wavelength afterglows (see below).


== Non-detection of supernova. \
<non-detection-of-supernova.>


A robust association between Type-II GRBs and supernovae (SNe) has been established, and the smoking gun signature is the detection of characteristic spectral features of the supernova in the optical afterglow @Galama_1998Natur @Reeves_2002Natur @Hjorth_2003Natur. With a redshift of 0.076, if GRB 211211A were a Type-II GRB, a significant supernova component would be expected approximately ten days later. To examine the possibility of an association between GRB 211211A and a supernova, we obtain the quasi-bolometric unreddened rest-frame light curves of SN 1998bw from Ref.@Clocchiatti_2011AJ. We then apply a scale factor, $k$, and a stretch factor, $s$, to the template supernova, SN 1998bw, in order to obtain a specific supernova light curve. The observed flux density at redshift $z$ of the specific supernova can be described as $ F_nu^"SN" ( t_"obs" , nu_"obs" ) = frac(( 1 + z ) k, 4 pi d_(upright(L))^2) L_nu^"SN" ( frac(t_"obs", ( 1 + z ) s) , ( 1 + z ) nu_"obs" ) , $ where $d_(upright(L))$ is luminosity distance and $L_nu^"SN"$ is specific luminosity at frequency $nu$ of template supernova. In #ref(<fig:agmnmodeling>)a, we demonstrate the $R$ band light curves of three well-studied supernovae associated with Type-II GRBs, including the template SN 1998bw/GRB 980425, SN 2006aj/GRB 060218A ($s = 0.68$ and $k = 0.72$\; see Ref.@Cano_2013MNRAS) and SN 2010bh/GRB 100316D ($s = 0.60$ and $k = 0.40$\; see Ref.@Cano_2013MNRAS), by putting them at the redshift of GRB 211211A. The three supernovae cover a considerable range of luminosity, with SN 1998bw and SN 2010bh ranked the brightest and faintest GRB-SNe, respectively. The $R$ band afterglow of GRB 211211A decays so rapidly at 1--5 days that it is about two orders of magnitude fainter than the supernovae at this time, and there is still no sign of a supernova bump. The $R$ band upper limits at $tilde 10$ days further confirm the absence of supernova. The absence of a supernova associated with GRB 211211A rules out it being a typical Type-II GRB produced by the core collapse of a massive star.


== Identification of an engine-fed kilonova. \
<identification-of-an-engine-fed-kilonova.>


#emph[Fit with afterglow-only model]: The theoretical afterglow light curves are generated using the public python package #emph[Afterglowpy]@Ryan_2020ApJ, which can compute external forward shock synchrotron radiation and handle both the structured jet and off-axis-observer cases. We apply a Gaussian structured jet for our calculation. A model-dependent set of input parameters includes the isotropic kinetic energy ($E_(upright(k), "iso")$), viewing angle ($theta_(upright(v))$), Gaussian width of jet core ($theta_(upright(c))$), circumburst density ($n$), electron energy distribution index ($p$), and the fractions of shock energy that go to electrons ($epsilon.alt_(upright(e))$) and magnetic fields ($epsilon.alt_(upright(B))$). For a Gaussian structured jet, we provide a sensible value of 4$theta_(upright(c))$ to truncate the outer regions of the jet. To correct the data in @tab:uvoniobs for foreground Galactic extinction on the line of sight, we applied the F99 @Fitzpatrick_1999PASP model with a visual extinction to reddening ratio $R_(upright(V)) = 3.1$ to extinguish the flux density of the afterglow model, which is implemented with the #emph[dust-extinction] python package @Astropy_2013AA. We leave the color excess $E ( B - V )$ as a free parameter during the procedure.


The fitting of the observed data is based on the nested sampling algorithm by applying the Bayesian computation python package #emph[PyMultinest] @Buchner_2014AandA, with the log-likelihood function written as $ "ln" cal(L) = - 1 / 2 sum_(i = 1)^n [ frac(( O_i - M_i )^2, sigma_i^2 + v^2) + "ln" [ 2 pi ( sigma_i^2 + v^2 ) ] ] , $ where $O$, $M$, and $sigma$ stand for the observed magnitudes, modeled magnitudes, and uncertainties of observed magnitudes, respectively. The subscript $i$ represents the serial number for each observed and modeled value. An extra variance parameter $v$ is introduced to account for the variance of Gaussian distribution, which encompasses additional uncertainty in observed data. The log-likelihood function can be described as a one-sided Gaussian penalty term for upper limits. We utilize $- 2 "ln" cal(L)$ as a statistic to measure the goodness of modeling. To avoid the effect of energy injection, we only consider the afterglow after the X-ray plateau. Then we allow all model parameters to vary with typical but broad priors to search for the best fit for observed data.


Fitting the afterglow-only (AG-only) model with all the observed data, from X-ray to near-infrared, we find that significant residual errors exist even with the best-fit parameters, especially in the optical and near-infrared bands. Then, we exclude the observed data in the $r$, $i$, $J$, and $K$ bands and fit the rest again with the AG-only model. The best-fit AG-only model can explain the overall trends of the multi-wavelength light curves, in particular in the X-ray band. Nonetheless, significant disagreement between the observational data and the afterglow model at $t gt.tilde$ 1 day is observed in both optical and near-infrared wavelengths, as plotted in #ref(<fig:agmnmodeling>)c. These significant excesses indicate that other emission components are required to explain the observed data.


#emph[Fits with afterglow plus kilonova model]: Such kind of excess has long been considered as the existence of an underlying kilonova emission. Therefore, we investigate the afterglow plus kilonova (AG + KN) model to explain the significant excess observed in the optical and near-infrared bands of GRB 211211A.


In a WD-NS system, if the masses of the two components are comparable, the WD might not be totally disrupted and thrown around the NS right before the merger like a tidal disruption event. Instead, the NS might merge into the center of the WD and induce the collapse of the WD. During the collapsing, materials from the WD would be neutronized and mixed with the materials from the pre-merger NS. Later, a proto-magnetar would form, which is surrounded by a disk with neutron-rich materials. Therefore, the ejecta from the WD-NS merger consists of two components: a neutron-poor component from the dynamical process in the front and a neutron-rich component from the disk wind in the rear. Here we define a parameter $f_n = M_("ej", "disk") / ( M_("ej", "dyn") + M_("ej", "disk") )$ to describe the fraction of neutron-rich ejecta, where $M_("ej", "disk")$ and $M_("ej", "dyn")$ represent the masses of ejecta from the disk wind and dynamical process, respectively. R-process nucleosynthesis can happen inside the neutron-rich ejecta and power a kilonova emission@Li_1998ApJ @Metzger_2010MNRAS @Kasen_2013ApJ.


Since a post-merger magnetar has been introduced to explain the EE phase and the long-lasting plateau in the X-ray afterglow, a considerable amount of spin-down energy from the magnetar should be injected into both the dynamical and disk-wind ejecta. Therefore, instead of the r-process powered kilonova model, we employ an engine-fed kilonova model based on Ref.@Yu_2013ApJ. In this model, the spin-down energy is injected with an efficiency $xi$ while only a fraction $xi_(upright(t))$ can be directly deposited as the ejecta's internal energy. The detailed energy injection mechanism has been studied recently @Ai_2022arXiv in the framework of a shock system produced through the interaction between the magnetar wind and the ejecta, and the efficiencies have been quantitatively determined. In this work, we adopt $xi = 0.5$ and $xi_(upright(t)) = 0.03 e^(- 1 / tau)$, where $tau$ stands for the mean optical depth of the ejecta.


The light curve of the engine-fed kilonova depends on the properties of both the ejecta and magnetar. The parameters related to the ejecta include the total ejecta mass ($M_"ej"$), opacity ($kappa$), initial velocity ($v_"ej"$), and the fraction of neutron-rich ejecta ($f_(upright(n))$). The total ejecta mass and the fraction of neutron-rich ejecta determine how much radioactive energy would be generated. The ejecta mass would also highly influences the dynamics of the kilonova's radiation region. The opacity and velocity significantly influence the radiation transfer process and the subsequent thermal emission. Fixing the collapsing time of the newly born magnetar as 6,000 s (corresponding to the end time of the X-ray plateau), the energy injection from the central engine would only depend on the spin-down energy, in other words, the surface magnetic strength ($B$) and the initial spin period of the magnetar ($P_0$, fixing 1 ms).


Again, the AG + KN model is fitted to the full-band observed data with the python package #emph[PyMultinest] @Buchner_2014AandA. The best-fitting parameter values and their 1$sigma$ uncertainties for the afterglow and engine-fed kilonova are presented in @tab:agmnmodeling. The corner plot of posterior probability distributions of the parameters is exhibited in #ref(<fig:mnmodeling>)a. The modeled light curves of AG and AG + KN are plotted as dotted and solid lines in #ref(<fig:agmnmodeling>)c, respectively. As shown in #ref(<fig:mnmodeling>)b, the engine-fed kilonova model is successful in fitting the excesses in both optical and near-infrared bands.


As listed in @tab:agmnmodeling, the parameters of afterglow are generally consistent with the statistical results in Ref.@Wang_2015ApJS. With the aid of a clearly visible jet break in the X-ray afterglow, the jet opening angle $theta_(upright(c))$ can be well constrained. The viewing angle $theta_(upright(v)) tilde 2 theta_(upright(c))$ indicates that this burst was seen in a slightly off-axis manner. From the theoretical side, the properties of the merger ejecta are still poorly known because of the lack of numerical simulations on WD-NS mergers. According to our best-fitting values, the opacity of the ejecta ($kappa tilde 0.73 med upright(g) med "cm"^(- 2)$) is higher than the typical opacity due to the electron scattering ($kappa = 0.2 med upright(g) med "cm"^(- 2)$), but much lower than that for the neutron-rich materials ($kappa tilde 10 med upright(g) med "cm"^(- 2)$). It is consistent with our scenario that the whole ejecta is a mixture of neutron-rich and neutron-poor materials. Our best-fitting opacity can be regarded as an effective value.


== Interpretation to the extended emission. \
<interpretation-to-the-extended-emission.>


Since the EE has distinct temporal and spectral properties from the ME, a different physical mechanism is needed. For compact object mergers, if the merger product is a black hole, it is essentially impossible to maintain a roughly constant jet luminosity because of its small disk mass, short viscous timescale, and decaying accretion rate@rosswog07 @lu2022. A rapid-spin-powered BH engine scenario was mentioned in Ref.@vanputten14, but the specific mechanism has been only developed for long GRBs@vanputten12.


A natural mechanism to interpret EE for Type-I GRBs is to invoke a magnetar central engine@metzger08. The specific mechanism may be through invoking differential-rotation-induced magnetic bubbles as the mechanism for producing GRB prompt emission @Kluzniak_1998ApJ @Ruderman_2000ApJ @Dai_2006Sci @Zhang_2021NatAs. In such a model, the duration of a GRB is dependent on the number of bubbles and the interval between two bubble eruptions. Each magnetic bubble eruption follows the same process as described below. We consider a differentially rotating magnetar with an internal poloidal magnetic field $B_(upright(r)) = 10^13 thin G$ and an initial spin period $P_0 tilde 1$ ms. Here we take the convention that $Q_x = Q / 10^x$ and all the quantities are in the #emph[cgs] unit system. Due to differential rotation, $B_(upright(r))$ will be wound up into a toroidal magnetic field $B_(upright(phi."alt"))$ which increases as $d B_(upright(phi."alt")) / d t = Delta Omega B_(upright(r))$ @Dai_2006Sci, where $Delta Omega$, with an initial value of $2 pi / P_0$, is the differential angular velocity between the inner and outer parts of the magnetar. Continually amplified $B_(upright(phi."alt"))$ forms a magnetically confined toroid inside the magnetar to enclose some matter. When $B_(upright(phi."alt"))$ is amplified to a critical magnetic field@Kluzniak_1998ApJ $B_(upright(b)) approx 10^17 thin G$, the magnetic buoyant force can balance the antibuoyant stratification in magnetar composition, which corresponds to a critical time scale $tau_(upright(b)) = B_(upright(b)) / ( Delta Omega B_(upright(r)) ) tilde.eq 1.6 times B_(upright(r), upright(13))^(- 1) P_(upright(0), upright(- 3))$ s. Such a time scale corresponds to the interval between two bubble eruptions. As $B_(upright(phi."alt"))$ continues to increase after $tau_(upright(b))$, the buoyancy force will exceed the antibuoyant force. The magnetic toroid becomes unstable and floats up toward the magnetar surface due to excess buoyancy. The buoyancy time scale, during which the magnetic toroid floats up and penetrates through the magnetar surface, can be calculated as $Delta tau_(upright(b)) tilde.eq 8.4 times B_(upright(r), upright(13))^(- 1 / 3) P_(upright(0), upright(- 3))^(1 / 3)$ ms. Upon penetration through the magnetar surface, the toroidal fields may reconnect and give rise to an explosive event with energy $E_(upright(b)) = B_(upright(b))^2 V_(upright(b)) / 8 pi tilde.eq 1.6 times 10^50 thin xi_(upright(b), upright(- 1))$ erg, where $xi_(upright(b)) = V_(upright(b)) / V_(upright(s))$ is the ratio of the toroid's volume to the stellar volume. Such a reconnection process typically occurs within $tilde 10^(- 4)$ s, corresponding to the large fluctuations as observed in the observations. A magnetar with an initial differential kinetic energy of $tilde 3 times 10^51$ erg is capable of producing $tilde 30$ similar eruptions. It yields a temporal profile consisting of several sub-bursts with a total duration of $tilde 50$ s, which is in agreement with the observed EE phase of GRB 211211A. Once this event is over, a similar process described above will lead to another explosion as long as $Delta Omega$ remains large enough. Once the differential kinetic is exhausted or no longer supports another wind-up of the toroidal magnetic field, the millisecond magnetar can continue to lose its rotation energy through magnetic dipole radiation. Such a model predicts that the different pulses of the EE are locally generated in small emission regions and are independent of one another, so the spectral lag of the EE will be small. Such a prediction is consistent with that observed in GRB 211211A.


== Spin-down luminosity. \
<spin-down-luminosity.>
The spin-down power of magnetar from magnetic dipole radiation has successfully explained the energy injection in the plateau phase @Zhang_2006ApJ @Nousek_2006ApJ. For a millisecond magnetar, the spin-down luminosity due to the magnetic dipole radiation can be calculated as @shapiro83 @Zhang_2001ApJ $ L_("sd,m") = frac(eta B_"p"^2 R_"s"^6 Omega^4, 6 c^3) approx 10^46 "erg s"^(-1) eta_(-3) B_("p,15")^2 R_("s,6")^6 P_(0,-3)^(-4) $ where $B_(upright(p))$ represents the strength of the surface dipolar magnetic field of the magnetar, $R_(upright(s))$ stands for the radius of the magnetar, $eta$ is the efficiency of converting the magnetar wind energy into X-ray radiation @Xiao_2019ApJ @Xiao_2019ApJL, and $c$ is the speed of light. To explain the observed luminosity of $tilde 10^45$ $"erg" thin s^(- 1)$ during the X-ray plateau of GRB 211211A, a surface dipolar magnetic field $B_(upright(p)) approx 3 times 10^14$ G is required.


== Special properties of the WD-NS merger. \
<special-properties-of-the-wd-ns-merger.>
Since the WD-NS merger rate is much higher than the NS-NS merger rate and since the rate density of GRB 211211A is much smaller than that of short GRBs, an inevitable conclusion is that only a rare type of WD-NS mergers can make GRBs. We suggest that the preferred systems that can make GRBs are those with a mass ratio close to unity. In other words, the WD needs to be massive and close to the Chandrasekhar limit. Such a WD is compact and is the progenitor of the accretion-induced collapse (AIC) model for GRBs@fryer99. Before the merger, a small amount of WD mass (which is neutron poor) would be tidally ejected. The majority of the mass would undergo collapse and neutralization after the NS enters the interior of the WD because of the huge excess gravity provided by the NS. Because of the large orbital angular momentum, the WD undergoes AIC to form a massive NS surrounded by a massive accretion disk. A neutron-rich wind is subsequently launched from such a system, similar to the AIC model for GRBs@fryer99, which provides the necessary neutron-rich ejecta to power the kilonova. The product of such a merger carries a significant angular momentum. The magnetic field of the post-merger product depends on the magnetic field strengths of the NS and the WD, but additional amplification is possible due to the $alpha - Omega$ dynamo. A millisecond magnetar is a likely outcome.


== Other progenitor models. \
<other-progenitor-models.>
NS-NS@Paczynski1986 @Eichler1989 and BH-NS@Paczynski1991 mergers have been proposed to power short GRBs. Both types of engines have difficulties interpreting GRB 211211A. The product of a BH-NS merger system must be a BH. Since the NS matter has a very high density, it is very difficult to power a GRB with a duration longer than 2 s, let alone to produce both a 13-s ME and a 55-s EE with distinct emission properties, as well as an X-ray plateau lasting up to $tilde$ 6,000 s. An NS-NS merger can produce a magnetar central engine, but it is difficult to interpret the much longer ME than all other short GRBs or short GRBs with EE, which are believed to be due to NS-NS mergers. A WD-WD merger model was proposed to interpret the kilonova emission associated with GRB 170817A@Rueda2018. However, this model cannot interpret the gravitational wave data, which pointed toward an NS-NS merger. For GRB 211211A, the WD-WD merger model predicts too high an event rate, and it is unclear whether a rapidly spinning magnetar can be formed as the consequence of the merger. Another interesting possibility is the r-process enhanced collapsar model@Siegel2019. However, such a collapsar event is expected to be associated with a bright supernova, which is not observed in association with GRB 211211A. The same objection applies to the model that interprets the infrared hump as evidence of dust echo of a standard long GRB@waxman22. In order to avoid this apparent issue, Ref.@waxman22 invokes another galaxy, SDSS J140909.60+275325.8 (hereafter G2) at redshift $z = 0.459$, in the GRB field of view as the GRB host galaxy. However, the chance coincidence probability $P_("cc", upright(G 2)) = 0.15$ between GRB 211211A and G2 is much higher than that between GRB 211211A and SDSS J140910.47+275320.8 (G1), the host galaxy candidate adopted in our paper and all other papers on GRB 211211A. Furthermore, if G2 is the host galaxy, the location of GRB 211211A has a physical offset of 61.81 kpc and a normalized offset of 36.78 from the host. These numbers are inconsistent with long GRBs and even short GRBs. At such a large offset, it is essentially impossible to have a massive star and a dusty environment to support the suggested dust echo model. We, therefore, conclude that a WD-NS merger provides the best interpretation for the broad-band observations of GRB 211211A.


#heading(level: 1, numbering: none)[Data Availability]
<data-availability>


The processed data are presented in the tables and figures of the paper, which are available upon reasonable request. The authors point out that the data used in the paper are publicly available, whether through #emph[Fermi]/GBM data archive, #emph[Swift] data archive, or GCN circulars.


#heading(level: 1, numbering: none)[Code Availability]
<code-availability>
Upon reasonable requests, the code (mostly in python) used to produce the results and figures will be provided.





#block[
]


This work is supported by the National Key Research and Development Programs of China (2018YFA0404204), the National Natural Science Foundation of China (Grant Nos. 11833003, U2038105, 12121003, 11922301, 12041306, 12103089), the science research grants from the China Manned Space Project with NO.CMS-CSST-2021-B11, the Natural Science Foundation of Jiangsu Province (Grant No. BK20211000), and the Program for Innovative Talents, Entrepreneur in Jiangsu. S.-K.A. and B.Z. acknowledge support of the Top Tier Doctoral Graduate Research Assistantship (TTDGRA) and Nevada Center for Astrophysics at the University of Nevada, Las Vegas. We acknowledge the use of public data from the #emph[Fermi] Science Support Center, #emph[Swift] Science Data Centre, and GCN circulars reported by multiple facilities. We thank Yan-Zhi Meng and Zong-Kai Peng for helpful comments.





B.-B.Z. and J.Y. initiated the study. B.-B.Z., B.Z., J.Y., and S.A. coordinated the scientific investigations of the event. J.Y. processed and analyzed the #emph[Fermi]/GBM and #emph[Swift] data. J.Y. and Z.-K.L. calculated the spectral lags. J.Y., X.I.W., and H.-J.L. calculated the amplitude parameter. J.Y., Y.-H.Yang, and Y.-H.Yin fitted the Amati relation. J.Y. and Y.L. contributed to the information about the host galaxy. J.Y. contributed to the afterglow analysis and modeling. S.A. provided the engine-fed kilonova model. J.Y. and S.A. performed theoretical modeling of the engine-fed kilonova. J.Y. and S.A. contributed to the magnetic bubble and spin-down models. B.Z. and S.A. developed the WD-NS merger scenario. B.Z., S.A., and J.Y. investigated other progenitor models. J.Y., B.-B.Z., B.Z., and S.A. wrote the manuscript with contributions from all authors.


The authors declare that they have no competing financial interests.


Correspondence and requests for materials should be addressed to B.-B.Z. and B.Z.










#figure({
  set text(size: 5pt)
  set table(inset: (x: 1pt, y: 3.3pt))
  align(center, table(
    columns: 12,
    align: (center,center,center,left,center,center,center,center,center,left,center,center,),
    table.header([t1 (s)], [t2 (s)], [$alpha$ ($beta$)], [$E_(upright(p))$ (keV)], [flux ($"erg" thin "cm"^(- 2) thin s^(- 1)$)], [pgstat/dof], [t1 (s)], [t2 (s)], [$alpha$], [$E_(upright(p))$ (keV)], [flux ($"erg" thin "cm"^(- 2) thin s^(- 1)$)], [pgstat/dof],),
    table.hline(),
    table.cell(rowspan: 2)[0.500], table.cell(rowspan: 2)[13.000], [$- 0.996_(- 0.005)^(+ 0.005)$], table.cell(rowspan: 2)[$687.1_(- 11.0)^(+ 12.5)$], table.cell(rowspan: 2)[$3.02_(- 0.01)^(+ 0.01) times 10^(- 5)$], table.cell(rowspan: 2)[2,399.59/361], table.cell(rowspan: 2)[10.900], table.cell(rowspan: 2)[11.200], [$- 1.10_(- 0.04)^(+ 0.04)$], table.cell(rowspan: 2)[$323.9_(- 22.0)^(+ 33.2)$], table.cell(rowspan: 2)[$1.52_(- 0.04)^(+ 0.06) times 10^(- 5)$], table.cell(rowspan: 2)[332.01/362],
    [\($- 2.36_(- 0.02)^(+ 0.02)$)], [],
    table.cell(rowspan: 2)[15.000], table.cell(rowspan: 2)[70.000], [$- 0.97_(- 0.04)^(+ 0.03)$], table.cell(rowspan: 2)[$82.0_(- 2.3)^(+ 3.8)$], table.cell(rowspan: 2)[$2.92_(- 0.02)^(+ 0.01) times 10^(- 6)$], table.cell(rowspan: 2)[883.32/361], table.cell(rowspan: 2)[11.200], table.cell(rowspan: 2)[11.700], [$- 1.20_(- 0.05)^(+ 0.04)$], table.cell(rowspan: 2)[$242.8_(- 20.4)^(+ 30.9)$], table.cell(rowspan: 2)[$8.16_(- 0.30)^(+ 0.35) times 10^(- 6)$], table.cell(rowspan: 2)[317.85/362],
    [\($- 2.02_(- 0.02)^(+ 0.01)$)], [],
    table.cell(rowspan: 2)[0.500], table.cell(rowspan: 2)[70.000], [$- 1.20_(- 0.01)^(+ 0.01)$], table.cell(rowspan: 2)[$399.3_(- 16.1)^(+ 14.0)$], table.cell(rowspan: 2)[$7.24_(- 0.03)^(+ 0.04) times 10^(- 6)$], table.cell(rowspan: 2)[2,648.05/361], table.cell(rowspan: 2)[11.700], table.cell(rowspan: 2)[12.200], [$- 1.21_(- 0.04)^(+ 0.05)$], table.cell(rowspan: 2)[$269.4_(- 24.5)^(+ 30.7)$], table.cell(rowspan: 2)[$8.54_(- 0.31)^(+ 0.33) times 10^(- 6)$], table.cell(rowspan: 2)[297.89/362],
    [\($- 2.05_(- 0.02)^(+ 0.02)$)], [],
    [0.500], [2.400], [$- 1.27_(- 0.08)^(+ 0.05)$], [$300.3_(- 39.3)^(+ 102.9)$], [$2.01_(- 0.11)^(+ 0.16) times 10^(- 6)$], [204.38/362], [12.200], [14.000], [$- 1.35_(- 0.05)^(+ 0.05)$], [$164.3_(- 13.6)^(+ 24.5)$], [$2.60_(- 0.10)^(+ 0.14) times 10^(- 6)$], [291.13/362],
    [2.400], [3.100], [$- 1.12_(- 0.03)^(+ 0.02)$], [$851.4_(- 65.4)^(+ 108.2)$], [$1.39_(- 0.02)^(+ 0.02) times 10^(- 5)$], [303.82/362], [14.000], [15.900], [$- 1.43_(- 0.08)^(+ 0.04)$], [$155.1_(- 12.4)^(+ 40.2)$], [$1.97_(- 0.07)^(+ 0.16) times 10^(- 6)$], [259.65/362],
    [3.100], [3.400], [$- 0.96_(- 0.02)^(+ 0.02)$], [$997.7_(- 49.4)^(+ 66.7)$], [$4.91_(- 0.06)^(+ 0.07) times 10^(- 5)$], [393.99/362], [15.900], [17.400], [$- 1.29_(- 0.05)^(+ 0.04)$], [$167.4_(- 12.2)^(+ 22.1)$], [$3.36_(- 0.11)^(+ 0.17) times 10^(- 6)$], [336.08/362],
    [3.400], [3.500], [$- 0.87_(- 0.02)^(+ 0.02)$], [1,593.6$""_(- 84.1)^(+ 85.8)$], [$1.26_(- 0.02)^(+ 0.02) times 10^(- 4)$], [440.78/362], [17.400], [18.000], [$- 1.24_(- 0.05)^(+ 0.04)$], [$230.5_(- 21.4)^(+ 28.8)$], [$6.56_(- 0.25)^(+ 0.29) times 10^(- 6)$], [289.01/362],
    [3.500], [3.700], [$- 0.95_(- 0.02)^(+ 0.02)$], [$923.1_(- 60.0)^(+ 60.8)$], [$5.74_(- 0.10)^(+ 0.07) times 10^(- 5)$], [377.34/362], [18.000], [18.300], [$- 1.08_(- 0.04)^(+ 0.04)$], [$319.0_(- 22.4)^(+ 32.2)$], [$1.39_(- 0.04)^(+ 0.05) times 10^(- 5)$], [301.40/362],
    [3.700], [3.800], [$- 0.86_(- 0.03)^(+ 0.02)$], [$999.2_(- 56.5)^(+ 82.2)$], [$8.60_(- 0.15)^(+ 0.16) times 10^(- 5)$], [379.22/362], [18.300], [18.800], [$- 1.13_(- 0.05)^(+ 0.05)$], [$193.5_(- 13.8)^(+ 18.4)$], [$6.85_(- 0.23)^(+ 0.30) times 10^(- 6)$], [285.09/362],
    [3.800], [4.100], [$- 0.99_(- 0.03)^(+ 0.02)$], [$528.0_(- 27.9)^(+ 32.6)$], [$3.31_(- 0.07)^(+ 0.05) times 10^(- 5)$], [402.86/362], [18.800], [19.300], [$- 1.20_(- 0.03)^(+ 0.03)$], [$380.7_(- 28.9)^(+ 43.8)$], [$1.29_(- 0.04)^(+ 0.04) times 10^(- 5)$], [365.17/362],
    [4.100], [4.315], [$- 1.03_(- 0.03)^(+ 0.04)$], [$433.8_(- 30.9)^(+ 35.0)$], [$2.26_(- 0.06)^(+ 0.06) times 10^(- 5)$], [323.71/362], [19.300], [19.800], [$- 1.14_(- 0.04)^(+ 0.03)$], [$294.3_(- 22.2)^(+ 30.0)$], [$1.03_(- 0.04)^(+ 0.03) times 10^(- 5)$], [363.09/362],
    [4.315], [4.500], [$- 0.92_(- 0.03)^(+ 0.02)$], [$590.8_(- 30.6)^(+ 41.7)$], [$4.21_(- 0.10)^(+ 0.08) times 10^(- 5)$], [337.54/362], [19.800], [20.200], [$- 1.13_(- 0.04)^(+ 0.03)$], [$370.7_(- 29.6)^(+ 36.8)$], [$1.46_(- 0.04)^(+ 0.04) times 10^(- 5)$], [366.96/362],
    [4.500], [4.700], [$- 0.96_(- 0.02)^(+ 0.02)$], [$775.6_(- 46.8)^(+ 45.4)$], [$5.61_(- 0.09)^(+ 0.09) times 10^(- 5)$], [386.44/362], [20.200], [20.900], [$- 1.22_(- 0.04)^(+ 0.03)$], [$260.3_(- 16.5)^(+ 24.6)$], [$9.06_(- 0.22)^(+ 0.31) times 10^(- 6)$], [303.95/362],
    [4.700], [4.900], [$- 0.98_(- 0.04)^(+ 0.03)$], [$442.3_(- 25.5)^(+ 35.6)$], [$2.75_(- 0.06)^(+ 0.07) times 10^(- 5)$], [336.71/362], [20.900], [21.330], [$- 1.15_(- 0.07)^(+ 0.05)$], [$201.6_(- 13.6)^(+ 28.5)$], [$7.05_(- 0.24)^(+ 0.42) times 10^(- 6)$], [296.20/362],
    [4.900], [5.100], [$- 0.91_(- 0.04)^(+ 0.02)$], [$734.9_(- 26.5)^(+ 70.6)$], [$4.83_(- 0.08)^(+ 0.09) times 10^(- 5)$], [365.44/362], [21.330], [21.800], [$- 1.18_(- 0.05)^(+ 0.06)$], [$163.4_(- 13.2)^(+ 15.6)$], [$5.84_(- 0.24)^(+ 0.26) times 10^(- 6)$], [312.70/362],
    [5.100], [5.300], [$- 0.87_(- 0.03)^(+ 0.03)$], [$534.1_(- 28.8)^(+ 29.4)$], [$4.32_(- 0.10)^(+ 0.06) times 10^(- 5)$], [323.32/362], [21.800], [22.200], [$- 1.15_(- 0.04)^(+ 0.04)$], [$302.3_(- 23.4)^(+ 35.7)$], [$1.06_(- 0.03)^(+ 0.04) times 10^(- 5)$], [334.77/362],
    [5.300], [5.800], [$- 1.30_(- 0.04)^(+ 0.04)$], [$223.4_(- 18.9)^(+ 28.6)$], [$7.40_(- 0.27)^(+ 0.32) times 10^(- 6)$], [326.06/362], [22.200], [22.900], [$- 1.15_(- 0.04)^(+ 0.03)$], [$207.3_(- 11.8)^(+ 14.7)$], [$8.36_(- 0.23)^(+ 0.25) times 10^(- 6)$], [355.29/362],
    [5.800], [6.105], [$- 1.20_(- 0.04)^(+ 0.04)$], [$300.8_(- 27.1)^(+ 37.0)$], [$1.17_(- 0.04)^(+ 0.05) times 10^(- 5)$], [326.81/362], [22.900], [23.400], [$- 1.21_(- 0.04)^(+ 0.05)$], [$166.7_(- 12.1)^(+ 13.5)$], [$7.11_(- 0.24)^(+ 0.27) times 10^(- 6)$], [312.39/362],
    [6.105], [6.500], [$- 1.10_(- 0.02)^(+ 0.03)$], [$411.4_(- 25.1)^(+ 24.9)$], [$2.28_(- 0.05)^(+ 0.05) times 10^(- 5)$], [363.45/362], [23.400], [23.730], [$- 1.19_(- 0.05)^(+ 0.04)$], [$231.7_(- 19.2)^(+ 26.3)$], [$9.85_(- 0.36)^(+ 0.42) times 10^(- 6)$], [298.87/362],
    [6.500], [6.700], [$- 0.95_(- 0.02)^(+ 0.02)$], [$841.7_(- 46.3)^(+ 52.4)$], [$7.13_(- 0.09)^(+ 0.11) times 10^(- 5)$], [458.43/362], [23.730], [24.200], [$- 1.21_(- 0.05)^(+ 0.04)$], [$217.1_(- 16.8)^(+ 23.6)$], [$8.22_(- 0.25)^(+ 0.36) times 10^(- 6)$], [322.31/362],
    [6.700], [6.800], [$- 0.90_(- 0.02)^(+ 0.01)$], [1,511.6$""_(- 67.1)^(+ 64.6)$], [$1.37_(- 0.02)^(+ 0.02) times 10^(- 4)$], [469.41/362], [24.200], [24.500], [$- 1.19_(- 0.04)^(+ 0.04)$], [$305.1_(- 27.4)^(+ 32.6)$], [$1.27_(- 0.04)^(+ 0.04) times 10^(- 5)$], [291.18/362],
    [6.800], [6.875], [$- 0.93_(- 0.03)^(+ 0.02)$], [1,055.5$""_(- 65.7)^(+ 84.0)$], [$1.07_(- 0.02)^(+ 0.02) times 10^(- 4)$], [396.71/362], [24.500], [25.000], [$- 1.11_(- 0.03)^(+ 0.03)$], [$285.6_(- 15.4)^(+ 23.0)$], [$1.31_(- 0.03)^(+ 0.04) times 10^(- 5)$], [337.06/362],
    [6.875], [6.965], [$- 0.95_(- 0.03)^(+ 0.03)$], [1,021.6$""_(- 67.2)^(+ 86.6)$], [$8.84_(- 0.16)^(+ 0.17) times 10^(- 5)$], [362.51/362], [25.000], [25.400], [$- 1.07_(- 0.05)^(+ 0.06)$], [$167.5_(- 11.1)^(+ 13.4)$], [$7.66_(- 0.27)^(+ 0.30) times 10^(- 6)$], [295.48/362],
    [6.965], [7.100], [$- 0.98_(- 0.02)^(+ 0.02)$], [1,486.8$""_(- 80.1)^(+ 89.0)$], [$9.83_(- 0.12)^(+ 0.17) times 10^(- 5)$], [502.24/362], [25.400], [25.800], [$- 1.13_(- 0.06)^(+ 0.05)$], [$160.5_(- 10.6)^(+ 15.3)$], [$7.21_(- 0.24)^(+ 0.32) times 10^(- 6)$], [285.70/362],
    [7.100], [7.300], [$- 1.05_(- 0.02)^(+ 0.03)$], [$765.9_(- 58.1)^(+ 65.1)$], [$4.89_(- 0.08)^(+ 0.08) times 10^(- 5)$], [465.77/362], [25.800], [26.400], [$- 1.21_(- 0.04)^(+ 0.04)$], [$225.7_(- 15.0)^(+ 24.3)$], [$8.05_(- 0.22)^(+ 0.34) times 10^(- 6)$], [304.57/362],
    [7.300], [7.500], [$- 1.00_(- 0.03)^(+ 0.02)$], [$800.3_(- 49.5)^(+ 75.0)$], [$5.08_(- 0.07)^(+ 0.09) times 10^(- 5)$], [406.72/362], [26.400], [27.000], [$- 1.31_(- 0.05)^(+ 0.05)$], [$174.9_(- 14.4)^(+ 23.6)$], [$5.76_(- 0.20)^(+ 0.30) times 10^(- 6)$], [279.77/362],
    [7.500], [7.610], [$- 0.96_(- 0.03)^(+ 0.02)$], [1,035.8$""_(- 67.5)^(+ 83.9)$], [$6.98_(- 0.17)^(+ 0.11) times 10^(- 5)$], [431.29/362], [27.000], [28.000], [$- 1.14_(- 0.08)^(+ 0.06)$], [$103.7_(- 5.8)^(+ 8.5)$], [$2.77_(- 0.09)^(+ 0.12) times 10^(- 6)$], [268.42/362],
    [7.610], [7.700], [$- 0.85_(- 0.02)^(+ 0.02)$], [1,136.8$""_(- 59.8)^(+ 61.4)$], [$1.16_(- 0.02)^(+ 0.02) times 10^(- 4)$], [487.18/362], [28.000], [28.900], [$- 1.18_(- 0.07)^(+ 0.05)$], [$133.9_(- 8.0)^(+ 13.8)$], [$3.71_(- 0.11)^(+ 0.17) times 10^(- 6)$], [293.07/362],
    [7.700], [7.800], [$- 0.94_(- 0.01)^(+ 0.02)$], [1,920.8$""_(- 93.8)^(+ 77.6)$], [$1.38_(- 0.02)^(+ 0.02) times 10^(- 4)$], [484.62/362], [28.900], [30.400], [$- 1.26_(- 0.06)^(+ 0.06)$], [$85.9_(- 4.2)^(+ 5.2)$], [$2.58_(- 0.07)^(+ 0.08) times 10^(- 6)$], [267.26/362],
    [7.800], [7.870], [$- 0.84_(- 0.02)^(+ 0.02)$], [1,352.4$""_(- 79.0)^(+ 69.5)$], [$1.38_(- 0.02)^(+ 0.03) times 10^(- 4)$], [420.36/362], [30.400], [31.500], [$- 1.20_(- 0.08)^(+ 0.09)$], [$83.6_(- 5.4)^(+ 7.0)$], [$2.05_(- 0.07)^(+ 0.09) times 10^(- 6)$], [280.33/362],
    [7.870], [8.000], [$- 0.89_(- 0.02)^(+ 0.02)$], [1,021.6$""_(- 43.4)^(+ 67.0)$], [$1.00_(- 0.01)^(+ 0.01) times 10^(- 4)$], [371.07/362], [31.500], [32.305], [$- 1.40_(- 0.08)^(+ 0.06)$], [$88.90_(- 6.8)^(+ 9.8)$], [$2.51_(- 0.09)^(+ 0.13) times 10^(- 6)$], [254.40/362],
    [8.000], [8.100], [$- 0.89_(- 0.02)^(+ 0.02)$], [1,464.1$""_(- 60.2)^(+ 78.3)$], [$1.35_(- 0.02)^(+ 0.02) times 10^(- 4)$], [451.51/362], [32.305], [33.300], [$- 1.44_(- 0.08)^(+ 0.07)$], [$90.1_(- 6.6)^(+ 12.2)$], [$2.11_(- 0.08)^(+ 0.13) times 10^(- 6)$], [245.51/362],
    [8.100], [8.200], [$- 0.90_(- 0.03)^(+ 0.03)$], [$864.6_(- 53.2)^(+ 56.2)$], [$8.36_(- 0.16)^(+ 0.14) times 10^(- 5)$], [386.92/362], [33.300], [35.300], [$- 1.17_(- 0.07)^(+ 0.06)$], [$91.4_(- 4.3)^(+ 7.1)$], [$1.73_(- 0.05)^(+ 0.07) times 10^(- 6)$], [255.59/362],
    [8.200], [8.400], [$- 0.89_(- 0.02)^(+ 0.02)$], [$766.2_(- 34.1)^(+ 45.3)$], [$7.05_(- 0.11)^(+ 0.09) times 10^(- 5)$], [453.50/362], [35.300], [36.600], [$- 1.35_(- 0.05)^(+ 0.05)$], [$153.8_(- 12.4)^(+ 21.3)$], [$2.93_(- 0.10)^(+ 0.15) times 10^(- 6)$], [298.30/362],
    [8.400], [8.500], [$- 0.84_(- 0.03)^(+ 0.02)$], [$965.8_(- 47.3)^(+ 60.5)$], [$9.99_(- 0.18)^(+ 0.16) times 10^(- 5)$], [354.00/362], [36.600], [37.380], [$- 1.27_(- 0.07)^(+ 0.06)$], [$147.7_(- 12.1)^(+ 21.9)$], [$3.33_(- 0.13)^(+ 0.20) times 10^(- 6)$], [272.55/362],
    [8.500], [8.700], [$- 0.95_(- 0.02)^(+ 0.02)$], [$654.4_(- 33.4)^(+ 41.7)$], [$5.38_(- 0.09)^(+ 0.09) times 10^(- 5)$], [402.11/362], [37.380], [38.500], [$- 1.25_(- 0.07)^(+ 0.07)$], [$115.3_(- 9.4)^(+ 12.4)$], [$2.43_(- 0.11)^(+ 0.11) times 10^(- 6)$], [241.96/362],
    [8.700], [8.795], [$- 0.92_(- 0.02)^(+ 0.02)$], [1,159.4$""_(- 61.6)^(+ 83.6)$], [$8.85_(- 0.16)^(+ 0.16) times 10^(- 5)$], [369.54/362], [38.500], [39.600], [$- 1.34_(- 0.07)^(+ 0.07)$], [$110.2_(- 7.5)^(+ 13.6)$], [$2.26_(- 0.08)^(+ 0.12) times 10^(- 6)$], [254.22/362],
    [8.795], [8.900], [$- 0.94_(- 0.02)^(+ 0.02)$], [1,204.8$""_(- 63.1)^(+ 109.1)$], [$8.37_(- 0.15)^(+ 0.14) times 10^(- 5)$], [375.64/362], [39.600], [41.100], [$- 1.30_(- 0.08)^(+ 0.06)$], [$86.4_(- 5.2)^(+ 7.4)$], [$1.66_(- 0.06)^(+ 0.07) times 10^(- 6)$], [256.25/362],
    [8.900], [9.030], [$- 1.07_(- 0.02)^(+ 0.02)$], [1,252.2$""_(- 83.8)^(+ 136.7)$], [$5.35_(- 0.11)^(+ 0.10) times 10^(- 5)$], [433.73/362], [41.100], [42.700], [$- 1.26_(- 0.09)^(+ 0.07)$], [$88.8_(- 5.9)^(+ 8.9)$], [$1.80_(- 0.06)^(+ 0.09) times 10^(- 6)$], [240.01/362],
    [9.030], [9.300], [$- 1.04_(- 0.03)^(+ 0.02)$], [$603.6_(- 33.2)^(+ 55.2)$], [$3.35_(- 0.06)^(+ 0.06) times 10^(- 5)$], [300.74/362], [42.700], [44.700], [$- 1.29_(- 0.10)^(+ 0.10)$], [$62.4_(- 4.1)^(+ 4.5)$], [$1.07_(- 0.04)^(+ 0.04) times 10^(- 6)$], [203.05/362],
    [9.300], [9.600], [$- 1.07_(- 0.04)^(+ 0.04)$], [$291.4_(- 23.2)^(+ 26.2)$], [$1.35_(- 0.05)^(+ 0.05) times 10^(- 5)$], [344.43/362], [44.700], [47.300], [$- 1.51_(- 0.11)^(+ 0.03)$], [$68.1_(- 2.8)^(+ 9.9)$], [$1.08_(- 0.02)^(+ 0.07) times 10^(- 6)$], [234.63/362],
    [9.600], [10.000], [$- 1.21_(- 0.05)^(+ 0.03)$], [$307.4_(- 24.0)^(+ 42.0)$], [$1.18_(- 0.04)^(+ 0.05) times 10^(- 5)$], [312.69/362], [47.300], [50.100], [$- 1.48_(- 0.09)^(+ 0.08)$], [$76.2_(- 6.0)^(+ 9.0)$], [$1.06_(- 0.04)^(+ 0.06) times 10^(- 6)$], [208.91/362],
    [10.000], [10.400], [$- 1.15_(- 0.04)^(+ 0.04)$], [$331.0_(- 25.3)^(+ 39.0)$], [$1.18_(- 0.03)^(+ 0.05) times 10^(- 5)$], [330.12/362], [50.100], [53.600], [$- 1.44_(- 0.09)^(+ 0.08)$], [$63.1_(- 3.9)^(+ 5.4)$], [$8.91_(- 0.33)^(+ 0.40) times 10^(- 7)$], [247.34/362],
    [10.400], [10.900], [$- 1.12_(- 0.04)^(+ 0.04)$], [$232.2_(- 16.5)^(+ 22.1)$], [$9.57_(- 0.30)^(+ 0.40) times 10^(- 6)$], [346.45/362], [53.600], [70.000], [$- 1.64_(- 0.08)^(+ 0.05)$], [$60.8_(- 4.6)^(+ 7.4)$], [$4.21_(- 0.15)^(+ 0.24) times 10^(- 7)$], [218.64/362],
  ))}, caption: [#strong[Spectral fitting results and corresponding energy flux in each time interval of GRB 211211A.] The energy fluxes are calculated between 10 and 1,000 keV. All errors represent the 1$sigma$ uncertainties.]
  , kind: "edtable", supplement: [Extended Data Table]
  )
 <tab:specfit>





#figure(text(size: 8pt, align(center)[#table(
    stroke: none,
    columns: 9,
    align: (center,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.cell(rowspan: 2)[Linear model], table.cell(align: center, colspan: 2)[Main emission], [], table.cell(align: center, colspan: 2)[Extended emission], [], table.cell(align: center, colspan: 2)[Whole burst],
    [$k$], [$b$], [], [$k$], [$b$], [], [$k$], [$b$],
    [$alpha = k "log" F + b$], [$0.26_(- 0.02)^(+ 0.02)$], [$0.14_(- 0.08)^(+ 0.07)$], [], [$0.27_(- 0.02)^(+ 0.03)$], [$0.21_(- 0.11)^(+ 0.17)$], [], [$0.26_(- 0.01)^(+ 0.01)$], [$0.15_(- 0.05)^(+ 0.05)$],
    [$"log" E_(upright(p)) = k "log" F + b$],
    table.hline(stroke: 0.5pt), [$0.55_(- 0.03)^(+ 0.04)$], [$5.26_(- 0.15)^(+ 0.16)$], [], [$0.55_(- 0.02)^(+ 0.05)$], [$5.15_(- 0.10)^(+ 0.25)$], [], [$0.62_(- 0.02)^(+ 0.02)$], [$5.53_(- 0.08)^(+ 0.08)$],
    [$"log" E_(upright(p)) = k alpha + b$], [$1.69_(- 0.18)^(+ 0.20)$], [$4.53_(- 0.19)^(+ 0.20)$], [], [$1.38_(- 0.32)^(+ 0.15)$], [$3.92_(- 0.41)^(+ 0.20)$], [], [$2.08_(- 0.14)^(+ 0.09)$], [$4.87_(- 0.15)^(+ 0.11)$],
    [$"log" E_(upright(p), upright(z)) = k "log" E_(gamma , "iso") + b$], [$1.22_(- 0.12)^(+ 0.12)$], [$- 58.44_(- 6.07)^(+ 6.04)$], [], [$0.95_(- 0.17)^(+ 0.22)$], [$- 44.96_(- 10.76)^(+ 8.42)$], [], [$1.50_(- 0.08)^(+ 0.09)$], [$- 72.26_(- 4.26)^(+ 4.03)$],
    table.hline(stroke: 0.8pt),
  )]), caption: [#strong[The best-fit parameters of linear models for $alpha$--log$F$, log$E_(upright(p))$--log$F$, log$E_(upright(p))$--$alpha$, and log$E_(upright(p), upright(z))$--log$E_("gamma", "iso")$ correlations.] All errors represent the 1$sigma$ uncertainties.]
  , kind: "edtable", supplement: [Extended Data Table]
  )
 <tab:alpha_Ep_flux>





#figure(text(size: 7pt, align(center)[#table(
    stroke: none,
    columns: 11,
    align: (left,center,center,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.cell(rowspan: 2)[Phase], table.cell(align: center, colspan: 4)[GRB 211211A], [], table.cell(align: center, colspan: 4)[GRB 060614], [],
    [start (s)], [stop (s)], [$alpha_(upright(X))$], [$Gamma_(upright(X))$], [], [start (s)], [stop (s)], [$alpha_(upright(X))$], [$Gamma_(upright(X))$], [],
    table.cell(rowspan: 2)[I: steep decays], [70], [177], [$2.98_(- 0.06)^(+ 0.03)$], [$1.42_(- 0.05)^(+ 0.05)$], [], [97], [173], [$2.47_(- 0.06)^(+ 0.06)$], [$1.21_(- 0.05)^(+ 0.05)$], [],
    [177],
    table.hline(stroke: 0.5pt), [296], [$5.16_(- 0.13)^(+ 0.06)$], [$2.48_(- 0.06)^(+ 0.06)$], [], [173], [464], [$3.90_(- 0.03)^(+ 0.03)$], [$2.28_(- 0.04)^(+ 0.04)$], [],
    [II: plateau], [3,526], [6,140], [$- 0.17_(- 0.55)^(+ 0.52)$], [$1.47_(- 0.08)^(+ 0.15)$], [], [4,538], [34,006], [$0.02_(- 0.05)^(+ 0.05)$], [$1.71_(- 0.04)^(+ 0.11)$], [],
    [III: normal decay], [6,140], [66,490], [$1.57_(- 0.21)^(+ 0.15)$], [$1.54_(- 0.09)^(+ 0.19)$], [], [34,006], [152,033], [$1.34_(- 0.09)^(+ 0.10)$], [$1.85_(- 0.12)^(+ 0.13)$], [],
    [IV: post jet-break decay], [66,490], [167,615], [$3.33_(- 0.42)^(+ 0.73)$], [$1.40_(- 0.30)^(+ 0.44)$], [], [152,033], [2,027,831], [$2.17_(- 0.12)^(+ 0.11)$], [$1.63_(- 0.18)^(+ 0.22)$], [],
    table.hline(stroke: 0.8pt),
  )]), caption: [#strong[The temporal and spectral profiles of X-ray afterglows.] All errors represent the 1$sigma$ uncertainties.]
  , kind: "edtable", supplement: [Extended Data Table]
  )
 <tab:xprofile>





#figure({
  set text(size: 5pt)
  set table(inset: (x: 2.5pt, y: 0.5pt))
  align(center, table(
    columns: 5,
    align: (center,center,center,center,right,),
    table.header([$T - T_0$ (day)], [Telescope], [Band], [AB Magnitude], [Ref.],),
    table.hline(),
    [0.026], [KAIT], [Clear ($tilde$R)], [$20.30 plus.minus 0.20$], [64],
    [0.042], [Swift/UVOT], [U], [$19.86 plus.minus 0.15$], [98],
    [0.044], [Swift/UVOT], [B], [$19.74 plus.minus 0.23$], [98],
    [0.049], [Swift/UVOT], [UVW2], [$19.74 plus.minus 0.15$], [98],
    [0.051], [Swift/UVOT], [V], [$19.27 plus.minus 0.30$], [98],
    [0.053], [Swift/UVOT], [UVM2], [$19.79 plus.minus 0.18$], [98],
    [0.056], [Swift/UVOT], [UVW1], [$19.55 plus.minus 0.14$], [98],
    [0.057], [Swift/UVOT], [U], [$19.56 plus.minus 0.19$], [98],
    [0.186], [Swift/UVOT], [U], [$19.76 plus.minus 0.12$], [98],
    [0.190], [Swift/UVOT], [U], [$19.83 plus.minus 0.12$], [98],
    [0.193], [Swift/UVOT], [U], [$19.99 plus.minus 0.14$], [98],
    [0.196], [Swift/UVOT], [B], [$19.95 plus.minus 0.26$], [98],
    [0.200], [Swift/UVOT], [B], [$20.03 plus.minus 0.33$], [98],
    [0.254], [Swift/UVOT], [UVM2], [$20.63 plus.minus 0.17$], [98],
    [0.263], [MITSuME/Akeno], [Ic], [$20.40 plus.minus 0.30$], [99],
    [0.263], [MITSuME/Akeno], [Rc], [$20.30 plus.minus 0.10$], [99],
    [0.263], [MITSuME/Akeno], [$upright(g)'$], [$20.40 plus.minus 0.20$], [99],
    [0.431], [Nanshan/NEXT], [r], [$20.13 plus.minus 0.06$], [15],
    [0.445], [Nanshan/NEXT], [z], [$20.04 plus.minus 0.23$], [15],
    [0.456], [HCT], [R], [$20.30 plus.minus 0.13$], [100],
    [0.656], [Swift/UVOT], [UVW1], [$21.93 plus.minus 0.27$], [98],
    [0.663], [Swift/UVOT], [U], [$> 20.62$], [98],
    [0.680], [CAHA/CAFOS], [i], [$20.78 plus.minus 0.08$], [10],
    [0.690], [NOT/ALFOSC], [g], [$21.06 plus.minus 0.04$], [10],
    [0.690], [NOT/ALFOSC], [r], [$20.85 plus.minus 0.05$], [10],
    [0.700], [NOT/ALFOSC], [i], [$20.92 plus.minus 0.06$], [10],
    [0.713], [LCO/Sinistro], [R], [$20.83 plus.minus 0.09$], [101],
    [0.713], [LCO/Sinistro], [I], [$21.49 plus.minus 0.25$], [101],
    [0.720], [Swift/UVOT], [UVW2], [$22.30 plus.minus 0.28$], [98],
    [0.726], [Swift/UVOT], [V], [$> 19.34$], [98],
    [0.784], [Swift/UVOT], [B], [$> 20.66$], [98],
    [0.852], [Swift/UVOT], [UVW1], [$22.18 plus.minus 0.31$], [98],
    [0.858], [Swift/UVOT], [U], [$> 20.89$], [98],
    [0.917], [Swift/UVOT], [UVW2], [$> 22.75$], [98],
    [0.923], [Swift/UVOT], [V], [$> 19.37$], [98],
    [1.049], [Swift/UVOT], [B], [$> 20.66$], [98],
    [1.126], [Swift/UVOT], [UVW1], [$> 22.10$], [98],
    [1.182], [Swift/UVOT], [U], [$> 21.39$], [98],
    [1.259], [Swift/UVOT], [UVM2], [$> 22.31$], [98],
    [1.321], [Swift/UVOT], [UVW1], [$> 22.13$], [98],
    [1.396], [GMG], [r], [$> 22.00$], [102],
    [1.410], [DOT], [R], [$21.66 plus.minus 0.07$], [103],
    [1.425], [GIT], [$upright(r)'$], [$> 21.19$], [100],
    [1.440], [Nanshan/NEXT], [r], [$> 22.06$], [15],
    [1.441], [Nanshan/NEXT], [i], [$> 21.22$], [15],
    [1.562], [AbAO], [R], [$21.60 plus.minus 0.33$], [104],
    [1.680], [CAHA/CAFOS], [i], [$22.59 plus.minus 0.13$], [10],
    [2.527], [AbAO], [R], [$> 21.80$], [104],
    [2.558], [Zeiss-1000], [Rc], [$23.10 plus.minus 0.40$], [105],
    [2.680], [CAHA/CAFOS], [i], [$24.59 plus.minus 0.34$], [10],
    [2.912], [Swift/UVOT], [UVM2], [$> 22.77$], [98],
    [4.070], [Gemini/NIRI], [K], [$22.42 plus.minus 0.14$], [10],
    [4.420], [DOT], [R], [$> 23.70$], [103],
    [4.700], [TNG/NICS], [H], [$> 21.90$], [106],
    [5.100], [Gemini/NIRI], [K], [$22.41 plus.minus 0.17$], [10],
    [5.110], [Gemini/GMOS], [i], [$26.06 plus.minus 0.30$], [10],
    [5.419], [Nanshan/NEXT], [r], [$> 21.34$], [15],
    [5.428], [Nanshan/NEXT], [i], [$> 20.81$], [15],
    [5.440], [Nanshan/NEXT], [z], [$> 19.83$], [15],
    [5.960], [MMT/MMIRS], [J], [$24.18 plus.minus 0.35$], [10],
    [6.080], [Gemini/GMOS], [i], [$> 25.52$], [10],
    [6.419], [Nanshan/NEXT], [r], [$> 21.05$], [15],
    [6.428], [Nanshan/NEXT], [i], [$> 20.64$], [15],
    [6.440], [Nanshan/NEXT], [z], [$> 19.67$], [15],
    [6.940], [MMT/MMIRS], [K], [$23.44 plus.minus 0.31$], [10],
    [7.403], [Nanshan/NEXT], [r], [$> 20.97$], [15],
    [7.980], [MMT/MMIRS], [K], [$23.78 plus.minus 0.30$], [10],
    [9.920], [MMT/MMIRS], [K], [$> 22.12$], [10],
    [10.434], [Nanshan/NEXT], [r], [$> 21.66$], [15],
    [14.412], [Nanshan/NEXT], [r], [$> 21.93$], [15],
    [17.650], [NOT/ALFOSC], [i], [$> 24.70$], [10],
    [19.570], [CAHA/CAFOS], [i], [$> 24.17$], [10],
  ))
},
  caption: [#strong[Ultraviolet, optical, and near-infrared observations of GRB 211211A.]],
  kind: "edtable", supplement: [Extended Data Table]
) <tab:uvoniobs>





#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Posterior], [Prior bounds],),
    table.hline(),
    [#strong[Afterglow:]], [], [],
    [log$( E_(upright(k), "iso") / "erg" )$], [$53.2_(- 1.2)^(+ 1.0)$], [$( 50 , 55 )$],
    [log$( theta_(upright(v)) / "rad" )$], [$- 1.6_(- 0.4)^(+ 0.2)$], [$( - 2.2 , - 1.0 )$],
    [log$( theta_(upright(c)) / "rad" )$], [$- 1.8_(- 0.2)^(+ 0.5)$], [$( - 2.5 , - 1.0 )$],
    [log$( n / "cm"^(- 3) )$], [$- 2.8_(- 1.2)^(+ 2.3)$], [$( - 6.0 , 1.0 )$],
    [$p$], [$2.24_(- 0.05)^(+ 0.10)$], [$( 2.0 , 2.5 )$],
    [log$epsilon.alt_(upright(e))$], [$- 2.3_(- 0.7)^(+ 1.2)$], [$( - 4.0 , - 0.5 )$],
    [log$epsilon.alt_(upright(B))$], [$- 2.0_(- 2.0)^(+ 0.5)$], [$( - 5.0 , - 0.5 )$],
    [#strong[Kilonova:]], [], [],
    [$P_0 / "ms"$], [$( 1 )$], [],
    [log$( B / upright(G) )$], [$13.3_(- 0.1)^(+ 0.2)$], [$( 13 , 14 )$],
    [$f_(upright(n))$], [$0.80_(- 0.24)^(+ 0.03)$], [$( 0.4 , 0.9 )$],
    [$kappa / ( "cm"^2 thin g^(- 1) )$], [$0.73_(- 0.06)^(+ 0.53)$], [$( 0.5 , 1.5 )$],
    [$M_"ej" / upright(M)_⊙$], [$0.037_(- 0.004)^(+ 0.008)$], [$( 0.02 , 0.05 )$],
    [$v_"ej" / upright(c)$], [$0.24_(- 0.02)^(+ 0.06)$], [$( 0.1 , 0.4 )$],
    [log$E ( B - V )$], [$- 2.1_(- 0.5)^(+ 0.5)$], [$( - 3 , - 1 )$],
    [log$( v / "mag" )$], [$- 0.58_(- 0.02)^(+ 0.10)$], [$( - 1.5 , 0.0 )$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[The best-fit parameters of the afterglow and engine-fed kilonova models.] All errors represent the 1$sigma$ uncertainties.]
  , kind: "edtable", supplement: [Extended Data Table]
  )
 <tab:agmnmodeling>





// [figvision-cn] imgs/Extended_Data_Figure_1.png
// 该图由四个子图组成，分别标记为a、b、c和d。 子图a： 类
// 型：多通道光变曲线堆叠图。 布局：包含六个垂直堆叠的面
// 板，每个面板对应一个特定的能量波段。所有面板共享底部的
// 同一个横坐标轴。纵坐标轴位于最左侧，标注为“scaled rate
// ”（归一化计数率），无具体数值刻度。横坐标轴标注为“T -
// T0 (s)”，表示相对于触发时刻的时间，范围从0到70秒，主刻
// 度间隔为10秒。 能量波段：从上到下依次标注在右侧，分别
// 为：817-50,000 keV、350-817 keV、100-350 keV、50-100
// keV、25-50 keV、15-25 keV。 数据曲线与颜色含义： 顶部
// 两个面板（817-50,000 keV 和 350-817 keV）仅显示蓝色实
// 线，代表来自Fermi/GBM探测器的GRB 211211A数据。 底部四
// 个面板（100-350 keV 至 15-25 keV）均包含三条重叠的曲线：
// 蓝色实线：代表Fermi/GBM探测器的GRB 211211A数据。 红色
// 实线：代表Swift/BAT探测器的GRB 211211A数据。 黑色实线：
// 代表Swift/BAT探测器的GRB 060614数据。 趋势与结论：在
// 15-350 keV的低能波段，蓝色、红色和黑色曲线在时间结构上
// 高度重合，显示出相似的脉冲形态。在350 keV以上的高能波
// 段，仅观测到GRB 211211A的信号（蓝色曲线）。 子图b： 类
// 型：带误差棒的散点图。 标题：右上角标注“main emission”
// （主辐射）。 坐标轴：纵坐标轴标注为“lag (s)”，即光谱时
// 延，线性标度，范围约为-0.01到0.02秒，主刻度为0.00和
// 0.01。横坐标轴标注为“energy (keV)”，即能量，对数标度，
// 范围从约50 keV到20,000 keV，主刻度标记为10^2和10^4。
// 数据点：图中包含多个带有水平和垂直误差棒的数据点，分为
// 红色和蓝色两种颜色。 辅助元素：背景中有一个灰色的水平
// 矩形区域，大致覆盖纵坐标0.00到0.009的范围。一条黑色的
// 水平实线穿过灰色区域中部（约0.005 s处），一条灰色的水
// 平虚线位于0.00 s处。 趋势与结论：展示了在主辐射阶段，
// 不同能量点之间的光谱时延分布。大部分数据点的时延值集中
// 在正区间，且随能量变化没有明显的单调递增或递减趋势。
// 子图c： 类型：带误差棒的散点图。 标题：上方标注“
// extended emission”（延展辐射）。 坐标轴：纵坐标轴标注
// 为“lag (s)”，线性标度，范围约为-0.01到0.02秒，主刻度为
// 0.00和0.02。横坐标轴标注为“energy (keV)”，对数标度，主
// 要刻度标记为10^2。 数据点：包含红色和蓝色的带误差棒数
// 据点。 辅助元素：背景同样包含一个灰色水平矩形区域（约
// -0.005到0.01 s）和一条位于0.00 s处的灰色水平虚线。 趋
// 势与结论：展示了在延展辐射阶段的光谱时延分布。数据点分
// 布在零值附近，部分为正，部分为负，整体波动较大。 子图d：
// 类型：带误差棒的散点图。 标题：右上角标注“whole burst”
// （整个爆发）。 坐标轴：纵坐标轴标注为“lag (s)”，线性标
// 度，范围约为-0.01到0.02秒，主刻度为0.00和0.02。横坐标
// 轴标注为“energy (keV)”，对数标度，范围从约50 keV到20,
// 000 keV，主刻度标记为10^2、10^3和10^4。 数据点：包含红
// 色和蓝色的带误差棒数据点。 辅助元素：背景包含一条位于
// 0.00 s处的灰色水平虚线。 趋势与结论：展示了整个爆发期
// 间的综合光谱时延特征。随着能量增加，数据点呈现一定的离
// 散性，但总体围绕零值上下分布。
#figure(placement: top, kind: "edfig", supplement: [Extended Data Figure], image("imgs/Extended_Data_Figure_1.png", width: 100%),
  caption: [
    #strong[The multi-wavelength light curves of prompt emissions and spectral lags.] #strong[a], The scaled multi-wavelength light curves obtained from #emph[Fermi]/GBM (blue) and #emph[Swift]/BAT (red) data for GRB 211211A, and #emph[Swift]/BAT (black) data for GRB 060614. For comparison, we reduce the trigger time of GRB 060614 by 5 seconds. #strong[b], #strong[c] and #strong[d] show the spectral lags between each of the higher energy bands and the lowest energy band calculated for the main emission, extended emission, and whole burst of GRB 211211A. The lags in blue and red are derived from #emph[Fermi]/GBM and #emph[Swift]/BAT data, respectively. The horizontal black lines and grey shaded areas in #strong[b] and #strong[c] show the spectral lags and their uncertainties of GRB 060614, respectively. All error bars on data points represent their 1$sigma$ confidence level.
  ]
)
<fig:wavelag>


// [figvision-cn] imgs/Extended_Data_Figure_2.png
// 该图包含两个子图，分别标记为a和b，均为带有拟合曲线的直
// 方图，展示了伽马射线暴（GRB）样本的持续时间分布。 子图
// a： 这是一个统计图表，类型为带有拟合曲线的直方图。 横
// 坐标轴名称为“log(T90/s)”，表示T90持续时间的对数（单位
// 为秒），范围从-2.0到1.5，刻度间隔为0.5。 纵坐标轴名称
// 为“number”，表示数量，范围从0到40，刻度间隔为5。 图中
// 包含以下元素： 灰色空心柱状直方图：代表来自第四个Fermi
// /GBM目录的短伽马射线暴样本的分布。 实心黑线：一条平滑
// 的钟形曲线，代表对上述样本数据的单对数正态分布拟合。图
// 例左上角标注为“N(-0.27, 0.36^2)”。 蓝色垂直实线：位于
// 横坐标约0.8的位置，对应GRB 060614事件。线条右侧有蓝色
// 文字标注“p-value=1.73 x 10^-3”以及下方的“2.92σ”。 红色
// 垂直实线：位于横坐标约1.1的位置，对应GRB 211211A事件。
// 线条右侧有红色文字标注“p-value=5.61 x 10^-5”以及下方的
// “3.86σ”。 图例：位于左上角，说明黑色实线为拟合分布，蓝
// 色实线为GRB 060614 (6 s)，红色实线为GRB 211211A (13 s)。
// 趋势与结论：该图显示短伽马射线暴样本主要分布在log(T90/
// s)小于0的区域，符合单对数正态分布。两个特殊事件GRB
// 060614和GRB 211211A位于分布的极右端尾部，其对应的p值极
// 小且sigma值大于3，表明它们在统计学上显著偏离主分布。
// 子图 b： 这是一个统计图表，类型为带有双峰拟合曲线的直
// 方图。 横坐标轴名称为“log(T90/s)”，范围从-1到3，刻度间
// 隔为1。 纵坐标轴名称为“number”，范围从0到200，刻度间隔
// 为25。 图中包含以下元素： 灰色空心柱状直方图：代表来自
// 第四个Fermi/GBM目录的全部伽马射线暴样本的分布，呈现双
// 峰特征。 虚线灰线：一条较矮的钟形曲线，位于左侧峰值附
// 近。图例标注为“N(1.40, 0.50^2)”。 点划线灰线：一条较高
// 的钟形曲线，位于右侧峰值附近。图例标注为“N(-0.24, 0.40
// ^2)”。 实心黑线：一条叠加在直方图上的复合曲线，由上述
// 两条灰色曲线组成，代表对整个样本的双高斯分布拟合。 蓝
// 色垂直实线：位于横坐标约0.8的位置，对应GRB 060614。线
// 条右侧有蓝色文字标注“P_sGRB = 1.78 x 10^-2”以及下方的“
// 2.57σ”。 红色垂直实线：位于横坐标约1.1的位置，对应GRB
// 211211A。线条右侧有红色文字标注“P_sGRB = 7.68 x 10^-4”
// 以及下方的“3.42σ”。 图例：位于左上角，说明了各条线的含
// 义。 趋势与结论：该图显示全部伽马射线暴样本的持续时间
// 分布呈现双模态结构。GRB 060614和GRB 211211A均落在长伽
// 马射线暴（sGRB）概率较低的区域，但GRB 211211A的偏离程
// 度（sigma值和p值）比GRB 060614更为显著。
#figure(placement: top, kind: "edfig", supplement: [Extended Data Figure], image("imgs/Extended_Data_Figure_2.png", width: 100%),
  caption: [
    #strong[The $T_(upright(90))$ distributions.] #strong[a], The $T_(upright(90))$ distribution (grey hist) of the short GRB ($T_(upright(90)) < 2 med upright(s)$) sample from the fourth #emph[Fermi]/GBM catalog @von_2020ApJ fit with a single log-normal distribution (solid black line). GRB 211211A (with 13-s main emission) and GRB 060614 (with 6-s main emission) are highlighted in red and blue, respectively. #strong[b], The $T_(upright(90))$ distribution (grey hist) of the whole GRB sample from the fourth #emph[Fermi]/GBM catalog fit with a two-component log-normal mixture model (solid black line). The two components responsible for short and long GRB populations are shown with grey dashed and dotted lines, respectively. GRB 211211A (with 13-s main emission) and GRB 060614 (with 6-s main emission) are highlighted in red and blue, respectively.
  ]
)
<fig:t90pdf>


// [figvision-cn] imgs/Extended_Data_Figure_3.png
// 该图包含六个子图（a至f），展示了伽马射线暴的光度与谱参
// 数之间的相关性分析及其分布统计。 子图a： 类型：散点拟
// 合图（双对数坐标）。 坐标轴：横轴为通量 F，单位是 erg
// cm^-2 s^-1，范围从 10^-6 到 10^-4；纵轴为谱指数 alpha，
// 线性刻度，范围从 -1.6 到 -0.8。 数据点：图中包含两组带
// 误差棒的数据点。蓝色十字标记代表“main emission”（主发
// 射相），品红色加号标记代表“extended emission”（延展发
// 射相）。所有误差棒表示 1 sigma 置信水平。 线条：实线表
// 示最佳拟合直线，虚线表示 +/- 3 sigma 的误差带。蓝色对
// 应主发射相，品红色对应延展发射相。 趋势：数据显示随着
// 通量 F 的增加，谱指数 alpha 逐渐变大（即谱变硬），呈现
// 正相关关系。主发射相的数据点主要分布在较高通量和较硬谱
// 指数的区域。 子图b： 类型：散点拟合图（双对数坐标）。
// 坐标轴：横轴为通量 F，单位是 erg cm^-2 s^-1，范围从 10
// ^-6 到 10^-4；纵轴为峰值能量 Ep，单位是 keV，对数刻度，
// 范围从约 50 到 10^3 以上。 数据点：蓝色十字标记代表“
// main emission”，品红色加号标记代表“extended emission”。
// 所有数据点均带有垂直和水平的误差棒。 线条：实线表示最
// 佳拟合直线，虚线表示 +/- 3 sigma 的误差带。 趋势：Ep
// 随 F 的增加而增加，呈现明显的正相关关系（Amati 关系的
// 变种或类似光度-谱关系）。主发射相的数据点普遍具有更高
// 的峰值能量。 子图c： 类型：散点拟合图（半对数坐标）。
// 坐标轴：横轴为谱指数 alpha，线性刻度，范围从 -1.6 到
// -0.8；纵轴为峰值能量 Ep，单位是 keV，对数刻度，范围从
// 约 50 到 10^3 以上。 数据点：蓝色十字标记代表“main
// emission”，品红色加号标记代表“extended emission”。 线
// 条：实线表示最佳拟合直线，虚线表示 +/- 3 sigma 的误差
// 带。 趋势：Ep 随 alpha 的增加（谱变硬）而增加，两者呈
// 正相关关系。 子图d： 类型：散点拟合图（双对数坐标）。
// 坐标轴：横轴为各向同性等效辐射能量 E_gamma,iso，单位是
// erg，对数刻度，中心标注为 10^50；纵轴为红移修正后的峰
// 值能量 Ep(1+z)，单位是 keV，对数刻度，范围从 10^2 到
// 10^3 以上。 数据点：蓝色十字标记代表“main emission”，
// 品红色加号标记代表“extended emission”。 线条：实线表示
// 最佳拟合直线，虚线表示 +/- 3 sigma 的误差带。 趋势：这
// 是经典的 Amati 关系图，显示 Ep(1+z) 随 E_gamma,iso 的
// 增加而增加。主发射相的数据点位于高能量端，延展发射相位
// 于低能量端，两者共同构成一条连续的相关性趋势。 子图e：
// 类型：直方图。 坐标轴：横轴为谱指数 alpha，线性刻度，
// 范围从 -1.6 到 -0.8；纵轴为概率 probability，线性刻度，
// 范围从 0.00 到 0.15。 图形特征：蓝色的空心轮廓直方图展
// 示了 alpha 参数的分布情况。 趋势：分布并非单峰，在
// alpha 约为 -1.2 处有一个显著的主峰（概率最高约 0.17），
// 在 -1.0 附近有一个次级峰。整体分布覆盖了从 -1.6 到
// -0.8 的范围。 子图f： 类型：直方图。 坐标轴：横轴为峰
// 值能量 Ep，单位是 keV，对数刻度，范围跨越 10^2 到 10^3；
// 纵轴为概率 probability，线性刻度，范围从 0.000 到
// 0.125。 图形特征：蓝色的空心轮廓直方图展示了 Ep 参数的
// 分布情况。 趋势：分布较为宽泛，在 Ep 约为 200-300 keV
// 以及 1000 keV (1 MeV) 附近均有较高的概率密度，显示出多
// 峰或平坦的分布特征，没有单一的尖锐峰值。
#figure(placement: top, kind: "edfig", supplement: [Extended Data Figure], image("imgs/Extended_Data_Figure_3.png", width: 100%),
  caption: [
    #strong[The $alpha$, $E_(upright(p))$, and flux $F$ correlation diagrams.] #strong[a], #strong[b], #strong[c] and #strong[d] show the linear fits to $alpha - "log" F$, $"log" E_(upright(p)) - "log" F$, $"log" E_(upright(p)) - alpha$ and $"log" E_(upright(p), upright(z)) - "log" E_("gamma", "iso")$ relations during main emission phase (blue) and extended emission (magenta) phase. The solid and dashed lines show the best-fit correlations and 3$sigma$ error bands, respectively. All error bars on data points represent their 1$sigma$ confidence level. #strong[e] and #strong[f] show the distributions of the best-fit $alpha$ and $E_(upright(p))$ obtained from time-resolved spectral fits.
  ]
)
<fig:alpha_Ep_flux>


// [figvision-cn] imgs/Extended_Data_Figure_4.png
// 该图展示的是伽马射线暴 GRB 211211A 的X射线余辉光变曲线，
// 采用对数-对数坐标系绘制。横轴表示“days after burst”（
// 爆发后天数），范围从约0.03天到4天，刻度为对数标度，主
// 刻度标记为10^-1和10^0；纵轴表示“flux density F_ν (mJy)
// ”（流量密度，单位毫央斯基），范围从10^-5到10^-2 mJy，
// 同样为对数标度，主刻度标记为10^-5、10^-4、10^-3、10^-2。
// 图中包含多组灰色数据点，每个数据点带有垂直误差棒，代表
// PC模式下观测到的X射线余辉流量密度随时间的变化。这些数
// 据点在早期（约0.03–0.1天）密集分布，后期稀疏，整体呈下
// 降趋势。 两条拟合曲线叠加在数据点上： 红色实线代表三段
// 平滑断幂律模型（3-segment SBPL），其统计参数标注于图例
// 框内：“stat/dof=40.81/46, BIC=64.52, AICc=54.68”。该曲
// 线在早期（<0.1天）较平缓，随后经历两个明显的转折（
// breaks），分别发生在约0.2天和约0.8天附近，之后以较陡斜
// 率下降。 蓝色实线代表两段平滑断幂律模型（2-segment
// SBPL），其统计参数标注为：“stat/dof=51.25/48, BIC=
// 67.06, AICc=60.10”。该曲线仅有一个明显转折，位于约0.5
// 天处，前期衰减较慢，后期衰减更快。 图例位于右上角白色
// 背景框内，明确标识红蓝两线对应的模型及各自统计指标。根
// 据BIC和AICc值比较（红色模型的BIC与AICc均小于蓝色模型），
// 数据更支持三段SBPL模型优于两段模型。所有文字标签均为黑
// 色无衬线字体，坐标轴标签清晰可读，无其他装饰性元素。
#figure(placement: top, kind: "edfig", supplement: [Extended Data Figure], image("imgs/Extended_Data_Figure_4.png", width: 100%),
  caption: [
    #strong[The X-ray afterglow of GRB 211211A fit with smoothed broken power-law (SBPL) function.] The X-ray afterglow in PC mode is shown with grey error bars. The 2-segment and 3-segment SBPL models are represented by blue and red lines, respectively. Based on the statistics (stat/dof, BIC, and AICc), the data favors the 3-segment more than the 2-segment SBPL model. The differences in BIC and AICc between the 2-segment and 3-segment SBPL models are $Delta "BIC" = 2.54$ and $Delta "AICc" = 5.42$, respectively. Such "strength of evidence" (i.e., $Delta "BIC"$ and $Delta "AICc"$) also positively supports the 3-segment SBPL model.
  ]
)
<fig:xrtfit>


// [figvision-cn] imgs/Extended_Data_Figure_5.png
// 图a展示了一个包含15个参数的后验概率分布角图（Corner
// plot）。该图为一个15x15的矩阵布局，对角线排列着每个参
// 数的一维概率密度直方图，非对角线区域则展示了任意两个参
// 数之间的二维联合概率等高线图。 所有子图中的颜色映射一
// 致：深蓝色代表最高概率密度，向外逐渐过渡为浅蓝色和白色。
// 红色十字标记表示最佳拟合值（中位数），红色水平线段代表
// 1倍标准差（1-sigma）的不确定度范围。 对角线上的直方图
// 及对应的参数标注（从左上至右下依次为）： logE_k,iso：
// 对数各向同性动能。最佳值为53.250，不确定度上界+0.168，
// 下界-0.247。 logE_j：对数喷流能量。最佳值为-1.581，不
// 确定度上界+0.192，下界-0.182。 logE_e：对数电子能量分
// 配分数。最佳值为-1.790，不确定度上界+0.474，下界-0.169。
// logn：对数环境数密度。最佳值为-2.780，不确定度上界+
// 0.197，下界-0.182。 p：电子能谱指数。最佳值为2.237，不
// 确定度上界+0.088，下界-0.084。 logE_B：对数磁场能量分
// 配分数。最佳值为-2.330，不确定度上界+0.152，下界-0.152。
// logE_p：对数质子能量分配分数。最佳值为-1.997，不确定度
// 上界+0.402，下界-0.168。 logB：对数初始磁场强度。最佳
// 值为13.269，不确定度上界+0.131，下界-0.126。 f_b：几何
// 因子或相关系数。最佳值为0.798，不确定度上界+0.039，下
// 界-0.038。 κ：吸光度或相关系数。最佳值为0.731，不确定
// 度上界+0.087，下界-0.081。 M_0：质量参数。最佳值为
// 0.037，不确定度上界+0.008，下界-0.004。 v_ij：速度参数。
// 最佳值为0.235，不确定度上界+0.052，下界-0.045。 logE(
// B-V)：对数色余。最佳值为-2.096，不确定度上界+0.149，下
// 界-0.133。 logv：对数速度。最佳值为-0.575，不确定度上
// 界+0.032，下界-0.032。 最后一个参数未明确标出具体名称，
// 但位于右下角。 二维等高线图显示了参数间的相关性。例如，
// logE_k,iso与logE_j呈现正相关（椭圆沿对角线方向延伸），
// 而某些其他参数对之间相关性较弱（接近圆形分布）。 图b是
// 一个多波段光变曲线图，横坐标为“days after burst”（爆发
// 后天数），范围从0到25天；纵坐标为“AB magnitude +
// constant”（AB星等加常数），范围从32到16（数值越小越亮）。
// 图中包含多条理论模型曲线和观测数据点。 理论模型曲线按
// 颜色区分不同波段，从下到上亮度依次递减（即星等数值越大
// 越暗）： 蓝色系曲线（UVW2+6, UVM2+5, UVW1+4, U+3）：位
// 于图表最下方，对应紫外波段，在约2-4天内迅速衰减至探测
// 极限以下。 青色/绿色系曲线（B+2, g+1, V）：位于中间偏
// 下位置，峰值出现在约1天左右，随后下降。 黄/橙色系曲线
// （r-1, i-2, z-3, J-4）：位于中间偏上位置，峰值稍晚，衰
// 减较慢。 红色系曲线（H-5, K-6）：位于图表最上方，对应
// 近红外波段，亮度最高且衰减最慢，持续至25天。 每条曲线
// 旁标注了具体的波段名称及一个偏移常数（如“U+3”表示U波段
// 数据向上平移了3个星等单位以避免重叠）。 观测数据点用带
// 误差棒的符号表示： 实心圆点表示实际探测到的数据点。 向
// 下箭头表示未探测到信号的上限（upper limits）。 数据点
// 的颜色与对应的模型曲线颜色一致。例如，红色的实心圆点和
// 箭头对应K波段和H波段的观测数据，分布在第4天到第10天左
// 右，与红色模型曲线吻合较好。蓝色的数据点集中在前2天内。
// 绿色的数据点分布在第2天到第10天之间。整体趋势显示，观
// 测数据点（扣除余辉后）与发动机驱动千新星（engine-fed
// kilonova）模型的最佳拟合曲线高度一致，特别是在光学和近
// 红外波段。
#figure(placement: top, kind: "edfig", supplement: [Extended Data Figure], image("imgs/Extended_Data_Figure_5.png", width: 100%),
  caption: [
    #strong[The fit of the afterglow plus engine-fed kilonova model to multi-wavelength data.] #strong[a], Corner plot of the posterior probability distributions of the parameters. The red error bars represent the 1$sigma$ uncertainties. #strong[b], Afterglow-subtracted observations and best-fitting engine-fed kilonova model. The detections and upper limits of the afterglow-subtracted observations are shown with solid circles and downward arrows, respectively. The best-fit models in different bands are presented with solid lines.
  ]
)
<fig:mnmodeling>

#bibliography("refs.bib", style: "nature.csl", title: [References])