#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (x: 2.05cm, top: 2.3cm, bottom: 2.0cm))
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
#set par(justify: true, leading: 0.49em)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(spacing: 0.87em, first-line-indent: (amount: 1.5em, all: true))
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): it => context layout(size => {
  let w = measure(it).width

  let sz = if w * (9 / 10.5) <= size.width { 9pt } else if w * (8.5 / 10.5) <= size.width { 8.5pt } else if w * (8 / 10.5) <= size.width { 8pt } else if w * (7.5 / 10.5) <= size.width { 7.5pt } else if w * (7 / 10.5) <= size.width { 7pt } else if w * (6.5 / 10.5) <= size.width { 6.5pt } else if w * (6 / 10.5) <= size.width { 6pt } else { 5.5pt }
  set text(size: sz)
  it
})
#set math.equation(numbering: "(1)", supplement: none)
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#let citeify(s) = {
  let re = regex("@([A-Za-z0-9_.:-]+)")
  let out = ()
  let pos = 0
  for m in s.matches(re) {
    out.push(s.slice(pos, m.start))
    let key = m.captures.at(0)
    out.push(if key.match(regex("^(thm|lemm|def|lem|cor|task|fig|tab|eq|sec):")) != none { ref(label(key)) } else { cite(label(key)) })
    pos = m.end
  }
  out.push(s.slice(pos))
  out.join()
}
#let thmbox(fam, name, body) = {
  let p = name.split("(")
  let head = p.at(0).trim()
  let title = if p.len() > 1 { p.slice(1).join("(").trim() } else { none }
  figure(
    kind: fam,
    supplement: head,
    numbering: "1",
    placement: none,
    block(width: 100%, {
      context {
        let num = counter(figure.where(kind: fam)).display()
        if title == none {
          [*#head #num.*]
        } else {
          [*#head #num (#citeify(title.replace("~", " "))).*]
        }
      }
      h(0.4em)
      set text(style: "italic")
      body
    }),
  )
}


#align(center)[
  #text(12pt, weight: "bold", [Quantum advantage in learning from experiments])   #v(1.2em)
  #text(10.5pt)[Hsin-Yuan Huang#super[1], Michael Broughton#super[3], Jordan Cotler#super[4], Sitan Chen#super[6], Jerry Li#super[8], Masoud Mohseni#super[3], Hartmut Neven#super[3], Ryan Babbush#super[3], Richard Kueng#super[9], John Preskill#super[1], Jarrod R. McClean#super[3]]
  
]
// affcenter
#align(center)[#set text(style: "italic")

  #text(9pt)[#super[1] Institute for Quantum Information and Matter, Caltech, Pasadena, CA, USA] \
  #text(9pt)[#super[2] Department of Computing and Mathematical Sciences, Caltech, Pasadena, CA, USA] \
  #text(9pt)[#super[3] Google Quantum AI, 340 Main Street, Venice, CA 90291, USA] \
  #text(9pt)[#super[4] Harvard Society of Fellows, Cambridge, MA 02138 USA] \
  #text(9pt)[#super[5] Black Hole Initiative, Cambridge, MA 02138 USA] \
  #text(9pt)[#super[6] Department of Electrical Engineering and Computer Science, University of California, Berkeley, Berkeley, CA, USA] \
  #text(9pt)[#super[7] Simons Institute for the Theory of Computing, Berkeley, CA, USA] \
  #text(9pt)[#super[8] Microsoft Research AI, Redmond, WA 98052, USA] \
  #text(9pt)[#super[9] Institute for Integrated Circuits, Johannes Kepler University Linz, Austria] \
  #text(9pt)[#super[10] AWS Center for Quantum Computing, Pasadena, CA 91125, USA] \
]
#v(1.2em)








// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: December 3, 2021)]]

Quantum technology has the potential to revolutionize how we acquire and process experimental data to learn about the physical world. An experimental setup that transduces data from a physical system to a stable quantum memory, and processes that data using a quantum computer, could have significant advantages over conventional experiments in which the physical system is measured and the outcomes are processed using a classical computer. We prove that, in various tasks, quantum machines can learn from exponentially fewer experiments than those required in conventional experiments. The exponential advantage holds in predicting properties of physical systems, performing quantum principal component analysis on noisy states, and learning approximate models of physical dynamics. In some tasks, the quantum processing needed to achieve the exponential advantage can be modest; for example, one can simultaneously learn about many noncommuting observables by processing only two copies of the system. Conducting experiments with up to 40 superconducting qubits and 1300 quantum gates, we demonstrate that a substantial quantum advantage can be realized using today's relatively noisy quantum processors. Our results highlight how quantum technology can enable powerful new strategies to learn about nature.





= Introduction
<introduction>


Humans learn about nature by doing experiments, but up until now our ability to acquire knowledge has been hampered by viewing the quantum world through a classical lens. The rapid advance of quantum technology portends an opportunity to observe the world in a fundamentally different and more powerful way. Instead of measuring physical systems and then processing the classical measurement outcomes to infer properties of the physical systems, quantum sensors @degen2017quantum will eventually be able to transduce @lauk2020perspectives quantum information in physical systems directly to a quantum memory @lvovsky2009optical@dennis2002topological, where it can be processed by a quantum computer. @fig:Cartoon(a) illustrates the distinction between #emph[conventional] and #emph[quantum-enhanced] experiments. For example, in a quantum-enhanced experiment, multiple photons might be captured and stored coherently at each node of a quantum network, and then processed coherently to extract an informative signal @PhysRevLett.109.070503@Bland-Hawthorn:21@giovannetti2011advances.


// [figvision-cn] imgs/Overview.png
// 图(a)为示意图，展示量子增强传感与经典传感的对比。左侧
// 方框标题为“Experiment”，内含“Physical world”区域，列有
// 五种物理对象：分子（Molecules，结构式图示）、病毒（
// Viruses，球形带刺突结构）、DNA（双螺旋结构）、行星（
// Planets，带环行星）、黑洞（Black holes，黑色圆球），各
// 对象旁均有波浪线表示其发出的信号或扰动。右侧为垂直排列
// 的传感器阵列（Sensor），由多个紫色原子符号（中心圆点加
// 轨道电子）堆叠而成，接收来自物理世界的信号。中间部分分
// 为上下两栏：上栏标题“Quantum-enhanced”，显示一个蓝色机
// 器人图标（头部含原子符号），两侧双向箭头分别标注“
// Quantum information”（左向）和未标注但隐含信息流（右向），
// 表明量子信息在机器人与传感器间交互；下栏标题“
// Conventional”，显示灰色机器人图标（头部为电路图案），
// 两侧双向箭头标注“Classical information”，表明经典信息
// 交互。整体布局从左至右为：物理世界→传感器→信息处理单元
// （量子/经典）。 图(b)为流程图，标题“Learning physical
// state”。上方路径为量子流程：起始为蓝色机器人图标（标“
// Quantum memory”），其右侧依次连接三个渐变色椭圆柱体（
// 紫→蓝→浅蓝），每个柱体上方有希腊字母ρ（密度矩阵）及向
// 下箭头指向柱体，表示状态输入；第三个柱体后接一个矩形框
// （内含原子符号），标注“Quantum processing +
// Measurement”。下方路径为经典流程：起始为灰色机器人图标
// （标“Classical memory”），其右侧连接两个深灰色椭圆柱体，
// 第一个柱体上方有ρ_Measure标签及相机图标，第二个柱体内
// 部列出二进制数“011 100”，随后箭头指向第三个深灰色柱体，
// 内部列出“011 100 101 011”，再经箭头指向齿轮图标矩形框，
// 标注“Classical processing”。所有箭头均为单向实线，指示
// 数据流向。 图(c)为流程图，标题“Learning physical
// process”。上方路径为量子流程：起始为紫→蓝渐变椭圆柱体，
// 其上方有两个ε（超算子）标签及向下箭头指向柱体；随后连
// 接第二个同类型柱体，同样受两个ε作用；最后连接浅蓝柱体，
// 再经箭头指向原子符号矩形框。下方路径为经典流程：起始为
// 深灰色柱体，上方有ε_Pinit标签及相机图标；接着连接第二
// 个深灰色柱体，内部列出“111 010”；再连接第三个深灰色柱
// 体，内部列出“111 010 000 110”；最后经箭头指向齿轮图标
// 矩形框。所有ε标签均位于柱体上方，箭头方向一致向右，表
// 示过程演化步骤。
#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [Table #context it.counter.display(it.numbering): #it.body]
}

#figure(scope: "parent", image("imgs/Overview.png", width: 99.0%),
  caption: [
    #emph[\(a) Quantum-enhanced experiments versus conventional experiments.] Quantum-enhanced/conventional experiments interface with a quantum/classical machine running a quantum/classical learning algorithm that can store and process quantum/classical information. #emph[\(b) Learning physical state $rho$.] Each experiment produces a physical state $rho$. In the conventional setting, we measure each $rho$ to obtain classical data (the measurement could depend on prior measurement outcomes) and store the data in a classical memory. In the quantum-enhanced setting, $rho$ can coherently alter the quantum information stored in the memory of the quantum machine (illustrated by the change in color). With large enough quantum memory, the quantum machine can simply store each copy of $rho$. After multiple rounds of experiments, quantum processing followed by a measurement is performed on the quantum memory. #emph[\(c) Learning physical process $cal(E)$.] Each experiment is an evolution under $cal(E)$. In the conventional setting, the classical machine specifies the input state to $cal(E)$ using a classical bitstring, and obtains classical measurement data @mohseni_qpt_2008. In the quantum-enhanced setting, the evolution $cal(E)$ coherently alters the memory of the quantum machine: the input state to $cal(E)$ is entangled with the quantum memory in the quantum machine and the output state is retrieved coherently by the quantum machine.
  ]
)
<fig:Cartoon>



To be more concrete, suppose that each experiment generates an $n$-qubit state $rho$, and our goal is to learn some property of $rho$\; see @fig:Cartoon. We depict #emph[conventional] and #emph[quantum-enhanced] experiments for this scenario in @fig:Cartoon\(b). In conventional experiments, each copy of $rho$ is measured separately, the measurement data is stored in a classical memory, and a classical computer outputs a prediction for the property after processing the classical data. In quantum-enhanced experiments, each copy of $rho$ is stored in a quantum memory, and then the quantum machine outputs the prediction after processing the quantum data in the quantum memory. We prove that for some tasks, the number of experiments needed to learn a desired property is exponential in $n$ using the conventional strategy, but only polynomial in $n$ using the quantum-enhanced strategy. For suitably defined tasks, we can achieve exponential quantum advantage using a protocol as simple as storing two copies of $rho$ in quantum memory and performing an entangling measurement. We also show that quantum-enhanced experiments have a similar exponential advantage in a related scenario shown in @fig:Cartoon\(c), in which the goal is to learn about a quantum process $cal(E)$ rather than a quantum state $rho$.


Building on observations in @huang2021information @chen2021exponential we prove that for a task that entails acquiring information about a large number of non-commuting observables, quantum-enhanced experiments can have an exponential advantage even when the measured quantum state is unentangled. By performing experiments with up to 40 superconducting qubits, we show that this quantum advantage persists even when using currently available quantum processors. We also demonstrate quantum advantage in learning the symmetry class of a physical evolution operator, inspired by recent theoretical advances @aharonov2021quantum @chen2021exponential. Finally, in a theoretical contribution, we rigorously prove that quantum-enhanced experiments have an exponential advantage in learning about the principal component of a noisy state, as previously indicated in @lloyd2014quantum.


In our proof-of-principle experiments, we directly execute the state preparation or process to be learned within the quantum processor. In an actual application, the quantum data analyzed by the learning algorithm might be produced by an analog quantum simulator or a gate-based quantum computer. We also envision future applications in which quantum sensors equipped with quantum processors interact coherently with the physical world. The robustness of quantum advantage with respect to noise, validated by our experiments using a noisy superconducting device, boosts our confidence that the quantum-enhanced strategies described here can be exploited someday to achieve a substantial advantage in realistic applications.


= Provable quantum advantage
<provable-quantum-advantage>
Here we present three classes of learning tasks and the associated quantum-enhanced experiments, each yielding a provable exponential advantage over conventional experiments. Each result is encapsulated by a theorem which we state informally. Precise statements and proofs are presented in the Supplemental Material. Our experimental demonstrations are discussed in @sec:experimental. The proofs proceed by representing a classical algorithm with a decision tree depicted at the center of the gray robot in @fig:Cartoon. The tree representation encodes how the classical memory changes as we obtain more experimental data. We then analyze how the transitions on the tree differ for distinct measured physical systems to provide rigorous information-theoretic lower bounds. A general mathematical framework building on~@chen2021exponential is given in @sec:separation .


The first task concerns learning about a physical system described by an $n$-qubit state $rho$. We suppose that each experiment generates one copy of $rho$. In the conventional setting, we measure each copy of $rho$ to obtain classical data. The procedure can be adaptive, that is, each measurement can depend on the data obtained in earlier measurements. In the quantum-enhanced setting, a quantum computer can store each copy of $rho$ in a quantum memory, and act jointly on multiple copies of $rho$. In both scenarios, we require all quantum data to be measured at the end of the learning phase of the procedure, so that only classical data survives. After the learning is completed, the learner is asked to provide an accurate prediction for the expectation value of one observable drawn from a set $( O_1 , O_2 , dots.h )$ where the number of observables in the set is exponentially large in $n$. The observables in the set can be highly incompatible, that is, each observable may fail to commute with many others in the set.


In prior work by some of the authors~@huang2021information @chen2021exponential, we required the learner to predict exponentially many observables, which is not possible in practice if the system size is large. In order to demonstrate the advantage in an actual device, we prove that predicting just the absolute value of one observable requires exponentially many copies in the #emph[conventional] scenario. In contrast, predicting the entire set of observables can be achieved with a polynomial number of copies in the #emph[quantum-enhanced] scenario. We thereby establish the following constant versus exponential separation. The proof is given in @sec:shadow.


#thmbox("theorem", "Theorem (Predicting observables)")[


There exists a distribution over $n$-qubit states and a set of observables such that in the conventional scenario, at least order $2^n$ experiments are needed to predict the absolute value of one observable selected from the set, while a constant number of experiments suffice in the quantum-enhanced scenario.


] <thm:observables>


The exponential quantum advantage can occur even if the state $rho$ is unentangled. For example, in our experiments we consider $rho prop ( I + alpha P )$ where $P$ is an $n$-qubit Pauli operator and $alpha in ( - 1 , 1 )$. This state can be realized as a probabilistic ensemble of product states, each of which is an eigenstate of $P$ with eigenvalue $alpha$. Even if the state is known to be of this form, but $P , alpha$ are unknown, the exponential separation between conventional and quantum-enhanced experiments persists. Moreover, the quantum advantage can be achieved by performing simple entangling measurements on pairs of copies of $rho$. That the quantum advantage applies even when correlations among the $n$ qubits are classical leads us to believe that the quantum-enhanced strategy will be beneficial in a broad class of sensing applications. In @sec:hard-bdd-mem, we extend this theorem, showing that a sufficiently large quantum memory is needed to achieve this task in the quantum-enhanced scenario.


Our second machine learning task with a quantum advantage is quantum principal component analysis (PCA) @lloyd2014quantum. In this task, each experiment produces one copy of $rho$, and our goal is to predict properties of the (first) principal component of $rho$, namely the eigenstate $| psi chevron.r$ of $rho$ with the largest eigenvalue. For example, we may want to predict the expectation values of a few observables in the state $| psi chevron.r$. This task may become a valuable ingredient in future quantum-sensing applications. If an imperfect quantum sensor transduces a detected quantum state into quantum memory, the state is likely to be corrupted by noise. But it is reasonable to expect that properties of the principal component are relatively robust with respect to noise~@koczor2021dominant, and therefore highly informative about the uncorrupted state. To perform quantum PCA, a learning algorithm was introduced in @lloyd2014quantum based on phase estimation which requires fault-tolerant quantum computers. One can also obtain information about the principal component of $rho$ using more near-term algorithms, such as virtual cooling @cotler2019quantum and virtual distillation @huggins2020virtual.


While the quantum PCA algorithm in @lloyd2014quantum is exponentially faster than known algorithms based on conventional experiments, this advantage was not proven against #emph[all] possible algorithms in the conventional scenario. Here, we rigorously establish the exponential quantum advantage for performing quantum PCA. The exponential quantum advantage also holds in the near-term proposals @cotler2019quantum @huggins2020virtual. The proofs are in @sec:qpca.


#thmbox("theorem", "Theorem (Performing quantum PCA)")[


In the conventional scenario, at least order $2^(n / 2)$ experiments are needed to learn a fixed property of the principal component of an unknown $n$-qubit quantum state, while a constant number of experiments suffice in the quantum-enhanced scenario.


] <thm:PCA>


It is worth commenting on recent results in Refs.~@tang2021quantum @chia2020sampling~showing that quantum PCA can be achieved by polynomial-time classical algorithms, which may seem to contradict @thm:PCA. Those works assume the ability to access any entry of the exponentially large matrix $rho$ to exponentially high precision in #emph[polynomial time]. Achieving such a high precision requires measuring exponentially many copies of $rho$, which takes an exponential number of experiments and #emph[exponential time]. Hence, the assumptions of @tang2021quantum @chia2020sampling do not hold here. See~@cotler2021revisiting which provides a detailed exposition of these matters.


// [figvision-cn] imgs/Exp1.png
// (a) 子图类型为流程示意图，展示了利用门控循环神经网络（
// Gated recurrent neural network）学习物理状态的过程。左
// 侧垂直标注为“N repetitions”（N次重复），包含上下两个相
// 同的处理单元，中间以垂直省略号表示更多重复。每个单元从
// 左至右依次为一个蓝色机器人图标（头部有原子符号）、三个
// 由深紫到浅蓝渐变的圆柱体、以及一个矩形框（内部有原子符
// 号）。箭头从机器人指向第一个圆柱体，再从第一个圆柱体依
// 次指向后续圆柱体，最后指向矩形框；同时，希腊字母ρ分别
// 标注在机器人至第一圆柱体、第一至第二圆柱体、第二至第三
// 圆柱体的箭头上。右侧是一个多层网络结构图，顶部标注“
// Gated recurrent neural network”。该网络由三列节点组成：
// 左列为绿色背景上的白色圆圈（部分带有灰色星形连接），中
// 列为青色背景上的白色圆圈（同样带灰色星形连接），右列为
// 紫色背景上的白色圆圈。最右侧是一列垂直排列的矩形块，颜
// 色从上到下为绿、黄、紫，旁边标注“Aggregate”，再右侧是
// 一个单独的紫色矩形块，标注“Predict”。整个流程显示数据
// 从左侧输入，经过N次重复处理后送入神经网络，最终输出预
// 测结果。 (b) 子图类型为曲线图，横轴为“Training epoch”
// （训练轮次），范围从0到10000，刻度间隔2500；纵轴无明确
// 标签但数值范围从0.0到1.0，刻度间隔0.2。图中包含三条曲
// 线：一条紫色实线波动上升并稳定在0.8以上，标注为“
// Prediction Accuracy (Q)”；一条灰色水平虚线位于约0.5处，
// 标注为“Prediction Accuracy (C)”；一条蓝色实线从约0.7下
// 降至接近0.0，标注为“Training Loss (Q)”。此外，在横坐标
// 约1000处有一条灰色垂直虚线，与蓝色曲线相交于约0.5位置，
// 并用箭头指向该交点，可能表示某个关键训练阶段或阈值点。
// 趋势表明量子模型（Q）的训练损失随轮次增加而降低，预测
// 准确率持续高于经典模型（C）的固定准确率，且最终达到较
// 高精度。 (c) 子图类型为散点图叠加折线图，横轴为“n (
// system size)”（系统尺寸），范围从2到20，刻度间隔2；纵
// 轴为“Number of experiments”（实验次数），对数刻度，范
// 围从10⁰到10⁶，主刻度为10¹, 10², ..., 10⁶。图中包含三种
// 数据系列：紫色菱形标记的实线代表“Acc ≥ 70% (Q)”，从n=2
// 时的约10¹线性增长至n=20时的约10³；灰色叉号标记的点代表
// “Acc ≥ 70% (C)”，分布在n=4至n=10之间，数量级从10¹到10⁴
// 不等；灰色虚线代表“Acc ≥ 70% (C, LB)”，即经典模型的理
// 论下界，呈指数增长趋势，从n=2时的约10¹增至n=20时的约10
// ⁵。右上角区域被灰色阴影覆盖，标注“Rigorous LB (C)”，表
// 示经典方法的严格理论下限区域。结论显示，随着系统尺寸增
// 大，量子方法（Q）所需实验次数远低于经典方法（C）及其理
// 论下界，体现量子优势。
#figure(scope: "parent", image("imgs/Exp1.png", width: 100.0%),
  caption: [
    Quantum advantage in learning physical states. #emph[\(a) Supervised machine learning (ML) model based on quantum-enhanced experiments.] $N$ repetitions of quantum-enhanced experiments are performed and the data is fed into a gated recurrent neural network (GRU) @chung2014empirical @tang2015document. The neurons in the GRU are aggregated to predict an output. #emph[\(b) Training process of the supervised ML model.] We train the supervised ML model to determine which of two $n$-qubit Pauli operators has a larger magnitude for the expectation value in an unknown state $rho$ using noiseless simulation for small system sizes $( n < 8 )$. We consider the cross entropy @murphy2012machine as the training loss. Then we use the supervised ML model to make predictions using data from noisy quantum-enhanced experiments running on the Sycamore processor @arute2019quantum for larger system sizes $( 8 lt.eq n lt.eq 20 )$. We consider the probability to predict correctly as the prediction accuracy. Random guessing yields a prediction accuracy of $0.5$. #emph[\(c) Quantum advantage in the number of experiments needed to achieve $gt.eq 70 "%"$ accuracy.] Here, (Q) corresponds to results running the supervised ML model based on quantum-enhanced experiments and (C) corresponds to results running the best known conventional strategy. The dotted line is a lower bound for any conventional strategy (C, LB) as proven in @sec:compare-abs-value. Even running on a noisy quantum processor, quantum-enhanced experiments are seen to vastly outperform the best theoretically achievable conventional results (C, LB).
  ]
)
<fig:AdvantageExpt1>



Another core task in quantum mechanics is understanding physical processes rather than states. Here, each experiment implements a physical process $cal(E)$, and we can interface with $cal(E)$ through a quantum/classical machine in the quantum-enhanced/conventional setting; see @fig:Cartoon\(c). We show that a quantum machine can learn an approximate model of any polynomial-time quantum process $cal(E)$ from only a polynomial number of experiments. Given a distribution on input states, the approximate model can predict the output state from $cal(E)$ accurately on average. In contrast, we would need an exponential number of experiments to achieve the same task in the conventional setting. The proof for general quantum processes is given in @sec:evolution.


#thmbox("theorem", "Theorem (Learning quantum processes)")[


Suppose we are given a polynomial-time physical process $cal(E)$ acting on $n$ qubits and a probability distribution over $n$-qubit input states. In the conventional scenario, at least order $2^n$ experiments are needed to learn an approximate model of $cal(E)$ that predicts output states accurately on average, while a polynomial number of experiments suffice in the quantum-enhanced scenario.


] <thm:processes>


= Demonstrations of quantum advantage
<sec:experimental>
The exponential quantum advantage captured by @thm:observables, @thm:PCA, and @thm:processes applies no matter how much classical processing power is leveraged in the conventional experiments. The conventional strategy fails because there is just no way to access enough classical data to perform the specified tasks, if the number of experiments is subexponential in $n$. But these exponential separations apply in an idealized setting where quantum states are stored and processed perfectly. Will access to quantum memory unlock a substantial quantum advantage under more realistic conditions?


For two different tasks, we have investigated the robustness of the quantum advantage by conducting experiments using a superconducting quantum processor. The first task we studied pertains to @thm:observables. The task is to approximately estimate the magnitude for the expectation value of Pauli observables. The unknown state is an unentangled $n$-qubit state $rho = 2^(- n) (I + alpha P)$, where $alpha = plus.minus 0.95$, $P$ is a Pauli operator, and both $alpha , P$ are unknown. After all measurements are completed and learning is terminated, two distinct Pauli operators $Q_1$ and $Q_2$ are announced, one of which is $P$ and the other of which is not equal to $P$. We ask the machine to determine which of $| upright("tr") (Q_1 rho) |$ and $| upright("tr") (Q_2 rho) |$ is larger.


// [figvision-cn] imgs/Exp2.png
// 图(a)为示意图，展示无监督机器学习从量子动力学数据中提
// 取一维表示的流程。图中包含两个并列的立方体框架，代表两
// 种实验设置。上方框架内左侧为一个紫色机器人图标，其头部
// 有原子符号；中间依次排列三个圆柱体，颜色从左至右由深紫
// 渐变为浅蓝，每个圆柱体上方标有蓝色箭头指向并标注“Ek”；
// 右侧为一个矩形框，内部绘有原子符号。该流程旁标注文字：
// “500 repetitions for each k=1,2,...”。下方框架结构类似，
// 但所有元素均为灰色：左侧为灰色机器人，中间三个灰色圆柱
// 体，上方有一个带指针的仪表盘图标标注“p_init”，右侧矩形
// 框内有齿轮符号。该流程旁标注文字：“1000 repetitions
// for each k=1,2,...”。两个框架之间以“— or —”分隔。下方
// 有一个向下的大箭头，指向文字“Unsupervised ML”，其后跟
// 随四个彩色条形柱（红、灰、蓝、紫）。再下方是两个椭圆形
// 区域：左侧淡紫色椭圆内含六个下标不同的ε符号（ε₃, ε₁, ε
// ₆, ε₇, ε₁₀），右侧淡粉色椭圆内含五个ε符号（ε₄, ε₉, ε₂,
// ε₅, ε₈）。最底部标注文字：“1D representation for all
// dynamics”。 图(b)标题为“1D dynamics”，包含上下两个子图。
// 上方子图标题为“Quantum-enhanced”，横轴范围为-0.25至
// 0.25，无单位标注，纵轴无刻度。图中分布两类点云：左侧为
// 蓝色点云，集中在横坐标约-0.15处；右侧为红色点云，集中
// 在横坐标约+0.15处。点云下方对应位置各有一个机器人图标
// （左侧紫色，右侧灰色）及对应的垂直条形图（左蓝右红）。
// 下方子图标题为“Conventional”，横轴同样为-0.25至0.25。
// 图中点云呈混合状态，蓝色与红色点在横坐标中心附近重叠，
// 无明显分离。下方同样配有灰色机器人图标和混合颜色的垂直
// 条形图。两子图共享一个图例：蓝色菱形标记“General”，红
// 色圆形标记“T-symmetric”。底部统一标注“1D
// representation”。 图(c)标题为“2D dynamics”，结构与图(b
// )完全相同。上方子图“Quantum-enhanced”中，蓝色点云位于
// 横坐标约-0.15，红色点云位于约+0.15，清晰分离；下方子图
// “Conventional”中，蓝红点云在中心区域高度重叠。同样配有
// 机器人图标、条形图、图例及“1D representation”标注。 图
// (d)标题为“Sycamore processor”，分为上下两部分，分别对
// 应1D和2D系统布局。上半部分右下角标有蓝色方块“1D”，下半
// 部分右下角标有蓝色方块“2D”。图中网格由多种符号构成：灰
// 色加号“+”代表Qubits；蓝色实心方块代表Adjustable
// coupler；红色空心方框代表System qubit；蓝色空心方框代
// 表Memory qubit。上半部分（1D）显示一条斜向链状结构，由
// 交替的红框和蓝框组成，周围散布灰色加号和蓝色方块。下半
// 部分（2D）显示一个更密集的二维网格，其中红框和蓝框形成
// 规则阵列，外围环绕灰色加号和蓝色方块。左下角提供完整图
// 例：灰色“+”对应Qubits，蓝色方块对应Adjustable coupler，
// 红色空心方框对应System qubit，蓝色空心方框对应Memory
// qubit。
#figure(scope: "parent", image("imgs/Exp2.png", width: 96.0%),
  caption: [
    Quantum advantage in learning physical dynamics. #emph[\(a) Unsupervised machine learning (ML) model.] We perform $500$ repetitions of quantum-enhanced experiments (each accessing $cal(E)_k$ twice) for every physical process $cal(E)_k$, and feed the data into an unsupervised ML model (Gaussian kernel PCA @scholkopf1998nonlinear) to learn a one-dimensional representation for describing distinct physical dynamics $cal(E)_1 , cal(E)_2 , dots.h$. Similarly, we also consider applying unsupervised ML to data obtained from $1000$ repetitions of the best known conventional experiments (each accessing $cal(E)_k$ once) for every physical process $cal(E)_k$. #emph[\(b) Representation learned by unsupervised ML for 1D dynamics.] Each point corresponds to a distinct physical process~$cal(E)_k$. The vertical line at the bottom shows the exact 1D representation of each $cal(E)_k$. Half of the processes satisfy time-reversal symmetry (blue diamonds) while the other half of them do not (red circles). When fed with data from quantum-enhanced experiments, the ML model accurately discovers the underlying symmetry pattern. In contrast, the ML model fails to do so when fed with data from conventional experiments. #emph[\(c) Representation learned by unsupervised ML for 2D dynamics.] #emph[\(d) The geometry implemented on the Sycamore processor @arute2019quantum.] We consider two different classes of connectivity geometry for implementing 1D (top) and 2D (bottom) dynamics.
  ]
)
<fig:AdvantageExpt2>



In the conventional scenario, where copies of $rho$ are measured one by one, the best known strategy is to use randomized Clifford measurements requiring an exponential number of copies to achieve the task with reasonable success probability~@huang2020predicting @huang2021information. In the quantum-enhanced scenario, copies of $rho$ are deposited in quantum memory two at a time, and a Bell measurement across the two copies is performed to extract a snapshot of the state. We then feed the snapshots into a supervised machine learning (ML) model based on a gated recurrent neural network @chung2014empirical @tang2015document @goodfellow2016deep to make a prediction, as depicted in @fig:AdvantageExpt1\(a). We train the neural network using noiseless simulation data for small system sizes $( n < 8 )$. Then we use the neural network to make predictions when we are provided with experimental data for large system sizes $( 8 lt.eq n lt.eq 20 )$. We report the prediction accuracy, which is equal to the probability for correctly answering whether $| upright("tr") (Q_1 rho) |$ or $| upright("tr") (Q_2 rho) |$ is larger. @fig:AdvantageExpt1\(b) shows the performance of the ML model as we train the neural network. @fig:AdvantageExpt1\(c) depicts, as a function of the system size $n$, the number of experiments needed in each scenario to achieve $70 "%"$ prediction accuracy. We show the experimental results when using conventional and quantum-enhanced experiments, along with a theoretical lower bound on the number of experiments needed in the conventional scenario as proven in @sec:compare-abs-value. Despite the noisy storage and processing in the experimental device, we observe a significant quantum advantage.


The second task we studied, which pertains to @thm:processes, is inspired by the recent observation that quantum-enhanced experiments can efficiently identify the symmetry class of a quantum evolution operator, while conventional experiments cannot @aharonov2021quantum @chen2021exponential. An unknown $n$-qubit quantum evolution operator is presented, drawn either from the class of all unitary transformations, or from the class of time-reversal-symmetric unitary transformations (i.e., real orthogonal transformations). We consider whether an unsupervised ML can learn to recognize the symmetry class of the unknown evolution operator based on data obtained from either quantum-enhanced experiments or conventional experiments. An illustration is shown in @fig:AdvantageExpt2\(a).


