// Supplement (included from main.typ)
#set text(size: 10.26pt, lang: "en")
#set figure(numbering: "S1", supplement: [Figure])
#show figure.where(kind: image): set figure(placement: top)
#show figure.where(kind: table): set figure.caption(position: bottom)
#show figure.caption: set text(size: 10.26pt)
#show outline.entry: it => {
  if it.level == 1 {
    block(above: 15.6pt, text(font: "CMU Sans Serif", weight: "bold", it))
  } else { it }
}

#v(-2.39pt)
#align(center)[
  #text(size: 23.32pt, weight: "bold")[Supplementary Information]
  #v(8.02pt)
  #text(size: 16.2pt, weight: "bold")[Odd dynamics of living chiral crystals]
]
#v(4.24pt)
#text(size: 10.26pt)[
Tzer Han Tan#super[1,2,3,5], Alexander Mietke#super[4,5], Junang Li#super[1,6], Yuchao~Chen#super[1,6], Hugh Higinbotham#super[1], \
Peter~J.~Foster#super[1], Shreyas~Gokhale#super[1], Jörn~Dunkel#super[4], Nikta~Fakhri#super[1,7]
]
#v(-5.75pt)
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
#v(73.7pt)
#outline(title: none, depth: 3, target: selector(heading).after(<supp-start>),
  indent: level => (0pt, 15.4pt, 39pt).at(calc.min(level, 2)))
#pagebreak()

#block(height: 0pt)<supp-start>
= Experiment
<experiment>


== Preparation of starfish embryos
<sec:Prep>
Starfish #emph[Patiria Miniata] were procured from South Coast Bio-Marine LLC. The animals were kept in salt water fish tanks maintained at 15$thin^compose$C. To fertilize embryos, we first extracted oocytes and sperm separately. Ovaries were extracted through a small incision made at the bottom of the starfish and were then carefully fragmented using a pair of scissors to release the oocytes. Extracted oocytes were washed twice with calcium free seawater to prevent maturation and incubated in artificial filtered seawater (FSW) at 15$thin^compose$C. The testes were extracted similarly and kept in a 1 mL Eppendorf tube at 4$thin^compose$C. To fertilize embryos, we first matured the oocytes by adding the hormone 1-methyladenine. After one hour, sperm extract was added to the culture at a 1:10000 dilution. Fertilized embryos were cultured in FSW at 15$thin^compose$C for the first 24~hours before being moved to 20$thin^compose$C.


== Clustering and flow field experiments
<sec:PIVexp>
All experiments have been performed at 20$thin^compose$C. For clustering experiments, the appropriate number of embryos was transferred to a well of a 24-well plate (VWR sterilized tissue culture plates, Catalog Number 10861-558, single well diameter: $15.7 thin$mm). The total water level height was, in all well-experiments, approximately 14 mm. Images were taken in 10 s intervals using a dissection scope (Nikon SMZ745) with a high-speed CMOS digital camera (Amscope MU500) attached at the eyepiece.


To measure flow fields around embryos, 2 $mu$m sized polystyrene beads (Bangs Lab, Catalog Number PS05001) were added to the medium. “Top-view\" cross-sectional flow field experiments (main text Fig.~2a--c, @fig:PIVfittingtrip) were performed with embryos oriented vertically near the fluid-air interface. Maximum projections of the bead dynamics are used to visualize stream lines (main text Fig.~1a). The corresponding data analysis is detailed in Sec.~@sec:FFanalsis. “Side-view\" flow field experiments (main text Fig~1b, @fig:SideViewFitResults) were performed by confining embryos and beads in a flow cell, where double-sided tape was used as a spacer to generate a flat channels with a height of $approx$ 100 $mu$m. The flow cell was sealed with Valap, and flows were imaged using bright-field illumination on a Leica microscope (DMIL LED) at a 50 ms interval with either a 10x/0.25 (N PLAN CY) or a 4x/0.10 (HI PLAN) objective. The corresponding data analysis is detailed in Sec.~@sec:FFanalsisSide. Embryo morphology images (main text Fig.~1b and @fig:Morphology) at different time points were obtained using the same experimental setup.


== Verification of proper development after cluster formation
<sec:Morp>
To verify that the embryos develop properly after they formed a living chiral crystal, we performed a standard clustering experiment (see Sec.~@sec:PIVexp) until about 72 hours post fertilization (hpf) when clusters have dissolved. The embryo solution was then diluted down to a low concentration of less than $10$ embryos/ml and randomly selected embryos were regularly imaged for up to 10 days following cluster dissolution~(@fig:Morphology, bottom row). At this point, embryos had developed well into the bipinnaria stage~($approx 3$ days post fertilization). As a control, we cultured embryos right after fertilization at a low density ($< 10$ embryos/ml). The morphology of these control embryos (@fig:Morphology, top row), is comparable to the morphology of embryos that underwent cluster formation, indicating that the formation of living chiral crystal does not interfere with the development into more advanced larval stages. We note that, even when embryo suspensions were kept at high density up to day 13 post fertilization, no additional collective phenomena comparable to the cluster formation during the first 2 to 3 days post fertilization were observed.


// [figvision-cn] imgs/FigS1.png
// 这是一张由两行五列组成的明场显微照片矩阵，展示胚胎在受
// 精后不同天数（3、6、8、10、13 dpf）的形态发育过程对比。
// 图像为灰度图（明场成像），每个子图右下角均有一根黑色比
// 例尺，根据图注和胚胎整体尺寸推断，比例尺长度约代表 200
// 微米，但图像未明确标注具体数值。所有图像无坐标轴、曲线
// 或色标。 第一行（顶部）标注为“Dilute-Dilute (Control)”，
// 对应图注中“受精后立即在低密度（具体数值未在图中显示，
// 图注中为空白）培养的胚胎”。从左至右依次为： 第 1 列，
// Day 3：胚胎呈典型的长椭圆形，内部可见暗色的眼点（两个
// 深色圆形结构）和体节轮廓，胚胎整体被一层透明卵膜包裹，
// 周边视野干净。 第 2 列，Day 6：胚胎形态变得更不规则，
// 卵膜轮廓松弛，内部眼点依然可见，但整体变宽，出现透明区
// 域。 第 3 列，Day 8：胚胎进一步变形，卵膜呈波浪状透明
// 结构，内部可见一个较大且清晰的暗色眼点，胚胎主体变窄，
// 周边有碎片。 第 4 列，Day 10：胚胎形态高度不规则，卵膜
// 呈花瓣状，内部眼点依然存在，胚胎整体显得松散，组织边界
// 模糊。 第 5 列，Day 13：胚胎形态严重变形，卵膜大范围透
// 明且呈褶皱状，内部保留一个眼点，整体结构松散，但未见明
// 显腐败。 第二行（底部）标注为“Concentrated-Dilute”，对
// 应图注中“经历了集群形成、并在 3 dpf 时被转移到稀释孔中
// 继续培养的胚胎”。从左至右依次为： 第 1 列，Day 3：胚胎
// 呈较紧凑的椭圆形，内部可见两个明显的暗色眼点，与对照组
// Day 3 形态相近，但整体略小、更圆。 第 2 列，Day 6：胚
// 胎形态开始变形，卵膜轮廓不规则，内部可见两个眼点，一个
// 清晰，另一个稍模糊。 第 3 列，Day 8：胚胎呈长条形，一
// 端有一个明显的暗色眼点，另一端有透明结构，整体形态与对
// 照组 Day 8 有差异，组织密度较低。 第 4 列，Day 10：胚
// 胎形态不规则，卵膜呈波浪状，内部可见两个暗色眼点，一个
// 位于中央偏下，另一个位于边缘，整体结构松散。 第 5 列，
// Day 13：胚胎形态类似对照组 Day 13 但更短，卵膜透明且呈
// 褶皱状，内部保留一个眼点，整体结构松散，未见明显腐败。
// 总体趋势：两组胚胎在 3 dpf 时形态相似，均具有眼点和卵
// 膜。随着时间推移，两组胚胎的卵膜均逐渐松弛、变形，组织
// 密度下降，但对照组（Dilute-Dilute）胚胎在后期（Day
// 10-13）形态更不规则、卵膜更透明且呈花瓣状，而
// Concentrated-Dilute 组胚胎在 Day 13 时形态相对更紧凑，
// 但内部结构同样松散。两组胚胎均未出现明显腐败，表明集群
// 形成后转移至稀释条件不影响胚胎存活至 13 dpf，但可能影
// 响后期形态的规整度。图像中无文字标注除行标签和天数外。
#figure(image("imgs/FigS1.png", width: 97.0%),
  caption: [
    #strong[Embryo development after cluster formation.] Cluster formation and dissolution takes place during the first 3 days post fertilization~(dpf). Top row:~Morphologies of embryos that were right after fertilization cultured at low density ($< 10$ embryos/ml). Time points indicate dpf. Bottom row:~Embryos that underwent cluster formation were transferred at 3 dpf to a dilute well for further culturing and imaging up to 13 dpf. Morphologies of embryos that formed living chiral crystals show no notable differences when compared to the control (top-row). For experimental details see Sec.~@sec:Morp. Scale bar,~100 $mu$m.
  ]
)
<fig:Morphology>



== Sedimentation of inactive embryos
<sec:SedExps>
To estimate the embryo's negatively buoyant weight force $F_g$, we performed a sedimentation experiment. Embryos were immobilized by treatment with 1 mM of the metabolic inhibitor~#link(<si-1>)[[1]] Sodium Azide $N a N_3$. They were then transferred to a long Pasteur pipette (diameter 7 mm) and released from the top position. The process of immobilized embryo sedimentation was video-recorded and embryos were tracked to determine sedimentation velocities $v_s$. Using the measured velocities, $v_s = ( 0.6 plus.minus 0.1 ) thin$mm/s (mean $plus.minus$ standard deviation, $n = 7$), an effective embryo size of $L = ( ell_(upright("min")) + ell_(upright("maj")) ) slash 2 approx ( 150 plus.minus 30 ) thin mu$m during mid to later stages of experiments (see #ref(<fig:SideViewFitResultsfortheo>)c,d), we find $F_g slash eta = ( 1.7 plus.minus 0.4 ) thin$mm$""^2$/s from equating the approximate Stokes drag $6 pi eta L v_s$ with the weight force $F_g$. Using viscosity of water ($eta = 1 thin$mPa$dot.op$s at 20$thin^compose$C) the negatively buoyant weight force is therefore of the order $F_g approx 1 - 2 thin$nN.


= Theory
<theory>
The length and time scales, $L tilde 150 thin mu$m (typical embryo size, see #ref(<fig:SideViewFitResultsfortheo>)c,d) and $v tilde 0.1 thin$mm/s (typical flow speed), relevant for the embryo dynamics correspond to a Reynolds number of $upright("Re") tilde 1.5 times 10^(- 2)$ and therefore allow for a theoretical description of our system in terms of overdamped Stokesian hydrodynamics. Within this framework, we provide in this section a quantitative description of the hydrodynamics and orientational stability of surface-bound embryos~(Sec.~@sec:Hydbd), introduce an experimentally parametrized minimal model of cluster formation~(Sec.~@sec:HydrModel) and discuss effective macroscopic material properties expected to arise from the microscopic interactions among embryos~(Sec.~@sec:MappingDetails).


== Hydrodynamics of single embryos and their bound states
<sec:Hydbd>
The fluid flows surrounding embryos are generated by the beating of cilia that cover the embryo's body. Such an interactions with the fluid can lead to the propulsion and rotation of embryos, and it affects how embryos interact with each other. For low-Reynolds number microswimmers it is well-established that their dynamics and hydrodynamic interactions can be modulated by nearby fluid-substrate interfaces~#link(<si-2>)[[2, 3, 4, 5]] or free fluid surfaces~#link(<si-6>)[[6]]. Building on the corresponding ideas, we aim to develop in this section a quantitative and mechanistic understanding of how starfish embryos form stable surface bound states and how interactions between them lead to the observed phenomenology of cluster formation and dissolution. While the analysis presented here focuses exclusively on hydrodynamic effects, we note that also nonhydrodynamic effects, such as bottom- or top-heaviness, can in principle affect the orientational stability of microswimmers~#link(<si-4>)[[4]].


The theoretical analysis of hydrodynamic embryo properties and bound states proceeds in several steps: First, using Stokes flow singularities, we introduce a generic description of the flow fields surrounding a microswimmer below a free fluid surface as a function of its body axis orientation (Secs.~@sec:FFms and @sec:Image). Second, using Faxen's law, we derive a criterion for the orientational stability of such a generic microswimmer as function of the singularity amplitudes~(Sec.~@sec:StabAnalFull). In the last step, we explain how the singularity amplitudes can be parametrized by experiments as a function of developmental time~(Sec.~@sec:DevModePara) and evaluate the derived stability criterion~(@sec:stabtimefinal). Finally, we focus on the dominant Stokeslet singularity and show that it is essential for both the upright bound state stability and for generating an effective hydrodynamic attraction that facilitates the formation of clusters~(@sec:Stokeslet).


=== Far-field description of fluid flow surrounding microswimmers
<sec:FFms>
To understand the hydrodynamic effects that contribute to bound state stabilization and destabilization near a fluid-air interface, we require a tractable parametrization of the fluid flows that surround embryos. Here, we use a systematic expansion in terms of flow singularities that are constructed from the Green's function of the Stokes equation $eta nabla^2 upright(bold(v)) - nabla p = 0$, where $eta$ is the viscosity and the pressure $p$ is determined by the incompressibility condition $nabla dot.op upright(bold(v)) = 0$. Up to order $1 slash r^3$, the relevant axisymmetric flow singularities are given by~#link(<si-5>)[[5, 7]] 


$ upright(bold(v))_(upright("st")) ( upright(bold(r))   upright(bold(p)) ) & = a R_0 slash r [upright(bold(p)) + ( upright(bold(p)) dot.op upright(bold(e))_r ) upright(bold(e))_r] upright("(Stokeslet)")\
upright(bold(v))_(upright("fd")) ( upright(bold(r))   upright(bold(p)) ) & = b R_0^2 slash r^2 [3 ( upright(bold(p)) dot.op upright(bold(e))_r )^2 - 1] upright(bold(e))_r upright("(Force-dipole)")\
upright(bold(v))_(upright("fq")) ( upright(bold(r))   upright(bold(p)) ) & = c R_0^3 slash r^3 [upright(bold(p)) - 3 ( upright(bold(p)) dot.op upright(bold(e))_r )^2 upright(bold(p)) - 9 ( upright(bold(p)) dot.op upright(bold(e))_r ) upright(bold(e))_r + 15 ( upright(bold(p)) dot.op upright(bold(e))_r )^3 upright(bold(e))_r] upright("(Force-quadrupole)")\
upright(bold(v))_(upright("sd")) ( upright(bold(r))   upright(bold(p)) ) & = d R_0^3 slash r^3 [3 ( upright(bold(p)) dot.op upright(bold(e))_r )^2 upright(bold(e))_r - upright(bold(p))] upright("(Source-dipole)") . $<eq:singall>


Here, $upright(bold(r)) = ( x , y , z )^top$, $r = | upright(bold(r)) |$, $upright(bold(e))_r = upright(bold(r)) slash r$, and~$upright(bold(p))$ is a unit vector ($| upright(bold(p)) | = 1$) that will be identified below with the embryo's major body axis. The length scale $R_0$ is in general related to the size of the microswimmer. However, its concrete value depends on the specific context in which the singularities Eqs.~(@eq:singall) are used and may differ from the length $L = ( ell_(upright("min")) + ell_(upright("maj")) ) slash 2 approx 150 thin mu$m (see #ref(<fig:SideViewFitResultsfortheo>)c,d) that we use mostly for basic scale arguments. Due to the absence of systematic rotary flows surrounding single embryos, rotlet contributions with $| upright(bold(v)) | tilde 1 slash r^3$ are not included in this analysis and only become relevant in the case of embryo interactions (Sec.~@sec:PIVfit).


The coefficients $a , b , c$ and $d$ in Eqs.~(@eq:singall) are determined by the details of how the microswimmer interacts with the fluid, in particular by the flows generated near the surface of the microswimmer's body. To make this connection explicit, we consider a nondeforming spherical surface of radius~$R_0$ at rest, $v_r ( r = R_0 ) = 0$ and $upright(bold(v)) ( r arrow.r oo ) = 0$, that is immersed in an unbound fluid and generates a tangential surface flow


$ v_theta ( r = R_0 ) = alpha sin theta + beta sin 2 theta + gamma sin 3 theta . $<eq:vtheta>


Here, $( r , theta , phi.alt )$ define spherical coordinates that are related to the Cartesian coordinates above by $x = r sin theta cos phi.alt , thin y = r sin theta sin phi.alt , thin z = r cos theta$, and $alpha$, $beta$ and $gamma$ denotes parameters that will later be determined from experiments (see Secs.~@sec:DevModePara and @sec:FFanalsisSide). Using analytic solutions of the Stokes equation~#link(<si-8>)[[8]], implementing the boundary condition Eq.~(@eq:vtheta) and comparing the solution with the singularities in Eqs.~(@eq:singall) for $upright(bold(p)) = upright(bold(e))_z$, one finds far field flows of the form


$ upright(bold(v)) = upright(bold(v))_(upright("st")) + upright(bold(v))_(upright("fd")) + upright(bold(v))_(upright("fq")) + upright(bold(v))_(upright("sd")) + cal(O) ( R_0^4 slash r^4 ) $<eq:SingExp>


with coefficients given by


$ a = gamma slash 10 - alpha slash 2 quad b = - beta quad c = - 2 gamma slash 3 quad d = alpha slash 2 - 11 gamma slash 30 . $<eq:SingCoeffs>


In Sec.~@sec:DevModePara, we describe how flow field measurements can be used to parametrize the coefficients $alpha$, $beta$ and $gamma$ in Eq.~(@eq:vtheta) over the relevant developmental time frame.


The orientation $upright(bold(p)) = upright(bold(e))_z$ used to derive the coefficients in Eq.~(@eq:SingCoeffs) reflects the azimuthal symmetry axis of the boundary condition Eq.~(@eq:vtheta) and therefore fully determines the symmetry axis of this solution. Using the same coefficients $a , b , c$ and~$d$ with another orientation $upright(bold(p)) = upright(bold(p))_0$ in the flow singularities Eqs.~(@eq:singall) therefore yields a far field flow that solves an analog boundary value problem to order $cal(O) ( R_0^4 slash r^4 )$ in which the boundary condition Eq.~(@eq:vtheta) is rotated such that the azimuthal symmetry axis is given by $upright(bold(p))_0$. Hence, the singularity expansion Eq.~(@eq:SingExp) with coefficients given in Eq.~(@eq:SingCoeffs) provides a tractable parametrization of flows surrounding a microswimmer with arbitrary orientation~$upright(bold(p))$.


=== Image construction near free fluid surfaces
<sec:Image>
In the next step, we describe how the far-field flows derived in the previous section are modified by the nearby fluid-air interfaces. We place the origin of the coordinate system on the fluid surface and align the $z$-axis with the surface normal pointing away from the fluid. For simplicity, we do not take into account shape changes of the fluid surface due to the presence of embryos and treat it as a nondeforming and shear stress-free interface. This corresponds to nondeforming, stress-free boundary conditions $v_z |_(z = 0) = 0$ and $E_(x z) |_(z = 0) = E_(y z) |_(z = 0) = 0$, where $upright(bold(E)) = [ nabla upright(bold(v)) + ( nabla upright(bold(v)) )^top ] slash 2$ is the strain rate tensor. Consider then any of the flow singularities in Eqs.~(@eq:singall) at a position $upright(bold(r))_0 = ( x_0 , y_0 , - h )^top$, where $h > 0$ is the distance below the surface. Flow fields $upright(bold(v)) = macron(upright(bold(v)))$ that obey nondeforming, free boundary conditions at $( x , y , 0 )$ can be constructed by complementing the singularity with a suitable image~#link(<si-6>)[[6]] above the surface at $upright(bold(r))'_0 = ( x_0 , y_0 , h )^top$. For example, the flow field


$ macron(upright(bold(v)))_(upright("st")) ( upright(bold(r)) ; upright(bold(p)) , upright(bold(r))_0 ) = upright(bold(v))_(upright("st")) ( upright(bold(r)) - upright(bold(r))_0 ; upright(bold(p)) ) + upright(bold(v))_(upright("st")) ( upright(bold(r)) - upright(bold(r))'_0 ; upright(bold(p))' ) $<eq:Stokeslet>


with $upright(bold(p))' = ( p_x , p_y , - p_z )^top$ corresponds to a solution of the Stokes equation that describes fluid flows originating from a Stokeslet at $upright(bold(r))_0 = ( x_0 , y_0 , - h )^top$ below a nondeforming, stress-free fluid surface at $z = 0$. The same construction as Eq.~(@eq:Stokeslet) also yields force-dipole, force-quadrupole and source-dipole flows that solve the Stokes equation below a nondeforming, stress-free fluid surface.


=== Stationary orientations and stability near free surfaces
<sec:StabAnalFull>
Using the flow parametrization derived in Secs.~@sec:FFms and~@sec:Image, we can now study how hydrodynamic effects influence the orientation of microswimmers near a free surface. To this end, we identify the unit vector $upright(bold(p))$ as the embryo's major body axis pointing from posterior (P) to anterior (A) and use the generalized Faxen's law for a prolate ellipsoidal body~#link(<si-7>)[[7,5]]:


$ frac(d upright(bold(p)), d t) & = 1 slash 2 [nabla times upright(bold(v))'] times upright(bold(p)) + chi [ upright(bold(p)) times (upright(bold(E))' dot.op upright(bold(p))) ] times upright(bold(p)) . $<eq:Faxen>


Equation~(@eq:Faxen) describes the dynamics of the body axis orientation $upright(bold(p))$ in response to external flows~$upright(bold(v))'$, including image flow contributions. The corresponding strain rate tensor is given by $upright(bold(E))' = [nabla upright(bold(v))' + ( nabla upright(bold(v))' )^top] slash 2$. The geometric parameter $chi = ( 1 - e^2 ) slash ( 1 + e^2 )$, with $e = ell_(upright("min")) slash ell_(upright("maj"))$ being the semi-minor~($ell_(upright("min"))$) to semi-major axis~($ell_(upright("maj"))$) ratio, captures shape anisotropies of the immersed body with $chi = 0$ for a perfect sphere and $chi > 0$ for any elongated, ellipsoidal body. For a single microswimmer below the fluid surface, $upright(bold(v))'$ in Eq.~(@eq:Faxen) is given by the microswimmer's image flow. For the image flow $upright(bold(v))' = upright(bold(v)) ( upright(bold(r)) - upright(bold(r))'_0   upright(bold(p))' )$ with $upright(bold(v))$ given in Eq.~(@eq:SingExp) and singularities listed in Eqs.~(@eq:singall), we find from Eq.~(@eq:Faxen) the director dynamics


$ frac(d p_x, d t) = 3 slash 16 f ( p_z ) p_z p_x frac(d p_y, d t) = 3 slash 16 f ( p_z ) p_z p_y frac(d p_z, d t) = 3 slash 16 f ( p_z ) ( p_z^2 - 1 ) , $<eq:Dynpcart>


where


$ f ( p_z ) = frac(2 b R_0^2, h^3) p_z + frac(c R_0^3, h^4) ( 5 p_z^2 - 1 ) + chi (frac(4 a R_0, h^2) p_z + frac(2 b R_0^2, h^3) p_z^3 + frac(c R_0^3, h^4) ( p_z^2 - 1 ) ( 3 p_z^2 + 2 ) + frac(d R_0^3, h^4) ( 1 + p_z^2 )) . $<eq:fp>


Here, $a , b , c$ and $d$ denote amplitudes of the different singularities listed in Eqs.~(@eq:singall) and $h$ is the distance to the fluid surface. Equations~(@eq:Dynpcart) imply $frac(d, d t) ( p_x p_y^(- 1) ) = 0$, indicating that the dynamics of $upright(bold(p))$ is at all times confined to a single plane that contains the $z$-axis and is fixed by initial conditions. Without loss of generality, this plane is chosen in the following to be the $x z$-plane. Together with the normalization of the director $| upright(bold(p)) | = 1$, only one dynamic degree of freedom remains. Parameterizing the unit director as $p_x = sin theta_(upright("p"))$ and $p_z = cos theta_(upright("p"))$, Eqs.~(@eq:Dynpcart) finally yield


$ frac(d theta_(upright("p")), d t) = 3 slash 16 f ( p_z ) sin theta_(upright("p")) . $<eq:OrientDyn>


#emph[Stationary orientations and linear stability:] The dynamics Eq.~(@eq:OrientDyn) has stationary orientations $theta_(upright("p"))^(*) = 0$ and $theta_(upright("p"))^(*) = pi$, corresponding to $p_z^(*) = cos theta_(upright("p"))^(*) = plus.minus 1$ and therefore rationalizes the perfectly upright oriented state $p_z^(*) = 1$ seen in experiments. Additionally, skewed stationary orientations with $sin theta_(upright("p"))^(*) eq.not 0$ exist that can be found numerically from~$f ( p_z^(*) ) = 0$. Stationary orientations are stable if


$ - sin^2 theta_(upright("p"))^(*) frac(d f, d p_z)|_(p_z^(*)) + cos theta_(upright("p")) f ( p_z^(*) ) < 0 $<eq:StabCrit>


and unstable if the left-hand side of Eq.~(@eq:StabCrit) becomes larger than zero. The stability properties of the stationary upright orientation $theta_(upright("p"))^(*) = 0$ ($p_z^(*) = 1$) can according to Eq.~(@eq:StabCrit) directly be read off the sign of $f ( 1 )$ for $f ( p_z )$ given in Eq.~(@eq:fp), once the singularity amplitudes $a , b , c$ and $d$ have been specified. The latter are parametrized through Eq.~(@eq:SingCoeffs) by developmental changes of the flows generated near embryo surfaces~(Sec.~@sec:DevModePara), leading to different sationary orientations and stability properties as embryo development progresses (Sec.~@sec:stabtimefinal).


// [figvision-cn] imgs/FigS2.png
// 子图a为折线图，横轴为模态序号n（标记为1、2、3，下方分
// 别注有α、β、γ），纵轴为归一化模态系数Bn/|B1|，范围约
// -0.5至1.5。图例显示三条曲线：黄色“早期<8小时”、蓝色“中
// 期8...30小时”、橙色“晚期>30小时”；各数据点带误差棒。趋
// 势显示：在n=1处三组值约1.0，n=2处降至约-0.2，n=3处早期
// 约0.1、中期约0.4、晚期约0.6。每个数据点配有单独的细灰
// 线连接，表示均值与标准差。三条曲线均在n=2处出现明显低
// 谷。该图说明用于参数化胚胎表面流场的归一化模态系数随发
// 育时间的变化。子图b为三幅并排的流场模型示意图，分别对
// 应早期（黄框，xd=0）、中期（蓝框，xd=0.5）和晚期（红框，
// xd=1）。每幅图中心有一个圆形胚胎，灰色流线（带箭头）描
// 绘表面流场，外围有矩形封闭边界；图内标注有胚胎表面单位
// 矢量e_φ与e_r、坐标系x̃、ỹ（位于左下角，仅首幅图）。上
// 方插图为胚胎形状随发育的示意图：早期为圆形，中期轻微拉
// 长，晚期进一步拉长。该图展示发育参数化流场模型随发育阶
// 段的变化：流场从近似对称的闭合涡旋模式（xd=0）逐渐演化
// 为更复杂、具有不对称性的模式（xd=1），同时胚胎形状由圆
// 变长。子图c为示意图，展示一个浅灰色椭圆状胚胎，标注长
// 半轴ℓ_maj（竖向双箭头）和短半轴ℓ_min（横向双箭头）。子
// 图d为散点图，横轴为时间（小时），范围约0至55；纵轴为长
// 度（微米），范围60至220。图例：圆形标记为长半轴ℓ_maj，
// 倒三角标记为短半轴ℓ_min；颜色与图a一致：黄色（<8小时）、
// 蓝色（8-30小时）、橙色（>30小时）。数据点显示：长半轴
// 随发育时间增加（约90微米升至200微米以上），短半轴大致
// 维持在80至120微米区间，且长半轴离散度随发育增大。该图
// 直接呈现胚胎长、短半轴的发育变化，支持长轴优先伸长的结
// 论。子图e为散点图，横轴为时间（小时），范围约0至55；纵
// 轴为体伸长量X，范围0至0.6。颜色映射与图d一致：黄色方块
// （<8小时）、蓝色方块（8-30小时）、橙色方块（>30小时）。
// 图中有一条黑色虚线，为线性拟合，斜率约0.009/小时（表明
// 体伸长量随时间大致线性增加）。该图显示体伸长量随发育时
// 间逐步增大。
#figure(image("imgs/FigS2.png", width: 99.0%),
  caption: [
    #strong[Developmental parametrization of lateral embryo surface flows and body aspect ratios.] #strong[a,]~Normalized mode coefficients over development (mean and standard deviation) used to parametrize flows generated on the embryo surface via Eq.~(@eq:vtheta). Values were extracted from experimentally measured flows surrounding confined embryos (see Sec.~@sec:PIVfitSide, @fig:SideViewFitResults) and correspond to generalized squirmer parameters~#link(<si-6>)[[6]]. #strong[b,]~Validating the minimal parametrization of embryo surface flows: Solutions of the Hele-Shaw flow Eq.~(@eq:HS) using boundary condition Eq.~(@eq:bcHS) with values from $upright(bold(a))$ show good agreement with the characteristic streamline features seen in experiments (insets, reproduced from #ref(<fig:SideViewFitResults>)b). #strong[c,]~Illustration of semi-minor length~$ell_(upright("min"))$ and semi-major length~$ell_(upright("maj"))$ used to characterize embryo size. #strong[d,]~Measurements of $ell_(upright("min"))$ and $ell_(upright("maj"))$ over development. For basic scale arguments, we use a characteristic embryo size during mid to later stages $L = ( ell_(upright("min")) + ell_(upright("maj")) ) slash 2 approx 150 thin mu$m. #strong[e,]~The embryo's body elongation is characterized by the geometric parameter $chi = ( 1 - e^2 ) slash ( 1 + e^2 )$ with $e = ell_(upright("min")) slash ell_(upright("maj"))$. Heuristic linear and power-law interpolations (Eqs.~(@eq:DevParas)) of data in #strong[a] and #strong[e] (dashed line), respectively, are used to analyze orientational stability over development of embryos below a free fluid surface (Secs.~#ref(<sec:FFms>)--@sec:stabtimefinal, main text Fig.~2j).
  ]
)
<fig:SideViewFitResultsfortheo>



