#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.94cm, bottom: 2.43cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.62em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.46em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set figure(placement: top, scope: "parent")
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [(#context counter(math.equation).at(e.location()).first())]
  } else { it }
}


#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [What is the source of the PTA GW signal?])   #v(1.2em)
    #text(10.5pt)[John Ellis#super[1], Malcolm Fairbairn#super[2], Gabriele Franciolini#super[4], Gert Hütsi#super[1], Antonio Iovino #super[4], Marek Lewicki#super[6], Martti Raidal#super[1], Juan Urrutia#super[1], Ville Vaskonen#super[1], Hardi Veermäe#super[1]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Keemilise ja Bioloogilise Füüsika Instituut, Rävala pst. 10, 10143 Tallinn, Estonia] \
    #text(9pt)[#super[2] Physics Department, King’s College London, Strand, London, WC2R 2LS, United Kingdom] \
    #text(9pt)[#super[3] Theoretical Physics Department, CERN, CH 1211 Geneva, Switzerland] \
    #text(9pt)[#super[4] Dipartimento di Fisica, “Sapienza” Università di Roma, Piazzale Aldo Moro 5, 00185, Roma, Italy] \
    #text(9pt)[#super[5] INFN sezione di Roma, Piazzale Aldo Moro 5, 00185, Roma, Italy] \
    #text(9pt)[#super[6] Faculty of Physics, University of Warsaw ul. Pasteura 5, 02-093 Warsaw, Poland] \
    #text(9pt)[#super[7] Departament of Cybernetics, Tallinn University of Technology, Akadeemia tee 21, 12618 Tallinn, Estonia] \
    #text(9pt)[#super[8] Dipartimento di Fisica e Astronomia, Università degli Studi di Padova, Via Marzolo 8, 35131 Padova, Italy] \
    #text(9pt)[#super[9] INFN sezione di Padova, Via Marzolo 8, 35131 Padova, Italy] \
  ]
  #v(1.2em)






























  The most conservative interpretation of the nHz stochastic gravitational wave background (SGWB) discovered by NANOGrav and other Pulsar Timing Array (PTA) Collaborations is astrophysical, namely that it originates from supermassive black hole (SMBH) binaries. However, alternative cosmological models have been proposed, including cosmic strings, phase transitions, domain walls, primordial fluctuations and “audible” axions. We perform a multi-model analysis (MMA) to compare how well these different hypotheses fit the NANOGrav data, both in isolation and in combination with SMBH binaries, and address the questions: Which interpretations fit the data best, and which are disfavoured? We also discuss experimental signatures that can help discriminate between different sources of the PTA GW signal, including fluctuations in the signal strength between frequency bins, individual sources, and how the PTA signal extends to higher frequencies. \
  ~~ \
  KCL-PH-TH/2023-43, CERN-TH-2023-153, AION-REPORT/2023-08
]





= INTRODUCTION
<introduction>


The Pulsar Timing Array (PTA) collaborations NANOGrav~@NANOGrav:2023gor @NANOGrav:2023hde, EPTA (in combination with InPTA) @EPTA:2023fyk @EPTA:2023sfo @EPTA:2023xxk, PPTA @Reardon:2023gzh @Zic:2023gta @Reardon:2023zen and CPTA @Xu:2023wog have recently announced the discovery of a stochastic gravitational wave background (SGWB) at frequencies in the nHz range, with a strength and frequency dependence similar to that expected from a population of supermassive black holes (SMBH) binary systems. This discovery opens new perspectives in the studies of GW sources, complementing the mergers of stellar-mass black holes discovered by the LIGO-Virgo-KAGRA collaborations~@LIGOScientific:2018mvr @LIGOScientific:2020ibl @LIGOScientific:2021djp. Measurements of the nHz SGWB are at an early stage, and it is important to verify to what extent it is consistent with the SMBH binary model. Indeed, the first measurements seem to indicate that the frequency dependence of the SGWB observed by the PTAs may differ somewhat from that predicted in the simplest version of the SMBH binary model, according to which the binaries evolve by losing energy primarily through GW emission@NANOGrav:2023hfp @EPTA:2023xxk.


Two classes of interpretation of this apparent discrepancy have been proposed. One is that the SMBH binaries may also be losing energy through some other mechanism, presumably through interactions with their environments, that would reduce the period over which they emit GWs in the frequency range measured @NANOGrav:2023hfp @Ellis:2023dgf @Ghoshal:2023fhh @Shen:2023pan @Broadhurst:2023tus @Bi:2023tib @Zhang:2023lzt. A more radical interpretation is that the GWs are being emitted by some cosmological source whose origin is in fundamental physics. Candidate sources that have been considered include a network of cosmic (super)strings @Ellis:2023tsl @Kitajima:2023vre @Wang:2023len @Lazarides:2023ksx @Eichhorn:2023gat @Chowdhury:2023opo @Servant:2023mwt @Antusch:2023zjk @Yamada:2023thl @Ge:2023rce @Basilakos:2023xof, a first-order phase transition in the early Universe @Fujikura:2023lkn @Addazi:2023jvg @Bai:2023cqj @Megias:2023kiy @Han:2023olf @Zu:2023olm @Ghosh:2023aum @Xiao:2023dbb @Li:2023bxy @DiBari:2023upq @Cruz:2023lnq @Gouttenoire:2023bqy @Ahmadvand:2023lpp @An:2023jxf @Wang:2023bbc, domain walls @Kitajima:2023cek @Guo:2023hyp @Blasi:2023sej @Gouttenoire:2023ftk @Barman:2023fad @Lu:2023mcz @Li:2023tdx @Du:2023qvj @Babichev:2023pbf @Gelmini:2023kvo @Zhang:2023nrs, primordial fluctuations @Franciolini:2023pbf @Vagnozzi:2023lwo @Franciolini:2023wjm @Inomata:2023zup @Cai:2023dls @Wang:2023ost @Ebadi:2023xhq @Gouttenoire:2023nzr @Liu:2023ymk @Abe:2023yrw @Unal:2023srk @Yi:2023mbm @Firouzjahi:2023lzg @Salvio:2023ynn @You:2023rmn @Bari:2023rcw @Ye:2023xyr @HosseiniMansoori:2023mqh @Cheung:2023ihl @Balaji:2023ehk @Jin:2023wri @Bousder:2023ida @Das:2023nmm @Zhao:2023joc @Ben-Dayan:2023lwd @Jiang:2023gfe @Liu:2023pau @Yi:2023tdk @Frosina:2023nxu @Bhaumik:2023wmw @Yuan:2023ofl @Gorji:2023sil,“audible” axions @Figueroa:2023zhu @Geller:2023shn and other more exotic scenarios @Depta:2023qst @Yang:2023aak @Li:2023yaj @Lambiase:2023pxd @Borah:2023sbc @Datta:2023vbs @Murai:2023gkv @Niu:2023bsr @Choudhury:2023kam @Cannizzaro:2023mgc @Zhu:2023lbf @Aghaie:2023lan @He:2023ado. If any such mechanism is in operation, one may expect there also to be an admixture of GWs from astrophysical SMBH binaries.~#footnote[See, for example,~@Bian:2023dnv @Figueroa:2023zhu @Wu:2023hsa]


In this paper, we perform a Multi-Model Analysis (MMA), comparing the qualities of fits to the NANOGrav 15-year (NG15) data invoking SMBH binaries, driven either by GWs alone or together with environmental effects, with each of the proposed fundamental physics sources. We also explore fits postulating combinations of SMBH binaries with each of the fundamental physics mechanisms. Our MMA adopts a common statistical approach to all the proposed sources based directly upon the NANOGrav probability density function (PDF) in each frequency bin. Furthermore, in order to help disentangle cosmological and astrophysical sources, we highlight some experimental features that could in the future be used to distinguish between them. These include fluctuations in the GW signal between different frequency bins (including the possible observation of individual GW sources) and the behavior of the SGWB spectrum at higher frequencies. For example, whereas SMBH models predict observable fluctuations that increase at higher frequencies, generic fundamental physics sources would not predict large bin-by-bin fluctuations, and some predict an extended spectrum that would be detectable at higher frequencies, whereas others predict a sharp fall-off above the range where PTAs are sensitive.


The structure of this paper is as follows. In @sec:SMBH we introduce the astrophysical SMBH binary model, including the possibility of energy loss through environmental effects, and discuss the observability of bin-to-bin fluctuations and individual binary sources. Then, in @sec:cosmo we introduce the different cosmological models we consider, based on fundamental physics scenarios, and present likelihood contours for each of the scenarios with and without a SMBH binary background, taking into account other relevant observational constraints. In @sec:comp we compare the qualities of the fits within the various model scenarios, and we conclude in @sec:concl. Some technical details are gathered in the appendix.


= SUPERMASSIVE BLACK HOLES
<sec:SMBH>


The default interpretation of the SGWB postulates a population of tight astrophysical SMBH binaries. We estimate the SMBH binary population as in @Ellis:2023dgf: We use the extended Press-Schechter formalism~@Press:1973iz @Bond:1990iw @Lacey:1993iv, which depends on the rate $R_h$ of coalescences of galactic halos of masses $M_(1 , 2)$, the stellar mass-BH mass relation arising from observations of inactive galaxies~@Kormendy:2013dxa @2015ApJ...813...82R and the observed stellar mass-halo mass relation~@Girelli:2020goz. The merger rate of SMBHs of masses $m_(1 , 2)$ is $
  (dif R_("BH")) / (dif m_1 dif m_2) approx & p_("BH") integral dif M_1 dif M_2 (dif R_h) / (dif M_1 dif M_2) \
  & times p_("occ")(m_1 | M_1, z) p_("occ")(m_2 | M_2, z) ,
$ where we incorporate a probability $p_(upright("BH"))$ for the pair of SMBHs to approach each other sufficiently closely to merge~@Ellis:2023owy and $p_(upright("occ"))$ relates the BH mass to the halo mass including the observed scatter~@Ellis:2023dgf. The interactions with their environments that allow the binaries to overcome the “final parsec problem” are not fully understood~@Begelman:1980vb, and we regard $p_(upright("BH"))$ as a phenomenological parameter to be determined using the PTA data. For simplicity, we assume $p_(upright("BH"))$ to be constant.


== GW-driven binaries
<gw-driven-binaries>


The spectrum of the GW signal from the SMBH population in general includes large fluctuations due to the small number of dominant and deviates from the naive power-law approximation that predicts~@Phinney:2001di the spectral index $gamma = 13 / 3$. Following the analysis of Ref.~@Ellis:2023dgf, we compute the PDFs of the GW signal from SMBH binaries in the frequency bins used in the NG15 analysis and calculate their overlaps with the posterior PDFs (“violins”) from the Hellings--Downs-correlated free spectrum analysis of the NG15 data~@NANOGrav:2023gor. Assuming that the evolution of the SMBH binaries is driven solely by energy loss due to GW emission, we find $p_(upright("BH")) = 0.07_(- 0.07)^(+ 0.05)$, which is consistent with an earlier analysis of IPTA data~@Ellis:2023owy, but the quality of the best fit is poor.


// [figvision-cn] imgs/Pos_SMBH.png
// 这是一张 3×3 的参数后验概率分布三角图（corner plot），
// 用于展示超大质量双黑洞（SMBH binary）模型在引入环境效
// 应后对 NG15 数据拟合的后验概率分布。图中涉及三个参数：
// pBH、α 和 fref。整张图由 6 个子图组成，包括 3 个对角线
// 的 1D 边缘概率分布直方图和 3 个非对角线的 2D 联合概率
// 分布等高线图。所有子图共用相同的黄绿色调，其中 1D 直方
// 图用实线阶梯表示，虚线表示 95% 置信区间（CL）的边界；
// 2D 等高线图用三种不同深浅的黄色填充区域分别表示 50%、
// 90% 和 95% 的置信区间。 第 1 行第 1 列（左上角）是对角
// 线子图，展示参数 pBH 的 1D 边缘概率分布。横轴为 pBH，
// 范围约为 0 到 0.9，主要刻度为 0.2、0.4、0.6、0.8；纵轴
// 为概率密度（未标注具体刻度）。图中用黄绿色阶梯曲线显示
// 后验概率密度，峰值位于 pBH ≈ 0.5 附近，曲线在 0.4 到
// 0.6 之间较为平缓，向两侧下降。两条黄绿色垂直虚线分别位
// 于 pBH ≈ 0.28 和 pBH ≈ 0.78 处，包围的区域为 95% 置信
// 区间。子图顶部标注文字为“[0.28, 0.78]”，表示该参数的
// 95% 置信区间范围。该图表明 pBH 的后验分布较宽，中心值
// 约为 0.5。 第 1 行第 2 列（中上）是对角线子图，展示参
// 数 α 的 1D 边缘概率分布。横轴为 α，范围约为 0 到 6.5，
// 主要刻度为 1.5、3.0、4.5、6.0；纵轴为概率密度。黄绿色
// 阶梯曲线显示后验概率密度在 α ≈ 1.5 附近达到峰值，随后
// 向高值方向迅速下降，在 α ≈ 3.0 到 4.0 之间形成较长尾部。
// 两条垂直虚线分别位于 α ≈ 1.4 和 α ≈ 3.6 处。子图顶部标
// 注文字为“[1.4, 3.6]”，表示 α 的 95% 置信区间。该图表明
// α 的后验分布偏向低值，中心值约为 2.0。 第 1 行第 3 列
// （右上）是对角线子图，展示参数 fref 的 1D 边缘概率分布。
// 横轴为 fref/nHz，范围约为 0 到 40，主要刻度为 8、16、
// 24、32；纵轴为概率密度。黄绿色阶梯曲线显示后验概率密度
// 在 fref ≈ 15 nHz 附近达到峰值，分布较宽，向高值方向有
// 较长尾部。两条垂直虚线分别位于 fref ≈ 12 nHz 和 fref ≈
// 29 nHz 处。子图顶部标注文字为“[12, 29]”，表示 fref 的
// 95% 置信区间。该图表明 fref 的后验分布较宽，中心值约为
// 15 nHz。 第 2 行第 1 列（中左）是非对角线子图，展示
// pBH 与 α 的 2D 联合概率分布。横轴为 pBH，范围约为 0 到
// 0.9，刻度为 0.2、0.4、0.6、0.8；纵轴为 α，范围约为 0
// 到 6.5，刻度为 1.5、3.0、4.5、6.0。图中用三种深浅不同
// 的黄色填充区域表示置信区间：最浅的黄色区域为 95% 置信
// 区间，中等黄色为 90%，最深的黄色为 50%。等高线形状显示
// pBH 与 α 之间存在弱负相关趋势：当 pBH 增大时，α 的允许
// 范围略微向低值偏移。50% 置信区间大致位于 pBH ≈ 0.3 到
// 0.7、α ≈ 1.0 到 3.5 的区域。该图表明两个参数之间没有强
// 烈的线性相关。 第 2 行第 2 列（中中）是非对角线子图，
// 展示 α 与 fref 的 2D 联合概率分布。横轴为 α，范围约为
// 0 到 6.5，刻度为 1.5、3.0、4.5、6.0；纵轴为 fref/nHz，
// 范围约为 0 到 40，刻度为 8、16、24、32。等高线形状显示
// α 与 fref 之间存在明显的负相关趋势：当 α 增大时，fref
// 的允许范围向低值偏移。50% 置信区间大致位于 α ≈ 1.0 到
// 2.5、fref ≈ 10 到 25 nHz 的区域。该图表明两个参数之间
// 存在较强的相关性。 第 2 行第 3 列（中右）是非对角线子
// 图，展示 pBH 与 fref 的 2D 联合概率分布。横轴为 pBH，
// 范围约为 0 到 0.9，刻度为 0.2、0.4、0.6、0.8；纵轴为
// fref/nHz，范围约为 0 到 40，刻度为 8、16、24、32。等高
// 线形状显示 pBH 与 fref 之间存在弱正相关趋势：当 pBH 增
// 大时，fref 的允许范围略微向高值偏移。50% 置信区间大致
// 位于 pBH ≈ 0.3 到 0.7、fref ≈ 10 到 25 nHz 的区域。该
// 图表明两个参数之间相关性较弱。 第 3 行第 1 列（左下）
// 是非对角线子图，展示 pBH 与 fref 的另一种视角的 2D 联
// 合概率分布，实际上与第 2 行第 3 列相同，但坐标轴交换。
// 横轴为 pBH，纵轴为 fref/nHz。等高线形状和置信区间与第
// 2 行第 3 列一致，显示弱正相关趋势。 第 3 行第 2 列（中
// 下）是非对角线子图，展示 α 与 fref 的另一种视角的 2D
// 联合概率分布，实际上与第 2 行第 2 列相同，但坐标轴交换。
// 横轴为 α，纵轴为 fref/nHz。等高线形状和置信区间与第 2
// 行第 2 列一致，显示明显的负相关趋势。 第 3 行第 3 列（
// 右下）是对角线子图，展示 fref 的 1D 边缘概率分布，实际
// 上与第 1 行第 3 列相同，但纵轴刻度未标注。横轴为 fref/
// nHz，范围约为 0 到 40，刻度为 8、16、24、32。黄绿色阶
// 梯曲线显示后验概率密度在 fref ≈ 15 nHz 附近达到峰值，
// 分布较宽，向高值方向有较长尾部。两条垂直虚线分别位于
// fref ≈ 12 nHz 和 fref ≈ 29 nHz 处。子图顶部标注文字为“
// [12, 29]”，表示 fref 的 95% 置信区间。该图表明 fref 的
// 后验分布较宽，中心值约为 15 nHz。 总体而言，该图展示了
// SMBH 双星模型参数 pBH、α 和 fref 的后验概率分布及其相
// 关性。pBH 的后验分布较宽，中心值约为 0.5，95% 置信区间
// 为 [0.28, 0.78]；α 的后验分布偏向低值，中心值约为 2.0，
// 95% 置信区间为 [1.4, 3.6]；fref 的后验分布较宽，中心值
// 约为 15 nHz，95% 置信区间为 [12, 29] nHz。参数之间，α
// 与 fref 存在明显的负相关，pBH 与 α 存在弱负相关，pBH
// 与 fref 存在弱正相关。这些结果反映了模型对 NG15 数据的
// 拟合约束。
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

#figure(image("imgs/Pos_SMBH.png", width: 100%),
  caption: [
    The posterior probability distribution of the fit of the SMBH binary model with environmental effects to the NG15 data. The contours enclose the $1 sigma$, $2 sigma$, and $3 sigma$ CL regions. On top of each column, we report $1 sigma$ CL ranges.
  ]
)
<fig:SMBH_posteriors>



== Environmental effects
<environmental-effects>


It is natural to consider the possibility that environmental effects could affect the evolution of SMBH binaries while they are emitting GWs in the nHz frequency range. We parametrize the binary energy loss via environmental effects as~@Ellis:2023dgf $ t_(upright("env")) / t_(upright("GW")) = (f_r / f_(upright("GW")))^alpha , quad f_(upright("GW")) = f_(upright("ref")) (frac(cal(M), 10^9 M_⊙))^(- beta) , $<eq:gas> where $t_(upright("env"))$ and $t_(upright("GW"))$ are the timescales for energy loss via environmental effects and GWs, respectively, $f_(upright("ref"))$ is a reference frequency, $cal(M)$ is the binary chirp mass, and $alpha$ and $beta$ are phenomenological parameters. We take $beta = 0.4$~#footnote[Our results are not sensitive to this choice: see~@Ellis:2023dgf.] and treat $p_(upright("BH")) , alpha$ and $f_(upright("ref"))$ as parameters to be constrained using PTA data. This three-parameter model provides a significantly better fit to the NG15 data than the single-parameter GW-only model, with $- 2 Delta ell = - 11.3$ relative to the GW-driven SMBH model.#footnote[We estimate the log-likelihood for observing the data $arrow(d)$ given a model characterised by $arrow(theta)$ by $ ell ( arrow(d) \| arrow(theta) ) = sum_j ln integral upright(d) Omega P_(upright("ex") , j) ( Omega \| arrow(d) ) P_(upright("th") , j) ( Omega \| arrow(theta) ) thin , $ where the sum runs over the first 14 NG15 bins and $P_(upright("ex") , j)$ and $P_(upright("th") , j)$ denote the probability distributions of $Omega$ in bin $j$ in the NG15 data and in the given model.] The posterior probabilities for the three parameters, computed in Ref.~@Ellis:2023dgf, are shown in @fig:SMBH_posteriors. The best fit is at $ p_(upright("BH")) = 0.84 , quad alpha = 2.0 , quad f_(upright("ref")) = 34 thin upright("nHz") thin . $ Throughout the rest of the paper, this best-fit environmentally driven SMBH scenario sets the baseline to which other models are compared.


