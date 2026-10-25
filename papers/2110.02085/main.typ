#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Palatino Linotype", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.90cm, right: 1.90cm, top: 2.00cm, bottom: 1.90cm))
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.48em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(20.7pt, weight: "bold", [Enhancing Computational Fluid Dynamics with Machine Learning])   #v(1.2em)
  #text(10.5pt)[Ricardo Vinuesa#super[1,2,#text("*")] and Steven L. Brunton#super[3]]   #v(0.6em)
  #text(8.5pt)[
    #super[1] FLOW, Engineering Mechanics, KTH Royal Institute of Technology, Stockholm, Sweden.
    #super[2] Swedish e-Science Research Centre (SeRC), Stockholm, Sweden.
    #super[3] Department of Mechanical Engineering, University of Washington, Seattle, WA 98195, United States. \
    #super[#text("*")] Corresponding author: Ricardo Vinuesa (rvinuesa\@mech.kth.se)
  ]
]
#v(1.6em)

// abshead
#align(center)[#text(9pt, weight: "bold")[Abstract]]

Machine learning is rapidly becoming a core technology for scientific computing, with numerous opportunities to advance the field of computational fluid dynamics. In this Perspective, we highlight some of the areas of highest potential impact, including to accelerate direct numerical simulations, to improve turbulence closure modeling, and to develop enhanced reduced-order models. We also discuss emerging areas of machine learning that are promising for computational fluid dynamics, as well as some potential limitations that should be taken into account.

= Introduction <sec:intro>

The field of numerical simulation of fluid flows is generally known as computational fluid dynamics (CFD). Fluid mechanics is an area of great importance, both from a scientific perspective and for a range of industrial-engineering applications. Fluid flows are governed by the Navier--Stokes equations, which are partial differential equations (PDEs) modeling the conservation of mass and momentum in a Newtonian fluid. These PDEs are non-linear due to the convective acceleration (which is related to the change of velocity with the position), and they commonly exhibit time-dependent chaotic behavior, known as #emph[turbulence]. Solving the Navier--Stokes equations for turbulent flows requires numerical methods that may be computationally expensive, or even intractable at high Reynolds numbers, due to the wide range of scales in space and time necessary to resolve these flows. There are various approaches to numerically solve these equations, which can be discretized using methods of different orders, for instance finite-difference @godunov1959finite, finite-volume @eymard2000finite, finite-element @zienkiewicz1977finite, spectral methods @canuto2012spectral, and so forth. Furthermore, turbulence can be simulated with different levels of fidelity and computational cost.

At the same time, we are experiencing a revolution in the field of machine learning (ML), which is enabling advances across a wide range of scientific and engineering areas @Brunton2019book @recht2019tour @vinuesa_et_al_2020 @Noe2020ARPC @niederer2021scaling. Machine learning is a subfield of the broader area of artificial intelligence (AI), which is focused on the development of algorithms with the capability of learning from data without explicit mathematical models @samuel. Many of the most exciting advances in ML have leveraged deep learning, based on neural networks (NNs) with multiple hidden layers between the input and the output. One key aspect contributing to the remarkable success of deep learning is the ability to learn in a hierarchical manner: while initial layers learn simple relationships in the data, deeper layers combine this information to learn more abstract relationships. Many physical problems exhibit this hierarchical behavior, and can therefore be effectively modelled using deep learning, and machine learning more generally.

In this Perspective, we focus on the potential of machine learning to improve CFD, including possibilities to increase the speed of high-fidelity simulations, develop turbulence models with different levels of fidelity, and produce reduced-order models beyond what can be achieved with classical approaches. Several authors have surveyed the potential of machine learning to improve fluid mechanics @Brenner2019prf, @Brunton2020arfm, including topics beyond the scope of CFD, such as experimental techniques, control applications, and related fields. Others have reviewed more specific aspects of ML for CFD, such as turbulence closure @duraisamy_et_al @ahmed2021closures and heat-transfer aspects of CFD for aerodynamic optimization @wang_wang. Our discussion will address the middle ground of ML for CFD more broadly, with a schematic representation of topics covered in @wang_wang. Approaches to improve CFD with ML are aligned with the larger efforts to incorporate ML into scientific computing, for instance via physics-informed neural networks (PINNs) @raissi2019physics @karniadakis2021physics or to accelerate computational chemistry @Noe2019science @Noe2020ARPC.

