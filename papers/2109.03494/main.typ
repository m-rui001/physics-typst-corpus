#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.86cm, bottom: 2.38cm))
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set math.equation(numbering: "(1)", supplement: none)
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#set heading(numbering: none)
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set par(justify: true, spacing: 0.97em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(12pt, weight: "bold", [Quantum Computational Advantage via 60-Qubit 24-Cycle Random Circuit Sampling])
  #v(1em)
  #text(10.5pt)[Qingling Zhu, Sirui Cao, Fusheng Chen, Ming-Cheng Chen, Xiawei Chen, Tung-Hsun Chung, Hui Deng, Yajie Du, Daojin Fan, Ming Gong, Cheng Guo, Chu Guo, Shaojun Guo, Lianchen Han, Linyin Hong, He-Liang Huang, Yong-Heng Huo, Liping Li, Na Li, Shaowei Li, Yuan Li, Futian Liang, Chun Lin, Jin Lin, Haoran Qian, Dan Qiao, Hao Rong, Hong Su, Lihua Sun, Liangyuan Wang, Shiyu Wang, Dachao Wu, Yulin Wu, Yu Xu, Kai Yan, Weifeng Yang, Yang Yang, Yangsen Ye, Jianghan Yin, Chong Ying, Jiale Yu, Chen Zha, Cha Zhang, Haibin Zhang, Kaili Zhang, Yiming Zhang, Han Zhao, Youwei Zhao, Liang Zhou, Chao-Yang Lu, Cheng-Zhi Peng, Xiaobo Zhu, Jian-Wei Pan]
]
#v(1em)

#text(9.5pt)[*Abstract.* To ensure a long-term quantum computational advantage, the quantum hardware should be upgraded to withstand the competition of continuously improved classical algorithms and hardwares. Here, we demonstrate a superconducting quantum computing systems #emph[Zuchongzhi] 2.1, which has 66 qubits in a two-dimensional array in a tunable coupler architecture. The readout fidelity of #emph[Zuchongzhi] 2.1 is considerably improved to an average of 97.74%. The more powerful quantum processor enables us to achieve larger-scale random quantum circuit sampling, with a system scale of up to 60 qubits and 24 cycles. The achieved sampling task is about 6 orders of magnitude more difficult than that of Sycamore [Nature #strong[574], 505 (2019)] in the classic simulation, and 3 orders of magnitude more difficult than the sampling task on #emph[Zuchongzhi] 2.0 [arXiv:2106.14734 (2021)]. The time consumption of classically simulating random circuit sampling experiment using state-of-the-art classical algorithm and supercomputer is extended to tens of thousands of years (about $4.8 times 10^4$ years), while #emph[Zuchongzhi] 2.1 only takes about 4.2 hours, thereby significantly enhancing the quantum computational advantage.]

#columns(2, gutter: 0.6cm)[

= INTRODUCTION
<introduction>
Quantum computers are emerging with the promise of solving certain computational tasks exponentially faster than the current classical computers~@nielsen2002quantum#cite(<shor1999polynomial>). Limited by the development of quantum hardwares, quantum computing has been at the stage of small-scale demonstrations for several decades in the past~#cite(<huang2020superconducting>). Recently, thanks to the significant progress in superconducting and photonic platforms, the long-anticipated milestone of quantum computational advantage or supremacy~@aaronson2011computational@boixo2018characterizing@bouland2019complexity@aaronson2016complexity has been achieved by using the quantum processors Sycamore~@arute2019quantum, #emph[Jiuzhang]~@zhong2020quantum@zhong2021phase, and #emph[Zuchongzhi]~@wu2021strong successively. These quantum processors with dozens of qubits reveal remarkable potential for quantum computing to offer new capabilities for near-term applications in the noisy intermediate scale quantum (NISQ) area, such as quantum simulation~@google2020hartree@mcardle2020quantum@aspuru2005simulated@bernien2017probing@zhang2017observation@zhu2021observation@chen2021observation@zha2020ergodic@yang2020quantum@cian2021many@xu2018emulating@gong2021quantum@huang2021emulating@liu2019demonstration, quantum machine learning~@huang2020experimental@havlivcek2019supervised@harrigan2021quantum@huang2018demonstration@saggio2021experimental@cong2019quantum@liu2021hybrid, and cloud quantum computing~@barz2012demonstration@huang2017experimental@huang2017universal@dumitrescu2018cloud@huang2017homomorphic#cite(<huang2018entanglement>).

Nonetheless, quantum computational advantage will be a long-term competition between classical simulation and quantum devices, rather than being a one-off experimental demonstration. During the past two years, the classical simulation algorithms keep evolving~@pednault2019leveraging@HuangChen2020@pan2021simulating@MarkovShi2008@GuoWu2019@VillalongaMandra2019@villalonga2020establishing#cite(<guo2021verifying>). In particular, it is estimated in Ref.~@HuangChen2020 that simulating Sycamore's 53-qubit and 20-cycle circuit sampling only takes about 19 days on Summit, and the exact amplitudes for 2 million correlated bitstrings were computed in 5 days by using only 60 GPUs in a recent work~@pan2021simulating, in comparison with 10,000 years as estimated in the original paper~#cite(<arute2019quantum>). Additionally, since calculating and storing the evolution of the entire state-space of the 53 qubits in random circuit sampling is still possible~@pednault2019leveraging, there is a sample-size-dependent loophole in the Google's Sycamore experiment. The development of classical algorithms and hardwares is almost about to overturn the quantum computational advantage that Sycamore has achieved. Thus, the quantum hardware needs to be continuously upgraded to maintain the quantum computational advantage. Such a long-term competition will also provide an important diagnose to benchmark the quantum computing system which is useful for eventually realizing fault-tolerant quantum computing.

In this work, a new 66-qubit two-dimensional superconducting quantum processor, called #emph[Zuchongzhi] 2.1, is designed and fabricated. Compared to #emph[Zuchongzhi] 2.0~@wu2021strong, the readout performance of #emph[Zuchongzhi] 2.1 is greatly improved to an average fidelity of 97.74%, while the single-qubit gate and the two-qubit gate have an average fidelity of 99.84% and 99.40%, respectively. Based on this state-of-the-art quantum processor, the random quantum circuit sampling with a system size up to 60 qubits and 24 cycles is realized experimentally. As estimated, the classical computational cost of simulating our sample task is about 6 orders of magnitude and 5000 times higher than that of the hardest tasks on the Sycamore ~@arute2019quantum and #emph[Zuchongzhi] 2.0 processors, respectively. Our experiment extendeds the classical simulation time of random circuit sampling experiment to tens of thousands of years, even using the state-of-the-art classical supercomputers.

= #emph[Zuchongzhi] 2.1 ------ AN UPGRADED HIGH-PERFORMANCE QUANTUM PROCESSOR
<zuchongzhi-2.1-an-upgraded-high-performance-quantum-processor>
// [figvision-cn] imgs/fig1.png
// 图a为祖冲之2.1量子处理器的立体结构示意图，展示其三维堆
// 叠结构。图像上半部分为一块透明蓝色矩形芯片（蓝宝石衬底），
// 表面布满呈网格状排列的深灰色十字形元件，代表66个超导量
// 子比特与110个耦合器；其中位于右上区域的一个十字形元件
// 被标记为红色实心圆点，表示该耦合器工作异常。下半部分为
// 另一块深蓝色芯片，其上均匀分布着金色柱状结构，每个柱子
// 顶部有圆形接触盘，对应控制线路接口；最底层为黑色基板，
// 印有黄色汉字“祖冲之号”，并有多条平行金色导线从边缘延伸
// 至上方芯片底部，体现倒装键合（flip-chip）连接方式。整
// 体布局呈现上下两层芯片垂直对齐、通过微凸点互联的结构，
// 传达器件采用双芯片集成设计以实现高密度布线与控制。 图b
// 包含两个子图：左侧为量子比特阵列简化拓扑示意图，右侧为
// 单个量子比特-耦合器-读出电路的原理电路图。左侧图中，灰
// 色交叉线段构成菱形网格，每个交叉点代表一个量子比特位置，
// 共显示约7×7局部阵列；其中一个交叉点被涂成粉红色椭圆，
// 标注为故障耦合器；相邻两个交叉点之间用浅蓝色双向箭头连
// 接，并标有“Coupler”字样，指示正常工作的可调耦合路径。
// 右侧电路图以虚线框包围，内部绿色粗线表示输入（Input）
// 和输出（Output）微波传输线，两端各有一个螺旋谐振腔作为
// 阻抗匹配结构；中间并联三个紫色方框模块，分别标注为“
// Qubit1”、“Coupler”、“Qubit2”。Qubit1和Qubit2内部均含电
// 感、电容及约瑟夫森结符号（X形叉号），Coupler模块内同样
// 含约瑟夫森结但无独立电容支路，且其上方跨接可变电容符号
// （带斜杠的电容器），表明其为可调耦合器。所有元件通过直
// 线导线连接，清晰展示三端口耦合架构中两个量子比特经由中
// 心耦合器相互作用的电气拓扑关系。
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

#figure([#block[
  #box(image("imgs/fig1.png", width: 95.0%))
  ]],
  caption: [
    #strong[Device schematic of the #emph[Zuchongzhi] 2.1 quantum processor.] (a) The #emph[Zuchongzhi] 2.1 quantum processor is composed of two sapphire chips combined by flip-chip technique, one of which has 66 qubits and 110 couplers, and the other carries all the control lines. (b) Simplified circuit schematic of the qubit, coupler and readout. The coupler marked in red in the left panel is not working properly, which can only provide fixed coupling with a coupling strength of about 7.5 MHz.
  ],
  placement: top,
)
<fig1>

// [figvision-cn] imgs/fig2_main.png
// 该图由三个并列的子图 a、b 和 c 组成，展示了选定的 60
// 个量子比特的读出性能以及单量子比特门和双量子比特门的保
// 真度误差。所有子图均为热力图（Heatmap），颜色从蓝色（
// 低误差）渐变至红色（高误差），右侧均配有垂直的颜色条标
// 尺以指示数值范围。 子图 a： 子图类型：热力图矩阵。 坐
// 标轴与布局：图像呈现为一个矩形网格，对应于量子处理器的
// 物理布局。图中未明确绘制 X 轴和 Y 轴的刻度线，但每个单
// 元格代表一个独立的量子比特。 色标与数值：右侧垂直颜色
// 条单位为百分比（%），数值范围从底部的 1 到顶部的略高于
// 3.5。深蓝色代表约 1%，白色代表约 2.5%，深红色代表约
// 3.5%。 数据内容：网格内包含 40 个彩色方块，每个方块中
// 心标注有具体的读出误差数值。数值范围从 0.9 到 3.6。其
// 中大部分区域为蓝色或浅橙色，但在网格中下部存在一个显著
// 的深红色区域，数值为 3.6，其周围分布着 3.5、3.4 等高值。
// 标注文字：子图左下角标注文本为 "Average error e_r:
// 2.26%"，表示这组量子比特的平均读出误差为 2.26%。 结论：
// 该图显示了不同量子比特间读出误差的分布情况，整体平均值
// 约为 2.26%，且存在局部误差较高的区域。 子图 b： 子图类
// 型：热力图矩阵。 坐标轴与布局：与子图 a 具有相同的网格
// 布局和形状，对应相同的 60 个量子比特位置。 色标与数值：
// 右侧垂直颜色条单位为百分比（%），数值范围从底部的 0.1
// 到顶部的 0.26。深蓝色代表 0.1%，浅灰色/白色代表 0.18%
// -0.20%，橙红色代表 0.24%-0.26%。 数据内容：网格内的数
// 值范围从 0.09 到 0.28。绝大多数方块呈现为蓝色，表明单
// 量子比特门误差较低。右下角区域出现两个较深的红色方块，
// 数值分别为 0.28 和 0.24，是图中的最高值。左上角也有少
// 量橙色方块，如 0.23。 标注文字：子图下方标注文本为 "
// Average error e_1: 0.16%"，表示单量子比特门的平均泡利
// 误差为 0.16%。 结论：该图显示单量子比特门操作在大多数
// 量子比特上表现良好，误差普遍低于 0.2%，平均值为 0.16%。
// 子图 c： 子图类型：热力图矩阵。 坐标轴与布局：图像呈现
// 为一个不规则的多边形网格，形状与典型的量子处理器耦合图
// 一致。网格中的每个方块代表连接两个量子比特的相互作用通
// 道，共计 99 个双量子比特门。 色标与数值：右侧垂直颜色
// 条单位为百分比（%），数值范围从底部的 0.2 到顶部的 1.8。
// 深蓝色代表 0.2%，浅蓝色代表 0.6%-0.8%，橙色代表 1.4%
// -1.6%，深红色代表 1.8% 以上。 数据内容：网格内的数值范
// 围从 0.19 到 2.02。大部分方块为蓝色，数值集中在 0.2 到
// 0.8 之间。图中有两个显著的异常高值点：左侧中部有一个深
// 红色方块，数值为 2.02；右侧中部偏下有一个橙红色方块，
// 数值为 1.73。此外，右下角有一个橙色方块数值为 1.32。
// 标注文字：子图下方标注文本为 "Average error e_2: 0.60%
// "，表示双量子比特门的平均泡利误差为 0.60%。 结论：该图
// 展示了双量子比特门操作的误差分布，虽然大部分门操作误差
// 较低，但存在个别连接通道的误差显著高于平均水平，拉高了
// 整体平均值至 0.60%。
#figure([#block[
  #box(image("imgs/fig2_main.png", width: 100%))
  ]],
  caption: [
    #strong[Readout, single-qubit gate and two-qubit gate performance of the selected 60 qubits.] (a) and (b) are the readout error $e_r$ and single-qubit gate pauli error $e_1$ for these 60 qubits, respectively. (c) The two qubit gate pauli error $e_2$ of the 99 two-qubit gates used. The errors are measured when operating all qubits simultaneously. The average errors of readout and quantum gates are also given in each subgraph.
  ],
  placement: top,
  scope: "parent",
)
<fig2>

