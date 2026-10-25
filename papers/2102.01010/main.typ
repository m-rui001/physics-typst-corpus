#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
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
  block(width: 100%, above: 1.2em, below: 0.7em, [#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: auto)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#show math.equation.where(block: true): set align(center)

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #set par(justify: false)
    #text(17pt, weight: "bold")[Machine learning accelerated computational fluid dynamics]
  ]
  #v(1.2em)
  #align(center)[
    #set par(justify: false)
    #set text(10.5pt)
    #strong[Dmitrii Kochkov]#super[1,#text("*")],
    #strong[Jamie A. Smith]#super[1,#text("*")],
    #strong[Ayya Alieva]#super[1],
    #strong[Qing Wang]#super[1],
    #strong[Michael P. Brenner]#super[1, 2],
    #strong[Stephan Hoyer]#super[1]
  ]
  #v(0.8em)
  #align(center)[
    #set par(justify: false)
    #set text(9pt)
    #emph[#super[1]~Google Research]\
    #emph[#super[2]~School of Engineering and Applied Sciences, Harvard University, Cambridge, MA 02138]\
    #super[#text("*")] These authors contributed equally to this work.
  ]
  #v(0.6em)
  #align(center)[
    #set par(justify: false)
    #set text(9pt)
    To whom correspondence should be addressed. E-mail: dkochkov\@google.com, jamieas\@google.com, shoyer\@google.com
  ]
  #v(1.4em)

  #block(width: 88%, inset: (x: 1.2em))[
    #set text(size: 9.5pt)
    #set par(justify: true)
    #strong[Abstract.]
    Numerical simulation of fluids plays an essential role in modeling many physical phenomena, such as weather, climate, aerodynamics and plasma physics.
    Fluids are well described by the Navier-Stokes equations, but solving these equations at scale remains daunting, limited by the computational cost of resolving the smallest spatiotemporal features.
    This leads to unfavorable trade-offs between accuracy and tractability.
    Here we use end-to-end deep learning to improve approximations inside computational fluid dynamics for modeling two-dimensional turbulent flows.
    For both direct numerical simulation of turbulence and large eddy simulation, our results are as accurate as baseline solvers with 8-10x finer resolution in each spatial dimension, resulting in 40-80x fold computational speedups.
    Our method remains stable during long simulations, and generalizes to forcing functions and Reynolds numbers outside of the flows where it is trained, in contrast to black box machine learning approaches.
    Our approach exemplifies how scientific computing can leverage machine learning and hardware accelerators to improve simulations without sacrificing accuracy or generalization.
  ]
  #v(1.6em)

]
= INTRODUCTION <introduction>

Simulation of complex physical systems described by nonlinear partial differential equations are central to engineering and physical science, with applications ranging from weather @richardson2007weather @bauer2015 and climate @schneider2017a, @neumann2019, engineering design of vehicles or engines @anderson2009basic, to wildfires @bakhshaii2019review and plasma physics~@tang2005advances. Despite a direct link between the equations of motion and the basic laws of physics, it is impossible to carry out direct numerical simulations at the scale required for these important problems. This fundamental issue has stymied progress in scientific computation for decades, and arises from the fact that an accurate simulation must resolve the smallest spatiotemporal scales.

A paradigmatic example is turbulent fluid flow @pope2001turbulent, underlying simulations of weather, climate, and aerodynamics. The size of the smallest eddy is tiny: for an airplane with chord length of 2 meters, the smallest length scale (the Kolomogorov scale) @frisch1995turbulence is $O(10^(-6)) space "m"$. Classical methods for computational fluid dynamics (CFD), such as finite differences, finite volumes, finite elements and pseudo-spectral methods, are only accurate if fields vary smoothly on the mesh, and hence meshes must resolve the smallest features to guarantee convergence. For a turbulent fluid flow, the requirement to resolve the smallest flow features implies a computational cost scaling like $"Re"^3$, where $R e = U L\/nu$, with $U$ and $L$ the typical velocity and length scales and $nu$ the kinematic viscosity. A tenfold increase in $"Re"$ leads to a thousandfold increase in the computational cost. Consequently, direct numerical simulation (DNS) for e.g. climate and weather are impossible. Instead, it is traditional to use smoothed versions of the Navier Stokes equations @moser2020statistical @meneveau2000scale that allow coarser grids while sacrificing accuracy, such as Reynolds Averaged Navier-Stokes (RANS) @Boussinesq1877-uf, @Alfonsi2009-gt, and Large-Eddy Simulation (LES) @Smagorinsky1963-fj @Lesieur1996-zy. For example, current state-of-art LES with mesh sizes of $cal(O) ( 10 )$ to $cal(O) ( 100 )$ million has been used in the design of internal combustion engines~@Male2019-uk, gas turbine engines~@Wolf2012-fn, @Esclapez2017-to, and turbo-machinery~@Arroyo2019-nq. Despite promising progress in LES over the last two decades, there are severe limits to what can be accurately simulated. This is mainly due to the first-order dependence of LES on the sub-grid scale (SGS) model, especially for flows whose rate controlling scale is unresolved~@Pope2004-ho.

// [figvision] imgs/overview_figure.png
// Panel (a) is a scatter plot with log-scale y-axis Runtime per time unit (s) ranging from 10^-1 to 10^3 and
// x-axis Time until correlation < 0.95 from 0 to 8. A solid blue line with filled circles marks direct
// simulation at resolutions 512×512, 1024×1024, 2048×2048, 4096×4096, and 8192×8192, ending near 8×10^2 seconds
// at x about 7.7. A dashed orange line marks learned interpolation at 256×256, 512×512, and 1024×1024. A
// vertical double arrow labeled 86x speedup connects the 4096×4096 direct point to the 512×512 learned point.
// Panel (b) shows fluid velocity fields. Left, under Training dataset, Forced turbulence displays a fanned stack
// of four square snapshots of red-blue turbulent swirls. Right, under Generalization tests, four square panels
// show Larger domain, a fine-grained chaotic red-blue field with a white crop inset at top left; Decaying, a
// dark field with large orange vortices and blue spots; and More turbulent, dense chaotic red-blue swirls. Each
// panel depicts a two-dimensional turbulent flow. Panel (c) is a schematic flowchart. Input Old velocity v(t)
// enters a Convolutional neural network box. A top arrow feeds External forcing F(t) into an Explicit timestep
// block. A central dashed box labeled Convective flux Φ_ij contains Filter constraints feeding two parallel
// boxes, ψ_ij interpolation and u_ij interpolation, whose outputs combine at a multiplication node marked ×d².
// Bottom sequence runs Divergence to Explicit timestep to Pressure projection, outputting New velocity v(t+Δt),
// with a feedback arrow returning to the network input.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(placement: auto, image("imgs/overview_figure.png", width: 100%),
  caption: [
    Overview of our approach and results. (a) Accuracy versus computational cost with our baseline (direct simulation) and ML accelerated (learned interpolation) solvers. The $x$ axis corresponds to pointwise accuracy, showing how long the simulation is highly correlated with the ground truth, whereas the $y$-axis shows the computational time needed to carry out one simulation time-unit on a single TPU core. Each point is annotated by the size of the corresponding spatial grid: for details see the appendix. (b) Illustrative training and validation examples, showing the strong generalization capabilities of our model. (c) Structure of a single time step for our "learned interpolation" model, with a convolutional neural net controlling learned approximations inside the convection calculation of a standard numerical solver. $psi$ and $u$ refer to advected and advecting velocity components. For $d$ spatial dimensions there are $d^2$ replicates of the convective flux module, corresponding to the flux of each velocity component in each spatial direction.
  ]
) <fig:outline>

Here, we introduce a method for calculating the accurate time evolution of solutions to nonlinear partial differential equations, while using an order of magnitude coarser grid than is traditionally required for the same accuracy. This is a novel type of numerical solver that does not average unresolved degrees of freedom, but instead uses discrete equations that give pointwise accurate solutions on an unresolved grid. We discover these algorithms using machine learning, by replacing the components of traditional solvers most affected by the loss of resolution with learned alternatives. As shown in @fig:outline(a), for a two dimensional direct numerical simulation of a turbulent flow, our algorithm maintains accuracy while using $10 times$ coarser resolution in each dimension, resulting in a $tilde 80$ fold improvement in computational time with respect to an advanced numerical method of similar accuracy. The model learns how to interpolate local features of solutions and hence can accurately generalize to different flow conditions such as different forcings and even different Reynolds numbers \[@fig:outline(b)\]. We also apply the method to a high resolution LES simulation of a turbulent flow and show similar performance enhancements, maintaining pointwise accuracy on $R e = 100 space 000$ LES simulations using $8 times$ times coarser grids with $tilde 40$ fold computational speedup.