We note that our analysis assumes circular orbits that emit GWs at twice the orbital frequency. The eccentricity of the orbits would affect the GW spectrum by introducing higher harmonics, increasing the total power emitted in GWs and modifying the frequency spectral index~@Enoki:2006kj.#footnote[There is no indication of eccentric binaries in current (O3) LIGO/Virgo/KAGRA (LVK) data~@LIGOScientific:2023lpe.] However, big eccentricities $e > 0.9$ would lead to an attenuation of the background due to the acceleration of the binary inspiral~@Kelley:2017lek. The GW signal from SMBHs could also be affected by modifications to small-scale structures compared to standard $Lambda$CDM, which could lead to the earlier formation of galaxies and SMBHs. The observation of high-redshift galaxies with surprisingly high stellar masses by the JWST~@2022arXiv220802794N @2022ApJ...940L..55F @2023Natur.616..266L @2023ApJS..265....5H @2023arXiv230406658H provides a potential hint for this possibility~@Liu:2022bvr @Menci:2022wia @Biagetti:2022ode @Hutsi:2022fzw @Parashari:2023cui @Hassan:2023asd @Gouttenoire:2023nzr @Guo:2023hyp.


// [figvision-cn] imgs/Pfluct.png
// 该图为单幅折线图，无子图划分。横轴标注为 f/nHz，表示频
// 率，单位为纳赫兹，刻度范围从约3到26，主刻度标注为5、10、
// 15、20、25，两端为圆点终止；纵轴标注为 P，表示概率，未
// 给出单位，刻度范围从0.0到1.0，主刻度间隔0.2，次刻度间
// 隔0.05。图中包含两条折线：橙色实线对应图例“NG15”，代表
// NG15数据中测得的涨落概率；黄绿色实线对应图例“SMBH”，代
// 表考虑环境效应的SMBH模型中向上涨落的概率。所有线条均为
// 实线，无数据点标记。橙色NG15曲线在低频段约3-10 nHz变化
// 平缓，数值约0.31-0.34；至约12 nHz后急剧下降，在约14
// nHz达到谷值约0.06；随后陡升至约16 nHz处形成峰值约0.87；
// 再急剧下降至约18 nHz处达到最低点约0.02；之后回升，在约
// 22 nHz处形成次级峰约0.40，最后在约26 nHz降至约0.27。黄
// 绿色SMBH曲线整体变化平缓，在约3 nHz处起始值约0.14，快
// 速上升至约6 nHz处约0.27，之后缓慢上升并略有波动，在约
// 14 nHz处约0.28，随后维持在约0.31-0.32，至约26 nHz处约
// 0.32。图中传达的趋势是：NG15数据测得的向上涨落概率随频
// 率变化剧烈，在约14、18和22 nHz处出现显著的谷值和峰值；
// 而SMBH模型预测的向上涨落概率随频率变化平缓，整体在
// 0.14-0.32之间，在约5 nHz以上基本稳定在0.27-0.32。
#figure(image("imgs/Pfluct.png", width: 75%),
  caption: [
    The probability~@eq:Pfluct for upward fluctuations in the SMBH model with environmental effects (green line) and the fluctuations measured in the NG15 data (orange line).
  ]
)
<fig:Pfluct>



== Fluctuations in the GW spectrum
<fluctuations-in-the-gw-spectrum>


As already mentioned, the SMBH signal may exhibit significant fluctuations between frequency bins, which appear because around half of the signal strain is produced by $cal(O) ( 10 )$ sources. Since the spectral fluctuations in the SGWB for every cosmological BSM model are expected to be negligible, the appearance of fluctuations would be a smoking gun for an astrophysical component in the signal.


Spectral fluctuations can be quantified by the second finite difference $
Delta^2 Omega ( f ) & equiv Omega ( f + delta f ) + Omega ( f - delta f ) - 2 Omega ( f ) #h(0.17em)
$<eq:Delta2_Omega> where the step size $delta f$ can, for instance, be taken to correspond to the width of a bin. The probability of an upward fluctuation in the $i$th bin can be estimated as~#footnote[Neglecting correlations between bins, this probability is given by $
P ( - Delta^2 Omega ( f_i ) med Omega_(upright("th")) ) = & integral upright("d") Omega upright("d") Omega' P_(i + 1) ( Omega - Omega' ) P_(i - 1) ( Omega' )\
 & times integral_(2 Omega_i - Omega med Omega_(upright("th")) ( Omega f_i )) upright("d") Omega_i P_i ( Omega_i )
$ where $P_i$ denote the theoretical $Omega_(upright("GW"))$ distributions in individual bins (see~@Ellis:2023owy @Ellis:2023dgf).] $ P_(upright("fluct"), upright(i)) equiv P ( - Delta^2 Omega ( f_i ) > Omega_(upright("th")) ( f_i ) ) thin , $<eq:Pfluct> where $f_i$ is the bin frequency and we choose $ Omega_(upright("th")) ( f_i ) = iota [Omega ( f_(i - 1) ) + Omega ( f_(i + 1) )] thin , $ with $iota = 0.2$. This choice of threshold can help distinguish SMBH binaries from cosmological GW sources, which are expected to produce smooth spectra. We find that for all of the cosmological sources discussed in the next Section the probability~@eq:Pfluct is zero in all NG15 bins. When the GW signal arises from an admixture of cosmological sources and SMBH binaries the probability of fluctuations will be smaller than in the pure SMBH model. The optimal threshold $Omega_(upright("th"))$ that can filter out cosmological models depends on the frequency binning -- while for smooth cosmological signals, the finite difference @eq:Delta2_Omega decreases with increased spectral resolution (since $Delta^2 Omega ( f ) prop delta f^2$ as $delta f arrow.r 0$), it can be sizeable for SMBH binaries as long as their frequency changes less than $delta f$ during the observational period.


In @fig:Pfluct we show the probability~@eq:Pfluct for the best-fit parameters of the SMBH binary model with environmental effects. We find that $P approx 0.3$ across all the bins and the probability of not having fluctuations that exceed this threshold in any of the 11 bins considered in @fig:Pfluct is roughly $product P_(upright("fluct"), upright(i)) approx 1.3 "%"$, while the expected number of upward fluctuations in the NG15 bins is $sum_i P_(upright("fluct"), upright(i)) approx 4$ for both the NG15 data and the SMBH binary model. The NG15 data indicates that the 8th bin at $f approx 16 thin$nHz shows an upward fluctuation at the 91% CL.


// [figvision-cn] imgs/pmin.png
// 这是一张二维等值线图（相图），用于展示在不同环境效应参
// 数下，找到候选事件概率超过 5% 所需的最小合并效率的等值
// 线。图中横轴为参数 α（无单位，刻度范围从约 0.5 到 6，
// 主刻度标注为 1、2、3、4、5、6）。纵轴为 f_ref（单位
// nHz，主刻度标注为 5、10、15、20、25、30、35、40）。右
// 侧有一个垂直色标，标题为 p_BH^min，数值范围从 0.2 至
// 1.0，颜色从浅米色渐变至深黄色。图中还有多条灰色曲线作
// 为等值线，以及一个黑色区域。当 α 较小时，等值线在左下
// 角较陡；当 α 较大时，等值线趋于水平。黑色区域位于图的
// 右上部分，表示该区域候选事件概率低于 5%。
#figure(image("imgs/pmin.png", width: 80%),
  caption: [
    Contours of the minimal merger efficiency $p_(upright("BH"))^(upright("min"))$ required for the probability of finding the candidate event at $f tilde 4 upright("nHz")$ to exceed 5% for different values of the parameters of the environmental effects. In the black region, the probability of the candidate event is less than 5% for $p_(upright("BH")) lt.eq 1$.
  ]
)
<fig:Pmin>



== Detecting individual binaries
<detecting-individual-binaries>


A nearby SMBH binary will stand out from the background as a resolvable binary. Intriguingly, the model predicts that the most probable frequency for an individual binary to be detectable is $tilde 4$~nHz~@Ellis:2023dgf, where there is evidence for an upward fluctuation in both NANOGrav and EPTA data~@NANOGrav:2023pdq @Antoniadis:2023bjw. If the SMBH binaries are driven by GW emission only the probability of observing such an event in the present NANOGrav data is less than$tilde 5 "%"$, but such an event is easier to accommodate when environmental energy loss is included in the SMBH binary model, where the probability is $tilde 23 "%"$. In @fig:Pmin we show contours of the minimal merger efficiency, $p_(upright("BH"))^(upright("min"))$, for which the probability of finding such an event is larger than 5% for different values of the environmental parameters $alpha$ and $f_(upright("ref"))$.~#footnote[In addition to bin-to-bin fluctuations and resolvable binaries, other characteristic features of the SMBH models include the possibilities of observable circular polarization~@Sato-Polito:2021efu @Ellis:2023owy and anisotropies~@Sato-Polito:2023spo.]


= COSMOLOGICAL SOURCES
<sec:cosmo>


In this Section, we discuss SGWB predictions in various cosmological scenarios invoking particle physics beyond the Standard Model (BSM). In these scenarios, the GWs are produced in the early Universe and their present abundance is $
& Omega_(upright("GW")) h^2 = [frac(a ( T ), a_0)]^4 [frac(H ( T ), H_0 h)]^2 Omega_(upright("GW")) ( T )\
 & approx 1.6 times 10^(- 5) [frac(g_(*) ( T ), 100)] #h(-1em) [frac(g_(* s) ( T ), 100)]^(#h(-1em) - 4 / 3) Omega_(upright("GW")) ( T ) thin
$<eq:OmegaGWtoday> where $T$ denotes the temperature at which the GWs were produced and $Omega_(upright("GW")) ( T )$ their abundance at that moment, $a$ is the scale factor and $H$ the Hubble rate, the subscript $0$ refers to their present day values, and $g_(*)$ and $g_(* s)$ are the effective numbers of relativistic energy and entropy degrees of freedom. The present frequency corresponding to the scale entering the Hubble horizon at temperature $T$ is $
f_H ( T ) #h(-1em) & = frac(a ( T ), a_0) frac(H ( T ), 2 pi)\
 & approx #h(-1em) 2.6 #h(-1em) times #h(-1em) 10^(- 8) thin upright("Hz") [frac(g_(*) ( T ), 100)]^(1 / 2) #h(-1em) [frac(g_(* s) ( T ), 100)]^(#h(-1em) - 1 / 3) #h(-1em) T / upright("GeV") thin .
$ For short-lasting, so-called causality-limited GW sources, the GW spectrum at $f lt.double f_H$ scales as $Omega_(upright("GW")) ( f lt.double f_H ) = Omega_(upright("CT")) ( f ) prop f^3$, assuming radiation domination~@Caprini:2009fx @Domenech:2020kqm. This behavior is affected by deviations from pure radiation domination, e.g., around the QCD phase transition. We use the results tabulated in Ref.~@Franciolini:2023wjm for the causality tail, $Omega_(upright("CT")) ( f )$.


== Cosmic (super)strings
<cosmic-superstrings>


Cosmic strings are one-dimensional topological defects that are predicted in many BSM scenarios~@Hindmarsh:1994re @Jeannerot:2003qv @King:2020hyd. Once produced, strings reach a scaling solution where their density is a small fraction of the total cosmological density while the excess energy goes into production of closed loops that then decay into GWs. This process continues throughout the evolution of the Universe and results in a very broad and relatively flat spectrum. We focus here on (super)strings that may arise from string theory~@Dvali:2003zj @Copeland:2003bj or during confinement in pure Yang-Mills theories~@Yamada:2022aax @Yamada:2022imq. Their main phenomenological difference from the standard case is a lower intercommutation probability $p$, which diminishes the loop production and increases the resulting string density and GW signal amplitude by a factor $p^(- 1)$~@Sakellariadou:2004wq @Blanco-Pillado:2017rnf.


Our calculation of the spectrum closely follows~@Ellis:2023tsl. We start with the velocity-dependent one-scale model~@Martins:1995tg @Martins:1996jp @Martins:2000cs @Avelino:2012qy @Sousa:2013aaa, which we use to compute the correlation length of the network $L$ and mean string velocity $macron(v)$ by solving the equations $
frac(d L, d t) & = ( 1 + macron(v)^2 ) thin H L + frac(tilde(c) macron(v), 2) thin \
frac(d macron(v), d t) & = ( 1 - macron(v)^2 ) [frac(k ( macron(v) ), L) - 2 H thin macron(v)] thin
$ where $ k ( macron(v) ) = frac(2 sqrt(2), pi) ( 1 - macron(v)^2 ) ( 1 + 2 sqrt(2) macron(v)^3 ) (frac(1 - 8 macron(v)^6, 1 + 8 macron(v)^6)) med , $ and $tilde(c) tilde.eq 0.23$ is the loop chopping efficiency~@Martins:2000cs.


Following recent numerical simulations~@Blanco-Pillado:2011egf @Blanco-Pillado:2013qja @Blanco-Pillado:2015ana @Blanco-Pillado:2017oxo @Blanco-Pillado:2019vcs @Blanco-Pillado:2019tbi we focus on large loops as the main GW sources. We include a prefactor $cal(F) tilde 0.1$ to describe the fraction of energy in these loops and a factor $f_r = sqrt(2)$ accounting for the energy going to peculiar velocities of loops~@Auclair:2019wcv and not contributing to radiation.


Loops cut from the network oscillate losing energy to GWs which reduces their length over time: $ l ( t ) = alpha_L L (t_i) - Gamma G mu (t - t_i) med . $<eq:lloop> Where we use $alpha_L approx 0.37$, the total emission power $Gamma approx 50$~@Burden:1985md @Blanco-Pillado:2017oxo @Blanco-Pillado:2017rnf and $t_i$ is the time at which the given loop was created.


// [figvision-cn] imgs/Pos_CS.png
// 该图由三个子图组成，呈倒L形布局，展示宇宙弦模型对NG15
// 数据拟合的后验概率分布。左下角为二维联合后验概率密度图，
// 其上方和右侧分别为两个一维边缘后验概率分布图。 左下角
// 子图（联合分布图）为二维等高线图。横轴为 log10(Gμ)，范
// 围约从 -12.3 到 -10.6，主刻度标记为 -12.0、-11.6、
// -11.2、-10.8；纵轴为 log10(p)，范围约从 -2.8 到 -0.6，
// 主刻度标记为 -2.5、-2.0、-1.5、-1.0。图中用紫色填充等
// 高线表示后验概率密度，由外向内颜色加深，最外层为浅紫色，
// 最内层为深紫色，表示概率密度逐渐升高。等高线形状呈左上
// 至右下的椭圆状。图中叠加了两条橙色直线，表示LVK的约束：
// 实线标记为 "LVK O3"，从图左下方延伸至右上方，斜率为正；
// 虚线标记为 "LVK design"，位于实线上方，斜率与实线相近，
// 表示更高的灵敏度。图中可见联合后验分布大部分位于 "LVK
// O3" 实线的左上方区域，与 "LVK design" 虚线有部分重叠。
// 上方子图（横轴边缘分布）为阶梯状直方图。横轴与左下角子
// 图横轴相同，为 log10(Gμ)，范围从 -12.3 到 -10.6；纵轴
// 未标注，表示概率密度。图中紫色阶梯线显示概率密度在
// log10(Gμ) 约 -11.8 处达到峰值，向两侧递减，在 -12.2 和
// -11.0 处较低。图中标注有区间 "[-12, -11]"，对应两条紫
// 色垂直虚线，分别位于 log10(Gμ) = -12.0 和 -11.0 处，表
// 示该区间内的概率分布。 右侧子图（纵轴边缘分布）为阶梯
// 状直方图。横轴为 log10(p)，范围约从 -2.8 到 -0.6，主刻
// 度标记为 -2.5、-2.0、-1.5、-1.0；纵轴未标注，表示概率
// 密度。图中紫色阶梯线显示概率密度在 log10(p) 约 -2.3 处
// 最高，随后向右侧递减。图中标注有区间 "[-3, -2.1]"，对
// 应一条紫色垂直虚线，位于 log10(p) = -2.1 处，表示该值
// 以下的概率分布。 整体趋势表明，宇宙弦模型参数 log10(Gμ
// ) 和 log10(p) 的后验概率分布存在正相关，且当前 LVK O3
// 约束已排除部分高概率区域，未来 LVK design 灵敏度将能进
// 一步限制参数空间。
#figure(image("imgs/Pos_CS.png", width: 100%),
  caption: [
    The posterior probability distribution of the cosmic (super)string model fit to the NG15 data. The current (O3) LVK constraint and prospective future LVK sensitivity are shown by the solid and dashed lines.
  ]
)
<fig:CSfit>



Calculation of the spectrum involves the integration of emissions from all contributing loops: $ Omega_(upright("GW"))^(( 1 )) ( f ) = frac(16 pi, 3 f) cal(F) / f_r frac(G mu^2, H_0^2) frac(Gamma, zeta alpha_L) integral_(t_F)^(t_0) #h(-1em) d tilde(t) #h(0em) n ( l , tilde(t) ) thin , $<eq:GWdensity> where $ n ( l , tilde(t) ) = frac(Theta ( t_i - t_F ), alpha_L dot(L) ( t_i ) + Gamma G mu) frac(tilde(c) v ( t_i ), L ( t_i )^4) \[ frac(a ( tilde(t) ), a ( t_0 )) \]^5 \[ frac(a ( t_i ), a ( tilde(t) )) \]^3 thin . $ The formation time of the loops has to be found solving @eq:lloop and restricting to loops emitting at frequency $f$ whose length is $l ( tilde(t) , f ) = 2 / f frac(a ( tilde(t) ), a ( t_0 ))$. The Heaviside function assures that we integrate from only the time $t_F$ when the network first reaches scaling after its production. We ensure that the total emitted power equals $Gamma$ with the function $zeta = sum k^(- 4 / 3)$, where we assume that the GW emission is dominated by cusps. Finally, we sum over the emission modes using $ Omega_(upright("GW"))^(( k )) ( f ) = k^(- q) thin Omega_(upright("GW"))^(( 1 )) ( f / k ) thin , $ and the prescription from ref. ~@Cui:2019kkd that allows us to sum over a very large number of modes, which is necessary to compute the spectrum accurately~@Cui:2019kkd @Blasi:2020wpy @Gouttenoire:2019kij.