#emph[Zuchongzhi] 2.1 is an upgraded version of the same generation of #emph[Zuchongzhi] 2.0~@wu2021strong (#emph[Zuchongzhi] 1.0 is used in Ref.~@gong2021quantum). #emph[Zuchongzhi] 2.1 is designed and fabricated as a $11 times 6$ two-dimensional rectangular superconducting qubit array composed of 66 Transmon qubits~@koch:042319 (see Fig.~#ref(<fig1>, supplement: none)). Except for the qubits at the boundary, each qubit has four tunable couplers to couple to its nearest neighboring qubits~@yysCouplerCZ, where the coupler is also a Transmon qubit, whose frequency several GHz higher than that of the data qubits~#cite(<yan2018tunable>). All the qubits and couplers are fabricated on a sapphire chip, and all the control lines are fabricated on another sapphire chip. These two separate sapphire chips are then stacked together with the indium bump flip-chip technique. Each qubit has a microwave drive line and a fast flux-bias line to realize full control, including state excitation and qubit frequency modulation. Each coupler is controlled by a magnetic flux bias line, to realize fast tuning of the coupling strength $g$ continually from $tilde.op + 5 med "MHz"$ to $tilde.op - 50 med "MHz"$. Except for a unfunctional coupler (see Fig.~#ref(<fig1>, supplement: none)#text("(b)")), the remaining 66 qubits and 109 couplers on the quantum processor function properly, among which 60 qubits are selected for random quantum circuit sampling experiment.

Compared with previous work~@wu2021strong, #emph[Zuchongzhi] 2.1 mainly upgrades the performance of readout. Specifically, the coupler frequency at turn-off point is significantly higher than the readout frequency, so that we don't need to reset the qubit frequency when performing measurement. After calibrating and optimizing the readout, the average single-qubit state readout error of the selected 60 qubits can reach $e_r = 2.26 %$ (Fig.~#ref(<fig2>, supplement: none)#text("(a)")). Among them, the highest readout fidelity reach 99.1%. The huge improvement in readout performance plays a key role in our realization of larger and deeper random quantum circuit sampling.

The procedures of calibration and optimization of single-qubit and two-qubit gate are similar to #emph[Zuchongzhi] 2.0~#cite(<wu2021strong>). In order to achieve parallel execution of gates, all the couplers are turned off when single-qubit gates are applied to isolate each qubit, and the required couplers are turned on only when two-qubit gates are implemented. The two-qubit gate implemented in our experiment is iSWAP-like gate~@arute2019quantum, for the purpose of random circuit sampling. The matrix form of iSWAP-like gate is: $ mat(delim: "[", 1, 0, 0, 0; 0, e^(i ( Delta_(+) + Delta_(-) )) upright("cos") theta, - i e^(i ( Delta_(+) - Delta_(- , "off") )) upright("sin") theta, 0; 0, - i e^(i ( Delta_(+) + Delta_(- , "off") )) upright("sin") theta, e^(i ( Delta_(+) - Delta_(-) )) upright("cos") theta, 0; 0, 0, 0, e^(i ( 2 Delta_(+) - phi.alt ))) , $ where the five parameters ${ theta , phi.alt , Delta_(+) , Delta_(-) , Delta_(- , "off") }$ are obtained by two-qubit gate cross-entropy benchmarking (XEB) ~@boixo2018characterizing@Neill195 fitting. The use of a stronger coupling strength ($tilde.op 14 med "MHz"$) than that ($tilde.op 10 med "MHz"$) in 2.0, the time duration of iSWAP-like gate is shorten from $tilde.op 32 med "ns"$ to $tilde.op 24 med "ns"$. The performance of quantum gates is characterized by parallel XEB, yielding the average pauli errors of 0.16% (Fig.~#ref(<fig2>, supplement: none)#text("(b)")) and 0.60% (Fig.~#ref(<fig2>, supplement: none)#text("(c)")) for single-qubit gates and two-qubit gates, respectively, in the case of all gates are applied simultaneously.

// [figvision-cn] imgs/fig3_main_new_1.png
// 该图包含三个子图（a、b、c），展示了60量子比特随机量子
// 电路的处理器拓扑结构、4区域校准方法以及不同量子比特数
// 量下的保真度结果。 子图a： 类型为示意图，展示处理器结
// 构拓扑及电路时序。 主体部分是一个由圆圈和连线构成的网
// 格状晶格结构。圆圈代表量子比特，内部标有数字编号，从左
// 下角的0开始，大致呈蛇形排列至右上角的59。其中，位于右
// 下角边缘区域的6个量子比特（编号53至58）被填充为浅灰色，
// 表示这些是被丢弃或禁用的量子比特。其余量子比特为白色填
// 充、黑色轮廓。连接量子比特的线条颜色各异，包括红色、蓝
// 色、绿色和橙色，代表两量子比特门的作用连接。 在拓扑图
// 下方，有一个放大的虚线框区域，指向主图中底部的一个局部
// 结构，并标注了“cycle 1”到“cycle m”。该区域展示了电路的
// 时间演化示意图，包含三条水平时间轴，分别标记为q0、q1、
// q2。轴上分布着不同颜色的矩形块，代表单量子比特门操作（
// 如橙色、蓝色、绿色、红色的方块）。在q0和q1之间、q1和q2
// 之间以及更右侧的位置，有垂直的粗红线跨越多条轴线，代表
// 两量子比特纠缠门操作。 文字标注包括：“cycle 1”、“cycle
// m”、“q0”、“q1”、“q2”。 该子图传达了处理器的物理连接布
// 局以及随机量子电路中门操作的序列结构。 子图b： 类型为
// 示意图，展示4区域优化（4-Patch optimization）的空间划
// 分。 图像内容与子图a中的量子比特晶格结构相同，但去除了
// 具体的量子比特编号。整个晶格被划分为四个不规则的多边形
// 区域，每个区域被填充不同的半透明颜色。左上方区域为淡粉
// 色，右上方区域为淡蓝色，左下方区域为淡绿色，右下方区域
// 为淡橙色。 图下方有一个标题为“4-Patch optimization”的
// 图例框。框内列出了四种颜色及其对应的标签：粉色对应P1，
// 蓝色对应P2，绿色对应P3，橙色对应P4。 该子图说明了将处
// 理器划分为四个独立区域进行校准优化的空间布局策略。 子
// 图c： 类型为对数坐标曲线图，展示保真度随量子比特数量的
// 变化趋势。 纵坐标轴名称为“Fidelity”（保真度），采用对
// 数刻度，范围从10^-4到10^0（即0.0001到1）。主刻度标记为
// 10^-4, 10^-3, 10^-2, 10^-1, 10^0。 横坐标轴名称为“
// Number of qubits, n”（量子比特数量，n），采用线性刻度，
// 范围从15到60。主刻度标记为15, 18, 21...直到60，间隔为3。
// 图中包含两组数据点，分别代表“Before 4-Patch Cal.”（4区
// 域校准前）和"After 4-Patch Cal."（4区域校准后）。 在“
// Before 4-Patch Cal.”组中： 灰色实心圆点代表“Full”（全
// 电路），带有垂直误差棒。 灰色叉号（x）代表“Patch”（区
// 域电路）。 灰色空心圆点代表“Elided”（省略电路）。 在"
// After 4-Patch Cal."组中： 红色实心圆点代表“Full”，带有
// 垂直误差棒。 蓝色加号（+）代表“Patch”。 绿色叉号（x）
// 代表“Elided”。 此外，图中还有一条黑色实线，标记为“
// Estimated”（估计值），穿过所有数据点的大致中心趋势。
// 所有数据点均显示出随着量子比特数量n的增加，保真度呈下
// 降趋势。经过4区域校准后的红色、蓝色和绿色数据点整体位
// 于校准前的灰色数据点上方，表明校准提高了保真度。 图的
// 左下角嵌入了一个子图，标题为“m = 10”。该子图包含三个小
// 的晶格示意图，从左到右分别标记为“Full Circuit”、“
// Elided Circuit”和“Patch Circuit”。 “Full Circuit”显示
// 完整的60量子比特晶格，所有节点均为彩色。 “Elided
// Circuit”显示同样的晶格，但部分边缘节点的连线被移除或淡
// 化。 “Patch Circuit”显示晶格的中间部分，边缘部分被截断
// 或变灰。 这三个小图直观地解释了三种不同电路配置（全电
// 路、省略电路、区域电路）的结构差异。
#figure([#block[
  #box(image("imgs/fig3_main_new_1.png"))
  ]],
  caption: [
    #strong[60-qubit random quantum circuit, 4-patch calibration, and results of cirucit with 15-60 qubits and 10-cycle.] (a) In the processor structure topology diagram, the circles represent qubits, and the discarded qubits are marked with a shaded colour. The single-qubit gates in the random quantum circuit are chosen randomly from the set of ${ sqrt(X) , sqrt(Y) , sqrt(W) }$. The orange, blue, green, and red lines represent the two-qubit gates of the four patterns A, B, C, and D respectively. (b) We divide the circuit into 4 patches as shown, and optimize the parameters of iSWAP gates in each patch. (c) The XEB fidelities of cirucit with 15-60 qubits and 10-cycle before and after 4-patch calibration. Each data point, including the results from full circuit, patch circuit, and elided circuit, is an average over nine quantum circuit instances. The predicted fidelity result is shown as a black line labeled by "Estimated", which is calculated from a simple multiplication of individual operation. The gray line labeled by "Fitting" is the exponential fit of the fidelities before 4-patch calibration. Whether it's before or after 4-patch calibration, the fidelities of the patch and elided circuits are in good agreement with those of the full circuit. And after the 4-patch calibration, the fidelity of each circuit can be significantly improved, and is highly consistent with the predicted fidelity.
  ],
  placement: top,
  scope: "parent",
)
<fig3>

// [figvision-cn] imgs/fig4_main.png
// 该图由五个子图（a、b、c、d、e）组成，展示了60量子比特
// 随机量子电路在量子计算优势区域的实验结果。 子图a： 类
// 型：对数坐标下的散点拟合图。 坐标轴：横轴为“Cycle, m”
// （周期数），范围从12到24；纵轴为“Fidelity”（保真度），
// 采用对数刻度，范围从10^-4到10^0。 数据与符号：图中包含
// 蓝色加号标记的数据点和绿色叉号标记的数据点，分别代表“
// Patch”和“Elided”两种电路的保真度测量值。每个数据点均带
// 有垂直误差棒，表示三个标准差。一条黑色实线穿过这些数据
// 点，代表拟合曲线。 标注：左上角有粗体字母“a”。图中央左
// 侧有文字“n = 60 qubits”。右上角图例标明黑色实线为“
// Fitting”，蓝色加号为“Patch”，绿色叉号为“Elided”。 趋势：
// 随着周期数m的增加，保真度呈指数下降趋势。 子图b： 类型：
// 散点分布图。 坐标轴：横轴为“Circuit instance”（电路实
// 例编号），范围从1到12；纵轴为“Fidelity”（保真度），采
// 用对数刻度，范围从10^-3到10^-2。 数据与区域：图中包含
// 一系列绿色实心圆点，代表不同电路实例的保真度。背景有一
// 个淡红色水平带状区域，上下边界由虚线标示，代表“±σ
// _single”的范围。一条水平虚线穿过红色区域中心。 标注：
// 左上角有粗体字母“b”。顶部标题为“m=16, Fidelity = 0.381%
// ”。图内右下角图例标明虚线为“Fitting”，绿色圆点为“
// Elided”，红色区域为“±σ_single”。 趋势：在周期数为16时，
// 各电路实例的保真度分布在0.381%附近。 子图c： 类型：散
// 点分布图。 坐标轴：横轴为“Circuit instance”，范围从1到
// 12；纵轴为“Fidelity”，采用对数刻度，范围从10^-3到10^-2。
// 数据与区域：包含绿色实心圆点，以及一个比子图b更低的淡
// 红色水平带状区域和中心水平虚线。 标注：左上角有粗体字
// 母“c”。顶部标题为“m=20, Fidelity = 0.134%”。 趋势：在
// 周期数为20时，平均保真度下降至0.134%，数据点波动范围依
// 然覆盖在红色区域内。 子图d： 类型：散点分布图。 坐标轴：
// 横轴为“Circuit instance”，范围从1到12；纵轴为“Fidelity
// ”，采用对数刻度，范围从10^-3到10^-2。 数据与区域：包含
// 绿色实心圆点，以及一个位置更低的淡红色水平带状区域和中
// 心水平虚线。 标注：左上角有粗体字母“d”。顶部标题为“m=
// 22, Fidelity = 0.0758%”。 趋势：在周期数为22时，平均保
// 真度进一步下降至0.0758%。 子图e： 类型：散点分布图。
// 坐标轴：横轴为“Circuit instance”，范围从1到12；纵轴为“
// Fidelity”，采用对数刻度，范围从10^-4到10^-3。 数据与区
// 域：包含绿色实心圆点，以及一个位置最低的淡红色水平带状
// 区域和中心水平虚线。 标注：左上角有粗体字母“e”。顶部标
// 题为“m=24, Fidelity = 0.0366%”。 趋势：在周期数为24时，
// 平均保真度降至最低点0.0366%。 总体结论：该组图通过子图
// a展示了60量子比特系统的保真度随电路深度（周期数）增加
// 而指数衰减的整体规律；子图b至e则详细展示了在不同特定周
// 期数（16、20、22、24）下，12个独立电路实例的保真度具体
// 分布情况，验证了随着周期数增加，系统保真度显著降低的实
// 验事实。
#figure([#block[
  #box(image("imgs/fig4_main.png", width: 98.0%))
  ]],
  caption: [
    #strong[Experimental results of random quantum circuits in the quantum computational advantage regime.] (a) Results of random quantum circuits with 60 qubits and 12-24 cycles. Each data point denotes the average fidelity of the patch or elided circuit over 12 distinct quantum circuit instances, as an estimate of the fidelity of the full circuit. The error bar denotes three standard deviations. For each 60-qubit 24-cycle circuit instance, about 70 million bitstrings are sampled in 4.2 hours (1 million samples per 210 seconds). (b), (c), (d), and (e) show the fidelity of each individual 16-cycle, 20-cycle, 22-cycle, and 22-cycle elided circuit instance, respectively. The band corresponding to $plus.minus overline(sigma_("single"))$, which is the mean statistical error bar of the 12 instances.
  ],
  placement: top,
  scope: "parent",
)
<fig4>

