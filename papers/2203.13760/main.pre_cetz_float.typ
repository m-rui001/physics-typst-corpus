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


#align(center)[
  #text(17pt, weight: "bold", [JAX-FLUIDS: A fully-differentiable high-order computational fluid dynamics solver for compressible two-phase flows])   #v(1.2em)
  #text(10.5pt)[Deniz A. Bezgin\correfcor\fnreffn, Aaron B. Buhendwa\correfcor\fnreffn, Nikolaus A. Adams\corref]
  
]

#v(1.2em)




















#block[
]


Physical systems are governed by partial differential equations (PDEs). The Navier-Stokes equations describe fluid flows and are representative of nonlinear physical systems with complex spatio-temporal interactions. Fluid flows are omnipresent in nature and engineering applications, and their accurate simulation is essential for providing insights into these processes. While PDEs are typically solved with numerical methods, the recent success of machine learning (ML) has shown that ML methods can provide novel avenues of finding solutions to PDEs. ML is becoming more and more present in computational fluid dynamics (CFD). However, up to this date, there does not exist a general-purpose ML-CFD package which provides 1) powerful state-of-the-art numerical methods, 2) seamless hybridization of ML with CFD, and 3) automatic differentiation (AD) capabilities. AD in particular is essential to ML-CFD research as it provides gradient information and enables optimization of preexisting and novel CFD models. In this work, we propose JAX-FLUIDS: a comprehensive fully-differentiable CFD Python solver for compressible two-phase flows. JAX-FLUIDS allows the simulation of complex fluid dynamics with phenomena like three-dimensional turbulence, compressibility effects, and two-phase flows. Written entirely in JAX, it is straightforward to include existing ML models into the proposed framework. Furthermore, JAX-FLUIDS enables end-to-end optimization. I.e., ML models can be optimized with gradients that are backpropagated through the entire CFD algorithm, and therefore contain not only information of the underlying PDE but also of the applied numerical methods. We believe that a Python package like JAX-FLUIDS is crucial to facilitate research at the intersection of ML and CFD and may pave the way for an era of differentiable fluid dynamics.


#block[
]


Computational fluid dynamics ,Machine learning ,Differential programming ,Navier-Stokes equations ,Level-set ,Turbulence ,Two-phase flows


d





k


e


y


w


o


r


d







 frontmatter
\


j


o


u


r


n


a


l









= Introduction
<sec:Intro>


The evolution of most known physical systems can be described by partial differential equations (PDEs). Navier-Stokes equations (NSE) are partial differential equations that describe the continuum-scale flow of fluids. Fluid flows are omnipresent in engineering applications and in nature, and the accurate numerical simulation of complex flows is crucial for the prediction of global weather phenomena #text([]) #text([]), for applications in biomedical engineering such as air flow through the lungs or blood circulation #text([]) #text([]), and for the efficient design of turbomachinery #text([]), wind turbines #text([]) #text([]), and airplane wings #text([]). Computational fluid dynamics (CFD) aims to solve these problems with numerical algorithms.


While classical CFD has a rich history, in recent years the symbiosis of machine learning (ML) and CFD has sparked a great interest amongst researchers #text([]) #text([]) #text([]). The amalgamation of classical CFD and ML requires powerful novel algorithms which allow seamless integration of data-driven models and, more importantly, end-to-end automatic differentiation #text([]) through the entire algorithm. Here, we provide JAX-FLUIDS (#link("https://github.com/tumaer/JAXFLUIDS")): the first state-of-the-art fully-differentiable CFD framework for the computation of three-dimensional compressible two-phase flows with high-order numerical methods. Over the course of this paper, we discuss the challenges of hybrid ML-accelerated CFD solvers and highlight how novel architectures like JAX-FLUIDS have the potential to facilitate ML-supported fluid dynamics research.


The quest for powerful numerical fluid dynamics algorithms has been a long-lasting challenge. In the mid of the last century, the development of performant computer processing units (CPUs) laid the fundament for the development of computational fluid dynamics (CFD). For the first time, computers were used to simulate fluid flows #text([]). Computational fluid dynamics, i.e., the numerical investigation of fluid flows, became a scientific field on its own. With the rapid development of computational hardware, the CFD community witnessed new and powerful algorithms for the computation of more and more complex flows. Among others, robust time integration schemes, high-order spatial discretizations, and accurate flux-functions were thoroughly investigated. In the 1980s and 1990s, many advancements in numerical methods for compressible fluid flows followed, e.g., #text([]) #text([]) #text([]) #text([]) #text([]).


In recent years, machine learning (ML) has invigorated the physical sciences by providing novel tools for predicting the evolution of physical systems. Breakthrough inventions in ML #text([]) #text([]) and rapid technical developments of graphics processing units (GPUs) have led to an ever-growing interest in machine learning. Starting from applications in computer vision #text([]) #text([]), cognitive sciences #text([]), and genomics #text([]), machine learning and data-driven methods have also become more and more popular in physical and engineering sciences. This development has partially been fuelled by the emergence of powerful general-purpose automatic differentiation frameworks, such as Tensorflow #text([]), Pytorch #text([]), and JAX #text([]). Natural and engineering sciences can profit from ML methods as they have capabilities to learn complex relations from data and enable novel strategies for modelling physics as well as new avenues of post-processing. For example, machine learning has been successfully used to identify PDEs from data #text([]), and physics-informed neural networks provide new ways for solving inverse problems #text([]) #text([]) by combining data and PDE knowledge.


It is well-known that fluid dynamics is a data-rich and compute-intensive discipline #text([]). The nonlinearity of the underlying governing equations, the Navier-Stokes equations for viscous flows and the Euler equations for inviscid flows, is responsible for very complex spatio-temporal features of fluid flows. For example, turbulent flows exhibit chaotic behavior with strong intermittent flow features, and non-Gaussian statistics. At the same time, in the inviscid Euler equations strong discontinuities can form over time due to the hyperbolic character of the underlying PDEs.


Machine learning offers novel data-driven methods to tackle long-standing problems in fluid dynamics #text([]) #text([]) #text([]). A multitude of research has put forward different ways of incorporating ML in CFD applications. Applications range from fully data-driven surrogate models to less invasive hybrid data-driven numerical methods. Thereby, scientific ML methods can be categorized according to different criteria.


One important distinction is the level of physical prior-knowledge that is included in model and training #text([]). Entirely data-driven ML models have the advantage of being quickly implemented and efficient during inference. However, they typically do not offer guarantees on performance (e.g., convergence, stability, and generalization), convergence in training is challenging, and it is often difficult to enforce physical constraints such as symmetries or conservation of energy. In contrast, established numerical methods are consistent and enforce physical constraints. Recently, intense research has investigated the hybridization of ML and classical numerical methods.


A second major distinction of ML models can be made according to on- and offline training. Up until now, ML models have been typically optimized offline, i.e., outside of physics simulators. Upon proper training, they are then plugged into an existing CFD solver for evaluation of down-stream tasks. Examples include training of explicit subgrid scale models in large eddy simulations #text([]), interface reconstruction in multiphase flows #text([]) #text([]), and cell face reconstruction in shock-capturing schemes #text([]) #text([]).


Although the offline training of ML models is relatively easy, there are several drawbacks to this approach. For one, these models suffer from a data-distribution mismatch between the data seen at training and test time. Secondly, they generally do not directly profit from a priori knowledge about the dynamics of the underlying PDE. Additionally, fluid mechanics solvers are often very complex, written in low-level programming languages like Fortran or C++, and heavily optimized for CPU computations. This is in contrast with practices in ML research: ML models are typically trained in Python and optimized for GPU usage. Inserting these models into preexisting CFD software frameworks can be a tedious task.


To tackle this problem, researchers have come up with differentiable CFD frameworks written entirely in Python which allow end-to-end optimization of ML models. The end-to-end (online) training approach utilizes automatic differentiation #text([]) through entire simulation trajectories. ML models trained in such a fashion experience the PDE dynamics and also see their own outputs during training. Among others, Bar-Sinai and co-workers #text([]) #text([]) have proposed a differentiable framework for finding optimal discretizations for simple non-linear one-dimensional problems and turbulent mixing in two-dimensions. In #text([]), a differentiable solver was placed in the training loop to reduce the error of iterative solvers. Bezgin et al. #text([]) have put forward a subgrid scale model for nonclassical shocks. Kochkov et al. #text([]) have optimized a subgrid scale model for two-dimensional turbulence.


Afore-noted works focus on simpler flow configurations. The problems are often one- and two-dimensional, incompressible, and lack complex physics such as two-phase flows, three-dimensional turbulence, or compressibility effects. Additionally, the written code packages often are highly problem specific and cannot be used as general differentiable CFD software packages. To the knowledge of the authors, despite a high-interest in ML-accelerated CFD, to this day there does not exist a comprehensive mesh-based software package for #emph[differentiable fluid dynamics] in the Eulerian reference frame. At the same time, for Lagrangian frameworks, the differentiable software package JAX-MD #text([]) has been successfully used for molecular dynamics and provides a general fundament for other particle-based discretization methods.


We reiterate that the steady rise and success of machine learning in computational fluid dynamics, but also more broadly in computational physics, calls for a new generation of algorithms which allow


+ rapid prototyping in high-level programming languages,

+ algorithms which can be run on CPUs, GPUs, and TPUs,

+ the seamless integration of machine learning models into solver frameworks,

+ fully-differentiable algorithms which allow end-to-end optimization of data-driven models.


Realizing the advent of #emph[differentiable fluid dynamics] and the increasing need for a differentiable general high-order CFD solver, here we introduce JAX-FLUIDS as a fully-differentiable general-purpose 3D finite-volume CFD solver for compressible two-phase flows. JAX-FLUIDS is written entirely in JAX #text([]), a numerical computing library with automatic differentiation capabilities which has seen increased popularity in the physical science community over the past several years. JAX-FLUIDS provides a wide variety of state-of-the-art high-order methods for compressible turbulent flows. A powerful level-set implementation allows the simulation of arbitrary solid boundaries and two-phase flows. High-order shock-capturing methods enable the accurate computation of shock-dominated compressible flow problems and shock-turbulence interactions. Performance and usability were key design goals during development of JAX-FLUIDS. The solver can conveniently be installed as a Python package. The source code builds on the JAX NumPy API. Therefore, JAX-FLUIDS is accessible, performant, and runs on accelerators like CPUs, GPUs, and TPUs. Additionally, an object-oriented programming style and a modular design philosophy allows users the easy integration of new modules. We believe that frameworks like JAX-FLUIDS are crucial to facilitate research at the intersection of ML and CFD, and may pave the way for an era of #emph[differentiable fluid dynamics].


The remainder of this paper is organized as follows. In @sec:PhysicalModel and @sec:numericalmodel, we describe the physical and numerical model. @sec:Implementation describes challenges of writing a high-performance CFD code in a high-level programming language such as JAX. We additionally detail the general structure of our research code. In @sec:ForwardPass, we evaluate our code as a classical physics simulator. We validate the numerical framework on canonical test cases from compressible fluid mechanics, including strong-shocks and turbulent flows. In @sec:Performance, we assess the computational performance of JAX-FLUIDS. @sec:BackwardPass showcases how the proposed framework can be used in machine learning tasks. Specifically, we demonstrate full-differentiability of the framework by optimizing a numerical flux function. Finally, in @sec:Conclusion we conclude and summarize the main results of our work.


= Physical Model
<sec:PhysicalModel>


We are interested in the compressible Euler equations for inviscid flows and in the compressible Navier-Stokes equations (NSE) which govern viscous flows. The state of a fluid at any position in the flow field $upright(bold(x)) = [x , y , z]^T = [x_1 , x_2 , x_3]^T$ at time $t$ can be described by the vector of primitive variables $upright(bold(W)) = [rho , u , v , w , p]^T$. Here, $rho$ is the density, $upright(bold(u)) = [u , v , w]^T = [u_1 , u_2 , u_3]^T$ is the velocity vector, and $p$ is the pressure. An alternative description is given by the vector of conservative variables $upright(bold(U)) = [rho , rho u , rho v , rho w , E]^T$. Here, $rho upright(bold(u)) = [rho u , rho v , rho w]^T$ are the momenta in the three spatial dimensions, and $E = rho e + 1 / 2 rho upright(bold(u)) dot.op upright(bold(u))$ is the total energy per unit volume. $e$ is the internal energy per unit mass.


In differential formulation, the compressible Euler equations can be written in terms of $upright(bold(U))$


$ frac(partial upright(bold(U)), partial t) + frac(partial cal(F) ( upright(bold(U)) ), partial x) + frac(partial cal(G) ( upright(bold(U)) ), partial y) + frac(partial cal(H) ( upright(bold(U)) ), partial z) = 0 . $<eq:DiffConsLaw1>


The convective physical fluxes $cal(F)$, $cal(G)$, and $cal(H)$ are defined as


$ cal(F) ( upright(bold(U)) ) = vec(rho u, rho u^2 + p, rho u v, rho u w, u ( E + p )) , quad cal(G) ( upright(bold(U)) ) = vec(rho v, rho v u, rho v^2 + p, rho v w, v ( E + p )) , quad cal(H) ( upright(bold(U)) ) = vec(rho w, rho w u, rho w v, rho w^2 + p, w ( E + p )) . $


This set of equations must be closed by an equation of state (EOS) which relates pressure with density and internal energy, i.e., $p = p ( rho , e )$. Unless specified otherwise, we use the stiffened gas equation


$ p ( rho , e ) = ( gamma - 1 ) rho e - gamma B , $<eq:StiffenedGas>


where $gamma$ represents the ratio of specific heats and $B$ is the background pressure.


The compressible Navier-Stokes equations can be seen as the viscous extension of the Euler equations. As before, we write them in terms of the conservative state vector $upright(bold(U))$,