// [figvision-cn] imgs/Pos_CSwSMBH.png
// 这是一张由15个子图组成的下三角联合后验概率分布图（角图），
// 用于展示超弦理论模型拟合NG15脉冲星计时阵列数据（包含带
// 环境效应的超大质量黑洞双星）时各参数的约束情况。 子图a
// （最左上角，第1行第1列）：类型为一维边缘后验概率直方图。
// 横轴为参数pBH，范围约0.1至0.9，无单位。纵轴为概率密度，
// 无刻度。曲线为阶梯状紫红色实线。图中标注有两条深紫色垂
// 直虚线，分别位于约0.25和约0.68处；顶部标注文字为“[0.22
// , 0.77]”，表示该参数的95%置信区间。趋势：pBH在0.2至0.7
// 之间具有较高的概率，分布呈宽峰状。 子图b（第2行第1列）：
// 类型为二维等高线图。横轴为pBH（范围0.1至0.9），纵轴为α
// （范围约0.5至6.5，无单位）。图中有三层紫色填充等高线，
// 颜色由外向内加深，分别代表不同的置信水平（通常为50%、
// 90%、99%）。趋势：当pBH增大时，α倾向于减小，两者呈负相
// 关。 子图c（第2行第2列）：类型为一维直方图。横轴为α，
// 范围约0.5至6.5。纵轴为概率密度。阶梯状紫红色实线。两条
// 垂直虚线位于约1.9和约4.7处；顶部标注“[1.8, 4.8]”。趋势：
// α的分布呈右偏态，峰值在2.5至3.0之间。 子图d（第3行第1
// 列）：类型为二维等高线图。横轴为pBH，纵轴为fref/nHz（
// 范围约5至35）。三层紫色填充等高线。趋势：pBH与fref呈正
// 相关，当pBH增大时，fref倾向于更高值。 子图e（第3行第2
// 列）：类型为二维等高线图。横轴为α，纵轴为fref/nHz。趋
// 势：α与fref呈负相关，高α值对应低fref。 子图f（第3行第3
// 列）：类型为一维直方图。横轴为fref/nHz，范围约5至35。
// 阶梯状紫红色实线。两条垂直虚线位于约11和约27处；顶部标
// 注“[17, 35]”。趋势：fref分布呈双峰或宽峰，主峰在20附近。
// 子图g（第4行第1列）：类型为二维等高线图。横轴为pBH，纵
// 轴为log10(Gμ)（范围约-12.5至-10.5）。三层紫色填充等高
// 线。趋势：pBH与log10(Gμ)呈弱正相关。 子图h（第4行第2列）：
// 类型为二维等高线图。横轴为α，纵轴为log10(Gμ)。趋势：α
// 与log10(Gμ)呈弱负相关。 子图i（第4行第3列）：类型为二
// 维等高线图。横轴为fref/nHz，纵轴为log10(Gμ)。趋势：
// fref与log10(Gμ)呈正相关。 子图j（第4行第4列）：类型为
// 一维直方图。横轴为log10(Gμ)，范围约-12.5至-10.5。阶梯
// 状紫红色实线。两条垂直虚线位于约-12.2和约-10.9处；顶部
// 标注“[-12, -11]”。趋势：log10(Gμ)分布较宽，峰值在-11.5
// 附近。 子图k（第5行第1列）：类型为二维等高线图。横轴为
// pBH，纵轴为log10(p)（范围约-2.8至-0.5）。三层紫色填充
// 等高线。趋势：pBH与log10(p)呈正相关。 子图l（第5行第2
// 列）：类型为二维等高线图。横轴为α，纵轴为log10(p)。趋
// 势：α与log10(p)呈弱正相关。 子图m（第5行第3列）：类型
// 为二维等高线图。横轴为fref/nHz，纵轴为log10(p)。趋势：
// fref与log10(p)呈负相关。 子图n（第5行第4列）：类型为二
// 维等高线图。横轴为log10(Gμ)，纵轴为log10(p)。图中除了
// 三层紫色填充等高线外，还叠加了两条斜线：一条橙色实线标
// 注为“LVK O3”，一条橙色虚线标注为“design”。趋势：log10(
// Gμ)与log10(p)呈强正相关，数据分布与LVK O3及design灵敏
// 度曲线有部分重叠。 子图o（第5行第5列，最右下角）：类型
// 为一维直方图。横轴为log10(p)，范围约-2.8至-0.5。阶梯状
// 紫红色实线。一条垂直虚线位于约-2.1处；顶部标注“[-2,
// -0.5]”。趋势：log10(p)分布呈右偏态，峰值在-1.5至-1.0之
// 间。
#figure(image("imgs/Pos_CSwSMBH.png", width: 100%),
  caption: [
    As in @fig:CSfit, for a (super)string fit to NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:CSwSMBHfit>



In @fig:CSfit we show the posterior distributions for the string tension, $G mu$, and the intercommutation probability, $p$, together with the constraints from current (O3) LIGO/Virgo/KAGRA (LVK) data~@KAGRA:2021kbb and the design sensitivity of future LVK data~@LIGOScientific:2014pky @LIGOScientific:2016fpe @LIGOScientific:2019vic, assuming that the SMBH background is negligible. The best pure (super)string fit not in conflict with current LVK data has $ G mu = 2 times 10^(- 12) thin , quad p = 6.3 times 10^(- 3) thin , $ with $- 2 Delta ell = 1.5$ compared to the SMBH baseline model including environmental effects. @fig:CSwSMBHfit shows results from a combined fit including the possibility of a SMBH background. The best fit, in this case, is at $
& G mu = 1.2 times 10^(- 12) thin quad p = 3.3 times 10^(- 3) thin \
 & p_(upright("BH")) = 0.42 thin quad f_(upright("ref")) = 24 thin upright("nHz") thin quad alpha = 4.4 thin
$ with $- 2 Delta ell = - 0.7$. Each model individually can give a comparable fit, and indeed we find that a combined fit with significant contributions from both gives a noticeably better fit, although the improvement is not very significant statistically. A significant contribution from SMBH binaries also results in a non-negligible probability of finding a candidate event at $f tilde 4$~nHz, which in this case is 5%.


== Phase transitions
<phase-transitions>


Cosmological first-order phase transitions generate GWs in bubble collisions and by motions of inhomogeneities in the fluid~@Witten:1984rs @Hogan:1986qda. Given the large amplitude of the NANOGrav signal, we focus on very strong transitions that accommodate this feature naturally. We assume that the energy of the transition dominates over the background, so that its strength $alpha gt.double 1$, in which case its value does not play an important role in the calculation of the signal. It was recently shown in~@Lewicki:2022pdb that in such a case the energy budget of the transition does not play an important role, as fluid-related sources~@Kamionkowski:1993fg @Hindmarsh:2015qta @Hindmarsh:2016lnk @Hindmarsh:2017gnf @Ellis:2018mja @Cutting:2019zws @Hindmarsh:2019phv @Ellis:2020awk @Nakai:2020oit and the contributions from bubble collisions~@Kosowsky:1992vn @Cutting:2018tjt @Ellis:2019oqb @Lewicki:2019gmv @Cutting:2020nla @Lewicki:2020jiv @Giese:2020znk @Ellis:2020nnr @Lewicki:2020azd @Wang:2022wwj behave very similarly.


// [figvision-cn] imgs/Pos_PT.png
// 该图由三个子图构成，呈 2×2 布局，左下为二维后验概率分
// 布等高线图，左上和右下分别为两个参数的一维边缘后验概率
// 分布直方图，右上角空白。 子图 a（左上）：一维阶梯直方
// 图。横轴为 log₁₀(T*/GeV)，范围约从 −2.0 到 0.8，单位无
// 量纲；纵轴为概率密度（无刻度标签）。黄色阶梯线展示后验
// 分布，峰值在 −0.5 附近，分布不对称，左侧尾部较长。两条
// 黄色竖直虚线标出 95% 置信区间边界，图上方标注区间 [−
// 0.79, 0.22]。 子图 b（左下）：二维等高线图。横轴为 log
// ₁₀(T*/GeV)，范围约 −2.0 至 0.8；纵轴为 log₁₀(β/H)，范
// 围约 0.2 至 1.7。黄色填充等高线表示后验概率密度，颜色
// 由浅黄到深橙黄递增，中心最暗区域为概率最高处，位于 (T*
// ≈−0.3, β/H≈0.9)。等高线呈右上—左下倾斜的椭圆状。图中有
// 一条水平灰色虚线位于 log₁₀(β/H)≈0.6，其下方区域填充为
// 灰色，并标注文字 “PBH overproduction”，表示该区域因原
// 初黑洞过量产生而被排除。 子图 c（右下）：一维阶梯直方
// 图。横轴为 log₁₀(β/H)，范围约 0.2 至 1.7；纵轴为概率密
// 度（无刻度标签）。黄色阶梯线展示边缘后验分布，峰值在
// 0.9 附近，分布较对称。两条黄色竖直虚线标出 95% 置信区
// 间边界，图上方标注区间 [0.38, 0.98]。 整体趋势：后验概
// 率分布显示 log₁₀(T*/GeV) 与 log₁₀(β/H) 存在正相关退化；
// 原初黑洞过量产生的限制排除了 log₁₀(β/H) 低于约 0.6 的
// 参数空间。
#figure(image("imgs/Pos_PT.png", width: 100%),
  caption: [
    The posterior probability distribution of the phase transition fit to the NG15 data. The constraint from the production of PBHs is shown in grey.
  ]
)
<fig:PTfit>