= 60-QUBIT RANDOM CIRCUIT SAMPLING
<qubit-random-circuit-sampling>
After the basic calibration, we implement random quantum circuit sampling to characterize the overall performance of the quantum processor, and measure the degree of quantum computational advantage. The gate sequence of our random quantum circuit is shown in Fig.~#ref(<fig3>, supplement: none)#text("(a)"). Each cycle consists of a layer of single-qubit gates randomly selected from set ${ sqrt(X) , sqrt(Y) , sqrt(W) }$ and applied to all qubits, followed by a layer of two-qubit iSWAP-like gates. The two-qubit gates in each two-qubit gate layer are applied according to a specified pattern, labeled by A, B, C, and D, and the layer is implemented in the sequence of ABCDCDAB in each cycle.

In general, the verification of large-scale random quantum circuit is done through two variant circuits, named patch circuit and elided circuit, which are designed by removing a slice of two-qubit gates and only a fraction of the gates between the patches, respectively. As the first step of the experiment, we first evaluate whether these two verification methods are applicable on this quantum processor. We implement these two variant circuits and full version of the circuits ranging from 15 qubits to 60 qubits with 10 cycles, and calculate the linear XEB fidelities $F_("XEB")$ of the respective output bitstrings. Experimental results (see Fig.~#ref(<fig3>, supplement: none)#text("(c)")) show that the average ratio of patch circuit and elided circuit fidelities to full circuit fidelity are 1.09 and 1.13, indicating the effectiveness of these two verification circuits.

However, the fidelity of all circuits appears lower than the predicted fidelity calculated from a simple multiplication of individual operations. This is due to the additional error caused by our control method. In #emph[Zuchongzhi] 2.1, the coupler and qubit are placed at their original frequencies most of the time, and then detuned to the idle frequencies within a few microseconds before and during the experiment, and finally detuned back to their original frequencies after the readout pulse ends (#emph[Zuchongzhi] 2.0 uses DC pulse to keep the qubit and coupler at the idle frequencies all the time.). The distortion of the square pulse causes qubit frequency and coupling strength continuously change slightly during the operation time. To mitigate this effect, the square pulses on the qubit are calibrated. However, the calibration of square pulses on coupler is not performed, due to the frequency of the couplers is too high. This causes the parameters of iSWAP-like gate obtained by the two-qubit XEB to be slightly inaccurate for shallow circuits.

We develop a new calibration method, called 4-patch calibration, to search the optimal parameters of the iSWAP-like gate, based on the original gate parameters obtained by the two-qubit XEB. We divide the full circuit into $4$ non-overlapping patches, which nevertheless covers all the iSWAP gates. Then we sample the bitstrings of the 4 patch circuits separately, and use the sampled bitstrings as the training set $b_("train")$. For each patch, we use a gradient-based machine learning to optimize the parameters of the iSWAP gates it contains. Specifically, we consider the set $gamma = { arrow(gamma)_1 , . . . , arrow(gamma)_(n g) }$ as trainable parameters, where $arrow(gamma)_i = ( theta^i , phi.alt^i , Delta_(+)^i , Delta_(-)^i , Delta_(- , "off")^i )$ is the parameters of $i$-th iSWAP gate, and $n g$ is the total number of iSWAP gates in this patch. By minimizing the loss function $ "Loss"_("XEB") ( gamma , b_("train") ) = 1 - F_("XEB") ( gamma , b_("train") ) , $<eq:loss> using the BFGS optimizer, we are able to find the optimal parameters of each iSWAP for this patch, where $F_("XEB") ( gamma , b_("train") )$ is the linear XEB fidelity of chosen patch. All these trainings are implemented on a classical computer, and thus we can compute the gradient of @eq:loss using the classical auto-differentiation framework. By separately training the parameters of the iSWAP gate in the 4 patches, the optimized parameters of all the iSWAP gates are obtained. After 4-patch calibration, we re-calculate the XEB fidelities of all of the circuits in Fig.~#ref(<fig3>, supplement: none)#text("(c)") using the the optimized two-qubit gate parameters. Results show that all of these fidelities have been greatly improved and match the predicted fidelities quite well (see Fig.~#ref(<fig3>, supplement: none)#text("(c)")), indicating that the optimized parameters have adaptability to different quantum circuits. Furthermore, The behavior of two variant circuits are more consistent with full circuits, where the the average ratio of patch circuit and elided circuit fidelities to full circuit fidelity are improved to 1.05 and 1.07, respectively. Since the cirucit is split into 4 patches for training, our 4-patch calibration method can be efficiently implemented on the classical computer. For larger circuits, our method can easily be modified into $n$-patch calibration to maintain its efficiency.

#figure(
  text(size: 7pt, table(
    columns: (1.3fr, 1.05fr, 0.68fr, 0.8fr, 1.02fr, 0.95fr, 0.95fr, 0.8fr, 1.05fr),
    align: (left, left, center, center, center, center, center, center, center),
    inset: 2.5pt,
    stroke: none,
    table.header(
      [Processor], [Circuit], [Fidelity], [\# of bitstrings],
      [FPOs #linebreak() (perfect sample)], [FPOs #linebreak() (circuit)],
      [Runtime on #linebreak() Summit], [Runtime on #linebreak() QPU],
      [Classical Runtime #linebreak() Quantum Runtime],
    ),
    table.hline(stroke: 0.8pt),
    [Sycamore@arute2019quantum], [53-qubit 20-cycle], [$0.224%$], [$3.0 times 10^6$], [$1.63 times 10^18$], [$1.10 times 10^22$], [15.9 days], [600 s], [$2.29 times 10^3$],
    [#emph[Zuchongzhi] 2.0@wu2021strong], [56-qubit 20-cycle], [$0.0662%$], [$1.9 times 10^7$], [$1.65 times 10^20$], [$2.08 times 10^24$], [8.2 years], [1.2 h], [$6.02 times 10^4$],
    [#emph[Zuchongzhi] 2.1], [60-qubit 22-cycle], [$0.0758%$], [$1.5 times 10^7$], [$1.06 times 10^22$], [$1.21 times 10^26$], [$4.8 times 10^2$ years], [1 h], [$4.21 times 10^6$],
    [#emph[Zuchongzhi] 2.1], [60-qubit 24-cycle], [$0.0366%$], [$7.0 times 10^7$], [$4.68 times 10^23$], [$1.2 times 10^28$], [$4.8 times 10^4$ years], [4.2 h], [$9.93 times 10^7$],
    table.hline(stroke: 0.8pt),
  )),
  caption: [The runtime of tensor network algorithm for different circuits on Summit. The classical simulation consumption estimation of the random quantum circuit sampling experiment on the Sycamore, #emph[Zuchongzhi] 2.0, and #emph[Zuchongzhi] 2.1 processors are provided. FPOs is the abbreviation for the number of floating point operations, QPU is the abbreviation for quantum processing unit.],
  kind: table,
  placement: top,
  scope: "parent",
) <tab:TNC>
We sample the output bitstrings of 60-qubit full, patch, and elided circuits with increasing depth from 12 to 24 cycles , and employ patch and elided circuits to estimate the performance of full circuit. At each system size, a total of 12 randomly generated circuit instances are executed. Figure~#ref(<fig4>, supplement: none)#text("(a)") shows the XEB fidelities of patch and elided circuits. For the largest circuit with 60 qubits and 24 cycles, we collect approximately $7.0 times 10^7$ bitstrings for each circuit instance, and the combined linear XEB fidelity of theses 12 elided circuit instances are calculated as $F_("XEB") = ( 3.66 plus.minus 0.345 ) times 10^(- 4)$. Thus, with high statistical significance ($> 10 sigma$), the null hypothesis of uniform sampling ($F_("XEB") = 0$) is rejected.

= COMPUTATIONAL COST ESTIMATION
<computational-cost-estimation>
We employ the state-of-the-art classical algorithm, tensor network algorithm~@MarkovShi2008@GuoWu2019@VillalongaMandra2019@villalonga2020establishing@HuangChen2020@pan2021simulating@guo2021verifying, to estimate the classical computational cost of our largest circuit with 60 qubits and 24 cycles. The number of floating point operations to generate one perfect sample from the $60$-qubit 24-cycle random circuit are estimated as $1.63 times 10^18$ by the python package cotengra~@cotengra (see Supplemental Material for details). Thus, it would cost a total of $1.10 times 10^22$ floating point operations to reproduce the same results of this hardest circuit ($7.0 times 10^7$ bitstrings, 0.0366% fidelity) using classical computer. @tab:TNC also shows the extrapolated run times for Sycamore's 53-qubit 20-cycle circuit ~@arute2019quantum and #emph[Zuchongzhi] 2.0's 56-qubit 20-cycle circuit using tensor network algorithm.

As shown in @tab:TNC, using the tensor network algorithm, the classical computational cost of our sample task with 60-qubit and 24-cycle is about 6 orders of magnitude and 5000 times higher than that of the hardest tasks on the Sycamore and #emph[Zuchongzhi] 2.0 processor~@wu2021strong, respectively. The random circuit sampling task with 60-qubit and 24-cycles, achieved by #emph[Zuchongzhi] 2.1 in 4.2 hours, would cost Summit 48,000 years to simulate.

= CONCLUSION
<sec:summary>
In conclusion, the high-performance superconducting quantum computing system #emph[Zuchongzhi] 2.1 has achieved a larger-scale random quantum circuit sampling with 60-qubit and 24-cycle, yielding a Hilbert space dimension up to $2^60$. Compared with #emph[Zuchongzhi] 2.0, our sampling task is about 5000 times more difficult in classical simulation, thus the quantum computational advantage has been significantly enhanced. Our future work would be to investigate the practical applications of random quantum circuits on NISQ devices, such as certified random bits~@aaronson2018certified, error correction~@gullans2020quantum, and hydrodynamics simulation~@richter2021simulating, beyond the abstract sampling task.

#block[
We thank Run-Ze Liu, Wen Liu, Chenggang Zhou for very helpful discussions and assistance. The classical calculations were performed on the supercomputing system in the Supercomputing Center of University of Science and Technology of China. The design and quality check of the sample are completed using SQCEDA packages (https://github.com/sqceda). The authors thank the USTC Center for Micro- and Nanoscale Research and Fabrication for supporting the sample fabrication. The authors also thank QuantumCTek Co., Ltd., for supporting the fabrication and the maintenance of room-temperature electronics. #strong[Funding:] This research was supported by the National Key R&D Program of China (Grant No. 2017YFA0304300), the Chinese Academy of Sciences, Anhui Initiative in Quantum Information Technologies, Technology Committee of Shanghai Municipality, National Natural Science Foundation of China (Grants No. 11905217, No. 11774326, Grants No. 11905294), Shanghai Municipal Science and Technology Major Project (Grant No. 2019SHZDZX01), Natural Science Foundation of Shanghai (Grant No. 19ZR1462700), Key-Area Research and Development Program of Guangdong Provice (Grant No. 2020B0303030001), and the Youth Talent Lifting Project (Grant No. 2020-JCJQ-QT-030).

The authors' names appear in alphabetical order by last name.

]

#bibliography("refs.bib", style: "ieee", title: none)

]

#pagebreak()
#align(center)[#text(12pt, weight: "bold", [Supplemental Material for “Quantum Computational Advantage via 60-Qubit 24-Cycle Random Circuit Sampling”])]
#v(0.8em)

#counter(heading).update(0)
#counter(math.equation).update(0)
#set heading(numbering: "1.1.1")
#set math.equation(numbering: n => "(S" + str(n) + ")")

#columns(2, gutter: 0.6cm)[

Since most of the methods of calibration and result analysis have been provided in the Ref.~#cite(<wu2021strong>) of _Zuchongzhi_ 2.0, in this supplemental material, we will list the relevant results of _Zuchongzhi_ 2.1 without describing too many details about the method. Interested readers may refer to the Ref.~#cite(<wu2021strong>) for more details about the method used.

= QUANTUM PROCESSOR
<supp:quantum-processor>
Our device is a 66-qubit superconducting programmable quantum processor, consisting of $66$ Transmon qubits~#cite(<koch:042319>) and $110$ tunable couplers~#cite(<yysCouplerCZ>), which is similar to _Zuchongzhi_ 2.0~#cite(<wu2021strong>). Each qubit is inductively coupled to a control line for both XY and Z control, and capacitively coupled to a separate $lambda / 4$ readout resonator which is coupled to a $lambda / 2$ bandpass filter~#cite(<PhysRevLett.112.190504>) #cite(<zhu2021observation>) for fast and high fidelity readout. Each qubit is tunably coupled to one of its nearest neighbor qubits with a coupler which can tune coupling strength from about $+5$ MHz to about $-50$ MHz, except for the coupler between qubit $Q_(22)$ and $Q_(15)$ which does not work well. With the tunable coupler, we can tune off the qubit-qubit coupling when qubit at idle, and tune on the coupling when performing two-qubit gates. The coupling strength we used to perform two-qubit gates is about $-14$ MHz. Steps of fabrication are same with _Zuchongzhi_ 2.0, which will not be described here.

= EXPERIMENTAL WIRING
<supp:experimental-wiring>
The experimental wiring setup for qubit $slash$ coupler control and frequency-multiplexed readout of cryogenic system and the configuration of room temperature electronics are same with the setup of _Zuchongzhi_ 2.0~#cite(<wu2021strong>). The room temperature electronics used in this experiment includes 330 DAC channels, 11 ADC channels, 11 DC channels and 32 microwave source channels. All experiments are performed in a dilution refrigerator at base temperature of 20 mK with a magnetic field shield.

= GATE PERFORMANCE AND READOUT
<supp:gate-performance>
== Basic calibration on 66 qubits
<supp:basic-calibration>

The basic calibration steps of the processor are also the same with _Zuchongzhi_ 2.0, all 66 qubits, 110 couplers, 66 readout resonators and 11 JPAs are involved in this process. One can see more details about the procedure in Ref.~#cite(<wu2021strong>). The maximum frequencies $f_(01)^"Max"$ of the all 66 qubits are shown in Fig. S3.
The coupler between qubit $Q_(22)$ and $Q_(15)$ does not work properly, so there are 109 couplers which we can use to tune the coupling strength between near-neighbor qubits in this processor.

== Fine-tune on 60 qubits
<supp:fine-tune>

For technical and theory reasons, we select $60$ qubits in the device and set other qubits' frequencies far away from these qubits to avoid residual coupling. We then perform accurate calibration on these 60 qubits. After fine measurement of $T_1$ and XY crosstalk, we preliminary set a suitable idle frequency distribution. However, we find that the $T_1$ performance at idle frequency may change significantly during the experiment. Thus, we quickly measure these qubits' $T_1$ and $T_2^*$ near idle frequencies in parallel and then adjust the idle frequency distribution if the coherence performance of qubits decreases.

=== Readout Calibration
<supp:readout-calibration>
All selected qubits are placed at idle frequencies during measurement. Readout fidelity of each qubit is measured after qubits are prepared at $|00, dots.c, 0 chevron.r$ or $|11, dots.c, 1 chevron.r$. To reduce the influence of energy relaxation and enhance the effective lifetime, we drive the qubits into $|2 chevron.r$ from $|1 chevron.r$ before readout~#cite(<Elder_2020>). By applying this technology, we can achieve average readout fidelity of 97.74%. To evaluate the performance of joint readout, we randomly prepare the qubits states $|s_1, s_2, dots.c, s_(60) chevron.r$, where $s_i = 0$ or $1$, and measure these randomly states to obtain the average joint read fidelity, corresponding to 0.2304.

=== Single-Qubit Gate Calibration
<supp:single-qubit-calibration>
Couplers and qubits are placed at their original frequencies at most time and then detuned to idle frequencies several microseconds before and during the experiment and finally detuned back to their original frequencies after the readout pulses end. Due to this control method, we find qubit frequency and coupling strength may vary slightly during the operation time, which may reduce the following single-qubit gate fidelity. To mitigate this effect, we measure the qubit frequency variation and then calibrate the square pulse. In Fig. S1, we show our ramsey test pulse to measure z control pulse distortion and the phase before (after) calibration. After this calibration, we measure the single-qubit gate fidelity for isolated operation and simultaneous operation by cross-entropy benchmarking (XEB)~#cite(<arute2019quantum>), see Table S1. The difference between isolated fidelity and simultaneous fidelity is caused by XY crosstalk and residual coupling strength.

// [figvision-cn] imgs/supp/xzTailCalibration.png
// 子图a为脉冲序列示意图，展示Z控制脉冲畸变校准的实验时序。
// 图中横轴表示时间（无具体单位标注，但相对间隔明确），纵
// 轴表示信号幅度（未标数值）。从左至右依次为：一个蓝色矩
// 形脉冲标记为“Z detune pulse”，其后经过一段双向箭头标注
// 的“Delay time”延迟；接着是一个红色振荡波形包络，标记为
// “X/2 pulse”，该脉冲被两条垂直虚线框出；随后是0.4微秒的
// 时间间隔（由双向箭头标注）；再出现第二个相同的红色“X/2
// pulse”；最后是一段绿色高频振荡波形，标记为“Readout
// pulse”。所有脉冲均沿同一水平基线排列，Z detune pulse和
// Readout pulse为方波形式，X/2 pulse为正弦调制包络，颜色
// 区分不同功能模块。 子图b为热图，标题为“Phase before
// calibration”。横轴为“Qubit Index”，范围从约1到60，无单
// 位；纵轴为“Delay time (μs)”，范围从5到30微秒。右侧设有
// 垂直色条，单位为“(rad)”，范围从-3（深蓝色）到+3（深红
// 色），中间0值为黄绿色。图中呈现明显的竖直条纹结构：在
// Qubit Index约为18、27、36、45、54等位置，存在贯穿整个
// 延迟时间范围的强相位调制带，表现为红蓝交替或高对比度色
// 彩变化，表明这些量子比特在校准前对延迟时间敏感且相位响
// 应剧烈波动。其余区域以黄绿为主，相位接近零。整体趋势显
// 示校准前相位随量子比特索引呈周期性剧烈震荡，与延迟时间
// 耦合明显。 子图c为热图，标题为“Phase after calibration
// ”。坐标轴定义同子图b：横轴“Qubit Index”（1–60），纵轴“
// Delay time (μs)”（5–30 μs），右侧色条相同（-3 rad 至 +
// 3 rad）。图中几乎全为均匀的浅绿色，代表相位值稳定在0弧
// 度附近，无明显竖直条纹或局部极值。仅在极少数像素点有轻
// 微黄色或青色斑点，幅度远小于子图b中的波动。结论：校准
// 后，所有量子比特在不同延迟时间下的相位响应趋于一致且平
// 坦，消除了此前观察到的系统性畸变，表明Z控制脉冲畸变已
// 被有效校正。
#figure(
  image("imgs/supp/xzTailCalibration.png", width: 92%),
  numbering: none,
  caption: [FIG. S1. *Z control pulse distortion calibration.* *a,* Pulse sequence of the z control pulse distortion calibration. *b,* Phase before calibration. *c,* Phase after calibration.],
) <fig:supp-xztail>

// [figvision-cn] imgs/supp/hf_error_1q_population.png
// 该图像包含两个垂直排列的子图，分别标记为a和b。 子图a
// 子图类型：曲线图（积分直方图）。 坐标轴：纵轴名称为“
// Integrated histogram”，范围从0到1，刻度间隔为0.2。横轴
// 名称为“Single qubit gate error rate”，范围从0到4，刻度
// 间隔为1，单位标注在轴末端为“x 10^-3”。 曲线与图例：图
// 中包含四条从左下向右上延伸的S形曲线，均位于图的右侧区
// 域有图例说明。 第一条曲线为绿色虚线，标记为“Purity
// isolated”。该曲线起始于横坐标约0.8 x 10^-3处，在横坐标
// 约1.5 x 10^-3处达到纵坐标0.9。 第二条曲线为青色点状虚
// 线，标记为“XEB isolated”。该曲线起始于横坐标约0.9 x 10
// ^-3处，位于绿色虚线的右侧，在横坐标约2.0 x 10^-3处达到
// 纵坐标0.9。 第三条曲线为绿色实线，标记为“Purity
// simultaneous”。该曲线位于绿色虚线的右侧，起始于横坐标
// 约0.9 x 10^-3处，在横坐标约2.0 x 10^-3处达到纵坐标0.9。
// 第四条曲线为青色实线，标记为“XEB simultaneous”。该曲线
// 位于所有曲线的最右侧，起始于横坐标约1.0 x 10^-3处，在
// 横坐标约2.5 x 10^-3处达到纵坐标0.9。 趋势与结论：所有
// 曲线显示单量子比特门错误率的累积分布。对于每种测量方法
// （纯度Purity或随机基准测试XEB），同时运行（
// simultaneous，实线）的错误率分布均比独立运行（isolated，
// 虚线）更偏向高错误率一侧。此外，XEB测量的错误率普遍高
// 于纯度测量。 子图b 子图类型：曲线图（积分直方图）。 坐
// 标轴：纵轴名称为“Integrated histogram”，范围从0到1，刻
// 度间隔为0.2。横轴名称为“Readout error rate”，范围从0到
// 0.08，刻度间隔为0.02。 曲线与图例：图中包含两组曲线，
// 左侧为蓝色系，右侧为红色系。图例位于图的右侧。 第一组
// 曲线（蓝色）：对应基态|0>的读出错误。其中一条为蓝色点
// 状虚线，标记为“e|0> isolated”；另一条为蓝色实线，标记
// 为“e|0> simultaneous”。两条曲线几乎重合，起始于横坐标
// 接近0处，在横坐标约0.03处达到纵坐标1.0。曲线附近标有蓝
// 色的文字“e|0>”。 第二组曲线（红色）：对应激发态|1>的读
// 出错误。其中一条为红色点状虚线，标记为“e|1> isolated”；
// 另一条为红色实线，标记为“e|1> simultaneous”。这两条曲
// 线位于蓝色曲线的右侧，起始于横坐标约0.01处，在横坐标约
// 0.06处达到纵坐标1.0。红色实线略微位于红色虚线的左侧。
// 曲线附近标有红色的文字“e|1>”。 趋势与结论：所有曲线显
// 示读出错误率的累积分布。基态|0>的读出错误率显著低于激
// 发态|1>。对于两种状态，同时运行（实线）与独立运行（虚
// 线）的结果差异很小，曲线基本重叠。
#figure(
  image("imgs/supp/hf_error_1q_population.png", width: 92%),
  numbering: none,
  caption: [FIG. S2. *Single-qubit gates XEB and readout errors.* *a,* Integrated histograms of single-qubit gates Pauli error $e_1$. The dotted line represent isolated results, and the line represent simultaneous results. *b,* Integrated histograms of readout errors $e_(|0 chevron.r)$ and $e_(|1 chevron.r)$.],
) <fig:supp-hf1q>

// [figvision-cn] imgs/supp/figS1-66bit.png
// 子图a： 类型：二维热图（Heatmap），用于展示66个量子比
// 特在空间网格上的平均退相干时间分布。 布局与结构：图像
// 主体为一个11行6列的矩形网格，共包含66个方形单元格，每
// 个单元格代表一个独立的量子比特。 坐标轴：该图没有显式
// 的X轴和Y轴刻度或标签，而是通过网格位置隐含了量子比特的
// 物理排布。 颜色标尺：右侧设有一个垂直的颜色条（
// Colorbar）。顶部标注单位为微秒（$\mu s$）。色条范围从
// 底部的5到顶部的30，中间刻度分别为10、15、20、25。颜色
// 映射采用红蓝渐变方案：深红色对应高数值（约30 $\mu s$），
// 浅橙色/米色对应中等数值（约20-25 $\mu s$），浅蓝色对应
// 较低数值（约10-15 $\mu s$），深蓝色对应最低数值（约5 $
// \mu s$）。 数据内容：每个网格单元内部标有黑色的具体数
// 值，表示该位置量子比特的平均 $T_1$ 时间。例如，第一行
// 从左至右的数值依次为17, 20, 24, 22, 31, 3；其中数值“3”
// 所在的单元格为深蓝色，数值“31”所在的单元格为深红色。大
// 部分单元格的数值分布在18到26之间，呈现浅橙色或米色。
// 底部文字：子图下方有一行黑色加粗文字：“Average $T_1$:
// 21.1 $\mu s$”，总结了所有66个量子比特的平均性能指标。
// 子图b： 类型：二维热图（Heatmap），用于展示与子图a相同
// 位置的66个量子比特的最大频率分布。 布局与结构：图像主
// 体同样为一个11行6列的矩形网格，其空间排列顺序与子图a完
// 全一致，以便进行对比。 坐标轴：无显式坐标轴，依赖网格
// 位置。 颜色标尺：右侧设有一个垂直的颜色条（Colorbar）。
// 顶部标注单位为吉赫兹（GHz）。色条范围从底部的4.8到顶部
// 的5.3以上，中间刻度分别为4.9, 5.0, 5.1, 5.2。颜色映射
// 同样采用红蓝渐变方案：深红色对应高频（>5.3 GHz），浅橙
// 色对应中频（~5.1-5.2 GHz），浅蓝色对应低频（~4.9-5.0
// GHz），深蓝色对应最低频（~4.8 GHz）。 数据内容：每个网
// 格单元内部标有黑色的具体数值，保留三位小数，表示该位置
// 量子比特的最大频率。例如，第一行从左至右的数值依次为
// 5.372, 5.149, 5.034, 5.177, 4.879, 5.145。其中左上角的
// “5.372”为深红色，显示最高频率；第二行最右侧的“4.860”为
// 深蓝色，显示较低频率。整体来看，大部分数值集中在5.0到
// 5.2 GHz之间。 底部文字：子图下方有一行黑色加粗文字：“
// Qubit maximum frequency (GHz)”，说明了该热力图的物理量
// 及其单位。
#figure(
  image("imgs/supp/figS1-66bit.png", width: 74%),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [FIG. S3. *Average 2D $T_1$ and qubit maximum frequency of 66 qubits.*],
) <fig:supp-s3>

// [figvision-cn] imgs/supp/figS3-99coupler.png
// 该图包含两个并列的子图，分别标记为 a 和 b，展示了99个
// 耦合器的量子比特共振频率分布和纯度误差分布。 子图 a：
// 类型：热力图（Heatmap）。 布局：一个由10行10列方格组成
// 的网格（右下角最后一个位置为空），每个方格代表一个耦合
// 器。 坐标轴：无显式X轴或Y轴刻度线，但底部标注文字“
// Resonance frequency (GHz)”表明数据物理量。 色标：位于
// 子图右侧的垂直颜色条。顶部数值为5.05，底部数值为4.8，
// 单位为GHz。颜色从底部的深蓝色渐变至顶部的深红色，中间
// 经过浅蓝、灰白、浅橙过渡。 数据内容：网格内的每个方格
// 填充有特定颜色并标注了具体的数值。数值范围大致在4.773
// 到5.045之间。 具体数值分布趋势： 左上角区域数值较低，
// 如第一行前四个数值分别为4.909, 4.910, 4.845, 4.930，颜
// 色偏蓝。 左侧中部有一块明显的暖色（橙色/红色）区域，例
// 如第6行第1列为5.013，第9行第2列为5.035。 右上角区域存
// 在高值，如第1行第6列为5.002，第1行第7列为5.009。 右侧
// 中部及下部也有分散的高值点，如第8行第10列为5.045（全图
// 最高值之一，呈深红色）。 整体来看，数值分布不均匀，既
// 有集中在4.8-4.9 GHz的蓝色区域，也有分布在5.0 GHz以上的
// 红色区域。 子图 b： 类型：热力图（Heatmap）。 布局：与
// 子图a相同的10x10网格布局，对应相同的耦合器排列。 坐标
// 轴：底部标注文字“Average 2Q purity error: 0.51%”，表明
// 图中展示的是平均双量子比特纯度误差，且所有数据的平均值
// 约为0.51%。 色标：位于子图右侧的垂直颜色条。顶部数值为
// 1.4，底部数值为0.2，单位符号为%。颜色同样采用从深蓝（
// 低误差）到深红（高误差）的渐变。 数据内容：网格内每个
// 方格标注了百分比数值。 具体数值分布趋势： 绝大多数方格
// 呈现不同深浅的蓝色，表示误差值较低，大部分数值在0.2%到
// 0.7%之间。 存在几个显著的异常高值点（红色/橙色）： 第2
// 行第2列数值为1.40（全图最高值，呈深红色）。 第10行第4
// 列数值为1.60（全图最高值，呈深红色）。 第6行第6列数值
// 为1.10（呈橙色）。 其余部分数值较为均匀地分布在0.20至
// 0.91之间，其中第9行第2列数值为0.91（浅灰色/淡橙色）。
// 结论：该子图显示大多数耦合器的平均双量子比特纯度误差较
// 低（<0.5%），但在少数特定位置出现了显著升高的误差（>
// 1.0%）。
#figure(
  image("imgs/supp/figS3-99coupler.png", width: 86%),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [FIG. S4. *The qubit resonance frequencies and Purity error distribution of 99 couplers.*],
) <fig:supp-s4>

// [figvision-cn] imgs/supp/figS2-60bit.png
// 该图包含六个子图（a至f），以2行3列的网格布局排列，展示
// 了60个量子比特在特定参数上的分布情况。每个子图均由一个
// 10行6列的彩色矩阵和右侧对应的垂直颜色条组成，矩阵中的
// 每个单元格代表一个量子比特的数值，颜色深浅表示数值大小。
// 子图 a： 类型：热力图（Heatmap）。 标题：Qubit idle
// frequency (GHz)。 坐标轴与范围：无显式坐标轴，数据范围
// 为4.771 GHz至5.037 GHz。 色标：右侧垂直颜色条，单位(
// GHz)，范围从4.8到5.05。颜色由底部的蓝色渐变至顶部的红
// 色，分别代表低频和高频。 内容描述：矩阵内填充了具体的
// 频率数值。大部分数值集中在4.900至4.980之间。左下角区域
// 存在几个明显的低值点（如4.771, 4.760, 4.766），显示为
// 深蓝色；右上角区域存在高值点（如5.037, 5.030），显示为
// 红色。整体呈现出一定的空间不均匀性。 子图 b： 类型：热
// 力图（Heatmap）。 标题：Qubit anharmonicity (MHz)。 坐
// 标轴与范围：无显式坐标轴，数据范围为-262 MHz至-239 MHz。
// 色标：右侧垂直颜色条，单位(MHz)，范围从-260到-240。颜
// 色由底部的蓝色渐变至顶部的红色，分别代表负值较大（更负）
// 和负值较小（接近零）。 内容描述：所有数值均为负数。中
// 心偏左位置有一个显著的低值点-262（深蓝色），周围环绕着
// -257等较低数值。右上部分区域数值相对较高（如-239, -240），
// 显示为红色或橙色。 子图 c： 类型：热力图（Heatmap）。
// 标题：Readout drive frequency (GHz)。 坐标轴与范围：无
// 显式坐标轴，数据范围为6.280 GHz至6.556 GHz。 色标：右
// 侧垂直颜色条，单位(GHz)，范围从6.25到6.55。颜色由底部
// 的蓝色渐变至顶部的红色。 内容描述：数值分布在6.300至
// 6.500之间居多。右下角区域聚集了多个高值点（如6.548,
// 6.556），显示为深红色。左侧边缘及中间部分散布着一些低
// 值点（如6.280, 6.292），显示为蓝色。 子图 d： 类型：热
// 力图（Heatmap）。 标题：Detuning from maximum
// frequency (MHz)。 坐标轴与范围：无显式坐标轴，数据范围
// 为-487 MHz至-12 MHz。 色标：右侧垂直颜色条，单位(MHz)，
// 范围从-500到-50。颜色由底部的蓝色渐变至顶部的红色。 内
// 容描述：所有数值均为负数，表示相对于最大频率的失谐量。
// 左上角存在极低的异常值-487（深蓝色）。中部和右下部也有
// 大片蓝色区域（如-370, -340, -335），表示较大的失谐。右
// 上角区域数值绝对值较小（如-12, -18），显示为红色，表示
// 接近最大频率。 子图 e： 类型：热力图（Heatmap）。 标题：
// Average T1 at idle frequency: 26.5 μs。 坐标轴与范围：
// 无显式坐标轴，数据范围为15 μs至37 μs。 色标：右侧垂直
// 颜色条，单位(μs)，范围从16到36。颜色由底部的蓝色渐变至
// 顶部的红色。 内容描述：展示T1弛豫时间。图中存在两个显
// 著的高值点37（红色），分别位于第2行第1列和第6行第4列。
// 同时存在一个极低值点15（深蓝色），位于第6行第3列。大部
// 分数值分布在20至30之间。底部文字标注平均值为26.5 μs。
// 子图 f： 类型：热力图（Heatmap）。 标题：Average T2*
// at idle frequency: 3.4 μs。 坐标轴与范围：无显式坐标轴，
// 数据范围为1.1 μs至12.1 μs。 色标：右侧垂直颜色条，单位
// (μs)，范围从2到12。颜色由底部的蓝色渐变至顶部的红色。
// 内容描述：展示退相干时间T2*。大部分数值小于5，显示为蓝
// 色。图中仅有一个显著的红色高值点12.1，位于倒数第5行第3
// 列。其他较高值如10.3、9.9分散在右侧。底部文字标注平均
// 值为3.4 μs。
#figure(
  image("imgs/supp/figS2-60bit.png", width: 66%),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [FIG. S5. Typical distribution of selected 60-qubits.],
) <fig:supp-s5>

=== Two-Qubit Gate Calibration
<supp:two-qubit-calibration>
iSWAP-like gates~#cite(<arute2019quantum>) are used in our experiment, which are realized by tuning two near-neighbor qubits into resonance. The procedures of calibration and optimizing are similar to _Zuchongzhi_ 2.0 which we briefly illustrate here again. First, we set the total duration time of iSWAP-like gates to $24$ ns after considering the effect of the leakage to non-computational basis. To realize swap angles close to $pi / 2$, we delicately calibrate the coupling strength and detuning of two near-neighbor qubits.

// [figvision-cn] imgs/supp/hf_error_2q_population.png
// 该图包含两个子图（a和b），均为累积直方图形式的曲线图，
// 用于展示双量子比特门在不同测量条件下的误差分布及控制参
// 数分布。 子图 a： 类型：累积直方图曲线图。 坐标轴：横
// 轴为“Fsim gate error rate”，范围从0到0.025，无单位标注；
// 纵轴为“Integrated histogram”，范围从0到1，无量纲。 曲
// 线与图例：图中有四条曲线，分别代表不同条件下的积分分布：
// 黄色虚线点状线（Purity isolated）：表示孤立测量下的纯
// 度误差累积分布。 蓝色虚线点状线（XEB isolated）：表示
// 孤立测量下的随机基准测试（XEB）误差累积分布。 黄色实线
// （Purity simultaneous）：表示同时测量下的纯度误差累积
// 分布。 蓝色实线（XEB simultaneous）：表示同时测量下的
// XEB误差累积分布。 趋势与结论：所有曲线均从左下向右上单
// 调递增，表明随着Fsim门错误率增加，累积概率上升。孤立测
// 量结果（虚线）整体位于同时测量结果（实线）左侧，说明在
// 相同累积概率下，孤立测量的错误率更低。例如，在累积概率
// 0.8处，Purity isolated对应的错误率约为0.006，而Purity
// simultaneous对应约0.009；XEB isolated约为0.007，XEB
// simultaneous约为0.01。这表明同时测量引入额外噪声或串扰，
// 导致门性能下降。 子图 b： 类型：累积直方图曲线图。 坐
// 标轴：横轴为“Fsim gate parameter”，范围从0到120，无单
// 位标注；纵轴为“Integrated histogram”，范围从0到1，无量
// 纲。 曲线与图例：图中有两条曲线： 蓝色实线（Swap angle
// θ simultaneous）：表示同时测量下交换角θ参数的累积分布。
// 红色实线（Conditional phase φ simultaneous）：表示同时
// 测量下条件相位φ参数的累积分布。 趋势与结论：红色曲线（
// φ）在横坐标约10至15之间急剧上升至1，表明绝大多数门的条
// 件相位集中在该窄区间内。蓝色曲线（θ）在横坐标约85至100
// 之间急剧上升至1，表明交换角主要分布在90度附近（接近π/2
// 弧度）。两曲线形态陡峭，说明参数分布高度集中，系统对这
// 两个关键控制参数具有良好的稳定性和一致性。比例尺未提供，
// 但根据物理背景可推断横轴单位为角度（度）或归一化值。
#figure(
  image("imgs/supp/hf_error_2q_population.png", width: 92%),
  numbering: none,
  caption: [FIG. S6. *Two-qubits gates XEB and parameters.* *a,* Integrated histograms of two-qubit gates Pauli error $e_2$. The dotted line represent isolated results, and the line represent simultaneous results. *b,* Integrated histograms of two control parameters $theta$ and $phi$.],
) <fig:supp-hf2q>

After calibration of iSWAP-like gates parameters, we use XEB~#cite(<arute2019quantum>) to benchmark the gate performance. Through optimize the five parameters ${theta, phi, Delta_+, Delta_-, Delta_(minus, "off")}$, as described in the main text, overall fidelities of XEB are obtained Fig.~2 (main). We also analyze the error of speckle purity benchmarking (SPB)~#cite(<arute2019quantum>) which is shown in Fig. S4(b). Considering the effects of two-level-system (TLS), pulse distortion, decoherence and the residual coupling between nearest-neighbor qubits when simultaneous manipulating two-qubit gates in a specific pattern, we obtain an optimized resonance frequency configuration of all $99$ two-qubit gates in four different patterns, as exhibited in Fig. S4(a).

After calibration and optimization, we compare two-qubit gates performance in the isolated and simultaneous situations. As illustrated in Fig. S6(a), the XEB error is close to SPB error in both cases which means our control error is small. The difference is that the SPB error is larger when simultaneously manipulate two-qubit gates which mainly caused from the residual coupling strength. Partial parameters of all $99$ iSwap-like gates are shown in Fig. S6(b), the average swap angle and conditional phase are $90$ degrees and $10$ degrees separately.

#figure(
  table(
    columns: 5,
    align: (left, center, center, center, center),
    inset: 3pt,
    stroke: none,
    table.hline(stroke: 0.7pt),
    [Parameters], [Mean], [Median], [Stdev.], [Figure],
    table.hline(stroke: 0.5pt),
    [Qubit maximum frequency (GHz)], [5.094], [5.099], [0.129], [Fig. S3],
    [Qubit idle frequency (GHz)], [4.921], [4.926], [0.082], [Fig. S5],
    [Readout drive frequency (GHz)], [6.397], [6.409], [0.097], [Fig. S5],
    [Qubit anharmonicity (MHz)], [$-246.6$], [$-245.3$], [4.9], [Fig. S5],
    [$T_1$ at idle frequency ($mu$s)], [26.5], [26.5], [5.3], [Fig. S5],
    [$T_2^*$ at idle frequency ($mu$s)], [3.4], [2.9], [2.1], [Fig. S5],
    table.hline(stroke: 0.5pt),
    [Readout $e_(|0 chevron.r)$ isolated / simultaneous (%)], [1.36 / 1.48], [1.20 / 1.35], [0.55 / 0.63], [Fig. S2],
    [Readout $e_(|1 chevron.r)$ isolated / simultaneous (%)], [3.22 / 3.03], [3.02 / 2.93], [1.03 / 0.91], [Fig. S2],
    [1Q XEB $e_1$ isolated / simultaneous (%)], [0.15 / 0.16], [0.14 / 0.16], [0.05 / 0.04], [Fig. S2],
    [1Q XEB $e_1$ purity isolated / simultaneous (%)], [0.12 / 0.13], [0.11 / 0.12], [0.03 / 0.04], [Fig. S2],
    [2Q XEB $e_2$ isolated / simultaneous (%)], [0.48 / 0.60], [0.40 / 0.52], [0.31 / 0.30], [Fig. S6],
    [2Q XEB $e_2$ purity isolated / simultaneous (%)], [0.42 / 0.51], [0.35 / 0.44], [0.23 / 0.24], [Fig. S6],
    table.hline(stroke: 0.7pt),
  ),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [TABLE S1. *Summary of system parameters.*],
  kind: table,
) <tab:supp-params>

