#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)
#let thmbox(fam, name, body, title: none) = figure(
  kind: fam,
  supplement: name,
  numbering: "1",
  block(width: 100%, {
    context [*#name #counter(figure.where(kind: fam)).display()#if title != none [ (#title)].*]
    h(0.4em)
    set text(style: "italic")
    body
  }),
)


#align(center)[
  #text(17pt, weight: "bold", [Information-theoretic bounds on quantum advantage in machine learning])   #v(1.2em)
  #text(10.5pt)[Hsin-Yuan Huang#super[1], Richard Kueng#super[3], John Preskill#super[1]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Institute for Quantum Information and Matter, Caltech, Pasadena, CA, USA] \
  #text(9pt)[#super[2] Department of Computing and Mathematical Sciences, Caltech, Pasadena, CA, USA] \
  #text(9pt)[#super[3] Institute for Integrated Circuits, Johannes Kepler University Linz, Austria] \
  #text(9pt)[#super[4] Walter Burke Institute for Theoretical Physics, Caltech, Pasadena, CA, USA] \
  #text(9pt)[#super[5] AWS Center for Quantum Computing, Pasadena, CA, USA] \
]
#v(1.2em)





We study the performance of classical and quantum machine learning (ML) models in predicting outcomes of physical experiments. The experiments depend on an input parameter $x$ and involve execution of a (possibly unknown) quantum process $"ℰ"$. Our figure of merit is the number of runs of $"ℰ"$ required to achieve a desired prediction performance. We consider classical ML models that perform a measurement and record the classical outcome after each run of $"ℰ"$, and quantum ML models that can access $"ℰ"$ coherently to acquire quantum data; the classical or quantum data is then used to predict outcomes of future experiments. We prove that for any input distribution $cal(D) ( x )$, a classical ML model can provide accurate predictions #emph[on average] by accessing $"ℰ"$ a number of times comparable to the optimal quantum ML model.


In contrast, for achieving accurate prediction on #emph[all] inputs, we prove that exponential quantum advantage is possible. For example, to predict expectations of all Pauli observables in an $n$-qubit system $rho$, classical ML models require $2^(Omega ( n ))$ copies of $rho$, but we present a quantum ML model using only $cal(O) ( n )$ copies. Our results clarify where quantum advantage is possible and highlight the potential for classical ML models to address challenging quantum problems in physics and chemistry.





= Introduction
<introduction>


The widespread applications of machine learning (ML) to problems of practical interest have fueled interest in machine learning using quantum platforms @biamonte2017quantum @schuld2019quantum @havlivcek2019supervised. Though many potential applications of quantum ML have been proposed, so far the prospect for quantum advantage in solving purely classical problems remains unclear @tang2019quantum @tang2018quantum @gilyen2018quantum @arrazola2019quantum. On the other hand, it seems plausible that quantum ML can be fruitfully applied to problems faced by quantum scientists, such as characterizing the properties of quantum systems and predicting the outcomes of quantum experiments @carleo2017solving @van2017learning @carrasquilla2017machine @gilmer2017neural @melnikov2018active @sharir2020deep @aharonov2021quantum.


Here we focus on an important class of learning problems motivated by quantum mechanics. Namely, we are interested in predicting functions of the form


$ f ( x ) = "tr" ( O "ℰ" ( | x chevron.r chevron.l x | ) ) , $<eq:target-function>


where $x$ is a classical input, $"ℰ"$ is an arbitrary (possibly unknown) completely positive and trace preserving (CPTP) map, and $O$ is a known observable. Equation~@eq:target-function encompasses #emph[any] physical process that takes a classical input and produces a real number as output. The goal is to construct a function $h ( x )$ that accurately approximates $f ( x )$ after accessing the physical process $"ℰ"$ as few times as possible.


A particularly important special case of setup~@eq:target-function is training an ML model to predict what would happen in physical experiments @melnikov2018active. Such experiments might explore, for instance, the outcome of a reaction in quantum chemistry @zhou2017optimizing, ground state properties of a novel molecule or material @parr1980density @car1985unified @becke1993new @white1993density @peruzzo2014variational @kandala2017hardware @gilmer2017neural, or the behavior of neutral atoms in an analog quantum simulator @buluta2009quantum @levine2018high @bernien2017probing. In these cases, the input $x$ subsumes parameters that characterize the process, e.g., chemicals involved in the reaction, a description of the molecule, or the intensity of lasers that control the neutral atoms. The map $"ℰ"$ characterizes a quantum evolution happening in the lab. Depending on the parameter $x$, it produces the quantum state $"ℰ" ( | x chevron.r chevron.l x | )$. Finally, the experimentalist measures a certain observable $O$ at the end of the experiment. The goal is to predict the measurement outcome for new physical experiments, with new values of $x$ that have not been encountered during the training process.


// [figvision] imgs/CMLvsQML.png
// Panel (a): A schematic flowchart for classical machine learning. At the bottom, a rectangular "Classical
// processing" block receives a "Classical input" and sends a thick grey arrow upward to a grey 3-D block labeled
// "Physical experiments (CPTP map)" topped by a "Measurement" box. A callout marked "Classical output" leaves
// this stage and enters a second "Classical processing" block above, which connects to an upper grey "Physical
// experiments (CPTP map)" block also capped by "Measurement". A vertical arrow rises from this upper block to a
// top "Classical processing" rectangle, whose arrow points to "Prediction model stored in classical memory".
// Dotted ellipses between stages indicate repeated cycles. All boxes have dark rectangular outlines; arrows are
// thick grey. A bold caption below reads "Classical Machine Learning". Panel (b): A schematic flowchart for
// quantum machine learning. At the bottom, a red-rimmed "Quantum processing" block takes "Coherent quantum state
// input" and sends a thick grey arrow upward to a grey "Physical experiments (CPTP map)" block. A wavy black
// line marked "Entangled" links this lower block to a second upper grey "Physical experiments (CPTP map)" block.
// A green "Quantum processing" block sits between them carrying "Coherent quantum state output", while a purple
// top "Quantum processing" block leads to "Prediction model stored in quantum memory". Blue callouts label the
// coherent quantum state input and output. Dotted ellipses indicate iteration. Colours distinguish the
// processing stages: red bottom, green middle, purple top. A bold caption below reads "Quantum Machine
// Learning".
#figure(image("imgs/CMLvsQML.png", width: 83.0%),
  caption: [
    #emph[Illustration of classical and quantum machine learning settings:] The goal is to learn about an unknown CPTP map $"ℰ"$ by performing physical experiments. (Left) In the learning phase of the classical ML setting, a measurement is performed after each query to $"ℰ"$\; the classical measurement outcomes collected during the learning phase are consulted during the prediction phase. (Right) In the learning phase of the quantum ML setting, multiple queries to $"ℰ"$ may be included in a single coherent quantum circuit, yielding an output state stored in a quantum memory; this stored quantum state is consulted during the prediction phase.
  ]
)
<fig:CMLvsQML>



Motivated by these concrete applications, we want to understand the power of classical and quantum ML models in predicting functions of the form given in Equation~@eq:target-function. On the one hand, we consider classical ML models that can gather classical measurement data $( ( x_i , o_i ) )_(i = 1)^(N_(upright(C)))$, where $o_i$ is the outcome when we perform a POVM measurement on the state $"ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | )$. We denote by $N_(upright(C))$ the number of such experiments performed during training in the classical ML setting. On the other hand, we consider quantum ML models in which multiple runs of the CPTP map $"ℰ"$ can be composed coherently to collect quantum data, and predictions are produced by a quantum computer with access to the quantum data. We denote by $N_(upright(Q))$ the number of times $"ℰ"$ is used during training in the quantum setting. The classical and quantum ML settings are illustrated in @fig:CMLvsQML.


We focus on the question of whether quantum ML can have a large advantage over classical ML: to achieve a small prediction error, can the optimal $N_(upright(Q))$ in the quantum ML setting be much less than the optimal $N_(upright(C))$ in the classical ML setting? For the purpose of this comparison, we disregard the runtime of the classical or quantum ML models that generate the predictions; we are only interested in how many times the process $"ℰ"$ must run during the learning phase in the quantum and classical settings.


Our first main result addresses small #emph[average] prediction error, i.e.~the prediction error $| h ( x ) - f ( x ) |^2$ averaged over some specified input distribution $cal(D) ( x )$.


We rigorously show that, for any $"ℰ"$, $O$, and $cal(D)$, and for any quantum ML model, one can always design a classical ML model achieving a similar average prediction error such that $N_(upright(C))$ is larger than $N_(upright(Q))$ by at worst a small polynomial factor.


Hence, there is no exponential advantage of quantum ML over classical ML if the goal is to achieve a small average prediction error, and if the efficiency is quantified by the number of times $"ℰ"$ is used in the learning process. This statement holds for existing quantum ML models running on near-term devices @havlivcek2019supervised @schuld2019quantum @huang2020power and future quantum ML models yet to be conceived. We note, though, that while there is no large advantage in query complexity, a substantial quantum advantage in computational complexity is possible @servedio2004equivalences.


However, the situation changes if the goal is to achieve a small #emph[worst-case] prediction error rather than a small average prediction error --- an exponential separation between $N_(upright(C))$ and $N_(upright(Q))$ becomes possible if we insist on predicting $f ( x ) = "tr" ( O "ℰ" ( | x chevron.r chevron.l x | ) )$ accurately for #emph[every] input $x$. We illustrate this point with an example: accurately predicting expectation values of Pauli observables in an unknown $n$-qubit quantum state $rho$. This is a crucial subroutine in many quantum computing applications; see e.g.~@peruzzo2014variational @kokail2019self @huang2019near @crawford2020efficient @huang2020predicting @izmaylov2019unitary @jiang2020optimal @huggins2019efficient. We present a quantum ML model that uses $N_(upright(Q)) = cal(O) ( n )$ copies of $rho$ to predict expectation values of all $n$-qubit Pauli observables. In contrast we prove that #emph[any] classical ML model requires $N_(upright(C)) = 2^(Omega ( n ))$ copies of $rho$ to achieve the same task even if the ML model can perform arbitrary adaptive single-copy POVM measurements.


= Machine learning settings
<machine-learning-settings>


We assume that the observable $O$ (with \$"left""lVertO""right""rVert" less.eq 1\$) is known and the physical experiment $"ℰ"$ is an unknown CPTP map that belongs to a set of CPTP maps $"ℱ"$. Apart from $"ℰ" in "ℱ"$, the process can be arbitrary --- a common assumption in statistical learning theory~@valiant1984theory @blumer1989learnability @bartlett2002rademacher @vapnik2013nature @arunachalam2017guest. For the sake of concreteness, we assume that $"ℰ"$ is a CPTP map from a Hilbert space of $n$ qubits to a Hilbert space of $m$ qubits. Regarding inputs, we consider bit-strings of size $n$: $x in (0 , 1)^n$. This is not a severe restriction, since floating-point representations of continuous parameters can always be truncated to a finite number of digits. We now give precise definitions for classical and quantum ML settings; see @fig:CMLvsQML for an illustration.


==== Classical (C) ML:
<classical-c-ml>
The ML model consists of two phases: learning and prediction. During the learning phase, a randomized algorithm selects classical inputs $x_i$ and we perform a (quantum) experiment that results in an outcome $o_i$ from performing a POVM measurement on $"ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | )$.


A total of $N_(upright(C))$ experiments give rise to the classical training data $( ( x_i , o_i ) )_(i = 1)^(N_(upright(C)))$. After obtaining this training data, the ML model executes a randomized algorithm $cal(A)$ to learn a prediction model


$ s_(upright(C)) = cal(A) (( ( x_1 , o_1 ) , dots.h ( x_(N_(upright(C))) , o_(N_(upright(C))) ) )) , $


where $s_(upright(C))$ is stored in the classical memory. In the prediction phase, a sequence of new inputs $tilde(x)_1 , tilde(x)_2 , dots.h in ( 0 , 1 )^n$ is provided. The ML model will use $s_(upright(C))$ to evaluate predictions $h_(upright(C)) ( tilde(x)_1 ) , h_(upright(C)) ( tilde(x)_2 ) , dots.h$ that approximate $f ( tilde(x)_1 ) , f ( tilde(x)_2 ) , dots.h$ up to small errors.


==== Restricted classical ML:
<restricted-classical-ml>
We will also consider a restricted version of the classical setting. Rather than performing arbitrary POVM measurements, we restrict the ML model to measure the target observable $O$ on the output state $"ℰ" | x_i chevron.r #h(-1em) chevron.l x_i |$ to obtain the measurement outcome $o_i$. In this case, we always have $o_i in bb(R)$ and $"𝔼" [ o_i ] = "tr" ( O "ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | ) )$.


==== Quantum (Q) ML:
<quantum-q-ml>
During the learning phase, the model starts with an initial state $rho_0$ in a Hilbert space of arbitrarily high dimension. Subsequently, the quantum ML model accesses the unknown CPTP map $"ℰ"$ a total of $N_(upright(Q))$ times. These queries are interleaved with quantum data processing steps:


$ rho_("ℰ") = cal(C)_(N_(upright(Q))) ( "ℰ" ⊗ cal(I) ) cal(C)_(N_(upright(Q)) - 1) dots.h cal(C)_1 ( "ℰ" ⊗ cal(I) ) ( rho_0 ) , $<eq:outputQSQML-main>


where each $cal(C)_i$ is an arbitrary but known CPTP map, and we write $"ℰ" ⊗ cal(I)$ to emphasize that $"ℰ"$ acts on an $n$-qubit subsystem of a larger quantum system. The final state $rho_("ℰ")$, encoding the prediction model learned from the queries to the unknown CPTP map $"ℰ"$, is stored in a quantum memory. In the prediction phase, a sequence of new inputs $tilde(x)_1 , tilde(x)_2 , dots.h in ( 0 , 1 )^n$ is provided. A quantum computer with access to the stored quantum state $rho_("ℰ")$ executes a computation to produce prediction values $h_(upright(Q)) ( tilde(x)_1 ) , h_(upright(Q)) ( tilde(x)_2 ) , dots.h$ that approximate $f ( tilde(x)_1 ) , f ( tilde(x)_2 ) , dots.h$ up to small errors

#block[
#footnote[Due to non-commutativity of quantum measurements, the ordering of new inputs matters. For instance, the two lists $tilde(x)_1 , tilde(x)_2$ and $tilde(x)_2 , tilde(x)_1$ can lead to different outcome predictions $h_(upright(Q)) ( tilde(x)_i )$. Our main results do not depend on this subtletey --- they are valid, irrespective of prediction input ordering.]

]
.


The quantum ML setting is strictly more powerful than the classical ML setting. During the prediction phase, classical ML models are restricted to processing classical data, albeit data obtained by measuring a quantum system during the learning phase. In contrast, quantum ML models can work directly with the quantum data and perform quantum data processing. A quantum ML model can have an exponential advantage relative to classical ML models for some tasks, as we demonstrate in Sec.~@sec:worstcaseprederr.


= Average-case prediction error
<average-case-prediction-error>


For a prediction model $h ( x )$, we consider the average-case prediction error


$ sum_(x in ( 0 , 1 )^n) cal(D) ( x ) | h ( x ) - "tr" ( O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ) ) |^2 , $


with respect to a fixed distribution $cal(D)$ over inputs. This could, for instance, be the uniform distribution.


Although learning from quantum data is strictly more powerful than learning from classical data, there are fundamental limitations. The following rigorous statement limits the potential for quantum advantage.


#thmbox("theorem", "Theorem")[


Fix an $n$-bit probability distribution $cal(D)$, an $m$-qubit observable \$O("left""lVertO""right""rVert"less.eq 1)\$ and a set $"ℱ"$ of CPTP maps with $n$ input qubits and $m$ output qubits. Suppose there is a quantum ML model which accesses the map $"ℰ" in "ℱ" N_(upright(Q))$ times, producing with high probability a function $h_(upright(Q)) ( x )$ that achieves