$ frac(partial upright(bold(U)), partial t) + frac(partial cal(F) ( upright(bold(U)) ), partial x) + frac(partial cal(G) ( upright(bold(U)) ), partial y) + frac(partial cal(H) ( upright(bold(U)) ), partial z) = frac(partial cal(F)^d ( upright(bold(U)) ), partial x) + frac(partial cal(G)^d ( upright(bold(U)) ), partial y) + frac(partial cal(H)^d ( upright(bold(U)) ), partial z) + S ( upright(bold(U)) ) . $<eq:DiffConsLaw2>


Here, we have additionally introduced the dissipative fluxes $cal(F)^d$, $cal(G)^d$, and $cal(H)^d$ and the source term vector $S ( upright(bold(U)) )$ on the right-hand side. The dissipative fluxes describe viscous effects and heat conduction, and are given by


$ cal(F)^d ( upright(bold(U)) ) = vec(0, tau^11, tau^12, tau^13, sum_i u_i tau^(1 i) - q_1) , quad cal(G)^d ( upright(bold(U)) ) = vec(0, tau^21, tau^22, tau^23, sum_i u_i tau^(2 i) - q_2) , quad cal(H)^d ( upright(bold(U)) ) = vec(0, tau^31, tau^32, tau^33, sum_i u_i tau^(3 i) - q_3) . $


The stresses $tau^(i j)$ are given by


$ tau^(i j) = mu (frac(partial u_i, partial x_j) + frac(partial u_j, partial x_i)) - 2 / 3 mu delta_(i j) frac(partial u_k, partial x_k) . $


$mu$ is the dynamic viscosity. The energy flux vector $upright(bold(q))$ can be expressed via Fourier's heat conduction law, $upright(bold(q)) = \[ q_1 , q_2 , q_3 \]^T = - lambda nabla T$. $lambda$ is the heat conductivity. The source terms $S ( upright(bold(U)) )$ represent body forces or heat sources. The body force resulting from gravitational acceleration $upright(bold(g)) = \[ g_1 , g_2 , g_3 \]^T$ is given by $ S ( upright(bold(U)) ) = vec(0, rho upright(bold(g)), rho upright(bold(u)) dot.op upright(bold(g))) . $


In @tab:Nondimensionalization, we summarize the nomenclature and the reference values with which we non-dimensionalize aforementioned equations.


#figure(text(size: 9pt, align(center)[#table(
    columns: 3,
    align: (left,left,left,),
    table.header([Quantitiy], [Nomenclature], [Reference quantity],),
    table.hline(),
    [Density], [$rho$], [$rho_(r e f)$],
    [Length], [$( x , y , z )$ or $( x_1 , x_2 , x_3 )$], [$l_(r e f)$],
    [Velocity], [$( u , v , w )$ or $( u_1 , u_2 , u_3 )$], [$u_(r e f)$],
    [Temperature], [$T$], [$T_(r e f)$],
    [Time], [$t$], [$t_(r e f) = l_(r e f) / u_(r e f)$],
    [Pressure], [$p$], [$p_(r e f) = rho_(r e f) u_(r e f)^2$],
    [Viscosity], [$mu$], [$mu_(r e f) = rho_(r e f) u_(r e f) l_(r e f)$],
    [Surface tension coefficient], [$sigma$], [$sigma_(r e f) = rho_(r e f) u_(r e f)^2 l_(r e f)$],
    [Thermal conductivity], [$lambda$], [$lambda_(r e f) = rho_(r e f) u_(r e f)^3 l_(r e f) / T_(r e f)$],
    [Gravitation], [$g$], [$g_(r e f) = u_(r e f)^2 / l_(r e f)$],
    [Specific gas constant], [$cal(R)$], [$cal(R)_(r e f) = u_(r e f)^2 / T_(r e f)$],
    [Mass], [$m$], [$m_(r e f) = rho_(r e f) l_(r e f)^3$],
    [Mass flow], [$dot(m)$], [$dot(m)_(r e f) = m_(r e f) / t_(r e f) = rho_(r e f) u_(r e f) l_(r e f)^2$],
  )]), caption: [Overview on nomenclature and nondimensionalization.]
  , kind: table
  )
<tab:Nondimensionalization>



= Numerical Model
<sec:numericalmodel>


In this section we detail the numerical methods of JAX-FLUIDS. @tab:NumericalMethods provides an overview on the implemented numerical methods.


== Finite-Volume Discretization
<subsec:FVD>


The differential form of the conservation law in Equations #link(<eq:DiffConsLaw1>)[\[eq:DiffConsLaw1\]] and #link(<eq:DiffConsLaw2>)[\[eq:DiffConsLaw2\]] assume smooth solutions for which partial derivatives exist. In practice, we solve the integral form of the partial differential equations using the finite-volume method. We use cuboid cells on a Cartesian grid. In general, cell $( i , j , k )$ has spatial extension $Delta x$, $Delta y$, and $Delta z$ in the spatial dimensions $x$, $y$, and $z$, respectively. We denote the corresponding cell volume as $V = Delta x Delta y Delta z$. Often, we use cubic cells for which $Delta x = Delta y = Delta z$.


In the finite-volume formulation we are interested in the spatio-temporal distribution of cell-averaged values which are defined by


$ macron(upright(bold(U)))_(i , j , k) = 1 / V integral_(x_(i - 1 / 2 , j , k))^(x_(i + 1 / 2 , j , k)) integral_(y_(i , j - 1 / 2 , k))^(y_(i , j + 1 / 2 , k)) integral_(z_(i , j , k - 1 / 2))^(z_(i , j , k + 1 / 2)) upright(bold(U)) upright("d") x upright("d") y upright("d") z . $


After application of volume integration to Equation #link(<eq:DiffConsLaw2>)[\[eq:DiffConsLaw2\]], the temporal evolution of the cell-averaged value in cell $( i , j , k )$ is given by


$ frac(upright("d"), upright("d") t) macron(upright(bold(U)))_(i , j , k) = & - frac(1, Delta x) (upright(bold(F))_(i + 1 / 2 , j , k) - upright(bold(F))_(i - 1 / 2 , j , k))\
 & - frac(1, Delta y) (upright(bold(G))_(i , j + 1 / 2 , k) - upright(bold(G))_(i , j - 1 / 2 , k))\
 & - frac(1, Delta z) (upright(bold(H))_(i , j , k + 1 / 2) - upright(bold(H))_(i , j , k - 1 / 2))\
 & + frac(1, Delta x) (upright(bold(F))_(i + 1 / 2 , j , k)^d - upright(bold(F))_(i - 1 / 2 , j , k)^d)\
 & + frac(1, Delta y) (upright(bold(G))_(i , j + 1 / 2 , k)^d - upright(bold(G))_(i , j - 1 / 2 , k)^d)\
 & + frac(1, Delta z) (upright(bold(H))_(i , j , k + 1 / 2)^d - upright(bold(H))_(i , j , k - 1 / 2)^d)\
 & + macron(upright(bold(S)))_(i , j , k) . $<eq:FVD>


$upright(bold(F))$, $upright(bold(G))$, and $upright(bold(H))$ are the convective intercell numerical fluxes across the cell faces in $x$-, $y$-, and $z$-direction, and $upright(bold(F))^d$, $upright(bold(G))^d$, and $upright(bold(H))^d$ are the numerical approximations to the dissipative fluxes in $x$-, $y$-, and $z$-direction. $macron(upright(bold(S)))_(i , j , k)$ is the cell-averaged source term. Note that the convective and dissipative fluxes in Equation #link(<eq:FVD>)[\[eq:FVD\]] are cell face averaged quantities. We use a simple one-point Gaussian quadrature to evaluate the necessary cell face integrals, however approximations of higher order are also possible, see for example #text([]). For the calculation of the convective intercell numerical fluxes, we use WENO-type high-order discretization schemes #text([]) in combination with approximate Riemann solvers. Subsection @subsec:InviscidFlux provides more details.


Dissipative fluxes are calculated by central finite-differences, see Subsection @subsec:Dissipative for details. Multidimensional settings are treated via the dimension-by-dimension technique in a straightforward manner, i.e., aforementioned steps are repeated for each spatial dimension separately.


== Time Integration
<subsec:timeint>
The finite-volume discretization yields a set of ordinary differential equations (ODEs) #link(<eq:FVD>)[\[eq:FVD\]] that can be integrated in time by an ODE solver of choice. We typically use explicit total-variation diminishing (TVD) Runge-Kutta methods #text([]). The time step size is given by the $C F L$ criterion as described in #text([]).


== Convective Flux Calculation
<subsec:InviscidFlux>
For the calculation of the convective fluxes an approximative solution to a Riemann problem has to be found at each cell face. As we make use of the dimension-by-dimension technique, without loss of generality, we restrict ourselves to a one-dimensional setting in this subsection. We are interested in finding the cell face flux $upright(bold(F))_(i + 1 / 2)$ at the cell face $x_(i + 1 / 2)$.


We distinguish between two different methods for the calculation of the convective intercell fluxes: the #emph[High-order Godunov] approach and the #emph[Flux-splitting] approach. In the #emph[High-order Godunov] approach, we first reconstruct flow states left and right of a cell face, and subsequently enter an approximate Riemann solver for the calculation of the convective intercell flux. In the #emph[Flux-splitting] approach, we first perform cell-wise flux-splitting, reconstruct left and right going fluxes for each cell face, and subsequently assemble the final flux. In the following, we briefly sketch both methods. \


#emph[High-order Godunov approach]

+ Apply WENO reconstruction on the primitive variable $upright(bold(W))_i$/the conservative variable $upright(bold(U))_i$ to obtain the cell face quantities $upright(bold(W))_(i + 1 / 2)^plus.minus$/$upright(bold(U))_(i + 1 / 2)^plus.minus$. Note that the reconstruction can be done directly in physical space or via transformation in characteristic space. High-order reconstruction in physical space can lead to spurious oscillations due to the interaction of discontinuities in different fields #text([]).

+ Transform the reconstructed primitive/conservative variables at the cell face into conservative/primitive cell face quantities: $upright(bold(W))_(i + 1 / 2)^plus.minus arrow.r upright(bold(U))_(i + 1 / 2)^plus.minus$ / $upright(bold(U))_(i + 1 / 2)^plus.minus arrow.r upright(bold(W))_(i + 1 / 2)^plus.minus$.

+ Compute the final flux with an appropriate flux function/approximate Riemann solver, e.g., HLL #text([]) or HLLC #text([]) $ upright(bold(F))_(i + 1 / 2) = upright(bold(F))_(i + 1 / 2) (upright(bold(U))_(i + 1 / 2)^(-) , upright(bold(U))_(i + 1 / 2)^(+) , upright(bold(W))_(i + 1 / 2)^(-) , upright(bold(W))_(i + 1 / 2)^(+)) $<eq:ApproxRiemannSolver>


#emph[Flux-Splitting approach]