=== Mode parametrization of embryo surface flows
<sec:DevModePara>
The analysis from the previous section allows us to determine stationary body axis orientations and their linear stability properties and connects them through Eqs.~(@eq:singall)--(@eq:SingCoeffs) directly to the fluid flows generated near the microswimmer's body surface. In the next step, we want to experimentally infer these near-surface embryo flows in a form that can be integrated via Eq.~(@eq:vtheta) into the stability analysis. To this end, we have measured fluid flows in a “side-view\" plane along the AP body axis of confined embryos at different developmental stages~(#ref(<fig:SideViewFitResults>)a) and extracted a low-dimensional representation in terms of a mode expansion of Hele-Shaw flow solutions~(Sec.~@sec:PIVfitSide, #ref(<fig:SideViewFitResults>)b). Despite the embryo's developmental body shape changes from a close-to-spherical to more elongated shapes over the course of experiments ($tilde 0 - 50$ hours), fluid flows in this plane retain a high level of symmetry and, as a result, are captured by a small number of modes that can be specified in cylindrical coordinates (Eq.~(@eq:HSsol), #ref(<fig:SideViewFitResults>)c). The following two observations allow us to further simplify the parametrization of embryo surface flows~(#ref(<fig:SideViewFitResultsfortheo>)a): $i )$~The modes~$B_n$, in particular $B_1 , thin B_2$ and $B_3$ represent the dominant contributions to the fits, and $i i )$~due to the linearity of Eqs.~(@eq:OrientDyn) in fluid flows, stationary orientations and their stability will only depend on relative values of mode amplitudes. Akin to the definition of a squirmer parameter~#link(<si-6>)[[6]], we therefore focus in the following on the modes $B_1 , thin B_2$ and $B_3$ and normalize each of the pooled data sets (Early, Mid, Late) by the corresponding mode amplitude~$| B_1 |$. Note, for this normalization $B_2 slash | B_1 |$ corresponds to a classical squirmer parameter~#link(<si-6>)[[6]] and #ref(<fig:SideViewFitResultsfortheo>)a suggests starfish embryos are weak pushers ($| B_2 | slash | B_1 | lt.double 1$ with $B_2 slash | B_1 | < 0$).


Finally, we verify that such a simplified parametrization does recapitulate the flow profiles seen in side-view~PIV measurements of confined embryos (@fig:SideViewFitResults). Indeed, when solving the Hele-Shaw Eq.~(@eq:HS) around a circular unit disk with boundary flow profile


$ V_phi = alpha sin phi + beta sin 2 phi + gamma sin 3 phi $<eq:bcHS>


using $alpha = 1$ and the measured values of $beta$ and $gamma$ indicated in #ref(<fig:SideViewFitResultsfortheo>)a, we find flow solutions that exhibit the same evolution of features as seen in experiments (compare #ref(<fig:SideViewFitResults>)a,b with #ref(<fig:SideViewFitResultsfortheo>)b): Initially, an almost centered pair of vortices (closed streamlines) is present at the lateral sides~(Early) and moves over time towards the posterior end of embryos~(Mid), which is a consequence of the increasing pusher amplitude $| beta |$. At later stages an increasing contribution from the quadrupole mode $tilde gamma$ leads to the appearance of a second vortex pair near the embryo's anterior~(Late).


=== Stationary orientations and stability as function of developmental time
<sec:stabtimefinal>
To integrate the two-dimensional surface flow parametrization from the previous section through the boundary condition Eq.~(@eq:vtheta) and corresponding singularity amplitudes Eqs.~(@eq:SingCoeffs) into the three-dimensional stability analysis, we assume lateral embryo surface flows are axisymmetric with respect to the AP body axis. In this case, we can identify the azimuthal angle $phi$ used in Eq.~(@eq:bcHS) and defined in #ref(<fig:SideViewFitResultsfortheo>)b with the polar angle used in the stability analysis Secs.~#ref(<sec:FFms>)--@sec:StabAnalFull, i.e. $theta tilde.eq phi$ for $phi in [ 0 , pi )$ and $theta tilde.eq 2 pi - phi$ for $phi in [ pi , 2 pi )$, and may directly use the the coefficients $alpha = 1$, $beta$ and $gamma$ (#ref(<fig:SideViewFitResultsfortheo>)a) in Eqs.~(@eq:SingCoeffs) to determine the different singularity amplitudes. Combining this with measurements of minor and major embryo body axis lengths that define the aspect ratio~$chi = ( 1 - e^2 ) slash ( 1 + e^2 )$, with $e = ell_(upright("min")) slash ell_(upright("maj"))$ (#ref(<fig:SideViewFitResultsfortheo>)c,d), we can define an interpolated developmental parametrization of the embryo's properties in the form


$ beta ( x_d ) = - 0.2 x_d gamma ( x_d ) = 0.6 x_d chi ( x_d ) = 0.5 x_d^(1 slash 2) , $<eq:DevParas>


where $x_d in [ 0 , 1 ]$ represents a developmental coordinate that maps to experimental time points as $t_d = x_d times 50$ h. The functions $beta ( x_d )$ and $gamma ( x_d )$ interpolate linearly towards the largest mode amplitudes of $min ( B_2 slash | B_1 | ) approx - 0.2$ and $max ( B_3 slash | B_1 | ) approx 0.6$~(#ref(<fig:SideViewFitResultsfortheo>)a). The function $chi ( x_d )$ represents the best power-law fit to the data shown in #ref(<fig:SideViewFitResultsfortheo>)e (black dashed line) and heuristically parametrizes developmental changes of the embryo body shape. Using the parametrization Eqs.~(@eq:DevParas) in Eqs.~(@eq:OrientDyn) and (@eq:StabCrit) with $h slash R_0 = 1$ in Eq.~(@eq:fp) then determines stationary orientations and their linear stability as a function of developmental time~$t_d$, as depicted and discussed in~Fig.~2j of the main text.


=== Stokeslet hydrodynamics of bound embryos
<sec:Stokeslet>
The analysis of the previous sections was based on fluid field measurements surrounding confined embryos within an effectively two-dimensional geometry. We finally want to verify that the basic orientational stability established by this analysis is compatible with flow fields surrounding surface-bound and freely spinning embryos in the experimental setting used to study cluster formation. In this case, we only have direct experimental access to “top-view\" flow field information recorded for bound embryos from above the fluid surface (main text Fig.~2a,b). From the flow field measurements around confined embryos used in the analysis above, we expect relative contributions to dipole flows $tilde 1 slash r^2$ set by~$beta$ in #ref(<fig:SideViewFitResultsfortheo>)a are small. The next potentially relevant singularity contribution is short-ranged ($tilde 1 slash r^3$), such that the Stokeslet flow ($tilde 1 slash r$) is expected to be the dominant contribution to “top-view\" flow fields. We therefore focus here on direct measurements of the embryo's Stokeslet strength and its independent validation via sedimentation experiments. Additionally, we discuss in this section the impact of a curved fluid-air interface. \


#strong[Stokeslet strength and negative bouyancy]


From sedimentation experiments (Sec.~@sec:SedExps), we know that starfish embryos are negatively buoyant. When bound and stationary below the surface, the weight force of embryos must then be encoded in the flow fields surrounding the embryo. To test this, we have fitted experimental measurements of top-view flow fields in the $x y$-plane using the image construction Eq.~(@eq:Stokeslet) with Stokeslet singularity Eq.~(@eq:singall) and $upright(bold(p)) = upright(bold(e))_z$ (see Sec.~@sec:PIVfit for details of the fitting procedure). The singularity parameter $a$ in Eq.~(@eq:singall) is related to the Stokeslet force $F_(upright("st"))$ by


$ a = - frac(F_(upright("st")), 8 pi R_0 eta) , $<eq:Stoka>


where~$eta$ denotes the fluid viscosity. Consistent with our expectation that the Stokeslet represents the dominant contribution to “top-view\" flow fields, we find that the latter are indeed captured well by the Stokeslet flow Eq.~(@eq:Stokeslet) below a fluid surface~(Fig.~2b, main text). The fitted Stokeslet strength $F_(upright("st")) slash eta = ( 2.6 plus.minus 0.3 ) thin$mm$""^2$/s is comparable to the negatively buoyant weight force $F_g slash eta = ( 1.7 plus.minus 0.4 ) thin$mm$""^2$/s estimated from independent sedimentation experiments~(Sec.~@sec:SedExps) and does not change substantially during the experimental time window~(#ref(<fig:StokesletHydrod>)a). Assuming a viscosity of water ($eta = 1 thin$mPa$dot.op$s at 20$thin^compose C$), we therefore find $F_(upright("st")) approx 2 - 3 thin$nN. The fact that $F_(upright("st")) > F_g$ suggests the presence of a small counter-force $F_Delta = F_(upright("st")) - F_g approx 1 thin$nN. With the surface tension of a water-air interface ($sigma_(upright("H")_2 upright("O")) approx 70 times 10^(- 3) thin$N/m at 20$""^compose$C) and for an embryo area of approximately $ell_(upright("min"))^2 = 100^2 thin mu$m$""^2$ (see #ref(<fig:SideViewFitResultsfortheo>)c,d) pushing against the surface, any interface curvature radius smaller than $ell_(upright("min"))^2 sigma_(upright("H")_2 upright("O")) slash F_Delta approx 70 thin$cm is sufficient to provide such a counter-force. This value is much larger than the well diameter of $1.6 thin$cm, such that normal forces resulting from surface tension are indeed a plausible source of the counter-force~$F_Delta$, even if the fluid-air interface is only weakly curved near the center of the well.


The flow seen in the $x z$-plane as described by these fits is shown in~#ref(<fig:StokesletHydrod>)b. As in the case of Stokeslet flow below a rigid surface~#link(<si-4>)[[4]], a strong lateral inwards flow will draw in nearby embryos and thereby generates an effective attraction between them. A Stokeslet of strength $F_(upright("st")) slash eta$ captures the spatial profile and strength of this attraction~#link(<si-3>)[[3]]. Below, we will use this experimental parametrization of hydrodynamic attraction to describe the corresponding embryo interactions in a minimal hydrodynamic model~(Sec.~@sec:HydrModel).


Finally, we note that the embryo's spinning motion around its own AP axis as such has no systematic effect on the surrounding fluid flow. Interestingly, a torque-free spherical body that generates an azimuthally symmetric, rotary surface flow also rotates in the lab frame, but does not drive any flow in its environment~#link(<si-6>)[[6]]. This solution remains valid in the vicinity of a nondeforming shear stress-free interface and therefore provides a scenario that is consistent with experimental observations. \


#strong[Bound state orientations near curved fluid surfaces]


The fluid-air interfaces in finite-sized wells used in experiments are weakly curved. In the following, we show that this can lead to slightly tilted, but still linearly stable embryo orientations with an essentially upright AP~axis. For simplicity, we describe fluid flows surrounding an embryo as a pure Stokeslet flow, but note that qualitatively similar results can be found when higher order singularities as described in Secs.~#ref(<sec:FFms>)--@sec:StabAnalFull are included.


// [figvision-cn] imgs/FigS3.png
// 子图 a 为带误差棒的散点图。横轴为 Time (hours)，范围 0
// 到 45，主刻度间隔 10；纵轴为 Stokeslet strength Fst/η
// (mm²/s)，范围 0 到 5，主刻度间隔 1。每个时间点（约 1、
// 13、20、24、38、43 小时）有若干灰色小圆点，表示单次拟
// 合值；蓝色大圆点表示均值，蓝色竖线误差棒表示标准差。数
// 据趋势显示，Stokeslet 强度在实验早期（约 1 小时）均值
// 约 2.6 mm²/s，在 13 小时附近升至约 3.4 mm²/s，在 20 到
// 24 小时附近降至约 2.5 mm²/s，38 小时附近升至约 3.0 mm²
// /s，43 小时附近降至约 2.2 mm²/s；单次拟合值散布范围约
// 1.4 到 4.1 mm²/s。 子图 b 为侧视流场等值线/伪彩图。横
// 轴为 x/R，范围 -3 到 3，主刻度间隔 1；纵轴为 z/R，范围
// -3 到 0，主刻度间隔 1。中央 x/R 介于 -1 与 1 之间的矩
// 形区域为灰色，不显示流场；两侧显示流场。白色流线呈从自
// 由表面（z/R=0）向下并向中心再向上回流的环状结构，在 x/
// R 约 -1 和 1 处形成一对反向旋转的涡。右侧色标标注 "
// xy-plane flow amplitude (mm/s)"，范围 0 到 0.5，颜色由
// 深蓝（低）经青色、绿色到黄色（高）；最高流速集中在灰色
// 区域两侧靠近自由表面的位置。左侧下方有白色坐标轴示意，
// 水平箭头标 x，垂直箭头标 z。 子图 c 为三个示意小图的组
// 合。左图：z 轴向上、x 轴向右，z=0 处有水平自由表面线，
// 虚线穿过表面。表面下方有一红色半圆，其法向标有 F，指向
// 右下方；表面上方有一镜像红色半圆，标有 F'，指向右上方；
// 两红色半圆法线与竖直方向夹角标为 θg，左上角有斜向下的
// 重力加速度 g 箭头。右图：上方为平行水平线之间充满浅蓝
// 色流体的通道，绿色实心圆点位于其中，虚箭头向右表示速度；
// 下方为倾斜直线表示液-液或液-气界面，绿色实心圆点位于界
// 面附近，标有 p，界面法向用虚线表示，实箭头指向右上方，
// 虚箭头沿界面方向指向右方。左上角有向下的 g 箭头。
#figure(image("imgs/FigS3.png", width: 97.0%),
  caption: [
    #strong[Stokeslet description of single embryos bound below a free fluid surface.] #strong[a,]~Stokeslet strength $F_(upright("st"))$ normalized by fluid viscosity $eta$ from fits of in-plane flow fields (Sec.~@sec:PIVfit) over time course of experiments. Gray dots depict individual fit values, blue dots and error bars represent mean and standard deviation, respectively. #strong[b,]~Side-view of Stokeslet flow below a free surface (Eq.~(@eq:Stokeslet) with $upright(bold(r))_0 = ( 0 , 0 , - R )^top$, $F_(upright("st")) slash eta = 2.6 thin$mm$""^2$/s, $R = 110 thin mu$m). White lines depict stream lines in the $x z$-plane and colors indicate the amplitude of flows parallel to the $x y$-plane. The dominantly lateral in-flow leads to an effective attraction between embryos. #strong[c,]~Image Stokeslet construction below a free surface ($z = 0$) that allows for an angle $theta_g$ between surface normal and gravity $upright(bold(g))$ (left) to represent embryos below a curved fluid surface present in small wells (right). Under a surface that is locally not orthogonal to gravity, a tilted stationary orientation enhances the accumulation of embryos near the well center (Sec.~@sec:Stokeslet).
  ]
)
<fig:StokesletHydrod>



For a curved fluid surface, the surface normal along which image flow singularities are reflected is in general not parallel to gravity, but may enclose a finite angle $theta_g$. We chose the plane of this tilt without loss of generality to be parallel to the $x z$-plane (#ref(<fig:StokesletHydrod>)c, left) and then study the orientation dynamics in a frame where the surface normal is parallel to the $z$-axis. Specifically, we consider Eq.~(@eq:Faxen) for the image flow $upright(bold(v))'$ of a Stokeslet with fixed total force $upright(bold(F)) = F_(upright("st")) ( sin theta_g , 0 , - cos theta_g )^top$ with $F_(upright("st")) > 0$ (#ref(<fig:StokesletHydrod>)c) -- such an image flow is given by Eq.~(@eq:singall) with $upright(bold(p)) = - ( sin theta_g , 0 , cos theta_g )^top$ and $a$ as in Eq.~(@eq:Stoka) -- which yields 


$ frac(d p_x, d t) & = frac(F_(upright("st")), 32 pi eta h^2) (- p_z sin theta_g + 3 chi p_z^2 p_x cos theta_g)\
frac(d p_y, d t) & = - frac(F_(upright("st")), 32 pi eta h^2) 3 chi p_z^2 p_y cos theta_g\
frac(d p_z, d t) & = frac(F_(upright("st")), 32 pi eta h^2) [- p_x sin theta_g + 3 chi (1 - p_z^2) p_z cos theta_g] . $<eq:DynPi>


Equations~(@eq:DynPi) are for $theta_g = 0$ equivalent to the Stokeslet contribution $tilde a$ in Eqs.~(@eq:Dynpcart)--(@eq:fp). The stationary orientation of interest ($upright(bold(p))$ mostly oriented along the $z$-axis) described by Eqs.~(@eq:DynPi) is given by $p_y^(*) = 0$ and 


$ p_x^(*) & = frac(tan theta_g, 3 chi p_z^(*))\
p_z^(*) & = sqrt(1 slash 2 + sqrt(1 slash 4 - (frac(tan theta_g, 3 chi))^2)) , $<eq:Pfull>


which shows that the body axis $upright(bold(p))$ is at steady state oriented in the plane formed by the surface normal and the direction of gravity. For this solution, two important scenarios can be discussed:


- #emph[Gravity aligned with the surface normal $( theta_g = 0 )$: Orientational stability of bound states] In this case, Eqs.~(@eq:Pfull) imply $upright(bold(p))^(*) = upright(bold(e))_z$ if $chi > 0$ and a linearization of Eqs.~(@eq:DynPi) shows this state is stable against orientational perturbations. Hence, below a free surface, an anisotropic body shape $chi > 0$ (#ref(<fig:SideViewFitResultsfortheo>)e) and the generation of a Stokeslet flow (#ref(<fig:StokesletHydrod>)a) are in principle sufficient ingredients to stabilize the upright body axis orientation of a microswimmer, consistent with the analysis in the previous sections and with experimental observations.

- #emph[Gravity tilted relative to the surface normal $( theta_g eq.not 0 )$: Hydrodynamic focusing in wells] Equation~(@eq:Pfull) implies in this case that a stationary solution only exist for anisotropic surface shapes with $ chi > 3 slash 2 | tan theta_g | . $<eq:Gammacrit> Furthermore, assuming Eq.~(@eq:Gammacrit) holds, we see from Eqs.~(@eq:Pfull) that the stationary orientation vector is itself tilted relative to the fluid surface normal ($p_x^(\*) eq.not 0$). A linearization of Eqs.~(@eq:DynPi) around the stationary state Eqs.~(@eq:Pfull) for arbitrary~$theta_g$ shows that such a tilted state is still linearly stable. This has important consequences for swimmers that are bound below a potentially curved fluid surface: Whenever embryos tilt relative to the surface above them, part of the thrust that is generated by ciliary beating is converted into translational motion parallel to the surface. The direction of this translation is set by the direction of the embryo tilt, which in turn is set by the orientation of gravity relative to the surface normal. From the sign of given in Eq.~(@eq:Pfull) it follows that the body axis tilt relative to the surface is always oriented such that, for a convexly curved fluid surface in a well, bound embryos tend to translate towards the center of the well~(#ref(<fig:StokesletHydrod>)c, right). Complementing the Stokeslet-mediated attraction, this hydrodynamic focusing additionally contributes to the accumulation of embryos and thereby supports the formation of even larger clusters.


== Minimal model of cluster formation and rotation
<sec:HydrModel>
In this section, we describe a minimal model of interacting chiral disks that faithfully recapitulates the phenomenology of cluster formation and quantitatively accounts for experimentally observed single embryo spinning and whole cluster rotation frequencies~(Fig.~2e--g, main text). Notably, over the course of each experiment, system properties spread over almost three orders of magnitude in frequencies and in the number of embryos contained in clusters. For simplicity, our model aims at a description of the effectively two-dimensional dynamics in the $x y$-plane of a fixed number of embryos that are bound below the surface. In this case, each embryo can be represented as a disk and lateral interactions can be described by effective force and torque balance equations.


=== Force and torque balance
<force-and-torque-balance>
Before formulating effective force and torque balance equations for a given embryo, we qualitatively describe the minimal set of interactions expected in our living chiral crystal system. Besides a steric repulsion between nearby embryos, the essential lateral interactions are given~by:

- #emph[Hydrodynamic attraction] The dominant long-ranged radial in-flow $| upright(bold(v)) | tilde 1 slash r$ from the Stokeslet generated by each embryo (main text Fig.~2a,b, see Sec.~@sec:Stokeslet), entrains surrounding embryos and thereby leads to an effective attraction between them. An analogous effect near rigid no-slip interfaces has been studied in various theoretical and experimental settings~#link(<si-2>)[[2, 3, 4, 9]]. Lateral hydrodynamic interactions from higher order flow singularities are subdominant as they decay at least with $1 slash r^2$ in distance and are therefore neglected in the minimal model that is presented below.

- #emph[Transverse hydrodynamic force and torque exchange] Two nearby rotating embryo surfaces will experience an additional exchange of forces and torques due to hydrodynamic near-field interactions~#link(<si-7>)[[7, 4, 9]]~(see Fig.~2d, main text). In particular, transverse forces within the $x y$-plane due to the neighboring embryo's spinning effectively make a pair of embryos “roll\" on each other. Together with the Stokeslet attraction, this leads to an orbiting motion of groups of embryos. Similarly, each embryo is subject to torques due to the spinning of nearby embryos, which leads to a slow-down of individual embryo spinning frequencies~(Fig.~2f, main text). The forces and torques contributing to these interactions are expected to affect the fluid flow around rotating groups of embryos in a particular fashion, a prediction that was independently verified by fitting suitable sets of singularities to measured flow fields~(Sec.~@sec:PIVfit, main text Fig.~2c, @fig:PIVfitting and~@fig:PIVfittingtrip)


Representing an embryo~$i$ by a disk with centroid position $upright(bold(r))_i = ( x_i , y_i , - h )$, where $h$ is the distance between centroid and fluid surface, the above interactions translate into an effective force balance of the form


$ frac(d upright(bold(r))_i, d t) = sum_(j eq.not i) [macron(upright(bold(v)))_(upright("st")) ( upright(bold(r))_i   upright(bold(e))_z , upright(bold(r))_j ) + frac(1, eta R) upright(bold(F))_(upright("rep")) ( | upright(bold(r))_i - upright(bold(r))_j | ) + R ( omega_i + omega_j ) F_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | ) thin hat(upright(bold(r)))_(i j)^perp] , $<eq:FB>


which describes an overdamped dynamics of the in-plane centroid coordinates, $d x_i slash d t$ and~$d y_i slash d t$. The vector $hat(upright(bold(r)))_(i j)^perp = [ ( hat(upright(bold(r)))_(i j) )_y , - ( hat(upright(bold(r)))_(i j) )_x ]^top$ is orthogonal to the unit vector $hat(upright(bold(r)))_(i j) = ( upright(bold(r))_i - upright(bold(r))_j ) slash | upright(bold(r))_i - upright(bold(r))_j |$ that points from the center of disk $j$ to the center of disk~$i$. The first term in Eq.~(@eq:FB) captures the Stokeslet-mediated attraction through the flow $macron(upright(bold(v)))_(upright("st"))$ (Eqs.~(@eq:singall)~and~(@eq:Stokeslet) with $a = - F_(upright("st")) slash ( 8 pi R eta )$) generated by embryos at positions~$upright(bold(r))_j$. The second term in Eq.~(@eq:FB) implements a steric repulsion between embryos of the form $upright(bold(F))_(upright("rep")) ( r ) = - d V ( r ) slash d upright(bold(r))$, where $r = | upright(bold(r)) |$ and


$ V ( r ) = f_(upright("rep")) R^13 slash r^12 . $<eq:RepPot>


Here, $R$ is the average apparent radius of bound embryos when viewed along the $z$-axis from above the fluid surface and the effective repulsion force~$f_(upright("rep"))$ was inferred from experiments (Sec.~@sec:ModPara). The last term in Eq.~(@eq:FB) introduces the transverse hydrodynamic near-field forces. This transverse force is proportional to the relative velocity $R ( omega_i + omega_j )$ of two nearby embryo surfaces, where $omega_i$ denotes the angular spinning frequency of embryo~$i$. $omega_i > 0$ ($omega_i < 0$) corresponds to clockwise (counter-clockwise) single embryo spinning when viewed from above the fluid surface. The amplitude of the transverse force depends on the distance $d_(i j) = | upright(bold(r))_i - upright(bold(r))_j | - 2 R$ between embryo surfaces and takes the form


$ F_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | ) = {f_0 ln d_c slash d_(i j) ( d_(i j) < d_c )\
0 ( d_(i j) gt.eq d_c ) , $<eq:Finter>


where the logarithmic distance dependence is a known result from lubrication theory~#link(<si-7>)[[7, 4]]. While the prefactor in Eq.~(@eq:Finter) for purely hydrodynamic interactions in the lubrication limit is also known~#link(<si-7>)[[7]], we introduce here a phenomenological dimensionless parameter $f_0$ that is instead determined from experiments to account for potential effects of flagella-flagella interactions or of the nonspherical embryo shape. The parameter $f_0$ then characterizes the effective overall strength of the transverse force exchange~(see also Sec.~@sec:ModPara).


Anticipating the formation of clusters in experiments, where hydrodynamic attraction gets screened by the presence of neighboring embryos, we distinguish two populations of disks depending on the size of clusters they are part of at a given moment in time: A disk $i$ that is isolated or part of a small cluster of at most 3 disks interacts with all other disks $j$ via the Stokeslet flow $macron(upright(bold(v)))_(upright("st"))$ in Eq.~(@eq:FB). A disk $i$ that is part of a cluster with more than 3 disks only experiences a Stokeslet-mediated attraction with disks $j$ with $| upright(bold(r))_i - upright(bold(r))_j | lt.eq 3.8 R$, such that hydrodynamic attraction in larger clusters is restricted to nearest and second nearest neighbor interactions -- corresponding to the set of neighboring disks with which a direct lateral line-of-sight exists.


To mimic the effect of hydrodynamic focusing of embryos towards the well center (see Sec.~@sec:Stokeslet and #ref(<fig:StokesletHydrod>)c) and facilitate the formation of a single large cluster in simulations within finite time, the contribution $upright(bold(v))_w = - frac(| upright(bold(r))_i |, tau_w) hat(upright(bold(r)))_i$ with $hat(upright(bold(r)))_i = upright(bold(r))_i slash | upright(bold(r))_i |$ and $tau_w = 15 thin$min was added to Eq.~(@eq:FB), effectively placing the center of the well at the in-plane coordinate origin $x = 0$ and $y = 0$. \


This model is closed by a torque balance that describes the evolution of each embryo's spinning frequency. We consider a fully overdamped scenario, in which the torque balance requires for each embryo that the sum of torques from rotational drag, from the flagellar beating and from lubrication interactions with nearby embryos vanish. For embryos interacting isotropically in the $x y$-plane, this leads to an algebraic condition that determines instantaneous spinning frequencies of each embryo as


$ omega_i = omega_0 - sum_(j eq.not i) ( omega_i + omega_j ) T_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | ) . $<eq:TB>


Single bound embryos are spinning with angular frequency $omega_0$ and nearby embryos slow down each other's spinning. The distance-dependence of the latter interaction again borrows from known results in lubrication theory~#link(<si-7>)[[7, 4]], which suggests the form


$ T_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | ) = {tau_0 ln d_c slash d_(i j) ( d_(i j) < d_c )\
0 ( d_(i j) gt.eq d_c ) , $<eq:Tinter>


for the near-field contribution in Eq.~(@eq:TB). Similar to Eq.~(@eq:Finter), Eq.~(@eq:Tinter) uses a phenomenological dimensionless parameter $tau_0$ that is directly determined by experiments and characterizes the strength of the torques that slow down the spinning of nearby embryo.


// [figvision-cn] imgs/FigS4.png
// 本图由三个子图（a、b、c）组成，c 包含左右两个面板。整
// 体展示胚胎在液面下绑定后的表观半径、旋转频率随时间的变
// 化，以及成对和三联胚胎的旋转频率关系。 子图 a：散点图。
// 横轴为时间（Time），单位小时（hours），范围 0 到 45，
// 刻度为 0、10、20、30、40。纵轴为胚胎表观半径（Apparent
// embryo radius），单位毫米（mm），范围 0.08 到 0.13，刻
// 度间隔 0.01。图中每个灰色圆点代表一个不同胚胎的测量值；
// 蓝色圆点和误差棒分别表示平均值和标准差。数据点分布在约
// 0、12、21、26、38、42 小时六个时间点。0 小时处平均表观
// 半径约 0.115 mm，12 小时降至约 0.104 mm，21 小时回升至
// 约 0.109 mm，26 小时约 0.110 mm，38 小时约 0.114 mm，
// 42 小时降至约 0.100 mm。图中左下角有一个灰色圆形示意图，
// 标注双向箭头，表示表观半径的测量方向。趋势显示表观半径
// 随时间先下降后回升再下降的波动变化。 子图 b：散点图。
// 横轴为时间（Time），单位小时（hours），范围 0 到 45，
// 刻度为 0、10、20、30、40。纵轴为胚胎旋转频率（Embryo
// spinning frequency），单位 1/s，范围 0 到 1.5，刻度为
// 0、0.5、1、1.5。同样，灰色圆点代表单个胚胎，蓝色圆点和
// 误差棒代表平均值和标准差。数据点分布在约 0、12、21、26、
// 38、42 小时六个时间点。0 小时处平均旋转频率约 0.65 1/s，
// 12 小时约 0.68 1/s，21 小时约 0.80 1/s，26 小时约 0.63
// 1/s，38 小时约 0.68 1/s，42 小时约 0.85 1/s。图中左上
// 角有一个灰色圆形示意图，黄色箭头表示旋转方向。趋势显示
// 旋转频率随时间波动，整体略有上升。 子图 c：包含左右两
// 个面板，均为散点图。左面板为成对胚胎（bound pairs），
// 右面板为三联胚胎（triplets）。两个面板的横轴均为胚胎旋
// 转频率（Embryo spinning frequency），单位 1/s，范围 0
// 到 0.8，刻度为 0、0.2、0.4、0.6、0.8。纵轴分别为成对旋
// 转频率（Pair rotation frequency）和三联旋转频率（
// Triplet rotation frequency），单位 1/min，范围 0 到 8，
// 刻度为 0、2、4、6、8。图中彩色圆点表示不同时间点的测量
// 值，颜色映射由右侧色标给出，色标标注为时间（Time），单
// 位小时（hours），范围 0 到 40，颜色从深蓝（0）经青、绿、
// 黄过渡到亮黄（40）。两个面板中均有一条黑色虚线，从左下
// 角原点向右上角延伸，表示某种参考关系。左面板左上角有一
// 个示意图，显示两个灰色圆形通过红色弧线连接，红色箭头表
// 示旋转方向；右下角也有一个类似示意图，但圆形为黄色。右
// 面板左上角有一个示意图，显示三个灰色圆形通过红色弧线连
// 接，红色箭头表示旋转方向；右下角也有一个类似示意图，但
// 其中一个圆形为黄色。左面板数据点分布在横轴 0.3 到 0.7、
// 纵轴 2 到 6.5 之间，右面板数据点分布在横轴 0.3 到 0.7、
// 纵轴 2 到 7.5 之间。趋势显示成对和三联胚胎的旋转频率随
// 单个胚胎旋转频率增加而增加，且数据点颜色随时间变化，表
// 明旋转频率与时间相关。
#figure(image("imgs/FigS4.png", width: 94.0%),
  caption: [
    #strong[Measurements of embryo properties.]~#strong[a,]~Apparent radii~$R$ of embryos bound below the fluid surface. #strong[b,]~Spinning frequencies $omega_0 slash ( 2 pi )$ of isolated bound embryos. In #strong[a] and #strong[b], each gray dot depicts value for a different embryo (same set of embryos as in #ref(<fig:StokesletHydrod>)a), blue dots and error bars represent mean and standard deviation, respectively. #strong[c,]~Rotation frequencies of bound pairs (left) and triplets (right) increase linearly with the spinning frequency of embryos within these groups, as previously observed for pairs of $V o l v o x$ colonies~#link(<si-4>)[[4]]. Qualitatively, a given embryo spinning frequency translates over time into gradually smaller group rotation frequencies, suggesting a weakening of effective hydrodynamic interactions as development progresses. The variability of single embryo spinning frequencies (#strong[b]) is consistent with the variability of spinning frequencies within pairs and triplets and consequently leads to variability in rotation frequencies of pairs and triplets. Black dashed lines depict calibration of average embryo properties in the minimal model (see Sec.~@sec:HydrModel).
  ]
)
<fig:EmbryoProps>