$ sum_(x in ( 0 , 1 )^n) cal(D) ( x ) lr(|h_(upright(Q)) ( x ) - "tr" ( O cal(E) ( | x chevron.r #h(-1em) chevron.l x | ) )|)^2 lt.eq epsilon.alt . $


Then there is an ML model in the restricted classical setting which accesses $"ℰ" N_(upright(C)) = cal(O) ( m N_(upright(Q)) / epsilon.alt )$ times and produces with high probability a function $h_C$ that achieves


$ sum_(x in ( 0 , 1 )^n) cal(D) ( x ) lr(|h_(upright(C)) ( x ) - "tr" ( O cal(E) ( | x chevron.r #h(-1em) chevron.l x | ) )|)^2 = cal(O) ( epsilon.alt ) . $<eq:aveprederr>


] <thm:noadvquantum>


#emph[Proof sketch.] The proof consists of two parts. First, we cover the entire set of CPTP maps $"ℱ"$ with a maximal packing net, i.e.~the largest subset $cal(S) = { "ℰ"_s }_(s = 1)^(| cal(S) |) subset "ℱ"$ such that the functions $f_("ℰ"_s) ( x ) = "tr" ( O "ℰ"_s ( | x chevron.r #h(-1em) chevron.l x | ) )$ obey $sum_(x in (0 , 1)^n) cal(D) ( x ) lr(|f_(cal(E)_s) ( x ) - f_(cal(E)_(s')) ( x )|)^2 > 4 epsilon.alt$ whenever $s eq.not s'$. We then set up a communication protocol as follows. Alice chooses an element $s$ of the packing net uniformly at random, records her choice $s$, and then applies $"ℰ"_s N_Q$ times to prepare a quantum state $rho_("ℰ"_s)$ as in Eq.~@eq:outputQSQML-main. Alice's random ensemble of quantum states is thus given by



$ rho_("ℰ"_s) thin upright(" with probability ") thin p_s = frac(1, | cal(S) |) $<eq:randomensemble>


for $s = 1 , dots.h , | cal(S) |$.


Alice then sends the randomly sampled quantum state $rho_("ℰ"_s)$ to Bob, hoping that Bob can



 decode the state $rho_("ℰ"_s)$ to recover her chosen message $s$. Using the quantum ML model,


Bob can produce the function $h_(Q , s) ( x )$. Because by assumption the function $h_(Q , s) ( x )$ achieves a small average-case prediction error with high probability, and because the packing net has been constructed so that the functions ${ f_("ℰ"_s) }$ are sufficiently distinguishable, Bob can determine $s$ successfully with high probability. Because Alice chose from among $| cal(S) |$ possible messages, the mutual information of the chosen message $s$ and Bob's measurement outcome must be at least of order $log | cal(S) |$ bits. According to Holevo's theorem, the Holevo $chi$ quantity of Alice's ensemble Eq.~@eq:randomensemble upper bounds this mutual information, and therefore



must also be $chi = Omega ( log | cal(S) ) |$.


Furthermore, we can analyze how $chi$ depends on $N_Q$, finding that each additional application of $"ℰ"_s$ can increase $chi$ by at most $cal(O) ( m )$. We conclude that $chi = cal(O) ( m N_(upright(Q)) )$, yielding the lower bound $N_(upright(Q)) = Omega ( log ( | cal(S) | ) / m )$. The lower bound applies to any quantum ML model, where the size $| cal(S) |$ of the packing net depends on the average-case prediction error $epsilon.alt$. This completes the first part of the proof.


In the second part, we explicitly construct an ML model in the restricted classical setting that achieves a small average-case prediction error using a modest number of experiments. In this ML model, an input $x_i$ is selected by sampling from the probability distribution $cal(D)$, and an experiment is performed in which the observable $O$ is measured in the output quantum state $"ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | )$, obtaining measurement outcome $o_i$ which has expectation value $"tr" ( O "ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | ) )$. A total of $N_(upright(C))$ such experiments are conducted. Then, the ML model minimizes the least-squares error to find the best fit within the aforementioned maximal packing net $cal(S)$:


$ h_(upright(C)) = "arg min"_(f in cal(S)) 1 / N_(upright(C)) sum_(i = 1)^(N_(upright(C))) | f ( x_i ) - o_i |^2 . $


Because the measurement outcome $o_i$ fluctuates about the expectation value of $O$, it may be impossible to achieve zero training error. Yet it is still possible for $h_(upright(C))$ to achieve a small average-case prediction error, potentially even smaller than the training error. We use properties of maximal packing nets and of quantum fluctuations of measurement outcomes to perform a tight statistical analysis of the average-case prediction error, finding that with high probability $sum_(x in ( 0 , 1 )^n) cal(D) ( x ) lr(|h_(upright(C)) ( x ) - "tr" ( O cal(E) ( | x chevron.r #h(-1em) chevron.l x | ) )|)^2 = cal(O) ( epsilon.alt )$, provided that $N_(upright(C))$ is of order $log ( | cal(S) | ) / epsilon.alt$.


Finally, we combine the two parts to conclude $N_(upright(C)) = cal(O) ( m N_(upright(Q)) / epsilon.alt )$.


The full proof is in #ref(<sec:proofnoadv>, supplement: [Appendix]).






@thm:noadvquantum shows that all problems that are approximately learnable by a quantum ML model are also approximately learnable by some restricted classical ML model which executes the quantum process $"ℰ"$ a comparable number of times. This applies in particular, to predicting outputs of quantum-mechanical processes. The relation $N_(upright(C)) = cal(O) ( m N_(upright(Q)) / epsilon.alt )$ is tight. We give an example in #ref(<sec:satnoadv>, supplement: [Appendix]) with $N_(upright(C)) = Omega ( m N_(upright(Q)) / epsilon.alt )$.


For the task of learning classical Boolean circuits, fundamental limits on quantum advantage have been established in previous work @servedio2004equivalences @zhang2010improved @arunachalam2016optimal @arunachalam2017guest @chung2019sample @arunachalam2020quantum. @thm:noadvquantum generalizes these existing results to the task of learning outcomes of quantum processes. ◻


= Worst-case prediction error
<sec:worstcaseprederr>


#place(top + center, scope: "parent", float: true,
  grid(
    columns: (0.33fr, 0.64fr),
    align: horizon,
    [#figure(
      table(
        columns: 3,
        align: center,
        table.header([Model], [Upp. bd.], [Low. bd.]),
        table.hline(),
        [Quantum ML], [$cal(O) ( n )$], [$Omega ( n )$],
        [Classical ML], [$cal(O) ( n 2^n )$], [$2^(Omega ( n ))$],
        [Restricted CML], [$cal(O) ( 2^(2 n) )$], [$Omega ( 2^(2 n) )$],
      ),
      kind: table,
      placement: none,
      caption: [Sample complexity for predicting expectations of #emph[all] $4^n$ Pauli observables (worst-case prediction error) in an $n$-qubit quantum state. #emph[Upp. bd.] is the achievable sample complexity of a specific algorithm. #emph[Low. bd.] is the lower bound for any algorithm. The classical ML upper bound can be achieved using classical shadows based on random Clifford measurements @huang2020predicting. The rest of the bounds are obtained in #ref(<app:exp-sep-Pauli>, supplement: [Appendix]).],
    ) <tab:QSCC-samp>],
// [figvision] imgs/PauliShadow.png
// Panel (a), the mixed-state plot titled Predicting 4^n Pauli observables (mixed state), draws number of data
// copies on a logarithmic y-axis spanning 10^1 to 10^5 versus system size n on a linear x-axis from 0 to 100.
// Quantum ML is green circles rising slowly from about 5 copies near n=2 to roughly 200 at n=100. Classical ML
// is orange crosses shooting up from roughly 15 at n=1 to nearly 10^5 around n=8. Restricted CML is blue squares
// climbing even faster to 10^5 by about n=5. The two classical curves grow exponentially with n while the
// quantum curve stays low, showing a strong quantum data advantage for mixed states. Panel (b), the
// product-state plot titled Predicting 4^n Pauli observables (product state), plots number of data copies on a
// linear y-axis from 0 to 600 versus system size n from 0 to 100. Restricted CML, blue squares, is a straight
// line rising linearly from 0 copies at n=0 to 600 at n=100. Classical ML, orange crosses, stays nearly flat
// around 20 to 30 copies for all n. Quantum ML, green circles, remains near zero to about ten copies across the
// range, essentially flat. The linear CML growth contrasts with the nearly constant, small copy number needed by
// quantum and classical ML for product states.
    [#figure(
      image("imgs/PauliShadow.png", width: 100%),
      placement: none,
      caption: [Numerical experiments -- number of copies of an unknown $n$-qubit state needed for predicting expectation values of all $4^n$ Pauli observables, with constant worst-case prediction error. #emph[Mixed states:] Quantum states of the form $( I + P ) / 2^n$, where $P$ is an $n$-qubit Pauli observable. #emph[Product states:] Tensor products of single-qubit stabilizer states.],
    ) <fig:numeric>],
  )
)



Rather than achieving a small average prediction error, one may be interested in obtaining a prediction model that is accurate for all inputs $x in ( 0 , 1 )^n$. For a prediction model $h ( x )$, we consider the worst-case prediction error to be


$ max_(x in ( 0 , 1 )^n) | h ( x ) - "tr" ( O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ) ) |^2 . $


Under such a stricter performance requirement, exponential quantum advantage becomes possible.


We highlight this potential by means of an illustrative and practically relevant example: predicting expectation values of Pauli operators in an unknown $n$-qubit quantum state $rho$. This is a central task for many quantum computing applications @peruzzo2014variational @huang2019near @crawford2020efficient @huang2020predicting @kokail2019self @izmaylov2019unitary @jiang2020optimal @huggins2019efficient. To formulate this problem in our framework, suppose the $2 n$-bit input $x$ specifies one of the $4^n n$-qubit Pauli operators $P_x in ( I , X , Y , Z )^(⊗ n)$, and suppose that $"ℰ"_rho ( | x chevron.r chevron.l x | )$ prepares the unknown state $rho$ and maps $P_x$ to the fixed observable $O$, which is then measured; hence


$ f ( x ) = "tr" ( O "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) ) = "tr" ( P_x rho ) . $


In this setting, according to @thm:noadvquantum, there is no large quantum advantage if our goal is to estimate the Pauli operator expectation values with a small #emph[average] prediction error. However, an exponential quantum advantage is possible if we insist on accurately predicting #emph[every one] of the $4^n$ Pauli observables.


First we show there is an efficient quantum ML model that achieves a small prediction error. Details are in #ref(<sec:pauli-qml>, supplement: [Appendix])\; here we just sketch the main ideas. The procedure for predicting $"tr" ( P_x rho )$ has two stages. The goal of the first stage is to predict the absolute value $| "tr" ( P_x rho ) |$ for each $x$, and the goal of the second stage is to determine the #emph[sign] of $"tr" ( P_x rho )$. The key idea used in the first stage is that, although two different Pauli operators $P_x$ and $P_y$ may either commute or anticommute, the tensor products $P_x ⊗ P_x$ and $P_y ⊗ P_y$ are mutually commuting for all $x$ and $y$. Therefore, although it is not possible to measure anticommuting Pauli operators simultaneously using a single copy of the state $rho$, it is possible to measure $P_x ⊗ P_x$ simultaneously for all $x$ using two copies of $rho$. Indeed, all $4^n$ expectation values $"tr" ( ( P_x ⊗ P_x ) ( rho ⊗ rho ) ) = "tr" ( P_x rho )^2$ can be determined by measuring pairs of qubits in the Bell basis, which is highly efficient. This completes the first stage.


If $| "tr" ( P_x rho ) |$ is found to be small in the first stage, we may predict $h ( x ) = 0$ and be assured that the prediction error is small. Therefore, in the second stage, we need only determine the sign if $| "tr" ( P_x rho ) |$ was found to be reasonably large in the first stage. In that case we can perform a coherent measurement across several copies of $rho$ which performs a majority vote and yields the correct value of the sign with high success probability. Because the measurement is strongly biased in favor of one of the two possible outcomes, it introduces only a very "gentle" disturbance of the pre-measurement state.


Therefore, by performing many such measurements in succession on the same quantum memory register, we can determine the sign of $"tr" ( P_x rho )$ for many different values of $x$.


The second stage can also be more amenable to near-term implementation using a heuristic that groups commuting observables @izmaylov2019unitary @huggins2019efficient\; see #ref(<sec:heuristicsNTImp>, supplement: [Appendix]) for further discussion.


Each of the two stages requires only a small number of copies of $rho$\; a careful analysis yields the following theorem.







#thmbox("theorem", "Theorem")[


The quantum ML model only needs $N_(upright(Q)) = cal(O) ( log ( M / delta ) / epsilon.alt^4 )$ copies of $rho$ to predict expectation values of any $M$ Pauli observables to error $epsilon.alt$ with probability at least $1 - delta$.


] <thm:pauli-shadow>


More details regarding the quantum ML model, as well as a rigorous proof, are provided in #ref(<sec:pauli-qml>, supplement: [Appendix]). The sample complexity stated in @thm:pauli-shadow improves upon previously known shadow tomography protocols @aaronson2018shadow @aaronson2019gentle @huang2020predicting @badescu2020improved for the special case of predicting Pauli observables; see #ref(<sec:related-work>, supplement: [Appendix]). Because each access to $"ℰ"_rho$ allows us to obtain one copy of $rho$, we only need $N_(upright(Q)) = cal(O) ( n )$ to predict expectation values of all $4^n$ Pauli observables up to a constant error.


For classical ML models, we prove the following fundamental lower bound; see #ref(<sec:lowerboundindmeas>, supplement: [Appendix]).


#thmbox("theorem", "Theorem")[


Any classical ML must use $N_(upright(C)) gt.eq 2^(Omega ( n ))$ copies of $rho$ to predict expectation values of all Pauli observables up to a small error with a constant success probability.


] <thm:cmllwbd>


This theorem holds even when the POVM measurements performed by the classical ML model could depend on the previous POVM measurement outcomes adaptively. When combined with @thm:pauli-shadow, @thm:cmllwbd establishes an exponential gap separating classical ML models from fully quantum ML models. @tab:QSCC-samp provides a summary of the upper and lower bounds on the sample complexity for predicting expectation values of Pauli observables.


= Numerical experiments
<numerical-experiments>


We support our theoretical findings with numerical experiments, focusing on the task of predicting the expectation values of all $4^n$ Pauli observables in an unknown $n$-qubit quantum state $rho$, with a small worst-case prediction error. In this case, the function is $f ( x ) = "tr" ( O "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) ) = "tr" ( P_x rho )$, where $x in ( I , X , Y , Z )^n$ indexes the Pauli observables, and $"ℰ"_rho$ prepares the unknown state $rho$ then maps $P_x$ to the fixed observable $O$. This is the task we considered in @sec:worstcaseprederr. Note that average-case prediction of Pauli observables is a much easier task, because most of the $4^n$ expectation values are exponentially small in $n$.


We consider two classes of underlying states $rho$: (i) #emph[Mixed states:] $rho = ( I + P ) / 2^n$, where $P$ is a tensor product of $n$ Pauli operators. States in this class have rank $2^(n - 1)$. (ii) #emph[Product states:] $rho = ⨂_(i = 1)^n | s_i chevron.r chevron.l s_i |$, where each $| s_i chevron.r$ is one the six possible single-qubit stabilizer states. We consider stabilizer states to ensure that classical simulation of the quantum ML model is tractable for reasonably large system size.


The numerical experiment in @fig:numeric implements the best-known ML procedures. We can clearly see that there is an exponential separation between the number of copies of the state $rho$ required for classical and quantum ML to predict expectation values when $rho$ is in the class of mixed states. However, for the class of product states, the separation is much less pronounced. Restricted classical ML can only obtain outcomes $o_i in { plus.minus 1 }$ with $"𝔼" [ o_i ] = "tr" ( P_(x_i) rho )$. Hence each copy of $rho$ provides at most one bit of information, and therefore $cal(O) ( n )$ copies are needed to predict expectation values of all $4^n$ Pauli observables. In contrast, standard classical ML can perform arbitrary POVM measurements on the state $rho$, so each copy can provide up to $n$ bits of information. The separation between classical ML and quantum ML is marginal for product states.


= Conclusion and outlook
<conclusion-and-outlook>


We have studied the task of learning functions of the form Equation~@eq:target-function, using as a figure of merit the number of runs of $"ℰ"$.


Our main result @thm:noadvquantum shows that, when the objective is achieving a specified #emph[average] prediction error, a classical ML model can perform as well as a quantum ML model, using a comparable number of runs of $"ℰ"$. This result establishes a fundamental limit on quantum advantage in machine learning that holds for any quantum ML model @havlivcek2019supervised @schuld2019quantum @huang2020power.


From a different perspective, @thm:noadvquantum means that the classical ML setting, in which a measurement is performed after each query to $"ℰ"$, can be surprisingly effective. The quantum ML setting, in which multiple queries to $"ℰ"$ can be included in a single coherent quantum circuit, is far more challenging and may be infeasible until far in the future.


Therefore finding that classical and quantum ML have comparable power (for average-case prediction) boosts our hopes that the combination of classical ML and near-term quantum algorithms



  preskill2018quantum,huang2019near,havlivcek2019supervised,schuld2019quantum,huang2020power may fruitfully address challenging quantum problems in physics, chemistry, and materials science.


On the other hand, @thm:pauli-shadow~and~@thm:cmllwbd rigorously establish that quantum ML can have an exponential advantage over classical ML for certain problems where the objective is achieving a specified #emph[worst-case] prediction error. This exponential advantage of quantum ML over classical ML may be viewed as an exponential separation between coherent measurements (in which a measurement apparatus interacts coherently multiple times with a measured system, storing quantum data which is then processed by a quantum computer) and incoherent measurements (in which a POVM measurement is performed and the outcome recorded after each interaction between system and apparatus, and the classical measurement outcomes are then processed by a classical computer).


Such a separation has been challenging to establish because incoherent measurements are difficult to analyze in the adaptive setting, where each measurement performed may depend on the outcomes of all previous measurements.


Our proof technique overcomes this challenge,


enabling us to identify tasks which allow substantial quantum advantage.



An important future direction will be identifying further learning problems which allow substantial quantum advantage, pointing toward potential practical applications of quantum technology.


#heading(level: 2, numbering: none)[Acknowledgments:]
<acknowledgments>


The authors thank Victor Albert, Sitan Chen, Jerry Li, Seth Lloyd, Jarrod McClean, Spiros Michalakis, Yuan Su, and Thomas Vidick for valuable input and inspiring discussions. We would also like to thank anonymous reviewers for in-depth comments and suggestions. HH is supported by the J. Yang & Family Foundation.


JP acknowledges funding from the U.S. Department of Energy Office of Science, Office of Advanced Scientific Computing Research, (DE-NA0003525, DE-SC0020290), and the National Science Foundation (PHY-1733907). The Institute for Quantum Information and Matter is an NSF Physics Frontiers Center.








#heading(level: 1, numbering: none)[Appendix]
<appendix>

#counter(heading).update(0)
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 { numbering("A", n.at(0)) } else { numbering("A", n.at(0)) + "." + n.slice(1).map(str).join(".") }
})


#heading(level: 4, numbering: none)[#strong[Roadmap:]]
<roadmap>
#ref(<sec:related-work>, supplement: [Appendix]) provides additional context and discusses relevant existing work. Details regarding the numerical experiments can be found in @sec:numerics. The remaining portions are devoted to theory and mathematical proofs. #ref(<sec:proofnoadv>, supplement: [Appendix]) provides a thorough treatment of average prediction errors, including bounds on query complexity (the number times the quantum process $"ℰ"$ is accessed) culminating in a proof of @thm:noadvquantum. #ref(<sec:satnoadv>, supplement: [Appendix]) provides a stylized example demonstrating that the bound is tight. Finally, #ref(<app:exp-sep-Pauli>, supplement: [Appendix]) provides sample complexity upper and lower bounds for predicting many Pauli expectation values with small worst-case error (leading to exponential separation in query complexity).


= Related works
<sec:related-work>


==== Quantum PAC learning:
<quantum-pac-learning>


It is instructive to relate our main result on achieving average-case prediction error (@thm:noadvquantum) to quantum probably approximately correct (PAC) learning @servedio2004equivalences @zhang2010improved @arunachalam2016optimal @arunachalam2017guest @chung2019sample @arunachalam2020quantum @caro2020binary. The latter rigorously established the absence of information-theoretic quantum advantage for learning classical Boolean functions $h : ( 0 , 1 )^n arrow.r ( 0 , 1 )$. This is a special case of predicting functions of the form $f ( x ) = "tr" (O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ))$. To see this, we reversibly encode every $n$-bit Boolean function $h$ in a (unitary) CPTP map that acts on $( n + 1 )$ qubits:


$ "ℰ"_h ( rho ) = U_h rho U_h^dagger , quad upright("where") quad U_h | x , a chevron.r = | x , h ( x ) xor a chevron.r quad upright("for all") quad x in ( 0 , 1 )^n , a in ( 0 , 1 ) , $


where $xor$ is addition in $bb(Z)_2$. This is the quantum oracle for implementing the Boolean function $h$. Fix $O = bb(I)^(⊗ n) ⊗ Z = Z_(n + 1)$ --- a Pauli-$Z$ operator acting on the final qubit --- to conclude $"tr" ( O "ℰ"_h ( | x chevron.r #h(-1em) chevron.l x | ) ) = h ( x )$. In quantum PAC learning, the quantum ML models (or quantum learners) are restricted to quantum samples of the form $sum_x sqrt(cal(D) ( x )) | x chevron.r | h ( x ) chevron.r$, where $cal(D) ( x )$ is the probability for sampling $x$ in the input distribution $cal(D)$ and $h ( x )$ is the Boolean function in question. Furthermore, quantum PAC learning focuses on the worst-case input distribution $cal(D)_star.op$. This leaves open the potential for large quantum advantages in more general settings. For instance, the quantum ML could be allowed to access the CPTP map $"ℰ"_h$ or we may want to consider an input distribution with the largest classical-quantum separation. @thm:noadvquantum closes these open questions showing that no large quantum advantage in sample complexity (or query complexity) is possible even in the much more general setting of learning $f ( x ) = "tr" ( O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ) )$. Note that direct access to $"ℰ"_h$ would also enable the construction of quantum PAC samples (if we assume the quantum ML model depends on the fixed input distribution $"𝒟"$). The quantum ML model simply inputs the pure state $sum_x sqrt(cal(D) ( x )) | x chevron.r | 0 chevron.r$ to $"ℰ"_h$ to obtain


$ U_h sum_x sqrt(cal(D) ( x )) | x chevron.r | 0 chevron.r = sum_x sqrt(cal(D) ( x )) | x chevron.r | h ( x ) chevron.r , $


which is the quantum sample considered in quantum PAC learning. For related works on PAC learning a distribution rather than a function, see @sweke2020quantum @niu2020learnability.


While existing results @servedio2004equivalences @zhang2010improved @arunachalam2016optimal @arunachalam2017guest @chung2019sample @arunachalam2020quantum @caro2020binary have shown that no large quantum advantage in sample complexity is possible, we can still have substantial quantum speedups in computational complexity. In Ref.~@servedio2004equivalences, for instance, a contrived learning problem is constructed based on factoring. This work showcases the possibility of a quantum advantage in computational complexity, even if no quantum advantage in sample complexity is possible. On the other hand, exponential separation in sample complexity is possible if one considers worst-case approximation errors.


==== Quantum machine learning:
<quantum-machine-learning>


Quantum computers have the potential to improve existing machine learning models based on classical computers. A series of works require that an exponential amount of data is stored in a quantum random access memory @biamonte2017quantum @harrow2009quantum @rebentrost2014quantum @lloyd2014quantum @lloyd2013quantum @wiebe2012quantum @dunjko2018machine @huang2019near. Due to the quantum data structure, one can obtain exponential speed-up for certain machine learning tasks. However, the act of storing the exponential amount of data will take exponential time. Furthermore, if we assume a similar data structure for classical machines, then the exponential advantage may


vanish altogether @aaronson2015read @tang2019quantum @tang2018quantum @gilyen2018quantum @arrazola2019quantum. Another recent line of works focuses on using quantum computers to represent a set of classically intractable functions @farhi2018classification @havlivcek2019supervised @schuld2019quantum @cong2019quantum. However, computational power provided by data in a machine learning task can also make a classical ML model stronger @huang2020power and may challenge some of these proposals in practice. When we consider learning an arbitrary unitary, due to the inherent complexity of the unitary group, the sample complexity is going to scale with the Hilbert space dimension (exponential in the system size) @poland2020no @sharma2020reformulation.


==== Classical learning theory:
<classical-learning-theory>


For a general introduction to classical learning theory, see the comprehensive book on the foundations of machine learning @mohri2018foundations. The classical learning strategy is the same as learning probabilistic real-valued functions. Existing works on learning real-valued functions @alon1997scale @bartlett1998prediction, or probabilistic Boolean functions @kearns1994efficient, mainly focus on the worst-case input distribution that maximizes sample complexity. Geometric quantities, such as the fat-shattering dimension @alon1997scale, then provide a characterization of the sample complexity @alon1997scale. For example, @bartlett1998prediction proves that a (worst-case) sample complexity upper bound is given by $tilde(cal(O)) ( upright("fat") thin upright("(") epsilon.alt / upright("5") thin upright(")") / epsilon.alt^("2") )$, where $tilde(cal(O)) ( dot.op )$ suppresses logarithmic factors. In contrast, our proof of @thm:noadvquantum produces a sample complexity upper bound $cal(O) (log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ) / epsilon.alt) )$ that scales with $1 / epsilon.alt$ instead of $1 / epsilon.alt^2$. The geometric constant $log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | )$ is also different (it measures the cardinality of a maximal packing net that depends on the input distribution).






==== Shadow tomography:
<shadow-tomography>


Shadow tomography is the task of simultaneously estimating the outcome probabilities associated with $M$ 2-outcome measurements up to accuracy $epsilon.alt$: $p_i ( rho ) = upright("tr") ( E_i rho )$, where each $E_i$ is a positive semi-definite matrix with operator norm at most one @aaronson2018shadow @brandao2019sdp @aaronson2019gentle @badescu2020improved. The best existing result is given by @badescu2020improved. They showed that $N = cal(O) (log ( M )^2 log ( d ) / epsilon.alt^4)$ copies of the unknown state suffice to achieve this task. Their protocol is based on an improved quantum threshold search: finding an observable $E_i$ with the expectation value $"tr" ( E_i rho )$ exceeding a certain threshold. Then, they combine this with online learning of quantum states following Aaronson's original protocol. @aaronson2018shadow. A more experimentally friendly shadow tomography protocol has been proposed in @huang2020predicting. It only yields competitive scaling complexities for a restricted set of observables, but can be implemented on state-of-the-art quantum platforms @struchalin2020experimental @elben2020mixed.


==== PAC learning quantum systems:
<pac-learning-quantum-systems>


A precursor to shadow tomography is PAC learning of quantum states @aaronson2007learnability @rocchetto2019experimental, where the goal is to accurately predict expectation values of different observables in an unknown quantum system $rho$ up to a small average error. This fits nicely into the scope of @thm:noadvquantum: The optimal fully quantum ML model that can perform quantum data analysis on many copies stored in the quantum memory will not yield a large advantage in sample complexity over ML models that make predictions based solely on classical measurement data from randomized measurements on single copy of $rho$.


This separation between learning from classical measurement data and learning from the quantum states coherently has not been discussed in @aaronson2007learnability.


The result @aaronson2007learnability could be seen as establishing an upper bound on the maximal packing net for the set of CPTP maps



 $"ℱ"$. This then translates into a sample complexity upper bound needed to achieve good prediction performance.


==== Measuring expectation values of Pauli observables:
<measuring-expectation-values-of-pauli-observables>


Due to the importance of measuring Pauli observables in near-term applications of quantum computers, a series of methods @crawford2020efficient @izmaylov2019unitary @verteletskyi2020measurement @hamamura2020efficient @jiang2020optimal @huggins2019efficient @bonet2020nearly have been proposed to reduce the number of measurements needed to estimate Pauli expectation values. All of them are based on one basic, yet powerful, observation: Commuting observables can be measured simultaneously. For example, quantum chemistry applications are often contingent on measuring $cal(O) ( n^4 )$ Pauli observables @peruzzo2014variational. The aforementioned Pauli estimation protocols group these observables into $cal(O) ( n^3 )$ or even only $cal(O) ( n )$ commuting groups. In turn, $cal(O) ( n^3 )$ or $cal(O) ( n )$ copies of the underlying state suffice to obtain expectation values for all $cal(O) ( n^4 )$ relevant Pauli observables by exploiting the ability to simultaneously measure commuting observables. On the other hand, the novel technique proposed in #ref(<app:exp-sep-Pauli>, supplement: [Appendix]) gets by with even fewer state preparations. A total of $cal(O) ( log ( n^4 ) ) = cal(O) ( log ( n ) )$ copies suffice. Restriction to few-body Pauli observables can yield additional improvements. Several protocols are known for this special case, see e.g.~@paini2019approximate @cotler2019quantum @bonet2020nearly @jiang2020optimal @evans2019scalable @huang2020predicting.


==== Incoherent versus coherent measurements:
<incoherent-versus-coherent-measurements>


