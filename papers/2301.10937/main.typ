#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.53cm, right: 2.48cm, top: 2.62cm, bottom: 2.46cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.96em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.43em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#align(center)[
  #text(17pt, weight: "bold", [Super-Resolution Analysis via Machine Learning:
 A Survey for Fluid Flows])   #v(1.2em)
  #text(10.5pt)[Kai Fukami#super[[1, \*]], Koji Fukagata#super[[2]], Kunihiko Taira#super[[1]]\ 1. Department of Mechanical and Aerospace Engineering, University of California, Los Angeles, CA 90095, USA\ 2. Department of Mechanical Engineering, Keio University, Yokohama, 223-8522, Japan\ Corresponding author: kfukami1\@g.ucla.edu]
  
]

#v(1.2em)



// abshead
#align(center)[#text(12pt, weight: "bold")[ABSTRACT]]

This paper surveys machine-learning-based super-resolution reconstruction for vortical flows. Super resolution aims to find the high-resolution flow fields from low-resolution data and is generally an approach used in image reconstruction. In addition to surveying a variety of recent super-resolution applications, we provide case studies of super-resolution analysis for an example of two-dimensional decaying isotropic turbulence. We demonstrate that physics-inspired model designs enable successful reconstruction of vortical flows from spatially limited measurements. We also discuss the challenges and outlooks of machine-learning-based super-resolution analysis for fluid flow applications. The insights gained from this study can be leveraged for super-resolution analysis of numerical and experimental flow data.





#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.0pt)
  #set par(first-line-indent: 0em, leading: 0.95em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 0.95em, it) } else { it }
  }
  #outline(title: none, depth: 3)
]

= Introduction
<sec:intro>


Super resolution reconstructs a spatially high-resolution field data $bold(q)_"HR"$ from its low-resolution counterpart~$bold(q)_"LR"$~@irani1991improving @salvador2016example @bannore2009iterative. This problem set has been traditionally tackled in computer visions with various techniques including interpolation~@keys1981cubic @vandewalle2006frequency @joshi2008psf @lucas1981iterative, example-based internal learning~@michaeli2013nonparametric @glasner2009super @zontak2013separating @shahar2011space, high-frequency transfer~@freedman2011image @yang2013fast @baker2002limits @park2003super, neighbor embedding~@roweis2000nonlinear @bevilacqua2012low @chang2004super @freeman2002example @freeman2000learning, and sparse coding~@lee2006efficient @yang2008image @lu2012geometry @yang2010image @zhang2012single. Although these implementations are effortless, it is generally challenging to reconstruct high-wavenumber contexts. To address this difficulty, machine learning has been used for accurate super-resolution reconstruction of images~@dong2014learning @dong2016accelerating @yang2019deep. Machine learning can find a nonlinear relationship between input and output data even under ill-posed conditions. This approach can be applied to a pair of low- and high-resolution images, providing a finer level of images from extremely coarse images~@dong2015image.


Machine-learning-based techniques in general~@BNK2020 @BHT2020 @BEF2019 have been considered for a range of applications in fluid mechanics including turbulence modeling~@DIX2019 @MSJC2019 @LKT2016 @novati2021automating @bae2022scientific, reduced-order modeling~@LY2019 @callaham2022empirical @san2018neural @fukami2020sparse @SGASV2019, data reconstruction~@RPCA2020 @manohar2018data @FFT2020 @KKL2023, and flow control~@rabault2019artificial @bieker2020deep @zhou2020artificial @paris2021robust @park2020machine @ghraieb2021single. Super-resolution reconstruction with machine learning is no exception. The lower barrier to access open source codes in image science and implement models also enables fluid mechanicians to apply methods for fluid flow data by replacing RGB components (red, green, and blue) with velocity components~$( u , v , w )$.


While super resolution can be regarded as an image-based data recovery technique, it is also a general framework for a broad range of applications in fluid mechanics. For instance, a low-resolution fluid flow image can be interpreted as a set of sparse sensor measurements. In this aspect, the inverse problem of global field reconstruction from local measurements is an extension of super-resolution analysis~@fukami2021global @guemes2022super @sun2020physics. If we consider low-resolution fluid flow data as noisy experimental measurements, super-resolution analysis can also be extended to denoising problem~@gao2021super @fathi2020super @vlasenko2009superresolution. Furthermore, large-eddy simulation (LES) can incorporate super-resolution reconstruction to reveal finer structures inside a low-resolution grid cell~@pradhan2021variational @bode2021using.


This paper surveys the current status and the challenges of machine-learning-based super-resolution analysis for vortical flows. We first cover several machine-learning models and their applications to super resolution of fluid flows. We then offer case studies using a supervised learning-based super resolution for an example of two-dimensional decaying isotropic turbulence. We consider embedding physics into the model design to successfully reconstruct a high-resolution vortical flow from low-resolution data. We further discuss the challenges and outlooks of machine-learning-based super resolution in fluid flow applications. The present paper is organized as follows. We introduce machine-learning approaches of super-resolution reconstruction for vortical flows in @sec:methods. Applications of these machine-learning techniques are discussed in @sec:appl. We perform case studies in @sec:results. Extensions of super-resolution analysis for fluid dynamics are discussed in @sec:outlook. Concluding remarks with outlooks are provided in @sec:conc.


= Approaches
<sec:methods>


A variety of machine-learning models have been proposed for the super-resolution reconstruction of vortical flows, as summarized in @tab1.


Machine-learning-based approaches can find a nonlinear relationship between the low-resolution input and the corresponding high-resolution output from a large collection of data through training. In super-resolution analysis, the dimension of the input (low-resolution data) $bold(q)_"LR" in bb(R)^m$ is smaller than that of the high-resolution output $bold(q)_"HR" in bb(R)^n$ with $m lt.double n$, $ bold(q)_"HR" = F ( bold(q)_"LR" ) , $ where $F$ is the super-resolution model. Depending on the flow of interest and the size of data, the machine-learning model should be carefully chosen. In @sec:models, we introduce three types of machine-learning models that are widely used. We also discuss the use of physics-based loss functions in @sec:PILF.


#figure({
  set text(size: 8.5pt)
  set table(inset: (x: 3.5pt, y: 1.8pt))
  align(center, table(
    columns: 5,
    align: (center,center,center,center,center,),
    table.header([Authors (Year)], [Flow examples], [Approaches], [Algorithms], [Notes],),
    table.hline(),
    [Xie, Franz, Chu, Thuerey (2018)~@xie2018tempogan], [Smoke dynamics], [Supervised], [MLP/CNN (tempoGAN)], [Incorporates dynamics, expensive],
    [Fukami, Fukagata, Taira (2019)~@FFT2019a], [Laminar cylinder wake, isotropic turbulence, turbulent channel flow], [Supervised], [CNN (DSC/MS)], [Robust for multi-scale physics, stability of training],
    [Erichson, Mathelin, Yao, Brunton, Mahoney, Kutz (2020)~@erichson2020shallow], [Laminar cylinder wake, isotropic turbulence, sea surface temperature], [Supervised], [MLP], [Accuracy, simplicity, expensive],
    [Bode, Gauding, Kleinheinz, Pitsch (2019)~@bode2019deep], [Isotropic turbulence], [Unsupervised], [CNN (ESRGAN)], [Physics loss function, stability of training],
    [Obiols-Sales, Vishnu, Malaya, Chandramowlishwaran (2021)~@obiols2021surfnet], [NACA airfoil wake, cylinder wake], [Supervised], [CNN (SURFNet)], [Uncertainties over transfer, inexpensive],
    [Liu, Tang, Huang, Lu (2020)~@liu2020deep], [Isotropic turbulence, turbulent channel flow], [Supervised], [CNN (MTPC)], [Incorporates dynamics, high-wavenumber reconstruction],
    [Kim, Kim, Won, Lee (2021)~@kim2021unsupervised], [Isotropic turbulence, turbulent channel flow], [Unsupervised], [CNN (Cycle GAN)], [No required paired data, stability of training],
    [Gao, Sun, Wang (2021)~@gao2021super], [Laminar flow with spatially varying BCs, cardiovascular flow], [Semi-supervised], [CNN], [Less data, physics loss function, tuning of loss coefficients],
    [Zhou, McClure, Chen, Xiao (2022)~@zhou2022neural], [Porous flow], [Supervised], [CNN (U-Net)], [Robust against noise, need to compress data],
    [Güemes, Discetti, Ianiro, Sirmacek, Azizpour, Vinuesa (2021)~@guemes2021coarse], [Turbulent channel flow], [Unsupervised], [CNN (SRGAN)], [Small-scale reconstruction, training data size],
    [Pradhan, Duraisamy (2021)~@pradhan2021variational], [Turbulent channel flow], [Supervised], [MLP (VSRNN)], [Generalized for unseen initial condition, expensive],
    [Fukami, Maulik, Ramachandra, Fukagata, Taira (2021)~@fukami2021global], [Laminar cylinder wake, sea surface temperature, turbulent channel flow], [Supervised], [CNN (Voronoi model)], [Generalized for moving sensors, training data size],
    [Yousif, Yu, Lim (2021)~@yousif2021high], [Turbulent channel flow], [Unsupervised], [CNN (MS-ESRGAN)], [Robust for multi-scale physics, expensive],
    [Bode, Gauding, Lian, Denker, Davidovic, Kleinheinz, Jitsev, Pitsch (2021)~@bode2021using], [Isotropic turbulence], [Unsupervised], [CNN (PIESRGAN)], [Physics loss function, tuning of loss coefficients],
    [Nair, Goza (2020)~@NG2020], [Laminar flat plate wake], [Supervised], [MLP], [Inexpensive, requires POD],
  ))
},
  caption: [Representative studies on machine-learning-based super-resolution reconstruction methods for fluid flows.],
  kind: table,
) <tab1>


== Machine-learning models
<sec:models>


=== Fully-connected network (multi-layer perceptron)
<fully-connected-network-multi-layer-perceptron>


// [figvision-cn] imgs/fig1.png
// 该图由三个水平排列的部分组成，从左至右展示了一个基于全
// 连接模型的超分辨率重建流程。 左侧部分为输入数据示意图，
// 标注为“q_LR”。这是一个10行10列的方形网格区域，背景为浅
// 灰色。网格上均匀分布着100个紫色实心小圆点，代表低分辨
// 率采样位置。在这些采样点之间和周围，填充有颜色渐变的热
// 力图，颜色从深紫色（代表负值或低值）过渡到白色（零值），
// 再到橙色和棕色（代表正值或高值）。热力图的色块呈像素化
// 分布，每个色块大致对应一个采样点的邻域，整体呈现出模糊、
// 不连续的低分辨率特征场分布。 中间部分为神经网络结构示
// 意图，表示从左侧输入到右侧输出的映射过程。该结构包含三
// 层节点：最左侧一层为淡紫色垂直矩形框内的6个橙色圆形节
// 点，代表输入层；中间层省略号暗示存在多个隐藏层，未具体
// 绘制；最右侧一层为橙黄色垂直矩形框内的约20个橙色圆形节
// 点，代表输出层。所有相邻层之间的节点均通过黑色细线完全
// 连接，形成全连接拓扑结构。左侧输入层与中间层之间用虚线
// 箭头连接，中间层与右侧输出层之间也用虚线箭头连接，右侧
// 输出层再通过一条实线弯曲箭头指向最右侧的输出图像。 右
// 侧部分为输出结果示意图，标注为“q_HR”。这是一个正方形区
// 域，内部显示经过超分辨率重建后的高分辨率连续场分布。图
// 中呈现平滑流动的涡旋状图案，颜色同样采用从深紫色（负值
// 区）经白色（中性区）到橙棕色（正值区）的连续色谱。相比
// 左侧输入，此图无网格结构，细节丰富，边缘柔和，表现出更
// 高空间分辨率的物理场形态，如流体中的速度势或压力场分布。
// 整个流程表明模型将离散、低分辨的采样数据 q_LR 映射为连
// 续、高分辨的重建场 q_HR。
#figure(placement: top, image("imgs/fig1.png", width: 75.0%),
  caption: [
    Fully-connected model-based super resolution.
  ]
)
<fig_MLP>


The fully-connected network, also called the multi-layer perceptron~@RHW1986, is the most basic neural network model. Nodes between layers are fully connected with each other, as illustrated in @fig_MLP. The minimum unit of a fully-connected network is called perceptron. For each perceptron, the linear combination of the inputs from layer $( l - 1 )$, $c_j^(( l - 1 ))$, is connected with weights~$bold(w)$ yielding the output at layer $( l )$, $c_i^(( l ))$, $ c_i^(( l )) = phi ( sum_j w_(i j)^(( l )) c_j^(( l - 1 )) + b_i^(( l )) ) , $ where $phi$ is the activation function and $b$ is the bias added at each layer. We can choose a nonlinear function for $phi$, enabling the network to capture the nonlinear relationship between the input and the output.


