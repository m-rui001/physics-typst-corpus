#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 12pt, lang: "en")
#set par(first-line-indent: 2em, spacing: 1.26em)
#set par(leading: 0.78em)
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.54cm, right: 2.54cm, top: 2.64cm, bottom: 3.49cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#set figure.caption(separator: [: ])
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#align(left)[
  #text(17pt, weight: "bold")[A fast radio burst source at a complex magnetised site in a barred galaxy]
  #v(1em)
  #text(12pt)[H.~Xu#super[1,2,3], J.~R.~Niu#super[2,4], P.~Chen#super[1,3,5], K.~J.~Lee#super[1,2]#footnote[E-mail: kjlee\@pku.edu.cn, orcid.org/0000-0002-1435-0883], W.~W.~Zhu#super[2]#footnote[E-mail: zhuww\@nao.cas.cn, orcid.org/0000-0001-5105-4058], S.~Dong#super[1]#footnote[E-mail: dongsubo\@pku.edu.cn, orcid.org/0000-0002-1027-0990], B.~Zhang#super[6,7]#footnote[E-mail: bing.zhang\@unlv.edu, orcid.org/0000-0002-9725-2524], J.~C.~Jiang#super[1,2,3], B.~J.~Wang#super[1,2,3], J.~W.~Xu#super[1,2,3], C.~F.~Zhang#super[1,2,3], H.~Fu#super[8], A.~V.~Filippenko#super[9], E.~W.~Peng#super[3,1], D.~J.~Zhou#super[2,4], Y.~K.~Zhang#super[2,4], P.~Wang#super[2], Y.~Feng#super[2,10], Y.~Li#super[11], T.~G.~Brink#super[9], D.~Z.~Li#super[12], W.~Lu#super[13], Y.~P.~Yang#super[14], R.~N.~Caballero#super[1], C.~Cai#super[15], M.~Z.~Chen#super[16], Z.~G.~Dai#super[17], S.~G.~Djorgovski#super[18], A.~Esamdin#super[16], H.~Q.~Gan#super[2], P.~Guhathakurta#super[19], J.~L.~Han#super[2], L.~F.~Hao#super[20], Y.~X.~Huang#super[20], P.~Jiang#super[2], C.~K.~Li#super[15], D.~Li#super[2,21], H.~Li#super[2], X.~Q.~Li#super[15], Z.~X.~Li#super[20], Z.~Y.~Liu#super[16], R.~Luo#super[22], Y.~P.~Men#super[23], C.~H.~Niu#super[2], W.~X.~Peng#super[15], L.~Qian#super[2], L.~M.~Song#super[15], D.~Stern#super[24], A.~Stockton#super[25], J.~H.~Sun#super[2], F.~Y.~Wang#super[26], M.~Wang#super[20], N.~Wang#super[16], W.~Y.~Wang#super[3], X.~F.~Wu#super[11], S.~Xiao#super[15], S.~L.~Xiong#super[15], Y.~H.~Xu#super[20], R.~X.~Xu#super[3,1,27], J.~Yang#super[26], X.~Yang#super[11], R.~Yao#super[2], Q.~B.~Yi#super[15], Y.~L.~Yue#super[2], D.~J.~Yu#super[2], W.~F.~Yu#super[30], J.~P.~Yuan#super[16], B.~B.~Zhang#super[26,28], S.~B.~Zhang#super[11], S.~N.~Zhang#super[15], Y.~Zhao#super[15], W.~K.~Zheng#super[9], Y.~Zhu#super[2], J.~H.~Zou#super[29,26]]
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Kavli Institute for Astronomy and Astrophysics, Peking University, Beijing 100871, P.~R.~China] \
  #text(9pt)[#super[2] National Astronomical Observatories, Chinese Academy of Sciences, Beijing 100101, P.R.~China] \
  #text(9pt)[#super[3] Department of Astronomy, Peking University, Beijing 100871, P.~R.~China] \
  #text(9pt)[#super[4] University of Chinese Academy of Sciences, Chinese Academy of Sciences, Beijing 100049, P.~R.~China] \
  #text(9pt)[#super[5] Department of Particle Physics and Astrophysics, Weizmann Institute of Science, Rehovot 76100, Israel] \
  #text(9pt)[#super[6] Nevada Center for Astrophysics, University of Nevada, Las Vegas, NV 89154, USA] \
  #text(9pt)[#super[7] Department of Physics and Astronomy, University of Nevada, Las Vegas, NV 89154, USA] \
  #text(9pt)[#super[8] Department of Physics & Astronomy, University of Iowa, Iowa City, IA 52242, USA] \
  #text(9pt)[#super[9] Department of Astronomy, University of California, Berkeley, CA 94720-3411, USA] \
  #text(9pt)[#super[10] Zhejiang Lab, Hangzhou, Zhejiang 311121, People's Republic of China] \
  #text(9pt)[#super[11] Purple Mountain Observatory, Chinese Academy of Sciences, Nanjing 210008, P~.R~. China] \
  #text(9pt)[#super[12] TAPIR, Walter Burke Institute for Theoretical Physics, Mail Code 350-17, Caltech, Pasadena, CA 91125, USA] \
  #text(9pt)[#super[13] Department of Astrophysical Sciences, Princeton University, Princeton, NJ 08544, USA] \
  #text(9pt)[#super[14] South-Western Institute For Astronomy Research, Yunnan University, Yunnan 650504, P.~R.~China] \
  #text(9pt)[#super[15] Key laboratory of Particle Astrophysics, Institute of High Energy Physics, Chinese Academy of Sciences, Beijing 100049, P.R.~China] \
  #text(9pt)[#super[16] Xinjiang Astronomical Observatory, Chinese Academy of Sciences, Urumqi 830011, P.~R.~China] \
  #text(9pt)[#super[17] University of Science and Technology of China, Anhui 230026, P.~R.~China.] \
  #text(9pt)[#super[18] Division of Physics, Mathematics, and Astronomy, California Institute of Technology, Pasadena, CA 91125, USA.] \
  #text(9pt)[#super[19] UCO/Lick Observatory, Department of Astronomy & Astrophysics, University of California Santa Cruz, 1156 High Street, Santa Cruz, CA 95064, USA] \
  #text(9pt)[#super[20] Yunnan Observatories, Chinese Academy of Sciences, Kunming 650216, P.~R.~China] \
  #text(9pt)[#super[21] Guizhou Normal University, Guiyang 550001, P.~R.~China] \
  #text(9pt)[#super[22] CSIRO Space and Astronomy, Epping, NSW 1710, Australia] \
  #text(9pt)[#super[23] Max-Planck institut für Radioastronomie, Auf Dem Hügel, Bonn, 53121, Germany] \
  #text(9pt)[#super[24] Jet Propulsion Laboratory, California Institute of Technology, 4800 Oak Grove Drive, Pasadena, CA 91109, USA] \
  #text(9pt)[#super[25] Institute for Astronomy, University of Hawaii, Honolulu, HI 96822, USA] \
  #text(9pt)[#super[26] School of Astronomy and Space Science, Nanjing
University, Nanjing 210093, P.~R.~China] \
  #text(9pt)[#super[27] State Key Laboratory of Nuclear Physics and Technology, School of Physics, Peking University, Beijing 100871, P.~R.~China] \
  #text(9pt)[#super[28] Key Laboratory of Modern Astronomy and Astrophysics (Nanjing University), Ministry of Education, P.~R.~China] \
  #text(9pt)[#super[29] College of Physics, Hebei Normal University, Shijiazhuang 050024, P.~R.~China] \
  #text(9pt)[#super[30] Shanghai Astronomical Observatory, Chinese Academy of Sciences, Shanaghai 200030, P.~R.~China] \
]

#v(1.2em)




Fast radio bursts (FRBs) are highly dispersed millisecond-duration radio bursts@Petroff19AAR @Cordes19ARAA @Zhang20Nature. Recent observations of a Galactic FRB@CHIME200428 @Bocheneck20 @Li21 @Ridnaia21 @Mereghetti20 suggest that at least some FRBs originate from magnetars, but the origin of cosmological FRBs is still not settled. Here we report the detection of 1863 bursts in 82 hr over 54 days from the repeating source FRB~20201124A@CHIMEFRB20201124A. These observations show irregular short-time variation of the Faraday rotation measure (RM), which probes the density-weighted line-of-sight magnetic field strength, of individual bursts during the first 36 days, followed by a constant RM. We detected circular polarisation in more than half of the burst sample, including one burst reaching a high fractional circular polarisation of 75\%. Oscillations in fractional linear and circular polarisations as well as polarisation angle as a function of wavelength were detected. All of these features provide evidence for a complicated, dynamically evolving, magnetised immediate environment within about an astronomical unit (au; Earth-Sun distance) of the source. Our optical observations of its Milky-Way-sized, metal-rich host galaxy@Fong21 @Ravi21 @Piro21 reveal a barred spiral, with the FRB source residing in a low stellar density, interarm region at an intermediate galactocentric distance. This environment is inconsistent with a young magnetar engine formed during an extreme explosion of a massive star that resulted in a long gamma-ray burst or superluminous supernova.


Triggered by observations of the Canadian Hydrogen Intensity Mapping Experiment@CHIMEFRB20201124A, we used the Five-hundred-meter Aperture Spherical radio Telescope (FAST)@Jiang19SCPMA to monitor FRB~20201124A from 2021 April 1 to June 11 (UT) with 91 hr total observing time. The 19-beam receiver was used to cover the frequency range 1.0--1.5 GHz. Our detection threshold was a signal-to-noise ratio $S / N > 7$, and 1103 bright bursts reached $S / N > 30$ among a total of 1863 detected bursts. The burst flux is 0.005--11.5 Jy, and the inferred isotropic luminosity after integrating signal bandwidth spans from $5 times 10^37$ erg s$""^(- 1)$ to $3 times 10^40$ erg s$""^(- 1)$. The daily burst energy distribution shows no secular trend (Methods), while the burst-to-burst fluctuation exceeds two orders of magnitude.


The daily event rate varies slowly (@fig:fig1), with minimal and maximal values of $6 plus.minus 1$ and $46 plus.minus 8$ hr$""^(- 1)$, respectively. Throughout paper, the error bars are for the 68\% confidence level unless otherwise specified. The waiting time follows a bimodal distribution with timescales peaking at 39 ms and 135.2 s (Methods). Similar bimodality in waiting time had also been detected in the repeating FRB~20121102A@LiDi2021, which may indicate a common mechanism. The high event rate makes FRB~20201124A among the most active known FRBs. We witnessed the quenching of the burst activity on a timescale $< 74$ hr, when the source stopped emitting any bursts above the flux limit of 4.3 mJy at the fiducial burst width of 5 ms on 2021 May 29. We continued to observe the source over the next 16 days and did not detect a single burst during the 9 hr of observations (@fig:fig1). Counterintuitively, the burst rate did not show any sign of a monotonic decrease, but a slow increase from $6 plus.minus 1$ hr$""^(- 1)$ to $27_(- 8)^(+ 7)$ hr$""^(- 1)$ during the last 20 days before the quenching.

