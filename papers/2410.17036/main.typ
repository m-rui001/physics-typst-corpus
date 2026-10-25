#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm))
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)


#align(center)[
  #text(12pt, weight: "bold", [Dark Matter Search Results from 4.2 Tonne-Years of Exposure \ of the LUX-ZEPLIN (LZ) Experiment])   #v(1.2em)
  #text(10.5pt)[J. Aalbers#super[1], D.S. Akerib#super[1], A.K. Al Musalhi#super[3], F. Alder#super[3], C.S. Amarasinghe#super[4], A. Ames#super[1], T.J. Anderson#super[1], N. Angelides#super[5], H.M. Araújo#super[5], J.E. Armstrong#super[6], M. Arthurs#super[1], A. Baker#super[7], S. Balashov#super[8], J. Bang#super[9], J.W. Bargemann#super[4], E.E. Barillier#super[10], D. Bauer#super[5], K. Beattie#super[12], T. Benson#super[13], A. Bhatti#super[6], A. Biekert#super[12], T.P. Biesiadzinski#super[1], H.J. Birch#super[10], E. Bishop#super[15], G.M. Blockinger#super[16], B. Boxer#super[17], C.A.J. Brew#super[8], P. Brás#super[18], S. Burdin#super[19], M. Buuck#super[1], M.C. Carmona-Benitez#super[20], M. Carter#super[19], A. Chawla#super[21], H. Chen#super[12], J.J. Cherwinka#super[13], Y.T. Chin#super[20], N.I. Chott#super[22], M.V. Converse#super[23], R. Coronel#super[1], A. Cottle#super[3], G. Cox#super[24], D. Curran#super[24], C.E. Dahl#super[25], I. Darlington#super[3], S. Dave#super[3], A. David#super[3], J. Delgaudio#super[24], S. Dey#super[27], L. de Viveiros#super[20], L. Di Felice#super[5], C. Ding#super[9], J.E.Y. Dobson#super[7], E. Druszkiewicz#super[23], S. Dubey#super[9], S.R. Eriksen#super[28], A. Fan#super[1], S. Fayer#super[5], N.M. Fearon#super[27], N. Fieldhouse#super[27], S. Fiorucci#super[12], H. Flaecher#super[28], E.D. Fraser#super[19], T.M.A. Fruth#super[29], R.J. Gaitskell#super[9], A. Geffre#super[24], J. Genovesi#super[22], C. Ghag#super[3], A. Ghosh#super[16], R. Gibbons#super[12], S. Gokhale#super[30], J. Green#super[27], M.G.D.van der Grinten#super[8], J.J. H]
  
]
// affcenter
#align(center)[#set text(style: "italic")

  #text(9pt)[#super[1] SLAC National Accelerator Laboratory, Menlo Park, CA 94025-7015, USA] \
  #text(9pt)[#super[2] Kavli Institute for Particle Astrophysics and Cosmology, Stanford University, Stanford, CA 94305-4085, USA] \
  #text(9pt)[#super[3] University College London (UCL), Department of Physics and Astronomy, London WC1E 6BT, UK] \
  #text(9pt)[#super[4] University of California, Santa Barbara, Department of Physics, Santa Barbara, CA 93106-9530, USA] \
  #text(9pt)[#super[5] Imperial College London, Physics Department, Blackett Laboratory, London SW7 2AZ, UK] \
  #text(9pt)[#super[6] University of Maryland, Department of Physics, College Park, MD 20742-4111, USA] \
  #text(9pt)[#super[7] King’s College London, Department of Physics, London WC2R 2LS, UK] \
  #text(9pt)[#super[8] STFC Rutherford Appleton Laboratory (RAL), Didcot, OX11 0QX, UK] \
  #text(9pt)[#super[9] Brown University, Department of Physics, Providence, RI 02912-9037, USA] \
  #text(9pt)[#super[10] University of Michigan, Randall Laboratory of Physics, Ann Arbor, MI 48109-1040, USA] \
  #text(9pt)[#super[11] University of Zürich, Department of Physics, 8057 Zürich, Switzerland] \
  #text(9pt)[#super[12] Lawrence Berkeley National Laboratory (LBNL), Berkeley, CA 94720-8099, USA] \
  #text(9pt)[#super[13] University of Wisconsin-Madison, Department of Physics, Madison, WI 53706-1390, USA] \
  #text(9pt)[#super[14] University of California, Berkeley, Department of Physics, Berkeley, CA 94720-7300, USA] \
  #text(9pt)[#super[15] University of Edinburgh, SUPA, School of Physics and Astronomy, Edinburgh EH9 3FD, UK] \
  #text(9pt)[#super[16] University at Albany (SUNY), Department of Physics, Albany, NY 12222-0100, USA] \
  #text(9pt)[#super[17] University of California, Davis, Department of Physics, Davis, CA 95616-5270, USA] \
  #text(9pt)[#super[18] Laboratório de Instrumenta cão e Física Experimental de Partículas (LIP), University of Coimbra, P-3004 516 Coimbra, Portugal] \
  #text(9pt)[#super[19] University of Liverpool, Department of Physics, Liverpool L69 7ZE, UK] \
  #text(9pt)[#super[20] Pennsylvania State University, Department of Physics, University Park, PA 16802-6300, USA] \
  #text(9pt)[#super[21] Royal Holloway, University of London, Department of Physics, Egham, TW20 0EX, UK] \
  #text(9pt)[#super[22] South Dakota School of Mines and Technology, Rapid City, SD 57701-3901, USA] \
  #text(9pt)[#super[23] University of Rochester, Department of Physics and Astronomy, Rochester, NY 14627-0171, USA] \
  #text(9pt)[#super[24] South Dakota Science and Technology Authority (SDSTA), Sanford Underground Research Facility, Lead, SD 57754-1700, USA] \
  #text(9pt)[#super[25] Northwestern University, Department of Physics \& Astronomy, Evanston, IL 60208-3112, USA] \
  #text(9pt)[#super[26] Fermi National Accelerator Laboratory (FNAL), Batavia, IL 60510-5011, USA] \
  #text(9pt)[#super[27] University of Oxford, Department of Physics, Oxford OX1 3RH, UK] \
  #text(9pt)[#super[28] University of Bristol, H.H. Wills Physics Laboratory, Bristol, BS8 1TL, UK] \
  #text(9pt)[#super[29] The University of Sydney, School of Physics, Physics Road, Camperdown, Sydney, NSW 2006, Australia] \
  #text(9pt)[#super[30] Brookhaven National Laboratory (BNL), Upton, NY 11973-5000, USA] \
  #text(9pt)[#super[31] University of Massachusetts, Department of Physics, Amherst, MA 01003-9337, USA] \
  #text(9pt)[#super[32] University of Alabama, Department of Physics \& Astronomy, Tuscaloosa, AL 34587-0324, USA] \
  #text(9pt)[#super[33] University of California, Los Angeles, Department of Physics \& Astronomy, Los Angeles, CA 90095-1547, USA] \
  #text(9pt)[#super[34] IBS Center for Underground Physics (CUP), Yuseong-gu, Daejeon, Korea] \
  #text(9pt)[#super[35] University of Sheffield, Department of Physics and Astronomy, Sheffield S3 7RH, UK] \
  #text(9pt)[#super[36] University of Texas at Austin, Department of Physics, Austin, TX 78712-1192, USA] \
  #text(9pt)[#super[37] Kavli Institute for Particle Astrophysics and Cosmology, Stanford University, Stanford, CA 94305-4085 USA] \
  #text(9pt)[#super[38] Lawrence Livermore National Laboratory (LLNL), Livermore, CA 94550-9698, USA] \
  #text(9pt)[#super[39] Vatican Observatory, Castel Gandolfo, V-00120, Vatican City State] \
  #text(9pt)[#super[40] Black Hills State University, School of Natural Sciences, Spearfish, SD 57799-0002, USA] \
]
#v(1.2em)


















































































































































































































































































































































































































































































































































































































































































































#emph[Abstract.] We report results of a search for nuclear recoils induced by weakly interacting massive particle (WIMP) dark matter using the LUX-ZEPLIN (LZ) two-phase xenon time projection chamber. This analysis uses a total exposure of $4.2 plus.minus 0.1$~tonne-years from 280~live days of LZ operation, of which $3.3 plus.minus 0.1$~tonne-years and 220 live days are new. A technique to actively tag background electronic recoils from $""^214$Pb $beta$ decays is featured for the first time. Enhanced electron-ion recombination is observed in two-neutrino double electron capture decays of $""^124$Xe, representing a noteworthy new background. After removal of artificial signal-like events injected into the data set to mitigate analyzer bias, we find no evidence for an excess over expected backgrounds. World-leading constraints are placed on spin-independent (SI) and spin-dependent WIMP-nucleon cross sections for masses $gt.eq$9~GeV/$c^2$. The strongest SI exclusion set is $2.2 times 10^(- 48)$~cm$""^2$ at the 90\% confidence level and the best SI median sensitivity achieved is $5.1 times 10^(- 48)$~cm$""^2$, both for a mass of 40~GeV/$c^2$.








#columns(2, gutter: 0.6cm)[

Astrophysical observations provide strong evidence for the existence of dark matter and its dominance of the matter density of the Universe~@Aghanim2020 @SofueRubin @harvey2015nongravitational @ARBEY2021103865. Well-motivated as a thermal relic, the weakly interacting massive particle (WIMP) is a leading hypothesis for dark matter, arising in a number of beyond-the-standard-model theories~@RevModPhys.90.045002 @Billard2022 @akerib2022snowmass2021. The LUX-ZEPLIN (LZ) collaboration operates the world's largest two-phase xenon time projection chamber (TPC), with the primary aim of directly detecting WIMPs through their interactions with xenon nuclei. This technology has produced the most stringent constraints on spin-independent (SI) WIMP-nucleon interactions for $gt.tilde$5~GeV/$c^2$ masses, with all three current-generation experiments having reported results~@SR1WS @XENON:2023cxc @PandaX:2024qfu. In this Letter we present the latest WIMP analysis from LZ, combining a new 220~live-day exposure (WS2024) with the 60~live-day exposure from the first result (WS2022)~@SR1WS to perform the most sensitive direct search for WIMPs to date.


The LZ experiment~@lzcdr#cite(<-lztdr>)#cite(<-LZExperiment>) is located 4850~ft underground, shielded by a 4300~meter water equivalent rock overburden in the Davis Cavern at the Sanford Underground Research Facility (SURF) in Lead, South Dakota, USA. Its TPC, containing seven tonnes of active liquid xenon (LXe), is surrounded by a dual-detector veto system comprising a two-tonne LXe “Skin,” designed to tag $gamma$ rays, and an outer detector (OD) containing 17 tonnes of gadolinium-loaded liquid scintillator (GdLS), optimized for the detection of neutrons.


Interactions in the LXe target that fills the TPC create light in the form of prompt vacuum ultraviolet (VUV) scintillation (S1) and delayed electroluminescence (S2), both observed by the top and bottom photomultiplier tube (PMT) arrays. The S2 signal is generated by ionization electrons as they traverse a thin layer of gaseous xenon above the liquid, having been drifted upwards from the interaction site under an applied electric field and extracted from the liquid phase. The measured time interval between the S1 and the S2 pulses, referred to as the “drift time”, corresponds to the depth, $z$, of the interaction, while the hit pattern of S2 light in the top PMT array allows for position reconstruction in the transverse $( x , y )$ plane. The ratio of S2 to S1 signal sizes is used to discriminate between background electronic recoils (ERs) and nuclear recoils (NRs), the latter of which is expected for WIMP-nucleus scatters. Background events are further rejected if they exhibit multiple scatters (MS) rather than a single scatter (SS) in the TPC, or through the presence of coincident signals in the Skin and/or OD.


The LXe target is contained in a vacuum-insulated cryostat, and is continuously circulated for gas-phase purification to remove electronegative impurities, and to regulate the liquid level. The cooling and circulation systems allow for control of the LXe flow pattern inside the cryostat, which influences the spatial distribution and movement of radioisotopes in the TPC volume. Two distinct flow configurations can be attained, referred to as the “high-mixing” and “low-mixing” states. In the high-mixing state, the liquid flow results in spatially homogeneous distributions of injected calibration sources. In the low-mixing state, there exist distinct regions of laminar flow throughout the detector, and coincident $""^222$Rn$-^218$Po $alpha$ decays can be reliably used to map the LXe velocity field. The ability to model the flow in this state is exploited in the development of a “radon tag” to target the prominent $""^214$Pb ER background (similar to that in Ref.~@XENON_radonVeto), discussed later.


Cathode, gate, and anode electrodes establish the TPC drift field at 97~V/cm and the liquid-gas extraction field at 3.4~kV/cm (at the radial center, below the liquid surface) for the WS2024 data-taking campaign. With respect to WS2022, the extraction field was decreased to reduce the dead time incurred from spurious electron and photon emission, and the cathode voltage was lowered in response to the onset of persistent light emission localized to the Skin region below the cathode.


This analysis incorporates 220.0~live days collected in the new electrode bias configuration between March~27,~2023 and April~1,~2024. Of this WS2024 live time, 40.9~live days are included from when the detector is in the high-mixing state, due to proximity to injected calibrations, with the remaining 179.1~live days taken in the low-mixing state. The xenon gas pressure throughout the run is 1.860 bar(a) with variation at the level of 0.03\%. The level of convective mixing is controlled by adjusting the temperature of the liquid returning to the bottom of the TPC from 177.9~K (high-mixing state) to 174.2~K (low-mixing state), with variations at the level of 0.02\% for each. Changing from high-mixing to low-mixing state increases the maximum drift time from 1045~$mu$s to 1050~$mu$s and reduces the overall liquid height by about 0.2 mm. The consequent 1\% increase in S2 signal size is corrected for in analysis. Stable electron lifetimes averaging 9.3 ms and 13.8 ms were maintained in the high-mixing and low-mixing states, respectively.


Data acquisition uses a trigger with a digital filter designed primarily to capture S2 pulses. The trigger was optimized for WS2024 to increase the sensitivity to low-energy events of interest to the WIMP analysis, achieving an efficiency of 95\% for S2 pulses corresponding to 3.5~extracted electrons. Waveforms from the TPC, Skin, and OD PMTs are recorded with a window extending from 2.2~ms before the trigger time to 2.5~ms after it, sampled at 100~MHz. Further details of the data acquisition and signal chain are described in Ref.~@LZ_DAQ.


Event waveforms are processed to find and categorize pulses and interactions. Pulse sizes are normalized by the time-dependent size of single VUV photon pulses measured in each channel, and are reported as the number of photons detected (phd)~@faham2015measurements @LOPEZPAREDESdpe. Events are categorized as SS if they have a single S1 preceding a single S2. The SS identification efficiency is dependent on the S1 and S2 pulse classification efficiencies. Ionization electrons diffuse as they drift, which can lead to fragmentation of the S2 signal into multiple pulses. The splitting probability is $<$1\% on average across the TPC for S2 pulses relevant to this analysis, as estimated with waveform simulations~@LZSims. For a pulse to be classified as S1, coincident photons must be recorded in at least three PMTs; however, undersized PMT responses and differences in photon transit times can lead to missed S1 pulses. The SS S1 identification efficiency is found to be $>$90\% for all S1 pulse sizes in this analysis, rising to 100\% for S1s $>$35~phd (8~keV). This efficiency is assessed by comparing the event classification of a sample of tritium beta decays and deuterium-deuterium (DD) neutron calibration events determined by the event reconstruction algorithms to the corresponding classification obtained from a manual, visual categorization campaign.