A fully-connected model can be used for supervised machine learning-based super resolution. A training process for supervised machine-learning models is cast as an optimization problem to determine the weights~$bold(w)$ inside the model $F$. The weights $bold(w)$ are optimized by minimizing the loss function~$cal(E)$ through backpropagation~@kingma2014. This optimization procedure is described as $ bold(w) = "argmin"_(bold(w)) med cal(E) ( bold(w) ) . $<eq2> Since super-resolution reconstruction aims to obtain a high-resolution image $bold(q)_"HR"$ from the corresponding low-resolution data $bold(q)_"LR"$, the loss function (error) can be formulated as $ cal(E) & = \| \| bold(q)_"HR" - F ( bold(q)_"LR" ) \| \|_P , med $<eq_super> where $P$ indicates the norm. While the $L_2$ norm is widely used, we can instead consider other norms such as $L_1$ norm and logarithmic norm depending on the data characteristics. The $L_1$ norm can be used for model construction that is not as sensitive for outliers in the data. The logarithmic norm is suitable for cases where underestimation should be avoided.


As mentioned above, the difference of data dimension between the input and the output in the super-resolution analysis is substantial. Hence, models generally comprise the decoder-type structure~@erichson2020shallow @williams2022data, meaning that the number of nodes gradually increases towards the output layer. This is especially the case for high-dimensional inverse problems such as super-resolution reconstruction of fluid flows. This leads to the number of nodes and their connections to drastically increase, leading to the prohibitively expensive computational cost and the failure of non-convex optimization known as the curse of dimensionality~@domingos2012few. Users should be mindful of computational time and memory requirements for fully-connected models.


=== Convolutional neural network
<convolutional-neural-network>


To address the issue of the computational burden associated with the fully-connected models, convolutional neural networks (CNNs)~@LBBH1998 have been widely utilized in super-resolution analysis of fluid flows. CNNs incorporate a function called filter sharing, enabling the processing of large vortical flow data without encountering the curse of dimensionality~@morimoto2021convolutional.


A CNN is generally comprised of the convolutional layer, pooling layer, and upsampling layer. The convolutional layer depicted in @fig_CNN captures the nonlinear relationship between input and output data by extracting spatial features of supplied data through filtering operations. This operation is expressed as $ q_(i j n)^(( l )) = phi (sum_(m = 1)^M sum_(p = 0)^(H - 1) sum_(q = 0)^(H - 1) h_(p q m n)^(( l )) q_(i + p - G , j + q - G , m)^(( l - 1 )) + b_n^(( l ))) , $<eq:CNN> where $G = floor.l H / 2 floor.r$, $H$ is the width and height of the filter, $M$ is the number of input channel, $n$ is the number of output channel, $b$ is the bias, and $phi$ is the activation function. As in the fully-connected models, a nonlinear function can be chosen for $phi$ to account for nonlinearlities in the machine-learning model.


// [figvision-cn] imgs/fig2.png
// 该图展示了一个基于卷积神经网络（CNN）的超分辨率处理流
// 程，由左至右分为三个主要部分：输入低分辨率图像、中间网
// 络结构示意、输出高分辨率图像。 左侧子图标记为 q_LR，是
// 一张二维空间分布的热力图或标量场快照。图像呈现明显的像
// 素化特征，网格单元较大且边界清晰，表明其空间分辨率较低。
// 颜色从深紫色（代表低值）渐变到橙色和浅黄色（代表高值），
// 形成若干局部极值区域，如中心偏左的一个明显橙棕色斑块。
// 图中用紫色虚线框出一个 2×2 像素的小区域，并通过两条发
// 散虚线连接至中间部分的对应位置，表示该局部区域被送入网
// 络进行处理。 中间部分为示意图，描绘了卷积神经网络的层
// 间映射关系。左侧是一叠四层灰色矩形方块，每块边缘为紫色
// 轮廓，象征网络的第一组卷积层；右侧是另一叠四层类似结构
// 的方块，但最上层方块右上角以黑色省略号表示后续还有更多
// 层。两组方块之间有一个双向箭头标注字母 M，可能表示下采
// 样与上采样操作或特征维度变换。在左侧第一层方块底部，有
// 一个橙色小正方形区域，旁边标注两个 H，分别指向水平和垂
// 直方向，暗示该区域尺寸为 H×H。此橙色区域通过虚线与左右
// 两侧图像中的对应区域相连，表明它是从输入图像中提取并经
// 过网络处理后映射到输出图像的局部感受野或重建单元。 右
// 侧子图标记为 q_HR，同样是二维空间分布的热力图，但图像
// 平滑连续，无可见像素网格，细节丰富，呈现出流线型纹理和
// 多个清晰的涡旋状结构（如中心偏右的深紫色圆环包围橙黄色
// 核心）。颜色映射方式与左侧一致，仍为紫-白-橙黄梯度。图
// 中同样用紫色实线框出一个与左侧对应位置的局部区域，尺寸
// 明显小于左侧像素块，反映分辨率提升后同一物理区域在图像
// 中占据更小像素数。整体趋势显示：原始低分辨率图像经 CNN
// 处理后，生成具有更高空间频率成分、更精细结构的高分辨率
// 图像，实现从离散块状到连续光滑场的重构。
#figure(placement: top, image("imgs/fig2.png", width: 70.0%),
  caption: [
    Convolutional neural network-based super resolution.
  ]
)
<fig_CNN>


In addition to the convolutional layer, a pooling layer also plays an important role in CNN-based analysis. The pooling layer downscales the data, reducing data dimension. For regression tasks, it is useful for reducing spatial sensitivity, producing a robust CNN model against noisy inputs~@NF2022. It is also possible to expand the data dimension through the upsampling layer. Upsampling copies the value onto an arbitrary region to expand the dimension. This function is especially useful to align the data dimension inside the network.


For super resolution in which the dimension of the output~$bb(R)^n$ is larger than that of the input~$bb(R)^m$, there are several ways to treat the difference of the dimensions between the input and the output. For example, the upsampling can be used inside a network to expand the dimension~@wurster2022deep. One can also implement a resize or interpolation function for the input data to align the size with that of the output~@dong2015image @FFT2019a @romano2016raisr. This can avoid the use of pooling or upsampling operations, reducing the complexity of the model.


=== Generative adversarial network
<sec:GAN>


// [figvision-cn] imgs/fig3.png
// 该图展示了一个基于生成对抗网络（GAN）的超分辨率重建流
// 程示意图，整体布局从左至右分为三个主要部分：输入图像、
// 生成器处理过程与输出图像、判别器评估环节。 左侧为输入
// 图像 q_LR，是一个低分辨率二维热力图，呈正方形，像素化
// 明显，网格结构清晰可见。颜色从深紫色（代表低值）经浅灰、
// 米白过渡到橙棕色（代表高值），分布呈现不规则斑块状，其
// 中中心偏左有一块较明显的橙棕色区域，右上角和左下角散布
// 若干深紫色小方块。图像上方标注“q_LR”，字体为黑色斜体。
// 中间部分由两个垂直排列的正方形图像组成，均带有灰色边框。
// 上方图像标记为“q_HR”，是真实高分辨率参考图像；下方图像
// 标记为“G(q_LR)”，是由生成器 G 从 q_LR 生成的超分辨率图
// 像。两者在视觉上高度相似：均为连续平滑的热力图，无像素
// 块感，颜色映射与 q_LR 一致（紫→灰→橙棕），但细节更丰富，
// 如中心橙棕色区域边缘柔和、周围有细丝状结构延伸，多个深
// 紫色斑点形状圆润且位置对应。两图之间通过一个紫色轮廓梯
// 形框连接，框内文字为“Generator (G)”，表示生成器将 q_LR
// 映射为 G(q_LR)。 右侧为一个橙色轮廓梯形框，内部标注“
// Discriminator (D)”，代表判别器模块。从 q_HR 和 G(q_LR)
// 分别引出两条深蓝色箭头指向该判别器，表明其同时接收真实
// 高分辨率图像和生成图像作为输入。判别器输出端分出两条深
// 蓝色箭头：上方箭头指向标签“D(q_HR)”，表示对真实图像的
// 判别结果；下方箭头指向标签“D(G(q_LR))”，表示对生成图像
// 的判别结果。所有箭头均为实心三角形箭头，线条粗细均匀。
// 整幅图无坐标轴、无比例尺、无数值刻度，属于纯示意性流程
// 图，旨在说明 GAN 架构中生成器与判别器的数据流向及功能
// 角色：生成器负责从低分辨率输入重构高分辨率图像，判别器
// 则负责区分真实高分辨率图像与生成图像，二者在训练过程中
// 相互博弈以提升生成质量。
#figure(placement: top, image("imgs/fig3.png", width: 80.0%),
  caption: [
    Generative adversarial network-based super resolution.
  ]
)
<fig_GAN>


In addition to supervised fully-connected networks and convolutional networks, unsupervised learning with generative adversarial network (GAN)~@goodfellow2020generative has also been proposed for super-resolution analysis of fluid flows~@xie2018tempogan @bode2019deep @kim2021unsupervised @guemes2021coarse @MTK2023. GAN is attractive for cases in which it is difficult to prepare paired input and output data. For example, the application of super resolution with LES can correspond to this scenario. A model trained with a pair of high-fidelity DNS and subsampled low-resolution data may not directly support super-resolution reconstruction for LES data.


Super resolution of PIV measurements with limited spatio-temporal resolution (without corresponding high-resolution solution images) also needs to be carefully considered.


GAN is composed of two networks, namely, a generator ($G$) and a discriminator ($D$). A generator produces a fake image which is similar to the solution from random noise $bold(n)$. In contrast, a discriminator judges the generated (fake) image as whether it is likely to be a realistic image by returning a probability between 0 (fake) and 1 (real). A generator usually possesses a decoder-type structure to expand the data dimension from noise to images, while a discriminator is composed of an encoder-type network towards reducing the data size from images to the probability. Throughout the training process, the weights inside the generator are being updated to deceive the discriminator toward the direction of minimizing the probability by generating images increasingly similar to the real data. Fake images produced by the generator eventually become high-quality images that cannot be distinguished from the real image.


These processes can be mathematically expressed with regard to the cost function $V ( D , G )$, $ "min"_G "max"_D med V ( D , G ) = bb(E)_(bold(d) tilde p_"data" ( bold(d) )) \[ "log" D ( bold(d) ) \] + bb(E)_(bold(n) tilde p_(bold(n)) ( bold(n) )) \[ "log" ( 1 - D ( G ( bold(n) ) ) ) \] , med $<eq_GAN> where $bold(d)$ is a real data set and $p_"data"$ is the probability distribution of the real data. The parameters in the generator $G$ are trained towards the direction in which $D ( G ( bold(n) ) )$ becomes 1. On the other hand, the weights in the discriminator $D$ are updated so that $D ( bold(d) )$ returns a value close to 1. Since the discriminator becomes wiser through training, $D ( G ( bold(n) ) )$ provides a value close to 0. Summarizing, the parameter inside the generator $G$ is optimized by minimizing the loss function while that for the discriminator $D$ is adjusted by maximizing the loss function, referred to as competitive learning~@rumelhart1985feature. Once the training ends, the trained generator can produce an output with indistinguishable quality compared to the real data. For super-resolution problems, we can use low-resolution data as the input for the generator $G$ instead of random noise $bold(n)$, as illustrated in @fig_GAN. A generator in super-resolution reconstruction provides a statistically plausible high-resolution output by learning the relationship between the input low-resolution data set and the high-resolution data set, which need not be paired.


== Choice of loss function
<sec:PILF>


Here, let us discuss the choice of loss (cost) function for machine-learning-based super-resolution analysis. In standard formulation, we can have the cost function defined by equations~@eq_super and~@eq_GAN. However, super-resolved flow fields with direct applications of machine-learning models do not satisfy physical conditions, such as the conservation laws. To address such an issue, loss functions that embed physics laws can be utilized~@lagaris1998artificial @raissi2019physics. Together with the original data-based cost $cal(E)_d$ from equation~@eq_super or~@eq_GAN, the loss function $cal(E)$ incorporating a physics-inspired loss function $cal(E)_p$ for super-resolution analysis can take the form of $ cal(E) & = cal(E)_d + beta cal(E)_p , $ where $beta$ provides a scale between $cal(E)_d$ and $cal(E)_p$.


There are several approaches to introduce the physics-based loss term for fluid flows. For instance, we can directly substitute a reconstructed high-resolution field $bold(q)_"HR"$ into the governing equation~@raissi2019physics if we have all data for the state variables to have, $ cal(E)_p = \| \| cal(N) ( bold(x) , bold(q)_"HR" ( bold(x) , t ) ) \| \|_P , $ where $cal(N)$ is an operator from governing equations. Minimizing a loss function incorporating only certain terms of the Navier--Stokes equation~@LY2019 can also be considered, $  & cal(E)_p^j = \| \| cal(N)_j ( bold(q)_"Ref" ) - cal(N)_j ( bold(q)_"HR" ) \| \|_P , med med med cal(N) = sum_j cal(N)_j , $ where $cal(N)_j$ is a term in the governing equation and $bold(q)_"Ref"$ is a reference data. It is known that these physics-based loss functions help in reconstructing flows with a small amount of data~@gao2021super. What these terms in the loss function do is to better constrain the solution space~@karniadakis2021physics @cai2022physics. This is a similar concept to semisupervised learning which combines a small amount of labeled data with a large amount of unlabeled data~@zhu2009introduction. In the present paper, we demonstrate the effectiveness of training with small data set for super-resolution reconstruction of turbulent vortices in @sec:results. We should however note that the so-called physics-inspired analysis can suffer from large numerical error if $bold(q)_"HR"$ contains error or noise. This approach should be used with caution as it assumes that $bold(q)_"HR"$ can be used to evaluate certain terms.


