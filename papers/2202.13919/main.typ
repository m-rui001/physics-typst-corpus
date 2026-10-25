#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10.1pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.00cm, right: 1.94cm, top: 2.28cm, bottom: 2.14cm), columns: 2)
#set heading(numbering: none)
#set figure(placement: auto)
#set par(justify: true, spacing: 0.73em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.53em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9pt)

#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
 let e = it.element
 if e != none and e.func() == math.equation {
 [Eq. (#context counter(math.equation).at(e.location()).first())]
 } else { it }
}
#set figure(placement: auto)
#show figure.caption: set align(left)

#place(top + center, scope: "parent", float: true)[
  #align(center)[
   #text(19.9pt, weight: "bold", [New physics from the polarised light of the cosmic microwave background])
   #v(1em)
   #text(11pt)[Eiichiro Komatsu]
   #v(0.4em)
   #text(9pt)[#super[1,2] Max-Planck-Institut für Astrophysik, Karl-Schwarzschild Str. 1, 85741 Garching, Germany]
   #linebreak()
   #text(9pt)[#super[2] Kavli Institute for the Physics and Mathematics of the Universe (Kavli IPMU, WPI), University of Tokyo, Chiba 277-8582, Japan]
   #linebreak()
   #text(9pt)[e-mail: komatsu\@mpa-garching.mpg.de]
  ]
  #v(0.5em)

  #align(center)[
   #block(width: 100%)[#text(9.5pt)[
// abshead
#align(left)[#set par(first-line-indent: 0em)
#text(12pt, weight: "bold")[ABSTRACT]]

   Cosmology requires new physics beyond the Standard Model of elementary particles and fields. What is the fundamental physics behind dark matter and dark energy? What generated the initial fluctuations in the early Universe? Polarised light of the cosmic microwave background (CMB) may hold the key to answers. In this article, we discuss two new developments in this research area. First, if the physics behind dark matter and dark energy violates parity symmetry, their coupling to photons rotates the plane of linear polarisation as the CMB photons travel more than 13 billion years. This effect is known as "cosmic birefringence": space filled with dark matter and dark energy behaves as if it were a birefringent material, like a crystal. A tantalising hint for such a signal has been found with the statistical significance of $3 sigma$. Next, the period of accelerated expansion in the very early Universe, called "cosmic inflation", produced a stochastic background of primordial gravitational waves (GW). What generated GW? The leading idea is vacuum fluctuations in spacetime, but matter fields could also produce a significant amplitude of primordial GW. Finding its origin using CMB polarisation opens a new window into the physics behind inflation. These new scientific targets may influence how data from future CMB experiments are collected, calibrated, and analysed.
   ]]
  ]
]
  #v(1em)








  The standard cosmological model, called $Lambda$CDM, demands new physics beyond the Standard Model (SM) of elementary particles and fields@weinberg:2008. '$Lambda$' denotes Einstein's cosmological constant, which is the simplest (but most difficult to understand@weinberg:1989 @martin:2012) candidate of dark energy responsible for the accelerated expansion of the Universe@SupernovaSearchTeam:1998 @SupernovaCosmologyProject:1999 'CDM' stands for cold dark matter, which accounts for 80% of the matter density in the Universe@peebles:2020. The existence of dark matter and dark energy, as well as their mysterious and elusive nature, are well known to the public.


  Yet, the most extraordinary ingredient of the model is perhaps not as well known. This ingredient, which is not contained in the name of $Lambda$CDM, is the idea that the origin of all structures in the Universe, such as galaxies, stars, planets and life, was the quantum-mechanical vacuum fluctuation generated in the early Universe@mukhanov-chibisov:1981@hawking:1982 @starobinsky:1982@guth-pi:1982@bardeen-turner-steinhardt:1983. The observed properties of cosmic structures, most notably those of the afterglow of the fireball Universe called the cosmic microwave background (CMB), agree with this idea@komatsu-etal:2014@Planck2018X.


  What is the physical nature of dark matter and dark energy? What generated the initial quantum vacuum fluctuation and how? #emph[Polarised] light of the CMB may help answer these questions. Their importance is widely recognised, and there are beautiful measurements of CMB polarisation from two space missions, the National Aeronautics and Space Administration (NASA) #emph[Wilkinson Microwave Anisotropy Probe] (#emph[WMAP])@WMAP:2013a and the European Space Agency (ESA) #emph[Planck]@Planck2018I, as well as from a host of ground-based@adachi-etal:2020@adachi-etal:2020b@aiola-etal:2020@sayre-etal:2020@dutcher-:2021@BICEP:2021 and balloon-borne@SPIDER:2022 experiments. The rate at which the sensitivity of CMB experiments has improved over the last 2 decades is staggering: the noise level has dropped by 3 orders of magnitude, nearly exponentially with time. If it were not for the CMB research, such a dramatic improvement and innovation in microwave sensor technology would not have been made.


  There will be ever more powerful CMB polarisation experiments in the coming decade, including ground-based observatories such as Simons Observatory@SimonsObservatory:2019, South Pole Observatory@SPO:2020 and CMB Stage-4@CMB-S4:2019, and a space mission #emph[LiteBIRD]@LiteBIRD:2022 led by the Japan Aerospace Exploration Agency (JAXA). These experiments will reduce the noise level by another order of magnitude. We are now at the stage where not only the statistical uncertainty but also the systematic uncertainty (including both instrumental and astrophysical ones) must be controlled with unprecedented precision. What kind of systematics should we characterise better and how well depends on what kind of new physics we wish to discover from such observations.


  In this article, we focus on two new developments in the quest for new physics. First, CMB polarisation is sensitive to physics violating parity symmetry under inversion of spatial coordinates@lue-wang-kamionkowski:1999. We discuss a tantalising hint for such a signal, called 'cosmic birefringence'@carroll-field-jackiw:1990@carroll-field:1991@harari-sikivie:1992, in the polarisation data obtained by #emph[Planck]@minami-komatsu:2020b@NPIPE:2022 @eskilt:prep. The statistical significance is currently about 3$sigma$. If confirmed with higher significance in future, it would have profound implications for the fundamental physics behind dark energy@carroll:1998@panda-sumitomo-trivedi:2011 and dark matter@finelli-galaverni:2009@fedderke-graham-rajendran:2019, as well as for theory of quantum gravity@myers-pospelov:2003@arvanitaki-etal:2010.


  Second, the quantum-mechanical vacuum fluctuation generated in the early Universe could produce a stochastic background of primordial gravitational waves (GW)@grishchuk:1975 @starobinsky:1979, and CMB polarisation is sensitive to them@seljak-zaldarriaga:1997@kamionkowski-etal:1997b. We discuss recent new developments in the study of GW sourced by matter fields in the early Universe. Statistical properties of such a sourced GW are dramatically different from those of the quantum vacuum fluctuation in spacetime (i.e., tensor metric perturbation) that has usually been considered in the CMB research@kamionkowski-kovetz:2016.


  These two developments may as well require new designs and calibration strategy for future CMB experiments, and influence the way polarisation data are analysed. We conclude this article by giving an outlook in this regard.


= Polarisation of the CMB
<polarisation-of-the-cmb>


Space is filled with nearly uniform sea of CMB photons from the fireball Universe@peebles-page-partridge:2009. When the temperature was greater than 3,000~K in the past, all atoms were fully ionised and photons were scattered by electrons efficiently: the plasma was opaque to photons. When the temperature fell below 3,000~K, protons, helium nuclei and electrons were combined to form neutral atoms, which did not scatter photons very much. This marks the moment of 'last scattering', after which most of the photons propagated freely 13--14 billion years to reach us today.


As the photons propagated through expanding space, their wavelength was stretched and the photons lost energy continuously to expansion. The energy spectrum of photons remained a thermal Planck spectrum (which was established by interaction of matter and radiation in the fireball phase@sunyaev-zeldovich:1970@danese-dezotti:1982) with temperature dropping as space expanded. The present-day temperature averaged over the full sky is $T_0 = 2.725$~K@fixsen:2009, and the spectrum has a peak in microwave bands, hence the name 'cosmic microwave background'.


The initial fluctuations generated in the early Universe left imprints in the distribution of CMB intensity observed in different directions on the sky. As the spectrum of CMB intensity is a Planck spectrum, the results of CMB experiments are reported in units of thermodynamic temperature, rather than in units of intensity. The temperature fluctuation observed in a direction $hat(n)$ is defined by removing the sky-averaged temperature, $Delta T ( hat(n) ) = T ( hat(n) ) - T_0$. A typical magnitude of the fluctuation is $Delta T T_0$ of order $10^(- 5)$. By measuring the distribution of CMB photons arriving from various directions over the sky, we can map $Delta T$ at the 'surface of last scattering' far, far away from us.


The CMB photons are linearly polarised at the surface of last scattering@kosowsky:1996 Linear polarisation is generated when #emph[anisotropic] incident light is scattered/reflected. The sunlight reflected upon the windshield of a car is polarised because the sunlight arrives from the sky. A rainbow is polarised when the sunlight is scattered by water droplets in the atmosphere into a particular direction. How about the Universe? The Universe is isotropic with no preferred direction, but the angular distribution of intensity of light coming to an electron can be #emph[locally] anisotropic. Linear polarisation is generated when this anisotropic incident light is last scattered by electrons@hu-white:1997.


In @fig:planck, we show a high signal-to-noise map of CMB polarisation observed by the #emph[Planck] mission@Planck2018I overlaid on a map of $Delta T$. In this article, we describe how such a polarisation map can tell us about new physics.


// vision: This is a full-field 2D color map covering a 10°×10° region centered at Galactic coordinates (276.4°, −29.8°), smoothed at 20 arcminutes. A horizontal colorbar at the bottom runs from −201 µK (blue) to 309 µK (dark red), passing through cyan, white, yellow, and orange; a separate 13.7 µK marker sits at lower left. Short black line segments are overlaid across the entire map, encoding local direction. Blue patches indicate negative temperature excursions and red/orange patches positive excursions, with no panels, curves, legend, or additional annotations beyond the title, coordinate label, and scale labels.
// [figvision-cn] imgs/fig1.png
// 这是一张展示宇宙微波背景（CMB）观测数据的复合图，包含
// 温度涨落和偏振信息。 图像类型：天空区域的数据可视化图
// （包含颜色映射的温度图和叠加的矢量场）。 整体布局与尺
// 寸： 该图为一个正方形区域，顶部文字标注显示其覆盖的天
// 空范围为10度乘以10度（10°x10°），数据经过了20角分（20'）
// 的高斯平滑处理。底部中央的文字标注指出了该区域的银河系
// 坐标中心位置为（经度 276.4，纬度 -29.8）。 颜色映射（
// 温度分布）： 图像背景展示了温度的空间分布，通过颜色梯
// 度表示相对于平均值的温度涨落。底部设有一个水平颜色条（
// Colorbar）作为图例： 颜色范围从深蓝色过渡到浅蓝、白色、
// 橙色，最后到深红色。 对应的数值范围是从左侧的-201微开
// 尔文（μK）到右侧的309微开尔文（μK）。 具体含义：深蓝色
// 代表比平均值低201 μK的低温区域；深红色代表比平均值高
// 309 μK的高温区域；白色或浅色区域代表接近平均温度的区域。
// 图中可见不规则的斑块状结构，例如左上角有明显的蓝色低温
// 区，而中部和右下角则散布着橙红色的较高温区。 黑色线条
// （偏振分布）： 在彩色背景之上，均匀覆盖着大量黑色的短
// 线段。这些线段代表了光线的线性偏振状态： 方向：每条线
// 段的朝向指示了该点处偏振的方向。观察可见，这些线段倾向
// 于沿着温度等值线的切线方向排列，或者在冷热交界处呈现特
// 定的几何构型（如围绕冷斑点的环状或发散状排列）。 长度：
// 线段的长度指示了偏振的强度。虽然图中未直接给出长度比例
// 尺，但左下角提供了一个垂直的黑色参考线段，旁边标注数值
// “13.7 μK”，这代表了偏振振幅的量级标准。 总结结论： 该
// 图直观地展示了宇宙微波背景辐射在特定天区的精细结构，其
// 中颜色揭示了早期宇宙密度的微小起伏（温度涨落），而叠加
// 的黑线则描绘了光子散射产生的偏振模式，两者共同反映了宇
// 宙早期的物理过程。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

#figure(placement: auto, image("imgs/fig1.png", width: 100%),
 caption: [
 #strong[Observed CMB polarisation.] This map shows temperature fluctuations $Delta T$ (colour) and polarisation (lines) on a $10^compose times 10^compose$ patch of sky, extracted from the full-sky map of the #emph[Planck] mission. Lengths and orientations of the lines indicate polarisation strengths and directions, respectively. The figure is reproduced from Ref.@Planck2018I
 ]
)
<fig:planck>


== $E$- and $B$-mode polarisation and parity
<e--and-b-mode-polarisation-and-parity>


To probe violation of parity symmetry, we decompose the observed pattern of CMB polarisation into eigenstates of parity, called $E$ and $B$ modes@zaldarriaga-seljak:1997@kamionkowski-etal:1997, which transform differently under inversion of spatial coordinates. Let us first consider a small patch of sky (@fig:planck) around a given line of sight.


We use Stokes parameters to characterise the polarisation field. In right-handed coordinates with the $z$ axis taken in the propagation direction of photons, Stokes parameters for linear polarisation are $Q = \| E_x \|^2 - \| E_y \|^2 = 2 Re ( E_(+)^(*) E_(-) )$ and $U = 2 Re ( E_x^(*) E_y ) = 2 Im ( E_(+)^(*) E_(-) )$, where $E_x$ and $E_y$ are components of an electric field $bold(E)$ in Cartesian coordinates and $E_plus.minus = ( E_x minus.plus i E_y )/sqrt(2)$ are those of $plus.minus$ helicity states. Right- and left-handed circular polarisation states correspond to $+$ and $-$, respectively.


With an amplitude ($P$) and a position angle (PA) of linear polarisation defined as $Q plus.minus i U = P e^(plus.minus 2 i psi)$, $psi > 0$ is a counter-clockwise rotation of the plane of polarisation on the sky. This is the definition of PA adopted by the International Astronomical Union (IAU)@hamaker-bregman:1996. On the other hand, the CMB community often uses right-handed coordinates with the $z$ axis taken in the direction of observer's lines of sight. This results in the opposite sign convention for $U$ and PA@angle:2017.


We adopt the CMB convention for the rest of this article and use the notation $beta = - psi$ for PA, as this is what has been reported in the literature. In this notation $beta > 0$ is a #emph[clockwise] rotation on the sky, and $Q plus.minus i U = P e^(plus.minus 2 i beta) = P e^(minus.plus 2 i psi) = Q_("IAU") minus.plus i U_("IAU")$. The Stokes parameter for circular polarisation, $V = 2 Im ( E_x^(*) E_y ) = \| E_(+) \|^2 - \| E_(-) \|^2$, is not affected by this difference.


Without loss of generality, we choose the centre of the sky patch to be at the pole of spherical coordinates ($theta = 0$). We define $E$ and $B$ modes by writing Fourier transform of Stokes parameters observed at a 2-dimensional position vector, $bold(theta) = ( theta cos phi.alt , theta sin phi.alt )$, as

$ Q ( bold(theta) ) plus.minus i U ( bold(theta) ) = integral frac(d^2 bold(ell), ( 2 pi )^2) (E_(bold(ell)) plus.minus i B_(bold(ell))) e^(plus.minus 2 i phi.alt_(bold(ell)) + i bold(ell) dot.op bold(theta)) thin , $<eq:EB>

where $bold(ell) = ( ell cos phi.alt_(bold(ell)) , ell sin phi.alt_(bold(ell)) )$. Here, $E_(bold(ell))$ and $B_(bold(ell))$ are Fourier coefficients of $E$ and $B$ modes, respectively. For a single plane wave, $E_(bold(ell))$ produces polarisation directions that are parallel or perpendicular to $bold(ell)$, and $B_(bold(ell))$ produces those tilted by $plus.minus 45^compose$. By construction $E_(bold(ell))$ has even parity, whereas $B_(bold(ell))$ has odd parity.


We acknowledge the abuse of notation: $E$- and $B$-mode polarisation coefficients, $E_(bold(ell))$ and $B_(bold(ell))$, must not be confused with electric and magnetic field vectors, $bold(E)$ and $bold(B)$! In fact, $bold(E)$ is a vector with odd parity, and $bold(B)$ is a pseudovector with even parity.


Fourier transform given in @eq:EB is valid only on a small patch of sky. To deal with full-sky data on a sphere, we use spherical harmonics. We expand Stokes parameters observed in a direction $hat(n) = ( sin theta cos phi.alt , sin theta sin phi.alt , cos theta )$ on the sky as

$ Q ( hat(n) ) plus.minus i U ( hat(n) ) = - sum_(ell = 2)^oo sum_(m = - ell)^ell (E_(ell m) plus.minus i B_(ell m)) zws_(plus.minus 2) Y_ell^m ( hat(n) ) thin , $<eq:EBfullsky>

where $zws_(plus.minus 2) Y_ell^m ( hat(n) )$ is the spin-2 spherical harmonics@zaldarriaga-seljak:1997@kamionkowski-etal:1997, and $E_(ell m)$ and $B_(ell m)$ are spherical harmonics coefficients of $E$ and $B$ modes, respectively. This is the full-sky generalisation of @eq:EB and is used for analysing polarisation data of all experiments. Under $hat(n) arrow.r - hat(n)$, the coefficients transform as $E_(ell m) arrow.r ( - 1 )^ell E_(ell m)$ and $B_(ell m) arrow.r ( - 1 )^(ell + 1) B_(ell m)$\; thus, they have the opposite parity, as promised. In the limit of small angles (large $ell$), $ell$ is equal to $\| bold(ell) \|$, and $m$ describes how the Fourier coefficients depend on $phi.alt_(bold(ell))$.


A useful quantity for describing stochastic variables such as $E_(ell m)$ and $B_(ell m)$ is the angular power spectrum $C_ell$, which is the squared amplitude of spherical harmonics coefficients. Assuming that the Universe is statistically isotropic with no preferred direction, we average the squared coefficients over $m$ to obtain $ C_ell^(E E) & = frac(1, 2 ell + 1) sum_(m = - ell)^ell \| E_(ell m) \|^2 thin \,\
C_ell^(B B) & = frac(1, 2 ell + 1) sum_(m = - ell)^ell \| B_(ell m) \|^2 thin. $ Both of these are parity even. See @fig:cl for the current measurements of $C_ell^(E E)$ and $C_ell^(B B)$. Though not shown, the parity-even cross-correlation of temperature and polarisation, $C_ell^(T E)$, has also been measured precisely.