+ At the cell face $x_(i + 1 / 2)$ compute an appropriate average state from neighboring cells $upright(bold(U))_(i + 1 / 2) = upright(bold(U))_(i + 1 / 2) (upright(bold(U))_i , upright(bold(U))_(i + 1))$ (e.g., by arithmetic mean or Roe average #text([])) and the corresponding Jacobian $upright(bold(A))_(i + 1 / 2) = upright(bold(A))_(i + 1 / 2) (upright(bold(U))_(i + 1 / 2))$.

+ Eigenvalue decomposition of the Jacobian: $upright(bold(A))_(i + 1 / 2) = upright(bold(R))_(i + 1 / 2) upright(bold(Lambda))_(i + 1 / 2) upright(bold(R))_(i + 1 / 2)^(- 1)$, with the matrix of right eigenvectors $upright(bold(R))_(i + 1 / 2)$, the matrix of left eigenvectors $upright(bold(R))_(i + 1 / 2)^(- 1)$, and the eigenvalues $upright(bold(Lambda))_(i + 1 / 2)$.

+ Transform the cell state $upright(bold(U))_i$ and the flux $upright(bold(F))_i$ to characteristic space: $upright(bold(V))_j = upright(bold(R))_(i + 1 / 2)^(- 1) upright(bold(U))_i , quad upright(bold(G))_j = upright(bold(R))_(i + 1 / 2)^(- 1) upright(bold(F))_i$.

+ Perform the user-specified flux splitting: $hat(upright(bold(G)))_i^plus.minus = 1 / 2 (upright(bold(G))_i plus.minus macron(upright(bold(Lambda)))_(i + 1 / 2) upright(bold(V))_i)$, where $macron(upright(bold(Lambda)))_(i + 1 / 2)$ is the eigenvalue matrix of the respective flux-splitting scheme.

+ Apply WENO reconstruction on $hat(upright(bold(G)))_i^plus.minus$ to obtain $hat(upright(bold(G)))_(i + 1 / 2)^plus.minus$ at the cell face $x_(i + 1 / 2)$.

+ Assemble the final flux in characteristic space: $hat(upright(bold(G)))_(i + 1 / 2) = hat(upright(bold(G)))_(i + 1 / 2)^(+) + hat(upright(bold(G)))_(i + 1 / 2)^(-)$.

+ Transform the final flux back to physical space: $upright(bold(F))_(i + 1 / 2) = upright(bold(R))_(i + 1 / 2) hat(upright(bold(G)))_(i + 1 / 2)$.


== Dissipative Flux Calculation
<subsec:Dissipative>
For the calculation of the dissipative fluxes, we have to evaluate derivatives at the cell faces. We do this using central finite-differences. As we do all computations in a Cartesian framework, central finite-differences can be evaluated directly at a cell face if the direction of the derivative is parallel to the cell face normal. For example, at the cell face $x_(i + 1 / 2 , j , k)$ the $x$-derivative of any quantity $psi$ is directly approximated with second-order or fourth-order central finite-differences,


$ frac(partial psi, partial x)\|_(x_(i + 1 / 2 , j , k))^(C 2) = frac(- psi_(i , j , k) + psi_(i + 1 , j , k), Delta x) , quad frac(partial psi, partial x)\|_(x_(i + 1 / 2 , j , k))^(C 4) = frac(psi_(i - 1 , j , k) - 27 psi_(i , j , k) + 27 psi_(i + 1 , j , k) - psi_(i + 2 , j , k), 24 Delta x) . $


If the cell face normal is perpendicular to the direction of the derivative, we use a two-step process to approximate the derivative. We first evaluate the derivative at the cell-centers and then use a central interpolation to obtain the value at the cell face of interest. Again, we use second-order or fourth-order order central finite-differences for the derivatives. Let us consider the $y$-derivative of the quantity $psi$ at the cell face $x_(i + 1 / 2 , j , k)$ (the $z$-derivative is complelety analogous). We first calculate the derivative at the cell centers


$ frac(partial psi, partial y)\|_(x_(i , j , k))^(C 2) = frac(- psi_(i , j - 1 , k) + psi_(i , j + 1 , k), Delta y) , quad frac(partial psi, partial y)\|_(x_(i , j , k))^(C 4) = frac(psi_(i , j - 2 , k) - 8 psi_(i , j - 1 , k) + 8 psi_(i , j + 1 , k) - psi_(i , j + 2 , k), 12 Delta y) . $


We subsequently interpolate these values to the cell face,


$  & frac(partial psi, partial y)\|_(x_(i + 1 / 2 , j , k)) = 1 / 2 (frac(partial psi, partial y)\|_(x_(i - 1 , j , k)) + frac(partial psi, partial y)\|_(x_(i + 1 , j , k))) ,\
 & frac(partial psi, partial y)\|_(x_(i + 1 / 2 , j , k)) = 1 / 16 (- frac(partial psi, partial y)\|_(x_(i - 2 , j , k)) + 9 frac(partial psi, partial y)\|_(x_(i - 1 , j , k)) + 9 frac(partial psi, partial y)\|_(x_(i + 1 , j , k)) - frac(partial psi, partial y)\|_(x_(i + 2 , j , k))) . $


== Source Terms and Forcings
<subsec:forcing>


The source terms $S ( upright(bold(U)) )$ represent body forces and heat sources. We use them to impose physical constraints, e.g., fixed mass flow rates or temperature profiles. These forcings are required to simulate a variety of test cases. Examples include channel flows or driven homogenous isotropic turbulence. Fixed mass flow rates are enforced with a PID controller minimizing the error between target and current mass flow rate $e ( t ) = frac(dot(m)_(upright("target")) - dot(m) ( t ), dot(m)_(upright("target")))$. Here, the control variable is an acceleration $a_(dot(m))$ that drives the fluid in the prescribed direction. We denote the unit vector pointing towards the prescribed direction as $upright(bold(N))$. The controller variable and resulting source terms read $ a_(dot(m)) = K_p e ( t ) + K_I integral_0^t e ( tau ) upright("d") tau + K_d frac(upright("d") e ( t ), upright("d") t) , #h(2em) S ( upright(bold(U)) ) = vec(0, rho a_(dot(m)) upright(bold(N)), rho a_(dot(m)) upright(bold(u)) dot.op upright(bold(N))) , $<eq:PID_massflow> where $K_p$, $K_I$, and $K_d$ are the controller parameters. The integral and derivative in Equation #link(<eq:PID_massflow>)[\[eq:PID\_massflow\]] are approximated with first order schemes. Fixed temperature profiles are enforced with a heat source $dot(omega)_T$. The heat source and resulting source term is given by $ dot(omega)_T = rho R frac(gamma, gamma - 1) frac(T_(upright("target")) - T, Delta t) , #h(2em) S ( upright(bold(U)) ) = dot(omega)_T \[ 0 , 0 , 0 , 0 , 1 \]^T . $


== Level-set Method for Two-phase Flows
<subsec:levelset>
We use the level-set method #text([]) to model two-phase flows with fluid-fluid and fluid-solid interfaces. In particular, we implement the sharp-interface level-set method proposed by Hu et al. #text([]), which is also used in the solver ALPACA #text([]) #text([]). The interface is tracked by a scalar field $phi.alt$ whose values represent the signed distance from the interface of each cell center within the mesh of the finite-volume discretization. This implies that there is a positive phase ($phi.alt > 0$) and a negative phase ($phi.alt < 0$) with the interface being located at the zero level-set of $phi.alt$. A cell that is intersected by the interface is referred to as cut cell. @fig:cut_cell shows a schematic of a cut cell in the finite-volume discretization. The apertures $A_(i plus.minus 1 / 2 , j , k)$, $A_(i , j plus.minus 1 / 2 , k)$, and $A_(i , j , k plus.minus 1 / 2)$ represent the portion of the cell face area that is covered by the respective fluid. The volume fraction $alpha_(i , j , k)$ denotes the portion of the cell volume covered by the respective fluid. Hereinafter, we will refer to the positive phase with the subscript 1 and to the negative phase with the subscript 2. The following relations between the geometrical quantities for the positive and negative phase apply: $ alpha_1 = 1 - alpha_2 , quad A_1 = 1 - A_2 . $<eq:posnegphase>


#figure([],
  caption: [
    Schematic finite-volume discretization for cut cell $( i , j , k )$ on a Cartesian grid. The red dots represent the cell centers. The red line indicates the interface, and the blue line gives the linear approximation of the interface. The fluid with positive level-set values is colored in gray, and the fluid with negative level-set values is colored in white. Volume fraction and apertures are computed for the positive fluid. Note that the figure illustrates a two-dimensional slice in the $( x , y )$-plane. (For interpretation of the references to color in this figure legend, the reader is referred to the web version of this article.)
  ]
)
<fig:cut_cell>



We solve Equation #link(<eq:FVD>)[\[eq:FVD\]] for both phases separately. However, in a cut cell $( i , j , k )$, the equation is modified as follows. $ frac(upright("d"), upright("d") t) alpha_(i , j , k) macron(upright(bold(U)))_(i , j , k) = & - frac(1, Delta x) [A_(i + 1 / 2 , j , k) (upright(bold(F))_(i + 1 / 2 , j , k) + upright(bold(F))_(i + 1 / 2 , j , k)^d) - A_(i - 1 / 2 , j , k) (upright(bold(F))_(i - 1 / 2 , j , k) + upright(bold(F))_(i - 1 / 2 , j , k)^d)]\
 & - frac(1, Delta y) [A_(i , j + 1 / 2 , k) (upright(bold(G))_(i , j + 1 / 2 , k) + upright(bold(G))_(i , j + 1 / 2 , k)^d) - A_(i , j - 1 / 2 , k) (upright(bold(G))_(i , j - 1 / 2 , k) + upright(bold(G))_(i , j - 1 / 2 , k)^d)]\
 & - frac(1, Delta z) [A_(i , j , k + 1 / 2) (upright(bold(H))_(i , j , k + 1 / 2) + upright(bold(H))_(i , j , k + 1 / 2)^d) - A_(i , j , k - 1 / 2) (upright(bold(H))_(i , j , k - 1 / 2) + upright(bold(H))_(i , j , k - 1 / 2)^d)]\
 & + alpha_(i , j , k) macron(upright(bold(S)))_(i , j , k)\
 & - frac(1, Delta x Delta y Delta z) [upright(bold(X))_(i , j , k) ( Delta Gamma ) + upright(bold(X))_(i , j , k)^d ( Delta Gamma )] $<eq:FVD_levelset>


The cell-averaged state and the intercell fluxes must be weighted with the volume fraction and the cell face apertures, respectively. The terms $upright(bold(X)) ( Delta Gamma )$ and $upright(bold(X))^d ( Delta Gamma )$ denote the convective and dissipative interface flux, with $Delta Gamma$ being the interface segment length. We define the projections of the interface segment length on the $x$, $y$, and $z$ direction as the vector $ Delta upright(bold(Gamma))_p = vec(Delta Gamma ( upright(bold(i)) dot.op upright(bold(n))_I ), Delta Gamma ( upright(bold(j)) dot.op upright(bold(n))_I ), Delta Gamma ( upright(bold(k)) dot.op upright(bold(n))_I ), ) , #h(2em) $<eq:interface_segment_projection> where $upright(bold(i))$, $upright(bold(j))$, and $upright(bold(k))$ represent the unit vectors in $x$, $y$, and $z$ direction, respectively. The interface normal is given by $upright(bold(n))_I = nabla phi.alt / \| nabla phi.alt \|$. The interface fluxes read $ upright(bold(X)) = vec(0, p_I Delta upright(bold(Gamma))_p, p_I Delta upright(bold(Gamma))_p dot.op upright(bold(u))_I) , #h(2em) upright(bold(X))^d = vec(0, upright(bold(tau))_I^T Delta upright(bold(Gamma))_p, ( upright(bold(tau))_I^T Delta upright(bold(Gamma))_p ) dot.op upright(bold(u))_I - upright(bold(q))_I dot.op Delta upright(bold(Gamma))_p) . $<eq:interface_flux> Here, $p_I$ and $upright(bold(u))_I$ denote the interface pressure and interface velocity. The viscous interface stress tensor $upright(bold(tau))_I$ is given by $ upright(bold(tau))_I = mat(delim: "(", tau_I^11, tau_I^12, tau_I^13; tau_I^21, tau_I^22, tau_I^23; tau_I^31, tau_I^32, tau_I^33; #none) , #h(2em) tau_I^(i j) = mu_I (frac(partial u_i, partial x_j) + frac(partial u_j, partial x_i)) - 2 / 3 mu_I delta_(i j) frac(partial u_k, partial x_k) , #h(2em) mu_I = frac(mu_1 mu_2, alpha_1 mu_2 + alpha_2 mu_1) . $ The interface heat flux $upright(bold(q))_I$ reads $ upright(bold(q))_I = - lambda_I nabla T , #h(2em) lambda_I = frac(lambda_1 lambda_2, alpha_1 lambda_2 + alpha_2 lambda_1) . $ The evaluation of $upright(bold(tau))_I$ and $upright(bold(q))_I$ requires the computation of velocity and temperature gradients at the interface. The gradient at the interface is approximated with the gradient at the cell center. We use the real fluid state to evaluate these gradients. The real fluid state in a cut cell is approximated by $upright(bold(W)) = alpha_1 upright(bold(W))_1 + alpha_2 upright(bold(W))_2$. As we solve Equations #link(<eq:FVD_levelset>)[\[eq:FVD\_levelset\]] and #link(<eq:interface_segment_projection>)[\[eq:interface\_segment\_projection\]] for each phase separately, we emphasize that $upright(bold(n))_I$, $alpha$, and $A$ must be computed with respect to the present phase. Conservation is therefore satisfied since $upright(bold(n))_(I 1) = - upright(bold(n))_(I 2)$, i.e., the interface flux terms for the two fluids at the interface have the same magnitude but opposite sign. The computation of the interface velocity $upright(bold(u))_I$ and interface pressure $p_I$ depends on the type of interface interaction:

- For #strong[fluid-solid] interactions, the interface velocity is prescribed as either a constant or a space and time-dependent function. The interface pressure $p_I$ is approximated with the cell pressure.

- For #strong[fluid-fluid] interactions, the two-material Riemann problem at the interface is solved. The solution reads #text([]) \$\$\\begin{align}
          \bold(u)\_I &= \\frac{\\rho\_1c\_1 \bold(u)\_1\⋯ \bold(n)\_{I1} + \\rho\_2c\_2 \bold(u)\_2\⋯ \bold(n)\_{I1} + p\_2 - p\_1 - \\sigma \\kappa}{\\rho\_1c\_1 + \\rho\_2c\_2} \bold(n)\_{I1}, \\notag \\\\
          p\_{I1} &= \\frac{\\rho\_1c\_1(p\_2 + \\sigma \\kappa) + \\rho\_2c\_2p\_1 + \\rho\_1c\_1\\rho\_2c\_2(\bold(u)\_2\⋯ \bold(n)\_{I1} - \bold(u)\_1\⋯ \bold(n)\_{I1})}{\\rho\_1c\_1 + \\rho\_2c\_2}, \\\\
          p\_{I2} &= \\frac{\\rho\_1c\_1p\_2 + \\rho\_2c\_2(p\_1 - \\sigma \\kappa) + \\rho\_1c\_1\\rho\_2c\_2(\bold(u)\_2\⋯ \bold(n)\_{I1} - \bold(u)\_1\⋯ \bold(n)\_{I1})}{\\rho\_1c\_1 + \\rho\_2c\_2}, \\notag
  \\end{align}\$\$ where $c$ denotes the speed of sound, $sigma$ is the surface tension coefficient, and $kappa = nabla dot.op upright(bold(n))_(I 1)$ denotes the curvature. For $sigma eq.not 0$ and $kappa eq.not 0$, the interface pressure experiences a jump at the interface as constituted by mechanical equilibrium. The interface pressure in Equation #link(<eq:interface_flux>)[\[eq:interface\_flux\]] must be chosen with respect to the present phase.


Assuming a linear interface within each cut cell, the cell face apertures are computed analytically as follows. The level-set values at the edges of a computational cell are computed using trilinear interpolation. The sign of the level-set values at the four corners of a cell face determine the cut cell face configuration. @fig:cut_cell_face illustrates three typical cases of a cell face that is intersected by the interface. In total, there are $2^4$ different sign combinations of the level-set values along the corners. Hence, there are $2^4$ different cut cell face configurations. For each of these, the cell face aperture is evaluated as the (sum of) areas of the basic geometric shapes, i.e., triangle or trapezoid.