= Applications
<sec:appl>


In this section, we survey recent super-resolution applications for fluid flows through supervised (@sec:slbt) and semisupervised-/unsupervised learning (@sec:sul).


== Supervised learning
<sec:slbt>


In machine-learning-based super-resolution reconstruction of fluid flows, supervised techniques are often used. Supervised learning requires a pair of input and output flow field data as training data. For super-resolution analysis, a high-resolution reference flow field and the corresponding low-resolution data need to be available for training models. To avoid the curse of dimensionality, CNN models are often used for image-based super resolution of fluid flows rather than fully-connected models.


Fukami et al.~@FFT2019a @FFT2019tsfp @FFT2021b proposed a CNN-based super-resolution reconstruction for fluid flows in a supervised manner. The CNN-based model was applied to examples of a two-dimensional cylinder wake, two-dimensional isotropic turbulence, and three-dimensional turbulent channel flow. To capture multi-scale physics in turbulent vortical flows, they also proposed the hybrid downsampled skip-connection/multi-scale (DSC/MS) model based on the CNN. The model is composed of the up-/downsampling operations, the skip connection~@he2016deep, and CNNs with various sizes of filters. While up-/downsampling operations support robustness against rotation and translation of vortical structures, the skip connection provides stability of the learning process~@he2016deep. Moreover, the multi-scale CNN aims to capture a variety of length scales in turbulent flows. Especially for the examples of turbulence, it was shown that the DSC/MS model is effective in accurately preserving the energy spectrum.


Following this study, supervised CNN-based super-resolution analysis has been actively studied for a range of flows. Obiols-Sales et al.~@obiols2021surfnet proposed a CNN-based super-resolution model called SURFNet and tested its performance for wakes around various NACA-type airfoils, ellipses, and cylinders. SURFNet includes a transfer learning-based augmentation~@pan2009survey. The model is first trained using only low-resolution flow data, and then the pre-trained weights are transferred in training with high-resolution data sets. Transfer learning over multiple levels of spatial-resolution flow field can improve the accuracy of super-resolution reconstruction~@guastoni2021convolutional, which is also related to multi-fidelity learning~@LPBK2020.


U-Net-based model (illustrated in @fig_Unet) can also reduce the training cost for super-resolution reconstruction of turbulent flows since the size of fluid flow data is reduced through an autoencoder-type model structures~@pant2020deep.


// [figvision-cn] imgs/fig4.png
// 该图是一张U-Net架构的示意图，用于涡旋流的超分辨率重建。
// 整体布局从左至右展示了数据流向：左侧为输入图像，中间为
// 网络结构，右侧为输出图像。 在图的左下角设有图例，包含
// 两个符号：一个紫色倒梯形标注为“Downsampling”（下采样），
// 一个橙色正梯形标注为“Upsampling”（上采样）。 最左侧是
// 一个方形输入图像块，上方标注有数学符号 q_LR。该图像呈
// 现低分辨率特征，由明显的粗大像素网格组成，颜色以白色为
// 背景，分布着模糊的橙色和深紫色斑块，代表流场中的不同数
// 值区域。从该图像的右下部分引出一条虚线，指向网络第一层
// 的一个小方块，示意局部区域的映射关系。 中间主体部分是U
// 形的神经网络结构，由一系列堆叠的灰色正方形图层构成，这
// 些图层代表卷积层或特征图。网络分为左侧的下采样路径、底
// 部的瓶颈层和右侧的上采样路径。 左侧下采样路径：由三组
// 堆叠的灰色方块自上而下排列，每一组的尺寸逐层减小。每组
// 方块之间通过黑色向下箭头连接，箭头旁对应一个紫色的倒梯
// 形符号，表示下采样操作。 底部瓶颈层：位于U形底部，由两
// 组最小的堆叠灰色方块组成，连接左右两侧路径。 右侧上采
// 样路径：与左侧对称，由三组堆叠的灰色方块自下而上排列，
// 尺寸逐层增大。每组方块之间通过黑色向上箭头连接，箭头旁
// 对应一个橙色的正梯形符号，表示上采样操作。 图中包含两
// 条红色的弧形箭头，分别标注文字“Skip connection”（跳跃
// 连接）。第一条连接左侧最顶层的特征图与右侧最顶层的特征
// 图；第二条连接左侧第二层的特征图与右侧第二层的特征图。
// 这些箭头表示将下采样阶段的特征直接传递到对应的上采样阶
// 段进行融合。此外，在网络内部的各个层级之间，也有虚线连
// 接，表示特征图的逐层传递。 最右侧是一个方形输出图像块，
// 上方标注有数学符号 q_HR。该图像呈现高分辨率特征，纹理
// 细腻平滑，没有明显的像素网格。图像内容显示复杂的流体涡
// 旋结构，具有清晰的深色核心和周围细腻的浅色及橙色渐变流
// 线，相比输入图像细节丰富得多。同样有一条虚线从网络最后
// 一层的小方块引出，指向该图像的对应位置。
#figure(placement: top, image("imgs/fig4.png", width: 85.0%),
  caption: [
    U-Net-based model for super-resolution reconstruction of vortical flows.
  ]
)
<fig_Unet>


Incorporating physical insights and domain knowledge into model construction further supports or enhances supervised-learning-based super-resolution reconstruction in vortical flows. For instance, accounting for spatial length scales of the flow structures in the models improves reconstruction~@FFT2019a. Kong et al.~@kong2020deep developed a multiple path super-resolution CNN with several connections inside the model to capture variations of spatial temperature distribution in a supersonic combustor. They reported that the proposed multiple-path CNN provides enhanced reconstruction of temperature fields compared to a regular CNN. Incorporating the time history of flow fields is also useful for super-resolving vortical flows in a supervised manner. Liu et al.~@liu2020deep compared two types of supervised CNN-based models for super-resolution analysis: namely the static CNN (SCNN) and the multiple temporal paths CNN (MTPC). While the SCNN model uses instantaneous flow snapshots as the input, the MTPC model considers a time series of velocity fields as the input to read spatial and temporal information simultaneously. With examples of forced isotropic turbulence and turbulent channel flow, they found that the MTPC model can improve the reconstruction of turbulence statistics such as kinetic energy spectra and the second and third invariants of the velocity gradient tensor.


Once supervised models are trained, machine-learning models can be used for data compression since we only need to save only the input data to recover high-resolution flow fields. Matsuo et al.~@matsuo2021supervised proposed an adaptive super-resolution analysis. They focused on how a low-resolution field is prepared in training a supervised learning-based model. While max- and averaging pooling operations are generally used for preparing low-resolution data sets, they considered the spatial standard deviation in arbitrary subdomains in a flow field to determine the local degree of downsampling. This can account for the importance of flow structures in generating low-resolution data sets. They reported that supervised CNN models can reconstruct a high-resolution field of three-dimensional square cylinder wake from adaptive low-resolution data, achieving approximately 0.05% data compression against the original data.


Compressing fluid flow data in the time direction can also be considered. Fukami et al.~@FFT2021b used the DSC/MS model to reconstruct high-resolution turbulent flows from coarse flow data in space and time inspired by a concept of super-resolution analysis and inbetweening~@LRT2019. In their formulation, two spatial coarse flow fields at $t = n Delta t$ and $t = ( n + k ) Delta t$ are taken as the input of the first machine-learning model. Once the spatial-reconstruction model provides two super-resolved high-resolution flow fields, these outputs are then fed into the second model to perform inbetweening that provides high-resolution snapshots between the beginning and the end frames. By combining these two models, spatio-temporal high-resolution vortical flows can be obtained from only two coarse snapshot data. It should be note that linear interpolation in time cannot capture advective physics. They demonstrated the model capability with turbulent channel flows and reported that the flow field can be quantitatively reconstructed, achieving 0.04% data compression. Arora and Shrivastava~@AS2022 have recently combined this super-resolution/inbetweening idea with physics-informed neural network~@raissi2019physics to improve the reconstruction accuracy and demonstrated it with an example of a mixed-variable elastodynamics system.


Furthermore, supervised super-resolution reconstruction can be used to examine how machine learning extracts the relationship between small and large-scale vortical structures. Kim and Lee~@KL2020 considered a CNN-based estimation of the high-resolution heat flux field in a turbulent channel flow from poorly-resolved wall-shear stresses and pressure. They revealed that the CNN model focuses on the relationship between vortical structures and pressure distribution in channel turbulence to estimate the local heat flux from the wall-shear stress. Morimoto et al.~@morimoto2022generalization has recently examined the effect of inter- and extrapolation with machine-learning-based super-resolution reconstruction with respect to flow parameters. They considered two-staggered cylinder wakes whose flow dynamics are characterized based on the diameters and the distance between two cylinders. They found that the supervised CNN-based model can quantitatively reconstruct a vortical flow even for untrained parameter cases by preparing flow field data based on the information of lift coefficient spectrum.


Supervised super-resolution techniques have also been applied to larger-scale meteorological flows~@onishi2019super @yasuda2022super. Onishi et al.~@onishi2019super proposed a CNN-based model for super-resolution analysis of temperature fields in urban environment. The proposed model provides a high-resolution temperature field at reduced computational time than the corresponding high-fidelity simulation, suggesting the potential use of machine-learning models as a surrogate for large-scale numerical simulations. To improve the model performance, Yasuda et al.~@yasuda2022super extended their model by incorporating skip connection~@he2016deep and channel attention~@hu2018squeeze. While skip connection~@he2016deep helps stabilize the learning process of deep CNNs, channel attention~@hu2018squeeze can discover the crucial and irrelevant spatial regions of fluid flow regressions. The model trained with temperature fields in one city (Tokyo) provides quantitative reconstruction for test temperature data for another city with similar climate (Osaka). They also observed that including building height information as a part of the input of the machine-learning model is important for successful temperature reconstruction.


In addition to the aforementioned studies with numerical data, applications to experiments have also been considered~@MLPIV2023. For such cases, the effects of noise in the input data must be carefully considered. Deng et al.~@DHLK2019 developed a machine-learning model to super-resolve PIV measurements. For training the model based on CNN, a pair of high-resolution experimental velocity data collected by PIV with cross-correlation method and downsampled low-resolution data is used. The model was tested for turbulent flows around a single cylinder and two cylinders. For more complex turbulent flows, Wang et al.~@wang2020predicting proposed a super-resolution neural network for two-dimensional PIV (PIV2DSR) based on CNNs. Once they trained the model with velocity fields of turbulent channel flow at $R e_tau = 1000$ obtained by direct numerical simulation (DNS), the model is assessed with not only numerical channel flow field data at a much higher Reynolds number of 5200 but also real experimental PIV data for a turbulent boundary layer at $R e_tau = 2200$.


// [figvision-cn] imgs/fig5.png
// 该图由上下两部分组成，展示了从浅层解码器中提取非线性模
// 式以重建二维不可压缩流动（涡量场）的过程。 上半部分为
// 流程图与示意图，描述网络结构与数据流向： 左侧为一个虚
// 线框包围的矩形区域，内含NACA0012翼型轮廓（蓝色填充），
// 其上分布四个红色实心圆点，代表传感器或采样位置；背景为
// 彩色云图，颜色从深蓝（负值）经白色过渡到橙黄（正值），
// 表示涡量场分布，翼型前缘上方有一明显橙色高涡量区，后缘
// 下方有深蓝色低涡量区。 中间为神经网络结构简图：左侧输
// 入层为4个红色节点（对应左图红点），连接至隐藏层（3个紫
// 色节点），再连接至输出层（多个橙色节点，垂直排列，中间
// 省略号表示数量较多）。其中隐藏层最下方节点为绿色，输出
// 层中对应位置也为绿色，其余为橙色。所有连接线为灰色细线，
// 呈全连接拓扑。 右侧为一个实线框矩形区域，显示重建后的
// 完整涡量场云图：翼型轮廓清晰，后方尾流呈现交替的橙蓝涡
// 街结构，颜色映射与左图一致，表明成功恢复全局流动特征。
// 三条黑色弯曲箭头指示数据流：从左图指向输入层，从隐藏层
// 指向右图（重建结果），以及从隐藏层向下指向底部子图组。
// 在隐藏层与底部子图之间标注文字：“Nonlinear modes (
// weights between latent variables and flow field)”，说
// 明底部图像是潜在变量与流场之间的权重所对应的非线性模态。
// 下半部分为三个并列的子图（a、b、c），每个均为带边框的
// 矩形云图，分别对应不同颜色的潜在变量（即隐藏层中的特定
// 神经元）所激活的非线性模态： 子图a（左）：边框为粉红色。
// 图中显示一个沿翼型弦向延伸的模态结构：翼型本身为蓝色，
// 其后紧随一个深蓝色椭圆区（负涡量），再后是一个较大橙色
// 圆形区（正涡量），整体呈前后对称的双极结构，反映第一阶
// 非线性模态的空间分布。 子图b（中）：边框为天蓝色。图中
// 翼型仍为蓝色，但其后出现两个分离的涡对结构：靠近翼型处
// 为一小团深蓝色与一小团橙色相邻，稍远处另有一组类似但更
// 大的涡对，整体呈非对称、多尺度涡旋分布，反映第二阶非线
// 性模态。 子图c（右）：边框为草绿色。图中翼型为蓝色，其
// 后方尾流区域呈现更复杂的涡系结构：包含至少三组交替的橙
// 蓝涡斑，且涡斑尺寸逐渐增大并向下游扩散，形态接近卡门涡
// 街的早期发展阶段，反映第三阶非线性模态。 所有子图均无
// 坐标轴、比例尺或数值标签，仅通过颜色深浅和空间布局表达
// 模态强度与分布；颜色映射统一：深蓝色代表负涡量，橙色代
// 表正涡量，白色为零值区域。 三个子图共同说明：浅层解码
// 器的不同潜在变量编码了不同空间尺度和拓扑结构的非线性流
// 动模态，这些模态叠加后可重构出完整的物理流场。
#figure(placement: top, image("imgs/fig5.png", width: 95.0%),
  caption: [
    Extraction of nonlinear modes~@MFF2019 from shallow decoder~@erichson2020shallow in super-resolution reconstruction for an example of two-dimensional incompressible flow (vorticity field) over a NACA0012 airfoil ($R e = 100$ and $alpha = 40$ deg).
  ]
)
<fig_nonmodes>