The resulting GW spectrum is a broken power-law that may be parametrized as $ Omega_(upright("GW")) ( f , T_(*) ) = [beta / H]^2 frac(A ( a + b )^c S_H ( f , f_H ( T_(*) ) ), (b [f / f_p]^(#h(-1em) - a / c) + a [f / f_p]^(b / c))^(#h(-1em) c)) thin , $<eq:Omega_PT> where $beta$ is the timescale of the transition, $T_(*)$ is the temperature reached after the transition, $a = b = 2.4$, $c = 4$, $A = 5.1 times 10^(- 2)$ and the peak frequency $f_p = 0.7 f_H ( T_(*) ) beta / H$~@Lewicki:2022pdb. The function $ S_H ( f , f_H ) = (1 + [frac(Omega_(upright("CT")) ( f ), Omega_(upright("CT")) ( f_H ))]^(- 1 / delta) [f / f_H]^(a / delta))^(#h(-1em) - delta) $<eq:SH> models the transition of the spectrum to the causality tail at scales larger than the horizon at the transition time~@Caprini:2009fx. The parameter $delta$ determines how quickly the spectrum evolves towards the causality tail and could be determined by a simulation of the strong phase transition taking expansion into account. We fix $delta = 1$, having verified its value does not have a large impact on the results.


// [figvision-cn] imgs/Pos_PTwSMBH.png
// 这是一张5×5的下三角矩阵图（角图），用于展示五个参数的
// 边缘概率分布和两两联合概率分布。五个参数分别为：pBH、α、
// fref/nHz、log10(T*/GeV)、log10(β/H)。所有子图均使用黄
// 色填充区域表示置信区间（颜色越深表示概率密度越高，通常
// 对应1σ和2σ置信区域），并使用黄色实线绘制边缘分布的阶梯
// 状直方图。以下逐个子图说明： 子图(a)（左上角，第1行第1
// 列）：一维边缘概率分布直方图。横轴为pBH，范围约0.1至
// 1.0。纵轴为概率密度（无刻度标签）。黄色实线阶梯图显示
// 分布呈单峰，峰值在pBH约0.7处。图中两条黄色垂直虚线分别
// 位于约0.2和0.75处，顶部标注区间“[0.2, 0.75]”，表示该参
// 数的68%置信区间。 子图(b)（第2行第2列）：一维边缘概率
// 分布直方图。横轴为α，范围约0.5至6.0。黄色实线阶梯图显
// 示分布呈右偏单峰，峰值在α约1.5处，随后缓慢下降。两条黄
// 色垂直虚线分别位于约1.5和4.1处，顶部标注“[1.5, 4.1]”。
// 子图(c)（第3行第3列）：一维边缘概率分布直方图。横轴为
// fref/nHz，范围约2至60。黄色实线阶梯图显示分布呈单峰，
// 峰值在fref约16 nHz处。两条黄色垂直虚线分别位于约14和33
// 处，顶部标注“[14, 33]”。 子图(d)（第4行第4列）：一维边
// 缘概率分布直方图。横轴为log10(T*/GeV)，范围约-2.0至1.0。
// 黄色实线阶梯图显示分布较宽，峰值在约-0.3处。一条黄色垂
// 直虚线位于约-0.67处，顶部标注“[-0.67, 1.3]”（表示置信
// 区间上界为1.3，下界为-0.67）。 子图(e)（第5行第5列）：
// 一维边缘概率分布直方图。横轴为log10(β/H)，范围约0.2至
// 1.8。黄色实线阶梯图显示分布呈上升趋势，峰值在约1.6处。
// 一条黄色垂直虚线位于约0.94处，顶部标注“[0.94, 2]”。 子
// 图(f)（第2行第1列）：二维联合概率分布等高线图。横轴为
// pBH（0.1-1.0），纵轴为α（0.5-6.0）。黄色填充区域显示
// pBH与α呈正相关趋势：当pBH增大时，α的允许范围向高值移动。
// 深黄色区域集中在pBH约0.6-0.8、α约1.5-3.0处。 子图(g)（
// 第3行第1列）：二维联合概率分布等高线图。横轴为pBH，纵
// 轴为fref/nHz（2-60）。黄色区域显示pBH与fref呈正相关：
// pBH增大时fref倾向更高值。深黄色区域集中在pBH约0.6-0.8、
// fref约16-32 nHz处。 子图(h)（第3行第2列）：二维联合概
// 率分布等高线图。横轴为α（0.5-6.0），纵轴为fref/nHz。黄
// 色区域显示α与fref呈正相关：α增大时fref倾向更高值。深黄
// 色区域集中在α约1.5-3.0、fref约16-32 nHz处。 子图(i)（
// 第4行第1列）：二维联合概率分布等高线图。横轴为pBH，纵
// 轴为log10(T*/GeV)（-2.0至1.0）。黄色区域较宽，显示pBH
// 与log10(T*)相关性较弱，深黄色区域集中在pBH约0.6-0.8、
// log10(T*)约-0.5至0.5处。 子图(j)（第4行第2列）：二维联
// 合概率分布等高线图。横轴为α，纵轴为log10(T*/GeV)。黄色
// 区域显示α与log10(T*)呈弱正相关，深黄色区域集中在α约
// 1.5-3.0、log10(T*)约-0.5至0.5处。 子图(k)（第4行第3列）：
// 二维联合概率分布等高线图。横轴为fref/nHz，纵轴为log10(
// T*/GeV)。黄色区域显示fref与log10(T*)呈弱正相关，深黄色
// 区域集中在fref约16-32 nHz、log10(T*)约-0.5至0.5处。 子
// 图(l)（第5行第1列）：二维联合概率分布等高线图。横轴为
// pBH，纵轴为log10(β/H)（0.2-1.8）。图中有一条灰色水平虚
// 线位于log10(β/H)约0.6处，虚线下方区域标注文字“PBH
// overproduction”（原初黑洞过度产生），该区域被灰色填充。
// 黄色等高线区域显示pBH与log10(β/H)呈正相关：pBH增大时
// log10(β/H)倾向更高值，且大部分概率区域位于灰色虚线之上
// （即避免PBH过度产生）。 子图(m)（第5行第2列）：二维联
// 合概率分布等高线图。横轴为α，纵轴为log10(β/H)。同样有
// 灰色水平虚线位于约0.6处，下方标注“PBH overproduction”
// 并填充灰色。黄色区域显示α与log10(β/H)呈正相关，深黄色
// 区域集中在α约1.5-3.0、log10(β/H)约1.0-1.4处，位于灰色
// 虚线之上。 子图(n)（第5行第3列）：二维联合概率分布等高
// 线图。横轴为fref/nHz，纵轴为log10(β/H)。灰色水平虚线位
// 于约0.6处，下方标注“PBH overproduction”并填充灰色。黄
// 色区域显示fref与log10(β/H)呈弱正相关，深黄色区域集中在
// fref约16-32 nHz、log10(β/H)约1.0-1.4处，位于灰色虚线之
// 上。 子图(o)（第5行第4列）：二维联合概率分布等高线图。
// 横轴为log10(T*/GeV)，纵轴为log10(β/H)。灰色水平虚线位
// 于约0.6处，下方标注“PBH overproduction”并填充灰色。黄
// 色区域显示log10(T*)与log10(β/H)呈弱负相关趋势，深黄色
// 区域集中在log10(T*)约-0.5至0.5、log10(β/H)约1.0-1.4处，
// 位于灰色虚线之上。 整体趋势：各参数的一维边缘分布均给
// 出了68%置信区间（标注在对应直方图顶部）。二维联合分布
// 显示pBH、α、fref三者之间存在正相关，而log10(β/H)与前三
// 者呈弱正相关，与log10(T*)呈弱负相关。所有涉及log10(β/H
// )的二维图均标示了“PBH overproduction”禁区（灰色虚线下
// 方），显示后验概率主要落在该禁区之上，即模型参数倾向于
// 避免原初黑洞过度产生。该图对应NG15数据对相变模型的拟合，
// 并包含了带环境效应的超大质量双黑洞贡献。
#figure(image("imgs/Pos_PTwSMBH.png", width: 100%),
  caption: [
    As in @fig:PTfit for a phase transition fit to NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:PTwSMBHfit>



In @fig:PTfit we show the posteriors of phase transition fit to the NG15 data while @fig:PTwSMBHfit includes also the background from SMBH binaries. The best fit to a pure phase transition signal is for $ T_(*) = 0.34 thin upright("GeV") thin , quad beta / H = 6.0 thin , $<eq:PTbestfit> resulting in $- 2 Delta ell = - 2.3$ compared to the SMBH baseline model. Including SMBHs with environmental effects, we find that the best fit is dominated by the phase transition signal with $p_(upright("BH")) approx 0$. Searching for points capable of providing the candidate event at $4$ nHz by requiring its probability to be $gt.eq 5 "%"$ we find the best-fit point $
& T_(*) = 2.6 thin upright("GeV") thin quad beta H = 4.0\
 & p_(upright("BH")) = 0.28 thin #h(0em) f_(upright("ref")) = 20 thin upright("nHz") thin #h(0em) alpha = 2.6 thin
$ which gives $- 2 Delta ell = 0.2$.


Strong first-order phase transitions can also lead to the formation of primordial black holes (PBHs) if they are sufficiently slow~@Hawking:1982ga @Kodama:1982sf @Liu:2021svg @Lewicki:2023ioy @Gouttenoire:2023naa. In @fig:PTfit and @fig:PTwSMBHfit we show the constraint $beta / H gt.tilde 4$ from overproduction of PBHs~@Lewicki:2023ioy.#footnote[A slightly stronger bound, $beta / H gt.tilde 6$, was found in~@Gouttenoire:2023naa.] We see that most of the 1$sigma$ region of the fit including only the phase transition signal is allowed by this constraint. However, as pointed out in~@Gouttenoire:2023bqy, it is interesting that the NG15 fit is compatible with a large PBH abundance. These PBHs would be around the stellar mass range, where their abundance is constrained by optical lensing~@EROS-2:2006ryy @Macho:2000nvd @Zumalacarregui:2017qqd @Gorton:2022fyb @Petac:2022rio @DeLuca:2022uvz, GW observations~@Raidal:2017mfl @Ali-Haimoud:2017rtz @Raidal:2018bbj @Vaskonen:2019jpv @Hutsi:2020sol @Franciolini:2022tfm and accretion~@Ricotti:2007au @Horowitz:2016lib @Ali-Haimoud:2016mbv @Poulin:2017bwe @Hektor:2018qqw @Hutsi:2019hlw @Serpico:2020ehh (for a review see e.g.~@Carr:2020gox). Nevertheless, a subdominant PBH abundance, $cal(O) ( 0.1 )$% of DM, might be related to the BH binary mergers detected by LVK~@Vaskonen:2019jpv @DeLuca:2020jug @Raidal:2017mfl @Raidal:2018bbj @Ali-Haimoud:2017rtz @DeLuca:2020qqa @Hutsi:2020sol @Franciolini:2021tla @Clesse:2020ghq @Franciolini:2022tfm and can be further probed with future GW observatories~@DeLuca:2021hde @Pujolas:2021yaw @Urrutia:2023mtk @Franciolini:2023opt.


== Domain walls
<domain-walls>


// [figvision-cn] imgs/Pos_DW_only.png
// 这是一张由三个子图组成的角图（corner plot），展示两个
// 参数的后验概率分布。左下为二维等高线图，左上方和右下方
// 分别为两个参数的一维边缘概率分布直方图。 整体布局：图
// 像呈 2×2 网格，左上角子图为顶部一维分布，左下角子图为
// 二维联合分布，右下角子图为右侧一维分布，右上角区域留空
// 并放置文字标注。 顶部一维边缘分布（对应横轴 log10(
// T_ann/GeV)）： 子图类型：阶梯状直方图（边缘后验概率分
// 布）。 横轴：与下方二维图横轴共享，标度值从 −0.6 到
// 0.6，单位对应 log10(T_ann/GeV)；纵轴无标注，代表概率密
// 度（相对值）。 曲线：深绿色阶梯线，显示分布峰值约在 −
// 0.1 至 0.1 之间，分布右侧有较长拖尾延伸至约 0.7。 标注：
// 图中上方标有区间文字 “[−0.2, 0.072]”；两条垂直深绿色虚
// 线分别位于约 −0.2 和 0.072 处，标示该区间的边界。 趋势：
// 该参数的后验分布中心接近 0，多数概率质量集中在 −0.2 至
// 0.07 之间。 右侧一维边缘分布（对应纵轴 log10(α_★)）：
// 子图类型：阶梯状直方图（边缘后验概率分布）。 横轴：与
// 二维图纵轴共享，标度值从 −1.6 到 −0.4，单位对应 log10(
// α_★)（量纲一）；纵轴无标注，代表概率密度（相对值）。
// 曲线：深绿色阶梯线，峰值约在 −1.0 至 −0.9 附近，分布向
// 两侧递减，左侧尾部延伸至 −1.6，右侧尾部延伸至 −0.4 左
// 右。 标注：图上方标有区间文字 “[−1.1, −0.76]”；两条垂
// 直深绿色虚线分别位于约 −1.1 和 −0.76 处，标示该区间的
// 边界。 趋势：该参数的后验分布中心约在 −0.9，多数概率质
// 量集中在 −1.1 至 −0.76 之间。 左下二维联合后验分布：
// 子图类型：填充等高线图（二维后验概率密度）。 横轴：
// log10(T_ann/GeV)，范围约 −0.8 至 0.8，刻度标注为 −0.6、
// −0.3、0.0、0.3、0.6。 纵轴：log10(α_★)，范围约 −1.6 至
// −0.1，刻度标注为 −1.6、−1.2、−0.8、−0.4（文字旋转 45°
// 显示）。 等高线：三层深绿色填充区域，颜色由外向内加深；
// 最外层浅绿色为低概率密度区域，最内层深绿色为高概率密度
// 核心区，核心位于横轴约 0.0、纵轴约 −0.8 处。 标注：图
// 中左上部有文字 “ΔN_eff”。 阴影区域：图左上部分被灰色半
// 透明阴影覆盖，阴影区边界由一条粗黑色虚线划分。该黑色虚
// 线从左侧（横轴约 −0.8、纵轴约 −1.35）向右延伸，在横轴
// 约 0.2 处略向下弯折，随后近似水平延伸至右侧边界（横轴
// 约 0.8、纵轴约 −0.95）。根据图注，虚线表示约束暗物质壁
// （DW）完全湮灭为暗辐射可能性的边界。 趋势：二维后验概
// 率核心位于黑色虚线下方，表明数据更倾向于参数空间中未越
// 过该边界的区域；概率分布呈从左上向右下倾斜的椭圆状，说
// 明两个参数存在正相关趋势。
#figure(image("imgs/Pos_DW_only.png", width: 100%),
  caption: [
    The posterior probability distribution of the DW fit to the NG15 data. The dashed line indicates the $Delta N_(upright("eff"))$ bound, which constrains the possibility of DWs annihilating completely into dark radiation.
  ]
)
<fig:new_DW>



Domain walls (DWs)~@Vilenkin:1984ib are topological defects produced when a discrete symmetry in some BSM scenario is broken after inflation. During the scaling regime when the DW network expands together with its surroundings, the energy density is $rho_(upright("DW")) = c thin sigma H$~@Hiramatsu:2013qaa @Kibble:1976sj, where $sigma$ is the tension of the wall and $c = cal(O) ( 1 )$ is a scaling parameter. DWs emit GWs until they annihilate at a temperature $T = T_(upright("ann"))$~@Gelmini:1988sf @Coulson:1995nv @Larsson:1996sp @Preskill:1991kd. The peak frequency of the resulting GW spectrum is given by the horizon size at the time of DW annihilation, $f_p = f_H ( T_(upright("ann")) )$, and at frequencies $f gt.double f_p$ the spectrum scales as $f^(- 1)$. We approximate the GW spectrum at the formation time $T = T_(upright("ann"))$ as~@Hiramatsu:2013qaa @Ferreira:2022zzo $ Omega_(upright("DW")) ( f , T_(upright("ann")) ) = frac(3 epsilon.alt alpha_(*)^2, 8 pi) #h(-1em) (1 / 4 #h(-1em) [frac(Omega_(upright("CT")) ( f_p ), Omega_(upright("CT")) ( f ))]^(1 / delta) #h(-1em) #h(-1em) + 3 / 4 #h(-1em) [f / f_p]^(#h(-1em) 1 / delta))^(#h(-1em) #h(-1em) - delta) , $ where $epsilon.alt = cal(O) ( 1 )$ is an efficiency parameter and $alpha_(*) equiv rho_(upright("DW")) ( T_(upright("ann")) ) / rho_r ( T_(upright("ann")) )$ is the energy density in the domain walls relative to the radiation energy density $rho_r$ at the annihilation moment. Following the results of numerical simulations~@Hiramatsu:2013qaa, we fix $epsilon.alt = 0.7$ and $delta = 1$.


// [figvision-cn] imgs/Pos_DW.png
// 这是一张五参数贝叶斯后验分布的角图（corner plot），由
// 五个一维边缘分布直方图和十个二维联合后验等高线图组成，
// 用于展示模型参数拟合结果及其相关性。图中所有参数均基于
// NG15 数据，并包含带有环境效应的超大质量双黑洞（SMBH
// binaries）与畴壁（domain wall）模型的联合拟合。 整体布
// 局与通用元素：图的对角线从左至右依次展示了五个参数的一
// 维边缘后验概率分布直方图，横轴下方标注了参数名称，纵轴
// 为相对概率密度（未标数值）。对角线子图内的虚线表示后验
// 分布的 95% 可信区间边界，顶部方括号内给出了该区间的具
// 体数值。非对角线子图展示了参数两两之间的二维联合后验概
// 率分布，采用等高线填充图表示，深绿色区域代表高概率密度
// （约 1σ 至 2σ），浅绿色区域代表较低概率密度，最外层轮
// 廓线代表 95% 可信区域。在二维图内部，深绿色区域边缘的
// 黑色实线为等高线。 第一列参数为 \(p_{\rm BH}\)（原初黑
// 洞比例），横轴范围 0.2 至 0.8，刻度间隔 0.2。其对角线
// 一维直方图呈近似高斯分布，峰值约在 0.5，顶部标注 95%
// 可信区间为 [0.25, 0.77]，两条垂直虚线分别位于 0.25 和
// 0.77。二维图显示 \(p_{\rm BH}\) 与 \(\alpha\) 呈微弱的
// 正相关趋势（等高线向右上方倾斜），与 \(f_{\rm ref}\)
// 呈微弱的负相关（等高线向右下方倾斜）。 第二列参数为 \(
// \alpha\)（谱指数），横轴范围 1.5 至 6.0，刻度间隔 0.75。
// 其一维直方图在低值端较高，随后缓慢下降，峰值约在 2.0
// 附近，95% 可信区间为 [1.4, 3.8]，垂直虚线位于 1.4 和
// 3.8。在二维图中，\(\alpha\) 与 \(f_{\rm ref}\) 呈现出
// 明显的正相关，等高线向右上方倾斜；\(\alpha\) 与 \(\
// log_{10}(T_{\rm ann}/{\rm GeV})\) 的联合分布显示，当 \
// (\alpha\) 较高时，\(T_{\rm ann}\) 倾向于较低值。 第三
// 列参数为 \(f_{\rm ref}/{\rm nHz}\)（参考频率），横轴范
// 围 8 至 32，刻度间隔 8。一维直方图呈明显的单峰分布，峰
// 值约在 18 附近，95% 可信区间为 [13, 30]，垂直虚线位于
// 13 和 30。在二维图中，\(f_{\rm ref}\) 与 \(\alpha\) 呈
// 正相关，与 \(\log_{10}(T_{\rm ann}/{\rm GeV})\) 呈负相
// 关（等高线向右下方倾斜），与 \(\log_{10}(\alpha_\star)
// \) 也呈负相关趋势。 第四列参数为 \(\log_{10}(T_{\rm
// ann}/{\rm GeV})\)（湮灭温度的对数），横轴范围 -0.6 至
// 1.8，刻度间隔 0.6。一维直方图分布较宽，峰值约在 0.3 附
// 近，95% 可信区间为 [0.16, 2]，垂直虚线位于 0.16 和 2。
// 该参数的二维图与 \(\log_{10}(\alpha_\star)\) 的联合分
// 布中，图中标注了 "\(\Delta N_{\rm m}\)" 字样，并出现了
// 一条贯穿深绿色区域的黑色短虚线，该虚线斜率为负，表明 \
// (T_{\rm ann}\) 与 \(\alpha_\star\) 之间存在特定的简并
// 关系。 第五列参数为 \(\log_{10}(\alpha_\star)\)（耦合
// 常数的对数），横轴范围 -2.0 至 -0.5，刻度间隔 0.5。其
// 一维直方图在 -1.5 至 -1.0 之间分布较平缓，随后在 -1.0
// 处急剧下降，95% 可信区间为 [-2.5, -1]，垂直虚线位于
// -2.5 和 -1。该参数与前面参数的二维图显示，其与 \(p_{\
// rm BH}\) 和 \(\alpha\) 的相关性较弱，但与 \(f_{\rm ref
// }\) 和 \(T_{\rm ann}\) 存在一定的负相关。 整体趋势表明，
// 该模型对五个参数均有较好的约束，其中 \(p_{\rm BH}\)、\
// (f_{\rm ref}\) 和 \(\alpha\) 的后验分布较为集中，而 \(
// T_{\rm ann}\) 和 \(\alpha_\star\) 的约束相对较宽，且参
// 数间存在如 \(\alpha\) 与 \(f_{\rm ref}\) 的正相关、\(
// f_{\rm ref}\) 与 \(T_{\rm ann}\) 的负相关等显著的简并
// 关系。
#figure(image("imgs/Pos_DW.png", width: 100%),
  caption: [
    As in @fig:new_DW for a domain wall fit to the NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:DW_posteriors>



The parameters of the DW model are the relative energy density in DWs, $alpha_(*)$, and the temperature at which they annihilate, $T_(upright("ann"))$. Since the DWs can constitute a big fraction of the total energy density, it is necessary to check that their annihilation respects the constraints imposed by Big Bang Nucleosynthesis (BBN) and the Cosmic Microwave Background (CMB). If the DWs annihilate completely into dark radiation, the energy density can be expressed as the equivalent number of neutrino species @Ferreira:2022zzo: $Delta N_(upright("eff")) = rho_(upright("DW")) ( T_(upright("ann")) ) / rho_(upright(nu)) ( T_(upright("ann")) ) = 13.6 thin g_(*) ( T_(upright("ann")) )^(- 1 / 3) thin alpha_(*)$, which is constrained by BBN ($Delta N_(upright("eff")) < 0.33$)~@Fields:2019pfx and CMB ($Delta N_(upright("eff")) < 0.3$)~@Planck:2018vyg @Ramberg:2022irf. On the other hand, if the DWs annihilating into SM particles, BBN imposes $T_(upright("ann")) > ( 4 - 5 ) thin upright("MeV")$~@Hasegawa:2019jsa and CMB $T_(upright("ann")) > 4.7 thin upright("MeV")$~@deSalas:2015glj (see~@Allahverdi:2020bys for a review).


We have performed scans over the parameters of the DW model to fit the NG15 data. The posterior probability distributions for the DW model without a SMBH contribution are shown in @fig:new_DW, and the best fit is at $ T_(upright("ann")) = 0.85 thin upright("GeV") thin , quad alpha_(*) = 0.11 thin , $ and has $- 2 Delta ell = - 3.1$ compared to the SMBH baseline model. These parameter values are allowed both if the DWs annihilate into SM particles. If they instead annihilate into dark radiation, the best fit is in tension with $Delta N_(upright("eff"))$ bound. However, the $1 sigma$ region of the posterior distribution extends to smaller values of $alpha_(*)$ that are allowed by the $Delta N_(upright("eff"))$ bound.


@fig:DW_posteriors shows a full set of posterior parameter distribution functions and two-parameter correlations for the fit to a combination of DWs and SMBH binaries. The best fit of the combined model is dominated by the DW contribution with $p_(upright("BH")) approx 0$. Imposing a lower bound on $p_(upright("BH"))$ from @fig:Pmin, the best fit is $
& T_(upright("ann")) = 1.12 thin upright("GeV") thin quad alpha_(*) = 0.074 thin \
 & p_(upright("BH")) = 0.51 thin #h(0em) f_(upright("ref")) = 22 thin upright("nHz") thin #h(0em) alpha = 2.6 thin
$ with $- 2 Delta ell = - 0.5$.


Similarly to first-order phase transitions, the annihilation of the DW network can lead to the copious formation of PBHs~@Ferrer:2018uiu @Gelmini:2023ngs. The PBH formation may be so efficient that it excludes the parameter region preferred by the NG15 data~@Gouttenoire:2023ftk. However, further studies are needed to confidently estimate the PBH formation from DW networks.


== Scalar-induced GWs
<sec:SIGWth>


Primordial scalar curvature fluctuations can source a SGWB at the second order of perturbation theory~@Tomita:1975kj @Matarrese:1993zf @Acquaviva:2002ud @Mollerach:2003nq @Ananda:2006af @Baumann:2007zm @Domenech:2021ztg @Yuan:2021qgz. A scalar-induced GW (SIGW) background that can be probed by PTAs requires sizable curvature perturbations that enter the horizon around the QCD phase transition. This scenario has received a lot of attention~@Vaskonen:2020lbd @Chen:2019xse @DeLuca:2020agl @Bhaumik:2020dor @Inomata:2020xad @Kohri:2020qqd @Domenech:2020ers @Vagnozzi:2020gtf @Namba:2020kij @Sugiyama:2020roc @Zhou:2020kkf @Lin:2021vwc @Rezazadeh:2021clf @Kawasaki:2021ycf @Ahmed:2021ucx @Yi:2022ymw @Yi:2022anu @Dandoy:2023jot @Zhao:2023xnh @Ferrante:2023bgz @Cai:2023uhc since the initial observation of a stochastic common-spectrum process by NANOGrav~@NANOGrav:2020bcs and several studies have recently appeared that update the available parameter space in the light of the most recent PTA data releases~@Franciolini:2023pbf @Franciolini:2023wjm @Inomata:2023zup @Ebadi:2023xhq @Figueroa:2023zhu @Yi:2023mbm @Firouzjahi:2023lzg @You:2023rmn @Balaji:2023ehk @Zhao:2023joc @Yi:2023tdk. The most stringent constraint on a SIGW scenario for PTAs arises from the overproduction of PBHs associated with large peaks in the primordial curvature power spectrum~@Dandoy:2023jot @Franciolini:2023pbf @Franciolini:2023wjm. Relieving the tension would require PBH production to be suppressed by specific non-gaussianities~@Franciolini:2023pbf or modifications to cosmology at the time of the QCD phase transition~@Balaji:2023ehk.


// [figvision-cn] imgs/Pos_SIGW_LN.png
// 本图为一张 3×3 的角图（corner plot），展示 SIGW 模型对
// NG15 数据拟合的后验概率分布。图中涉及三个参数：log10(k
// */Mpc⁻¹)、log10 A 和 Δ。对角线为三个参数的一维边缘后验
// 概率分布直方图，非对角线为两两参数的二维联合后验概率分
// 布等高线图。 子图 (a)：位于第一行第一列，是一维边缘后
// 验概率分布直方图，横轴为 log10(k*/Mpc⁻¹)，范围约 6.6
// 至 8.6，纵轴未标注但表示概率密度。蓝色阶梯线表示后验概
// 率密度，峰值大致出现在 7.8–8.0 之间。两条蓝色竖直虚线
// 标出 1σ 置信区间边界，上方标注文字“[7.7, 8.6]”给出该区
// 间数值。 子图 (b)：位于第二行第一列，是 log10(k*/Mpc⁻¹
// ) 与 log10 A 的二维联合后验概率分布等高线图，横轴为
// log10(k*/Mpc⁻¹)，范围约 6.6 至 8.6；纵轴为 log10 A，范
// 围约 −0.4 至 −1.6。填充颜色由浅灰至深蓝表示后验概率密
// 度由低到高，蓝色实线等高线勾勒不同置信水平。左下角有一
// 条黑色虚线曲线，旁边标注文字“PBH overproduction”，表示
// 该曲线以下区域被 PBH 过度产生限制排除。图中趋势显示，
// 随着 log10(k*/Mpc⁻¹) 增大，log10 A 的允许范围向较大值
// 移动，两者存在正相关。 子图 (c)：位于第二行第二列，是
// 一维边缘后验概率分布直方图，横轴为 log10 A，范围约 −
// 2.0 至 −0.5，纵轴未标注但表示概率密度。蓝色阶梯线表示
// 后验概率密度，峰值大致出现在 −0.9 至 −0.7 之间。两条蓝
// 色竖直虚线标出 1σ 置信区间边界，右上方标注文字“[−0.88,
// −0.094]”给出该区间数值。 子图 (d)：位于第三行第一列，
// 是 log10(k*/Mpc⁻¹) 与 Δ 的二维联合后验概率分布等高线图，
// 横轴为 log10(k*/Mpc⁻¹)，范围约 6.6 至 8.6；纵轴为 Δ，
// 范围约 0.6 至 3.0。填充颜色由浅灰至深蓝表示后验概率密
// 度由低到高，蓝色实线等高线勾勒不同置信水平。图中趋势显
// 示，随着 Δ 增大，log10(k*/Mpc⁻¹) 的允许范围向较大值移
// 动，两者存在正相关。 子图 (e)：位于第三行第二列，是
// log10 A 与 Δ 的二维联合后验概率分布等高线图，横轴为
// log10 A，范围约 −2.0 至 −0.5；纵轴为 Δ，范围约 0.6 至
// 3.0。填充颜色由浅灰至深蓝表示后验概率密度由低到高，蓝
// 色实线等高线勾勒不同置信水平。图中有一条黑色粗虚线斜穿
// 左下区域，未标注具体含义。图中趋势显示，随着 Δ 增大，
// log10 A 的允许范围向较大值移动，两者存在正相关。 子图
// (f)：位于第三行第三列，是一维边缘后验概率分布直方图，
// 横轴为 Δ，范围约 0.6 至 3.0，纵轴未标注但表示概率密度。
// 蓝色阶梯线表示后验概率密度，峰值出现在 1.2 附近，随后
// 向高值方向快速衰减。一条蓝色竖直虚线标出 1σ 置信区间边
// 界，右上方标注文字“[0.2, 1.3]”给出该区间数值。
#figure(image("imgs/Pos_SIGW_LN.png", width: 100%),
  caption: [
    The posterior probability distribution of the SIGW fit to the NG15 data. The black shaded region indicates where $f_(upright("PBH")) > 1$, while the black dashed lines bracket the 1$sigma$ ranges in the marginalised direction.
  ]
)
<fig:SIGWonly_posteriors>



The present-day SIGW background would have a spectrum given by @eq:OmegaGWtoday, where~@Inomata:2019yww @DeLuca:2019ufz @Yuan:2019fwv @Domenech:2020xin $ Omega_(upright("GW")) ( T ) = 1 / 3 integral_1^oo upright(d) t integral_(- 1)^1 upright(d) s frac(overline(J^2 ( u , v )), ( u v )^2) cal(P)_zeta ( v k ) cal(P)_zeta ( u k ) , $<eq:P_h_ts> where $u = ( t + s ) / 2$, $v = ( t - s ) / 2$ and the transfer function $overline(J^2 ( u , v ))$ depends on the cosmological background~@Kohri:2018awv @Espinosa:2018eve. The relevant calculations are reported in Appendix~#ref(<app:NGSIGW>, supplement: none), including higher-order corrections to the SIGW signal that arise in the event of non-Gaussian curvature perturbations.


A broad class of primordial curvature spectra can be characterized by a log-normal (LN) shape of the form $ cal(P)_zeta ( k ) = frac(A, sqrt(2 pi) Delta) thin exp (- frac(1, 2 Delta^2) ln^2 ( k / k_(*) )) thin . $<eq:PLN> The SIGW model therefore has three relevant parameters: the characteristic scale $k_(*) / upright("Mpc")^(- 1)$, the peak amplitude $A$, and the width $Delta$.~#footnote[Similar results are obtained if one assumes a broken power-law power spectrum of the form inspired by inflection-point inflationary models. See Ref.~@Franciolini:2023pbf for an in-depth discussion.] The distributions of their posterior values and two-parameter correlations for fits to the NG15 data assuming only scalar-induced second-order GWs are shown in @fig:SIGWonly_posteriors. The best-fit values of the SIGW model parameters are: $ log_10 ( k_(*) / upright("Mpc")^(- 1) ) = 7.7 thin , quad log_10 A = - 1.2 thin , quad Delta = 0.21 $<eq:bestfitSIGW> for which $- 2 Delta ell = - 2.1$.


// [figvision-cn] imgs/Pos_SMBHs_SIGW_LN.png
// 这是一张包含六个参数的一维边缘后验分布图和二维联合后验
// 分布图（角图，corner plot），共包含21个子图，按5行5列
// 的上三角加对角线布局排列，具体为：第1行1个子图（对角），
// 第2行2个子图（1个对角+1个二维），第3行3个子图，第4行4
// 个子图，第5行5个子图，第6行5个子图（含1个对角+4个二维）。
// 图中参数依次为 pBH、α、fref/nHz、log10(k*/Mpc⁻¹)、
// log10A、Δ。所有二维子图使用蓝色填充等高线表示后验概率
// 密度，颜色由浅蓝到深蓝分别对应约1σ和2σ置信区间；所有一
// 维子图使用蓝色阶梯状直方图表示边缘后验概率密度，垂直虚
// 线标出16%、50%、84%分位数，子图顶部方括号内给出68%置信
// 区间。 对角子图（从上到下、从左到右）： 第1行第1列：一
// 维直方图，横轴为 pBH，范围0.0至1.0，刻度0.2、0.4、0.6、
// 0.8；纵轴为概率密度（无刻度）。直方图分布较宽，顶部标
// 注[0.25, 0.79]，垂直虚线约在0.25、0.50、0.79处。趋势表
// 明pBH后验较宽且偏向中等值。 第2行第2列：横轴为 α，范围
// 0.0至6.0，刻度1.5、3.0、4.5、6.0；顶部标注[1.4, 4.1]，
// 垂直虚线约在1.4、2.8、4.1处，分布峰值约在2.5附近，右尾
// 较长。 第3行第3列：横轴为 fref/nHz，范围0至40，刻度8、
// 16、24、32；顶部标注[14, 32]，垂直虚线约在14、22、32处，
// 分布峰值约在20 nHz附近，右尾延伸至40 nHz。 第4行第4列：
// 横轴为 log10(k*/Mpc⁻¹)，范围6.0至10.0，刻度6.4、7.2、
// 8.0、8.8、9.6；顶部标注[7.8, 10]，垂直虚线约在7.8、8.9、
// 10处，分布较宽，峰值约在8.5—9.0之间。 第5行第5列：横轴
// 为 log10A，范围-2.8至-0.4，刻度-2.4、-1.8、-1.2、-0.6；
// 顶部标注[-3, -1.2]（实际横轴下限约-2.8），垂直虚线约在
// -2.5、-1.8、-1.2处，分布峰值约在-1.8附近，左侧尾部较缓。
// 第6行第6列：横轴为 Δ，范围0.0至3.6，刻度0.6、1.2、1.8、
// 2.4、3.0；顶部标注[0.2, 3.2]，垂直虚线约在0.2、1.5、
// 3.2处，分布较宽，峰值约在1.5附近。 二维子图（行、列对
// 应参数）： 第2行第1列：横轴 pBH，纵轴 α（范围0.0至6.0，
// 刻度1.5、3.0、4.5、6.0）。等高线显示pBH与α存在弱正相关，
// 高概率区域在pBH 0.2—0.7、α 2—4.5之间。 第3行第1列：横
// 轴 pBH，纵轴 fref/nHz（范围0至40，刻度8、16、24、32）。
// 高概率区域在pBH 0.2—0.8、fref 10—30 nHz之间，相关性不
// 明显。 第3行第2列：横轴 α，纵轴 fref/nHz。高概率区域在
// α 1.5—4.5、fref 10—30 nHz之间，呈弱正相关。 第4行第1列：
// 横轴 pBH，纵轴 log10(k*/Mpc⁻¹)（范围6.0至10.0，刻度6.4、
// 7.2、8.0、8.8、9.6）。高概率区域在pBH 0.2—0.8、log10k*
// 7.5—9.5之间。 第4行第2列：横轴 α，纵轴 log10(k*/Mpc⁻¹)。
// 高概率区域在α 1.5—4.5、log10k* 7.5—9.5之间，无明显相关。
// 第4行第3列：横轴 fref/nHz，纵轴 log10(k*/Mpc⁻¹)。高概
// 率区域在fref 10—30 nHz、log10k* 7.5—9.5之间，呈弱负相
// 关。 第5行第1列：横轴 pBH，纵轴 log10A（范围-2.8至-0.4，
// 刻度-2.4、-1.8、-1.2、-0.6）。高概率区域在pBH 0.2—0.8、
// log10A -2.5—-1.3之间。 第5行第2列：横轴 α，纵轴 log10A。
// 高概率区域在α 1.5—4.5、log10A -2.5—-1.3之间。 第5行第3
// 列：横轴 fref/nHz，纵轴 log10A。高概率区域在fref 10—30
// nHz、log10A -2.5—-1.3之间。 第5行第4列：横轴 log10(k*/
// Mpc⁻¹)，纵轴 log10A。高概率区域在log10k* 7.5—9.5、
// log10A -2.5—-1.3之间。图中标注虚线框“PBH
// overproduction”，对应log10k*约7.8—8.8、log10A约-2.4—
// -1.6区域，表示该区域被PBH过度产生限制排除。 第6行第1列：
// 横轴 pBH，纵轴 Δ（范围0.0至3.6，刻度0.6、1.2、1.8、2.4、
// 3.0）。高概率区域在pBH 0.2—0.8、Δ 0.5—3.0之间。 第6行
// 第2列：横轴 α，纵轴 Δ。高概率区域在α 1.5—4.5、Δ 0.5—
// 3.0之间。 第6行第3列：横轴 fref/nHz，纵轴 Δ。高概率区
// 域在fref 10—30 nHz、Δ 0.5—3.0之间。 第6行第4列：横轴
// log10(k*/Mpc⁻¹)，纵轴 Δ。高概率区域在log10k* 7.5—9.5、
// Δ 0.5—3.0之间。 第6行第5列：横轴 log10A，纵轴 Δ。图中
// 有一条黑色粗虚线斜穿等高线区域，从约(log10A=-2.3, Δ=
// 0.3)延伸至(log10A=-1.2, Δ=3.2)，表示Δ与log10A之间存在
// 正相关趋势，高概率区域集中在虚线附近。 总体趋势：各参
// 数后验分布均较宽，pBH、α、fref、log10k*、log10A、Δ之间
// 未见强简并，仅Δ与log10A呈现一定正相关；图中标注的PBH
// overproduction区域在log10k*—log10A平面上排除了部分高概
// 率参数空间。
#figure(image("imgs/Pos_SMBHs_SIGW_LN.png", width: 100%),
  caption: [
    As in @fig:SIGWonly_posteriors for a SIGW fit to NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:SIGW_posteriors>



We also show in @fig:SIGWonly_posteriors the regions of parameter space where PBHs are overproduced. We compute their abundance following the prescription given in Refs. @DeLuca:2019qsy @Young:2019yug @Germani:2019zez @Ferrante:2022mui. In order to compute the abundance more precisely we also include the effects of the QCD phase transition and the shape of the power spectrum in the parameters, following Refs. @Musco:2020jjb @Franciolini:2022tfm @Musco:2023dak. As already pointed out in @Franciolini:2023pbf, the tension between the NANOGrav data and a scenario with the SIGW signal alone can be relaxed in models where large non-Gaussianities suppress the PBH abundance, or if the PBH formation take place during non standard cosmological phases deviating from radiation domination @Balaji:2023ehk @Zhao:2023joc @Liu:2023pau. Our results differ from those in Refs. @Inomata:2023zup @Figueroa:2023zhu @Yi:2023mbm @Firouzjahi:2023lzg @You:2023rmn @Zhao:2023joc. This discrepancy comes from several limitations of the analyses in these papers, such as the omission of critical collapse and the nonlinear relationship between curvature perturbations and density contrast, the adoption of a different value for the threshold (independently from the curvature power spectrum), and the use of a different window function, without properly recomputing the threshold values @Young:2019osy.~#footnote[When computing the PBH abundance in this work we have adopted the best prescription available following Ref.~@Franciolini:2023pbf and references therein. We mention that Ref. @DeLuca:2023tun (see, however, also @Germani:2023ojx) suggested that super-horizon threshold conditions may lead to an overestimation of the abundance, due to non-linear effects not included in the linear transfer function.]


@fig:SIGW_posteriors shows a full set of posterior parameter distribution functions and two-parameter correlations for the fit to a combination of scalar-induced second-order GWs and SMBH binaries. The preferred values of the SIGW model parameters are similar to those in the SIGW-only fit, but their distributions are significantly broader, as was to be expected. The best-fit parameters of the combined model are $
& log_10 ( k_(*) upright("Mpc")^(- 1) ) = 7.6 thin quad log_10 A = - 1.2 thin quad Delta = thin 0.30 thin \
 & p_(upright("BH")) = 0.06 thin quad f_(upright("ref")) = 26 thin upright("nHz") thin quad alpha = 4.1 thin .
$


The best-fit parameters describing the SIGW sector in the mixed scenario are very similar to those reported in @eq:bestfitSIGW, where SIGWs alone are assumed to explain PTA observations. This is because the SIGW model provides a better fit, and dominates the signal where the likelihood peaks. However, neither of the two models dominates over the other beyond the $tilde 2 sigma$ level, maintaining the large degeneracy of most parameters in the posterior distributions shown in @fig:SIGW_posteriors.


Imposing a lower bound on $p_(upright("BH"))$ forcing the SMBHs model to produce the candidate event at $4$nHz with probability larger than $5 "%"$, we find instead that the astrophysical channel is required to dominate, and the best fit parameters are $
& log_10 ( k_(*) upright("Mpc")^(- 1) ) = 6.3 thin quad log_10 A = - 2.2 thin quad Delta = thin 0.21 thin \
 & p_(upright("BH")) = 0.70 thin quad f_(upright("ref")) = 24 thin upright("nHz") thin quad alpha = 3.8 thin .
$ with a maximum likelihood similar to the SMBHs-only scenario (with enviromental effects included), resulting in $- 2 Delta ell = - 0.4$.


== First-order GWs
<sec:FOGWs>


Another mechanism for generating a cosmological SGWB is during inflation via first-order GWs (FOGWs)~@Grishchuk:1974ny @Starobinsky:1979ty. We consider canonically normalized single-field slow-roll models, which predict a primordial tensor power spectrum that, in the relevant range of frequencies between the CMB and PTA scales, can be approximated by a pure power-law @NANOGrav:2023hvm: $ Omega_(upright("GW")) ( f ) = frac(r A_s, 24) (f / f_(upright("CMB")))^(n_t) cal(T) ( f ) thin , $<eq:FO> where $f_(upright("CMB")) = 7.7 times 10^(- 17)$ Hz, $A_s = 2.1 times 10^(- 9)$~@Planck:2018vyg, $n_t$ is the tensor spectral index and $r$ is the tensor-to-scalar ratio. The transfer function that connects the radiation-dominated era to reheating can be approximated as~@Kuroyanagi:2014nba @Kuroyanagi:2020sfw $ cal(T) ( f ) approx frac(Theta (f_(upright("end")) - f), 1 - 0.22 (f / f_(upright("rh")))^1.5 + 0.65 (f / f_(upright("rh")))^2) thin , $ where $f_(upright("end"))$ and $f_(upright("rh")) lt.eq f_(upright("end"))$ correspond, respectively, to the end of inflation and to the end of reheating. For simplicity, we assume that the cut-off scale is $f_(upright("end")) gt.double f_(upright("rh")) = f_H ( T_(upright("rh")) )$. In this way, the analysis is independent of the choice of the cutoff.


// [figvision-cn] imgs/Pos_FOGW_only.png
// 该图是一幅三角图（corner plot），由六个子图按三行三列
// 布局排列，用于展示三个参数的后验概率分布及其两两相关性。
// 三个参数分别为：log10(Trh/GeV)（横轴，子图a、d、e、f），
// 范围约-1.8至0.8；log10 r（纵轴，子图b、d；横轴，子图e），
// 范围约-30至0；nt（纵轴，子图c、e；横轴，子图f），范围
// 约0.0至4.5。所有子图中的红色粗实线阶梯状轮廓表示后验概
// 率分布，红色实心填充区域由外向内颜色逐渐加深，代表不同
// 置信水平（通常为50%、90%等），红色虚线表示边界值。 子
// 图a（左上，一维直方图）：横轴为log10(Trh/GeV)，纵轴为
// 概率密度（无刻度）。红色阶梯曲线在-0.8附近达到峰值，向
// 两侧衰减。两条红色垂直虚线分别位于-1.8和-0.12处，上方
// 标注区间[-1.8, -0.12]。 子图b（左中，二维等高线图）：
// 纵轴为log10 r，横轴为log10(Trh/GeV)。红色填充等高线显
// 示两者呈正相关趋势，即log10 r随log10(Trh/GeV)增加而增
// 加。一条黑色实心曲线从左上向右下弯曲，其右侧区域被灰色
// 阴影填充。黑色虚线从图左侧向右上方延伸，与红色等高线区
// 域相交。 子图c（左下，二维等高线图）：纵轴为nt，横轴为
// log10(Trh/GeV)。红色填充等高线显示两者呈负相关趋势，即
// nt随log10(Trh/GeV)增加而减小。一条黑色虚线从左上向右下
// 弯曲，与红色等高线区域相交。右上角标注“ΔNeff”。 子图d
// （中上，一维直方图）：横轴为log10 r，纵轴为概率密度。
// 红色阶梯曲线呈双峰结构，主峰在-20附近，次峰在-8附近。
// 两条红色垂直虚线分别位于-25和-8.2处，上方标注区间[-25,
// -8.2]。 子图e（中中，二维等高线图）：纵轴为nt，横轴为
// log10 r。红色填充等高线显示两者呈负相关趋势，即nt随
// log10 r增加而减小。一条黑色虚线从左上向右下穿过等高线
// 中心区域。 子图f（中右，一维直方图）：横轴为nt，纵轴为
// 概率密度。红色阶梯曲线在1.5附近有一个主峰，在3.0至4.5
// 之间有一个较宽的次峰。两条红色垂直虚线分别位于1.8和4.1
// 处，上方标注区间[1.8, 4.1]。 整体趋势：log10(Trh/GeV)
// 与log10 r正相关，与nt负相关；log10 r与nt负相关。黑色实
// 线、虚线及灰色阴影区域表示在特定假设下的边界约束，与红
// 色后验分布区域存在部分重叠。
#figure(image("imgs/Pos_FOGW_only.png", width: 100%),
  caption: [
    The posterior probability distribution of the FOGW fit to the NG15 data. The black-shaded region shows the constraints by $Delta N_(upright("eff"))$ bound in @eq:deltaN, assuming $f_(upright("end")) = f_(upright("rh"))$ (solid line) and $f_(upright("end")) = 10 f_(upright("rh"))$ (dashed line). We also show the $r - n_t$ correlation @eq:nt-rcorr in the corresponding panel.
  ]
)
<fig:FOGWonly_posteriors>



The FOGW scenario is parametrized by the inflationary parameters $n_t$ and $r$, and the reheating temperature $T_(upright("rh"))$. As seen in the left panel of @fig:FOGWonly_posteriors, their values are very tightly correlated, and their best-fit values are $ T_(upright("rh")) = - 0.67 thin upright("GeV") thin , quad log_10 r = - 14 thin , quad n_t thin = thin 2.6 $<eq:figwalone_bestfit> for which $- 2 Delta ell = - 2.0$.


A constraint on the possible values of these parameters is given by the SGWB contribution to the radiation energy budget characterized by $Delta N_(upright("eff"))$, i.e. its contribution to the effective number of relativistic species. $Delta N_(upright("eff"))$ is constrained by BBN and CMB probes, and an approximate upper limit is given by $Delta N_(upright("eff")) lt.tilde 0.3$~@Planck:2018vyg @Fields:2019pfx. The GW spectrum, integrated from BBN scales to the cutoff frequency $f_(upright("end"))$, must not exceed an upper limit that is set by the allowed amount of extra relativistic degrees of freedom at the time of BBN and recombination. This contribution is given~@Smith:2006nka @Boyle:2007zx $ 1.8 times 10^5 integral_(f_(upright("BBN")))^(f_(upright("end"))) frac(upright(d) f, f) Omega_(upright("GW")) ( f ) h^2 lt.tilde Delta N_(upright("eff"))^max $<eq:deltaN> where we set $f_(upright("BBN")) tilde.eq 10^(- 12)$~Hz, which is the frequency at horizon re-entry of tensor mode around the onset of BBN at $T tilde.eq 10^(- 4)$ GeV @Caprini:2018mtu. For a slope compatible with the NANOGrav data, the signal cannot extend to excessively high frequencies, as doing so would violate constraints imposed by BBN @Maggiore:1999vm @Pagano:2015hma. For these reasons, we limit our analysis to the range $T_(upright("rh")) in \[ 0.01 , 10 \]$ $upright("GeV")$. As can be seen from @fig:FOGWonly_posteriors, if the reheating temperature is $lt.tilde 0.3$ GeV the preferred signal changes the tilt moving from $n_t$ to $n_t - 2$. This is because, for such values of the temperature, the cut-off of the signal is at a lower frequency than the last NANOGrav bin, and the GW spectrum in the PTA band is composed of tensor modes that re-entered the horizon during reheating after inflation. When deriving the constraint from the bound on $Delta N_(upright("eff"))$, we find that $n_t$ and $r$ are strongly correlated, and the equation that relates these quantities can be approximated by $ n_t = - 0.14 log_10 r + 0.58 . $<eq:nt-rcorr> Using this last relation we constrain the parameter space as shown in @fig:FOGWonly_posteriors and @fig:FOGWSMBH_posteriors.


// [figvision-cn] imgs/Pos_FOGW_SMBH.png
// 这是一张六参数贝叶斯推断的角图（corner plot），由6个参
// 数两两组合构成的21个子图组成，呈下三角布局。右上三角区
// 域为空，对角线上为6个一维边缘后验概率分布直方图，非对
// 角线为15个二维联合后验概率等高线图。所有子图均使用红色
// 系配色。整体用于展示FOGW模型拟合NG15数据并纳入环境效应
// 下的超大质量双黑洞（SMBH binaries）参数约束结果。 子图
// a（第1行第1列）：一维边缘后验直方图。横轴为p_BH，无量
// 纲，范围约0.0至1.0；纵轴为概率密度（无标注单位）。阶梯
// 状红色直方图显示后验分布，顶部标注95%置信区间[0.26,
// 0.77]，两条红色竖直虚线分别位于0.26和0.77处。分布呈单
// 峰，峰值约在0.5附近，右侧尾部略高于左侧。 子图b（第2行
// 第1列）：二维联合后验等高线图。横轴p_BH（0.0至1.0），
// 纵轴α（约1.5至6.0）。红色填充等高线由深红（高概率密度）
// 到浅粉（低概率密度）渐变，中心高密度区位于p_BH约0.4至
// 0.6、α约2.5至4.5之间，呈向右上方倾斜的椭圆状。等高线显
// 示p_BH与α存在弱正相关。 子图c（第2行第2列）：一维边缘
// 后验直方图。横轴α，范围约1.5至6.0；纵轴概率密度。阶梯
// 状红色直方图，顶部标注[1.4, 3.7]，两条红色竖直虚线位于
// 1.4和3.7处。分布峰值约在2.5至3.0之间，右侧尾部较长。
// 子图d（第3行第1列）：二维联合后验等高线图。横轴p_BH（
// 0.0至1.0），纵轴f_ref/nHz（约8至32）。红色填充等高线，
// 高密度区位于p_BH约0.3至0.7、f_ref约12至28 nHz，呈向右
// 上倾斜的椭圆。显示p_BH与f_ref存在正相关趋势。 子图e（
// 第3行第2列）：二维联合后验等高线图。横轴α（1.5至6.0），
// 纵轴f_ref/nHz（8至32）。红色填充等高线，高密度区位于α
// 约2.0至4.0、f_ref约12至26 nHz，呈向右上倾斜的椭圆。显
// 示α与f_ref存在正相关。 子图f（第3行第3列）：一维边缘后
// 验直方图。横轴f_ref/nHz，范围约8至32；纵轴概率密度。阶
// 梯状红色直方图，顶部标注[12, 30]，两条红色竖直虚线位于
// 12和30处。分布峰值约在18至20 nHz，右侧尾部较长。 子图g
// （第4行第1列）：二维联合后验等高线图。横轴p_BH（0.0至
// 1.0），纵轴log10(T_Rh/GeV)（约-1.6至1.6）。红色填充等
// 高线，高密度区呈竖直带状，覆盖整个p_BH范围，log10(T_Rh
// /GeV)约在-0.4至1.2之间。显示p_BH与log10(T_Rh/GeV)无明
// 显相关。 子图h（第4行第2列）：二维联合后验等高线图。横
// 轴α（1.5至6.0），纵轴log10(T_Rh/GeV)（-1.6至1.6）。红
// 色填充等高线，高密度区呈竖直带状，覆盖整个α范围，log10
// (T_Rh/GeV)约在-0.4至1.2之间。显示α与log10(T_Rh/GeV)无
// 明显相关。 子图i（第4行第3列）：二维联合后验等高线图。
// 横轴f_ref/nHz（8至32），纵轴log10(T_Rh/GeV)（-1.6至1.6）。
// 红色填充等高线，高密度区呈竖直带状，覆盖整个f_ref范围，
// log10(T_Rh/GeV)约在-0.4至1.2之间。显示f_ref与log10(
// T_Rh/GeV)无明显相关。 子图j（第4行第4列）：一维边缘后
// 验直方图。横轴log10(T_Rh/GeV)，范围约-1.6至1.6；纵轴概
// 率密度。阶梯状红色直方图，顶部标注[-2, 2]，两条红色竖
// 直虚线位于-2和2处。分布近似均匀，在-2至2之间较为平坦，
// 两端略有下降。 子图k（第5行第1列）：二维联合后验等高线
// 图。横轴p_BH（0.0至1.0），纵轴log10 r（约-32至-8）。红
// 色填充等高线，高密度区呈竖直带状，覆盖整个p_BH范围，
// log10 r约在-28至-14之间，中心在-24至-20附近。显示p_BH
// 与log10 r无明显相关。 子图l（第5行第2列）：二维联合后
// 验等高线图。横轴α（1.5至6.0），纵轴log10 r（-32至-8）。
// 红色填充等高线，高密度区呈竖直带状，覆盖整个α范围，
// log10 r约在-28至-14之间。显示α与log10 r无明显相关。 子
// 图m（第5行第3列）：二维联合后验等高线图。横轴f_ref/nHz
// （8至32），纵轴log10 r（-32至-8）。红色填充等高线，高
// 密度区呈竖直带状，覆盖整个f_ref范围，log10 r约在-28至
// -14之间。显示f_ref与log10 r无明显相关。 子图n（第5行第
// 4列）：二维联合后验等高线图。横轴log10(T_Rh/GeV)（-1.6
// 至1.6），纵轴log10 r（-32至-8）。红色填充等高线，高密
// 度区位于log10(T_Rh/GeV)约-0.4至0.8、log10 r约-28至-16
// 之间，呈向右下倾斜的椭圆。图中叠加了一条黑色虚线曲线，
// 从左上（log10(T_Rh/GeV)≈-0.8, log10 r≈-12）向右下（
// log10(T_Rh/GeV)≈1.2, log10 r≈-30）延伸。显示log10(T_Rh
// /GeV)与log10 r存在负相关。 子图o（第5行第5列）：一维边
// 缘后验直方图。横轴log10 r，范围约-32至-8；纵轴概率密度。
// 阶梯状红色直方图，顶部标注[-35, -17]，两条红色竖直虚线
// 位于-35和-17处。分布峰值约在-24至-20之间，左侧尾部较长
// 至-32，右侧尾部至-10附近。 子图p（第6行第1列）：二维联
// 合后验等高线图。横轴p_BH（0.0至1.0），纵轴n_t（约1.5至
// 4.5）。红色填充等高线，高密度区呈水平带状，覆盖整个
// p_BH范围，n_t约在2.5至4.0之间。显示p_BH与n_t无明显相关。
// 子图q（第6行第2列）：二维联合后验等高线图。横轴α（1.5
// 至6.0），纵轴n_t（1.5至4.5）。红色填充等高线，高密度区
// 呈水平带状，覆盖整个α范围，n_t约在2.5至4.0之间。显示α
// 与n_t无明显相关。 子图r（第6行第3列）：二维联合后验等
// 高线图。横轴f_ref/nHz（8至32），纵轴n_t（1.5至4.5）。
// 红色填充等高线，高密度区呈水平带状，覆盖整个f_ref范围，
// n_t约在2.5至4.0之间。显示f_ref与n_t无明显相关。 子图s
// （第6行第4列）：二维联合后验等高线图。横轴log10(T_Rh/
// GeV)（-1.6至1.6），纵轴n_t（1.5至4.5）。红色填充等高线，
// 高密度区呈水平带状，覆盖整个log10(T_Rh/GeV)范围，n_t约
// 在2.5至4.0之间。图中叠加了一条黑色虚线曲线，从左上（
// log10(T_Rh/GeV)≈-0.6, n_t≈4.2）向右下（log10(T_Rh/GeV)
// ≈1.2, n_t≈1.5）延伸。图中还标注了“ΔN_eff”文字及一个灰
// 色三角形区域。显示log10(T_Rh/GeV)与n_t存在弱负相关。
// 子图t（第6行第5列）：二维联合后验等高线图。横轴log10 r
// （-32至-8），纵轴n_t（1.5至4.5）。红色填充等高线，高密
// 度区呈向右下倾斜的椭圆，log10 r约-28至-14、n_t约2.0至
// 4.0。图中叠加了一条黑色虚线曲线，从左上（log10 r≈-28,
// n_t≈4.2）向右下（log10 r≈-12, n_t≈1.5）延伸。显示log10
// r与n_t存在负相关。 子图u（第6行第6列）：一维边缘后验直
// 方图。横轴n_t，范围约1.5至4.5；纵轴概率密度。阶梯状红
// 色直方图，顶部标注[0, 2.3]，两条红色竖直虚线位于0和2.3
// 处。分布呈单峰，峰值约在2.0至2.5之间，右侧尾部较长至
// 4.5。 整体趋势：p_BH、α、f_ref三者之间存在弱正相关；
// log10 r与log10(T_Rh/GeV)、n_t分别呈负相关；p_BH、α、
// f_ref与log10(T_Rh/GeV)、log10 r、n_t之间无明显相关性。
// 各参数的一维边缘后验均给出了95%置信区间。
#figure(image("imgs/Pos_FOGW_SMBH.png", width: 100%),
  caption: [
    Same as @fig:FOGWonly_posteriors for a FOGW fit to NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:FOGWSMBH_posteriors>



Our results are in perfect agreement with Refs.~@NANOGrav:2023hvm @Vagnozzi:2023lwo. @fig:FOGWSMBH_posteriors shows a full set of posterior parameter distribution functions and three-parameter correlations for the fit to a combination of FOGWs and SMBH binaries. The best fit of the combined models results in


$- 2 Delta ell = - 1.9$ with $p_(upright("BH")) tilde.eq 0$. Thus, the FIGW contribution is dominant, and the best-fit parameter of the FIGW sector coincides with those reported in @eq:figwalone_bestfit, assuming no SMBH contribution. Imposing a lower bound on $p_(upright("BH"))$ to produce the candidate SMBH merger at $4$nHz, we find instead $
& T_(upright("rh")) = 1.5 thin upright("GeV") thin quad log_10 r = - 9.1 thin quad n_t thin = thin 1.46 thin \
 & p_(upright("BH")) = 0.35 thin quad f_(upright("ref")) = 16 thin upright("nHz") thin quad alpha = 4.7 thin .
$ with resulting in $- 2 Delta ell = - 0.1$.


== “Audible” axions
<sec:axions>


// [figvision-cn] imgs/Pos_aa.png
// 该图由三个子图组成，呈倒L形布局，展示可听轴子（audible
// axion）模型对NG15数据的拟合结果。整体图注说明阴影区域
// 为超辐射约束排除的区域。 子图a（左上）：一维边缘后验概
// 率分布直方图，横轴为log10(ma/eV)，范围从-14到-10；纵轴
// 为概率密度（未标注刻度）。橙色阶梯状实线表示后验分布，
// 在约-13.3处有一个窄峰，随后下降至约-12.5处形成谷，然后
// 上升至约-10.7处形成主峰。两条橙色垂直虚线分别位于约
// -13.3和-10.7处，标示分布的边界或特征位置。图上方标注区
// 间[-13, -10]。该图显示轴子质量的后验分布具有双峰特征。
// 子图b（左下）：二维后验概率等高线图，横轴为log10(ma/eV
// )，范围-14至-10；纵轴为log10(fa/Mp)，范围-0.8至0（刻度
// 标注为-0.8、-0.6、-0.4、-0.2）。橙色等高线（由浅至深）
// 表示不同置信水平的后验概率密度，分布呈从左下（约-14,
// -0.75）向右上（约-10, -0.1）延伸的条带状，与纵轴呈负相
// 关。图中央灰色阴影区域覆盖横轴约-13.3至-10.7的范围，内
// 部垂直标注“Superradiance”文字，表示超辐射约束排除的区
// 域。该图显示fa/Mp与ma之间存在明显的退化关系，且超辐射
// 约束排除了大部分高质量区域。 子图c（右下）：一维边缘后
// 验概率分布直方图，横轴为log10(fa/Mp)，范围-0.8至-0.2；
// 纵轴为概率密度（未标注刻度）。橙色阶梯状实线表示后验分
// 布，在约-0.6处有一个峰，随后在约-0.5处下降，然后向-0.2
// 方向持续上升。一条橙色垂直虚线位于约-0.45处，标示特征
// 位置。图上方标注区间[-0.41, -0]。该图显示fa/Mp的后验分
// 布偏向较大值，且存在一个局部峰。
#figure(image("imgs/Pos_aa.png", width: 100%),
  caption: [
    The posterior probability distribution of the “audible” axion fit to the NG15 data. The shaded region is excluded by super-radiance constraints.
  ]
)
<fig:Axion_posteriors>



In models in which an axion or an axion-like particle has a weak coupling to the SM, thanks to a coupling to a light dark photon, a SGWB can be produced~@Machado:2018nqk @Machado:2019xuc @Co:2021rhi @Fonseca:2019ypl @Chatrchyan:2020pzh @Ratzinger:2020oct @Eroncel:2022vjg. After the axion begins to roll, it induces a tachyonic instability for one of the dark photon helicities, causing vacuum fluctuations to grow exponentially. This effect generates time-dependent anisotropic stress in the energy-momentum tensor, which ultimately sources GWs. In this scenario, the condition of having a coupling with a dark photon and not with the SM photon is due to the fact that the latter undergoes rapid thermalization that would destroy the conditions required for exponential particle production.#footnote[GWs can also be produced in kinetic misalignment scenarios (in which the axion field has a nonzero initial velocity) also in the absence of dark photons. As shown in @Machado:2019xuc the resulting signal in this scenario is, however, in general too small to be observable in the foreseeable future.] The GW formation ends when the tachyonic band closes at temperature~@Machado:2018nqk $ T_(*) approx frac(1.2 sqrt(m_a M_(upright(P))), g_(*)^(1 / 4) ( alpha theta )^(2 / 3)) thin , $ where $alpha$ is the coupling with the dark photon, $theta$ is the initial misalignment angle, and $m_a$ is the mass of the axion. As shown in~@Machado:2019xuc, assuming that between the beginning of the axion oscillations and the end of the GW formation, the effective number of degrees of freedom does not change, the GW spectrum at temperature $T_(*)$ can be fitted by $ Omega_(upright("GW")) ( f , T_(*) ) = frac(6.3 (f_a / M_(upright(P)))^4 (theta^2 / alpha)^(4 / 3) S_H ( f , f_H ( T_(*) ) ), [frac(f, 2.0 f_p)]^(#h(-1em) - 1.5) + exp #h(-1em) [12.9 (frac(f, 2.0 f_p) - 1)]) thin , $<eq:OmegaAa> where $f_a$ is the decay constant of the axion and the peak frequency of the spectrum is $ f_p approx 2.5 ( alpha theta )^(4 / 3) f_H ( T_(*) ) thin . $ Compared to the fit in~@Machado:2019xuc, we have added the function $S_H ( f , f_H )$ that accounts for the causality tail of the spectrum at frequencies $f < f_H ( T_(*) )$ and is given by @eq:SH with $a = 1.5$. We set the parameter $delta$ in $S_H ( f , f_H )$ to $delta = 1$. Typical values for the initial misalignment angle are of $theta tilde cal(O) ( 1 )$  @DiLuzio:2020wdo @Marsh:2015xka and @eq:OmegaAa holds only for $theta tilde 1$ and $alpha gt.eq 10$, the range of values where the particle production process is efficient @Agrawal:2017eqm. For simplicity, we fix $theta = 1$ and $alpha = 20$ in the analysis.


// [figvision-cn] imgs/Pos_aa_SMBH.png
// 这是一张由十五个子图组成的下三角相关矩阵图（角图），用
// 于展示五个参数的后验概率分布及两两之间的联合分布。所有
// 子图均使用橙色系：一维直方图为橙色阶梯线，二维等高线图
// 为浅橙至深橙的填充等高线（深色区域表示高概率密度），并
// 配有深橙色实线等高线边界。每个一维直方图顶部标注了参数
// 名称及括号内的数值范围（表示95%置信区间），直方图内包
// 含两条垂直橙色虚线，标示该区间的上下边界。 第一行第一
// 列（最左上）子图：一维阶梯直方图，横轴为p_BH，范围约
// 0.2至0.8，纵轴为概率密度（无刻度标签）。顶部标注[0.27,
// 0.77]，两条垂直虚线分别位于0.27和0.77处。分布呈单峰，
// 峰值约在0.5附近。 第二行第一列子图：二维填充等高线图，
// 横轴为p_BH（0.2至0.8），纵轴为α（1.5至6.0）。等高线呈
// 宽缓的闭合环状，高概率密度区域集中在p_BH约0.4至0.7、α
// 约3.0至4.5的范围内。第二行第二列子图：一维阶梯直方图，
// 横轴为α，范围1.5至6.0，纵轴为概率密度。顶部标注[1.4,
// 3.7]，两条垂直虚线分别位于1.4和3.7处。分布呈单峰，峰值
// 约在2.5附近。 第三行第一列子图：二维等高线图，横轴为
// p_BH，纵轴为f_ref/nHz（8至32）。等高线呈从左下向右上延
// 伸的拉长闭合形状，高概率密度区域集中在f_ref约8至24 nHz、
// p_BH约0.2至0.5。第三行第二列子图：二维等高线图，横轴为
// α，纵轴为f_ref/nHz。高概率密度区域集中在α约3.0至4.5、
// f_ref约8至24 nHz。第三行第三列子图：一维阶梯直方图，横
// 轴为f_ref/nHz，范围8至32，纵轴为概率密度。顶部标注[12,
// 29]，两条垂直虚线分别位于12和29处。分布呈单峰，峰值约
// 在18 nHz附近。 第四行第一列子图：二维等高线图，横轴为
// p_BH，纵轴为log10(m_a/meV)（-14至-6）。等高线呈近乎垂
// 直的条带状，高概率密度区域集中在p_BH约0.3至0.5、log10(
// m_a/meV)约-12至-6。第四行第二列子图：二维等高线图，横
// 轴为α，纵轴为log10(m_a/meV)。高概率密度区域集中在α约
// 3.0至4.5、log10(m_a/meV)约-12至-6。第四行第三列子图：
// 二维等高线图，横轴为f_ref/nHz，纵轴为log10(m_a/meV)。
// 高概率密度区域集中在f_ref约12至24 nHz、log10(m_a/meV)
// 约-12至-6。第四行第四列子图：一维阶梯直方图，横轴为
// log10(m_a/meV)，范围-14至-6，纵轴为概率密度。顶部标注[
// -11, -5]，两条垂直虚线分别位于-11和-5处。分布呈阶梯上
// 升趋势后趋于平缓。 第五行第一列子图：二维等高线图，横
// 轴为p_BH，纵轴为log10(f_a/M_P)（-1.6至-0.4）。等高线呈
// 从左下向右上倾斜的椭圆形，高概率密度区域集中在p_BH约
// 0.3至0.5、log10(f_a/M_P)约-1.2至-0.8。第五行第二列子图：
// 二维等高线图，横轴为α，纵轴为log10(f_a/M_P)。高概率密
// 度区域集中在α约3.0至4.5、log10(f_a/M_P)约-1.2至-0.8。
// 第五行第三列子图：二维等高线图，横轴为f_ref/nHz，纵轴
// 为log10(f_a/M_P)。高概率密度区域集中在f_ref约12至24
// nHz、log10(f_a/M_P)约-1.2至-0.8。第五行第四列子图：二
// 维等高线图，横轴为log10(m_a/meV)，纵轴为log10(f_a/M_P)。
// 图中有一条从左上向右下延伸的灰色窄带，灰色区域内标注文
// 字“Superradiance”。等高线呈不规则形状，高概率密度区域
// 集中在log10(m_a/meV)约-12至-8、log10(f_a/M_P)约-1.2至
// -0.6。第五行第五列子图：一维阶梯直方图，横轴为log10(
// f_a/M_P)，范围-1.6至-0.4，纵轴为概率密度。顶部标注[-2,
// -0.85]，两条垂直虚线分别位于-2和-0.85处。分布呈右偏单
// 峰，峰值约在-1.0附近。 整体趋势：各参数的一维后验分布
// 均呈单峰或单调递增/递减形态，二维联合分布显示参数之间
// 存在一定的相关性，例如p_BH与α呈正相关趋势，f_ref与α呈
// 正相关趋势，而log10(m_a/meV)与log10(f_a/M_P)的联合分布
// 中标注了“Superradiance”灰色区域，表明该区域对应超辐射
// 机制。
#figure(image("imgs/Pos_aa_SMBH.png", width: 100%),
  caption: [
    As in @fig:Axion_posteriors for an “audible” axion fit to NG15 data including also SMBH binaries with environmental effects.
  ]
)
<fig:aaSMBH_posteriors>



// [figvision-cn] imgs/BFplots.png
// 这是一张单一面板的曲线图，没有子图划分。图表横轴为频率
// f，单位为赫兹（Hz），采用对数坐标，显示范围约从 1.2×10
// ⁻⁹ Hz 到 3.5×10⁻⁸ Hz，刻度标注有 2×10⁻⁹、5×10⁻⁹、10⁻⁸
// 和 2×10⁻⁸。纵轴为随机引力波背景的能量密度 Ω_GW h²，采
// 用对数坐标，显示范围从 10⁻¹¹ 到 10⁻⁶。 图右侧图例包含
// 九个条目。前两项为空心符号：灰色空心圆代表 NG15 数据，
// 黄绿色空心圆代表包含环境效应的超大质量黑洞双星（SMBH w
// env. effects）。其后七项为不同颜色和线型的虚线，依次为：
// 紫色虚线代表宇宙超弦（Cosmic SuperStrings）、橙色虚线
// 代表相变（Phase Transition）、灰色虚线代表畴壁（Domain
// Walls）、珊瑚色虚线代表可听轴子（Audible axions）、红
// 色虚线代表一阶引力波（First-order GWs）、蓝色虚线代表
// 标量诱导引力波（Scalar-induced GWs），最后一条未在图例
// 中单独列出但以黄绿色粗虚线形式出现，对应包含环境效应的
// SMBH 双星最佳拟合。 图中灰色区域为 NG15 数据的约束带，
// 呈不规则的垂直尖峰状分布，覆盖约 2×10⁻⁹ Hz 至 3×10⁻⁸
// Hz 范围，其幅度从低频约 10⁻¹⁰ 上升至高频约 10⁻⁶，在频
// 段右端呈现密集的锯齿状尖峰。该灰色带在 4×10⁻⁹ Hz 附近
// 有一个向下延伸的尖峰。 黄绿色曲线（SMBH w env. effects）
// 是一条贯穿全频段的实线，带有周期性振荡的尖峰特征：在 2
// ×10⁻⁹ Hz 附近有一个明显下凹至约 5×10⁻¹¹，随后在 4×10⁻⁹
// Hz、8×10⁻⁹ Hz、1.2×10⁻⁸ Hz、1.6×10⁻⁸ Hz 附近出现向上的
// 尖峰，尖峰幅度随频率增加而增大，在 2×10⁻⁸ Hz 附近尖峰
// 峰值接近 10⁻⁶。该曲线在低频段位于其他模型曲线之下，在
// 高频段则显著高于所有其他模型曲线。 其余六条模型曲线均
// 大致呈幂律上升趋势，在 2×10⁻⁹ Hz 处从约 1.5×10⁻¹¹ 至
// 1.5×10⁻¹⁰ 的范围内起步，上升至 3×10⁻⁸ Hz 处约 10⁻⁸ 至
// 2×10⁻⁸。其中紫色虚线（Cosmic SuperStrings）在低频段最
// 高、斜率最平缓；橙色虚线（Phase Transition）和红色虚线
// （First-order GWs）居中；蓝色虚线（Scalar-induced GWs）
// 和灰色虚线（Domain Walls）在低频段最低、斜率最陡。所有
// 模型曲线在 2×10⁻⁸ Hz 附近收敛至约 10⁻⁸ 量级，且均被灰
// 色 NG15 数据带的低频下包络所覆盖。图表传达的趋势是：包
// 含环境效应的 SMBH 双星模型在低频段与 NG15 数据吻合较好，
// 但在高频段产生远超其他宇宙学模型的振荡尖峰信号；而各
// BSM 宇宙学模型则呈现平滑的幂律谱，在高频段与 NG15 数据
// 带的上包络存在明显差距。
#figure(scope: "parent", image("imgs/BFplots.png", width: 85.0%),
  caption: [
    Comparison of the best fits to the NG15 data for SMBH binaries with environmental effects and in the indicated BSM cosmological models.
  ]
)
<fig:Bestfits>



We show in @fig:Axion_posteriors the posteriors of the “audible” axions two-parameter fit to the NG15 data. The best-fit values are achieved at $ m_a = 3.1 times 10^(- 11) upright("eV") thin , quad f_a = 0.87 thin M_(upright(P)) thin , $ corresponding to $- 2 Delta ell = - 1.6$ relative to the baseline. Differently from the analysis performed in ref. @Figueroa:2023zhu we find a larger possible range for the masses of the axions below super-Planckian $f_a$ values. Part of this region is currently ruled out by the super-radiance constraints @Zhang:2021mks @Baryakhtar:2020gao @Mehta:2020kwu. The discrepancy between our analysis and that in @Figueroa:2023zhu is twofold. First, the analysis in Ref. @Figueroa:2023zhu is based on both NANOGrav and EPTA data, with the latter dataset favoring larger amplitudes at higher frequencies. Heavier axions move the main peak to higher frequencies without changing the amplitude of the main peak. As a consequence, including the EPTA dataset leads to stronger bounds on more massive axions compared to our analysis. Lastly, when the peak of the signal is at frequencies much higher than the PTA range, which occurs for the larger masses in @fig:Axion_posteriors, the causality tail dominates the signal compared to the Ansatz used to characterize the signal in @Figueroa:2023zhu.


@fig:aaSMBH_posteriors shows a full set of posterior parameter distribution functions and two-parameter correlations for the fit to a combination of “audible” axions and SMBH binaries. The best fit of the combined fit is at the same point as without the SMBH, $p_(upright("BH")) approx 0$, so the inclusion of the SMBH binaries does not improve the fit. If we impose the posteriors from the candidate event at $4 upright("nHz")$, then the best-fit shifts to $
& p_(upright("BH")) = 0.58 #h(0.17em) #h(0em) f_(upright("ref")) = 20 #h(0.17em) upright("nHz") #h(0.17em) #h(0em) alpha = 5 #h(0.17em)
$ and same axion parameters, corresponding to $- 2 Delta ell = - 0.3$.


= MODEL COMPARISONS
<sec:comp>


@fig:Bestfits compares the best fits in the models we have studied in the frequency range measured by NANOGrav. We see that the cosmological models all capture to some extent the frequency dependence measured in the NANOGrav range, as does the astrophysical SMBH binary scenario if environmental effects are included. This model, the cosmic (super)string scenario and “audible” axions fit the data less well than phase transitions, domain walls, scalar-induced GWs and first-order GWs, as seen quantitatively in @tab:results, which collects the numerical results for our best fits in the astrophysical SMBH model with and without environmental effects and in the BSM cosmological scenarios we have studied. The best-fit values of the model parameters are shown in the second column, and the values of the Bayesian inference criterion $Delta upright("BIC")$ relative to the baseline SMBH model with the environmental effects are shown in the third column. The numbers in the parenthesis in the third column indicate the Bayesian inference criterion of the fit combining the cosmological model with the SMBH model including the environmental effects. These fits give significantly larger values of $Delta upright("BIC")$ because they include more parameters. The combined fit is better than the SMBH model alone only in the case of phase transitions and domain walls.


// [figvision-cn] imgs/BFplotsbig.png
// 这是一张双对数坐标图，横轴为频率 f，单位 Hz，范围从约
// 10^-9 到 100 Hz；纵轴为随机引力波背景的能量密度谱 Ω_GW
// h^2，范围从 10^-15 到 10^-5。图中包含多条彩色曲线、阴
// 影带和虚线轮廓。 图左上角有一块淡粉色区域，标注 “ROMAN
// ”，其边界为虚线，覆盖频率约 10^-8 到 10^-7 Hz、纵轴约
// 10^-9 到 10^-6。左侧边缘有一组绿色和灰色的“小提琴”形分
// 布，覆盖频率约 10^-9 到 10^-7.5 Hz，纵轴约 10^-10 到
// 10^-7，表示脉冲星计时阵列（PTA）的探测灵敏度。 图中央
// 有一条宽阔的黄色阴影带，内部标有 “Supermassive Black
// Hole”，其中心线为黄色实线，从低频端约 10^-9 Hz、Ω_GW h
// ^2 ≈ 10^-10 上升至约 10^-8 Hz、10^-7.5 后缓慢下降，延
// 伸至约 10^-2 Hz。这条黄色带在低频端与绿色“小提琴”分布
// 衔接。 图中有多条虚线表示不同物理模型：紫色虚线标 “
// Cosmic SuperStrings”，从左上向右下倾斜；深绿色虚线标 “
// Domain Walls”，从约 10^-7 Hz、10^-7 下降至 10^-4 Hz、
// 10^-11；黄色虚线标 “Phase Transition”，从约 10^-7 Hz、
// 10^-7 下降至 10^-3 Hz、10^-15；蓝色虚线标 “
// Scalar-induced GWs”，从约 10^-8 Hz、10^-8 下降至 10^-6
// Hz、10^-15；橙色虚线标 “Audible axions”，从约 10^-9 Hz、
// 10^-9 下降至 10^-7 Hz、10^-15；红色虚线标 “First-order
// GWs”，从约 10^-8 Hz、10^-7 下降至 10^-6 Hz、10^-15。
// 右侧有多组虚线轮廓表示未来探测器灵敏度：淡蓝色区域标 “
// AION-km”，覆盖约 0.01 到 1 Hz、10^-13 到 10^-9；深蓝色
// 区域标 “AEDGE”，覆盖约 0.01 到 0.3 Hz、10^-14 到 10^
// -10；绿色虚线轮廓标 “LISA”，覆盖约 10^-4 到 0.1 Hz、10
// ^-13 到 10^-9；橙色虚线轮廓标 “ET”，覆盖约 1 到 100 Hz、
// 10^-13 到 10^-7；深棕色虚线轮廓标 “LVK O3”，覆盖约 10
// 到 100 Hz、10^-9 到 10^-6；浅棕色虚线轮廓标 “LVK
// design”，覆盖约 10 到 100 Hz、10^-11 到 10^-7；红色虚
// 线轮廓标 “AION-100”，覆盖约 0.1 到 10 Hz、10^-12 到 10
// ^-6。 图中所有标注文字均为英文，曲线和轮廓的颜色与标注
// 文字颜色对应。整体趋势显示：不同物理模型在不同频段产生
// 不同强度的引力波背景，而各类探测器在各自频段具有不同的
// 探测灵敏度，黄色 Supermassive Black Hole 带在 10^-8 到
// 10^-2 Hz 之间具有较高振幅，是未来探测器的重要目标。
#figure(scope: "parent", image("imgs/BFplotsbig.png", width: 95.0%),
  caption: [
    Extension of @fig:Bestfits to higher frequencies, indicating the prospective sensitivities of LVK and planned and proposed future detectors. For clarity, we include only the first four and the eighth bins which are the most narrow and have the largest impact on fit quality. The green band extends the “violins” in the PTA range to higher frequencies, and shows the mean GW energy density spectrum from SMBH binaries heavier than $10^3 M_⊙$ for $p_(upright("BH")) = 0.25 - 1$. Individual SMBH binaries are expected to be measurable in this frequency range. The FOGW spectrum is expected to be cut off at some frequency between the ranges where PTAs and interferometers are sensitive.
  ]
)
<fig:BestFits2>



