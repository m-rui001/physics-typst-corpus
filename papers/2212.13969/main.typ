#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.80cm, bottom: 2.37cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: none)
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#set math.equation(numbering: "(1)")
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)
#show ref: it => {
  let el = it.element
  if el != none and el.func() == math.equation {
    link(it.target, numbering("(1)", ..counter(math.equation).at(it.target)))
  } else { it }
}

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Quantum simulation of partial differential equations via Schrödingerisation])   #v(1.2em)
    #text(10.5pt)[Shi Jin]
  
  ]
  #v(1.6em)

  #v(0.6em)

  #align(center)[
// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: December 29, 2022)]]

    #text(9.5pt)[*Abstract.* We present a simple new way---called _Schrödingerisation_---to simulate general linear partial differential equations via quantum simulation. Using a simple new transform, referred to as _the warped phase transformation_, any linear partial differential equation can be recast into a system of Schrödinger's equations --- in real time --- in a straightforward way. This can be seen directly on the level of the dynamical equations without more sophisticated methods. This approach is not only applicable to PDEs for classical problems but also those for quantum problems --- like the preparation of quantum ground states, Gibbs states and the simulation of quantum states in random media in the semiclassical limit.]
  ]

















]

= INTRODUCTION
<introduction>


Quantum simulation is one of the most natural tasks for a quantum device --- by preparing outputs of Schrödinger's equations directly via its own evolution @feynman2018simulating. However, what can we say about the suitability of quantum systems in simulating classical dynamical laws, typically in the form of ordinary or partial differential equations (ODEs/PDEs) that are not Schrödinger's equations? This is of great importance for broader applications of quantum computing in science and engineering.


While the most obvious applications are for classical problems, simulating classical dynamics is also important for #emph[quantum problems]. The most well-known include the preparation of quantum ground states @ge2019faster @lin2020near and Gibbs states @poulin2009sampling, which benefit from non-unitary dynamics, and are particularly important in areas like quantum chemistry @lloyd1996universal and optimisation.


We know quantum simulation of classical dynamics is in principle possible, if we accept reductionism and that the world is fundamentally quantum mechanical. All classical dynamical laws are, with the exception of relativity, in principle derivable from underlying Schrödinger's equations. From a computational perspective, we also know that any classical gate can be trivially embedded into a quantum gate, so we expect quantum gates to be able to simulate classical ones. However, the quantum degrees of freedom involved could typically be significantly larger than that of the classical systems one wishes to simulate. An essential question is then: are there less resource-intensive ways to represent classical dynamics with Schrödinger's equations?


Consider the case of numerical solutions to linear PDEs, which, upon spatial and temporal discretizations, become a system of linear algebraic equations. Quantum algorithm speedups in solving a system of linear algebraic equations @harrow2009quantum @childs2017quantum can subsequently lead to possible polynomial or super-polynomial speedups in solving PDEs @childs2021high @montanaro2016quantum. For nonlinear counterparts see @liu2021efficient @jin2022quantum. However, here quantum simulation only plays the role of an algorithmic primitive --- due to discretisation in time, one does not prepare solution states continuously in time $t$ by evolution of a Schrödinger equation in time $t$.


To obviate the discretisation in time, a main difficulty is in finding a way to represent non-unitary dynamics with a unitary one, which can be evolved by quantum simulation like the Schrödinger equation. One way is via qubitisation @low2019hamiltonian @gilyen2019quantum (or block-encoding) and this has very recently been applied to linear PDEs @an2022theory. This involves unitary dilation methods (e.g. @horn2012matrix) and has origins in quantum signal processing @low2016methodology. While this fairly general formalism can in principle approximate the action of any non-unitary operator, it relies heavily on building linear combinations of quantum states and finding suitable polynomial approximations to the non-unitary operator, which is not always simple to describe or to implement in practise.


For the heat equation, another method is the imaginary time evolution approach, where the heat equation can be converted to a Schrödinger equation through a change to time $t arrow.r i t$ @lehtovaara2007solution. However, the state obeying Schrödinger's equation and its imaginary time counterpart do not have the same evolution. This means that, except for the steady state solution, extra resources are necessary to map between the solution in the unitarily evolving system to the other. For instance, one requires tomographic measurements of quantum states at each small time step in the unitary evolution @motta2020determining. Furthermore, the imaginary time evolution method does not apply beyond the heat equation.


Thus we have an important question: #emph[Is there a simpler and generic way of obtaining Schrödinger's equations naturally from any given linear dynamics?]


We propose a new paradigm --- based on a simple transformation called the #emph[warped phase transformation] --- that can map any linear PDE to Schrödinger equations in real time. By the quantum simulation of this Schrödinger dynamics in time $t$, it is possible to prepare solutions of the original PDEs at any time $t$, in the form of a quantum state. We call this the #emph[Schrödingerisation approach].


To illustrate this approach, we present the heat equation example in detail. With a warped phase transformation and a Fourier transform, the heat equation can be transformed into a system of uncoupled Schrödinger equations with rescaled time coordinates --- #emph[in real time] --- thus providing a conceptual alternative to imaginary time evolution methods. We show how the quantum simulation of these Schrödinger's equations can be used to prepare quantum ground states and Gibbs states.


In another example, we apply the Schrödingerisation approach to a linear radiative transport equation. This can be used to simulate quantum systems in random media in the semi-classical limit.


Finally, we show how to generalise the Schrödingerisation approach to any linear PDE.


= BACKGROUND
<background>
Consider linear $( d + 1 )$-dimensional PDEs for $u = u ( t , x )$ that is first-order in time $t gt.eq 0$ $ partial_t u = cal(L) u , quad u ( 0 , x ) = u_0 ( x ) . $ Here $x in bb(R)^d$ is the position in $d$ dimensions, $partial_(( dot.op ))$ is the partial derivative with respect to $( dot.op )$ and $cal(L)$ is a linear differential operator with respect to $x$.


Schrödinger's equation is such a linear PDE equation where $u$ is called the wavefunction and $cal(L) u = - i ( - nabla_x^2 + V ( x ) ) u$, where $nabla_x^2$ is the Laplace operator with respect to $x$ and $V ( x )$ is the potential function. To find numerical solutions to this problem, one can discretise in $x$, with uniform mesh sizes along each dimension $Delta x = 2 / M$ where $M$ is a positive even integer. Let $bold(u) ( t )$ represent the $M^d$-dimensional vector whose entries are $u ( t , x_i )$ at grid points with $i = 1 , . . . , M^d$. By definition of the wavefunction, the $l_2$ norm $parallel bold(u) ( t ) parallel = 1$. The entries to this vector can be considered as amplitudes of the $M^d$-dimensional quantum state $\| u ( t ) chevron.r = sum_(i = 1)^(M^d) u ( t , x_i ) \| i chevron.r$ where ${ \| i chevron.r }$ is an orthonormal basis set. When given a state spanned by $( \| 0 chevron.r , \| 1 chevron.r )$ over the field $bb(C)$, this is called a qubit. Thus $\| u ( t ) chevron.r$ can be described by a system of $d log_2 ( M )$ qubits. It is straightforward to see that $bold(u) ( t )$ satisfies the linear system of ODEs $ i frac(d bold(u) ( t ), d t) = bold(H) bold(u) ( t ) $<eq:schrode1> where $bold(H)$ is a $M^d times M^d$ Hermitian matrix that results from a discretisation of the Schrödinger Hamiltonian $- nabla_x^2 + V ( x )$ in $x$. The solution to Eq.~#ref(<eq:schrode1>) is clearly $bold(u) ( t ) = exp ( - i bold(H) t ) bold(u) ( 0 )$ and one has the corresponding quantum state evolution $\| u ( t ) chevron.r = exp ( - i bold(H) t ) \| u ( 0 ) chevron.r$. Quantum simulation addresses the question of how to realise this $exp ( - i bold(H) t )$ operator, when given $bold(H)$, and an estimation of the resources required. We focus on the time-independent setting for now.


