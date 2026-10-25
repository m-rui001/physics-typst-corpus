#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("CMU Serif", "New Computer Modern"), size: 10pt, lang: "en", hyphenate: true)
#set page(
  numbering: none,
  paper: "us-letter",
  margin: (left: 3.30cm, right: 2.78cm, top: 3.06cm, bottom: 2.88cm),
  header-ascent: 30.6pt,
  footer-descent: 34pt,
  header: context {
    if counter(page).get().first() > 1 {
      block(width: 100%)[
        #align(center)[#text(10pt, style: "italic")[Observational Evidence for Primordial Black Holes]]
        #v(-9pt)
        #line(length: 100%, stroke: 0.4pt)
      ]
    }
  },
  footer: context {
    align(center)[#text(10pt)[– #counter(page).display()/117 –]]
  },
)
#set heading(numbering: (..n) => {
  let v = n.pos()
  if v.len() == 1 { numbering("I.", v.first()) }
  else if v.len() == 2 { numbering("A.", v.last()) }
  else if v.len() == 3 { numbering("1.", v.last()) }
  else { numbering("a.", v.last()) }
})
#set par(justify: true, spacing: 1.25em, first-line-indent: (amount: 1.2em, all: true), linebreaks: "optimized")
#show figure: set block(above: 0.7em, below: 0.7em)
#show figure.caption: it => {
  set text(size: 9pt)
  set par(justify: true, leading: 0.17em, first-line-indent: 0pt)
  align(left)[#text(weight: "bold")[#it.supplement #it.numbering.]#h(0.4em)#it.body]
}
#show ref: it => {
  let e = it.element
  if e != none and e.func() == heading {
    let nums = counter(heading).at(e.location())
    let txt = if e.level == 1 { numbering("I", nums.at(0)) }
      else if e.level == 2 { numbering("I", nums.at(0)) + "." + numbering("A", nums.at(1)) }
      else if e.level == 3 { numbering("A", nums.at(1)) + "." + numbering("1", nums.at(2)) }
      else { numbering("1", nums.at(2)) + "." + numbering("a", nums.at(3)) }
    [Section~#txt]
  } else { it }
}
#show math.equation.where(block: true): set block(above: 1.65em, below: 1.65em)
#set par(leading: 0.75em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: (..n) => {
  let sec = counter(heading).get().first()
  numbering("I.1", sec, n.pos().first())
}, supplement: none)
#show heading.where(level: 1): it => {
  counter(math.equation).update(0)
  it
}
#let eqnn(body) = { set math.equation(numbering: none); body }


#block(height: 100%, width: 100%)[
  #align(center)[
    #block(width: 460pt)[#text(12pt, weight: "bold")[Observational Evidence for Primordial Black Holes: A Positivist Perspective]]
  ]
  #v(7.3pt)
  #align(center)[#text(10pt)[B. J. Carr,#super[1,#h(0.12em)∗]#h(0.17em) S. Clesse,#super[2,#h(0.12em)†]#h(0.17em) J. García-Bellido,#super[3,#h(0.12em)‡]#h(0.17em) M. R. S. Hawkins,#super[4,#h(0.12em)§]#h(0.17em) and F. Kühnel#super[5,#h(0.12em)¶]]]
  #v(0.7pt)
  #align(center, stack(dir: ttb, spacing: 10pt,
    text(9pt, style: "italic")[#super[1]#h(0.05em)School of Physics and Astronomy, Queen Mary University of London],
    text(9pt, style: "italic")[#super[2]#h(0.05em)Service de Physique Théorique, University of Brussels (ULB)],
    text(9pt, style: "italic")[#super[3]#h(0.05em)Instituto de Física Teórica, Universidad Autonóma de Madrid],
    text(9pt, style: "italic")[#super[4]#h(0.05em)Royal Observatory Edinburgh],
    text(9pt, style: "italic")[#super[5]#h(0.05em)Max Planck Institute for Physics,],
  ))
  #v(0.2pt)
  #align(center)[#text(9pt)[(Dated: Tuesday 6#super[th] February, 2024, 2:37am)]]
  #v(1.2pt)
  #pad(left: 20.5pt, right: 20.5pt)[
    #set text(size: 9pt)
    #set par(justify: true, first-line-indent: (amount: 9.2pt, all: true), leading: 0.77em)









	






	






	






	






	





We review numerous arguments for primordial black holes (PBHs) based on observational evidence from a variety of lensing, dynamical, accretion and gravitational-wave effects. This represents a shift from the usual emphasis on PBH constraints and provides what we term a positivist perspective. Microlensing observations of stars and quasars suggest that PBHs of around $1 thin M_⊙$ could provide much of the dark matter in galactic halos, this being allowed by the Large Magellanic Cloud microlensing observations if the PBHs have an extended mass function. More generally, providing the mass and dark matter fraction of the PBHs is large enough, the associated Poisson fluctuations could generate the first bound objects at a much earlier epoch than in the standard cosmological scenario. This simultaneously explains the recent detection of high-redshift dwarf galaxies, puzzling correlations of the source-subtracted infrared and X-ray cosmic backgrounds, the size and the mass-to-light ratios of ultra-faint-dwarf galaxies, the dynamical heating of the Galactic disk, and the binary coalescences observed by LIGO/Virgo/KAGRA in a mass range not usually associated with stellar remnants. Even if PBHs provide only a small fraction of the dark matter, they could explain various other observational conundra, and sufficiently large ones could seed the supermassive black holes in galactic nuclei or even early galaxies themselves. We argue that PBHs would naturally have formed around the electroweak, quantum chromodynamics and electron-positron annihilation epochs, when the sound-speed inevitably dips. This leads to an extended PBH mass function with a number of distinct bumps, the most prominent one being at around $1 thin M_⊙$, and this would allow PBHs to explain many of the observations in a unified way.
    ]
  #v(1fr)
  #place(bottom + left, dy: -70pt)[#h(1.7pt)#line(length: 42pt, stroke: 0.4pt)]
  #pad(bottom: 5.6pt, align(left, stack(dir: ttb, spacing: 8pt,
    text(8pt)[#h(1.7pt)#text(6pt)[∗]#h(0.4em)b.j.carr\@qmul.ac.uk],
    text(8pt)[#h(1.7pt)#text(6pt)[†]#h(0.4em)sebastien.clesse\@ulb.ac.be],
    text(8pt)[#h(1.7pt)#text(6pt)[‡]#h(0.4em)juan.garciabellido\@uam.es],
    text(8pt)[#h(1.7pt)#text(6pt)[§]#h(0.4em)mrsh\@roe.ac.uk],
    text(8pt)[#h(1.7pt)#text(6pt)[¶]#h(0.4em)fkuehnel\@mpp.mpg.de],
  )))
]








// single-column source (revtex reprint/preprint): no #columns wrapper
#pagebreak()
#[
  #set par(first-line-indent: 0pt, justify: false)
  #align(center)[#text(14.3pt, weight: "bold")[Contents]]
  #v(1.15em)
  #show outline.entry: it => {
    let hd = it.element
    if hd.numbering == none { return none }
    let nums = counter(heading).at(hd.location())
    let pg = counter(page).at(hd.location()).first()
    link(hd.location(), block(
      width: 100%,
      above: if it.level == 1 { 1.0em } else { 0pt },
      below: if it.level == 1 { 0.92em } else { 0.92em },
      {
        if it.level == 1 {
          text(weight: "bold")[#h(12pt)#(hd.numbering)(..nums)#h(8pt)#hd.body#h(1fr)#pg]
        } else {
          [#h(26pt)#(hd.numbering)(..nums)#h(8pt)#hd.body#h(1fr)#pg]
        }
      },
    ))
  }
  #outline(title: none, depth: 2, indent: 1.3em)
]
#pagebreak()
= Introduction
<sec:Introduction>


It is over 50 years since Hawking proposed the formation of PBHs~@Hawking:1971ei. Although his specific model turned out to be wrong (because it assumed the black holes were electrically charged and therefore able to capture charged particles to form neutral "atoms"), this might be regarded as the first #emph[positive] paper on the topic. Zeldovich and Novikov~@1967SvA....10..602Z had also speculated about this possibility in 1967 but concluded on the basis of a simple Newtonian argument that PBHs were unlikely to have formed because they would have grown through accretion to masses of order $10^15 thin M_⊙$ and the existence of such behemoths was excluded. However, in 1974 their accretion argument was disproved by a more precise relativistic analysis and it was shown that PBHs would not grow much at all~@Carr:1974nx.


PBHs would be expected to have the cosmological horizon mass at formation, which is well below the mass $tilde 1 thin M_⊙$ of the smallest astrophysical black holes for those forming before the quantum chromodynamics (QCD) epoch at $10^(- 5) thin$s. This prompted Hawking to consider the quantum effects of smaller black holes and led to his discovery in 1974 that they emit particles like a black-body with temperature $T prop M^(- 1)$ and evaporate completely on a timescale $tau prop M^3$~@Hawking:1974rv. (We note that the study of PBHs prompted the study of black hole quantum effects and not vice versa.) PBHs of around $10^15 thin$g would be completing their evaporation at the present epoch and those smaller than this would no longer exist. Even though Hawking's prediction has still not been experimentally confirmed, this might be regarded as one of the most important theoretical developments of the late 20th century since it unifies general relativity, quantum theory and thermodynamics. Since only PBHs could be small enough for this effect to be important, this shows that it has been useful to think about them even if they never actually formed.


In the aftermath of Hawking's discovery, there was a flurry of papers about the cosmological consequences of evaporating PBHs (such as their contribution to cosmic rays or gamma-ray bursts) but this did not lead to conclusive evidence for such objects. Later attention turned to the consequences of PBHs larger than $10^15 thin$g, for which quantum effects are unimportant, but there was no compelling evidence even in this context, so the topic remained a minority interest for many years. It was clear that PBHs were a unique probe of the early Universe, even their non-existence giving valuable information (e.g.~about the form of the density fluctuations on small scales and inflationary scenarios), but few people thought they might actually have formed. For this reason the number of publications in the area was initially very small.


However, in recent years the situation has changed radically and PBH publications have soared to several hundred per year. There are many reasons for this but perhaps the main ones are: (1) growing interest in the possibility that PBHs larger than $10^15 thin$g could provide the dark matter in galactic halos; (2) the LIGO/Virgo/KAGRA (LVK) detection of gravitational waves from coalescing binary black holes, at least some of which might be primordial; (3) the possibility that very large PBHs could provide seeds for the supermassive black holes (SMBHs) which reside in galactic nuclei. None of these arguments is decisive but they are sufficiently suggestive to have excited both the cosmological and particle physics communities.


As regards (1), the suggestion that PBHs could provide the dark matter goes back to the earliest days of PBH research~@1975Natur.253..251C, as does the realisation that this would have important consequences for galaxy formation~@Meszaros:1975ef. This interest was intensified in the 1990s, when the #emph[Massive Compact Halo Object] (MACHO) microlensing survey suggested the presence of compact objects with mass around $0.5 thin M_⊙$ and about $20 "%"$ of the dark matter~@MACHO:1996qam. The most likely candidates would be PBHs and those in this mass range might naturally form at the QCD transition~@Jedamzik:1998hc. Although later microlensing data reduced the dark matter fraction~@Alcock:2000ph and indeed excluded the mass range $10^(- 7) thin M_⊙$ to $10 thin M_⊙$~@Tisserand:2006zx from providing $100 "%"$, we will argue that PBHs are still a viable explanation for the MACHO events if they have an extended mass function.


As regards (2), although the mainstream view is that all the LVK detections derive from astrophysical black holes, the sources are larger than initially expected~@Kovetz:2017rvv and include mass gaps where stellar remnants should not be found. Also the observations suggest smaller spins than would be expected for astrophysical holes~@Garcia-Bellido:2017fdg. The PBH proposal is still controversial but future observations of the mass, spin and redshift distribution of the objects should clarify the issue soon. It should be stressed that the PBHs invoked in this context do not necessarily provide most of the dark matter.


As regards (3), the mainstream view is that the SMBHs in galactic nuclei form from dynamical processes #emph[after] galaxies, but this proposal is becoming increasingly challenged by the high mass and redshift of some SMBHs~@Dolgov:2023ijt. It is unclear that such objects can form quickly enough in the standard model, so this has led to the suggestion that the SMBHs --- or at least their seeds --- could form #emph[before] galaxies. Such seeds would only have a tiny fraction of the dark matter density and would probably undergo a huge amount of accretion after decoupling.


Although these three arguments have attracted most attention, several other cosmological conundra might be explained by PBHs. For example, provided the PBHs have an appreciable density, the formation of some galaxies at times earlier than predicted by the standard cold dark matter (CDM) model can be explained through their Poisson fluctuations. There are also other problems with the standard scenario which Silk claims can be resolved if intermediate-mass PBHs are ubiquitous in early dwarf galaxies, with their early feedback providing a unified explanation for many dwarf galaxy anomalies~@Silk:2017yai. In this context, it should be stressed that non-evaporating PBHs may still be of great interest even if they provide only a small fraction of the dark matter. For example, the PBHs seeding SMBHs in galactic nuclei and the PBHs required to explain planetary-mass microlensing events would only have a tiny cosmological density.


The possible evidence for PBHs is summarised in @fig:PositiveEvidence in terms of $f_"PBH" ( M )$, the fraction of the dark matter in PBHs with mass around $M$. The derivation of this figure is the main purpose of this review, although a detailed justification for each region is postponed until later. This figure supports what we term a “positivist” approach to the topic because of the association with the philosophy movement known as “logical positivism”. This was born nearly a century ago and stressed the importance of positive evidence as opposed to theoretical speculation~@Passmore1967-PASLP-6. The movement is no longer popular in philosophical circles but the term seems appropriate in the context of this review. For comparison, Darwin's ideas about natural selection were developed through detailed and careful study of a variety of disparate biological systems.


Besides the positive evidence for PBHs, there are numerous constraints on their number density. The limits on $f_"PBH" ( M )$ have recently been reviewed in Ref.~@Carr:2020gox. If the PBH mass function is monochromatic, these limits are often thought to imply that $10^17 thin "–" thin 10^23$ g is the only mass range where $f_"PBH" tilde 1$ is possible. However, it must be stressed that all limits have caveats and other mass ranges are possible if the PBH mass function is extended. Specifically, we will argue that the mass range $1 thin "–" thin 10^2 thin M_⊙$ is still possible. On the other hand, some PBH advocates prefer the lower mass range, so there is a sociological parallel with the split between the search for light and heavy particle candidates. However, whereas advocates of low-mass PBHs rely on the absence of limits, stellar-mass advocates rely on the existence of evidence.


// [figvision-cn] imgs/Figure_01.png
// 这是一张单一坐标系的科学图表，用于汇总原初黑洞（PBHs）
// 的多种探测迹象。图中没有子图划分，所有数据系列均叠加在
// 同一绘图区域内。 坐标轴设置：横轴表示原初黑洞质量 M，
// 单位为太阳质量 M_⊙，采用对数刻度，范围从 10^-12 到 10^
// 9 以上，主刻度标记为 10^-12、10^-8、10^-4、10^0、10^4、
// 10^8。纵轴表示原初黑洞丰度 f_PBH = Ω_PBH / Ω_DM，即原
// 初黑洞密度与暗物质密度之比，采用对数刻度，范围从 10^-5
// 到 1，主刻度标记为 10^-5、10^-4、0.001、0.010、0.100、
// 1。 图中各数据系列、标注文字及其物理含义如下： 左上方
// 有一条深红色实线边界与红色半透明填充区域，标注为 SNe（
// 超新星），覆盖质量范围约 10^-12 至 10^-6 M_⊙，在该范围
// 内给出 f_PBH 大致在 0.001 到 1 之间的限制或迹象。 灰色
// 曲线呈 U 形，标注为 HSC，质量覆盖约 10^-10 至 10^-2 M_
// ⊙，其最低点位于质量约 10^-8 M_⊙、f_PBH 约 0.001 处。
// 绿色椭圆区域标注为 OGLE，中心大致位于质量 10^-5 M_⊙、
// f_PBH 约 0.03，纵向范围约 0.005 至 0.2，横向范围约 10^
// -6 至 10^-4 M_⊙。 青绿色填充多边形标注为 P-A（像素引力
// 透镜），覆盖质量约 10^-5 至 10^0 M_⊙，f_PBH 值大致在
// 0.05 至 0.5 之间。 浅蓝色填充区域标注为 Quasars（类星
// 体），覆盖质量约 10^-4 至 10^0 M_⊙，f_PBH 值主要在 0.1
// 至 1 之间。 橙色区域标注为 MACHO，位于质量约 10^-1 至
// 10^1 M_⊙，f_PBH 约 0.01 至 1。 粉色、蓝色和橙色细长条
// 带标注为 SSM，集中在质量 10^0 M_⊙ 附近，f_PBH 范围较宽。
// 橙色阶梯状折线标注为 OGLE+Gaia，覆盖质量约 10^-1 至 10
// ^1 M_⊙，f_PBH 在 10^-5 至 1 之间。 棕色填充区域标注为
// PTA，覆盖质量约 10^0 至 10^2 M_⊙，f_PBH 约 10^-5 至 1。
// 黄绿色填充区域标注为 LVK（引力波探测），覆盖质量约 10^
// 0 至 10^2 M_⊙，f_PBH 约 10^-5 至 1。 紫色填充区域标注
// 为 C-C（核心/尖峰轮廓），覆盖质量约 10^1 至 10^5 M_⊙，
// f_PBH 约 10^-4 至 0.1。 浅黄色区域标注为 UFDGs（超暗弱
// 矮星系），覆盖质量约 10^3 至 10^5 M_⊙，f_PBH 约 10^-4
// 至 1。 右上角粉色斜线区域标注为 CIB-XRB，覆盖质量约 10
// ^1 至 10^5 M_⊙，f_PBH 较高，接近 1。 右侧紫色大方块区
// 域标注为 SMBHs（超大质量黑洞），覆盖质量约 10^4 至 10^
// 9 M_⊙，f_PBH 从 0.005 延伸至 1。 图中传达的趋势是：不
// 同观测手段对不同质量范围的原初黑洞给出了不同的丰度限制
// 或探测迹象。超新星和 HSC 主要限制较轻质量段（小于 10^
// -6 M_⊙）；中等质量段（10^-6 至 10^2 M_⊙）有密集的引力
// 透镜、引力波和类星体等观测数据覆盖；大质量段（大于 10^
// 4 M_⊙）由超大质量黑洞和 CIB-XRB 等给出较高丰度的迹象。
// 总体而言，原初黑洞作为暗物质组成部分的可能性在多个质量
// 窗口内被探讨，但各探测手段给出的 f_PBH 值跨度很大，从
// 10^-5 到接近 1 不等。
#figure(placement: top, image("imgs/Figure_01.png", width: 90.0%),
  caption: [
    Summary of positive indications of PBHs in terms of $f_"PBH"$ values required by or consistent with the claimed detections. These come from PBH-attributed signals from supernovæ (SNe), various microlensing surveys (#emph[Gaia], HSC, OGLE, MACHO), POINT-AGAPE pixel-lensing (P-A), gravitational waves (LVK), ultra-faint dwarf galaxies (UFDGs), supermassive black holes (SMBHs), core/cusp (C-C) profiles for inner galactic halos, and correlations of the source-subtracted cosmic infrared and X-ray backgrounds (CIB-XRB). The method used to calculate each region is described in @sec:Comparing-Evidence-with-Thermal--History-Model.
  ]
)
<fig:PositiveEvidence>



Although this review focusses on the positive evidence for PBHs, it should be stressed that none of the evidence is conclusive because there is always some uncertainty associated with either the observations or the theoretical interpretations. Even when the observations are definite, we cannot exclude some other explanation (e.g.~one involving some other dark matter candidate). For example, there is clear evidence for microlensing and gravitational wave events but still no consensus that these are associated with PBHs. Therefore, as with the constraints, one can associate varying degrees of confidence with each item of evidence and the confidence level is in part associated with the possibility of other explanations. Nevertheless, we would claim that the attraction of PBHs (at least with an extended mass function) is that they can provide a #emph[unified] explanation of all the evidence.


This review does not include a detailed discussion of the numerous formation mechanisms for PBHs, although the credibility of the evidence is clearly influenced by the plausibility of the mechanisms. The high density of the early Universe does not itself guarantee PBH formation. One also requires density inhomogeneities of some form, so that a small fraction of regions are dense enough to collapse. The most natural source of such inhomogeneities is inflation and there is a huge literature on this topic, starting with Refs.~@Carr:1993aq @Ivanov:1994pa @1996PhRvD..54.6040G @1996NuPhB.472..377R. However, there are also other mechanisms, including a reduction of pressure due to early matter-domination~@Khlopov:1980mg, quark confinement~@Dvali:2021byy, the collapse of cosmic strings~@1989PhLB..231..237H @Polnarev:1988dh or vacuum bubbles~@Deng:2017uwc or a scalar field~@2018PhRvD..98h3513C, and collisions of domain walls~@2001JETP...92..921R or bubbles of broken symmetry~@Hawking:1982ga. Nor will we cover the numerical studies of PBH formation~@1978SvA....22..129N @2013CQGra..30n5009M @2009CQGra..26w5001M @2019PhRvD.100l3524M @2021PhRvD.103f3538M. For a more comprehensive review of these issues, see Refs.~@Khlopov:2008qy @Escriva:2022duf.


Despite our neglect of these topics, we will highlight one particular formation mechanism. This is because the concentration of evidence at the solar-mass scale suggests a possible association with the QCD epoch~@Jedamzik:1996mr @2018JCAP...08..041B and a particular unified scenario in this context is described in Ref.~@Carr:2019kxo. This is based on the idea that the thermal history of the Universe naturally led to dips in the sound-speed and therefore enhanced PBH formation at scales corresponding to the electroweak phase transition ($10^(- 6) thin M_⊙$), the QCD transition ($1 thin M_⊙$), the pion-plateau ($10 thin M_⊙$) and $e^(+) e^(-)$ annihilation ($10^6 thin M_⊙$). This scenario allows an appreciable fraction of the dark matter to be PBHs formed at the QCD peak. Indeed, this fraction would naturally be around the value inferred by the MACHO project if the #emph[total] PBH density is comparable to that of the dark matter. Towards the end we discuss our preferred model in some detail. In particular, @fig:PositiveEvidence is reproduced, together with a curve representing the prediction of our unifying PBH scenario, showing how they are remarkably concordant.


The plan of this paper is as follows. We start with a discussion of the inevitable Poisson clustering of PBHs in @sec:Clustering-of-PBHs because this is an important aspect of the positive evidence and also affects the constraints. We discuss lensing evidence in @sec:Lensing-Evidence, dynamical/accretion evidence in @sec:Dynamical-and-Accretion-Evidence and gravitational-wave evidence in @sec:Gravitational--Wave-Evidence. Various other problems with the standard $Lambda$CDM model which could easily be resolved by PBHs are covered in @sec:Potential-Solutions-to-Cosmic-Problems. We consider some more general issues related to the PBH scenario in @sec:Evidence-from-Dark-Matter-and-Unified-Model, including a discussion of our favoured model for their production at the QCD epoch, a possible resolution of the fine-tuning problem and mixed dark matter scenarios. We draw some conclusions in @sec:Conclusions and append a table of acronyms.


= Clustering of PBHs
<sec:Clustering-of-PBHs>


A major difference between dark matter particles and PBHs comes from the larger mass of the latter. This implies significant Poisson fluctuations in the PBH spatial distribution and eventually leads to bound PBH clusters. This was first pointed out by Mészáros~@Meszaros:1975ef and later many other authors studied this effect@1977AandA....56..377C@1983ApJ...268....1C @1983ApJ...275..405F @Chisholm:2005vm @Chisholm:2011kn. It is crucial for sufficiently massive and abundant PBHs and has several significant consequences: (1) Some of the PBH constraints --- including the microlensing ones~@DeLuca:2020jug @Gorton:2022fyb @Petac:2022rio --- may be affected; (2) The clustering influences the PBH merger rate and thereby provides a connection between the dark matter and gravitational-wave (GW) observations; (3) It implies the formation of non-linear structures at higher redshifts than in the standard formation history, with implications for cosmic backgrounds and the observations of high-redshift galaxies; (4) It may explain the minimum size and large mass-to-light ratio of ultra-faint dwarf galaxies (UFDGs) and the identification of a subset of PBH clusters with these means that we can regard clustering as providing positive evidence for PBHs. The Coulomb effect of an individual PBH, which might be considered a special case of the Poisson effect, is also important. Because some of the observational evidence for PBHs depends on their clustering properties, we begin with a discussion of this topic. We first recall the heuristic treatment of the Poisson and Coulomb effects in Ref.~@Carr:2018rid. We then present a more detailed account of the formation and dynamical evolution of PBH clusters, including some extra effects which were not fully incorporated in earlier treatments. In this section the PBH mass is denoted by $m$ rather than $M$ and $f ( m )$ is the fraction of the dark matter density in those of mass $m$ for an extended mass function.


== Seed and Poisson Effects
<sec:Seed-and-Poisson-Effects>


PBHs provide a source of fluctuations for objects of larger mass in two ways: (1) via the seed effect, associated with the Coulomb attraction of a #emph[single] black hole; (2) via the Poisson effect, associated with the $sqrt(N)$ fluctuation in the number of black holes. If the PBHs have a single mass $m$, the initial fluctuation in the matter density on a scale $M$ is~@Carr:2018rid $ delta_i approx cases(
    m / M & ( "seed" ),
    ( f_"PBH" thin m / M )^(1 / 2) & ( "Poisson" ) thin ,
  ) $<eq:initial> where $f_"PBH"$ is the fraction of the dark matter in the PBHs, assumed to be constant during the clustering process. If $f_"PBH" tilde 1$, the Poisson effect dominates for all $M$\; if $f_"PBH" lt.double 1$, the Poisson effect dominates for $M > m / f_"PBH"$ and the seed effect for $M < m / f_"PBH"$. Indeed, the mass bound by a single seed can never exceed $m / f_"PBH"$ because of competition from other seeds.


There is always a mass $M_"CDM"$ below which the PBH fluctuations dominate the CDM fluctuations, so this produces extra power on small scales. However, the CDM fluctuations fall off slower than both the Poisson and seed fluctuations with increasing $M$ and so generally dominate for sufficiently large $M$. For this reason, the structure of the Universe is unchanged in $Lambda$CDM models on sufficiently large scales but it can be radically different on small-scales.


Both types of PBH fluctuations are frozen during the radiation-dominated era~@1974AandA....37..225M but grow as $( 1 + z )^(- 1)$ from the start of the matter-dominated era. Since matter-radiation equality corresponds to a redshift $z_"eq" approx 4000$ and an overdense region binds when $delta approx 1$, one can estimate the mass of regions which become gravitationally bound at redshift $z_(upright(c))$ as $ M_"c" approx cases(
    4000 #h(0em) m thin ( 1 + z_"c" )^(- 1) & ( "seed" ),
    10^7 f_"PBH" thin m thin ( 1 + z_"c" )^(- 2) & ( "Poisson" ) thin .
  ) $<eq:bind> However, there is an important difference between the two effects. In the Poisson case, most of the Universe goes into bound regions of mass $M_(upright(c))$ at redshift $z_(upright(c))$. For instance, if $f_"PBH" tilde 1$ and $m tilde 1 med thin M_⊙$, the Universe is already inhomogeneous at $z tilde 100$ with the formation of PBH clusters of around $10^3 thin M_⊙$. A similar result is obtained for any combination for which $m f_"PBH" tilde 1 M_⊙$. In the seed case, the fraction of the Universe in bound regions at redshift $z_(upright(c))$ is approximately $f_"PBH" thin z_"eq" / z_(upright(c))$, which is initially small for $f_"PBH" lt.double 1$ and only reaches $1$ at $z_(upright(c)) approx f_"PBH" thin z_"eq"$. Thereafter, competition between the seeds will limit the mass of each seed-bound region to at most $M tilde m / f_"PBH"$. This is just the value of $M$ above which the Poisson effect dominates. Each PBH is surrounded by a local bound region of this mass, so one has a combination of the seed and Poisson effect. Indeed, the regions of mass $m / f_"PBH"$ can themselves be regarded as sourcing Poisson fluctuations: putting $f_"PBH" arrow.r 1$ and $m arrow.r m / f_"PBH"$ in Eq.~(#ref(<eq:initial>)), and assuming growth starts at $z approx f_"PBH" thin z_"eq"$, gives the same bound mass as the original Poisson expression~(#ref(<eq:bind>)). The dependences of $delta_(upright(i))$ on $M$ and $M_(upright(c))$ on $z_(upright(c))$ are shown in @fig:seedvsposson.


For an extended PBH mass function, the relationship between the seed and Poisson effect is more complicated~@Carr:2018rid. For simplicity, we consider a power-law mass function with $"dn" / "dm" prop m^(- alpha)$ with upper and lower cut-offs at $m_"max"$ and $m_"min"$, respectively. This implies the mass fraction of the Universe in PBHs of mass $m$ is $f ( m ) prop m^2 thin "dn" / "dm" prop m^(- alpha + 2)$. The total dark matter fraction $f_"PBH"$ is therefore dominated by the $m_"min"$ PBHs for $alpha > 2$. The dominant fluctuation on a scale $M$ comes from the seed effect for $M < m_"min" / f_"PBH"$, so Eq.~(#ref(<eq:bind>)) implies that the mass binding at redshift $z_(upright(c))$ is $ M_(upright(c)) equiv M ( z_(upright(c)) ) tilde 4000 #h(0em) m_(upright("min")) thin ( 1 + z_(upright(c)) )^(- 1) quad upright("for") quad M_(upright(c)) < m_(upright("min")) / f_(upright("PBH")) thin . $<eq:boundmass> The Poisson effect dominates for $M > m_"min" / f_"PBH"$ but the relevant value of $m$ for given $M$ depends on the form of the function $f ( m ) thin m$. If this decreases with increasing $m$ (corresponding to $alpha > 3$), the holes of mass $m_"min"$ dominate the Poisson effect and Eq.~(#ref(<eq:bind>)) implies that the mass binding at redshift $z_(upright(c))$ is $ M_(upright(c)) tilde 10^7 #h(0em) f_(upright("PBH")) thin m_(upright("min")) thin ( 1 + z_(upright(c)) )^(- 2) quad upright("for") quad M_(upright(c)) > m_(upright("min")) / f_(upright("PBH")) thin . $ The expressions for $M_(upright(c))$ cross at $z_(upright(c)) = z_"eq" thin f_"PBH"$, which is when the Poisson effect takes over.


If $f ( m ) thin m$ is an increasing function of $m$ (corresponding to $alpha < 3$), the largest $m$ dominates the Poisson fluctuation. If the mass of the largest PBH in the region is less than $m_"max"$, i.e.~if $M < m_"max" / f_"max"$ where $f_"max" equiv f ( m_"max" )$, then the Poisson scenario effectively reduces to the seed scenario with an $M$-dependent seed mass $ m_(upright("seed")) tilde ( M f_(upright("PBH")) thin m_(upright("min"))^(alpha - 2) )^(1 / ( alpha - 1 )) thin . $<eq:seed>


The mass binding at redshift $z_(upright(c))$ is therefore $ M_(upright(c)) tilde f_(upright("PBH"))^(1 / ( alpha - 2 )) thin m_(upright("min")) ( 1 + z_(upright(c)) / 4000 )^(( alpha - 1 ) / ( 2 - alpha )) quad upright("for") quad m_(upright("min")) / f_(upright("PBH")) < M_(upright(c)) < m_(upright("max")) / f_(upright("max")) thin . $ However, if $M$ is larger than $m_"max" / f_"max"$, it will contain many PBHs of mass $m_"max"$ and the associated Poisson fluctuation will bind a mass $ M_(upright(c)) tilde 10^7 thin f_(upright("max")) thin m_(upright("max")) thin ( 1 + z_(upright(c)) )^(- 2) tilde 10^7 thin f_(upright("PBH")) thin m_(upright("min"))^(alpha - 2) thin m_(upright("max"))^(3 - alpha) thin ( 1 + z_(upright(c)) )^(- 2) \
    quad upright("for") quad M_(upright(c)) > m_(upright("max")) / f_(upright("max")) thin . $ There is therefore a complicated transition between the seed and Poisson effects in the extended case, this depending sensitively on the shape of the PBH mass function. One has $M_(upright(c)) prop ( 1 + z_(upright(c)) )^(- 1)$ at large $z_(upright(c))$, $( 1 + z_(upright(c)) )^(- 2)$ at low $z_(upright(c))$ and an intermediate regime with $M_(upright(c)) prop ( 1 + z_(upright(c)) )^(- ( alpha - 1 ) / ( alpha - 2 ))$ for $alpha < 3$. Numerical simulations are required for a more detailed analysis. Note that a more complicated mass function may still be approximated by a power-law over some mass range.


// [figvision-cn] imgs/Figure_02a.png
// 子图(a)是一幅双对数坐标的曲线图，横轴为质量 M，纵轴为
// 初始密度涨落 δ_l。纵轴为对数刻度，标有 10^-5、f、1 三
// 个刻度值，横轴标有 m、m/f、M_CDM、M_eq 四个刻度值。图
// 中包含三条线：一条是带折点的实线，左侧陡降段标注为“
// seed”，右侧较缓段标注为“Poisson”；另一条是虚线，标注为
// “CDM”。三条线在 m/f 附近相交，其中“seed”实线在 m 到 m/
// f 之间斜率较大，“Poisson”实线与“CDM”虚线在 m/f 到
// M_CDM 之间几乎重合，在 M_CDM 之后“Poisson”实线低于“CDM
// ”虚线，而“seed”实线在 m/f 之后持续低于“CDM”虚线。该图
// 表明，在质量小于 m/f 时，种子效应主导初始密度涨落；在
// 质量大于 m/f 时，泊松效应主导，且其重要性相对于标准
// CDM 模型逐渐降低。
// [figvision-cn] imgs/Figure_02a.png
// 子图(a)是一幅双对数坐标的曲线图，横轴为质量 M，纵轴为
// 初始密度涨落 δ_l。纵轴为对数刻度，标有 10^-5、f、1 三
// 个刻度值，横轴标有 m、m/f、M_CDM、M_eq 四个刻度值。图
// 中包含三条线：一条是带折点的实线，左侧陡降段标注为“
// seed”，右侧较缓段标注为“Poisson”；另一条是虚线，标注为
// “CDM”。三条线在 m/f 附近相交，其中“seed”实线在 m 到 m/
// f 之间斜率较大，“Poisson”实线与“CDM”虚线在 m/f 到
// M_CDM 之间几乎重合，在 M_CDM 之后“Poisson”实线低于“CDM
// ”虚线，而“seed”实线在 m/f 之后持续低于“CDM”虚线。该图
// 表明，在质量小于 m/f 时，种子效应主导初始密度涨落；在
// 质量大于 m/f 时，泊松效应主导，且其重要性相对于标准
// CDM 模型逐渐降低。
#figure(placement: top, [#box(image("imgs/Figure_02a.png", width: 45.0%)) #box(image("imgs/Figure_02b.png", width: 45.0%))

  ],
  caption: [
    Relative importance of the seed and Poisson effects as compared to the standard CDM scenario in terms of the initial density fluctuation $delta_(upright(i))$ as a function of mass (left) and the binding mass $M$ as a function of redshift $z_(upright(c))$ (right). From Ref.~@Carr:2018rid.
  ]
)
<fig:seedvsposson>



== Evolution of Poisson Fluctuations and Formation of PBH Clusters
<sec:Evolution-of-Poisson-Fluctuations-and-Formation-of-PBH-Clusters>


We now provide a more accurate description of PBH clustering induced by Poisson fluctuations. Going beyond the simple analytical estimates of the previous section is essential in assessing the positive observational evidence linked to the dynamics of these clusters and calculating the accretion onto the PBHs they contain. We consider the case of a monochromatic mass function. Since the Poisson fluctuation scales like $m f_"PBH"$, we can generalise to any PBH mass function by replacing $m f_"PBH"$ with $integral upright(d) ln m #h(0em) m thin f ( m )$.


The formation of Poisson-induced PBH clusters has been studied using $N$-body simulations~@Inman:2019wvr @Raidal:2018bbj and analytically using the Press--Schechter formalism and the theory of spherical collapse~@Afshordi:2003zb. As an illustrative example, @fig:Nbody shows the density distribution at redshift $z = 100$ obtained by Ref.~@Inman:2019wvr for monochromatic PBHs with $m = 30 thin M_⊙$ and $f_"PBH" = 10^(- 5)$ and $10^(- 1)$. These results also apply for any combination with $m f_"PBH" \/ M_⊙ = 0.0003$ and $3$. The difference with the standard cosmological scenario, in which the Universe is still homogeneous at such a high redshift, is striking.


// [figvision-cn] imgs/Figure_03a.png
// 这是一张二维伪彩色密度分布图（热图），用于展示在特定尺
// 度（图注提及红移 z，但图中未标注具体数值）下，由
// N-body 模拟得到的暗物质密度涨落场。该图没有传统的 x 轴
// 和 y 轴刻度及单位，整体为一个正方形区域，代表宇宙空间
// 的一个二维切片。 图左侧有一条垂直色标。色标顶部标注文
// 字为“≥ 4000”，其下方依次标注数值“45”、“4”、“1”、“0”。
// 色标旁侧垂直旋转的文字为“1 + δ_PDM”，表示所绘制的物理
// 量为原初暗物质密度场（PDM）的过密度加一。色标颜色从底
// 部的黑色（对应值 0）渐变到深紫色（对应值 1）、品红色（
// 对应值约 4）、橙粉色（对应值约 45），最后到顶部的浅黄
// 色（对应值 ≥ 4000）。该色标为对数或高度非线性的映射，
// 用以同时显示极低密度空隙和极高密度尖峰。 图右上角有白
// 色文字标注：“f_PBH = 10^{-5}”，表明该模拟中原初黑洞（
// PBH）的丰度参数设定为十万分之一。 图中主体区域绝大部分
// 被深紫色和品红色像素覆盖，对应 1 + δ_PDM 的值在 1 到 4
// 之间，呈现出弥漫的、云雾状的密度涨落纹理，并隐约可见由
// 暗至亮的网状结构。在图像中右侧偏下位置，存在一个非常显
// 眼的亮橙色至浅黄色的孤立亮点，其颜色对应色标上接近 45
// 至 ≥4000 的高密度区域，表明在该位置存在一个极端高密度
// 的暗物质晕或尖峰。图中没有其他独立的标注文字、符号或线
// 型。 整体图传达的趋势是：在 f_PBH = 10^{-5} 的设定下，
// 暗物质密度场在广阔区域内呈现接近平均密度的微弱涨落（1
// + δ_PDM 接近 1-4），但存在一个极为突出的高密度暗物质团
// 块（1 + δ_PDM ≥ 4000），该团块可能是原初黑洞或早期形成
// 的暗物质晕所产生的密度尖峰。
// [figvision-cn] imgs/Figure_03a.png
// 这是一张二维伪彩色密度分布图（热图），用于展示在特定尺
// 度（图注提及红移 z，但图中未标注具体数值）下，由
// N-body 模拟得到的暗物质密度涨落场。该图没有传统的 x 轴
// 和 y 轴刻度及单位，整体为一个正方形区域，代表宇宙空间
// 的一个二维切片。 图左侧有一条垂直色标。色标顶部标注文
// 字为“≥ 4000”，其下方依次标注数值“45”、“4”、“1”、“0”。
// 色标旁侧垂直旋转的文字为“1 + δ_PDM”，表示所绘制的物理
// 量为原初暗物质密度场（PDM）的过密度加一。色标颜色从底
// 部的黑色（对应值 0）渐变到深紫色（对应值 1）、品红色（
// 对应值约 4）、橙粉色（对应值约 45），最后到顶部的浅黄
// 色（对应值 ≥ 4000）。该色标为对数或高度非线性的映射，
// 用以同时显示极低密度空隙和极高密度尖峰。 图右上角有白
// 色文字标注：“f_PBH = 10^{-5}”，表明该模拟中原初黑洞（
// PBH）的丰度参数设定为十万分之一。 图中主体区域绝大部分
// 被深紫色和品红色像素覆盖，对应 1 + δ_PDM 的值在 1 到 4
// 之间，呈现出弥漫的、云雾状的密度涨落纹理，并隐约可见由
// 暗至亮的网状结构。在图像中右侧偏下位置，存在一个非常显
// 眼的亮橙色至浅黄色的孤立亮点，其颜色对应色标上接近 45
// 至 ≥4000 的高密度区域，表明在该位置存在一个极端高密度
// 的暗物质晕或尖峰。图中没有其他独立的标注文字、符号或线
// 型。 整体图传达的趋势是：在 f_PBH = 10^{-5} 的设定下，
// 暗物质密度场在广阔区域内呈现接近平均密度的微弱涨落（1
// + δ_PDM 接近 1-4），但存在一个极为突出的高密度暗物质团
// 块（1 + δ_PDM ≥ 4000），该团块可能是原初黑洞或早期形成
// 的暗物质晕所产生的密度尖峰。
#figure(placement: top, [#box(image("imgs/Figure_03a.png", width: 40.0%)) #box(image("imgs/Figure_03b.png", width: 40.0%))

  ],
  caption: [
    Expected dark matter density distribution over a scale of $2 thin h^(- 1) thin "kpc"$ at redshift $z = 99$ obtained from $N$-body simulations of Ref.~@Inman:2019wvr for $m = 30 thin M_⊙$ and $f_"PBH" = 10^(- 5)$ (#emph[left]) or $f_"PBH" = 0.1$ (#emph[right]).
  ]
)
<fig:Nbody>



As pointed out in Ref.~@Kashlinsky:2016sdv, the contribution from Poisson fluctuations to the matter power spectrum becomes dominant on small scales and for stellar-mass PBHs leads to the high-redshift gravitational collapse of almost all small-scale perturbations into clusters with masses up to $10^6 thin "–" thin 10^7 thin M_⊙$. The Poisson contribution in the matter power spectrum is scale-invariant and its amplitude at redshift $z$ is well approximated by~@Afshordi:2003zb $
  P_"Poisson" = 2 times 10^(-3) thin (f_"PBH")/(g(z)^2) (m/(3 thin M_⊙)) thin "Mpc"^3,
$ where $g ( z )$ is the growth factor for isocurvature fluctuations; this increases linearly with the scale factor in the matter-dominated era, when clusters are formed. Later, the growth function takes a more complex but still analytic form.


For example, if we consider the standard $Lambda$CDM model with $m = 3 thin M_⊙$ and $f_"PBH" = 1$, the Poisson term dominates for comoving wavemodes $k gt.tilde 100 thin "Mpc"^(- 1)$ at $z approx 20$. The current (dimensionless) density perturbation $Delta ( k )$, related to the power spectrum through $Delta ( k )^2 = P ( k ) thin k^3 / ( 2 pi^2 )$, is shown in @fig:deltas (neglecting non-linear effects). For comparison, we also show the expected spectrum for the standard $Lambda$CDM scenario and for a primordial spectrum with a sharp enhancement at $k_"trans" = 10^3 thin "Mpc"^(- 1)$ to generate PBHs at small scales. This effect modifies the spectrum below the scale at which the Poisson effect becomes dominant, but even for lower values of $m$ or $f_"PBH"$ one may have to take into account the effect of the enhanced primordial power spectrum on the PBH cluster formation, which is sometimes overlooked.


One can associate a cluster mass scale with each fluctuation wavelength $lambda = 2 pi / k$: $ M_(upright(c)) ( lambda ) = ( 4 pi / 3 ) thin lambda^3 thin rho_(upright(m))^0 thin ( 1 + delta_(upright(c)) )  \
  tilde.eq 1.15 times 10^12 thin ( lambda / upright("Mpc") )^3 thin ( 1 + delta_(upright(c)) ) thin M_⊙ thin , $<eq:Mlambda> where $rho_(upright(m))^0$ is the current matter density. Poisson-induced fluctuations decouple from the expansion and form a bound PBH cluster when they become larger than the overdensity threshold $delta_(upright(c)) tilde.eq 1.686$, which implies a redshift of collapse given by $
  z_c + 1 = 3.7 times 10^(-3) k^(-3/2) ( (m f_"PBH")/M_⊙ )^(-1/2) \
  = 39 times [ (10^6 m f_"PBH")/M_c ]^(1/2)
$ in the matter-dominated era. One recognises the same dependence on $m$ and $M_(upright(c))$ as in Eq.~(#ref(<eq:bind>)), but the formation redshift is higher, which demonstrates the need to go beyond those estimations. When a bound cluster is formed, the theory of spherical collapse predicts that its density is $178$ times the background density, giving a cluster radius at formation: $
  r_c = 135 thin "pc" ( (m f_"PBH")/M_⊙ )^(-1/2) (M_c/(10^6 thin M_⊙))^(5/6) .
$ <eq:rM> According to the Press--Schechter formalism~@Bond:1990iw @Bower:1991kf @Lacey:1993iv @Lacey:1994su, the fraction of fluctuations that collapse into halos with a mass $M_(upright(c))$ is given by
$ F_(upright(c)) ( M_(upright(c)), thin z_(upright(c)) ) = "erfc" [ (delta_(upright(c)))/(sqrt(2) thin sigma ( M_(upright(c)), z_(upright(c)) )) ], $
where
$ sigma^2 ( M_(upright(c)), z_(upright(c)) ) = integral (dif ln k) (k^3)/(2 pi^2) thin P ( k, z_(upright(c)) ) thin W ( k ). $
Here $W ( k )$ a window function, commonly taken to be a top-hat at $k ( M_(upright(c)) )$ with width $ln k ( M_(upright(c)) )$. @fig:deltas shows the expected value of $F_(upright(c))$ for the previous example ($m = 2.6 thin M_⊙$, $f_"PBH" = 1$) and indicates that $F_(upright(c)) ( M_(upright(c)) < 10^6 thin M_⊙ )$ is very close to unity. This means that almost all fluctuations below this scale collapse to clusters, so most PBHs end up in such clusters at some point. The maximum mass of PBH clusters for this model is therefore around $10^6 thin "–" thin 10^7 thin M_⊙$.


// [figvision-cn] imgs/Figure_04.png
// 该图为一幅双对数坐标曲线图，横轴表示波数 k，单位为 Mpc
// ⁻¹，范围从 0.001 到约 10000（刻度为 0.001、0.100、10、
// 1000）；图顶部另设一横轴，表示暗晕质量 M_halo，单位为
// 太阳质量 M_⊙，刻度从 10²⁰ 递减至 1（10²⁰、10¹⁸、10¹⁶、
// 10¹⁴、10¹²、10¹⁰、10⁸、10⁶、10⁴、10²、1）。纵轴为无量
// 纲线性密度反差 Δ(k)，对数刻度，范围从 10⁻⁶ 到 10⁴ 以上
// （刻度 10⁻⁶、10⁻⁴、0.01、1、10⁴），右侧纵轴为坍缩分数
// F_c，线性刻度，标注了 0.09、0.87、0.99 三个数值。图中
// 包含四条主要曲线：点线蓝线表示无原初黑洞（PBH）的标准
// ΛCDM 模型，曲线在低 k 区近乎平直，在 k≈1 附近略升至约
// 1 后保持平直；实线红线表示包含质量为 2.6 M_⊙ 原初黑洞
// 的总密度反差，覆盖范围从 k≈0.003 处约 10⁻³ 开始，随 k
// 增大单调上升，在 k≈10 处升至约 10，在 k≈1000 附近出现
// 明显拐折并急升至约 2×10⁴，之后在高 k 端略降；虚线绿线
// 表示物质功率谱中不可避免的泊松项（对应 m_PBH=2.6 M_⊙），
// 在对数坐标下呈直线上升趋势，从 (0.003, 10⁻⁶) 附近升至
// (3000, 5×10⁴) 附近，与红线上翘段相衔接；虚线橙线表示可
// 能诱导 PBH 形成的功率谱增强（跃变尺度），在 k<1000 区
// 与蓝线基本重合，于 k≈1000 处径直跃升至约 2×10⁴，随后与
// 红线的高 k 段重合并水平延伸至右侧边缘。图中还有一条水
// 平虚线（灰色）位于 Δ≈1 处，横贯全图，对应右侧纵轴的
// F_c≈0.09，或作为参考基准。图例（右下方区域）标注了四种
// 线型对应的物理含义：ΛCDM w/o PBHs、Step in P_ζ、
// Poisson, m_PBH=2.6 M_⊙、Total, m_PBH=2.6 M_⊙。图中传达
// 的趋势是：在包含特定质量原初黑洞的模型中，密度反差在 k
// ≈1000（对应小尺度）处出现显著增强，其总密度反差几乎完
// 全由泊松项贡献，而这一增强恰好对应坍缩分数 F_c 由约
// 0.09 上升至高值（0.87 以上）的区域，与可能诱导 PBH 形
// 成的功率谱跃变尺度相一致。
#figure(placement: top, image("imgs/Figure_04.png", width: 85.0%),
  caption: [
    Dimensionless (linear) density contrast $Delta ( k )$ today in the standard $Lambda$CDM model without PBHs (dotted blue line) and with them for $f_"PBH" = 1$ at $m = 2.6 thin M_⊙$ (solid red line), including the inevitable Poisson term in the matter power spectrum (dashed green line). For comparison, we also show the possible power spectrum enhancement leading to PBH formation for a transition scale at $k_"trans" = 10^3 thin "Mpc"^(- 1)$ (dashed orange line). The horizontal dashed line represents the critical threshold for halo formation $delta_"clust" tilde.eq 1.686$. The upper $x$-axis is the halo mass implied by Eq.~(#ref(<eq:Mlambda>)). The right $y$-axis shows the halo collapsed fraction $F_(upright(c)) ( M_(upright(c)) )$\; this is almost $1$ for $k gt.tilde 100 thin "Mpc"^(- 1)$, meaning that all PBHs are regrouped in clusters with masses of $10^6 thin "–" thin 10^7 thin M_⊙$. Figure adapted from Ref.~@Clesse:2020ghq.
  ]
)
<fig:deltas>



== Relaxation, Dynamical Heating and Evaporation of PBH Clusters
#<sec:Relaxation--Dynamical-Heating-and-Evaporation-of-PBH-Clusters>


When Poisson-induced PBH clusters have formed, it takes some time for the PBH velocities and the cluster size to relax towards the values expected from the virial theorem. The relaxation time for a halo of $N = f_"PBH" thin M_(upright(c)) / m$ objects is $ t_(upright("rel")) tilde.eq [frac(0.14 thin N, ln ( 0.14 thin N ))] #h(-1em) sqrt(frac(r_(upright(c))^3, G M_(upright(c)))) thin \
  = 2.1 times 10^6 thin upright("yr") thin frac(( M_(upright(c)) / M_⊙ )^(1 / 2), ( m / M_⊙ ) ln #h(-1em) \[ 0.14 thin M_(upright(c)) / m \]) (r_(upright(c)) / upright("pc"))^(#h(-1em) 3 / 2) thin , $<eq:reltime> where $r_(upright(c))$ is the initial halo median radius, estimated in the previous subsection. After relaxation the clusters continue to expand due to dynamical heating. This process is taken into account, for instance, to derive limits on $f_"PBH"$ from the minimum size of UDFGs or their globular star clusters. The cluster radius increases according to $ frac(upright(d) thin r_(upright(c)), upright(d) t) = frac(4 thin sqrt(2) pi thin G f_(upright("PBH")) thin m ln #h(0em) ( f_(upright("PBH")) #h(0em) M_(upright(c)) / 2 thin m ), 2 thin beta thin v_(upright("vir")) thin r_(upright(c))) thin , $ where $v_"vir" = sqrt(G M_(upright(c)) / 2 thin r_(upright(c)))$ is the halo virial velocity and $beta approx 10$ is a parameter depending on the halo profile. By integrating this equation, one can relate the time elapsed since cluster formation to the current cluster radius $r_(upright(c))$: $ t_(upright("dyn")) tilde.eq beta thin t_(upright("rel")) [1 - (r_(upright(c) , #h(0em) i) / r_(upright(c)))^(#h(-1em) 3 / 2)] \
  quad arrow.r.double quad r_(upright(c)) ( t_0 ) tilde.eq 400 thin beta^(- 2 / 3) (M_(upright(c)) / M_⊙)^(#h(-1em) - 1 / 3) #h(-1em) (m / M_⊙)^(#h(-1em) 2 / 3) ln #h(-1em) [frac(M_(upright(c)), 2 thin m)] . $<eq:dyntime> Here $r_(upright(c) , #h(0em) i)$ is the initial cluster radius, given by Eq. (#ref(<eq:rM>)), and the second expression gives the current cluster radius, obtained by putting $t_"dyn" = t_0 approx 14 thin$Gyr.


Eventually, if the PBH clusters are initially very compact and dense, they will completely evaporate through dynamical heating. This happens within the evaporation time, given approximately by $t_"ev" tilde 100 thin t_"rel"$. As a result, for a given cluster mass $M_(upright(c))$ one can deduce a minimum radius $r_(upright(c))$ from the requirement that the cluster has not totally evaporated. The time scales $t_"rel"$, $t_"dyn"$, $t_"ev"$ have the same dependence on $M_(upright(c))$, $f_"PBH"$ and $m$ but with different numerical factors. They have sometimes been confused. For example, in the context of the microlensing limits, the evaporation time was considered in Ref.~@Petac:2022rio in order to find the minimum cluster mass, whereas the dynamical heating time should have been used. Another point that has often been overlooked is that the initial size of the PBH clusters can be large enough for heating over the age of the Universe to be inefficient. This applies above the line specified by Eq.~(#ref(<eq:dyntime>)).


This discussion assumes that the evolution of a cluster can be considered in isolation. However, in the Poisson situation, a cluster always becomes part of a bigger cluster as long as $F_(upright(c)) approx 1$. So as it expands, it becomes subsumed into progressively larger structures and loses its integrity. This means the values of $r_(upright(c))$ and $M_(upright(c))$ for surviving clusters at the present epoch are related by Eq. (#ref(<eq:rM>)), so long as the expansion time $t_"dyn"$ is more than the age of the Universe. The expansion process stops above the mass for which the lines given by Eqs. (#ref(<eq:rM>)) and (#ref(<eq:dyntime>)) cross, so this introduces a minimum mass ($M_(upright(c)) prop m thin f_"PBH"^(3 / 7)$) and radius ($r_(upright(c)) prop m^(1 / 3) thin f_"PBH"^(- 1 / 7)$) for surviving clusters. These are of order $10^5 thin M_⊙$ and $r_(upright(c)) approx 20 thin$pc for $f_"PBH" thin m / M_⊙ tilde cal(O) ( 1 )$.


As discussed below, clusters larger than this minimum mass may still lose their integrity as a result of collisions within a larger cluster. However, this can lead to their disruption only if the velocity dispersion $sigma_(upright(c))$ within clusters increases with their mass. So long as the Poisson effect dominates, Eq. (#ref(<eq:rM>)) implies $sigma_(upright(c)) tilde M_(upright(c))^(1 / 12)$, which increases only very weakly, so it is marginal whether the hierarchy of clustering can be destroyed. However, on scales larger than about $10^8 thin M_⊙$, the CDM fluctuations take over (see @fig:deltas) and in this case $sigma_(upright(c)) tilde M_(upright(c))^(1 / 3)$. This means that collisional disruption may occur, at least in the central region of the larger bound region. In particular, we show below that collisions in our own halo may destroy clusters within a sufficiently small Galactocentric radius.


In order to illustrate these different processes and infer the PBH cluster mass-size relation today, @fig:rcvsmc shows as broken black lines the initial cluster size, from Eq. (#ref(<eq:rM>)), and the region where dynamical expansion occurs within the age of the Universe, from Eq.~(#ref(<eq:dyntime>)), for the cases $f_"PBH" thin m / M_⊙ = 0.3$, $3$ (relevant for the thermal-history model discussed in @sec:Thermal--History-Scenario) and $30$. The current relationship is given by the solid black lines with the minimum depending on $f_"PBH"$ and $m$. The increase of size with mass roughly follows the distribution of observed UFDGs (whose most likely half-light radius and mass are represented by crosses), which indicates that they form from Poisson rather than CDM fluctuations. The figure also indicates the cluster masses for which $F_(upright(c)) ( M_(upright(c)) ) = 0.9$ and $0.99$ (vertical blue lines), showing that almost all Poisson fluctuations have collapsed into such clusters on the relevant mass scale.


// [figvision-cn] imgs/Figure_05.jpg
// 这是一张双对数坐标的二维相图，横轴为原初黑洞（PBH）团
// 簇的质量 \(M_c\)，单位为太阳质量 \(M_\odot\)，范围从 \
// (10^3\) 到 \(10^9\)；纵轴为团簇的特征半径 \(r_c\)，单
// 位为秒差距（pc），范围从 1 到 1000。图中通过不同颜色区
// 域、曲线和标注，展示了由泊松涨落引起的 PBH 团簇在银河
// 系盘加热、潮汐场破坏、团簇碰撞、动力学摩擦和动力学加热
// 等物理过程影响下被排除或偏好的参数空间。 图中绿色区域
// 表示被银河系潮汐场破坏所排除的参数空间，分为两部分：深
// 绿色区域由绿色点线界定，标注为“Excl. by tidal field at
// \(R_0 = 8\ \text{kpc}\)”；浅绿色区域由绿色实线界定，标
// 注为“Excl. by tidal field at \(R_0 = 16\ \text{kpc}\)”。
// 两者之间的区域为浅绿色。红色区域表示被银河系盘加热排除
// 的参数空间，填充在垂直红色实线右侧，该线标注为“Excl.
// by disc heating”，位于 \(M_c \approx 2 \times 10^6\ M_
// \odot\) 附近。 蓝色线条表示团簇碰撞的排除边界：蓝色水
// 平实线标注为“Excl. by coll. dis. at \(R_0 = 16\ \text{
// kpc}\)”，位于 \(r_c \approx 80\ \text{pc}\)；蓝色水平
// 点线标注为“Excl. by coll. dis. at \(R_0 = 8\ \text{kpc
// }\)”，位于 \(r_c \approx 25\ \text{pc}\)。另一条蓝色点
// 线为垂直方向，标注“Collapse prob. \(F_c = 0.99\)”，位
// 于 \(M_c \approx 2 \times 10^5\ M_\odot\) 处。此外，从
// 该垂直蓝线附近向上延伸的蓝色点线表示潮汐场破坏边界向高
// 质量端的延续。 紫色实线表示动力学摩擦的排除边界，标注
// 为“Collapse prob. \(F_c = 0.90\)”，从图底部 \(M_c \
// approx 3 \times 10^6\ M_\odot\) 处斜向上延伸至高 \(M_c
// \) 区域。 黑色虚线表示动力学加热的排除边界，共三条斜线，
// 分别标注为“\(t_{\text{dyn}} = 13.7\ \text{Gyr}\) for
// PBH \(m/M_\odot = 3\)”（最上方）、“\(r_{c,i}\) for PBH
// \(m/M_\odot = 3\)”（中间）和“\(r_{c,i}\) for PBH \(m/
// M_\odot = 3\)”（最下方）。 黑色实线表示不同 PBH 质量比
// 下的最终半径 \(r_{c,f}\) 演化：黑实线从左下向右上弯曲
// 延伸，分别标注为“\(r_{c,f}\ m/M_\odot = 0.3\)”（最左侧）、
// “\(r_{c,f}\ m/M_\odot = 3\)”（中间）和“\(r_{c,f}\ m/M_
// \odot = 30\)”（最右侧）。这些曲线在低质量端较平缓，在
// 高质量端陡峭上升。 其他标注包括：蓝色叉号（×）散点分布
// 在图中，表示模拟或观测数据点；红色虚线位于图右下侧，标
// 注为“Coll. dis. within some \(R\)”；紫色斜线标注为“
// Coll. dis. before dyn. fric.”。图中还通过不同颜色背景
// （浅蓝、浅绿、浅红、浅紫）划分出不同物理过程主导的区域，
// 整体趋势表明：低质量、小半径的团簇受潮汐场和碰撞破坏影
// 响显著，而高质量、大半径的团簇则受盘加热和动力学摩擦约
// 束。
#figure(image("imgs/Figure_05.jpg", width: 90.0%), placement: top,
  caption: [
    Regions in the $( M_(upright(c)) , thin r_(upright(c)) )$ plane of PBH clusters induced by Poisson fluctuations that are excluded or favoured by (1) Galactic disc heating (red region), (2) disruption by the Galactic tidal field (green region) for a Galactocentric distance of $8$ kpc (dotted line) and $16$ kpc (solid line), (3) cluster collisions (blue lines), (4) dynamical friction (purple line), (5) dynamical heating (upper dashed black lines). The expected size of clusters in a scenario with $f_"PBH" thin m = 3 thin M_⊙$ is indicated by the thick solid black line that takes into account the dilution of sub-clusters inside more massive host clusters. For comparison, the cases $f_"PBH" thin m = 0.3 thin M_⊙$ and $30 thin M_⊙$ are also represented (thin black lines). The lower dashed black lines show the initial cluster size from Eq. (#ref(<eq:rM>)). The vertical blue lines indicate the cluster mass for which there is a probability of collapse into halos $F_(upright(c)) = 0.99$ and $F_(upright(c)) = 0.90$ (dashed and dotted lines, respectively) for Poisson fluctuations in the Press--Schechter formalism. The crosses indicate actual observations of UFDGs, with $r_(upright(c)) approx r_(1 / 2)$ and $M_(upright(c))$ computed from the virial theorem, for the best-fit values of the half-light-radius $r_(1 / 2)$ and velocity dispersion.
  ]
)
<fig:rcvsmc>





== Dynamical Friction
<sec:Dynamical-Friction>


Encounters between either SMBHs or clusters in our halo and lower mass objects (such as the spheroid stars) will steal energy from them so that they drift towards the Galactic centre. One can show that the clusters will reach the nucleus within the age of the Milky Way ($t_(upright(g)) approx 1.5 times 10^10 thin$yr) from inside a Galactocentric radius $ R_"df" approx cases(
    1.3 thin "kpc" ( frac(M_"c", 10^6 #h(0em) M_⊙) )^(#h(-1em) 10 / 21) & ( R_"df" < R_1 ),
    2.2 thin "kpc" ( frac(M_"c", 10^6 #h(0em) M_⊙) )^(#h(-1em) 2 / 3) & ( R_1 < R_"df" < R_2 ),
    1.4 thin "kpc" ( frac(M_"c", 10^6 #h(0em) M_⊙) )^(#h(-1em) 1 / 2) & ( R_"df" > R_2 ) thin ,
  ) $<eq:DF> where $R_1 approx 800 thin$pc is the core radius of the spheroid stars and $R_2$ is the radius beyond which the halo density dominates the spheroid density. The first two expressions were derived by Carr & Lacey~@1987ApJ...316...23C but this neglects the dynamical friction effects of the halo objects themselves if they have an extended mass function. The third expression allows for this and comes from an analysis by Carr & Sakellariadou~@Carr:1997cn. In the SMBH case, the mass dragged into the Galactic nucleus will exceed the observational upper limit of $4 times 10^6 thin M_⊙$~@Gillessen:2008qv unless one imposes an upper limit on the SMBH mass of around $10^4 thin ( R_(upright(c)) / 2 thin "kpc" )^2 thin M_⊙$. This assumes that the halo density is constant within some core radius $R_(upright(c))$ and falls off like $R^(- 2)$ outside this. However, this conclusion can be avoided for halo clusters since, as discussed below, they may be disrupted by collisions before dynamical friction can drag them into the nucleus.


== Collisional and Tidal Disruption
<Collisional-and-Tidal-Disruption>


The proposal that galactic halos comprise SMBHs is precluded by dynamical and accretion constraints. However, it is still possible that halos are made of supermassive clusters of black holes of more modest mass. Indeed, many years ago Carr & Lacey~@1987ApJ...316...23C suggested that the dark matter could be clusters of around $10^6 thin M_⊙$ comprising massive compact halo objects (MACHOs), this being the Jeans mass at decoupling. The accretion luminosity is then reduced by the number of objects per cluster, since the Bondi accretion rate and hence luminosity scale as the square of the black hole mass (see @sec:PBH-Accretion:-Pregalactic-Era), and the dynamical limits can be circumvented if the clusters are disrupted by collisions before the dynamical effects become operative. Although Carr & Lacey did not discuss the nature of the MACHOs or assume any particular mass for them, it is natural to assume that they are PBHs if they provide the dark matter because other MACHO candidates would have to derive from baryons and could only comprise $20 "%"$ of the dark matter. A simplified discussion of the dynamical constraints on the mass and radius of such clusters follows below and the results are summarised in @fig:rcvsmc. Most of the constraints are for the Milky Way halo but the arguments could also be applied to other galaxies.


Collisions between clusters will lead to their disruption if the velocity dispersion of the halo objects $sigma_(upright(h))$ exceeds their internal dispersion $sigma_(upright(c))$, as shown by the broken red line in @fig:rcvsmc. Outside the halo core ($R > R_(upright(c))$), this requires $r_(upright(c)) > 0.05 thin ( M_(upright(c)) / 10^6 thin M_⊙ ) thin$pc. The time scale for collisional disruption is constant within the core and increases further outward, so clusters will only be disrupted if the time scale at $R_(upright(c))$ is less than the lifetime of the Milky Way. This requires $r_(upright(c)) > 0.9 thin f_(upright(h))^(- 1) ( R_(upright(c)) / 2 thin "kpc" )^2 thin "pc"$ and clusters will be disrupted within a Galactocentric distance $2.1 thin f_(upright(h))^(1 / 2) thin ( r_(upright(c)) / "pc" )^(1 / 2) thin$kpc, where $f_(upright(h))$ is the fraction of the halo mass in the clusters. Clusters avoid dynamical friction providing this distance exceeds the value $R_"df"$ given by Eq.~(#ref(<eq:DF>)). An upper limit on $r_(upright(c))$ comes from requiring that the clusters survive at our own Galactocentric distance, $ r_(upright(c)) < 20 thin f_(upright(h))^(- 1) ( R_(upright(o)) / 8 thin upright("kpc") )^2 thin upright("pc") thin . $ We have represented this line in @fig:rcvsmc, together with the limit obtained at a Galactocentric distance of $16$ kpc, and interestingly this scale corresponds to the minimum size of PBH clusters if $f_"PBH" thin m / M_⊙ tilde cal(O) ( 1 )$. It is therefore expected that in the inner part of the Milky Way halo, PBH clusters in this case would have been disrupted by collisions. They nevertheless remain stable at the larger Galactocentric distance that is typical of UFDGs.


Clusters will also be destroyed by the Galactic tidal field at $R_(upright(o))$ unless $ r_(upright(c)) < 100 thin ( M_(upright(c)) / 10^6 thin M_⊙ )^(1 / 3) ( R_(upright(o)) / 8 thin upright("kpc") )^2 thin upright("pc") thin . $ As for collisional disruption, we also show this limit in @fig:rcvsmc for a Galactocentric distance of $16 thin$kpc. Again, the predictions for PBH clusters cross these regions, implying that they should have been destroyed by the tidal field in the inner part of halo. But at larger Galactocentric distances, corresponding to UFDGs, they should remain stable. On the other hand, clusters will be destroyed by collisions within the Galactocentric radius at which dynamical friction would drag them into the nucleus, given by Eq.~(#ref(<eq:DF>)), only if $ r_"c" > cases(
    0.5 thin f_"h"^(- 1) #h(-1em) ( frac(M_"c", 10^6 #h(0em) M_⊙) )^(#h(-1em) 4 / 3) "pc" & ( M_"c" < M_2 ),
    0.8 thin f_"h"^(- 1) #h(-1em) ( frac(M_"c", 10^6 #h(0em) M_⊙) ) "pc" & ( M_"c" > M_2 ) thin ,
  ) $ where $M_2$ is the mass for which Eq.~(#ref(<eq:DF>)) gives $R_"df" = R_2$. This condition is necessary in order to obviate the upper limit on their mass which would apply for SMBHs and corresponds to the region above the purple line in @fig:rcvsmc.


== PBH Clustering from Non-Gaussian Effects during Inflation
<sec:PBH-Clustering-from-Non--Gaussian-Effects-during-Inflation>


Non-Gaussian corrections to the matter density distribution may provide an important additional component to the initial PBH clustering during the radiation-dominated era. This arises because quantum diffusion during inflation creates high exponential tails in the probability distribution function for the density contrast~@Ezquiaga:2019ftu. These non-Gaussian effects increase the probability of finding another PBH near a given one, with successive waves of enhanced curvature fluctuations inevitably generating dense clusters. Their size and mass depend very strongly on the form of the non-Gaussian tails and is still under investigation. In particular, plateau-type potentials like those of Critical Higgs Inflation~@Ezquiaga:2017fvi @Garcia-Bellido:2017mdw naturally generate such tails, and significant clustering is also expected in the thermal-history scenario~@Carr:2019kxo. These non-Gaussian exponential tails also have important consequences for the early formation of massive structures like galaxies and clusters at high redshift~@Ezquiaga:2022qpw. In fact, the #emph[James Webb SpaceTelescope] (JWST) has detected massive galaxies at $13 thin "–" thin 16$, while the #emph[Dark Energy Spectroscopic Instrument] (DESI) and other telescopes found SMBHs at the centres of galaxies up to $z tilde 9$, whereas according to the $Lambda$CDM model there should be none. These exponential tails not only affect the large-scale structure evolution during the matter-dominated era, but also early PBH formation and clustering. Although primordial non-Gaussianity at CMB scales is usually characterised by a local $f_"NL"$ parameter, the non-Gaussian exponential tails arising from fundamental quantum diffusion during inflation~@Ezquiaga:2019ftu cannot be described in terms of perturbative parameters like $f_"NL"$ or $g_"NL"$~@Ezquiaga:2022qpw. Indeed, they are always positively squeezed with a large kurtosis and higher-order cumulants, enhancing the probability of collapse to PBHs.


The effect of large exponential tails in the distribution of density contrasts on the evolution of PBH clusters comprising some or all of the dark matter has been explored using $N$-body simulations of large-sale structure, these also including gas and other components~@Tkachev:2020uin @2021Univ....7...18T. However, Ref.~@Ali-Haimoud:2018dau claims that one does not expect clustering on very small scales beyond what is expected from a Poisson distribution. Moreover, the usual analysis of the formation of binaries during the radiation-dominated era~@Nakamura:1997sm assumes Poisson statistics, with binary formation occurring due to (rare) three-body encounters. Nevertheless, the additional clustering effect discussed here modifies both the formation of binaries and their disruption due to energetic close encounters. This prevents the early development of a stochastic GW background.


= Lensing Evidence
<sec:Lensing-Evidence>


This section discusses the evidence for PBHs from gravitational lensing. We distinguish between four effects, all of which have been observed and are relevant to the detection of PBHs: (1) multiple images of quasars produced by massive objects such as galaxies (macrolensing); (2) brightness variations in isolated quasars induced by much less massive objects, typically in the stellar mass range (microlensing), including microlensing by an intergalactic population of compact bodies, or individual stars or halo objects within galaxies; (3) microlensing by such objects of the images of a macrolensed quasar; (4) microlensing of individual nearby stars by other compact bodies.


The idea that a cosmological distribution of compact bodies might be detected by observing the microlensing of distant point-like light sources such as quasars or stars has a long history. In an early paper~@1973ApJ...185..397P, Press & Gunn proposed that a cosmological distribution of compact bodies could be detected from the amplification of quasar light due to microlensing, an idea which was put on a more practical basis~@1979Natur.282..561C by Chang & Refsdal. A similar idea was suggested by Gott~@1981ApJ...243..140G, who proposed that this method could determine whether the dark halos of galaxies were composed of compact bodies. The first practical suggestion as to how such bodies might be detected was put forward by Paczyński~@1986ApJ...304....1P. His idea was to determine whether the dark halo of the Milky Way was composed of stellar-mass bodies by monitoring several million stars in the Magellanic Clouds to look for the distinctive signature of microlensing events. This was put to the test by the MACHO collaboration~@1996ApJ...461...84A @2000ApJ...541..270A and the experiment was a resounding success. We discuss the results in more detail below.


Attempts to detect a cosmological distribution of compact bodies from the microlensing of quasars were more problematic. The difficulty was that should compact bodies make up a sizeable fraction of dark matter, a web of caustics would be formed, leading to the erratic variation of the quasar light as it traversed the complex amplification pattern. The resulting light curve would not have an easily identifiable shape and would be hard to distinguish from an intrinsic variation in the quasar accretion disc. There are, nonetheless, unmistakable features associated with caustic crossings which have been observed and cannot plausibly be associated with intrinsic variations~@Hawkins:1998fk. We discuss some typical examples below. Despite these difficulties, Hawkins~@1993Natur.366..242H presented the first evidence for a cosmological distribution of PBHs from the microlensing of quasar light curves. Further lines of evidence were later summarised~@Hawkins:2011qz in a more comprehensive case for PBHs as dark matter.


The difficulty of distinguishing microlensing events from intrinsic variations can largely be removed by focussing on multiply-lensed quasar systems. In these systems intrinsic variations in the quasar light will show up in each image, with a small time lag corresponding to differences in light travel time to the observer. However, it is well known that the individual quasar images can vary independently, often by large amounts. This is generally accepted to be the result of microlensing by compact bodies along the line of sight to each image, which might suggest a cosmological distribution of lenses. However, since a massive galaxy will inevitably lie along the line of sight to a gravitationally lensed quasar system, it is also possible that stars in the galaxy act as the lenses. The problem with this idea is that there are a number of systems where the microlensed quasar images lie well beyond the stellar population of the lensing galaxy~@Hawkins:2020zie, so the stellar lenses must either reside in the dark halo or more generally along the line of sight to the quasar images. The most striking example is a cluster lens~@Hawkins:2020rqu which we discuss below. If such a population of compact bodies exists, it must make up a significant fraction of the dark matter and should be detectable by microlensing along more general lines of sight to quasars. This possibility was investigated in early work by Schneider@1993AandA...279....1S and has more recently been updated by Hawkins~@2022MNRAS.tmp..849H to reveal a cosmological population of compact bodies associated with the dark matter distribution, most plausibly identified as PBHs.


There are a number of other puzzling features of quasar light curves which seem to point towards microlensing variations. These include lack of correlation between emission line and continuum variation, lack of evidence for time dilation in samples of quasar light curves, statistical symmetry of the variations, and colour effects which seem inconsistent with accretion-disc instabilities~@Hawkins:2011qz. For the remainder of this section we shall focus on the most conclusive evidence for microlensing by a cosmological distribution of compact bodies. Should this be confirmed, then at present the only plausible candidates would appear to be PBHs~@Hawkins:2020zie.


== Galactic Halo
<sec:Galactic-Halo>


// [figvision-cn] imgs/Figure_06a.png
// 这是一张单面板曲线图，标题为“Halo Models”（晕模型），
// 位于图的上方正中。图的横轴为 R (kpc)，表示银心距，单位
// 为千秒差距，刻度范围从 0 到 60，主刻度为 0, 20, 40, 60。
// 纵轴为 v (km/sec)，表示旋转速度，单位为公里每秒，刻度
// 范围从 0 到 400，主刻度为 0, 100, 200, 300, 400。纵轴
// 标签逆时针旋转了90度。 图中包含四组不同颜色的模型曲线
// （分别为红、绿、蓝、紫色），以及三组观测数据散点。所有
// 曲线在 R 约为 0-10 kpc 范围内从 0 迅速上升，随后在
// 100-260 km/sec 的区间内趋于平缓或缓慢变化。 红色虚线从
// R=0 起始，陡升至 10 kpc 处的约 220 km/sec，随后达到约
// 250 km/sec 并保持平缓，在 R=60 kpc 时略微升至约 260 km
// /sec。绿色点划线起始上升至 10 kpc 处的约 190 km/sec，
// 随后呈水平线，稳定在 200 km/sec 左右直至 R=60 kpc。蓝
// 色点线上升至 10 kpc 处的约 200 km/sec，随后平缓下降，
// 在 R=60 kpc 处降至约 160 km/sec。紫色点-划线（由一点和
// 两划交替组成）起始上升至 10 kpc 处的约 180 km/sec，随
// 后持续下降，在 R=60 kpc 处降至约 110 km/sec。 观测数据
// 以带垂直误差棒的散点表示，分布如下：实心圆点包含位于 (
// 约10, 210) 至 (约55, 190) 区间的多个点，其中 R=42 kpc
// 处有一个明显的实心圆点约为 200 km/sec。空心圆点包含位
// 于 (约10, 200) 至 (约40, 160) 区间的点。实心三角形从 R
// =25 kpc 处约 140 km/sec 延伸至 R=60 kpc 处约 110 km/
// sec。所有数据点均带有表示不确定度的上下垂直线段。图中
// 没有提供图例或色标说明，模型曲线的具体物理含义需参考原
// 始文献。整体趋势显示，观测数据（尤其是实心圆点在 R=
// 20-50 kpc 处）较好地落在蓝色和绿色曲线之间，而红色曲线
// 在 R>20 kpc 后明显高估了大多数观测速度，紫色曲线则低估
// 了 R>20 kpc 处的观测速度。
// [figvision-cn] imgs/Figure_06b.png
// 这是一幅单面板的二维直角坐标曲线图，标题为“Halo Models
// ”（晕模型），位于图像顶部中央。该图展示了银河系旋转曲
// 线随半径变化的情况，将观测数据与多个理论模型曲线进行了
// 对比。 坐标轴方面：横轴（X轴）表示半径，标签为“R (kpc)
// ”，单位为千秒差距，刻度范围从 0 到 60，主刻度标记为 0、
// 20、40、60，各主刻度之间有等距的次级刻度。纵轴（Y轴）
// 表示旋转速度，标签为“v (km/sec)”，单位为千米每秒，刻度
// 范围从 0 到 400，主刻度标记为 0、100、200、300、400，
// 包含次级刻度。图表顶部和右侧也画有向内指向的刻度线，但
// 没有数字标签。所有坐标轴刻度均为线性尺度。 图中包含观
// 测数据点和理论模型曲线： 观测数据点包含三种符号，均带
// 有垂直误差棒： 实心圆点：在半径约 10 至 50 kpc 范围内
// 分布，数值波动较大，在半径 45 kpc 附近有一个明显的峰值
// 约 200 km/s，整体分布在 150 至 220 km/s 之间。 空心圆
// 点：主要集中在半径 10 至 30 kpc 之间，速度值分布在 160
// 至 200 km/s 左右，在较远半径处也有零星分布。 实心三角
// 形：主要分布在半径 25 至 60 kpc 之间，速度值整体略低于
// 实心圆点，大致在 120 至 180 km/s 之间。 理论模型曲线方
// 面，图中绘制了多条平滑曲线，它们都在半径约 5 至 10 kpc
// 之间达到峰值（约 210 至 240 km/s），随后随半径增加缓慢
// 下降。这些曲线在峰值附近非常接近，在较大半径（>20 kpc）
// 处逐渐散开。 这些曲线包括五种不同线型和颜色的模型：红
// 色虚线（dashed）、绿色点划线（dot-dash）、蓝色点线（
// dotted）、紫色三点划线（dash-dot-dot-dot）以及一条黄色
// 实线（图中图注未明确解释黄色实线，但对应图注中提及的模
// 型）。此外，图中还包含其他浅色（如浅绿、浅紫等）的曲线，
// 与上述线型共同展示不同模型间的差异。 趋势与结论：观测
// 数据点在整体趋势上与模型曲线大致吻合，即速度在 10 kpc
// 左右达到峰值后缓慢下降，但观测数据在较大半径处（尤其是
// 实心圆点）存在显著的散布，且部分观测点高于理论模型预测
// 的平滑曲线。不同模型（不同颜色和线型）在半径 20 kpc 之
// 后出现明显的分歧，紫色和蓝色曲线下降较快，而绿色和红色
// 曲线下降较缓，黄色实线在峰值附近略高。图中没有提供图例
// 来详细说明每种线型对应的具体模型参数，但通过颜色和线型
// 的差异区分了不同的晕模型。
// [figvision-cn] imgs/Figure_06a.png
// 这是一张单面板曲线图，标题为“Halo Models”（晕模型），
// 位于图的上方正中。图的横轴为 R (kpc)，表示银心距，单位
// 为千秒差距，刻度范围从 0 到 60，主刻度为 0, 20, 40, 60。
// 纵轴为 v (km/sec)，表示旋转速度，单位为公里每秒，刻度
// 范围从 0 到 400，主刻度为 0, 100, 200, 300, 400。纵轴
// 标签逆时针旋转了90度。 图中包含四组不同颜色的模型曲线
// （分别为红、绿、蓝、紫色），以及三组观测数据散点。所有
// 曲线在 R 约为 0-10 kpc 范围内从 0 迅速上升，随后在
// 100-260 km/sec 的区间内趋于平缓或缓慢变化。 红色虚线从
// R=0 起始，陡升至 10 kpc 处的约 220 km/sec，随后达到约
// 250 km/sec 并保持平缓，在 R=60 kpc 时略微升至约 260 km
// /sec。绿色点划线起始上升至 10 kpc 处的约 190 km/sec，
// 随后呈水平线，稳定在 200 km/sec 左右直至 R=60 kpc。蓝
// 色点线上升至 10 kpc 处的约 200 km/sec，随后平缓下降，
// 在 R=60 kpc 处降至约 160 km/sec。紫色点-划线（由一点和
// 两划交替组成）起始上升至 10 kpc 处的约 180 km/sec，随
// 后持续下降，在 R=60 kpc 处降至约 110 km/sec。 观测数据
// 以带垂直误差棒的散点表示，分布如下：实心圆点包含位于 (
// 约10, 210) 至 (约55, 190) 区间的多个点，其中 R=42 kpc
// 处有一个明显的实心圆点约为 200 km/sec。空心圆点包含位
// 于 (约10, 200) 至 (约40, 160) 区间的点。实心三角形从 R
// =25 kpc 处约 140 km/sec 延伸至 R=60 kpc 处约 110 km/
// sec。所有数据点均带有表示不确定度的上下垂直线段。图中
// 没有提供图例或色标说明，模型曲线的具体物理含义需参考原
// 始文献。整体趋势显示，观测数据（尤其是实心圆点在 R=
// 20-50 kpc 处）较好地落在蓝色和绿色曲线之间，而红色曲线
// 在 R>20 kpc 后明显高估了大多数观测速度，紫色曲线则低估
// 了 R>20 kpc 处的观测速度。
#figure(placement: top, [#box(image("imgs/Figure_06a.png", width: 47.5%)) #box(image("imgs/Figure_06b.png", width: 47.5%)) #box(image("imgs/Figure_06c.png", width: 94.0%))

  ],
  caption: [
    #emph[Upper panel:] Rotation curves for models of the Milky Way out to $60 thin$kpc from Ref.~@Hawkins:2015uja. The observed rotation curves are shown as filled circles~@SDSS:2008nmx, open circles~@2013PASJ...65..118S and filled triangles~@2014ApJ...785...63B. In the #emph[top-left panel], the red (dashed), green (dot-dash), blue (dotted) and purple (dash-dot-dot-dot) curves are for Models B, S, F and E, respectively, from Ref.~@1996ApJ...461...84A. In the #emph[top-right] panel the coloured curves are for power-law models from Ref.~@1994MNRAS.267L..21E, consistent with the optical depth measurements of Ref.~@2000ApJ...541..270A. #emph[Lower panel:] More recent data for the rotation curve, extending to $100 thin$kpc, from Ref.~@Calcino:2018mwh. This shows the best-fit plots and $2 sigma$ uncertainties (shaded) for the power-law model with fixed bulge model included in the combined constraints. The difference between the combined rotation curve for the low prior (LP) and high prior (HP) cases is not discernible at the resolution of this plot, so a combined shaded region is shown. The HP case makes a slightly more massive disk and therefore a slightly lighter dark halo in the inner regions.
  ]
)
<fig:fig1>



The proposal of Paczyński~@1986ApJ...304....1P to search for compact objects in the halo of the Milky Way by looking for microlensing of stars in the Magellanic Clouds was based on the fact that the half-crossing time of the magnification curve depends on three quantities: the mass of the deflector $M_(upright(D))$, the reduced distance $1 / d = 1 / d_"OD" + 1 / d_"DS"$ (where $d_"OD"$ and $d_"DS"$ are the observer-deflector and deflector-source distances, respectively) and the velocity $v$ of the lens across the line of sight. This gives $ Delta t_(1 / 2) = sqrt(4 thin G M_(upright(D)) #h(0em) d) / v approx 0.1 thin upright("yr") (frac(M_(upright(D)), thin M_⊙))^(#h(-1em) 1 / 2) (frac(d, 10 thin upright("kpc")))^(#h(-1em) 1 / 2) (frac(v, 200 thin upright(k m / s)))^(#h(-1em) - 1) thin . $


The results of the survey for compact bodies in the Milky Way by the MACHO collaboration~@1996ApJ...461...84A @2000ApJ...541..270A have been widely and perhaps simplistically interpreted as ruling out the possibility that stellar-mass compact bodies make up the dark matter. However, we shall argue that the experiment puts no useful constraints on this proposal and, on the contrary, provides the first positive detections of stellar-mass PBHs. The number of microlensing events detected was around $15$, depending on the details of the selection criteria. This is far larger than can be attributed to known stellar populations in the Milky Way or Magellanic Clouds~@2000ApJ...541..270A. The population of compact bodies making up the lenses was an obvious dark matter candidate, but the MACHO collaboration stopped short of making such a claim because they concluded on the basis of their preferred 'heavy' halo model that there were too few compact bodies to account for the Milky Way rotation curve. Indeed, they concluded that such objects could make up at most $40 "%"$ of the halo. This limit was, among other things, based on the assumption of a narrow mass range for the lenses making up the dark matter. However, if the lenses have an extended mass function, as predicted for PBHs~@Carr:2019kxo, it is to be expected that the dark matter fraction at around $1 thin M_⊙$ will be significantly less than $1$.


When the first MACHO results were published, little was known about the rotation curve of the Milky Way and a variety of models were considered, as illustrated in the top left panel of @fig:fig1. However, most of these models were rejected as being unrealistic and it is now clear that their Model F (blue dotted line) fits recent rotation curve measures well and is consistent with their observed microlensing optical depth. The collaboration assumed an essentially flat rotation curve, in line with the consensus at the time on the statistics of the rotation curves of nearby galaxies. This implied a massive halo and considerably more microlensing events than were observed, so compact bodies were rejected as candidates to account for all of the halo dark matter~@2000ApJ...541..270A, although the possibility of a partial contribution was left open. Since then, much work has been done on the dynamics of the Milky Way and it is clear that the rotation curve is not flat but declines, as illustrated by the top panels of @fig:fig1, which are taken from Ref.~@Hawkins:2015uja. The observations shown there are from Refs.~@SDSS:2008nmx @2013PASJ...65..118S @2014ApJ...785...63B and can easily be fitted by halo models~@1994MNRAS.267L..21E with a microlensing optical depth consistent with the MACHO observations. More recently, the declining rotation curve has been confirmed by Ref.~@Calcino:2018mwh, shown in the lower panel of @fig:fig1, and Refs.~@Ou:2023adg @Jiao:2023aci. However, there is still inertia in the literature in accepting the reality of the new measures of halo kinematics. For example, in a recent paper@2022AandA...664A.106B the old superseded 'S' model for the halo is still used without any reference or challenge to the papers which show it to be inconsistent with recent observations of the Milky Way rotation curve. This inevitably appears to support earlier constraints on the population of PBHs in the Milky Way halo. Further doubt has been cast on the validity of the MACHO constraints by considering the effects of a broad mass function, as mentioned above.


The microlensing rate measured by MACHO was not confirmed by the EROS~@Tisserand:2006zx and OGLE~@Wyrzykowski:2011tr collaborations. Comparison of the results of these three groups is complicated, as EROS and OGLE failed to observe the excess of microlensing events detected by MACHO. The statistical incompatibility of the MACHO and EROS results has been the subject of extensive discussion~@Tisserand:2006zx @Moniez:2010zt. One of the most obvious differences between the MACHO and EROS experiments was their respective use of faint and bright star samples. Only two of the $17$ MACHO microlensing candidates were bright enough to be included in the EROS Bright-Stars sample~@Tisserand:2006zx but these were not detected in the standard EROS analysis for well-understood reasons. Although there are advantages in the restriction of the EROS analysis to bright stars, it would have resulted in problems associated with the resolution of stellar discs. In this sense, the MACHO detections can be seen as a lower limit to the total population of compact bodies.


This raises the question of the reliability of the estimates of detection efficiency, which are essential to setting limits on the frequency of microlensing events. There are a number of problems with these estimates, as discussed in detail by Hawkins~@Hawkins:2015uja. These include gaps in the data due to weather and mechanical failure, the consequences of variable seeing on overlapping images in the dense star fields of the Magellanic Clouds, the elimination of true variable stars, and the distortion of light curves due to the presence of binary or planetary companions. A related issue is the question of self-lensing by stars in the Magellanic Clouds rather than the Galactic halo. The MACHO fields covered only very dense regions of the LMC, which may increase the probability of self-lensing by stars there~@Sahu:1994pj. This effect is hard to quantify, given lack of detailed knowledge of the structure of the Magellanic Clouds, but subsequent analysis~@Mancini:2004pb has shown that self-lensing can only have a small effect on the observed optical depth to microlensing. A more detailed comparison between MACHO, EROS and OGLE events is beyond this review and their compatibility has recently been discussed elsewhere@2022AandA...664A.106B.


To summarise, the large excess of events associated with solar-mass lenses detected by the MACHO project cannot be attributed to the stellar population of the Milky Way and at present the only plausible candidates are PBHs~@Hawkins:2020zie. This possibility was considered by the MACHO collaboration~@2001ApJ...550L.169A, but rejected on the basis of their constraints. However, both MACHO and EROS only show microlensing constraints for monochromatic mass functions, while extended mass functions --- further discussed in @sec:Thermal--History-Scenario --- allow compatibility of the present microlensing constraints with a halo made entirely of PBHs~@Calcino:2018mwh. The reason is that the new Milky Way halo profile is no longer understood to be spherical, but triaxial, and the integrated optical depth due to dark matter in the form of PBHs along the line of sight between Earth and the LMC has been reduced by almost an order of magnitude. This, together with the observed MACHO microlensing events, implies that around $40 "%"$ of the Milky Way halo could be in the form of stellar mass PBHs~@Hawkins:2020zie. An extended mass function then allows for a peak at around a few solar masses, with smaller contributions at the few percent level, at smaller and larger masses. This would be inhomogeneously populated (e.g.~in the Galactic Center, dwarf spheroidals etc.), giving $100 "%"$ of the dark matter in the form of PBHs.


== Galactic Bulge
<sec:Galactic-Bulge>


Another approach for the detection of PBHs in the Milky Way has involved the monitoring of large numbers of stars in the Galactic bulge by the OGLE collaboration~@2016MNRAS.458.3012W. These observations are particularly focussed on the detection of white dwarf, neutron star and black hole lensing events, using #emph[Gaia] parallax measurements and brightness changes to estimate the mass of the lenses. This approach has led to the detection of a small sample of 'dark' lenses, where the contribution of light from the lensing body is negligible@2020AandA...636A..20W. This sample is of particular interest as it appears to bridge the mass range between $2 thin M_⊙$ and $5 thin M_⊙$, where there is a gap in the distribution of X-ray binaries~@2010ApJ...725.1918O. This gap may be explained by 'natal kicks', where the tangential velocity of the remnant is given a boost at birth, thus distorting the measurement of the lens mass. However, a more significant possibility@2020AandA...636A..20W is that the mass gap is populated by PBHs which would not be part of X-ray binary systems.


An unexpected indication of the existence of Earth-mass PBHs has come from a microlensing survey for unbound planetary mass bodies~@2017Natur.548..183M. Although the survey was primarily focussed on Jupiter-mass planets with an expected microlensing timescale of $1 thin "–" thin 2$ days, a small number of very short events with timescales less than half a day were also detected. This implies a lens with around an Earth mass and raises the question of the identity of such objects. This was addressed by Niikura #emph[et al.]~@Niikura:2019kqi, who used an accurate model for the stellar population of the Galactic bulge and disc, including their remnants, to account for the observed microlensing events in this mass range. The most obvious explanation for the six Earth-mass outliers is that they are detached or free floating planets, resulting from gravitational interactions between stellar systems. However, there is no continuity of detections between these outliers and events associated with low-mass stars or brown dwarfs. @fig:figX indicates the mass distribution of the OGLE/#emph[Gaia] events. @fig:OGLEPLAN shows their distribution as a function of timescale (left panel) and also the values of $f_"PBH" ( M )$ required to explain the data for a monochromatic mass function (blue band of right panel).


// [figvision-cn] imgs/Figure_07.png
// 这是一张采用双对数坐标系的科学曲线图，用于展示不同质量
// 下原初黑洞（PBH）的质量分布函数。图中横轴为质量 M，单
// 位为太阳质量 M⊙，范围从 0.01 到 1000，刻度按对数尺度分
// 布，主刻度分别为 0.01、0.10、1、10、100、1000。纵轴为
// f_PBH(M)，表示原初黑洞在暗物质中所占的比例，范围从
// 0.001 到略高于 1，同样采用对数刻度，主刻度为 1、0.100、
// 0.001。 图中有两种主要曲线：一条浅蓝色平滑曲线和一组深
// 红色曲线。浅蓝色曲线为参考模型给出的 PBH 质量分布，其
// 形态为宽峰结构，在 M ≈ 3–5 M⊙ 附近达到峰值，峰值约为
// 0.8–0.9，随后向高质量端下降，在 100–1000 M⊙ 区间趋于平
// 缓，约为 0.02 左右。深红色曲线代表 OGLE/Gaia 微引力透
// 镜事件的质量分布，共约十几条，每条曲线对应一个微引力透
// 镜事件的后验质量分布。这些红色曲线形态多样，大多呈单峰
// 分布，峰值位置分布在约 0.1 到 20 M⊙ 之间，峰值高度在
// 0.1 到 0.8 之间。部分曲线在峰值后迅速下降，呈现截断状；
// 也有曲线在 5–10 M⊙ 附近形成较宽的峰。 图中还包含一组灰
// 色竖直线，用于标示每个微引力透镜事件质量分布的模式（即
// 最可能的质量值）。这些灰线集中在约 0.8 到 8 M⊙ 之间，
// 具体位置大致为 0.8、1.2、1.5、2、2.5、3、4、5、6、8 M⊙
// 等，各线间距不等，反映了不同事件最可能质量的离散分布。
// 整体趋势表明：微引力透镜事件推断出的 PBH 质量主要集中
// 在 1–10 M⊙ 的范围内，与参考模型在 3–5 M⊙ 附近的峰值有
// 一定重叠，但红色曲线的峰值普遍略低于模型峰值，且部分事
// 件的质量分布向低质量端（0.1–1 M⊙）延伸。图中传达的结论
// 是：观测到的微引力透镜事件质量分布与参考模型在 1–10 M⊙
// 区间基本一致，但模型在 3–5 M⊙ 的峰值略高于多数事件的后
// 验分布，且高质量端（>20 M⊙）的分布存在较大不确定性。
#figure(placement: top, image("imgs/Figure_07.png", width: 77.0%),
  caption: [
    Mass distribution of OGLE/#emph[Gaia] events (red curves) overlaid onto the model of Ref.~@Carr:2019kxo. The mode of the distribution for each microlensing event is shown by grey vertical lines. Figure taken from Ref.~@Garcia-Bellido:2019tvz.
  ]
)
<fig:figX>



// [figvision-cn] imgs/Figure_08a.png
// 这是一张单面板科学图表，由左侧的直方图与右侧的图例组成，
// 没有子图划分。图表类型为双对数坐标曲线图与直方图。 横
// 轴名称为“ML LC timescale: t_E [days]”，即微引力透镜光
// 变曲线时标，单位为天。横轴采用对数刻度，范围从 10^-1
// 到略大于 10^0，主要刻度标注为 10^-1 和 10^0。纵轴名称
// 为“Number of events per bin”，即每个区间的观测事件数。
// 纵轴采用对数刻度，范围从 10^0 到 10^2，主要刻度标注为
// 10^0、10^1 和 10^2，刻度线包含次级对数分度。 图中包含
// 三组数据与曲线。第一组为黑色阶梯状直方图，带有黑色带盖
// 的误差棒。左上角标注文字为“OGLE data”（带有一个类似字
// 母 I 的符号）。该直方图在 t_E 小于 10^-1 至约 0.6 天之
// 间呈低值波动，多数区间事件数为 1，个别区间达到 2 左右；
// 当 t_E 大于约 0.6 天后，事件数急剧上升，在 t_E 接近
// 1.5 天（最右侧可见区间）达到约 60 至 70 个事件，误差棒
// 也随之增大。横轴最右侧的区间未显示完整。 第二组为粗紫
// 色实线，图例文字为“besft-fit PBH model”（注意原文存在
// 拼写错误，应为 best-fit），下方紧接括号内参数：“(M =
// 9.5 × 10^-6 M_⊙, f_PBH = 0.026)”。该曲线从横轴 10^-1
// 处约为 1.1 开始，在 t_E 约 0.15 天处达到峰值约 1.8，随
// 后单调下降，在 t_E 约 0.6 天处降至 0 附近（图表底边）。
// 第三组为蓝色虚线，无单独图例文字。该曲线从横轴 10^-1
// 处约为 1 开始，在 t_E 约 0.2 天处达到峰值约 1.2，随后
// 缓慢下降，在 t_E 约 0.7 天处降至 0 附近。 此外，图中还
// 有一条细蓝色实线，从横轴 t_E 约 0.55 天、纵轴事件数约
// 0.3 处开始，向右上方陡峭上升，穿过直方图的高值区域，在
// t_E 接近 1.5 天时穿过纵轴约 60 个事件的位置。该曲线无
// 图例说明。 图表传达的趋势是：观测到的微引力透镜事件时
// 标分布（黑色直方图）在短时标端（小于 0.6 天）呈现少量
// 事件，而在长时标端（大于 0.6 天）事件数迅速增加；紫色
// 粗实线代表的最佳拟合原初黑洞（PBH）模型仅能解释短时标
// 端的少量事件，而长时标端的事件分布可能由其他群体（如普
// 通恒星）主导。图注中提到的右侧面板（置信水平区域）在提
// 供的图片中并未出现。
// [figvision-cn] imgs/Figure_08a.png
// 这是一张单面板科学图表，由左侧的直方图与右侧的图例组成，
// 没有子图划分。图表类型为双对数坐标曲线图与直方图。 横
// 轴名称为“ML LC timescale: t_E [days]”，即微引力透镜光
// 变曲线时标，单位为天。横轴采用对数刻度，范围从 10^-1
// 到略大于 10^0，主要刻度标注为 10^-1 和 10^0。纵轴名称
// 为“Number of events per bin”，即每个区间的观测事件数。
// 纵轴采用对数刻度，范围从 10^0 到 10^2，主要刻度标注为
// 10^0、10^1 和 10^2，刻度线包含次级对数分度。 图中包含
// 三组数据与曲线。第一组为黑色阶梯状直方图，带有黑色带盖
// 的误差棒。左上角标注文字为“OGLE data”（带有一个类似字
// 母 I 的符号）。该直方图在 t_E 小于 10^-1 至约 0.6 天之
// 间呈低值波动，多数区间事件数为 1，个别区间达到 2 左右；
// 当 t_E 大于约 0.6 天后，事件数急剧上升，在 t_E 接近
// 1.5 天（最右侧可见区间）达到约 60 至 70 个事件，误差棒
// 也随之增大。横轴最右侧的区间未显示完整。 第二组为粗紫
// 色实线，图例文字为“besft-fit PBH model”（注意原文存在
// 拼写错误，应为 best-fit），下方紧接括号内参数：“(M =
// 9.5 × 10^-6 M_⊙, f_PBH = 0.026)”。该曲线从横轴 10^-1
// 处约为 1.1 开始，在 t_E 约 0.15 天处达到峰值约 1.8，随
// 后单调下降，在 t_E 约 0.6 天处降至 0 附近（图表底边）。
// 第三组为蓝色虚线，无单独图例文字。该曲线从横轴 10^-1
// 处约为 1 开始，在 t_E 约 0.2 天处达到峰值约 1.2，随后
// 缓慢下降，在 t_E 约 0.7 天处降至 0 附近。 此外，图中还
// 有一条细蓝色实线，从横轴 t_E 约 0.55 天、纵轴事件数约
// 0.3 处开始，向右上方陡峭上升，穿过直方图的高值区域，在
// t_E 接近 1.5 天时穿过纵轴约 60 个事件的位置。该曲线无
// 图例说明。 图表传达的趋势是：观测到的微引力透镜事件时
// 标分布（黑色直方图）在短时标端（小于 0.6 天）呈现少量
// 事件，而在长时标端（大于 0.6 天）事件数迅速增加；紫色
// 粗实线代表的最佳拟合原初黑洞（PBH）模型仅能解释短时标
// 端的少量事件，而长时标端的事件分布可能由其他群体（如普
// 通恒星）主导。图注中提到的右侧面板（置信水平区域）在提
// 供的图片中并未出现。
#figure(placement: top, [#box(image("imgs/Figure_08a.png", width: 45.0%)) #box(image("imgs/Figure_08b.png", width: 45.0%))

  ],
  caption: [
    #emph[Left panel:] Number of observed microlensing events as a function of lightcurve (LC) timescale in days from Ref.~@Niikura:2019kqi. The bold-purple solid line indicates the best-fit PBH model (with $M = 9.5 times 10^(- 6) thin M_⊙$ and $f_"PBH" = 0.026$) for explaining the distribution of six ultrashort-timescale OGLE events. #emph[Right panel:] $95 "%"$ confidence level (CL) region for PBH abundance (blue-shaded region), assuming that the six observed ultrashort-timescale events in the OGLE data are due to PBHs with a monochromatic mass function. Also shown (grey band) is the $95 "%"$ CL prediction for the abundance inferred from the HSC/Subaru observations. From Refs.~@Niikura:2019kqi and~@2019NatAs...3..524N.
  ]
)
<fig:OGLEPLAN>



== Andromeda Galaxy
<sec:Andromeda-Galaxy>


The search for the microlensing of stars in Andromeda is more challenging because the microlensed star is unresolved and just one of many stars contributing to each CCD pixel. The pixel-lensing technique, which involves subtracting a reference image from a target image taken at a different epoch, must therefore be used. This has been attempted by several groups. In particular, the POINT-AGAPE collaboration detected six microlensing events~@CalchiNovati:2005cd. They argued that this was more than could be expected from self-lensing alone and concluded that $20 "%"$ of the halo mass in the direction of Andromeda could be PBHs in the range $0.5 thin "–" thin 1 thin M_⊙$. This supports our conclusion above. In addition, they discussed a likely binary microlensing candidate with caustic crossing, whose location supported the conclusion that they were detecting a MACHO signal in the direction of Andromeda.


Niikura #emph[et al.]~@Niikura:2017zjd carried out a dense-cadence, seven-hour observation of Andromeda with the Subaru Hyper Suprime-Camera (HSC) and then used the pixel-lensing technique to search for microlensing of stars by PBHs lying in the halo of the Milky Way or Andromeda. The pointing was towards the central region of Andromeda and they reported the observation of a single microlensing event by a compact body with mass in the range $10^(- 11) thin "–" thin 10^(- 5) thin M_⊙$. A number of $15 , 571$ candidate variable stars were extracted from the difference images, and this was subsequently reduced to $66$ by selecting only those with a best-fit reduced $chi$-squared value and a light curve which is symmetrical around the peak. Further visual inspection left a single but solid candidate which passed all applied criteria and its light-curve is shown in #ref(<fig:Subaru-HSC>). Assuming that the number of microlensing events follows a Poisson distribution, and given the $10^8$ monitored stars, Niikura #emph[et al.]~estimated that about a thousand microlensing would have been observed during the seven-hour observation period if the PBHs constituted all the dark matter. Here, it is assumed that the PBHs are not subject to any additional (i.e.~non-Poissonian) clustering and have a monochromatic mass spectrum. @fig:eventrate shows the expected event rate for various PBH masses as a function of the full-width-at-half-maximum timescale $t_"FWHM"$. Translating this into estimates for $f_"PBH"$ yields the grey band in the right panel of @fig:OGLEPLAN.


// [figvision-cn] imgs/Figure_09.png
// 这是一张单面板的散点与拟合曲线图，没有子图划分。图表类
// 型为二维直角坐标曲线图。横轴标注为“time [sec]”，表示时
// 间，单位为秒，范围从 0 到 25000，主刻度间隔为 5000。纵
// 轴标注为“counts”，表示计数，范围从 -1500 到 1000，主刻
// 度间隔为 500（标记为 -1500, -1000, -500, 0, 500, 1000）。
// 图中包含以下视觉元素： 红色圆点：代表各观测历元的数据
// 点，每个红点带有垂直的误差棒（红色细线），表示图像差分
// 亮度测量中的光度误差。数据点分布在整个时间范围内，在 0
// 到 5000 秒及 20000 到 25000 秒区间内波动较大，部分点达
// 到 -1000 以下或 600 以上。 深蓝色实线曲线：贯穿整个时
// 间范围，由密集的小蓝点连接而成，代表最佳拟合微引力透镜
// 模型。该曲线在 0 到 12000 秒左右基本平缓，数值维持在
// -250 左右；在 12000 秒后开始上升，在约 17500 秒处达到
// 峰值，峰值约为 500 counts；随后下降，在 21000 秒左右回
// 落至基线水平并略微继续下降至 -300 左右。 浅蓝色实线：
// 位于深蓝色模型曲线附近，在大部分时间范围内与深蓝色线平
// 行，数值略高（约 50-100 counts），其波动趋势与深蓝色线
// 相似，代表该模型的某种包络或不确定性范围。 图中所有标
// 注文字包括纵轴标签“counts”、横轴标签“time [sec]”以及坐
// 标轴上的数字刻度。图表传达的趋势是：在约 17500 秒处存
// 在一个显著的微引力透镜事件亮度峰值，红色数据点围绕深蓝
// 色最佳拟合模型曲线分布，误差棒显示了测量的离散程度。
#figure(image("imgs/Figure_09.png", width: 65.0%),
  caption: [
    Best-fit microlensing model (blue curve) for the light curve of the single pixel-lensing event reported by Niikura #emph[et al.] ~@Niikura:2017zjd. Error bars denote photometric errors in the brightness measurement in the image difference at each epoch. From Ref.~@Niikura:2017zjd.
  ]
)
#<fig:Subaru-HSC>


// [figvision-cn] imgs/Figure_10.png
// 这是一张单面板的对数-对数坐标曲线图，展示单颗仙女座星
// 系（M31）恒星在不同质量原初黑洞（PBH）单色质量函数下，
// 微引力透镜事件的微分预期数量随光变半高全宽时标的分布。
// 横轴（x轴）为 t_FWHM [hrs]，表示微引力透镜光变曲线的半
// 高全宽时标，单位为小时，采用对数刻度，显示范围从 10^-2
// 到 10^1（即0.01至10小时）。纵轴（y轴）为 dN_event / d
// ln t_FWHM [events/star]，表示每颗恒星每个对数时标区间
// 的微引力透镜事件微分数量，单位为 events/star，采用对数
// 刻度，显示范围从 10^-7 到 10^-4 以上（最高可见至约2×10
// ^-4）。 图左上角标注标题文字“Event rate for a single
// star in M31”。图右上角为图例，列出六条实线对应的单色
// PBH质量 M：深蓝/黑色实线 M = 10^-12 M_⊙；深紫色实线 10
// ^-11 M_⊙；紫色实线 10^-10 M_⊙；品红色实线 10^-9 M_⊙；
// 橙色实线 10^-8 M_⊙；浅橙色实线 10^-7 M_⊙。符号 M_⊙ 表
// 示太阳质量。 图中六条实线均为不对称的单峰曲线：在小时
// 标端按幂律上升，达到峰值后在大时标端下降，峰值位置随时
// 标增大而向右移动，峰值高度随时标增大而降低。具体地，M
// = 10^-12 M_⊙ 的曲线在横轴左侧（约 10^-2 小时）迅速上升，
// 峰值几乎在 10^-2 小时附近（纵轴约 2×10^-4），随后急剧
// 下降，在约 10^-1 小时处降至 10^-7 以下。M = 10^-11 M_⊙
// 曲线的峰值约在 10^-1 小时处，纵轴约 4×10^-5。M = 10^
// -10 M_⊙ 曲线峰值约在 3×10^-1 小时处，纵轴约 1.5×10^-5。
// M = 10^-9 M_⊙ 曲线峰值约在 8×10^-1 小时处，纵轴约 5×10
// ^-6。M = 10^-8 M_⊙ 曲线峰值约在 2 小时处，纵轴约 2×10^
// -6。M = 10^-7 M_⊙ 曲线峰值约在 6 小时处，纵轴约 8×10^
// -7。在横轴 10^-2 至 10^-1 小时区间，黑色曲线与紫色曲线
// 存在交叉，说明低质量PBH主导极短时标事件，较高质量PBH在
// 更长时标处贡献更大。 图背景可分为两个区域：中间有一个
// 以浅灰色填充的垂直条带，范围约从 t_FWHM = 10^-2 小时到
// 2 小时（灰带右边界约在 1.5 至 2 小时之间），带内曲线和
// 数据敏感度最高；灰带外（10^-2 小时左侧及灰带右侧至 10^
// 1 小时）为白色背景。该灰带对应图注所述 utilised data
// 对光变曲线具有最高敏感度的时标区间。整体趋势表明：对于
// 给定质量的原初黑洞，微引力透镜事件率在特定半高全宽时标
// 处达到峰值；PBH质量越大，峰值时标越长且峰值事件率越低。
#figure(image("imgs/Figure_10.png", width: 65.0%),
  caption: [
    The expected differential number of microlensing events per logarithmic interval of the full-width-at-half-maximum timescale $t_"FWHM"$ for a single star in Andromeda. Solid lines correspond to a monochromatic PBH mass function with $f_"PBH" = 1$. The unshaded band is where the utilised data has the highest sensitivity to the lightcurves ($t_"FWHM" tilde.eq 0.07 thin "–" thin 3 med "hours"$). From Ref.~@Niikura:2017zjd.
  ]
)
<fig:eventrate>



== Caustic Crossings of Quasars
<sec:Caustic-Crossings-of-Quasars>


// [figvision-cn] imgs/Figure_11.png
// 这是一幅包含左右两个并排子图（a 和 b）的科学论文插图，
// 均为带误差棒的散点曲线图，展示了两个类星体在不同光学波
// 段下的长期光变曲线。 左侧子图（a）： 子图顶部居中标注
// 有“Q2116-441 z = 1.392”，表示目标天体名称及其红移值。
// 图注说明填充圆点和空心圆点分别代表蓝色和红色通带的测量
// 值，误差棒基于实测的光度误差。 纵轴（Y轴）标签为“Mag”
// （星等），刻度从上到下依次为 19、20、21，数值向下递增
// （表示亮度变暗），刻度范围约从 18.6 到 21.4 星等（反向
// 坐标，图下方为21）。 横轴（X轴）标签为“Years”（年份），
// 主刻度从左至右标记为 1985、1990、1995，刻度范围约覆盖
// 1982 年至 1998 年，每 2.5 年一个次级刻度。 数据序列（
// 蓝色实心圆点，即蓝光波段）： 起始于约 1982.5 年，星等
// 为 20.7；至 1984 年下降至约 21.0 星等；随后上升至
// 1987.5 年的峰值 19.4 星等；之后缓慢下降，在 1992 年左
// 右降至 20.4 星等；1994 年出现一个小幅回升至 19.8 星等；
// 最终在 1997 年降至最低点约 20.9 星等。所有数据点均带有
// 垂直误差棒，整体呈现先降、后升、再缓慢下降的波动趋势，
// 且蓝光波段与红光波段趋势高度一致，但蓝光星等数值普遍更
// 大（即更暗），反映了该天体的颜色特征。 数据序列（红色
// 空心圆点，即红光波段）： 整体走势与蓝点相同，但星等数
// 值更小（更亮）。起始于约 1982.5 年，星等约 19.7；1984
// 年降至约 19.9 星等；随后上升至 1988 年左右的峰值约
// 18.8 星等；之后缓慢下降，至 1995 年降至 20.1 星等；
// 1997 年跌至最低点约 20.3 星等。同样带有垂直误差棒。 右
// 侧子图（b）： 子图顶部居中标注有“Q2139-432 z = 1.645”。
// 图注与左侧相同（红蓝通带、误差棒）。 纵轴（Y轴）标签为
// “Mag”（星等），刻度从上到下依次为 20、21、22，刻度范围
// 约从 19.4 到 22.1 星等（反向坐标，图下方为22）。 横轴
// （X轴）标签为“Years”（年份），主刻度标记为 1985、1990、
// 1995，刻度范围约 1982.5 年至 1997.5 年。 数据序列（蓝
// 色实心圆点）： 起始于约 1982.5 年，星等约 20.9；至
// 1984 年上升至 21.3 星等（变暗）；随后在 1985 年上升至
// 约 21.8 星等，达到整个序列最暗点；之后开始持续变亮，至
// 1992 年达到峰值约 20.3 星等；随后在 1993 年降至 20.5
// 星等，1994 年升至 20.1 星等；最终在 1997 年降至 21.2
// 星等。整体呈现先变暗（至 21.8），后持续变亮（至 20.1），
// 再变暗的趋势。 数据序列（红色空心圆点）： 起始于约
// 1982.5 年，星等约 19.7；1984 年升至约 20.2 星等；1985
// 年至 1987 年间在 20.3 到 20.2 之间波动；1988 年后开始
// 持续上升（变亮），至 1993 年达到峰值约 19.4 星等；之后
// 在 1995 年降至 19.8 星等，1997 年降至 19.9 星等。整体
// 趋势同样与蓝点平行，红点始终比方点亮约 1 个星等。 该图
// 传达的关键趋势与结论：两个红移不同的类星体在近 15 年的
// 观测期内均表现出显著的长期光变，且其蓝光与红光波段的光
// 变趋势高度同步（形状相似），但蓝光波段始终比红光波段暗
// 约 1 个星等。两者的光变曲线特征（如 1987-1988 年的峰值
// 和随后的下降，以及 1993 年左右的高亮度状态）与类星体受
// 到微引力透镜效应中“焦散线交叉（caustic crossing events）
// ”的预期特征相吻合。所有数据点都带有垂直误差棒，表明测
// 量精度。
#figure(placement: top, image("imgs/Figure_11.png", width: 100.0%),
  caption: [
    Light curves for two quasars showing all the characteristics expected of caustic crossing events. Filled and open circles are blue and red passband measures, respectively. Error bars are based on measured photometric errors. From Ref.~@Hawkins:1998fk.
  ]
)
<fig:fig2>



If solar-mass PBHs make up a significant fraction of dark matter, then the detection of microlensing in the light curves of distant compact sources such as quasars becomes an interesting possibility. The frequency of such events is a function of the cosmological density of the lenses and the redshift of the quasar~@1992ApJ...393....3F, while the structure of the resulting light curve depends upon the relative sizes of the quasar accretion disc and the Einstein radius of the lenses, as well as the optical depth to microlensing $tau$. From simulations it is clear that it will be hard to unambiguously identify most microlensing events in quasar light curves. A large source size will smear out the characteristic features and make them hard to distinguish from intrinsic changes in quasar luminosity. Some interesting candidates for isolated microlensing events have recently been proposed@10.1093-mnras-staa972 but such featureless light curves are hard to pin down as the result of microlensing, as opposed to intrinsic variations in the quasar luminosity.


The most distinctive features of microlensing light-curves are caustic crossings. For low optical depth ($tau lt.tilde 0.3$), microlensing events tend to be isolated, with no readily identifiable features. However, as $tau$ increases, caustic features emerge in the amplification pattern, with characteristic shapes and structures. These are well illustrated by simulations@1986AandA...166...36K, where the effect of increasing source size can also be seen. Although the identification of caustic crossings in quasar light curves would be an unambiguous signature of a component of dark matter in the form of PBHs, the difficulty of disentangling microlensing events from the distorting effects of intrinsic variations means that uncontaminated detections of caustic crossings will be quite rare. However, in a large enough sample of light curves these difficulties can be largely overcome~@Hawkins:1998fk.


The requirements for detecting caustic crossings in quasar light-curves are quite demanding. For a population of solar-mass lenses, the typical time for a compact source to cross a caustic is $10$ to $20$ years. To define the structure of the resulting light curve, it must be sampled at least once a year with an accuracy of $tilde 0.05$ mags, ideally for around $20$ years. Given that for a cosmological distribution of lenses well-defined caustic crossings are quite rare, a large sample of light curves will be required for a reasonable chance to find an unambiguous detection of a caustic crossing. These requirements are largely satisfied in the large-scale quasar monitoring programme undertaken by the UK $1.2 thin$m Schmidt telescope from 1975 to 2002 in ESO/SERC Field $287$. The survey comprises yearly sampled light curves covering up to 25 years for over a thousand quasars~@Madgwick:2003bd, and has proved to be an excellent database for the detection of caustic-crossing events.


In @fig:fig2 we show two examples of caustic crossing events from the Field 287 survey, where the blue and red symbols are for blue and red passband magnitudes, respectively. The two light curves were selected as they clearly show the characteristic distinguishing features of caustic crossing events. A well-known feature of the gravitational lensing of a point source is that changes in amplitude are achromatic. The question of whether intrinsic quasar variations are achromatic is complicated. Low-luminosity active galactic nuclei are known to become bluer as they brighten~@Peterson:2002nh, whereas more luminous quasars can show little or no colour change as they vary~@2018ApJ...862..123M. This means that for point sources, colour changes are not a useful way of distinguishing between microlensing and intrinsic variations. A more interesting situation arises where the source is resolved, or larger than the Einstein radii of the lenses, and there is a radial colour gradient, as might be expected in a quasar accretion disc. In this case the blue and red passband light curves can have very different and characteristic structures. The colour gradient effectively results in the source of blue light being more compact than the red source. When a quasar crosses a caustic in the amplification pattern of the lenses, the blue light curve can show the unresolved features of the caustic, while in the red light curve the features are smoothed out from the partial resolution of the red source. An additional effect is that as the quasar accretion disc traverses the caustic pattern, it will start to amplify the red light before the blue, and will continue to do so for longer. The light curves in @fig:fig2 clearly show all these features. The blue curves show the characteristic cusps associated with caustic crossings, which are smoothed out in the red curves. Amplification of the quasar light first appears in the red curves, followed by sharper and larger rises and falls in the blue. The red light then continues to decline to the base level.


The features in the two light curves in @fig:fig2 are commonly seen in the Field 287 sample, although in some cases apparently distorted by intrinsic variations. It is not easy to see how accretion-disc instabilities can produce these symmetrical feature, as instabilities originating at the centre should start simultaneously in the red and blue light curves, and persist longer in the red as the disc cools with increasing radius. This asymmetry can be seen in individual light curves~@Hawkins:1998fk, and statistically in the form of time lags~@2018ApJ...862..123M. The identification of caustic crossings in quasar light curves implies a cosmological distribution of lenses. This rules out stars as lens candidates, which would have negligible probability of forming a universal cosmic web. Given the large optical depth to microlensing required to produce caustics, the lenses must make up a large part of the dark matter, and in this case the only plausible candidates are PBHs~@Hawkins:2020zie.


Another example of caustic crossing has come from Kelly #emph[et al.]~@Kelly:2017fps, who have reported the magnification of an individual star by the galaxy cluster MACSJ1149.5+2223 at $z = 1.49$. They claim that dark matter subhalos or massive compact objects may account for this and that PBHs of $30 thin M_⊙$ with $3 "%"$ of the dark matter could potentially explain some features of the observations. Diego #emph[et al.]~@Diego:2017drh have used simulations of ray-tracing to study this case; they allow for both stars and PBHs, and also include the effects of the intracluster medium. They point out that this phenomenon should be widespread and that HST monitoring of such arcs could yield the mass spectrum of the compact objects. Venumadhav #emph[et al.]~@Venumadhav:2017pps have studied this in more detail and find that the exquisite sensitivity of caustic-crossing events to the granularity of the lens-mass distribution makes them ideal probes of dark matter components, such as PBHs.


== Multiply Lensed Quasars
<sec:Multiply-Lensed-Quasars>


Perhaps the most convincing detections of stellar-mass PBHs come from the analysis of microlensing events in the light curves of multiply lensed quasar systems. The first detection of such a gravitational lens~@1979Natur.279..381W showed the quasar Q0957+561 split into two separate images by a massive galaxy along the line of sight. A photometric monitoring programme revealed that small brightness changes in one image were repeated in the second image around a year later. This confirmed the identification of the system as a gravitational lens, but also revealed that the images varied in brightness independently of each other~@1991AJ....101..813S. This result has been universally interpreted as the result of microlensing by a population of solar-mass bodies along the line of sight to the quasar images. The different light trajectories from each of the quasar images to the observer result in independent amplification patterns, and hence light curves, for each image. Somewhat surprisingly, it was widely assumed from the outset~@1990AJ....100.1771S @1991MNRAS.251..698F @1993ApJ...404..455K that the microlenses were in the lensing galaxy, and it was only some time later~@Hawkins:2011qz @Hawkins:2020zie @Hawkins:2020rqu that evidence was presented that the microlenses were part of a cosmological distribution of stellar-mass compact bodies making up the dark matter. In this case, they would be situated in the halo of the lensing galaxy, or in other galaxy halos, along the line of sight to the quasar images.


Since the identification of microlensing features in lensed quasar systems, there have been a number of attempts to demonstrate that these can be attributed to stars in the halo of the lensing galaxy and to put limits on any population of non-stellar compact bodies~@2009ApJ...706.1451M @2012ApJ...744..111P. Using a large sample of lensed quasar systems, a maximum likelihood analysis is used to estimate the most likely percentage of compact bodies in the galaxy halos, consistent with the observed microlensing statistics of the quasar images. The results of this type of analysis generally imply consistency of the observed microlensing with a halo population of compact bodies of about $10 "%"$, similar to the expected stellar component.


The problem with this approach is that the sample of gravitational lenses is dominated by systems where due to the configuration of the quasar and lens redshift and alignment, and the mass and compactness of the lensing galaxy, the quasar images lie deeply embedded in the stellar component of lensing galaxy. In these cases, there is no question that the observed microlensing can be attributed to the stellar population. There are however a few cases where the microlensed quasar images lie well outside the stellar distribution of the lensing galaxy, where the probability of microlensing by stars is negligible, and in this case the observed microlensing must be seen as the detection of a large population of non-stellar compact bodies. This point is in fact implicit in the separate analysis of the few wide-separation systems in the sample of Pooley #emph[et al.]~@2012ApJ...744..111P, but not commented upon by them. The issue is that in their sample of wide-separation lens systems, there is a much higher likelihood than in the sample as a whole that the dark matter component of the lensing galaxies is made up of compact objects~@Hawkins:2020zie.


In order to clarify this issue, a more direct approach was taken by Hawkins~@Hawkins:2020zie where, instead of treating the stellar population as a free parameter, the surface mass density in stars was measured from observations of the lensing galaxy, thus enabling a direct estimation of the probability of microlensing by the stellar population. The optical depth to microlensing $tau$ is given by: $ tau = kappa_(*) / ( 1 - kappa_(upright(c)) ) thin , $<eq:eqn1> where $kappa_(*)$ is the convergence due to the stars (the surface mass density in units of some appropriate critical density) and $kappa_(upright(c))$ is the convergence due to smoothly distributed dark matter, which for most lens systems is close to $0.5$ in the vicinity of the quasar images. Precise values can be obtained from mass modelling of the system. For large values of $tau$ a network of caustics is formed, resulting in a non-linear amplification pattern for the source, but for low values, $tau$ is effectively the probability that the quasar image will be significantly microlensed.


// [figvision-cn] imgs/Figure_12.png
// 子图类型：单幅散点图（带误差棒的曲线图）。图顶部居中标
// 注标题“Microlensing variations in J1004+4112”。 坐标轴：
// 纵轴（y轴）标签为“Δ mag”，表示星等差异（差值星等）。y
// 轴刻度从下到上依次为 1、0.5、0、−0.5、−1，即纵轴为反向
// 排列（数值由上向下递增，即上方为负、下方为正）。y轴的
// 主刻度间隔为0.5，次刻度间隔为0.1。Δ mag 的正负号在此图
// 中表示亮度变化方向，数值越负表示图像相对变亮。 横轴（x
// 轴）标签为“JD+2450000”，表示儒略日（Julian Date）加上2
// ,450,000后的时间坐标。x轴范围自约 2800 至 5000，主刻度
// 标注为 3000、3500、4000、4500、5000，主刻度间隔为500，
// 次刻度间隔为100。 数据点与符号： 图中共有9个数据点，均
// 为亮绿色实心圆点（带有细绿色垂直误差棒）。误差棒表示每
// 个差分星等测量值的1σ不确定度，误差棒长度约为±0.1 mag（
// 视具体点略有差异）。 数据点坐标（近似值，x: JD+2450000
// , y: Δ mag）： (2980, 0.45) (3190, 0.56) (3360, 0.40)
// (3560, 0.35) (3750, -0.27) (3970, 0.00) (4090, 0.13) (
// 4280, 0.15) (4460, -0.44) 另外在约 (4650, -0.48) 处有
// 一个数据点，实际上共约10个点；需仔细计数：图中有10个绿
// 色圆点，位于上述坐标附近，其中 (4650, -0.48) 点误差棒
// 极短，可能小于符号大小。 趋势与结论： 图中显示图像A与C
// 的差值星等随时间变化。从 JD+2450000≈3000 至 ≈3600，Δ
// mag 在0.35–0.56之间波动；在 JD≈3750 处出现一个明显的负
// 值（-0.27），随后在 JD≈3970 回到0.00，之后在 JD≈4090
// 与 4280 处回升至0.13–0.15；在 JD≈4460 与 4650 处又下降
// 至约-0.45至-0.48。整体趋势表明，A与C的亮度差异存在不可
// 忽略的时间变化，变化幅度约0.5–1.0 mag（从+0.56到-0.48，
// 总幅度约1.04 mag），且变化并非单调。根据图注参考，这种
// 差异变化被归因于微引力透镜效应（microlensing）。
#figure(placement: top, image("imgs/Figure_12.png", width: 72.0%),
  caption: [
    Difference light curve for images A and C of the gravitationally lensed quasar SDSS J1004+4112. The differential variations of the images are attributed to microlensing. From Ref.~@Hawkins:2020rqu.
  ]
)
<fig:fig3>



In order to test the possibility that in wide separation systems the observed microlensing can be attributed to the stellar population of the lensing galaxy, a sample of four of the widest separation lens systems was selected where the quasar images appeared to lie well clear of the distribution of star light~@Hawkins:2020zie. As for most gravitationally lensed quasars, the images in this sample were strongly microlensed, in the sense that photometric variations in the individual images were not correlated.


The first step was to measure the surface brightness profile of the lensing galaxy from deep #emph[Hubble Space Telescope] (HST) frames in the F160W infrared passband. The surface brightness was then converted to surface mass density using a mass-to-light ratio based on stars in globular clusters, where the mass can be measured directly from velocity dispersions. Working in the infrared made this step more straightforward than in optical bands, as the mass-to-light ratio for the F160W band is only weakly dependent on stellar type. The resulting values of $kappa_(*)$ were then combined with values for $kappa_(upright(c))$ to derive $tau$ from Eq.~(#ref(<eq:eqn1>)) and hence the probability of microlensing at the positions of the quasar images. The result of this analysis~@Hawkins:2020zie is that any individual quasar image has a probability of $tilde 0.05$ of being microlensed by the stellar population of the lensing galaxy. This probability is confirmed by computer simulations where non-linear effects and the amplitude of the light curves are taken into account. The simulations also show that the combined probability of the observed microlensing is of order $10^(- 4)$~@Hawkins:2020zie.


Although for most quasar gravitational lens systems, the lens is a massive early type galaxy, where the image separation is typically less than $3 thin$arcsec, there is one well known example (SDSS J1004+4112) of a quadruple system where the lens is a massive cluster, with a central dominant galaxy together with a number of smaller galaxies. The separation of the quasar images is $16 thin$arcsec, putting them well clear of any detectable starlight, but the most striking feature is that the images are strongly microlensed. @fig:fig3 shows the difference light curve for two of the quasar images. The amplitude of variation is more than a magnitude, which is very large for any known quasar system, and raises the question of the identity of the lenses.


// [figvision-cn] imgs/Figure_13.png
// 这是一张单面板的二维曲线图，展示的是引力透镜星系团
// J1004+4112 的收敛度（Convergence，即光学深度）随径向距
// 离的变化关系，用于比较总质量模型与恒星成分的径向分布。
// 图的顶部标题为“Convergence in J1004+4112”。横轴标签为“
// Radial Distance (kpc)”，即径向距离，单位为千秒差距（
// kpc），范围从 0 到 70 左右，主刻度标注为 0、20、40、60，
// 主刻度之间有表示中间值的次刻度。纵轴标签为“Convergence
// ”，即收敛度，范围从 0 到 1，主刻度标注为 0、0.5、1，同
// 样带有次刻度。纵轴在 0 处有一条贯穿全图的水平实线基线。
// 图中有两种数据表示方式。第一种是连续实线，代表透镜模型
// 给出的总收敛度。该曲线从横轴约 30 kpc 处（纵轴数值超过
// 1，超出绘图范围）开始向下延伸，随着径向距离增大而单调
// 平滑下降；在 30 kpc 处纵值约为 1.0，在 40 kpc 处约为
// 0.65，在 50 kpc 处约为 0.52，在 60 kpc 处约为 0.45，到
// 70 kpc 处约为 0.40。第二种是黑色实心圆点，代表透镜星系
// 团中恒星成分的收敛度。这些点在径向距离小于 2 kpc 处纵
// 值最高，约为 0.55；随后在 0 到 10 kpc 之间急剧下降并形
// 成类似 1/r 的陡峭衰减曲线，在 10 kpc 处降至约 0.07；在
// 10 到 20 kpc 之间缓慢降至约 0.02；在 20 kpc 之外，数据
// 点基本贴近基线零值，仅存在由测量噪声引起的、幅度小于
// 0.01 的微小波动。可以明显看出，恒星成分的收敛度随半径
// 的衰减远快于总收敛度，且在超过约 10 kpc 后，恒星成分对
// 总收敛度的贡献几乎可以忽略。 图右侧区域标出了三个类星
// 体图像的位置，用向下的箭头和字母标注。字母“A”位于横轴
// 约 59 kpc、纵轴约 0.32 处，其正下方约 0.26 处有一个向
// 下箭头；字母“B”位于横轴约 60 kpc、纵轴约 0.27 处，其正
// 下方约 0.21 处有一个向下箭头；字母“C”位于横轴约 69 kpc、
// 纵轴约 0.28 处，其正下方约 0.21 处有一个向下箭头。这些
// 箭头指示了类星体图像在径向上的投影位置，对应横轴约 59
// kpc、60 kpc 和 69 kpc。
#figure(placement: top, image("imgs/Figure_13.png", width: 72.0%),
  caption: [
    Convergence as a function of radial distance for the lensing cluster J1004+4112. The solid line shows the total convergence $kappa$ (i.e.~the optical depth $tau$) from the lensing model and the filled circles show convergence $kappa_(*)$ for the stellar population of the lensing cluster. The arrows indicate the positions of the quasar images. From Ref.~@Hawkins:2020rqu.
  ]
)
<fig:fig4>



@fig:fig4 shows the relation between $kappa_(*)$ or $tau$ and the radial distance from the cluster centre, constructed as described above for galaxy lenses. It can be seen that the optical depth to microlensing from stars is effectively negligible beyond $25 thin$kpc from the cluster centre. The overall configuration is illustrated in @fig:fig5, showing the cluster galaxies from an HST frame in the F160W passband, close to the infrared $H$-band. The quasar images are visible as part of arcs centred on the cluster. The yellow circle has a radius of $25 thin$kpc and shows the point at which convergence from starlight becomes negligible, as illustrated in @fig:fig5. The whole analysis is described in detail in Ref.~@Hawkins:2020rqu, including the investigation of the possibility of the chance superposition of a small cluster galaxy exactly in the position of one of the quasar images. The overall conclusion of this work is that the probability that the observed microlensing of the quasar images can be attributed to stars is less than $10^(- 4)$.


// [figvision-cn] imgs/Figure_14.png
// 这是一幅单幅天文显微/深空成像图，属于伪彩色强度图，用
// 于展示星系团 J1004+4112 周围透镜类星体图像区域的深空观
// 测结果。该图无子图划分，主体为一张接近方形的图像，边长
// 约数十角秒（依据图注推测为数十角秒量级），成像波段为哈
// 勃空间望远镜（HST）的 F160W 滤光片（近红外波段，接近 H
// 波段）。图像采用伪彩色映射表示光子通量强度：深蓝色背景
// 代表低强度/背景噪声，绿色为中等强度，黄色至红色为高强
// 度核心区域。图中没有明确的坐标轴刻度或色标条，但颜色渐
// 变直观反映了表面亮度的空间分布。 图像中央偏左位置有一
// 个显著的黄色圆圈，直径覆盖图像中心区域，其含义是标示星
// 系团中心星系（最亮中心星系，BCG）的星光在此半径处淹没
// 于背景噪声中，对应物理尺度约为千秒差距（kpc）量级。圆
// 圈内部中心是一个明亮的椭圆状天体，核心呈黄红色，周围有
// 绿色晕，代表星系团中心星系的光度分布。在圆圈内部右下方，
// 紧邻中心星系，有一个较小的黄绿色点状源，这是透镜类星体
// 图像之一。在圆圈外部右侧，有一个明亮的黄绿色点状源，同
// 样属于透镜类星体图像。 图像中散布着多个其他天体：左上
// 角有一个明亮的黄绿色椭圆星系；右上角有一个带绿色晕的黄
// 色点源；左侧边缘有一个拉长的黄绿色星系，呈斜向分布；左
// 下角有一个明亮的黄绿色点源；底部边缘有一个拉长的黄绿色
// 星系；右下角有一个明亮的黄绿色点源。此外，图像中还有若
// 干微弱的绿色小点源，散布在背景中。所有天体均无文字标注，
// 仅通过颜色和形态区分。该图传达的核心信息是：在 F160W
// 波段下，中心星系的光度分布延伸至千秒差距尺度，而透镜类
// 星体图像位于中心星系周围，背景噪声限制了中心星系外围微
// 弱星光的探测。
#figure(placement: top, image("imgs/Figure_14.png", width: 72.0%),
  caption: [
    Deep HST frame of the area around the lensed quasar images of the cluster J1004+4112, in the photometric passband F160W, close to the $H$ band. The frame is approximately $15 thin$arcsec on a side. The yellow circle defines the point at which starlight from the central cluster galaxy is lost in the background noise at $25 thin$kpc. From Ref.~@Hawkins:2020rqu.
  ]
)
<fig:fig5>



The only way to account for the observed microlensing of the quasar images in SDSS J1004+4112 is to invoke a cosmological distribution of solar-mass compact bodies. For a number of reasons summarised in Ref.~@Hawkins:2020zie, these bodies can only be PBHs making up a significant fraction of the dark matter. This would appear to be a clear detection of solar-mass PBHs.


// [figvision-cn] imgs/Figure_15.png
// 这是一张单幅科学曲线图，图上方居中标注文字“Lens Mass =
// 0.3M_⊙”，其中M_⊙表示太阳质量，说明该图对应透镜质量为
// 0.3倍太阳质量的情形。横轴标注为Δm，表示星等变化量，横
// 轴范围从0到3，主刻度标注为0、1、2、3，并在主刻度之间设
// 有次级刻度（对应0.5间隔），未标注单位（星等）。纵轴标
// 注为“P(Δm)”，表示累积概率，纵轴范围从0到1，主刻度标注
// 为0、0.2、0.4、0.6、0.8、1，并在主刻度之间设有次级刻度
// （对应0.1间隔）。图中有两条曲线：黑色曲线表示观测数据
// （1033个来自Field 287巡天样本的类星体，变化超过给定星
// 等Δm的累积概率），红色曲线表示由对数正态内禀变化与微引
// 力透镜放大共同组合而成的模型累积概率，模型假设类星体盘
// 半径为若干光日。两条曲线均从Δm≈0.2处（概率接近1）开始，
// 随Δm增大单调下降，在Δm≈1处概率约为0.3–0.35，在Δm≈1.5处
// 概率降至约0.05，在Δm≈2处趋于0。红线与黑线形状高度一致：
// 在低Δm端（约0.2–0.7）红线略低于黑线，在中等Δm（约0.8–
// 1.3）红线略高于黑线，整体偏差很小，表明模型与数据吻合
// 良好。该图传达的趋势是：类星体样本的星等变化累积概率随
// Δm增大而迅速衰减，且内禀变化加微引力透镜的模型能较好地
// 重现观测到的累积分布。
#figure(placement: top, image("imgs/Figure_15.png", width: 80.0%),
  caption: [
    Cumulative probability $P ( Delta m )$ that a source varies by more than $Delta m$ magnitudes for the sample of 1033 quasars from the Field 287 survey for lens mass $0.3 thin M_⊙$. The black curve represents the data, and the red curve shows the cumulative probability for a combination of lognormal intrinsic variation and microlensing amplification, assuming a quasar disc radius of $4$ light-days. From Ref.~@2022MNRAS.tmp..849H.
  ]
)
<fig:fig6b>



== Cosmological Distribution of Primordial Black Holes
<sec:Cosmological-Distribution-of-Primordial-Black-Holes>


The detection of a significant population of PBHs in the halo of the Milky Way and more distant galaxies and clusters suggests that these objects might also betray their presence by microlensing the light from quasars with a cosmological distribution. The detection of caustic crossings discussed in sub@sec:Caustic-Crossings-of-Quasars supports this possibility, but the idea of putting limits on dark matter by comparing the expected microlensing amplifications with observed quasar amplitudes was first suggested by Schneider@1993AandA...279....1S, some $30 thin$years ago. He found that assuming a point source for the quasar light, the expected variation due to microlensing far exceeded the observed amplitudes for plausible values of lens mass and lens density $Omega_(upright(L))$. Subsequent work@2003AandA...399...23Z showed that for more realistic values of the quasar disc size, the simulated microlensing amplitudes put no meaningful constraint on $Omega_(upright(L))$. The main drawback with this approach is the unknown contribution of intrinsic variations to the microlensing amplifications.


In a recent paper~@2022MNRAS.tmp..849H, the problem of modelling intrinsic quasar variations has been addressed by using luminous quasars where the accretion disc is too large to be significantly microlensed as a template for changes in quasar luminosity. The idea was to simulate the intrinsic variations in luminosity for a large sample of quasars and to apply the amplifications expected for a dark matter component of stellar-mass compact bodies, and then to compare the resulting distribution in amplitudes with the observed distribution from the quasar sample. The optical depth to microlensing was calculated from the redshift of each quasar in a standard $Lambda$CDM cosmology. Other input parameters, such as the size of the quasar accretion disc and the mass of the lenses, were not optimised but taken from independent and unrelated measurements in the literature. The quasar sample for comparison with the observations comprised 1033 with blue-band lightcurves covering $26 thin$years from the UK $1.2 thin$m Schmidt telescope@10.1046-j.1365-8711.2003.06828.x, and covering a wide range of luminosity and redshift.


@fig:fig6b shows the result of repeating Schneider's original test with the new large sample and modelling the intrinsic changes in quasar brightness. The black line shows the cumulative probability of quasar amplitudes from the observed quasar light curves. The red line shows a similar curve for the combination of intrinsic luminosity changes amplified by the expected effects of microlensing due to the optical depth corresponding to each quasar redshift. The parameters of the simulations as described above are not fitted to the data but independently measured, with the result that to understand the distribution of quasar amplitudes it is necessary to include the microlensing effects of a cosmologically-distributed population of stellar-mass compact bodies. These bodies must make up a significant fraction of the dark matter and are most plausibly identified as PBHs.


== Galaxy-Galaxy Strong Lensing
<sec:Galaxy--Galaxy-Strong-Lensing>


Meneghetti #emph[et al.]~@Meneghetti:2020yif have recently investigated the probability of strong lensing events produced by dark matter substructure using HST data for eleven galaxy clusters. As an example, @fig:HST-GGSL shows a colour-composite image of the galaxy cluster MACSJ1206, together with several of its critical lines, which indicate the boundaries of the inner regions of the cluster near which the most dramatically distorted gravitational arcs occur. This implies significantly more substructure than expected. Indeed, all studied galaxy clusters show an order of magnitude more substructures than predicted by standard CDM simulations (c.f.~@fig:HST-Number-Of-Clusters-Comparison). Either systematic issues with simulations or incorrect assumptions about the properties of dark matter could explain these findings.


In contrast to the solutions to other well-known issues, like the "missing satellite"~@1999ApJ...524L..19M @Klypin:1999uc, "cusp-core"~@Flores:1994gz, and "too-big-to-fail" problems~@Boylan-Kolchin:2009ztl @Boylan-Kolchin:2011qkt, or discrepancies with planes of satellite galaxies~@Muller:2018hks, which require that observed small satellite galaxies are fewer in number and less dense than expected, the excess in dark matter clumps discussed above requires that subhalos are #emph[more] concentrated than predicted by simulations. Strikingly, the clustering of PBHs induced by an extended mass function of the form imprinted by the thermal history of the Universe~@Carr:2019kxo #emph[predicts] the required excess of compact dark substructures. Furthermore, this scenario can address a related issue recently pointed out by Safarzadeh & Loeb~@2021arXiv210703478S. They found that several Milky Way satellites, in particular #emph[Horologium I] and #emph[Tucana II], are too dense, leading to the conclusion that the formation masses and redshifts of CDM halos are incompatible with their being satellites. These "too-dense-to-be-satellite systems" can easily be accounted for by clustered PBHs with an extended mass function.


// [figvision-cn] imgs/Figure_16.png
// 这是一张由哈勃空间望远镜（HST）拍摄的星系团 MACSJ1206
// 中心区域的合成伪彩色图像，图中包含一个主视场（A）和三
// 个放大的子图（B、C、D）。图像整体呈深蓝色/黑色背景，散
// 布着大量天体。 主视场（A）： 这是一张覆盖约数角分的天
// 文合成图像。水平横轴为赤经（Right Ascension, J2000），
// 从左至右由 18s 递减至 12h06m06s；垂直纵轴为赤纬（
// Declination, J2000），从下至上由 49' 递减至 -8°47'。背
// 景中可见许多呈现黄色、橙色、白色的椭圆星系和点状恒星，
// 图像左下角和右下角区域分布着一些绿色（可能为滤光片通道
// 中的伪彩色）的亮天体。图中央有一个巨大的、不规则的白色
// 实线轮廓，呈南北向拉长、中心向内凹陷的形态。实线轮廓内
// 部有一条白色的虚线轮廓，形状更为紧凑，近似椭圆。这些白
// 线描绘了该星系团在特定源红移处的临界线（critical lines），
// 虚线对应源红移 \(z_s = 4.996\)，实线对应 \(z_s = 1.425
// \)。图中央偏右有一对明亮的黄色星系，被多个同心圆弧状结
// 构包围。 子图（B）： 位于主图右上角，是主视场东北方向
// 一个天体的放大图。该图是伪彩色合成图像，背景呈现斑驳的
// 橙黄色和暗紫色。图中央有一个明亮的白色/黄色点源，其周
// 围环绕一个近乎完整的、明亮的蓝色弧形结构（典型的引力透
// 镜弧）。弧的形态呈现一个接近闭合的环（爱因斯坦环），环
// 的左侧和下方略亮。图上叠加了一个白色的闭合曲线，形状略
// 扁，包围了中心亮源和部分弧结构。图内左下角标注白色文字
// “\(z_s = 1.425\)”。一条黑色的细线将子图（B）的边框与主
// 视场（A）中一个暗弱的方形区域相连，指示其位置。 子图（
// C）： 位于主图左上角，是主视场西北方向一个天体的放大图。
// 背景呈暗紫色和绿色。中央可见两个明亮的黄色点源，排列成
// 近南北向。围绕这两个点源，有数个同心、不规则的白色闭合
// 曲线叠加其上，形状略呈椭圆，长轴呈南北向。在同心曲线外
// 围，有一条呈“C”形的蓝色弧线从上方包围中央两个亮源。图
// 内左下角标注白色文字“\(z_s = 4.996\)”。一条黑色细线将
// 子图（C）的边框与主视场（A）中西北部的一个暗弱区域相连。
// 子图（D）： 位于主图左下角，是主视场西南方向一个天体的
// 放大图。背景呈暗紫色，带有红色斑点。中央可见两个明亮的
// 黄色/白色点源，水平排列。围绕这两个点源，有一条白色的、
// 类似“8”字形的双瓣闭合曲线，每个瓣分别包裹一个点源，在
// 中间区域相切或靠近。在外围，可见一条较暗的蓝色弧线从上
// 方掠过。图内左下角标注白色文字“\(z_s = 3.753\)”。一条
// 黑色细线将子图（D）的边框与主视场（A）中西南部一个暗弱
// 区域相连。 整体结论：该复合图像展示了星系团 MACSJ1206
// 的强引力透镜效应，通过白色实线和虚线标出了不同源红移（
// 1.425 和 4.996）下的临界线位置，并详细放大了三个星系-
// 星系强透镜事件（B、C、D），分别对应源红移 1.425、4.996
// 和 3.753 的透镜弧或多重像结构。
#figure(placement: top, image("imgs/Figure_16.png", width: 77.0%),
  caption: [
    Composite HST image of the central region of the galaxy cluster MACSJ1206, where the critical lines of the cluster at source redshifts of $1$ and $7$ are indicated with dashed and solid lines, respectively. The panels (B), (C), and (D) zoom into three galaxy-galaxy strong lensing events. From Ref.~@Meneghetti:2020yif.
  ]
)
<fig:HST-GGSL>



// [figvision-cn] imgs/Figure_17.png
// 这是一张单面板曲线图，展示星系-星系强引力透镜概率随源
// 红移的变化。横轴标注为 z_S，表示源红移，范围从约 0.5
// 到 7，主刻度位于 1、2、3、4、5、6、7。纵轴标注为 GGSL
// probability [10^-6]，采用对数坐标，主刻度为 10.0、
// 100.0、1000.0，范围约从 10 到 2000×10^-6。图例位于右下
// 角，包含四项：深蓝色实线 Ref. sample、浅蓝色点划线
// Frontier Fields、紫色点线 CLASH "Gold"、橙色虚线
// Simulations。所有观测曲线均被同色半透明阴影带包围，代
// 表置信区间（CL）；模拟曲线同样带橙色半透明阴影带。图中
// 没有显式标注的数值标签或额外符号。 趋势上，四条曲线均
// 随 z_S 增加而上升并逐渐趋于平缓饱和。深蓝实线从 z_S≈
// 0.6 处约 60×10^-6 开始，在 z_S≈3 附近升至约 600×10^-6，
// 随后缓慢上升，在 z_S=7 处略低于 1000×10^-6。浅蓝点划线
// 在低红移端与深蓝实线接近，在 z_S≈2.5 附近达到约 900×10
// ^-6，其后基本持平并在 z_S>4 后略降至约 800×10^-6。紫色
// 点线整体偏低，从 z_S≈0.6 处约 30×10^-6 升至 z_S≈4 处约
// 500×10^-6，之后基本平稳。观测样本的阴影带在 z_S≈1.5–3
// 区间较宽，反映该处不确定性较大。橙色虚线显著低于观测曲
// 线，在 z_S≈1.5 处约 15×10^-6，随红移缓慢上升，至 z_S=7
// 时约为 40×10^-6，其阴影带下界在 z_S<1.5 时低于纵轴下限。
// 总体结论是：观测到的 GGSL 概率随源红移升高而增加并饱和，
// 但参考样本与 Frontier Fields、CLASH "Gold" 之间存在系
// 统差异，且所有观测结果均明显高于模拟结果（橙色虚线），
// 模拟值约低一个数量级。
#figure(placement: top, image("imgs/Figure_17.png", width: 72.0%),
  caption: [
    Mean observed galaxy-galaxy strong lensing (GGSL) probability (solid blue line) based on three reference samples (coloured bands show the $99.9 "%"$ CL) versus median simulation results (orange line). From Ref.~@Meneghetti:2020yif.
  ]
)
<fig:HST-Number-Of-Clusters-Comparison>



== Identity of Lenses
<sec:Identity-of-Lenses>


If dark matter is indeed made up of compact bodies, then there are several strong constraints on the form it can take. Combining measurements of light element abundances with the photon density from the CMB gives a fairly robust limit of $Omega_(upright(b)) < 0.03$~@1993ApJS...85..219S which effectively rules out baryonic objects as dark matter candidates. This of course includes stars and planets as well as later products of stellar evolution such as white dwarfs, neutron stars and stellar black holes. A second constraint comes from the timescale of microlensing events, which constitute much of the evidence for compact bodies as dark matter. Both the MACHO events in the Milky Way halo and the microlensing events observed in multiple quasar systems of the type discussed here point to a lens mass of around a solar mass, with an uncertainty of at least a factor of $10$ either way. This is nonetheless sufficient to rule out a wide range of candidates, which we discuss below. A final constraint is compactness. Again, since much of the evidence for a cosmological distribution of compact bodies comes from microlensing, dark matter bodies must be compact enough to act as lenses in the configuration in which they are observed.


In many respects, stars are the most obvious candidates for the microlenses, and in a review of baryonic dark matter, Carr~@Carr:1994ci discusses the plausibility of various stellar populations acting as lenses. This is relevant to the microlensing observations described in this paper, as a major issue is the possibility that a significant fraction of the lenses might be stars. In her review of the nature of dark matter, Trimble~@Trimble:1987ee lists quark nuggets, cosmic strings and PBHs as non-baryonic non-particle candidates. Quark nuggets have some virtue as dark matter candidates~@Alam:1997ij, and the basic idea has been generalised in a number of ways~@Jacobs:2014yca, but as their mass is limited to around $10^(- 8) thin M_⊙$, they cannot be the objects detected in the microlensing experiments. This low-mass constraint also applies to other classes of compact dark matter objects such as #emph[N]-MACHOs~@Dvali:2019ewm. Another recent paper~@Fujikura:2021omw has investigated the possibility that boson stars might contribute to the dark matter in the Milky Way halo, but the problem here is that such objects are predicted to be insufficiently compact to microlens solar-mass stars. The possibility that cosmic strings might betray their presence by the microlensing of distant quasars has been investigated in some detail by Kuijken #emph[et al].~@2008MNRAS.384..161K. Their motivation is to establish a method for detecting the presence of cosmic strings, and they estimate that a typical microlensing event would last about $20$ years. This fits in well with other microlensing signatures, but the problem they face is that such events would be extremely rare. The optical depth to microlensing for cosmic strings derived in Ref.~@2008MNRAS.384..161K is of the order $tau tilde 10^(- 8)$ which completely rules them out as the source of the microlensing seen in multiple quasar systems.


An interesting idea proposed by Walker & Wardle~@1998ApJ...498L.125W suggesting that extreme radio scattering events might be caused by cold self-gravitating gas clouds has been investigated by Rafikov & Draine~@2001ApJ...547..207R with a view to establishing whether such clouds could be detected by microlensing searches. The clouds are predicted to have masses of around $10^(- 3) thin M_⊙$ and radii of $tilde 10 thin$AU, and would make up a significant fraction of the mass in galaxy halos. Reference~@2001ApJ...547..207R concluded that although strongly constrained by MACHO microlensing searches, such clouds could not be definitively ruled out as the dark matter component of the Milky Way halo. However, as an explanation for the microlensing seen in multiple quasar systems they can be ruled out on the basis of their low proposed mass, and also the fact that they are essentially baryonic and so cannot make up the dark matter on cosmological scales.


The steady improvement in numerical simulations of the formation of large-scale structure from primordial perturbations culminating in the discovery of a universal profile for dark matter halos~@1996ApJ...462..563N has raised the question of the nature of their internal structure on small scales. An ambitious programme to solve this problem was undertaken by the #emph[Aquarius Project]~@2008MNRAS.391.1685S which focussed on simulating the evolution of individual galaxy halos with unprecedented resolution. The two main results of this and other similar simulations were that galaxy halos have cuspy dark matter profiles, and that there should be a very large population of dark matter subhalos. In their largest simulation they resolve nearly $300 , 000$ gravitationally bound subhalos within the virialised region of the halo. At first sight these subhalos might seem attractive candidates for microlensing quasars, but their structure as described in Ref.~@2008MNRAS.391.1685S imply that they would not be compact enough to act as microlenses for the accretion discs of distant quasars, even if subhalos as small as a solar mass can form. The objects which have received the most attention as candidates for dark matter in the form of compact bodies are PBHs. They satisfy the basic constraints mentioned above in that they are non-baryonic, very compact and can in principle form over a wide range of masses, including those relevant to quasar microlensing, and as things stand they appear to be the only plausible candidates for dark matter in the form of compact bodies.


= Dynamical and Accretion Evidence
<sec:Dynamical-and-Accretion-Evidence>


In this section we consider a number of constraints and signatures related to dynamical and accretion effects. Numerous dynamical effects were discussed in Ref.~@Carr:1997cn, these being associated with the heating of galactic disks~@1985ApJ...299..633L, effects on dwarf galaxies~@2017PhRvL.119d1102K, triggering of white dwarf explosions~@2015PhRvD..92f3007G, disruption of wide binaries~@1985ApJ...290...15B @1987ApJ...312..367W @Monroy-Rodriguez:2014ula and globular clusters~@1993ApJ...413L..93M and star clusters~@2016ApJ...824L..31B, capture of PBHs by white dwarfs and neutron stars~@Capela:2014qea @2014JCAP...06..026P, dynamical friction effect of spheroid stars~@Carr:1997cn, tidal distortions in galaxies~@1969Natur.224..891V and the CMB dipole anisotropy~@Carr:1997cn. Many of them involve the heating or destruction of astronomical systems by the passage of nearby PBHs. If the PBHs have density $rho$ and velocity dispersion $V$, while the systems have mass $M_(upright(c))$, radius $R_(upright(c))$, velocity dispersion $V_(upright(c))$ and survival time $t_(upright(L))$, then the constraint has the form~@Carr:1997cn $ f_(upright("PBH")) ( M ) < \
  cases(delim: "{", M_(upright(c)) thin V / ( G thin M rho thin t_(upright(L)) thin R_(upright(c)) ) & \[ M < M_(upright(c)) thin ( V / V_(upright(c)) ) \], M_(upright(c)) / ( rho thin V_(upright(c)) thin t_(upright(L)) thin R_(upright(c))^2 ) & \[ M_(upright(c)) thin ( V / V_(upright(c)) ) < M < M_(upright(c)) thin ( V / V_(upright(c)) )^3 \], frac(M thin V_(upright(c))^2, rho thin R_(upright(c))^2 thin V^3 thin t_(upright(L))) thin exp thin \[ ( M / M_(upright(c)) ) ( V_(upright(c)) / V )^3 \] thin & \[ M > M_(upright(c)) thin ( V / V_(upright(c)) )^3 \] thin .) $<eq:carsaklim> The three limits correspond to disruption by multiple encounters, one-off encounters and non-impulsive encounters, respectively. These are all potential signatures of PBHs but we just focus below on the three effects for which positive evidence has been claimed. These come from the heating of the Galactic disk, features of UFDGs, the cusp/core problem for dwarf galaxies, recent observations by JWST of galaxies at higher redshift than allowed by standard galaxy formation models, and the triggering of white-dwarf explosions.


There are also many constraints and possible signatures for PBHs resulting from their accretion luminosity. These are associated with point source observations for individual PBHs~@2017JCAP...10..034I @2017PhRvL.118x1101G @2019JCAP...06..026M and with the generation of cosmic background radiation~@1980Natur.284..326C and effects on the thermal history of the Universe for a population of PBHs@10.1093-mnras-194.3.639. The signatures all depend upon astrophysical assumptions and on the black hole environment (gas density and temperature), so there is inevitably some uncertainty. If the PBHs reside in galactic nuclei or halos, they will accrete local gas and stars. If they reside outside galaxies, they will still accrete intergalactic gas, the consequences of which depend on the (somewhat uncertain) state of the intergalactic medium. There are also #emph[indirect] constraints associated with the $mu$-distortions in the CMB spectrum associated with the dissipation by Silk damping of the density fluctuations invoked to generate PBHs~@Chluba:2012we @Kohri:2014lza @2018PhRvD..97d3525N @2019JCAP...06..028B. Although all these effects are usually presented as constraints, clearly they are also potential signatures. The positive accretion evidence comes from the existence of SMBHs in galactic nuclei, the spatial coherence of the X-ray and infrared source-subtracted backgrounds, this requiring the existence of bound baryon clouds earlier than expected in the standard scenario but as predicted by the Poisson effect, and a radio background. Finally PBHs may accrete dark matter in some period, this being relevant to the considerations of @sec:Mixed-Dark-Matter.


Some of these points have also been made by Silk, who argues that intermediate-mass PBHs could be ubiquitous in early dwarf galaxies, being mostly passive today but active in their gas-rich past~@Silk:2017yai. This would be allowed by current active galactic nuclei observations~@2013ARAA..51..511K @2016ApJ...831..203P @Baldassare:2016cox and early feedback from intermediate-mass PBHs could provide a unified explanation for many dwarf galaxy anomalies~@2018PDU....22..137C. Besides providing a phase of early galaxy formation and seeds for SMBHs at high redshift, they could: (1) suppress the number of luminous dwarfs; (2) generate cores in dwarfs by dynamical heating; (3) resolve the "too big to fail" problem; (4) create bulgeless disks; (5) form UFDGs and ultra-diffuse galaxies; (6) reduce the baryon fraction in Milky-Way-type galaxies; (7) explain ultra-luminous X-ray sources in the outskirts of galaxies; (8) trigger star formation in dwarfs via active galactic nuclei. They would also induce microlensing of extended radio sources~@Inoue:2003hq @Inoue:2013ey.


== Dynamical Heating of the Milky Way Disk
<sec:Dynamical-Heating-of-the-Milky-Way-Disk>


As halo objects traverse the Galactic disk, they will impart energy to the stars there. This will lead to a gradual puffing up of the disk, with older stars being heated more than younger ones. This problem was first studied by Lacey~@1984ASIC..117..351L in the context of a very general analysis of disk-heating and then by Lacey & Ostriker~@1985ApJ...299..633L, who argued that SMBHs could generate the observed disk-puffing if they provide the dark matter ($f_"PBH" tilde 1$). In particular, they claimed that this could explain: (1) why the velocity dispersion of disc stars $sigma$ scales with age as $t^(1 / 2)$\; (2) the relative velocity dispersions in the radial, azimuthal and vertical directions; and (3) the existence of a high-energy tail of stars with large velocity (c.f.~Ipser & Semenzato@1985AandA...149..408I). In order to normalise the $sigma ( t )$ relationship correctly, the number density $n$ of the holes must satisfy $n thin M^2 approx 2 times 10^4 thin M_⊙^2 thin "pc"^(- 3)$. Combining this with the local halo density, $rho_(upright(H)) = n thin M approx 0.01 thin M_⊙ thin "pc"^(- 3)$, then gives $M approx 2 times 10^6 thin M_⊙$. Wielen & Fuchs~@1988LNP...306..100W claimed that black hole heating could also explain the dependence of the velocity dispersion upon Galactocentric distance. If some other mechanism explains disc heating, these arguments still give an upper limit on the fraction of dark matter in black holes: $ f_(upright("PBH")) ( M ) < ( M / 10^6 thin M_⊙ )^(- 1) thin . $ For example, this would apply if the heating were due to giant molecular clouds, which is the more mainstream explanation.


Although disc heating can no longer be attributed to such large black holes, because this is now excluded by other constraints, Carr & Lacey pointed out that it may still provide evidence for clusters of much smaller PBHs~@1987ApJ...316...23C. Indeed, since PBH clusters with mass close to the value of $10^6 thin M_⊙$ required for disc heating are #emph[expected] to form (see @sec:Clustering-of-PBHs), this might be regarded as a prediction if PBHs provide the dark matter. The stellar velocity change in close encounters is smaller in the cluster case because of the finite size of the clusters but most of the disc heating comes from distant encounters anyway. However, scattering off the clusters can only produce the high-velocity disc stars with $v > 100 thin$km s$""^(- 1)$ if $r_(upright(c)) < 0.5 thin ( M_(upright(c)) / 10^6 thin M_⊙ ) thin "pc"$, and the associated constraint is shown by the red region in @fig:rcvsmc.


== Dynamical Heating of Ultra-Faint Dwarf Galaxies
<sec:Dynamical-Heating-of-Ultra--Faint-Dwarf-Galaxies>


UFDGs have been used to constrain the PBH abundance~@2020MNRAS.492.5247S. This requires $f_"PBH" < 1$ for $M gt.tilde 10 thin M_⊙$, with the precise limit depending on model assumptions and the possible effect of an intermediate-mass black hole (IMBH) at their centre. It was suggested in Ref.~@2018PDU....22..137C that the argument could be reversed, with the observed critical radius and mass of UFDGs indicating that a large fraction of dark matter comprises stellar-mass compact objects. Although Ref.~@2020MNRAS.492.5247S claims that this is excluded, the presence of Poisson-induced clusters was not allowed for.


@fig:rcvsmc shows the most likely half-light radius and mass of recently observed UFDGs, using the tables of Ref.@2019ARAandA..57..375S and the virial theorem to obtain the mass from the stellar velocity dispersion. Comparison with the predicted relation between between $r_(upright(c))$ and $M_(upright(c))$ supports the model providing $f_"PBH" thin M$ does not deviate much from our favoured value of $3 thin M_⊙$\; the $0.3 thin M_⊙$ and $30 thin M_⊙$ cases are represented in the figure. In addition, the critical radius and mass match the ones obtained from the dynamical heating effect. This was first noted in Ref.~@2018PDU....22..137C, which also pointed out that the large mass-to-light ratios observed in UFDGs could be explained by a rapid PBH accretion phase after the formation of the clusters. Furthermore, the Galactocentric distances of the UFDGs are sufficiently large for them to evade the limits from collisional disruption, the Galactic tidal field and disc heating.


== Cusp/Core Problem
#<sec:Cusp-Core-Problem>


$N$-body simulations in the standard $Lambda$CDM scenario yield galactic halos with central cusps~@Navarro:1996gj, contradicting observations of dwarf galaxies with central cores~@deBlok:2009sp. One resolution of this problem is to invoke stellar feedback --- since this redistributes gas clouds, generates bulk motions and galactic winds --- or reheating by dynamical friction of massive clumps~@Boldrini:2019isx. Another is to include dark matter self-interaction~@Vogelsberger:2015gpr @Cyr-Racine:2015ihg, this leading to cored halo profiles for sufficiently large cross-sections.


Boldrini #emph[et al.]~@Boldrini:2019isx have used an $N$-body code to explore an alternative explanation, which involves a galactic halo comprising both particles and PBHs. As a specific example, they consider $10^7 thin M_⊙$ dwarf galaxies with PBHs in the mass window $25 thin "–" thin 100 thin M_⊙$. They find that cores can form as a result of dynamical heating of the CDM through PBH infall and two-body processes, providing PBHs provide at least $1 "%"$ of the non-baryonic halo. The halo shape depends upon the PBH mass distribution, this being subject to mass segregation, PBH mergers, possible slingshotting of light PBHs, and PBH interactions with the central black hole. This may resolve the cusp/core problem.


In the context of the Milky Way, the observed rotation curve near the centre indicates the presence of a supermassive central black hole of $4 times 10^6 thin M_⊙$ and a ring of dark matter at a distance of about $100 thin$pc with the usual $r^(- 2)$ fall-off at larger distances. These features are predicted by detailed numerical simulations of PBHs in the central region of an all-black-hole halo~@2021Univ....7...18T. Because the PBHs scatter off each other and the central SMBH, they accumulate in a ring around the centre~@Garcia-Bellido:2022fgh and the density profile has a hill at a distance of about $100 thin$pc for a galaxy like our own and $10 thin$pc for dwarf galaxies. This configuration could be transitory but it currently seems universal for all sizes of galaxies and halos. The profile looks like a core at large distances, so one needs more precise observations of rotation curves in the inner parts of galaxies to test the model~@Calcino:2018mwh. Note that several IMBHs have been observed in the central molecular zone around the Galactic Centre~@2020ApJ...890..167T, which could could be interpreted as a subpopulation of massive PBH that have migrated to the centre of our Milky Way due to dynamical friction.


== Primordial Black Holes as Seeds for Quasars and Galaxies
<sec:Primordial-Black-Holes-as-Seeds-for-Quasars-and-Galaxies>


The mainstream view is that the $10^6 thin "–" thin 10^10 thin M_⊙$ black holes in galactic nuclei form from dynamical processes #emph[after] galaxies, but this proposal is becoming increasingly challenged by the high mass and redshift of some SMBHs. This has led to the suggestion that the SMBHs could form #emph[before] galaxies, in which case they may have been seeded by PBHs. In this subsection the mass of the PBH is denoted by $m$, so for a monochromatic PBH mass function with $f_"PBH" < m / M$ (i.e.~only one PBH per bound region of mass $M$), Eq.~(#ref(<eq:initial>)) and the growth law $delta prop ( 1 + z )^(- 1)$ imply that the mass bound by a seed could exceed the seed mass by a factor of $10^3$ at the redshift $z tilde 4$ when SMBHs are observed. For example, the softening of the pressure through $e^(+) e^(-)$ annihilation at $10 thin$s naturally produces $10^6 thin M_⊙$ PBHs and the seed effect could then bind a region of $10^9 thin M_⊙$. Of course, one cannot infer that all the bound mass is swallowed by the black hole since that depends on the efficiency of accretion. Also the limit would not be attained anyway for $f_"PBH" > 10^(- 3)$, since the filling factor of the bound regions reaches $1$ when $M tilde m / f_"PBH"$, so there will be competition between the seeds thereafter. If larger galaxies are produced by the mergers of smaller galaxies, with the original central black holes themselves possibly merging to form a single central SMBH, this would naturally explain the observed proportionality between the masses of the galaxy and the central black hole. However, one cannot be sure that the original SMBHs will all drift to the centre of the larger galaxy and merge. The accretion rate according to a recent calculation is indicated in @fig:figY.


There is also the possibility that either the SMBHs or the PBHs which seeded them could help to generate the galaxies themselves. Hoyle & Narlikar~@1966RSPSA.290..177H first suggested the seed picture of galaxy formation in the context of the steady state theory, arguing that a typical galactic mass $M_(upright(g)) tilde 10^11 thin M_⊙$ would require a seed of mass $m tilde 10^9 thin M_⊙$. Their model was not constrained by the existence of a radiation-dominated era but Ryan~@1972ApJ...177L..79R argued that SMBHs could also seed galaxies in the context of the big bang theory. Using a spherically-symmetric Newtonian cosmology, he showed that the hydrodynamic equations permit a solution in which the density contrast has a particular form in the radiation-dominated and matter-dominated eras. This gave expressions for the galactic mass $M_(upright(g)) prop m^(2 / 5)$ and radius $R_(upright(g)) prop m^(1 / 3)$. For the Milky Way, Ryan obtained $m approx ( 1 thin "–" thin 9 ) times 10^6 thin M_⊙$, which encompasses the now established mass of $4 times 10^6 thin M_⊙$~@1998ApJ...509..678G. Gunn & Gott~@1972ApJ...176....1G pointed out an interesting prediction of the seed theory. If each shell of gas virialises after it has stopped expanding and virialised, then one would expect the resultant galaxy to have a density profile $rho ( r ) prop r^(- 9 / 4)$. This does not agree with the standard Navarro--Frenk--White (NFW) profile~@1996ApJ...462..563N, but one would not expect the latter to apply within the radius of gravitational influence of the central black hole anyway.


Of course, one could not expect #emph[all] galaxies to be produced by PBH seeds since the standard CDM model works well on large enough scales. However, one might want to invoke the PBH effect for early galaxies (i.e.~below the mass $M_"CDM"$ discussed in @sec:Seed-and-Poisson-Effects). For a monochromatic PBH mass function, all the galaxies binding at a given redshift will have the same mass until the CDM fluctuations take over. For an extended mass function, the PBH seeds will naturally produce a range of galactic masses at a given redshift. However, there are two distinct situations. In the first, the PBHs are sufficiently rare that there is only one per galaxy. The galactic mass is then proportional to the seed mass and one would expect the galactic mass function to be the same as the PBH mass function, although only a small fraction of the Universe goes into these galaxies. In the second situation, the filling factor of the bound regions reaches $1$, so that the competition between seeds becomes important and one can no longer assume $M prop m$. However, there should still be a simple relation between the mass spectrum of the holes, $"dn" / "dm" prop m^(- alpha)$, and that of the resulting galaxies, as we now demonstrate.


If $M_(upright(g)) prop m^gamma$, we expect the number of galaxies with mass in the range $( M , thin M + #h(0em) "dM" )$ to be $upright(d) N_(upright(g)) ( M )$ where $upright(d) N_(upright(g)) / "dM" prop M^(( 1 - gamma - alpha ) / gamma)$. For $alpha < 3$, the considerations of @sec:Seed-and-Poisson-Effects imply that one expects an $M$-dependent seed mass for $M < m_"max" / f_"max"$, where $m_"max"$ is the upper cut-off in the PBH mass function and $f_"max"$ is the dark matter fraction on that scale. In this mass range, Eq.~(#ref(<eq:seed>)) predicts $gamma = alpha - 1$, so one expects~@Carr:2018rid $ frac(upright(d) N_(upright(g)), upright(d) M) prop M^(- 2) quad ( M < M_(upright("max")) equiv m_(upright("max")) / f_(upright("max")) ) thin . $<eq:gal> This prediction depends on the concept of an $M$-dependent seed mass, although the simple analytic treatment of this concept in @sec:Clustering-of-PBHs. A needs to be backed up by numerical calculations. The form of the galactic mass function above $M_"max"$ corresponds to the Poisson effect and one expects an exponential decline. For comparison, the Press--Schechter mass function is~@Press:1973iz $ frac(upright(d) N_(upright(g)), upright(d) M) prop M^(- 2 + frac(3 + n, 6)) thin exp #h(-1em) \[ - ( M / M_(*) )^(frac(3 + n, 3)) \] thin , $ where $n$ is the power-spectrum index, $P ( k ) prop k^n$, which ranges from $1$ at large scales to $-3$ at small scales in the $Lambda$CDM model. Coincidentally, this corresponds to form~(#ref(<eq:gal>)) at small scales. It is supposed to explain the Schechter galaxy luminosity function at large scales~@1976ApJ...203..297S: $ frac(upright(d) N_(upright(g)), upright(d) L) prop L^alpha exp ( - L / L_(*) ) thin , $ where $alpha = - 1.07 plus.minus 0.07$ and $L_(*) = 1.2 times 10^10 thin L_⊙ thin h^(- 2)$ in the blue band. However, it also matches the prediction of Eq.~(#ref(<eq:gal>)), providing $m_"max" / f_"max" approx 10^12 thin M_⊙$.


// [figvision-cn] imgs/Figure_18.png
// 这是一张单面板的半对数曲线图，没有子图划分。横轴为时间
// t，单位是 Gyr（十亿年），采用对数坐标，范围从 0.01 到
// 10 Gyr。纵轴为质量增长率 dM/dt，单位是太阳质量每年（M⊙
// yr⁻¹），同样采用对数坐标，范围从 10⁻⁶ 到 10 M⊙ yr⁻¹。
// 图中共有四条主要曲线和一个标记点： 黑色实线（细线，无
// 填充）代表原星系（protogalaxy）气体沉积到最内层秒差距
// 的速率。该曲线在 t ≈ 0.01 Gyr 时从约 10⁻³ M⊙ yr⁻¹ 开始，
// 在 0.03 至 0.06 Gyr 之间上升至约 0.1 M⊙ yr⁻¹ 并出现一
// 个局部峰值，随后下降至约 0.02 M⊙ yr⁻¹（t ≈ 0.07 Gyr），
// 然后再次上升并在 0.1 至 1 Gyr 之间呈现锯齿状波动，峰值
// 出现在约 0.8 Gyr 处，达到约 1–2 M⊙ yr⁻¹。在 t ≈ 1 Gyr
// 之后，曲线急剧下降，到 t ≈ 2 Gyr 时降至约 0.02 M⊙ yr⁻¹。
// 图中有文字标注“protogalaxy”指向该曲线。 黑色虚线代表初
// 始质量约为 10 M⊙ 的原初黑洞（PBH）种子的生长率。该曲线
// 从 t = 0.01 Gyr 时的约 10⁻⁷ M⊙ yr⁻¹ 开始，单调上升，在
// t ≈ 1 Gyr 时达到约 1–2 M⊙ yr⁻¹ 的峰值。虚线所围成的区
// 域用灰色阴影填充，在该阴影区域内标注有文字“black hole”。
// 在 t ≈ 1 Gyr 之后，黑色虚线也急剧下降，到 t ≈ 2–3 Gyr
// 时降至 10⁻⁶ M⊙ yr⁻¹ 以下并终止。图左上方有文字“Initial
// seed mass = 10 M⊙”。 红色实线代表一个从 10⁵ M⊙ 种子黑
// 洞演化到已知 10⁹ M⊙ 类星体所需的生长率。该曲线从 t ≈
// 0.15 Gyr、纵轴约 10⁻³ M⊙ yr⁻¹ 处开始，在半对数坐标中呈
// 近似直线的单调上升趋势，到 t ≈ 0.75 Gyr 时达到约 10 M⊙
// yr⁻¹。红色实线起点附近有文字“10⁵ M⊙ seed black hole”并
// 带有指向该线的箭头。红色实线顶端有一个红色实心圆点，圆
// 点旁有文字“known 10⁹ M⊙ quasi-stellar object”，圆点下
// 方标注其红移为“z = 7.5”。 图中的主要趋势是：原星系的气
// 体供给率（黑色实线）在 0.1–1 Gyr 之间维持在较高水平（
// 0.1–2 M⊙ yr⁻¹）；一个 10 M⊙ 的初始黑洞种子（黑色虚线）
// 其生长率始终低于气体供给率，且所需生长时间较长；而红色
// 实线显示，若要在 z = 7.5（约 0.7 Gyr）时长成 10⁹ M⊙ 的
// 类星体，从 10⁵ M⊙ 种子出发所需的生长率极高，在 t ≈ 0.7
// Gyr 时约为 10 M⊙ yr⁻¹，这远高于同期的气体沉积率。
#figure(placement: top, image("imgs/Figure_18.png", width: 85.0%),
  caption: [
    Black hole growth rate as a function of time for an initial PBH seed mass of $10 thin M_⊙$ (black dashed line) and the rate of gas deposition into the innermost $100 thin$pc for the galaxy model used in Ref.~@Archibald:2001gi (black solid line). Also shown (red line) is the growth rate for a black hole which evolves from a seed mass of $10^5 thin M_⊙$ to the $10^9 thin M_⊙$ required for a quasi-stellar object \[extracted from Ref.~@2007ApJ...665..187L by Hasinger (private communication)\]. The shaded area corresponds to Eddington-limited accretion, persisting until $0.5 thin "–" thin 0.7 thin$Gyr, with the accretion being sub-Eddington over the subsequent $1 thin$Gyr. From Ref.~@Archibald:2001gi.
  ]
)
<fig:figY>



The possible rôle of PBHs as seeds for the SMBHs in galactic nuclei and early structures has been highlighted by recent results from the JWST, as reviewed by Dolgov~@Dolgov:2023ijt. These show that such structures form much earlier than expected in the standard $Lambda$CDM scenario. For example, there is a population of red galaxies with stellar mass above $10^10 thin M_⊙$ at $7.4 < z < 9.1$ with central SMBHs~@Labb__2023. The #emph[Atacama Large Millimeter/submillimeter Array] (ALMA) has observed an AGN at $z tilde 7$ whose large luminosity suggests a $10^9 thin M_⊙$ black hole~@Endsley_2023. The detection of X-rays from a $4 times 10^7 thin M_⊙$ SMBH in a gravitationally lensed galaxy is reported at $z = 10.3$ by Bogdan #emph[et al.]~@Bogdan:2023ilu, although they invoke seeds formed from the collapse of $10^4 thin "–" thin 10^5 thin M_⊙$ gas clouds rather than PBHs.


It has been claimed that such observations preclude the standard model but Dolgov~@Dolgov:2023ijt has emphasised that it is entirely consistent if one invokes a population of PBHs. Liu & Bromm~@Liu:2022bvr have also argued that unusually massive galaxies at $z > 10$ could be evidence that structure formation is accelerated by $10^9 thin M_⊙$ PBHs making up $10^(- 6) thin "–" thin 10^(- 3)$ of the dark matter. Goulding #emph[et al.]~@Goulding:2023gqa also argue for a heavy seeding channel for the formation of SMBHs within the first billion years of cosmic evolution. An interesting feature of these observations is that the central black hole to stellar mass ratio is several orders of magnitude larger than observed locally, as expected if the black hole is acting as a seed. Seeding of dwarf galaxies by IMBHs has also been proposed and two examples of this have been found~@Micic:2022mws @Yang:2023bnv.


Dolgov also links this proposal to the LVK observations, arguing that these are consistent with his earlier proposal of a lognormal mass function~@PhysRevD.47.4244 centred around $10 thin M_⊙$. This would be compatible with a low QCD temperature of $70 thin$MeV for a non-zero chemical potential. However, others argue that only some fraction of the LVK black holes could be primordial~@2022arXiv220905959F. He also argues that the SMBH binaries invoked to explain the NANOGrav data~@NANOGrav:2023hfp could be primordial.


== Exploding White Dwarfs
<sec:Exploding-White-Dwarfs>


PBHs can trigger explosions of white dwarfs, leading to potentially observable signatures~@2006PhRvL..96u1302F @2015PhRvL.115n1301B @2019PhRvD.100d3020A @2021ApJ...914..138C @2018PhRvD..98k5027G @2022PhRvD.105b3012A @2022arXiv221100013S ). It is therefore interesting that some recently observed supernovæ, the so-called #emph[calcium-rich transients]~@2010Natur.465..322P @2017ApJ...836...60L, do not trace the stellar density but are located off-centre from the host galaxies. Furthermore, they appear to originate from white dwarfs with masses of around $0.6 thin M_⊙$@2015AandA...573A..57M, well below the Chandrasekhar limit, and they predominantly occur in old systems.


It has been argued~@2022arXiv221100013S that these transient events could have been triggered by collisions with asteroidal-mass PBHs, with the associated event rate being within reach of current or near-future microlensing surveys~@2019NatAs...3..524N @2020PhRvD.101f3005S. The left panel of @fig:datacompare shows the cumulative type-Ia supernova event rate, normalised to the half-light radii of the host galaxies, as determined in Ref.~@2017ApJ...836...60L. This is different from standard type-Ia supernovæ, whose locations closely follow the stellar distribution. However, the distribution of these events with galactocentric distance follows that expected from dark matter/white dwarf interactions. This, together with the unique chemical properties and atypical progenitors of calcium-rich transients, strongly supports the hypothesis that these events originate from such interactions.


// [figvision-cn] imgs/Figure_19.png
// 这是一张由左右两个子图组成的科学论文插图，左侧为子图a，
// 右侧为子图b。 子图a为二维曲线图，展示不同天体事件在宿
// 主星系内的径向累积相对分布。横轴名称为“Galactocentric
// Distance [R_{1/2}]”，即银心距，以星系半光半径为单位，
// 采用对数坐标，刻度范围从0.1至约30，主要刻度标记为0.1、
// 1、10。纵轴名称为“cumulative relative rate”，即累积相
// 对率，采用线性坐标，范围从0.0至1.0，主刻度间隔0.2。图
// 中共有四条曲线：黑色实线代表“银河系恒星分布”，黑色虚线
// 代表“遵循恒星分布的标准Ia型超新星”，这两条曲线几乎重合，
// 从横轴0.1处纵轴约0.05开始，在横轴1处迅速上升至约0.5，
// 在横轴10处接近1.0；红色实线代表“预期的原初黑洞-白矮星
// 相互作用”，其从横轴0.1处纵轴约0.15起始，在横轴1处缓慢
// 上升至约0.25，随后在横轴1至10之间快速上升，在横轴20附
// 近达到1.0；红色虚线代表“观测到的富钙瞬变源”，其起始值
// 极低，在横轴1处纵轴约0.05，在横轴2至3之间出现阶梯状跃
// 升至约0.25，随后在横轴10附近急剧上升至约0.85，并在横轴
// 20后趋于1.0。图中文字标注明确指出了各曲线对应的物理对
// 象，红色箭头将红色实线指向“预期的原初黑洞-白矮星相互作
// 用”标签。该图传达的趋势是：标准Ia型超新星的空间分布与
// 星系恒星分布高度一致，而富钙瞬变源的空间分布明显更集中
// 于星系中心区域，与预期的原初黑洞-白矮星相互作用分布趋
// 势吻合。 子图b为二维参数空间图，展示原初黑洞暗物质丰度
// 随其质量的变化关系。横轴名称为“M[g]”，即原初黑洞质量，
// 单位为克，采用对数坐标，范围从10^21至10^25，主刻度为10
// ^21、10^22、10^23、10^24、10^25。纵轴名称为“f_{PBH}”，
// 即原初黑洞暗物质丰度，采用对数坐标，范围从10^-4至1，主
// 刻度为10^-4、10^-3、0.01、0.1、1。图中有一个红色填充的
// 带状区域，其边界为黑色实线，区域内部标注文字“Expected
// from Calcium-rich event rate”，即由富钙事件率预期的丰
// 度范围。该红色带状区域在横轴10^21处纵轴范围约为6×10^-4
// 至8×10^-3，随质量增加呈上升趋势，在横轴10^23处纵轴范围
// 约为0.01至0.2，在横轴10^24处纵轴范围约为0.1至1.0，并在
// 横轴10^25处达到纵轴1.0。图中还有一条蓝色粗虚线，标注文
// 字“HSC”，该线在横轴10^21至10^23之间呈陡峭下降趋势，从
// 纵轴约1.0降至约0.01，在横轴10^24处降至最低约5×10^-3，
// 随后在横轴10^25处略微回升至约0.01。该图传达的趋势是：
// 为了产生观测到的富钙瞬变源事件率，原初黑洞暗物质丰度需
// 在特定质量范围内达到一定水平，且该预期范围与HSC观测约
// 束在质量约10^23克附近存在交集或张力。
#figure(placement: top, image("imgs/Figure_19.png", width: 100%),
  caption: [
    #emph[Left panel:] Radial distributions of standard type-Ia supernovæ (black dashed) and calcium-rich transients (red dashed) within their host galaxies compared to the distribution of galactic stars (black solid) and the expected PBH/white dwarf interactions (red solid). #emph[Right panel:] PBH dark matter fraction as a function of mass required to produce the observed supernova rate. Also shown (blue) is the $95 #h(0em) "%"$ CL exclusion region from stellar microlensing in Andromeda by the Subaru HSC~@2019NatAs...3..524N @2020PhRvD.101f3005S. Figures adapted from Ref.~@2022arXiv221100013S.
  ]
)
<fig:datacompare>



The modelling of Ref.~@2022arXiv221100013S suggests that PBHs with $10^21 thin upright(g) < M < 10^23 thin upright(g)$ and $10^(- 3) < f_"PBH" < 0.1$ are the most plausible triggers for these events (see right panel of @fig:datacompare). Future observations will further explore this possibility. Interestingly, the #emph[Zwicky Transient Facility] (ZTF), which is the largest ongoing systematic survey, classified 8 new events in its first $16$ months of operation~@2020ApJ...905...58D. In the year 2024, the #emph[Large Synoptic Survey Telescope] (LSST) --- as part of the #emph[Vera Rubin Observatory] (VRO) --- is expected to increase the search volume by at least two orders of magnitude. Furthermore, observations with the JWST should be able to resolve dwarf spheroidal galaxies for the current sample of calcium-rich transients~@2020ApJ...905...58D, these two populations being closely connected.


== PBH Accretion: Pregalactic Era
<sec:PBH-Accretion:-Pregalactic-Era>


Here we focus on the accretion of gas by PBHs before the formation of galaxies or other cosmic structures. This problem was first studied in Ref.@10.1093-mnras-194.3.639, although this work was later superseded by more detailed numerical investigations. It is usually associated with PBH constraints but it may also lead to positive evidence since PBH accretion in this period could ionise the Universe or generate to X-ray background~@1980Natur.284..326C. Reference@10.1093-mnras-194.3.639 assumes the Bondi accretion formula and covers epochs between matter-radiation equality at $t_"eq" = 2.4 times 10^12 thin$s and galaxy formation. Before $t_"eq"$, the sound-speed is $c_(upright(s)) = c / #h(-1em) sqrt(3)$ and one can show that there is very little accretion~@Carr:1974nx. After $t_"eq"$, the accretion radius is increased, so the accretion rate is larger. However, the problem is complicated because the black hole luminosity will boost the matter temperature of the background Universe above the standard Friedmann value even if the PBH density is small, thereby reducing the accretion. Thus there are two distinct but related PBH constraints: one associated with the effects on the Universe's thermal history and the other with the generation of background radiation.


We assume that each PBH accretes at the Bondi rate, $ dot(M) = frac(4 pi thin G^2 thin n thin m_(upright(p)) thin M^2, ( k_(upright(B)) T / m_(upright(p)) + V^2 )^(3 / 2)) \
  approx 10^11 (frac(M, thin M_⊙))^(#h(-1em) 2) thin (n / upright("cm")^(- 3)) #h(-1em) (frac(T, 10^4 thin upright(K)))^(#h(-1em) - 3 / 2) upright(g) #h(0em) upright(s)^(- 1) thin , $<eq:Bondi> where a dot indicates a derivative with respect to cosmic time, $k_(upright(B))$ is the Boltzmann constant, $m_(upright(p))$ is the proton mass, $V$ is the black hole velocity (neglected in the second expression since it is small before the formation of cosmic structures) and $n$ and $T$ are the number density and temperature of the gas at the black hole accretion radius, $ R_(upright(a)) approx 10^14 (frac(M, thin M_⊙)) #h(-1em) (frac(T, 10^4 thin upright(K)))^(#h(-1em) - 1) thin c m thin . $ Each PBH will initially be surrounded by an ionised (HII) region of radius $R_(upright(s))$. If $R_(upright(a)) > R_(upright(s))$ or if the whole Universe is ionised (so that the individual ionised regions merge), the appropriate values of $n$ and $T$ are those in the background Universe ($macron(n)$ and $macron(T)$). In this case, after decoupling, $dot(M)$ is epoch-independent so long as $macron(T)$ has its usual Friedmann behaviour ($macron(T) prop z^2$). However, $dot(M)$ decreases with time if $macron(T)$ is boosted above the Friedmann value. If the individual ionised regions have not merged and $R_(upright(a)) < R_(upright(s))$, the values for $n$ and $T$ are those which pertain within the ionised region. In this case, $T$ is usually close to $10^4 thin$K and pressure balance at the edge of the region implies $n tilde macron(n) thin ( macron(T) / 10^4 thin upright(K) )$. This implies $dot(M) prop z^5$ if $macron(T)$ is unaffected, so the accretion rate rapidly decreases in this phase.


We assume that accreted mass is converted into outgoing radiation with constant efficiency $epsilon.alt$, so that the associated luminosity is $ L = epsilon.alt thin dot(M) c^2 thin , $ until this reaches the Eddington limit, $ L_(upright("ED")) = frac(4 pi thin G thin M #h(0em) c thin n thin m_(upright(p)), sigma_(upright(T))) approx 10^38 #h(-1em) (frac(M, thin M_⊙)) upright("erg") #h(0em) upright(s)^(- 1) thin , $<eq:Eddington> at which the Thomson drag of the outgoing radiation balances the gravitational attraction of the hole. (Here $sigma_(upright(T))$ is the Thomson cross-section.) The assumption that $epsilon.alt$ is constant is simplistic and more sophisticated models allow it to be $dot(M)$-dependent. We also assume that the spectrum of emergent radiation is constant, extending up to an energy $E_"max" equiv 10 thin eta thin$keV, with Ref.@10.1093-mnras-194.3.639 considering models with $eta = 0.01$, $1$ and $100$. We must distinguish between the #emph[local] effect of a PBH at distances sufficiently small that it dominates the effects of the others and the combined effect of all the PBHs on the mean conditions of the background Universe. Both effects are very dependent on the spectrum of the accretion-generated radiation and on the process by which this heats the background. The dominant process is Compton heating until a redshift@10.1093-mnras-194.3.639 $ z_(*) approx 10^2 thin Omega_(upright(m))^(1 / 3) thin ( eta thin Omega_(upright(g)) )^(- 2 / 3) thin , $<eq:zstar-def> where $Omega_(upright(m)) approx 0.2$ and $Omega_(upright(g)) approx 0.05$ are the density parameters of the matter and gas, respectively.


Providing the Bondi formula applies, the analysis of Ref.@10.1093-mnras-194.3.639 shows that a PBH will accrete at the Eddington limit for some period after decoupling if $ M > M_(upright("ED")) approx 10^3 thin epsilon.alt^(- 1) thin Omega_(upright(g))^(- 1) thin M_⊙ thin , $ so this condition only applies for supermassive PBHs. This phase will persist until a redshift $z_"ED"$ which depends upon $M$, $Omega_"PBH"$, $Omega_(upright(g))$ and $epsilon.alt$. The overall effect on the thermal history of the Universe is illustrated in @fig:extra, which is adapted from Ref.~@Carr:2020erq and indicates the ($Omega_"PBH" , thin M$) domain for which the Universe is reionised. $macron(T)$ is boosted above $10^4 thin upright(K)$ in regions (1) and (2) with $z_"ED" > z_(*)$ and $z_"ED" < z_(*)$, respectively; it reaches $10^4 thin upright(K)$ but never exceeds it in region (3); it never reaches $10^4 thin upright(K)$ (so the Universe remains unionised) in region (4). Associated constraints from the background-radiation density in various wavebands are discussed in Ref.@10.1093-mnras-189.1.123 and the limit on the PBH density parameter in domain (1) is $ Omega_(upright("PBH")) < ( 10 thin epsilon.alt )^(- 5 / 6) thin ( M / 2 times 10^5 thin M_⊙ )^(- 5 / 6) thin eta^(5 / 4) thin ( Omega_(upright(g)) / 0.05 )^(- 5 / 6) thin . $<eq:accretion> This is shown by the blue line in @fig:extra.


Two complications modify this analysis. First, accretion increases the PBH mass, although this has been assumed constant in the above analysis. During the Eddington phase, each PBH doubles its mass on the Salpeter timescale, $t_(upright(S)) approx 4 times 10^8 thin epsilon.alt thin$yr~@Salpeter:1964kb, so $M$ can only be regarded as constant if $z_"ED" > z_(upright(S)) approx 10 thin epsilon.alt^(- 2 / 3)$ and corresponds to the condition@10.1093-mnras-194.3.639 $ M < cases(
    10^19 thin Omega_"g"^(- 1) thin epsilon.alt^(7 / 2) thin ( Omega_"PBH" thin eta )^(3 / 2) thin M_⊙ & ( "region " 1 ),
    10^9 thin Omega_"g"^(- 1) thin epsilon.alt thin M_⊙ & ( "region " 3 ) thin .
  ) $<eq:Mconst> This is indicated by the bold line on the right of @fig:extra, where $z_"ED" approx 40$ for $epsilon.alt = 0.1$. Beyond this line, the PBH mass increases by the factor, $ exp ( t_(upright("ED")) / t_(upright(S)) ) approx exp #h(-1em) \[ ( 0.1 / epsilon.alt ) ( 40 / z_(upright("ED")) )^(3 / 2) \] thin . $<eq:salpetergrowth> The above analysis must be modified in this regime but, since most of the final black hole mass generates radiation with efficiency $epsilon.alt$, the current energy of the radiation produced is $E ( M ) approx epsilon.alt thin M c^2 / z ( M )$, where $z ( M )$ is the redshift at which most of the radiation is emitted. The current background-radiation density is $Omega_(upright(R)) approx epsilon.alt thin Omega_"PBH" thin z ( M )^(- 1)$, so the constraint becomes $ Omega_(upright("PBH")) < epsilon.alt^(- 1) thin Omega_(upright(R))^(upright("max")) thin z_(upright(S)) approx 10^(- 5) thin ( 10 thin epsilon.alt )^(- 5 / 3) thin , $<eq:accretion2> where $Omega_(upright(R))^"max" approx 10^(- 8)$ in the X-ray band. This is shown by the flat part of the blue line in @fig:extra and is equivalent to the so-called Soltan constraint~@Soltan:1982vf. This argument has been used to suggest that PBHs might generate the cosmic X-ray background~@1980Natur.284..326C.


The second complication is that the steady-state assumption fails if the Bondi accretion timescale, $ t_(upright(B)) approx 10^12 (frac(M, 10^4 thin M_⊙))^(- 1) #h(-1em) (frac(T, 10^4 thin upright(K)))^(#h(-1em) 3 / 2) thin upright(s) thin , $<eq:steady> exceeds the cosmic expansion time (i.e.~the Bondi formula is inapplicable at times earlier than $t_(upright(B))$). This arises if the mass within the accretion radius exceeds $M$, in which case the accretion radius is reduced to the value for which the gas mass contained is comparable to $M$. However, the Bondi formula becomes applicable by $t_"ED"$ providing $M < 10^4 thin M_⊙$ and this applies for most of the expected PBH mass range~@Carr:2020erq.


// [figvision-cn] imgs/Figure_20.png
// 这是一幅单子图的对数-对数坐标参数空间划分图，用于说明
// 原初黑洞（PBH）质量与密度对背景物质温度演化及吸积状态
// 的影响。横轴为原初黑洞质量 M，单位是太阳质量 M⊙，范围
// 从 10^2 到 10^16，刻度为 10^2、10^4、10^6、10^8、10^10、
// 10^12、10^14、10^16。纵轴为原初黑洞密度参数 f_PBH，范
// 围从 10^-6 到 10^0，刻度为 10^-6、10^-5、10^-4、10^-3、
// 10^-2、10^-1、10^0。坐标轴均为对数刻度。 图中用黑色粗
// 线和蓝色粗虚线划分出不同区域。左上角有一条垂直的黑色粗
// 线，位置在 M 略大于 10^4 M⊙ 处，线左侧标注竖直文字“
// z_ED = 10^3”。从这条竖线约 f_PBH = 2×10^-2 处向右下方
// 延伸出一条黑色粗斜线，斜线在 M 约 10^9 M⊙、f_PBH 约 2×
// 10^-5 处形成一个转折点，然后垂直向下延伸到底部边缘。图
// 中还有一条黑色粗斜线从 f_PBH 接近 10^0 处的左侧竖线顶
// 点向右下方延伸，经过 M 约 10^6 M⊙、f_PBH 约 2×10^-2 处
// 形成转折，再向右下方延伸，经过 M 约 10^9 M⊙、f_PBH 约
// 2×10^-5 处与前述转折点相接，然后继续向右上方延伸，斜线
// 旁标注文字“z_ED = 40”。这条向右上方的斜线在 M 约 10^15
// M⊙、f_PBH 约 2×10^-1 处再次转折，并垂直向上延伸到顶部
// 边缘。 蓝色粗虚线包括两部分：一条从左上向右下倾斜的虚
// 线，起点约在 M = 10^7 M⊙、f_PBH = 10^-1 处，终点约在 M
// = 10^10 M⊙、f_PBH = 10^-4 处；另一条从该终点向右水平延
// 伸的虚线，贯穿至右侧边缘，纵坐标保持在 f_PBH = 10^-4
// 附近。 图中用数字标出四个区域，各占被黑线划分出的空间。
// 区域 1 位于由中间转折斜线、右侧斜线和蓝色虚线围成的右
// 上方区域，标注数字“1”。区域 2 位于上方两条斜线之间、蓝
// 色斜虚线之上的左上方区域，标注数字“2”。区域 3 位于中间
// 转折斜线、左侧竖线与下方斜线围成的中间区域，标注数字“3
// ”。区域 4 位于左侧竖线、下方斜线和底部边缘围成的左下方
// 区域，标注数字“4”。 图注指出，该图展示背景物质温度演化
// 如何依赖 PBH 质量和密度，假设特定参数和 keV 能量。图中
// 黑色粗线 z_ED = 10^3 和 z_ED = 40 标示爱丁顿吸积率临界
// 线，在这些线右侧的区域内，解耦后一段时间内吸积率超过爱
// 丁顿极限，因此质量不能视为常数。区域（1）和（2）中，康
// 普顿加热使温度升高到 K 以上；区域（1）中温度超过某一临
// 界值。整体趋势表明，质量越大、密度参数越高的区域越容易
// 进入吸积率超过爱丁顿极限的状态，并伴随康普顿加热效应。
#figure(placement: top, image("imgs/Figure_20.png", width: 70.0%),
  caption: [
    This shows how the evolution of the background matter temperature depends on the PBH mass and density, adapted from Ref.~@Carr:2020erq. We assume $epsilon.alt = 0.1$, $Omega_(upright(g)) = 0.05$ and $E_"max" = 10 thin$keV. The accretion rate exceeds the Eddington limit for some period after decoupling to the right of the line $z_"ED" = 10^3$ and the mass cannot be regarded as constant the right of the line $z_"ED" = 40$. In domains (1) and (2), $T$ is boosted above $10^4 thin$K by Compton heating; $t_"ED"$ exceeds $t_(*)$ in domain (1) but it is less than it in domain (2). In domain (3), $T$ is boosted to $10^4 thin$K but not above it. PBHs reionise the Universe, with no neutral phase after decoupling, throughout these regions and they could generate the X-ray background on the blue broken line.
  ]
)
<fig:extra>



Later, an improved numerical analysis of pregalactic PBH accretion was provided by Ricotti #emph[et al.]~@Ricotti:2007au. They used a more realistic model for the efficiency parameter $epsilon.alt$, allowed for the increased density in the dark halo expected to form around each PBH and included the effect of the velocity dispersion of the PBHs \[i.e.~the $V$-term in Eq.~(#ref(<eq:Bondi>))\] on the accretion in the period after cosmic structures start to form. They found much stronger accretion limits by considering the effects of the emitted radiation on the spectrum and anisotropies of the cosmic microwave background (CMB) rather than the background radiation itself and excluded $f_"PBH" = 1$ above $10 thin M_⊙$. However, this problem has subsequently been reconsidered by several groups, who argue that the limits are weaker than indicated in Ref.~@Ricotti:2007au. Ali-Haïmoud & Kamionkowski~@Ali-Haimoud:2016mbv calculate the accretion on the assumption that it is suppressed by Compton drag and Compton cooling from CMB photons and allowing for the PBH velocity relative to the background gas. The point here is that accreting gas will have an inward velocity relative to the expanding background of CMB photons and the Thomson drag of these photons will inhibit accretion at sufficiently early times. They find the spectral distortions are too small to be detected, while the anisotropy constraints only exclude $f_"PBH" = 1$ above $10^2 thin M_⊙$. Horowitz~@Horowitz:2016lib performs a similar analysis and gets an upper limit of $30 thin M_⊙$. Serpico #emph[et al.]~@Serpico:2020ehh argue that the spherical accretion approximation probably breaks down, with an accretion disc forming instead, and this affects the statistical properties of the CMB anisotropies. Provided the disks form early, these constraints exclude a monochromatic PBH distribution above $2 thin M_⊙$ as the dark matter.


== PBH Accretion: X-Ray/Infrared/Radio Backgrounds
#<sec:PBH-Accretion:-X--Ray-Infrared-Radio-Backgrounds>


// [figvision-cn] imgs/Figure_21.png
// 这是科学论文插图，图类型为示意图（物理/天体物理过程示
// 意图）。图中没有坐标轴、比例尺或定量曲线。以下按图例与
// 空间布局描述，以便重建图像。 图例位于图的上方，共分两
// 行，左对齐排列。第一行含三项：左侧是一个六角星形符号，
// 中心为浅蓝色，外缘有灰蓝色较粗的锯齿状六角轮廓，旁标“
// PBH accretion”；中间是一个黑色实心圆，旁标“PBH”；右侧
// 是一个红色四角星/十字形符号，旁标“PBH-Quasi-stellar
// object”。第二行含两项及两个缩写：左侧是一个红色五角星，
// 旁标“Population-II star”；中间是一个黑色线框的六角星形
// 符号，中心为白色，六个顶点由线段连接，旁标“
// Intergalactic medium”；右侧是“C Central”和“S Satellite
// ”，分别表示中央与卫星。 背景为白色，图中散布许多黑色实
// 心圆（代表PBH，尺寸略有差异但无定量标尺）。通过细黑色
// 箭头指示这些PBH有向内运动的趋势，指向三个蓝色半透明圆
// 形区域（代表晕/结构）。这三个蓝色圆形结构分布在图中：
// 左上角一个中等大小圆（直径约占图宽的1/5），左下角一个
// 较小圆（直径约占图宽的1/6），右上角一个最大圆（直径约
// 占图宽的1/3，面积最大）。三个圆均为浅蓝色实心填充、无
// 边框，内部密集分布着黑色PBH，以及红色恒星符号、红/蓝星
// 形符号和中央/卫星标记等。 各蓝色圆形内部结构如下。左上
// 圆：中心附近有一个黑色实心圆，其上叠加一个正向红色四角
// 星符号，旁边标注白色字母“C”；其右侧约半径的1/3处有一个
// 黑色实心圆，旁边标注白色字母“S”；圆内散布多个红色五角
// 星（Population-II star）和黑色PBH。左上圆外侧边缘有两
// 个细箭头方向指向圆内（分别来自左侧和左下侧）。 左下圆：
// 中央有黑色PBH叠加红色四角星，标注白色“C”；圆内偏左上有
// 一个黑色PBH旁标注白色“S”；此圆内除黑色PBH和红色五角星
// 外，还有若干蓝色五角星（Population-III star），蓝色五
// 角星数量明显多于该圆内红色五角星；该圆右侧/上方有一个
// 细箭头指向圆内。 右上大圆：中心有较大黑色PBH叠加红色四
// 角星，标注白色“C”；其右侧约半径的1/3处有黑色PBH旁标注
// 白色“S”；圆内散布较多红色五角星和黑色PBH，红色五角星在
// 中部呈松散环状分布；大圆边缘有多个细箭头从外侧指向圆内
// （可见左上、左侧、左下、右下等方向）。大圆上方和右侧背
// 景中也散布若干PBH，右侧边缘外有一个箭头指向圆内。 图中
// 还有独立于三个蓝色圆之外的示意元素：在左上圆与右上大圆
// 之间的中下部，有一个放大的PBH吸积符号（浅蓝六角星加灰
// 色轮廓，即“PBH accretion”图例中的符号），它向右侧三个
// 白色线框六角星（Intergalactic medium）发出三条细箭头，
// 表示吸积过程与星际介质之间的相互作用；三个线框六角星大
// 小相近，呈品字形排列。该吸积符号附近也散布黑色PBH，并
// 有箭头指向左下蓝色小圆。 整体布局传达的趋势/结论：黑色
// PBH在空间中聚集，通过箭头指向蓝色晕区域，表明PBH在特定
// 红移阶段成团；不同蓝色圆的相对大小示意晕质量差异，右上
// 最大圆代表质量最大的晕，内部以红色五角星（
// Population-II恒星）为主；左下较小圆内蓝色五角星（
// Population-III恒星）更丰富，呼应“最低质量晕先形成星族
// III恒星，较高质量晕随后产生星族II恒星”的图注结论；中央
// （C）与卫星（S）标记显示每个晕内有一个中央PBH/准恒星天
// 体及一个卫星PBH；独立的PBH吸积符号与星际介质符号示意吸
// 积过程贡献宇宙X射线背景。
#figure(placement: top, image("imgs/Figure_21.png", width: 82.0%),
  caption: [
    Illustration of PBH clustering at redshifts $10 thin "–" thin 15$. Initially, PBHs (black dots) capture baryons while accreting, thereby contributing to the cosmic X-ray background. Lighter PBHs later form halos around more massive ones and initiate star formation; the lowest mass halos first form Population III stars, which generate a faint cosmic infrared background, and the higher mass ones then yield Population II stars. The most massive (central) supermassive PBH continues to accrete and merge with other PBHs. It appears as the central source in the infrared and X-ray emission, with the smaller PBHs and stars filling the halo as satellites. Figure adapted from Ref.~@Cappelluti:2021usg.
  ]
)
<fig:figZ2>



// [figvision-cn] imgs/Figure_22a.png
// 这是一张包含两个子图（图注中称为左图和右图）的科学论文
// 插图。左图占画面左侧约三分之二，右图占右侧约三分之一，
// 两者共享相同的横坐标轴。以下分别描述。 左图（图注中的
// Left panel）： 类型为曲线图（散点加阴影带与拟合曲线），
// 横轴为红移 z，采用对数坐标，范围从 10^0 到约 10^1.5（
// 即 1 到约 30），标注为“z”，无单位。纵轴为恒星形成率密
// 度 SFR，采用对数坐标，范围从 10^-5 到约 5×10^-1，标注
// 为“SFR (M_⊙ Mpc^-3 yr^-1)”，单位为太阳质量每年每立方兆
// 秒差距。 图中包含以下元素： 黑色实心圆点：表示观测数据
// 点，每个点带有垂直误差棒。数据点分布在 z≈1 到 z≈10 之
// 间，在 z≈3 附近达到峰值约 1.5×10^-1，随后下降。在 z≈8、
// 10 附近的数据点误差棒极大，向下延伸至 10^-5 量级。 绿
// 色阴影带：横跨 z≈1 到 z≈7，表示与河外背景光和高红移巡
// 天测量兼容的范围。该带在 z≈3 处最宽，上限约 2×10^-1，
// 下限约 5×10^-2；在 z≈7 处收窄至约 3×10^-2 到 5×10^-2。
// 灰色连续曲线：表示对所用数据的最佳拟合，从 z=1 处约 2×
// 10^-2 上升至 z≈3 的峰值约 1.2×10^-1，然后单调下降，在
// z≈10 处降至约 3×10^-4，在 z≈30 处降至 10^-5 以下。 右
// 侧（z>7）区域叠加了大量半透明的彩色曲线束，颜色从深蓝
// 色渐变到黄色。这些曲线在 z≈7 到 15 之间形成一个密集的
// 峰群，峰值高度在 10^-2 到 10^-1 之间，随后急剧下降。深
// 蓝色曲线束下降较快，黄色曲线束下降较慢，在 z≈20 之后分
// 散成多条细线，最终在 z≈30 处降至 10^-5 以下。 该图传达
// 的趋势是：恒星形成率密度随红移先上升后下降，在 z≈2-3
// 达到峰值，高红移（z>7）区域模型预测存在较大的不确定性，
// 彩色曲线束展示了不同热历史模型下的可能演化路径。 右图
// （图注中的 Right panel）： 类型为曲线图（多条半透明曲
// 线束），横轴与左图共享，为红移 z，对数坐标，范围从约 7
// 到 30。纵轴未在图中明确标注名称和刻度，但根据图注，表
// 示质量超过某一维里化温度阈值的坍缩暗物质晕的比例（
// Fraction of collapsed halos with mass exceeding ... as
// a function of redshift for various virialisation
// temperatures）。纵轴为线性比例（从曲线形态推断），无可
// 见刻度标签。 图中包含大量半透明曲线，颜色从深蓝色渐变
// 到黄色，与左图中的彩色曲线束对应。这些曲线在 z≈10 附近
// 从约 0.1 开始上升，在 z≈15 附近达到峰值（不同颜色峰值
// 位置略有差异，深蓝色峰值在 z≈12-14，黄色峰值在 z≈15-18），
// 峰值高度接近 1.0，随后在 z>18 区域快速下降。深蓝色曲线
// 下降更早、更陡，黄色曲线下降较晚、较缓。 该图传达的趋
// 势是：不同维里化温度阈值下，坍缩晕的比例随红移先上升后
// 下降，峰值出现在 z≈12-18 之间，且阈值温度越高（黄色），
// 峰值出现得越晚。
// [figvision-cn] imgs/Figure_22a.png
// 这是一张包含两个子图（图注中称为左图和右图）的科学论文
// 插图。左图占画面左侧约三分之二，右图占右侧约三分之一，
// 两者共享相同的横坐标轴。以下分别描述。 左图（图注中的
// Left panel）： 类型为曲线图（散点加阴影带与拟合曲线），
// 横轴为红移 z，采用对数坐标，范围从 10^0 到约 10^1.5（
// 即 1 到约 30），标注为“z”，无单位。纵轴为恒星形成率密
// 度 SFR，采用对数坐标，范围从 10^-5 到约 5×10^-1，标注
// 为“SFR (M_⊙ Mpc^-3 yr^-1)”，单位为太阳质量每年每立方兆
// 秒差距。 图中包含以下元素： 黑色实心圆点：表示观测数据
// 点，每个点带有垂直误差棒。数据点分布在 z≈1 到 z≈10 之
// 间，在 z≈3 附近达到峰值约 1.5×10^-1，随后下降。在 z≈8、
// 10 附近的数据点误差棒极大，向下延伸至 10^-5 量级。 绿
// 色阴影带：横跨 z≈1 到 z≈7，表示与河外背景光和高红移巡
// 天测量兼容的范围。该带在 z≈3 处最宽，上限约 2×10^-1，
// 下限约 5×10^-2；在 z≈7 处收窄至约 3×10^-2 到 5×10^-2。
// 灰色连续曲线：表示对所用数据的最佳拟合，从 z=1 处约 2×
// 10^-2 上升至 z≈3 的峰值约 1.2×10^-1，然后单调下降，在
// z≈10 处降至约 3×10^-4，在 z≈30 处降至 10^-5 以下。 右
// 侧（z>7）区域叠加了大量半透明的彩色曲线束，颜色从深蓝
// 色渐变到黄色。这些曲线在 z≈7 到 15 之间形成一个密集的
// 峰群，峰值高度在 10^-2 到 10^-1 之间，随后急剧下降。深
// 蓝色曲线束下降较快，黄色曲线束下降较慢，在 z≈20 之后分
// 散成多条细线，最终在 z≈30 处降至 10^-5 以下。 该图传达
// 的趋势是：恒星形成率密度随红移先上升后下降，在 z≈2-3
// 达到峰值，高红移（z>7）区域模型预测存在较大的不确定性，
// 彩色曲线束展示了不同热历史模型下的可能演化路径。 右图
// （图注中的 Right panel）： 类型为曲线图（多条半透明曲
// 线束），横轴与左图共享，为红移 z，对数坐标，范围从约 7
// 到 30。纵轴未在图中明确标注名称和刻度，但根据图注，表
// 示质量超过某一维里化温度阈值的坍缩暗物质晕的比例（
// Fraction of collapsed halos with mass exceeding ... as
// a function of redshift for various virialisation
// temperatures）。纵轴为线性比例（从曲线形态推断），无可
// 见刻度标签。 图中包含大量半透明曲线，颜色从深蓝色渐变
// 到黄色，与左图中的彩色曲线束对应。这些曲线在 z≈10 附近
// 从约 0.1 开始上升，在 z≈15 附近达到峰值（不同颜色峰值
// 位置略有差异，深蓝色峰值在 z≈12-14，黄色峰值在 z≈15-18），
// 峰值高度接近 1.0，随后在 z>18 区域快速下降。深蓝色曲线
// 下降更早、更陡，黄色曲线下降较晚、较缓。 该图传达的趋
// 势是：不同维里化温度阈值下，坍缩晕的比例随红移先上升后
// 下降，峰值出现在 z≈12-18 之间，且阈值温度越高（黄色），
// 峰值出现得越晚。
#figure(placement: top, [#box(image("imgs/Figure_22a.png", width: 48.0%)) #box(image("imgs/Figure_22b.png", width: 48.0%)) 

  ],
  caption: [
    #emph[Left panel:] Star formation rate (SFR) density versus redshift for the thermal-history model (see @sec:Thermal--History-Scenario). The green band indicates compatibility with measurements from extragalactic background light and high-redshift surveys. The grey continuous line indicates the best fit to the data used. #emph[Right panel:] Fraction of collapsed halos with mass exceeding $M$ as a function of redshift for various virilisation temperatures $T_"vir"$. Results are for both particle dark matter (dotted lines) and PBH dark matter (solid lines). From Ref.~@Cappelluti:2021usg.
  ]
)
<fig:figZ3>



// [figvision-cn] imgs/Figure_23.png
// 这是一张单一坐标系的科学曲线图，没有子图划分。以下为详
// 细描述： 图表类型为曲线图。纵轴为射电背景温度 \(T_r\)，
// 单位为开尔文（K），采用对数刻度，范围从约 \(10^0\) K
// 到略高于 \(10^4\) K。横轴有两个对应同一物理量的刻度：
// 底部横轴为光子能量 \(E\)，单位为微电子伏特（\(\mu\)eV），
// 采用对数刻度，范围从 \(10^{-1}\) 到 \(10^2\)；顶部横轴
// 为光子频率 \(\nu\)，单位为吉赫兹（GHz），同样采用对数
// 刻度，范围从 \(10^{-1}\) 到 \(10^1\)，与底部横轴通过 \
// (E = h\nu\) 对应。 图中有三条曲线。第一条为蓝色点线，
// 在图例中标注为 "ARCADE2/LWA1"，代表观测数据给出的射电
// 背景温度随能量的变化。第二条为蓝色实线，在图例中标注为
// "\((\lambda, f_{\text{duty}}) = (0.5, 0.05)\)"，代表原
// 初黑洞吸积模型在参数 \(\lambda = 0.5\) 和 \(f_{\text{
// duty}} = 0.05\) 下预测的射电背景温度。第三条为黑色虚线，
// 在图例中标注为 "CMB"，代表宇宙微波背景辐射温度，在图中
// 表现为一条不随能量变化的水平线，数值约为 2.7 K（在 \(
// 10^1\) K 刻度线下方）。 蓝色点线和实线趋势高度一致，均
// 从低能端（\(E \approx 0.1\) \(\mu\)eV）的高温（约 \(
// 1.5 \times 10^4\) K）开始，随能量增加呈单调递减，直到
// \(E \approx 10\) \(\mu\)eV 处降至与 CMB 温度相当的水平，
// 并在此后保持与 CMB 曲线重合。在 \(E < 10\) \(\mu\)eV
// 的区间，蓝色点线（观测数据）略高于蓝色实线（模型预测），
// 两条线之间的差距在 \(E \approx 0.1\) 到 \(1\) \(\mu\)
// eV 之间最为明显。该图传达的结论是：原初黑洞吸积模型在
// 给定参数下预测的射电背景温度演化趋势与 ARCADE2/LWA1 的
// 观测数据基本吻合，尤其是在高能端与 CMB 一致，而在低能
// 端模型预测值略低于观测值。
#figure(image("imgs/Figure_23.png", width: 55.0%),
  caption: [
    Net radio background temperature $T_r$ for photon of energy $E$, due to accretion onto supermassive PBHs. The CMB temperature (black dashed line) is also shown. Figure adapted from Ref.~@Mittal:2021dpe.
  ]
)
<fig:acc>



The most compelling evidence for PBHs is associated with the X-ray and infrared source-subtracted cosmological backgrounds (requiring stellar PBHs) and the radio background (requiring supermassive PBHs). As shown by Kashlinsky and his collaborators~@2013ApJ...769...68C @2005Natur.438...45K @2018RvMP...90b5006K @Kashlinsky:2016sdv, the spatial coherence of the X-ray and infrared source-subtracted cosmological backgrounds suggests that black holes are required. Although these need not be primordial, the level of the infrared background suggests an overabundance of high-redshift halos and this could be explained by the Poisson effect discussed above if a significant fraction of the CDM comprises solar-mass PBHs. In these halos, a few stars form and emit infrared radiation, while PBHs emit X-rays due to accretion. It is challenging to find other scenarios that naturally produce such features. PBHs naturally explain both the amplitude and angular spectrum of the source-subtracted infrared anisotropies (as found by Spitzer). The infrared/X-ray coherence is a consistency argument but the infrared connection would apply even if there was no coherence (i.e.~even if PBHs did not efficiently accrete). Kashlinksy also invokes cosmological advection at $z > 100$ to speed up the formation of early compact objects~@2021PhRvL.126a1101K.


Hasinger~@2020JCAP...07..022H has estimated the contribution from PBH baryon accretion and stars to the cosmic X-ray and infrared backgrounds, and analysed their cross-correlation using deep #emph[Chandra] and #emph[Spitzer] survey data~@2013ApJ...769...68C. Assuming Bondi capture and advection-dominated disc accretion, he finds that a population of $10^(- 8) thin "–" thin 10^10 thin M_⊙$ PBHs is consistent with the residual X-ray fluctuation signal, peaking at redshifts $z approx 17 thin "–" thin 30$. Furthermore, he argues that PBHs could have an important bearing on a number of other phenomena: (1) amplifying primordial magnetic fields; (2) modifying the reionisation history of the Universe (while being consistent with recent #emph[Planck] measurements@2020AandA...641A...6P); (3) impacting on X-ray heating, thereby providing a contribution to the entropy floor observed in groups of galaxies~@1999Natur.397..135P\; (4) certain $21$-$"cm"$ absorption-line features~@2018Natur.555...67B which could be connected to radio emission from PBHs.


In a recent related study, Cappelutti #emph[et al.]~@Cappelluti:2021usg have explored the high-redshift properties of PBH dark matter with an extended mass spectrum induced by the thermal history of the Universe (see Ref.~@Carr:2019kxo and @sec:Thermal--History-Scenario). Their main results are summarised in @fig:figZ2 and~@fig:figZ3. Further findings are: (1) a secondary peak of star formation at $z tilde 15 thin "–" thin 20$ (beyond the well-established observed peak at $z tilde 3$), being driven by mini halos, which are likely to host the first episode of Population III star formation; (2) a significant enhancement of the X-ray background fluctuations and the unresolved cosmic X-ray and infrared-background cross-power spectrum, with only a minor effect on the cosmic infrared-background fluctuations; (3) an explanation of the integrated $1 thin "nW" thin upright(m)^(- 2) thin "sr"^(- 1)$ measured signal~@2016MNRAS.455..282H @2018RvMP...90b5006K, which cannot be fully accounted for by non-PBH cosmologies, with $M > 1 thin M_⊙$ PBHs; (4) the X-ray spectral-energy distribution of the cosmic X-ray and infrared-background cross-correlation signal also contains information about their production mechanism (c.f.~Ref.~@2018ApJ...864..141L).


Mittal & Kulkarni~@Mittal:2021dpe discuss the generation of a radio background by accreting supermassive PBHs and claim that this could explain the excess observed by the second generation #emph[Absolute Radiometer for Cosmology, Astrophysics and Diffuse Emission] (ARCADE2)~@2011ApJ...734....5F and the #emph[Long Wavelength Array] (LWA1)~@Dowell:2018mdb. They take the comoving radio emissivity due to accreting PBHs to be $ epsilon.alt_(upright("acc")) ( E ) & = 5.65 times 10^19 thin f_(upright("duty")) thin ( f_(upright(X)) thin lambda )^0.86 (frac(f_(upright("PBH")) thin rho_(upright("DM")), 1 thin upright("kg") thin upright(m)^(- 3))) (frac(E, 5.79 thin mu thin upright("eV")))^(#h(-1em) - 0.6) \
  upright(s)^(- 1) upright(m)^(- 3) thin . $<eq:rem> where $f_"duty"$ is the duty cycle parameter (i.e.~the probability that a black hole is active at a particular time), $lambda$ is the luminosity in units of the Eddington value and $f_(upright(X))$ is the ratio of the total X-ray luminosity to the bolometric luminosity. The specific intensity due to this emissivity is then $ J_(upright("acc")) ( E , z ) = frac(c, 4 pi) thin ( 1 + z )^3 integral_z^1000 frac(upright(d) z', H ( z' )) #h(0em) frac(epsilon.alt_(upright("acc")) \[ E thin ( 1 + z' ) / ( 1 + z ) \], 1 + z') thin . $<eq:jacc> This is shown in @fig:acc for typical values for SMBHs, $f_(upright(X)) = 0.1$, $f_"duty" = 5 times 10^(- 2)$, $lambda = 0.5$, which shows that the observed excess (dotted blue line) and can be explained (solid blue line).


D'Agostino #emph[et al.]~@DAgostino:2022ckg have examined the impact of PBH dark matter around a central SMBH on the accretion-disc luminosity of spiral galaxies and kinematic quantities. They find that suitable PBH masses are $10^6 - 10^12 thin M_⊙$ for PBH fractions of $10^(- 3) - 1$, with the best-fit configuration having $f_"PBH" = 1$ and $M = 10^6 thin M_⊙$.


// [figvision-cn] imgs/Figure_24.png
// 这是一张散点图，用于汇总LIGO/Virgo观测到的致密双星并合
// 事件（GWTC-3中天文概率大于0.5的事件），并叠加了电磁观
// 测约束的黑洞和中子星。纵轴为“太阳质量”（Solar Masses），
// 采用对数刻度，范围从1到200，刻度标注为1、2、5、10、20、
// 50、100、200。横轴不表示连续物理量，仅用于将不同事件横
// 向展开以避免重叠，没有刻度标签和单位。 图例位于顶部，
// 包含四类：LIGO-Virgo-KAGRA Black Holes（蓝绿色文字）、
// LIGO-Virgo-KAGRA Neutron Stars（橙色文字）、EM Black
// Holes（暗红色文字）、EM Neutron Stars（浅绿色文字）。
// 底部标注文字为“LIGO-Virgo-KAGRA | Aaron Geller |
// Northwestern”。 图中的数据点分为两组：上方由蓝绿色圆点
// 表示的LIGO-Virgo-KAGRA黑洞双星并合事件，以及下方由浅绿
// 色圆点表示的电磁观测中子星。每个蓝绿色圆点对应一个并合
// 事件，并用一条灰色垂直箭头连接两个圆点：箭头顶端代表较
// 重的黑洞质量（m1），箭头底端代表较轻的黑洞质量（m2），
// 箭头方向朝上。部分双黑洞系统的质量比接近1，箭头很短；
// 质量比悬殊的系统箭头较长。可以看到，大多数双黑洞并合事
// 件的主质量集中在5到50太阳质量之间，部分事件的主质量超
// 过100太阳质量。在中心区域，有一组双黑洞系统的质量较低，
// 延伸至约2至10太阳质量。图中还显示了一些质量比极端的事
// 件，次质量低至约2至3太阳质量。 在图的左侧和右侧，各有
// 一组暗红色圆点沿对数曲线排列，代表通过电磁观测确认的黑
// 洞。左侧的暗红点从约20太阳质量下降至约5太阳质量，右侧
// 的暗红点从约20太阳质量下降至约5太阳质量，形成类似“V”形
// 的分布，但左右不对称。这些点没有箭头连接，表示它们不是
// 双星并合事件，而是单个黑洞的质量估计。 在底部，有一条
// 浅绿色圆点组成的曲线，表示电磁观测到的中子星质量分布。
// 这条曲线在中间最低，约1.2太阳质量，向两侧逐渐升高至约2
// 太阳质量，在图上形成一条凹形曲线。这些点同样没有箭头连
// 接，代表单个中子星的质量。 图中所有标注文字均已描述。
// 该图传达的趋势是：LIGO/Virgo观测到的双黑洞并合事件覆盖
// 了从约2到约100太阳质量的范围，且多数事件的主质量集中在
// 5到50太阳质量；电磁观测的黑洞质量集中在5到20太阳质量；
// 中子星质量集中在1到2太阳质量。双黑洞并合事件的质量分布
// 与电磁观测的黑洞和中子星质量分布存在重叠区域，尤其是低
// 质量端，暗示了致密天体质量分布的连续性。
#figure(placement: top, image("imgs/Figure_24.png", width: 96.0%),
  caption: [
    Summary of compact binary coalescences observed by LIGO/Virgo, from GWTC-3~@2021arXiv211103606T (with all events having an astrophysical probability greater than $0.5$), together with black holes and neutron stars previously constrained through electromagnetic observations. Figure credit: LIGO-Virgo/Aaron Geller/Northwestern University.
  ]
)
<fig:figLIGO>



= Gravitational-Wave Evidence
<sec:Gravitational--Wave-Evidence>


This section reviews the evidence for PBHs from gravitational-wave (GW) observations. The first detections of such waves were in 2015~@Abbott:2016blz and came from the merging of black holes which were unexpectedly large (around $30 thin M_⊙$) compared to those in X-ray binaries. This triggered renewed interest in PBHs, not only as a source of the mergers but also as a possible solution to the dark matter problem. Eight years later there are about $90$ detections in the third #emph[Gravitational-Wave Transient Catalog] (GWTC-3)~@2021arXiv211103606T, as shown in @fig:figLIGO, and the properties of the GW sources are still intriguing. A unifying PBH scenario may explain the merging rates, the black hole mass distribution, the existence of events in the high- and low-mass gaps for stellar remnants, the mergers with highly asymmetric masses, the reported low spins and some subsolar black hole candidates. PBHs in the stellar-mass range can also lead to a GW background at nanohertz frequency, with contributions from both the PBH binaries themselves and the waves generated at second order in perturbation theory by the density fluctuations which produce the PBHs. Such a background may have already been observed by #emph[Pulsar Timing Arrays] (PTAs).


We note that connecting GW observations and the PBH abundance requires an understanding of the PBH clustering since this strongly impacts the PBH merger rates. It also requires an understanding of the PBH formation scenario, since this affects the amplitude of the scalar-induced GW background through the statistics of curvature fluctuations and the PBH mass distribution. In this section the mass of the PBH is denoted by $m$ and $f ( m )$ denotes the PBH mass function.


== Merger Rate of Compact Binaries
<sec:Merger-Rate-of-Compact-Binaries>


One month after the first GW detection, Bird #emph[et al.]~@Bird:2016dcv and Clesse & Garcı́a-Bellido~@Clesse:2016vqa claimed that the expected PBH merging rates of binaries formed at late times in compact halos is compatible with the LVK analysis if they comprise all the dark matter. This was later supported by other studies~@Blinnikov:2016bxu. On the other hand, Sasaki #emph[et al.]~@Sasaki:2016jop argued that the mergers of PBH binaries formed before matter-radiation equality, when neighbouring PBHs are sufficiently close to form pairs, are much more frequent and this implies that the fraction of dark matter in $30 thin M_⊙$ PBHs can be at most $1 "%"$. However, Raidal #emph[et al.]~@Raidal:2017mfl @Vaskonen:2019jpv studied the evolution and merging of early PBH binaries in more detail with $N$-body simulations. They found that the rates are highly suppressed if PBHs significantly contribute to the dark matter, due to binary disruption by nearby PBHs, early-forming PBH clusters (see @sec:Clustering-of-PBHs) and matter inhomogeneities. Other groups obtained similar results with both analytical and numerical methods~@Ali-Haimoud:2017rtz but without including all these effects.


The most recent rate analyses~@2022arXiv220905959F @Escriva:2022bwe @Clesse:2020ghq @2020JCAP...09..022J @2021PhRvL.126e1302J seem to exclude all the dark matter being in $tilde 30 thin M_⊙$ PBHs but it is still debated if a significant fraction of the dark matter could comprise solar-mass PBHs for the wide mass distribution expected if PBH formation is boosted at the QCD transition (see @sec:Thermal--History-Scenario). Given the uncertainties related to the clustering of PBHs, it remains unclear which binary formation channel (early or late) is dominant in the solar-mass range. Another complication is that the perturbation of early binaries~@2020PhRvD.101d3015V and their formation by three-body capture~@Franciolini:2022ewd may significantly contribute to the merger rate. We now review some recent calculations of the merger rates for each production channel and show that they could be compatible with LVK observations if solar-mass PBHs dominate the dark matter.


#strong[Early Binaries] A PBH binary can form when two PBHs are produced sufficiently close to each other, which happens regularly due to their Poisson distribution. The gravitational influence of one or more nearby PBHs prevents them from merging directly and allows them to form a binary which takes of order the age of the Universe to merge. For an arbitrary mass function $f ( m )$, normalised to $1$, the differential merging rate $R^"early" equiv "dR" / ( upright(d) ln m_1 thin upright(d) ln m_2 )$ is given by~@Raidal:2018bbj @Gow:2019pok @Kocsis:2017yty $
  R^"early" (m_1, m_2) & = 1.6 times 10^6 thin f_"sup" (m_1, m_2, z) thin f_"PBH"^(53/37) thin f(m_1) thin f(m_2) [ (t(z))/t_0 ]^(-34/37) \
  & quad times ( (m_1 + m_2)/M_⊙ )^(-32/37) [ (m_1 m_2)/((m_1 + m_2)^2) ]^(-34/37) "Gpc"^(-3) thin "yr"^(-1).
$ <eq:cosmomerg> Assuming $m_1 > m_2$ mass ordering, an additional factor of two must be included in these rates. For a monochromatic mass function, this reduces to the Sasaki #emph[et al.]~@Sasaki:2018dmp expression, except for the suppression factor $f_"sup"$. Analytical prescriptions derived from $N$-body simulations in Refs.~@Raidal:2018bbj @Hutsi:2020sol determine this suppression factor. It has a complex dependence on redshift, $f_"PBH"$ and the mass distribution $f ( m )$. Nevertheless, if one assumes that the mass distribution has a sharp peak and that PBHs contribute significantly to the dark matter ($0.1 lt.tilde f_"PBH" lt.eq 1$), one gets a useful low-redshift approximation~@Clesse:2020ghq, #eqnn[$
  f_"sup" approx 2.3 times 10^(-3) f_"PBH"^(-0.65),
$] that is independent of the mass distribution. The more complete results of Refs.~@Raidal:2018bbj @Hutsi:2020sol have been tested against $N$-body simulations but only for monochromatic or lognormal distributions, which makes their validity uncertain for broad mass functions. Moreover, in this case, the value of $f_"sup"$ depends on the low-mass cut-off~@Escriva:2022bwe. Binary disruption by nearby black holes has not been explored for very asymmetric binaries, which provides another source of uncertainty.


If one assumes $f ( m approx 2 thin M_⊙ ) approx 1$ and $f_"PBH" = 1$, one gets merger rates of order $10^3 #h(0em) "yr"^(- 1) thin "Gpc"^(- 3)$, which is in tension with the upper limits inferred from LIGO/Virgo observations. But one can have $f_"PBH" gt.tilde 0.1$ to explain merger rates. This could be obtained with a very wide mass distribution, implying that the PBH fraction in the solar-mass range is somewhat below $1$. However, the case of an extended mass distribution is more complex and the current prescription is not valid for arbitrary mass distributions. One must be cautious when applying them to a broad mass function, even if it exhibits a sharp solar-mass peak, because the influence of small mass black holes on binary disruption tends to be overestimated, even when they do not contribute significantly to the total PBH density. There are also subtleties related to the exact definition of the PBH mass distribution, which has led some studies~@Raidal:2018bbj @Hutsi:2020sol to use inconsistent prescriptions, as pointed out in Ref.~@Escriva:2022bwe. This can induce significant differences when the PBH density is inferred from GW observations.


Finally, large uncertainties remain in the formation rate of early binaries, the suppression factor for binaries with very low mass ratios, and the contribution to the merging rates of disrupted binaries~@Raidal:2018bbj that can dominate when $f_"PBH" gt.tilde 0.1$, the shape of the mass function or the clustering after matter-radiation equality. Strong claims relying on these merging rates are therefore probably premature. Nevertheless, Eq. (#ref(<eq:cosmomerg>)) gives a good estimate of the merging rates, at least in some cases.


#strong[Late Binaries] PBH binaries can also form by capture in clusters at late times, in which case the merging rate becomes~@Clesse:2016vqa @Clesse:2016ajp @Clesse:2020ghq @Bagui:2021dqi $
  R^"late" (m_1, m_2) & = R_"clust" thin f_"PBH"^2 thin f(m_1) thin f(m_2) \
  thin ((m_1 + m_2)^(10/7))/((m_1 m_2)^(5/7)) thin "yr"^(-1) "Gpc"^(-3),
$ <eq:ratescatpure2> where $R_"clust"$ is a scaling factor that depends on the typical halo mass, size and virial velocity. Halo mass functions compatible with the standard $Lambda$CDM scenario typically lead to $R_"clust" approx 1 thin "–" thin 10 #h(0em) "yr"^(- 1) thin "Gpc"^(- 3)$, as assumed by Bird #emph[et al.]~@Bird:2016dcv. This is too low to explain the rates observed at the solar-mass scale, and a model with $f ( m approx 30 thin M_⊙ ) approx 1$ would be inconsistent with the increased rates expected for Poisson-induced clusters (see @sec:Clustering-of-PBHs).


Poisson fluctuations induce an additional clustering compared to that expected in the $Lambda$CDM scenario and in this case more realistic values of $R_"clust"$ are between $100$ and $1000 thin "yr"^(- 1) thin "Gpc"^(- 3)$. A value of around $400 thin "yr"^(- 1) thin "Gpc"^(- 3)$ is needed to explain exceptional events like GW190425, GW190814 and GW19052 with the wide mass distribution expected in the 'thermal-history' scenario~@Clesse:2020ghq (see @sec:Thermal--History-Scenario). The exact value of $R_"clust"$, however, is still uncertain and model-dependent. It could have a more or less complex dependence on the component masses, $f_"PBH"$ and redshift.


From the PBH cluster properties identified in @sec:Clustering-of-PBHs, one can estimate $R_"clust"$ as a function of the PBH velocity and the enhanced local density contrast $delta^"local"$ compared to the cosmological dark matter density, which gives $
  R_("clust") = (2 pi thin delta^("local") thin Omega_"M"^2 thin rho_"c" thin G)/c ( (85 thin pi)/(6 sqrt(2)) )^(2/7) ( c/(sqrt(2) thin v_"vir") )^(11/7) "yr"^(-1) "Gpc"^(-3).
$ With realistic values of $delta^"local" = 3 thin M_"halo" / ( 4 pi thin r_"halo"^3 thin rho_"DM"^0 )$, assuming clusters with $M_"halo" = 10^6 thin M_⊙$ and $r_"halo" approx 20$ pc and the corresponding virial velocity, this gives $R_"clust" approx 100 thin "yr"^(- 1) thin "Gpc"^(- 3)$, while for $M_"halo" = 10^7 thin M_⊙$ and $r_"halo" approx 10$ pc, one gets $R_"clust" approx 750$. Merger rates that are obtained with these values are consistent with those inferred from observations at the solar-mass scale.


Using the most recent merging rate calculations and the latest limits from GWTC-3~@KAGRA:2021duu, one can conclude that PBHs around $30 thin M_⊙$ can explain at most $0.1 thin "–" thin 1 thin$% of the dark matter, despite Poisson clustering reducing the merging rate of early binaries and increasing the rate of late ones. However, it is still possible that PBHs in the solar-mass range explain at least a significant fraction of the dark matter. In this case, the rate of late and early binaries are comparable. In order to distinguish these two binary formation mechanisms, or to distinguish late PBH binaries from standard astrophysical ones, it will be possible to use the next generation of GW detectors to measure the orbital eccentricities of inspiraling late binaries that are initially highly eccentric~@Cholis:2016kqi. At the solar-mass scale, the PBH merger rate also coincides with the neutron star merger rate inferred from GW observations. Apart from GW170817 (which had an electromagnetic counterpart), these could be PBHs at the QCD peak. PBH scenarios with extended mass functions generically lead to many asymmetric mergers (involving PBHs of order $10$ and $1 thin M_⊙$) and their rate is of order $10 #h(0em) "yr"^(- 1) thin "Gpc"^(- 3)$. On the other hand, the observed merging rates of asymmetric binaries like GW190814 challenges all current astrophysical models, as mentioned in the abstract of the LIGO/Virgo discovery paper of GW190814~@2020ApJ...896L..44A. In the next section, we expand the discussion of the evidence for PBHs from the mass distribution of the GW events.


== Mass Distribution
<sec:Mass-Distribution>


While merging rates indicate the PBH abundance, the mass distribution of the coalescences indicates the PBH mass function and therefore provides an important probe of the scenario. It was argued in Refs.~@Clesse:2016vqa @Kovetz:2016kpi @Kovetz:2017rvv that the PBH mass distribution could be reconstructed from the distribution of LVK merger events anticipated in the next observing run. It was also proposed that a quantity related to the merger-rate distribution, $ alpha equiv - ( m_1 + m_2 )^2 thin frac(partial^2 ln R, partial m_1 thin partial m_2) thin , $ could be used to identify a primordial component of black hole mergers: one should have $0.97 lt.tilde alpha lt.tilde 1.05$ for early binaries and $alpha tilde.eq 10 / 7$ for late binaries, independent of the PBH mass function~@Kocsis:2017yty. According to the most recent population analysis for GWTC-3~@KAGRA:2021duu, the large number of merger events with component masses around $30 thin M_⊙$ indicates a statistically preferred model with a peak at this mass scale. If these black holes are primordial, one might associate this excess with the QCD-induced feature expected at this scale. However, one should be cautious about this because an event excess need not imply a rate or black hole mass function excess. For example, the PBH mass distributions obtained with some of the most recent numerical simulations, taking into account the effects of the equation-of-state variations at the QCD epoch on the dynamics of the spherical inhomogeneities, do not lead to a significant peak in the rate distribution around $30 thin M_⊙$~@2022arXiv220906196E. Therefore, it is not straightforward to assess whether such models are favoured or disfavoured compared to stellar-black-hole models. This is illustrated in @fig:1DRate-LIGO.


// [figvision-cn] imgs/Figure_25.png
// 该图是一张双对数坐标系下的二维曲线与阶梯直方图（阶梯带）
// 混合图，用于展示不同质量分布模型下的合并率分布及其90%
// 置信区间，并叠加理论模拟曲线。横轴为源框架下主质量 m1
// (M☉)，范围从 1 到 100，刻度为对数间隔（标注 1, 5, 10,
// 50, 100）。纵轴为 m1 d τ_LB+EB / d m1，单位为 Gpc^-3
// yr^-1，范围约从 0.001 到 100，刻度为对数间隔（标注
// 0.01, 10）。图中包含三层信息：1）阶梯状柱带表示重构率
// 分布及90%置信区间：橙色（浅橙实心带）为等质量（q ≈ 1）
// 合并，蓝色（浅蓝实心带）为非等质量合并；2）黑色、橙色、
// 蓝色曲线（实线与虚线）为理论模拟预测的质量分布；3）辅
// 助文本框。主要趋势：两种合并类型的置信带在 m1 ≈ 5–10
// 区间有峰值，橙色带在 m1 > 20 时呈快速下降趋势，而蓝色
// 带在 m1 > 20 时下降更平缓，表明非等质量合并更倾向于产
// 生大质量主星。从图例与文本标注可知：蓝色阶梯带对应“All
// ”，橙色阶梯带对应“q ≈ 1”。理论曲线中，蓝色曲线（All）
// 总体上高于橙色曲线（q ≈ 1），在 m1 ≈ 10 处达到峰值约
// 40–50 Gpc^-3 yr^-1。图中文本框标注了模型参数：左侧框“
// q_prof = 3.14, f_PBH = 1”，右侧上方小框“Spectral index
// ”，内部标注“n_s = 0.965”（实线）与“n_s = 0.975”（虚线）；
// 右侧下方小框“Masses”，内部标注“All”（蓝色实线）与“q_r
// ≈ 1”（橙色实线）。曲线根据线型与颜色区分为：蓝色实线、
// 蓝色虚线、橙色实线、橙色虚线（其中虚线对应 n_s = 0.975），
// 以及若干黑色细实线/细虚线（对应不同谱指数模拟）。所有
// 曲线在 m1 < 2 时呈上升趋势，在 m1 ≈ 5–10 达到峰值后下
// 降，且蓝色曲线始终位于橙色曲线上方。坐标轴无网格线，但
// 图内边框完整。无显微照片、比例尺、色标或连接布局示意。
#figure(placement: top, image("imgs/Figure_25.png", width: 100%),
  caption: [
    Reconstructed rate distribution and their 90% confidence intervals as a function of $m_1$ for equal-mass (orange band) and non-equal mass (blue band) mergers, using GWTC-3 data, for the binned Gaussian process model with uniform $( log m_1 , log m_2 )$ bins. Superimposed are typical mass distributions predicted by the simulations of Ref.~@Escriva:2022bwe. These include QCD effects and assume Gaussian fluctuations for a nearly scale-invariant power spectrum with spectral index $n_(upright(s))$ and $f_"PBH" = 1$ for the combined merger rates of early and late binaries. The parameter $q_"prof"$ describes the density profile. From Ref.~@KAGRA:2021duu.
  ]
)
<fig:1DRate-LIGO>



Because the sensitivity of the detectors depends on frequency, they are more able to detect mergers with large chirp masses, even if these are less frequent than solar-mass mergers. In order to predict the observed mass distribution, one must therefore multiply the merging rates by the volume probed, which is fixed by the detector range: $ R_(upright("det")) approx sqrt(5) / 24 thin frac(( G #h(0em) cal(M) thin c^3 )^(5 / 6), pi^(2 / 3)) thin 1 / 2.26 [integral_(f_(upright("min")))^(f_(upright("max"))) thin frac(f^(- alpha), S_h ( f ))]^(1 / 2) thin , $ where $cal(M)$ is the binary chirp mass, $f_"min" = 50 thin$Hz is the minimum frequency used in the search, $f_"max"$ is the smaller of the maximal search frequency ($tilde 4000 thin$Hz) and the merger frequency \[estimated as twice the innermost stable circular orbit (ISCO) frequency $f_"ISCO" = 4400 thin M_⊙ / ( m_1 + m_2 ) thin "Hz"$\], and $S_h ( f )$ is the spectral density of the detector noise. The exponent $alpha$ is $7 / 3$ in the post-Newtonian limit up to the ISCO frequency and $2 / 3$ during the merging phase. For distant sources, one includes the redshift of the GW signal by replacing the source-frame chirp mass $cal(M)$ with $cal(M) thin ( 1 + z )$ and adapting the probed frequency range. Another, more precise, method used in Ref.~@Escriva:2022bwe is to multiply the merger rates by the volume-time sensitivity $chevron.l V T chevron.r$, computed by the LVK collaboration by injecting sets of waveform into the data, marginalised over all possible inclinations, sky locations, luminosity distances, spins etc.


The resulting distribution of detections for the combination of early and late binaries in the unified model of Ref.~@Carr:2019kxo, but improved by using simulations of PBH formation at the QCD epoch~@Escriva:2022bwe, is shown in @fig:Rate-LIGO-events. GW events are most likely observed between $30 thin M_⊙$ and $60 thin M_⊙$, which is where most observations lie. The second most likely region is the solar-mass scale, as expected for QCD peak. One coalescence has been observed in this region without an electromagnetic counterpart (GW190425) and attributed to a neutron star merger~@Abbott:2020uma. For early binaries, the event distribution would have a dominant peak at the solar-mass scale and so it is less likely that all the black holes between $20 thin M_⊙$ and $100 thin M_⊙$ were in early binaries. The distribution also exhibits a region with less expected events, between $5 thin M_⊙$ and $15 thin M_⊙$, where a few observations were made. This seems to conflict with the favoured PBH scenario but the importance of this gap depends on the model details and the statistical significance of this problem should be studied with Bayesian methods, as in Ref.~@2022arXiv220905959F.


// [figvision-cn] imgs/Figure_26.png
// 这是一张二维热力图（密度图/色图）叠加散点与参考线的科
// 学图表，用于展示双黑洞并合事件的质量分布及理论预期概率
// 密度。图中包含一个主坐标区和一个右侧色标。 坐标轴：横
// 轴（底边与顶边）标注为 m1 [M_⊙]（主质量，单位太阳质量），
// 采用对数刻度，底边刻度标签为 1、10、100，顶边刻度标签
// 为 1、10、100；纵轴（左侧）标注为 m2 [M_⊙]（次质量，单
// 位太阳质量），采用对数刻度，刻度标签为 1、10，10 上方
// 及 100 之间区域未标注，但物理范围约为 1 至 100。绘图区
// 域呈直角三角形状，左上边界为 m1 = m2 的对角线，左下边
// 界为 m1 = 1 与 m2 = 1 的直线，右下边界为 m1 = 100 的垂
// 直边。 色标（右侧竖直条）：颜色从深蓝到黄绿色渐变，深
// 蓝对应 0，依次经过约 0.5（蓝绿）、1.0（绿）、1.5（黄绿）
// 到顶部约 1.8；色标代表预期概率分布密度（单位任意），颜
// 色越偏黄绿表示概率密度越高，深蓝表示接近零。热力图有效
// 区域为 m1 ≥ m2 且 m1 ≤ 100 的三角形；概率密度在 m1 ≈
// 10–30、m2 ≈ 10–30 区域（即对角线附近）最高，呈现黄绿色；
// 在 m1 ≈ 30–100、m2 ≈ 1–10 的右下区域形成深蓝色低密度“
// 谷”，在 m1 ≈ 1–3、m2 ≈ 1–3 的左下角也有中等偏低的绿色
// 密度。 图中标注与线型： 白色实线：从底边 m1 ≈ 12 处向
// 右上延伸，穿过热力图，走向大致平行于 m1 = m2 对角线但
// 整体偏向右侧（m2 < m1），对应质量比 q = m2/m1 ≈ 0.1 的
// 轨迹（图注提及实线与虚线对应不同质量比，实线对应较低质
// 量比）。 白色虚线：从左下角 m1 ≈ 1、m2 ≈ 1 附近沿对角
// 线向右上延伸，贯穿高密度区域，大致经过 m1 ≈ m2 的位置，
// 对应质量比 q ≈ 1（相等质量）的轨迹。 红色散点与误差棒：
// 图中有大量红色十字/星形标记，代表观测到的双黑洞并合事
// 件样本。每个红色标记带有水平和垂直误差棒（表示 m1 和
// m2 的测量不确定度）。散点主要分布在对角线附近及偏右下
// 区域：在 m1 ≈ 3–10、m2 ≈ 3–10 有密集簇；在 m1 ≈ 20–60、
// m2 ≈ 5–30 区域也有较多事件；在 m1 ≈ 2、m2 ≈ 2 附近有少
// 量事件；在 m1 ≈ 40、m2 ≈ 2 处有一个带较大误差棒的事件。
// 红色散点整体趋势沿对角线分布，但部分事件明显偏离，位于
// 白色实线（q ≈ 0.1）与对角线之间或附近。 子图标注：该图
// 仅有一个主图，没有子图 a、b、c 的划分。左上角有刻度标
// 签“1.”，右上角有“100”，底部横轴左端为“1.”，右端为“100”。
// 图注提及“Solid and dashed white lines correspond to
// mass ratios of ... and ...”，但图中未直接标注具体数值，
// 实线对应较低质量比（接近 0.1），虚线对应较高质量比（接
// 近 1）。 趋势与结论：该图表明，在给定质量函数下，双黑
// 洞并合的预期概率密度在对数质量平面上沿对角线（m1 ≈ m2）
// 最高，并向高质量比（q 小）方向逐渐降低；LIGO O3 观测到
// 的红色事件样本主要落在高概率密度区域附近，但部分事件（
// 尤其是 m1 较大、m2 较小的系统）落在低概率密度区，说明
// 观测样本与理论预期分布存在一定差异，可能反映质量函数或
// 并合物理模型的细节。
#figure(placement: top, image("imgs/Figure_26.png", width: 100%),
  caption: [
    Expected probability distribution of PBH mergers with masses $m_1$ and $m_2$ for a mass function with $n_(upright(s)) = 0.97$ and LIGO sensitivity for O3 run. Solid and dashed white lines correspond to mass ratios $q equiv thin m_2 / m_1$ of $0.1$ and $0.5$, respectively. From Ref.~@Escriva:2022bwe.
  ]
)
<fig:Rate-LIGO-events>



Finally, some regions are not occupied by stellar black hole mergers but are a distinctive prediction of PBH models. These regions correspond to the pair-instability mass gap (above $60 thin M_⊙$), the subsolar region, the low-mass gap (between approximately $2.5$ and $5 thin M_⊙$) and binaries with low mass ratios. There are multiple observations of compact objects in these regions and GWTC-3 indicates that these regions exhibit only smooth transitions in merger rates~@KAGRA:2021duu. This is hard to explain with a stellar model but natural for PBHs. We now discuss each case in more detail.


#figure(
  table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([Event], [Mass 1 $\[ thin M_⊙ \]$], [Mass 2 $\[ thin M_⊙ \]$], [Rate $cal(R) \[ upright("yr"^(- 1) "Gpc"^(- 3) \])$],),
    table.hline(),
    table.hline(),
    [GW190403\_051519], [$85_(- 33.0)^(+ 27.8)$], [$20.0_(- 8.4)^(+ 26.3)$], [],
    [GW190426\_190642], [$105.5_(- 24.1)^(+ 45.3)$], [$76.0_(- 36.5)^(+ 26.2)$], [],
    [GW190519\_153544], [$66.0_(- 12.0)^(+ 10.7)$], [$40.5_(- 11.1)^(+ 11.0)$], [],
    [GW190521], [$95.3_(- 18.9)^(+ 28.7)$], [$69.0_(- 23.1)^(+ 22.7)$], [$\[ 0.02 thin "–" thin 0.43 \]$],
    [GW190602\_175927], [$69.1_(- 13.0)^(+ 15.7)$], [$47.8_(- 17.4)^(+ 14.3)$], [],
    [GW190706\_222641], [$67.0_(- 16.2)^(+ 14.6)$], [$38.2_(- 13.3)^(+ 14.6)$], [],
    [GW190929\_012149], [$80.8_(- 33.2)^(+ 33.0)$], [$24.1_(- 10.6)^(+ 19.3)$], [],
    [GW191109\_010717], [$65_(- 11)^(+ 11)$], [$47_(- 13)^(+ 15)$], [],
    [GW200220\_061928], [$87_(- 23)^(+ 40)$], [$61_(- 25)^(+ 26)$], [],
    table.hline(),
    [GW190814], [$23.2_(- 1.0)^(+ 1.1)$], [$2.59_(- 0.09)^(+ 0.08)$], [$\[ 1 thin "–" thin 23 \]$],
    [GW190917\_114630], [$9.7_(- 3.9)^(+ 3.4)$], [$2.1_(- 0.4)^(+ 1.1)$], [],
    [GW190924\_021846], [$8.9_(- 2.0)^(+ 7.0)$], [$5.0_(- 1.9)^(+ 1.4)$], [],
    [GW191219\_163120], [$31.1_(- 2.8)^(+ 2.2)$], [$1.17_(- 0.06)^(+ 0.07)$], [],
    [GW200105\_162426], [$9.0_(- 1.7)^(+ 1.7)$], [$1.91_(- 0.24)^(+ 0.33)$], [],
    [GW200210\_092254], [$24.1_(- 4.6)^(+ 7.5)$], [$2.83_(- 0.42)^(+ 0.47)$], [],
  ),
  caption: [GW events reported in the catalogs GWTC-1~@LIGOScientific:2018mvr, GWTC-2~@LIGOScientific:2020ibl, GWTC-2.1~@LIGOScientific:2021usb and GWTC-3~@2021arXiv211103606T, with at least one component in the pair-instability mass gap (above $60 thin M_⊙$) or low-mass gap (between $2.5 thin M_⊙$ and $5 thin M_⊙$), or with low mass ratios ($q tilde 0.1$), together with the mass uncertainties. When available, the associated merger rates are given.],
  kind: table
) <tab:exceptional>


== Black Holes in the Pair-Instability Mass Gap
<sec:Black-Holes-in-the-Pair--Instability-Mass-Gap>


The most intriguing and unexpected GW observations involve black hole mergers with component masses in the pair-instability mass gap. Above a mass of around $60 thin M_⊙$, the temperature in the core of stars becomes so high during oxygen-burning that electron-positron pair production leads to a reduction of the pressure and core collapse. Below a mass of around $150 thin M_⊙$, the star explodes as a supernova without any remnant. As a result, stars are not expected to directly form black holes with mass between about $60 thin M_⊙$ and $150 thin M_⊙$. This pair-instability mass gap is well established theoretically, even if the exact range can be debated.


With component masses of $66 thin M_⊙$ and $85 thin M_⊙$, GW190521 is the first observation of at least one (and probably two) black holes in this mass gap. Reference~@Nitz:2020mga argues that the error bars on the masses might allow the two objects to be just at the limit of the mass gap. However, GWTC-3 contains several additional candidates (GW190403051519, GW190426190642, GW190519153544, GW190602175927, GW190706222661, GW190929012149, GW191109010717, GW200220061928) with components in the range from $61 thin M_⊙$ to $107 thin M_⊙$ (shown in #ref(<tab:exceptional>, supplement: [Tab.]) together with corresponding uncertainties), so this becomes unlikely. A deeper analysis of the merger rates provides statistical evidence for a smooth transition across the mass gap, with no evidence for a break~@KAGRA:2021duu. Also, there is some evidence for the dynamical formation of the progenitor binary~@Gamba:2021gap, with some Bayesian evidence in favour of a hyperbolic merger. PBHs offer an interesting alternative explanation for the events, still in the context of a dynamical capture, since their mass function should vary smoothly in the $10 thin "–" thin 100 thin M_⊙$ range. However, if they form from primordial density fluctuations, there should be a bump at around $30 thin "–" thin 100 thin M_⊙$ coming from the epoch of the pion formation (see @sec:Thermal--History-Scenario).


In principle, black holes in the pair-instability mass gap could result from previous mergers (e.g.~of two $30 thin "–" thin 50 thin M_⊙$ black holes). However, the observed merger rates require binary formation in dense black hole environments, such as globular clusters or active galactic nuclei disks. There are several difficulties with this scenario. First, it is intriguing that GW190521, GW190426\_190642 and GW200220\_061928 probably have two components in the mass gap; one would expect the secondary black holes to mainly merge with primary black holes between $20 thin M_⊙$ and $50 thin M_⊙$. Second, the velocity kick acquired in a previous merger typically exceeds the escape velocity of globular clusters. Third, the black hole mass and rate distribution above $20 thin M_⊙$ change continuously across the pair-instability mass gap. Even if one cannot rule it out, the previous-merger scenario may conflict with the latest observations.


== Black Holes in the Low-Mass Gap
<sec:Black-Holes-in-the-Low--Mass-Gap>


Observations of X-ray binaries provide strong statistical evidence for a gap between approximately $2.5 thin M_⊙$ and $5 thin M_⊙$ in the stellar black hole mass distribution~@Bailyn:1997xt @Farr:2010tu. This can be explained by numerical simulations of supernova explosions due to carbon deflagration. A gap in the mass distribution of binary coalescences from GW observations was therefore expected. However, the latest catalogs~@LIGOScientific:2020ibl @LIGOScientific:2021usb @2021arXiv211103606T reveal two mergers with at least one progenitor in the expected gap (GW190814 and GW200210\_092254) and two others lying near the boundary of the gap (GW190924\_021844, GW200115\_042309). Overall, observations do not support the existence of this gap, even if the statistical significance is not yet very high and the mass uncertainties are large. The existence of black holes in the mass gap is also supported by microlensing observations of OGLE/#emph[Gaia] towards the Galactic centre (see @sec:Galactic-Bulge). If confirmed, this discrepancy between X-ray and GW observations cannot easily be explained with stellar models. However the existence of PBHs in the low-mass gap is natural since they would come from the large-mass tail of the QCD peak.


== Binaries with Asymmetric Masses
<sec:A-Binary-with-Asymmetric-Masses>


The event GW190814~@2020ApJ...896L..44A is exceptional, not only because its secondary component lies in the lower mass gap, but also because of the observed very low mass ratio, $q equiv thin m_2 / m_1 approx 0.1$. The existence of such asymmetric binaries is not excluded for astrophysical black hole populations, but it is difficult to explain why their associated merger rate is only slightly lower than for binaries with similar masses. Asymmetric binaries are also interesting because one can reconstruct the individual spin of the primary component $chi_1$, which is very low for GW190814: $chi_1 < 0.07$ at $90 "%"$ CL (see next subsection). This has led the LVK collaboration to claim that #emph[“the combination of mass ratio, component masses, and the inferred merger rate for this event challenges all current models of the formation and mass distribution of compact-object binaries.”] On the other hand, such binaries are expected for PBH models~@Clesse:2020ghq, especially when one includes QCD-induced features in their mass function: a dominant bump at $m_1 approx 2.5 thin M_⊙$ and a smaller bump at $m_1 approx 30 thin "–" thin 50 thin M_⊙$. GW190814 could therefore involve PBHs from both bumps, as shown in @fig:Rate-LIGO-events. We note that Eqs.~((#ref(<eq:cosmomerg>), #ref(<eq:ratescatpure2>))) naturally give rates of order $R tilde 10 thin "yr"^(- 1) thin "Gpc"^(- 3)$ with $f ( m_1 ) tilde 1$ and $f ( m_2 ) tilde 0.02$.


GWTC-3 contains information about a few additional coalescences with mass ratios below $0.25$: GW200210\_092254 (similar to GW190814), GW200115\_042309 ($5.4 thin M_⊙$ and $1.4 thin M_⊙$) as well as GW191219\_163121. For the latter, the secondary mass is around $1.2 thin M_⊙$ and $q tilde.eq 0.04$, which would make it the lowest mass neutron star ever observed. The mass properties of these GW events are indicated in #ref(<tab:candidate>, supplement: [Tab.]). As shown in @fig:Rate-LIGO-events, one can obtain a broad range of low-mass-ratio mergers for a wide PBH mass function. Future observations may soon provide additional information on the abundance of such asymmetric binaries and their merger rates. For PBHs, one cannot exclude LVK observing even lower mass ratios (down to $q tilde.eq 0.001$) using continuous-wave methods~@Miller:2021knj @Miller:2020kmv but specific waveforms must be assumed for such searches. For broad PBH mass distributions, asymmetric binaries also boost the stochastic GW background to a level observable with upcoming runs~@Bagui:2021dqi.


== Subsolar Candidates
<sec:Subsolar-Candidates>


Given the broad variety of PBH and stellar black hole scenarios, such models could accommodate very different mass, rate and spin distributions. It is therefore crucial to identify a clear signature of PBHs that cannot be explained by black holes of stellar origin. There are two observations that would point towards a PBH origin. The first is detecting a black hole merger from a redshift before the first stars formed (viz.~$z > 20$)~@2020JCAP...08..039C. For chirp masses above or around $30 thin M_⊙$, such redshifts will become accessible to the third generation of ground-based GW detectors, such as the #emph[Einstein Telescope]~@2020JCAP...03..050M and #emph[Cosmic Explorer]~@Evans:2021gyd. Their expected redshift range for different values of the signal-to-noise ratios is shown in @fig:horizon, as a function of the total binary black hole mass. As indicated there, intermediate-mass or supermassive black holes will be probed by space interferometers like LISA~@LISACosmologyWorkingGroup:2022jok and pulsar timing arrays. The second signature would be the detection of a black hole smaller than $1 thin M_⊙$. Detecting a subsolar-mass black hole can already be achieved with the current generation of GW detectors. The first subsolar LIGO/Virgo searches were unsuccessful~@Abbott:2018oah @Authors:2019qbw but only focused on binaries with a primary component smaller than $2 thin M_⊙$. Similar searches were performed independently~@Nitz:2022ltl @Nitz:2021vqh and rate limits obtained for asymmetric binaries in Refs.~@Nitz:2021mzz @Nitz:2020bdb.


// [figvision-cn] imgs/Figure_27.png
// 该图为单一坐标平面内的等值线图，类型为科学论文中的参数
// 空间分布图。纵轴为 Redshift z，采用对数刻度，范围从
// 0.01 到 1000，刻度标注为 0.01、0.1、1、10、100、1000。
// 横轴为 \(M_{\rm tot}\ [M_\odot]\)，表示总源质量（单位：
// 太阳质量），采用对数刻度，范围从 1 到 \(10^{11}\)，标
// 注的刻度为 1、10、\(10^2\)、\(10^3\)、\(10^4\)、\(10^5
// \)、\(10^6\)、\(10^7\)、\(10^8\)、\(10^9\)、\(10^{10}\
// )、\(10^{11}\)。 右侧有两个色标。第一个色标为 SNR（信
// 噪比），颜色从深蓝渐变到紫色、洋红、橙色、黄色，标注刻
// 度为 5、10、\(10^2\)、\(10^3\)、\(10^4\)、\(10^5\)、\(
// 10^6\)、\(10^7\)，表示信号强度由低到高。第二个色标为 \
// (t_{\rm cosmic}\ [\mathrm{Gyr}]\)（宇宙时间，单位十亿
// 年），标注刻度为 13.5、13、10、5、1、0.5、0.1、0.01、
// 0.001，用于标示图中等值线对应的宇宙年龄。 图中以颜色填
// 充表示 SNR 的空间分布，并叠加黑色等值线。图中标出了五
// 种引力波探测器的敏感区域及其标注文字： Einstein
// Telescope: Design D：位于图幅左中部，覆盖红移约 0.05
// 到 100、总质量约 1 到 \(10^3\ M_\odot\) 的区域，处于深
// 紫至紫色带。 Advanced LIGO：位于图幅左下，覆盖红移约
// 0.01 到 1、总质量约 1 到 \(10^3\ M_\odot\) 的区域，用
// 深色线条勾勒。 LISA: L3 Proposal：占据图幅中下方大面积
// 区域，覆盖红移约 0.01 到 10 的宽范围，总质量从约 \(10^
// 3\) 延伸到 \(10^9\ M_\odot\) 以上，颜色由紫至橙黄递增。
// IPTA30: WN Only：位于图幅右上角，覆盖红移约 10 到 1000、
// 总质量约 \(10^8\) 到 \(10^{11}\ M_\odot\) 的区域，呈紫
// 色竖条带。 NANOGrav: 11yr Data：位于图幅右侧，覆盖红移
// 约 0.1 到 10、总质量约 \(10^9\) 到 \(10^{11}\ M_\odot\
// ) 的区域，中心区域颜色为深紫，并带有黑色等值线。 整体
// 趋势与结论：望远镜的 SNR 高值区域（黄色/橙色）集中在
// LISA 覆盖的低红移、大质量范围，以及爱因斯坦望远镜覆盖
// 的低质量、中等红移范围；NANOGrav 和 IPTA30 主要覆盖高
// 红移、大质量范围，对应较低的 SNR 值（深紫色）。不同探
// 测器敏感的红移与质量区间存在明显分工与互补。
#figure(placement: top, image("imgs/Figure_27.png", width: 80.0%),
  caption: [
    Signal-to-Noise Ratio (SNR) as a function of source redshift and total source mass for various GW detectors: #emph[Einstein Telescope] (design model D), advanced LIGO, LISA (L3 proposal), IPTA30 (WN only) and NANOGrav (11yr). From Ref.~@Kaiser:2020tlg.
  ]
)
<fig:horizon>



A recent re-analysis of data from the second Advanced LIGO run, including binaries with a $2 thin M_⊙ < m_1 < 10 thin M_⊙$ primary component and a subsolar secondary component, has revealed four subsolar black hole candidates with a signal-to-noise larger than $8$ and a false-alarm-rate smaller than $2$ per year~@2021arXiv210511449P. These threshold are the usual ones for LVK detections. Two candidates are seen by only a single detector (one in Livingston and the other in Hanford), so are more likely attributed to noise but the others are seen in several detectors.


The properties of these candidates, inferred from the template bank, are shown in #ref(<tab:candidate>, supplement: [Tab.]). Some parameter estimation is ongoing to check their validity and confirm that the secondary component is indeed subsolar. Although noise might mimic such a signal, we tentatively consider these four candidates as possible PBHs. Recently, three additional subsolar triggers have been reported by the second half of the third LIGO/Virgo run~@LVK:O3bSSM based on the same threshold. Their properties are shown in #ref(<tab:candidate>, supplement: [Tab.]) but they were only detected by one of the pipelines used in the search. If more clear-cut candidates are observed in future observing runs, this would clearly provide evidence for PBHs. Alternative explanation exist, such as black holes formed from accretion of dark matter particles~@Garani:2021gvc @Kouvaris:2018wnh, by dissipative dark matter~@Gurian:2022nbx @Shandera:2018xkn, or neutron stars with non-standard equation of state (a subsolar neutron star may have already been observed~@2022NatAs.tmp..224D). However, PBHs would be the favoured interpretation of subsolar-mass compact objects.


#figure(
  table(
    columns: 10,
    align: (center,center,center,center,center,center,center,center,center,center,),
    table.header([Date], [FAR \[yr$""^(- 1)$\]], [$m_1 \[ M_⊙ \]$], [$m_2 \[ M_⊙ \]$], [spin-1-$z$], [spin-2-$z$], [H SNR], [L SNR], [V SNR], [Network SNR],),
    table.hline(),
    [2017-04-01], [0.41], [4.90], [0.78], [$- 0.05$], [$- 0.05$], [6.32], [5.94], [--], [8.67],
    [2017-03-08], [1.21], [2.26], [0.70], [$- 0.04$], [$- 0.04$], [6.32], [5.74], [--], [8.54],
    [2020-03-08], [0.20], [0.78], [0.23], [0.57], [0.02], [6.31], [6.28], [--], [8.90],
    [2019-11-30], [1.37], [0.40], [0.24], [0.10], [$- 0.05$], [6.57], [5.31], [5.81], [10.25],
    [2020-02-03], [1.56], [1.52], [0.37], [0.49], [0.10], [6.74], [6.10], [--], [9.10],
  ),
  caption: [Reported properties (date, component masses and spins) of the subsolar triggers in Refs.~@2021arXiv210511449P @LVK:O3bSSM, with a network signal-to-noise ratio (SNR) $> 8$ and false-alarm rate (FAR) $< 2 thin "yr"^(- 1)$ in the second and third observing runs of LIGO/Virgo.],
  kind: table
) <tab:candidate>


For one of these subsolar-mass triggers, SSM170401, a parameter estimation has been performed~@Morras:2023jvb, assuming that the signal comes from a real GW event. The results are consistent with expectation for a real signal. However, after removing a glitch, even if one considers more precise waveforms and a lower minimum frequency of $20 thin$Hz, the signal-to-noise ratio does not increase and is even slightly reduced from $8.6$ to $7.94$ if one includes marginalisation over the analysed parameters. Nevertheless, the posterior probability distribution for the secondary mass supports a subsolar-mass at $84$% CL. The posterior distributions are shown in @fig:SSM-events. These results are not sufficiently statistically significant to claim a firm observation of a subsolar object, so the signal could be due to noise, but it remains an interesting possibility. In order to better assess this possibility, one would have to run similar parameter estimations for the other triggers reported in the third observing run. One also has to understand the origin of the different ranking statistics obtained with the various pipelines. But it is plausible that SSM170401 is the first subsolar-mass PBH observed by GW detectors. We emphasise that observing a subsolar-mass black hole is the only way to prove the existence of PBHs with the current generation of detectors, so this research line should be pursued in a cautious way, given the far-reaching consequence of such a discovery.


// [figvision-cn] imgs/Figure_28.png
// 这是一个角图（corner plot），用于展示SSM170401事件在假
// 设为真实引力波信号时，主成分质量m1source和次成分质量
// m2source的后验概率分布。图中包含三个子图：中央的二维等
// 高线图（联合后验概率）、顶部的一维边缘概率分布图（
// m1source）和右侧的一维边缘概率分布图（m2source）。图中
// 比较了两种波形模型：IMRPhenomPv2（绿色）和
// IMRPhenomXPHM（蓝色）。质量单位均为太阳质量M⊙。 中央二
// 维图：横轴为m1source [M⊙]，范围从1到7；纵轴为m2source
// [M⊙]，范围从0.4到1.5。图中显示了两组闭合的等高线（通常
// 代表50%和90%可信区间）。绿色（IMRPhenomPv2）和蓝色（
// IMRPhenomXPHM）等高线均呈现从左上向右下倾斜的带状分布，
// 表明m1source与m2source之间存在明显的负相关性（即一个质
// 量增大时另一个倾向于减小）。蓝色等高线内部填充有颜色深
// 浅不一的二维直方图（像素化），颜色越深代表后验概率密度
// 越高，最高密度区域集中在m1source约4.5-5.5、m2source约
// 0.7-0.8附近。蓝色等高线（IMRPhenomXPHM）向低m2source方
// 向延伸得更远，其下边界接近0.6 M⊙。绿色等高线（
// IMRPhenomPv2）则相对更紧凑，下边界约在0.63 M⊙。图中有
// 一条从左上角（约m1source=1, m2source=1.5）发出的浅灰色
// 细线，代表m1source=m2source的对角线，但数据分布明显偏
// 离此线。图中还包含垂直和水平的虚线参考线：两条垂直蓝色
// 虚线分别位于m1source约2.5和6.5处，一条垂直绿色虚线位于
// m1source约6.1处；两条水平蓝色虚线分别位于m2source约
// 0.63和1.28处，一条水平绿色虚线位于m2source约0.65处。这
// 些虚线对应于一维边缘分布图中特定模型的置信区间边界。
// 顶部一维边缘概率分布图：横轴与中央图共享m1source [M⊙]
// （1到7），纵轴为概率密度（无具体刻度标签，但可见相对高
// 度）。图中显示两条曲线：绿色曲线（IMRPhenomPv2）和蓝色
// 曲线（IMRPhenomXPHM）。两条曲线均呈现双峰结构。第一个
// 峰位于m1source约2.5 M⊙处，蓝色峰略高于绿色峰；第二个主
// 峰位于m1source约5.0-5.5 M⊙处，绿色峰略高于蓝色峰且位置
// 稍偏右。蓝色曲线在m1source约5.8 M⊙处有一个明显的肩部或
// 次峰结构。曲线下方填充有浅蓝色。图中垂直虚线（蓝色在~
// 2.5和~6.5，绿色在~6.1）标示了相应模型的90%可信区间上限
// 或特定分位数。整体趋势表明，主成分质量最可能落在约5 M⊙
// 附近，但也存在一个次要的、较低质量的解（约2.5 M⊙），且
// IMRPhenomXPHM模型对低质量解的支撑略强。 右侧一维边缘概
// 率分布图：纵轴与中央图共享m2source [M⊙]（0.4到1.5），
// 横轴为概率密度（无具体刻度标签）。图中显示两条曲线：绿
// 色（IMRPhenomPv2）和蓝色（IMRPhenomXPHM）。两条曲线均
// 呈现单峰结构，峰值位于m2source约0.7-0.75 M⊙处。蓝色曲
// 线在低质量端（约0.6 M⊙）有一个明显的延伸或肩部，而绿色
// 曲线在低质量端下降更快。曲线下方填充有浅蓝色。水平虚线
// （蓝色在~0.63和~1.28，绿色在~0.65）标示了相应模型的90%
// 可信区间下限和上限。整体趋势表明，次成分质量最可能约为
// 0.7 M⊙，且IMRPhenomXPHM模型允许更低质量（接近0.6 M⊙）
// 的解。 图例位于顶部一维图下方，标注了绿色线为
// IMRPhenomPv2，蓝色线为IMRPhenomXPHM。该图传达的结论是：
// 在假设信号为真实引力波事件的前提下，SSM170401的次成分
// 质量后验概率在约0.7 M⊙处达到峰值，且向亚太阳质量区域延
// 伸，在特定置信水平下偏好亚太阳质量成分，但无法排除信号
// 来自噪声或中子星/黑洞并合的可能性。两种波形模型给出的
// 结果存在一定差异，主要体现在低质量端的分布宽度和双峰结
// 构的相对权重上。
#figure(placement: top, image("imgs/Figure_28.png", width: 100%),
  caption: [
    Posterior probability distributions of the primary and secondary component masses $m_1$ and $m_2$ of SSM170401, observed during the second observing run of Advanced LIGO, assuming that the signal comes from a real GW event. A subsolar-mass $m_2$ is preferred at $84 "%"$ CL but one cannot rule out that the signal is due to noise or a neutron star/black hole merger. From Ref.~@Morras:2023jvb.
  ]
)
<fig:SSM-events>



In a recent study, Wolfe #emph[et al.]~@Wolfe:2023yuu have presented a detailed analysis of the measurability of the mass, spin and sky location for binary black hole mergers with least one subsolar-mass component. They find that next-generation detectors, such as #emph[Cosmic Explorer] and the #emph[Einstein Telescope], will enable measurements of the source-frame component masses down to $cal(O) ( 10^(- 5) ) thin M_⊙$. Furthermore, due to the long duration of these signals, it should be possible to confidently identify sub-solar components at the threshold of detectability even during the fourth observing run of LVK, with these events being well sky-localised and possibly revealing characteristic spin information. This is indicated in @fig:sky-localisation. However, for a clear attribution of these signals to black holes, future work on the development of waveforms --- calibrated for subsolar-mass compact-object mergers and including tidal deformability --- is necessary.


// [figvision-cn] imgs/Figure_29.png
// 这是一张单面板科学散点图，没有子图分幅。图的横轴为网络
// 信噪比（Network SNR），采用对数刻度，标注的刻度值为10^
// 1、10^2、10^3，范围约从7到2000；纵轴为90%置信区域（90%
// confidence region），单位为平方度（square degrees），
// 采用对数刻度，标注的刻度值从10^-2到10^4，范围约从5×10^
// -3到2×10^4。图右上角有一个图例，包含六种灰色线型和三种
// 数据点符号。数据点方面：紫色圆点表示注入到LVK O4设计灵
// 敏度网络的次太阳质量并合信号，共约15个点，横轴范围约7
// 到30，大部分集中在纵轴10^1到2×10^4之间，最低点约在横轴
// 25、纵轴4×10^0；黄色圆点表示注入到由Cosmic Explorer和
// Einstein Telescope组成的3G网络的信号，共约12个点，横轴
// 范围约200到1500，纵轴范围约6×10^-3到2×10^-1，整体呈随
// 信噪比增大而置信区域减小的趋势；浅蓝色五角星表示近等质
// 量双中子星GW170817，位于横轴约28、纵轴约25处。灰色参考
// 线方面：深灰色粗虚线标注TMT，水平位于纵轴约5×10^-3处；
// 深灰色点线标注DECam，水平位于纵轴约3×10^0处；深灰色点
// 划线标注ngVLA，水平位于纵轴约7×10^0处；深灰色密点线标
// 注Rubin，水平位于纵轴约9×10^0处；深灰色间断线标注ZTF，
// 水平位于纵轴约4×10^1处。所有灰色参考线均为水平贯穿全图
// 的直线，代表各天文设施对应的典型定位区域面积。图中没有
// 其他标注文字。该图传达的趋势是：随着网络信噪比的提高，
// 次太阳质量并合信号的90%置信区域面积显著减小；3G网络相
// 比O4网络能在更高信噪比下将定位区域缩小至0.01至0.1平方
// 度量级，接近或低于TMT等设施的视场参考线；而GW170817的
// 定位区域约为25平方度，与O4网络下部分注入信号的结果相当。
#figure(placement: top, image("imgs/Figure_29.png", width: 100%),
  caption: [
    Localisation areas ($90 "%"$ CL) as function of network SNR for all subsolar-mass merger signals studied in Ref.~@Wolfe:2023yuu. Coloured dots indicate injected signals into the LVK O4-design sensitivity network (purple) and a network of #emph[Cosmic Explorer] and #emph[Einstein Telescope] (yellow), respectively. The light-blue star indicates the near equal-mass binary neutron star GW170817. Also shown as gray lines are the fields of view for the electromagnetic follow-up observations with ZTF (dash-dot-dotted), #emph[Vera Rubin Observatory] (dotted), #emph[next-generation Very Large Array] (ngVLA; dash-dotted), #emph[Dark Energy Camera] (DECam; wide-spaced dots), and the #emph[Thirty-Meter Telescope] (TMT; dashed). From Ref.~@Wolfe:2023yuu.
  ]
)
<fig:sky-localisation>



== Black Hole Spins
<sec:Black-Hole-Spins>


Another unexpected property of the first detected coalescences is their low effective spins, often compatible with zero. The effective spin $chi_"eff"$ of a binary is defined as $ chi_(upright("eff")) equiv frac(1, thin m_1 + thin m_2) thin \[ m_1 S_1 cos ( theta_(upright(L) S_1) ) + m_2 S_2 cos ( theta_(upright(L) S_2) ) \] thin , $ where $m_i$ is the mass, $S_i$ the spin and $theta_(upright(L) S_i)$ the angle between the spin and the orbital momentum for each component ($i = 1 , #h(0em) 2$). If the two masses are almost equal, a low effective spin may indicate that the individual spins are similar and anti-aligned, as expected for stellar black hole binaries. But the fact that $chi_"eff"$ remains low and compatible with zero for the vast majority of binaries observed so far~@2021arXiv211103606T, even for different progenitor masses, suggests that the individual spins are also low. This is further supported by the individual spin of the primary component of GW190814, $chi_1 equiv S_1 cos theta_(upright(L) S_1) < 0.07$ at $90 "%"$ CL, this being well determined due to the mass asymmetry. Low spins are also most likely for the primary components of other asymmetric binaries, which disfavours a spin orientation that is orthogonal to the orbital plane for GW190814 by chance. Low spins for black hole binaries are not expected for popular stellar models, such as the Geneva model, since these should produce a wide effective spin distribution with a peak around $chi_"eff" approx 0.8$.


In some astrophysical scenarios, it is possible to produce such low spins (see e.g.~Refs.~@Belczynski:2017gds @Bavera:2020inc), so an astrophysical origin cannot be excluded on this basis alone. But low spin is a generic outcome for PBHs since these must have almost vanishing spin at formation~@DeLuca:2019buf. This is because they are close to the Hubble horizon size at formation and therefore do not collapse much. Also the rare large initial fluctuations from which they form are expected to be nearly spherical~@1986ApJ...304...15B. While chaotic accretion may reduce the PBH spin, other factors --- such as coherent accretion, previous mergers and hyperbolic encounters in dense PBH environments --- are expected to broaden the spin distribution~@2021PDU....3400882J. In particular, for coalescences in the pair-instability mass gap, this would result in a distribution of $chi_"eff"$ centred on zero but with some non-zero values. There is some evidence for non-zero $chi_"eff"$ in the most recent catalogue. In particular, GW190521 has at least one component in the pair-instability gap. PBHs therefore provide a natural explanation for the low binary spins inferred from GW observations and this complements the other evidence.


In order to quantify the weight of this evidence, several studies~@Fernandez:2019kyb @Garcia-Bellido:2020pwq @Wong:2020yig @DeLuca:2021wjr have compared the Bayes factor for PBH and astrophysical black hole models. All of them favour either PBHs or a mixed population. However, more data and more precise PBH and astrophysical models are needed to better distinguish them with a Bayesian approach~@Garcia-Bellido:2020pwq.


Finally, some events in GWTC-3 seem to have spins compatible with a random spin orientation, which suggests a dynamical formation channel in a dense black hole environments~@KAGRA:2021duu. Active galactic nuclei and globular clusters are a plausible context for this but PBHs are also expected to be clustered due to Poisson fluctuations (@sec:Clustering-of-PBHs). An important difference between the two scenarios is that black holes from secondary mergers should have all acquired large spins, whereas smaller spins are expected for PBHs. A statistical analysis of the spins of black holes in the pair-instability mass gap could soon discriminate between these explanations.


== Pulsar-Timing Arrays
<sec:Pulsar--Timing-Arrays>


The NANOGrav collaboration have recently reported a possible detection of a GW background at nano-Hertz frequency~@NANOGrav:2020bcs using pulsar timing arrays (PTA). This has been confirmed by the #emph[European Pulsar Timing Array] (EPTA)~@Chen:2021rqp, Parkes~@Goncharov:2021oub and IPTA~@Antoniadis:2022pcn collaborations, although the GW origin still had to be demonstrated. This claim was confirmed in June 2023, based on updated PTA data from the #emph[North American Nanohertz Observatory for Gravitational Waves] (NANOGrav)~@NANOGrav:2020bcs, the #emph[European Pulsar Timing Array] (EPTA)~@Chen:2021rqp, the #emph[Parkes]~@Goncharov:2021oub and #emph[International Pulsar Timing Array] (IPTA)~@Antoniadis:2022pcn collaborations. Strong evidence was also found for the Hellings--Downs correlations~@1983ApJ...265L..39H predicted by the quadrupolar nature of GWs.


Such a GW background could have been sourced by the second-order perturbations associated with the large density fluctuations needed to form PBHs. Several groups have suggested this and the signal frequency would be associated with PBHs in the stellar~@DeLuca:2020agl @Vaskonen:2020lbd @Kohri:2020qqd @Yi:2021lxc @Dandoy:2023jot @Inomata:2020xad or even planetary~@Domenech:2020ers mass range. There were also claims that the amplitude of the PTA signal excludes PBHs as the source of the signal because it would require a PBH abundance larger than that associated with the dark matter~@Inomata:2020xad @Dandoy:2023jot @Ellis:2023oxs. However, the uncertain shape of the primordial power spectrum, the possibility of non-Gaussianity~@Wang:2023ost @Franciolini:2023pbf and non-Gaussian tails~@Ferrante:2023bgz in the fluctuation statistics~@Inomata:2020xad, the model dependence of the critical overdensity threshold~@DeLuca:2023tun, together with other uncertainties, make it difficult to estimate the PBH dark matter fraction required to explain such a signal. Nevertheless, the range $10^(- 3) < f_"PBH" < 1$ could be accommodated. Given its shape, and assuming Gaussian fluctuations, it is still possible to set limits on and identify the most likely amplitude of the primordial power spectrum on scales that are relevant for the formation of stellar-mass PBHs. The results obtained using the most recent IPTA data and a log-normal primordial power spectrum are shown in @fig:PTA, where the required amplitude to get $f_"PBH" = 1$ is also estimated~@Dandoy:2023jot.


Even if some papers claim that there is an inconsistency between the value of $f_"PBH"$ required for this model and the merger rates inferred from LVK observations, given the large uncertainties and model-dependence of the critical threshold~@DeLuca:2023tun, mass distributions, merger rates and possible non-Gaussianity, we regard the order-of-magnitude coincidence between the value of $f_"PBH"$ required for the NANOGrav signal and the LIGO/Virgo merger rates as favouring PBHs. Even if the NANOGrav detection has a GW origin, there are alternative sources, such as SMBH binaries or cosmic strings, and the recent analysis of Ref.~@Ellis:2023oxs compares possible astrophysical and cosmological explanations. Another PBH-related explanation, given that the signal for extended mass distribution is boosted, could be late binaries in clusters~@Bagui:2021dqi or SMBH binaries of primordial origin~@Depta:2023qst. It has also been proposed that such a GW background is produced by the mergers of stupendously large PBHs~@Atal:2020yic, or during a first-order phase transition at the origin of stellar-mass or heavier PBHs~@Ashoorioon:2022raz.


// [figvision-cn] imgs/Figure_30.png
// 这是一张二维后验概率分布等值线图（二维相图），标题为“
// Scalar induced GWs only”（仅标量诱导引力波）。图中展示
// 了两个数据集对原初功率谱峰值振幅的限制。横轴为峰值波数
// k*，单位为 Mpc⁻¹，采用对数刻度，范围约为 5×10⁴ 到 2×10
// ⁷ Mpc⁻¹；纵轴为峰值振幅 A_ζ，采用对数刻度，范围约为 3×
// 10⁻³ 到 10⁻¹。图内包含两组填充等值线：深蓝色填充区域代
// 表 IPTADR2 数据（第二次国际脉冲星计时阵列数据发布），
// 绿色填充区域代表 NG12 数据（NANOGrav 12.5 年数据）。每
// 组等值线包含内层深色区域（约 68% 置信区间）和外层浅色
// 区域（约 95% 置信区间），并配有同色系轮廓线。IPTADR2
// 的允许区域呈长椭圆形，中心约在 k* ≈ 3×10⁶ Mpc⁻¹、A_ζ ≈
// 0.03 处，纵向延伸较窄；NG12 的允许区域呈宽大的倒三角形，
// 从 k* ≈ 5×10⁴ Mpc⁻¹ 向下延伸至 A_ζ ≈ 10⁻² 以下，中心约
// 在 k* ≈ 2×10⁶ Mpc⁻¹、A_ζ ≈ 0.008 处，横向和纵向覆盖范
// 围均大于 IPTADR2。一条黑色点线斜穿全图，从左上方（约 k
// * = 10⁵ Mpc⁻¹、A_ζ = 0.1）向右下方延伸，在 k* ≈ 2×10⁶
// Mpc⁻¹ 处达到极小值（约 A_ζ = 0.025），然后略微回升至右
// 边缘（k* = 10⁷ Mpc⁻¹、A_ζ ≈ 0.04），线上标注文字为“
// f_PBH = 1(Δ = 1)”。图中无显微照片或比例尺。该图传达的
// 趋势是：若观测信号完全来自标量诱导引力波，NG12 数据对
// 宽波数范围内的振幅给出较宽松限制，而 IPTADR2 数据将允
// 许区域显著收窄并移向更高振幅；黑色点线表示产生丰度为 1
// 的原初黑洞所需的振幅—波数关系，IPTADR2 的高概率区域紧
// 贴该点线，表明 IPTADR2 数据更支持原初黑洞暗物质假说。
#figure(image("imgs/Figure_30.png", width: 65.0%),
  caption: [
    Two-dimensional posterior distributions ($1 sigma$ and $2 sigma$ contours) of the primordial power spectrum amplitude $A_zeta$ at peak scale $k_(*)$, assuming a log-normal shape of width $Delta = 1$, from the NANOGrav $12.5$-year (green) and second IPTA data release (blue) observations of PTAs, if the observed signal comes from scalar-induced GWs. The dotted line represents the expected amplitude leading to $f_"PBH" = 1$ on which one can identify the bumpy feature due to the QCD-epoch leading to solar-mass PBHs. From Ref.~@Dandoy:2023jot.
  ],
  placement: top,
)
<fig:PTA>






= Potential Solutions to Cosmic Problems
<sec:Potential-Solutions-to-Cosmic-Problems>


There are a number of other unresolved problems in cosmology which PBHs might help to solve. We discuss them separately from the problems discussed above, since they are less studied and the arguments are less compelling.


== Fast Radio Bursts and Transmuted Stars and Stellar Remnants
<sec:Fast-Radio-Bursts-and-Transmuted-Stars-and-Stellar-Remnants>


Fast radio bursts (FRBs) are bright radio transient events with millisecond pulse widths and GHz frequencies; their nature is still unknown~@Nicastro:2021cxs. All of them are extragalactic and most are non-repeating. Many explanations have been proposed, including cataclysmic events involving merging neutron stars and stellar black holes, neutron star seismic activity, black hole accretion and active galactic nuclei (see Refs.~@Katz:2018xiu @Petroff:2019tty @Xiao:2021omr for recent reviews). FRBs may also be explained by collisions of neutron stars with planetary-mass PBHs. For example, Abramowicz #emph[et al.]~@Abramowicz:2017zbp argue that this could apply if PBHs of around $10^21 thin$g constitute around $1 "%"$ of the dark matter. This mechanism can also lead to the production of some $r$-process elements, as argued in Ref.~@Fuller:2017uyd. This corresponds to the only known mechanism to explain the surprisingly large amount of gold in the Universe, which neutron star mergers appear to underproduce by a large factor~@Kobayashi:2020jes. Interestingly, this suggestion would be consistent with the 'thermal-history' model~@Carr:2019kxo, which is discussed in @sec:Thermal--History-Scenario.


As pointed out by Kainulainen #emph[et al.]~@Kainulainen:2021rbg, the Bondi formula implies that the characteristic time for accretion of neutron star material onto the PBH is $ t_(upright(B)) approx 2.5 thin "yr" thin ( c_(upright(s)) / 0.6 )^(#h(-1em) 3) ( frac(10^15 thin upright(g) thin upright("cm")^(- 3), rho_(upright(c))) ) ( frac(10^(- 12) thin M_⊙, M) ) thin . $ Using $c_(upright(s)) = 0.6$ as a characteristic sound speed in the core of a neutron star, this is longer than $10 thin$yr for PBHs smaller than $2 times 10^(- 13) thin M_⊙$. Reference~@Kainulainen:2021rbg suggests that one needs accretion on this timescale to explain the irregular bursts of the repeating FRBs, such as FRB 121102 (c.f.~Ref.~@Houben:2019xla), through intermittent reconnection of the magnetic field-line bundles. Hence planetary-mass PBHs could be the source of repeating FRBs. Indeed, a PBH mass function with $f_"PBH" tilde 0.1$ in the range $10^(- 14) thin "–" thin 10^(- 11) thin M_⊙$ ($10^19 thin "–" thin 10^22 thin$g) might explain all the FRBs.


In a related proposal, Takhistov #emph[et al.]~@2021PhRvL.126g1101T have suggested that small (i.e.~subsolar) PBHs can be captured by neutron stars and then consume them, thereby converting them into black holes of $1 thin "–" thin 2 thin M_⊙$ (see Refs.~@2013PhRvD..87l3524C @2017PhRvL.119f1101F @2018PhLB..782...77T for earlier works on PBH-induced implosions of neutron stars). The resulting mass distribution is depicted in @fig:nsmass, broken down into its subcomponents. Its shape is very different from that expected in standard astrophysical scenarios, so they conclude that the observation of a population of $1 thin "–" thin 2 thin M_⊙$ black holes provide support for the original PBHs.


// [figvision-cn] imgs/Figure_31.png
// 这是一张单面板曲线图（概率密度/似然分布图）。横轴名称
// 为“Transmuted black hole mass [M_⊙]”（转化黑洞质量，单
// 位为太阳质量 M_⊙），范围从 0.5 到 2.5，主刻度间隔为
// 0.5（标注 0.5、1.0、1.5、2.0、2.5），次刻度间隔为 0.1。
// 纵轴名称为“Likelihood”（似然），范围从 0 到 5，主刻度
// 间隔为 1（标注 0、1、2、3、4、5），无次刻度标注。图中
// 包含四条曲线： 橙色实线，标注为“Double Neutron Stars”
// （双中子星）。该曲线呈窄高峰分布，峰值位于质量约 1.33
// M_⊙ 处，峰值似然约 4.4，半高宽约 0.1 M_⊙（约在 1.25 至
// 1.42 M_⊙ 之间从半高以上通过），在 1.5 M_⊙ 之后迅速降至
// 接近 0。 蓝色实线，标注为“Slow Pulsars”（慢脉冲星）。
// 该曲线呈较宽的单峰分布，峰值位于质量约 1.45 M_⊙ 处，峰
// 值似然约 2.1，分布范围约从 0.9 M_⊙ 延伸至 2.1 M_⊙，在
// 1.2 至 1.8 M_⊙ 之间保持较高似然（大于 1）。 红色实线，
// 标注为“Millisecond Pulsars”（毫秒脉冲星）。该曲线同样
// 呈较宽的单峰分布，峰值位于质量约 1.55 M_⊙ 处，峰值似然
// 约 1.75，分布范围约从 1.0 M_⊙ 延伸至 2.2 M_⊙，峰值位置
// 比蓝色曲线更靠右，且峰值略低。 黑色虚线，标注为“
// Combined”（组合分布）。该曲线为上述三个子种群的叠加分
// 布，呈偏态单峰，峰值位于质量约 1.35 M_⊙ 处，峰值似然约
// 2.4，在 1.3 至 1.6 M_⊙ 之间形成一个较宽的肩部，随后在
// 2.0 M_⊙ 之后趋近于 0。 图中文字标注均直接置于对应曲线
// 附近：橙色曲线峰顶右侧标注“Double Neutron Stars”，黑色
// 虚线峰顶右侧标注“Combined”，蓝色曲线峰顶右侧标注“Slow
// Pulsars”，红色曲线峰顶右侧标注“Millisecond Pulsars”。
// 图题说明这些分布是假设转化黑洞继承其中子星前身星质量时，
// 由慢脉冲星（蓝色）、再生快速旋转毫秒脉冲星（红色）和双
// 中子星（橙色）三个子种群所预期的质量分布，黑色虚线为组
// 合分布。该图传达的趋势是：双中子星前身星对应最窄且质量
// 最低的转化黑洞质量分布，毫秒脉冲星对应质量最高且较宽的
// 分布，慢脉冲星居中；组合分布因双中子星的窄峰而在低质量
// 端形成显著峰值，并在较高质量端呈现来自脉冲星种群的宽尾。
#figure(placement: top, image("imgs/Figure_31.png", width: 82.0%),
  caption: [
    Expected mass distribution of transmuted solar-mass black holes, assuming they track their neutron star progenitors, for the subpopulations originating from slow pulsars (blue), recycled fast-rotating millisecond pulsars (red) and double neutron stars (orange). Also shown is the combined distribution (black dashed). Input parameters for the Gaussian distributions of these populations have been taken from Ref.~@2013ApJ...778...66K@2016ARAandA..54..401O. Adapted from Ref.~@2021PhRvL.126g1101T.
  ]
)
<fig:nsmass>



The recently discovered #emph[G objects] in the Galactic Centre~@s41586-019-1883-y may be clouds of gas bound by the gravitational field of stellar-mass black holes. As pointed out by Flores #emph[et al.]~@Flores:2023lll, these could have primordial seeds. Specifically, they argue that light PBHs of mass in the range $10^(- 16) thin "–" thin 10^(- 10) thin M_⊙$ could have transmuted neutron stars into a population of $1 thin "–" thin 2 thin M_⊙$ black holes which subsequently develop gaseous atmospheres. This may explain the properties of the #emph[G] objects, such as their avoidance of tidal disruption from the SMBH at the Galactic Centre, while generating the observed emission.


PBHs in the cores of ordinary stars (as well as neutron stars) could have observable consequences, as first suggested by Hawking~@Hawking:1971ei. For a range of stellar masses and metallicities, Bellinger #emph[et al.]~@Bellinger:2023wou have delineated the evolution of stars hosting a PBH in their core. The lightest PBHs leave no evolutionary imprint but the larger ones can partially consume the star, with striking consequences for its spectrum. For example, a solar-type star could develop a convective core, which could not be produced via ordinary stellar evolution and might be asteroseismologically detectable. Also a giant star would exhibit pure-pressure-mode pulsations.


== Missing-Pulsar Problem
<sec:Missing--Pulsar-Problem>


One expects a large population of pulsars in the Galactic centre but none have been detected within the innermost $20 thin$pc and there is a lack of old pulsars even at much larger distances~@Bower:2018mta. This may be accounted for if the Galactic halo comprises PBHs because they would sink into the centres of the pulsars due to dynamical friction and then consume them. Assuming a Maxwellian PBH velocity distribution, the capture rate for a PBH by a neutron star is~@Capela:2013yf $ Gamma_(upright("cap")) = f_(upright("PBH")) thin sqrt(6 pi) #h(0em) rho_(upright("DM")) / M thin frac(2 thin G M_(upright("NS")) thin R_(upright("NS")), sigma_(upright(v)) thin ( 1 - 2 thin G M_(upright("NS")) / R_(upright("NS")) )) #h(-1em) [1 - exp #h(-1em) (- frac(3 thin E_(upright("loss")), M sigma_(upright(v))^2))] . $<eq:Pcapture> Here, $rho_"DM"$ is the local dark matter density, $sigma_(upright(v))$ is the velocity dispersion of the PBHs, $E_"loss"$ is the energy lost in the process, and $R_"NS"$ and $M_"NS"$ are radius and mass of the neutron star, respectively. The upper panel of @fig:NS-Capture-Probability-Spike shows the number of captures over $10^10 thin$yr as a function of Galactocentric distance, assuming a NFW profile~@Navarro:1995iw. For PBHs smaller than about $10^24 thin upright(g)$, no neutron star older than $10^10 thin$yr survives within the innermost $10 thin f_"PBH" thin$pc and this increases to $100 thin f_"PBH" thin$pc for $M tilde 10^20 thin$g.


This effect is significantly enhanced if the dark matter density near the Galactic centre is increased relative to an NFW profile due to adiabatic accretion of dark matter, as expected in the spike models of Gondolo and Silk~@Gondolo:1999ef. Sadeghian #emph[et~al.]~@Sadeghian:2013laa suggest the following analytic approximation for the spike density profile, which we depict in the lower-left panel of @fig:NS-Capture-Probability-Spike (see also Refs.~@1980ApJ...242.1232Y @1986ApJ...301...27B): $ rho_(upright("sp")) ( r ) & prop (R_(upright("sp")) / r_0)^(#h(-1em) - gamma) #h(-1em) (1 - frac(2 thin R_(upright(S)), r))^(#h(-1em) 3) #h(-1em) (R_(upright("sp")) / r)^(#h(-1em) - ( 9 - 2 thin gamma ) / ( 4 - gamma )) quad ( 2 thin R_(upright(S)) < r < R_(upright("sp")) ) thin . $<eq:rho> Here, $R_(upright(S))$ is the Schwarzschild radius of Sgr $upright(A)^(#h(-1em) *)$ and $R_"sp"$ is the spike radius (see Refs.~@Gondolo:1999ef @Nishikawa:2017chy for details). The lower-right panel of @fig:NS-Capture-Probability-Spike shows the capture rate for the profile (#ref(<eq:rho>)) and indicates that a steeper profile (i.e.~larger $gamma$) results in more efficient removal. For $gamma = 2$ and $M_"PBH" = 10^22 thin$g, no neutron stars older than $10^7 f_"PBH" thin$yr survive inside $10 thin$pc. $N$-body simulations using more refined PBH velocity distributions and mass profiles will be needed to better assess this model.


// [figvision-cn] imgs/Figure_32a.png
// 这是一张单面板科学曲线图，图的顶部居中标注标题 NFW。坐
// 标轴均为对数刻度。横轴标注为 r [kpc]，表示银心距，范围
// 从 10^-6 到 10^2 kpc，主刻度依次为 10^-6、10^-4、10^-2、
// 10^0、10^2。纵轴标注为 10^10 years × Γ_capture，表示以
// 10^10 年为单位乘以捕获率，范围从 10^-8 到 10^8，主刻度
// 依次为 10^-8、10^-4、1、10^4、10^8。图中包含一条水平虚
// 线，位于纵轴值 1 处，贯穿整个横轴范围。 图右上角有图例，
// 标明四种线型对应的原初黑洞质量 m_PBH：实线对应 10^22 g，
// 短虚线对应 10^24 g，点线对应 10^26 g，点划线对应 10^28
// g。 图中四条曲线均随银心距 r 增大而单调下降。实线（10^
// 22 g）在 r = 10^-6 kpc 处纵轴值约为 10^5，在 r = 10^2
// kpc 处降至约 10^-3。短虚线（10^24 g）在 r = 10^-6 kpc
// 处约为 10^5，在 r = 10^2 kpc 处降至约 10^-5。点线（10^
// 26 g）在 r = 10^-6 kpc 处约为 10^2，在 r = 10^2 kpc 处
// 降至约 10^-7。点划线（10^28 g）在 r = 10^-6 kpc 处约为
// 1，在 r = 10^2 kpc 处降至 10^-8 以下（约 10^-10）。四
// 条曲线在 r 约为 10^-4 至 10^-2 kpc 之间彼此交叉或接近
// 水平虚线，其中点划线在 r = 10^-6 kpc 处与水平虚线相交。
// 整体趋势表明，对于给定的 m_PBH，捕获率随银心距增大而迅
// 速降低；在相同 r 处，m_PBH 越大，捕获率越低。
// [figvision-cn] imgs/Figure_32b.png
// 这是一幅双对数坐标曲线图。横轴为银心距 r，单位为 kpc，
// 刻度范围从 10^-10 到 10^0，标有 10^-10、10^-8、10^-6、
// 10^-4、10^-2、10^0 刻度。纵轴为暗物质晕密度 ρ(r)，单位
// 为 GeV/cm³，刻度范围从 10^-4 到 10^20，标有 10^-4、10^
// 4、10^12、10^20 刻度。 图中共有四条曲线。实线代表 NFW
// 轮廓，从 r=10^-10 kpc 处约 10^5 GeV/cm³ 开始，随 r 增
// 大单调下降，在 r=10^0 kpc 处降至约 10^-4 GeV/cm³，在双
// 对数坐标下近似为一条直线。三条虚线代表引入尖峰（spike）
// 后的密度轮廓，在 r 约 10^-9 kpc 附近急剧上升至峰值，随
// 后随 r 增大而下降，最终在 r 接近 10^0 kpc 时与 NFW 实
// 线汇合。三条虚线的峰值高度和整体密度水平随参数 γ 增大
// 而升高：γ=0.1（短虚线）峰值约 10^12 GeV/cm³，γ=1（点线）
// 峰值约 10^14 GeV/cm³，γ=2（点划线）峰值约 10^16 GeV/cm
// ³。在 r 大于约 10^-2 kpc 后，三条虚线逐渐靠近并趋近于
// NFW 实线。 图例位于右上角，标明实线为 NFW，短虚线为 γ
// = 0.1，点线为 γ = 1，点划线为 γ = 2。该图传达的趋势是：
// 尖峰模型在极小银心距处显著抬高暗物质密度，且抬升幅度随
// γ 增大而增强；在较大银心距处，所有模型均回归 NFW 轮廓。
// [figvision-cn] imgs/Figure_32b.png
// 这是一幅双对数坐标曲线图。横轴为银心距 r，单位为 kpc，
// 刻度范围从 10^-10 到 10^0，标有 10^-10、10^-8、10^-6、
// 10^-4、10^-2、10^0 刻度。纵轴为暗物质晕密度 ρ(r)，单位
// 为 GeV/cm³，刻度范围从 10^-4 到 10^20，标有 10^-4、10^
// 4、10^12、10^20 刻度。 图中共有四条曲线。实线代表 NFW
// 轮廓，从 r=10^-10 kpc 处约 10^5 GeV/cm³ 开始，随 r 增
// 大单调下降，在 r=10^0 kpc 处降至约 10^-4 GeV/cm³，在双
// 对数坐标下近似为一条直线。三条虚线代表引入尖峰（spike）
// 后的密度轮廓，在 r 约 10^-9 kpc 附近急剧上升至峰值，随
// 后随 r 增大而下降，最终在 r 接近 10^0 kpc 时与 NFW 实
// 线汇合。三条虚线的峰值高度和整体密度水平随参数 γ 增大
// 而升高：γ=0.1（短虚线）峰值约 10^12 GeV/cm³，γ=1（点线）
// 峰值约 10^14 GeV/cm³，γ=2（点划线）峰值约 10^16 GeV/cm
// ³。在 r 大于约 10^-2 kpc 后，三条虚线逐渐靠近并趋近于
// NFW 实线。 图例位于右上角，标明实线为 NFW，短虚线为 γ
// = 0.1，点线为 γ = 1，点划线为 γ = 2。该图传达的趋势是：
// 尖峰模型在极小银心距处显著抬高暗物质密度，且抬升幅度随
// γ 增大而增强；在较大银心距处，所有模型均回归 NFW 轮廓。
#figure(placement: top, [#box(image("imgs/Figure_32a.png", width: 48%)) \
  #box(image("imgs/Figure_32b.png", width: 48%)) #box(image("imgs/Figure_32c.png", width: 48%))

  ],
// [figvision-cn] imgs/Figure_32a.png
// 这是一张单面板科学曲线图，图的顶部居中标注标题 NFW。坐
// 标轴均为对数刻度。横轴标注为 r [kpc]，表示银心距，范围
// 从 10^-6 到 10^2 kpc，主刻度依次为 10^-6、10^-4、10^-2、
// 10^0、10^2。纵轴标注为 10^10 years × Γ_capture，表示以
// 10^10 年为单位乘以捕获率，范围从 10^-8 到 10^8，主刻度
// 依次为 10^-8、10^-4、1、10^4、10^8。图中包含一条水平虚
// 线，位于纵轴值 1 处，贯穿整个横轴范围。 图右上角有图例，
// 标明四种线型对应的原初黑洞质量 m_PBH：实线对应 10^22 g，
// 短虚线对应 10^24 g，点线对应 10^26 g，点划线对应 10^28
// g。 图中四条曲线均随银心距 r 增大而单调下降。实线（10^
// 22 g）在 r = 10^-6 kpc 处纵轴值约为 10^5，在 r = 10^2
// kpc 处降至约 10^-3。短虚线（10^24 g）在 r = 10^-6 kpc
// 处约为 10^5，在 r = 10^2 kpc 处降至约 10^-5。点线（10^
// 26 g）在 r = 10^-6 kpc 处约为 10^2，在 r = 10^2 kpc 处
// 降至约 10^-7。点划线（10^28 g）在 r = 10^-6 kpc 处约为
// 1，在 r = 10^2 kpc 处降至 10^-8 以下（约 10^-10）。四
// 条曲线在 r 约为 10^-4 至 10^-2 kpc 之间彼此交叉或接近
// 水平虚线，其中点划线在 r = 10^-6 kpc 处与水平虚线相交。
// 整体趋势表明，对于给定的 m_PBH，捕获率随银心距增大而迅
// 速降低；在相同 r 处，m_PBH 越大，捕获率越低。
  caption: [
    #emph[U]pper panel$#h(0em)$: Capture rate (#ref(<eq:Pcapture>)) as a function of Galactocentric distance assuming an NFW profile, $f_"PBH" = 1$, $sigma_(upright(v)) = 7 thin$km/s and $M_"PBH" = 10^22 thin$g (solid), $10^24 thin$g (dashed), $10^26 thin$g (dotted), $10^28 thin$g (dot-dashed). #emph[L]ower-left panel$#h(0em)$: Spike halo density profile (#ref(<eq:rho>)) with $gamma = 0.1$ (dashed), $gamma = 1$ (dotted), $gamma = 2$ (dot-dashed) as a function of Galactocentric distance, compared to NFW profile (solid). #emph[L]ower-right panel$#h(0em)$: Capture rate (#ref(<eq:Pcapture>)) for $M_"PBH" = 10^22 thin$g as a function of Galactocentric distance using the halo density profiles of the left panel.
  ]
)
<fig:NS-Capture-Probability-Spike>



== Hubble Tension
<sec:Hubble-Tension>


The value of the Hubble constant reported by the Planck collaboration~@Planck:2018vyg, $H_0 = 67.37 plus.minus 0.54 thin$km/s/Mpc, is less than the value measured by Cepheids and Type Ia supernovæ~@Riess:2018byc, $H_0 = 73.52 plus.minus 1.62 thin$km/s/Mpc. No standard explanation has been found so far. Some ways to weaken or resolve this tension have been discussed, for instance due to systematic uncertainties in the Cepheid colour-luminosity calibration~@Mortsell:2021tcx, or due to the fact that $30 "%"$ of the CMB dipole is not caused by the movement of the Sun, implying an error in Planck's dipole subtraction~@Horstmann:2021jjg. However, the current mainstream view is that this tension is real. Future research is clearly needed to clarify the situation.


If the Hubble tension prevails, PBHs could help to alleviate it. Eroshenko~@Eroshenko:2021oeq studied a scenario in which PBHs have (1) a mass distribution peaking in the range $10^20 thin "–" thin 10^24$ g, and (2) a weakly-relativistic velocity dispersion. He points out that if these PBHs have been in dense clusters with initial masses $18 thin "–" thin 560 thin M_⊙$, their further dynamical evolution might have lead to a vastly increased merger rate, transforming about $10 "%"$ of their initial mass into gravitational waves. In turn, the Hubble constant might have increased by $tilde 5 "%"$ as compared to its value without these merger processes. This would imply a shortening of the first acoustic-peak scale, such that the present Hubble constant $H_0$ would be less than that deduced from local measurements. Papanikolaou~@Papanikolaou:2023oxq has recently argued that the Hubble tension could also be alleviated through the evaporation of PBHs with mass less than $10^9 thin$g via dark radiation degrees of freedom having feeble couplings to the Standard Model. These would have been injected into the primordial plasma, increasing the effective number of neutrino species and in turn the value of the Hubble parameter. Papanaikolaou also argues that such PBHs can generate primordial magnetic fields~@Papanikolaou:2023nkx.


== Falling Rotation Curves at Large Distances
<sec:Falling-Rotation-Curves-at-Large-Distances>


There is increasing evidence for non-flat rotation curves of galaxies at $z tilde cal(O) ( 1 )$~@Genzel:2017jgd, with the curves falling beyond twice the half-light radius (c.f.~@fig:fig1 in @sec:Lensing-Evidence). This could be accounted for if the dark matter were subdominant in the outer regions of galactic disks at those redshifts. This is expected if the dark matter comprises PBHs in dense clusters since --- as they merge with larger halos --- they would tend to fall to the centre. Moreover, in the standard $Lambda$CDM scenario, galaxy halos are formed by successive mergers of smaller halos and galaxies move along cosmic web filaments, where most of the baryonic gas is located. For PBH dark matter, the galaxy halos have edges, so the rotation curves of galaxies should fall off at sufficiently large distances. This works for PBHs but not particle dark matter since only the former are affected by dynamical friction. The galactocentric distance at which this fall-off occurs depends on the type of galaxy and its merger history. In the case of the Milky Way, this happens at around $30 thin$kpc, which is closer than the Large and Small Magellanic Clouds~@Calcino:2018mwh. This significantly weakens the microlensing constraints from the Large Magellanic Cloud, as discussed in @sec:Lensing-Evidence. The estimate in Ref.~@Calcino:2018mwh suggests $f_"PBH" tilde.eq 0.4$ at $M tilde.eq 1 thin M_⊙$, which agrees with the MACHO microlensing result and the thermal-history scenario.


== Hyper-Velocity Stars
<sec:Hyper--Velocity-Stars>


High-velocity stars have been recently detected in the Milky Way halo and observations suggest a Galactic bulge and LMC origin~@2017MNRAS.469.2151B. They could have resulted from slingshot interactions with massive PBHs~@Garcia-Bellido:2017fdg or massive black hole binaries~@Yu:2003hj. The existence of the former in the Galactic centre is supported by a recent observation~@2017NatAs...1..709O. High-velocity stars are also detected in the core of globular clusters~@Lutzgendorf:2012tn, which might also indicate a population of massive PBHs. A recent analysis~@Montanari:2019rvu has found a few candidates for high-velocity stars in the second data-release catalog of the #emph[Gaia] mission, which seem to come from the centre of the Sagittarius dwarf galaxy, a highly compact tidal stream with a high concentration of black holes at the centre. These are probably primordial, given the stellar evolution in the tidally stripped dwarf galaxy. The core of the Sagittarius dwarf galaxy could be a cluster of a thousand PBHs with mass peaked around a solar mass~@Montanari:2019rvu @Montanari:2020gcr.


== Properties of Low-Mass X-Ray Binaries
<sec:Properties-of-Low--Mass-X--Ray-Binaries>


The majority of so-called low-mass X-ray binaries have been detected in globular clusters or towards the Galactic centre, but not in the Galactic disk~@Bahramian:2022msw. This favours formation through a process of tidal capture. If stellar-mass PBHs provide a significant fraction of the dark matter, they should reside in both globular clusters and the Galactic bulge and their contribution may dominate that from black holes of stellar origin and neutron stars. This suggests that the compact objects in low-mass X-ray binaries could have a mass below the Chandrasekhar mass and are PBHs rather than neutron stars~@2018PDU....22..137C. Because the GW amplitude depends on the black hole mass, while the X-ray luminosity from a low-mass X-ray binaries is detectable whatever the PBH mass, a broad PBH mass distribution centred on a few solar masses would also explain why most low-mass X-ray binaries have a mass in that range, whereas GW events involve heavier black holes due to the detector optimal sensitivity at higher masses.


== Evaporating Black Holes
<sec:Evaporating-Black-Holes>


There are numerous constraints on evaporating PBHs~@2010PhRvD..81j4019C. For example, the strongest limit on the collapse fraction $beta ( M )$ is associated with the ones with mass $M_(*) approx 5 times 10^14 thin$g which are completing their evaporation at the present epoch. This comes from the extragalactic $100 thin$MeV background~@MacGibbon:1991vc, and the general conclusion is that this could not have been generated by PBHs~@2021RPPh...84k6902C. Nevertheless, evaporating PBHs have been invoked to explain various other cosmological features. While none of the arguments may be compelling, they should certainly be regarded as potential signatures and will therefore be summarised here.


Several authors have suggested that the $511 thin$keV annihilation-line radiation from the Galactic centre could result from the positrons emitted by the PBHs there~@Bugaev:2008gw @Bambi:2008kx, as first suggested by Okele and Rees@1980AandA....81..263O. It has also been suggested that the pregalactic medium could have been reionised by PBH evaporations~@Belotsky:2014twa. Overproduction of $zws^7 "Li"$ by a factor $tilde 3$ is the most serious issue with the standard cosmological nucleosynthesis model~@Coc:2017rpv and astrophysical solutions (such as invoking particle decays to reduce the lithium abundance via neutron injection) have failed so far. However, PBHs evaporating at $10^2 thin "–" thin 10^4 thin$s might provide a plausible alternative. For example, PBHs with an extended mass function around $10^12 thin$g could provide an early injection of neutrons and then soft $gamma$-rays. This combination could destroy some $zws^7 "Be"$ at $tilde 10^2 thin upright(s)$, avoiding overproduction of $zws^7 "Li"$, and subsequently destroy excess Deuterium at $tilde 10^3 thin "–" thin 10^4 thin upright(s)$.


Historically, there has been much interest in whether the explosions of PBHs of mass $M_(*)$ could be detected as $gamma$-ray bursts. The extragalactic $gamma$-ray background limit implies that the PBH explosion rate $cal(R)$ could be at most $10^(- 6) thin "pc"^(- 3) thin "yr"^(- 1)$ if the PBHs are uniformly distributed or $10 thin "pc"^(- 3) thin "yr"^(- 1)$ if they are clustered inside galactic halos~@Page:1976wx. The direct observational constraints on the explosion rate come both from $gamma$-ray bursts and high-energy cosmic-ray showers. In the Standard Model, where the number of elementary particle species never exceeds around $100$, the likelihood of detecting such explosions is very low. However, the physics of the QCD phase transition is still uncertain and the prospects of detecting PBH explosions would be improved in less conventional models. In particular, Cline and colleagues have argued that the formation of a fireball at the QCD temperature could explain some of the short-period $gamma$-ray bursts (i.e.~those with duration less than $100 thin$ms~@Cline:1992ps). In Ref.~@Cline:2001tq they claim to find $42$ BATSE (#emph[Burst And Transient Source Experiment]) candidates of this kind and the fact that their distribution matches the spiral arms suggests that they are Galactic. In Ref.~@Cline:2005xb they report a class of short-period #emph[Konus] bursts which have a harder spectrum than usual and identify these with exploding PBHs. In Ref.~@Cline:2006nv they find a further $8$ candidates in the #emph[Swift] data. Overall they claim that the BATSE, #emph[Konus] and #emph[Swift] data correspond to a $4.5 sigma$ effect and that several events exhibit the time structure expected of PBH evaporations~@Cline:2009ni.


If PBHs of mass $M_(*)$ are clustered inside our own Milky Way halo, as expected, then there should also be a Galactic $gamma$-ray background and, since this would be anisotropic, it should be separable from the extragalactic background. The ratio of the anisotropic to isotropic intensity depends on the Galactic longitude and latitude, the Galactic core radius and the halo flattening. Some time ago Wright~@1996ApJ...459..487W claimed that such a halo background had been detected in EGRET (#emph[Energetic Gamma Ray Experiment Telescope]) observations between $30 thin$MeV and $120 thin$MeV and attributed this to PBHs. His detailed fit to the data, subtracting various other known components, required the PBH clustering factor to be comparable to that expected and the local explosion rate to be $cal(R) = 0.07 thin "–" thin 0.42 thin "pc"^(- 3) thin "yr"^(- 1)$. A later analysis of EGRET data between $70 thin$MeV and $150 thin$MeV, assuming a variety of distributions for the PBHs, was given by Lehoucq #emph[et al.]~@Lehoucq:2009ge. Subsequently, Ref.~@Carr:2016hva took into account several other physical factors, but this work only claimed to provide a constraint rather than positive evidence. Note that these analyses do not constrain PBHs of #emph[initial] mass $M_(*)$ because these no longer exist. Rather, they constrain PBHs of #emph[current] mass $M_(*)$, and this corresponds to an initial mass of $1.26 thin M_(*)$ . This contrasts to the situation with the extragalactic background, where the strongest constraint on $beta ( M )$ comes from the time-integrated contribution of the $M_(*)$ black holes.


It has sometimes been suggested that the tiny amount of antimatter in cosmic rays could be generated by PBH evaporations since these should emit particles and antiparticles in equal numbers~@Barrau:1999sk. Galactic antiprotons can constrain PBHs only in a very narrow range around $M approx M_(*)$ since they diffusively propagate to the Earth on a timescale much shorter than the cosmic age. However, the evaporation of PBHs with $M > 10^17 thin$g is expected to inject sub-GeV electrons and positrons into the Milky Way. These particles are shielded by the solar magnetic field for Earth-bound detectors, but not for #emph[Voyager] 1, which is now beyond the heliopause. Boudaud & Cirelli~@Boudaud:2018hqb use its data to constrain the number of PBHs in the Milky Way. However, these are only claimed as constraints.


If PBH evaporations leave stable Planck-mass relics, these might also contribute to the dark matter. This was first pointed out by MacGibbon~@MacGibbon:1987my, and has subsequently been explored in the context of inflationary scenarios by numerous authors~@Barrow:1992hq @Carr:1994ar @Green:1997sz @Alexeyev:2002tg @Chen:2002tu @Barrau:2003xp @Chen:2004ft @Nozari:2005ah. The problem is that such remnants would be challenging to detect. However, Lehmann #emph[et al.]~@Lehmann:2019zgt point out that they may carry electric charge, making them visible to terrestrial detectors. They evaluate constraints and detection prospects in detail and show that this scenario can be explored within the next decade using planned experiments.


= Evidence from Dark Matter and Unified Model
<sec:Evidence-from-Dark-Matter-and-Unified-Model>


Of all the observational evidence discussed in this review, that pertaining to dark matter is most firmly established and this surely points towards new physics. The dark matter has about $26 "%"$ of the critical density and evidence for it has been found on many different scales--galactic halos, clusters of galaxies and intergalactic space. The usual assumption is that it comprises some form of cold dark matter (CDM) since, in this case, as progressively larger scales of structure bind from the initial fluctuations, the dark matter will inevitably be found on all these scales. It must be: (1) dark enough to explain the lack of observations across the whole electromagnetic spectrum; (2) "cold" in order to agree with the observed large-scale structure and CMB anisotropies; (3) non-interacting or weakly interacting to be consistent with the dark matter distribution in dwarf galaxies; (4) of non-astrophysical origin since CMB observations show that it was present in the early Universe. Only some new type of particle or a PBH can satisfy all these criteria.


== PBHs versus Particle Dark Matter
<sec:PBHs-versus-Particle-Dark-Matter>


Until recently, the most popular CDM candidates were WIMPs (weakly interacting massive particles) since they arise naturally in supersymmetric extensions of the standard model. However, neither direct searches (using accelerators and underground detectors) nor indirect searches (using astronomical observations) have provided any evidence for such particles and this has ruled out most versions of the scenario. This has led to the search for other particle candidates (sterile neutrinos~@2005PhLB..620...17A @2013PhRvD..87i3006C, axions and axion-like particles~@1978PhRvL..40..223W @1978PhRvL..40..279W @1977PhRvL..38.1440P, ultralight bosons~@2000PhRvL..85.1158H) or even proposed modifications to the law of gravity (such as MOND~@Milgrom:1983ca or TeVeS~@Bekenstein:2004ne).


Black holes might also be regarded as a form of CDM. However, while black holes are certainly dark, it should be stressed that those which form at late times (e.g.~as stellar remnants or in galactic nuclei) could not provide #emph[all] the dark matter because they derive from baryons and are therefore subject to the well-known big bang nucleosynthesis constraint that baryons can have at most $5 "%"$ of the critical density~@Cyburt:2003fe. By contrast, PBHs formed in the radiation-dominated era before big bang nucleosynthesis and avoid this constraint. They should therefore be classified as non-baryonic and behave like any other form of CDM. There are certainly some dark baryons, including those in stellar remnants, but most of them are probably in the form of intergalactic gas. For recent reviews of PBHs as dark matter, see Refs.~@Carr:2020xqk @2021JPhG...48d3001G.


It is sometimes argued that PBHs are more natural dark matter candidates than WIMPs or other particles since black holes holes definitely exist, so that one does not need to invoke new physics. It might be counter-argued that most models of PBH formation depend on processes in the early Universe which involve new physics. However, there exists at least one scenario, Critical Higgs Inflation, which only needs to include a non-minimal coupling of the Higgs field to gravity in the Lagrangian of the Standard Model~@Garcia-Bellido:2017mdw. This is very different from the particle dark matter scenario, which requires the addition of at least a new field beyond the Standard Model since the known particles cannot account for CDM. Such theoretical arguments cannot be decisive but we believe the observational evidence discussed in this review boosts the odds in favour of PBHs. Finally, we stress that PBHs could still play an important cosmological rôle even if they only contribute a small part of the dark matter. This resembles the situation with neutrinos: these definitely exist and are enormously important even though their cosmological density is low. However, as discussed below, PBHs and particles cannot both make significant contributions to the dark matter.


The PBH parameter space --- just like the parameter space for the particle model --- has been progressively constrained by various observations. In particular, many papers have constrained the function $f_"PBH" ( M )$, usually for a monochromatic mass distribution. However, the comparison is not entirely valid since: (1) $f_"WIMP"$ is not considered as a free parameter in the WIMP case; (2) no theoretical model leads to monochromatic PBH mass function; (3) most limits on particle dark matter are rather precise, whereas the PBH limits depend on many astrophysical and theoretical uncertainties.


It is worth elaborating on the last point. All the limits below $10^17 thin$g rely on the theory of black hole evaporation but this has never been proved experimentally and evaporation might be suppressed below some mass-scale in alternative models. Between $10^(- 10) thin M_⊙$ and $1 thin M_⊙$ (i.e.~ten decades of mass) the limits come from microlensing surveys but these depend on assumptions about the dark halo (its density profile), the PBHs (their velocity and mass distributions and clustering) and the efficiency of ML detections. The claimed limits on $f_"PBH"$ are not very strong anyway, ranging from $10^(- 2)$ to $1$. Most of the limits above $10 thin M_⊙$ rely on black hole accretion. However, this is not well understood either observationally or theoretically and could be more complex than usually assumed. In particular, accretion depends on the black hole velocity relative to gas and this depends on the exact model. A modest change in the PBH velocity distribution could change the abundance limits by several orders of magnitude. The limits above $10^4 thin M_⊙$ depend on the primordial power spectrum and could be evaded if PBHs formed from highly non-Gaussian fluctuations, as applies in a variety of theoretical models.


Given these uncertainties, PBHs or the relics of their evaporation could provide a significant fraction of the dark matter for the hundred decades of mass between $tilde 1 thin$g (for PBHs formed around the grand unified theory scale) and $10^6 thin M_⊙$. They may therefore provide all the dark matter even if $f_"PBH" ( M ) tilde 10^(- 2)$ for any particular mass, thereby obviating many of the constraints. See Refs.~@Carr:2016drx @Green:2016xgy @Kuhnel:2017pwq @Carr:2017jsz for detailed analyses of extended PBH mass functions. In Section C below, we will place emphasis on a particular scenario in which most of the dark matter is in PBHs of around $1 thin M_⊙$ formed at the QCD epoch. While this is our preferred scenario, it should be stressed that other PBH advocates favour a scenario in which most of the dark matter comprises PBHs in the planetary mass range and there are certainly formation mechanisms which would allow this. Indeed, it has been argued that the PBH mass function could have its main peak in the planetary mass range and a second peak in the LIGO mass range (e.g.~Ref.~@2022arXiv220905959F). This requires even more fine-tuning than usual (since there are two peaks) but is not excluded. Other alternatives have been proposed by Boehm #emph[et al.]~@Boehm:2020jwd, who advocate dark matter in $30 thin "–" thin 100 thin M_⊙$ PBHs since they might escape microlensing and CMB constraints, and Coriano & Frampton~@Coriano:2020uny, who advocate $10^2 thin "–" thin 10^5 thin M_⊙$ PBHs. Our reason for underemphasising these alternative scenarios in this review is that there is currently no positive evidence for them.


== Mixed Dark Matter
<sec:Mixed-Dark-Matter>


If most of the dark matter is in the form of elementary particles, these will be accreted around any small admixture of PBHs. In the case of WIMPs, this can even happen during the radiation-dominated era, since Eroshenko~@Eroshenko:2016yve has shown that a low-velocity subset will accumulate around PBHs as density spikes shortly after the WIMPs kinetically decouple from the background plasma. Their annihilation will give rise to bright $gamma$-ray sources and comparison of the expected signal with Fermi-LAT data then severely constrains $Omega_"PBH"$ for $M > 10^(- 8) thin M_⊙$. These constraints are several orders of magnitude more stringent than other ones if one assumes a WIMP mass of $m_chi tilde cal(O) ( 100 ) thin "GeV"$ and the standard value of $chevron.l sigma v chevron.r^() = 3 times 10^(- 26) thin "cm" thin upright(s)^(- 1)$ for the velocity-averaged annihilation cross-section. Boucenna #emph[et al.]~@Boucenna:2017ghj have investigated this scenario for a larger range of values for $chevron.l sigma v chevron.r$ and $m_chi$ and reach similar conclusions. Although this might be regarded as a PBH constraint, it also represents potential signature of even a small density of PBHs.


Besides the early formation of spikes around light PBHs, WIMP accretion can also occur by secondary infall around heavier PBHs~@Bertschinger:1985pd. This leads to a different halo profile and WIMP annihilations then yield a constraint $f_"PBH" lt.tilde cal(O) ( 10^(- 9) )$ for the same values of $chevron.l sigma v chevron.r$ and $m_chi$. This result was obtained by Adamek #emph[et al.]~@Adamek:2019gns for solar-mass PBHs and the argument was extended by Carr #emph[et al.]~@Carr:2020mqm to the mass range from $10^(- 18) thin M_⊙$ to $10^15 thin M_⊙$\; this even includes stupendously large black holes (SLABs) larger than $10^12 thin M_⊙$~@Carr:2020erq. Recently, Ginés #emph[et al.]~@Gines:2022qzy used the same dark matter halo profile as Ref.~@Carr:2020mqm and their extended analysis of annihilation signals found similar results.


The basis for all those constraints is the derivation of the density profile of the WIMP halos around the PBHs, which was given in Ref.~@Carr:2020mqm. Their result is depicted in @fig:rhochi, which exhibits three initial scaling regimes, $ rho_("chi", "thinspike") ( r ) prop cases(
    f_chi thin rho_"KD" thin r^(- 3 / 4) & ( r < r_"C" ),
    f_chi thin rho_"eq" thin M^(3 / 2) thin r^(- 3 / 2) & ( r_"C" < r < r_"K" ),
    f_chi thin rho_"eq" thin M^(3 / 4) thin r^(- 9 / 4) & ( r > r_"K" ) thin . o n t h e r e l e v a n t m a s s s c a l e
  ) $<eq:densityprofile2> Here, $f_chi$ is the dark matter fraction in the WIMPs, $rho_"KD"$ is the cosmological density when they kinetically decouple, $rho_"eq"$ is the density at matter-radiation equality, and $r_(upright(C))$ and $r_(upright(K))$ depend on $M$ and $m_chi$. However, the dynamical evolution of the halo needs to be taken into account, since WIMP annihilations significantly change the profile from its initial form and produce a flat core. The derivation of these results and further details can be found in Ref.~@Carr:2020mqm. Using $N$-body simulations, Boudaud #emph[et al.]~@Boudaud:2021irr obtained exactly the same density profile, confirming the three-fold behaviour of Eq.~(#ref(<eq:densityprofile2>)).


// [figvision-cn] imgs/Figure_33a.png
// 这是一张单面板科学曲线图，展示弱相互作用大质量粒子（
// WIMP）在原始黑洞（PBH）周围因束缚态湮灭前后的密度径向
// 分布。纵轴为密度 ρ_χ，单位 g cm⁻³，采用对数刻度，范围
// 10⁻²⁴ 至 10⁸，每两个数量级一个主刻度。横轴为径向距离 r，
// 单位 cm，采用对数刻度，范围 10⁰ 至 10¹⁸。图中包含六条
// 粗实线和六条粗虚线。实线代表初始密度分布 ρ_i(r)（即湮
// 灭前），虚线代表当前（湮灭后）密度分布 ρ_χ(r)。颜色编
// 码表示粒子质量 m_χ：洋红色为 10 GeV，橙色为 100 GeV，
// 绿色为 1 TeV。每种颜色包含两条剖面，分别对应两个不同的
// PBH 质量：外侧、较高密度的实线对应 M = 10⁻⁶ M_⊙，内侧、
// 较低密度的实线对应 M = 10⁻¹² M_⊙，由两个带双箭头的斜向
// 标注指示。所有实线呈平行直线下降趋势，在双对数坐标中斜
// 率约为 -3；洋红色和橙色实线在 r 接近 10¹⁷ cm 处出现陡
// 峭截断，绿色实线在 r 接近 10¹¹ cm 处截断。六条虚线为由
// 左向右延伸的水平线，密度值恒定在 10⁻¹² 至 10⁻¹⁶ g cm⁻³
// 之间，这些虚线从各自的实线开始，一直延伸至图的右边缘，
// 表示已进入平缓的饱和状态。图中左侧靠近 r = 10⁰ 处有一
// 条黑色虚线水平标注 "Today"，指示当前宇宙的临界密度水平，
// 其量级约为 10⁻¹⁴ g cm⁻³。图中的主要趋势为：对于每个粒
// 子质量，质量更大的 PBH（10⁻⁶ M_⊙）对应的初始密度峰值更
// 高（约 10⁶–10⁸ g cm⁻³），而质量更小的 PBH（10⁻¹² M_⊙）
// 对应的峰值较低（约 10⁰–10² g cm⁻³）；粒子质量越大（从
// 10 GeV 到 1 TeV），初始密度峰值越低；湮灭后，所有密度
// 剖面均显著下降并大幅平坦化，形成由粒子质量决定的特征性
// 饱和密度。
// [figvision-cn] imgs/Figure_33a.png
// 这是一张单面板科学曲线图，展示弱相互作用大质量粒子（
// WIMP）在原始黑洞（PBH）周围因束缚态湮灭前后的密度径向
// 分布。纵轴为密度 ρ_χ，单位 g cm⁻³，采用对数刻度，范围
// 10⁻²⁴ 至 10⁸，每两个数量级一个主刻度。横轴为径向距离 r，
// 单位 cm，采用对数刻度，范围 10⁰ 至 10¹⁸。图中包含六条
// 粗实线和六条粗虚线。实线代表初始密度分布 ρ_i(r)（即湮
// 灭前），虚线代表当前（湮灭后）密度分布 ρ_χ(r)。颜色编
// 码表示粒子质量 m_χ：洋红色为 10 GeV，橙色为 100 GeV，
// 绿色为 1 TeV。每种颜色包含两条剖面，分别对应两个不同的
// PBH 质量：外侧、较高密度的实线对应 M = 10⁻⁶ M_⊙，内侧、
// 较低密度的实线对应 M = 10⁻¹² M_⊙，由两个带双箭头的斜向
// 标注指示。所有实线呈平行直线下降趋势，在双对数坐标中斜
// 率约为 -3；洋红色和橙色实线在 r 接近 10¹⁷ cm 处出现陡
// 峭截断，绿色实线在 r 接近 10¹¹ cm 处截断。六条虚线为由
// 左向右延伸的水平线，密度值恒定在 10⁻¹² 至 10⁻¹⁶ g cm⁻³
// 之间，这些虚线从各自的实线开始，一直延伸至图的右边缘，
// 表示已进入平缓的饱和状态。图中左侧靠近 r = 10⁰ 处有一
// 条黑色虚线水平标注 "Today"，指示当前宇宙的临界密度水平，
// 其量级约为 10⁻¹⁴ g cm⁻³。图中的主要趋势为：对于每个粒
// 子质量，质量更大的 PBH（10⁻⁶ M_⊙）对应的初始密度峰值更
// 高（约 10⁶–10⁸ g cm⁻³），而质量更小的 PBH（10⁻¹² M_⊙）
// 对应的峰值较低（约 10⁰–10² g cm⁻³）；粒子质量越大（从
// 10 GeV 到 1 TeV），初始密度峰值越低；湮灭后，所有密度
// 剖面均显著下降并大幅平坦化，形成由粒子质量决定的特征性
// 饱和密度。
#figure(placement: top, [#box(image("imgs/Figure_33a.png", width: 48.0%)) #box(image("imgs/Figure_33b.png", width: 48.0%))

  ],
  caption: [
    Density profile before ($rho_i$) and after ($rho_chi$) annihilations of WIMPs bound to a PBH of mass $10^(- 12) thin M_⊙$ or $10^(- 6) thin M_⊙$ (left panel) and $1 thin M_⊙$ or $10^6 thin M_⊙$ (right panel) for $f_chi tilde.eq 1$. We set $m_chi$ to be $10 thin$GeV (magenta), $100 thin$GeV (orange) and $1 thin$TeV (green). From Ref.~@Carr:2020mqm.
  ]
)
<fig:rhochi>



The most stringent constraints come from extragalactic $gamma$-ray background observations. The differential flux of $gamma$-rays is produced by the #emph[collective] annihilations of WIMPs around PBHs at all redshifts~@Ullio:2002pj, $ frac(upright(d) Phi_gamma, upright(d) E thin upright(d) Omega) \|_(upright("eg")) = integral_0^(thin oo) upright(d) z #h(0em) frac(e^(- tau_(upright(E))^() ( z , thin E )), 8 pi H ( z )) frac(upright(d) N_gamma, upright(d) E) integral #h(-1em) upright(d) M #h(0em) Gamma ( z ) thin frac(upright(d) n_(upright("PBH")) ( M ), upright(d) M) thin , $<eq:flux> where $H ( z )$ is the Hubble rate at redshift $z$, "eg" indicates extragalactic and $n_"PBH"$ is the PBH number density. Also $Gamma ( z ) equiv Gamma_0 thin h ( z )^(2 / 3)$, where $Gamma_0 = Upsilon thin f_chi^1.7 thin M / thin M_⊙$ is the WIMP annihilation rate around each PBH, with $Upsilon equiv 1.2 times 10^34 thin upright(s)^(- 1) thin ( "TeV" / m_chi )^(4 / 3)$, $h ( z ) = H ( z ) / 100$ and $tau_(upright(E))^()$ is the optical depth at redshift $z$ resulting from (1) photon-matter pair production, (2) photon-photon scattering, and (3) photon-photon pair production~@Cirelli:2009dv @Slatyer:2009yq. The numerical expressions for both the energy spectrum $upright(d) N_gamma / "dE"$ and the optical depth are taken from Ref.~@Cirelli:2010xx. Integrating over the energy and solid angle leads to a flux $ Phi_(gamma , thin upright("eg")) = frac(f_(upright("PBH")) thin rho_(upright("DM")), 2 H_0 thin M_⊙) thin Upsilon thin f_chi^1.7 tilde(N)_gamma ( m_chi ) thin , $<eq:flux-normalised> where $rho_"DM"$ is the present dark matter density and $tilde(N)_gamma$ is the number of photons produced: $ tilde(N)_gamma ( m_chi ) equiv integral_(z_star.op)^oo #h(-1em) upright(d) z #h(0em) integral_(E_(upright("th")))^(m_chi) #h(-1em) upright(d) E #h(0em) frac(upright(d) N_gamma, upright(d) E) frac(e^(- tau_(upright(E))^() ( z , thin E )), h ( z )^(1 / 3)) thin . $<eq:tildeNgamma> Here, the lower limit in the redshift integral corresponds to the epoch of galaxy formation, assumed to be $z_star.op tilde 10$. The analysis becomes more complicated after $z_star.op$. The lower limit in the energy integral is the threshold for detection.


Comparing the integrated flux with the Fermi sensitivity $Phi_"res"$ yields $
  f_"PBH" & lt.tilde (2 M H_0 Phi_"res")/(rho_"DM" Gamma_0 tilde(N)_gamma (m_chi)) \
  & approx cases(
    2 times 10^(-9) (m_chi / "TeV")^(1.1) quad (M gt.tilde M_*),
    1.1 times 10^(-12) (m_chi / "TeV")^(-5.0) (M / 10^(-10) thin M_⊙)^(-2) quad (M lt.tilde M_*),
  ),
$ <eq:egbound> where $M_(*)$ is given by $ M_(*) approx 2 times 10^(- 12) thin ( m_chi / upright("TeV") )^(- 3.0) thin M_⊙ thin . $<eq:masschange> The full constraint is shown by the blue curves in the left panel of @fig:fPBHWIMP for a WIMP mass of $10 thin$GeV (dashed line), $100 thin$GeV (dot-dashed line) and $1 thin$TeV (dotted line). We note that the extragalactic bound intersects the cosmological incredulity limit (corresponding to one PBH within the particle horizon) at a mass $ M_(upright("eg")) = frac(2 thin H_0 thin M_⊙ thin Phi_(upright("res")) thin M_(upright(E)), alpha_(upright(E)) thin rho_(upright("DM")) thin Upsilon thin tilde(N)_gamma ( m_chi )) approx 5 times 10^12 thin M_⊙ thin ( m_chi / upright("TeV") )^1.1 thin , $<eq:MiL> where we have used our fit for $tilde(N)_gamma ( m_chi )$.


// [figvision-cn] imgs/Figure_34a.png
// 这是一张包含两个并置面板的半对数坐标曲线图，用于展示原
// 初黑洞（PBH）质量和暗物质质量对相关物理参数的限制。左
// 面板为曲线图，右面板为相图（填色图）。 左面板图： 横轴
// 标记为 \(M [M_\odot]\)，表示原初黑洞质量，单位为太阳质
// 量。横轴采用对数坐标，范围从 \(10^{-18}\) 到 \(10^{15}
// \)，主刻度为 \(10^{-18}, 10^{-15}, 10^{-12}, 10^{-9},
// 10^{-6}, 10^{-3}, 10^{0}, 10^{3}, 10^{6}, 10^{9}, 10^{
// 12}, 10^{15}\)。纵轴标记为 \(f_{\rm PBH}\)，表示原初黑
// 洞在暗物质中所占的比例，采用对数坐标，范围从 \(10^{-13
// }\) 到 \(10^{0}\)，主刻度为 \(10^{-13}, 10^{-12}, 10^{
// -11}, 10^{-10}, 10^{-9}, 10^{-8}, 10^{-7}, 10^{-6}, 10
// ^{-5}, 10^{-4}, 10^{-3}, 10^{-2}, 10^{-1}, 10^{0}\)。
// 图中包含一条粗绿色实线和三条蓝色线条。绿色实线标记为“
// GRB”，位于图的左边缘，从横轴 \(M \approx 10^{-18}\) 处
// 纵坐标约 \(10^{-7}\) 开始，向右上方陡峭上升，横轴约 \(
// 10^{-15}\) 时纵坐标达到 \(10^0\)。三条蓝色线条从左上方
// 向右下方延伸并趋于水平。最左侧的蓝色线为点线，其曲线在
// 横轴 \(M \approx 10^{-10}\) 时到达纵坐标 \(10^{-10}\)
// 并保持水平向右延伸直到右边缘。中间的蓝色线为点划线，在
// 横轴 \(M \approx 10^{-6}\) 时降至纵坐标 \(10^{-11}\)
// 后保持水平。最右侧的蓝色线为虚线，在横轴 \(M \approx
// 10^{-4}\) 时降至纵坐标 \(10^{-12}\) 附近并保持水平。图
// 的右侧有一条蓝色细实线向右上方延伸，标记为“Incredulity
// Limit”。该线从横轴 \(M \approx 10^{9}\) 处纵坐标 \(10^
// {-13}\) 开始，向右上方直线延伸至右边缘纵坐标约 \(10^{
// -5}\) 处。图中包含灰色阴影区域：一个在左侧“GRB”线以左，
// 另一个在右侧“Incredulity Limit”线以右。图的右上角有一
// 个图例，包含四项：蓝色实线旁边标注“extragalactic”；黑
// 色短虚线旁边标注“\(m_\chi = 1\, {\rm TeV}\)”；黑色点划
// 线旁边标注“\(m_\chi = 100\, {\rm GeV}\)”；黑色虚线旁边
// 标注“\(m_\chi = 10\, {\rm GeV}\)”。该子图展示了从河外
// 伽马射线背景得出的对原初黑洞丰度的限制。 右面板图： 该
// 面板为相图，图中彩色区域展示了WIMP（弱相互作用大质量粒
// 子）所占比例作为原初黑洞质量和WIMP质量的函数。由于图片
// 右侧被截断，坐标轴的具体数值标签和色标细节不可见。图中
// 左侧显示为一个倾斜的带状颜色渐变区域，颜色从蓝色过渡到
// 绿色再到灰白色，右侧为大面积的纯灰色区域。
// [figvision-cn] imgs/Figure_34a.png
// 这是一张包含两个并置面板的半对数坐标曲线图，用于展示原
// 初黑洞（PBH）质量和暗物质质量对相关物理参数的限制。左
// 面板为曲线图，右面板为相图（填色图）。 左面板图： 横轴
// 标记为 \(M [M_\odot]\)，表示原初黑洞质量，单位为太阳质
// 量。横轴采用对数坐标，范围从 \(10^{-18}\) 到 \(10^{15}
// \)，主刻度为 \(10^{-18}, 10^{-15}, 10^{-12}, 10^{-9},
// 10^{-6}, 10^{-3}, 10^{0}, 10^{3}, 10^{6}, 10^{9}, 10^{
// 12}, 10^{15}\)。纵轴标记为 \(f_{\rm PBH}\)，表示原初黑
// 洞在暗物质中所占的比例，采用对数坐标，范围从 \(10^{-13
// }\) 到 \(10^{0}\)，主刻度为 \(10^{-13}, 10^{-12}, 10^{
// -11}, 10^{-10}, 10^{-9}, 10^{-8}, 10^{-7}, 10^{-6}, 10
// ^{-5}, 10^{-4}, 10^{-3}, 10^{-2}, 10^{-1}, 10^{0}\)。
// 图中包含一条粗绿色实线和三条蓝色线条。绿色实线标记为“
// GRB”，位于图的左边缘，从横轴 \(M \approx 10^{-18}\) 处
// 纵坐标约 \(10^{-7}\) 开始，向右上方陡峭上升，横轴约 \(
// 10^{-15}\) 时纵坐标达到 \(10^0\)。三条蓝色线条从左上方
// 向右下方延伸并趋于水平。最左侧的蓝色线为点线，其曲线在
// 横轴 \(M \approx 10^{-10}\) 时到达纵坐标 \(10^{-10}\)
// 并保持水平向右延伸直到右边缘。中间的蓝色线为点划线，在
// 横轴 \(M \approx 10^{-6}\) 时降至纵坐标 \(10^{-11}\)
// 后保持水平。最右侧的蓝色线为虚线，在横轴 \(M \approx
// 10^{-4}\) 时降至纵坐标 \(10^{-12}\) 附近并保持水平。图
// 的右侧有一条蓝色细实线向右上方延伸，标记为“Incredulity
// Limit”。该线从横轴 \(M \approx 10^{9}\) 处纵坐标 \(10^
// {-13}\) 开始，向右上方直线延伸至右边缘纵坐标约 \(10^{
// -5}\) 处。图中包含灰色阴影区域：一个在左侧“GRB”线以左，
// 另一个在右侧“Incredulity Limit”线以右。图的右上角有一
// 个图例，包含四项：蓝色实线旁边标注“extragalactic”；黑
// 色短虚线旁边标注“\(m_\chi = 1\, {\rm TeV}\)”；黑色点划
// 线旁边标注“\(m_\chi = 100\, {\rm GeV}\)”；黑色虚线旁边
// 标注“\(m_\chi = 10\, {\rm GeV}\)”。该子图展示了从河外
// 伽马射线背景得出的对原初黑洞丰度的限制。 右面板图： 该
// 面板为相图，图中彩色区域展示了WIMP（弱相互作用大质量粒
// 子）所占比例作为原初黑洞质量和WIMP质量的函数。由于图片
// 右侧被截断，坐标轴的具体数值标签和色标细节不可见。图中
// 左侧显示为一个倾斜的带状颜色渐变区域，颜色从蓝色过渡到
// 绿色再到灰白色，右侧为大面积的纯灰色区域。
#figure(placement: top, [#box(image("imgs/Figure_34a.png", width: 43.0%)) #box(image("imgs/Figure_34b.png", width: 52.0%))

  ],
  caption: [
    #emph[L]eft panel$#h(0em)$: constraints on $f_"PBH"$ as a function of PBH mass from extragalactic $gamma$-ray background for $m_chi = 10 thin "GeV"$ (dashed line), $100 thin "GeV"$ (dot-dashed line) and $1 thin "TeV"$ (dotted line), setting $chevron.l sigma v chevron.r = 3 times 10^(- 26) thin$cm$""^3$s$""^(- 1)$, and $f_"PBH" + f_chi = 1$. Also shown is the incredulity limit (one black hole within the particle horizon). #emph[R]ight panel$#h(0em)$: the colour shows the fraction of WIMPs $f_chi$ as a function of the PBH and WIMP masses. From Ref.~@Carr:2020mqm.
  ]
)
<fig:fPBHWIMP>



The above analysis can be extended to the case in which WIMPs do not provide most of the dark matter~@Carr:2020mqm. The right panel of @fig:fPBHWIMP shows the results, with the values of $f_chi$ being indicated by the coloured scale as a function of $M$ and $m_chi$. This shows the maximum WIMP density if most of the dark matter comprises PBHs of a certain mass and complements the constraints on the PBH density if most of the dark matter comprises WIMPs with a certain mass and annihilation cross-section. The left panel of @fig:fPBHWIMP can also be applied in the latter case, with all the constraints weakening as $f_chi^(- 1.7)$. The important point is that even a small value of $f_"PBH"$ may imply a strong upper limit on $f_chi$.


If $M gt.tilde 10^(- 11) thin M_⊙$ and $m_chi gt.tilde 100 thin$GeV, both the WIMP and PBH fractions are at most $cal(O) ( 10 "%" )$. Since neither of them can provide all the dark matter, this motivates a consideration of the situation with $f_"PBH" + f_chi lt.double 1$, which requires a #emph[third] dark matter candidate. Particles which are not produced through the mechanisms discussed above or which avoid annihilation include axion-like particles~@Abbott:1982af @Dine:1982ah @Preskill:1982cy, sterile neutrinos~@Dodelson:1993je @Shi:1998km, ultra-light or "fuzzy" dark matter~@Hu:2000ke @Schive:2014dra. The latter is interesting because of its potential interplay with stupendously large black holes~@Carr:2020erq. If light bosonic fields exist in nature, they could accumulate around rotating SMBHs and form a condensate, leading to superradiant instabilities~@Press:1972zz. As shown in @fig:BHboson, which is taken from Ref.~@Carr:2020erq, this leads to strong constraints on the mass $m_phi.alt$ of such a hypothetical boson.


// [figvision-cn] imgs/Figure_35.png
// 这是一张单幅科学曲线图，没有分子图a、b等。横轴名称为 M
// [M_⊙]，表示原初黑洞质量，单位为太阳质量，采用对数刻度，
// 范围从 10^10 到 10^15，主刻度标注为 10^10、10^11、10^
// 12、10^13、10^14、10^15，次刻度位于相邻主刻度之间。纵
// 轴名称为 m_φ [eV]，表示假想玻色子的质量，单位为电子伏
// 特，采用对数刻度，范围从 10^-27 到 10^-20，主刻度标注
// 为 10^-27、10^-26、10^-25、10^-24、10^-23、10^-22、10^
// -21、10^-20，次刻度位于相邻主刻度之间。 图中包含三组平
// 行的斜线，均为从左上向右下倾斜的直线，在对数坐标下斜率
// 约为 -1。图例位于右上角，用三条线型区分不同自旋参数 a_
// * 的取值：实线对应 a_* = 0.99，短虚线对应 a_* = 0.2，
// 长虚线对应 a_* = 0.01。每组线型由两条近似平行的线组成
// 一条带状区域：同组内上方那条线位于较高玻色子质量处，下
// 方那条线位于较低质量处，两者之间的区域用灰色填充，表示
// 该自旋参数下超辐射约束对应的参数空间。三组灰色带在图中
// 按 a_* 从大到小整体下移：a_* = 0.99 的带最高，a_* =
// 0.2 的带居中，a_* = 0.01 的带最低；三组带之间在上方区
// 域有部分重叠，但整体保持分层排序。所有线条均为黑色，无
// 标记点。 图中没有单独标注禁止区或允许区的文字，但灰色
// 填充区本身表示各 a_* 下超辐射质量约束所覆盖的黑洞质量-
// 玻色子质量参数组合。趋势上，随着黑洞质量 M 从 10^10 M_
// ⊙ 增大到 10^15 M_⊙，对应的约束玻色子质量 m_φ 从约 10^
// -21 eV 降至约 10^-26 eV，呈反比关系；同时，自旋参数 a_
// * 越大，同一黑洞质量下约束的玻色子质量越高，例如在 M =
// 10^10 M_⊙ 处，a_* = 0.99 的带约处于 10^-21 eV 附近，a_
// * = 0.2 的带约处于 10^-22 eV 附近，a_* = 0.01 的带约处
// 于 10^-23 eV 附近。
#figure(image("imgs/Figure_35.png", width: 48.0%),
  caption: [
    Superradiance constraints on the mass $m_phi.alt$ of a hypothetical boson as a function of PBH mass $M$. Results are shown for the #emph[observed] black hole spin parameter $a_(*) = 0.99$ (solid line), $a_(*) = 0.2$ (dashed line) and $a_(*) = 0.01$ (dotted line), defined in terms of the angular momentum $J$ as $a_(*) equiv J c / ( G M^2 )$. From Ref.~@Carr:2020erq.
  ]
)
<fig:BHboson>



Recently, Kadota & Hiroyuki~@Kadota:2022cij studied mixed dark matter scenarios consisting of PBHs and self-annihilating WIMPs through their synchrotron radiation at the radio frequency in the presence of galactic magnetic fields. This results in bounds on $f_"PBH"$ in the range $10^(- 8)$  $10^(- 5)$, depending on the WIMP annihilation channel and mass ($10$  $10^3$ ). These authors also investigated~@Tashiro:2021xnj the enhancement of heating and ionisation of the intergalactic medium due to WIMP annihilation, and found that the constraints on $f_"PBH"$ from CMB observations are comparable to or even tighter than those utilising $gamma$-ray data. Using $21$-cm observations and assuming strong Lyman-$alpha$ coupling, they find improved PBH limits for the canonical WIMP annihilation cross-section $chevron.l sigma v chevron.r = 3 times 10^(- 26) thin "cm"^3 thin upright(s)^(- 1)$: $f_"PBH" < 4 times 10^(- 10)$ for $m_chi = 100 thin$GeV and $f_"PBH" < 2 times 10^(- 9)$ for $m_chi = 1 thin$TeV.


Choi #emph[et al.]~@GilChoi:2023qrz have elaborated on a novel way to discriminate PBHs dressed by particle dark matter from PBHs without a halo. They show that microlensing abundance constraints on the former are significantly weakened and infer that dressed PBHs could provide all the dark matter in the range $0.1$ to $10^2 thin M_⊙$. They also demonstrate that diffractive lensing of chirping GWs from binary mergers can identify lenses consisting of dressed PBHs.


== Thermal-History Scenario
<sec:Thermal--History-Scenario>


Here we explore the possibility of explaining all the observational evidence for PBHs with a single unified theoretical scenario, as first described in Ref.~@Carr:2019kxo. Because the evidence covers a wide range of masses, this requires that the PBH mass function also be extended. We will argue that this could be a natural consequence of the standard thermal history of the Universe, combined with the dependence of the critical threshold for PBH formation on the sound-speed. In particular, one expects a rather specific mass function in the planetary to intermediate mass range, which is independent of the origin of the density fluctuations. For all formation scenarios, PBH clustering is another key ingredient in explaining the evidence and the inevitable clustering induced by the Poisson fluctuations was discussed in @sec:Clustering-of-PBHs. We must also consider the relationship between the primordial fluctuations on large and small cosmological scales (as probed by the CMB and PBHs, respectively), with particular emphasis on scenarios producing non-Gaussian tails in the fluctuation statistics~@Ezquiaga:2019ftu.


Reheating at the end of inflation fills the Universe with radiation. In the standard cosmological model, it remains dominated by relativistic particles until matter-radiation equality with an energy density decreasing as the fourth power of the temperature. As time increases, the number of relativistic degrees of freedom remains constant until around $200 thin$GeV, when the temperature of the Universe falls to the mass thresholds of the Standard Model particles. The first particle to become non-relativistic is the top quark at $172 thin$GeV, followed by the Higgs boson at $125 thin$GeV, the $Z$ boson at $92 thin$GeV and the $W$ boson at $81 thin$GeV. At the QCD transition, occurring at a temperature of around $200 thin$MeV, protons, neutrons and pions condense out of the free light quarks and gluons. A little later the pions become non-relativistic and then the muons, with $e^(+) e^(-)$ annihilation and neutrino decoupling occuring at around $1 thin$MeV.


// [figvision-cn] imgs/Figure_36.png
// 这是一张单面板的二维曲线图（物理学状态方程参数随温度变
// 化图），没有子图划分。 坐标轴设置：横轴为温度 T，采用
// 对数刻度，显示范围约为 0.01 到 10^6 兆电子伏特，标注的
// 刻度包括 0.1、10、1000、10^5，单位为兆电子伏特。纵轴为
// 状态方程参数 w，采用线性刻度，显示范围为 0.22 到 0.34，
// 主刻度间隔为 0.02，标有 0.22、0.24、0.26、0.28、0.30、
// 0.32、0.34。 图中包含一条蓝色实线，代表状态方程参数 w
// 随温度 T 的变化。这条曲线在低温（T 小于 0.1 兆电子伏特）
// 和高温（T 大于 10^5 兆电子伏特）时维持在恒定值约 0.333
// （图中上方灰色虚线即对应此值），但在中间温度区间出现多
// 个低谷。曲线在 T 约为 0.1 兆电子伏特时出现第一个凹陷，
// 降至约 0.30；在 T 约为 10 兆电子伏特时出现第二个小凹陷
// （降至约 0.305）；在 T 约为 100 兆电子伏特时出现最深的
// 一个 V 形低谷，降至约 0.23；在 T 约为 10^5 兆电子伏特
// 之前还有一个较浅的低谷，降至约 0.32。 图中有五条灰色竖
// 直细线，分别对应不同粒子的质量，从左至右依次标注了符号：
// m_e（电子质量，对应约 0.1 兆电子伏特）、m_π（π 介子质
// 量，对应约 10 兆电子伏特）、m_p（质子/中子质量，对应约
// 1000 兆电子伏特）、m_W,Z（W 和 Z 玻色子质量，对应约 10
// ^5 兆电子伏特）、m_t（顶夸克质量，对应约 10^5 兆电子伏
// 特，位置略靠右）。此外，图中央有一条灰色水平虚线横贯全
// 图，对应纵轴值约 0.333。 图中传达的趋势是：状态方程参
// 数 w 在极低和极高温度下近似等于 1/3，而在温度跨越各个
// 基本粒子质量阈值附近时，w 会显著下降，形成多个低谷。
#figure(placement: top, image("imgs/Figure_36.png", width: 70.0%),
  caption: [
    Equation-of-state parameter $w$ as a function of temperature $T$, from Ref.~@Carr:2019kxo. The grey vertical lines correspond to the masses of the electron, pion, proton/neutron, $W / Z$ bosons and top quark. The grey dashed horizontal line correspond to $w = 1 / 3$.
  ]
)
<fig:g-and-w-of-T>



Whenever the number of relativistic degrees of freedom suddenly drops, it changes the effective equation-of-state parameter $w equiv p \/ rho c^2$. As shown in @fig:g-and-w-of-T, there are thus four periods in the thermal history of the Universe when $w$ decreases. After each of these, $w$ resumes its relativistic value of $1 / 3$ but because the threshold overdensity required for PBH production $delta_(upright(c))$ is sensitive to the equation-of-state parameter $w ( T )$, the sudden drop modifies the probability of gravitational collapse of any large curvature fluctuations. This results in pronounced features in the PBH mass function even if the primordial fluctuations have a uniform power spectrum. If the PBHs form from Gaussian inhomogeneities with root-mean-square amplitude $delta_"rms"$, the fraction of horizon patches undergoing collapse to PBHs on mass scale $M$ is~@Carr:1975qj $ beta ( M ) & approx upright("Erfc") #h(-1em) [frac(delta_(upright(c)) ( w \[ T ( M ) \] ), sqrt(2) thin delta_(upright("rms")) ( M ))] , $<eq:beta-t> where the mass and temperature are related by $ T approx 200 thin sqrt(thin M_⊙ / M) #h(0em) upright("MeV") thin . $ Thus $beta ( M )$ is exponentially sensitive to $w ( M )$ and the present CDM fraction for PBHs of mass $M$ is $ f_(upright("PBH")) ( M ) equiv 1 / rho_(upright("CDM")) frac(upright(d) thin rho_(upright("PBH")) ( M ), upright(d) ln M) approx 2.4 #h(0em) beta ( M ) thin sqrt(M_(upright("eq")) / M) thin , $<eq:fPBH> where $M_"eq" = 2.8 times 10^17 thin M_⊙$ is the total horizon mass at matter-radiation equality and the numerical factor is $2 thin ( 1 + Omega_(upright(B)) / Omega_"CDM" )$ with $Omega_"CDM" = 0.245$ and $Omega_(upright(B)) = 0.0456$~@Aghanim:2018eyx.


There are many inflationary models and they predict a variety of shapes for $delta_"rms" ( M )$. Some models produce an extended plateau or dome-like feature in the power spectrum. For example, this applies for two-field models like hybrid inflation~@Clesse:2015wea and even some single-field models like Critical Higgs Inflation~@Ezquiaga:2017fvi. This results in a quasi-scale-invariant spectrum, $ delta_(upright("rms")) ( M ) = A (frac(M, thin M_⊙))^(#h(-1em) ( 1 - n_(upright(s)) ) / 4 thin + thin alpha_(upright(s)) / 8 ln ( M / M_⊙ )) #h(0em) , $<eq:delta-power-law> where the spectral index $n_(upright(s))$, its running $alpha_(upright(s)) equiv upright(d) ln n_(upright(s)) ( k ) / upright(d) ln k$ and the amplitude $A$ are treated as free phenomenological parameters. This could represent any spectrum with a broad peak, such as might be generically produced by a second phase of slow-roll inflation. We choose $A = 0.0218$ for $n_(upright(s)) = 0.986$ and $alpha_(upright(s)) = - 0.0018$, in order to get an integrated abundance $f_"PBH" = 1$. Following Refs.~@Carr:2019hud @Garcia-Bellido:2019vlf, the ratio of the PBH mass and the horizon mass at re-entry is assumed to be $0.8$. The resulting mass functions are represented in @fig:effect-of-tilt-and-running. There is a dominant peak at $M tilde.eq 2 thin M_⊙$ and three additional bumps at $10^(- 5) thin M_⊙$, $30 thin M_⊙$ and $10^6 thin M_⊙$. Earlier works~@Jedamzik:1996mr @Byrnes:2018clq @Clesse:2020ghq @Jedamzik:2020omx have also discussed the effect of the QCD transition on PBH formation but not that of the other transitions. All the effects were first considered in a unified way in Ref.~@Carr:2019kxo. Depending on the running and tilt, these bumps are more or less pronounced, as can be seen in @fig:effect-of-tilt-and-running. This shows that small variations of the tilt and its running can dramatically change the normalisation and thus the height of the main peak.


Two recent numerical studies of PBH formation at the QCD epoch by Escrivà #emph[et al.]~@Escriva:2022bwe and Musco #emph[et al.]~@Musco:2023dak have treated the effects of the varying sound speed and equation of state during PBH formation more consistently. Both give a somewhat different PBH mass function, although the same qualitative feature of a peak at around $1 thin M_⊙$ is retained. This may be explained by subtle differences in the assumed curvature profiles, the interpolation method between data points of the equation of state as a function of the temperature and by the exact recipe for the computation of the PBH mass distribution. The precise mass distribution is therefore still uncertain and model-dependent. This can impact the analysis of PBH merger rates. Moreover, different fundamental physics around the QCD epoch, such as gluon condensation, could drastically change the shape of the mass distribution around $1 thin M_⊙$~@Garcia-Bellido:2021zgu. A detailed spectroscopic mass resolution around that peak could thus reveal the nature of the phase transition and possibly new fundamental physics.


// [figvision-cn] imgs/Figure_37a.png
// 这是一张单面板的对数-对数坐标系曲线图，用于展示原初黑
// 洞质量函数 fPBH(M) 随质量 M 的变化，以及谱倾斜参数 ns
// 的影响。 坐标轴：横轴为质量 M，单位是太阳质量 M⊙，采用
// 对数刻度，从左到右依次标注 10⁻⁹、10⁻⁵、0.1、1000.0、10
// ⁷；纵轴为原初黑洞质量分数 fPBH(M)，采用对数刻度，范围
// 从 10⁻⁶ 到 1，主刻度依次标注 10⁻⁶、10⁻⁵、10⁻⁴、0.001、
// 0.010、0.100、1。 图中包含三条红色实线曲线和一条蓝色阴
// 影带。三条红色曲线代表不同 ns 取值下的质量函数：上方曲
// 线对应 ns = 0.975，下方曲线对应 ns = 0.965，中间曲线未
// 直接标注数值，应介于两者之间。红色曲线在 M ≈ 0.2 M⊙ 附
// 近均出现一个尖锐主峰，峰值接近 1（约 0.6–0.9 之间），
// 随后在更大质量区间出现多个次级峰和整体下降趋势。蓝色阴
// 影带由两条深蓝色边界曲线围成，表示某种包络或不确定范围，
// 其整体走势与红色曲线一致：在 M ≈ 0.2 M⊙ 处同样出现主峰，
// 峰顶接近 1；在 M > 1 M⊙ 的区间，蓝色带的下边界明显低于
// 红色曲线，上边界则高于红色曲线，整体覆盖了红色曲线的变
// 化范围。图中在 M ≈ 0.2 M⊙ 处有一条细竖直线穿过主峰位置。
// 趋势与结论：谱倾斜参数 ns 主要影响峰后（M > 1 M⊙）的质
// 量函数幅度，ns 越大（0.975），fPBH 在中等质量区间越高；
// ns 越小（0.965），fPBH 越低。主峰位置和质量几乎不受 ns
// 影响。蓝色阴影带展示了在 ns 变化之外的其他参数或不确定
// 性对质量函数包络的影响，尤其在低质量和高质量尾部更为显
// 著。
// [figvision-cn] imgs/Figure_37a.png
// 这是一张单面板的对数-对数坐标系曲线图，用于展示原初黑
// 洞质量函数 fPBH(M) 随质量 M 的变化，以及谱倾斜参数 ns
// 的影响。 坐标轴：横轴为质量 M，单位是太阳质量 M⊙，采用
// 对数刻度，从左到右依次标注 10⁻⁹、10⁻⁵、0.1、1000.0、10
// ⁷；纵轴为原初黑洞质量分数 fPBH(M)，采用对数刻度，范围
// 从 10⁻⁶ 到 1，主刻度依次标注 10⁻⁶、10⁻⁵、10⁻⁴、0.001、
// 0.010、0.100、1。 图中包含三条红色实线曲线和一条蓝色阴
// 影带。三条红色曲线代表不同 ns 取值下的质量函数：上方曲
// 线对应 ns = 0.975，下方曲线对应 ns = 0.965，中间曲线未
// 直接标注数值，应介于两者之间。红色曲线在 M ≈ 0.2 M⊙ 附
// 近均出现一个尖锐主峰，峰值接近 1（约 0.6–0.9 之间），
// 随后在更大质量区间出现多个次级峰和整体下降趋势。蓝色阴
// 影带由两条深蓝色边界曲线围成，表示某种包络或不确定范围，
// 其整体走势与红色曲线一致：在 M ≈ 0.2 M⊙ 处同样出现主峰，
// 峰顶接近 1；在 M > 1 M⊙ 的区间，蓝色带的下边界明显低于
// 红色曲线，上边界则高于红色曲线，整体覆盖了红色曲线的变
// 化范围。图中在 M ≈ 0.2 M⊙ 处有一条细竖直线穿过主峰位置。
// 趋势与结论：谱倾斜参数 ns 主要影响峰后（M > 1 M⊙）的质
// 量函数幅度，ns 越大（0.975），fPBH 在中等质量区间越高；
// ns 越小（0.965），fPBH 越低。主峰位置和质量几乎不受 ns
// 影响。蓝色阴影带展示了在 ns 变化之外的其他参数或不确定
// 性对质量函数包络的影响，尤其在低质量和高质量尾部更为显
// 著。
#figure(placement: top, [#box(image("imgs/Figure_37a.png", width: 65%)) \
  #box(image("imgs/Figure_37b.png", width: 65%))

  ],
  caption: [
    The effect of the spectral tilt (upper panel) and its running (lower panel) on the thermal- history-induced mass function $f_"PBH" ( M )$. From Ref.~@Garcia-Bellido:2022fgh
  ]
)
<fig:effect-of-tilt-and-running>



Another example of how fundamental physics can change the shape of the PBH mass function concerns lepton-flavour asymmetries. Observationally allowed lepton flavour asymmetries~@Oldengott:2017tzj could dramatically change the functional form of the bumps and even their location~@Bodeker:2020stj. @fig:fPBH illustrates this for the three examples analysed in Ref.~@Bodeker:2020stj.

- $ell_e = ell_mu = ell_tau = - thin 5.3 times 10^(- 11)$~\[green, solid line\];

- $ell_e = 0$ and $ell_mu = - thin ell_tau = 4 times 10^(- 2)$~\[red, dotted line\];

- $ell_e = - thin 8 times 10^(- 2)$ and $ell_mu = ell_tau = 4 times 10^(- 2)$ ~\[blue, dashed line\],

where the lepton flavour asymmetries are defined as $ ell_alpha equiv frac(n_alpha - n_(macron(alpha)) + n_(nu_alpha) - n_(macron(nu)_alpha), s) #h(0em) , quad alpha thin in thin ( e , thin mu , thin tau ) #h(0em) . $<eq:leptonasymmetry> Here, $n_alpha$ and $n_(macron(alpha))$ denote the number density of the particles and antiparticles, and $s$ is the entropy density. For adiabatic expansion, the $ell_alpha$ are conserved between the electroweak transition at $T tilde.eq 160 thin$GeV and electron-positron annihilation at $T tilde.eq 10 thin "MeV"$. The baryon asymmetry of the Universe is constrained from CMB observations~@Aghanim:2018eyx and primordial element abundances~@Pitrou:2018cgg to be $eta = 8.7 times 10^(- 11)$. Constraints on the lepton asymmetries are, however, many orders of magnitude weaker and allow for a total lepton asymmetry~@Oldengott:2017tzj $ \| ell_e + ell_mu + ell_tau \| < 1.2 times 10^(- 2) thin . $<eq:ell-total> In particular, as pointed out in Refs.~@Stuke:2011wz @Middeldorf-Wygas:2020glx @Vovchenko:2020crk, scenarios with unequal lepton flavour asymmetries (before the onset of neutrino oscillations) are observationally almost unconstrained and therefore open up a whole new parameter space for the evolution of the Universe around the QCD transition.


// [figvision-cn] imgs/Figure_38a.png
// 这是一张单幅曲线图。横轴为温度 T，单位为 MeV，对数坐标，
// 范围约从 10 MeV 到 5000 MeV 以上，主刻度标注为 10、50、
// 100、500、1000、5000。纵轴为有效状态方程参数 w，线性坐
// 标，范围从 0.21 到 0.34，主刻度间隔 0.02。图中包含一条
// 水平灰色点划线，位于 w 约 0.333 处，表示辐射流体的参考
// 值。图中共有四条曲线：绿色实线、蓝色虚线、红色点线和一
// 条绿色细实线。绿色粗实线对应标准情形（case 1），蓝色虚
// 线和红色点线对应另外两种轻子味不对称情形。所有曲线在 T
// 约 10 MeV 时起始于 w 约 0.333，随温度升高先下降，在 T
// 约 50 MeV 附近形成一个局部极小值（w 约 0.303-0.304），
// 随后略微回升至 T 约 100 MeV 附近的局部极大值（w 约
// 0.308），接着在 T 约 200 MeV 附近出现一个深谷，其中绿
// 色实线谷底最深（w 约 0.210），蓝色虚线谷底约 0.259，红
// 色点线谷底约 0.243；谷底之后所有曲线随温度升高而单调上
// 升，在 T 约 5000 MeV 时趋近于 0.333 的辐射流体参考值。
// 绿色细实线在 T 约 1000 MeV 后略高于绿色粗实线，在 T 约
// 5000 MeV 时两者接近。图注说明左侧面板（即此图）展示有
// 效状态方程参数随温度的变化，绿色实线为标准情形，灰色点
// 划线为辐射流体参考。
// [figvision-cn] imgs/Figure_38a.png
// 这是一张单幅曲线图。横轴为温度 T，单位为 MeV，对数坐标，
// 范围约从 10 MeV 到 5000 MeV 以上，主刻度标注为 10、50、
// 100、500、1000、5000。纵轴为有效状态方程参数 w，线性坐
// 标，范围从 0.21 到 0.34，主刻度间隔 0.02。图中包含一条
// 水平灰色点划线，位于 w 约 0.333 处，表示辐射流体的参考
// 值。图中共有四条曲线：绿色实线、蓝色虚线、红色点线和一
// 条绿色细实线。绿色粗实线对应标准情形（case 1），蓝色虚
// 线和红色点线对应另外两种轻子味不对称情形。所有曲线在 T
// 约 10 MeV 时起始于 w 约 0.333，随温度升高先下降，在 T
// 约 50 MeV 附近形成一个局部极小值（w 约 0.303-0.304），
// 随后略微回升至 T 约 100 MeV 附近的局部极大值（w 约
// 0.308），接着在 T 约 200 MeV 附近出现一个深谷，其中绿
// 色实线谷底最深（w 约 0.210），蓝色虚线谷底约 0.259，红
// 色点线谷底约 0.243；谷底之后所有曲线随温度升高而单调上
// 升，在 T 约 5000 MeV 时趋近于 0.333 的辐射流体参考值。
// 绿色细实线在 T 约 1000 MeV 后略高于绿色粗实线，在 T 约
// 5000 MeV 时两者接近。图注说明左侧面板（即此图）展示有
// 效状态方程参数随温度的变化，绿色实线为标准情形，灰色点
// 划线为辐射流体参考。
#figure(placement: top, [#box(image("imgs/Figure_38a.png", width: 42%)) #box(image("imgs/Figure_38b.png", width: 51%))

  ],
  caption: [
    #emph[Left panel:] Effective equation-of-state parameter as a function of temperature. Shown are the three cases of different lepton flavour asymmetry and the $1 / 3$ for a radiation fluid. The standard scenario \[case (1)\] is indicated by the green solid line. #emph[Right panel:] Spectral density of the PBH dark matter fraction as a function of PBH mass, for the three cases. The green solid line indicates the standard scenario. Also shown is the LIGO sensitivity curve (grey dot-dashed line) from Ref.~@LIGOScientific:2018mvr, for equal-mass mergers and using the maximal GW frequency $f_"max"^() approx 4400 thin M_⊙ / M$ for the conversion from frequency to mass. From Ref.~@Bodeker:2020stj.
  ]
)
<fig:fPBH>



The left panel of @fig:fPBH shows how non-zero flavour asymmetries weaken the softening of $w$ during the transition, with even $ell_e = 0$ yielding a pronounced effect. Two cases of unequal lepton flavour asymmetry are chosen for illustrative purposes. Note that a lepton flavour asymmetry always weakens the softening of the equation of state during the QCD transition, as it adds leptons to the Universe which do not interact strongly. This is different from the smaller effect at the pion/muon plateau, where lepton flavour asymmetries can lead to either stiffening or softening (c.f.~the two cases of unequal flavour asymmetry) as pions and muons become non-relativistic. The corresponding result for the PBH dark matter fraction is depicted in the right panel of @fig:fPBH. Due to the exponential enhancement of Eq.~(#ref(<eq:beta-t>)), the three cases differ significantly. The effect of lepton flavour asymmetries are currently being explored. As shown by Gao & Oldengott~@Gao:2021nwz, the cosmic QCD transition might even become first order if the asymmetries are sufficiently large, with a dramatic impact on the PBH mass function.


== Comparing Evidence with Thermal-History Model
<sec:Comparing-Evidence-with-Thermal--History-Model>


In @fig:PositiveEvidence and~@fig:figZ1, we have indicated the PBH mass and dark matter fraction required to explain the various type of observational evidence discussed in this review. We now explain the derivation of these regions in more detail, considering the lensing, dynamical and GW arguments in turn. However, just as for PBH constraints, all these estimates are based on various assumptions and subject to significant uncertainties. In particular PBH properties (such as mass function, clustering etc.) can modify the different regions. Unless indicated otherwise, we assume a monochromatic PBH mass function.


// [figvision-cn] imgs/Figure_39.png
// 这是一张单子图的科学曲线图（通过填充色块表示约束区域），
// 没有子图划分。图表展示了原初黑洞质量函数 \(f_{\mathrm{
// PBH}}(M)\) 随质量 \(M\) 的变化关系，并在同一坐标系上叠
// 加了多种观测对原初黑洞丰度的限制。 坐标轴： 横轴为原初
// 黑洞质量 \(M[M_\odot]\)（以太阳质量为单位），采用对数
// 刻度，范围从 \(10^{-12}\) 到约 \(10^{10}\)，主要刻度标
// 记为 \(10^{-12}\)、\(10^{-8}\)、\(10^{-4}\)、\(10^0\)、
// \(10^4\)、\(10^8\)。 纵轴为原初黑洞质量函数（暗物质占
// 比）\(f_{\mathrm{PBH}}(M)\)，采用对数刻度，范围从 \(10
// ^{-5}\) 到 \(1\)，主要刻度标记为 \(10^{-5}\)、\(10^{-4
// }\)、\(0.001\)、\(0.010\)、\(0.100\)、\(1\)。 主曲线：
// 图中有一条粗黑色虚线曲线，表示由宇宙热历史诱导产生峰值
// 特征的原初黑洞质量函数。该曲线呈现多峰结构：在 \(M \
// sim 10^{-11} M_\odot\) 处约为 \(0.0015\)，随后上升并在
// \(M \sim 10^{-7} M_\odot\) 处达到局部峰值约 \(0.008\)；
// 在 \(M \sim 10^{-4} M_\odot\) 处形成第二个局部峰值约 \
// (0.02\)，随后下降至 \(M \sim 10^{-1} M_\odot\) 处的极
// 小值约 \(0.008\)；之后急剧上升，在 \(M \sim 10^0 M_\
// odot\) 附近达到最高峰约 \(0.8\) 以上（接近 1）；随后迅
// 速下降，在 \(M \sim 10^5 M_\odot\) 处降至约 \(3\
// times10^{-4}\)，并在 \(M \sim 10^7 M_\odot\) 处形成一
// 个小幅回升至约 \(4\times10^{-4}\)，最终在 \(M \sim 10^
// 9 M_\odot\) 处降至 \(10^{-5}\) 以下。 约束区域（浅色阴
// 影区，均表示被排除的参数空间）： SNe（红色斜线阴影）：
// 位于 \(M \sim 10^{-12}\) 至 \(10^{-9} M_\odot\)，上限
// 从约 \(0.01\) 上升至超过 \(1\)。 HSC（灰色斜线阴影）：
// 位于 \(M \sim 10^{-10}\) 至 \(10^{-5} M_\odot\)，呈 U
// 形，最低点约在 \(M \sim 10^{-8} M_\odot\) 处，\(f_{\
// mathrm{PBH}} \sim 0.01\)，两侧上升。 Ogle（绿色椭圆区
// 域）：位于 \(M \sim 10^{-6}\) 至 \(10^{-4} M_\odot\)，
// 中心约在 \(M \sim 10^{-5} M_\odot\)，\(f_{\mathrm{PBH}
// } \sim 0.02-0.05\)。 P-A（浅蓝色斜线阴影）：位于 \(M \
// sim 10^{-7}\) 至 \(10^{-2} M_\odot\)，上边界从约 \(1\)
// 下降至 \(0.1\)。 Quasars（青色斜线阴影）：位于 \(M \
// sim 10^{-5}\) 至 \(10^{-1} M_\odot\)，上边界约在 \(0.2
// \) 至 \(1\) 之间。 MACHO（橙红色斜线阴影）：位于 \(M \
// sim 10^{-1}\) 至 \(10^1 M_\odot\)，上限约在 \(0.1\) 至
// \(0.5\) 之间。 SSM（深蓝色竖直窄带）：位于 \(M \sim 10
// ^0 M_\odot\) 附近，极窄，上限接近 \(1\)。 Ogle+Gaia（
// 深灰色斜线阴影）：位于 \(M \sim 10^{-1}\) 至 \(10^0 M_
// \odot\)，上限约 \(0.1\) 至 \(0.5\)。 PTA（紫色竖直窄带）：
// 位于 \(M \sim 10^{-1}\) 至 \(10^0 M_\odot\)，极窄，上
// 限接近 \(1\)。 LVK（橙色斜线阴影）：位于 \(M \sim 10^0
// \) 至 \(10^1 M_\odot\)，下限低至 \(10^{-5}\)，上限约 \
// (0.1\) 至 \(0.5\)。 C-C（棕褐色斜线阴影）：位于 \(M \
// sim 10^0\) 至 \(10^2 M_\odot\)，上边界从约 \(1\) 下降
// 至 \(10^{-4}\)。 UFDGs（浅米色斜线阴影）：位于 \(M \
// sim 10^3\) 至 \(10^5 M_\odot\)，呈楔形，上边界从约 \(
// 0.1\) 下降至 \(10^{-4}\)。 CIB-XRB（浅绿色斜线阴影）：
// 位于 \(M \sim 10^2\) 至 \(10^9 M_\odot\)，上边界从约 \
// (1\) 下降至 \(0.01\)。 SMBHs（紫色斜线阴影）：位于 \(M
// \sim 10^3\) 至 \(10^9 M_\odot\)，上边界从约 \(0.05\)
// 下降至 \(0.01\) 以下。 图中还包含一条细红色实线，位于
// \(M \sim 10^{-11}\) 至 \(10^{-8} M_\odot\) 之间，从 \(
// f_{\mathrm{PBH}} \sim 0.01\) 上升至超过 \(1\)。 趋势与
// 结论：该图表明，在宇宙热历史诱导的多峰质量函数模型中，
// 原初黑洞在 \(M \sim 10^0 M_\odot\)（恒星级质量）附近存
// 在一个显著的高峰，该峰值受到 SSM、PTA、MACHO、LVK 等多
// 种观测的严格限制；在 \(M \sim 10^{-5} M_\odot\) 和 \(M
// \sim 10^{-10} M_\odot\) 附近的小峰则分别与 Ogle、HSC
// 等约束区域相交或接近，部分参数空间被排除。
#figure(placement: top, image("imgs/Figure_39.png", width: 89.0%),
  caption: [
    PBH mass function with peaks induced by the thermal history of the Universe (thick, dashed curve; c.f.~Ref.~@Carr:2019kxo). This replicates the positive features of @fig:PositiveEvidence but also includes various monochromatic constraints on $f_"PBH" ( M )$ (light-shaded regions), taken from Ref.~@carr2020primordial.
  ]
)
<fig:figZ1>



#strong[PBH dark matter fraction from lensing evidence.] We have estimated the PBH dark matter fraction for six types of lensing evidence in the following way:

- #emph[For HSC], we have reinterpreted the limits of Ref.~@Niikura:2017zjd. Instead of assuming no detection, we have computed the $2 sigma$ confidence intervals for $f_"PBH"$ assuming that one PBH microlensing event was observed. The limit is identified with a band using simple Poisson statistics. All the assumptions are therefore identical to those of Ref.~@Niikura:2017zjd.

- #emph[For OGLE], we show the $2 sigma$ allowed region provided in Fig.~8 of Ref.~@Niikura:2019kqi, combining the OGLE confidence region with the HSC exclusion region.

- #emph[For POINT-AGAPE pixel-lensing (P-A)], we provide a band of possible $f_"PBH"$ values based on the Table 9 of Ref.~@CalchiNovati:2005cd, where $2 sigma$ confidence intervals were estimated for different PBH masses.

- #emph[For quasars], there is not yet a robust estimation of a confidence region despite the fact that we consider them as a strong evidence for a large fraction of dark matter made of compact objects. We therefore consider a relatively broad range of PBH masses, between $10^(- 2) thin M_⊙$ and $10 thin M_⊙$, and a lower limit of $f_"PBH" > 0.1$, but these are only order-of-magnitude estimates.

- #emph[For MACHO], the $2 sigma$ region comes from Refs.~@1996ApJ...461...84A@2007AandA...469..387T. We have argued that the MACHO microlensing events are real and plausibly due to PBHs, despite EROS and OGLE later claiming more stringent limits.

- #emph[For OGLE+Gaia], we assume that all the microlensing events are due to PBHs. The indicated band comes from the lowest and highest mean masses shown in @fig:figX, obtained by the analysis of Ref.@2020AandA...636A..20W, and there is a somewhat arbitrary lower bound, $f_"PBH" approx 10^(- 3)$, below which PBHs are unlikely to explain so many microlensing events.

All these estimates are subject to large uncertainties. In particular, the size of PBH clusters could alter the PBH fraction inferred from microlensing of stars towards the Magellanic Clouds. @fig:PositiveEvidence represents the ideal situation, in which all the observations are due to PBHs. However, since alternative origins are not excluded, it is possible that only a some of them are.


#strong[PBH dark matter fraction from dynamical and accretion evidence.] We have estimated the PBH dark matter fraction for the five types of dynamical and accretion evidence as follows:

- #emph[For SNe], the band corresponds to the one shown in @fig:datacompare, which is taken from Ref.~@2022arXiv221100013S.

- #emph[For UFDGs], we assume $0.3 < f_"PBH" thin M / thin M_⊙ < 30$, with a maximum mass of $10^4 thin M_⊙$. These values are somewhat arbitrary and do not result from a robust statistical analysis, but the large cosmological, astrophysical and observational uncertainties would limit the validity of a more refined analysis. The values shown correspond to the two extreme cases displayed in @fig:rcvsmc. With our simple modelling of PBH clustering, these values could simultaneously explain (1) the minimum size of observed UFDGs, (2) the relation between their radius and mass, and (3) their very large mass-to-light ratios due to PBH gas accretion.

- #emph[For C-C (core-cusp)], the displayed region is based on the lower limits from Fig.~7 of Ref.~@Boldrini:2019isx, extrapolated up to a mass of $10^3 thin M_⊙$ since there is no theoretical restriction on this, other than there being enough PBHs for dynamical heating to be efficient.

- #emph[For CIB-XRB correlations], the band corresponds to $1 < f_"PBH" thin M / thin M_⊙ < 100$ up to a mass of $10^4 thin M_⊙$. We have not used a rigorous statistical analysis to get more precise values but the proposed band agrees with the order-of-magnitude estimate in Ref.~@Kashlinsky:2016sdv.

- #emph[For SMBHs], we have followed Ref.~@Carr:2019kxo in assuming a linear relation between the central IMBH or SMBH mass and stellar mass, as suggested by the gray band in Fig.~1 of Ref.~@Kruijssen:2013cna, as well as a Press--Schechter halo mass function. The upper limit neglects the effects of accretion and mergers. The origin of IMBHs and SMBHs in clusters and galaxies is therefore related to the PBH mass distribution. The lower limit assumes that the PBH mass increased during the pregalactic era at the Bondi rate, given by Eq.~(#ref(<eq:Bondi>)), until it reached the Eddington limit, given by Eq.~(#ref(<eq:Eddington>)). However, this is subject to the large uncertainties in the accretion process. We note that @fig:effect-of-tilt-and-running suggests $f_"PBH" ( M ) prop M^(- 1 / 4)$ for $M > 10 thin M_⊙$ in the thermal-history model, which corresponds to a power-law function with $alpha approx 9 / 4$.


The proposed regions depend on the very uncertain physical processes which underlie the dynamical evolution of PBH clusters and the accretion process throughout cosmic history. Most of the dynamical and accretion evidence relates to the mass range from one to a billion solar masses and therefore complements the microlensing and GW evidence. This clearly favours models with an extended PBH mass distribution. In this case, all the evidence depends on Poisson-induced clustering. Since this is determined by the product $f_"PBH" thin M$, PBHs with different masses would contribute to the effect in such a way that a distribution not crossing the proposed region can still provide the required effect. Although such extended mass distributions may conflict with the stringent constraints on the CMB distortions and anisotropies, these can be relaxed for realistic accretion models if PBH formation is associated with curvature fluctuations with non-Gaussian tails~@2022arXiv221207969F.


#strong[PBH dark matter fraction from GW evidence.] We have estimated the PBH dark matter fraction for various types of GW evidence. For this purpose, we have considered the merger rates of early binaries for a monochromatic model, but obviously the range of component masses associated with the observed coalescences points to an extended mass distribution.

- #emph[For subsolar-mass candidates], we have used the three subsolar-mass triggers in the LVK O3b observing run to derive credible $2 sigma$ intervals for $f_"PBH"$ in the monochromatic case. More precisely, we use the chirp mass associated with each candidate to compute an associated interval for $f_"PBH"$, this mass being well reconstructed for GW events. In each case, it is sufficiently below $1 thin M_⊙$ to guarantee that at least one of the components is a subsolar-mass compact object for a real GW signal. We then assume that the two components have the same mass and use the volume-time sensitivity $chevron.l V T chevron.r$ obtained in Ref.~@LVK:O3bSSM for each mass. When combined with the expected merger rate of early binaries, using simple Poisson statistics, one can compute a $2 sigma$ interval for $f_"PBH"$ for each subsolar-mass trigger.

- #emph[For LVK], we have used the inferred merger rates in intervals at different masses, for the O1, O2 and O3 runs and the binned Gaussian process model of Ref.~@KAGRA:2021duu, considering only the rates for equal-mass mergers shown in their Fig.~4 (orange regions). For each bin, we have then compared this with the expected merger rates of early binaries for a monochromatic model to infer the $90 "%"$ CL intervals for $f_"PBH"$. This model does not allow $f_"PBH"$ to reach $1$ but it could still exceed $0.1$ at solar-mass scale, bearing in mind the uncertainties associated with the rate model.

- #emph[For PTAs], we have used the two-dimensional marginalised posterior distributions of the primordial power spectrum amplitude and pivot wavelength mode calculated for IPTA observations in Ref.~@Dandoy:2023jot, as shown in @fig:PTA\; this assumes a log-normal primordial power spectrum. In order to translate these contours into $f_"PBH"$ constraints, we have assumed a critical overdensity threshold for PBH formation at the QCD epoch and a corresponding PBH abundance in agreement with the recent numerical simulations of Ref.~@Escriva:2022bwe. The obtained region is extremely sensitive to the threshold values and the method used to compute the PBH abundance, so it can vary by several orders of magnitudes.


The uncertainties and model dependence of the merger rates, the exact PBH formation mechanism, and the various possibilities for the statistics of the curvature fluctuations, clearly blur the calculated intervals for GW mergers and PTAs. Nevertheless, GW observations hint at a peak in $f_"PBH"$ at the solar-mass scale, as expected for PBHs forming at QCD epoch. These observations complement and agree well with the lensing, dynamical and accretion evidence. The fit with the data is consistent with all the constraints if one uses a running spectral index for the power spectrum at PBH scales, as suggested in Ref.~@Hasinger:2020ptw. In this case, we are considering a spectral tilt $n_(upright(s)) = 0.986$ and running $alpha_(upright(s)) = - 0.0018$ at PBH scales. These values are remarkably close to those measured at CMB scales, which may hint that Critical Higgs Inflation generates the full matter power spectrum.


== PBHs, Baryogenesis and the Fine-Tuning Problem
#<sec:PBHs--Baryogenesis-and-the-Fine--Tuning-Problem>


In this section we argue that the coincidence between the dark matter and baryonic densities suggests a common origin, which is linked to baryogenesis. There are several ways in which PBHs could have induced baryogenesis and, in this sense, the observed baryon asymmetry might be considered positive evidence for them. In particular, we emphasise that the density coincidence is naturally explained if the PBHs have around a solar mass and form at the QCD epoch. This is because each region collapsing to a PBH is surrounded by a hot expanding shell, in which all the Sakharov conditions for efficient low-temperature electroweak baryogenesis are satisfied. This provides a natural connection between the PBH collapse fraction and the cosmological baryon asymmetry.


The important point is that observations imply that only a tiny fraction of the early Universe could have collapsed into PBHs. The current density parameter $Omega_"PBH"$ of PBHs which form at a redshift $z$ is related to the initial collapse fraction $beta$ by~@Carr:1975qj $ Omega_(upright("PBH")) = beta #h(0em) Omega_(upright(R)) thin ( 1 + z ) approx 10^6 thin beta (t / upright(s))^(#h(-1em) - 1 / 2) approx 10^18 thin beta (frac(M, 10^15 thin upright(g)))^(#h(-1em) - 1 / 2) , $<beta> where $Omega_(upright(R)) approx 5 times 10^(- 5)$ is the density parameter of the CMB. The $( 1 + z )$ factor arises because the radiation density scales as $( 1 + z )^4$, whereas the PBH density scales as $( 1 + z )^3$. The CDM density parameter is $Omega_"CDM" approx 0.25$, so $beta$ must be tiny even if PBHs provide all of it. For example, PBHs of $10^15 thin$g, the smallest ones avoiding evaporation, would have $beta tilde 10^(- 18)$, while those of $1 thin M_⊙$ would have $beta tilde 10^(- 9)$. More generally, any limit on $Omega_"PBH"$ places a constraint on $beta ( M )$. Requiring $Omega_"PBH" < Omega_"CDM"$ above $10^15 thin$g is the most basic constraint but there are many stronger ones, as discussed in numerous papers (e.g.~Ref.~@Carr:1994ar). In particular, interesting constraints are associated with PBHs smaller than $10^15 thin$g since they would have evaporated by now. The strongest one is the $gamma$-ray limit associated with PBHs evaporating at the present epoch.


The fine-tuning of the collapse fraction required to explain the dark matter is sometimes regarded as a criticism of the PBH dark matter proposal. Furthermore, it implies even more fine-tuning on the amplitude of the density fluctuations generating the PBHs, since Eq.~(#ref(<eq:beta-t>)) implies that $beta$ depends exponentially on this amplitude. However, the small value of $beta$ implied by @beta itself derives from the high photon-to-baryon ratio associated with the small baryon asymmetry of the Universe (BAU) at the QCD epoch ($eta tilde 10^(- 9)$). The origin of this asymmetry and the PBH collapse fraction are thus linked. The standard assumption is that high-energy physics generates the baryon asymmetry everywhere simultaneously via out-of-equilibrium particle decays or a first-order phase transition well before PBH formation. However, there is no direct evidence for this and --- even if the process occurs --- it may not provide all the baryon asymmetry required.


García-Bellido #emph[et al.]~@Garcia-Bellido:2019vlf have proposed an alternative scenario in which the gravitational collapse to PBHs at the QCD epoch can resolve both these problems. The collapse is accompanied by the violent expulsion of surrounding material, which might be regarded as a sort of “primordial supernova”. Such high density #emph[hot spots] provide the out-of-equilibrium conditions required to generate a baryon asymmetry~@Sakharov:1967dj through the well-known electroweak sphaleron transitions responsible for Higgs windings around the electroweak vacuum~@Asaka:2003vt. The charge-parity symmetry violation of the Standard Model then suffices to generate a local baryon-to-photon ratio of order one. The hot spots are separated by many horizon scales but the outgoing baryons propagate away from them at the speed of light and become homogeneously distributed well before BBN. The large initial local baryon asymmetry is thus diluted to the tiny observed global BAU. This naturally explains why the observed BAU is of order the PBH collapse fraction and why the baryons and dark matter have comparable densities. The situation is illustrated qualitatively in @fig:BAU. Only at the QCD epoch are the conditions such that over-the-barrier sphalerons can occur via the heating of the surrounding plasma due to the violent shockwave at PBH formation. This is because the rapid quenching at QCD temperatures prevents baryon washout~@Garcia-Bellido:2019vlf.


The energy available for hot spot electroweak baryogenesis can be estimated as follows. Energy conservation implies that the change in kinetic energy due to the collapse of matter within the Hubble radius to the Schwarzschild radius of the PBH is $
  Delta K & = (1/gamma - 1) thin M_"H" = (1 - gamma)/(gamma^2) thin M,
$ where $M_(upright(H))$ is the Hubble mass and $gamma$ is the size of the black hole compared to the Hubble horizon. The energy acquired per proton in the expanding shell is $E_0 = Delta K / ( n_(upright(p)) thin Delta V )$, where $Delta V = ( 1 thin - thin gamma^3 ) thin V_(upright(H))$ is the difference between the Hubble and PBH volumes, so $E_0$ scales as $( gamma thin + thin gamma^2 thin + thin gamma^3 )^(- 1)$. For a PBH formed at $T approx Lambda_"QCD" approx 140 thin "MeV"$, the effective temperature is $T_"eff" = 2 thin E_0 / 3 approx 5 thin$TeV, which is well above the sphaleron barrier and induces a charge-parity violation parameter $delta_"CP" ( T ) tilde 10^(- 5) thin ( T / 20 thin "GeV" )^(- 12)$~@Shaposhnikov:1998ewc. The appropriate reheat temperature $T_"rh"$ is the geometric mean of $T_"eff"$ and the temperature of the thermal plasma, $T_"pl" tilde 10 thin$MeV, right after the collision of the shockwave with the plasma, since this corresponds to the centre-of-mass energy. This gives $T_"rh" tilde 5 thin$GeV, which implies $delta_"CP" tilde 1$. The final baryon number comes from the Boltzmann equation, with all three temperatures playing a rôle: $T_"eff"$ for baryon-number violation, $T_"rh"$ for CP-violation and $T_"pl"$ for baryon washout~@Garcia-Bellido:2019vlf. The production of baryons can therefore be very efficient, giving $eta tilde 1$ locally. Note that PBH formation at a higher temperature transition would result in a smaller value of $delta_"CP"$, which is why the QCD transition is optimal. Since the temperature at the QCD epoch is close to the proton mass $m_(upright(p))$, the ratio of the photon and baryon densities, $n_gamma thin T / n_(upright(b)) #h(0em) m_(upright(p))$, is just of order the photon-to-baryon ratio $S tilde eta^(- 1)$, so this proposal naturally links the BAU to the PBH collapse fraction ($eta tilde beta$). The observed ratio of the dark matter and baryon densities is also explained provided $gamma approx 0.8$.


The spectator-field mechanism for PBH production from curvature fluctuations~@2017PhRvD..96f3507C also avoids the need for a fine-tuned peak in the power spectrum, which has long been considered a major drawback of PBH scenarios. One still needs fine-tuning of the mean field value to produce the observed values of $eta$ and $beta$, which are both around $10^(- 9)$. However, the stochasticity of the field during inflation ensures that Hubble volumes exist with all possible field values and one can explain the fine-tuning by invoking a single anthropic constraint on the value of $eta$. In this scenario, the curvature fluctuations at the origin of PBH formation are seeded after inflation when the field transiently dominates the energy density of the Universe. One attractive feature is that the primordial power spectrum could remain small on all scales, as in standard slow-roll inflation, because the curvature fluctuations are generated by non-Gaussian tails in the curvature fluctuation statistics. The scenario is discussed in Ref.~@Carr:2019hud and depends on the fact that only a small fraction of patches will have the PBH and baryon abundance required for galaxies to form. Here we can briefly review the possibilities proposed to solve the fine-tuning issue of the PBH abundance.


// [figvision-cn] imgs/Figure_40.png
// 这是一张示意图，展示早期宇宙中三个连续物理过程。图面左
// 侧是主体结构，右侧延伸至远处。 主体结构由内向外分为三
// 层。中心是一个黑色实心圆，标注文字为 PBH（原初黑洞）。
// PBH 外围有一圈极细的黑色实线圆，再向外是一层较宽的亮红
// 色（带橙色）环形区域；红色环内均匀分布着灰色小圆点，从
// PBH 向外有多个黑色箭头沿径向指向红环边界，该红环边界标
// 注为 Hubble horizon（哈勃视界），其上方标有 ~10 km。在
// 红环外缘附近，标有一个橙色字母 A。最外层是暗棕红色（或
// 褐红色）的环形区域，宽度大于内层红环；该区域内同样散布
// 灰色小圆点，并有黑色箭头继续向外辐射。暗红环的外边界周
// 围有六个粗黑色箭头均匀向外指向，其中左下角的一个箭头旁
// 标注 shock wave（激波）。暗红环的右上方标有一个橙色字
// 母 B。 图中最外层右侧标注了一个蓝色字母 C，C 旁有两束
// 蓝色实线（构成一个极窄的圆锥），从暗红环右侧边缘向右延
// 伸，指向约 10 000 km 外的一个黑色实心圆，该黑色圆内标
// 注 PBH。在蓝色圆锥的起点处，右侧有黑色文字说明：jets
// producing > TeV collisions + parton showers（喷流产生
// > TeV 碰撞 + 部分子簇射）。 此外，从暗红环右下角有一条
// 蓝色虚线向右下方延伸，指向同一个远处的黑色 PBH，该蓝色
// 虚线上标有文字 streams（流）。从暗红环右侧偏下位置，有
// 一条蓝色虚线带着箭头指向中心的 PBH，蓝色虚线上标注文字
// U(1)_Y（表示超荷流）。 图面传达的总体趋势是：在哈勃视
// 界（~10 km）内发生引力坍缩形成 PBH，并在其周围热斑中发
// 生 sphaleron 跃迁（电弱重子生成），随后重子通过喷流（>
// TeV 碰撞和部分子簇射）和流传播到远处，最终产生观测到的
// 重子不对称（BAU）。黑色箭头表示 Shock wave 向外传播；
// 中心的 PBH 通过蓝色虚线箭头（U(1)_Y）吸收或交换荷。
#figure(placement: top, image("imgs/Figure_40.png", width: 100%),
  caption: [
    Qualitative representation of the three steps in the discussed scenario: gravitational collapse of the curvature fluctuation at horizon re-entry; sphaleron transition in hot spot around the PBH, producing $eta tilde cal(O) ( 1 )$ locally through electroweak baryogenesis; propagation of baryons to rest of Universe through jets, resulting in the observed BAU with $eta tilde 10^(- 9)$. From Ref.~@Garcia-Bellido:2019vlf.
  ]
)
<fig:BAU>






= Conclusions
<sec:Conclusions>


Previous literature has usually focussed on PBH #emph[constraints], identifying the mass ranges in which their density could be large enough to have interesting cosmological consequences but without providing positive evidence that this is the case. In this paper we have taken the opposite approach, identifying the observational data which specifically support the PBH proposal. In this sense, we are following the lead of the #emph[positivist] philosophers of the early 20th century.


What is striking is the large number of strands of evidence for PBHs which we have described in this paper. We have mentioned numerous arguments. One may argue about the strength of any particular strand, be it on observational or theoretical grounds, but the collective impact seems very strong --- like a rope whose strength far surpasses that of any individual fibre. We have also considered observations which could #emph[potentially] be explained by PBHs, even though there are other explanations here and the evidence is less secure. Of course, the division between weak and strong evidence is not clear-cut and amounts to merely selecting a confidence level.


As regards the dark matter problem, it is interesting that much of the evidence point towards dark matter in PBHs with around a solar mass, this also corresponding to the peak of the mass function of ordinary stars, both being close to the Chandrasekhar mass. This coincidence is naturally explained if PBHs form at the QCD epoch and this is our preferred scenario. Other PBH advocates have claimed that this is precluded and favour a scenario in which the dark matter comprises PBHs in the planetary mass range. Although this alternative scenario is certainly not excluded, our justification for emphasising our own favoured scenario is that there is currently no #emph[positive] evidence for it.


As regards the GW events, we have argued that the black holes which dominate the LIGO/Virgo/ KAGRA detections can only provide a small fraction of the dark matter but this is expected if PBHs have an extended mass function since the GW events inevitably peak at a higher mass than the density. The #emph[natural] proximity of the PBH and stellar masses might be regarded as unfortunate from the perspective of distinguishing between astrophysical and primordial sources. However, other characteristics (such as spin) may remove this degeneracy. In any case, it seems most likely that one has a combination of the two, with evidence for at least some primordial component coming from observations of black holes in the two mass gaps in which stellar remnants are not expected.


As regards seeding the SMBHs in galactic nuclei our favoured scenario predicts that there should be at least some PBHs large enough to seed the SMBHs. However, the evidence for this is certainly not definitive, the primary uncertainty being the amount of growth of the seeds as a result of accretion. Since most of the final SMBH mass may derive from accretion at late times (i.e.~from ordinary baryonic material), we emphasise that the SMBHs are merely seeded by PBHs. Although we have not discussed them much here, there could even be a population of stupendously large black holes (i.e.~larger than $10^12 thin M_⊙$) of primordial origin, although again most of their mass might come from baryonic accretion.


An important aspect of our approach is that it is very broadly based, being #emph[multi-production-mode] (invoking different PBH formation mechanisms), #emph[multi-epoch] (the relevant data coming from many different redshifts), #emph[multi-scale] (the predicted PBH mass function having bumps on several different scales) and #emph[multi-probe] (invoking many types of observational evidence). The last point implies that several new or impending telescopes (such as the LSST, #emph[Einstein Telescope], SKA, LOFAR or JWST) may be brought to bear on the PBH proposal.


#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>
S.C.~acknowledges support from the Belgian Francqui Foundation through a start-up grant and the Belgian fund for research F.R.S.-FNRS through a #emph[Mandat d'impulsion scientifique]. J.G.-B.~acknowledges support from the Spanish Research Project PID2021-123012NB-C43 \[MICINN-FEDER\] and the Centro de Excelencia Severo Ochoa Program CEX2020-001007-S at IFT. It is a pleasure to thank Anne Green, Jim Rich and Will Sutherland for elucidating remarks on the MACHO and EROS microlensing surveys, Gianfranco Bertone for an initial discussion on the missing-pulsar problem, Michael Brockamp for simulating remarks on cryogenic bulk acoustic wave cavity measurements, Dominik Schwarz for sharing his insights into the apparent Hubble tension, and Günther Hasinger for multiple insights and discussions on the rôle of PBHs for early structure formation. We also acknowledge stimulating discussions with Earl Bellinger, Matthew Caplan and Selma de Mink on various aspects of PBHs and valuable insights from the referee. Finally, we would like to thank our collaborators in previous PBH studies since they have all indirectly contributed to this review: Nancy Aggarwal, Yacine Ali-Haïmoud, Richard Arendt, Eleni Bagui, Gregory Baltus, Sofiane Boucenna, Chris Byrnes, Francesca Calore, Nico Cappelluti, Sarah Caudill, Federico De Lillo, Valerio De Luca, Antoine Depasse, Kontantinos Dimopoulos, Gia Dvali, Albert Escrivà, Jose Ezquiaga, Gaétan Facchinetti, Maxime Fays, Pierre Fleury, Heather Fong, Gabriele Franciolini, André Füzfa, Katie Freese, Jonathan Gilbert, Ariel Goobar, Tomohiro Harada, Nicolas Herman, Mark Hindmarsh, Rajeev Jain, Alexander Jenkins, Cristian Joana, Shasvath Kapadia, Christos Karathanasis, Alexander Kashlinsky, Kazunori Kohri, Sachiko Kuroyanagi, Léonard Lehoucq, Jim Lidsey, Matteo Lucca, Jane MacGibbon, Kei-ichi Maeda, Ryan Magee, Mario Martínez, Katarina Martinovic, Alexis Menéndez-Vázquez, Andrew Miller, Ester Ruiz Morales, Gonzalo Morrás, Ilia Musco, Savvas Nesseris, Tommy Ohlsson, Charlotte Owen, Don Page, Theodoros Papanikolaou, Marco Peloso, Khun Phukon, Sasha Polnarev, Vivian Poulin, Alvise Raccanelli, Martti Raidal, Sebastien Renaux-Petel, Antonio Riotto, Maria Sakellariadou, Ziad Sakr, Marit Sandstad, Marco Scalisi, Yuuiti Sendouda, Olga Sergijenko, Pasquale Serpico, José Francisco Nuño Siles, Joe Silk, Ioanna Stamou, Yuichiro Tada, Tomi Tenkanen, Jesus Torrado, Caner Unal, Ville Vaskonen, Hardi Veermäe, Vincent Vennin, Luca Visinelli, David Wands, Łukasz Wyrzykowski, Jun'ichi Yokoyama, Sam Young and Michael Zantedeschi.


#heading(level: 1, numbering: none)[Acronyms]
<acronyms>


#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (left,left,),
    table.hline(stroke: 0.8pt),
    [ARCADE], [#strong[A]bsolute #strong[R]adiometer for #strong[C]osmology, #strong[A]strophysics and #strong[D]iffuse #strong[E]mission],
    table.hline(stroke: 0.5pt),
    [ALMA], [#strong[A]tacama #strong[L]arge #strong[M]illimeter/submillimeter #strong[A]rray],
    [BAU], [#strong[b]aryon #strong[a]symmetry of the #strong[U]niverse],
    [BATSE], [#strong[B]urst #strong[A]nd #strong[T]ransient #strong[S]ource #strong[E]xperiment],
    [BBN], [#strong[b]ig #strong[b]ang #strong[n]ucleosynthesis],
    [CDM], [#strong[c]old #strong[d]ark #strong[m]atter],
    [CL], [#strong[c]onfidence #strong[l]evel],
    [CMB], [#strong[c]osmic #strong[m]icrowave #strong[b]ackground],
    [DESI], [#strong[D]ark #strong[E]nergy #strong[S]pectroscopic #strong[I]nstrument],
    [EGRET], [#strong[E]nergetic #strong[G]amma #strong[R]ay #strong[E]xperiment #strong[T]elescope],
    [EPTA], [#strong[E]uropean #strong[P]ulsar #strong[T]iming #strong[A]rray],
    [EROS], [#strong[E]xpérience pour la #strong[R]echerche d'#strong[O]bjets #strong[S]ombres],
    [FAR], [#strong[f]alse #strong[a]larm #strong[r]ate],
    [FRB], [#strong[f]ast #strong[r]adio #strong[b]urst],
    [GW], [#strong[g]ravitational #strong[w]ave],
    [GWTC], [#strong[G]ravitational-#strong[W]ave #strong[T]ransient #strong[C]atalog],
    [HSC], [#strong[H]yper #strong[S]uprime-#strong[C]amera],
    [HST], [#strong[H]ubble #strong[S]pace #strong[T]elescope],
    [IMBH], [#strong[i]ntermediate #strong[m]ass #strong[b]lack #strong[h]ole],
    [IPTA], [#strong[I]nternational #strong[P]ulsar #strong[T]iming #strong[A]rray],
    [ISCO], [#strong[i]nnermost #strong[s]table #strong[c]ircular #strong[o]rbit],
    [JWST], [#strong[J]ames #strong[W]ebb #strong[S]pace #strong[T]elescope],
    [KAGRA], [#strong[Ka]mioka #strong[Gra]vitational-Wave Detector],
    [LIGO], [#strong[L]aser #strong[I]nterferometer #strong[G]ravitational-Wave #strong[O]bservatory],
    [LISA], [#strong[L]aser #strong[I]nterferometer #strong[S]pace #strong[A]ntenna],
    [LOFAR], [#strong[Lo]w #strong[F]requency #strong[Ar]ray],
    [LVK], [#strong[L]IGO/#strong[V]irgo/#strong[K]AGRA],
    [LSS], [#strong[l]arge-#strong[s]cale #strong[s]tructure],
    [LSST], [#strong[L]arge #strong[S]ynoptic #strong[S]urvey #strong[T]elescope],
    [LWA1], [#strong[L]ong #strong[W]avelength #strong[A]rray (#strong[1]st station)],
    table.hline(stroke: 0.8pt),
  )]
  , kind: table
  )





#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (left,left,),
    table.hline(stroke: 0.8pt),
    [MACHO], [#strong[Ma]ssive #strong[C]ompact #strong[H]alo #strong[O]bject],
    table.hline(stroke: 0.5pt),
    [NANOGrav], [#strong[N]orth #strong[A]merican #strong[N]anohertz #strong[O]bservatory for #strong[Grav]itational Waves],
    [NFW], [#strong[N]avarro-#strong[F]renk-#strong[W]hite],
    [OGLE], [#strong[O]ptical #strong[G]ravitational #strong[L]ensing #strong[E]xperiment],
    [PBH], [#strong[p]rimordial #strong[b]lack #strong[h]ole],
    [POINT-AGAPE], [#strong[P]ixel-lensing #strong[O]bservations with the #strong[I]saac #strong[N]ewton #strong[T]elescope],
    [], [-- #strong[A]ndromeda #strong[G]alaxy #strong[A]mplified #strong[P]ixels #strong[E]xperiment],
    [QCD], [#strong[q]uantum #strong[c]hromo #strong[d]ynamics],
    [SKA], [#strong[S]quare #strong[K]ilometer #strong[A]rray],
    [SMBH], [#strong[s]uper#strong[m]assive #strong[b]lack #strong[h]ole],
    [SNR], [#strong[s]ignal-to-#strong[n]oise #strong[r]atio],
    [SLAB], [#strong[s]tupendously #strong[l]arge #strong[b]lack #strong[h]ole],
    [SSM], [#strong[s]ub-#strong[s]olar #strong[m]ass],
    [UFDG], [#strong[u]ltra-#strong[f]aint #strong[d]warf #strong[g]alaxy],
    [VRO], [#strong[V]era #strong[R]ubin #strong[O]bservatory],
    [WIMP], [#strong[w]eakly #strong[i]nteracting #strong[m]assive #strong[p]article],
    [ZTF], [#strong[Z]wicky #strong[T]ransient #strong[F]acility],
    table.hline(stroke: 0.8pt),
  )]
  , kind: table
  )

#[
  #set par(spacing: 14.5pt)
  #show bibliography: set text(9pt)
  #bibliography("refs.bib", style: "apsrev.csl", title: none)
]