// [figvision-cn] imgs/f1.png
// 该图由六个垂直堆叠的子图（a至f）组成，共享同一水平时间
// 轴。所有子图的横坐标均为“Date (MJD)”，即修正儒略日，范
// 围从59310到59375。在横坐标上方标注了对应的公历日期：
// 2020-04-01、04-11、04-21、05-01、05-11、05-21、06-01、
// 06-11。图中存在一条贯穿所有子图的垂直虚线，位于MJD约
// 59339处。此外，从MJD 59361开始至图表末端（约MJD 59375），
// 整个区域被浅灰色背景填充。 子图 a 类型：条形图。 纵坐
// 标：N_bursts，表示爆发数量，刻度范围从0到100。 内容：
// 显示了一系列深蓝色的垂直条形，代表不同观测日的爆发次数。
// 条形高度随日期变化，在MJD 59318附近达到峰值（超过100次），
// 随后波动下降。在MJD 59339的垂直虚线右侧，条形显著减少，
// 仅有个别低矮条形出现。 子图 b 类型：散点图带误差棒。
// 纵坐标：r (hr^-1)，表示发生率，单位为每小时，刻度范围
// 从0到50以上。 内容：数据点为紫色圆点，每个点带有黑色垂
// 直误差棒。数据点在MJD 59310至59339之间分布较密集，数值
// 主要在10至40 hr^-1之间波动。在MJD 59339之后，数据点变
// 得稀疏且数值普遍较低，多集中在10 hr^-1以下。 子图 c 类
// 型：折线图带阴影区域。 纵坐标：RM (rad/m^2)，表示旋转
// 测量值，刻度范围从-800到0。 内容：包含一条深蓝色实线连
// 接的数据点序列，周围环绕着浅绿色半透明阴影区域（可能表
// 示置信区间）。曲线呈现明显的周期性波动趋势：从MJD
// 59310的约-650 rad/m^2开始，经历多次起伏，在MJD 59335左
// 右降至最低点（约-850 rad/m^2），随后迅速回升并在MJD
// 59340后稳定在约-600 rad/m^2的水平。MJD 59339处的垂直虚
// 线恰好穿过曲线的快速上升段。 子图 d 类型：散点图。 纵
// 坐标：L/I (%)，表示线性偏振度百分比，刻度范围从0到100。
// 内容：由大量洋红色实心圆点组成。数据点在MJD 59310至
// 59339期间密集分布，数值主要集中在50%至100%之间，部分点
// 低于50%。在MJD 59339之后，数据点数量明显减少，且数值分
// 布较为分散，部分点接近0%。 子图 e 类型：散点图。 纵坐
// 标：|V|/I (%)，表示圆偏振度绝对值百分比，刻度范围从0到
// 100。 内容：由蓝色实心圆点组成。与子图d类似，数据点在
// MJD 59310至59339期间较为密集，数值大多分布在0%至50%之
// 间，少数点高于50%。在MJD 59339之后，数据点稀疏，数值普
// 遍较低，多数在20%以下。 子图 f 类型：条形图。 纵坐标：
// T_obs (hr)，表示观测时长，单位为小时，刻度范围从0到2。
// 内容：显示了一系列黑色垂直条形，代表每日的观测时长。在
// MJD 59310至59339期间，条形高度基本保持在2小时左右，表
// 明观测持续且完整。在MJD 59339之后，条形高度不稳定，有
// 几次降至1小时或更低，且在MJD 59361之后的灰色区域内，条
// 形非常稀疏且高度不一。
#figure(placement: top, image("imgs/f1.png", width: 100.0%),
  caption: [
    #strong[Temporal variations of the physical parameters of FRB~20201124A.] #strong[\(a)] Daily number of bursts detected. #strong[\(b)] Weibull event rate (blue) and Poisson event rate (magenta). #strong[\(c)] Daily RM, where the violin symbol indicates the distribution function, the green shaded strips indicate the 95\% upper and lower bounds, and the solid black curve is the median. Vertical dashed line indicates MJD~59339, where the largest RM fluctuation is noted. #strong[\(d)] and #strong[\(e)] Fractional linear and circular polarisations measured for each individual burst. #strong[\(f)] Observation length on each day. The grey shaded region on the right side of the plot shows the epoch when no burst was detected.
  ]
)
<fig:fig1>



FRB~20201124A bursts show diverse polarisation properties, including nearly constant polarisation angle (PA) across the phase@HilmarssonFRB20201124A @Michilli18Nat, significant PA swings@Luo20Nat, and a high amount of circular polarisation (@fig:fig2). In our burst sample, 50\% of the bright bursts ($S / N > 30$) had circular polarisation higher than 3.3\%, while the maximal circular polarisation reaches 75\%, higher than the 47\% reported previously@Kumar2021. This is in contrast to most FRBs@Petroff19AAR or radio-emitting magnetars@Kramer2007 showing little circular polarisation.

// [figvision-cn] imgs/f2.png
// 该图由五个子图（a至e）组成，按四列排布，每列对应一个特
// 定的射电暴事件：从左至右分别为Burst 779、Burst 926、
// Burst 1,112和Burst 1,472。 子图a为位置角（PA）随时间变
// 化的曲线图。纵轴标签为“PA (°)”，范围从-50到50度；横轴
// 标签为“Time (ms)”，范围从-40到40毫秒。图中黑色数据点显
// 示在脉冲峰值附近存在剧烈的位置角旋转。对于Burst 779，
// PA在约-30度到+30度之间快速摆动；对于Burst 926，PA在+30
// 度附近有小幅变化；对于Burst 1,112，PA从接近0度旋转至约
// +30度；对于Burst 1,472，PA在+30度附近波动。 子图b为流
// 量密度（Flux）随时间变化的曲线图。纵轴标签为“Flux (Jy)
// ”，各列刻度不同（左侧第一列为0至1 Jy，第二列为0.0至0.4
// Jy，第三列为0.0至0.1 Jy，第四列为-0.03至0.03 Jy）。横
// 轴与子图a相同。图中包含两条曲线：蓝色实线代表总强度（
// Stokes I），紫色实线代表圆偏振强度（Stokes V）。背景中
// 有一个浅蓝色阴影区域，覆盖了脉冲的主要部分。每个子图左
// 上角标注了平均圆偏振度数值，格式为$\langle|V|\rangle/\
// langle I\rangle$及其百分比值：Burst 779为7.44(3)%，
// Burst 926为14.5(2)%，Burst 1,112为55.9(3)%，Burst 1,
// 472为75.1(9)%。 子图c为动态频谱图（Dynamic Spectra）。
// 纵轴标签为“Frequency (GHz)”，范围从1.0到1.4 GHz；横轴
// 为时间，范围从-40到40毫秒。图像以灰度显示信号强度，深
// 色表示高流量。左侧边缘有红色标记指示频率通道。图中展示
// 了脉冲在频域上的分布特征，例如Burst 779显示出明显的频
// 率漂移结构，而Burst 1,472则显示出较为弥散的信号。 子图
// d为分数圆偏振度（frac. pol.）随波长平方（$\lambda^2$）
// 变化的散点图。纵轴标签为“frac. pol. (%)”，范围从-100%
// 到100%；横轴标签为“$\lambda^2 (m^2)$”，范围从0.04到
// 0.08 $m^2$。图中包含两种颜色的数据点：紫色点代表正圆偏
// 振，绿色点代表负圆偏振（或反之，视具体符号约定而定，但
// 此处主要展示幅度）。背景中有灰色阴影区域，对应于脉冲到
// 达的时间窗口。每个子图中标注了法拉第深度（Faraday
// depth）的测量值 $\Delta\Phi$，单位未明确标出但通常与
// rad/m²相关：Burst 779为198(34)，Burst 926为121(22)，
// Burst 1,112为200(40)。 子图e为位置角（PA）随波长平方（
// $\lambda^2$）变化的散点图。纵轴标签为“PA (°)”，范围各
// 异（第一列为50至75度，第二列为0至100度，第三列为25至50
// 度，第四列为-200至100度）；横轴与子图d相同。图中黑色数
// 据点显示了位置角随波长的变化趋势。每个子图中标注了位置
// 角的旋转量 $\Delta\Psi$：Burst 779为179(42)°，Burst
// 926为12(20)°，Burst 1,112为295(40)°。这些数据表明不同
// 爆发事件中位置角随波长的变化程度差异显著。
#figure(placement: top, image("imgs/f2.png", width: 100%),
  caption: [
    #strong[Polarisation profiles, dynamic spectra, and frequency-dependent polarisation of selected bursts.] #strong[\(a)] PA curve. #strong[\(b)] Polarisation profile, where total intensity, linear, and circular polarisations normalised to the off-pulse noise of total intensity are in black, red, and blue curves, respectively. #strong[\(c)] Dynamic spectra of total intensity. The horizontal white strips and red markers represent frequency channels that have been removed owing to either radio-frequency interference (RFI) or band edges. #strong[\(d)] Fractional polarisation as a function of the square of wavelength, where green, magenta, and blue dots and error bars are respectively for total, linear, and circular polarisations. The solid curves of the corresponding colour are the model fitting excluding data in the grey region (see Methods). The oscillation phase difference ($Delta Phi$) between the linear and circular polarisation oscillations is denoted. #strong[\(e)] Linear polarisation angle as a function of the square of wavelength. The oscillation phase difference ($Delta Psi$, between the linear polarisation and polarisation angle is denoted. All error bars in the figure are at the 95\%-confidence level.
  ]
)
<fig:fig2>



For some bursts with moderate circular polarisation, the frequency spectra of both circular and linear polarisations show oscillating features (e.g., bursts 779 and 926 in @fig:fig2), which indicate Faraday conversion (i.e., generalised Faraday rotation) or polarisation-dependent absorption. The oscillation phases of the linear and circular polarisations are approximately offset by $180^compose$. We also detected highly circularly polarised bursts without such quasiperiodic structures (burst 1472 in @fig:fig2). This suggests that there is likely an alternative mechanism for producing circular polarisation in addition to the polarisation oscillations. Since the synchrotron maser model invoking relativistic shocks does not predict circular polarisation, our results support the magnetospheric origin of FRB emission@Kumar17MN @YangZhang18ApJ @Luo20Nat @Zhang20Nature.


The RM shows a stochastic temporal variation between $- 889.5_(- 0.7)^(+ 0.7)$ and $- 365.1_(- 1.4)^(+ 2.9)$ rad m$""^(""^(-) 2)$, on a timescale of 10 days (@fig:fig1) and the largest burst-to-burst RM variation per session with a root-mean-square (RMS) value of 77.2 rad m$""^(- 2)$. Within a single burst, the profile evolution induced apparent RM variation is $tilde 15.6$ rad m$""^(- 2)$. The detected stochastic RM variations on 10-day timescale are more than 40 times larger, suggesting that stochastic RM variations do not result from the profile evolution. Compared with the case of FRB~20121102A@Michilli18Nat @Hilmarsson2021, the fractional amplitude of RM variation in FRB~20201124A is larger, while the absolute amplitude is smaller. The RM variation quickly stopped $tilde 20$ days before the quenching of the radio bursts, with the 95\% confidence level upper limit of $Delta upright("RM") lt.eq 9.1$  $upright("rad") thin m^(""^(-) 2)$, a factor of 50 smaller than the amplitude of stochastic RM variations detected earlier.


The significant RM variation on a 10-day timescale could be caused by a change of either the magnetic field configuration or the density profile along the line of sight close to the source region. The sub-au size of the Faraday screen is estimated as $tilde 0.6 med upright("au") ( tau / 10 upright(d) ) ( v / 100 med upright("km") med s^(- 1) )$, where $tau$ is the timescale of RM variation and $v$ is the relative transverse velocity between the screen and the FRB source. Similar to the FRB~20201124A, the Galactic binary pulsar system PSR~B1259$-$63 shows irregular RM evolution@Johnston05. Thus, the lack of periodicity in RM variation may not rule out the binary scenario, and is probably related to irregular mass ejection from the companion star. The cessation of RM variation suggests that the line of sight is less contaminated by the varying component of the medium density. If the central engine is an isolated young magnetar, the RM is predicted to show a secular monotonic decline with time@Piro18 @Metzger19MN.


The oscillations of the linear and circular polarisation fractions as well as the linear polarisation angle as functions of radio wavelength probe the magnetic field and the relativistic plasma close to the FRB central engine. They are likely a consequence of the polarisation-dependent absorption or conversion, which requires $B gt.eq 3 ( gamma / 10 )^(- 2)$ Gauss, where $gamma$ is the kinetic Lorentz factor of the plasma (Methods). Owing to the burst-to-burst variation of polarisation oscillation phenomena, the distance scale associated with the oscillation in polarisation is $0.1 thin upright("au") thin ( tau / upright("min") )$ assuming that the bursts propagate at the speed of light. The polarisation oscillation suggests that the vicinity of the FRB source is occupied by a variable Gauss-level magnetic field together with both a cold and a relativistic plasma (Methods).


We performed optical and near-infrared observations of the host galaxy SDSS J050803.48+260338.0@Fong21 @Ravi21 @Piro21 using the 10 m Keck telescopes, including high- and low-dispersion spectra with the Echellette Spectrograph Imager (ESI) and the Low Resolution Imaging Spectrometer (LRIS), respectively, and $K'$-band images with the NIRC2 camera using the laser guide-star adaptive-optics (AO) system. In the optical spectra, we detected multiple emission lines (@fig:fig3\(a)) and derived $z = 0.09795 plus.minus 0.00003$, which corresponds to a luminosity distance of $453.3 plus.minus 0.1$ Mpc adopting the standard #emph[Planck] cosmological model#cite(label("Planck16AandA")). Similar to the hosts of several other repeaters (e.g., FRB~20121102A@Chatterjee2017, FRB~20180916B@Marcote2020, FRB~20180301A@Bhandari2021), this host is in the star-forming branch of the Baldwin-Phillips-Terlevich diagram@BPT1981 (Methods). Our adaptive-optics (AO) image (@fig:fig3\(b)), with a full width at half-maximum resolution of $0.12''$, shows that the host is a barred galaxy with spiral features, and the FRB's apparent location is in the disc but offset from the bar and spiral arms.