=== Determining model parameters from experimental data
<sec:ModPara>
The parameters contained in this model can be systematically determined from experimental measurements and suitable fits to the dynamics of single embryos, rotating pairs and rotating triplets. Similar to the Stokeslet strength $F_(upright("st"))$~(#ref(<fig:StokesletHydrod>)a), apparent average radii $R$ and spinning frequencies $omega_0 slash ( 2 pi )$ of isolated bound embryos are determined from direct single embryo measurements~(#ref(<fig:EmbryoProps>)a,b). While we noted a slight decrease of in-plane flow speeds around single embryos towards the very end of the experimental time window, none of these parameters showed substantial changes over about~40 hours of experiments. For given size $R$ and attraction characterized by~$F_(upright("st"))$, the repulsive force strength $f_(upright("rep"))$ in Eq.~(@eq:RepPot) sets the surface distance $d_(i j)$ between equilibrated pairs of disks in the minimal model. This distance was measured in experiments ($approx 20 thin mu$m) and $f_(upright("rep"))$ was set accordingly (see also Eq.~(@eq:r0eq)). Finally, rotation frequencies of pairs and triplets~(#ref(<fig:EmbryoProps>)c) in experiments can be used to set the transverse force strength~$f_0$, while reduced embryo spinning frequencies within pairs and triplets~(Fig.~2f, main text) determine the lateral torque strength~$tau_0$. The final parameter values used in simulations of the emergent cluster formation are listed in~Tab.~1. \


#figure(
  align(center)[#table(
    columns: 8,
    align: (center,center,center,center,center,center,center,center,),
    table.header([Parameter], [$R$~($mu$m)], [$frac(omega_0, 2 pi)$~(Hz)], [$F_(upright("st")) slash eta$~(mm$""^2$/s)], [$f_(upright("rep")) slash eta$~(mm$""^2$/s)], [$f_0$], [$tau_0$], [$d_c slash R$],),
    table.hline(),
    [Value], [$110$], [$0.72 plus.minus 0.17$], [$2.6 plus.minus 0.3$], [$38 plus.minus 6$], [$0.06$], [$0.12$], [$0.5$],
  )],
  caption: [Table 1: Parameters used in the minimal hydrodynamic model of cluster formation. Mean values of apparent radii $R$, free spinning frequencies $omega_0 slash 2 pi$ and Stokselet strength $F_(upright("st")) slash eta$ were set to averages of corresponding experimental measurements (#ref(<fig:StokesletHydrod>)a and #ref(<fig:EmbryoProps>)a,b). The variability of apparent radii is represented by a commensurate variability in the repulsive force amplitude $f_(upright("rep"))$. In simulations the parameters $omega_0$, $F_(upright("st"))$ and $f_(upright("rep"))$ have been drawn from random distributions as described in the text below to reflect the natural variability of embryo properties. ],
  kind: table,
  numbering: none,
)
<Tab:ModelParams>


#emph[Introducing variability of single embryo parameters in the minimal model:] Experimental measurements of bound single embryo properties (#ref(<fig:StokesletHydrod>)a and #ref(<fig:EmbryoProps>)a,b) provide insights into the biological variability of microscopic parameters. Qualitatively, this parameter variability can be interpreted as a form of noise that is present in the system. Indeed, parameter variability in the minimal model increases the likelihood of more comprehensive neighbor rearrangements when clusters merge. In the absence of microscopic variability on the other hand, even small clusters formed in the minimal model are rather static in their shape and nearest-neighbor topology, which is in contrast to experimental observations. To include parameter variability into the model, we proceeded as follows. Stokeslet strength $F_(upright("st"))$ (#ref(<fig:StokesletHydrod>)a) and isolated bound embryo spinning frequencies $omega_0 slash ( 2 pi )$ (#ref(<fig:EmbryoProps>)b) were sampled for each disk from a normal distribution with mean and standard deviation as determined from experiments (Tab.~1). To mimic a finite apparent size variability in a minimal fashion, we additionally sampled the repulsive force strength $f_(upright("rep"))$ homogeneously from the interval given in Tab.~1. Finally, to restore reciprocity of attraction and repulsion between disks $i$~and~$j$ for sampled parameters $beta_i$ and $beta_j$ (representing corresponding values of $F_(upright("st"))$ or $f_(upright("rep"))$), we symmetrized the linear coefficients of each pair-wise interaction in Eq.~(@eq:FB) as $F_(upright("st")) , f_(upright("rep")) arrow.r ( beta_i + beta_j ) slash 2$. \


#emph[Phenomenological scaling of embryo spinning frequencies in large clusters:] The emergent dynamics that our minimal model gives rise to can be tested by comparing spinning frequencies of embryos within clusters and whole-cluster rotation frequencies with experiments. The minimal model reveals that, as more disks join a cluster, the average nearest-neighbor distance is reduced, which leads to a slow-down of embryo spinning frequencies ($omega_i$ in our model) within clusters due to torque exchanges (see experimental data in main text Fig.~2f). This causes a reduction in lateral force exchanges and, together with the increased drag experienced by larger clusters, slows down whole-cluster rotations (see experimental data in main text Fig.~2g). The interactions described in Eqs.~(@eq:FB) and (@eq:TB) with parameters from Tab.~1 quantitatively match the corresponding experimental observations up to cluster sizes of about 40 to 50 embryos. For larger clusters, we observed experimentally a more drastic reduction in the whole-cluster rotation speeds than captured by the local interactions described so far (main text Fig.~2g). The simplest way to take this into account without making assumptions about more complex spatial modulations of embryo interactions is to assume that the embryo's ability to generate a torque surface density is increasingly impeded in larger clusters. Formally, this amounts to a cluster-size-dependent reduction of $omega_0$, where we heuristically found that a scaling $omega_0 arrow.r omega_0 slash [ 1 + ( N_(c l) slash N_0 )^2 ]$ in Eq.~(@eq:TB) ($N_0 = 80$ and $N_(c l) gt.eq 2$ is the total number of disks in a given cluster) leads to whole-cluster rotation rates that fit the experimental data (main text Fig.~2g). A nontrivial prediction of the $omega_0$-modulation are the emerging embryo spinning frequencies $omega_i$ in larger clusters, which agree well with the experimental data (main text Fig. 2f).


=== Details of numerical simulations
<details-of-numerical-simulations>
The effective force and torque balance Eqs.~(@eq:FB) and (@eq:TB) with parameters shown in Tab.~1 were implemented in MATLAB and solved using the ordinary differential equation solver `ode113`. Note that in practice Eq.~(@eq:TB) represents a separate linear system of equations for each connected component of the graph that is generated by connecting all disks within a distance of~$| upright(bold(r))_i - upright(bold(r))_j | < d_c + 2 R$. Because the weights of this linear system given by Eq.~(@eq:Tinter) depend only on positions~$upright(bold(r))_i$, it can be explicitly solved for the angular spinning frequencies $omega_i$ at arbitrary intermediate time steps. The resulting values are directly used to evaluate the transverse interaction $tilde hat(upright(bold(r)))_(i j)^top$ in Eq.~(@eq:FB).


To simulate the cluster formation shown in Fig.~2e (main text), we initiated 700 disks with individual parameters given in Tab.~1 and positioned them homogeneously on a circular domain with an approximate radius of 8 cm.


To determine the data shown in Fig.~2f (main text) (“In small clusters\"), we ran 30 simulations of pairs, triplets and groups of four disks corresponding to one, two, and three direct neighbors, respectively. 10 simulations of clusters with 100 disks were run to determine spinning frequencies “In large clusters\" Fig.~2f (main text). Mean and standard deviations of the spinning frequencies extracted from these simulations are depicted by the symbols and error bars in~Fig.~2f.


To determine the size-dependent whole-cluster rotation rates shown in Fig.~2g (main text), we ran 5 simulations for each total numbers of disks $N_(c l) in ( 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 12 , 17 , 25 , 37 , 54 , 78 , 114 , 165 , 220 , 320 )$ and extracted rotation frequencies of the final clusters that had formed. The standard variation of these whole-cluster rotation frequencies in the minimal model is smaller than the symbol size used in Fig.~2g (main text).


=== Discussion
<discussion>
In the following, we discuss the key assumptions and simplifications made in the minimal model introduced above in more detail.


To simplify the fluid dynamics, we have assumed hydrodynamic interactions are dominated by the Stokeslet properties of single bound embryos. The corresponding singularity description was used to describe a fixed attraction strength among embryos and therefore neglects potential changes of the ciliary activity and more complex aspects of hydrodynamic interactions when embryos come closer together. Similarly, we have considered an isotropic potential-like steric repulsion in the $x y$-plane that implies a circular apparent shape of bound embryos. Taking more details of embryo morphology~(main text Fig.~1b and @fig:Morphology) and associated hydrodynamic effects in tightly packed clusters faithfully into account will most likely require fully resolved, three-dimensional hydrodynamic simulations~#link(<si-10>)[[10, 11]], as well additional knowledge about the ciliary activity of embryos within clusters as compared to freely spinning~ones.


We did not explicitly include contributions of cilia-cilia interactions between embryos that may become relevant when embryos within clusters get very close to each other. In particular, the latter effect could lead to additional terms that complement the hydrodynamically motivated transverse near-field force and torques given in Eqs.~(@eq:Finter) and (@eq:Tinter). Using the phenomenological coefficients $f_0$ and $tau_0$ and determining them from experimental measurements (Sec.~@sec:ModPara) partially accounts for this uncertainty. More generally, we restricted the force and torque balance equations to local interactions but note that hydrodynamic effects may lead, even among embryos within clusters, to longer-ranged interactions.


The above mentioned factors -- cilia-cilia interactions and spatial three-dimensional details of the inter-embryonic fluid streaming -- but also potential feedback of the latter on ciliary activity might play a particularly important role in large clusters. While difficult to detect experimentally, such feedbacks could underlie the phenomenological $omega_0$-scaling (see Sec.~@sec:ModPara) that is in the present model required to quantitatively explain embryo and whole-cluster rotation rates for large clusters.


For simplicity, we have considered a scenario with a constant number of interacting disks. In experiments, embryos at the clusters boundaries can depart from clusters and incoming embryos may fill up holes that arise, for example, when clusters merge. This additional level of effective noise in experiments smoothens “sharp\" edges of clusters, eliminates some of the vacancies or fills up larger holes that have formed, but is otherwise not expected to change the essential characteristics of cluster formation.


== Effective material properties of living chiral crystals
<sec:MappingDetails>
Based on the minimal model described in Sec.~@sec:HydrModel, we derive in this section effective macroscopic material properties that arise for a collection of disks interacting within a hexagonal lattice. More complex details of interactions with the surrounding fluid, which may lead to effectively viscoelastic material properties of living chiral crystals, were for simplicity not included in the microscopic minimal model. Consequently, we focus here on the purely elastic response of such a system. To provide the required background, we first introduce the continuum description of isotropic elastic materials, closely following recent work on odd elasticity theory~#link(<si-12>)[[12, 13]] (Sec.~@sec:OddModuli) and proceed with the linearization (Sec.~@Sec:ModelMapping) and coarse-graining (Sec.~@Sec:CGmodel) of the interactions given in minimal model Eqs.~(@eq:FB) and (@eq:TB).


=== Linear elasticity and strain cycles in isotropic solids
<sec:OddModuli>
The pair-wise interactions on the right-hand side of Eq.~(@eq:FB) describe a response to small displacements $upright(bold(u)) ( x , y , t ) = ( u_x , u_y )^top$ from an equilibrium distance that is elastic and purely distance-dependent (translationally invariant). Hence, to linear order, a mean-field theory of effective stresses $sigma_(i j)$ associated with crystal deformations will be of the form


$ sigma_(i j) = sigma_(i j)^0 + C_(i j k l) partial_k u_l , $<eq:StrStrind>


where $sigma_(i j)^0$ is a pre-stress, $C_(i j k l)$ denotes the elastic moduli tensor, $partial_k u_l$ is the displacement gradient tensor (Einstein summation convention $i , j , k , l = x , y$). Using the matrix basis~#link(<si-12>)[[12]]


$ s^0 = mat(delim: "(", 1, 0; 0, 1; #none) s^1 = mat(delim: "(", 0, - 1; 1, 0; #none) s^2 = mat(delim: "(", 1, 0; 0, - 1; #none) s^3 = mat(delim: "(", 0, 1; 1, 0; #none) , $


with $s_(i j)^alpha s_(i j)^beta = 2 delta^(alpha beta)$ ($alpha , beta = 0 , 1 , 2 , 3$), Eq.~(@eq:StrStrind) can be conveniently expressed as


$ sigma^alpha = sigma_0^alpha + C^(alpha beta) u^beta , $<eq:StrStrproj>


which highlights the moduli $C^(alpha beta) = 1 slash 2 C_(i j k l) s_(i j)^alpha s_(k l)^beta$ that couple strain components $u^alpha = s_(i j)^alpha partial_i u_j$ ($u^0$: Compression/Expansion; $u^1$: Rotation; $u^2$, $u^3$: Shear components 1 and 2) to different stress components $sigma^alpha = s_(i j)^alpha sigma_(i j)$ ($sigma^0$: Compressive/Expansive stress; $sigma^1$: Torque, $sigma^2$, $sigma^3$: Shear stress components). Based on the nature of the interactions and the hexagonal lattice geometry in our system, we anticipate isotropic material properties to emerge at larger scales. Isotropy restricts potential pre-stresses to take the form of a pressure $sigma_(i j)^0 tilde delta_(i j)$ and/or a torque density $sigma_(i j)^0 tilde epsilon.alt_(i j)$, and the most general isotropic moduli tensor is given by~#link(<si-12>)[[12, 13]]


$ C^(alpha beta) = mat(delim: "(", B, Lambda, 0, 0; A, Gamma, 0, 0; 0, 0, mu, K^o; 0, 0, - K^o, mu; #none) . $<eq:Cab>


Besides the bulk and shear moduli $B$ and $mu$ commonly found in equilibrium solids, the moduli tensor Eq.~(@eq:Cab) contains additionally odd bulk and shear moduli $A$ and $K^o$ that can exist in isotropic nonequilibrium materials~#link(<si-12>)[[12]]. While $B , mu > 0$ is required for mechanical stability, there are in principle no restrictions on the signs of $A$ and $K^o$. The moduli $Gamma$ and $Lambda$ respectively represent equilibrium and nonequilibrium moduli that couple rotations to isotropic stresses and torques, and therefore require interactions with a surrounding medium~#link(<si-13>)[[13]]. In general, all these moduli are compatible with the properties of living chiral crystals, which are inherently out-of-equilibrium, exhibit nonreciprocal transverse interactions and are embedded in and interacting with a surrounding medium.


Anticipating the experimental observation of closed cycles in the strain component spaces ($u^1 , u^0$) and ($u^2 , u^3$) (see Sec.~@sec:StrCycAnal, @fig:Entropy and main text Fig.~4f,g), it is interesting to note that the #strong[work that can be extracted from] a material with stress-strain relation Eqs.~(@eq:StrStrproj) and (@eq:Cab) during a strain cycle, $W = - integral.cont sigma_(i j) d u_(i j)$, can be expressed as~#link(<si-12>)[[12, 14]]


$ W & = (A - Lambda) times (upright("Area enclosed by counter-clockwise cycle in (u^1,u^0)-space"))\
 & + 2 K^o times (upright("Area enclosed by counter-clockwise cycle in (u^2,u^3)-space")) . $<eq:work>


=== Linearization of pair-interactions in the minimal model
<Sec:ModelMapping>
We now show that pair-interactions in the two-dimensional disk dynamics described by Eqs.~(@eq:FB) and (@eq:TB) can be mapped to odd elastic spring-like interactions~#link(<si-12>)[[12]] when considering small displacements from an equilibrium distance. For convenience, we normalize forces and two-dimensional stresses (tension) throughout by $eta R$, such that forces have units (Length/Time) and tensions have units~(1/Time).


We consider a pair of disks $i = 1 , 2$ with centroid distance $r_12 = | upright(bold(r))_1 - upright(bold(r))_2 |$ interacting according to Eqs.~(@eq:FB) and (@eq:TB) and focus for simplicity on the scenario of equal disk radii $R$ and free spinning frequency $omega_0$. Interactions in Eq.~(@eq:FB) coming from Stokeslet attraction $macron(upright(bold(v)))_(upright("st"))$ and repulsion $upright(bold(F))_(upright("rep"))$ are both central forces acting along the vector $hat(upright(bold(r)))_12 = ( upright(bold(r))_1 - upright(bold(r))_2 ) slash r_12$. To linear order around some fixed relative distance $tilde(x) = x slash R$, the effective force associated with these interactions reads


$ F^parallel ( r_12 ) = frac(1, eta R) [12 f_(upright("rep")) slash tilde(x)^13 - frac(F_(upright("st")) tilde(x), 4 pi ( tilde(x)^2 + 4 )^(3 slash 2))] - frac(1, eta R^2) [frac(156 f_(upright("rep")), tilde(x)^14) - frac(F_(upright("st")) ( tilde(x)^2 - 2 ), 2 pi ( tilde(x)^2 + 4 )^(5 slash 2))] ( r_12 - x ) + cal(O) ( delta tilde(r)^2 ) , $<eq:linattrrep>


where $delta tilde(r) = ( r_12 - x ) slash R$. The first term in square brackets vanishes at the equilibrium distance


$ r_0 := x^(*) approx 2.2 R , $<eq:r0eq>


where we used the values for $F_(upright("st"))$ and $f_(upright("rep"))$ from Table.~1. We recall that the Stokeslet strength~$F_(upright("st"))$ (relative to the viscosity) was determined from experimental measurements (Sec.~@sec:PIVfit) and $f_(upright("rep"))$ was chosen such the equilibrium distance between a pair of disks was equal to the experimentally measured mean distance of an orbiting pair of embryos (Sec.~@sec:ModPara). The latter is therefore self-consistently recovered in Eq.~(@eq:r0eq). At this rest-length $r_0$, the linear coefficient in Eq.~(@eq:linattrrep) defines an effective spring constant


$ k := frac(1, eta R^2) [frac(156 f_(upright("rep")), tilde(x)^14) - frac(F_(upright("st")) ( tilde(x)^2 - 2 ), 2 pi ( tilde(x)^2 + 4 )^(5 slash 2))] approx 8.1 thin upright("s")^(- 1) . $<eq:SprConst>


To approximate the transverse interaction $tilde hat(upright(bold(r)))_(i j)^perp$ in Eq.~(@eq:FB), we have to determine the prefactor $omega_1 + omega_2$ from the torque balance Eq.~(@eq:TB). By symmetry, the angular rotation frequencies of a pair of interacting disks must be equal,~$omega_1 = omega_2 = omega$. Equation~(@eq:TB) then implies


$ omega = frac(omega_0, 1 + 2 tau_0 ln d_c slash d_12) , $


where $d_12 = r_12 - 2 R$ is the shortest distance between the two disk boundaries. The amplitude of transverse interaction in Eq.~(@eq:FB) for a pair of interacting disks therefore becomes


$ 2 omega R F_(upright("nf")) ( r_12 ) = 2 R omega_0 f_0 frac(ln d_12 slash d_c, 2 tau_0 ln d_12 slash d_c - 1) = F_0^perp - k_a (r_12 - r_0) + cal(O) ( delta r^2 ) , $


where the zeroth order transverse interaction $F_0^perp$ and an effective elastic constant $k_a$ are given~by 


$ F_0^perp & := 2 R omega_0 f_0 ln d_0 slash d_c (2 tau_0 ln d_0 slash d_c - 1)^(- 1) approx 0.04 thin upright("mm/s")\
k_a & := frac(2 R omega_0 f_0, d_0) (2 tau_0 ln d_0 slash d_c - 1)^(- 2) approx 2.0 thin upright("s")^(- 1) . $<eq:oddcoeffmap>


In these expressions, $d_0 = r_0 - 2 R = 0.2 R$ (see Eq.~(@eq:r0eq)) denotes the disk surface distance at equilibrium, $d_c = 0.5 R$ the cut-off length of lubrication-induced transverse interactions and we used parameters from the experimentally calibrated disk model to determine concrete values for $F_0^perp$ and $k_a$ (see Tab.~1). All together, pairwise interactions in Eq.~(@eq:FB) imply in this limit the centroid dynamics


$ frac(d upright(bold(r))_1, d t) = - frac(d upright(bold(r))_2, d t) = - k (r_12 - r_0) hat(upright(bold(r)))_12 + [F_0^perp - k_a (r_12 - r_0)] hat(upright(bold(r)))_12^perp , $<eq:odddynmap>


where $hat(upright(bold(r)))_12^perp = [ ( hat(upright(bold(r)))_12 )_y , - ( hat(upright(bold(r)))_12 )_x ]^top$ and the effective parameters $k$, $k_a$ and $F_0^perp$ are given in Eqs.~(@eq:SprConst) and (@eq:oddcoeffmap).


=== Coarse-grained odd material parameters of living chiral crystals
<Sec:CGmodel>
The linearized pair-wise dynamics Eq.~(@eq:odddynmap) corresponds to a spring-like interaction with linear spring constant $k$ and odd spring constant $k_a$ as introduced in~#link(<si-12>)[[12]] and analyzed further in~#link(<si-13>)[[13]]. While the exact values of $r_0$, $k$ and $k_a$ differ from the values given in Eqs.~(@eq:SprConst) and (@eq:oddcoeffmap) when more than two disks interact within a hexagonal lattice, linear and transverse interactions will be qualitatively similar to Eq.~(@eq:odddynmap). Hence, we can refer to the coarse-graining results derived in ref.~#link(<si-13>)[[13]] for hexagonal lattices of particles interacting with nearest neighbors. The parameters given in Eqs.~(@eq:oddcoeffmap) then provide estimates for effective material moduli that emerge from transverse lubrication interactions and are given by~#link(<si-13>)[[13]]


$ A = sqrt(3) slash 2 (k_a + F_0^perp slash r_0) approx 1.9 thin upright("s")^(- 1) K^o = sqrt(3) slash 4 (k_a - F_0^perp slash r_0) approx 0.8 thin upright("s")^(- 1) . $<eq:OddModuliCG>


These moduli are comparable to the standard bulk and shear moduli


$ B = sqrt(3) slash 2 k approx 7.0 thin upright("s")^(- 1) mu = sqrt(3) slash 4 k approx 3.5 thin upright("s")^(- 1) $<eq:PassModuliCG>


of a coarse-grained hexagonal lattice connected by linear springs with spring constant given in Eq.~(@eq:SprConst). Additionally, for a hexagonal lattice with nearest neighbor interactions the contribution $F_0^perp$ in Eq.~(@eq:odddynmap) yields in the long-wavelength limit an anti-symmetric pre-stress $sigma_(i j)^0 = sigma_0 epsilon.alt_(i j)$ with~#link(<si-13>)[[13]]


$ sigma_0 = frac(sqrt(3) F_0^perp, r_0) approx 0.3 thin upright("s")^(- 1) . $<eq:td>


To express the parameter values in Eqs.~(@eq:OddModuliCG)--(@eq:td) in units of tension, they have to be multiplied by the effective friction parameter $R eta$.


Based on our minimal model, distance-dependent transverse lubrication interactions are therefore expected to give rise to effective odd material properties with $A , K^o > 0$ and broken Maxwell-Betti reciprocity~#link(<si-13>)[[13]]. From this derivation, we see explicitly that signs of the odd moduli are determined by the sign of $omega_0$ and thus by the intrinsic handedness of active embryo rotations. In agreement with this coarse-graining result, $A > 0$ and $K^o > 0$ is also found from the experimental analysis of strains surrounding topological lattice defects (Fig.~4a--c in the main text, Sec.~@sec:StrAnalysis). Finally, the sign of the anti-symmetric pre-stress $sigma_(i j)^0 = sigma_0 epsilon.alt_(i j)$ with $sigma_0 > 0$ indicates an intrinsic tendency of the material to spin clockwise, consistent with the clockwise rotations exhibited by living chiral crystals.


= Data Analysis
<data-analysis>
This final section details the different data analysis approaches used to quantitatively living chiral crystals.


== Starfish embryo centroid localization and rotation correction
<sec:EmbrProc>
To identify starfish embryos, we first performed a circular Hough transform using the MATLAB (2016b, MathWorks) function `imfindcircles` on inverted raw intensities of microscopy images. To calculate the rotation frequency of clusters, we first identified all embryos within a cluster. This was done by recursively finding all nearest neighbors within a 1.5 embryo diameter from a predetermined seed position (for large clusters) or by using intensity thresholding to identify clusters and identifying the embryo centroids that lie within a given cluster region (for small clusters). Particle tracking was performed using the Hungarian linker algorithm~#link(<si-15>)[[15]] (for large clusters) or Daniel Blair and Eric Dufresne's MATLAB adaptation of the IDL Particle Tracking software (for small clusters)~#link(<si-16>)[[16]]. The rotation angle between any two consecutive time points was calculated by finding a rigid body transformation that maximizes the overlap of the embryo centroid positions between two frames. We then applied the inverse transformation on subsequent time frames to obtain embryo centroid positions in the cluster's co-rotating frame for analysis, which we refer to as #emph[rotation-corrected] centroid data. Measured rotation frequencies of clusters as a function of the number of embryos are shown in Fig.~2g (main text).


== Analysis of top-view flow fields surrounding bound embryos, pairs and triplets
<sec:FFanalsis>
In the following, we describe a quantitative analysis of the stationary flow fields parallel to the surface ($x y$-plane) as they can be seen around isolated bound embryos, as well as around pairs and triplets rotating near the surface. To this end, we use experimental measurements of tracer particle velocities (see Sec.~@sec:PIVexp for experimental details) and hydrodynamic arguments to fit the resulting flow fields.


=== Flow field measurements
<sec:FFM>


#emph[Embryo centroid tracking:] Embryos bound near the surface were segmented using Fiji's #link(<si-17>)[[17]] built-in function “Threshold\". Subsequently, incomplete or touching edges of embryos were delineated with the “Pencil Tool\" and the operation “Fill Holes\" was applied. Positions of embryo centroids were then extracted from the resulting shapes using the “Analyze Particles\" feature. \


#emph[Tracer particle tracking:] For all measurements, tracer particles were segmented using Fiji's “Threshold\" ($i$)~with and ($i i$)~without applying a prior “FFT Bandpass Filter\" step (filtering structures over 100 pixel $approx 200 thin mu$m). Segmented particles from $( i )$ and $( i i )$ were then tracked using the~“TrackMate\" plugin (Simple LAP tracker)~#link(<si-18>)[[18]]. Combining the results from $( i )$ and $( i i )$ enabled segmentation and tracking of particles with high fidelity both near and far away from the embryo surface. \


#emph[Averaging tracer particle velocities:] Before averaging the velocities found from particle tracking, we removed measurements that indicated particle movements away from single embryos or cluster centers by more than~$45^compose$ to narrow the depth of field. Furthermore, to determine meaningful average flow fields surrounding embryo pairs and triplets, their rotation dynamics had to be taken into account. To this end, the location of a given velocity measurement was additionally registered with respect to the current orientation of the pair or triplet and duplicated with respect to the corresponding cluster symmetry~(See Code Availability). Thereby, the final average field corresponds to the instantaneous flow field in the lab frame registered with respect some fixed orientation of the given pair or triplet.


=== Flow field fitting
<sec:PIVfit>
To connect average flow fields to the ciliary activity of the embryos, we approximated the flow fields around isolated embryos, pairs and triplets using suitable sets of Stokes flow singularities~#link(<si-4>)[[4,19]]: \


#emph[Single embryos:] The flow surrounding an isolated embryo was approximated by a Stokeslet with force $upright(bold(F)) = - F_(upright("st")) upright(bold(e))_z$ at distance $h$ below a free surface, which we write for purpose of defining a general fit function in this data analysis section as


$ macron(upright(bold(v)))_(upright("st")) ( upright(bold(r))   upright(bold(F)) , upright(bold(r))_0 ) = upright(bold(v))_(upright("st")) ( upright(bold(r))   upright(bold(F)) , upright(bold(r))_0 ) + upright(bold(v))_(upright("st")) ( upright(bold(r))   upright(bold(F))' , upright(bold(r))'_0 ) , $<eq:stok_forfit>


where $upright(bold(F))' = ( F_x , F_y , - F_z )^top$, $upright(bold(r))'_0 = ( x_0 , y_0 , h )^top$ (fluid surface at $z = 0$) and


$ upright(bold(v))_(upright("st")) ( upright(bold(r))   upright(bold(F)) , upright(bold(r))_0 ) = frac(1, 8 pi eta) (frac(upright(bold(F)), | upright(bold(r)) - upright(bold(r))_0 |) + frac(upright(bold(F)) dot.op (upright(bold(r)) - upright(bold(r))_0) (upright(bold(r)) - upright(bold(r))_0), | upright(bold(r)) - upright(bold(r))_0 |^3)) . $<eq:stok_forfit2>


The Stokeslet position $upright(bold(r))_0 = ( x_0 , y_0 , - h )^top$ is centered at the $( x , y )$-coordinate of a given embryo centroid. The parameters $h$, $F_(upright("st"))$, as well as the $z$-coordinate~$z_v$ of the apparent $x y$-plane in which the flow field is observed are determined by the fitting procedure described below. \


#emph[Additional contributions for rotating pairs and triplets:] Rotations of two closely nearby embryos give rise to additional hydrodynamic interactions (Fig.~2d, main text) that can in turn affect the surrounding flow field~#link(<si-4>)[[4]]. Similar to the Stokeslet Eq.~(@eq:stok_forfit2), the generic flow around a torque $upright(bold(T)) = ( T_x , T_y , T_z )^top$ located at $upright(bold(r))_0 = ( x_0 , y_0 , - h )^top$ in an unbound fluid (“rotlet\") is given~by


$ upright(bold(v))_(upright("rot")) ( upright(bold(r))   upright(bold(T)) , upright(bold(r))_0 ) = frac(1, 8 pi eta) frac(upright(bold(T)) times (upright(bold(r)) - upright(bold(r))_0), | upright(bold(r)) - upright(bold(r))_0 |^3) . $<eq:rot_uf>


To meet the free-surface boundary conditions at $upright(bold(r)) = ( x , y , 0 )^top$ this flow has to be complemented by a rotlet image. The rotlet below a free surface is given by


$ macron(upright(bold(v)))_(upright("rot")) ( upright(bold(r)) , upright(bold(T)) , upright(bold(r))_0 ) = upright(bold(v))_(upright("rot")) ( upright(bold(r))   upright(bold(T)) , upright(bold(r))_0 ) + upright(bold(v))_(upright("rot")) ( upright(bold(r))   upright(bold(T))' , upright(bold(r))'_0 ) , $<eq:rot>


where $upright(bold(T))' = ( - T_x , - T_y , T_z )^top$ and $upright(bold(r))'_0 = ( x_0 , y_0 , h )$. To fit flow fields around pairs and triplets, we assume each embryo centroid is the source of an “upright\" Stokeslet flow with a common strength $F_(upright("st"))$. Furthermore, we assume that the exchange of near-field forces is homogeneous and pair-wise symmetric among embryos, such that it can be described by only one additional Stokeslet and rotlet strength, $hat(F)_(upright("nf"))$ and $hat(T)_(upright("nf"))$, respectively~(#ref(<fig:PIVfitting>)a). \


// [figvision-cn] imgs/FigS5.png
// 子图a为示意图，展示用于拟合旋转二聚体和三聚体周围流场
// 的近场Stokeslet力位置。左下角有直角坐标系，x轴向右，y
// 轴向上。图分左右两组：左侧为一对水平排列的灰色圆（二聚
// 体），中心处有红色弧形箭头表示旋转方向（逆时针），每个
// 圆上叠加一个棕色粗箭头表示近场力，左圆力向上，右圆力向
// 下，两圆之间有一条水平虚线穿过圆心，上方有一条垂直虚线
// 穿过两圆中点；右侧为三个灰色圆呈三角排列（三聚体），每
// 个圆中心有红色逆时针弧形箭头，棕色箭头分别指向左上、右
// 和左下，虚线十字交叉穿过三聚体中心。图下方有图例：棕色
// 直箭头标记为F_nf，红色弧形箭头标记为T_nf。该图说明近场
// 力与旋转力矩的配置。 子图b为两幅并排的二维彩色热图，显
// 示相对最小二乘拟合误差。左图对应二聚体（N_cl = 2），右
// 图对应三聚体（N_cl = 3）。两图坐标轴相同：横轴为h/R，
// 范围0到4，主刻度0、1、2、3、4；纵轴为z_v/R，范围-4到0，
// 主刻度0、-1、-2、-3、-4。颜色映射由底部色标给出，从深
// 蓝（0.05）经青、绿、黄到橙红（0.35），表示相对拟合误差
// E(h,z_v)。两幅图中均有一条自左上向右下弯曲的低误差（深
// 蓝）带，误差随h/R增大和z_v/R降低而增大（颜色变黄）。左
// 图约在(h/R≈0.5, z_v/R≈-0.9)处有一个红色圆点标记，右图
// 约在(h/R≈1.0, z_v/R≈-1.0)处有一个红色圆点标记。该图传
// 达的趋势是：在特定的高度和间距参数下拟合误差存在极小值，
// 二聚体与三聚体的误差分布形态相似但极小值位置不同。
#figure(image("imgs/FigS5.png", width: 99.0%),
  caption: [
    #strong[Fitting of experimental in-plane flow fields.] #strong[a,]~Schematic of the locations~ of near-field Stokeslet forces~ (brown arrows, see Tab.~2) used to fit flow fields around rotating pairs and triplets. Red arrows indicate corresponding rotlet-associated torques $upright(bold(T)) = hat(T)_(upright("nf")) upright(bold(e))_z$. #strong[b,]~Relative least squares errors $E ( h , z_v ) = chevron.l | upright(bold(v))_(upright("fit")) - upright(bold(v))_(upright("exp")) | chevron.r_(x , y) slash max_(x , y) | upright(bold(v))_(upright("exp")) |$ of fits to $x y$-plane flows around the rotating pair (left, $macron(R) = 108 thin mu$m) and triplet (right, $macron(R) = 111 thin mu$m) shown in Fig.~2c (main text) and in @fig:PIVfittingtrip, respectively. Red dots indicate fit parameters that globally minimize $E ( h , z_v )$.
  ]
)
<fig:PIVfitting>



#emph[General fit function:] The final flow field that is fitted to measured tracer particle velocity fields around single embryos~($N_(c l) = 1$), pairs~($N_(c l) = 2$) and triplets~($N_(c l) = 3$) is given by a fit function


$ upright(bold(v))_(upright("fit")) ( upright(bold(r)) ) = sum_(i = 1)^(N_(c l)) [macron(upright(bold(v)))_(upright("st")) (upright(bold(r))   - F_(upright("st")) upright(bold(e))_z , upright(bold(r))_0^(( i ))) + macron(upright(bold(v)))_(upright("st")) (upright(bold(r))   hat(F)_(upright("nf")) upright(bold(e))^(( i )) , upright(bold(r))_0^(( i ))) + macron(upright(bold(v)))_(upright("rot")) (upright(bold(r))   hat(T)_(upright("nf")) upright(bold(e))_z , upright(bold(r))_0^(( i )))] , $<eq:ufit>


where $macron(upright(bold(v)))_(upright("st"))$ and $macron(upright(bold(v)))_(upright("rot"))$ are given in Eqs.~(@eq:stok_forfit) and (@eq:rot) and $hat(F)_(upright("nf")) = hat(T)_(upright("nf")) = 0$ for isolated single embryos. For a comparison with measurements, Eq.~(@eq:ufit) is evaluated at $upright(bold(r)) = ( x , y , z_v )^top$ and the parameters $F_(upright("st")) , hat(F)_(upright("nf")) , hat(T)_(upright("nf")) , h$ and $z_v$ are determined from a suitable fit procedure (see below). The positions~ of all flow singularities and the orientations~ of the near-field forces used for these fits are listed in Tab.~2 and depicted in~#ref(<fig:PIVfitting>)a.


#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([$N_(c l)$], [$upright(bold(r))_0^(( i ))$], [$upright(bold(e))^(( i ))$], [Fit parameters],),
    table.hline(),
    [1], [$- h upright(bold(e))_z$], [$-$], [$( h , z_v , F_(upright("st")) )$],
    table.cell(rowspan: 2)[2], [$- l slash 2 upright(bold(e))_x - h upright(bold(e))_z$], [$upright(bold(e))_y$], table.cell(rowspan: 2)[$( h , z_v , F_(upright("st")) , hat(F)_(upright("nf")) , hat(T)_(upright("nf")) )$],
    [$l slash 2 upright(bold(e))_x - h upright(bold(e))_z$], [$- upright(bold(e))_y$],
    table.cell(rowspan: 3)[3], [$l slash 2 (upright(bold(e))_x - 1 slash sqrt(3) upright(bold(e))_y) - h upright(bold(e))_z$], [$- 1 slash 2 (upright(bold(e))_x + sqrt(3) upright(bold(e))_y)$], table.cell(rowspan: 3)[$( h , z_v , F_(upright("st")) , hat(F)_(upright("nf")) , hat(T)_(upright("nf")) )$],
    [$- l slash 2 (upright(bold(e))_x + 1 slash sqrt(3) upright(bold(e))_y) - h upright(bold(e))_z$], [$1 slash 2 (- upright(bold(e))_x + sqrt(3) upright(bold(e))_y)$],
    [$l slash sqrt(3) upright(bold(e))_y - h upright(bold(e))_z$], [$upright(bold(e))_x$],
  )],
  caption: [Table 2: Positions $upright(bold(r))_0^(( i ))$ and near-field force orientations~$upright(bold(e))^(( i ))$ of flow singularities used to fit $upright(bold(v))_(f i t) ( upright(bold(r)) )$ given in Eq.~(@eq:ufit) to experimentally measured flow fields. $l$ denotes average nearest neighbor centroid distances. Fit parameters are given by the distance of the flow singularities to the surface ($h$), the apparent $z$-coordinate of the $x y$-plane in which the flow is observed ($z_v$), as well as the strengths $F_(upright("st"))$, $hat(F)_(upright("nf"))$ and $hat(T)_(upright("nf"))$ of the different flow singularities used in $upright(bold(v))_(upright("fit")) ( upright(bold(r)) )$ given in Eq.~(@eq:ufit). (see Sec.~@sec:PIVfit for details). ],
  kind: table,
  numbering: none,
)
<Tab:FlowFieldFit>