Tritium and DD neutrons are among several sources used to calibrate the TPC~@LZ_calibrations. Tritium is delivered through radiolabeled methane along with $""^14$C, in an activity ratio of approximately 8:1. The tritiated methane, primarily used to calibrate the ER response, was injected into the TPC while in the high-mixing state to ensure its efficient dispersal and complete removal by the purification system, with a half-life of 53 hours. Mono-energetic 2.45~MeV neutrons from a collimated DD generator, directed roughly 10~cm below the LXe surface, supply the counterpart for calibrating the NR response. AmLi neutron sources, deployed in source tubes at three different azimuthal positions and three different heights around the TPC, provide additional NR calibration events. Injections of $""^(131 upright(m))$Xe and $""^(83 upright(m))$Kr at roughly monthly and trimonthly cadences, respectively, in addition to background radon progeny, provide mono-energetic peaks throughout WS2024, used to monitor the stability of the detector response and develop corrections for the normalization of S1 and S2 signals.


S1 and S2 signals exhibit spatial and temporal variations due to factors such as changing detector conditions or non-uniform light collection and electron extraction efficiencies. Corrections are applied to produce standardized values, S1$c$ and S2$c$. An $( x , y , z )$ map normalizes the S1 signals to the center of the TPC volume, with correction factors averaging 8\% in absolute value. S2 signals are normalized to the radial center of the liquid surface in the $( x , y )$ plane, in addition to being corrected for the measured electron lifetime\; the average values of these corrections are approximately 13\% and 7\%, respectively. The responses are also normalized in time, using the tritium calibration period as the reference.


Calibrations also inform the tuning of the #smallcaps[nest] 2.4.0~@nest_2_4_0 model for detector response, in which the scintillation photon and ionization electron gains, $g_1$ and $g_2$, are key parameters. A scan over viable values for $g_1$ and $g_2$, performed using tritium data in $( upright("S1") c , upright("log")_10 ( upright("S2") c ) )$ space and constrained by the energy reconstruction of $""^(131 upright(m))$Xe and $""^(83 upright(m))$Kr peaks, yields $g_1 = 0.112 plus.minus 0.002$~phd/photon and $g_2 = 34.0 plus.minus 0.9$~phd/electron. A further tuning to more accurately capture the “ER band,” i.e. the shape of the observed distribution of tritium data, enables #smallcaps[nest] to reproduce the band median and width to better than 0.2% and 5% in $log_10 ( upright("S2") c )$, respectively. The DD data define an analogous “NR band,” for which #smallcaps[nest] is separately tuned to a similar level of precision via small adjustments in the NR yield parameters. For both the ER and NR models, the tuned parameters and the resulting light and charge yields are within the uncertainty bands reported in Ref.~@szydagis2022review. The DD neutron interactions are confined to the top of the detector, where the average electric field is 7\% higher than the center. Because the charge yield of $""^222$Rn $alpha$ decays used for spatial corrections is more field-sensitive than NRs, corrections in the DD neutron region overestimate field effects on recombination, leading to a systematic shift in the NR band position as assumed for the full TPC. An upwards shift of 2.4\% in S2$c$ is applied to the NR model to compensate for this effect, calculated from electrostatic simulations and #smallcaps[nest]-based models.


Candidate events for the WIMP analysis are selected if they are classified as SS; they are located within the fiducial volume (FV); they pass veto coincidence, S1 and S2-based, and live-time exclusion cuts, all of which are described below; and they lie within the WIMP region of interest (ROI). The ROI is defined such that the corrected S1 and S2 pulse sizes are in the range of $3 < upright("S1") c < 80$~phd and $log_10 ( upright("S2") c ) < 4.5$. A lower bound on uncorrected S2 pulse size of 645~phd, equivalent to 14.5 extracted electrons, is also applied. This S2 threshold renders the analysis largely insensitive to $""^8$B coherent elastic neutrino-nucleus scattering (CE$nu$NS), a search for which will be reported in a future publication.


// [figvision-cn] imgs/figure1.png
// 这是一张二维散点图。横轴为 R² [cm²]，范围从 0 到约 75²
// （标度依次为 0²、20²、30²、40²、50²、60²、70²）；左侧
// 纵轴为 z [cm]，范围从 0 到 140；右侧纵轴漂移时间 Drift
// Time [μs] 与左侧 z 轴对应，0 μs 对应 z=140 cm，1000 μs
// 对应 z=0 cm。 图中包含以下数据标记： 灰色背景点云：大
// 量浅灰色小点，位于 R² 大于 60² cm² 且 z 从 0 到 140 cm
// 的区域，对应 FV 之外的数据（未进行符合性否决切割）。
// 黑色点：大量黑色点，应用所有分析切割，主要散布在 R² 小
// 于 65² cm² 且 z 在 0 到 140 cm 的区域；注意这些黑点均
// 未出现在灰色点主导的区域内。 红色叉号：集中分布在 R²
// 大约 55²–67² cm²、z 大约 0–15 cm（底部）以及 R² 约 60²
// –67² cm²、z 约 115–135 cm（顶部），表示被瞬发否决符合
// 切割的事件（被排除）。 蓝色空心圆圈：散落分布，例如 (
// 20², 60)、(30², 110)、(50², 80)、(55², 50) 等位置，表
// 示被延迟否决符合切割的事件（被排除）。 线型说明： 虚线：
// 表示平均方位角上的活跃体积边界，其边界呈弯曲状，贯穿右
// 侧区域（高 R²），在 R² ≈ 60²–67² cm² 处，底部 z=0、顶
// 部 z=140。 两条实线：表示根据最小和最大径向延伸方位角
// 定义的最终 FV（Fiducial Volume）边界。两条线在图上几乎
// 重合，构成一个近似矩形的区域，底部和顶部边缘分别在 z=0
// 和 z=140 cm 附近，右侧边界由折线构成，顶点约在 R² ≈ 63
// ² cm² 处，向外略延伸至 R² 约 65² cm²（对应两个方位角极
// 值）。 趋势与结论：图中显示经过所有切割后，保留的黑色
// 事件在 FV 内分布较为均匀，被否决的（红叉、蓝圈）事件主
// 要出现在 FV 边界和底部/顶部区域，表明切割有效地剔除了
// 背景事件，同时 FV 的径向边界在方位角上的变化（两条实线
// 之间）较小，只是略呈倾斜或微小的弯曲。未出现标记的灰色
// 点区域代表被直方图清晰展示的高漂移时间（低 z）和高半径
// 区域，这些事件被分析切割完全排除。
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

#figure(image("imgs/figure1.png", width: 100%),
  caption: [
    Data from WS2024, in black with all analysis cuts applied, and in gray outside the FV without veto coincidence cuts. Red crosses and blue circles represent events that are vetoed by the prompt and delayed veto coincidence cuts, respectively. The dashed line shows the active volume, averaged over azimuth, and the two solid lines depict the FV, at the azimuths of its smallest and largest radial extent. The drift field affects the position reconstruction such that the observed radius of the TPC varies as a function of both drift time and azimuthal angle.
  ]
)
<fig:r2z>



A FV, illustrated in @fig:r2z, is defined to suppress external backgrounds. Drift time limits are placed at 71~$mu$s and 1034 (1030)~$mu$s in the low(high)-mixing state, corresponding to distances of 9.9~cm below the gate and 2.2~cm above the cathode, respectively. Events within 6.0~cm of the TPC field cage resistors~@LZExperiment in $( x , y )$ are also excluded, as these resistors have elevated radioactivity. The radial fiducial boundary is defined such that backgrounds originating from the TPC wall, which can be misreconstructed radially inwards due to finite position resolution, have a negligible expectation of $< 0.01$ events for WS2024. This radial boundary follows a contour of measured wall background event rate, and is a function of both depth and azimuthal angle. The fiducial mass, determined using the fraction of tritium events in the full active volume found within the FV, is $5.5 plus.minus 0.2$~tonnes.


Veto coincidence cuts reject events that are accompanied by activity in the Skin and/or OD, and are divided into prompt and delayed categories (see @fig:r2z). Prompt cuts target $gamma$ rays and fast neutron scatters, removing events with signals in the Skin (OD) of size $> 2.5$~phd ($> 4.5$~phd) within 0.25~$mu$s (0.3~$mu$s) of the S1. Delayed veto cuts target neutrons, which thermalize then capture, typically on Gd in the OD with the release of an 8--9~MeV $gamma$-ray cascade. These cuts reject events with pulses in the OD (Skin) of energy $gt.tilde 200$~keV ($gt.tilde 300$~keV) that occur within a 600~$mu$s time window after the S1. The delayed veto cuts remove 3\% of the collected live time due to coincidences between unrelated interactions in the TPC and the veto detectors. The veto efficiency for AmLi calibration neutrons, combining prompt and delayed cuts, is measured to be $89 plus.minus 3$\%. Radiogenic neutrons can be vetoed more effectively as they are typically higher in energy than those from AmLi, and are often accompanied by other neutrons and $gamma$ rays. Simulations tuned on the AmLi calibration data indicate that the efficiency to reject background neutrons is $92 plus.minus 4$\%, with the uncertainty driven by residual discrepancies between the simulations and AmLi data.


Cuts based on S1 and S2 pulse characteristics target accidental coincidence events, in which the random pairing of pulses classified as S1s and S2s mimic true SS interactions. Several sources give rise to isolated S1- and S2-classified pulses, such as interactions in light- or charge-insensitive regions of the detector, spurious Cherenkov photon emissions, or delayed emissions of electrons~@sorensen2017electron @LUXelectronbkgs. The cuts primarily exploit the shapes of these pulses in assessing the validity of the S1-S2 pair. The rejection power of the cuts is evaluated on a sideband of known accidental coincidence events with unphysical drift times ($>$1100~$mu$s) and is 99.5\% for all such events in the WIMP ROI.


Live time exclusions discount periods with higher-than-average incidences of accidental coincidences due to elevated pulse rates, which generally occur in the wake of high-energy interactions. A time hold-off is imposed after large S2 signals, dependent on their size, to avoid subsequent delayed ionization or correlated light emission. The hold-off calculation is optimized with respect to that used in WS2022 so that it cumulatively removes 10\% of the recorded live time in WS2024, as opposed to 30\% in WS2022. Accounting for all live-time losses and exclusions, 81.5\% of the collected live time of WS2024 remains for analysis, totaling 220.0~live days.


The cumulative effect of the data selection, event detection, and reconstruction efficiencies on the NR signal efficiency can be seen in @fig:NRacceptance, where the cut acceptances are assessed on a combination of tritium and neutron calibration data sets. Uncertainties arise from the combined statistical error on the SS efficiency and data analysis cuts, as well as a systematic error equal to the variation in efficiency of data analysis cuts as evaluated on the different calibration data sets.


// [figvision-cn] imgs/figure2.png
// 这是一张单面板曲线图，展示核反冲信号效率随核反冲能量变
// 化的函数关系。主图横轴为核反冲能量 Nuclear Recoil
// Energy，单位为 keV，范围从 0 到约 75 keV，主刻度间隔
// 10 keV，次刻度间隔 5 keV；纵轴为相对效率 Relative
// Efficiency，无量纲，范围 0.0 到 1.0，主刻度间隔 0.2，
// 次刻度间隔 0.1。图中包含四条阶梯状效率曲线：蓝色曲线表
// 示 S2 触发（Trigger），橙色曲线表示叠加单散射重建与数
// 据分析 cuts（+ SS & Data Analysis Cuts），绿色曲线表示
// 叠加 S2 ROI（+ S2 ROI），黑色曲线表示再叠加 S1 ROI（+
// S1 ROI）。灰色带仅包裹黑色曲线，表示不确定度带。上方居
// 中的图例标注了这四条曲线的颜色与含义。主图显示：蓝色触
// 发曲线在约 2–3 keV 处迅速从 0 上升至接近 1.0，并一直保
// 持平坦；橙色曲线在约 5–12 keV 上升至约 0.9，随后在 40–
// 50 keV 之前保持约 0.9，之后在 50–70 keV 间下降至 0；绿
// 色曲线在约 7–15 keV 上升至约 0.95 并保持稳定；黑色曲线
// 在约 8–15 keV 上升至约 0.93–0.95，并在约 50–70 keV 间
// 与灰色带一同下降至 0，其低能端比绿色曲线更晚上升。主图
// 中还包含一个嵌入图（inset），位于主图左中偏下位置。嵌
// 入图横轴同样是核反冲能量，范围 0 到 10 keV，主刻度间隔
// 2 keV，次刻度间隔 1 keV；纵轴为 0.00 到 1.00，主刻度间
// 隔 0.25。嵌入图显示低能区四条曲线的细节：蓝色曲线在 2–
// 3 keV 间陡升至接近 1.0；橙色曲线从约 1.5 keV 开始平缓
// 上升，到 10 keV 时约 0.85；绿色曲线从约 3 keV 开始上升，
// 到 10 keV 时约 0.80；黑色曲线从约 3.5 keV 开始上升，到
// 10 keV 时约 0.77。嵌入图中有一条竖直灰色虚线位于 5.4
// keV 处，旁边标注“50% Efficiency: 5.4 keV”，该虚线穿过
// 橙色、绿色和黑色曲线，黑色曲线的 50% 效率点约在 5.4
// keV 附近。嵌入图无独立图例，曲线颜色与主图图例一致。整
// 体趋势表明，经过 S2 触发后效率在高能区接近 1，而后续
// SS 重建、数据分析 cuts 与 S1/S2 ROI 主要影响低能阈值与
// 高能下降位置；灰色不确定度带在约 10–50 keV 间较宽，在
// 50 keV 以上随效率下降而收敛至 0。
#figure(image("imgs/figure2.png", width: 100%),
  caption: [
    Energy-dependent NR signal efficiency in WS2024 after the application, in sequence, of the S2 trigger (blue); SS reconstruction and analysis cuts (orange); S2 ROI (green) followed by the S1 ROI (black). The inset shows the low-energy behavior, with the dotted line at 5.4~keV marking 50\% efficiency. The uncertainty band (gray) is assessed using AmLi and tritium data as discussed in the text.
  ]
)
<fig:NRacceptance>



To mitigate analyzer bias, artificial, WIMP-like events are injected at random times into the data pipeline, a process referred to as “salting.” Salt events are pre-generated by combining S1 and S2 pulses from sequestered tritium and AmLi calibration data sets. The pulse sizes for a given event are chosen to best match those expected from an NR energy deposition drawn from a parent distribution consisting of the sum of an exponential (WIMP-like) and a flat spectrum. The salt injection rate and parameters of the parent energy distribution were generated randomly within predefined bounds and kept hidden for the entirety of the analysis. Eight salt events were injected, of which one was removed by analysis cuts, consistent with the NR signal efficiency. The other seven events were revealed as salt following the final definition of the data selection criteria and the likelihood models. More details about the salting distribution can be found in the Supplemental Material~@Supplemental.


The 1220 events which remain in the 3.3 tonne-year exposure of WS2024 after the application of all data selections and salt removal are shown in @fig:r2z and~@fig:data. These events are analyzed using a likelihood model in the $( upright("S1") c , upright("log")_10 ( upright("S2") c ) )$ observables. Signal and background model distributions are generated using #smallcaps[nest] and event simulations~@LZSims, with the exception of the accidental coincidence background model, which follows a data-driven method identical to that used for the WS2022 result~@LZ-backgrounds. The primary backgrounds and their treatment are similar to those of the WS2022 analysis, with the expected counts for each background source given in @tab:backgrounds. Notable differences are now described.