#figure([
#figure(text(‹TikZ source: figures/tikz_0.tex›), caption: [TikZ figure 0])


  ],
  caption: [
    Three typical cut cell face configurations. Solid and hollow blue circles indicate positive and negative level-set corner values, respectively.
  ]
)
<fig:cut_cell_face>



The interface segment length $Delta Gamma$ is computed from the apertures as follows. $ Delta Gamma_(i , j , k) = [( A_(i + 1 / 2 , j , k) - A_(i - 1 / 2 , j , k) )^2 Delta y Delta z + ( A_(i , j + 1 / 2 , k) - A_(i , j - 1 / 2 , k) )^2 Delta x Delta z + ( A_(i , j , k + 1 / 2) - A_(i , j , k - 1 / 2) )^2 Delta x Delta y]^(1 / 2) $ Geometrical reconstruction with seven pyramids yields the volume fraction $alpha$. \$\$\\begin{align}
    \\alpha\_{i,j,k} &= \\frac{1}{3} \\frac{1}{\\Delta x \\Delta y \\Delta z} \\left\[ A\_{i+\\frac{1}{2},j,k} \\Delta y \\Delta z \\frac{1}{2} \\Delta x +  A\_{i-\\frac{1}{2},j,k} \\Delta y \\Delta z \\frac{1}{2} \\Delta x  + A\_{i,j+\\frac{1}{2},k} \\Delta x \\Delta z \\frac{1}{2} \\Delta y \\right. \\notag \\\\
    &+ \\left. A\_{i,j-\\frac{1}{2},k} \\Delta x \\Delta z \\frac{1}{2} \\Delta y + A\_{i,j,k-\\frac{1}{2}} \\Delta x \\Delta y \\frac{1}{2} \\Delta z + A\_{i,j,k+\\frac{1}{2}} \\Delta x \\Delta y \\frac{1}{2} \\Delta z + \\Delta \\Gamma\_{i,j,k} \\phi\_{i,j,k}  \\right\]
\\end{align}\$\$ Note that the described approach yields the volume fraction and apertures with respect to the positive phase. The values of the negative phase can be obtained from relations #link(<eq:posnegphase>)[\[eq:posnegphase\]].


The level-set field is advected by the interface velocity $upright(bold(u))_I = upright(bold(n))_I u_I$ by solving the level-set advection equation. $ frac(partial phi.alt, partial t) + upright(bold(u))_I dot.op nabla phi.alt = 0 $<eq:levelset_advection> The spatial term in Equation #link(<eq:levelset_advection>)[\[eq:levelset\_advection\]] is discretized using high-order upstream central (HOUC) #text([]) stencils. For the temporal integration, we apply the same scheme that is used to integrate the conservative variables, which typically is a Runge-Kutta method, see Subsection @subsec:timeint. The level-set field is only advected within a narrowband around the interface.


In order to apply the reconstruction stencils used in the finite-volume discretization near the interface, we extrapolate the real fluid state to the other side of the interface. We denote the cells on the other side of the interface as ghost cells. An arbitrary quantity $psi$ is extrapolated from the real cells to the ghost cells by advancing it in a fictitious time $tau$ to steady state according to $ frac(partial psi, partial tau) plus.minus upright(bold(n))_I dot.op nabla psi = 0 . $<eq:extension> The sign of the interface normal $plus.minus upright(bold(n))_I$ depends on the sign of the present phase: To extrapolate the real fluid state of the positive phase into its ghost cells, we must extrapolate into the direction of the negative level-set, i.e. $- upright(bold(n))_I$, and vice versa. The spatial term is discretized using a first-order upwind stencil. Temporal integration is performed with the Euler method. Note that we also use this extension procedure to extend the interface velocity from the cut cells into the narrowband around the interface, where we advect the level-set field.


The computation of the geometrical quantities requires the level-set field to be a signed distance function. During a simulation, the level-set field loses its signed distance property due to numerical errors and/or a shearing flow field. Additionally, since we only advect the level-set field within a narrowband around the interface, the level-set field develops a kink at the edge of the narrowband and the remainder of the computational domain. The signed distance property is maintained via reinitialization of the level-set field. The reinitialization equation reads $ frac(partial phi.alt, partial tau) + s g n ( phi.alt^0 ) ( \| nabla phi.alt \| - 1 ) = 0 . $<eq:reinitialization> Here, $phi.alt^0$ represents the level-set at a fictitious time $tau = 0$. We apply first-order #text([]) or higher-order WENO-HJ #text([]) schemes to solve this equation. We reinitialize the level-set each physical time step for a fixed amount of fictitious time steps resulting in a sufficiently small residual of Equation #link(<eq:reinitialization>)[\[eq:reinitialization\]].


The presented level-set method is not consistent when the interface crosses a cell face within a single time step, i.e., when new fluid cells are created or fluid cells have vanished. @fig:mixing displays this scenario for a 1D discretization. The interface is moving from cell $i - 1$ to cell $i$. At $t^n$, cell $i$ is a newly created cell w.r.t. phase 1 and cell $i - 1$ is a vanished cell w.r.t. phase 2. To maintain conservation, we must do the following. For phase 1, conservative variables must be taken from cell $i - 1$ and put into the newly created cell $i$. For phase 2, conservative variables must be taken from cell $i$ and put into the vanished cell $i - 1$. In addition to the scenario where an interface crosses the cell face, small cut cells may generally lead to an unstable integration using the time step restriction that is based on a full cell. We apply a mixing procedure #text([]) that deals with these problems. The procedure is applied to two types of cells.

+ Cells where $alpha = 0$ after integration but $alpha eq.not 0$ before (vanished cells).

+ Cells with $alpha < alpha_(upright("mix"))$ after integration (newly created cells and small cells).

We use a mixing threshold of $alpha_(upright("mix")) = 0.6$. For each cell that requires mixing, we identify target (trg) cells from the interface normal. Consider cell $i$ in @fig:mixing, which is a small/newly created cell for phase 1. Here, the target cell in $x$ direction is cell $i - 1$, as $upright(bold(n))_(I 1) dot.op upright(bold(i)) < 0$. Analogously, cell $i - 1$ is a vanished cell for phase 2. The corresponding target is cell $i$, since $upright(bold(n))_(I 2) dot.op upright(bold(i)) > 0$. In 3D, there are 7 target cells in total: One in each spatial direction $x$, $y$, and $z$, one in each plane $x y$, $x z$, and $y z$, and one in $x y z$. Seven mixing weights are computed as \$\$\\begin{align}
    \\beta\_x &= |\bold(n)\_I\⋯ \bold(i)|^2 \\alpha\_{trg}, \\notag \\\\
    \\beta\_y &= |\bold(n)\_I\⋯ \bold(j)|^2 \\alpha\_{trg}, \\notag \\\\
    \\beta\_z &= |\bold(n)\_I\⋯ \bold(k)|^2 \\alpha\_{trg}, \\notag \\\\
    \\beta\_{xy} &= |\\left(\bold(n)\_I\⋯ \bold(i)\\right) \\left(\bold(n)\_I\⋯ \bold(j)\\right) | \\alpha\_{trg}, \\\\
    \\beta\_{xz} &= |\\left(\bold(n)\_I\⋯ \bold(i)\\right) \\left(\bold(n)\_I\⋯ \bold(k)\\right) | \\alpha\_{trg}, \\notag \\\\
    \\beta\_{yz} &= |\\left(\bold(n)\_I\⋯ \bold(j)\\right) \\left(\bold(n)\_I\⋯ \bold(k)\\right) | \\alpha\_{trg}, \\notag \\\\
    \\beta\_{xyz} &= |\\left(\bold(n)\_I\⋯ \bold(i)\\right) \\left(\bold(n)\_I\⋯ \bold(j)\\right) \\left(\bold(n)\_I\⋯ \bold(k)\\right) |^{2/3} \\alpha\_{trg}. \\notag
\\end{align}\$\$ Here, $alpha_(t r g)$ denotes the volume fraction of the target cell in the corresponding direction. We normalize the mixing weights so that $sum_(t r g) beta_(t r g) = 1$, where $t r g in ( x , y , z , x y , x z , y z , x y z )$. Subsequently, the mixing flux $upright(bold(M))_(t r g)$ is computed like $ upright(bold(M))_(t r g) = frac(beta_(t r g), alpha beta_(t r g) + alpha_(t r g)) [( alpha_(t r g) macron(upright(bold(U)))_(t r g) ) alpha - ( alpha macron(upright(bold(U))) ) alpha_(t r g)] . $ The conservative variables are then updated according to $ alpha macron(upright(bold(U))) & = (alpha macron(upright(bold(U))))^(*) + sum_(t r g) upright(bold(M))_(t r g) ,\
alpha_(t r g) macron(upright(bold(U)))_(t r g) & = (alpha_(t r g) macron(upright(bold(U)))_(t r g))^(*) - sum_(t r g) upright(bold(M))_(t r g) . $ Here, $alpha macron(upright(bold(U)))$ and $alpha_(t r g) macron(upright(bold(U)))_(t r g)$ denote the conservative variables of the cells that require mixing and the conservative variables of the corresponding target cells, respectively. Star-quantities denote conservative variables before mixing.


#figure([
#figure(text(‹TikZ source: figures/tikz_1.tex›), caption: [TikZ figure 1])


  ],
  caption: [
    Schematic illustrating the mixing procedure in a 1D discretization at $t^n$. Red and blue color indicate the positive and negative phases. Green indicates interface positions $Gamma_0$ at $t^(n - 1)$ and $t^n$.
  ]
)
<fig:mixing>



== Computational Domain and Boundary Conditions
<computational-domain-and-boundary-conditions>


The computational domain is a cuboid. @fig:computational_domain depicts an exemplary computational domain including the nomenclature for the boundary locations. The solver provides symmetry, periodic, no-slip wall, Dirichlet, and Neumann boundary conditions. The no-slip wall boundary condition allows the user to specify either a constant value or time-dependent function for the wall velocity. The Dirichlet and Neumann boundary conditions allow the user to specify either a constant value or a space and time-dependent function.


Furthermore, (in 2D only) multiple different types of boundary conditions may be imposed along a single boundary location. Here, the user must specify the starting and end point of each of the different boundary types along the specific boundary location. The level-set implementation allows for arbitrary immersed solid boundaries.


#figure([
#figure(text(‹TikZ source: figures/tikz_2.tex›), caption: [TikZ figure 2])


  ],
  caption: [
    Computational domain with boundary locations.
  ]
)
<fig:computational_domain>



#figure([], caption: [Overview on numerical methods available in JAX-FLUIDS.]
  , kind: table
  )
<tab:NumericalMethods>



