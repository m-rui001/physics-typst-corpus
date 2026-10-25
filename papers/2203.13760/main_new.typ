#import "@preview/cetz:0.4.0": canvas
#import "@preview/cetz-plot:0.1.2": plot

#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10pt, lang: "en")
#set page(paper: "a4", numbering: "1", margin: (x: 3cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#set math.equation(numbering: "(1)", supplement: none)

#let d(name) = csv("data/" + name + ".csv", row-type: array).map(r => (float(r.at(0)), float(r.at(1))))
#let c0 = rgb("#0065BD")
#let c1 = rgb("#E37222")
#let c2 = rgb("#A2AD00")
#let code(s) = raw(s, lang: "python")

// cetz draws axis labels outside the canvas box; reserve room so panels don't collide
#let pbox(body) = box(inset: (left: 1.2cm, bottom: 0.9cm, top: 0.1cm, right: 0.1cm), body)

#let listing(path, lang: "python") = {
  let lines = read(path).split("\n")
  if lines.len() > 0 and lines.last() == "" { lines = lines.slice(0, -1) }
  block(
    width: 100%, inset: (x: 6pt, y: 4pt), stroke: 0.4pt + luma(140),
    text(size: 7.4pt, font: "DejaVu Sans Mono", {
      set par(justify: false)
      grid(
        columns: (auto, 1fr),
        column-gutter: 8pt,
        align: (right + top, left + top),
        ..lines.enumerate().map(((i, l)) => (
          text(fill: luma(130))[#(i + 1)],
          raw(l, lang: lang),
        )).flatten(),
      )
    })
  )
}

#align(center)[
  #text(16pt, weight: "bold", hyphenate: false, [JAX-FLUIDS: A fully-differentiable high-order computational fluid dynamics solver for compressible two-phase flows])
  #v(1em)
  #text(11pt)[Deniz A. Bezgin#super[1,2]#sym.ast.basic, Aaron B. Buhendwa#super[1,2]#sym.ast.basic, Nikolaus A. Adams#super[1]]
  #v(0.8em)
  #text(9pt)[#super[1] Technical University of Munich, School of Engineering and Design, Chair of Aerodynamics and Fluid Mechanics, Boltzmannstr. 15, 85748 Garching bei München, Germany]
  #linebreak()
  #text(9pt)[#super[2] Both authors contributed equally]
  #linebreak()
  #text(9pt)[#sym.ast.basic Corresponding authors]
]
#v(0.6em)

#block(width: 100%, inset: (x: 1.2em, y: 1em))[
#align(center)[#text(weight: "bold")[Abstract]]
Physical systems are governed by partial differential equations (PDEs). The Navier-Stokes equations describe fluid flows and are representative of nonlinear physical systems  with complex spatio-temporal interactions. Fluid flows are omnipresent in nature and engineering applications, and their accurate simulation is essential for providing insights into these processes. While PDEs are typically solved with numerical methods, the recent success of machine learning (ML) has shown that ML methods can provide novel avenues of finding solutions to PDEs. ML is becoming more and more present in computational fluid dynamics (CFD). However, up to this date, there does not exist a general-purpose ML-CFD package which provides 1) powerful state-of-the-art  numerical methods, 2) seamless hybridization of ML with CFD, and 3) automatic differentiation (AD) capabilities. AD in particular is essential to ML-CFD research as it provides gradient information and enables  optimization of preexisting and novel CFD models.  In this work, we propose JAX-FLUIDS: a comprehensive fully-differentiable CFD Python solver for compressible  two-phase flows. JAX-FLUIDS allows the simulation of complex fluid dynamics with phenomena like three-dimensional turbulence,  compressibility effects, and two-phase flows. Written entirely in JAX, it is straightforward to include existing ML models into the proposed framework. Furthermore, JAX-FLUIDS enables end-to-end optimization. I.e., ML models can be optimized with gradients that are backpropagated through the entire CFD algorithm, and therefore contain not only information of the underlying PDE but also of the applied numerical methods. We believe that a Python package like JAX-FLUIDS is crucial to facilitate research at the intersection of ML and CFD and may pave the way for an era of differentiable fluid dynamics.
]

#v(0.8em)
#align(center)[#text(9pt)[*Keywords:* Computational fluid dynamics, machine learning, differential programming, Navier-Stokes equations, level-set, turbulence, two-phase flows]]


= Introduction
 <sec-Intro>
The evolution of most known physical systems can be described by partial differential equations (PDEs). Navier-Stokes equations (NSE) are partial differential equations that describe the continuum-scale flow of fluids. Fluid flows are omnipresent in engineering applications and in nature, and the accurate numerical simulation of complex flows is crucial for the prediction of global weather phenomena #cite(<Bauer2015>) #cite(<Hafner2021>),  for applications in biomedical engineering such as air flow through the lungs or blood circulation #cite(<Nowak2003>) #cite(<Johnston2004>), and for the efficient design of turbomachinery #cite(<Denton1998>), wind turbines #cite(<Hansen2006>) #cite(<Sanderse2011>), and airplane wings #cite(<Lyu2014>). Computational fluid dynamics (CFD) aims to solve these problems with numerical algorithms.

 While classical CFD has a rich history, in recent years the symbiosis of machine learning (ML) and CFD has  sparked a great interest amongst researchers #cite(<Duraisamy2019>) #cite(<Brenner2019>) #cite(<Brunton2020a>). The amalgamation of classical CFD and ML requires powerful novel algorithms which allow seamless integration of data-driven models  and, more importantly, end-to-end automatic differentiation #cite(<Baydin2018>) through the entire algorithm. Here, we provide JAX-FLUIDS (#link("https://github.com/tumaer/JAXFLUIDS")): the first state-of-the-art fully-differentiable CFD framework for the computation of  three-dimensional compressible two-phase flows with high-order numerical methods. Over the course of this paper, we discuss the challenges of hybrid ML-accelerated CFD solvers and highlight  how novel architectures like JAX-FLUIDS have the potential to facilitate ML-supported fluid dynamics research.

 The quest for powerful numerical fluid dynamics algorithms has been a long-lasting challenge.  In the mid of the last century, the development of performant computer processing units (CPUs) laid the fundament for the development  of computational fluid dynamics (CFD). For the first time, computers were used to simulate fluid flows #cite(<Harlow2004>). Computational fluid dynamics, i.e., the numerical investigation of fluid flows, became a scientific field on its own.  With the rapid development of computational hardware, the CFD community witnessed new and powerful algorithms  for the computation of more and more complex flows. Among others, robust time integration schemes, high-order spatial discretizations,  and accurate flux-functions were thoroughly investigated. In the 1980s and 1990s, many advancements in numerical methods for compressible fluid flows followed,  e.g., #cite(<VanLeer1979>) #cite(<Roe1981>) #cite(<Woodward1984>) #cite(<Toro1994>) #cite(<Liou1996>).

 In recent years, machine learning (ML) has invigorated the physical sciences by providing novel tools for predicting the evolution of physical systems.  Breakthrough inventions in ML #cite(<Lecun1989>) #cite(<Hochreiter1997>) and rapid technical developments of graphics processing units (GPUs)  have led to an ever-growing interest in machine learning. Starting from applications in computer vision #cite(<LeCun2010>) #cite(<Lecun2015>), cognitive sciences #cite(<Lake2015>),  and genomics #cite(<Alipanahi2015>),  machine learning and data-driven methods have also become more and more popular in physical and engineering sciences. This development has partially been fuelled by the emergence of powerful general-purpose automatic differentiation frameworks,  such as Tensorflow #cite(<Abadi>), Pytorch #cite(<Paszke2019>), and JAX #cite(<jax2018github>).  Natural and engineering sciences can profit from ML methods as they have capabilities to learn complex relations from data and  enable novel strategies for modelling physics as well as new avenues of post-processing. For example, machine learning has been successfully used to identify PDEs from data #cite(<Brunton2016>),  and physics-informed neural networks provide new ways for solving inverse problems #cite(<Raissi2019>) #cite(<Buhendwa2021c>)  by combining data and PDE knowledge.

 It is well-known that fluid dynamics is a data-rich and compute-intensive discipline #cite(<Brunton2020a>). The nonlinearity of the underlying governing equations, the Navier-Stokes equations for viscous flows and the Euler equations  for inviscid flows, is responsible for very complex spatio-temporal features of fluid flows. For example, turbulent flows exhibit chaotic behavior with strong intermittent flow features, and non-Gaussian statistics. At the same time, in the inviscid Euler equations strong discontinuities can form over time due to the hyperbolic character  of the underlying PDEs.

 Machine learning offers novel data-driven methods to tackle long-standing problems in fluid dynamics #cite(<Duraisamy2019>) #cite(<Brunton2020a>) #cite(<Brunton2020b>). A multitude of research has put forward different ways of incorporating ML in CFD applications. Applications range from fully data-driven surrogate models to less invasive hybrid data-driven numerical methods. Thereby, scientific ML methods can be categorized according to different criteria.

 One important distinction is the level of physical prior-knowledge that is included in model and training #cite(<Karniadakis2021>). Entirely data-driven ML models have the advantage of being quickly implemented and efficient during inference. However, they typically do not offer guarantees on performance (e.g., convergence, stability, and generalization), convergence in training is challenging, and it is often difficult to enforce physical constraints such as symmetries or conservation of energy. In contrast, established numerical methods are consistent and enforce physical constraints. Recently, intense research has investigated the hybridization of ML and classical numerical methods.

 A second major distinction of ML models can be made according to on- and offline training. Up until now, ML models have been typically optimized offline, i.e., outside of physics simulators. Upon proper training, they are then plugged into an existing CFD solver for evaluation of down-stream tasks. Examples include training of explicit subgrid scale models in large eddy simulations #cite(<Beck2019>),  interface reconstruction in multiphase flows #cite(<Patel2019a>) #cite(<Buhendwa2021b>),  and cell face reconstruction in shock-capturing schemes #cite(<Stevens2020c>) #cite(<Bezgin2021b>).

 Although the offline training of ML models is relatively easy, there are several drawbacks to this approach. For one, these models suffer from a data-distribution mismatch between the data seen at training and test time. Secondly, they generally do not directly profit from a priori knowledge about the dynamics of the underlying PDE. Additionally, fluid mechanics solvers are often very complex, written in low-level programming languages like Fortran or C++,  and heavily optimized for CPU computations. This is in contrast with practices in ML research: ML models are typically trained in Python and optimized for GPU usage.  Inserting these models into preexisting CFD software frameworks can be a tedious task.

 To tackle this problem, researchers have come up with differentiable CFD frameworks written entirely in Python  which allow end-to-end optimization of ML models. The end-to-end (online) training approach utilizes automatic differentiation #cite(<Baydin2018>) through entire simulation trajectories. ML models trained in such a fashion experience the PDE dynamics and also see their own outputs during training. Among others, Bar-Sinai and co-workers #cite(<Bar-Sinai2019>) #cite(<Zhuang2021>) have proposed a differentiable framework for finding  optimal discretizations for simple non-linear one-dimensional problems and turbulent mixing in two-dimensions. In #cite(<Um2020>), a differentiable solver was placed in the training loop to reduce the error of iterative solvers. Bezgin et al. #cite(<Bezgin2021a>) have put forward a subgrid scale model for nonclassical shocks. Kochkov et al. #cite(<Kochkove2101784118>) have optimized a subgrid scale model for two-dimensional turbulence.

 Afore-noted works focus on simpler flow configurations.  The problems are often one- and two-dimensional, incompressible, and lack complex physics such as two-phase flows,  three-dimensional turbulence, or compressibility effects.  Additionally, the written code packages often are highly problem specific and cannot be used as general differentiable CFD  software packages. To the knowledge of the authors, despite a high-interest in ML-accelerated CFD, to this day there does not exist a  comprehensive mesh-based software package for _differentiable fluid dynamics_ in the Eulerian reference frame. At the same time, for Lagrangian frameworks, the differentiable software package JAX-MD #cite(<Schoenholz>) has been successfully used  for molecular dynamics and provides a general fundament for other particle-based discretization methods.

 We reiterate that the steady rise and success of machine learning in computational fluid dynamics,  but also more broadly in computational physics, calls for a new generation of algorithms which allow

+ rapid prototyping in high-level programming languages,
+ algorithms which can be run on CPUs, GPUs, and TPUs,
+ the seamless integration of machine learning models into solver frameworks,
+ fully-differentiable algorithms which allow end-to-end optimization of data-driven models.

 Realizing the advent of _differentiable fluid dynamics_ and the increasing need for a differentiable general high-order  CFD solver, here we introduce JAX-FLUIDS as a fully-differentiable general-purpose 3D finite-volume CFD  solver for compressible two-phase flows.  JAX-FLUIDS is written entirely in JAX #cite(<jax2018github>), a numerical computing library with automatic differentiation capabilities  which has seen increased popularity in the physical science community over the past several years.  JAX-FLUIDS provides a wide variety of state-of-the-art high-order methods for compressible turbulent flows. A powerful level-set implementation allows the simulation of arbitrary solid boundaries and two-phase flows. High-order shock-capturing methods enable the accurate computation of shock-dominated compressible flow problems and  shock-turbulence interactions. Performance and usability were key design goals during development of JAX-FLUIDS. The solver can conveniently be installed as a Python package. The source code builds on the JAX NumPy API. Therefore, JAX-FLUIDS is accessible, performant, and runs on accelerators like CPUs, GPUs, and TPUs. Additionally, an object-oriented programming style and a modular design philosophy allows users the easy integration of new modules. We believe that frameworks like JAX-FLUIDS are crucial to facilitate research at the intersection of ML and CFD, and may pave the way for an era of _differentiable fluid dynamics_.

 The remainder of this paper is organized as follows. In Sections @sec-PhysicalModel and @sec-numericalmodel, we describe the physical and numerical model.  @sec-Implementation describes challenges of writing a high-performance CFD code in a high-level programming language  such as JAX. We additionally detail the general structure of our research code. In @sec-ForwardPass, we evaluate our code as a classical physics simulator.  We validate the numerical framework on canonical test cases from compressible fluid mechanics, including strong-shocks and turbulent flows. In @sec-Performance, we assess the computational performance of JAX-FLUIDS. @sec-BackwardPass showcases how the proposed framework can be used in machine learning tasks. Specifically, we demonstrate full-differentiability of the framework by optimizing a numerical flux function. Finally, in @sec-Conclusion we conclude and summarize the main results of our work.


= Physical Model
 <sec-PhysicalModel>
We are interested in the compressible Euler equations for inviscid flows and in the compressible Navier-Stokes equations (NSE) which govern viscous flows. The state of a fluid at any position in the flow field $upright(bold(x)) = [ x, y, z ]^(T) = [ x_(1), x_(2), x_(3) ]^(T)$ at time $t$ can be described by the vector of primitive variables  $upright(bold(W)) = [ rho, u, v, w, p ]^(T)$. Here, $rho$ is the density, $upright(bold(u)) = [ u, v, w ]^(T) = [ u_(1), u_(2), u_(3) ]^(T)$ is the velocity vector, and $p$ is the pressure. An alternative description is given by the vector of conservative variables  $upright(bold(U)) = [ rho, rho u, rho v, rho w, E ]^(T)$. Here, $rho upright(bold(u)) = [ rho u, rho v, rho w ]^(T)$ are the momenta in the three spatial dimensions, and $E = rho e + 1/2 rho upright(bold(u)) dot upright(bold(u))$ is the total energy per unit volume. $e$ is the internal energy per unit mass.

 In differential formulation, the compressible Euler equations can be written in terms of $upright(bold(U))$
$ frac(partial upright(bold(U)), partial t) + frac(partial cal(F) (upright(bold(U))), partial x) + frac(partial cal(G) (upright(bold(U))), partial y) + frac(partial cal(H) (upright(bold(U))), partial z) = 0 . $ <eq-DiffConsLaw1>

The convective physical fluxes $cal(F)$, $cal(G)$, and $cal(H)$ are defined as
$ cal(F) (upright(bold(U))) = mat(delim: "(", rho u ; rho u^(2) + p ; rho u v ; rho u w ; u(E + p)), quad cal(G) (upright(bold(U))) = mat(delim: "(", rho v ; rho v u ; rho v^(2) + p ; rho v w ; v(E + p)), quad cal(H) (upright(bold(U))) = mat(delim: "(", rho w ; rho w u ; rho w v ; rho w^(2) + p ; w(E + p)) . $

This set of equations must be closed by an equation of state (EOS) which relates pressure with density and internal energy,  i.e., $p = p(rho, e)$.  Unless specified otherwise, we use the stiffened gas equation
$ p(rho, e) = (gamma - 1) rho e - gamma B, $ <eq-StiffenedGas>

where $gamma$ represents the ratio of specific heats and $B$ is the background pressure.

 The compressible Navier-Stokes equations can be seen as the viscous extension of the Euler equations. As before, we write them in terms of the conservative state vector $upright(bold(U))$,
$ frac(partial upright(bold(U)), partial t) + frac(partial cal(F) (upright(bold(U))), partial x) + frac(partial cal(G) (upright(bold(U))), partial y) + frac(partial cal(H) (upright(bold(U))), partial z) = frac(partial cal(F)^(d)(upright(bold(U))), partial x) + frac(partial cal(G)^(d)(upright(bold(U))), partial y) + frac(partial cal(H)^(d)(upright(bold(U))), partial z) + S(upright(bold(U))). $ <eq-DiffConsLaw2>

Here, we have additionally introduced the dissipative fluxes $cal(F)^(d)$, $cal(G)^(d)$, and $cal(H)^(d)$ and  the source term vector $S(upright(bold(U)))$ on the right-hand side. The dissipative fluxes describe viscous effects and heat conduction, and are given by
$ cal(F)^(d)(upright(bold(U))) = mat(delim: "(", 0 ; tau^(11) ; tau^(12) ; tau^(13) ; sum_(i) u_(i) tau^(1 i) - q_(1)), quad cal(G)^(d)(upright(bold(U))) = mat(delim: "(", 0 ; tau^(21) ; tau^(22) ; tau^(23) ; sum_(i) u_(i) tau^(2 i) - q_(2)), quad cal(H)^(d)(upright(bold(U))) = mat(delim: "(", 0 ; tau^(31) ; tau^(32) ; tau^(33) ; sum_(i) u_(i) tau^(3 i) - q_(3)) . $

The stresses $tau^(i j)$ are given by
$ tau^(i j) = mu (frac(partial u_(i), partial x_(j)) + frac(partial u_(j), partial x_(i))) - 2/3 mu delta_(i j) frac(partial u_(k), partial x_(k)). $

$mu$ is the dynamic viscosity. The energy flux vector $upright(bold(q))$ can be expressed via Fourier's heat conduction law, $upright(bold(q)) = [q_(1), q_(2), q_(3)]^(T) = - lambda nabla T$. $lambda$ is the heat conductivity. The source terms $S(upright(bold(U)))$ represent body forces or heat sources. The body force resulting from gravitational acceleration $upright(bold(g)) = [g_(1), g_(2), g_(3)]^(T)$  is given by $ S(upright(bold(U))) = mat(delim: "(", 0 ; rho upright(bold(g)) ; rho upright(bold(u)) dot upright(bold(g))) . $

 In @tab-Nondimensionalization, we summarize the nomenclature and the reference values with which we non-dimensionalize aforementioned equations.
#figure(
  placement: top,
  table(
    columns: 3,
    stroke: none,
    align: (left, left, left),
    table.hline(),
    [Quantity], [Nomenclature], [Reference quantity],
    table.hline(),
    [Density], [$rho$], [$rho_"ref"$],
    [Length], [$(x, y, z)$ or $(x_1, x_2, x_3)$], [$l_"ref"$],
    [Velocity], [$(u, v, w)$ or $(u_1, u_2, u_3)$], [$u_"ref"$],
    [Temperature], [$T$], [$T_"ref"$],
    [Time], [$t$], [$t_"ref" = l_"ref" slash u_"ref"$],
    [Pressure], [$p$], [$p_"ref" = rho_"ref" u_"ref"^2$],
    [Viscosity], [$mu$], [$mu_"ref" = rho_"ref" u_"ref" l_"ref"$],
    [Surface tension coefficient], [$sigma$], [$sigma_"ref" = rho_"ref" u_"ref"^2 l_"ref"$],
    [Thermal conductivity], [$lambda$], [$lambda_"ref" = rho_"ref" u_"ref"^3 l_"ref" slash T_"ref"$],
    [Gravitation], [$g$], [$g_"ref" = u_"ref"^2 slash l_"ref"$],
    [Specific gas constant], [$cal(R)$], [$cal(R)_"ref" = u_"ref"^2 slash T_"ref"$],
    [Mass], [$m$], [$m_"ref" = rho_"ref" l_"ref"^3$],
    [Mass flow], [$dot(m)$], [$dot(m)_"ref" = m_"ref" slash t_"ref" = rho_"ref" u_"ref" l_"ref"^2$],
    table.hline(),
  ),
  caption: [Overview on nomenclature and nondimensionalization.],
  kind: table,
) <tab-Nondimensionalization>


= Numerical Model
 <sec-numericalmodel>

 In this section we detail the numerical methods of JAX-FLUIDS. @tab-NumericalMethods provides an overview on the implemented numerical methods.

== Finite-Volume Discretization
 <subsec-FVD>