Two sources of background NR events are considered: those originating from neutrino interactions and those from radioactive decays in detector components. The neutrino interactions are from CE$nu$NS of solar ($""^8$B and #emph[hep]) and cosmic-ray-generated atmospheric neutrinos. Nuclear recoils that originate from spontaneous fission and $( alpha , n )$ reactions in detector materials can be vetoed by detecting the scattered neutrons and/or associated $gamma$ rays in the Skin and/or OD. Events vetoed by these systems are used as a sideband to derive an #emph[in-situ] constraint on the number of neutron events in the WIMP search data. As discussed later, the sideband is incorporated directly into the final statistical analysis; a sideband-only fit returns an expectation of $0^(+ 0.2)$ SS counts, as shown in @tab:backgrounds. Secondary estimates from simulations based on detector material radioassays and from data using candidate MS neutron events tagged by the veto detectors return expectations of $0.05 plus.minus 0.01$ and $0.3 plus.minus 0.2$ neutron counts, respectively, consistent with the primary analysis.


Electron capture (EC) and double electron capture (DEC) decays deposit their energy via X ray and Auger cascades in a more localized profile than a $beta$ particle of the equivalent energy, leading to higher ionization densities and enhanced electron-ion recombination. As a result, EC and DEC events look more NR-like than $beta$ decays, as reported in @XELDA-Lshell. Preliminary measurements of this effect for ECs in LZ were performed with sidebands of Skin-tagged and multiple scatter decays of $""^127$Xe and $""^125$Xe, isotopes that have been produced #emph[in situ] via neutron activation. These yield a charge-yield ratio of $Q_y^(upright("L")) / Q_y^beta = 0.87 plus.minus 0.03$ for 5.2~keV L-shell EC decays relative to $beta$ decays of the same energy~@aalbers2025measurementsmodelsenhancedrecombination.


Two-neutrino DEC decays of $""^124$Xe are observed in LZ with a half-life of $T_(1 / 2) = ( 1.09 plus.minus 0.14_(upright("stat")) plus.minus 0.05_(upright("sys")) ) times  ×  10^22 med "yr"$~@LZ-Xe124, consistent with that in Ref.~@XENONnT-Xe124_Xe136-2022. The expected number of $""^124$Xe counts in the ROI is estimated assuming an abundance of $9.52 times 10^(- 4)$~@XeAbundances and branching ratios for the LL (10.00~keV) and LM (5.98~keV) decay modes of 1.4% and 0.8%, respectively. The LM charge suppression is modeled with the same ratio of 0.87 as used for single EC decays. The overlap of two L-shell cascades in LL-shell capture should result in additional recombination. As an independent measurement of the LL-shell charge yield is not available, the Thomas-Imel (TI) box model ~@thomas1987recombination @szydagis2022review is invoked to relate the ionization density to the amount of electron-ion recombination at a given applied electric field. The ratio of the charge yield for LL-shell DEC to $beta$ decays of the same energy, $Q_y^(upright("LL")) / Q_y^beta$, is treated as a free parameter in the statistical analysis, bounded on one side by the measured $Q_y^(upright("L")) / Q_y^beta$ for WS2024 (0.87) and on the other side by the result from a preliminary study of increasing the ionization density in the TI box model (0.65).


The largest ER background contribution in this exposure comes from $beta$-emitting isotopes in the LXe bulk. Xenon sampling measurements indicate a concentration of $1.10 plus.minus 0.18$~ppb $""^(upright("nat"))$Ar g/g and an exposure-averaged concentration of $186 plus.minus 26$~ppq $""^(upright("nat"))$Kr g/g. These are used to estimate the contributions of $""^39$Ar and $""^85$Kr, respectively. Exposure in the high-mixing state includes residual tritium and $""^14$C activity following their injection for ER calibrations, and both their beta spectra are therefore incorporated into the background model for this period.


Radon emanates from materials exposed to xenon, dispersing in the active volume. With a measured FV activity of $3.9 plus.minus 0.4$~$mu$Bq/kg, $""^214$Pb decays from the $""^222$Rn chain, in particular those to the ground state, form the dominant ER background. We attribute the higher activity in WS2024 with respect to WS2022 ($3.26 med mu$Bg/kg @LZ-backgrounds) to the lower drift field, as charged radon daughter progeny move more slowly out of the fiducial volume. A method to identify events with high likelihood of being a $""^214$Pb decay --- the radon tag --- is developed using simulations of the movement of daughter atoms and ions built from observed flow vectors between $""^222$Rn-$""^218$Po $alpha$-decay pairs. A tag volume in which it is probable to find a $""^214$Pb decay is defined for each identified $""^218$Po alpha decay, co-moving with the projected flow streamline for 81~min or approximately three times the $""^214$Pb half-life. The tag volume includes two flowpaths to account for neutral and ionized daughters. The radon tag can only be applied in the low-mixing state, where the flow can be modeled. Additional periods in the low-mixing state during which radon tagging is not possible, for example around gaps in data acquisition or after flow disturbances induced by power outages, are labeled as radon-tag-inactive. To summarize, we have four categories of WS2024 exposure: (1) high-mixing, where a radon tag is not possible; (2) low-mixing, but with the radon tag inactive due to interruptions; (3) low-mixing, active radon tag and radon-tagged, with a high probability to contain $""^214$Pb decays; and (4) low-mixing, active radon tag and radon-untagged, with a lower probability to contain $""^214$Pb decays.


For WS2024, 15% of the low-mixing, tag-active exposure is identified as radon-tagged, containing on average $60 plus.minus 4$% of the total $""^214$Pb as estimated directly by measurements of its excited-state decays.


The effective $""^214$Pb activity in the untagged remainder of the tag-active exposure is thus $1.8 plus.minus 0.3$~$mu$Bq/kg. The radon-tagged data set can be seen in the bottom panel of @fig:data.


The separation into radon-tagged and untagged exposures offers the benefit of being able to better identify and constrain other background contributions, $""^124$Xe in particular.


// [figvision-cn] imgs/figure3.png
// 这是一张由上下两个子图组成的科学论文插图，两者共享同一
// 横轴。子图类型均为二维散点图，并叠加了多条等能曲线、阴
// 影带及闭合轮廓线。横轴名称为“S1c [phd]”，线性刻度，范
// 围0至80，主刻度间隔为10，次刻度间隔为2。纵轴名称为“
// log10(S2c [phd])”，线性刻度，范围约2.75至4.25，主刻度
// 分别为2.75、3.00、3.25、3.50、3.75、4.00、4.25，每个主
// 刻度之间有4个次刻度。 图中有两种数据点分布：大量黑色小
// 圆点代表事例；图中还有灰色阴影带、紫色阴影带、绿色闭合
// 轮廓线、橙色曲线和灰色曲线。 子图(a)位于上半部分，其右
// 侧中间标注文字“All Data”。该子图展示了所有通过筛选条件
// 的事例分布，黑点密集分布在横轴5至80、纵轴3.5至4.1的区
// 域，在横轴0至5附近黑点较稀疏。灰色阴影带呈横向带状，从
// 左向右略微上升，覆盖纵轴约3.6至3.9的范围，其内缘有灰色
// 轮廓线。紫色阴影带从左下角向右上方弯曲延伸，覆盖横轴0
// 至40、纵轴2.8至3.5的区域，呈上窄下宽的弯曲带状。绿色闭
// 合轮廓线有三条同心椭圆形，中心大致位于横轴40、纵轴3.7，
// 覆盖横轴30至80、纵轴3.55至3.9的区域。橙色曲线自左上方
// 进入，先急剧下降，在横轴5附近形成拐点，再向右下方延伸，
// 最后在横轴60附近形成回环，最低点到达纵轴约2.85。灰色曲
// 线自左上方向右下方弯曲延伸，有多条，分别标注了能量。
// 子图(b)位于下半部分，其右侧中间标注文字“Radon Tagged”。
// 该子图展示的是被氡标记的事例分布，黑点密度明显低于子图
// (a)，在横轴5至80、纵轴3.5至4.2的区域有分布，但数量较少。
// 灰色阴影带和紫色阴影带与子图(a)位置和形状基本一致，但
// 灰色阴影带内黑点更稀疏。绿色闭合轮廓线同样有三条同心椭
// 圆形，中心位置与子图(a)类似，但轮廓范围略小，覆盖横轴
// 35至75、纵轴3.6至3.9的区域。橙色曲线和灰色曲线的形状与
// 子图(a)一致。 图中标注文字与符号包括：纵轴刻度2.75、
// 3.00、3.25、3.50、3.75、4.00、4.25，横轴刻度0、10、20、
// 30、40、50、60、70、80。子图(a)中标注“All Data”，子图(
// b)中标注“Radon Tagged”。下方还有一排灰色虚线标注，从左
// 到右依次为：“0.8 keV_ee / 5 keV_nr”、“2.8 keV_ee / 15
// keV_nr”、“5.0 keV_ee / 25 keV_nr”、“7.2 keV_ee / 35
// keV_nr”。灰色曲线上方标注“9.5 keV_ee / 45 keV_nr”、“
// 13.1 keV_ee / 60 keV_nr”。这些标注均以垂直虚线对应到横
// 轴位置。 该子图传达的趋势与结论：通过对比上下两图，可
// 以看出“Radon Tagged”数据集的事例数量显著减少，但绿色轮
// 廓线（可能代表某种物理信号区域）仍然保留，而紫色阴影带
// 和灰色阴影带与“All Data”中的位置一致，说明氡标记数据集
// 中某些背景（如Xe）的相对贡献可能发生变化。图注说明氡标
// 记数据集包含了60%的Pb和15%的分散背景活动，因此与全部数
// 据的对比突出了非Pb背景（如Xe）的贡献。
#figure(image("imgs/figure3.png", width: 100%),
  caption: [
    Black points show the final set of events passing all selection cuts with the panels distinguishing all events in WS2024 (top) from those that are radon tagged (bottom). The radon-tagged data set contains 60% and 15% of the full FV activity of the $""^214$Pb and dispersed backgrounds, respectively; thus, the comparison with all data brings to prominence the non-$""^214$Pb backgrounds like $""^124$Xe that are not well-described by the ER band. Dark and light gray and purple shading show the regions containing 68% and 95% of the ER portion of the background model and a 40~GeV/$c^2$ WIMP, respectively. Green and orange contours show the same quantiles for the best-fit $""^124$Xe distribution and the accidental coincidence events, respectively. Gray lines show contours of constant ER-equivalent ($"keV"_"ee"$) and NR-equivalent ($"keV"_"nr"$) energy.
  ]
)
<fig:data>



#figure(align(center)[#table(
    stroke: none,
    columns: 5,
    align: (left,right,left,right,left,),
    table.hline(stroke: 0.8pt),
    table.header([Source], table.cell(align: left, colspan: 2)[Pre-fit Expectation], table.cell(align: center, colspan: 2)[Fit Result],),
    table.hline(),
    table.hline(),
    [$beta$s], [743], [~$plus.minus$ 88], [733], [~$plus.minus$ 34],
    [$""^85$Kr + $""^39$Ar $beta$s + det. $gamma$s], [162], [~$plus.minus$ 22], [161], [~$plus.minus$ 21],
    [Solar $nu$ ER], [102], [~$plus.minus$ 6], [102], [~$plus.minus$ 6],
    [$""^212$Pb + $""^218$Po $beta$s], [62.7], [~$plus.minus$ 7.5], [63.7], [~$plus.minus$ 7.4],
    [Tritium+ $""^14$C $beta$s], [58.3], [~$plus.minus$ 3.3], [59.7], [~$plus.minus$ 3.3],
    [$2 nu beta beta$], [55.6], [~$plus.minus$ 8.3], [55.9], [~$plus.minus$ 8.2],
    [DEC], [19.4], [~$plus.minus$ 2.5], [20.4], [~$plus.minus$ 2.4],
    [+ EC], [3.2], [~$plus.minus$ 0.6], [2.7], [~$plus.minus$ 0.6],
    [Accidental coincidences], [2.8], [~$plus.minus$ 0.6], [2.6], [~$plus.minus$ 0.6],
    [$upright("Atm") thin upright(".") nu$ NR], [0.12], [~$plus.minus$ 0.02], [0.12], [~$plus.minus$ 0.02],
    [$""^8$B$+ h e p nu$ NR], [0.06], [~$plus.minus$ 0.01], [0.06], [~$plus.minus$ 0.01],
    table.hline(),
    [Detector neutrons], table.cell(align: left, colspan: 2)[$0.0^(+ 0.2)$], table.cell(align: center, colspan: 2)[$0.0^(+ 0.2)$],
    [40~GeV/$c^2$ WIMP], [], [--], table.cell(align: center, colspan: 2)[$0.0^(+ 0.6)$],
    table.hline(),
    [Total], [1210], [~$plus.minus$ 91], [1202], [~$plus.minus$ 41],
    table.hline(stroke: 0.8pt),
  )], caption: [The expected and best-fit counts for different sources in the 3.3~tonne-year exposure of WS2024, including a 40~GeV/$c^2$ WIMP signal. Flat $beta$-decay components have been separated based on whether they are affected by the flow state or the radon tag, and the neutron counts are derived #emph[in situ]. “Det. $gamma$s” refers to $gamma$-ray contributions from detector materials, whose Compton spectra are also flat in the ROI.], kind: table) <tab:backgrounds>


The data are divided into six mutually exclusive samples, which are simultaneously analyzed using an unbinned, extended maximum likelihood. Five of these apply to the new 220~live-day exposure and describe: the (1-4) WS2024 samples described previously


and (5) events tagged by the Skin or OD. The nuisance parameters, which float within their uncertainties, are the expected number of events for each background source, listed in @tab:backgrounds; the radon tagging efficiency; the neutron veto tagging efficiency; and the $""^124$Xe $Q_y^(upright("LL")) / Q_y^beta$, bounded between 0.65 and 0.87. Parameters characterizing $""^222$Rn and $""^220$Rn daughter backgrounds, tritium and $""^14$C are independent in the high- and low-mixing state exposures. The sixth sample in the likelihood represents WS2022, containing the data and models from the first, 60 live-day WIMP search result~@SR1WS. The full WS2024 data set is shown in the top panel of @fig:data. All six samples can be seen in Fig. S1 of the Supplemental Material~@Supplemental, where we also report their exposures.


// [figvision-cn] imgs/figure4.png
// 这是一张包含上下两个面板的阶梯直方图（step histogram），
// 用于展示实验数据与最佳拟合模型的比较。两个面板共享同一
// 个横坐标轴，范围从 -6 到 4，表示归一化后的对数电荷比参
// 数 \((\log_{10}(\text{S2c}) - \mu_{ER}) / \sigma_{ER}\
// )，该变量以 ER 带中位数为中心并按带宽进行归一化，无量
// 纲。纵坐标轴为 “Events”，采用对数刻度，范围从 \(10^{-2
// }\) 到 \(10^2\)。横轴在整数处有主刻度，纵轴在每个数量
// 级处有标记。 图例位于图像顶部，包含以下条目：黑色圆点
// 代表 “Data”（数据）；粗蓝实线代表 “Total Bkg”（总本底）；
// 浅蓝实线代表 \(^{214}\text{Pb } \beta\text{s}\)；粉色
// 实线代表 “Other ER”；墨绿色实线代表 \(^{124}\text{Xe
// DEC}\)；橙色实线代表 \(^{127}\text{Xe} + ^{125}\text{
// Xe EC}\)；黄色实线代表 “Accidentals”（偶然符合）；淡紫
// 色实线代表 \(^8\text{B}\)；紫色虚线代表 “40 GeV/\(c^2\
// ) WIMP”。 上面板标注有文字 “\(3 < \text{S1c} < 40 \
// text{ phd}\)”，表示选取的 S1 信号区间为 3 到 40 光电倍
// 增管光子数（phd）。在该面板中，y 轴从 \(10^{-2}\) 线性
// 延伸至约 \(2\times10^2\)。黑色数据点呈钟形分布，峰值在
// x=0 附近，约为 \(1.2\times10^2\) 个事件。粗蓝线（总本
// 底）紧密跟随数据点。粗蓝线周围包裹着一层浅蓝色半透明阴
// 影带，代表总本底的不确定性区间。各本底分量阶梯线分布如
// 下：浅蓝线（\(^{214}\text{Pb } \beta\text{s}\)）在 x=0
// 附近达到峰值约 \(1.1\times10^2\)，是主导本底；粉色线（
// Other ER）在 x=0 附近峰值为 \(2\times10^1\)；墨绿色线
// （\(^{124}\text{Xe DEC}\)）在 x=0 附近峰值为 \(1.5\)；
// 橙色线（\(^{127}\text{Xe} + ^{125}\text{Xe EC}\)）在 x
// =-1 附近峰值为 \(0.6\)；黄色线（Accidentals）在低 x 值
// 处较高，在 x=-4 附近约为 \(0.2\)，向右逐渐下降；淡紫色
// 线（\(^8\text{B}\)）在 x=-1 附近约为 \(0.1\) 并向右下
// 降。紫色虚线（40 GeV/\(c^2\) WIMP）在整个区间内均低于
// \(10^{-1}\)，其峰值在 x=-1 附近约为 \(0.2\)，并在 x=-5
// 处有一个次峰，约为 \(10^{-1}\)。在上方面板的极左侧，粗
// 蓝线及其误差阴影带宽度显著增大，但数据点在 x < -4 的区
// 域未显示。 下面板标注有文字 “\(40 < \text{S1c} < 80 \
// text{ phd}\)”，表示选取的 S1 信号区间为 40 到 80 phd。
// 坐标轴范围和刻度与上面板相同。黑色数据点同样呈钟形分布，
// 峰值在 x=0 附近，约为 \(1.3\times10^2\) 个事件。各分量
// 阶梯线的形状与上面板大致相似，但部分相对幅度有变化：浅
// 蓝线（\(^{214}\text{Pb } \beta\text{s}\)）峰值为 \(1.1
// \times10^2\)；粉色线（Other ER）峰值为 \(2.5\times10^1
// \)；墨绿色线（\(^{124}\text{Xe DEC}\)）峰值为 \(3\)；
// 橙色线（\(^{127}\text{Xe} + ^{125}\text{Xe EC}\)）的峰
// 值向右偏移至 x=-2 附近，值约为 \(0.03\)；黄色线（
// Accidentals）在 x=-3 附近约为 \(0.02\)；淡紫色线（\(^8
// \text{B}\)）的幅度极小，基本贴近底线。紫色虚线（40 GeV
// /\(c^2\) WIMP）在该面板中的幅度更低，峰值在 x=-2 附近，
// 约为 \(0.02\)。粗蓝线（总本底）与数据点高度吻合，浅蓝
// 色误差带覆盖了数据点。 整体趋势表明，在两个 S1 区间内，
// 实验数据点（黑点）与包含各本底分量的总本底模型（粗蓝线）
// 吻合良好。无论是在上面板还是下面板中，40 GeV/\(c^2\)
// 的 WIMP 信号（紫色虚线）的幅度都非常小，远低于观测到的
// 事件数和总本底，其影响在图中被极大抑制。
#figure(image("imgs/figure4.png", width: 100%),
  caption: [
    Comparison between data and the best-fit model for WS2024 corresponding to the values shown in @tab:backgrounds for a background plus a 40 GeV/$c^2$ WIMP signal fit in a projection along the ER band median, normalized to the $1 sigma$ band width. The 40 GeV/$c^2$ WIMP component is shown with an amplitude equal to its power-constrained 90\% C.L. upper limit. The upper and lower panels select the S1$c$ ranges 3--40 phd and 40--80 phd with $p$ values of 0.55 and 0.59, respectively. Shaded bands depict the central interval containing 68\% of the combined systematic and statistical uncertainties of the model.
  ]
)
<fig:gof>