In the conventional scenario, we repeatedly apply the unknown evolution operator to the initial state $| 0 chevron.r^(⊗ n)$, and then measure each qubit of the output state in the $Y$-basis. Under $T$-symmetric evolution the output state has purely real amplitudes; hence the expectation value of any purely imaginary observable, such as the Pauli-$Y$ operator, is always zero. In contrast, the expectation value of $Y$ after general unitary evolution is generically nonzero, but may be exponentially small and hence hard to distinguish from zero. In the quantum-enhanced scenario, we make use of $n$ additional memory qubits. We prepare an initial state in which the $n$ system qubits are entangled with the $n$ memory qubits, evolve the system qubits under the unknown evolution operator, swap the system and memory qubits, evolve the system qubits again, and finally perform $n$ Bell measurements, each acting on one system qubit and one memory qubit.


Each evolution operator is a one-dimensional or two-dimensional $n$-qubit quantum circuit as shown in @fig:AdvantageExpt2\(d). After sampling many different evolution operators from both symmetry classes (and obtaining data from each sampled evolution multiple times), we use an unsupervised ML model (kernel PCA @scholkopf1998nonlinear) to find a one-dimensional representation of the evolution operators. The representations learned by the unsupervised ML model are shown in @fig:AdvantageExpt2\(b, c). Using the quantum-enhanced data, the ML model discovers a clean separation between the two symmetry classes, while there is no discernable separation into classes when using data from conventional experiments. The signal from the quantum-enhanced experiments is strong enough that the two classes are easily recognized without access to any labeled training data.


= Outlook
<outlook>


We have investigated how quantum technology can enhance our ability to discover new phenomena occurring in nature. For a variety of tasks, we proved that quantum-enhanced strategies using quantum memory and quantum processing can predict properties of physical systems using exponentially fewer experiments than conventional strategies. This exponential advantage is achievable even if the amount of classical processing used in the conventional strategies is unlimited, and even when the physical system exhibits only classical correlations. While many previous studies of quantum advantage have focused on computational tasks with known inputs, our work focuses instead on learning tasks, where the goal is to learn about an a priori unknown physical system. This work provides a new approach to understanding and achieving quantum advantage in quantum machine learning @biamonte2017quantum @broughton2021tensorflow and quantum sensing @degen2017quantum.


Our experiments with up to 40 qubits in a superconducting quantum processor show that a substantial quantum advantage is already evident when using today's noisy intermediate-scale quantum platforms @preskill2018quantum. These experiments demonstrate that supervised and unsupervised machine learning models @goodfellow2016deep @mohri2018foundations employing data obtained from quantum-enhanced experiments can predict properties and discover underlying structure in physical systems that are beyond the scope of conventional experiments.


We envision that future quantum sensing systems will be able to transduce detected quantum data to a quantum memory and then process the stored data using a quantum computer. Lacking for now suitably advanced sensors and transducers, we have conducted proof-of-concept experiments in which quantum data is directly planted in our quantum processor. Nevertheless, the robust quantum advantage we have validated highlights the potential for advancing quantum platforms to unlock facets of nature that would otherwise remain concealed.


#heading(level: 2, numbering: none)[Acknowledgments:]
<acknowledgments>


The quantum hardware used for this experiment was developed by the Google Quantum AI hardware team, under the direction of Anthony Megrant, Julian Kelly and Yu Chen. Methods for device calibrations were developed by the physics team led by Vadim Smelyanskiy. Data was collected via cloud access through Google's Quantum Computing Service. HH is supported by a Google PhD Fellowship. JC is supported by a Junior Fellowship from the Harvard Society of Fellows, the Black Hole Initiative, as well as in part by the Department of Energy under grant DE-SC0007870. SC is supported by the National Science Foundation under Award 2103300 and was visiting the Simons Institute for the Theory of Computing while part of this work was completed. JP acknowledges funding from the U.S. Department of Energy Office of Science, Office of Advanced Scientific Computing Research, (DE-NA0003525, DE-SC0020290), and the National Science Foundation (PHY-1733907). The Institute for Quantum Information and Matter is an NSF Physics Frontiers Center.








#block[
#strong[Supplementary information]

]











#strong[@sec:exper-detail.~~#link(<sec:exper-detail>)[Experimental details]] #strong[]


#block[
#link(<sec:gen-descr>)[General description] $bullet$ #link(<sec:learn-state-detail>)[Experiments on learning physical states] $bullet$ #link(<sec:learn-dyn>)[Experiments on learning physical dynamics] $bullet$ #link(<sec:additional-exp>)[Additional experimental results] $bullet$ #link(<sec:PerformanceData>)[Performance and characterization data]

]


#strong[@sec:review.~~#link(<sec:review>)[A brief review on quantum information theory]] #strong[]


#block[
#link(<sec:Qprocess>)[Definition and properties of quantum processes] $bullet$ #link(<sec:POVMdef>)[Definition and properties of POVMs]

]


#strong[@sec:separation.~~#link(<sec:separation>)[Mathematical framework for proving exponential advantage]] #strong[]


#block[
#link(<sec:tree-def>)[Tree representation] $bullet$ #link(<sec:many-v-one>)[Many-versus-one distinguishing tasks] $bullet$ #link(<sec:many-vs-many>)[Many-versus-many distinguishing task] $bullet$ #link(<sec:part-many-v-one>)[Partially-revealed many-versus-one distinguishing task] $bullet$ #link(<sec:noisedegradation>)[Presence of noise] $bullet$ #link(<sec:related-work>)[Related works]

]


#strong[@sec:shadow.~~#link(<sec:shadow>)[Predicting highly-incompatible observables]] #strong[]


#block[
#link(<sec:expo-adv-abs-one>)[Exponential advantage in predicting absolute value of a single observable] $bullet$ #link(<sec:uppbd-obs>)[A constant upper bound for quantum-enhanced experiments] $bullet$ #link(<sec:lowbd-obs>)[An exponential lower bound for conventional experiments] #link(<sec:compare-abs-value>)[An exponential lower bound for comparing absolute values] $bullet$

]


#strong[@sec:qpca.~~#link(<sec:qpca>)[Performing quantum principal component analysis]] #strong[]


#block[
#link(<sec:conv-exp-LB-pca>)[An exponential lower bound for conventional experiments] $bullet$ #link(<sec:pseudo>)[An exponential lower bound using pseudorandomness]

]


#strong[@sec:evolution.~~#link(<sec:evolution>)[Learning a polynomial-time quantum process]] #strong[]


#block[
#link(<sec:learn-process-setting>)[Problem setting] $bullet$ #link(<sec:rigor-learn-process>)[Rigorous statements] $bullet$ #link(<sec:poly-proc>)[Proof of polynomial upper bound in @thm:poly-upp-learn-proc]

]


#strong[@sec:hard-bdd-mem.~~#link(<sec:hard-bdd-mem>)[Predicting highly-incompatible observables with bounded quantum memory]] #strong[]


#block[
#link(<sec:background1>)[Background and statement of results] $bullet$ #link(<sec:revew-bdd-qmem>)[Review of learning tree framework for bounded quantum memories] $bullet$ #link(<sec:hardness-smallqmem>)[Hardness result for small quantum memories]

]


= Experimental details
<sec:exper-detail>


In this section, we present the details for the physical experiments ran on the superconducting processor as well as the supervised/unsupervised machine learning models used to analyze the data.


== General description
<sec:gen-descr>


The experiments were performed on a Google Sycamore processor containing up to 53 superconducting transmon qubits. The largest error source in the Sycamore processor @arute2019quantum is qubit readout error, which ranges from $3 "%"$ to $7 "%"$. The second largest error source is the two-qubit gate with an error around $0.5 "%"$ to $1.5 "%"$. Single-qubit gates have the smallest error around $0.05 "%"$ to $0.5 "%"$. The Sycamore chip was introduced in Ref.~@arute2019quantum, where additional details concerning the hardware implementation and performance can be found. The Sycamore chip was controlled remotely using an internal cloud interface programmed using Cirq @cirq_developers_2021_5182845 and TensorFlow Quantum @broughton2021tensorflow. The layout of the chip including connectivity is depicted in Supp.~@fig:Geometry\(a).


For all of our experiments on learning about states and dynamics, the total number of qubits was varied from 4 to 40 qubits (where in each case half of the qubits are used to simulate a physical system). As the system size was varied, the subset of qubits used for the experiments was varied in order to maximize experimental performance and minimize any overhead related to the 2D connectivity. That is, the largest contiguous patches with low gate and measurement error rates were selected, and swap operations were used to meet connectivity requirements when necessary. The experimental requirements for learning states, 1D dynamics, and 2D dynamics differ considerably in their experimental complexity.


In all experiments, the implementations of the unknown states or dynamics are performed in the quantum processor, where the learning algorithms do not know about them. While this is only an emulation of the process of data collection from a physical system in an actual sensing experiment, it allows us to examine the proposed pipeline for quantum data processing in a situation where data collection is imperfect.


== Experiments on learning physical states
<sec:learn-state-detail>


We separate this subsection into the concrete procedure for generating the unknown states, the conventional experiments we run, the quantum-enhanced experiments we run, and the supervised neural network model for making prediction based on data from quantum-enhanced experiments.


=== Procedure for generating the class of unknown states
<sec:state-I-P>


The state preparation we consider is relatively simple in that the unknown state $rho$ is unentangled, but has strong non-local classical correlations. In the experimental demonstration we consider states of the form $rho = 2^(- n) (I + alpha P)$, where $alpha in ( - 0.95 , 0.95 )$, $P = ⨂_(i = 1)^n P_i$ is an $n$-qubit Pauli operator, and both $alpha$ and $P$ are unknown. The state $rho = 2^(- n) (I + alpha P)$ is prepared by a randomized constant-depth circuit described in the following. To generate one copy of $rho$, we introduce a parameter $eta = upright("sign") ( alpha )$. Then for each qubit $i = 1 , dots.h , n$, we do the following.

+ If $P_i = I$, then we set qubit $i$ to be $| 0 chevron.r chevron.l 0 |$ with probability $1 / 2$, and be $| 1 chevron.r chevron.l 1 |$ with probability $1 / 2$.

+ If $P_i eq.not I$ and there exists $j > i$ such that $P_j eq.not I$, then we set qubit $i$ to be one of the two eigenstates of $P_i$ with equal probability. We multiply $eta$ by the eigenvalue ($+ 1$ or $- 1$) of the selected eigenstate of $P_i$.

+ If $P_i eq.not I$ and there does not exist $j > i$ such that $P_j eq.not I$, then we use the following procedure.

  + With probability $0.05$, we set qubit $i$ to be either $| 0 chevron.r chevron.l 0 |$ or $| 1 chevron.r chevron.l 1 |$ with equal probability.

  + With probability $0.95$, we set qubit $i$ to be the positive eigenstate of $P_i$ if $eta = + 1$, and set qubit $i$ to be the negative eigenstate of $P_i$ if $eta = - 1$.

By construction, the density operator prepared by this procedure is realized as an ensemble of pure states, where each pure state is a tensor product of Pauli operator eigenstates. Therefore, there is no quantum entanglement across different qubits. Furthermore, step 3 is designed to assure that $| "tr" (P rho) | = 0.95$.


// [figvision-cn] imgs/Geometry.png
// 该图包含三个并列的示意图，分别标记为(a)、(b)和(c)，展
// 示了量子比特阵列在不同配置下的结构。所有子图均基于相同
// 的底层网格布局：由灰色“X”符号代表量子比特（Qubits），
// 排列成规则的斜向晶格；相邻量子比特之间通过蓝色实心方块
// 连接，代表可调耦合器（Adjustable coupler）。在三个子图
// 中，部分位置存在一个白色空心“X”，表示该处无量子比特或
// 处于空置状态。 子图(a)：仅显示基础架构。灰色“X”均匀分
// 布于整个网格，每个相邻对之间均有蓝色方块连接。左下角图
// 例标明：“+ Qubits”对应灰色“X”，“Adjustable coupler”对
// 应蓝色方块。无任何其他颜色或附加元素。此图传达的是系统
// 初始未编程状态，所有耦合器均可调但尚未被指定功能。 子
// 图(b)：在(a)基础上，部分蓝色耦合器被替换为红色边框的空
// 心矩形，内部仍保留蓝色填充。这些红框区域沿对角线方向形
// 成连续带状结构，从左上至右下贯穿图像中部。另有少量独立
// 红框出现在边缘区域。右下角有两个标注箭头指向不同组合：
// 左侧箭头指向一个蓝底白边矩形与一个红底白边矩形并排组成
// 的单元，标注为“System qubit”；右侧箭头指向两个相同结构
// 的单元（均为蓝底白边与红底白边并排）组成的更大单元，标
// 注为“Memory qubit”。这表明系统已部分编程，某些耦合器被
// 激活用于构建系统量子比特和记忆量子比特的复合结构。整体
// 趋势是局部区域开始承担特定逻辑功能。 子图(c)：相比(b)，
// 更多蓝色耦合器被转换为红框结构，且红框覆盖范围更广、更
// 密集，几乎填满整个中心区域，仅在边界保留少量原始蓝色耦
// 合器。红框同样以对角线带状分布为主，但密度更高，形成更
// 完整的逻辑模块网络。标注方式与(b)完全一致，即“System
// qubit”和“Memory qubit”的定义不变。此图传达的是系统进一
// 步编程后的状态，大部分可调耦合器已被重新配置为功能性量
// 子比特组件，表明系统正逐步实现复杂量子电路的构建。 三
// 幅图共同展示了一个可编程量子处理器中，通过调整耦合器状
// 态来动态定义系统量子比特与记忆量子比特的过程，体现了硬
// 件重配置能力随时间或控制指令演进的三个阶段。
#figure(scope: "parent", image("imgs/Geometry.png", width: 98.0%),
  caption: [
    #emph[\(a) Layout of a Google Sycamore processor.] There is a total of $53$ superconducting transmon qubits (the qubit corresponding to an empty cross is out of order). The blue rectangles show the adjustable couplers that can apply the entangling two-qubit gate $upright("SYC")$ to neighboring qubits. #emph[\(b) Layout used for learning states and for learning 1D dynamics.] We partition the $40$ qubits into $20$ system qubits and $20$ memory qubits. Either an unknown state of the system qubits is prepared, or an unknown process is applied to the system qubits. #emph[\(c) Layout used for learning 2D dynamics.]
  ]
)
<fig:Geometry>



=== Conventional experiments
<conventional-experiments>


In the conventional setting, the optimal strategy (up to logarithmic factors) for estimating expectation values of high-weight $n$-qubit Pauli observables uses classical shadow tomography based on randomized Clifford measurements @huang2020predicting. Using this strategy, in each experiment we randomly sample a unitary transformation from the Clifford group, apply the sampled transformation to the unknown state $rho$, and then measure in the computational basis. Although such randomized Clifford measurements can be executed using quantum circuits of polynomial size, the required circuits are too large to be performed accurately with today's noisy quantum devices except for quite modest values of $n$. Furthermore, the classical post-processing of the measurement results has complexity exponential in $n$.


In our conventional experiments, because randomized Clifford measurements are infeasible we instead use classical shadow tomography based on randomized Pauli measurements @huang2020predicting. Using this strategy, in each experiment, we randomly sample from depth-$1$ Clifford circuits, apply the sampled circuit to $rho$, and then measure in the computational basis. That is, for each of the $n$ qubits, we decide uniformly at random to measure one of the three Pauli observables $X$, $Y$, or $Z$. Many such measurements are performed, each time on a new copy of $rho$, and the classical data collected is post-processed to predict expectation values of observables in the state $rho$.


Classical shadow tomography based on randomized Pauli measurements is a powerful technique that enables classical ML models to predict quantum many-body ground states and quantum phases of matter with rigorous guarantees @huang2021provably. However, for the task of estimating the expectation value of an $n$-qubit Pauli observable that is announced after all measurements are completed, both randomized Clifford and randomized Pauli measurements require a number of experiments that scale exponentially in $n$, as we have proven in @sec:compare-abs-value. Likewise, exponentially many experiments are needed to perform @task:comp-abs defined in @sec:compare-abs-value with high success probability. In @fig:AdvantageExpt1\(b), we report the average prediction accuracy (the probability of performing @task:comp-abs successfully) over system sizes $n = 8 , 10 , 12 , 14 , 16 , 18 , 20$. For each $n$-qubit state $rho$, we conduct $1000$ experiments to obtain the measurement data. The prediction accuracy is indicated by the gray point shown on the vertical axis, which is only slightly better than random guessing ($0.5$). For system sizes $n gt.eq 10$, the prediction accuracy is very close to $0.5$. Classical shadow tomography based on randomized Pauli measurements is a statistical estimation procedure that has no training phase. Therefore, the prediction accuracy for conventional experiments is a single point @fig:AdvantageExpt1\(b). The training epoch on the horizontal axis in @fig:AdvantageExpt1\(b) is only for quantum-enhanced strategy. In @fig:AdvantageExpt1\(c), we report the number of experiments required to achieve a prediction accuracy of at least $70 "%"$ for different system sizes. We consider a maximum of $5000$ experiments. For system size $n gt.eq 10$, we are unable to achieve at least $70 "%"$ prediction accuracy with $5000$ experiments. Hence we only show system size $n = 2 , 4 , 6 , 8$ for conventional experiments in @fig:AdvantageExpt1\(c).


=== Quantum-enhanced experiments
<quantum-enhanced-experiments>


Quantum-enhanced experiments are executed by performing an entangling Bell measurement across two copies of $rho$. We prepare the state $rho$ on the system qubits (marked blue in Supp.~@fig:Geometry), swap the state to the memory qubits (marked red), prepare another state $rho$ on the system qubits, then perform an entangling Bell measurement across the two copies of $rho$. Note that every preparation of $rho$ generates a random product state according to a classical probability distribution described in #ref(<sec:state-I-P>).


For each system size $n = 2 , dots.h , 20$, we choose $n$ qubits from among the $20$ pairs of qubits shown in Supp.~@fig:Geometry\(b); these pairs are selected to minimize errors in the state preparations, gates, and measurements. Because the state $rho$ is not entangled, no entangling gates are used during the state preparation; therefore there is no advantage in choosing the pairs of qubits to be in proximity to one another. For each system size $n$, we use the same qubits for the conventional experiments as for the quantum-enhanced experiments, except that in conventional experiments we prepare the unknown state $rho$ only on the system qubits, and then perform a randomized Pauli measurement of the system immediatly after the state preparation.


While a Bell measurement on a pair of qubits can be performed via a simple circuit containing one Hadamard gate, one CNOT gate, and two $Z$-basis measurements, we instead compile these operations into operations better suited for the Sycamore processor. In particular, the native two-qubit entangling gate is the Sycamore Gate, which has a unitary matrix representation given by


$ upright("SYC") = upright(" iSWAP")^dagger upright(" CPHASE") ( - pi / 6 ) = mat(delim: "(", 1, 0, 0, 0; 0, 0, - i, 0; 0, - i, 0, 0; 0, 0, 0, e^(- i pi / 6)) . $


Using this gate, the Bell state measurements may be performed by the gate sequence needed to unprepare a Bell state, which when compiled to Sycamore's native gates is expressed as a product of SYC gates and phased XZ gates ($upright("PhXZ")_i$). The phased XZ gate $upright("PhXZ")_i$ on the $i$-th qubit is a native gate on the Sycamore device that can be expressed as


$ upright("PhXZ") ( a , x , z )_i = Z_i^z Z_i^a X_i^x Z_i^(- a) . $


where $X_i$ and $Z_i$ are the standard Pauli operators acting on qubit $i$, and the exponents $a$, $x$, $z$ are real numbers. The particular angles ($a , x , z$) for each of the gates used in our experiments were compiled numerically via a variational optimization. As the inverse Sycamore is not a native gate of the architecture, the compilations to hardware for inverse gates have to compensate for this difference, which we do numerically. The full decomposition of all the gates and circuits we reference are provided as Cirq circuits in additional supplemental material.


Each quantum-enhanced experiment generates a classical bitstring of size $2 n$. We collect the bitstrings from all experiments and feed them into a neural network model. In addition to the experimental data, the neural network model also takes in two Pauli strings $Q_1 , Q_2$ and predicts which one of $| "tr" ( Q_1 rho ) |$ and $| "tr" ( Q_2 rho ) |$ is larger. In @fig:AdvantageExpt1\(b), we repeat each quantum-enhanced experiments $500$ times. This provides a fair comparison with conventional experiments because two copies of the unknown state $rho$ are used in each quantum-enhanced experiment; therefore a total of $1000$ copies are consumed in both our conventional and quantum-enhanced experiments. In @fig:AdvantageExpt1\(c), we repeat quantum-enhanced experiments for a maximum of $500$ times over different system sizes from $n = 2 , 4 , 6 , 8 , 10 , 12 , 14 , 16 , 18 , 20$.


=== A supervised neural network model using data from quantum-enhanced experiments
<sec:NN-data-Q>


We train a supervised neural network model using noiseless simulation data from small system sizes. Then we use the trained neural network model on the noisy experimental data obtained from performing quantum-enhanced experiments. The neural network model has three layers. Each of the outer layers runs the preceding inner layer multiple times. In the following, we describe each layer of the neural network model.

+ The #emph[inner layer] is a recurrent neural network based on gated recurrent unit (GRU) @chung2014empirical @tang2015document @goodfellow2016deep. The recurrent neural network takes in a size-$2 n$ bitstring, corresponding to the measurement outcome from a single quantum-enhanced experiment, and an $n$-qubit Pauli operator $Q$, which can be represented as a size-$2 n$ bitstring. The recurrent neural network outputs a two-dimensional real vector. Other popular choices of recurrent units, such as long short-term memory (LSTM) @sepp1997lstm or transformer @vaswani2017attention, could be used instead of GRU.

+ The #emph[intermediate layer] is an aggregation layer. This layer runs the inner layer for all the bitstrings obtained from each of the quantum-enhanced experiments. For example, if we run the quantum-enhanced experiments for $100$ times, we would obtain $100$ size-$2 n$ bitstring and we would run the inner layer for $100$ times over each bitstring. The intermediate layer outputs the average of the two-dimensional output vectors from the multiple runs of the inner layers.

+ The #emph[outer layer] is inspired by a Siamese neural network (twin neural network) @koch2015siamese. This layer runs the intermediate layer twice, one for each of the two Pauli operators $Q_1$ and $Q_2$. Each intermediate layer generates a real-valued vector $x$ of dimension two, which we map to a single real value by considering $x_1 - x_2$. The outer layer compares the real value from the two intermediate layers and outputs $Q_1$ or $Q_2$ based on which one of them has a higher real value.

The specific details of the above neural network structure is given in the accompanying code repository#footnote[#link("https://github.com/quantumlib/ReCirq/tree/master/recirq/qml_lfe")].


In the inner layer, we create a recurrent neural network with an encoding layer that maps an integer between $0$ and $15$ to a vector of dimension $30$, a GRU with $30$ neurons, and a decoding layer that maps $30$ neurons to $2$ neurons. Only the inner layer contains trainable parameters. The intermediate layer and the outer layer are both fixed operations based on outputs from the inner layer, which will not be updated.


Next, we discuss the process for training the neural network model. We use noiseless simulation data (for small system sizes $n < 8$) to train the recurrent neural network. During training, we pick a state $rho = 2^(- n) (I + alpha P)$ where $alpha in ( - 0.95 , 0.95 )$ and $P$ is an $n$-qubit Pauli operator, and pick an $n$-qubit Pauli operator $Q$ that is equal to $P$ with probability $1 / 2$ and is not equal to $P$ with probability $1 / 2$. We encode the training data into two tensors, `inp` and `target`. The encoding is defined by the following.

- The tensor `inp` is of size $b times n$, where $b$ is the number of quantum-enhanced experiments we performed, $n$ is the number of qubits, and each entry of `inp` is an integer from $0$ to $15$. The $( t , i )$-th entry of `inp` encodes the component of $Q$ on qubit $i$ (a choice of $4$ for $I , X , Y , Z$) and the Bell measurement outcome on qubit $i$ from the $t$-th quantum-enhanced experiment (also a choice of $4$). Each entry takes a total of $16$ possible values.

- The tensor `target` is of size $1$. The entry in `target` is equal to $1$ if $P = Q$, and is equal to $0$ if $P eq.not Q$.

We update the neural network model once using `inp` of size $b times n$ and `target` of size $1$. We are using the cross entropy loss and employ the Adam optimizer @kingma2014adam, which is a gradient-based optimization algorithm that adaptively estimates lower-order moments. We generate multiple different states $rho$ and $Q$ corresponding to different `inp` and `target` to train the neural network model.


During the training process, we are not using the #emph[outer layer]. Also, we simultaneously run the $b$ repetitions of the inner layer for each outcome from a single quantum-enhanced experiment by leveraging parallel computing. Then, we average over the $b$ repetitions of the inner layer. Also, the output of the neural network model is a two-dimensional real vector, denoted as $v = ( v_0 , v_1 )$. When `target` is $a in ( 0 , 1 )$, the loss function is given by


$ - log (frac(upright(e)^(v_a), upright(e)^(v_0) + upright(e)^(v_1))) . $


The two real values $v_0$, $v_1$ are combined to produce a probability distribution


$ frac(upright(e)^(v_0), upright(e)^(v_0) + upright(e)^(v_1)) = 1 - frac(1, upright(e)^(v_0 - v_1) + 1) , quad frac(upright(e)^(v_1), upright(e)^(v_0) + upright(e)^(v_1)) = frac(1, upright(e)^(v_0 - v_1) + 1) , $
<eq:prob-NN>


indicating which of $a = 0$ and $a = 1$ is more likely. If $v_0 - v_1$ is large, then $a = 0$ corresponding to $P eq.not Q$ is more likely. On the other hand, if $v_0 - v_1$ is small, then $a = 1$ corresponding to $P = Q$ is more likely. We compute the gradient through back-propagation and update the model using the Adam optimizer @kingma2014adam.


Finally, we discuss the prediction process in the neural network model. Due to the significant amount of measurement errors, we employ a form of measurement error mitigation. We first characterize the measurement errors for every qubit assuming the zero state preparations and $X$-gates are perfect. For each qubit $i$, we obtain a $2 times 2$ matrix specifying the probability to measure $0$ or $1$ if the qubit is in $| 0 chevron.r chevron.l 0 |$ or $| 1 chevron.r chevron.l 1 |$. We store that as a list of $2 times 2$ matrices called `calib_2x2`. We then expand the data, referred to as `data` in the pseudo-code, obtained from the quantum-enhanced experiments, which is a two-dimensional array of size $b times ( 2 n )$. Basically, we expand each measurement to $20$ measurements with a real-valued coefficient associated to each of the expanded measurements. Therefore, `data_expanded` is a two-dimensional array of size $( 20 b ) times ( 2 n )$ and `coefficients` is a one-dimensional array of size $20 b$.

#block[
def noise\_inversion(data, calib\_2x2, inverse\_cnt=20): Set data\_expanded as an empty array Set list\_of\_coefficients as an empty array

]


for t from 0 to b-1: for r from 0 to inverse\_cnt-1: Set single\_data as an empty array Set coefficient as 1.0


for i from 0 to 2n-1: Set p as calib\_2x2[i][1, 1] if data[t][i] = 0 Set p as calib\_2x2[i][0, 0] if data[t][i] = 1




 python


After obtaining `data_expanded`, we construct two tensors `inp1` and `inp2` corresponding to the same experimental data `data_expanded`, but different Pauli operators $Q_1 , Q_2$. Both `inp1` and `inp2` are tensors of size $( 20 b ) times n$, where $b$ is the number of quantum-enhanced experiments we performed, $n$ is the number of qubits, and each entry of `inp1` and `inp2` is an integer from $0$ to $15$ similar to the training process. Then the neural network make a prediction using the two input tensors `inp1` and `inp2`. In the #emph[outer layer], the neural network model runs the #emph[intermediate layer] (as well as the multiple repetitions of #emph[inner layer]) for each of the two input tensors to obtain two 2D vectors denoted as $u = ( u_0 , u_1 ) , v = ( v_0 , v_1 )$. From the discussion given around @eq:prob-NN. If $u_0 - u_1$ is small, then it is more likely that $P = Q_1$. If $v_0 - v_1$ is small, then it is more likely that $P = Q_2$. The neural network hence compare $u_0 - u_1$ and $v_0 - v_1$ to predict whether $P = Q_1$ or $P = Q_2$.


== Experiments on learning physical dynamics
<sec:learn-dyn>


For the task of learning about physical dynamics in 1D and 2D, we considered unitary transformations implemented by 1D and 2D random quantum circuits. We generated many random circuits, half of which are time-reversal symmetric (i.e., real orthogonal), and half of which are general unitary circuits without any symmetry. For each of these circuits, we performed both conventional and quantum-enhanced experiments to generate classical measurement data. This data was fed to an unsupervised machine learning model to learn a low-dimensional classical representation of the physical dynamics. We wished to see whether the unsupervised ML model could recognize the difference between time-reversal symmetric dynamics and general dynamics. The results summarized in @fig:AdvantageExpt2 were obtained in experiments analyzing $180$ different circuits in each of the the two classes, using methods described below. The largest quantum circuits we ran on the Sycamore processor are presented in #ref(<tab:scrambling-circuits>).


#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([], [  #strong[Number of qubits]  ], [  #strong[Number of gates]  ], [  #strong[Circuit depth]  ],),
    table.hline(),
    [#strong[1D dynamics]  ], [#strong[40]], [#strong[842]], [#strong[40]],
    [#strong[2D dynamics]  ], [#strong[40]], [#strong[1388]], [#strong[54]],
  )]
  , caption: [Circuit information for the experiments on learning physical dynamics. ]
  , kind: table
  )

<tab:scrambling-circuits>



In @aharonov2021quantum, a restricted subclass of conventional strategies was shown to require an exponential number of experiments to distinguish between general unitary dynamics and time-reversal-symmetric dynamics. In @chen2021exponential, some of the authors of the present work have shown that an exponential number of experiments are required for this task even when arbitrary conventional strategies are allowed. Furthermore, it is plausible that under appropriate cryptographic assumptions, the superpolynomial difficulty of characterizing quantum dynamics in conventional experiments would persist even for psuedo-random dynamical processes that can be efficiently generated on a quantum computer. However, at present, explicit constructions of cryptographically-secure pseudo-random unitaries are not known. In light of this, in our experiments we resort to studying random quantum circuits similar to those used for demonstrating quantum computational supremacy @arute2019quantum.


In this subsection, we provide further details regarding how our samples of 1D dynamics and 2D dynamics are generated, how our experiments are conducted, and how our unsupervised machine learning model works. As we will see, the unsupervised ML successfully learns to classify quantum circuits into symmetry classes when provided with data from quantum-enhanced experiments, but not when provided with data from conventional experiments.


=== 1D dynamics
<d-dynamics>


We use the layout provided in Supp.~@fig:Geometry\(b). A 1D circuit is implemented along the 1D line connecting all the qubits circled in blue. For system size $n < 20$, we consider a contiguous region on the 1D line with the smallest gate/measurement error. For general unitary dynamics, we use a 1D version of the quantum supremacy circuit @arute2019quantum. The quantum supremacy circuit in 1D interleaves between a layer of random single-qubit gates and a layer of two-qubit entangling gates, namely $upright("SYC")$ gates applied to neighboring qubits. We alternate the partitioning of the two-qubit entangling gates, e.g., $( 1 , 2 ) , ( 3 , 4 ) , ( 5 , 6 ) arrow.l.r ( 2 , 3 ) , ( 4 , 5 )$ for $n = 6$.