The exponential advantage of quantum ML over classical ML established by our work may be viewed as an exponential separation between coherent measurements (in which a measurement apparatus interacts coherently multiple times with a measured system, storing quantum data which is then processed by a quantum computer) and incoherent measurements (in which a POVM measurement is performed and the outcome recorded after each interaction between system and apparatus, and the classical measurement outcomes are then processed by a classical computer). Existing work has shown an


advantage of coherent measurements over #emph[independent] incoherent measurements, a special case in which the POVM measurements do not depend on the results of previous measurements; see e.g., @haah2017sample on quantum state tomography and @huang2020predicting on shadow tomography. However, few prior results limit the power of incoherent measurements in the #emph[adaptive] setting, in which each measurement performed may depend on the outcomes of all the previous measurements.


A prior result we were aware of before obtaining our result was @bubeck2020entanglement, showing a mild polynomial advantage of coherent over incoherent measurements for the task of distinguishing whether an unknown quantum state is close to the completely mixed state or not. Our work established an exponential separation between incoherent and coherent measurements in sample complexity (the number of copies of a quantum state needed to perform the task) for shadow tomography. After our work was complete, @aharonov2021quantum also presented a detailed analysis of the power of coherent and incoherent measurements, finding



an exponential separation between incoherent and coherent measurements for the task of distinguishing between different types of quantum channels.


= Details of numerical experiments
<sec:numerics>


== Mixed states
<mixed-states>


For the case of mixed states given by $rho = ( I + P_(x^(*)) ) / 2^n$, we have $f ( x ) = "tr" ( P_x rho ) = delta_(x , x^(*))$ for all $x in ( I , X , Y , Z )^n$. That is, $f ( x )$ is a point function, i.e.~$f ( x^(*) ) = 1$ for exactly one $x^(*)$, all other Pauli strings evaluate to zero.


==== Restricted classical ML:
<restricted-classical-ml>


We consider a restricted classical ML model that implements an exhaustive search over all Pauli observables $P_x$ with $x in (I , X , Y , Z)^n$. For each $x$, we repeatedly measure the observable $P_x$ and check whether the outcome $- 1$ ever occurs. If this is the case, we know $f ( x ) = 0$ with certainty (recall, that $f ( x ) in (0 , 1)$ is a point function). After looping through all observables, we will be left with a single input $x^(*)$ that obeys $f ( x^(*) ) = 1$. There are a total of $4^n$ inputs and whenever $x eq.not x^(*)$, the expected number of measurements required to obtain the outcome $- 1$ is $1 / ( upright("Pr")_x [ - 1 ] ) = 2$. In contrast, for $x = x^(*)$, outcome $- 1$ can never occur. This results in a sample complexity of $cal(O) ( 4^n )$ -- a scaling that is confirmed by our numerical experiments and matches the lower bound $Omega ( 4^n )$.


==== Classical ML:
<classical-ml>


For classical ML, we implement property prediction with classical shadows based on random Clifford measurements~


@huang2020predicting. The sample complexity to predict $M$ Pauli observables up to small constant accuracy is known to be $cal(O) ( max_x "tr" ( P_x^2 ) log ( M ) )$. Using $"tr" ( P_x^2 ) = "tr" ( I^(⊗ n) ) = 2^n$ and $M = 4^n$, this upper bound simplifies to $cal(O) ( n 2^n )$. The numerical experiments confirm this theoretical prediction.


==== Quantum ML:
<quantum-ml>


For quantum ML, we use the procedure introduced in #ref(<sec:pauli-qml>, supplement: [Appendix]). We first perform several repetitions of two-copy Bell basis measurements to estimate absolute values $| "tr" ( P_x rho ) |^2$ for all $4^n$ possible inputs $x$. This allows us to immediately identify $x^(*)$. One could solve for $x^(*)$ by performing Gaussian elimination in $G F ( 2 )$. A similar strategy has also been used for learning quantum channels @harper2020fast. The required sample complexity is $cal(O) ( log ( 4^n ) ) = cal(O) ( n )$ and the numerical experiments confirm this linear scaling.


== Product states
<product-states>


We consider the unknown $n$-qubit state to be a tensor product of $n$ single-qubit stabilizer states (there are only six choices $| 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | y , + chevron.r , | y , - chevron.r$). We only need to obtain measurement outcomes for single-qubit Pauli observables to completely determine such product states.


==== Restricted classical ML:
<restricted-classical-ml>
Recall that the goal of this task is to predict $f ( x ) = "tr" ( P_x rho )$ for an unknown quantum state $rho$. The restricted classical ML can collect measurement data of the form $( ( x_i , o_i ) )$, where $x_i in ( I , X , Y , Z )^n$ and $o_i in plus.minus 1$ is the measurement outcome when we measure $P_x$ on $rho$. We simply collect measurement outcomes for the $3 n$ single-qubit Pauli observables by choosing the appropriate $x_i$. For each qubit, we sample $plus.minus 1$-outcomes in the $X$-, $Y$- and $Z$-basis. Once we find that two of the three Pauli observables result in both the outcome $plus.minus 1$, we can determine the single-qubit state for the particular qubit. For two of the three bases, the underlying distribution is uniform, while deterministic outcomes are produced in the third basis. In turn, we expect to require $6 n$ Pauli measurements to unambiguously characterize the underlying stabilizer state. This scaling is confirmed by the numerical experiments.


==== Classical ML:
<classical-ml>
We associate classical ML models with reconstruction procedures that can perform arbitrary POVM measurements on individual copies of the unknown state $rho$. Here, we consider a sequence of POVMs where we measure first in the all-$X$ basis, second in the all-$Y$ basis, and then in the all-$Z$ basis (and repeat). Similar to the restricted classical ML, we also check if two of the three possible single-qubit observables $X , Y , Z$ have resulted in both outcomes $plus.minus 1$. Once two of the three single-qubit observables have produce both outcomes $plus.minus 1$, we can perfectly identify the corresponding single-qubit stabilizer state. But, to complete the assignment, we need to be able to do so for all $n$ qubits. This incurs an additional logarithmic factor in the expected number of measurements. We expect to require $cal(O) ( log ( n ) )$ measurement repetitions to unambiguously determine the underlying product state. Numerical experiments confirm this scaling behavior.


==== Quantum ML:
<quantum-ml>
Quantum ML models can perform quantum data processing on multiple copies of quantum states. For product states, we only perform the following procedure. For each repetition, we perform two-copy Bell basis measurements on $rho ⊗ rho$ to simultaneously measure $X ⊗ X , Y ⊗ Y , Z ⊗ Z$ on each of the $n$ qubits in $rho$. We can determine the eigenbasis (X-basis, Y-basis, or Z-basis) of each qubit when we found that two of the observables $X ⊗ X , Y ⊗ Y , Z ⊗ Z$ result in both $plus.minus 1$ outcomes. For two of the three observables, the underlying distribution is uniform in $plus.minus 1$, while deterministic outcomes are produced in the third observable. Since we know the stabilizer bases for each qubit after a few two-copy measurements, we simply measure the $n$ qubits in the corresponding stabilizer basis on the final copy to recover the full state. We refer to @gross2017schur @montanaro2017learning @zhao2016fast @montanaro2016survey for results on efficient procedures for testing and learning stabilizer states in general.


= Proof of @thm:noadvquantum
<sec:proofnoadv>


This section contains a thorough treatment of #emph[average] prediction errors. We consider related setups for the classical and quantum learning settings.


The learning problem is defined by a set of CPTP maps $"ℱ"$, an input distribution $cal(D)$, and an observable $O$ with \$"left""lVertO""right""rVert" less.eq 1\$. Each CPTP map $"ℰ" in "ℱ"$ maps a $n$-qubit quantum state to $m$-qubit state. This collection defines a function


$ f_("ℰ") ( x ) = "tr" ( O "ℰ" ( | x chevron.r chevron.l x | ) ) : ( 0 , 1 )^n arrow.r bb(R) $


The goal is to learn a function $f : ( 0 , 1 )^n arrow.r bb(R)$ such that with high probability


$ bb(E)_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 quad upright("is small") . $


A bit of additional context is appropriate here: we are studying the existence of learning algorithms under a fixed learning problem defined by input distribution $"𝒟"$, observable $O , $ and set of CPTP maps $"ℱ"$. In turn, the actual learning algorithms may and, in general, will depend on these mathematical objects.


One of our main technical contributions -- @thm:noadvquantum -- highlights that a substantial quantum advantage is impossible for this setting (small #emph[average-case] prediction error). This is in stark contrast to the setting of achieving small #emph[worst-case] prediction error. The proof consists of two parts. @sec:lowerbdQU establishes a lower bound for the query complexity of #emph[any] quantum ML model. Subsequently, @sec:uppbdCL provides an upper bound for the query complexity achieved by #emph[certain] classical ML models. Finally, a combination of these two results establishes @thm:noadvquantum, see @sec:combineCLQU.


== Information-theoretic lower bound for quantum machine learning models
<sec:lowerbdQU>


The quantum machine learning model consists of learning phase and prediction phase. In the learning phase, the quantum ML model accesses the quantum experiment characterized by the CPTP map $"ℰ"$ for $N_(upright(Q))$ times to learn a model. We consider the quantum ML model to be a mixed state quantum computation algorithm (a generalization of unitary quantum computation). Starting point is an initial state $rho_0$ on any number of qubits. Subsequently, arbitrary quantum operations $cal(C)_t$ (CPTP maps) are interleaved with in total $N_(upright(Q))$ invocations $cal(E) ⊗ cal(I)$ of the unknown (black box) CPTP map and produce a final state


$ rho_("ℰ") = cal(C)_(N_(upright(Q))) ( "ℰ" ⊗ cal(I) ) cal(C)_(N_(upright(Q)) - 1) dots.h cal(C)_1 ( "ℰ" ⊗ cal(I) ) ( rho_0 ) . $<eq:outputQSQML>






In this model, we can assume without loss that $cal(E)$ always acts on the first $n$ qubits, because the quantum operations $cal(C)_t$ are unrestricted. In particular, they could contain certain SWAP operations that permute the qubits around.


The final state $rho_("ℰ")$ is the quantum memory that stores the prediction model learned from the CPTP map $"ℰ"$ using the quantum ML algorithm. Obtaining $rho_("ℰ")$ concludes the quantum learning phase.


In the prediction phase, we assume that new inputs are provided as part of a sequence


$ x_1 , x_2 , x_3 , dots.h in ( 0 , 1 )^n . $


For each sequence member $x_i$, the quantum ML model accesses the input $x_i$, as well as the current quantum memory. It produces an outcome by performing a POVM measurement on the quantum memory $rho_("ℰ")$. We emphasize that this can, and in general will, affect the quantum memory nontrivially. The quantum ML outputs $h_(upright(Q)) ( x_i )$ depend on the entire sequence $x_1 , dots.h , x_i$. And different sequence orderings will produce different predictions.


For example, when $n = 2$, the following ordering may result in the prediction


$ x_1 = 00 , x_2 = 01 , x_3 = 10 , x_4 = 11 thin thin arrow.r thin thin h_(upright(Q)) ( 00 ) = - 0.3 , h_(upright(Q)) ( 01 ) = 0.5 , h_(upright(Q)) ( 10 ) = 0.2 , h_(upright(Q)) ( 11 ) = - 0.7 , $


but a different ordering may result in a slightly different prediction, such as


$ x_1 = 11 , x_2 = 01 , x_3 = 10 , x_4 = 00 thin thin arrow.r thin thin h_(upright(Q)) ( 00 ) = - 0.2 , h_(upright(Q)) ( 01 ) = 0.5 , h_(upright(Q)) ( 10 ) = 0.2 , h_(upright(Q)) ( 11 ) = - 0.6 . $


Also, note that $h_(upright(Q)) ( x_i )$ can be randomized because a quantum measurement is performed to produce the prediction outcome. The ordering does not affect the theorem we want to prove. In the following, we will fix the input ordering to be an arbitrary ordering. For example, we can use the input ordering such that the quantum ML model has the smallest prediction error.


After fixing an input ordering, we can treat the entire prediction phase (taking a sequence of inputs $x_1 , x_2 , dots.h$ and producing $h_(upright(Q)) ( x_1 ) , h_(upright(Q)) ( x_2 ) , dots.h$) as an enormous POVM measurement on the output state $rho_("ℰ")$ obtained from the learning phase. Each outcome $a$ from the enormous POVM measurement on the output state $rho_("ℰ")$ corresponds to a function $h_(upright(Q) , a) ( x ) : ( 0 , 1 )^n arrow.r bb(R)$. Using Naimark's dilation theorem, every POVM measurement is a projective measurements on a larger Hilbert space. Since the quantum memory that the quantum ML model can operate on contains an arbitrary amount of qubits, we can use Naimark's dilation theorem to restrict the enormous POVM measurement to a projective measurement ${ P_a }_a$. Hence, for any CPTP map $"ℰ" in "ℱ"$, when we asks the quantum ML model to produce the prediction for an ordering of inputs $x_1 , x_2 , dots.h$, the output values $h_(upright(Q)) ( x_1 ) , h_(upright(Q)) ( x_2 ) , dots.h$ will be given by


$ h_(upright(Q) , a) ( x ) quad upright("with probability") quad "tr" ( P_a rho_("ℰ") ) = "tr" ( P_a cal(C)_(N_(upright(Q))) ( "ℰ" ⊗ thin cal(I) ) cal(C)_(N_(upright(Q)) - 1) dots.h cal(C)_2 ( "ℰ" ⊗ thin cal(I) ) cal(C)_1 ( "ℰ" ⊗ thin cal(I) ) cal(C)_0 ( rho_0 ) ) , $<eq:h-QaofQML>


for a projective measurement ${ P_a }_a$ with $sum_a P_a = I$.


Finally, we will assume that the produced function $h_(upright(Q)) ( x )$ achieves small prediction error


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q)) ( x ) - "tr" ( O cal(E) ( | x chevron.r chevron.l x | ) )|)^2 lt.eq epsilon.alt quad upright("with probability at least 2/3.") $<eq:QMLassumption>


for any CPTP map $cal(E) in "ℱ"$. This assumption asserts that


$ sum_(a = 1)^A "tr" ( P_a rho_("ℰ") ) bb(1) ["𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - "tr" ( O cal(E) ( | x chevron.r chevron.l x | ) )|)^2 lt.eq epsilon.alt] gt.eq 2 / 3 , $<eq:prob2-3>


where $bb(1) [ z ]$ denotes the indicator function of event $z$. That is, $bb(1) [ z ] = 1$ if $z$ is true and $bb(1) [ z ] = 0$ otherwise.


=== Maximal packing net
<sec:packnetQ>


We emphasize that Rel.~@eq:prob2-3 must be valid for #emph[any] $cal(E) in cal(F)$. Because we only need to output a function $h_(upright(Q)) ( x )$ that approximates $f ( x ) = "tr" ( O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ) )$ on average, the task will not be hard when there are only a few qualitatively different CPTP maps in $cal(F)$. However, the problem could become harder when $cal(F)$ contains a large amount of very different CPTP maps. The task is now to transform this requirement into a stringent lower bound on $N_(upright(Q))$ -- the number of black-box uses of the unknown CPTP map $cal(E) ⊗ cal(I)$ within the quantum computation @eq:outputQSQML. As a starting point, we equip the set of target functions $"ℱ"_f = { f_("ℰ") ( x ) = "tr" ( O cal(E) ( | x chevron.r chevron.l x | ) ) | "ℰ" in "ℱ" }$ with a packing net. Packing nets are discrete subsets whose elements are guaranteed to have a certain minimal pairwise distance (think of spheres that must not overlap with each other). We choose points (functions) $f_(cal(E)_i) in cal(F)_f$ and demand


$ "𝔼"_(x tilde cal(D)) | f_("ℰ"_i) ( x ) - f_("ℰ"_j) ( x ) |^2 > 4 epsilon.alt quad upright("whenever") quad i eq.not j . $<eq:epspackingnetdistance>


We denote the resulting packing net of $cal(F)_f$ by $M_(4 epsilon.alt)^p ( "ℱ"_f )$ and note that every such set has finitely many elements ($cal(F)_f$ is a compact set). We also assume that $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is maximal in the sense that no other $4 epsilon.alt$-packing net can contain more points (functions).


It is possible to utilize packing nets to derive a query complexity lower bound for the quantum machine learning model. In fact, we will present two different proof strategies. The first proof is inspired by @flammia2012quantum @haah2017sample @huang2020predicting and analyzes a communication protocol. The second proof uses a proof technique that depends on an analysis of polynomials similar to @beals2001quantum. While it is somewhat weaker than the information-theoretic bound in the first proof, we include the derivation for completeness as we believe that it may be insightful for the interested reader.


=== Proof strategy I: mutual information analysis
<sec:MIanalysisML>


Let us define a communication protocol between two parties, say Alice and Bob. They use the packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$ as a dictionary to communicate randomly selected classical messages. More precisely, Alice samples an integer $X$ uniformly at random from $1 , 2 , dots.h , | M_(4 epsilon.alt)^p ( "ℱ"_f ) |$ and chooses the corresponding CPTP map $"ℰ"_X in M_(4 epsilon.alt)^p ( "ℱ"_f )$. When Bob wants to access the unknown CPTP map $"ℰ"_X$, he will ask Alice to apply the CPTP map $"ℰ"_X$. Bob will then execute the quantum machine learning model @eq:outputQSQML to obtain a prediction model $h_(upright(Q) , a) ( x )$, where $a$ parameterizes the prediction model. Subsequently, Bob solves the following optimization problem


$ tilde(X) = "arg min"_(X' = 1 , dots.h , | M_(4 epsilon.alt)^p ( "ℱ"_f ) |) "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - "tr" ( O cal(E)_(X') ( | x chevron.r chevron.l x | ) )|)^2 $<eq:bob-decoding>


to obtain an integer $tilde(X)$. This decoding procedure seems adequate, provided that the prediction model $h_(upright(Q))$ approximately reproduces the true underlying function.


More precisely, assumption~@eq:QMLassumption asserts


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - "tr" ( O cal(E)_X ( | x chevron.r chevron.l x | ) )|)^2 lt.eq epsilon.alt quad upright("with probability at least 2/3.") $


Here is where the choice of dictionary matters: $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is a packing net, see Equation~@eq:epspackingnetdistance. For $X' eq.not X$ this necessarily implies


$ "𝔼"_(X tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - f_("ℰ"_(X')) ( x )|)^2 & gt.eq (( "𝔼"_(X tilde cal(D)) lr(|f_("ℰ"_X) ( x ) - f_("ℰ"_(X')) ( x )|)^2 )^(1 / 2) - ( "𝔼"_(X tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - f_("ℰ"_X) ( x )|)^2 )^(1 / 2))^2\
 & > (2 sqrt(epsilon.alt) - sqrt(epsilon.alt))^2 = epsilon.alt . $


This allows us to conclude that Bob's decoding strategy @eq:bob-decoding succeeds perfectly if


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - "tr" ( O cal(E)_X ( | x chevron.r chevron.l x | ) )|)^2 lt.eq epsilon.alt . $


In turn, Assumption~@eq:QMLassumption ensures $tilde(X) = X$ (perfect decoding) with probability at least $2 / 3$.


Now, we use the fact that Alice samples her message $X$ uniformly at random from a total of $| M_(4 epsilon.alt)^p ( "ℱ"_f ) |$ integers. Because $tilde(X) = X$ (perfect decoding) with probability at least $2 / 3$, Fano's inequality implies that


$ H ( X | tilde(X) ) lt.eq H ( 1 / 3 ) + log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ) / 3 , $


where $H ( x ) = - x log x - ( 1 - x ) log ( 1 - x )$ is the binary entropy. This gives a lower bound on the mutual information between sent and decoded message, namely


$ I ( X : tilde(X) ) = H ( X ) - H ( X | tilde(X) ) gt.eq 2 / 3 log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ) - H ( 1 / 3 ) = Omega (log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | )) . $<eq:MutualInfo-Mp>






Next, note that $tilde(X)$ is obtained by classically processing a measurement outcome $a$ of the quantum state $rho_(cal(E)_X)$ The data processing inequality and Holevo's theorem @holevo1973bounds @horodecki2009quantum @bengtsson2017geometry @araki2002entropy then imply


$ I ( X : tilde(X) ) lt.eq I ( X : a ) lt.eq chi ( X : rho_("ℰ"_X) ) . $<eq:MutualInfo-DP>


The Holevo $chi$ quantity between the classical random variable $X$ and the quantum state $rho_("ℰ"_X)$ is


$ chi ( X : rho_("ℰ"_X) ) = S ("𝔼"_X rho_("ℰ"_X)) - "𝔼"_X S (rho_("ℰ"_X)) , $


where $S ( rho ) = "tr" ( - rho log rho )$ is the von Neumann entropy. Throughout this work, we refer to $log$ with base $upright(e)$. Recall that Bob produces $rho_("ℰ"_X)$ by utilizing a total of $N_(upright(Q))$ channel copies obtained from Alice. We can use the specific layout~@eq:outputQSQML of Bob's quantum computation to produce an upper bound on the Holevo-$chi$:


$ chi ( X : rho_("ℰ"_X) ) lt.eq cal(O) ( m N_(upright(Q)) ) $<eq:holevo-upper-bound>


This bound follows from induction over a sample-resolved variant of Bob's quantum computation. For $t = 0 , 1 , dots.h , N_(upright(Q))$, we will show that


$ rho_("ℰ")^t = cal(C)_t ( "ℰ" ⊗ thin cal(I) ) cal(C)_(t - 1) dots.h cal(C)_1 ( "ℰ" ⊗ thin cal(I) ) cal(C)_0 ( rho_0 ) quad upright("obeys") quad chi ( X : rho_("ℰ"_X)^t ) lt.eq ( 2 log 2 ) m t . $


Bound~@eq:holevo-upper-bound then follows from recognizing that setting $t = N_(upright(Q))$ reproduces Bob's complete computation, see Equation~@eq:outputQSQML.


The base case ($t = 0$) is simple, because $rho_("ℰ"_X)^0 = cal(C)_0 ( rho_0 )$ does not depend on $X$ at all. This ensures


$ chi (X : rho_("ℰ"_X)^0) = S ("𝔼"_X rho_("ℰ"_X)^0) - "𝔼"_X S (rho_("ℰ"_X)^0) = S (rho_("ℰ"_X)^0) - S (rho_("ℰ"_X)^0) = 0 lt.eq ( 2 log 2 ) m t quad ( t = 0 ) . $


Now, let us move to the induction step ($t > 0$). The induction hypothesis provides us with