// [figvision-cn] imgs/f3.png
// 子图a为光谱曲线图，横坐标为波长（Wavelength），单位是
// 埃（Å），范围从5,100 Å到7,500 Å，中间在约6,800 Å处有断
// 裂标记；纵坐标为流量密度（f_λ），单位是10⁻¹⁵ erg/s/cm²
// /Å，范围从0.0到2.5。图中包含两条曲线：蓝色实线代表LRIS
// 仪器观测数据，红色实线代表ESI仪器观测数据（已减去常数
// 背景）。在左侧波段（~5,000–5,800 Å），蓝色曲线在约5,
// 400 Å处有一个窄峰标注为Hβ，在约5,500 Å处有一个小峰标注
// 为[O III]λ5007；红色曲线在此区域基本平坦，仅在约5,400
// Å处有微弱对应特征。在右侧波段（~7,100–7,500 Å），蓝色
// 曲线在约7,200 Å处出现一组强发射线，标注为Hα+[N II]，峰
// 值流量约1.0×10⁻¹⁵ erg/s/cm²/Å；红色曲线在同一位置也显
// 示相同结构但幅度更高，峰值接近2.5×10⁻¹⁵ erg/s/cm²/Å，
// 并在其右侧约7,300 Å处另有一组较弱发射线标注为[S II]。
// 图内文字“z=0.098 lines”表明这些谱线来自红移z=0.098的宿
// 主星系。整体趋势显示ESI在长波段的灵敏度显著高于LRIS，
// 尤其在Hα和[S II]区域。 子图b为光学图像叠加示意图，背景
// 为灰度处理的近红外或光学波段星系影像，中心为一个明亮的
// 椭圆状星系核，周围弥散光晕呈暗灰色渐变。图像坐标系：横
// 轴为赤经（Right Ascension, J2000），范围从5ʰ08ᵐ03.70ˢ
// 到03.30ˢ（注意数值递减方向）；纵轴为赤纬（Declination,
// J2000），范围从36″到26°03′40″（即36″至26°03′40″，实际
// 应为26°03′36″至26°03′40″，因刻度间隔为1″）。图中绘制了
// 两条平行斜线：蓝色直线标注为“LRIS slit edge”，从左上角
// 延伸至右下角，穿过星系中心偏左位置；红色水平直线标注为
// “ESI slit edge”，横跨图像中部，位于赤纬约38″处，与蓝色
// 线相交于星系中心附近。两个标记点：青色空心圆圈位于赤经
// 约03.50ˢ、赤纬约38.2″处，标注为“FRB (EVN)”；黄色五角星
// 位于赤经约03.48ˢ、赤纬约38.0″处，标注为“Background
// galaxy center”。左下角有一个比例尺线段，标注“3kpc@z=
// 0.098”，表示该长度对应物理尺度3千秒差距（在红移z=0.098
// 时）。布局上，ESI狭缝（红线）覆盖星系中心及FRB位置，而
// LRIS狭缝（蓝线）则斜穿星系，两者交叠区域包含FRB定位点
// 与星系核心。此图传达的是两种光谱仪狭缝相对于宿主星系和
// 快速射电暴（FRB）位置的几何关系，用于说明观测覆盖范围
// 与目标对齐情况。
#figure(placement: top, image("imgs/f3.png", width: 50.0%),
  caption: [
    #strong[Host-galaxy properties at optical and near-infrared wavelengths.] #strong[\(a)] Emission lines from the $z = 0.098$ host galaxy in the LRIS (blue) and ESI (red) spectra. #strong[\(b)] The $K'$-band AO image of the barred-spiral host galaxy, with the indicated position of the FRB@FRB20201124AEVN shown as a cyan circle, the centroid of a $z = 0.553$ background galaxy (Methods) marked by a yellow star, and the LRIS and ESI slit edges in blue and red solid lines, respectively.
  ]
)
<fig:fig3>



The galaxy's stellar mass@Fong21 @Ravi21, $M_(*) approx 3 times 10^10 thin M_⊙$, is about half that of the Milky Way (MW); in contrast, its star-formation rate ($upright("SFR") = 3.4 plus.minus 0.3 thin M_⊙ thin upright("yr")^(- 1)$) is about twice that of the MW, and its metallicity ($12 + log("O/H") = 9.07_(-0.04)^(+0.03)$) is approximately twice the solar abundance (Methods). The projected offset of the FRB location from the galaxy centre and the specific SFR appear to be typical compared with known FRB hosts (Methods), and its metallicity is higher than that of any FRB host reported previously (most were for non-repeating FRBs)@Bhandari20ApJL @Li2020. One active repeater, FRB~20121102A, is hosted by a metal-poor dwarf galaxy with a high specific SFR@Chatterjee2017 @Tendulkar17ApJ, which is similar to the hosts of long gamma-ray bursts or hydrogen-poor superluminous supernovae. This has motivated a hypothesised connection between active repeating FRBs and young, millisecond magnetars@Metzger17ApJ. In contrast, the host of FRB~20201124A is more metal-rich and massive than almost all known hosts of long gamma-ray bursts or hydrogen-poor superluminous supernovae@Li2020. It has been speculated that FRB~20201124A may reside in a star-forming region in the host galaxy@Fong21 @Ravi21 @Piro21. However, the interarm location of the source revealed by our image does not support such a possibility, so a young magnetar engine born from an extreme explosion is disfavoured. Nonetheless, a regular magnetar similar to those in the MW is still possible, although the high burst rate, not seen in the Galactic magnetars, requires unusual intrinsic or environmental conditions.
































#heading(level: 1, numbering: none)[Methods]
<methods>