There has been a flurry of recent work using machine learning to improve turbulence modeling. One major family of approaches uses ML to fit closures to classical turbulence models based on agreement with high resolution direct numerical simulations (DNS) @Ling2016-qk @duraisamy2019 @maulik2019subgrid @beck2019deep. While potentially more accurate than traditional turbulence models, these new models have not achieved reduced computational expense. Another major thrust uses "pure" ML, aiming to replace the entire Navier Stokes simulation with approximations based on deep neural networks @kim2019deep @li2020neural @bhattacharya2020model @wang2020towards @lusch2018deep @erichson2019physics. A pure ML approach can be extremely efficient, avoiding the severe time-step constraints required for stability with traditional approaches. Because these models do not include the underlying physics, they often struggle to enforce constraints, such as conservation of momentum and incompressibility. While these models often perform well on data from the training distribution, they often struggle with generalization. For example, they perform worse when exposed to novel forcing terms. A third approach, which we build upon in this work, uses ML to correct errors in cheap, under-resolved simulations @sirignano2020dpm @um2020solver @pathak2020using. These models borrow strength from the coarse-grained simulations.

In this work we design algorithms that accurately solve the equations on coarser grids by replacing the components most affected by the resolution loss with better performing learned alternatives. We use #emph[data driven discretizations] @bar2019learning @zhuang2020learned to interpolate differential operators onto a coarse mesh with high accuracy \[@fig:outline(c)\]. We train the solver inside a standard numerical method for solving the underlying PDEs as a differentiable program, with the neural networks and the numerical method written in a framework (JAX~@bradbury2020jax) supporting reverse-mode automatic differentiation. This allows for end-to-end gradient based optimization of the entire algorithm, similar to prior work on density functional theory~@Li2020-kohn-sham-regularizer, molecular dynamics~@Schoenholz2020-jax-md and fluids~@sirignano2020dpm @um2020solver. The methods we derive are equation specific, and require training a coarse resolution solver with high resolution ground truth simulations. Since the dynamics of a partial differential equation are local, the high resolution simulations can be carried out on a small domain. The models remains stable during long simulations and has robust and predictable generalization properties, with models trained on small domains producing accurate simulations on larger domains, with different forcing functions and even with different Reynolds number. Comparison to pure ML baselines shows that generalization arises from the physical constraints inherent in the formulation of the method.

= BACKGROUND <sec:background>

== Navier-Stokes <navier-stokes>

Incompressible fluids are modeled by the Navier-Stokes equations: $ frac(partial upright(bold(u)), partial t) = & - nabla dot.op ( upright(bold(u)) ⊗ upright(bold(u)) ) + 1 \/ italic(R e) nabla^2 upright(bold(u)) - 1 \/ rho nabla p + upright(bold(f))\
nabla dot.op bold("u") = & 0 $ <eq:ns>
where $upright(bold(u))$ is the velocity field, $upright(bold(f))$ the external forcing, and $⊗$ denotes a tensor product. The density $rho$ is a constant, and the pressure $p$ is a Lagrange multiplier used to enforce @eq:ns. The Reynolds number $italic(R e)$ dictates the balance between the convection (first) or diffusion (second) terms in the right hand side of @eq:ns. Higher Reynolds number flows dominated by convection are more complex and thus generally harder to model; flows are considered "turbulent" if $italic(R e) gt.double 1$.

Direct numerical simulation (DNS) solves @eq:ns directly, whereas large eddy simulation (LES) solves a spatially filtered version. In the equations of LES, $upright(bold(u))$ is replaced by a filtered velocity $overline(upright(bold(u)))$ and an sub-grid term $- nabla dot.op bold(tau)$ is added to the right side of @eq:ns, with the sub-grid stress defined as $bold(tau) = overline(upright(bold(u)) ⊗ upright(bold(u))) - overline(upright(bold(u))) ⊗ overline(upright(bold(u)))$. Because $overline(upright(bold(u)) ⊗ upright(bold(u)))$ is un-modeled, solving LES also requires a choice of #emph[closure] model for $bold(tau)$ as a function of $overline(upright(bold(u)))$. Numerical simulation of both DNS and LES further requires a #emph[discretization] step to approximate the continuous equations on a grid. Traditional discretization methods (e.g., finite differences) converge to an exact solution as the grid spacing becomes small, with LES converging faster because it models a smoother quantity. Together, discretization and closure models are the two principle sources of error when simulating fluids on coarse grids~@sirignano2020dpm @Duraisamy2020-es.

// [figvision] imgs/accelerating_dns.png
// Panel (a) is a 3×4 grid of vorticity snapshots. Rows are labelled DS 2048×2048, LI 64×64, and DS 64×64;
// columns are Time step = 0, 500, 1000, 1500. Each cell is a 2D vorticity field colored blue through white to
// red, with a shared colorbar from −10 to 10. A yellow square in each panel tracks one vortex across time. The
// 2048² reference retains fine structure at late times, while the 64² direct simulation and learned
// interpolation blur small scales, though the learned model keeps the tracked vortex position close to the
// high-resolution reference. Panel (b) plots Vorticity correlation from 0.0 to 1.0 against Time step 0 to 2000,
// with Simulation time 0 to 12 on the top axis. Seven curves are shown: solid DS curves for 64×64, 128×128,
// 256×256, 512×512, 1024×1024, and 2048×2048 in light green to dark blue, plus an orange dashed LI 64×64 curve.
// All start near unity then decay; coarser DS curves decay earlier. The orange dashed LI curve closely overlaps
// the dark blue DS 2048×2048 curve, indicating learned interpolation reaches direct-simulation accuracy at
// coarse resolution. Panel (c) is a log–log plot of Scaled energy spectrum E(k)/k⁵ from 10⁶ to above 10⁹ versus
// Wavenumber k from 1 to 30. Curves in greens, teals, blues, and orange dashed rise steeply, peak near k≈10–15,
// then decay. Grey lines connect the main axes to an inset at upper left magnifying the low-k region.
// Higher-resolution curves reach higher peaks and extend to larger k; the learned-interpolation curve lies on
// the reference curve, matching direct simulation across the spectrum.
#figure(placement: auto, image("imgs/accelerating_dns.png", width: 100%),
  caption: [
    Learned interpolation achieves accuracy of direct simulation at $tilde 10 times$ higher resolution. (a) Evolution of predicted vorticity fields for reference (DS $2048 times 2048$), learned (LI $64 times 64$) and baseline (DS $64 times 64$) solvers, starting from the same initial velocities. The yellow box traces the evolution of a single vortex. (b) Comparison of the vorticity correlation between predicted flows and the reference solution for our model and DNS solvers. (c) Energy spectrum scaled by $k^5$ averaged between time-steps 10000 and 20000, when all solutions have decorrelated with the reference solution.
  ]
) <fig:accelerating_dns>

== Learned solvers <subsec:challenges>

Our principle aim is to accelerate DNS without compromising accuracy or generalization. To that end, we consider ML modeling approaches that enhance a standard CFD solver when run on inexpensive to simulate coarse grids. We expect that ML models can improve the accuracy of the numerical solver via effective super-resolution of missing details~@bar2019learning. Because we want to train neural networks for approximation #emph[inside] our solver, we wrote a new CFD code in JAX~@bradbury2020jax, which allows us to efficiently calculate gradients via automatic differentiation. Our CFD code is a standard implementation of a finite volume method on a regular staggered mesh, with first-order explicit time-stepping for convection, diffusion and forcing, and implicit treatment of pressure; for details see the appendix.

The algorithm works as follows: in each time-step, the neural network generates a latent vector at each grid location based on the current velocity field, which is then used by the sub-components of the solver to account for local solution structure. Our neural networks are convolutional, which enforces translation invariance and allows them to be local in space. We then use components from standard numerical methods to enforce inductive biases corresponding to the physics of the Navier Stokes equations, as illustrated by the light gray boxes in @fig:outline(c): the convective flux model improves the approximation of the discretized convection operator; the divergence operator enforces local conservation of momentum according to a finite volume method; the pressure projection enforces incompressibility and the explicit time step operator forces the dynamics to be continuous in time, allowing for the incorporation of additional time varying forces. "DNS on a coarse grid" blurs the boundaries of traditional DNS and LES modeling, and thus invites a variety of data-driven approaches. In this work we focus on two types of ML components: learned interpolation and learned correction. Both focus on the convection term, the key term in @eq:ns for turbulent flows.

=== Learned interpolation (LI) <learned-interpolation-li>