#text(size: 8pt)[#align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    [Time Integration], [Euler], [],
    [], [TVD-RK2 #text([])], [],
    [], [TVD-RK3 #text([])], [],
    [Flux Function/Riemann Solver], [Lax-Friedrichs (LxF)], [According to],
    [], [Local Lax-Friedrichs (LLxF, Rusanov)], [According to],
    [], [HLL/HLLC/HLLC-LM #text([]) #text([]) #text([]) #text([]) #text([])], [Signal speed estimates see below],
    [], [AUSM+ #text([])], [],
    [], [Componentwise LLxF], [Flux-splitting formulation],
    [], [Roe #text([])], [Flux-splitting formulation],
    [Signal Speed Estimates], [Arithmetic], [],
    [], [Davis #text([])], [],
    [], [Einfeldt #text([])], [],
    [], [Toro #text([])], [],
    [Spatial Reconstruction], [WENO1 #text([])], [],
    [], [WENO3-JS/Z/N/F3+/NN #text([]) #text([]) #text([]) #text([])], [],
    [], [WENO5-JS/Z #text([]) #text([])], [],
    [], [WENO6-CU/CUM #text([]) #text([])], [],
    [], [WENO7-JS #text([])], [],
    [], [WENO9-JS #text([])], [],
    [], [TENO5 #text([])], [],
    [], [Second-order central], [For dissipative terms only],
    [], [Fourth-order central], [For dissipative terms only],
    [Spatial Derivatives], [Second-order central], [],
    [], [Fourth-order central], [],
    [], [HOUC-3/5/7 #text([])], [],
    [Levelset reinitialization], [First-order #text([])], [],
    [], [HJ-WENO #text([])], [],
    [Ghost fluid extension], [First-order upwind #text([])], [],
    [LES Modules], [ALDM #text([])], [],
    [Equation of State], [Ideal Gas], [],
    [], [Stiffened Gas #text([])], [],
    [], [Tait #text([])], [],
    [Boundary Conditions], [Periodic], [],
    [], [Zero Gradient], [E.g., used for outflow boundaries],
    [], [Neumann], [E.g., for a prescribed heat flux],
    [], [Dirichlet], [],
    [], [No-slip Wall], [],
    [], [Immersed Solid Boundaries], [Arbitrary geometries via level-set],
  )]]


= Software Implementation Details
<sec:Implementation>


In the past, CFD solvers have been written predominantly in low-level programming languages like Fortran and C/C++. These languages offer computational performance and CPU parallelization capabilities. However, the integration of ML models, which are typically coded in Python, is not straightforward and automatic differentiation capabilities are nonexistent. With the present work, we want to provide a CFD framework that allows for seamless integration and end-to-end optimization of ML models, without major performance losses. The Python package JAX #text([]) satisfies these requirements. Therefore, we use JAX as the fundamental building block of JAX-FLUIDS. In this section, we give implementation details and the algorithmic structure of JAX-FLUIDS.


== Array Programming in JAX
<array-programming-in-jax>


JAX is a Python library for high-performance numerical computations, which uses XLA to compile and run code on accelerators like CPUs, GPUs, and TPUs. Designed as a machine learning library, JAX supports automatic differentiation #text([]). In particular, JAX comes with a fully-differentiable version of the popular NumPy package #text([]) called JAX NumPy. Both Python and NumPy are widely popular and easy to use. NumPy adds high-level functionality to handle large arrays and matrices.


The backbone of (JAX) NumPy is the multidimensional array, so called #raw(lang:"python", "jax.numpy.DeviceArray"). We use arrays to store all of our field data. In particular, the vectors of conservative and primitive variables, $upright(bold(U))$ and $upright(bold(W))$, are stored in arrays of shape $( 5 , N_x + 2 N_h , N_y + 2 N_h , N_z + 2 N_h )$. $( N_x , N_y , N_z )$ denote the resolution in the three spatial directions, and $N_h$ specifies the number of halo cells. Our implementation naturally degenerates for one- and two-dimensional settings by using only a single cell in the excess dimensions.


In the #emph[array programming paradigm] (see #text([]) for details on numerical operations on arrays in NumPy), every operation is performed on the entire array. I.e., instead of writing loops over the array as is common in Fortran or C/C++, we use appropriate indexing/slicing operations. As a result, many parts of the code used from classical CFD solvers have to be rewritten according to the #emph[array programming paradigm]. As an example we include the source code of our implementation of the second-order central cell face reconstruction scheme in Figure #text([]). The #raw(lang:"python", "class CentralSecondOrderReconstruction") inherits from #raw(lang:"python", "class SpatialReconstruction"). This parent class has an abstract member function #raw(lang:"python", "reconstruct_xi"), which must be implemented in every child class. #raw(lang:"python", "reconstruct_xi") receives the entire #raw(lang:"python", "buffer") and the reconstruction direction #raw(lang:"python", "axis") as arguments.


The data buffer has to be indexed/sliced differently depending on the spatial direction of the reconstruction and the dimensionality of the problem. Note that the buffer array has shape $( 5 , N_x + 2 N_h , N_y + 2 N_h , N_z + 2 N_h )$ if the problem is three-dimensional, $( 5 , N_x + 2 N_h , N_y + 2 N_h , 1 )$ if the problem is two-dimensional, and $( 5 , N_x + 2 N_h , 1 , 1 )$ if the problem is one-dimensional. The slice indices have to be adapted accordingly. To prevent boilerplate code in the reconstruction routine, we abstract the slicing operations. The member variable #raw(lang:"python", "self.slices") is a list that holds the correct slice objects for each spatial direction. Consider reconstructing in $x$-direction (#raw(lang:"python", "axis=0")) using the present second-order cell face reconstruction scheme, $ upright(bold(U))_(i + 1 / 2 , j , k) = 1 / 2 ( upright(bold(U))_(i , j , k) + upright(bold(U))_(i + 1 , j , k) ) . $ Here, we require two slice objects: #raw(lang:"python", "jnp.s_[...,self.nh-1:-self.nh,self.nhy,self.nhz]") for $upright(bold(U))_(i , j , k)$ and #raw(lang:"python", "jnp.s_[...,self.nh:-self.nh+1,self.nhy,self.nhz]") for $upright(bold(U))_(i + 1 , j , k)$. The variable #raw(lang:"python", "self.nh") denotes the number of halo cells. The slices in $x$-direction, i.e., #raw(lang:"python", "self.nh-1:-self.nh") and #raw(lang:"python", "self.nh:-self.nh+1"), are determined by the reconstruction scheme itself. #raw(lang:"python", "self.nhy") and #raw(lang:"python", "self.nhz") denote the slice objects for the dimensions in which we do not reconstruct. These are either #raw(lang:"python", "self.nh:-self.nh") if the dimension is active or #raw(lang:"python", "None:None") if the dimension is inactive. #raw(lang:"python", "self.nhx"), #raw(lang:"python", "self.nhy"), and #raw(lang:"python", "self.nhz") are defined in the parent class.



 figure
    
     python ./figures/code\_snippets/reconstruction\_stencil.py
     Code snippet for the second-order central cell face reconstruction stencil.
     fig:reconstruction
 figure


== Object-oriented Programming in the Functional Programming World of JAX
<object-oriented-programming-in-the-functional-programming-world-of-jax>


As already alluded to in the previous subsection, we use object-oriented programming (OOP) throughout the entire JAX-FLUIDS solver. Although JAX leans inherently more towards a functional programming style, we have opted to program JAX-FLUIDS in a modular object-oriented approach since this has several benefits. Firstly, comprehensive CFD solvers typically offer a plethora of interchangeable numerical algorithms. Naturally, OOP allows the implementation of many derived classes, e.g., different spatial reconstructors (see #raw(lang:"python", "class SpatialReconstruction") in the previous subsection), and saves boilerplate code. Secondly, the modular OOP approach allows users to customize a solver specific to their problem. Via a numerical setup file, the user can detail the numerical setup prior to every simulation. Thirdly, we want to stress that the modularity of our solver allows for straightforward integration of custom modules and implementations. For example, avid ML-CFD researchers can easily implement their own submodule into the JAX-FLUIDS framework, either simply for forward simulations or for learning new routines from data.


== Just-in-time (jit) Compilation and Pure Functions
<just-in-time-jit-compilation-and-pure-functions>
JAX offers the possibility to just-in-time (jit) compile functions, which significantly increases the performance. However, jit-compilation imposes two constraints:

+ #strong[The function must be a pure function]. A function is pure if its return values are identical for identical input arguments and the function has no side effects.

+ #strong[Control flow statements in the function must not depend on input argument values]. During jit-compilation, an abstract version of the function is cached that works for arbitrary argument values. I.e., the function is not compiled for concrete argument values but rather for the set of all possible argument values where only the array shape and type is fixed. Therefore, control flow statements that depend on the input argument values can not be jit-compiled, unless the argument is a #emph[static argument]. In this case, the function is recompiled for all values that the #emph[static argument] takes during runtime.

The aforementioned requirements to jit-compile a function have the following impact on our implementation:

- The #raw(lang:"python", "self") argument in jit-compiled member functions must be a #emph[static argument]. This implies that class member variables that are used in the function are static and hence must not be modified. In other words, the type of class member variables is similar to the C++ type #raw(lang:"C++", "constexpr").

- Control flow statements in jit-compiled functions can only be evaluated on #emph[static arguments]. In our code, there are three distinct types of control flow statements where this has an impact:

  + #strong[Conditional exit of a for/while loop]. The top level compute loop over the physical simulation time (compare Algorithm #text([])) is not jit-compiled, since it consists of a while loop that is exited when the final simulation time is reached $t gt.eq t_(e n d)$. However, $t$ is not a static variable. We therefore only jit-compile the functions #raw(lang:"python", "compute_timestep"), \
    #raw(lang:"python", "do_integration_step()"), and #raw(lang:"python", "compute_forcings()"). These are the functions that constitute the heavy compute within the main loop.

  + #strong[Conditional slicing of an array]. In multiple parts of the JAX-FLUIDS code, arrays are sliced depending on the present spatial direction. The present spatial direction is indicated by the input argument #raw(lang:"python", "axis") (compare cell face reconstruction in Figure #text([])). The code that is actually executed conditionally depends on the value of #raw(lang:"python", "axis"). Therefore, #raw(lang:"python", "axis") must be a static argument. Functions that receive #raw(lang:"python", "axis") as an input argument are compiled for all values that #raw(lang:"python", "axis") might take during runtime. Each compiled version of those functions is cached.

  + #strong[Conditional executation of code sections]. We explained above that class member variables are always static. In practice, we often use them to conditionally compile code sections, much like the #raw(lang:"C++", "if constexpr") in C++. An example is the cell face reconstruction of the variables, which can be done on primitive or conservative variables in either physical or characteristic space.

- Element-wise conditional array operations are implemented using masks, as jit-compilation requires the array shapes to be fixed at compile time. Figure #text([]) exemplarily illustrates the use of masks, here for the evaluation of the level-set advection equation. We make frequent use of #raw(lang:"python", "jnp.where") to implement element-wise conditional array operations.



 figure
    
     python ./figures/code\_snippets/conditional\_operations.py
     Code snippet showing the right-hand-side computation of the level-set advection equation. 
     fig:masks
 figure


== Main Objects and Compute Loops
<subsec:ComputeLoops>


We put emphasis on making JAX-FLUIDS an easy-to-use Python package for ML-CFD research. Figure #text([]) shows the required code lines to run a simulation. The user must provide a numerical setup and a case setup file in the #emph[json] format. The numerical setup specifies the combination of numerical methods that will be used for the simulation. The case setup details the physical properties of the simulation including the spatial domain and its resolution, initial and boundary conditions, and material properties. As an example, we include the numerical setup and case setup for the Sod shock tube test case in the appendix in Figure #text([]) and #text([]), respectively. Using the #emph[json] files, we create an #raw(lang:"python", "class InputReader") instance, which we denote as #raw(lang:"python", "input_reader"). The #raw(lang:"python", "input_reader") performs necessary data type transformations and a thorough sanity check ensuring that the provided numerical and case setups are consistent.


Then, an #raw(lang:"python", "class Initializer") and a #raw(lang:"python", "class SimulationManager") object are created using the #raw(lang:"python", "input_reader") object. The #raw(lang:"python", "class Initializer") implements functionality to generate the initial buffers from either the initial condition specified in the case setup file or from a restart file. We receive these buffers by calling the #raw(lang:"python", "initialization") method of the #raw(lang:"python", "initializer") object. The #raw(lang:"python", "class SimulationManager") is the main class in JAX-FLUIDS, implementing the algorithm to advance the initial buffers in time using the specified numerical setup. The initial buffers must be passed to the #raw(lang:"python", "simulate") method of the #raw(lang:"python", "simulation_manager") object. The simulation starts upon execution of this function.



 figure
     python ./figures/code\_snippets/run\_nlfvs.py
     Code snippet illustrating how to run a simulation with JAX-FLUIDS.
     fig:run\_solver
 figure


The code contains three major loops:

+ #strong[Loop over physical simulation time], see Algorithm #text([]).

+ #strong[Loop over Runge-Kutta stages], see Algorithm #text([]).

+ #strong[Loop over active spatial dimensions], see Algorithm #text([]).


#block[
]


#block[
]


#block[
]


== Gradient Computation in JAX-FLUIDS
<subsec:gradients>
JAX-FLUIDS offers the #raw(lang:"python", "simulate") method to perform a standard forward CFD simulation. In this regard, JAX-FLUIDS serves as a physics simulator for data generation, development of numerical methods, and exploration of fluid dynamics. The #raw(lang:"python", "simulate") method does not have a return value, therefore, it is not meant to be used for end-to-end optimization.


To use the automatic differentiation capabilities of JAX-FLUIDS, we offer the #raw(lang:"python", "feed_forward") method. This method takes in a batch of initial buffers and propagates them in time for a fixed number of time steps. The user provides the number of integration steps and a fixed time step. The output of the #raw(lang:"python", "feed_forward") method is the solution trajectory. In particular, the shape of the initial buffer is $( N_b , 5 , N_x , N_y , N_z )$ where $N_b$ is the batch size. The shape of the solution trajectory is $( N_b , N_T + 1 , 5 , N_x , N_y , N_z )$ where $N_T$ is the number of integration steps. Internally, the #raw(lang:"python", "feed_forward") method uses the #raw(lang:"python", "jax.vmap") routine to vectorize over the batch dimension. #raw(lang:"python", "feed_forward") is jit-compilable and can be differentiated with #raw(lang:"python", "jax.grad") or #raw(lang:"python", "jax.value_and_grad"). The #raw(lang:"python", "feed_forward") method of JAX-FLUIDS can therefore be used for end-to-end optimization of ML models.


== Integration of ML models into JAX-FLUIDS
<subsec:MLJAXFLUIDS>
JAX-FLUIDS works with Haiku #text([]) and Optax #text([]). The Haiku package is a neural network library for JAX. In Haiku, neural networks are of type #raw(lang:"python", "haiku.Module"). To use them in combination with JAX, the feedforward method of the network has to be embedded in a function that is transformed into a forward wrapper object of type #raw(lang:"python", "haiku.Transformed"). This forward wrapper object provides two pure methods, #raw(lang:"python", "init") and #raw(lang:"python", "apply"). The #raw(lang:"python", "init") method initializes the network parameters, and the #raw(lang:"python", "apply") method executes the feedforward of the network. Network parameters have to be explicitly passed to the #raw(lang:"python", "apply") method. We refer to the Haiku documentation for more details. Optax provides optimization routines, e.g., the popular Adam optimizer #text([]).


In JAX-FLUIDS, we provide functionality to include preexisting ML models and optimize new ones. Neural networks can be passed to the #raw(lang:"python", "simulate") and #raw(lang:"python", "feed_forward") method. Note that only the #raw(lang:"python", "feed_forward") method can be differentiated, see Subsection @subsec:gradients. I.e., it must be used for optimization of deep learning models. A typical use case in ML-CFD research is substituting a conventional numerical subroutine with a data-driven alternative. We provide a number of interfaces inside the JAX-FLUIDS solver to which network modules can be passed from #raw(lang:"python", "feed_forward"), e.g., to the cell face reconstruction, the Riemann solver, or the forcing module. On the top level, the user gives a dictionary of transformed network modules and a dictionary with corresponding network parameters to the #raw(lang:"python", "feed_forward") method. The keys of these dictionaries specify the JAX-FLUIDS subroutine to which the corresponding values are passed.

= Validation of JAX-FLUIDS as a Classical CFD Simulator
<sec:ForwardPass>


We show the capabilities of the JAX-FLUIDS solver as a classical fluid dynamics simulator. We validate our implementation on established one- and two-dimensional test cases from gas dynamics and several canonical turbulent flows. In Subsection @subsec:SinglePhase we first validate the single-phase implementation in JAX-FLUIDS. In Subsection @subsec:Twophase we then validate the two-phase level-set implementation for fluid-solid and fluid-fluid interactions.


We define two numerical setups which we will use predominantly throughout this section. Firstly, we use the #emph[High-Order Godunov] formulation. This setup consists of a WENO5-JS reconstruction of the primitive variables with an approximate HLLC Riemann solver. We will refer to this setup as #emph[HLLC]. Secondly, we employ the #emph[Flux-Splitting] formulation. In particular, we choose Roe approximate Riemann solver with a WENO5-JS flux reconstruction in characteristic space. This setup will be denoted as #emph[ROE]. The dissipative fluxes are discretized with a fourth-order central finite difference stencil as described in @subsec:Dissipative. If not specified otherwise we will use the stiffened gas equation of state with $gamma = 1.4$ and $B = 0$, i.e., the ideal gas law. We will use the classical TVD-RK3 scheme with $C F L_(upright("conservatives")) = 0.9$ for time integration. For the two-phase test cases, we additionally apply the following methods. The level-set advection equation is discretized with a HOUC5 stencil. We solve the extension equation using a first-order upwind spatial derivative stencil combined with an Euler integration scheme. Here, we apply a fixed number of $15$ steps with $C F L_(upright("extension")) = 0.7$. The reinitialization equation is solved with a WENO3-HJ stencil combined with a TVD-RK2 scheme. The level-set field is reinitialized each physical time step by integrating the reinitialization equation for one step with $C F L_(upright("reinitialization")) = 0.7$. We refer to @sec:numericalmodel and therein to @tab:NumericalMethods for details on numerical models.


== Single Phase Simulations
<subsec:SinglePhase>


=== Convergence Study
<subsubsec:Convergence>


We analyze the convergence behavior of our solver. We simulate the advection of a density profile in a one-dimensional periodic domain of extent $x in \[ 0 , 1 \]$ with constant velocity $u = 1$ and pressure $p = 1$. We use a sinusoidal initial condition for the density


$ rho ( x , t = 0 ) = 1.5 + sin ( 2 pi x ) . $<eq:SinusDensity>


Note that we initialize the cell-averaged values of Equation #link(<eq:SinusDensity>)[\[eq:SinusDensity\]]. I.e., for cell $i$ with cell-center $x_i$ we use $macron(rho)_i = 1.5 - 1.0 / ( 2 pi Delta x ) ( cos ( 2 pi x_(i + 1 / 2) ) - cos ( 2 pi x_(i - 1 / 2) ) )$. We conduct simulations with WENO1-JS, WENO3-JS, and WENO5-JS spatial discretizations and evaluate the rate of convergence upon mesh refinement. We use TVD-RK2 for WENO1- and WENO3-JS. For WENO5-JS we use TVD-RK3. We use a fixed time step $Delta t = 1 times 10^(- 4)$ which is chosen small enough to exclude any influence of the time integration scheme. The simulation is propagated until $t_(upright("end")) = 1.0$. @fig:convergence shows the convergence rates in the $l_1$, $l_2$, and $l_oo$ norms. We increase the resolution from $10$ to $1000$ points. The expected convergence rates of $cal(O) ( Delta x^1 )$, $cal(O) ( Delta x^2 )$, and $cal(O) ( Delta x^5 )$ are reached. Note that it is well known that the convergence order of WENO3-JS drops to second order under the presence of extreme points.


#figure([],
  caption: [
    Error convergence $\| rho - hat(rho) \|_p$ for the linear advection of Equation #link(<eq:SinusDensity>)[\[eq:SinusDensity\]] with WENO1, WENO3, and WENO5 spatial discretization. $hat(rho)$ is the analytical solution at $t_(upright("end")) = 1.0$. From left to right: $l_1$, $l_2$, and $l_oo$ norms.
  ]
)
<fig:convergence>



=== Shock Tube Tests
<subsubsec:Shocktube>
The shock tube tests of Sod #text([]) and Lax #text([]) are standard one-dimensional test cases for validating fluid solvers for compressible flows. Specifically, we use these test cases to validate the implementation of the convective fluxes and the shock-capturing schemes. In both shock tube test cases three waves emanate from the initial discontinuities: a left running rarefaction, a right running contact discontinuity, and a right running shock. A detailed description of the tests and their setups are provided in the presented references. We discretize the domain $x in \[ 0 , 1 \]$ with $N = 100$ points. The analytical reference solution is taken from an exact Riemann solver (e.g, #text([])). We run both shock tube tests with the #emph[HLLC] and #emph[ROE] setups. @fig:shocktube_1 and @fig:shocktube_2 show the density and velocity distributions for the Sod and Lax shock tube tests at $t = 0.2$ and $t = 0.14$, respectively. The #emph[HLLC] and #emph[ROE] solutions agree very well with the analytical reference. The #emph[HLLC] solutions show slightly oscillatory behavior which is due to the cell face reconstruction of the primitive variables, see #text([]).


#figure([],
  caption: [
    Sod shock tube: density $rho$ and velocity $u$ at $t = 0.2$.
  ]
)
<fig:shocktube_1>



#figure([],
  caption: [
    Lax shock tube: density $rho$ and velocity $u$ at $t = 0.14$.
  ]
)
<fig:shocktube_2>



=== Lid-driven Cavity
<subsubsec:Cavity>
The lid-driven cavity test case describes the flow in a square cavity that is driven by a moving wall. Viscous forces lead to the generation of one primary vortex and, depending on the Reynolds number, one or more secondary vortices. We use this test case to validate the implementation of the viscous fluxes. The computational domain $x times y in \[ 0 , 1 \] times \[ 0 , 1 \]$ is discretized with a grid consisting of $500 times 500$ cells. All boundary conditions are no-slip walls. The north wall is moving with a constant velocity $u_W$, resulting in a Reynolds number $R e = frac(u_W L, nu) = 5000$. The test case is simulated until a steady state is reached with the #emph[HLLC] setup. @fig:driven_cavity depicts the distribution of $u / u_W$ over $y$ and $v / u_W$ over $x$ across the domain center. The present result agrees very well with the reference #text([]).


#figure([],
  caption: [
    Lid driven cavity at \$Re = "sfrac"{u\_W L}{nu} = 5000\$. (Left) Instantaneous streamlines with colors ranging from largest (red) and smallest (blue) value of the absolute velocity. (Middle) Normalized $u$ velocity over $y$ through domain center. (Right) Normalized $v$ velocity over $x$ through domain center. Reference is taken from #text([]).
  ]
)
<fig:driven_cavity>



=== Compressible Decaying Isotropic Turbulence
<subsubsec:HIT>
Many flows in nature and engineering applications are turbulent. The direct numerical simulation of turbulent flows requires the resolution of the smallest scales present (the Kolmogorov scales) which is prohibitively expansive #text([]). In JAX-FLUIDS we have implemented the implicit large eddy simulation (ILES) model #emph[ALDM] #text([]) which enables us to simulate complex compressible turbulent flows up to very high Reynolds numbers. To validate the implementation of #emph[ALDM] and the viscous forces, we simulate compressible decaying isotropic turbulence at various turbulent Mach numbers. Specifically, we investigate the performance of the #emph[ALDM] ILES implementation on the basis of cases 1-3 from Spyropoulos et al. #text([]). The turbulent Mach numbers $M_t = sqrt(< u^2 + v^2 + w^2 >) / < c >$ for the three cases are $0.2$, $0.4$, and $0.6$, respectively. The turbulent Reynolds number is $R e_T = frac(rho u' ""^4, epsilon.alt mu) = 2742$, where $u'$ is the root-mean-square (rms) velocity and $epsilon.alt$ is the dissipation rate of turbulent kinetic energy #text([]). The spatial domain has extent $x times y times z in [0 , 2 pi] times [0 , 2 pi] times [0 , 2 pi]$. We use the DNS data from #text([]) and an #emph[HLLC] simulation with a resolution of $128^3$ cells as reference. The LES simulations are performed on a coarse grid with $32^3$ cells. We use #emph[ALDM] and #emph[HLLC] on this resolution to conduct LES simulations. The initial velocity field is divergence free and has the energy spectrum


$ E ( k ) = A k^4 exp ( - 2 k^2 / k_0^2 ) , $


where $k$ is the wave number, $k_0$ is the wave number at which the spectrum is maximal, and $A$ is a constant chosen to adjust a specified initial kinetic energy. The initial density and temperature fields are uniform. @fig:densityrmsdecay shows the temporal evolution of the rms density fluctuations $rho_(r m s) = sqrt(< rho' rho' >)$. We normalize the time axis with the initial eddy turnover time $tau = lambda_f / u' approx 0.85$. $lambda_f$ is the lateral Taylor microscale #text([]). The #emph[HLLC] simulation at $128^3$ recovers the DNS reference very well. On the coarse mesh, the performance of the #emph[ALDM] ILES becomes obvious when compared to #emph[HLLC] simulations at the same resolution. #emph[ALDM] gives good results consistent with the DNS data, indicating that #emph[ALDM] recovers the correct sub-grid scale terms for compressible isotropic turbulence.


#figure([],
  caption: [
    Temporal evolution of the rms density fluctuations for decaying isotropic turbulence. The time axis is normalized with the initial eddy turnover time. The DNS results are cases 1-3 from Spyropoulos et al. #text([]).
  ]
)
<fig:densityrmsdecay>



== Two-phase Simulations
<subsec:Twophase>


=== Two-phase Sod Shock Tube
<subsubsec:TwophaseSod>
We consider a two-phase variant of the Sod shock tube problem #text([]). This test case validates the inviscid fluid-fluid interface interactions. In particular, we investigate an air-helium shock tube problem in which the materials left and right of the initial discontinuity are air ($gamma_(upright("air")) = 1.4$) and helium ($gamma_(upright("helium")) = 1.667$), respectively. We use the previously described #emph[HLLC] setup. The domain $x in \[ 0 , 1 \]$ is resolved with 200 cells. @fig:twophaseshocktube shows the results at $t = 0.15$. The numerical approximations are in good agreement with the analytical solution. The interface position and shock speed and shock strength are captured correctly. We observe slight density oscillations around the interface. This is in agreement with previous literature #text([]) as no isobaric fix is employed.


#figure([],
  caption: [
    Air-helium shock tube problem. Density $rho$ and velocity $u$ at $t = 0.15$.
  ]
)
<fig:twophaseshocktube>



=== Bow Shock
<subsubsec:Bowshock>
Bow shocks occur in supersonic flows around blunt bodies #text([]). Here, we simulate the flow around a stationary cylinder at high Mach numbers \$Ma = "sfrac"{sqrt{"bold"("u") dot.op "bold"("u")}}{sqrt{gamma"frac"{p}{rho}}}=\\(3,20\\)\$. This test case validates the implementation of the inviscid fluid-solid interface fluxes. The computational domain $x times y in \[ - 0.3 , 0.0 \] times \[ - 0.4 , 0.4 \]$ is discretized with a grid consisting of $480 times 1280$ cells. A cylinder with diameter $0.2$ is placed at the center of the east boundary. The north, east, and south boundaries are zero-gradient. The west boundary is of Dirichlet type, imposing the post shock fluid state. The fluid is initialized with the post shock state, i.e., $( rho , u , v , p ) = (1 , sqrt(1.4) M a , 0 , 1)$. We simulate the test case with the #emph[HLLC] setup until a steady state solution is reached. @fig:bowshock illustrates the steady state density and pressure distributions. The results compare well to results from literature, e.g., #text([]).


#figure([
#figure(text(‹TikZ source: figures/tikz_3.tex›), caption: [TikZ figure 3])


  ],
  caption: [
    Density and pressure for the bow shock at $M a = 3$ (left) and $M a = 20$ (right). The colormap ranges from minimum (blue) to maximum (red) value; $rho in \[ 0.7 , 4.5 \]$, $p in \[ 1.0 , 15.0 \]$ for $M a = 3$ and $rho in \[ 0.7 , 7.2 \]$, $p in \[ 1.0 , 550.0 \]$ for $M a = 20$. The black lines represent Mach isocontours from 0.1 to 2.5 in steps of 0.2.
  ]
)
<fig:bowshock>



=== Oscillating Drop
<subsubsec:OscillatingDrop>
We consider a drop oscillating due to the interplay of surface tension and inertia. Starting from an ellipsoidal shape, surface tension forces drive the drop to a circular shape. This process is associated with a transfer of potential to kinetic energy. The oscillating drop test case validates the implementation of the surface tension forces. The drop oscillates with a distinct frequency. The oscillation period $T$ is given by #text([]) $ omega^2 = frac(6 sigma, ( rho_b + rho_d ) R^3) , #h(2em) T = frac(2 pi, omega) . $ We discretize the computational domain $x times y in \[ 0 , 1 \] times \[ 0 , 1 \]$ with a grid consisting of $200 times 200$ cells. We place an ellipse with semi-major and semi-minor axes of $0.2$ and $0.15$ at the center of the domain. The effective circle radius is therefore $R = 0.17321$. The bulk and drop densities are $rho_b = rho_d = 1.0$ and the surface tension coefficient is $sigma = 0.05$. All boundaries are zero-gradient. We use the #emph[HLLC] setup for this simulation. @fig:oscillatingdrop displays instantaneous pressure fields and the kinetic energy of the drop over time. The present result for the oscillation period is $T = 1.16336$, which is in very good agreement with the analytical reference $T_(r e f) = 1.16943$.


#figure([],
  caption: [
    Oscillating drop. (Left) Temporal evolution of the pressure distribution within the drop. The colors range from maximum (red) to minimum (blue) value within the shown time period. (Right) Kinetic energy $E_(upright("kin")) = integral_V rho upright(bold(u)) dot.op upright(bold(u)) upright("d") V$ of the drop over time. The orange dots indicate the times that correspond to the pressure distributions on the left.
  ]
)
<fig:oscillatingdrop>



=== Shear Drop Deformation
<shear-drop-deformation>
The shear drop deformation test case describes the deformation of an initially circular shaped drop due to homogenous shear. Viscous forces lead to the deformation to an ellipsoidal shape. For stable parameters, surface tension forces will eventually balance the viscous forces, which results in a steady state solution. The shear flow is generated with moving no-slip wall boundaries. We use this test case to validate the viscous fluid-fluid interface fluxes. The steady state solution is characterized by the viscosity ratio $mu_b / mu_d$ and the capillary number $C a$ $ C a = frac(mu_b R dot(s), sigma) , $ where $R$ denotes the initial drop radius, $sigma$ the surface tension coefficient, $dot(s)$ the shear rate, and $mu_b$ and $mu_d$ the viscosities of the drop and bulk fluid, respectively. The following relation holds for small deformations #text([]). $ #h(2em) D = frac(B_1 - B_2, B_1 + B_2) = C a frac(19 mu_b / mu_d + 16, 16 mu_b / mu_d + 16) $ Herein, $B_1$ and $B_2$ indicate the semi-major and semi-minor axes of the steady state ellipse. To simulate this test case, we discretize the domain $x times y in \[ 0 , 1 \] times \[ 0 , 1 \]$ with a grid that consists of $250 times 250$ cells. A drop with radius $R = 0.2$ is placed at the center of the domain. We move the north and south wall boundaries with an absolute velocity of $u_W = 0.1$ in positive and negative direction, respectively. This results in a shear rate of $0.2$. At the east and west boundaries we enforce periodicity. The viscosities are $mu_b = mu_d = 0.1$. We simulate multiple capillary numbers by varying the surface tension coefficient with the #emph[HLLC] setup until a steady state solution is reached. <subsubsec:ShearDrop>


#figure([],
  caption: [
    Shear drop deformation. (Left) Steady state pressure field for $C a = 0.2$. (Right) Deformation parameter $D$ over $C a$.
  ]
)
<fig:sheardrop>



@fig:sheardrop illustrates the pressure distribution of the steady state ellipse at $C a = 0.2$. Furthermore, it shows the deformation parameter $D$ over the capillary number $C a$. The present result agrees well with the analytical reference.


=== Shock-bubble Interaction
<subsubsec:ShockBubble>


We simulate the interaction of a shock with Mach number 1.22 with a helium bubble immersed in air. This is an established test case to assess the robustness and validity of compressible two-phase numerical methods. Reports are well documented in literature #text([]) #text([]) #text([]) and experimental data are available #text([]).


A helium bubble with diameter $D = 50 thin upright("mm")$ is placed at the origin of the computational domain $x times y in \[ - 90 thin upright("mm") , 266 thin upright("mm") \] times \[ - 44.5 thin upright("mm") , 44.5 thin upright("mm") \]$. The initial shock wave is located $5 thin upright("mm")$ to the left of the helium bubble. The shock wave travels right and impacts with the helium bubble. @fig:shockbubbleflowfield shows the flow field at two later time instances. The interaction of the initial shock with the helium bubble generates a reflected shock which is travelling to the left and a second shock which is transmitted through the bubble, see @fig:shockbubbleflowfield on the left. The incident shock wave is visible as a vertical line. The transmitted wave travels faster than the incident shock. The helium bubbles deforms strongly and a re-entrant jet forms. @fig:shockbubbleflowfield on the right shows the instance in time at which the jet impinges on the interface of the bubble.


The numerical schlieren images and the flow fields in @fig:shockbubbleflowfield are in good qualitative agreement with results from literature, compare with Figure 7 from #text([]) or Figure 10 from #text([]). @fig:shockbubblespacetime shows the temporal evolution of characteristic interface points. The results are in very good quantitative agreement with #text([]).


#figure([
#figure(text(‹TikZ source: figures/tikz_4.tex›), caption: [TikZ figure 4])


  ],
  caption: [
    Visualizations of the flow field at two different instances in time. The upper half of each image shows numerical schlieren, the lower half shows the pressure field from the smallest (blue) to the largest (red) pressure value. The black line indicates the location of the interface.
  ]
)
<fig:shockbubbleflowfield>



#figure([],
  caption: [
    Space-time diagram of three characteristic interface points. Positions of the upstream point (left-most point of the interface), the downstream point (right-most point of the interface), and the jet (left-most point of the interface on the center-line) are tracked. Reference values are taken from Terashima et al. #text([]).
  ]
)
<fig:shockbubblespacetime>



= Single Node Performance
<sec:Performance>


We assess the single node performance of the JAX-FLUIDS solver on an NVIDIA RTX A6000 GPU. The NVIDIA RTX A6000 provides 48GB of GPU memory and a bandwidth of 768 GB/s. We conduct simulations of the three-dimensional compressible Taylor-Green vortex (TGV) #text([]) at $M a = 0.1$ on a series of grids with increasing resolution. Specifically, we simulate TGVs on $64^3$, $128^3$, $256^3$, and $384^3$ cells. We use the two numerical setups described in the previous section. We use JAX version 0.2.26. As JAX-FLUIDS can handle single- and double-precision computations, we assess the performance for both data types. @tab:Performance summarizes the results. At $384^3$ cells, only the simulation setup #emph[HLLC-float32] did not exceed the memory resources of the A6000 GPU, compare with @tab:Memory. All results reported here are averaged over 5 independent runs. For the #emph[HLLC-float32] setup, JAX-FLUIDS achieves a performance of around 25 $mu s$ per time step. This corresponds to three evaluations of the right-hand side in Equation #link(<eq:FVD>)[\[eq:FVD\]] as we use TVD-RK3 time integration. JAX-FLUIDS, therefore, provides a strong performance taking into consideration that the code is written entirely in the high-level language of Python/JAX. For the #emph[ROE-float32] setup, the computation of the eigenvectors and eigenvalues increases the wall clock time roughly by an order of magnitude. For #emph[HLLC] and #emph[ROE] schemes, we observe that the single-precision calculations are between 2.5 and 3 times faster than the double-precision calculations.


As GPU memory is a critical resource when working with JAX, we investigate the memory consumption of JAX-FLUIDS. The default behavior of JAX preallocates 90\% of GPU memory in order to avoid memory fragmentation. Therefore, to monitor the actual memory consumption, we set #raw(lang:"python", "XLA_PYTHON_CLIENT_PREALLOCATE=\"false\"") to disable memory preallocation and force JAX to allocate GPU memory as needed. Additionally, we set #raw(lang:"python", "XLA_PYTHON_CLIENT_ALLOCATOR=\"platform\"") which allows JAX to deallocate unused memory. Note that allowing JAX to deallocate unused memory incurs a performance penalty, and we only use this setting to profile the memory consumption. @tab:Memory summarizes the GPU memory requirements for the aforementioned simulation setups. We refer to the documentation of JAX #text([]) for more details on GPU memory utilization.


#figure([], caption: [Mean wall clock time per cell per time step. All computations are run on an NVIDIA RTX A6000 GPU. The wall clock times are averaged over five runs. Numbers in brackets denote the standard deviation over the five runs.]
  , kind: table
  )
<tab:Performance>



#align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    table.header([], table.cell(align: center, colspan: 5)[Mean wall clock time per cell per time step in $10^(- 9) s$],),
    table.hline(),
    [], [$32^3$], [$64^3$], [$128^3$], [$256^3$], [$384^3$],
    [HLLC - float32], [64.41 (11.87)], [24.39 (0.06)], [25.09 (0.04)], [28.36 (0.03)], [28.11 (0.01)],
    [HLLC - float64], [98.20 (0.49)], [93.94 (0.06)], [92.55 (0.09)], [92.76 (0.04)], [-],
    [ROE - float32], [241.71 (0.70)], [302.20 (0.32)], [304.55 (0.16)], [301.78 (0.36)], [-],
    [ROE - float64], [703.40 (1.42)], [746.78 (6.17)], [759.36 (5.23)], [760.09 (6.37)], [-],
  )]


#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    table.header([], table.cell(align: center, colspan: 5)[Memory pressure],),
    table.hline(),
    [], [$32^3$], [$64^3$], [$128^3$], [$256^3$], [$384^3$],
    [HLLC - float32], [295.6 (1.50)], [434.4 (1.50)], [1424.4 (1.50)], [9141.6 (1.50)], [29849.2 (2.04)],
    [HLLC - float64], [353.6 (2.33)], [623.6 (2.33)], [2631.6 (2.33)], [18275.6 (2.33)], [-],
    [ROE - float32], [626.0 (1.79)], [818.8 (2.04)], [2255.2 (2.04)], [13546.0 (1.79)], [-],
    [ROE - float64], [688.0 (2.83)], [1068.4 (2.33)], [3938.0 (2.83)], [26504.4 (2.33)], [-],
  )]
  , caption: [GPU Memory Pressure in megabytes (MB).]
  , kind: table
  )