#heading(level: 3, numbering: none)[Radio observations and burst detection]
<radio-observations-and-burst-detection>
We carried out our observations using the 19-beam receiver of FAST on 2021 April 1. The 19-beam receiver spans from 1.0 GHz to 1.5 GHz with a system temperature of 20--25 K @Jiang20RAA. From 2021 April 1 to April 2, we performed a grid of 9 observations using all 19 beams around the position ($alpha = 05^(upright(h)) 08^(upright(m))$, $delta = + 26^compose 11'$) reported by the CHIME/FRB team@CHIMEAtel and detected multiple bursts in 2 to 4 beams simultaneously. We then used the differential intensity in each beam to compute a refined location: $alpha = 05^(upright(h)) 08^(upright(m)) 03.50^(upright(s))$, $delta = + 26^compose 03' 37.80^('')$ @XuAtel2021. From May 15 onward, observations were carried out by pointing the FAST central beam at the much more precise European Very Long Baseline Interferometry Network (EVN) position@FRB20201124AEVN ($alpha = 05^(upright(h)) 08^(upright(m)) 03.507^(upright(s))$, $delta = + 26^compose 03' 38.50^('')$). The epochs and durations of all observations are shown in @fig:fig1. The data of April 1 and 2 were used only for localisation purposes@XuAtel2021\; they are excluded in other analyses in this paper, as the beam centre was misaligned with the source position. The data were recorded with a frequency resolution of 122.07 kHz and a temporal resolution of 49.152 $mu$s or 196.608 $mu$s. The FAST receiver uses the dual-polarisation linear polarisation feed@Jiang20RAA, with which the 4-channel Stokes intensity was measured. Before and after each observation session, we recorded a 1~minute noise diode signal for the polarisation calibration.


We used the software #smallcaps[transientx] \(#link("https://github.com/ypmen/TransientX")) to perform the off-line burst searches. The data were dedispersed in the range of 380--440 $upright("cm")^(- 3) thin upright("pc")$ with a step of 0.1 $upright("cm")^(- 3) thin upright("pc")$ and the burst width was searched with a boxcar filter, of which the filter width ranges from 0.1 ms to 100 ms. After candidate plots were formed, we visually inspected all 3364 candidates with $S / N gt.eq 7$@ZXM21. A total of 1863 bursts were detected in our observations; the detected number of bursts for each observation session is plotted in @fig:fig1. We also verified the search results using the software #smallcaps[BEAR]@Men19MN. No difference can be found for bursts with $S / N gt.eq 7$.


#heading(level: 3, numbering: none)[Event-rate evolution and the quenching]
<event-rate-evolution-and-the-quenching>


We adopted the Weibull distribution@Oppermann18MN to describe the probability density of time intervals between bursts. The Weibull distribution of time interval $delta$ is $ W ( delta \| k , r ) = k delta^(- 1) \[ delta thin r Gamma ( 1 + 1 / k ) \]^k e^(- \[ delta thin r Gamma ( 1 + 1 / k ) \]^k) , $ where the function $Gamma ( x ) equiv integral_0^oo t^(x - 1) upright(e)^(- t) upright("dt")$\; $r$ and $k$ are the event rate and shape parameter, respectively. The statistical inferences were carried out using the Bayesian method@Oppermann18MN implemented with the software package #smallcaps[multinest]@Feroz09MN. The inferred daily event rate and shape parameter are shown in @fig:fig1 and @fig:radiosup1. The inferred average event rate and shape parameter are $r = 21 plus.minus 2 thin upright("hr")^(-1)$ and $k = 0.60 plus.minus 0.02$ for a 95\% confidence level, where $k < 1$ indicates that the bursts tend to cluster together. The Poisson rate, implicitly assuming no temporal correlation, is computed by fixing $k = 1$. As shown in @fig:fig1, the two rates are consistent with each other within the 68\% confidence-level error. The event rate is not constant as the reduced $chi^2$, assuming constant rate, for all 45 measurements are 6.3 and 12.0 (the corresponding $P$-values are $10^(- 35)$ and $10^(- 83)$) for the Weibull and Poission cases, respectively. On May 29 (MJD~59363), the FRB source was quenched. No more bursts were detected with $S / N gt.eq 7$ thereafter in 20 days with a total of 9 hr observations. The corresponding 95\% confidence level upper limit of the event rate is $r lt.eq 0.3$ hr$""^(- 1)$.


#heading(level: 3, numbering: none)[Flux, fluence, and energy of bursts]
<sec:burstprop>


We estimated the flux densities ($S$) through the radiometer equation with a typical system temperature of 20 K and telescope gain $G approx 16$ K Jy$""^(- 1)$ for FAST@Jiang20RAA. We calculate the flux density at a frequency resolution of 7.8125 MHz and a time resolution of 196.608 $mu$s. The dominant uncertainty ($tilde 20 "%"$) in flux-density estimation comes from the temporal variation of system temperature@Jiang20RAA. The average flux density is derived from the Gaussian fitting method@CHIME20Nat. Since the average flux will depend on the definition of "signal bandwidth", we choose the 3$sigma$ width from the Gaussian fitting as our signal bandwidth. The average burst fluence ($F$) is computed by integrating the average burst flux with respect to time, and the equivalent width $W_(upright("eq"))$ is computed by dividing the fluence by the burst peak flux. The measured distributions $F$ and $W_(upright("eq"))$ are shown in @fig:flux. The average and the RMS deviation of $W_(upright("eq"))$ are 7.6 ms and 3.3 ms, respectively, while the average $F$ and its RMS fluctuation are 0.5 Jy ms and 1.0 Jy ms.


The sample completeness was determined with the following method. We simulated 10,000 mock bursts with Gaussian profile and bandpass matching the detected distributions. We then randomly injected the mock bursts into the original FAST data when no FRB was detected. The mock burst injected data are then fed to our burst-searching pipeline to compute the detection rate. The procedure shows that the fluence threshold achieving the 95\% detection probability with $S / N gt.eq 7$ is 53 mJy ms.


The isotropic burst energy $E$ was calculated by integrating over the $4 pi$ solid angle and the signal bandwidth, $E = 4 pi D_L^2 ( 1 + z )^(- 1) integral F thin d upright("BW")$, where $D_L = 453.3 plus.minus 0.1$ Mpc is the luminosity distance#cite(label("Planck16AandA")), and $F$ is the fluence. The energy inference is little affected by the choice of BW, as it is integrated. We evaluate the systematics by comparing the energy measured from integrating 2$sigma$ and 3$sigma$ Gaussian-fitting BW. The difference ($Delta E / E lt.eq$10\%) is smaller than the 20\% uncertainty in the system temperature.


The histogram of burst energies and the cumulative distribution function (CDF) of the burst energy are shown in @fig:flux. We note that the CDF of burst energy is better fitted by a broken power law rather than by a single power law; i.e., we use $ N ( gt.eq E ) prop cases(
    E^(- gamma_1) thin upright("for") thin E < E_0 thin ,,
    E^(- gamma_2) thin upright("for") thin E gt.eq E_0 thin ,
  ) $ where $gamma_1$ and $gamma_2$ are the power-law indices, and $E_0$ is the turning-over energy. The inferred parameters for the broken power law model are $gamma_1 = 0.36 plus.minus 0.02 plus.minus 0.02$, $gamma_2 = 1.5 plus.minus 0.1 plus.minus 0.1$, and $E_0 = 1.1 plus.minus 0.1 plus.minus 0.1 times 10^38 thin upright("erg")$. Here, the former uncertainty is for the 95\% confidence-level statistical error, while the later one comes from the 20\% $T_(upright("sys"))$ variation. The natural logarithmic Bayesian factor ($ln cal(B)$) of the broken power law model over the single power law model is 1275, which indicates a strong preference for the former. Our measured power-law index at the higher-energy end ($gamma_2$) is close to that of FRB~20121102A@LiDi2021 (i.e., $gamma tilde 1.4$ for $E > 3 times 10^38 thin upright("erg")$), and it is also close to the power-law index ($gamma approx 1.3$) of the bright bursts of FRB~20180916B detected by CHIME@CHIME20Nat. The power-law index at the lower-energy end ($gamma_1$) is shallower than that measured in FRB~20121102A@LiDi2021 with $gamma = 0.61 plus.minus 0.04$ for $4 times 10^36 < E < 3 times 10^38$. We tested the effects of Gaussian fitting BW on $gamma$ by comparing the value derived using 2$sigma$ and 3$sigma$ BW values, where $delta gamma_1 = 0.02$ and $delta gamma_2 = 0.06$ are comparable to the systematics of $T_(upright("sys"))$ variation. We searched for the corresponding high-energy transients in both #emph[Fermi] and #emph[Insight]-HXMT/GECAM data@Zou2021 @Cai2021, and the null detection places loose bounds that the ratio between the luminosity in radio and $gamma$-ray bands, i.e. $L_(upright("radio")) / L_(upright(gamma)) gt.eq 1.4 times 10^(- 7)$ (8--200 keV) and $gt.eq 6.3 times 10^(- 7)$ (200--3,000 keV).


#heading(level: 3, numbering: none)[Waiting time between the bursts]
<waiting-time-between-the-bursts>
The burst times of arrival (TOAs) were measured from the centroid of the best-matched boxcar filter@Men19MN. We then converted the site arrival times to the barycentric coordinate time at the reference frequency of 1500 MHz using the software package #smallcaps[tempo2]@TEMPO2ref. The waiting times ($Delta T_(upright("wait"))$) were calculated by subtracting two adjacent barycentric TOAs. The distribution of the waiting time is shown in @fig:waitingtime. We modeled it using the superposition of three log-normal distributions, where the best-fitting curve to the histogram is in @fig:waitingtime. The waiting-time distribution shows local maxima at 39 ms, 45.1 s, and 162.3 s. We note that a superposition of two log-normal distributions is insufficient to describe the data (@fig:waitingtime), which can be verified by the large value of natural logarithmic Bayesian factor ($ln cal(B) = 35$) of the three-component model over the two-component model. The multimodal distribution of waiting times is similar to the case of FRB~20121102A@LiDi2021, except that the shortest waiting-time population (39 ms) is one order of magnitude longer than that of FRB~20121102A (3.4 ms).


#heading(level: 3, numbering: none)[Dispersion measure (DM)]
<dispersion-measure-dm>


We used the Fourier-domain method to measure the dispersion measure (DM), where the DM is measured by maximising the time derivative of "intensity" computed only with the Fourier phase \(#link("https://www.github.com/DanieleMichilli/DM_phase")). The DM values as a function of time are collected in @fig:radiosup1. The mean value is $413.2 thin upright("cm")^(- 3) thin upright("pc")$ and the RMS deviation is $2.0 thin upright("cm")^(- 3) thin upright("pc")$. A linear fit shows no obvious trend in DM with a 95\% confidence-level upper limit of $\| upright("dDM") / upright("dt") \| lt.eq 7 times 10^(- 3) thin upright("cm")^(- 3) thin upright("pc") thin upright("day")^(-1)$, while there is a peak-to-peak fluctuation of $tilde 10 thin upright("cm")^(- 3) thin upright("pc")$ in the burst-to-burst DM.


The measured DM agrees with the theoretical expectation. The observed DM is $tilde 413 thin upright("cm")^(- 3) thin upright("pc")$. The Galactic interstellar medium (ISM) contribution is $upright("DM")_(upright("MW")) approx 140 thin upright("cm")^(- 3) thin upright("pc")$ or $upright("DM")_(upright("MW")) approx 200 thin upright("cm")^(- 3) thin upright("pc")$ according to the NE2001 model@CL02arXiv and the YMW16 model@YMW16, respectively. Considering a Galactic-halo contribution of $tilde 30 thin upright("cm")^(- 3) thin upright("pc")$@Dolag15MN, the total Galactic contribution is in the range 170--230 $upright("cm")^(- 3) thin upright("pc")$. The rest of all the extragalactic DM contributions would thus be 183--243 $upright("cm")^(- 3) thin upright("pc")$. Further accounting for the intergalactic medium contribution of $upright("DM")_(upright("IGM")) approx 80 thin upright("cm")^(- 3) thin upright("pc")$ at $z = 0.09795$@DengZhang2014, the FRB host-galaxy DM contribution should be in the range 103--163 $upright("cm")^(- 3) thin upright("pc")$. This value agrees with the modeling of the host galaxy using the DM template technique@Luo18MN, which predicted that the 68\%-confidence-level range of the host-galaxy DM is $10 lt.eq upright("DM")_(upright("host")) / ( 1 + z ) lt.eq 300 thin upright("cm")^(- 3) thin upright("pc")$, where the host-galaxy H$alpha$ luminosity $L_(upright("H") thin upright("alpha")) = 7 times 10^41$ erg s$""^(- 1)$ and the effective radius $R_e = 1.5$ kpc are from our optical observations (see the optical observation section in Methods).


#heading(level: 3, numbering: none)[Polarisation properties]
<sec:polarisation>


Our polarisation data are calibrated with the single-axis model using the software package #smallcaps[psrchive]@HvSM04, where both the differential gain and phase between the two polarisation channels are calibrated using noise diode signal injected in the feed. The polarisation fidelity and calibration scheme have been described and tested in previous work@Jiang20RAA @Luo20Nat.


We measure the RM for high-quality bursts only with $S / N gt.eq 30$ (1103 in total) using the $Q - U$ fitting method@DKL19. We corrected the ionosphere contribution with values computed from the software package #smallcaps[ionFR]@SSH13, where the maximal ionosphere RM correction is 3 $upright("rad") thin upright(m)^(- 2)$. The RM in the FRB's source rest frame@WPK84 @ARG16 is $upright("RM")_(upright("host")) = ( 1 + z )^2 ( upright("RM")_(upright("obs")) - upright("RM")_(upright("Gal")) ) = - 380 thin upright("rad") thin upright(m)^(- 2)$ to $- 1010 thin upright("rad") thin upright(m)^(- 2)$.


We can exclude a few common origins for the RM variation. (1) The RM variation cannot be explained with the RM contribution in the MW, which is $- 51 ( 5 )$ $upright("rad") thin upright(m)^(- 2)$ along the direction of FRB~20201124A; the maximal variation is a few tens of radians per square meter within a $2^compose$ field of view@XuHan14. (2) The RM variation is not caused by instrumental artifacts. In polarisation studies, we have excluded the data of April 1 and 2, where the observations were carried out with off-axis illumination. The FAST polarimetry stability has been checked@Luo20Nat to show that the RM measurement is stable with $Delta upright("RM") lt.eq 0.2 thin upright("rad") thin upright(m)^(- 2)$. We also checked if saturation or nonlinearity affected our polarimetry. The digital sampling and data recording is done with an 8-bit sampling scheme at FAST. We tested the nonlinearity by comparing the differences in results between including and removing the data above 250 (the maximal digital value is 255 for an 8-bit system); the differences are tiny. (3) RM variation is not from the apparent RM variation across the phase of a burst as found in pulsars@NKK09 and in FRBs@Cho20. We find that the maximum amplitude of RM variations within single bursts for FRB 20201124A is at the level of 15 $upright("rad") thin upright(m)^(- 2)$ (examples are shown in @fig:burstrm), which is too small to explain the RM variation of FRB 20201124A at the level of $tilde 500$ $upright("rad") thin upright(m)^(- 2)$. (4) RM variation is not caused by the intrinsic frequency evolution of individual bursts, as the PA rotation matches the cold plasma Faraday rotation relation. We relaxed the power-law index of wavelength in $Q - U$ fitting and also fit for the RM index $beta$ using the model $Delta Psi = upright("RM") thin lambda^beta$. One expects $beta = 2$ if the cold plasma Faraday rotation model can be applied, while the index $beta$ would not necessarily equal 2 if the apparent RM is caused by intrinsic profile evolution. As shown in @fig:RMindex, we found that for 57\% of the bursts (631 out of 1103 bursts), the deviations of measured RM index values are within 1$sigma$ error bars. Visual inspection revealed that the $beta eq.not 2$ deviation was mainly caused by overlapping of multiple components in the dynamic spectrum. The detected trend of RM variation is hardly affected by the $beta eq.not 2$ deviation as shown in @fig:RMindex. To further reduce the profile-evolution effects, only the measurements with RM index within 1$sigma$ of $beta = 2$ are included in @fig:fig1.


Considering the 10-day timescale of RM variation, we expect that the major RM variation comes from the FRB local environment, over a distance scale of $Delta X approx 0.6 thin upright("au") thin ( tau / 10 thin upright("day") ) ( v / 100 thin upright("km") thin s^(- 1) )$, where we normalised velocity to the typical value of binary motion or proper motion of neutron stars. We can derive a bound on the parallel magnetic field by using the constraint induced by free-free absorption at such a small distance scale. The detection of FRB emission requires that the free-free absorption optical depth should be smaller than unity@MH67 @Hessels19ApJL, which means that the local DM contributing to the RM variation meets $ upright("Delta") thin upright("DM") < 4 eta (T / 10^4)^0.7 (nu / upright("GHz"))^1.1 (frac(Delta X, upright("au"))) thin , $ where we converted the DM to EM via the filling factor $eta equiv frac(Delta upright("DM")^2, Delta X upright("EM")) lt.eq 1$. One finds $ chevron.l B_parallel chevron.r = 1.23 med upright("mu") thin upright("G") thin frac(Delta upright("RM"), Delta upright("DM")) > 0.2 med upright("mG") thin eta^(- 1) (frac(Delta upright("RM"), upright(5) 00 thin r a d thin m^(- 2))) (T / 10^4)^(- 0.7) (nu / upright("GHz"))^(- 1.1) (frac(Delta X, upright("au")))^(- 1) thin . $ Here RM is defined in the source rest frame. Such a mG-level lower bound of the magnetic field was also reported for FRB~20121102A@Michilli18Nat @VedanthamRavi2019 based on the host-galaxy DM estimation.


For 41 of the total 1863 bursts, we have discovered oscillations of fractional circular/linear polarisation ($Pi_(upright(V)) equiv V / I , Pi_(upright(L)) equiv L / I$), and linear PA. The oscillation can be characterised with periodicity in the square of wavelength, and we use the Lomb-Scargle periodogram@Lomb1976 to find such features. A $chi^2$ fitting to the following model simultaneously for circular and linear polarisation intensities is used to infer the oscillation parameters: $ L & = & I [Pi_(upright("L0")) + dot(Pi)_(upright("L")) lambda^2 + A sin ( omega_(lambda^2) lambda^2 + phi.alt_(upright("L")) )] thin ,\
V & = & I [Pi_(upright("V0")) + dot(Pi)_(upright("V")) lambda^2 + A sin ( omega_(lambda^2) lambda^2 + phi.alt_(upright("V")) ) \]] thin ,\
Q & = & L cos [upright("PA")_0 + A_(upright("PA")) cos ( omega_(lambda^2) lambda^2 + phi.alt_(upright("PA")) )] thin ,\
U & = & L sin [upright("PA")_0 + A_(upright("PA")) cos ( omega_(lambda^2) lambda^2 + phi.alt_(upright("PA")) )] thin , $<eq:fitmod1> where the parameters $Pi_(upright("L0"))$, $dot(Pi)_(upright(L))$, $Pi_(upright("V0"))$, and $dot(Pi)_(upright(V))$ are the average values and the slopes of the fractional linear and circular polarisation, $A$ is the amplitude of oscillation in the fractional polarisation, $upright(P) A_0$ is the mean PA, and $A_(upright("PA"))$ is the amplitude of the oscillation in PA. A common angular frequency of oscillation ($omega_(lambda^2)$) is assumed for $Pi_(upright(V))$, $Pi_(upright(L))$ and PA. The $phi.alt_(upright(L))$, $phi.alt_(upright(V))$, and $phi.alt_(upright("PA"))$ are oscillation phases. The best-fitting conjugate frequencies of bursts 779 and 926 are $omega_(lambda^2) = 2400 plus.minus 30 thin upright("rad") thin upright(m)^(- 2)$ and $1800 plus.minus 10 thin upright("rad") thin upright(m)^(- 2)$. In the framework of mild polarisation absorption or Faraday conversion, one has $\| upright("R") thin upright("M'") \| = omega_(lambda^2) / 2$, which is the Faraday rotation accumulated from the FRB, along the line of sight, up to the position where the absorption or conversion occurs: $upright("RM")' = 1200 plus.minus 15 thin upright("rad") thin upright(m)^(- 2)$, $900 plus.minus 5 thin upright("rad") thin upright(m)^(- 2)$, respectively. We note that the total observed RM is of the same order of magnitude, which indicates that a significant amount of RM comes from the vicinity of the FRB source, where, at the same time, Faraday conversion or synchrotron absorption is still important@Sazonov69 @HuangShcherbakov2011, i.e. a cold and a relativistic plasma coexist.


We plot the best-fit curves against the data in @fig:fig2, where we convert the model to fractional polarisation for better visualisation. The best-fit phase differences between the linear and circular oscillations are given in panel (d) of @fig:fig2. For burst 779, the oscillations of $Pi_(upright(V))$ and $Pi_(upright(L))$ decrease significantly above 1160 MHz ($lambda^2 lt.eq 0.067 thin upright(m)^2$ as indicated by the shaded area in @fig:fig2), where the best-fit amplitudes of oscillation below and above 1160 MHz are $0.16 plus.minus 0.01$ and $0.008 plus.minus 0.005$, respectively. Such frequency-dependent oscillation can be explained with the characteristic frequency of a uniformly magnetised plasma@HuangShcherbakov2011 that the plasma effects are important when wave frequency bellow the characteristic frequency, i.e. $f lt.eq 0.04 thin upright("GHz") thin ( B / upright(G) ) gamma^2$, with $gamma$ the electron kinetic Lorentz factor. In the polarisation-dependent radiative transfer framework, the constraint for magnetic field becomes $B gt.eq 3 thin upright(G) ( f / upright("1.1") thin upright("GHz") ) ( gamma / 10 )^(- 2)$.


We checked the power-law index of oscillation with respect to $lambda$ by replacing terms of $omega_(lambda^2) lambda^2$ in @eq:fitmod1 and (@eq:fitmod1) to a generalised form of $omega_(lambda^(2 k)) lambda^(2 k)$ and fit the index $k$ simultaneously. For bursts 779 and 926, we had $k = 0.998 plus.minus 0.005$ and $1.0 plus.minus 0.1$, which verifies the $lambda^2$-dependent oscillation of polarisation.


Besides Faraday conversion, polarisation-dependent scintillation can also induce such $lambda^2$-dependent oscillations@Beniamini2021, if the number of slits on the scintillation screen is limited. However, special conditions are required in this model to reproduce the observation. First, polarisation-dependent absorption is still required to induce oscillation in total polarisation $Pi_(upright(P))$. Second, contrived fine tuning is required to achieve a 40\% $Pi_(upright(V))$ variation for a $< 10^compose$ PA change as seen in burst 779. Also, an extra mechanism is needed to cease the polarisation oscillations above 1160 MHz for burst 779.


We note that not all bursts with the measured nonzero $Pi_(upright(V))$ show the above oscillatory behaviour. Some bursts exhibit slow variations with opposite phases of $Pi_(upright(V))$ and $Pi_(upright(L))$, such as burst 1112 in @fig:fig2. The variation may come from Faraday conversion or an intrinsic radiation mechanism of FRBs. Interestingly, the burst with the highest $Pi_(upright(V))$ in our sample (burst 1472 in @fig:fig2) shows no significant oscillation. Therefore, on top of Faraday conversion, an alternative, intrinsic radiation mechanism may be required to generate circular polarisation.


#heading(level: 3, numbering: none)[Keck optical and near-infrared observations]
<keck-optical-and-near-infrared-observations>


We obtained Keck I low- and high-dispersion spectra with the Low Resolution Imaging Spectrometer (LRIS)@Oke1995 @Rockosi2010 and the Echellette Spectrograph Imager (ESI)@Sheinis2002, respectively. The LRIS spectra were taken with a slit width of $1.0''$ at PA = $53.4^compose$, and there were $750 + 920$ s and $2 times 750$ s exposures on the blue and red sides, respectively. LRIS has an atmospheric dispersion corrector. The data were reduced using LPipe @Perley2019, and the fluxes were scaled to match Pan-STARRS1 @Pan-STARRS12020 $g r i z$ photometry. Galactic extinction corrections@Cardelli1989 @Schlafly2011 were applied with $R_V = 3.1$ and $E ( B - V )_(upright("MW")) = 0.652$ mag. We took $8 times 320$ s exposures with ESI in the cross-dispersed echelle mode with resolving power $R approx 10 , 000$ and a slit width of $1.0''$ at the parallactic angle@Filippenko1982 of $87^compose$. They were reduced with ESIRedux \(#link("https://www2.keck.hawaii.edu/inst/esi/ESIRedux/index.html")), with only relative-flux calibration performed.


The LRIS imaging consisted of $4 times 180$ s exposures in the $g$ band and $2 times 180$ s in the $i$ band. They were reduced following standard procedures of bias subtraction, flat fielding, and coadding.


We obtained $4 times 120$ s near-infrared $K'$-band images (dithered by 3--4$''$ between exposures) with the NIRC2 camera ($0.04''$ pixel$""^(- 1)$ scale and $40''$~field) via the Keck II laser-guide-star AO system @Wizinowich06. An $R = 15.9$ mag star $36''$~NW of the FRB host served as the tip-tilt reference star. The images were reduced following a standard iterative procedure implemented in an IDL package \(#link("https://github.com/fuhaiastro/nirc2")), and the final combined image reaches a full width at half-maximum intensity (FWHM) resolution of $0.12''$.


The astrometry is calibrated using five stars in the field to the #emph[Gaia] reference frame (Gaia-CRF2 @Gaia-CRF2), which is tied to the International Celestial Reference System (ICRF) reference system using accurate VLBI positions of quasars at sub-mas precision.


#heading(level: 3, numbering: none)[Properties of the host galaxy]
<properties-of-the-host-galaxy>


#heading(level: 4, numbering: none)[Star-formation rate and gas-phase metallicity:]
<star-formation-rate-and-gas-phase-metallicity>
We use the emission lines detected in the high-$S / N$ LRIS spectrum to measure the redshift ($z = 0.09795 plus.minus 0.00003$), infer the star-formation rate (SFR), and determine the gas-phase metallicity of the galaxy. We measure line fluxes of H$alpha$, [N II] $lambda 6548$, [N II] $lambda 6583$, [O III] $lambda 5007$, [O II] $lambda 3726$, 3729, and [S II] $lambda 6716$, 6731 by fitting single-Gaussian profiles; for H$beta$, we add an additional Lorentzian component to account for stellar absorption.


We use the $upright(H) alpha$ luminosity $L ( upright(H) alpha )$ to estimate the SFR. The internal extinction of the galaxy is estimated with the Balmer decrement by adopting $( upright(H) alpha / upright(H) beta )_(upright("theory")) = 2.86$ for Case B recombination and using the Calzetti et al.@Calzetti2000 reddening curve; we obtain $E ( B - V ) = 0.43 plus.minus 0.04$ mag and thus $A_lambda ( upright(H) alpha ) = 1.27 plus.minus 0.12$ mag, yielding $L ( upright(H) alpha ) = ( 6.9 plus.minus 0.7 ) times 10^41$ erg s$""^(- 1)$, which translates to SFR $= 3.4 plus.minus 0.3 thin M_⊙$ yr$""^(- 1)$@Heintz2020. Our SFR estimate is higher than previous $L ( upright(H) alpha )$-based measurements, $tilde 2.1 thin upright(M)_⊙ "yr"^(- 1)$ @Fong21, $tilde 1.7 thin upright(M)_⊙ "yr"^(- 1)$ @Ravi21, and $2.3 plus.minus 0.4 thin upright(M)_⊙ "yr"^(- 1)$ @Piro21, while it is lower than those derived from spectral energy distribution (SED) fitting ($tilde 4.3 thin upright(M)_⊙ "yr"^(- 1)$ @Fong21) and radio data ($tilde 7 thin upright(M)_⊙ "yr"^(- 1)$ @Ravi21 and $tilde 10 thin upright(M)_⊙ "yr"^(- 1)$ @Piro21). Adopting a stellar mass $M_(*) = ( 2.5 plus.minus 0.7 ) times 10^10 thin M_⊙$ for the galaxy from averaging two existing results@Fong21 @Ravi21, the specific SFR is $log ( upright("sSFR") / upright("yr")^(- 1) ) = - 9.86 plus.minus 0.11$. We also cross-check it by estimating sSFR using the equivalent width (EW) of H$alpha$, EW(H$alpha$) = 48 Å  and obtain $log ( upright("sSFR") / upright("yr")^(- 1) ) = - 9.65 plus.minus 0.19$ @Belfiore2018\; it is higher than our $L ( upright(H) alpha )$-based estimate by $tilde 1 thin sigma$.


We infer the gas-phase metallicity ($Z$) by applying the Inferring metallicities ($Z$) and Ionization parameters ($q$) (IZI) photoionisation model@Blanc2015 @Mingozzi2020 to the fluxes of all the above-mentioned emission lines, yielding a best-fit oxygen abundance of 12 + log(O/H) = $9.07_(- 0.04)^(+ 0.03)$, in agreement with a previous estimate@Fong21 (12 + log(O/H) = $9.03_(- 0.24)^(+ 0.15)$) using the "O3N2" method.


#heading(level: 4, numbering: none)[Morphology and kinematics:]
<morphology-and-kinematics>
The left and middle subpanels of @fig:opticalobs01\(a) show the LRIS $i$-band image and the NIRC2 $K'$-band AO image, respectively. The AO image with FWHM $= 0.12''$ enables us to resolve the bar and spiral features of the galaxy, which is not possible with natural seeing. We used GALFIT @Peng2010 to model the host galaxy in the NIRC2 image with a single-component model composed of a Sérsic profile in the radial direction and a generalised ellipse function in the azimuthal direction. We obtain the best-fit effective radius $R_e = 1.5$ kpc and axis ratio $b / a = 0.62$, which suggests cos $( i )$ = 0.6 (where $i$ is disc inclination angle) @Holmberg1958 @TF1977AA.


After subtracting the disc component, the galaxy bar and spiral features can be clearly seen in the residual NIRC2 image shown in the right-most subpanel of @fig:opticalobs01\(a). We measure the centroid of the galaxy bar by fitting a two-dimensional (2D) Gaussian model and obtain refined J2000 coordinates of the galaxy centre \(RA $= 05^(upright(h)) 08^(upright(m)) 03.4896^(upright(s))$, Dec $= + 26^compose 03' 37.869^('')$). The FRB is $0.239 plus.minus 0.013''$ and $0.636 plus.minus 0.007''$ to the east and north of the galaxy centre, respectively. The uncertainties are estimated by adding the localisation uncertainties from EVN ($Delta upright("RA")_(upright("EVN")) = 4.5$ mas and $Delta upright("Dec")_(upright("EVN")) = 3.6$ mas @FRB20201124AEVN) and optical observations ($Delta upright("RA")_(upright("opt")) = 12.0$ mas and $Delta upright("Dec")_(upright("opt")) = 6.5$ mas) in quadrature. The error budget of optical astrometry is dominated by the uncertainties from the Keck-#emph[Gaia] frame transformation, whereas the centroiding errors in Keck (2 mas) and #emph[Gaia] (from a fraction of 1 mas to $tilde 2$ mas for the five reference stars) are relatively minor.



The object's projected position is on the disc, although it does not seem to coincide with any other visible structures. We measure the one-dimensional intensity profile of a chord slicing through the FRB position and perpendicular to the major axis of the bar on the NIR2 image. We find that it is well described by a model of concentric double Gaussian functions with the broader ($ =511$,mas) and narrower ($ =96$,mas) Gaussians describing the disc and the bar contributions, respectively. We subtract the broader Gaussian (i.e., the disc contribution) and find that at the position of the FRB, which is $260 13$,mas from the bar centre, its light has only $7\%$ of the peak bar intensity, which is very small.


As shown in @fig:opticalobs01(b), the H$alpha$ line in the ESI spectrum has a double-peaked profile with a peak-to-peak separation of $tilde 100$ km s$""^(- 1)$, which may be due to disc rotation; however, since the ESI slit was oriented along the minor axis of the galaxy, it may alternatively be caused by gas outflow. We study the disc rotation with LRIS, for which the slit was oriented $60^compose$ with respect to the major axis. As shown in the left subpanels of @fig:opticalobs01(c), the wavelength centroids of H$alpha$ emission vary along the LRIS slit direction. We extract H$alpha$ lines with a step size of 3 pixels ($0.4''$) along the slit direction, and we measure their projected galactocentric distance ($r_perp$) and line-of-sight velocities ($v$) to the continuum centre shown as the black dots in the right subpanel of @fig:opticalobs01(c). Then we fit the data using a simple rotational disc model, in which velocity scales linearly with galactocentric distance $r$ for $r < r_(upright("break"))$ (the velocity zero point is a free parameter) and stays constant at $v_(upright("ROT"))$ for $r > r_(upright("break"))$. The best-fit model, which is shown as the red line in the right subpanel of @fig:opticalobs01(c), has the deprojected rotation velocity $v_(upright("ROT")) = 139 plus.minus 19 thin upright(k) m thin s^(- 1)$ and $r_(upright("break")) = 3.0 plus.minus 0.5$ kpc. Our $v_(upright("ROT"))$ estimate suggests a galaxy stellar mass $M_(*) approx 2 times 10^10 thin M_⊙$ using the Tully-Fisher relation @TF1977AA @Ouellette2017. This is consistent with our adopted value $M_(*) = \( 2.5 plus.minus 0.7 \) times 10^10 thin M_⊙$ from averaging two previous estimates @Fong21 @Ravi21.


#heading(level: 3, numbering: none)[Background galaxy]
<background-galaxy>



Fong et al.@Fong21 tentatively identified a background galaxy with the possible detection of H$beta$ and [O III] emission lines at $z = 0.5531$. Our spectra allow its firm identification and study of its properties. We detect H$alpha$, H$beta$, and [O III] $lambda lambda 4959$, 5007 emission lines at $z = 0.5534 plus.minus 0.0001$ in the LRIS (blue) and ESI (cyan) spectra (see @fig:opticalobs02(c)). Owing to the nondetection of [N II] (or [O II]), we cannot distinguish between a star-forming galaxy and an active galactic nucleus (AGN) in the Baldwin-Phillips-Terlevich (BPT) diagram (see @fig:opticalobs02(a)). The [O III] $lambda 5007$ line is resolved by ESI with a velocity dispersion $sigma_("[O III]" thin lambda 5007) = 27.6 plus.minus 2.6$ km s$""^(-1)$;

such a low velocity dispersion favours that it is a star-forming galaxy@Law2021. Using IZI, we find that its gas-phase metallicity $12 + log("O/H") = 8.29_(-0.28)^(+0.26)$ and $E(B - V) = 0.27_(-0.13)^(+0.12)$ mag. The extinction-corrected $L(upright(H) alpha) = 1.14_(-0.38)^(+0.51) times 10^42$ erg s$""^(-1)$, which yields SFR $= 5.7_(-1.9)^(+2.5) thin M_⊙$ yr$""^(-1)$.

The centres of [O III] $ 5007$ emission from the background galaxy are offset from the centre of the continuum dominated by the host (foreground) galaxy in the 2D spectroscopic image.  We measure the centroid of the background galaxy by using its [O III] emission line detected at two slit orientations, which are shown in @fig:fig3(b); it is $0.29''$ west and $0.22''$ north of foreground galaxy's centre. Owing to the large projected separation of 4.7 kpc, and inconsistency of the expected DM and scattering timescale@Main2021, it is unlikely that the background galaxy is the FRB host.





#heading(level: 3, numbering: none)[Data availability]
<data-availability>
Raw data are available from the FAST data center, #link("http://fast.bao.ac.cn"). Owing to the large data volume, we encourage contacting the corresponding author for the data transfer. The directly related data that support the findings of this study can be found at the PSRPKU website, #link("https://psr.pku.edu.cn/index.php/publications/frb20201124a/") and Figshare website, #link("https://doi.org/10.6084/m9.figshare.19688854").


#heading(level: 3, numbering: none)[Code availability]
<code-availability>
#smallcaps[PSRCHIVE] (#link("http://psrchive.sourceforge.net"))


#smallcaps[transientx] (#link("https://github.com/ypmen/TransientX"))


#smallcaps[BEAR] (#link("https://psr.pku.edu.cn/index.php/publications/frb180301/"))


#block[
]


We are grateful to L. C. Ho, H. Gao, and R. Li for discussions. This work made use of data from the FAST. FAST is a Chinese national megascience facility, built and operated by the National Astronomical Observatories, Chinese Academy of Sciences. We acknowledge the use of public data from the Fermi Science Support Center (FSSC). This work is supported by National SKA Program of China (2020SKA0120100, 2020SKA0120200), Natural Science Foundation of China (12041304, 11873067, 11988101, 12041303, 11725313, 11725314, 11833003, 12003028, 12041306, 12103089, U2031209, U2038105, U1831207), National Program on Key Research and Development Project (2019YFA0405100, 2017YFA0402602, 2018YFA0404204, 2016YFA0400801), Key Research Program of the CAS (QYZDJ-SSW-SLH021), Natural Science Foundation of Jiangsu Province (BK20211000), Cultivation Project for FAST Scientific Payoff and Research Achievement of CAMS-CAS, the Strategic Priority Research Program on Space Science, the Chinese Academy of Sciences (grants XDA15360000, XDA15052700, XDB23040400), funding from the Max-Planck Partner Group, the science research grants from the China Manned Space Project (CMS-CSST-2021-B11,NO. CMS-CSST-2021-A11), and PKU development grant 7101502590. AVF's group at U.C.~Berkeley is supported by the Christopher R. Redlich Fund, the Miller Institute for Basic Research in Science (in which AVF was a Miller Senior Fellow), and many individual donors. SD acknowledges support from the XPLORER PRIZE. BBZ is supported by Fundamental Research Funds for the Central Universities (14380046), and the Program for Innovative Talents, Entrepreneur in Jiangsu. Some of the data presented herein were obtained at the W.M. Keck Observatory, which is operated as a scientific partnership among the California Institute of Technology, the University of California, and NASA; the observatory was made possible by the financial support of the W.M. Keck Foundation. We thank the Keck staff for their help during the observing runs.


HX, JRN, and PC led the data analysis. KJL, WWZ, SD, and BZ coordinated the observational campaign, cosupervised data analyses and interpretations, and led the paper writing. JCJ conducted the polarisation and RM measurements. BJW, JWX, CFZ, and KJL did the timing analysis, periodicity search, DM measurement, burst searching, and Faraday conversion measurement. YPM contributed to the searching software development. RNC, MZC, LFH, YXH, ZYL, ZXL, YHX, and JPY performed software testing. DJZ, YKZ, PW, YF, CHN, FYW, XFW, and SBZ contributed to radio data analysis. PC, SD, HF, AVF, EWP, TGB, SGD, PG, DS, AS, WKZ, and AE contributed to the optical observations and data reduction; AVF also edited the manuscript in detail. PC, SD, HF, and YL contributed to analysing and interpreting the optical data. PJ, HQG, JLH, JLH, HL, LQ, JHS, RY, YLY, DJY, and YZ aided with FAST observations. JLH, DL, MW, and NW helped with observation coordination. KJL, BZ, DZL, WYW, RXX, WL, YPY,WFY, ZGD, and RL provided theoretical discussions. CC, CKL, XQL, WXP, LMS, SX, SLX, JY, XY, QBY, BBZ, SNZ, and JHZ contributed to the high-energy observations and data analyses.


The authors declare no competing financial interests.


Requests for materials should be addressed to the following: \
K.~J.~Lee (E-mail:kjlee\@pku.edu.cn) \
S.~Dong (E-mail: dongsubo\@pku.edu.cn) \
W.~W.~Zhu (E-mail:zhuww\@nao.cas.cn) \
B.~Zhang (Email:bing.zhang\@unlv.edu) \



#heading(level: 3, numbering: none)[Addendum]











#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf1.png
// 该图包含三个垂直排列的子图，分别标记为a、b和c，共享同
// 一个横坐标轴。 子图a是一个散点图，用于展示威布尔分布在
// 事件率推断中的形状参数k随时间的变化。纵坐标轴标记为“k”，
// 范围从略低于1到2.5，刻度标记为1和2。横坐标轴位于最下方，
// 标记为“Date (MJD)”，即修正儒略日，范围从59310到59360，
// 主刻度间隔为10天（59310, 59320, 59330, 59340, 59350,
// 59360）。图中数据点为深蓝色的实心圆点，每个点上方带有
// 一条垂直的误差棒，表示68%置信水平下的不确定性。在纵坐
// 标k=1的位置有一条水平的黑色虚线贯穿整个子图。数据点在k
// =1附近波动，大部分数值在0.5到1.0之间，但在日期约59342
// 至59345期间出现显著升高，其中一点接近k=2，且伴随较大的
// 误差棒。 子图b是一个小提琴图与折线图结合的复合图，展示
// 每日爆发能量（Log10E）的时间分布。纵坐标轴标记为“
// Log10E (erg)”，表示以10为底的对数能量，单位为尔格（erg），
// 范围从36到39，刻度标记为36、37、38、39。横坐标轴与子图
// a相同。图中主要元素包括：深蓝色的竖直小提琴符号，其轮
// 廓表示每日能量值的概率密度分布函数；浅绿色的阴影带状区
// 域，覆盖在小提琴图外部，表示95%的上限和下限范围；一条
// 黑色的实线曲线，穿过小提琴图的中间，表示每日能量值的中
// 位数。中位数曲线在Log10E约为37.2至37.4之间小幅波动，整
// 体趋势相对平稳。小提琴图的宽度反映了数据的离散程度，部
// 分日期（如59310附近）分布较宽，表明能量值波动较大。 子
// 图c的结构与子图b完全相同，展示的是色散量（DM）的时间分
// 布。纵坐标轴标记为“DM (pc cm^-3)”，单位为立方厘米每平
// 方秒差距，范围从410到420以上，刻度标记为410和420。横坐
// 标轴同样与子图a和b对齐。图中同样包含深蓝色的小提琴符号
// 表示每日DM值的分布函数，浅绿色阴影带表示95%的上下限，
// 以及黑色实线表示中位数。中位数曲线在DM值约412至415之间
// 波动，在日期59340附近出现一个明显的下凹，随后回升。小
// 提琴图显示在某些日期（如59340附近）DM值的分布范围较窄，
// 而在其他日期则较宽，反映出测量精度的变化或物理过程的波
// 动。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf1.png", width: 100%),
    caption: [
      #strong[Temporal variations of extra physical parameters.] #strong[(a)] Shape parameter ($k$) of Weibull distribution in event-rate inference. The error bar is at 68"%" confidence level. #strong[(b)] and #strong[(c)] Daily burst energy and DM, where the violin symbol indicates the distribution function, the green shaded strips indicate the 95"%" upper and lower bounds, and the solid black curve is the median.
    ]
  ) <fig:radiosup1>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf2.png
// 该图包含六个子图，分别标记为a、b、c、d、e、f，展示了探
// 测到的快速射电暴（FRB）的流量密度、等效宽度和能量分布。
// 子图 a 和 b 位于左侧上方，共享同一个横坐标轴。 子图 a
// 是一个累积分布曲线图。纵坐标轴名称为“Percentage (>F) (%
// )”，表示百分比，范围从0到100，刻度间隔为50。横坐标轴名
// 称为“Fluence (Jy ms)”，表示流量密度，采用对数标度，范
// 围从10的负2次方到10的2次方，主刻度标记为10的-2、-1、0、
// 1、2次方。图中有一条黑色阶梯状实线，表示流量密度的累积
// 分布函数，曲线从左上角（约100%）开始，随着流量密度增加
// 而单调下降。图中还有一条红色垂直虚线，位置在横坐标约
// 0.053 Jy ms处（即53 mJy ms），延伸至图表顶部，表示95%
// 的完备性阈值。 子图 b 是一个直方图，位于子图 a 的正下
// 方。纵坐标轴名称为“Counts”，表示计数，范围从0到150，刻
// 度间隔为50。横坐标与子图 a 相同。图中由一系列白色填充、
// 黑色边框的矩形条组成，展示了流量密度的频率分布。分布呈
// 现右偏态，峰值出现在0.1至1 Jy ms之间，最高柱状图的计数
// 接近150。子图 a 中的红色垂直虚线在此图中同样存在，对应
// 于低流量密度区域。 子图 c 和 d 位于左侧下方。 子图 c
// 是一个二维散点图。纵坐标轴名称为“Width (ms)”，表示脉冲
// 宽度，采用对数标度，范围大约从1 ms到100 ms，主刻度标记
// 为10的1次方。横坐标轴名称为“Fluence (Jy ms)”，表示流量
// 密度，采用对数标度，范围从10的负2次方到10的2次方。图中
// 包含数百个蓝色实心圆点，每个点代表一个探测到的暴事件。
// 数据点在图上广泛分布，没有明显的线性相关性，但在流量密
// 度大于0.1 Jy ms且宽度在1 ms到10 ms的区域密度较高。 子
// 图 d 是一个水平方向的直方图，紧贴在子图 c 的右侧边缘，
// 作为子图 c 的边际分布。其横坐标轴名称为“Counts”，范围
// 从0到200，刻度标记为0和200。纵坐标轴与子图 c 的纵坐标
// 轴对齐，表示脉冲宽度。图中由一系列白色填充、黑色边框的
// 水平矩形条组成，展示了脉冲宽度的频率分布。分布较为均匀，
// 在宽度约10 ms处有一个较宽的峰。 子图 e 和 f 位于右侧，
// 上下排列，共享同一个横坐标轴。 子图 e 是一个带拟合线的
// 散点图。纵坐标轴名称为“N(>E)”，表示能量大于E的事件数量，
// 采用对数标度，范围从10的0次方到10的3次方，主刻度标记为
// 10的0、1、2、3次方。横坐标轴名称为“Energy (erg)”，表示
// 能量，采用对数标度，范围从10的36次方到10的40次方，主刻
// 度标记为10的36、37、38、39次方。图中有一系列带有垂直误
// 差棒的黑色实心圆点，数据点整体呈下降趋势，表明高能量的
// 事件数量较少。一条黑色实线穿过这些数据点，表示幂律拟合
// 模型。图中有两条垂直虚线：一条位于横坐标约2乘以10的36
// 次方 erg处，另一条位于10的38次方 erg处，这两条线贯穿子
// 图 e 和 f。 子图 f 是一个直方图，位于子图 e 的正下方。
// 纵坐标轴名称为“Counts”，表示计数，采用对数标度，范围从
// 10的0次方到10的2次方，主刻度标记为10的0、1、2次方。横
// 坐标与子图 e 相同。图中由一系列白色填充、黑色边框的矩
// 形条组成，展示了 FRB 20201124A 暴事件的能量分布。分布
// 形态大致呈钟形或截断的幂律分布，峰值出现在10的37次方
// erg附近，最大计数超过100。子图 e 中的两条垂直虚线在此
// 图中同样可见。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf2.png", width: 100%),
    caption: [
      #strong[Fluence, equivalent width, and energy distribution for detected bursts.] #strong[(a)] and #strong[(b)] Cumulative distribution and histogram of the burst fluence; the red dashed vertical line at 53 mJy ms indicates the 95"%" completeness threshold. #strong[(c)] The 2D distribution of fluence and burst width. #strong[(d)] Histogram of burst width. #strong[(e)] and #strong[(f)] Cumulative distribution and histogram of FRB~20201124A burst energy; the black dashed vertical line at $2 times 10^36 thin upright("erg")$ indicates 95"%" completeness assuming a burst bandwidth of 185 MHz, the median of the burst bandwidths. The broken power-law fit to the cumulative distribution of energy is the solid black curve, with the break point at $1.1 times 10^38 thin upright("erg")$ indicated by a dot-dashed vertical line.
    ]
  ) <fig:flux>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf3.png
// 该图包含两个并排的子图，分别标记为a和b，均为直方图与拟
// 合曲线叠加的统计分布图。 子图a： 子图类型：直方图叠加
// 拟合曲线图。 坐标轴：横轴为“Waiting Time (s)”，采用对
// 数刻度，范围从10^-2秒到10^3秒；纵轴为“Counts”，线性刻
// 度，范围从0到160。 数据表示：黑色空心矩形条代表观测数
// 据的计数分布（Data），在约0.04秒处有一个小峰（峰值约30），
// 在约100秒处有一个主峰（峰值约145）。 拟合曲线：一条蓝
// 色实线代表使用两个对数正态函数进行的最佳拟合（
// 2-Log-Normal Fit）。该曲线由两个分量叠加而成，一个分量
// 峰值位于39毫秒（即0.039秒），另一个分量峰值位于106.7秒。
// 蓝色曲线整体贴合黑色直方图的轮廓，在两个峰值区域均与数
// 据吻合良好。 标注文字：左上角有图例，标明“2-Log-Normal
// Fit”对应蓝色实线，“Data”对应黑色空心框。 子图b： 子图
// 类型：直方图叠加多组分拟合曲线图。 坐标轴：横轴为“
// Waiting Time (s)”，对数刻度，范围从10^-2秒到10^3秒；纵
// 轴为“Counts”，线性刻度，范围从0到160。 数据表示：黑色
// 空心矩形条代表观测数据（Data），分布形态与子图a相同。
// 拟合曲线： 蓝色实线：代表使用三个对数正态函数进行的总
// 最佳拟合（3-Log-Normal Fit），其形状与子图a中的蓝色曲
// 线相似，但更精细地分解了主峰结构。 橙色虚线：代表第一
// 个对数正态分量（Log-Normal Component 1），峰值位于39毫
// 秒（0.039秒），主要贡献于左侧小峰。 绿色虚线：代表第二
// 个对数正态分量（Log-Normal Component 2），峰值位于45.1
// 秒，构成主峰的左半部分。 红色虚线：代表第三个对数正态
// 分量（Log-Normal Component 3），峰值位于162.3秒，构成
// 主峰的右半部分。 布局关系：三条虚线分量曲线相加后形成
// 蓝色实线总拟合曲线。橙色分量独立于左侧小峰，绿色和红色
// 分量共同构成右侧主峰，二者在约100秒附近重叠，导致主峰
// 呈现不对称或双峰特征。 标注文字：左上角图例标明：“
// 3-Log-Normal Fit”对应蓝色实线，“Log-Normal Component 1
// ”对应橙色虚线，“Log-Normal Component 2”对应绿色虚线，“
// Log-Normal Component 3”对应红色虚线，“Data”对应黑色空
// 心框。 结论：子图a表明等待时间分布可用两个对数正态分布
// 近似描述，分别对应快速重复事件（~39 ms）和慢速重复事件
// （~106.7 s）。子图b进一步揭示，慢速事件部分实际上可分
// 解为两个不同的对数正态过程（峰值分别在45.1 s和162.3 s），
// 暗示可能存在两种不同机制或状态主导的延迟行为。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf3.png", width: 100.0%),
    caption: [
      #strong[Waiting time distribution of FRB~20201124A.] #strong[(a)] The best fit using two log-normal functions (the blue curve), where the two log-normal distributions peak at 39 ms and 106.7 s. #strong[(b)] The best fit (blue curve) using three log-normal functions, which were indicated with the dashed-line curves, peak at 39 ms, 45.1 s, and 162.3 s.
    ]
  ) <fig:waitingtime>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf4.png