== 4-patch calibration
<supp:four-patch>
Till now the parameters of all the iSWAP-like gates are calibrated using two-qubit XEB. As stated in the main text and section III (B2), the distortion of the square pulse will cause qubit frequency and coupling strength continuously change slightly during the operation time. However, the square pulses on coupler are not calibrated. Due to that the iSWAP-like gate parameters obtained by two-qubit XEB is fitted using 10-500 cycles circuits, the iSWAP-like gate parameters is slightly inaccurate for shallow circuits.

To optimize the XEB fidelity for the shallow and full circuits, it may be helpful to directly calibrate the iSWAP-like gate on the whole system level with shallow cycle. For such a purpose, we will minimize the loss function
$ "Loss"_"XEB"(arrow(theta), b_"train") = 1 - F_"XEB"(arrow(theta), b_"train"). $ <eq:supp-loss>
Here $arrow(theta)$ is a list of tunable parameters of all the iSWAP-like gates, $b_"train"$ is a training dataset which is generated experimentally before hand, $F_"XEB"$ is the cross-entropy fidelity. We note that Eq. (S1) is a pure classical function except that the training data $b_"train"$ is generated with a quantum computer. Therefore we can compute the gradient of Eq. (S1) using the classical auto-differentiation framework, and then we use the BFGS optimizer to minimize the loss function. The initial values of the iSWAP-like gates are set as the parameters obtained by two-qubit XEB. After that we use the optimal set of parameters, $arrow(theta)^"optimal"$, as the final parameters for the iSWAP-like gates.