In a finite volume method, $upright(bold(u))$ denotes a vector field of volume averages over unit cells, and the cell-averaged divergence can be calculated via Gauss' theorem by summing the surface flux over the each face. This suggests that our only required approximation is calculating the convective flux $upright(bold(u)) ⊗ upright(bold(u))$ on each face, which requires interpolating $upright(bold(u))$ from where it is defined. Rather than using typical polynomial interpolation, which is suitable for interpolation without prior knowledge, here we use an approach that we call #emph[learned interpolation] based on data driven discretizations~@bar2019learning. We use the outputs of the neural network to generate interpolation coefficients based on local features of the flow, similar to the fixed coefficients of polynomial interpolation. This allows us to incorporate two important priors: (1) the equation maintains the same symmetries and scaling properties (e.g., rescaling coordinates $bold(x)arrow.r lambda bold(x)$) as the original equations, and (2) as the mesh spacing vanishes, the interpolation module retains polynomial accuracy so that our model performs well in the regime where traditional numerical methods excel.

=== Learned correction (LC) <learned-correction-lc>

An alternative approach, closer in spirit to LES modeling, is to simply model a residual correction to the discretized Navier-Stokes equations \[@eq:ns\] on a coarse-grid~@um2020solver @sirignano2020dpm. Such an approach generalizes traditional closure models for LES, but in principle can also account for discretization error. We consider #emph[learned correction] models of the form $upright(bold(u))_t = upright(bold(u))_t^(*) + "LC" ( upright(bold(u))_t^(*) )$, where LC is a neural network and $upright(bold(u))_t^(*)$ is the uncorrected velocity field from the numerical solver on a coarse grid. Modeling the residual is appropriate both from the perspective of a temporally discretized closure model, and pragmatically because the relative error between $upright(bold(u))_t$ and $upright(bold(u))_t^(*)$ in a single time step is small. LC models have fewer inductive biases than LI models, but they are simpler to implement and potentially more flexible. We also explored LC models restricted to take the form of classical closure models (e.g., flow-dependent effective tensor viscosity models), but the restrictions hurt model performance and stability.

=== Training <training>
The training procedure tunes the machine learning components of the solver to minimize the discrepancy between an expensive high resolution simulation and a simulation produced by the model on a coarse grid. We accomplish this via supervised training where we use a cumulative point-wise error between the predicted and ground truth velocities as the loss function $L ( x , y ) = sum_(t_i)^(t_T) "MSE" ( bold("u") ( t_i ) , tilde(bold("u")) ( t_i ) ) .$ The ground truth trajectories are obtained by using a high resolution simulation that is then coarsened to the simulation grid. Including the numerical solver in the training loss ensures fully "model consistent" training where the model sees its own outputs as inputs @Duraisamy2020-es, @maulik2019subgrid @um2020solver, unlike typical #emph[a priori] training where simulation is only performed offline. As an example, for the Kolmogorov flow simulations below with Reynolds number $1000$, our ground truth simulation had a resolution of $2048$ cells along each spatial dimension. We subsample these ground truth trajectories along each dimension and time by a factor of $32$. For training we use $32$ trajectories of $4800$ sequential time steps each, starting from different random initial conditions. To evaluate the model, we generate much longer trajectories (tens of thousands of time steps) to verify that models remain stable and produce plausible outputs. We unroll the model for 32 time steps when calculating the loss, which we find improves model performance for long time trajectories~@um2020solver, in some cases using gradient checkpoints at each model step to reduce memory usage~@Griewank1994-yg.

// [figvision] imgs/generalization_decaying.png
// Panel (a) is a three-by-four grid of vorticity snapshots. The rows are DS 2048 x 2048, LI 64 x 64, and DS 64 x
// 64; the columns are time steps 0, 400, 800, and 1200. A vertical colorbar maps vorticity from -10 (white-blue)
// through 0 (dark blue) to 10 (orange-red). Yellow boxes outline a small region in the top two rows of each
// column. At time zero the fields look alike, but by step 1200 the high-resolution DS field keeps fine filaments
// while LI 64 x 64 and DS 64 x 64 grow smooth and blob-like, losing small-scale structure. Panel (b) plots
// vorticity correlation from 0 to 1 against time step from 0 to 1500, with a top axis giving simulation time
// from 0 to 10. Seven curves are shown: DS 64 x 64 (light green), DS 128 x 128 (green-teal), DS 256 x 256
// (teal), DS 512 x 512 (blue-teal), DS 1024 x 1024 (blue), DS 2048 x 2048 (dark blue), and LI 64 x 64 (orange
// dashed). All begin at correlation 1.0 and decay. By step 1500 the lowest DS resolutions fall below 0.3, LI 64
// x 64 reaches about 0.55, and DS 2048 x 2048 remains above 0.75, so correlation persists longer at higher
// resolution. Panel (c) plots scaled energy spectrum E(k) k^5 versus wavenumber k on log-log axes, with k from 1
// to 30 and the spectrum spanning roughly 10^7 to above 10^8. The same seven series and colors as panel (b)
// appear. Every curve rises from k = 1 to a peak near k ≈ 3-5, then falls. The dark blue DS 2048 x 2048 and
// orange dashed LI 64 x 64 reach the highest plateau around 3-5 x 10^8, whereas low-resolution curves sit lower;
// DS 64 x 64 peaks near 2-3 x 10^7 around k ≈ 3-4 and drops steeply after k ≈ 10. Learned interpolation matches
// the high-resolution spectrum at low and intermediate wavenumbers but under-resolves small scales.
#figure(placement: auto, image("imgs/generalization_decaying.png", width: 100%),
  caption: [
    Learned interpolation generalizes well to decaying turbulence. (a) Evolution of predicted vorticity fields as a function of time. (b) Vorticity correlation between predicted flows and the reference solution. (c) Energy spectrum scaled by $k^5$ averaged between time-steps 2000 and 2500, when all solutions have decorrelated with the reference solution.
  ]
) <fig:decaying_generalization>

= RESULTS <sec:results>

We take a utilitarian perspective on model evaluation: simulation methods are good insofar as they demonstrate accuracy, computational efficiency and generalizability. In this case, accuracy and computational efficiency require the method to be faster than the DNS baseline, while maintaining accuracy for long term predictions; generalization means that although the model is trained on specific flows, it must be able to readily generalize well to new simulation settings, including to different forcings and different Reynolds numbers. In what follows, we first compare the accuracy and generalizability of our method to both direct numerical simulation and several existing ML-based approaches for simulations of two dimensional turbulence flow. In particular, we first consider Kolmogorov flow~@Chandler2013-koklmogorov, a parametric family of forced turbulent flows obeying the Navier-Stokes equation \[@eq:ns\], with forcing $f = sin ( 4 y ) hat(bold("x")) - 0.1 bold("u")$, where the second term is a velocity dependent drag preventing accumulation of energy at large scales~@Boffetta2012-2d-turbulence. Kolmogorov flow produces a statistically stationary turbulent flow, with flow complexity controlled by a single parameter, the Reynolds number $italic("Re")$.

== Accelerating DNS <subsec:accelerating_dns>
The accuracy of a direct numerical simulation quickly degrades once the grid resolution cannot capture the smallest details of the solution. In contrast, our ML-based approach strongly mitigates this effect. @fig:accelerating_dns shows the results of training and evaluating our model on Kolmogorov flows at Reynolds number $"Re"= 1000$. All datasets were generated using high resolution DNS, followed by a coarsening step.

=== Accuracy <subsubsec:accelerating_dns_performance>

The scalar vorticity field $omega = partial_x u_y - partial_y u_x$ is a convenient way to describe a two-dimensional incompressible flows~@Boffetta2012-2d-turbulence. Accuracy can be quantified by correlating vorticity fields,#footnote[In our case the Pearson correlation reduces to a cosine distance because the flows considered here have mean velocity of $0$.#text(fill: white, size: 0pt)[#cite(<Note1>)]] $C ( omega , hat(omega) )$ between the ground truth solution $omega$ and the predicted state $hat(omega)$. @fig:accelerating_dns compares the learned interpolation model ($64 times 64$) to fully resolved DNS of Kolmogorov flow ($2048 times 2048$) using an initial condition that was not included in the training set. Strikingly, the learned discretization model matches the pointwise accuracy of DNS with a $tilde 10$ times finer grid. The eventual loss of correlation with the reference solution is expected due to the chaotic nature of turbulent flows; this is marked by a vertical grey line in @fig:accelerating_dns(b), indicating the first three Lyapunov times. @fig:accelerating_dns (a) shows the time evolution of the vorticity field for three different models: the learned interpolation matches the ground truth ($2048 times 2048$) more accurately than the $512 times 512$ baseline, whereas it greatly outperforms a baseline solver at the same resolution as the model ($64 times 64$).