#figure(
  cetz.canvas(length: 0.98cm, padding: 0.15cm, {
    import cetz.draw: *

    // chunky block arrow between panels
    let arrow(p0, p1, col) = line(p0, p1,
      stroke: (paint: col, thickness: 0.22cm),
      mark: (end: (symbol: "stealth", length: 0.55cm, width: 0.6cm, fill: col)),
    )
    let blue = rgb("#3b7fc4")
    let dkred = rgb("#9b2f2f")
    let yellow = rgb("#f0d020")
    let green = rgb("#7cb342")
    let lblue = rgb("#a8d0e6")
    let orange = rgb("#f0a030")

    // ---------- panel a) machine learning ----------
    rect((1.2, 6.2), (12.4, 11.6), radius: 0.6, stroke: (paint: yellow, thickness: 4.5pt))
    content((0.6, 11.3), text(weight: "bold", [a)]), anchor: "center")

    let inx = 2.6
    let h1 = 4.9
    let h2 = 7.0
    let h3 = 9.1
    let ox = 11.3
    let nodes-in = range(4).map(i => (inx, 8.1 + i * 0.75))
    let nodes-h1 = range(5).map(i => (h1, 7.35 + i * 0.75))
    let nodes-h2 = range(5).map(i => (h2, 7.35 + i * 0.75))
    let nodes-h3 = range(5).map(i => (h3, 7.35 + i * 0.75))
    let nodes-out = range(3).map(i => (ox, 8.1 + i * 0.85))
    set-style(stroke: 0.5pt + black)
    for a in (nodes-in + nodes-h1 + nodes-h2 + nodes-h3) {
      for b in (nodes-h1 + nodes-h2 + nodes-h3 + nodes-out) {
        if a.at(0) < b.at(0) { line(a, b) }
      }
    }
    set-style(stroke: 1pt + black)
    for p in nodes-in { circle(p, radius: 0.3, fill: lblue) }
    for p in (nodes-h1 + nodes-h2 + nodes-h3) { circle(p, radius: 0.3, fill: green) }
    for p in nodes-out { circle(p, radius: 0.3, fill: orange) }
    content((6.8, 6.75), text(size: 13pt, weight: "bold", [Machine Learning]), anchor: "center")

    // ---------- chunky arrows down to the three application panels ----------
    arrow((2.2, 6.0), (1.5, 4.4), blue)
    arrow((5.2, 6.0), (4.6, 4.4), blue)
    arrow((7.6, 6.0), (8.1, 4.4), dkred)
    arrow((10.6, 6.0), (11.4, 4.4), dkred)
    content((2.8, 4.75), text(size: 7pt, fill: blue, [Accelerate \ simulations, \ Improve Scaling]), anchor: "west")
    content((8.55, 4.75), text(size: 7pt, fill: dkred, [Improve \ Physical \ Understanding]), anchor: "west")

    // ---------- panel b) DNS ----------
    content((0.35, 4.1), text(weight: "bold", [b)]), anchor: "center")
    rect((0.8, 0.9), (3.6, 4.0), radius: 0.4, stroke: (paint: blue, thickness: 3pt))
    for i in range(7) {
      line((1.15 + i * 0.32, 1.3), (1.15 + i * 0.32, 3.65), stroke: 0.5pt + black)
      line((1.15, 1.3 + i * 0.39), (3.07, 1.3 + i * 0.39), stroke: 0.5pt + black)
    }
    rect((1.15, 1.12), (3.07, 1.3), fill: gray, stroke: none)
    line((1.35, 1.6), (1.6, 1.95), (2.1, 2.45), (2.6, 2.95), (2.95, 3.25), (3.05, 3.4),
         (2.85, 3.5), (2.4, 3.12), (1.9, 2.62), (1.5, 2.2), (1.3, 1.85),
      close: true, fill: blue, stroke: 1pt + black)
    content((2.2, 0.35), text(size: 11pt, weight: "bold", [Direct Numerical \ Simulation]), anchor: "center")

    // ---------- panel c) turbulence modelling ----------
    content((4.0, 4.1), text(weight: "bold", [c)]), anchor: "center")
    rect((4.3, 0.9), (9.6, 4.0), radius: 0.4, stroke: (paint: green, thickness: 3pt))
    line((4.9, 1.4), (7.0, 1.4), stroke: 1.6pt + black,
      mark: (end: (symbol: "stealth", length: 0.28, width: 0.3, fill: black)))
    line((4.9, 1.4), (4.9, 3.5), stroke: 1.6pt + black,
      mark: (end: (symbol: "stealth", length: 0.28, width: 0.3, fill: black)))
    content((4.62, 2.45), text(size: 8pt, [Energy]), angle: 90deg, anchor: "center")
    content((5.95, 1.15), text(size: 8pt, [wavenumber]), anchor: "center")
    line((5.0, 1.75), (5.3, 2.6), (5.65, 3.15), (6.05, 3.25), (6.45, 2.9), (6.85, 2.3), (7.2, 1.7), (7.45, 1.45),
      stroke: (paint: yellow, thickness: 3.5pt, cap: "round", join: "round"))
    line((6.05, 1.5), (6.05, 3.62), stroke: (paint: green, thickness: 2pt, dash: "dashed"))
    content((5.6, 3.72), text(size: 7pt, [resolved]), anchor: "center")
    content((6.75, 2.55), text(size: 7pt, [modelled]), angle: -50deg)
    for (p, r) in (((5.35, 2.55), 0.2), ((5.95, 2.0), 0.16), ((5.5, 1.75), 0.12)) {
      arc(p, start: 30deg, stop: 300deg, radius: r, stroke: 0.8pt + black)
    }
    content((8.5, 3.2), text(8pt, [$tilde(u)_i = U_i + u_i$]))
    line((8.5, 2.75), (8.5, 2.2), stroke: (paint: blue, thickness: 0.16cm),
      mark: (end: (symbol: "stealth", length: 0.3cm, width: 0.32cm, fill: blue)))
    content((8.5, 1.85), text(8pt, [$f(nu_T)$]))

    content((6.95, 0.35), text(size: 11pt, weight: "bold", [Turbulence Modeling \ (LES and RANS)]), anchor: "center")

    // ---------- panel d) ROM ----------
    content((10.0, 4.1), text(weight: "bold", [d)]), anchor: "center")
    rect((10.3, 0.9), (12.9, 4.0), radius: 0.4, stroke: (paint: orange, thickness: 3pt))
    let lin = range(4).map(i => (10.75, 1.55 + i * 0.6))
    let lout = range(4).map(i => (12.45, 1.55 + i * 0.6))
    let mid = range(2).map(i => (11.6, 2.15 + i * 0.6))
    set-style(stroke: 1pt + blue)
    for a in lin { for b in mid { bezier(a, b, (a.at(0) + 0.45, a.at(1)), (b.at(0) - 0.3, b.at(1))) } }
    for a in mid { for b in lout { bezier(a, b, (a.at(0) + 0.3, a.at(1)), (b.at(0) - 0.45, b.at(1))) } }
    set-style(stroke: 1pt + black)
    rect((11.35, 1.95), (11.85, 2.95), radius: 0.12, fill: yellow)
    for p in (lin + lout) { circle(p, radius: 0.13, fill: lblue) }
    for p in mid { circle(p, radius: 0.13, fill: lblue) }
    content((11.6, 0.35), text(size: 11pt, weight: "bold", [Reduced-Order \ Models]), anchor: "center")
  }),
  caption: [
    #strong[Summary of some of the most relevant areas where machine learning can enhance CFD.] a) Neural network illustrating the field of machine learning. b) In direct numerical simulations, computational grids fine enough to properly resolve the details of the flow structures (such as the one shown in blue) are needed. The grey band denotes the wall. c) The left subpanel illustrates large-eddy simulation (LES), and we show a schematic of the turbulence spectrum, where the larger scales (to the left of the green vertical line, #emph[i.e.] the cut-off wavenumber) are numerically simulated, and the smaller ones (to the right of the cut-off) are represented by a model. Since these smaller scales do not need to be resolved, the computational cost of the simulation is reduced. The right subpanel illustrates Reynolds-averaged Navier--Stokes (RANS) simulations, where $tilde(u)_i$ is the instantaneous velocity component $i$, $U_i$ the mean and $u_i$ the fluctuating component. In RANS models, the fluctuations are usually expressed as a function of the eddy viscosity $nu_T$. d) General schematic of a dimensionality-reduction method, where the circles denote flow quantities. The input (on the left in blue) is the high-resolution flow field, the output (on the right in red) is the reconstruction of the input field, and the yellow box represents the low-dimensional system.
  ]
) <fig:fig1>

= Accelerating direct numerical simulations <sec:performance>

Direct numerical simulation (DNS) is a high-fidelity approach where the governing Navier--Stokes equations are discretized and integrated in time with enough degrees of freedom to resolve all flow structures. Turbulent flows exhibit a pronounced multi-scale character, with vortical structures across a range of sizes and energetic content @vinuesa_ftac. This complexity requires fine meshes and accurate computational methods to avoid distorting the underlying physics with numerical artifacts. With a properly designed DNS, it is possible to obtain a representation of the flow field with the highest level of detail among CFD methods. However, the fine computational meshes required to resolve the smallest scales lead to exceedingly high computational costs, which increase with the Reynolds number @choi_moin.

A number of machine-learning approaches have been developed recently to improve the efficiency of DNS. First, we will discuss several studies aimed at improving discretization schemes. Bar-Sinai #emph[et al.] @bar2019learning proposed a technique based on deep learning to estimate spatial derivatives in low-resolution grids, outperforming standard finite-difference methods. A similar approach was developed by Stevens and Colonius @stevens2020enhancement to improve the results of fifth-order finite-difference schemes in the context of shock-capturing simulations. Jeon~and~Kim @jeon_kim proposed to use a deep neural network to simulate the well-known finite-volume discretization scheme @eymard2000finite employed in fluid simulations. They tested their method with reactive flows, obtaining very good agreement with reference high-resolution data at one tenth the computational cost. However, they also documented errors with respect to the reference solution which increased with time. Another deep-learning approach, based on a fully-convolutional/long-short-term-memory (LSTM) network, was proposed by Stevens~and~Colonius @stevens2020finitenet to improve the accuracy of finite-difference/finite-volume methods. Second, we consider the strategy of developing a correction between fine- and coarse-resolution simulations. This was developed by Kochkov~#emph[et al.] @chandler for the two-dimensional Kolmogorov flow @chandler, which maintains fluctuations via a forcing term. They leveraged deep learning to develop the correction, obtaining excellent agreement with reference simulations in meshes from 8 to 10 times coarser in each dimension, as shown in @chandler. In particular, this figure shows that for long simulations, the standard coarse-resolution case does not exhibit certain important vortical motions, which are however properly captured by the low-resolution case with the ML model. These results promise to substantially reduce the computational cost of relevant fluid simulations, including weather @bauer_et_al, climate @freddy, engineering @vinuesa_et_al_2018 and astrophysics @toras2018towards. Finally, other strategies to improve the performance of PDE solvers in coarser meshes have been developed by Li @li2020neural @li2020multipole @li2020fourier #emph[et al.]