The parity-odd power spectra (not shown in @fig:cl) are given by $ C_ell^(E B) & = frac(1, 2 ell + 1) sum_(m = - ell)^ell Re (E_(ell m) B_(ell m)^(*)) thin \,\
C_ell^(T B) & = frac(1, 2 ell + 1) sum_(m = - ell)^ell Re (T_(ell m) B_(ell m)^(*)) thin , $ and can be used to probe new physics that violates parity symmetry@lue-wang-kamionkowski:1999. While $C_ell^(T B)$ used to be the most sensitive probe of parity violation in the #emph[WMAP] era@WMAP:2009 @WMAP:2011, $C_ell^(E B)$ has become the most sensitive one in the current era of CMB experiments with low polarisation noise.


// vision: This is a log-log power-spectrum plot of ℓ(ℓ+1)Cℓ/2π [μK²] versus multipole ℓ from 2 to 2000. Grey curves show the ΛCDM E-mode spectrum; a green curve shows the B-mode spectrum for r = 0.03; a light-grey curve shows the lensed B mode. Data series are Planck (blue circles), Polarbear (green circles), SPTpol (yellow circles), ACTPol (orange circles), and BICEP/Keck Array (magenta circles), with shaded error bands. Planck and ACTPol trace the E-mode rise to about 30 μK² near ℓ ≈ 1000-2000. BICEP/Keck points span ℓ ≈ 40-300 at roughly 0.002-0.03 μK²; SPTpol spans ℓ ≈ 200-2000 near 0.03-0.1 μK².
// [figvision-cn] imgs/fig2.png
// 这是一张对数-对数坐标的曲线图，展示了宇宙微波背景辐射
// （CMB）偏振功率谱的观测数据与理论模型的对比。 横轴标题
// 为“Multipole, ℓ”，代表多极矩，采用对数标度，范围从2延
// 伸至约3000，主刻度标记为2、10、30、80、200、500、1000
// 和2000。纵轴标题为“Power Spectrum, ℓ(ℓ+1)Cl/2π [μK²]”，
// 代表功率谱密度，单位是微开尔文平方（μK²），同样采用对
// 数标度，范围从0.0003至30，主刻度标记为0.0003、0.003、
// 0.03、0.3、3和30。 图的左上角包含一个图例框，定义了图
// 中的线条和符号： 灰色实线：代表ΛCDM模型下的E模式理论预
// 测曲线（E mode (ΛCDM)）。 绿色实线：代表张量比r=0.03时
// 的B模式理论预测曲线（B mode (r = 0.03)）。 浅蓝色实心
// 圆点：代表Planck实验的数据点。 深绿色实心圆点：代表
// Polarbear实验的数据点。 黄色实心圆点：代表SPTpol实验的
// 数据点。 红色实心圆点：代表ACTPol实验的数据点。 品红色
// 实心圆点：代表BICEP/Keck Array实验的数据点。 图中主要
// 包含以下几组数据特征： 一条细长的灰色实线贯穿全图，这
// 是E模式的理论曲线。该曲线在低ℓ值（约2到10）处数值约为
// 0.03，随后下降至ℓ=10附近的极小值（低于0.003），接着急
// 剧上升，在ℓ=200附近达到峰值（约1），之后在ℓ=1000左右出
// 现震荡并维持在高位，最后在高ℓ区域开始下降。 一条较粗的
// 绿色实线位于图表底部，代表B模式理论曲线。该曲线在ℓ=2到
// 10之间缓慢下降，在ℓ=10附近达到最低点（低于0.0003），随
// 后上升至ℓ=80左右的峰值（约0.002），之后迅速衰减，在ℓ=
// 500后几乎不可见。 图中分布着不同颜色的离散数据点及其误
// 差棒，这些数据点均带有垂直的黑色误差棒，部分还伴有同色
// 半透明填充带表示置信区间。 浅蓝色的Planck数据点分布在
// 两个区域：左侧低ℓ区域（ℓ约等于4到10），数值在0.002到
// 0.03之间；右侧高ℓ区域（ℓ约等于200到300），数值在1到3之
// 间，这些点紧贴着灰色理论曲线的上升趋势。 品红色的BICEP
// /Keck Array数据点集中在ℓ=50到200之间，数值从0.002上升
// 至0.03，被粉色阴影带包围，显示出随ℓ增加而增大的趋势。
// 黄色的SPTpol数据点位于ℓ=200到2000之间，数值在0.03到0.1
// 之间，被黄色阴影带包围，整体呈现先升后降的趋势，并在高
// ℓ处波动。 红色和深绿色的数据点（ACTPol和Polarbear）密
// 集地聚集在图表右上方的ℓ=300到2000区域，数值在1到30之间，
// 它们紧密重叠在一起，跟随灰色理论曲线的高位震荡形态。
// 总体趋势表明，不同实验观测到的数据点（特别是高ℓ区域的
// 红、绿、蓝点和中ℓ区域的黄、粉点）与灰色的E模式理论预测
// 曲线高度吻合，而绿色的B模式理论曲线则远低于大部分观测
// 数据的数值水平。
#figure(scope: "parent", placement: auto, image("imgs/fig2.png", width: 100%),
 caption: [
 #strong[Observed CMB polarisation power spectra.] We show $ell ( ell + 1 ) C_ell^(E E) 2 pi$ and $ell ( ell + 1 ) C_ell^(BB) 2 pi$ in units of $mu "K"^2$ from the current generation of CMB experiments: #emph[Planck]@Planck2018I, Polarbear@adachi-etal:2020b, South Pole Telescope (SPTpol)@sayre-etal:2020@dutcher-:2021, Atacama Cosmology Telescope (ACTPol)@choi-etal:2020, and BICEP/Keck Array@BICEP:2021. The data points are averaged over multipoles in bins centered at $ell$ shown by the filled circles. The error bars and bands indicate the 68% confidence level (C.L.) intervals. The best-fitting $Lambda$CDM models@Planck2018VI for the $E$-mode and lensed $B$-mode power spectra are also shown, together with the $B$-mode power spectrum of the primordial GW for the tensor-to-scalar parameter of $r = 0.03$.
 ]
)
<fig:cl>


The $C_ell^(E E)$ data are dominated by sound waves excited by density fluctuations in the fireball Universe. Photons and electrons were tightly coupled via Thomson scattering, and electrons, protons and helium nuclei were also tightly coupled via Coulomb scattering; thus, the cosmic plasma behaved as if it were a single fluid, i.e., a 'cosmic hot soup'@peebles-yu:1970@sunyaev-zeldovich:1970b. Density fluctuations excited sound waves in this fluid, which have been observed clearly as peaks and troughs in $C_ell^(TT)$@miller-etal:1999@boomerang:2000@hanany-etal:2000 and $C_ell^(T E)$@WMAP:2003 as well as in $C_ell^(E E)$ shown here. The early Universe was indeed filled with sound waves propagating in a hot soup.


Non-linear effects such as the gravitational lensing effect of CMB by the intervening matter distribution in the Universe mix $E$ and $B$ modes at different multipoles@zaldarriaga-seljak:1998 and produce non-zero $C_ell^(BB)$. No $C_ell^(E B)$ is generated by this process unless parity symmetry is violated by other new physics, as we describe in the next section. This lensing-induced $C_ell^(BB)$ has been measured as shown in @fig:cl.


$B$ modes can also be generated by primordial GW@seljak-zaldarriaga:1997@kamionkowski-etal:1997b, which we discuss in the later sections. Using $C_ell^(E E)$ and $C_ell^(BB)$ shown in @fig:cl, we find that the map shown in @fig:planck is consistent with no $B$ modes from GW@tristram-etal:2021. The lensing $B$ mode may be a nuisance in the search of primordial GW, but it is a treasure when investigating the mass distribution (including dark matter) in the Universe@omori-etal:2017@Planck2018VIII @POLARBEAR:2020@darwish-etal:2020.


= New Physics I: Cosmic birefringence
<new-physics-i-cosmic-birefringence>


There exists a distinct possibility that a parity-violating pseudoscalar field, $chi$, is responsible for dark matter and dark energy@marsh:2016 @ferreira:2021. The concept of a pseudoscalar field, which changes sign under inversion of spatial coordinates, is familiar in particle physics. In SM, pion is a pseudoscalar@chinowsky-steinberger:1954. In beyond SM, the strong #emph[CP] problem of quantum chromodynamics (QCD) can be solved by introducing a yet-to-be-discovered pseudoscalar 'axion' field@peccei-quinn:1977@weinberg:1978 @wilczek:1978.


In this article, $chi$ is some new pseudoscalar which can be fundamental ('axionlike' field) or composite. Like pion and axion, $chi$ couples to an electromagnetic (EM) field in a parity-violating manner. If $chi$ is dark matter or dark energy, it affects polarisation of CMB as photons travel through space filled with $chi$ for more than 13 billion years.


== Light propagation in the expanding Universe
<light-propagation-in-the-expanding-universe>


To set the notation, we first review the basics of propagation of a free EM field in expanding space. The material covered in this section will also be used in the later sections on GW. The speed of light is $c equiv 1$ throughout this article.


We choose coordinates in which a distance between two events in homogeneous and isotropic spacetime is given by $d s^2 = sum_(mu nu) g_(mu nu) d x^mu d x^nu = a^2 ( eta ) ( - d eta^2 + d bold(x)^2 )$, with the metric tensor being $g_(mu nu) = a^2 ( eta ) "diag" ( - 1 , bold(1) )$. Here, $bold(x)$ denotes comoving coordinates, whereas $eta = x^0$ is the conformal time which is related to the physical time $t$ as $eta = integral d t a ( t )$, with $a ( t )$ being the scale factor of expanding space.


The action of a free EM field is $I_A = integral d^4 x sqrt - g cal(L)_A$ with a Lagrangian density $cal(L)_A = - sum_(mu nu ) F_(mu nu ) F^(mu nu ) / 4$, where $F_(mu nu) equiv partial A_nu partial x^mu - partial A_mu partial x^nu$ is the antisymmetric electromagnetic tensor and $g$ is the determinant of $g_(mu nu)$. With gauge conditions $A_0 = 0$ and $nabla dot.op bold(A) = 0$, the equation of motion for $bold(A)$ is given by $bold(A)'' - nabla^2 bold(A) = 0$, where $nabla equiv partial partial bold(x)$ and the prime denotes $partial partial eta$.


Those who are not familiar with electromagnetism in cosmology may be surprised to see that the equation of motion for $bold(A)$ takes the same form as in flat Minkowski space. The fundamental reason is that a massless free vector field is #emph[conformally coupled] to gravitation, which implies that, when written in suitable coordinates ($eta$, $bold(x)$), it does not 'feel' expansion of space and behaves as if it were in Minkowski space. Conformal transformation rescales the metric tensor as $g_(mu nu) arrow.r hat(g)_(mu nu) = Omega^2 g_(mu nu)$. For example, if we choose $Omega = a^(- 1)$, we can 'undo' expansion and the transformed metric is equal to the Minkowski metric, $hat(g)_(mu nu) = "diag" ( - 1 , bold(1) )$. Transformation yields $sqrt(- hat(g)) = Omega^4 sqrt(- g)$ and $hat(F)^(mu nu) = Omega^(- 4) F^(mu nu)$\; thus, $sqrt - g cal(L)_A$ remains invariant. We can calculate everything in Minkowski space and the result is valid for all conformally transformed metric tensors in suitable coordinates.


In Fourier space the equation of motion is $bold(A)'' + k^2 bold(A) = 0$, where $k$ is a comoving wavenumber, which is related to a physical wavelength as $lambda ( t ) = 2 pi a ( t ) k$ (i.e., the wavelength of photons gets redshifted in physical coordinates). The equation of motion for $plus.minus$ helicity states is $A''_plus.minus + k^2 A_plus.minus = 0$, yielding the identical dispersion relation for both states.