#emph[Least squares fit and nonlinear optimization:] Fitting parameters that need to be determined are in all cases given by the upright Stokeslet strength $F_(upright("st"))$, the distance of the flow singularities to the surface $h$, and the effective $z$-coordinate~$z_v$ of the plane in which the $x y$-plane flow is observed. Fits of flow fields surrounding pairs and triplets additionally include a near-field Stokeslet and rotlet strength, $hat(F)_(upright("nf"))$ and $hat(T)_(upright("nf"))$, respectively~(#ref(<fig:PIVfitting>)a). To determine these fitting parameters from flow fields $upright(bold(v))_(upright("exp"))$ measured in the $x y$-plane, we proceeded in two steps. First, for a given observation plane~$z_v$ and distance of flow singularities below the surface~$h$, we note that the fit function $upright(bold(v))_(upright("fit"))$ given in Eq.~(@eq:ufit) depends linearly on the Stokes flow parameters $F_(upright("st")) , hat(F)_(upright("nf"))$ and~$hat(T)_(upright("nf"))$. Hence, for given $h$ and $z_v$, these singularity strengths can be determined from an exact least squares minimization of the error $E ( h , z_v ) = chevron.l | upright(bold(v))_(upright("fit")) - upright(bold(v))_(upright("exp")) | chevron.r_(x , y) slash max_(x , y) | upright(bold(v))_(upright("exp")) |$, where only the in-plane $x$- and $y$-components of $upright(bold(v))_(upright("fit"))$ contribute to this error. For an embryo (or pairs and triplets) of apparent (average) radius $macron(R)$, the error $E ( h , z_v )$ was determined on a $100 times 100$ parameter grid on which $h slash macron(R)$ and $z_v slash macron(R)$ are varied in intervals $[ 0 , 4 ]$ and $[ - 4 , 0 ]$, respectively, and $F_(upright("st")) , hat(F)_(upright("nf"))$ and~$hat(T)_(upright("nf"))$ are determined by least squares fitting $upright(bold(v))_(upright("fit"))$ to measured flow fields $upright(bold(v))_(upright("exp"))$ at each point of this ($h , z_v$)-parameter grid~(#ref(<fig:PIVfitting>)b). In a second step, the final fit parameters are chosen from the fit that globally minimizes the error $E ( h , z_v )$. Exemplary error maps $E ( h , z_v )$ of pair and triplet fits are shown in #ref(<fig:PIVfitting>)b. \


// [figvision-cn] imgs/FigS6.png
// 整幅图由四个高度相同的方形子图并列组成，下方由两条独立
// 的色标分别对应左侧两个子图和右侧两个子图。子图从左到右
// 依次为实验测量的径向流场、理论拟合的径向流场、实验测量
// 的方位角流场、理论拟合的方位角流场。所有子图具有相同的
// 空间布局：中心是由三个等大灰色圆形（代表三个相邻的旋转
// 粒子，呈品字形排列）组成的“三体”结构，相邻圆形之间留有
// 小孔隙。所有子图中的矢量场箭头均从三体结构中心向外辐射，
// 覆盖整个正方形视场，箭头长度和方向指示局部流速。每个子
// 图均无显式的绝对坐标轴数值刻度，但四个子图共享同一空间
// 坐标系：左下角的水平箭头标注为“x”轴，垂直箭头标注为“y”
// 轴，均指向正方向。左上角子图还提供了极坐标基准：一个从
// 中心向外指的箭头标注为“e_r”（径向单位矢量），一个与e_r
// 垂直指向逆时针方向的箭头标注为“e_φ”（方位角单位矢量）。
// 比例尺仅出现在左侧径向实验子图的右下角，为一条水平白色
// 线段，图注标明其长度为200 m（微米）。 子图a（最左）：
// 子图类型为二维伪彩色场叠加矢量箭头图。左上角文字标注“
// Experiment”。背景颜色映射为径向面内流速的绝对值 |v_xy
// · e_r|，单位mm/s，色标范围从0（深蓝）到0.15（亮黄）。
// 颜色分布呈明显的径向对称：三个粒子表面附近为高值区（黄
// 色至橙色），向外围逐渐衰减至蓝色。黑色箭头（矢量方向）
// 与径向单位矢量 e_r 一致向外辐射，箭头长度随流速大小变
// 化，靠近粒子处箭头长而密集，远离处短而稀疏。图中叠加了
// 一条白色虚线圆环，半径约为三个粒子组合尺寸的两倍，用于
// 标示流场衰减至某一参考值的径向距离。实验图像中粒子表面
// 有轻微的高光反射，显示其三维球状形态。该子图传达的趋势
// 是：三体旋转产生的流场在径向上以向外辐射为主，强度随距
// 离增大而衰减。 子图b（左二）：子图类型为与子图a对应的
// 理论拟合伪彩色场叠加矢量箭头图。左上角文字标注“Theory”。
// 背景颜色映射与子图a相同（|v_xy · e_r|，0至0.15 mm/s），
// 色标共用左侧下方的连续色带。理论计算的径向流场呈现出与
// 实验高度一致的径向对称图案：粒子间隙及表面附近为黄橙色
// 高值区，外围逐渐过渡为蓝绿色低值区。黑色矢量的方向与分
// 布与子图a几乎完全相同，均呈径向向外发散。该子图说明，
// 基于Stokes方程和流体动力学相互作用的理论模型能够定量重
// 现实验测得的径向流速幅值及其空间衰减趋势。 子图c（右二）：
// 子图类型为二维伪彩色场叠加矢量箭头图。左上角文字标注“
// Experiment”。背景颜色映射为方位角面内流速 v_xy · e_φ，
// 单位mm/s，色标范围从-0.04（深蓝）到0.04（深红），对应
// 于右侧下方的蓝-白-红色带。该子图背景颜色分布呈现明显的
// 四极对称特征：在三个粒子构成的品字形结构的左右两侧（沿
// x轴方向）出现红色（正方位角流速，逆时针方向），而在上
// 下两侧（沿y轴方向）出现蓝色（负方位角流速，顺时针方向），
// 形成交替的红蓝象限。黑箭头的方向在此子图中并非均一径向，
// 但在远离粒子中心的外围区域仍主要呈径向向外；在粒子间隙
// 附近，箭头强烈偏转。实验测量中，粒子表面附近的彩色区域
// 因实验噪声和粒子边缘的光学衍射而呈现出较明显的局部红蓝
// 斑驳。该子图传达的趋势是：三体旋转不仅产生径向流，还产
// 生具有四极对称性的方位角流场分量，其幅值约为径向流速的
// 几十分之一（0.04 vs 0.15 mm/s）。 子图d（最右）：子图
// 类型为与子图c对应的理论拟合伪彩色场叠加矢量箭头图。左
// 上角文字标注“Theory”。背景颜色映射与子图c相同（v_xy ·
// e_φ，-0.04至0.04 mm/s），共用右侧下方的蓝-白-红色带。
// 理论计算的方位角流场呈现出与实验一致的左右红、上下蓝的
// 交替象限分布，但色块边界比实验图更平滑、对称性更好，粒
// 子表面附近没有明显的红蓝斑驳。黑矢量的方向在外围区域与
// 子图c一致，在粒子间隙附近的偏转角度也与实验高度吻合。
// 该子图说明，理论模型不仅拟合了径向主流动，还准确捕捉了
// 方位角流场中微弱的四极对称分量，验证了所假设的流体动力
// 学相互作用机制的正确性。
#figure(image("imgs/FigS6.png", width: 99.0%),
  caption: [
    #strong[Fitting of top-view flow fields around triplet bound near the fluid surface.] Measured radial and azimuthal flow field components surrounding a rotating triplets (“Experiment\") can be quantitatively described with suitable solutions of the Stokes equation~(“Theory\", see Sec.~@sec:PIVfit) by invoking hydrodynamic interactions illustrated in Fig.~2d (main text). Scale bar, 200 $mu$m.
  ]
)
<fig:PIVfittingtrip>



#emph[Fit results:] The single-embryo Stokeslet strengths $F_(upright("st"))$ found by the fitting procedure described above are shown in #ref(<fig:StokesletHydrod>)a and an exemplary fit represented as a radial projection is shown in main text Fig.~2b. For the flow field around the rotating pair shown in Fig.~2c (main text), we find $F_(upright("st")) = 1.1 thin$nN, $hat(F)_(upright("nf")) = 25.4 thin$pN and~$hat(T)_(upright("nf")) = 11 thin$pN$dot.op macron(R)$ ($macron(R) = 108 thin mu$m) assuming a viscosity of $eta = 1 thin$mPa$dot.op$s to estimate the involved forces and torques. For the flow field around the rotating triplet shown in @fig:PIVfittingtrip, we find $F_(upright("st")) = 1.1 thin$nN, $hat(F)_(upright("nf")) = 19.8 thin$pN and~$hat(T)_(upright("nf")) = 23.3 thin$pN$dot.op macron(R)$ ($macron(R) = 111 thin mu$m). Compared to fitting results for single embryos (#ref(<fig:StokesletHydrod>)a), the Stokeslet strength $F_(upright("st"))$ is reduced, which is most likely due to a lack of flow screening in a pure singularity description of multiple swimmers. Importantly, the signs ($hat(=)$ orientations) of the fitted near-field contributions are consistent with the orientations of forces and torques expected from the hydrodynamic interactions (main text Fig.~2d, Sec.~@sec:HydrModel): Consistent with $hat(F)_(upright("nf")) > 0$ (see #ref(<fig:PIVfitting>)a), clockwise spinning of bound embryos indeed leads to a clockwise rotation of pairs and triplets, and consistent with $T_z = hat(T)_(upright("nf")) > 0$, excess torques that arises from the reduced embryo spinning frequencies are expected to point along the positive $z$-direction. Furthermore, we note that the ratio of near-field forces and torques from these fits, $macron(R) hat(F)_(upright("nf")) slash hat(T)_(upright("nf")) approx 2.3$ (pair) and $macron(R) hat(F)_(upright("nf")) slash hat(T)_(upright("nf")) approx 0.8$ (triplet), are similar to the ratio $f_0 slash tau_0 = 0.5$ of near-field force and torque strengths used in the minimal model (Eqs.~(@eq:Finter),(@eq:Tinter), see Tab.~1), where the latter had been determined by matching rotation frequencies of pairs and triplets between theory and experiment (Sec.~@sec:ModPara, #ref(<fig:EmbryoProps>)c).


== Analysis of side-view flow fields surrounding confined embryos
<sec:FFanalsisSide>
Here, we describe the experimental procedures and fitting methods used to spatially resolved the fluid flows generated along the lateral embryo surface. While the analysis described in Sec.~@sec:FFanalsis captures flows from a top-view and provides a direct quantification of the Stokeslet strength and effective hydrodynamic attraction, the analysis described here spatially resolves flow properties along the embryo's AP~body axis and provides the quantitative basis for the developmental stability analysis in Secs.~#ref(<sec:StabAnalFull>)--@sec:stabtimefinal.


=== Flow field measurements
<sec:FFMSide>
Embryos were confined between a glass slide and a cover slip (separation distance $approx thin 100 thin mu$m) such that their long axes were parallel to the imaging plane. Surrounding flow fields were characterized by analyzing the motion of tracer beads though particle image velocimetry (PIV) using the PIVlab plugin for MATLAB #link(<si-20>)[[20, 21, 22]]. Default PIVlab setting were used, with the exception that the “Pass 1 interrogation area\" and “Step\" were set to 128 and 64 pixels, respectively, (corresponding to $approx$ 164 $mu$m and $approx$ 82 $mu$m) and the “Pass 2 interrogation area\" was set to 64 pixels ($approx$ 82 $mu$m). The resulting velocity fields were temporally averaged over either 100 or 500 frames (frame rate 20 fps). Exemplary maximum projections over 100 frames that reveal the streamlines of these flow fields are shown in #ref(<fig:SideViewFitResults>)a. Additionally, the outer contour of each embryo at a given time was found by first generating a binary mask using an intensity threshold to identify pixels corresponding to the embryo. Holes in this mask were then filled, and the mask was smoothed and spurious pixels removed through repeated erosion and dilation. The largest connected region provides a binary mask of the embryo, and the gradient of this mask approximates the embryo's outer contour. A smooth representation of the latter was generated by Fourier-transforming the radial-azimuthal representation $r ( phi )$ of the approximate contour and using only the first 10 Fourier-modes for further analysis~(blue outlines in #ref(<fig:SideViewFitResults>)b).


// [figvision-cn] imgs/FigS7.png
// 子图a为实验流场最大投影显微图像，含三幅，分别标注为3h、
// 19h、50h，右侧各有白色比例尺，按图注为100微米，对应胚
// 胎早期、中期、晚期三个发育阶段。每幅图中，中央为胚胎，
// 呈圆形或椭圆形，内部可见明暗结构；两侧标注P（后）与A（
// 前），P在左、A在右。胚胎周围布满由胚胎表面附近发出的流
// 线，呈放射或螺旋状汇入与外流。3h时可见一对近似对称的涡
// 旋结构；19h时原对称涡旋对向A侧（右侧）偏移，A端附近出
// 现第二对涡旋；50h时原涡旋继续后移，A端第二对涡旋更明显，
// 流线覆盖范围与胚胎轮廓增大。 子图b为与a一一对应的
// Hele-Shaw流拟合流线图，采用直角坐标系x横轴、y纵轴，均
// 无刻度数值，仅示方向。每幅图中央为蓝色闭合曲线表示胚胎
// 截面轮廓，周围为黑色流线。3h图中显示上下对称的一对涡旋，
// 蓝色轮廓内标出几何中心点与偏心矢量e_x、e，以及水平虚线。
// 19h图涡旋对向A端偏移，流线不对称；50h图A端附近出现一对
// 附加涡旋，流线形态更复杂。整体显示，拟合流线与实验流线
// 拓扑一致。 子图c为模态幅值随模态数变化图，共四个子图。
// 左起第一幅纵轴为A_n，单位mm/s，量程-12至12，刻度乘10^
// -2；横轴模态数n，0至9。三条曲线：黄线Early <8h，蓝线
// Mid 8h…30h，红线Late >30h，均带误差棒。A_n在n=0处接近0，
// n=1处略微负值，n=2至7基本在0附近，n=8、9略上升；Late在
// n=1、n=2较低。第二幅纵轴为B_n（mm/s），量程-4至12；B_n
// 在n=1处Early、Mid、Late均正峰，Mid最高约6；n=2处Late负
// 值约-2，之后趋近0。第三幅纵轴C_n（mm/s），量程-8至8，
// 刻度乘10^-2；C_n在n=1至6有波动，n=3处Early、Mid约4，n=
// 7以后接近0。第四幅纵轴D_n（mm/s），量程-4至4；D_n除n=1
// 处Late略负外，其余多数接近0。每幅子图上方均有小示意图，
// 蓝色轮廓代表胚胎，黑色箭头表示外围流动方向：第一幅为上
// 下左右均匀压缩/拉伸；第二幅为上方箭头向左、右下箭头向
// 右；第三幅为右上、左下方向箭头；第四幅为左上、右下方向
// 箭头。下方图例区分Early、Mid、Late。
#figure(image("imgs/FigS7.png", width: 99.0%),
  caption: [
    #strong[Fitting of experimental side-view flow fields.] #strong[a,]~Flow field streamlines surrounding embryos confined between glass slide and cover slip at different developmental stages (maximum projections, see Sec.~@sec:FFMSide). Over development, an initially symmetric vortex pair moves posteriorly (P) and a second vortex pair appears near the anterior end (A). Scale bar, 100 $mu$m. #strong[b,]~Streamlines of Hele-Shaw flow solutions Eqs.~(@eq:HSsol) fitted to experimental data in~#strong[a] (see Sec.~@sec:PIVfitSide). #strong[c,]~Mean and standard deviations of fitted mode amplitudes in Eq.~(@eq:HSsol) for embryos during early ($n = 7$), mid ($n = 14$) and late ($n = 16$) development. These coefficients suggest a minimal parametrization of fluid flows near the embryo surface. Indeed, using only the first three dominant modes $B_1 , thin B_2$ and $B_3$, is sufficient to capture the key properties of measured surrounding flows~(see @fig:SideViewFitResultsfortheo).
  ]
)
<fig:SideViewFitResults>