// 该图展示了九个不同射电暴（Burst）在单个爆发事件内部视
// 旋转量度（RM）的变化情况，整体布局为三行三列的网格结构。
// 每一列代表一个独立的子图组，分别对应不同的爆发编号：第
// 一列为 Burst 37、561、779；第二列为 Burst 377、598、1,
// 377；第三列为 Burst 460、725、1,398。每个子图组包含三
// 个垂直排列的子图，从上至下依次标记为 a、b、c，分别表示
// RM 随时间变化曲线、偏振轮廓图和动态频谱图。所有子图共
// 享相同的横轴：时间为毫秒（ms），范围从 -20 ms 到 +20
// ms，原点位于中心。 (a) 子图为散点误差棒图，纵轴为 RM，
// 单位为 rad/m²，各子图纵轴刻度根据数据调整。图中蓝色实
// 心圆点表示测量值，垂直蓝色线段表示 95% 置信水平的误差
// 棒。例如，在 Burst 37 中，RM 值分布在约 -660 至 -665
// rad/m² 之间，误差棒长度不一；Burst 561 中 RM 从约 -575
// 降至 -590 rad/m²；Burst 779 中 RM 在 -448 至 -452 rad/
// m² 区间波动并伴随较大误差棒。这些点显示 RM 在爆发持续
// 期间存在显著时变，部分案例呈现单调下降或上升趋势，部分
// 则无明确规律。 (b) 子图为归一化通量随时间变化的曲线图，
// 纵轴为“Normalized Flux”，无量纲，数值范围因爆发而异，
// 如 Burst 37 最大约 300，Burst 561 达 1,000。红色实线代
// 表总强度轮廓，黑色细线叠加其上可能表示拟合模型或去色散
// 后信号，蓝色虚线位于底部接近零值处，可能代表噪声基线或
// 未极化成分。所有爆发均呈现单峰或多峰结构，峰值集中在 t
// =0 ms 附近，宽度通常在几毫秒内。例如，Burst 377 呈双峰
// 结构，主峰在 t≈-5 ms，次峰在 t≈+5 ms；Burst 1,398 为尖
// 锐单峰，半高宽小于 2 ms。 (c) 子图为动态频谱图（
// spectrogram），纵轴为频率（GHz），范围固定为 1.0 GHz
// 至 1.4 GHz，横轴同前为时间（ms）。颜色映射采用热图形式：
// 深紫色代表低强度，绿色至黄色代表中等强度，亮白色代表最
// 高强度。图中可见多个水平条纹状结构，对应于特定频率通道
// 上的信号增强区域。左侧边缘有红色矩形块，标注了观测频带
// 覆盖范围（如 1.0–1.1 GHz、1.2–1.3 GHz 等），中间穿插白
// 色横线，可能指示干扰频段或被剔除的数据段。例如，Burst
// 37 在 1.3–1.4 GHz 区间出现两个分离的绿色斑块，分别位于
// t≈-10 ms 和 t≈+5 ms；Burst 598 在 1.2–1.3 GHz 区间呈现
// 连续斜向结构，表明频率随时间漂移；Burst 1,377 在 1.1–
// 1.2 GHz 区间有强信号集中区，形态不规则。比例尺未直接标
// 出，但可通过频率跨度与时间跨度推断分辨率约为 0.01 GHz
// × 0.5 ms。 综合来看，该图集通过多参数同步展示揭示了
// FRB 爆发内部 RM 的快速时变特性，且这种变化与偏振轮廓及
// 频谱结构相关联，暗示磁化介质环境在毫秒尺度上发生剧烈演
// 化。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf4.png", width: 100.0%),
    caption: [
      #strong[Apparent RM variation within individual bursts.] #strong[(a)] RM curve with 95"%" confidence level error bars, #strong[(b)] polarisation profiles, and #strong[(c)] dynamic spectra. Bursts are dedispersed using corresponding structure-optimised DM values.
    ]
  ) <fig:burstrm>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf5.png