For $T$-symmetric (time-reversal-symmetric) dynamics, the single-qubit gates are real orthogonal $2 times 2$ matrices of the form $upright(e)^(- i t Y)$, where $Y$ is the Pauli-$Y$ matrix and $t$ is a randomly chosen real number. In addition, we replace the two-qubit entangling gate $upright("SYC")$ by a $T$-symmetric two-qubit entangling gate


$ V = ( U_3 ⊗ U_4 ) upright("SYC") ( U_1 ⊗ U_2 ) , $


where $U_1 , U_2 , U_3 , U_4$ are appropriately chosen single-qubit gates. In order to find a suitable choice of $U_1 , dots.h , U_4$ such that the two-qubit gate $V$ is time-reversal symmetric, we employ a numerical optimization. We parameterize each of $U_i$ as $exp ( upright(i) ( a_i X + b_i Y + c_i Z ) )$, where $a_i , b_i , c_i in bb(R)$ are initialized randomly. There are a total of $12$ variables. Next, we define the loss function to be equal to the Frobenius norm of the imaginary part of the matrix $V$ (after fixing the top left entry of $V$ to be real). We then perform gradient descent to minimize the loss function and terminate once we have found that the loss function is below $10^(- 9)$. We then replace $upright("SYC")$ by $V$.


In the conventional experiment, we begin with $| 0^n chevron.r chevron.l 0^n |$ on the system qubits, evolve under the 1D dynamics, and measure in the $Y$-basis. We also considered using randomized Pauli measurement at the end, but the performance for measuring in the $Y$-basis is slightly better. The rationale is that the output state under $T$-symmetric evolution has purely real amplitudes; hence the expectation value of any purely imaginary observable, such as the Pauli-$Y$ operator, is always zero. In contrast, the expectation value of $Y$ after a general unitary evolution is non-zero. $T$-symmetric unitaries are nevertheless hard to distinguish from general unitaries in the conventional setting because the expectation value of $Y$ is exponentially small for general unitaries; theefore an exponentially large number of experiments are needed to discern its nonzero value. Indeed, the result in @aharonov2021quantum @chen2021exponential shows that conventional strategies require an exponential number of experiments for distinguishing $T$-symmetric unitaries from general unitaries.


In the quantum-enhanced experiment, we prepare a Bell state $1 / sqrt(2) ( | 00 chevron.r + | 11 chevron.r )$ for every pair of system and memory qubits. Then we evolve the system qubits under the unknown dynamics. After the evolution, we swap the system and the memory qubits. Then we evolve the system qubits under the unknown dynamics again. Finally, we measure every pair of system and memory qubits in the Bell basis. Each quantum-enhanced experiment generates a $2 n$-bit string. We perform gradient descent to find our implementation of the Bell state preparation, swap operation, and Bell measurement using the native gates in the Sycamore processor.


// [figvision-cn] imgs/2DDynamics.png
// 该图像为一幅示意图，展示了量子比特阵列布局在三种状态之
// 间的转换过程。图中包含三个从左至右排列的子图区域，分别
// 代表不同的系统配置，并通过箭头指示其间的动态演化关系。
// 左侧子图（初始布局）： 类型：二维晶格结构示意图。 物体
// 组成：由红色方块、蓝色菱形和灰色叉号（×）组成的规则网
// 格阵列，整体呈45度倾斜的矩形排布。 布局细节：红色方块
// 与蓝色菱形交替排列形成斜向条纹带；灰色叉号位于部分交叉
// 点位置，不连续分布。具体而言，在左上角区域可见一个孤立
// 的灰色叉号，其余叉号沿右下方向稀疏分布。 标注文字：无
// 显式坐标轴或数值标注，但图形本身隐含空间拓扑结构。 趋
// 势/结论：此布局为“系统”与“记忆”量子比特未按特定配对方
// 式组织的初始状态。 中间子图（过渡布局）： 类型：二维晶
// 格结构示意图，被置于一个圆角矩形框内以突出显示。 物体
// 组成：同样由红色方块、蓝色菱形和灰色叉号构成，但相对左
// 侧子图发生了局部重排。 布局变化：相较于左侧，多个红色
// 方块与其相邻的蓝色菱形位置发生互换——即原本属于“系统”的
// 红色节点与“记忆”的蓝色节点成对交换位置。例如，原位于某
// 行第二列的红色方块现移至第三列，而其右侧蓝色菱形则左移
// 一位。这种交换导致红蓝相间模式出现错位重组。 灰色叉号
// 位置基本保持不变，仅随整体结构微调略有偏移。 连接关系：
// 所有元素仍维持原有邻接关系，未新增或删除连线，仅通过节
// 点置换改变逻辑归属。 标注文字：无额外文本标签。 趋势/
// 结论：该布局是通过“交换某些系统-记忆量子比特对”从左侧
// 布局演化而来，作为实现二维动力学的中间步骤。 右侧子图
// （目标布局）： 类型：二维晶格结构示意图，亦被置于同一
// 圆角矩形框内（与中间子图共享外框），表明二者处于可逆迭
// 代循环中。 物体组成：再次呈现红方块、蓝菱形、灰叉号的
// 组合，但相对于中间子图，所有成对的系统-记忆量子比特均
// 完成交换。 布局特征：此时红色方块与蓝色菱形的排列恢复
// 某种对称性或周期性模式，但与左侧初始布局不同——它是经过
// 全局配对交换后的新稳态。例如，若将中间子图中的每一对红
// 蓝节点全部互换，则得到当前布局。 灰色叉号位置进一步调
// 整以适应新的节点分布，但仍保持稀疏且非均匀特性。 连接
// 关系：维持原始晶格连通性，仅节点身份（颜色所代表的功能
// 角色）发生变化。 标注文字：无显式标记。 趋势/结论：该
// 布局是最终目标构型，可通过与中间布局反复切换来实现所需
// 的二维动力学行为。 整体流程说明： 左侧 → 中间：单向箭
// 头指向右方，表示一次性的部分节点交换操作。 中间 ↔ 右侧：
// 双向水平箭头连接两者，表示可在两种布局间无限次迭代切换，
// 每次切换涉及“所有系统-记忆量子比特对”的完全交换。 圆角
// 矩形框包围中间与右侧子图，强调它们共同构成一个封闭的操
// 作单元，用于持续执行动力学协议。 颜色编码含义：红色方
// 块代表“系统量子比特”，蓝色菱形代表“记忆量子比特”，灰色
// 叉号可能代表辅助控制位或空闲节点（图中未明确定义，但从
// 上下文推断为非活跃组件）。 比例尺：本图为抽象拓扑示意，
// 无物理尺寸比例尺，重点在于相对位置与变换逻辑而非几何尺
// 度。 总结：整幅图通过三阶段布局演变及箭头指示，清晰传
// 达了如何通过分步交换量子比特角色来构建并维持二维动力学
// 系统的关键机制。
#figure(scope: "parent", image("imgs/2DDynamics.png", width: 98.0%),
  caption: [
    To implement the 2D dynamics, we first move from the layout on the left to the layout in the middle (by swapping some pairs of system and memory qubits). Then, we iterate between the layout in the middle and the layout in the right (by swapping all pairs of system and memory qubits).
  ]
)
<fig:2Dscrambling>



=== 2D dynamics
<d-dynamics>


For our 2D circuits we use the layout provided in Supp.~@fig:Geometry\(c) which is also shown as the leftmost layout in Supp.~@fig:2Dscrambling. In the leftmost layout, none of the system qubits (circled blue) are connected to one another. In order to implement 2D dynamics, we first swap some pairs of the system and memory qubits to obtain the layout shown in the middle. In the middle layout, we can see that many of the system qubits are connected (the light blue line). We implement a depth-$4$ 1D random quantum circuit for each light blue line. Each depth-$4$ circuit corresponds to 1 layer of single-qubit gates, 1 layer of two-qubit gates, 1 layer of single-qubit gates, and 1 layer of two-qubit gates. The partitioning of the two layers of two-qubit gates are different. Then, we swap all pairs of qubits to obtain the layout shown on the right. The right-most layout connects a different set of system qubits (the light blue line). We again implement a depth-$4$ 1D random quantum circuit for each light blue line. After that, we move back to the middle layout and repeat for multiple rounds. After sufficiently many repetitions, the $n$ qubits become globally entangled.


=== An unsupervised machine learning model
<an-unsupervised-machine-learning-model>


For each circuit, we create a feature vector by obtaining statistics for each bit in the measurement outcome bitstring. In conventional experiments, each experiment produces an $n$-bit measurement outcome. In quantum-enhanced experiments, each experiment produces a $2 n$-bit measurement outcome. In the following, we consider $ell = n$ or $2 n$ depending on either we are running conventional or quantum-enhanced experiments. For an $ell$-bit measurement outcome, we obtain a feature vector of size $2 ell$ including the first and second moment of each bit. After constructing a feature vector for each circuit, we map the feature vector to an infinite-dimensional reproducing kernel Hilbert space (corresponding to a Gaussian kernel) that includes all the polynomial expansions of the feature vector. Then, we find a low-dimensional subspace in the infinite-dimensional Hilbert space using principal component analysis (PCA) @scholkopf1998nonlinear. The entire procedure can be performed efficiently using kernel PCA @scholkopf1998nonlinear. Kernel PCA is implemented using scikit-learn @sklearn_api.


In @fig:AdvantageExpt2 of the main text, we show a one-dimensional subspace found by the unsupervised ML model, for both 1D and 2D random quantum circuits. We can use this one-dimensional representation to classify the circuits into two classes (by splitting the one-dimensional representation in the middle). Then, we can evaluate the accuracy of the unsupervised ML model by checking the percentage of circuits that are correctly classified as general circuits or as $T$-symmetric circuits. A two-dimensional subspace found by the unsupervised ML model, and an assessment of classification accuracy, are discussed in @sec:additional-exp


== Additional experimental results
<sec:additional-exp>


// [figvision-cn] imgs/2DPCA.png
// 该图由两个主列（a）和（b）组成，分别展示一维动力学和二
// 维动力学的无监督机器学习二维表示结果。每个主列包含上下
// 两个子图，上方为“常规”实验数据的结果，下方为“量子增强”
// 实验数据的结果。所有四个子图均为散点图，横轴标记为“
// Dim. 1”，范围从-0.4到0.4；纵轴标记为“Dim. 2”，范围从
// -0.25到0.25。图中数据点分为两类：蓝色菱形代表不具有时
// 间反演对称性的通用过程（General），红色圆形代表具有时
// 间反演对称性的过程（T-symmetric）。图例位于底部中央，
// 明确标注了两种符号对应的物理含义。 子图(a)上半部分标题
// 为“1D Dynamics”，副标题为“Conventional”。在此图中，蓝
// 色菱形与红色圆形在二维平面上高度重叠，主要集中在横坐标
// -0.2至0.2、纵坐标-0.15至0.15的区域，无明显分离趋势，表
// 明常规实验数据下模型无法区分两类过程。右上角有一个灰色
// 机器人图标，内部电路图案模糊，象征传统AI模型。 子图(a)
// 下半部分标题同为“1D Dynamics”，副标题为“
// Quantum-enhanced”。在此图中，蓝色菱形集中于左侧区域（
// 横坐标约-0.3至-0.1），红色圆形则分布于右侧及中部（横坐
// 标约-0.1至0.3），两者在横向上明显分离，仅在中间小区域
// 有轻微重叠。这表明量子增强数据使模型成功将两类过程在潜
// 在空间中分开。右上角机器人图标变为彩色，头部为蓝色，身
// 体为紫色，胸前有原子结构图案，象征量子增强AI模型。 子
// 图(b)上半部分标题为“2D Dynamics”，副标题为“
// Conventional”。此图中蓝色菱形与红色圆形同样高度混合，
// 分布范围大致为横坐标-0.3至0.3、纵坐标-0.15至0.15，无清
// 晰分界，说明在二维动力学情况下常规数据亦无法实现有效分
// 类。右上角为相同灰色机器人图标。 子图(b)下半部分标题为
// “2D Dynamics”，副标题为“Quantum-enhanced”。在此图中，
// 蓝色菱形密集聚集于左侧（横坐标约-0.35至-0.05），红色圆
// 形则完全分离至右侧（横坐标约0.05至0.35），两组点在横轴
// 方向几乎无重叠，形成清晰的左右分区。这证明即使在更复杂
// 的二维动力学系统中，量子增强数据仍能引导模型准确发现并
// 分离出时间反演对称性差异。右上角为相同的彩色量子增强机
// 器人图标。 整体而言，该图通过对比常规与量子增强条件下
// 机器学习模型对一维和二维动力学数据的二维嵌入表示，定量
// 展示了量子增强实验如何显著提升模型识别物理系统内在对称
// 性（特别是时间反演对称性）的能力——在常规条件下两类过程
// 混杂不清，而在量子增强条件下它们在潜在空间中实现显著分
// 离。
#figure(scope: "parent", image("imgs/2DPCA.png", width: 75.0%),
  caption: [
    #emph[Two-dimensional representation learned by unsupervised ML for (a) 1D dynamics and (b) 2D dynamics.] Each point in the two-dimensional plane corresponds to a distinct physical process. Half of the processes have time-reversal symmetry (blue diamonds) while the other half do not (red circles). When fed with data from quantum-enhanced experiments, the ML model accurately discovers the underlying symmetry pattern. In contrast, the ML model fails to do so when fed with data from conventional experiments.
  ]
)
<fig:2DPCA>



In Supp.~@fig:2DPCA, we provide the two-dimensional representations learned by unsupervised ML for the various random quantum circuits investigated in our conventional and quantum-enhanced experiments. (One-dimensional representations are presented in @fig:AdvantageExpt2 in the main text.) We see that in the second dimension found by unsupervised ML using quantum-enhanced experiments for 1D dynamics, $T$-symmetric dynamics are clustered into two groups. Further inspection shows that the unsupervised ML model has learned substructure corresponding to the parity of the depth of the evolution (recall that the depth is always an integer). In principle, the unsupervised ML model should be able to learn a wide variety of structures in the dynamics. Notably, we see that it places the distinction between general unitary dynamics and $T$-symmetric dynamics as the major axis (the first dimension), and places less prominent structure as the second major axis (the second dimension).


In Supp.~@fig:acc-PCA, we provide the accuracy of the unsupervised ML model for distinguishing between general unitary dynamics and $T$-symmetric dynamics. We see a substantial advantage for using the quantum-enhanced strategy in both the physical experiments and the noiseless simulation. We perform brute-force noiseless simulation for conventional experiments because the system size is at most $20$. The noiseless simulation for quantum-enhanced experiments uses the fact that $( U ⊗ U ) 1 / sqrt(2^n) sum_(i = 0)^(2^n - 1) | i i chevron.r = ( U U^T ⊗ I ) 1 / sqrt(2^n) sum_(i = 0)^(2^n - 1) | i i chevron.r$, hence we can effectively reduce the simulation to a system size at most $20$.


// [figvision-cn] imgs/Acc_dynamics.png
// 该图由两个并排的子图（左侧为物理实验，右侧为无噪声模拟）
// 和一个位于最右侧的共享图例组成。 左侧子图： 类型：曲线
// 图。 标题：Physical experiments（物理实验）。 横坐标轴
// 名称：Number of experiments（实验次数），刻度为对数标
// 度，范围从10^1到10^4，主刻度标记为10^1, 10^2, 10^3, 10
// ^4。 纵坐标轴名称：Accuracy（准确率），刻度为线性标度，
// 范围从0.5到1.0，主刻度标记间隔为0.1。 数据系列：图中包
// 含两组曲线簇，分别对应“Quantum-enhanced experiments”（
// 量子增强实验）和“Conventional experiments”（常规实验）。
// 每组曲线簇内包含多条不同颜色的线，代表不同的系统尺寸n。
// 每条实线代表平均值，线周围的半透明阴影区域代表误差范围
// 或置信区间。 具体曲线特征： “Quantum-enhanced
// experiments”组（上方曲线簇）：共有9条曲线，颜色从深紫
// 色、红色、橙色过渡到黄色、绿色、青色、蓝色、粉色、灰色。
// 这些曲线整体呈上升趋势，随着实验次数增加，准确率从约
// 0.78至0.85上升至0.90至0.96。在图例中，该系统对应一个彩
// 色机器人图标。 “Conventional experiments”组（下方曲线
// 簇）：同样包含9条对应颜色的曲线。这些曲线整体波动较小，
// 准确率维持在0.5至0.6之间，没有明显的随实验次数增加而提
// 升的趋势。在图例中，该系统对应一个黑白机器人图标。 标
// 注文字：图内右上角有“Quantum-enhanced experiments”字样
// 及彩色机器人图标；右下角有“Conventional experiments”字
// 样及黑白机器人图标。 右侧子图： 类型：曲线图。 标题：
// Noiseless simulation（无噪声模拟）。 横坐标轴名称：
// Number of experiments（实验次数），刻度为对数标度，范
// 围从10^1到10^4，主刻度标记为10^1, 10^2, 10^3, 10^4。
// 纵坐标轴名称：未明确标出，但根据左侧推断为Accuracy（准
// 确率），刻度为线性标度，范围从0.5到1.0，主刻度标记间隔
// 为0.1。 数据系列：与左图类似，包含两组曲线簇，分别对应
// “Quantum-enhanced experiments”和“Conventional
// experiments”。 具体曲线特征： “Quantum-enhanced
// experiments”组（上方曲线簇）：所有曲线均呈现显著的S形
// 上升趋势。对于较小的系统尺寸（如n=4, 6, 8），曲线在较
// 少的实验次数下（约10^2至10^3次）即可达到接近1.0的准确
// 率。对于较大的系统尺寸（如n=18, 20），需要更多的实验次
// 数才能达到高准确率。在图例中，该系统对应一个彩色机器人
// 图标。 “Conventional experiments”组（下方曲线簇）：这
// 些曲线整体处于较低水平，准确率大多在0.5至0.7之间，且上
// 升趋势不明显或非常缓慢。在图例中，该系统对应一个黑白机
// 器人图标。 标注文字：图内左上角有“Quantum-enhanced
// experiments”字样及彩色机器人图标；右下角有“
// Conventional experiments”字样及黑白机器人图标。 共享图
// 例： 位置：位于两个子图的右侧。 标题：System sizes (n)
// （系统尺寸n）。 内容：列出了从4到20的偶数系统尺寸（4,
// 6, 8, 10, 12, 14, 16, 18, 20），每个尺寸对应一种特定的
// 颜色和符号组合。例如，n=4对应深紫色实心圆点，n=6对应红
// 色加号，n=8对应橙色叉号，以此类推，颜色按光谱顺序变化。
// 底部图标：图例下方展示了两个机器人图标，左侧为彩色版本
// （对应量子增强实验），右侧为黑白版本（对应常规实验）。
#figure(image("imgs/Acc_dynamics.png", width: 98.0%),
  caption: [
    #emph[Accuracy of the unsupervised ML model for classifying general unitary and $T$-symmetric dynamics.] For each system size, we generate $100$ different circuits for each of the two classes (general and $T$-symmetric). The one-dimensional representation found by the unsupervised ML model is used to classify the $200$ circuits into two classes. We consider both physical experiments and noiseless simulations. Accuracy is plotted as a function of the number of experiments in both the conventional and quantum-enhanced settings.
  ]
)
<fig:acc-PCA>



== Performance and characterization data
<sec:PerformanceData>


The performance of the device was characterized before each run. The measurement data is collected explicitly and used for measurement error mitigation in the prediction process of the supervised neural network model (see discussion in the last part of @sec:NN-data-Q). The task of learning quantum states is largely limited by the qubit measurement fidelities. A representative sample of the data from the device is reported in @fig:ReadoutError, where one can see that typical readout errors (conflated with errors in preparing zero and one states) range from 3\% to 7\%. For transmons, the $| 0 chevron.r$ preparation has a small error; hence Supp.~@fig:ReadoutError\(a) is dominated by the readout error. Furthermore, the single-qubit gate error (shown in Supp.~@fig:GateError) is much smaller than the error shown in @fig:GateError\(b), hence the error shown in Supp.~@fig:ReadoutError\(b) is mostly due to readout errors rather than gate errors. During the actual run of the experiments, we avoid using qubits with the worst readout errors by checking the measurement errors before the experiment and selecting the layout accordingly.


The task of learning quantum dynamics involves circuits of higher complexity and hence is limited by both measurement errors and errors in two-qubit gates. For these experiments, we report in Supp.~@fig:GateError the quality of the single-qubit and two-qubit gates across the device. This data was obtained via parallel cross-entropy benchmarking and single-qubit randomized benchmarking. The typical single-qubit gate error is around $0.001$ to $0.005$, while the typical two-qubit gate error is around $0.01$ to $0.05$.


// [figvision-cn] imgs/readout.png
// 该图包含两个并列的子图 (a) 和 (b)，均为展示Sycamore量
// 子处理器在特定状态下准备与测量误差数据的热力图。 子图
// (a)： 类型：热力图，左上角嵌有示意图。 坐标轴：横轴为
// "column"，范围0至9；纵轴为 "row"，范围0至9。 色标：位
// 于右侧的垂直颜色条，数值范围从0（深紫色）到0.08（亮黄
// 色）。 嵌入示意图：位于坐标区域左上角（约row 0-2,
// column 0-3），由多个蓝色小圆圈通过灰色线条连接而成，呈
// 网格状排列，代表量子比特布局。 数据内容：主区域为矩形
// 网格，每个单元格内标注具体数值，表示对应位置(qubit)的
// 误差值。例如，(row=3, column=2)处的值为0.084（亮黄色，
// 最高误差点之一），(row=9, column=4)处为0.012（深紫色，
// 低误差点）。整体趋势显示大部分误差集中在0.01至0.05之间，
// 少数点如(3,2)和(8,2)达到较高值。 结论：展示“零态+测量
// 误差”分布，高误差区域局部集中。 子图 (b)： 类型：热力
// 图，左上角嵌有示意图。 坐标轴：横轴为 "column"，范围0
// 至9；纵轴为 "row"，范围0至9。 色标：位于右侧的垂直颜色
// 条，数值范围从0（深紫色）到0.5（亮黄色）。 嵌入示意图：
// 与(a)相同，位于左上角，蓝色圆圈加灰色连线构成网格结构。
// 数据内容：同样为矩形网格，单元格内标注误差值。例如，(
// row=3, column=2)处为0.52（亮黄色，显著高于其他点），(
// row=9, column=4)处为0.05（中等偏低）。多数单元格值在
// 0.03至0.15区间，但存在明显异常高点如(3,2)=0.52、(5,4)=
// 0.12等。 结论：展示“一态+测量误差”分布，相比(a)整体误
// 差水平更高且波动更大，尤其在(3,2)位置出现极端高误差。
// 两子图共同对比了不同初始状态下的系统误差特性，(b)中误
// 差幅度普遍大于(a)，表明“一态”下测量或制备过程更不稳定。
#figure([#box(image("imgs/readout.png", width: 94.0%))],
  caption: [
    #emph[Sycamore state preparation and measurement error data.] \
    #emph[\(a) $|0 chevron.r$ state preparation and measurement error.] We prepare a noisy zero state $|0 chevron.r$ and measure in the computational basis using the noisy single-qubit readout. We show the probability of measuring $|1 chevron.r$ in the qubit readout. \
    #emph[\(b) $|1 chevron.r$ state preparation and measurement error.] We prepare a noisy one state $|1 chevron.r$ and measure in the computational basis using the noisy single-qubit readout. We show the probability of measuring $|0 chevron.r$ in the qubit readout. \
    While these values change over time, we present here a representative sample of the error. One can see that in accordance with physical expectations based on $T_1$ errors, the readout in the physical 1 state is substantially higher than the 0 state.
  ],
  scope: "parent",
  placement: top,
) <fig:ReadoutError>

// [figvision-cn] imgs/gate.png
// 该图包含两个并列的子图，分别标记为(a)和(b)，展示了
// Sycamore量子处理器的单量子比特门和二量子比特门的错误率
// 数据。 子图(a)： 标题为“Single-qubit gate error”。这是
// 一个二维热力图（或矩阵图），用于展示不同位置量子比特的
// 单量子比特门错误率。 左侧有一个小型的示意图，描绘了处
// 理器芯片上量子比特的物理布局。该布局呈菱形网格状，由多
// 个节点（代表量子比特）通过连线连接而成，整体位于坐标系
// 的左上角区域。 主图的横轴标记为“column”，范围从0到9；
// 纵轴标记为“row”，范围从0到9。 图中彩色方块代表了在特定
// (row, column)坐标处的量子比特门错误率。每个方块内部都
// 标注了具体的数值。例如，位于(2, 5)位置的方块颜色最亮（
// 黄色），其数值为0.0081；位于(9, 4)位置的方块颜色较深（
// 紫色），数值为0.0018。大部分方块的数值在0.001到0.006之
// 间。 图的右侧设有一个垂直的颜色条（colorbar）。颜色从
// 底部的深紫色渐变到顶部的亮黄色。对应的数值刻度从底部的
// 0.001线性增加到顶部的0.008。这表明深紫色代表较低的错误
// 率，而亮黄色代表较高的错误率。 该子图传达的结论是：不
// 同位置的量子比特其单量子比特门错误率存在差异，其中(2,
// 5)处的错误率最高，约为0.0081，而大部分区域的错误率在
// 0.003左右。 子图(b)： 标题为“Two-qubit gate error”。这
// 也是一个二维热力图，但展示的是二量子比特门的错误率。
// 与子图(a)类似，左侧也有一个相同的菱形网格布局示意图。
// 横轴同样标记为“column”（0-9），纵轴标记为“row”（0-9）。
// 图中的彩色元素不是正方形，而是菱形，这些菱形填充在网格
// 的连接处，代表了相邻量子比特之间的二量子比特门错误率。
// 每个菱形内部也标注了具体数值。例如，中心区域的一个菱形
// （大致位于row=5, column=4附近）颜色为黄色，数值为0.03；
// 周围许多菱形的数值为0.01或0.02。 图的右侧同样设有一个
// 垂直颜色条。颜色从底部的深紫色渐变到顶部的亮黄色。对应
// 的数值刻度从底部的0.01增加到顶部的0.08。 该子图传达的
// 结论是：二量子比特门的错误率普遍高于单量子比特门（比较
// 两图颜色条的量级可知）。大部分二量子比特门的错误率在
// 0.01到0.03之间，其中个别位置的错误率达到了0.03。
#figure([#box(image("imgs/gate.png", width: 94.0%))],
  caption: [
    #emph[Sycamore single- and two-qubit gate error data.] \

    #emph[\(a) Single-qubit gate error.] The figure shows the error of single-qubit gates across the chip using parallel single-qubit randomized benchmarking. \
    #emph[\(b) Two-qubit gate error.] The figure shows the error across the chip of two-qubit gates being executed in parallel, as to account for errors that occur during simultaneous operation of qubits. We can see that the distribution of errors varies across the chip couplers, showing the extent to which performance is non-uniform.
  ],
  scope: "parent",
  placement: top,
)
<fig:GateError>



= A brief review on quantum information theory
<sec:review>


In this section we review some relevant definitions and basic results in quantum information theory which are leveraged throughout our problem statements and proofs. Specifically, we will discuss quantum processes, which are a general mathematical formalism for describing physical processes, and positive operator-valued measures (POVMs), which encompass all possible physical measurements. Readers familiar with these concepts can skip this section.


== Definition and properties of quantum processes
<sec:Qprocess>


For concreteness, let us consider a Hilbert space $cal(H)_S tilde.eq bb(C)^d$. Here the subscript $S$ stands of 'system', since the Hilbert space describes the space of states of some particular system we wish to study. Given a density matrix $rho$ on this Hilbert space, we might ask: how can it evolve in time? The Schrödinger equations tells us that a state can evolve via unitary time evolution, and as such a density matrix can evolve by $rho mapsto U rho U^dagger$. However, there is a more general type of time evolution allowed by quantum mechanics. Suppose that we append our Hilbert space by another $cal(H)_E tilde.eq bb(C)^(d')$ which describes an external environment. The joint Hilbert space is then the tensor product $cal(H)_S ⊗ cal(H)_E$. We can imagine having an initial state $rho_S ⊗ rho_E$ which factorizes between the system and environment, and then evolving the state by a unitary on the joint Hilbert space which couples the system and environment: $rho_S ⊗ rho_E mapsto U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger$. If we only have access to $cal(H)_S$, then our knowledge of $U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger$ is described by performing a partial trace over the environment, namely $upright("tr")_E (U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger)$. As such, if we are only aware of the initial density matrix $rho_S$ on $cal(H)_S$, then only having access to $cal(H)_S$ the time evolution would appear to be


$ rho_S mapsto upright("tr")_E (U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger) thin . $
<E:SEchannel1>


Note that, viewed as time evolution on $rho_S$ alone, the above map is not unitary. This is because information in $rho_S$ can leak into the environment, and similarly information from the environment can influence the state on our system $S$ of interest. This mapping is an example of a quantum process, which can be more compactly notated as $rho_S mapsto cal(C) \[ rho_S \]$. Here, $cal(C)$ is a map from density matrices on $cal(H)_S$ to (other) density matrices on $cal(H)_S$. We visualize this dynamical process in Supp.~@fig:qprocess.


Our quantum process $cal(C)$ has two properties that are worth highlighting:

+ $cal(C)$ #emph[is trace-preserving]. This means that $upright("tr") ( cal(C) \[ rho_S \] ) = upright("tr") ( rho_S )$. The equality follows from the definition of $cal(C) \[ rho \]$ via the right-hand side of~@E:SEchannel1, since

  $ upright("tr") (cal(C) \[ rho_S \]) &= upright("tr")_S (upright("tr")_E (U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger)) \
    &= upright("tr") (U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger) \
    &= upright("tr") ( rho_S ⊗ rho_E ) = upright("tr") ( rho_S ) thin upright("tr") ( rho_E ) = upright("tr") ( rho_S ) thin , $

  where we have used the cyclicity of the trace to cancel $U_(S E)$ with $U_(S E)^dagger$, and have also leveraged $upright("tr") ( rho_E ) = 1$.

+ $cal(C)$ #emph[is completely positive]. Suppose we append our system Hilbert space $cal(H)_S$ by ancillas $cal(H)_A$ to arrive at the joint Hilbert space $cal(H)_A ⊗ cal(H)_S$. Then complete positivity means that for any density matrix $rho_(A S)$ on this joint system (and for any choice of ancilla Hilbert space), $( upright("Id")_A ⊗ cal(C) ) \[ rho_(A S) \]$ is positive-semidefinite; here $upright("Id")_A$ acts as the identity on the ancillas. To see why this property holds, we can write out $( upright("Id")_A ⊗ cal(C) ) \[ rho_(A S) \]$ more explicitly:

  #[
  #set math.equation(numbering: none)
  $ ( upright("Id")_A ⊗ cal(C) ) \[ rho_(A S) \] = upright("tr")_E (( I_A ⊗ U_(S E) ) ( rho_(A S) ⊗ rho_E ) ( I_A ⊗ U_(S E)^dagger )) thin . $
  ]

  Since the right-hand side is merely performing a unitary transformation on the density matrix $rho_(A S) ⊗ rho_E$ and then tracing out a subsystem (i.e.~the environment subsystem), positive semi-definiteness is preserved.

We have thus shown that our $cal(C)$ is a completely positive, trace-preserving (CPTP) linear map from density matrices on $cal(H)_S$ to density matrices on $cal(H)_S$. Henceforth, when we refer to a map as being CPTP, we will implicitly suppose that the map is linear. Moreover, we will interchangeably call a CPTP map a quantum process.