The learned interpolation model also produces a similar energy spectrum $E ( bold("k") ) = 1\/2 abs(bold(u) (bold(k)))^2$ to DNS. With decreasing resolution, DNS cannot capture high frequency features, resulting in an energy spectrum that "tails off" for higher values of $k$. @fig:accelerating_dns (c) compares the energy spectrum for learned interpolation and direct simulation at different resolutions after $10^4$ time steps. The learned interpolation model accurately captures the energy distribution across the spectrum.

=== Computational efficiency <computational-efficiency>

The ability to match DNS with a $tilde 10$ times coarser grid makes the learned interpolation solver much faster. We benchmark our solver on a single core of Google's Cloud TPU v4, a hardware accelerator designed for accelerating machine learning models that is also suitable for many scientific computing use-cases~ @Ben-Haim2019-ja @Yang2019-si @Lu2020-cb. The TPU is designed for high throughput vectorized operations, and extremely high throughput matrix-matrix multiplication in low precision (bfloat16). On sufficiently large grid sizes ($256 times 256$ and larger), our neural net makes good use of matrix-multiplication unit, achieving 12.5x higher throughput in floating point operations per second than our baseline CFD solver. Thus despite using 150 times more arithmetic operations, the ML solver is only about 12 times slower than the traditional solver at the same resolution. The $10 times$ gain in effective resolution in three dimensions (two space dimensions and time, due to the Courant condition) thus corresponds to a speedup of $10^3\/12 approx 80$.

// [figvision] imgs/generalization_4k.png
// Panel (a) shows a 3 by 4 grid of vorticity heatmaps for Kolmogorov flow at time steps 0, 800, 1600, and 2400.
// Rows are DS 4096 × 4096 (top), LI 128 × 128 (middle), and DS 128 × 128 (bottom). Red–orange indicates positive
// vorticity and blue negative vorticity on a shared colorbar from −10 to 10, with yellow square boxes marking
// local regions in each frame. The flow evolves from broad coherent structures at time step 0 into finer
// turbulent filaments by time step 2400, while the 4096 resolution retains the sharpest small-scale detail.
// Panel (b) plots vorticity correlation versus time step from 0 to beyond 3000 on the bottom axis, with
// simulation time 0 to 12 on the top axis. The y-axis runs 0.0 to 1.0. Seven curves are shown: DS 128 × 128
// (light green), DS 256 × 256 (light teal), DS 512 × 512 (teal), DS 1024 × 1024 (blue), DS 2048 × 2048 (dark
// blue), DS 4096 × 4096 (navy), and LI 128 × 128 (orange dashed). All correlations begin near 1.0 and decay to
// zero, with higher DS resolutions remaining correlated longer and the 128-resolution cases decorrelating
// earliest. Panel (c) is a log-log plot of scaled energy spectrum E(k)/k^5 versus wavenumber k from 1 to 60,
// with the y-axis from 10^6 to 10^10. Curves for DS resolutions 128 × 128 through 4096 × 4096 and LI 128 × 128
// (orange dashed) are averaged over time steps 6000 to 12000. The spectra rise to a broad peak near k ≈ 30–40
// then decline, collapsing across resolutions at high k. An inset box magnifies the high-wavenumber range,
// linked by corner lines to the main axes, showing spectral convergence at large k.
#figure(placement: auto, image("imgs/generalization_4k.png", width: 100%),
  caption: [
    Learned interpolations can be scaled to simulate higher Reynolds numbers without retraining. (a) Evolution of predicted vorticity fields as a function of time for Kolmogorov flow at $R e = 4000$. (b) Vorticity correlation between predicted flows and the reference solution. (c) Energy spectrum scaled by $k^5$ averaged between time-steps 6000 and 12000, when all solutions have decorrelated with the reference solution.
  ]
) <fig:kolmogorov_re_4000>

=== Generalization <subsubsec:accelerating_dns_generalization>
In order to be useful, a learned model must accurately simulate flows outside of the training distribution. We expect our models to generalize well because they learn local operators: interpolated values and corrections at a given point depend only on the flow within a small neighborhood around it. As a result, these operators can be applied to any flow that features similar local structures as those seen during training. We consider three different types of generalization tests: (1) larger domain size, (2) unforced decaying turbulent flow, and (3) Kolmogorov flow at a larger Reynolds number.

First, we test generalization to larger domain sizes with the same forcing. Our ML models have essentially the exact same performance as on the training domain, because they only rely upon local features of the flows (see @apx:pointwise_accuracy_extra and @fig:model_comparison).

Second, we apply our model trained on Kolmogorov flow to #emph[decaying turbulence], by starting with a random initial condition with high wavenumber components, and letting the turbulence evolve in time without forcing. Over time, the small scales coalesce to form large scale structures, so that both the scale of the eddies and the Reynolds number vary. @fig:decaying_generalization shows that a learned discretization model trained on Kolmogorov flows $"Re= 1000"$ can match the accuracy of DNS running at $tilde 7$ times finer resolution. A standard numerical method at the same resolution as the learned discretization model is corrupted by numerical diffusion, degrading the energy spectrum as well as pointwise accuracy.

Our final generalization test is harder: can the models generalize to higher Reynolds number where the flows are more complex? The universality of the turbulent cascade @richardson2007weather @kolmogorov1941local @kraichnan1980two implies that at the size of the smallest eddies (the Kolmogorov length scale), flows "look the same" regardless of Reynolds number when suitably rescaled. This suggests that we can apply the model trained at one Reynolds number to a flow at another Reynolds number by simply rescaling the model to match the new smallest length scale. To test this we construct a new dataset for a Kolmogorov flow with $"Re"= 4000$. The theory of two-dimensional turbulence @boffetta2012two implies that the smallest eddy size decreases as $1\/sqrt( "Re" )$, implying that the smallest eddies in this flow are $1\/2$ that for original flow with $"Re"= 1000$. We therefore can use a trained $"Re"= 1000$ model at $"Re"= 4000$ by simply halving the grid spacing. @fig:kolmogorov_re_4000 (a) shows that with this scaling, our model achieves the accuracy of DNS running at $7$ times finer resolution. This degree of generalization is remarkable, given that we are now testing the model with a flow of substantially greater complexity. @fig:kolmogorov_re_4000 (b) visualizes the vorticity, showing that higher complexity is captured correctly, as is further verified by the energy spectrum shown in @fig:kolmogorov_re_4000 (c).

== Comparison to other ML models <subsec:model_comparison>
Finally, we compare the performance of learned interpolation to alternative ML-based methods. We consider three popular ML methods: ResNet (RN)~@he2016deep, Encoder-Processor-Decoder (EPD)~@battaglia2018relational @sanchez2020learning architectures and the learned correction (LC) model introduced earlier. These models all perform explicit time-stepping without any additional latent state beyond the velocity field, which allows them to be evaluated with arbitrary forcings and boundary conditions, and to use the time-step based on the CFL condition. By construction, these models are inivariant to translation in space and time, and have similar runtime for inference (varying within a factor of two). To evaluate training consistency, each model is trained 9 times with different random initializations on the same Kolmogorov $"Re"= 1000$ dataset described previously. Hyperparameters for each model were chosen as detailed in @apx:hyperparameters, and the models are evaluated on the same generalization tasks. We compare their performance using several metrics: time until vorticity correlation falls below $0.95$ to measure pointwise accuracy for the flow over short time windows, the absolute error of the energy spectrum scaled by $k^5$ to measure statistical accuracy for the flow over long time windows, and the fraction of simulated velocity values that does not exceed the range of the training data to measure stability.

@fig:model_comparison compares results across all considered configurations. Overall, we find that learned interpolation (LI) performs best, although learned correction (LC) is not far behind. We were impressed by the performance of the LC model, despite its weaker inductive biases. The difference in effective resolution for pointwise accuracy ($8 times$ vs $10 times$ upscaling) corresponds to about a factor of two in run-time. There are a few isolated exceptions where pure black box methods outperform the others, but not consistently. A particular strength of the learned interpolation and correction models is their consistent performance and generalization to other flows, as seen from the narrow spread of model performance for different random initialization and their consistent dominance over other models in the generalization tests. Note that even a modest $4 times$ effective coarse-graining in resolution still corresponds to a $5 times$ computational speed-up. In contrast, the black box ML methods exhibit high sensitivity to random initialization and do not generalize well, with much less consistent statistical accuracy and stability.

== Acceleration of LES <acceleration-of-les>

Finally, up until now we have illustrated our method for DNS of the Navier Stokes equations. Our approach is quite general and could be applied to any nonlinear partial differential equation. To demonstrate this, we apply the method to accelerate LES, the industry standard method for large scale simulations where DNS is not feasible.