For the preparation of training data in these experimental studies, cross-correlation methods~@adrian2005twenty are generally used to obtain velocity fields from particle images. Instead of giving a velocity field from the correlation method, one may consider providing a particle image directly into a model to obtain a higher-resolution flow field. Cai et al.~@CZXG2019 used FlowNetS~@deconv2015 to estimate velocity fields of cylinder wake, backward-facing step flow, and isotropic turbulence from synthetic particle images. They exhibited that a machine-learning model provides higher-resolution flow field data than the conventional PIV. The proposed method was also tested with experimental particle images of a turbulent boundary layer. Reconstructed flows based on machine learning may capture phenomena that cannot be observed with conventional techniques. This FlowNetS-based method has recently been commercialized as AI-PIV~@majewski2020developing. The super-resolution approach with particle images has also been applied to a wake around bluff bodies to remove the influence of reflection and halation in PIV measurements~@morimoto2021experimental.


Alternatively, a set of sparse sensor measurements can be considered as input to machine-learning models instead of the low-resolution flow data. For instance, Erichson et al.~@erichson2020shallow used a fully-connected model to reconstruct a global flow field from local sensors. The model was applied to geophysical flow and forced isotropic turbulence. Their fully-connected model is a shallow decoder -- the model that incorporates a dimension compression to nonlinearly extract key features from sensors, after which the whole field is recovered from these latent representations of the input sensors, as illustrated in @fig_nonmodes. By visualizing the weight distribution between the latent space representation and the whole field, the shallow decoder provides nonlinear modes that represent the contribution of each latent variable for super-resolution reconstruction, which are analogous to those captured by nonlinear autoencoders~@MFF2019 @FT2022b @FNF2020 @ricardo_VAE2021 @FHNMF2020 @linot2020deep @FT2023.


As mentioned above, fully-connected network-based reconstruction is prohibitively expensive for global flow field reconstruction due to the very large number of parameters in the network~@wu2020comprehensive. To address this issue, there are also some efforts to estimate low-order representations such as coefficients obtained through proper orthogonal decomposition (POD) from sparse sensor measurements~@carter2021data @giannopoulos2020data @MFRFT2020. For instance, Nair and Goza~@NG2020 proposed a fully-connected model-based estimator of POD coefficients and applied it to a laminar wake around a flat plate. Their fully-connected model takes vorticity sensors on the airfoil surface and then outputs POD coefficients, as illustrated in @fig_NG. They considered wakes with two different angles of attacks, and reported that the neural-network model outperforms conventional linear techniques such as Gappy POD~@ES1995 @BDW2004 and linear stochastic estimation~@adrian1988stochastic. Similarly, Manohar et al.~@manohar2022sparse has also recently performed a fully-connected model and POD-based sparse reconstruction for wake interactions of two cylinders. Their model considers the time history of sensor measurements with long short-term memory (LSTM)~@HS1997, achieving more robustness against noisy inputs compared to a regular MLP model. These reduced-order strategies in machine-learning-based vortical flow reconstruction are summarized in Dubois et al.~@dubois2022machine. With flow examples of two- and three-dimensional cylinder wakes and a spatial mixing layer, they discussed pros and cons of a variety of techniques such as POD~@Lumely1967 @Holmes @TBDRCMSGTU2017, regular autoencoder~@HS2006, variational autoencoder~@rezende2014stochastic, linear/nonlinear fully-connected networks, support vector machine~@smola2004tutorial, gradient boosting~@friedman2001greedy, and library-based reconstruction~@BPK2016a @callaham2019robust.


// [figvision-cn] imgs/fig6.png
// 该图是一幅水平排列的流程图，展示了基于降阶模型辅助的超
// 分辨率重建过程，从左至右依次包含四个主要部分：传感器数
// 据输入、神经网络映射、解码器展开以及高维状态输出。 第
// 一部分位于最左侧，是一个由虚线矩形框包围的正方形区域，
// 标题为“Sensor data s”。框内展示了一个二维标量场的伪彩
// 色分布图，背景为白色，场值通过颜色梯度表示：深蓝色代表
// 最低值，橙色至黄色代表最高值。图中可见一条从左上角延伸
// 至右下角的弯曲带状结构，其核心区域为深蓝色，边缘过渡为
// 浅蓝、白色，再向外扩展为橙黄色晕染区。在该色图上叠加了
// 五个红色实心圆点，分别位于左上角、中部偏左、中部、中部
// 偏右及右下角，这些红点代表稀疏传感器采样位置。一条黑色
// 弯曲箭头从该区域指向右侧的神经网络模块，表示数据流向。
// 第二部分为“Neural network F”，图形化表示一个前馈神经网
// 络。左侧输入层由五个垂直排列的红色圆形节点组成，对应前
// 述五个传感器数据点；中间包含两个隐藏层，每层各有六个灰
// 色圆形节点，各层之间以密集交叉的黑色细线连接，表示全连
// 接权重；右侧输出层为三个垂直排列的浅蓝色圆形节点。整个
// 网络下方标注公式“a = F(s)”，表明输入s经网络F映射得到低
// 维状态向量a。在输出层右侧紧邻处标注文字“Reduced state
// a”，并用括号括起三个浅蓝色节点，强调其为压缩后的状态表
// 示。 第三部分为“Decoder Φ”，表现为一个梯形放大结构，左
// 侧窄边与神经网络的三个输出节点对齐，右侧宽边连接至一列
// 垂直排列的多个橙色空心圆圈（共显示八个，上下两端省略号
// 表示更多），象征将低维状态a线性或非线性展开为高维空间
// 中的基函数组合。该梯形区域填充为渐变橙色，内部标注“
// Decoder Φ”。在其下方标注公式“q = aΦ”，说明高维状态q由
// 低维系数a与解码矩阵Φ相乘获得。一条黑色弯曲箭头从该解码
// 器顶部指向最右侧的输出图像，指示最终结果生成路径。 第
// 四部分位于最右侧，是一个实线矩形框，标题为“
// High-dimension state q”。框内呈现一幅高分辨率二维标量
// 场图像，视觉上与左侧传感器数据区域的物理场形态一致，但
// 细节更丰富、边界更清晰、噪声更少。同样采用相同的颜色映
// 射方案：深蓝为极小值，橙黄为极大值，中间经白灰过渡。该
// 图像无额外标记点或符号，仅作为重建后的高保真状态场展示。
// 整体流程传达的核心结论是：通过稀疏传感器数据s，利用神
// 经网络F提取低维特征a，再经由解码器Φ重构出完整的高维状
// 态场q，实现从欠采样到超分辨率的恢复。
#figure(placement: top, image("imgs/fig6.png", width: 95.0%),
  caption: [
    Reduced-order modeling-assisted super-resolution reconstruction~@NG2020 @dubois2022machine.
  ]
)
<fig_NG>


From the aspect of reducing the number of parameters inside machine-learning models, a combination of a fully-connected model and CNNs has also been leveraged to overcome the limitation of fully-connected networks. Morimoto et al.~@MFMVF2022 considered a combination of multi-layer perceptron (MLP) and CNN (called MLP-CNN-based estimator) to estimate vortical flows around urban structures and temperature data (DayMET) across North America from sparse sensors. The sensor inputs are first given into the part of a fully-connected model and the model extracts the features from the input sensors. The feature vectors extracted from it are then given to the convolutional layers. Compared to solely using fully-connected layers, the computational cost can be significantly reduced while maintaining the reconstruction accuracy. A similar MLP-CNN model was also considered by Zhong et al.~@ZFAT2022 @ZFAT2023 for a vortex-airfoil gust interaction problem. The model estimates a two-dimensional vorticity field from pressure sensor measurements on an airfoil surface. They reported that transfer learning~@pan2009survey @lee2022predicting can help in reducing the required amount of training data, while recurrent neural network (long short-term memory, LSTM~@HS1997) also improves the reconstruction performance of complex transient wake problems.


== Semisupervised- and unsupervised learning
<sec:sul>


In addition to supervised-learning-based efforts, semisupervised- and unsupervised learning can be used in super-resolution analysis of fluid flows. Semisupervised learning combines a small amount of labeled data with a large amount of unlabeled data, which can also be augmented with prior knowledge incorporated into the loss function. Gao et al.~@gao2021super proposed a semisupervised CNN-based super-resolution analysis for fluid flows. Through the investigation of a two-dimensional laminar flow and a cardiovascular flow, they showed that the constraints based on the conservation laws and boundary conditions enable successful super-resolution reconstruction without high-resolution labeling. These physics-law-based augmentations inspired by physics-informed neural network (PINN)~@lagaris1998artificial @raissi2019physics @raissi2020hidden achieve accurate reconstruction while reducing the required amount of training data~@yousif2021high @yousif2022deep.


There are also a couple of studies on semisupervised super resolution. Bode et al.~@bode2021using proposed the physics-informed enhanced super-resolution generative adversarial network (PIESRGAN) for applications to subgrid-scale modeling of LES. To incorporate a physics-based loss function, they used the following cost function~$cal(E)$ for training, $ cal(E) = cal(E)_"adv" + beta_"reg" cal(E)_"reg" + beta_"grad" cal(E)_"grad" + beta_"cont" cal(E)_"cont" , $ where $beta_"reg"$, $beta_"grad"$, and $beta_"cont"$ are weighting coefficients for the different loss term contributions. The first loss term $cal(E)_"adv"$ corresponds to a regular adversarial loss used in GAN-based models, introduced in equation~@eq_GAN~@wang2018esrgan. The second term $cal(E)_"reg"$ is a regular supervised loss function, which is equivalent to equation~@eq_super. The PIESRGAN also includes the gradient loss $cal(E)_"grad"$ defined as the $L_2$ error norm of the gradient of state variables~@bode2019deep. Weighting the gradient of the flow field promotes a smooth and physically-plausible reconstruction~@HFMF2020a @HFMF2020b. They also considered $cal(E)_"cont"$, the divergence-free error for incompressible flow. Similarly, a combination of physics-based loss and U-Net (@fig_Unet) was proposed by Esmaeilzadeh et al.~@esmaeilzadeh2020meshfreeflownet as MeshfreeFlowNet and was applied for the Rayleigh-Bénard instability problem. Due to the U-Net-based augmentation, the training for MeshfreeFlowNet takes only less than 4 minutes with 128 GPUs while achieving quantitative reconstruction. To improve the generalizability of MeshfreeFlowNet~@esmaeilzadeh2020meshfreeflownet for a wide variety of problems, Wang et al.~@TransFlowNet2022 have recently proposed TransFlowNet which weakens the constraint of initial and boundary conditions compared to MeshfreeFlowNet. TransFlowNet was tested with examples of shallow water equation and Rayleigh-Bénard convection. The model provides better reconstruction than the original MeshfreeFlowNet, although the instability of training process is also observed due to the complexity of model.