The differential form of the conservation law in Equations (#ref(<eq-DiffConsLaw1>, supplement: none)) and (#ref(<eq-DiffConsLaw2>, supplement: none)) assume smooth solutions  for which partial derivatives exist. In practice, we solve the integral form of the partial differential equations using the finite-volume method. We use cuboid cells on a Cartesian grid. In general, cell $(i,j,k)$ has spatial extension $Delta x$, $Delta y$, and $Delta z$ in the spatial dimensions $x$, $y$, and $z$,  respectively. We denote the corresponding cell volume as $V = Delta x Delta y Delta z$. Often, we use cubic cells for which $Delta x = Delta y = Delta z$.

 In the finite-volume formulation we are interested in the spatio-temporal distribution of cell-averaged values which are defined by
$ overline(upright(bold(U)))_(i,j,k) = 1/V integral_(x_(i - 1/2,j,k))^(x_(i + 1/2,j,k)) integral_(y_(i,j - 1/2,k))^(y_(i,j + 1/2,k)) integral_(z_(i,j,k - 1/2))^(z_(i,j,k + 1/2)) upright(bold(U)) #text[d] x #text[d] y #text[d] z . $

After application of volume integration to Equation (#ref(<eq-DiffConsLaw2>, supplement: none)), the temporal evolution of the cell-averaged value in cell $(i,j,k)$ is given by
$ frac(#text[d], #text[d] t) overline(upright(bold(U)))_(i,j,k) = & - frac(1, Delta x) (upright(bold(F))_(i + 1/2,j,k) - upright(bold(F))_(i - 1/2,j,k)) \ & - frac(1, Delta y) (upright(bold(G))_(i,j + 1/2,k) - upright(bold(G))_(i,j - 1/2,k)) \ & - frac(1, Delta z) (upright(bold(H))_(i,j,k + 1/2) - upright(bold(H))_(i,j,k - 1/2)) \ & + frac(1, Delta x) (upright(bold(F))^(d)_(i + 1/2,j,k) - upright(bold(F))^(d)_(i - 1/2,j,k)) \ & + frac(1, Delta y) (upright(bold(G))^(d)_(i,j + 1/2,k) - upright(bold(G))^(d)_(i,j - 1/2,k)) \ & + frac(1, Delta z) (upright(bold(H))^(d)_(i,j,k + 1/2) - upright(bold(H))^(d)_(i,j,k - 1/2)) \ & + overline(upright(bold(S)))_(i,j,k). $ <eq-FVD>

$upright(bold(F))$, $upright(bold(G))$, and $upright(bold(H))$ are the convective intercell numerical fluxes across the cell faces in $x$-, $y$-, and $z$-direction, and  $upright(bold(F))^(d)$, $upright(bold(G))^(d)$, and $upright(bold(H))^(d)$ are the numerical approximations to the dissipative fluxes in $x$-, $y$-, and $z$-direction. $overline(upright(bold(S)))_(i,j,k)$ is the cell-averaged source term.  Note that the convective and dissipative fluxes in Equation (#ref(<eq-FVD>, supplement: none)) are cell face averaged quantities. We use a simple one-point Gaussian quadrature to evaluate the necessary cell face integrals, however approximations of higher order are also possible, see for example #cite(<Coralic2014e>). For the calculation of the convective intercell numerical fluxes, we use WENO-type high-order discretization schemes #cite(<Jiang1996>) in combination with approximate Riemann solvers. @subsec-InviscidFlux provides more details.

Dissipative fluxes are calculated by central finite-differences, see @subsec-Dissipative for details. Multidimensional settings are treated via the dimension-by-dimension technique in a straightforward manner, i.e., aforementioned steps are repeated for each spatial dimension separately.

== Time Integration
 <subsec-timeint> The finite-volume discretization yields a set of ordinary differential equations (ODEs) (#ref(<eq-FVD>, supplement: none)) that can be integrated in time by an ODE solver of choice. We typically use explicit total-variation diminishing (TVD) Runge-Kutta methods #cite(<Gottlieb1998a>). The time step size is given by the $C F L$ criterion  as described in #cite(<Hoppe2022a>).

== Convective Flux Calculation
 <subsec-InviscidFlux> For the calculation of the convective fluxes an approximative solution to a Riemann problem has to be found at each cell face. As we make use of the dimension-by-dimension technique, without loss of generality, we restrict ourselves to a one-dimensional setting in this subsection. We are interested in finding the cell face flux $upright(bold(F))_(i + 1/2)$ at the cell face $x_(i + 1/2)$.

 We distinguish between two different methods for the calculation of the convective intercell fluxes:  the _High-order Godunov_ approach and the _Flux-splitting_ approach. In the _High-order Godunov_ approach, we first reconstruct flow states left and right of a cell face, and subsequently  enter an approximate Riemann solver for the calculation of the convective intercell flux. In the _Flux-splitting_ approach, we first perform cell-wise flux-splitting, reconstruct left and right going fluxes for each cell face, and subsequently assemble the final flux. In the following, we briefly sketch both methods.\

  _High-order Godunov approach_
+ Apply WENO reconstruction on the primitive variable $upright(bold(W))_(i)$/the conservative variable $upright(bold(U))_(i)$ to obtain the  cell face quantities $upright(bold(W))^(plus.minus)_(i + 1/2)$/$upright(bold(U))^(plus.minus)_(i + 1/2)$.  Note that the reconstruction can be done directly in physical space or via transformation in characteristic space. High-order reconstruction in physical space can lead to spurious oscillations due to the interaction of discontinuities in different fields #cite(<Qiu2002>).
+ Transform the reconstructed primitive/conservative variables at the cell face into conservative/primitive cell face quantities:  $upright(bold(W))^(plus.minus)_(i + 1/2) -> upright(bold(U))^(plus.minus)_(i + 1/2)$ / $upright(bold(U))^(plus.minus)_(i + 1/2) -> upright(bold(W))^(plus.minus)_(i + 1/2)$.
+ Compute the final flux with an appropriate flux function/approximate Riemann solver, e.g., HLL #cite(<Harten1983a>) or HLLC #cite(<Toro1994>):  $ upright(bold(F))_(i + 1/2) = upright(bold(F))_(i + 1/2) (upright(bold(U))_(i + 1/2)^(-), upright(bold(U))_(i + 1/2)^(+), upright(bold(W))_(i + 1/2)^(-), upright(bold(W))_(i + 1/2)^(+)) $ <eq-ApproxRiemannSolver>

  _Flux-Splitting approach_
+ At the cell face $x_(i + 1/2)$ compute an appropriate average state from neighboring cells $upright(bold(U))_(i + 1/2) = upright(bold(U))_(i + 1/2) (upright(bold(U))_(i), upright(bold(U))_(i + 1))$ (e.g., by arithmetic mean or Roe average #cite(<Toro2009a>)) and the corresponding Jacobian $upright(bold(A))_(i + 1/2) = upright(bold(A))_(i + 1/2) (upright(bold(U))_(i + 1/2))$.
+ Eigenvalue decomposition of the Jacobian: $upright(bold(A))_(i + 1/2) = upright(bold(R))_(i + 1/2) upright(bold(Lambda))_(i + 1/2) upright(bold(R))_(i + 1/2)^(- 1)$, with the matrix of right eigenvectors $upright(bold(R))_(i + 1/2)$, the matrix of left eigenvectors $upright(bold(R))_(i + 1/2)^(- 1)$, and the eigenvalues $upright(bold(Lambda))_(i + 1/2)$.
+ Transform the cell state $upright(bold(U))_(i)$ and the flux $upright(bold(F))_(i)$ to characteristic space: $upright(bold(V))_(j) = upright(bold(R))_(i + 1/2)^(- 1) upright(bold(U))_(i), quad upright(bold(G))_(j) = upright(bold(R))_(i + 1/2)^(- 1) upright(bold(F))_(i)$.
+ Perform the user-specified flux splitting: $hat(upright(bold(G)))^(plus.minus)_(i) = 1/2(upright(bold(G))_(i) plus.minus overline(upright(bold(Lambda)))_(i + 1/2) upright(bold(V))_(i))$, where $overline(upright(bold(Lambda)))_(i + 1/2)$ is the eigenvalue matrix of the respective flux-splitting scheme.
+ Apply WENO reconstruction on $hat(upright(bold(G)))^(plus.minus)_(i)$ to obtain $hat(upright(bold(G)))^(plus.minus)_(i + 1/2)$ at the cell face $x_(i + 1/2)$.
+ Assemble the final flux in characteristic space: $hat(upright(bold(G)))_(i + 1/2) = hat(upright(bold(G)))^(+)_(i + 1/2) + hat(upright(bold(G)))^(-)_(i + 1/2)$.
+ Transform the final flux back to physical space: $upright(bold(F))_(i + 1/2) = upright(bold(R))_(i + 1/2) hat(upright(bold(G)))_(i + 1/2)$.

== Dissipative Flux Calculation
 <subsec-Dissipative> For the calculation of the dissipative fluxes, we have to evaluate derivatives at the cell faces. We do this using central finite-differences. As we do all computations in a Cartesian framework, central finite-differences can be evaluated directly at a cell face if the direction of the derivative is  parallel to the cell face normal. For example, at the cell face $x_(i + 1 slash 2,j,k)$ the $x$-derivative of any quantity $psi$ is directly approximated with second-order or fourth-order central finite-differences,
$ lr(frac(partial psi, partial x) bar.v)_(x_(i + 1 slash 2,j,k))^(C 2) = frac(- psi_(i,j,k) + psi_(i + 1,j,k), Delta x), quad lr(frac(partial psi, partial x) bar.v)_(x_(i + 1 slash 2,j,k))^(C 4) = frac(psi_(i - 1,j,k) - 27 psi_(i,j,k) + 27 psi_(i + 1,j,k) - psi_(i + 2,j,k), 24 Delta x). $

If the cell face normal is perpendicular to the direction of the derivative, we use a two-step process to approximate the derivative. We first evaluate the derivative at the cell-centers and then use a central interpolation to obtain the value at the cell face of interest. Again, we use second-order or fourth-order order central finite-differences for the derivatives. Let us consider the $y$-derivative of the quantity $psi$ at the cell face $x_(i + 1/2,j,k)$ (the $z$-derivative is complelety analogous). We first calculate the derivative at the cell centers
$ lr(frac(partial psi, partial y) bar.v)_(x_(i,j,k))^(C 2) = frac(- psi_(i,j - 1,k) + psi_(i,j + 1,k), Delta y), quad lr(frac(partial psi, partial y) bar.v)_(x_(i,j,k))^(C 4) = frac(psi_(i,j - 2,k) - 8 psi_(i,j - 1,k) + 8 psi_(i,j + 1,k) - psi_(i,j + 2,k), 12 Delta y). $

We subsequently interpolate these values to the cell face,
$ & lr(frac(partial psi, partial y) bar.v)_(x_(i + 1 slash 2,j,k)) = 1/2(lr(frac(partial psi, partial y) bar.v)_(x_(i - 1,j,k)) + lr(frac(partial psi, partial y) bar.v)_(x_(i + 1,j,k))), \ & lr(frac(partial psi, partial y) bar.v)_(x_(i + 1 slash 2,j,k)) = 1/16 (- lr(frac(partial psi, partial y) bar.v)_(x_(i - 2,j,k)) + 9 lr(frac(partial psi, partial y) bar.v)_(x_(i - 1,j,k)) + 9 lr(frac(partial psi, partial y) bar.v)_(x_(i + 1,j,k)) - lr(frac(partial psi, partial y) bar.v)_(x_(i + 2,j,k))) . $

== Source Terms and Forcings
 <subsec-forcing>
The source terms $S(upright(bold(U)))$ represent body forces and heat sources. We use them to impose physical constraints, e.g., fixed mass flow rates or temperature profiles. These forcings are required to simulate a variety of test cases. Examples include  channel flows or driven homogenous isotropic turbulence. Fixed mass flow rates are enforced with a PID controller minimizing the error between target and current mass flow rate $e(t) = frac(dot(m)_(#text[target]) - dot(m) (t), dot(m)_(#text[target]))$. Here, the control variable is an acceleration $a_(dot(m))$ that drives the fluid in the prescribed direction. We denote the unit vector pointing towards the prescribed direction as $upright(bold(N))$. The controller variable and resulting source terms read $ a_(dot(m)) = K_(p) e(t) + K_(I) integral_(0)^(t) e(tau)#text[d] tau + K_(d) frac(#text[d] e(t), #text[d] t), wide S(upright(bold(U))) = mat(delim: "(", 0 ; rho a_(dot(m)) upright(bold(N)) ; rho a_(dot(m)) upright(bold(u)) dot upright(bold(N))), $ <eq-PID-massflow>
 where $K_(p)$, $K_(I)$, and $K_(d)$ are the controller parameters. The integral and derivative in Equation (#ref(<eq-PID-massflow>, supplement: none)) are  approximated with first order schemes. Fixed temperature profiles are enforced with a heat source $dot(omega)_(T)$. The heat source and resulting source term is given by $ dot(omega)_(T) = rho R frac(gamma, gamma - 1) frac(T_(#text[target]) - T, Delta t), wide S(upright(bold(U))) = dot(omega)_(T) [0,0,0,0,1 ]^(T). $

== Level-set Method for Two-phase Flows
 <subsec-levelset> We use the level-set method #cite(<Osher1988>) to model two-phase flows with fluid-fluid and fluid-solid interfaces. In particular, we implement the sharp-interface level-set method proposed by Hu et al. #cite(<Hu2006>), which is also used in the solver ALPACA #cite(<Hoppe2020a>) #cite(<Hoppe2022a>).  The interface is tracked by a scalar field $phi.alt$ whose values represent the signed distance from the interface of each cell center within the mesh of the finite-volume discretization. This implies that there is a positive phase ($phi.alt > 0$) and a negative phase ($phi.alt < 0$)  with the interface being located at the zero level-set of $phi.alt$. A cell that is intersected by the interface is referred to as cut cell. @fig-cut-cell shows a schematic of a cut cell in the finite-volume discretization. The apertures $A_(i plus.minus 1/2,j,k)$, $A_(i,j plus.minus 1/2,k)$, and $A_(i,j,k plus.minus 1/2)$ represent the portion of the cell face area that is covered by the respective fluid. The volume fraction $alpha_(i,j,k)$ denotes the portion of the cell volume covered by the respective fluid.  Hereinafter, we will refer to the positive phase with the subscript 1 and to the  negative phase with the subscript 2. The following relations between the geometrical quantities  for the positive and negative phase apply:  $ alpha_(1) = 1 - alpha_(2),quad A_(1) = 1 - A_(2). $ <eq-posnegphase>

#figure(
  placement: top,
  align(center, canvas({
    import "@preview/cetz:0.4.0": draw
    import draw: *

    // cell centers one full cell apart; the cut cell spans (0,0)--(4,4)
    // dashed grid through the neighbouring cell centers
    let grid(x0, y0, x1, y1) = line((x0, y0), (x1, y1), stroke: (thickness: 0.4pt, dash: "dashed"))
    grid(-2, -2, -2, 6)
    grid(6, -2, 6, 6)
    grid(-2, -2, 6, -2)
    grid(-2, 6, 6, 6)
    // central grid lines: solid inside the cut cell, dashed outside
    grid(2, 4, 2, 6)
    grid(2, -2, 2, 0)
    grid(4, 2, 6, 2)
    grid(-2, 2, 0, 2)

    // positive phase
    line((0, 0), (0, 4), (0.72, 4), (4, 0.52), (4, 0), (0, 0), fill: rgb(0, 0, 0, 25), close: true)

    // cell boundary and interior center lines
    line((0, 0), (4, 0), (4, 4), (0, 4), (0, 0), stroke: (thickness: 1pt))
    line((0, 2), (4, 2), stroke: (thickness: 0.4pt))
    line((2, 0), (2, 4), stroke: (thickness: 0.4pt))

    // interface (red) and its linear approximation (blue)
    bezier((0.35, 4.28), (4.18, 0.28), (1.6, 3.4), (2.8, 1.9), stroke: (paint: red, thickness: 1pt))
    line((0.72, 4), (4, 0.52), stroke: (paint: blue, thickness: 1pt))

    // aperture dimension lines
    line((-0.45, 0), (-0.45, 4), mark: (start: "<", end: ">"), stroke: 0.4pt)
    line((0, 0), (-0.6, 0), stroke: 0.4pt)
    line((0, 4), (-0.6, 4), stroke: 0.4pt)
    line((0, -0.45), (4, -0.45), mark: (start: "<", end: ">"), stroke: 0.4pt)
    line((0, 0), (0, -0.6), stroke: 0.4pt)
    line((4, 0), (4, -0.6), stroke: 0.4pt)
    line((0, 4.55), (0.72, 4.55), mark: (start: "<", end: ">"), stroke: 0.4pt)
    line((0, 4), (0, 4.7), stroke: 0.4pt)
    line((0.72, 4), (0.72, 4.7), stroke: 0.4pt)
    line((4.45, 0), (4.45, 0.52), mark: (start: "<", end: ">"), stroke: 0.4pt)
    line((4, 0), (4.6, 0), stroke: 0.4pt)
    line((4, 0.52), (4.6, 0.52), stroke: 0.4pt)

    // cell centers
    let centers = ((-2, -2), (-2, 2), (-2, 6), (2, -2), (2, 2), (2, 6), (6, -2), (6, 2), (6, 6))
    for p in centers {
      circle(p, radius: 0.08, fill: red, stroke: none)
    }
    let lbl(body) = text(7.5pt, body)
    // labels sit below-left or below-right of each center
    content((-2.12, 5.88), lbl[$(i - 1, j + 1, k)$], anchor: "north-east")
    content((2.12, 5.88), lbl[$(i, j + 1, k)$], anchor: "north-west")
    content((6.12, 5.88), lbl[$(i + 1, j + 1, k)$], anchor: "north-west")
    content((-2.12, 1.88), lbl[$(i - 1, j, k)$], anchor: "north-east")
    content((2.12, 1.88), lbl[$(i, j, k)$], anchor: "north-west")
    content((6.12, 1.88), lbl[$(i + 1, j, k)$], anchor: "north-west")
    content((-2.12, -2.12), lbl[$(i - 1, j - 1, k)$], anchor: "north-east")
    content((2.12, -2.12), lbl[$(i, j - 1, k)$], anchor: "north-west")
    content((6.12, -2.12), lbl[$(i + 1, j - 1, k)$], anchor: "north-west")

    // apertures and phase labels
    content((-0.85, 2), std.rotate(-90deg, text(8pt, $A_(i - 1\/2, j, k) = 1.0$)))
    content((2, -0.78), text(8pt, $A_(i, j - 1\/2, k) = 1.0$), fill: white)
    content((0.36, 4.82), text(8pt, $A_(i, j + 1\/2, k)$))
    content((4.75, 0.26), std.rotate(-90deg, text(8pt, $A_(i + 1\/2, j, k)$)))
    content((0.14, 3.5), text(fill: blue, 8pt, $Delta Gamma_(i, j, k)$), anchor: "south-west")
    content((3.78, 3.62), text(8pt, $phi < 0$), anchor: "north-east")
    content((0.14, 0.14), text(8pt, $phi > 0 quad alpha_(i, j, k)$), anchor: "south-west")

    // coordinate axes
    line((-1.35, -1.35), (-1.35, -0.35), mark: (end: ">"), stroke: 0.8pt)
    content((-1.5, -0.55), text(8pt, $y$), anchor: "east")
    line((-1.35, -1.35), (-0.35, -1.35), mark: (end: ">"), stroke: 0.8pt)
    content((-0.75, -1.5), text(8pt, $x$), anchor: "north")
    circle((-1.35, -1.35), radius: 0.05, fill: black, stroke: none)
    content((-1.6, -1.6), text(8pt, $z$), anchor: "north-east")
  })),
  caption: [Schematic finite-volume discretization for cut cell $(i,j,k)$ on a Cartesian grid. The red dots represent the cell centers. The red line indicates the interface, and the blue line gives the linear approximation of the interface. The fluid with positive level-set values is colored in gray, and the fluid with negative level-set values is colored in white. Volume fraction and apertures are computed for the positive fluid. Note that the figure illustrates a two-dimensional slice in the $(x,y)$-plane. (For interpretation of the references to color in this figure legend, the reader is referred to the web version of this article.)],
) <fig-cut-cell>

We solve Equation (#ref(<eq-FVD>, supplement: none)) for both phases separately. However, in a cut cell $(i,j,k)$, the equation is modified as follows. $ frac(#text[d], #text[d] t) alpha_(i,j,k) overline(upright(bold(U)))_(i,j,k) = & - frac(1, Delta x) [ A_(i + 1/2,j,k) (upright(bold(F))_(i + 1/2,j,k) + upright(bold(F))^(d)_(i + 1/2,j,k)) - A_(i - 1/2,j,k) (upright(bold(F))_(i - 1/2,j,k) + upright(bold(F))^(d)_(i - 1/2,j,k)) ] \ & - frac(1, Delta y) [ A_(i,j + 1/2,k) (upright(bold(G))_(i,j + 1/2,k) + upright(bold(G))^(d)_(i,j + 1/2,k)) - A_(i,j - 1/2,k) (upright(bold(G))_(i,j - 1/2,k) + upright(bold(G))^(d)_(i,j - 1/2,k)) ] \ & - frac(1, Delta z) [ A_(i,j,k + 1/2) (upright(bold(H))_(i,j,k + 1/2) + upright(bold(H))^(d)_(i,j,k + 1/2)) - A_(i,j,k - 1/2) (upright(bold(H))_(i,j,k - 1/2) + upright(bold(H))^(d)_(i,j,k - 1/2)) ] \ & + alpha_(i,j,k) overline(upright(bold(S)))_(i,j,k) \ & - frac(1, Delta x Delta y Delta z) [ upright(bold(X))_(i,j,k)(Delta Gamma) + upright(bold(X))^(d)_(i,j,k)(Delta Gamma) ] $ <eq-FVD-levelset>

The cell-averaged state and the intercell fluxes must be weighted with the volume fraction and the cell face apertures, respectively. The terms $upright(bold(X)) (Delta Gamma)$ and $upright(bold(X))^(d)(Delta Gamma)$ denote the convective and dissipative interface flux, with $Delta Gamma$ being the interface segment length. We define the projections of the interface segment length on the $x$, $y$, and $z$ direction as the vector  $ Delta upright(bold(Gamma))_(p) = mat(delim: "(", Delta Gamma (upright(bold(i)) dot upright(bold(n))_(I)) ; Delta Gamma (upright(bold(j)) dot upright(bold(n))_(I)) ; Delta Gamma (upright(bold(k)) dot upright(bold(n))_(I)) ;), wide $ <eq-interface-segment-projection>
 where $upright(bold(i))$, $upright(bold(j))$, and $upright(bold(k))$ represent the unit vectors in $x$, $y$, and $z$ direction, respectively. The interface normal is given by $upright(bold(n))_(I) = nabla phi.alt slash | nabla phi.alt |$. The interface fluxes read $ upright(bold(X)) = mat(delim: "(", 0 ; p_(I) Delta upright(bold(Gamma))_(p) ; p_(I) Delta upright(bold(Gamma))_(p) dot upright(bold(u))_(I)), wide upright(bold(X))^(d) = mat(delim: "(", 0 ; upright(bold(tau))_(I)^(T) Delta upright(bold(Gamma))_(p) ; (upright(bold(tau))_(I)^(T) Delta upright(bold(Gamma))_(p)) dot upright(bold(u))_(I) - upright(bold(q))_(I) dot Delta upright(bold(Gamma))_(p)) . $ <eq-interface-flux>
 Here, $p_(I)$ and $upright(bold(u))_(I)$ denote the interface pressure and interface velocity. The viscous interface stress tensor $upright(bold(tau))_(I)$ is given by $ upright(bold(tau))_(I) = mat(delim: "(", tau_(I)^(11), tau_(I)^(12), tau_(I)^(13) ; tau_(I)^(21), tau_(I)^(22), tau_(I)^(23) ; tau_(I)^(31), tau_(I)^(32), tau_(I)^(33) ;), wide tau_(I)^(i j) = mu_(I) (frac(partial u_(i), partial x_(j)) + frac(partial u_(j), partial x_(i))) - 2/3 mu_(I) delta_(i j) frac(partial u_(k), partial x_(k)), wide mu_(I) = frac(mu_(1)mu_(2), alpha_(1)mu_(2) + alpha_(2)mu_(1)). $
 The interface heat flux $upright(bold(q))_(I)$ reads $ upright(bold(q))_(I) = - lambda_(I) nabla T, wide lambda_(I) = frac(lambda_(1)lambda_(2), alpha_(1)lambda_(2) + alpha_(2)lambda_(1)). $
 The evaluation of $upright(bold(tau))_(I)$ and $upright(bold(q))_(I)$ requires the computation of velocity and temperature gradients at  the interface. The gradient at the interface is approximated with the gradient at the cell center. We use the real fluid state to evaluate these gradients. The real fluid state in a cut cell is approximated by $upright(bold(W)) = alpha_(1)upright(bold(W))_(1) + alpha_(2)upright(bold(W))_(2)$. As we solve Equations (#ref(<eq-FVD-levelset>, supplement: none)) and (#ref(<eq-interface-segment-projection>, supplement: none)) for each phase separately, we emphasize that $upright(bold(n))_(I)$, $alpha$, and $A$ must be computed with respect to the present phase.  Conservation is therefore satisfied since $upright(bold(n))_(I 1) = - upright(bold(n))_(I 2)$, i.e., the interface flux terms for the two fluids at the interface have the same magnitude but opposite sign. The computation of the interface velocity $upright(bold(u))_(I)$ and interface pressure $p_(I)$ depends on the type of interface interaction:
- For *fluid-solid* interactions, the interface velocity is prescribed as either a constant or a space and time-dependent function. The interface pressure $p_(I)$ is approximated with the cell pressure.
- For *fluid-fluid* interactions, the two-material Riemann problem at the interface is solved. The solution reads #cite(<Hu2004>) $ upright(bold(u))_(I) & = frac(rho_(1)c_(1) upright(bold(u))_(1)dot upright(bold(n))_(I 1) + rho_(2)c_(2) upright(bold(u))_(2)dot upright(bold(n))_(I 1) + p_(2) - p_(1) - sigma kappa, rho_(1)c_(1) + rho_(2)c_(2)) upright(bold(n))_(I 1) \ p_(I 1) & = frac(rho_(1)c_(1)(p_(2) + sigma kappa) + rho_(2)c_(2)p_(1) + rho_(1)c_(1)rho_(2)c_(2)(upright(bold(u))_(2)dot upright(bold(n))_(I 1) - upright(bold(u))_(1)dot upright(bold(n))_(I 1)), rho_(1)c_(1) + rho_(2)c_(2)), \ p_(I 2) & = frac(rho_(1)c_(1)p_(2) + rho_(2)c_(2)(p_(1) - sigma kappa) + rho_(1)c_(1)rho_(2)c_(2)(upright(bold(u))_(2)dot upright(bold(n))_(I 1) - upright(bold(u))_(1)dot upright(bold(n))_(I 1)), rho_(1)c_(1) + rho_(2)c_(2)) $
 where $c$ denotes the speed of sound, $sigma$ is the surface tension coefficient, and $kappa = nabla dot upright(bold(n))_(I 1)$ denotes the curvature.  For $sigma != 0$ and $kappa != 0$, the interface pressure experiences a jump at the interface as constituted by mechanical equilibrium. The interface pressure  in Equation (#ref(<eq-interface-flux>, supplement: none)) must be chosen with respect to the present phase.

 Assuming a linear interface within each cut cell, the cell face apertures are computed analytically as follows. The level-set values at the edges of a computational cell are computed using trilinear  interpolation. The sign of the level-set values at the four corners of a cell face determine the cut cell face configuration. @fig-cut-cell-face illustrates three typical cases of a cell face that is intersected by the interface. In total, there are $2^(4)$ different sign combinations of the level-set values along the corners. Hence, there are $2^(4)$ different cut cell face configurations.  For each of these, the cell face aperture is evaluated as the (sum of) areas of the basic geometric shapes, i.e., triangle or trapezoid.
#figure(
  placement: top,
  align(center, canvas({
    import "@preview/cetz:0.4.0": draw
    import draw: *
    let corner(p, filled: false) = circle(p, radius: 0.11, stroke: blue, fill: if filled { blue } else { none })
    // configuration 1
    line((0, 0), (0, 2), (2, 2), (2, 0), (0, 0), stroke: 1pt)
    line((1.0, 0.0), (0.0, 1.0), stroke: (thickness: 1pt, dash: "dashed"))
    corner((0, 0), filled: true); corner((0, 2)); corner((2, 2)); corner((2, 0))
    // configuration 2
    line((3, 0), (3, 2), (5, 2), (5, 0), (3, 0), stroke: 1pt)
    line((3.8, 0.0), (4.2, 2.0), stroke: (thickness: 1pt, dash: "dashed"))
    corner((3, 0), filled: true); corner((3, 2), filled: true); corner((5, 2)); corner((5, 0))
    // configuration 3
    line((6, 0), (6, 2), (8, 2), (8, 0), (6, 0), stroke: 1pt)
    line((6.0, 0.5), (7.0, 2.0), stroke: (thickness: 1pt, dash: "dashed"))
    line((7.2, 0.0), (8.0, 0.8), stroke: (thickness: 1pt, dash: "dashed"))
    corner((6, 0)); corner((6, 2), filled: true); corner((8, 2)); corner((8, 0), filled: true)
  })),
  caption: [Three typical cut cell face configurations. Solid and hollow blue circles indicate positive and negative level-set corner values, respectively.],
) <fig-cut-cell-face>
 The interface segment length $Delta Gamma$ is computed from the apertures as follows. $ Delta Gamma_(i,j,k) &= [ (A_(i + 1/2,j,k) - A_(i - 1/2,j,k))^(2)Delta y Delta z + (A_(i,j + 1/2,k) - A_(i,j - 1/2,k))^(2)Delta x Delta z \ &+ (A_(i,j,k + 1/2) - A_(i,j,k - 1/2))^(2)Delta x Delta y ]^(1/2) $
 Geometrical reconstruction with seven pyramids yields the volume fraction $alpha$. $ alpha_(i,j,k) &= 1/3 frac(1, Delta x Delta y Delta z) [ A_(i + 1/2,j,k) Delta y Delta z 1/2 Delta x + A_(i - 1/2,j,k) Delta y Delta z 1/2 Delta x + A_(i,j + 1/2,k) Delta x Delta z 1/2 Delta y \ &+ A_(i,j - 1/2,k) Delta x Delta z 1/2 Delta y + A_(i,j,k - 1/2) Delta x Delta y 1/2 Delta z + A_(i,j,k + 1/2) Delta x Delta y 1/2 Delta z + Delta Gamma_(i,j,k) phi.alt_(i,j,k) ] $
 Note that the described approach yields the volume fraction and apertures with respect to the positive phase. The values of the negative phase can be obtained from relations (#ref(<eq-posnegphase>, supplement: none)).

 The level-set field is advected by the interface velocity $upright(bold(u))_(I)= upright(bold(n))_(I) u_(I)$ by solving the level-set advection equation.  $ frac(partial phi.alt, partial t) + upright(bold(u))_(I)dot nabla phi.alt = 0 $ <eq-levelset-advection>
 The spatial term in Equation (#ref(<eq-levelset-advection>, supplement: none)) is discretized using high-order upstream central (HOUC) #cite(<Nourgaliev2007>) stencils. For the temporal integration, we apply the same scheme that is used to integrate the conservative variables, which typically is a Runge-Kutta method, see @subsec-timeint. The level-set field is only advected within a narrowband around the interface.

 In order to apply the reconstruction stencils used in the finite-volume discretization near the interface, we extrapolate the real fluid state to the other side of the interface. We denote the cells on the other side of the interface as ghost cells.  An arbitrary quantity $psi$ is extrapolated from the real cells to the ghost cells by advancing it in a fictitious time $tau$ to steady state according to $ frac(partial psi, partial tau) plus.minus upright(bold(n))_(I)dot nabla psi = 0 . $ <eq-extension>
 The sign of the interface normal $plus.minus upright(bold(n))_(I)$ depends on the sign of the present phase: To extrapolate the real fluid state of the positive phase into its ghost cells, we must extrapolate  into the direction of the negative level-set, i.e. $- upright(bold(n))_(I)$, and vice versa. The spatial term is discretized using a first-order upwind stencil.  Temporal integration is performed with the Euler method. Note that we also use this extension procedure to extend the interface velocity from the cut cells into the narrowband around the interface, where we advect the level-set field.

 The computation of the geometrical quantities requires the level-set field to be a signed distance function. During a simulation, the level-set field loses its signed distance property due to numerical errors and/or a shearing flow field. Additionally, since we only advect the level-set field within a narrowband around the interface, the level-set field develops a kink at the edge of the narrowband and the  remainder of the computational domain. The signed distance property is maintained via reinitialization of the level-set field. The reinitialization equation reads $ frac(partial phi.alt, partial tau) + s g n(phi.alt^(0)) (| nabla phi.alt | - 1) = 0 . $ <eq-reinitialization>
 Here, $phi.alt^(0)$ represents the level-set at a fictitious time $tau = 0$. We apply first-order #cite(<Russo2000>) or higher-order WENO-HJ #cite(<jiang2000weighted>) schemes to solve this equation. We reinitialize the level-set each physical time step for a fixed amount of fictitious time steps resulting in a sufficiently small residual of Equation (#ref(<eq-reinitialization>, supplement: none)).

 The presented level-set method is not consistent when the interface crosses a cell face within a single time step, i.e., when new fluid cells are created or fluid cells have vanished.  @fig-mixing displays this scenario for a 1D discretization. The interface  is moving from cell $i - 1$ to cell $i$. At $t^(n)$, cell $i$ is a newly created cell w.r.t. phase 1 and cell $i - 1$ is a vanished cell w.r.t. phase 2. To maintain conservation, we must do the following. For phase 1, conservative variables must be taken from cell $i - 1$ and put into the newly created cell $i$. For phase 2, conservative variables must be taken from cell $i$ and put into the vanished cell $i - 1$. In addition to the scenario where an interface crosses the cell face, small cut cells may generally lead to an unstable integration using the time step restriction that is based on a full cell.  We apply a mixing procedure #cite(<Hu2006>) that deals with these problems. The procedure is applied to two types of cells.
+ Cells where $alpha = 0$ after integration but $alpha != 0$ before (vanished cells).
+ Cells with $alpha < alpha_(#text[mix])$ after integration (newly created cells and small cells).
 We use a mixing threshold of $alpha_(#text[mix]) = 0.6$. For each cell that requires mixing, we identify target (trg) cells from the interface normal. Consider cell $i$ in @fig-mixing, which is a small/newly created cell for phase 1. Here, the target cell in $x$ direction is cell $i - 1$, as $upright(bold(n))_(I 1)dot upright(bold(i)) < 0$. Analogously,  cell $i - 1$ is a vanished cell for phase 2. The corresponding target is cell $i$, since $upright(bold(n))_(I 2)dot upright(bold(i)) > 0$.  In 3D, there are 7 target cells in total: One in each spatial direction $x$, $y$, and $z$, one in each plane $x y$, $x z$, and $y z$, and one in $x y z$. Seven mixing weights are computed as $ beta_(x) & = | upright(bold(n))_(I)dot upright(bold(i)) |^(2) alpha_(t r g) \ beta_(y) & = | upright(bold(n))_(I)dot upright(bold(j)) |^(2) alpha_(t r g) \ beta_(z) & = | upright(bold(n))_(I)dot upright(bold(k)) |^(2) alpha_(t r g) \ beta_(x y) & = | (upright(bold(n))_(I)dot upright(bold(i))) (upright(bold(n))_(I)dot upright(bold(j))) | alpha_(t r g), \ beta_(x z) & = | (upright(bold(n))_(I)dot upright(bold(i))) (upright(bold(n))_(I)dot upright(bold(k))) | alpha_(t r g) \ beta_(y z) & = | (upright(bold(n))_(I)dot upright(bold(j))) (upright(bold(n))_(I)dot upright(bold(k))) | alpha_(t r g) \ beta_(x y z) & = | (upright(bold(n))_(I)dot upright(bold(i))) (upright(bold(n))_(I)dot upright(bold(j))) (upright(bold(n))_(I)dot upright(bold(k))) |^(2 slash 3) alpha_(t r g). $
 Here, $alpha_(t r g)$ denotes the volume fraction of the target cell in the corresponding direction. We normalize the mixing weights so that $sum_(t r g) beta_(t r g) = 1$, where $t r g in {x,y,z,x y,x z,y z,x y z }$. Subsequently, the mixing flux $upright(bold(M))_(t r g)$ is computed like $ upright(bold(M))_(t r g) = frac(beta_(t r g), alpha beta_(t r g) + alpha_(t r g)) [ (alpha_(t r g)overline(upright(bold(U)))_(t r g))alpha - (alpha overline(upright(bold(U))))alpha_(t r g) ] . $
 The conservative variables are then updated according to $ alpha overline(upright(bold(U))) & = (alpha overline(upright(bold(U))))^(*) + sum_(t r g)upright(bold(M))_(t r g), \ alpha_(t r g) overline(upright(bold(U)))_(t r g) & = (alpha_(t r g) overline(upright(bold(U)))_(t r g))^(*) - sum_(t r g)upright(bold(M))_(t r g). $
 Here, $alpha overline(upright(bold(U)))$ and $alpha_(t r g) overline(upright(bold(U)))_(t r g)$ denote the conservative variables of the cells that require mixing  and the conservative variables of the corresponding target cells, respectively. Star-quantities denote conservative variables before mixing.
#figure(
  placement: top,
  align(center, canvas({
    import "@preview/cetz:0.4.0": draw
    import draw: *
    line((0, 0), (14, 0), stroke: 1pt)
    circle((4, 0), radius: 0.08, fill: black, stroke: none)
    circle((10, 0), radius: 0.08, fill: black, stroke: none)
    content((4, -0.45), [$i-1$])
    content((7, -0.45), [$i-1\/2$])
    content((10, -0.45), [$i$])
    content((4, 2.2), [vanished cell], fill: blue)
    content((10, 2.2), [target cell], fill: blue)
    content((4, -2.2), [target cell], fill: red)
    content((10, -2.2), [newly created cell], fill: red)
    content((1, -2.2), [$phi > 0$], fill: red)
    content((13, 2.2), [$phi < 0$], fill: blue)
    line((1, 0.3), (1, -0.3))
    line((7, 0.3), (7, -0.3))
    line((13, 0.3), (13, -0.3))
    let gr = rgb("#008000").darken(30%)
    line((6.2, 1.5), (6.2, -1.5), stroke: (paint: gr, thickness: 0.8pt, dash: "dashed"))
    content((6.2, 1.7), [$Gamma_0 (t^(n-1))$], anchor: "south")
    line((8.5, 1.5), (8.5, -1.5), stroke: (paint: gr, thickness: 0.8pt, dash: "dashed"))
    content((8.5, 1.7), [$Gamma_0 (t^n)$], anchor: "south")
    line((7, -1.5), (8.5, -1.5), mark: (start: ">", end: ">"))
    content((7.75, -1.35), [$alpha_1$], anchor: "south")
    line((8.5, 1.5), (13, 1.5), mark: (start: ">", end: ">"))
    content((10.75, 1.35), [$alpha_2$], anchor: "north")
    line((5, -3), (9, -3), mark: (end: ">"), stroke: 1pt)
    content((7, -3.2), [Mixing flux $bold(M)_1$], anchor: "north")
    line((5, 3), (9, 3), mark: (start: ">"), stroke: 1pt)
    content((7, 3.2), [Mixing flux $bold(M)_2$], anchor: "south")
  })),
  caption: [Schematic illustrating the mixing procedure in a 1D discretization at $t^n$. Red and blue color indicate the positive and negative phases. Green indicates interface positions $Gamma_0$ at $t^(n-1)$ and $t^n$.],
) <fig-mixing>

== Computational Domain and Boundary Conditions

 The computational domain is a cuboid. @fig-computational-domain depicts an exemplary computational domain including the nomenclature for the boundary locations. The solver provides symmetry, periodic, no-slip wall, Dirichlet, and Neumann boundary conditions.  The no-slip wall boundary condition allows the user to specify either a constant value or time-dependent function for the wall velocity.  The Dirichlet and Neumann boundary conditions allow the user to specify either a constant value or a space and time-dependent function.
Furthermore, (in 2D only) multiple different types of boundary conditions may be imposed along a single boundary location. Here, the user must specify the starting and end point of each of the different boundary types along the specific boundary location. The level-set implementation allows for arbitrary immersed solid boundaries.

#figure(
  placement: top,
  align(center, canvas({
    import "@preview/cetz:0.4.0": draw
    import draw: *
    let fb = blue.transparentize(70%)
    let fr = red.transparentize(70%)
    let fg = green.transparentize(70%)
    line((0, 0), (0, 3), (5, 3), (5, 0), fill: fb, close: true, stroke: none)
    line((1.5, 1.5), (1.5, 4.5), (6.5, 4.5), (6.5, 1.5), fill: fb, close: true, stroke: none)
    line((5, 0), (5, 3), (6.5, 4.5), (6.5, 1.5), fill: fr, close: true, stroke: none)
    line((0, 0), (0, 3), (1.5, 4.5), (1.5, 1.5), fill: fr, close: true, stroke: none)
    line((0, 0), (1.5, 1.5), (6.5, 1.5), (5, 0), fill: fg, close: true, stroke: none)
    line((0, 3), (1.5, 4.5), (6.5, 4.5), (5, 3), fill: fg, close: true, stroke: none)
    line((0, 0), (0, 3), (5, 3), (5, 0), close: true, stroke: 0.8pt)
    line((0, 3), (1.5, 4.5), (6.5, 4.5), (5, 3), stroke: 0.8pt)
    line((5, 0), (6.5, 1.5), (6.5, 4.5), stroke: 0.8pt)
    line((0, 0), (1.5, 1.5), (6.5, 1.5), stroke: 0.8pt)
    content((3.25, 0.75), [#text(fill: rgb("#006400"))[south]])
    content((4.0, 2.8), [#text(fill: blue)[top]])
    content((1.5, 3.0), [#text(fill: red)[west]])
    content((6.5, 3.0), [#text(fill: red)[east]])
    content((3.25, 3.75), [#text(fill: rgb("#006400"))[north]])
    content((2.5, 1.3), [#text(fill: blue)[bottom]])
    line((1.5, 1.5), (3.2, 1.5), mark: (end: ">"), stroke: 1pt)
    content((3.4, 1.5), [$x$])
    line((1.5, 1.5), (1.5, 3.0), mark: (end: ">"), stroke: 1pt)
    content((1.5, 3.15), [$y$])
    line((1.5, 1.5), (0.6, 0.9), mark: (end: ">"), stroke: 1pt)
    content((0.35, 0.75), [$z$])
  })),
  caption: [Computational domain with boundary locations.],
) <fig-computational-domain>

#figure(
  placement: top,
  text(8pt, table(
    columns: 3,
    stroke: none,
    align: center + horizon,
    table.hline(),
    [Time Integration], [Euler], [],
    [], [TVD-RK2 #cite(<Gottlieb1998a>)], [],
    [], [TVD-RK3 #cite(<Gottlieb1998a>)], [],
    table.hline(),
    [Flux Function/Riemann Solver], [Lax-Friedrichs (LxF)], [According to],
    [], [Local Lax-Friedrichs (LLxF, Rusanov)], [According to],
    [], [HLL/HLLC/HLLC-LM #cite(<Harten1983a>) #cite(<Toro1994>) #cite(<Toro2009a>) #cite(<Toro2019>) #cite(<Fleischmann2020>)], [Signal speed estimates see below],
    [], [AUSM+ #cite(<Liou1996>)], [],
    [], [Componentwise LLxF], [Flux-splitting formulation],
    [], [Roe #cite(<Roe1981>)], [Flux-splitting formulation],
    table.hline(),
    [Signal Speed Estimates], [Arithmetic], [],
    [], [Davis #cite(<Davis1988>)], [],
    [], [Einfeldt #cite(<Einfeldt1988a>)], [],
    [], [Toro #cite(<Toro1994>)], [],
    table.hline(),
    [Spatial Reconstruction], [WENO1 #cite(<Jiang1996>)], [],
    [], [WENO3-JS/Z/N/F3+/NN #cite(<Jiang1996>) #cite(<Acker2016a>) #cite(<Gande2020>) #cite(<Bezgin2021b>)], [],
    [], [WENO5-JS/Z #cite(<Jiang1996>) #cite(<Borges2008a>)], [],
    [], [WENO6-CU/CUM #cite(<Hu2010>) #cite(<Hu2011>)], [],
    [], [WENO7-JS #cite(<Balsara2000>)], [],
    [], [WENO9-JS #cite(<Balsara2000>)], [],
    [], [TENO5 #cite(<Fu2016>)], [],
    [], [Second-order central], [For dissipative terms only],
    [], [Fourth-order central], [For dissipative terms only],
    table.hline(),
    [Spatial Derivatives], [Second-order central], [],
    [], [Fourth-order central], [],
    [], [HOUC-3/5/7 #cite(<Nourgaliev2007>)], [],
    table.hline(),
    [Levelset reinitialization], [First-order #cite(<Russo2000>)], [],
    [], [HJ-WENO #cite(<jiang2000weighted>)], [],
    table.hline(),
    [Ghost fluid extension], [First-order upwind #cite(<Hu2006>)], [],
    table.hline(),
    [LES Modules], [ALDM #cite(<Hickel2014b>)], [],
    table.hline(),
    [Equation of State], [Ideal Gas], [],
    [], [Stiffened Gas #cite(<Menikoff1989>)], [],
    [], [Tait #cite(<Fedkiw1999a>)], [],
    table.hline(),
    [Boundary Conditions], [Periodic], [],
    [], [Zero Gradient], [E.g., used for outflow boundaries],
    [], [Neumann], [E.g., for a prescribed heat flux],
    [], [Dirichlet], [],
    [], [No-slip Wall], [],
    [], [Immersed Solid Boundaries], [Arbitrary geometries via level-set],
    table.hline(),
  )),
  caption: [Overview on numerical methods available in JAX-FLUIDS.],
  kind: table,
) <tab-NumericalMethods>


= Software Implementation Details
 <sec-Implementation>

 In the past, CFD solvers have been written predominantly in low-level programming languages like Fortran and C/C++. These languages offer computational performance and CPU parallelization capabilities. However, the integration of ML models, which are typically coded in Python, is not straightforward and automatic differentiation capabilities are nonexistent. With the present work, we want to provide a CFD framework that allows for seamless integration and end-to-end optimization of ML models, without major performance losses. The Python package JAX #cite(<jax2018github>) satisfies these requirements. Therefore, we use JAX as the fundamental building block of JAX-FLUIDS. In this section, we give implementation details and the algorithmic structure of JAX-FLUIDS.

== Array Programming in JAX

 JAX is a Python library for high-performance numerical computations, which uses XLA to compile and run code on accelerators like CPUs, GPUs, and TPUs. Designed as a machine learning library, JAX supports automatic differentiation #cite(<Baydin2018>). In particular, JAX comes with a fully-differentiable version of the popular NumPy package #cite(<Harris2020>) called JAX NumPy. Both Python and NumPy are widely popular and easy to use. NumPy adds high-level functionality to handle large arrays and matrices.

 The backbone of (JAX) NumPy is the multidimensional array, so called `jax.numpy.DeviceArray`. We use arrays to store all of our field data. In particular, the vectors of conservative and primitive variables, $upright(bold(U))$ and $upright(bold(W))$, are stored in arrays of shape $(5, N_(x) + 2 N_(h), N_(y) + 2 N_(h), N_(z) + 2 N_(h))$. $(N_(x), N_(y), N_(z))$ denote the resolution in the three spatial directions, and $N_(h)$ specifies the number of halo cells. Our implementation naturally degenerates for one- and two-dimensional settings by using only a single cell in the excess dimensions.

 In the _array programming paradigm_ (see #cite(<Walt2011>) for details on numerical operations on arrays in NumPy), every operation is performed on the entire array. I.e., instead of writing loops over the array as is common in Fortran or C/C++, we use appropriate indexing/slicing operations. As a result, many parts of the code used from classical CFD solvers have to be rewritten according to the _array programming paradigm_. As an example we include the source code of our implementation of the second-order central cell face reconstruction scheme in @fig-reconstruction. The `class CentralSecondOrderReconstruction` inherits from `class SpatialReconstruction`. This parent class has an abstract member function `reconstruct_xi`, which must be implemented in every child class.  `reconstruct_xi` receives the entire `buffer` and the  reconstruction direction `axis` as arguments.

 The data buffer has to be indexed/sliced differently depending on the spatial direction of the reconstruction and the dimensionality of the problem. Note that the buffer array has shape $(5, N_(x) + 2 N_(h), N_(y) + 2 N_(h), N_(z) + 2 N_(h))$ if the problem is three-dimensional,  $(5, N_(x) + 2 N_(h), N_(y) + 2 N_(h), 1)$ if the problem is two-dimensional, and $(5, N_(x) + 2 N_(h), 1, 1)$ if the problem is one-dimensional.  The slice indices have to be adapted accordingly. To prevent boilerplate code in the reconstruction routine, we abstract the slicing operations. The member variable `self.slices` is a list that holds the correct slice objects for each spatial direction. Consider reconstructing in $x$-direction (`axis=0`) using the present second-order cell face  reconstruction scheme, $ upright(bold(U))_(i + 1/2,j,k)= 1/2(upright(bold(U))_(i,j,k) + upright(bold(U))_(i + 1,j,k)). $
 Here, we require two slice objects: `jnp.s_[...,self.nh-1:-self.nh,self.nhy,self.nhz]` for $upright(bold(U))_(i,j,k)$ and `jnp.s_[...,self.nh:-self.nh+1,self.nhy,self.nhz]` for $upright(bold(U))_(i + 1,j,k)$. The variable `self.nh` denotes the number of halo cells. The slices in $x$-direction, i.e., `self.nh-1:-self.nh` and `self.nh:-self.nh+1`, are determined by the reconstruction scheme itself.  `self.nhy` and `self.nhz` denote the slice objects for the dimensions in which we do not reconstruct. These are either `self.nh:-self.nh` if the dimension is active or `None:None` if the dimension is inactive. `self.nhx`, `self.nhy`, and `self.nhz` are defined in the parent class.

#figure(
  placement: top,
  listing("code/reconstruction_stencil.py"),
  caption: [Code snippet for the second-order central cell face reconstruction stencil.],
) <fig-reconstruction>

== Object-oriented Programming in the Functional Programming World of JAX

 As already alluded to in the previous subsection, we use object-oriented programming (OOP) throughout the entire JAX-FLUIDS solver. Although JAX leans inherently more towards a functional programming style, we have opted to program JAX-FLUIDS in a modular object-oriented approach since this has several benefits. Firstly, comprehensive CFD solvers typically offer a plethora of interchangeable numerical algorithms. Naturally, OOP allows the implementation of many derived classes, e.g., different spatial reconstructors (see `class SpatialReconstruction` in the previous subsection), and saves boilerplate code.  Secondly, the modular OOP approach allows users to customize a solver specific to their problem. Via a numerical setup file, the user can detail the numerical setup prior to every simulation. Thirdly, we want to stress that the modularity of our solver allows for straightforward integration of custom modules and implementations. For example, avid ML-CFD researchers can easily implement their own submodule into the JAX-FLUIDS framework, either simply for forward simulations or for learning new routines from data.

== Just-in-time (jit) Compilation and Pure Functions
 JAX offers the possibility to just-in-time (jit) compile functions, which significantly increases the performance. However, jit-compilation imposes two constraints:
+ *The function must be a pure function*. A function is pure if its return values are identical for identical input arguments and the function has no side effects.
+ *Control flow statements in the function must not depend on input argument values*. During jit-compilation, an abstract version of the function is cached that works for arbitrary argument values. I.e., the function is not compiled for concrete argument values but rather for the set of all possible argument values where only the array shape and type is fixed. Therefore, control flow statements that depend on the input argument values can not be jit-compiled, unless  the argument is a _static argument_. In this case, the function is recompiled for all values that the _static argument_ takes during runtime.
 The aforementioned requirements to jit-compile a function have the following impact on our implementation:
- The `self` argument in jit-compiled member functions must be a _static argument_.  This implies that class member variables that are used in the function are static and hence must not be modified.  In other words, the type of class member variables is similar to the C++ type `constexpr`.
- Control flow statements in jit-compiled functions can only be evaluated on _static arguments_.  In our code, there are three distinct types of control flow statements where this has an impact:
  + *Conditional exit of a for/while loop*. The top level compute loop over the physical simulation time (compare Algorithm @alg-main-loop) is not jit-compiled, since it consists of a while loop that is  exited when the final simulation time is reached $t >= t_(e n d)$. However, $t$ is not a static variable.  We therefore only jit-compile the functions `compute_timestep`, `do_integration_step()`, and `compute_forcings()`.  These are the functions that constitute the heavy compute within the main loop.
  + *Conditional slicing of an array*. In multiple parts of the JAX-FLUIDS code, arrays are sliced depending on the present spatial direction. The present spatial direction is indicated by the input argument `axis` (compare cell face reconstruction in @fig-reconstruction). The code that is actually executed conditionally depends on the value of `axis`. Therefore, `axis` must be a static argument.  Functions that receive `axis` as an input argument are compiled for all values that `axis` might take during runtime. Each compiled version of those functions is cached.
  + *Conditional executation of code sections*.  We explained above that class member variables are always static.  In practice, we often use them to conditionally compile code sections,  much like the `if constexpr` in C++.  An example is the cell face reconstruction of the variables, which can be done on primitive or conservative variables  in either physical or characteristic space.
- Element-wise conditional array operations are implemented using masks, as jit-compilation requires the array shapes to be fixed at compile time. @fig-masks exemplarily illustrates the use of masks, here for the evaluation of the level-set advection equation. We make frequent use of `jnp.where` to implement element-wise conditional array operations.

#figure(
  placement: top,
  listing("code/conditional_operations.py"),
  caption: [Code snippet showing the right-hand-side computation of the level-set advection equation.],
) <fig-masks>

== Main Objects and Compute Loops
 <subsec-ComputeLoops>

 We put emphasis on making JAX-FLUIDS an easy-to-use Python package for ML-CFD research.  @fig-run-solver shows the required code lines to run a simulation. The user must provide a numerical setup and a case setup file in the _json_ format. The numerical setup specifies the combination of numerical methods that will be used for the simulation. The case setup details the physical properties of the simulation including the spatial domain and its resolution, initial and boundary conditions, and material properties. As an example, we include the numerical setup and case setup for the Sod shock tube test case in the appendix in @fig-numerical-setup and @fig-case-setup, respectively. Using the _json_ files, we create an `class InputReader` instance, which we denote as `input_reader`. The `input_reader` performs necessary data type transformations and a thorough sanity check ensuring  that the provided numerical and case setups are consistent.

Then, an `class Initializer` and a `class SimulationManager` object are created  using the `input_reader` object. The `class Initializer` implements functionality to generate the initial buffers from either the initial condition specified in the case setup file or from a restart file. We receive these buffers  by calling the `initialization` method of the `initializer` object. The `class SimulationManager` is the main class in JAX-FLUIDS, implementing the algorithm to advance the initial buffers in time using the specified numerical setup. The initial buffers must be passed to the `simulate` method of the `simulation_manager` object. The simulation starts upon execution of this function.

#figure(
  placement: top,
  listing("code/run_nlfvs.py"),
  caption: [Code snippet illustrating how to run a simulation with JAX-FLUIDS.],
) <fig-run-solver>

 The code contains three major loops:
+ *Loop over physical simulation time*, see Algorithm @alg-main-loop.
+ *Loop over Runge-Kutta stages*, see Algorithm @alg-do-integration-step.
+ *Loop over active spatial dimensions*, see Algorithm @alg-compute-rhs.

#figure(
  placement: top,
  block(width: 100%, stroke: 0.5pt, inset: 8pt)[
    #set par(justify: false)
    #set text(size: 9pt)
    *while* time < end time *do*
    #block(inset: (left: 1.2em))[
      #code("compute_timestep()") \
      #text(fill: red, code("forcings_handler.compute_forcings()")) \
      #code("do_integration_step()") \
      #code("output_writer.write_output()")
    ]
    *end while*
  ],
  caption: [Loop over physical simulation time in the #code("simulate") function. Red text color indicates functions that are only executed for simulations with active forcings.],
  kind: "algorithm",
  supplement: [Algorithm],
) <alg-main-loop>


#figure(
  placement: top,
  block(width: 100%, stroke: 0.5pt, inset: 8pt)[
    #set par(justify: false)
    #set text(size: 9pt)
    *for* all RK stages *do*
    #block(inset: (left: 1.2em))[
      #code("space_solver.compute_rhs()") \
      #text(fill: blue, code("levelset_handler.transform_volume_averages_to_conservatives()")) \
      #code("time_integrator.prepare_buffers_for_integration()") \
      #code("time_integrator.integrate_conservatives()") \
      #text(fill: blue, code("time_integrator.integrate_levelset()")) \
      #text(fill: blue, code("levelset_handler.reinitialize_levelset()")) \
      #text(fill: blue, code("boundary_condition.fill_boundaries_levelset()")) \
      #text(fill: blue, code("levelset_handler.compute_geometrical_quantities()")) \
      #text(fill: blue, code("levelset_handler.mix_conservatives()")) \
      #text(fill: blue, code("levelset_handler.transform_conservatives_to_volume_averages()")) \
      #code("get_primitives_from_conservatives()") \
      #text(fill: blue, code("levelset_handler.extend_primitives_into_ghost_cells()")) \
      #code("boundary_condition.fill_material_boundaries()")
    ]
    *end for*
  ],
  caption: [Loop over Runge-Kutta stages in the #code("do_integration_step") function. Blue text color indicates functions that are only executed for two-phase simulations.],
  kind: "algorithm",
  supplement: [Algorithm],
) <alg-do-integration-step>


#figure(
  placement: top,
  block(width: 100%, stroke: 0.5pt, inset: 8pt)[
    #set par(justify: false)
    #set text(size: 9pt)
    *for* all active axes *do*
    #block(inset: (left: 1.2em))[
      #code("flux_computer.compute_inviscid_flux_xi()") \
      #code("flux_computer.compute_viscous_flux_xi()") \
      #code("flux_computer.compute_heat_flux_xi()") \
      #text(fill: blue, code("levelset_handler.weight_cell_face_flux_xi()")) \
      #text(fill: blue, code("levelset_handler.compute_interface_flux_xi()")) \
      #text(fill: blue, code("levelset_handler.compute_levelset_advection_rhs()"))
    ]
    *end for*
  ],
  caption: [Loop over spatial dimensions in the #code("compute_rhs") function. Blue text color indicates functions that are only executed for two-phase simulations.],
  kind: "algorithm",
  supplement: [Algorithm],
) <alg-compute-rhs>


== Gradient Computation in JAX-FLUIDS
 <subsec-gradients> JAX-FLUIDS offers the `simulate` method to perform a standard forward CFD simulation. In this regard, JAX-FLUIDS  serves as a physics simulator for data generation, development of numerical methods, and exploration of fluid dynamics. The `simulate` method does not have a return value, therefore, it is not meant to be used for end-to-end optimization.

 To use the automatic differentiation capabilities of JAX-FLUIDS, we offer the `feed_forward` method. This method takes in a batch of initial buffers and propagates them in time for a fixed number of time steps. The user provides  the number of integration steps and a fixed time step. The output of the `feed_forward` method is the solution trajectory.  In particular, the shape of the initial buffer is $(N_(b), 5, N_(x), N_(y), N_(z))$ where $N_(b)$ is the batch size. The shape of  the solution trajectory is $(N_(b), N_(T) + 1, 5, N_(x), N_(y), N_(z))$ where $N_(T)$ is the number of integration steps.  Internally, the `feed_forward` method uses the `jax.vmap` routine to vectorize  over the batch dimension. `feed_forward` is jit-compilable and can be differentiated with `jax.grad` or `jax.value_and_grad`. The `feed_forward` method  of JAX-FLUIDS can therefore be used for end-to-end optimization of ML models.

== Integration of ML models into JAX-FLUIDS
 <subsec-MLJAXFLUIDS> JAX-FLUIDS works with Haiku #cite(<haiku2020github>) and Optax #cite(<optax2020github>). The Haiku package is a neural network library for JAX. In Haiku, neural networks are of type `haiku.Module`. To use them in combination with JAX, the feedforward method of the network has to be embedded in a function that is transformed into a forward wrapper object of type `haiku.Transformed`. This forward wrapper object provides two pure methods, `init` and `apply`. The `init` method initializes the network parameters, and  the `apply` method executes the feedforward of the network. Network parameters have to be explicitly passed to the `apply` method. We refer to the Haiku documentation for more details. Optax provides optimization routines, e.g., the popular Adam optimizer #cite(<Kingma2015>).

 In JAX-FLUIDS, we provide functionality to include preexisting ML models and optimize new ones. Neural networks can be passed to the `simulate` and `feed_forward` method. Note that only the `feed_forward` method can be differentiated, see @subsec-gradients. I.e., it must be used for optimization of deep learning models. A typical use case in ML-CFD research is substituting a conventional numerical subroutine with a data-driven alternative. We provide a number of interfaces inside the JAX-FLUIDS solver to which network modules  can be passed from `feed_forward`, e.g., to the cell face reconstruction, the Riemann solver, or the forcing module. On the top level, the user gives a dictionary of transformed network modules  and a dictionary with corresponding network parameters to the `feed_forward` method. The keys of these dictionaries specify the JAX-FLUIDS subroutine to which the corresponding values are passed.


= Validation of JAX-FLUIDS as a Classical CFD Simulator
 <sec-ForwardPass>
We show the capabilities of the JAX-FLUIDS solver as a classical fluid dynamics simulator. We validate our implementation on established one- and two-dimensional test cases from gas dynamics and several canonical turbulent flows.  In @subsec-SinglePhase we first validate the single-phase implementation in JAX-FLUIDS. In @subsec-Twophase we then validate the two-phase level-set implementation for fluid-solid and fluid-fluid interactions.

 We define two numerical setups which we will use predominantly throughout this section. Firstly, we use the _High-Order Godunov_ formulation. This setup consists of a WENO5-JS reconstruction of the primitive variables with an approximate HLLC Riemann solver. We will refer to this setup as _HLLC_. Secondly, we employ the _Flux-Splitting_ formulation. In particular, we choose Roe approximate Riemann solver with a WENO5-JS flux reconstruction in characteristic space. This setup will be denoted as _ROE_. The dissipative fluxes are discretized with a fourth-order central finite difference stencil as described in @subsec-Dissipative. If not specified otherwise we will use the stiffened gas equation of state with $gamma = 1.4$ and $B = 0$, i.e., the ideal gas law.  We will use the classical TVD-RK3 scheme with $C F L_(#text[conservatives])= 0.9$ for time integration. For the two-phase test cases, we additionally apply the following methods. The level-set advection equation is discretized with a HOUC5 stencil. We solve the extension equation using a first-order upwind spatial derivative stencil combined with an Euler integration scheme.  Here, we apply a fixed number of $15$ steps with $C F L_(#text[extension])= 0.7$. The reinitialization equation is solved with a WENO3-HJ stencil combined with a TVD-RK2 scheme.  The level-set field is reinitialized each physical time step by integrating the reinitialization equation  for one step with $C F L_(#text[reinitialization])= 0.7$. We refer to @sec-numericalmodel and therein to @tab-NumericalMethods for details on numerical models.

== Single Phase Simulations
 <subsec-SinglePhase>

=== Convergence Study
 <subsubsec-Convergence>

 We analyze the convergence behavior of our solver. We simulate the advection of a density profile in a one-dimensional periodic domain of extent $x in [0, 1 ]$ with constant velocity $u = 1$ and pressure $p = 1$. We use a sinusoidal initial condition for the density
$ rho (x, t = 0) = 1.5 + sin (2 pi x). $ <eq-SinusDensity>

Note that we initialize the cell-averaged values of Equation (#ref(<eq-SinusDensity>, supplement: none)). I.e., for cell $i$ with cell-center $x_(i)$ we use $overline(rho)_(i) = 1.5 - 1.0 slash (2 pi Delta x) (cos (2 pi x_(i + 1 slash 2)) - cos (2 pi x_(i - 1 slash 2)))$. We conduct simulations with WENO1-JS, WENO3-JS, and WENO5-JS spatial discretizations and evaluate the rate of convergence upon mesh refinement. We use TVD-RK2 for WENO1- and WENO3-JS.  For WENO5-JS we use TVD-RK3. We use a fixed time step $Delta t = 1 times 10^(- 4)$ which is chosen small enough to exclude any influence of the time integration scheme. The simulation is propagated until $t_(#text[end]) = 1.0$. @fig-convergence shows the convergence rates in the $l_(1)$, $l_(2)$, and $l_(infinity)$ norms. We increase the resolution from $10$ to $1000$ points. The expected convergence rates of $cal(O) (Delta x^(1))$, $cal(O) (Delta x^(2))$, and $cal(O) (Delta x^(5))$ are reached. Note that it is well known that the convergence order of WENO3-JS drops to second order under the presence of extreme points.

#figure(
  placement: top,
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 5pt,
    align(center, pbox(canvas({
      plot.plot(size: (3.3, 3.2), x-mode: "log", y-mode: "log", x-tick-step: 1, y-tick-step: 3, x-format: "sci", y-format: "sci",
        x-label: [$Delta x$], y-label: [$|rho - hat(rho)|_1$],
        x-min: 0.0008, x-max: 0.13, y-min: 2e-12, y-max: 2,
        legend: "inner-north-east", legend-anchor: "north-east", legend-style: (scale: 75%), {
        plot.add(d("convergence-001"), style: (stroke: black))
        plot.add(d("convergence-000"), style: (stroke: c0), mark: "o", mark-size: 0.13, label: [WENO1])
        plot.add(d("convergence-003"), style: (stroke: black))
        plot.add(d("convergence-002"), style: (stroke: c1), mark: "o", mark-size: 0.13, label: [WENO3])
        plot.add(d("convergence-005"), style: (stroke: black))
        plot.add(d("convergence-004"), style: (stroke: c2), mark: "o", mark-size: 0.13, label: [WENO5])
      })
    }))),
    align(center, pbox(canvas({
      plot.plot(size: (3.3, 3.2), x-mode: "log", y-mode: "log", x-tick-step: 1, y-tick-step: 3, x-format: "sci", y-format: "sci",
        x-label: [$Delta x$], y-label: [$|rho - hat(rho)|_2$],
        x-min: 0.0008, x-max: 0.13, y-min: 2e-12, y-max: 2, {
        plot.add(d("convergence-007"), style: (stroke: black))
        plot.add(d("convergence-006"), style: (stroke: c0), mark: "o", mark-size: 0.13)
        plot.add(d("convergence-009"), style: (stroke: black))
        plot.add(d("convergence-008"), style: (stroke: c1), mark: "o", mark-size: 0.13)
        plot.add(d("convergence-011"), style: (stroke: black))
        plot.add(d("convergence-010"), style: (stroke: c2), mark: "o", mark-size: 0.13)
      })
    }))),
    align(center, pbox(canvas({
      plot.plot(size: (3.3, 3.2), x-mode: "log", y-mode: "log", x-tick-step: 1, y-tick-step: 3, x-format: "sci", y-format: "sci",
        x-label: [$Delta x$], y-label: [$|rho - hat(rho)|_infinity$],
        x-min: 0.0008, x-max: 0.13, y-min: 2e-12, y-max: 2, {
        plot.add(d("convergence-013"), style: (stroke: black))
        plot.add(d("convergence-012"), style: (stroke: c0), mark: "o", mark-size: 0.13)
        plot.add(d("convergence-015"), style: (stroke: black))
        plot.add(d("convergence-014"), style: (stroke: c1), mark: "o", mark-size: 0.13)
        plot.add(d("convergence-017"), style: (stroke: black))
        plot.add(d("convergence-016"), style: (stroke: c2), mark: "o", mark-size: 0.13)
      })
    }))),
  ),
  caption: [Error convergence $|rho - hat(rho)|_p$ for the linear advection of Eq. (@eq-SinusDensity) with WENO1, WENO3, and WENO5 spatial discretization. $hat(rho)$ is the analytical solution at $t_("end") = 1.0$. From left to right: $l_1$, $l_2$, and $l_infinity$ norms.],
) <fig-convergence>

=== Shock Tube Tests
 <subsubsec-Shocktube> The shock tube tests of Sod #cite(<Sod1978a>) and Lax #cite(<Lax1954>) are standard one-dimensional test cases for validating fluid solvers for compressible flows. Specifically, we use these test cases to validate the implementation of the convective fluxes and the shock-capturing schemes. In both shock tube test cases three waves emanate from the initial discontinuities: a left running rarefaction, a right running contact discontinuity, and a right running shock. A detailed description of the tests and their setups are provided in the presented references. We discretize the domain $x in [0, 1 ]$ with $N = 100$ points. The analytical reference solution is taken from an exact Riemann solver (e.g, #cite(<Toro2009a>)). We run both shock tube tests with the _HLLC_ and _ROE_ setups. Figures @fig-shocktube-1 and @fig-shocktube-2 show the density and velocity distributions for the Sod and Lax shock tube tests at $t = 0.2$ and $t = 0.14$, respectively. The _HLLC_ and _ROE_ solutions agree very well with the analytical reference. The _HLLC_ solutions show slightly oscillatory behavior which is due to the cell face reconstruction of the primitive variables, see #cite(<Qiu2002>).

#figure(
  placement: top,
  grid(
    columns: (1fr, 1fr),
    gutter: 4pt,
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$rho$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: 0.08, y-max: 1.05, legend: "inner-north-east", legend-anchor: "north-east", {
        plot.add(d("shocktube_1-002"), style: (stroke: black), label: [Exact])
        plot.add(d("shocktube_1-000"), style: (stroke: c0), label: [HLLC])
        plot.add(d("shocktube_1-001"), style: (stroke: (paint: c1, dash: "dashed")), label: [ROE])
      })
    }))),
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$u$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: -0.05, y-max: 0.98, {
        plot.add(d("shocktube_1-005"), style: (stroke: black))
        plot.add(d("shocktube_1-003"), style: (stroke: c0))
        plot.add(d("shocktube_1-004"), style: (stroke: (paint: c1, dash: "dashed")))
      })
    }))),
  ),
  caption: [Sod shock tube: density $rho$ and velocity $u$ at $t = 0.2$.],
) <fig-shocktube-1>

#figure(
  placement: top,
  grid(
    columns: (1fr, 1fr),
    gutter: 4pt,
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$rho$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: 0.28, y-max: 1.36, legend: "inner-north-west", legend-anchor: "north-west", {
        plot.add(d("shocktube_2-002"), style: (stroke: black), label: [Exact])
        plot.add(d("shocktube_2-000"), style: (stroke: c0), label: [HLLC])
        plot.add(d("shocktube_2-001"), style: (stroke: (paint: c1, dash: "dashed")), label: [ROE])
      })
    }))),
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$u$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: -0.08, y-max: 1.66, {
        plot.add(d("shocktube_2-005"), style: (stroke: black))
        plot.add(d("shocktube_2-003"), style: (stroke: c0))
        plot.add(d("shocktube_2-004"), style: (stroke: (paint: c1, dash: "dashed")))
      })
    }))),
  ),
  caption: [Lax shock tube: density $rho$ and velocity $u$ at $t = 0.14$.],
) <fig-shocktube-2>

=== Lid-driven Cavity
 <subsubsec-Cavity> The lid-driven cavity test case describes the flow in a square cavity that is driven by a moving wall. Viscous forces lead to the generation of one primary vortex and, depending on the Reynolds number, one or more  secondary vortices. We use this test case to validate the implementation of the viscous fluxes.  The computational domain $x times y in [0,1 ]times [0,1 ]$ is discretized with a grid consisting of $500 times 500$ cells.  All boundary conditions are no-slip walls.  The north wall is moving with a constant velocity $u_(W)$, resulting in a Reynolds number $R e = frac(u_(W) L, nu) = 5000$.  The test case is simulated until a steady state is reached with the _HLLC_ setup. @fig-driven-cavity depicts the distribution of $frac(u, u_(W))$ over $y$ and $frac(v, u_(W))$ over $x$ across the domain center.  The present result agrees very well with the reference #cite(<Ghia1982>).

// [figvision-cn] imgs/drivencavity_streamlines_5000.png
// 该图为驱动腔流场的瞬时流线图，属于二维矢量场可视化示意
// 图。图像整体呈正方形，展示了一个封闭方形区域内的流体流
// 动结构。图中由大量彩色曲线构成流线，这些曲线密集且呈同
// 心环状分布，中心区域流线最为紧密，颜色以深紫色和蓝色为
// 主，表明此处绝对速度值最小；向外逐渐过渡为青色、绿色、
// 黄色，直至边缘区域呈现橙红色，表示绝对速度值最大。颜色
// 映射遵循从蓝（低速）到红（高速）的连续色标，对应流线所
// 代表的绝对速度大小。 在四个角落附近，流线形态发生明显
// 弯曲并闭合，形成局部涡旋结构：左上角与右下角各有一个清
// 晰的小型闭合涡胞，其内部流线呈螺旋收缩状，颜色偏紫蓝，
// 说明涡核处流速较低；右上角与左下角则表现为流线被拉伸变
// 形，未形成完整闭合涡，但可见速度梯度变化剧烈，颜色由绿
// 转黄再转橙红，反映边界层内速度急剧增加。 所有流线均为
// 实线，无箭头标注方向，但从整体拓扑可推断主涡为顺时针旋
// 转（因顶部壁面驱动带动流体向右运动）。图中无任何坐标轴、
// 数值刻度或文字标签，仅通过颜色编码传达物理量信息。比例
// 尺缺失，无法定量判断空间尺寸，但根据典型驱动腔问题设定，
// 可假设域为单位正方形[0,1]×[0,1]。 该子图传达的核心结论
// 是：在高雷诺数下，驱动腔内存在一个主导的大尺度顺时针涡，
// 占据绝大部分区域；同时在角落处因粘性效应产生次级小涡，
// 尤其在静止壁面交汇处更显著；速度最大值出现在顶部驱动壁
// 面附近及侧壁中部，最小值位于中心涡核区，符合经典驱动腔
// 流动的对称破缺特征。
#figure(
  placement: top,
  grid(
    columns: (auto, 1fr, 1fr),
    gutter: 4pt,
    align(horizon, image("imgs/drivencavity_streamlines_5000.png", width: 4.6cm)),
    align(horizon, pbox(canvas({
      plot.plot(size: (3.35, 3.7), x-label: [$y$], y-label: [$u \/ u_W$], x-min: -0.05, x-max: 1.05,
        y-min: -0.52, y-max: 1.08, x-tick-step: 0.2, y-tick-step: 0.4,
        legend: "inner-north-west", legend-anchor: "north-west", {
        plot.add(d("cavity5k-000"), style: (stroke: c0), label: [Present])
        plot.add(d("cavity5k-001"), mark: "*", mark-size: 0.18, style: (stroke: none), label: [Reference])
      })
    }))),
    align(horizon, pbox(canvas({
      plot.plot(size: (3.35, 3.7), x-label: [$x$], y-label: [$v \/ u_W$], x-min: -0.05, x-max: 1.05,
        y-min: -0.66, y-max: 0.56, x-tick-step: 0.2, y-tick-step: 0.3, {
        plot.add(d("cavity5k-002"), style: (stroke: c0))
        plot.add(d("cavity5k-003"), mark: "*", mark-size: 0.18, style: (stroke: none))
      })
    }))),
  ),
  caption: [Lid driven cavity at $R e = u_W L \/ nu = 5000$. (Left) Instantaneous streamlines with colors ranging from largest (red) and smallest (blue) value of the absolute velocity. (Middle) Normalized $u$ velocity over $y$ through domain center. (Right) Normalized $v$ velocity over $x$ through domain center. Reference is taken from @Ghia1982.],
) <fig-driven-cavity>

=== Compressible Decaying Isotropic Turbulence
 <subsubsec-HIT> Many flows in nature and engineering applications are turbulent. The direct numerical simulation of turbulent flows requires the resolution of the smallest scales present (the Kolmogorov scales) which is prohibitively expansive #cite(<Pope2000>). In JAX-FLUIDS we have implemented the implicit large eddy simulation (ILES) model _ALDM_ #cite(<Hickel2014b>) which enables us to simulate complex compressible turbulent flows up to very high Reynolds numbers. To validate the implementation of _ALDM_ and the viscous forces, we simulate compressible decaying isotropic turbulence at various turbulent Mach numbers. Specifically, we investigate the performance of the _ALDM_ ILES implementation on the basis of cases 1-3 from Spyropoulos et al. #cite(<Spyropoulos1996>). The turbulent Mach numbers $M_(t) = sqrt(< u^(2) + v^(2) + w^(2)>) slash < c >$ for the three cases are $0.2$, $0.4$, and $0.6$, respectively. The turbulent Reynolds number is $R e_(T) = frac(rho u '^(4), epsilon.alt mu) = 2742$, where $u '$ is the root-mean-square (rms) velocity and $epsilon.alt$ is the dissipation rate of turbulent kinetic energy #cite(<Pope2000>). The spatial domain has extent $x times y times z in [ 0, 2 pi ] times [ 0, 2 pi ] times [ 0, 2 pi ]$. We use the DNS data from #cite(<Spyropoulos1996>) and an _HLLC_ simulation with a resolution of $128^(3)$ cells as reference. The LES simulations are performed on a coarse grid with $32^(3)$ cells. We use _ALDM_ and _HLLC_ on this resolution to conduct LES simulations. The initial velocity field is divergence free and has the energy spectrum
$ E(k) = A k^(4) exp (- 2 k^(2) slash k_(0)^(2)), $

where $k$ is the wave number, $k_(0)$ is the wave number at which the spectrum is maximal, and $A$ is a constant chosen to adjust a specified initial kinetic energy. The initial density and temperature fields are uniform. @fig-densityrmsdecay shows the temporal evolution of the rms density fluctuations $rho_(r m s) = sqrt(< rho ' rho '>)$. We normalize the time axis with the initial eddy turnover time $tau = lambda_(f) slash u ' approx 0.85$. $lambda_(f)$ is the lateral Taylor microscale #cite(<Pope2000>). The _HLLC_ simulation at $128^(3)$ recovers the DNS reference very well. On the coarse mesh, the performance of the _ALDM_ ILES becomes obvious when compared to _HLLC_ simulations at the same resolution. _ALDM_ gives good results consistent with the DNS data, indicating that _ALDM_ recovers the correct sub-grid scale terms for compressible isotropic turbulence.

#figure(
  placement: top,
  align(center, canvas({
    import "@preview/cetz:0.4.0": draw
    plot.plot(size: (11, 5.4), x-label: [$t slash tau$], y-label: [$rho_"rms"$],
      x-min: 0, x-max: 5, y-min: 0, y-max: 0.16, legend: "inner-north-east", legend-anchor: "north-east", name: "p", {
      plot.add(d("density_rms_decay-000"), style: (stroke: c0))
      plot.add(d("density_rms_decay-001"), style: (stroke: c0))
      plot.add(d("density_rms_decay-002"), style: (stroke: c0), label: [HLLC 128])
      plot.add(d("density_rms_decay-003"), style: (stroke: c1))
      plot.add(d("density_rms_decay-004"), style: (stroke: c1))
      plot.add(d("density_rms_decay-005"), style: (stroke: c1), label: [ALDM 32])
      plot.add(d("density_rms_decay-006"), style: (stroke: c2))
      plot.add(d("density_rms_decay-007"), style: (stroke: c2))
      plot.add(d("density_rms_decay-008"), style: (stroke: c2), label: [HLLC 32])
      plot.add(d("density_rms_decay-009"), mark: "o", mark-size: 0.16, style: (stroke: none), label: [DNS])
      plot.add(d("density_rms_decay-010"), mark: "o", mark-size: 0.16, style: (stroke: none))
      plot.add(d("density_rms_decay-011"), mark: "o", mark-size: 0.16, style: (stroke: none))
      plot.add-anchor("c1", (0.35, 0.028))
      plot.add-anchor("c2", (0.35, 0.057))
      plot.add-anchor("c3", (5.0, 0.083))
    })
    draw.content(("p.c1"), text(8pt)[Case 1], anchor: "south-west")
    draw.content(("p.c2"), text(8pt)[Case 2], anchor: "south-west")
    draw.content(("p.c3"), text(8pt)[Case 3], anchor: "south-east")
  })),
  caption: [Temporal evolution of the rms density fluctuations for decaying isotropic turbulence. The time axis is normalized with the initial eddy turnover time. The DNS results are cases 1-3 from Spyropoulos et al. @Spyropoulos1996.],
) <fig-densityrmsdecay>

== Two-phase Simulations
 <subsec-Twophase>

=== Two-phase Sod Shock Tube
 <subsubsec-TwophaseSod> We consider a two-phase variant of the Sod shock tube problem #cite(<Sod1978a>). This test case validates the inviscid fluid-fluid interface interactions. In particular, we investigate an air-helium shock tube problem  in which the materials left and right of the initial discontinuity are air ($gamma_(#text[air]) = 1.4$)  and helium ($gamma_(#text[helium]) = 1.667$), respectively. We use the previously described _HLLC_ setup. The domain $x in [0, 1 ]$ is resolved with 200 cells. @fig-twophaseshocktube shows the results at $t = 0.15$. The numerical approximations are in good agreement with the analytical solution. The interface position and shock speed and shock strength are captured correctly. We observe slight density oscillations around the interface. This is in agreement with previous literature #cite(<Hu2006>) as no isobaric fix is employed.

#figure(
  placement: top,
  grid(
    columns: (1fr, 1fr),
    gutter: 4pt,
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$rho$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: 0.08, y-max: 1.05, legend: "inner-north-east", legend-anchor: "north-east", {
        plot.add(d("twophase_shocktube-000"), style: (stroke: black), label: [Exact])
        plot.add(d("twophase_shocktube-001"), style: (stroke: c0), label: [HLLC])
      })
    }))),
    align(center, pbox(canvas({
      plot.plot(size: (5.8, 4.0), x-label: [$x$], y-label: [$u$], x-min: 0, x-max: 1, x-tick-step: 0.2,
        y-min: -0.05, y-max: 0.96, {
        plot.add(d("twophase_shocktube-002"), style: (stroke: black))
        plot.add(d("twophase_shocktube-003"), style: (stroke: c0))
      })
    }))),
  ),
  caption: [Air-helium shock tube problem. Density $rho$ and velocity $u$ at $t = 0.15$.],
) <fig-twophaseshocktube>

=== Bow Shock
 <subsubsec-Bowshock> Bow shocks occur in supersonic flows around blunt bodies #cite(<PEERY1988>). Here, we simulate the flow around a stationary cylinder at high  Mach numbers $M a = frac(sqrt(upright(bold(u)) dot upright(bold(u))), sqrt(gamma p ∕ rho))= {3,20 }$.  This test case validates the implementation of the inviscid fluid-solid interface fluxes. The computational domain $x times y in [- 0.3,0.0 ]times [- 0.4,0.4 ]$ is discretized with a grid consisting  of $480 times 1280$ cells.  A cylinder with diameter $0.2$ is placed at the center of the east boundary. The north, east, and south boundaries are zero-gradient.  The west boundary is of Dirichlet type, imposing the post shock fluid state. The fluid is initialized with the post shock state, i.e., $(rho,u,v,p)= (1,sqrt(1.4) M a,0,1)$. We simulate the test case with the _HLLC_ setup until a steady state solution is reached. @fig-bowshock illustrates the steady state density and pressure distributions. The results compare well to results from  literature, e.g., #cite(<Fleischmann2020>).

// [figvision-cn] imgs/bowshock_density_20.png
// 该图展示了一个弓形激波（bow shock）在物体周围的密度与
// 压力分布的二维截面示意图，图像呈竖直长方形布局。 右侧
// 为一个白色圆形区域，代表产生激波的障碍物或天体本体，其
// 边缘清晰、无纹理填充，占据画面右半部分约三分之一宽度。
// 左侧及环绕白色圆体外围的区域为彩色渐变背景，表示物理量
// （密度或压力）的空间分布：颜色从深蓝色（最小值）过渡到
// 红色（最大值），形成明显的色带结构。 具体而言，紧邻白
// 色圆体表面的环形区域呈现高强度红色，表明此处物理量达到
// 峰值；向外逐渐过渡为橙色、黄色、浅蓝，最终在远离物体的
// 左部广阔区域变为均匀深蓝色，代表低值区。这种径向递减的
// 色彩分布暗示物理量随距中心距离增加而衰减。 叠加在彩色
// 背景上的是一系列黑色等值线，标注为马赫数（Mach number）
// 等高线，数值范围从0.1至2.5，步长0.2。这些线条大致平行
// 于白色圆体轮廓，但在激波前沿（即红蓝交界处附近）发生弯
// 曲和密集化，尤其在上下对称位置出现局部扭曲，反映流场中
// 速度场的变化特征。其中一条标有“2”的等值线位于红色核心
// 区外侧，另一条标有“1”的线更靠外，其余未标注数字但按规
// 律排列。 整幅图无坐标轴刻度或单位标注，亦无比例尺，属
// 于定性可视化图。根据图注说明，此图为密度或压力场的一种
// 表现形式（左右分别对应不同物理量，但本图仅显示一种状态）。
// 颜色映射明确定义为：蓝色=最小值，红色=最大值；对于特定
// 参数组合（如γ=1.4, M∞=3.0等，虽未在图中明示，但属常规
// 设定），该分布符合超音速流动下弓形激波的典型结构——即激
// 波层内高压高温高密度区紧贴物面，外部自由流区则保持低温
// 低压低密状态。 趋势结论：图像直观揭示了超音速气流绕过
// 钝头体时形成的弓形激波结构，激波后区域（红色环带）存在
// 显著的压力/密度跃升，且马赫数沿流线方向逐步降低（由外
// 向内等值线数值增大），符合气体动力学基本规律。
// [figvision-cn] imgs/bowshock_density_3.png
// 该图为弓形激波区域的密度与压力分布示意图，呈现为二维彩
// 色映射图叠加黑色等值线。图像整体呈竖直矩形布局，右侧边
// 缘为白色半圆形物体（代表天体或障碍物），其左侧及上方区
// 域展示流体动力学场结构。 颜色映射范围从最小值（蓝色）
// 到最大值（红色）。根据图注说明：密度场的数值范围为 0.1
// 至 1.0（单位未明示，但应为归一化或无量纲密度）；压力场
// 的数值范围为 0.2 至 2.0（同样为归一化或无量纲压力）。
// 图中实际显示的是两个物理量之一（因图注提及“density and
// pressure”，但未明确本图是哪一个——结合常见做法和视觉特
// 征，此图更可能为压力分布，因为激波后高压区通常对应红色
// 且紧邻激波面）。 空间坐标轴未在图中直接标注刻度，但从
// 几何形态可推断：横轴方向大致对应径向距离（从中心物体向
// 外），纵轴对应垂直于来流方向的横向位置。整个计算域覆盖
// 约数个半径长度（R）的范围，其中激波前沿位于距中心物体
// 表面约 1–2 R 处。 图中所有黑色实线为马赫数等值线（Mach
// isocontours），取值从 0.1 到 2.5，步长为 0.2。这些等值
// 线密集分布在激波附近（即红蓝过渡带），表明此处速度梯度
// 大、流动剧烈变化；远离激波区域（深蓝色背景）等值线稀疏
// 甚至缺失，表示马赫数接近零或恒定低速状态。在靠近白色半
// 圆物体的上游侧（左下方），可见多条不规则弯曲的黑色细线，
// 可能是局部湍流或数值扰动引起的马赫数微小波动。 颜色分
// 布趋势如下： 最外侧大面积区域为深蓝色，代表最低值（密
// 度≈0.1 或压力≈0.2）； 向内过渡为浅蓝→粉红→鲜红，形成一
// 道明显的弧形高值带，即弓形激波位置； 激波内侧（靠近白
// 色物体）再次出现蓝色区域，尤其在顶部和底部角落，表示激
// 波后存在低压/低密区（可能为尾迹或膨胀区）； 中央偏下区
// 域有一片较宽的红色核心区，紧贴白色物体前缘，表明此处压
// 力或密度达到峰值（≈1.0 或 2.0）。 结论：该图清晰展示了
// 超音速流绕过钝头体时形成的典型弓形激波结构。激波前后物
// 理量发生突变，激波层内马赫数由 supersonic (>1) 降至
// subsonic (<1)，并通过等值线间距反映压缩强度。红色区域
// 标识高压/高密度区，集中于激波面及驻点附近；蓝色区域则
// 为未受扰动的自由流或激波后的膨胀区。整体结构对称性良好，
// 符合轴对称假设下的理论预期。
// [figvision-cn] imgs/bowshock_pressure_20.png
// 该图为一张二维平面彩色填充图，展示了弓形激波区域的密度
// 与压力分布。图像整体呈竖直长方形布局。背景为深蓝色，代
// 表数值最小区域。在图像右侧边缘，有一个白色的半圆形物体，
// 其圆心位于图像右边界的中点附近，占据了右半部分约三分之
// 一的宽度。紧挨着白色半圆物体的左侧，存在一个明显的弧形
// 过渡带，颜色从靠近白色物体的红色逐渐向外侧的蓝色渐变。
// 红色区域代表数值最大，主要集中在白色半圆物体正左方及上
// 下两侧紧邻的区域。随着距离白色物体越远，颜色迅速变为浅
// 蓝并最终融入背景的深蓝色。在整个彩色背景上叠加了多条黑
// 色的细实线，这些是马赫数（Mach number）等值线。这些黑
// 线沿着弧形过渡带的形状分布，彼此大致平行且不相交。根据
// 图注描述，黑色线条代表的马赫数范围从0.1到2.5，步长为
// 0.2。图中没有显示坐标轴、刻度或具体的数值标签，仅通过
// 颜色的深浅和等值线的疏密来传达物理量的空间分布趋势：即
// 在白色物体前方形成了一个高压高密度的激波层，随后向周围
// 空间扩散衰减。
// [figvision-cn] imgs/bowshock_pressure_20.png
// 该图为一张二维平面彩色填充图，展示了弓形激波区域的密度
// 与压力分布。图像整体呈竖直长方形布局。背景为深蓝色，代
// 表数值最小区域。在图像右侧边缘，有一个白色的半圆形物体，
// 其圆心位于图像右边界的中点附近，占据了右半部分约三分之
// 一的宽度。紧挨着白色半圆物体的左侧，存在一个明显的弧形
// 过渡带，颜色从靠近白色物体的红色逐渐向外侧的蓝色渐变。
// 红色区域代表数值最大，主要集中在白色半圆物体正左方及上
// 下两侧紧邻的区域。随着距离白色物体越远，颜色迅速变为浅
// 蓝并最终融入背景的深蓝色。在整个彩色背景上叠加了多条黑
// 色的细实线，这些是马赫数（Mach number）等值线。这些黑
// 线沿着弧形过渡带的形状分布，彼此大致平行且不相交。根据
// 图注描述，黑色线条代表的马赫数范围从0.1到2.5，步长为
// 0.2。图中没有显示坐标轴、刻度或具体的数值标签，仅通过
// 颜色的深浅和等值线的疏密来传达物理量的空间分布趋势：即
// 在白色物体前方形成了一个高压高密度的激波层，随后向周围
// 空间扩散衰减。
#figure(
  placement: top,
  align(center, grid(
    columns: 4,
    gutter: 3pt,
    grid.cell(colspan: 2, align(center, [#text(10pt)[$M a = 3$]])),
    grid.cell(colspan: 2, align(center, [#text(10pt)[$M a = 20$]])),
    image("imgs/bowshock_density_3.png", width: 3.9cm),
    image("imgs/bowshock_pressure_3.png", width: 3.9cm),
    image("imgs/bowshock_density_20.png", width: 3.9cm),
    image("imgs/bowshock_pressure_20.png", width: 3.9cm),
  )),
  caption: [Density and pressure for the bow shock at $M a = 3$ (left) and $M a = 20$ (right). The colormap ranges from minimum (blue) to maximum (red) value; $rho in [0.7, 4.5]$ and $p in [1.0, 15.0]$ for $M a = 3$ and $rho in [0.7, 7.2]$ and $p in [1.0, 550.0]$ for $M a = 20$. The black lines represent Mach isocontours from 0.1 to 2.5 in steps of 0.2.],
) <fig-bowshock>

=== Oscillating Drop
// [figvision-cn] imgs/bowshock_density_20.png
// 该图展示了一个弓形激波（bow shock）在物体周围的密度与
// 压力分布的二维截面示意图，图像呈竖直长方形布局。 右侧
// 为一个白色圆形区域，代表产生激波的障碍物或天体本体，其
// 边缘清晰、无纹理填充，占据画面右半部分约三分之一宽度。
// 左侧及环绕白色圆体外围的区域为彩色渐变背景，表示物理量
// （密度或压力）的空间分布：颜色从深蓝色（最小值）过渡到
// 红色（最大值），形成明显的色带结构。 具体而言，紧邻白
// 色圆体表面的环形区域呈现高强度红色，表明此处物理量达到
// 峰值；向外逐渐过渡为橙色、黄色、浅蓝，最终在远离物体的
// 左部广阔区域变为均匀深蓝色，代表低值区。这种径向递减的
// 色彩分布暗示物理量随距中心距离增加而衰减。 叠加在彩色
// 背景上的是一系列黑色等值线，标注为马赫数（Mach number）
// 等高线，数值范围从0.1至2.5，步长0.2。这些线条大致平行
// 于白色圆体轮廓，但在激波前沿（即红蓝交界处附近）发生弯
// 曲和密集化，尤其在上下对称位置出现局部扭曲，反映流场中
// 速度场的变化特征。其中一条标有“2”的等值线位于红色核心
// 区外侧，另一条标有“1”的线更靠外，其余未标注数字但按规
// 律排列。 整幅图无坐标轴刻度或单位标注，亦无比例尺，属
// 于定性可视化图。根据图注说明，此图为密度或压力场的一种
// 表现形式（左右分别对应不同物理量，但本图仅显示一种状态）。
// 颜色映射明确定义为：蓝色=最小值，红色=最大值；对于特定
// 参数组合（如γ=1.4, M∞=3.0等，虽未在图中明示，但属常规
// 设定），该分布符合超音速流动下弓形激波的典型结构——即激
// 波层内高压高温高密度区紧贴物面，外部自由流区则保持低温
// 低压低密状态。 趋势结论：图像直观揭示了超音速气流绕过
// 钝头体时形成的弓形激波结构，激波后区域（红色环带）存在
// 显著的压力/密度跃升，且马赫数沿流线方向逐步降低（由外
// 向内等值线数值增大），符合气体动力学基本规律。
// [figvision-cn] imgs/bowshock_density_3.png
// 该图为弓形激波区域的密度与压力分布示意图，呈现为二维彩
// 色映射图叠加黑色等值线。图像整体呈竖直矩形布局，右侧边
// 缘为白色半圆形物体（代表天体或障碍物），其左侧及上方区
// 域展示流体动力学场结构。 颜色映射范围从最小值（蓝色）
// 到最大值（红色）。根据图注说明：密度场的数值范围为 0.1
// 至 1.0（单位未明示，但应为归一化或无量纲密度）；压力场
// 的数值范围为 0.2 至 2.0（同样为归一化或无量纲压力）。
// 图中实际显示的是两个物理量之一（因图注提及“density and
// pressure”，但未明确本图是哪一个——结合常见做法和视觉特
// 征，此图更可能为压力分布，因为激波后高压区通常对应红色
// 且紧邻激波面）。 空间坐标轴未在图中直接标注刻度，但从
// 几何形态可推断：横轴方向大致对应径向距离（从中心物体向
// 外），纵轴对应垂直于来流方向的横向位置。整个计算域覆盖
// 约数个半径长度（R）的范围，其中激波前沿位于距中心物体
// 表面约 1–2 R 处。 图中所有黑色实线为马赫数等值线（Mach
// isocontours），取值从 0.1 到 2.5，步长为 0.2。这些等值
// 线密集分布在激波附近（即红蓝过渡带），表明此处速度梯度
// 大、流动剧烈变化；远离激波区域（深蓝色背景）等值线稀疏
// 甚至缺失，表示马赫数接近零或恒定低速状态。在靠近白色半
// 圆物体的上游侧（左下方），可见多条不规则弯曲的黑色细线，
// 可能是局部湍流或数值扰动引起的马赫数微小波动。 颜色分
// 布趋势如下： 最外侧大面积区域为深蓝色，代表最低值（密
// 度≈0.1 或压力≈0.2）； 向内过渡为浅蓝→粉红→鲜红，形成一
// 道明显的弧形高值带，即弓形激波位置； 激波内侧（靠近白
// 色物体）再次出现蓝色区域，尤其在顶部和底部角落，表示激
// 波后存在低压/低密区（可能为尾迹或膨胀区）； 中央偏下区
// 域有一片较宽的红色核心区，紧贴白色物体前缘，表明此处压
// 力或密度达到峰值（≈1.0 或 2.0）。 结论：该图清晰展示了
// 超音速流绕过钝头体时形成的典型弓形激波结构。激波前后物
// 理量发生突变，激波层内马赫数由 supersonic (>1) 降至
// subsonic (<1)，并通过等值线间距反映压缩强度。红色区域
// 标识高压/高密度区，集中于激波面及驻点附近；蓝色区域则
// 为未受扰动的自由流或激波后的膨胀区。整体结构对称性良好，
// 符合轴对称假设下的理论预期。
 <subsubsec-OscillatingDrop> We consider a drop oscillating due to the interplay of surface tension and inertia. Starting from an ellipsoidal shape, surface tension forces drive the drop to a circular shape.  This process is associated with a transfer of potential to kinetic energy.  The oscillating drop test case validates the implementation of the surface tension forces.  The drop oscillates with a distinct frequency.  The oscillation period $T$ is given by #cite(<Rayleigh1879>) $ omega^(2) = frac(6 sigma, (rho_(b)+ rho_(d))R^(3)), wide T = frac(2 pi, omega). $
 We discretize the computational domain $x times y in [0,1 ]times [0,1 ]$ with a grid consisting of $200 times 200$ cells. We place an ellipse with semi-major and semi-minor axes of $0.2$ and $0.15$ at the center of the domain.  The effective circle radius is therefore $R = 0.17321$.  The bulk and drop densities are $rho_(b)= rho_(d)= 1.0$ and the surface tension coefficient is $sigma = 0.05$.  All boundaries are zero-gradient.  We use the _HLLC_ setup for this simulation.  @fig-oscillatingdrop displays instantaneous pressure fields and the kinetic energy of the drop over time. The present result for the oscillation period is $T = 1.16336$, which is in very good agreement with the analytical reference $T_(r e f) = 1.16943$.
// [figvision-cn] imgs/pressure_0.png
// 该图展示了一个振荡液滴内部压力分布的二维可视化结果。图
// 像主体为一个水平放置的椭圆形区域，代表液滴的横截面，边
// 缘由粗黑实线勾勒。椭圆内部填充了像素化的颜色场，用于表
// 示压力数值的空间分布。颜色映射方案中，深红色代表该时间
// 段内的最大压力值，深蓝色代表最小压力值，白色则代表中间
// 过渡的压力值。从空间布局上看，椭圆的左右两端呈现大面积
// 的深红色高区，表明液滴两侧压力最高；椭圆的上下两端呈现
// 深蓝色低区，表明液滴顶部和底部压力最低；在椭圆的几何中
// 心附近，颜色为白色或浅紫色，显示此处压力介于极值之间。
// 整体压力分布呈现出关于水平和垂直中心轴对称的特征，形成
// 类似沙漏状的图案，即两侧高压、上下低压、中心中等压力的
// 结构。
// [figvision-cn] imgs/pressure_1.png
// 该图展示了一个振荡液滴在某一特定时刻的物理状态，由左侧
// 的压力分布云图和右侧的动能曲线图两部分组成。 左侧子图
// 为一个二维压力分布示意图（伪彩云图）。图像主体为一个被
// 粗黑实线圆环包围的圆形区域，代表液滴的横截面。圆环内部
// 填充了表示压力数值的颜色场。颜色分布呈现出中心对称的特
// 征：液滴正中心区域为深红色，表示该处压力达到最大值；从
// 中心向外辐射，颜色逐渐过渡为浅粉色、白色，并在靠近边缘
// 的区域变为浅蓝色至深蓝色，表示压力值向最小值递减。这种
// 红-白-蓝的颜色梯度直观地展示了液滴内部压力由中心向表面
// 降低的空间分布规律。图中未显示具体的数值比例尺条，但根
// 据说明，红色对应所示时间段内的最大压力值，蓝色对应最小
// 压力值。 右侧子图为一条二维曲线图，描述液滴动能随时间
// 的变化。纵坐标轴表示动能（Kinetic Energy），单位未在图
// 中明确标出，通常为非归一化或归一化的能量单位；横坐标轴
// 表示时间（Time），单位为无量纲时间或秒。图中绘制了一条
// 连续的黑色曲线，呈现周期性振荡形态，表明液滴的动能随时
// 间发生往复变化，具有明显的波峰和波谷。在曲线上叠加了若
// 干个橙色实心圆点，这些标记点对应左侧压力云图所展示的具
// 体时刻。通过观察橙色点在曲线上的位置，可以判断当前左侧
// 云图对应的物理状态处于动能变化的哪个阶段（例如，若橙色
// 点位于波峰附近，则对应动能最大时刻，此时液滴形变可能最
// 大或速度最快）。整体趋势表明液滴处于稳定的振荡模式，动
// 能与压力分布之间存在动态耦合关系。
// [figvision-cn] imgs/pressure_2.png
// 该图像为一张科学论文插图，展示了一个振荡液滴内部压力分
// 布的二维可视化结果。图像主体为一个垂直方向拉长的椭圆形
// 区域，代表液滴的横截面轮廓，其边界由一条粗黑实线勾勒。
// 在椭圆内部，颜色根据压力值进行映射：红色区域表示该时间
// 段内的最高压力，蓝色区域表示最低压力，白色或浅色过渡区
// 域表示中间压力值。具体分布上，椭圆的顶部和底部各有一块
// 明显的红色高亮区域，呈弧形带状，表明这两个位置（可能是
// 液滴的极区）承受着最大的压力。这两块红色区域向中心延伸
// 并逐渐变淡，过渡到白色，再进入占据图像中部大部分面积的
// 深蓝色区域。蓝色区域主要分布在椭圆的左右两侧及水平中轴
// 线附近，表明这些区域的压力较低。整体图案呈现出上下对称、
// 左右对称的结构，反映了液滴在特定振荡模式下的压力场特征。
// 图中未显示坐标轴、比例尺或图例色条，所有信息均通过颜色
// 空间分布传达。
// [figvision-cn] imgs/pressure_3.png
// 该图展示了一个振荡液滴在特定时刻的瞬时状态，由左右两个
// 部分构成。 左侧子图为一个二维彩色示意图（或伪彩分布图），
// 展示了液滴内部的压力分布。 图形主体：一个具有粗黑实线
// 边界的圆形区域，代表液滴的截面。 颜色映射与物理含义：
// 圆内填充了连续变化的渐变色，用于表示压力的大小。根据图
// 注说明，红色区域代表在该时间段内的最大压力值，蓝色区域
// 代表最小压力值。 空间分布细节：在圆形的中心区域，呈现
// 出大面积的粉红色至淡红色，表明此处为高压区。从中心向边
// 缘过渡，颜色逐渐变为白色，进而转变为浅紫色和深蓝色。深
// 蓝色的低压力区域主要分布在靠近黑色边界的边缘地带，并呈
// 现出某种对称的瓣状结构（类似于四叶草形状的边缘凹陷处）。
// 结论：该图直观地显示了液滴内部压力并非均匀分布，而是中
// 心高、边缘低，且边缘存在特定的波动模式。 右侧子图为一
// 条曲线图，展示了液滴动能随时间的变化。 坐标轴定义：横
// 轴表示时间（Time），纵轴表示液滴的动能（Kinetic Energy）。
// 具体的数值范围和单位未在提供的图像片段中显示，但通常横
// 轴单位为秒（s）或无量纲时间，纵轴单位为焦耳（J）或归一
// 化能量。 曲线特征：图中包含一条连续的折线或曲线，描绘
// 了动能随时间波动的轨迹。曲线呈现出周期性的起伏，反映了
// 液滴振荡过程中动能的周期性转换。 特殊标注：曲线上标记
// 有若干个橙色的实心圆点。 关联说明：这些橙色圆点在时间
// 轴上的位置，精确对应于左侧压力分布图所展示的那个特定时
// 刻（即左侧图是右侧图中某个橙色点对应的瞬间快照）。 趋
// 势结论：动能随时间发生振荡，表明液滴处于非平衡的动态运
// 动状态。
// [figvision-cn] imgs/pressure_0.png
// 该图展示了一个振荡液滴内部压力分布的二维可视化结果。图
// 像主体为一个水平放置的椭圆形区域，代表液滴的横截面，边
// 缘由粗黑实线勾勒。椭圆内部填充了像素化的颜色场，用于表
// 示压力数值的空间分布。颜色映射方案中，深红色代表该时间
// 段内的最大压力值，深蓝色代表最小压力值，白色则代表中间
// 过渡的压力值。从空间布局上看，椭圆的左右两端呈现大面积
// 的深红色高区，表明液滴两侧压力最高；椭圆的上下两端呈现
// 深蓝色低区，表明液滴顶部和底部压力最低；在椭圆的几何中
// 心附近，颜色为白色或浅紫色，显示此处压力介于极值之间。
// 整体压力分布呈现出关于水平和垂直中心轴对称的特征，形成
// 类似沙漏状的图案，即两侧高压、上下低压、中心中等压力的
// 结构。
// 连续的黑色曲线，呈现周期性振荡形态，表明液滴的动能随时
// 间发生往复变化，具有明显的波峰和波谷。在曲线上叠加了若
// 干个橙色实心圆点，这些标记点对应左侧压力云图所展示的具
// 体时刻。通过观察橙色点在曲线上的位置，可以判断当前左侧
// 云图对应的物理状态处于动能变化的哪个阶段（例如，若橙色
// 点位于波峰附近，则对应动能最大时刻，此时液滴形变可能最
// 大或速度最快）。整体趋势表明液滴处于稳定的振荡模式，动
// 能与压力分布之间存在动态耦合关系。
// 轴单位为秒（s）或无量纲时间，纵轴单位为焦耳（J）或归一
// 化能量。 曲线特征：图中包含一条连续的折线或曲线，描绘
// 了动能随时间波动的轨迹。曲线呈现出周期性的起伏，反映了
// 液滴振荡过程中动能的周期性转换。 特殊标注：曲线上标记
// 有若干个橙色的实心圆点。 关联说明：这些橙色圆点在时间
// 轴上的位置，精确对应于左侧压力分布图所展示的那个特定时
// 刻（即左侧图是右侧图中某个橙色点对应的瞬间快照）。 趋
// 势结论：动能随时间发生振荡，表明液滴处于非平衡的动态运
// 动状态。
#figure(
  placement: top,
  align(center, grid(
    columns: (auto, auto), gutter: 10pt,
    align(horizon, [
      #grid(columns: (1.5cm,) * 5, column-gutter: 1pt,
        image("imgs/pressure_0.png", width: 1.5cm),
        image("imgs/pressure_1.png", width: 1.5cm),
        image("imgs/pressure_2.png", width: 1.5cm),
        image("imgs/pressure_3.png", width: 1.5cm),
        image("imgs/pressure_4.png", width: 1.5cm),
      )
      #v(-0.2em)
      #align(right)[#text(9pt)[increasing time $arrow.r$]]
    ]),
    align(horizon, pbox(canvas({
      plot.plot(size: (4.3, 3.9), x-label: [$t$], y-label: [$E_("kin")$], x-min: -0.1, x-max: 2.1,
        y-min: -0.001, y-max: 0.0098, x-tick-step: 0.4, y-tick-step: 0.002, y-decimals: 3,
        legend: "inner-north-east", legend-anchor: "north-east", {
        plot.add(d("energy-001"), style: (stroke: c0), label: [Kinetic energy])
        plot.add(d("energy-000"), mark: "o", mark-size: 0.2, style: (stroke: none), label: [Snapshots])
      })
    }))),
  )),
  caption: [Oscillating drop. (Left) Temporal evolution of the pressure distribution within the drop. The colors range from maximum (red) to minimum (blue) value within the shown time period. (Right) Kinetic energy $E_("kin") = integral_V rho upright(bold(u)) dot upright(bold(u)) dif V$ of the drop over time. The orange dots indicate the times that correspond to the pressure distributions on the left.],
) <fig-oscillatingdrop>

=== Shear Drop Deformation
 The shear drop deformation test case describes the deformation of an initially circular shaped drop due to homogenous shear.  Viscous forces lead to the deformation to an ellipsoidal shape. For stable parameters, surface tension forces will eventually balance the viscous forces, which results in a steady state solution. The shear flow is generated with moving no-slip wall boundaries.  We use this test case to validate the viscous fluid-fluid interface fluxes. The steady state solution is characterized by the viscosity ratio $mu_(b) slash mu_(d)$ and the capillary number $C a$ $ C a = frac(mu_(b) R dot(s), sigma), $
 where $R$ denotes the initial drop radius, $sigma$ the surface tension coefficient, $dot(s)$ the shear rate, and  $mu_(b)$ and $mu_(d)$ the viscosities of the drop and bulk fluid, respectively.  The following relation holds for small deformations #cite(<TaylorG.1934>). $ wide D = frac(B_(1) - B_(2), B_(1) + B_(2)) = C a frac(19 mu_(b) slash mu_(d)+ 16, 16 mu_(b) slash mu_(d)+ 16) $
 Herein, $B_(1)$ and $B_(2)$ indicate the semi-major and semi-minor axes of the steady state ellipse.  To simulate this test case, we discretize the domain $x times y in [0,1 ]times [0,1 ]$ with a grid that consists of $250 times 250$ cells.  A drop with radius $R = 0.2$ is placed at the center of the domain.  We move the north and south wall boundaries with an absolute velocity of $u_(W) = 0.1$ in positive and negative direction, respectively.  This results in a shear rate of $0.2$. At the east and west boundaries we enforce periodicity.  The viscosities are $mu_(b)= mu_(d)= 0.1$. We simulate multiple capillary numbers by varying the surface tension coefficient with the _HLLC_ setup until a steady state solution is reached. <subsubsec-ShearDrop>
// [figvision-cn] imgs/sheardrop_pressure_1.png
// 该图像为单幅彩色示意图，展示剪切流场中液滴的稳态变形与
// 压力分布。图中无坐标轴、比例尺或文字标注，属于定性可视
// 化图。 中心主体为一个红色椭圆形物体，代表变形后的液滴，
// 其长轴沿左下至右上方向倾斜约45度（相对于水平线）。椭圆
// 边界由粗黑实线勾勒，内部填充从中心向边缘渐变的红色：中
// 心区域为亮红色（近似RGB(255,0,0)），向外逐渐过渡到暗红
// 并最终融入背景蓝色，暗示压力在液滴内部较高且呈对称分布。
// 背景为纯深蓝色（近似RGB(0,0,200)），覆盖整个画布，象征
// 外部流体介质。在红色椭圆周围存在一圈模糊的浅蓝色光晕，
// 宽度约为椭圆短轴的1/3，颜色从紧贴边界的淡蓝（近似RGB(
// 100,100,255)）平滑过渡到背景深蓝，表示压力梯度或速度扰
// 动区。 整体布局居中对称，无其他图形元素。该图传达的核
// 心物理信息是：在稳态剪切作用下，液滴发生拉伸变形形成椭
// 球状，其内部压力高于外部环境，并在界面附近产生连续的压
// 力衰减场；红色区域对应高压核心，蓝色背景对应低压环境，
// 光晕反映界面处的应力集中或粘性耗散效应。
#figure(
  placement: top,
  align(center, grid(
    columns: (auto, auto), gutter: 10pt,
    align(horizon, canvas({
      import "@preview/cetz:0.4.0": draw
      draw.content((0, 0), image("imgs/sheardrop_pressure_1.png", width: 4.6cm))
      draw.line((-2.4, 2.5), (2.4, 2.5), mark: (end: ">"), stroke: 0.6pt)
      draw.content((0, 2.8), [$u_W$])
      draw.line((-2.4, -2.5), (2.4, -2.5), mark: (start: ">"), stroke: 0.6pt)
      draw.content((0, -2.8), [$u_W$])
      draw.line((-2.6, -3.2), (-1.5, -3.2), mark: (end: ">"), stroke: 0.6pt)
      draw.content((-1.9, -3.55), [$x$])
      draw.line((-2.6, -3.2), (-2.6, -2.1), mark: (end: ">"), stroke: 0.6pt)
      draw.content((-3.0, -2.6), [$y$])
    })),
    align(horizon, canvas({
      plot.plot(size: (5.6, 4.6), x-label: [$C a$], y-label: [$D$], x-min: 0.006, x-max: 0.42, x-tick-step: 0.1,
        y-min: 0.006, y-max: 0.46, y-tick-step: 0.1, legend: "inner-south-east", legend-anchor: "south-east", {
        plot.add(d("sheardrop-000"), mark: "o", mark-size: 0.16, style: (stroke: none), label: [Reference])
        plot.add(d("sheardrop-001"), style: (stroke: black), label: [Present])
      })
    })),
  )),
  caption: [Shear drop deformation. (Left) Steady state pressure field for $C a = 0.2$. (Right) Deformation parameter $D$ over $C a$.],
) <fig-sheardrop>
 @fig-sheardrop illustrates the pressure distribution of the steady state ellipse at $C a = 0.2$. Furthermore, it shows the deformation parameter $D$ over the capillary number $C a$. The present result agrees well with the analytical reference.

=== Shock-bubble Interaction
 <subsubsec-ShockBubble>

 We simulate the interaction of a shock with Mach number 1.22 with a helium bubble immersed in air. This is an established test case to assess the robustness and validity of compressible two-phase numerical methods. Reports are well documented in literature #cite(<Fedkiw1999a>) #cite(<Terashima2009>) #cite(<Hoppe2022a>) and experimental data are available #cite(<Haas1987>).

 A helium bubble with diameter $D = 50 thin #text[mm]$ is placed at the origin of the computational domain  $x times y in [- 90 thin #text[mm], 266 thin #text[mm] ] times [- 44.5 thin #text[mm], 44.5 thin #text[mm] ]$. The initial shock wave is located $5 thin #text[mm]$ to the left of the helium bubble. The shock wave travels right and impacts with the helium bubble. @fig-shockbubbleflowfield shows the flow field at two later time instances. The interaction of the initial shock with the helium bubble generates a reflected shock which is travelling to the left and a second shock which is transmitted through the bubble, see @fig-shockbubbleflowfield on the left. The incident shock wave is visible as a vertical line. The transmitted wave travels faster than the incident shock. The helium bubbles deforms strongly and a re-entrant jet forms. @fig-shockbubbleflowfield on the right shows the instance in time at which the jet impinges on the interface of the bubble.

 The numerical schlieren images and the flow fields in @fig-shockbubbleflowfield are in good qualitative agreement with results from literature, compare with Figure 7 from #cite(<Haas1987>) or Figure 10 from #cite(<Hoppe2022a>). @fig-shockbubblespacetime shows the temporal evolution of characteristic interface points. The results are in very good quantitative agreement with #cite(<Terashima2009>).

// [figvision-cn] imgs/flowfield_500e-05.png
// 该图由左右两个并列的子图组成，分别展示了流场在两个不同
// 时间瞬间的可视化结果。每个子图均为矩形区域，水平方向被
// 一条清晰的黑色粗线分割为上下两部分：上半部分显示数值阴
// 影图（numerical schlieren），下半部分显示压力场分布。
// 左子图： 类型：复合示意图（上半部为数值阴影图，下半部
// 为压力场伪彩色图）。 布局与物体：图像中央偏左位置有一
// 个近似球形的物体，其表面呈现网格状纹理，顶部连接一根垂
// 直细杆延伸至图像上边界。该球形物体跨越上下两个区域，大
// 部分位于下半区，小部分侵入上半区。 上半区（数值阴影图）：
// 背景为纯白色，无灰度变化或条纹，表明该区域内密度梯度极
// 小或为零。球形物体轮廓在此区域以半透明灰色渲染，内部可
// 见网格结构。 下半区（压力场）：采用蓝至红的连续色标映
// 射压力值，蓝色代表最小压力，红色代表最大压力。整体背景
// 为深蓝色，表示低压区；在球形物体底部接触界面处出现一小
// 块亮红色区域，表示局部高压；从红色区域向上过渡到浅红、
// 粉红，再渐变为深蓝，形成明显的压力梯度带。 标注文字：
// 图中无任何坐标轴、刻度、单位或文本标签。 趋势/结论：在
// 左侧时刻，球形物体刚接触或略微穿透界面，在接触点下方产
// 生显著高压区（红色），而周围流体压力较低（蓝色），表明
// 存在强烈的局部压力扰动。 右子图： 类型：同左子图，为同
// 一物理场景在不同时间的快照。 布局与物体：球形物体位置
// 相比左图向右移动并下沉更深，几乎完全进入下半区，仅顶部
// 一小部分仍在上半区。连接杆保持垂直，但随物体平移。 上
// 半区（数值阴影图）：背景仍为纯白色，无明显密度梯度特征。
// 球形物体轮廓更清晰，呈半透明灰色，内部网格可见。 下半
// 区（压力场）：颜色分布发生明显变化。原左图中的红色高压
// 区已消失，取而代之的是围绕球形物体底部的一个环形浅蓝色
// 至淡紫色区域，表示中等偏低压力；物体正后方（右侧）出现
// 一片较亮的粉红色区域，暗示压力略有升高；其余大部分区域
// 仍为深蓝色。 标注文字：同样无任何坐标轴、刻度、单位或
// 文本标签。 趋势/结论：在右侧时刻，球形物体进一步浸入流
// 体，初始接触点的强高压已消散，压力分布趋于平缓，但在物
// 体后方形成了新的弱高压区，反映流动演化过程中的压力重分
// 布现象。 两子图共同展示了一个球形物体穿越两种介质界面
// 时，流场中压力分布随时间动态变化的过程：初期接触引发局
// 部高压峰值，随后随着物体运动，压力场重新调整，高压区迁
// 移并减弱。
// [figvision-cn] imgs/flowfield_500e-05.png
// 该图由左右两个并列的子图组成，分别展示了流场在两个不同
// 时间瞬间的可视化结果。每个子图均为矩形区域，水平方向被
// 一条清晰的黑色粗线分割为上下两部分：上半部分显示数值阴
// 影图（numerical schlieren），下半部分显示压力场分布。
// 左子图： 类型：复合示意图（上半部为数值阴影图，下半部
// 为压力场伪彩色图）。 布局与物体：图像中央偏左位置有一
// 个近似球形的物体，其表面呈现网格状纹理，顶部连接一根垂
// 直细杆延伸至图像上边界。该球形物体跨越上下两个区域，大
// 部分位于下半区，小部分侵入上半区。 上半区（数值阴影图）：
// 背景为纯白色，无灰度变化或条纹，表明该区域内密度梯度极
// 小或为零。球形物体轮廓在此区域以半透明灰色渲染，内部可
// 见网格结构。 下半区（压力场）：采用蓝至红的连续色标映
// 射压力值，蓝色代表最小压力，红色代表最大压力。整体背景
// 为深蓝色，表示低压区；在球形物体底部接触界面处出现一小
// 块亮红色区域，表示局部高压；从红色区域向上过渡到浅红、
// 粉红，再渐变为深蓝，形成明显的压力梯度带。 标注文字：
// 图中无任何坐标轴、刻度、单位或文本标签。 趋势/结论：在
// 左侧时刻，球形物体刚接触或略微穿透界面，在接触点下方产
// 生显著高压区（红色），而周围流体压力较低（蓝色），表明
// 存在强烈的局部压力扰动。 右子图： 类型：同左子图，为同
// 一物理场景在不同时间的快照。 布局与物体：球形物体位置
// 相比左图向右移动并下沉更深，几乎完全进入下半区，仅顶部
// 一小部分仍在上半区。连接杆保持垂直，但随物体平移。 上
// 半区（数值阴影图）：背景仍为纯白色，无明显密度梯度特征。
// 球形物体轮廓更清晰，呈半透明灰色，内部网格可见。 下半
// 区（压力场）：颜色分布发生明显变化。原左图中的红色高压
// 区已消失，取而代之的是围绕球形物体底部的一个环形浅蓝色
// 至淡紫色区域，表示中等偏低压力；物体正后方（右侧）出现
// 一片较亮的粉红色区域，暗示压力略有升高；其余大部分区域
// 仍为深蓝色。 标注文字：同样无任何坐标轴、刻度、单位或
// 文本标签。 趋势/结论：在右侧时刻，球形物体进一步浸入流
// 体，初始接触点的强高压已消散，压力分布趋于平缓，但在物
// 体后方形成了新的弱高压区，反映流动演化过程中的压力重分
// 布现象。 两子图共同展示了一个球形物体穿越两种介质界面
// 时，流场中压力分布随时间动态变化的过程：初期接触引发局
// 部高压峰值，随后随着物体运动，压力场重新调整，高压区迁
// 移并减弱。
#figure(
  placement: top,
  align(center, grid(
    columns: 2, gutter: 4pt,
    align(center, image("imgs/flowfield_500e-05.png", width: 7.6cm)),
    align(center, image("imgs/flowfield_550e-04.png", width: 7.6cm)),
    align(center, [#text(9pt)[$t = 55 thin mu "s"$]]),
    align(center, [#text(9pt)[$t = 555 thin mu "s"$]]),
  )),
  caption: [Visualizations of the flow field at two different instances in time. The upper half of each image shows numerical schlieren, the lower half shows the pressure field from the smallest (blue) to the largest (red) pressure value. The black line indicates the location of the interface.],
) <fig-shockbubbleflowfield>

#figure(
  placement: top,
  align(center, canvas({
    plot.plot(size: (11, 5.6), x-label: [Position (mm)], y-label: [Time ($mu$s)],
      x-min: 0, x-max: 180, y-min: 0, y-max: 1000, legend: "inner-south-west", legend-anchor: "south-west", {
      plot.add(d("points-000"), style: (stroke: c0), label: [Upstream])
      plot.add(d("points-001"), style: (stroke: c1), label: [Jet])
      plot.add(d("points-002"), style: (stroke: c2), label: [Downstream])
      plot.add(d("points-003"), mark: "o", mark-size: 0.15, style: (stroke: none), label: [Terashima et al.])
      plot.add(d("points-004"), mark: "o", mark-size: 0.15, style: (stroke: none))
      plot.add(d("points-005"), mark: "o", mark-size: 0.15, style: (stroke: none))
    })
  })),
  caption: [Space-time diagram of three characteristic interface points. Positions of the upstream point (left-most point of the interface), the downstream point (right-most point of the interface), and the jet (left-most point of the interface on the center-line) are tracked. Reference values are taken from Terashima et al. @Terashima2009.],
) <fig-shockbubblespacetime>


= Single Node Performance
 <sec-Performance>
We assess the single node performance of the JAX-FLUIDS solver on an NVIDIA RTX A6000 GPU. The NVIDIA RTX A6000 provides 48GB of GPU memory and a bandwidth of 768 GB/s.  We conduct simulations of the three-dimensional compressible Taylor-Green vortex (TGV) #cite(<Brachet1984>) at $M a = 0.1$ on a series of grids  with increasing resolution. Specifically, we simulate TGVs on $64^(3)$, $128^(3)$, $256^(3)$, and $384^(3)$ cells. We use the two numerical setups described in the previous section.  We use JAX version 0.2.26. As JAX-FLUIDS can handle single- and double-precision computations, we assess the performance for both data types. @tab-Performance summarizes the results. At $384^(3)$ cells, only the simulation setup _HLLC-float32_ did not exceed the memory resources of the A6000 GPU,  compare with @tab-Memory. All results reported here are averaged over 5 independent runs. For the _HLLC-float32_ setup, JAX-FLUIDS achieves a performance of around 25 $mu s$ per time step. This corresponds to three evaluations of the right-hand side in Equation (#ref(<eq-FVD>, supplement: none)) as we use TVD-RK3 time integration. JAX-FLUIDS, therefore, provides a strong performance taking into consideration that the code is written entirely in the high-level language of Python/JAX. For the _ROE-float32_ setup, the computation of the eigenvectors and eigenvalues increases the wall clock time roughly by an order of magnitude. For _HLLC_ and _ROE_ schemes, we observe that the single-precision calculations are between 2.5 and 3 times faster  than the double-precision calculations.

 As GPU memory is a critical resource when working with JAX, we investigate the memory consumption of JAX-FLUIDS. The default behavior of JAX preallocates 90% of GPU memory in order to avoid memory fragmentation. Therefore, to monitor the actual memory consumption, we set `XLA_PYTHON_CLIENT_PREALLOCATE="false"` to disable memory preallocation and force JAX to allocate GPU memory as needed. Additionally, we set `XLA_PYTHON_CLIENT_ALLOCATOR="platform"` which allows JAX to deallocate unused memory. Note that allowing JAX to deallocate unused memory incurs a performance penalty, and we only use this setting to profile the  memory consumption.  @tab-Memory summarizes the GPU memory requirements for the aforementioned simulation setups. We refer to the documentation of JAX #cite(<jax2018github>) for more details on GPU memory utilization.

#figure(
  placement: top,
  table(
    columns: 6,
    stroke: none,
    align: center + horizon,
    table.hline(),
    [], table.cell(colspan: 5)[Mean wall clock time per cell per time step in $10^(-9) "s"$],
    table.hline(),
    [], [$32^3$], [$64^3$], [$128^3$], [$256^3$], [$384^3$],
    table.hline(),
    [HLLC - float32], [64.41 (11.87)], [24.39 (0.06)], [25.09 (0.04)], [28.36 (0.03)], [28.11 (0.01)],
    [HLLC - float64], [98.20 (0.49)], [93.94 (0.06)], [92.55 (0.09)], [92.76 (0.04)], [-],
    [ROE - float32], [241.71 (0.70)], [302.20 (0.32)], [304.55 (0.16)], [301.78 (0.36)], [-],
    [ROE - float64], [703.40 (1.42)], [746.78 (6.17)], [759.36 (5.23)], [760.09 (6.37)], [-],
    table.hline(),
  ),
  caption: [Mean wall clock time per cell per time step. All computations are run on an NVIDIA RTX A6000 GPU. The wall clock times are averaged over five runs. Numbers in brackets denote the standard deviation over the five runs.],
  kind: table,
) <tab-Performance>

#figure(
  placement: top,
  table(
    columns: 6,
    stroke: none,
    align: center + horizon,
    table.hline(),
    [], table.cell(colspan: 5)[Memory pressure],
    table.hline(),
    [], [$32^3$], [$64^3$], [$128^3$], [$256^3$], [$384^3$],
    table.hline(),
    [HLLC - float32], [295.6 (1.50)], [434.4 (1.50)], [1424.4 (1.50)], [9141.6 (1.50)], [29849.2 (2.04)],
    [HLLC - float64], [353.6 (2.33)], [623.6 (2.33)], [2631.6 (2.33)], [18275.6 (2.33)], [-],
    [ROE - float32], [626.0 (1.79)], [818.8 (2.04)], [2255.2 (2.04)], [13546.0 (1.79)], [-],
    [ROE - float64], [688.0 (2.83)], [1068.4 (2.33)], [3938.0 (2.83)], [26504.4 (2.33)], [-],
    table.hline(),
  ),
  caption: [GPU memory pressure in megabytes (MB).],
  kind: table,
) <tab-Memory>


= Machine Learning in JAX-FLUIDS
 <sec-BackwardPass>
Having showcased that the JAX-FLUIDS solver functions very well as a modern and easy-to-use fluid dynamics simulator, we now discuss its capabilities for ML research, in particular its automatic differentiation capabilities for end-to-end optimization. In this section, we demonstrate that we can successfully differentiate through the entire JAX-FLUIDS solver. We validate the AD gradients for single- and two-phase flows. We then showcase the potential of JAX-FLUIDS by training a data-driven Riemann solver  leveraging end-to-end optimization.

== Deep Learning Fundamentals
 <subsec-Deeplearning> Given a data set of input-outputs pairs $cal(D) = { (upright(bold(x))_(1), upright(bold(y))_(1)), . . ., (upright(bold(x))_(N), upright(bold(y))_(N)) }$ with $upright(bold(x)) in cal(X)$ and $upright(bold(y)) in cal(Y)$, supervised learning tries to find a function $f : cal(X) -> cal(Y)$ which (approximately) minimizes an average loss
$ cal(L) = 1/N sum_(i = 1)^(N) L(upright(bold(y))_(i), f(upright(bold(x))_(i))), $

where $L : cal(Y) times cal(Y) -> RR$ is a suitable loss function. $cal(X)$ and $cal(Y)$ are input and output spaces, and $f in cal(F)$, where $cal(F)$ is the hypothesis space. We use $upright(bold(hat(y)))_(i)$ to denote the output of the function $f$ for input $upright(bold(x))_(i)$, $upright(bold(hat(y)))_(i) = f(upright(bold(x))_(i))$. A popular loss in regression tasks is the mean-squared error (MSE)
$ cal(L) = M S E(upright(bold(x)), upright(bold(y))) = 1/N sum_(i = 1)^(N) (upright(bold(y))_(i) - upright(bold(hat(y)))_(i))^(2). $

One possible and highly-expressive class of functions are deep neural networks (DNN) #cite(<Lecun2015>) #cite(<Goodfellow2016>). DNNs are parameterizable nonlinear compound functions, $f = f_(upright(bold(theta)))$, where the network parameters consist of weights and biases, $upright(bold(theta)) = { upright(bold(W)), upright(bold(b)) }$. DNNs consist of multiple hidden layers of units between input layer and output layer. The values in each layer are called activations. Multilayer perceptrons (MLPs) are one particular kind of DNN in which adjacent layers are densely connected #cite(<Goodfellow2016>). We compute the activations $upright(bold(a))^(l)$ in layer $l$ from the activations of the previous layer $upright(bold(a))^(l - 1)$,
$ upright(bold(a))^(l) = sigma (upright(bold(W))^(l - 1) upright(bold(a))^(l - 1) + upright(bold(b))^(l - 1)). $

Here, $upright(bold(W))^(l - 1)$ is the weight matrix linking layers $l - 1$ and $l$, $upright(bold(b))^(l - 1)$ is the bias vector, and $sigma (dot)$ is the element-wise nonlinearity. Typically, DNNs are trained by minimizing $cal(L)$ via mini-batch gradient descent or more advanced optimization routines  like AdaGrad #cite(<Duchi2011>) or Adam #cite(<Kingma2015>).

== Optimization through PDE Trajectories
 Machine learning has the potential to discover and learn novel data-driven numerical algorithms for the numerical computation of fluid dynamics. For supervised learning, we need input-ouput pairs. In fluid dynamics, exact solutions rarely exist for complex flow. We usually take highly-resolved numerical simulations as exact.

 In the context of differentiable physics, end-to-end optimization usually refers to supervised learning of ML models  which receive gradients that are backpropagated through a differentiable physics simulator. Here, the ML model is placed inside a differentiable PDE solver. A trajectory obtained from a forward simulation of the PDE solver is compared to a ground truth trajectory, and the derivatives of the loss are  propagated across the temporal sequence, i.e., the trajectory. We denote a trajectory of states as
$ upright(bold(tau)) = { upright(bold(U))^(1),. . .,upright(bold(U))^(N_(T)) } . $

The differentiable solver, e.g., JAX-FLUIDS, can be interpreted as a parameterizable generator $cal(G)_(upright(bold(theta)))$ of such a trajectory  starting from the initial condition $upright(bold(U))_(0)$.
$ upright(bold(tau))^(P D E)_(upright(bold(theta))) = { upright(bold(U))^(1),. . .,upright(bold(U))^(N_(T)) } = cal(G)_(upright(bold(theta)))(upright(bold(U))_(0)) $

Our loss objective is the difference between the trajectory $upright(bold(tau))^(P D E)_(upright(bold(theta)))$ and a ground truth trajectory $upright(bold(hat(tau))) = { upright(bold(hat(U)))^(1),. . .,upright(bold(hat(U)))^(N_(T)) }$. For example, using the MSE in state space
$ cal(L)^(tau) = frac(1, N_(T)) sum_(i = 1)^(N_(T)) M S E(upright(bold(U))^(i), upright(bold(hat(U)))^(i)). $

The derivatives of the loss with respect to the tuneable parameters $partial cal(L) slash partial upright(bold(theta))$ are backpropagated  across the simulation trajectory and through the entire differentiable PDE solver. And the ML model is optimized by using $partial cal(L) slash partial upright(bold(theta))$ in a gradient-based optimization routine.

 In particular, multiple steps through the simulator can be chained together. Thereby, the ML model observes the full dynamics of the underlying PDE and learns how its actions influence the entire simulation trajectory. Naturally, the trained model is equation-specific and physics-informed. This training procedure alleviates the problem of distribution mismatch between training and test data as the model sees its own outputs during the training phase. Additionally, the ML model could potentially account for approximation errors of other parts of the solver.

 JAX-FLUIDS allows us to take gradients through an entire CFD simulation trajectory by applying `jax.grad` to any scalar observable of the state trajectory. We want to stress that JAX-FLUIDS thereby differentiates for each time step through complex subfunctions such as the spatial reconstruction,  Riemann solvers, or two-phase interactions.

== Validation of Automatic Differentiation Gradients
 <subsec-gradientvalid> Before we showcase the full potential of JAX-FLUIDS for learning data-driven numerical schemes by end-to-end optimization, we first validate the gradients obtained from automatic differentiation by comparing them with gradients obtained from finite-differences. We consider a single shock wave with shock Mach number $M_(S)$ propagating into a fluid at rest.
We fix the state ahead of the shock with $rho_(R) = p_(R) = 1, u_(R) = 0$. The Rankine-Hugoniot relations #cite(<Toro2009a>) determine the state behind the shock wave as a function of the shock Mach number $M_(S)$. As the shock wave crosses the computational domain, the integral entropy increases. The described setup is depicted in @fig-gradients on left. The left and right states are separated by an initial shock discontinuity. We consider a single-phase and two-phase setup. In both setups all fluids are modeled by the ideal gas law. In the former, the same fluid is left and right of the initial shock wave and $gamma_(L) = gamma_(R)$. In the latter, two immiscible fluids are separated by the shock wave, i.e., $gamma_(L) != gamma_(R)$. For the second setup, we make use of the entire level-set algorithm as described earlier.

 As the shock wave propagates into the domain, the integral entropy in the domain increases by $Delta S$, see the schematic in the middle of @fig-gradients. The integral entropy at time $t$ is defined by
$ S(t) = integral_(Omega) rho (x,t) s(x,t) d x, $

and the increase in integral entropy is
$ Delta S(t) = S(t) - S(t_(0)) = integral_(Omega) (rho (x,t) s(x,t) - rho (x,t = 0) s(x,t = 0)) d x . $

In the simplified setting under investigation, the increase in integral entropy at any fixed point in time, say $t^(n)$, is solely determined by the shock Mach number $M_(S)$, i.e., $Delta S^(n) = Delta S(t = t^(n)) = Delta S(M_(S))$. We let the shock wave propagate for $n$ steps with fixed $Delta t$, i.e., $t^(n) = n Delta t$, and compute the gradient of the total entropy increase $Delta S^(n)$ with respect to the shock Mach number $M_(S)$.
$ g = frac(partial Delta S^(n), partial M_(S)) $

We compute the gradient with automatic differentiation $g_(A D)$ and with second-order central finite-differences according to
$ g_(F D)^(epsilon) = frac(Delta S^(n) (M_(S) + epsilon) - Delta S^(n) (M_(S) - epsilon), 2 epsilon). $

Here, we set $M_(S) = 2$. We use the _HLLC_ setup described in the previous section. We set $Delta t = 1 times 10^(- 2)$ and $n = 5$. In the single-phase case $gamma_(L) = gamma_(R) = 1.4$, in the two-phase case $gamma_(L) = 1.4, gamma_(R) = 1.667$. On the right of @fig-gradients, we visualize the $l_(1)$ norm between the gradients $g_(A D)$ and $g_(F D)^(epsilon)$ for the single-phase and two-phase setup. We choose $epsilon in [ 1 e - 1, 3 e - 2, 1 e - 2, 3 e - 3, 1 e - 3, 3 e - 4, 1 e - 4 ]$. We observe that the finite-difference approximations converge with second-order to the respective automatic differentiation gradients. We conclude that automatic differentiation through the entire JAX-FLUIDS code works and gives correct gradients. In passing, we note that although the described setting is a simplified one-dimensional setup, and we only differentiate w.r.t a single parameter, the AD call has to backpropagate through multiple integration steps with several Runge-Kutta substeps each accompanied by calls to spatial reconstruction and Riemann solver. Especially in the two-phase setup, gradients are obtained through the entire level-set computational routines including  level-set advection, level-set reinitilization, and the extension procedure.

#figure(
  placement: top,
  align(center, grid(
    columns: (auto, auto, auto), gutter: 14pt, align(horizon,
    // left: initial-state schematic
    canvas({
      import "@preview/cetz:0.4.0": draw
      import draw: *
      line((0, 0), (0, 3.25), stroke: (thickness: 1pt))
      line((-0.75, 3.45), (0.75, 3.45), mark: (end: ">"), stroke: 0.8pt)
      content((0, 3.7), [$M_S$])
      content((-0.12, 2.75), [$rho_L$], anchor: "east")
      content((-0.12, 2.35), [$u_L$], anchor: "east")
      content((-0.12, 1.15), [$p_L$], anchor: "east")
      content((-0.12, 0.75), [$gamma_L$], anchor: "east")
      content((0.12, 2.75), [$rho_R$], anchor: "west")
      content((0.12, 2.35), [$u_R$], anchor: "west")
      content((0.12, 1.15), [$p_R$], anchor: "west")
      content((0.12, 0.75), [$gamma_R$], anchor: "west")
    }),
  ),
    // middle: entropy staircase
    align(horizon, canvas({
      import "@preview/cetz:0.4.0": draw
      import draw: *
      let X(d) = d * 4
      let Y(v) = (v - 0.2) / 0.9 * 4
      line((0, 0), (4.3, 0), mark: (end: ">"), stroke: 0.7pt)
      line((0, 0), (0, 4.3), mark: (end: ">"), stroke: 0.7pt)
      content((4.5, -0.05), [$x$])
      content((-0.25, 4.45), [$S$])
      for (d, l) in ((0, [0]), (0.5, [0.5]), (1, [1])) {
        line((X(d), -0.08), (X(d), 0.08), stroke: 0.7pt)
        content((X(d), -0.32), l)
      }
      line(
        (X(0), Y(1)), (X(0.5), Y(1)), (X(0.5), Y(0.25)), (X(1), Y(0.25)),
        fill: c0.transparentize(60%), close: true, stroke: (thickness: 1pt),
      )
      line(
        (X(0), Y(1)), (X(0.75), Y(1)), (X(0.75), Y(0.25)), (X(1), Y(0.25)),
        stroke: (thickness: 1pt, dash: "dashed"),
      )
      content((X(0.625), Y(0.6)), [$Delta S$])
    })),
    // right: gradient check
    align(horizon, canvas({
      plot.plot(size: (5.2, 4.4), x-label: [$epsilon$], y-label: [$|g_"AD" - g_"FD"^epsilon|_1$],
        x-min: 7e-5, x-max: 0.15, y-min: 1e-8, y-max: 1e0,
        x-mode: "log", y-mode: "log", x-tick-step: 1, y-tick-step: 1,
        legend: "inner-north-east", legend-anchor: "north-east", {
        plot.add(d("gradient_check_single-000"), mark: "o", mark-size: 0.14,
          style: (stroke: c0), label: [Single-Phase])
        plot.add(d("gradient_check_two-000"), mark: "o", mark-size: 0.14,
          style: (stroke: c1), label: [Two-Phase])
        plot.add(d("gradient_check_two-001"), style: (stroke: black), label: [$cal(O)(Delta x^2)$])
      })
    })),
  )),
  caption: [Left: Schematic of the computational setup. The constant initial states are separated by a single right-running shock discontinuity. Middle: Schematic of the total entropy increase. Right: Error convergence of the gradient obtained by second-order central finite-difference approximation with respect to the gradient obtained by automatic differentiation, i.e., $|g_"AD" - g_"FD"^epsilon|_p$.],
) <fig-gradients>

== End-to-end Optimization of a Riemann Solver
 <subsec-rusanovnn>

 Automatic differentiation yields the opportunity to optimize and learn numerical schemes from data by end-to-end optimization through a numerical simulator #cite(<Bar-Sinai2019>) #cite(<Bezgin2021a>) #cite(<Kochkove2101784118>). In this section, we want to showcase how JAX-FLUIDS is able to learn a numerical flux function (i.e., an approximate Riemann solver) by minimizing a loss between predicted trajectory and ground truth trajectory. We optimize the popular Rusanov flux function (also known as local Lax-Friedrichs flux function). The Rusanov flux at the cell face $x_(i + 1 slash 2)$ is
$ upright(bold(F))_(i + 1 slash 2)^(#text[Rusanov])= 1/2(upright(bold(F))_(L) + upright(bold(F))_(R)) - 1/2 alpha (upright(bold(U))_(R) - upright(bold(U))_(L)). $ <eq-Rusanov>

Here, $upright(bold(U))_(L slash R)$ and $upright(bold(F))_(L slash R)$ are the left and right sided cell face reconstructions of the conservative variable and the flux. $alpha$ is the scalar numerical viscosity. For the classical Rusanov method the numerical viscosity is defined at each cell face  $alpha_(#text[Rusanov])= max { | u_(L) - c_(L) |, | u_(L) + c_(L)|, | u_(R) - c_(R)|, | u_(R) + c_(R)| }$.  $u$ is the cell face normal velocity and $c$ is the local speed of sound. It is well known that although the Rusanov method yields a stable solution, the excess numerical diffusion leads to smearing out of the solution. As a simple demonstration of the AD-capabilities of our CFD solver, we introduce the Rusanov-NN flux  with the dissipation $alpha^(#text[NN])_(#text[Rusanov])= N N(bar.v Delta u bar.v, u_(M), c_(M), bar.v Delta s bar.v)$ to be optimized. The dissipation is output of a multi-layer perceptron which takes as inputs the jump in normal velocity $Delta u = bar.v u_(R) - u_(L) bar.v$, the mean normal velocity $u_(M) = 1/2(u_(L) + u_(R))$, the mean speed of sound $c_(M) = 1/2(c_(L) + c_(R))$, and the entropy jump $Delta s = bar.v s_(R) - s_(L) bar.v$. The network is composed of three layers with 32 nodes each. We use RELU activations for the hidden layers. An exponential activation function in the output layer guarantees $alpha_(#text[Rusanov])^(#text[NN])>= 0$.

#figure(
  placement: top,
  align(center, block(width: 100%)[
    #let rows = ("Exact", "CG", "Rusanov-NN", "Rusanov")
    #grid(
      columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 1pt,
      row-gutter: 2pt,
      [],
      ..(50, 100, 250, 500, 1000, 1250).map(s => align(center, text(7.5pt)[Step = #s])),
      ..range(4).map(r => (
        rotate(-90deg, reflow: true, text(7.5pt)[#rows.at(r)]),
        ..range(6).map(c => image("imgs/pic_absvel_" + str(r + 4 * c) + ".png", width: 2.3cm)),
      )).flatten(),
    )
  ]),
  caption: [Trajectories of the absolute velocity. From top to bottom: Ground truth (Exact) on $128 times 128$, coarse-grained (CG) on $32 times 32$, Rusanov-NN on $32 times 32$, and Rusanov on $32 times 32$. For each time step, values are normalized with the minimum and maximum value of the exact solution.],
) <fig-Trajectory>

We set up a highly-resolved simulation of a two-dimensional implosion test case to generate the ground truth trajectory. The initial conditions are a diagonally placed jump in pressure and density,
$ (rho, u, v, p) = cases((0.14\, 0\, 0\, 0.125) & #text[if] x + y <= 0.15\,, (1\, 0\, 0\, 1) & #text[if] x + y > 0.15\,) $ <eq-FullImplosion>

on a domain with extent $x times y in [0, 1 ] times [0, 1 ]$. A shock, a contact discontinuity, and a rarefaction wave emanate from the initial discontinuity and travel along the diagonal. The shock is propagating towards the lower left corner and is reflected by the walls resulting in a double Mach reflection, while the rarefaction wave is travelling into the open domain. The high resolution simulation is run on a mesh with $128 times 128$ cells with a WENO3-JS cell face reconstruction, TVD-RK2 integration scheme, and the HLLC Riemann solver. We use a fixed time step $Delta t = 2.5 times 10^(- 4)$ and sample the trajectory every $Delta t_(#text[CG])= 10^(- 3)$,  which is the time step for the coarse grained trajectories. A trajectory of 2501 time steps is generated, i.e., $t in [0, 2500 Delta t_(#text[CG])]$. Exemplary time snapshots for the absolute velocity are visualized in the top row of @fig-Trajectory. We obtain the ground truth data after coarse-graining the high-resolution trajectory onto $32 times 32$ points, see second row of @fig-Trajectory.

 The dissipation network model is trained in a supervised fashion by minimizing the loss between the coarse-grained (CG) trajectory and the simulation produced by the Rusanov-NN model. The loss function is defined as the mean-squared error between the predicted and coarse-grained primitive state vectors, $upright(bold(W))^(#text[NN])$ and $upright(bold(W))^(#text[CG])$, over a trajectory of length $N_(T)$,
$ L = frac(1, N_(T))sum_(i = 1)^(N_(T)) M S E(upright(bold(W))^(#text[NN])_(i), upright(bold(W))^(#text[CG])_(i)). $ <eq-Loss>

The training data set consists of the first $1000$ time steps of the coarse grained reference solution.  During training, the model is unrolled for $N_(T) = 15$ time steps.  We use the Adam optimizer with a constant learning rate $5 e - 4$ and a batch size of $20$. The Rusanov-NN model is trained for $200$ epochs. Although we have trained on trajectories of length $15$, the trained model is then evaluated for the entire trajectory of $2501$ time steps.  @fig-Trajectory compares the results of the Rusanov and the final Rusanov-NN flux functions. The NN-Rusanov flux is less dissipative than the classical Rusanov scheme and recovers small scale flow structures very well, e.g., see time step 100 in @fig-Trajectory. The NN-Rusanov flux stays stable over the course of the simulation and consistently outperforms the Rusanov flux,  see the relative errors in pressure and density in @fig-RelError. The ML model even performs very well outside the training set (time steps larger than $1000$).

#figure(
  placement: top,
  align(center, canvas({
    plot.plot(size: (10, 4.8), x-label: [Steps], y-label: [Relative error],
      x-min: 0, x-max: 2500, y-min: 0, y-max: 4, legend: "inner-north-east", legend-anchor: "north-east", {
      plot.add-vline(1000, style: (stroke: (paint: luma(128), thickness: 0.7pt)))
      plot.add(d("relerr-000"), style: (stroke: c0), label: [$rho_"Rus"^"NN"$])
      plot.add(d("relerr-001"), style: (stroke: (paint: c0, dash: "dashed")), label: [$rho_"Rus"$])
      plot.add(d("relerr-002"), style: (stroke: c1), label: [$p_"Rus"^"NN"$])
      plot.add(d("relerr-003"), style: (stroke: (paint: c1, dash: "dashed")), label: [$p_"Rus"$])
    })
  })),
  caption: [Relative $L_1$ error for density (blue) and pressure (orange). The gray line indicates the training horizon.],
) <fig-RelError>


= Conclusion
 <sec-Conclusion>
We have presented JAX-FLUIDS, a comprehensive state-of-the-art fully-differentiable python package for compressible three-dimensional computational fluid dynamics. Machine learning is becoming more and more dominant in the physical and engineering sciences. Especially, fluid dynamics represents a field in which ML techniques and data-driven methods show very promising results and seem to have a high potential. Despite the recent surge of ML-CFD research, a comprehensive state-of-the-art differentiable CFD solver has not been published. JAX-FLUIDS provides researchers at the intersection of fluid dynamics and deep learning the opportunity to explore new data-driven numerical models for fluid dynamics. JAX-FLUIDS offers powerful high-order numerical methods for a wide variety of fluid dynamics problems, e.g., turbulent flows, flows with arbitrary solid boundaries, compressible flows, and two-phase flows. The modular architecture of JAX-FLUIDS makes integration of custom submodules easy and straightforward.

 Although JAX-FLUIDS covers a wide range of flow physics, some intriguing and complex phenomena like combustion, fluid-structure interaction, or cavitation cannot yet be modeled with JAX-FLUIDS. For the future, we plan to implement appropriate numerical methods.

 Currently, by far the largest limitation of JAX-FLUIDS is the available memory of the GPU. Although JAX-FLUIDS scales out of the box to problem sizes with roughly 400 million degrees of freedom (DOFs) on a single modern GPU, many problems in fluid dynamics require higher DOFs. Generally, there are two ways of tackling this problem: adaptive multiresolution #cite(<Harten1994>) #cite(<Harten1995>) and parallelization to multiple GPUs, e.g. #cite(<Romero2020>) #cite(<Hafner2021>).  Adaptive multiresolution increases the mesh resolution in areas of interest (e.g., where small scale structures are present) while using a much coarser resolution in  other parts of the flow field. Compared to a uniform mesh, adaptive multiresolution increases the efficiency of the simulation in terms of computational resources. To the knowledge of the authors, multiresolution strategies seem to be problematic with a jit-compiled code framework such as JAX, as the computegraph has to be static. A second approach for increasing the computable problem size is parallelization. The latest version of JAX #cite(<jax2018github>) as well as other works #cite(<Hafner2021b>) propose different parallelization strategies for JAX algorithms and provide promising avenues for future work.


#heading(numbering: none)[Acknowledgements]
<acknowledgements>

// Appendix
#counter(heading).update(0)

#heading(numbering: none)[Appendix A. Numerical and Case Setup Files for Sod Shock Tube Test Case]
 <sec-Appendix>
#figure(
  placement: top,
  listing("code/numerical_setup.json", lang: "json"),
  caption: [Numerical setup _json_ file for the Sod shock tube test case.],
) <fig-numerical-setup>

#figure(
  placement: top,
  listing("code/case_setup.json", lang: "json"),
  caption: [Case setup _json_ file for the Sod shock tube test case.],
) <fig-case-setup>


#heading(numbering: none)[Data Availability Statement]
JAX-FLUIDS is available under the MIT license at #link("https://github.com/tumaer/JAXFLUIDS").


#bibliography("refs.bib", style: "ieee", title: [References])