Here we treat the LES at high resolution as the ground truth simulation and train an interpolation model on a coarser grid for Kolmogorov flows with Reynolds number $italic("Re") = 10^5$ according to the Smagorinsky-Lilly model SGS model~@pope2001turbulent. Our training procedure follows the exact same approach we used for modeling DNS. Note in particular that we do not attempt to model the parameterized viscosity in the learned LES model, but rather let learned interpolation model this implicitly. @fig:accelerating_les shows that learned interpolation for LES still achieves an effective $8 times$ upscaling, corresponding to roughly $40 times$ speedup.

// [figvision] imgs/model_comparison.png
// (a) Forced turbulence, pointwise accuracy. Scatter plot; x-axis is time until correlation drops below 0.95,
// linear from 0 to about 6.5 with gridlines at 0, 2, 4, 6; a top axis marks discretization factors 1x, 2x, 4x,
// 8x, 16x. Y categories bottom to top are RN (red), EPD (green), LC (orange), LI (blue), nine replicate dots
// each. RN red dots cluster near x≈2–4. EPD green has one dot at x≈0 and clusters near x≈4.3–4.7 and x≈5.8–6.5.
// LC orange clusters near x≈4.5–5. LI blue clusters near x≈5.5–6.3. Message: higher-resolution LI/LC runs
// sustain correlation longest; RN is shortest lived. (b) Forced turbulence, statistical accuracy. Scatter plot;
// x-axis is spectral error on a decreasing log scale with ticks 10^9 left and 10^8 toward the right (lower error
// is better). EPD green left-pointing triangles sit at the far left edge (largest error), with a few green dots
// near 10^8 on the right. LC orange dots cluster around a few times 10^8. LI blue dots occupy the far right at
// the lowest errors, with one dot at the extreme right edge. Message: LI achieves the smallest spectral error;
// EPD shows both high-error outliers and good replicates. (c) Forced turbulence, stability. Scatter plot; x-axis
// is proportion stable at t=50 from 0.0 to 1.0. RN red dots pile near 0, with a few around 0.3 and one near 0.9.
// EPD green dots cluster near 0 and a few near 1. LC orange dots sit near 1. LI blue dots form a tight cluster
// at 1.0. Message: LI and LC are almost always stable; RN is mostly unstable. (d) Larger domain, pointwise
// accuracy. X-axis time until correlation < 0.95, 0 to about 6.5; top axis 1x–16x. RN red dots cluster near
// x≈0–3.5. EPD green: one dot at x≈0, clusters near x≈4.5 and x≈5.8–6.5. LC orange near x≈4.8–5.5. LI blue near
// x≈5.5–6.3. Same color/row scheme as (a), nine replicates per category. Message: generalization to a larger
// domain preserves the ordering LI best, RN worst, with EPD split between poor and good replicates. (e) Larger
// domain, statistical accuracy. X-axis spectral error decreasing on a log scale with ticks 10^9, 10^8, 10^7 left
// to right. EPD green left triangles at the far left (highest error). LC orange dots cluster around 10^8 to a
// few 10^8. LI blue dots cluster at the far right near 10^7–10^8, the lowest errors. A few green dots appear
// near 10^8. Message: LI generalizes best statistically on the larger domain; EPD has large-error outliers. (f)
// Larger domain, stability. X-axis proportion stable at t=50, 0.0–1.0. RN red dots near 0 plus one near 0.85.
// EPD green dots cluster near 0 with several near 1. LC orange near 1. LI blue tightly at 1.0. Message:
// stability is retained under domain enlargement for LI and LC; RN remains largely unstable. (g) Decaying,
// pointwise accuracy. X-axis 0 to about 6. RN red dots cluster tightly near x≈1–1.5. EPD green dots spread from
// x≈0 to x≈3. LC orange dots near x≈3–3.5. LI blue: one dot near x≈0.8, clusters near x≈2.5–2.8 and x≈3.8–4.5.
// Top axis 1x–16x. Message: for decaying flows the spread across architectures is wider and LI is only
// moderately better than LC; RN is clearly worst. (h) Decaying, statistical accuracy. X-axis spectral error
// decreasing, log scale centered on 10^8. EPD green left triangles at the far left and green dots spread across
// mid-range. LC orange dots cluster around mid-range errors. LI blue dots at the right near/below 10^8, plus one
// dot at the extreme right edge. Message: LI again reaches the lowest spectral error; EPD spans high to moderate
// error. (i) Decaying, stability. X-axis proportion stable 0.0–1.0. RN red dots near 0. EPD green dots are
// broadly spread, with values near 0, ~0.2, ~0.4, ~0.75 and near 1. LC orange and LI blue dots cluster near 1.
// Message: EPD is unstable and variable under decay; LI and LC remain stable; RN unstable. (j) More turbulent,
// pointwise accuracy. X-axis 0 to about 6.5; top axis 1x–16x. RN red dots cluster near x≈0–1. EPD green dots
// spread from x≈0 to x≈4. LC orange dots near x≈3–4. LI blue: one dot near x≈2.8 and a cluster near x≈4–4.8.
// Message: under more turbulent forcing, LI retains the longest correlation time but the advantage over LC
// narrows; RN collapses to near-zero correlation time. (k) More turbulent, statistical accuracy. X-axis spectral
// error decreasing, log scale ticks 10^9 and 10^8. EPD green left triangles at far left and green dots spread
// mid-range. LC orange dots cluster on the right around 10^8. LI blue dots at the far right at the lowest errors
// near/below 10^8. Message: LI maintains the best statistical accuracy in the most turbulent regime. (l) More
// turbulent, stability. X-axis proportion stable at t=50, 0.0–1.0. RN red dots near 0 plus one near 0.85. EPD
// green dots cluster near 0, several near ~0.75–0.95, and one near 1. LC orange and LI blue dots cluster tightly
// near 1. Message: LI and LC remain highly stable; EPD is highly variable; RN is mostly unstable.
#figure(placement: auto, image("imgs/model_comparison.png", width: 100%),
  caption: [
    Learned discretizations outperform a wide range of baseline methods in terms of accuracy, stability and generalization. Each row within a subplot shows performance metrics for nine model replicates with the same architecture, but different randomly initialized weights. The models are trained on forced turbulence, with larger domain, decaying and more turbulent flows as generalization tests. Vertical lines indicate performance of non-learned baseline models at different resolutions (all baseline models are perfectly stable). The pointwise accuracy test measures error at the start of time integration, whereas the statistical accuracy and stability tests are both performed on simulations at time 50 after about $7000$ time integration steps (twice the number of steps for more turbulent flow). The points indicated by a left-pointing triangle in the statistical accuracy tests are clipped at a maximum error.
  ]
) <fig:model_comparison>

// [figvision] imgs/accelerating_les.png
// Panel (a) is a 3 × 4 grid of vorticity heatmaps. Columns are labelled Time step = 0, 400, 800, 1200; rows are
// DS 2048 × 2048, LI 64 × 64, and DS 64 × 64. Each cell shows a turbulent field coloured by vorticity from −10
// (blue) to 10 (red) using the shared colour bar, with a yellow square marking one subregion per snapshot. The
// patterns become more filamentary with time, and the 64 × 64 rows deviate from the 2048 × 2048 reference,
// especially at later steps. Panel (b) plots vorticity correlation (0.0 to 1.0) against time step (0 to 1500)
// with a secondary simulation-time axis (0 to 10) on top. Seven series are shown: DS 64 × 64 (pale green), DS
// 128 × 128, DS 256 × 256, DS 512 × 512, DS 1024 × 1024, DS 2048 × 2048 (solid blues, light to dark), and LI 64
// × 64 (orange dashed). All curves begin at 1.0 and decay; increasing DS resolution delays the decay, with DS
// 2048 × 2048 remaining near 1.0 throughout, while LI 64 × 64 tracks the mid-resolution DS curves. A faint
// horizontal line sits near 0.9. Panel (c) is a log–log plot of scaled energy spectrum E(k)/k^5 (10^6 to 10^10)
// versus wavenumber k (1 to 30). The same seven series appear as solid DS curves from DS 64 × 64 to DS 2048 ×
// 2048 and an orange dashed LI 64 × 64 curve. Spectra rise steeply at low k then roll off at high k; DS 2048 ×
// 2048 and LI 64 × 64 reach near 10^10, while coarse DS curves drop earlier toward 10^6–10^8. Two connected
// insets zoom into the high-k roll-off region.
#figure(placement: auto, image("imgs/accelerating_les.png", width: 100%),
  caption: [
    Learned discretizations achieve accuracy of LES simulation running on $8 times$ times finer resolution. (a) Evolution of predicted vorticity fields as a function of time. (b) Vorticity correlation between predicted flows and the reference solution. (c) Energy spectrum scaled by $k^5$ averaged between time-steps 3800 and 4800, when all solutions have decorrelated with the reference solution.
  ]
) <fig:accelerating_les>