The electric and magnetic fields are given by $F_(i 0) = a^2 E_i$ (i.e., $bold(E) = - a^(- 2) bold(A)'$) and $F_(i j) = a^2 sum_k epsilon.alt^(i j k) B_k$ (i.e., $bold(B) = a^(- 2) nabla times bold(A)$), respectively. Here, $epsilon.alt^(i j k)$ is a totally antisymmetric symbol with $epsilon.alt^123 = 1$. We then find $cal(L)_A = ( bold(E) dot.op bold(E) - bold(B) dot.op bold(B) ) / 2$. In our notation, $bold(E) dot.op bold(E) = sum_i E_i^2$. The stress-energy tensor is $T_(i j )^A = sum_(mu nu ) g^(mu nu ) F_(i mu) F_(j nu) + g_(i j ) cal(L)_A$, which reproduces the known result for EM pressure, $P_A = ( bold(E) dot.op bold(E) + bold(B) dot.op bold(B) )/6 = rho_A/3$, where $rho_A$ is the energy density. Conformal invariance occurs generally for any stress-energy sources with a vanishing trace, $sum_(mu nu) g^(mu nu) T_(mu nu) = 0$, which is certainly the case for $T_(mu nu)^A$. For a general perfect fluid, a vanishing trace implies $P = rho/3$.


== Rotation of the plane of linear polarisation
<rotation-of-the-plane-of-linear-polarisation>


We now include $chi$. A pseudoscalar can couple to EM via the so-called Chern-Simons (CS) term in the action@ni:1977@turner-widrow:1988 $ I_("CS") & = integral d^4 x sqrt(- g) (- frac(alpha, 4 f) chi F tilde(F)) thin \,\
F tilde(F) & equiv sum_(mu nu) F_(mu nu) sum_(mu' nu') frac(epsilon.alt^(mu nu mu' nu'), 2 sqrt(- g)) F_(mu' nu') thin , $<eq:CS> where $alpha$ is a dimensionless coupling constant, $f$ is the so-called 'decay constant' with dimension of energy, and $epsilon.alt^(mu nu mu' nu')$ is a totally antisymmetric symbol with $epsilon.alt^0123 = 1$. The $F tilde(F)$ term violates parity symmetry, as $F tilde(F) = - 4 bold(B) dot.op bold(E)$ changes sign under inversion of spatial coordinates. Therefore, $chi$ needs to be a pseudoscalar, such that the whole $chi F tilde(F)$ remains invariant.


In SM, a neutral pion $pi_0$ decays into 2 photons via this coupling in the effective Lagrangian density $- 2 g_pi pi_0 F tilde(F)$ with $g_pi = N_c e^2 ( 48 pi^2 f_pi )$@weinberg:1996\; thus, $alpha = N_c e^2 ( 6 pi^2 )$ for $f = f_pi$ where $N_c = 3$ is the number of colours and $f_pi tilde.eq 184$~MeV is the pion decay constant. For our purpose, $alpha f$ is a free parameter related to the physical nature of dark matter or dark energy, which can be constrained by CMB polarisation data.


For simplicity, we first discuss the effect of homogeneous $chi = chi ( eta )$. This is a good approximation for dark energy@carroll:1998 but may not apply to other cases. We discuss spatial fluctuations later. The equation of motion for $bold(A)$ is given by $bold(A)'' - nabla^2 bold(A) - ( alpha chi' f ) nabla times bold(A) = 0$, and that for $A_plus.minus$ is given by@carroll-field-jackiw:1990@carroll-field:1991@harari-sikivie:1992

$ A''_plus.minus + (k^2 minus.plus frac(k alpha chi', f)) A_plus.minus = 0 thin. $<eq:vectorequation>

The effect of the CS term vanishes when $chi$ is a constant, because $sqrt(- g) F tilde(F)$ is a total derivative and does not contribute to physics unless the coefficient multiplying it, $chi$, depends on spacetime.


The equation of motion now yields a helicity-dependent dispersion relation. When the effective angular frequency, $omega_plus.minus^2 equiv k^2 minus.plus k alpha chi' f$, varies slowly with time within one period, $\| omega'_plus.minus \| omega_plus.minus^2 lt.double 1$, a WKB solution is $A_plus.minus tilde.eq ( 2 omega_plus.minus )^(-1/2) e^(- i integral d eta omega_plus.minus + i delta_plus.minus)$, where $delta_plus.minus$ is the initial phase of the $plus.minus$ states. The phase velocity is given by

$ omega_plus.minus / k tilde.eq 1 minus.plus frac(alpha chi', 2 k f) thin , $<eq:phasevelocity>

when the second term is small. Indeed, the second term is absolutely tiny: it is at most of order the ratio of the photon wavelength and the size of the visible Universe, $( k eta )^(- 1)$. However, the impact on CMB accumulates over very long time (more than 13 billion years), which makes $integral d eta ( omega_(+) - omega_(-) )$ large enough to be observable. Therefore, we keep $omega_plus.minus$ in the phase but set $omega_plus.minus tilde.eq k$ in the amplitude of the WKB solution.


On the other hand, the second term in $omega_plus.minus^2 = k^2 minus.plus k alpha chi' f$ can exceed the first term during the period of cosmic inflation, resulting in $omega_plus.minus^2 < 0$ depending on the sign of $alpha$@anber-sorbo:2010. This signals instability, and yields rich phenomenology for primordial GW@sorbo:2011@anber-sorbo:2012@barnaby-pajer-peloso:2012. We discuss this in the later sections on GW.


The group velocity is not modified at linear order of $alpha$ but receives a very tiny positive contribution at $alpha^2$, making $d omega_plus.minus d k tilde.eq 1 + ( alpha chi' f )^2 ( 8 k^2 ) > 1$. Whether this has any significance is an open question@mcdonald-ventura:2020, although it has no practical consequence for our study.


The difference in the phase velocity leads to rotation of the plane of linear polarisation@carroll-field-jackiw:1990@carroll-field:1991@harari-sikivie:1992. Suppose that the initial light of CMB at the surface of last scattering had no circular polarisation, i.e., both helicity states had equal amplitudes of electric fields, $E_plus.minus prop e^(- i integral d eta omega_plus.minus + i delta_plus.minus)$. In the CMB convention defined earlier, the Stokes parameters for linear polarisation are $Q prop cos [ integral d eta ( omega_(+) - omega_(-) ) - ( delta_(+) - delta_(-) ) ]$ and $U prop - sin [ integral d eta ( omega_(+) - omega_(-) ) - ( delta_(+) - delta_(-) ) ]$. The PA is given by

$ beta = 1 / 2 (delta_(+) - delta_(-)) - 1 / 2 integral d eta (omega_(+) - omega_(-)) thin. $<eq:beta>

The plane of linear polarisation is rotated relative to the initial PA at the surface of last scattering, $( delta_(+) - delta_(-) ) 2$. This phenomenon is similar to birefringence in a crystal.


The Stokes parameter for circular polarisation vanishes, $V = 0$, as we set $omega_plus.minus tilde.eq k$ in the amplitude of the WKB solution. Keeping $omega_plus.minus$ results in a tiny $V$@finelli-galaverni:2009. Non-zero $V$ occurs at the order $alpha^2$ as well@alexander-ochoa-kosowsky:2009.


Without loss of generality, we set $delta_(+) - delta_(-) = 0$ from now on. Using @eq:phasevelocity, we find $beta = ( alpha/2 f ) integral_(eta_("LS"))^(eta_0) d eta chi'$, where the subscripts 'LS' and '0' denote the time of last scattering and the present-day time, respectively. Therefore, space filled with a time-dependent $chi$, which could be dark matter or dark energy or both, behaves as if it were a birefringent material. For this reason, such an effect is called 'cosmic birefringence'.


We sketch this effect in @fig:minami. $beta > 0$ is a clockwise rotation on the sky. If we write $cal(L)_"CS" = frac(1,4) g_a chi F tilde F$ for a Lagrangian density of the CS term@harari-sikivie:1992 instead of that in @eq:CS, $beta = - 1 / 2 g_a integral_(eta_("LS"))^(eta_0) d eta chi'$.


// vision: This is a schematic diagram, not a data plot, showing two globes-a small sphere at left and a much larger sphere at right-connected by dotted perspective lines forming a conical frustum. Each globe bears a variegated color map in blue, green, yellow, and orange-red; the large globe has a red burst-like region at lower right and dashed black hexagonal outlines near top, while the small globe shows matching features. Sweeping orange curves looping between and around the globes represent magnetic field lines. In the upper right, an angle labeled β is marked between two vertical reference bars.
// [figvision-cn] imgs/fig3.png
// 该图为宇宙双折射导致线性偏振旋转的示意图。图像背景为深
// 蓝色，整体布局从左至右展示光子传播过程。左侧有一个较小
// 的球体，代表最后散射面；右侧有一个较大的球体，代表今天
// 的观测者视角。两个球体之间由一个半透明的、呈梯形展开的
// 灰色光束区域连接，表示光子的传播路径。 在左侧小球的表
// 面，绘制有彩色的温度涨落图样，颜色从深蓝（低温）过渡到
// 青色、黄色、橙色直至红色（高温）。在此图样之上叠加了两
// 组黑色的粗短线段图案：上方一组呈六边形排列，下方一组呈
// 星形放射状排列。这些黑色线段代表初始的线性偏振方向。
// 一条白色的细直线贯穿两个球体的中心，代表光子的传播轴线。
// 围绕这条白色轴线，有一条橙色的正弦波形曲线，模拟电磁波
// 的振荡。 在右侧大球的表面，同样绘制有与左侧相似的彩色
// 温度涨落图样。然而，其表面的黑色粗短线段图案相对于左侧
// 发生了旋转。原本垂直或水平的线段现在呈现出倾斜角度。具
// 体而言，上方的六边形图案和下方的星形图案中的每一根短线
// 都顺时针旋转了一个角度。 在图像的右上角，有一个独立的
// 局部放大图示，用于解释旋转角。图中画有一根垂直的黑色短
// 线段，旁边标注有希腊字母“β”。从这根垂直线段出发，画有
// 一条弯曲的橙色箭头，指向一根向右倾斜的黑色短线段。这个
// 图示直观地定义了旋转角β，即偏振平面从初始状态（垂直）
// 旋转到最终状态（倾斜）的角度。 整幅图通过对比左右两个
// 球体上黑色线段的朝向差异，并结合右上角的角度定义，传达
// 了以下结论：当宇宙微波背景辐射光子从最后散射面传播至今
// 日时，由于宇宙双折射效应，其线性偏振平面发生了一个大小
// 为β的旋转，导致观测到的偏振模式相对于源头的原始模式发
// 生了改变。
#figure(placement: auto, image("imgs/fig3.png", width: 100%),
 caption: [
 #strong[Rotation of linear polarisation by cosmic birefringence.] Polarisation pattern at the surface of last scattering (black lines inside the left circle) changes when the plane of linear polarisation (orange line) rotates by an angle $beta$ as CMB photons travel to reach us today (right circle). Credit: Y. Minami.
 ]
)
<fig:minami>


We can derive the same result in an alternative way@harari-sikivie:1992. Writing the Lagrangian density, $
 cal(L)_A + cal(L)_"CS" &= 1/2 (bold(E) dot.op bold(E) - bold(B) dot.op bold(B)) + alpha/f chi (bold(B) dot.op bold(E)) \
 &= 1/2 [(bold(E) + alpha/(2 f) chi bold(B))^2 - (bold(B) - alpha/(2 f) chi bold(E))^2] + cal(O)(alpha^2),
$ we find that the linear combinations $bold(E) + ( alpha/2 f ) chi bold(B)$ and $bold(B) - ( alpha/2 f ) chi bold(E)$ satisfy free wave equations and oscillate along a constant direction. The plane of linear polarisation therefore rotates clockwise on the sky by an angle $beta = ( alpha/2 f ) [chi ( eta_0 ) - chi ( eta_("LS") )]$.


We now include spatial fluctuations, $chi ( eta ) arrow.r chi ( eta , bold(x) )$. Conveniently, all we need is to replace $k chi' arrow.r k chi' + bold(k) dot.op nabla chi$ in @eq:vectorequation, i.e., the total derivative of $chi$ along the photon trajectory@harari-sikivie:1992@li-zhang:2008@pospelov-ritz-skordis:2009. The birefringence angle is given by

$ beta ( hat(n) ) = frac(alpha, 2 f) [chi ( eta_0 ) - chi ( eta_("LS") , r_("LS") hat(n) )] thin , $<eq:betahat>

where $r_("LS") equiv eta_0 - eta_("LS")$ is the comoving distance from the observer to the surface of last scattering and $hat(n)$ is the direction of observer's lines of sight.


Fluctuations in $beta ( hat(n) )$ are easier to measure experimentally than the isotropic $beta$, as they do not require knowledge of the absolute PA of polarisation-sensitive detectors on the focal plane with respect to the sky@kamionkowski:2009 Currently there is no evidence for fluctuations in $beta ( hat(n) )$@contreras-boubel-scott:2017@bianchini-etal:2020@namikawa-etal:2020@gruppuso-etal:2020\; thus, we focus on the isotropic $beta$ for the rest of this article.


The phenomenon of cosmic birefringence can occur more generally. Integrating @eq:CS by parts, we obtain $I_("CS") = frac(alpha, 2 f) integral d^4 x sqrt(- g) sum_(mu nu) p_mu A_nu tilde(F)^(mu nu) thin ,$ where $p_mu = partial chi partial x^mu$ for the pseudoscalar example. We now promote $p_mu$ to a generic 4-vector. Since $p_mu$ picks up a preferred direction in spacetime, it breaks Lorentz and #emph[CPT] symmetry; thus, cosmic birefringence is a probe of new physics that breaks Lorentz and #emph[CPT] symmetry@carroll-field-jackiw:1990@colladay-kostelecky:1998@kostelecky-mewes:2002@kostelecky-mewes:2007. For the homogeneous pseudoscalar example, cosmological evolution of $chi$ picks up a preferred direction $p_0 = chi'$. Lorentz breaking terms in the effective Lagrangian can generate non-zero circular polarisation@alexander-ochoa-kosowsky:2009@zarei-etal:2010.


So far we have considered $beta$ that is independent of the photon energy $k$. Lorentz and #emph[CPT] breaking terms in the effective Lagrangian can give $beta ( k ) prop k^n$ with $n = 1$@shore:2005 and $2$@gambini-pullin:1999@myers-pospelov:2003. Such signatures may be a sign of new physics at the Planck energy scale, e.g., quantum gravity. In the absence of Lorentz and #emph[CPT] breaking terms, astrophysical effects such as Faraday rotation due to the intergalactic magnetic field can produce a $k$-dependent rotation of the plane of linear polarisation with $n = - 2$@kosowsky-loeb:1996. If $chi$ is dark matter with non-zero magnetic moment@pospelov-terveldhuis:2000@sigurdson-etal:2004, a Gyromagnetic Faraday effect can also produce $beta$ in the presence of an external magnetic field@gardner:2008. Unlike the usual Faraday effect with $n = - 2$, $beta$ from a Gyromagnetic effect is independent of $k$.


See Refs.@kahniashvili-durrer-maravin:2008@gubitosi-etal:2009@gubitosi-paci:2013 for early constraints on $beta ( k )$. Later we discuss the latest constraint on $n$ from the #emph[Planck] data@eskilt:prep.


== Effects on $E$ and $B$ modes
<effects-on-e-and-b-modes>


When PA shifts uniformly over the sky by $beta$, we have $Q^("o") plus.minus i U^("o") = ( Q plus.minus i U ) e^(plus.minus 2 i beta)$, where the superscript 'o' denotes the observed value and $Q plus.minus i U$ on the right hand side is the intrinsic one at the surface of last scattering. This yields $E_(ell m)^("o") plus.minus i B_(ell m)^("o") = ( E_(ell m) plus.minus i B_(ell m) ) e^(plus.minus 2 i beta)$, or
$ E_(ell m)^"o" = E_(ell m) cos ( 2 beta ) - B_(ell m) sin ( 2 beta ) thin , $ <eq:EBrelation1>
$ B_(ell m)^"o" = E_(ell m) sin ( 2 beta ) + B_(ell m) cos ( 2 beta ) thin. $ <eq:EBrelation2> This simple result assumes an instantaneous decoupling of CMB photons at $eta_("LS")$. In reality, the last scattering of photons occurred over a finite duration characterised by the so-called 'visibility function', $cal(V) ( eta )$, which has a peak at $eta_("LS")$ with some width. We need to integrate the Boltzmann equation for photons to take this effect into account.


For simplicity, let us consider only the density fluctuation and ignore GW. We expand $Q plus.minus i U$ in Fourier space with the wavenumber $bold(q)$ taken in the $z$ axis. Defining $mu = cos theta$ for the propagation direction of photons in spherical coordinates, we write the Boltzmann equation for the Fourier coefficients, $zws_(plus.minus 2) Delta_P ( eta , q , mu )$, as@liu-lee-ng:2006@finelli-galaverni:2009@gubitosi-martinelli-pagano:2014 $ zws_(plus.minus 2) Delta'_P + i q mu zws_(plus.minus 2) Delta_P = & - tau' zws_(plus.minus 2) Delta_P + sqrt(20 pi) zws_(plus.minus 2) Y_2^0 ( mu ) sqrt(6) / 10 tau' Pi\
 & plus.minus 2 i beta' zws_(plus.minus 2) Delta_P thin , $<eq:boltzmann> where $beta' = - ( omega_(+) - omega_(-) ) / 2$ (see @eq:beta, $tau' equiv a sigma_("T") n_e$, $sigma_("T")$ is the Thomson scattering cross section, $n_e$ the electron number density, and $Pi$ the polarisation source function@zaldarriaga-seljak:1997.


Expanding $zws_(plus.minus 2) Delta_P$ using spin-2 spherical harmonics, $zws_(plus.minus 2) Delta_P ( eta , q , mu ) = sum_ell i^(- ell) sqrt(4 pi ( 2 ell + 1 )) zws_(plus.minus 2) Delta_(P , ell) ( eta , q ) zws_(plus.minus 2) Y_ell^0 ( mu ) thin ,$ and defining the coefficients of $E$ and $B$ modes in the same way as in @eq:EBfullsky, $zws_(plus.minus 2) Delta_(P , ell) = - ( Delta_(E , ell) plus.minus i Delta_(B , ell) )$, we find solutions to @eq:boltzmann as $
 Delta_(E, ell) (eta_0, q) &= 3/4 sqrt(((ell + 2)!)/((ell - 2)!)) integral_0^(eta_0) d eta cal(V) Pi frac(j_ell (x), x^2) cos(2 beta (eta)),
$ <eq:boltzmannsolutionE> $
 Delta_(B, ell) (eta_0, q) &= 3/4 sqrt(((ell + 2)!)/((ell - 2)!)) integral_0^(eta_0) d eta cal(V) Pi frac(j_ell (x), x^2) sin(2 beta (eta)),
$ <eq:boltzmannsolutionB> where $beta ( eta ) = integral_eta^(eta_0) d eta beta'$, $cal(V)(eta) equiv a sigma_"T" n_e e^(-tau(eta))$ is the visibility function with $tau ( eta ) = integral_eta^(eta_0) d eta tau'$, and $j_ell ( x )$ the spherical Bessel function with $x = q ( eta_0 - eta )$.


For a slowly varying $beta ( eta )$ and a very sharply peaked $cal(V) ( eta )$, these solutions agree with @eq:EBrelation1 and @eq:EBrelation2 without $B_(ell m)$ on the right hand side, as we ignored primordial $B$ modes from GW at the surface of last scattering. On the other hand, for a rapidly oscillating $beta ( eta )$ within a finite width of $cal(V) ( eta )$, the effect is 'washed out' and a proper treatment is required. This happens when $chi$ is dark matter and starts oscillating before decoupling@finelli-galaverni:2009@fedderke-graham-rajendran:2019. See Refs.@lee-liu-ng:2016@capparelli-caldwell-melchiorri:2020 for treatment of spatially fluctuating $beta$ in the Boltzmann equation.


The Boltzmann equation is also required when we include the effect of reionisation of hydrogen atoms in a late-time Universe@zaldarriaga:1997. The so-called 'reionisation bump' at $ell lt.tilde 10$ (see @fig:cl) was generated at a redshift of $z tilde.eq 10$, and experienced less cosmic birefringence because of a shorter path length of photons@liu-lee-ng:2006@WMAP:2009. We can use this effect to perform 'tomography': the difference between cosmic birefringence inferred from $ell lt.tilde 10$ and that from higher $ell$ tells us the evolution of $chi$ between $z tilde.eq 10$ and $z_("LS") tilde.eq 1090$@sherwin-namikawa:prep. As the current analysis of the #emph[Planck] data@minami-komatsu:2020b@NPIPE:2022 @eskilt:prep is based only on $ell gt.eq 51$, we use @eq:EBrelation1 and @eq:EBrelation2 for the rest of this article.


== Measuring $beta$ from the $E B$ correlation
<measuring-beta-from-the-eb-correlation>


Cosmic birefringence yields non-zero observed $C_ell^(E B , "o")$ even if there were no $C_ell^(E B)$ at the surface of last scattering@lue-wang-kamionkowski:1999@feng-etal:2005@liu-lee-ng:2006. Using @eq:EBrelation1 and @eq:EBrelation2, we find $ C_ell^(E E , "o") & = cos^2 ( 2 beta ) C_ell^(E E) + sin^2 ( 2 beta ) C_ell^(B B) - C_ell^(E B) sin ( 4 beta ) thin \,\
C_ell^(B B , "o") & = sin^2 ( 2 beta ) C_ell^(E E) + cos^2 ( 2 beta ) C_ell^(B B) + C_ell^(E B) sin ( 4 beta ) thin \,\
C_ell^(E B , "o") & = 1 / 2 sin ( 4 beta ) ( C_ell^(E E) - C_ell^(B B) ) + C_ell^(E B) cos ( 4 beta ) thin. $ Using the solutions of the Boltzmann  @eq:boltzmannsolutionE and @eq:boltzmannsolutionB, we can also calculate $
 C_ell^(X Y , "o") = 4 pi integral d ln q cal(P)_("s") ( q ) Delta_(X , ell) ( eta_0 , q ) Delta_(Y , ell) ( eta_0 , q ) thin \,
$ when $C_ell^(BB) = 0 = C_ell^(E B)$ initially. Here, $cal(P)_"s" ( q )$ is the power spectrum of the initial scalar curvature perturbation.


Rotation by $beta$ does not create $E B$ when $C_ell^(E E) = C_ell^(BB)$. This makes sense because $beta$ mixes $E$ and $B$ modes; we need an asymmetry between the amplitudes of $E$ and $B$ modes to produce a non-zero effect. For example, randomly oriented polarisation angles have $C_ell^(E E) = C_ell^(BB)$ and $C_ell^(E B) = 0$. Rotation by $beta$ still keeps them random, hence $C_ell^(E B , "o") = 0$.


We can write $C_ell^(E B , "o")$ in terms of $C_ell^(E E , "o")$ and $C_ell^(BB , "o")$@zhao-etal:2015@gruppuso-etal:2016

$ C_ell^(E B , "o") = 1 / 2 ( C_ell^(E E , "o") - C_ell^(BB , "o") ) tan ( 4 beta ) + frac(C_ell^(E B), cos ( 4 beta )) thin. $<eq:EBobs>

As shown in @fig:cl, there is a large asymmetry between $C_ell^(E E , "o")$ and $C_ell^(BB , "o")$ in our Universe, which makes the $E B$ correlation a sensitive probe of $beta$.


The intrinsic $C_ell^(E B)$ on the right hand side could be generated by parity-violating primordial GW from gauge fields, as discussed in the later sections of this article. We can distinguish between the effects of $beta$ and the intrinsic $C_ell^(E B)$ easily using the shape of $C_ell^(E B)$@gluscevic-kamionkowski:2010@thorne-etal:2018.


However, the effect of $beta$ is degenerate with an instrumental miscalibration of polarisation angles~@wu-etal:2009@WMAP:2011 Do we observe $C_ell^(E B , "o")$ because of $beta$, or because we do not know how polarisation-sensitive orientations of detectors on the focal plane of a telescope are related to the sky coordinates and how polarisation of the incoming light is rotated by optical components precisely enough? If we rotate the focal plane by a miscalibration angle $alpha$, the observed PA shifts and generates non-zero $C_ell^(E B , "o")$ in the same way as $beta$. As a result, in the absence of any other information, we can only determine the sum of the two angles, $alpha + beta$, which explains why the previous determinations of $beta$ were spread over a wide range beyond the quoted statistical uncertainties (excluding systematic uncertainties in the knowledge of $alpha$)@PlanckIntXLIX@adachi-etal:2020@bianchini-etal:2020@namikawa-etal:2020@choi-etal:2020.


Is there information we can use to lift degeneracy between $alpha$ and $beta$? One approach is to calibrate $alpha$ using astrophysical objects with known PA@kaufman-keating-leon:2016@aumont-etal:2020@masi-etal:2021. However, to determine PA of an object with sufficient precision, we must have calibrated detectors well enough for such a measurement in the first place. This has not been achieved much better than $0.5^compose$@takahashi-etal:2010@koopman:2018.


In 2019, Minami et al. proposed a new way to solve this issue@minami-etal:2019. The magnitude of cosmic birefringence is proportional to the path length of photons when $chi'$ varies slowly, which makes CMB photons an ideal target. Our sky also contains polarised microwave emission from intersteller gas within our own Galaxy, which is often called the Galactic 'foreground' emission. As the path length of photons within our Galaxy is much smaller, we can safely ignore $beta$ for the foreground emission. Thus, polarisation of the foreground (FG) is rotated only by $alpha$, whereas that of CMB by $alpha + beta$.

#[
  #set math.equation(numbering: none)
  $
    E_(ell m)^"o" &= E_(ell m)^"FG" cos(2 alpha) - B_(ell m)^"FG" sin(2 alpha) \
    & + E_(ell m)^"CMB" cos(2 alpha + 2 beta) - B_(ell m)^"CMB" sin(2 alpha + 2 beta), \
    B_(ell m)^"o" &= E_(ell m)^"FG" sin(2 alpha) + B_(ell m)^"FG" cos(2 alpha) \
    & + E_(ell m)^"CMB" sin(2 alpha + 2 beta) + B_(ell m)^"CMB" cos(2 alpha + 2 beta),
  $
]

which gives
$
  C_ell^(E B, "o") &= frac(tan(4 alpha), 2) (C_ell^(E E, "o") - C_ell^(B B, "o")) \
  & + frac(sin(4 beta), 2 cos(4 alpha)) (C_ell^(E E, "CMB") - C_ell^(B B, "CMB")) \
  & + frac(1, cos(4 alpha)) C_ell^(E B, "FG") + frac(cos(4 beta), cos(4 alpha)) C_ell^(E B, "CMB").
$ This formula allows us to determine $alpha$ and $beta$ simultaneously, as $C_("ell")^(E E , "CMB")$ and $C_("ell")^(B B , "CMB")$ are known precisely. Note that the formula does not require any knowledge of $C_ell^(E E , "FG")$ or $C_ell^(BB , "FG")$, but $C_ell^(E B , "FG")$ and $C_ell^(E B , "CMB")$. We can ignore $C_ell^(E B , "CMB")$ for sensitivity of the current experiments, but $C_ell^(E B , "FG")$ needs to be taken into account when interpreting the measured value of $beta$.


== Results from the #emph[Planck] polarisation data
<results-from-the-planck-polarisation-data>


Applying the methodology developed in Refs.@minami-etal:2019@minami:2020@minami-komatsu:2020 to the #emph[Planck] high-frequency instrument (HFI) data at $nu = 100$, 143, 217 and 353~GHz released in 2018@Planck2018III, a weak signal of $beta = 0.35^compose plus.minus 0.14^compose$ was reported for nearly full-sky data@minami-komatsu:2020b. Throughout this section, we quote uncertainties at the 68 % C.L. Subsequently, more precise value, $beta = 0.30^compose plus.minus 0.11^compose$, was reported@NPIPE:2022 using the latest reprocessing of the #emph[Planck] data called '`NPIPE`'@PlanckIntLVII.


These measurements were done assuming that $beta$ was independent of $nu$. Eskilt@eskilt:prep expanded the analysis by constraining the photon frequency dependence of $beta ( nu )$. To this end he included all of the polarised frequency channels of the #emph[Planck] data, including those of the low-frequency instrument (LFI) at 30, 44 and 70~GHz@Planck2018II. Parametrising the frequency dependence as $beta ( nu ) prop nu^n$, he finds $n = - 0.35_(- 0.47)^(+ 0.48)$, which is consistent with a frequency-independent $beta$. Assuming $n = 0$, he finds $beta = 0.33^compose plus.minus 0.10^compose$. The statistical significance exceeds $3 sigma$. While intriguing, it is not yet sufficient to claim a convincing detection.


If confirmed as a genuine signal of cosmic birefringence with more statistical significance in future, these measurements would provide evidence for new physics beyond SM with profound implications for the fundamental physics behind dark matter and dark energy. First of all, simply knowing that the physics behind them violates parity symmetry is a breakthrough. Next, as $chi$ must evolve in time, it would rule out Einstein's cosmological constant, $Lambda$, as the origin of dark energy. Such a discovery would have a far-reaching consequence for quantum gravity: As $Lambda > 0$ is difficult to realise in quantum gravity@dvali-gomez:2016@dvali:2020, a recent 'Swampland' proposal@obied-etal:prep@garg-krishnan:2019@ooguri-etal:2019 favours a dynamical scalar field as the origin of dark energy@agrawal-etal:2018@dvali-gomez-zell:2019. If $chi$ is dark matter, $beta$ may change during the course of observations as $chi ( eta_0 )$ in @eq:betahat oscillates around the minimum of a quadratic potential, $V ( chi ) = m^2 chi^2 2$@fedderke-graham-rajendran:2019@BICEPKeck:2021.


The measured value of $beta$ suggests that $chi$ has moved by@minami-komatsu:2020b

$ Delta chi tilde.eq 10^(- 2) / alpha f thin , $<eq:interpretation>

where $Delta chi equiv chi ( eta_0 ) - chi ( eta_("LS") )$. This is sensible: for pion and axion, $alpha$ is of order the fine-structure constant of EM. If this applies also to $chi$, $Delta chi tilde.eq f$, which is expected for a cosine potential typical of axionlike fields, $V ( chi ) = mu^4 [ 1 + cos ( phi f ) ]$@freese-frieman-olinto:1990. See Refs.@fujita-etal:2021a@fujita-etal:2021b@takahashi-yin:2021@mehta-etal:2021@nakagawa-takahashi-yamada:2021@alvey-escudero:2021@choi-etal:2021@obata:prep for more on interpretation.


== Impact of polarised Galactic foreground emission
<impact-of-polarised-galactic-foreground-emission>


We now include the effect of possible foreground $E B$ correlations. When $C_ell^(E B , "FG")$ exists, we have the relation $C_ell^(E B , "FGo") = 1 / 2 sin ( 4 alpha ) ( C_ell^(E E , "FG") - C_ell^(BB , "FG") ) + C_ell^(E B , "FG") cos ( 4 alpha )$@abitbol-hill-johnson:2016. We can formally rewrite this as@NPIPE:2022 $C_ell^(E B , "FGo") = sqrt(J_ell^2 + (C_ell^(E B , "FG"))^2) sin ( 4 alpha + 4 gamma_ell ) thin ,$ where $J_ell equiv ( C_ell^(E E , "FG") - C_ell^(BB , "FG") ) 2$ and $tan ( 4 gamma_ell ) equiv C_ell^(E B , "FG") J_ell$ is an effective angle for the foreground $E B$. For $C_ell^(E B , "FG") prop J_ell$, $gamma_ell$ becomes independent of $ell$, $gamma_ell = gamma$, and is degenerate with $alpha$. In this limit and $\| gamma \| lt.double 1$, the foreground does not yield $alpha$ but $alpha + gamma$, and we measure $beta - gamma$@minami-etal:2019.


Polarised thermal emission of dust grains is the dominant foreground at the #emph[Planck] HFI frequencies. The #emph[Planck] collaboration also detected intriguing correlations between the dust intensity and $E$- and $B$-mode polarisation, $C_ell^(T E , "dust")$ and $C_ell^(T B , "dust")$, respectively@Planck2018XI@weiland-etal:2020. This is also confirmed by an independent analysis using the distribution of filaments of neutral hydrogen atoms~@clark-etal:2021.


Detection of $C_ell^(T B , "dust")$ was not expected. One plausible explanation is based on filaments of hydrogen clouds producing the thermal dust emission and polarisation@huffenberger-rotti-collins:2020. When the filaments and magnetic field lines are perfectly aligned, a positive $T E$ but no $T B$ or $E B$ correlations are produced. When they misalign by a small angle, $T B$ and $E B$ correlations emerge with the same sign. Such a physical insight results in a model for $gamma_ell$ given by@clark-etal:2021@NPIPE:2022

$ gamma_ell tilde.eq frac(A_ell C_ell^(E E , "dust"), C_ell^(E E , "dust") - C_ell^(BB , "dust")) C_ell^(T B , "dust") / C_ell^(T E , "dust") thin , $<eq:filament>

where $A_ell$ is a free amplitude parameter which varies slowly with $ell$. Using this model to determine $alpha$, $beta$ and $gamma_ell$ simultaneously, Diego-Palazuelos et al.@NPIPE:2022 find $beta = 0.36^compose plus.minus 0.11^compose$ for nearly full-sky data at the HFI frequencies. The statistical significance exceeds $3 sigma$.


It is reassuring that a frequency-independent $beta$ is found when adding the LFI data@eskilt:prep: the Galactic foreground at such low frequencies is no longer dominated by dust emission but is dominated by synchrotron emission. No frequency dependence is therefore consistent with a cosmological signal.


We need to improve our understanding of the foreground polarisation such that we can assign properly the #emph[systematic] uncertainty of the model for $C_ell^(E B , "dust")$ to the measured value of $beta$. The hint for cosmic birefringence motivates further work not only on cosmology but also on Galactic science.


We can avoid the issue of the Galactic foreground altogether if we do not rely on it. To this end, we must improve upon the accuracy of calibrating instruments. We comment on this in the 'Outlook' section.


= New Physics II: Primordial gravitational waves from the early Universe
<new-physics-ii-primordial-gravitational-waves-from-the-early-universe>


How is it possible that the origin of all structures in the Universe was the quantum-mechanical vacuum fluctuation generated in the early Universe? Quantum mechanics operates in microscopic atomic worlds, whereas cosmic structures are vastly macroscopic objects. What linked micro- and macroscopic worlds? The leading idea is that the link was provided by a period of accelerated, exponential expansion of space in the early Universe called 'cosmic inflation'@guth:1981 @sato:1981 @linde:1982@albrecht-steinhardt:1982. See Refs.@steinhardt-turok:2002@nayeri-brandenberger-vafa:2006@brandenberger:2017 for other ideas. The origin of cosmic structures is therefore explained by a combination of quantum mechanics and general theory of relativity for gravitation -- the two pillars of modern physics@mukhanov:2016.


According to the idea of inflation, a microscopic wavelength of quantum fluctuations was stretched by enormous expansion of space to become a macroscopic one. Not only was the fluctuation in density (called a scalar mode) generated quantum mechanically@mukhanov-chibisov:1981@hawking:1982 @starobinsky:1982@guth-pi:1982@bardeen-turner-steinhardt:1983, but also the #emph[primordial gravitational wave] (GW; tensor mode) is expected to be produced and stretched to macroscopic wavelengths@grishchuk:1975 @starobinsky:1979. The scalar mode explains the observed properties of cosmic structures@weinberg:2008 @peebles:2020. The tensor mode is yet to be discovered@tristram-etal:2021@BICEP:2021 @SPIDER:2022@tristram-etal:prep.


== Energy density spectrum of GW
<energy-density-spectrum-of-gw>


The simplest model of inflation based on a single energy component driving accelerated expansion predicts a stochastic background of primordial GW at all wavelengths, from tens of billions of light-years (comparable to the size of the visible Universe today) to human sizes. More common units used for describing GW are the frequency $f$. A wavelength of tens of billions of light-years corresponds to a frequency of atto Hz ($f = 10^(- 18)$~Hz). No astrophysical process (e.g., collision of compact objects such as black holes and neutron stars) can generate such a low-frequency GW@caprini-figueroa:2018\; thus, its discovery provides strong evidence for inflation which, in turn, calls for new physics beyond SM@lyth:1997@lyth-riotto:1999.


In @fig:omega_gw, we show typical spectra of the present-day energy density of stochastic GW from inflation discussed in this article. It is common to show the fractional energy density parameter of GW, $Omega_("GW") ( f ) equiv rho_("crit")^(- 1) d rho_("GW") d ln f$, which is the ratio of the GW energy density per logarithmic frequency, $d rho_("GW") d ln f$, to the critical density of the Universe, $rho_("crit")$. The most important message of this figure is that the GW spectrum spans a huge range of $f$, and various experiments can measure them across at least 21 decades in $f$@lasky-etal:2016@adshead-etal:2020@campeti-etal:2021@kite-etal:2021@bailes-etal:2021.


// vision: This is a log-log plot of fractional gravitational-wave energy density today versus gravitational-wave frequency, with the y-axis spanning roughly 10^-19 to 10^-9 and the x-axis spanning 10^-18 to 10^2 Hz. The legend shows three curves: Vacuum Fluctuation (solid blue), SU(2) Gauge Field (AX2) (dashed orange), and SU(2) Gauge Field (AX3) (dotted green). The blue curve drops from ~10^-14 at 10^-18 Hz to a flat ~10^-17 plateau; the orange dashed curve stays near 10^-17 to 10^-16 across most frequencies; and the green dotted curve rises from ~10^-15 to a peak of about 10^-13 near 10^-10 Hz before falling, exceeding the vacuum level between roughly 10^-16 and 10^-2 Hz.
// [figvision-cn] imgs/fig4.png
// 这是一张展示原初引力波（GW）在当今宇宙中能量密度随频率
// 变化的科学图表，包含一个主坐标图、三条理论模型曲线以及
// 顶部的实验技术示意图。 子图类型：对数-对数坐标曲线图（
// Log-Log Plot），叠加有说明性插图。 坐标轴信息： 横轴（
// X轴）：名称为“Gravitational Wave Frequency [Hz]”（引力
// 波频率，单位赫兹）。刻度范围从 10^-18 Hz 到 10^2 Hz，
// 采用对数标度，主要刻度标记为 10的偶数次幂（10^-18, 10^
// -16, ..., 10^0, 10^2）。 纵轴（Y轴）：名称为“
// Fractional GW Energy Density Today”（当今引力波分数能
// 量密度，通常指参数 Ω_GW）。刻度范围从 10^-17 到 10^-9，
// 采用对数标度，主要刻度标记为 10的奇数次幂（10^-17, 10^
// -15, ..., 10^-9）。 图例与曲线描述（位于左上角方框内）：
// 蓝色实线（Vacuum Fluctuation）：代表真空涨落模型。该曲
// 线在低频端（约 10^-18 Hz）起始于 10^-13 左右，迅速下降，
// 在 10^-16 Hz 处降至约 10^-17。随后曲线趋于平缓，在 10^
// -14 Hz 至 10^2 Hz 的宽频范围内保持在 10^-17 的水平线上，
// 中间在 10^-10 Hz 附近有一个微小的隆起。 橙色长虚线（SU
// (2) Gauge Field (AX2)）：代表 SU(2) 规范场模型（AX2）。
// 该曲线在低频端（10^-18 Hz）约为 10^-16，随后下降至 10^
// -17 以下。在 10^-14 Hz 之后开始上升，在 10^-10 Hz 至
// 10^-2 Hz 之间形成一个较宽的峰值平台，数值维持在 10^-16
// 左右，最后在高频端（>10^0 Hz）缓慢下降。 绿色点状虚线
// （SU(2) Gauge Field (AX3)）：代表 SU(2) 规范场模型（
// AX3）。该曲线呈现明显的钟形分布。从低频端的 10^-15 左
// 右下降至 10^-16 Hz 处的局部极小值（约 10^-16），随后显
// 著上升，在 10^-10 Hz 附近达到峰值，数值略高于 10^-13。
// 之后随着频率增加而下降，在 10^0 Hz 附近穿过 10^-15，并
// 在 10^1 Hz 后急剧跌落至图表底部。 顶部插图布局（从左至
// 右）： CMB（宇宙微波背景辐射）区域：对应频率范围约 10^
// -18 Hz 至 10^-16 Hz。插图是一个椭圆形的球体投影图，表
// 面布满橙色和蓝色的斑点纹理，模拟全天空温度涨落图。文字
// 标注“CMB”位于椭圆上方。 Pulsars/Stars（脉冲星/恒星）区
// 域：对应频率范围约 10^-10 Hz 至 10^-8 Hz。插图是一张深
// 色的夜空照片，其中可见绿色的线条连接着几个光点，模拟脉
// 冲星计时阵列的观测网络。文字标注“Pulsars/Stars”位于图
// 片上方。 Laser/atomic Interferometers（激光/原子干涉仪）
// 区域：对应频率范围约 10^-6 Hz 至 10^2 Hz。此处并排展示
// 了三张小图：左侧是一张红色的三角形光路示意图；中间是一
// 张手绘风格的太空探测器或卫星轨道草图；右侧是两张实景照
// 片，分别展示了实验室内的干涉条纹图案和户外的长基线干涉
// 仪装置（类似LIGO）。文字标注“Laser/atomic
// Interferometers”横跨这三张图片上方。 趋势与结论： 该图
// 对比了三种不同物理机制产生的原初引力波谱。绿色点线模型
// （AX3）在纳赫兹频段（10^-10 Hz）具有最高的能量密度，可
// 能落入脉冲星计时阵列的探测窗口。橙色虚线模型（AX2）在
// 微赫兹至毫赫兹频段表现出平坦的谱特征。蓝色实线模型（真
// 空涨落）整体能级最低，但在极宽频段内保持平坦。顶部的插
// 图指出了当前及未来的探测手段及其对应的敏感频率区间，暗
// 示了不同理论模型在不同频段被实验验证的可能性。
#figure(scope: "parent", placement: auto, image("imgs/fig4.png", width: 100%),
 caption: [
 #strong[Present-day energy density of primordial GW across 21 decades in frequency.] The vertical axis shows the fractional energy density parameter of GW today, $Omega_("GW")$. The horizontal axis shows the GW frequency in units of Hz. Illustrations of various experimental techniques@bailes-etal:2021 are shown in the corresponding frequency bands. An apparent gap between 'CMB' anad 'Pulsars/Stars' could be filled by measuring a small departure of the CMB energy spectrum from a Planck spectrum@kite-etal:2021@chluba-etal:2021. The solid line shows the vacuum energy contribution of Starobinsky's $R^2$ inflation@starobinsky:1979 @starobinsky:1980 See Refs.@watanabe-komatsu:2006@saikawa-shirai:2018@kite-etal:2021b for explanations of the spectral shape. The dashed and dotted lines show $Omega_("GW")$ sourced by SU(2) gauge fields of AX2 and AX3 models given in Ref.@campeti-etal:2021.
 ]
)
<fig:omega_gw>


How do we measure GW across 21 decades in $f$? A laser interferometer technique@gertsenshtein-pustovoit:1962@moss-miller-forward:1971 was employed successfully to detect GW from binary black holes@LIGOScientific:2016, whose wavelength was $lambda tilde.eq$~a few thousand km ($f tilde.eq 10^2$~Hz), comparable to the size of Earth. The upcoming ESA #emph[Laser Interferometer Space Antenna] (#emph[LISA]@LISA:2017) mission is sensitive to $lambda tilde.eq$~a few hundred million km ($10^(- 3)$~Hz), comparable to astronomical units. New mission concepts were submitted for ESA's #emph[Voyage 2050] planning of Large Class science missions in the timeframe 2035-2050, which illustrated various laser and atomic interferometer designs covering $f tilde.eq 10^(- 6)$ to $10$~Hz@sesana-etal:2021@baibhav-etal:2021@sedda-etal:2021@bertoldi-etal:2021. We can also measure GW-induced motion of astrophysical bodies such as pulsars@NANOGrav:2020 @IPTA:2022 (rotating neutron stars emitting pulses of radio emission) and stars@moore-etal:2017 within our Galaxy to detect GW of $lambda tilde.eq$~tens of light-years ($10^(- 9)$~Hz). However, none of these techniques can be used to detect GW of $lambda tilde.eq$ tens of billions of light-years. We are therefore led to using the whole Universe as a detector: CMB polarisation.


The scalar mode does not produce $B$ modes at linear order in cosmological perturbation@seljak:1997. This makes $B$ modes a clean probe of the primordial GW@seljak-zaldarriaga:1997@kamionkowski-etal:1997b. See Supplementary Information for details on how GW produces $B$ modes.


== GW from the vacuum fluctuation in spacetime
<gw-from-the-vacuum-fluctuation-in-spacetime>


Statistical properties of the observed CMB temperature fluctuations and polarisation excited by the scalar mode agree well with the basic prediction of inflation driven by a single energy component@komatsu-etal:2014@Planck2018X Observation of the primordial tensor mode would give even stronger evidence for inflation.


What generated tensor modes during inflation? The leading idea is that they were generated by quantum-mechanical vacuum fluctuations in spacetime@grishchuk:1975 @starobinsky:1979.


To set the notation, we first review the power spectrum of tensor modes generated by the vacuum fluctuation. A distance between two events in inhomogeneous spacetime in the presence of tensor modes is given by $d s^2 = a^2 ( eta ) [- d eta^2 + sum_(i j) exp ( h )_(i j) d x^i d x^j] thin ,$ where $exp ( h )_(i j) = delta_(i j) + h_(i j) + ( 1 2 ) sum_k h_(i k) h_(k j) + dots.h$ is defined in Taylor series. Here, $h_(i j)$ is a $3 times 3$ symmetric real matrix with conditions: (1) $h_(i j)$ does not change a volume (otherwise it induces a change in density like the scalar mode), and (2) $h_(i j)$ is transverse, i.e., perpendicular to the propagation direction, just like an EM wave. The first condition demands the determinant of $exp ( h )_(i j)$ be unity: $det [exp ( h )_(i j)] = exp (sum_i h_(i i)) = 1$\; thus, $h_(i j)$ is traceless (1 condition). The second condition demands $sum_i k^i h_(i j) = 0$ where $k^i$ is a wave vector (3 conditions). We are left with $6 - 1 - 3 = 2$ physical degrees of freedom. If we take $k^i$ to be in the $z$ axis, we can write

$ h_(i j) = mat(delim: "(", h_(+), h_times, 0; h_times, - h_(+), 0; 0, 0, 0) thin. $<eq:pluscross>


Einstein's field equation for $h_(i j)$ at linear order is given by@weinberg:1972

$ square.stroked h_(i j) ( t , bold(x) ) = - 16 pi G a^(- 2) ( t ) T_(i j)^("t") ( t , bold(x) ) thin , $<eq:einstein>

where $G$ is the gravitational constant, $square.stroked equiv ( - g )^(-1/2) sum_(mu nu) partial partial x^mu (sqrt(- g) g^(mu nu) partial partial x^nu)$ the d'Alembert operator for a scalar field in curved spacetime with the Friedmann-Robertson-Walker metric tensor $g_(mu nu)$, and $T_(i j)^("t")$ the stress-energy source (the superscript 't' stands for tensor modes).


We define the expansion rate, $H ( t ) equiv dot(a) a$, where the dot denotes a time derivative. Integrating this, we find $a ( t ) prop exp [ integral H ( t' ) d t' ]$ and $a ( t )$ grows exponentially when $H$ varies slowly with $t$. Accelerated expansion demands $dot.double(a) a = dot(H) + H^2 > 0$, hence $- dot(H) H^2 < 1$. Defining a parameter, $epsilon.alt_H equiv - dot(H) H^2$, which characterises how slowly $H$ varies, inflation demands $epsilon.alt_H lt.double 1$@lyth-riotto:1999.


The vacuum fluctuation is a homogeneous solution to @eq:einstein with $T_(i j)^("t") = 0$. We calculate variance, $sum_(i j) chevron.l h_(i j)^2 ( t , bold(x) ) chevron.r$, to quantify the amplitude of tensor modes at a time $t$. The result is divergent because of the short-wavelength contribution, but we consider only the super-Hubble contribution, i.e., variance of a field smoothed over $H^(- 1)$. The calculation can be done by computing either a quantum-mechanical vacuum expectation value or an expectation value of a classical random field. They give the same answer: $ sum_(i j) chevron.l h_(i j)^2 ( t , bold(x) ) chevron.r & = 2 sum_(p = + , times) integral frac(d^3 k, ( 2 pi )^3) \| h_(p , k) ( eta ) \|^2\
 & tilde.eq integral frac(d k, k) 8 / M_("pl")^2 (frac(H, 2 pi))^2 thin , $ where@starobinsky:1979

$ h_(p , k) ( eta ) = i H / M_("pl") e^(- i k eta) / k^(3 / 2) (1 + i k eta) thin. $<eq:hp-solution>

We used the reduced Planck mass in units of $c = 1 = ℏ$, $M_("pl") = 1 / sqrt(8 pi G)$. See Supplementary Information for derivation of @eq:hp-solution.


Variance per logarithmic $k$ is independent of $k$, which is known as 'scale invariance'. This is the consequence of $H$ being (nearly) constant during inflation, $epsilon.alt_H lt.double 1$. In detail, weak time dependence of $H ( t )$ introduces weak $k$ dependence. Variance per logarithmic $k$ is often expressed in terms of the power spectrum $cal(P)_"t" ( k )$. It is common to write@weinberg:2008 $
 cal(P)_("t") ( k ) = A_("t") (k / k_(*))^(n_("t")) thin , quad A_("t") = 8 / M_("pl")^2 (frac(H ( t_(*) ), 2 pi))^2 thin , quad n_("t") = - 2 epsilon.alt_H thin \,
$ <eq:vacuum-predictions> where the subscripts 't' stand for tensor modes, $k_(*) = 0.05 "Mpc"^(- 1)$ is some reference wavenumber (1~Mpc is 3.26 million light-years), and $t_(*)$ is the time when $k_(*) = a ( t_(*) ) H ( t_(*) )$.


The amplitude of tensor modes is often parametrised by the so-called 'tensor-to-scalar ratio' parameter, $r$, defined by $r equiv A_("t") A_("s")$, where $A_("s")$ is the corresponding amplitude of scalar modes. The vacuum fluctuation yields $r = 16 epsilon.alt_H$@weinberg:2008. The scalar mode amplitude has been constrained precisely@Planck2018VI, $A_("s") tilde.eq 2.1 times 10^(- 9)$. The upper bound on $r$ from the current $B$-mode data is $r < 0.036$~(95%~C.L.)@BICEP:2021. This implies an upper bound on the tensor mode amplitude, $A_("t") < 7.6 times 10^(- 11)$, or $H ( t_(*) ) < 1.9 times 10^(- 5) M_("pl") tilde.eq 4.7 times 10^13$~GeV. Future detection of $r$ at this level implies new physics at an energy scale billion times as large as achieved at CERN's Large Hadron Collider.


The current bound on $r$ has ruled out many models of inflation@komatsu-etal:2014@Planck2018X A number of compelling models still remain, including one of the earliest models by Starobinsky@starobinsky:1980 (also see Ref.@nariai-tomita:1971). His model is based on a quantum correction to the Einstein-Hilbert action, $I = I_("GR") + ( 16 pi G )^(- 1) integral d^4 x sqrt(- g) R^2/(6 M^2)$, where $R$ is the Ricci scalar, $M$ is some characteristic energy scale, and $I_("GR") = ( 16 pi G )^(- 1) integral d^4 x sqrt(- g) R$ is the the Einstein-Hilbert action. This model is known as '$R^2$ inflation' and predicts $r = 12 N^2 tilde.eq 0.0046$ (for $N tilde.eq 51$), which is one order of magnitude smaller than the current bound. Here, $N$ is the number of $e$-folds of inflation for which $k_(*) = a ( t_(*) ) H ( t_(*) )$, counted from the end of inflation, i.e., $N = ln [a(t_("end"))/a(t_(*))] tilde.eq H ( t_("end") - t_(*) )$. This value of $r$ is considered as the next target for CMB experiments.


The same value of $r = 12 N^2$ is also predicted@komatsu-futamase:1999 by a model in which a real scalar field driving inflation $phi$ is coupled to the Ricci scalar non-minimally, $I = I_("GR") + integral d^4 x sqrt(- g) [xi phi^2 R/2 - ( partial phi )^2/2 - lambda phi^4/4]$@futamase-maeda:1987 with $xi gt.double 1$@fakir-unruh:1990 and $( partial phi )^2 equiv sum_(mu nu) g^(mu nu) ( partial phi partial x^mu ) ( partial phi partial x^nu )$. This model can be realised when the SM Higgs field is coupled to $R$ non-minimally@bezrukov-shaposhnikov:2008. See Refs.@spokoiny:1984@accetta-zoller-turner:1985@fakir-unruh:1990b for a similar construction in which $I_("GR")$ is absent.


After inflation, the primordial GW evolved according to @eq:einstein with $T_(i j)^("t")$ provided mostly by free-streaming neutrinos@weinberg:2004. The resulting energy density spectrum of GW in today's Universe is shown in @fig:omega_gw for $R^2$ inflation. The structures seen in the spectrum reflect various events in the early Universe@watanabe-komatsu:2006@saikawa-shirai:2018@kite-etal:2021b.


The tensor mode from quantum-mechanical vacuum fluctuations has three important, testable properties.

- The power spectrum is nearly scale invariant, with #emph[decreasing] power towards large $k$ with $n_("t") = - 2 epsilon.alt_H = - r 8 < 0$.

- The probability density function (PDF) is nearly Gaussian@maldacena:2003.

- As the right hand side of @eq:hp-solution does not depend on $p$, the amplitudes of $+$ and $times$ modes are equal; thus, there is no linear or circular polarisation of the primordial GW. No $C_ell^(E B)$ is generated.

Discovery of violation of any of these properties would lead to a new insight of the fundamental physics behind inflation.


Such observational tests have been performed extensively for scalar modes. We have confirmed that the statistical properties of CMB temperature fluctuations and polarisation from scalar modes are described by Gaussian statistics with high precision@WMAP-NG:2003 @komatsu:2010 @Planck2018IX. When writing the scalar-mode power spectrum as $cal(P)_"s" ( k ) = A_"s" ( k / k_(*) )^(n_"s" - 1 )$, we have found that the scalar mode is nearly, but not exactly, scale invariant with $n_("s") - 1 tilde.eq - 0.035$@WMAP:2013b @Planck2018VI, in agreement with $R^2$ inflation@mukhanov-chibisov:1981, Higgs inflation@komatsu-futamase:1999@bezrukov-shaposhnikov:2008, and many others. It is also consistent with $epsilon.alt_H lt.double 1$, as single-field inflation predicts $n_("s") - 1 = - 4 epsilon.alt_H - 2 delta_H$ with $delta_H equiv dot.double(H)/(2 H dot(H))$@weinberg:2008.


These results strongly support the idea that the observed cosmic structure grew out of quantum vacuum fluctuations generated during inflation. We must now perform the same tests for tensor modes to probe their origin.


== Vector field
<vector-field>


In the simplest model of inflation, accelerated expansion is driven by a single energy component such as a scalar field $phi$@lyth-riotto:1999. This does not mean that there were no other matter fields during inflation; on the contrary, matter fields must have existed to allow the energy density of $phi$ to be converted eventually to a plasma of SM particles after inflation. This process is called 'reheating'@lozanov:2019. In cosmology, we often call massive and massless particles 'matter' and 'radiation', respectively. We do not make such a distinction here and call all fields other than $phi$ 'matter fields' regardless of the mass of particles.


Matter fields can source tensor modes via the stress-energy tensor, $T_(i j)^("t")$, on the right hand side of Einstein's field @eq:einstein. The vacuum fluctuation is the homogeneous solution of this equation. We now discuss inhomogeneous solutions sourced by matter fields.


To calculate $T_(i j)$, we need a Lagrangian density of matter fields, $cal(L)_"m"$, in the action $
 I = I_("GR") + I_("inf" , phi) + integral d^4 x sqrt(- g) cal(L)_("m") thin \,
$ where $I_("inf" , phi)$ is the action for $phi$ driving inflation, e.g., $I_("inf" , phi) = integral d^4 x sqrt(- g) [- ( partial phi )^2 2 - V ( phi )]$ where $V ( phi )$ is $phi$'s potential. The stress-energy tensor is given by $
 T_(i j)^("m") = frac(- 2, sqrt(- g)) frac(delta ( sqrt(- g) cal(L)_("m") ), delta g^(i j)) thin.
$ To extract $T_(i j)^("t")$, which is transverse and traceless, we remove $g_(i j) T^("m") 3$ from $T_(i j)^("m")$ where $T^("m") = sum_(i j) g^(i j) T_(i j)^("m")$ is trace, and extract a component transverse to the wave vector in Fourier space.


For example, consider a massless free vector field, $A_mu$, like an EM field we discussed in the earlier sections on cosmic birefringence. The traceless component relevant for tensor modes is $T_(i j)^A - g_(i j) T^A 3 = - a^2 ( E_i E_j + B_i B_j ) + g_(i j) ( bold(E) dot.op bold(E) + bold(B) dot.op bold(B) ) 3$. It is important to realise that this is second order in perturbation when geometry of the background spacetime is isotropic. If a homogeneous vector field with a preferred direction exists, it breaks isotropy globally at the background level; thus, $bold(E)$ and $bold(B)$ must be a perturbation.


This result is generic. The so-called scalar-vector-tensor decomposition theorem states that scalar, vector, and tensor modes are decoupled and evolve independently of each other at first order in perturbation, when the background spacetime is homogeneous and isotropic@kodama-saaski:1984. Therefore, not only vectors but also scalar matter fields can source GW only at second order@tomita:1967@matarrese-mollerach-bruni:1998. There is a guaranteed lower bound for the amplitude of a stochastic background of GW sourced by the second-order scalar mode in the early Universe@ananda-clarkson-wands:2007@baumann-etal:2007. Additional scalar degrees of freedom during inflation@carney-etal:2012@cook-sorbo:2012@biagetti-fasiello-riotto:2013@senatore-silverstein-zaldarriaga:2014@cai-etal:2021 and other scenarios@martineau-brandenberger:2008@brandenberger-etal:2007a@brandenberger-etal:2007b can enhance the amplitude of GW. We refer the readers to a recent review article by Domènech@domenech:2021 for details on this rich subject.


Can we still find an interesting level of tensor modes from a massless free vector field? The answer is no, if all we have is a massless free field. As we saw already, a massless free vector field is conformally coupled to gravitation, with the equation of motion $A''_i + k^2 A_i = 0$\; thus, $A_i$ is oscillatory, and the EM fields decay as $bold(E) prop a^(- 2)$ and $bold(B) prop a^(- 2)$.


The situation changes dramatically when we include the CS term given in @eq:CS. What is $chi$ in this context? It can be the field driving inflation with an action $I = I_("GR") + I_("inf" , chi) + I_A + I_("CS")$@anber-sorbo:2010 or an additional 'spectator' field whose energy density is negligible compared to $phi$ with an action $I = I_("GR") + I_("inf" , phi) + I_chi + I_A + I_("CS")$@barnaby-etal:2012. Here, $bold(E)$ and $bold(B)$ need not be the SM EM fields; most likely they are not because of many theoretical challenges and constraints on generation of astrophysically interesting EM fields during inflation@ratra:1992@demozzi-mukhanov-rubinstein:2009@barnaby-namba-peloso:2012@maleknejad-sheikh-jabbari-soda:2013@kobayashi-afshordi:2014. We thus assume that $bold(E)$ and $bold(B)$ are some new vector fields present during inflation.


The equation of motion for $A_i$ is given by @eq:vectorequation. As the scale factor is given by $a ( eta ) tilde.eq - ( H eta )^(- 1)$ for $- oo < eta < 0$ during inflation, we obtain

$ A''_plus.minus + [k^2 minus.plus frac(2 k xi, ( - eta ))] A_plus.minus = 0 thin , $<eq:vectorequation2>

where $xi equiv alpha dot(chi) ( 2 f H )$@anber-sorbo:2010. We take $alpha dot(chi) > 0$ (hence $xi > 0$) without loss of generality. Then, the effective frequency squared, $omega_plus.minus^2 = k^2 minus.plus 2 k xi / ( - eta )$, can become negative for the $+$ state, and the mode function is amplified during inflation. The exact solution that matches a positive frequency mode deep in the short-wavelength regime, $k \| eta \| gt.double 1$, can be obtained when $xi$ varies slowly with $t$, and is given by Whittaker's function@barnaby-pajer-peloso:2012. The amplified vector field sources tensor modes via $square.stroked h_(i j) = 16 pi G ( E_i E_j + B_i B_j )^("TT")$, where the subscript 'TT' indicates a transverse and traceless component. As the tensor mode is sourced by product of two perturbations, it is highly non-Gaussian@anber-sorbo:2012@namba-etal:2016@shiraishi-etal:2016.


The resulting power spectrum is #emph[chiral], i.e., the amplitudes of right- and left-handed polarisation states of GW are different. For GW propagating in the $z$ axis, we define right- and left-handed states (helicity $+ 2$ and $- 2$ respectively) as $h_("R") = ( h_(+) - i h_times )/sqrt(2)$ and $h_("L") = ( h_(+) + i h_times )/sqrt(2)$. The corresponding power spectra are given by@sorbo:2011@barnaby-namba-peloso:2011 $
 cal(P)_("t,R") &tilde.eq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + 8.6 times 10^(-7) frac(H^2, M_"pl"^2) frac(e^(4 pi xi), xi^6)],
$ <eq:PRu1> $
 cal(P)_("t,L") &tilde.eq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + 1.8 times 10^(-9) frac(H^2, M_"pl"^2) frac(e^(4 pi xi), xi^6)],
$ <eq:PLu1> The first term in the square bracket is the vacuum contribution. Adding them reproduces the vacuum result given in  @eq:vacuum-predictions: $cal(P)^("vac")_("t,R") + cal(P)^("vac")_("t,L") = (8/M_"pl"^2)(H/(2 pi))^2$. The second terms differ by more than two orders of magnitude, i.e., chiral GW. We can probe this by measuring the $E B$ power spectrum of CMB polarisation data@lue-wang-kamionkowski:1999@sorbo:2011 as well as circular polarisation of GW using laser interferometers@seto:2006@seto-taruya:2007@crowder-etal:2012.


As $B$ modes from primordial GW are yet to be found, the current $E B$ data do not constrain the parameter space of this model. If GW were found, the lack of detection of $E B$ would constrain the parameter space; however, if GW were not found, the lack of $E B$ would not mean much. Conversely, if GW were not found but $E B$ were found, it would point towards a different mechanism for $E B$, such as cosmic birefringence.


For the vacuum contribution, the scale-dependence of $cal(P)_"t"$ was given by weak time dependence of $H ( t )$, resulting in the decreasing power at large $k$ with $n_("t") = - 2 epsilon.alt_H < 0$. For the sourced contribution, additional scale-dependence is given by weak time dependence of $xi ( t ) prop dot(chi) H$. Depending on the potential for $chi$, $dot(chi) H$ can increase during inflation ($chi$ speeds up as it rolls down on its potential $V ( chi )$), which results in #emph[increasing] power at large $k$@cook-sorbo:2012@barnaby-pajer-peloso:2012.


The amplified vector field sources not only tensor modes, but also scalar modes via $square.stroked chi - partial V partial chi = - ( alpha f ) bold(E) dot.op bold(B)$@anber-sorbo:2010. This scalar mode is highly non-Gaussian@barnaby-peloso:2011. As there is no evidence for scalar-mode non-Gaussianity in the CMB data@WMAP-NG:2003 @komatsu:2010 @Planck2018IX, the model producing a sizable primordial GW in the scales relevant to CMB is highly constrained if $chi$ is the field driving inflation@barnaby-peloso:2011@barnaby-namba-peloso:2011. The constraint is lessened when $chi$ is an additional spectator field coupled to $phi$ only gravitationally@barnaby-etal:2012@cook-sorbo:2013@namba-etal:2016. A significant amount of GW can still be produced at interferometer scales (@fig:omega_gw) without violating the CMB constraint on scalar non-Gaussianity@barnaby-pajer-peloso:2012@bartolo-etal:2016.


To summarise, the tensor mode sourced by the vector field, which is amplified by the CS term, violates #emph[all] of the three properties of the vacuum contribution: it produces non-scale-invariant, non-Gaussian, and chiral primordial GW. Such observational tests open a completely new window into the particle physics of inflation.


== Non-Abelian gauge field
<non-abelian-gauge-field>


Scalar and vector matter fields can source tensor modes only at second order, when the background spacetime is homogeneous and isotropic. As there is no evidence for statistical anisotropy in the #emph[Planck] data@kim-komatsu:2013, we assume isotropic geometry. Is there a matter field which can source tensor modes at linear order without breaking isotropy?


The answer is yes: it is a non-Abelian gauge field with SU(2) symmetry, $bold(A)_mu$. The vector field example in the previous section can be regarded as an Abelian gauge field with U(1) symmetry.


In 2011, Maleknejad and Sheikh-Jabbari discovered a new class of homogeneous and isotropic inflationary solutions with $bold(A)_mu$, which they called 'Gauge-flation'@maleknejad-sheikh-jabbari:2011@maleknejad-sheikh-jabbari:2013. As a massless free gauge field is conformally coupled, they broke conformal invariance by adding a term $cal(L)_"Gf" = kappa ( F tilde F )^2 / 96$ to the Lagrangian density ($kappa$ is a constant). Here, the CS term is $F tilde(F) = sum_(a = 1)^3 sum_(mu nu) F_(mu nu)^a sum_(mu' nu') frac(epsilon.alt^(mu nu mu' nu'), 2/sqrt(- g)) F_(mu' nu')^a thin ,$ where $F_(mu nu)^a = frac(partial A_nu^a, partial x^mu) - frac(partial A_mu^a, partial x^nu) + g_A sum_(b = 1)^3 sum_(c = 1)^3 epsilon.alt^(a b c) A_mu^b A_nu^c thin ,$ with $bold(A)_mu = sum_a A_mu^a bold(sigma)_a 2$ and $bold(sigma)_a$ ($a = 1 , 2 , 3$) being the Pauli matrices. The self-coupling constant is $g_A$.


The Maleknejad-Sheikh-Jabbari solution is characterised by a homogeneous and isotropic vacuum expectation value for $A_i^a = a ( t ) Q ( t ) delta_i^a$ and $A_0^a equiv 0$. Imagine three vectors: $A_i^1$, $A_i^2$ and $A_i^3$, which align with the three axes of Cartesian coordinates such that there is no preferred direction. This configuration can be rotated by an arbitrary 3-rotation, breaking isotropy. However, we can always find a global SU(2) transformation which cancels the 3-rotation, restoring isotropy. The fundamental reason for this behaviour is that the adjoint representation of SU(2) is isomorphic to SO(3), i.e., symmetry group of 3-rotation.


In 2012, Adshead and Wyman found the same result using another action, which they called 'Chromo-natural inflation'@adshead-wyman:2012, $I = I_("GR") + I_("inf" , chi) + I_A + I_("CS")$, with a cosine potential typical for axionlike fields, $V ( chi ) = mu^4 [ 1 + cos ( phi f ) ]$@freese-frieman-olinto:1990. This action is similar to that of the vector field (Abelian gauge field) example discussed in the previous section but with $F^2$ and $F tilde(F)$ computed for SU(2). It was then found that the Gauge-flation action with $kappa = 3 alpha^2 mu^4$ could be obtained from the Chromo-natural one by integrating out $chi$ near the minimum of its potential@adshead-wyman:2012b@sheikh-jabbari:2012 They therefore share similar phenomenology@maleknejad-sheikh-jabbari-soda:2013. Possible embedding of this model in a more fundamental theory is discussed in Refs.@dallagata:2018@mcdonough-alexander:2018@agrawal-fan-reece:2018@holland-zavala-tasinato:2020.


The SM weak interaction acts on left-handed fermions. Recently, Maleknejad embedded the above SU(2) field in the right-handed sector of weak interaction in the so-called left-right symmetric extension of SM@maleknejad:2020b @maleknejad:2021 Her model has a rich phenomenology not only for the primordial GW from inflation but also for dark matter and the origin of matter-anti matter asymmetry.


The isotropic solution of Gauge-flation/Chromo-natural inflation is an attractor: even if spacetime geometry of the Universe was highly anisotropic initially, it approaches the isotropic solution@maleknejad-erfani:2014@wolfson-maleknejad-komatsu:2020@wolfson-etal:2021. Isotropy is broken when $A_i^a$ is allowed to acquire different mass $m_a$ depending on $a$. When a mass term is added to the Lagrangian density, $m_a^2 A_mu^a A_nu^a g^(mu nu) 2$, anisotropic solutions can exist for $m_1 eq.not m_2 = m_3$@adshead-liu:2018.


Expanding $A_mu^a$ around the vacuum expectation value, we write $A_i^a ( t , bold(x) ) = a ( t ) Q ( t ) delta_i^a + delta A_i^a ( t , bold(x) )$. The perturbation contains 1 tensor, 2 vector, and 3 scalar modes, $delta A_i^a = t_(a i) + dots.h$, where $t_(a i)$ is transverse and traceless (tensor mode) and '$dots.h$' contains scalar and vector modes@maleknejad-sheikh-jabbari:2011@maleknejad-sheikh-jabbari:2013. The stress-energy tensor consists of the background and perturbed parts, $T_(i j)^A = macron(T)_(i j)^A + delta T_(i j)^A$. There was no background part in the Abelian case. The perturbed stress-energy tensor for $t_(a i)$ is $ delta T_(i j)^("t") = - & 2 / a frac(d ( a Q ), d t) t'_(i j) + 2 g_A Q^2 #scale(x: 180%, y: 180%)[{] g_A ( a Q ) t_(i j)\
 & - 1 / 2 [sum_(a b) epsilon.alt^(i b a) frac(partial t_(a j), partial x^b) + ( i arrow.l.r j )]} thin. $ This is linear in $t_(i j)$, as promised.


When tensor modes propagate in the $z$ axis, we can define $+$ and $times$ modes in the same way as for GW ( @eq:pluscross as well as left- and right-handed states, $t_L = ( t_(+) + i t_times )/sqrt(2)$ and $t_R = ( t_(+) - i t_times )/sqrt(2)$. Then, we find the stress-energy tensor for $t_R$ and $t_L$ in Fourier space as $delta T_(R L)^("t") = - 2 / a frac(d ( a Q ), d t) t'_(R L) + 2 g_A Q^2 (g_A a Q t_(R L) minus.plus k_3 t_(R L)) thin ,$



 equation


where the minus and plus signs are for the $R$ and $L$ modes, respectively.


Symmetry permits us to generalise this result for arbitrary propagating directions by replacing $k_3$ with $k$. Right/left-handed GW are sourced linearly by $t_(R L)$ in $delta T_(R L)^("t")$, respectively.


The equations of motion for $t_R$ and $t_L$ are@adshead-martinec-wyman:2013@dimastrogiovanni-peloso:2012@maleknejad-sheikh-jabbari-soda:2013 $
 t''_(R \/ L) + [k^2 + 2 / eta^2 (m_Q xi minus.plus ( - k eta ) ( m_Q + xi ))] t_(R \/ L) \
  = cal(O) ( h_(R \/ L) ) thin \,
$



 equation


where the minus and plus signs are for the $R$ and $L$ modes, respectively. Here, $xi = alpha dot(chi) ( 2 f H )$ is the same as in the Abelian case, while $m_Q equiv g_A Q H$ is unique to the SU(2) case because it has the self-coupling constant $g_A$. The right hand side contains $h_(L R)$, which we can ignore. Notice the minus sign in front of $- k eta$ for $t_R$\; this signals amplification again, just like for the Abelian case. For $xi > 0$, $t_R$ is amplified when $sqrt(2) ( - 1 + sqrt(2) ) m_Q < - k eta < sqrt(2) ( 1 + sqrt(2) ) m_Q$, i.e., $0.6 m_Q < - k eta < 3.6 m_Q$. The solution that matches a positive frequency mode deep in the short-wavelength regime is given by Whittaker's function when $xi$ and $m_Q$ vary slowly.


Just like for the Abelian case given in  @eq:PRu1 and @eq:PLu1, the resulting power spectrum is chiral: $
 cal(P)_"t,R/L" tilde.eq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + frac(Q^2, 2 M_"pl"^2) |cal(G)_(R/L)(m_Q)|^2 e^(pi (m_Q + xi))],
$ where $cal(G)_(R / L )$ is given in Appendix E of Ref.@maleknejad-komatsu:2019. It suffices to say $\| cal(G)_(R ) \|^2 "gg" \| cal(G)_(L ) \|^2$ for $xi > 0$.


During inflation $xi tilde.eq m_Q + m_Q^(- 1)$ and a successful phenomenology requires $sqrt(2) < m_Q lt.tilde "a few"$@dimastrogiovanni-peloso:2012@adshead-martinec-wyman:2013b. The basic phenomenology is similar to the Abelian case discussed earlier: depending on the potential for $chi$, weak time dependence of $m_Q$ and $xi$ can make $cal(P)_"t"$ increase towards large $k$. The sourced GW is chiral, yielding non-vanishing $C_ell^(E B)$ for CMB experiments and circularly polarised GW for interferometers@thorne-etal:2018. For the Abelian case, the sourced GW was highly non-Gaussian because it was sourced at second order in EM fields. For the SU(2) case, it is highly non-Gaussian because of the self-coupling of gauge fields@agrawal-fujita-komatsu:2018@agrawal-fujita-komatsu:2018b@dimastrogiovanni-etal:2018@fujita-namba-obata:2019@fujita-etal:2022. Thus, GW sourced by the SU(2) gauge field again violates all of the three properties of the vacuum contribution. This makes a strong case for observational tests of these properties, once the primordial GW is discovered in $B$-mode polarisation or other techniques shown in @fig:omega_gw.


The action may contain the so-called 'gravitational Chern-Simons (GCS) term', $chi R tilde(R)$@alexander-yunes:2009, which also induces parity-violating correlations in the CMB data@lue-wang-kamionkowski:1999@saito-ichiki-taruya:2007@contaldi-magueijo-smolin:2008. When considered simultaneously with $I_("CS")$, the impact of GCS is minor@mirzagholi-etal:2020, justifying our ignoring this term in this section.


Production of GW by the SU(2) gauge field is so efficient that the original Gauge-flation and Chromo-natural inflation models have been ruled out by upper bounds on $B$ modes@adshead-martinec-wyman:2013b@namba-dimastrogiovanni-peloso:2013. The model can be made compatible with observational data by modifying $chi$'s potential@maleknejad:2016@caldwell-devulder:2018 or kinetic term@watanabe-komatsu:prep\; making $chi$ a spectator field@dimastrogiovanni-fasiello-fujita:2016@iarygina-sfakianakis:2021\; giving mass to the gauge field via a Higgs-like mechanism@nieto-rodriguez:2016@adshead-etal:2016@adshead-sfakianakis:2017\; delaying the onset of the Chromo-natural inflation phase so that GW is not produced at the CMB scale but at higher frequencies@obata-miura-soda:2015@obata-soda:2016@domcke-etal:2019b, etc.


Here we show $cal(P)_"t"$ of the spectator model@dimastrogiovanni-fasiello-fujita:2016 with an action $I = I_("GR") + I_("inf" , phi) + I_chi + I_A + I_("CS")$. The detailed shape of $cal(P)_"t"$ is determined by time evolution of $m_Q$ and $xi$. For a cosine potential, $chi$ speeds up initially, reaches the maximum velocity at the inflection point of the potential $chi ( t_(*) ) = pi f 2$, and slows down. The sourced tensor-mode power spectrum has a peak at the wavenumber $k_("p")$ that corresponds to $chi ( t_(*) )$@thorne-etal:2018 $
 cal(P)^"source"_("t,R")(k) = r_(* ) cal(P)_("s")(k) exp(-frac(1, 2 Sigma^2) ln^2 (frac(k, k_"p"))),
$ where $r_(*)$ is the tensor-to-scalar ratio at $k = k_("p")$, $cal(P)_("s")(k)$ is the scalar-mode power spectrum, and $Sigma$ characterises the width of the peak. Other shapes are possible for other forms of $V ( chi )$@fujita-sfakianakis-shiraishi:2019. In terms of the model parameters, we write $m_(*) equiv m_Q ( t_(*) ) = (g_A^2 mu^4 / (3 alpha H^4))^(1/3)$, $xi_(*) tilde.eq m_(*) + m_(*)^(- 1)$, $Sigma^2 = (alpha/(2 xi_(*)))^2 / [2 cal(I)(m_(*))]$, and $cal(I) ( m_(*) ) tilde.eq 0.666 + 0.81 m_(*) - 0.0145 m_(*)^2 - 0.0064 m_(*)^3$.


In @fig:omega_gw, we show $Omega_("GW")$ computed from the 'AX2' ($r_(*) = 0.15$, $k_("p") = 10^11 "Mpc"^(- 1)$, $Sigma = 8$) and 'AX3' ($r_(*) = 50$, $k_("p") = 10^6 "Mpc"^(- 1)$, $Sigma = 4.8$) models given in Ref.@campeti-etal:2021. We use $cal(P)_"s" = A_"s" ( k / k_(*) )^(n_"s" - 1 )$ but other forms are possible at larger $k$ than constrained precisely by CMB observations. The shapes of $Omega_("GW")$ are completely different from that of the vacuum contribution and distinguishable not only in the CMB polarisation data sets@LiteBIRD:2022, but also in the other data sets@campeti-etal:2021. Measuring the shape of $Omega_("GW")$ across 21 decades in frequency promises a breakthrough in our understanding of the fundamental physics behind inflation.


In @fig:requirement, we show the $B$-mode power spectrum computed from another choice of axion-SU(2) parameters: $r_(*) = 0.023$, $k_("p") = 3.4 times 10^(- 4) "Mpc"^(- 1)$, and $Sigma = 1.1$ (P. Campeti, private communication), which is added to the vacuum contribution of $R^2$ inflation. This parameter was chosen such that the sourced GW enhances the reionisation bump at $ell lt.tilde 10$ significantly compared to the vacuum contribution, while satisfying constraints from backreaction discussed below. We also show the 68%~C.L. intervals of ideal experiments with full-sky coverage and noise much below the lensed $B$ modes (i.e., $lt.double 5 mu$K~arcmin). In this case, they can be treated effectively as noiseless experiments. We find that the sourced contribution is clearly detectable over the vacuum contribution, if we have access to low multipoles, i.e., full-sky coverage by a satellite mission such as #emph[LiteBIRD]. While no foreground contamination or instrumental systematics was included in the uncertainty here, more detailed analysis including them reached the same conclusion@LiteBIRD:2022.


// vision: This is a log-log line plot of B-mode power spectrum versus multipole. The y-axis shows B-mode Power Spectrum [μK²] from 0.00003 to 0.3; the x-axis shows multipole ℓ from 2 to 2000. Seven legend entries are shown: solid blue line "GW: Vacuum R² Inflation (r = 0.0046)", dotted yellow line "GW: SU(2) + R² Inflation", dotted red line "Cosmic Birefringence (β = 0.3 deg)", green circles with shaded band "New Physics Total", grey line "Lensed B mode", yellow circles "SPTpol", and magenta circles "BICEP/Keck Array". The blue vacuum curve sits near 10⁻⁴ μK² at low ℓ and falls at high ℓ; the red dotted birefringence curve rises steadily.
// [figvision-cn] imgs/fig5.png
// 该图为对数-对数坐标曲线图，展示了B模式极化功率谱随多极
// 矩的变化。横坐标为“Multipole, l”，表示多极矩，范围从2
// 到2000，刻度标记包括2、10、30、80、200、500、1000、
// 2000；纵坐标为“B-mode Power Spectrum [μK²]”，表示B模式
// 功率谱，单位为微开尔文平方，范围从0.00003到0.3，刻度标
// 记包括0.00003、0.0003、0.003、0.03、0.3。 图中包含多条
// 曲线和散点数据： 蓝色实线代表“GW: Vacuum R² Inflation
// (r = 0.0046)”，即真空R²暴胀模型产生的引力波贡献，其功
// 率谱在低l值（约2至10）处约为0.0001 μK²，随后下降，在l≈
// 100后迅速衰减至低于0.00003 μK²。 橙色点线代表“GW: SU(2
// ) + R² Inflation”，即在真空暴胀基础上加入SU(2)规范场源
// 项的贡献，其趋势与蓝色实线相似但在高l区域略有抬升，尤
// 其在l>1000时略高于蓝色曲线。 红色虚线代表“Cosmic
// Birefringence (β = 0.3 deg)”，即宇宙双折射效应（旋转角
// β=0.3度）的贡献，该曲线仅在l>30区域出现，从l≈40开始上
// 升，在l≈200达到峰值约0.0003 μK²，之后缓慢下降。 绿色填
// 充圆圈及其周围浅绿色带状区域代表“New Physics Total”，
// 即上述三种新物理效应的总和，并已在以特定中心l值划分的
// 区间内平均处理。该曲线在l<10时主导，数值约0.0003–0.001
// μK²；在l≈10–100之间降至最低点约0.00005 μK²；在l>100后
// 再次上升，在l≈500–1000间形成多个振荡峰，峰值达0.003 μK
// ²以上；在l>1000后逐渐下降。 灰色实线代表“Lensed B mode
// ”，即由引力透镜效应产生的B模式功率谱，已作为背景被减去。
// 该曲线从l≈10开始线性上升（在对数坐标下呈直线），在l=
// 200时约0.003 μK²，在l=1000时约0.03 μK²，在l=2000时接近
// 0.1 μK²。 黄色空心圆圈带误差棒代表SPTpol实验观测数据，
// 分布在l≈200至2000区间，数值从约0.003上升至0.1左右，误
// 差棒显示测量不确定性。 品红色实心圆带误差棒代表BICEP/
// Keck Array实验观测数据，主要位于l≈30至200区间，数值从
// 约0.002上升至0.03，误差棒较大，反映当前观测限制。 所有
// 理论曲线均叠加在同一坐标系中，用于比较不同物理机制对B
// 模式功率谱的贡献及与观测数据的吻合程度。绿色总和新物理
// 曲线在大部分l范围内与观测数据（黄圈和品红圈）有较好重
// 叠，表明该模型能解释当前观测结果。灰色透镜B模式曲线在
// 高l区占主导，说明在大尺度上需扣除透镜效应才能提取原始
// 信号。
#figure(scope: "parent", placement: auto, image("imgs/fig5.png", width: 100%),
 caption: [
 #strong[$B$-mode polarisation power spectra.] We show $ell ( ell + 1 ) C_ell^(BB) 2 pi$ in units of $mu "K"^2$ from cosmic birefringence with $beta = 0.3^compose$ (red dashed) and a sourced GW from SU(2) gauge fields added to the vacuum contribution of $R^2$ inflation (orange dashed). The green filled circles show the sum of these contributions, which are averaged over multipoles in bins centered at $ell$ as shown. The lensed $B$-mode power spectrum (grey solid) is subtracted. The bands indicate the 68%~C.L. intervals assuming full-sky and noiseless experiments (the lensed $B$-mode contribution is included in the intervals). The blue solid line shows the vacuum contribution alone. The data points of SPTpol@sayre-etal:2020 and BICEP/Keck Array@BICEP:2021 are the same as in @fig:cl.
 ]
)
<fig:requirement>


Observations of non-Gaussianity of $B$ modes would not only be revolutionary, but also place useful constraints on the parameter space of the sourced GW@agrawal-fujita-komatsu:2018@agrawal-fujita-komatsu:2018b. The prospects for detecting $E B$ from chiral GW used to be good when a large $r$ was allowed@saito-ichiki-taruya:2007@thorne-etal:2018. While the current upper bound on $r$ from the recombination bump at $ell tilde.eq 80$ (@fig:cl)@BICEP:2021 is making this measurement a challenge, there is still a room for a detectable $E B$ signal in the reionisation bump.


In @fig:requirement, we also show the $B$-mode power spectrum from cosmic birefringence, $C_ell^(BB , "o") = sin^2 ( 2 beta ) C_ell^(E E)$, with $beta = 0.3^compose$. This contribution dominates at $ell gt.tilde 200$, which is accessible to ground-based observatories such as CMB Stage-4. The synergy of space-borne and ground-based experiments in the quest for new physics is obvious.


The presence of a strong EM field creates pairs of electrons and positrons via the so-called Schwinger process@schwinger:1951 Similar phenomena occur here: the background $chi$ and gauge fields create a copious amount of particles coupled to either or both of them, such as charged scalar@lozanov-maleknejad-komatsu:2019, massless@domcke-etal:2019 and massive@mirzagholi-makeknejad-lozanov:2020@maleknejad:2020 fermions, and spin-2 particles@maleknejad-komatsu:2019. When the energy and momentum densities of the produced particles become large, they give 'backreaction' to the background equations of motion for $chi$ and gauge fields, potentially spoiling phenomenological success of the model@dimastrogiovanni-fasiello-fujita:2016@fujita-namba-tada:2018.


Ishiwata et al.@ishiwata-komatsu-obata:2022 analysed the backreaction of spin-2 particles in detail, finding that the sourced GW can exceed the vacuum contribution by many orders of magnitude without spoiling dynamics of the background $chi$ and gauge fields. The enhancement of GW at high frequencies shown in @fig:omega_gw is therefore allowed.


In the GW frequency measured by CMB experiments, the additional constraints on $P_("s") tilde.eq 2.1 times 10^(- 9)$ and $r < 0.036$ allow the sourced GW to exceed the vacuum contribution by more than an order of magnitude.


While scalar modes in $delta A_i^a$ are not excited for $m_Q > sqrt(2)$@dimastrogiovanni-peloso:2012@adshead-martinec-wyman:2013b, tensor modes can source scalar modes at second order@papageorgiou-peloso-unal:2018@papageorgiou-peloso-unal:2019. Such non-linearly sourced scalar modes not only modify $P_("s") ( k )$ but also add non-Gaussian fluctuations which are strongly constrained by the #emph[Planck] temperature anisotropy data@Planck2018IX. This effect would constrain viable parameter space of the model in the GW frequency measured by CMB experiments further. The detailed analysis is yet to be done, though the sourced and vacuum contributions can still be comparable. In particular, the former can exceed the latter by a factor of 5 at low multipoles, $ell lt.tilde 10$ where the constraint on the scalar mode is not strong@ishiwata-komatsu-obata:2022. The $B$-mode power spectrum at such low multipoles will be measured by the #emph[LiteBIRD] mission@LiteBIRD:2022.


The above phenomenology is valid when extended to SU($N$), provided that it contains SU(2) as a subgroup@caldwell-devulder:2018@holland-zavala-tasinato:2020@fujita-etal:prep. Can $bold(A)_mu$ be the SM SU(2) gauge field? It is possible, though $chi$ coupled to the CS term is beyond SM. It is also possible that $chi$ couples to the SM particles, as in the Peccei-Quinn solution to the strong #emph[CP] problem in QCD@peccei-quinn:1977@weinberg:1978 @wilczek:1978.


= Outlook
<outlook>


Sensitivity of polarisation to new physics that violates parity symmetry offers exciting opportunities for discovery, which may tell us the fundamental physics behind dark matter, dark energy, and cosmic inflation. The science topics described in this article may shed new light on the way polarisation data from on-going@adachi-etal:2020@adachi-etal:2020b@aiola-etal:2020@sayre-etal:2020@dutcher-:2021@BICEP:2021 @SPIDER:2022@dahal-etal:2022 and future CMB experiments@SimonsObservatory:2019 @SPO:2020 @CMB-S4:2019 @LiteBIRD:2022 are obtained, calibrated, and analysed.


Searching for new physics requires new strategy. Efforts to discover the $B$-mode power spectrum from primordial GW are endorsed strongly by American National Academies's #emph[Decadal Survey on Astronomy and Astrophysics 2020] (Astro2020), and currently drive requirements for design of future experiments@kamionkowski-kovetz:2016. However, do they also satisfy requirements for the $E B$ science and tests of Gaussianity of $B$ modes?


Miscalibration of polarisation-sensitive orientations of detectors on the focal plane of a telescope with respect to the sky as well as cross-polarisation coupling induced by systematics of beam @hu-hedman-zaldarriaga:2003@rosset-etal:2007@odea-etal:2007@shimon-etal:2008 and optical components such as half-wave plates@bao-etal:2012@duivenvoorden-etal:2021@giardiello-etal:2021 yield $alpha$, hence a spurious $B$-mode power spectrum, $C_ell^(BB , "o") = sin^2 ( 2 alpha ) C_ell^(E E)$. Reducing this to sufficiently small level required for the $B$-mode science sets a requirement for $alpha$, which is below $0.2^compose$@abitbol-etal:2021 or even below $0.1^compose$@vielva-etal:prep (see @fig:requirement for $B$ modes of $0.3^compose$). Achieving this in practice is a significant challenge, and the CMB community often calibrates $alpha$ using $C_ell^(E B , "o")$, assuming null cosmological signals@keating-shimon-yadav:2012@RAC:2022. This obviously compromises our ability to search for new parity-violating physics, which has a hint of $beta tilde.eq 0.3^compose$, well above the requirement. This example clearly calls for innovation in the calibration strategy@johnson-etal:2015@kaufman-keating-johnson:2016@nati-etal:2017@casas-etal:2021.


When such precision is achieved for the angle calibration, we no longer have to rely on the Galactic foreground for measuring $alpha$. The current measurement sets a requirement for precision: $plus.minus 0.05^compose$ (i.e., $plus.minus 3'$) would yield a secure $> 5 sigma$ detection of $beta tilde.eq 0.3^compose$. As the statistical uncertainty on $beta$ expected from $E B$ data of future experiments is smaller@pogosian-etal:2019, the measurement will be limited by the calibration uncertainty.


Innovation is required not only for the calibration strategy, but also for the analysis technique. The techniques established for confirming the basic predictions of inflation - Gaussian statistics and nearly but not exactly scale-invariant power spectrum of scalar modes - should be developed for tensor modes@shiraishi:2019@duivenvoorden-meerburg-freese:2020@hiramatsu-etal:2018@campeti-poletti-baccigalupi:2019. Such tests are necessary for distinguishing between different origins of the primordial GW, i.e., quantum vacuum fluctuations in spacetime and GW sourced by matter fields during inflation. Equally important is the need for high-fidelity end-to-end simulations@PlanckIntLVII, with the $E B$ science and tests of Gaussianity in mind.


Last but not least, measuring the spectrum and polarisation of the stochastic background of GW across 21 decades in frequency (@fig:omega_gw) sets an ambitious goal for ultimate tests of our ideas about the origin of the Universe. Such a research direction is in line with one of the three Large Mission science themes, '#emph[New Physical Probes of the Early Universe]', of the ESA Science Programme #emph[Voyage 2050]. Let's find new physics!


= Acknowledgements
<acknowledgements>
This article is dedicated to the memory of Steven Weinberg. We thank P. Campeti for sharing his work on the axion-SU(2) model, and J. Chluba, G. Domènech, G. Dvali, J.~R. Eskilt, K. Lozanov, A. Maleknejad, Y. Minami, I. Obata, and M. Shiraishi for comments on the draft. We also thank anonymous referees for comments, which helped improve the presentation of the article. The materials in this article are based partly on the Van der Waals Lecture delivered at the University of Amsterdam in 2020. We thank the institutes of Physics and Astronomy at the University of Amsterdam and the Vrije Universiteit Amsterdam for their hospitality, and the Stichting Van der Waals Fonds for the Johannes Diderik van der Waals rotating chair which enabled the visit. This work was also supported in part by JSPS KAKENHI Grants No.~JP20H05850 and No.~JP20H05859, and the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany's Excellence Strategy - EXC-2094 - 390783311. This work has also received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No.~101007633. The Kavli IPMU is supported by World Premier International Research Center Initiative (WPI), MEXT, Japan.


= Competing interests
<competing-interests>


The author declares no competing interests.


= Publisher's note
<publishers-note>
Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.


= Supplementary information
<supplementary-information>


== Vacuum fluctuation in spacetime
<vacuum-fluctuation-in-spacetime>


We quantise the tensor metric perturbation, $h_(i j)$, in vacuum. As the $+$ and $times$ modes evolve independently in vacuum, we write $square.stroked h_p = 0$ ($p = + , times$). This equation takes the same form as the Klein-Gordon equation for a massless free field; thus, we can quantise $h_p$ following the standard procedure@ford-parker:1977@birrell-davies:1984@mukhanov-feldman-brandenberger:1992. We do not need full theory of quantum gravity here; we are only quantising #emph[fluctuations] in spacetime at linear order given the (classical) background spacetime.


With the conformal time $eta$, the d'Alembert operator for a scalar field in the Friedmann-Robertson-Walker spacetime is given by $a^2 square.stroked = - partial^2 partial eta^2 - 2 ( a' a ) partial partial eta + nabla^2$. Going to Fourier space, $h_p ( eta , bold(x) ) = ( 2 pi )^(- 3 2) integral d^3 bold(k) h_(p , bold(k)) ( eta ) e^(i bold(k) dot.op bold(x))$, and defining a convenient new variable, $u_(p , bold(k)) ( eta ) = C a ( eta ) h_(p , bold(k)) ( eta )$, where $C$ is a constant to be specified later, we write the equation of motion as@lifshitz:1946 @grishchuk:1975

$ u''_(p , bold(k)) + [k^2 + m_("eff")^2 ( eta )] u_(p , bold(k)) = 0 thin. $<eq:meff>

Here $m_("eff")^2 ( eta )$ is a time-dependent effective mass-squared defined by $m_("eff")^2 equiv - a'' a = - a^2 H^2 ( 2 - epsilon.alt_H )$. Such a term did not appear in the equation of motion for $bold(A)$ because of conformal invariance. Here we see that $u_p$ is not conformally invariant@grishchuk:1975.


As $epsilon.alt_H lt.double 1$ during inflation, $m_("eff")^2$ is actually #emph[negative]. The solution is divided into two regimes: (1) Super-Hubble regime ($k lt.double \| m_("eff") \| tilde.eq sqrt(2) a H$) and (2) Sub-Hubble regime ($k gt.double/sqrt(2) a H$). The former is a long-wavelength solution, whose physical wavelength is much greater than the Hubble length, $lambda gt.double H^(- 1)$. The latter is a short-wavelength solution.


The sub-Hubble solution is oscillatory, $u_(p , bold(k)) prop e^(plus.minus i k eta)$, so GW decays as $h_(p , bold(k)) prop a^(- 1) e^(plus.minus i k eta)$. The super-Hubble solution is $u_(p , bold(k)) prop a ( eta )$, hence $h_(p, bold(k)) = "constant"$. This is remarkable: the primordial information is preserved in the super-Hubble regime. First, quantum-mechanical vacuum fluctuations are produced deep in the sub-Hubble regime. Then, exponential expansion stretches the wavelength of fluctuation to the super-Hubble scale, in which $h_(p , bold(k))$ becomes #emph[frozen], preserving the primordial information of inflation. After inflation the Hubble length grows faster than the wavelength of GW, and GW comes inside the Hubble length, making it observable to us in CMB, motions of pulsars and stars, and interferometers.


If we ignore a small parameter $epsilon.alt_H$, the scale factor is given by $a ( eta ) = - ( H eta )^(- 1)$ for $- oo < eta < 0$ and @eq:meff can be solved exactly with a solution $ u_(p , bold(k)) ( eta ) & = A_(p , bold(k)) [cos ( k eta ) - frac(sin ( k eta ), k eta)]\
 & + B_(p , bold(k)) [frac(cos ( k eta ), k eta) + sin ( k eta )] thin , $<eq:solution> where $A_(p , bold(k))$ and $B_(p , bold(k))$ are integration constants. What determines them? Here comes quantum mechanics. Deep in the sub-Hubble regime, the effect of spacetime curvature is negligible. The sub-Hubble solution should therefore match the known flat-space solution for a free quantum field in vacuum called a 'positive frequency mode'@birrell-davies:1984. Matching the two solutions, we find $A_(p , bold(k))$ and $B_(p , bold(k))$.


To this end, we must first find the correct variable (called 'canonical variable') for quantisation. We wrote $u_p = C a h_p$, but what is $C$? To answer this, we expand the Einstein-Hilbert action for general theory of relativity, $I_("GR") = ( 16 pi G )^(- 1) integral d^4 x sqrt(- g) R$, to second-order in tensor modes@ford-parker:1977@mukhanov-feldman-brandenberger:1992 $I_("GR")^(( 2 )) = integral frac(a^2 d eta d^3 x, 16 pi G) sum_(p = + , times) [1 / 2 ( h'_p )^2 - 1 / 2 ( nabla h_p )^2] thin.$ This is similar to the action for a free scalar field in Minkowski space, except the prefactor $a^2 ( 16 pi G )$. We define a canonically normalised field $u_p = a h_p/sqrt(16 pi G)$, i.e., $C = 1/sqrt(16 pi G)$, to find the desired action $I_("GR")^(( 2 )) = 1 / 2 integral d eta d^3 x sum_p [( u'_p )^2 - ( nabla u_p )^2 - m_("eff")^2 ( eta ) u_p^2] thin.$


We quantise $u_p$ using creation ($hat(a)_(bold(k))^dagger$) and annihilation ($hat(a)_(bold(k))$) operators, $u_(p , bold(k)) ( eta ) = u_(p , k) ( eta ) hat(a)_(p , bold(k)) + u_(p , k)^(*) ( eta ) hat(a)_(p , - bold(k))^dagger$, with the commutation relation $[ hat(a)_(p , bold(k)) , hat(a)_(p' , bold(k)')^dagger ] = delta_(p p') delta_("D") ( bold(k) - bold(k)' )$. A positive frequency mode is given by $u'_(p , k) = - i omega_k u_(p , k)$ with an angular frequency $omega_k$@birrell-davies:1984. We work in units of $ℏ = 1$. The canonical commutation relation gives the normalisation condition $u_(p , k) u_(p , k)^(*) zws' - u_(p , k)^(*) u'_(p , k) = i$, which then gives $u_(p , k) = e^(- i omega_k eta)/sqrt(2 omega_k)$.


We determine $A_(p , bold(k))$ and $B_(p , bold(k))$ in @eq:solution as follows. Taking the sub-Hubble limit $k \| eta \| gt.double 1$ and comparing to the positive frequency solution, we find $omega_k = k$, $A_(p , bold(k)) = ( hat(a)_(p , - bold(k))^dagger + hat(a)_(p , bold(k)) )/sqrt(2 k)$ and $B_(p , bold(k)) = i ( hat(a)_(p , - bold(k))^dagger - hat(a)_(p , bold(k)) )/sqrt(2 k)$. Finally, the full solution for $h_(p , bold(k))$ valid for all $k$ is $h_(p , bold(k)) ( eta ) = h_(p , k) ( eta ) hat(a)_(p , bold(k)) + h_(p , k)^(*) ( eta ) hat(a)_(p , - bold(k))^dagger$ with
$
  h_(p,k) = i frac(H, M_("pl")) frac(e^(-i k eta), k^(3/2)) (1 + i k eta) thin .
$


The appearance of the reduced Planck mass, $M_("pl")$, which contains $G$, $c$, and $ℏ$, is appropriate here because we quantised a linear perturbation of the gravitational field.


During inflation, the wavelength of quantum vacuum fluctuations is stretched to the super-Hubble scale, $k \| eta \| lt.double 1$, in which the solution approaches a constant, $h_(p , bold(k)) tilde.eq i (H/M_("pl")) k^(-3/2) hat(c)_(p , bold(k))$. The new operator $hat(c)_(p , bold(k))$ is defined by $hat(c)_(p , bold(k)) equiv hat(a)_(p , bold(k)) - hat(a)_(p , - bold(k))^dagger$, which commutes, $[ hat(c)_(p , bold(k)) , hat(c)_(p , bold(k))^dagger ] = 0$@kiefer-polarski-starobinsky:1998@komatsu:2001. This poses an interesting question: does $h_(p , bold(k))$ remain a quantum field in the super-Hubble regime? Of course, the full solution valid for all $k$ remains fully a quantum field, and we cannot take only a long-wavelength solution to claim that it has become a classical field.


No mechanism for 'classicalisation' of a quantum field via, e.g., decoherence, was included in the above calculation. Rather, this is a manifestation of a squeezed quantum state in the super-Hubble regime@grishchuk-sidorov:1989@grishchuk-sidorov:1990: while it is a quantum field, it is indistinguishable from an ensemble of classical stochastic process@polarski-starobinsky:1996@martin-vennin-peter:2012. In other words, inflation creates gravitons, but their properties are very close to those of classical GW. Whether we can devise a way to probe quantum nature of the primordial GW remains an open question@allen-flanagan-papa:2000@kanno-soda:2019.


== CMB polarisation from gravitational waves
<cmb-polarisation-from-gravitational-waves>


The degree of polarisation is proportional to a quadrupole moment of the local photon intensity distribution around electrons (@fig:thomson). The observed polarisation depends also on the orientation of quadrupole with respect to observer's lines of sight. Polarisation pattern on the sky thus tells us the distribution of photon quadrupoles at the surface of last scattering@hu-white:1997.


// vision: This black-and-white schematic diagram contains five panels labeled (a-1), (a-2), (b-1), (b-2), and (b-3). Each panel depicts a central point labeled e⁻ surrounded by dashed Cartesian axes: x pointing down-left diagonally, z pointing right horizontally, and y pointing down in row (a) or up in row (b). Thick textured bars labeled ε and ε′ represent vectors arranged differently in each panel. Panel (a-1) shows ε vertical at top-left and ε′ at top-right and bottom-left. Panel (a-2) shows angled ε at top-left and ε′ at top-right and bottom-right. Panels (b-1) through (b-3) show crossed bar configurations at various positions around e⁻.
// [figvision-cn] imgs/fig6.png
// 该图由六个黑白线描示意图组成，分为上下两排，分别标记为
// (a-1)、(a-2)和(b-1)、(b-2)、(b-3)，展示了电子在不同入
// 射光偏振条件下的散射过程。所有子图均包含一个位于坐标系
// 原点的实心黑点，代表电子（标注为e⁻）。三条虚线箭头从原
// 点出发，分别沿x轴（指向左下方）、y轴（指向正下方）和z
// 轴（指向正右方），定义了三维空间方向。 上排两个子图展
// 示入射光沿z轴传播的情况： 子图(a-1)：入射光偏振矢量ε为
// 垂直方向（平行于y轴），用一条穿过z轴的粗竖直线段表示。
// 散射后，在z轴方向（前向）和x轴方向存在出射光，其偏振矢
// 量ε'同样为垂直方向（平行于y轴），分别用穿过z轴和x轴的
// 粗竖直线段表示。y轴方向无出射光，图中未绘制任何符号。
// 子图(a-2)：入射光偏振矢量ε为45度斜向（与y轴成45度角），
// 用一条穿过z轴的粗斜线段表示。散射后，在z轴方向和x轴方
// 向均存在出射光，其偏振矢量ε'保持与入射光相同的45度斜向，
// 分别用穿过对应轴的粗斜线段表示。y轴方向无出射光。 下排
// 三个子图展示入射光偏振状态变化对散射的影响，其中(b-2)
// 和(b-3)引入了检偏器（分析器）： 子图(b-1)：入射光偏振
// 矢量ε为45度斜向，用穿过z轴的粗斜线段表示。散射后，在x
// 轴方向存在出射光，其偏振矢量ε'为垂直方向（平行于y轴），
// 用穿过x轴的粗竖直线段表示。y轴和z轴方向无出射光或未被
// 特别标示。 子图(b-2)：入射光偏振矢量ε为45度斜向。在x轴
// 方向的出射光路径上设置了一个水平放置的检偏器（用一条粗
// 横线表示，中间有一条短竖线穿过），用于检测水平偏振分量；
// 在y轴方向的出射光路径上设置了一个45度斜向的检偏器（用
// 一条粗斜线表示，中间有一条短垂线穿过），用于检测同向偏
// 振分量。图中显示，通过x轴水平检偏器的光强为零（无后续
// 光线），而通过y轴斜向检偏器的光强不为零（有后续光线射
// 出）。 子图(b-3)：入射光偏振矢量ε为垂直方向（平行于y轴），
// 但图示中该矢量被一个带有叉号的圆圈覆盖，可能表示此分量
// 被阻挡或不存在。在x轴方向的出射光路径上设置了一个垂直
// 放置的检偏器（用一条粗竖线表示，中间有一条短横线穿过）；
// 在y轴方向的出射光路径上设置了一个45度斜向的检偏器。图
// 中显示，通过x轴垂直检偏器的光强为零，而通过y轴斜向检偏
// 器的光强不为零。
#figure(placement: auto, image("imgs/fig6.png", width: 100%),
 caption: [
 #strong[Generation of polarisation.] An electron ($e^(-)$) at the origin receives an incident light along $z$ axis with the initial polarisation vector $bold(epsilon.alt)$. The differential cross section is given by $d sigma d Omega = 3 sigma_("T") ( bold(epsilon.alt) dot.op bold(epsilon.alt)' )^2 8 pi$, where $sigma_("T")$ is the Thomson scattering cross section and $bold(epsilon.alt)'$ the polarisation vector of an outgoing light. #strong[a-1]| Incident light is vertically polarised and scattered into $x$ and $z$ axes. No scattering into $y$ axis is possible. #strong[a-2]| Incident light is horizontally polarised and scattered into $y$ and $z$ axes. No scattering into $x$ axis is possible. #strong[b-1]| Incident light is unpolarised, but light scattered into $x$ axis is vertically polarised. #strong[b-2]| Unpolarised lights are coming into $e^(-)$ along $y$ and $z$ axes with the equal intensity and scattered into $x$ axis. No polarisation is generated. #strong[b-3]| Finally, unpolarised lights are coming into $e^(-)$ along $y$ and $z$ axes with #emph[unequal] intensity and scattered into $x$ axis. Polarisation is generated.
 ]
)
<fig:thomson>