// [figvision] imgs/Fig2a_data.png
// Panel (a) of a composite figure: a 3-row x 4-column grid of instantaneous vorticity
// snapshots, with a blue arrow labelled "Time" pointing right above the columns.
// Rows (labels rotated on the left): "Original resolution" (top), "Low resolution + ML"
// (middle), "Low resolution" (bottom).
// Each cell is a thin-slab vorticity field in a magma-like divergent map; the colour bar
// at the right runs from -10 (cyan/blue) through 0 (black) to +10 (red/orange/cream),
// labelled "Vorticity".
// Yellow squares highlight the same small vortical structure in every row of columns 1,
// 2 and 4: the filament pair is resolved in the original and ML-corrected rows but is
// blurred or absent in the low-resolution-only row. Column 3's highlighted structure is
// a single small vortex that survives in all rows but is sharper with ML.
// Small black tick-like markers sit along the "Time" arrow between columns.
#figure(placement: top, 
  grid(columns: (68%, 32%), column-gutter: 2%,
    image("imgs/Fig2a_data.png", width: 100%),
    align(center, scale(62%, include "figures/schematic_fig2b.cetz.typ")),
  ),
  caption: [
    #strong[An example of machine-learning-accelerated direct numerical simulation.] a) Results from the work by Kochkov~#emph[et al.] @hoyer, where the instantaneous vorticity field is shown for simulations with high-/low-resolution, as well as a case with low resolution supplemented with ML. Four different time steps are shown, and some key vortical structures are highlighted with yellow squares. Adapted from the work by Kochkov~#emph[et~al.] @hoyer, with permission of the publisher (United States National Academy of Sciences). b) Sketch represents that ML accelerates the simulation through a correction between the coarse and the fine resolutions. In this example, one can reduce the resolution by downsampling the flow data on a coarser mesh, and then use ML to recover the details present in the finer simulation through super-resolution. The correction between coarse and fine resolutions, which is based on ML, enables the super-resolution task here.
  ]
) <fig:fig2>