= DISCUSSION <discussion>

In this work we present a data driven numerical method that achieves the same accuracy as traditional finite difference/finite volume methods but with much coarser resolution. The method learns accurate local operators for convective fluxes and residual terms, and matches the accuracy of an advanced numerical solver running at 8--$10 times$ finer resolution, while performing the computation 40--$80 times$ faster. The method uses machine learning to interpolate better at a coarse scale, within the framework of the traditional numerical discretizations. As such, the method inherently contains the scaling and symmetry properties of the original governing Navier Stokes equations. For that reason, the methods generalize much better than pure black-box machine learned methods, not only to different forcing functions but also to different parameter regimes (Reynolds numbers).

What outlook do our results suggest for speeding up 3D turbulence? In general, the runtime $T$ for efficient ML augmented simulation of time-dependent PDEs should scale like $T tilde (C_"ML" + C_"physics") (N\/K)^(d + 1)$ where $C_"ML"$ is the cost of ML inference per grid point, $C_"physics"$ is the cost of baseline numerical method, $N$ is the number of grid points along each dimension of the resolved grid, $d$ is the number of spatial dimensions and $K$ is the effective coarse graining factor. Currently, $C_"ML"\/C_"physics" approx 12$, but we expect that much more efficient machine learning models are possible, e.g., by sharing work between time-steps with recurrent neural nets. We expect the $10 times$ decrease in effective resolution discovered here to generalize to 3D and more complex problems. This suggests that speed-ups in the range of $10^3$--$10^4$ may be possible for 3D simulations. Further speed-ups, as required to capture the full range of turbulent flows, will require either more efficient representations for flows (e.g., based on solution manifolds rather than a grid) or being satisfied with statistical rather than pointwise accuracy (e.g., as done in LES modeling).

In summary, our approach expands the Pareto frontier of efficient simulation in computational fluid dynamics, as illustrated in @fig:outline(a). With ML accelerated CFD, users may either solve expensive simulations much faster, or increase accuracy without additional costs. To put these results in context, if applied to numerical weather prediction, increasing the duration of accurate predictions from 4 to 7 time-units would correspond to approximately 30 years of progress~@Bauer2015-quiet-rev-nwp. These improvements are possible due to the combined effect of two technologies still undergoing rapid improvements: modern deep learning models, which allow for accurate simulation with much more compact representations, and modern accelerator hardware, which allows for evaluating said models with a remarkably small increase in computational cost. We expect both trends to continue for the foreseeable future, and to eventually impact all areas of computationally limited science.

#heading(level: 1, numbering: none)[Acknowledgement]
<acknowledgement>
We thank John Platt and Rif A.~Saurous for encouraging and supporting this work and for important conversations, and Yohai bar Sinai, Anton Geraschenko, Yi-fan Chen and Jiawei Zhuang for important conversations.

#set heading(numbering: "A.1", supplement: [Appendix])
#counter(heading).update(0)

= DIRECT NUMERICAL SIMULATION <apx:dns>
Here we describe the details of the numerical solver that we use for data generation, model comparison and the starting point of our machine learning models. Our solver uses a staggered-square mesh @mcdonough2007lectures in a finite volume formulation: the computational domain is broken into computational cells where the velocity field is placed on the edges, while the pressure is solved at the cell centers. Our choice of real-space formulation of the Navier-Stokes equations, rather than a spectral method is motivated by practical considerations: real space simulations are much more versatile when dealing with boundary conditions and non-rectangular geometries. We now describe the implementation details of each component.

#heading(level: 2, numbering: none)[Convection and diffusion]
<convection-and-diffusion>
We implement convection and diffusion operators based on finite-difference approximations. The Laplace operator in the diffusion is approximated using a second order central difference approximation. The convection term is solved by advecting all velocity components simultaneously, using a high order scheme based on Van-Leer flux limiter @sweby1984high. For the results presented in the paper we used explicit time integration using Euler discretization. This choice is motivated by performance considerations: for the simulation parameters used in the paper (high Reynold number) implicit diffusion is not required for stable time-stepping, and is approximately twice as slow, due to the additional linear solves required for each velocity component. For diffusion dominated simulations implicit diffusion would result in faster simulations.

#heading(level: 2, numbering: none)[Pressure]
<pressure>
To account for pressure we use a projection method, where at each step we solve the corresponding Poisson equation. The solution is obtained using either a fast diagonalization approach with explicit matrix multiplication @Lynch1964-pe or a real-valued fast Fourier transform (FFT). The former is well suited for small simulation domains as it has better accelerator utilization, while FFT has best computational complexity and performs best in large simulations. For wall-clock evaluations we choose between the fast diagonalization and FFT approach by choosing the fastest for a given grid.