// 该图像包含两个子图，分别标记为 a 和 b，展示了与旋转测
// 量（RM）指数相关的统计分析结果。 子图 a 类型：直方图
// 坐标轴： 横轴：名称为“Normalised deviation of rotation
// measure index”（归一化旋转测量指数偏差），范围从 -5 到
// +5，刻度间隔为 1（标有 -4, -2, 0, 2, 4）。 纵轴：名称
// 为“Count”（计数/频数），范围从 0 到 175，刻度间隔为 25
// （标有 0, 25, 50, 75, 100, 125, 150, 175）。 图形元素：
// 主数据：由黑色实线勾勒出的阶梯状直方图。分布呈现单峰形
// 态，峰值位于横坐标约 -0.5 处，对应的纵坐标数值约为 173。
// 在横坐标 0 附近，曲线出现明显的断崖式下降。 辅助线：图
// 中有三条垂直虚线，用于标示标准差范围。 蓝色虚线：位于
// 横坐标约 -1.0 和 +1.0 处。 橙色虚线：位于横坐标约 -2.0
// 和 +2.0 处。 绿色虚线：位于横坐标约 -3.0 和 +3.0 处。
// 标注文字： 左上角图例包含三行文字： “1-sigma, 631
// bursts”（对应蓝色虚线） “2-sigma, 916 bursts”（对应橙
// 色虚线） “3-sigma, 1006 bursts”（对应绿色虚线） 趋势与
// 结论： 该图展示了归一化旋转测量指数偏差的统计分布。大
// 部分数据集中在 0 附近，且随着偏差绝对值的增加，样本数
// 量逐渐减少。三条虚线界定了不同置信水平下的爆发事件（
// bursts）数量，表明绝大多数观测值落在 3 倍标准差范围内。
// 子图 b 类型：散点图 坐标轴： 横轴：名称为“MJD”（
// Modified Julian Date，修正儒略日），代表时间。范围从
// 59310 到 59360，刻度间隔为 10（标有 59310, 59320,
// 59330, 59340, 59350, 59360）。 纵轴：名称为“RM (rad m^
// -2)”（旋转测量，单位 rad/m²），范围从 -900 到 -400，刻
// 度间隔为 100（标有 -900, -800, -700, -600, -500, -400）。
// 图形元素： 橙色圆点：代表被选中的爆发事件（Selected
// bursts），这些点的 RM 误差较小（小于 3 倍标准差）。 蓝
// 色菱形点：代表未被选中的测量值（Not selected），这些点
// 的 RM 误差较大。 标注文字： 左上角图例包含两行： 一个
// 橙色圆点符号，后跟文字“Selected”。 一个蓝色菱形符号，
// 后跟文字"Not selected"。 趋势与结论： 该图显示了 RM 随
// 时间的变化关系。整体趋势显示 RM 值在 -400 到 -700 之间
// 波动。 在 MJD 59320 至 59330 期间，RM 值较高，接近
// -400 至 -500。 在 MJD 59330 至 59340 期间，出现显著的
// 剧烈波动，部分数据点急剧下降至 -800 甚至 -900 以下。
// 在 MJD 59340 之后，RM 值趋于稳定，维持在 -600 左右。
// 橙色点（高置信度数据）在大部分时间段内主导了数据的趋势，
// 而蓝色点（低置信度数据）较为稀疏，主要分布在波动剧烈的
// 区域或作为补充数据存在。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf5.png", width: 100%),
    caption: [
      #strong[Rotation measure index.] #strong[(a)] Histogram of normalised rotation measure index deviation defined as $\( beta - 2 \) \/ sigma_beta$, where $sigma_beta$ is the uncertainty of $beta$ with 68"%" confidence level. #strong[(b)] RM as a function of time. Orange dots are for selected bursts with $\( beta - 2 \) \/ sigma_beta lt.eq 1$, and the measurements not selected are in blue dots.
    ]
  ) <fig:RMindex>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf6.png