It is also possible to accelerate CFD by solving the Poisson equation with deep learning; this has been done by several research groups in various areas, such as simulations of electric fields @poisson2 and particles @poisson. The Poisson equation is frequently used in operator-splitting methods to discretize the Navier--Stokes equations @bridson, where first the velocity field is advected, and the resulting field $bold(u)^*$ does not satisfy the continuity equation (#emph[i.e.] for incompressible flows, $bold(u)^*$ does not satisfy the divergence-free condition). The second step involves a correction to ensure that $bold(u)^*$ is divergence free, leading to the following Poisson equation:
$
  frac(Delta t, rho) nabla^2 p = - nabla dot.op bold(u)^* ,
$<ec:poisson>
where $Delta t$ is the simulation time step, $rho$ is the fluid density, and $p$ is the pressure. Solving this equation is typically the most computationally expensive step of the numerical solver. Therefore, devising alternative strategies to solve it more efficiently is an area of great promise. Machine learning can be used for this task, because this technology can exploit data from previous examples to find mappings between the divergence of the uncorrected velocity and the resulting pressure field. For instance, Ajuria~#emph[et al.] @poisson3 proposed using a convolutional neural network (CNN) to solve @ec:poisson in incompressible simulations, and tested it in a plume configuration. Their results indicate that it is possible to outperform the traditional Jacobi solver with good accuracy at low Richardson numbers $R i$ (the Richardson number measures the ratio between the buoyancy and the shear in the flow). However, the accuracy degrades at higher $R i$, motivating the authors to combine the CNN with the Jacobi solver (which is used when the CNN diverges). CNNs were also used to solve the Poisson problem by decomposing the original problem into a homogeneous Poisson problem plus four inhomogeneous Laplace subproblems @poisson_imperial. This decomposition resulted in errors below $10%$, which motivates using this approach as a first guess in iterative algorithms, potentially reducing computational cost. Other data-driven methods @Weymouth have been proposed to accelerate the pressure correction in multi-grid solvers. These approaches may also be used to accelerate simulations of lower fidelity that rely on turbulence models.

Numerical simulations can also be accelerated by decreasing the size of the computational domain needed to retain physical properties of the system. Two ways in which the domain can be reduced are to replace a section upstream of the domain of interest by an inflow condition, and to replace part of the far-field region by a suitable boundary condition. Doing so, these parts of the domain do not need to be simulated, thus producing computational savings, and ML can help to develop the inflow and far-field conditions as discussed next. Fukami~#emph[et al.] @fukami_inflow developed a time-dependent inflow generator for wall-bounded turbulence simulations using a convolutional autoencoder with a multilayer perceptron (MLP). They tested their method in a turbulent channel flow at $R e_tau = 180$, which is the friction Reynolds number based on channel half height and friction velocity, and they maintained turbulence for an interval long enough to obtain converged turbulence statistics. This is a promising research direction due to the fact that current inflow-generation methods show limitations in terms of generality of the inflow conditions, for instance at various flow geometries and Reynolds numbers. A second approach to reduce the computational domain in external flows is to devise a strategy to set the right pressure-gradient distribution without having to simulate the far field. This was addressed by Morita~#emph[et al.] @morita_et_al through Bayesian optimization based on Gaussian-process regression, achieving accurate results when imposing concrete pressure-gradient conditions on a turbulent boundary layer.

= Improving turbulence models <sec:rans>

DNS is impractical for many real-world applications due to the computational cost associated with resolving all scales for flows with high Reynolds numbers, together with difficulties arising from complex geometries. Industrial CFD typically relies on either Reynolds-averaged Navier--Stokes (RANS) models, where no turbulent scales are simulated, or coarsely-resolved large-eddy simulations (LES), where only the largest turbulent scales are resolved and smaller ones are modelled. Here the term #emph[model] refers to an #emph[a-priori] assumption regarding the physics of a certain range of turbulent scales. In the following we discuss ML applications to RANS and LES modeling.

== RANS modeling <rans-modeling>

Numerical simulations based on RANS models rely on the so-called RANS equations, which are obtained after decomposing the instantaneous flow quantities into a mean and a fluctuating component, and averaging the Navier--Stokes equations in time. Using index notation, the instantaneous $i$-th velocity component $tilde(u)_i$ can be decomposed into its mean ($U_i$) and fluctuating ($u_i$) components as follows: $tilde(u)_i = U_i + u_i$. Although the RANS equations govern the mean flow, the velocity fluctuations are also present in the form of the Reynolds stresses $overline(u_i u_j)$\(where the overbar denotes averaging in time), which are correlations between the $i$-th and $j$-th velocity components. Since it is convenient to derive equations containing only mean quantities, $overline(u_i u_j)$ needs to be expressed as a function of the mean flow, and this is called the #emph[closure problem]. The first approach to do this was proposed by Boussinesq @boussinesq, who related the Reynods stresses with the mean flow via the so-called eddy viscosity $nu_T$. Although this approach has led to some success, there are still a number of open challenges for RANS modeling in complex flows @NASA, where this approach is too simple. In particular, conventional RANS models exhibit significant errors when dealing with complex pressure-gradient distributions, complicated geometries involving curvature, separated flows, flows with significant degree of anisotropy and three-dimensional effects, among others. As argued by Kutz @kutz2017deep, machine learning can produce more sophisticated models for the Reynolds stresses by using adequate data, in particular if the examples used for training represent a sufficiently rich set of flow configurations.

A wide range of ML methods have recently been used to improve RANS turbulence modeling @duraisamy_et_al, focusing on the challenge of improving the accuracy of the Reynolds stresses for general conditions. For example, Ling~#emph[et al.] @ling2016reynolds proposed a novel architecture, including a multiplicative layer with an invariant tensor basis, used to embed Galilean invariance in the predicted anisotropy tensor. Incorporating this invariance improves the performance of the network, which outperforms traditional RANS models based on linear @boussinesq and nonlinear @craft_et_al eddy-viscosity models. They tested their models for turbulent duct flow and the flow over a wavy wall, which are challenging to predict with RANS models @hexagon @spalart because of the presence of secondary flows @wavy. Other ML-based approaches @wang2017physics @wu_et_al rely on physics-informed random forests to improve RANS models, with applications to cases with secondary flows and separation. On the other hand, Jiang~#emph[et al.] @ml_rans recently developed an interpretable framework for RANS modeling based on a physics-informed residual network (PiResNet). Their approach relies on two modules to infer the structural and parametric representations of turbulence physics, and includes non-unique mappings, a realizability limiter, and noise-insensitivity constraints. Interpretable models are essential for engineering and physics, particularly in the context of turbulence modeling. The interpretability of the framework by Jiang~#emph[et al.] @rudin relies on its constrained model form @rudin, although this is not generally possible to attain. Recent studies @vinuesa_interp have discussed various approaches to include interpretability in the development of deep-learning models, and one promising approach is the one proposed by Cranmer #emph[et al.] @cranmer_et_al. This technique has potential in terms of embedding physical laws and improving our understanding of such phenomena. Other interpretable RANS models were proposed by Weatheritt~and~Sandberg @sandberg1, using gene-expression programming (GEP), which is a branch of evolutionary computing @gep. GEP iteratively improves a population of candidate solutions by survival of the fittest, with the advantage of producing closed-form models. The Reynolds-stress anisotropy tensor was also modelled by Weatheritt~and~Sandberg @sandberg2, who performed tests in RANS simulations of turbulent ducts. Models based on sparse identification of nonlinear dynamics (SINDy) @Brunton2016pnas have also been used for RANS closure models @beetham2020formulating @schmelzer2020discovery @beetham2021sparse.

Furthermore, the literature also reflects the importance of imposing physical constraints in the models and incorporating uncertainty-quantification (UQ) @rezaeiravesh @iaccarino1 @iaccarino2 alongside ML-based models. It is also important to note that when using DNS quantities to replace terms in the RANS closure, the predictions may be unsatisfactory @poroseva_et_al. This inadequacy is due to the strict assumptions associated with the RANS model, as well as the potential ill-conditioning of the RANS @wu_et_al_2018. It is thus essential to take advantage of novel data-driven methods, while also ensuring that uncertainties are identified and quantified. Another interesting review by Ahmed~#emph[et al.] @ahmed2021closures discussed both classical and emerging data-driven closure approaches, also connecting with ROMs.

Obiols-Sales~#emph[et al.] @accelerator developed a method to accelerate the convergence of RANS simulations based on the very popular Spalart--Allmaras (SA) turbulence model @sa using the CFD code OpenFOAM @openfoam. In essence, they combined iterations from the CFD solver and evaluation of a CNN model, obtaining convergence from 1.9 to 7.4 times faster than that of the CFD solver, both in laminar and turbulent flows. Multiphase flows, which consist of flows with two or more thermodynamic phases, are also industrially relevant. Gibou~#emph[et al.] @multiphase proposed different directions in which machine learning and deep learning can improve CFD of multiphase flows, in particular when it comes to enhancing the simulation speed. Ma~#emph[et al.] @ma_et_al used deep learning to predict the closure terms (i.e., gas flux and streaming stresses) in their two-fluid bubble flow, whereas Mi~#emph[et al.] @mi_et_al analyzed gas-liquid flows and employed neural networks to identify the different flow regimes.

== LES modeling <les-modeling>

LES-based numerical simulations rely on low-pass filtering the Navier--Stokes equations (@mi_et_al), such that the largest scales are simulated and the smallest ones (below a certain cut-off) are modeled by means of a so-called subgrid-scale model (SGS). Note that the smallest scales are the most demanding from a computational point of view \(both in terms of computer time and memory usage), because they require fine meshes to be properly resolved. The first proponent of this type of approach was Smagorinski @smagorinski, who developed an SGS model based on an eddy viscosity which was computed in terms of the mean flow and the grid size; his model assumed that the production equals the dissipation for the small scales. Although LES can lead to substantial computational savings with respect to DNS while exhibiting a good accuracy, there are still challenges associated with its usage for general purpose @NASA. For instance, current SGS models exhibit limited accuracy in their predictions of turbulent flows at high Reynolds number, in complex geometries, and in cases with shocks and chemical reactions.

Machine learning has also been used to develop SGS models in the context of LES of turbulent flows basically in two ways: supplementing the unresolved energy in the coarse mesh using supervised learning and developing agent-based approaches to stabilize the coarse simulation. When it comes to the first approach, we list several studies below which rely on high-fidelity data to train both deep-learning and GEP-based models. First, Beck~#emph[et al.] @beck_et_al used an artificial neural network based on local convolutional filters to predict the mapping between the flow in a coarse simulation and the closure terms, using a filtered DNS of decaying homogeneous isotropic turbulence. Lapeyre~#emph[et al.] @lapeyre_et_al employed a similar approach, with a CNN architecture inspired by a U-net model, to predict the subgrid-scale wrinkling of the flame surface in premixed turbulent combustion; they obtained better results than classical algebraic models. Maulik~#emph[et al.] @maulik2019subgrid employed a multilayer perceptron (MLP) to predict the SGS model in an LES using high-fidelity numerical data to train the model. They evaluated the performance of their method on Kraichnan turbulence @kraichnan, which is a classical two-dimensional decaying-turbulence test case. Several other studies have also used neural networks in a supervised manner for SGS modeling @vollant @gamahara @maulik. Furthermore, GEP has also been used for SGS modeling @sandberg3 in an LES of a Taylor--Green vortex, outperforming standard LES models. Regarding the second approach to LES modeling, Novati~#emph[et al.] @petros_natmi employed multi-agent reinforcement-learning (RL) to estimate the unresolved subgrid-scale physics. This unsupervised method exhibits favorable generalization properties across grid sizes and flow conditions, and the results are presented for isotropic turbulence. As shown in the schematic representation of @fig:fig4, the state of the agents at a particular instant is given in terms of both local and global variables; this state is then used to calculate the so-called dissipation coefficient at each grid point.

#figure(
  cetz.canvas(length: 0.55cm, padding: 0.15cm, {
    import cetz.draw: *

    let green = rgb("#2e8b57")
    let blue = rgb("#3b7fc4")
    let teal = rgb("#159a9a")
    let orange = rgb("#f0a030")
    let red = rgb("#d62728")

    // ===================== panel a) unresolved scales =====================
    content((0.0, 5.6), text(weight: "bold", [a)]), anchor: "west")
    rect((0.6, 0.4), (5.0, 5.4), radius: 0.5, stroke: (paint: green, thickness: 3pt))
    content((2.8, 4.75), text(6pt, [ML helps to model \ #text(fill: green)[unresolved] flow scales]))
    line((2.75, 3.98), (2.75, 3.52), stroke: (paint: green, thickness: 0.13cm),
      mark: (end: (symbol: "stealth", length: 0.28cm, width: 0.32cm, fill: green)))
    for i in range(4) {
      line((1.2 + i * 0.8, 0.9), (1.2 + i * 0.8, 3.3), stroke: 0.7pt + black)
      line((1.2, 0.9 + i * 0.8), (3.6, 0.9 + i * 0.8), stroke: 0.7pt + black)
    }
    arc((1.85, 2.45), start: 30deg, stop: 320deg, radius: 0.42, stroke: (paint: blue, thickness: 3.5pt))
    arc((2.85, 1.65), start: 210deg, stop: 500deg, radius: 0.40, stroke: (paint: blue, thickness: 3.5pt))
    circle((2.75, 3.3), radius: (0.22, 0.15), fill: green.lighten(75%),
      stroke: (paint: green, thickness: 1.2pt, dash: "dashed"))

    // ===================== panel b) RL agent flow diagram =====================
    content((5.6, 5.6), text(weight: "bold", [b)]), anchor: "west")
    // cube wireframe
    let A = (6.0, 1.0)
    let B = (9.2, 1.0)
    let C = (9.2, 4.2)
    let D = (6.0, 4.2)
    let H = (7.3, 5.2)
    let G = (10.5, 5.2)
    let F = (10.5, 2.0)
    rect(A, C, fill: teal.lighten(72%), stroke: 1pt + black)
    line(D, H); line(C, G); line(B, F)
    line(H, G, stroke: 1pt + black); line(G, F, stroke: 1pt + black)
    for i in range(3) {
      for j in range(3) {
        rect((6.6 + i * 0.85 - 0.09, 1.5 + j * 0.85 - 0.09), (6.6 + i * 0.85 + 0.09, 1.5 + j * 0.85 + 0.09),
          fill: red, stroke: none)
      }
    }
    // agent highlight circle with orange cube
    circle((12.9, 3.3), radius: 1.1, stroke: 1.5pt + red)
    rect((12.6, 3.2), (13.2, 3.8), fill: orange, stroke: 1pt + black)
    content((12.9, 2.8), text(size: 7pt, weight: "bold", [Agent i]))
    content((13.25, 3.95), text(size: 7pt, weight: "bold", [$bold(x)^(i)$]))
    line((10.5, 3.0), (11.85, 3.2), stroke: 1pt + red,
      mark: (end: (symbol: "stealth", length: 0.22cm, width: 0.24cm, fill: red)))

    // global / local state boxes
    rect((15.2, 4.1), (17.8, 5.3), radius: 0.2, stroke: 1.5pt + teal)
    content((16.5, 4.7), text(7pt, [Global \ state]))
    rect((15.2, 2.7), (17.8, 3.9), radius: 0.2, stroke: 1.5pt + teal)
    content((16.5, 3.3), text(7pt, [Local \ state]))
    line((13.85, 3.8), (15.2, 4.55), stroke: 1pt + teal,
      mark: (end: (symbol: "stealth", length: 0.22cm, width: 0.24cm, fill: teal)))
    line((13.95, 2.95), (15.2, 3.3), stroke: 1pt + teal,
      mark: (end: (symbol: "stealth", length: 0.22cm, width: 0.24cm, fill: teal)))
    line((17.8, 4.7), (18.5, 4.7), stroke: (paint: green, thickness: 0.12cm),
      mark: (end: (symbol: "stealth", length: 0.28cm, width: 0.3cm, fill: green)))
    line((17.8, 3.3), (18.5, 3.3), stroke: (paint: green, thickness: 0.12cm),
      mark: (end: (symbol: "stealth", length: 0.28cm, width: 0.3cm, fill: green)))
    content((18.6, 4.7), text(size: 5.5pt, [Energy spectrum, viscous \ dissipation rate and \ total dissipation rate]), anchor: "west")
    content((18.6, 3.3), text(size: 5.5pt, [Invariants of the \ gradient and Hessian \ of the velocity]), anchor: "west")
    content((23.15, 4.0), text(size: 36pt, [}]), anchor: "center")
    content((23.6, 4.0), text(size: 9pt, [Agent \ state]), anchor: "west")

    // dissipation coefficient box + policy
    rect((15.2, 0.4), (20.6, 1.6), radius: 0.2, stroke: 1.5pt + green)
    content((17.9, 1.0), text(7pt, [Dissipation coefficient \ at $bold(x)^i$ and t]))
    content((26.5, 1.0), text(size: 6pt, [Policy, which depends \ on the agent state]), anchor: "east")
    line((20.8, 1.0), (22.8, 1.0), stroke: (paint: black, thickness: 0.12cm),
      mark: (start: (symbol: "stealth", length: 0.3cm, width: 0.32cm, fill: black)))
    line((15.2, 1.3), (13.7, 2.5), stroke: 1pt + green,
      mark: (end: (symbol: "stealth", length: 0.22cm, width: 0.24cm, fill: green)))

    // reward box
    line((12.35, 2.5), (11.75, 1.0), stroke: 1pt + red,
      mark: (end: (symbol: "stealth", length: 0.22cm, width: 0.24cm, fill: red)))
    rect((9.6, -0.35), (12.2, 1.0), radius: 0.2, stroke: 1.5pt + orange)
    content((10.9, 0.32), text(size: 6pt, [Reward = \ Global + \ Local]))
  }),
  caption: [
    #strong[An example of LES modeling where the dissipation coefficient in the Smagorinski model is calculated by means of machine learning.] a) Schematic of a numerical simulation fine enough to resolve the blue flow structures, but too coarse to resolve the green structure. This small-scale structure (green) would have to be modeled by means of a subgrid-scale (SGS) model, such as the well-known SGS model by Smagorinski @smagorinski. This model relies on an empirical parameter, the dissipation coefficient $C_s$, which can be determined more accurately by ML. b) An example of ML-based approach to determine the value of $C_s$ by reinforcement learning (RL) @petros_natmi. The RL agents are located at the red blocks, and they are used to compute $C_s$ for each grid point with coordinates $("x")^i$ at time $t$. This calculation is carried out in terms of a policy, which depends on the state of the agent. This state is based on local variables (invariants of the gradient and Hessian of the velocity) and also global ones (energy spectrum, viscous dissipation rate and total dissipation rate). The agents receive a reward, which also depends on local and global quantities, based on the accuracy of the simulation. Adapted from the work by Novati~#emph[et~al.] @petros_natmi, with permission of the publisher (Springer Nature).
  ]
) <fig:fig4>