One difficulty of this approach is that for the full circuit of $60$ qubits, $F_"XEB"$ will be extremely difficult to evaluate. To overcome this problem, we divide the full circuit into $4$ non-overlapping patches (see Fig. S8(a)), which nevertheless covers all the iSWAP gates. We then optimize the parameters in each patch independently, with $b_"train"$ generated for each patch with depth $24$. After that, we obtain $arrow(theta)^"optimal"$ for all the iSWAP-like gates.

Fig. S9 shows the parameters of all the iSWAP-like gates before and after 4-patch calibration. We can see that the two parameters $theta$ and $phi$ related to the coupling strength have slightly changed before and after 4-patch, which is consistent with our inference. As shown in Fig. S8(b), the XEB fidelities of circuit with 15-60 qubits and 10-cycle can be greatly improved after 4-patch calibration.

// [figvision-cn] imgs/supp/fsim_gate.png
// 该图展示了两量子比特交叉熵基准测试（XEB）的结果，包含
// 一个散点拟合曲线图。横轴表示“Number of cycles, m”（循
// 环次数），数值范围从0到500，刻度标记为0、100、200、300、
// 400、500。纵轴表示“XEB fidelity”（XEB保真度），数值范
// 围从0.0到1.0，刻度标记为0.0、0.2、0.4、0.6、0.8、1.0。
// 图中有两组实验数据点及对应的两条拟合曲线： 第一组数据
// 由绿色实心圆点表示，对应图例中的“Purity error = 0.31%”。
// 这些数据点分布在一条红色实线周围，该红线代表“Purity
// fitting”（纯度拟合）。随着横轴循环次数m的增加，绿色数
// 据点和红色拟合线均呈现下降趋势。在m=0附近，保真度约为
// 0.9；当m增加到500时，保真度降至约0.08。 第二组数据由蓝
// 色实心圆点表示，对应图例中的“XEB error = 0.30%”。这些
// 数据点分布在一条橙色实线周围，该橙线代表“XEB fitting”
// （XEB拟合）。同样地，随着循环次数增加，蓝色数据点和橙
// 色拟合线也呈下降趋势。在m=0附近，保真度约为0.9；当m增
// 加到500时，保真度降至约0.04。 总体来看，两组数据的初始
// 保真度相近，但随循环次数增加，蓝色数据点及其拟合曲线（
// XEB方法）的衰减速度略快于绿色数据点及其拟合曲线（纯度
// 方法），导致在较大循环次数下（如m > 100），橙色曲线位
// 于红色曲线下方。这表明在该测试条件下，基于纯度的估计值
// 略高于直接XEB测量的估计值。
#figure(
  image("imgs/supp/fsim_gate.png", width: 80%),
  numbering: none,
  caption: [FIG. S7. *Two-qubit crossentropy benchmarking (XEB) on a pair of qubits.*],
) <fig:supp-fsim>