The best-fit number of WIMPs at all masses tested (between 9~GeV/$c^2$ and 100~TeV/$c^2$) for the combined WS2024+WS2022 analysis is zero. The goodness of fit of the background-only model is assessed in binned 1D projections of the data and model into $upright("S1") c$, $upright("log")_10 ( upright("S2") c )$, reconstructed energy, distance from the ER band median, as well as the 2D space of $( upright("S1") c , upright("log")_10 ( upright("S2") c ) )$. All samples show excellent model-data agreement, passing a Holm-Bonferroni test~@Holm1979ASS with a significance level of 0.05. @fig:gof shows the WS2024 data and model in the 1D projection along the ER band median, illustrating the level of agreement through the tails of the distribution with the inclusion of the modified $""^124$Xe response. The fitted values of the radon tagging efficiency and the $""^124$Xe $Q_y^(upright("LL")) / Q_y^beta$ are consistent across all masses, at $62 plus.minus 3$\% and $0.70 plus.minus 0.04$, respectively, in agreement with the pre-fit expectations.



@fig:limit shows the 90\% confidence level upper limit on the spin-independent WIMP-nucleon cross section as a function of mass following inference performed with a two-sided, unbinned profile likelihood ratio test statistic~@cowan2011asymptotic. The limit is power constrained at all WIMP masses to $1 sigma$ below the median expectation following the recommendation in Ref.~@baxter2021recommended. The fluctuation, and therefore the size of the constraint, is largest between 20 and 50~GeV/$c^2$. This is a consequence of the inclusion of the WS2022 data from Ref.~@SR1WS, which exhibit an underfluctuation in this region. The limit for the WS2024 data alone can be found in the Supplemental Material~@Supplemental, with an approximate $- 1 sigma$ fluctuation across the entire mass range, primarily attributed to an underfluctuation of the accidental coincidence background in the region of largest overlap with expected WIMP distributions. The minimum of the limit curve is $2.2 times 10^(- 48)$~cm$""^2$ at 40~GeV/$c^2$ while that of the median expected limit is $5.1 times 10^(- 48)$~cm$""^2$ at 40~GeV/c$""^2$. The best median $3 sigma$ observation potential is $1.1 times 10^(- 47)$~cm$""^2$ at 40~GeV/c$""^2$. Results of searching for evidence of spin-dependent WIMP-nucleon couplings are discussed in the Appendix.


// [figvision-cn] imgs/figure5.png
// 这是一张双对数坐标系的科学论文插图，展示不同暗物质探测
// 实验给出的WIMP-核子自旋无关散射截面上限随WIMP质量变化
// 的关系。图的横轴为WIMP Mass [GeV/c²]，采用对数刻度，范
// 围从10¹到10⁴，主要刻度标注为10¹、10²、10³、10⁴；纵轴为
// WIMP-nucleon σ_SI [cm²]，采用对数刻度，范围从10⁻⁴⁸到10
// ⁻⁴⁴，主要刻度标注为10⁻⁴⁸、10⁻⁷、10⁻⁴⁶、10⁻⁴⁵、10⁻⁴⁴。
// 图中所有曲线均呈现低质量端上升、中间质量端降至最低点、
// 高质量端再上升的U形趋势。图中右上角绘有若干其他实验的
// 上限曲线：橙色曲线标有DEAP-3600 (2019)，其最低点约在60
// GeV/c²处、截面约10⁻⁴⁵ cm²；红色曲线标有LUX (2017)，最
// 低点约在50 GeV/c²处、截面约10⁻⁴⁶ cm²；绿色曲线标有
// XENON1T (2018)，最低点约在60 GeV/c²处、截面约3×10⁻⁴⁷
// cm²；深绿色曲线标有XENONnT (2023)，最低点约在40 GeV/c²
// 处、截面约2×10⁻⁴⁷ cm²；紫色曲线标有LZ (2023)，最低点约
// 在40 GeV/c²处、截面约1×10⁻⁴⁷ cm²；蓝色曲线标有
// PandaX-4T (2025)，最低点约在40 GeV/c²处、截面约8×10⁻⁴⁸
// cm²。图中右下角有一条粗黑色实线，标有LZ (2025)，其最低
// 点约在40 GeV/c²处、截面约2×10⁻⁴⁸ cm²，为该图展示的最严
// 格上限。粗黑实线周围有绿色阴影区域，表示背景涨落导致的
// 预期上限的68%范围；绿色阴影外围有黄色阴影区域，表示预
// 期上限的95%范围。绿色和黄色阴影区域内还包含一条黑色虚
// 线，表示预期上限的中位数。粗黑实线下方有一条灰色点划线，
// 表示无功率约束的上限，其在低质量端略低于粗黑实线。图中
// 还有一条黑色点线，表示中位3σ发现潜力，其位置在黑色虚线
// 上方，与虚线平行。图例位于右下角，自上而下依次为：黑色
// 点线“Median 3σ discovery potential”、黑色虚线“Median
// expected upper limit”、粗黑实线“Power constrained
// upper limit”、灰色点划线“Unconstrained upper limit”。
// 该图传达的结论是：LZ (2025) 给出的功率约束上限在大部分
// WIMP质量范围内优于其他实验的上限，且该上限与预期上限的
// 中位数及背景涨落范围一致；无功率约束的上限在低质量端略
// 更严格，但整体趋势相似。
#figure(image("imgs/figure5.png", width: 100%),
  caption: [
    Upper limits (90\% C.L.) on the spin-independent WIMP-nucleon cross section as a function of WIMP mass from the combined WS2024+WS2022 analysis (280.0~live days) are shown with a solid black line, with a $- 1 sigma$ power constraint applied. The gray dot-dash line shows the limits without the power constraint; green and yellow regions show the range of expected upper limits from 68\% and 95\% of background-only experiments, while the dashed black line indicates the median expectation, obtained with post-fit background estimates. The median $3 sigma$ observation potential from the post-fit model is shown as a dotted black line. Also shown are limits from WS2022 only~@SR1WS, PandaX-4T~@PandaX:2024qfu, LUX~@akerib2017results, all power constrained to $- 1 sigma$\; XENONnT~@XENON:2023cxc, reinterpreted with a $- 1 sigma$ power constraint; XENON1T~@collaboration2018dark, and DEAP-3600~@DEAP:2019yzn.
  ]
)
<fig:limit>



In summary, LZ has achieved limits on SI WIMP-nucleon interactions that surpass previous best exclusions by a factor of four or more for WIMP masses $>$9~GeV/$c^2$. A radon tag to target the dominant ER background from $""^214$Pb decays has been demonstrated, with potential for optimization that will allow it to have greater impact on the sensitivities of future searches, particularly for physics with potential ER signals. The enhanced electron-ion recombination of $""^124$Xe LL-shell DEC events was noted for the first time, and will be further investigated in future analyses. The experiment continues to take salted data towards a target 1000-day live time that will enable more sensitive searches for WIMP interactions and other new phenomena.


#emph[Acknowledgements] - The research supporting this work took place in part at the Sanford Underground Research Facility (SURF) in Lead, South Dakota. Funding for this work is supported by the U.S. Department of Energy, Office of Science, Office of High Energy Physics under Contract Numbers DE-AC02-05CH11231, DE-SC0020216, DE-SC0012704, DE-SC0010010, DE-AC02-07CH11359, DE-SC0015910, DE-SC0014223, DE-SC0010813, DE-SC0009999, DE-NA0003180, DE-SC0011702, DE-SC0010072, DE-SC0006605, DE-SC0008475, DE-SC0019193, DE-FG02-10ER46709, UW PRJ82AJ, DE-SC0013542, DE-AC02-76SF00515, DE-SC0018982, DE-SC0019066, DE-SC0015535, DE-SC0019319, DE-SC0024225, DE-SC0024114, DE-AC52-07NA27344, & DE-SC0012447. This research was also supported by U.S. National Science Foundation (NSF); the UKRI's Science & Technology Facilities Council under award numbers ST/W000490/1, ST/W000482/1, ST/W000636/1, ST/W000466/1, ST/W000628/1, ST/W000555/1, ST/W000547/1, ST/W00058X/1, ST/X508263/1, ST/V506862/1, ST/X508561/1, ST/V507040/1, ST/W507787/1, ST/R003181/1, ST/R003181/2, ST/W507957/1, ST/X005984/1, ST/X006050/1; Portuguese Foundation for Science and Technology (FCT) under award numbers PTDC/FIS-PAR/2831/2020; the Institute for Basic Science, Korea (budget number IBS-R016-D1); the Swiss National Science Foundation (SNSF) under award number 10001549. This research was supported by the Australian Government through the Australian Research Council Centre of Excellence for Dark Matter Particle Physics under award number CE200100008. We acknowledge additional support from the UK Science & Technology Facilities Council (STFC) for PhD studentships and the STFC Boulby Underground Laboratory in the U.K., the GridPP~@faulkner2005gridpp @britton2009gridpp and IRIS Collaborations, in particular at Imperial College London and additional support by the University College London (UCL) Cosmoparticle Initiative, and the University of Zurich. We acknowledge additional support from the Center for the Fundamental Physics of the Universe, Brown University. K.T. Lesko acknowledges the support of Brasenose College and Oxford University. The LZ Collaboration acknowledges the key contributions of Dr. Sidney Cahn, Yale University, in the production of calibration sources. This research used resources of the National Energy Research Scientific Computing Center, a DOE Office of Science User Facility supported by the Office of Science of the U.S. Department of Energy under Contract No. DE-AC02-05CH11231. We gratefully acknowledge support from GitLab through its GitLab for Education Program. The University of Edinburgh is a charitable body, registered in Scotland, with the registration number SC005336. The assistance of SURF and its personnel in providing physical access and general logistical and technical support is acknowledged. We acknowledge the South Dakota Governor's office, the South Dakota Community Foundation, the South Dakota State University Foundation, and the University of South Dakota Foundation for use of xenon. We also acknowledge the University of Alabama for providing xenon. For the purpose of open access, the authors have applied a Creative Commons Attribution (CC BY) license to any Author Accepted Manuscript version arising from this submission. Finally, we respectfully acknowledge that we are on the traditional land of Indigenous American peoples and honor their rich cultural heritage and enduring contributions. Their deep connection to this land and their resilience and wisdom continue to inspire and enrich our community. We commit to learning from and supporting their effort as original stewards of this land and to preserve their cultures and rights for a more inclusive and sustainable future.


= Appendix - Spin Dependent Results
<appendix---spin-dependent-results>