#heading(level: 2, numbering: none)[Forcing and closure terms]
<forcing-and-closure-terms>
We incorporate forcing terms together with the accelerations due to convective and diffusive processes. In an LES setting the baseline and ground truth simulations additionally include a subgrid scale model that is also treated explicitly. We use the Smagorinsky-Lilly model (#ref(<apx:eq:les_model>, supplement: none)) where $Delta$ is the grid spacing and $C_s = 0.2$:

$ tau_(i j) = - 2 (C_s Delta)^2 & norm( macron(S) ) macron(S)_(i j)\
macron(S)_(i j) = 1 \/ 2 ( partial_i u_j + partial_j u_i ) #h(2em) & norm( macron(S) ) = 2 sqrt(sum_(i, j) macron(S)_(i j) macron(S)_(i j)) $<apx:eq:les_model>

= DATASETS AND SIMULATION PARAMETERS <apx:simulation_setup>
In the main text we introduced five datasets: two Kolmogorov flows at $italic("Re") = 1000$ and $italic("Re") = 4000$, Kolmogorov flow with $italic("Re") = 1000$ on a $2 times$ larger domain, decaying turbulence and an LES dataset with Reynolds number $10^5$. Dataset generation consisted of three steps: (1) burn-in simulation from a random initial condition; (2) simulation for a fixed duration using high resolution solver; (3) downsampling of the solution to a lower grid for training and evaluation.

The burn-in stage is fully characterized by the #emph[burn-in time] and #emph[initialization wavenumber] which represent the discarded initial transient and the peak wavenumber of the log-normal distribution from which random initial conditions were sampled from. The maximum amplitude of the initial velocity field was set to $7$ for forced simulations and $4.2$ in the decaying turbulence, which was selected to minimize the burn-in time, as well as maintain standard deviation of the velocity field close to $1.0$. The initialization wavenumber was set to $4$. Simulation parameters include #emph[simulation resolution] along each spatial dimension, #emph[forcing] and #emph[Reynolds number]. The resulting velocity trajectories are then downsampled to the #emph[save resolution]. Note that besides the spatial downsampling we also perform downsampling in time to maintain the Courant--Friedrichs--Lewy (CFL) factor fixed at $0.5$, standard for numerical simulations. Parameters specifying all five datasets are shown in @table:simulation_params. We varied the size of our datasets from $12200$ time slices at the downsampled resolution for decaying turbulence to $34770$ slices in the forced turbulence settings. Such extended trajectories allow us to analyze stability of models when performing long-term simulations. We note that when performing simulations at higher Reynolds numbers we used rescaled grids to maintain fixed time stepping. This is motivated to potentially allow methods to specialize on a discrete time advancements. When reporting the results, spatial and time dimensions are scaled back to a fixed value to enable direct comparisons across the experiments.

For comparison of our models with numerical methods we use the corresponding simulation parameters while changing only the resolution of the underlying grid. As mentioned in @apx:dns, when measuring the performance of all solvers on a given resolution we choose solver components to maximize efficiency.

#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,left,left,left,),
    table.hline(stroke: 0.8pt),
    table.header([#strong[Dataset]], [#strong[Resolution]], [#strong[Re]], [#strong[Burn-in time]],),
    table.hline(),
    [Kolmogorov $italic("Re") = 1000$], [$2048 arrow.r 64$], [$1000$], [$40$],
    [Kolmogorov $italic("Re") = 4000$], [$4096 arrow.r 128$], [$4000$], [$40$],
    [Kolmogorov $italic("Re") = 1000$], [$4096 arrow.r 128$], [$1000$], [$40$],
    [Decaying turbulence], [$2048 arrow.r 64$], [$1000$ ($t = 0$)], [$4$],
    [LES $italic("Re") = 10^5$], [$2048 arrow.r 64$], [$10^5$], [$40$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Simulation parameters used for generation of the datasets in this manuscript. For resolution, the notation $X arrow.r Y$ indicates that simulation was performed at resolution $X$ and the result was downsampled to resolution $Y$.]
  , kind: table
  ) <table:simulation_params>


= LEARNED INTERPOLATIONS <apx:learned_interpolations>
To improve numerical accuracy of the convective process our models use psuedo-linear models for interpolation~@bar2019learning @zhuang2020learned. The process of interpolating $u_i$ to $u ( x )$ is broken into two steps:

+ Computation of local stencils for interpolation target $x$.

+ Computation of a weighted sum $sum_(i = 1)^n a_i u_i$ over the stencil.

Rather using a fixed set of interpolating coefficients $a_i$ (e.g., as done for typical polynomial interpolation), we choose $a_i$ from the output of a neural network additionally constrained to satisfy $sum_(i = 1)^n a_i = 1$, which guarantees that the interpolation is at least first order accurate. We do so by generating interpolation coefficients with an affine transformation $upright(bold(a)) = A upright(bold(x)) + upright(bold(b))$ on the unconstrainted outputs $x$ of the neural network, where $A$ is the null-space of the constraint matrix (a $1 times n$ matrix of ones) of shape $n times ( n - 1 )$ and $upright(bold(b))$ is an arbitrary valid set of coefficients (we use linear interpolation from the nearest source term locations). This is a special case of the procedure for arbitrary polynomial accuracy constraints on finite difference coefficients described in @bar2019learning @zhuang2020learned. In this work, we use a $4 times 4$ patch centered over the top-right corner of each unit-cell, which means we need $15$ unconstrained neural network outputs to generate each set of interpolation coefficients.

= NEURAL NETWORK ARCHITECTURES <neural-network-architectures>

#figure(
  scale(61.5%, reflow: true, {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let gray = rgb("#7f7f7f")
    let dgray = rgb("#8c8c8c")
    let nnf = rgb("#e7d7ef")
    let nnb = rgb("#a878b8")
    let phyf = rgb("#dcefdc")
    let phyb = rgb("#6aa86a")
    let convf = rgb("#d7e5f7")
    let convb = rgb("#5b8fc9")
    let reluf = rgb("#fbddb2")
    let relub = rgb("#e0912f")
    let plusf = rgb("#fceaa6")
    let plusb = rgb("#c9a227")

    let arw = (a, b) => line(a, b, stroke: (thickness: 1.1pt, paint: gray), mark: (end: (symbol: "stealth", fill: gray)))
    let parw = (..pts) => line(..pts, stroke: (thickness: 1.1pt, paint: gray), mark: (end: (symbol: "stealth", fill: gray)))
    let mbox = (cy, w, h, lbl, f, s) => {
      rect((-w/2, cy - h/2), (w/2, cy + h/2), radius: 0.06, stroke: (thickness: 1pt, paint: s), fill: f)
      content((0, cy), lbl)
    }
    let pcirc = (cy, r: 0.42) => {
      circle((0, cy), radius: r, stroke: (thickness: 1pt, paint: plusb), fill: plusf)
      content((0, cy), text(size: 11pt)[+])
    }
    let dbox = (y0, y1, w) => rect((-w/2, y0), (w/2, y1), radius: 0.35,
      stroke: (thickness: 1pt, paint: dgray, dash: "dashed"), fill: none)
    let title = (cy, body) => content((0, cy), text(size: 10pt, style: "italic", body))
    let ut = (cy) => content((0, cy), text(size: 10pt)[$bold(u)(t)$])
    let utdt = (cy) => content((0, cy), text(size: 10pt)[$bold(u)(t + Delta t)$])

    // ===== TOP ROW: modeling approaches =====
    group({
      translate((2.6, 0))
      title(18.3, [Pure ML])
      ut(17.4)
      mbox(16.0, 4.0, 1.0, text(size: 10pt)[Neural network], nnf, nnb)
      pcirc(14.4)
      utdt(13.0)
      arw((0, 17.05), (0, 16.5))
      arw((0, 15.5), (0, 14.82))
      arw((0, 13.98), (0, 13.35))
      parw((0, 16.9), (-2.5, 16.9), (-2.5, 14.4), (-0.46, 14.4))
    })

    group({
      translate((7.5, 0))
      title(18.3, [Learned Interpolation])
      ut(17.4)
      mbox(16.0, 4.0, 1.0, text(size: 10pt)[Neural network], nnf, nnb)
      mbox(14.4, 4.0, 1.0, text(size: 10pt)[Physics], phyf, phyb)
      utdt(13.0)
      arw((0, 17.05), (0, 16.5))
      arw((0, 15.5), (0, 14.9))
      arw((0, 13.9), (0, 13.35))
      parw((0, 16.9), (-2.5, 16.9), (-2.5, 14.4), (-2.02, 14.4))
    })

    group({
      translate((12.4, 0))
      title(18.3, [Learned Correction])
      ut(17.4)
      mbox(16.0, 4.0, 1.0, text(size: 10pt)[Physics], phyf, phyb)
      mbox(14.4, 4.0, 1.0, text(size: 10pt)[Neural network], nnf, nnb)
      pcirc(13.0)
      utdt(11.9)
      arw((0, 17.05), (0, 16.5))
      arw((0, 15.5), (0, 14.9))
      arw((0, 13.9), (0, 13.42))
      arw((0, 12.58), (0, 12.25))
      parw((0, 16.9), (-2.5, 16.9), (-2.5, 13.0), (-0.46, 13.0))
    })

    // ===== BOTTOM ROW: architectures =====
    group({
      translate((2.6, 0))
      title(11.4, [Basic ConvNet])
      dbox(6.9, 9.9, 4.0)
      mbox(9.2, 3.4, 0.8, text(size: 9pt)[Conv2D 64 3x3], convf, convb)
      mbox(8.2, 3.4, 0.8, text(size: 9pt)[Relu], reluf, relub)
      content((2.2, 8.7), anchor: "west", text(size: 11pt)[×6])
      mbox(6.0, 3.4, 0.8, text(size: 9pt)[Conv2D $N_"out"$ 3x3], convf, convb)
      arw((0, 11.0), (0, 9.65))
      arw((0, 6.9), (0, 6.4))
      arw((0, 5.6), (0, 5.0))
    })

    group({
      translate((7.5, 0))
      title(11.4, [Encoder-Process-Decoder])
      mbox(10.2, 3.4, 0.8, text(size: 9pt)[Conv2D 64 5x5], convf, convb)
      dbox(5.7, 9.6, 4.0)
      mbox(8.9, 3.4, 0.8, text(size: 9pt)[Conv2D 64 3x3], convf, convb)
      mbox(8.1, 3.4, 0.8, text(size: 9pt)[Relu], reluf, relub)
      mbox(7.3, 3.4, 0.8, text(size: 9pt)[Conv2D 64 3x3], convf, convb)
      pcirc(6.3)
      content((2.2, 7.6), anchor: "west", text(size: 11pt)[×4])
      mbox(4.9, 3.4, 0.8, text(size: 9pt)[Conv2D 64 5x5], convf, convb)
      mbox(4.1, 3.4, 0.8, text(size: 9pt)[Relu], reluf, relub)
      mbox(3.3, 3.4, 0.8, text(size: 9pt)[Conv2D 2 5x5], convf, convb)
      arw((0, 11.0), (0, 10.6))
      arw((0, 9.8), (0, 9.3))
      arw((0, 6.9), (0, 6.72))
      arw((0, 5.7), (0, 5.3))
      arw((0, 2.9), (0, 2.3))
      parw((0, 9.55), (-2.5, 9.55), (-2.5, 6.3), (-0.46, 6.3))
    })

    group({
      translate((12.4, 0))
      title(11.4, [ResNet])
      dbox(6.2, 10.6, 4.4)
      dbox(8.6, 10.3, 3.8)
      mbox(9.9, 3.4, 0.8, text(size: 9pt)[Conv2D 64 3x3], convf, convb)
      mbox(9.1, 3.4, 0.8, text(size: 9pt)[Relu], reluf, relub)
      content((2.1, 9.5), anchor: "west", text(size: 11pt)[×4])
      mbox(8.0, 3.4, 0.8, text(size: 9pt)[Conv2D 2 3x3], convf, convb)
      pcirc(7.0)
      content((2.4, 8.4), anchor: "west", text(size: 11pt)[×4])
      dbox(3.9, 5.8, 3.8)
      mbox(5.3, 3.4, 0.8, text(size: 9pt)[Conv2D 64 3x3], convf, convb)
      mbox(4.5, 3.4, 0.8, text(size: 9pt)[Relu], reluf, relub)
      content((2.1, 4.9), anchor: "west", text(size: 11pt)[×4])
      mbox(3.4, 3.4, 0.8, text(size: 9pt)[Conv2D 2 3x3], convf, convb)
      arw((0, 11.0), (0, 10.3))
      arw((0, 8.6), (0, 8.4))
      arw((0, 7.6), (0, 7.42))
      arw((0, 6.2), (0, 5.8))
      arw((0, 3.9), (0, 3.8))
      arw((0, 3.0), (0, 2.4))
      parw((0, 10.55), (-2.6, 10.55), (-2.6, 7.0), (-0.46, 7.0))
    })
  })}),
  caption: [
    Modeling approaches and neural network architecutres used in this paper. Rescaling of inputs and outputs from neural network sub-modules with fixed constants is not depicted. Dashed lines surround components that are repeatedly applied the indicated number of times.
  ]
) <fig:model_architectures>