<tab:Memory>



= Machine Learning in JAX-FLUIDS
<sec:BackwardPass>


Having showcased that the JAX-FLUIDS solver functions very well as a modern and easy-to-use fluid dynamics simulator, we now discuss its capabilities for ML research, in particular its automatic differentiation capabilities for end-to-end optimization. In this section, we demonstrate that we can successfully differentiate through the entire JAX-FLUIDS solver. We validate the AD gradients for single- and two-phase flows. We then showcase the potential of JAX-FLUIDS by training a data-driven Riemann solver leveraging end-to-end optimization.


== Deep Learning Fundamentals
<subsec:Deeplearning>
Given a data set of input-outputs pairs $cal(D) = (( upright(bold(x))_1 , upright(bold(y))_1 ) , . . . , ( upright(bold(x))_N , upright(bold(y))_N ))$ with $upright(bold(x)) in cal(X)$ and $upright(bold(y)) in cal(Y)$, supervised learning tries to find a function $f : cal(X) arrow.r cal(Y)$ which (approximately) minimizes an average loss


$ cal(L) = 1 / N sum_(i = 1)^N L ( upright(bold(y))_i , f ( upright(bold(x))_i ) ) , $


where $L : cal(Y) times cal(Y) arrow.r bb(R)$ is a suitable loss function. $cal(X)$ and $cal(Y)$ are input and output spaces, and $f in cal(F)$, where $cal(F)$ is the hypothesis space. We use $upright(bold(hat(y)))_i$ to denote the output of the function $f$ for input $upright(bold(x))_i$, $upright(bold(hat(y)))_i = f ( upright(bold(x))_i )$. A popular loss in regression tasks is the mean-squared error (MSE)