// [figvision-cn] imgs/figure6.png
// 这是一张单面板的二维曲线图，用于展示不同暗物质直接探测
// 实验对WIMP-核子自旋相关散射截面的限制及探测潜力。图中
// 横轴为WIMP质量，单位是GeV/c²，采用对数坐标，范围从10¹
// 到10⁴；纵轴为WIMP-中子自旋相关散射截面σ_SD，单位是cm²，
// 采用对数坐标，范围从10⁻⁴³到10⁻³⁹。图中所有曲线均呈现先
// 下降后上升的“U”形趋势，在质量约为30至40 GeV/c²处达到最
// 低点（即最严格的限制）。图中共有五条彩色实线，分别对应
// 不同实验或未来项目的预期灵敏度：浅蓝色曲线标注为“
// PandaX-II (2019)”，其最低点截面约为1.5×10⁻⁴¹ cm²；浅红
// 色曲线标注为“LUX (2017)”，其最低点截面约为1.8×10⁻⁴¹ cm
// ²；黄绿色曲线标注为“XENON1T (2019)”，其最低点截面约为7
// ×10⁻⁴² cm²；紫色曲线标注为“LZ (2023)”，其最低点截面约
// 为1.5×10⁻⁴² cm²；粉色曲线标注为“XENONnT (2023)”，其最
// 低点截面约为5×10⁻⁴² cm²。图中黑色粗实线标注为“LZ (2025
// )”，代表功率约束上限（Power constrained upper limit），
// 在低质量区（10 GeV/c²附近）截面约为10⁻⁴¹ cm²，在最低点
// （约40 GeV/c²）处截面约为4×10⁻⁴³ cm²，随后随质量增加而
// 上升，在10⁴ GeV/c²处约为5×10⁻⁴¹ cm²。黑色粗实线周围环
// 绕着一条浅灰色阴影带，标注为“Band: Xe SD-n Nucl.
// Uncert.”，表示由于核模型不确定性带来的误差范围，该阴影
// 带在低质量区较宽，在最低点处相对较窄，并随质量增加而略
// 微变宽。图中还有一条黑色点线，标注为“Median 3σ
// discovery potential”，其形状与黑色实线类似，但整体位置
// 略高，在最低点处截面约为1.5×10⁻⁴² cm²。图右下角有图例，
// 说明黑色点线代表“Median 3σ discovery potential”，黑色
// 实线代表“Power constrained upper limit”。图中未显示显
// 微照片或示意图，所有标注文字均清晰可见，曲线线型分别为
// 实线、点线和阴影带。整体趋势表明，随着WIMP质量增加，探
// 测灵敏度先提高后降低，且LZ (2025) 的预期限制在大部分质
// 量范围内优于其他已公布的实验结果，其灰色不确定性带覆盖
// 了从约10 GeV/c²到10⁴ GeV/c²的整个质量范围。
#figure(image("imgs/figure6.png", width: 100%),
  caption: [
    The 90\% confidence-level upper limit (solid-black curve) using the mean of the nuclear structure functions from~@PhysRevD.102.074018, allowing for like-to-like comparison with other results. The gray band indicates the uncertainty due to nuclear modeling across models from~@PhysRevD.102.074018 @Pirinen:2019gap @PhysRevLett.128.072502 and applies similarly to the limit from all xenon-based experiments. The dotted line shows the median $3 sigma$ observation significance from the post-fit model. Also shown are the WS2022 only~@SR1WS, XENONnT~@XENON:2023cxc (reinterpreted with a $- 1 sigma$ power constraint), XENON1T~@collaboration2019constraining, PandaX-II~@xia2019pandax, and LUX~@akerib2017limits limits.
  ]
)
<fig:limitplotSDn>



// [figvision-cn] imgs/figure7.png
// 这是一张双对数坐标曲线图，横轴表示WIMP质量，单位为GeV/
// c²，范围从10¹到10⁴；纵轴表示WIMP-质子自旋相关散射截面，
// 单位为cm²，范围从10⁻⁴¹到10⁻³⁷。图中包含多条不同颜色的
// 曲线，均呈先下降后上升的U形趋势，代表不同实验给出的上
// 限。红色曲线标注LUX (2017)，蓝色曲线标注PandaX-II (
// 2019)，绿色曲线标注XENON1T (2019)，洋红色曲线标注
// XENONnT (2023)，紫色曲线标注LZ (2023)，橙色曲线标注
// PICO-60 (2019)。黑色粗实线代表LZ (2025)的功率约束上限，
// 位于所有曲线最下方，在质量约30-40 GeV/c²处达到最低点约
// 10⁻⁴¹ cm²。黑色虚线代表中位3σ发现潜力，位于黑色实线上
// 方。灰色阴影带标注为“Band: Xe SD-p Nucl. Uncert.”，覆
// 盖从约10⁻⁴¹到10⁻³⁸ cm²的范围，包裹黑色实线并延伸至其他
// 曲线区域。右下角图例说明黑色虚线为“Median 3σ discovery
// potential”，黑色实线为“Power constrained upper limit”。
// 图注说明黑色实线为90%置信水平上限，灰色带表示核建模不
// 确定性。
#figure(image("imgs/figure7.png", width: 100%),
  caption: [
    The 90\% confidence-level upper limit (solid-black curve) using the mean of the nuclear structure functions from~@PhysRevD.102.074018, allowing for like-to-like comparison with other results. The gray band indicates the uncertainty due to nuclear modeling across models from~@PhysRevD.102.074018 @Pirinen:2019gap @PhysRevLett.128.072502 and applies similarly to the limit from all xenon-based experiments. The dotted line shows the median $3 sigma$ observation significance from the post-fit model. Also shown are the PICO-60~@amole2019dark, LZ WS2022 only~@SR1WS, XENONnT~@XENON:2023cxc (reinterpreted with a $- 1 sigma$ power constraint), XENON1T~@collaboration2019constraining, PandaX-II~@xia2019pandax, and LUX~@akerib2017limits limits. The PICO-60 result relies on WIMP-scattering on the spin of the unpaired proton of $""^19$F with minimal uncertainty.
  ]
)
<fig:limitplotSDp>



In this Appendix we report limits on the spin-dependent WIMP-nucleon cross section using the same data selection, background modeling, and statistical inference techniques described in the main text. Results follow an identical procedure to that in Ref.#cite(<SR1WS>): signal models which describe scattering on ~(spin $1 / 2$, 26.4~\% natural abundance) and ~(spin $3 / 2$, 21.2~\% natural abundance)~@XeAbundances are constructed using the neutron- and proton-only nuclear structure functions and their uncertainties from Refs.~@PhysRevD.102.074018 @Pirinen:2019gap @PhysRevLett.128.072502. The nominal limits use the mean structure functions from~@PhysRevD.102.074018 and allow for a consistent comparison with previous limits from xenon-based experiments. As in Ref.~@SR1WS, an uncertainty band is calculated at each WIMP mass using the extrema of power-constrained limits obtained from the minimum and maximum nuclear structure function uncertainties provided in Refs.~@PhysRevD.102.074018 @Pirinen:2019gap @PhysRevLett.128.072502.


The best-fit number of WIMP events is zero at all tested masses, from 9~GeV/$c^2$ to 100~TeV/$c^2$. The black line of @fig:limitplotSDn shows the 90\% confidence level nominal upper limit on the WIMP-neutron spin-dependent cross section as a function of mass, while the gray band shows the nuclear structure function uncertainty on the limit. The minimum of the limit curve occurs at 46~GeV/$c^2$ at a cross section of $sigma_(upright("SD"))^n =$ 3.7E-43~cm#super[2] (median expected limit at 8.5E-43~cm#super[2] at 40~GeV/$c^2$), and a power constraint is applied at all tested masses. @fig:limitplotSDp shows the same for the WIMP-proton spin-dependent cross section. The minimum of the limit curve is at 40~GeV/$c^2$ at a cross section of $sigma_(upright("SD"))^p =$ 9.8E-42~cm#super[2], and a power constraint is applied between 9~GeV/$c^2$ and 91~GeV/$c^2$. The minimum of the median expected limit on $sigma_(upright("SD"))^p$ is 2.3E-41~cm#super[2] and occurs at 40~GeV/$c^2$.








#block[
#strong[Supplemental Materials]

]





= Data Samples
<data-samples>
@fig:allsamples shows the WS2024 and WS2022 events passing all data selection criteria grouped in their respective sample in the likelihood. @tab:exposures lists the exposure for each sample in tonne-years.