// 子图 a 为三幅并列的显微照片，展示宿主星系在不同波段及
// 残差图像中的形态。左图为 i-band（i 波段）光学图像，呈
// 灰度显示，中心区域过曝发白，外围有弥散光晕；图中叠加一
// 个青色空心圆圈和一个黄色五角星标记特定位置。中图为
// K'-band（K' 波段）近红外图像，同样灰度，整体更平滑，亮
// 度分布较集中，保留相同位置的青色圆圈与黄色五角星；左下
// 角标注比例尺“0.58''”及对应物理尺度“1kpc@z=0.098”，右下
// 角有方向指示箭头：向上为北（N），向左为东（E）。右图为
// Residual（残差）图像，显示扣除模型后的剩余结构，中心呈
// 垂直亮带，两侧暗区对称，青色圆圈与黄色五角星仍位于相同
// 相对位置。三幅图下方分别标注“i-band”、“K'-band”、“
// Residual”。 子图 b 为曲线图，横轴为速度 v (km/s)，范围
// 从 -400 到 +400 km/s，纵轴未标数值但代表流量强度。图中
// 包含两条曲线：红色实线与蓝色实线，两者几乎重合，在 v =
// 0 附近形成单峰，峰值处有一条浅青色虚线垂直穿过，标注为
// “Hα”，表示氢-alpha 发射线中心波长对应的速度零点。曲线
// 在 ±200 km/s 以外趋于平坦基线，表明谱线宽度约 300–400
// km/s。该图传达宿主星系气体在 Hα 波段的速度分布特征，以
// 静止系为中心对称展宽。 子图 c 为二维空间-波长分布示意
// 图，横轴为 Wavelength direction（波长方向），纵轴为
// Spatial direction（空间方向），图像为灰度热图形式，显
// 示沿空间切片的谱线轮廓变化。图中用三个矩形框标出不同空
// 间区域：上方青色框标记 A，中间红色框标记 B，下方蓝色框
// 标记 C，三者垂直堆叠覆盖同一波长区间但不同空间位置。此
// 图用于提取后续子图 d 中三条光谱曲线所对应的空间切片。
// 子图 d 为归一化光谱曲线图，横轴为 Wavelength (Å)，范围
// 从 7,195 Å 到 7,215 Å，纵轴为 Scaled flux（归一化流量），
// 范围 0.0 到 1.0。图中三条曲线分别对应子图 c 中标记的空
// 间区域：青色实线带叉号标记为 A，红色实线带加号标记为 B，
// 蓝色实线带乘号标记为 C。三条曲线均为钟形发射线轮廓，峰
// 值均位于约 7,205 Å 附近，但半高全宽略有差异：A 最窄，C
// 最宽，B 居中。图例位于右上角，明确标注颜色与符号对应关
// 系。该图显示不同空间位置的气体发射线轮廓存在轻微展宽差
// 异，暗示动力学结构随空间位置变化。 子图 e 为旋转曲线图，
// 横轴为 r⊥ (kpc)，即垂直于视线方向的半径，范围从 -4 kpc
// 到 +4 kpc；纵轴为 v (km/s)，即旋转速度，范围从 -60 到
// +100 km/s。图中数据点为灰色实心圆点，带垂直误差棒，共
// 10 个点，分布在左右两侧。一条红色折线拟合这些数据点：
// 在 r⊥ < -2 kpc 时速度恒定为 +60 km/s，在 r⊥ > +2 kpc
// 时速度恒定为 -50 km/s，中间线性过渡段斜率约为 -55 km/s
// /kpc。在 r⊥ = -3 kpc 处另有一个独立数据点，速度约 +90
// km/s，误差较大。图中还有一条黑色水平线段标注“0.7''”，
// 表示角分辨率或束宽尺度。该图揭示宿主星系具有明显的旋转
// 运动，内侧高速旋转，外侧趋于恒定速度平台，符合盘状星系
// 动力学特征。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf6.png", width: 100.0%),
    caption: [
      #strong[Properties of the host galaxy at $z = 0.098$ in the optical and near-infrared.] #strong[\(a)] $i$-band and $K'$-band FRB~20201124A host-galaxy images by LRIS and NIRC2, respectively, and the residual $K'$-band image after subtracting the disc component. The EVN localisation of FRB~20201124A is indicated with the cyan circle, which is in 60 mas radius, i.e. 4 times the uncertainty. The centre of the background galaxy ($z = 0.553$) is shown as the yellow asterisk. #strong[\(b)] The H$alpha$ double-peaked profile revealed in the medium-resolution ESI spectrum. Blue and red are for two different orders of the echelle spectrum. #strong[\(c)] 2D spectroscopic image by LRIS around the H$alpha$ emission line. A wavelength-dependent variation is clearly seen in the spatial direction. #strong[\(d)] The H$alpha$ lines extracted from three different regions, which correspond to the three rectangles in panel #strong[\(c)] of the galaxy along the slit. #strong[\(e)] The velocities at different projected distances in the slit direction relative to the continuum centre. The red line is the best-fit result of a simple rotation model The LRIS spectroscopic observations were taken with seeing of $0.7''$ (black bar), which sets the spatial resolution.
    ]
  ) <fig:opticalobs01>
  #v(1fr)
]



