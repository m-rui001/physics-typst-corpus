#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.31cm, bottom: 2.56cm), columns: 2)
#set page(numbering: none, header-ascent: 15pt, header: context {
  let n = counter(page).get().first()
  if n > 1 {
    let num = text(10pt, counter(page).display())
    let mid = if calc.odd(n) [NANOGrav 15-year Gravitational-Wave Background] else [The NANOGrav Collaboration]
    grid(columns: (1fr, auto, 1fr),
      if calc.odd(n) { [] } else { num },
      align(center, text(10pt, mid)),
      if calc.odd(n) { align(right, num) } else { [] })
  }
})
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("1.", p.at(0)) } else { numbering("1.1", ..p) } })
// appendix equations are numbered <letter><n>, e.g. (B1), (C2)
#let appeq = state("appendix-letter", none)
#let eqoff = state("appendix-eq-offset", 0)
#let eqnum(n) = {
  let l = appeq.get()
  if l == none { str(n) } else { l + str(n - eqoff.get()) }
}
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { numbering(it.numbering, ..counter(heading).at(it.location())) }
  let dot = if it.supplement == [Appendix] { [.] } else { [] }
  if it.supplement == [Appendix] {
    if appeq.get() == none {
      eqoff.update(counter(math.equation).at(it.location()).first())
    }
    appeq.update(numbering("A", counter(heading).at(it.location()).first()))
  }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "regular")[#num#dot #it.body]])
}
#show heading.where(level: 2): it => {
  let num = if it.numbering == none { [] } else { numbering(it.numbering, ..counter(heading).at(it.location())) }
  let dot = if it.numbering == none { [] } else { [.] }
  block(width: 100%, above: 1em, below: 0.5em, align(left)[#text(size: 10pt, weight: "regular")[#num#dot #it.body]])
}

#set figure(placement: auto)
#set figure(kind: figure)
#set figure(supplement: [Figure])
#set par(justify: true, spacing: 1.02em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.59em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show figure.caption: set text(size: 9pt)
#set figure(placement: auto)
#set math.equation(numbering: n => "(" + eqnum(n) + ")", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context {
      let n = counter(math.equation).at(e.location()).first()
      let l = appeq.at(e.location())
      if l == none { n } else { l + str(n - eqoff.at(e.location())) }
    })]
  } else { it }
}
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9pt)

#set page(columns: 1)
#place(bottom + left, scope: "parent", float: true)[
  #text(8pt)[Corresponding author: The NANOGrav Collaboration] \
  #text(8pt, "comments@nanograv.org")
]
#block(width: 100%)[
  #text(8pt)[#upper[Draft version June 29, 2023]] \
  #text(8pt)[#upper[Typeset using LaTeX twocolumn style in AASTeX63]]
]
#v(1.8em)
#align(center)[
      #text(10pt, weight: "bold", [The NANOGrav 15-year Data Set: Evidence for a Gravitational-Wave Background])   #v(1.2em)
      #text(8pt)[#upper[
    #set par(leading: 0.73em)
    Gabriella Agazie#super[1], Akash Anumarlapudi#super[1], Anne M. Archibald#super[2], Zaven Arzoumanian#super[3], Paul T. Baker#super[4], Bence Bécsy#super[5], Laura Blecha#super[6], Adam Brazier#super[7,8], Paul R. Brook#super[9], Sarah Burke-Spolaor#super[10,11], Rand Burnette#super[5], Robin Case#super[5], Maria Charisi#super[12], Shami Chatterjee#super[7], Katerina Chatziioannou#super[13], Belinda D. Cheeseboro#super[10,11], Siyuan Chen#super[14], Tyler Cohen#super[15], James M. Cordes#super[7], Neil J. Cornish#super[16], Fronefield Crawford#super[17], H. Thankful Cromartie#super[7], Kathryn Crowter#super[18], Curt J. Cutler#super[13,19], Megan E. DeCesar#super[20], Dallas DeGan#super[5], Paul B. Demorest#super[21], Heling Deng#super[5], Timothy Dolch#super[22,23], Brendan Drachler#super[24,25], Justin A. Ellis#super[26], Elizabeth C. Ferrara#super[27,28,29], William Fiore#super[10,11], Emmanuel Fonseca#super[10,11], Gabriel E. Freedman#super[1], Nate Garver-Daniels#super[10,11], Peter A. Gentile#super[10,11], Kyle A. Gersbach#super[12], Joseph Glaser#super[10,11], Deborah C. Good#super[30,31], Kayhan Gültekin#super[32], Jeffrey S. Hazboun#super[5], Sophie Hourihane#super[13], Kristina Islo#super[1], Ross J. Jennings#super[10,11], Aaron D. Johnson#super[1,13], Megan L. Jones#super[1], Andrew R. Kaiser#super[10,11], David L. Kaplan#super[1], Luke Zoltan Kelley#super[33], Matthew Kerr#super[34], Joey S. Key#super[35], Tonia C. Klein#super[1], Nima Laal#super[5], Michael T. Lam#super[24,25], William G. Lamb#super[12], T. Joseph W. Lazio#super[19], Natalia Lewandowska#super[36], Tyson B. Littenberg#super[37], Tingting Liu#super[10,11], Andrea Lommen#super[38], Duncan R. Lorimer#super[10,11], Jing Luo#super[39], Ryan S. Lynch#super[40], Chung-Pei Ma#super[33,41], Dustin R. Madison#super[42], Margaret A. Mattson#super[10,11], Alexander McEwen#super[1], James W. McKee#super[43,44], Maura A. McLaughlin#super[10,11], Natasha McMann#super[12], Bradley W. Meyers#super[18,45], Patrick M. Meyers#super[13], Chiara M. F. Mingarelli#super[30,31,46], Andrea Mitridate#super[47], Priyamvada Natarajan#super[48,49], Cherry Ng#super[50], David J. Nice#super[51], Stella Koch Ocker#super[7], Ken D. Olum#super[52], Timothy T. Pennucci#super[53], Benetge B. P. Perera#super[54], Polina Petrov#super[12], Nihan S. Pol#super[12], Henri A. Radovan#super[55], Scott M. Ransom#super[56], Paul S. Ray#super[34], Joseph D. Romano#super[57], Shashwat C. Sardesai#super[1], Ann Schmiedekamp#super[58], Carl Schmiedekamp#super[58], Kai Schmitz#super[59], Levi Schult#super[12], Brent J. Shapiro-Albert#super[10,11,60], Xavier Siemens#super[1,5], Joseph Simon#super[61], Magdalena S. Siwek#super[62], Ingrid H. Stairs#super[18], Daniel R. Stinebring#super[63], Kevin Stovall#super[21], Jerry P. Sun#super[5], Abhimanyu Susobhanan#super[1], Joseph K. Swiggum#super[51], Jacob Taylor#super[5], Stephen R. Taylor#super[12], Jacob E. Turner#super[10,11], Caner Unal#super[64,65], Michele Vallisneri#super[13,19], Rutger van~Haasteren#super[66], Sarah J. Vigeland#super[1], Haley M. Wahl#super[10,11], Qiaohong Wang#super[12], Caitlin A. Witt#super[67,68], Olivia Young#super[24,25]
      ]]
      #v(0.9em)
      #text(9pt)[#upper[The NANOGrav Collaboration]]
      #v(1.2em)
      #text(6pt)[
#block(width: 100%)[#align(center)[#set text(style: "italic")
#set par(leading: 0.95em)
#super[1]Center for Gravitation, Cosmology and Astrophysics, Department of Physics, University of Wisconsin-Milwaukee, P.O. Box 413, Milwaukee, WI 53201, USA \
        #super[2]Newcastle University, NE1 7RU, UK \
        #super[3]X-Ray Astrophysics Laboratory, NASA Goddard Space Flight Center, Code 662, Greenbelt, MD 20771, USA \
        #super[4]Department of Physics and Astronomy, Widener University, One University Place, Chester, PA 19013, USA \
        #super[5]Department of Physics, Oregon State University, Corvallis, OR 97331, USA \
        #super[6]Physics Department, University of Florida, Gainesville, FL 32611, USA \
        #super[7]Cornell Center for Astrophysics and Planetary Science and Department of Astronomy, Cornell University, Ithaca, NY 14853, USA \
        #super[8]Cornell Center for Advanced Computing, Cornell University, Ithaca, NY 14853, USA \
        #super[9]Institute for Gravitational Wave Astronomy and School of Physics and Astronomy, University of Birmingham, Edgbaston, Birmingham B15 2TT, UK \
        #super[10]Department of Physics and Astronomy, West Virginia University, P.O. Box 6315, Morgantown, WV 26506, USA \
        #super[11]Center for Gravitational Waves and Cosmology, West Virginia University, Chestnut Ridge Research Building, Morgantown, WV 26505, USA \
        #super[12]Department of Physics and Astronomy, Vanderbilt University, 2301 Vanderbilt Place, Nashville, TN 37235, USA \
        #super[13]Division of Physics, Mathematics, and Astronomy, California Institute of Technology, Pasadena, CA 91125, USA \
        #super[14]Kavli Institute for Astronomy and Astrophysics, Peking University, Beijing, 100871 China \
        #super[15]Department of Physics, New Mexico Institute of Mining and Technology, 801 Leroy Place, Socorro, NM 87801, USA \
        #super[16]Department of Physics, Montana State University, Bozeman, MT 59717, USA \
        #super[17]Department of Physics and Astronomy, Franklin \& Marshall College, P.O. Box 3003, Lancaster, PA 17604, USA \
        #super[18]Department of Physics and Astronomy, University of British Columbia, 6224 Agricultural Road, Vancouver, BC V6T 1Z1, Canada \
        #super[19]Jet Propulsion Laboratory, California Institute of Technology, 4800 Oak Grove Drive, Pasadena, CA 91109, USA \
        #super[20]George Mason University, resident at the Naval Research Laboratory, Washington, DC 20375, USA \
        #super[21]National Radio Astronomy Observatory, 1003 Lopezville Rd., Socorro, NM 87801, USA \
        #super[22]Department of Physics, Hillsdale College, 33 E. College Street, Hillsdale, MI 49242, USA \
        #super[23]Eureka Scientific, 2452 Delmer Street, Suite 100, Oakland, CA 94602-3017, USA \
        #super[24]School of Physics and Astronomy, Rochester Institute of Technology, Rochester, NY 14623, USA \
        #super[25]Laboratory for Multiwavelength Astrophysics, Rochester Institute of Technology, Rochester, NY 14623, USA \
        #super[26]Bionic Health, 800 Park Offices Drive, Research Triangle Park, NC 27709 \
        #super[27]Department of Astronomy, University of Maryland, College Park, MD 20742 \
        #super[28]Center for Research and Exploration in Space Science and Technology, NASA/GSFC, Greenbelt, MD 20771 \
        #super[29]NASA Goddard Space Flight Center, Greenbelt, MD 20771, USA \
        #super[30]Department of Physics, University of Connecticut, 196 Auditorium Road, U-3046, Storrs, CT 06269-3046, USA \
        #super[31]Center for Computational Astrophysics, Flatiron Institute, 162 5th Avenue, New York, NY 10010, USA \
        #super[32]Department of Astronomy and Astrophysics, University of Michigan, Ann Arbor, MI 48109, USA \
        #super[33]Department of Astronomy, University of California, Berkeley, 501 Campbell Hall \#3411, Berkeley, CA 94720, USA \
        #super[34]Space Science Division, Naval Research Laboratory, Washington, DC 20375-5352, USA \n#super[35]University of Washington Bothell, 18115 Campus Way NE, Bothell, WA 98011, USA \
        #super[36]Department of Physics, State University of New York at Oswego, Oswego, NY, 13126, USA \
        #super[37]NASA Marshall Space Flight Center, Huntsville, AL 35812, USA \
        #super[38]Department of Physics and Astronomy, Haverford College, Haverford, PA 19041, USA \
        #super[39]Department of Astronomy \& Astrophysics, University of Toronto, 50 Saint George Street, Toronto, ON M5S 3H4, Canada \
        #super[40]Green Bank Observatory, P.O. Box 2, Green Bank, WV 24944, USA \
        #super[41]Department of Physics, University of California, Berkeley, CA 94720, USA \
        #super[42]Department of Physics, University of the Pacific, 3601 Pacific Avenue, Stockton, CA 95211, USA \
        #super[43]E.A. Milne Centre for Astrophysics, University of Hull, Cottingham Road, Kingston-upon-Hull, HU6 7RX, UK \
        #super[44]Centre of Excellence for Data Science, Artificial Intelligence and Modelling (DAIM), University of Hull, Cottingham Road, Kingston-upon-Hull, HU6 7RX, UK \
        #super[45]International Centre for Radio Astronomy Research, Curtin University, Bentley, WA 6102, Australia \
        #super[46]Department of Physics, Yale University, New Haven, CT 06520, USA \
        #super[47]Deutsches Elektronen-Synchrotron DESY, Notkestr. 85, 22607 Hamburg, Germany \
        #super[48]Department of Astronomy, Yale University, 52 Hillhouse Ave, New Haven, CT 06511 \
        #super[49]Black Hole Initiative, Harvard University, 20 Garden Street, Cambridge, MA 02138 \
        #super[50]Dunlap Institute for Astronomy and Astrophysics, University of Toronto, 50 St. George St., Toronto, ON M5S 3H4, Canada \
        #super[51]Department of Physics, Lafayette College, Easton, PA 18042, USA \
        #super[52]Institute of Cosmology, Department of Physics and Astronomy, Tufts University, Medford, MA 02155, USA \
        #super[53]Institute of Physics and Astronomy, Eötvös Loránd University, Pázmány P. s. 1/A, 1117 Budapest, Hungary \
        #super[54]Arecibo Observatory, HC3 Box 53995, Arecibo, PR 00612, USA \
        #super[55]Department of Physics, University of Puerto Rico, Mayagüez, PR 00681, USA \
        #super[56]National Radio Astronomy Observatory, 520 Edgemont Road, Charlottesville, VA 22903, USA \
        #super[57]Department of Physics, Texas Tech University, Box 41051, Lubbock, TX 79409, USA \
        #super[58]Department of Physics, Penn State Abington, Abington, PA 19001, USA \
        #super[59]Institute for Theoretical Physics, University of Münster, 48149 Münster, Germany \
        #super[60]Giant Army, 915A 17th Ave, Seattle WA 98122 \
        #super[61]Department of Astrophysical and Planetary Sciences, University of Colorado, Boulder, CO 80309, USA \
        #super[62]Center for Astrophysics, Harvard University, 60 Garden St, Cambridge, MA 02138 \
        #super[63]Department of Physics and Astronomy, Oberlin College, Oberlin, OH 44074, USA \
        #super[64]Department of Physics, Ben-Gurion University of the Negev, Be'er Sheva 84105, Israel \
        #super[65]Feza Gursey Institute, Bogazici University, Kandilli, 34684, Istanbul, Turkey \
        #super[66]Max-Planck-Institut für Gravitationsphysik (Albert-Einstein-Institut), Callinstrasse 38, D-30167, Hannover, Germany \
        #super[67]Center for Interdisciplinary Exploration and Research in Astrophysics (CIERA), Northwestern University, Evanston, IL 60208 \
        #super[68]Adler Planetarium, 1300 S. DuSable Lake Shore Dr., Chicago, IL 60605, USA
    ]]]
  ]
#align(center)[#text(10pt, weight: "bold")[ABSTRACT]]
    #v(0.4em)
    #block(width: 86%, inset: (x: 0.7em))[
      #set text(size: 10pt)
      #set align(left)
      We report multiple lines of evidence for a stochastic signal that is correlated among 67 pulsars from the 15-year pulsar-timing data set collected by the North American Nanohertz Observatory for Gravitational Waves. The correlations follow the Hellings--Downs pattern expected for a stochastic gravitational-wave background. The presence of such a gravitational-wave background with a power-law--spectrum is favored over a model with only independent pulsar noises with a Bayes factor in excess of $10^(14)$, and this same model is favored over an uncorrelated common power-law--spectrum model with Bayes factors of 200--1000, depending on spectral modeling choices. We have built a statistical background distribution for these latter Bayes factors using a method that removes inter-pulsar correlations from our data set, finding $p = 10^(- 3)$ (approx.~$3 sigma$) for the observed Bayes factors in the null no-correlation scenario. A frequentist test statistic built directly as a weighted sum of inter-pulsar correlations yields $p = 5 times 10^(- 5)$--$1.9 times 10^(- 4)$ (approx.~$3.5$--$4 sigma$). Assuming a fiducial $f^(- 2\/3)$ characteristic-strain spectrum, as appropriate for an ensemble of binary supermassive black-hole inspirals, the strain amplitude is $2.4_(-0.6)^(+0.7) times 10^(-15)$ (median + 90\% credible interval) at a reference frequency of 1 $"yr"^(- 1)$. The inferred gravitational-wave background amplitude and spectrum are consistent with astrophysical expectations for a signal from a population of supermassive black-hole binaries, although more exotic cosmological and astrophysical sources cannot be excluded. The observation of Hellings--Downs correlations points to the gravitational-wave origin of this signal.
    ]
    #v(0.5em)
#block(width: 86%, inset: (x: 0.7em))[
  #set text(size: 10pt)
  #emph[Keywords:] Gravitational waves -- Black holes -- Pulsars
]

#pagebreak()
#set page(columns: 2)
= INTRODUCTION <sec:intro>



 Almost a century had to elapse between Einstein's prediction of gravitational waves (GWs, #cite(<einstein1916approximative>, style: "aas_noparen.csl")) and their measurement from a coalescing binary of stellar-mass black holes #cite(<2016PhRvL.116f1102A>). However, their existence had been confirmed in the late 1970s through measurements of the orbital decay of the Hulse--Taylor binary pulsar #cite(<1975ApJ...195L..51H>)#cite(<1979Natur.277..437T>). Today, pulsars are again at the forefront of the quest to detect GWs, this time from binary systems of central galactic black holes.

// [figvision-cn] imgs/nano15_14f_cornerplot_2amps_vg_fg_flat.png
// 这是一张用于展示引力波背景（GWB）信号统计分析结果的组
// 合图，主图由三个相互连接的子图构成，分别为左侧的主二维
// 后验分布图、上方的边缘一维后验分布图和右侧的边缘一维后
// 验分布图。整张图用以展示不同参考频率下，引力波背景谱指
// 数与振幅的联合约束。 左侧主二维图描述： 类型为二维等高
// 线图与后验分布图。横轴为 GWB 谱指数（γ_GWB），刻度范围
// 显示为 3.0 至 4.5 之间，主要刻度标注有 2.5、3.0、3.5、
// 4.0、4.5；纵轴为 GWB 振幅的对数（log10 A_GWB），刻度标
// 签从下至上依次为 -14.8、-14.6、-14.4、-14.2、-14.0、
// -13.8。图中有两组等高线，分别对应两个不同参考频率的模
// 型：蓝色实线组对应 f_ref = 1 yr^-1 ≈ 32 nHz，橙色实线
// 组对应 f_ref = 0.1 yr^-1 ≈ 3.2 nHz。每组等高线代表二维
// 后验分布的置信区间，从内到外分别对应 1σ、2σ、3σ 区域，
// 分布呈现负相关倾斜的椭圆状。图中还包含一条垂直的黑色虚
// 线，位于 γ_GWB 约为 4.33 的位置。此外，图中还有灰色小
// 提琴图（背景分布），表示各独立频率区间的后验分布，但当
// 前截图未能完整显示出所有小提琴，仅可见两到三个。右上角
// 有箭头标注文字 γ_GWB = 13/3，箭头指向该垂直虚线，表示
// 谱指数理论值 4.333 的位置。 上方一维图描述： 类型为边
// 缘一维后验分布曲线。横轴与左侧主图的 γ_GWB 刻度对齐，
// 但无数字标签；纵轴为概率密度，无具体数值刻度。图中有一
// 条蓝色实线曲线，展示在 f_ref = 1 yr^-1 条件下 γ_GWB 的
// 一维边缘后验概率密度。曲线在 γ_GWB ≈ 3.5 附近达到峰值，
// 曲线向右侧延伸至垂直虚线（13/3）处，且分布具有明显的非
// 对称性，右尾较长，峰值处与垂直虚线之间有一定距离。 右
// 侧一维图描述： 类型为边缘一维后验分布曲线，方向为垂直。
// 纵轴与左侧主图的 log10 A_GWB 刻度对齐，横轴为概率密度，
// 无具体数字刻度。图中有两条曲线：一条是蓝色实线曲线，对
// 应 f_ref = 1 yr^-1，其峰值对应的振幅约为 log10 A_GWB ≈
// -14.2 附近；另一条是橙色实线曲线，对应 f_ref = 0.1 yr^
// -1，其峰值对应的振幅约为 log10 A_GWB ≈ -14.4 附近。图
// 中还有两条蓝色虚线曲线，分别向上下两侧延伸，位于主蓝色
// 实线包络之外，可能对应不同先验或不同分析设置的边界情况。
// 在右侧图的上方，有两个向下指出的垂直箭头，文字标注为 γ
// _GWB = 13/3，其指向的纵向位置与左侧主图中谱指数为 13/3
// 对应的振幅区域对应，但具体箭头是否指代特定曲线的峰值尚
// 不完全明确，推测是在指示谱指数理论值对应的振幅约束范围。
// 图中所有蓝色和橙色分布均呈非对称形态，蓝色主峰略向低振
// 幅方向偏斜。
// [figvision-cn] imgs/nano15_14f_fg_oscrosscor_paircorr_fig1.png
// 这是一张关于脉冲星计时阵列数据的科学图表，主要展示了脉
// 冲星对之间的空间相关性随角分离的变化。以下是详细描述：
// 图表类型为带有误差棒的散点图和拟合曲线图。横轴（X轴）
// 名称为“Separation Angle Between Pulsars, ξ_ab [degrees
// ]”（脉冲星之间的分离角，ξ_ab，单位为度），范围从 0 到
// 180 度，主刻度间隔为 30 度，并在 0、30、60、90、120、
// 150、180 处标有数字标签。纵轴（Y轴）名称为“Γ(ξ_ab)”（
// 相关函数 Γ 关于分离角 ξ_ab 的值），范围从 -0.4 到 0.8，
// 主刻度间隔为 0.2，并在 -0.4、-0.2、0.0、0.2、0.4、0.6、
// 0.8 处标有数字标签。图表内部在 Y = 0.0 处有一条贯穿整
// 个横轴的黑色水平实线，作为零基准线。 图中包含两种主要
// 的数据元素： 观测数据点：用蓝色的实心圆点表示，每个点
// 都带有垂直的蓝色误差棒，误差棒两端有水平短线作为“帽”。
// 这些点分布在不同的分离角上，显示了各个角度下的相关性测
// 量值及其不确定性。 理论拟合曲线：一条黑色的粗虚线（短
// 划线），代表预期的理论模型。在右上角附近有文字标注“γ =
// 13/3”，表示该理论曲线对应的参数。 数据趋势和结论：随着
// 脉冲星分离角从 0 度增加到约 90 度，理论曲线（黑色虚线）
// 从约 0.5 逐渐下降，在约 90 度时达到最小值（约 -0.15），
// 随后随着角度继续增加至 180 度，曲线又开始回升，最终在
// 180 度时达到约 0.25。图中的蓝色数据点及其误差棒总体上
// 遵循这一理论曲线的 U 型（或余弦型）趋势，尽管在某些角
// 度（如 150 度左右）数据点存在较大的波动和误差范围。这
// 一趋势通常用于验证引力波背景（如 Hellings-Downs 曲线）
// 的存在。
// [figvision-cn] imgs/nano15_hd_freespec_fig1.png
// 这是一张呈现科学论文核心分析结果的子图（对应原图注中的
// 子图a），类型为带有后验分布的小提琴图与曲线叠加图。该
// 图旨在展示在15年NANOGrav数据集中，自由谱（
// free-spectrum）贝叶斯分析得到的各频率独立时间延迟后验
// 分布，并与预期的Hellings-Downs频谱及幂律模型进行对比。
// 坐标轴设置：横轴为频率的对数（log10(Frequency [Hz])），
// 范围从-8.75延伸至-7.60左右，主要刻度标记在-8.75、-8.50、
// -8.25、-8.00、-7.75。纵轴为超额时间延迟的对数（log10(
// Excess timing delay [s])），范围从-9.0延伸至-5.0左右，
// 主要刻度标记在-9、-8、-7、-6。 图中包含以下关键元素及
// 物理含义： 灰色小提琴图（gray violins）：代表每个独立
// 频率 bin 下超额时间延迟的后验概率密度分布。共有约14个
// 离散的频率点（横轴对应的位置），每个小提琴图的宽度表示
// 该时间延迟取值的概率密度大小，其中心垂直的灰线通常代表
// 中位数或置信区间。灰色小提琴图的分布范围在纵轴上大致覆
// 盖了 -6.5 到 -8.5 的区间，且随着频率升高（横轴向右），
// 分布逐渐变窄且中心值下降。 浅蓝色实线及浅蓝色阴影带（
// Power-law posterior）：代表幂律模型的后验分布。中心浅
// 蓝色曲线为幂律模型的最佳拟合/中值谱，其周围的浅蓝色半
// 透明阴影区域表示后验的置信区间（例如 1σ 或 2σ 区域）。
// 该曲线呈直线下降趋势，在图中沿对角线方向延伸。 黑色虚
// 线（Median power-law amplitude; γ = 13/3）：代表幂律模
// 型的中值幅度谱，其幂律指数固定为 γ = 13/3。该虚线与浅
// 蓝色实线走势平行且高度吻合，贯穿整个频率范围。 灰色实
// 线（Hellings-Downs spectrum）：位于图例中，代表理论预
// 期的 Hellings-Downs 相关频谱形状。在具体图表中，该谱线
// 以灰色小提琴图的中心趋势为参考，但图例明确指示了其谱形
// 特征。 趋势与结论：图中灰色小提琴图（各频率独立后验）
// 的中心分布与倾斜向下的浅蓝色幂律后验带以及黑色虚线（γ=
// 13/3）高度重合，没有出现显著的偏离。这种各频率独立后验
// 分布整体遵循 γ=13/3 的幂律衰减趋势，且与
// Hellings-Downs 频谱预期一致，为数据中存在
// Hellings-Downs 相关性提供了关键的贝叶斯证据。图例位于
// 右上角，包含三行：第一行为灰色实线，标注“
// Hellings-Downs spectrum”；第二行为浅蓝色实线，标注“
// Power-law posterior”；第三行为黑色虚线，标注“Median
// power-law amplitude; γ = 13/3”。图中无其他额外文字标注。
// [figvision-cn] imgs/nano15_14f_cornerplot_2amps_vg_fg_flat.png
// 这是一张用于展示引力波背景（GWB）信号统计分析结果的组
// 合图，主图由三个相互连接的子图构成，分别为左侧的主二维
// 后验分布图、上方的边缘一维后验分布图和右侧的边缘一维后
// 验分布图。整张图用以展示不同参考频率下，引力波背景谱指
// 数与振幅的联合约束。 左侧主二维图描述： 类型为二维等高
// 线图与后验分布图。横轴为 GWB 谱指数（γ_GWB），刻度范围
// 显示为 3.0 至 4.5 之间，主要刻度标注有 2.5、3.0、3.5、
// 4.0、4.5；纵轴为 GWB 振幅的对数（log10 A_GWB），刻度标
// 签从下至上依次为 -14.8、-14.6、-14.4、-14.2、-14.0、
// -13.8。图中有两组等高线，分别对应两个不同参考频率的模
// 型：蓝色实线组对应 f_ref = 1 yr^-1 ≈ 32 nHz，橙色实线
// 组对应 f_ref = 0.1 yr^-1 ≈ 3.2 nHz。每组等高线代表二维
// 后验分布的置信区间，从内到外分别对应 1σ、2σ、3σ 区域，
// 分布呈现负相关倾斜的椭圆状。图中还包含一条垂直的黑色虚
// 线，位于 γ_GWB 约为 4.33 的位置。此外，图中还有灰色小
// 提琴图（背景分布），表示各独立频率区间的后验分布，但当
// 前截图未能完整显示出所有小提琴，仅可见两到三个。右上角
// 有箭头标注文字 γ_GWB = 13/3，箭头指向该垂直虚线，表示
// 谱指数理论值 4.333 的位置。 上方一维图描述： 类型为边
// 缘一维后验分布曲线。横轴与左侧主图的 γ_GWB 刻度对齐，
// 但无数字标签；纵轴为概率密度，无具体数值刻度。图中有一
// 条蓝色实线曲线，展示在 f_ref = 1 yr^-1 条件下 γ_GWB 的
// 一维边缘后验概率密度。曲线在 γ_GWB ≈ 3.5 附近达到峰值，
// 曲线向右侧延伸至垂直虚线（13/3）处，且分布具有明显的非
// 对称性，右尾较长，峰值处与垂直虚线之间有一定距离。 右
// 侧一维图描述： 类型为边缘一维后验分布曲线，方向为垂直。
// 纵轴与左侧主图的 log10 A_GWB 刻度对齐，横轴为概率密度，
// 无具体数字刻度。图中有两条曲线：一条是蓝色实线曲线，对
// 应 f_ref = 1 yr^-1，其峰值对应的振幅约为 log10 A_GWB ≈
// -14.2 附近；另一条是橙色实线曲线，对应 f_ref = 0.1 yr^
// -1，其峰值对应的振幅约为 log10 A_GWB ≈ -14.4 附近。图
// 中还有两条蓝色虚线曲线，分别向上下两侧延伸，位于主蓝色
// 实线包络之外，可能对应不同先验或不同分析设置的边界情况。
// 在右侧图的上方，有两个向下指出的垂直箭头，文字标注为 γ
// _GWB = 13/3，其指向的纵向位置与左侧主图中谱指数为 13/3
// 对应的振幅区域对应，但具体箭头是否指代特定曲线的峰值尚
// 不完全明确，推测是在指示谱指数理论值对应的振幅约束范围。
// 图中所有蓝色和橙色分布均呈非对称形态，蓝色主峰略向低振
// 幅方向偏斜。
// Power-law posterior”；第三行为黑色虚线，标注“Median
// power-law amplitude; γ = 13/3”。图中无其他额外文字标注。
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