// [figvision-cn] imgs/figureS1_high_mix_final.png
// 这是一张二维散点图（带有多层等值线/轮廓线的散点图）。
// 横轴为 S1c，单位为 phd，刻度范围为 0 到 80；纵轴为
// log10(S2c [phd])，刻度范围为 2.75 到 4.25。 图中标注的
// 文字包括：中央的 “High-Mixing State”；深绿色轮廓线无文
// 字标注；浅紫色填充区域无文字标注；斜向灰色细线及其标注
// 的核反冲等效能量刻度共四组，分别为 “0.8 keV ee / 5 keV
// nr”、“2.8 keV ee / 15 keV nr”、“5.0 keV ee / 25 keV nr
// ”、“7.2 keV ee / 35 keV nr”；左上方斜向灰色线标注为 “
// 9.5 keV ee / 45 keV nr” 和 “13.1 keV / 60 keV nr”。 数
// 据点：大量黑色小圆点散布在图中，主要分布在 S1c 10 到
// 75、log10(S2c) 3.2 到 4.1 的区域内。 轮廓线含义：深绿
// 色实心轮廓线勾勒出两个紧邻的闭合区域，其中一个位于 S1c
// 15 到 35、log10(S2c) 3.55 到 3.85 之间，另一个位于 S1c
// 45 到 75、log10(S2c) 3.65 到 3.9 之间；这两组深绿色轮
// 廓线代表 “High-Mixing State” 的分布（或模型预测范围）。
// 浅紫色阴影区域：位于 S1c 0 到 40、log10(S2c) 3.25 到
// 3.6 之间，内部无点，背景点几乎不涉及该区域。 黄色粗轮
// 廓线：呈复杂的折线/曲线形状，包围了从低 S1c 到高 S1c
// 的一个较宽范围，边缘曲折。 灰色半透明带：位于数据点主
// 要分布区的上方（log10(S2c) 约 3.8 到 4.15），贯穿 S1c
// 从 10 到 80 的横向范围，覆盖了许多黑色散点。 趋势/结论：
// 黑色散点分为两组主要簇团，对应两个深绿色轮廓区域（
// High-Mixing State），其分布与灰色斜线描述的能量刻度相
// 关，紫色区域位于较低能区，黄色轮廓线描述了一个更宽的包
// 络，各模型轮廓与散点数据分布显示该 High-Mixing State
// 在特定的 S1c 和 log10(S2c) 范围内被探测到。
// [figvision-cn] imgs/figureS1_rn_inactive_final.png
// 这是一张以S1c [phd]为横轴（线性刻度，范围0到80，主刻度
// 间隔10，次刻度间隔5）和log10(S2c [phd])为纵轴（线性刻
// 度，范围2.75到4.25，主刻度间隔0.25，次刻度间隔0.05）的
// 二维散点图。图中包含黑色散点、灰色等高线线索、黑色实心
// 轮廓和彩色等高线区域，并标注了物理事件能量坐标。 散点
// 分布：约80个黑色实心圆点，主要分布在S1c 10至80、log10(
// S2c) 3.45至4.15的区域。在S1c<10区域有少量散点，最低点
// 位于S1c约9、log10(S2c)约3.25处；在S1c约10-20区间，
// log10(S2c)集中在3.5-3.7。 灰色曲线（核反冲能标）：四条
// 向上弯曲的灰色实线，从左上向右下倾斜，底部标注对应的核
// 反冲能（keV_nr）和电子等效能（keV_ee）。从左到右依次为：
// 0.8 keV_ee / 5 keV_nr（约S1c 5处）、2.8 keV_ee / 15
// keV_nr（约S1c 20处）、5.0 keV_ee / 25 keV_nr（约S1c 40
// 处）、7.2 keV_ee / 35 keV_nr（约S1c 60处）。另在S1c 48
// 处标注有13.1 keV_ee / 60 keV_nr的曲线，在S1c 28处标注
// 有9.5 keV_ee / 45 keV_nr的曲线。 灰色阴影带：一条从S1c
// 5延伸至80的斜向灰色带，中心从log10(S2c)约3.6上升至约
// 4.0。其边界由两条近似平行的曲线构成，中部区域颜色较深，
// 与散点分布的中心区域基本重合。 黑色实心轮廓：一个封闭
// 的不规则环状曲线，覆盖S1c约20-40、log10(S2c) 3.55-3.85
// 的区域，形状近似为两个相连的椭圆，左侧中心约(S1c 26,
// log10(S2c) 3.75)，右侧中心约(S1c 35, 3.7)。 绿色封闭曲
// 线：两个包含在黑色轮廓内的绿色封闭区域，呈椭圆状，轮廓
// 线为墨绿色。左侧绿椭圆中心约(S1c 28, log10(S2c) 3.75)，
// 范围S1c 20-35；右侧绿椭圆中心约(S1c 50, log10(S2c)
// 3.75)，范围S1c 45-70。 紫色等高线区域：位于图的中下部，
// 由两条封闭的紫色轮廓线组成，填充色为浅紫色。区域覆盖
// S1c约10-55、log10(S2c) 3.2-3.7，轮廓线边界较宽，呈不规
// 则波浪状，中心区域（S1c 30-45）颜色稍深。 橙黄色曲线：
// 一条从图左上方向右下方延伸的粗橙色实线，起点约在(S1c 5
// , log10(S2c) 4.3)，向下弯曲后沿log10(S2c)约2.8的水平向
// 右延伸至S1c 80。在S1c 60附近出现一个向下的凹陷，局部坐
// 标约(S1c 60, log10(S2c) 3.0)。 灰色虚线：一条横贯整个
// 图表的水平虚线，位于log10(S2c)=2.8处。 文字标注：图内
// 中部偏右有“Radon Tag Inactive”字样，分两行排列。 整体
// 趋势：散点主要集中在灰色阴影带内，向上弯曲的灰色曲线与
// 核反冲能标对应，绿色封闭曲线和紫色等高线区域分别界定了
// 特定的背景事件分布区间。
// [figvision-cn] imgs/figureS1_rn_tagged_final.png
// 这是一张单面板的二维散点图（带有等值线与阴影区域），位
// 于白色背景上，横纵坐标均为线性刻度（对数转换后的纵轴值）。
// 图中展示的是用于 WS2024+WS2022 联合分析的“Radon Tagged
// ”（氡标记）样本事件分布。 坐标轴：横轴标签为“S1c [phd]
// ”，范围 0 到 80，主刻度间隔 10，次刻度间隔 5。纵轴标签
// 为“log10(S2c [phd])”，范围 2.75 到 4.40（最低主刻度
// 2.75，最高主刻度 4.25，顶部延伸至约 4.40），主刻度间隔
// 0.25，次刻度间隔 0.125。图框四边均有朝内的主次刻度线。
// 图内数据与标记： 黑色圆点（散点）：约 250 个黑色实心小
// 圆点，主要分布在 S1c 5–80 phd、log10(S2c) 3.40–4.20 的
// 带状区域内，点密度在 S1c 20–60 phd 区间最高，整体呈向
// 右上方的带状延伸趋势。N=250 为估计值。 灰色阴影带：一
// 条从左上向右下略微倾斜的灰色半透明带，覆盖了大部分黑色
// 散点，其上边界约为 log10(S2c)=4.10（S1c=70 处），下边
// 界约为 3.55（S1c=10 处），带宽约 0.4–0.5 dex。 紫色阴
// 影区域：位于灰色带下方偏左，呈月牙形或舌形，覆盖 S1c 2
// –55 phd、log10(S2c) 3.20–3.65 范围。该区域具有更深的紫
// 色内部核心（对应 68% 轮廓）和较浅的紫色外围（对应 95%
// 轮廓），二者以平滑曲线分界。 绿色轮廓线：两条封闭曲线，
// 表示标记中子本底分布的 68% 和 95% 置信区域。内层绿色轮
// 廓（68%）位于 S1c 22–40 phd、log10(S2c) 3.60–3.82 的椭
// 圆状区域；外层绿色轮廓（95%）范围更大，覆盖 S1c 15–80
// phd、log10(S2c) 3.55–3.90，其右侧在 S1c 60–80 处略有下
// 凹。 橙色轮廓线：一条粗橙色闭合曲线，形状不规则，从底
// 部的 S1c 2–60 phd、log10(S2c) 2.78–2.9 区域向上延伸，
// 左侧边界紧贴 S1c=2 附近竖直上升至 log10(S2c)>4.4，右侧
// 在 S1c 45–60 处向上收缩至 log10(S2c)≈3.1，中部形成向左
// 开口的凹陷。该线代表某个模型的边界轮廓（图注称模型轮廓
// 与某文献中红色轮廓相同，但此处显示为橙色）。 灰色细曲
// 线：四条从左上向右下弯曲的弧形等值线，分别标注为：9.5
// keVee / 45 keVnr（位于 S1c≈25、log10(S2c)≈4.15 附近），
// 13.1 keVee / 60 keVnr（位于 S1c≈55、log10(S2c)≈4.25 附
// 近），0.8 keVee / 5 keVnr（位于左下角 S1c≈3、log10(S2c
// )≈2.85 附近，标注文字在横轴下方），2.8 keVee / 15
// keVnr（位于 S1c≈20、log10(S2c)≈2.78 下方），5.0 keVee
// / 25 keVnr（位于 S1c≈42、log10(S2c)≈2.78 下方），7.2
// keVee / 35 keVnr（位于 S1c≈62、log10(S2c)≈2.78 下方）。
// 这些曲线代表不同核反冲能量（keVnr）与电子等效能量（
// keVee）对应的模型等值线。 灰色水平虚线：一条位于 log10
// (S2c)=2.78 的水平虚线，贯穿整个横轴范围，代表某个分析
// 阈值或下限。 文字标注："Radon Tagged" 以较大字号黑色文
// 字标注在图的右中偏下位置，坐标约为 S1c=62、log10(S2c)=
// 3.45，表明该图对应氡标记样本。 趋势与结论：黑色散点（
// 候选事件）主要沿灰色带分布，部分散点落入绿色标记中子本
// 底轮廓内，表明存在标记中子本底污染。紫色阴影区域（可能
// 是某种本底模型或信号模型）位于灰色带下方，与绿色轮廓部
// 分重叠。橙色轮廓线包围的区域与散点分布区有部分交叠。该
// 图通过展示事件在 S1c–log10(S2c) 平面的分布，结合本底模
// 型轮廓（绿、紫）和物理模型等值线（灰色曲线），用于评估
// 氡标记样本中信号与本底的分离程度。
// [figvision-cn] imgs/figureS1_rn_untagged_final.png
// 这是一张单面板散点图，横轴为 S1c [phd]，范围 0 到 80，
// 主刻度间隔 10，次刻度间隔 5；纵轴为 log10(S2c [phd])，
// 范围约 2.75 到 4.35，主刻度间隔 0.25，次刻度间隔 0.05。
// 图中散布约 500 个黑色小圆点，主要集中在 S1c 10 到 80、
// 纵轴 3.40 到 4.20 的区域，呈现随 S1c 增大而纵轴略微上
// 升的趋势。有四个灰色曲线带，从左下到右上大致平行排列，
// 每个带由上下两条灰色边界线构成，带内填充浅灰色半透明区
// 域，并附有文字标注：左下角为“0.8 keVee / 5 keVnr”，从
// 左到右依次为“2.8 keVee / 15 keVnr”、“5.0 keVee / 25
// keVnr”、“7.2 keVee / 35 keVnr”，中上部分别有“9.5 keVee
// / 45 keVnr”和“13.1 keVee / 60 keVnr”。图中有一条橙色粗
// 线，从左上角垂直下降到左下区域后折向右延伸，在纵轴约
// 2.78 处水平向右到 S1c 约 60，然后向上折返回到纵轴约
// 3.00 后向左闭合，形成一个不规则的大轮廓，轮廓内部为浅
// 橙色填充。在橙色轮廓内部中下部，有一个紫色填充区域，上
// 边界约纵轴 3.55，向下延伸至约 2.80，左边界约 S1c 8，右
// 边界在 S1c 10 到 38 之间逐渐收窄，紫色区域由深浅两层组
// 成，外层浅紫、内层深紫。图中还有两个深绿色粗线椭圆，右
// 侧椭圆中心约在 S1c 65、纵轴 3.75，横向跨度约 S1c 50 到
// 80，纵向跨度约 3.68 到 3.84；左侧椭圆中心约在 S1c 30、
// 纵轴 3.73，横向跨度约 S1c 20 到 45，纵向跨度约 3.64 到
// 3.83。图右下部标有文字“Radon Untagged”。图底部有一条水
// 平灰色虚线，位于纵轴约 2.78 处，横跨全图。图中黑点大部
// 分位于灰色曲线带内，绿色椭圆框出了黑点分布中两块相对集
// 中的区域。
// [figvision-cn] imgs/figureS1_vetoed.png
// 这是一张二维散点图，横轴标为“S1c [phd]”，范围从 0 到
// 80，主刻度间隔为 10，次刻度间隔为 2.5；纵轴标为“log10(
// S2c [phd])”，范围从 2.6 到 4.35，主刻度间隔为 0.25，次
// 刻度间隔为 0.05。图中散布约 100 个黑色小圆点，主要分布
// 区域为横轴 5–70、纵轴 3.45–4.1。这些数据点被一个浅灰色
// 阴影带包络，阴影带自左下向右上延伸，边界为平滑曲线。图
// 中央有一条红色粗实线，大致沿阴影带中线延伸，形状呈左侧
// 陡升、右侧趋于平缓的弧形。该红线下方还有另一条红色粗实
// 线，构成一个封闭的环状区域底部边界。图中标有“Skin/OD
// tagged”文字。此外，若干灰色曲线从左上向右下弯曲，形成
// 等值线系，每条曲线旁标注能量值，包括“9.5 keV_ee / 45
// keV_nr”“13.1 keV_ee / 60 keV_nr”等；图底部还有两条灰色
// 水平虚线，分别标注“0.8 keV_ee / 5 keV_nr”“2.8 keV_ee /
// 15 keV_nr”“5.0 keV_ee / 25 keV_nr”“7.2 keV_ee / 35
// keV_nr”。图注说明红色轮廓线表示被标记中子背景分布包含
// 68% 和 95% 的区域，数据点呈现随 S1c 增大而 log10(S2c)
// 饱和并趋于平缓的趋势。
// [figvision-cn] imgs/figureS1_vetoed.png
// 这是一张二维散点图，横轴标为“S1c [phd]”，范围从 0 到
// 80，主刻度间隔为 10，次刻度间隔为 2.5；纵轴标为“log10(
// S2c [phd])”，范围从 2.6 到 4.35，主刻度间隔为 0.25，次
// 刻度间隔为 0.05。图中散布约 100 个黑色小圆点，主要分布
// 区域为横轴 5–70、纵轴 3.45–4.1。这些数据点被一个浅灰色
// 阴影带包络，阴影带自左下向右上延伸，边界为平滑曲线。图
// 中央有一条红色粗实线，大致沿阴影带中线延伸，形状呈左侧
// 陡升、右侧趋于平缓的弧形。该红线下方还有另一条红色粗实
// 线，构成一个封闭的环状区域底部边界。图中标有“Skin/OD
// tagged”文字。此外，若干灰色曲线从左上向右下弯曲，形成
// 等值线系，每条曲线旁标注能量值，包括“9.5 keV_ee / 45
// keV_nr”“13.1 keV_ee / 60 keV_nr”等；图底部还有两条灰色
// 水平虚线，分别标注“0.8 keV_ee / 5 keV_nr”“2.8 keV_ee /
// 15 keV_nr”“5.0 keV_ee / 25 keV_nr”“7.2 keV_ee / 35
// keV_nr”。图注说明红色轮廓线表示被标记中子背景分布包含
// 68% 和 95% 的区域，数据点呈现随 S1c 增大而 log10(S2c)
// 饱和并趋于平缓的趋势。
#figure(
    align(center)[#table(
    stroke: none,
      columns: 2,
      align: (center,center,),
// [figvision-cn] imgs/figureS1_high_mix_final.png
// 这是一张二维散点图（带有多层等值线/轮廓线的散点图）。
// 横轴为 S1c，单位为 phd，刻度范围为 0 到 80；纵轴为
// log10(S2c [phd])，刻度范围为 2.75 到 4.25。 图中标注的
// 文字包括：中央的 “High-Mixing State”；深绿色轮廓线无文
// 字标注；浅紫色填充区域无文字标注；斜向灰色细线及其标注
// 的核反冲等效能量刻度共四组，分别为 “0.8 keV ee / 5 keV
// nr”、“2.8 keV ee / 15 keV nr”、“5.0 keV ee / 25 keV nr
// ”、“7.2 keV ee / 35 keV nr”；左上方斜向灰色线标注为 “
// 9.5 keV ee / 45 keV nr” 和 “13.1 keV / 60 keV nr”。 数
// 据点：大量黑色小圆点散布在图中，主要分布在 S1c 10 到
// 75、log10(S2c) 3.2 到 4.1 的区域内。 轮廓线含义：深绿
// 色实心轮廓线勾勒出两个紧邻的闭合区域，其中一个位于 S1c
// 15 到 35、log10(S2c) 3.55 到 3.85 之间，另一个位于 S1c
// 45 到 75、log10(S2c) 3.65 到 3.9 之间；这两组深绿色轮
// 廓线代表 “High-Mixing State” 的分布（或模型预测范围）。
// 浅紫色阴影区域：位于 S1c 0 到 40、log10(S2c) 3.25 到
// 3.6 之间，内部无点，背景点几乎不涉及该区域。 黄色粗轮
// 廓线：呈复杂的折线/曲线形状，包围了从低 S1c 到高 S1c
// 的一个较宽范围，边缘曲折。 灰色半透明带：位于数据点主
// 要分布区的上方（log10(S2c) 约 3.8 到 4.15），贯穿 S1c
// 从 10 到 80 的横向范围，覆盖了许多黑色散点。 趋势/结论：
// 黑色散点分为两组主要簇团，对应两个深绿色轮廓区域（
// High-Mixing State），其分布与灰色斜线描述的能量刻度相
// 关，紫色区域位于较低能区，黄色轮廓线描述了一个更宽的包
// 络，各模型轮廓与散点数据分布显示该 High-Mixing State
// 在特定的 S1c 和 log10(S2c) 范围内被探测到。
// [figvision-cn] imgs/figureS1_rn_inactive_final.png
// 这是一张以S1c [phd]为横轴（线性刻度，范围0到80，主刻度
// 间隔10，次刻度间隔5）和log10(S2c [phd])为纵轴（线性刻
// 度，范围2.75到4.25，主刻度间隔0.25，次刻度间隔0.05）的
// 二维散点图。图中包含黑色散点、灰色等高线线索、黑色实心
// 轮廓和彩色等高线区域，并标注了物理事件能量坐标。 散点
// 分布：约80个黑色实心圆点，主要分布在S1c 10至80、log10(
// S2c) 3.45至4.15的区域。在S1c<10区域有少量散点，最低点
// 位于S1c约9、log10(S2c)约3.25处；在S1c约10-20区间，
// log10(S2c)集中在3.5-3.7。 灰色曲线（核反冲能标）：四条
// 向上弯曲的灰色实线，从左上向右下倾斜，底部标注对应的核
// 反冲能（keV_nr）和电子等效能（keV_ee）。从左到右依次为：
// 0.8 keV_ee / 5 keV_nr（约S1c 5处）、2.8 keV_ee / 15
// keV_nr（约S1c 20处）、5.0 keV_ee / 25 keV_nr（约S1c 40
// 处）、7.2 keV_ee / 35 keV_nr（约S1c 60处）。另在S1c 48
// 处标注有13.1 keV_ee / 60 keV_nr的曲线，在S1c 28处标注
// 有9.5 keV_ee / 45 keV_nr的曲线。 灰色阴影带：一条从S1c
// 5延伸至80的斜向灰色带，中心从log10(S2c)约3.6上升至约
// 4.0。其边界由两条近似平行的曲线构成，中部区域颜色较深，
// 与散点分布的中心区域基本重合。 黑色实心轮廓：一个封闭
// 的不规则环状曲线，覆盖S1c约20-40、log10(S2c) 3.55-3.85
// 的区域，形状近似为两个相连的椭圆，左侧中心约(S1c 26,
// log10(S2c) 3.75)，右侧中心约(S1c 35, 3.7)。 绿色封闭曲
// 线：两个包含在黑色轮廓内的绿色封闭区域，呈椭圆状，轮廓
// 线为墨绿色。左侧绿椭圆中心约(S1c 28, log10(S2c) 3.75)，
// 范围S1c 20-35；右侧绿椭圆中心约(S1c 50, log10(S2c)
// 3.75)，范围S1c 45-70。 紫色等高线区域：位于图的中下部，
// 由两条封闭的紫色轮廓线组成，填充色为浅紫色。区域覆盖
// S1c约10-55、log10(S2c) 3.2-3.7，轮廓线边界较宽，呈不规
// 则波浪状，中心区域（S1c 30-45）颜色稍深。 橙黄色曲线：
// 一条从图左上方向右下方延伸的粗橙色实线，起点约在(S1c 5
// , log10(S2c) 4.3)，向下弯曲后沿log10(S2c)约2.8的水平向
// 右延伸至S1c 80。在S1c 60附近出现一个向下的凹陷，局部坐
// 标约(S1c 60, log10(S2c) 3.0)。 灰色虚线：一条横贯整个
// 图表的水平虚线，位于log10(S2c)=2.8处。 文字标注：图内
// 中部偏右有“Radon Tag Inactive”字样，分两行排列。 整体
// 趋势：散点主要集中在灰色阴影带内，向上弯曲的灰色曲线与
// 核反冲能标对应，绿色封闭曲线和紫色等高线区域分别界定了
// 特定的背景事件分布区间。
// [figvision-cn] imgs/figureS1_rn_tagged_final.png
// 这是一张单面板的二维散点图（带有等值线与阴影区域），位
// 于白色背景上，横纵坐标均为线性刻度（对数转换后的纵轴值）。
// 图中展示的是用于 WS2024+WS2022 联合分析的“Radon Tagged
// ”（氡标记）样本事件分布。 坐标轴：横轴标签为“S1c [phd]
// ”，范围 0 到 80，主刻度间隔 10，次刻度间隔 5。纵轴标签
// 为“log10(S2c [phd])”，范围 2.75 到 4.40（最低主刻度
// 2.75，最高主刻度 4.25，顶部延伸至约 4.40），主刻度间隔
// 0.25，次刻度间隔 0.125。图框四边均有朝内的主次刻度线。
// 图内数据与标记： 黑色圆点（散点）：约 250 个黑色实心小
// 圆点，主要分布在 S1c 5–80 phd、log10(S2c) 3.40–4.20 的
// 带状区域内，点密度在 S1c 20–60 phd 区间最高，整体呈向
// 右上方的带状延伸趋势。N=250 为估计值。 灰色阴影带：一
// 条从左上向右下略微倾斜的灰色半透明带，覆盖了大部分黑色
// 散点，其上边界约为 log10(S2c)=4.10（S1c=70 处），下边
// 界约为 3.55（S1c=10 处），带宽约 0.4–0.5 dex。 紫色阴
// 影区域：位于灰色带下方偏左，呈月牙形或舌形，覆盖 S1c 2
// –55 phd、log10(S2c) 3.20–3.65 范围。该区域具有更深的紫
// 色内部核心（对应 68% 轮廓）和较浅的紫色外围（对应 95%
// 轮廓），二者以平滑曲线分界。 绿色轮廓线：两条封闭曲线，
// 表示标记中子本底分布的 68% 和 95% 置信区域。内层绿色轮
// 廓（68%）位于 S1c 22–40 phd、log10(S2c) 3.60–3.82 的椭
// 圆状区域；外层绿色轮廓（95%）范围更大，覆盖 S1c 15–80
// phd、log10(S2c) 3.55–3.90，其右侧在 S1c 60–80 处略有下
// 凹。 橙色轮廓线：一条粗橙色闭合曲线，形状不规则，从底
// 部的 S1c 2–60 phd、log10(S2c) 2.78–2.9 区域向上延伸，
// 左侧边界紧贴 S1c=2 附近竖直上升至 log10(S2c)>4.4，右侧
// 在 S1c 45–60 处向上收缩至 log10(S2c)≈3.1，中部形成向左
// 开口的凹陷。该线代表某个模型的边界轮廓（图注称模型轮廓
// 与某文献中红色轮廓相同，但此处显示为橙色）。 灰色细曲
// 线：四条从左上向右下弯曲的弧形等值线，分别标注为：9.5
// keVee / 45 keVnr（位于 S1c≈25、log10(S2c)≈4.15 附近），
// 13.1 keVee / 60 keVnr（位于 S1c≈55、log10(S2c)≈4.25 附
// 近），0.8 keVee / 5 keVnr（位于左下角 S1c≈3、log10(S2c
// )≈2.85 附近，标注文字在横轴下方），2.8 keVee / 15
// keVnr（位于 S1c≈20、log10(S2c)≈2.78 下方），5.0 keVee
// / 25 keVnr（位于 S1c≈42、log10(S2c)≈2.78 下方），7.2
// keVee / 35 keVnr（位于 S1c≈62、log10(S2c)≈2.78 下方）。
// 这些曲线代表不同核反冲能量（keVnr）与电子等效能量（
// keVee）对应的模型等值线。 灰色水平虚线：一条位于 log10
// (S2c)=2.78 的水平虚线，贯穿整个横轴范围，代表某个分析
// 阈值或下限。 文字标注："Radon Tagged" 以较大字号黑色文
// 字标注在图的右中偏下位置，坐标约为 S1c=62、log10(S2c)=
// 3.45，表明该图对应氡标记样本。 趋势与结论：黑色散点（
// 候选事件）主要沿灰色带分布，部分散点落入绿色标记中子本
// 底轮廓内，表明存在标记中子本底污染。紫色阴影区域（可能
// 是某种本底模型或信号模型）位于灰色带下方，与绿色轮廓部
// 分重叠。橙色轮廓线包围的区域与散点分布区有部分交叠。该
// 图通过展示事件在 S1c–log10(S2c) 平面的分布，结合本底模
// 型轮廓（绿、紫）和物理模型等值线（灰色曲线），用于评估
// 氡标记样本中信号与本底的分离程度。
// [figvision-cn] imgs/figureS1_rn_untagged_final.png
// 这是一张单面板散点图，横轴为 S1c [phd]，范围 0 到 80，
// 主刻度间隔 10，次刻度间隔 5；纵轴为 log10(S2c [phd])，
// 范围约 2.75 到 4.35，主刻度间隔 0.25，次刻度间隔 0.05。
// 图中散布约 500 个黑色小圆点，主要集中在 S1c 10 到 80、
// 纵轴 3.40 到 4.20 的区域，呈现随 S1c 增大而纵轴略微上
// 升的趋势。有四个灰色曲线带，从左下到右上大致平行排列，
// 每个带由上下两条灰色边界线构成，带内填充浅灰色半透明区
// 域，并附有文字标注：左下角为“0.8 keVee / 5 keVnr”，从
// 左到右依次为“2.8 keVee / 15 keVnr”、“5.0 keVee / 25
// keVnr”、“7.2 keVee / 35 keVnr”，中上部分别有“9.5 keVee
// / 45 keVnr”和“13.1 keVee / 60 keVnr”。图中有一条橙色粗
// 线，从左上角垂直下降到左下区域后折向右延伸，在纵轴约
// 2.78 处水平向右到 S1c 约 60，然后向上折返回到纵轴约
// 3.00 后向左闭合，形成一个不规则的大轮廓，轮廓内部为浅
// 橙色填充。在橙色轮廓内部中下部，有一个紫色填充区域，上
// 边界约纵轴 3.55，向下延伸至约 2.80，左边界约 S1c 8，右
// 边界在 S1c 10 到 38 之间逐渐收窄，紫色区域由深浅两层组
// 成，外层浅紫、内层深紫。图中还有两个深绿色粗线椭圆，右
// 侧椭圆中心约在 S1c 65、纵轴 3.75，横向跨度约 S1c 50 到
// 80，纵向跨度约 3.68 到 3.84；左侧椭圆中心约在 S1c 30、
// 纵轴 3.73，横向跨度约 S1c 20 到 45，纵向跨度约 3.64 到
// 3.83。图右下部标有文字“Radon Untagged”。图底部有一条水
// 平灰色虚线，位于纵轴约 2.78 处，横跨全图。图中黑点大部
// 分位于灰色曲线带内，绿色椭圆框出了黑点分布中两块相对集
// 中的区域。
    table.hline(stroke: 0.8pt),
      [#box(image("imgs/figureS1_high_mix_final.png", width: 40.0%))], [#box(image("imgs/figureS1_rn_inactive_final.png", width: 40.0%))],
    table.hline(stroke: 0.5pt),
      [#box(image("imgs/figureS1_rn_tagged_final.png", width: 40.0%))], [#box(image("imgs/figureS1_rn_untagged_final.png", width: 40.0%))],
      [#box(image("imgs/figureS1_vetoed.png", width: 40.0%))], [#box(image("imgs/figureS1_ws2022.png", width: 40.0%))],
    table.hline(stroke: 0.8pt),
    )],
  kind: image,
  caption: [
    Panels show the events used in the WS2024+WS2022 combined analysis organized into the various samples described in the main text. Model contours are the same as those in @fig:data. Red contours in the veto tagged panel display the regions containing 68\% and 95\% of the distribution of tagged neutron backgrounds.
  ]
)
<fig:allsamples>



#figure(
  align(center)[#table(
    stroke: none,
    columns: 6,
    align: (center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [High-Mixing], [Radon Tag], [Radon], [Radon], [Veto], [WS2022],
    table.hline(stroke: 0.5pt),
    [State], [Inactive], [Tagged], [Untagged], [Tagged], [Only],
    table.hline(),
    [0.6], [0.6], [0.3], [1.8], [n/a], [0.9],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Exposures of the six samples used in the likelihood given in tonne-years.]
  , kind: table
  )
<tab:exposures>



= Details of the Detector Response Model
<details-of-the-detector-response-model>
The LZ detector and xenon response models are implemented in a #smallcaps[nest]-based application that includes effects such as curved electron drift paths from field non-uniformities, finite position reconstruction resolution in the transverse $( x , y )$ and longitudinal $z$ directions, and position-dependence of the S1 and S2 signal sizes. The key detector parameters of the model are provided in @nest_det_params. A header file for #smallcaps[nest]~v2.4.0 that reproduce the ER and NR response models used in this analysis is available online at #link("https://www.hepdata.net/record/155182").


#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [WS2024], [WS2022],),
    table.hline(),
    [$g_1$~\[phd/photon\]], [0.112], [0.114],
    [$g_1^(upright("gas"))$~\[phd/photon\]], [0.076], [0.092],
    [Effective GXe Extraction Field~\[kV/cm\]], [8.3], [8.4],
    [Single Electron Size~\[phd\]], [46.9], [58.5],
    [Extraction Efficiency~\[\%\]], [72.5], [80.5],
    [$g_2$~\[phd/electron\]], [~34.0], [47.1],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Relevant #smallcaps[nest] detector parameters. The parameters in the top-half of the table are input parameters, while the bottom-half are results of #smallcaps[nest] calculations. \
  ]
  , kind: table
  )