// [figvision-cn] imgs/supp/4patch.png
// 该图包含两个子图，分别标记为 a 和 b。 子图 a： 类型：
// 量子电路示意图。 布局与物体：展示了一个由节点（代表量
// 子比特）和连线（代表相互作用或门操作）组成的二维网格结
// 构，整体呈六边形轮廓。网格中的节点以白色圆圈表示，内部
// 无填充。节点之间通过彩色直线连接。整个网格被划分为四个
// 区域，每个区域用不同的半透明颜色背景标示。 分区与色标：
// 图的右上角有一个图例，标题为“4-patch”。图例包含四个条
// 目，分别对应四个分区：P1 对应红色，P2 对应青色，P3 对
// 应绿色，P4 对应橙色。在示意图中，左上角区域被标记为 P1
// （红色背景），右上角区域被标记为 P2（青色背景），左下
// 角区域被标记为 P3（绿色背景），右下角区域被标记为 P4（
// 橙色背景）。这些分区覆盖了整个量子比特阵列。 标注文字：
// 图上方有标题“4-patch”。 结论：此图展示了将量子电路物理
// 布局划分为四个独立部分（patch）的策略，用于后续的参数
// 优化。 子图 b： 类型：散点图与拟合曲线图，带有对数坐标
// 轴。 坐标轴： 横轴（X轴）：名称为“Number of qubits, n”，
// 表示量子比特的数量。刻度从 15 到 60，主要刻度间隔为 3
// （15, 18, 21, ..., 60）。 纵轴（Y轴）：名称为“Fidelity
// ”，表示保真度。采用对数刻度，范围从 10^-4 到 10^0（即
// 1），主要刻度线位于 10^-4, 10^-3, 10^-2, 10^-1, 10^0。
// 数据系列与符号：图中有两组主要的数据对比，分别代表“
// Before 4-patch Cal.”（4-patch校准前）和"After 4-patch
// Cal."（4-patch校准后）。 校准前（灰色系）： “Patch”数
// 据点：灰色加号（+）。 “Elided”数据点：灰色叉号（x）。
// “Full”数据点：灰色空心圆圈（○）。 拟合曲线：一条灰色的
// 实线穿过这些数据点。 校准后（彩色系）： “Patch”数据点：
// 蓝色加号（+）。 “Elided”数据点：绿色叉号（x）。 “Full”
// 数据点：红色空心圆圈（○）。 拟合曲线：一条黑色的实线穿
// 过这些数据点。 图例位置：图例位于图的右上角，分为左右
// 两栏，左栏为校准前，右栏为校准后。每一栏下列出了对应的
// 符号含义（Fitting, Patch, Elided, Full）。 趋势描述：
// 两组数据均显示随着量子比特数量 n 的增加，保真度
// Fidelity 呈下降趋势（指数衰减）。校准后的数据点（彩色）
// 及其拟合曲线（黑色）整体位于校准前数据点（灰色）及其拟
// 合曲线（灰色）的上方。这表明在经过 4-patch 校准后，对
// 于相同数量的量子比特，电路的保真度得到了显著提升。例如，
// 在 n=60 时，校准前的保真度约为 10^-2 量级，而校准后提
// 升至约 10^-1.5 量级。 插图内容：在主图的下方嵌入了一张
// 虚线框起来的示意图，标题为“m = 10”。该示意图展示了三种
// 不同类型的电路布局，从左到右依次为：“Full Circuit”（全
// 电路）、“Elided Circuit”（剪枝电路）、“Patch Circuit”
// （分块电路）。这三种布局都显示了与主图相似的六边形网格
// 结构，但节点间的连线密度或模式有所不同，直观地解释了上
// 述数据点中“Full”、“Elided”和“Patch”所代表的不同电路测
// 试配置。
#figure(
  image("imgs/supp/4patch.png", width: 96%),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [FIG. S8. *4-patch calibration and experimental results.* (a) We divide the circuit into 4 patches as shown, and optimize the parameters of iSWAP gates in each patch. (c) The XEB fidelities of circuit with 15-60 qubits and 10-cycle before and after 4-patch calibration.],
) <fig:supp-4patch>

// [figvision-cn] imgs/supp/fsimGatePara_rawvsReargs.png
// 该图像包含五个垂直堆叠的子图，标记为a、b、c、d和e。所
// 有子图共享位于底部的水平轴，标签为“Coupler”，代表不同
// 的耦合器编号或索引，刻度线密集排列，未标注具体数值。右
// 上角有一个适用于前四个子图的图例：蓝色实心圆点表示“
// Before 4-Patch Calibration”（四补丁校准前），红色实心
// 圆点表示"After 4-Patch Calibration"（四补丁校准后）。
// 子图a： 类型：散点图。 纵坐标轴：标签为$|\delta_\theta
// |$，范围从0到0.2，主刻度间隔为0.1。 数据描述：图中包含
// 大量蓝色和红色的离散圆点。在大多数横坐标位置上，红点的
// 纵坐标值普遍低于或等于对应的蓝点。蓝点散布较广，部分接
// 近0.2；而红点主要集中在0.05以下，显示出更小的偏差值。
// 这表明经过校准后，参数$|\delta_\theta|$的波动幅度减小，
// 整体向零靠近。 子图b： 类型：散点图。 纵坐标轴：标签为
// $\phi$，范围从0到0.4，主刻度间隔为0.2。 数据描述：图中
// 分布着密集的蓝色和红色圆点。与子图a不同，这里红点和蓝
// 点在纵向上高度重叠，两者均围绕0.2附近波动，没有明显的
// 系统性偏移或显著差异。这表明校准前后，相位参数$\phi$保
// 持相对稳定。 子图c： 类型：散点图。 纵坐标轴：标签为$\
// Delta_-$，范围从-5到10，主刻度间隔为5。 数据描述：蓝色
// 和红色圆点交错分布。虽然存在随机波动，但总体上红点似乎
// 比蓝点略微集中在正值区域，且两者的分布范围基本一致，覆
// 盖了从0到8左右的区间。 子图d： 类型：散点图。 纵坐标轴：
// 标签为$\Delta_+$，范围从0到10，主刻度间隔为5。 数据描
// 述：图中显示了大量红色圆点，蓝色圆点数量极少，仅在左侧
// 少数位置可见，且与红点重合。红点分布广泛，从接近0到7左
// 右不等。由于缺乏显著的蓝色数据对比，主要展示了校准后的
// 状态分布。 子图e： 类型：散点图。 纵坐标轴：标签为$\
// Delta_{-, \text{off}}$，范围从-50到50，主刻度间隔为50。
// 数据描述：该子图中仅包含红色实心圆点，没有蓝色圆点。这
// 些红点分布在-30到30之间，呈现出无规则的随机散布特征。
#figure(
  image("imgs/supp/fsimGatePara_rawvsReargs.png", width: 92%),
  numbering: none,
  caption: [FIG. S9. *Parameters of iSWAP-like gates before and after 4-patch calibration.*],
) <fig:supp-4patch-params>

== Summary of system parameters
<supp:summary-params>
The system parameters of our quantum processor 60bit are summarized in Table S1.