$ chi ( X : rho_("ℰ"_X)^(t - 1) ) lt.eq ( 2 log 2 ) m ( t - 1 ) $<eq:induchypoIX>


and we must relate $chi ( X : rho_("ℰ"_X)^t )$ to $chi ( X : rho_("ℰ"_X)^(t - 1) )$. To achieve this goal, we use the fact that the Holevo-$chi$ is closely related to the quantum relative entropy $D ( rho | | sigma ) = "tr" (rho ( log rho - log sigma ))$ @horodecki2009quantum @bengtsson2017geometry @araki2002entropy. Indeed,


$ chi ( X : rho_("ℰ"_X)^t ) = "𝔼"_X ["tr" (rho_("ℰ"_X)^t log rho_(c E_X)^t - rho_("ℰ"_X)^t log ("𝔼"_(X') rho_(c E_(X'))^t))] = "𝔼"_X D (rho_("ℰ"_X)^t | | "𝔼"_(X') rho_(c E_(X'))^t) , $


and monotonicity of the quantum relative entropy asserts


$ "𝔼"_X D (rho_("ℰ"_X)^t | | "𝔼"_(X') rho_(c E_(X'))^t) = & "𝔼"_X D (cal(C)_t (("ℰ"_X ⊗ thin cal(I)) (rho_("ℰ"_X)^(t - 1))) thin thin | | thin thin cal(C)_t ("𝔼"_(X') ("ℰ"_(X') ⊗ thin cal(I)) (rho_("ℰ"_(X'))^(t - 1))))\
lt.eq & "𝔼"_X D (("ℰ"_X ⊗ thin cal(I)) (rho_("ℰ"_X)^(t - 1)) thin thin | | thin thin "𝔼"_(X') ("ℰ"_(X') ⊗ thin cal(I)) (rho_("ℰ"_(X'))^(t - 1)))\
= & S ("𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) - "𝔼"_X S (("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) . $


This effectively allows us to ignore the $t$-th quantum operation $cal(C)_t$ and instead exposes the $t$-th invocation of $cal(E) ⊗ cal(I)$.


We analyze the two remaining terms separately. Let use define the notation $"tr"_(lt.eq m)$ as the partial trace over the first $m$ qubits, and $"tr"_(> m)$ as the partial trace over the rest of the qubits. Subadditivity of the von Neumann entropy $S ( rho )$ @horodecki2009quantum @bengtsson2017geometry @araki2002entropy implies


$ S ("𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) & lt.eq S ("tr"_(lt.eq m) "𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) + S ("tr"_(> m) "𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) ,\
 & lt.eq S ("tr"_(lt.eq m) "𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) + m log 2\
 & = S ("tr"_(lt.eq n) "𝔼"_X rho_("ℰ"_X)^(t - 1)) + m log 2 . $


The second inequality uses the fact that the maximum entropy for an $m$-qubit system is at most $m log 2$. The last equality is due to the following technical observation (the action of a CPTP map can be traced out).


#thmbox("lemma", "Lemma")[


Fix a CPTP map $cal(E)$ from $n$ qubits to $m$ qubits and let $cal(I)$ denote the identity map on $n' gt.eq 0$ qubits. Then, $"tr"_(lt.eq m) [ ( "ℰ" ⊗ cal(I) ) rho ] = "tr"_(lt.eq n) [ rho ]$ for any $( n + n' )$-qubit state $rho$.


]


#emph[Proof.] Let $cal(E) ( rho ) = sum_i K_i rho K_i^dagger$ be a Kraus representation of the CP map $cal(E)$. TP moreover implies $sum_i K_i^dagger K_i = I$. For any input state $rho$, Linearity and (partial) cyclicity of the partial trace then ensure



$ "tr"_(lt.eq m) (( "ℰ" ⊗ cal(I) ) rho) = & sum_i "tr"_(lt.eq m) (K_i ⊗ I rho K_i^dagger ⊗ I) = sum_i "tr"_(lt.eq m) (rho ( K_i^dagger K_i ) ⊗ I) = "tr"_(lt.eq m) (rho I ⊗ I) = "tr"_(lt.eq m) (rho) . $


This concludes the proof of the lemma.






Similarly, the second term can be lower bounded by


$ "𝔼"_X S (("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) & gt.eq "𝔼"_X S ("tr"_(lt.eq m) ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) - "𝔼"_X S ("tr"_(> m) ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) ,\
 & gt.eq "𝔼"_X S ("tr"_(lt.eq m) ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) - m log 2 ,\
 & = "𝔼"_X S ("tr"_(lt.eq n) rho_("ℰ"_X)^(t - 1)) - m log 2 . $


We can combine these two bounds with the monotonicity of the quantum relative entropy to obtain


$ chi ( X : rho_("ℰ"_X)^t ) & lt.eq S ("𝔼"_X ("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) )) - "𝔼"_X S (("ℰ"_X ⊗ thin cal(I)) ( rho_("ℰ"_X)^(t - 1) ))\
 & lt.eq S ("tr"_(lt.eq n) "𝔼"_X rho_("ℰ"_X)^(t - 1)) - "𝔼"_X S ("tr"_(lt.eq n) rho_("ℰ"_X)^(t - 1)) + ( 2 log 2 ) m\
 & = "𝔼"_X D ("tr"_(lt.eq n) rho_("ℰ"_X)^(t - 1) | | "tr"_(lt.eq n) "𝔼"_(X') rho_("ℰ"_(X'))^(t - 1)) + ( 2 log 2 ) m\
 & lt.eq "𝔼"_X D (rho_("ℰ"_X)^(t - 1) | | "𝔼"_(X') rho_("ℰ"_(X'))^(t - 1)) + ( 2 log 2 ) m\
 & = chi ( X : rho_("ℰ"_X)^(t - 1) ) + ( 2 log 2 ) m . $


Plug in the induction hypothesis @eq:induchypoIX to complete the argument:


$ chi ( X : rho_("ℰ"_X)^t ) lt.eq chi ( X : rho_("ℰ"_X)^(t - 1) ) + ( 2 log 2 ) m lt.eq ( 2 log 2 ) m ( t - 1 ) + ( 2 log 2 ) m = ( 2 log 2 ) m t . $<eq:holevo-upper-bound2>


It is worthwhile to pause and recapitulate the main insights from this section: i.) a lower bound on the mutual information in terms of packing net cardinality, see Equation~@eq:MutualInfo-Mp\; ii.) Holevo's theorem, see Equation~@eq:MutualInfo-DP\; and, (iii) an upper bound on the Holevo-$chi$ in terms of query complexity, see Equation~@eq:holevo-upper-bound2 for $t = N_(upright(Q))$. Combining all of them yields


$ Omega (log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | )) lt.eq I (X : tilde(X)) lt.eq chi (X : rho_("ℰ"_X)) lt.eq ( 2 log 2 ) m N_(upright(Q)) . $


Rearranging this display yields a lower bound on the minimal query complexity in terms of packing net size:


$ N_(upright(Q)) gt.eq Omega (frac(log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ), m)) . $<eq:NQlowerbound>

#align(right)[◻]


=== Proof strategy II: polynomial method
<proof-strategy-ii-polynomial-method>


The second proof uses a proof technique that depends on analysis of polynomials~@beals2001quantum. It leads to somewhat weaker results that only apply if $m lt.eq n$. We include this derivation for completeness as we believe that it may be insightful for the interested reader.


Let us start by recalling that we may embed a $4 epsilon.alt$-packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$ within the set of target functions $"ℱ"_f$. Geometrically, this means that each $"ℰ" in M_(4 epsilon.alt)^p ( "ℱ"_f )$ describes the center of a $2 epsilon.alt$-ball (this radius is defined with respect to average prediction error squared). And, according to the defining property Equation~@eq:epspackingnetdistance, these balls do not overlap. We can use these disjoint balls to cluster different quantum machine learning solutions. Define


$ cal(F)_("ℰ")^(upright(Q)) = (a in A thin thin : thin thin "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - f_("ℰ") ( x )|)^2 lt.eq epsilon.alt) , $<eq:smallballFQ>


where $A$ is a placeholder for all possible answers the quantum machine learning model can provide. See the definition given in Equation~@eq:h-QaofQML. The packing net condition~@eq:epspackingnetdistance ensures that different clusters are completely disjoint. For distinct $"ℰ"_1 , "ℰ"_2 in "ℱ"$ and $a_1 in "ℱ"_("ℰ"_1)^(upright(Q))$, $a_2 in "ℱ"_("ℰ"_2)^(upright(Q))$, two triangle inequalities and Equation~@eq:epspackingnetdistance yield


$ sqrt("𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a_1) ( x ) - h_(upright(Q) , a_2) ( x )|)^2) & gt.eq sqrt("𝔼"_(x tilde cal(D)) lr(|f_("ℰ"_1) ( x ) - h_(upright(Q) , a_2) ( x )|)^2) - sqrt("𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a_1) ( x ) - f_("ℰ"_1) ( x )|)^2)\
 & gt.eq sqrt("𝔼"_(x tilde cal(D)) lr(|f_("ℰ"_1) ( x ) - f_("ℰ"_2) ( x )|)^2) - sqrt("𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a_2) ( x ) - f_("ℰ"_2) ( x )|)^2)\
 & - sqrt("𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a_1) ( x ) - f_("ℰ"_1) ( x )|)^2)\
 & > 2 sqrt(epsilon.alt) - sqrt(epsilon.alt) - sqrt(epsilon.alt) = 0 . $


This implies $f_(a_1)^Q eq.not f_(a_2)^Q$ and, more importantly, $cal(F)_("ℰ"_1)^Q inter cal(F)_("ℰ"_2)^Q = diameter$ whenever $f_("ℰ"_1) eq.not f_("ℰ"_2)$.


We will use this insight to reason about an auxiliar matrix $P$ of size $| M_(4 epsilon.alt)^p ( "ℱ"_f ) | times | M_(4 epsilon.alt)^p ( "ℱ"_f ) |$. We label rows and columns by packing net elements $f_("ℰ"_i)$ with $i = 1$ (rows) or $i = 2$ (columns). For each pair $f_("ℰ"_1) , f_("ℰ"_2)$, let $P_("ℰ"_1 , "ℰ"_2)$ denote the probability of a mix-up between $"ℰ"_1$ and $"ℰ"_2$. Such mix-ups occur if the underlying CPTP map is $"ℰ"_2$, but the quantum ML model outputs an answer $a in "ℱ"_("ℰ"_1)^(upright(Q))$ that belongs to the cluster associated with $"ℰ"_1$:


$ P_("ℰ"_1 , "ℰ"_2) & = sum_(a = 1)^A "tr" ( P_a rho_("ℰ"_2) ) bb(1) ["𝔼"_(x tilde cal(D)) lr(|h_(upright(Q) , a) ( x ) - f_("ℰ"_1) ( x )|)^2 lt.eq epsilon.alt] = sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_1)^Q) "tr" ( P_a rho_("ℰ"_2) ) . $<eq:polynomial-method-P>


Here, $rho_(epsilon.alt_2)$ is the outcome state of the quantum ML model (trained on CPTP map $"ℰ"_2$) and $P_a$ is the POVM element associated with predicting $a_1$. Recall that the main assumption on the quantum ML model is that it predicts accurately with probability at least $2 / 3$. This implies


$ P_("ℰ"_1 , "ℰ"_1) gt.eq 2 / 3 quad upright("for each") quad "ℰ"_1 in M_(4 epsilon.alt)^p ( "ℱ"_f ) , $


while each row sum over off-diagonal matrix elements is strictly smaller. For $f_("ℰ"_2) in M_(4 epsilon.alt)^p ( "ℱ"_f )$,


$ sum_(f_("ℰ"_1) in M_(4 epsilon.alt)^p ( "ℱ"_f )\
f_("ℰ"_1) eq.not f_("ℰ"_2)) P_("ℰ"_1 , "ℰ"_2) & = sum_(f_("ℰ"_1) in M_(4 epsilon.alt)^p ( "ℱ"_f )\
f_("ℰ"_1) eq.not f_("ℰ"_2)) sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_1)^Q) "tr" ( P_a rho_("ℰ"_2) )\
 & = sum_(f_("ℰ"_1) in M_(4 epsilon.alt)^p ( "ℱ"_f )) sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_1)^Q) "tr" ( P_a rho_("ℰ"_2) ) - sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_2)^Q) "tr" ( P_a rho_("ℰ"_2) )\
 & = sum_(a : exists f_("ℰ"_1) in M_(4 epsilon.alt)^p ( "ℱ"_f )\
h_(upright(Q) , a) in cal(F)_("ℰ"_1)^Q) "tr" ( P_a rho_("ℰ"_2) ) - sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_2)^Q) "tr" ( P_a rho_("ℰ"_2) )\
 & lt.eq sum_(a = 1)^A "tr" ( P_a rho_("ℰ"_2) ) - sum_(a : h_(upright(Q) , a) in cal(F)_("ℰ"_2)^Q) "tr" ( P_a rho_("ℰ"_2) )\
 & = 1 - P_("ℰ"_2 , "ℰ"_2) lt.eq 1 / 3 . $


The first equality uses the definition of matrix $P$. The third equality follows from the observation that distinct clusters are also disjoint ($cal(F)_("ℰ"_1)^Q inter cal(F)_("ℰ"_2)^Q = diameter$). We conclude that the $| M_(4 epsilon.alt)^p ( "ℱ"_f ) | times | M_(4 epsilon.alt)^p ( "ℱ"_f ) |$-matrix $P$ is diagonally dominant. Such matrices are guaranteed to be non-singular, i.e.~they have full rank.


This is a suitable starting point for analyzing the probability $"tr" ( P_a rho_("ℰ") )$ via a polynomial method @beals2001quantum. Let ${ K_i^("ℰ") }_(i = 1)^(2^n 2^m)$,


$ "ℰ" ( rho ) = sum_i K_i^("ℰ") rho ( K_i^("ℰ") )^dagger , $


with $K_i^("ℰ") in bb(C)^(2^m times 2^n)$ be the Kraus representation of a fixed CPTP map $"ℰ" in "ℱ"$. This representation is parametrized by (at most) $2^n 2^m times 2^m 2^n = 2^(2 ( n + m ))$ complex parameters:


$ ( K_i^("ℰ") )_(j k) = z_(i times 2^(n + m) + j times 2^n + k)^("ℰ") quad upright("defines") quad z^("ℰ") in bb(C)^(2^(2 ( n + m ))) . $


On a high level, we parametrize inputs to the quantum ML model by vectors. After training, the probability of obtaining answer $a in A$ corresponds to a homogeneous polynomial of degree $N_(upright(Q))$ in $z^("ℰ")$ and of degree $N_(upright(Q))$ in $macron(z)^("ℰ")$:


$ "tr" ( P_a rho_("ℰ") ) & = "tr" ( P_a cal(C)_(N_(upright(Q))) ( "ℰ" ⊗ thin cal(I) ) cal(C)_(N_(upright(Q)) - 1) dots.h cal(C)_2 ( "ℰ" ⊗ thin cal(I) ) cal(C)_1 ( "ℰ" ⊗ thin cal(I) ) cal(C)_0 ( rho_0 ) )\
 & = w_a^dagger underbrace(( z^("ℰ") ⊗ macron(z)^("ℰ") ) ⊗ dots.h.c ⊗ ( z^("ℰ") ⊗ macron(z)^("ℰ")) )_(N_(upright(Q)) upright(" times")) , $


where $w_a^dagger$ is a dual tensor product vector with compatible dimension $N = 2^(2 ( n + m ) 2 N_(upright(Q))) = 2^(4 ( n + m ) N_(upright(Q)))$. Every matrix element $P_(cal(E)_1 , cal(E)_2)$ of $P$ defined in Equation~@eq:polynomial-method-P can be expressed as a sum of homogeneous polynoials in $( z^(cal(E)_2) ⊗ macron(z)^(cal(E)_2) ) ⊗ dots.h.c ⊗ ( z^(cal(E)_2) ⊗ macron(z)^(cal(E)_2) )$. Collecting all $M = | M_(4 epsilon.alt)^p ( "ℱ"_f ) |$ possible tensor products as rows of the matrix


$ Z = mat(delim: "[", ( z^(cal(E)_1) ⊗ macron(z)^(cal(E)_1) ) ⊗ dots.h.c ⊗ ( z^(cal(E)_1) ⊗ macron(z)^(cal(E)_1) ), dots.h.c, ( z^(cal(E)_M) ⊗ macron(z)^(cal(E)_M) ) ⊗ dots.h.c ⊗ ( z^(cal(E)_M) ⊗ macron(z)^(cal(E)_M) )) in bb(C)^(N times M) $


allows us to present the multilinear characterization of all entries of $P$ in a single display:


$ P = W Z quad upright("with") quad W = mat(delim: "[", sum_(h_(upright(Q) , a) in cal(F)_("ℰ"_1)^Q) w_a^dagger; dots.v; sum_(h_(upright(Q) , a) in cal(F)_("ℰ"_M)^Q) w_a^dagger; #none) in bb(C)^(M times 2^N) $


Above, we have shown that the $M times M$-matrix $P$ must have full column rank. This is only possible if


$ | M_(4 epsilon.alt)^p ( "ℱ"_f ) | = M lt.eq N = 2^(2 ( n + m ) 2 N_(upright(Q))) = 2^(4 ( n + m ) N_(upright(Q))) . $


Rearranging these terms and assuming $n lt.eq m$ implies the following lower bound on quantum query complexity $N_(upright(Q))$:


$ N_(upright(Q)) gt.eq frac(log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ), 4 ( n + m )) gt.eq frac(log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ), 8 m) . $


== Information-theoretic upper bound for restricted classical machine learning models
<sec:uppbdCL>


We will focus on restricted classical ML models that can select inputs $x_i in ( 0 , 1 )^n$ and obtain the corresponding outcome $o_i in bb(R)$. This outcome is obtained by performing a single-shot measurement (the projective measurement given by the eigenbasis of $O$) of observable $O$ on the output quantum state $cal(E) ( | x_i chevron.r chevron.l x_i | )$. This ensures