// [figvision-cn] imgs/fig7.png
// 子图(a)为流程图，展示了ResBlock的架构。数据流向从左至
// 右，由黑色箭头指示。输入信号首先进入一个淡紫色的竖直矩
// 形框，内部标注文字为“BatchNormalization”。随后连接一个
// 蓝色的竖直矩形框，标注为“ReLU”。接着是一个橙色的三维立
// 方体块，标注为“Convolution layers”。之后依次是第二个淡
// 紫色“BatchNormalization”框、第二个蓝色“ReLU”框和第二个
// 橙色“Convolution layers”立方体块。最后输出由右侧黑色箭
// 头指示。此外，图中有一条红色的水平直线位于所有模块上方，
// 左端从第一个模块前引出，右端向下弯曲指向最后一个模块后
// 的输出路径，该红线上方标注文字为“Skip connection”，表
// 示跳跃连接将输入直接加到输出上。 子图(b)为示意图，描绘
// 了Cycle GAN（cGAN）的网络结构及数据流。图的中央左侧是
// 一叠方形图像，代表“Low-resolution data set”（低分辨率
// 数据集），图像内容为模糊的网格状色块，包含橙色、紫色和
// 白色像素区域。图的中央右侧是一叠较大的方形图像，代表“
// High-resolution data set”（高分辨率数据集），图像内容
// 为清晰的流体动力学纹理，具有明显的橙色涡旋结构和深紫色
// 背景。图中包含四个梯形或四边形模块：两个生成器和两个判
// 别器。下方的生成器标记为“Generator (G1)”，接收低分辨率
// 数据集作为输入，输出箭头指向高分辨率数据集；上方的生成
// 器标记为“Generator (G2)”，接收高分辨率数据集作为输入，
// 输出箭头指向低分辨率数据集。右下角的判别器标记为“
// Discriminator (D1)”，接收来自高分辨率数据集的真实样本
// 和来自G1生成的样本（通过双向箭头连接）。左上角的判别器
// 标记为“Discriminator (D2)”，接收来自低分辨率数据集的真
// 实样本和来自G2生成的样本（通过双向箭头连接）。所有连接
// 线均为灰色实线箭头，清晰标示了数据在各模块间的传递方向。
#figure(placement: top, image("imgs/fig7.png", width: 100.0%),
  caption: [
    $( a )$ ResBlock~@he2016deep comprised of BatchNormalization layer, ReLU activation, and convolutional layer. $( b )$ Cycle GAN (cGAN)~@zhu2017unpaired @MTK2023.
  ]
)
<fig_RB>


While incorporating the aforementioned physics loss can promote a physically-plausible super-resolution solution, we should be mindful of the fact that finding an appropriate balance between the weighting coefficients is challenging. We can consider the use of optimization for finding an optimal set of coefficients, although it is computationally expensive~@psaros2022meta. The influence of balancing between an adversarial error and a regular $L_2$ reconstruction error for sparse flow reconstruction is discussed in detail by Zhang et al.~@zhang2022towards for an example of a flow around building models. Moreover, achieving stable convergence during training is also difficult with such complex loss functions. To avoid this issue, additional machine-learning functions such as skip connection~@he2016deep and BatchNormalization~@ioffe2015batch can be leveraged. In fact, the aforementioned models such as PIESRGAN~@bode2019deep, MeshfreeFlowNet~@esmaeilzadeh2020meshfreeflownet, and TransFlowNet~@TransFlowNet2022 are composed of ResBlock~@he2016deep (illustrated in @fig_RB$( a )$), which includes both BatchNormalization and skip connection, for stable and successful learning.


In contrast to supervised and semisupervised learning, unsupervised learning, which does not require labeled data sets, is also used for super-resolution analysis. Kim et al.~@kim2021unsupervised proposed a cycle generative adversarial network (cGAN)-based framework for unsupervised super-resolution reconstruction of turbulent flows. While a regular GAN is composed of one generator and one discriminator as presented in @sec:GAN, cGAN possesses two generators ($G_1$ and $G_2$) and two discriminators ($D_1$ and $D_2$), as illustrated in @fig_RB$( b )$. One generator $G_1$ attempts to reconstruct a high-resolution data $bold(q)_"HR"$ from a low-resolution flow field $bold(q)_"LR"$, while another generator $G_2$ provides low-resolution fields from the generated high-resolution flow data through $G_1$. The discriminators $D_1$ and $D_2$ are trained to distinguish the real data from the generated data, as depicted in @fig_RB$( b )$. This operation allows the cGAN model to learn common features between low- and high-resolution data, that need not be paired~@zhu2017unpaired. The proposed model can reconstruct a velocity field of turbulent channel flow from its low-resolution field. They also demonstrated that the model trained with data from DNS can be applied to the LES data.


Following the study by Kim et al.~@kim2021unsupervised, the unsupervised GAN-based super resolution has recently been examined for a variety of flows. Wurster et al.~@wurster2021deep proposed a hierarchical GAN to perform super resolution of fluid flows. Analogous to SURFNet~@obiols2021surfnet, a hierarchical GAN is first trained with low-resolution data sets. The model weights are then transferred to training with higher-resolution flow fields. Güemes et al.~@guemes2021coarse combined a GAN-based super-resolution reconstruction and state estimation~@BMT2001 @CHBH2006 @CCB2011 @SH2017 from the wall sensor measurements of turbulent channel flow. They first perform super-resolution reconstruction for wall-shear stresses and wall pressure. Another GAN model is then constructed to estimate wall-parallel velocity fields at several wall-normal locations from the super-resolved wall measurements. The GAN models are able to provide reasonable agreement with the reference simulation data up to $y^(+) approx 50$. Yousif et al.~@yousif2022super extended a super-resolution GAN model by combining it with multi-scale CNN~@FFT2019a and applied it to a turbulent channel flow with large longitudinal ribs. The reconstructed flow fields are shown to retain the temporal correlations and high-order spatial statistics.


Moreover, the use of a CNN-based GAN for three-dimensional super-resolution analysis was examined by Xu et al.~@xu2020data for computed tomography (CT) of turbulent jet combustor. With an example of turbulent atmospheric flow, Hassanaly et al.~@hassanaly2022adversarial has comprehensively compared various models for super-resolution reconstruction, including a super-resolution GAN~@ledig2017photo, stochastic estimation, a deconvolution GAN~@stengel2020adversarial, and diversity-sensitive conditional GAN~@yang2019diversity. Although GAN-based models have issues with stability during the learning process, these models hold potential for high-wavenumber reconstruction of turbulent flows.


= Case study: super-resolution reconstruction of turbulence
<sec:results>


This section offers details of CNN-based super-resolution reconstruction for fluid flows through a case study. As an example, we consider two-dimensional decaying isotropic turbulence, which serves as a canonical turbulent flow.


The flow field data to be studied is generated by a two-dimensional DNS~@TNB2016, which numerically solves the two-dimensional vorticity transport equation, $ frac(partial omega, partial t) + bold(u) dot.op nabla omega = frac(1, R e_0) nabla^2 omega , $<eq_1> where $bold(u) = ( u , v )$ and $omega$ represent the velocity and vorticity fields, respectively. The computational domain is a biperiodic square with $L_x = L_y = 1$. The initial Reynolds numbers for training/validation and test data sets are respectively set to $R e_0 equiv u^(*) l_0^(*) / nu = ( 451 , 442 )$. Here, $u^(*)$ is the characteristic velocity defined as the square root of the spatially averaged initial kinetic energy, $l_0^(*) = \[ 2 overline(u^2) ( t_0 ) / overline(omega^2) ( t_0 ) \]^(1 / 2)$ is the initial integral length, and $nu$ is the kinematic viscosity. The numbers of computational grid points used by DNS are $N_x = N_y = 512$. For training the baseline networks, we use 1000 snapshots over an eddy turn-overtime of $t in \[ 2 , 6 \]$ with a time interval of $Delta t = 0.004$. We consider a vorticity field $omega$ as the variable of interest.


We note that our previous studies~@FFT2019a @FFT2021b on machine-learning-based super-resolution reconstruction was performed with two-dimensional decaying turbulence but at lower Reynolds numbers ($R e_0 approx 80$) with smaller numbers of the grid points ($N = 128$). The present case study examines how the model can be improved with regard to not only reconstruction accuracy but also a large amount of necessary training data at a higher Reynolds number.


// [figvision-cn] imgs/fig8.png
// 该图展示了一个用于湍流场超分辨率重建的互联DSC/MS模型架
// 构示意图。整体布局从左至右，包含输入、两个主要处理模块
// （DSC模型和MS模型）、输出以及右侧的图例说明。 左侧为输
// 入数据，标记为 q_LR，表现为一个带有橙色高亮区域的方形
// 图像块，代表低分辨率湍流场数据。该输入通过黑色实线箭头
// 同时馈入上方的DSC模型和下方的MS模型。 上方区域为粉色背
// 景框，标记为“DSC model”。其内部结构由一系列灰色方块堆
// 叠表示特征图，每个特征图右下角有一个小橙色方块，象征卷
// 积滤波器作用点。从左到右依次排列三组绿色边框包围的特征
// 图组，每组之间由蓝色倒三角形连接，代表上采样操作；最右
// 侧一组无绿色边框。在顶部，有四条红色弯曲箭头从输入端直
// 接跨越多个层级指向后续特征图组，表示下采样连接路径。这
// 些红色箭头起始于输入后不久，分别指向第一、第二、第三及
// 最后一组特征图，体现多尺度跳跃连接机制。 下方区域为浅
// 蓝色背景框，标记为“MS model”。其内部结构分为三层水平排
// 列的特征图组，每层包含三个垂直堆叠的灰色方块组，共九组。
// 中间一列三组被橙色矩形框突出显示，表明关键处理阶段。各
// 层内部及层间通过虚线箭头连接：同一层内相邻组之间有横向
// 虚线箭头，上下层对应位置组之间有纵向虚线箭头，形成密集
// 的多尺度交互网络。所有特征图右下角均标有小橙色方块，表
// 示卷积滤波器的应用。 右侧中部为输出结果，标记为 q_HR，
// 是一个比输入更精细、细节更丰富的方形图像块，颜色分布与
// 输入相似但纹理更清晰，代表高分辨率重构后的湍流场。 右
// 上角设有第一个图例框（虚线边框），定义三种图形符号：
// 白色空心正三角形：Downsampling（下采样） 蓝色实心倒三
// 角形：Upsampling（上采样） 橙色实心正方形：
// Convolutional filter（卷积滤波器） 右下角设有第二个图
// 例框（虚线边框），定义两种连接类型： 红色弯曲箭头：
// Downsampled connection（下采样连接） 蓝色直线箭头：
// Upsampled connection（上采样连接） 此外，该图例还包含
// 两个示例子图：左侧为绿色边框包围的小型特征图组，右侧为
// 橙色边框包围的大型特征图组，两者之间用双向红蓝箭头连接，
// 直观展示不同尺度特征图之间的双向信息流动关系。 整个图
// 示传达了该模型通过结合深度监督对比（DSC）与多尺度（MS）
// 机制，利用多层次特征提取、跨尺度跳跃连接和多方向信息融
// 合，实现从低分辨率输入到高分辨率输出的有效重建过程。其
// 中，DSC模块侧重于自上而下的全局上下文引导，MS模块则负
// 责自底向上的局部细节增强与跨层交互，二者协同工作以提升
// 重建精度与结构保真度。
#figure(placement: top, image("imgs/fig8.png", width: 100.0%),
  caption: [
    Interconnected DSC/MS model for super-resolution reconstruction of turbulent flows.
  ]
)
<fig2>


For the present study, we consider super-resolution reconstruction with a regular CNN and the hybrid downsampled skip-connection/multi-scale (DSC/MS) model~@FFT2019a. The design of the DSC/MS model is illustrated in @fig2. The red portion of the downsampled skip connection (DSC) model is composed of up-/downsampling operations and skip connection. The up-/downsampling operations provide robustness against rotational and translational invariance. The skip connection plays a crucial role in learning hierarchically the relationship between the high-resolution output and the low-resolution input, while providing numerical stability during the learning process of the CNN~@he2016deep. The present model also incorporates the multi-scale model (MS) model~@DQHG2018, corresponding to the blue portion of @fig2. This part of the model performs filtering operations across three different sizes, capturing a range of spatial length scales in vortical flows.


To accurately reconstruct two-dimensional higher Reynolds number turbulent flow, we provide additional internal skip connections between the DSC model and MS model, as depicted in the green and orange boxes in @fig2. Each green box in the DSC model connects with each of the orange boxes in the MS model, hence nine connections are present. With these interconnections, this interconnected DSC/MS model enables the intermediate input/output from both submodels to correlate with each other through the learning process. Since coverage of spatial length scales increases with the Reynolds number, the interconnections are expected to be important in learning the relationship between small and large vortical elements by the model. For the activation function $phi$, this study uses the ReLU function~@NH2010 to avoid vanishing gradients of weights during the training process.