What is not immediately obvious is the following fact:


#thmbox("theorem", "Theorem (Stinespring dilation)")[


Any CPTP map $cal(C)$ taking density matrices on $cal(H)_S tilde.eq bb(C)^d$ to density matrices on $cal(H)_S tilde.eq bb(C)^d$ can be written in the form


#[
#set math.equation(numbering: none)
$ cal(C) \[ rho_S \] = upright("tr")_E (U_(S E) ( rho_S ⊗ rho_E ) U_(S E)^dagger) $
]


for any $rho_S$, where $U_(S E)$, $rho_E$, and the dimension of the environment $d'$ are all fixed.


]


This theorem means that any CPTP map on a density matrix can be realized as a unitary operation on a larger system, i.e.~coupling the density matrix to an appropriate environment and evolving the joint state and ultimately tracing out the environment. In this sense, a quantum process is the most general form of evolution of a density matrix. Note that a special case of a quantum process is simply a unitary channel, i.e.~$cal(C) \[ rho \] = U rho U^dagger$. A way of summarizing the above Theorem is that a quantum process that is not a unitary channel can be thought of as implementing open system dynamics.


// [figvision-cn] imgs/qprocess.png
// 该图是一幅示意图，通过左右两个部分对比展示了量子过程的
// 物理图像与抽象形式。 左侧部分展示了一个具体的物理演化
// 过程。最左侧竖直排列着两个长方体块，上方为紫色边框的“
// Input state”（输入态），内部包含三个垂直堆叠的原子符号；
// 下方为青色边框的“Environment”（环境），内部包含五个垂
// 直堆叠的原子符号。这两个长方体块共同指向中间一个巨大的
// 淡蓝色矩形框，框内写有黑色文字“Unitary Evolution”（幺
// 正演化）。从该矩形框右侧伸出一个深蓝色粗箭头，指向一个
// 较窄的粉色长方体块，标记为“Output state”（输出态），其
// 内部有一个问号。在该输出态的右侧，垂直排列着五个红色的
// 叉号，旁边标注红色文字“Information Lost”（信息丢失），
// 表示在只关注系统输出时，与环境纠缠导致的信息损失。 右
// 侧部分展示了该过程的抽象描述。左侧是一个与左图相同的紫
// 色“Input state”长方体块，右侧是粉色的“Output state”长
// 方体块（内含问号）。两者之间由一个宽大的灰色箭头连接，
// 箭头下方标注黑色文字“Quantum Process”（量子过程）。左
// 右两部分之间用一个等号连接，表明左侧复杂的物理演化（系
// 统与环境的幺正演化）在数学上等价于右侧对系统单独作用的
// 量子过程。
#figure(image("imgs/qprocess.png", width: 70.0%),
  caption: [
    #emph[Illustration of quantum process: a formalism for describing physical processes.] Quantum process is also known as quantum operation or quantum dynamical map, and is often referred to as quantum channel in quantum communication theory.
  ]
)
<fig:qprocess>



== Definition and properties of POVMs
<sec:POVMdef>


The most conventional way to measure a quantum state $| psi chevron.r$ is by decohering it with respect to a complete orthonormal basis. More specifically, suppose that $| psi chevron.r in bb(C)^d$ and we choose some complete orthonormal basis ${ | i chevron.r }_(i = 0)^(d - 1)$ of $bb(C)^d$. Then upon measuring $| psi chevron.r$ with respect to this basis, we will measure $| psi chevron.r$ to be in the state $| i chevron.r$ with probability $upright("Prob") ( i ) = | chevron.l i | psi chevron.r |^2$. Analogously for a density matrix $rho$ on the same Hilbert space, if we measure it with respect to the same orthonormal basis we will measure the state to be $| i chevron.r chevron.l i |$ with probability $upright("Prob") ( i ) = upright("tr") ( | i chevron.r chevron.l i | thin rho )$.


There is a nice way of conceptualizing measurements which will admit useful generalizations. First, let us develop some notation. We define $Pi_i = | i chevron.r chevron.l i |$ which is the projector onto state $| i chevron.r$, and will speak of the collection of projectors ${ Pi_i }_(i = 0)^(d - 1)$. It is readily seen that $sum_(i = 0)^(d - 1) Pi_i = I$ since this is just a resolution of the identity. Observe that each $Pi_i$ is Hermitian and positive semi-definite. Now suppose we append to our Hilbert space another copy $bb(C)^d$. Then we can define a unitary on both copies which acts by


$ U ( | psi chevron.r ⊗ | 0 chevron.r ) = sum_(i = 0)^(d - 1) Pi_i | psi chevron.r ⊗ | i chevron.r $
<E:pointermeas1>


for any $| psi chevron.r$. Note that, as required of a unitary,


#[
#set math.equation(numbering: none)
$ & ( chevron.l psi | ⊗ chevron.l 0 | ) U^dagger U ( | psi chevron.r ⊗ | 0 chevron.r ) \
  & quad = sum_(i , j = 0)^(d - 1) chevron.l psi | Pi_i Pi_j | psi chevron.r chevron.l i | j chevron.r \
  & quad = sum_(i = 0)^(d - 1) chevron.l psi | Pi_i^2 | psi chevron.r \
  & quad = sum_(i = 0)^(d - 1) chevron.l psi | Pi_i | psi chevron.r = 1 $
]


on account of $Pi_i^2 = Pi_i$ and $sum_(i = 0)^(d - 1) Pi_i = I$. Given the right-hand side of~@E:pointermeas1, we can make a measurement on the appended Hilbert space in the ${ | i chevron.r }_(i = 0)^(d - 1)$ basis; we will then measure the appended register to be in the state $| i chevron.r$ with probability


$ & upright("Prob") ( i ) = ( chevron.l psi | ⊗ chevron.l 0 | ) U^dagger ( I ⊗ | i chevron.r chevron.l i | ) U ( | psi chevron.r ⊗ | 0 chevron.r ) \
  & quad = upright("tr") ( Pi_i | psi chevron.r chevron.l psi | ) = | chevron.l i | psi chevron.r |^2 thin . $


Similarly, if we consider $rho ⊗ | 0 chevron.r chevron.l 0 |$, conjugate by $U$, and then measure the state of the ancilla, the probability of measuring the ancilla to be $| i chevron.r$ is $upright("Prob") ( i ) = upright("tr") ( Pi_i rho ) = upright("tr") ( | i chevron.r chevron.l i | thin rho )$.


We can think about the above in terms of the following procedure. First we prepare a state $| psi chevron.r$\; then we bring in an ancilla $| 0 chevron.r$ and cause the two states to interact such that the ancilla goes into a state $| i chevron.r$ upon coupling with the $| i chevron.r$-component of $| psi chevron.r$. This leads to the right-hand side of~@E:pointermeas1. The ancilla can be thought of as a proxy for the readout of a measurement apparatus: upon reading off the value of $| i chevron.r$, we are informed that the state $| psi chevron.r$ has been projected into its $| i chevron.r$-component.


// [figvision-cn] imgs/POVM.png
// 这是一张科学论文插图，用于阐释正算符值测度（POVM）的概
// 念。图像由左右两部分组成，中间用一个黑色的等号连接，表
// 示左侧的物理过程在数学上等价于右侧的抽象测量模型。 左
// 侧部分展示了一个量子测量的物理实现流程，从左至右依次排
// 列： 输入态与辅助态：最左侧是两个垂直堆叠的长方体，代
// 表量子系统。上方是一个紫色的长方体，顶部标注有黑色文字
// “Input state”（输入态）。该长方体内部垂直排列着三个紫
// 色的原子状符号（中心一个圆点，周围环绕六个小圆圈）。下
// 方是一个青色的长方体，高度略高于紫色长方体，其左下角标
// 注有两行黑色文字“Auxiliary state in measurement
// apparatus”（测量装置中的辅助态）。该长方体内部垂直排列
// 着五个青色的原子状符号。这两个长方体紧密贴合，青色长方
// 体的左上角紧贴紫色长方体的右下角。 幺正演化：紧接在两
// 个长方体右侧的是一个大的浅蓝色矩形框，边框为深蓝色。框
// 内居中写有两行黑色文字：“Unitary”和“Evolution”。从左侧
// 两个长方体与这个蓝色矩形的交界处，伸出一个深蓝色的实心
// 短箭头指向蓝色矩形内部，表示状态的输入。 投影测量：在
// 浅蓝色矩形的右侧，有一个深蓝色的粗箭头指向右边一个深紫
// 色的细长竖条矩形。这个深紫色矩形代表测量步骤，其底部标
// 注有黑色文字“Projective Measurement”（投影测量）。矩形
// 内部中央绘制有一个白色的半圆形弧线，弧线右端带有一个向
// 上的箭头，象征测量结果或指针偏转。 右侧部分展示了上述
// 过程的等效简化模型： 输入态：右上角有一个紫色的长方体，
// 样式、颜色和内部的三个原子状符号均与左侧上方的“Input
// state”完全相同。其顶部同样标注有黑色文字“Input state”。
// POVM算符：在紫色长方体的右侧，紧邻着一个灰色的正方形框，
// 边框为黑色。框内绘制有一个黑色的半圆形弧线，弧线右端带
// 有一个向右上方的箭头，这与左侧深紫色矩形内的白色符号形
// 状一致但颜色不同。该灰色方框下方标注有黑色文字“POVM”。
// 整个图像通过这种布局传达了核心结论：任何包含输入态与辅
// 助态进行幺正演化后再进行投影测量的复杂物理过程，都可以
// 被等效地描述为对输入态直接进行一次POVM测量。
#figure(image("imgs/POVM.png", width: 65.0%),
  caption: [
    #emph[Illustration of POVM: a formalism encompassing all physical measurements.] POVM considers a composition of the input state with an auxiliary state in the measurement apparatus (which can be thought of as a set of ancilla qubits) that undergoes an unitary evolution, followed by a projective measurement.
  ]
)
<fig:povm>



This type of procedure can be generalized as follows. Suppose we have a set of $N d times d$ operators ${ M_i }_(i = 0)^(N - 1)$ satisfying the completeness relation $sum_(i = 0)^(N - 1) M_i^dagger M_i = I$. Let us append to our Hilbert space $bb(C)^d$ and ancillary Hilbert space $bb(C)^N$ with complete orthonormal basis ${ | i chevron.r }_(i = 0)^(N - 1)$. Then we can consider a unitary map


$ U ( | psi chevron.r ⊗ | 0 chevron.r ) = sum_(i = 0)^(N - 1) M_i | psi chevron.r ⊗ | i chevron.r thin . $
<E:pointermeas2>


The fact that $( chevron.l psi | ⊗ chevron.l 0 | ) U^dagger U ( | psi chevron.r ⊗ | 0 chevron.r ) = 1$ can be checked using the completeness relation $sum_(i = 0)^(N - 1) M_i^dagger M_i = I$. Now if we measure the ancilla with respect to the ${ | i chevron.r }_(i = 0)^(N - 1)$ basis, then we will measure the ancilla to be in the state $| i chevron.r$ with probability $upright("Prob") ( i ) = | M_i | psi chevron.r |^2$. If we performed an analogous procedure at the level of density matrices, namely starting with a state $rho ⊗ | 0 chevron.r chevron.l 0 |$, conjugating both sides by $U$, and then measuring the ancilla in the ${ | i chevron.r }_(i = 0)^(N - 1)$ basis, we would measure the ancilla to be $| i chevron.r$ with probability $upright("Prob") ( i ) = upright("tr") ( M_i^dagger M_i rho )$. We visualize the above procedure in Supp.~@fig:povm.


We can abstract this procedure into what is called a #emph[positive operator-valued measure] (POVM):


#thmbox("definition", "Definition (POVM)")[


A POVM is a set Hermitian, positive semi-definite operators ${ F_i }_(i = 0)^(N - 1)$ on $bb(C)^d$ satisfying the completeness relation $sum_(i = 0)^(N - 1) F_i = I$. A POVM measurement is a procedure in which, given a state $rho$ on $bb(C)^d$, an ancillary measurement apparatus registers the index $i$ with probability $upright("tr")(F_i rho)$.


]


This relates to our previous procedure as follows. We simply decompose $F_i = M_i^dagger M_i$ (say, by a Cholesky decomposition) and perform the procedure previously stated with the $M_i$'s.


We remark that the term 'measure' is used above in two distinct ways. When we speak of a POVM, the M means measure in the sense of measure theory, since we can think of ${ F_i }_(i = 0)^(N - 1)$ as comprising a type of discrete measure on the space of operator on $bb(C)^d$. Otherwise, we use 'measure' in the sense of measurement.


A useful fact is that given a POVM ${ F_i }_(i = 0)^(N - 1)$, we can refine it into another, larger POVM $( F_(i , j) )_(i = 0 , j = 0)^(N - 1 , d - 1)$ such that (1) each $F_(i , j)$ is rank-1, and (2) a POVM measurement of $( F_(i , j) )_(i = 0 , j = 0)^(N - 1 , d - 1)$ can simulate a POVM measurement of ${ F_i }_(i = 0)^(N - 1)$. Let us explain this construction. Since each $F_i$ is a positive semi-definite Hermitian operator, we can diagonalize each operator as $F_i = sum_(j = 0)^(d - 1) lambda_j^(( i )) | v_j^(( i )) chevron.r chevron.l v_j^(( i )) |$. Then let $F_(i , j) := lambda_j^(( i )) | v_j^(( i )) chevron.r chevron.l v_j^(( i )) |$ which is manifestly positive semi-definite, Hermitian, and rank-1; it is also clear that $sum_(i = 0)^(N - 1) sum_(j = 0)^(d - 1) F_(i , j) = sum_(i = 0)^(N - 1) F_i = I$. We can use a POVM measurement of $( F_(i , j) )_(i = 0 , j = 0)^(N - 1 , d - 1)$ to simulate a POVM measurement of ${ F_i }_(i = 0)^(N - 1)$ by simply summing measurement results:


$ sum_(j = 0)^(d - 1) upright("tr") ( F_(i , j) rho ) = upright("tr") ( F_i rho ) thin . $


Accordingly, we can without loss of generality choose to work with rank-1 POVMs, since we can use these to simulate any other POVMs.


= Mathematical framework for proving exponential advantage
<sec:separation>


One of the central ingredients for establishing exponential advantage is to prove an exponential lower bound for any learning algorithm with only external classical memory. In this section, we present the basic framework for proving such lower bounds. This framework enables us to establish a suite of exponential advantage in various physically-relevant tasks, which will be presented after this section. The purpose of this section is to provide the readers with the essential tools to prove quantum advantage in the tasks they want to study.


The basic tools include the tree representation of learning algorithms (@sec:tree-def), reduction to distinguishing tasks and information-theoretic lower bounds (@sec:many-v-one-red~and~@sec:many-vs-many). Many of these techniques were introduced and leveraged in~@chen2021exponential. We also present a novel #emph[partially-revealed many-versus-one distinguishing task] in @sec:part-many-v-one that is crucial for realizing the advantage in practice. Then, in @sec:noisedegradation, we discuss how having noise in the unknown physical states and dynamics only makes the lower bounds for conventional experiments larger. This result on the presence of noise is simple to establish but also crucial in practice because there is often noise in the unknown physical states and dynamics. There are some other techniques presented in a theory paper written by some of the authors~@chen2021exponential, such as a multi-linear tensor analysis on the learning tree, which may be of interest to some readers.


== Tree representation
<sec:tree-def>


We begin by presenting the tree representation for analyzing algorithms with only classical memory~@chen2021exponential. The key idea is to track changes in the classical memory state in the algorithm using a graph, which we can take to be a rooted tree. We consider each node $u$ of the graph to be a classical memory state. Based on the memory state, the algorithm performs an experiment to obtain a measurement outcome $s$.


=== Experiments for learning physical world
<experiments-for-learning-physical-world>


To motivate the definitions in the sequel, we separately describe the two types of experimental setups that we focus on in this work: one on learning an unknown physical state and the other on learning an unknown process~@huang2021information @aharonov2021quantum @chen2021exponential.

- #emph[Learning an unknown physical state]: A physical state is represented by a density matrix $rho$. An algorithm leveraging the classical memory state $u$ measures the physical system $rho$ using a rank-$1$ POVM ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }$ with $sum_s w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | = I$. Note that from the discussion in @sec:POVMdef, we can always consider rank-$1$ POVMs only. The measurement outcome $s$ occurs with probability $w_s^u chevron.l phi.alt_s^u | rho | phi.alt_s^u chevron.r .$ Here, the rank-$1$ POVM ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }$ depends on the classical memory state $u$.

- #emph[Learning an unknown physical process]: A physical process is represented by a quantum process $cal(E)$ (equivalently, a CPTP map). An algorithm leveraging the memory state $u$ prepares an initial state $| psi^u chevron.r$, feeds it into the physical evolution $cal(E)$, and measures the output state $cal(E) ( | psi^u chevron.r chevron.l psi^u | )$ with a rank-$1$ POVM ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }$ with $sum_s w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | = I$. The outcome $s$ is obtained from the experiment with probability $w_s^u chevron.l phi.alt_s^u | cal(E) ( | psi^u chevron.r chevron.l psi^u | ) | phi.alt_s^u chevron.r thin .$ In this case, both the initial state and the measurement depend on the classical memory state $u$. We consider the initial state $| psi^u chevron.r$ to be an $( n + n' )$-qubit state, where $cal(E)$ acts on the first $n$ qubits. The rank-$1$ POVM ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }$ is on an $( n + n' )$-qubit state.


=== Dynamics of the learning algorithm
<dynamics-of-the-learning-algorithm>


The classical memory state of the learning algorithm is initialized in a certain state, which we represent by the root node $r$. The memory state of the algorithm begins at the root $r$. Each measurement outcome~$s$ resulting from a single experiment causes the algorithm to transition to a node neighbor of $r$. Whenever the algorithm obtains a measurement outcome $s$, the memory state changes. This is represented by a transition from a node $u$ to another node $v$,


$ u arrow.r^s v . $


The directed edge $e = ( u , v , s )$ from $u$ to $v$ represents the transition of the memory in an algorithm when we receive the measurement outcome $s$. We illustrate the transition under a single experiment in Supp.~@fig:Tree\(a).


If a different $s$ leads us to the same node, then the algorithm is not retaining full information of the measurement outcome. An example is given in Supp.~@fig:Tree\(b). Since we do not limit the size of the classical memory, there is no need to lose (or forget) information. Hence, all the outgoing edges of the root node $r$ indexed by the measurement outcome $s$ will point to distinct nodes. The same argument holds for any node in the graph. More precisely, every outgoing edge from a node $u$ will connect to a node $v$, such that $v$ has exactly one incoming edge (the edge is from $u$). The only node in the graph without an incoming edge is the root $r$. This is exactly the definition of a directed rooted tree $cal(T)$. We will focus on an algorithm that performs $T$ experiments. This means the depth of the tree, namely the number of edges in any root-to-leaf path, will be $T$. The tree representation is shown in Supp.~@fig:Tree\(c).


// [figvision-cn] imgs/Tree.png
// 子图(a)为示意图，展示经典算法的内存状态。图中包含四个
// 圆形节点和三条带箭头的连接线。顶部中央是一个标有字母“r
// ”的根节点。从“r”节点引出三条深青色箭头，分别指向下方的
// 三个节点：左侧节点标有“c”，中间节点标有“c'”，右侧节点
// 标有“c''”。连接“r”到“c”的箭头上标注有“s”，连接“r”到“c'
// ”的箭头上标注有“s'”，连接“r”到“c''”的箭头上标注有“s''”。
// 图的上方有标题文字“Memory state of classical algorithm
// ”。该图传达的结论是经典算法通过单一记忆状态“r”来区分不
// 同的输入路径（s, s', s''），从而能够唯一地确定对应的输
// 出结果（c, c', c''）。 子图(b)为示意图，描绘信息丢失的
// 过程。主体是一个深蓝色边框的矩形，背景为白色，右下角有
// 多层堆叠的线条效果，暗示这是多个步骤或状态的叠加。矩形
// 内部有三个红色圆形节点，分别标有“a”、“b”和“c”。节点“a”
// 位于左上方，节点“b”位于右上方，节点“c”位于下方中央。从
// “a”和“b”分别引出红色箭头指向“c”。矩形左上角有黑色文字“
// Information is lost”。该图传达的结论是当两个不同的初始
// 状态（a和b）汇聚到同一个最终状态（c）时，无法从最终状
// 态反推原始状态，导致信息丢失。 子图(c)为树状结构示意图，
// 展示学习算法的树表示法。图中包含多层圆形节点和深青色箭
// 头。最顶层是一个标有“r”的根节点。从“r”向下分出三个分支，
// 连接到第二层的三个未标记节点。第二层的每个节点再向下分
// 出两个分支，连接到第三层的六个未标记节点。图中用水平线
// 和文字标注了两个实验阶段：“Experiment 1”标注在从第一层
// 到第二层的连线上，“Experiment 2”标注在从第二层到第三层
// 的连线上。图的底部中央有垂直排列的三个点，表示层级可以
// 继续延伸。右下角有文字“Tree representation”。该图传达
// 的结论是学习算法利用树状结构记录历史，随着实验次数的增
// 加，树的深度和宽度扩展，使得不同的路径保持分离，避免了
// 信息丢失。
#figure(image("imgs/Tree.png", width: 90.0%),
  caption: [
    #emph[Illustration of the tree representation for a learning algorithm.] #emph[\(a) Dynamics of memory.] The memory state changes based on the measurement outcome $s$. #emph[\(b) No cycles.] If two memory states $a , b$ transition into the same memory state $c$, then some information is lost. #emph[\(c) Tree representation of an algorithm.] When no information is lost, the transition graph of the memory states must be a directed tree. Each layer of the tree corresponds to one experiment. After $T$ experiments, the memory state is represented by a node in the $T$-th layer.
  ]
)
<fig:Tree>



When we execute the algorithm to achieve a certain task (such as to verify entanglement, or learn a model of the physical system), the entire dynamic process of how the memory state changes will be represented by a path from the root $r$ to a leaf $ell$ in the tree $cal(T)$,


$ u_0 = r arrow.r^(s_1) u_1 arrow.r^(s_2) u_2 arrow.r^(s_3) dots.h arrow.r^(s_(T - 1)) u_(T - 1) arrow.r^(s_T) u_T = ell . $


To establish a lower bound against any learning algorithm for a particular task, we need to analyze each such path along with the probability that the path is taken.


== Many-versus-one distinguishing tasks
<sec:many-v-one>


=== Reduction
<sec:many-v-one-red>


In a learning task, we often want the learning algorithm to be able to make accurate predictions about some properties of the unknown physical system or dynamics. We will have a set of states (the mathematical representation of a physical system) or a set of channels (the mathematical representation of physical dynamics) to which we assume the unknown system or dynamics belong. The basic technique we employ in all of our proofs is to pick out one of the states/channels as the null hypothesis, and consider all the rest as the alternative hypothesis~@huang2021information @chen2021exponential. Let $cal(X)$ denote the set of possible states/channels.

- #emph[Null hypothesis]: The unknown state/channel is an element $X_0 in cal(X)$. To establish a tight lower bound, we should choose an $X_0$ that we think is #emph[close] to every other state/channel in $cal(X)$.

- #emph[Alternative hypothesis]: The unknown state/channel is a random element in $cal(X) { X_0 }$.

Furthermore, we need to choose $X_0$ such that the desired property we would like to learn enables us to distinguish between $X_0$ and the entire set of $cal(X) { X_0 }$.


To prove a lower bound against any classical algorithm, we try to answer the following question.

#block[
#emph[How hard is it to distinguish the alternative hypothesis from the null hypothesis?]

]
Because the alternative hypothesis consists of many elements and the null hypothesis consists of only one element, we refer to this distinguishing task as the #emph[many-versus-one distinguishing task].


=== Information-theoretic lower bound
<sec:many-v-one-info>


// [figvision-cn] imgs/Leaf_prob.png
// 该图包含左右两个部分，中间由一条垂直黑线分隔。左侧部分
// 展示了零假设下的情况，右侧部分展示在一个三维立方体框内
// 的备择假设情况。 左侧子图： 类型：示意图（决策树结构）。
// 内容描述：图中展示了一个灰色的三层二叉树结构。树的顶层
// 是一个标有字母“r”的圆形节点，代表根节点。从根节点向下
// 引出两条带有箭头的连线，分别指向第二层的两个圆形节点。
// 第二层的每个节点再各自向下分出两条带箭头的连线，指向第
// 三层（叶节点层）的四个圆形节点。因此，最底层共有六个可
// 见的叶节点排列成一行。所有节点均为白色填充、灰色边框的
// 圆形，连接线为细灰线配实心箭头。在树的下方标注有两行文
// 字：“Null hypothesis:”和“leaf probability”。此部分传达
// 的概念是：在零假设下，存在单一的状态或过程，从而产生一
// 个特定的叶节点概率分布。 右侧子图： 类型：示意图组合（
// 多个决策树结构与颜色映射条）。 布局：整个区域被一个灰
// 色的线框立方体包围，内部包含三个不同颜色的树状结构和底
// 部的一个颜色条。 上方橙色树（Alternative 1）： 结构：
// 位于右上方的橙色二叉树。根节点标有“r”，同样具有三层结
// 构。 视觉特征：所有节点和连接线均为橙色。最底层的叶节
// 点中，第二个节点被深橙色实心填充，其余节点为浅橙色填充
// 或空心。 标注：树下标注文字“Alternative 1”。 左下方绿
// 色树（Alternative 2）： 结构：位于右下方的绿色二叉树。
// 根节点标有“r”，结构同上。 视觉特征：所有节点和连接线均
// 为绿色。最底层的叶节点中，第三个和第六个节点被深绿色实
// 心填充，其余为浅绿色或空心。 标注：树下标注文字“
// Alternative 2”。 右方蓝色树（Alternative 3）： 结构：
// 位于右侧中间的蓝色二叉树。根节点标有“r”，结构同上。 视
// 觉特征：所有节点和连接线均为蓝色。最底层的叶节点中，第
// 一个、第五个和第六个节点被深蓝色实心填充，其余为浅蓝色
// 或空心。 标注：树下标注文字“Alternative 3”。 底部颜色
// 映射条与总标注： 位置：位于右侧区域的右下角。 内容：一
// 排水平排列的六个圆形色块，从左到右颜色渐变，依次为白色、
// 浅灰色、中灰色、深灰色、更深的灰色、黑色。这代表了叶节
// 点概率的数值大小或权重。 标注：颜色条下方标注两行文字：
// “Alternative hypothesis:”和“leaf probability”。 整体结
// 论：右侧部分通过展示三种不同的状态/过程（Alternative 1
// , 2, 3），每种状态对应不同的叶节点激活模式（颜色深浅不
// 同），传达了备择假设的核心概念：即存在多种可能的状态或
// 过程，每一种都会产生不同的叶节点概率分布。
#figure(image("imgs/Leaf_prob.png", width: 88.0%),
  caption: [
    #emph[Illustration for the leaf probability distribution.] The leaf probability distribution depends on the unknown physical state/process and the learning algorithm. In the null hypothesis, we have a single state/process, which gives rise to a probability distribution over leaves. In the alternative hypothesis, there are multiple possible states/processes. Each state/process produces a different leaf probability distribution. The leaf probability distribution for the alternative hypothesis is the average of all the leaf probability distributions.
  ]
)
<fig:leaf-alt>



In order to establish a lower bound for the many-versus-one distinguishing task, we need to first discuss the leaf probability distribution in the tree representation of the learning algorithm~@huang2021information @chen2021exponential. Recall that depending on the unknown state/process, the transition probabilities among the memory states in the learning algorithm will be different. This is because the outcome probability for each experiment differs when the unknown state/process differs. Therefore, the probability to traverse a certain path in the tree representing an execution of the learning algorithm will change according to the unknown state/process. Hence, the probability to arrive at a particular leaf node in the depth-$T$ tree will change. An illustration is given in Supp.~@fig:leaf-alt.


For each element $X$ in $cal(X)$, the set of all admissible states/channels, we write the probability distribution over leaves as


$ p_X ( ell ) , quad ell : upright("leaf node of the tree") . $


The probability distribution over the leaves $ell$ for the null hypothesis and for the alternative hypothesis are respectively


$ p_(X_0) ( ell ) thin thin thin thin upright("and") thin thin "𝔼"_(X in cal(X) { X_0 }) p_X ( ell ) . $


The probability distribution over $X in cal(X) { X_0 }$ in the expectation $"𝔼"_(X in cal(X) { X_0 })$ is arbitrary. We should choose the probability distribution that yields the largest lower bound.


Suppose that the null hypothesis and the alternative hypothesis are true with probability $1 / 2$ each. If we want to use the memory state of the learning algorithm to distinguish between the null hypothesis and the alternative hypothesis, then the success probability of any procedure is upper bounded by


$ 1 / 2 + 1 / 2 upright("TV") (p_(X_0) , "𝔼"_(X in cal(X) X_0) p_X) = 1 / 2 + 1 / 4 sum_ell lr(|p_(X_0) ( ell ) - "𝔼"_(X in cal(X) X_0) p_X ( ell )|) , $


which is also known as LeCam's two-point method. $upright("TV") ( p_0 , p_1 )$ is the total variation distance between the two probability distributions $p_0 , p_1$.


Intuitively, as we perform more experiments, the depth of the tree increases and the total variation distance between the leaf probability distribution increases. If we want to achieve a prediction accuracy of $p gt.eq 1 / 2$, then we need the total variation distance to be lower bounded by,


$ upright("TV") (p_(X_0) , "𝔼"_(X in cal(X) X_0) p_X) gt.eq 2 p - 1 . $
<eq:TVbound>


On the other hand, the total variation distance can be upper bounded by a monotonically increasing function of the number of experiments~$T$ equal to the depth of the tree. Altogether, this allows us to lower bound the number of experiments $T$ by a function of the success probability $p$.


== Many-versus-many distinguishing task
<sec:many-vs-many>


Sometimes, it is easier to first reduce the learning task to a many-versus-many distinguishing task before reducing to a many-versus-one task. This technique is used in @sec:qpca to prove exponential advantage for quantum principal component analysis. Consider $cal(X)$ to be the set of allowed states/channels. We consider a subset $cal(A) subset.eq cal(X)$, and define $cal(B) = cal(X) cal(A)$. Here, we consider the following two hypotheses.

- Hypothesis A: The unknown state/channel is a random element in $cal(A)$.

- Hypothesis B: The unknown state/channel is a random element in $cal(B)$.

Assume each hypothesis happens with probability $1 / 2$. The goal is to distinguish which hypothesis is true. Because $cal(A) , cal(B)$ can contain many elements in $cal(X)$, we refer to this as the many-versus-many distinguishing task. In Supp. @fig:many-vs-one, we visualize the difference between the #emph[many-versus-many distinguishing task] and the other tasks.


Following a similar derivation as the many-versus-one distinguishing task, for any learning algorithm in the conventional setting, we represent the algorithm as a learning tree. Given a tree representation $cal(T)$, the success probability for any procedure to distinguish hypothesis A and B using the final memory state of the learning algorithm is upper bounded by


$ 1 / 2 + 1 / 2 upright("TV") ("𝔼"_(X in cal(A)) p_X , "𝔼"_(X in cal(B)) p_X) , $


where $p_X$ is a probability distribution over the leaf nodes of the tree $cal(T)$ when the unknown state/channel is $X$. Hence, if we want to achieve a prediction accuracy of $p gt.eq 1 / 2$, then we need the total variation distance to be lower bounded by