Quantum simulation falls roughly into two categories: analogue and digital @daley2022practical. In the analogue case, a quantum system that naturally realises $bold(H)$ or can be mapped to this Hamiltonian is found. However, if such an analogue quantum system cannot be found, digital quantum simulation methods still allows the simulation for more general $bold(H)$. In this case, one counts resources as the number of queries to some given black-boxes and the number of two-qubit gates needed. This is referred to as the query and gate complexities respectively.


Let $s$ be the sparsity of $bold(H)$ (maximum number of non-zero entries in each row) and $parallel bold(H) parallel_"max"$ be its max-norm (value of largest entry in absolute value). We denote the $( i , j )^"th"$ entry to $bold(H)$ as $H_(i j)$. A common set of black-boxes used in Hamiltonian simulation is known as the sparse access.

#block[
Sparse access to Hermitian matrix $bold(H)$ refers to two unitary black-boxes $O_M$ and $O_F$ such that $O_M \| j chevron.r \| k chevron.r \| z chevron.r = \| j chevron.r \| k chevron.r \| z xor H_(j k) chevron.r$ and $O_F \| j chevron.r \| l chevron.r = \| j chevron.r \| F ( j , l ) chevron.r$. Here the function $F$ takes the row index $j$ and a number $l = 1 , 2 , . . . , s$ and outputs the column index of the $l^"th"$ non-zero elements in row $j$.

]
There are quantum simulation protocols in terms of query complexity that scale linearly in $t$ @low2019hamiltonian using sparse access or linearly in $t$ up to logarithmic factors @berry2015hamiltonian.

#figure(
  block([
@berry2015hamiltonian Let $tau = s t parallel bold(H) parallel_"max"$. Then $exp ( - i bold(H) t )$ acting on $m_H$ qubits can be simulated to within error $epsilon$ has query complexity $cal(O) ( tau log ( tau / epsilon ) / ( log log ( tau / epsilon ) ) )$ with gate complexity $cal(O) #scale(x: 180%, y: 180%)[(] tau ( m_H + log^2.5 ( tau / epsilon ) ) log ( tau / epsilon ) / ( log log ( tau / epsilon ) ) #scale(x: 180%, y: 180%)[)]$.
  ]),
  kind: "lemma",
  supplement: "Lemma",
) <eq:lemmasimulation>
Throughout the paper, we use $tilde(cal(O))$ to denote $cal(O)$ where logarithmic terms are ignored.

= SCHRÖDINGERISATION OF THE HEAT EQUATION
<schrödingerisation-of-the-heat-equation>


We begin with the initial value problem of the linear heat equation with a source term
$ partial_t u = - H u , quad u ( 0 , x ) = u_0 ( x ) , $ <eq:heatequation>
where $H = - nabla_x^2 + V ( x )$ and $t gt.eq 0$. We introduce a real one-dimensional variable $p > 0$ and define $ w ( t , x , p ) = e^(- p) u ( t , x ) . $ This transformation -- which we call the #emph[warped phase transformation] -- is a crucial ingredient that will allow us to transform the heat equation to Schrödinger equations by extending the heat equation solution to a higher 'warped' extra dimension. Such a transformation was used in @golse2022quantum for a completely different purpose: to develop efficient quantum computing algorithms for uncertainty quantification problems in PDEs.


First observe that one can recover the solution to the heat equation using $u(t,x) = integral_0^infinity w(t,x,p) dif p = integral_(-infinity)^infinity chi(p) w(t,x,p) dif p$, where $chi ( p )$ is the indicator function with $chi ( p ) = 1$ for $p gt.eq 0$ and $chi ( p ) = 0$ for $p < 0$. One can also recover $u$ via $u ( t , x ) = e^p W ( t , x , p )$ for any $p > 0$. One can extend the domain of $p$ to $( - oo , oo )$, with $w = w ( t , x , p )$ satisfying $partial_t w + ( nabla_x^2 - V ( x ) ) partial_p w = 0$ with evenly extended initial condition $w ( 0 , x , p ) = exp ( - \| p \| u_0 ( x ) )$. Let $tilde(w) = tilde(w) ( t , x , eta )$ be the Fourier transform of $w$ in $p$ and $eta in bb(R)$ be the Fourier mode. Then $tilde(w)$ satisfies a system of #emph[uncoupled] Schrödinger equations $ i partial_t tilde(w) = eta ( - nabla_x^2 + V ( x ) ) tilde(w) , $<eq:heatschrodinger> one for each $eta$! See Appendix A for details. We call this the #emph[Schrödingerised heat equation]. The role of $eta$ can be interpreted as a recaling in time with $t arrow.r t eta$ for the Schrödinger equation $i partial_t tilde(w) = ( - nabla_x^2 + V ( x ) ) tilde(w)$. The rescaled time remains real-valued.


To solve these equations numerically, we discretise the system in $x$ and $p$, but not in $t$. We choose uniform mesh sizes $Delta x = 2 / M$ for the position variable in each dimension, $Delta p = 2 L / N$ for the $p$ variable, $Delta eta = 2 L / N$ for the $eta$ variable, where $M$ and $N$ are even positive integers and $L > 0$. We introduce the vector $bold(w) ( t ) = bold(w)_(\[ x \]) ⊗ bold(w)_(\[ p \])$ where the elements of the vector $bold(w)_(\[ x \])$ are $w ( t , x_i , p )$ with $i = 1 , . . . , M^d$ labelling the $x$ grid points and the elements of $bold(w)_(\[ p \])$ are $w ( t , x , p_j )$ with $p_j = j Delta p$, $j = - N / 2 , . . . , N / 2$. We define $tilde(bold(w)) = ( upright(bold(1))^(⊗ M^d) ⊗ cal(F)_p ) bold(w)$ where $cal(F)_p$ is the discrete Fourier transform with respect to variable $p$. Then the discretisation of the Schrödingerised heat equation in Eq.~#ref(<eq:heatschrodinger>) becomes the following system of $M^d N$ ODEs $ i frac(d, d t) tilde(bold(w)) ( t ) = ( bold(H) ⊗ bold(D) ) tilde(bold(w)) ( t ) = bold(H)_"total" tilde(bold(w)) ( t ) . $<eq:schrodinger> where $bold(H)_"total"$ is a Hermitian matrix. Here $bold(H) = ( - bold(P)_1^2 - . . . - bold(P)_d^2 + bold(V) )$ is also Hermitian, originating from the discretisation of the Schrödinger Hamiltonian $H$ in Eq.~#ref(<eq:heatequation>). We define the matrices $bold(P)_l = upright(bold(1))^(⊗ l - 1) ⊗ P_l ⊗ upright(bold(1))^(⊗ d - l)$, $l = 1 , . . . , d$, where $P_l$ is the discretisation of the momentum operator $- i partial_x$ with respect to the $l^"th"$ spatial variable. The matrix $bold(V) = "diag" ( V ( x_1 ) , . . . , V ( x_(M^d) ) )$ is a diagonal matrix with entries $V ( x_i )$. The matrix $bold(D) = "diag" ( mu_1 , . . . , mu_N )$ is also a diagonal matrix, with entries $mu_j = pi ( j - N / 2 )$.