#figure(placement: auto, supplement: [Figure], [
  #table(
    columns: 2,
    align: center,
    stroke: none,
    [#strong[(a)]], [#strong[(c)]],
    [#box(image("imgs/nano15_hd_freespec_fig1.png", width: 100%))], [#box(image("imgs/nano15_14f_fg_oscrosscor_paircorr_fig1.png", width: 100%))],
    [#strong[(b)]], [#strong[(d)]],
    [#box(image("imgs/nano15_14f_cornerplot_2amps_vg_fg_flat.png", width: 100%))], [#box(image("imgs/nano15_splineorf_vg_violinplot_fig1.png", width: 100%))],
  )
], caption: [
  Summary of the main Bayesian and optimal-statistic analyses presented in this paper, which establish multiple lines of evidence for the presence of Hellings--Downs correlations in the 15-year NANOGrav data set. Throughout we refer to the $68.3 \%$, $95.4 \%$, and $99.7 \%$ regions of distributions as $1\/2\/3 sigma$ regions, even in two dimensions. #strong[(a)]: Bayesian "free-spectrum" analysis, showing posteriors (gray violins) of independent variance parameters for a Hellings--Downs-correlated stochastic process at frequencies $i \/ T$, with $T$ the total data set time span. The blue represents the posterior median and $1\/2 sigma$ posterior bands for a power-law model; the dashed black line corresponds to a $gamma = 13 \/ 3$ (SMBHB-like) power-law, plotted with the median posterior amplitude. See @sec:bayes for more details. #strong[(b)]: Posterior probability distribution of GWB amplitude and spectral exponent in a HD power-law model, showing $1\/2\/3 sigma$ credible regions. The value $gamma_("GWB") = 13 \/ 3$ (dashed black line) is included in the $99 \%$ credible region. The amplitude is referenced to $f_("ref") = 1 thin "yr"^(- 1)$ (blue) and $0.1 thin "yr"^(- 1)$ (orange). The dashed blue and orange curves in the $log_(10) A_("GW")$ subpanel shows its marginal posterior density for a $gamma = 13 \/ 3$ model, with $f_("ref") = 1 thin "yr"^(- 1)$ and $f_("ref") = 0.1 thin "yr"^(- 1)$, respectively. See @sec:bayes for more details. #strong[(c)]: Angular-separation--binned inter-pulsar correlations, measured from 2,211 distinct pairings in our 67-pulsar array using the frequentist optimal statistic, assuming maximum-a-posteriori pulsar noise parameters and $gamma = 13 \/ 3$ common-process amplitude from a Bayesian inference analysis. The bin widths are chosen so that each includes approximately the same number of pulsar pairs, and central bin locations avoid zeros of the Hellings--Downs curve. This binned reconstruction accounts for correlations between pulsar pairs #cite(<romano-2021>)#cite(<2022arXiv220807230A>). The dashed black line shows the Hellings--Downs correlation pattern, and the binned points are normalized by the amplitude of the $gamma = 13 \/ 3$ common process to be on the same scale. Note that we do not employ binning of inter-pulsar correlations in our detection statistics; this panel serves as a visual consistency check only. See @sec:optimal for more frequentist results. #strong[(d)]: Bayesian reconstruction of normalized inter-pulsar correlations, modeled as a cubic spline within a variable-exponent power-law model. The violins plot the marginal posterior densities (plus median and $68 \%$ credible values) of the correlations at the knots. The knots positions are fixed, and are chosen on the basis of features of the Hellings--Downs curve (also shown as a dashed black line for reference): they include the maximum and minimum angular separations, the two zero crossings of the Hellings--Downs curve, and the position of minimum correlation. See @sec:bayes for more details.
], scope: "parent") <fig:spectrum_correlations_plot>

Black holes with masses of $10^5$--$10^10 thin M_ ⊙$ exist at the center of most galaxies and are closely correlated with the global properties of the host, suggesting a symbiotic evolution #cite(<1998AJ....115.2285M>)#cite(<2013ApJ...764..184M>). Galaxy mergers are the main drivers of hierarchical structure formation over cosmic time #cite(<blumenthal84>) and lead to the formation of close massive--black-hole binaries long after the mergers #cite(<bbr80>)#cite(<mm03>). The most massive of these (supermassive black-hole binaries, SMBHBs, with masses $10^8$--$10^10 thin M_ ⊙$) emit GWs with slowly evolving frequencies, contributing to a noise-like broadband signal in the nHz range (the GW background, GWB; #cite(<rr95>, style: "aas_noparen.csl")#cite(<jb03>, style: "aas_noparen.csl")#cite(<wl03>, style: "aas_noparen.csl")#cite(<shm-04>, style: "aas_noparen.csl")#cite(<2014ApJ...789..156M>, style: "aas_noparen.csl")#cite(<stc-19>, style: "aas_noparen.csl")). If all contributing SMBHBs evolve purely by loss of circular orbital energy to gravitational radiation, the resultant GWB spectrum is well described by a simple $f^(- 2 \/ 3)$ characteristic-strain power law #cite(<p01>). However, GWB signals that are not produced by populations of inspiraling black holes may also lie within the nHz band; these include primordial GWs from inflation, scalar-induced GWs, and GW signals from multiple processes arising due to cosmological phase transitions, such as collisions of bubbles of the post-transition vacuum state, sound waves, turbulence, and the decay of any defects such as cosmic strings or domain walls that may have formed (see, e.g., #cite(<guzzetti2016gravitational>, style: "aas_noparen.csl")#cite(<2018CQGra..35p3001C>, style: "aas_noparen.csl")#cite(<2021Univ....7..398D>, style: "aas_noparen.csl"), and references therein).

The detection of nHz GWs follows the template outlined by #cite(<1956AcPP...15..389P>)#cite(<2009GReGr..41.1215P>), whereby we time the propagation of light to measure modulations in the distance between freely falling reference masses. #cite(<1975GReGr...6..439E>, form: "prose") derived the GW response of electromagnetic signals traveling between Earth and distant spacecraft, sparking interest in low-frequency GW detection. #cite(<saz78>, form: "prose") and #cite(<det79>, form: "prose") described nHz GW detection using Galactic pulsars and (effectively) the solar system barycenter as references, relying on the regularity of pulsar emission and planetary motions to highlight GW effects. The fact that pulsars are such accurate clocks enables precise measurements of their rotational, astrometric, and binary parameters (and more) from the times-of-arrival of their pulses, which are used to develop ever-refining end-to-end #emph[timing models]. #cite(<hd83>, form: "prose") made the crucial suggestion that the correlations between the time-of-arrival perturbations of multiple pulsars could reveal a GW signal buried in pulsar noise; #cite(<romani1989timing>, form: "prose") and #cite(<fb90>, form: "prose") proposed that a #emph[pulsar timing array] (PTA) of highly stable millisecond pulsars #cite(<1982Natur.300..615B>) could be used to search for a GWB. Nevertheless, the first multi-pulsar, long-term GWB limits were obtained by analyzing millisecond-pulsar residuals independently, rather than as an array #cite(<1990PhRvL..65..285S>)#cite(<1994ApJ...428..713K>).

From a statistical-inference standpoint, the problem of detecting nHz GWs in PTA data is analogous to GW searches with terrestrial and future space-borne experiments, in which the propagation of light between reference masses is modeled with physical and phenomenological descriptions of signal and noise processes. It is distinguished by the irregular observation times, which encourage a time- rather than Fourier-domain formulation, and by noise sources (intrinsic pulsar noise, interstellar-medium--induced radio-frequency--dependent fluctuations, and timing-model errors) that are correlated on timescales common to the GWs of interest. This requires the joint estimation of GW signals and noise, which is similar to the kinds of global fitting procedures already used in terrestrial GW experiments, and proposed for space-borne experiments. GW analysts have therefore converged on a Bayesian framework that represents all noise sources as Gaussian processes #cite(<2009MNRAS.395.1005V>)#cite(<2014PhRvD..90j4012V>), and relies on model comparison (i.e., Bayes factors, which are ratios of fully marginalized likelihoods) to define detection (see, e.g., #cite(<taylor2021nanohertz>, style: "aas_noparen.csl")). This Bayesian approach is nevertheless complemented by null hypothesis testing, using a frequentist detection statistic#footnote[See #cite(<2006ApJ...653.1571J>, form: "prose") for an early example of a cross-correlation statistic for PTA GWB detection.] (the "optimal statistic" of #cite(<abc-2009>, style: "aas_noparen.csl")#cite(<dfg-13>, style: "aas_noparen.csl")#cite(<ccs-2015>, style: "aas_noparen.csl")) averaged over Bayesian posteriors of the noise parameters #cite(<vite18>).

The GWB---rather than GW signals from individually resolved binary systems---is likely to become the first nHz source accessible to PTA observations #cite(<rsg2015>). Because of its stochastic nature, the GWB cannot be identified as a distinctive phase-coherent signal in the way of individual compact-binary-coalescence GWs. Rather, as PTA data sets grow in extent and sensitivity one expects to first observe the GWB as excess low-frequency residual power of consistent amplitude and spectral shape across multiple pulsars #cite(<romano-2021>)#cite(<astro4cast>). An observation following this behavior was reported in $2020$ (#cite(<abb-20>, form: "prose"), henceforth NG12gwb) for the 12.5-year data set collected by the North American Nanohertz Observatory for Gravitational waves #cite(<m13>)#cite(<ransom-19>), and then confirmed #cite(<ppta_dr2_gwb>)#cite(<epta_dr2_gwb>) by the Parkes Pulsar Timing Array #cite(<2013PASA...30...17M>) and the European Pulsar Timing Array #cite(<dcl-16>), following many years of null results and steadily decreasing upper limits on the GWB amplitude. A combined International Pulsar Timing Array #cite(<pdd-19>) data release consisting of older data sets from the constituent PTAs also confirmed this observation #cite(<2022MNRAS.510.4873A>). Nevertheless, the finding of excess power cannot be attributed to a GWB origin merely by the consistency of amplitude and spectral shape, which could arise from intrinsic pulsar processes of similar magnitude #cite(<gts-22>)#cite(<zhs-22>), or from a common systematic noise such as clock errors #cite(<thk-2016>). Instead, definitive proof of GW origin is sought by establishing the presence of phase-coherent inter-pulsar correlations with the characteristic spatial pattern derived by Hellings and Downs (#cite(<hd83>, form: "year", supplement: [henceforth HD])): for an isotropic GWB, the correlation between the GW-induced timing delays observed at Earth for any pair of pulsars is a universal, quasi-quadrupolar function of their angular separation in the sky. Even though this correlation pattern is modified if there is anisotropy in the GWB---which may be the case for a GWB generated by a SMBHB population #cite(<2013PhRvD..88f2005M>)#cite(<2013PhRvD..88h4001T>)#cite(<Cornish:2013aba>)#cite(<2014PhRvD..90f2011M>)#cite(<2017NatAs...1..886M>)#cite(<2017ApJ...835...21R>)---the HD template is effective for detecting even anisotropic GWBs in all but the most extreme scenarios #cite(<Cornish:2013aba>)#cite(<cs16>)#cite(<2020PhRvD.102h4039T>)#cite(<2022ApJ...941..119B>)#cite(<2023PhRvD.107d3018A>).

In this letter we present multiple lines of evidence for an excess low-frequency signal with HD correlations in the NANOGrav 15-year data set (@fig:spectrum_correlations_plot). Our key results are as follows. The Bayes factor between an HD-correlated, power-law GWB model and a spatially uncorrelated common-spectrum power-law model ranges from 200 to 1,000, depending on modeling choices (@fig:bfs). The noise-marginalized optimal statistic, which is constructed to be selectively sensitive to HD-correlated power, achieves a signal-to-noise ratio of $tilde$~5 (@fig:background and @fig:optstat). We calibrated these detection statistics by removing correlations from the 15-year data set using the phase-shift technique, which removes inter-pulsar correlations by adding random phase shifts to the Fourier components of the common process #cite(<tlb-17>). We find false-alarm probabilities of $p = 10^(- 3)$ and $p = 5 times 10^(- 5)$ for the observed Bayes factor and optimal statistic, respectively (see @fig:background).

For our fiducial power-law model ($f^(- 2 \/ 3)$ for characteristic strain and $f^(- 13 \/ 3)$ for timing residuals) and a log-uniform amplitude prior, the Bayesian posterior of GWB amplitude at the customary reference frequency 1 $"yr"^(- 1)$ is $A_("GW") = 2.4_(-0.6)^(+0.7) times 10^(-15)$ (median with 90\% credible interval), which is compatible with current astrophysical estimates for the GWB from SMBHBs #cite(<stc-19>, form: "prose")#cite(<aaa-23_smbhb>). This corresponds to a total integrated energy density of $Omega_("gw") = 9.3^(+5.8)_(-4.0) times 10^(-9)$ or $rho_("gw") = 7.7_(-3.3)^(+4.8) times 10^(-17) thin "ergs" thin thin "cm"^(- 3)$ (assuming $H_0 = 70 thin "km"\/"s"\/"Mpc"$) in our sensitive frequency band. For a more general model of the timing-residual power spectral density with variable power-law exponent $- gamma$, we find $A_("GW") = 6.4_(-2.7)^(+4.2) times 10^(-15)$, and $gamma = 3.2_(-0.6)^(+0.6)$. See panel (b) of @fig:spectrum_correlations_plot for $A_("GW")$ and $gamma$ posteriors. The posterior for $gamma$ is consistent with the value of $13 \/ 3$

predicted for a population of SMBHBs evolving by GW emission, although smaller values of $gamma$ are preferred; however, the recovered posteriors are consistent with predictions from astrophysical models (see #cite(<aaa-23_smbhb>, style: "aas_noparen.csl")). We also note that, unlike our detection statistics (which are calibrated under our modeling assumptions), the estimation of $gamma$ is very sensitive to minor details in the data model of a few pulsars.

The rest of this paper is organized as follows. We briefly describe our data set and data model in @sec:data. Our main results are discussed in detail in @sec:bayes and @sec:optimal; they are supported by a variety of robustness and validation studies, including a spectral analysis of the excess signal (@subsec:spectral), a correlation analysis that finds no significant evidence for additional spatially correlated processes (@subsec:correlation), and cross-validation studies with single-telescope data sets and leave-one-pulsar-out techniques (@subsec:cross-validation). In the past two years we have performed an end-to-end review of the NANOGrav experiment, to identify and mitigate possible sources of systematic error or data set contamination: our improvements and considerations are partly described in a set of companion papers: on the NANOGrav statistical analysis as implemented in software #cite(<code_review>), on the 15-year data set (#cite(<aaa-23>, form: "prose"), hereafter NG15), and on pulsar models (#cite(<aaa-23_noise>, form: "prose"), hereafter NG15detchar). More companion papers address the possible SMBHB #cite(<aaa-23_smbhb>) and cosmological #cite(<aaa-23_cosmo>) interpretations of our results, with several more GW searches and signal studies in preparation. We look forward to the cross-validation analysis that will become possible with the independent data sets collected by other IPTA members.

= THE 15-YEAR DATA SET AND DATA MODEL <sec:data>

The NANOGrav 15-year data set#footnote[While the time between the first and last observations we analyze is 16.03 years, this data set is named "15-year data set" since no single pulsar exceeds 16 years of observation; we will use this nomenclature despite the discrepancy.] contains observations of 68 pulsars obtained between July 2004 and August 2020 with the Arecibo Observatory (Arecibo), the Green Bank Telescope (GBT), and the Very Large Array (VLA), augmenting the 12.5-year data set #cite(<aab-20>)#cite(<12yr_wideband>) with $2.9$ years of timing data for the 47 pulsars in the previous data set, and with 21 new pulsars#footnote[The data set is available at #link("http://data.nanograv.org")[data.nanograv.org] with the code used to process it.]. For this paper we analyze narrowband times of arrival (TOAs), which are computed separately for sub-bands of each receiver, and focus on the 67 pulsars with a timing baseline $gt.eq 3$ years. We adopt the TT(BIPM2019) timescale and the JPL DE440 ephemeris #cite(<2021AJ....161..105P>), which improves Jupiter's orbit with ranging and VLBI observations of the Juno spacecraft. Uncertainties in the Jovian orbit impacted NANOGrav's 11-year GWB search #cite(<abb-18b>)#cite(<2020ApJ...893..112V>), but they are now negligible.

For each pulsar, we fit the TOAs to a timing model that includes pulsar spin period, spin period derivative, sky location, proper motion, and parallax. While not all pulsars have measurable parallax and proper motion, we always include these parameters because they induce delays with the same frequencies for all pulsars ($f = 0.5 thin "yr"^(- 1)$ for parallax and $f = "yr"^(- 1)$ plus a linear envelope for proper motion), so there is a risk that a parallax or proper motion signal could be misidentified as a GW signal. Fitting for these parameters in all pulsars reduces our sensitivity to GWs at those frequencies; however, this effect is minimal for GWB searches since these frequencies are much higher than the frequencies at which we expect the GWB to be significant. For binary pulsars, the timing model includes also five orbital elements for binary pulsars and additional non-Keplerian parameters when these improve the fit as determined by an $F$ test. We fit variations in dispersion measure as a piecewise constant "DMX" function #cite(<abb-15>)#cite(<jml-2017>). The individual analysis of each pulsar provides best-fit estimates of the timing residuals $bold(delta t)$, of white measurement noise, and of intrinsic red noise, modeled as a power law #cite(<cordes2013>)#cite(<lcc-2017>)#cite(<jml-2017>).#footnote[Throughout the paper we use "red noise" to describe noise whose power spectrum decreases with increasing frequency.] White measurement noise is described by three parameters: a linear scaling of TOA uncertainties ("EFAC"), white noise added to the TOA uncertainties in quadrature ("EQUAD"), and noise common to all sub-bands at the same epoch ("ECORR"), with independent parameters for every receiver/backend combination (see NG15detchar). We summarize white noise by its maximum #emph[a posteriori] (MAP) covariance $bold(C)$. See App. #ref(<app:data_set_details>, supplement: none) for more details of our instruments, observations, and data-reduction pipeline: a complete discussion of the data set can be found in NG15.

In our Bayesian GWB analysis, we model $bold(delta t)$ as a finite Gaussian process consisting of time-correlated fluctuations that include intrinsic red pulsar noise and (potentially) a GW signal, along with timing-model uncertainties #cite(<2009MNRAS.395.1005V>)#cite(<2014PhRvD..90j4012V>)#cite(<taylor2021nanohertz>). The red noise is modeled with Fourier basis $bold(F)$ and amplitudes $bold(c)$#cite(<lentati-2013>). All Fourier bases (the columns of $bold(F)$) are sines and cosines computed on the TOAs with frequencies $f_i = i \/ T$, where $T = 16.03$ yr is the TOA extent. The timing-model uncertainties are modeled with design-matrix basis $bold(M)$ and coefficients $bold(epsilon)$. The single-pulsar log likelihood is then

$ ln p(bold(delta t) | bold(c), bold(epsilon)) = - 1\/2 [ bold(r)^T bold(C)^(- 1) bold(r) + ln "det" (2 pi bold(C)) ] , $ <eq:likelihood>

with

$
  bold(r) = bold(delta t) - bold(F) bold(c) - bold(M) bold(epsilon) .
$

The prior for the $bold(epsilon)$ is taken to be uniform with infinite extent, so the posterior is driven entirely by the likelihood. The set of the $bold(c)$ for all pulsars take a joint normal prior with zero mean and covariance

$
  chevron.l c_(a i) c_(b j) chevron.r = delta_(i j) (delta_(a b) phi_(a i) + Phi_(a b i))
$<eq:gp_covariance>

here $a b$ range over pulsars and $i j$ over Fourier components; $delta_(i j)$ is Kronecker's delta. The term $phi_(a i)$ describes the spectrum of intrinsic red noise in pulsar $a$, while $Phi_(a b i)$ describes processes with common spectrum across all pulsars and (potentially) phase-coherent inter-pulsar correlations. The $bold(c)$ prior ties together the single-pulsar likelihoods @eq:likelihood into a joint posterior, $p(bold(c), bold(epsilon), bold(eta) | bold(delta t)) prop p(bold(delta t) | bold(c), bold(epsilon)) p(bold(c),bold(epsilon)|bold(eta)) p(bold(eta))$, where we have dropped subscripts to denote the concatenation of vectors for all pulsars, and where $bold(eta)$ denotes all the hyperparameters (such as red-noise and GWB power spectrum amplitudes) that determine the covariances. We marginalize over $bold(c)$ and $bold(epsilon)$ analytically, and use Markov chain Monte Carlo techniques (see App. #ref(<sec:bayesapp>, supplement: none)) to estimate $p(bold(eta) | bold(delta t))$ for different models of the intrinsic red noise and common spectrum.

The data-model variants adopted in this paper all share this probabilistic setup, but differ in the structure and parametrization of $Phi_(a b i)$. For a model with intrinsic red noise only (henceforth #smallcaps[irn]), $Phi_(a b i) = 0$; for common-spectrum spatially-uncorrelated red noise (#smallcaps[curn]), $Phi_(a b i) = delta_(a b) Phi_("CURN", i)$; for an isotropic GWB with Hellings--Downs correlations (#smallcaps[hd]), $Phi_(a b i) = Gamma ( xi_(a b) ) Phi_("HD", i)$, with $Gamma$ the Hellings--Downs function of pulsar angular separations $xi_(a b)$

$ Gamma \( xi_(a b) \) = 3 \/ 2 x ln \( x \) - 1 \/ 4 x + 1 \/ 2 + 1 \/ 2 delta_(a b) , $

$ x = frac(1 - cos xi_(a b), 2) . $

In NG12gwb we established strong Bayesian evidence for #smallcaps[curn]~over #smallcaps[irn]; finding that #smallcaps[hd]~is preferred over #smallcaps[curn]~would point to the GWB origin of the common-spectrum signal. We also investigate other spatial correlation patterns, e.g., monopole or dipole, introduced in @subsec:correlation.

Throughout this paper, we set the spectral components $phi_(a i)$ of intrinsic pulsar noise (which have units of $upright(s)^2$, as appropriate for the variance of timing residuals) to a power law,

$
  phi_(a i) = frac(A_a^2, 12 pi^2) 1 \/ T #h(-1em) (f_i \/ f_("ref"))^(#h(-1em) - gamma_a) f_("ref")^(- 3)
$<eq:powerlaw>

introducing two dimensionless hyperparameters for each pulsar: the intrinsic-noise amplitude $A_a$ and spectral index $gamma_a$. We use log-uniform and uniform priors, respectively, on these hyperparameters; their bounds are described in App. #ref(<sec:bayesapp>, supplement: none). More sophisticated intrinsic-noise models are discussed in @subsec:dm_models and @aaa-23_noise. In models #smallcaps[curn]#super[$gamma$]~and #smallcaps[hd]#super[$gamma$], the common spectra $Phi_("CURN", i)$ and $Phi_("HD", i)$ follow @eq:powerlaw,

$ Phi_("CURN", i) = frac(A_("CURN")^2, 12 pi^2) 1 \/ T (f_i \/ f_("ref"))^(-gamma_("CURN")) f_("ref")^(-3) , $

$ Phi_("HD", i) = frac(A_("HD")^2, 12 pi^2) 1 \/ T (f_i \/ f_("ref"))^(-gamma_("HD")) f_("ref")^(-3) , $

introducing hyperparameters $A_("CURN") gamma_("CURN")$ and $A_("HD") gamma_("HD")$ respectively. However, we set $gamma_("HD") = 13 \/ 3$ for the GWB from a stationary ensemble of inspiraling binaries, and refer to that fiducial model as #smallcaps[hd]#super[$(13 \/ 3)$]. For specific "free spectrum" studies we will instead model the individual $Phi_("CURN", i)$ or $Phi_("HD", i)$ elements, and refer to models #smallcaps[curn]#super[$("free")$]~and #smallcaps[hd]#super[$("free")$]. Throughout this article we use frequencies $f_i = i \/ T$ with $i = 1 "–" 30$ for intrinsic noise ($f = 2 "–" 59 #h(0em) "nHz"$), covering a frequency range over which pulsar noise transitions from red-noise--dominated to white--noise-dominated. For common-spectrum noise, we limit the frequency range in order to reduce correlations with excess white noise at higher frequencies. Following NG12gwb, we fit a #smallcaps[curn]#super[$gamma$]~model enhanced with a power-law break to our data, and limit frequencies to the MAP break frequencies ($i = 1 "–" 14$ or $f = 2 "–" 28 #h(0em) "nHz"$; see App. #ref(<sec:appbroken>, supplement: none)).

= BAYESIAN ANALYSIS <sec:bayes>

#figure(
  scope: "parent", placement: auto,
  [#block[
  #box(
cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let lw = 1.1pt
    let bw = 2.2pt

    // node box with centred text
    let node(c, w, h, body, thick: false) = {
      let x = c.at(0)
      let y = c.at(1)
      rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2),
        radius: 0.26, fill: white,
        stroke: (thickness: if thick { bw } else { lw }, paint: black))
      content(c, {
        set par(leading: 0.55em, spacing: 0.59em)
        text(size: 7pt)[#body]
      })
    }

    let arrow(p1, p2) = {
      line(p1, p2, mark: (end: (symbol: "stealth", fill: black)), stroke: (thickness: lw, paint: black))
    }

    let lbl(c, body) = content(c, text(size: 9pt)[#body])

    node((0.0, 0.0), 2.26, 1.48, [intrinsic pulsar\
noise only\
($bold("IRN")$)])
    node((3.86, 0.0), 2.22, 1.48, [common-\
spectrum red\
noise ($bold("CURN")^gamma$)], thick: true)
    node((5.46, 1.66), 2.05, 1.09, [dipole])
    node((5.46, -1.66), 2.05, 1.09, [monopole])
    node((8.92, 0.0), 2.72, 1.48, [HD-correlated,\
common spectrum\
red noise ($bold("HD")^gamma$)], thick: true)
    node((10.50, 1.66), 2.15, 1.09, [$bold("HD")^gamma$ + dipole])
    node((10.50, -1.66), 2.35, 1.09, [$bold("HD")^gamma$ + monopole])
    node((13.02, 0.0), 2.05, 1.09, [$bold("HD")^gamma$+ sin])

    arrow((1.13, 0.0), (2.75, 0.0))
    lbl((1.85, 0.29), $10^(12.1 plus.minus 0.1)$)

    arrow((3.84, 0.56), (4.48, 1.11))
    lbl((3.72, 1.00), $< 10^(-7)$)
    arrow((3.84, -0.56), (4.48, -1.11))
    lbl((3.72, -1.00), $< 10^(-8)$)

    arrow((4.97, 0.0), (7.56, 0.0))
    lbl((6.21, 0.29), $226 plus.minus 70$)
    lbl((6.25, -0.31), [(965 with 5 freqs.)])

    arrow((8.87, 0.56), (9.51, 1.11))
    lbl((8.20, 1.00), $0.48 plus.minus 0.01$)
    arrow((8.87, -0.56), (9.51, -1.11))
    lbl((8.20, -1.00), $0.6 plus.minus 0.2$)

    arrow((10.28, 0.0), (11.99, 0.0))
    lbl((11.09, 0.29), $0.78 plus.minus 0.09$)
  })
  )
  ]],
  caption: [
    Bayes factors between models of correlated red noise in the NANOGrav 15-year data set (see @subsec:correlation and App. #ref(<sec:bayesapp>, supplement: none)). All models feature variable-$gamma$ power laws. #smallcaps[curn]#super[$gamma$] is vastly favored over #smallcaps[irn] (i.e., we find very strong evidence for common-spectrum excess noise over pulsar intrinsic red-noise alone); #smallcaps[hd]#super[$gamma$] is favored over #smallcaps[curn]#super[$gamma$] (i.e., we find positive evidence for Hellings--Downs correlations in the common-spectrum process); dipole and monopole processes are strongly disfavored with respect to #smallcaps[curn]#super[$gamma$]; adding correlated processes to #smallcaps[hd]#super[$gamma$] is disfavored. While the interpretation of "raw" Bayes factors is somewhat subjective, they can be given a statistical significance within the hypothesis-testing framework by computing their background distributions and deriving the $p$-values of the observed factors, e.g., @fig:background
  ]
) <fig:bfs>