Finally, the fifth fourth of @tab:results tabulates some prospective signatures of the models considered that could help discriminate between them. As discussed above, PTAs should be sensitive to bin-to-bin fluctuations if the observed SGWB is due to SMBH binaries. Moreover, there should be observable anisotropies in the SGWB~@Sato-Polito:2023spo and circular polarization could be observable~@Sato-Polito:2021efu @Ellis:2023owy. Also, future PTA data could reveal individual binary sources. We see from the fits combining the cosmological models with the SMBH model with environmental effects that the 1$sigma$ ranges for the SMBH parameters are relatively broad. A consequence of this is that it is possible to find a mixed scenario where the fit is better than in the pure SMBH model but that can still accommodate observable individual binary sources.


@fig:BestFits2 extends the model comparisons to the higher frequencies accessible to other experiments including LISA~@Bartolo:2016ami @Caprini:2019pxz @LISACosmologyWorkingGroup:2022jok, The Einstein Telescope (ET)~@Punturo:2010zz @Hild:2010id, AION~@Badurina:2019hst @Badurina:2021rgt, AEDGE~@AEDGE:2019nxb @Badurina:2021rgt, the Nancy Roman telescope (ROMAN)~@Wang:2022sxn and the design sensitivity of LVK~@LIGOScientific:2014pky @LIGOScientific:2016fpe @LIGOScientific:2019vic. We see that LISA should be able to detect individual SMBH binaries, albeit with lower masses ($cal(O) ( 10^6 - 10^9 )$ solar masses) than those responsible for the NANOGrav signal ($gt.tilde cal(O) ( 10^9 )$ solar masses~@Ellis:2023owy), at larger rates if environmental effects are important~@Ellis:2023dgf. Similarly, proposed experiments in the mid-frequency band such as AION and AEDGE would be sensitive to mergers of BHs with masses $cal(O) ( 10^3 - 10^6 )$ solar masses. On the other hand experiments such as LVK and ET are not sensitive to mergers of BHs with masses $gt.tilde 10^3$ solar masses. In contrast, all these experiments should be able to detect GWs from cosmic (super)strings, even in the case of modified cosmological evolution~@Ellis:2023tsl. On the other hand, the SGWB from a cosmological phase transition, SIGWs, FOGWs or “audible” axions would be unobservable in any higher-frequency detector, whereas the SGWB from domain walls might be observable by LISA between $10^(- 3) - 10^(- 2)$~Hz, but probably not by AEDGE and other detectors operating at frequencies $gt.tilde 10^(- 2)$~Hz.