$ cal(L) = M S E ( upright(bold(x)) , upright(bold(y)) ) = 1 / N sum_(i = 1)^N ( upright(bold(y))_i - upright(bold(hat(y)))_i )^2 . $


One possible and highly-expressive class of functions are deep neural networks (DNN) #text([]) #text([]). DNNs are parameterizable nonlinear compound functions, $f = f_(upright(bold(theta)))$, where the network parameters consist of weights and biases, $upright(bold(theta)) = (upright(bold(W)) , upright(bold(b)))$. DNNs consist of multiple hidden layers of units between input layer and output layer. The values in each layer are called activations. Multilayer perceptrons (MLPs) are one particular kind of DNN in which adjacent layers are densely connected #text([]). We compute the activations $upright(bold(a))^l$ in layer $l$ from the activations of the previous layer $upright(bold(a))^(l - 1)$,


$ upright(bold(a))^l = sigma ( upright(bold(W))^(l - 1) upright(bold(a))^(l - 1) + upright(bold(b))^(l - 1) ) . $


Here, $upright(bold(W))^(l - 1)$ is the weight matrix linking layers $l - 1$ and $l$, $upright(bold(b))^(l - 1)$ is the bias vector, and $sigma ( dot.op )$ is the element-wise nonlinearity. Typically, DNNs are trained by minimizing $cal(L)$ via mini-batch gradient descent or more advanced optimization routines like AdaGrad #text([]) or Adam #text([]).


== Optimization through PDE Trajectories
<optimization-through-pde-trajectories>
Machine learning has the potential to discover and learn novel data-driven numerical algorithms for the numerical computation of fluid dynamics. For supervised learning, we need input-ouput pairs. In fluid dynamics, exact solutions rarely exist for complex flow. We usually take highly-resolved numerical simulations as exact.


In the context of differentiable physics, end-to-end optimization usually refers to supervised learning of ML models which receive gradients that are backpropagated through a differentiable physics simulator. Here, the ML model is placed inside a differentiable PDE solver. A trajectory obtained from a forward simulation of the PDE solver is compared to a ground truth trajectory, and the derivatives of the loss are propagated across the temporal sequence, i.e., the trajectory. We denote a trajectory of states as


$ upright(bold(tau)) = (upright(bold(U))^1 , . . . , upright(bold(U))^(N_T)) . $


The differentiable solver, e.g., JAX-FLUIDS, can be interpreted as a parameterizable generator $cal(G)_(upright(bold(theta)))$ of such a trajectory starting from the initial condition $upright(bold(U))_0$.


$ upright(bold(tau))_(upright(bold(theta)))^(P D E) = (upright(bold(U))^1 , . . . , upright(bold(U))^(N_T)) = cal(G)_(upright(bold(theta))) ( upright(bold(U))_0 ) $


Our loss objective is the difference between the trajectory $upright(bold(tau))_(upright(bold(theta)))^(P D E)$ and a ground truth trajectory $upright(bold(hat(tau))) = (upright(bold(hat(U)))^1 , . . . , upright(bold(hat(U)))^(N_T))$. For example, using the MSE in state space