=== Flow field fitting
<sec:PIVfitSide>
In the following, we describe how the mode decomposition of embryo surface flows used in Sec.~@sec:DevModePara was extracted from side-view~PIV data. We denote the flows in this analysis by $upright(bold(V)) ( macron(x) , macron(y) )$ to emphasize that the Cartesian coordinate plane $( macron(x) , macron(y) )$ considered in these measurements is distinct from the “top-view\" $x y$-plane, where the latter is part of the three-dimensional domain in which clusters were analyzed throughout most of this work. We define cylindrical coordinates $( rho , phi )$ in this plane by $macron(x) = rho cos phi$ and $macron(y) = rho sin phi$ (see #ref(<fig:SideViewFitResults>)b). To take into account the confinement under which flow data was acquired (see Sec.~@sec:FFMSide), we aim to describe measured flows in terms of solutions of the Hele-Shaw equation~#link(<si-23>)[[23]]


$ eta Delta upright(bold(V)) - nabla P = kappa' upright(bold(V)) , $<eq:HS>


where $P ( macron(x) , macron(y) )$ is the pressure enforcing incompressibility $nabla dot.op upright(bold(V)) = 0$ and $kappa' = 12 eta slash H^2$ is an effective friction parameter resulting from interactions of the fluid flow with top and bottom surface of the channel of height $H$ ($approx thin 100 thin mu$m in experiments). The most general solution of Eq.~(@eq:HS) for which $upright(bold(V)) , P arrow.r 0$ at infinity can be written in cylindrical coordinates as $upright(bold(V)) = V_rho upright(bold(e))_rho + V_phi upright(bold(e))_phi$ with 


$ V_rho & = sum_(n = 1)^oo (A_n cos n phi - C_n sin n phi) (rho slash L)^(- n - 1) + sum_(n = 1)^oo (B_n cos n phi - D_n sin n phi) frac(K_(n + 1) - K_(n - 1), 2)\
V_phi & = sum_(n = 1)^oo (A_n sin n phi + C_n cos n phi) (rho slash L)^(- n - 1) + sum_(n = 0)^oo (B_n sin n phi + D_n cos n phi) frac(K_(n + 1) + K_(n - 1), 2) , $<eq:HSsol>