$ upright("TV") ("𝔼"_(X in cal(A)) p_X , "𝔼"_(X in cal(B)) p_X) gt.eq 2 p - 1 thin . $
<eq:TVbound-many-vs-many>


This last inequality will be important for establishing the lower bound on the number of experiments $T$.


== Partially-revealed many-versus-one distinguishing task
<sec:part-many-v-one>


// [figvision-cn] imgs/ManyvsOne.png
// 该图由三个子图 (a)、(b) 和 (c) 组成，均为示意图，用于
// 可视化不同类型的区分任务。图中使用不同颜色的立方体代表
// 不同的假设状态。 子图 (a)： 类型：示意图。 布局与物体：
// 该子图展示了一个“多对一”（Many-versus-one）的区分任务。
// 左侧有一个灰色的立方体，其下方标注文字为“Null
// hypothesis”（零假设）。中间有一条垂直的黑线，旁边标注
// 有“or”（或），将左右两侧分开。右侧排列着四个彩色的立方
// 体，呈2x2矩阵分布。左上方的立方体为红色，标注为“
// Alternative A1”；右上方的立方体为蓝色，标注为“
// Alternative B1”；左下方的立方体为橙色，标注为“
// Alternative A2”；右下方的立方体为紫色，标注为“
// Alternative B2”。 结论：此图表示需要从单一的零假设与四
// 个备择假设（A1, B1, A2, B2）中的一个进行区分。 子图 (b
// )： 类型：示意图。 布局与物体：该子图展示了一个“多对多
// ”（Many-versus-many）的区分任务。左侧并列放置两个彩色
// 立方体：上方为红色的“Alternative A1”，下方为橙色的“
// Alternative A2”。中间有一条垂直的黑线，旁边标注有“or”。
// 右侧也并列放置两个彩色立方体：上方为蓝色的“Alternative
// B1”，下方为紫色的“Alternative B2”。 结论：此图表示需要
// 在两组假设之间进行区分，即判断系统处于A组（A1或A2）还
// 是B组（B1或B2）。 子图 (c)： 类型：示意图。 布局与物体：
// 该子图展示了一个“部分揭示的多对一”（Partially-revealed
// many-versus-one）区分任务，整体被分为左右两个区域。 左
// 侧区域：顶部有红色标题文字“Revealed to be A”（已揭示为
// A）。区域内左侧是一个灰色的“Null hypothesis”立方体，中
// 间是带有“or”的垂直分隔线，右侧垂直排列着两个立方体：上
// 方的红色“Alternative A1”和下方的橙色“Alternative A2”。
// 这表示在已知属于A类的情况下，需在零假设与A类备择假设之
// 间区分。 右侧区域：顶部有蓝色标题文字“Revealed to be B
// ”（已揭示为B）。区域内左侧是一个灰色的“Null hypothesis
// ”立方体，中间是带有“or”的垂直分隔线，右侧垂直排列着两
// 个立方体：上方的蓝色“Alternative B1”和下方的紫色“
// Alternative B2”。这表示在已知属于B类的情况下，需在零假
// 设与B类备择假设之间区分。 结论：此图描述了当部分信息（
// 类别A或B）已知时，区分任务的简化形式。
#figure(image("imgs/ManyvsOne.png", width: 100.0%),
  caption: [
    #emph[Visualization of the different distinguishing tasks.] #emph[\(a)] In the many-versus-one distinguishing task, we are distinguishing between the null hypothesis and the alternative hypothesis (which can be one of many alternatives). #emph[\(b)] In the many-versus-many distinguishing task, we want to distinguish between two hypotheses (each of which can be one of many alternatives). #emph[\(c)] In the partially-revealed many-versus-one distinguishing task, some information about the alternatives is revealed, which makes the distinguishing task easier.
  ]
)
<fig:many-vs-one>



In some tasks, it can be challenging to verify if an algorithm has learned accurately without revealing some information to the learning algorithm. Here, we consider a setting where after learning, the algorithm is additionally given some partial information about the underlying state/process.


The set $cal(X)$ of all admissible states/processes can be represented as follows,


$ X = ( xi , chi ) in cal(X) , $


where $xi$ is the information that will be revealed during prediction and $chi$ remains hidden. After performing all experiments, the algorithm can obtain $xi^(*)$, such that the unknown state/process $X$ is guaranteed to be either


$ X_0 quad upright("or") quad ( xi^(*) , chi ) in cal(X) { X_0 } , $


i.e. the null hypothesis or an element of the alternative hypothesis. In Supp. @fig:many-vs-one, we visualize the difference between the #emph[partially-revealed many-versus-one distinguishing task] and other tasks. Due to the additional information revealed to the learning algorithm, the distinguishing task becomes easier. However, in many examples, we show that revealing a significant amount of information to a learning algorithm that only has external classical memory will not significantly help its distinguishing power.


Suppose that after revealing the information $xi^(*)$ to the learning algorithm, the conditional probability for whether the unknown state/process $X$ is $X_0$ (null hypothesis) or one of $( xi^(*) , chi ) in cal(X) { X_0 }$ (alternative hypothesis) is still uniform, i.e., $1 / 2$ and $1 / 2$. Then similar to when the information is not revealed, the success probability of any procedure to distinguish between null and alternative hypothesis is upper bounded by


$ 1 / 2 + 1 / 2 upright("TV") (p_(X_0) , "𝔼"_(( xi^(*) , chi ) in cal(X) without \{X_0\}) p_(( xi^(*) , chi ))) = 1 / 2 + 1 / 4 sum_ell lr(|p_(X_0) ( ell ) - "𝔼"_(( xi^(*) , chi ) in cal(X) without \{X_0\}) p_(( xi^(*) , chi )) ( ell )|) . $


When $xi^(*)$ is chosen randomly, the average success probability is upper bounded by


$ 1 / 2 + 1 / 2 "𝔼"_(xi^(*)) upright("TV") (p_(X_0) , "𝔼"_(( xi^(*) , chi ) in cal(X) without \{X_0\}) p_(( xi^(*) , chi ))) . $


Again, similar to the discussion before, in order to achieve a prediction accuracy of $p gt.eq 1 / 2$, we need to satisfy the inequality


$ "𝔼"_(xi^(*)) upright("TV") (p_(X_0) , "𝔼"_(( xi^(*) , chi ) in cal(X) without \{X_0\}) p_(( xi^(*) , chi ))) gt.eq 2 p - 1 . $
<eq:TVbound-rev>


The left-hand side of the above inequality can be upper bounded by a monotonically increasing function of $T$, hence we can obtain a lower bound on $T$. Note that by Jensen's inequality, the left hand side of the above inequality is larger than the left hand side in @eq:TVbound, so we will obtain a weaker lower bound on $T$. This makes sense because making accurate predictions with partially-revealed information is easier.


== Presence of noise
<sec:noisedegradation>


So far, we have considered protocols for learning quantum states or quantum processes in the absence of noise. There are several forms of noise we can consider: (i) noise on input states, (ii) noise on the POVMs which are measured, and (iii) noise on the quantum process (if there is one). Let us prove the following result:


#thmbox("theorem", "Theorem (Noise cannot decrease the lower bound)")[


If the upper bound


$ upright("TV") ("𝔼"_(X in cal(A)) p_X , "𝔼"_(X in cal(B)) p_X) lt.eq 2 p - 1 $
<E:noisyupper1>


holds for all learning protocols with a classical memory, then this same bound holds for all learning protocols with a classical memory in the presence of noise. Because the upper bound on total variation distance applies when noise is present, so does the lower bound on the number of experiments needed to achieve the distinguishing task.


] <thm:noisylowerbound>


#block[
#emph[Proof.] Consider first the setting of learning an unknown physical state $rho$. Suppose we have a learning protocol with a classical memory described by a learning tree $cal(T)$. At node $u$ in the protocol, we measure the state $rho$ with the POVM $\{F_s^u\}_s$. We will measure the $s$th outcome with probability~◻

]


$ upright("tr") ( F_s^u rho ) thin . $
<E:probus1>


If there is noise on $rho$, we can use $rho mapsto cal(N) \[ rho \]$ for some noise quantum process $cal(N)$. Likewise if there is noise on the POVM, we can use $F_s^u mapsto cal(M)^dagger \[ F_s^u \]$ for a noise quantum process $cal(M)$. Then the probability of the $s$th outcome is instead


$ upright("tr") ( cal(M)^dagger \[ F_s^u \] thin cal(N) \[ rho \] ) = upright("tr") ( ( cal(N)^dagger compose cal(M)^dagger ) \[ F_s^u \] thin rho ) thin . $


But ${ ( cal(N)^dagger compose cal(M)^dagger ) \[ F_s^u \] }_s$ also forms a POVM. We can apply this same argument to each node in the tree; note that the noise channels can be node-dependent. The result is that we simply get a new learning tree with classical memory, with POVM's augmented by the noise channels. But since by hypothesis~@E:noisyupper1 holds for all learning protocols with a classical memory, the bound evidently still holds in the noisy setting.


In the setting where we are learning a physical process $cal(E)$, the argument is similar. Given a learning tree $cal(T)$ for learning the physical process, at node $u$ we (i) prepare the state $rho^u$, (ii) apply the physical process $cal(E)$, and (iii) measure with the POVM $\{F_s^u\}_s$ and obtain outcome $s$ with probability


$ upright("tr") ( F_s^u thin cal(E) \[ rho^u \] ) thin . $


If the initial state is noisy, we can implement this by a channel mapping $rho^u mapsto cal(N) \[ rho^u \]$. If $cal(E)$ is noisy, this can be implemented by $cal(E) mapsto cal(D) compose cal(E) compose cal(F)$. Finally, if the POVM is noisy, we can implement this by $F_s^u mapsto cal(M)^dagger \[ F_s^u \]$. In these circumsntances, the probability of the $s$th outcome is instead


$ upright("tr") ( cal(M)^dagger \[ F_s^u \] thin ( cal(D) compose cal(E) compose cal(F) ) \[ cal(N) \[ rho^u \] \] ) = upright("tr") ( ( cal(D)^dagger compose M^dagger ) \[ F_s^u \] thin cal(E) \[ cal(F) compose cal(N) \[ rho^u \] \] ) thin . $


But ${ ( cal(D)^dagger compose M^dagger ) \[ F_s^u \] }_s$ also forms a POVM, and $( cal(F) compose cal(N) ) \[ rho^u \]$ is also a valid choice of input state. The same argument can be used for noise channels applied at every node in the tree, and moreover the noise can be node-dependent. The result is that we just get a modified learning tree with classical memory, which by assumption satisfies~@E:noisyupper1, as desired. ◻






In summary, we have shown that if a task is hard for all learning protocols with classical memory, then the task is still just as hard (if not harder) in the presence of noise.


== Related works
<sec:related-work>


We begin with existing works that study the separation between conventional and quantum-enhanced strategies for learning physical systems and dynamics. In @bubeck2020entanglement, they establish a polynomial separation between conventional and quantum-enhanced strategies for testing if a state is maximally mixed or not. In @huang2021information @aharonov2021quantum @chen2021exponential, exponential separations between conventional and quantum-enhanced strategies are established for tasks regarding the learning of physical systems and dynamics.


We also mention some relevant works that study other classes of strategies for learning or characterizing physical systems and dynamics. It was shown in Ref. @mohseni_dcqd_2007 that the dynamics of open quantum systems with dimension $d^n$, where $d$ is a prime, can be fully reconstructed with a quadratically fewer experiments over conventional quantum process tomography, with a quantum-enhanced strategy consist of $n$ auxiliary systems of same dimensions $d$ and performing generalized Bell-sate preparations and generalized Bell-state measurements. The results in @haah2017sample give a polynomial separation between a restricted class of conventional strategies and quantum-enhanced strategies for learning the complete description of a quantum state. The results in @huang2020predicting give an exponential separation between a restricted class of conventional strategies and quantum-enhanced strategies for learning to predict properties of a quantum state. @chen2021quantum establish an exponential separation between ancilla-free strategies and ancilla-assisted strategies for learning the eigenvalues in Pauli channels. @chen2021hierarchy give an exponential separation between restricted quantum-enhanced strategies and quantum-enhanced strategies for learning about a quantum state. @anshu2021distributed consider a problem on learning two spatially separated quantum states using local quantum learning algorithms and give an exponential separation between having a quantum or a classical communication channel between the local quantum learning algorithms. In @coudron2020computations @chia2020need, an exponential separation between two bounded-depth quantum learning algorithms are given for learning about an exponential-time quantum process.


= Predicting highly-incompatible observables
<sec:shadow>


The first task we study using the framework of the previous section involves learning about a physical system represented by an $n$-qubit state $rho$. We provide an illustration of the task in Supp.~@fig:learn-obs.

- In conventional experiments, we consider algorithms that can measure each copy of $rho$ one at a time. The algorithm can choose to perform any POVM measurement on each copy, where the POVM measurement can be chosen adaptively based on the outcomes of previous experiments.

- In quantum-enhanced experiments, we consider algorithms that can use a quantum computer to act collectively on multiple copies of $rho$ to obtain entangled measurement data.

In both scenarios, we consider all quantum data to be used during the learning phase, and we are left only with classical measurement data. After this learning phase, the learner is then asked to provide accurate predictions for the expectation value of an observable $O$, using the classical data obtained from the experiments. The observable $O$ is selected from an exponentially large set $( O_1 , O_2 , dots.h O_M )$, where $O_1 , dots.h , O_M$ may not be mutually commuting and $M$ is exponential in $n$.


Note that when the observables in the set are not mutually commuting, it is impossible to measure all of them simultaneously. Hence, a naïve algorithm in the conventional scenario would be to measure the exponential number of observables individually, which would result in exponential sample complexity.


// [figvision-cn] imgs/LearnState.png
// 这是一幅展示预测高度不兼容可观测量任务的流程示意图，整
// 体布局从左至右分为三个主要区域：左侧为“传统实验”方案，
// 中间为“量子增强实验”方案，右侧为数据处理与预测输出部分。
// 左侧区域标题为“Conventional experiments”，包含三个垂直
// 排列的相同单元。每个单元由一个绿色球体和一个指向右侧的
// 箭头及一个立方体组成。绿色球体表面绘有蓝色网格线，代表
// 未知的量子态；箭头表示操作流向；立方体正面绘有一个带箭
// 头的半圆符号，代表对单个量子态副本进行的独立测量装置。
// 三个单元并列排布，表明传统方法是对多个状态副本逐个进行
// 独立测量。 中间区域标题为“Quantum-enhanced experiments
// ”，同样包含三个垂直排列的绿色球体（结构与左侧相同），
// 但它们的箭头共同指向右侧一个高大的浅蓝色长方体。该长方
// 体侧面标注文字“Entangled measurement”，顶部和底部边缘
// 略向内收，呈现立体感。此结构表示将多个量子态副本存储于
// 量子存储器中，并通过纠缠测量联合处理。在左右两个大区域
// 之间有一条垂直分隔线，线上标注“or”，表示两种实验路径是
// 互斥选择关系。 右侧区域起始于从“量子增强实验”模块引出
// 的灰色箭头，指向一个标有“Classical Data”的矩形框，表示
// 经典数据输出。从此框再引出箭头指向一台深蓝色电脑显示器
// 图标，屏幕内显示“Predicting ...”字样及四个彩色柱状图（
// 红、橙、蓝、紫），象征正在进行的预测过程。显示器下方是
// 一个灰色对话气泡，内含文字“Predict property O”，指向右
// 侧一个奔跑姿态的人形剪影，人形面向左方，似在接收或执行
// 预测结果。整个右侧流程表达：无论采用哪种实验方式，最终
// 都将产生经典数据用于预测目标属性O。 全图无坐标轴、数值
// 范围或颜色映射说明，属于纯概念性流程图。所有图形元素均
// 为平面矢量风格，色彩简洁明确：绿色代表未知量子态，浅蓝
// 色代表纠缠测量模块，深蓝色代表计算设备，灰色代表数据流
// 与人形交互界面。图中未出现比例尺或成像通道信息，因非显
// 微图像或定量曲线图。核心结论通过对比左右两路实验路径传
// 达：传统方法逐次独立测量，而量子增强方法利用纠缠联合测
// 量以提升预测效率或精度，两者均可导向同一预测任务。
#figure(image("imgs/LearnState.png", width: 95.0%),
  caption: [
    #emph[Illustration for the task of predicting highly-incompatible observables.] The unknown quantum state $rho$ is represented by the green sphere. Conventional experiments measure each copy of state $rho$ individually, and the measurements can depend adaptively on previous measurements. Quantum-enhanced experiments store many copies of $rho$ in a quantum memory, process the copies with a quantum computer, and produce an entangled measurement outcome. The classical data obtained from the experiments are used to predict a property of $rho$.
  ]
)
<fig:learn-obs>



== Exponential advantage in predicting absolute value of a single observable
<sec:expo-adv-abs-one>


We will prove that even predicting the absolute value of just a single observable requires exponentially many copies in the conventional scenario. In contrast, an algorithm with quantum memory can predict the expectation values for $M$ arbitrary observables from only $cal(O) ( n log ( M ) / epsilon.alt^4 )$ copies of $rho$ through the procedure known as shadow tomography @aaronson2019shadow @aaronson2019gentle @buadescu2020improved. Hence, even if we would like to predict an exponential number of observables, an algorithm with quantum memory only needs a polynomial number of copies.


In fact, for certain natural instances, we can show an even more dramatic separation. Specifically, for the following states and observables, we will show how to achieve an exponential versus #emph[constant] separation.


#thmbox("definition", "Definition (Separation instance)")[


Consider a distribution $cal(D)$ over $n$-qubit state $rho$ and observable $O$.

+ With probability $1 / 2$, the state is $rho = I / 2^n$ and $O in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ is chosen uniformly at random.

+ With probability $1 / 2$, the state is $rho = ( I + 0.9 s P ) / 2^n$ and $O = P$, where $s = { plus.minus 1 }$ with equal probability and $P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ is chosen uniformly at random.#footnote[While $0.9$ is used in the definition $rho = ( I + 0.9 s P ) / 2^n$, any constant value smaller than $1$ is sufficient to obtain the exponential separation. A technical difficulty arises when we consider $( I + s P ) / 2^n$, and it is unclear whether this difficulty is fundamental.]


] <def:hardrhoO>


The $n$-qubit state $rho$ considered in the above definition does not contain any quantum entanglement. The state $rho$ can be written as a classical probability distribution over tensor products of single-qubit states. Despite the lack of quantum entanglement, we can still achieve an exponential versus constant separation. This result is a substantial improvement over the result established in @huang2021information. In @huang2021information, some of the authors showed an $Omega ( 2^(n / 3) )$ versus $cal(O) ( n )$ separation between conventional and quantum-enhanced strategies, but the task was to predict an exponential number of observables, which can only be verified using an exponential amount of time.


#thmbox("theorem", "Theorem (Exponential advantage in predicting highly-incompatible observables)")[


We sample an $n$-qubit state $rho$ and an observable $O$ according to $cal(D)$ given in @def:hardrhoO\; both of these are unknown to the algorithm. The algorithm then learns about $rho$ through conventional or quantum-enhanced experiments. After the learning phase, we ask the learning algorithm to predict $lr(|"tr" ( O rho )|)$.

- #emph[Upper bound:] There is an algorithm in the #strong[quantum-enhanced] scenario using only $cal(O) ( 1 )$ copies of $rho$ to predict up to $0.25$ additive error with probability at least $0.8$.

- #emph[Lower bound:] For any algorithm in the #strong[conventional] scenario, it needs at least $Omega ( 2^n )$ copies of $rho$ to predict up to $0.25$ additive error with probability at least $0.8$.


] <thm:obs-adv>


Here, we are using the standard Big-$cal(O)$ and Big-$Omega$ notations: $f = Omega ( g )$ if there is an $n_0 , C > 0$ such that $forall n > n_0$, $f ( n ) gt.eq C g ( n )$\; and $f = cal(O) ( g )$ if there is an $n_0 , M > 0$ such that $forall n > n_0$, $| f ( n ) | lt.eq M g ( n )$. We separate the proof of @thm:obs-adv into the following two subsections. In @sec:uppbd-obs, we prove a constant upper bound for quantum-enhanced experiments for this task. In @sec:lowbd-obs, we prove an exponential lower bound for conventional experiments for the same task.


== A constant upper bound for quantum-enhanced experiments
<sec:uppbd-obs>


The learning algorithm in the quantum-enhanced scenario builds on results presented in @huang2021information. We separate the protocol into the learning phase, where entangled measurements are performed, and the prediction phase, where we predict the desired properties.


=== Learning phase
<learning-phase>


Consider $N_(upright(Q))$ rounds of two-copy entangled measurements. In round $t in ( 1 , dots.h , N_(upright(Q)) )$, for every $k in ( 1 , dots.h , n )$ we measure the $k$-th qubit from the first and second copies of $rho$ in the Bell basis to obtain


$ S_k^(( t )) in ( | Psi^(+) chevron.r chevron.l Psi^(+) | , | Psi^(-) chevron.r chevron.l Psi^(-) | , | Phi^(+) chevron.r chevron.l Phi^(+) | , | Phi^(-) chevron.r chevron.l Phi^(-) | ) , $
<eq:Bell-basis-meas>


where the Bell basis encompasses four maximally entangled two-qubit states. Here, $| Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r + | 11 chevron.r)$ is the Bell state, and we additionally have


#[
#set math.equation(numbering: none)
$ & | Psi^(+) chevron.r = I ⊗ I | Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r + | 11 chevron.r) , \
  & | Psi^(-) chevron.r = I ⊗ Z | Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r - | 11 chevron.r) , \
  & | Phi^(+) chevron.r = I ⊗ X | Omega chevron.r = 1 / sqrt(2) (| 01 chevron.r + | 10 chevron.r) , \
  & | Phi^(-) chevron.r = upright(i) I ⊗ Y | Omega chevron.r = 1 / sqrt(2) (| 01 chevron.r - | 10 chevron.r) . $
]


Then, we efficiently store the measurement data $S_k^(( t )) , forall k = 1 , dots.h , n , forall t = 1 , dots.h , N_(upright(Q))$ in a classical memory with $2 n N_(upright(Q))$ classical bits.


=== Prediction phase
<prediction-phase>


Given an observable $O$ drawn from $( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$, we can use the block of classical memory obtained in the learning phase to estimate $| "tr" ( O rho ) |$. First let us consider the case where $rho$ is a single-qubit state. When we measure $rho ⊗ rho$ in the Bell basis, the measurement outcome $S$ is a projector onto one of the four Bell states given in @eq:Bell-basis-meas. Let $sigma in ( I , X , Y , Z )$ be any Pauli matrix. Each Bell state is an eigenstate of $sigma ⊗ sigma$ with an eigenvalue $plus.minus 1$. The probability that the Bell measurement outcome $S$ is an eigenstate of $sigma ⊗ sigma$ with eigenvalue $+ 1$ is


$ upright("Prob") ( + ) = 1 / 2 "tr" (( I ⊗ I + sigma ⊗ sigma ) ( rho ⊗ rho )) , $


while the $- 1$ eigenvalue occurs with probability


$ upright("Prob") ( - ) = 1 / 2 "tr" (( I ⊗ I - sigma ⊗ sigma ) ( rho ⊗ rho )) . $


Therefore, we have


$ "𝔼" \["tr" (( sigma ⊗ sigma ) S)\] = upright("Prob") ( + ) - upright("Prob") ( - ) = "tr" (( sigma ⊗ sigma ) ( rho ⊗ rho )) = | "tr" ( sigma rho ) |^2 , $


where $"𝔼"$ denotes the expectation with respect to the probability distribution over Bell measurement outcomes. We see that the entangling Bell measurement enables us to estimate the absolute value $| "tr" ( sigma rho ) |$ for any Pauli matrix $sigma in (I , X , Y , Z)$.


We can generalize this observation to the case where $rho$ is an $n$-qubit state, and each pair of qubits in $rho ⊗ rho$ is measured in the Bell basis to yield the outcomes $( S_k , k = 1 , 2 , dots.h , n )$. If $O = sigma_1 ⊗ dots.h.c ⊗ sigma_n$ is a Pauli observable, then as in the $n = 1$ case the Bell state $S_k$ is an eigenstate of $sigma_k ⊗ sigma_k$ with eigenvalue $plus.minus 1$ for each $k$. This implies that $⨂_(k = 1)^n S_k$ is an eigenstate of $O ⊗ O$ with an eigenvalue $plus.minus 1$. In particular, let us consider the product


$ product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k) = plus.minus 1 . $


This product is equal to $+ 1$ when the tensor product of the Bell measurement outcomes $⨂_(k = 1)^n S_k$ is an eigenstate of $O ⊗ O$ with eigenvalue $+ 1$, and it is $- 1$ when $⊗_(k = 1)^n S_k$ is an eigenstate of $O ⊗ O$ with eigenvalue $- 1$. We conclude that


$ "𝔼" \[product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k)\] & = "𝔼" \["tr" (( O ⊗ O ) ⨂_(k = 1)^n S_k)\]\
 & = upright("Prob") ( O ⊗ O = + 1 ) - upright("Prob") ( O ⊗ O = - 1 )\
 & = "tr" (( O ⊗ O ) ( rho ⊗ rho ))\
 & = | "tr" ( O rho ) |^2 , $<eq:bell-expected>


where $"𝔼"$ denotes the expectation with respect to the probability distribution of Bell measurement outcomes. The above derivation shows that the $n$-qubit entangling Bell measurement enables us to estimate the absolute value $| "tr" ( O rho ) |$ for any $O$ considered in @def:hardrhoO.


Because @eq:bell-expected relates the probability distribution of Bell measurement outcomes to the absolute value $| "tr" ( O rho ) |$, we can estimate $| "tr" ( O rho ) |$ accurately by repeatedly making entangling Bell measurements on successive pairs of copies of $rho$ sufficiently many times. Specifically, in the learning phase, we perform the entangling Bell measurement on $N_(upright(Q))$ pairs of copies of $rho$, and collect the measurement data ${ S_k^(( t )) }$ in the classical memory, where $k = 1 , 2 , dots.h , n$ labels the qubit pairs, and $t = 1 , 2 , dots.h , N_(upright(Q))$ labels the different rounds of measurements. For any given $n$-qubit Pauli observable $O = sigma_1 ⊗ dots.h.c ⊗ sigma_n$, we consider the following estimator


$ hat(a) ( O ) = 1 / N_Q sum_(t = 1)^(N_Q) product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k^(( t ))) , $


which can be computed efficiently in time $cal(O) ( n N_(upright(Q)) )$.


Using the expectation evaluated in @eq:bell-expected, we can apply Hoeffding's inequality to show that the estimate $hat(a) ( O )$ is equal to the expectation value $"tr" ( ( O ⊗ O ) ( rho ⊗ rho ) ) = | "tr" ( O rho ) |^2$ up to a small error with high probability. The formal statement is given below.


#thmbox("lemma", "Lemma")[


Given $N_(upright(Q)) = Theta ( log ( 1 / delta ) / epsilon.alt^2 )$. For any observable $O$ considered in @def:hardrhoO, we have


$ lr(|hat(a) ( O ) - | "tr" ( O rho ) |^2|) lt.eq epsilon.alt , $


with probability at least $1 - delta$.


] <lem:hoeffPauli>


To obtain an estimate for the absolute value $| "tr" ( O rho ) |$, we consider the estimate


$ hat(b) = sqrt(max ( 0 , hat(a) )) . $


We can show the inequalities


$ | "tr" ( O rho ) |^2 - epsilon.alt lt.eq hat(a) lt.eq | "tr" ( O rho ) |^2 + epsilon.alt \
 & arrow.r.double.long max ( 0 , sqrt(| "tr" ( O rho ) |^2) - sqrt(epsilon.alt) ) lt.eq hat(b) lt.eq sqrt(| "tr" ( O rho ) |^2) + sqrt(epsilon.alt) , $


using the fact that $sqrt(x + y) lt.eq sqrt(x) + sqrt(y)$.


In the final step of the upper bound proof, we use @lem:hoeffPauli to obtain the following result. As long as $N_(upright(Q)) = cal(O) ( 1 )$, we can estimate the absolute value of $"tr" ( O rho )$ for any observable $O$ given in @def:hardrhoO to an error $0.25$ with probability at least $0.8$.


#thmbox("corollary", "Corollary")[


Let $N_(upright(Q)) = Theta ( 1 )$. For any observable $O$ considered in @def:hardrhoO, we have


$ lr(|hat(b) - | "tr" ( O rho ) ||) lt.eq 0.25 , $


with probability at least $0.8$.


] <cor:absPauli>


This concludes the constant upper bound for quantum-enhanced experiments in @thm:obs-adv.


== An exponential lower bound for conventional experiments
<sec:lowbd-obs>


The proof begins with a reduction to the partially-revealed many-versus-one distinguishing task followed by bounding the total variation distance.


=== Reduction to partially-revealed many-versus-one distinguishing task
<reduction-to-partially-revealed-many-versus-one-distinguishing-task>


We consider the following partially-revealed many-versus-one distinguishing task discussed in @sec:part-many-v-one, namely where:

- The null hypothesis is $I / 2^n$.

- The alternative hypothesis is $( I + 0.9 s P ) / 2^n$.

The partially revealed information is the Pauli operator $P$. Recall the following from @def:hardrhoO,

+ With probability $1 / 2$, the state is $rho = I / 2^n$ and $O in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ is sampled uniformly at random. (Corresponds to the null hypothesis)

+ With probability $1 / 2$, the state is $rho = ( I + 0.9 s P ) / 2^n$ and $O = P$, where $s = { plus.minus 1 }$ with equal probability and $P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ uniformly. (Corresponds to the alternative hypothesis)

For $rho = I / 2^n$, we have $| "tr" ( O rho ) | = 0$. For $rho = ( I + 0.9 s P ) / 2^n$, we have $| "tr" ( O rho ) | = 0.9$. Therefore, if an algorithm could predict $| "tr" ( O rho ) |$ to $0.25$ error with probability at least $1 - delta$, it could be used to distinguish between the null and alternative hypotheses with success probability at least $1 - delta$.


=== Total variation distance
<total-variation-distance>


From the information-theoretic lower bound for partially-revealed many-versus-one distinguishing task given in @sec:part-many-v-one, if we let $p_rho ( ell )$ be the leaf probability distribution under $rho$, then


$ "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) upright("TV") (p_(I / 2^n) , "𝔼"_(s in { plus.minus 1 }) p_(( I + 0.9 s P ) / 2^n)) gt.eq 1 - 2 delta . $
<eq:TVLB>


For each leaf node $ell$, we consider the path from the root to $ell$,


$ u_0 = r arrow.r^(s_1) u_1 arrow.r^(s_2) u_2 arrow.r^(s_3) dots.h arrow.r^(s_(T - 1)) u_(T - 1) arrow.r^(s_T) u_T = ell . $


At each node $u$, we perform a POVM measurement ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }_s$ on $rho$ to obtain an outcome $s$ with probability


$ w_s^u chevron.l phi.alt_s^u | rho | phi.alt_s^u chevron.r . $


Hence, we can write down the probability to arrive at the leaf $ell$ as


$ p_rho ( ell ) = product_(t = 1)^T w_(s_t)^(u_(t - 1)) chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho | phi.alt_(s_t)^(u_(t - 1)) chevron.r . $


Recalling the definition of total variation distance, note that for any probability distributions $p_A , p_B$ for which $p_A ( ell ) > 0$ whenever $p_B ( ell ) > 0$,