All of the ML based models used in this work are based on fully convolutional architectures. @fig:model_architectures depicts our three modeling approaches (pure ML, learned interpolation and learned correction) and three architecturs for neural network sub-components (Basic ConvNet, Encoder-Process-Decoder and ResNet). Outputs and inputs for each neural network layer are linearly scaled such that appropriate values are in the range $( - 1 , 1 )$.

For our physics augmented solvers (learned interpolation and learned correction), we used the basic ConvNet archicture, with $N_"out" = 120$ (8 interpolations that need 15 inputs each) for learned interpolation and $N_"out" = 2$ for learned correction. Our experiments found accuracy was slightly improved by using larger neural networks, but not sufficiently to justify the increased computational cost.

For pure ML solvers, we used EPD and ResNet models that do not build impose physical priors beyond time continuity of the governing equations. In both cases a neural network is used to predict the acceleration due to physical processes that is then summed with the forcing function to compute the state at the next time. Both EPD and ResNet models consist of a sequence of CNN blocks with skip-connections. The main difference is that the EPD model has an arbitrarily large hidden state (in our case, size 64), whereas the ResNet model has a fixed size hidden state equal to 2, the number of velocity components.

= DETAILS OF ACCURACY MEASUREMENTS <apx:pointwise_accuracy_extra>
In the main text we have presented accuracy results based on correlation between the predicted flow configurations and the reference solution. We reach the same conclusions based on other common choices, such as squared and absolute errors as shown in @fig:mae_mse_errors comparing learned discretizations to DNS method on Kolmogorov flow with Reynolds number $1000$.

As mentioned in the main text, we additionally evaluated our models on enlarged domains while keeping the flow complexity fixed. Because our models are local, this is the simplest generalization test. As shown in @fig:larger_domain_generalization (and @fig:model_comparison in the main text), the improvement for $2 times$ larger domains is identical to that found on a smaller domain.

= DETAILS OF OVERVIEW FIGURE <details-of-overview-figure>

The Pareto frontier of model performance shown in @fig:outline(a) is based on extrapolated accuracy to an $8 times$ larger domain. Due to computational limits, we were unable to run the simulations on the $16384 times 16384$ grid for measuring accuracy, so the time until correlation goes below $0.95$ was instead taken from the $1 times$ domain size, which as described in the preceding section matched performance on the $2 times$ domain.

The $512 times 512$ learned interpolation model corresponds to the depicted results in @fig:accelerating_dns, whereas the $256 times 256$ and $1024 times 1024$ models were retrained on the same training dataset for $2 times$ coarser or $2 times$ finer coarse-graining.

// [figvision] imgs/accelerating_dns_metrics.png
// Panel (a) is a line plot of vorticity correlation (y-axis, 0.0 to 1.0) versus time step (x-axis, 0 to 3000).
// Six series appear: DNS 64×64 (mint), DNS 128×128 (light green), DNS 256×256 (olive), DNS 512×512 (brown), DNS
// 1024×1024 (maroon), and LD 64×64 (blue dashed). All start at correlation 1.0 and decay sigmoidally toward
// roughly 0.1, shifting rightward as DNS resolution increases; the dashed LD trace falls among the
// mid-resolution DNS curves and ends in noisy fluctuations near zero. Panel (b) is a line plot of absolute
// velocity error (y-axis, 0.0 to about 1.1) versus time step (x-axis, 0 to 3000), using the same six series,
// colours, and dashed style for LD 64×64. The curves rise sigmoidally from zero, with lower-resolution DNS
// rising earliest and higher resolution later; the blue dashed LD trace rises between the 512×512 and 1024×1024
// DNS curves. All series saturate near 1.0–1.1 with mild fluctuations across the final third of the time range.
// Panel (c) is a line plot of squared velocity error (y-axis, 0.0 to 1.0) versus time step (x-axis, 0 to 3000),
// with the same six series and styles. All curves climb sigmoidally from zero; DNS 64×64 rises first and
// plateaus lowest, around 0.85, while DNS 1024×1024 rises last. The dashed LD 64×64 trace reaches about 1.0 near
// step 2000 and fluctuates around 0.9–1.0 through step 3000, indicating error convergence to order unity at late
// times.
#figure(placement: auto, image("imgs/accelerating_dns_metrics.png", width: 100%),
  caption: [
    Comparison of ML + CFD model to DNS running at different resolutions using varying metrics. (a) Vorticity correlation as presented in the main text. (b) Mean absolute error. (c) Absolute error of the kinetic energy.
  ]
) <fig:mae_mse_errors>

// vision: This figure contains three panels. (a) A 3×4 grid of vorticity snapshots for DNS 128×128, ML+CFD 128×128, and DNS 4096×4096 at time steps 0, 500, 1000, and 1500, sharing a colorbar from −10.0 to 10.0 vorticity. (b) Vorticity correlation (0.0-1.0) versus time step (0-2000; simulation time 0-12 on the top axis) for DNS 128×128 through 4096×4096 in light-green-to-dark-blue curves and ML+CFD 128×128 as a dashed orange curve; all decay from 1.0 toward about 0.1, with higher resolutions decaying later and ML+CFD tracking high-resolution DNS.
// [figvision] imgs/generalization_larger_domain.png
// Panel (a) is a 3 by 4 grid of square vorticity heatmaps. The columns are labeled Time step = 0, Time step =
// 500, Time step = 1000, and Time step = 1500. The rows are labeled DNS 4096 × 4096, ML+CFD 128 × 128, and DNS
// 128 × 128. Each cell shows turbulent red and blue vortex structures on a dark background, evolving from
// fine-scale mottling at time zero toward larger coherent swirls by step 1500. A horizontal colorbar below spans
// Vorticity from -10.0 to 10.0, with light blue at -10, black near zero, and dark red at 10. Panel (b) is a line
// plot of Vorticity correlation versus Time step, with the x axis from 0 to 2000 and the y axis from 0.0 to 1.0;
// a secondary top axis reads Simulation time from 0 to 12. Seven curves start near 1.0 and decay toward zero.
// Solid lines denote DNS at 128 × 128 light green, 256 × 256 light teal, 512 × 512 teal, 1024 × 1024 blue, 2048
// × 2048 dark blue, and 4096 × 4096 navy, with higher resolution shifting the decay later. A dashed orange curve
// marks ML+CFD 128 × 128 and tracks between the 1024 and 2048 DNS curves. Panel (c) is a log-log plot of Scaled
// energy spectrum E(k)k^5 versus Wavenumber k, with the y axis from 10^5 to 10^10 and the x axis from 1 to 30.
// Multiple curves rise steeply from k=1, peak around k=4 to 5 near 10^10, then roll over at higher k. The light
// green DNS 128 × 128 curve falls fastest, while darker blues and the orange dashed ML+CFD curve remain higher.
// Two rectangular insets connected by thin lines zoom into the peak region, an upper inset at high wavenumbers
// and a lower inset at intermediate wavenumbers, revealing curve separation and partial convergence.
#figure(placement: auto, image("imgs/generalization_larger_domain.png", width: 100%),
  caption: [
    Comparison of ML + CFD model to DNS running at different resolutions when evaluated on a $2 times$ larger domain with characteristic length-scales matching those of the training data. (a) Visualization of the vorticity at different times. (b) Vorticity correlation as a function of time. (c) Scaled energy spectrum $E ( k ) * k^5$.
  ]
) <fig:larger_domain_generalization>

= HYPERPARAMETER TUNING <apx:hyperparameters>
All models were trained using Adam @kingma2014adam optimizer. Our initial experiments showed that none of the models had a consistent dependence on the optimization parameters. The set that worked well for all models included learning rate of $10^(- 3)$, $b 1 = 0.9$ and $b 2 = 0.99$. For each model we performed a hyperparameter sweep over the length of the training trajectory $t_T$ used to compute the loss, model capacity such as size and number of hidden layers, as well as a sweep over different random initializations to assess reliability and consistency of training.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: none)