#page(margin: (x: 1in, y: 1in), paper: "us-letter", numbering: "1")[
  #v(1fr)
// [figvision-cn] imgs/EDf7.png
// 图a为散点图，横轴表示log([NII]λ6583/Hα)，范围从-2.0到
// 0.5；纵轴表示log([OIII]λ5007/Hβ)，范围从-1.0到1.5。背
// 景由大量灰色像素点构成密度分布，深色区域代表高恒星形成
// 星系聚集区，标注“Star-forming”位于左下方低电离度区域，
// 右上角高密度区标注“AGN”。图中绘制两条黑色实线与虚线分
// 隔星暴与活动星系核区域。六个带误差棒的彩色数据点代表不
// 同FRB宿主星系：青色实心圆点（FRB 20180916B, galaxy
// J0158+65）位于(-0.4, 0.2)附近；青色空心方块（FRB
// 20180916A local）在(-0.3, -0.5)；紫色带十字标记的圆圈
// （FRB 20121102A host galaxy）在(-1.4, 0.7)；蓝色实心方
// 块（FRB 20180301A host galaxy）在(-0.4, 0.1)；红色实心
// 圆点（FRB 20201124A host galaxy, z=0.098）在(-0.3,
// -0.4)；黄色带十字标记的圆圈（FRB 20201124A background
// galaxy, z=0.553）在(-0.2, 0.7)。所有点均带有水平和垂直
// 误差棒。该子图显示多数FRB宿主位于恒星形成区，部分接近
// AGN边界，表明其金属丰度与电离状态介于典型星暴与AGN之间。
// 图b包含三个堆叠的子图，共享同一横轴：“Host Stellar
// Mass (M☉)”，对数刻度，范围从10⁸到10¹¹ M☉。最上方子图纵
// 轴为“Offset/Rₑ”，对数刻度，范围10⁻¹到10²，表示FRB相对
// 于宿主星系有效半径的偏移量；中间子图纵轴为“12+log(O/H)
// ”，线性刻度，范围8.0到9.0，表示氧丰度；最下方子图纵轴
// 为“sSFR (yr⁻¹)”，对数刻度，范围10⁻¹³到10⁻⁹ yr⁻¹，表示
// 比恒星形成率。每个子图中均有三类数据点：红色空心圆点代
// 表重复爆发源宿主星系，黑色实心圆点代表非重复源宿主星系，
// 红色五角星代表FRB 20201124A宿主星系。所有点均带误差棒。
// 趋势显示：随着宿主星系质量增加，sSFR普遍下降（符合质量
// -比SFR关系），氧丰度随质量略有上升但无显著相关性，偏移
// 量分布广泛，无明显质量依赖。FRB 20201124A宿主（红五星）
// 质量为~3×10¹⁰ M☉，sSFR ~10⁻¹⁰ yr⁻¹，氧丰度~9.0，偏移量
// ~1 Rₑ，处于中等质量、低比SFR、正常金属丰度区间。 图c为
// 光谱图，横轴为波长（Å），分为两段：左侧7500–7800 Å，右
// 侧10100–10200 Å，中间有断裂符号。纵轴为流量fλ（单位10⁻
// ¹⁵ erg/s/cm²/Å），范围0.0到1.0。图中两条曲线：蓝色实线
// 为LRIS仪器观测数据，红色实线为ESI仪器观测数据（已加常
// 数偏移以便对比）。绿色阴影区域覆盖约7600–7700 Å，内含
// 一个绿色带十字标记的圆圈，标注“z=0.553 lines”，指示背
// 景星系红移特征。谱线标注包括：Hβ（~7600 Å）、[OIII]λ
// 4959（~7700 Å）、[OIII]λ5007（~7800 Å）、Hα（~10200 Å）。
// 红色曲线在[OIII]λ5007处出现强发射峰，蓝色曲线对应位置
// 也有较弱信号。该子图展示FRB 20201124A背景星系（z=0.553）
// 的光谱特征，确认其红移并识别关键发射线，支持其为高红移
// 背景源而非宿主本身。
  #figure(kind: "edfig", supplement: [Extended Data Figure], image("imgs/EDf7.png", width: 100.0%),
    caption: [
      #strong[Properties of the galaxies and comparisons with other FRB hosts] #strong[\(a)] FRB repeaters' hosts in the BPT diagram plotted with the SDSS DR8 MPA-JHU sample (black); parameter spaces of galaxies dominated by star formation and active galactic nuclei are separated by the black dashed and solid lines, respectively@Kewley2001 @Kauffmann2003. The host and background galaxies of FRB 2020124A are shown in red and yellow, respectively. #strong[\(b)] The properties (FRB--galaxy offset in units of galaxy effective radius $R_e$, gas-phase metallicity, sSFR, and stellar mass) of the FRB~20201124A host galaxy (red star) compared with a literature sample of FRB hosts (available at #link("https://web.archive.org/web/20211015143528/https://frbhosts.org/#explore")) shown with dots (black, non-repeaters; red, repeaters). #strong[\(c)] Emission lines from the background galaxy at $z = 0.553$ in the LRIS (blue) and ESI (red) spectra with regions contaminated by Earth's atmosphere marked in green.
    ]
  ) <fig:opticalobs02>
  #v(1fr)
]










#bibliography("refs.bib", style: "nature.csl", title: [References])