$ upright("TV") ( p_A , p_B ) = 1 / 2 sum_ell | p_A ( ell ) - p_B ( ell ) | = sum_ell max ( 0 , p_A ( ell ) - p_B ( ell ) ) \
 & = sum_ell p_A ( ell ) dot.op max (0 , 1 - frac(p_B ( ell ), p_A ( ell ))) , $
<eq:tv_fdiv>


where the last equality follows from $max ( a x , a y ) = a max ( x , y )$ for all $x , y in bb(R)$ and all $a gt.eq 0$.


Observe that for leaf $ell$,


$ frac("𝔼"_(s in { plus.minus 1 }) p_(( I + 0.9 s P ) / 2^n) ( ell ), p_(I / 2^n) ( ell )) & = frac("𝔼"_(s in { plus.minus 1 }) product_(t = 1)^T w_(s_t)^(u_(t - 1)) chevron.l phi.alt_(s_t)^(u_(t - 1)) | frac(I + 0.9 s P, 2^n) | phi.alt_(s_t)^(u_(t - 1)) chevron.r, product_(t = 1)^T w_(s_t)^(u_(t - 1)) chevron.l phi.alt_(s_t)^(u_(t - 1)) | I / 2^n | phi.alt_(s_t)^(u_(t - 1)) chevron.r)\
 & = "𝔼"_(s in { plus.minus 1 }) product_(t = 1)^T (1 + 0.9 s chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r) . $<eq:lr>


Combining @eq:tv_fdiv and @eq:lr, we can express the total variation distance inside the expectation in @eq:TVLB as


$ upright("TV") (p_(I / 2^n) , "𝔼"_(s in { plus.minus 1 }) p_(( I + 0.9 s P ) / 2^n)) = sum_ell p_(I / 2^n) ( ell ) thin max (0 , thin thin 1 - "𝔼"_(s in { plus.minus 1 }) product_(t = 1)^T (1 + 0.9 s chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r)) $


=== Upper bound for total variation distance
<upper-bound-for-total-variation-distance>


We analyze one of the terms in the total variation distance using Jensen's inequality (note that $exp ( x )$ is a convex function in $x$).


$  & "𝔼"_(s in { plus.minus 1 }) product_(t = 1)^T (1 + 0.9 s chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r)\
 & = "𝔼"_(s in { plus.minus 1 }) exp \[sum_(t = 1)^T log (1 + 0.9 s chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r)\]\
 & gt.eq exp \["𝔼"_(s in { plus.minus 1 }) sum_(t = 1)^T log (1 + 0.9 s chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r)\]\
 & = exp \[sum_(t = 1)^T 1 / 2 log (1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\]\
 & = product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) thin . $


We can then upper bound the total variation distance as


$  & upright("TV") (p_(I / 2^n) , "𝔼"_(s in { plus.minus 1 }) p_(( I + 0.9 s P ) / 2^n))\
 & lt.eq sum_ell p_(I / 2^n) ( ell ) thin max ( 0 , thin thin 1 - product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) )\
 & = sum_ell p_(I / 2^n) ( ell ) thin ( 1 - product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) ) thin . $<eq:TVUB>


The last equality follows from the fact that all eigenvalues of $P$ are $plus.minus 1$, hence $1 gt.eq product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)$.


=== Lower bound for the number of measurements
<lower-bound-for-the-number-of-measurements>


We can combine @eq:TVUB and @eq:TVLB to find


$ "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) sum_ell p_(I / 2^n) ( ell ) thin ( 1 - product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) ) gt.eq 1 - 2 delta . $


By linearity of expectation, we have


$ sum_ell p_(I / 2^n) ( ell ) thin ( 1 - "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) ) gt.eq 1 - 2 delta . $
<eq:TV-UBLB>


We analyze the expectation value term in the summand as follows:


$  & "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\
 & = "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) exp \[1 / 2 sum_(t = 1)^T log (1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\]\
 & gt.eq exp \[1 / 2 sum_(t = 1)^T "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) log (1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\]\
 & gt.eq exp \[1 / 2 sum_(t = 1)^T "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) - 1.701 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2\]\
 & = exp \[- 0.8505 sum_(t = 1)^T frac(1, 2^n + 1)\] $ <eq:sqrt0.81>

$ & = exp (- frac(0.8505 T, 2^n + 1)) . $ <eq:0.8505>


The second line follows from Jensen's inequality because $exp ( x )$ is convex in $x$. The third line uses $log ( 1 - x ) gt.eq - 2.1 x , forall x in \[ 0 , 0.82 \]$. The fourth line uses the fact that


$ "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) P ⊗ P = frac(2^n upright("SWAP") - I ⊗ I, 4^n - 1) , $


hence $"𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2 = frac(2^n - 1, 4^n - 1) = frac(1, 2^n + 1)$.


Combining the analysis with @eq:TV-UBLB, we find that


$ sum_ell p_(I / 2^n) ( ell ) thin ( 1 - exp (- frac(0.8505 T, 2^n + 1)) ) gt.eq 1 - 2 delta . $


Because $sum_ell p_(I / 2^n) ( ell ) = 1$, we have


$ 1 - exp (- frac(0.8505 T, 2^n + 1)) gt.eq 1 - 2 delta . $


Together, the following lower bound on the number of experiments can be obtained:


$ T gt.eq frac(2^n + 1, 0.8505) log (frac(1, 2 delta)) . $


After setting $delta = 0.2$ (corresponding to a success probability of at least $0.8$), we conclude the exponential lower bound for conventional experiments in @thm:obs-adv.


== An exponential lower bound for comparing absolute values
<sec:compare-abs-value>


In the physical experiment presented in the main text, we considered a slightly different task that also yields an exponential lower bound for conventional experiments. This slightly different task has two main differences when compared with the task described in @sec:lowbd-obs. First, we do not consider the maximally mixed state $I / 2^n$. Second, we ask the learner to predict which of two observables $O_1 , O_2$ has a larger absolute value. The task description is given below.


#thmbox("task", "Task (Comparing absolute values)")[


There is an unknown state $rho = ( I + 0.9 s P ) / 2^n$ where $s = { plus.minus 1 }$ and $P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ are both sampled uniformly at random. The algorithm learns about $rho$ through conventional or quantum-enhanced strategies. The algorithm transforms all quantum data to classical data. After learning, we present the learning algorithm with


$ O_1 = P , thin thin O_2 = Q thin thin quad upright("or") thin thin quad O_1 = Q , thin thin O_2 = P , $


with equal probability, where $Q eq.not P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ is sampled uniformly. The learning algorithm succeeds if it correctly classifies whether $| "tr" ( O_1 rho ) | > | "tr" ( O_2 rho ) |$ or $| "tr" ( O_1 rho ) | < | "tr" ( O_2 rho ) |$.


] <task:comp-abs>


Using the procedure presented in @sec:uppbd-obs, it is not hard to show that quantum-enhanced strategies could accomplish the above task with classification accuracy (i.e., the probability that the classification is correct) at least $1 - delta$ from only $cal(O) ( log ( 1 / delta ) )$ experiments. In contrast, we have the following theorem for conventional experiments.


#thmbox("theorem", "Theorem (Exponential lower bound for Task~@task:comp-abs)")[


A learning algorithm in the conventional setting (without quantum memory) requires at least


$ frac(( 2^n + 1 ), 0.8505) log (frac(2, 1 + 2 delta)) $


experiments to accomplish @task:comp-abs with an accuracy of $1 - delta$, for a given $delta > 0$.


] <thm:comp-abs>


=== Lower bound for total variation distance
<lower-bound-for-total-variation-distance>


Here we begin the proof of @thm:comp-abs. @task:comp-abs is closely related to the partially-revealed many-versus-one distinguishing task, but is not exactly the same. We will utilize a slightly different information-theoretic bound for this task. Let us define the following notation


$ rho_(s P) equiv frac(I + 0.9 s P, 2^n) . $


We consider a learning algorithm in the conventional setting. We consider the probability distribution $p_rho ( ell )$ over the leaf node $ell$ when the underlying state is $rho$. Recall that the leaf node $ell$ is the final memory state of the learning algorithm. Any procedure that makes the prediction based on the final memory state of the learning algorithm must have a classification accuracy upper bounded by


$ & frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) \
  & quad times \[1 / 2 + 1 / 2 upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell ))\] thin . $
<eq:PQ-TV>


To understand why the above inequality holds, consider a fixed $P eq.not Q$. There is an equal probability that the underlying state is $rho_(+ P) , rho_(- P) , rho_(+ Q) ,$ or $rho_(- Q)$ because $s in { plus.minus 1 }$ with equal probability and $O_1 = P , O_2 = Q$ or $O_1 = Q , O_2 = P$ with probability $1 / 2$. In order to distinguish the event of $rho_(+ P) , rho_(- P)$ from the event $rho_(+ Q) , rho_(- Q)$ based on the leaf node $ell$, we need the two distributions $"𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell )$ and $"𝔼"_(s in { plus.minus 1 }) p_ell ( rho_(s Q) )$ to be sufficiently distinct. Formally, one can show that the success probability is upper bounded by


$ 1 / 2 + 1 / 2 upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell )) $


using LeCam's two-point method, see e.g.~Lemma 1 in~@yu1997assouad. To achieve the above success probability, one can use the maximum likelihood protocol that outputs $P$ if $"𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) > "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell )$ and outputs $Q$ otherwise. Because $P , Q$ are both chosen uniformly at random (but distinct), the average classification accuracy is given in @eq:PQ-TV. If the learning algorithm could achieve an accuracy of $1 - delta$, we would have


$ ( 1 - delta ) lt.eq 1 / 2 + frac(1, 2 ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell )) . $


This implies that


$ & 1 - 2 delta lt.eq frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) \
  & quad times upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell )) . $
<eq:1-2delta-lowerbound>


=== Upper bound for total variation distance
<upper-bound-for-total-variation-distance>


We now perform triangle inequalities and reuse inequalities in @sec:lowbd-obs to upper bound the total variation distance:


$ & upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell )) \
 & quad lt.eq upright("TV") (p_(I / 2^n) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell )) \
 & quad quad + upright("TV") (p_(I / 2^n) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell ))\
 & lt.eq sum_ell p_(I / 2^n) ( ell ) thin ( 1 - product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) )\
 & #h(2em) + sum_ell p_(I / 2^n) ( ell ) thin ( 1 - product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | Q | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) )\
 & = 1 - sum_ell p_(I / 2^n) ( ell ) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\
 & #h(2em) + 1 - sum_ell p_(I / 2^n) ( ell ) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | Q | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2) . $<eq:sqrt0.81-Q->


The first line is triangle inequality. The second inequality uses @eq:TVUB for both $P$ and $Q$. The equality step uses $sum_ell p_(I / 2^n) ( ell ) = 1$. Therefore, we have


$  & frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) upright("TV") ("𝔼"_(s in { plus.minus 1 }) p_(rho_(s P)) ( ell ) , "𝔼"_(s in { plus.minus 1 }) p_(rho_(s Q)) ( ell ))\
 & lt.eq 1 - frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) \[sum_ell p_(I / 2^n) ( ell ) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\]\
 & #h(2em) + 1 - frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) \[sum_ell p_(I / 2^n) ( ell ) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | Q | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\]\
 & = 1 - sum_ell p_(I / 2^n) ( ell ) "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | P | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\
 & #h(2em) + 1 - sum_ell p_(I / 2^n) ( ell ) "𝔼"_(Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | Q | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)\
 & = 1 - sum_ell p_(I / 2^n) ( ell ) exp (- frac(0.8505 T, 2^n + 1)) + 1 - sum_ell p_(I / 2^n) ( ell ) exp (- frac(0.8505 T, 2^n + 1)) $ <E:third1>

$ & = 2 - 2 exp (- frac(0.8505 T, 2^n + 1)) . $ <eq:2x0.8505>


In the above inequalities, the first inequality uses @eq:sqrt0.81-Q-. The equality thereafter uses the following analysis,


$  & frac(1, ( 4^n - 1 ) ( 4^n - 2 )) sum_(P eq.not Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) f ( P )\
 & = frac(1, 4^n - 1) sum_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) f ( P ) (frac(1, 4^n - 2) sum_(Q in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }\
upright("s") thin upright(".") thin upright("t") thin upright(".") thin Q eq.not P) 1)\
 & = frac(1, 4^n - 1) sum_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) f ( P )\
 & = "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) f ( P ) thin , $


where $f ( P ) = sum_ell p_(I / 2^n) ( ell ) product_(t = 1)^T sqrt(1 - 0.81 chevron.l phi.alt_(s_t)^(u_(t - 1)) | Q | phi.alt_(s_t)^(u_(t - 1)) chevron.r^2)$, as well as linearity of expectation, i.e.


$ "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) sum_ell p_(I / 2^n) ( ell ) = sum_ell p_(I / 2^n) ( ell ) "𝔼"_(P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }) . $


The third step in @E:third1 uses @eq:sqrt0.81~to~@eq:0.8505, and the final step uses $sum_ell p_(I / 2^n) ( ell ) = 1$.


=== Combining upper and lower bounds
<combining-upper-and-lower-bounds>


We can combine the lower bound obtained in @eq:1-2delta-lowerbound and the upper bound in @eq:2x0.8505 to find


$ 1 - 2 delta lt.eq 2 - 2 exp (- frac(0.8505 T, 2^n + 1)) . $


Basic algebraic manipulations give


$ frac(0.8505 T, 2^n + 1) gt.eq - log (1 / 2 + delta) = log (frac(2, 1 + 2 delta)) . $


We have thus concluded the desired lower bound


$ T gt.eq frac(( 2^n + 1 ), 0.8505) log (frac(2, 1 + 2 delta)) $


stated in @thm:comp-abs.


= Performing quantum principal component analysis
<sec:qpca>


The (first) principal component of a nonnegative Hermitian matrix $A$ is the eigenvector of $A$ with the largest eigenvalue. Here, we consider a well-known task called quantum principal component analysis (PCA), which can be achieved efficiently using the quantum algorithm given in @lloyd2014quantum. The formal definition of the quantum PCA task is given in the following definition.


#thmbox("task", "Task (Quantum principal component analysis task)")[


Let $rho$ be an unknown $n$-qubit mixed state whose top eigenvector $| phi.alt chevron.r$ has eigenvalue larger than all other eigenvalues by a constant factor independent of $n$. Given a fixed observable $O$, we would like to predict $chevron.l phi.alt | O | phi.alt chevron.r$ up to a small additive error.


]


We can accomplish this task using the quantum PCA algorithm in @lloyd2014quantum. In this algorithm, multiple copies of $rho$ are used in a protocol that approximates the unitary operator $sum_t | t chevron.r chevron.l t | ⊗ exp ( - i rho t )$, where $t$ is the "time" stored in an auxiliary register. By applying this conditional $exp ( - i rho t )$ operation to the initial state $rho = sum_i lambda_i | phi.alt_i chevron.r chevron.l phi.alt_i |$, performing the quantum Fourier transform and measuring the auxiliary register, we read out an eigenvalue $lambda_i$ and prepare the corresponding eigenstate $| phi.alt_i chevron.r$ with probability $lambda_i$. The eigenvalue can be measured with constant accuracy, and the eigenstate prepared with constant fidelity, using a constant number of copies of $rho$. Once $| phi.alt_i chevron.r$ has been prepared, we can measure the observable $O$ in this state.


By assumption, the largest eigenvalue of $rho$ is a constant independent of $n$, and furthermore is greater than all other eigenvalues by a constant. Hence by repeating the above procedure a constant number of times, we can estimate $chevron.l phi.alt | O | phi.alt chevron.r$ to constant accuracy, where $| phi.alt chevron.r$ is the eigenstate of $rho$ with the largest eigenvalue. In contrast, in @sec:conv-exp-LB-pca we show that algorithms that can only learn about $rho$ through conventional experiments require an exponential number of copies of $rho$. Bringing these arguments all together, we establish the following theorem.


#thmbox("theorem", "Theorem (Exponential advantage for quantum principal component analysis)")[


Let $rho$ be an unknown $n$-qubit mixed state (for $n > 1$) whose top eigenvector $| phi.alt chevron.r$ has eigenvalue larger than all the other eigenvalues by a constant, and let $Z_1$ be an observable which is equal to the Pauli-$Z$ operator on the first qubit. Algorithms learn about $rho$ through conventional or quantum-enhanced experiments.

- #emph[Upper bound:] There is an algorithm in the #strong[quantum-enhanced] scenario using only $cal(O) ( 1 )$ copies of $rho$ to predict $chevron.l phi.alt | Z_1 | phi.alt chevron.r$ up to $0.25$ error with probability at least $0.8$.

- #emph[Lower bound:] Any algorithm in the #strong[conventional] scenario needs at least $Omega ( 2^(n / 2) )$ copies of $rho$ to predict $chevron.l phi.alt | Z_1 | phi.alt chevron.r$ up to $0.25$ error with probability at least $0.8$.


] <thm:qPCA>


Instead of estimating $chevron.l phi.alt | Z_1 | phi.alt chevron.r$, we can also consider the near-term proposals @cotler2019quantum @huggins2020virtual to obtain some information about the principal component $| psi chevron.r$ of an unknown state $rho$ as follows. The proposals consider $rho^M / "tr" ( rho^M )$, which approaches $| psi chevron.r chevron.l psi |$ when $M$ is large. In particular, @huggins2020virtual shows that one can efficiently estimate $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 )$ by performing entangling Bell measurements over at most two copies of $rho$ at a time. By the analysis in @huggins2020virtual, if the eigenvalue associated to the principal component of $rho$ is a constant, then $"tr" ( Z_i rho^2 ) / "tr" ( rho^2 )$ can be estimated to any constant error by performing quantum-enhanced experiments over a constant number of copies of $rho$. In contrast, we show that if one can only measure a single copy of $rho$ at a time, exponentially many copies are necessary to estimate $"tr" ( Z_i rho^2 ) / "tr" ( rho^2 )$.


#thmbox("theorem", "Theorem (Exponential advantage for near-term quantum principal component analysis)")[


Suppose we are given an observable $Z_1$ which is equal to the Pauli-$Z$ operator on the first qubit, as well as an $n$-qubit state $rho$ (for $n > 1$) where an eigenvector $| phi.alt chevron.r$ of $rho$ has an eigenvalue that is larger than all the other eigenvalues by a constant. We consider algorithms which learn about $rho$ through conventional or quantum-enhanced experiments. Then we have the following bounds:

- #emph[Upper bound:] There is an algorithm in the #strong[quantum-enhanced] scenario using only $cal(O) ( 1 )$ copies of $rho$ to predict $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 )$ up to $0.25$ error with probability at least $0.8$.

- #emph[Lower bound:] Any algorithm in the #strong[conventional] scenario needs at least $Omega ( 2^(n / 2) )$ copies of $rho$ to predict $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 )$ up to $0.25$ error with probability at least $0.8$.


] <thm:qPCA-near>


== An exponential lower bound for conventional experiments
<sec:conv-exp-LB-pca>


The lower bound proofs for both @thm:qPCA and @thm:qPCA-near are essentially the same. We first reduce quantum PCA (or near-term analogs thereof) to a many-versus-many distinguishing task. Then we bound the total variation distance to arrive at the exponential lower bound.


=== Reduction to many-versus-many distinguishing task
<reduction-to-many-versus-many-distinguishing-task>


We begin by considering a many-versus-many distinguishing task, as discussed in @sec:many-vs-many. The two hypotheses are given below.


- Hypothesis A: The unknown $n$-qubit state $rho$ is given by $rho_A ( | psi chevron.r ) = 1 / 2 | 0 chevron.r chevron.l 0 | ⊗ | psi chevron.r chevron.l psi | + 1 / 2 | 1 chevron.r chevron.l 1 | ⊗ I / 2^(n - 1) ,$ where $| psi chevron.r$ is an fixed $( n - 1 )$-qubit pure state, sampled at the outset from the Haar measure.

- Hypothesis B: The unknown $n$-qubit state $rho$ is given by $rho_B ( | psi chevron.r ) = 1 / 2 | 1 chevron.r chevron.l 1 | ⊗ | psi chevron.r chevron.l psi | + 1 / 2 | 0 chevron.r chevron.l 0 | ⊗ I / 2^(n - 1) ,$ where $| psi chevron.r$ is again a fixed $( n - 1 )$-qubit pure state, sampled at the outset from the Haar measure.


It is not hard to see that in hypothesis A, the principal component (largest eigenvector) is $| phi.alt chevron.r = | 0 chevron.r ⊗ | psi chevron.r$. On the other hand, in hypothesis B, the principal component (largest eigenvector) is $| phi.alt chevron.r = | 1 chevron.r ⊗ | psi chevron.r$. Hence, $chevron.l phi.alt | Z_1 | phi.alt chevron.r = 1$ in hypothesis A, but $chevron.l phi.alt | Z_1 | phi.alt chevron.r = - 1$ in hypothesis B. If an algorithm in the conventional scenario can predict $chevron.l psi | Z_1 | psi chevron.r$ up to $0.25$ error with probability at least $0.8$, then we can use the output from the algorithm to distinguish between hypotheses A and B with a success probability of at least $0.8$.


Similarly, we have $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 ) = ( 2^(n - 1) - 1 ) / ( 2^(n - 1) + 1 )$ in hypothesis A and $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 ) = - ( 2^(n - 1) - 1 ) / ( 2^(n - 1) + 1 )$ in hypothesis B. If an algorithm in the conventional scenario can predict $"tr" ( Z_1 rho^2 ) / "tr" ( rho^2 )$ up to $0.25$ error with probability at least $0.8$, then we can use the output from the algorithm to distinguish between hypothesis A and B with a success probability of at least $0.8$.


Together, a lower bound for distinguishing hypotheses A and B using conventional experiments immediately implies a lower bound for both @thm:qPCA and @thm:qPCA-near.


=== Total variation distance
<total-variation-distance>


As in previous sections, let $p_rho ( ell )$ denote the probability to arrive at the leaf node $ell$ using the learning algorithm in the conventional setting when the unknown state is $rho$. If the algorithm can distinguish between hypotheses A and B with success probability $0.8$, then using @eq:TVbound-many-vs-many we have


$ upright("TV") ("𝔼"_(| psi chevron.r) p_(rho_A ( | psi chevron.r )) , "𝔼"_(| psi chevron.r) p_(rho_B ( | psi chevron.r ))) gt.eq 0.6 . $


From the triangle inequality, we have


$ upright("TV") ("𝔼"_(| psi chevron.r) p_(rho_A ( | psi chevron.r )) , p_(I / 2^n)) + upright("TV") ("𝔼"_(| psi chevron.r) p_(rho_B ( | psi chevron.r )) , p_(I / 2^n)) gt.eq 0.6 . $
<eq:TVTV0.6>


For each leaf node $ell$, we consider the path from the root to $ell$,


$ u_0 = r arrow.r^(s_1) u_1 arrow.r^(s_2) u_2 arrow.r^(s_3) dots.h arrow.r^(s_(T - 1)) u_(T - 1) arrow.r^(s_T) u_T = ell . $


At each node $u$, we perform a POVM measurement ${ w_s^u | phi.alt_s^u chevron.r chevron.l phi.alt_s^u | }_s$ on $rho$ to obtain an outcome $s$ with probability


$ w_s^u chevron.l phi.alt_s^u | rho | phi.alt_s^u chevron.r . $


Hence, we can write down the probability to arrive at the leaf $ell$ as


$ p_rho ( ell ) = product_(t = 1)^T w_(s_t)^(u_(t - 1)) chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho | phi.alt_(s_t)^(u_(t - 1)) chevron.r . $


We will use $rho ( | psi chevron.r )$ to denote either $rho_A ( | psi chevron.r )$ or $rho_B ( | psi chevron.r )$. Then recalling @eq:tv_fdiv, we have


$ upright("TV") ("𝔼"_(| psi chevron.r) p_(rho ( | psi chevron.r )) , p_(I / 2^n)) = sum_ell p_(I / 2^n) ( ell ) max (0 , thin thin 1 - "𝔼"_(| psi chevron.r) product_(t = 1)^T 2^n chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho ( | psi chevron.r ) | phi.alt_(s_t)^(u_(t - 1)) chevron.r) . $
<eq:TV-PCA>


=== Upper bound for total variation distance
<upper-bound-for-total-variation-distance>


The central quantity to control in our bound on the total variation distance is


$ "𝔼"_(| psi chevron.r) product_(t = 1)^T 2^n chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho ( | psi chevron.r ) | phi.alt_(s_t)^(u_(t - 1)) chevron.r . $


Without loss of generality, let us consider $rho ( | psi chevron.r ) = rho_A ( | psi chevron.r ) = 1 / 2 | 0 chevron.r chevron.l 0 | ⊗ | psi chevron.r chevron.l psi | + 1 / 2 | 1 chevron.r chevron.l 1 | ⊗ I / 2^(n - 1)$. Suppose each $| phi.alt_(s_t)^(u_(t - 1)) chevron.r$ takes the form


$ | phi.alt_(s_t)^(u_(t - 1)) chevron.r = alpha_(s_t)^(u_(t - 1)) | 0 chevron.r ⊗ | phi.alt_(s_t)^(u_(t - 1) , 0) chevron.r + beta_(s_t)^(u_(t - 1)) | 1 chevron.r ⊗ | phi.alt_(s_t)^(u_(t - 1) , 1) chevron.r , $


where $alpha_(s_t)^(u_(t - 1)) , beta_(s_t)^(u_(t - 1)) in bb(C)$ and $lr(|alpha_(s_t)^(u_(t - 1))|)^2 + lr(|beta_(s_t)^(u_(t - 1))|)^2 = 1$. Then we have


$ & "𝔼"_(| psi chevron.r) product_(t = 1)^T 2^n chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho ( | psi chevron.r ) | phi.alt_(s_t)^(u_(t - 1)) chevron.r \
 & = "𝔼"_(| psi chevron.r) product_(t = 1)^T (2^(n - 1) lr(|alpha_(s_t)^(u_(t - 1))|)^2 |chevron.l psi | phi.alt_(s_t)^(u_(t - 1) , 0) |⟩ |^2 + lr(|beta_(s_t)^(u_(t - 1))|)^2)\
 & = sum_(S subset.eq ( 1 , dots.h , T )) product_(t in.not S) lr(|beta_(s_t)^(u_(t - 1))|)^2 \["𝔼"_(| psi chevron.r) product_(t in S) 2^(n - 1) lr(|alpha_(s_t)^(u_(t - 1))|)^2 |chevron.l psi | phi.alt_(s_t)^(u_(t - 1) , 0) |⟩ |^2\] . $<eq:purity-testing>


We need to lower bound the above quantity in order to upper bound the total variation distance. In order to do so, we utilize the following lemma. The proof of the lemma is based on Haar integration. For readers unfamiliar with Haar integration, we would suggest skipping the proof of this lemma.


#thmbox("lemma", "Lemma (High moment bound for Haar-random state)")[


Consider any $m$-qubit pure states $| phi.alt_1 chevron.r , dots.h , | phi.alt_K chevron.r$ and an $m$-qubit pure state $| psi chevron.r$ sampled from the Haar measure, we have


$ & "𝔼"_(| psi chevron.r) product_(k = 1)^K |chevron.l psi | phi.alt_k |⟩ |^2 \
 & gt.eq frac(1, ( 2^m + K - 1 ) dots.h ( 2^m + 1 ) ( 2^m )) . $


]


#block[
#emph[Proof.] The Haar integration over states shows that~◻

]


$ & "𝔼"_(| psi chevron.r) | psi chevron.r chevron.l psi |^(⊗ K) \
 & = frac(1, ( 2^m + K - 1 ) dots.h ( 2^m + 1 ) ( 2^m )) sum_(pi in cal(S)_K) pi , $


where $cal(S)_K$ is the permutation group of $K$ items, and $pi$ is the permutation operator over the $K$ tensor-product space. From Lemma~5.12 in @chen2021exponential, we have


$ sum_(pi in cal(S)_K) "tr" (pi ⨂_(k = 1)^K | phi.alt_k chevron.r chevron.l phi.alt_k |) gt.eq 1 . $


Therefore, we find


$ & "𝔼"_(| psi chevron.r) product_(k = 1)^K |chevron.l psi | phi.alt_k |⟩ |^2 \
 & gt.eq frac(1, ( 2^m + K - 1 ) dots.h ( 2^m + 1 ) ( 2^m )) . $


This concludes the proof. ◻






We apply this lemma with


$ m equiv n - 1 , quad K equiv | S | , quad | phi.alt_k chevron.r equiv | phi.alt_(s_t)^(u_(t - 1) , 0) chevron.r $


to obtain the following lower bound,


$ & "𝔼"_(| psi chevron.r) product_(t in S) 2^(n - 1) lr(|alpha_(s_t)^(u_(t - 1))|)^2 |chevron.l psi | phi.alt_(s_t)^(u_(t - 1) , 0) |⟩ |^2 \
 & gt.eq product_(t in S) frac(lr(|alpha_(s_t)^(u_(t - 1))|)^2, ( 1 + frac(| S | - 1, 2^(n - 1)) ) dots.h ( 1 + 1 / 2^(n - 1) ) ( 1 ))\
 & gt.eq product_(t in S) lr(|alpha_(s_t)^(u_(t - 1))|)^2 / (1 + frac(| S | - 1, 2^(n - 1)))^(| S | - 1)\
 & gt.eq (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) product_(t in S) lr(|alpha_(s_t)^(u_(t - 1))|)^2 . $


Combining with @eq:purity-testing, we have


$ & "𝔼"_(| psi chevron.r) product_(t = 1)^T 2^n chevron.l phi.alt_(s_t)^(u_(t - 1)) | rho ( | psi chevron.r ) | phi.alt_(s_t)^(u_(t - 1)) chevron.r \
 & gt.eq (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) \
 & quad times sum_(S subset.eq ( 1 , dots.h , T )) product_(t in.not S) lr(|beta_(s_t)^(u_(t - 1))|)^2 product_(t in S) lr(|alpha_(s_t)^(u_(t - 1))|)^2\
 & = (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) product_(t = 1)^T (lr(|beta_(s_t)^(u_(t - 1))|)^2 + lr(|alpha_(s_t)^(u_(t - 1))|)^2)\
 & = (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) . $


Next we leverage @eq:TV-PCA to obtain


$ & upright("TV") ("𝔼"_(| psi chevron.r) p_(rho ( | psi chevron.r )) , p_(I / 2^n)) \
 & quad lt.eq sum_ell p_(I / 2^n) ( ell ) max (0 , thin thin 1 - (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )))\
 & quad = 1 - (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) . $


The second line follows from $sum_ell p_(I / 2^n) ( ell ) = 1$ because $p_(I / 2^n) ( ell )$ is a probability distribution.


=== Lower bound for the number of measurements
<lower-bound-for-the-number-of-measurements>


We can now utilize the lower bound on the total variation distance given in @eq:TVTV0.6 and the upper bound obtained above to find


$ & 2 (1 - (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 ))) \
 & gt.eq upright("TV") ("𝔼"_(| psi chevron.r) p_(rho_A ( | psi chevron.r )) , p_(I / 2^n)) \
 & quad + upright("TV") ("𝔼"_(| psi chevron.r) p_(rho_B ( | psi chevron.r )) , p_(I / 2^n)) gt.eq 0.6 . $
<E:usefulTVboundQPCA1>


Hence, we have the inequality


$  & 0.7 gt.eq (1 + frac(T - 1, 2^(n - 1)))^(- ( T - 1 )) ,\
 & arrow.r.double.long ( T - 1 ) log (1 + frac(T - 1, 2^(n - 1))) gt.eq log ( 10 / 7 ) . $