Furthermore, we consider a physics-based loss function to examine its effects on machine-learning-based super-resolution reconstruction of turbulent vortical flows. As discussed in @sec:PILF, the use of physics-inspired loss function may not only promote the physical validity of reconstruction but also reduce the amount of necessary training data in a semisupervised manner~@gao2021super @yousif2021high @esmaeilzadeh2020meshfreeflownet @ren2022physics. Here, we use the nonlinear advection term and the linear viscous diffusion term in equation~@eq_1 for the physics-based loss function. The present cost function $cal(E)$ is hence defined as $ cal(E) & = cal(E)_omega + beta_(upright("adv")) cal(E)_(upright("adv")) + beta_(upright("visc")) cal(E)_(upright("visc")) \, med med med upright("where") med\
cal(E)_omega & = \| \| omega_(upright("DNS")) - F \( omega_(upright("LR")) \) \| \|_2 \,\
cal(E)_(upright("adv")) & = \| \| bold(u)_(upright("DNS")) dot.op nabla omega_(upright("DNS")) - bold(u)_(upright("ML")) dot.op nabla omega_(upright("ML")) \| \|_2 \,\
cal(E)_(upright("visc")) & = \| \| nabla^2 omega_(upright("DNS")) - nabla^2 omega_(upright("ML")) \| \|_2 \, $<eq:err> in which $omega_(upright("DNS"))$ and $omega_(upright("LR"))$, respectively, represent the reference (high-resolution) DNS field and the low-resolution input flow field. The coefficients $beta_(upright("adv"))$ and $beta_(upright("visc"))$ determine the balance of the terms in the loss function. The terms $\( dot.op \)_(upright("ML"))$ inside $cal(E)_(upright("adv"))$ and $cal(E)_(upright("visc"))$ are computed with the super-resolved vorticity field $F \( omega_(upright("LR")) \)$.


// [figvision-cn] imgs/fig9.png
// 该图展示了二维衰减均匀各向同性湍流的超分辨率重建结果，
// 整体布局为两行四列的网格结构。第一行为基于L2损失函数的
// 重建结果，第二行为基于物理损失函数（Physics loss）的重
// 建结果。每一列对应一种不同的神经网络模型或输入条件：从
// 左至右依次为“Input”（输入）、“Regular CNN”（常规卷积神
// 经网络）、“DSC/MS”和“Interconnected DSC/MS”。 左侧第一
// 个子图（左上角）标记为“Input”，是一张低分辨率涡量场示
// 意图，呈块状像素化特征，颜色由深紫色经白色过渡到深橙色，
// 表示涡量值从负到正的变化。其右侧附有一个垂直色标条，标
// 注符号为ω，范围从-30（底部深紫色）到+30（顶部深棕色），
// 中间为0（白色）。此图代表待重建的低分辨率输入数据。 左
// 下角子图标记为“Reference”，是高分辨率真实涡量场参考图
// 像，呈现连续平滑的流线型结构，包含多个清晰涡旋结构（如
// 中心偏左的大号深棕色涡核、右侧两个较小涡核等），颜色映
// 射与Input一致，用于对比评估重建质量。 右上角三个子图分
// 别标记为“Regular CNN”、“DSC/MS”、“Interconnected DSC/
// MS”，均为涡量场重建结果图，尺寸与Reference相同。每个子
// 图下方均标注一个数值，代表该重建结果的L2范数误差：分别
// 为0.508、0.241、0.0763。这些图像中，“Regular CNN”输出
// 仍保留明显块状伪影；“DSC/MS”输出较光滑但细节略有模糊；
// “Interconnected DSC/MS”最接近Reference，在局部区域用红
// 色虚线框标出两个关键涡旋结构以突出其重建精度提升。 右
// 下角三个子图同样对应三种模型，但使用物理损失函数训练，
// 下方标注的误差值为0.505、0.0991、0.0863。其中“Regular
// CNN”输出几乎无改善，仍具块状结构；“DSC/MS”和“
// Interconnected DSC/MS”均显著优于前者，且后者在红色虚线
// 框标示区域内更精确地复现了涡旋形态与强度分布。所有重建
// 图均采用与Input相同的颜色映射方案，便于视觉比较。 综上，
// 该图通过并列展示不同模型在不同损失函数下的重建效果及定
// 量误差，表明引入物理约束并采用互连架构可显著提升湍流场
// 超分辨率重建的保真度，尤其在保持小尺度涡结构方面表现优
// 异。
#figure(placement: top, image("imgs/fig9.png", width: 80.0%),
  caption: [
    Super-resolution reconstruction of two-dimensional decaying homogeneous isotropic turbulence. The value underneath each vorticity contour plot presents the $L_2$ norm of reconstruction error $epsilon.alt$.
  ]
)
<fig3>


// [figvision-cn] imgs/fig10.png
// 该图像包含两个主要部分，分别标记为 (a) 和 (b)，展示了
// 不同机器学习模型对流场中线性项和非线性项的重建结果。图
// 像整体布局为一个网格结构，左侧一列为参考真值（Ground
// Truth），右侧三列分别为三种不同模型的预测结果。 子图 (
// a)： 类型：二维标量场的伪彩色可视化图（共7张）。 内容：
// 展示线性项 $\nabla^2\omega$ 的分布。 第一列（最左侧）：
// 标题为 "Linear term $\nabla^2\omega$"。这是一张参考真
// 值图。图像显示平滑的流体涡旋结构，由细长的橙色/棕色线
// 条（代表正梯度区域）和蓝色线条（代表负梯度区域）交织而
// 成，背景为白色。 第二列至第四列：分别对应三种模型："
// Regular CNN"、"DSC/MS"、"Interconnected DSC/MS"。 行划
// 分：每一列模型下分为两行，分别对应不同的损失函数训练结
// 果。第一行标签为 "$L_2$ loss"，第二行标签为 "Physics
// loss"。 具体描述与数值： Regular CNN ($L_2$ loss)：图
// 像呈现明显的网格状人工伪影，充满深棕色的方块和十字交叉
// 线，几乎掩盖了流场结构。下方标注数值 "5.16"，表示 $L_2
// $ 范数误差。 DSC/MS ($L_2$ loss)：图像模糊，仅隐约可见
// 几个深褐色的斑点，缺乏细节结构。下方标注数值 "1.61"。
// Interconnected DSC/MS ($L_2$ loss)：图像开始呈现流线型
// 结构，虽然仍有一些噪点，但已能看出与参考图相似的弯曲纹
// 理。下方标注数值 "0.527"。 Regular CNN (Physics loss)：
// 图像同样呈现严重的网格状伪影，与上方类似。下方标注数值
// "5.18"。 DSC/MS (Physics loss)：图像比上方清晰一些，但
// 仍显得破碎且噪声较大。下方标注数值 "0.906"。
// Interconnected DSC/MS (Physics loss)：图像结构较为完整，
// 能够识别出蓝色的涡旋核心和橙色的剪切层，形态与参考图接
// 近。下方标注数值 "0.447"。 子图 (b)： 类型：二维标量场
// 的伪彩色可视化图（共7张）。 内容：展示非线性项 $\
// boldsymbol{u} \cdot \nabla\omega$ 的分布。 第一列（最
// 左侧）：标题为 "Nonlinear term $\boldsymbol{u} \cdot \
// nabla\omega$"。这是参考真值图。图像显示对比度较强的涡
// 旋结构，有明显的深紫色/蓝色团块（高幅值区域）和橙色/黄
// 色条纹，背景为白色。 第二列至第四列：模型名称与子图(a)
// 一致，分别为 "Regular CNN"、"DSC/MS"、"Interconnected
// DSC/MS"。 行划分：同样分为 "$L_2$ loss" 和 "Physics
// loss" 两行。 具体描述与数值： Regular CNN ($L_2$ loss)：
// 图像再次被强烈的网格状伪影覆盖，呈现出像素化的深色方块，
// 无法辨认物理结构。下方标注数值 "2.82"。 DSC/MS ($L_2$
// loss)：图像极其模糊，仅在中心区域有微弱的蓝紫色斑块，
// 周围是杂乱的浅色纹理。下方标注数值 "1.53"。
// Interconnected DSC/MS ($L_2$ loss)：图像成功重建了两个
// 主要的涡旋结构，一个在左上（偏蓝），一个在右下（偏蓝），
// 中间夹杂着橙色过渡区，形态与参考图高度相似。下方标注数
// 值 "0.748"。 Regular CNN (Physics loss)：图像依然受困
// 于网格状伪影，但在某些区域显示出试图模拟涡旋的尝试。下
// 方标注数值 "2.85"。 DSC/MS (Physics loss)：图像比上方
// 清晰，能看到模糊的涡旋轮廓，颜色映射基本正确（蓝/紫和
// 橙），但边界不清晰。下方标注数值 "0.918"。
// Interconnected DSC/MS (Physics loss)：图像质量最高，清
// 晰地再现了参考图中的双涡旋结构及其颜色分布，细节丰富。
// 下方标注数值 "0.734"。 总结趋势： 从左到右，随着模型从
// "Regular CNN" 进化到 "Interconnected DSC/MS"，重建图像
// 的质量显著提高，网格状伪影逐渐消失，流体的物理结构（如
// 涡旋和剪切层）越来越清晰。下方的数值（范数误差）也随之
// 减小，表明 "Interconnected DSC/MS" 模型具有最高的重建
// 精度。比较同一列的上下两行，对于高级模型（后两列），使
// 用 "Physics loss" 训练的模型通常能获得比 "$L_2$ loss"
// 更小的误差值和更清晰的图像结构；而对于基础模型（
// Regular CNN），两种损失函数的表现都很差。
#figure(placement: top, image("imgs/fig10.png", width: 83.0%),
  caption: [
    $( a )$ The linear term $nabla^2 omega$ and $( b )$ the nonlinear term $bold(u) dot.op nabla omega$, computed from the reconstructed flow fields for each machine-learned model. The value underneath each contour presents the $L_2$ norm error $epsilon.alt$. Shown results are from the same case as the vorticity snapshots presented in @fig3.
  ]
)
<fig4>


In what follows, we assess six different machine-learning models:

+ CNN-$L_2$: a regular CNN model with $cal(E) = cal(E)_omega$,

+ CNN-$L_"phys"$: a regular CNN model with $cal(E) = cal(E)_omega + beta_"adv" cal(E)_"adv" + beta_"visc" cal(E)_"visc"$,

+ DSC/MS-$L_2$: the original DSC/MS model~@FFT2019a with $cal(E) = cal(E)_omega$,

+ DSC/MS-$L_"phys"$: the original DSC/MS model with $cal(E) = cal(E)_omega + beta_"adv" cal(E)_"adv" + beta_"visc" cal(E)_"visc"$,

+ IDSC/MS-$L_2$: the interconnected DSC/MS model with $cal(E) = cal(E)_omega$,

+ IDSC/MS-$L_"phys"$: the interconnected DSC/MS model with $cal(E) = cal(E)_omega + beta_"adv" cal(E)_"adv" + beta_"visc" cal(E)_"visc"$.

These six machine-learning models are tasked to reconstruct the high-resolution vortical flow field of size $512^2$ from the corresponding low-resolution data of size $16^2$, generated by average-pooling operations~@FFT2019a. We set $beta_"adv" = beta_"visc" = 0.1$ to the balance of the order for each term.


Let us consider the reconstructed vorticity fields from machine-learing-based super-resolution approaches in @fig3. The large-scale vortices can be reconstructed with the regular CNN models. However, the reconstructed fields are pixelized around rotation and shear-dominated structures, which was also observed with a regular CNN-based super-resolution reconstruction in our previous study~@FFT2019a. The $L_2$ norm error, $epsilon.alt = \| \| f_"DNS" - f_"ML" \| \|_2 / \| \| f_"DNS" \| \|_2$, is found to be larger than 0.5 with the regular CNNs. The DSC/MS model with the $L_2$-based optimization provides a better and clear reconstruction for large vortical structures with an $L_2$ norm error of 0.241. This indicates that embedding the physics-inspired DSC functions and the MS filters enables accurate reconstruction of vortical flows.


While the DSC/MS model achieves a qualitative reconstruction for vortical structures, finer scales of shear layers that appear around large rotational elements cannot be recovered well. The reconstruction over these scales that emerge in higher Reynolds number flows can be improved by introducing either the physics-based loss function or the interconnection inside the DSC/MS model, as presented in @fig3. With DSC/MS-$L_"phys"$, IDSC/MS-$L_2$, and IDSC/MS-$L_"phys"$, these shear layers are more accurately reconstructed compared to the reconstruction with the regular model, as highlighted by the red boxes in @fig3. Hence, both the physics-inspired optimization and model design greatly assist in the reconstruction of higher Reynolds number flows. Note that the difference between the interconnection-based model enhancement and using the physics-based loss function is in their robustness against noisy low-resolution input, as it will be discussed later.


We here examine each term in the physics-loss function; namely the linear term $nabla^2 omega$ and the nonlinear term $bold(u) dot.op nabla omega$ of the present super-resolution reconstruction, as shown in @fig4. These results are from the same case as the vorticity snapshots presented in @fig3. Examination of these terms is a strict test since higher-order derivations can amplify errors greatly for high wavenumbers. Let us first focus on the estimated linear viscous diffusion term visualized in @fig4$( a )$. The regular CNN completely fails to estimate $nabla^2 omega$, as evident from the pixelized vorticity reconstruction in @fig3. Using the DSC/MS model with the regular $L_2$ optimization, the linear term field also exhibits erroneous profiles comprised of pairwise structures that cannot be observed in the reference field. These derivative-based assessments are again very sensitive and also affected by the reconstruction of surrounding local structures. As expected, estimation is improved by including the physics-based term in the loss function (DSC/MS-$L_"phys"$). The accuracy of $nabla^2 omega$ can be further enhanced by using the interconnected DSC/MS models, presenting fine-scale structures in the high-order derivation field. This indicates that adding the interconnections inside the machine-learning model enables physically-compatible super-resolution reconstruction of turbulent flows in addition to the physics-loss-based optimization.