In certain applications, for instance those involving atmospheric boundary layers (ABLs), the Reynolds number is several orders of magnitude larger than those of most studies based on turbulence models or wind-tunnel experiments @hutchins. The mean flow in the inertial sublayer has been widely studied in the ABL community, and it is known that in neutral conditions it can be described by a logarithmic law @log. The logarithmic description of the inertial sublayer led to the use of wall models, which replace the region very close to the wall with a model defining a surface shear stress matching the logarithmic behavior. This is the cornerstone of most atmospheric models, which avoid resolving the computationally expensive scales close to the wall. One example is the work by Giometto~#emph[et al.] @giometto, who studied a real urban geometry, adopting the LES model by Bou-Zeid~#emph[et al.] @bou_zeid and the Moeng model @moeng for the wall boundary condition. It is possible to use data-driven approaches to develop mappings between the information in the outer region (which is resolved) and a suitable off-wall boundary condition (so the near-wall region does not need to be resolved). For instance, it is possible to exploit properties of the logarithmic layer and rescale the flow in the outer region to set the off-wall boundary condition in turbulent channels @mizuno_jimenez @gmayoral. This may also be accomplished via transfer functions in spectral space @sasaki, convolutional neural networks @ari_etmm, or modeling the temporal dynamics of the near-wall region via deep neural networks @milano_koumoutsakos. Other promising approaches based on deep learning are the one by Moriya~#emph[et al.] @moriya, based on defining a virtual velocity, and the reinforcement-learning technique by Bae~and~Koumoutsakos @bae_koumoutsakos. Defining off-wall boundary conditions with machine learning is a challenging yet promising area of research.