Because $log ( 1 + x ) lt.eq x$ for all $x > - 1$, we have


$ & ( T - 1 )^2 gt.eq 2^(n - 1) log ( 10 / 7 ) \
 & arrow.r.double.long T gt.eq 1 + sqrt(frac(log (10 / 7), 2)) thin 2^(n / 2) . $


Finally, we have established the lower bound $T = Omega ( 2^(n / 2) )$ stated in @thm:qPCA.


== An exponential lower bound using pseudorandomness
<sec:pseudo>


In our exponential lower bound in the previous subsection, we relied on a state that was in part constructed using a Haar-random $( n - 1 )$-qubit state $| psi chevron.r$. However, preparing a Haar-random state from a simple initial state (say, a product state) requires circuit depth exponential in $n$. As such, we can not prepare Haar-random states in practice. Accordingly we cannot prepare either $rho_A ( | psi chevron.r )$ or $rho_B ( | psi chevron.r )$ in realistic circumstances.


However, we could instead efficiently construct pseudorandom states $| psi chevron.r$ which are (very plausibly) indistinguishable from Haar-random states if we probe with any POVM instantiated by a $upright("poly") ( n )$-time quantum algorithm~@ji2018pseudorandom. We will elaborate on this shortly. The parenthetical caveat 'very plausibly' is due to the fact that the construction we use relies on cryptographic assumptions which are not proven, but are widely believed. In particular, we need to suppose the existence of quantum-secure one-way functions~@ji2018pseudorandom\; these are functions which are efficient to evaluate but are hard to invert even with a quantum computer. Making such an assumption is standard practice in computational complexity theory, and so we proceed apace.


Let us recall the definition of a pseudorandom quantum state:


#thmbox("definition", "Definition (Pseudorandom quantum states; paraphrased from Definition 3 of~@ji2018pseudorandom)")[


Given a set $cal(K)$, a family of pseudorandom quantum states on $n$ qubits is a family of states $\{ |phi.alt_k chevron.r \}_(k in cal(K))$ and a probability distribution $cal(D)$ over $cal(K)$ such that:

- There is a $"poly"(n)$-time quantum algorithm that samples a single element $k$ from $cal(K)$ according to $cal(D)$ and generates the corresponding state $|phi.alt_k chevron.r$;

- For any polynomial $t(n)$ and any $"poly"(n)$-time quantum algorithm $cal(A)$ with outputs in $\{0, 1\}$, we have

  $ & | "Pr"_(k arrow.l cal(K)) \[cal(A)(|phi.alt_k chevron.r^(⊗ t(n))) = 1\] \
    & quad - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(|psi chevron.r^(⊗ t(n))) = 1\] | lt.eq "negl"(n) . $ <E:compindist1>

  Here $"negl"(n)$ is a function such that for all constants $c > 0$ we have $"negl"(n) < n^(-c)$ for $n$ sufficiently large.

] <def:pseudostates>


We can interpret the above definition as follows. @E:compindist1 says that if we are given a polynomial $t ( n )$ number of copies of either (i) a fixed pseudorandom state, or (ii) a fixed Haar random state, any polynomial time quantum algorithm with binary outputs cannot distinguish between the two cases. Since an exponential depth quantum algorithm can distinguish between the two cases,~@E:compindist1 describes a notion of #emph[computational indistinguishability], i.e.~we cannot distinguish with polynomial time computational resources.


A key question is: do pseudorandom quantum states exist? We recall the following, contingent result.


#thmbox("lemma", "Lemma (Existence of pseudorandom quantum states~@ji2018pseudorandom)")[ If there exist quantum-secure one-way functions, then they can be used to construct pseudorandom quantum states.


]


Explicit details of the construction can be found in~@ji2018pseudorandom\; there have also been refinements and generalizations in follow-up work (see e.g.~@brakerski2019pseudo @brakerski2020scalable).


Before stating the main result of this section, we require the following definition:


#thmbox("definition", "Definition (Polynomial-time algorithms in the conventional scenario)")[


A polynomial-time algorithm $cal(A)$ in the conventional scenario is constructed as follows. We consider a learning tree $cal(T)$ in the #strong[conventional scenario] with leaves $ell$, and require that the protocol described by the learning tree can be implemented by an at most $"poly"(n)$-time quantum algorithm. (As such, the depth of $cal(T)$ is at most polynomial in $n$.) Then let $cal(D)$ be a $"poly"(n)$-time classical algorithm which, given the transcript of measurements encoded into the leaves $ell$ of $cal(T)$, provides a binary output $0$ or $1$. We let $cal(A)$ be a map from $n$-qubit density matrices $rho$ to $( 0 , 1 )$, corresponding to instantiating the learning tree $cal(T)$ on copies of $rho$, followed by using $cal(D)$ on the measurement transcript to determine a binary outcome.


]


We can now leverage the putative pseudorandom states and the above definition to establish the following result:


#thmbox("theorem", "Theorem (Lower bound many-versus-many distinguishing task using pseudorandom states)")[

Let $\{ |phi.alt_k chevron.r \}_(k in cal(K))$ be a family of pseudorandom states on $n - 1$ qubits. Then any polynomial-time algorithm $cal(A)$ in the #strong[conventional] scenario with binary output cannot distinguish $rho_A ( |phi.alt_k chevron.r )$ from $rho_B ( |phi.alt_k chevron.r )$ for $k$ sampled from the probability distribution over $cal(K)$. That is:

$ & | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_A(|phi.alt_k chevron.r)) = 1\] \
  & quad - "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_B(|phi.alt_k chevron.r)) = 1\] | lt.eq "negl"(n) . $ <E:compindist2>

] <thm:compindist2>

#block[
#emph[Proof.] Using the triangle inequality several times we have

$ & | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_A(|phi.alt_k chevron.r)) = 1\] - "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_B(|phi.alt_k chevron.r)) = 1\] | \
  & quad quad quad quad lt.eq | "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_A(|psi chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_B(|psi chevron.r)) = 1\] | \
  & quad quad quad quad quad + | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_A(|phi.alt_k chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_A(|psi chevron.r)) = 1\] | \
  & quad quad quad quad quad + | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_B(|phi.alt_k chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_B(|psi chevron.r)) = 1\] | . $ <E:pseudotriangle1>

Let $cal(T)$ be the learning tree corresponding to $cal(A)$, and let $cal(D)$ be the binary decision function mapping leaves of $cal(T)$ to $\{0, 1\}$. The depth $T$ of $cal(T)$ is necessarily at most polynomial in $n$; let us denote the depth by $T(n)$. Then the first term on the right-hand side of~@E:pseudotriangle1 is upper bounded by

$ & | "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_A(|psi chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_B(|psi chevron.r)) = 1\] | \
  &= | sum_(ell in "leaf"(cal(T)) : cal(D)(ell) = 1) (bb(E)_(|psi chevron.r) p_(rho_A(|psi chevron.r))(ell) - bb(E)_(|psi chevron.r) p_(rho_B(|psi chevron.r))(ell)) | \
  & lt.eq sum_(ell in "leaf"(cal(T))) | bb(E)_(|psi chevron.r) p_(rho_A(|psi chevron.r))(ell) - bb(E)_(|psi chevron.r) p_(rho_B(|psi chevron.r))(ell) | \
  & lt.eq 2 upright("TV") (bb(E)_(|psi chevron.r) p_(rho_A(|psi chevron.r)), p_(I \/ 2^n)) + 2 upright("TV") (bb(E)_(|psi chevron.r) p_(rho_B(|psi chevron.r)), p_(I \/ 2^n)) \
  & lt.eq 4 (1 - (1 + frac(T(n) - 1, 2^(n - 1)))^(-(T(n) - 1))) $ <E:firstpseudoterm>

where the last inequality comes from~@E:usefulTVboundQPCA1.

Next we turn to bounding the second term on the right-hand side of the inequality in~@E:pseudotriangle1, namely

$ | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_A(|phi.alt_k chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_A(|psi chevron.r)) = 1\] | . $

First, we observe that every $cal(A)$ takes in $T(n)$ copies of $rho_A$. Accordingly, there is a polynomial-time algorithm $tilde(cal(A))$ such that $tilde(cal(A)) ( rho_A^(⊗ T(n)) ) = cal(A) ( rho_A )$ for all inputs $rho_A$; this just amounts to a slightly different way of notating the domain of the algorithm $cal(A)$. Then we can rewrite our term of interest as

$ | "Pr"_(k arrow.l cal(K)) \[tilde(cal(A))(rho_A(|phi.alt_k chevron.r)^(⊗ T(n))) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[tilde(cal(A))(rho_A(|psi chevron.r)^(⊗ T(n))) = 1\] | . $ <E:pseudointermediate1>

But now observe that for any state $|omega chevron.r$, there is a polynomial-time quantum algorithm which takes $|omega chevron.r$ as input and produces $rho_A ( |omega chevron.r )$ as output. Accordingly, repeating this algorithm on $T(n)$ copies of $|omega chevron.r$, we produce $T(n)$ copies of $rho_A ( |omega chevron.r )$; let us denote this $T(n)$-copy algorithm by $cal(B)$. We have $cal(B) ( |omega chevron.r^(⊗ T(n)) ) = rho_A ( |omega chevron.r )^(⊗ T(n))$, where $cal(B)$ runs in polynomial time (recalling that $T(n)$ is polynomial in $n$). Then we can write~@E:pseudointermediate1 as

$ | "Pr"_(k arrow.l cal(K)) \[(tilde(cal(A)) compose cal(B))(|phi.alt_k chevron.r^(⊗ T(n))) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[(tilde(cal(A)) compose cal(B))(|psi chevron.r^(⊗ T(n))) = 1\] | . $ <E:pseudointermediate2>

Since $tilde(cal(A)) compose cal(B)$ is itself a polynomial-time quantum algorithm, @def:pseudostates tells us that~@E:pseudointermediate2 above is upper bounded by $"negl"(n)$. So in summary, we find

$ | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_A(|phi.alt_k chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_A(|psi chevron.r)) = 1\] | lt.eq "negl"(n) . $ <E:secondpseudoterm>

In an identical manner we can show that the third term on the right-hand side of~@E:pseudotriangle1 satisfies the bound

$ | "Pr"_(k arrow.l cal(K)) \[cal(A)(rho_B(|phi.alt_k chevron.r)) = 1\] - "Pr"_(|psi chevron.r arrow.l "Haar") \[cal(A)(rho_B(|psi chevron.r)) = 1\] | lt.eq "negl"(n) . $ <E:thirdpseudoterm>

Putting together the inequalities in~@E:pseudotriangle1,~@E:firstpseudoterm,~@E:secondpseudoterm and~@E:thirdpseudoterm, as well as observing that $T(n)$ is at most polynomially large in $n$, we achieve the desired bound. #h(1fr) $square$
]


The above Theorem immediately implies that the exponential advantage for quantum principal component analysis in @thm:qPCA has a counterpart for pseudorandom states. We note that in the pseudorandom context the advantage is not strictly exponential; rather, the advantage holds for arbitrary #emph[polynomial]-time quantum learning algorithms in the quantum-enhanced scenario versus in the conventional scenario.


= Learning a polynomial-time quantum process
<sec:evolution>


Here we consider the problem of learning a polynomial-time quantum process, and provide a rigorous exponential separation between the conventional and quantum-enhanced learning settings.


== Problem setting
<sec:learn-process-setting>


We consider an unknown quantum process $cal(E)$ on $n$ qubits generated as follows.

- An $n$-qubit state $sigma$ is accompanied by an $m$ ancillary qubits initialized at $| 0^n chevron.r chevron.l 0^n |$.

- $p$ unknown two-qubit unitary gates are applied on the $( n + m )$-qubit system $rho ⊗ | 0^n chevron.r chevron.l 0^n |$.

- The ancillary qubits are hidden, resulting in an $n$-qubit mixed state.

When $m , p = upright("poly") ( n )$, we refer to $cal(E)$ as a polynomial-time quantum process. Next, we consider an input probability distribution $cal(D)$ over $n$-qubit mixed states $sigma$. The goal is to learn an approximate model $tilde(cal(E))$ of $cal(E)$, such that we can accurately predict the output state on average:


$ "𝔼"_(sigma tilde cal(D)) ∥tilde(cal(E)) ( sigma ) - cal(E) ( sigma )∥_1 lt.eq epsilon.alt . $


In the above, $norm(X)_1 = "max"_(O: norm(O)_infinity lt.eq 1) |upright("tr")(O X)|$ is the trace norm.


== Rigorous statements
<sec:rigor-learn-process>


We have the following theorem for quantum-enhanced experiments showing that they can efficiently learn a polynomial-time quantum process. We will prove the theorem later in @sec:poly-proc.


#thmbox("theorem", "Theorem (Approximate learning of quantum processes -- polynomial upper bound)")[


For any distribution $cal(D)$ and any $epsilon.alt , delta > 0$, there exists a learning algorithm in the quantum-enhanced setting that can learn an approximate model $tilde(cal(E))$ such that with probability at least $1 - delta$,


$ "𝔼"_(sigma tilde cal(D)) ∥tilde(cal(E)) ( sigma ) - cal(E) ( sigma )∥_1 lt.eq epsilon.alt $
<eq:thm8>


from at most $tilde(cal(O)) ( upright("poly") ( n ) log ( 1 / delta ) / epsilon.alt^4 )$ accesses to $cal(E)$, where $tilde(cal(O)) ( dot.op )$ hides factors of $log ( 1 / epsilon.alt )$.


] <thm:poly-upp-learn-proc>


In contrast, our hardness results for predicting properties of physical states in the conventional setting (see @thm:obs-adv in @sec:expo-adv-abs-one) immediately implies the following exponential lower bound.


#thmbox("corollary", "Corollary (Approximate learning of quantum processes -- exponential lower bound)")[


Let $cal(D)$ be any distribution and $cal(E)$ be the quantum process that always generates a state $rho$ considered in Def.~@def:hardrhoO. Any algorithm in the conventional setting that learns an approximate model $tilde(cal(E))$ such that


$ "𝔼"_(sigma tilde cal(D)) ∥tilde(cal(E)) ( sigma ) - cal(E) ( sigma )∥_1 lt.eq 0.25 , $


must use at least $Omega ( 2^n )$ accesses to $cal(E)$.


] <cor:learn-proc-hard>


#block[
#emph[Proof.] We consider $m = 2 n$. The two-qubit gates swap the input state $sigma$ to the first $n$ ancillary qubits. Then we use the rest of the $n$ ancillary qubits and the $n$ system qubits (i.e.~the qubits in the input state $rho$) to prepare a state $rho$ considered in Def.~@def:hardrhoO. To prepare the maximally mixed state $I / 2^n$, we entangle each of the system qubits with the corresponding ancillary qubit to prepare a Bell state $1 / sqrt(2) ( | 00 chevron.r + | 11 chevron.r )$. To prepare the alternative state $( I + 0.9 s P ) / 2^n$, we perform the following procedure.

+ For qubit $i$, where $P_i$ is #emph[not] the last non-identity Pauli operator (i.e.~last in terms of having the largest index $i$), we entangle the $i$-th system qubit with the corresponding ancillary qubit to prepare a Bell state $1 / sqrt(2) ( | 00 chevron.r + | 11 chevron.r )$.

+ For the last remaining qubit $i$, which corresponds to the index $i$ such that $P_i$ is the last non-identity Pauli operator, we apply a sequence of two-qubit gates entangling qubit $i$ to qubit $j$ with $P_j eq.not I$. The sequence of two-qubit gates stores the parity (or $1 - upright("parity")$) of all qubits $j$ with $P_j eq.not I$. After this step, when we trace over the ancillary qubits, we have generated $( I + s P^(( Z )) ) / 2^n$, where $P^(( Z )) = ⨂_(i = 1)^n F ( P_i )$ and $F ( I ) = I , F ( X ) = Z , F ( Y ) = I , F ( Z ) = I$. Then, we rotate the corresponding ancillary qubit for qubit $i$ from $| 0 chevron.r$ to $sqrt(0.95) | 0 chevron.r + sqrt(0.05) | 1 chevron.r$ and apply a controlled-not gate from the ancillary qubit (control) to qubit $i$. The system qubits are now in the state $( I + 0.9 s P^(( Z )) ) / 2^n$.

+ Finally, for each qubit $i$ with $P_i = X$, we rotate the system qubit from $| 0 chevron.r$ to $| + chevron.r = 1 / sqrt(2) ( | 0 chevron.r + | 1 chevron.r )$ and from $| 1 chevron.r$ to $| - chevron.r = 1 / sqrt(2) ( | 0 chevron.r - | 1 chevron.r )$. For each qubit $i$ with $P_i = Y$, we rotate from $0$ to $y +$ and from $1$ to $y -$. Tracing over the ancillary qubits, the system qubits are now in the state $( I + 0.9 s P ) / 2^n$.

We can see that the number of gates $p$ is $cal(O) ( n )$. Furthermore, no matter what the input state $sigma$ is, the above quantum process always produces a state $rho$ considered in Def.~@def:hardrhoO.~◻

]


When an algorithm in the conventional setting has learned an approximate model $tilde(cal(E))$ with


$ "𝔼"_(sigma tilde cal(D)) ∥tilde(cal(E)) ( sigma ) - cal(E) ( sigma )∥_1 lt.eq 0.25 , $


we can use Jensen's inequality to conclude


$ ∥"𝔼"_(sigma tilde cal(D)) tilde(cal(E)) ( sigma ) - rho∥_1 lt.eq "𝔼"_(sigma tilde cal(D)) ∥tilde(cal(E)) ( sigma ) - cal(E) ( sigma )∥_1 lt.eq 0.25 . $


Because $norm(X)_1 = "max"_(O: norm(O)_infinity lt.eq 1) |upright("tr")(O X)|$, the above implies that the algorithm can predict $"tr" ( O rho )$ up to an error of $0.25$.


From @thm:obs-adv, we conclude that the learning algorithm must use at least $Omega ( 2^n )$ copies of $rho$, which corresponds to $Omega ( 2^n )$ accesses to $cal(E)$. ◻






== Proof of polynomial upper bound in @thm:poly-upp-learn-proc
<sec:poly-proc>


// [figvision-cn] imgs/Phys_process.png
// 该图由左右两个部分构成，通过一个指向右侧的深灰色箭头连
// 接，展示了一个从构建覆盖网到进行量子假设选择的流程。
// 左侧部分为一个示意图。主体是一个由粗黑线勾勒的不规则云
// 朵状轮廓，代表所有多项式时间量子过程的空间。在该轮廓内
// 部及边缘分布着若干半透明的浅蓝色圆形区域，这些圆形相互
// 重叠，形成一种网状结构。在这些圆形区域内以及云朵轮廓内
// 散布着若干个实心深蓝色圆点。图的左上角有一个图例，显示
// 一个深蓝色圆点对应文字“A physical process”（一个物理过
// 程）。在云朵轮廓下方，有四条细长的深灰色直线从云朵内部
// 的不同位置引出，汇聚于底部并指向文字标签“Covering net”
// （覆盖网），表明图中的深蓝色圆点构成了覆盖网。 右侧部
// 分标题为“Quantum hypothesis selection using
// quantum-enhanced experiments”（使用量子增强实验进行量
// 子假设选择）。该部分背景为浅灰色矩形框。框内同样分布着
// 若干与左侧样式相同的深蓝色圆点，排列较为稀疏。在矩形框
// 的中心位置有一个巨大的深蓝色问号符号“?”。在右侧部分的
// 右下角，绘制了一个小型的紫色机器人图标，其头部中央有原
// 子轨道图案。机器人旁边是一个水平放置的圆角矩形框，背景
// 色为深蓝至紫色的渐变色。框内包含两行数学表达式，第一行
// 为重复出现的符号“E(ρ1)”，第二行为重复出现的符号“E(ρ2)”，
// 每行末尾均有省略号表示序列延续。这代表存储在量子记忆中
// 的量子数据集，其中ρ1和ρ2可能代表不同的量子态，E代表演
// 化或测量算符。整个图像传达了利用预先构建的覆盖网（左侧）
// 来逼近任意物理过程，并通过量子增强的实验数据（右侧底部）
// 在候选集合中筛选出最接近真实过程的假设（右侧问号处）的
// 逻辑。
#figure(image("imgs/Phys_process.png", width: 75.0%),
  caption: [
    #emph[Illustration for the proof of @thm:poly-upp-learn-proc on learning polynomial-time quantum processes.] We first form a covering net (all dark blue dots) for the space of all polynomial-time quantum processes (the cloud shape). Any polynomial-time quantum process is close to an element in the covering net. Then we perform quantum hypothesis selection @buadescu2020improved using a quantum dataset stored in the quantum memory to find the approximate physical process.
  ]
)
<fig:learn-process>



@thm:poly-upp-learn-proc establishes an upper bound on the number of times we must access the unknown process $cal(E)$ in the quantum-enhanced setting to construct an approximate model of $cal(E)$. Note that the theorem only concerns the number of times we run the process $cal(E)$\; it does not address the computational complexity of the learning procedure. Our strategy for proving the theorem is as follows. First we find an upper bound on the number of elements of an $epsilon.alt'$-covering net for the set of all quantum processes that can be constructed using up to $p$ two-qubit quantum gates, with distance defined by the diamond norm. Next we explain how to use a quantum hypothesis testing algorithm to find a process $cal(tilde(E))$ in the covering net that approximates $cal(E)$ as specified in (@eq:thm8), if $epsilon.alt'$ is appropriately chosen. This quantum hypothesis testing method can be carried out in the quantum-enhanced setting, but not in the conventional setting. The number of times we must access $cal(E)$ depends on the size of the covering net, and can be shown to scale polynomially with the number of gates $p$, proving the theorem. An illustration is given in Supp.~@fig:learn-process.


=== Covering net
<covering-net>


First, we construct the covering net for the set $cal(S)$ of quantum processes with a fixed $n , m , p$. An $epsilon.alt$-covering net of a set $cal(S)$ is a subset $cal(N)_epsilon.alt subset.eq cal(S)$ such that for every point $x in cal(S)$, there exists a point $y in cal(N)$ with $ ‖x - y‖ lt.eq epsilon $ in an appropriate norm.


Recall that a unitary $U$ corresponds to a unitary channel $cal(U)$ defined as


$ cal(U) ( rho ) = U rho U^dagger . $


Because two-qubit unitary channels form a bounded set in a finite-dimensional space, the $tilde(epsilon.alt)$-covering net for two-qubit unitary channels has a size of at most


$ (c_1 / tilde(epsilon.alt))^(c_2) , $
<eq:twoqubit>


where $c_1 , c_2$ are two constants (see, e.g., Section $4.2$ in @vershynin2018highdimensional). Here, we consider the norm to be the diamond norm $∥dot.op∥_diamond.stroked.small$ (see Section~3.3 in @watrous2018book). The bound in @eq:twoqubit only pertains to the covering net size when the unitary acts on a #emph[fixed] set of two qubits. Let us now consider two-qubit unitary channels that can act on any two of the $n + m$ qubits. Because there are $binom(n + m, 2)$ pairs of qubits that the unitary could act on, the size of the $tilde(epsilon.alt)$-covering net $cal(N)_(tilde(epsilon.alt) , n + m)$ of all two-qubit gates on an $( n + m )$-qubit system is upper bounded as follows,


$ lr(|cal(N)_(tilde(epsilon.alt) , n + m)|) lt.eq binom(n + m, 2) (c_1 / tilde(epsilon.alt))^(c_2) . $


To construct an $epsilon.alt$-covering net for the composed quantum process $cal(E)$, we need to consider $tilde(epsilon.alt) = epsilon.alt' / p$ in $cal(N)_(tilde(epsilon.alt) , n + m)$. Consider any sequence of two-qubit unitary channels $cal(U)_1 , dots.h , cal(U)_p$ on an $( n + m )$-qubit system. For each $U_i$ in the sequence, we find the closest unitary channel $tilde(cal(U))_i$ in $cal(N)_(tilde(epsilon.alt) , n + m)$, hence $∥cal(U)_i - tilde(cal(U))_i∥_diamond.stroked.small lt.eq tilde(epsilon.alt)$. Then we can use a telescoping sum and the triangle inequality to see that


$  & ∥"tr"_(n + 1 , dots.h , n + m) (cal(U)_p dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )) - "tr"_(n + 1 , dots.h , n + m) (tilde(cal(U))_p dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ))∥_1\
 & lt.eq ∥cal(U)_p dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ) - tilde(cal(U))_p dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )∥_1\
 & lt.eq ∥cal(U)_p dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ) - cal(U)_p tilde(cal(U))_(p - 1) dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )∥_1\
 & #h(2em) + ∥cal(U)_p tilde(cal(U))_(p - 1) dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ) - tilde(cal(U))_p tilde(cal(U))_(p - 1) dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )∥_1\
 & lt.eq ∥cal(U)_(p - 1) dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ) - tilde(cal(U))_(p - 1) dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )∥_1 + ∥cal(U)_p - tilde(cal(U))_p∥_diamond.stroked.small\
 & lt.eq ∥cal(U)_(p - 2) dots.h cal(U)_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | ) - tilde(cal(U))_(p - 2) dots.h tilde(cal(U))_1 ( rho ⊗ | 0^m chevron.r chevron.l 0^m | )∥_1 + ∥cal(U)_(p - 1) - tilde(cal(U))_(p - 1)∥_diamond.stroked.small + ∥cal(U)_p - tilde(cal(U))_p∥_diamond.stroked.small\
 & lt.eq dots.h\
 & lt.eq sum_(i = 1)^p ∥cal(U)_i - tilde(cal(U))_i∥_diamond.stroked.small\
 & lt.eq p tilde(epsilon.alt) = epsilon.alt' . $


The first inequality uses the fact that taking partial trace does not increase the trace norm. The second inequality uses $norm(A - B) lt.eq norm(A - C) + norm(C - B)$. The third inequality uses $norm(cal(E)(X))_1 lt.eq norm(X)_1$ for any CPTP map $cal(E)$, and $∥cal(E) ( rho )∥_1 lt.eq ∥cal(E)∥_diamond.stroked.small ∥rho∥_1 = ∥cal(E)∥_diamond.stroked.small$. The fourth inequality considers the same steps taken in the second and third inequality. Then, using induction, we obtain the formula given in the second-to-last line. The last line uses the fact that $∥cal(U)_i - tilde(cal(U))_i∥_diamond.stroked.small lt.eq tilde(epsilon.alt)$ for all $i$ and $tilde(epsilon.alt) = epsilon.alt' / p$.


From the above analysis, we can see that we can find an $epsilon.alt'$-covering net $cal(N)_(epsilon.alt' , n , m , p)$ for the space of $cal(E)$ with an $n$-qubit input state, $m$ ancillary qubits, and $p$ two-qubit gates that satisfies


$ lr(|cal(N)_(epsilon.alt' , n , m , p)|) lt.eq \[binom(n + m, 2) (frac(p c_1, epsilon.alt'))^(c_2)\]^p . $
<eq:Neps-sizeupp>


For any $cal(E)$ in the space, we can find an $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ such that for all $n$-qubit input states $rho$ we have


$ ∥cal(E) ( rho ) - tilde(cal(E)) ( rho )∥_1 lt.eq epsilon.alt' . $


We will then utilize the $epsilon.alt$-covering net $cal(N)_(epsilon.alt' , n , m , p)$ in the subsequent proof. An $epsilon.alt$-covering net of quantum processes have also been used in @huang2021information to establish an information-theoretic bound on quantum advantage in @caro2021generalization to analyze generalization performance of quantum neural networks.





=== Learning via Hypothesis Selection: Protocol and Analysis
<learning-via-hypothesis-selection-protocol-and-analysis>


We will sample $"Nin"$ input states $rho_1,dots.h,rho_("Nin")$ from the distribution $cal(D)$. For each $i in \["Nin"\]$ and every $tilde(cal(E))_k in cal(N)_(epsilon.alt' , n , m , p)$ (for $epsilon.alt'$ to be tuned later), we will access the true process $cal(E)$ a number of times $"Nout"$ using $rho_i$ as the input state, obtaining $"Nout"$ copies of $cal(E) ( rho_i )$. We will store these $"Nin"dot.op"Nout"$ states in the quantum memory and run a known algorithm for #emph[quantum hypothesis selection] @buadescu2020improved to determine for which $k$ the product state $⨂^("Nin")_(i = 1)tilde(cal(E))_k(rho_i)$ is approximately closest to $⨂^("Nin")_(i=1)cal(E)(rho_i)$. We will argue that if $epsilon.alt'$ is sufficiently small and $"Nin"$ sufficiently large, then the index $k$ that we find will satisfy


$ "𝔼"_(rho tilde cal(D)) \[∥cal(E) ( rho ) - tilde(cal(E))_k ( rho )∥_1\] lt.eq epsilon.alt thin , $
<eq:desired>


as desired.


We now proceed to the analysis of this protocol. We begin with an estimate for the distance between product states whose components are pairwise far from each other.


#thmbox("lemma", "Lemma")[


If $rho_1 , dots.h , rho_N$ and $rho'_1 , dots.h , rho'_N$ satisfy $1 / N sum_(i = 1)^N ∥rho_i - rho'_i∥_1 gt.eq epsilon.alt$, then


$ ∥⨂_i rho_i - ⨂_i rho'_i∥_1 gt.eq 2 (1 - ( 1 - epsilon.alt^2 / 4 )^(N / 2)) . $


] <lem:tensordiff>


#block[
#emph[Proof.] For convenience, denote $epsilon.alt_i := ∥rho_i - rho'_i∥_1$. We have that $F ( rho_i , rho'_i ) lt.eq 1 - epsilon.alt_i^2 / 4$, so~◻

]


$ ∥⨂_i rho_i - ⨂_i rho'_i∥_1 & gt.eq 2 (1 - sqrt(F (⨂_i rho_i , ⨂_i rho'_i)))\
 & gt.eq 2 (1 - sqrt(product_(i = 1)^N ( 1 - epsilon.alt_i^2 / 4 )))\
 & gt.eq 2 (1 - (1 / N sum_i ( 1 - epsilon.alt_i^2 / 4 ))^(N / 2))\
 & = 2 (1 - ( 1 - epsilon.alt^2 / 4 )^(N / 2)) $


where the first step follows by the standard inequality $∥rho - rho'∥_1 gt.eq 2 sqrt(1 - F ( rho , rho' ))$ , the second step follows by tensorization of fidelity, the third step follows by AM-GM and the fact that $epsilon.alt_i = ∥rho_i - rho'_i∥_1 lt.eq 2$, and the last step follows from the assumption. ◻






Next, we elaborate on how to select $"Nin"$. Consider any $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$. By Hoeffding's inequality, because $rho_1,dots.h,rho_("Nin")$ are sampled independently and identically distribued from the distribution $cal(D)$, and $∥rho - rho'∥ lt.eq 2$ for all density matrices $rho , rho'$ we have


$ lr(|1 / N_(upright("in")) sum_(i = 1)^(N_(upright("in"))) ∥tilde(cal(E)) ( rho_i ) - cal(E) ( rho_i )∥_1 - "𝔼"_(rho tilde cal(D)) ∥tilde(cal(E)) ( rho ) - cal(E) ( rho )∥_1|) lt.eq epsilon.alt / 2 $
<eq:conc>