When fit to the 15-year data set, the #smallcaps[curn]#super[$gamma$]~and #smallcaps[hd]#super[$gamma$]~models agree on the presence of a loud time-correlated stochastic signal with common amplitude and spectrum across pulsars#footnote[See App. #ref(<sec:bayesapp>, supplement: none) for details about our Bayesian methods, including the calculation of Bayes factors.].

The joint $A_("HD")$--$gamma_("HD")$ Bayesian posterior is shown in panel (b) of @fig:spectrum_correlations_plot, with 1-D marginal posteriors in the horizontal and vertical subplots.

The posterior medians and 5--95\% quantiles are $A_("HD") = 6.4_(-2.7)^(+4.2) times 10^(-15)$ and $gamma_("HD") = 3.2_(-0.6)^(+0.6)$.

The thicker curve in the vertical subplot is the $A_("HD")$ posterior for the #smallcaps[hd]#super[$(13 \/ 3)$] model, for which $A_("HD", 13 \/ 3) = 2.4_(-0.6)^(+0.7) times 10^(-15)$.

These amplitudes are compatible with astrophysical expectations of a GWB from inspiraling SMBHBs (see @sec:discussion). The $A_("HD")$ posterior has essentially no support below $10^(- 15)$.

The strong $A_("HD")$--$thin gamma_("HD")$ correlation is an artifact of using the conventional frequency $f_("ref") = 1 thin "yr"^(- 1)$ in @eq:powerlaw, and it largely disappears when $f_("ref")$ is moved to the band of greatest PTA sensitivity; see the dashed contours in panel (b) of @fig:spectrum_correlations_plot for $f_("ref") = ( 10 thin "yr" )^(- 1)$. The $gamma_("HD")$ posterior is in moderate tension with the theoretical universal binary-inspiral value $gamma_("HD") = 13 \/ 3$, which lies at the $99$\% credible boundary: smaller values of $gamma_("HD")$ could be an indication that astrophysical effects, such as stellar scattering and gas dynamics, play a role in the evolution of SMBHBs emitting GWs in this frequency range (see @sec:discussion and #cite(<aaa-23_smbhb>, style: "aas_noparen.csl")). This highlights the importance of measuring this parameter. Furthermore, its estimation is sensitive to details in the modeling of intrinsic red noise and of interstellar-medium timing delays in a few pulsars (see the analysis in @subsec:spectral). Notably, in the 12.5-year data set $gamma_("HD") = 13 \/ 3$ was recovered at $tilde 1 sigma$ below the median (NG12gwb); this anomaly is reversed in the newer data set. It is likely that more expansive data sets or more sophisticated chromatic noise models, e.g., next generation Gaussian process models such as in @subsec:dm_models #cite(<goncharov-21a>)#cite(<Chalumeau-2022>)#cite(<leg-2018>), will be needed to infer the presence of possible systematic errors in $gamma_("HD")$.

// [figvision-cn] imgs/fap_plots_logscale_cdf_pshift.png
// 这是一张包含左右两个并排子图（左图和右图）的统计图表，
// 展示了通过相位平移技术（phase-shift technique）去除脉
// 冲星之间相关性后得到的经验背景分布。两个子图均为阶梯状
// 曲线图（类似生存函数或累积分布函数的补集），纵轴均采用
// 对数坐标。 左图（对应 hd-to-curn Bayes 因子）： 图表类
// 型为阶梯曲线图。横轴标签为“log₁₀ B^HD_CURN”，表示 HD
// 到 CURN 的贝叶斯因子的以10为底的对数，刻度范围从约 -5
// 到 4，主要刻度标记为 -4、-2、0、2、4。纵轴标签为“1 -
// CDF”，表示1减去累积分布函数，采用对数坐标，刻度范围从
// 10⁻⁵ 到 10⁰，主要刻度标记为 10⁻⁵、10⁻⁴、10⁻³、10⁻²、10
// ⁻¹、10⁰。 图中有一条蓝色的阶梯状曲线，图例中标注为“
// Phase shifts”（相位平移）。该曲线在横轴 -5 到 0 之间基
// 本保持在 10⁰ 附近，随后在横轴 0 到 3 之间急剧下降，最
// 终在横轴约 3 处降至 10⁻⁵ 以下。 图中有三条水平灰色虚线，
// 分别对应纵轴上的 2σ、3σ 和 4σ 水平，右侧标注有对应的文
// 字“2σ”、“3σ”、“4σ”。在横轴约 2.5 处有一条垂直灰色虚线，
// 该垂直线与蓝色曲线相交于 3σ 水平线附近。图中还包含一个
// 图例框，内含蓝色阶梯线图标和文字“Phase shifts”。 右图
// （对应噪声边缘化最优统计量）： 图表类型为阶梯曲线图与
// 拟合曲线的叠加。横轴标签为“Noise-Marginalized Mean S/N
// ”，表示噪声边缘化平均信噪比，刻度范围从约 -3 到 6，主
// 要刻度标记为 -2、0、2、4、6。纵轴与左图相同，标签为“1
// - CDF”，采用对数坐标，范围从 10⁻⁵ 到 10⁰，主要刻度标记
// 为 10⁻⁵、10⁻⁴、10⁻³、10⁻²、10⁻¹、10⁰。 图中包含三条线：
// 一条蓝色阶梯状曲线（图例标注为“Phase shifts”），一条橙
// 色阶梯状曲线（图例标注为“Simulations”），以及一条绿色
// 平滑曲线（图例标注为“Analytic background”）。这三条曲
// 线在横轴 -3 到 5 的范围内高度重合，从纵轴 10⁰ 开始缓慢
// 下降，在横轴 5 到 6 之间急剧下降至 10⁻⁵ 以下。 与左图
// 类似，图中有三条水平灰色虚线，分别对应纵轴上的 2σ、3σ
// 和 4σ 水平，右侧标注有对应的文字“2σ”、“3σ”、“4σ”。在横
// 轴约 5 处有一条垂直灰色虚线，该垂直线与曲线相交于 3σ
// 水平线附近。图中包含一个图例框，内含蓝色阶梯线、橙色阶
// 梯线和绿色实线图标，分别对应文字“Phase shifts”、“
// Simulations”和“Analytic background”。
#figure(scope: "parent", placement: auto, [#block[
  #box(image("imgs/fap_plots_logscale_cdf_pshift.png", width: 95.0%))
  ]],
  caption: [
    Empirical background distribution of #smallcaps[hd]#super[$gamma$]-to-#smallcaps[curn]#super[$gamma$]~Bayes factor (left, see @sec:bayes) and noise-marginalized optimal statistic (right, see @sec:optimal), as computed by the phase-shift technique #cite(<tlb-17>) to remove inter-pulsar correlations. We only compute 5,000 Bayesian phase shifts, compared to 400,000 optimal statistic phase shifts, because of the huge computational resources needed to perform the Bayesian analyses. For the optimal statistic, we also compute the background distribution using 27,000 simulations (orange line) and compare to an analytic calculation (green line). Dotted lines indicate Gaussian-equivalent 2 $sigma$, 3 $sigma$, and 4 $sigma$ thresholds. The dashed vertical lines indicate the values of the detection statistics for the unshifted data sets. For the Bayesian analyses, we find $p = 10^(- 3)$ (approx.~$3 sigma$); for the optimal statistic analyses, we find $p = 5 times 10^(- 5)$--$1.9 times 10^(- 4)$ (approx.~$3.5$--$4 sigma$).
  ]
) <fig:background>

Our Bayesian analysis provides evidence that the common-spectrum signal includes Hellings--Downs inter-pulsar correlations. Specifically, the Bayes factor between the #smallcaps[hd]#super[$gamma$]~and #smallcaps[curn]#super[$gamma$]~models ranges from 200 (when 14 Fourier frequencies are included in $Phi_i$) to 1,000 (when 5 frequencies are included, as in NG12gwb). Results are similar for #smallcaps[hd]#super[$(13 \/ 3)$]~vs.~#smallcaps[curn]#super[$(13 \/ 3)$]. @fig:bfs recapitulates Bayes factors between a variety of models, including some with the alternative spatial-correlation structures discussed in @subsec:correlation. The very peaked $A_("HD")$ posterior in panel (b) of @fig:spectrum_correlations_plot, significantly separated from smaller amplitudes, supports the very large Bayes factor between #smallcaps[irn]~and #smallcaps[curn]#super[$gamma$]. The 15-year data set favors #smallcaps[hd]#super[$gamma$]~over #smallcaps[curn]#super[$gamma$], and over models with monopolar or dipolar correlations, and it is inconclusive about, i.e., gives roughly even odds for, the presence of spatially correlated signals in addition to #smallcaps[hd]#super[$gamma$].

We can also regard the #smallcaps[hd]#super[$gamma$]~vs.~#smallcaps[curn]#super[$gamma$]~Bayes factor as a detection statistic in a hypothesis-testing framework, and derive the $p$-value of the observed Bayes factor with respect to its empirical distribution under the #smallcaps[curn]#super[$gamma$]~model. We do so by computing Bayes factors on 5,000 bootstrapped data sets where inter-pulsar spatial correlations are removed by introducing random #emph[phase shifts], drawn from a uniform distribution from 0 to $2 pi$, to the common-process Fourier components~#cite(<tlb-17>). This procedure alters inter-pulsar correlations to have a mean of zero, while leaving the amplitudes of intrinsic pulsar noise and CURN unchanged, thus providing a way to test the null hypothesis that no inter-pulsar correlations are present. The resulting background distribution of Bayes factors is shown in the left panel of @fig:background, they exceed the observed value in five of the 5,000 phase shifts ($p = 10^(- 3)$). We also performed sky scramble analyses #cite(<cs16>), which remove the dependence of inter-pulsar spatial correlations on the angular separations between the pulsars by attributing random sky positions to the pulsars. Sky scrambles generate a background distribution for which inter-pulsar correlations are present in the data but they are independent of the pulsars' angular separations: for this distribution, we find $p = 1.6 times 10^(- 3)$. A detailed discussion of sky scrambles and the results of these analyses can be found in App. #ref(<sec:appskyscrambles>, supplement: none).

As in NG12gwb, we also carried out a minimally modeled Bayesian reconstruction of the inter-pulsar correlation pattern, using spline interpolation over seven spline-knot positions. The choice of seven spline-knot positions is based on features of the Hellings--Downs pattern: two correspond to the maximum and minimum angular separations ($0^compose$ and $180^compose$, respectively), two are chosen to be at the theoretical zero crossings of the Hellings--Downs pattern ($49.2^compose$ and $121.8^compose$), one is at the theoretical minimum ($82.5^compose$), and the final two are between the end points and zero crossings ($25^compose$ and $150^compose$) to allow additional flexibility in the fit. Panel (d) of @fig:spectrum_correlations_plot shows the marginal $1$-D posterior densities at these spline-knot positions for a power-law varied-exponent model. The reconstruction is consistent with the overplotted Hellings--Downs pattern; furthermore, the joint $2$-D marginal posterior densities for the knots, not shown in panel (d) of @fig:spectrum_correlations_plot, at the HD zero-crossings is consistent with $( 0, 0 )$ within $1 sigma$ credibility.

= OPTIMAL STATISTIC ANALYSIS <sec:optimal>

We complement our Bayesian search with a frequentist analysis using the #emph[optimal statistic] #cite(<abc-2009>)#cite(<dfg-13>)#cite(<ccs-2015>), a summary statistic designed to measure correlated excess power in PTA residuals. (Note that there is no accepted definition of "optimal statistic" in modern statistical usage, but the term has become established in the PTA literature to refer to this specific method, so we use it for this reason.) It is enlightening to describe the optimal statistic as a weighted average of the inter-pulsar correlation coefficients

$ rho_(a b) = frac(bold(delta t)_a^T bold(P)_a^(- 1) tilde(Phi)_(a b) bold(P)_b^(- 1) bold(delta t)_b, "Tr" bold(P)_a^(- 1) tilde(Phi)_(a b) bold(P)_b^(- 1)) , $<eq:rhoab>

where $bold(delta t)_a^T$ are the timing residuals of pulsar $a$, and $bold(P)_a = chevron.l bold(delta t)_a bold(delta t)_a^T chevron.r$ is their total auto-covariance matrix. The cross-covariance matrix $tilde(upright(bold(Phi)))_(a b)$ encodes the spectrum of the HD-correlated signal, normalized so that $upright(bold(Phi))_(a b) = A^2 Gamma ( xi_(a b) ) tilde(upright(bold(Phi)))_(a b)$ (see #cite(<ptr2022>, style: "aas_noparen.csl")), and where elements of $upright(bold(Phi))_(a b)$ are given by @eq:gp_covariance. Indeed, the $rho_(a b)$ have expectation value $A^2 Gamma ( xi_(a b) )$, but their variance $sigma_(a b)^2 = ( "Tr" thin upright(bold(P))_a^(- 1) tilde(upright(bold(Phi)))_(a b) upright(bold(P))_b^(- 1) tilde(upright(bold(Phi)))_(b a) )^(- 1) + O ( A^4 )$ is too large to use them directly as estimators. Thus we assemble the optimal statistic as the variance-weighted, $Gamma$-template-matched average of the $rho_(a b)$,

$
  hat(A)^2 = frac(sum_(a > b) rho_(a b) Gamma ( xi_(a b) ) \/ sigma_(a b)^2, sum_(a > b) Gamma^2 ( xi_(a b) ) \/ sigma_(a b)^2) .
$<eq:os>

This equation represents the optimal estimator of the HD amplitude $A^2$; it can also be interpreted as the best-fit $hat(A)^2$ obtained by least-squares--fitting the $rho_(a b)$ to the Hellings--Downs model $hat(A)^2 thin Gamma ( xi_(a b) )$. Because $hat(A)^2$ is a function of intrinsic--red-noise and common-process hyperparameters through the $upright(bold(P))_a$, we use the results of an initial Bayesian-inference run to refer the statistic to MAP hyperparameters, or to marginalize it over their posteriors. As discussed in #cite(<vite18>, form: "prose"), we obtain more accurate values of the amplitude by this marginalization.

To search for inter-pulsar correlations using the optimal statistic, we evaluate the frequency (the $p$-value) with which an uncorrelated common-spectrum process with parameters estimated from our data set would yield $hat(A)^2$ greater than we observe.

In the absence of a signal, the expectation value of $hat(A)^2$ is zero, and its distribution is approximately normal. Thus we divide the observed $hat(A)^2$ by its standard deviation to define a formal signal-to-noise ratio

$
  upright(S \/ N) = frac(sum_(a > b) rho_(a b) Gamma ( xi_(a b) ) \/ sigma_(a b)^2, [sum_(a > b) Gamma^2 ( xi_(a b) ) \/ sigma_(a b)^2]^(1 \/ 2)) thin .
$ <eq:ossnr>

@fig:optstat shows the distribution of this S/N over #smallcaps[curn]#super[$gamma$]~and #smallcaps[curn]#super[$(13 \/ 3)$]~noise-parameter posteriors, with S/Ns of $5 plus.minus 1$ and $4 plus.minus 1$, respectively (means $plus.minus$ standard deviations across noise-parameter posteriors). We use 14 frequency components to model the signal: the dependence on the number of frequency components is very weak.

// [figvision-cn] imgs/optstat.png
// 这是一张单面板阶梯状直方图（未标注子图编号）。横轴为 S
// /N（信噪比），范围从 2 到 10，主刻度为 2、4、6、8、10，
// 次刻度间隔为 0.5。纵轴为 PDF（概率密度函数），范围从
// 0.0 到 0.4，主刻度为 0.0、0.1、0.2、0.3、0.4，次刻度间
// 隔为 0.02。 图中有两条阶梯状曲线。实线表示“Varied γ”，
// 其分布较宽，峰值约在 S/N ≈ 4.6–4.8，峰值 PDF ≈ 0.35–
// 0.36。虚线表示“γ = 13/3”，其分布较窄，峰值约在 S/N ≈
// 4.2–4.4，峰值 PDF ≈ 0.41–0.42。两条分布均呈右偏态，在
// S/N > 6 后逐渐下降，在 S/N ≈ 9–10 处降至接近 0。图中用
// 两条竖直线标出各自的均值：实线竖直线位于 S/N ≈ 5.0，虚
// 线竖直线位于 S/N ≈ 4.5。 右上角图例标明：实线框对应“
// Varied γ”，虚线框对应“γ = 13/3”。该图传达的趋势是：与
// 固定 γ = 13/3 的模型相比，变化 γ 的模型其 S/N 分布更宽、
// 峰值更低且均值略高，说明参数变化增加了信噪比的不确定性
// 并略微提高平均信噪比。
#figure(placement: auto, [#block[
  #box(image("imgs/optstat.png", width: 100%))
  ]],
  caption: [
    Optimal statistic S/N for HD correlations, distributed over #smallcaps[curn]#super[$gamma$]~(solid lines) and #smallcaps[curn]#super[$(13 \/ 3)$]~(dashed lines) noise-parameter posteriors. The vertical lines indicate the mean S/Ns. We find S/Ns of $5 plus.minus 1$ and $4 plus.minus 1$ for #smallcaps[curn]#super[$gamma$]~and #smallcaps[curn]#super[$(13 \/ 3)$], respectively.
  ]
) <fig:optstat>