= Developing reduced-order models <sec:roms>
Machine learning is also being used to develop reduced-order models (ROMs) in fluid dynamics. ROMs rely on the fact that even complex flows often exhibit a few dominant coherent structures @Taira2017aiaa @Rowley2017arfm @Taira2020aiaaj that may provide coarse, but valuable information about the flow. Thus, ROMs describe the evolution of these coherent structures, providing a lower-dimensional, lower-fidelity characterization of the fluid. In this way, ROMs provide a fast surrogate model for the more expensive CFD techniques described above, enabling optimization and control tasks that rely on many model iterations or fast model predictions. The cost of this efficiency is a loss of generality: ROMs are tailored to a specific flow configuration, providing massive acceleration but a limited range of applicability.

Developing a reduced-order model involves (1) finding a set of reduced #emph[coordinates], typically describing the amplitudes of important flow structures, and (2) identifying a differential-equation model (#emph[i.e.], a dynamical system) for how these amplitudes evolve in time. Both of these stages have seen incredible recent advances with machine learning. One common ROM technique involves learning a low-dimensional coordinate system with the proper orthogonal decomposition (POD) @lumley @Taira2017aiaa and then obtaining a dynamical system for the flow system restricted to this subspace by Galerkin projection of the Navier--Stokes equations onto these modes. Although the POD step is data driven, working equally well for experiments and simulations, Galerkin projection requires a working numerical implementation of the governing equations; moreover, it is often #emph[intrusive], involving custom modifications to the numerical solver. The related dynamic-mode decomposition (DMD) @Schmid2010jfm is a purely data-driven procedure that identifies a low-dimensional subspace and a linear model for how the flow evolves in this subspace. Here, we will review a number of recent developments to extend these approaches with machine learning.

The first broad opportunity to incorporate machine learning into ROMs is in learning an improved coordinate system in which to represent the reduced dynamics. POD @lumley @Taira2017aiaa provides an orthogonal set of modes that may be thought of as a data-driven generalization of Fourier modes, which are tailored to a specific problem. POD is closely related to principal-component analysis (PCA) and the singular-value decomposition (SVD) @Brunton2019book, which are two core dimensionality-reduction techniques used in data-driven modeling. These approaches provide linear subspaces to approximate data, even though it is known that many systems evolve on a nonlinear manifold. Deep learning provides a powerful approach to generalize the POD/PCA/SVD dimensionality reduction from learning a linear subspace to learning coordinates on a curved manifold. Specifically, these coordinates may be learned using a neural network #emph[autoencoder], which has an input and output the size of the high-dimensional fluid state and a constriction or bottleneck in the middle that reduces to a low-dimensional latent variable. The map from the high-dimensional state $upright(bold(x))$ to the latent state $upright(bold(z))$ is called the #emph[encoder] and the map back from the latent state to an estimate of the high-dimensional state $hat(upright(bold(x)))$ is the #emph[decoder]. The autoencoder loss function is $parallel hat(upright(bold(x))) - upright(bold(x)) parallel_2^2$. When the encoder and decoder consist of a single layer and all nodes have identity activation functions, then the optimal solution to this network will be closely related to POD @baldi1989neural. However, this shallow linear autoencoder may be generalized to a deep nonlinear autoencoder with multiple encoding and decoding layers and nonlinear activation functions for the nodes. In this way, a deep autoencoder learns nonlinear manifold coordinates that may considerably improve the compression in the latent space, with increasing applications in fluid mechanics @murata2020nonlinear @ae_modal. This concept is illustrated in @fig:ROMfig for the simple flow past a cylinder, where it is known that the energetic coherent structures evolve on a parabolic sub-manifold in the POD subspace @Noack2003jfm.  Lee and Carlberg @lee2020model recently showed that deep convolutional autoencoders may be used to greatly improve the performance of classical ROM techniques based on linear subspaces @Benner2015siamreview @Carlberg2017jcp. More recently, Cenedese~#emph[et~al.] @cenedese_et_al proposed a promising data-driven method to construct ROMs on spectral submanifolds (SSMs).