Both the scalar and tensor modes generate a local quadrupole. In the tight-coupling regime before decoupling, in which photons and electrons are tightly coupled via Thomson scattering, the angular distribution of photon intensity around electrons is isotropic because electrons and photons move together on average - no polarisation is generated. The electron number density fell exponentially as the temperature approached 3,000~K, which weakened coupling of photons and electrons and generated a quadrupolar angular distribution of photon intensity around electrons, hence polarisation.


The tensor mode generates a quadrupole moment directly. In @fig:gw, we show how $h_(+)$ and $h_times$ propagating in the $z$ direction change distances between two points on $x$-$y$ plane. For example, when $h_(+)$ increases, the distance between two points increases along $x$ axis and decreases along $y$ axis such that the area is conserved. Now imagine that space is filled with sea of photons. If space is stretched and contracted in $x$ and $y$ axes, wavelengths of photons are also stretched and contracted. This creates a quadrupole moment of photon intensity on the $x$-$y$ plane@sachs-wolfe:1967. Polarisation is generated when these photons are scattered by an electron at the origin of the plane into the $z$ direction towards an observer. Polarisation directions are parallel to the major axes of ellipses shown in @fig:gw.


// vision: A four-panel black-and-white phase-portrait diagram in a 2×2 grid. Each panel plots unlabeled y (vertical) versus x (horizontal) axes with arrowheads but no numeric ticks, units, or ranges. Every panel contains a dashed circle centered at the origin plus a solid black elliptical trajectory with small direction arrows. Top-left, labeled $\dot{h}_+>0$: a horizontally elongated ellipse traversed clockwise. Top-right, labeled $\dot{h}_\times>0$: an ellipse tilted with its major axis running from lower-left to upper-right. Bottom-left, labeled $\dot{h}_+<0$: a vertically elongated ellipse traversed counter-clockwise.
// [figvision-cn] imgs/fig7.png
// 该图包含四个子图，呈2x2网格排列，均为二维示意图，用于
// 展示张量模式对两点间距离的扭曲效应。所有子图共享相同的
// 坐标系结构：横轴为x轴，箭头向右；纵轴为y轴，箭头向上。
// 每个子图中均有一个以原点为中心的虚线圆，代表未受扰动时
// 的参考状态（即等距圆周）。实线椭圆表示在特定张量扰动下，
// 原本位于虚线圆上的点被拉伸或压缩后的新位置分布。椭圆上
// 带有双向箭头，指示形变方向。 左上角子图（a）： 类型：
// 示意图 坐标轴：x轴与y轴，无具体数值范围或单位标注 图形
// 元素：一个水平拉长的实线椭圆，其长轴沿x轴方向，短轴沿y
// 轴方向；内部嵌套一个虚线圆，圆心在原点 标注文字：右上
// 角标注“ḣ₊ > 0”，其中“ḣ”表示h的时间导数，“+”下标对应加
// 号极化模式 箭头含义：椭圆左右两端有向外指的双向箭头，
// 表明x方向被拉伸；上下两端有向内指的双向箭头，表明y方向
// 被压缩 结论：当ḣ₊ > 0时，空间在x方向膨胀、y方向收缩，
// 导致圆形变为横向椭圆 右上角子图（b）： 类型：示意图 坐
// 标轴：同左上图，x轴向右，y轴向上 图形元素：一个倾斜45
// 度的实线椭圆，主轴沿第一象限至第三象限对角线方向；内部
// 嵌套虚线圆 标注文字：右侧标注“ḣₓ > 0”，其中“×”下标对应
// 叉号极化模式 箭头含义：椭圆两端（沿对角线方向）有向外
// 指的双向箭头，表明该对角线方向被拉伸；垂直于该方向的另
// 一对角线方向被压缩（由椭圆形状隐含） 结论：当ḣₓ > 0时，
// 空间在第一/三象限对角线方向膨胀，第二/四象限对角线方向
// 收缩，圆形变为斜向椭圆 左下角子图（c）： 类型：示意图
// 坐标轴：同前，x轴向右，y轴向上 图形元素：一个垂直拉长
// 的实线椭圆，长轴沿y轴方向，短轴沿x轴方向；内部嵌套虚线
// 圆 标注文字：右上角标注“ḣ₊ < 0” 箭头含义：椭圆上下两端
// 有向外指的双向箭头，表明y方向被拉伸；左右两端有向内指
// 的双向箭头，表明x方向被压缩 结论：当ḣ₊ < 0时，空间在y
// 方向膨胀、x方向收缩，导致圆形变为纵向椭圆 右下角子图（
// d）： 类型：示意图 坐标轴：同前，x轴向右，y轴向上 图形
// 元素：一个倾斜135度（或-45度）的实线椭圆，主轴沿第二象
// 限至第四象限对角线方向；内部嵌套虚线圆 标注文字：右侧
// 标注“ḣₓ < 0” 箭头含义：椭圆两端（沿第二/四象限对角线方
// 向）有向外指的双向箭头，表明该方向被拉伸；垂直方向（第
// 一/三象限对角线）被压缩 结论：当ḣₓ < 0时，空间在第二/
// 四象限对角线方向膨胀，第一/三象限对角线方向收缩，圆形
// 变为反向斜向椭圆 整体趋势与结论：四个子图共同说明引力
// 波的两种独立极化模式（+模式和×模式）如何随时间变化率（
// ḣ）的正负不同，引起空间在不同方向上发生交替的拉伸与压
// 缩，从而扭曲两点间的固有距离。虚线圆代表初始各向同性距
// 离分布，实线椭圆代表扰动后的非均匀距离分布，箭头明确标
// 示了局部应变的方向和性质。
#figure(placement: auto, image("imgs/fig7.png", width: 100%),
 caption: [
 #strong[Tensor-mode distortion of distances between two points.]
 ]
)
<fig:gw>