where $kappa = sqrt(kappa' slash eta) = sqrt(12) H^(- 1)$, $L = ( ell_(upright("min")) + ell_(upright("maj")) ) slash 2$ is the characteristic embryo size, $K_n ( kappa rho )$ denote modified Bessel functions of the second kind and the coefficients $( A_n , B_n , C_n , D_n )$ represent integration constants that will be determined by fitting the measurement data described in Sec.~@sec:FFMSide. Qualitatively, the coefficients $A_n$ and $B_n$ represent flows that are mirror-symmetric with respect to the $x$-axis, the coefficients $B_n$ and $D_n$ describe flows whose mirror-symmetry with respect to the $x$-axis is broken. To define the least-square optimization underlying these fits, we additionally introduce the stream function


$ Psi ( rho , phi ) = L sum_(n = 1)^oo (A_n slash n sin n phi + C_n slash n cos n phi) (rho slash L)^(- n) + kappa^(- 1) sum_(n = 0)^oo (B_n sin n phi + D_n cos n phi) K_n ( kappa rho ) $


that generates the flow field components in Eqs.~(@eq:HSsol) via $V_rho = rho^(- 1) partial_phi Psi$ and $V_phi = - partial_rho Psi$. We then solve the least-square problem


$ min_(A_n , B_n , C_n , D_n) bar.v.double upright(bold(V)) - upright(bold(v))_(upright("exp")) bar.v.double_2 + bar.v.double upright(bold(e))_s dot.op nabla Psi |_(cal(C)) bar.v.double_2 , $<eq:LSopt>


where $upright(bold(v))_(upright("exp"))$ denotes data from flow measurements~(Sec.~@sec:FFMSide), $upright(bold(e))_s$ denotes the unit tangent vector along the curve $cal(C)$ prescribed by the embryo boundary~(blue outlines in #ref(<fig:SideViewFitResults>)b). The norm~$bar.v.double dot.op bar.v.double_2$ indicates the square of the Euclidean norm at which experimental velocities~$upright(bold(v))_(upright("exp"))$ were measured. The second term in Eq.~(@eq:LSopt) penalizes flow contributions from~$upright(bold(V))$ that are not tangential at the embryo surface. The prefactor of this term corresponds to a weight, which is set here to $1$, while we note that the final fits and conclusions drawn from them do not dependent on this particular choice. Exemplary fits resulting from this approach for embryos are shown in~#ref(<fig:SideViewFitResults>)b. The corresponding mode amplitudes, pooled at three different developmental stages, are depicted in~#ref(<fig:SideViewFitResults>)c. Mode coefficients $B_n$ (gray box in #ref(<fig:SideViewFitResults>)c) that describe mirror-symmetric flows along the embryo's AP axes are the dominating contribution to these fits and are used in Sec.~@sec:DevModePara to parametrize changes of near-surface flow fields surrounding developing embryos.


== Embryo spinning frequencies
<embryo-spinning-frequencies>
#emph[Analysis of embryo spinning frequencies in small clusters:] Average embryo spinning frequencies were determined from the manually measured duration of 10 embryo rotations~(data “In small clusters\" in Fig.~2f, main text).~ \


#emph[Automated analysis of embryo spinning frequencies in large clusters:] To measure embryo spinning frequencies within clusters containing $approx 100$ embryos, we took advantage of the inhomogeneous intensity profile within the embryo body that results from the uneven positioning of developing internal organs. We first processed raw videos using Fiji~#link(<si-17>)[[17]] by inverting the pixel intensity and performing a background subtraction. For each embryo, we shifted the origin of the coordinate system to the embryo centroid, and considered pixels within a circular neighborhood with radius equal to the apparent embryo radius. From these pixels, we constructed an angular intensity profile $I ( theta , t )$ at each time $t$ by averaging the pixel intensity within sectors of angular width~$pi slash 90$. We then smoothed the angular intensity profile using adjacent averaging of 10 points in $theta$ and 500 points in $t$ to reduce noise and suppress slow global intensity variations, respectively. We then computed the cross-correlation between angular intensity profiles $I ( theta + Delta theta , t + Delta t )$ and $I ( theta , t )$ at two time points, and determined the angular lag $Delta theta = Delta theta_(m a x)$ that maximizes this cross-correlation. While the analysis can be performed between successive frames, performing a running average over $Delta t$ frames yields a higher signal to noise ratio and hence more accurate results. In practice, we chose $Delta t = 3$ frames and subsequently determined the measured dynamics $macron(theta) ( t )$ from a cumulative sum over $Delta theta_(m a x)$. Finally, we fitted $theta ( t ) = omega t^2 slash 2$ to the cumulative sum of $macron(theta) ( t )$ to determine a noise-robust estimate of the embryo's spinning frequency $omega slash ( 2 pi )$~(data “In larger clusters\" in Fig.~2f, main text).~ \


#emph[Analysis of embryo spinning frequencies in the oscillating cluster:] Embryo spinning frequencies inside oscillating clusters (main text Fig.~4d) were not amenable to automated tracking. Therefore, we manually determined the spinning rates of 40 embryos within the cluster and found a value of $( 0.33 plus.minus 0.13 ) thin$min$""^(- 1)$ (mean$thin plus.minus thin$standard deviation,~$n = 40$).


== Quantifying sources of effective noise contributing to cluster dissolution
<quantifying-sources-of-effective-noise-contributing-to-cluster-dissolution>
As embryos develop, they exhibit notable changes in their hydrodynamic properties (see Sec.~@sec:FFMSide and @fig:SideViewFitResults) and in their morphology (see main text Fig.~1b, #ref(<fig:SideViewFitResultsfortheo>)d,e for views in the plane of the embryo's anterior-posterior axis). These changes introduce sources of an effective noise in embryo interactions that leads to a gradual loss of positional order (Fig.~3a,b) and eventually facilities cluster dissolution. We quantified two features associated with this effective noise that can be directly observed in top-view images of clusters: Body shape anisotropies perpendicular to the anterior-posterior axis that make embryos “bump\" into each other when closely packed and spinning within a cluster, as well as the tilt angle of embryos at cluster boundaries that increases their tendency to swim away from or to be scattered off the cluster boundary. The corresponding data is shown in Fig.~2h,i (main text).


=== Shape anisotropy of embryo cross-sectional area
<sec:shapanis>
Of particular importance for interactions in clusters is the morphological symmetry breaking in the dorsal/ventral-left/right (DV-LR) plane perpendicular to the embryo's AP axis. When embryos are bound below the fluid surface, this plane is parallel to the “top-view\" $x y$-plane defined in Fig.~1e. To quantify the anisotropy of embryo shape in the DV-LR plane, we have fitted ellipses to outlines of embryos in the bulk of the crystal (red outlines in main text Fig.~2h). To find outlines from brightfield images, we first identified the white spaces between the embryo center and boundary using the pixel classification functionality of the software ilastik~#link(<si-24>)[[24]]. The labeling of training data is done at different time points to improve the classification quality. We then fit ellipses onto the identified region using MATLAB's `regionprops` function. To eliminate spuriously defined regions, we only consider regions with areas within 9000 and 26000 $mu$m$""^2$ (120 and 350 pixels squared). From fitted ellipses, we obtain the minor and major axis lengths $ell_(>)$ and $ell_(<)$, respectively, and compute the ellipticity of the embryo's top-view cross section as $1 - ell_(>) slash ell_(<)$ (data shown in main text Fig.~2h).


=== Tilt angle of embryos at cluster boundaries
<tilt-angle-of-embryos-at-cluster-boundaries>
Focusing now on embryos at cluster boundaries, we want to determine tilt angles of the embryo's AP axis away from the $z$-axis (see main text Fig.~1e and Fig.~2j inset for definition of $z$-axis and tilt angle). With basic shape information given, tilt angles can be inferred from projected embryo outlines in the $x y$-plane. Similar to the approach in Sec.~@sec:shapanis, outlines were characterized by the principal axis lengths $macron(ell)_(>)$ and $macron(ell)_(<)$ of ellipses that we placed manually over embryo outlines. An automated segmentation could not be realized for this analysis due to the increasingly complex embryo morphology at later developmental stages.


While 3D embryo shapes are approximately given by ellipsoids with possibly three distinct principal axes (see @fig:SideViewFitResultsfortheo and main text Fig.~2h for shape anisotropies in the AP-LR- and in the DV-LR-plane, respectively), we found that the projected minor axis $macron(ell)_(<)$ of tilted embryos hardly changed across different measurement time points. In this case, tilt angles can be systematically determined from the projected major axis $2 macron(ell)_(>)$, if the embryo's actual AP axis length $2 ell_(upright("maj"))$ (see #ref(<fig:SideViewFitResultsfortheo>)c) is known. We estimated the latter independently from horizontally swimming embryos ($ell_(upright("maj")) = [ 155 , 186 , 212 ] thin mu$m for the 3 time points $t_d = [ 11 , 28 , 33 ] thin$hours in Fig.~2i). We then determined a “look-up table\" $ell_(x y) ( theta )$ by projecting a correspondingly rotated ellipsoid with minor and major axis lengths $2 macron(ell)_(<)$ and $2 ell_(upright("maj"))$, respectively, onto the $x y$-plane and compared the values $ell_(x y) ( theta )$ to measurements of~$macron(ell)_(>)$ to infer the tilt angle~$theta$ shown in Fig.~2i (main text).


== Orientational order parameter
<sec:OrientOrd>
To compute the local bond orientational order for each embryo $i$, the nearest neighbor embryo is first determined by a delaunay triangulation of embryos within the cluster (using the MATLAB function `delaunay`). A threshold of $1.5 a$ with lattice constant $macron(a) approx 207 thin mu$m was applied to exclude cases where nearest neighbors are anomalously determined at the cluster boundary due to irregular cluster shapes. The local bond orientational order parameter~#link(<si-25>)[[25]] is then defined as


$ psi_6 ( upright(bold(r))_i ) = 1 slash N_i sum_(j = 1)^(N_i) e^(i 6 phi.alt_(i j)) equiv | psi_6 |_i e^(i phi.alt_i) , $<eq:hexorder>


where the sum is over the $N_i$ nearest neighbors of embryo~$i$, and~$phi.alt_(i j)$ is the angle between the $x$-axis of the co-rotated cluster frame and the bond connecting embryos $i$ and $j$. $| psi_6 |_i$ quantifies the magnitude of local hexagonal order and $phi.alt_i = arg psi_6$ measures the angle of the local bond orientational order parameter.


== Pair distribution function
<pair-distribution-function>
Following~#link(<si-26>)[[26]], we define the radial pair distribution function~$g ( r )$ as


$ g ( r ) = frac(1, 2 pi r N_(c l) chevron.l n chevron.r) ⟨sum_(i eq.not j) delta ( r - | upright(bold(r))_i - upright(bold(r))_j | )⟩ , $<eq:gr>


where $N_(c l)$ is the total number of centroids in a cluster and $chevron.l dot.op chevron.r$ denotes the average over all centroids at positions~$upright(bold(r))_i$ and $upright(bold(r))_j$. The number density $chevron.l n chevron.r$ in Eq.~(@eq:gr) was estimated from the rotation-corrected centroid data~(see Sec.~@sec:EmbrProc) by identifying boundary centroids using the MATLAB function `boundary`, finding the area defined by these boundary centroids using `polyarea`, and dividing the total number of centroids by this area. A time course of the number density $chevron.l n chevron.r$ is shown in #ref(<fig:lattice_props>)a. The pair distribution $g ( r )$, e.g. as shown in the inset of Fig~3f (main text), was then computed at~100 s intervals by approximating Eq.~(@eq:gr) at discrete points $r_k = k Delta r$ ($k = 1 , 2 , 3 , . . .$) as


$ g ( r_k ) = frac(1, 2 pi k N_(c l) chevron.l n chevron.r (Delta r)^2) sum_(i eq.not j) bb(1)_(r_k lt.eq | upright(bold(r))_i - upright(bold(r))_j | < r_(k + 1)) , $<eq:gr_discr>


which uses an indicator function $ bb(1)_(r_k lt.eq | upright(bold(r))_i - upright(bold(r))_j | < r_(k + 1)) = cases(
    1 & upright("if ") r_k lt.eq | upright(bold(r))_i - upright(bold(r))_j | < r_(k + 1),
    0 & upright("else") .
  ) . $<eq:indicfunc> The bin width was $Delta r approx 8.6 thin mu$m. Finally, the nearest neighbor peak of $g ( r_k )$ was fit to a Gaussian function $G ( r ) = C exp [- ( r - r_mu )^2 slash (2 sigma^2)]$ (Fig.~3f, inset) with fitting parameters describing the amplitude~$C$, mean~$r_mu$, and width~$sigma$ of the peak. That latter was used as the “First Peak Width\" shown in Fig.~3f (main text), and $r_mu$ was taken as the lattice constant~$macron(a)$ (#ref(<fig:lattice_props>)b).


// [figvision-cn] imgs/FigS8.png
// 本图由两个并排的曲线图组成，分别标记为 a 和 b，展示晶
// 格特性随时间变化的平均时间进程。 子图 a：曲线图。左上
// 角标注黑色粗体字母 a。横轴为时间（Time），单位为小时（
// hours），刻度从 0 到 40，主刻度间隔为 10，范围覆盖 0
// 到约 36 小时。纵轴为数量密度（Number density ⟨n⟩），单
// 位为每平方毫米（mm⁻²），刻度从 0 到 40，主刻度间隔为
// 10。图中有一条蓝色实线，表示胚胎数量密度随时间的变化。
// 曲线在实验初始阶段（0 到约 8 小时）波动剧烈，数值在 22
// 到 40 mm⁻² 之间快速震荡，并呈现轻微下降趋势；随后从约
// 8 小时到 20 小时，曲线平滑下降至约 22 mm⁻²；20 小时之
// 后，曲线趋于平稳，维持在约 22 mm⁻² 的水平，但在 30 小
// 时之后再次出现小幅波动，最终在 36 小时附近回升至约 24
// mm⁻²。该图表明胚胎数量密度在初期快速变化后逐渐稳定。
// 子图 b：曲线图。左上角标注黑色粗体字母 b。横轴为时间（
// Time），单位为小时（hours），刻度从 0 到 30，主刻度间
// 隔为 10，范围覆盖 0 到约 36 小时。纵轴为晶格常数（
// Lattice constant ā），单位为微米（μm），刻度从 0 到
// 250，主刻度间隔为 50。图中有一条蓝色实线，表示晶格常数
// 随时间的变化。曲线在 0 小时处起始于约 210 μm，随后在 0
// 到 5 小时之间缓慢下降至约 195 μm 的极小值；之后从 5 小
// 时到 20 小时，曲线持续上升至约 220 μm；20 小时之后，曲
// 线上升趋势明显放缓，趋于平稳，在 36 小时附近达到约 225
// μm。该图表明晶格常数在初期略有收缩，随后逐渐增大并最终
// 趋于稳定。
#figure(image("imgs/FigS8.png", width: 97.0%),
  caption: [
    #strong[Time course of average lattice properties.] #strong[a,]~Number density $chevron.l n chevron.r$ of embryos in a crystal over the time course of the experiment. This information was used to compute the radial pair distribution function $g ( r )$ given in Eq.~(@eq:gr_discr) and shown as an inset in Fig.~3f (main text). #strong[b,]~Lattice constant~$macron(a)$ as a function of time from fitting the first, nearest-neighbors peak of $g ( r )$ (see also main text Fig.~3f, inset).
  ]
)
<fig:lattice_props>



== Dynamic Lindemann parameter
<sec:LM>
Following~#link(<si-27>)[[27]] and using rotation-corrected centroid positions~(see Sec.~@sec:EmbrProc), we define the dynamic Lindemann parameter as


$ gamma_L ( tau ) = frac(1, 2 macron(a)^2) sum_(j , j + 1) ⟨[Delta upright(bold(r))_j ( tau , t ) - Delta upright(bold(r))_(j + 1) ( tau , t )]^2⟩_t , $<eq:LM>


where $Delta upright(bold(r))_i ( tau , t ) = upright(bold(r))_i ( t + tau ) - upright(bold(r))_i ( t )$ denotes the displacement of embryo $i$ between two time points of duration $tau$ apart. Index pairs $j$ and $j + 1$ in Eq.~(@eq:LM) correspond to nearest neighbor pairs, and $a$ is the lattice constant. The analysis takes into account variation of $a$ with developmental time (#ref(<fig:lattice_props>)b). Two embryos were considered to be nearest neighbors if their initial positions were separated by a distance smaller than $1.2 a$.


// [figvision-cn] imgs/FigS9.png
// 这是一张单幅曲线图（无子图），展示动态 Lindemann 参数
// 随时间的变化。横轴为 Time τ (s)，范围 0 至 1000 秒，主
// 刻度为 0、200、400、600、800、1000，次刻度间隔 100 秒。
// 纵轴为 Dynamic Lindemann parameter γ_L，范围 0 至 0.2，
// 主刻度为 0、0.05、0.1、0.15、0.2，次刻度间隔 0.025。
// 图中共有六条由小圆点连接而成的数据曲线，代表不同发育时
// 间：8 小时（红色）、12 小时（橙色）、16 小时（黄色）、
// 20 小时（绿色）、24 小时（浅蓝色）、28 小时（深蓝色）。
// 所有曲线在 τ 接近 0 时起点均低于 0.05，在 τ 约 50 秒内
// 快速上升，之后转为较平缓的近似线性增长。红色曲线最低，
// 从约 0.02 快速升至约 0.04，随后缓慢增至 1000 秒时的约
// 0.06。橙色曲线约从 0.025 升至 0.05，最终达约 0.065。黄
// 色曲线约从 0.03 升至 0.06，最终达约 0.085。绿色曲线约
// 从 0.04 升至 0.075，最终达约 0.095。浅蓝色曲线约从
// 0.05 升至 0.09，最终达约 0.11。深蓝色曲线最高，约从
// 0.05 升至 0.11，最终在 1000 秒时达到约 0.175，并在 950
// –1000 秒处出现一个明显峰值约 0.18 后略回落。 图中在 τ
// 约 810 秒至 1000 秒之间有一块浅橙粉色半透明阴影区，覆
// 盖全部曲线尾部，用于标示后续统计平均与方差计算的时间窗
// 口（对应正文 Fig. 3g）。整体趋势表明：发育时间越长（从
// 8 小时到 28 小时），动态 Lindemann 参数整体越高，且随
// 时间的增长斜率越大，说明系统动态涨落随发育时间增强。
#figure(image("imgs/FigS9.png", width: 55.0%),
  caption: [
    #strong[Dynamic Lindemann parameter.] Representative plots for the dynamic Lindemann parameter $gamma_L ( tau )$ (see Sec.~@sec:LM) for developmental times $t_d$ of 8 h (red), 12 h (orange), 16 h (yellow), 20 h (green), 24 h~(light blue) and 28 h (dark blue). The average values and variance of $gamma_L ( tau )$ within the shaded region for different developmental times $t_d$ are shown in Fig.~3g (main text).
  ]
)
<fig:LMexample>



To generate Fig.~3g in the main text, we considered a subset of consecutive developmental time points $t_d$ that are $100$ s apart from each other. The Lindemann parameter $gamma_L ( tau )$ is then computed for each $t_d$ within a centered $1000$ s interval, i.e. the average in Eq.~(@eq:LM) was performed over times $t in [ t_d - 500$ s, $t_d + 500$ s$]$. @fig:LMexample shows representative examples of~$gamma_L ( tau )$ computed at different developmental time points~$t_d$. For each $t_d$, the mean and standard deviation of $gamma_L ( tau )$ over the range $800$ s~$< tau lt.eq 1000$ s (20 consecutive time points in total) are plotted as data points and error bars in Fig.~3g (main text), respectively. At very late times $> 30 thin$h, due to dissolution of the cluster, embryo trajectories do not last over $1000$ s, and hence, the dynamic Lindemann parameter cannot be calculated in this regime.


== Displacement field and strain components
<sec:SFcalc>
To determine displacement and strain fields of oscillating clusters (Fig.~4), rotation-corrected centroid trajectories~$upright(bold(r))_i ( t )$ (see Sec.~@sec:EmbrProc) of embryos $i = 1 , 2 , . . .$ were first smoothed with a 5-frame (50 s) moving average to remove noise. We then determined long-time averaged embryo positions $upright(bold(R))_i ( t ) = chevron.l upright(bold(r))_i ( t ) chevron.r_([ t - 25 , t + 25 ])$ by using a 50-frame (500 s) moving average. The displacement of each embryo from its average position is given by $upright(bold(u)) ( upright(bold(r))_i , t ) := upright(bold(u))_i ( t ) = upright(bold(r))_i ( t ) - upright(bold(R))_i ( t )$ and an exemplary displacement time series is shown in the inset of Fig.~4a (main text). A Fourier-analysis of $upright(bold(u)) ( upright(bold(r))_i , t )$ for all embryos that were continuously tracked throughout a time window of 4000 s revealed an average displacement oscillation frequency of $( 0.26 plus.minus 0.04 ) thin$min$""^(- 1)$ (mean $plus.minus$ standard deviation, $n = 389$).


A~continuous displacement field $upright(bold(u)) ( upright(bold(r)) , t )$ was approximated from all embryo displacements $upright(bold(u))_i ( t )$ by applying a 2D Gaussian filter of radius $macron(a) approx 216 thin mu$m (approximately one lattice constant). From $upright(bold(u)) ( upright(bold(r)) , t )$, we computed the displacement gradient tensor $u_(i j) = partial_i u_j$ in the $x y$-plane ($i , j in ( x , y )$). As described in Sec.~@sec:OddModuli and following the convention in~#link(<si-12>)[[12]], the displacement gradient tensor can be decomposed into four independent strain components given by (i)~the divergence $u^0 ( upright(bold(r)) , t ) = u_(x x) + u_(y y)$, (ii) the curl $u^1 ( upright(bold(r)) , t ) = u_(y x) - u_(x y)$, as well as by the two shear components (iii)~$u^2 ( upright(bold(r)) , t ) = u_(x x) - u_(y y)$ (shear~1), and (iv) $u^3 ( upright(bold(r)) , t ) = u_(y x) + u_(x y)$ (shear~2).


To determine space-time kymographs of the strain component dynamics along the boundary shown in maint text Fig.~4e,g, we first determined a parametrization~$upright(bold(r))_s$ of the cluster boundary (MATLAB function `bwboundaries`) in terms of the boundary arc length $s$. Finally, components of the displacement gradient tensor $u_(i j)$ were projected onto a local basis composed of the boundary tangent~$partial_s upright(bold(r))_s$ and the boundary normal pointing away from the cluster to compute transformed strain components $u^alpha$ ($alpha = 0 , 1 , 2 , 3$) analog to the definitions above. This transformation leaves the divergence and curl components $u^0$ and $u^1$, respectively, invariant and corresponds to a rotation of the strain component vector $( u^2 , u^3 )^top$ that conserves the total shear strain amplitude $u_s = sqrt([ u^2 ]^2 + [ u^3 ]^2)$ ($[ u^alpha ]^2$ with $alpha = 2 , 3$ denotes squared shear strain components). Strain components computed in the co-rotating Cartesian basis along a section through the bulk (dashed line in #ref(<fig:StrainInBulk>)a) are shown in #ref(<fig:StrainInBulk>)b and exhibit similar amplitudes and wavelengths, indicating that the corresponding excitations are present at the boundary and in the bulk of the cluster.


// [figvision-cn] imgs/FigS10.png
// 子图 a 由四幅二维应变分量空间快照组成，按 2×2 排列。左
// 上为 Divergence（散度），右上为 Curl（旋度），左下为
// Shear 1（剪切 1），右下为 Shear 2（剪切 2）。四幅图均
// 呈不规则团簇状分布，背景为浅灰色或白色，团簇结构以红蓝
// 两色叠加显示。每幅图的右侧带有一个竖直色标，标注物理量
// 名称，数值范围均从负值（红色）过渡到正值（蓝色）。
// Divergence、Shear 1 和 Shear 2 的色标范围均为 −0.05 至
// 0.05，Curl 的色标范围为 −0.08 至 0.08。四幅图中均有一
// 条贯穿上下的黑色虚线，左上 Divergence 图中黑色虚线右侧
// 标注有黑色比例尺 "1 mm"，标尺长度对应水平方向约 1 mm。
// Divergence 图中蓝色区域和红色区域交替分布，呈现局部压
// 缩与膨胀特征；Curl 图中红蓝区域呈现旋转式分布；Shear 1
// 和 Shear 2 图中红蓝区域呈斜向条带状交织。四幅图整体显
// 示团簇振荡期间四种应变分量在空间上的非均匀分布，且不同
// 分量的红蓝极性分布存在差异。 子图 b 由四幅并排的时空图
// （kymograph）组成，从左到右分别对应 Divergence、Curl、
// Shear 1 和 Shear 2 四个应变分量。四幅图共用同一纵轴
// Time (s)，范围从 0 到 3000 以上，主要刻度为 0、1000、
// 2000、3000，时间向下增加；每幅图的横轴均为 Arclength (
// mm)，范围从 0 到约 6，主要刻度为 0、2、4、6。四幅图均
// 采用红白蓝发散色标映射：负值为深红色，零为白色，正值为
// 深蓝色。每幅图下方带有一个水平色标，标注对应分量名称，
// Divergence、Curl、Shear 1 和 Shear 2 的色标范围均从 −
// 0.05 到 0.05。四幅图内部均显示沿时间方向延伸、沿弧长方
// 向交替出现的红蓝细条纹或斑块结构，表明应变在时间和空间
// 上均呈波动状变化。Curl、Shear 1 和 Shear 2 图在 2000–
// 3000 s 区间内出现较宽、较深的红蓝条带，提示该时段应变
// 波动幅度增大；Divergence 图的红蓝条带相对更细密且分布
// 较均匀。四幅时空图整体表明，沿子图 a 中黑色虚线位置测
// 得的四种应变分量均随时间发生周期性或准周期性的空间波动，
// 且不同分量在时间与弧长上的波动模式存在差异。
#figure(image("imgs/FigS10.png", width: 97.0%),
  caption: [
    #strong[Strain waves in bulk.]~#strong[a,]~Exemplary snapshots of the four strain components: divergence, curl, shear 1 and shear 2 during cluster oscillations. #strong[b,]~Space-time kymographs of the four principal strain components measured along the black dashed lines in #strong[a]. Details of the analysis are described in Sec.~@sec:SFcalc.
  ]
)
<fig:StrainInBulk>



== Mode chirality analysis of displacement waves
<sec:ModChir>
To characterize the bulk dynamics of cluster oscillations discussed in Fig.~4d--h (main text) with respect to their chiral symmetry, we consider a complex representation of the displacement field given by


$ U ( upright(bold(r)) , t ) = u_x ( upright(bold(r)) , t ) + i u_y ( upright(bold(r)) , t ) . $<eq:complrepr>


Here, $i$ denotes the imaginary unit, and $u_x ( upright(bold(r)) , t )$ and $u_y ( upright(bold(r)) , t )$ represent the Cartesian components of the smoothed, dynamic displacement field $upright(bold(u)) ( upright(bold(r)) , t )$ described in Sec.~@sec:SFcalc. Using the spatio-temporal Fourier transform of $U ( upright(bold(r)) , t )$ given by


$ tilde(U) ( upright(bold(q)) , omega ) = integral d upright(bold(r)) integral d t thin U ( upright(bold(r)) , t ) exp [- i (upright(bold(q)) dot.op upright(bold(r)) + omega t)] , $<eq:FT>


a mode chirality parameter can be defined as


$ C ( omega ) = frac(chevron.l | tilde(U) ( upright(bold(q)) , omega ) | - | tilde(U) ( - upright(bold(q)) , - omega ) | chevron.r_(upright("BZ")), chevron.l | tilde(U) ( upright(bold(q)) , omega ) | + | tilde(U) ( - upright(bold(q)) , - omega ) | chevron.r_(upright("BZ"))) . $<eq:ChirMeas>


Averages $chevron.l dot.op chevron.r_(upright("BZ"))$ over wave vectors $upright(bold(q))$ are taken within the first Brillouin zone defined by the lattice constant $macron(a) approx 220 thin mu$m of the hexagonal embryo cluster. The quantity $| C ( omega ) |$ characterizes the symmetry of the displacement field's Fourier spectrum $tilde(U) ( upright(bold(q)) , omega )$ with respect to point-reflections at the Fourier space origin. It vanishes if the spectrum is perfectly point-symmetric and becomes unity if the point-symmetry of a given mode is maximally broken. In practice, $C ( omega )$ given in Eq.~(@eq:ChirMeas) can be used to detect and quantify signatures of chirality in oscillating displacement fields. To see this explicitly, it is instructive to consider a minimal displacement wave of the form 


$ u_x ( upright(bold(r)) , t ) & = u_x^(( 0 )) cos (Omega t - lambda x)\
u_y ( upright(bold(r)) , t ) & = u_y^(( 0 )) sin (Omega t - lambda x) , $<eq:testwave>


for some frequency $Omega$ and wavelength $lambda$. The wave described by Eqs.~(@eq:testwave) represents a pure longitudinal (transverse) wave if $u_x^(( 0 )) eq.not 0$ and $u_y^(( 0 )) = 0$ ($u_x^(( 0 )) = 0$ and $u_y^(( 0 )) eq.not 0$). In either case, the Fourier amplitude of the complex representation Eq.~(@eq:complrepr) is point-symmetric, i.e. $| tilde(U) ( upright(bold(q)) , omega ) | = | tilde(U) ( - upright(bold(q)) , - omega ) |$ and consequently $C ( omega ) = 0$ (see Eq.~(@eq:ChirMeas)) for purely longitudinal or transverse waves. However, if both amplitudes of the minimal wave in Eq.~(@eq:testwave) are finite, $u_x^(( 0 )) eq.not 0$ and $u_y^(( 0 )) eq.not 0$, the wave acquires a chiral character, as seen by the well-defined rotation sense of displacement vectors at every point $upright(bold(r))$. In this case, the point-symmetry in Fourier-space is lost and $| C ( omega = Omega ) | eq.not 0$. Interestingly, for $u_x^(( 0 )) = u_y^(( 0 ))$ the displacement vector Eq.~(@eq:testwave) draws out perfect cirlces at every point $upright(bold(r))$, a characteristic of emergent displacement waves that can appear in purely odd elastic materials~#link(<si-12>)[[12]]. In this case, the chirality measure defined in Eq.~(@eq:ChirMeas) becomes maximal at the wave frequency, i.e. $| C ( omega = Omega ) | = 1$.


// [figvision-cn] imgs/FigS11.png
// 子图 a 为一张灰度显微照片，展示了一个由大量微小圆形颗
// 粒密集堆积形成的不规则团簇，团簇大致呈上宽下窄的形态，
// 颗粒呈深灰色环形（中心较亮），背景为浅灰色，图像右下角
// 和左上角有黑色边角区域。团簇上叠加了一个倾斜的浅灰色矩
// 形框，框内为用于模式手性分析的感兴趣区域。照片左下角有
// 一条黑色水平比例尺，图注标注为 1 mm。图中无其他文字标
// 注。 子图 b 为一张散点与平滑曲线叠加的图。横轴为“Mode
// frequency ω/(2π) (1/min)”，范围 0 到 2，刻度为 0、0.5、
// 1、1.5、2；纵轴为“Mode Chirality C(ω)”，范围 0 到 0.3，
// 刻度为 0、0.05、0.1、0.15、0.2、0.25、0.3。图例显示蓝
// 色代表“Before oscillations”，黄色代表“During
// oscillations”。图中蓝色和黄色各有散点及一条平滑曲线：
// 蓝色散点在 0.03–0.08 间波动，其平滑曲线整体维持在约
// 0.03–0.05；黄色散点峰值可达约 0.29，其平滑曲线在约 0.3
// min⁻¹ 处出现一个明显峰值（约 0.26），随后在 0.5–0.7
// min⁻¹ 间有次峰（约 0.18），之后随频率增加逐渐下降至约
// 0.03。图中有一条黑色竖直虚线位于约 0.3 min⁻¹ 处，对应
// 黄色曲线的主峰位置。该图传达的趋势是：在可见振荡发生期
// 间，模式手性参数在约 0.3 min⁻¹ 频率处显著增强，而未振
// 荡时该参数在全频段均较低。
#figure(image("imgs/FigS11.png", width: 97.0%),
  caption: [
    #strong[Mode chirality analysis of displacement waves.]~#strong[a,]~The mode chirality analysis described in Sec.~@sec:ModChir was performed on a $7.8 times 3.9 thin$mm region of interest indicated by the gray box over a time window of 135 min. Scale bar, 1 mm. #strong[b,]~Mode chirality parameter $C ( omega )$ given in Eq.~(@eq:ChirMeas) before the onset of (blue dots) and during (yellow dots) visible oscillations. A smoothed representation of this mode data is depicted by solid lines and serves as guide to the eye. The black dashed line indicates most prominent chiral oscillations at a frequency of approximately $0.28 thin$min$""^(- 1)$.
  ]
)
<fig:ModeChirality>



We have determined $C ( omega )$ from displacement field information $upright(bold(u)) ( upright(bold(r)) , t )$ located in the domain shown in #ref(<fig:ModeChirality>)a (gray box, $900 times 450$ pixel, corresponding to $7.8 times 3.9 thin$mm). Points of this domain outside the cluster were zero-padded. We then considered temporal sections of 800 consecutive time points ($approx 135 thin$min in total) before the onset of and during cluster oscillations. For each section, we computed a fast Fourier transform (MATLAB function~`fftn` #link(<si-28>)[[28]]) of the resulting $900 times 450 times 800$ data-cubes to approximate the Fourier transform Eq.~(@eq:FT) and determine $C ( omega )$ given in Eq.~(@eq:ChirMeas). During oscillations, a broad spectrum of frequencies shows chiral signatures~(yellow curve in #ref(<fig:ModeChirality>)b), including a distinct peak with frequency $approx 0.28 thin$min$""^(- 1)$~(black dashed line). An almost identical frequency ($0.26 thin$min$""^(- 1)$) is found from a direct analysis of the space-time kymographs that characterize strain component oscillation along the cluster boundary~(see main text Fig.~4e,g and Sec.~@sec:SFcalc). In the absence of visible cluster oscillations $| C ( omega ) |$ flattens substantially~(blue curve in #ref(<fig:ModeChirality>)b).


== Extracting elastic moduli from strain fields near crystal lattice defects
<sec:StrAnalysis>
Interactions between embryos within clusters give rise to emergent mechanical properties(Sec.~@Sec:CGmodel). To analyze these properties experimentally, we use the fact that living chiral crystals typically contain topological lattice defects, such as edge dislocations, that locally displace embryos away from a regular hexagonal arrangement. The associated displacement and strain fields contain information about the effective mechanical properties of a living chiral crystal (Fig.~4a--c, main text). In this section, we characterize these properties in terms of suitable elastic moduli. To this end, we compare experimental measurements with recently derived predictions about strain fields around edge dislocations in the most general linearly elastic isotropic material~#link(<si-13>)[[13]] that can also be out of equilibrium~#link(<si-12>)[[12]]. As suggested by the minimal model of the microscopic embryo interactions (Sec.~@Sec:ModelMapping), and consistent with experimental observations of overdamped chiral displacement waves (Sec.~@sec:ModChir) and strain cycles~(Fig.~4d--h, main text), we also allow for odd elastic moduli~(see Sec.~@sec:OddModuli) when fitting experimental displacement fields. Throughout this analysis, we use rotation-corrected centroid data (see~Sec~@sec:EmbrProc) and analyze embryo crystals at time points in which oscillations are absent.


=== Determining strain fields around lattice defects
<sec:SFD>
To properly resolve strain fields near defects, we follow the procedure suggested in~#link(<si-13>)[[13]] and briefly described below. Away from any lattice defects, this approach is consistent with the analysis in Sec.~@sec:SFcalc, while it does not require spatio-temporal smoothing and therefore provides a more detailed characterization of strain fields in the vicinity of defects. We consider a Delauny triangulation of embryo centroids to identify nearest neighbors (@fig:DefectStrainSI1) and define the “local displacement field\" around embryo $i$ as


$ bold("u")_i ( j_n ) = bold("r")_(j_n ( i )) - bold("r")_(j_n ( i ))^(upright("Tem")) , $<eq:locDisp>


which corresponds to the set of six displacement vectors $bold("u")_i ( j_n )$ associated with the six nearest neighbors $j_1 ( i ) , . . . , j_6 ( i )$ of embryo $i$, located at positions $bold("r")_(j_n ( i ))$. The positions $bold("r")_(j_n ( i ))^(upright("Tem"))$ correspond to the corners of a template hexagon that is defined as follows. First, we determine from the Delaunay triangulation global averages of the lattice constant $macron(a)^(upright("Tem"))$ and of the hexagonal bond orientation $phi.alt^(upright("Tem")) = arg chevron.l psi_6 chevron.r slash 6$ (mod~$pi slash 3$) with $psi_6$ defined in Eq.~(@eq:hexorder), where edges connecting to embryos without 6 neighbors or near the cluster boundary (closer than 650 $mu$m) are excluded. Template positions surrounding each embryo $i$ are then given by the corners of a hexagon located~at


$ upright(bold(r))_(j_n ( i ))^(upright("Tem")) = upright(bold(r))_i + macron(a)^(upright("Tem")) mat(delim: "[", cos (frac(( n - 1 ) pi, 3) + phi.alt^(upright("Tem"))); sin (frac(( n - 1 ) pi, 3) + phi.alt^(upright("Tem")))) . $<eq:Def_Tem>


Neighbor positions $upright(bold(r))_(j_n ( i ))$ in Eq.~(@eq:locDisp) are indexed in counter-clockwise order and such that the bond angle between embryos $upright(bold(r))_i$ and $upright(bold(r))_(j_1 ( i ))$ is the one closest to $phi.alt^(upright("Tem"))$. Finally, we perform a linear regression (using MATLAB's~`polyfitn` function) and fit the 6 local displacement vectors~by


$ bold("u")_(i , upright("fit")) ( j_n ) = bold("u")_0 + upright(bold(S)) ( upright(bold(r))_i )^top dot.op bold("r")_(j_n ( i ))^(upright("Tem")) , $<eq:Du>


to determine a vector $bold("u")_0$ that captures any residual translations, while the fitted matrix


$ upright(bold(S)) ( upright(bold(r))_i ) = mat(delim: "(", S_11, S_12; S_21, S_22) $<eq:Duf>


approximates the local displacement gradient tensor $S_(i j) approx partial_i u_j$ in the basis in which the components the of $bold("u")_(i , upright("fit")) ( j_n )$ and are provided. From this matrix, we can therefore extract strain components at position $upright(bold(r))_i$ in analogy to the definitions in Sec.~(@sec:SFcalc): $u_(upright("fit"))^0 = S_11 + S_22$ (compression/expansion), $u_(upright("fit"))^1 = S_21 - S_12$ (rotation), $u_(upright("fit"))^2 = S_11 - S_22$ and $u_(upright("fit"))^3 = S_12 + S_21$ (shear components).


=== Identification, tracking and characterization of edge dislocations
<sec:EdgeDisl>
The defects we are interested in for this analysis are edge dislocations. In a hexagonal lattice, they can be identified as a bound pair of 5- and 7-fold coordinated embryos (orange and purple dots in @fig:DefectStrainSI1). The coordination number of an embryo corresponds to the number of its edges in the Delaunay triangulation. To minimize the influence of other dislocations or from cluster boundaries, we restrict the strain analysis to defects that are isolated and located in the crystal bulk (dislocation $A$ in @fig:DefectStrainSI1). Other than the “ideal\" edge dislocation~$A$, a second fairly isolated defect ($B$ in @fig:DefectStrainSI1) was the result of an abnormally positioned embryo and therefore not considered for further analysis. Due to their close proximity to each other, edge dislocations $C$ and $D$ also had to be excluded from the analysis.


Focusing on the edge dislocation $A$, we track its center -- defined as the average position of the two constituent 5- and 7-coordinated embryos -- over 500 frames ($approx 80 thin$min) using MATLAB's `simpletracker` function~#link(<si-29>)[[29]]. For each frame, the dislocation can be characterized by a Burgers vector ~#link(<si-26>)[[26, 13]]


$ bold("b") := integral.cont_(cal(C)) upright(bold(S))^top dot.op upright(d) bold("r") , $<eq:Burgers>


where the contour $cal(C)$ represents a counter-clockwise loop enclosing the defect, and the fitted strain matrix~$upright(bold(S))$ given at embryo positions $upright(bold(r))_i$ was introduced in Sec.~@sec:SFD. In practice, we take~$cal(C)$ to be a circular contour of radius $approx 500 thin mu$m centered at the edge dislocation, interpolate $upright(bold(S)) ( upright(bold(r))_i )$ on 1000 equidistant points along $cal(C)$ using MATLAB's `scatteredInterpolant` function (method setting “natural\") and approximate the integral Eq.~(@eq:Burgers) numerically using a Riemann sum with midpoint rule.


// [figvision-cn] imgs/FigS12.png
// 这是一幅科学论文中的示意图，用于展示边缘位错周围的应变
// 分析。该图由主图和右上角的插图组成，没有使用字母a、b、
// c等子图编号，而是分为主图区域和插图区域。 主图区域展示
// 了一个由灰色细线构成的 Delaunay 三角网格，覆盖在一个大
// 致呈椭圆形的不规则斑块上。网格由大量近似等边的小三角形
// 组成。根据图例，灰色细线代表 Delaunay 三角剖分。 在网
// 格中，识别出四对由5配位和7配位构成的“胚胎对”（即边缘位
// 错），分别标记为 A、B、C 和 D。每对位错由一个紫色圆点
// （配位数为 5）和一个橙色圆点（配位数为 7）组成。它们的
// 具体位置如下：A 对位于图像中心偏上区域，紫色点在左，橙
// 色点在右，两者水平相邻；B 对位于 A 对左侧较远处，紫色
// 点在左，橙色点在右；C 对位于 A 对左下方，紫色点在左，
// 橙色点在右；D 对位于 A 对正下方略偏右，紫色点在左，橙
// 色点在右。图例标明紫色圆点代表配位数为 5，橙色圆点代表
// 配位数为 7。 围绕 A 对位错，图中标注了局部坐标系。原点
// 位于紫色圆点（配位数 5）处。x 轴指向右下方，与一条蓝色
// 箭头平行，图注明确标注“x (Parallel to Burgers vector b
// )”，即 x 轴平行于伯格斯矢量 b。y 轴指向右上方，与 x 轴
// 垂直。图中还画出了一条从紫色圆点出发、指向右侧的蓝色箭
// 头，并标注了角度 φ，表示该方向与 x 轴的夹角。 在 A 对
// 位错周围，有一片由黑色和灰色圆点组成的密集点阵区域。图
// 例说明这些是“Analyzed embryo positions”（分析的胚胎位
// 置），其中黑色圆点表示“data used for fitting”（用于拟
// 合的数据），灰色圆点表示其他被分析的位置。这些点呈六角
// 密排状分布，黑色圆点集中在中心区域，灰色圆点分布在黑色
// 圆点外围。 右上角的插图是一个放大示意图，展示了一个单
// 个的六边形“胚胎”结构，其中心为粉红色填充，边缘有虚线轮
// 廓。该六边形被置于一个局部坐标系中，x 轴水平向右，y 轴
// 垂直向上。图中标注了角度 α_s，表示六边形的一条边与 x
// 轴之间的夹角。六边形的左右两侧各有一个箭头指向中心，上
// 下两侧各有一个箭头指向中心，表示该结构受到的压缩或约束
// 方向。这个插图通过一条虚线连接到主图中 A 对位错右侧的
// 一个粉红色六边形上，该六边形位于橙色圆点（配位数 7）附
// 近。 图像右下角有一个黑色粗线段作为比例尺，但未标注具
// 体数值。整体图传达的趋势是：通过 Delaunay 三角剖分识别
// 出四对稳定的 5-7 配位边缘位错，并围绕其中一对（A）建立
// 了局部坐标系，用于分析其周围的应变场，同时插图详细说明
// 了单个胚胎结构的取向和受力方向。
#figure(image("imgs/FigS12.png", width: 70.0%),
  caption: [
    #strong[Strain analysis around edge dislocations.] From a Delaunay triangulation (grey lines) four edge dislocations -- 5,7-coordinated embryo pairs -- labeled $A$, $B$, $C$, and $D$ can be identified that move little and are present throughout most of the time window of the strain analysis. The Burgers vector $upright(bold(b))$ associated with a dislocation (see Sec.~@sec:EdgeDisl) defines the $x$-axis direction of a local coordinate system with azimuthal angle $phi.alt$. Shear elongation axis orientations $alpha_s$ of embryos colored in gray and black seen along~$phi.alt$ are shown in @fig:DefectStrainSI3. To minimize spurious effects from crystal boundaries and nearby dislocations, we focus the fitting in Secs.~@sec:axisElong and @sec:ObservedStrain on dislocation~$A$, specifically on the 21~embryos colored in black. Scale bar, 1 mm.
  ]
)
<fig:DefectStrainSI1>



=== Registration and averaging of strain measurements around edge dislocations
<sec:Collapse_strain>
Due to positional fluctuations of dislocations and embryos around it even in the rotation-corrected data and in the absence of whole-cluster oscillations, the amplitude $| upright(bold(b)) |$ and orientation~$phi.alt_(upright(bold(b)))$ of the Burgers vector $upright(bold(b)) = | upright(bold(b)) | ( cos phi.alt_(upright(bold(b))) , sin phi.alt_(upright(bold(b))) )^top$ defined in Eq.~(@eq:Burgers) changes between frames. However, to define meaningful averages of strain profiles around a dislocation they have to be measured in a common reference frame with respect to the dislocation. Specifically, we want to analyze and average strain fields in a frame in which the Burgers vector defines at all times the $x$-axis of a local coordinate system (see @fig:DefectStrainSI1). The correspondingly rotated strain matrix $upright(bold(S))'$ is given by , where we use the rotation matrix


$ upright(bold(R)) ( phi.alt_(upright(bold(b))) ) = mat(delim: "(", cos phi.alt_(bold("b")), - sin phi.alt_(bold("b")); sin phi.alt_(bold("b")), cos phi.alt_(bold("b"))) . $


This transformation leaves the fitted strain components related to compression and rotation defined below Eq.~(@eq:Duf) unchanged, $u_(upright("fit"))^(' thin 0) = u_(upright("fit"))^0$ and $u_(upright("fit"))^(' thin 1) = u_(upright("fit"))^1$, and rotates the strain component vector according to $( u_(upright("fit"))^(' thin 2) , u_(upright("fit"))^(' thin 3) )^top = upright(bold(R)) ( 2 phi.alt_(upright(bold(b))) ) dot.op ( u_(upright("fit"))^2 , u_(upright("fit"))^3 )^top$. Accordingly rotated embryo positions~$upright(bold(r))_i$ surrounding the edge dislocation fall nicely onto a common hexagonal lattice (black dots in Fig.~4a, main text), demonstrating that this registration and the following calculation of averages are meaningful. From here on, we work with the registered strain components $u_(upright("fit"))^(' thin alpha)$ ($alpha = 0 , 1 , 2 , 3$), but drop primes~$'$ and “$upright("fit")$\"-labels again to simplify the notation.


After these pre-processing steps, we arrive at a time series of well-defined strain components given at each 6-fold coordinated embryo positions close to the edge dislocation $A$ (black and gray dots in @fig:DefectStrainSI1). In the following, we will use these strain components to estimate effective elastic material properties of living chiral crystals.


=== Estimating effective material parameters from shear orientations
<sec:axisElong>
We first analyze the local axis of shear elongation near the dislocation. In particular, we are interested in the angle $alpha_s$ of local shear elongations, which is defined by$( u^2 , u^3 )^top = u_s ( cos 2 alpha_s , sin 2 alpha_s )^top$, where $u_s = sqrt([ u^2 ]^2 + [ u^3 ]^2)$ ($[ u^alpha ]^2$ with $alpha = 2 , 3$ denotes squared shear strain components) is the total shear strain amplitude. Note that the shear axis of elongation has nematic symmetry and therefore uniquely defined in the interval $alpha_s in [ 0 , pi )$. Rotations described in the previous section transformed measured strain components into a coordinate system in which the Burgers vector is parallel to the $x$-axis, i.e. $upright(bold(b)) = | upright(bold(b)) | upright(bold(e))_x$, and we use in the following the azimuthal angle $phi.alt in [ 0 , 2 pi )$ defined in this coordinate system (see @fig:DefectStrainSI1). We then plot the values of $alpha_s$ as determined from $u^2$ and $u^3$ for each embryo and for each frame as a function of this azimuthal angle $phi.alt$, where it is instructive to periodically extent the axis orientation data up to $alpha_s = 2 pi$ (@fig:DefectStrainSI2\; gray dots: individual measurements, black dots/error bars: circular means and standard deviation of strain orientations averaged over times).


// [figvision-cn] imgs/FigS13.png
// 这是一张散点图，横轴为 φ（单位：弧度），范围从 0 到 2π；
// 纵轴为 α_s（单位：弧度），范围从 0 到 2π。图中每个灰色
// 圆点代表一次剪切伸长轴取向的测量值，这些测量值沿着方位
// 角方向相对于位错的伯格斯矢量分布。黑色圆点和误差棒表示
// 在 42 个相邻晶格点位上汇总数据的均值和标准差。 图中用
// 红色虚线标出了“Passive Elastic”的理论参考线，其斜率为
// 1，贯穿整个坐标系。蓝色虚线将图划分为两个主要区域：左
// 下角标记为区域 I，右上角标记为区域 II。 整体趋势显示，
// α_s 随 φ 呈周期性变化，并大致围绕红色虚线波动。在区域
// I 中，数据点主要集中在红色虚线附近，但存在明显的离散；
// 在区域 II 中，数据的分布范围更广，均值偏离红色参考线的
// 程度更明显。黑色误差棒的幅度在不同相位区间有所差异，表
// 明在某些晶格点位上的测量一致性较高，而在其他点位上则波
// 动较大。
#figure(image("imgs/FigS13.png", width: 70.0%),
  caption: [
    #strong[Orientation of $bold(alpha_s)$ the shear elongation axis around a dislocation.] Each gray dot represents a “measurement\" of the shear elongation axis orientation $alpha_s$ (see Sec.~@sec:axisElong) in an azimuthal direction $phi.alt$ relative to the Burgers vector $upright(bold(b))$ of the dislocation (@fig:DefectStrainSI1). Black dots and errorbars denote means and standard deviation of data pooled at each of the 42 nearby lattice sites (depicted in gray and black in @fig:DefectStrainSI1). For reference, red dashed lines depict orientations $alpha_s$ expected in a passive isotropic elastic solid (Eq.~(@eq:alphaphi) with $delta alpha_s = 0$). To test the theoretically expected symmetry Eq.~(@eq:alphasim), we periodically extent the shear elongation axis orientation, which is uniquely defined in an interval~$[ 0 , pi )$. Equation~(@eq:alphasim) then predicts the data in box~II are a copy of those in box~I. The fact that this symmetry is not clearly present is most likely due to the presence of other nearby dislocations ($B - D$ in @fig:DefectStrainSI1) in the direction $pi < phi.alt < 2 pi$ of the local coordinate system associated with dislocation $A$. Fits are therefore restricted to data in the interval $0 lt.eq phi.alt lt.eq pi$ (data shown in Fig.~4b, main text).
  ]
)
<fig:DefectStrainSI2>



For the most general linearly elastic isotropic solid the profile of shear elongation axis orientations~$alpha_s$ surrounding a dislocation is predicted to be independent of the distance to the dislocation. The general profile is given by~#link(<si-13>)[[13]]


$ alpha_s ( phi.alt ) = phi.alt + pi slash 4 upright("sgn") ( cos phi.alt ) + delta alpha_s ( phi.alt ) , $<eq:alphaphi>


with


$ delta alpha_s ( phi.alt ) = 1 slash 2 arg {( 1 + nu + 2 i nu^o ) cos phi.alt + [ 2 gamma_1 + i ( gamma_2 - 1 ) ] sin phi.alt} - 1 slash 2 arg ( cos phi.alt ) . $<eq:dalphaphi>


This expression is a function of the (effective) material parameters





$ nu & = frac(( B - mu ) ( mu + Gamma ) + ( A - K^o ) ( K^o - Lambda ), ( B + mu ) ( mu + Gamma ) + ( A + K^o ) ( K^o - Lambda ))\
nu^o & = frac(B K^o - A mu, ( B + mu ) ( mu + Gamma ) + ( A + K^o ) ( K^o - Lambda ))\
gamma_1 & = frac(K^o Gamma + Lambda mu, ( B + mu ) ( mu + Gamma ) + ( A + K^o ) ( K^o - Lambda ))\
gamma_2 & = frac(( B + mu ) ( mu - Gamma ) + ( A + K^o ) ( K^o + Lambda ), ( B + mu ) ( mu + Gamma ) + ( A + K^o ) ( K^o - Lambda )) , $<eq:strain_param>


which are related to the 6 independent elastic moduli $B , thin mu , thin A , thin K^o , thin Gamma , thin Lambda$ introduced in Sec.~@sec:OddModuli. Hence, the profile of elongation axis orientations can encode information about material properties. For standard passive elastic solids ($B , mu > 0$, and $thin A , thin K^o , thin Gamma , thin Lambda = 0$) one finds $delta alpha_s = 0$\; in this case $alpha_s ( phi.alt )$ is independent of material parameters (red dashed lines in @fig:DefectStrainSI2 and in Fig.~4b, main text). More generally, the symmetry of an edge dislocation implies for any value of the 6 elastic moduli that


$ alpha_s ( phi.alt + pi ) = alpha_s ( phi.alt ) + pi slash 2 . $<eq:alphasim>


Graphically, we therefore expect from the theory Eq.~(@eq:alphaphi) that the values in the blue box~II in @fig:DefectStrainSI2 are merely a copy of those in box~I. The fact that this symmetry is not clearly present in the data and standard deviations in box~II are larger than in box~I is most likely due to the presence of other nearby dislocations ($B - D$ in @fig:DefectStrainSI1) that face the dislocation~$A$ approximately in the direction~$pi < phi.alt < 2 pi$ of the local coordinate system. We thus restrict the fitting in this and in the following Sec.~@sec:ObservedStrain to data from the interval $0 lt.eq phi.alt lt.eq pi$ (see also Fig.~4b of the main text) that contains the azimuthal position $phi.alt$ and shear axis orientations $alpha_s$ from 21 lattice sites surrounding the defect (black dots in @fig:DefectStrainSI1).


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.header([Fit Parameter], [Fit value], [Standard Error],),
    table.hline(),
    [$p_1 := 2 nu^o slash ( 1 + nu )$], [0.048], [0.098],
    [$p_2 := 2 gamma_1 slash ( 1 + nu )$], [0.11], [0.094],
    [$p_3 := ( gamma_2 - 1 ) slash ( 1 + nu )$], [-0.16], [0.085],
  )]
  , caption: [Table 3: Best fit parameters of the shear elongation axis orientation $alpha ( phi.alt )$ (see Sec.~@sec:axisElong) around a dislocation (@fig:DefectStrainSI1 and @fig:DefectStrainSI2). The resulting fit $alpha_(upright("fit")) ( phi.alt ) = phi.alt + pi slash 4 upright("sgn") ( cos phi.alt ) + delta alpha_(upright("fit")) ( phi.alt )$ with $delta alpha_(upright("fit")) ( phi.alt )$ given in Eq.~(@eq:alphafit) is shown as a solid red curve in main text Fig.~4b.]
  , numbering: none, kind: table
  )