It is clear that $tilde(bold(w)) ( t ) = exp ( - i bold(H)_"total" t ) tilde(bold(w)) ( 0 )$ and $bold(H)_"total"$, being Hermitian, can be interpreted as a time-independent Hamiltonian. We can define the quantum state $\| tilde(w) ( t ) chevron.r = ( 1 / parallel tilde(bold(w)) ( t ) parallel ) sum_(i = 1)^(M^d) sum_(j = - N / 2)^(N / 2) tilde(w) ( t , x_i , eta_j ) \| i , j chevron.r$ where $parallel tilde(bold(w)) ( t ) parallel^2 = sum_(i = 1)^(M^d) sum_(j = - N / 2)^(N / 2) \| tilde(w) ( t , x_i , eta_j ) \|^2$ is the $l_2$ norm squared of $tilde(bold(w)) ( t )$. From Eq.~#ref(<eq:schrodinger>) one can recover the quantum state with input quantum state $\| tilde(w) ( 0 ) chevron.r$ through $\| tilde(w) ( t ) chevron.r = exp ( - i bold(H)_"total" t ) \| tilde(w) ( 0 ) chevron.r$. By applying an inverse quantum Fourier transform $cal(F)_p^(- 1)$, with respect to $p$, onto the second register we obtain $\| w ( t ) chevron.r = ( upright(bold(1))^(⊗ M^d) ⊗ cal(F)_p^(- 1) ) \| tilde(w) ( t ) chevron.r$, where $\| w ( t ) chevron.r = ( 1 / parallel bold(w) ( t ) parallel ) sum_(i = 1)^(M^d) sum_(j = 1)^N w ( t , x_i , p_j ) \| i , j chevron.r$ and $parallel bold(w) ( t ) parallel = parallel tilde(bold(w)) ( t ) parallel$. From $\| w ( t ) chevron.r$ one can recover the quantum state of $u$ whose entries are proportional to the solutions of the heat equation $\| u ( t ) chevron.r = ( 1 / parallel bold(u) ( t ) parallel ) sum_(i = 1)^(M^d) u ( t , x_i ) \| i chevron.r$. We can do this by either projecting $\| w ( t ) chevron.r$ onto $upright(bold(1)) ⊗ sum_(k = N / 2)^N \| k chevron.r chevron.l k \|$ (projecting only onto $p > 0$), or using amplitude amplification to boost the chance of retrieving $\| u ( t ) chevron.r$ to probability $tilde parallel bold(u) ( 0 ) parallel / parallel bold(u) ( t ) parallel$.


We call this the #emph[Schrödingerisation approach] to prepare $\| u ( t ) chevron.r prop exp ( - bold(H) t ) \| u ( 0 ) chevron.r$, where $\| u ( t ) chevron.r$ evolves with respect to $bold(H)$ instead of $bold(H)_"total"$. The above method is in fact applicable to Hermitian $bold(H)$, with sparsity $s$ and max-norm $parallel bold(H) parallel_"max"$. We extend to non-Hermitian $bold(H)$ in the last section.


#figure(
  block([
Given sparse-access to a $D times D$ Hermitian matrix $bold(H)$ and the unitary $U_(i n i t i a l)$ that prepares the initial quantum state $\| u ( 0 ) chevron.r = U_(i n i t i a l) \| 0 chevron.r$. With the Schrödingerisation approach, the state $\| u ( t ) chevron.r$ can be prepared to precision $epsilon.alt$ with query and gate complexity $tilde(cal(O)) ( ( parallel bold(u) ( 0 ) parallel / parallel bold(u) ( t ) parallel ) s t parallel bold(H) parallel_"max" / epsilon.alt )$.
  ]),
  kind: "theorem",
  supplement: "Theorem",
) <thm:heatequation>
#block[
#emph[Proof.] See Appendix B.~◻

]


== Preparing quantum ground states and Gibbs states
<preparing-quantum-ground-states-and-gibbs-states>
Suppose one wants to prepare a $D$-dimensional ground state $\| E_0 chevron.r$ from a given state $\| u ( 0 ) chevron.r = sum_(j = 0)^(D - 1) alpha_j \| E_j chevron.r$, where $alpha_j in bb(C)$, $parallel bold(u) ( 0 ) parallel = 1$ and ${ \| E_j chevron.r }$ are the non-degenerate orthonormal eigenstates of a (Hermitian) $D times D$ Hamiltonian $bold(H)$. $bold(u) ( t )$ is the vector whose entries are the amplitudes of $\| u ( t ) chevron.r$. If one evolves $bold(u) ( t ) = exp ( - bold(H) t ) bold(u) ( 0 )$ according to $partial_t bold(u) = - bold(H) bold(u)$ with initial condition $bold(u) ( 0 )$, then one can write $\| u ( t ) chevron.r = ( 1 / parallel bold(u) ( t ) parallel ) sum_(j = 0)^(D - 1) alpha_j exp ( - E_j t ) \| E_j chevron.r$. Then $\| u ( t ) chevron.r = exp ( - bold(H) t ) \| u ( 0 ) chevron.r$ where $bold(H)$ is a $D times D$ Hermitian matrix with sparsity $s$ and max-norm $parallel bold(H) parallel_"max"$. Assuming the presence of a non-zero spectral gap $Delta = E_1 - E_0 > 0$, the convergence to the ground state $\| u ( t ) chevron.r arrow.r \| E_0 chevron.r$ is exponentially fast. If $t_"final"$ denotes the time where the quantum fidelity between the target ground state $\| E_0 chevron.r$ and the prepared state $\| u ( t ) chevron.r$ be $F ( \| E_0 chevron.r , \| u ( t ) chevron.r ) = 1 - epsilon.alt$ for a small $epsilon.alt > 0$, then the dominating contribution to $t_"final"$ is $cal(O) ( ( 1 / Delta ) ln ( 1 / ( epsilon.alt \| alpha_0 \|^2 ) ) )$. Combining this with @thm:heatequation, one sees the total query and gate complexity costs in preparing the ground state to fidelity $1 - epsilon.alt$ for $epsilon.alt lt.double 1$ is $tilde(cal(O)) ( s parallel bold(H) parallel_"max" / ( \| alpha_0 \| Delta epsilon.alt ) )$. Here the scaling in $\| alpha_0 \|$ and $Delta$ is comparable to non-heuristic schemes like quantum phase estimation @ge2019faster and near-optimal lower bounds for ground state preparation @lin2020near, up to logarithmic factors. The drawback is that this scheme has an extra factor $1 / epsilon.alt$ compared to the near-optimal schemes. This originates from $parallel bold(H) ⊗ bold(D) parallel_"max" tilde parallel bold(H) parallel_"max" / epsilon.alt$. It will be interesting to see if improvements to this factor can be achieved. For details see Appendix C.