#figure(
  cetz.canvas(length: 0.82cm, padding: 0.15cm, {
    import cetz.draw: *

    let red = rgb("#d62728")
    let blue = rgb("#1f77b4")
    let purple = rgb("#cdb4ec")
    let cream = rgb("#f7f2da")
    let cyan = rgb("#5bc8f5")
    let r = 0.16
    let s = 0.44
    let hh(n) = (n - 1) * s / 2 + r

    let nodes(x, oy, n, fill) = {
      for i in range(n) {
        circle((x, oy + (hh(n) - r) - i * s), radius: r, fill: fill, stroke: 0.8pt + black)
      }
    }
    let colbar(x, oy, n) = {
      let h = 2 * (hh(n) + 0.07)
      rect((x - 0.27, oy - h / 2), (x + 0.27, oy + h / 2), radius: 0.27, fill: cream, stroke: 1.4pt + black)
    }
    let funnel(xa, ha, xb, hb, oy, fill) = {
      line((xa, oy + ha), (xb, oy + hb), (xb, oy - hb), (xa, oy - ha), close: true, fill: fill, stroke: none)
    }
    // flow-past-cylinder snapshot stack (schematic)
    let wake(ox, oy) = {
      for k in range(3) {
        rect((ox + 0.14 * k, oy + 0.20 * k), (ox + 0.14 * k + 1.7, oy + 0.20 * k + 1.15),
          fill: white, stroke: 0.5pt + gray.darken(25%))
      }
      let fx = ox + 0.28
      let fy = oy + 0.40
      circle((fx + 0.28, fy + 0.55), radius: 0.15, fill: gray, stroke: 0.6pt + black)
      circle((fx + 0.85, fy + 0.72), radius: (0.42, 0.20), fill: red.lighten(35%), stroke: none)
      circle((fx + 1.20, fy + 0.50), radius: (0.38, 0.18), fill: blue.lighten(35%), stroke: none)
      circle((fx + 1.05, fy + 0.85), radius: (0.28, 0.14), fill: red.lighten(55%), stroke: none)
    }
    let lbl(p, t) = content(p, text(size: 12pt, weight: "bold", t), anchor: "south")

    // ===================== panel a) shallow linear AE =====================
    let ay = 8.0
    wake(0.1, ay - 0.6)
    colbar(3.0, ay, 5); funnel(3.0, hh(5), 4.7, hh(3), ay, purple); colbar(4.7, ay, 3); funnel(4.7, hh(3), 6.4, hh(5), ay, purple); colbar(6.4, ay, 5)
    nodes(3.0, ay, 5, red); nodes(4.7, ay, 3, blue); nodes(6.4, ay, 5, red)
    content((3.85, ay), text(size: 14pt, weight: "bold", [$bold(U)^text(T)$]), anchor: "center")
    content((5.55, ay), text(size: 14pt, weight: "bold", [$bold(V)$]), anchor: "center")
    lbl((3.0, ay + hh(5)), [$bold(x)$]); lbl((4.7, ay + hh(3)), [$bold(z)$]); lbl((6.4, ay + hh(5)), [$hat(bold(x))$])
    content((3.85, ay + 2.0), text(size: 11pt, weight: "bold", [a) Shallow linear autoencoder \(POD / PCA\)]), anchor: "center")
    // 3D subspace coil
    for i in range(5) { circle((4.7, 5.0 - i * 0.22), radius: (0.5 - i * 0.08, 0.16), stroke: 0.6pt + black) }
    line((4.7, 5.1), (4.7, 3.9), stroke: 0.6pt + blue)
    line((4.7, 4.0), (4.3, 3.7), stroke: 0.6pt + blue); line((4.7, 4.0), (5.1, 3.7), stroke: 0.6pt + blue)
    content((6.1, 3.95), text(size: 10pt, [3D subspace \ coordinates]), anchor: "west")
    wake(7.7, ay - 0.6)

    // ===================== panel b) deep nonlinear AE =====================
    let bx = 12.6
    wake(bx - 1.6, ay - 0.6)
    colbar(bx, ay, 5); funnel(bx, hh(5), bx + 1.7, hh(2), ay, purple); colbar(bx + 1.7, ay, 2); funnel(bx + 1.7, hh(2), bx + 3.4, hh(5), ay, purple); colbar(bx + 3.4, ay, 5)
    nodes(bx, ay, 5, red); nodes(bx + 1.7, ay, 2, blue); nodes(bx + 3.4, ay, 5, red)
    content((bx + 0.85, ay), text(size: 14pt, weight: "bold", [$bold(phi)$]), anchor: "center")
    content((bx + 2.55, ay), text(size: 14pt, weight: "bold", [$bold(psi)$]), anchor: "center")
    lbl((bx, ay + hh(5)), [$bold(x)$]); lbl((bx + 1.7, ay + hh(2)), [$bold(z)$]); lbl((bx + 3.4, ay + hh(5)), [$hat(bold(x))$])
    content((bx + 1.7, ay + 2.4), text(size: 11pt, weight: "bold", [b) Deep nonlinear autoencoder]), anchor: "center")
    // 2D manifold cone
    for i in range(6) { circle((bx + 1.7, 5.0 - i * 0.20), radius: (0.55 - i * 0.09, 0.15), fill: blue.lighten(20% + i * 8%), stroke: 0.5pt + blue.darken(20%)) }
    content((bx + 2.6, 3.95), text(size: 10pt, [2D manifold \ coordinates]), anchor: "west")
    wake(bx + 4.7, ay - 0.6)

    // ===================== panel c) Galerkin projection =====================
    let cy = 2.2
    content((1.1, cy + 1.9), text(size: 11pt, weight: "bold", [c)]), anchor: "west")
    colbar(2.6, cy, 5); funnel(2.6, hh(5), 4.3, hh(3), cy, purple); colbar(4.3, cy, 3)
    rect((5.2, cy - 0.8), (6.8, cy + 0.8), radius: 0.15, fill: cyan, stroke: 1.4pt + black)
    content((6.0, cy), text(size: 13pt, weight: "bold", [$bold(f)(bold(z))$]), anchor: "center")
    colbar(7.7, cy, 3); funnel(7.7, hh(3), 9.4, hh(5), cy, purple); colbar(9.4, cy, 5)
    nodes(2.6, cy, 5, red); nodes(4.3, cy, 3, blue); nodes(7.7, cy, 3, blue); nodes(9.4, cy, 5, red)
    content((3.45, cy), text(size: 14pt, weight: "bold", [$bold(U)^text(T)$]), anchor: "center")
    content((8.55, cy), text(size: 14pt, weight: "bold", [$bold(V)$]), anchor: "center")
    lbl((2.6, cy + hh(5)), [$bold(x)$]); lbl((4.3, cy + hh(3)), [$bold(z)$]); lbl((7.7, cy + hh(3)), [$dot(bold(z))$]); lbl((9.4, cy + hh(5)), [$dot(bold(x))$])
    content((6.0, cy - 1.2), text(size: 10pt, weight: "bold", [Galerkin \ projection]), anchor: "center")

    // ===================== panel d) regression model =====================
    let dx = 12.2
    content((dx - 1.5, cy + 1.9), text(size: 11pt, weight: "bold", [d)]), anchor: "west")
    colbar(dx, cy, 5); funnel(dx, hh(5), dx + 1.7, hh(2), cy, purple); colbar(dx + 1.7, cy, 2)
    rect((dx + 2.6, cy - 0.8), (dx + 4.2, cy + 0.8), radius: 0.15, fill: cyan, stroke: 1.4pt + black)
    content((dx + 3.4, cy), text(size: 13pt, weight: "bold", [$bold(f)(bold(z))$]), anchor: "center")
    colbar(dx + 5.1, cy, 2); funnel(dx + 5.1, hh(2), dx + 6.8, hh(5), cy, purple); colbar(dx + 6.8, cy, 5)
    nodes(dx, cy, 5, red); nodes(dx + 1.7, cy, 2, blue); nodes(dx + 5.1, cy, 2, blue); nodes(dx + 6.8, cy, 5, red)
    content((dx + 0.85, cy), text(size: 14pt, weight: "bold", [$bold(phi)$]), anchor: "center")
    content((dx + 5.95, cy), text(size: 14pt, weight: "bold", [$bold(psi)$]), anchor: "center")
    lbl((dx, cy + hh(5)), [$bold(x)$]); lbl((dx + 1.7, cy + hh(2)), [$bold(z)$]); lbl((dx + 5.1, cy + hh(2)), [$dot(bold(z))$]); lbl((dx + 6.8, cy + hh(5)), [$dot(bold(x))$])
    content((dx + 3.4, cy - 1.2), text(size: 10pt, weight: "bold", [Regression \ model]), anchor: "center")
  }),
  caption: [
    #strong[Schematic of neural-network autoencoders for dimensionality reduction and model identification.] Reduced-order models are typically designed to balance efficiency and accuracy. ML solutions further improve the efficiency by reducing the effective dimension of the model and increasing the accuracy through better modeling of how these few variables co-evolve in time. In this figure, the input is a high-resolution flow field evolving in time ($t$) and the output is a reconstruction of that field from the latent space. a) Classic proper orthogonal decomposition/principal component analysis (POD/PCA) may be viewed as a shallow autoencoder with a single encoder $upright(bold(U))^top$ and decoder $upright(bold(V))$ layers, together with linear activation units. For the flow past a cylinder example shown, the dynamics evolve in a three-dimensional coordinate system. b) A deep, multi-level autoencoder with mulit-layer encoder $bold(phi)$ and decoder $bold(psi)$, as well as nonlinear activation functions provides enhanced nonlinear coordinates on a manifold. The cylinder flow now evolves on a two-dimensional submanifold. c) The classic Galerkin-projection model, obtained by projecting the governing Navier--Stokes equations onto an orthogonal basis. The Galerkin-projection model in c) can be replaced by more generic machine-learning regressions in d), such as long-short-term-memory (LSTM) networks, reservoir networks or sparse nonlinear models to represent the nonlinear dynamical system $dot(upright(bold(z))) = upright(bold(f)) ( upright(bold(z)) )$.
  ]
) <fig:ROMfig>

Once an appropriate coordinate system is established, there are many machine-learning approaches to model the dynamics in these coordinates. Several neural networks are capable of learning nonlinear dynamics @sole_conv, including the LSTM network @vlachas_et_al @srinivasan2019predictions @sole_lstm and echo-state networks @pathak2018model, which are a form of reservoir computing. Beyond neural networks, there are alternative regression techniques to learn effective dynamical-systems models. Cluster reduced-order modeling (CROM) @Kaiser2014jfm is a simple and powerful unsupervised-learning approach that decomposes a time series into a few representative clusters, and then models the transition-state probability between clusters. The operator-inference approach is closely related to Galerkin projection, where a neighboring operator is learned from data @peherstorfer2016data @benner2020operator @qian2020lift. The sparse identification of nonlinear dynamics (SINDy) @Brunton2016pnas procedure learns a minimalistic model by fitting the observed dynamics to the fewest terms in a library of candidate functions that might describe the dynamics, resulting in models that are interpretable and balance accuracy and efficiency. SINDy has been used to model a range of fluids @Loiseau2017jfm, @loiseau2020data @guan2020sparse @Deng2020JFM @deng2021galerkin @callaham2021empirical @callaham2021role, including laminar and turbulent wake flows, convective flows, and shear flows.

The modeling approaches above may be combined with a deep autoencoder to uncover a low-dimensional latent space, as in the SINDy-autoencoder @Champion2019pnas. DMD has also been extended to nonlinear coordinate embeddings through the use of deep-autoencoder networks @Yeung2017arxiv @Takeishi2017nips @Lusch2018natcomm @Mardt2018natcomm @Otto2019siads. In all of these architectures, there is a tremendous opportunity to embed partial knowledge of the physics, such as conservation laws @Loiseau2017jfm, symmetries, and invariances @wang2020incorporating @wang2020towards @frezat2021physical. It may also be possible to directly impose stability in the learning pipeline @Loiseau2017jfm @erichson2019physics @kaptanoglu2021promoting.