<Tab:alphafit>



Finally, we fit the theoretical prediction Eq.~(@eq:alphaphi) to the measured shear elongation orientations. To this end, define in accordance with Eqs.~(@eq:alphaphi)--(@eq:dalphaphi) a fit function $alpha_(upright("fit")) ( phi.alt ) = phi.alt + pi slash 4 upright("sgn") ( cos phi.alt ) + delta alpha_(upright("fit")) ( phi.alt )$ with


$ delta alpha_(upright("fit")) ( phi.alt ) = 1 slash 2 arg [( 1 + i p_1 ) cos phi.alt + ( p_2 + i p_3 ) sin phi.alt] - 1 slash 2 arg ( cos phi.alt ) . $<eq:alphafit>


Weighted estimates and standard errors of the three dimensionless fitting parameters$p_1 = 2 nu^o slash ( 1 + nu )$, $p_2 = 2 gamma_1 slash ( 1 + nu )$ and $p_3 = ( gamma_2 - 1 ) slash ( 1 + nu )$ (assuming $nu > - 1$) are determined using MATLAB's~`nlmfit` function~(Tab.~3). The curve $alpha_(upright("fit")) ( phi.alt )$ corresponding to the best fit is shown as a red solid line in Fig.~4b of the main text.


In a standard passive linearly elastic solid with $B , mu > 0$ and all other moduli zero, one expects $p_1 = p_2 = p_3 = 0$, which seems -- despite a fairly large standard error -- not sufficient to fit strain elongation axis orientation (main text Fig.~4b, Tab.~3). The fact that $p_3$ is notably different from zero suggests that stress-strain couplings mediated through interactions with the surrounding fluid ($Gamma , Lambda$, see Eq.~(@eq:strain_param)) are contributing to the effective mechanical response of the crystal. In addition, we note that for a coarse-grained hexagonal network with ideal linearly elastic odd interactions one finds $p_1 tilde nu^o = 0$~#link(<si-12>)[[12]]. It is therefore not possible to directly infer unambiguous information about odd bulk and shear moduli $A$ and $K^o$, respectively, from fits to the shear elongation axis alone. A complementary fitting approach that overcomes this limitation is described in the following section.


=== Estimating elastic moduli from shear strain fields
<sec:ObservedStrain>
The fits from the previous section are consistent with the presence of odd moduli in the elastic response of a living chiral crystal, but do not provide unambiguous information about the relative magnitude and signs of such moduli. To determine the latter, we now explicitly fit theoretical predictions of the spatial dependence of strain components to measurements. Importantly, these fits specify magnitude and signs of odd moduli, which in turn can be compared against predictions based on embryo-embryo interactions within the crystal (see~Sec.~@Sec:CGmodel).


Using the coordinate system in which $bold("b") = | upright(bold(b)) | upright(bold(e))_x$ and centering the dislocation at the coordinate origin as before, the spatial dependence of strain components in a general isotropic linearly elastic solid is given by~#link(<si-13>)[[13]]


$ u^alpha = frac(| upright(bold(b)) |, 2 pi r^2) tilde(u)^alpha $<eq:uapred>


with


$ tilde(u)^0 ( x , y ) & = - 2 gamma_1 x - ( 1 - nu ) y\
tilde(u)^1 ( x , y ) & = ( 1 + gamma_2 ) x - 2 nu^o y\
tilde(u)^2 ( x , y ) & = - ( 2 nu^o x + ( gamma_2 - 1 ) y ) frac(x^2 - y^2, x^2 + y^2) - ( ( 1 + nu ) x + 2 gamma_1 y ) frac(2 x y, x^2 + y^2)\
tilde(u)^3 ( x , y ) & = - ( 2 nu^o x + ( gamma_2 - 1 ) y ) frac(2 x y, x^2 + y^2) - ( ( 1 + nu ) x + 2 gamma_1 y ) frac(y^2 - x^2, x^2 + y^2) . $<eq:Strain_theory>


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.header([Fit Parameter], [Fit value], [Standard Error],),
    table.hline(),
    [$nu$], [0.049], [0.0097],
    [$nu^o$], [0.053], [0.0039],
    [$gamma_1$], [0.010], [0.0046],
    [$gamma_2$], [0.74], [0.0088],
  )]
  , caption: [Table 4: Mean and standard errors for fits of the shear strain components $u^2$ and $u^3$ using theoretical predictions~#link(<si-13>)[[13]] Eq.~(@eq:uapred) with $tilde(u)^2$ and $tilde(u)^3$ given in Eqs.~(@eq:Strain_theory)~and~(@eq:Strain_theory). The corresponding spatial shear strain profiles together with experimental measurements are depicted in #ref(<fig:DefectStrainSI3>)a. Predictions for divergent and rotary strain components using these fitting parameters in Eq.~(@eq:uapred) with $tilde(u)^0$ and $tilde(u)^1$ are shown in #ref(<fig:DefectStrainSI3>)b (same data as shown in main text Fig.~4c). ]
  , numbering: none, kind: table
  )
<Tab:strainfit1>



The goal is then to determine $nu , thin nu^o , thin gamma_1$ and $gamma_2$ by fitting measured spatial profiles of strain around the dislocation. To make this analysis comparable to the fitting of shear orientations described the previous section, we determine $nu , thin nu^o , thin gamma_1$ and $gamma_2$ by fitting spatial profiles of the shear strain components $u^2$ and $u^3$ (Eq.~(@eq:uapred) with $tilde(u)^2$ and $tilde(u)^3$). As before, we restrict the fitting to a specific subset of embryo positions around the dislocation (black dots in @fig:DefectStrainSI1) to mitigate spurious effects from other nearby dislocations and from domain boundaries (see Sec.~@sec:EdgeDisl for details). The shear component fits are implemented using MATLAB's `lsqcurvefit` function. The mean and the standard error of each fit parameter, computed from the collection of single-frame fits, are depicted in Tab.~4. The strain components $u^2$ and $u^3$ corresponding to this best fit are plotted for comparison with measurements in #ref(<fig:DefectStrainSI3>)a.


// [figvision-cn] imgs/FigS14.png
// 整张图由三个子图a、b、c组成，展示位错附近空间应变分量
// 的实空间测量、拟合与连续场分布。所有离散数据图（a、b）
// 的坐标系均为x轴向右、y轴向上，原点处有一黑色实心圆点标
// 记位错核心，x、y轴无刻度数值，仅用等间距圆盘阵列表示晶
// 格近邻平均位置（约5行、列数3至6不等，构成以原点为下顶
// 点的倒三角点阵）。颜色映射由下方色标给出：红色为负值，
// 白色为零，蓝色为正值，色标两端标注数值，颜色从红到白到
// 蓝连续过渡。子图a和b的每个象限分为上下两行：上行为
// Measured（测量值），下行为Fitted或Predicted（拟合/预测
// 值）。 子图a左列为Shear 1（剪切分量1）。Measured图中，
// 圆盘颜色从左上角约-0.07的浅红逐渐过渡到中部与右侧的白
// 色、浅蓝，原点左侧第一行有两枚约-0.11的深红圆盘，原点
// 右侧紧邻x轴处有一枚约+0.09的中蓝圆盘。Fitted图中，圆盘
// 颜色分布基本一致：左上浅红、中部白色、右下浅蓝，原点左
// 侧一排有深红圆盘、右下一排有蓝色圆盘，但颜色整体略淡。
// 色标范围-0.12至+0.12。子图a右列为Shear 2（剪切分量2）。
// Measured图中，原点左侧两枚深红圆盘值约-0.15，原点右下
// 方一排为浅蓝到中蓝（约+0.10至+0.15），上方和左侧大部分
// 区域为白色到浅红。Fitted图中，原点左侧两枚红盘、上方浅
// 红、右下蓝色一排，分布与测量吻合。色标范围-0.17至+0.17。
// 右列Fitted图下方有一条水平黑色粗线作比例尺，图中未标注
// 具体长度。 子图b左列为Divergence（散度）。Measured图中，
// 原点上方紧邻两枚深红圆盘值约-0.11，原点左侧一排为浅红
// 到中红（约-0.07至-0.10），原点右下方和上方边缘为浅蓝到
// 白。Predicted图同样呈现原点上方深红、左侧浅红、右侧浅
// 蓝的分布。色标范围-0.13至+0.13。子图b右列为Curl（旋度）。
// Measured图中，原点左侧为浅红（约-0.05），原点右下方的
// 两排圆盘为深蓝（约+0.25至+0.30），原点上方为浅蓝到白。
// Predicted图中，原点左侧深红、右下方深蓝、上方浅蓝，与
// 测量一致。色标范围-0.34至+0.34。 子图c为四个圆盘状连续
// 场图，分别与a、b四列对应，展示Shear 1、Shear 2、
// Divergence、Curl的拟合或理论连续分布。每个圆盘中心为位
// 错核心，颜色代表应变分量数值，色标与上方对应列相同。
// Shear 1场图呈中心对称的四瓣结构：左上和右下为红色负值
// 区，右上和左下为蓝色正值区，瓣间为白色零值带。Shear 2
// 场图呈沿水平方向反对称的双瓣结构：左半为红色负值区、右
// 半为蓝色正值区，中心有细白零线。Divergence场图呈上下反
// 对称的双瓣结构：上半为红色负值区，峰值位于核心正上方；
// 下半为蓝色正值区，峰值位于核心正下方；水平方向过渡为白
// 色。Curl场图呈水平反对称双瓣结构：左侧为红色负值区，右
// 侧为蓝色正值区，中心有垂直白色零线，与Shear 2场图形态
// 相似但瓣形更宽。四个场图均无坐标轴刻度，仅通过颜色和色
// 标传达定量数值。整图未出现除坐标轴标签x、y、标题、行标
// 签、色标数值外的其他文字标注。
#figure(image("imgs/FigS14.png", width: 100.0%),
  caption: [
    #strong[Spatial strain component analysis near a dislocation.] #strong[a,]~Shear components measured (top, see Sec.~#ref(<sec:SFD>)--@sec:Collapse_strain) and fitted (bottom, see Sec.~@sec:ObservedStrain) using Eq.~(@eq:uapred) with $tilde(u)^2$ (Shear~1) and $tilde(u)^3$ (Shear~2). Each disk represents an average strain measurement or value of the fitting function centered at the average position of lattice sites near the dislocation (depicted black in @fig:DefectStrainSI1). The resulting fit parameters are given in Tab.~4. #strong[b,]~Comparison of measured divergent and rotary strain components (top) with predictions (bottom) from Eq.~(@eq:uapred) with $tilde(u)^0$ (Divergence) and $tilde(u)^1$ (Curl) using the fitting paramers determined in #strong[a] (same data as shown in main text Fig.~4c). Scale bar,~0.4 mm. #strong[c,]~Spatial profiles of strain components on a continuous domain as computed from Eq.~(@eq:uapred) with $tilde(u)^alpha$ given in Eqs.~(@eq:Strain_theory)--(@eq:Strain_theory) using parameters given in Tab.~4 found from fitting data in #strong[a] (top). Scales and color bars same as in panels #strong[a] and #strong[b].
  ]
)
<fig:DefectStrainSI3>



As a consistency check for this alternative fitting approach, we compute the parameters $p_1 thin , p_2$ and $p_3$ found from strain elongation orientation fits (see Sec.~@sec:axisElong) using the effective material parameters from Tab.~4, where we find $p_1 approx 0.1$, $p_2 approx 0.02$ and $p_3 approx - 0.25$. These values deviate, but are still within the error margins of the fit values listed Tab.~3.


The fit results in Tab.~4 lead to nontrivial predictions for divergent and rotary strain components surrounding a dislocation (Eq.~(@eq:uapred) with $tilde(u)^0$ and $tilde(u)^1$), which so far had not been included into our analysis. Importantly, these predictions can be compared against independent experimental measurements of the corresponding strain components in the crystal, where we find good quantitative agreement~(see main text Fig.~4c, reproduced for convenience in #ref(<fig:DefectStrainSI3>)b).


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.header([Modulus], [Estimate], [Standard Error],),
    table.hline(),
    [$A slash mu$], [7.7], [0.61],
    [$K^o slash mu$], [7.1], [0.59],
    [$Gamma slash mu$], [0.32], [0.082],
    [$Lambda slash mu$], [-1.0], [0.097],
  )]
  , caption: [Table 5: Relative values of elastic moduli determined from an inversion of Eqs.~@eq:strain_param for given fit parameters $nu , thin nu^o , thin gamma_1$ and $gamma_2$ from Tab.~4. The signs of the odd bulk and shear moduli $A > 0$ and $K^o > 0$ ($mu > 0$ required for stability) are consistent with predictions based on the handedness of transverse embryo interactions (see Sec.~@Sec:CGmodel) and indicate broken Maxwell-Betti reciprocity~#link(<si-13>)[[13]].]
  , numbering: none, kind: table
  )
<Tab:strainfit2>



Finally, we explicitly determine elastic moduli by inverting Eqs.~(@eq:strain_param) for given fit parameters $nu$, $nu^o$, $gamma_1$ and $gamma_2$ from Tab.~4. From dimensionless strain measurements, we can only expect to find relative values of elastic moduli, where we choose the passive shear modulus $mu$ to make all other moduli dimensionless. To make the inversion result of Eqs.~(@eq:strain_param) unique, we additionally impose $B = 2 mu$, which holds for a linearly elastic hexagonal spring network with nearest neighbor interactions~#link(<si-12>)[[12, 13]]. Using MATLAB's `solve` function, we can then determine from the values Tab.~4 and Eqs.~(@eq:strain_param) a unique solution for the parameters $A slash mu$ and $K^o slash mu$ (odd bulk and shear moduli), as well as for $Gamma slash mu$ and $Lambda slash mu$ (equilibrium and nonequilibrium moduli coupling rotations to torque and pressure). The final parameter values and standard errors of these moduli are given in Tab.~5.


According to the fit results Tab.~5, strain measurements around a dislocation suggest that odd bulk and shear moduli $A$ and $K^o$, respectively, contribute to the effective material properties of a living chiral crystal. Their relative values compared to the shear modulus $mu$ are larger than estimated from the coarse-graining of the microscopic model (see Sec.~@Sec:CGmodel, Eqs.~(@eq:OddModuliCG) and (@eq:PassModuliCG)). However, the latter was based on interactions among an isolated pair of embryos, which neglects interaction modulations that are most likely present within clusters. Importantly, the signs determined for $A$ and $K^o$ agree between the coarse-graining and the strain measurement approaches. Ultimately, these signs result from the handedness of the microscopic transverse interactions and therefore represent a macroscopic signature of the well-defined handedness of embryo rotations within the cystal. Furthermore, $A , K^o > 0$ (together with $Lambda < 0$) implies broken Maxwell-Betti reciprocity~#link(<si-13>)[[13]] and suggests that strain cycles observed during the emergence of chiral displacement waves (main text Fig.~4d--h, Sec.~@sec:Hand, #ref(<fig:Handedness>)a,b) do work on the surrounding (see Eq.~(@eq:work)), highlighting once again the nonequilibrium nature of living chiral crystals. In addition, we find the equilibrium ($Gamma$) and nonequlibrium ($Lambda$) moduli coupling rotations to stress (see Sec.~@sec:OddModuli) are nonzero, which is most likely due to interactions of the crystal with the surrounding fluid.


== Phase space analysis of strain cycles
<sec:StrCycAnal>
In this section, we describe the systematic statistical analysis of the living chiral crystal dynamics in strain space. In particular, we find closed cycles in strain space that provide information about contributions to entropy production~#link(<si-30>)[[30]] and, in the context of effective odd elastic properties, can be related to mechanical work that is done on the environment~#link(<si-12>)[[12]].


=== Phase space currents and partial entropy production
<sec:EntrProd>
The entropy production rate $dot(S)$ of an overdamped stochastic system that follows Langevin dynamics can be determined from~#link(<si-30>)[[30]]


$ dot(S) = k_(upright("B")) integral d bold("x") thin frac(upright(bold(j)) ( bold("x") ) dot.op upright(bold(D))^(- 1) ( bold("x") ) dot.op upright(bold(j)) ( bold("x") ), rho ( bold("x") )) , $<eq:entropyproduction>


where $rho ( bold("x") )$ and $upright(bold(j)) ( bold("x") )$ denote the probability density and corresponding probability current of a particular system configuration $bold("x")$, respectively. $upright(bold(D)) ( bold("x") )$ is an effective diffusion matrix with inverse~$upright(bold(D))^(- 1) ( bold("x") )$. In the following, we describe how $rho ( bold("x") )$, $upright(bold(j)) ( bold("x") )$ and $upright(bold(D)) ( bold("x") )$ can be approximated from experimental data of the strain component dynamics to estimate the system's partial entropy production rate shown in main text Fig.~4f,h.


For the spatially resolved analysis shown in #ref(<fig:Entropy>)b,d, we tiled the cluster domain into square regions of $200 thin mu$m (approximately one embryo diameter). The center of each tile is located at some position~$hat(upright(bold(r)))$. In each of these squares, we spatially average the strain components $u^alpha ( upright(bold(r)) , t )$ ($alpha = 0 , 1 , 2 , 3$, see Sec.~@sec:SFcalc) to determine local strain component values $hat(u)^alpha ( hat(upright(bold(r))) , t )$. We then introduce a strain component pair vector $hat(bold(u)) ( hat(upright(bold(r))) , t ) = [ hat(u)^alpha ( hat(upright(bold(r))) , t ) , hat(u)^beta ( hat(upright(bold(r))) , t ) ]^top$. Inspired by the curl-divergence and shear~1-shear 2 cycles that were suggested as signatures of odd elastic oscillations~#link(<si-12>)[[12]], we considered for our analysis the corresponding pairs $alpha = 1 , beta = 0$ (Fig.~4f in the main text) and $alpha = 2 , beta = 3$ (Fig.~4h in the main text).


To estimate partial entropy production rates, we used time series of strain component pairs $( hat(bold(u))_1 , hat(bold(u))_2 , . . . , hat(bold(u))_N )$, where $hat(bold(u))_k := hat(bold(u)) ( hat(upright(bold(r))) , k Delta t )$ with $k = 1 , 2 , . . . , N$ denotes pairs of strain components at $N = 200$ successive time points in $Delta t = 10$ s intervals. The continuous probability density~$rho ( bold("x") )$ and the associated current~$upright(bold(j)) ( bold("x") )$ were then estimated as#link(<si-31>)[[31]]:


$ hat(rho) ( bold("x") ) & = 1 slash N sum_(i = 1)^N K ( bold("x") , hat(bold(u))_i , Sigma ) ,\
hat(upright(bold(j))) ( bold("x") ) & = frac(hat(rho) ( bold("x") ), 2 Delta t) frac(sum_(i = 2)^(N - 1) K ( bold("x") , hat(bold(u))_i , Sigma ) ( hat(bold(u))_(i + 1) - hat(bold(u))_(i - 1) ), sum_(i = 2)^(N - 1) K ( bold("x") , hat(bold(u))_i , Sigma )) , $<eq:EPdefs>


where system configurations $bold("x") = ( u^alpha , u^beta )^top$ are defined in the space of a strain component pair. In Eqs.~(@eq:EPdefs), $K ( bold(x) , bold(mu) , Sigma ) = exp [ - ( bold(x) - bold(mu) )^top Sigma^(- 1) ( bold(x) - bold(mu) ) slash 2 ] slash [ 2 pi det ( Sigma ) ]^(- 1 slash 2)$ is the bivariate Gaussian with a bandwidth $Sigma$ determined using the so-called “rule of thumb\"~#link(<si-32>)[[32, 30]]. The latter aims to heuristically minimize the asymptotic mean squared error of the estimated fields $hat(rho) ( bold("x") )$ and $hat(upright(bold(j))) ( bold("x") )$ under the assumption of a standard normal distribution as reference distribution. In two dimensions, it suggests the bandwidth $Sigma$ is a diagonal $2 times 2$ matrix with components $Sigma_(alpha beta) = 1 slash 2 N^(- 1 slash 6) sigma_alpha delta_(alpha beta)$ (no summation), where $N$ denotes the total number of time points and $sigma_alpha$ is the standard deviation of the local strain component values $( hat(u)_1^alpha , hat(u)_2^alpha , dots.h , hat(u)_N^alpha )$ defined above.


// [figvision-cn] imgs/FigS15.png
// 图a由两幅二维空间热图和一维色标构成，展示局部部分熵产
// 生率在应变波出现前后的空间分布。两幅热图的形状为不规则
// 多叶状区域，外轮廓受像素化网格限制，形态与下方c图左、
// 右两幅热图一致。左图底部标注t1=-150 mins，对应应变波出
// 现前；右图底部标注t2=0 mins，对应应变波存在时。两图均
// 使用同一色标映射数值，色标位于整张图左下角，范围0至2，
// 单位×10^-4 k_B/s；颜色从深蓝（0，低值）经浅蓝、绿色、
// 黄色过渡至红色（2，高值）。左图以深蓝和浅蓝为主，局部
// 有少量淡黄斑点，整体处于低值区；右图整体颜色明显变浅，
// 出现大量黄色和淡绿色斑块，并在右上边缘和左下叶处出现红
// 橙色高值区。图中右下角有一处黑色小方框标记，用于强调高
// 值区域。两幅图下方分别有文字“t1 = -150 mins”和“t2 = 0
// mins”。 图a右侧为一幅黑底方形相图，横轴标注为Curl、范
// 围-0.02至0.02，纵轴标注为Divergence、范围-0.10至0.10。
// 图内叠加黄白色椭圆环带，环带中心附近有虚线箭头，构成逆
// 时针方向旋转的轮廓，环带区域内分布多个亮度不同的白色斑
// 块。图中心画有一个黑色矩形框，与左侧两幅热图右下角的小
// 方框相对应，暗示该区域在相空间中对应高值区。图中未标注
// 色标，亮度表示局部部分熵产生强度的相对大小。该相图说明
// 应变波出现时，curl-divergence空间中的熵产生在给定环带
// 内增强，形成旋转结构。 图b为一条曲线图，横轴为Time，单
// 位min，范围-200至200；纵轴标注为“Spatially integrated
// partial entropy production rate (k_B/s)”，范围0至1.5，
// 刻度为0、0.5、1.0、1.5。横轴上有两条竖直虚线，分别标注
// t1和t2，t1位于约-150 min处，t2位于约0 min处。曲线由空
// 心三角符号和细虚线连接构成，并带有竖直误差棒（表示标准
// 差）。曲线在-200 min处约为0.25，之后在t1附近出现小幅隆
// 起，约0.3；随后迅速上升，在t2处达到峰值约1.2；峰值后急
// 剧下降，在20至30 min内回到0.4左右，之后缓慢降至0.25附
// 近。该曲线表明空间积分的局部部分熵产生率在t2时刻出现显
// 著峰值，与t1前的低值区形成对比。 图c的布局与图a左侧相
// 同，也为两幅二维空间热图，分别对应t1=-150 mins（左）和
// t2=0 mins（右）。两幅图使用与图a相同的色标（0至2，×10^
// -4 k_B/s）。左图整体为蓝紫色，在右下叶中部有一处青绿色
// 斑块，大部分区域仍为低值；右图则出现大面积黄绿色斑块，
// 在右侧边缘和右下叶处有红橙色高值区，整体强度略高于图a
// 右图。图中右下角同样有黑色小方框标注。两幅热图之间下方
// 有文字“t1 = -150 mins”和“t2 = 0 mins”。 图c右侧相图横
// 轴标注为Shear 1，范围-0.010至0.010；纵轴标注为Shear 2，
// 范围-0.02至0.02。图内同样有黄白色椭圆环带和逆时针虚线
// 箭头，环带数量较多，呈嵌套状，中心处有较亮的白色斑块，
// 外围环带较暗。环带内有一条较粗的黑色水平线段，穿过中心
// 区域。该相图说明在shear 1-shear 2空间中，熵产生沿环带
// 分布，中心区域强度较高。 图d为曲线图，横轴Time，min，
// 范围-200至200；纵轴与图b一致，为“Spatially integrated
// partial entropy production rate (k_B/s)”，范围0至1.5。
// 横轴同样有t1（约-150 min）和t2（约0 min）两条竖直虚线。
// 曲线由空心三角符号和虚线连接，带误差棒。曲线从-200 min
// 处约0.2开始，在t1附近有小幅上升至约0.3；随后快速上升，
// 在t2处达到峰值约1.35，略高于图b的峰值；峰值后快速下降，
// 在20至30 min内降至0.4左右，之后逐渐回落至0.25附近。该
// 图表明在不同相变量（shear 1、shear 2）下，空间积分的熵
// 产生率同样在t2时刻显著峰值，且峰值强度稍高。 整张图通
// 过对比t1与t2时刻的空间分布和积分曲线，揭示应变波出现时
// 局部部分熵产生率在空间和相空间中均显著增强，并在t2时刻
// 达到峰值。
#figure(image("imgs/FigS15.png", width: 97.0%),
  caption: [
    #strong[Partial entropy production rate during cluster oscillations.] #strong[a,]~Spatial map the local partial entropy production rate in the curl-divergence space before the emergence of strain waves (left) and in the presence of strain waves (right). Details of the analysis are described in Sec.~@sec:EntrProd. #strong[b],~Spatially integrated entropy production rate in the curl-divergence space. Error bars indicate standard deviation over 100 bootstraps (see Sec.~@sec:EntrProd). The time point of maximum entropy production rate $t_2$ is defined as 0 min. #strong[c, d,]~Same analysis as #strong[a] and #strong[b] in the shear strain component space. Scale bar, 1 mm.
  ]
)
<fig:Entropy>



Examples of the probability densities and fluxes estimated at some position in the cluster using Eqs.~(@eq:EPdefs) are shown in the insets of Fig.~4f and h (main text). Similarly, the effective diffusion matrix is estimated as~#link(<si-31>)[[31]]


$ macron(upright(bold(D))) ( bold("x") ) = frac(hat(rho) ( bold(u) ), Delta t) frac(sum_(i = 1)^(N - 1) K ( bold("x") , hat(bold(u))_i , Sigma ) ( hat(bold(u))_(i + 1) - hat(bold(u))_i ) ⊗ ( hat(bold(u))_(i + 1) - hat(bold(u))_i ), sum_(i = 1)^(N - 1) K ( bold("x") , hat(bold(u))_i , Sigma )) , $<eq:difftens1>


where $⊗$ denotes a dyadic product. To ensure an inverse diffusion matrix required in Eq.~(@eq:entropyproduction) is well-defined, we finally use $macron(upright(bold(D))) ( bold("x") )$ given in Eq.~(@eq:difftens1) to define a constant, weighted mean diffusion matrix $hat(upright(bold(D)))$ as


$ hat(upright(bold(D))) = integral d bold("x") thin macron(upright(bold(D))) ( bold("x") ) hat(rho) ( bold("x") ) bb(1)_(hat(rho) ( bold("x") ) > c) . $<eq:diffusivetensor>