Because the distribution of $hat(A)^2$ is only approximately normal #cite(<hazboun-2023GX2>), the S/N of @eq:ossnr does not map analytically to a $p$-value, and it cannot be interpreted as a "sigma" level. Instead, optimal-statistic $p$-values can be computed empirically by removing inter-pulsar correlations from the 15-year data set with phase shifts #cite(<tlb-17>). We draw random phase offsets from 0 to $2 pi$ for the common-process Fourier components, which is equivalent to making uniform draws from the background distribution of CURN, and ask how often a random choice of phase offsets produces a HD-correlated signal. The right panel of @fig:background shows the distribution of noise-marginalized S/N over 400,000 phase shifts. There are 19 phase shifts with noise-marginalized S/N greater than observed, with $p = 5 times 10^(- 5)$. We compare the phase-shift distribution with backgrounds obtained by simulation (right panel of @fig:background, orange line) and analytic calculation (green line). For the former, we simulate 27,000 #smallcaps[curn]#super[$gamma$]~realizations using MAP hyperparameters from the 15-yr data and compute the optimal-statistic S/N for each; for the latter, we evaluate the generalized $chi^2$ distribution #cite(<hazboun-2023GX2>) with median #smallcaps[curn]#super[$gamma$]~hyperparameters. Although neither method includes the marginalization over noise-parameter posteriors, we find good agreement with phase shifts, with $p = 1.8 times 10^(- 4)$ from simulations, and $p = 1.9 times 10^(- 4)$ from the analytic calculation. Finally, we use sky scrambles to compute the $p$-value for the null hypothesis that inter-pulsar correlations are present, but they have no dependence on the angular separation between the pulsars, for which we find $p < 10^(- 4)$ (see App. #ref(<sec:appskyscrambles>, supplement: none)).

Averaging the cross-correlations $rho_(a b)$ in angular-separation bins with equal numbers of pulsar pairs reveals the Hellings--Downs pattern, as shown in panel (c) of @fig:spectrum_correlations_plot for 15 bins. The $rho_(a b)$ were evaluated with MAP #smallcaps[curn]#super[$(13 \/ 3)$]~noise parameters. The black dashed curve traces the expected correlations for an HD-correlated background with the MAP amplitude; the vertical error bars display the expected 1 $sigma$ spreads of the binned cross-correlations, accounting for the $chevron.l rho_(a b) rho_(c d) chevron.r$ covariances induced by the HD-correlated process #cite(<romano-2021>)#cite(<2022arXiv220807230A>). (Neglecting those covariances yields 20--40\% smaller spreads. Note that they are #emph[not] included in $p$-value estimates because those are calculated under the null hypothesis of no spatially correlated process.)

Although each draw from the noise-parameter posterior would generate a slightly different plot, as would different binnings, the quality of the fit seen in @fig:spectrum_correlations_plot provides a visual indication that the excess low-frequency power in the 15-year data set harbors HD correlations. The $chi^2$ for this $15$-bin reconstruction with respect to the Hellings--Downs curve is $8.1$, where we account for $rho_(a b)$ covariance in constructing the bins, and the covariance between bins in constructing the $chi^2$#cite(<2022arXiv220807230A>). This corresponds to a $p$-value of 0.75, calculated using simulations based on the #smallcaps[hd]#super[$gamma$]~model, or 0.92 if one assumes this value follows a canonical $chi^2$ with 15 degrees of freedom. These $p$-values are representative of what we find with different binnings: we find $p > 0.3$ when using eight to 20 bins (assuming a canonical $chi^2$ distribution).

= CHECKS AND VALIDATION <sec:validation>

Prior to analyzing the 15-year data set, we extensively reviewed our data collection and analysis procedures, methods, and tools, in an effort to eliminate contamination from systematic effects and human error. Furthermore, the results presented in @sec:bayes and @sec:optimal are supported by a variety of consistency checks and auxiliary studies. In this section we present those that offer evidence for or against the presence of HD correlations, reveal anomalies, or otherwise highlight features of note in the data: alternative DM modeling (@subsec:dm_models), the spectral content (@subsec:spectral) and correlation pattern (@subsec:correlation) of the excess-noise signal, as well as the consistency of our findings across data set "slices," pulsars, and telescopes (@subsec:cross-validation).

== Alternative DM models <subsec:dm_models>

In this paper and in previous GW searches (e.g., NG12gwb), we model fluctuations in the DM using DMX parameters (a piecewise-constant representation, see NG15). Adopting this DM model as the standard makes it easier to directly compare the results here to those in @abb-20. An alternative model where DM variations are modeled as a Fourier-domain Gaussian process, DMGP, has been used by #cite(<2022MNRAS.510.4873A>, form: "prose"), #cite(<epta_dr2_gwb>, form: "prose"), and #cite(<ppta_dr2_gwb>, form: "prose"). The Fourier coefficients follow a power law similar to those of intrinsic and common-spectrum red noise, but their basis vectors include a $nu^(- 2)$ radio-frequency dependence, and the component frequencies $f_i = i \/ T$ range through $i = 1 "–" 100$. Under the DMGP model we also include a deterministic solar-wind model #cite(<2022ApJ...929...39H>) and the two chromatic events in PSR J1713 $+$ 0747 reported in #cite(<leg-2018>, form: "prose") which are modeled as deterministic exponential dips with the chromatic index quantifying the radio-frequency dependence of the dips left as a free parameter. If these chromatic events are not modeled, they raise estimated white noise #cite(<hazboun:2020a>). A detailed discussion of chromatic noise effects can be found in NG15.

Using the DMGP model in place of DMX has minimal effects on nearly all pulsars in the array. Only PSRs J1713 $+$ 0747 and J1600 $-$ 3053 show notable differences in their recovered intrinsic-noise parameters. However, DMGP does affect the parameter estimation of common red noise, as seen in @fig:dmgp, shifting the posterior for $gamma$ to higher values that are more consistent with $13 \/ 3$. Despite this, we still recover HD correlations at the same significance as when we use DMX to model fluctuations in the DM, implying that the evidence reported for the presence of correlations in this work is independent of the choice of DM noise modeling.

// [figvision-cn] imgs/dmgp_comparison.png
// 这是一张包含三个子图的联合分布图，用于比较两种模型（
// DMGP 和 DMX）对两个参数的后验分布估计。主图（左下）为
// 二维等高线图，上方和右侧为对应的一维边缘概率密度曲线图。
// 图中没有标注子图编号（a、b、c），但根据布局可划分为：
// 主二维图、上方一维图、右侧一维图。 主二维图（左下）：
// 横轴标签为“γCURN”，刻度范围从 2.0 到 5.6，主刻度标注为
// 2.4、3.2、4.0、4.8。纵轴标签为“log₁₀ A_CURN”，刻度范围
// 从 -15.2 到 -13.4，主刻度标注为 -14.8、-14.4、-14.0、
// -13.6。图中包含两组等高线：蓝色等高线代表 DMX 模型，红
// 色等高线代表 DMGP 模型，每组均绘制了三条闭合的等高线（
// 代表不同的置信水平或密度层级）。两条分布均呈从左下到右
// 上的正相关趋势，即 γCURN 增大时 log₁₀ A_CURN 也增大。
// 蓝色等高线中心偏左上方，红色等高线中心偏右下方。图中有
// 一条垂直的黑色虚线，位于 γCURN ≈ 4.4 处，贯穿整个主图
// 并延伸至上方一维图。主图左下角有图例文字：“DMX”为蓝色，
// “DMGP”为红色。 上方一维图：这是 γCURN 的边缘后验概率密
// 度曲线图。横轴与主图横轴共享，但无刻度标签；纵轴无标签
// 和刻度。图中包含两条平滑曲线：蓝色曲线对应 DMX，其峰值
// 位于 γCURN ≈ 3.2 附近；红色曲线对应 DMGP，其峰值位于 γ
// CURN ≈ 4.0 附近。黑色垂直虚线（γCURN ≈ 4.4）穿过此图。
// 该图显示 DMGP 的后验分布相对于 DMX 向更高的 γCURN 值偏
// 移。 右侧一维图：这是 log₁₀ A_CURN 的边缘后验概率密度
// 曲线图。纵轴与主图纵轴共享，无刻度标签；横轴无标签和刻
// 度。图中包含两条平滑曲线：蓝色曲线对应 DMX，其峰值位于
// log₁₀ A_CURN ≈ -13.9 附近；红色曲线对应 DMGP，其峰值位
// 于 log₁₀ A_CURN ≈ -14.3 附近。该图显示 DMGP 的后验分布
// 相对于 DMX 向更低的 log₁₀ A_CURN 值偏移。 整体趋势与结
// 论：两种模型的后验分布在大致范围内一致，但 DMGP 模型（
// 红色）将 γCURN 的后验分布推向更高的值（更接近垂直虚线
// 标记的位置），同时将 log₁₀ A_CURN 的后验分布推向更低的
// 值。这与图注中“DMGP shifts the posterior to higher
// values”的描述一致，但需注意该偏移在二维空间中表现为沿
// 正相关方向的移动。
#figure(placement: auto, [#block[
  #box(image("imgs/dmgp_comparison.png", width: 100%))
  ]],
  caption: [
    #smallcaps[curn]#super[$gamma$]~posterior distributions using DMGP (red) and DMX (blue) to model DM variations. The dashed line marks $gamma_("CURN") = 13 \/ 3$. While the posteriors are broadly consistent, DMGP shifts the $gamma_("CURN")$ posterior to higher values, making it more consistent with $gamma_("CURN") = 13 \/ 3$.
  ]
) <fig:dmgp>

== Spectral analysis <subsec:spectral>

Adopting power-law spectra for #smallcaps[curn]~and #smallcaps[hd]~is a useful simplification that reduces the number of fit parameters and yields more informative constraints; furthermore, it is expedient to identify #smallcaps[hd]#super[$(13 \/ 3)$]~with the hypothesis that we are observing the GWB from SMBHBs. Nevertheless, the standard $gamma = 13 \/ 3$ power law for GW inspirals may be altered by astrophysical processes such as stellar and gas friction in nuclei (see, e.g., #cite(<mm05>, style: "aas_noparen.csl") for a review), by appreciable eccentricity in SMBHB orbits #cite(<en07>), and by low-number SMBHB statistics #cite(<2008MNRAS.390..192S>). #smallcaps[hd]#super[$gamma$]~parameter recovery may also be biased if intrinsic pulsar noise is not modeled well by a power law. Indeed, our data show hints of a discrepancy from the idealized #smallcaps[hd]#super[$(13 \/ 3)$]~model: the $gamma_("HD")$ posterior in panel (b) of @fig:spectrum_correlations_plot favors slopes much shallower than 13/3, and the #smallcaps[hd]#super[$gamma$]-to-#smallcaps[curn]#super[$gamma$]~Bayes factor drops from 1,000 to 200 when Fourier components at more than five frequencies are included in the model.

// [figvision-cn] imgs/periodogram.png
// 本图由左右两个并排的子图组成，均为统计分布图，用于展示
// 不同引力波背景模型下傅里叶分量方差的贝叶斯后验分布。
// 左侧子图（对应 curn 模型）：包含两组垂直放置、以对应频
// 率为中心的概率密度小提琴图（分布图）。这些图以橙蓝两种
// 颜色区分：橙色代表 HD（Hellings-Downs 相关）模型，蓝色
// 代表 CURN（共同红噪声）模型。纵轴为对数尺度，标注为
// log₁₀√Φᵢ / s²，范围从 -9 到 -6，表示傅里叶分量的振幅平
// 方。横轴为频率，标注为 f [1/yr]，范围从 0.0 到略小于
// 1.0，对应数据集的 16.03 年跨度。图中在特定频率处有 14
// 个垂直分区，用数字 1 到 14 标记，相邻分区之间的垂直阴
// 影带（蓝色和橙色）直观展示了每个频率区间内后验分布的形
// 状和宽度。蓝色 CURN 模型的分布在低频段（约 f=0.1 至
// 0.5）有更宽的展宽，而橙色 HD 模型分布相对更窄。图中画
// 有三条拟合线：一条贯穿所有频率的黑色虚线，标注为 “best
// fit (γ = 3.2)”；下方两条点线分别对应 “best fit fixing
// γ = 13/3”。图中文字标注指出，在 “bins 1–8” 存在超出预
// 期功率（bin 6 边缘），且 “Hellings-Downs-correlated
// power in bins 1–5 and 8”。图中左上角图例显示蓝色方块对
// 应 CURN，橙色方块对应 HD。 右侧子图：为三个不同模型的
// 概率密度曲线（直方图）对比。纵轴没有数字刻度，表示概率
// 密度。横轴为对数尺度，标注为 log₁₀√Φ₂ / s²，范围从 -9
// 到 -6。图中包含三条曲线：一条蓝实线代表 CURN 模型，其
// 峰值位置在 -7.0 附近，随后在更负值处拖尾；一条橙实线代
// 表 HD 模型，峰值位置非常靠近 -7.0，且曲线更为尖锐、狭
// 窄，分布更集中在高值处；一条绿色虚线代表单极子（
// monopole）模型，峰值位置在 -7.2 左右，分布较宽；一条红
// 色点线代表偶极子（dipole）模型，峰值位置在 -8.0 左右，
// 分布最宽。图中右上角图例明确标注了四种线型的含义：蓝色
// 实线为 CURN，橙色实线为 HD，绿色虚线为 monopole，红色
// 点线为 dipole。该图直观反映出 HD 模型的后验概率密度集
// 中在比 CURN 模型更高的振幅区域。
#figure(scope: "parent", placement: auto, [#block[
  #box(image("imgs/periodogram.png", width: 100%))
  ]],
  caption: [
    #strong[Left]: Posteriors of Fourier component variance $Phi_i$ for the #smallcaps[curn]#super[$("free")$]~(left) and #smallcaps[hd]#super[$("free")$]~(right) models (see @sec:data), plotted at their corresponding frequencies $f_i = i \/ T$ with $T$ the 16.03-yr extent of the data set. Excess power is observed in bins 1--8 (somewhat marginally in bin 6); Hellings--Downs-correlated power in bins 1--5 and 8. The dashed line plots the best-fit power law, which has $gamma tilde.eq 3.2$ (as in panel (d) of @fig:spectrum_correlations_plot); the fit is pushed to lower $gamma$ by bins 1 and 8. The dotted line plots the best-fit power law when $gamma$ is fixed to 13/3; it overshoots in bin 1 and undershoots in bin 8. #strong[Right]: Posteriors of variance $Phi_2$ in Fourier bin 2 ($f_2 = 3.95$ nHz) in a #smallcaps[curn]#super[$("free")$]~+ #smallcaps[hd]#super[$("free")$]~+ #smallcaps[monopole]#super[$("free")$]~+ #smallcaps[dipole]#super[$("free")$]~model, showing evidence of a quasi-monochromatic monopole process (dashed). No monopole or dipole power is observed in all other bins of that joint model, with $Phi_("CURN", i)$ and $Phi_("HD", i)$ posteriors consistent with the left panel.
  ]
) <fig:periodogram>

We examine the spectral content of the 15-year data set using the #smallcaps[curn]#super[$("free")$]~and #smallcaps[hd]#super[$("free")$]~models, which are parametrized by the variances of the Fourier components at each frequency. Their marginal posteriors are shown in the left panel of @fig:periodogram, where bin number $i$ corresponds to $f_i = i \/ T$, with $T = 16.03$ yr the extent of the data set. For the purpose of illustration, we overlay best-fit power laws that thread the posteriors in a way similar to the factorized PTA likelihood of #cite(<2022PhRvD.105h4049T>, form: "prose") and #cite(<2023arXiv230315442L>, form: "prose").

We deem excess power, either uncorrelated for #smallcaps[curn]#super[$("free")$]~or correlated for #smallcaps[hd]#super[$("free")$], to be observed in a bin when the support of the posterior is concentrated away from the lowest amplitudes. No power of either kind is observed above $f_8$, consistent with the presence of a floor of white measurement noise. Furthermore, no correlated power is observed in bins 6 and 7, where a power-law model would expect a smooth continuation of the trend of bins 1--5 (cf.~the dashed fit of @fig:periodogram): this may explain the drop in the Bayes factor. However, correlated power reappears in bin 8, pushing the fit toward shallower slopes. Indeed, repeating the fit by omitting subsets of the bins suggests that the low recovered $gamma_("HD")$ is due mostly to bin 8 and to the lower-than-expected correlated power found in bin 1. Obviously, excluding those bins leads to higher $gamma_("HD")$ estimates.

To explore deviations from a pure power law that may arise from statistical fluctuations of the astrophysical background or from unmodeled systematics (perhaps related to the timing model), in App. #ref(<sec:apptprocess>, supplement: none) we relax the normal $c_k$ prior (cf. @eq:gp_covariance) to a multivariate Student's $t$-distribution that is more accepting of mild outliers. The resulting estimate of $gamma_("CURN")$ peaks at a higher value and is broader than in #smallcaps[curn]#super[$gamma$], with posterior medians and 5-95\% quantiles of $gamma_("CURN") = 3.5_(- 1.0)^(+ 1.0)$.

Similarly, spectral turnovers due to interactions between SMBHBs and their environments can result in reduced GWB power at lower frequencies, which might explain the slightly lower correlated power in bin 1. We investigate this hypothesis in App. #ref(<sec:appturnover>, supplement: none) using the turnover spectrum of #cite(<scm2015>). For this #smallcaps[curn]#super[$("turnover")$]~model, the 15-year data favor a spectral bend below 10 nHz (near $f_5$), but the Bayes factor against the standard #smallcaps[hd]#super[$gamma$]~is inconclusive.

Future data sets with longer time spans and the comparison of our data set with those of other PTAs should help clarify the astrophysical or systematic origin of these possible spectral features.

== Alternative correlation patterns <subsec:correlation>

Sources other than GWs can produce inter-pulsar residual correlations with spatial patterns other than HD. For example, errors in the solar-system ephemerides create time-dependent Roemer delays with dipolar correlations #cite(<r19>)#cite(<2020ApJ...893..112V>), and errors in the correction of telescope time to an inertial timescale #cite(<2012MNRAS.427.2780H>)#cite(<2020MNRAS.491.5951H>) create an identical time-dependent delay for all pulsars (i.e., a delay with monopolar correlations).

#cite(<grtm14>, form: "prose") showed that, for a pulsar array distributed uniformly across the sky, HD correlations can be decomposed as

$ Gamma_("HD" , a b) & = sum_(l = 0)^oo g_l thin P_l \( cos xi_(a b) \) ,\
g_0 = 0 , #h(0em) g_1 = 0 , #h(0em) g_l & = 3 \/ 2 \( 2 l + 1 \) frac(\( l - 2 \) !, \( l + 2 \) !) thin thin thin "for" thin thin thin l gt.eq 2 , $<eq:hdlegendre>

where the $P_l ( cos xi_(a b) )$ are Legendre polynomials of order $l$ evaluated at the pulsar angular separation $xi_(a b)$. In other words, a HD-correlated signal should have no power at $l = 0$ or $l = 1$.

We can perform a frequentist generic correlation search using Legendre polynomials#footnote[A Bayesian method for fitting correlations using Legendre polynomials can be found in #cite(<nay-23>, form: "prose").] with the multiple-component optimal statistic (MCOS; #cite(<sv2023>, style: "aas_noparen.csl"))---a generalized statistic that allows multiple correlation patterns to be fit simultaneously to the correlation coefficients $rho_(a b)$. @fig:optstat_legendre_vg shows the constraints on $A_l^2 = A^2 g_l$ obtained by fitting the correlations $rho_(a b)$ to this Legendre series using the MCOS and marginalizing over #smallcaps[curn]#super[$gamma$]~noise-parameter posteriors. The quadrupolar structure of the data is evident, along with a small but significant monopolar contribution.

// [figvision-cn] imgs/os_legendre_vg.png
// 这是一张单面板科学曲线图，展示不同阶数 Legendre 多项式
// 的归一化系数分布及其与纯 HD 信号理论谱的对比。横轴为
// Legendre 多项式阶数 l，取值为 0、1、2、3、4、5，无单位。
// 纵轴为归一化 Legendre 系数 A_l^2，单位为乘以 10^-30，
// 刻度范围从 -1 到 3，步长为 1。图中有两组数据元素：浅蓝
// 色分布标注为“MCOS Legendre spectrum”，黑色虚线标注为“
// Median Â_HD^2 spectrum”。浅蓝色分布呈小提琴图形态，每
// 个阶数 l 对应一个垂直的浅蓝色填充轮廓，内部有一条深蓝
// 色短横线表示中位数，轮廓的宽度表示概率密度分布。在每个
// 小提琴图中，l=0 对应的中位数约 0.55×10^-30，分布范围约
// 0.3 至 0.8×10^-30；l=1 对应的中位数约 0.4×10^-30，分布
// 范围约 -0.3 至 1.0×10^-30；l=2 对应的中位数约 1.8×10^
// -30，是最大值，分布范围约 0.7 至 2.7×10^-30；l=3 对应
// 的中位数约 -0.15×10^-30，分布范围约 -0.5 至 0.5×10^-30；
// l=4 对应的中位数约 -0.4×10^-30，分布范围约 -0.8 至 0.2
// ×10^-30；l=5 对应的中位数约 -0.5×10^-30，分布范围约
// -1.0 至 0.1×10^-30。黑色虚线为纯 HD 信号的中位谱，在 l
// =0 和 l=1 时约为 0；在 l=2 时达到峰值，约 1.8×10^-30，
// 与 MCOS 分布在该阶的中位数基本一致；随后在 l=3 降至约
// 0.5×10^-30，l=4 约 0.25×10^-30，l=5 约 0.1×10^-30。图
// 中有一条 y=0 的水平黑色实线作为零参考线。图顶部有图例：
// 浅蓝色方块表示“MCOS Legendre spectrum”，黑色虚线表示“
// Median Â_HD^2 spectrum”。该图传达的趋势是：MCOS 的
// Legendre 系数在 l=2 处有显著正值峰值，与纯 HD 信号的谱
// 峰位置一致；在 l=3、4、5 处系数中位数趋近于零或略微为
// 负，而 l=0 和 l=1 处则呈较小的正值或接近零。
#figure(placement: auto, [#block[
  #box(image("imgs/os_legendre_vg.png", width: 100%))
  ]],
  caption: [
    Multiple-component optimal statistic for a Legendre polynomial basis @eq:hdlegendre with $l_("max") = 5$. The violin plots show the distributions of the normalized Legendre coefficients $A_l^2 = A^2 g_l$ over #smallcaps[curn]#super[$gamma$]~noise-parameter posteriors. The black dashed line shows the Legendre spectrum of a pure-HD signal, with the median posterior $hat(A)_("HD")^2$.
  ]
) <fig:optstat_legendre_vg>