The next step is to calculate the observed polarisation pattern on the sky. In @fig:fourier, we show polarisation patterns in spherical coordinates $( theta , phi.alt )$. The left panel shows the pattern we observe in $phi.alt = 0^compose$ ($45^compose$), when a single plane wave of $h_(+)$ ($h_times$) propagates in the $z$ axis. The right panel shows that in $phi.alt = 45^compose$ ($0^compose$) for $h_(+)$ ($h_times$). The polarisation directions in the left panel are parallel or perpendicular to the propagating direction of GW (i.e., $E$ modes), whereas those in the right panel are tilted by $plus.minus 45^compose$ ($B$ modes). Of course, fluctuations in our Universe are not described by a single plane wave but by a superposition of plane waves going in different directions with various wavelengths and amplitudes.


// vision: This is a schematic illustration, not a data plot. A thick black circular arc sits on a gray horizontally striped background with a vertical z axis and a polar angle θ marked from the center. A vertical axis on the left is labeled Θ, running from 0 to π in radians with ticks at 0, π/4, π/2, 3π/4, and π, each carrying a black horizontal bar. Four inset schematics appear: one at top showing θ around a z-aligned bar; two at the left (Θ = π/4 and π/2) showing φ as a horizontal arrow and θ as a vertical arrow; and a row of tilted square panels along the right side of the arc, each holding white and gray circular disks.
// vision: A schematic polar diagram on a gray vertically striped background plots spin configurations on a thick black circular arc spanning polar angle θ from 0 at the top (+Z axis) to π at the bottom. A vertical θ axis on the far left runs 0 to π beside a black-and-white zigzag key of alternating up/down spins. Along the arc, white and gray circular markers sit in tilted square local planes, most densely on the right half. Three square insets (near θ = 0, the left side near π/2, and upper region) each show a local frame with a thick black vector, polar angle θ, and azimuth φ. A right-side annotation states φ = 0 for h× and φ = π/4 for h+.
// [figvision-cn] imgs/fig8a.jpg
// 这是一张示意图，描绘了由单个平面引力波在天空产生的宇宙
// 微波背景辐射（CMB）极化模式。图像主体为一个以原点为中
// 心的圆形几何结构，叠加在具有水平明暗条纹的背景之上。
// 中心区域展示了一个三维坐标系，垂直轴标记为Z并带有向上
// 箭头，水平轴未标记但代表赤道平面。一条粗黑实线圆弧从Z
// 轴正方向（顶部）延伸至水平轴右侧，表示天球上的一个经线
// 圈。圆弧上标注了角度θ，表示从Z轴向下测量的极角。圆弧的
// 左侧边缘有一列垂直排列的刻度标记，从上至下依次对应0、-
// π/4、-π/2、-3π/4和π，这些数值与圆弧上的位置相对应，表
// 明θ角的取值范围是从0到π。 在圆弧的三个特定位置（分别对
// 应θ=0, θ=π/4, θ=π/2），绘制了三个方形插图框，用于放大
// 显示该点处的物理细节。每个方框内都包含一个黑色的短粗线
// 段和一个十字交叉的坐标轴。 位于顶部（θ=0）的方框：黑色
// 粗线段沿垂直方向放置。从中心向四个对角方向引出四条带箭
// 头的细线，每条线与垂直轴之间的夹角均标记为θ。 位于中间
// 偏左（θ=π/4）的方框：黑色粗线段沿水平方向放置。方框内
// 有一个十字坐标，水平向右的箭头标记为φ，垂直向下的箭头
// 标记为θ。 位于左侧（θ=π/2）的方框：黑色粗线段沿垂直方
// 向放置。方框内同样有十字坐标，水平向右标记为φ，垂直向
// 下标记为θ。 在圆弧的右半部分（第一象限），沿弧线分布着
// 五个倾斜的小菱形平面。每个平面上放置了两个小球，一个为
// 白色，一个为灰色。这些小球成对出现，随着沿圆弧向下移动
// （θ增加），这对小球的连线相对于径向的方向发生旋转。 图
// 像右侧有两行文字说明，解释了参数φ与引力波偏振模式的关
// 系：第一行为“φ = 0 for h+”，第二行为“φ = π/4 for hx”。
// 这表明白色和灰色小球构成的四极矩图案的取向角φ取决于引
// 力波的偏振类型（h+或hx）。 背景是由一系列水平的灰度渐
// 变条纹组成，颜色从深灰到浅灰交替变化，模拟了某种场或强
// 度的空间分布。整体图像旨在说明当引力波沿Z轴传播时，在
// 最后散射面（由粗黑圆环示意）的每一点上都会产生光子强度
// 的四极矩（由黑白小球示意），电子散射这些四极矩后便产生
// 了特定的CMB极化模式。
// [figvision-cn] imgs/fig8a.jpg
// 这是一张示意图，描绘了由单个平面引力波在天空产生的宇宙
// 微波背景辐射（CMB）极化模式。图像主体为一个以原点为中
// 心的圆形几何结构，叠加在具有水平明暗条纹的背景之上。
// 中心区域展示了一个三维坐标系，垂直轴标记为Z并带有向上
// 箭头，水平轴未标记但代表赤道平面。一条粗黑实线圆弧从Z
// 轴正方向（顶部）延伸至水平轴右侧，表示天球上的一个经线
// 圈。圆弧上标注了角度θ，表示从Z轴向下测量的极角。圆弧的
// 左侧边缘有一列垂直排列的刻度标记，从上至下依次对应0、-
// π/4、-π/2、-3π/4和π，这些数值与圆弧上的位置相对应，表
// 明θ角的取值范围是从0到π。 在圆弧的三个特定位置（分别对
// 应θ=0, θ=π/4, θ=π/2），绘制了三个方形插图框，用于放大
// 显示该点处的物理细节。每个方框内都包含一个黑色的短粗线
// 段和一个十字交叉的坐标轴。 位于顶部（θ=0）的方框：黑色
// 粗线段沿垂直方向放置。从中心向四个对角方向引出四条带箭
// 头的细线，每条线与垂直轴之间的夹角均标记为θ。 位于中间
// 偏左（θ=π/4）的方框：黑色粗线段沿水平方向放置。方框内
// 有一个十字坐标，水平向右的箭头标记为φ，垂直向下的箭头
// 标记为θ。 位于左侧（θ=π/2）的方框：黑色粗线段沿垂直方
// 向放置。方框内同样有十字坐标，水平向右标记为φ，垂直向
// 下标记为θ。 在圆弧的右半部分（第一象限），沿弧线分布着
// 五个倾斜的小菱形平面。每个平面上放置了两个小球，一个为
// 白色，一个为灰色。这些小球成对出现，随着沿圆弧向下移动
// （θ增加），这对小球的连线相对于径向的方向发生旋转。 图
// 像右侧有两行文字说明，解释了参数φ与引力波偏振模式的关
// 系：第一行为“φ = 0 for h+”，第二行为“φ = π/4 for hx”。
// 这表明白色和灰色小球构成的四极矩图案的取向角φ取决于引
// 力波的偏振类型（h+或hx）。 背景是由一系列水平的灰度渐
// 变条纹组成，颜色从深灰到浅灰交替变化，模拟了某种场或强
// 度的空间分布。整体图像旨在说明当引力波沿Z轴传播时，在
// 最后散射面（由粗黑圆环示意）的每一点上都会产生光子强度
// 的四极矩（由黑白小球示意），电子散射这些四极矩后便产生
// 了特定的CMB极化模式。
#figure(scope: "parent", placement: auto, [#box(image("imgs/fig8a.jpg", width: 48.0%)) #box(image("imgs/fig8b.jpg", width: 48.0%))

 ],
 caption: [
 #strong[Polarisation patterns of CMB on the sky generated by a single plane wave.] When GW propagates in $z$ axis, quadrupole moments (illustrated by two grey and two white balls) of the photon intensity are generated on $x$-$y$ plane at each point on the surface of last scattering (solid circle). The white and grey balls show hot and cold photons as seen from electrons. When electrons scatter these quadrupoles, various strengths and directions of polarisation are seen by an observer located at the origin, depending on orientations of quadrupoles with respect to the observer's lines of sight. The left panel shows the polarisation pattern seen in azimuthal angles of $phi.alt = 0^compose$ and $45^compose$ for $h_(+)$ and $h_times$, respectively, whereas the right panel shows that of $phi.alt = 45^compose$ and $0^compose$ for $h_(+)$ and $h_times$, respectively.
 ]
)
<fig:fourier>


As the scalar mode does not produce $B$ modes at linear order in cosmological perturbation@seljak:1997, $B$ modes are a clean probe of the primordial GW@seljak-zaldarriaga:1997@kamionkowski-etal:1997b.

#bibliography("refs.bib", style: "nature.csl", title: [References])