// [figvision-cn] imgs/supp/ABCD_pattern.png
// 该图像包含四个并排排列的子图，分别标记为A、B、C和D。每
// 个子图展示了一个相同的量子比特（qubit）晶格结构示意图，
// 用于说明60个量子比特的耦合器激活模式。 子图 A 类型：
// 示意图。 布局与物体： 主体是一个由黑色圆圈代表的量子比
// 特节点组成的网格状晶格结构。这些节点通过黑色的细线连接
// 成五边形环状单元。在图的右上角区域，有若干用浅粉色线条
// 勾勒的虚化五边形轮廓，表示边界或未被选中的区域。 色标
// 与物理含义： 图中部分连接两个节点的连线被加粗并填充为
// 橙色。这些橙色连线代表在当前周期内被激活的耦合器，即允
// 许其两端的量子比特发生相互作用。 趋势/结论： 橙色连线
// 呈现出规则的斜向平行排列，覆盖了晶格的特定对角线路径。
// 子图 B 类型： 示意图。 布局与物体： 晶格结构与子图A完
// 全一致，包含相同的黑色节点、连接线以及右上角的浅粉色虚
// 化轮廓。 色标与物理含义： 图中另一组特定的连线被加粗并
// 填充为蓝色。这些蓝色连线代表另一种激活模式下的耦合器。
// 趋势/结论： 蓝色连线同样呈现斜向平行排列，但其方向与子
// 图A中的橙色连线垂直（或呈不同角度的对角线），表明这是
// 针对同一晶格的不同激活配置。 子图 C 类型： 示意图。 布
// 局与物体： 晶格结构与子图A和B完全一致。 色标与物理含义：
// 图中一组连线被加粗并填充为绿色。这些绿色连线代表第三种
// 激活模式下的耦合器。 趋势/结论： 绿色连线的分布路径与
// 子图A中的橙色连线完全重合，但颜色不同，可能代表时间序
// 列上的不同步或不同的实验条件。 子图 D 类型： 示意图。
// 布局与物体： 晶格结构与前述子图完全一致。 色标与物理含
// 义： 图中一组连线被加粗并填充为红色。这些红色连线代表
// 第四种激活模式下的耦合器。 趋势/结论： 红色连线的分布
// 路径与子图B中的蓝色连线完全重合，同样展示了与A/C组正交
// 的另一类耦合激活模式。 整体描述总结： 这四个子图共同展
// 示了在一个包含60个量子比特的二维晶格系统中，四种不同的
// 耦合器激活图案。每种图案通过不同颜色的粗线（橙、蓝、绿、
// 红）标示出在该特定操作周期内允许相互作用的量子比特对。
// 其中，A和C展示了同一种几何路径的激活，而B和D展示了另一
// 种与之交叉的几何路径激活。这种分时的激活模式旨在控制量
// 子比特之间的相互作用时序。
#figure(
  image("imgs/supp/ABCD_pattern.png", width: 96%),
  numbering: none,
  placement: top,
  scope: "parent",
  caption: [FIG. S10. *Coupler activation patterns for 60 qubits.* Coupler activation pattern for 60 qubits that determines which qubits are allowed to interact simultaneously in a cycle.],
) <fig:supp-abcd>

= RANDOM QUANTUM CIRCUITS
<supp:random-circuits>

In the random quantum circuit, single-qubit gates are chosen randomly from ${sqrt(X), sqrt(Y), sqrt(W)}$, the two-qubit gates are implemented in the sequence of ABCDCDAB, where A, B, C and D are 4 different patterns. The random quantum circuit for 60-qubit and 24-cycle is constructed using the method in Ref.~#cite(<wu2021strong>), and the four patterns for two-qubit gates are shown in Fig. S10. For the 60-qubit 22-cycle circuit, the sequence for two-qubit gates are set as (ABCDCDAB) $times$ 2 + ABCD + CB, to ensure the difficulty of classical simulation.

= XEB RESULT ANALYSIS
<supp:xeb-analysis>

For a set of bitstrings ${q_i}$, we estimate the linear XEB fidelity from the ideal probabilities ${p_i = p_s(q_i)}$ as
$ F_l = chevron.l D p chevron.r - 1 $ <eq:supp-linear-xeb>

Firstly, we compare the XEB results of patch circuits and elided circuits with full circuits to check the efficacy of circuit performance estimation method. Fig. S11 shows the XEB results measured by full, patch and elided circuit of systems from 15 to 60 qubits with 10 cycles. The average ratio of patch circuit and elided circuit fidelity to full circuit fidelity are 1.05 and 1.07, both with a standard deviation of 6%.

// [figvision-cn] imgs/supp/XEB_Patch.png
// 这是一张包含单个子图的曲线图，展示了不同量子电路类型的
// XEB保真度随量子比特数量的变化关系。 子图类型：半对数坐
// 标曲线图（横轴为线性刻度，纵轴为对数刻度）。 坐标轴信
// 息： 横轴名称为“Number of qubits”（量子比特数量），单
// 位为无量纲数值。范围从10到60，主刻度标记在10、20、30、
// 40、50和60处。 纵轴名称为“XEB fidelity”（XEB保真度），
// 单位为无量纲比率。采用对数标度，范围从10⁻³到10⁰，主刻
// 度标记在10⁻³、10⁻²、10⁻¹和10⁰处。背景绘有浅灰色网格线，
// 对应于这些主刻度位置。 图例与数据系列： 图中包含三条带
// 数据点标记的实线，分别代表三种不同的电路类型，所有数据
// 点均为圆形实心标记。 绿色实线连接绿色圆形标记，代表“
// Full circuits”（完整电路）。该曲线起始于约15个量子比特
// 处，XEB保真度约为0.3；随着量子比特数增加至60，保真度下
// 降至约0.02。 蓝色实线连接蓝色圆形标记，代表“Elided
// circuits”（省略电路）。该曲线起始于约15个量子比特处，
// XEB保真度最高，约为0.4；随后迅速下降，在20个量子比特时
// 降至约0.3，之后趋势与其他两条曲线趋同，在60个量子比特
// 时降至约0.025。 红色实线连接红色圆形标记，代表“Patch
// circuits”（补丁电路）。该曲线起始于约15个量子比特处，
// XEB保真度约为0.3；其走势介于绿色和蓝色曲线之间，在60个
// 量子比特时降至约0.022。 标注文字： 图例位于图表右上角
// 区域，白色背景框内，列出三行文字：“Full circuits”、“
// Elided circuits”、“Patch circuits”，每行左侧配有对应颜
// 色的线段及圆形标记。 无其他额外文本标注或箭头指示。 趋
// 势与结论： 三条曲线均显示XEB保真度随量子比特数量增加而
// 单调递减，表明系统规模扩大导致性能下降。在较小规模（如
// 15–20量子比特）时，“Elided circuits”表现出最高的初始保
// 真度，但很快被其他两种方法追上并超越。从约25个量子比特
// 开始，三种电路类型的保真度曲线几乎重合，说明在大尺度下
// 它们的性能趋于一致。每个数据点是9个独立量子电路实例的
// 平均值，反映了统计平均后的稳健结果。整体而言，该图表明
// 在所测试范围内，三种电路构造方法在大规模下的表现差异不
// 大，但在小规模时存在可区分的优劣顺序。
#figure(
  image("imgs/supp/XEB_Patch.png", width: 92%),
  numbering: none,
  caption: [FIG. S11. *Performance of patch circuits and elided circuits.* Patch, elided and full circuit XEB fidelity from 15 to 60 qubits with 10 cycles. Each data point is averaged over 9 quantum circuit instances.],
) <fig:supp-xebpatch>

We then check the probability distribution of our samples against the theoretical PDF
$ P_l (x | hat(F_l)) = (hat(F_l) x + (1 - hat(F_l))) e^(-x) $ <eq:supp-pdf>
where $x equiv D p$ is bitstring probability scaled by the dimension $D$. For elided circuit with 60 qubits and 24 cycles, we show the result of one circuit instance in Fig. S12. Kolmogorov-Smirnov test is performed to quantify the consistency of experimental data distribution with theoretical curve. Taking one circuit instance for example, the K-S test result is $p = 0.77$ for hypothesis $F = hat(F)$ while $p = 8.0 times 10^(-4)$ for hypothesis $F = 0$.

// [figvision-cn] imgs/supp/probdist.png
// 子图类型：直方图叠加理论曲线图。 标题与坐标轴：图表顶
// 部标题为“Distribution of bitstring probability,
// 60qubits, 24cycles”。纵坐标轴标签为“Counts”，采用对数
// 刻度，范围从10的负1次方（0.1）到10的7次方（10,000,000），
// 主刻度间隔为10的整数次幂。横坐标轴标签为“x = Dp”（Dp代
// 表概率分布的距离或差异度量），采用线性刻度，范围从0.0
// 到20.0，主刻度标记间隔为2.5（即0.0, 2.5, 5.0, ...,
// 20.0）。背景包含对应坐标轴刻度的灰色网格线。 数据系列
// 与图例：右上角包含图例框，定义了两个数据系列。第一个系
// 列为红色实线，标注为“P_i (x|F_hat_I = 0.000409)”，代表
// 基于实验XEB保真度（Fidelity）计算出的理论概率分布曲线。
// 第二个系列为浅粉色填充区域，标注为“Experimental Data”，
// 代表实验测量得到的位串概率分布计数直方图。 视觉特征与
// 趋势：浅粉色的实验数据直方图在横坐标0.0附近具有最高的
// 计数值，接近10的7次方。随着横坐标数值增加，直方图的高
// 度呈指数级下降。红色的理论曲线是一条平滑的对数直线，起
// 始于左上角（x=0, y=10^7），向右下角延伸，穿过整个图表
// 区域，并在x约等于18处降至10的-1次方以下。该理论曲线紧
// 密地拟合了实验数据的整体下降趋势，特别是在高计数区域（
// x < 12.5），两者高度重合。在低计数区域（x > 12.5），由
// 于统计涨落，实验数据的柱状条表现出一定的离散性，但总体
// 仍围绕理论曲线分布。图表展示了60量子比特、24周期电路下
// 的位串概率分布符合理论预测的Porter-Thomas分布特征。
#figure(
  image("imgs/supp/probdist.png", width: 92%),
  numbering: none,
  caption: [FIG. S12. *Distribution of bitstring probabilities from a 60-qubit 24-cycle circuit.* The theoretical curve $P_l (x | hat(F_l))$ is computed with the experimental XEB fidelity and scaled by the number of samples $N_s = 7 times 10^7$.],
) <fig:supp-probdist>

The statistical uncertainty of XEB is estimated with formula
$ hat(sigma)_(F_l) = D sqrt(op("Var")(p) / N_s) $ <eq:supp-sigma>
We check the formula with bootstrap method. For a 60-qubit 24-cycle elided circuit, the statistical uncertainty of XEB is $1.20, 1.19, 1.21 times 10^(-4)$ for the estimating formula, bootstrap and gaussian fit. The fidelity distribution of 2500 bootstrap samples with Gaussian fit are shown in Fig. S13.

Then we use inverse-variance weighting to estimate the fidelity and statistical uncertainty of all twelve 60-qubit and 24-cycle elided circuits. The result is $hat(F_l) = (3.66 plus.minus 0.35) times 10^(-4)$, indicating great consistency with the theoretical statistical uncertainty $3.5 times 10^(-5)$.

// [figvision-cn] imgs/supp/bootstrap.png
// 子图类型为带有高斯拟合曲线的直方图。纵轴名称为“Counts”
// （计数），采用对数标度，刻度范围从10的0次方到10的3次方，
// 主刻度标记为10^0、10^1、10^2、10^3。横轴名称为“Linear
// cross entropy fidelity”（线性交叉熵保真度），采用线性
// 标度，刻度范围从0到9，右下角标注有比例因子“× 10^-4”，
// 表示实际数值需乘以10的负4次方。图中包含两个数据系列：
// 第一个是半透明浅粉色填充的柱状直方图，代表原始数据的分
// 布，即自举样本的保真度统计频数；第二个是叠加在直方图上
// 的实心红色曲线，代表对数据进行的高斯分布拟合结果。图例
// 位于右上角，标明粉色区域为“Data histogram”（数据直方图），
// 红色线条为“Gaussian fit”（高斯拟合）。图像整体展示了一
// 个近似钟形的分布，峰值出现在横坐标约4.2（即4.2 × 10^-4）
// 处，对应的纵坐标计数值约为300左右，表明大多数自举样本
// 的保真度集中在此附近，且分布符合高斯模型。
#figure(
  image("imgs/supp/bootstrap.png", width: 92%),
  numbering: none,
  caption: [FIG. S13. *Fidelity distribution of bootstrap samples.* The samples of a 60-qubit 24-cycle elided circuit are bootstrapped 2500 times. Calculated fidelities distribution is shown with a gaussian fit.],
) <fig:supp-bootstrap>

= CLASSICAL SIMULATION
<supp:classical-simulation>
In this section, two state-of-the-art classical algorithms, tensor network contraction algorithm (abbreviated as TNC, a single-amplitude algorithm) and Schrödinger-Feynman algorithm (abbreviated as SFA, a full-amplitude algorithm), are used to estimate the classical computational cost of our random quantum circuit. Compared with SFA, TNC is more efficient for this system size, so the results of TNC are present in the main text as the estimation of classical computational cost.

== Tensor network contraction
<supp:tnc>
The cost of TNC algorithm can be estimated by the python package cotengra. When using this package, we leave 21 out of the 60 qubits as open, set the size of the largest intermediate tensor as $2^30$, and the optimizer _kahypar_ is chosen. For the 60-qubit random quantum circuit with 22 cycles and 24 cycles, the number of floating point operations to generate one perfect sample are estimated as $1.06 times 10^22$ and $4.68 times 10^23$, respectively, by repeating the procedure about 100 times (see Fig. S14).