$ cal(L)^tau = 1 / N_T sum_(i = 1)^(N_T) M S E ( upright(bold(U))^i , upright(bold(hat(U)))^i ) . $


The derivatives of the loss with respect to the tuneable parameters $partial cal(L) / partial upright(bold(theta))$ are backpropagated across the simulation trajectory and through the entire differentiable PDE solver. And the ML model is optimized by using $partial cal(L) / partial upright(bold(theta))$ in a gradient-based optimization routine.


In particular, multiple steps through the simulator can be chained together. Thereby, the ML model observes the full dynamics of the underlying PDE and learns how its actions influence the entire simulation trajectory. Naturally, the trained model is equation-specific and physics-informed. This training procedure alleviates the problem of distribution mismatch between training and test data as the model sees its own outputs during the training phase. Additionally, the ML model could potentially account for approximation errors of other parts of the solver.


JAX-FLUIDS allows us to take gradients through an entire CFD simulation trajectory by applying #raw(lang:"python", "jax.grad") to any scalar observable of the state trajectory. We want to stress that JAX-FLUIDS thereby differentiates for each time step through complex subfunctions such as the spatial reconstruction, Riemann solvers, or two-phase interactions.


== Validation of Automatic Differentiation Gradients
<subsec:gradientvalid>
Before we showcase the full potential of JAX-FLUIDS for learning data-driven numerical schemes by end-to-end optimization, we first validate the gradients obtained from automatic differentiation by comparing them with gradients obtained from finite-differences. We consider a single shock wave with shock Mach number $M_S$ propagating into a fluid at rest.


We fix the state ahead of the shock with $rho_R = p_R = 1 , u_R = 0$. The Rankine-Hugoniot relations #text([]) determine the state behind the shock wave as a function of the shock Mach number $M_S$. As the shock wave crosses the computational domain, the integral entropy increases. The described setup is depicted in @fig:gradients on left. The left and right states are separated by an initial shock discontinuity. We consider a single-phase and two-phase setup. In both setups all fluids are modeled by the ideal gas law. In the former, the same fluid is left and right of the initial shock wave and $gamma_L = gamma_R$. In the latter, two immiscible fluids are separated by the shock wave, i.e., $gamma_L eq.not gamma_R$. For the second setup, we make use of the entire level-set algorithm as described earlier.


As the shock wave propagates into the domain, the integral entropy in the domain increases by $Delta S$, see the schematic in the middle of @fig:gradients. The integral entropy at time $t$ is defined by


$ S ( t ) = integral_Omega rho ( x , t ) s ( x , t ) d x , $


and the increase in integral entropy is


$ Delta S ( t ) = S ( t ) - S ( t_0 ) = integral_Omega (rho ( x , t ) s ( x , t ) - rho ( x , t = 0 ) s ( x , t = 0 )) d x . $


In the simplified setting under investigation, the increase in integral entropy at any fixed point in time, say $t^n$, is solely determined by the shock Mach number $M_S$, i.e., $Delta S^n = Delta S ( t = t^n ) = Delta S ( M_S )$. We let the shock wave propagate for $n$ steps with fixed $Delta t$, i.e., $t^n = n Delta t$, and compute the gradient of the total entropy increase $Delta S^n$ with respect to the shock Mach number $M_S$.


$ g = frac(partial Delta S^n, partial M_S) $


We compute the gradient with automatic differentiation $g_(A D)$ and with second-order central finite-differences according to


$ g_(F D)^epsilon = frac(Delta S^n ( M_S + epsilon ) - Delta S^n ( M_S - epsilon ), 2 epsilon) . $


Here, we set $M_S = 2$. We use the #emph[HLLC] setup described in the previous section. We set $Delta t = 1 times 10^(- 2)$ and $n = 5$. In the single-phase case $gamma_L = gamma_R = 1.4$, in the two-phase case $gamma_L = 1.4 , gamma_R = 1.667$. On the right of @fig:gradients, we visualize the $l_1$ norm between the gradients $g_(A D)$ and $g_(F D)^epsilon$ for the single-phase and two-phase setup. We choose $epsilon in [1 e - 1 , 3 e - 2 , 1 e - 2 , 3 e - 3 , 1 e - 3 , 3 e - 4 , 1 e - 4]$. We observe that the finite-difference approximations converge with second-order to the respective automatic differentiation gradients. We conclude that automatic differentiation through the entire JAX-FLUIDS code works and gives correct gradients. In passing, we note that although the described setting is a simplified one-dimensional setup, and we only differentiate w.r.t a single parameter, the AD call has to backpropagate through multiple integration steps with several Runge-Kutta substeps each accompanied by calls to spatial reconstruction and Riemann solver. Especially in the two-phase setup, gradients are obtained through the entire level-set computational routines including level-set advection, level-set reinitilization, and the extension procedure.


#figure([],
  caption: [
    Left: Schematic of the computational setup. The constant initial states are separated by a single right-running shock discontinuity. Middle: Schematic of the total entropy increase. Right: Error convergence of the gradient obtained by second-order central finite-difference approximation with respect to the gradient obtained by automatic differentiation, i.e., $\| g_(A D) - g_(F D)^epsilon \|_p$.
  ]
)
<fig:gradients>



== End-to-end Optimization of a Riemann Solver
<subsec:rusanovnn>


Automatic differentiation yields the opportunity to optimize and learn numerical schemes from data by end-to-end optimization through a numerical simulator #text([]) #text([]) #text([]). In this section, we want to showcase how JAX-FLUIDS is able to learn a numerical flux function (i.e., an approximate Riemann solver) by minimizing a loss between predicted trajectory and ground truth trajectory. We optimize the popular Rusanov flux function (also known as local Lax-Friedrichs flux function). The Rusanov flux at the cell face $x_(i + 1 / 2)$ is


$ upright(bold(F))_(i + 1 / 2)^(upright("Rusanov")) = 1 / 2 ( upright(bold(F))_L + upright(bold(F))_R ) - 1 / 2 alpha ( upright(bold(U))_R - upright(bold(U))_L ) . $<eq:Rusanov>


Here, $upright(bold(U))_(L / R)$ and $upright(bold(F))_(L / R)$ are the left and right sided cell face reconstructions of the conservative variable and the flux. $alpha$ is the scalar numerical viscosity. For the classical Rusanov method the numerical viscosity is defined at each cell face $alpha_(upright("Rusanov")) = max (\| u_L - c_L \| , \| u_L + c_L \| , \| u_R - c_R \| , \| u_R + c_R \|)$. $u$ is the cell face normal velocity and $c$ is the local speed of sound. It is well known that although the Rusanov method yields a stable solution, the excess numerical diffusion leads to smearing out of the solution. As a simple demonstration of the AD-capabilities of our CFD solver, we introduce the Rusanov-NN flux with the dissipation $alpha_(upright("Rusanov"))^(upright("NN")) = N N (\| Delta u \| , u_M , c_M , \| Delta s \|)$ to be optimized. The dissipation is output of a multi-layer perceptron which takes as inputs the jump in normal velocity $Delta u = \| u_R - u_L \|$, the mean normal velocity $u_M = 1 / 2 ( u_L + u_R )$, the mean speed of sound $c_M = 1 / 2 ( c_L + c_R )$, and the entropy jump $Delta s = \| s_R - s_L \|$. The network is composed of three layers with 32 nodes each. We use RELU activations for the hidden layers. An exponential activation function in the output layer guarantees $alpha_(upright("Rusanov"))^(upright("NN")) gt.eq 0$.


#figure([],
  caption: [
    Trajectories of the absolute velocity. From top to bottom: Ground truth (Exact) on $128 times 128$, Coarse-grained (CG) on $32 times 32$, Rusanov-NN on $32 times 32$, and Rusanov on $32 times 32$. For each time step, values are normalized with the minimum and maximum value of the exact solution.
  ]
)
<fig:Trajectory>



We set up a highly-resolved simulation of a two-dimensional implosion test case to generate the ground truth trajectory. The initial conditions are a diagonally placed jump in pressure and density,


$ (rho , u , v , p) = cases(delim: "{", (0.14 , 0 , 0 , 0.125) & upright("if") med x + y lt.eq 0.15 ,, (1 , 0 , 0 , 1) & upright("if") med x + y > 0.15 ,) $<eq:FullImplosion>


on a domain with extent $x times y in \[ 0 , 1 \] times \[ 0 , 1 \]$. A shock, a contact discontinuity, and a rarefaction wave emanate from the initial discontinuity and travel along the diagonal. The shock is propagating towards the lower left corner and is reflected by the walls resulting in a double Mach reflection, while the rarefaction wave is travelling into the open domain. The high resolution simulation is run on a mesh with $128 times 128$ cells with a WENO3-JS cell face reconstruction, TVD-RK2 integration scheme, and the HLLC Riemann solver. We use a fixed time step $Delta t = 2.5 times 10^(- 4)$ and sample the trajectory every $Delta t_(upright("CG")) = 10^(- 3)$, which is the time step for the coarse grained trajectories. A trajectory of 2501 time steps is generated, i.e., $t in \[ 0 , 2500 Delta t_(upright("CG")) \]$. Exemplary time snapshots for the absolute velocity are visualized in the top row of @fig:Trajectory. We obtain the ground truth data after coarse-graining the high-resolution trajectory onto $32 times 32$ points, see second row of @fig:Trajectory.


The dissipation network model is trained in a supervised fashion by minimizing the loss between the coarse-grained (CG) trajectory and the simulation produced by the Rusanov-NN model. The loss function is defined as the mean-squared error between the predicted and coarse-grained primitive state vectors, $upright(bold(W))^(upright("NN"))$ and $upright(bold(W))^(upright("CG"))$, over a trajectory of length $N_T$,


$ L = 1 / N_T sum_(i = 1)^(N_T) M S E ( upright(bold(W))_i^(upright("NN")) , upright(bold(W))_i^(upright("CG")) ) . $<eq:Loss>


The training data set consists of the first $1000$ time steps of the coarse grained reference solution. During training, the model is unrolled for $N_T = 15$ time steps. We use the Adam optimizer with a constant learning rate $5 e - 4$ and a batch size of $20$. The Rusanov-NN model is trained for $200$ epochs. Although we have trained on trajectories of length $15$, the trained model is then evaluated for the entire trajectory of $2501$ time steps. @fig:Trajectory compares the results of the Rusanov and the final Rusanov-NN flux functions. The NN-Rusanov flux is less dissipative than the classical Rusanov scheme and recovers small scale flow structures very well, e.g., see time step 100 in @fig:Trajectory. The NN-Rusanov flux stays stable over the course of the simulation and consistently outperforms the Rusanov flux, see the relative errors in pressure and density in @fig:RelError. The ML model even performs very well outside the training set (time steps larger than $1000$).


#figure([],
  caption: [
    Relative $L_1$ error for density (blue) and pressure (orange). The gray line indicates the training horizon.
  ]
)
<fig:RelError>



= Conclusion
<sec:Conclusion>


We have presented JAX-FLUIDS, a comprehensive state-of-the-art fully-differentiable python package for compressible three-dimensional computational fluid dynamics. Machine learning is becoming more and more dominant in the physical and engineering sciences. Especially, fluid dynamics represents a field in which ML techniques and data-driven methods show very promising results and seem to have a high potential. Despite the recent surge of ML-CFD research, a comprehensive state-of-the-art differentiable CFD solver has not been published. JAX-FLUIDS provides researchers at the intersection of fluid dynamics and deep learning the opportunity to explore new data-driven numerical models for fluid dynamics. JAX-FLUIDS offers powerful high-order numerical methods for a wide variety of fluid dynamics problems, e.g., turbulent flows, flows with arbitrary solid boundaries, compressible flows, and two-phase flows. The modular architecture of JAX-FLUIDS makes integration of custom submodules easy and straightforward.


Although JAX-FLUIDS covers a wide range of flow physics, some intriguing and complex phenomena like combustion, fluid-structure interaction, or cavitation cannot yet be modeled with JAX-FLUIDS. For the future, we plan to implement appropriate numerical methods.


Currently, by far the largest limitation of JAX-FLUIDS is the available memory of the GPU. Although JAX-FLUIDS scales out of the box to problem sizes with roughly 400 million degrees of freedom (DOFs) on a single modern GPU, many problems in fluid dynamics require higher DOFs. Generally, there are two ways of tackling this problem: adaptive multiresolution #text([]) #text([]) and parallelization to multiple GPUs, e.g. #text([]) #text([]). Adaptive multiresolution increases the mesh resolution in areas of interest (e.g., where small scale structures are present) while using a much coarser resolution in other parts of the flow field. Compared to a uniform mesh, adaptive multiresolution increases the efficiency of the simulation in terms of computational resources. To the knowledge of the authors, multiresolution strategies seem to be problematic with a jit-compiled code framework such as JAX, as the computegraph has to be static. A second approach for increasing the computable problem size is parallelization. The latest version of JAX #text([]) as well as other works #text([]) propose different parallelization strategies for JAX algorithms and provide promising avenues for future work.


#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>


= Numerical and Case Setup Files for Sod Shock Tube Test Case
<sec:Appendix>



 figure
     json ./figures/code\_snippets/numerical\_setup.json
     Numerical setup  json file for the Sod shock tube test case.
     fig:numerical\_setup
 figure



 figure
     json ./figures/code\_snippets/case\_setup.json
     Case setup  json file for the Sod shock tube test case.
     fig:case\_setup
 figure


#heading(level: 1, numbering: none)[Data Availability Statement]
<data-availability-statement>
JAX-FLUIDS is available under the MIT license at #link("https://github.com/tumaer/JAXFLUIDS").