Here, $bb(1)_(hat(rho) ( bold("x") ) > c)$ is the indicator function defined analog to Eq.~(@eq:indicfunc) and $c$ is chosen such that only sufficiently well populated regions of the phase space with $hat(rho) d bold("x") > 0.01$ are included in the analysis. The estimates Eqs.~(@eq:EPdefs) and Eq.~(@eq:diffusivetensor) are then used in Eq.~(@eq:entropyproduction) to approximate a local partial entropy production rate . #ref(<fig:Entropy>)a and c each show two exemplary spatial maps of the partial entropy production rate before (left) and during (right) the presence of displacement~waves.


Finally, we consider the spatially integrated entropy production rate for the whole cluster


$ hat(dot(S))_(upright("tot")) = sum_(hat(upright(bold(r)))) hat(dot(S)) ( hat(upright(bold(r))) ) . $


In #ref(<fig:Entropy>)b,d shows that the integrated entropy production rate calculated in both strain component spaces peaks when the displacement waves are most prominent.


To quantify the robustness of the spatially integrated entropy production rate, we performed the same analysis on bootstrapped~#link(<si-33>)[[33, 34]] time series of the strain component pairs. In particular, we randomly sampled $N - 2$ elements from the time series of strain component pair vectors $( hat(bold(u))_2 , hat(bold(u))_3 , . . . , hat(bold(u))_(N - 1) )$. With each sampled vector $hat(bold(u))_k$, we additionally stored $hat(bold(u))_(k - 1)$ and $hat(bold(u))_(k + 1)$ to be able to compute the flux and diffusion matrix given in Eqs.~(@eq:EPdefs) and (@eq:diffusivetensor). Entropy production rates were finally determined from this bootstrapped configuration space information. Repeating this procedure 100 times yields a standard deviation that is depicted by error bars in #ref(<fig:Entropy>)b,d.


// [figvision-cn] imgs/FigS16.png
// 这是一张双纵轴折线图。横轴为时间，单位是小时，范围从20
// 到27，主刻度间隔为1小时，在整数小时之间有半个小时的次
// 刻度。左侧纵轴用蓝色标示，名称为“缺陷数量”，范围从2到6，
// 主刻度间隔为1。右侧纵轴用金色标示，名称为“部分熵产生率
// ”，单位是kB/s，范围从0到1.4，主刻度间隔为0.2。 图中有
// 三条数据序列。第一条是蓝色阶梯线，对应左侧纵轴，表示缺
// 陷总数随时间的变化。该曲线从约20.4小时处的2开始，在约
// 20.5小时跳升至3，维持到约21.2小时；随后在约21.2小时跳
// 升至4，紧接着在约21.4小时跳升至5，并在约21.55小时回落
// 到4；在约22.3小时跳升至5，维持到约23.1小时；在约23.1小
// 时跳升至6，维持到约23.9小时；随后在约23.9小时降至5，在
// 约24.05小时降至4，在约24.15小时降至3；最后在约25.5小时
// 升至3.3，维持到约27小时，此处曲线结束。 第二条是金色实
// 线，对应右侧纵轴，表示部分熵产生率。该曲线从约20.4小时
// 处的约0.25开始，在21.0至22.5小时之间在0.2至0.35之间波
// 动，谷值约0.2，峰值约0.35；从22.5小时起快速上升，在
// 23.9小时左右达到峰值约1.18；随后快速下降，在24.5小时降
// 至约0.4，在25.0小时降至约0.28；此后在0.2至0.3之间缓慢
// 波动，至27小时结束。 第三条是金色虚线，同样对应右侧纵
// 轴，表示部分熵产生率（可能是不同参数或局部测量）。其趋
// 势与金色实线相似，但在23.8至24.6小时之间的峰值更高，在
// 约24.0小时达到约1.38，且在整个时间段内多数位置略高于实
// 线，谷值约0.22，峰值约1.38。 三条曲线显示出一致的时间
// 趋势：部分熵产生率（金色实线和虚线）的上升和下降与缺陷
// 总数（蓝色阶梯线）的上升和下降在时间上高度对应。缺陷数
// 量在21至24小时之间阶梯式上升，熵产生率同期从低值升至峰
// 值；缺陷数量在24小时之后阶梯式下降，熵产生率同期从峰值
// 回落。图中未提供图例，也未标注比例尺或成像通道。
#figure(image("imgs/FigS16.png", width: 50.0%),
  caption: [
    #strong[Dynamics of total defect number and partial entropy production rate.] The increase and decrease of the spatially integrated partial entropy production rate (see Sec.~@sec:EntrProd for details of the analysis) is accompanied by a corresponding increase and decrease of the total number of defects.
  ]
)
<fig:DefectNEnt>



~ \
Combining the dynamic analysis of lattice defects (Sec.~@sec:EdgeDisl) with the quantification of partial entropy production (@fig:Entropy and Sec.~@sec:EntrProd), we can study the correlation of entropy production with the crystalline order of the cluster. Specifically, we plot the total number of defects over time together with the spatially integrated entropy production in @fig:DefectNEnt, which reveals a striking correlation between increasing (and decreasing) defect numbers with the increase (and decrease) in the entropy production rate. Qualitatively, we suspect that the presence of defects provides additional space for embryos to fluctuate around their mean positions within the crystal and thereby facilitates the emergence of substantial strain waves. Once the defects are expelled through embryo rearrangements from the finite crystal domain (@fig:Entropy), this extra space -- and consequently strain waves -- cease to exists.


=== Strain cycle handedness
<sec:Hand>
The handedness of the phase space currents in strain space computed in Sec.~@sec:EntrProd corresponds to the handedness of strain cycles observed during cluster oscillations. To quantify cycle handedness, we define a counter-clockwise reference unit current field as $upright(bold(j))_(upright("ref")) ( upright(bold(x)) ) = ( - sin phi.alt_(alpha beta) , cos phi.alt_(alpha beta) )$, where $phi.alt_(alpha beta) in [ 0 , 2 pi ]$ represents the azimuthal angle in the strain spaces spanned by $upright(bold(x)) = ( u^1 , u^0 )^top$ ($alpha = 1 , thin beta = 0$) and $upright(bold(x)) = ( u^2 , u^3 )^top$ ($alpha = 2 , thin beta = 3$, see insets in #ref(<fig:Handedness>)a,b). The strain cycle handedness is then at each point in the embryo cluster empirically defined as


$ H_(alpha beta) = frac(1, max ( | hat(upright(bold(j))) | )) integral hat(upright(bold(j))) dot.op upright(bold(j))_(upright("ref")) thin d upright(bold(x)) , $<eq:handedn>


such that $H_(alpha beta) = 1$ and $H_(alpha beta) = - 1$ indicate perfectly counter-clockwise and clockwise cycles, respectively. Strain cycles handedness maps, computed at the time of maximum partial entropy production of strain wave oscillations ($t_2$ in #ref(<fig:Entropy>)b,d), are shown in #ref(<fig:Handedness>)a and b. These maps reveal a predominant counter-clockwise cycle handedness ($H_(alpha beta) > 0$). Comparing the handedness distribution with the local partial entropy production rate map in @fig:Entropy, we found that handedness amplitudes $| H_(alpha beta) |$ are larger in regions with high partial entropy production rate. Finally, we analyzed the map of local correlation of the handedness in either of the two strain spaces. Specifically, #ref(<fig:Handedness>)c depicts the handedness product $H_10 H_23$, which is largely positive and therefore indicates a strong correlation between counter-clockwise oriented strain cycles in both strain component spaces $upright(bold(x)) = ( u^1 , u^0 )^top$ and $upright(bold(x)) = ( u^2 , u^3 )^top$.


// [figvision-cn] imgs/FigS17.png
// 图中共有三个子图，分别标记为 a、b 和 c。 子图 a：左侧
// 是一幅不规则形状（上宽下窄，右侧有一处缺口）的像素化手
// 性图，颜色从浅绿经黄到橙红分布，表示手性值，大部分区域
// 为黄橙色，左侧边缘和下部有浅绿色斑块。图右侧中部有一个
// 黑色小方框标记特定位置。该手性图右下方嵌入一个相图，坐
// 标轴分别为“Curl”（水平轴）和“Divergence”（垂直轴），轴
// 范围未标数值，原点位于中心。相图内布满细小的灰色箭头，
// 表示应变循环的方向，箭头整体呈现逆时针旋转趋势；另有一
// 个粗蓝色箭头指向右上方，表示主要循环方向。该子图无独立
// 色标，其手性值由右侧子图旁的色标指示。 子图 b：左侧是
// 与子图 a 形状和大小相同的像素化手性图，颜色分布类似，
// 以橙红色为主，左侧边缘和顶部有浅绿色区域，右侧中部同样
// 有黑色小方框。其右下方嵌入的相图坐标轴分别为“Shear 1”
// （水平轴）和“Shear 2”（垂直轴），轴范围未标数值。相图
// 内灰色箭头同样整体呈逆时针旋转，粗蓝色箭头指向左上方略
// 偏上。 子图 a 和 b 之间有一个竖直色标，标注为“
// Handedness”，刻度从 -0.4（深绿色）经 0（黄绿色）到 0.4
// （深红色），表明手性值的范围。 子图 c：是一幅与 a、b
// 形状相同的像素化相关图，颜色从深蓝经绿到浅粉白分布，大
// 部分区域为绿色，边缘和局部有深蓝色斑块，右侧中部有一处
// 深蓝色小区域（对应 a、b 中的方框位置）。右侧有竖直色标，
// 标注为“Correlation”，刻度从 -0.02（深蓝）经 0.04（绿色）
// 到 0.10（浅粉白）。图右下角有一条黑色水平线段作为比例
// 尺，无长度数值。
#figure([#block[
  #box(image("imgs/FigS17.png", width: 97.0%))
  ]],
  caption: [
    #strong[Handedness maps of strain cycles during cluster oscillations]. #strong[a]--#strong[b,]~Handedness maps of strain cycles computed via Eq.~(@eq:handedn) during cluster oscillations at the time of maximum partial entropy production (denoted $t_2$ in #ref(<fig:Entropy>)b,d). In both strain spaces $upright(bold(x)) = ( u^1 , u^0 )^top$ (curl--divergence, #strong[a]) and $upright(bold(x)) = ( u^2 , u^3 )^top$ (shear 1--shear~2,~#strong[b]), cycles are oriented mostly counter-clockwise. #strong[c,]~Correlation between the handedness maps in $bold("a")$ and $bold("b")$, confirming the visual impression that the cycle handedness in both strain spaces is strongly correlated. Scale bar, 1 mm.
  ]
)
<fig:Handedness>



= Table of symbols
<table-of-symbols>


#set text(size: 8.44pt)
#set table(inset: (x: 5pt, y: 2.28pt))
#figure(
  align(center)[#table(
    columns: (91.8pt, 1fr),
    align: (center,left,),
    table.hline(stroke: 0.8pt),
    table.vline(x: 0, stroke: 0.37pt), table.vline(x: 1, stroke: 0.37pt),
    table.vline(x: 2, stroke: 0.37pt),
    [$upright(bold(v))$], [Fluid velocity],
    [$eta$], [Viscosity],
    [$v_s$], [Sedimentation velocity of inactive embryos],
    [Re], [Reynolds number],
    [$upright(bold(r)) = ( x , y , z )^top$], [Position vector with magnitude $r = | upright(bold(r)) |$],
    [$a$, $b$, $c$, $d$], [Stokeslet, force-dipole, force-quadrupole, source-dipole singularity amplitude],
    [$upright(bold(p))$], [Embryo AP body-axis orientation],
    [$alpha$, $beta$, $gamma$], [Coefficients to describe flows near the surface of a microswimmer],
    [$A_n$, $B_n$, $C_n$, $D_n$], [Mode coefficients in solution of the Hele-Shaw equation],
    [$upright(bold(r))_i$], [Centroid position of a disk/particle $i$],
    [$t_d$], [Developmental time, $t_d = 0$: onset of cluster formation],
    [$h$], [Distance of flow singularities from the fluid-air interface],
    [$upright(bold(g))$/$theta_g$], [Gravity/Orientation of gravity relative to fluid surface normal],
    [$upright(bold(r))_(i j) = upright(bold(r))_i - upright(bold(r))_j$], [Relative coordinate between disk $i$ and $j$],
    [$hat(upright(bold(r)))_(i j)$, $hat(upright(bold(r)))_(i j)^perp$], [Normalized relative coordinate and orthogonal normalized relative coordinate],
    [$omega_0$], [Single embryo angular spinning frequency],
    [$R$], [Apparent top-view radius of surface-bound embryos (in the disk model)],
    [$omega_i$], [Angular spinning frequency of disk/particle $i$],
    [$upright(bold(F))_(upright("rep"))$, $f_(upright("rep"))$], [Effective repulsion force and effective repulsion force strength],
    [$F_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | )$], [Effective lubrication forces in the disk model],
    [$T_(upright("nf")) ( | upright(bold(r))_i - upright(bold(r))_j | )$], [Effective lubrication torques in the disk model],
    [$f_0$, $tau_0$], [Strength of lubrication forces and torques in the disk model],
    [$d_c$], [Cut-off length of lubrication interactions],
    [$d_(i j)$], [Shortest disk surface distance between disks $i$ and $j$],
    [$N_(c l)$], [Total number of embryos or disks bound in a cluster],
    [$upright(bold(e))_x , thin upright(bold(e))_y , thin upright(bold(e))_z$], [3D Cartesian basis],
    [$upright(bold(e))_r , thin upright(bold(e))_theta , thin upright(bold(e))_phi.alt$], [3D spherical coordinates basis, $x = r sin theta cos phi.alt , y = r sin theta sin phi.alt , z = r cos theta$],
    [$upright(bold(e))_rho , thin upright(bold(e))_phi$], [2D cylindrical coordinate basis, $macron(x) = rho cos phi , thin macron(y) = rho sin phi$.],
    [$l$], [Average nearest neighbor centroid distance in bound pairs and triplets],
    [$ell_(upright("maj"))$, $ell_(upright("min"))$], [Semi-major and semi-minor embryo body axis],
    [$e = ell_(upright("min")) slash ell_(upright("maj"))$], [Body axis ratio],
    [$chi = ( 1 - e^2 ) slash ( 1 + e^2 )$], [Microswimmer body shape anisotropy],
    [$L = ( ell_(upright("maj")) + ell_(upright("min")) ) slash 2$], [Characteristic embryo size, $L = 150 thin mu$m],
    [$F_(upright("st")) , F_g$], [Stokeslet force amplitude, Negatively buoyant weight force],
    [$upright(bold(r))_0$, $upright(bold(r))'_0$], [Position of flow singularity and of image flow singularity],
    [$upright(bold(E))$, $upright(bold(E))'$], [Symmetric strain rate tensor/Image above free fluid surface],
    [$upright(bold(F))$, $upright(bold(F))'$], [Stokeslet force and image Stokeslet force/Image above free fluid surface],
    [$upright(bold(T))$, $upright(bold(T))'$], [Rotlet torque and image rotlet torque/Image above free fluid surface],
    [$macron(upright(bold(v))) ( upright(bold(r))   upright(bold(p)) , upright(bold(r))_0 )$], [Singularity construction below free, nondeforming fluid surfaces],
    [$upright(bold(u))$, $u_(i j) = partial_i u_j$], [Displacement field and displacement gradient tensor],
    [$u^alpha$], [2D strain components: dilation ($alpha = 0$), rotation ($alpha = 1$), shear ($alpha = 2 , 3$)],
    [$sigma^alpha$], [2D stress components: pressure ($alpha = 0$), torque ($alpha = 1$), shear ($alpha = 2 , 3$)],
    [$B$, $mu$], [Bulk modulus, Shear modulus],
    [$A$, $K^o$], [Odd bulk modulus, Odd shear modulus],
    [$Lambda$, $Gamma$], [Elastic moduli coupling rotations to stresses],
    [$nu$, $nu^o$], [Poisson's ratio, Odd ratio],
    [$gamma_1$, $gamma_2$], [Effective material parameters of an isotropic elastic solid],
    [$hat(F)_(upright("nf"))$, $hat(T)_(upright("nf"))$], [Stokeslet and rotlet fitting parameters for flows surrounding bound pairs and triplets],

    [$macron(a)$], [Living chiral crystal lattice constant ($approx 220 thin mu$m)],
    [$psi_6 ( upright(bold(r))_i )$], [Local hexagonal bond orientation parameter of embryo $i$],
    [$g ( r )$], [Radial pair distance distribution function],
    [$gamma_L ( tau )$], [Dynamic Lindemann parameter as a function of lag time $tau$],
    [$upright(bold(b))$], [Burgers vector],
    [$phi.alt_(upright(bold(b)))$], [Azimuthal Burgers vector orientation in cluster frame],
    [$u_s$, $alpha_s$], [Magnitude and orientation of the shear elongation axis],
    [$upright(bold(x)) = ( u^alpha , u^beta )^top$], [Strain space coordinate],
    [$rho ( bold("x") )$, $upright(bold(j)) ( bold("x") )$, $upright(bold(D)) ( bold("x") )$], [Probability density, probability current and diffusion matrix in strain space],
    [$hat(rho) ( bold("x") )$, $hat(upright(bold(j))) ( bold("x") )$, $hat(upright(bold(D))) ( bold("x") )$], [Corresponding functions estimated from data],
    [$H_(alpha beta) med$], [Strain cycle handedness averaged in the strain space $upright(bold(x)) = ( u^alpha , u^beta )^top$],
    [], [Local and spatially integrated partial entropy production rate estimated from data],
    table.hline(stroke: 0.8pt),
  )]
  , kind: table
  )
#set text(size: 10.26pt)
#set table(inset: (x: 5pt, y: 5pt))






= Extended Data Figures
<extended-data-figures>








#counter(figure.where(kind: image)).update(0)
#set figure(numbering: "1", supplement: [Extended Data Figure])
// [figvision-cn] imgs/ExtDataFig1.png
// 这是一幅明场显微照片序列，由五个横向排列的子图组成，展
// 示同一胚胎从0小时到44小时的形态变化过程。这五个子图未
// 分别标记a、b、c等字母，而是以时间标注。图像为灰度明场
// 成像，背景浅灰，胚胎呈半透明，内部结构因折射率差异呈现
// 深灰至黑色的颗粒或轮廓。图中无颜色映射。最左侧0小时子
// 图左下角有一条比例尺，标注“100 μm”。 各子图顶部标注时
// 间，从左到右依次为：0h、12h、26h、38h、44h。 0h子图：
// 胚胎呈近圆形，外轮廓光滑，长径约110–120 μm（依比例尺估
// 算）。内部为细小均匀颗粒，右侧偏下有一处壳状凹陷或缺口。
// 除比例尺外无其他标注。 12h子图：胚胎开始拉长，轮廓由圆
// 形变为椭圆，长径约120–130 μm，短径约80–90 μm。外轮廓仍
// 较光滑，下端略尖。内部颗粒粗细不均，中下部可见颜色较深
// 的颗粒聚集区。无额外标注。 26h子图：胚胎明显 elongated
// （拉长），呈不规则长椭圆形，长径约130–150 μm，短径约80
// –90 μm。右侧内部出现一个纵向的、边界清晰的深灰色杆状或
// 带状结构（纵向截面），其周围颗粒减少，形成较空亮的区域。
// 外轮廓右端略平。无额外标注。 38h子图：胚胎进一步拉长，
// 长径约150–160 μm，短径约90–100 μm。内部的杆状或带状结
// 构横向延伸，位置靠近中央，呈深灰色，边缘清晰，内部可见
// 较浅的纹理或颗粒。其左侧有一团颜色较深的颗粒聚集区；右
// 侧外轮廓明显内凹或形成缺口。胚胎整体轮廓仍较平滑。无额
// 外标注。 44h子图：胚胎形态与38h相近但进一步延展，长径
// 约160–170 μm，短径约90–100 μm。内部的杆状或带状结构更
// 清晰，呈深灰色，横向贯穿中部，其内部可见较规则的浅色纹
// 理，两端略尖。胚胎左端较圆，右端仍存在凹陷或缺口。外轮
// 廓较平滑。无额外标注。 总体趋势：从0h到44h，胚胎从近圆
// 形逐步拉长，体积感增大，内部杆状或带状结构逐渐形成并清
// 晰化，位置由右下方移至中部横贯，提示胚胎在发育过程中发
// 生明显的形态重塑与内部结构分化。图中所有标注文字仅包括
// 各子图顶部的时间标签（0h、12h、26h、38h、44h）及比例尺
// 数值“100 μm”。
#figure(placement: none, image("imgs/ExtDataFig1.png", width: 100.0%),
  caption: [
    Uncropped embryo morphology images shown in Fig.~1b in the main text.
  ]
)

#pagebreak()
#v(9.2pt)
#text(size: 13.5pt, weight: "bold", font: "CMU Sans Serif")[References]
#v(10pt)
#block(inset: (left: 5.2pt))[
#grid(
  columns: (15.9pt, 1fr),
  row-gutter: 7pt,
  [\[1\]<si-1>], [Hirokazu Ishii, Takuma Shirai, Chisato Makino, and Takahito Nishikata. Mitochondrial inhibitor sodium azide inhibits the reorganization of mitochondria-rich cytoplasm and the establishment of the anteroposterior axis in ascidian embryo. _Dev. Growth Differ._, 56(2):175–188, 2014.],
  [\[2\]<si-2>], [Eric R. Dufresne, Todd M. Squires, Michael P. Brenner, and David G. Grier. Hydrodynamic coupling of two brownian spheres to a planar surface. _Phys. Rev. Lett._, 85:3317–3320, 2000.],
  [\[3\]<si-3>], [Todd M. Squires. Effective pseudo-potentials of hydrodynamic origin. _J. Fluid Mech._, 443:403–412, 2001.],
  [\[4\]<si-4>], [Knut Drescher, Kyriacos C. Leptos, Idan Tuval, Takuji Ishikawa, Timothy J. Pedley, and Raymond E. Goldstein. Dancing Volvox: Hydrodynamic bound states of swimming algae. _Phys. Rev. Lett._, 102:168101, 2009.],
  [\[5\]<si-5>], [Saverio E. Spagnolie and Eric Lauga. Hydrodynamics of self-propulsion near a boundary: predictions and accuracy of far-field approximations. _J. Fluid Mech._, 700:105–147, 2012.],
  [\[6\]<si-6>], [Eric Lauga. The Fluid Dynamics of Cell Motility.],
  [\[7\]<si-7>], [Sangtea Kim and Seppo J. Karrila. Microhydrodynamics: Principles and Selected Applications.],
  [\[8\]<si-8>], [Alexander Mietke, V. Jemseena, K. Vijay Kumar, Ivo F. Sbalzarini, and Frank Jülicher. Minimal model of cellular symmetry breaking. _Phys. Rev. Lett._, 123:188101, 2019.],
  [\[9\]<si-9>], [Alexander P. Petroff, Xiao-Lun Wu, and Albert Libchaber. Fast-moving bacteria self-organize into active two-dimensional crystals of rotating cells. _Phys. Rev. Lett._, 114:158102, 2015.],
  [\[10\]<si-10>], [Zaiyi Shen, Alois Würger, and Juho S. Lintuvuori. Hydrodynamic self-assembly of active colloids: chiral spinners and dynamic crystals. _Soft Matter_, 15:1508–1521, 2019.],
  [\[11\]<si-11>], [Wen Yan, Eduardo Corona, Dhairya Malhotra, Shravan Veerapaneni, and Michael Shelley. A scalable computational platform for particulate Stokes suspensions. _J. Comp. Phys._, 416:109524, 2020.],
  [\[12\]<si-12>], [Colin Scheibner, Anton Souslov, Debarghya Banerjee, Piotr Surówka, William T. M. Irvine, and Vincenzo Vitelli. Odd elasticity. _Nat. Phys._, 16(4):475–480, 2020.],
  [\[13\]<si-13>], [Lara Braverman, Colin Scheibner, Bryan VanSaders, and Vincenzo Vitelli. Topological defects in solids with odd elasticity. _Phys. Rev. Lett._, 127:268001, 2021.],
  [\[14\]<si-14>], [Étienne Fodor and Anton Souslov. Optimal power and efficiency of odd engines. _Phys. Rev. E_, 104:L062602, 2021.],
  [\[15\]<si-15>], [Harold W. Kuhn. The Hungarian method for the assignment problem. _Nav. Res. Logist._, 2(1):83–97, 1955.],
  [\[16\]<si-16>], [Daniel Blair and Eric Dufresne. Matlab Particle Tracking.],
  [\[17\]<si-17>], [Johannes Schindelin, Ignacio Arganda-Carreras, Erwin Frise, Verena Kaynig, Mark Longair, Tobias Pietzsch, Stephan Preibisch, Curtis Rueden, Stephan Saalfeld, Benjamin Schmid, and others. Fiji: an open-source platform for biological-image analysis. _Nat. Methods_, 9(7):676–682, 2012.],
  [\[18\]<si-18>], [Jean-Yves Tinevez, Nick Perry, Johannes Schindelin, Genevieve M. Hoopes, Gregory D. Reynolds, Emmanuel Laplantine, Sebastian Y. Bednarek, Spencer L. Shorte, and Kevin W. Eliceiri. TrackMate: An open and extensible platform for single-particle tracking. _Methods_, 115:80–90, 2017.],
  [\[19\]<si-19>], [Knut Drescher, Raymond E. Goldstein, Nicolas Michel, Marco Polin, and Idan Tuval. Direct measurement of the flow Field around swimming microorganisms. _Phys. Rev. Lett._, 105:168101, 2010.],
  [\[20\]<si-20>], [William Thielicke and Eize Stamhuis. PIVlab–towards user-friendly, affordable and accurate digital particle image velocimetry in MATLAB. _J. Open Res. Softw._, 2(1), 2014.],
  [\[21\]<si-21>], [William Thielicke and René Sonntag. Particle Image Velocimetry for MATLAB: Accuracy and enhanced algorithms in PIVlab. _J. Open Res. Softw._, 9(12), 2021.],
  [\[22\]<si-22>], [William Thielicke. The flapping flight of birds. _Diss. University of Groningen_, 2014.],
  [\[23\]<si-23>], [Hannah Jeckel, Eric Jelli, Raimo Hartmann, Praveen K. Singh, Rachel Mok, Jan Frederik Totz, Lucia Vidakovic, Bruno Eckhardt, Jörn Dunkel, and Knut Drescher. Learning the space-time phase diagram of bacterial swarm expansion. _Proc. Natl. Acad. Sci. U.S.A._, 116(5):1489–1494, 2019.],
  [\[24\]<si-24>], [Stuart Berg, Dominik Kutra, Thorben Kroeger, Christoph N. Straehle, Bernhard X. Kausler, Carsten Haubold, Martin Schiegg, Janez Ales, Thorsten Beier, Markus Rudy, Kemal Eren, Jaime I. Cervantes, Buote Xu, Fynn Beuttenmueller, Adrian Wolny, Chong Zhang, Ullrich Koethe, Fred A. Hamprecht, and Anna Kreshuk. ilastik: interactive machine learning for (bio)image analysis. _Nat. Methods_, 16(12):1226–1232, 2019.],
  [\[25\]<si-25>], [David R. Nelson and Bertrand I. Halperin. Dislocation-mediated melting in two dimensions. _Phys. Rev.~B_, 19(5):2457, 1979.],
  [\[26\]<si-26>], [Paul M. Chaikin and Tom C. Lubensky. Principles of Condensed Matter Physics.],
  [\[27\]<si-27>], [Klaus Zahn, Ralf Lenke, and Georg Maret. Two-stage melting of paramagnetic colloidal crystals in two dimensions. _Phys. Rev. Lett._, 82:2721–2724, 1999.],
  [\[28\]<si-28>], [Matteo Frigo and Steven G. Johnson. FFTW: an adaptive software architecture for the FFT. _Proceedings of the 1998 IEEE International Conference on Acoustics, Speech and Signal Processing_, 3:1381–1384, 1998.],
  [\[29\]<si-29>], [Jean-Yves Tinevez. simpletracker. #link("https://github.com/tinevez/simpletracker")[https://github.com/tinevez/simpletracker].],
  [\[30\]<si-30>], [Junang Li, Jordan M. Horowitz, Todd R. Gingrich, and Nikta Fakhri. Quantifying dissipation using fluctuating currents. _Nat. Comm._, 10(1):1–9, 2019.],
  [\[31\]<si-31>], [Wolfram Just, Holger Kantz, Mario Ragwitz, and Frank Schmüser. Nonequilibrium physics meets time series analysis: Measuring probability currents from data. _EPL_, 62(1):28, 2003.],
  [\[32\]<si-32>], [Adrian W. Bowman and Adelchi Azzalini. Applied smoothing techniques for data analysis: the kernel approach with S-Plus illustrations.],
  [\[33\]<si-33>], [Bradley Efron. Bootstrap methods: Another look at the jackknife. _Ann. Stat._, 7(1):1–26, 1979.],
  [\[34\]<si-34>], [Christopher Battle, Chase P. Broedersz, Nikta Fakhri, Veikko F. Geyer, Jonathon Howard, Christoph F. Schmidt, and Fred C. MacKintosh. Broken detailed balance at mesoscopic scales in active biological systems. _Science_, 352(6285):604–607, 2016.],
)
]
