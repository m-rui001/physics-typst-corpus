// Odd dynamics of living chiral crystals -- main text + Supplementary Information
// (single Typst document reproducing the original PDF pagination)

#set text(font: ("CMU Serif", "New Computer Modern"), size: 10.26pt, lang: "en")
#set page(paper: "us-letter", margin: (x: 87pt, top: 70.3pt, bottom: 74pt),
  numbering: none,
  footer: context [#v(25.28pt)#align(center)[#counter(page).display("1")]])
#set par(justify: true, leading: 5.74pt, spacing: 12.74pt)
#set table(stroke: none)
#set figure(numbering: "1")
#set figure.caption(position: bottom)
#show figure.caption: set text(size: 10.26pt)
#show figure.where(kind: table): set figure.caption(position: top)
#set math.equation(numbering: "(1)", supplement: none)
#show math.equation.where(block: true): set align(center)

#set heading(numbering: none)
#show heading: set text(font: "CMU Sans Serif", weight: "bold")
#show heading.where(level: 1): set text(size: 13.5pt)
#show heading.where(level: 2): set text(size: 11.25pt)
#show heading.where(level: 3): set text(size: 10.26pt)
#show heading: set block(above: 19.73pt, below: 12.37pt)

#show ref: it => {
  let el = it.element
  if el == none { return it }
  if el.func() == figure {
    if el.numbering == none { return it }
    link(el.location(), [Fig.~#numbering(el.numbering, ..counter(figure.where(kind: el.kind)).at(el.location()))])
  } else if el.func() == heading {
    if el.numbering == none { return it }
    link(el.location(), numbering(el.numbering, ..counter(heading).at(el.location())))
  } else { it }
}

#v(-2.42pt)
#align(center)[#text(size: 19.44pt, weight: "bold")[Odd dynamics of living chiral crystals]]
#v(9.6pt)
#text(size: 10.26pt)[
Tzer Han Tan#super[1,2,3,5], Alexander Mietke#super[4,5], Junang Li#super[1,6], Yuchao~Chen#super[1,6], Hugh Higinbotham#super[1], \
Peter~J.~Foster#super[1], Shreyas~Gokhale#super[1], Jörn~Dunkel#super[4], Nikta~Fakhri#super[1,7]
]
#v(-5.77pt)
#set par(leading: 5.28pt, spacing: 0pt, justify: false)
#block(inset: (left: 0.77pt))[
#text(size: 9.37pt)[
#grid(columns: (9.34pt, 1fr), align: horizon, row-gutter: 5.28pt,
  [#text(size: 6.56pt)[1]], [Department of Physics, Massachusetts Institute of Technology, Cambridge, MA, USA],
  [#text(size: 6.56pt)[2]], [Quantitative Biology Initiative, Harvard University, Cambridge, MA, USA],
  [#text(size: 6.56pt)[3]], [Center for Systems Biology Dresden, Dresden, Germany],
  [#text(size: 6.56pt)[4]], [Department of Mathematics, Massachusetts Institute of Technology, Cambridge, MA, USA],
  [#text(size: 6.56pt)[5]], [These authors contributed equally and are joint first authors.],
  [#text(size: 6.56pt)[6]], [These authors contributed equally.],
  [#text(size: 6.56pt)[7]], [Corresponding author: fakhri\@mit.edu],
)
]]
#set par(leading: 5.74pt, spacing: 12.74pt)
#v(50.67pt)
#text(size: 13.5pt, weight: "bold", font: "CMU Sans Serif")[Abstract]
#v(3.15pt)

Active crystals are highly ordered structures that emerge from the self-organization of motile objects, and have been widely studied in synthetic~@Palacci:2013eu @bililign2021chiral and bacterial~@Petroff2015 @Petroff:2018js active matter. Whether collective crystallization phenomena can occur in groups of autonomously developing multicellular organisms is currently unknown. Here, we show that swimming starfish embryos spontaneously assemble into chiral crystals that span thousands of spinning organisms and persist for tens of hours. Combining experiments, theory, and simulations, we demonstrate that the formation, dynamics, and dissolution of these living crystals are controlled by the hydrodynamic properties and natural development of embryos. Remarkably, living chiral crystals exhibit self-sustained chiral oscillations as well as various unconventional deformation response behaviors recently predicted for odd elastic materials~@Scheibner:2020gm @braverman2020topological. Our results provide direct experimental evidence for how nonreciprocal interactions between autonomous multicellular components may facilitate novel nonequilibrium phases of chiral active matter.

#pagebreak()

Symmetry breaking~@Anderson393 @ashcroft1976solid is a hallmark of living~@2010LiBowerman and synthetic~@Palacci:2013eu @Bricard:2013jq @2000Grzybowski @2010Lee active matter. From the asymmetric growth of multicellular organisms~@2010LiBowerman @Naganathan:2014fc @2019Smith to the coherent motions of swimming cells~@riedel2005self @PhysRevLett.98.158102 and self-propelled colloids~@Palacci:2013eu @Bricard:2013jq @2019Shen @2020Bechinger, active systems form self-organized structures~@RevModPhys.66.1481 @wang2021emergent @2021Omar with unusual material properties @avron1998odd @soni2019odd @banerjee2021active that can only emerge far from thermal equilibrium. In spite of major experimental~@Palacci:2013eu @Bricard:2013jq @Petroff2015 @PhysRevLett.98.158102 @soni2019odd @2020Bechinger and theoretical~@Marchetti:2013bp @shankar2020topological @2015CatesTailleur progress over the last decade, we are only beginning to understand how complex collective behaviors of multicellular~@Bi:2015hh @hartmann2018emergence @Qin71 @2021Collinet and multiorganismal~@Rosenthal4690 @Bialek4786 systems arise from the broken symmetries and nonequilibrium dynamics of their individual constituents.


A particularly interesting class of nonequilibrium symmetry-breaking phenomena comprises the active crystallization processes recently discovered in colloidal~@Palacci:2013eu and bacterial~@Petroff2015 systems. Unlike conventional passive crystals, which form upon lowering temperature and often require attractive forces, active crystallization arises from the particles' self-propulsion and can occur even in purely repulsive dilute systems~@Palacci:2013eu. A long-standing related, unanswered question is whether groups of multicellular organisms can self-organize into states of crystalline order and, if so, what emergent material properties they might exhibit.


Here, we report the discovery of spontaneous crystallization in large assemblies of developing starfish _Patiria miniata_ embryos (#ref(<fig-1>)a). Our experimental observations show how, over the course of their natural development, thousands of swimming embryos come together to form living chiral crystal (LCC) structures that persist for many hours. In contrast to externally actuated colloidal systems, the self-assembly, dynamics, and dissolution of these LCCs are controlled entirely by the embryos' internal developmental program (#ref(<fig-1>)a,b). A quantitative theoretical analysis reveals that LCC formation arises from the complex hydrodynamic interactions~@Drescher2009 @Lauga2020 between the starfish embryos. Once formed, these LCCs exhibit striking collective dynamics, consistent with predictions from a recently proposed theory of odd elasticity~@Scheibner:2020gm.


== Self-assembly, growth, and dissolution of living chiral crystals
<self-assembly-growth-and-dissolution-of-living-chiral-crystals>




During early development, starfish embryos exhibit substantial morphological changes. From the onset of gastrulation (#ref(<fig-1>)b, 0 h), embryos elongate along their anterior-posterior (AP) axis (0-44 h) while progressively developing folds that further break shape symmetry. In parallel, the self-generated fluid flow near the embryo's surface changes~(#ref(<fig-1>)b), reflecting spatial reconfigurations of cilia during growth~@Gilpin:2017ef similar to other ciliated organisms~@wan2020reorganization. Remarkably, when embryos come close to the fluid surface, they can attain a stable bound state in which their AP axes are oriented perpendicular to the fluid-air interface. Groups of surface-bound embryos can spontaneously self-organize into two-dimensional hexagonal clusters (#ref(<fig-1>)a, 2-5 h). Over time, these clusters grow into larger crystals, reaching sizes of hundreds to thousands of embryos (#ref(<fig-1>)a, 26 h) and persisting for tens of hours. As embryos develop further (#ref(<fig-1>)b, 38--44 h) crystals begin to disassemble (#ref(<fig-1>)a, 35 h) and eventually dissolve completely (#ref(<fig-1>)a, 38 h).


Viewed from above, both small and large crystals rotate clockwise (#ref(<fig-1>)c), consistent with the chiral spinning motions of individual embryos about their AP axis (#ref(<fig-2>)a). Large LCCs typically exhibit a high degree of hexagonal order, while also harboring lattice defects (#ref(<fig-1>)d). The assembly, rotational dynamics and dissolution of LCCs can be rationalized by a hydrodynamic analysis that accounts for the flow fields generated by individual embryos (Figs.~1e and 2a-c).


== From single embryo properties to crystal formation, chiral rotation, and dissolution
<from-single-embryo-properties-to-crystal-formation-chiral-rotation-and-dissolution>





To understand the hydrodynamic interactions underlying the cluster dynamics, we first analyzed the fluid flow around individual embryos bound below the air-water interface~(#ref(<fig-2>)a,b). 

#pagebreak()
#align(center + horizon)[
// [figvision-cn] _ms_conv/imgs/Fig1.png
// 子图a是五幅灰度显微照片构成的时间序列，面板左上角依次
// 标注2h、5h、26h、35h、38h；第一幅图底部标有一条黑色比
// 例尺。成像采用透射光或亮场显微镜，灰度亮度反映胚胎光学
// 密度，未使用伪色颜色映射。2h时视野内胚胎呈稀疏颗粒，局
// 部形成不规则小团块；5h时团块面积扩大，相互靠近形成不连
// 续的大片致密区；26h时致密区进一步融合，占据绝大部分视
// 野，背景中散布个别孤立胚胎；35h时致密区出现分支状空隙
// 并开始破碎；38h时团块分解为更小的簇和散布颗粒，整体空
// 间分布回归接近2h时的稀疏状态。趋势表明胚胎群体经历聚集、
// 致密化、破碎与重新分散的周期性自组织。 子图b包含两列显
// 微照片，时间点分别为0h、12h、26h、38h、44h。左列为整个
// 胚胎的亮场图像，右列为对应的光学横截面亮场图像；所有图
// 像为灰度，底部第一列标有一条黑色比例尺。0h整体图像左侧
// 标注白色字母A和P，分别标示动物极与植物极。0h时胚胎为球
// 形实心结构；12h至26h时胚胎体积增大，右列横截面可见内部
// 纹理变化；38h时右列图像中央出现大面积黑色空腔；44h时中
// 央黑色空腔进一步扩大，胚胎呈薄壁囊泡状。结论为发育过程
// 中胚胎发生囊腔形成与形态重塑。 子图c是一幅宽场显微照片，
// 展示数千个胚胎细胞排列成螺旋状手性晶体单层；图像右下角
// 标有一条黑色比例尺。底部为水平时间色标，左端标注0s，右
// 端标注2000s，中间标注Time；色标从蓝色（0s）经绿色过渡
// 到黄色（2000s），用于给每个细胞或局部区域分配其参与晶
// 体构建或旋转的时间点。主图中央为紧密排列的六方晶格区域，
// 呈蓝色；向外辐射区域颜色逐渐转为绿色和黄色，形成明显的
// 螺旋纹理。颜色梯度与空间位置连续对应，表明晶体生长伴随
// 旋转，且不同区域的细胞在不同时间点加入有序结构。 子图d
// 是一幅灰度显微照片叠加彩色标记，展示密排胚胎单层中的局
// 部手性簇；图像右下角标有一条黑色比例尺。背景为直径均一
// 的圆形胚胎紧密六方堆积的灰度图像。图中有三组标记：橙色
// 组位于左下方，由一个中心橙色实心圆点和六个周围橙色实心
// 圆点构成，周围点以橙色虚线箭头连向中心并带切线方向，表
// 示涡旋；紫色组位于右上方，由一个中心紫色实心圆点和四个
// 周围紫色实心圆点构成，以紫色虚线箭头连接，表示旋转方向；
// 黄色组位于紫色组右侧，由六个黄色空心圆环沿圆周等距排列，
// 每个圆环外侧有细箭头指向顺时针方向。这些叠加图形量化了
// 局域细胞的旋转对称性与旋转方向，结论为单层中存在与晶格
// 方向耦合的手性涡旋。 子图e包含两个示意图面板，均无实验
// 数据坐标轴。左侧面板为三维示意图：左下角标注直角坐标轴
// x、y、z；半透明白色立方体表示限制容器，立方体内排列四
// 个灰色球体代表胚胎细胞，每个球体表面有黄色弧线指示自转
// 方向，球体间有蓝色流线箭头表示细胞旋转驱动周围流体产生
// 定向对流；容器左下角放大了一个球体，表面标有黄色条纹与
// 旋转箭头。右侧面板为二维俯视示意图：左下角标注直角坐标
// 轴x、y；六个灰色圆形细胞带黄色边缘环排列成环状，每个细
// 胞内部有黄色弧线标示自转方向，中央有一个红色粗弧箭指示
// 六个细胞绕中心公转的宏观旋转方向，周围布有黑色细箭头表
// 示径向流向或流出。两个面板共同说明微观细胞自转通过流体
// 耦合产生宏观手性晶体有序。
#figure(
  gap: 10pt,
  image("_ms_conv/imgs/Fig1.png", width: 100%),
  caption: [
    #strong[Developing starfish embryos self-organize into living chiral crystals.] #strong[a,]~Time sequence of still images showing crystal assembly and dissolution. Scale bar, 1 mm. $t = 0$ hours corresponds to the onset of clustering. #strong[b,]~Embryo morphology and flow fields change with developmental time. Shape scale bar, 100 $mu$m. Flow field scale bar, 200 $mu$m. See Extended Data Figure 1 for uncropped morphology images. #strong[c,] Embryos assembled in a crystal perform a global collective rotation. Scale bar, 2 mm. #strong[d,]~Spinning embryos (yellow arrows) in the crystal form a hexagonal lattice, containing 5-fold (purple) and 7-fold (orange) defects. Scale bar, 0.5 mm. #strong[e,]~Schematic of embryo dynamics and fluid flows. Crystals of spinning embryos form near the air-water interface. Self-generated hydrodynamic flows lead to an effective attraction between surface-bound embryos.
  ],
) <fig-1>
]
#pagebreak()
#align(center + horizon)[
// [figvision-cn] _ms_conv/imgs/Fig2.png
// 图a为单胚胎俯视图显微照片。图像中心为一个灰色圆形胚胎，
// 内部有黄色弯曲箭头指示其逆时针旋转方向。胚胎周围分布大
// 量白色细线，代表流体迹线（streamlines），呈放射状从中
// 心向外发散并带有切向分量，显示旋转驱动流场。图中左下角
// 标有坐标系：x轴水平向右，y轴垂直向上。右下角有白色比例
// 尺条。 图b为径向流入速度随距离变化的曲线图。横坐标为“
// Distance from embryo (mm)”，范围0至0.6 mm；纵坐标为“
// Radial in-plane flow (mm/s)”，范围0至0.2 mm/s。灰色散
// 点表示实验测量值，蓝色实线表示理论模型（Stokeslet flow
// below a free surface）。数据点在r≈0.15 mm处达到峰值约
// 0.18 mm/s，随后单调下降。理论曲线与实验点高度吻合。 图
// c包含四幅子图，分为左右两组，每组含“Experiment”和“
// Theory”。左侧两图为径向平面内流速 |v_xy·e_r| 的热力图，
// 右侧两图为方位角平面内流速 v_xy·e_θ 的矢量场图。所有子
// 图均显示两个相邻灰色圆盘（代表结合对胚胎），位于画面中
// 央偏左。左侧热力图颜色从蓝（低流速）到红（高流速），标
// 注“Radial in-plane flow |v_xy·e_r| (mm/s)”及刻度0–0.13
// mm/s；右图矢量场用彩色箭头表示方向与大小，标注“
// Azymuthal in-plane flow v_xy·e_θ (mm/s)”及刻度-0.04至
// 0.04 mm/s。左上角有坐标系（x,y）及单位向量 e_r, e_θ。
// 实验与理论结果在空间分布上基本一致。 图d为示意图，展示
// 两个胚胎间的流体动力学相互作用。上方标题“Forces”，下方
// 标题“Torques”。每个胚胎为灰色圆盘，内含逆时针旋转箭头。
// 橙色直线箭头表示作用力方向，红色弧形箭头表示扭矩方向。
// 左侧胚胎受力指向右上方，右侧胚胎受力指向左下方；两者扭
// 矩均为逆时针。左下角标有坐标系（x,y）。 图e为六帧时间
// 序列显微图像，展示胚胎聚集过程。从左至右、从上至下时间
// 为0min、20min、40min、50min、60min、200min。每帧中黄色
// 小圆点代表单个胚胎，紫色区域代表已形成簇团。初始阶段胚
// 胎分散，随时间推移逐渐聚集成不规则簇团，最终形成大面积
// 连通结构。底部有色标条：“Embryo spinning frequency (1/
// s)”，范围10⁻⁴至1 Hz，颜色从紫（低频）到黄（高频）。 图
// f为柱状图加误差棒，横坐标为“Number of direct neighbors
// ”（0至6），纵坐标为“Embryo spinning frequency (1/s)”（
// 0至1 s⁻¹）。灰色圆圈代表实验数据，蓝色方块代表模型预测。
// 数据显示：当邻居数≤2时，自旋频率较高（~0.7 s⁻¹）；当邻
// 居数≥3时，频率显著降低（<0.3 s⁻¹）。右侧插图示意“小簇
// 团”（少量胚胎，高自旋）与“大簇团”（多胚胎，低自旋）对
// 比。 图g为双对数坐标散点图，横坐标为“Number of embryos
// in cluster”（10¹至10³），纵坐标为“Cluster rotation
// frequency (1/s)”（10⁻至10¹ s⁻¹）。灰色圆圈为实验数据，
// 蓝色空心圈为模型预测。整体趋势：簇团越大，整体旋转频率
// 越低，近似幂律衰减。右侧红色弯曲箭头示意整个簇团的集体
// 旋转方向。 图h为折线图，横坐标为“Time (hours)”（0至40
// h），纵坐标为“Ellipticity”（0至1）。黑色实线为平均值，
// 灰色阴影带为标准差。椭圆度随时间缓慢上升，在约30小时后
// 急剧增加。绿色三角形标记三个时间点，对应右侧三张显微照
// 片（i, ii, iii）：i（早期，圆形胚胎）、ii（中期，部分
// 变形）、iii（晚期，明显拉长成椭圆形）。每张子图均有比
// 例尺。 图i为累积分布函数曲线图，横坐标为“Tilt angle θ
// (°)”（0至60°），纵坐标为“Cumulative fraction of
// embryos”（0至1）。三条曲线分别对应不同培养时间：浅绿线
// （11小时）、中线（28小时）、深绿线（33小时）。曲线随时
// 间右移，表明倾斜角增大。右侧三张显微照片（i, ii, iii）
// 显示胚胎从直立（θ≈0°）逐渐倾斜至接近水平（θ>90°），黄
// 色轮廓圈出个体胚胎。 图j为角度-时间演化图，横坐标为“
// Time (hours)”（0至50 h），纵坐标为“Stationary
// orientation θ (°)”（0至180°）。蓝色实线表示稳定态，灰
// 色虚线表示不稳定态。初始θ=0°（直立），随时间推移，系统
// 经历分岔：一部分保持θ=0°，另一部分跃迁至θ>90°（倒置）。
// 右侧示意图展示两种稳态构型：θ=0°时胚胎竖直排列，θ>90°
// 时倒置排列。中间插入一个局部放大图，定义θ为胚胎长轴与
// 垂直方向夹角。
#figure(
  gap: 10pt,
  image("_ms_conv/imgs/Fig2.png", width: 100%),
  caption: [
    #strong[Single embryo properties facilitate formation, rotations and dissolution of clusters.] #strong[a,]~Single embryo top view. Yellow arrow indicates spinning direction, gray dotted lines visualize streamlines~(SI~Sec.~1.2). #strong[b,]~Measured radial in-flow velocities (gray dots) are well-described by Stokeslet flow below a free surface (blue line)~(SI~Sec.~2.1.6). #strong[c,]~Flow fields surrounding bound pairs (Experiment, SI~Sec.~3.2.1) fitted by a solution of the Stokes equation~(Theory, SI~Sec.~3.2.2) that takes into account hydrodynamic interactions (#strong[d]). #strong[d,]~Hydrodynamic interactions cause nearby embryos to orbit around each and reduce individual spinning frequencies. #strong[e,]~Stokeslet-mediated attraction~(#strong[a],#strong[b]) and hydrodynamic near-field interactions of spinning particles (#strong[d]) in an experimentally constrained minimal model~(SI~Sec.~2.2) reproduce crystal formation and rotation dynamics seen in the experiments. #strong[f,]~Single embryo spinning frequencies in small clusters ($<= 4$ embryos) and in larger clusters ($approx 100$ embryos). Error bars denote standard deviations of measurements (Experiment) and from simulations (Model) (SI~Sec.~2.2.3). #strong[g,]~Assuming a cluster-size dependent reduction of the individual embryo's spinning activity (SI Sec.~2.2.2) leads to good agreement with measured whole-cluster rotation frequencies. #strong[h,]~Ellipticity of embryo shapes (right: top-view outlines in red, SI~Sec.~3.5) increases during development, leading to increasingly noisy steric interactions among spinning embryos in clusters. Gray band depicts standard deviation. #strong[i,]~Embryos at cluster boundaries exhibit increasing AP axis tilt angles as development progresses (right: projection outlines in yellow, SI~Sec.~3.5). Dashed line: critical angle at which bound states of late embryos become unstable. #strong[j,]~Stationary orientations and stability of a microswimmer with hydrodynamic properties akin to developing embryos~(SI Secs.~2.1.1--2.1.5). A decreasing critical angle (gray line) and the increase in effective noise (#strong[h],#strong[i]) increase the rate of embryos leaving cluster boundary and fluid surface, ultimately driving the dissolution of clusters. Scale bar, 200 $mu$m (#strong[a],#strong[c]), 100 $mu$m~(#strong[d]), 1 mm~(#strong[e]), 500 $mu$m~(#strong[h],#strong[i]).
  ],
) <fig-2>
]
#pagebreak()

Observed along the AP axis, fluid moves radially inward towards the embryo, reaches maximum speed 0.1--0.2 mm/s lateral to the embryo surface~(#ref(<fig-2>)b), and eventually moves toward the bottom of the well~(#ref(<fig-1>)e). The radial in-flow generated by isolated embryos can be described as a Stokeslet flow~(#ref(<fig-2>)b, blue curve), a solution of the Stokes equation that describes the generic fluid flow around an external force~(SI~Sec.~3.2.2). This force is related to the negative buoyancy of embryos. Indeed, the buoyant weight force $F_g = 1.7 plus.minus 0.4 thin$nN estimated from sedimentation speeds of immobilized embryos~(SI~Sec.~1.4) is close to the Stokeslet strength $F_("st") = 2.6 plus.minus 0.3 thin$nN obtained from fitting radial in-plane flow fields (#ref(<fig-1>)b, SI~Sec.~2.1.6).


The self-generated Stokeslet flow stabilizes the upright AP-axis orientation of embryos below the fluid surface~(SI~Sec.~2.1.6). In addition, it induces an effective long-ranged hydrodynamic attraction between embryos, facilitating the assembly of clusters. Similar effects have been observed previously for bacterial and algal microswimmers near rigid surfaces~@Petroff2015 @Drescher2009. Once two embryos are close together, their intrinsic spinning motions lead to an additional exchange of hydrodynamic forces and torques~(#ref(<fig-2>)d). Similar to pairs of _Volvox_ colonies near a rigid surface @Drescher2009 @Ishikawa2020, nearby starfish embryos orbit each other, and their spinning frequency decreases compared to that of a freely spinning embryo. The excess cilia-generated torque from slower rotating embryos~@Drescher2009 manifests itself in systematic azimuthal flow contributions~(#ref(<fig-2>)c). To confirm our understanding of these hydrodynamic interactions, we complemented the Stokeslet flow of each embryo with additional contributions that reflect the effects of hydrodynamic interactions (SI~Sec.~3.2.2, SI~Fig.~S5). Flow fields fitted via this approach show good quantitative agreement with experimental measurements~(#ref(<fig-2>)c, SI~Fig.~S6).


Based on these insights, we experimentally constrained a minimal model in which upright spinning embryos are represented by rigid disks interacting through hydrodynamic Stokeslet-mediated pairwise attraction, and through pairwise transverse force and torque exchanges~(SI~Sec.~2.2). Using the Stokeslet strength determined from fits as in #ref(<fig-2>)b, and a parameterization of transverse interactions based on rotation frequency measurements of bound pairs and triplets~(SI~Sec.~2.2.2), this minimal model predicts the self-organized formation of rotating clusters similar to those seen in the experiments~(#ref(<fig-2>)e). Assuming a cluster-size dependent reduction of the individual embryo's spinning activity to match whole-cluster rotation rates (SI Sec.~2.2.2), the model quantitatively captures the experimentally observed reduction of individual embryo rotation frequencies in both small and large clusters~(#ref(<fig-2>)f), as well as their collective translation into global cluster rotation rates~(#ref(<fig-2>)g).


To investigate how developmental changes of embryos contribute to the dissolution of a cluster, we followed the time-dependent morphology and hydrodynamics of embryos. Body shape anisotropies perpendicular to the AP axis increase almost five-fold over the course of experiments~(#ref(<fig-2>)h). Such anisotropies cause neighboring embryos to 'bump' into each other when closely packed and spinning within a cluster, introducing an effective source of noise in the LCC lattice. The increased interaction noise is particularly visible at cluster boundaries, where embryos become more and more tilted as their morphological development progresses~(#ref(<fig-2>)i), increasing their tendency to leave or to be scattered off a cluster. Using additional flow field measurements of single embryos at different time points~(SI~Sec.~3.3), we parameterized an orientational stability diagram that reveals a bistable nature of bound state orientations~(#ref(<fig-2>)j, SI~Sec.~2.1): In addition to a stable upright orientation ($theta = 0 degree$), downwards oriented stable orientations ($theta > 90 degree$) exist for which embryos are expected to swim away from the surface. These two orientations are separated by an unstable critical angle (#ref(<fig-2>)j, gray). The increase of effective noise as characterized in #ref(<fig-2>)j,h contributes to an increased rate at which embryos tilt beyond this critical angle and therefore represents a key factor in the eventual dissolution of clusters.


#pagebreak()
#align(center + horizon)[
// [figvision-cn] _ms_conv/imgs/Fig3.png
// 该图由七个子图（a至g）组成，展示了胚胎发育过程中晶体序
// 参数的时空演化。 子图 a 为五个不同时间点的胚胎示意图，
// 分别标记为 i, ii, iii, iv, v。每个胚胎由大量紧密排列的
// 六边形网格单元构成，代表细胞或晶格位点。部分单元被着色
// 以表示取向序参数 $\psi_6$ 的模值大小。颜色条位于右下角，
// 标注为“Magnitude of $\psi_6$”，范围从0到1，颜色从黑色
// 经黄色过渡到红色，数值越大颜色越红。在子图i中，仅有少
// 数几个点呈红色；随着发育进行至ii和iii，整体结构扩大，
// 但大部分区域保持浅色（低模值），边缘有少量高模值点；至
// iv和v阶段，胚胎形态变得不规则且破碎，出现大量深红色和
// 黑色斑点，表明局部序参量分布极不均匀。左下角有一根黑色
// 比例尺，标注长度为2mm。 子图 b 为热图（密度图），横轴
// 为时间（Time (hours)），范围0至35小时；纵轴为$\psi_6$
// 的模值（Magnitude of $\psi_6$），范围0至1。图中用颜色
// 深浅表示概率密度：深紫色代表低概率，亮橙红色代表高概率。
// 可见在约0–5小时内，高概率区域集中在模值接近1处；随后逐
// 渐下移，在约20小时后，高概率带稳定在模值0.4–0.6区间，
// 并持续至35小时。三条垂直虚线分别对应子图a中的时间点i、
// iii、v。右侧对数坐标轴显示概率值范围从$10^{-2.2}$到$10
// ^{0.2}$。 子图 c 同样为热图，横轴与b相同（时间0–35小时），
// 纵轴为$\psi_6$的相位（Phase of $\psi_6$），范围从-$\pi
// $到+$\pi$。颜色映射与b类似，深蓝代表低概率，亮黄绿代表
// 高概率。初期（<5h）相位集中分布在0附近；之后逐渐扩散，
// 形成一条随时间缓慢漂移的带状结构，表明平均相位发生系统
// 性变化。三条垂直虚线位置同b。 子图 d 为四个时间点的胚
// 胎示意图，布局与a相似但未编号。每个单元按$\psi_6$的相
// 位着色，颜色条位于右下角，标注“Phase of $\psi_6$”，范
// 围从-$\pi$（品红）经蓝色、绿色到+$\pi$（黄色）。早期胚
// 胎（左一）呈现局部有序色块；中期（左二、三）颜色混合更
// 均匀，但仍保留一定空间相关性；晚期（右一）颜色高度杂乱，
// 无明显大尺度相干区域，反映长程取向序丧失。左下角有黑色
// 比例尺，长度未标注数值但视觉上与a中比例尺相当。 子图 e
// 为曲线图，横轴为时间（Time (hours)），范围0至30+小时；
// 纵轴为平均 $|\psi_6|$（Mean $|\psi_6|$），范围0.6至1.0。
// 图中包含两条曲线：上方灰色实线代表原始数据波动，下方黑
// 色粗线为其平滑趋势。曲线从初始~0.95开始，在前10小时基
// 本持平，之后缓慢下降，至30小时降至约0.75，表明整体取向
// 序强度随发育减弱。 子图 f 为双Y轴复合图。主图（左侧Y轴）
// 为径向分布函数 g(r)，横轴 r (μm) 范围0至800 μm，纵轴 g
// (r) 范围0至6。黑色实线为实测g(r)，显示多个振荡峰，第一
// 个峰位于~200 μm，振幅~5；后续峰依次衰减。红色虚线为高
// 斯拟合曲线，仅覆盖第一峰区域。插图（右上角）展示第一峰
// 宽度随时间的变化：横轴时间（0–30小时），纵轴第一峰宽度
// （First peak width (μm)），范围10至40 μm。曲线单调上升，
// 从~15 μm增至~35 μm，表明局部结构弛豫加剧。 子图 g 为散
// 点加趋势线图，横轴时间（0–30小时），纵轴动态Lindemann
// 参数（Dynamic Lindemann parameter），范围0至0.5。黑色
// 散点密集分布，整体呈上升趋势：前10小时维持在0.1以下，
// 之后逐步攀升，至30小时达到0.4以上，表明原子/细胞级振动
// 幅度增大，晶体稳定性降低。
#figure(
  gap: 10pt,
  image("_ms_conv/imgs/Fig3.png", width: 100%),
  caption: [
    #strong[Crystalline order first increases and then decreases as embryos develop.] #strong[a,]~Embryo centroids at different time points color-coded by the magnitude of the orientational order parameter~$|psi_6|$ (SI~Sec.~3.6). Scale bar,~2mm. #strong[b] -- #strong[c,]~The measured probability distribution of $|psi_6|$ spreads to smaller values after about 20 hours, indicating a loss of bond-orientational order (#strong[b]). The ensuing drift of the mean phase angle (#strong[c]) signals dynamical restructuring of the crystal. #strong[d,]~Embryo centroids at different times color-coded by the phase of $psi_6$. Scale bar,~2mm. Time slices corresponding to snapshots (i-v) in #strong[a] and #strong[d] are indicated by white dotted lines. #strong[e,]~Average magnitude of $psi_6$ decays after $tilde 10$ hours, confirming a decrease in orientational order. Error bars indicate standard deviation. #strong[f,]~The widening of the first peak of the radial pair distribution function $g(r)$ indicates increased variation in the distance between nearest neighbors. Error bars indicate 95% confidence interval from Gaussian fit. Inset: Example pair distribution function, $g(r)$, and Gaussian fit to the first peak (SI~Sec.~3.7). #strong[g,]~The increase of the dynamic Lindemann parameter with developmental time signals a progressive destabilization of the crystal lattice. Error bars indicate standard deviation of 20 consecutive time points (SI~Sec.~3.8).
  ],
) <fig-3>
]
#pagebreak()


== Increase and decrease of crystalline order with development
<increase-and-decrease-of-crystalline-order-with-development>


A striking feature of the LCCs is that they nucleate, grow and dissolve naturally as embryos progressively develop (#ref(<fig-1>)a). To quantify the evolution of crystalline order, we calculated the local order parameter $psi_6(upright(bold(r))_i) = |psi_6|_i e^(i phi.alt_i)$ at embryo positions $upright(bold(r))_i$ in the co-rotating frame of the cluster (SI~Secs.~3.1~and~3.6). Measurements of $psi_6(upright(bold(r))_i)$ determine the local phase $phi.alt_i$ representing the crystal orientation, as well as the magnitude of hexagonal order $|psi_6|_i$~@nelson1979dislocation. Initially, small clusters merge together along different crystal axes, resulting in grain boundaries and broad distributions of $|psi_6|_i$ and $phi.alt_i$ (#ref(<fig-3>)a-d, (i)). Within 5~hours of crystal formation, LCCs undergo rapid internal restructuring during which subdomains align. This results in large, nearly defect-free crystals with a high degree of hexagonal order ($chevron.l |psi_6|_i chevron.r approx 0.9$) and a narrow distribution of local bond orientation (#ref(<fig-3>)a-d, (ii-iii)). This highly ordered state persists for several hours.


As development progresses, changes in morphology and surrounding flow fields (Figs.~1b and 2h) lead to a decreased crystalline order. Specifically, the probability density of $|psi_6|_i$ spreads to smaller values (#ref(<fig-3>)b,e $t > 20$ hours), quantitatively indicating a loss of orientational order. A similar spread is observed in the average phase angle $phi.alt_i$, indicating the loss of a well-defined, global crystal orientation~(#ref(<fig-3>)c, $t > 20$ hours). After about 30~hours, disorder dominates and the crystal dissolves over a period of 10~hours (#ref(<fig-3>)a-d, (iv-v)).


Furthermore, we identified a progressive loss of translational order prior to dissolution as quantified by the radial pair distribution function $g(r)$ (inset #ref(<fig-3>)f, SI~Sec.~3.7). Specifically, the first peak width of $g(r)$ -- representing the variability of nearest neighbor distances -- was found to increase with development (#ref(<fig-3>)f). Consequently, deviations from an ideal hexagonal lattice become more frequent and translational order is reduced as embryos develop.


To examine whether the evolution of orientational and translational order is also reflected in dynamic crystal properties, we determined the dynamic Lindemann parameter (SI~Sec.~3.8), which characterizes the strength of fluctuations in the crystal lattice~@zahn2000dynamic. In the crystalline phase (5-25h), the dynamic Lindemann parameter increases with time (#ref(<fig-3>)g) and indicates a progressive destabilization of the crystal lattice, consistent with the observed loss of orientational~(#ref(<fig-3>)e) and translational order~(#ref(<fig-3>)f), and with the increased interaction noise due to changes in the embryo morphology~(#ref(<fig-2>)h,i). Large fluctuations of the dynamic Lindemann parameter at early and late times are due to the small crystal sizes and the highly dynamic nature of growing and dissolving clusters.


Taken together, the systematic decay of orientational, translational and dynamic order with developmental time shows how morphological changes at the single-embryo level (Figs.~1b, 2h) can autonomously drive LCCs through a dissolution transition reminiscent of solid-gas phase transitions.




== Signatures of odd elasticity and emergence of chiral displacement waves
<signatures-of-odd-elasticity-and-emergence-of-chiral-displacement-waves>
Starfish embryos are inherently chiral and spin about their AP axis in a left-handed manner (Figs.~1d, 2a). This chiral spinning motion leads to distance-dependent, transverse lubrication interactions between pairs of embryos (#ref(<fig-2>)d). A coarse-graining of our minimal model~(SI Sec.~2.3) suggests that these interactions could lead to effective material properties of LCCs that emulate an odd elastic material~@Scheibner:2020gm @braverman2020topological. Odd elasticity theory complements the conventional elastic response of passive isotropic solids to compression and shear -- a bulk modulus $B$ and a shear modulus $mu$ -- by odd bulk and shear moduli $A$ and $K^o$, respectively. Odd elasticity can emerge in active isotropic solids that are chiral~@Scheibner:2020gm.

#pagebreak()
#align(center + horizon)[
// [figvision-cn] _ms_conv/imgs/Fig4.png
// 子图 a 为示意图与显微照片的叠加组合。左侧展示了一个六
// 边形区域内的细胞胚胎阵列，背景为灰度显微图像，其上覆盖
// 有白色 Delaunay 三角网格线。在区域中心附近有两个被高亮
// 标记的缺陷点：一个紫色圆点代表具有5个邻居的胚胎（五配
// 位），一个橙色圆点代表具有7个邻居的胚胎（七配位）。左
// 上角有一个放大的局部插图，显示一个粉色六边形单元及其周
// 围邻居，标注了剪切应变角 α_s 和旋转方向箭头。右侧是一
// 个简化的几何模型图，仅包含灰色节点和黑色连线构成的三角
// 晶格，同样标出紫色（5配位）和橙色（7配位）缺陷点。底部
// 有一条黑色比例尺，长度对应实际尺寸（未标注数值，但可推
// 断为毫米级）。该子图传达的核心信息是：通过追踪胚胎质心
// 位置并构建拓扑结构，可以识别出非六配位的缺陷点，这些缺
// 陷点处的局部剪切应变编码了材料的有效力学性质。 子图 b
// 为散点图叠加拟合曲线。横轴为“Orientation Angle φ”，范
// 围从0到π，单位为弧度；纵轴为“Shear Angle α_s”，范围从-
// π/2到π/2，单位为弧度。图中大量灰色小点表示实验测量数据，
// 分布呈周期性波动趋势。两条红色曲线分别代表理论模型预测：
// 实线为“Odd Elastic”（奇弹性）模型，虚线为“Passive
// Elastic”（被动弹性）模型。每条曲线上附有垂直误差棒，表
// 示标准差或置信区间。图例位于右下角，明确区分两种模型。
// 该子图表明：实验测得的剪切应变随取向角的变化规律与奇弹
// 性模型吻合良好，而与被动弹性模型存在显著偏差，尤其在φ=
// π/2附近出现明显凹陷，支持系统具有奇弹性的结论。 子图 c
// 为四幅热图组成的对比图，分为上下两行、左右两列。上行标
// 题为“Predicted”（预测），下行标题为“Measured”（测量）。
// 左列为“Divergence”（散度），右列为“Curl”（旋度）。每幅
// 热图均为圆形区域内的离散点阵，每个点用颜色表示物理量大
// 小，下方配有彩色条：左侧散度图颜色条范围从-0.13（深蓝）
// 到0.13（深红），右侧旋度图颜色条范围从-0.34（深蓝）到
// 0.34（深红）。所有热图均带有x-y坐标轴箭头指示方向。右
// 下角附有一条黑色比例尺。该子图显示：预测与测量的散度和
// 旋度场在空间分布上高度一致，尤其在高值区域（如中心偏右
// 的红点）和低值区域（如边缘的蓝点）匹配良好，验证了理论
// 模型对缺陷周围流场特征的准确性。 子图 d 为矢量场图与时
// 间序列图的组合。主图为一个不规则形状的二维区域，内部布
// 满彩色箭头，箭头方向表示位移角度，颜色由绿色经黄色过渡
// 到紫色，对应上方颜色条“Displacement angle”，范围从0到π。
// 左下角嵌入一个小线图：横轴为“Time (min)”，范围从-50到
// -25分钟；纵轴为“Displacement (μm)”，范围从-20到20微米。
// 图中绘制了一条振荡曲线，振幅约±15 μm，周期约为5分钟，
// 并在曲线上标注了三个时间点t₁、t₂、t₃。主图左侧有一个弯
// 曲箭头标注θ=0的方向。底部有一条黑色比例尺。该子图说明：
// 胚胎群体表现出集体振荡运动，位移幅度随时间周期性变化，
// 且整体位移场呈现螺旋状或涡旋状的空间模式，暗示存在长程
// 有序的动态响应。 子图 e 为两个水平堆叠的热图，共享同一
// 横轴“Time (min)”（范围-30至30分钟）和纵轴“Arc length (
// mm)”（范围0至20毫米）。上方热图标签为“Divergence”，下
// 方为“Curl”。右侧各有一个独立颜色条：散度图颜色条范围从
// -0.05（蓝）到0.05（红），旋度图颜色条范围从-0.05（蓝）
// 到0.05（红）。热图中可见明显的斜向条纹结构，表明散度和
// 旋度信号沿弧长和时间传播，形成波前。该子图揭示：缺陷附
// 近的散度和旋度扰动以波的形式向外传播，具有明确的时空演
// 化特征，符合弹性波动力学行为。 子图 f 为热图与局部放大
// 图的组合。主图为一个不规则形状区域的“Divergence”热图，
// 颜色条范围从0（绿）到2（红），单位未标明但应为无量纲归
// 一化值。图中标注“t_i = 0 mins”。右下角嵌入一个方形局部
// 放大图，显示更精细的网格结构，其中用虚线框标出一个矩形
// 区域，并用箭头指向该区域，旁边标注“Curl”。该子图强调：
// 在初始时刻（t_i=0），散度场在特定区域集中，而对应的旋
// 度场在该区域内也呈现结构化分布，两者空间关联性强，进一
// 步佐证缺陷作为源激发偶极子型应变波的观点。 子图 g 为两
// 个水平堆叠的热图，结构与子图e类似。横轴“Time (min)”范
// 围-30至30分钟，纵轴“Arc length (mm)”范围0至20毫米。上
// 方热图标签为“Shear 1”，下方为“Shear 2”。右侧颜色条范围
// 均为-0.05（蓝）到0.05（红）。热图中同样观察到斜向传播
// 的条纹，表明两种剪切分量均以波的形式演化。该子图补充说
// 明：除了散度和旋度外，剪切应变的两个分量也表现出类似的
// 波动特性，且相位关系可能反映奇弹性张量的非对称性。 子
// 图 h 为热图与局部放大图的组合，结构与子图f相似。主图为
// “Partial entropy production rate (x10⁻⁴ k_B/s)”热图，
// 颜色条范围从0（绿）到2（红），单位已注明。图中标注“t_i
// = 0 mins”。右下角嵌入局部放大图，标注“Shear 1”，并用虚
// 线框和箭头突出显示一个矩形区域。该子图指出：在初始时刻，
// 熵产率在特定区域达到峰值，且该区域与剪切应变1的高值区
// 重合，表明能量耗散主要发生在缺陷激发的应变波传播路径上，
// 符合非平衡态热力学的预期。
#figure(
  gap: 10pt,
  image("_ms_conv/imgs/Fig4.png", width: 100%),
  caption: [
    #strong[Defect strains and displacement waves exhibit signatures of odd elasticity.] #strong[a,]~Shear strain angles $alpha_s$ near a defect -- defined by a pair of embryos with 5 (purple) and~7 (orange) neighbors -- encode information about effective material properties. Left:~Delaunay triangulation overlaid with crystal. Right:~Embryo centroid positions (gray dots) collected over 80 min, black dots depict average positions identified as lattice sites (SI Sec.~3.11.1). Scale bar,~500 $mu$m. #strong[b,]~Measured shear angle $alpha_s$ seen along~$phi.alt$ for data in #strong[a] (gray dots) and averages at lattice sites (black symbols, error bars depict standard deviation). Dashed line:~$alpha_s(phi.alt)$ predicted for passive elastic solids (no fit parameter). Solid line:~Best fit including contributions from an isotropic odd elastic solid~@braverman2020topological (SI~Sec.~3.11.4). #strong[c,]~Odd elastic moduli obtained from fits of spatial shear strain profiles predict measured divergence and curl strain components with good quantitative agreement~(SI~Sec.~3.11.5). Scale bar,~0.4 mm. #strong[d,]~Snapshot of embryo displacements during cluster oscillations~(SI~Sec.~3.9). Inset: $x$- and $y$- displacement components of a representative embryo indicate robust oscillations with frequency $approx 0.26 thin "min"^(-1)$. Scale bar,~1 mm. #strong[e,]~Space-time kymographs of the strain components divergence and curl along the boundary (SI Sec.~3.9). Oscillation with similar amplitude are also present in the bulk~(SI Fig.~S10). #strong[f,]~Spatial map of the partial entropy production rate computed in the strain component space of curl and divergence (SI Sec.~3.12.1). Scale bar,~1 mm. Inset: Probability density current in the curl-divergence strain component space computed at the location of the black box shows a representative counter-clockwise strain cycle (SI~Sec.~3.12.2). #strong[g],#strong[h,]~An analogous analysis in the shear strain component space yields similar results as in~#strong[e] and~#strong[f].
  ],
) <fig-4>
]
#pagebreak()




To identify signatures of odd elasticity in our experimental data, we use the fact that LCCs typically harbor lattice defects~(Figs.~1d, 4a). The defects locally deform LCCs, with the deformation field encoding information about the effective material properties. We quantify deformations in the frame co-rotating with the cluster by measuring the displacement $upright(bold(u)) (upright(bold(r))_i , t) = (u_x , u_y)^top$ of embryos at position~$upright(bold(r))_i$ and time $t$ from a regular lattice (SI~Sec.~3.9). By computing the displacement gradient tensor $u_(i j) = partial_i u_j$ ($i = x , y$) (SI~Secs.~3.9, 3.11), relative deformations can be expressed in terms of four strain components#cite(<Scheibner:2020gm>): divergence ($u^0 = u_(x x) + u_(y y)$), curl/rotations ($u^1 = u_(y x) - u_(x y)$), and shear strain components “shear 1” ($u^2 = u_(x x) - u_(y y)$) and “shear 2” ($u^3 = u_(y x) + u_(x y)$). We first analyzed profiles of the local shear elongation angle $alpha_s(phi.alt) = upright("arg") (u^2 + i u^3) slash 2$ (#ref(<fig-4>)a, inset) measured at different lattice sites (#ref(<fig-4>)a) surrounding a defect pair. In a general isotropic linearly elastic solid, $alpha(phi.alt)$ is independent of the distance from the defect~@braverman2020topological and in a conventional passive solid, where all moduli except $B$ and $mu$ vanish, $alpha_s$ is parameter-free~@braverman2020topological (dashed line, #ref(<fig-4>)b). In contrast, our measured values of $alpha_s$ (#ref(<fig-4>)b, gray dots) averaged at lattice sites (black symbols) show a more complex pattern that can only be explained by allowing for a more exotic material response that may include nonvanishing odd moduli~@braverman2020topological (solid line, #ref(<fig-4>)b, SI~Sec.~3.11.4). We then fit in a second step the full spatial profiles of the shear strain components $u^2$ and~$u^3$ (SI~Sec.~3.11.5), which yields results consistent with the shear angle analysis (#ref(<fig-4>)b), and in addition provides the relative odd moduli estimates $A slash mu approx 8$ and $K^o slash mu approx 7$. Finally, we validate these fit results by predicting the remaining strain components $u^0$ and $u^1$ (#ref(<fig-4>)c, top) that had not been used so far and find very good quantitative agreement with experiments~(#ref(<fig-4>)c, bottom).


The presence of odd moduli raises the possibility that LCCs can support self-sustained chiral waves and strain cycles, similar to those recently predicted in odd elastic materials~@Scheibner:2020gm. In the displacement fields $upright(bold(u)) (upright(bold(r))_i , t)$ introduced above, we indeed observe the propagation of chiral displacement waves~(#ref(<fig-4>)d, SI~Secs.~3.9, 3.10) that persist for more than an hour. The existence of such waves in an overdamped LCC is a direct manifestation of its nonequilibrium nature. The frequency of the dominant, chiral modes~(SI~Fig.~S10), $0.28 thin "min"^(-1)$, is close to the spinning frequency of individual embryos within the cluster, $0.33 thin "min"^(-1)$, (SI~Sec.~3.4), suggesting that these modes are directly linked to the spinning motion of embryos.


A generic feature of systems with nonreciprocal interactions is that mechanical work can be extracted from quasistatic cyclic processes. Specifically, in materials with an odd elastic response, work can be extracted from cyclic deformations (strain cycles)~@Scheibner:2020gm~(SI~Sec.~2.2.1). To investigate whether strain cycles exist in an LCC, we determined the displacement gradient tensor, $u_(i j) = partial_i u_j$ with $i , j in(x , y)$. As evident from kymographs measured along the boundary (#ref(<fig-4>)e,g) and in the bulk (SI~Sec.~3.9) of the LCC, all strain components exhibit long-lived oscillation that span the whole cluster. Moreover, in the space of suitable strain component pairs (insets #ref(<fig-4>)f,h), strain cycles are found that have the same handedness almost everywhere in the cluster~(SI~Sec.~3.12.2). Such strain cycles are theoretically predicted as part of the chiral waves that odd elastic solids can support~@Scheibner:2020gm. Together with the signs of the measured odd moduli, $A , thin K^o > 0$, we conclude that oscillating LCCs are effectively doing work on the surrounding fluid~(SI~Sec.~2.3.1).


Strain waves in materials with finite odd elastic moduli can give rise to work and dissipation cycles~@Scheibner:2020gm. To quantify the lower bounds of the associated entropy production rates, we estimated the statistical irreversibility of strain cycles using recently developed frameworks of stochastic thermodynamics~@battle2016broken @Li:2019dy. By calculating the local phase-space currents in strain space~(SI~Sec.~3.12), we constructed spatial maps of the local entropy production rates arising in the relevant strain component spaces (#ref(<fig-4>)f,h). These maps reveal spatio-temporal variations of the entropy production rates, with higher rates appearing mostly in the vicinity of vacancy defects and boundary regions. Spatially integrated entropy production rates exhibit in both spaces temporal maxima during the period of most active wave propagation (SI~Fig.~S15).


== Discussion
<discussion>


Our combined experimental and theoretical results demonstrate how morphological changes in developing multicellular organisms can lead to the self-assembly and dissolution of living crystals with broken chiral symmetry. By observing starfish embryos over two days post gastrulation, we have identified hydrodynamic and morphological single-embryo properties that facilitate these self-organized processes. Over the course of several hours, thousands of embryos can come together to form a macroscopic non-equilibrium material that carries signatures of odd elasticity. Driven by the embryos' inherent activity, these living crystal structures support self-sustained chiral waves that exemplify upward energy transport from the individual microscopic constituents to the macro-scale. More broadly, such living chiral crystals can serve as a paradigmatic active matter system to elucidate principles of collective self-organization, nonequilibrium thermodynamics, and exotic material properties that emerge from nonreciprocal interactions.


#pagebreak()
== Acknowledgments
<acknowledgments>
We thank Colin Scheibner, William Irvine, Ned Wingreen, Jinghui Liu and Yu-Chen Chao for helpful discussions. This research was supported by the Sloan Foundation Grant (G-2021-16758) to N.F. and J.D., and the National Science Foundation CAREER Award to N.F.. T.H.T. acknowledges support from the NSF-Simons Center for Mathematical and Statistical Analysis of Biology at Harvard (award number 1764269) and Harvard Quantitative Biology Initiative as NSF-Simons Postdoctoral Fellow. T.H.T. acknowledges support from the Center for Systems Biology Dresden as ELBE Postdoctoral Fellow. A.M. acknowledges support from a Longterm Fellowship from the European Molecular Biology Organization (ALTF~528-2019) and a Postdoctoral Research Fellowship from the Deutsche Forschungsgemeinschaft (Project~431144836). Y.C. acknowledges support from MIT Department of Physics Curtis Marble Fellowship. P.J.F. and S.G. acknowledge support from the Gordon and Betty Moore Foundation as Physics of Living Systems Fellows through grant no. GBMF4513. J.D. was supported by the Robert E. Collins Distinguished Scholarship fund. N.F., J.D. and S.G. are grateful to KITP program ‘ACTIVE20: Symmetry, Thermodynamics and Topology in Active Matter', supported in part by the National Science Foundation under grant no. NSF PHY-1748958. We thank the MIT SuperCloud~@Reuther2018 for providing access to its HPC resources.


#heading(level: 1)[References]
#bibliography("refs.bib", style: "plain-unsrt.csl", title: none)

#pagebreak()
#counter(page).update(1)
#set page(margin: (x: 93.7pt, top: 70.3pt, bottom: 62pt))
#counter(heading).update(0)
#counter(figure.where(kind: image)).update(0)
#counter(math.equation).update(0)
#set heading(numbering: "1.1.1")
#show figure.caption: set text(size: 10.26pt)
#include "supplement.typ"