The same feature from the Legendre decomposition appears if we use the MCOS to search for multiple correlations simultaneously: a multiple regression analysis favors models that contain both significant HD and monopole correlations (see App. #ref(<sec:appmcos>, supplement: none)). From simulations of 15-year-like data sets (see App. #ref(<sec:appastrosims>, supplement: none)), we find a $p$-value of 0.11 (approx.~$2 sigma$) for observing a monopole at this significance or higher with a pure-HD injection of amplitude similar to what we observe. We also perform a model-checking study to assess whether the observed monopole is consistent with the #smallcaps[hd]#super[$(13 \/ 3)$]~model (see App. #ref(<sec:appmodelsims>, supplement: none)), and we find a $p$-value of 0.11 for producing an apparent monopole when the signal is purely #smallcaps[hd]#super[$(13 \/ 3)$]. Thus, we conclude that it is possible for a HD-correlated signal to appear to have monopole correlations in an optimal statistic analysis at this significance level.

In contrast, Bayesian searches for additional correlations do not find evidence of additional monopole- or dipole-correlated red noise processes: as shown in @fig:bfs, the Bayes factors for these processes are $tilde 1$. We also perform a general Bayesian search for correlations using a #smallcaps[curn]#super[$("free")$]~+ #smallcaps[hd]#super[$("free")$]~+ #smallcaps[monopole]#super[$("free")$]~+ #smallcaps[dipole]#super[$("free")$]~model, which allows for independent uncorrelated and correlated components at every frequency bin. We note that this analysis is more flexible than the ones described above, which assume a power-law power spectral density. We find no significant dipole-correlated power at any frequency, and we find monopole-correlated power only in the second frequency bin ($f_2 = 3.95$ nHz); posteriors of variance for that bin are shown in the right panel of @fig:periodogram.

Motivated by this finding, we perform a search for #smallcaps[hd]#super[$gamma$]~+ #smallcaps[sinusoid], which includes a deterministic sinusoidal delay (applied to all pulsars alike, as appropriate for a monopole) with free frequency, amplitude, and phase. The sinusoid's posteriors match the free-spectral analysis in frequency and amplitude; however, the Bayes factor between #smallcaps[hd]#super[$gamma$]~+ #smallcaps[sinusoid]~and #smallcaps[hd]#super[$gamma$]  calculated using two methods #cite(<hee15>)#cite(<HourihaneMeyers2022>), is only $tilde 1$, so the signal cannot be considered statistically significant. Astrophysically motivated searches for sources that produce sinusoidal or sinusoid-like delays in the residuals, such as an individual SMBHB or perturbations to the local gravitational field induced by fuzzy dark matter #cite(<2014JCAP...02..019K>), also yield Bayes factors $tilde 1$. Thus we conclude that there is some evidence of additional power at 3.95 nHz with monopole correlations; however, the significance in the Bayesian analyses is low, while the optimal-statistic S/N could be produced by a HD-correlated signal. Therefore, we cannot definitively say whether the signal is present, or determine the source. We note that performing an MCOS analysis after subtracting off realizations of a sinusoid using #smallcaps[hd]#super[$gamma$]~+ #smallcaps[sinusoid]~posteriors reduces the $( upright(S) \/ upright(N) )_("monopole") tilde.eq 0$ while $( upright(S) \/ upright(N) )_("HD")$ remains unchanged, indicating that this single-frequency monopole-correlated signal is likely causing the nonzero monopole signal observed in the MCOS analysis.

Similar hints of a monopolar signal (though weaker) were found in the NANOGrav 12.5-year data set, unsurprisingly given that it is a subset of the current data set. To exercise due diligence, we audited the correction of telescope time to GPS time at the Arecibo Observatory and at the Green Bank Telescope, and found nothing that could explain our observations. The subsequent steps in the time-correction pipeline rely on very accurate atomic clocks and are unlikely to introduce considerable systematics #cite(<petit2022>). An important test will be whether this signal persists in future data sets. If this monopolar feature is a truly an astrophysical signal, we would expect it to increase in significance as our data set grows. Comparisons with other PTAs and combined IPTA data sets will also provide crucial insight.

== Dropout and cross-validation <subsec:cross-validation>

The GWB is by its nature a signal affecting all of the pulsars in the PTA, although it may appear more significant in some based on their observing time span, noise properties, and on the particular realization of pulsar and Earth contributions #cite(<2023MNRAS.518.1802S>). One way to assess the significance of the GWB in each pulsar is a Bayesian #emph[dropout analysis] #cite(<aab-19>)#cite(<abb-20>), which introduces a binary parameter that turns on and off the common signal (or its inter-pulsar correlations) for a single pulsar, leaving all other pulsars unchanged. The Bayes factor associated with this parameter, also referred to as the "dropout factor," describes how much each pulsar likes to "participate" in the common signal.

@fig:dropout plots #smallcaps[curn]#super[$gamma$]~vs. #smallcaps[irn]~dropout factors for all 67 pulsars (blue). We find positive dropout factors (i.e., dropout factors $> 2$) for an uncorrelated common process in twenty pulsars, while only one has a dropout factor $< 0.5$. For comparison, in the NANOGrav 12.5-year data set ten pulsars showed positive dropout factors for an uncorrelated common process, while three had negative dropout factors. We also show HD correlations vs. #smallcaps[curn]#super[$gamma$]~dropout factors (orange). For these, the uncorrelated common process is always present in all pulsars, but the cross-correlations for all pulsar pairs involving a given pulsar may be dropped from the likelihood. We find positive factors for HD correlations vs. #smallcaps[curn]#super[$gamma$]~in seven pulsars, while three are negative. We expect more pulsars to have positive dropout factors for #smallcaps[curn]#super[$gamma$]~vs. #smallcaps[irn]~than for Hellings--Downs vs. #smallcaps[curn]#super[$gamma$]~because the Bayes factor comparing the first two models is significantly higher than the one comparing the second two models (see @fig:bfs). Negative dropout factors could be caused by noise fluctuations or they could be an indication that more advanced chromatic noise modeling is necessary~#cite(<aab-20>). They could also be caused by the GWB itself, which induces both correlated and uncorrelated noise in the pulsars (the so-called "Earth terms" and "pulsar terms"; #cite(<2018JPhCo...2j5002M>, style: "aas_noparen.csl")).

// [figvision-cn] imgs/dropout_scatter_2panel.png
// 图由上下排列的两个子图组成，共享横轴。 子图（下方）为
// 散点图。横轴标签为“log₁₀(Dropout Factor)”，范围从 −0.5
// 到 1.3，刻度间隔为 0.5，即 −0.5、0.0、0.5、1.0。纵轴标
// 签为“Observation Span [yrs]”，范围从约 3 到 17 年，主
// 刻度为 5、10、15。图中每个点代表一颗脉冲星；蓝色实心圆
// 点表示 CURN 的 dropout factor，橙色实心圆点表示 HD
// correlations 的 dropout factor。蓝色点在图例中标注为“
// Dropout factors, CURN”，橙色点标注为“Dropout factors,
// HD correlations”。图例位于右下角。大部分数据点纵坐标分
// 布在 5 到 16 年之间，横坐标密集在 0 附近，即 dropout
// factor 约为 1；横坐标大于 0.5 的蓝色点明显多于橙色点。
// 纵坐标较高（>12 年）的脉冲星中，蓝色点横坐标分布从约 −
// 0.4 延伸到 1.2，而橙色点横坐标主要集中在约 −0.4 到 0.3
// 之间。部分脉冲星只有蓝色或橙色一个点，少数脉冲星在同一
// 纵坐标处同时存在蓝色和橙色点。数据表明，长观测时间的脉
// 冲星中 dropout factor 存在显著离散，且整体上蓝色点（
// CURN）在 log₁₀ 值大于 0.5 的区域占比更高，说明支持
// CURN 参与的脉冲星数量更多。 子图（上方）为阶梯状直方图，
// 横轴与下方子图共享，但横轴刻度标签未显示。纵轴无标签，
// 表示频数，仅显示刻度线，范围从 0 到最高约 16，主刻度间
// 隔为 4。图中包含两条阶梯线：蓝色阶梯线表示 CURN 的 log
// ₁₀(Dropout Factor) 分布，橙色阶梯线表示 HD
// correlations 的分布。两条线在横轴 0.0 附近均有明显峰值，
// 蓝色峰值频数约 16，橙色峰值频数约 13。蓝色分布右侧尾部
// 延伸至约 1.3，且在 1.0 附近有一个小峰，频数约 1；橙色
// 分布在约 0.3 处有一个小峰，频数约 2。分布表明两种模型
// dropout factor 均集中在 0（即 factor 为 1）附近，但蓝
// 色分布的右偏尾部更明显。
#figure(placement: auto, [#block[
  #box(image("imgs/dropout_scatter_2panel.png", width: 100%))
  ]],
  caption: [
    Support for #smallcaps[curn]#super[$gamma$]~(blue) and #smallcaps[hd]#super[$gamma$]~correlations (orange) in each pulsar, as measured by a dropout analysis. Dropout factors greater than 1 indicate support for the #smallcaps[curn]#super[$gamma$]~or #smallcaps[hd]#super[$gamma$]  while those less than 1 show that the pulsar disfavors it. We find significant spread in the dropout factors among pulsars with long observation times, but overall more pulsars favor #smallcaps[curn]#super[$gamma$]~participation and #smallcaps[hd]#super[$gamma$]~correlations than disfavor them.
  ]
) <fig:dropout>

In addition to Bayes factors, the goodness-of-fit of probabilistic models can be evaluated by assessing their predictive performance #cite(<gelman2013bayesian>). Specifically, given that the GWB is correlated across pulsars, we can (partially) predict the timing residuals $bold(delta t)_a$ of pulsar $a$ from the residuals $bold(delta t)_(-a)$ of all other pulsars by way of the "leave-one-out" #emph[posterior predictive likelihood] (PPL)

$
  p(bold(delta t)_a | bold(delta t)_(-a)) = integral upright(d) bold(theta)_a dot p(bold(delta t)_a | bold(theta)_a) dot p(bold(theta)_a | bold(delta t)_(-a)) ,
$

where $bold(theta)_a$ are all the parameters and hyperparameters that affect pulsar $a$ in a given model. As discussed in #cite(<meyers-23>, form: "prose"), we compare the predictive performance of #smallcaps[curn]#super[$(13 \/ 3)$]~and #smallcaps[hd]#super[$(13 \/ 3)$]~for each pulsar in turn by taking the ratio of the corresponding leave-one-out PPLs. These ratios are closely related to the dropout factors plotted in @fig:dropout. Multiplying the PPL ratios for all pulsars yields the #emph[pseudo Bayes factor] (PBF). For the 15-year data set we find $"PBF"_(15 thin "yr") =$ 1,400 in favor of #smallcaps[hd]#super[$(13 \/ 3)$]~over #smallcaps[curn]#super[$(13 \/ 3)$]. The PBF does not have a "betting odds" interpretation, but we obtain a crude estimate of its significance by building its background distribution on 40 #smallcaps[curn]#super[$(13 \/ 3)$]~simulations with the MAP $log_10 A_("CURN")$ inferred from the 15-year data set. For all simulations except one, the PBF favors the null hypothesis, and $log_10 "PBF"_(15 thin "yr")$ is displaced by approx.~three standard deviations from the mean $log_10 "PBF"$.

// [figvision-cn] imgs/forward_slices.png
// 这是一张单面板双纵轴曲线图（子图a），用于展示脉冲星计
// 时阵中信号信噪比（S/N）随数据集时间跨度和脉冲星数量的
// 增长关系。图表没有其他子图。 图的横轴标签为“Years in
// data set”（数据集中的年数），主刻度标记为6.0、8.0、
// 10.0、12.0、14.0、16.0，数据点从约5.8年延伸到约16.0年，
// 步长约为0.5年（每次增加六个月的数据）。左侧纵轴标签为“
// S/N”（信噪比），刻度范围从-3到7，主刻度标记为-2、0、2、
// 4、6，次刻度间隔为1。右侧纵轴标签为“Npuls”（脉冲星数量），
// 刻度范围从约15到约70，主刻度标记为20、30、40、50、60，
// 次刻度间隔为5。 图中有两个图例。左上角图例包含一条蓝色
// 实线，标注“HD S/N”。右下角图例包含一条橙色虚线，标注“
// Number of pulsars”。 蓝色小提琴图用来表示不同时间切片
// 下最优统计量S/N在curn ~noise参数上的分布。每个小提琴对
// 应一个约0.5年的数据切片，从约5.8年开始到约16.0年，共约
// 21个小提琴。小提琴的颜色映射为单一浅蓝色填充，黑色细轮
// 廓。每个小提琴的内部结构包括：中心垂直黑色实线（沿用小
// 提琴的纵向），一个黑色小圆点表示分布中位数，从中心点向
// 上下延伸的粗黑竖线表示四分位距（IQR），更细的黑线表示
// 整体分布范围（类似箱线图叠加在小提琴上）。纵向宽度代表
// 该S/N值处的概率密度。分布形态随时间推移有明显变化：在
// 6.0-8.0年期间，S/N中位数约为-2至-0.5，分布较窄，多集中
// 在负值区域；8.0-10.0年时中位数逐渐升至0左右，分布顶部
// （高S/N侧）开始出现长尾，最高可达约2-2.5；10.0-12.0年
// 期间，中位数升至约0.5-1.5，小提琴顶部延伸至约3-4，底部
// 约-1.5；12.0-14.0年期间，中位数保持在约1-2，上尾可达
// 4-5.5，但个别小提琴的下尾仍至-1；14.0-16.0年期间，中位
// 数显著上升至约3-4，分布明显变宽，上尾达6-7，下尾约
// 0.5-2，说明最优统计量的分布随数据集时间增长而整体向高
// 信噪比方向移动，并且离散度增大。 橙色虚线表示每个时间
// 切片使用的脉冲星数量（对应右轴Npuls）。该虚线由一系列
// 橙色空心圆点连接而成，每个圆点对应一个小提琴的时间位置。
// 脉冲星数量随时间呈阶梯式上升：从约5.8年时的约16颗开始，
// 在6.0-8.0年期间缓慢上升至约25颗；在8.0年之后开始出现较
// 明显的台阶式增加，8.5年约25颗，9.0年约26颗，9.5年约27
// 颗；在10.0年时约28颗，10.5年约30颗，11.0年约32颗，11.5
// 年约33颗；在11.5-12.0年之间出现一次跳升，12.0年达到约
// 40颗，12.5年约43颗，13.0年约43颗，13.5年约44颗；在14.0
// 年约45颗，14.5年约50颗，15.0年约51颗，15.5年约65颗，
// 16.0年约65颗。每新增六颗脉冲星（约每3年数据积累，满足“
// 积累三年数据后新增脉冲星”的规则），脉冲星数量对应一次
// 明显的台阶上升。橙色虚线的走势与蓝色小提琴中位数的上升
// 趋势一致，尤其在11.5-12.0年和15.0-15.5年两个明显增加点，
// S/N的中位数和上尾同时出现跃升。 图内没有比例尺（非显微
// 图），也没有色标（颜色单一）。图中所有标注文字包括：横
// 轴标题“Years in data set”、左纵轴标题“S/N”、右纵轴标题
// “Npuls”、左上图例文字“HD S/N”、右下图例文字“Number of
// pulsars”，以及坐标轴上的数字刻度标签。图表整体传达的趋
// 势是：随着数据集时间增加（每次增加六个月数据），最优统
// 计量的信噪比分布整体向高值移动，且高S/N尾部显著增长；
// 脉冲星数量呈阶梯式增加，每次增加对应于累积三年数据后加
// 入新脉冲星；S/N的增长与脉冲星数量的增加在时间上高度相
// 关，尤其在大幅增加脉冲星数量的节点，S/N分布出现明显的
// 上移和展宽。
#figure(placement: auto, [#block[
  #box(image("imgs/forward_slices.png", width: 100%))
  ]],
  caption: [
    S/N growth as a function of time and number of pulsars. As we move from left to right we add an additional six months of data at each step. New pulsars are added when they accumulate three years of data. The blue violin plot shows the distribution of the optimal statistic S/N over #smallcaps[curn]#super[$gamma$]~noise parameters. The dashed orange line shows the number of pulsars used for each time slice.
  ]
) <fig:os_time_slice_forward>

A different sort of cross-validation relies on evaluating the optimal statistic for temporal subsets of the data set, as in #cite(<hazboun:2020a>, form: "prose"). In the regime where the lowest frequencies of our data are dominated by the GWB, the optimal statistic S/N should grow with the square root of the time span of the data and linearly with the number of pulsars in the array#cite(<Siemens:2013zla>); in this regime increasing the number of pulsars is the best way to boost PTA sensitivity to the GWB. To verify that this is indeed the case, we analyze "slices" of the data set in six-month increments, starting from a six-year data set. Once a new pulsar accumulates three years of data, we add it to the array. We perform a separate Bayesian #smallcaps[curn]#super[$gamma$]~analysis for each slice and calculate the Hellings--Downs optimal statistic over the noise-parameter posterior. In @fig:os_time_slice_forward, we plot the S/N distributions against time span and the number of pulsars. As expected, we observe essentially monotonic growth associated with the increase in the number of pulsars.

The signal should also be consistent between timing observations made with Arecibo and GBT. To test this, we analyze the two split-telescope data sets (see App. #ref(<app:data_set_details>, supplement: none)); both show evidence of common-spectrum excess noise.

@fig:telescope_psd shows Arecibo (orange) and GBT (green) #smallcaps[curn]#super[$gamma$]~posteriors, which are broadly consistent with each other and with full-data posteriors (blue).

Arecibo yields $log_(10) A = -14.02^(+0.18)_(-0.22)$ and $gamma = 2.78^(+0.70)_(-0.64)$ (medians with 68\% credible intervals), while GBT yields $log_(10) A = -14.2^(+0.15)_(-0.17)$ and $gamma = 3.37^(+0.40)_(-0.38)$.
 to spatial correlations than the full data set, because they have fewer pulsars and therefore pulsar pairs (see @fig:ang_sep of App. #ref(<app:data_set_details>, supplement: none)). Nevertheless, we can search them for spatial correlations using the optimal statistic. We find a noise-marginalized Hellings--Downs S/N of 2.9 for Arecibo and 3.3 for GBT, consistent with the split-telescope data sets having about half the number of pulsars as the full data set. The S/Ns for Arecibo and GBT are comparable: while telescope sensitivity, observing cadence, and distribution of pulsars all affect GWB sensitivity, the dominant factor is the number of pulsars because the S/N scales linearly with the number of pulsars but only as $prop ( sigma sqrt(c) )^(- 1 \/ gamma)$, where $sigma$ is the residual root-mean-squared, and $c$ is the observing cadence #cite(<Siemens:2013zla>). We also note that the distributions of angular separations probed by Arecibo and GBT are similar, although GBT observes more pulsar pairs with large angular separations (see @fig:ang_sep).

// [figvision-cn] imgs/telescope_comparison_psd.png
// 这是一张包含三个子图的科学数据图，展示参数 γCURN 和
// log10 ACURN 的后验概率分布。主图位于中央，顶部和右侧各
// 附有一个边缘分布图。 主图（中央子图）： 类型为二维后验
// 概率等高线图。横轴为 γCURN，刻度范围约为 0.8 到 5.6，
// 主要刻度标记为 1、2、3、4、5。纵轴为 log10 ACURN，刻度
// 范围约为 -15.2 到 -13.3，主要刻度标记为 -13.5、-14.0、
// -14.5、-15.0。图内绘制了三组彩色等高线，由外向内表示概
// 率密度递增：橙色等高线代表“AO only”（Arecibo 单望远镜
// 数据集），绿色等高线代表“GBT only”（GBT 单望远镜数据集），
// 蓝色等高线代表“Entire PTA”（全数据集）。图中左下角有文
// 字标注图例，分别对应蓝色、橙色、绿色线条。所有等高线呈
// 从左下向右上倾斜的椭圆状分布，且相互重叠。图中有一条垂
// 直的黑色虚线，位置约在 γCURN = 4.33 处，贯穿整个主图和
// 顶部子图。 顶部子图： 类型为一维边缘概率密度曲线图。横
// 轴与主图共享，无独立刻度标签。纵轴表示概率密度，但没有
// 数字标签和单位。图内有三条曲线：橙色曲线（AO only）呈
// 现一个宽缓的单峰，峰值约在 γCURN = 2.7；绿色曲线（GBT
// only）呈现较窄的单峰，峰值约在 γCURN = 3.4；蓝色曲线（
// Entire PTA）呈现最窄最高的单峰，峰值约在 γCURN = 3.3。
// 一条黑色垂直虚线位于 γCURN = 4.33 处。橙色曲线的峰值位
// 置明显低于绿、蓝两色曲线的峰值位置，且分布更宽；绿、蓝
// 两条曲线几乎重合。 右侧子图： 类型为一维边缘概率密度曲
// 线图。纵轴与主图共享，无独立刻度标签。横轴表示概率密度，
// 无数字标签和单位。图内有三条曲线：橙色曲线（AO only）
// 呈现单峰，峰值位置在 log10 ACURN ≈ -13.9 处；绿色曲线
// （GBT only）呈现单峰，峰值位置约在 -14.05；蓝色曲线（
// Entire PTA）呈现单峰，峰值位置约在 -14.1。三条曲线在纵
// 向上有重叠，橙色曲线的峰值对应的 log10 ACURN 值略高于
// 绿、蓝两色曲线。 整体趋势与结论：在全数据集（蓝色）和
// GBT数据集（绿色）中，γCURN 的后验分布高度一致，峰值约
// 在 3.3-3.4 之间，且分布较窄；而Arecibo数据集（橙色）的
// γCURN 后验分布更宽且峰值偏向较低值（约2.7）。垂直虚线
// （γCURN ≈ 4.33）位于所有后验分布峰值的右侧，表明该参考
// 值不在后验分布的高概率区域。
#figure(placement: auto, [#block[
  #box(image("imgs/telescope_comparison_psd.png", width: 100%))
  ]],
  caption: [
    #smallcaps[curn]#super[$gamma$]~posterior distributions for Arecibo (orange) and GBT (green) split-telescope data sets, and for the full data set (blue). The dashed line marks $gamma_("CURN") = 13 \/ 3$. The posteriors for the split-telescope data sets are consistent with each other and with the posteriors for the full data set.
  ]
) <fig:telescope_psd>

= DISCUSSION <sec:discussion>

In this letter we have reported on a search for an isotropic stochastic GWB in the 15-year NANOGrav data set. A previous analysis of the 12.5-year NANOGrav data set found strong evidence for excess low-frequency noise with common spectral properties across the array, but inconclusive evidence for Hellings--Downs inter-pulsar correlations, which would point to the GW origin of the background. By contrast, the 12.5-year data disfavored purely monopolar (clock-error--like) and dipolar (ephemeris-error--like) correlations. Subsequent independent analyses by the PPTA and EPTA collaborations reported results consistent with ours #cite(<ppta_dr2_gwb>)#cite(<epta_dr2_gwb>), as did the search of a combined data set #cite(<2022MNRAS.510.4873A>)---a syzygy of tantalizing discoveries that portend the rise of low-frequency GW astronomy.

We analyzed timing data for 67 pulsars in the 15-year data set (those that span $> 3$ years), with a total time span of 16.03 years, and more than twice the pulsar pairs than in the 12.5-year data set. The common-spectrum stochastic signal gains even greater significance and is detected in a larger number of pulsars. For the first time, we find compelling evidence of Hellings--Downs inter-pulsar correlations, using both Bayesian and frequentist detection statistics (see @fig:spectrum_correlations_plot), with false-alarm probabilities of $p = 10^(- 3)$ and $p = 5 times 10^(- 5)$--$1.9 times 10^(- 4)$, respectively (see @fig:background).

The significance of Hellings--Downs correlations increases as we increase the number of frequency components in the analysis up to five, indicating that the correlated signal extends over a range of frequencies. A detailed spectral analysis supports a power-law signal, but at least two frequency bins show deviations that may skew the determination of spectral slope (@fig:periodogram). These discrepancies may arise from astrophysical or systematic effects. Furthermore, slope determination changes significantly using an alternative DM model (@fig:dmgp). The study of spatial correlations with the optimal statistic confirms a Hellings--Downs quasi-quadrupolar pattern (@fig:optstat_legendre_vg and panel c of @fig:spectrum_correlations_plot), with some indications of an additional monopolar signal confined to a narrow frequency range near 4~nHz. However, the Bayesian evidence for this monopolar signal is inconclusive, and we could not ascribe it to any astrophysical or terrestrial source (e.g., an individual SMBHB or errors in the chain of timing corrections).

The GWB is a persistent signal that should increase in significance with number of pulsars and observing time span. This is indeed what we observe by analyzing slices of the data set (see @fig:os_time_slice_forward). Furthermore, the signal is present in multiple pulsars (@fig:dropout), and can be found in independent single-telescope data sets (@fig:telescope_psd). We are preparing a number of other papers searching the 15-year data set for stochastic and deterministic signals, including an all-sky, all-frequency search for GWs from individual circular SMBHBs. This search, together with the same analysis of the 12.5-year data set #cite(<2023arXiv230103608A>), indicates that the spectrum and correlations we observe cannot be produced by an individual circular SMBHB.

If the Hellings--Downs-correlated signal is indeed an astrophysical GWB, its origin remains indeterminate. Among the many possible sources in the PTA frequency band, numerous studies have focused on the unresolved background from a population of close-separation SMBHBs. The SMBHB population is a direct byproduct of hierarchical structure formation, which is driven by galaxy mergers #cite(<blumenthal84>). In a post-merger galaxy, the SMBHs sink to the center of the common merger remnant through dynamical interactions with their astrophysical environment, eventually leading to the formation of a binary #cite(<bbr80>). GW emission from a SMBHB at nHz frequencies is quasi-monochromatic because the binaries evolve very slowly. Under the assumption of purely GW-driven binary evolution, the expected characteristic-strain spectrum is $prop f^(- 2 \/ 3)$ (or $f^(- 13 \/ 3)$ for pulsar-timing residuals).

The GWB spectrum may also feature a low-frequency turnover induced by the dynamical interactions of binaries with their astrophysical environment (e.g., with stars or gas, see #cite(<2002ApJ...567L...9A>, style: "aas_noparen.csl")#cite(<shm-04>, style: "aas_noparen.csl")#cite(<mm05>, style: "aas_noparen.csl")) or possibly by non-negligible orbital eccentricities persisting to small separations #cite(<en07>). We find little support for a low-frequency turnover in our data (see App. #ref(<sec:appturnover>, supplement: none)).

The GWB amplitude is determined primarily by SMBH masses and by the occurrence rate of close binaries, which in turn depends on the galaxy merger rate, the occupation fraction of SMBHs, and the binary evolution timescale; population models predict amplitudes ranging over more than an order of magnitude #cite(<rr95>)#cite(<wl03>)#cite(<jb03>)#cite(<2014ApJ...789..156M>)#cite(<2013MNRAS.433L...1S>), under a variety of assumptions. @fig:astro_compare displays a comparison of #smallcaps[hd]#super[$gamma$]~parameter posteriors with power-law spectral fits from an observationally constrained semi-analytic model of the SMBHB population constructed with the #smallcaps[holodeck] package #cite(<holodeck>). This particular set of SMBHB populations assumes purely GW-driven binary evolution, and uses relatively narrow distributions of model parameters based on literature constraints from galaxy-merger observations #cite(<Tomczak-2014>). While the amplitude recovered in our analysis is consistent with models derived directly from our understanding of SMBH and galaxy evolution, it is toward the upper end of predictions implying a combination of relatively high SMBH masses and binary fractions. A detailed discussion of the GWB from SMBHBs in light of our results is given in #cite(<aaa-23_smbhb>, form: "prose").

// [figvision-cn] imgs/nano15_astrogw_compare.png
// 这是一张二维等高线图（后验概率分布图），用于比较
// NANOGrav 15年数据集与模拟引力波背景（GWB）光谱的拟合结
// 果。横轴为γ_GWB（引力波背景光谱指数），范围约2.0至5.2；
// 纵轴为log10_A_GWB（引力波背景振幅的对数），范围约-16.8
// 至-13.4。图中有蓝色和红色两组等高线，每组各有三条，分
// 别表示1σ、2σ和3σ置信区间。蓝色实线为NANOGrav 15年数据
// 集的15年数据后验分布，红色虚线为基于holodeck模拟的
// SMBHB种群在纯引力波驱动双星演化假设下对GWB光谱的幂律拟
// 合结果。蓝色区域沿横轴2.2至4.0延伸，纵轴约-14.6至-13.6，
// 中心约在横轴3.3、纵轴-14.1处；红色区域沿横轴约2.4至4.6
// 延伸，纵轴约-15.2至-13.4，中心约在横轴3.8、纵轴-14.2处，
// 呈更宽的分布。图中有一条垂直黑色虚线，位于横轴γ_GWB=13
// /3≈4.33处，标注为“γ_GWB=13/3”。左下角有图例：蓝色文字“
// NANOGrav 15-year”对应蓝色实线，红色文字“HOLODECK Sims”
// 对应红色虚线。该图表明NANOGrav 15年数据集的振幅和光谱
// 指数后验分布与基于holodeck模拟的SMBHB种群在纯引力波驱
// 动演化假设下的幂律拟合结果存在一定重叠，但NANOGrav的分
// 布更集中于较低的光谱指数（约3.3），而模拟结果更偏向于
// 较高的光谱指数（约3.8），且模拟结果的分布范围更宽。
#figure(placement: auto, [#block[
  #box(image("imgs/nano15_astrogw_compare.png", width: 100%))
  ]],
  caption: [
    Posteriors of #smallcaps[hd]#super[$gamma$]~amplitude (for $f_("ref") = 1 thin "yr"^(- 1)$) and spectral slope for the 15-year data set (blue), compared to power-law fits to simulated GWB spectra (red, dashed) from a population of SMBHBs generated by #smallcaps[holodeck] #cite(<holodeck>) under the assumption of purely GW-driven binary evolution, and narrowly distributed model parameters based on galaxy merger-observations. We show $1 \/ 2 \/ 3 sigma$ regions, and the dashed line indicates $gamma = 13 \/ 3$. The broad contours confirm that population variance can lead to a significant spread of spectral characteristics.
  ]
) <fig:astro_compare>