The estimation of the nonlinear term is shown in @fig4$( b )$. The whole trend in reconstruction is analogous to that for the linear term, hence the interconnected DSC/MS models well reconstruct the nonlinear term fields compared to the reference field. The $L_2$ errors for the nonlinear term with DSC/MS-$L_"phys"$, IDSC/MS-$L_2$, and IDSC/MS-$L_"phys"$ are higher than that of the linear term. This suggests that the estimation for the nonlinear term is more difficult than the linear term.


We also investigate the dependence of the reconstruction error on the number of the training snapshots~$n_"snapshot"$. For all models, the error decreases as $n_"snapshot"$ increases, as shown in @fig6. Both the interconnection and the physics-based loss enable a qualitative reconstruction with a reduced number of training snapshots. The observation that a physics-inspired optimization reduces the required amount of training data has also been reported in previous studies~@gao2021super @raissi2020hidden. The interconnected DSC/MS model reconstructs fine vortical structures even with only $n_"snapshot" = 50$ (@fig6$( c )$), while the original DSC/MS model provides only large-scale structures, as shown in @fig6$( a )$. This suggests that the present machine-learning model efficiently captures a nonlinear relationship between the under-resolved input and the high-resolution vortical flow from a small amount of training data by capitalizing on the interconnected skip connections.


// [figvision-cn] imgs/fig11.png
// 该图包含左侧一个折线图（子图a）和右侧四幅并排排列的方
// 形热图（子图b、c、d及未标号但位于右上角的第四幅，根据
// 布局应为(b)、(c)、(d)对应左下、右下、右上？需澄清——实
// 际图中：左上为(a)，右上为(b)，左下为(c)，右下为(d)。因
// 此右侧共四幅热图，分别标记为(a)、(b)、(c)、(d)，与左侧
// 曲线图中的标注点相对应）。 左侧子图(a)为折线图，横坐标
// 为“n_snapshot”，表示训练快照数量，范围从约50到1000，无
// 明确刻度间隔但可见主要刻度在200、400、600、800、1000处；
// 纵坐标为“ε”，表示重建误差，范围从0.0到0.5，主刻度间隔
// 为0.1。图中共有六条曲线，每条代表一种方法及其损失函数
// 组合： 蓝色实线带圆形标记：“CNN-L₂” 橙色实线带圆形标记：
// “CNN-L_phys” 绿色实线带圆形标记：“DSC/MS-L₂” 红色实线
// 带圆形标记：“DSC/MS-L_phys” 紫色实线带圆形标记：“IDSC/
// MS-L₂” 棕色实线带圆形标记：“IDSC/MS-L_phys” 所有曲线均
// 随n_snapshot增加而下降或趋于平稳，表明重建精度随训练数
// 据量增加而提升。具体趋势如下： “CNN-L₂”（蓝线）起始于n
// ≈50时ε≈0.52，在n=200时降至≈0.43，之后缓慢下降至n=1000
// 时≈0.41。 “CNN-L_phys”（橙线）起始于ε≈0.49，在n=200时
// 降至≈0.41，之后基本持平。 “DSC/MS-L₂”（绿线）起始于ε≈
// 0.40，在n=200时降至≈0.30，n=500后稳定在≈0.25。 “DSC/
// MS-L_phys”（红线）起始于ε≈0.32，在n=200时降至≈0.25，n=
// 500后稳定在≈0.12。 “IDSC/MS-L₂”（紫线）起始于ε≈0.26，
// 在n=200时降至≈0.16，n=500后稳定在≈0.09。 “IDSC/
// MS-L_phys”（棕线）起始于ε≈0.33，在n=200时降至≈0.13，n=
// 500后稳定在≈0.09。 图中用彩色字母标注了四个关键数据点，
// 对应右侧四幅热图： (a) 绿色圆点，位于“DSC/MS-L₂”曲线上，
// n_snapshot ≈ 50，ε ≈ 0.40 (b) 红色圆点，位于“DSC/
// MS-L_phys”曲线上，n_snapshot = 500，ε ≈ 0.12 (c) 紫色
// 圆点，位于“IDSC/MS-L₂”曲线上，n_snapshot ≈ 50，ε ≈
// 0.26 (d) 棕色圆点，位于“IDSC/MS-L_phys”曲线上，
// n_snapshot = 500，ε ≈ 0.09 右侧四幅热图均为正方形区域，
// 显示二维场分布，颜色映射一致：深紫色代表负值极小值，白
// 色为零值附近，橙黄色代表正值极大值。每幅图下方无比例尺，
// 但根据上下文可推断其空间尺度相同。各图内容描述如下：
// 子图(a)（对应左侧绿色点）：中心偏左有一个明显的深紫色
// 椭圆状负值区，周围环绕浅橙色环；右侧中部有一个较小的深
// 紫色斑点；整体结构较模糊，边缘不清晰，反映低训练样本下
// 的较差重建质量。 子图(b)（对应左侧红色点）：中心偏左的
// 深紫色区域更集中、边界更锐利；右侧小斑点仍存在但形状更
// 规则；背景噪声减少，细节更丰富，体现中等训练量下物理约
// 束带来的改进。 子图(c)（对应左侧紫色点）：中心深紫色区
// 域比(a)稍清晰，但仍略显弥散；右侧斑点较弱；整体对比度
// 低于(b)，说明即使使用IDSC/MS模型，仅50个样本仍不足以获
// 得高精度。 子图(d)（对应左侧棕色点）：中心深紫色区域高
// 度聚焦，呈近似圆形；右侧斑点清晰且对称；背景几乎无杂波，
// 纹理平滑，是四幅中最接近真实结构的图像，表明IDSC/MS结
// 合物理损失在足够训练样本下性能最优。 综上，该图通过定
// 量曲线与定性可视化共同说明：重建误差随训练快照数增加而
// 降低，其中引入物理损失函数（L_phys）的方法收敛更快、最
// 终误差更低；IDSC/MS架构优于DSC/MS，尤其在少量样本下表
// 现更佳；当训练样本达500时，IDSC/MS-L_phys达到最佳重建
// 效果。
#figure(placement: top, image("imgs/fig11.png", width: 85.0%),
  caption: [
    Dependence of the reconstruction accuracy on the number of the training snapshots.
  ]
)
<fig6>


// [figvision-cn] imgs/fig12.png
// 该图由左右两部分组成。左侧为子图(a)，是一个二维曲线图；
// 右侧为子图(b)至(f)，是六张并排排列的方形显微图像。 左
// 侧子图(a)： 这是一个二维折线图，展示重建误差ε随输入噪
// 声幅度γ的变化关系。横坐标轴标记为γ，范围从0.0到0.8，刻
// 度间隔为0.2。纵坐标轴标记为ε，范围从0.0到1.2，刻度间隔
// 为0.2。图中包含六条带数据点的折线，分别代表不同算法在
// 不同损失函数下的性能，具体对应关系如下： 蓝色实线配圆
// 形标记：代表CNN-L₂方法。其ε值随γ增加而显著上升，在γ=
// 0.0时约为0.5，在γ=0.8时达到约1.2，是所有曲线中增长最快、
// 最终误差最高的。曲线上在γ≈0.2处标注有蓝色文字“(a)”。
// 橙色实线配圆形标记：代表CNN-Lphys方法。其趋势与蓝色曲
// 线相似但数值较低，在γ=0.0时约为0.5，在γ=0.8时约为1.03。
// 绿色实线配圆形标记：代表DSC/MS-L₂方法。其ε值随γ缓慢上
// 升，在γ=0.0时约为0.25，在γ=0.8时约为0.58。曲线上在γ≈
// 0.4处标注有绿色文字“(b)”。 紫色实线配菱形标记：代表
// IDSC/MS-L₂方法。其ε值随γ上升，在γ=0.0时约为0.1，在γ=
// 0.8时约为0.6。曲线上在γ≈0.8处标注有紫色文字“(c)”。 红
// 色实线配三角形标记：代表DSC/MS-Lphys方法。其ε值随γ缓慢
// 上升，在γ=0.0时约为0.1，在γ=0.8时约为0.45。曲线上在γ≈
// 0.2处标注有红色文字“(d)”，在γ≈0.6处标注有红色文字“(e)”。
// 棕色实线配正方形标记：代表IDSC/MS-Lphys方法。其ε值随γ
// 缓慢上升，在γ=0.0时约为0.1，在γ=0.8时约为0.4。曲线上在
// γ≈0.8处标注有黑色文字“(f)”。 总体趋势表明，所有方法的
// 误差均随噪声幅度增加而增大，但基于物理损失（Lphys）的
// 方法（红、棕线）及迭代方法（紫、棕线）受噪声影响较小，
// 表现优于仅使用L₂损失的CNN方法（蓝、橙线）。 右侧子图(b
// )至(f)： 这六张子图均为方形的显微照片或模拟图像，展示
// 了在不同条件下的重建结果或原始含噪图像。每张图像的尺寸
// 相同，无坐标轴，但在右下角通常会有比例尺（虽然在此裁剪
// 图中不可见，按常规推断应有）。图像采用伪彩色映射，背景
// 为浅黄色至白色，其中散布着深蓝色/紫色的团块和亮橙色/棕
// 色的区域。这些颜色可能代表不同的物质相或密度值。各子图
// 内容描述如下： 子图(b)：位于右上第一列。图像中心有一个
// 较大的深棕色圆形区域，周围环绕着不规则的浅橙色晕圈。背
// 景中有若干分散的深蓝色斑点和细长的橙色条纹结构。整体纹
// 理较为模糊，细节不清晰。 子图(c)：位于右上第二列。结构
// 与(b)类似，中心的深棕色圆形区域更清晰锐利，周围的橙色
// 晕圈也更为分明。背景中的蓝色斑点数量减少，橙色条纹更加
// 连贯。相比(b)，此图的对比度和清晰度更高。 子图(d)：位
// 于右下第一列。图像呈现多个分散的深蓝色圆形斑点，以及连
// 接它们的橙色网状或纤维状结构。没有像(b)(c)那样单一的中
// 心大圆斑。整体看起来像是多孔介质或细胞结构的切片。 子
// 图(e)：位于右下第二列。与(d)相比，此图中的橙色网络结构
// 更加连续和明亮，深蓝色斑点的大小和分布略有变化，整体图
// 像的“干净”程度似乎比(d)略高，但仍保留较多背景噪声特征。
// 子图(f)：位于右下第三列。此图的中心有一个非常清晰、边
// 界锐利的深棕色圆形区域，类似于(c)。周围的橙色结构和背
// 景中的蓝色斑点都显得比(b)和(e)更加清晰，噪声水平最低，
// 细节最丰富。 这六张图直观地展示了从左到右、从上到下，
// 随着某种处理（可能是去噪或重建算法的应用），图像质量逐
// 渐提高的过程：从模糊、高噪声的状态(b, d, e)演变为清晰、
// 低噪声、特征明确的状态(c, f)。结合左图，可以推断这些图
// 像分别对应于左图中不同γ值或不同算法下的输出结果，用以
// 佐证定量分析的趋势。
#figure(placement: top, image("imgs/fig12.png", width: 100.0%),
  caption: [
    Dependence of the reconstruction accuracy on the magnitude of noisy input.
  ]
)
<fig7>


The use of the physics-based loss function can lead to robustness against noisy inputs. Here, let us examine the influence of noise on super-resolution reconstruction. We add the Gaussian noise $bold(n)$ to the low-resolution input $omega_"LR"$, and assess the reconstruction $L_2$ error $epsilon.alt = \| \| omega_"HR" - F ( omega_"LR" + bold(n) ) \| \|_2 / \| \| omega_"HR" \| \|_2$, where the magnitude of the noise is given as $gamma = \| \| bold(n) \| \| / \| \| omega \| \|$. Here, the models trained with 1000 snapshots are used. The relationship between the error and the noise magnitude is shown in @fig7. For all cases, the error increases with increasing magnitude $gamma$. The reconstructed flow fields generally reveal the large-scale vortices, while the finer scales are affected by the noisy input. Especially for $gamma > 0.3$, the DSC/MS models with the physics-based loss function are observed to be more robust than models trained with the simple $L_2$ error optimization. Hence, it can be argued that physics-based loss function helps in devising robust models against noisy measurements.


= Extensions
<sec:outlook>


In the above sections, we surveyed various machine-learning-based super-resolution approaches and their applications to vortical flows. Here, we discuss extensions of machine-learning-based super-resolution analysis beyond their basic applications.


== Changing input variable setups
<changing-input-variable-setups>