<nest_det_params>



Note that NEST has multiple models for extraction efficiency versus gaseous xenon (GXe) electric field strength due to conflicting measurements in the literature~@Xu:2019dqb, and the default model provides the lower bound of the extraction efficiency for a given field strength. In order to reproduce the observed single electron size and measured extraction efficiency in LZ with this default model, a higher effective value for the GXe field magnitude is used, and thus the value reported in @nest_det_params does not represent a physical field inside the LZ TPC. Extraction efficiency is measured as the ratio between the best-fit electroluminescence gain ($g_2$) value and the observed single electron signal size.


In addition to the parameters below, the ER and NR mean yield and fluctuations models have been tuned to minimize the discrepancy between NEST and LZ calibration data. The ER mean yield parameters are provided in @nest_ER_params, and the NR parameters are shown in @nest_NR_params. Nomenclature for the individual parameters follows from~@szydagis2022review. There are detailed instructions for implementing these changes in the provided file referenced above.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [#smallcaps[nest] Default at 97~V/cm], [LZ Value],),
    table.hline(),
    [$m_1$~\[keV$""^(- 1)$\]], [14.6], [12.5],
    [$m_2$~\[keV$""^(- 1)$\]], [77.3], [85.0],
    [$m_3$~\[keV\]], [0.8], [0.6],
    [$m_4$], [2.1], [2.1],
    [$m_5$ \[keV$""^(- 1)$\]], [19.3], [25.7],
    [$m_6$ \[keV$""^(- 1)$\]], [0], [0],
    [$m_7$ \[keV\]], [78.0], [59.7],
    [$m_8$], [4.3], [3.7],
    [$m_9$], [0.33], [0.28],
    [$m_10$], [0.08], [0.11],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Default and best-fit model parameters for the #smallcaps[nest] ER mean charge yield model. The LZ values were found by fitting to the $""^3$H and $""^14$C band means. See Eq.~6 of~@szydagis2022review for more information regarding the individual $m_i$. \
  ]
  , kind: table
  )


<nest_ER_params>



#figure([#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [#smallcaps[nest] Default], [LZ Value],),
    table.hline(),
    [$alpha$ \[keV$""^(1 / beta)$\]], [11.0], [10.2],
    [$beta$], [1.1], [1.1],
    [$gamma$ \[(V/cm)$""^(1 / delta)$\]], [0.048], [0.050],
    [$delta$], [-0.0533], [-0.0533],
    [$epsilon.alt$ \[keV\]], [12.6], [12.5],
    [$zeta$ \[keV\]], [0.30], [0.29],
    [$eta$], [2.0], [1.9],
    [$theta$ \[keV\]], [0.30], [0.32],
    [$iota$], [2.0], [2.1],
    [$p$], [0.50], [0.51],
    [$f_1$], [1.0], [0.996],
    [$f_2$], [1.0], [0.999],
    table.hline(stroke: 0.8pt),
  )], caption: [Model parameters for the #smallcaps[nest] NR mean light and charge yields model. The LZ values were found by fitting to the calibrated DD band mean. See Eqs. (10), (12), and (13) of~@szydagis2022review for more information regarding the individual parameters. The last two parameters ($f_1$ and $f_2$) are not described in~@szydagis2022review, but are available as free parameters in #smallcaps[nest], controlling the asymmetry of the sigmoidal energy dependence for the charge and light yields, respectively. See the #smallcaps[NEST] function #smallcaps[GetYieldNR(...)] for the usage of $f_1$ and $f_2$ in calculating NR yields~@nest_2_4_0. \
  ]
  , kind: table
  )


<nest_NR_params>






= WS2024-Only Limit
<ws2024-only-limit>
@fig:ws2024only shows the SI WIMP-nucleon cross section upper limit obtained using the data and models pertaining to the WS2024, 3.3~tonne-year exposure only.