In addition to SMBHBs, more exotic cosmological sources such as inflation, cosmic strings, phase transitions, domain walls, and curvature-induced GWs can also produce detectable GWBs in the nHz range #cite(<guzzetti2016gravitational>)#cite(<2018CQGra..35p3001C>) [and references therein]. Similarities in the spectral shapes of cosmological and astrophysical signals make it challenging to determine the origin of the background from its spectral characterization #cite(<kpm-22>). The question could be settled by the detection of signals from individual loud SMBHBs or by the observation of spatial anisotropies, since the anisotropies expected from SMBHBs are orders of magnitude larger than those produced by most cosmological sources #cite(<2018CQGra..35p3001C>)#cite(<2022JCAP...11..009B>). We discuss these models in the context of our results in #cite(<aaa-23_cosmo>, form: "prose").

The EPTA and Indian Pulsar Timing Array (InPTA; #cite(<InPTA>, style: "aas_noparen.csl")), PPTA, and Chinese Pulsar Timing Array (CPTA; #cite(<CPTA>, style: "aas_noparen.csl")) collaborations have also recently searched their most recent data for signatures of a gravitational-wave background #cite(<epta23>)#cite(<ppta23>)#cite(<cpta23>), and an upcoming IPTA paper will compare the results of these searches. The IPTA's forthcoming Data Release 3 will combine the NANOGrav $15$-year data set with observations from the EPTA, PPTA, and InPTA collaborations, comprising about 80 pulsars with time spans up to 24 years, and offering significantly greater sensitivity to spatial correlations and spectral characteristics than single-PTA data sets. Future PTA observation campaigns will improve our understanding of this signal and of its astrophysical and cosmological interpretation. Longer data sets will tighten spectral constraints on the GWB, clarifying its origin #cite(<astro4cast>). Greater numbers of pulsars will allow us to probe anisotropy in the GWB #cite(<ptr2022>) and its polarization structure (see, e.g., #cite(<2021ApJ...923L..22A>, style: "aas_noparen.csl") and references therein). The observation of a stochastic signal with spatial correlations in PTA data, suggesting a GWB origin, expands the horizon of GW astronomy with a new Galaxy-scale observatory sensitive to the most massive black-hole systems in the Universe and to exotic cosmological processes.

#emph[Author contributions.] An alphabetical-order author list was used for this paper in recognition of the fact that a large, decade timescale project such as NANOGrav is necessarily the result of the work of many people. All authors contributed to the activities of the NANOGrav collaboration leading to the work presented here, and reviewed the manuscript, text, and figures prior to the paper's submission. Additional specific contributions to this paper are as follows.

G.A., A.A., A.M.A., Z.A., P.T.B., P.R.B., H.T.C., K.C., M.E.D., P.B.D., T.D., E.C.F., W.F., E.F., G.E.F., N.G., P.A.G., J.G., D.C.G., J.S.H., R.J.J., M.L.J., D.L.K., M.K., M.T.L., D.R.L., J.L., R.S.L., A.M., M.A.M., N.M., B.W.M., C.N., D.J.N., T.T.P., B.B.P.P., N.S.P., H.A.R., S.M.R., P.S.R., A.S., C.S., B.J.S., I.H.S., K.S., A.S., J.K.S., and H.M.W.~developed the 15-year data set through a combination of observations, arrival time calculations, data checks and refinements, and timing model development and analysis; additional specific contributions to the data set are summarized in NG15.

S.R.T.~and S.J.V.~led the search and coordinated the writing of this paper. P.T.B., J.S.H., P.M.M., N.S.P., J.S., S.R.T., M.V., and S.J.V.~wrote the paper, made the figures, and generated the bibliography. K.P.I., N.L., N.S.P., X.S., J.S., J.P.S., S.R.T., and S.J.V.~performed analyses and developed new techniques on a preliminary 14-year data set.

P.T.B., B.B., B.D.C., S.C., B.D., G.E.F., K.G., A.D.J., A.R.K., L.Z.K., N.L., W.G.L., N.S.P., S.C.S., L.S., X.S., J.S., J.P.S., S.R.T., C.U., M.V., S.J.V., Q.W., and C.A.W.~analyzed preliminary versions of the 15-year data set.

J.S.H., J.G., N.L., N.S.P., J.P.S., and J.K.S.~performed noise analyses on the data set.

P.T.B., B.B., R.B., R.C., M.C., N.J.C., D.D., H.D., G.E.F., K.A.G., S.H., A.D.J., N.L., W.G.L., P.M.M., P.P., N.S.P., S.C.S., X.S., J.S., J.P.S., J.T., S.R.T., M.V., S.J.V., and C.A.W.~performed the Bayesian and frequentist analyses presented in this paper.

K.G., J.S.H., P.M.M., J.D.R., and S.J.V.~computed the background distribution of our detection statistics.

P.R.B., P.M.M., N.S.P., and M.V.~performed simulations that were used to compute false alarm probabilities.

A.M.A., P.T.B., B.B., B.D., S.C., J.A.E., G.E.F., J.S.H., A.D.J., A.R.K., N.L., M.T.L., K.D.O., T.T.P., N.S.P., J.S., J.P.S., J.K.S., S.R.T., M.V., and S.J.V.~contributed to the development of our code.

P.T.B., N.J.C., J.S.H., A.D.J., T.B.L., P.M.M., J.D.R., and M.V.~performed an internal code review.

K.C., C.C., J.A.E., J.S.H., D.R.M., M.A.Mc., C.M.F.M., K.D.O., N.S.P., S.R.T., M.V., R.v.H., and S.J.V.~were part of a NANOGrav Detection Study Group.

M.A.M.~and P.N.~served on the IPTA Detection Committee. K.C., J.S.H., T.J.W.L., P.M.M., N.S.P., J.D.R., X.S., S.R.T., S.J.V., and C.A.W.~responded to the Detection Checklist from the IPTA Detection Committee.

#emph[Acknowledgments.] The NANOGrav collaboration receives support from National Science Foundation (NSF) Physics Frontiers Center award numbers 1430284 and 2020265, the Gordon and Betty Moore Foundation, NSF AccelNet award number 2114721, an NSERC Discovery Grant, and CIFAR.

The Arecibo Observatory is a facility of the NSF operated under cooperative agreement (AST-1744119) by the University of Central Florida (UCF) in alliance with Universidad Ana G. Méndez (UAGM) and Yang Enterprises (YEI), Inc. The Green Bank Observatory is a facility of the NSF operated under cooperative agreement by Associated Universities, Inc. The National Radio Astronomy Observatory is a facility of the NSF operated under cooperative agreement by Associated Universities, Inc.

This work used the Extreme Science and Engineering Discovery Environment (XSEDE), which is supported by National Science Foundation grant number ACI-1548562. Specifically, it used the Bridges-2 system, which is supported by NSF award number ACI-1928147, at the Pittsburgh Supercomputing Center (PSC). This work was conducted using the Thorny Flat HPC Cluster at West Virginia University (WVU), which is funded in part by National Science Foundation (NSF) Major Research Instrumentation Program (MRI) Award number 1726534, and West Virginia University. This work was also conducted in part using the resources of the Advanced Computing Center for Research and Education (ACCRE) at Vanderbilt University, Nashville, TN. This work was facilitated through the use of advanced computational, storage, and networking infrastructure provided by the Hyak supercomputer system at the University of Washington. This research was supported in part through computational resources and services provided by Advanced Research Computing at the University of Michigan, Ann Arbor.

NANOGrav is part of the International Pulsar Timing Array (IPTA); we would like to thank our IPTA colleagues for their feedback on this paper. We thank members of the IPTA Detection Committee for developing the IPTA Detection Checklist. We thank Bruce Allen for useful feedback. We thank Valentina Di Marco and Eric Thrane for uncovering a bug in the sky scramble code. We thank Jolien Creighton and Leo Stein for helpful conversations about background estimation.

L.B. acknowledges support from the National Science Foundation under award AST-1909933 and from the Research Corporation for Science Advancement under Cottrell Scholar Award No. 27553. P.R.B. is supported by the Science and Technology Facilities Council, grant number ST/W000946/1. S.B. gratefully acknowledges the support of a Sloan Fellowship, and the support of NSF under award \#1815664. The work of R.B., R.C., D.D., N.La., X.S., J.P.S., and J.T. is partly supported by the George and Hannah Bolinger Memorial Fund in the College of Science at Oregon State University. M.C., P.P., and S.R.T. acknowledge support from NSF AST-2007993. M.C. and N.S.P. were supported by the Vanderbilt Initiative in Data Intensive Astrophysics (VIDA) Fellowship. K.Ch., A.D.J., and M.V. acknowledge support from the Caltech and Jet Propulsion Laboratory President's and Director's Research and Development Fund. K.Ch. and A.D.J. acknowledge support from the Sloan Foundation. Support for this work was provided by the NSF through the Grote Reber Fellowship Program administered by Associated Universities, Inc./National Radio Astronomy Observatory. Support for H.T.C. is provided by NASA through the NASA Hubble Fellowship Program grant \#HST-HF2-51453.001 awarded by the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., for NASA, under contract NAS5-26555. K.Cr. is supported by a UBC Four Year Fellowship (6456). M.E.D. acknowledges support from the Naval Research Laboratory by NASA under contract S-15633Y. T.D. and M.T.L. are supported by an NSF Astronomy and Astrophysics Grant (AAG) award number 2009468. E.C.F. is supported by NASA under award number 80GSFC21M0002. G.E.F., S.C.S., and S.J.V. are supported by NSF award PHY-2011772. K.A.G. and S.R.T. acknowledge support from an NSF CAREER award \#2146016. The Flatiron Institute is supported by the Simons Foundation. S.H. is supported by the National Science Foundation Graduate Research Fellowship under Grant No. DGE-1745301. N.La. acknowledges the support from Larry W. Martin and Joyce B. O'Neill Endowed Fellowship in the College of Science at Oregon State University. Part of this research was carried out at the Jet Propulsion Laboratory, California Institute of Technology, under a contract with the National Aeronautics and Space Administration (80NM0018D0004). D.R.L. and M.A.Mc. are supported by NSF \#1458952. M.A.Mc. is supported by NSF \#2009425. C.M.F.M. was supported in part by the National Science Foundation under Grants No. NSF PHY-1748958 and AST-2106552. A.Mi. is supported by the Deutsche Forschungsgemeinschaft under Germany's Excellence Strategy - EXC 2121 Quantum Universe - 390833306. P.N. acknowledges support from the BHI, funded by grants from the John Templeton Foundation and the Gordon and Betty Moore Foundation. The Dunlap Institute is funded by an endowment established by the David Dunlap family and the University of Toronto. K.D.O. was supported in part by NSF Grant No. 2207267. T.T.P. acknowledges support from the Extragalactic Astrophysics Research Group at Eötvös Loránd University, funded by the Eötvös Loránd Research Network (ELKH), which was used during the development of this research. S.M.R. and I.H.S. are CIFAR Fellows. Portions of this work performed at NRL were supported by ONR 6.1 basic research funding. J.D.R. also acknowledges support from start-up funds from Texas Tech University. J.S. is supported by an NSF Astronomy and Astrophysics Postdoctoral Fellowship under award AST-2202388, and acknowledges previous support by the NSF under award 1847938. C.U. acknowledges support from BGU (Kreitman fellowship), and the Council for Higher Education and Israel Academy of Sciences and Humanities (Excellence fellowship). C.A.W. acknowledges support from CIERA, the Adler Planetarium, and the Brinson Foundation through a CIERA-Adler postdoctoral fellowship. O.Y. is supported by the National Science Foundation Graduate Research Fellowship under Grant No. DGE-2139292.

#emph[Dedication.] This paper is dedicated to the memory of Donald Backer: a pioneer in pulsar timing arrays, a term he coined; a discoverer of the first millisecond pulsar; a master developer of pulsar timing instrumentation; a founding member of NANOGrav; and a friend and mentor to many of us.

#[
  #show bibliography: set text(size: 9pt)
  #bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)
]

#counter(heading).update(0)
#pagebreak()
#align(center)[#text(size: 10pt)[APPENDIX]]
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 { numbering("A", n.at(0)) } else { numbering("A.1", n.at(0), n.at(1)) }
}, supplement: [Appendix])

= ADDITIONAL DATA SET DETAILS <app:data_set_details>

The observations included in the NANOGrav 15-year data set were performed between July 2004 and August 2020 with the 305-m Arecibo Observatory (Arecibo), the 100-m Green Bank Telescope (GBT), and, since 2015, the 27 25-m antennae of the Very Large Array (VLA). We used Arecibo to observe the 33 pulsars that lie within its declination range ($0^compose < delta < + 39^compose$); GBT to observe the pulsars that lie outside of Arecibo's range, plus J1713 $+$ 0747 and B1937 $+$ 21, for a total of 36 pulsars; the VLA to observe the seven pulsars J0437 $-$ 4715, J1600 $-$ 3053, J1643 $-$ 1224, J1713+0747, J1903+0327, J1909 $-$ 3744, and B1937 $+$ 21. Six of these were also observed with Arecibo, GBT, or both; J0437 $-$ 4715 was only visible to the VLA. @fig:ang_sep shows the sky locations of the 67 pulsars used for the GWB search (top) and the distribution of angular separations for the pulsar pairs (bottom).

// [figvision-cn] imgs/array_hist.png
// 这是一张阶梯状直方图（曲线图），用于展示脉冲星对的角度
// 间距分布。横轴名称为“angular separation (deg)”，表示角
// 间距，单位为度，范围从 0 到 180，主刻度标注为 0、50、
// 100、150。纵轴名称为“pulsar pairs in bin”，表示每个区
// 间内的脉冲星对数量，范围从 0 到约 350，主刻度标注为 0、
// 100、200、300。图中无网格线，横轴和纵轴主刻度之间均有
// 次刻度。 图中包含三条阶梯状折线，对应右上角的图例说明：
// 橙色实线（图例标注“all”）：代表全数据集。该曲线数值最
// 高，从 0 度附近的约 195 对起步，在 20 到 35 度区间达到
// 最高峰约 325 对，随后随角度增大阶梯式下降，在 165 到
// 180 度区间降至最低约 75 对。 蓝色实线（图例标注“
// Arecibo”）：代表阿雷西博望远镜数据集。在 0 到 20 度区
// 间保持约 100 对，20 到 45 度区间微升至约 105 对，之后
// 随角度增大逐渐下降，在 150 到 165 度区间降至约 30 对，
// 165 到 180 度区间降至约 5 对。 红色虚线（图例标注“GB T
// ”）：代表绿岸望远镜数据集。在 0 到 25 度区间约为 90 对，
// 25 到 45 度区间降至约 60 对，45 到 80 度区间维持在约
// 60 对，此后略有上升至 110 到 130 度区间的约 75 对，在
// 165 到 180 度区间降至约 15 对。 三条曲线在 0 到 30 度
// 区间内走势分化明显，橙色曲线因包含所有组合而最高，红、
// 蓝曲线各自代表单一望远镜数据集，在 0 到 45 度区间形成
// 明显台阶。图中传达的定量趋势是：全数据集的脉冲星对数量
// 显著多于单望远镜数据集；在小于 45 度的较小角间距范围内，
// 阿雷西博与绿岸望远镜的脉冲星对分布存在明显差异（阿雷西
// 博约 100 对，绿岸约 60 对），这对应图注中提到的由于两
// 望远镜观测的脉冲星赤纬不同，导致小角度间距下跨望远镜对
// 数量极少的情况。
#figure(placement: none, [#block[
  #box(
cetz.canvas(length: 0.61cm, {
    import cetz.draw: *

    // ---- Mollweide projection (semi-axes a, b) ----
    let a = 6.64
    let b = 3.34
    let pi = calc.pi
    let d2r = pi / 180
    // solve 2 t + sin(2 t) = pi sin(lat) by Newton iteration
    let newton(t, tgt, k) = {
      if k == 0 { t } else {
        let d = 2 + 2 * calc.cos(2 * t)
        let nt = if calc.abs(d) < 1e-6 { t } else {
          t - (2 * t + calc.sin(2 * t) - tgt) / d
        }
        newton(nt, tgt, k - 1)
      }
    }
    let theta(lat) = {
      if calc.abs(lat) >= 89.99 { pi / 2 * (if lat < 0 {{ -1 }} else {{ 1 }}) } else {
        newton(lat * d2r, pi * calc.sin(lat * d2r), 14)
      }
    }
    let pt(lon, lat) = {
      let t = theta(lat)
      (a * lon * d2r * calc.cos(t) / pi, b * calc.sin(t))
    }
    // marker position from normalised projection coordinates
    let mp(X, Y) = (a * X, b * Y)

    let blu = rgb("#1030c0")
    let red = rgb("#e01010")
    let grn = rgb("#108010")
    let gline = (thickness: 0.7pt, paint: luma(205))

    // ---- graticule: meridians and parallels every 30 deg ----
    for lat in (-60, -30, 0, 30, 60) {
      let pts = ()
      for i in range(73) { pts.push(pt(-180 + i * 5, lat)) }
      line(..pts, stroke: gline)
    }
    for k in range(-5, 6) {
      let l = k * 30
      let pts = ()
      for i in range(61) { pts.push(pt(l, -90 + i * 3)) }
      line(..pts, stroke: gline)
    }
    circle((0, 0), radius: (a, b), fill: none,
      stroke: (thickness: 2pt, paint: black))

    // ---- pulsar markers (positions read from the original figure) ----
    let ablue = (
(-0.916, 0.197),
  (-0.903, 0.281),
  (-0.873, 0.080),
  (-0.868, 0.133),
  (-0.811, 0.357),
  (-0.776, 0.399),
  (-0.705, 0.230),
  (-0.684, 0.081),
  (-0.683, 0.237),
  (-0.635, 0.122),
  (-0.604, 0.288),
  (-0.601, 0.385),
  (-0.586, 0.185),
  (-0.583, 0.045),
  (-0.574, 0.338),
  (-0.571, 0.455),
  (-0.568, 0.125),
  (-0.558, 0.178),
  (-0.472, 0.137),
  (-0.466, 0.047),
  (-0.461, 0.191),
  (-0.430, 0.105),
  (-0.368, 0.300),
  (-0.231, 0.256),
  (-0.100, 0.011),
  (0.134, 0.136),
  (0.403, 0.067),
  (0.491, 0.213),
  (0.566, 0.120),
  (0.598, 0.407),
  (0.953, 0.065),
  (0.957, 0.128),
    )
    let ared = (
(-0.804, -0.106),
  (-0.740, 0.579),
  (-0.694, -0.452),
  (-0.666, -0.182),
  (-0.603, 0.288),
  (-0.603, -0.092),
  (-0.552, -0.161),
  (-0.535, -0.112),
  (-0.512, -0.499),
  (-0.487, -0.279),
  (-0.483, -0.344),
  (-0.468, -0.157),
  (-0.455, -0.298),
  (-0.443, -0.382),
  (-0.430, 0.104),
  (-0.429, -0.202),
  (-0.407, -0.281),
  (-0.403, -0.535),
  (-0.386, -0.172),
  (-0.334, -0.303),
  (-0.322, 0.495),
  (-0.301, -0.412),
  (-0.216, -0.445),
  (0.019, 0.922),
  (0.110, 0.681),
  (0.125, -0.558),
  (0.133, -0.099),
  (0.200, -0.258),
  (0.203, 0.818),
  (0.314, 0.670),
  (0.342, 0.656),
  (0.426, 0.500),
  (0.465, -0.283),
  (0.480, -0.029),
  (0.579, 0.543),
    )
    let agreen = (
  (-0.601, 0.083),
  (-0.565, 0.011),
  (-0.512, -0.500),
  (-0.384, -0.165),
  (-0.300, -0.411),
  (0.482, -0.613),
    )
    for p in ared {
      circle(mp(p.at(0), p.at(1)), radius: 0.13, fill: none,
        stroke: (thickness: 1pt, paint: red))
    }
    for p in ablue {
      circle(mp(p.at(0), p.at(1)), radius: 0.085, fill: blu, stroke: none)
    }
    let cross = (c) => {
      line((c.at(0) - 0.11, c.at(1) - 0.11), (c.at(0) + 0.11, c.at(1) + 0.11),
        stroke: (thickness: 1.6pt, paint: grn))
      line((c.at(0) - 0.11, c.at(1) + 0.11), (c.at(0) + 0.11, c.at(1) - 0.11),
        stroke: (thickness: 1.6pt, paint: grn))
    }
    for p in agreen { cross(mp(p.at(0), p.at(1))) }

    // ---- right-ascension labels on the equator ----
    for e in ((-60, "16h"), (0, "12h"), (60, "8h"), (120, "4h")) {
      let lon = e.at(0)
      content((a * lon * d2r / pi, 0.59), text(size: 16pt)[#(e.at(1))],
        anchor: "center")
    }

    // ---- latitude labels just outside the limb ----
    for k in range(5, -6, step: -1) {
      let L = k * 15
      let t = theta(L)
      let X = -calc.cos(t)
      let Y = calc.sin(t)
      let nx = X / a
      let ny = Y / b
      let nn = calc.sqrt(nx * nx + ny * ny)
      let px = a * X + 0.45 * nx / nn
      let py = b * Y + 0.45 * ny / nn
      let sign = if L < 0 { "-" } else { "" }
      content((px, py), text(size: 16pt)[#sign#calc.abs(L)#sym.degree],
        anchor: "east")
    }

    // ---- legend ----
    rect((4.78, -3.30), (7.72, -1.20), radius: 0.08,
      fill: luma(250), stroke: (thickness: 0.8pt, paint: luma(180)))
    cross((5.17, -1.596))
    circle((5.17, -2.245), radius: 0.085, fill: blu, stroke: none)
    circle((5.17, -2.918), radius: 0.13, fill: none,
      stroke: (thickness: 1pt, paint: red))
    content((6.05, -1.596), text(size: 12.5pt)[VLA], anchor: "west")
    content((6.05, -2.245), text(size: 12.5pt)[Arecibo], anchor: "west")
    content((6.05, -2.918), text(size: 12.5pt)[GBT], anchor: "west")
  })
  ) #box(image("imgs/array_hist.png", width: 100%))

  ]],
  caption: [
    #emph[Top:] Sky locations of the 67 pulsars used in the 15-year GWB analysis. Markers indicate which telescopes observed the pulsar. #emph[Bottom:] Distribution of angular separations probed by the pulsars in the full data set (orange), the Arecibo data set (blue), and the GBT data set (red). Because Arecibo and GBT mostly observed pulsars at different declinations, there are few inter-telescope pairs at small angular separations, resulting in a deficit of pairs for the full data set in the first bin.
  ]
) <fig:ang_sep>

Initial observations were performed with the ASP (Arecibo) and GASP (GBT) systems, with 64-MHz bandwidth #cite(<Demorest2007>). Between 2010 and 2012, we transitioned to the PUPPI (Arecibo) and GUPPI (GBT) systems, with bandwidths up to 800 MHz #cite(<DuPlain2008>)#cite(<Ford2010>). We observe pulsars in two different radio-frequency bands in order to measure pulse dispersion from the interstellar medium: at Arecibo, we use the 1.4 GHz receiver plus either the 430 MHz or 2.1 GHz receiver (and the 327 MHz receiver for early observations of J2317+1439); at GBT, we use the 820 MHz and 1.4 GHz receivers; at the VLA, we use the 1.4 GHz and 3 GHz receivers with the YUPPI system.