// [figvision-cn] imgs/supp/TNCdistribution.png
// 该图包含两个并列的直方图，分别标记为a和b，展示了在“祖
// 冲之2.1”量子处理器上运行不同深度电路时，收缩过程所需浮
// 点运算次数的概率分布。 子图a： 类型：直方图（柱状图）。
// 标题：“Zuchongzhi 2.1 60-qubit 22-cycle”，位于图表顶部
// 中央。 X轴名称：“floating-point-operation numbers”，范
// 围从0.0到1.0，单位标注为“1e24”（即10^24），刻度标记为
// 0.0, 0.2, 0.4, 0.6, 0.8, 1.0。 Y轴名称：“distribution”，
// 范围从0到35，刻度标记为0, 5, 10, 15, 20, 25, 30, 35。
// 数据表示：蓝色实心矩形条代表频数分布。第一个区间（约
// 0.0–0.05×10^24）的柱子高度约为34；第二个区间（约0.05–
// 0.1×10^24）高度约为7；第三个区间（约0.1–0.15×10^24）高
// 度约为6；第四个区间（约0.15–0.2×10^24）高度约为5；第五
// 个区间（约0.2–0.25×10^24）高度约为4；第六个区间（约
// 0.25–0.3×10^24）高度约为3；第七个区间（约0.3–0.35×10^
// 24）高度约为3；第八个区间（约0.35–0.4×10^24）高度约为2；
// 第九个区间（约0.4–0.45×10^24）高度约为2；第十个区间（
// 约0.45–0.5×10^24）高度约为1；之后无显著数据，直到接近
// 1.0×10^24处有一个极矮的小柱（高度约1）。 趋势与结论：
// 绝大多数情况下浮点运算次数集中在极低值区域（<0.2×10^24），
// 呈现高度右偏分布，表明对于60量子位22周期电路，收缩所需
// 的计算量通常很小，但存在少量高成本情况。 子图b： 类型：
// 直方图（柱状图）。 标题：“Zuchongzhi 2.1 60-qubit
// 24-cycle”，位于图表顶部中央。 X轴名称：“
// floating-point-operation numbers”，范围从0.0到1.5，单
// 位标注为“1e26”（即10^26），刻度标记为0.0, 0.5, 1.0,
// 1.5。 Y轴名称：“distribution”，范围从0到50以上，刻度标
// 记为0, 10, 20, 30, 40, 50。 数据表示：蓝色实心矩形条代
// 表频数分布。第一个区间（约0.0–0.05×10^26）的柱子高度约
// 为55；第二个区间（约0.05–0.1×10^26）高度约为18；第三个
// 区间（约0.1–0.15×10^26）高度约为9；第四个区间（约0.15–
// 0.2×10^26）高度约为5；第五个区间（约0.2–0.25×10^26）高
// 度约为4；第六个区间（约0.25–0.3×10^26）高度约为3；第七
// 个区间（约0.3–0.35×10^26）高度约为2；第八个区间（约
// 0.35–0.4×10^26）高度约为1；第九个区间（约0.4–0.45×10^
// 26）高度约为1；第十个区间（约0.45–0.5×10^26）高度约为1；
// 之后稀疏分布，在约1.0×10^26和1.5×10^26附近各有一个高度
// 约1的小柱。 趋势与结论：同样呈现高度右偏分布，大部分样
// 本集中在极低运算量区间（<0.2×10^26），但随着电路周期增
// 加至24，整体运算量数量级提升至10^26，且尾部更长，说明
// 更深层电路导致更多极端高成本事件出现。
#figure(
  image("imgs/supp/TNCdistribution.png", width: 96%),
  numbering: none,
  caption: [FIG. S14. *Probability distributions of the number of floating point operations for contraction of (a) 60-qubit 22-cycle circuit and (b) 60-qubit 24-cycle circuit.*],
) <fig:supp-tnc>

As estimated in Ref.~#cite(<HuangChen2020>), it would cost 833.75 s to generate one perfect sample for a tensor network with $6.66 times 10^18$ contraction cost using Summit. Thus, it would cost $frac((4.68 times 10^23) times (7.0 times 10^7) times (3.66 times 10^(-4)), 6.66 times 10^18) times 833.75 "s" approx 4.8 times 10^4$ years to reproduce the same results as the 53-qubit 20-cycle circuit in Ref.~#cite(<arute2019quantum>) and our 60-qubit 24-cycle circuit using Summit.

== Schrödinger-Feynman algorithm
<supp:sfa>
// [figvision-cn] imgs/supp/cut.png
// 该图像包含两个并排的示意图，分别标记为 a 和 b，展示了
// 量子电路的格点结构及其最优切割方案。 子图 a： 这是一个
// 二维格点网络示意图，展示了一个60量子比特、22周期的电路
// 结构。图中节点以圆圈表示，内部标有数字编号（从0到64），
// 代表不同的量子比特或时间步长。连接节点的线段代表量子门
// 操作或相互作用路径。整体布局呈菱形网格状，由多个相互连
// 接的六边形单元组成。 颜色与线型含义如下： 深蓝色粗实线：
// 表示未被切断的活跃连接，主要分布在左上区域，覆盖节点0
// 至38之间的密集网络。 黑色细实线：表示另一部分未切断的
// 连接，位于右下区域，覆盖节点39至64。 绿色粗实线：表示
// 被“切割”的连接，即在该优化方案中被移除或中断的边。具体
// 包括：(16,23)、(27,34)、(33,39)、(38,45)、(36,43)、(42
// ,48)。这些绿色线条跨越了蓝黑两区的边界，形成一条近似对
// 角线的切割路径。 浅粉色虚线及对应节点（如4,5,11,17,22,
// 65）：表示在原始电路中可能存在但在当前优化配置中被忽略
// 或排除的部分，不参与当前计算或测量。 所有标注文字均为
// 节点编号（0–64），无额外文本标签。趋势结论：此图显示对
// 于60量子比特22周期电路，最优切割策略是通过6条绿色边将
// 电路划分为两个连通分量——左侧深蓝色主导区和右侧黑色主导
// 区，从而最小化跨分区通信开销。 子图 b： 同样是一个二维
// 格点网络示意图，结构与子图a完全相同，但对应的是60量子
// 比特、24周期的电路。节点编号范围仍为0–64，布局一致。
// 颜色与线型含义： 深蓝色粗实线：同上，表示未切断连接，
// 覆盖节点0–38。 黑色细实线：同上，覆盖节点39–64。 绿色
// 粗实线：表示被切割的连接，共6条，位置分别为：(16,23)、
// (27,34)、(33,39)、(38,45)、(36,43)、(42,48) —— 与子图a
// 完全相同。 浅粉色虚线及节点（4,5,11,17,22,65）：同上，
// 表示被排除部分。 关键差异在于：虽然切割路径相同，但由
// 于周期数增加（22→24），某些原本属于活跃区域的节点可能
// 因时序扩展而重新归类；然而在此图中，视觉呈现上切割模式
// 保持不变，说明在24周期下最优解仍采用相同的拓扑分割方式。
// 所有标注文字仅为节点编号（0–64）。趋势结论：尽管电路深
// 度增加，最优切割方案并未改变，表明该拓扑划分对周期变化
// 具有鲁棒性，适用于不同深度的同类电路结构。
#figure(
  image("imgs/supp/cut.png", width: 96%),
  numbering: none,
  caption: [FIG. S15. *Optimal cut for (a) 60-qubit circuit with 22 cycles and (b) 60-qubit circuit with 24 cycles, respectively.*],
) <fig:supp-cut>

For the 60-qubit random quantum circuit with 22 cycles and 24 cycles, the promising cuts for SFA are shown in Fig. S15. We use the same simulator and server in Ref.~#cite(<wu2021strong>) to estimate the cost of SFA. The results are shown in Table S2 (for the sake of comparison, we also list the estimation for Sycamore and _Zuchongzhi_ 2.0's circuits).

#figure(
  table(
    columns: 5,
    align: center,
    inset: 4pt,
    stroke: (x, y) => if y == 0 or y == 6 { 0.8pt } else if y == 1 { 0.4pt } else { none },
    [Processor], [No. of qubits], [cycle], [fidelity], [run time (years)],
    [Sycamore], [$53$], [20], [0.224%], [1,332],
    [_Zuchongzhi_ 2.0], [$56$], [20], [0.0662%], [8,612,623],
    [_Zuchongzhi_ 2.1], [$60$], [22], [0.0758%], [$6.4 times 10^9$],
    [_Zuchongzhi_ 2.1], [$60$], [24], [0.0366%], [$1.2 times 10^12$],
  ),
  numbering: none,
  caption: [TABLE S2. *Run times of SFA using 7,630,848 CPU cores* (the most powerful supercomputer Fugaku has a total of 7,630,848 cores).],
  kind: table,
) <tab:supp-sfa>

// [figvision-cn] imgs/supp/fSim_gates_distribution.png
// 该图展示的是关于类iSWAP门（iSWAP-like gates）的累积概
// 率分布。 子图类型： 这是一张二维累积分布函数（CDF）曲
// 线图，背景为白色，四周有黑色边框。 坐标轴信息： 横坐标
// 轴名称为“|δθ|”，表示参数δθ的绝对值。其数值范围从0.000
// 开始，向右延伸至约0.185。主刻度标记包括0.000、0.025、
// 0.050、0.075、0.100、0.125、0.150和0.175。纵坐标轴名称
// 为“Proportion”（比例），代表累积概率或样本占比。其数值
// 范围从0.0到1.0。主刻度标记为0.0、0.2、0.4、0.6、0.8和
// 1.0。 曲线特征与物理含义： 图中包含一条单一的蓝色实线。
// 这条线呈现阶梯状上升的趋势，反映了数据的离散统计特性。
// 曲线的具体走势如下： 在横坐标0.000至约0.010的区间内，
// 曲线紧贴横轴，纵坐标值为0.0。 随后曲线开始上升。当横坐
// 标达到0.025时，纵坐标约为0.1；当横坐标达到0.050时，纵
// 坐标约为0.6。这表明大部分数据集中在较小的|δθ|范围内。
// 在横坐标0.050之后，曲线斜率变缓，继续上升。当横坐标达
// 到0.100时，纵坐标约为0.92。 当横坐标超过0.125后，曲线
// 趋于平缓，接近饱和状态。 最终，在横坐标约0.135之后，曲
// 线完全变为水平直线，纵坐标稳定在1.0，表示所有样本均已
// 包含在内。 结论： 该图表明对于所研究的类iSWAP门，绝大
// 多数情况的|δθ|值分布在0.05到0.10之间。结合参考图注信息，
// 该分布的平均值约为0.054。
#figure(
  image("imgs/supp/fSim_gates_distribution.png", width: 96%),
  numbering: none,
  caption: [FIG. S16. *Cumulative probability distribution of $|delta_theta|$ for iSWAP-like gates.* $|delta_theta|$ has an average around 0.054 and the speedup of SFA is less than an order.],
) <fig:supp-fsimgates>

// [figvision-cn] imgs/supp/imbalanced_gates.png
// 该图包含两个并排的曲线子图，分别展示在不同参数条件下经
// 典加速比随相位偏差的变化。 左子图（a）为双对数坐标下的
// 曲线图。横轴表示相位偏差的绝对值 |δθ|，范围从 0.00 到
// 0.12，无单位标注；纵轴表示“Speedup”（加速比），采用对
// 数刻度，范围从 10⁰ 到 10²。图中绘制六条带实心圆点标记
// 的直线型曲线，每条对应一个固定的保真度 F 值：蓝色曲线
// 对应 F=0.0001，橙色对应 F=0.0002，绿色对应 F=0.0003，
// 红色对应 F=0.0005，紫色对应 F=0.001，棕色对应 F=0.0015。
// 所有曲线均起始于 (0.00, 10⁰) 附近，并随 |δθ| 增大而单
// 调上升，斜率相近但略有差异——F 越小（即保真度越低），相
// 同 |δθ| 下对应的 Speedup 越高。图右下角标注固定参数 “g
// =54”。 右子图（b）同样为双对数坐标曲线图。横轴与左图一
// 致，为 |δθ|，范围 0.00–0.12；纵轴亦为 “Speedup”，对数
// 刻度 10⁰–10²。图中绘制七条带实心圆点标记的直线型曲线，
// 每条对应一个不同的 g 值：蓝色 g=25，橙色 g=30，绿色 g=
// 35，红色 g=40，紫色 g=45，棕色 g=50，粉色 g=54。所有曲
// 线同样从 (0.00, 10⁰) 附近出发，随 |δθ| 增加而上升，且
// g 越大，曲线位置越高，表明在相同相位偏差下更大的 g 值
// 带来更高的加速比。图右下角标注固定参数 “F=0.0366%”。
// 两子图共同说明：在 iSWAP 类门存在统一相位偏差 δθ 的前
// 提下，经典加速比随 |δθ| 增大而显著提升；同时，加速比也
// 受保真度 F 和耦合强度 g 的影响——较低 F 或较高 g 均能增
// 强加速效果。
#figure(
  image("imgs/supp/imbalanced_gates.png", width: 100%),
  numbering: none,
  caption: [FIG. S17. *Classical speedup given by the imbalance gates.* We assume all iSWAP-like gates deviate from $pi / 2$ by the same $delta_theta$ and calculate the speedup with given $g$ and $F$. _Left:_ speedup with varied fidelity $F$ and fixed $g = 54$. _Right:_ speedup with varied $g$ and fixed $F = 0.0366%$.],
) <fig:supp-imbalanced>

We did not consider the DCD formation in our estimation. The DCD formation appears three times in the 60-qubit 22-cycle and 24-cycle circuits. In addition, the balanced iSWAP-like $(theta, phi)$ gate in our experiment has $theta approx pi / 2$ and $phi approx pi / 18$. Deviation of $theta$ and $phi$ from the expected values results in imbalanced gates, which can accelerate the simulation with SFA. We calculate classical simulation speedup for imbalanced gates using the method introduced in Ref.~#cite(<wu2021strong>) #cite(<arute2019quantum>).

Assuming the imbalanced gates in our experiments is in the form of iSWAP-like $(pi / 2 plus.minus delta_theta, phi approx pi / 18)$. We show the distribution of $|delta_theta|$ in Fig. S16. In the experiments, $|delta_theta|$ has an average 0.054 radians. For 60-qubit 24-cycle circuits, we have XEB fidelity $F = 0.0366%$ and the number of decomposed iSWAP-like gates $g = 54$ in SFA. The speedup resulted from imbalanced gates is shown in Fig. S17. We can conjecture that the classical speedup in our experiment is less than an order.

]