To create the Gibbs state at temperature $T$ corresponding to the same $D times D$ Hamiltonian $bold(H)$, we can use the Schrödingerisation approach to prepare the normalised pure state $\| Psi ( beta ) chevron.r = sum_k sqrt(exp ( - beta E_k ) / Z) \| E_k E_k chevron.r$, where $Z = "Tr" ( exp ( - beta bold(H) ) )$ is the partition function for $bold(H)$ with $beta = 1 / ( k_B T )$ and $T$ is the temperature. Then by tracing out one register we obtain the Gibbs state $rho_(G i b b s) ( beta ) = sum_(j = 0)^(D - 1) exp ( - beta E_j ) \| E_j chevron.r chevron.l E_j \| = "Tr"_1 ( \| Psi ( beta ) chevron.r chevron.l Psi ( beta ) \| )$. This quantum simulation method differs from previous methods @poulin2009sampling that need to make use of quantum phase estimation to prepare $\| Psi ( beta ) chevron.r$. We rewrite $\| Psi ( beta ) chevron.r prop exp ( - ( beta / 2 ) ( bold(H) ⊗ upright(bold(1)) ) sum_(j = 0)^(D - 1) \| E_j E_j chevron.r$ where we can identify $\| u ( t ) chevron.r = \| Psi ( beta ) chevron.r$ by the application of $exp ( - ( bold(H) ⊗ upright(bold(1)) ) t )$, with time $t = beta / 2$, onto the state $\| u ( 0 ) chevron.r = ( 1 / sqrt(D) ) sum_(j = 0)^(D - 1) \| E_j E_j chevron.r$. The latter we assume is given. This is equivalent to performing the simple extension $bold(H) arrow.r bold(H) ⊗ upright(bold(1))$ in Eq.~#ref(<eq:schrodinger>), for any Hermitian $bold(H)$. Now $parallel u ( t ) parallel = sqrt(Z)$ and $parallel u ( 0 ) parallel = 1 / sqrt(D)$ where $D$ is the total number of energy levels. Then a straightforward application of @thm:heatequation means we can prepare $rho_(G i b b s) ( beta )$ to precision $epsilon.alt$ with query and gate complexity $tilde(cal(O)) ( s parallel bold(H) parallel_"max" beta sqrt(D / Z) / epsilon.alt )$. Heuristic methods aside, this coincides with the best-known scaling, to our knowledge, with respect to $D$ and $Z$ @poulin2009sampling @gilyen2019quantum.


= SCHRÖDINGERISATION OF LINEAR TRANSPORT EQUATION
<schrödingerisation-of-linear-transport-equation>


An interesting application of solving the linear transport equation (non-unitary dynamics) for a quantum problem is in simulating quantum states in random media in the semi-classical regime. Here we are interested in the evolution of a quantum system -- described by the Schrödinger equation -- in the presence of a random potential $U ( x ) = U_0 ( x ) + U_1 ( x / zeta )$. Here $U_0 ( x )$ is a deterministic, slowly moving background potential and $U_1$ is the random fluctuation depending on $x / zeta$, the fast spatial variable, and $R ( \| x - y \| ) = chevron.l U_1 ( x ) U_2 ( y ) chevron.r$ is the covariance of the fluctuations. We assume homogeneity and isotropy of the medium, where the differential scattering cross-section $sigma ( k , k' ) prop R ( k - k' ) delta ( k^2 - ( k' )^2 )$ with $tilde(R) ( \| k \| )$ being the power spectrum and $Sigma ( k )$ denotes the total scattering cross-section. In the semiclassical limit, the Wigner transform of the wave function will converge to the particle probability density function $W = W ( t , x , k )$ governed by the linear transport equation @ryzhik1996transport $ partial_t W + k dot.op nabla_x W = integral d k' sigma ( k , k' ) W ( t , x , k' ) - Sigma ( k ) W . $<eq:lineartranswigner> By Schrödingerising this equation, we can prepare, to precision $epsilon.alt$, the quantum state $\| W ( t ) chevron.r$ whose amplitudes are proportional $bold(W) ( t )$, which is the vector formed by taking $W$ at mesh points $( x_i , k_j )$ formed by discretising $x$ and $k$. Following the Schrödingerisation approach (see Appendix D for details), the corresponding $bold(H)_"total"$ for this problem is $bold(H)_"total" = bold(L)_(\[ xi , k \]) ⊗ bold(1) - upright(bold(1)) ⊗ bold(Sigma) ⊗ bold(D) + upright(bold(1)) ⊗ bold(sigma) ⊗ bold(D)$, where $bold(sigma)$ and $bold(Sigma)$ are the differential and total cross-section matrices. Matrix $bold(L)_(\[ xi , k \])$ has entries corresponding to $xi dot.op k$, where $xi$ is the Fourier mode of $x$ and arises from discretising $k dot.op nabla_x W$, which is a fundamental part of the transfer equation in Eq.~#ref(<eq:lineartranswigner>). This part exists whether or not the Schrödingerisation approach is used. Here $parallel bold(L)_(\[ xi , k \]) parallel_"max" tilde parallel bold(sigma) ⊗ bold(D) parallel_"max" tilde cal(O) ( 1 / epsilon.alt )$ where $bold(sigma)$ and $bold(Sigma)$ are order one factors. Since the warped transformation only adds one derivative in $p$ in the scattering term, and the new transformed equation remains first order, then the order of $parallel bold(H)_"total" parallel_"max"$ as the original transport equation. This means that the Schrödingerisation approach does not give rise to an extra $O ( 1 / epsilon.alt )$ factor compared to the original transport equation. Then to retrieve $\| W ( t ) chevron.r$, it can be shown that the query and gate complexities are respectively $tilde tilde(cal(O)) ( ( parallel bold(W) ( 0 ) parallel / parallel bold(W) ( t ) parallel ) s ( bold(sigma) ) / epsilon.alt )$ and $tilde tilde(cal(O)) ( ( parallel bold(W) ( 0 ) parallel / parallel bold(W) ( t ) parallel ) d s ( bold(sigma) ) / epsilon.alt )$, where $s ( bold(sigma) )$ is the sparsity of the differential cross-section matrix. This approach can also be applied to find the stationary state for $\| W ( t ) chevron.r$.


Here $d gt.eq 3$ and refers to the spatial dimension for Schrödinger's equation. It is also possible to interpret this in terms of multiple $n = d / 3$ particles each moving in three spatial dimensions so a high $d$ limit is a large $n$ limit. See Appendix D.


While $\| W ( t ) chevron.r$ not the usual output of a quantum simulator, which outputs directly a wavefunction $\| psi ( t ) chevron.r$, it is still possible to recover the semiclassical limit of the physical observables of $\| psi ( t ) chevron.r$ by taking the moments of $W$. Namely, any expectation value $chevron.l hat(G) chevron.r = chevron.l psi ( t ) \| hat(G) \| psi ( t ) chevron.r = integral.double d x d k W ( t , x , k ) g ( x , k )$, where $g ( x , k ) = 1 , k , k^2 / 2$, gives mass, momentum and energy respectively. Given access to the quantum state $\| g ( x , k ) chevron.r$ whose amplitudes are proportional to $g ( x , k )$ at mesh points $( x_i , k_j )$, $chevron.l hat(G) chevron.r$ is then proportional to the quantum fidelity between $\| g ( x , k ) chevron.r$ and $\| W ( t , x , k ) chevron.r$. This fidelity can be recovered in different ways, for instance, via a quantum swap-test @buhrman2001quantum.


= GENERAL FORMULATION
<general-formulation>


The Schrödingerisation approach can in fact be generalised to #emph[any] linear $( d + 1 )$-dimensional PDE for $u ( t , x )$. We study the PDE that is first-order in time. A system with higher-order derivatives in $t$ can be written as an enlarged system with first-order time-derivatives by introducing a new variable $u' = partial_t u$. Using the same discretisation scheme as before, where the entries of vector $bold(u) ( t )$ with size $M^d$ are solutions to a homogeneous linear PDE on the grid points $( t , x_i )$, we are left with a system of linear ODEs $ d bold(u) ( t ) / d t = - bold(A) bold(u) ( t ) , $ where the matrix $bold(A)$ is in general not Hermitian, unlike in the heat equation example. However, it is always possible to make the decomposition $bold(A) = bold(H) + i bold(macron(H))$ in terms of Hermitian matrices $bold(H) = ( bold(A) + bold(A)^dagger ) / 2$ and $bold(macron(H)) = i ( bold(A)^dagger - bold(A) ) / 2$. To ensure stability, we can assume $bold(H)$ to be positive semi-definite. The heat equation example belongs to the case $bold(macron(H)) = 0$, whereas purely Schrödinger dynamics corresponds to $bold(H) = 0$. A generalisation to inhomogeneous linear PDEs is possible by a straightforward dilation of $bold(u)$ and $bold(A)$. This is also useful for solving boundary value problems @schr2 by quantum simulation.


We can apply our warped phase transformation here to $bold(u) ( t )$ in the $p > 0$ region, $bold(v) ( t , p ) = e^(- p) bold(u) ( t )$, where the original solution can be recovered by using $bold(u) ( t ) = integral_(- oo)^oo chi ( p ) bold(v) ( t , p ) d p$. Just like for the heat equation, it is possible to extend the initial condition to $p < 0$ by defining $bold(v) ( 0 , p ) = exp ( - \| p \| ) bold(u) ( 0 )$ and in the $p in ( - oo , oo )$ region $bold(v) ( t , p )$ satisfies $partial_t bold(v) + bold(H) partial_p bold(v) - i bold(macron(H)) bold(v) = 0$. Let $tilde(bold(v)) ( t , eta )$, $eta in bb(R)$ be the Fourier transform of $bold(v)$ in $p$, we obtain the generalisation of Eq.~#ref(<eq:schrodinger>) $ i partial_t tilde(bold(v)) = ( eta bold(H) + bold(macron(H)) ) tilde(bold(v)) $ which is still a system of Schrödinger equations, one for each $eta$, since $eta bold(H) + bold(macron(H))$ is Hermitian. Note this form is not, in a strict sense, Schrödinger's equations per se, where the Hamiltonian is usually a Laplacian plus a potential function. However, the first order differential operator can be cast explicitly into the Schrödinger form by making another warped phase transformation. We omit the details here since it's not crucial for quantum simulation to be possible. As previously, we can proceed by discretising $eta$ to obtain $ i frac(d, d t) tilde(bold(v)) = ( bold(H) ⊗ bold(D) + bold(macron(H)) ⊗ upright(bold(1)) ) tilde(bold(v)) = bold(H)_"total" tilde(bold(v)) , $ and the state evolves $tilde(bold(v)) ( t ) = exp ( i bold(H)_"total" t ) tilde(bold(v)) ( 0 )$ with respect to unitary dynamics. Let $s tilde max ( s ( bold(H) ) , s ( bold(macron(H)) ) )$ be the maximum of the sparsity of $bold(H)$ and $bold(macron(H))$. The max-norm $parallel bold(H)_"total" parallel_"max" tilde max ( parallel bold(H) parallel_"max" / epsilon.alt , parallel bold(macron(H)) parallel_"max" )$. For instance, in the transport equation case, the two terms in the latter expression are of the same order. Then we can simulate $\| u ( t ) chevron.r$ with the following resources, where the proof follows in the same way as @thm:heatequation with $D = M^d$.

#figure(
  block([
Given sparse access to the $M^d times M^d$ matrix $bold(H)_"total"$ and the unitary $U_(i n i t i a l)$ that prepares the initial quantum state $\| bold(u) ( 0 ) chevron.r$ to precision $epsilon.alt$. With the Schrödingerisation approach, the state $\| bold(u) ( t ) chevron.r$ can be prepared with query complexity $tilde(cal(O)) ( ( parallel bold(u) ( 0 ) parallel / parallel bold(u) ( t ) parallel ) s t parallel bold(H)_"total" parallel_"max" )$ and $tilde(cal(O)) ( parallel bold(u) ( 0 ) parallel / parallel bold(u) ( t ) parallel d t s parallel bold(H)_"total" parallel_"max" )$ additional two-qubit gates.
  ]),
  kind: "theorem",
  supplement: "Theorem",
) <thm:general>


= DISCUSSION
<discussion>


We have introduced a conceptually new method, called Schrödingerisation, which makes it possible to simulate solutions of any linear partial differential equations using quantum simulation. This method is framed in the traditional language of dynamical equations. The connection between classical dynamics and its corresponding Schrödinger's equations can be seen more easily at the level of the dynamical equations without more sophisticated methods.


For more in-depth technical details, discussions and applications to other linear PDEs like Liouville, Fokker-Planck, Vlaslov-Fokker-Planck, Black-Scholes equations and nonlinear ODEs, please see our technical companion paper @schr2.

= ACKNOWLEDGEMENTS
<acknowledgements>
SJ was partially supported by the NSFC grant No.~12031013, the Shanghai Municipal Science and Technology Major Project (2021SHZDZX0102), and the Innovation Program of Shanghai Municipal Education Commission (No. 2021-01-07-00-02-E00087). NL acknowledges funding from the Science and Technology Program of Shanghai, China (21JC1402900).





= APPENDIX A: WARPED PHASE TRANSFORMATION



Here we define in the $p > 0$ region
$ w ( t , x , p ) = e^(- p) u ( t , x ) , quad p > 0 . $
A simple calculation shows
$ partial_t w + partial_p nabla_x w = 0 , quad p > 0 . $ <eq:heatreformulation>
We can recover $u$ using $w$ via
$ & u ( t , x ) = integral_0^infinity w ( t , x , p ) dif p \
  & = integral_(- infinity)^infinity chi ( p ) w ( t , x , p ) dif p , $ <eq:integration>
where $chi ( p ) = 1$ for $p > 0$ and $chi ( p ) = 0$ for $p < 0$. Alternatively, one can also choose any $p_(*) > 0$ and let
$ u ( t , x ) = e^(p_(*)) w ( t , x , p_(*) ) . $ <eq:point>
Now we want to see that no boundary condition is required at $p = 0$. Assume $x$ is defined in a periodic domain and we apply the Fourier transform on $w$ with respect to $x$, denoted $hat(w) ( t , xi , p )$, with Fourier modes $xi = ( xi_1 , dots.h , xi_d )^T$. One then arrives at a convection equation $partial_t hat(w) - \| xi \|^2 partial_p hat(w) = 0$, where $\| xi \|^2 = xi_1^2 + dots.h + xi_d^2$. Here the solution $hat(w)$ moves from the right to the left, so no boundary condition is needed at $p = 0$.


For the convenience of numerical approximation, we extend the domain to $p < 0$. This extension will not affect the solution of $w$ in the region $p > 0$ since $w$ convects from right to the left. Thus, we can symmetrically extend the initial data of $w$ to $p < 0$ and keep Eq.~#ref(<eq:heatreformulation>):
$ cases( partial_t w + Delta_x partial_p w = 0 , quad p in ( - infinity , infinity ) , w ( 0 , x , p ) = e^(-\|p\|) u_0 ( x ) . ) $ <eq:heatreformulationextend>
The only difference is that now the initial condition is $w ( 0 , x , p ) = exp ( - \| p \| ) u_0 ( x )$ for $p in ( - oo , oo )$ instead of just $w ( 0 , x , p ) = exp ( - p ) u_0 ( x )$ for $p > 0$.


The solution coincides with the solution of Eq.~#ref(<eq:heatreformulation>) when $p > 0$. Due to the exponential decay of $e^(-\|p\|)$ one can (computationally) impose the periodic boundary condition $w ( t , x , p = - L ) = w ( t , x , p = L ) = 0$ along the $p$-direction for some $L > 0$ suitably large but finite. Then the Fourier transform on $w$ with respect to $p$ gives
$ partial_t tilde(w) - i eta nabla_x^2 tilde(w) = 0 quad "or" quad i partial_t tilde(w) = - eta nabla_x^2 tilde(w) , $ <eq:heat-Schro>
where $tilde(w) ( t , x , eta )$, $eta in bb(R)$, is the Fourier transform of $w$ in $p$. Eq.~#ref(<eq:heat-Schro>) is clearly the Schrödinger equation, for every $eta$!


For more details and numerical experiments on justifying the setup in Eq.~#ref(<eq:heatreformulationextend>, supplement: none), see our technical companion paper @schr2.


= APPENDIX B: PROOF OF @thm:heatequation



From Eq.~#ref(<eq:schrodinger>) one can prepare the $tilde(cal(O)) ( log ( D ) )$-qubit state $\| tilde(w) ( t ) chevron.r = exp ( - i bold(H)_"total" t ) \| tilde(w) ( 0 ) chevron.r$ by simulating the Hamiltonian $bold(H)_"total" = bold(H) ⊗ bold(D)$ to time $t$. Here the results hold so long as $bold(H)$ is Hermitian. Let $s$ and $parallel bold(H) parallel_"max"$ be the sparsity and max-norm of a more general $D times D$ Hermitian matrix $bold(H)$.


Then, given $\| tilde(w) ( 0 ) chevron.r$, one can apply @eq:lemmasimulation, so that one prepares $\| tilde(w) ( t ) chevron.r$ with query and gate complexity $tilde(cal(O)) ( s parallel bold(H)_"total" parallel_"max" t )$, where $tilde(cal(O))$ denotes that logarithmic terms, like $log ( D )$ and $log ( 1 / epsilon.alt )$, are ignored. Now $parallel bold(H)_"total" parallel_"max" = parallel bold(H) parallel_"max" parallel bold(D) parallel_"max"$, where $parallel bold(D) parallel_"max" = cal(O) ( N )$ by definition and $N = cal(O) ( 1 / epsilon.alt )$. Thus $tilde(cal(O)) ( s t parallel bold(H)_"total" parallel_"max" ) = tilde(cal(O)) ( s t parallel bold(H) parallel_"max" / epsilon.alt )$.


From $\| tilde(w) ( t ) chevron.r$ that results from the Hamiltonian simulation problem, the simplest way to prepare $\| u ( t ) chevron.r$ from $\| tilde(w) ( t ) chevron.r$ is to project $\| tilde(w) ( t ) chevron.r$ with operator $hat(P) = upright(bold(1)) ⊗ sum_(k = N / 2)^N \| k chevron.r chevron.l k \|$ (which projects only onto $p > 0$ states). This leads to $ & hat(P) \| w ( t ) chevron.r \
  & = frac(parallel u ( t ) parallel parallel exp ( - p ) parallel, parallel w ( t ) parallel) \| exp ( - p ) chevron.r \| u ( t ) chevron.r $ where $\| exp ( - p ) chevron.r = ( 1 / parallel exp ( - p ) parallel ) sum_(k = N / 2)^N exp ( - p_k ) \| k chevron.r$ with normalisation constant $parallel exp ( - p ) parallel^2 = sum_(k = N / 2)^N exp ( - 2 p_k ) tilde cal(O) ( N integral_0^oo exp ( - 2 p ) d p ) = cal(O) ( N )$. Thus a simple projection retrieves $\| u ( t ) chevron.r$ with probability $( parallel u ( t ) parallel parallel exp ( - p ) parallel / parallel w ( t ) parallel )^2 tilde N ( parallel u ( t ) parallel / parallel w ( t ) parallel )^2$. We also used $parallel tilde(w) ( t ) parallel = parallel w ( t ) parallel$.


One can also use amplitude amplification to boost this probability to $sqrt(N) parallel u ( t ) parallel / parallel w ( t ) parallel$ in the usual manner, by assuming access to the oracle $Q = - S_w S_p$ where $S_w = upright(bold(1)) - \| w ( t ) chevron.r chevron.l w ( t ) \|$ and $S_p = upright(bold(1)) - 2 hat(P)$ @brassard2002quantum. This means $tilde(cal(O)) ( parallel w ( t ) parallel / ( sqrt(N) parallel u ( t ) parallel ) )$ queries to $Q$ is sufficient. Combining this with @eq:lemmasimulation, we see that this requires a total query complexity of $tilde(cal(O)) ( s t parallel bold(H) parallel_"max" parallel w ( t ) parallel / ( sqrt(N) parallel u ( t ) parallel ) )$.


It can be shown, using the quadrature rule, that $( 1 / ( M^d N ) ) parallel w ( t ) parallel^2 approx integral.double_(- oo)^oo d x d p \| w ( t , x , p ) \|^2 = integral_(- oo)^oo \| u ( 0 ) \|^2 approx ( 1 / M^d ) parallel u ( 0 ) parallel^2$. Thus $parallel w ( t ) parallel / ( sqrt(N) parallel u ( t ) parallel ) = parallel u ( 0 ) parallel / parallel u ( t ) parallel$.


In the above, we assumed access to $\| tilde(w) ( 0 ) chevron.r$, while it is more natural to assume access to $\| u ( 0 ) chevron.r$. It is straightforward to obtain the initial state $\| tilde(w) ( 0 ) chevron.r$ from $\| u ( 0 ) chevron.r$. Since $w ( 0 , x , p ) = exp ( - \| p \| ) u ( 0 , x )$, then $\| w ( 0 ) chevron.r = \| u ( 0 ) chevron.r \| exp ( - p ) chevron.r$, where we assume we can prepare the state $\| exp ( - p ) chevron.r$. Then applying the quantum Fourier transform to $\| w ( 0 ) chevron.r$, with respect to $p$, gives $\| tilde(w) ( 0 ) chevron.r$. To perform an inverse Fourier transform, only $tilde(cal(O)) ( 1 )$ two-qubit gates are required, since we have only $log ( N )$ qubits in the $p$-variable. The number of qubits in $\| tilde(w) ( t ) chevron.r$ is $log ( D N )$.


Thus, when given $\| u ( 0 ) chevron.r$, the total query and gate complexity to prepare $\| u ( t ) chevron.r$ is $tilde(cal(O)) ( ( parallel u ( 0 ) parallel / parallel u ( t ) parallel ) s t parallel bold(H) parallel_"max" / epsilon.alt )$.


= APPENDIX C: PREPARATION OF QUANTUM GROUND STATE VIA SCHRÖDINGERISATION

Given a (Hermitian) Hamiltonian $bold(H)$, an important question is how to prepare its ground state. If given a quantum state $\| u ( 0 ) chevron.r$, where $parallel u ( 0 ) parallel = 1$, then unitary evolution with respect to a time-independent $bold(H)$ for time $tau$ gives $\| u ( tau ) chevron.r = exp ( - i bold(H) tau ) \| u ( 0 ) chevron.r$. Here it is not clear at what time $t$ one might be able to retrieve the ground state, if at all. So an extension to non-unitary evolution would be helpful.


One method is the imaginary time evolution approach, which maps $tau arrow.r t = i tau$. In this case, one can write the non-unitary evolution as $ \| u ( t ) chevron.r = frac(e^(- bold(H) t), parallel u ( t ) parallel) \| u ( 0 ) chevron.r . $<eq:heatsolutionnormalised> Since this is now non-unitary evolution $parallel u ( t ) parallel eq.not parallel u ( t = 0 ) parallel$. However, there is now no direct way to transform the solution $\| u ( tau ) chevron.r$ into Eq.~#ref(<eq:heatsolutionnormalised>) since there is no $tau arrow.r t$ conversion that can be used once the solutions are obtained. The two solutions will only agree in the stationary limit $partial u / partial t = 0$. One can instead use an indirect method @motta2020determining, where for each $t$, one finds the corresponding Hamiltonian evolving with $tau$, by making tomographic measurements of $\| u chevron.r$ at every small time-step. We seek a more direct method, without intervening the quantum system during the process, that still allows us to perform this non-unitary evolution.


What we lose in unitarity of evolution in Eq.~#ref(<eq:heatsolutionnormalised>), we gain in the simplicity of seeing ground states emerge. Let the orthonormal eigenfunctions of $bold(H)$ be ${ E_j chevron.r }$ for $j = 1 , . . . , D$. We can thus decompose $\| u ( 0 ) chevron.r$ $ \| u ( 0 ) chevron.r = sum_(j = 0)^(D - 1) alpha_j \| E_j chevron.r , quad alpha_j in bb(C) $ with corresponding eigenvalues $E_j$ where $sum_(j = 0)^(D - 1) \| alpha_j \|^2 = 1$. Then it is clear, if we evolve non-unitarily, $ & \| u ( t ) chevron.r = frac(e^(- bold(H) t), parallel u ( t ) parallel) \| u ( 0 ) chevron.r \
  & = frac(1, parallel u ( t ) parallel) sum_(j = 0)^(D - 1) alpha_j e^(- E_j t) \| E_j chevron.r $ This means that for low eigenenergies, the decay is the slowest and $\| E_0 chevron.r$ would emerge as $t arrow.r oo$ for gapped Hamiltonians. Furthermore, the convergence rate toward the ground state is exponential with the decay rate of $exp ( ( E_0 - E_1 ) t )$, if there is a spectral gap, i.e., $E_1 > E_0$.


Here we can use Schrödingerisation to obtain the state $\| u ( t ) chevron.r prop exp ( - bold(H) t ) \| u ( 0 ) chevron.r$. To specify how long $t$ we need to evolve, let $t_"final"$ be the minimum evolution time so that quantum fidelity between the prepared $\| u ( t_"final" ) chevron.r$ state and the true ground state $\| E_0 chevron.r$ is greater or equal to $1 - epsilon.alt$, i.e., $ & \| chevron.l u ( t_"final" ) \| E_0 chevron.r \|^2 \
  & = frac(\| alpha_0 \|^2 e^(- 2 E_0 t_"final"), parallel u ( t_"final" ) parallel^2) gt.eq 1 - epsilon.alt $<eq:fidelitycondition> for some $epsilon.alt lt.double 1$. For a normalised initial state $parallel u ( 0 ) parallel = 1$ we have $ parallel u ( t ) parallel = parallel e^(- bold(H) t) \| u ( 0 ) chevron.r parallel . $<eq:psitaunorm> thus $parallel u ( t ) parallel^2 = \| alpha_0 \|^2 exp ( - 2 E_0 t ) ( 1 + ( \| alpha_1 \| / \| alpha_0 \| )^2 exp ( - 2 Delta t ) ) + L$ where $0 < Delta = E_1 - E_0$ is the spectral gap and we can assume $L = sum_(k gt.eq 2) \| alpha_k \|^2 e^(- 2 t E_k) lt.double 1$ for $t gt.double 1$. Then for $delta lt.double 1$, one can insert this into Eq.~#ref(<eq:fidelitycondition>) and obtain $ & t_"final" gt.tilde ( 1 / 2 Delta ) ln ( \| alpha_1 \|^2 / ( epsilon.alt \| alpha_0 \|^2 ) \
  & quad tilde ( 1 / Delta ) ln ( 1 / ( epsilon.alt \| alpha_0 \|^2 ) ) $ when $\| alpha_k \| lt.double 1$ for all $k gt.eq 2$.


Inserting $t = t_"final"$ in @thm:heatequation and $E_0 lt.double t_"final"$, one gets the total query and gate complexity $tilde(cal(O)) ( s parallel bold(H) parallel_"max" / ( \| alpha_0 \| Delta epsilon.alt ) )$ for preparing the ground state of $bold(H)$.


The proof for Gibbs state preparation proceeds similarly, except there $t prop 1 / T$ where $T$ is the temperature of the Gibbs state.


= APPENDIX D: TRANSPORT EQUATION AND QUANTUM SYSTEMS IN RANDOM MEDIA



Energy conservation for general wave problems is given by the transport equation for the scalar energy density $ partial_t f + nabla_k omega dot.op nabla_x f - nabla_x omega dot.op nabla_k f = S , $<eq:transport> with initial condition $f ( 0 , x , k ) = f_0 ( x , k )$, where $f = f ( t , x , k )$ is the scalar energy density and $omega = omega ( x , k )$ is the frequency of the wave with wave vector $k in bb(S)^(d - 1)$ at point $x in \[ - 1 , 1 \]^d$. We assume periodic boundary conditions are imposed. Here $S = integral d k' ( sigma ( x , k , k' ) f ( t , x , k' ) - Sigma ( x , k ) f )$ where $sigma = sigma ( x , k , k' )$ is the differential scattering cross section and $Sigma ( x , k ) = integral d k' sigma ( x , k' , k )$ is the total cross-section.