In @subsec:cross-validation we analyze also two split-telescope data sets: 33 pulsars for Arecibo, and 35 for GBT (excluding J0614 $-$ 3329, which was observed for less than three years). For the two pulsars timed by both telescopes (J1713 $+$ 0747 and B1937 $+$ 21), we partition the timing data between the telescopes and obtain independent timing solutions for each. We do not analyze a VLA-only data set, which would have shorter observation spans and significantly reduced sensitivity.



= BAYESIAN METHODS & DIAGNOSTICS <sec:bayesapp>

#figure(
  scope: "parent", placement: auto,
  align(center)[#text(size: 8pt, table(
    columns: (auto, 1fr, auto, auto),
    align: (left, left, left, left),
    inset: 2.3pt,
    stroke: 0.4pt,
    table.header([parameter], [description], [prior], [comments]),
    table.cell(colspan: 4, align: center)[#strong[white noise]],
    [$E_k$], [EFAC per backend/receiver system], [Uniform $[0, 10]$], [single-pulsar analysis only],
    [$Q_k$[s]], [EQUAD per backend/receiver system], [log-Uniform $[-8.5, -5]$], [single-pulsar analysis only],
    [$J_k$[s]], [ECORR per backend/receiver system], [log-Uniform $[-8.5, -5]$], [single-pulsar analysis only],
    table.cell(colspan: 4, align: center)[#strong[intrinsic red noise]],
    [$A_("red")$], [red-noise power-law amplitude], [log-Uniform $[-20, -11]$], [one parameter per pulsar],
    [$gamma_("red")$], [red-noise power-law spectral index], [Uniform $[0, 7]$], [one parameter per pulsar],
    table.cell(colspan: 4, align: center)[#strong[all common processes, free spectrum]],
    [$rho_i$[s²]], [power-spectrum coefficients at $f = i \/ T$], [log-Uniform in $rho_i$ $[-18, -8]$], [one parameter per frequency],
    table.cell(colspan: 4, align: center)[#strong[all common processes, power-law spectrum]],
    [$A$], [common process strain amplitude], [log-Uniform $[-18, -14]$ ($gamma = 13 \/ 3$)], [one parameter for PTA],
    [], [], [log-Uniform $[-18, -11]$ ($gamma$ varied)], [one parameter for PTA],
    [$gamma$], [common process power-law spectral index], [delta function ($gamma = 13 \/ 3$)], [fixed],
    [], [], [Uniform $[0, 7]$], [one parameter for PTA],
    table.cell(colspan: 4, align: center)[#strong[all common processes, broken--power-law spectrum]],
    [$A$], [broken--power-law amplitude], [log-Uniform $[-18, -11]$], [one parameter for PTA],
    [$gamma$], [broken--power-law low-freq. spectral index], [Uniform $[0, 7]$], [one parameter per PTA],
    [$delta$], [broken--power-law high-freq. spectral index], [delta function ($delta = 0$)], [fixed],
    [$f_("bend")$[Hz]], [broken--power-law bend frequency], [log-Uniform $[-8.7, -7]$], [one parameter for PTA],
    [$ell$], [broken--power-law high-freq. transition sharpness], [delta function ($ell = 0.1$)], [fixed],
    table.cell(colspan: 4, align: center)[#strong[all common processes, $t$-process spectrum]],
    [$A$], [power-law amplitude], [log-Uniform $[-18, -11]$], [one parameter for PTA],
    [$gamma$], [power-law spectral index], [Uniform $[0, 7]$], [one parameter per PTA],
    [$x_i$], [modification factor], [Inverse Gamma Distribution], [one parameter per frequency],
    table.cell(colspan: 4, align: center)[#strong[all common processes, turnover spectrum]],
    [$A$], [turnover power-law amplitude], [log-Uniform $[-18, -11]$], [one parameter for PTA],
    [$gamma$], [turnover power-law high-freq. spectral index], [Uniform $[0, 7]$], [one parameter per PTA],
    [$kappa$], [turnover power-law low-freq. spectral index], [Uniform $[0, 7]$], [one parameter per PTA],
    [$f_0$[Hz]], [turnover power-law bend frequency], [log-Uniform $[-9, -7]$], [one parameter for PTA],
    table.cell(colspan: 4, align: center)[#strong[all common processes, cross-correlation spline model]],
    [$y$], [normalized cross-correlation values at spline], [Uniform $[-0.9, 0.9]$], [seven parameters for PTA],
    [], [knots $(10^(- 3), 25, 49.3, 82.5, 121.8, 150, 180)$ degrees], [], [],
  ))],
  caption: [Prior distributions used in all analyses performed in this paper.],
  kind: table,
  supplement: [Table],
) <tab:priors>

The prior probability distributions assumed for all analyses in this paper are listed in @tab:priors. We use Markov chain Monte Carlo (MCMC) techniques to sample randomly from the joint posterior distribution of our model parameters. Marginal distributions are obtained simply by considering only the parameter of interest in each sample. To assess convergence of our MCMC runs beyond visual inspection we use the Gelman--Rubin statistic, requiring $hat(R) < 1.01$ for all parameters #cite(<gelmanrubin1992>)#cite(<vgs21>). We performed most runs discussed in this paper with the `PTMCMC` sampler #cite(<ptmcmc>) and postprocessed samples with `chainconsumer` #cite(<Hinton2016>).

In NG12gwb we use an analytic approximation for the uncertainty of marginalized-posterior statistics #cite(<wilcox2012introduction>). Here we instead adopt a boostrap approach: we resample the original MCMC samples (with replacement) to generate new sets that act as independent sampling realizations. We then calculate the distributions of the desired summary statistics (e.g., quantiles, marginalized posterior values) over these sets. From these distributions, we determine central values and uncertainties (either medians and $68 "%"$ confidence intervals, or means and standard deviations).

We rely on a variety of techniques to perform Bayesian model comparison. The first is thermodynamic integration #cite(<ogata1989monte>)#cite(<gelman1998simulating>), which computes Bayesian evidence integrals directly through parallel tempering: we run $N_beta$ MCMC chains that explore variants of the likelihood function raised to different exponents $beta$, then approximate the evidence for model $cal(H)$ as

$
  ln p ( d | cal(H) ) = integral_0^1 chevron.l ln p ( d | theta ) chevron.r_beta thin thin upright(d) beta \
  approx 1 \/ N_beta sum_beta chevron.l ln p ( d | theta ) chevron.r_beta
$

where all likelihoods and posteriors are computed within model $cal(H)$, $theta$ denotes all of the model's parameters, and the expectation $chevron.l ln p ( d | theta ) chevron.r_beta$ is approximated by MCMC with respect to the posterior $p_beta ( theta | d ) prop p ( d | theta cal(H) )^beta p ( theta cal(H) )$. The inverse temperatures $beta$ are spaced geometrically, as is the default in `PTMCMC`.

To compare nested models, which differ by "freezing" a subset of parameters, we also use the Savage--Dickey density ratio#cite(<dickey1971>) if models $cal(H)$ and $cal(H)_0$ differ by the fact that (say) $theta_0$ is frozen to 0 in the latter, then $p ( d | cal(H)_0 ) \/ p ( d | cal(H) ) = p ( theta_0 = 0 | d cal(H) ) \/ p ( theta_0 = 0 | cal(H) )$.

When comparing #emph[disjoint] models with different likelihoods (e.g., #smallcaps[hd]~versus #smallcaps[curn]), we use product-space sampling #cite(<cc95>)#cite(<g01>). This method treats model comparison as a parameter estimation problem, where we sample the union of the unique parameters of all models, plus a model-indexing parameter that activates the relevant likelihood function and parameter space of one of the sub-models. Bayes factors are then obtained by counting how often the model index falls in each activation region and taking ratios of those counts.

In some situations, it can be difficult to sample a computationally expensive model directly. In these cases, we sample a computationally cheaper approximate distribution and reweight those posterior samples to estimate the posterior for the computationally expensive model#cite(<HourihaneMeyers2022>). The reweighted posterior can be used in the thermodynamic-integration or Savage--Dickey methods. In addition, the mean of the weights yields the Bayes factor between the expensive and approximate models, which may be of direct interest (e.g., #smallcaps[hd]~can be approximated by #smallcaps[curn]). We estimate Bayes-factor uncertainties using bootstrapping and, for product-space sampling, with the Markov-model techniques of #cite(<cornish2015bayeswave>) and #cite(<heck2019quantifying>).

= BROKEN POWER-LAW MODEL <sec:appbroken>

As shown in NG12gwb, the simultaneous Bayesian estimation of white measurement noise and of red-noise processes described by power laws biases the recovery of the spectral index of the latter #cite(<lcc-2017>)#cite(<Hazboun:2019vhv>). Just as in NG12gwb and #cite(<2022MNRAS.510.4873A>, form: "prose"), we impose a high-frequency cutoff on the red-noise processes. To choose the cutoff frequency, we perform inference on our data with a #smallcaps[curn]#super[$gamma$]~model modified so that the common process has power spectral density

$
  S(f) = frac(A^2, 12 pi^2) (f \/ f_("ref"))^(- gamma) [1 + (f \/ f_("break"))^(1 \/ ell)]^(ell gamma) thin f_("ref")^(- 3) ,
$ <eq:brokenpl>
then set the cutoff to the MAP $f_("rm" "break")$. @eq:brokenpl is fairly generic, allowing for separate spectral indices at low ($gamma$) and high ($delta$) frequencies. The break frequency $f_("rm" "break")$ dictates where the broken power law changes spectral index, while $ell$ (which we set to 0.1) controls the smoothness of the transition.

The marginal posterior for $f_("break")$, obtained in the factorized-likelihood approximation using the techniques of #cite(<2023arXiv230315442L>, form: "prose"), has median and $90 "%"$ credible region of $3.2_(- 1.2)^(+ 5.4) times 10^(- 8)$~Hz, and a MAP value of $2.75 times 10^(- 8)$ Hz. The latter is close to $f_14 = 14 \/ T$ in our frequency basis (with $T$ the total span of the data set), so we use 14 frequencies to model common-spectrum noise processes (see @sec:data and NG12gwb).

= T-PROCESS SPECTRUM MODEL <sec:apptprocess>

// [figvision-cn] imgs/nano15_14f_cornerplot_plaw_tprocess.png
// 该图由三个子图组成，整体是一个联合后验分布三角图。 子
// 图 a（左上角）：一维边缘后验分布曲线图。横轴与下方子图
// 共享，表示谱指数 γ，范围约 1.5 至 6.5，无单位。纵轴未
// 标注刻度，表示概率密度。图中包含两条曲线：蓝色实线对应
// CURN^γ power law，呈单峰分布，峰值位于 γ 约为 3.7 处，
// 分布较窄；橙色实线对应 CURN^TTS modified power law，分
// 布更宽，峰值位于 γ 约为 3.5 处，且向高 γ 方向有拖尾。
// 子图 b（左下角）：二维联合后验等高线图。横轴为 γ，范围
// 1.5 至 6.5，刻度标注为 1.5, 3.0, 4.5, 6.0。纵轴为
// log_10 A，范围 -15.5 至 -14.0，刻度标注为 -15.5, -15.0
// , -14.5, -14.0。图中绘制了两组等高线：蓝色等高线对应
// CURN^γ power law，呈较窄的椭圆状，中心位于 γ 约 3.8、
// log_10 A 约 -14.3 处；橙色等高线对应 CURN^TTS modified
// power law，呈更宽、更长的椭圆状，从 γ 约 2.5、log_10 A
// 约 -14.6 延伸至 γ 约 5.0、log_10 A 约 -14.2。图中有两
// 条虚线：一条竖直虚线位于 γ 约 4.3 处，另一条斜虚线穿过
// 等高线区域，斜率为负，表示 A 与 γ 之间的负相关趋势。图
// 内左下角有文字标注：蓝色文字为 "CURN^γ power law"，橙
// 色文字为 "CURN^TTS modified power law"。 子图 c（右侧）：
// 一维边缘后验分布曲线图。纵轴与子图 b 共享，表示 log_10
// A，范围 -15.5 至 -14.0。横轴未标注刻度，表示概率密度。
// 图中包含两条曲线：蓝色实线对应 CURN^γ power law，呈单
// 峰分布，峰值位于 log_10 A 约 -14.2 处；橙色实线对应
// CURN^TTS modified power law，分布更宽，峰值位于 log_10
// A 约 -14.4 处，且向低 log_10 A 方向有拖尾。
// [figvision-cn] imgs/nano15_14f_cornerplot_plaw_tprocess.png
// 该图由三个子图组成，整体是一个联合后验分布三角图。 子
// 图 a（左上角）：一维边缘后验分布曲线图。横轴与下方子图
// 共享，表示谱指数 γ，范围约 1.5 至 6.5，无单位。纵轴未
// 标注刻度，表示概率密度。图中包含两条曲线：蓝色实线对应
// CURN^γ power law，呈单峰分布，峰值位于 γ 约为 3.7 处，
// 分布较窄；橙色实线对应 CURN^TTS modified power law，分
// 布更宽，峰值位于 γ 约为 3.5 处，且向高 γ 方向有拖尾。
// 子图 b（左下角）：二维联合后验等高线图。横轴为 γ，范围
// 1.5 至 6.5，刻度标注为 1.5, 3.0, 4.5, 6.0。纵轴为
// log_10 A，范围 -15.5 至 -14.0，刻度标注为 -15.5, -15.0
// , -14.5, -14.0。图中绘制了两组等高线：蓝色等高线对应
// CURN^γ power law，呈较窄的椭圆状，中心位于 γ 约 3.8、
// log_10 A 约 -14.3 处；橙色等高线对应 CURN^TTS modified
// power law，呈更宽、更长的椭圆状，从 γ 约 2.5、log_10 A
// 约 -14.6 延伸至 γ 约 5.0、log_10 A 约 -14.2。图中有两
// 条虚线：一条竖直虚线位于 γ 约 4.3 处，另一条斜虚线穿过
// 等高线区域，斜率为负，表示 A 与 γ 之间的负相关趋势。图
// 内左下角有文字标注：蓝色文字为 "CURN^γ power law"，橙
// 色文字为 "CURN^TTS modified power law"。 子图 c（右侧）：
// 一维边缘后验分布曲线图。纵轴与子图 b 共享，表示 log_10
// A，范围 -15.5 至 -14.0。横轴未标注刻度，表示概率密度。
// 图中包含两条曲线：蓝色实线对应 CURN^γ power law，呈单
// 峰分布，峰值位于 log_10 A 约 -14.2 处；橙色实线对应
// CURN^TTS modified power law，分布更宽，峰值位于 log_10
// A 约 -14.4 处，且向低 log_10 A 方向有拖尾。
#figure(scope: "parent", placement: auto, 
  grid(
    columns: (1fr, 1fr),
    align: horizon,
    gutter: 1em,
    image("imgs/nano15_cp_freespec_plaw_tprocess.png", width: 100%),
    image("imgs/nano15_14f_cornerplot_plaw_tprocess.png", width: 100%),
  ),
  caption: [
    Power-law (#smallcaps[curn]#super[$gamma$], blue) and $t$-process power-law (#smallcaps[curn]#super[$("TPS")$], orange) spectral posteriors. #strong[Left]: reconstructed spectra, compared to free-spectral bin-variance posteriors (#smallcaps[curn]#super[$("TPS")$], violin plots). #strong[Right]: joint $( log_10 A gamma )$ posteriors. The "fuzzy" $t$-process allows local deviations from a perfect power law, producing wider constraints that are more consistent with $gamma = 13 \/ 3$ (dashed line).
  ]
) <fig:tps>

The free-spectrum analysis of our data (@subsec:spectral and @fig:periodogram) shows that the frequency bins at $f_1$, $f_6$, $f_7$, and $f_8$ appear to be in tension with a pure power law, skewing the estimation of $gamma$ and reducing the #smallcaps[hd]#super[$(13 \/ 3)$]~vs.~#smallcaps[curn]#super[$(13 \/ 3)$]~Bayes factor. Assuming that those frequency components reflect unmodeled systematics or stronger-than-expected statistical fluctuations, we can make our inference more robust to such outliers with a "fuzzy" power-law model that allows the individual $Phi_i$ to vary more freely around their expected values. To wit, we introduce the $t$-process spectrum (TPS)

$
  Phi_("TPS" i) = x_i Phi_("powerlaw" i) quad "with" quad x tilde "invgamma" ( x_i 1, 1 )
$

where $Phi_("powerlaw" i)$ follows @eq:powerlaw and $x$ follows the inverse gamma distribution with parameters $alpha = beta = 1$; the resulting Gaussian mixture yields a Student's-$t$ distribution for the $Phi_("TPS" i)$. @fig:tps shows #smallcaps[curn]#super[$gamma$]~power-law posteriors and #smallcaps[curn]#super[$("TPS")$]~modified power-law posteriors, obtained in the factorized-likelihood approximation #cite(<2023arXiv230315442L>) and compared to #smallcaps[curn]#super[$("free")$]~bin variances. The TPS model is spread more widely and deviates from the perfect power law at bins $f_1$, $f_6$, $f_7$, and $f_8$, as expected. The right panel of @fig:tps shows the joint $log_10 A gamma$ posteriors for #smallcaps[curn]#super[$gamma$]~and #smallcaps[curn]#super[$("TPS")$]. The latter is more consistent with steeper power laws, and it includes $gamma = 13 \/ 3$ at $1 sigma$ credibility.

= TURNOVER MODEL <sec:appturnover>

The final parameterized spectral model that we investigate is motivated by the idea that the dynamics of SMBHBs are influenced by their environments at sub-parsec separations #cite(<2002ApJ...567L...9A>)#cite(<shm-04>)#cite(<mm05>). These interactions affect binary evolution and the resulting spectrum of the GWB. The process of bringing two SMBHs together after galaxy mergers involves a complex chain of interactions: despite significant theoretical work, the lack of observational constraints makes it difficult to draw any conclusions. PTAs, however, provide a unique opportunity to probe the timescale over which two SMBHs evolve from the merger of their galaxies to a bound binary that produces GW signals in the PTA sensitivity band.

When dynamical interactions dominate orbital evolution, binaries will traverse the GW spectrum more quickly, reducing GW emission compared to a GW-driven inspiral. This kind of behavior is captured by the #emph[turnover model] #cite(<scm2015>):

$
  S ( f ) = frac(A^2, 12 pi^2) (f \/ f_("ref"))^(- gamma) [1 + (f_0 \/ f)^kappa]^(- 1) thin thin f_("ref")^(- 3) .
$

This is qualitatively similar to the broken power law discussed earlier, except that here $f_0$ represents the GW frequency at which typical binary evolution transitions from environmentally dominated (at lower frequencies and wider separations) to GW-dominated (at higher frequencies and smaller separations). The parameter $kappa$ controls the shape of the spectrum below $f_0$, and depends on the orbital-evolution mechanism. Note that the actual turning point of the spectrum is not at $f_0$ but at $f_("bend") = f_0 times ( 3 kappa \/ 4 - 1 )^(1 \/ kappa)$ #cite(<abb-16>, supplement: [NG9gwb]).

Applying this model to our data, we find hints of departures from a pure power law: the transition frequency $f_0$ lies below $10$~nHz with $65 "%"$ credibility, while the bend frequency lies below $10$~nHz with $75 %$ credibility. Nevertheless, Bayesian comparison of this #smallcaps[curn]#super[$("turnover")$]~model with #smallcaps[curn]#super[$gamma$]~reports an inconclusive Bayes factor of $1.46 plus.minus 0.02$ in favor of #smallcaps[curn]#super[$("turnover")$]. Furthermore, the estimation of #smallcaps[curn]#super[$("turnover")$]~parameters is sensitive to DM modeling (see @subsec:dm_models). While the spectra are broadly consistent whether we use DMX or DMGP to model DM fluctuations, there are differences in the power at certain frequencies that lead to differences in the turnover parameters. This is discussed in greater detail in #cite(<aaa-23_smbhb>, form: "prose").

= SKY SCRAMBLES <sec:appskyscrambles>

// [figvision-cn] imgs/fap_plots_logscale_cdf_sscramble.png
// 本图由左右两个并排的子图组成，均为基于 5000 次“天空随
// 机化”（Sky scrambles）得到的经验背景分布累积分布函数（
// 1-CDF）阶梯曲线图。两图均为半对数坐标（纵轴为对数刻度），
// 蓝色阶梯线代表天空随机化样本的分布，灰色虚线表示高斯等
// 效显著性阈值，黑色竖直虚线标示检测值。 左图：坐标轴为
// 横轴 log10 B^HD_CURN（HD 到 CURN 的贝叶斯因子对数值），
// 范围约 -5 至 4；纵轴为 1-CDF（生存函数），对数刻度从
// 10^-5 至 10^0。蓝色阶梯曲线从左侧约 0 dB 处开始，随着
// 横轴数值增大而单调下降，在 log10 B 约为 2.2 处降至约
// 10^-3。灰色水平虚线分别对应 1-CDF 为 2σ（约 2.3×10^-2）、
// 3σ（约 1.3×10^-3）、4σ（约 3.2×10^-5）的高斯等效阈值，
// 图中右侧标注有“2σ”“3σ”“4σ”。黑色竖直虚线位于 log10 B
// 约 2.2 处，对应检测值。图例为带方框的“Sky scrambles”。
// 右图：坐标轴为横轴 Noise-Marginalized Mean S/N（噪声边
// 缘化平均信噪比），范围约 -3 至 6.5；纵轴同左图为 1-CDF，
// 对数刻度同样从 10^-5 至 10^0。蓝色阶梯曲线同样单调下降，
// 在横轴约 4.4 处降至 10^-4 以下。灰色水平虚线同样表示 2
// σ、3σ、4σ 阈值，右侧标注有“2σ”“3σ”“4σ”。黑色竖直虚线位
// 于横轴约 4.4 处，对应检测值。图例同为“Sky scrambles”。
// 两图共同传达的趋势是：实际检测到的信号值（黑色竖直虚线）
// 显著偏离天空随机化背景分布，对应显著性水平高于 3σ，接
// 近或超过 4σ 阈值。
#figure(scope: "parent", placement: auto, [#block[
  #box(image("imgs/fap_plots_logscale_cdf_sscramble.png", width: 90.0%))
  ]],
  caption: [
    Empirical background distribution of #smallcaps[hd]#super[$gamma$]-to-#smallcaps[curn]#super[$gamma$]~Bayes factor (left, see @sec:bayes) and noise-marginalized optimal statistic (right, see @sec:optimal), as computed in 5,000 sky scrambles, which erases the dependence of inter-pulsar correlations on the angular separation between the pulsars. Dotted lines indicate Gaussian-equivalent 2 $sigma$, 3 $sigma$, and 4 $sigma$ thresholds. The dashed vertical lines indicate the values of the detection statistics for the unscrambled data set. We find $p = 1.6 times 10^(- 3)$ (approx.~$3 sigma$) for the Bayesian analysis, and $p < 10^(- 4)$ ($> 3 sigma$) for the optimal-statistic analysis.
  ]
) <fig:skyscrambles>

In the sky-scramble method #cite(<cs16>), inter-pulsar correlations are analyzed as if the pulsars occupied random sky positions, with the purpose of creating a background distribution of PTA detection statistics for null-hypothesis testing, in alternative to phase shifts (#cite(<tlb-17>, form: "prose"); see @sec:bayes and @sec:optimal). If a correlated signal is present in the data, phase shifts and sky scrambles actually test #emph[different] null hypotheses: phase shifts test the hypothesis that no inter-pulsar correlations are present, while sky scrambles assume that inter-pulsar correlations are present at the level measured in the data, but test the hypothesis that these correlations have no dependence on angular separation.

As is the convention in the literature, we require that scrambled overlap reduction functions (ORFs) be independent of each other and of the unscrambled ORF using a match statistic,

$
  macron(M) = frac(sum_(a b eq.not a) Gamma_(a b) Gamma'_(a b), sqrt((sum_(a b eq.not a) Gamma_(a b) Gamma_(a b)) (sum_(a b eq.not a) Gamma'_(a b) Gamma'_(a b)))) ,
$ <eq:match>

where $Gamma_(a b)$ and $Gamma'_(a b)$ are two different ORFs. For the sky scrambles used in our analysis, the scrambled ORFs have $macron(M) < 0.1$ with respect to the unscrambled ORF, and $macron(M) < 0.17$ with each other. We generate 10,000 sky scrambles, owing to the difficulty in obtaining large numbers of scrambled ORFs that satisfy the match threshold; because of limitations of computational resources, we obtain our detection statistics for 5,000 of those ORFs. @fig:skyscrambles shows the resulting background distributions for the #smallcaps[hd]#super[$gamma$]-to-#smallcaps[curn]#super[$gamma$]~Bayes factor (left panel) and the optimal-statistic S/N (right panel). The Bayes factors exceed the observed value in eight of the 5,000 sky scrambles ($p = 1.6 times 10^(- 3)$), while none of the sky scrambles have noise-marginalized mean S/N greater than observed ($p < 10^(- 4)$).


// [figvision-cn] imgs/fap_plots_logscale_cdf_sscramble_match.png
// 该图为单幅阶梯状曲线图，无子图划分。横轴为“
// Noise-Marginalized Mean S/N”（噪声边际化平均信噪比），
// 采用线性坐标，显示范围约为−3至6.5，刻度标注为−2、0、2、
// 4、6；纵轴为“PDF”（概率密度函数），采用对数坐标，显示
// 范围从约2×10⁻⁵到1，刻度标注为10⁻⁴、10⁻³、10⁻²、10⁻¹、
// 10⁰。图中包含三条阶梯状实线，分别对应不同匹配阈值下的
// 经验背景分布：蓝色线（图例标注为M̃ < 0.17）、橙色线（
// 图例标注为M̃ < 0.1）、绿色线（图例标注为M̃ < 0.08），
// 图例位于图中左下方区域。三条水平灰色虚线表示高斯等效阈
// 值：2σ（对应纵轴约1.7×10⁻²）、3σ（对应纵轴约1.35×10⁻³）、
// 4σ（对应纵轴约3.2×10⁻⁵），右侧标注有“2σ”“3σ”“4σ”文本。
// 一条垂直灰色虚线位于横轴约5.0处，代表未进行 scramble
// 处理的数据的检测统计量值。所有曲线在低信噪比区（约≤1）
// 几乎重合且接近PDF=1，随信噪比增大呈现阶梯下降；绿色曲
// 线最先在横轴约3.6处截断降至坐标下界，橙色曲线在约4.2处
// 截断，蓝色曲线延伸至约4.8处。该图传达的趋势是：在较低
// 匹配阈值下，背景分布向高信噪比方向延伸更远，且检测统计
// 量（垂直虚线，约5.0）位于所有背景分布（包括4σ阈值）之
// 外，表明信号显著。
#figure(placement: auto, [#block[
  #box(image("imgs/fap_plots_logscale_cdf_sscramble_match.png", width: 100%))
  ]],
  caption: [
    Comparison between empirical background distributions for the noise-marginalized optimal statistic, as computed by the sky-scramble technique. We show distributions computed using a match threshold of $macron(M) < 0.17$ (blue), $macron(M) < 0.1$ (orange), and $macron(M) < 0.08$ (green). Dotted lines indicate Gaussian-equivalent 2 $sigma$, 3 $sigma$, and 4 $sigma$ thresholds. The dashed vertical lines indicate the values of the detection statistics for the unscrambled data set. We find little difference between the background distributions computed using different match thresholds, modulo the fact that imposing a smaller threshold yields fewer sky scrambles, which limits the precision to which the $p$-value can be measured.
  ]
) <fig:skyscrambles_match>