#figure(
  {
    set text(size: 8pt)
    align(center, table(
      columns: 4,
      align: (left, left, center, left),
      stroke: none,
      table.header([Scenario], [Best-fit parameters], [$Delta upright("BIC")$], [Signatures]),
      table.hline(), table.hline(),
      [GW-driven SMBH binaries], [$p_(upright("BH")) = 0.07$], [6.0], [FAPS, LISA, mid-$f$, #strike[LVK, ET]],
      table.hline(),
      [GW + environment-driven \ SMBH binaries], [$p_(upright("BH")) = 0.84$ \ $alpha = 2.0$ \ $f_(upright("ref")) = 34$~nHz], [Baseline \ (BIC = 53.9)], [FAPS, LISA, mid-$f$, #strike[LVK, ET]],
      table.hline(), table.hline(),
      [Cosmic (super)strings \ (CS)], [$G mu = 2 times 10^(-12)$ \ $p = 6.3 times 10^(-3)$], [-1.2 \ (4.6)], [#strike[FAPS], LISA, mid-$f$, LVK, ET],
      table.hline(),
      [Phase transition \ (PT)], [$T_(*) = 0.34$~GeV \ $beta / H = 6.0$], [-4.9 \ (2.9)], [#strike[FAPS, LISA, mid-$f$, LVK, ET]],
      table.hline(),
      [Domain walls \ (DWs)], [$T_(upright("ann")) = 0.85$~GeV \ $alpha_(*) = 0.11$], [-5.7 \ (2.2)], [#strike[FAPS], LISA?, #strike[mid-$f$, LVK, ET]],
      table.hline(),
      [Scalar-induced GWs \ (SIGWs)], [$k_(*) = 10^(7.7) / upright("Mpc")$ \ $A = 0.06$ \ $Delta = 0.21$], [-2.1 \ (5.8)], [#strike[FAPS, LISA, mid-$f$, LVK, ET]],
      table.hline(),
      [First-order GWs \ (FOGWs)], [$log_10 r = -14$ \ $n_(upright(t)) = 2.6$ \ $T_(upright("rh")) = -0.67$~GeV], [-2.0 \ (6.0)], [#strike[FAPS, LISA, mid-$f$, LVK, ET]],
      table.hline(),
      [“Audible” axions], [$m_a = 3.1 times 10^(-11) thin upright("eV")$ \ $f_a = 0.87 thin M_(upright(P))$], [-4.2 \ (3.7)], [#strike[FAPS, LISA, mid-$f$, LVK, ET]],
      table.hline(),
    ))
    v(0.5em)
    set text(size: 7.5pt)
    align(center)[
      FAPS~$equiv$~fluctuations, anisotropies, polarization, sources, mid-$f$~$equiv$~mid-frequency experiment, e.g., AION~@Badurina:2019hst, AEDGE~@AEDGE:2019nxb, \
      LVK~$equiv$~LIGO/Virgo/KAGRA~@LIGOScientific:2014pky @LIGOScientific:2016fpe @LIGOScientific:2019vic, ET~$equiv$~Einstein Telescope~@Sathyaprakash:2012jk (or Cosmic Explorer~@Reitze:2019iox), #strike[signature]~$equiv$~not detectable
    ]
  },
  caption: [#emph[T]he parameters of the different models are defined in the text. For each model, we tabulate their best-fit values, and the Bayesian information criterion $B I C equiv - 2 ell + k ln 14$, where $k$ denotes the number of parameters, relative to that for the purely SMBH model with environmental effects that we take as the baseline. The quantity in the parentheses in the third column shows the $Delta$BIC for the best-fit combined SMBH+cosmological scenario. The last column summarizes the prospective signatures.],
  kind: table,
) <tab:results>








= CONCLUSIONS
<sec:concl>


The recent PTA data from NANOGrav and other PTA Collaborations have established the existence of a SGWB in the nHz range, but its interpretation remains an open question. Binary SMBH systems are the default astrophysical interpretation but remain to be established as the sources of the PTA signals. Many cosmological models invoking generic aspects of BSM physics have also been proposed as prospective sources. We have presented in this paper a comprehensive Multi-Model Analysis (MMA) that applies a common approach to assess the relative qualities of fits in these models, both with and without the inclusion of a SMBH binary background. We find that these models are capable of fitting the NANOGrav data at least as well as SMBH binaries alone (significantly better if environmental effects on the evolution of the binaries can be neglected). Future PTA datasets may be able to distinguish between the cosmological and astrophysical scenarios, e.g., by observing bin-to-bin fluctuations, anisotropies, circular polarization or individual sources. Observations at higher frequencies will also be invaluable: some cosmological scenarios predict a turndown of the frequency spectrum that precludes measurements by LISA, whereas astrophysical models suggest that BH mergers may be observable by LISA and mid-frequency experiments, and cosmic (super)strings predict that a SGWB background should be detectable by LISA and higher-frequency experiments. \
~~ \
The discovery of nHz GWs may be linked to the biggest bangs since the Big Bang, namely mergers of SMBHs, or be providing evidence for new fundamental physics that is inaccessible to laboratory experiments. Time and more data will tell.


#block[
The work of J.E. was supported by the United Kingdom STFC Grants ST/T000759/1 and ST/T00679X/1. G.F. acknowledges the financial support provided under the European Union's H2020 ERC, Starting Grant agreement no.~DarkGRA--757480 and under the MIUR PRIN programme, and support from the Amaldi Research Center funded by the MIUR program “Dipartimento di Eccellenza” (CUP:~B81I18001170001). This work was supported by the EU Horizon 2020 Research and Innovation Programme under the Marie Sklodowska-Curie Grant Agreement No. 101007855 and additional financial support provided by “Progetti per Avvio alla Ricerca - Tipo 2”, protocol number AR2221816C515921. M.L. acknowledges the financial support provided by the Polish Returns Programme under agreement PPN/PPO/2020/1/00013/U/00001 and the Polish National Science Center grant 2018/31/D/ST2/02048. The work of G.H., V.V. and H.V. was supported by the European Regional Development Fund through the CoE program grant TK133 and by the Estonian Research Council grants PRG803 and PSG869. The work of V.V. has been partially supported by the European Union's Horizon Europe research and innovation program under the Marie Skłodowska-Curie grant agreement No. 101065736. A.J.I. acknowledges the financial support provided under the “Progetti per Avvio alla Ricerca Tipo 1”, protocol number AR12218167D66D36, and the “Progetti di mobilità di studenti di dottorato di ricerca”.

]





= SECOND-ORDER INDUCED GRAVITATIONAL WAVES WITH NON-GAUSSIANITIES
<app:NGSIGW>


We summarize here the formulas used to compute the spectrum of SIGWs when non-Gaussianities are included, referring the reader to Refs.~@Unal:2018yaa @Cai:2018dig @Yuan:2020iwf @Adshead:2021hnm @Abe:2022xur @Chang:2022nzu @Garcia-Saenz:2022tzu @Li:2023qua for more details. We assume that the curvature perturbation can be written in terms of its Gaussian component, as $zeta = zeta_(upright(G)) + F_(upright("NL")) zeta_(upright(G))^2 .$ The non-linear parameter is often normalised as $F_(upright("NL")) = ( 3 / 5 ) f_(upright("NL"))$.


The higher-order corrections to the GW power spectrum can then be written as $ Omega_(upright("GW")) ( T ) = Omega_(upright("GW"))^(( 0 )) ( T ) + Omega_(upright("GW"))^(( 1 )) ( T ) + Omega_(upright("GW"))^(( 2 )) ( T ) med , $<eq:Omegabar-total> where each contribution scales as $cal(P)_h ( k , eta )^(( n )) ( eta , k ) prop A^2 ( A F_(upright("NL"))^2 )^n$ and the first order is given in @eq:P_h_ts. The energy-density fraction spectrum of SIGW at the current epoch is then given by @eq:OmegaGWtoday.


// [figvision-cn] imgs/Ng_spectra_SIGW.png
// 这是一张单面板双对数坐标曲线图，没有子图划分，属于理论
// 物理/宇宙学论文中的示意图，用来展示不同微扰阶数对诱导
// 引力波（SIGW）能谱的贡献。图中横轴为波数比 k/k*，采用
// 对数刻度，范围从 10^-1 到 10^1，即有刻度标注的 10^-1、
// 10^0、10^1 三个主刻度；纵轴为无量纲的功率谱组合，采用
// 对数刻度，范围从 10^-5 到 10^0，刻度标注为 10^-5、10^
// -4、10^-3、10^-2、10^-1、10^0。图中没有网格线，但有朝
// 向图内的主刻度和次刻度短线。 图中绘制了三条曲线，表示
// 不同阶数的贡献： 蓝线：图例标注为 𝒫_h^(0)/(A²)，表示领
// 头阶（线性阶）贡献，整体幅值最低； 粉线：图例标注为 𝒫
// _h^(1)/(A³ F_NL²)，表示一阶非线性修正，整体幅值居中；
// 绿线：图例标注为 𝒫_h^(2)/(A⁴ F_NL⁴)，表示二阶非线性修
// 正，在低 k 区幅值高于蓝线，在高 k 区峰值最高。 三条曲
// 线均为实线，线宽相同。图例位于左上角，为一个圆角矩形框，
// 内部列出三行：蓝色短线及文字“𝒫_h^(0)/(A²)”、粉色短线及
// 文字“𝒫_h^(1)/(A³ F_NL²)”、绿色短线及文字“𝒫_h^(2)/(A⁴
// F_NL⁴)”。图例下方约 k/k* = 10^-1 与纵轴 10^-2 之间位置
// 标注文字“σ = 0.4”。 曲线趋势：在低波数区 k/k* < 10^-1，
// 三条曲线均随 k 增加而单调上升，蓝线最低、粉线最高、绿
// 线居中；在 k/k* ≈ 10^-1 到 10^0 之间，蓝线在 k/k* ≈
// 0.5 处出现一个小的局部平台（斜率变缓），随后继续上升；
// 三条曲线在 k/k* ≈ 1 附近均出现峰值，蓝线峰值约 4×10^-1，
// 粉线峰值约 1.2×10^0，绿线峰值约 1.5×10^0，绿线峰值位置
// 略靠右（约 k/k* ≈ 1.2）；在 k/k* > 10^0 后，三条曲线均
// 快速下降，蓝线最早在 k/k* ≈ 4 处跌破 10^-5，粉线在 k/k
// * ≈ 6 处跌破 10^-5，绿线在 k/k* ≈ 7 处跌破 10^-5。 该
// 图传达的结论是：在 σ = 0.4 的对数正态曲率功率谱假设下，
// 非高斯性会显著改变 SIGW 谱的幅值和峰值位置，一阶和二阶
// 非线性贡献在峰值附近与领头阶同量级甚至更高，说明微扰展
// 开的高阶项在计算 SIGW 谱时不可忽略。
#figure([#block[
  #box(image("imgs/Ng_spectra_SIGW.png", width: 52%))
  ]],
  caption: [
    Contributions to the SIGW spectrum from the leading orders in perturbation theory, where we have factored out the relevant combination of the amplitude $A$ and non-Gaussianity $F_(upright("NL"))$. This plot assumes a log-normal curvature power spectrum centered at $k_(*)$ that is characterised by a width $sigma = 0.4$.
  ]
)
<fig:SIGW-fNL_spectra>



In accordance with Refs.~@Adshead:2021hnm @Li:2023qua @Zhu:2023faa @Ragavendra:2021qdu @Atal:2021jyo, the higher-order terms in @eq:Omegabar-total can be expressed as $ Omega_(upright("GW"))^(( 1 )) ( T ) = & frac(2 F_(upright("NL"))^2, 3) product_(i = 1)^2 \[ integral_1^oo upright(d) t_i integral_(- 1)^1 upright(d) s_i thin frac(16, ( t_i^2 - s_i^2 )^2) \] ( 1 / 2 overline(J^2 ( s_1 , t_1 )) cal(P)_zeta ( v_1 v_2 k ) cal(P)_zeta ( u_1 k ) cal(P)_zeta ( v_1 u_2 k )\
+ & integral_0^(2 pi) frac(upright(d) phi_12, 2 pi) thin cos 2 phi_12 overline(J ( s_1 , t_1 ) J ( s_2 , t_2 )) frac(cal(P)_zeta ( v_2 k ), v_2^3) frac(cal(P)_zeta ( w_12 k ), w_12^3) \[ frac(cal(P)_zeta ( u_2 k ), u_2^3) + frac(cal(P)_zeta ( u_1 k ), u_1^3) \] ) $<eq:Omega-C> and $ Omega_(upright("GW"))^(( 2 )) ( T ) & = F_(upright("NL"))^4 / 6 product_(i = 1)^3 \[ integral_1^oo upright(d) t_i integral_(- 1)^1 upright(d) s_i thin frac(16, ( t_i^2 - s_i^2 )^2) \] ( 1 / 2 overline(J^2 ( s_1 , t_1 )) cal(P)_zeta ( v_1 v_2 k ) cal(P)_zeta ( v_1 u_2 k ) cal(P)_zeta ( u_1 v_3 k ) cal(P)_zeta ( u_1 u_3 k )\
 & + integral_0^(2 pi) frac(upright(d) phi_12, 2 pi) frac(upright(d) phi_23, 2 pi) cos ( 2 phi_12 ) overline(J ( s_1 , t_1 ) J ( s_2 , t_2 )) frac(cal(P)_zeta ( u_3 k ), u_3^3) frac(cal(P)_zeta ( w_13 k ), w_13^3) frac(cal(P)_zeta ( w_23 k ), w_23^3) \[ frac(cal(P)_zeta ( v_3 k ), v_3^3) + frac(cal(P)_zeta ( w_123 k ), w_123^3) \] ) med , $<eq:Omega-N> where we defined $s_i = u_i - v_i$, $t_i = u_i + v_i$, and $ y_(i j) & = & frac(cos phi_(i j), 4) sqrt(( t_i^2 - 1 ) ( t_j^2 - 1 ) ( 1 - s_i^2 ) ( 1 - s_j^2 )) + 1 / 4 ( 1 - s_i t_i ) ( 1 - s_j t_j ) med ,\
w_(i j) & = & sqrt(v_i^2 + v_j^2 - y_(i j)) thin , #h(2em) w_123 = sqrt(v_1^2 + v_2^2 + v_3^2 + y_12 - y_13 - y_23) med . $ The time-averaged integrated transfer functions $J ( u , v )$ were derived in Refs.~@Espinosa:2018eve @Kohri:2018awv @Atal:2021jyo @Adshead:2021hnm @Li:2023qua, and are $  & overline(J ( s_i , t_i ) J ( s_j , t_j )) = 9 / 8 frac((t_i^2 - 1) (t_j^2 - 1) (1 - s_i^2) (1 - s_j^2) (t_i^2 + s_i^2 - 6) (t_j^2 + s_j^2 - 6), (t_i^2 - s_i^2)^3 (t_j^2 - s_j^2)^3)\
 & \[ ((t_i^2 + s_i^2 - 6) ln lr(|frac(t_i^2 - 3, 3 - s_i^2)|) - 2 (t_i^2 - s_i^2)) ((t_j^2 + s_j^2 - 6) ln lr(|frac(t_j^2 - 3, 3 - s_j^2)|) - 2 (t_j^2 - s_j^2))\
 & + pi^2 Theta (t_i - sqrt(3)) Theta (t_j - sqrt(3)) (t_i^2 + s_i^2 - 6) (t_j^2 + s_j^2 - 6) \] med . $<eq:J-ave-12> Assuming a log-normal curvature power spectrum of the form @eq:PLN, as done in @sec:SIGWth, we can compute the different contributions to the SGWB, factoring out the overall scaling with the spectral amplitude $A$ and the non-linear parameter $F_(upright("NL"))$, as shown in @fig:SIGW-fNL_spectra.


The presence of higher-order corrections to the SIGW spectrum could be inferred from a modulation of the peak close to $k approx k_(*)$, if the combination $A F_(upright("NL"))^2$ is sufficiently large. On the other hand, the shape of the low-frequency tail at $k lt.double k_(*)$ is maintained, i.e., $ Omega_(upright("GW")) ( k lt.double k_(*) ) thin prop thin k^3 ( 1 + tilde(A) ln^2 ( k / tilde(k) ) ) thin , $ where $tilde(A)$ and $tilde(k) = cal(O) ( k_(*) )$ are parameters that depend mildly on the shape of the curvature power spectrum.


// [figvision-cn] imgs/Pos_SIGW_LN_fNL.png
// 这是一张科学论文中的角图（corner plot），用于展示四个
// 参数的联合后验概率分布。整张图呈下三角矩阵布局，包含10
// 个子图，分为4个一维边缘概率分布直方图（位于对角线）和6
// 个二维联合概率分布等高线图（位于非对角线）。图中使用深
// 蓝色实线、浅蓝色填充区域和黑色虚线表示不同的概率区域和
// 参考线。 子图布局与坐标轴： 图中所有子图共享参数轴。横
// 轴（从左到右）依次为：log10(k*/Mpc⁻¹)，范围约6.3至9.6；
// log10 A，范围约-2.0至-0.1；Δ，范围约0.3至3.3；F_NL，范
// 围约-9至9。纵轴（从上到下）依次为：log10 A，范围约-2.0
// 至-0.1；Δ，范围约0.3至3.3；F_NL，范围约-9至9。 对角线
// 子图（一维边缘概率分布直方图）： 这些子图是阶梯状直方
// 图，用深蓝色实线表示概率密度。每个子图上方标注了该参数
// 的最佳拟合值及置信区间。 第一行第一列：横轴为log10(k*/
// Mpc⁻¹)。直方图呈右偏分布，峰值在8.0附近。图中标注文字
// 为“[7.5, 8.9]”，并画有两条垂直虚线，分别位于7.5和8.9处，
// 标示出95%置信区间。 第二行第二列：横轴为log10 A。直方
// 图呈近似对称的钟形分布，峰值在-1.0附近。图中标注文字为
// “[-1.5, -0.55]”，并画有两条垂直虚线，分别位于-1.5和
// -0.55处。 第三行第三列：横轴为Δ。直方图呈左偏分布，峰
// 值在0.5附近。图中标注文字为“[0.2, 2]”，并画有一条垂直
// 虚线，位于2.0处，标示出95%置信上限。 第四行第四列：横
// 轴为F_NL。直方图在0附近呈平坦分布，略有波动。图中标注
// 文字为“[-10, 10]”，表示该参数的先验或置信区间边界。 非
// 对角线子图（二维联合概率分布等高线图）： 这些子图展示
// 了两个参数之间的相关性。使用深蓝色实线勾勒出等高线，内
// 部填充浅蓝色，最内层区域填充深蓝色。等高线通常代表68%
// 和95%置信区域。 第二行第一列：纵轴为log10 A，横轴为
// log10(k*/Mpc⁻¹)。等高线呈倾斜的椭圆形，从左上向右下延
// 伸，表明log10 A与log10(k*/Mpc⁻¹)呈正相关。深蓝色核心区
// 域位于约(8.0, -0.8)处。 第三行第一列：纵轴为Δ，横轴为
// log10(k*/Mpc⁻¹)。等高线呈倾斜的带状，从左上向右下延伸，
// 表明Δ与log10(k*/Mpc⁻¹)呈负相关。深蓝色核心区域位于约(
// 7.5, 1.2)处。 第四行第一列：纵轴为F_NL，横轴为log10(k*
// /Mpc⁻¹)。等高线近似垂直，表明F_NL与log10(k*/Mpc⁻¹)之间
// 没有明显的相关性。 第三行第二列：纵轴为Δ，横轴为log10
// A。等高线呈倾斜的带状，从左上向右下延伸，表明Δ与log10
// A呈负相关。图中还画有两条黑色虚线，从左上向右下弯曲延
// 伸，可能表示某种理论模型或边界。 第四行第二列：纵轴为
// F_NL，横轴为log10 A。等高线呈倾斜的带状，从左上向右下
// 延伸，表明F_NL与log10 A呈负相关。深蓝色核心区域位于约(
// -1.0, 0)处。黑色虚线同样存在。 第四行第三列：纵轴为
// F_NL，横轴为Δ。等高线呈扭曲的“S”形或波浪形，表明F_NL与
// Δ之间存在复杂的非线性关系。深蓝色核心区域位于约(1.0, 0
// )和(2.5, 0)处。 图中所有坐标轴的刻度线向内，且刻度标签
// 清晰可读。整体趋势表明，log10(k*/Mpc⁻¹)、log10 A和Δ之
// 间两两存在显著的相关性，而F_NL与其他三个参数的相关性较
// 弱，其边缘分布也较为平坦。
// [figvision-cn] imgs/Pos_SIGW_LN_fNL.png
// 这是一张科学论文中的角图（corner plot），用于展示四个
// 参数的联合后验概率分布。整张图呈下三角矩阵布局，包含10
// 个子图，分为4个一维边缘概率分布直方图（位于对角线）和6
// 个二维联合概率分布等高线图（位于非对角线）。图中使用深
// 蓝色实线、浅蓝色填充区域和黑色虚线表示不同的概率区域和
// 参考线。 子图布局与坐标轴： 图中所有子图共享参数轴。横
// 轴（从左到右）依次为：log10(k*/Mpc⁻¹)，范围约6.3至9.6；
// log10 A，范围约-2.0至-0.1；Δ，范围约0.3至3.3；F_NL，范
// 围约-9至9。纵轴（从上到下）依次为：log10 A，范围约-2.0
// 至-0.1；Δ，范围约0.3至3.3；F_NL，范围约-9至9。 对角线
// 子图（一维边缘概率分布直方图）： 这些子图是阶梯状直方
// 图，用深蓝色实线表示概率密度。每个子图上方标注了该参数
// 的最佳拟合值及置信区间。 第一行第一列：横轴为log10(k*/
// Mpc⁻¹)。直方图呈右偏分布，峰值在8.0附近。图中标注文字
// 为“[7.5, 8.9]”，并画有两条垂直虚线，分别位于7.5和8.9处，
// 标示出95%置信区间。 第二行第二列：横轴为log10 A。直方
// 图呈近似对称的钟形分布，峰值在-1.0附近。图中标注文字为
// “[-1.5, -0.55]”，并画有两条垂直虚线，分别位于-1.5和
// -0.55处。 第三行第三列：横轴为Δ。直方图呈左偏分布，峰
// 值在0.5附近。图中标注文字为“[0.2, 2]”，并画有一条垂直
// 虚线，位于2.0处，标示出95%置信上限。 第四行第四列：横
// 轴为F_NL。直方图在0附近呈平坦分布，略有波动。图中标注
// 文字为“[-10, 10]”，表示该参数的先验或置信区间边界。 非
// 对角线子图（二维联合概率分布等高线图）： 这些子图展示
// 了两个参数之间的相关性。使用深蓝色实线勾勒出等高线，内
// 部填充浅蓝色，最内层区域填充深蓝色。等高线通常代表68%
// 和95%置信区域。 第二行第一列：纵轴为log10 A，横轴为
// log10(k*/Mpc⁻¹)。等高线呈倾斜的椭圆形，从左上向右下延
// 伸，表明log10 A与log10(k*/Mpc⁻¹)呈正相关。深蓝色核心区
// 域位于约(8.0, -0.8)处。 第三行第一列：纵轴为Δ，横轴为
// log10(k*/Mpc⁻¹)。等高线呈倾斜的带状，从左上向右下延伸，
// 表明Δ与log10(k*/Mpc⁻¹)呈负相关。深蓝色核心区域位于约(
// 7.5, 1.2)处。 第四行第一列：纵轴为F_NL，横轴为log10(k*
// /Mpc⁻¹)。等高线近似垂直，表明F_NL与log10(k*/Mpc⁻¹)之间
// 没有明显的相关性。 第三行第二列：纵轴为Δ，横轴为log10
// A。等高线呈倾斜的带状，从左上向右下延伸，表明Δ与log10
// A呈负相关。图中还画有两条黑色虚线，从左上向右下弯曲延
// 伸，可能表示某种理论模型或边界。 第四行第二列：纵轴为
// F_NL，横轴为log10 A。等高线呈倾斜的带状，从左上向右下
// 延伸，表明F_NL与log10 A呈负相关。深蓝色核心区域位于约(
// -1.0, 0)处。黑色虚线同样存在。 第四行第三列：纵轴为
// F_NL，横轴为Δ。等高线呈扭曲的“S”形或波浪形，表明F_NL与
// Δ之间存在复杂的非线性关系。深蓝色核心区域位于约(1.0, 0
// )和(2.5, 0)处。 图中所有坐标轴的刻度线向内，且刻度标签
// 清晰可读。整体趋势表明，log10(k*/Mpc⁻¹)、log10 A和Δ之
// 间两两存在显著的相关性，而F_NL与其他三个参数的相关性较
// 弱，其边缘分布也较为平坦。
#figure(block(width: 100%)[#grid(columns: (1fr, 1.63fr), gutter: 1em, image("imgs/Pos_SIGW_LN_fNL.png", width: 100%), image("imgs/Pos_SMBHs_SIGW_LN_fNL.png", width: 100%))],
  caption: [
    Same as @fig:SIGWonly_posteriors (left panel) and same as @fig:SIGW_posteriors (right panel) but including the possibility of non-Gaussian curvature perturbations with a non-linear parameter $F_(upright("NL"))$.
  ]
)
<fig:SIGW_posteriors-fNL>



As the PTA observations could only be compatible with the infra-red tail of a SIGW, due to the preference for a positive tilt of the spectrum, we conclude that higher-order corrections do not affect significantly the results presented in the main text, while, in full generality, current GW observations are not able to break the degeneracy in the $( A , F_(upright("NL"))^2 )$ plane. As a by-product of our analysis, at odds with the claim in Refs.~@Liu:2023ymk @Figueroa:2023zhu, we conclude that current data are not able to constrain the presence of non-Gaussianities at PTA scales, beyond the reach of large-scale structure and CMB probes. This is because large values of $F_(upright("NL"))$ remain possible, provided the curvature power spectral amplitude is sufficiently small. This is confirmed by the posterior distributions shown in @fig:SIGW_posteriors-fNL, where we report results for non-Gaussian SIGW-only fits (left panel) and for non-Gaussian SIGWs together with SMBH binaries (right panel). In both panels, the posterior distribution for $F_(upright("NL"))$ is flat over the entire prior range.

#bibliography("refs.bib", style: "american-physics-society", title: [References])