An interesting example of this equation for a quantum problem appears in the simulation of quantum states in random media in the semi-classical regime. Here we study the evolution of a quantum system in the presence of a random potential $U ( x ) = U_0 ( x ) + U_1 ( x / zeta )$ where $U_0 ( x )$ is a deterministic slowly moving background potential, $U_1$ is the random fluctuation depending on $x / zeta$, the fast spatial variable.


Let $R ( \| x - y \| ) = chevron.l U_1 ( x ) U_2 ( y ) chevron.r$ be the covariance of the fluctuations, which are assumed to be spatially homogeneous and isotropic, and $R ( \| k \| ) = ( 1 / ( 2 pi ) )^d integral d k exp ( i k y ) R ( x )$ is the power spectrum. The differential cross-section and the total cross-section in this case are respectively $sigma ( k , k' ) / ( 4 pi ) = R ( k - k' ) delta ( k^2 - ( k' )^2 )$ and $Sigma ( k ) / ( 4 pi ) = integral d k' R ( k - k' ) delta ( k^2 - ( k' )^2 )$. For the Schrödinger equation, $omega^2 = k^2 / 2 + U_0 ( x ) = k^2 / 2$, we can ignore the slowly-moving background potential $U_0 ( x )$.


The semiclassical or weakly coupling limit of the Wigner function for the quantum system in this random medium, which is the particle density distribution, solves the transport equation in Eq.~#ref(<eq:transport>) @ryzhik1996transport and for any $d gt.eq 3$ the above forms of the cross-sections hold (Born approximation) @erdHos2000linear and $ & partial_t W + k dot.op nabla_x W \
  & = integral d k' sigma ( k , k' ) W ( t , x , k' ) - Sigma ( k ) W . $<eq:wignerpde>


We can apply the warped phase transformation $V = V ( t , x , k , p ) = exp ( - p ) W$ to get $ & partial_t V + k dot.op nabla_x V \
  & = - integral d k' sigma ( k , k' ) partial_p V ( t , x , k' , p ) + Sigma ( k ) partial_p V . $<eq:vequation> Now apply a Fourier transform with respect to #emph[both] the $x$ and $p$ variables, which have respective conjugate variables $xi in bb(R)^d$ and $eta in bb(R)$ and define this Fourier transform as $ & tilde(V) = tilde(V) ( t , xi , k , eta ) \
  & = integral d x d p thin e^(- i eta p) e^(- i xi x) V ( t , x , k , p ) . $ Using Eq.~#ref(<eq:vequation>), it is simple to see that $tilde(V)$ obeys $ & i partial_t tilde(V) = ( k dot.op xi - eta Sigma ( k ) ) tilde(V) \
  & quad + eta integral d k' sigma ( k , k' ) tilde(V) ( t , xi , k' , eta ) . $<eq:tildev> We discretise in $xi , k$ and $eta$ with $Delta xi = 2 / J$, $Delta k = 2 / K$ and $Delta eta = 2 / N$ for positive even integers $J , K , N$. Let $bold(tilde(V)) ( t ) = bold(tilde(V))_(\[ xi \]) ⊗ bold(tilde(V))_(\[ k \]) ⊗ bold(tilde(V))_(\[ p \])$ be the vector formed by the discretisation of $tilde(V)$ in $xi , k$ and $eta$. Here each element of $bold(tilde(V))_(\[ x \])$ denotes $tilde(V) ( t , xi_i , k , eta )$ with $i = 1 , . . . , J^d$ labelling the $xi$ grid points, each element of $bold(tilde(V))_(\[ k \])$ is $tilde(V) ( t , xi , k_j , eta )$ with $j = 1 , . . . , K^d$ labelling the $k$ grid points and the elements of $bold(tilde(V))_(\[ eta \])$ are $tilde(V) ( t , xi , k , eta_k )$ with $k = 1 , . . . , N$. One can then use the quadrature rule for the last term of Eq.~#ref(<eq:tildev>) to write $ & integral d k' sigma ( k , k' ) tilde(V) ( t , xi , k' , eta ) \
  & approx sum_(j' = 1)^(K^d) sigma_(j , j') tilde(V) ( t , xi , k'_(j') , eta ) $ where $sigma_(j , j') = sigma ( k_j , k'_(j') ) / K^d$ are the elements of a symmetric (and Hermitian) matrix $bold(sigma)$, since we are looking at isotropic scattering. Then from Eq.~#ref(<eq:tildev>) the vector $bold(tilde(V)) ( t )$ obeys $ i frac(d bold(tilde(V)), d t) = bold(H)_"total" bold(tilde(V)) $<eq:boltzmannfinal> where the matrix $bold(H)$ is Hermitian $ & bold(H)_"total" = bold(L)_(\[ xi , k \]) ⊗ bold(1) \
  & quad - upright(bold(1)) ⊗ bold(Sigma) ⊗ bold(D) + upright(bold(1)) ⊗ bold(sigma) ⊗ bold(D) . $<eq:hboltzmann> Here $bold(D) = "diag" ( mu_1 , . . . , mu_N )$ with $mu_k = pi ( k - N / 2 )$ and $bold(Sigma) = "diag" ( Sigma ( k_1 ) , . . . , Sigma ( k_(K^d) ) )$. The matrix $bold(L)_(\[ xi , k \])$ acts on $bold(tilde(V))_(\[ xi \]) ⊗ bold(tilde(V))_(\[ k \])$ and multiplies its $( i , j )^"th"$ component it by factor $xi_i dot.op k_j$.


Since $bold(H)_"max"$ is Hermitian, one can use Hamiltonian simulation methods in Eq.~#ref(<eq:boltzmannfinal>) where $bold(tilde(V)) ( t ) = exp ( - i bold(H)_"total" t ) bold(tilde(V)) ( 0 )$ and one can prepare the quantum state $\| tilde(V) ( t ) chevron.r = ( 1 / parallel bold(tilde(V)) ( t ) parallel ) sum_(i = 1)^(J^d) sum_(j = 1)^(K^d) sum_(k = 1)^N bold(tilde(V)) ( t ) \| i , j , k chevron.r$ by just evolving the Hamiltonian $bold(H)_"total"$, when given the initial state $\| V ( 0 ) chevron.r$. Note that $parallel bold(tilde(V)) ( t ) parallel = parallel bold(tilde(V)) ( 0 ) parallel$ since $bold(tilde(V)) ( t )$ evolves by a unitary transformation. This can be used to prepare the quantum state whose amplitude is proportional to the average Wigner function of the quantum state in a random medium in the following way.


Let $bold(W) ( t )$ be the vector whose elements are $W ( t , x_i , k_j )$ at grid points $( x_i , k_j )$. Suppose we want to prepare the quantum state $\| W ( t ) chevron.r = ( 1 / parallel bold(W) ( t ) parallel ) sum_(i = 1)^(M^d) sum_(j = 1)^(K^d) bold(W) ( t ) \| i , j chevron.r$. By definition, $bold(V) ( t ) = ( cal(F)_x^(- 1) ⊗ upright(bold(1)) ⊗ cal(F)_p^(- 1) ) bold(tilde(V)) ( t )$, where $cal(F)_(( dot.op ))^(- 1)$ is the inverse Fourier transform with respect to variable $( dot.op )$ and $bold(V) ( t )$ is the discretisation of the warped phase transformation $V ( t , x , k , p )$. Then $\| V ( t ) chevron.r = ( 1 / parallel bold(V) ( t ) parallel ) sum_(i = 1)^(M^d) sum_(j = 1)^(K^d) sum_(k = 1)^N bold(W) ( t ) exp ( - p_k ) \| i , j , k chevron.r$. Fourier transforms do not change norms, so $parallel bold(V) ( t ) parallel = parallel bold(tilde(V)) ( t ) parallel = parallel bold(tilde(V)) ( 0 ) parallel = parallel bold(V) ( 0 ) parallel$. We can use the projection $hat(P)$ in Appendix B and show $\| W ( t ) chevron.r$ and $\| tilde(V) ( t ) chevron.r$ are related by
$ & hat(P) ( cal(F)_x^(-1) ⊗ upright(bold(1)) ⊗ cal(F)_p^(-1) ) \| tilde(V) ( t ) chevron.r \
  & = frac(norm(bold(W) ( t )), norm(bold(V) ( 0 ))) \| W ( t ) chevron.r sum_(k = 1)^N e^(-p_k) \| k chevron.r \
  & = frac(norm(bold(W) ( t )) norm(exp ( - p )), norm(bold(V) ( 0 ))) \| W ( t ) chevron.r \| exp ( - p ) chevron.r $
where $\| exp ( - p ) chevron.r$ is the state with normalisation constant $parallel exp ( - p ) parallel tilde(cal(O)) ( sqrt(N) )$, as defined in Appendix B. Then following similar methods in Appendix B, it can be proved that $parallel bold(V) ( 0 ) parallel / parallel bold(W) ( t ) parallel tilde(sqrt(N)) parallel bold(W) ( 0 ) parallel / parallel bold(W) ( t ) parallel$.


The proof of the resource cost in obtaining $\| W ( t ) chevron.r$ follows in the same way as shown in Appendix B. Let $s$ be the sparsity of $bold(H)_"max"$ and $parallel bold(H)_"total" parallel_"max"$ is its max-norm. Then following @eq:lemmasimulation, we see that, given $\| W ( 0 ) chevron.r$, the query and gate complexities to obtain $\| W ( t ) chevron.r$ are respectively $tilde(cal(O)) ( ( parallel bold(W) ( 0 ) parallel / parallel bold(W) ( t ) parallel ) s t parallel bold(H)_"total" parallel_"max" )$ and $tilde(cal(O)) ( ( parallel bold(W) ( 0 ) parallel / parallel bold(W) ( t ) parallel ) d s t parallel bold(H)_"total" parallel_"max" )$.


From Eq.~#ref(<eq:hboltzmann>), one sees that the sparsity $s$ is dominated by $s ( bold(sigma) )$, which is the sparsity of $bold(sigma)$. This means the more off-diagonal terms in $bold(sigma)$ (corresponding to more scattering to different wave vectors), the larger the cost in preparing $\| W ( t ) chevron.r$. To find the max-norm $parallel bold(H)_"total" parallel_"max"$, we note that $parallel bold(L)_(\[ xi , k \]) parallel_"max" tilde parallel bold(sigma) ⊗ bold(D) parallel_"max" tilde parallel bold(sigma) ⊗ bold(D) parallel_"max" tilde cal(O) ( 1 / epsilon.alt )$ where $bold(sigma)$ and $bold(Sigma)$ are order one factors. This means that the Schrödingerisation approach oes not change the order of $parallel bold(H)_"total" parallel_"max"$, since the transformed equation remains first order as the original equation.


We can also apply this to finding the stationary state of the semiclassical limit of the Wigner function, i.e., $\| W ( t_s ) chevron.r$ when $d bold(W) ( t ) / d t \|_(t = t_s) = 0$. The analysis proceeds in the same way to preparing the ground state in Appendix C. The transport operator in Eq.~#ref(<eq:transport>) is dissipative, or rather hypocoercivity, with spectral gap shown in @Mouhot. In the case of isotropic scattering, the spectra includes $0$ and all other strictly negative ones, depending on Chandrasekhar's H-function @Chand. We can thus use $E_0 = 0$ in this case and the same cost as in Appendix C follows.


We can also extend the above analysis in the high $d$ limit by reinterpreting as a multiparticle $n = d / 3$ limit with each particle moving in three spatial dimensions. However, in this case, $omega^2 = k^2 / 2 + U_C$ since the interparticle interactions with a potential $U_C$ (e.g. Coulomb) needs to be included. This means we need to augment Eq.~#ref(<eq:wignerpde>) by an extra term
$ & partial_t W + k dot.op nabla_x W - nabla_x U_C dot.op nabla_k W \
  & = integral d k' sigma ( k , k' ) W ( t , x , k' ) - Sigma ( k ) W . $ <eq:wignerpde2>
Here we omit the precise details (see @schr2), but one can discretise in $x$, $k$ and rewrite this as a system of linear ODEs and apply the general formalism.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: none)