We note that the null distribution recovered by the sky scrambles is not very sensitive to the choice of match threshold for $| macron(M) | lt.tilde 0.2$. @fig:skyscrambles_match compares the null distributions when the match threshold for all ORFs with each other and with the unscrambled ORF is set to $| macron(M) | < 0.17$ (blue), $| macron(M) | < 0.1$ (orange), and $| macron(M) | < 0.08$ (green). There is very little difference among the distributions; however, imposing a smaller threshold means that fewer sky scrambles can be used (6,043 with $| macron(M) | < 0.1$ and 1,534 with $| macron(M) | < 0.08$, compared to 10,000 with $| macron(M) | < 0.17$), which limits the precision with which the $p$-value can be measured. We find no evidence that the recovered null distribution is biased when including sky scrambles with matches up to 0.17.

= MULTIPLE-CORRELATION OPTIMAL STATISTIC <sec:appmcos>

#figure(
  scope: "parent", placement: auto,
  align(center)[#table(
    columns: 8,
    align: (left,center,center,center,center,center,center,center),
    stroke: 0.5pt,
    [], table.cell(align: center, colspan: 2)[HD Correlations], table.cell(align: center, colspan: 2)[Monopole Correlations], table.cell(align: center, colspan: 2)[Dipole Correlations], [],
    [Model], [$hat(A)_("HD")^2$], [S/N], [$hat(A)_("mo")^2$], [S/N], [Mean $hat(A)_("di")^2$], [S/N], [$p ( "AIC" )$],
    table.hline(),
    [HD only], [$6.8 ( 9 ) times 10^(- 30)$], [4(1)], [--], [--], [--], [--], [$3 times 10^(- 2)$],
    [Monopole only], [--], [--], [$1.1 ( 1 ) times 10^(- 30)$], [$4 ( 1 )$], [--], [--], [$6 times 10^(- 3)$],
    [Dipole only], [--], [--], [--], [--], [$1.5 ( 3 ) times 10^(- 30)$], [4(1)], [$8 times 10^(- 4)$],
    [HD + monopole], [$5.5 ( 8 ) times 10^(- 30)$], [3.4(8)], [$8 ( 1 ) times 10^(- 31)$], [2.9(8)], [--], [--], [1],
    [HD + dipole], [$5.5 ( 8 ) times 10^(- 30)$], [3.2(7)], [--], [--], [$8 ( 2 ) times 10^(- 31)$], [1.7(7)], [$6 times 10^(- 2)$],
    [monopole + dipole], [--], [--], [$8 ( 1 ) times 10^(- 31)$], [2.7(7)], [$9 ( 2 ) times 10^(- 31)$], [1.9(6)], [$1 times 10^(- 2)$],
    [HD + monopole + dipole], [$5.1 ( 8 ) times 10^(- 30)$], [2.9(6)], [$7 ( 1 ) times 10^(- 31)$], [2.4(6)], [$3 ( 2 ) times 10^(- 31)$], [0.6(4)], [0.48],
  )],
  caption: [
    Multiple-correlation optimal statistic best-fit coefficients $hat(A)_k^2$, S/Ns, and AIC probabilities. All values were computed for the 15-year data set, assuming a power-law power spectral density using the 14 lowest frequency components. Here $hat(A)^2$, S/N, and AIC are marginalized over pulsar noise parameters with fixed $gamma = 13 \/ 3$. The numbers in parentheses represent the mean least-squares errors for the $hat(A)_k^2$ coefficients and standard deviations over noise-parameter posteriors for S/Ns. We compute $p ( "AIC" )$ with respect to the model with the lowest mean AIC (i.e., HD + monopole).
  ],
  kind: table,
  supplement: [Table],
) <tab:mc_optstat>



The multiple-correlation optimal statistic (MCOS; #cite(<sv2023>, style: "aas_noparen.csl")) fits the inter-pulsar correlation coefficients $rho_(a b)$ with a linear model that includes multiple components with different correlation patterns, but with the same spectral shape. The linear-model coefficients are the squared amplitudes of the components. Within such a model, the significance of each component can be quoted as a S/N given by its best-fit coefficient divided by the fit error. Just as for the noise-marginalized optimal statistic #cite(<vite18>), the posterior distribution of pulsar noise parameters induces a distribution of MCOS statistics.

We fit the 15-year data with models that include HD, monopole, and dipole-correlated components in various combinations. @tab:mc_optstat lists the noise-marginalized amplitude estimates and S/N for all models. The goodness-of-fit of the models can be compared using the Akaike Information Criterion (AIC; #cite(<Akaike1998>, style: "aas_noparen.csl")):

$
  "AIC" = 2 k + chi^2 thin
$<eq:AIC>

where $k$ is the number of model parameters and $chi^2$ is the fit's chi-squared, computed without accounting for GW-induced $rho_(a b)$ correlations. (This can be thought of as a pseudo-Bayes factor, with the factor of $2 k$ imposing an Occam penalty.) The relative probability of a model compared to the most-favored model is then given by

$
  p ("AIC") = exp [(upright(A I C_(m i n)) - "AIC") \/ 2]
$<eq:AIC-comparison>

where $upright(A I C_(m i n))$ is the minimum AIC across all models.

@tab:mc_optstat lists the AIC probabilities, computed by averaging the AIC of each model over pulsar noise parameters. The HD-correlated model is preferred among the models with a single correlated process. The models with both HD and monopole correlations are preferred among all models: for a model with HD and monopole correlations, we find S/N of $3.4 plus.minus 0.8$ for HD correlations and $2.9 plus.minus 0.8$ for monopolar correlations, while for a model with HD, monopole, and dipole correlations, we find S/N of $2.9 plus.minus 0.6$ for HD correlations, $2.4 plus.minus 0.6$ for monopole correlations, and $0.6 plus.minus 0.4$ for dipole correlations (means $plus.minus$ standard deviations across noise-parameter posteriors). The statistical significance of these S/Ns can be quantified empirically using simulations of 15-year--like data sets (see App. #ref(<sec:appastrosims>, supplement: none)), which report $p$-values $< 10^(- 2)$ and $tilde.eq 4 times 10^(- 2)$ for the observed mean HD and monopole statistics across data replications with no spatially correlated injections.



As discussed in #cite(<sv2023>, form: "prose"), the optimal statistic and the MCOS are metrics of the #emph[apparent] spatial correlation pattern of the data, but they have a limited ability to identify its actual source. That is because a real HD signal may also excite the monopole optimal statistic and the monopole component of the MCOS; conversely, a real monopolar signal may also excite the HD optimal statistic and the HD component of the MCOS; and so on. The S/Ns quoted in @tab:mc_optstat quantify how often we would expect to measure the observed value of the optimal statistic if only uncorrelated noise is present, but they do not describe how often one type of correlated noise would produce a given value of the optimal statistic for a different type of correlation. This effect can be characterized using simulations (see App. #ref(<sec:appastrosims>, supplement: none)), which report a $p$-value of $0.11$ for the observed mean monopole statistic when a HD-correlated signal with the MAP 15-year amplitude is included in the simulated data sets. We conclude that there are some indications of a possible monopole-correlated signal in the data with S/N comparable to but smaller than the S/N for HD correlations; however, from simulations we conclude that it is possible for such a signal to appear in an MCOS analysis if only a HD-correlated stochastic process is present.

// [figvision-cn] imgs/optstat_mc.png
// 该图由上下排列的两个子图组成，共用脉冲星夹角作为横轴物
// 理量。 子图 a（上方）：类型为阶梯状概率密度直方图。横
// 轴为信噪比 S/N，范围 0 至 7，主刻度间隔为 2。纵轴为概
// 率密度函数 PDF，范围 0.0 至 0.6，主刻度间隔为 0.2。图
// 例包含两项：蓝色实线阶梯表示 HD 相关性，橙色虚线阶梯表
// 示单极子相关性。图中两条竖直实线分别标示两种分布的均值：
// 蓝色竖线位于 S/N 约 3.4 处，橙色竖线位于 S/N 约 2.8 处。
// 蓝色分布的峰值在 S/N 约 3.3 至 3.5，橙色分布的峰值在 S
// /N 约 2.4 至 2.8。右下角标注文字为“γ = 13/3”。该子图传
// 达的结论是：HD 相关性被探测到的信噪比高于单极子相关性，
// 且两者均显著偏离零。 子图 b（下方）：类型为带误差棒的
// 散点与平滑曲线拟合图。横轴为脉冲星之间的分离角 ξ，单位
// 为度，范围 0 至 180，主刻度间隔为 30。纵轴为交叉相关量
// Â²Γ(ξ_ab)，单位为 10⁻³⁰，范围 -2.0 至 4.0，主刻度间隔
// 为 1.0。图中有黑色圆点表示分箱后的交叉相关数据点，每个
// 点带有竖直误差棒，误差棒范围约 ±0.8 至 ±1.2（以 10⁻³⁰
// 为单位）。数据点分布为：ξ=0° 处约 3.4，30° 处约 2.8，
// 45° 处约 2.3，60° 处约 0.8，75° 处约 0.0，90° 处约
// -0.5，105° 处约 -0.3，120° 处约 1.0，150° 处约 1.6。蓝
// 色实线表示仅 HD 相关性的理论曲线，从 0° 处约 3.5 开始
// 下降，在 90° 附近达到最小值约 -1.0，然后上升至 180° 处
// 约 1.7。橙色虚线表示 HD 加单极子相关性的理论曲线，从 0
// ° 处约 3.5 开始下降，在 75° 至 90° 之间达到最小值约
// 0.0，然后上升至 180° 处约 2.3。右下角标注文字为“γ = 13
// /3”。该子图传达的结论是：包含 HD 和单极子相关性的模型
// （橙色虚线）比仅包含 HD 相关性的模型（蓝色实线）更符合
// 分箱数据点，尤其是在 90° 至 180° 区间。
#figure(placement: none, [#block[
  #box(image("imgs/optstat_mc.png", width: 88%))
  ]],
  caption: [#text(size: 8.5pt)[
    Results of the MCOS analysis, which prefers a model including both HD and monopole correlations. #strong[Top]: MCOS S/N for HD correlations (solid blue) and monopole correlations (dashed orange), marginalized over #smallcaps[curn]#super[$(13 \/ 3)$]~noise-parameter posteriors. The vertical lines indicate the mean S/Ns. We find a S/N of $3.4 plus.minus 0.8$ for HD correlations and $2.9 plus.minus 0.8$ for monopole correlations. #strong[Bottom]: Binned cross-correlations $rho_(a b)$ (black error bars), computed with MAP noise parameters from a #smallcaps[curn]#super[$(13 \/ 3)$]~run. The solid blue and dashed orange curves show best-fit HD and HD+monopole correlation patterns, corresponding to $hat(A)^2 = 6.8 times 10^(- 30)$ and to $hat(A)_("HD")^2 = 5.5 times 10^(- 30)$, $hat(A)_("monopole")^2 = 8 times 10^(- 31)$, respectively. The monopolar component accounts for the vertical shift of the cross-correlations with respect to the HD curve. We use the standard version of the optimal statistic that does not include inter-pulsar correlations to compute $rho_(a b)$, so the points and errors do not match those shown in panel (c) of @fig:spectrum_correlations_plot
  ]]
) <fig:mcos_corr>

= MULTIPLE-CORRELATION OPTIMAL STATISTIC SIMULATIONS <multiple-correlation-optimal-statistic-simulations>

In this appendix we obtain the distribution of the MCOS over an ensemble of simulated data sets, with the goal of characterizing the probability that the observed S/Ns could have been produced by pulsar noise alone, or by a GWB with HD correlations. Unlike our Bayesian analysis, the MCOS prefers a model that includes both HD and monopolar components. So we are especially interested in asking how frequently we may expect the observed MCOS monopole if the data contain only the GWB. In Apps. H.1 and H.2 we present two different types of simulations: "astrophysical," where we generate synthetic data with MAP noise parameters inferred from the 15-year data set, both with and without the GWB; and "model checking," where we create data replications following the #smallcaps[hd]#super[$(13 \/ 3)$]~posteriors for the real data set. Note that neither simulation attempts to account for the monochromatic character of the putative monopolar signal (see @subsec:spectral).

== Astrophysical simulations <sec:appastrosims>

// [figvision-cn] imgs/a4c_sims_cc.png
// 该图由上下两个子图组成，均为阶梯状直方图（概率密度函数
// 图）。两个子图的纵轴均为 PDF（概率密度函数），刻度范围
// 都是 0.0 至 0.6，主刻度为 0.0, 0.3, 0.6，次刻度为 0.15
// 间隔。 上图（Top）的横轴为 HD S/N，刻度范围约从 -2.0
// 至 11.0，主刻度为 0.0, 3.0, 6.0, 9.0，次刻度为 1.5 间
// 隔。图中包含三条阶梯状分布曲线：蓝色实线代表 HD
// injection 模拟结果，其分布最宽，峰值约在 S/N=3 附近（
// PDF 约 0.2），并向右延伸至 S/N 约 10 处；橙色长虚线代
// 表 CURN injection 模拟结果，峰值位于 S/N 约 1.0（PDF
// 约 0.35），分布集中在 0 至 3 之间；灰色点线代表 No
// injection 模拟结果，峰值位于 S/N 约 0.0（PDF 约 0.6），
// 分布很窄，主要在 -1.5 至 1.5 之间。图中有一条红色垂直
// 虚线位于 HD S/N = 2.5 处，代表真实数据集中测得的 MCOS
// HD S/N 值。 下图（Bottom）的横轴为 Monopole S/N，刻度
// 范围约从 -2.5 至 11.0，主刻度为 -2.5, 0.0, 2.5, 5.0,
// 7.5, 10.0，次刻度为 1.25 间隔。图中同样包含三条阶梯状
// 分布曲线：蓝色实线代表 HD injection，峰值位于 S/N 约
// 0.0（PDF 约 0.3），分布较宽，向右延伸至 S/N 约 7；橙色
// 长虚线代表 CURN injection，峰值位于 S/N 约 -1.0（PDF
// 约 0.45），分布在 -2.5 至 2.5 之间；灰色点线代表 No
// injection，峰值位于 S/N 约 0.0（PDF 约 0.4），分布集中
// 在 -2.5 至 2.0 之间。图中有一条红色垂直虚线位于
// Monopole S/N = 2.5 处，代表真实数据集的 MCOS 单极子 S/
// N 值。图例位于图的右上方，标明三条曲线对应的标签：橙色
// 长虚线为 CURN injection，蓝色实线为 HD injection，灰色
// 点线为 No injection。两个子图均显示，真实数据（红色虚
// 线）的 S/N 值高于 No injection 模拟的分布范围，但与 HD
// injection 和 CURN injection 的分布尾部有重叠。
#figure(placement: auto, [#block[
  #box(image("imgs/a4c_sims_cc.png", width: 100%))
  ]],
  caption: [
    #strong[Top:] MCOS HD S/N values recovered in the three simulations described in App. #ref(<sec:appastrosims>, supplement: none), compared to the MCOS HD S/N measured in the real data set (vertical dashed red line), which has $p$-values of $< 10^(- 2)$ for simulations i and iii, and $0.64$ for simulations ii. #strong[Bottom:] MCOS monopole S/N values recovered in the three simulations, compared to the real-data MCOS monopole S/N (vertical dashed red line), which has $p$-values of $4 times 10^(- 2)$, $1.1 times 10^(- 1)$, and $< 10^(- 2)$ for simulation i, ii, and iii respectively.
  ]
) <fig:a4c_sims_cc>

Following #cite(<astro4cast>, form: "prose"), we generate simulated data sets adopting MAP pulsar-noise parameters obtained from the real data independently for each pulsar; these "noise runs" include an additional power-law process to reduce contamination between the putative GWB and the pulsars' intrinsic red noise #cite(<2022PhRvD.105h4049T>). We produce 100 realizations each of three different simulations: (i) injecting no spatially correlated power-law GWB or excess uncorrelated common-spectrum noise; (ii) injecting a spatially correlated power-law GWB with amplitude $2.7 times 10^(- 15)$ and spectral index $13 \/ 3$; and (iii) injecting no GWB or common-spectrum noise, but omitting the additional power-law process in the estimation of intrinsic pulsar noise, with the goal of testing how often excess common-spectrum noise is recognized as a spatially correlated GWB.

We compute HD + monopole + dipole MCOS S/Ns for all synthetic data sets (see @fig:a4c_sims_cc). The mean HD S/Ns observed in the real data (see App. #ref(<sec:appmcos>, supplement: none)) correspond to $p$-values of $< 10^(- 2)$ for simulations (i) and (iii), and $0.64$ for simulation (ii). The mean monopole S/Ns observed in the real data set correspond to $p$-values of $4 times 10^(- 2)$, $1.1 times 10^(- 1)$, and $< 10^(- 2)$ for simulations (i), (ii), and (iii) respectively. We conclude that it is unlikely that we would measure HD correlations at the level observed in real data when no correlated signal is present (simulation (i)) or when only uncorrelated common-spectrum red noise is present (simulation (iii)). In addition, the HD S/Ns obtained from a HD-correlated GWB injection (simulation (ii)) are fully consistent with the S/N observed in real data. By contrast, the observed monopole S/N could have been produced by intrinsic pulsar noise alone, or by a real HD signal.

== Model-checking simulations <sec:appmodelsims>

// [figvision-cn] imgs/monopole_pvalue.png
// 该图由三个子图组成，中央为散点图，上方和右侧各附一个边
// 缘分布密度曲线图。 中央散点图横轴标注“15 yr Monopole S
// /N”，范围从约-5到10；纵轴标注“Simulated Monopole S/N”，
// 范围从约-5到10。横纵坐标范围相同，均为-5至10，主刻度间
// 隔为5，次刻度间隔为1。图中每个点代表一次从后验分布 hd
// ~ posterior 中抽取的样本，共约200个点，点填充为浅蓝色、
// 边缘为深蓝色圆点。散点主要聚集在横轴约2至4、纵轴约-3至
// 4的区域，纵轴离散程度略大于横轴。图中有一条黑色虚线对
// 角线，方程约为 y = x，但散点整体位于该线下方，表明模拟
// monopole S/N 通常小于15年 monopole S/N。 上方子图为横
// 向边缘分布密度曲线，横轴与中央散点图共享“15 yr
// Monopole S/N”，范围-5至10，纵轴无标注，表示概率密度。
// 蓝色实线呈单峰分布，峰值位于横轴约3.2处，曲线从约-1开
// 始上升，至约3.2达到最高，然后下降至约7处接近零。 右侧
// 子图为纵向边缘分布密度曲线，纵轴与中央散点图共享“
// Simulated Monopole S/N”，范围-5至10，横轴无标注，表示
// 概率密度。蓝色实线呈单峰分布，峰值位于纵轴约0.5处，分
// 布向左尾延伸至约-4，向右尾延伸至约4。 图中所有标注文字
// 为英文：中央图横轴“15 yr Monopole S/N”，纵轴“Simulated
// Monopole S/N”。图注说明：每个点代表一次从 hd ~
// posterior 中抽取的样本，用于模拟并计算两个 S/N；在11%
// 的模拟中，复制的 monopole S/N 大于实际数据的 monopole
// S/N。
#figure(image("imgs/monopole_pvalue.png", width: 45.0%),
  caption: [
    Distribution of real-data and replicated MCOS monopole S/Ns. Each point represents a draw $bold(eta)^( k )$ from #smallcaps[hd]#super[$(13 \/ 3)$]~posterior, which is used to simulate $bold(delta t)^("sim",(k))$ and to compute both S/Ns. The replicated monopole S/N is greater for 11\% of the simulations.
  ]
) <fig:monopole_pvalue_enterprise_sims>

In App. #ref(<sec:appastrosims>, supplement: none) we have tackled the question of monopole S/N significance using simulations based on real-data MAP estimates $bold(eta)^("MAP")$ of pulsar-noise and GW parameters. In this appendix we adopt a procedure with a stronger Bayesian flavor, evaluating the MCOS on a population of #emph[data replications] created using #smallcaps[hd]#super[$(13 \/ 3)$]~as a generative model with noise hyperparameters $bold(eta)$ drawn from the #smallcaps[hd]#super[$(13 \/ 3)$]~real-data posterior. This can be seen also as a Bayesian model-checking exercise #cite(<gelman_bayes_pvals>)#cite(<gelman2013bayesian>) if we find that the summary statistic of interest (the monopole MCOS) has a much more extreme value in real data than in data replications, we should suspect that the data model (here #smallcaps[hd]#super[$(13 \/ 3)$]) is missing something.

We perform the test by drawing 500 parameter vectors $( b"old"(e"ta")^( k ) )$ from the #smallcaps[hd]#super[$(13 \/ 3)$]~real-data posterior; for each $bold(eta)^( k )$ we simulate a data set $bold(delta t)^("sim",(k)) tilde p(bold(delta t) | bold(eta)^(k))$ and compare $"MCOS"(bold(delta t)^("sim",(k));bold(eta)^(k))$ with $"MCOS"(bold(delta t);bold(eta)^(k))$. Our notation emphasizes the dependence of the MCOS on the pulsar noise parameters through the $upright(bold(P))$ matrices in @eq:rhoab @fig:monopole_pvalue_enterprise_sims shows the resulting distribution of monopole S/Ns. The replicated monopole S/N is greater than its observed counterpart for 11\% of the draws. Thus, it is plausible that the MCOS could measure the observed monopole S/N in data that contain only a HD-correlated GWB. Conversely, the observed monopole S/N does not by itself suggest that #smallcaps[hd]#super[$(13 \/ 3)$]~is misspecified.
 Our notation emphasizes the dependence of the MCOS on the pulsar noise parameters through the $bold(P)$ matrices in @eq:rhoab @fig:monopole_pvalue_enterprise_sims shows the resulting distribution of monopole S/Ns. The replicated monopole S/N is greater than its observed counterpart for 11\% of the draws. Thus, it is plausible that the MCOS could measure the observed monopole S/N in data that contain only a HD-correlated GWB. Conversely, the observed monopole S/N does not by itself suggest that #smallcaps[hd]#super[$(13 \/ 3)$] is misspecified.

#heading(level: 2, numbering: none)[Software]
This work made use of the following software packages: #emph[acor], #emph[astropy] #cite(<2022ApJ...935..167A>), #emph[ceffyl] #cite(<2023arXiv230315442L>), #emph[chainconsumer] #cite(<Hinton2016>), #emph[ENTERPRISE] #cite(<enterprise>), #emph[enterprise_extensions] #cite(<enterprise_ext>), #emph[hasasia] #cite(<hasasia>), #emph[holodeck] #cite(<holodeck>), #emph[Jupyter] #cite(<Kluyver2016jupyter>), #emph[libstempo] #cite(<libstempo>), #emph[matplotlib] #cite(<matplotlib>), #emph[numpy] #cite(<harris2020array>), #emph[PINT] #cite(<2021ApJ...911...45L>), #emph[PTMCMC] #cite(<ptmcmc>), #emph[scipy] #cite(<2020SciPy-NMeth>), and #emph[Tempo2] #cite(<tempo2>).