The ultimate goal for machine-learning ROMs is to develop models that have improved accuracy and efficiency, better generalizability to new initial and boundary conditions, flow configurations, varying parameters, as well as improved model interpretability, ideally with less intrusive methods and less data. Enforcing partially-known physics, such as symmetries and other invariances, along with sparsity, is expected to be critical in these efforts. It is also important to continue integrating these efforts with the downstream applications of control and optimization. Finally, many applications of fluid dynamics involve safety-critical systems, and therefore certifiable models are essential.

= Emerging possibilities and outlook <sec:out>

In this Perspective we have provided our view on the potential of ML to advance the capabilities of CFD, focusing on three main areas: accelerating simulations, enhancing turbulence models, and improving reduced-order models. In @table:summary we highlight some examples of application within each of the three areas. There are also several emerging areas of ML that are promising for CFD, which we discuss in this section. One area is non-intrusive sensing - that is the possibility of performing flow predictions based on, for instance, information at the wall. This task, which has important implications for closed-loop flow control @drl_control, has been carried out via CNNs in turbulent channels @guastoni2. In connection to the work by Guastoni~#emph[et~al.] @guastoni2, there are a number of studies documenting the possibility of performing super-resolution predictions (#emph[e.g.] when limited flow information is available) in wall-bounded turbulence using CNNs, autoencoders and generative-adversarial networks (GANs) @kim910unsupervised @fukami2019super @guemes_gans @fukami_autoencoders. Another promising direction is the imposition of constraints based on physical invariances and symmetries on the ML model, which has been used for SGS modeling @vollant @gamahara @maulik, ROMs @frezat2021physical, and for geophysical flows

#figure(
  table(
    columns: 4,
    align: center,
    table.header([*Accelerate DNS*], [*Improve LES/RANS*], [*Develop ROMs*], [*Future developments*]),
    table.hline(),
    [Deep learning for correction between coarse and fine simulations], [Deep learning / reinforcement learning for more general subgrid-scale models], [Proper-orthogonal decomposition for improved linear subspaces to represent dynamics], [Deep learning for prediction and control of turbulent flows],
    table.hline(),
    [Deep learning for accelerating the solution of the Poisson equation], [Deep learning / reinforcement learning for more robust wall models], [Autoencoders to learn manifolds to represent dynamics], [Better interpretability of deep learning for computational-fluid-dynamics models],
    table.hline(),
    [Domain reduction: deep learning for inflow generation; Gaussian processes for pressure-gradient distributions], [Deep learning / symbolic regression for more accurate and general RANS models], [Deep learning for representing temporal system dynamics], [More efficient operation of high-performance-computing facilities facilitated by ML],
    table.hline(),
    [Deep learning for improved accuracy of finite-difference / finite-volume schemes], [Deep learning / symbolic regression for interpretable RANS models], [Sparse identification of nonlinear dynamics for learning efficient and interpretable ROMs], [ML-enabled more advanced computational architectures],
    table.hline(),
  ),
  caption: [*Summary of applications of ML to enhance CFD.* We show options to accelerate direct numerical simulations (DNSs), improvement of turbulence models for large-eddy simulations (LESs) and Reynolds-averaged Navier--Stokes (RANS) simulations, development of reduced-order models (ROMs) and possible future developments.],
) <table:summary>

Physics-informed neural networks (PINNs) constitute another family of methods that are becoming widely adopted for scientific computing, more broadly. This technique, introduced by Raissi #emph[et al.] @raissi2019physics, uses deep learning to solve PDEs, exploiting the concept of automatic differentiation used in the back-propagation algorithm to calculate partial derivatives and form the equations, which are enforced through a loss function. Although the method is different from the ML approaches discussed above, in certain cases PINNs provide a promising alternative to traditional numerical methods for solving PDEs. This framework also shows promise for biomedical simulations, in particular after the recent work by Raissi #emph[et al.] @raissi_et_al, in which the concentration field of a tracer is used as an input to accurately predict the instantaneous velocity fields by minimizing the residual of the Navier--Stokes equations. The growing usage of PINNs highlights the relevance of exploiting the knowledge we have about the governing equations when conducting flow simulations. In fact, PINNs are being used for turbulence modeling @pinns_etmm (solving the RANS equations without the need of a model for the Reynolds stresses), for developing ROMs @kim_pinns, for dealing with noisy data @pinns_exp and for accelerating traditional solvers, for instance by means of solving the Poisson equation more efficiently @markidis.

There are also grand challenges in CFD that necessitate new methods in ML. One motivating challenge in CFD is to perform accurate coarse-resolution simulations in unforced three-dimensional wall-bounded turbulent flows. The production of turbulent kinetic energy (TKE) in these flows takes place close to the wall @kmm (although at very high Reynolds numbers, outer-layer production also becomes relevant), and therefore using coarse meshes may significantly distort TKE production. In these flows of high technological importance, the TKE production sustains the turbulent fluctuations, and therefore a correction between coarse and fine resolutions may not be sufficient to obtain accurate results. Another challenge is the need for robust and interpretable models, a goal which is not easily attainable with deep-learning methods. There are however promising directions @cranmer_et_al @vinuesa_interp to achieve interpretable deep-learning models, with important applications to CFD. A clear challenge of CFD is the large energy consumption associated with large-scale simulations. In this sense, ML can be an enabler for more efficient operation of the high-performance-computing (HPC) facilities @vinuesa_et_al_2020, or even for future computational architectures, including quantum computers @vinuesa_et_al_2020, as shown in @koji_quantum.

It is worth noticing that, while ML has a very high potential for CFD, there are also a number of caveats which may limit the applicability of ML to certain areas of CFD. Firstly, ML methods, such as deep learning, are often expensive to train and require large amounts of data. It is therefore important to identify areas where ML outperforms classical methods, which have been established for decades, and may be more accurate and efficient in certain cases. For instance, it is possible to develop interpretable ROMs with traditional methods such as POD and DMD, and while deep learning can provide some advantages @ae_modal, the simpler machine-learning methods may be more efficient and straightforward. Finally, it is important to assess the information about the training data available to the user: certain flow properties (#emph[e.g.] incompressibility, periodicity, etc.) should be embedded in the ML model to increase training efficiency and prediction accuracy. There is also a question of how the training data is generated, and whether the associated cost is taken into account when benchmarking. In this context, transfer learning is a promising area @guastoni2.

Despite the caveats above, we believe that the trend of advancing CFD with ML will continue in the future. This progress will continue to be driven by an increasing availability of high-quality data, high-performance computing, and a better understanding and facility with these emerging techniques. Improved adoption of reproducible research standards @barba2016hard @mesnard2017reproducible is also a necessary step. Given the critical importance of data when developing ML modes, we advocate that the community continues to establish proper benchmark systems and best practices for open-source data and software in order to harness the full potential of ML to improve CFD.

#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>
RV acknowledges the financial support from the Swedish Research Council (VR) and from the ERC Grant No. "2021-CoG-101043998, DEEPCONTROL". SLB acknowledges funding support from the Army Research Office (ARO W911NF-19-1-0045; program manager Dr. Matthew Munson).

#heading(level: 1, numbering: none)[Competing interests]
<competing-interests>
The authors declare no competing interests.

#heading(level: 1, numbering: none)[Author contributions]
<author-contributions>
Both authors contributed equally to the ideation of the study and the writing process.


#bibliography("refs.bib", style: "ieee", title: [References])