// [figvision-cn] imgs/figureS2.png
// 这是一张二维曲线图，无子图。横轴为 WIMP Mass [GeV/c²]，
// 采用对数刻度，范围从 10¹ 到 10⁴；纵轴为 WIMP-nucleon σ
// _SI [cm²]，采用对数刻度，范围从 10⁻⁴⁸ 到 10⁻⁴⁴。图中主
// 要内容为多条物理极限曲线及置信带。 所有线条与标注： 黑
// 色实线：标记为“LZ (WS2024)”，线旁写有“LZ (WS2024)”，代
// 表本次工作的自旋无关 WIMP-核子散射截面 90% 置信水平上
// 限（施加功率约束）。曲线在低质量区从约 10⁻⁴⁶ cm²（10
// GeV/c²）上升，在 10¹·⁵ GeV/c² 附近达到最低点约 2.5×10⁻
// ⁴⁸ cm²，然后随质量增加单调上升，在 10⁴ GeV/c² 处约 5×
// 10⁻⁴⁶ cm²。整条曲线位于浅绿色带状区域的中心位置。 灰色
// 点划线：标记为“Unconstrained upper limit”，形状与黑色
// 实线相似，但在中低质量区略低。在 10 GeV/c² 处约 1.5×10
// ⁻⁴⁶ cm²，在约 40 GeV/c² 处约 2.2×10⁻⁴⁸ cm²，然后随质量
// 增加上升，在 10⁴ GeV/c² 处与黑色实线接近。黑色线与灰色
// 线在低质量区差异明显。 黑色虚线：标记为“Median
// expected upper limit”，紧密贴合黑色实线，代表背景实验
// 的预期上限中位值。在 10 GeV/c² 约 2×10⁻⁴⁶ cm²，在约 40
// GeV/c² 达到最小约 2.5×10⁻⁴⁸ cm²，在 10⁴ GeV/c² 约 5×10
// ⁻⁴⁶ cm²。 黑色粗点线：标记为“Median 3σ discovery
// potential”，位于黑色虚线/实线上方，代表 3σ 发现潜力的
// 中位值。在 10 GeV/c² 约 4×10⁻⁴⁶ cm²，在约 40 GeV/c² 最
// 小约 5×10⁻⁴⁸ cm²，在 10⁴ GeV/c² 约 1×10⁻⁴⁵ cm²。 浅绿
// 色带状区域：标记为“LZ (WS2024)”，表示背景实验 68% 置信
// 水平的预期上限范围，其上下边界包络了黑色虚线和黑色实线。
// 在低质量区向下延伸至约 4×10⁻⁴⁷ cm²，在约 40 GeV/c² 处
// 下边界约 1×10⁻⁴⁸ cm²，在 10⁴ GeV/c² 处下边界约 2×10⁻⁴⁶
// cm²。 浅黄色带状区域：表示背景实验 95% 置信水平的预期
// 上限范围，位于浅绿色区域下方和外侧，标记在右下方图例中。
// 其下边界在约 40 GeV/c² 处延伸至约 1.5×10⁻⁴⁸ cm²，在 10
// ⁴ GeV/c² 处约 3×10⁻⁴⁶ cm²。 对比实验曲线（均未加填充带）：
// 橙色实线：标记为“DEAP-3600 (2019)”，在低质量区（<30
// GeV/c²）出现。从 10 GeV/c² 约 10⁻⁴³ cm² 下降，在约 30
// GeV/c² 处约 1×10⁻⁴⁵ cm²，然后上升。 红色实线：标记为“
// LUX (2017)”，从 10 GeV/c² 约 2×10⁻⁴⁵ cm² 下降，在约 40
// GeV/c² 处最低约 10⁻⁴⁶ cm²，然后上升并在 10⁴ GeV/c² 处
// 约 10⁻⁴⁴ cm²。 蓝色实线：标记为“PandaX-4T (2025)”，从
// 10 GeV/c² 约 8×10⁻⁴⁶ cm² 下降，在约 30 GeV/c² 处最低约
// 3×10⁻⁴⁷ cm²，然后缓慢上升并在 10⁴ GeV/c² 处约 4×10⁻⁴⁶
// cm²。 棕色实线：标记为“XENON1T (2018)”，从 10 GeV/c²
// 约 6×10⁻⁴⁶ cm² 下降，在约 40 GeV/c² 处最低约 2×10⁻⁴⁷
// cm²，然后上升并在 10⁴ GeV/c² 处约 1×10⁻⁴⁵ cm²。 绿色实
// 线：标记为“XENONnT (2023)”，从 10 GeV/c² 约 5×10⁻⁴⁶ cm
// ² 下降，在约 40 GeV/c² 处最低约 1.5×10⁻⁴⁷ cm²，然后上
// 升并在 10⁴ GeV/c² 处约 8×10⁻⁴⁶ cm²。 紫色实线：标记为“
// LZ (2023)”，从 10 GeV/c² 约 2×10⁻⁴⁶ cm² 下降，在约 40
// GeV/c² 处最低约 8×10⁻⁴⁸ cm²，然后上升并在 10⁴ GeV/c²
// 处约 3×10⁻⁴⁵ cm²。该曲线位于黑色实线/绿色带的上方。 图
// 例位于右下角，包含四个条目：黑色粗点线（Median 3σ
// discovery potential）、黑色虚线（Median expected upper
// limit）、黑色实线（Power constrained upper limit）、灰
// 色点划线（Unconstrained upper limit）。 趋势结论：该图
// 展示了 LZ (WS2024) 实验在 220 天有效数据下对 WIMP-核子
// 自旋无关散射截面的上限，在中低质量范围（约 10-100 GeV/
// c²）给出了目前最严格的上限之一（黑色实线最低约 2.5×10⁻
// ⁴⁸ cm²），且该上限与预期上限的中位值（黑色虚线）非常接
// 近，位于 68% 预期带内。与其他实验（LUX, PandaX-4T,
// XENON1T, XENONnT, LZ 2023）相比，LZ (WS2024) 的灵敏度
// 在大部分质量区间内更优。功率约束对上限的影响主要出现在
// 低 WIMP 质量区（<100 GeV/c²），使得约束后的上限略高于
// 未约束上限。
#figure(image("imgs/figureS2.png", width: 50.0%),
  caption: [
    Upper limits (90\% C.L.) on the spin-independent WIMP-nucleon cross-section as a function of WIMP mass from WS2024 (220.0~live days) only are shown with a solid black line, with a $- 1 sigma$ power constraint applied. The gray dot-dash line shows the limits without the power constraint; green and yellow regions show the range of expected upper limits from 68\% and 95\% of background-only experiments, while the dashed black line indicates the median expectation, obtained with post-fit background estimates. The median $3 sigma$ observation significance from the post-fit model is shown as a dotted black line. Also shown are limits from WS2022 only~@SR1WS, PandaX-4T~@PandaX:2024qfu, LUX~@akerib2017results, all power constrained to $- 1 sigma$\; XENONnT~@XENON:2023cxc, reinterpreted with a $- 1 sigma$ power constraint; XENON1T~@collaboration2018dark, and DEAP-3600~@DEAP:2019yzn.
  ]
)
<fig:ws2024only>



= Limits in Terms of Number of WIMP Events
<limits-in-terms-of-number-of-wimp-events>


@fig:nwimp presents the WS2022+WS2024 combined and WS2024-only upper limits in number of events.


// [figvision-cn] imgs/figureS3_limit_curve_events_combined.png
// 这是一张单幅科学曲线图，无子图划分。横轴为 WIMP 质量，
// 单位 GeV/c²，采用对数坐标，范围从 10¹ 至 10⁴，主刻度标
// 注为 10¹、10²、10³、10⁴，主刻度之间有次级对数刻度。纵
// 轴为 WIMP 事件数 N_WIMP，采用线性坐标，范围从 0 至 18，
// 主刻度标注为 2、4、6、8、10、12、14、16、18，每 1 个单
// 位有一个次级刻度。图中包含四条曲线和两个填色带，右上角
// 有图例，图例从上到下依次为：点线表示 Median 3σ
// discovery potential（中位 3σ 发现潜力）；短虚线表示
// Median expected upper limit（中位预期上限）；黑色实线
// 表示 Power constrained upper limit（功率约束上限）；灰
// 色点划线表示 Unconstrained upper limit（无约束上限）。
// 图例下方另有黑色文字标注“LZ (2025)”。曲线走势如下：点
// 线从质量 10¹ GeV/c² 处约 5.5 个事件开始，随质量增加迅
// 速上升，在 10² GeV/c² 附近达到约 11 个事件，之后缓慢上
// 升，在 10³ 至 10⁴ GeV/c² 区间稳定在约 11.5 个事件。短
// 虚线从 10¹ GeV/c² 处约 2.8 个事件开始，随质量增加上升，
// 在 10² GeV/c² 附近达到约 5.3 个事件，之后基本保持平坦，
// 在 10³ 至 10⁴ GeV/c² 区间稳定在约 5.5 个事件。黑色实线
// 从 10¹ GeV/c² 处约 1.3 个事件开始，随质量增加缓慢上升，
// 在 10² GeV/c² 附近约 2.1 个事件，之后基本平坦，在 10³
// 至 10⁴ GeV/c² 区间稳定在约 2.3 个事件。灰色点划线从 10
// ¹ GeV/c² 处约 1.0 个事件开始，在 10² GeV/c² 附近略升至
// 约 2.0 个事件，之后与黑色实线几乎重合，在 10³ 至 10⁴
// GeV/c² 区间稳定在约 2.1 至 2.2 个事件，整体略低于黑色
// 实线。浅绿色填色带的上边界为短虚线（中位预期上限），下
// 边界为黑色实线（功率约束上限），覆盖从 10¹ 至 10⁴ GeV/
// c² 的整个质量范围，其宽度随质量增加而增大，在 10¹ GeV/
// c² 处约为 1.5 个事件，在 10² GeV/c² 处约为 3.2 个事件，
// 在 10³ 至 10⁴ GeV/c² 区间约为 3.2 个事件。浅黄色填色带
// 的上边界为点线（中位 3σ 发现潜力），下边界为短虚线（中
// 位预期上限），同样覆盖整个质量范围，其宽度在 10¹ GeV/c
// ² 处约为 2.7 个事件，在 10² GeV/c² 处约为 5.7 个事件，
// 在 10³ 至 10⁴ GeV/c² 区间约为 6.0 个事件。图中所有曲线
// 和填色带均显示随着 WIMP 质量从 10¹ GeV/c² 增加到 10²
// GeV/c²，事件数上限或发现潜力显著上升，而在 10² GeV/c²
// 以上则趋于平缓，表明对高质量 WIMP 的探测灵敏度趋于稳定。
// [figvision-cn] imgs/figureS3_limit_curve_events_combined.png
// 这是一张单幅科学曲线图，无子图划分。横轴为 WIMP 质量，
// 单位 GeV/c²，采用对数坐标，范围从 10¹ 至 10⁴，主刻度标
// 注为 10¹、10²、10³、10⁴，主刻度之间有次级对数刻度。纵
// 轴为 WIMP 事件数 N_WIMP，采用线性坐标，范围从 0 至 18，
// 主刻度标注为 2、4、6、8、10、12、14、16、18，每 1 个单
// 位有一个次级刻度。图中包含四条曲线和两个填色带，右上角
// 有图例，图例从上到下依次为：点线表示 Median 3σ
// discovery potential（中位 3σ 发现潜力）；短虚线表示
// Median expected upper limit（中位预期上限）；黑色实线
// 表示 Power constrained upper limit（功率约束上限）；灰
// 色点划线表示 Unconstrained upper limit（无约束上限）。
// 图例下方另有黑色文字标注“LZ (2025)”。曲线走势如下：点
// 线从质量 10¹ GeV/c² 处约 5.5 个事件开始，随质量增加迅
// 速上升，在 10² GeV/c² 附近达到约 11 个事件，之后缓慢上
// 升，在 10³ 至 10⁴ GeV/c² 区间稳定在约 11.5 个事件。短
// 虚线从 10¹ GeV/c² 处约 2.8 个事件开始，随质量增加上升，
// 在 10² GeV/c² 附近达到约 5.3 个事件，之后基本保持平坦，
// 在 10³ 至 10⁴ GeV/c² 区间稳定在约 5.5 个事件。黑色实线
// 从 10¹ GeV/c² 处约 1.3 个事件开始，随质量增加缓慢上升，
// 在 10² GeV/c² 附近约 2.1 个事件，之后基本平坦，在 10³
// 至 10⁴ GeV/c² 区间稳定在约 2.3 个事件。灰色点划线从 10
// ¹ GeV/c² 处约 1.0 个事件开始，在 10² GeV/c² 附近略升至
// 约 2.0 个事件，之后与黑色实线几乎重合，在 10³ 至 10⁴
// GeV/c² 区间稳定在约 2.1 至 2.2 个事件，整体略低于黑色
// 实线。浅绿色填色带的上边界为短虚线（中位预期上限），下
// 边界为黑色实线（功率约束上限），覆盖从 10¹ 至 10⁴ GeV/
// c² 的整个质量范围，其宽度随质量增加而增大，在 10¹ GeV/
// c² 处约为 1.5 个事件，在 10² GeV/c² 处约为 3.2 个事件，
// 在 10³ 至 10⁴ GeV/c² 区间约为 3.2 个事件。浅黄色填色带
// 的上边界为点线（中位 3σ 发现潜力），下边界为短虚线（中
// 位预期上限），同样覆盖整个质量范围，其宽度在 10¹ GeV/c
// ² 处约为 2.7 个事件，在 10² GeV/c² 处约为 5.7 个事件，
// 在 10³ 至 10⁴ GeV/c² 区间约为 6.0 个事件。图中所有曲线
// 和填色带均显示随着 WIMP 质量从 10¹ GeV/c² 增加到 10²
// GeV/c²，事件数上限或发现潜力显著上升，而在 10² GeV/c²
// 以上则趋于平缓，表明对高质量 WIMP 的探测灵敏度趋于稳定。
#figure([#block[
  #box(image("imgs/figureS3_limit_curve_events_combined.png", width: 98.0%))
  ]
  #block[
  #box(image("imgs/figureS3_limit_curve_events_ws2024.png", width: 98.0%))
  ]],
  caption: [
    The 90~\% confidence limit (solid line) for the number of WIMP events versus WIMP mass in the spin-independent case for the combined analysis (left) and WS2024 only (right). The dot-dash line shows the limit before applying the power constraint described in the text. The dashed line shows the median sensitivity and the dotted line shows the median $3 sigma$ discovery sensitivity. The green and yellow bands are the $1 sigma$ and $2 sigma$ sensitivity bands.
  ]
)
<fig:nwimp>



= Parameters of the Salting Model
<parameters-of-the-salting-model>
As discussed in the main text, the salt is drawn from a distribution consisting of the sum of a WIMP-like exponential and a flat spectrum, as shown in @fig:saltdist. The parameter $E_(m a x)$ sets the maximum energy of the flat distribution and is drawn from a Gaussian distribution with mean $mu_(m a x) = 250$~keV and sigma $sigma_(m a x) = 25$~keV. The parameter $E_mu$ is chosen to mimic the recoil spectrum induced by a WIMP with mass $M_chi$, which is in turn drawn from a Gaussian with mean $mu_chi$ = 80~GeV/c$""^2$ and width $sigma_chi$ = 20~GeV/c$""^2$. The normalization is drawn from a uniform distribution that spans from zero up to a rate that would be consistent with the upper limits from Ref.~@SR1WS.


// [figvision-cn] imgs/figureS4.png
// 这是一张单幅科学示意图，无子图划分。图的主体是一个平面
// 直角坐标系，用于展示某种“盐事件”（salt events）所服从
// 的分布。坐标轴由带箭头的黑色实线构成：横轴为能量（E）
// 轴，箭头指向右，在轴线的右端附近标注有E_max（E的下标为
// max）；纵轴为频率或幅度轴，箭头指向上，在轴线的上端附
// 近标注有A_e（A的下标为e）。坐标轴的具体数值刻度未标出。
// 横轴上的E_max对应一条自横轴垂直向上的黑色虚线，这条虚
// 线构成了图形右侧的边界；同时，有一条水平黑色虚线从纵轴
// A_e处（对应纵轴高度就是A_e）向右延伸至E_max处的竖直虚
// 线。 图中绘有一条以自然常数e为底的指数衰减曲线，曲线从
// 纵轴上的A_e点出发，向右下方单调递减，直至在E_max处降至
// 横轴（数值趋近于0）。曲线旁有一个引线标注，文字为A_e ·
// e^(-E/E_μ)，其中A_e为初始幅度，E_μ为衰减常数（下标为希
// 腊字母μ）。 曲线与两条虚线及坐标轴共同将平面划分为四个
// 填充区域：1）深蓝色区域：位于曲线上方、水平虚线（高度
// A_e）下方、纵轴以右和曲线与水平虚线交点以左的区间；2）
// 浅蓝色区域：位于曲线上方、水平虚线下方、曲线与水平虚线
// 交点以右和E_max以左的区间；3）灰色区域：位于曲线下方、
// 横轴上方、纵轴以右和曲线与水平虚线交点以左的区间；4）
// 浅橙色（肉色）区域：位于曲线下方、横轴上方、曲线与水平
// 虚线交点以右和E_max以左的区间。水平虚线的高度代表A_e，
// 而深蓝色和浅蓝色区域的垂直高度一致，均为A_e减去曲线在
// 对应横坐标处的值；灰色和浅橙色区域的垂直高度则为曲线值
// 本身。从区域形状的变化可以读出：当指数衰减曲线穿过了水
// 平虚线（其高度为A_e）时，垂直方向上被截断，从而形成两
// 个高为A_e、上边界平直、下边界弯曲的带状区域；指数曲线
// 下降到零的整个区间由0到E_max限定。
#figure(image("imgs/figureS4.png", width: 45.0%),
  caption: [
    Distribution from which the salt events are drawn. The parameters are described in the text.
  ]
)
<fig:saltdist>




The actual normalization, exponential, and flat spectrum parameters used are still hidden to the collaboration as unveiling them would harm bias mitigation of ongoing analyses. The allowed ranges were chosen to ensure that salt events can plausibly span the WIMP-search energy range, and also reach the highest recoil energies that might be used in a future higher-energy analysis, such as for effective field theories of dark matter.

#show bibliography: set par(leading: 0.46em)
#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: none)

]