$ "𝔼" [ o_i ] = "tr" ( O cal(E) ( | x_i chevron.r chevron.l x_i | ) = f_("ℰ") ( x_i ) quad upright("and, moreover,") quad lr(|o_i|) lt.eq 1 upright(" with probability one") , $<eq:target-fct-thm1>


because observables are bounded in spectral norm (\$"left""lVertO""right""rVert" less.eq 1\$). By using the obtained training data $( ( x_i , o_i ) )_i$, the restricted classical ML model will produce a prediction model $h_(upright(C)) ( x )$ that allows accurate prediction of $f_("ℰ") ( x ) = "tr" ( O "ℰ" ( | x chevron.r #h(-1em) chevron.l x | ) )$. The restricted classical ML model should provide accurate prediction model for any CPTP map $"ℰ" in "ℱ"$.


=== Classical machine learning model for a given learning problem
<classical-machine-learning-model-for-a-given-learning-problem>


We consider the following classical machine learning model. First, we sample $N$ classical inputs $x_1 , dots.h , x_N$ according to the distribution $cal(D)$. Then, we obtain an associated quantum measurement outcome $o_i$ for each input $x_i$.That is, $o_i$ is a random variable that reproduces the target function in expectation only, see Equation~@eq:target-fct-thm1. We denote the underlying distribution by $cal(D)_o ( O , "ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | ) )$ to delineate dependence on input $x_i$ and CPTP map $"ℰ"$. After obtaining the training data $( ( x_i , o_i ) )_(i = 1)^N$, the model performs the following optimization to minimize the #emph[empirical] training error


$ f_(*) = "arg min"_(f in M_(4 epsilon.alt)^p ( "ℱ"_f )) 1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2 . $<eq:training-step>


Here, $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is the maximal packing net defined in @sec:packnetQ. The packing net is a subset of the set $"ℱ"_f$ that contains functions that are sufficiently different from one another. By "empirical training error" we mean the deviation of the function $f ( x_i )$ from the actual measurement outcome $o_i$, averaged over $N$ data points: $1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2 .$ In the later discussion, we will also refer to the #emph[ideal] training error, meaning the average deviation of the function $f ( x_i )$ from the expectation value $f_("ℰ") ( x_i ) = "tr" ( O "ℰ" ( | x_i chevron.r #h(-1em) chevron.l x_i | ) )$: $1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 .$ This distinction is important; the ideal training error could be close to zero as long as the maximal packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is closely packed, but because of the statistical fluctuation in the quantum measurements, the outcomes ${ o_i }$ can deviate substantially from the expectation value $f_("ℰ") ( x_i )$. Therefore we might not be able to achieve small empirical training error even if $f = f_("ℰ")$.


In the following, we will provide a tight statistical analysis for bounding the prediction error


$ "𝔼"_(x tilde cal(D)) | f_(*) ( x ) - f_("ℰ") ( x ) |^2 . $


The statistical analysis relies crucially on the distance measure used to define the packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$. Recall that this is the average squared distance over the input distribution $cal(D)$, and the statistical fluctuation in performing quantum measurements to obtain $o_i$, see Equation~@eq:epspackingnetdistance. In particular, we will show that a data size of $N = Theta ( log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ) / epsilon.alt )$ suffices to achieve prediction errors of order $cal(O) ( epsilon.alt )$ only.


We find it worthwhile to point out that this scaling is better than one might expect. Standard results in statistical learning theory @bartlett2002rademacher @mohri2018foundations usually yield a data size of order $log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ) / epsilon.alt^2$, which is worse than our result by an additional $1 / epsilon.alt$ factor.


=== Concentration results I: Ideal training error
<concentration-results-i-ideal-training-error>


We begin by considering the concentration of the #emph[ideal] training error for an arbitrary function $f$ from the maximal packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$:


$ 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 , $


which only depends on the inputs $x_1 , dots.h , x_N$ and is independent of the observable measurement outcome $o_i$. We use the quantifier #emph[ideal] because we compare directly with the expectation value $f_("ℰ") ( x_i )$ rather than the measurement outcome $o_i$.


As a first step, view $lr(|f ( x ) - f_("ℰ") ( x )|)^2$ with $x tilde^(cal(D)) (0 , 1)^n$ as a random variable and check that it is bounded: $lr(|f ( x ) - f_("ℰ") ( x )|)^2 lt.eq ( | f ( x ) | + | f_("ℰ") ( x ) | )^2 lt.eq 4$ for all $x in (0 , 1)^n$. This implies the following bound on the variance:


$ "Var" [ | f ( x ) - f_("ℰ") ( x ) |^2 ] lt.eq "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^4 lt.eq 4 "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 . $


We see that the ideal training error as a sum of independent random variables with bounded variance. Bernstein's inequality implies for $t > 0$


$ upright("Pr") [lr(|1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 - "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2|) gt.eq t] lt.eq 2 exp (- 1 / 2 frac(N t^2, 4 "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 + 8 / 3 t)) . $


Assigning $t = 1 / 4 "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2$ allows us to conclude


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 - "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2|) gt.eq 1 / 4 "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2]\
lt.eq & 2 exp (- 3 / 448 N "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2) $


On the other hand, if $"𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 lt.eq 4 epsilon.alt$, we instead assign $t = epsilon.alt$ to obtain


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 - "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2|) gt.eq epsilon.alt] lt.eq 2 exp (- 3 / 112 N epsilon.alt) . $


These two tail bounds (that cover different regimes) and a union bound then imply


$  & upright("Pr") [forall f in M_(4 epsilon.alt)^p ( "ℱ"_f ) , lr(|1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 - "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2|) gt.eq 1 / 4 max (4 epsilon.alt , "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2)]\
lt.eq & 2 sum_(f in M_(4 epsilon.alt)^p ( "ℱ"_f )) exp (- 3 / 448 N max (4 epsilon.alt , "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2)) lt.eq 2 lr(|M_(4 epsilon.alt)^p ( "ℱ"_f )|) exp (- 3 / 112 N epsilon.alt) . $


Intuitively, this can be understood as follows. The functions $f$ close to $f_("ℰ")$ will be distorted by at most $epsilon.alt$, while the functions $f$ that are further away from $f_("ℰ")$ will be distorted by a value proportional to the distance $"𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2$. For $delta in ( 0 , 1 )$ (confidence), we set


$ N gt.eq frac(38 log ( 2 lr(|M_(4 epsilon.alt)^p ( "ℱ"_f )|) / delta ), epsilon.alt) . $<eq:cmlNbound>


\(Throughout this paper, $log$ has base $upright(e)$ unless otherwise indicated.) Then, with probability at least $1 - delta$, we have


$ forall f in M_(4 epsilon.alt)^p ( "ℱ"_f ) , lr(|1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 - "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2|) < 1 / 4 max (4 epsilon.alt , "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2) . $<eq:fluc-f-fcE>


We note that the training data size $N$ in Equation~(@eq:cmlNbound) scales as $1 / epsilon.alt$ rather than $1 / epsilon.alt^2$, an improvement over the standard scaling typically encountered in statistical learning theory @bartlett2002rademacher @mohri2018foundations. The $1 / epsilon.alt^2$ comes naturally when we sample over the different inputs $x_i$ and apply a concentration inequality on the ideal training error $1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2$ to guarantee an $cal(O) ( epsilon.alt )$ statistical fluctuation around the prediction error $"𝔼"_(x tilde "𝒟") | f ( x ) - f_("ℰ") ( x ) |^2$. The main reason for the improved scaling is that any function $f$ with a small prediction error $"𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 lt.eq 4 epsilon.alt$ also has a small variance (e.g., a highly biased coin that almost always come out heads has a variance close to zero, which is much smaller than for an unbiased coin), so we need only $N = cal(O) ( 1 / epsilon.alt )$ to achieve $cal(O) ( epsilon.alt )$ statistical fluctuations. Furthermore, by examining Equation~@eq:fluc-f-fcE, we see that if function $f$ has a large prediction error then the statistical fluctuations in the training data may also be large. This is a price we pay to avoid a training set with size $N$ scaling as $1 / epsilon.alt^2$. The increased statistical fluctuations for a function $f$ with a large prediction error are not problematic, because the statistical fluctuation are still smaller than the prediction error in that case. We find that functions with small prediction error have small ideal training error, while functions with large prediction error have large ideal training error, which is adequate for our purposes.


We condition on the event that the display Equation~(@eq:fluc-f-fcE) holds true and proceed to the second step.


=== Concentration results II: Shifted empirical training error
<concentration-results-ii-shifted-empirical-training-error>


In the second step, we will condition on a set of inputs $x_1 , dots.h , x_N$ and study the concentration of statistical fluctuations in the observable measurement outcome $o_i$. Let us define a new quantity, which we call the #emph[shifted] empirical training error:


$ 1 / N sum_(i = 1)^N [| f ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] , $


where $f$ can be any function in the packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$.


The expectation value of the shifted empirical training error can be computed by means of direct expansion. Use $f_("ℰ") ( x_i ) = "𝔼"_(o tilde cal(D)_o ( O , cal(E) ( | x_i chevron.r chevron.l x_i | ) )) [ o ]$ to rewrite


$ | f ( x_i ) - f_("ℰ") ( x_i ) |^2 = "𝔼"_(o tilde cal(D)_o ( O , cal(E) ( | x_i chevron.r chevron.l x_i | ) )) | f ( x_i ) - o |^2 - | f_("ℰ") ( x_i ) - o |^2 , $


and for fixed input $x_i$, we can also bound the variance:


$ "Var"_(o tilde cal(D)_o ( O , cal(E) ( | x_i chevron.r chevron.l x_i | ) )) | f ( x_i ) - o |^2 - | f_("ℰ") ( x_i ) - o |^2 & = "𝔼"_(o tilde cal(D)_o ( O , cal(E) ( | x_i chevron.r chevron.l x_i | ) )) 4 ( f ( x_i ) - f_("ℰ") ( x_i ) )^2 ( o - f_("ℰ") ( x_i ) )^2\
 & = 4 ( f ( x_i ) - f_("ℰ") ( x_i ) )^2 "Var"_(o tilde cal(D)_o ( O , cal(E) ( | x_i chevron.r chevron.l x_i | ) )) \[ o \]\
 & lt.eq 4 | f ( x_i ) - f_("ℰ") ( x_i ) |^2 . $


The last inequality is contingent on $parallel O parallel lt.eq 1$ which implies $o in [- 1 , 1]$ with probability one.


Now, we apply Bernstein's inequality again. The $o_i$'s are independent, bounded random variables with small variance. So, we obtain


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N [| f ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] - 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2|) gt.eq t]\
lt.eq & 2 exp (- 1 / 2 frac(N t^2, 4 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 + 8 / 3 t)) quad upright("for t >0") . $


Assigning $t = frac(1, 4 N) sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2$ ensures


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N [| f ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] - 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 \]|) gt.eq frac(1, 4 N) sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2]\
lt.eq & 2 exp (- 3 / 448 sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2) . $<eq:foconc-large>


If $1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 lt.eq 4 epsilon.alt$, we instead assign $t = epsilon.alt$ to obtain


$ upright("Pr") [lr(|1 / N sum_(i = 1)^N [| f ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] - 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 ]|) gt.eq epsilon.alt] lt.eq 2 exp (- 3 / 112 N epsilon.alt) . $<eq:foconc-small>


These results are conditioned on $x_1 , dots.h , x_N$ already being sampled (the result of first step) where the event given in Equation~@eq:fluc-f-fcE holds.


=== Prediction error for functions in the maximal packing net
<prediction-error-for-functions-in-the-maximal-packing-net>


Before bounding the prediction error of $f_star.op$ obtained by the restricted classical ML model, we need to show that the following events happen simultaneously with high probability.

- #emph[Event 1:] There exists a function $tilde(f) in M_(4 epsilon.alt)^p ( "ℱ"_f )$ with small prediction error that results in an empirical training error that is upper bounded by a certain threshold. In particular, we will set out to show that $ 1 / N sum_(i = 1)^N | tilde(f) ( x_i ) - o_i |^2 lt.eq 1 / N sum_(i = 1)^N | f_("ℰ") ( x_i ) - o_i |^2 + 25 / 4 epsilon.alt . $<eq:classical-ML-aux2>

- #emph[Event 2:] All functions $f in M_(4 epsilon.alt)^p ( "ℱ"_f )$ that have a large prediction error will result in an empirical training error lower bounded by a certain threshold. In particular, we define the event to be: for all models $f in M_(4 epsilon.alt)^p ( "ℱ"_f )$ such that $"𝔼"_(x tilde D) | f ( x ) - f_("ℰ") ( x ) |^2 gt.eq 12 epsilon.alt$ will have: $ 1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2 gt.eq 1 / N sum_(i = 1)^N | f_("ℰ") ( x_i ) - o_i |^2 + 27 / 4 epsilon.alt . $<eq:classical-ML-aux1>

Then, we can combine these statements to obtain a bound on the prediction error of $f_star.op$. Let us first relate the packing net to another useful concept.


#thmbox("lemma", "Lemma", title: [Maximal packing nets are covering nets])[


For all $f_("ℰ") in "ℱ"_f$, there exists $tilde(f) in M_(4 epsilon.alt)^p ( "ℱ"_f )$, such that


$ "𝔼"_(x tilde D) | f ( x ) - f_("ℰ") ( x ) |^2 lt.eq 4 epsilon.alt . $


] <lem:maxpackingnet>


The proof is standard, see e.g.~@vershynin2018high, and based on contradicting the assumption that $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is a maximal packing net. Since it is short and insightful, we include the full proof for completeness.


#emph[Proof of @lem:maxpackingnet.] If there exists $f_("ℰ") in "ℱ"$, such that for all $tilde(f) in M_(4 epsilon.alt)^p ( "ℱ"_f )$, we have



$ "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 > 4 epsilon.alt , $


then we can add $f_("ℰ")$ into the packing net $M_(4 epsilon.alt)^p ( "ℱ"_f )$. Hence $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is not the maximal packing net.






For Event 1 in Equation~@eq:classical-ML-aux2, we want to show the existence of a function $tilde(f)$ that has a small prediction error as well as an empirical training error upper bounded by a threshold. Because $M_(4 epsilon.alt)^p ( "ℱ"_f )$ is a maximal packing net, using @lem:maxpackingnet, there exists a function $tilde(f)$ such that the prediction error


$ "𝔼"_(x tilde D) | tilde(f) ( x ) - f_("ℰ") ( x ) |^2 lt.eq 4 epsilon.alt . $


We now condition on Equation~@eq:fluc-f-fcE being true, which happens with probability at least $1 - delta$. Therefore, we have the following bound on the ideal training error


$ 1 / N sum_(i = 1)^N | tilde(f) ( x_i ) - f_("ℰ") ( x_i ) |^2 lt.eq 5 epsilon.alt . $<eq:emppredicerr-5-4>


We can now use this insight to control the shifted empirical training error. Use a combination of Eqs.~@eq:foconc-large~and~@eq:foconc-small to conclude


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N [| tilde(f) ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] - 1 / N sum_(i = 1)^N | tilde(f) ( x_i ) - f_("ℰ") ( x_i ) |^2 \]|) gt.eq 5 / 4 epsilon.alt]\
lt.eq & 2 exp (- 3 / 112 N epsilon.alt) lt.eq frac(delta, | M_(4 epsilon.alt)^p ( "ℱ"_f ) |) . $


The first inequality comes from separately analyzing the two cases: $1 / N sum_(i = 1)^N | tilde(f) ( x_i ) - f_("ℰ") ( x_i ) |^2 lt.eq 4 epsilon.alt$ or $4 epsilon.alt < 1 / N sum_(i = 1)^N | tilde(f) ( x_i ) - f_("ℰ") ( x_i ) |^2 lt.eq 5 epsilon.alt$, then take the looser statement. The second inequality arises from inserting the (lower bound) on training data size $N$ from Equation~@eq:cmlNbound. Therefore, if the display from Equation~@eq:fluc-f-fcE is true (which happens with probability at least $1 - delta$), then


$ frac(1, N) sum_(i = 1)^N |tilde(f) ( x_i ) - o_i|^2 & lt.eq frac(1, N) sum_(i = 1)^N |f_(cal(E)) ( x_i ) - o_i|^2 + frac(1, N) sum_(i = 1)^N |tilde(f) ( x_i ) - f_(cal(E)) ( x_i )|^2 + frac(5, 4) epsilon.alt \
 & lt.eq frac(1, N) sum_(i = 1)^N |f_(cal(E)) ( x_i ) - o_i|^2 + frac(25, 4) epsilon.alt quad "with probability at least " 1 - delta / |M_(4 epsilon.alt)^p (cal(F)_f)| . $


The second inequality is contingent on using Equation~@eq:emppredicerr-5-4. This is Event $1$ that we have set out to establish. And it is guaranteed to happen with high probability.


We now move on to Event $2$ given in Equation~@eq:classical-ML-aux1. For any $f in M_(4 epsilon.alt)^p ( "ℱ"_f )$ with a large prediction error


$ "𝔼"_(x tilde D) | f ( x ) - f_("ℰ") ( x ) |^2 gt.eq 12 epsilon.alt , $


we want to show that the training error $1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2$ will also be large. We again condition on the event displayed by Equation~@eq:fluc-f-fcE (which happens with probability at least $1 - delta$). This relation implies the following bound on the ideal training error


$ 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 gt.eq 3 / 4 "𝔼"_(x tilde D) | f ( x ) - f_("ℰ") ( x ) |^2 gt.eq 9 epsilon.alt . $


Using the concentration result from Equation~@eq:foconc-large, we have


$  & upright("Pr") [lr(|1 / N sum_(i = 1)^N [| f ( x_i ) - o_i |^2 - | f_("ℰ") ( x_i ) - o_i |^2] - 1 / N sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2 \]|) gt.eq frac(1, 4 N) sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2]\
 & lt.eq 2 exp (- 3 / 448 sum_(i = 1)^N | f ( x_i ) - f_("ℰ") ( x_i ) |^2) lt.eq 2 exp (- 3 / 448 N (9 epsilon.alt)) lt.eq frac(delta, | M_(4 epsilon.alt)^p ( "ℱ"_f ) |) . $


The last inequality uses the training data size bound from Equation~@eq:cmlNbound. This ensures


$ frac(1, N) sum_(i = 1)^N |f ( x_i ) - o_i|^2 & gt.eq frac(1, N) sum_(i = 1)^N |f_(cal(E)) ( x_i ) - o_i|^2 + frac(3, 4) frac(1, N) sum_(i = 1)^N |f ( x_i ) - f_(cal(E)) ( x_i )|^2 \
 & gt.eq frac(1, N) sum_(i = 1)^N |f_(cal(E)) ( x_i ) - o_i|^2 + frac(9, 16) "𝔼"_(x tilde D) |f ( x ) - f_(cal(E)) ( x )|^2 \
 & gt.eq frac(1, N) sum_(i = 1)^N |f_(cal(E)) ( x_i ) - o_i|^2 + frac(27, 4) epsilon.alt quad "with probability at least " 1 - delta / |M_(4 epsilon.alt)^p (cal(F)_f)| . $


We can combine these insights by applying union bound to obtain that all the desired events given in Equation~@eq:classical-ML-aux2~and~@eq:classical-ML-aux1 happen simultaneously with probability at least $1 - delta$ if we condition on Equation~@eq:fluc-f-fcE to be true. Furthermore, because the event in display~@eq:fluc-f-fcE happens with probability $1 - delta$, we can guarantee that the the desired events given in Equation~@eq:classical-ML-aux2~and~@eq:classical-ML-aux1 happen simultaneously with a probability at least $( 1 - delta )^2 gt.eq 1 - 2 delta$. This statement uses the following basic fact from elementary probability theory: Let $p ( A | B )$ be the probability of event $A$ when we condition on event $B$. And let $p ( B )$ be the probability of event $B$. Then the probability of event $A$, $p ( A )$, is larger or equal to the probability that $A , B$ both happens, $p ( A , B ) = p ( A | B ) p ( B )$.


To conclude, we have shown that using a training data of size $N gt.eq 38 log ( 2 lr(|M_(4 epsilon.alt)^p ( "ℱ"_f )|) / delta ) / epsilon.alt$ guarantees that the relations given in Equation~@eq:classical-ML-aux2~and~@eq:classical-ML-aux1 happen with probability at least $1 - 2 delta$. ◻


=== Prediction error for functions produced by restricted classical ML
<prediction-error-for-functions-produced-by-restricted-classical-ml>


Let us choose a data of size $N gt.eq 38 log ( 4 lr(|M_(4 epsilon.alt)^p ( "ℱ"_f )|) / delta ) / epsilon.alt$ such that the two relations in Equation~@eq:classical-ML-aux2~and~@eq:classical-ML-aux1 are both true with probability $1 - delta$. We now combine these with two other concepts from the previous subsections. Let $f_("ℰ") ( x )$ be the actual target function and recall that (at least) one packing net element $tilde(f) in M_(4 epsilon.alt)^p ( "ℱ"_f )$ is guaranteed to be close ($"𝔼"_(x tilde cal(D)) | tilde(f) ( x ) - f_("ℰ") ( x ) |^2 lt.eq 4 epsilon.alt$ according to @lem:maxpackingnet). The restricted classical ML model tries to identify such a packing net element by minimizing the empirical training error: $f_(*) = "arg min"_(f in M_(4 epsilon.alt)^p ( "ℱ"_f )) 1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2$ according to Equation~@eq:training-step. This setup ensures


$ 1 / N sum_(i = 1)^N | f_(*) ( x_i ) - o_i |^2 = min_(f in M_(4 epsilon.alt)^p ( "ℱ"_f )) 1 / N sum_(i = 1)^N | f ( x_i ) - o_i |^2 lt.eq 1 / N sum_(i = 1)^n lr(|tilde(f) ( x_i ) - o_i|)^2 . $


The first relation in Equation~@eq:classical-ML-aux2 allows us to take it from there. Indeed,


$ 1 / N sum_(i = 1)^n lr(|tilde(f) ( x_i ) - o_i|)^2 lt.eq 1 / N sum_(i = 1)^N | f_("ℰ") ( x_i ) - o_i |^2 + 25 / 4 epsilon.alt < 1 / N sum_(i = 1)^N | f_("ℰ") ( x_i ) - o_i |^2 + 27 / 4 epsilon.alt , $


where the strict inequality is completely trivial. Apply the second relation in Equation~@eq:classical-ML-aux1 to complete the chain of arguments:


$ 1 / N sum_(i = 1)^N | f_(*) ( x_i ) - o_i |^2 < min_(f in M_(4 epsilon.alt)^p ( "ℱ"_f ) : #h(0em) "𝔼"_(x tilde cal(D)) | f ( x ) - f_("ℰ") ( x ) |^2 gt.eq 12 epsilon.alt) 1 / N sum_(i = 1)^N lr(|f ( x_i ) - o_i|)^2 . $


In words, this display implies that the empirical training error achieved by $f_(*)$ -- the output of the restricted classical ML model -- is strictly smaller than any empirical training error that could be achieved by any packing net function that has a comparatively large prediction error (at least $12 epsilon.alt$). Therefore if $f_(*)$ has a prediction error of at least $12 epsilon.alt$, then this leads to a contradiction that $1 / N sum_(i = 1)^N | f_(*) ( x_i ) - o_i |^2 < 1 / N sum_(i = 1)^N | f_(*) ( x_i ) - o_i |^2$. By contradiction, this claim implies that the prediction error achieved by $f_(*)$ cannot be too bad.


#thmbox("proposition", "Proposition")[


Let $f_(*) : (0 , 1)^n arrow.r bb(R)$ be the packing net element that minimizes the empirical training error in Equation~@eq:training-step. Then, for $delta in ( 0 , 1 )$, training data of size $N gt.eq 38 log ( 4 lr(|M_(4 epsilon.alt)^p ( "ℱ"_f )|) / delta ) / epsilon.alt$ implies:


$ "𝔼"_(x tilde cal(D)) |f^* ( x ) - f_(cal(E)) ( x )|^2 < 12 epsilon.alt quad "with probability at least " 1 - delta . $


] <prop:uppbdcml>


== Combining the upper and lower bound
<sec:combineCLQU>


If a quantum ML model produces a prediction $h_(upright(Q))$ achieving average prediction error


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(Q)) ( x ) - "tr" ( O cal(E) ( | x chevron.r chevron.l x | ) )|)^2 lt.eq epsilon.alt , $


with probability at least $2 / 3$ for any CPTP map $cal(E) in "ℱ"$, then, as proven in Equation~@eq:NQlowerbound, the quantum ML must access the map $"ℰ"$ at least $N_(upright(Q))$ times, where


$ N_(upright(Q)) = Omega (frac(log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ), m)) . $


On the other hand, from @prop:uppbdcml, we know there is a restricted classical ML model producing prediction $h_(upright(C))$ achieving average prediction error


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - "tr" ( O cal(E) ( | x chevron.r chevron.l x | ) )|)^2 lt.eq 12 epsilon.alt = cal(O) ( epsilon.alt ) , $


with high probability for any CPTP map $"ℰ" in "ℱ"$, such that the restricted classical ML accesses the map $N_(upright(C))$ times, where


$ N_(upright(C)) = cal(O) (frac(log ( | M_(4 epsilon.alt)^p ( "ℱ"_f ) | ), epsilon.alt)) = cal(O) (frac(m N_(upright(Q)), epsilon.alt)) . $


This concludes the proof of @thm:noadvquantum.


= Examples saturating the maximum information-theoretic advantage
<sec:satnoadv>


#thmbox("proposition", "Proposition")[


For any $epsilon.alt in ( 0 , 1 / 3 )$, and positive integer $m$, there exists a learning problem @eq:target-function -- specified by an $m$-qubit observable $O$, a set $cal(F)$ of CPTP maps and a distribution $cal(D)$ on $n$-bit inputs, where $n = m - 1$, -- with the following property:


Any restricted classical ML model that can learn a function $h_(upright(C)) ( x )$ that achieves


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - "tr" ( O cal(E) ( | x chevron.r #h(-1em) chevron.l x | ) )|)^2 lt.eq epsilon.alt , $


must use classical training data of size $N_(upright(C)) = Omega ( m N_(upright(Q)) / epsilon.alt )$, where $N_(upright(Q))$ is the number of queries in the best quantum ML model.


] <prop:noadvquantum-appendix>


This statement follows from constructing a stylized learning problem that admits the largest possible separation (albeit only a small polynomial factor). We first introduce the problem and discuss quantum and classical strategies (and their limitations) afterwards. We will focus on restricted classical ML models, because @thm:noadvquantum also considers restricted classical ML models. We leave open the question of whether the separation between unrestricted classical ML and quantum ML is tight or not.


==== Learning problem formulation
<learning-problem-formulation>
Fix $epsilon.alt in ( 0 , 1 / 3 )$, let $m$ be the integer in the statement of Proposition @prop:noadvquantum-appendix and set $n = m - 1$.


We consider a set of CPTP maps $cal(F) = {cal(E)_a : #h(0em) a in (0 , 1)^n}$ containing $2^n$ elements, where each map in the set takes an $n$-qubit input to an $( n + 1 )$-qubit output. The map $cal(E)_a$, labeled by bit string $a in (0 , 1)^n$, is comprised of $2 times 2^n$ Kraus operators: $ "mathcal"{E}_(a)(rho)
= sum_(z in 0,1"right"\)^(n)}
sum_(i=1)^2 K^(z,i)_(a)rho (K^(z,i)_(a))^"dagger"
  upright("with")   cases(
    K_a^(z , 1) = & sqrt(frac(1 + sqrt(3 epsilon.alt), 2)) ( I ⊗ I^(⊗ n) ) | a ⊙ z , a chevron.r chevron.l z | ,,
    K_a^(z , 2) = & sqrt(frac(1 - sqrt(3 epsilon.alt), 2)) ( X ⊗ I^(⊗ n) ) | a ⊙ z & a chevron.r chevron.l z | .
  ) $<eq:function-class> Here, $X$ is a single-qubit bit flip and $a ⊙ z in (0 , 1)$ denotes the inner product of bit-strings in $bb(Z)_2$. We also choose the $( n + 1 )$-qubit observable $O = Z ⊗ I^(⊗ n)$, i.e.~we measure the first qubit in the $Z$-basis and trace out the rest of the system. By construction, the resulting function admits a closed-form expression:


$ f_a ( x ) = "tr" (O "ℰ"_a ( | x chevron.r #h(-1em) chevron.l x | )) = sqrt(3 epsilon.alt) (1 - 2 a ⊙ x) . $<eq:closed-form-expression>


We consider $"𝒟"$ to be the uniform distribution over the $n$-bit inputs.


==== Upper bound on the quantum query complexity
<upper-bound-on-the-quantum-query-complexity>


The above learning problem is easy to solve in the quantum realm. Since the set of CPTP maps $cal(F) = {cal(E)_a : #h(0em) a in (0 , 1)^n}$ is known, it suffices to extract the label $a in (0 , 1)^n$ of the underlying CPTP map. Once $a$ is known, the closed-form expression~@eq:closed-form-expression allows to predict future function values $f_a ( x )$ efficiently with perfect accuracy -- regardless of the input $x in (0 , 1)^n$.


Quantum computers are well equipped to extract the label $a$. In fact, a single query of the unknown CPTP map $cal(E)_a$ suffices to extract the label by executing the following simple procedure:

+ prepare the all-zero state on $n$ qubits: $rho_0 = | 0 , dots.h , 0 chevron.r chevron.l 0 , dots.h , 0 |$\;

+ query $cal(E)$ and apply it to $rho_0$: $rho_1 = 1 / 2 ( I + sqrt(3 epsilon.alt) Z ) ⊗ | a chevron.r chevron.l a |$, according to Equation~@eq:function-class\;

+ throw away (trace out) the first qubit to obtain the $n$ remaining ones: $rho_2 = | a chevron.r chevron.l a |$\;

+ perform a computational basis measurement to extact $a in (0 , 1)^n$ with probability one.

We see that a single quantum query ($N_(upright(Q)) = 1$) suffices to extract the label $a$ with certainty. Subsequently, we can make efficient and perfect predictions via the closed-form expression~@eq:closed-form-expression:


$ bb(E)_(x tilde cal(D)) lr(|h_(upright(Q)) ( x ) - "tr" (O "ℰ"_a ( | x chevron.r #h(-1em) chevron.l x | ))|)^2 = 0 lt.eq epsilon.alt quad arrow.l.double quad N_(upright(Q)) = 1 . $<eq:explicit-quantum-bound>


In words, $N_(upright(Q)) = 1$ allows for training a quantum ML model $h_(upright(Q)) ( x )$ that achieves zero prediction error for all input distributions (perfect prediction). This concrete ML model is also optimal, because $N_(upright(Q)) = 1$ is the smallest number of queries conceivable ($N_(upright(Q)) = 0$ would not reveal any information about the underlying CPTP map).


==== Lower bound on the classical query complexity
<lower-bound-on-the-classical-query-complexity>


Let us now turn to potential classical strategies for solving the above learning problem. In contrast to the previous paragraph, we will not construct an explicit strategy. Instead, we will use ideas similar to #ref(<sec:MIanalysisML>, supplement: [Appendix]) to establish a fundamental lower bound.


Recall that the input distribution $"𝒟"$ is taken to be the uniform distribution. Also, for each $"ℰ"_a in "ℱ"$, the underlying function $f_a ( x ) = "tr" (O cal(E)_a ( | x chevron.r #h(-1em) chevron.l x | ))$ admits a closed form expression, see Equation~@eq:closed-form-expression. For $a , b in (0 , 1)^n$,


$ "𝔼"_(x tilde cal(D)) lr(|f_a ( x ) - f_b ( x )|)^2 = & 1 / 2^n sum_(x in (0 , 1)^n) lr(|sqrt(3 epsilon.alt) 2 ( a - b ) ⊙ x|)^2 = cases(delim: "{", 0 & upright("if a=b") ,, 6 epsilon.alt & upright("else") ,) $


because $2^(- n) sum_(x in (0 , 1)^n) lr(|c ⊙ x|)^2 = 1 / 2$ for all $n$-bit strings $c eq.not ( 0 , dots.h , 0 )$. Now, suppose that a restricted classical ML model can utilize training data $cal(T) = (( x_i , o_i ))_(i = 1)^(N_(upright(C)))$ to learn a function $h_(upright(C)) ( x )$ that obeys $"𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - "tr" (O "ℰ"_a ( | x chevron.r #h(-1em) chevron.l x | ))|)^2 lt.eq epsilon.alt$ with high probability for any label $a in (0 , 1)^n$. Then, this model would also allow us to identify the underlying label. Indeed $"𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - f_b|)^2 lt.eq epsilon.alt$ if $b = a$, while for $b eq.not a$, by the triangle inequality,


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - f_b ( x )|)^2 gt.eq ( sqrt("𝔼"_(x tilde cal(D)) lr(|f_a ( x ) - f_b ( x )|)^2) - sqrt("𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - f_a ( x )|)^2) )^2 gt.eq (sqrt(6 epsilon.alt) - sqrt(epsilon.alt))^2 > epsilon.alt . $<eq:triangle-distinguish>


By checking $"𝔼"_(x tilde D) lr(|h_(upright(C)) ( x ) - f_b ( x )|)^2 lt.eq epsilon.alt$ for every possible value $b in (0 , 1)^n$, the restricted classical ML model allows us to recover the underlying bit-string label $a in (0 , 1)^n$ with high probability. For this part of the argument, what's essential is that the right-hand-side of the inequality Equation~(@eq:triangle-distinguish) is greater than $epsilon.alt$. If we replace $3 epsilon.alt$ in Equation~(@eq:function-class) by $alpha epsilon.alt$, where $alpha$ is a constant, we require $sqrt(2 alpha) - 1 > 1$, or $alpha > 2$. We chose $alpha = 3$ merely for convenience.


For any random hidden bitstring $a in ( 0 , 1 )^n$, we can use the restricted classical ML to obtain the training data $( ( x_i , o_i ) )_(i = 1)^(N_(upright(C)))$ and determine the underlying bitstring $a$. We assume that the restricted classical ML first query $x_1$ obtains $o_1$, then query $x_2$ obtains $o_2$, and so on. We also have $ o_i = cases(
    + 1 & upright("with probability ") p_(+) = 1 / 2 ( 1 + sqrt(3 epsilon.alt) ( 1 - 2 a ⊙ x_i ) ) ,,
    - 1 & upright("with probability ") p_(-) = 1 / 2 ( 1 - sqrt(3 epsilon.alt) ( 1 - 2 a ⊙ x_i ) ) ,
  ) $<eq:measurement-outcome> which is a single-shot outcome for measuring the observable $O$ on the state $"ℰ"_a ( | x_i chevron.r #h(-1em) chevron.l x_i | )$ in the eigenbasis of $O = Z ⊗ I^(⊗ n)$. Because we can use the training data $( ( x_i , o_i ) )_(i = 1)^(N_(upright(C)))$ to determine $a$ with high probability (by the assumption of the restricted classical ML model), Fano's inequality and the data processing inequality then imply a bound on the mutual information between the training data and the CPTP map label $a$:


$ I ( a : (( x_i , o_i ))_(i = 1)^(N_(upright(C))) ) = Omega ( n ) . $<eq:classical-aux1>


Next, using chain rule of mutual information based on conditional mutual information, we have


$ I ( a : (( x_i , o_i ))_(i = 1)^(N_(upright(C))) ) = sum_(i = 1)^(N_(upright(C))) I ( a : ( x_i , o_i ) | ( ( x_j , o_j ) )_(j = 1)^(i - 1) ) = sum_(i = 1)^(N_(upright(C))) I ( a : o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) . $<eq:classical-aux2>


The second equality follows from the fact that $x_i$ is chosen by the restricted classical ML using only the information of $( ( x_j , o_j ) )_(j = 1)^(i - 1)$, hence the input $x_i$ does not provide any additional information about $a$, i.e., $I ( a : x_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) ) = 0$. We now upper bound each term:


$ I ( a : o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) = H ( o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) - H ( o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i , a ) $


Because $o_i$ is a two-outcome random variable, $H ( o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) lt.eq H ( o_i ) lt.eq log_2 ( 2 ) = 1$. We now consider the distribution of $o_i$ when we condition on $( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i , a$. A closer inspection of Equation~@eq:measurement-outcome reveals that the probability of one outcome is $p = 1 / 2 (1 + sqrt(3 epsilon.alt))$ and the other is $1 - p$ (the value $a ⊙ x_i in (0 , 1)$ only ever permutes the outcome sign). This ensures


$ H ( o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i , a ) = - p log_2 ( p ) - ( 1 - p ) log_2 ( 1 - p ) gt.eq log_2 ( 2 ) - ( 2 p - 1 )^2 , $


and we conclude


$ I ( a : o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) lt.eq ( 2 p - 1 )^2 = 3 epsilon.alt . $<eq:classical-aux3>


Finally, we combine Eqs.~@eq:classical-aux1, @eq:classical-aux2 and @eq:classical-aux3 to conclude


$ Omega ( n ) lt.eq I ( a : (( x_i , o_i ))_(i = 1)^(N_(upright(C))) ) lt.eq sum_(i = 1)^(N_(upright(C))) I ( a : o_i | ( ( x_j , o_j ) )_(j = 1)^(i - 1) , x_i ) lt.eq 3 epsilon.alt N_(upright(C)) . $


Therefore, recalling that the output size of our set of maps is $m = n + 1$, we have for a restricted classical ML model with small average prediction error:


$ "𝔼"_(x tilde cal(D)) lr(|h_(upright(C)) ( x ) - "tr" (O "ℰ"_a ( | x chevron.r #h(-1em) chevron.l x | ))|)^2 lt.eq epsilon.alt quad upright("with high probability") quad arrow.r.double quad N_(upright(C)) = Omega (m / epsilon.alt) . $


@prop:noadvquantum-appendix follows from combining this assertion with the fact that the underlying learning problem does admit a perfect quantum solution with $N_(upright(Q)) = 1$, see Equation~@eq:explicit-quantum-bound.


= Exponential separation for predicting expectation values of Pauli operators
<app:exp-sep-Pauli>


In this section, we consider an example to demonstrate the existence of exponential information-theoretic quantum advantage when we want to achieve small worst-case prediction error.


== Task description
<sec:exp-task-desc>


The learning task is to train an ML model that allows accurate prediction of


$ x in ( I , X , Y , Z )^n arrow.r "tr" ( P_x rho ) , $


where $rho$ is an unknown $n$-qubit state, $X , Y , Z$ are the single-qubit Pauli operators, and $P_x$ is the tensor product of Pauli operators given by $x$. This task does fit into the framework described in the main text. Every unknown quantum state $rho$ defines an unknown quantum channel $"ℰ"_rho$. The unknown quantum channel $"ℰ"_rho$ takes a classical input $x in ( I , X , Y , Z )^n$, prepares the unknown quantum state $rho$, and rotates the quantum state $rho$ according to the input $x$ such that a Pauli-Z measurement on the first qubit is equivalent to measuring $P_x$ on $rho$. More precisely, we define


$ "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l y | ) = delta_(x , y) C_x^dagger rho C_x , $


where $| x chevron.r$ is an encoding of the classical input $x$ (e.g., as a $2 n$-qubit computational basis state), $C_x$ is a Clifford unitary that satisfies


$ C_x Z_1 C_x^dagger = P_x . $


We can extend this definition linearly to all of quantum state space.


The goal of the machine learning model is to produce $f ( x )$ such that


$ max_(x in ( I , X , Y , Z )^n) lr(|f ( x ) - "tr" ( Z_1 "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) )|) lt.eq epsilon.alt . $


We consider restricted classical ML models that can only obtain $( ( x_i , o_i ) )$, where $x_i$ are inputs denoting the Pauli operators, and $o_i$ are measurement outcome when measuring $"ℰ"_rho ( | x_i chevron.r #h(-1em) chevron.l x_i | )$ with $Z_1$, which is equivalent to the measurement outcome of measuring $rho$ with $P_(x_i)$. Classical ML models can obtain $( ( x_i , o_i ) )$, where $o_i$ is now the measurement outcome of an arbitrary POVM on the output state $"ℰ"_rho ( | x_i chevron.r #h(-1em) chevron.l x_i | )$. Note that for restricted classical ML, $o_i in bb(R)$, but for classical ML, $o_i$ is in the set indexing the POVM elements ${ F_o }_o$ with $sum_o F_o = I$. Quantum ML models can access the unknown quantum channel $"ℰ"_rho$ at will. Recall that, according to @thm:noadvquantum, for achieving a small average prediction error according to any input distribution, no large quantum advantage in sample complexity can be found.


In the following, we will show that to achieve a small worst-case prediction error, an exponential quantum advantage in sample complexity is possible. In @sec:pauli-qml, we give a simple quantum ML algorithm that can accurately predict the expectation values of all $4^n$ Pauli observables using only $cal(O) ( n )$ samples. In @sec:lowbd-cml-pauli~and~@sec:lowerboundindmeas, we will show that any classical ML algorithm requires at least an exponential number of samples to accurately predict the expectation values of all $4^n$ Pauli observables. In @sec:lowerboundentangled, we will give a matching lower bound $Omega ( n )$ for quantum ML.


== Sample complexity of a quantum ML algorithm
<sec:pauli-qml>


The quantum ML algorithm accesses the quantum channel $"ℰ"_rho$ multiple times to obtain multiple copies of the underlying quantum state $rho$. Each access to $"ℰ"_rho$ allows us to obtain one copy of $rho$. Then, the quantum ML algorithm performs a sequence of measurements on the copies of $rho$ to accurately predict $"tr" ( P_x rho )$ for all $x in ( I , X , Y , Z )^n$. To this end, we will give a detailed proof for @thm:sampPauliQ given below. From @thm:sampPauliQ, we only need $cal(O) ( log ( 100 times 4^n ) / epsilon.alt^4 ) = cal(O) ( n / epsilon.alt^4 )$ copies to accurately predict all $4^n$ Pauli operators with probability at least $0.99$. Hence we only need to access the quantum channel $"ℰ"_rho$ for $cal(O) ( n / epsilon.alt^4 )$ times.


#thmbox("theorem", "Theorem")[


For any $M$ Pauli operators $P_1 , dots.h , P_M$, there is a procedure that produces $hat(p)_1 , dots.h , hat(p)_M$ with


$ lr(|hat(p)_i - "tr" ( P_i rho )|) lt.eq epsilon.alt , thin thin forall i = 1 , dots.h , M , $


under probability at least $1 - delta$ by performing POVM measurements on


$ N = cal(O) (frac(log ( M / delta ), epsilon.alt^4)) $


copies of the unknown quantum state $rho$.


] <thm:sampPauliQ>


The procedure takes in the Pauli operators one by one and produces the estimate $hat(p)_i$ sequentially. Throughout the prediction process, the procedure maintains two blocks of memory:

+ Classical memory: We perform $N_1$ repetitions of Bell measurements on two copies of the quantum state $rho ⊗ rho$. For repetition $t$, we go through every qubit, and measure the $k$-th qubit from the first and second copies in the Bell basis to obtain: $ S_k^(( t )) in ( | Psi^(+) chevron.r #h(-1em) chevron.l Psi^(+) | , | Psi^(-) chevron.r #h(-1em) chevron.l Psi^(-) | , | Phi^(+) chevron.r #h(-1em) chevron.l Phi^(+) | , | Phi^(-) chevron.r #h(-1em) chevron.l Phi^(-) | ) , $<eq:Bell-basis-meas> where the Bell basis encompasses four maximally entangled 2-qubit states. Set $| Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r + | 11 chevron.r)$ (Bell state) and define $ | Psi^(+) chevron.r & = I ⊗ I | Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r + | 11 chevron.r) ,\
  | Psi^(-) chevron.r & = I ⊗ Z | Omega chevron.r = 1 / sqrt(2) (| 00 chevron.r - | 11 chevron.r) ,\
  | Phi^(+) chevron.r & = I ⊗ X | Omega chevron.r = 1 / sqrt(2) (| 01 chevron.r + | 10 chevron.r) ,\
  | Phi^(-) chevron.r & = upright(i) I ⊗ Y | Omega chevron.r = 1 / sqrt(2) (| 01 chevron.r - | 10 chevron.r) . $ We then efficiently store the measurement data $S_k^(( t )) , forall k = 1 , dots.h , n , forall t = 1 , dots.h , N_1$ in a classical memory with $2 n N_1$ bits. We use this block of memory to estimate $| "tr" ( P rho ) |^2$ for any Pauli operator $P$.

+ Quantum memory: We store $N_2$ copies of the unknown quantum state $rho$. We use this block of memory to estimate $"sign" ( "tr" ( P rho ) )$ for any Pauli operator $P$.


Consider any tensor product of Pauli operators $P = sigma_1 ⊗ dots.h ⊗ sigma_n$, where $sigma_k in ( I , X , Y , Z ) , forall k = 1 , dots.h , n$. The classical memory is used to predict the absolute value of $"tr" ( P rho )$, while the quantum memory is used to predict the sign of $"tr" ( P rho )$. This allows us to obtain an accurate estimate for $"tr" ( P rho )$. The following remark is central to the procedure.


#thmbox("remark", "Remark")[


If we find that the absolute value of $"tr" ( P rho )$ is close to zero, then we need not use the quantum memory to predict the sign of $"tr" ( P rho )$. By measuring the sign only for the Pauli observables such that the absolute value of the expectation value is appreciable, we can find the sign for may Pauli observables without badly disturbing the copies of $rho$ stored in the quantum memory.


]


We proceed to give a detailed procedure for estimating the absolute value and the sign of $"tr" ( P_i rho )$.


=== Measuring absolute values
<measuring-absolute-values>


To understand how the absolute value of the expectation of a Pauli operator is estimated, first consider the case where $rho$ is the density operator of a single qubit, and suppose that $rho ⊗ rho$ is measured in the Bell basis. The outcome $S$ is the projector onto one of the four Bell states, as in Equation~(@eq:Bell-basis-meas). If $sigma in ( I , X , Y , Z )$ is any Pauli matrix, then each Bell state is an eigenstate of $sigma ⊗ sigma$ with eigenvalue $plus.minus 1$. In the state $S$, the $+ 1$ eigenvalue of $sigma ⊗ sigma$ occurs with probability $upright("Prob") ( + ) = 1 / 2 "tr" (( I ⊗ I + sigma ⊗ sigma ) ( rho ⊗ rho ))$, and the $- 1$ eigenvalue occurs with probability $upright("Prob") ( - ) = 1 / 2 "tr" (( I ⊗ I - sigma ⊗ sigma ) ( rho ⊗ rho ))$. Therefore,


$ "𝔼" ["tr" (( sigma ⊗ sigma ) S)] = upright("Prob") ( + ) - upright("Prob") ( - ) = "tr" (( sigma ⊗ sigma ) ( rho ⊗ rho )) = | "tr" ( sigma rho ) |^2 , $


This observation can be generalized to the case where $rho$ is an $n$-qubit state, and each pair of qubits in $rho ⊗ rho$ is measured in the Bell basis, yielding the outcomes $( S_k , k = 1 , 2 , dots.h , n )$. If $P = sigma_1 ⊗ dots.h ⊗ sigma_n$ is a Pauli observable, then $S_k$ is an eigenstate of $sigma_k ⊗ sigma_k$ with eigenvalue $plus.minus 1$ for each $k$, just as in the $n = 1$ case; in particular,


$ product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k) = plus.minus 1 . $


This product is $+ 1$ when $⊗_(k = 1)^n S_k$ is an eigenstate of $P ⊗ P$ with eigenvalue $+ 1$, and it is $- 1$ when $⊗_(k = 1)^n S_k$ is an eigenstate of $P ⊗ P$ with eigenvalue $- 1$. Therefore,


$  & "𝔼" [product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k)] = "𝔼" ["tr" (( P ⊗ P ) ⨂_(k = 1)^n S_k)]\
 & = upright("Prob") ( P ⊗ P = + 1 ) - upright("Prob") ( P ⊗ P = - 1 ) = "tr" (( P ⊗ P ) ( rho ⊗ rho )) = | "tr" ( P rho ) |^2 . $<eq:bell-expected>


Because Equation~(@eq:bell-expected) relates the distribution of Bell measurement outcomes to $| "tr" ( P rho ) |$, we can estimate $| "tr" ( P rho ) |$ accurately by repeating Bell measurement on $rho ⊗ rho$ sufficiently many times. Suppose we have altogether $2 N_1$ copies of $rho$, and perform the Bell measurement on $N_1$ pairs of copies. We collect the measurement data ${ S_k^(( t )) }$ in the classical memory, where $k = 1 , 2 , dots.h n$ labels the qubit pairs, and $t = 1 , 2 , dots.h N_1$ labels the repeated measurements.


For each Pauli observable $P = sigma_1 ⊗ dots.h ⊗ sigma_n$, we define the corresponding expression


$ hat(a) ( P ) = 1 / N_1 sum_(t = 1)^(N_1) product_(k = 1)^n "tr" (( sigma_k ⊗ sigma_k ) S_k^(( t ))) , $


which can be computed efficiently in time $cal(O) ( n N_1 )$.


Using the statistical property given in Equation~(@eq:bell-expected), we can apply Hoeffding's inequality to show that, with high probability, the estimate $hat(a) ( P )$ is close to the expectation value $| "tr" ( P rho ) |^2$:


#thmbox("lemma", "Lemma")[


Given $N_1 = Theta ( log ( 1 / delta ) / epsilon.alt^2 )$. For any Pauli operator $P$, we have


$ lr(|hat(a) ( P ) - | "tr" ( P rho ) |^2|) lt.eq epsilon.alt , $


with probability at least $1 - delta$.


] <lem:hoeffPauli>


To obtain an estimate for the absolute value $| "tr" ( P rho ) |$, we consider the following estimate


$ hat(b) = sqrt(max ( 0 , hat(a) )) . $


It is not hard to show the following implication using $sqrt(x + y) lt.eq sqrt(x) + sqrt(y)$,


$ | "tr" ( P rho ) |^2 - epsilon.alt lt.eq hat(a) lt.eq | "tr" ( P rho ) |^2 + epsilon.alt arrow.r.double.long max ( 0 , sqrt(| "tr" ( P rho ) |^2) - sqrt(epsilon.alt) ) lt.eq hat(b) lt.eq sqrt(| "tr" ( P rho ) |^2) + sqrt(epsilon.alt) . $


Therefore, @lem:hoeffPauli gives the following corollary. With high probability, we can estimate the absolute value of $"tr" ( P rho )$ for any Pauli operator $P$ accurately.


#thmbox("corollary", "Corollary")[


Given $N_1 = Theta ( log ( 1 / delta ) / epsilon.alt^4 )$. For any Pauli operator $P$, we have


$ lr(|hat(b) - | "tr" ( P rho ) ||) lt.eq epsilon.alt , $


with probability at least $1 - delta$.


] <cor:absPauli>


=== Measuring signs
<measuring-signs>


Given a Pauli operator $P$, we check if $| "tr" ( P rho ) |$ is large enough with the previous procedure using Bell measurement and a the classical memory. If $| "tr" ( P rho ) |$ is large enough, we proceed to measure the sign of $"tr" ( P rho )$ as well, using a quantum memory. Suppose that $N_2$ copies of the state $rho$ are stored in the quantum memory. The sign is determined by measuring the two outcome observable


$ E = sum_(z in { plus.minus 1 }^(N_2)) upright("MAJ") ( z ) thin Pi^(( z_1 )) ⊗ dots.h ⊗ Pi^(( z_(N_2) )) , $


where $Pi^(( z_k ))$ projects the $k$th copy onto the eigenspace of the Pauli operator $P$ with eigenvalue $z_k in ( + 1 , - 1 )$ and $upright("MAJ") ( z )$ is the majority vote. In effect, the observable $E$ measures $P$ on each of the $N_2$ copies of $rho$, obtaining either $+ 1$ or $- 1$ each time, and takes a majority vote on these outcomes, yielding +1 if more than half of the outcomes are +1, and yielding -1 if more than half of the outcomes are -1.


Intuitively, if we are guaranteed that $| "tr" ( P rho ) | > tilde(epsilon.alt)$ and $N_2$ is sufficiently large, then the majority vote will concentrate on the correct answer. Hence, the quantum state $rho^(⊗ N_2)$ is approximately contained in one of the two eigenspaces of the observable $E$. As a result, after measuring $E$, the quantum state $rho^(⊗ N_2)$ would remain approximately the same. This allows us to keep measuring the sign of $"tr" ( P rho )$ for many different Pauli operators. This strategy is a key element in the original protocol for shadow tomography @aaronson2018shadow. The rigorous guarantee is given by @eq:signmeasure, which relies on the quantum union bound @aaronson2006qma.


#thmbox("lemma", "Lemma", title: [Quantum union bound @aaronson2006qma])[


Given any quantum state $rho$. Consider a sequence of $M$ two-outcome observables ${ K_i }_(i = 1)^M$, where $K_i$ has eigenvalue $0$ or $1$. Assume $"tr" ( K_i rho ) gt.eq 1 - epsilon.alt$. When we measure $K_1 , dots.h , K_M$ sequentially on $rho$, the probability that all of them yield the outcome $1$ is at least $1 - M sqrt(epsilon.alt)$.


] <lem:Qunion>


#thmbox("lemma", "Lemma")[


For any $delta , epsilon.alt , M > 0$, let $N_2 = Theta ( log ( M / delta ) / epsilon.alt^2 )$. For any $M$ Pauli operators $P_1 , dots.h , P_M$ with


$ lr(|"tr" ( P_i rho )|) > epsilon.alt , forall i = 1 , dots.h , M , $


let us define the corresponding two-outcome observables $E_1 , dots.h , E_M$. If we measure the two-outcome observable $E_1 , dots.h , E_M$ sequentially on $rho^(⊗ N_2)$, then we can correctly obtain


$ "sign" ( "tr" ( P_i rho ) ) , forall i = 1 , dots.h , M , $


with probability at least $1 - delta$.


] <eq:signmeasure>


#emph[Proof.] Let us first consider the probability that $E_i$ outputs the sign of $"tr" ( P_i rho )$ when measuring on $rho^(⊗ N_2)$. Using Hoeffding's inequality, the probability is lower bounded by



$ 1 - upright(e)^(- 1 / 2 | "tr" ( P_i rho ) |^2 N_2) > 1 - upright(e)^(- 1 / 2 epsilon.alt^2 N_2) = 1 - frac(delta^2, 2 M^2) , $


if we take $N_2 = 4 log ( 2 M / delta ) / epsilon.alt^2$. Let us define a related observable $K_i$ which has outcome $1$ if the outcome of $E_i$ is equal to the sign of $"tr" ( P_i rho )$ and $0$ otherwise. We have the following bound on the expectation value:


$ "tr" ( K_i rho^(⊗ N_2) ) gt.eq 1 - delta^2 / M^2 . $


Note that measuring $K_i$ is the same as measuring $E_i$. The only difference is in the eigenvalue associated with the outcome ($E_i$ has outcome $plus.minus 1$, while $K_i$ has outcome $0 , 1$).


Using the quantum union bound in @lem:Qunion, we will obtain outcome $1$ when we measure $K_i$ for all $i = 1 , dots.h , M$ with probability at least $1 - M sqrt(delta^2 / M^2) = 1 - delta$.


Because measuring outcome $1$ when we measure $K_i$ is equivalent to obtaining the correct sign when we measure $E_i$, this concludes the proof. ◻






=== Sample complexity analysis
<sample-complexity-analysis>


We can combine the previous results to obtain the sample complexity $N_1 , N_2$ to guarantee accurate prediction of $"tr" ( P_i rho ) , forall i = 1 , dots.h , M$. Here by "sample complexity" we mean the number of copies of $rho$ consumed by the protocol. First, following @cor:absPauli and the union bound, we choose


$ N_1 = Theta (frac(log ( M / delta ), epsilon.alt^4)) $


such that with probability at least $1 - ( delta / 2 )$, we have


$ lr(|hat(b)_i - | "tr" ( P_i rho ) ||) lt.eq epsilon.alt / 3 , forall i = 1 , dots.h , M . $<eq:goodabs>


This allows accurate prediction for the absolute values. In the next step, we only obtain the sign of $"tr" ( P_i rho )$ if $hat(b)_i > ( 2 / 3 ) epsilon.alt$. Let $R$ denote the number of Pauli operators that achieve $hat(b)_i > ( 2 / 3 ) epsilon.alt$.


Conditioning on Event~@eq:goodabs, for all $P_i$ with $hat(b)_i > ( 2 / 3 ) epsilon.alt$, we have $"tr" ( P_i rho ) > ( 1 / 3 ) epsilon.alt$. Let us denote the measured signs to be $hat(s)_i , forall i = 1 , dots.h , M$. If we do not measure the sign for $P_i$, then we set $hat(s)_i = 0$. Using @eq:signmeasure, we can choose a number of samples


$ N_2 = Theta (frac(log ( R / delta ), epsilon.alt^2)) lt.eq cal(O) (frac(log ( M / delta ), epsilon.alt^2)) $


to guarantee that, with probability at least $1 - ( delta / 2 )$, the measured signs are all correct for all $P_i$ with $hat(b)_i > ( 2 / 3 ) epsilon.alt$:


$ hat(s)_i = "sign" ( "tr" ( P_i rho ) ) , forall i in ( 1 , dots.h , M ) : hat(b)_i > 2 / 3 epsilon.alt . $<eq:correctsign>


Together, with probability at least $( 1 - ( delta / 2 ) )^2 gt.eq 1 - delta$, Events~@eq:goodabs~and~@eq:correctsign both holds. Finally, we produce the following estimate for $"tr" ( P_i rho )$: $ hat(p)_i = cases(
    hat(b)_i hat(s)_i , & upright(" if ") hat(b)_i > 2 / 3 epsilon.alt ,,
    0 , & upright(" else") .
  ) $ For Pauli operator $P_i$ with $hat(b)_i > 2 / 3 epsilon.alt$, we have


$ lr(|hat(p)_i - "tr" ( P_i rho )|) = lr(|hat(s)_i (hat(b)_i - | "tr" ( P_i rho ) |)|) = lr(|hat(b)_i - | "tr" ( P_i rho ) ||) lt.eq epsilon.alt / 3 lt.eq epsilon.alt . $


For Pauli operator $P_i$ with $hat(b)_i lt.eq 2 / 3 epsilon.alt$, we have


$ lr(|hat(p)_i - "tr" ( P_i rho )|) = lr(|"tr" ( P_i rho )|) lt.eq lr(|hat(b)_i|) + lr(|| "tr" ( P_i rho ) | - hat(b)_i|) lt.eq 2 / 3 epsilon.alt + 1 / 3 epsilon.alt lt.eq epsilon.alt . $


The first inequality uses triangle inequality. The second inequality uses the assumption that $hat(b)_i lt.eq 2 / 3 epsilon.alt$ and the fact that $hat(b)_i gt.eq 0$. Hence, we successfully predict the expectation value of $"tr" ( P_i rho ) , forall i = 1 , dots.h , M$. The number of copies we used is


$ N = 2 N_1 + N_2 = cal(O) (frac(log ( M / delta ), epsilon.alt^4)) . $


This concludes the proof of @thm:sampPauliQ.


=== Heuristics for near-term implementations
<sec:heuristicsNTImp>


The procedure for measuring the absolute value of $"tr" ( P rho )$ requires only two-copy Bell basis measurements, which can be performed quite easily on current quantum devices @cotler2019quantum @huggins2020virtual. On the other hand, the procedure for measuring signs of $"tr" ( P rho )$ can be rather difficult to implement on a near-term quantum device. However, for measuring signs, we only need to investigate the Pauli operator expectation values found to be relatively large in absolute value. For any $P$ such that $| "tr" ( P rho ) |$ is small, rather than determine the sign we simply set our predicted expectation value of $P$ to zero.


Therefore we focus on the Pauli observables whose expectation values are (comparatively) large in absolute value. When two Pauli observables $P_1$ and $P_2$ anti-commute, the expectation values of $P_1$ and $P_2$ cannot both be large in absolute value. Hence, it is often the case that these remaining observables can be sorted into a collection of just a few sets, where operators in each set are mutually commuting. Various sorting strategies are known @crawford2020efficient @izmaylov2019unitary @verteletskyi2020measurement @hamamura2020efficient @jiang2020optimal @huggins2019efficient @bonet2020nearly. Once such a commuting set is identified, all the operators in the set can be simultaneously measured using just a single copy of $rho$,


As a simple illustrative example, suppose that the underlying state is a stabilizer state. Even if we consider all $4^n$ Pauli observables, when we filter out all Pauli observables with $"tr" ( P rho ) = 0$, the rest of the Pauli observables will form a single commuting set. Hence, we only need to measure in one appropriately chosen basis to estimate all non-zero Pauli observables simultaneously.


== Sample complexity lower bound for restricted classical ML algorithms
<sec:lowbd-cml-pauli>


Recall that the restricted classical ML algorithm can only choose a certain input $x$ and obtain measurement outcome $o$ when we measure a fixed observable $O = Z_1$ on $"ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | )$. The sample complexity lower bound can be proved by reducing the problem to a well known classical problem: learning point functions. This section establishes a sample complexity lower bound for this basic problem.


#thmbox("lemma", "Lemma")[


Consider a set of point functions $f_a : ( 0 , 1 )^n arrow.r ( 0 , 1 )$, where $n gt.eq 2 , a in ( 0 , 1 )^n$ and $ f_a ( x ) = cases(
    1 & upright("if ") x = a ,,
    0 & upright("if ") x eq.not a .
  ) $ Suppose a classical randomized algorithm can output a function $tilde(f)$ by obtaining data for $N$ different inputs $( ( x_i , f_a ( x_i ) ) )_(i = 1)^N$, such that


$ max_(x in ( 0 , 1 )^n) lr(|tilde(f) ( x ) - f_a ( x )|) < 1 / 2 quad upright("with probability at least 2/3") , $<eq:point-function>


for all $a in ( 0 , 1 )^n$. Then $N gt.eq ( 1 / 4 ) 2^n = Omega ( 2^n )$.


] <lem:learnpointf>


#emph[Proof.] Suppose $a$ is selected uniformly at random. By assumption, the classical randomized algorithm will be able to output $tilde(f)$ that obeys Equation~@eq:point-function. Because the worst-case prediction error is smaller than $1 / 2$, the classical randomized algorithm will be able to correctly identify $a$ with probability at least $2 / 3$. We now use a simple calculation to obtain a lower bound to the probability for any classical randomized algorithm to identify $a$. Because $f_a ( x ) = 0$ for all but one inputs, a uniformly random input $x_1$ will result in $f_a ( x_1 ) = 0$ with probability $( 2^n - 1 ) / ( 2^n )$. Conditioned on $f_a ( x_1 ) = 0$, the second query $x_2$ will result in $f_a ( x_2 ) = 0$ with probability $( 2^n - 2 ) / ( 2^n - 1 )$. By induction, the probability that the first $k$ queries all result in function value equal to $0$ is



$ frac(2^n - k, 2^n - k + 1) dots.h frac(2^n - 1, 2^n) = frac(2^n - k, 2^n) . $


Hence, with $k = ( 1 / 4 ) 2^n$, the probability that the first $k$ queries are all zero is $( 3 / 4 )$. In such an event, the classical algorithm will have no information that helps it to distinguish the remaining $( 3 / 4 ) 2^n$ point functions. Because the conditional probability of the distribution over $a$ under such an event is uniform across the $( 3 / 4 ) 2^n$ point functions, no matter what the classical algorithm chooses, the probability of correctly identifying $a$ is equal to $( 4 / 3 ) 2^(- n)$. Thus the probability of correctly identifying a uniformly random label $a in (0 , 1)^n$ with $k$ uniformly random queries $f_a ( x_1 ) , dots.h , f_a ( x_k )$ is equal to


$ 1 / 4 + 3 / 4 dot.op 4 / 3 1 / 2^n lt.eq 1 / 2 $


under the extra assumption $n gt.eq 2$ ($2^n gt.eq 4$). Combining this fundamental lower bound with the constructive argument above reveals $N gt.eq ( 1 / 4 ) 2^n = Omega ( 2^n )$.


The number of inputs $N$ must be greater than $k = ( 2^n ) / 4$ to achieve a success probability of at least $2 / 3$.






It is not hard to consider a subset of all quantum states that can be mapped to the basic problem of learning point functions. We can equate $x in ( I , X , Y , Z )^n$ (input) and $a in (I , X , Y , Z)^n$ with bit strings of size $2 n$ (two bits unambiguously characterize all 4 single-qubit Paulis). We recall the definition that $P_x in ( I , X , Y , Z )^(⊗ n)$ is the tensor product of Pauli basis based on $x in ( I , X , Y , Z )^n$. For each $a$, we define a mixed state $ rho_a = frac(I + P_a, 2^n) , quad upright("such that") quad "tr" ( Z_1 "ℰ"_(rho_a) ( | x chevron.r #h(-1em) chevron.l x | ) ) = "tr" ( P_x rho_a ) = cases(
    1 & upright("if ") x = a ,,
    0 & upright("if ") x eq.not a .
  ) $ This is now exactly the same as the problem for learning point function given in @lem:learnpointf with input size $2 n$. Hence if the restricted classical ML model can produce $f ( x )$ such that


$ max_(x in ( I , X , Y , Z )^n) lr(|f ( x ) - "tr" ( Z_1 "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) )|) < 1 / 2 quad upright("with probability at least 2/3") , $


for all $a in ( I , X , Y , Z )^n$ from $N$ data samples. Then, the number of inputs must obey $N gt.eq ( 1 / 4 ) 2^(2 n) = Omega ( 4^n )$. ◻


== Sample complexity lower bound for any classical ML algorithm
<sec:lowerboundindmeas>


While restricted classical ML models can only obtain measurement outcome $o$ for a fixed observable $O$, one may be curious what the sample complexity lower bound would be for a standard classical ML model that can perform an arbitrary POVM measurement (which is equivalent to performing quantum computation with ancilla qubits follow by a computational basis measurement) on the output quantum state $"ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | )$. While this is much more powerful than restricted classical ML models, we will show that the sample complexity is still exponential. A quantum ML model that can process the quantum data in an entangled fashion has an exponential advantage over classical ML model that can only process each quantum data separately.


We will first focus on non-adaptive measurements, where the POVM measurement for each copy is fixed and do not change throughout the training process, and show that any procedure needs to measure $Omega ( n 2^n )$ copies of the state $rho$. A matching upper bound can be obtained using classical shadows with random Clifford measurements @huang2020predicting. Classical shadows with random Clifford measurements can predict $M$ observables $O_1 , dots.h , O_M$ using only $N_(upright(C)) = cal(O) ( max_i "tr" ( O_i^2 ) log ( M ) )$ copies. For the set of all $n$-qubit Pauli observables, we have $"tr" ( P_i^2 ) = 2^n$ and $M = 4^n$, so $N_(upright(C)) = cal(O) ( n 2^n )$. This matches with the lower bound for non-adaptive measurements.


We also give a lower bound of $Omega ( 2^(n / 3) )$ for adaptive measurements, where each POVM measurement can depend on the outcomes of previous POVM measurements. This sample complexity lower bound could be further improved using a more sophisticated analysis, which we leave for future work.


=== Non-adaptive measurements
<non-adaptive-measurements>


When one could perform arbitrary POVM measurement on $"ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | )$, the input $x$ is no longer useful since $x$ only rotates the quantum state $rho$, which can be absorbed into the POVM measurement. Let us denote the POVM for the $i$-th copy of $rho$ to be $F_i$. We can reduce the classical ML models with non-adaptive measurements to the following setup:


$ rho arrow.r^(F_1) o_1 , thin thin dots.h , thin thin rho arrow.r^(F_N) o_N , $


where $o_i$ is the POVM measurement outcome (single shot). Hence, it is a random variable that depends on $rho$ and $F_i$. This setup is known as #emph[single-copy independent measurements] in the quantum state tomography literature @haah2017sample @huang2020predicting. Without loss, we can further restrict our attention to POVM measurements comprised of rank-one projectors. Such measurements always reveal more information and we write $F_i = { w_(i o_i) 2^n | psi_(i o_i) chevron.r #h(-1em) chevron.l psi_(i o_i) | }_j$. The classical ML model then uses the classical measurement outcomes $o_1 , dots.h , o_N$ to learn a function $f ( x )$ such that the following prediction error bound holds with high probability:


$ max_(x in ( I , X , Y , Z )^n) lr(|f ( x ) - "tr" ( Z_1 "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) )|) = max_(x in ( I , X , Y , Z )^n) lr(|f ( x ) - "tr" ( P_x rho )|) < 1 / 2 . $


We will show that this necessarily requires $N gt.eq Omega ( n 2^n )$. Recall that the sample complexity for achieving a constant worst-case prediction error using a quantum ML model is $N = cal(O) ( n )$.


The proof uses a mutual information analysis similar to the sample complexity lower bound for quantum ML models given in @sec:MIanalysisML. We consider a communication protocol between Alice and Bob. First, we define a codebook that Alice will use to encode classical information in quantum states:


$ ( a , s ) in (1 , dots.h , 4^n - 1) times {plus.minus 1} thin thin thin arrow.r thin thin thin rho_(( a , s )) = frac(I + s P_a, 2^n) , $<eq:rhoa-def>


where $P_a$ runs through all Pauli matrices $( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }$ that are not the global identity and $s$ is an additional sign. There are $2 ( 4^n - 1 )$ combinations in total and Alice will sample one of them uniformly at random. Then, Alice she prepares $N$ copies of $rho_(( a , s ))$ and sends them to Bob. Bob will perform the POVM measurements $F_1 , dots.h , F_N$ on the $N$ copies of $rho_(( a , s ))$ he receives to obtain classical measurement outcomes $o_1 , dots.h , o_N$. He will use them to train the classical ML model to produce a function $tilde(f) ( x )$ that is guaranteed to obey


$ max_(x in ( I , X , Y , Z )^n) lr(|tilde(f) ( x ) - "tr" ( Z_1 "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) )|) = max_(x in ( I , X , Y , Z )^n) lr(|tilde(f) ( x ) - "tr" ( P_x rho_(( a , s )) )|) < 1 / 2 $<eq:learningguarantee>


with high probability. Because $"tr" ( P_x rho_(( a , s )) )$ is either $+ 1 , 0 , - 1$, it is not hard to see that Bob can use $tilde(f) ( x )$ to determine Alice's original message $a$ -- as long as Equation~@eq:learningguarantee holds. Using Fano's inequality and data processing inequality, the mutual information between $a$ and the measurement outcomes $o_1 , dots.h , o_N$ must be lower bounded by


$ I ( ( a , s ) : o_1 , dots.h , o_N ) = Omega ( log ( 2 ( 4^n - 1 ) ) ) = Omega ( n ) . $


Furthermore, when conditioned on $a$, the measurement outcomes $o_1 , dots.h , o_N$ are all independent from each other. Hence we can use the chain rule of mutual information to obtain


$ I ( ( a , s ) : o_1 , dots.h , o_N ) lt.eq sum_(i = 1)^N I ( ( a , s ) : o_i ) . $


By construction of $rho_a$, we can show that $I ( a : o_i ) lt.eq 1 / ( 2^n + 1 )$. This is the content of @lem:expsmallI below. This technical result allows us to conclude


$ frac(N, 2^n + 1) gt.eq I ( ( a , s ) : o_1 , dots.h , o_N ) = Omega ( n ) . $


This establishes the advertised result: $N = Omega ( n 2^n )$.


The bound on mutual information is a nontrivial consequence of the following technical statement.


#thmbox("lemma", "Lemma")[


Fix a pure state $| psi chevron.r chevron.l psi |$ and set $rho_(a , s) = ( I + s P_a ) / 2^n$, where $P_a$ is chosen uniformly from $( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }$ and $s in {plus.minus 1}$ is a random sign. Then,


$ "𝔼"_(a , s) chevron.l psi | rho_(( a , s )) | psi chevron.r = & 1 / 2^n quad upright("and")\
"𝔼"_(a , s) chevron.l psi | rho_(( a , s )) | psi chevron.r^2 = & 1 / 4^n (1 + frac(1, 4^n - 1) sum_a chevron.l psi | P_a | psi chevron.r^2) = 1 / 4^n (1 + frac(1, 2^n + 1)) . $


] <lem:pauli-averages>


#emph[Proof.] The first display is an immediate consequence of symmetry:



$ "𝔼"_(a , s) chevron.l psi | rho_(( a , s )) | psi chevron.r = 1 / 2^n "𝔼"_(a , s) chevron.l psi | I | psi chevron.r + 1 / 2^n "𝔼"_a ("𝔼"_s s chevron.l psi | P_a | psi chevron.r) = 1 / 2^n + 0 . $


The second display follows from the fact that the collection ${2^(- n / 2) P_a}$ forms an orthonormal basis of the space of all Hermitian $2^n times 2^n$ matrices (with respect to the Hilbert-Schmidt inner product). Parseval's identity then asserts $1 / 2^n ( sum_a chevron.l psi | P_a | psi chevron.r^2 + chevron.l psi | I | psi chevron.r^2 ) = parallel | psi chevron.r chevron.l psi parallel_2^2 = 1$ and, together with symmetry, we conclude


$ "𝔼"_(a , s) chevron.l psi | rho_(( a , s )) | psi chevron.r^2 = & 1 / 4^n "𝔼"_(a , s) chevron.l psi | I | psi chevron.r^2 + 2 / 4^n "𝔼"_a ("𝔼"_s s chevron.l psi | P_a | psi chevron.r) + 1 / 4^n "𝔼"_a ( "𝔼"_s s^2 ) chevron.l psi | P_a | psi chevron.r^2\

= & 1 / 4^n + 0 + frac(1, 4^n ( 4^n - 1 )) sum_a chevron.l psi | P_a | psi chevron.r^2 = 1 / 4^n + frac(1, 2^n ( 4^n - 1 )) (1 - 1 / 2^n)\
= & 1 / 4^n (1 + frac(1, ( 2^n + 1 ))) $





We now give the desired upper bound on the mutual information between $a$ and $o_i$. ◻


#thmbox("lemma", "Lemma")[


$I ( a : o_i ) lt.eq 1 / ( 2^n + 1 ) .$


] <lem:expsmallI>


#emph[Proof.] Suppose that the POVM measurement $F_i$ is given by $F_(o_i) = { w_(i o_i) 2^n | psi_(i o_i) chevron.r #h(-1em) chevron.l psi_(i o_i) | }$, where $j$ ranges through all possible measurement outcomes. Using the condition $sum_j w_(i o_i) 2^n | psi_(i o_j) chevron.r #h(-1em) chevron.l psi_(i o_i) | = I$ and $chevron.l psi_(i o_j) | psi_(i o_i) | = chevron.r 1$, we have $sum_(o_i) w_(i o_i) = 1$ (take the trace of both sides of the equation) The probability distribution of $o_i$ conditioned on $( a , s )$ can hence be written as



$ p_(( a , s )) ( o_i ) = w_(i o_i) 2^n chevron.l psi_(i o_i) | rho_(( a , s )) | psi_(i o_i) chevron.r $


and the mutual information obeys


$ I ( ( a , s ) : o_i ) & = "𝔼"_(a , s) [ sum_(o_i) p_(( a , s )) ( o_i ) log p_(( a , s )) ( o_i ) ] - sum_(o_i) ( "𝔼"_(a , s) p_(( a , s )) ( o_i ) ) log ( "𝔼"_(a , s) p_(( a , s )) ( o_i ) ) \
 & lt.eq sum_(o_i) frac("𝔼"_(a , s) [ p_(( a , s )) ( o_i )^2 ] - ( "𝔼"_(a , s) p_(( a , s )) ( o_i ) )^2, "𝔼"_(a , s) p_(( a , s )) ( o_i )) . $ <eq:MI-upper-bound>


The inequality uses the fact that $log ( x )$ is concave, so $log ( x ) lt.eq log ( y ) + frac(x - y, y)$. We can separately compute $"𝔼"_(a , s) p_(( a , s )) ( o_i )$ and $"𝔼"_(a , s) [p_(( a , s )) ( o_i )^2]$ using @lem:pauli-averages:


$ "𝔼"_(a , s) p_(( a , s )) ( o_i ) = & w_(i o_i) 2^n "𝔼"_(a , s) chevron.l psi_(i o_i) | rho_(( a , s )) | psi_(i o_i) chevron.r = w_(i o_i) ,\
"𝔼"_(a , s) p_(( a , s )) ( o_i )^2 = & w_(i o_i)^2 4^n "𝔼"_(a , s) chevron.l psi_(i o_i) | rho_(( a , s )) | psi_(i o_i) chevron.r^2 = w_(i o_i)^2 (1 + frac(1, 2^n + 1)) $


Inserting these expressions into


Equation~[\[eq:MI-upper-bound\]] reveals


$ I ( a : o_i ) lt.eq sum_(o_i) 1 / w_(i o_i) (w_(i o_i)^2 (1 + frac(1, 2^n + 1)) - w_(i o_i)^2) = frac(1, 2^n + 1) sum_(o_i) w_(i o_i) = frac(1, 2^n + 1) , $


because the $w_(i o_i)$'s are expansion coefficients of a POVM ($sum_(o_i) w_(i o_i) = 1$). This is the advertised result. ◻





=== Adaptive measurements
<adaptive-measurements>


In the last section, we have derived a sample complexity lower bound for independent single-copy quantum measurements. Several results in the literature address this restricted setting, see e.g.~@haah2017sample @huang2020predicting. In stark contrast, very little is known about the more realistic setting of adaptive single-copy measurements; see @bubeck2020entanglement @aharonov2021quantum for lower bounds on quantum mixedness testing and the task of distinguishing between physical experiments. Here, we give an elementary proof that provides an exponential sample complexity lower bound for predicting Pauli expectation values based on single-copy adaptive measurements. Such an extension to adaptive measurement strategies is nontrivial -- very few results are known for this setting. However, the actual result is not (yet) tight. We believe that further improvements are possible using more sophisticated analysis and we leave this as a future work. When adaptive measurements are allowed, each POVM measurement can depend on previous POVM measurement outcomes. And the entire training process can be written as


$ rho arrow.r^(F_1^(o_(< 1))) o_1 , rho arrow.r^(F_2^(o_(< 2))) o_2 , thin thin dots.h , thin thin rho arrow.r^(F_N^(o_(< N))) o_N . $


Here, $o_i$ is the POVM measurement outcome of the $i$-th measurement and $o_(< k)$ subsumes all previous measurement outcomes (think $o_(< k) = ( o_1 , dots.h , o_(k - 1) )$). Without loss, we again restrict our attention to POVM measurements comprised of rank-one projectors (these always provide more information in the measurement outcome) and write


$ F_i^(o_(< i)) = {w_(i j)^(o_(< i)) 2^n | psi_(i j)^(o_(< i)) chevron.r #h(-1em) chevron.l psi_(i j)^(o_(< i)) |} . $


Using the conditions $sum_j w_(i j)^(o_(< i)) 2^n | psi_(i j)^(o_(< i)) chevron.r #h(-1em) chevron.l psi_(i j)^(o_(< i)) | = I$ and $chevron.l psi_(i j)^(o_(< i)) | psi_(i j)^(o_(< i)) chevron.r = 1$, we have $sum_j w_(i j)^(o_(< i)) = 1$.


Suppose Alice randomly chooses one of $4^n$ possible $n$-qubit states based on a #emph[non-uniform] probability distribution: $ rho = cases(
    rho_(upright("mm")) = I / 2^n , & upright("with probability") thin thin 1 / 2 ,,
    rho_a = frac(I + P_a, 2^n) , & upright("with probability") thin thin frac(1, 2 ( 4^n - 1 )) ,
  ) $ where $P_a$ is chosen among all $4^n - 1$ nontrivial Pauli operators $( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }$. (In contrast to the previous subsection, we only include positive signs, that is $rho_a = rho_(( a , + 1 ))$). Alice then sends $rho^(⊗ N)$ to Bob. Hence, Bob will receive $  cases(
    rho_(upright("mm"))^(⊗ N) , & upright("with probability") thin thin 1 / 2 ,,
    rho_a^(⊗ N) , & upright("with probability") thin thin frac(1, 2 ( 4^n - 1 )) .
  ) $ Bob uses the classical ML model with adaptive measurement outcomes $o_1 , dots.h , o_N$ to infer all Pauli expectation values of $"tr" ( P_b rho )$ with a small error (the assumption of the classical ML model). Because $"tr" ( P_b rho_a ) = delta_(a b)$, but $"tr" ( P_b rho_(upright("mm")) ) = 0$ for all $b$, Bob can successfully distinguish the quantum state chosen by Alice once he knows the expectation values of all Pauli operators. This implies that the probability distribution for Bob's measurement outcomes $o_1 , dots.h , o_N$ must be able to distinguish the two events:

+ $rho = rho_(upright("mm"))$, which happens with probability $1 / 2$.

+ $rho = rho_a$ for a random $a$, which happens with probability $1 / 2$.

We have thus reduced a multiple-hypothesis testing problem -- distinguishing among $4^n$ possible states -- to a two-hypothesis testing problem -- distinguishing between the completely mixed state and a randomly chosen $rho_a$. We will use this observation to derive an information-theoretic lower bound on $N$.


Importantly, the two hypothesises give rise to different joint probability distributions of all $N$ outcomes. Under the first hypothesis ($rho = rho_(upright("mm"))$),


$ p_1 ( o_1 , dots.h , o_N ) = product_(i = 1)^N w_(i o_i)^(o_(< i)) , $<eq:p1>


while the second hypothesis ($rho = rho_a$ and $a$ is itself uniformly random) would imply


$ p_2 ( o_1 , dots.h , o_N ) = frac(1, 4^n - 1) sum_(P_a : ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) product_(i = 1)^N w_(i o_i)^(o_(< i)) ( 1 + chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r ) . $<eq:p2>


When Bob performs his measurement strategy, he exactly obtains one sample from such a joint probability distribution. And based on this sample, he must distinguish between the two hypotheses. A well-known fact from statistics states that the optimal decision strategy is the maximum likelihood rule (pick the joint probability distribution that is most likely, given the observed event). This strategy succeeds with a probability that is determined by the total variational (TV)distance:


$ upright("Pr") [upright("successful discrimination")] = & 1 / 2 + 1 / 2 upright("TV") ( p_1 , p_2 ) quad upright("with")\
upright("TV") ( p_1 , p_2 ) = & 1 / 2 sum_(x in cal(X)) lr(|p_1 ( x ) - p_2 ( x )|) = sum_(x in cal(X) : p_1 ( x ) > p_2 ( x )) (p_1 ( x ) - p_2 ( x )) . $<eq:TV-def>


We note in passing that this classical observation is actually the starting point for the celebrated Holevo-Helstrom theorem @Helstrom1969 @Holevo1973. We refer to @ambainis_wise_2007 @Matthews_2009 and also @Kueng2019[Lecture 1] for a modern discussion from a quantum information perspective.


Importantly, the TV distance between $p_1 ( o_1 , dots.h , o_N )$ and $p_2 ( o_1 , dots.h , o_N )$ remains tiny until $N$ becomes exponentially large: $upright("TV") (p_1 ( o_1 , dots.h , o_N ) , p_2 ( o_1 , dots.h , o_N )) lt.eq 2 N / ( 2^n + 1 )^(1 / 3)$. This is the content of @lem:total-variation below. This TV upper bounds Bob's bias for successful discrimination of the two possibilities. Because Bob can successfully discriminate between the two hypotheses, we have $upright("TV") ( p_1 , p_2 ) = Omega ( 1 )$, which gives the desired result


$ N = Omega ( 2^(n / 3) ) . $


We emphasize that an exponential lower bound can be proven using the same method whenever we want to predict a class of observables $( O_1 , dots.h , O_M )$ such that $1 / M sum_(i = 1)^M chevron.l psi | O_i | psi chevron.r^2$ is an exponentially small number for all pure states $| psi chevron.r$. Pauli observables are one example of such a class of observables.


#thmbox("lemma", "Lemma")[


$upright("TV") (p_1 ( o_1 , dots.h , o_N ) , p_2 ( o_1 , dots.h , o_N )) lt.eq 2 N / ( 2^n + 1 )^(1 / 3)$.


] <lem:total-variation>


#emph[Proof.] The key insight is that -- regardless of the actual choice of measurements -- single-copy, rank-one POVMs are ill equipped to distinguish the maximally mixed state $rho_(upright("mm")) = I / 2^n$ from $rho_a = ( I + P_a ) / 2^n$, where $a$ is a uniformly random index. To see this, let us first re-use @lem:pauli-averages to obtain



$ sum_a chevron.l psi^(o_(lt i))_(i o_i) | P_a | psi^(o_(lt i))_(i o_i) chevron.r^2 = ( 4^n - 1 ) "𝔼"_a chevron.l psi^(o_(lt i))_(i o_i) | P_a | psi^(o_(lt i))_(i o_i) chevron.r^2 = frac(4^n - 1, 2^n + 1) = 2^n - 1 quad "for any " |psi^(o_(lt i))_(i o_i) chevron.r . $ <eq:Pauli-sum>


This, in turn implies that for an overwhelmingly large fraction of Pauli indices, $chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r$ must be exponentially close to zero. More precisely,


$ lr(|{P_a in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) } : | chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r | lt.eq frac(1, ( 2^n + 1 )^(1 / 3))}|) gt.eq (1 - frac(1, ( 2^n + 1 )^(1 / 3))) ( 4^n - 1 ) , $<eq:small-paulis>


and this cardinality bound can be proven by contradiction. Suppose that the number of very small Pauli operators is smaller than $(1 - frac(1, ( 2^n + 1 )^(1 / 3))) ( 4^n - 1 )$. Then, this would necessarily imply


$ sum_(P_a : ( I , X , Y , Z )^(⊗ n)) chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r^2 > frac(4^n - 1, ( 2^n + 1 )^(1 / 3)) times (frac(1, ( 2^n + 1 )^(1 / 3)))^2 = 2^n - 1 $


which is in direct conflict with Equation~[\[eq:Pauli-sum\]].


Equation~@eq:small-paulis states that an overwhelming fraction of all Pauli observables $P_a$ have small overlap with a single fixed rank-one projector. This feature makes the associated states $rho_a$ difficult to distinguish from the maximally mixed state and an adaptive measurement procedure cannot easily wash out this phenomenon. Fix a tuple $( o_1 , dots.h , o_N )$ of measurement outcomes and let


$ G^(( o_1 , dots.h , o_N )) = {P_a in ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) } : | chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r | lt.eq frac(1, ( 2^n + 1 )^(1 / 3)) , forall i = 1 , dots.h , N} $


denote the set of Pauli operators that have exponentially small overlap with the associated rank-one projectors. Note that the set $G^(( o_1 , dots.h , o_N ))$ depends on the measurement outcomes $( o_1 , dots.h , o_N )$. Then, the cardinality of this set follows from the lower bound of the size of the set given in Equation~@eq:small-paulis:


$ | G^(( o_1 , dots.h , o_N )) | gt.eq (1 - frac(N, ( 2^n + 1 )^(1 / 3))) (4^n - 1) $


and $G^(( o_1 , dots.h , o_N ))$ exclusively contains mixed states $rho_a$ that are difficult to distinguish from the maximally mixed state. This has profound implications on the TV distance. Using the definition of $p_1 , p_2$ and the triangle inequality, we obtain


$ upright("TV") ( p_1 , p_2 ) lt.eq frac(1, 4^n - 1) sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) sum_(P_a : ( I , X , Y , Z )^(⊗ n) \ { I^(⊗ n) }) (product_(i = 1)^N w_(i o_i)^(o_(< i))) (1 - product_(i = 1)^N ( 1 + chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r )) $<eq:TV-Pauli-sum>


and each expression on the very right is guaranteed to be contained in an (exponentially) small interval


$ (1 - product_(i = 1)^N ( 1 + chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r )) in [1 - 2^N , 1] . $<eq:bound-Pauli-product>


To obtain an upper bound on the TV distance we make an additional rounding argument: if $P_a in.not G^(( o_1 , dots.h , o_N ))$, we assume that the difference takes the maximum possible value $1 - product_(i = 1)^N ( 1 + chevron.l psi_(i o_i)^(o_(< i)) | P_a | psi_(i o_i)^(o_(< i)) chevron.r ) = 1$. We also used the short-hand notation $o_(1 : N) = ( o_1 , dots.h , o_N )$. This gives


$ upright("TV") ( p_1 , p_2 ) & lt.eq frac(1, 4^n - 1) sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) | G^(( o_1 , dots.h , o_N )) | (product_(i = 1)^N w_(i o_i)^(o_(< i))) (1 - (1 - frac(1, ( 2^n + 1 )^(1 / 3)))^N)\
 & + frac(1, 4^n - 1) sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) ( 4^n - 1 - | G^(( o_1 , dots.h , o_N )) | ) (product_(i = 1)^N w_(i o_i)^(o_(< i)))\
 & lt.eq frac(1, 4^n - 1) sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) ( 4^n - 1 ) (product_(i = 1)^N w_(i o_i)^(o_(< i))) (1 - (1 - frac(1, ( 2^n + 1 )^(1 / 3)))^N)\
 & + frac(1, 4^n - 1) sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) frac(N, ( 2^n + 1 )^(1 / 3)) ( 4^n - 1 ) (product_(i = 1)^N w_(i o_i)^(o_(< i)))\
 & = sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) (product_(i = 1)^N w_(i o_i)^(o_(< i))) ((1 - (1 - frac(1, ( 2^n + 1 )^(1 / 3)))^N) + frac(N, ( 2^n + 1 )^(1 / 3)))\
 & lt.eq (1 - (1 - frac(1, ( 2^n + 1 )^(1 / 3)))^N) + frac(N, ( 2^n + 1 )^(1 / 3)) . $


To obtain the first inequality, we divide the sum over $P_a$ in Equation~(@eq:TV-Pauli-sum) into a sum over $P_a in G^(( o_1 , dots.h , o_N ))$ and a sum over $P_a in.not G^(( o_1 , dots.h , o_N ))$, and apply the upper bound in Equation~(@eq:bound-Pauli-product) to the sum over $P_a in.not G^(( o_1 , dots.h , o_N ))$. The second inequality uses the fact $(1 - frac(N, ( 2^n - 1 )^(1 / 3))) ( 4^n - 1 ) lt.eq | G^(( o_1 , dots.h , o_N )) | lt.eq 4^n - 1$. The final line follows from $w_(i o_i)^(o_(< i)) gt.eq 0$ and $sum_(o_i) w_(i o_i)^(o_(< i)) = 1$\; hence


$ sum_(o_(1 : N) :\
p_1 ( o_(1 : N) ) > p_2 ( o_(1 : N) )) (product_(i = 1)^N w_(i o_i)^(o_(< i))) lt.eq 1 . $


Finally, we use the inequality $1 - ( 1 - x )^N lt.eq N x , forall x lt.eq 1 , N in bb(N)$ to find


$ upright("TV") ( p_1 , p_2 ) lt.eq frac(2 N, ( 2^n + 1 )^(1 / 3)) . $


This concludes the desired upper bound on the total variation distance. ◻






== Sample complexity lower bound for general entangled measurements
<sec:lowerboundentangled>


We establish a lower bound of $N = Omega ( n )$ for quantum ML models that can perform general entangled measurements on $N$ copies of $rho$. This matches with the sample complexity of the quantum ML model considered in @sec:pauli-qml. The proof is similar to the sample complexity lower bound for single-copy independent measurements given in @sec:lowerboundindmeas.


We consider a communication protocol between Alice and Bob. First, we define a codebook that Alice will use to encode classical information in quantum states:


$ a in (1 , dots.h , 4^n - 1) #h(0em) upright("and") #h(0em) s in {plus.minus 1} thin thin thin arrow.r thin thin thin rho_(( a , s )) = frac(I + s P_a, 2^n) , $<eq:rhoa-def-2>


where $P_a$ runs through all Pauli matrices $( I , X , Y , Z )^(⊗ n) } \ { I^(⊗ n) }$ that are not the global identity. Alice samples a Pauli index $a$ and a sign $s$ uniformly at random. Then, she prepares $N$ copies of $rho_a$ and sends them to Bob. Bob will use the quantum ML model on the $N$ copies of $rho$ to predict the expectation values of all $4^n$ Pauli observables. The expectation values will be a general entangled POVM measurement outcome $o$ on the $N$ copies of $rho$. By assumption, Bob can use $O$ to construct a function $tilde(f) ( x ) : ( I , X , Y , Z )^n arrow.r bb(R)$ that is guaranteed to satisfy


$ max_(x in ( I , X , Y , Z )^n) lr(|tilde(f) ( x ) - "tr" ( Z_1 "ℰ"_rho ( | x chevron.r #h(-1em) chevron.l x | ) )|) = max_(x in ( I , X , Y , Z )^n) lr(|tilde(f) ( x ) - "tr" ( P_x rho_(( a , s )) )|) < 1 / 2 $<eq:learningguarantee-Q>


with high probability. Because $"tr" ( P_x rho_(( a , s )) )$ is either $+ 1 , 0 , - 1$, it is not hard to see that Bob can use $tilde(f) ( x )$ to determine both $a$ and $s$ as long as Equation~@eq:learningguarantee holds. Using Fano's inequality and data processing inequality, the mutual information between $( a , s )$ and the measurement outcome $o$ must be lower bounded by


$ I ( ( a , s ) : o ) gt.eq Omega ( log ( 2 ( 4^n - 1 ) ) ) = Omega ( n ) . $


In conjunction with Holevo's theorem @Helstrom1969 @Holevo1973, we have


$ I ( ( a , s ) : o ) & lt.eq S (frac(1, 2 ( 4^n - 1 )) sum_(a , s) rho_(( a , s ))^(⊗ N)) - frac(1, 2 ( 4^n - 1 )) sum_(a , s) S (rho_(( a , s ))^(⊗ N)) \
 & lt.eq N n log ( 2 ) - frac(1, 2 ( 4^n - 1 )) sum_(a , s) N S (rho_(( a , s ))) \
 & = N n log ( 2 ) - N ( n - 1 ) log ( 2 ) = N log ( 2 ) , $


where $S ( dot.op )$ is the von Neumann entropy, the second inequality uses the fact a $N n$-qubit system has an entropy upper bounded by $N n log ( 2 )$. Hence, we must have $N = Omega ( n )$.

#bibliography("refs.bib")