with probability at least $1 - delta'$ provided $"Nin" = Omega("log"(1 / delta\') / epsilon^2 )$. By a union bound over $cal(N)_(epsilon.alt' , n , m , p)$, the above bound holds simultaneously for all $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ with probability at least $1 - | cal(N)_(epsilon.alt' , n , m , p) | delta'$. Henceforth, we condition on this event holding.


The following shows that it suffices to find $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ for which the product state $⨂_(i=1)^("Nin") tilde(cal(E))(rho_i)$ is sufficiently close to $⨂_(i = 1)^(N_(upright("in"))) cal(E) ( rho_i )$.


#thmbox("lemma", "Lemma")[


If @eq:conc holds for all $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$, then if


$ norm(⨂_(i=1)^"Nin" tilde(cal(E))(rho_i) - ⨂_(i=1)^(N_"in") cal(E)(rho_i))_1 lt.eq 2 (1 - (1 - epsilon^2 / 16)^("Nin" / 2)) $ <eq:suffice>


for some $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$, we have that $"𝔼"_(rho tilde cal(D)) ∥tilde(cal(E)) ( rho ) - cal(E) ( rho )∥_1 lt.eq epsilon.alt$.


] <lem:suffice>


#block[
#emph[Proof.] We prove the contrapositive. Suppose $"𝔼"_(rho tilde cal(D)) ∥tilde(cal(E)) ( rho ) - cal(E) ( rho )∥_1 > epsilon.alt$. Then by @eq:conc, we have~◻

]


$ 1 / N_(upright("in")) sum_(i = 1)^(N_(upright("in"))) ∥tilde(cal(E)) ( rho_i ) - cal(E) ( rho_i )∥_1 gt.eq epsilon.alt / 2 . $


The lemma follows from @lem:tensordiff. ◻






As we show in the next lemma, there exists an $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$, namely the process in the covering net which is closest to $cal(E)$, for which @eq:suffice holds, provided $epsilon.alt'$ is sufficiently small.


#thmbox("lemma", "Lemma")[


For any $epsilon.alt' > 0$, there exists an $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ for which


$ norm(⨂_(i=1)^"Nin" tilde(cal(E))(rho_i) - ⨂_(i=1)^(N_"in") cal(E)(rho_i))_1 lt.eq "Nin" epsilon.alt\' . $


] <lem:existsgood>


#block[
#emph[Proof.] Take $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ satisfying $∥tilde(cal(E)) ( rho ) - cal(E) ( rho )∥_1 lt.eq epsilon.alt'$ for all $rho$. For convenience, let $sigma_i := cal(E) ( rho_i )$, $sigma'_i := tilde(cal(E)) ( rho_i )$, and $delta_i := sigma'_i - sigma_i$ for all $i in \(1, dots.h, "Nin"\)$. Then~◻

]


$ ⨂_(i=1)^"Nin" sigma\'_i - ⨂_(i=1)^"Nin" sigma_i = sum_(i=1)^"Nin" \[ (⨂_(j=1)^(i-1) sigma\'_j) ⊗ (sigma\'_i - sigma_i) ⊗ (⨂_(j=i+1)^"Nin" sigma_j) \] , $


so by the triangle inequality we conclude that $ lr(‖⨂_i sigma'_i - ⨂_i sigma_i‖)_1 lt.eq N_("in") epsilon' $ as claimed. ◻






@lem:suffice and @lem:existsgood guarantee the existence of a process in $cal(N)_(epsilon.alt' , n , m , p)$ satisfying the desired bound of @eq:desired. To complete the proof of @thm:poly-upp-learn-proc, we will use the following special case of a result from @buadescu2020improved to find a process in the covering net which performs comparably.


#thmbox("theorem", "Theorem (@buadescu2020improved, Theorem 1.5)")[


Suppose we are given $m$ fixed hypothesis states $sigma_1 , dots.h , sigma_M in bb(C)^(d times d)$, parameters $0 < epsilon.alt , delta < 1 / 2$, and access to copies of a state $rho in bb(C)^(d times d)$. Then there is an algorithm that uses


$ N = cal(O) (1 / epsilon.alt^2 (log^3 M + alpha log M) dot.op alpha) $


copies of $rho$ for $alpha := log ( log ( 1 / eta ) / delta )$ and $eta := min_i ∥rho - sigma_i∥_1$ such that with probability at least $1 - delta$ the algorithm outputs a $k in ( 1 , dots.h , M )$ for which $∥rho - sigma_k∥_1 lt.eq 4 eta$.


] <thm:data_analysis>


We can now put together the ingredients assembled in this section to complete the proof of @thm:poly-upp-learn-proc.


#block[
#emph[Proof of @thm:poly-upp-learn-proc.] We first prove the theorem for constant $delta$. Take $epsilon\' = c/"Nin"$ for a sufficiently small constant $c > 0$, $delta' = 1 / ( 10 | cal(N)_(epsilon.alt' , n , m , p) | )$, and $"Nin" = tilde(cal(O))(p/epsilon^2)$, where $tilde(cal(O)) ( dot.op )$ hides factors of $log n , log m , log p , log 1 / epsilon.alt$, so that $"Nin" gt.eq Omega("log"(1/delta\')/epsilon^2)$ and @eq:conc holds for all $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ with probability at least $4 / 5$. Note that for some absolute constant $C > 0$,~◻

]


$ 1 - (1 - epsilon^2 / 16)^("Nin" / 2) gt.eq 1 - e^(-"Nin" epsilon^2 / 32) = 1 - (delta\')^C gt.eq Omega(1) . $ <eq:big>


In contrast, by @lem:existsgood and our choice of $epsilon.alt'$, there exists some $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ for which


$ norm(⨂_(i=1)^"Nin" tilde(cal(E))(rho_i) - ⨂_(i=1)^(N_"in") cal(E)(rho_i))_1 lt.eq c . $ <eq:small>


Applying @thm:data_analysis to $sigma_k = ⨂_i tilde(cal(E))_k ( rho_i )$ where $tilde(cal(E))_k$ is the $k$-th element of $cal(N)_(epsilon.alt' , n , m , p)$, using $"Nout"$ copies of $rho = ⨂_i cal(E) ( rho_i )$ where


$ "Nout" = cal(O) (1 / epsilon^2 (log^3 |cal(N)_(epsilon.alt\', n , m , p)| + alpha log |cal(N)_(epsilon.alt\', n , m , p)|) dot.op alpha) , quad quad alpha := cal(O)(log log(1/c)) , $ <eq:Ndef>


we can output a $k$ for which $∥sigma_k - rho∥_1 lt.eq 4 c$ with probability $4 / 5$. By taking the constant $c$ sufficiently small, we can leverage @eq:big and @lem:suffice to conclude that


$ "𝔼"_(rho tilde cal(D)) \[∥cal(E) ( rho ) - tilde(cal(E))_k ( rho )∥_1\] lt.eq epsilon.alt thin . $


Note that $"Nout"$ in @eq:Ndef is dominated by the $epsilon.alt^(- 2) log | cal(N)_(epsilon.alt' , n , m , p) |$ term since $alpha = cal(O) ( 1 )$, and so recalling @eq:Neps-sizeupp and our choice of $epsilon\' = c/"Nin"$ we obtain


$ "Nout" = cal(O) (frac(p^3, epsilon^2) log^3 ((n + m) p "Nin")) = cal(O) (frac(p^3, epsilon^2) log^3 ((n + m) p "Nin")) = tilde(cal(O)) (frac(p^3, epsilon^2)) , $


where again $tilde(cal(O)) ( dot.op )$ hides logarithmic factors in $n , m , p , 1 / epsilon.alt$.


As we require $"Nout"$ copies of $⨂_(i = 1)^(N_(upright("in"))) cal(E) ( rho_i )$, we must make $"Nout"dot.op "Nin" = tilde(cal(O))(p^4/epsilon^4)$ accesses to $cal(E)$. By union bounding over @eq:conc holding for all $tilde(cal(E)) in cal(N)_(epsilon.alt' , n , m , p)$ and over the success of the algorithm in @thm:data_analysis, we obtain @thm:poly-upp-learn-proc for $delta = 2 / 5$ from the assumption that $p = upright("poly") ( n )$.


We now describe how to extend this result to general $delta$ by a standard clustering argument. We can run $r := Theta ( log ( 1 / delta ) )$ independent copies of the above protocol, resulting in indices $k_1 , dots.h , k_r$ into $cal(N)_(epsilon.alt' , n , m , p)$ such that for any fixed $i in \[ r \]$, $∥sigma_(k_i) - rho∥_1 lt.eq 4 c$ with probability at least $3 / 5$. If $S subset \[ r \]$ denotes the set of $i in \[ r \]$ for which $∥sigma_(k_i) - rho∥_1 lt.eq 4 c$, then by a Chernoff bound, $| S | gt.eq r / 2$ with probability at least $1 - delta$ provided the constant factor in the definition of $r$ is sufficiently large. Condition on the event that $| S | gt.eq r / 2$.


Let $k$ be an index into $cal(N)_(epsilon.alt' , n , m , p)$ for which there are at least $r / 2$ indices $i in \[ r \]$ for which $∥sigma_k - sigma_(k_i)∥_1 lt.eq 8 c$, and output the channel $tilde(cal(E))_k$. Such a $k$ certainly exists: take any $i in S$ and note that by triangle inequality, for any other $j in S$ we have


$ ∥sigma_(k_i) - sigma_(k_j)∥_1 lt.eq ∥sigma_(k_i) - rho∥_1 + ∥sigma_(k_j) - rho∥_1 lt.eq 8 c . $


Now observe that regardless of which $k$ we choose that meets the criterion that at least $r / 2$ indices $i in \[ r \]$ satisfy $∥sigma_k - sigma_(k_i)∥_1 lt.eq 8 c$, we must have


$ ∥sigma_k - rho∥_1 lt.eq 12 c . $
<eq:cluster_close>


Indeed, suppose to the contrary. Then for any $i in S$,


$ ∥sigma_k - sigma_(k_i)∥_1 gt.eq ∥sigma_k - rho∥_1 - ∥sigma_(k_i) - rho∥_1 > 12 c - 4 c = 8 c , $


where the second step is by the definition of $S$ and the assumption that @eq:cluster_close does not hold. As $| S | gt.eq r / 2$, this yields a contradiction of the fact that there are at least $r / 2$ indices $i in \[ r \]$ for which $∥sigma_k - sigma_(k_i)∥_1 lt.eq 8 c$.


If we take the constant $c$ sufficiently small, then @eq:cluster_close together with @eq:big and @lem:suffice allow us to conclude that $"𝔼"_(rho tilde cal(D)) \[∥cal(E) ( rho ) - tilde(cal(E))_k ( rho )∥_1\] lt.eq epsilon.alt$. As we ran $r := Theta ( log ( 1 / delta ) )$ independent copies of the protocol that we used for constant failure probability $delta$, we merely incur an additional $Theta ( log ( 1 / delta ) )$ multiplicative overhead in the number of access to $cal(E)$ we must make for general failure probability $delta$. ◻






= Predicting highly-incompatible observables with bounded quantum memory
<sec:hard-bdd-mem>


Here we will substantively generalize our results for predicting highly-incompatible observables, given in @sec:shadow. We show an exponential lower bound on the number of experiments when the size of the additional quantum memory is not large enough.


== Background and statement of results
<sec:background1>


Let us first recapitulate the setting of our previous results, so as to draw a contrast with our generalization. We have so far considered an experimentalist who is given sequential access to copies of an unknown state $rho$. In each measurement round, the experimentalist receives a copy of $rho$, and can measure with a POVM. The residual post-measurement state is then discarded, and only the classical data of the POVM outcome is kept. This classical data can be used to inform the choice of POVM measurement employed in subsequent rounds, i.e.~the protocol can be adaptive. This kind of protocol is emblematic of most contemporary and historical experiments in physics.


Note that the information maintained and processed from round to round in the protocols described above is solely classical. With the advent of quantum computers and more flexible quantum memory architectures, a new possibility emerges. Suppose that the unknown state $rho$ in question is an $n$-qubit state. Moreover, suppose we have $n + k$ qubit registers under our control. Then we can use those registers however we please, including performing arbitrary quantum information processing. Our only constraint is that each time we receive a new copy of $rho$, we must necessarily use $n$ qubits of our registers to hold it. It is thus appropriate to say that we have $k$ qubits of quantum memory, since even when we receive a new state $rho$ we can still maintain $k$ qubits worth of quantum data. We further allow ourselves to maintain and process an arbitrary amount of classical data, thought of as being stored in a classical device external to our quantum system.


A new question immediately presents itself: are there experimental tasks which are exponentially hard with only $k$ qubits of quantum memory, but easy with $k' > k$ qubits of quantum memory? In~@chen2021exponential this question was answered in the affirmative, but only in the sense of query complexity. That is, it was shown that there is an experimental task which requires $Omega ( 2^(( n - k ) / 3) )$ copies of $rho$ if there are only $k$ qubits of quantum memory; however, the gate complexity of achieving the task is #emph[always] exponential regardless of the size of $k$. Let us unpack this result. Note that if $k = n$, the bound $Omega ( 2^(( n - k ) / 3) )$ becomes trivial; indeed, it can be shown that one only requires a modest number of copies of $rho$ to achieve the specified task if $n = k$. But even in this case, the total number of quantum operations required is exponentially large in $n$. Nonetheless, the result is an interesting one: it means that unless $k$ goes as $n - c thin log ( n )$ (i.e.~unless $k$ is logarithmically close to $n$), the task is exponentially hard. When $k tilde n - c thin log ( n )$, the task is only polynomially hard in the sense of query complexity.


While the aforementioned result is theoretically interesting, it does not correspond to a quantum memory advantage that could be realized by a quantum device on account of the exponential gate complexity required to achieve the task for a quantum memory of #emph[any] size. Here we ameliorate this issue, and present the first example of a quantum memory advantage in the sense of both query #emph[and] gate complexity, and as such it can be realized on a quantum device. Moreover, we have realized this quantum advantage in our experiments on the Sycamore quantum computer.


Our experimental task has the form of a partially-revealed many-versus-one distinguishing task, closely related to the one in @sec:shadow. A statement of the new task is as follows:


#thmbox("task", "Task (Expectation value with bounded quantum memory)")[


There is an unknown state $rho$ which is either

+ A maximally mixed state $I / 2^n$ on $n$ qubits, or

+ The state $( I + P ) / 2^n$ where $P in ( I , X , Y , Z )^(⊗ n) { I^(⊗ n) }$ is a random but fixed Pauli string.

The choice of whether case 1 or case 2 is instantiated is made with equal probability at the outset, and is not revealed. The experimentalist is given access to $T$ copies of the unknown state $rho$ for a $T$ decided by the experimentalist, and after this an observable $O$ is revealed. The task of the experimentalist is to determine the value of $|upright("tr")(O rho)|$ using the final state of the $n + k$ qubit registers, along with any classical information that has been stored or processed along the way. In case 1 the operator $O$ is chosen uniformly at random from the non-identity Pauli strings; in case 2 the $O$ is chosen to be the Pauli operator $P$ if the state $rho$ is $( I + P ) / 2^n$.


] <task:bounded>


Note that if $k = n$ so that the total number of registers is $2 n$, then the task can be readily solved using the algorithm given in @sec:uppbd-obs. This algorithm is both query and gate efficient: we only require a constant number of copies of $rho$ (i.e.~the number of copies is independent of $n$) and $O ( n )$ gate complexity.


What is difficult is to show that if $k < n$, then the number of copies of $rho$ we require to determine $| upright("tr") ( O rho ) |$ as per the task above is $Theta ( 2^(( n - k ) / 3) )$. We will establish this in the subsections which follow below.


== Review of learning tree framework for bounded quantum memories
<sec:revew-bdd-qmem>


// [figvision-cn] imgs/BddQmem.png
// 这是一幅包含两个部分的示意图，用于对比两种不同记忆类型
// 的算法结构。 左侧部分标题为“Algorithm with only
// classical memory”（仅具有经典记忆的算法）。该部分展示
// 了一个树状结构图。树的根节点是一个位于顶部的空心圆圈。
// 从根节点向下引出三条带箭头的灰色实线，分别指向下方水平
// 排列的三个子节点。这三个子节点同样是空心圆圈。在该树状
// 结构的下方标注有文字“State of the classical memory”（
// 经典记忆的状态），指示这些圆圈代表经典记忆的状态。 图
// 像中央有一个粗大的深灰色箭头，从左指向右，表示从左侧模
// 型到右侧模型的演变或对应关系。 右侧部分标题为“
// Algorithm with bounded quantum memory”（具有受限量子记
// 忆的算法）。该部分同样展示了一个与左侧结构相同的树状图：
// 一个顶层的空心圆圈通过三条带箭头的灰色实线连接到下方的
// 三个空心圆圈。在右侧树状图的旁边标注有文字“State of
// the classical memory”（经典记忆的状态），指向这些空心
// 圆圈，表明它们依然代表经典记忆的状态。 与左侧不同的是，
// 右侧的每个树节点（包括根节点和三个子节点）都关联着一个
// 彩色的圆角正方形。根节点上方悬浮着一个粉色渐变到紫色的
// 圆角正方形。下方三个子节点的左侧各放置一个圆角正方形，
// 颜色分别为：最左侧是橙色渐变到紫色，中间是蓝色渐变到紫
// 色，最右侧是红色渐变到粉色。在这些彩色正方形的下方标注
// 有文字“State of the bounded quantum memory”（受限量子
// 记忆的状态），表明这些彩色方块代表了与特定经典记忆状态
// 相关联的量子记忆状态。
#figure(image("imgs/BddQmem.png", width: 70.0%),
  caption: [
    #emph[Illustration of learning tree representation for algorithms with bounded quantum memory.] We consider algorithms with unlimited classical memory and a bounded quantum memory consisting of $k$ qubits. To each node in the tree (corresponding to the state of the classical memory), we associate the $k$-qubit state of the bounded quantum memory.
  ]
)
<fig:bdd-qmem>



Here we provide an exposition of the learning tree framework for bounded quantum memories in~@chen2021exponential. As explained above, suppose we have $n + k$ qubit registers, where we designate $k$ as the quantum memory. Suppose for the moment that $k < n$. At each round in the protocol, we receive an $n$-qubit state $rho$, which we must hold on the $n$ non-memory registers. (Note that we cannot receive more than one copy of $rho$, since we do not have enough registers to hold additional copies on account of $k < n$.) Then upon receiving and holding $rho$, the state of all of our registers can be written as $rho ⊗ bold(Sigma)$, where $bold(Sigma)$ is the density matrix of the $k$-qubit quantum memory. The most general operation we can perform on the joint system is a quantum process, followed by a POVM measurement; we can then apply another quantum process followed by another POVM measurement, and so on. However, we can rewrite an alternating sequence of quantum processes and POVM measurements as a single POVM measurement, which we denote by ${ F_i }_(i = 1)^(N - 1)$. Writing $F_i = M_i^dagger M_i$, suppose our measurement outputs the $i$th POVM element. Defining


$ A_(M_i)^rho ( bold(Sigma) ) := upright("tr")_(1 , . . . , n) (M_i ( rho ⊗ bold(Sigma) ) M_i^dagger) thin , $


the reduced density matrix of our quantum memory is


$ frac(A_(M_i)^rho ( bold(Sigma) ), upright("tr") ( A_(M_i)^rho ( bold(Sigma) ) )) $
<E:newmemory1>


with probability $upright("tr") ( A_(M_i)^rho ( bold(Sigma) ) )$. In the next round, we can leverage our measurement output $i$ to adaptively inform our choice of POVM on


$ rho ⊗ frac(A_(M_i)^rho ( bold(Sigma) ), upright("tr") ( A_(M_i)^rho ( bold(Sigma) ) )) thin . $


Indeed, we can use the information of #emph[all] of our previous POVM outcomes to inform the choice of our next POVM. An illustration is given in Supp.~@fig:bdd-qmem.


The above description is ripe for being cast in the learning tree framework, which we presently articulate. The definition below is the same as Definition 6.1 of~@chen2021exponential, albeit with slightly different notation.

#block[
Let $rho$ be a fixed, unknown quantum density matrix on $n$ qubits. Suppose we have access to $n + k$ qubit registers. A learning algorithm with a quantum memory of size $k$ can be expressed as a rooted tree $cal(T)$ of depth $T$, where each node encodes the current state of the quantum memory in addition to the transcript of measurement outcomes the algorithm has seen so far. In particular, the tree satisfies the following properties:

+ Each note $u$ is associated with a $k$-qubit unnormalized density matrix $bold(Sigma)^rho ( u )$ corresponding to the current state of the quantum memory.

+ For the root $r$ of the tree, $bold(Sigma)^rho ( r )$ is an initial state denoted by $bold(Sigma)_0$.

+ At each note $u$, we apply a POVM measurement $\{F_s^u\}_s$ on $rho ⊗ bold(Sigma)^rho ( u )$ to obtain a classical outcome $s$. Each child node $v$ of $u$ is connected through the edge $e_(u , s)$.

+ If $v$ is the child note of $u$ connected through the edge $e_(u , s)$, then letting $F_s^u = M_s^(u thin dagger) M_s^u$ we have $bold(Sigma)^rho ( v ) := A_(M_s^u) ( bold(Sigma)^rho ( u ) ) thin .$

+ Note that for any node $u$ we have that $p^rho(u) := upright("tr")(bold(Sigma)^rho(u))$ is the probability that the transcript of measurement outcomes observed by the learning algorithm is described by $u$. Moreover, $bold(Sigma)^rho ( u ) / p^rho ( u )$ is the (normalized) state of the $k$-qubit memory at the node $u$.

]


Let us unpack the ingredients of this definition. The initial state of our quantum memory is $bold(Sigma)_0$, and we apply some initial choice of POVM ${ F_s^r }_s$ (where $r$ denotes the 'root' of the tree). If we measure the $s$th POVM outcome, then the quantum memory is in the unnormalized state $A_(M_s^r) ( bold(Sigma)_0 )$ with probability $upright("tr") ( A_(M_s^r) ( bold(Sigma)_0 ) )$. Each outcome $s$ of the POVM corresponds to a child note of the root; thus at the next level of the tree, each node is labelled by the POVM outcome $s$ and the corresponding state of the quantum memory $A_(M_s^r) ( bold(Sigma)_0 ) := bold(Sigma)^rho ( s )$. For the next measurement, we can leverage our knowledge of the previous POVM to craft a new POVM to be applied to the present state of the quantum memory. This type of procedure is repeated for many rounds.


To be explicit, suppose that the present state of the quantum memory is $Sigma^rho ( u )$, where the node $rho$ reflects a sequence or #emph[transcript] of POVM outcomes which brought us to the present state by an adaptive protocol. We can use this transcript of previous outcomes to choose a new POVM $\{F_s^u\}_s$ that we use to measure $rho ⊗ bold(Sigma)^u ( rho )$, which will result in the output $A_(M_s^u) ( bold(Sigma)^rho ( u ) )$ with probability $upright("tr") ( A_(M_s^u) ( bold(Sigma)^rho ( u ) ) )$. The nodes $v$ in the next layer encode the data of the previous measurement outcomes and the latest outcome (i.e., determined by the location of $v$ in the tree), as well as the new (conveniently unnormalized) state of the quantum memory $A_(M_s^u) ( bold(Sigma)^rho ( u ) ) := bold(Sigma)^rho ( v )$, where here $v$ is connected to $u$ by an edge $e_(u , s)$ (designating that $v$ is the consequence of the $s$th measurement outcome starting from the configuration in $u$).


== Hardness result for small quantum memories
<sec:hardness-smallqmem>


We will prove the following result using the learning tree framework:


#thmbox("theorem", "Theorem (Shadow tomography with partial reveal using a bounded quantum memory)")[ Consider Task~@task:bounded for learning an expectation value with a bounded quantum memory. Any learning algorithm with $n + k$ qubit registers needs $T gt.eq Omega ( 2^(( n - k ) / 3) )$ copies of $rho$ to determine $|upright("tr")(O rho)|$ with probability at least $2 / 3$. ] <thm:memory1>


On account of~@eq:TVbound-rev, it suffices to upper bound $bb(E)_P \[upright("TV") ( p_(I / 2^n) , p_(( I + P ) / 2^n) )\]$. To do so, we will leverage a key technical result coming from Theorem 1.4 of~@chen2021exponential. But in order to state this technical result, we first need to introduce the notion of #emph[good Paulis] and #emph[bad Paulis]. While details are provided in Definition 6.4 of~@chen2021exponential, here we explain the essential intuition and key properties.


In the learning protocol, we are trying to distinguish between the maximally mixed state $I / 2^n$ and states of the form $( I + P ) / 2^n$. The intuition is that if the size of our quantum memory $k$ is small relative to $n$, then it is hard to tell the two kinds of states apart. If this was the case, then any round of the protocol should only reveal a very small amount of distinguishing information. In particular, suppose we are at node $u$ in the learning tree, and so the state of the quantum memory at that node is either $bold(Sigma)_(I / 2^n) ( u )$ or $bold(Sigma)_(( I + P ) / 2^n) ( u )$ for some Pauli string $P$. If we consider a POVM $\{F_s^u\}_s$ where $F_s^u = M_s^(u thin dagger) M_s^u$, then if we measure some fixed outcome $s$ the new state of the quantum memory will be either $A_(M_s^u)^(I / 2^n) ( bold(Sigma)_(I / 2^n) ( u ) )$ or $A_(M_s^u)^(( I + P ) / 2^n) ( bold(Sigma)_(( I + P ) / 2^n) ( u ) )$. We would like for $∥A_(M_s^u)^(I / 2^n) ( bold(Sigma)_(I / 2^n) ( u ) ) - A_(M_s^u)^(( I + P ) / 2^n) ( bold(Sigma)_(( I + P ) / 2^n) ( u ) )∥_1$ to be exponentially small in $n - k$, in particular relative to some distinguishing measure between $bold(Sigma)_(I / 2^n) ( u )$ and $bold(Sigma)_(( I + P ) / 2^n) ( u )$. This would mean that starting from node $u$, the next POVM measurement will not significantly change our ability to distinguish the two possibilities for the resulting memory registers. While we cannot guarantee that such a property holds for all states $( I + P ) / 2^n$, such a property will hold for some $P$'s. Given a node $u$, the set of good Paulis $P \[ u \]$ is the set of all Pauli operators satisfying a particular version of the above property for #emph[all] edges from the root of the tree to $u$ (see Definition 6.4 of~@chen2021exponential for details). The residual Paulis are called the set of bad Paulis. In other words, the good Paulis $P \[ u \]$ designate the states $( I + P ) / 2^n$ which are hard to distinguish from $I / 2^n$ for a particular instantiation of the learning tree, specifically for the sequence of POVMs that get us from the root of said learning tree to the node $u$. By contrast, the bad Paulis reveal too much information.


We have the following useful Lemma about bad Paulis, which we will soon leverage in the proof of #ref(<thm:memory1>):


#thmbox("lemma", "Lemma (Fact 6.5 of~@chen2021exponential)")[


For any edge $e_(u , s)$, there are at most $2^(- ( n - k ) / 3) dot.op ( 4^n - 1 )$ bad Paulis $P$. In particular, along any root-to-leaf path of the learning tree, there are at most $T dot.op 2^(- ( n - k ) / 3) dot.op ( 4^n - 1 )$ Paulis which are bad for some edge along the path.


] <lemm:fact6p5>


Equipped with our discussion of good and bad Paulis, we can now state the following technical result from#cite(<chen2021exponential>):


#thmbox("lemma", "Lemma (Following from the proof of Theorem 1.4 of~@chen2021exponential)")[ We have the inequality


$ frac(1, 4^n - 1) sum_(ell in "leaf"(cal(T))) sum_(P in P\[ell\]) |bold(Sigma)_(I / 2^n)(ell) - bold(Sigma)_((I + P) / 2^n)(ell)|_1 lt.eq T dot.op 2^(-(n - k) / 3) dot.op sqrt(frac(2^(2 n), 2^(2 n) - 1)) , $

] <lemm:following>


We are finally ready to prove @thm:memory1.

#block[
#emph[Proof of @thm:memory1.] Let us upper bound $bb(E)_P [upright("TV") ( p_(I / 2^n) , p_(( I + P ) / 2^n) )]$. We have the inequalities~◻

]


$ bb(E)_P \[upright("TV") ( p_(I / 2^n) , p_(( I + P ) / 2^n) )\] lt.eq bb(E)_P \[sum_ell max (0 , p_(I / 2^n) ( ell ) - p_(( I + P ) / 2^n) ( ell ))\] $ <E:Ineq1>

$ lt.eq bb(E)_P \[sum_ell min (p_(I / 2^n) ( ell ) , | p_(I / 2^n) ( ell ) - p_(( I + P ) / 2^n) ( ell ) |)\] $ <E:Ineq2>

$ lt.eq bb(E)_P \[sum_ell min (p_(I / 2^n) ( ell ) , ∥bold(Sigma)_(I / 2^n) ( ell ) - bold(Sigma)_(( I + P ) / 2^n) ( ell )∥_1)\] $ <E:Ineq3>

$ lt.eq sum_ell upright("Pr") \[ P in.not P \[ ell \] \] thin p_(I / 2^n) ( ell ) + frac(1, 4^n - 1) sum_(P in P \[ ell \]) ∥bold(Sigma)_(I / 2^n) ( ell ) - bold(Sigma)_(( I + P ) / 2^n) ( ell )∥_1 thin . $ <E:Ineq4>


In the first line, we have used that $upright("TV") ( p , q ) = 1 / 2 sum_i | p_i - q_i | = sum_(i thin : thin p_i gt.eq q_i) ( p_i - q_i ) = sum_i max ( 0 , p_i - q_i )$. To go from~@E:Ineq1 to~@E:Ineq2 we used $max ( 0 , a - b ) lt.eq min ( a , | a - b | )$. In going from~@E:Ineq2 to~@E:Ineq3 we leveraged that $| p_(I / 2^n) ( ell ) - p_(( I + P ) / 2^n) ( ell ) | = | upright("tr") ( bold(Sigma)_(I / 2^n) ( ell ) - bold(Sigma)_(( I + P ) / 2^n) ( ell ) ) | lt.eq parallel bold(Sigma)_(I / 2^n) ( ell ) - bold(Sigma)_(( I + P ) / 2^n) ( ell ) parallel_1$. Finally, to go from~@E:Ineq3 to~@E:Ineq4 we used $sum_(i in S) min ( a_i , b_i ) lt.eq sum_(i in S R) a_i + sum_(i in R) b_i$ for any $R subset.eq S$.


By @lemm:fact6p5 and the fact that $sum_ell p_(I / 2^n) ( ell ) = 1$, we have the simple bound


$ sum_ell upright("Pr") \[ P in.not P \[ ell \] \] thin p_(I / 2^n) ( ell ) lt.eq T dot.op 2^(- ( n - k ) / 3) . $


and @lemm:following gives us


$ frac(1, 4^n - 1) sum_(P in P \[ ell \]) ∥bold(Sigma)_(I / 2^n) ( ell ) - bold(Sigma)_(( I + P ) / 2^n) ( ell )∥_1 lt.eq T dot.op 2^(- ( n - k ) / 3) dot.op sqrt(frac(2^(2 n), 2^(2 n) - 1)) thin . $


Then in total, we have


$ bb(E)_P \[upright("TV") ( p_(I / 2^n) , p_(( I + P ) / 2^n) )\] lt.eq T dot.op 2^(- ( n - k ) / 3) (1 + sqrt(frac(2^(2 n), 2^(2 n) - 1))) thin . $


If the left-hand side is $Omega ( 1 )$, then we must thus have $T gt.eq Omega ( 2^(( n - k ) / 3) )$, as claimed. ◻





#bibliography("refs.bib", title: none)