// [figvision-cn] imgs/fig13.png
// 该图像由四个标记为(a)、(b)、(c)和(d)的子图组成，展示了
// 四种基于机器学习的超分辨率分析方法。 子图(a)是一个示意
// 图，标题为“Convolution on point cloud”（点云卷积）。左
// 侧展示了一个背景为流体涡旋场（紫色代表负值，橙色代表正
// 值）的矩形区域，其中散布着若干彩色圆点，标注为“Random
// sensors as point cloud”（作为点云的随机传感器）。这些
// 点颜色各异（深蓝、浅蓝、橙色），表示不同的节点特征或类
// 别。图中有一个黑色实线圆圈和一个黑色虚线圆圈，分别圈出
// 部分传感器点，箭头从这两个圆圈指向右侧的高分辨率场$q_{
// HR}$中的对应区域，示意通过局部邻域进行卷积操作以重建高
// 分辨率场。右侧是输出结果$q_{HR}$，为一个平滑连续的二维
// 标量场，具有清晰的涡旋结构，颜色映射与输入背景一致。
// 子图(b)是一个流程图，标题为“Graph neural network”（图
// 神经网络）。左侧显示“Random sensors on graph or
// unstructured mesh”（图或非结构化网格上的随机传感器），
// 即一组节点（彩色圆点）通过蓝色线段连接形成不规则三角剖
// 分网格，覆盖在相同的涡旋背景场上。中间部分，“Node
// features”（节点特征）以一列垂直排列的彩色圆点表示，下
// 方是一个4×4的二值邻接矩阵（Adjacency matrix），元素为0
// 或1，表示节点间的连接关系。一个箭头从节点和邻接矩阵指
// 向一个标有“Graph convolution”（图卷积）的紫色梯形框，
// 再指向右侧的输出$q_{HR}$——与子图(a)相同的高分辨率涡旋
// 场。此图说明利用图结构和节点特征通过图卷积网络实现超分
// 辨率重建。 子图(c)是一个流程图，标题包含“Flow field or
// random sensors on stretched mesh”、“Coordinate
// transformation”、“Transformed coordinate”和“
// Convolution filter”。左侧是一个拉伸变形的网格（
// stretched mesh），网格线呈曲线分布，上面分布着彩色传感
// 器点。一个向右的箭头标注“Coordinate transformation”，
// 指向右侧一个规则的正方形网格（transformed coordinate），
// 原传感器点被映射到新坐标系的对应位置。其中一个局部3×3
// 区域用橙色方框高亮，并有箭头指向“Convolution filter”，
// 表明在此规则化后的坐标系上应用标准卷积滤波器。整个流程
// 旨在将非均匀采样数据变换到规则网格后执行传统卷积操作。
// 子图(d)是一个示意图，标题为“Voronoi tessellation-based
// projection”（基于沃罗诺伊剖分的投影）。左侧展示“
// Voronoi tessellation”（沃罗诺伊剖分），即在传感器点周
// 围生成多边形单元（不同灰度/浅色填充），每个单元内包含
// 一个中心点（传感器）。一个粉色小方块位于某个单元内，通
// 过虚线箭头连接到右侧的一叠正方形图像层（共四层可见，用
// 省略号表示更多层），每层中对应位置有一个同色小方块，最
// 后汇聚到最右侧的高分辨率场$q_{HR}$中的一个像素块。这表
// 明通过将传感器值投影到其沃罗诺伊单元格，并沿深度方向堆
// 叠多层特征图，最终合成高分辨率输出。
#figure(placement: top, image("imgs/fig13.png", width: 100.0%),
  caption: [
    Applications of machine-learning-based super-resolution analysis for moving sensor and unstructured grid conditions. $( a )$ Convolution on point clouds~@kashefi2021point @qi2017pointnet. $( b )$ Graph neural network~@liu2022fluid @gruber2022comparison. $( c )$ Coordinate transformation~@GSW2020. $( d )$ Voronoi tessellation-based projection~@fukami2021global.
  ]
)
<fig8>


When a machine-learning model is trained, the size of the input and output variables or more specifically the setup of the input and output variables is fixed. If the setup is changed, the machine-learning model generally needs to be completely retrained, which is a heavy burden. This issue is in fact a limitation of many machine-learning models, and machine-learning-based super-resolution models are no exceptions. If the number of pixels or their locations is different from that used in the training process, the trained model cannot be used without retraining the model with the input variable size changed. Preprocessing the different-size input data with interpolation may work, but care should be taken since such an approach generally loses information. Unstructured grid and randomly sampled data also require some care since standard CNN-based models may not be appropriate.


There are several approaches to address these challenges. For instance, PointNet~@qi2017pointnet is able to handle unorganized and sparse data with a point cloud. Although this was originally used for image classification and segmentation tasks, Kashefi et al.~@kashefi2021point has recently applied it to fluid flows. In their formulation, sensors on the grid can be directly treated and a model can learn the relationship between the sensors and outputs, as illustrated in @fig8$( a )$.


To handle spatially irregular sensor arrangements, graph neural network (GNN)~@wu2020comprehensive can be considered. GNN is able to perform a convolutional operation on unstructured mesh data, which is similar to that inside of CNNs.


Such GNN-based methods can be applied for machine-learning-based super-resolution reconstruction by modifying the setup for data dimensions between input and output, as shown in @fig8$( b )$.


Coordinate transformation can also be considered to simply use regular machine-learning models for vortical flows. PhyGeoNet~@GSW2020 includes coordinate transformation from an irregular domain to a structured mesh space for fluid flow regression, allowing us to convolve on flow fields, as illustrated in @fig8$( c )$. Finding the appropriate coordinate transformation may be a challenge for complex flow field domain geometry.


We can also generalize super-resolution analysis by considering sensor measurements in the flow field as the input for machine-learning models to reconstruct the flow field. For a fixed number of sensors with their positions unchanged, regular machine-learning models developed in image science can often be directly used. However, when sensors go online or offline changing the number of sensors and moving spatially over time, the machine-learning models cannot be applied without special care. Voronoi-tessellation-based CNN~@fukami2021global can handle an arbitrary number of moving sensors in a single model. In this formulation, sparse sensor measurements are projected onto grids generated from Voronoi tessellation, as illustrated in @fig8$( d )$. The flow field discretized with Voronoi tessellation is then used as an input for CNN-based super-resolution reconstruction. This approach provides robust real-time super-resolution analysis for vortical flows.


== Super resolution for turbulent flow simulations
<super-resolution-for-turbulent-flow-simulations>


With the ability to recover fine-scale flow structures from coarse images of the flow field, it is natural to ask whether machine-learning-based super-resolution analysis can be incorporated into numerical simulations to improve turbulent flow simulations. From a broader perspective, this question translates to whether super-resolution analysis can be implemented in a simulation of multi-scale physical phenomena to accurately reconstruct the subgrid-scale physics~@pradhan2021variational @bode2021using.


For super-resolution analysis to reconstruct a physically accurate high-resolution flow field, it is generally necessary that the low-resolution input data is accurate on its own coarse grid. If the coarse flow field input is provided by some turbulent flow simulation (e.g., large-eddy simulation, detached eddy simulation, and Reynolds-averaged Navier-Stokes simulation~@Kajishima), it is important that the coarse flow be accurate to begin with. The super-resolved field would not be a physically accurate if the low-resolution flow field (input) is deviated from the true solution. Conservatively speaking, turbulent flow statistics may be predicted well with super resolution but highly-accurate reconstruction of each and every instantaneous flow would likely be a major difficulty, if not impossible~@kochkov2021machine. In other words, we should not expect that LES results (or those from other solvers with turbulence models) can be transformed to yield DNS results.


A worthy question to ask is whether super-resolution analysis can support the development of subgrid-scale models. This could be different from other turbulence modeling approaches that use applied regressions to directly determine the subgrid-scale models for turbulent flow simulations. Similar to an approximate deconvolution model~@stolz2001approximate which considers inverse mapping of spatial filters, super resolution could be used to augment the subgrid-scale models. Furthermore, it remains to be seen whether super-resolution analysis can simultaneously nudge the low-resolution field and recover the subgrid-scale flow structures. Again, the success of such simultaneous corrections will likely require the low-resolution flow field to be fairly accurate on its own grid. Alternatively, GAN-based techniques may also provide interesting approaches to achieve super resolution for turbulence.


Ongoing research developments in super-resolution analysis of turbulent flows and data-driven turbulence models~@LKT2016 @DIX2019 may address the issues identified here in the coming years. As super-resolution methods are extended and incorporated into turbulent flow analysis and simulations, it is important to ensure that the derived super-resolution method is generalizable over a range of Reynolds numbers and turbulent flow problems to confirm robust and reliable performance. This is critical if these techniques are to be implemented in general-use turbulent flow simulators.


== Applications to real-world problems
<applications-to-real-world-problems>


Super-resolution analysis holds great potential for fluid dynamics as discussed above. However, there still exists some challenges, especially toward applications to real-world problems. This section discusses the current challenges and possible future directions of machine-learning-based fluid flow super resolution.


One of the major challenges of machine-learning-based super-resolution reconstruction for fluid flows is the necessity for a certain amount of training data. While unsupervised learning used for GANs and semisupervised learning assisted with physics-inspired loss functions introduced in the present survey can mitigate this issue, existing techniques still require learning the relationship between coarse data and high-resolution vortical flows from either unpaired or paired training data for successful reconstruction. Since the majority of real-world problems do not have access to ground truth and only sparse and noisy measurements are available, one can consider the use of data assimilation~@du2023state @di2020synchronization @di2018inferring to improve super-resolution reconstruction by incorporating the latest observations with a short-range real-time forecast.


Yasuda and Onishi~@yasuda2022spatio has recently proposed a four-dimensional super-resolution data assimilation and demonstrated its performance with a two-dimensional periodic channel flow. The proposed method considers the temporal evolution of a system from low-resolution simulations with the aid of an ocean model, while a trained machine-learning model is simultaneously used to perform data assimilation and super resolution. Since there is a huge amount of historical weather and climate reanalysis data available, the unification of super resolution with data assimilation or pre-existing models would be an interesting research direction.


In addition, most of the existing studies focus on designing a reconstruction model for a particular flow problem, variable, or data shape.


From this aspect, it would be desired to simultaneously leverage a variety of multi-modal data such as point-wise measurements, image-based data, and online measurements such as LiDAR-typ


e data.


Prediction of unavailable parameters from such sparse and noisy but available measurement


s may also become an interesting direction of super-resolution studies of fluid dynamics.






= Conclusions
<sec:conc>


We provided a survey on machine-learning-based super-resolution reconstruction of vortical flows. Several machine-learning approaches and the use of physics-based cost functions for super-resolution analysis were discussed. We further performed case studies of super-resolution reconstruction of turbulent flows with convolutional neural network (CNN)-based methods. We demonstrated that a super-resolution model with physics-based loss function or physics-inspired neural network structures can reconstruct vortical flows even with limited training data and noisy inputs. We also discussed extensions and challenges of machine-learning-based super resolution for fluid flows from the aspects of changing input variable setups and applications for turbulent flow simulations.


The insights obtained through the present survey can be leveraged for a variety of machine-learning-based super-resolution models. For instance, the use of multi-scale filters inside CNN can be generalized not only in supervised learning but also in unsupervised techniques~@yousif2022physics. Physics-informed loss functions can also be extended for various machine-learning models. Moreover, it may also be interesting to develop super-resolution models in wavespace to incorporate certain spectral properties.


We remind that studies surveyed in the present paper are generally based on clean training data. Preparing high-quality input data is essential for successfully reconstructing turbulent flows. However, it is necessary to assess the robustness and sensitivity of the models against noisy inputs~@nakamura2022identifying. This point will be important as machine-learning-based super-resolution analyses become utilized in industrial applications~@Fukamipump2022. Together with the accuracy of the models, quantifying uncertainties in machine-learning prediction is also required to assess their reliability and limitations. For these reasons, making computational and experimental fluid-flow databases~@li2008public @wu2008direct @towne2022database available is critically important to advance studies on data-driven analysis of vortical flows. We hope that this survey paper provides some guidance in advancing algorithms and applications of machine-learning-based super-resolution analysis for a variety of fundamental and industrial fluid flow problems.


#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>
K. Fukami acknowledges the support from the UCLA-Amazon Science Hub for Humanity and Artificial Intelligence. K. Fukagata acknowledges the support by JSPS KAKENHI (grant numbers 18H03758 and 21H05007). K. Taira acknowledges the generous support from the US Air Force Office of Scientific Research (grant FA9550-21-1-0178) and the US Department of Defense Vannevar Bush Faculty Fellowship (grant N00014-22-1-2798).


#heading(level: 1, numbering: none)[Declarations]
<declarations>


#heading(level: 2, numbering: none)[Conflict of interest]
<conflict-of-interest>
The authors declare that they have no conflict of interest.


#heading(level: 2, numbering: none)[Authors' contributions]
<authors-contributions>
Ka.F, Ko.F, and KT designed research. Ka.F performed research and analyzed data. Ka.F and KT wrote the paper. Ko.F and KT supervised.


#heading(level: 2, numbering: none)[Availability of data and materials ]
<availability-of-data-and-materials>
The data that support the findings of this study are available from the corresponding author upon reasonable request.

#bibliography("refs.bib", title: [References])
