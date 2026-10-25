#import "@preview/cetz:0.4.2"

// ---- document set ----
#set text(font: ("Times New Roman",), size: 12pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (x: 2.54cm, top: 2.64cm, bottom: 2.43cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0em, first-line-indent: (amount: 1.25em, all: false))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.9em, below: 1.7em)
#set par(leading: 1.73em)
#show heading.where(level: 1): set text(size: 14.4pt, weight: "bold")
#show heading.where(level: 2): set text(size: 12pt, style: "italic")
#show heading.where(level: 3): set text(size: 10.5pt, style: "italic")
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show figure.caption: set text(size: 10pt)
#show figure.caption: set par(leading: 0.65em)
#set figure(placement: top)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#show math.equation.where(block: true): set align(center)

#align(left)[#set par(first-line-indent: 0em, leading: 0.8em, spacing: 0em)
  #text(16pt, weight: "bold")[Photonics of Time-Varying Media]
  #v(1.4em)
  #text(12pt, weight: "bold")[Emanuele Galiffiᵃᵇ⁻, Romain Tiroleᵇ†, Shixiong Yinᵃ†, Huanan Liᵃ, Stefano Vezzoliᵇ,   Paloma A. Huidobroᵈ, Mário G. Silveirinhaᵈ, Riccardo Sapienzaᵇ, Andrea Alùᵃᵉ, and J. B. Pendryᵇ]
  #v(1.0em)
  #text(10pt)[
    ᵃ Photonics Initiative, Advanced Science Research Center, City University of New York, 85 St. Nicholas Terrace, 10031, New York, NY, USA \
    ᵇ The Blackett Laboratory, Department of Physics, Imperial College London, Prince Consort Road SW2AZ, London, UK \
    ᶜ School of Physics, Nankai University, Tianjin 300071, China \
    ᵈ Instituto de Telecomunicações, Instituto Superior Técnico-University of Lisbon, Avenida Rovisco Pais 1, Lisboa, 1049-001 Portugal \
    ᵉ Physics Program, Graduate Center, of the City University of New York, New York, NY 10016, USA \
  ]
]
#v(1.8em)

#block[
  #set text(size: 10pt)
  #set par(first-line-indent: 0em, leading: 0.5em)
// abshead
  #text(10pt, weight: "bold")[Abstract.] Time-varying media have recently emerged as a new paradigm for wave manipulation, thanks to the synergy between the discovery of novel, highly nonlinear materials, such as epsilon-near-zero materials, and the quest for novel wave applications, such as magnet-free nonreciprocity, multi-mode light shaping, and ultrafast switching. In this review we provide a comprehensive discussion of the recent progress achieved with photonic metamaterials whose properties stem from their modulation in time. We review the basic concepts underpinning temporal switching and its relation with spatial scattering, and deploy the resulting insight to review photonic time-crystals and their emergent research avenues such as topological and non-Hermitian physics. We then extend our discussion to account for spatiotemporal modulation and its applications to nonreciprocity, synthetic motion, giant anisotropy, amplification and other effects. Finally, we conclude with a review of the most attractive experimental avenues recently demonstrated, and provide a few perspectives on emerging trends for future implementations of time-modulation in photonics.

  #v(1.1em)
  #strong[Keywords:] time-varying, temporal modulation, metamaterials, switching, optics, photonics, light.
 ]

#v(1.2em)
#text(10pt)[#strong[\*]Emanuele Galiffi, egaliffi\@gc.cuny.edu. #strong[$dagger$] These authors contributed equally.]

#block[
  #set par(leading: 0.5em, first-line-indent: 0em, spacing: 0em)
  #show outline.entry.where(level: 1): set block(above: 0.7em)
  #show outline.entry.where(level: 1): set text(weight: "bold")
  #outline(title: [Contents], depth: 3)
]

= Introduction <sect:intro>

In the wake of the extraordinary scientific advances of the last two centuries, the role of time underpins many of the unsolved puzzles of the physical world. In quantum theory, time is the only quantity not associated to an observable, being merely treated as a variable, while attempts to bring it to a common ground with all other physical quantities are still in the making~@knox2021routledge. Meanwhile, at cosmological scales, the measured acceleration of the expansion of the universe makes it hard to imagine a complete cosmological theory where temporal dynamics of e.g. wave phenomena does not play a central role. Yet, most basic physics is carried out under the assumption that physical systems are passive, merely responding “after” any input stimuli.

Occasionally, the need to account for certain truly multi-physics or nonlinear phenomena brings up opportunities to develop our understanding of wave physics in temporally inhomogeneous systems: for instance, in order to realize bench-top analogues of relativistic phenomena early attempts were made to tap into time-modulated classical wave systems @schutzold2005hawking @philbin2008fiber. However, the critical mass of research efforts needed to accomplish sizeable advances in this direction has, until recently, been lacking. On yet another front of exploration, time-crystals have been proposed in condensed matter theory for almost a decade as a stable state of matter capable of spontaneously breaking continuous time-translation symmetry while preserving long-range temporal order @shapere2012classical: their very existence has been questioned and revised~@sacha2017time, and several increasingly successful implementations have recently been accomplished~@yao2020classical @kessler2021observation.

Meanwhile, over the past two decades, the rise of the field of metamaterials has proven how much fundamental wave physics lies untapped under the hood of well-established classical theories such as electromagnetism, acoustics and elasticity. Recently, the quest for novel forms of wave-matter interactions in these fields has led to a significant growth of interest in the exploration of time as a novel degree of freedom for metamaterials~@engheta2021metamaterials. In this pursuit, our need for even a basic understanding of wave phenomena in the time domain has reflected in the wealth of surprising physical effects recently unveiled, largely theoretically and in part experimentally, which can be enabled by externally applying explicit temporal modulations on the parameters of a physical system.

In this Review Article we present an overview of the state of the art across the rapidly expanding field of time-varying photonic metamaterials, in the hope that it may serve the photonics and metamaterials community as a catalyst for current and future explorations of this fascinating field. Whilst not as detailed as a tutorial paper, the review aims at presenting the basic building blocks of time-varying electromagnetics, with the main goal of developing basic insight into the relevant phenomenology, while offering a broad view of key past and future research directions in the field.

The paper is structured as follows: @sec:switching starts from the basics of electromagnetic time-switching, expanding towards more complex scenarios such as such as non-Hermitian and anisotropic switching, temporal slabs and space-time interfaces. @sec:timeperiodic is dedicated to photonic time-crystals, namely electromagnetic systems undergoing infinite (periodic or disordered) modulations of their parameters in time-only, and we discuss some of its most promising directions towards e.g. the engineering of topological phases, synthetic frequency dimensions, non-Hermitian physics and localization, concluding with some perspective on the peculiarities of time-varying surfaces. Spatiotemporal crystals are discussed in @sec:spacetime, where we introduce the peculiarities of space-time band diagrams, homogenization procedures for travelling-wave modulated systems enabling effective-medium descriptions of synthetic motion, and highlight some recently emerged opportunities for nonreciprocity, synthetic Fresnel drag and wave amplification and compression, as well as space-time modulated metasurface and some of their applications. Finally, @sec:experiments offers an overview of the most promising platforms for experimental implementations of time-modulation in photonics.

= Wave engineering with temporal interfaces <sec:switching>

#pagebreak(weak: true)
#figure(scale(118%, reflow: true, cetz.canvas(length: 0.72cm, {
    import cetz.draw: *

    let blu = rgb("#1f4e9c")
    let red = rgb("#c1272d")
    let grn = rgb("#2e8b57")
    let gy  = rgb("#888888")
    let sw  = 1.1pt

    // sine-wave polyline from p0, direction dx (+1 right / -1 left)
    let wave(p0, dx, length, cycles, amp, n: 48) = {
      let pts = ()
      for i in range(n + 1) {
        let t = i / n
        pts.push((p0.at(0) + dx * length * t,
                  p0.at(1) + amp * calc.sin(360deg * cycles * t)))
      }
      pts
    }
    let warr(p0, dx, length, col) = {
      line(..wave(p0, dx, length, 2.5, 0.26),
        stroke: (thickness: sw, paint: col),
        mark: (end: (symbol: "stealth", fill: col, length: 0.22, width: 0.14)))
    }
    let ax(ox, oy, ex, ey, lx, ly, lab) = {
      line((ox, oy), (ex, ey), stroke: (thickness: sw, paint: black),
        mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
      content((lx, ly), lab)
    }

    // ---------- Panel (a): spatial discontinuity ----------
    content((0.1, 6.9), anchor: "west", "(a)")
    content((1.1, 6.7), $n_1$)
    content((3.4, 6.7), $n_2$)
    line((2.5, 3.4), (2.5, 6.5), stroke: (thickness: sw, paint: black))
    line((2.5, 6.5), (4.4, 6.5), stroke: (thickness: sw, paint: black))
    line((2.5, 3.4), (4.4, 3.4), stroke: (thickness: sw, paint: black))
    warr((0.4, 5.7), -1, 1.8, blu)   // reflected (left)
    warr((0.5, 4.4),  1, 1.8, blu)   // incident (right)
    warr((2.75, 4.9), 1, 1.5, red)   // transmitted (right)
    ax(0.4, 3.0, 4.7, 3.0, 4.95, 3.0, $x$)

    // ---------- Panel (b): temporal discontinuity ----------
    content((6.6, 6.9), anchor: "west", "(b)")
    content((7.6, 6.7), $n_1$)
    content((9.9, 6.7), $n_2$)
    line((9.0, 3.4), (9.0, 6.5), stroke: (thickness: sw, paint: black))
    line((9.0, 6.5), (10.9, 6.5), stroke: (thickness: sw, paint: black))
    line((9.0, 3.4), (10.9, 3.4), stroke: (thickness: sw, paint: black))
    warr((6.9, 5.0), 1, 1.8, blu)    // incident (right)
    warr((8.8, 5.8), -1, 1.6, red)   // backward (left)
    warr((9.25, 4.3), 1, 1.5, red)   // forward (right)
    ax(6.9, 3.0, 11.2, 3.0, 11.45, 3.0, $t$)

    // ---------- Panel (c): dispersion, omega conserved ----------
    content((0.1, 1.3), anchor: "west", "(c)")
    let oc = (2.5, -1.1)
    let mb = 1.0
    let mr = 1.9
    ax(oc.at(0) - 2.3, oc.at(1), oc.at(0) + 2.3, oc.at(1), oc.at(0) + 2.55, oc.at(1), $k$)
    ax(oc.at(0), oc.at(1) - 1.6, oc.at(0), oc.at(1) + 2.3, oc.at(0) - 0.35, oc.at(1) + 2.45, $omega$)
    line((oc.at(0) - 2.2, oc.at(1) - 2.2 * mb), (oc.at(0) + 2.2, oc.at(1) + 2.2 * mb), stroke: (thickness: sw, paint: blu))
    line((oc.at(0) - 2.2, oc.at(1) + 2.2 * mb), (oc.at(0) + 2.2, oc.at(1) - 2.2 * mb), stroke: (thickness: sw, paint: blu))
    line((oc.at(0) - 1.3, oc.at(1) - 1.3 * mr), (oc.at(0) + 1.3, oc.at(1) + 1.3 * mr), stroke: (thickness: sw, paint: red))
    line((oc.at(0) - 1.3, oc.at(1) + 1.3 * mr), (oc.at(0) + 1.3, oc.at(1) - 1.3 * mr), stroke: (thickness: sw, paint: red))
    let h = 1.3
    line((oc.at(0) - 2.1, oc.at(1) + h), (oc.at(0) + 2.1, oc.at(1) + h), stroke: (thickness: 0.8pt, paint: gy, dash: "dashed"))
    circle((oc.at(0) - h / mr, oc.at(1) + h), radius: 0.13, fill: grn, stroke: none)
    circle((oc.at(0) + h / mr, oc.at(1) + h), radius: 0.13, fill: grn, stroke: none)
    circle((oc.at(0) + h / mb, oc.at(1) + h), radius: 0.13, fill: white, stroke: (thickness: 0.9pt, paint: black))

    // ---------- Panel (d): dispersion, k conserved ----------
    content((6.6, 1.3), anchor: "west", "(d)")
    let od = (9.0, -1.1)
    ax(od.at(0) - 2.3, od.at(1), od.at(0) + 2.3, od.at(1), od.at(0) + 2.55, od.at(1), $k$)
    ax(od.at(0), od.at(1) - 1.6, od.at(0), od.at(1) + 2.3, od.at(0) - 0.35, od.at(1) + 2.45, $omega$)
    line((od.at(0) - 2.2, od.at(1) - 2.2 * mb), (od.at(0) + 2.2, od.at(1) + 2.2 * mb), stroke: (thickness: sw, paint: blu))
    line((od.at(0) - 2.2, od.at(1) + 2.2 * mb), (od.at(0) + 2.2, od.at(1) - 2.2 * mb), stroke: (thickness: sw, paint: blu))
    line((od.at(0) - 1.3, od.at(1) - 1.3 * mr), (od.at(0) + 1.3, od.at(1) + 1.3 * mr), stroke: (thickness: sw, paint: red))
    line((od.at(0) - 1.3, od.at(1) + 1.3 * mr), (od.at(0) + 1.3, od.at(1) - 1.3 * mr), stroke: (thickness: sw, paint: red))
    let w = 1.0
    line((od.at(0) + w, od.at(1) - 1.6), (od.at(0) + w, od.at(1) + 2.3), stroke: (thickness: 0.8pt, paint: gy, dash: "dashed"))
    circle((od.at(0) + w, od.at(1) + mr * w), radius: 0.13, fill: grn, stroke: none)
    circle((od.at(0) + w, od.at(1) - mr * w), radius: 0.13, fill: grn, stroke: none)
    circle((od.at(0) + w, od.at(1) + mb * w), radius: 0.13, fill: white, stroke: (thickness: 0.9pt, paint: black))
  })),
  caption: [
    Scattering at (a) a spatial discontinuity, generating transmitted and reflected waves propagating in different media with refractive indices $n_1$ and $n_2$, and (b) a temporal discontinuity, generating forward and backward waves propagating in the same medium. (c,d) Illustration of the respective scattering processes on a dispersion diagram: the blue and red lines denote the dispersion cone for the two media. Note how the frequency $omega$ is conserved in a spatial scattering process, and coupling occurs to forward and backward modes in the two different media, whereas in a time-scattering process the momentum $k$ is conserved, and the two scattered waves are both embedded in the new medium.
  ]
) <fig:introFigure>

Light scattering by spatial interfaces \[@fig:introFigure\(a)\] is at the basis of many wave phenomena, from the simplest refraction effects to the complexity of wave engineering in complex media involving multilayers @novotnyPrinciples2012, anisotropy @salehFundamentals2019, nonlinearity @boydNonlinear2020, extreme constitutive parameters @veselagoElectrodynamics1967, @pendryNegative2000 @aluEpsilon2007, or metamaterials and metasurfaces @iyerMetamaterials2020, to name a few. How do electromagnetic waves behave when encountering interfaces in time rather than in space? Temporal interfaces can be created by abruptly switching the material properties of a medium in time, preserving its spatial continuity \[@fig:introFigure\(b)\]. Wave propagation in switched media was firstly investigated by Morgenthaler in 1958~@novotnyPrinciples2012. In parallel, the study of light interactions with abruptly switched materials was developed in the plasma physics community, since the plasma permittivity can be switched in time by fast ionization processes~@salehFundamentals2019. In this section, we focus on the recent explorations on time-switching in photonic materials.

== Temporal boundary conditions and temporal scattering <temporal-boundary-conditions-and-temporal-scattering>

It is well-known that wave propagation across spatial interfaces is governed by established boundary conditions, see e.g., @jacksonClassical2012. The essential constraint is that all relevant physical quantities, for instance, electric and magnetic fields ($(bold(E))$ and $(bold(H))$), must be finite at all points in space and time. Spatial boundary conditions are therefore derived by integrating Maxwell's equations over an infinitesimal area and volume across the spatial interface, implying the continuity of tangential $(bold(E))$ and $(bold(H))$ at an interface that does not support surface current densities. Dually, the integration over a time interval across a temporal boundary obeys temporal boundary conditions. Let us start with the macroscopic Maxwell’s curl equations:

$
  frac(partial bold(B), partial t) &= - nabla times bold(E)
$ <eq:Faraday>

$
  frac(partial bold(D), partial t) &= -bold(J) + nabla times bold(H)
$<eq:Ampere>

Here we assume that the medium is unbounded and homogeneous before and after a switching instance at $t = t_0$. Integrating from $t_0^- = t_0 - epsilon$ to $t_0^+ = t_0 + epsilon$ with a vanishing $epsilon$, we expect that the right-hand sides of @eq:Faraday and @eq:Ampere are both zero, due to the finite values of fields and sources. Then we obtain the temporal boundary conditions:

$
  bold(B) (t = t_0^+) &= bold(B) (t = t_0^-) \
  bold(D) (t = t_0^+) &= bold(D) (t = t_0^-)
$<eq:time_BC>

They ensure that the magnetic flux density $(bold(B))$ and the electric displacement $(bold(D))$ vary continuously in the time domain. Alternatively, the continuity of $(bold(B))$ and $(bold(D))$ can also be interpreted by the conservation of magnetic flux $Phi$ and electric charges $Q$, as shown by Morgenthaler @morgenthalerVelocity1958    and Auld @auldSignal1968, respectively.

One of the most intriguing phenomena that the temporal discontinuity in a medium brings about is that it can scatter waves in a way dual to spatial interfaces, producing forward and backward waves in time, rather than waves reflected and transmitted in space @morgenthalerVelocity1958 @auldSignal1968 @fanteTransmission1971 @fanteOn1973 @mukherjeeReflection1973 @xiaoReflection2014. The scattering coefficients can be found by applying the above temporal boundary conditions. Consider a monochromatic plane wave traveling in an unbounded, homogeneous, isotropic, non-dispersive but time-varying medium. Both permittivity $epsilon$ and permeability $mu$ are assumed to abruptly switch from their initial values $epsilon_1$ and $mu_1$ to $epsilon_2$ and $mu_2$ at $t = t_0$. We can denote the incident wave with $D_x = D_1 e^(j omega_1 t - j k z)$ and $B_y = B_1 e^(j omega_1 t - j k z)$, where $omega_1$ is the angular frequency and $k$ is the wavenumber. The field amplitudes are related by $B_1 = Z_1 D_1$ with $Z_1 = sqrt(mu_1 \/ epsilon_1)$.
The fields after the switching event read

$
  D_x (t > t_0) &= [T e^(j omega_2 (t - t_0)) + R e^(- j omega_2 (t - t_0))] D_1 e^(j (omega_1 t_0 - k_2 z)) \
  B_y (t > t_0) &= Z_2 [T e^(j omega_2 (t - t_0)) - R e^(- j omega_2 (t - t_0))] D_1 e^(j (omega_1 t_0 - k_2 z))
$ <eq:DBfields>

 $T$ and $R$ are the transmission and reflection coefficients defined for the electric displacement field, and $Z_2 = sqrt(mu_2\/epsilon_2)$ is the new wave impedance after switching. The temporal boundary conditions @eq:time_BC need to be satisfied everywhere in space, which implies that $k_2 = k$, or equivalently

$
  omega_2 sqrt(epsilon_2 mu_2) &= omega_1 sqrt(epsilon_1 mu_1).
$<eq:mometum_consv>

This condition ensures momentum conservation across temporal interfaces, which is expected due to the preserved spatial homogeneity~@morgenthalerVelocity1958 @mendonccaTheory2000 @salemSpace2015 @calozSpacetime2020a. By equating the incident and scattered $bold(D)$ and $bold(B)$ fields at $t = t_0$, we solve for the temporal scattering coefficients:

$
  T &= frac(Z_2 + Z_1, 2 Z_2), \
  R &= frac(Z_2 - Z_1, 2 Z_2).
$<eq:Coeff>

The coefficients for the electric field can be easily found by substituting the constitutive relation between $D$ and $E$, which are adopted more widely in the literature. It should be emphasized that the results presented in @eq:mometum_consv and @eq:Coeff generally apply to an abrupt temporal interface under the assumptions of spatial homogeneity, isotropy and instantaneous response of materials, and may change if one or more of these assumptions are relaxed @bakunovReflection2014.  Illustrations of spatial and temporal scattering processes are given in @fig:introFigure (a,c) and (b,d) respectively. As we consider more realistic and complicated electrodynamic models of materials, such as anisotropy, dispersion, and broken translational symmetry in space, the temporal scattering is expectedly modified~@kalluriElectromagnetics2018 @akbarzadehInverse2018 @bakunovLight2021 @SolisTime2021 @gratusTemporal2021 @zhangTemporal2021  @zhangTime2021. To date, research on these topics is very active, as discussed in the following subsections.

== Temporal slabs <temporal-slabs>

Leveraging scattering phenomena at time interfaces, research efforts have been dedicated to the engineering of wave interference in time, for example in the context of discrete time crystals @elseFloquet2016 @yaoDiscrete2017 and time metamaterials~@pacheco2021temporal @yaoDiscrete2017. Even when multiple temporal interfaces are involved, temporal interferences occur only between forward and backward waves induced by each boundary independently, due to the irreversibility of time, which introduces significant differences compared to spatial interfaces. A key contrast between spatial and temporal scattering from a mathematical standpoint is that space-scattering generally gives rise to boundary-value problems, whereas time-scattering leads to initial-value problems. Here we discuss the recent progress in temporal slabs comprising one or two consecutive switching events. In @sec:timeperiodic, we discuss (quasi-)periodically switched media.
The temporal interference introduced by a single temporal slab was firstly investigated by Mendonça and Martins in Ref.~@mendonccaTemporal2003, where they switched the refractive index of a medium from $n_0$ to $n_1$, and then switched it back to $n_0$ after a time interval $tau$. The total transmission and reflection amplitudes were found to be

$
  T_"total" &= [cos(omega_1 tau) + j \/ (2 alpha) (1 + alpha^2) sin(omega_1 tau)] e^(- j omega_0 tau), \
  R_"total" &= - j \/ (2 alpha) (1 + alpha^2) sin(omega_1 tau) e^(j omega_0 tau),
$<eq:SlabCoeff>

where $alpha = n_0\/n_1$ and $omega_0$, $omega_1$ are the frequencies of waves outside and inside of the temporal slab, respectively. Similar results were also obtained using a quantum optics formulation, illustrating the probability of creating Fock states of photon pairs with opposite momentum from the vacuum state @mendonccaTemporal2003.  A temporal Fabry-Perot slab with dispersion was recently studied in Ref.~@zhangTime2021, with slightly different results due to dispersion. The most important phenomenon induced in these systems may arguably be the amplification of light. Because frequency and energy are not conserved at time boundaries, we can indeed expect large amplification of the input energy at a suitably tailored temporal slab. It can be seen from @eq:SlabCoeff that such amplification process attains the maximum level when time interval $omega_1 tau$ is an odd multiple of $pi\/2$. On the contrary, time reflections can be minimized with a different choice of switching intervals. This finding can be connected to the dual phenomenon of impedance-matching layers in spatial scattering. Indeed, Pacheco-Peña and Engheta have recently introduced antireflection temporal coatings by rapidly changing the permittivity of an unbounded medium twice~@pachecoAntireflection2020, making an analogy to the quarter-wavelength impedance matching in the spatial domain. The schematic of such coatings is shown in @fig:temporalSlab (a). To minimize the backward reflection when the permittivity is to be switched from $epsilon_1$ to $epsilon_2$, they introduced a temporal coating with permittivity $epsilon_"eq"$ and duration $Delta t$ in between. Impedance matching is enabled with

$
  epsilon_"eq" &= sqrt(epsilon_1 epsilon_2), quad Delta t = frac(n T_"eq", 4); n = 1, 3, 5, dots.
$<eq:coating>

where $T_"eq" = 1\/f_"eq"$ is the equivalent period of the wave right after the permittivity is switched to $epsilon_"eq"$, and the equivalent frequency $f_"eq" = sqrt(epsilon_1\/epsilon_"eq") f_1$. A numerical simulation is shown in @fig:temporalSlab (b), indicating nearly vanishing reflection from the temporal interfaces. Although @eq:coating looks similar to the condition for impedance matching in the spatial case~@pozarMicrowave2011, it is more than a dual to its spatial counterpart. Firstly, the frequency is shifted from $f_1$ to $f_2 = sqrt(epsilon_1\/epsilon_2) f_1$, as shown in @fig:temporalSlab (c). In addition, the energy and power flow of the waves have also been modified as we change the permittivity of the material.

More recently, it has been shown that extreme power and energy manipulation can be achieved in these types of temporal slabs once loss and gain are considered. In analogy to conventional parity-time (PT) symmetry with balanced gain and loss @christodoulidesParity2018, Li #emph[et al.] investigated a scenario where a pair of temporal slabs obey temporal parity-time (TPT) symmetry~@christodoulidesParity2018. In their work, the temporal parity operation flips the arrow of time, while the "time" operation is defined to reverse the waves in space. TPT-symmetric temporal slabs are therefore realized if an unbounded medium is switched from a positive to a negative conductivity in time, $sigma_2 = - sigma_3 > 0$, for equal duration $Delta t$ before switching back to the initial Hermitian medium, as shown in @fig:temporalSlab\(d). Instantaneous material responses for both permittivity and conductivity have still been assumed here.

// [figvision-cn] imgs/switching_Fig1.png
// 子图(a)：这是一个二维曲线图，展示了介电常数随时间变化
// 的阶梯函数。横坐标为归一化时间 t/T，范围从27.5到29.5；
// 纵坐标为介电常数 ε(t)，范围从0到4。图中包含一条黑色实
// 线，表示在t=28.5T时刻之前介电常数为ε₁=1，之后突变为ε₂=
// 4。在突变点附近标注了Δt表示过渡时间宽度。下方有一个示
// 意图，显示一个沿时间轴t传播的波包结构，分为三段：左侧
// 灰色区域标有ε₁=1，中间绿色区域标有ε_eq，右侧浅蓝色区域
// 标有ε₂=4，整体示意等效介质模型中的时空调制过程。 子图(
// b)：这是两个并排的二维场分布热图，展示电磁波在不同时刻
// 的空间分布。上下两幅图共享相同坐标系统：横坐标为x/λ₁（
// 波长归一化位置），范围-20到20；纵坐标为y/λ₁，范围-5到5。
// 颜色条位于右侧，标注E_y，代表电场y分量，颜色从深蓝（负
// 值）经白色（零）到红色（正值）。上图对应t/T=26.8，显示
// 从左向右传播的入射波（Incident箭头指示），波形密集条纹
// 集中在x>0区域。下图对应t/T=38.8，显示经过变换后的波前：
// 左侧出现标记“BW-0”的反向波（带叉号箭头），右侧为标记“
// FW”的前向波（实心箭头），表明波被部分反射和透射。两图
// 均用彩色条纹表示驻波或行波干涉图案。 子图(c)：这是一个
// 归一化频谱图，横坐标为归一化频率f/f₀，范围0.0到2.0；纵
// 坐标为归一化谱强度Norm. spectra (a.u.)，范围0.0到1.0。
// 图中包含四条曲线：黑色实线为入射波（Incident），峰值在
// f/f₀≈1.0；绿色实线为带变换器时的后向波（BW with
// transformer），峰值在f/f₀≈0.5；棕色虚线为无变换器时的
// 后向波（BW w/o transformer），几乎为零；橙色点划线为带
// 变换器时的前向波（FW），与入射波重合。图中用黑色双向箭
// 头标注“Frequency changed”，连接入射峰与后向峰，说明频
// 率发生偏移。另有一条棕色曲线标注“BW - 0 transformer”，
// 表示无器件时后向波可忽略。 子图(d)：这是一个时空演化示
// 意图，横坐标为时间t（单位1/ω₁），纵坐标为空间z（未标数
// 值但隐含分层结构）。图中用不同颜色填充矩形区域表示不同
// 区域的介电常数ε(t)和电导率σ(t)。左侧浅蓝区标ε₁、σ₁；中
// 间绿区标ε₂、σ₂；右侧红区标ε₃、σ₃；最右浅蓝区标ε₄、σ₄。
// 虚线框标示Δt和2Δt的时间窗口，对应调制脉冲作用区间。底
// 部虚线箭头指向Time t轴，强调时间演化方向。该图用于说明
// 材料参数在时空上的分段恒定调制方案。 子图(e)：这是一个
// 能量-时间-空间三维数据投影的热图，横坐标为Time t (1/ω₁
// )，范围0到4；纵坐标为Energy，范围0.0到1.2；水平轴为
// position z，范围-15到15。颜色条位于右侧，标注V/m，表示
// 电场幅度，范围-1.5到1.5 V/m，颜色从深蓝（负）经白（零）
// 到红（正）。图中可见多个彩色块状区域，随时间推移在空间
// 中移动或变形，例如在t=0~2期间，高能量区（粉红/紫红）从
// 中心向两侧扩散，随后在t>2时重新聚集。这反映了能量在调
// 制介质中的动态输运过程。 子图(f)：结构与子图(e)类似，
// 也是能量-时间-空间热图，横坐标Time t (1/ω₁) 0–4，纵坐
// 标Energy 0.0–4.5，水平轴position z -15–15。颜色条标注V
// /m，范围-3.2到3.2 V/m。与(e)相比，此处能量尺度更大，且
// 存在明显的非线性特征：在t≈2.5处，右侧出现陡峭上升的能
// 量前沿（红色垂直线），同时左侧能量分布呈现复杂振荡模式。
// 图中还用红色折线勾勒出能量包络边界，突出显示能量集中区
// 域随时间的演化轨迹，暗示强非线性效应或孤子形成。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/switching_Fig1.png", width: 100%)

  ],
  caption: [
    \(a) Schematic of antireflection temporal coatings proposed in @pachecoAntireflection2020. (b) Numerical results for the field distribution before and after the temporal scattering, showing the incident and transmitted waves, with minimized reflection due to the temporal coating shown in (a). (c) Spectra of the incident, forward and backward waves. (d) Schematic of temporal parity-time (TPT) symmetric structures proposed in @liTemporal2021. (e) and (f): The time evolution of the normalized energy (solid curves) and its two constitutions (circle symbols for interferences and the dashed curves for another). (e) depicts the case of maximum total power while (f) shows that of minimum total power. Insets are the field distributions in simulations before, during and after the TPT slabs. Figures adapted from @pachecoAntireflection2020 and @liTemporal2021.
  ]
) <fig:temporalSlab>

By introducing a general temporal scattering matrix formulation, which may be powerfully applied to any multi-layer configuration of temporal interfaces, such (temporally finite) TPT-symmetric structures have been proven to always reside in their symmetric phase, for which the scattering matrix supports unimodular eigenvalues. Interestingly, the non-orthogonal nature of wave interference in non-Hermitian media enables exotic energy exchanges, despite the fact that the overall temporal bilayer is in its symmetric phase. As a result, the total power flow carried by the waves after the switching events, $P_(t o t) ( t ) = P^(+) ( t ) + P^(-) ( t )$ with $P^± ( t )$ for the forward/backward propagating wave, can be significantly different from the incident one. By controlling the relative phase of two incident counter-propagating waves, we can reach drastically different total power flows for the same TPT-symmetric temporal bilayer. As an example, for $n_1 = 1$, $n_2 = 2 - j 0.2$ and $2 omega_1 Delta t = 3.5$, the temporal evolution of the normalized stored energy density (solid curves) and its two components $U_i = 2 epsilon [| E^(+) ( t ) |^2 + | E^(-) ( t ) |^2]$ (dashed curves, proportional to the total power flow in the two waves $E^(+) ( t )$ and $E^(-) ( t )$, and equal to the total stored energy in Hermitian media) and $U_c = 2 (R e) [n ( n^(*) - n ) E^(+) ( t ) E^(-) ( t )^(*)]$ (circle symbols, stemming from the non-orthogonality of the counter-propagating waves in non-Hermitian media) are shown in @fig:temporalSlab\(e,f) for two different relative phases of the input waves, yielding widely different power flows after the switching events. Thus, dramatic power amplification and attenuation can be achieved in such non-Hermitian temporal bilayers as a function of the relative phase of the excitations, as a dual phenomenon to laser-absorber pairs in conventional PT-symmetric systems.

== Temporal switching in anisotropic media <switchingAnisotropic>
Recent research has added new degrees of freedom to enable exotic wave transformations based on time-switching. One intriguing possibility is to consider material anisotropy and spatial dispersion. In 2018, Akbarzadeh #emph[et al.] raised the question of whether it is possible to realize an analogue of Newton's prism, illustrated in @fig:switchingAnisotropy\(a) @akbarzadehInverse2018, in a time metamaterial. To map spatial frequencies into temporal frequencies, not only temporal invariance needs to be violated, but also spatial symmetry breaking is required to bridge different momenta with different frequency channels, as shown in @fig:switchingAnisotropy\(b). The result is an inverse prism, as presented in @fig:switchingAnisotropy\(c), in which an unbounded isotropic medium with scalar refractive index $n_1$ is switched to a uniaxial medium with $overline(overline(n))_2 = "diag"(n_parallel, n_parallel, n_perp)$ at $t = t_0$. The right part of panel (c) represents the isofrequency curves of the medium before and after switching. Because the medium remains homogeneous, the conservation of wavenumber $bold(k)$ (momentum) still holds, leading to "birefringence" in temporal frequencies. A monochromatic wave at frequency $omega_1$ propagating in the isotropic medium before switching will then be mapped to different frequencies, depending on its polarization and momentum, following

$
  n_1 omega_1 = plus.minus n (bold(k)) = cases(
    plus.minus n_parallel omega_2 & quad s"-polarization",
    (plus.minus n_parallel n_perp omega_2) \/ sqrt(n_parallel^2 cos^2 theta + n_perp^2 sin^2 theta) & quad p"-polarization",
  )
$

with $theta = tan^(- 1) (k_z \/ k_x)$ as defined in @fig:switchingAnisotropy\(c). In general, linearly polarized light experiencing such an inverse prism will feature Lissajous polarization with a time-varying phase difference between two orthogonal field components, due to the distinct values of $omega_2$ for #emph[s] and #emph[p]-polarizations.

One interesting phenomenon for wave propagation in anisotropic crystals is that the group velocity does not necessarily align with the phase velocity~@salehFundamentals2019. Based on this feature, the concept of temporal aiming was proposed in @pacheco-penaTemporal2020. @fig:switchingAnisotropy\(d) provides an overview of this phenomenon based on isotropic-to-anisotropic switching. A #emph[p]-polarized wave packet is immersed in a time-switched medium. Different switching schemes $macron(macron(epsilon))_r ( t )$ shown in the insets would route the signal to different receivers (denoted Rx 1-3 in @fig:switchingAnisotropy\(d)). For an incoming wave with propagation angle $theta_1 = tan^(- 1) (k_z \/ k_x)$, the direction of momentum $(bold(k))$ after switching to the anisotropic medium remains the same $theta_(2 k) = theta_(1 k) = theta_1$, while that of the Poynting vector $(bold(S))$ is redirected to $theta_(2 S) & = tan^(- 1) (epsilon_(r 2 z)\/epsilon_(r 2 x) tan theta_1)$

// [figvision-cn] imgs/switching_Fig2.png
// 图(a)为空间界面示意图。横轴为x，纵轴为z。图中有一条白
// 色曲线，标注为 z = z_0(x)。该曲线将平面分为两个区域：
// 下方灰色区域（z < z_0(x)）标注介电常数 n = n_1；上方灰
// 色区域（z > z_0(x)）标注介电常数 n = n_2(\omega)。在界
// 面上方某点，有一束由红、橙、黄、绿、蓝、紫六种颜色组成
// 的射线呈扇形向右上方发散，表示不同频率的光在空间不均匀
// 介质中的传播路径。 图(b)为时间界面示意图。横轴为x，纵
// 轴为t。图中有一条白色斜线，标注为 t = t_0。该线将平面
// 分为两个区域：左下方灰色区域（t < t_0）标注 n = n_1；
// 右上方灰色区域（t > t_0）标注 n = n_2(k)。在界面右侧某
// 点，有一束由红、橙、黄、绿、蓝、紫六种颜色组成的射线呈
// 扇形向左上方和右上方发散，表示在不同时刻介质突变后波的
// 传播方向。 图(c)包含三个部分。左侧为时空坐标系示意图，
// 横轴为ct，纵轴为t（实际应为z或空间坐标，但图中标注为ct
// 与t，可能为笔误，按图示理解：纵轴为空间z，横轴为时间t
// 乘以光速c）。一条蓝色箭头从原点指向右上，标注 \omega_1，
// 位于 n=n_1 区域；另一条蓝色箭头从界面处指向左上，也标
// 注 \omega_1，位于 n=\bar{n}_2 区域。中间为折射率张量定
// 义：\bar{n}_2 = \begin{pmatrix} n_\parallel & 0 & 0 \\
// 0 & n_\parallel & 0 \\ 0 & 0 & n_\perp \end{pmatrix}。
// 右侧为色散关系图，横轴为 ck_x/n_1，纵轴为 ck_z/n_1。图
// 中有一个蓝色大圆，代表各向同性介质中的等频面；内部有三
// 个椭圆：红色、绿色、橙色，分别对应不同偏振或模式。中心
// 有五个彩色箭头从原点发出，标注 \omega_{min}, \omega_2,
// \omega_p, \omega_{max}，表示不同频率下的波矢方向。右下
// 角小图为三维坐标系 x,y,z，显示波矢 k_1 分解为 k_x, k_z
// , s, p 分量，并标注角度 \theta。 图(d)为实验装置与信号
// 接收示意图。左下角为发射源：一个红色圆圈标注 H，旁边有
// 电场 E 的螺旋波形，入射角 \theta_i，沿虚线传播。上方有
// 三个接收器 Rx1（绿色）、Rx2（橙色）、Rx3（紫色），位置
// 分散。每个接收器上方对应变压率随时间变化曲线：Rx1 曲线
// 为阶跃函数，从 \epsilon_{r1} 跳变到 \epsilon_{r2}；Rx2
// 和 Rx3 曲线为矩形脉冲，在 t_1 到 t_2 之间值为 \
// epsilon_{r2}，其余时间为 \epsilon_{r1}。图中还有多个彩
// 色箭头指示波传播方向，颜色与接收器匹配。 图(e)为空间布
// 儒斯特角示意图。标题“Spatial Brewster angle”。背景分为
// 上下两部分：上部浅橙色区域标注 \epsilon_{r1}，下部浅绿
// 色区域标注 \epsilon_{r2}。界面为垂直虚线。入射波从左下
// 进入，标注 H_i, E_i, k_i, \theta_i；反射波消失，标注 R
// =0（红色叉号）；透射波进入下方，标注 H_t, E_t, k_t, \
// theta_t。坐标系 x-z 显示在左下角。 图(f)为时间布儒斯特
// 角示意图。标题“Temporal Brewster angle”。左侧为介电常
// 数随时间变化曲线：在 t<t_1 时为 \epsilon_{r1}，t>t_1
// 时突变为 \epsilon_{r2x} 和 \epsilon_{r2z}（分层结构）。
// 右侧分为左右两栏：左栏 t<t_1，显示入射波 H_i, E_i, k_i
// , \theta_i；右栏 t>t_1，显示反射波 H_FW, E_FW, k_FW, \
// theta_{FW} 和透射波 H_BW, E_BW, k_BW, \theta_{BW}，并
// 标注 BW=0？（问号表示待验证）。底部标注“Unbounded”，表
// 示无边界条件。所有矢量均用箭头表示方向和偏振。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/switching_Fig2.png", width: 100%)

  ],
  caption: [
    \(a) A conventional prism decomposing white light into its frequency components in different directions. (b) An inverse prism that maps the light with different momentum into different frequencies. (c) Implementation of the inverse prism proposed in @akbarzadehInverse2018. (d) Temporal aiming proposed in @pacheco-penaTemporal2020. (e) The conventional Brewster angle. (f) Temporal Brewster angle described in @pacheco-penaTemporal2021. Figures adapted from @akbarzadehInverse2018, @pacheco-penaTemporal2020 and @pacheco-penaTemporal2021.
  ]
) <fig:switchingAnisotropy>

assuming that the anisotropic medium is a uniaxial crystal with $macron(macron(epsilon))_(2 r) = "diag"(epsilon_(2 x), epsilon_(2 x), epsilon_(2 z))$. The discrepancy between $theta_(2 S)$ and $theta_1$ plays a key role in the aiming process by enforcing that the wave packet drifts transversely to the initial propagation direction. After an appropriate duration, the medium is then switched back to the initial state to allow the signal to travel again at the same frequency and direction. The idea of signal aiming through temporal switching paves the way to routing waves through temporal interfaces, creating a form of temporal waveguiding.

Another interesting phenomenon exploiting temporal switching with anisotropic media is the temporal Brewster angle~@pacheco-penaTemporal2021. The conventional Brewster angle is defined as the angle at which the reflection of #emph[p]-polarized incidence vanishes, as shown in @fig:switchingAnisotropy\(e). Its temporal counterpart is illustrated in @fig:switchingAnisotropy\(f), and similarly determined by the condition that no backward wave is produced at the time interface. The temporal Brewster angle is given by the following simple expression: $theta_(t B) & = sin^(- 1) sqrt(frac(epsilon_(r 2 x) (epsilon_(r 2 z) - epsilon_(r 1)), epsilon_(r 1) (epsilon_(r 2 z) - epsilon_(r 2 x)))) .$ Notice that the Brewster angle for #emph[s]-polarized waves is also expected if we consider biaxial anisotropy where $epsilon_(2 x) eq.not epsilon_(2 y) eq.not epsilon_(2 z)$. These results open the new avenues in controlling the polarization of waves by exploiting temporal interfaces. For instance, Xu #emph[et al.] have reported complete polarization conversion using anisotropic temporal slabs @xuComplete2021.

== Temporal switching in the presence of material dispersion <temporal-switching-in-the-presence-of-material-dispersion>

All previous results have assumed that the materials involved are non-dispersive, such that they respond to abrupt switching events instantaneously. However, caution is needed about this assumption, as the material response may have temporal dynamics comparable with the finite switching times of realistic modulation processes. In general, the temporal nonlocal response (dispersion) of a material can be considered by assuming a susceptibility kernel in the form $(bold(D)) ( t ) = epsilon_0 [epsilon_oo (bold(E)) ( t ) + integral d t' chi ( t t' ) (bold(E)) ( t - t' )]$, where $epsilon_oo$ is the background relative permittivity and $chi ( t t' )$ is the time-dependent electric susceptibility, which must satisfy causality. Recently, the generalization of the Kramers-Kronig relations have been introduced for both adiabatic @hayran2021spectral and non-adiabatic @solisFunctional2021 time-varying susceptibility $chi$. Research on temporal switching with material dispersion dates back to Fante's and Felson's work in 1970s @fanteTransmission1971 @fanteOn1973. In parallel, wave propagation phenomena such as self-phase modulation and frequency conversion were studied in rapidly growing plasmas due to ionization @yablonovitchSpectral1973 @yablonovitchSelfPhase1974 @jiangWave1975 @wilksFrequency1988. Comprehensive reviews on time-varying plasmas can be found in Refs.~@mendonccaTheory2000 and~@kalluriElectromagnetics2018.

Once material dispersion is not negligible, it has been shown that the electric field $(bold(E))$ becomes continuous at a time interface, giving rise to additional temporal boundary conditions in addition to @eq:time_BC. The temporal boundary conditions in this scenario have been derived in @SolisTime2021 from the perspective of Parseval's theorem and in @gratusTemporal2021 based on the balance of distributions. In the time domain, a Drude-Lorentz medium features a second-order differential equation for the electric polarization density $(bold(P))$: $frac(d^2 (bold(P)), d t^2) + gamma frac(d (bold(P)), d t) + omega_0^2 (bold(P)) = epsilon_0 omega_p^2 (bold(E))$ where $gamma$ is the collision damping rate, $omega_0$ is the natural frequency of the free electron gas, and $omega_p = sqrt(N e^2 \/ (m_e epsilon_0))$ with the volumetric carrier density $N$, and electron's mass $m_e$ and charge $e$. A time-switched $N$ was considered in Refs.~@bakunovLight2021 @SolisTime2021 to effectively change $omega_p$ abruptly. The boundary conditions at the temporal interface turn out to be the continuity of $(bold(B))$, $(bold(D))$, $(bold(E))$ (and therefore $(bold(P))$) and $d (bold(P)) \/ d t$. Meanwhile, the conservation of momentum $(bold(k))$ in general gives rise to four solutions for the new frequencies $plus.minus omega_(1, 2)$.

== Time-interfaces in spatial structures <time-interfaces-in-spatial-structures>

While drawing significant attention, the concept of time switching still bears the question about accessibility to practical implementations. Until now experimental work demonstrating time-reversal at a temporal interface has been limited to water-wave phenomena by Fink's group, whereby a water tank was uniformly shaken by an impulse, leading to the refocusing of the waves back to their emission point~@bacotTime2016. In addition to limitations in the achievable modulation speed and strength, one chief difficulty also lies in altering a medium in its entirety. Huge energy exchanges and stringent simultaneity of switching are typically required. Instead, more and more efforts have been geared towards switching materials only for spatially finite structures or in lower dimensions. For instance, temporal reflections were studied in Refs.~@menendezTime2017 @wilsonTemporal2018 @maslovTemporal2018 for two-dimensional graphene plasmons, as shown in @fig:switchingFinite\(a). In one-dimensional transmission lines, broadband and efficient impedance matching can be achieved by time-switching, as shown in @fig:switchingFinite\(b) from @shlivinskiBeyond2018. Since time-switching relaxes the constraint of time-invariance, the proposed matching schemes can go beyond the conventional Bode-Fano efficiency bounds.

Taking advantage of enhanced light-matter interactions in finite structures which support resonances, we can extend temporal switching to other applications. Switching resonant cavities enables possibilities for plasma radiation @moriConversion1995 and photon-generation~@cironePhoton1997. Similar ideas have also been applied to induce static-to-dynamic field radiation in a switched dielectric brick sandwiched in a waveguide~@mencagliStatic2021. Li and Alù explored a time-switched Dallenbach screen, whose schematic is shown in @fig:switchingFinite\(c), showing that time-switching can extend absorption bandwidth by changing the permittivity of an absorber whilst a broadband signal enters it~@liTemporal2021a. On a related note, Mazor #emph[et al.] unveiled how an excitation can be unitarily transferred between coupled cavities by switching the coupling strength, even if the detuning between the cavities is large~@mazorUnitary2021. An example of this phenomenon in a coupled LC resonator pair is shown in @fig:switchingFinite\(d): by properly switching the value of the coupling admittance, the energy stored in the capacitor $C_1$ can be transferred to $C_2$ efficiently. Subwavelength time-modulated meta-atoms have also been explored by Tretyakov's and Fleury's groups~@ptitcyn2019time, developing a consistent description of the interplay between time-modulation and dispersive polarizability~@mirmoosaDipole2020, while Engheta's group recently extended this concept to anisotropic meta-atoms, using it to demonstrate temporal deflection @pachecoSpatiotemporal2021, as shown in @fig:switchingFinite\(e).

// [figvision-cn] imgs/switching_Fig3.png
// (a) 子图类型为二维彩色等值线图（伪彩图），展示空间场分
// 布。横轴与纵轴未标注具体物理量名称或单位，但根据上下文
// 可推断为归一化空间坐标。图中颜色从深蓝（负值）经白色（
// 零值）过渡到深红（正值），表示某一物理量（如电场强度、
// 磁通密度或相位差）的空间分布。中心区域呈对称的“蝴蝶结”
// 状结构：左右两侧各有一个红色高值区，中间夹着一个蓝色低
// 值区，整体被同心椭圆环包围，外圈颜色渐变为浅橙和淡蓝。
// 图中标注两个黄色小箭头，分别指向左侧红色区和右侧红色区
// 的边缘，指示能量流动方向或波前传播方向。该图传达的趋势
// 是：在特定条件下，系统产生具有反对称性的局域化场分布，
// 且存在明显的干涉条纹特征。 (b) 子图包含上下两部分。上
// 半部分为电路示意图与时间波形图组合：左侧为传输线等效电
// 路模型，含电压源Vg、电阻Rg、特性阻抗Zc1、负载阻抗ZL；
// 传输线上标有Δz段长，以及i=1和i=2两个时刻的开关状态（
// CNTL控制信号）。右侧为三个波形曲线：蓝色实线标记“1”，
// 绿色虚线标记“Γ”，红色点划线标记“T”，横轴为t，纵轴无量
// 纲。下半部分为Bode-Fano极限对比图：横轴为ρ = RL/Rg（对
// 数刻度，范围10⁻²至10²），纵轴为η（效率，线性刻度0–0.25）。
// 图中三条曲线：蓝色实线标注“Switched TL, Passive Linear
// ”，红色实线标注“LTI, Passive”，灰色水平虚线标注“
// Bode-Fano Bound”。结论：切换式传输线（蓝色曲线）在宽频
// 带内超越传统线性无源系统的Bode-Fano极限，尤其在ρ≈1时达
// 到峰值效率约0.22，而LTI系统最大仅约0.14。 (c) 子图为三
// 维可视化示意图，背景黑色。左侧显示一条橙色正弦振荡曲线，
// 代表入射电磁波的时域波形；中间有一条垂直黄绿色光柱，象
// 征聚焦光束或倏逝波耦合区域；右侧是一个半透明蓝色立方体
// 块，代表样品或探测器。三者沿x轴排列，暗示波从左向右传
// 播并相互作用。该图传达的核心概念是：时域调制的入射波通
// 过某种机制（如非线性介质或超表面）转化为空间局域的激发
// 态或被探测信号。 (d) 子图分为上下两部分。上部为LC谐振
// 器耦合电路图：两个独立LC回路（L1-C1和L2-C2）通过双向箭
// 头S连接，分别对应端口v1和v2；虚线框内标注矢量Y̅₁和Y̅₂，
// 表示导纳矩阵元素。下部为能量演化图：横轴ΩR t（无量纲时
// 间，范围0–1.5），纵轴Ec/E₀（归一化电容储能，范围0–1.0）。
// 两条曲线：蓝色竖条填充区域标记EC₁，黄色斜纹填充区域标
// 记EC₂，两者交替起伏，呈现周期性能量交换；蓝色方框W标注
// 初始能量注入区间（约0–0.3）。趋势表明：两谐振器间发生
// 完全的能量来回转移，周期约为ΩR t ≈ 1.0，符合强耦合理论
// 预测。 (f) 子图为实验装置三维透视图。主体为一矩形GaAs
// 半导体芯片，尺寸标注w（宽）、d（厚）、L（长）；底部贴
// 附金属层（Metal layer），顶部受多束红色向下箭头照射，
// 标注“Optical pumping pulse”；侧面入射蓝色波浪线标注“
// Incident THz wave”，出射蓝色波浪线标注“Converted THz
// wave”；右上角双箭头标注“Polarization”，指示偏振方向可
// 调。坐标系xyz位于左下角，y轴向上，x轴向前，z轴向左。该
// 图说明：利用飞秒激光泵浦GaAs薄膜，在其表面诱导太赫兹辐
// 射转换过程，可通过调节泵浦偏振优化输出效率。 (g) 子图
// 为傅里叶变换功率谱图。横轴Frequency (THz)，范围0.2–0.8
// THz；纵轴FT Power (arb. units)，范围-0.25至+0.15。共六
// 条曲线，按延迟时间τp从上到下依次为：黑色实线（Without
// pumping）、蓝色实线（τp = 10 ps）、青色实线（5 ps）、
// 浅蓝实线（0 ps）、灰蓝实线（-5 ps）、浅绿实线（-10 ps）。
// 所有曲线均在~0.5 THz处出现主峰，其中“Without pumping”
// 曲线峰值最高（约+0.12），随|τp|增大，峰值逐渐降低甚至
// 反转符号（负值），表明泵浦脉冲延迟调控可有效抑制或增强
// 特定频率成分的太赫兹发射。 (e) 子图由多个部分组成。顶
// 部为散射几何示意图：左图为正方形物体（εrzz=6, εrxx=1,
// θ₁=45°），右图为圆形物体（相同参数），均标注incident θ
// ₁=45°及scattered θ₂方向；下方色标Hscatt从-1（蓝）到+1
// （红），表示散射磁场幅度。中部两张极坐标图：均为θ₁=45°
// 入射下的角分布，中心棕色方块/圆点代表目标，周围彩色环
// 带表示不同角度的散射强度，标注“~77°”指向最强散射方向；
// 右下角标注ν/T = 12.3，可能指归一化频率或温度比。整体结
// 论：各向异性材料（εrzz≠εrxx）在斜入射下产生非对称散射
// 图案，且形状（方vs圆）影响主瓣角度位置。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/switching_Fig3.png", width: 100%)

  ],
  caption: [
    \(a) Temporal reflection of graphene plasmons reported in @wilsonTemporal2018. (b) Impedance matching using a time-switched transmission line @shlivinskiBeyond2018 (c) Time-switched thin absorber in @liTemporal2021a. (d) Unitary excitation transfer between two coupled circuit resonators @mazorUnitary2021.  (e) Temporal deflection caused by isotropic-to-anisotropic switching on meta-atoms @pachecoSpatiotemporal2021. (f) Temporal switching of structural dispersion for ultrafast frequency-shifts, proposed in @miyamaruUltrafast2021. (g) Corresponding frequency spectra for the switching in panel (f). Figures adapted from @wilsonTemporal2018, @shlivinskiBeyond2018, @liTemporal2021a, @mazorUnitary2021, @pachecoSpatiotemporal2021 and @miyamaruUltrafast2021.
  ]
) <fig:switchingFinite>

Finally, abrupt changes to the structural dispersion of a cavity, realized e.g. by switching part of a structure, constitute yet another intriguing degree of freedom to be exploited. For instance, in @miyamaruUltrafast2021, Miyamaru #emph[et al.] achieved ultrafast terahertz frequency-shifts by metalizing the upper boundary of a single-metalized waveguide at sub-picosecond timescales via photocarrier excitation, thereby modifying its dispersion relation and inducing a large frequency shift, as shown in @fig:switchingFinite\(f,g). Similarly, nonlinear terahertz generation was reported later in ultrafast time-varying metasurfaces @tunesiTerahertz2021. Abruptly altering a spatial boundary can be interpreted heuristically as switching the effective permittivity of the waveguide structure @stefaniniTemporal2021, which also enforces a temporal interface on the fields inside the waveguide.

To summarize, in this section we discussed wave manipulation mechanisms in the presence of temporal interfaces. We revisited the temporal boundary conditions for Maxwell's Equations and highlighted a few representative works on temporal scattering and interferences. From the theory side the field is open to the study of more sophisticated material models, such as non-Hermitian, anisotropic and even bianisotropic switching mechanisms, also in spatially structured systems. In the quest for extreme wave phenomena, temporal switching with exotic media has opened a brand-new avenue for electromagnetics research and beyond, although its ultimate impact will hinge upon further implementations of temporal switching experiments, some of which we will discuss in @sec:experiments.

= Photonic Time-Crystals <sec:timeperiodic>

Having discussed the arsenal of potential wave phenomena based on individual time-switching, we now move on to consider systems whose properties are periodically (or quasi-periodically) modulated in time. The simplest mechanical archetype of such a parametric system is a pendulum, whose length is periodically modulated in time, one historic example being the “Botafumeiro”, an 80 kg incensory at the Cathedral of Santiago de Compostela, whose chain length is periodically modulated by monks, reaching speeds of 68 km/h over arc lengths of 65-meter within 17 modulation cycles~@sanmartin1984botafumeiro (a more familiar one is the child swing, whereby the height of the center of mass is modulated). In fact, a characteristic feature of parametric amplification is its exponential growth rate, as opposed to the linear growth that occurs in a driven oscillator.

We can make use of the scattering coefficients derived in @sec:switching, to construct the building blocks of parametric amplification in electromagnetism. After a first time-switching leading to a change of impedance $Z_1 = sqrt(mu_1 \/ epsilon_1) → Z_2 = sqrt(mu_2 \/ epsilon_2)$, the displacement field at time $t$ will comprise forward and backward waves according to: $D_2 ( t ) prop [ T_12 e^(j omega_2 t) + R_12 e^(- j omega_1 t) ]$. If we now switch the material again after a time $Delta t_2$, the new forward waves will encompass doubly-reversed and doubly-transmitted waves. Conversely, the backward waves will consist of waves which were reflected on only one of the two switching events, giving, after an additional time $Delta t_3$: $
  D_2 \/ D_0 & prop (T_12 e^(j omega_2 Delta t_2) T_23 + R_12 e^(- j omega_2 Delta t_2) R_23) e^(j omega_3 Delta t_3) \
  & + (T_12 e^(j omega_2 Delta t_2) R_23 + R_12 e^(- j omega_2 Delta t_2) T_23) e^(- j omega_3 Delta t_3)
$

This argument can be easily extended for a given number of switching events, with forward and backward waves consisting of scattering contributions involving an even and odd number of time-reversal processes $R_(i, i+1)$ respectively.

In order to study in more detail the effect of a periodic modulation, let us set the final parameters equal to the initial ones, $epsilon_3 = epsilon_1$ and $mu_3 = mu_1$, which forms one modulation cycle. Evaluating the energy content of the forward and backward waves, we arrive at:

$
  |bb(T)_2|^2 &= 1 + 1 \/ 2 frac(( Z_1^2 - Z_2^2 )^2, Z_1^2 Z_2^2) sin^2 ( omega_2 Delta t_2 ) \
  |bb(R)_2|^2 &= 1 \/ 2 frac(( Z_1^2 - Z_2^2 )^2, Z_1^2 Z_2^2) sin^2 ( omega_2 Delta t_2 )
$<eq:T2R3>

We now move on to study the key features of infinite time-periodic systems, which we shall regard as “photonic time-crystals” (PTC), although it should be noted that this term bears an ambiguity with the concept of time-crystal in condensed matter physics~@wilczek2012quantum, where it denotes a stable phase of matter which spontaneously breaks continuous time-translation symmetry. Here we intend PTCs as active systems relying on an externally induced time-periodic modulation of their constitutive parameters.

In a conventional photonic space-crystal (PSC) it is well-known that Bragg scattering between waves separated in momentum by integer multiples of the reciprocal lattice vector $(bold(g))$ of the crystal leads to the formation of band-gaps in energy, in correspondence with the high-symmetry points in reciprocal space (in 1D, this would happen at $k = ± g \/ 2$). In these gaps, the states have an imaginary momentum component, thus decaying into the crystal (growing states are forbidden by energy conservation). It is expected, therefore, that modulating a system periodically in time at frequency $Omega$ will yield band gaps in momentum ($k$-gaps) near the frequency $Omega \/ 2$, where $Omega$ plays the role of a reciprocal lattice vector, as a result of the interference between the waves which are forward scattered by the modulation, and those which are time-reversed. However, while in a PSC the wavevector is imaginary inside the band-gap, in a PTC it is the energy that acquires an imaginary component within a k-gap. As expected from our discussion on momentum and energy conservation in the previous section, while waves must spatially decay into the PSC to preserve energy, they can only grow in time as they interact with a PTC, in order to preserve momentum.

// [figvision-cn] imgs/figureTopologyPTC-01.png
// 子图(a)为曲线图。横坐标轴标签为“t/T”，表示归一化时间，
// 范围从0到10，刻度标记有0、5、10。纵坐标轴标签为“ε”，表
// 示介电常数，标有两个水平位置“ε₁”和“ε₂”。图中有一条蓝色
// 实线，描绘了介电常数随时间的变化：在t/T小于约-0.5时，
// 值为恒定的低值ε₁；从t/T约等于-0.5开始，波形在低值ε₁和
// 高值ε₂之间进行周期性方波跳变，形成一系列矩形脉冲，高电
// 平持续宽度与低电平持续宽度大致相等；该调制过程持续到t/
// T约等于9.5，之后恢复为恒定低值ε₁。 子图(b)为示意图，展
// 示了光子晶体带隙结构。横坐标轴标签为“k/k₀”，表示归一化
// 波矢量，范围从0到5，刻度标记有0、1、2、3、4、5。纵坐标
// 轴标签为“ωT”，表示归一化频率，范围从-4到4，刻度标记有
// -4、-2、0、2、4。图中绘制了多条深蓝色实线构成的色散关
// 系曲线，这些曲线呈菱形或交叉状排列，围成了多个封闭区域
// （带隙）。在特定的菱形区域内标注了数字“0”或希腊字母“π”。
// 背景中有垂直的浅灰色阴影条带，分别位于k/k₀约为0.5、1.5、
// 2.5、3.5、4.5的位置。在k/k₀=0.5处的上方有一个向下的黑
// 色箭头，箭头旁标注有“(c)”，指向该位置的带隙中心。 子图
// (c)为曲线图，是子图(b)中特定区域的放大视图。横坐标轴标
// 签为“k/k₀”，范围从约0.55到0.72，刻度标记有0.6、0.65、
// 0.7。纵坐标轴标签为“Phase [1/π]”，表示相位（单位为π），
// 范围从0到略高于1，刻度标记有0、0.5、1。图中有一条蓝色
// 实线，从左下方向右上方单调递增，呈现轻微的非线性弯曲。
// 图表内部上方标注有文字“Gap - 1”。 子图(d)为曲线图。横
// 坐标轴标签为“Modulation Periods”，表示调制周期数，范围
// 从0到16，刻度标记有0、8、16。纵坐标轴标签为“ε”，表示介
// 电常数，范围从0到3，刻度标记有0、1、3。图中有一条蓝色
// 实线，表现为周期性的方波信号，数值在1和3之间交替跳变。
// 子图(e)为曲线图，位于子图(d)正下方，共享相同的横坐标轴。
// 横坐标轴标签为“Modulation Periods”，范围从0到16，刻度
// 标记有0、8、16。纵坐标轴标签为“|D|”，表示电场强度的模，
// 范围从0到60，刻度标记有0、60。图中有一条蓝色实线，表示
// 电场强度随调制周期的变化。曲线在周期0到8之间振幅较小且
// 波动平缓；在周期8附近出现一个显著的尖峰，达到最大值接
// 近60；随后振幅逐渐衰减并伴随振荡；在周期16附近再次出现
// 一个次级峰值。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/figureTopologyPTC-01.png", width: 100%)

  ],
  caption: [
    \(a) Example of a (finite) layered PTC. (b) Band structure of a PTC, showing k-gaps and Zak numbers of the different bands. (c) Change of Zak phase across the first k-gap. (d) Example of an edge between two PTCs with opposite Zak phase. (e) Numerical demonstration of the effect of a temporal edge between two topologically inequivalent PTCs: the parametric amplification process is interrupted and the wave amplitude depleted for a few periods following the temporal edge, forming a temporally localized state. Figures reproduced from @lustigTopological2018.
  ]
) <fig:photonicTimeCrystals>

Let us consider an infinite series of switching events between $epsilon_1$ and $epsilon_2$, as shown for a few cycles in @fig:photonicTimeCrystals\(a). Being the problem periodic, the Floquet (Bloch) theorem holds, so that the solution may be written as $psi ( t ) = e^(i Omega t) phi.alt ( t )$, where $phi.alt ( t ) = phi.alt ( t + T )$, and $T = 2 pi \/ Omega$ is the period of the modulation. For the specific case of a step-like modulation, the temporal scattering coefficients can be related to each other by exploiting the symmetry $T_12 + R_12 = T_21 + R_21 = 1$, so that the Floquet bands can be calculated analytically~@lustigTopological2018, and can be seen in @fig:photonicTimeCrystals\(b). Notice how the k-gaps hosting the amplifying states open at $omega = Omega \/ 2$ (i.e. $omega T = pi$, where $T$ is the modulation period). The reason for this can be read off the solution for the double-switching problem in @eq:T2R3. Notice how the duration $Delta t_2$ determines whether or not gain will occur: if the duration of the modulation is half of the period $Delta t_2 = T \/ 2$, and we assume $omega_1 approx omega_2 = omega$, then at each switching process a net energy input from the contribution of the $sin^2 ( omega T \/ 2 )$ term will be coherently fed into the waves, leading to exponential growth or, in in the present of dominant losses, loss-compensation~@torrent2018loss. Related ideas were recently investigated, such as “multilayer” temporal slabs to design temporal transfer functions, in analogy with multilayer matching filters in spatial transmission line theory~@ramaccia2021temporal, @castaldi2021exploiting, and the effects of modulating both dielectric and magnetic parameters in a PTC @gaxiola2021temporal.

== Topology in photonic time-crystals <topology-in-photonic-time-crystals>

One recent direction emerged in the context of spatial crystals is that of topologically nontrivial photonic phases and symmetry-protected edge modes found at their interface with a topologically inequivalent crystal. The natural question of whether such a framework exists for temporal crystals has recently been answered in the affirmative, although experimental observations of temporal topological edge states are still missing~@lustigTopological2018. In 1D (infinite) crystals the topological character of the system is quantified via the Zak phase. A temporal edge state must therefore lie at the temporal interface between PTCs characterized by different Zak phases. For a layered PTC, the Zak phase can be calculated analytically via Floquet theory, and its change across the first k-gap is shown in @fig:photonicTimeCrystals\(c)~@lustigTopological2018. Far from a trivial generalisation, however, a temporal edge is a markedly different object than a spatial one. The edge modes commonly found at the interface between topologically inequivalent crystals are now to be sought near (more specifically later than) a specific instant of time, at which the properties of the PTC are suddenly changed. In addition, while spatial edge states occur within the frequency gap of a material where the eigenstates of the infinite crystal are evanescent, temporal edge states in a PTC are only found within k-gaps, so that the underlying wave dynamics is parametric amplification, and the transient wave which constitutes the edge state has the effect of temporarily opposing the exponential growth, as shown in @fig:photonicTimeCrystals\(d-e)~@lustigTopological2018.

In spite of time being a one-dimensional quantity, time-modulation can also provide a pathway towards higher-dimensional topological effects. This can be accomplished by constructing synthetic frequency dimensions, by using the frequency spectrum of the modes supported by a structure as an effective lattice of states, in analogy with the sites of a tight-binding lattice, as illustrated in @fig:syntheticDimensions\(a-c).

#figure(scale(132%, reflow: true, grid(
    columns: (1fr, 1fr),
    column-gutter: 6pt,
    row-gutter: 3pt,
    // ---- left column: a b c f g h ----
    grid(columns: 1, row-gutter: 2pt,
      // (a) frequency comb
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let rs = rgb("#cf3a1c"); let rk = rgb("#8f2410")
        let xs = (1.2,2.9,4.6,6.3,8.0,9.7)
        line((0.4,1.7),(11.2,1.7), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.22, width: 0.14)))
        content((11.5,1.7), $f$)
        for i in range(6) {
          let x = xs.at(i)
          line((x,1.7),(x,1.4), stroke: (thickness: 1.1pt, paint: black))
          content((x,2.15), str(i + 1))
          circle((x,0.8), radius: 0.3, fill: rs, stroke: (thickness: 0.8pt, paint: rk))
        }
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(a)]]
}),
      // (b) coupled chain
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let rs = rgb("#cf3a1c"); let rk = rgb("#8f2410"); let bl = rgb("#2a6fc0")
        let xs = (1.2,2.9,4.6,6.3,8.0,9.7)
        line((1.2,0.8),(9.7,0.8), stroke: (thickness: 1.4pt, paint: bl))
        for i in range(6) { circle((xs.at(i),0.8), radius: 0.3, fill: rs, stroke: (thickness: 0.8pt, paint: rk)) }
        let tl = ("12","23","34","45","56")
        for i in range(5) {
          content(((xs.at(i) + xs.at(i + 1)) / 2, 1.35), { set text(fill: bl, size: 8pt); $t_(#tl.at(i))$})
        }
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(b)]]
}),
      // (c) potential V(x)
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let rd = rgb("#c0272d"); let rs = rgb("#cf3a1c")
        line((0.4,0.2),(0.4,3.3), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.22, width: 0.14)))
        line((0.4,0.2),(10.8,0.2), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.22, width: 0.14)))
        content((11.1,0.2), $x$)
        content((1.7,3.1), $V (x)$)
        line((0.9,2.3),(10.2,2.3), stroke: (thickness: 1pt, paint: rd))
        for c in (2.15,3.85,5.55,7.25,8.95) {
          bezier((c - 0.75,0.35),(c + 0.75,0.35),(c,3.15), stroke: (thickness: 1.3pt, paint: black))
        }
        let sx = (1.3,3.0,4.7,6.4,8.1,9.8)
        for i in range(6) {
          circle((sx.at(i),2.3), radius: 0.28, fill: if i == 2 { rs } else { white }, stroke: (thickness: 1.1pt, paint: rd))
        }
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(c)]]
}),
      // (f) free sites
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let ys = rgb("#e8c62b"); let yk = rgb("#a5860f")
        let xs = (1.2,2.9,4.6,6.3,8.0,9.7)
        for i in range(6) {
          content((xs.at(i),1.45), str(i + 1))
          circle((xs.at(i),0.8), radius: 0.3, fill: ys, stroke: (thickness: 0.8pt, paint: yk))
        }
        line((9.9,0.1),(11.2,0.1), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.22, width: 0.14)))
        content((11.5,0.1), $x$)
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(f)]]
}),
      // (g) coupled chain
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let ys = rgb("#e8c62b"); let yk = rgb("#a5860f")
        let xs = (1.2,2.9,4.6,6.3,8.0,9.7)
        line((1.2,0.8),(9.7,0.8), stroke: (thickness: 1.4pt, paint: black))
        for i in range(6) {
          content((xs.at(i),1.45), str(i + 1))
          circle((xs.at(i),0.8), radius: 0.3, fill: ys, stroke: (thickness: 0.8pt, paint: yk))
        }
        content((2.05,0.25), $kappa$)
        line((9.9,0.1),(11.2,0.1), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.22, width: 0.14)))
        content((11.5,0.1), $x$)
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(g)]]
}),
      // (h) 2x3 ladder
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let ys = rgb("#e8c62b"); let yk = rgb("#a5860f"); let bl = rgb("#2a6fc0")
        let xs = (1.5,4.0,6.5)
        let yb = 0.9; let yt = 3.1
        for x in xs {
          line((x,yb),(x,yt), stroke: (thickness: 1.4pt, paint: bl))
        }
        line((1.5,yb),(6.5,yb), stroke: (thickness: 1.4pt, paint: black))
        line((1.5,yt),(6.5,yt), stroke: (thickness: 1.4pt, paint: black))
        for i in range(3) {
          content((xs.at(i),0.35), str(i + 1))
          content((xs.at(i),3.65), str(i + 4))
          circle((xs.at(i),yb), radius: 0.3, fill: ys, stroke: (thickness: 0.8pt, paint: yk))
          circle((xs.at(i),yt), radius: 0.3, fill: ys, stroke: (thickness: 0.8pt, paint: yk))
        }
        content((1.0,2.0), { set text(fill: bl, size: 9pt); $kappa'$})
        content((2.75,0.5), $kappa$)
        line((8.3,yb),(10.3,yb), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
        line((8.3,yb),(8.3,3.0), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
        content((10.6,yb), $x$)
        content((8.3,3.2), $y$)
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(h)]]
}),
    ),
    // ---- right column: (d e) / i / j ----
    grid(columns: 1, row-gutter: 2pt,
      grid(columns: 2, column-gutter: 3pt,
        // (d) ring resonator
        block({
cetz.canvas(length: 0.4cm, {
          import cetz.draw: *
          let org = rgb("#e8500f"); let ob = rgb("#a83808"); let blu = rgb("#3a63c0")
          content((1.8,6.6), { set text(fill: org, weight: "bold", size: 8pt); [Ring resonator] })
          circle((2.6,3.3), radius: 2.3, stroke: (thickness: 9pt, paint: org), fill: none)
          rect((2.0,0.75),(3.2,1.95), radius: 0.2, fill: blu, stroke: (thickness: 0.8pt, paint: rgb("#24418f")))
          content((2.6,2.7), { set text(fill: blu, size: 8pt); [Modulator] })
          content((2.6,0.15), { set text(fill: org, size: 9pt); $cos (Omega t + phi)$})
        })
place(top + left, dx: -21pt)[#text(size: 10pt, weight: "bold")[(d)]]
}),
        // (e) level scheme
        block({
cetz.canvas(length: 0.4cm, {
          import cetz.draw: *
          let rs = rgb("#cf3a1c"); let rk = rgb("#8f2410"); let bl = rgb("#2a6fc0"); let rd = rgb("#c0272d")
          line((2.0,-0.2),(2.0,6.6), stroke: (thickness: 1pt, paint: bl, dash: "dashed"))
          let ys = (6.0,4.1,2.2,0.3)
          let lb = ("2","1","0","-1")
          for i in range(4) {
            circle((2.0,ys.at(i)), radius: 0.28, fill: rs, stroke: (thickness: 0.8pt, paint: rk))
            content((0.4,ys.at(i)), anchor: "east", $omega_(#lb.at(i))$)
          }
          for i in range(3) {
            let yc = (ys.at(i) + ys.at(i + 1)) / 2
            line((1.72,yc - 0.55),(1.72,yc + 0.55), stroke: (thickness: 1.1pt, paint: bl), mark: (end: (symbol: "stealth", fill: bl, length: 0.18, width: 0.12)))
            line((2.28,yc + 0.55),(2.28,yc - 0.55), stroke: (thickness: 1.1pt, paint: rd), mark: (end: (symbol: "stealth", fill: rd, length: 0.18, width: 0.12)))
            content((2.75,yc), { set text(fill: rd, size: 8pt); $phi$})
            content((1.15,yc), { set text(fill: rd, size: 8pt); $-phi$})
          }
        })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(e)]]
}),
      ),
      // (i) chain of rings
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let yl = rgb("#cdd24a"); let yk = rgb("#8f9418")
        for x in (1.4,3.0,4.6,6.2) {
          circle((x,1.0), radius: 0.6, stroke: (thickness: 5pt, paint: yl), fill: white)
          circle((x,1.0), radius: 0.6, stroke: (thickness: 0.8pt, paint: yk), fill: none)
        }
        content((7.7,1.0), $dots$)
        circle((9.4,1.0), radius: 0.6, stroke: (thickness: 5pt, paint: yl), fill: white)
        circle((9.4,1.0), radius: 0.6, stroke: (thickness: 0.8pt, paint: yk), fill: none)
        content((4.6,0.05), $l$)
        line((10.2,0.4),(11.5,0.4), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
        content((11.8,0.4), $hat(z)$)
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(i)]]
}),
      // (j) synthetic 2D lattice
      block({
cetz.canvas(length: 0.4cm, {
        import cetz.draw: *
        let gs = rgb("#b7c93c"); let gk = rgb("#7c8a1e")
        let xs = (2.4,3.9,5.4,6.9,8.4,9.9)
        let ys = (0.9,2.4,3.9,5.4,6.9)
        for j in range(5) {
          for i in range(6) {
            if i < 5 { line((xs.at(i),ys.at(j)),(xs.at(i + 1),ys.at(j)), stroke: (thickness: 1pt, paint: black)) }
            if j < 4 { line((xs.at(i),ys.at(j)),(xs.at(i),ys.at(j + 1)), stroke: (thickness: 1pt, paint: black)) }
          }
        }
        for j in range(5) {
          for i in range(6) {
            circle((xs.at(i),ys.at(j)), radius: 0.22, fill: gs, stroke: (thickness: 0.7pt, paint: gk))
          }
        }
        content((3.15,7.3), $kappa$)
        content((1.6,6.9), anchor: "east", $g$)
        for j in range(4) { content((10.35,(ys.at(j) + ys.at(j + 1)) / 2), $phi_(l)$) }
        content((11.3,3.9), $dots$)
        line((1.7,0.9),(1.7,2.4), stroke: (thickness: 1pt, paint: black), mark: (start: (symbol: "stealth", fill: black), end: (symbol: "stealth", fill: black)))
        content((1.4,1.65), anchor: "east", $Omega$)
        line((2.4,0.4),(3.9,0.4), stroke: (thickness: 1pt, paint: black), mark: (start: (symbol: "|", fill: black, length: 0.2, width: 0.13)))
        content((3.15,0.05), $d$)
        line((11.0,0.5),(11.0,2.0), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
        line((11.0,0.5),(12.4,0.5), stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black, length: 0.2, width: 0.13)))
        content((11.2,2.2), $f$)
        content((12.6,0.5), $z$)
      })
place(top + left, dx: -13pt)[#text(size: 10pt, weight: "bold")[(j)]]
}),
    ),
  )),
  caption: [
    \(a) The resonant modes of a structure form a lattice. (b) Hopping through its sites can be enabled by time modulation, which can couple their different frequencies. (c) The resulting Hamiltonian is analogous to that of electrons in a periodic ionic potential. (d) A ring resonator combined with a modulator can reproduce such a model, (e) enabling hopping between its equally spaced resonant modes~@Kampfrath2010NatPhotCoherent @Kampfrath2013NatNanoTerahertz (f-h) A synthetic dimension may be constructed in a tight-binding model by introducing long-term coupling between the elements of a chain. In the time-domain, this can be realized by modulating the system at multiple frequencies~@Huisman2016NatNanoFemtosecond (i-h) A spatially 1D chain of ring resonators can be combined with temporal modulation to form a synthetic 2D lattice~@Qiu2020NatPhysUltrafast. Figures adapted from @yuan2016photonic, @yuan2018synthetic and @yuan2021tutorial.
  ]
) <fig:syntheticDimensions>

Similarly to electrons in a simple one-dimensional lattice, photons in e.g. a periodically modulated ring resonator may be described by a tight-binding Hamiltonian:

$
  H_1 = g sum_m (a_(m+1)^dagger a_m e^(i phi) + a_m^dagger a_(m+1) e^(-i phi))
$<eq:HTB1>

where $a_m^dagger$ and $a_m$ are the photon creation and annihilation operators for the $m^"th"$ mode on the lattice, $g = kappa Omega \/ (2 pi)$ is the hopping amplitude, $kappa$ is the modulation strength, $Omega$ is the modulation frequency and $phi$ is the modulation phase~@yuan2021tutorial. In fact, just as electrons hop between sites of a lattice, a dynamical modulation can make photons hop between different modes of the resonator, as long as the modulation frequency is similar to the difference $Omega_R = 2 pi v_g \/ L$ between the modes of the structure, where $v_g$ and $L$ are the group velocity of the waveguide constituting the resonator and $L$ is its length. The simplest instance of such a lattice may be realized with a single ring resonator combined with a periodic modulator, shown schematically in @fig:syntheticDimensions.

Importantly, such a ladder does not need to be unidimensional: additional dimensions may be constructed from any degree of freedom by simply introducing additional coupling terms between a lattice of resonators, or, in a synthetic frequency dimension, between modes~@yuan2016photonic, which means that a linear lattice can now be equivalently described as a folded one to highlight its higher dimensionality, as illustrated in @fig:syntheticDimensions\(f-h). With time-modulation, this can be done by considering two periodic modulations of different frequencies e.g. $Omega_1 = Omega_R$ and $Omega_N = N Omega_R$, thus introducing coupling between $N^"th"$-neighbouring modes in the lattice so that the Hamiltonian above can be generalized to:

$
  H_N = g sum_m (a_(m+1)^dagger a_m e^(i phi) + "h.c.") + g_N sum_m (a_(m+N)^dagger a_m e^(i phi_N) + "h.c.")
$<eq:HTBN>

where $g_N = kappa_N Omega_R \/ (2 pi)$. Here, the second term accounts for the coupling between modes separated by a frequency gap $N Omega_R$, and it is mathematically equivalent to the addition of a second dimension. Time-modulation can also be combined with other degrees of freedom, such as orbital angular momentum~@dutt2020single or spatial lattices~@yuan2016photonic to implement a range of photonic effects, from non-trivial Chern numbers to effective gauge fields and spin-momentum locking. Implementations of synthetic frequency dimensions have been realized in RF with varactors~@peterson2019strong and superconducting resonators~@hung2021quantum, and in the near-infrared with fiber and on-chip electro-optic modulators~@dutt2018experimental @zhang2019electronically, as well as all-optically via four-wave mixing, with frequency spacings generally ranging from MHz to THz~@yuan2021tutorial. A recent proposal makes use of a single ring-resonator coupled to an array of optomechanical pumps and a single electro-optic modulator to realize an on-chip 2D topological insulator with two synthetic dimensions~@ni2021topological.

== Non-Hermiticity and disorder <non-hermiticity-and-disorder>

Another promising direction for new opportunities in wave manipulation is the interplay between temporal structure and Hermiticity. Gain in electromagnetism has conventionally been associated with the use of active media, providing wave amplification in the form of a negative dissipation. However, as discussed above, time-modulation offers an alternative route towards gain. Nevertheless, a complete analogy between non-Hermitian gain/loss and parametric processes cannot be drawn: in fact, it is evident from our previous discussion that a mere time-modulation cannot provide loss, as a consequence of momentum conservation, whereas an imaginary component in the response parameters of a medium can be used to provide either gain or dissipation depending on its sign.

// [figvision-cn] imgs/figureNonHermitianAndDisordered-01.png
// 子图 (a) 为系统结构示意图。左侧是一个标有“Port 1”的绿
// 色矩形，右侧是一个标有“Port 2”的绿色矩形。中间有两个圆
// 形节点，左边是粉色圆圈，内部标记为 $\omega_1$；右边是
// 浅蓝色圆圈，内部标记为 $\omega_2$。从 Port 1 指向 $\
// omega_1$ 的箭头上方标记为 $\gamma_1$；从 $\omega_2$ 指
// 向 Port 2 的箭头上方标记为 $\gamma_2$。$\omega_1$ 和 $
// \omega_2$ 之间有一条红色的弯曲双向箭头连接。在示意图下
// 方有一行红色公式：$K(t) = k_0 + \Delta k' \cos(\Omega
// t) + j \Delta k^* \sin(\Omega t)$。 子图 (b) 至 (e) 均
// 为二维柱状分布图，共享相同的坐标轴定义和图例。横坐标轴
// 标记为 $\omega$，刻度位置从左到右依次标记为 $\omega_1
// - \Omega$、$\omega_1$ 和 $\omega_1 + \Omega$。纵坐标轴
// 标记为 $|a|$，无具体数值刻度。图中包含一根从原点出发指
// 向右上方的黑色实线箭头，末端标记为 $\Delta k'$。每个子
// 图中都有若干垂直虚线将横轴区域分隔。底部图例显示：浅橙
// 色方块代表 $|a_1|$，浅蓝色方块代表 $|a_2|$。 子图 (b)
// 中，在 $\omega_1 - \Omega$ 处有一个矮的浅橙色柱和一个
// 稍高的浅蓝色柱；在 $\omega_1$ 处有一个较高的浅橙色柱和
// 一个较矮的浅蓝色柱；在 $\omega_1 + \Omega$ 处有一个矮
// 的浅橙色柱和一个较矮的浅蓝色柱。 子图 (c) 中，在 $\
// omega_1 - \Omega$ 处有一个矮的浅橙色柱和一个极矮的浅蓝
// 色柱；在 $\omega_1$ 处有一个较高的浅橙色柱和一个极矮的
// 浅蓝色柱；在 $\omega_1 + \Omega$ 处有一个极矮的浅橙色
// 柱和一个极高的浅蓝色柱（高度远超其他柱子）。 子图 (d)
// 中，在 $\omega_1 - \Omega$ 处有一个矮的浅橙色柱和一个
// 较矮的浅蓝色柱；在 $\omega_1$ 处有一个较高的浅橙色柱和
// 一个极矮的浅蓝色柱；在 $\omega_1 + \Omega$ 处有一个较
// 矮的浅橙色柱和一个极高的浅蓝色柱。 子图 (e) 中，在 $\
// omega_1 - \Omega$ 处有一个矮的浅橙色柱和一个极矮的浅蓝
// 色柱；在 $\omega_1$ 处有一个较高的浅橙色柱和一个极矮的
// 浅蓝色柱；在 $\omega_1 + \Omega$ 处有一个极矮的浅橙色
// 柱和一个极高的浅蓝色柱。 子图 (f) 为脉冲时序示意图。横
// 坐标轴标记为 $t$，刻度点标记为 $t_1, t_2, t_{j-1}, t_j
// $。纵坐标轴标记为 $\Omega^2(t)$，刻度点标记为 $0, \
// Omega_b^2$。图中展示了一个阶梯状的信号波形：在 $t=0$
// 到 $t_1$ 期间，信号值为 $\Omega_b^2$，并在 $t_1$ 时刻
// 叠加一个向上的尖峰脉冲，标记为 $v_1$；在 $t_1$ 到 $t_2
// $ 期间，信号值降为 $0$，并在 $t_2$ 时刻叠加一个向下的
// 尖峰脉冲，标记为 $v_2$；在 $t_2$ 到 $t_{j-1}$ 期间，信
// 号值保持为 $0$（由虚线表示）；在 $t_{j-1}$ 到 $t_j$ 期
// 间，信号值回升至 $\Omega_b^2$，形成一个矩形块，该块被
// 标记为“block $j$”，其起始边标记为 $v_{j-1}$，结束边标
// 记为 $v_j$。 子图 (g) 为线性拟合散点图及插图。主图横坐
// 标轴标记为 $N$，范围从 $0$ 到 $2$，单位标注为 $\times
// 10^4$。纵坐标轴标记为 $\langle \ln(U_N) \rangle$，范围
// 从 $0$ 到 $18$。图中绘制了两条几乎重合的直线，一条为黑
// 色细线，另一条为红色粗线，均从接近原点处向右上方延伸。
// 红色粗线旁标记有红色文字 $N\langle \beta \rangle$。在
// 图的左侧，对应横坐标较小的位置，有一条垂直虚线，旁边标
// 记为 $N_c$。右下角包含一个插图（Inset），插图横坐标轴
// 标记为 $N$，范围从 $0$ 到 $200$；纵坐标轴标记为 $\
// langle U_N \rangle$，范围从 $1.1$ 到 $1.4$。插图内同样
// 包含两条从左下角向右上角延伸的曲线，下方的一条标记为 $
// 2N\langle \beta \rangle$。
#figure(placement: top, [#image("imgs/figureNonHermitianAndDisordered-01.png", width: 100%)

  ],
  caption: [
    \(a) Two resonators coupled via a combination of constant ($k_0$), time-dependent Hermitian ($Delta k'$) and time-dependent non-Hermitian ($Delta k''$) coupling terms. (b-e) Wave amplitude under excitation via Port 1 in the two resonators (orange and blue) for two arbitrary values of $Delta k'$ at the excitation frequency ($omega_1$) and the two sidebands for (b) $k_0 eq.not 0$ and $Delta k'' = 0$ (energy stored in both sidebands and both resonators); (c) $Delta k'' = 0$ and $k_0 = 0$ (energy channeled to sideband frequencies is all in the second resonator while the first only hosts the input frequency); (d) $Delta k' = Delta k''$ and $k_0 eq.not 0$ (energy gained is nonreciprocally channeled into the upper sideband and it is distributed over both resonators); (e) $Delta k' = Delta k''$ and $k_0 = 0$ (energy gained is nonreciprocally channeled only into the upper sideband, and uniquely in the second resonator).~@koutserimpas2018nonreciprocal (f) A random sequence of temporal $delta$-kicks results in (g) universal statistics observed by the energy in the system $U$. The energy at the N-th kick $U_N$ is plotted against the step number $N$~@carminati2021universal. Figures adapted from @koutserimpas2018nonreciprocal and @carminati2021universal.
  ]
) <fig:nonHermitianAndDisordered>

This distinction between parametric and non-Hermitian gain makes it natural to ask what more can be achieved by modulating in time the non-Hermitian component of the material response. As discussed in @sec:switching, the switching of dissipation not only impacts the amplitude of the wave, but also its phase, and can also generate backward waves. In fact, as recently shown, non-Hermitian time-modulation can be used for nonreciprocal mode-steering in frequency space~@koutserimpas2018nonreciprocal. Consider the setup shown in @fig:nonHermitianAndDisordered two resonators with mode-lifetimes $gamma_1$, $gamma_2$ are coupled via a time-dependent coupling constant $k_0 + Delta k' cos ( Omega t ) + j Delta k'' sin ( Omega t )$, resulting in a non-Hermitian time-Floquet Hamiltonian. Normally a periodic modulation of the system enables similar upconversion and downconversion between modes of a structure. However, it was shown that the inclusion of a non-Hermitian component in the time-modulation of the coupling constant between the resonators can hijack such mode coupling, rerouting all of the energy into one of the two resonators, thus producing nonreciprocal gain @koutserimpas2018nonreciprocal.

The link between time-modulation and parity-time (PT) symmetric Hamiltonians has also been discussed in some depth for the parametric resonance case, where the frequency of the modulation doubles that of the incoming light~@koutserimpas2018parametric. Elegantly, PT symmetry breaking in these parametric systems can be related to the stability conditions of the Mathieu equation governing a harmonically modulated structure~@arscott1968theory. Such time-modulation-induced PT symmetric physics additionally enables not only lasing instabilities, but also bidirectional invisibility due to anisotropic transmission resonance, when two PT-symmetric time-Floquet slabs are combined together such that their respective parametric oscillations cancel out exactly. New perspectives relating exceptional point physics and parametric modulation may be also found in Refs.~@wang2018photonic @bossart2021non @koutserimpas2020electromagnetic, whereas Ref.~@li2019topological investigates topological phases in non-Hermitian Floquet photonic systems.

Another interesting direction for non-Hermitian time-modulated systems relates to the temporal analogue of the causality relations of conventional passive media~@hayran2021spectral. As a well-known consequence of causality, imposed by demanding that the response function of a system is only non-zero at times following an input signal, the real and imaginary parts of the response of a system must relate to each other through the Kramers-Kronig relations. However, the spectral analogue of these relations can also be constructed: if one would like the spectral response of a system to be uniquely non-zero for frequencies higher or lower than the input frequency, such that only upconversion or downconversion occurs, then there exist temporal Kramers-Kronig relations which can provide a recipe for how the Hermitian and the non-Hermitian components of a time-modulation must be related, in order for such asymmetric frequency conversion to occur. Related concepts have also been exploited for event-cloaking, broadband absorption and synthetic frequency dimensions~@hayran2021spectral.

The introduction of temporal disorder constitutes yet another avenue where the inequivalence between space and time may bear new perspectives in long-standing problems such as Anderson localization~@apffel2021time @carminati2021universal @sharabi2021disordered  @pendry1982evolution. Interestingly, however, the conventional localization observed in spatially disordered media does not occur in a time-modulated system. Instead, in a similar fashion as the occurrence of edge states, the onset of the temporal analogue of Anderson localization manifests itself as an exponential growth in the energy of the waves. Such wave dynamics has been investigated both analytically~@carminati2021universal, demonstrating the universal statistics occurring in $delta$-kicked temporal media, and numerically~@sharabi2021disordered, as a disordered perturbation in a PTC. Experiments on wave dynamics in temporally disordered systems have also recently been performed with water waves @apffel2021time.

In the following section, we move on to briefly discuss temporally structured surfaces, whereby the interplay of spatial and temporal discontinuities can enable not only several realistic platforms for implementations with metasurfaces, but also completely new regimes of wave scattering.

== Time-modulated surfaces <time-modulated-surfaces>

// [figvision-cn] imgs/figureSurfaces-01.png
// 子图(a)为三维示意图，展示色散关系曲面。垂直轴标记为ω（
// 角频率），水平面由两个正交轴k_x和k_z构成。图中包含两个
// 锥面：一个红色双锥面代表体波（bulk waves）的等频面，另
// 一个蓝色单锥面与红色锥面在原点相切，代表表面波（
// surface wave）。在k_z=0平面内，用黄色曲线标出红色锥面
// 与蓝色锥面的交线，该交线呈椭圆形，表示表面波的色散轨迹。
// 子图(b)为实验装置实物照片，展示一块矩形超表面器件。器
// 件主体为深灰色基板，其上平行排列着大量银白色细长条状结
// 构，标注为“Transparent, tunable metasurface phase
// shifters”（透明可调超表面移相器）。基板四角通过四个白
// 色尼龙柱支撑，标注为“Nylon spacer”，使器件悬空。右侧安
// 装有两个金属SMA射频接口，连接外部电路，并标注有V_bias(
// t)，表示施加时变偏压。左侧箭头指示相邻移相器间距为9.56
// mm，括号内注明对应波长比例(0.3λ)。 子图(c)为曲线图，横
// 轴为Frequency (GHz)，范围从9.994 GHz到10.006 GHz；纵轴
// 为|E_out / E_in|^2 (dB)，范围从-50 dB到0 dB。图中绘制
// 一条黑色实线，呈现周期性尖峰结构，共约15个主峰。每个主
// 峰顶部标注其中心频率值（单位GHz），从左至右依次为：
// -19.0, -18.1, -17.6, -17.3, -5.3, -18.0, -27.3（注：此
// 处数值应为相对于某参考点的偏移量或笔误，实际应理解为频
// 率位置如9.995+Δf等形式，但按图中标注原文记录）。峰值高
// 度随频率变化，最高峰位于约10.000 GHz处，增益接近0 dB，
// 其余峰逐渐衰减。整体趋势显示系统在特定频率点出现强透射
// 共振。 子图(d)为二维色散图，横轴为波矢k，纵轴为角频率ω。
// 图中有一条虚线对角线标注为“light line”，代表自由空间光
// 锥边界。下方区域填充浅棕色，标注为“evanescent waves”（
// 倏逝波区）；上方区域无填充，标注为“propagating waves”
// （传播波区）。一条黑色实线曲线从原点出发，沿light line
// 下方弯曲延伸，标注为“surface mode”（表面模），表示表面
// 波色散关系。图中标注三个关键点：在k_i处对应频率ω_i，在
// k_sw处对应频率ω_sw，两点间以红色水平箭头连接，表示动量
// 匹配过程；另有一条蓝色竖直箭头从ω_i指向ω_sw，表示能量
// 转移方向。 子图(e)为一维函数图，横轴为x，纵轴为σ(gx)。
// 图中绘制一条红色正弦波形曲线，标注方程g = k_sw - k_i，
// 表示空间调制周期由表面波与入射波波矢差决定。曲线振幅恒
// 定，相位连续，反映电导率σ随空间位置gx呈周期性振荡。 子
// 图(f)为一维函数图，横轴为t，纵轴为σ(Ωt)。图中绘制一条
// 蓝色正弦波形曲线，标注方程Ω = ω_i - ω_sw，表示时间调制
// 频率由入射波与表面波角频率差决定。曲线同样振幅恒定、相
// 位连续，反映电导率σ随时间Ωt呈周期性振荡。 子图(g)为物
// 理机制示意图，展示电磁场与超表面相互作用。底部为两层介
// 质界面，下层介质ε_1（浅绿色），上层介质ε_2（白色）。界
// 面处有一绿色弧线代表超表面，标注σ表示其动态电导率。左
// 侧入射电磁波用锯齿形箭头表示，电场分量E_x和磁场分量H_y
// 分别用带箭头圆圈和双向箭头标示。右侧反射/透射波也用类
// 似符号表示。特别地，在超表面附近标注E_z（垂直电场分量），
// 并用向下箭头指示其方向，表明存在垂直于界面的电场耦合。
// 整个布局体现非互易性或参量放大效应中的场分布特征。 子
// 图(h)为双Y轴曲线图，横轴为|T|^2（透射系数平方），范围0
// 到1；左纵轴为无量纲参数α，范围0到1.7；右纵轴未明确标注，
// 但根据上下文推测可能为另一归一化变量。图中两条曲线：橙
// 色实线标注α=0.15，蓝色实线标注α=0。两条曲线均从左侧低
// 值开始，随|T|^2增加而缓慢上升，在|T|^2≈0.9后急剧上升至
// 平台区。图例框内说明：“— Analytics”（解析解）、“•
// Numerics”（数值模拟），并在曲线上叠加若干黑点，表示数
// 值计算结果与解析曲线吻合良好。整体趋势显示当α>0时系统
// 稳定性增强或阈值行为改变。 子图(i)为二维仿真快照图，标
// 题为“incoming pulse”。背景为深蓝色渐变，中央有一束倾斜
// 入射的脉冲波包，用亮黄色至红色高亮显示强度分布。波包传
// 播方向由多个白色空心箭头指示，大致沿45°角向右下传播。
// 左上角灰色扇形区域标注θ ≈ 44°，表示入射角。波包前方及
// 周围可见干涉条纹或散射波纹，暗示与超表面发生非线性或衍
// 射相互作用。右下角有一个黑色实心三角形指针，指向波包尾
// 部，可能用于标记观测时刻或参考点。整幅图传达的是瞬态电
// 磁脉冲在倾斜入射条件下与超表面相互作用的时空演化图像。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/figureSurfaces-01.png", width: 100%)

  ],
  caption: [
    \(a) Light scattered from a flat, time-varying metasurface can access a locus of states which form a hyperbola in phase space, as opposed to an ellipse in spatial metasurfaces. (b) Implementation of a time-modulated metasurface at GHz frequencies. (c) A 1 MHz modulation performs efficient frequency conversion through time-modulation @wu2019serrodyne. (d) Illustration of surface-wave excitation via Wood anomalies using a spatial (e) and temporal (f) modulation of a surface (g). (h) Example of Wood anomaly observed in transmission, the surface-wave excitation is explicitly shown in (i) from a Finite-Element-Time-Domain simulation @galiffi2020wood. Figures adapted from @wu2019serrodyne @galiffi2020wood.
  ]
) <fig:wood>

Amidst the rise of 2D materials, spatially structured surfaces, known as metasurfaces, have recently attracted enormous interest as the ultrathin counterpart of metamaterials. Periodically structured surfaces, or gratings, have however occupied a central role in photonics since its early days. In its interaction with waves in the far-field, a 1D-grating can couple waves whose dispersion lives on the edge of the light cone by trading in-plane ($k_x$) and out-of-plane ($k_z$) momentum via both its in-plane structure and its transverse boundary, such that they must add in quadrature to the total momentum $k_0 = epsilon omega \/ c_0$ of the impinging waves. Interestingly, time-modulated surfaces enable sharply different wave dynamics due the fact that the light cone treats time on a different footing that any of the spatial dimensions: if we consider light impinging on a flat, time-modulated surface, its in-plane momentum $k_x$ will now be conserved, whereas $k_z$ and, importantly the wave frequency $omega$, are now allowed to change. Taking a vertical cut of the light cone for a fixed value of $k_x$, we see that the two quantities being traded by the surface, $k_z$ and $omega$ must not add, but rather subtract in quadrature. As a result, the locus of points described by the available modes in the far-field is no longer elliptical, but hyperbolic. One consequence is that an increase in frequency caused by a temporal modulation corresponds to an increase in out-of-plane momentum and vice versa, the opposite of what happens between momentum components as they interact with a spatial grating.

One direction for time-modulated surfaces is the opportunity to couple radiation to surface waves in the absence of any surface structure. Since their dispersion curve lies outside of the light cone, surface waves are typically excited by breaking translational symmetry along the surface either via a localized near-field probe like a SNOM tip~@fischer1989observation, or periodically using a grating which induces a Wood Anomaly~@wood1902xlii. However, the argument above can be exploited to envision surface-wave excitation via a temporal grating~@galiffi2020wood, as depicted in @fig:wood\(d-i). This approach brings the advantage of complete reconfigurability and use of higher-quality pristine materials, in particular in highly tunable 2D materials such as graphene and other Van der Waals polaritonic materials such as hexagonal boron nitride and MoO3, thereby circumventing the very need for surface fabrication or near-field excitation techniques.

Another key technological application of time-modulated surfaces is that of frequency conversion~@cumming1957serrodyne. The advent of metasurfaces across the electromagnetic spectrum has led to a surge of opportunities for advancing this known field of research both theoretically~@wang2020theory @ramaccia2019phase @scarborough2021efficient @wu2020space @wang2021space @ramaccia2020electromagnetic @sedeh2020time @hadad2015space @romero2018parametric and experimentally~@wu2019serrodyne @zhang2021wireless @zhang2018space  @shaltout2019spatiotemporal @Shaltout2019ScienceSpatiotemporal~@wang2020nonreciprocity. Recent implementations of frequency translation with metasurfaces have been recently carried out in the microwave regime~@wu2019serrodyne, and implementations with experimentally more practical discretized arrays of time-and spacetime-modulated reactive elements are in steady development~@wu2020space @zhang2018space. Several more experimental implementations are discussed in @wu2020space @zhang2018space. Interestingly, the combination of bianisotropy and time-modulation has also been predicted to give rise to nonreciprocal response (see @sec:nonreciprocity)~. Specific scattering studies have also been dedicated to periodically modulated slabs~@martinez2016temporal, particularly in the context of parametric amplification @martinez2016temporal.

This recent surge of interest in time-modulated media has certainly highlighted the fundamental nature of the novel wave phenomena that time-modulation can unlock, and it is likely that a wealth of opportunities still lies unexplored for even the simplest spatially homogeneous systems. More opportunities involving surface structures have been explored in the context of space-time metasurfaces ( @sec:spacetime_metasurfaces). However, before discussing in detail the several new related concepts and implementations, it is instructive to extend the theoretical background presented so far to the case of space-time modulations, which introduce a wealth of additional phenomenology to the scattering processes discussed so far.

= Spatiotemporal metamaterials <sec:spacetime>

Spatiotemporal modulations generally imprint a travelling-wave-like perturbation, of the form $delta epsilon ( x , t ) = delta epsilon ( g x - Omega t )$ (and similarly for $mu$) onto the response parameters of a medium, where $g = 2 pi \/ L$ and $Omega = 2 pi \/ T$ are the spatial and temporal components of the reciprocal lattice vector associated with the spatial and temporal periods $L$ and $T$ of the modulation, which form a spatiotemporal lattice vector $p = ( T , L )$, as depicted in @fig:basic_concepts\(a-b)~@deck-legerUniformvelocity2019. The idea of travelling-wave modulation has been in use since the early days of travelling-wave amplifiers, whereby electron beams are used to pump energy into co-propagating microwave beams~@pierce1947theory, and have undergone a number of investigations in the 60's~@cullenTravellingWave1958 @olinerWave1961 @Cassedy1963 @cassedyDispersion1967 @fante1972optical, and later in the early 2000's~@winnInterband1999 @biancalanaDynamics2007. Recently, the interest in these systems has revamped, with intense research efforts in the modelling and realization of space-time modulated nonreciprocal systems (see @sec:nonreciprocity)~@sounas2017non @taravatiNonreciprocal2017 @sivan2016coupled @yuComplete2009 @liraElectrically2012 @calozSpacetime2020 @calozSpacetime2020a. In space-time media, neither frequency nor momentum are individually conserved, but rather a spatiotemporal Bloch vector $( omega , k )$ forms a good quantum number, and the fields can generally be expressed as a superposition of a discrete set of Floquet-Bloch modes characterized by frequency-momentum vectors $( k + n g , omega + n Omega )$, where $n in NN$ as shown in @fig:basic_concepts\(c-f), so that an eigenmode will have the form:

$
  psi ( x , t ) = e^(j ( omega t - k x)) sum_n a_n e^(j n ( Omega t - g x ))
$<eq:spacetimeFourier>

and an eigenvalue problem may be set in terms of either $omega ( k )$ or $k ( omega )$. Importantly, these new reciprocal lattice vectors $( g , Omega )$ are not generally horizontal (c), but may form an arbitrary angle in $omega - k$ space, which may be smaller than the slope $c_0$ of the bands for the background medium (subluminal, panel d) or larger (superluminal, panel e), reducing to a pure temporal modulation in the limit $v_m = Omega \/ g → ∞$ as the entire medium is then effectively modulated instantaneously (panel f). Interestingly, a peculiar regime of modulation velocities

$
  frac(c_0, sqrt(1 + max(delta epsilon)) sqrt(1 + max(delta mu))) < v_m < frac(c_0, sqrt(1 - max(delta epsilon)) sqrt(1 - max(delta mu)))
$<eq:luminalRegime>

exists, where the Fourier expansion in @eq:spacetimeFourier does not converge, as first shown by Cassedy in Ref.~@Cassedy1963. We discuss this exotic #emph[luminal] regime~@galiffiBroadband2019 in detail in @sec:luminal. In the next section we discuss the role of space-time modulation for the engineering of nonreciprocal scatterers, which first motivated the interest in this field.

// [figvision-cn] imgs/basicConcepts-01.png
// 该图由七个子图（a至g）组成，展示了光子晶体中的色散关系、
// 能带结构及参量下转换过程。 子图 (a) 为示意图。 类型：
// 二维空间结构示意图。 坐标轴：横轴标记为 x，纵轴标记为
// ct（光速乘以时间）。 内容：背景为白色，包含一组平行的
// 浅灰色斜条纹，从左上向右下倾斜。图中有一个蓝色的双向水
// 平箭头，标记为 p，表示动量或周期。右侧有一条短的黑色斜
// 线段，旁边标注有 v_m，代表移动速度。在右上区域标注有文
// 字 n_i n_j，可能指代折射率或介电常数分量。 子图 (b) 为
// 示意图。 类型：二维时空晶格结构示意图。 坐标轴：横轴标
// 记为 x，纵轴标记为 ct。 内容：背景为白色，包含两组正交
// 的浅灰色网格状条纹，形成菱形图案。图中有两个蓝色的双向
// 箭头，分别标记为 p_A 和 p_B，指向不同的方向。下方有两
// 个黑色的折线符号，分别标记为 v_m1 和 v_m2，表示两种不
// 同的调制速度。上方标注有文字 n_i n_j。 子图 (c) 为曲线
// 图（色散图）。 类型：ω-k 色散关系图。 坐标轴：横轴为波
// 数 k，纵轴为角频率 ω。原点处有红色圆点。 曲线与标注：
// 图中有多条穿过原点的直线。两条主要的黑色实线呈“X”形交
// 叉，代表光锥。另有两条较细的黑色实线与主光锥平行但偏移。
// 图中有一个红色的水平双向箭头，标记为 g，位于横轴上，表
// 示倒格矢。顶部标注有数学表达式 Ω/g = 0。在交叉点处有红
// 色的“X”符号标记。 子图 (d) 为曲线图（色散图）。 类型：
// ω-k 色散关系图。 坐标轴：横轴为波数 k，纵轴为角频率 ω。
// 曲线与标注：结构与子图(c)类似，包含黑色实线构成的光锥
// 和偏移的能带。一个红色的粗箭头沿其中一条偏移的能带指向
// 右上方，表示群速度方向。顶部标注有数学表达式 Ω/g < c。
// 同样标有红色的水平双向箭头 g 和红色的“X”符号。 子图 (e
// ) 为曲线图（色散图）。 类型：ω-k 色散关系图。 坐标轴：
// 横轴为波数 k，纵轴为角频率 ω。 曲线与标注：图中的能带
// 发生了明显的折叠和打开带隙的现象。蓝色线条构成了新的能
// 带结构，部分区域出现虚线。顶部标注有数学表达式 Ω/g > c。
// 纵轴上有一个蓝色双向箭头标记为 Ω。横轴上标有 g。 子图
// (f) 为曲线图（色散图）。 类型：ω-k 色散关系图。 坐标轴：
// 横轴为波数 k，纵轴为角频率 ω。 曲线与标注：展示了极限
// 情况下的能带结构。蓝色实线构成对称的“V”字形和倒“V”字形。
// 纵轴上有一个蓝色双向箭头标记为 Ω，并标注有文字 PA（可
// 能指 Parametric Amplification，参量放大）。横轴上标有
// g。顶部标注有数学表达式 Ω/g = ∞。 子图 (g) 为组合示意
// 图与曲线图。 类型：左侧为物理过程示意图，右侧为对应的
// 能量-动量守恒图。 左侧示意图： 物体：一个黄色的长方体，
// 代表非线性介质或波导。 连接与布局：三条波浪线代表不同
// 频率的光波。下方有一条红色波浪线，标记为 ω_1, k_1；中
// 间有一条黑色波浪线，标记为 ω_m, k_m，并在长方体内有黑
// 色箭头指示传播方向；上方有一条蓝色波浪线，标记为 ω_2,
// k_2。 右侧曲线图： 坐标轴：横轴为波数 k，纵轴为角频率
// ω。 曲线：两条黑色虚线构成一个向上传播的光锥（阴影区域）。
// 两条黑色实线从光锥两侧向外延伸，代表信号光和闲频光的色
// 散曲线。 标注与趋势：图中用红点和蓝点标记了特定的状态
// 点。一条垂直的双向箭头标记为 ω，表示泵浦光频率。另一条
// 水平的双向箭头也标记为 ω，表示动量失配或带宽。整体展示
// 了参量下转换过程中，一个高频光子（泵浦光，未直接画出但
// 隐含在能量差中）分裂为两个低频光子（信号光和闲频光），
// 且满足能量守恒（ω_pump = ω_signal + ω_idler）和动量守
// 恒（k_pump = k_signal + k_idler）的过程。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/basicConcepts-01.png", width: 100%)

  ],
  caption: [
    \(a) Spacetime diagram of a space-time crystal with alternating refractive indices $n_i$ and $n_j$, spatiotemporal lattice vector $p$ and velocity $v_m$. (b) Double-period space-time crystal, characterized by two different lattice vectors $p_A$ and $p_B$, and two different velocities $v_(m 1)$ and $v_(m 2)$@ZoeAdvancedPhotonics. (c) The band structure for a spatial crystal with $epsilon tilde cos ( g z - Omega t )$ becomes asymmetric as (d) a finite temporal component $Omega$, and therefore a finite modulation velocity $v_m = Omega \/ g$, is introduced. This is caused by reciprocal lattice vectors (dashed arrows) acquiring a non-zero frequency component. The angle formed by the reciprocal lattice vectors with the slope of the bands determines a subluminal (c-d) and a superluminal (e-f) regime @galiffiBroadband2019.  (g) Nonreciprocal mode-coupling in a space-time modulated waveguide: the modulation can couple forward modes between each other as their frequencies and momenta are matched by the space-time modulation, while two backward waves are not coupled, so that an impinging backward wave is effectively unchanged @sounas2017non. Figures adapted from @ZoeAdvancedPhotonics, @galiffiBroadband2019 and @sounas2017non.
  ]
) <fig:basic_concepts>

== Compact nonreciprocal devices without magnetic bias <sec:nonreciprocity>

The rise of space-time media was largely fuelled by the quest for magnet-free nonreciprocity that has dominated the metamaterials scene of the past decade. Nonreciprocity is the violation of the Lorentz reciprocity theorem, by which swapping source and receiver leaves the scattering properties of a medium unaltered~@sounas2017non. Nonreciprocal components such as isolators and circulators are crucial for duplex communications, enabling simultaneous transmission and reception at the same frequency on the same channel without parasitic reflections, as well as other applications such as laser protection from back-scattering and field enhancement. The common approach to breaking this symmetry of space is the use of gyromagnetic media, where the presence of a magnetic field breaks time-reversal symmetry. One common nonreciprocal effect encountered in basic electromagnetism is Faraday rotation, whereby the rotation of the polarization of a wave passing through a gyromagnetic medium depends on the direction from which the waves are impinging on the medium. One key drawback of gyromagnetic media, however, is their requirement of strong magnetic fields and large footprint for such effects to be appreciable, leading to bulky components, incompatible with CMOS technology. Time-modulation offers the opportunity of explicitly breaking time-reversal symmetry, thereby violating reciprocity without the use of strong magnetic fields~@Christofi2018OptLettGiant.

// [figvision-cn] imgs/nonreciprocity-01.png
// 图(a)为示意图，展示一个具有旋转对称性的环形结构。该结
// 构由两个同心圆环组成：内环标注为“|−1⟩”，外环标注为“|+1
// ⟩”。内环上绘有逆时针方向的红色箭头，外环上绘有顺时针方
// 向的蓝色箭头，表示不同角动量态的旋转方向。整个结构置于
// 黄色背景板上，左上角标有介电常数符号εg。图中建立了一个
// 三维直角坐标系（x, y, z），原点位于环中心，z轴垂直向上。
// 下方公式为Δε = Δε_m cos(ω_m t − L_m φ)，描述介电常数的
// 时空调制形式。 图(b)为能级耦合示意图，包含四个圆形节点
// 和连接它们的虚线。左侧绿色圆圈标注ω₁(t)，右侧上方红色
// 圆圈标注ω₃(t)，右侧下方绿色圆圈标注ω₂(t)。中央区域有两
// 个虚线框：上方框内含一个蓝色小圆和一个红色小圆，分别标
// 注ω_β + ω_m 和 ω_β；下方框内含一个蓝色小圆和一个红色小
// 圆，分别标注ω_α 和 ω_α − ω_m。从ω₁(t)到上方红圈、再到ω
// ₃(t)的路径旁标注|β⟩；从ω₁(t)到下方蓝圈、再到ω₂(t)的路
// 径旁标注|α⟩。所有连接线均为双向虚线箭头，表示量子态之
// 间的相干耦合。 图(c)为三模耦合系统示意图，三个浅绿色圆
// 形节点呈三角形排列，分别标注ω₁(t)、ω₂(t)、ω₃(t)。每两
// 个节点之间用带箭头的弧线连接，共六条弧线（双向各三），
// 每条弧线上均标注κ̇，表示时间依赖的耦合强度。中心位置有
// 一个红色圆环，内部标注“|−⟩”并配有逆时针红色箭头，旁边
// 另有一个蓝色圆环标注“|+⟩”并配有顺时针蓝色箭头，代表两
// 个相反旋转模式的叠加态。 图(d)为S参数曲线图与器件结构
// 示意图组合。横坐标为频率（单位c/a），范围0.6686至
// 0.6688；纵坐标为S-parameters（单位dB），范围−12至0。黑
// 色实线表示S₂₁和S₁₂，在约0.6687处出现深谷（最小值约−13
// dB）。图中嵌入两个器件结构简图：左侧为drop waveguide结
// 构，含一个半径R的环形谐振腔，两侧直波导间距g，宽度w，
// 端口编号1–4；右侧为channel waveguide结构，同样含环形腔，
// 但无侧向波导，仅保留端口1和2。两个结构均以灰色矩形表示
// 波导，红色椭圆表示谐振腔模式分布。 图(e)为S参数曲线图
// 与场分布快照组合。横坐标同图(d)，纵坐标同图(d)。蓝色实
// 线为S₂₁，红色实线为S₁₂，两者在0.6687附近交叉并各自形成
// 凹陷。图中插入两个深蓝色背景的场分布图：左侧对应S₂₁凹
// 陷区，显示环形腔内螺旋状场分布（红黄蓝三色渐变），下方
// 白色箭头指向上传播方向，标注“1→2”；右侧对应S₁₂凹陷区，
// 场分布镜像对称，上方白色箭头指向下传播方向，标注“2→1”。
// 中间以黄色虚线标记共振频率点。 图(f)为归一化S参数曲线
// 图与四端口器件示意图组合。横坐标未明确标注，但根据上下
// 文应为频率或无量纲变量；纵坐标为Normalized
// S-parameters，范围0.0至1.0。黑色实线为S₂₁，黑色实心圆
// 点为S₃₁。S₂₁曲线先升后降，峰值约0.9；S₃₁数据点呈单峰分
// 布，峰值略低于S₂₁。右上角嵌入四端口星形器件示意图：中
// 心为灰色圆盘，四个臂分别编号1、2、3、4，其中端口1和2为
// 输入/输出主通道，端口3和4为辅助端口，箭头指示信号流向。
// 图(g)为多通道S参数曲线图与四端口器件示意图组合。横坐标
// 同图(f)；纵坐标左轴为Normalized S-parameters（0.0–1.0），
// 右轴为0（可能用于对齐）。图中包含六条曲线：S₁₂（黑虚线）、
// S₂₁（黑实线）、S₃₁（蓝虚线）、S₁₃（蓝实线）、S₂₃（红虚
// 线）、S₃₂（红实线）。S₂₁和S₁₂在约0.6687处达到峰值（≈
// 1.0），S₃₁和S₁₃在相同频率处出现次峰（≈0.4），S₂₃和S₃₂
// 则呈现较宽的低幅响应。右上角嵌入四端口器件示意图，端口
// 1、2、3、4以彩色箭头标识：端口1为蓝色入射，端口2为红色
// 出射，端口3为蓝色反射，端口4为红色反射，体现非互易传输
// 特性。 图(h)为实验测量得到的多通道S参数曲线图与四端口
// 器件示意图组合。横坐标为Frequency（MHz），范围140至200；
// 纵坐标为Normalized S-parameters，范围0.0至1.0。图中包
// 含六条曲线：S₂₁（黑实线）、S₁₂（黑虚线）、S₁₃（蓝实线）、
// S₃₁（蓝虚线）、S₃₂（红实线）、S₂₃（红虚线）。所有曲线
// 在约165 MHz处出现主峰，S₂₁和S₁₂峰值接近1.0，S₁₃和S₃₁峰
// 值约0.5，S₃₂和S₂₃峰值约0.4。部分曲线在175–185 MHz区间
// 出现次级振荡。右上角嵌入四端口器件示意图，端口1、2、3、
// 4以彩色箭头标识：端口1为蓝色入射，端口2为红色出射，端
// 口3为蓝色反射，端口4为红色反射，与图(g)一致，表明实验
// 验证了理论设计的非互易行为。
#figure(placement: top, [#image("imgs/nonreciprocity-01.png", width: 100%)

  ],
  caption: [
    \(a) Angular momentum biasing: a directional modulation along a ring resonator splits the degeneracy between clockwise and anti-clockwise travelling states, (b) in analogy with the Zeeman splitting of electronic states in a magnetic field @sounas2013giant. (c) This can be realized by discretizing the elements of the ring, e.g. periodically modulating three strongly coupled resonators, with a phase of $120 deg$ between them @estep2014magnetic.  (d) Example of operation of a non-reciprocal ring resonator coupled to two waveguides: excitation from the bottom (top) of the channel waveguide (on the right of the ring) excites a counterclockwise (clockwise) mode, whose resonant frequency has been offset from the one of the clockwise (counterclockwise) mode, so that the direction of excitation determines the efficiency of the coupling to the resonator (e), and hence of the transmission to the output port of the channel waveguide @sounas2013giant.  (f-g) Theoretical and (h) experimental performance of an RF circulator made with angular-momentum biased resonators: panels (f) and (g) show the reciprocal response in the absence (f) and presence (g) of angular biasing, while panel (h) shows the performance of the experimental implementation of the circulator @estep2014magnetic.  Figures reproduced from @wang2020theory, @zhang2018space and @barati2020topological.
  ]
) <fig:nonreciprocity>

The basic idea of using ST modulation for optical isolation may be summarized in @fig:basic_concepts\(g): the modulation produces transitions between two optical states which differ in both momentum $k$ and frequency $omega$: as a result, if the system hosting the waves (e.g. a waveguide) supports multiple bands, to a pair of forward-propagating modes coupled by the ST modulation may not correspond a pair of backward-propagating ones. Therefore, while a forward incoming wave at frequency $omega_1$ may be completely converted into a new mode with frequency $omega_2$, a backward wave at $omega_1$ will not be converted as it will be mismatched in frequency and/or momentum. Hence, by introducing a narrowband filter at $omega_2$, the system allows propagation only in the backward direction, thus achieving optical isolation~@sounas2017non, @yuComplete2009, in a similar fashion to the way a diode conduces electricity unidirectionally~@wangOptical2013. An equivalent way of viewing this scattering asymmetry in an extended medium is the opening of an asymmetric band gap in the photonic dispersion of a material, allowing propagation along one direction only~@chamanara2017optical.

Ring-resonators constitute perhaps the most promising components for electromagnetic nonreciprocity. The idea of using ring resonators for nonreciprocity makes use of the concept of angular momentum biasing \[@fig:nonreciprocity\(a)\]: a circular, directional bias splits the degeneracy between clockwise and anticlockwise states, effectively mimicking the Zeeman splitting of atomic physics \[@fig:nonreciprocity\(b)\]. In practice, this can be achieved with e.g. three elements periodically modulated with a $120 deg$ phase difference between them \[@fig:nonreciprocity\(c)\]. Let us consider the two-port system formed by two linear waveguides coupled to the biased ring resonator shown in panel d. Thanks to the splitting between clockwise and anticlockwise states, if the channel waveguide (on the right of the ring in the panel) is excited at a frequency resonant with the anticlockwise mode from the bottom port, its power will be mainly rerouted by the ring resonator into the drop channel ( of the ring). On the contrary, a wave impinging from the top of the waveguide, which would normally couple to the clockwise state would now be off-resonance, thus coupling poorly to the mode of the resonator, and being largely transmitted to the bottom port of the channel waveguide~@sounas2013giant. This strategy can be used to realize electromagnetic circulators, as shown in @fig:nonreciprocity\(f-h). A circulator consists of three ports, and its purpose is to enable transmission from port 1 to port 2, port 2 to port 3 and port 3 to port 1, while impeding transmission in the opposite sense (i.e. $2 → 1$, $3 → 2$ and $1 → 3$). @fig:nonreciprocity\(f) shows the transmission from channel 1 to 2 and one to 3 in the absence of angular-momentum bias, which is perfectly symmetric. Once the bias is turned on, backward propagation is forbidden, as shown in simulations \[@fig:nonreciprocity\(g)\] and experimental data \[@fig:nonreciprocity\(h)\]~@estep2014magnetic. Other electromagnetic implementations have been realized with silicon waveguides~@liraElectrically2012, as well as microstrip transmission lines~@taravatiNonreciprocal2017, with modulation frequencies ranging from hundreds of MHz to tens of GHz.

Multiple extensive reviews on space-time modulation focusing on nonreciprocity have recently been published, so we refer the reader to them for further details, and move on to illustrate further opportunities for space-time media~@sounas2017non @caloz2018electromagnetic.

== Synthetic motion with spacetime media <synthetic-motion-with-spacetime-media>

The interaction of waves with moving bodies is at the origin of a myriad of physical phenomena, such as the Doppler effect, the Fresnel drag by which a moving medium drags light, or even the generation of hydroelectricity~@Fizeau @VanBladel @fresnel1818lettre.

Moreover, the electromagnetic response of a moving system is inherently nonreciprocal, as it is associated with a broken time-reversal symmetry~@Kong @fleurySound2014~@philbin2008fiber. In fact, flipping the arrow of time also requires flipping the velocity of all the moving components, leading thereby to a distinct optical platform. The nonreciprocity and the non-Hermitian nature of the electromagnetic response of moving matter can enable unidirectional light flows~@LanneberePRA2014, classical and quantum non-contact friction~@PendryFriction, @SilvFriction, parametric amplification~@Zeldovich, @SilvPRX2014 @LanneberePRA2014 @FaccioPRL2017, amongst others @Zeldovich @SilvPRX2014 @LanneberePRA2014 @FaccioPRL2017.

Unfortunately, it is impractical to take technological advantage of many of the features highlighted in the previous paragraph, because a realistic value for the velocity of a moving body is many orders of magnitude smaller than the speed of light. Interestingly, the actual physical motion of a macroscopic body may be imitated by a drift current in a solid state material with high-mobility @Sydoruk2010 @Morgado2017 @VanDuppen2016 @MorgadoACS2018. For example, it was recently experimentally verified that drifting electrons in graphene can lead to nonreciprocity at terahertz frequencies and to a Fresnel drag~@BasovNature2021 @WangNature2021. A different way to realize an effective moving response without any actual physical motion is through a travelling wave spacetime modulation~@olinerWave1961 @Cassedy1963 @cassedyDispersion1967 @deck-legerUniformvelocity2019 @huidobroFresnel2019  @mazor2019one. Such a solution is discussed next in detail.

// [figvision-cn] imgs/synthetic_motion-01.png
// 该图由六个子图组成，分为上下两排，展示了时空调制晶体的
// 物理模型及其等效描述和色散特性。 (a) 这是一个三维空间
// 示意图，展示了一个“时空调制晶体”。背景为浅蓝色网格状图
// 案，表示周期性结构。左下角有一个右手笛卡尔坐标系：x轴
// 水平向右，y轴垂直向上，z轴指向观察者（用圆圈加中心点表
// 示）。在晶体区域中央有一个半透明浅蓝色矩形框，内部写有
// 两行公式：“ε = ε(x - v_m t, y, z)” 和 “μ = μ(x - v_m t
// , y, z)”，表明介电常数和磁导率随组合变量 (x - v_m t)
// 变化，体现沿x方向以速度v_m传播的时空调制。无比例尺或数
// 值坐标。 (b) 这是一个二维平面示意图，标题为“等效移动双
// 各向异性晶体”。背景为浅绿色菱形格纹。左侧列有三个带帽
// 符号的参数：“ε̂(x', y', z')”、“μ̂(x', y', z')”、“ξ̂(x'
// , y', z')”，代表等效静止参考系中的材料参数。右侧是一个
// 粗大的黄色右向箭头，标注字母“v”，表示该等效晶体整体以
// 速度v沿x'方向运动。箭头尾部有三条短竖线，暗示其作为刚
// 体运动的示意。无坐标轴或数值范围。 (c) 这是一个简化后
// 的二维示意图，标题为“等效单轴有效介质”。背景为均匀浅蓝
// 色矩形。左侧标注两个参数：“ε̂_D”和“μ̂_D”，表示等效介质
// 的介电常数和磁导率。右侧有两个对称的黄色双向箭头：上方
// 箭头向左，下方箭头向右，中间夹着黑色文字“v_D”，表示该
// 等效介质具有拖曳速度v_D，且上下部分运动方向相反（可能
// 对应不同极化模式或场分量）。无坐标轴或比例尺。 (d) 这
// 是一个二维曲线图，标题为“准静态极限下的色散关系”。横轴
// 为波数k_x（无量纲），纵轴为角频率ω（无量纲）。图中从原
// 点(0,0)发出四条直线射线：两条红色射线分别位于第一、第
// 三象限，斜率为正；两条蓝色射线分别位于第二、第四象限，
// 斜率为负。所有射线均通过原点，形成X形交叉。图中标注“ε
// and μ”位于右上角，“ε or μ”位于右下角，暗示这些色散分支
// 与材料的介电/磁响应相关。无具体数值刻度，仅定性展示线
// 性色散关系。 (e) 这是一个二维数据曲线图，标题为“拖曳速
// 度”。横轴为归一化调制速度v_m/c_0，范围从0到2.0，主刻度
// 间隔0.5。纵轴为拖曳速度v_D，范围从-0.1到0.1，主刻度间
// 隔0.1。图中包含三条曲线：一条实心蓝线标记为“homog.”（
// 均匀化近似），一条实线黑线标记为“exact”（精确解），一
// 条橙色虚线标记为“n=0, ±1”（特定傅里叶级数项）。三条曲
// 线在v_m/c_0 < 0.7时接近零，在v_m/c_0 ≈ 0.8附近急剧下降
// 至约-0.09，随后缓慢回升并趋于平缓。在v_m/c_0 ≈ 0.9处有
// 一条灰色竖直阴影带，可能表示共振或不稳定区域。图例位于
// 右上角。 (f) 这是一个二维数据曲线图，标题为“等效双各向
// 异性系数”。横轴为归一化调制速度v_m/c_0，范围从0.0到2.0，
// 主刻度间隔0.5。纵轴为系数ξ_eff，范围从-0.05到0.05，主
// 刻度间隔0.05。图中是一条深蓝色实线，从原点开始缓慢上升，
// 在v_m/c_0 ≈ 0.8附近急剧上升至约0.06，之后略有回落并趋
// 于平稳。在v_m/c_0 ≈ 0.9处同样有灰色竖直阴影带。图中还
// 包含一个内嵌放大图（inset），显示v_m/c_0从0.80到0.95区
// 间内ξ_eff的快速上升细节，纵轴范围为0.00到0.06。此外，
// 图中还有两条水平虚线：上虚线标注“α”，下虚线标注“-α”，
// 分别位于ξ_eff≈0.05和-0.05处，可能表示理论边界值。
#figure(placement: top, [#image("imgs/synthetic_motion-01.png", width: 100%)

  ],
  caption: [
    (a) and (b) A synthetic spacetime modulated crystal (panel a) is formally equivalent to a fictitious moving bianisotropic time-invariant crystal (panel b) when $v_m < c_0$. The velocity of the equivalent moving crystal is identical to the modulation speed $bold(v)_m$. (c) In the long wavelength limit the system response can be homogenized and the crystal behaves as a uniaxial dielectric moving with speed $bold(v)_D$. The sign of $v_D$ is not necessarily coincident with the sign of $v$. (d) Dispersion diagram of the effective medium: $omega$ vs $k_x$. When only one of the material parameters is spacetime modulated the dispersion is symmetric, and the equivalent drag velocity vanishes (blue lines). When both $epsilon$ and $mu$ are spacetime modulated, the dispersion is asymmetric (red lines, assuming $v_D > 0$). The waves that propagate in the direction of $bold(v)_D$ have a larger group velocity than the waves that propagate in the opposite direction~@huidobroFresnel2019. (e) Drag velocity $v_D$ and (f) effective bianisotropic coefficient $xi_"ef"$ as a function of the modulation speed $v_m$ for a representative spacetime modulated crystal: the velocity of the equivalent moving medium and the magneto-electric coupling coefficient flip sign in the transition from the subluminal to the superluminal regime. Adapted from~@huidobro2021homogenization.
  ]
) <fig:synthetic_motion>

A system featuring a travelling-wave-type modulation is characterized, in the dispersionless limit, by the following constitutive relations:

$
  mat(bold(D); bold(B)) = mat(epsilon ( x - v_m t, y, z ) bold(1), bold(0); bold(0), mu ( x - v_m t, y, z ) bold(1)) mat(bold(E); bold(H))
$<eq:constitutiveLab>

where $v$ is the modulation speed \[@fig:synthetic_motion(a)\].

This form of modulation in space and time imparts a synthetic motion to the material response along the $x$-direction with uniform speed $v_m$. This property implies that with a suitable coordinate transformation one can switch to a frame where the material response is time-invariant. In fact, a Galilean transformation of coordinates,

$
  x^' = x - v_m t, quad y^' = y, quad z^' = z, quad t^' = t,
$<eq:GalileanT>

preserves the usual structure of the Maxwell's equations, with the transformed fields related to the original fields as follows $bold(D^') = bold(D)$, $bold(B^') = bold(B)$, $bold(E^') = bold(E) + bold(v_m) times bold(B)$, $bold(H^') = bold(H) - bold(v_m) times bold(D)$ and $bold(v_m) = v_m bold(hat(x))$. In the new coordinates, the constitutive relations are time-independent

$
  mat(bold(D^'); bold(B^')) = mat(bold(hat(epsilon))^' (bold(r^')), bold(hat(xi))^' (bold(r^')); bold(hat(zeta))^' (bold(r^')), bold(hat(mu))^' (bold(r^'))) mat(bold(E^'); bold(H^')),
$<eq:constitutiveComoving>

with $bold(r^') = bold(r) - bold(v_m) t$ and the transformed effective parameters given by

$ bold(hat(epsilon))^' &= epsilon ( frac(1, 1 - epsilon mu v_m^2) bold(1)_t + bold(hat(x)) ⊗ bold(hat(x)) ), \
  bold(hat(mu))^' &= mu ( frac(1, 1 - epsilon mu v_m^2) bold(1)_t + bold(hat(x)) ⊗ bold(hat(x)) ), \
  bold(hat(xi))^' &= -bold(hat(zeta))^' = frac(- epsilon mu, 1 - epsilon mu v_m^2) bold(v_m) times bold(1). $

In the above, $bold(1)_t = bold(hat(y)) ⊗ bold(hat(y)) + bold(hat(z)) ⊗ bold(hat(z))$ and $⊗$ represents the tensor product of two vectors. As seen, the coordinate transformation originates a bianisotropic-type coupling determined by the magneto-electric tensors $bold(hat(xi))^'$ and $bold(hat(zeta))^'$~@Serdyukov, such that the electric displacement vector $bold(D^')$ and the magnetic induction $bold(B^')$ depend on both the electric and magnetic fields $bold(E^')$ and $bold(H^')$. Indeed, as further discussed below, one of the peculiar features of the travelling-wave spacetime modulation is that it mixes the electric and magnetic responses, leading to the possibility of a giant bianisotropy in the quasi-static limit~@huidobro2021homogenization.

Interestingly, the constitutive relations (~@Kong) in the new coordinate system are reminiscent of those of a moving dielectric medium~@huidobroFresnel2019. Due to this feature the electrodynamics of spacetime media with travelling wave modulations bears many similarities to the electrodynamics of moving bodies @huidobroFresnel2019.  Yet, it is important to underline that a spacetime modulated dielectric crystal is not equivalent to a #emph[moving] dielectric crystal. In other words, impressing a time modulation on the parameters of a dielectric photonic crystal is not equivalent to setting the same photonic crystal into motion. A moving dielectric crystal would have a bianisotropic response in a frame where its speed $v$ is nontrival, very different from the constitutive relations @eq:constitutiveLab. Below, we revisit this discussion in the context of effective medium theory.

Even though the spacetime modulated dielectric system is not equivalent to a moving dielectric, its response can be precisely linked to that of a fictitious moving medium in the subluminal case. In fact, as previously noted, a suitable Lorentz transformation makes the response @eq:constitutiveLab of a spacetime system independent of time, analogous to @eq:constitutiveLab. Thus, the original constitutive relations @eq:constitutiveComoving are indistinguishable from those of a hypothetical moving system with a bianisotropic response in the co-moving frame of the type @eq:constitutiveComoving. In other words, the synthetic motion provided by the travelling wave modulation imitates the actual physical motion of a fictitious time-invariant bianisotropic crystal \[@fig:synthetic_motion\(b)\].

The previous discussion is completely general, apart from the assumption of a travelling wave modulation. In the following, we focus our attention on periodic systems and in the long wavelength regime. Effective medium methods have long been used to provide a simplified description of the wave propagation in complex media and metamaterials~@DRSmith2007 @Silv2007 @Simovski2007 @AluFirstPrinciples2007. The effective medium formalism is useful not only because it enables analytical modeling of the relevant phenomena, but also because it clearly pinpoints the key features of the system that originate the peculiar physics.

The standard homogenization approach is largely rooted on the idea of "spatial averaging", so that the effective response describes the dynamics of the envelopes of the electromagnetic fields~@jacksonClassical2012. In particular, in the traditional framework, there is no time averaging. Due to this reason, standard homogenization approaches are not directly applicable to spacetime crystals, where the microscopic response of the system depends simultaneously on space and on time.

At present, there is no general effective medium theory for spacetime crystals. Fortunately, the particular class of spacetime crystals with travelling wave modulations can be homogenized using standard ideas~@huidobro2021homogenization @HTToHomogenization @LurieBook. In fact, since a travelling wave modulated spacetime crystal is virtually equivalent to a moving system, it is possible to find the effective response with well established methods by working in the co-moving frame (primed coordinates) where the medium response is time invariant @huidobro2021homogenization.

To illustrate these ideas, we consider a one-dimensional photonic crystal such that the permittivity $epsilon$ and permeability $mu$ are independent of the $y$ and $z$ coordinates. It is well known, that for stratified systems the components of the $bold(E)$ and $bold(H)$ fields parallel to the interfaces ($y$ and $z$ components) and the components of the $bold(D)$ and $bold(B)$ fields normal to the interfaces ($x$ components) are constant in the long wavelength limit~@Aspnes1982, i.e., when the primed field envelopes vary sufficiently slowly in space and in time. Taking this result into account, one can relate the spatially averaged $⟨bold(D^')⟩bold(D^'))$ and $⟨bold(B^')⟩bold(B^'))$ with the spatially averaged $⟨bold(E^')⟩bold(E^'))$ and $⟨bold(H^')⟩bold(H^'))$ @huidobro2021homogenization. The effective parameters in the original (laboratory) frame can then be found with an inverse Galilean (or Lorentz) transformation. Such procedure leads to the following constitutive relations in the lab frame:

$
  mat(⟨bold(D)⟩bold(D)); ⟨bold(B)⟩bold(B))) = mat(bold(hat(epsilon))_(""), xi_("") bold(hat(x)) times bold(1); - xi_("") bold(hat(x)) times bold(1), bold(hat(mu))_("")) mat(⟨bold(E)⟩bold(E)); ⟨bold(H)⟩bold(H))),
$<eq:effectiveconstitutive>

where $bold(hat(epsilon))_("")$, $bold(hat(mu))_("")$ and $xi_("")$ are some parameters that can be written explicitly in terms of the permittivity and permeability profiles $epsilon ( x )$ and $mu ( x )$@huidobro2021homogenization. It turns out that when only one of the material parameters is modulated in spacetime the magnetoelectric coupling coefficient $xi_("")$ vanishes and the effective medium behaves as a standard uniaxial dielectric~@huidobro2021homogenization @huidobroFresnel2019. For example, if the material permeability is independent of space and time, then $xi_("") = 0$ and $bold(hat(mu))_("") = mu bold(1)$, for any permittivity profile $epsilon ( x )$. This property can be intuitively understood by noting that when $mu = "const."$, the “microscopic''” constitutive relation $bold(B) = mu bold(H)$ implies that the averaged fields are also linked by $⟨bold(B)⟩bold(B)) = mu ⟨bold(H)⟩bold(H))$, which corresponds to a trivial effective magnetic response. Note that this argument is only justified in the static limit, as in the dynamical case the second order spatial dispersion effects may lead to artificial magnetism~@Pendry1999 @Silv2007; other exotic static bianisotropy may arise in antiferromagnets with an axion-type response~@Astrov.

Remarkably, when both $epsilon$ and $mu$ are modulated in spacetime, $xi_("")$ can be nontrivial. In other words, notwithstanding that at the microscopic level there is no magnetoelectric coupling @eq:constitutiveLab, the effective medium is characterized by a bianisotropic response in the static limit. While it is not unusual that the complex wave interactions in a metamaterial without inversion symmetry can result in a magnetoelectric coupling~@Serdyukov, having a nontrivial magnetoelectric coupling in the static limit is very exotic, and to this date only reported in multiferroic materials with a very limited tunability#footnote[For completeness, we point out that some antiferromagnets, such as chromium oxide, may be characterized by an intrinsic axion-type bianisotropic response in the static limit~@Astrov @CohVanderbilt.]. In fact, in typical time-invariant systems the electric and magnetic fields are decoupled in the static limit. Thereby, the electric and magnetic responses of any conventional metamaterial are necessarily decoupled in the static limit and there is no bianisotropy. In contrast, for a spacetime modulated system the electric and the magnetic fields are never fully decoupled, as the time modulation of the material implies always some nontrivial time dynamics, and the magnetoelectric coupling is a direct consequence of the Lorentz invariance of Maxwell's equations. The strength and sign of $xi_"ef"$ can be tuned by changing the modulation speed and the profiles of the permittivity and permeability. As illustrated in @fig:synthetic_motion\(f), $xi_"ef"$ can be exceptionally large for modulation speeds approaching the speed of light in the relevant materials. This results in giant nonreciprocity, as has also been shown through Floquet-Bloch expansions~@taravatiGiant2018. The transition from the subluminal to the superluminal regime is marked by a change in sign of $xi_"ef"$.

Furthermore, it can be shown that constitutive relations @eq:effectiveconstitutive are identical to those of a fictitious moving anisotropic dielectric characterized in the respective co-moving frame by the permittivity $bold(hat(epsilon))_D$ and by the permeability $bold(hat(mu))_D$. The equivalent medium moves with a speed $v_D$ with respect to the lab frame. The parameters $bold(hat(epsilon))_D$, $bold(hat(mu))_D$ and $v_D$ are determined univocally by $bold(hat(epsilon))_("")$, $bold(hat(mu))_("")$ and $xi_("")$@huidobro2021homogenization. In general, $v_D$ may be rather different from the modulation speed $v$, both in amplitude and sign. The velocity $v_D$ can be nonzero only if $epsilon$ and $mu$ are both modulated in spacetime, i.e., only if $xi_("") != 0$. Therefore, it follows that a spacetime modulated photonic crystal can imitate precisely the response of a moving dielectric in the long wavelength limit. Remarkably, the velocity of the equivalent moving medium can be a very significant fraction of $c_0$ \[@fig:synthetic_motion(e)\]. Thus, spacetime modulated systems are ideal platforms to mimic on a table-top experiment the electrodynamics of bodies moving at relativistic velocities, the only caveat being that some degree of frequency mixing will, in general, occur upon propagation in a space-time medium.

In particular, similar to a moving medium, a spacetime modulated crystal can produce a drag effect~@huidobroFresnel2019. Specifically, a wave co-propagating with the equivalent moving medium, i.e. towards the direction $"sgn" ( v_D ) bold(hat(x))$, moves faster than a wave propagating in the opposite direction, due to the synthetic Fresnel-drag effect~@Fizeau. A clear fingerprint of the Fresnel drag can be detected in the dispersion of $omega$ vs. $k$ of the electromagnetic modes of the spacetime crystal. In fact, when both $epsilon$ and $mu$ are modulated in time, the slopes of the dispersion of the photonic states near $k = 0$ depend on the direction of propagation of the wave. The dispersion of the waves that co-propagate with the equivalent moving medium exhibits a larger slope than the dispersion of the modes that propagate in the opposite direction, as depicted in @fig:synthetic_motion\(d). Interestingly, these slopes are predicted #emph[exactly] by the discussed effective medium theory, and thereby the homogenization theory is expected to be rather accurate and useful to characterize excitations that vary sufficiently slowly in space and in time. Furthermore, the effective medium theory is exact for all frequencies when the parameters of the crystal are matched: $epsilon \/ mu = "const."$. In fact, the dispersion of a matched photonic crystal is generally linear for all frequencies. However, as we show in the next section, even this statement can be violated in an exotic class of spacetime media recently termed #emph[luminal] metamaterials.

<luminal-amplification-and-spatiotemporal-localization>

== Luminal amplification and spatiotemporal localization <sec:luminal>

// [figvision-cn] imgs/luminalAmpliicationLocalization.png
// 子图(a)包含左侧的曲线图和右侧的示意图。 左侧曲线图：纵
// 坐标轴标记为 $U$，范围从0到12；横坐标轴标记为 $\Omega
// t$，显示刻度 $0, \pi/2, 3\pi/2$。图中有四条曲线，分别
// 对应不同的参数 $d$。红色曲线（$d=30$）峰值最高，约为11，
// 位于 $\Omega t = \pi/2$ 处；橙色曲线（$d=20$）峰值次之，
// 约为5；青色曲线（$d=10$）峰值较低；深蓝色曲线（$d=0$）
// 几乎贴近横轴。每条曲线上都有对应颜色的实心圆点，代表数
// 值模拟结果（Numerics），与实线代表的解析解（Analytics）
// 重合良好。垂直虚线在 $\Omega t = \pi/2$ 和 $3\pi/2$ 处
// 标示了脉冲位置。 右侧示意图：展示了一个矩形区域，宽度
// 标记为 $d$。矩形内部填充有竖直条纹，背景颜色从左至右由
// 淡红渐变至橙黄，表示介电常数 $\varepsilon(gx - \Omega
// t)$ 的空间分布。左侧有一个波浪线箭头指向该区域，表示输
// 入波；右侧有一个水平箭头引出，标记为 $E_{out}$，表示输
// 出电场。 子图(b)为函数曲线图。 纵坐标轴标记为 $\
// varepsilon$，横坐标轴标记为 $\Omega t$，刻度为 $0, \pi
// /2, 3\pi/2$。图中有一条绿色实线，呈周期性波动，在 $\pi
// /2$ 处达到正向峰值，在 $3\pi/2$ 处达到负向谷值。一条水
// 平虚线穿过波形中心。图中用红色双向箭头标注了不同区域的
// 传播特性：在 $\pi/2$ 附近标注 $c_l > v_m$，在中间区域
// 标注 $c_l < v_m$，在 $3\pi/2$ 附近再次标注 $c_l > v_m$。
// 这描述了介质参数变化导致的光速与调制速度之间的相对关系。
// 子图(c)为一组堆叠排列的频谱图，共6行。 纵坐标轴统一标
// 记为 $|E_{out}(\omega)|^2$，范围从0到0.7；横坐标轴标记
// 为 $\omega/\Omega$，范围从0到350。顶部标题注明 $\
// omega_0 = 8\Omega$。每一行对应一个特定的 $d$ 值，从上
// 到下依次为 $d=0, 15, 30, 45, 60$。每行中包含三条曲线，
// 分别对应不同的 $\alpha$ 值：浅蓝色（$\alpha=0.02$）、
// 紫色（$\alpha=0.04$）、品红色（$\alpha=0.06$）。当 $d=
// 0$ 时，所有曲线均为零。随着 $d$ 增加，谱峰出现并向高频
// 移动。对于固定的 $d$，随着 $\alpha$ 增大，主峰高度降低
// 且频带变宽。 子图(d)结构与子图(c)相同，也是一组堆叠的
// 频谱图，共6行。 纵坐标轴标记为 $|E_{out}(\omega)|^2$，
// 采用对数标度，范围从 $10^{-4}$ 到 $10^0$；横坐标轴标记
// 为 $\omega/\Omega$，范围从0到350。顶部标题注明 $\
// omega_0 = 0$ (DC)。每一行对应一个特定的 $d$ 值，从上到
// 下依次为 $d=0, 20, 40, 60, 80$。同样包含三种颜色的曲线
// 对应不同的 $\alpha$ 值。当 $d=0$ 时无输出。随着 $d$ 增
// 加，低频部分（接近0）的能量显著增强，形成陡峭的衰减斜
// 坡。随着 $\alpha$ 增大，能量衰减变缓，高频分量增多。
// 子图(e)包含两个并列的坐标系，展示时间演化过程。 左图：
// 纵坐标轴标记为 time，范围约-50到50；横坐标轴标记为 $gX
// /\pi$，范围-2到2。图中有一条蓝色S形曲线，表示场强随时
// 间的变化。两条水平红色虚线标记了阈值，分别在+20和-20左
// 右。一条垂直黑色虚线标记位置 $X_0$。在 $X_0$ 左侧，曲
// 线处于低电平；经过 $X_0$ 后迅速上升至高电平。左上角标
// 注参数 $\alpha = +0.05, \delta = -0.095$。 右图：坐标
// 轴定义同左图。蓝色曲线呈现倒置的S形，从高电平下降至低
// 电平。参数标注为 $\alpha = +0.05, \delta = +0.085$。两
// 图均展示了在不同参数下，信号在特定空间位置 $X_0$ 处的
// 开关行为。 子图(f)为多条曲线叠加的线图。 纵坐标轴标记
// 为 $|E|^2$，范围从0到14；横坐标轴标记为 $X$，范围从0.0
// 到2.0。图中有多条蓝色曲线，每一条代表一个特定时刻 $t$
// 的场强分布。曲线标签包括 $t=0, t=\Delta t/6, t=2\Delta
// t/6, \dots, t=5\Delta t/6$。这些曲线展示了一个波包随时
// 间向右移动并逐渐变窄、峰值增高的过程。在 $t=0$ 时，波
// 包较宽且峰值较低；随着时间推移，波包中心向 $X=1.0$ 附
// 近移动，峰值急剧升高至12以上，表现出自聚焦或压缩效应。
// 子图(g)未在提供的图片中显示，因此无法描述。
#figure(placement: top, [#image("imgs/luminalAmpliicationLocalization.png", width: 100%)

  ],
  caption: [
    \(a) Electric field intensity at the output port vs time transmitted through different thicknesses (blue to red) $d$ of luminal crystal. (b) In the gain region the permittivity gradient is positive, and vice versa. The gain is maximum at the points (in time or space) where the velocity of the waves matches the velocity of the grating. (c-d) Power spectra of the transmitted waves for input frequency (c) $omega_0 = 8 Omega$, with $Omega$ the modulation frequency, and (d) for a DC input field ($omega_0 = 0$), showing the frequency generation responsible for the overall gain~@galiffiBroadband2019 @galiffi2020new (e-f) Trajectories of a point of constant phase along the spacetime variable $X = x - v_m t$. (e) outside of the localization regime (resulting in oscillations which periodically compress and decompress the pulse, panel g), and (f) within the localization regime, resulting in the amplification and compression described in (a-d) ~@galiffiPhoton2021. Figures adapted from @galiffi2020new, @galiffiBroadband2019 and @galiffiPhoton2021.
  ]
) <fig:luminal>

If the speed of a space-time modulation falls within the modulation velocity regime in @eq:luminalRegime (the extent of this #emph[luminal] regime increases with the modulation amplitude), the relevant wave physics changes dramatically, entering a very peculiar unstable phase whose underlying mechanism is, however, completely distinct from the parametric amplification processes described in @sec:switching and @sec:timeperiodic~@galiffiBroadband2019. In this regime, all forward bands become almost degenerate, as the frequency-momentum reciprocal lattice vectors effectively align with the forward bands. This regime marks a transition between the subluminal and superluminal regimes in @fig:basic_concepts\(d) and (e) respectively. Due to the resulting strong degeneracy between forward-travelling waves, the eigenmodes of these luminal systems cannot be written in Bloch form~@galiffiPhoton2021: the effect of the modulation, in fact, is to couple all of the forward bands, such that an impinging wave would emerge as a supercontinuum, or frequency comb. Such a transmission process is shown in @fig:luminal\(a-d): the waves are compressed into a train of pulses, and both the total energy of the system and its compression increase exponentially with respect to the propagation length (or time) in the luminal medium, as well as the amplitude and rate of the modulation. In real space, this amplification process can be viewed as the capturing of field lines by the synthetically moving grating~@pendry2021gain. The wave dynamics in a luminal medium is captured by the approximate equation for the energy density $U$ (which becomes exact if $epsilon = mu$ everywhere):

$
  frac(partial ln U, partial t^') = frac(v_m + c_l, 2) [ frac(partial ln mu, partial X) + frac(partial ln epsilon, partial X) ] + (v_m - c_l) frac(partial ln U, partial X)
$<eq:luminalEq>

where $v_m$ is the grating velocity, $c_l ( X ) = ( epsilon mu ) ^(-1/2)$, and $X = x - v_m t$ and $t^' = t$ are moving coordinates, which can be solved by successive iterations~@galiffi2020new. The characteristic feature of the luminal regime is the presence of points along the grating where the local phase velocity $c_l ( X )$ of the waves matches the velocity $v_m$ of the grating (crossings between the black, dashed horizontal line and the green sinusoidal grating profile in @fig:luminal\(b)). The presence of these velocity-matching points implies that the lines of force are trapped within each period of the grating, merely subject to the first term, which acts as an energy source term, resulting from the spatiotemporal change in $epsilon$ and $mu$. In fact, these local gradients in the electromagnetic parameters (first term in @eq:luminalEq) will pump energy into the waves, or deplete them, based on their sign, whereas the phase velocity of the waves in the region adjacent to the velocity-matching points determines whether these will function as attractors ($pi \/ 2$ in @fig:luminal\(b)) or repellors ($3 pi \/ 2$ in @fig:luminal\(b)) as a result of the Poynting flux driving power towards or away from them~@pendryNew2021. It has been noted that this completely linear mechanism results in pulse compression or expansion~@chamanaraLinear2019. On the other hand, as the modulation velocity approaches the edges of the luminal regime, a localization transition takes place, before which the response of the system is characterized by strong oscillations in time consisting of periodic field compression and expansion~@galiffiPhoton2021, as shown in @fig:luminal\(e-g). Importantly, luminal amplification does not rely on back-scattering, as opposed to parametric amplification, and in fact it occurs just as well in a system which is impedance-matched everywhere in spacetime, in sharp contrast to parametric amplification, which relies on time-reversal as explained in @sec:timeperiodic.

== Space-time metasurfaces <sec:spacetime_metasurfaces>
Most implementations of time-varying and space-time-varying systems are hard to achieve in bulk, as any modulation mechanism, e.g. a pump pulse, would generally need to impinge on the system from an additional direction. In addition, field penetration into a bulky structure is generally inhomogeneous, so that in practice only a small surface layer of a bulk medium would effectively be modulated. These considerations, combined with the ease of fabrication of metasurfaces compared to bulk metamaterials, have led to a concentration of research interest in space-time metasurfaces, whereby a travelling-wave modulation is applied to the surface impedance of a thin sheet, with proposals covering a wide range of ideas and applications, some of which are shown in @fig:nonreciprocity.

// [figvision-cn] imgs/metasurfaces-01.png
// 子图 (a) 为示意图，展示基于单向激发倏逝模的隔离器工作
// 原理。图中包含两个端口（Port 1 和 Port 2），分别位于左
// 右两侧。左侧 Port 1 处有一束紫色入射波，标注频率为 ω₀，
// 入射角为 θᵢ，对应模式阶数 n=0；该波在界面处发生反射和
// 透射，其中向右侧传播的透射波被抑制（未画出），而向左返
// 回的反射波存在。右侧 Port 2 处有一束绿色入射波，同样标
// 注频率 ω₀、入射角 -θᵢ、模式阶数 n=0，其透射波可无损耗
// 地向左传播至 Port 1，但反向路径被阻断。界面下方标注距
// 离 D，坐标系显示 x 轴水平向右，z 轴垂直向上。此图传达
// 非互易传输特性：仅允许从 Port 2 到 Port 1 的传播，禁止
// 反向。 子图 (b) 为示意图，描述波在空间时间超表面（STM）
// 上散射时经历非互易相移。结构与 (a) 类似，含 Port 1 和
// Port 2。左侧 Port 1 入射紫色波（ω₀, θᵢ, n=0），反射后
// 获得附加相位 φ₂；右侧 Port 2 入射绿色波（ω₀, -θᵢ, n=0），
// 反射后获得不同附加相位 φ₁。两束反射波均标有各自相位偏
// 移量，表明即使几何对称，因时空调制引入的非互易性导致相
// 位响应不对称。坐标轴同 (a)，D 表示单元间距。结论：STM
// 可实现方向依赖的相位调控。 子图 (c) 为示意图，展示基于
// STM 的环形器功能。三个端口：Port 1（左）、Port 2（右）、
// Port 3（中）。Port 1 入射黄色波（ω₀, θᵢ, n=-1），经调
// 制后产生新频率分量 ω₀−ωₘ，沿特定角度出射至 Port 3；同
// 时 Port 1 自身也接收来自 Port 3 的绿色波（ω₀, -θᵢ, n=0）。
// Port 2 入射浅绿波（ω₀, -θᵢ, n=1），经调制生成 ω₀+ωₘ 分
// 量并导向 Port 3。所有路径用箭头明确指示能量流向，体现
// 三端口循环路由能力。坐标轴与尺寸 D 同前。结论：STM 支
// 持多端口非互易信号路由。 子图 (d) 为复合示意图，分为三
// 部分：左上为可编程超表面阵列，由蓝色背景上的黄色方块组
// 成，代表电压控制单元；中间区域展示等效空间编码图案，红
// 色箭头表示波矢 kₓ，绿色网格代表空间分布，标注 rⱼₘ 为位
// 置参数；右下为“Space-time-coding”模块，显示随时间和空
// 间变化的编码序列，如 ℓ=3k, ℓ=2k 等，配合波形图示说明动
// 态调制过程。整体布局从左到右依次为物理结构→等效模型→编
// 码机制，强调通过编程实现灵活波前操控。 子图 (e) 为曲线
// 图，标题 “Amplitude modulation”，横轴 Theta (degree)，
// 范围 -90° 至 90°，纵轴 Normalized scattering pattern (
// dB)，范围 -50 dB 至 0 dB。图中有多组彩色虚线/实线曲线，
// 每组对应一种调制状态或偏置条件，颜色包括黑、红、蓝、黄、
// 绿、紫等，每条曲线呈钟形或多峰形态，峰值位置随参数变化
// 移动。例如黑色曲线主瓣约在 ±15°，红色在 ±30°，表明可通
// 过调节编码改变散射方向。趋势：幅度调制能有效控制远场辐
// 射图样形状与指向。 子图 (f) 为显微照片风格渲染图，展示
// 实验实现的时空编码超表面实物效果。底部为金属基底，上方
// 覆盖一层透明介质膜，其上排列着微小元件（不可见细节）。
// 三束红光以不同角度入射，标注频率均为 ω₀；反射光中出现
// 多个频移分量，如 ω₀+2ωₘ、ω₀+ωₘ、ω₀，用不同颜色射线表示，
// 且各射线发散角度各异。比例尺未给出，但可见光束宽度较窄，
// 聚焦于中心区域。结论：实际器件能同时产生多阶频率转换与
// 非互易散射。 子图 (g) 为多层结构示意图，分四个视图：(a
// ) 三维俯视图，绿色顶层布满规则点阵，代表活性单元；(b)
// 正交截面图，显示底层铜箔、中间介电层、顶部导电图案，标
// 注 y<0 和 y>0 区域结构差异；(c) 局部放大图，揭示单个单
// 元内部电极与电容结构，标注 V₁、V₂ 控制电压；(d) 平面布
// 局图，绿色方格内嵌黑色小圆点，形成周期性阵列，右上角插
// 图 (b) 显示完整芯片级排布，呈放射状对称。材料标注 SiO₂、
// ITO、Au 等，厚度信息隐含于层叠结构中。结论：器件采用分
// 层设计，通过电压独立控制每个单元阻抗，实现二进制编码。

Systems such as isolators \[@fig:spacetime_metasurfaces\(a)\], nonreciprocal phase shifters \[@fig:spacetime_metasurfaces\(b)\] and circulators \[@fig:spacetime_metasurfaces\(c)\] using space-time modulated metasurfaces were designed, extending magnet-free nonreciprocity to surface implementations~@hadad2015space @hadad2016breaking @shaltoutTimevarying2015 @wang2020theory. A promising idea to exploit these concepts in practice, at least at low frequencies, has come in the form of space-time-coding digital metasurfaces \[@fig:spacetime_metasurfaces\(d)\]: these systems consist of arrays of elements whose impedances are designed to take a discrete set of values, so that the overall response of the structure can be encoded as an array of bits (if only two values exist for each element)~@zhang2019breaking @rajabalipanah2021analog. Switching the individual impedances of a voltage-controlled array of such elements can enable exquisite control over the metasurfaces response in a system whose design can be systematically described using information theory concepts to tailor shape and direction of electromagnetic beams \[@fig:spacetime_metasurfaces\(e)\]~@zhang2018space, as well as to perform photonic analog computing @zhang2018space.    Furthermore, close to the luminal regime, opportunities for nonreciprocal hyperbolic propagation~@mazor2019one, as well as vacuum Čerenkov radiation~@oue2021v using space-time metasurfaces have recently been highlighted.

Another application of space-time metasurfaces that was recently proposed is that of power combining of waves, a long-standing challenge in laser technology. Here the strategy consists of using a spatiotemporal modulation of a surface to effectively trade the difference in angle of incidence between a discrete set of incoming waves with identical frequency in exchange for a difference between frequencies of the outgoing waves, which emerge, at the same angle, and at an equally spaced set of frequencies, as illustrated in @fig:spacetime_metasurfaces\(f)~@wang2021space. More exotic ideas include angular-momentum-biased metasurfaces \[@fig:spacetime_metasurfaces\(g)\], which can impart a geometric phase on the impinging waves, and engineer photonic states with finite orbital angular momentum and optical vortices~@barati2020topological.~@kortcamp2021space. Finally, the concept of space-time metasurfaces has recently been imported into the quantum realm, promising full control of spatial, temporal and spin degrees of freedom for non-classical light, with several opportunities for the generation of entangled photonic states, thereby anticipating a whole new scenery for this field to expand towards @kortcamp2021space.

#figure(placement: top, [#image("imgs/metasurfaces-01.png", width: 100%)

  ],
  caption: [
    Examples of applications of space-time metasurfaces: (a) An isolator based on the unidirectional excitation of evanescent modes; (b) Waves scattering off a STM experience a nonreciprocal phase shift; (c) A STM-based circulator~@Indukuri2019ASCNanoUltrasmall (d) Illustration of an experimentally realized space-time coding metasurface, consisting of a square array of individual voltage-controlled elements with binary impedance values, enabling encoding and imprinting of arbitrary phase and amplitude modulation onto different scattered harmonics for (e) beam-steering and shaping~@Indukuri2020ASCAppNanoMattWS2 (f) Illustration of wave power combining using STMs: incoming waves with frequency $omega_0$ coming from a discrete range of different angles can be scattered towards the same outgoing direction by imprinting the necessary frequency-wavevector shifts via the STM. (g) A proposal of an angular momentum-biased metasurface for generation of orbital angular momentum states: each azimuthal section is temporally modulated with a different relative phase, imparting the necessary angular-momentum bias. Figures adapted from @wang2020theory, @zhang2018space and @barati2020topological.
  ]
) <fig:spacetime_metasurfaces>

== Further directions <further-directions>

Among new directions for space-time media, dispersive effects offer additional knobs for mode-engineering~@chamanaraUnusual2018, for which much still remains to be explored. Interestingly, spatial dispersion may be effectively engineered into a material via time-modulation, just as temporal dispersion arises from spatial structure~@torrent2020strong. Chiral versions of synthetically moving and amplifying electromagnetic media, mimicking the Archimedean screw for fluids, have recently been proposed, and may be realized with circularly polarized pump-probe experiments~@galiffi2021archimedes. Topology also occupies a prime seat, with Floquet topological insulators having been realized in acoustics~@fleuryFloquet2016, and theoretically proposed for light~@he2019floquet. Further related opportunities have been demonstrated for photonic realizations of the Aharonov-Bohm effect~@fangPhotonic2012, as well as higher dimensional topological effects such as Weyl points (topological invariants for 3D structures) in spatially 2D systems, realized by exploiting a synthetic frequency dimension~@linPhotonic2016. The idea of space-time media has also been formalized in the interesting mathematical formulation of “field patterns”. These objects arise from the consecutive spatial and temporal scattering in a material that features a checkerboard-like structure of its response parameters in space and time, and may offer new angles to study space-time metamaterials in the future~@milton2017field @mattei2017field @LurieBook. Finally, beside photonic systems, non-electromagnetic dynamical metamaterials have already acquired significant momentum, with several theoretical proposals~@torrentNonreciprocal2018 @nassarQuantization2018 @liTransfer2019 and experimental realizations, including asymmetric charge diffusion~@camachoAchieving2020, nonreciprocity~@fleurySound2014, @wangObservation2018 @chen2021efficient, Floquet topological insulators~@fleuryFloquet2016 and topological pumping~@xuPhysical2020 amongst many others. In particular, digitally controlled acoustic meta-atoms have recently attracted significant interest to probe time-modulation physics in acoustics~@wen2020asymmetric @cho2020digitally. <experimental-advances-and-challenges-in-all-optical-implementations>

= Experimental advances and challenges in all-optical implementations <sec:experiments>

The experimental realisation of time-varying effects constitutes a new, broad and fruitful field of research across the wider wave-physics and engineering spectrum. Implementation in optics, and more particularly in nanoscale architectures and metasurfaces offers new opportunities to address both fundamental open questions in wave physics as well as material science, and potentially groundbreaking technological pathways, such as low-footprint ultrafast optical modulators and nonreciprocal components. This is particularly challenging due to the need for modulating a medium on a temporal scale similar to the optical frequency of the light field. Time-varying effects have been demonstrated in mechanical~@Bacot2019ProNatAcSciPhase, magnetic~@Schultheiss2021PRLTime, acousto-optic~@Kittlaus2018NatPhotNonreciprocal, opto-mechanical~@shenExperimental2016 and electronic systems~@liraElectrically2012. In particular, electromagnetic metasurfaces can be modulated via mechanical actuation, chemical reactions, or phase-change materials, as well as electrically~@Shaltout2019ScienceSpatiotemporal. Nevertheless, their slow modulation speed compared to near-optical timescales makes these poor candidates for achieving sizable frequency shifts and other time-varying effects in the visible or near-infrared ranges. The following section focuses on experimental realisations of time-varying media in these optical frequency ranges. Emphasis is placed on metasurfaces as these have subwavelength thicknesses that allow for purely temporal modulations of the medium. In a metasurface, the various constraints of bulk media such as loss or self-broadening are avoided, and the propagation of the modulating or probe beam in the medium does not need to be taken into account. We will review in a first step the state of the art of time-varying photonics experiments using nonlinear optical processes in semiconductors, more specifically their most common implementations: epsilon near zero (ENZ) materials, hybrid ENZ platforms and high-index dielectrics. We will then discuss emerging paths to implement all-optical ultrafast modulation within new structures or materials such as quantum wells, magnetic materials, multilayered metamaterials and 2D materials.

== Photocarrier excitation and nonlinear optical modulation <photocarrier-excitation-and-nonlinear-optical-modulation>

Thanks to their wide variety of implementations and frameworks, as well as their ultrafast nature, nonlinear optical interactions have proven to be a fertile ground for the development of time-varying systems at optical frequencies. In particular, modulation effects originated by short laser pulses interacting with a nonlinear medium occur on sub-ps timescales, well beyond the reach of electro-optic modulation, and very close to the time of an optical cycle (1-10~fs regime). Optical modulation of a medium stems from a change in $epsilon$, the relative permittivity, due to the nonlinear response in a material. In semiconductors, these effects are often driven by out-of-equilibrium electronic populations, called hot-electrons. Nonlinear effects in semiconductors arise because of electron excitation of either real or imaginary states. Transitions through real states are realized by photocarrier excitation, that is intraband or interband transitions of the electrons within the active medium. The redistribution of electrons within the valence and/or conduction bands will affect the permittivity and thus the refractive index of the material on timescales limited either by the rate of transfer of energy from the light beam to the electrons or by the light pulse duration. This allows for sub-ps modulation of $epsilon$ in a variety of media of interest for photonics, including dielectrics and metals. Transitions through virtual states are on the other hand much faster, but lack the strength of photocarrier excitations: nonlinear processes via virtual states, such as four-wave-mixing and sum-frequency-generation, usually exhibit low efficiencies. Both photocarrier excitation and nonlinear optical modulation induce ultrafast modulation of $epsilon$, generally limited by the pulse duration and not material-limited. In the next section we will discuss recent progress in nonlinear optical modulation for time-varying effects in two main platforms: epsilon-near-zero media and high-index dielectrics.

=== Epsilon-Near-Zero materials, transparent conducting oxides and nonlinear optics <epsilon-near-zero-materials-transparent-conducting-oxides-and-nonlinear-optics>

ENZ materials exhibit various interesting properties around their ENZ frequency, where the real part of their permittivity crosses zero, while the imaginary part stays relatively low. ENZ media feature guided and plasmonic modes for field enhancement, slow-light effects in waveguides and phase-matching relaxation~@Kinsey2019NatRevMatNear. Of particular interest are transparent conducting oxides (TCOs), degenerately doped semiconductors whose band structures allow for ENZ frequencies in the near-IR with strong optical nonlinearities. Indium Tin Oxide (ITO) and Aluminium Zinc Oxide (AZO) are well known, silicon-technology compatible TCOs with very strong nonlinear optical response~@alamLarge2016 @Caspani2016PRLEnhanced @Luk2015APLEnhanced @Carnemolla2018OptMatExpDegenerate which makes them good candidates as platforms for time-varying metasurfaces. Particularly, intraband transitions in ITO lead to a strong redistribution of the effective mass of conducting electrons and thus an efficient shifting of the plasma frequency in the material's Drude dispersion as shown in @fig:expFig1\(a). As shown by Alam et al. in 2016~@alamLarge2016, order of unity modulation of the refractive index can be achieved in ITO. Keeping in mind that for an instantaneous change of index, the frequency shift due to time-refraction is proportional to $Delta n \/ n$, where $n$ is the refractive index and $Delta n$ the index change, strong frequency shifts can be achieved in ITO due to its low refractive index near its ENZ frequency, even for small changes $Delta n$.

Time-refraction in pump probe experiments has been shown in bulk ITO and AZO thin-films @Ferrera2018JofOptUltrafast @Vezzoli2018PRLOptical @Bruno2020AppSciBroad @Zhou2020NatCommBroadband @Bohn2021Spatiotemporal, with frequency shifts as strong as 58 THz @Bruno2020AppSciBroad when the probe field and the modulation overlap [see diagram in @fig:expFig1(b)]. Time-refraction not only applies to the reflected and transmitted probe pulse, but also to its phase conjugation and negative refraction, as shown in @fig:expFig1(c-f). In the works of Ferrera et al. @Ferrera2018JofOptUltrafast, Vezzoli et al. @Vezzoli2018PRLOptical and Bruno et al. @Bruno2020AppSciBroad, negatively refracted and phase-conjugated signals were recorded simultaneously with the time-refracted signal, with the internal efficiencies going above unity for these ultrafast, purely time-varying signals @Vezzoli2018PRLOptical. This demonstrated the potential of these TCOs for time-varying applications, yet the strength of the modulation and signal was mostly achieved thanks to a significant propagation within the medium, and was hampered by losses in the medium (for ITO, the penetration depth of light around the ENZ frequency is about 100 nm). Time-refraction in a 80 nm thick ITO metasurface was demonstrated in Liu et al.'s work @Liu2021ACSPhotPhoton in 2021, which in turn highlighted the need for a new understanding of the role of saturation of photocarrier excitation in the modulation of permittivity as large field intensities are now confined to significantly smaller portions of space. In this work it was shown that, as expected, a shorter pulse will lead to a stronger shift in frequency due to a larger $d n \/ d t$ during the short propagation time within the ITO slab, but more interestingly that saturation happens at lower energies for longer pulses. This indicates that the ultimate material response time for short and intense modulation constitutes still an open research question.

Nanostructuring ENZ materials is a powerful strategy to increase the optical field enhancement and lead to efficient ultrafast modulation as demonstrated by Guo et al.'s work~@Guo2016NatCommLarge with ITO nanorods. In this work, the thickness of the medium is 2.6 $mu$ m, a length sufficient to cause significant loss upon propagation. An alternative to nanostructuring the ITO to increase the field enhancement consists of exploiting the plasmonic mode exhibited by flat ENZ thin films~@Vassant2012OptExpBerreman. In Bohn et al.'s work~@Bohn2021NatCommAll, the plasmonic ENZ mode was excited using a Kretschmann configuration, leading to a change in reflectance of 45\%.

While ENZ materials allow for large nonlinear responses and time-modulation, their large refractive index mismatch with air or larger-than-one-index media calls for advanced photonic architectures to ensure efficient coupling as we will address in the next section.

// [figvision-cn] imgs/fig1Experimental-01.png
// 子图 (a) 为示意图，展示泵浦光脉冲 \(I_{pump}(t)\)（橙
// 色曲线）与折射率变化 \(\Delta n(t)\)（蓝色曲线）随时间
// \(t\) 的演化关系。横轴为时间 \(t\)，范围从 -1 ps 到 1
// ps；纵轴未标单位，但表示相对强度或变化量。两条曲线均呈
// 高斯型，峰值位于 t=0 处，\(\Delta n(t)\) 滞后于 \(I_{
// pump}(t)\)，表明折射率响应具有延迟特性。 子图 (b) 为三
// 个并列的示意图，分别对应不同泵浦-探测延迟 \(t_d < 0\)、
// \(t_d \sim 0\)、\(t_d > 0\) 的情况。每个图中包含 ITO
// 层结构，上方标注“Pump”（泵浦光，黑色箭头向下），下方标
// 注“Probe”（探测光，红色或蓝色区域代表光场分布）。在 \(
// t_d < 0\) 时，探测光（红区）位于泵浦光之前；\(t_d \sim
// 0\) 时两者重合；\(t_d > 0\) 时探测光滞后。z 轴垂直向上，
// 指示传播方向。 子图 (c) 至 (f) 均为二维热图（伪彩图），
// 横轴为 Delay (fs)，范围 -200 到 400 fs；纵轴为
// Wavelength (nm)，范围 1250 到 1550 nm。颜色条位于顶部，
// PSD（功率谱密度）从 0（深蓝）到 0.9（深红）。所有子图
// 中均有一条水平虚线标注 “Seed”，位于约 1400 nm 处。 (c)
// 标题 “Phase conjugation”：中心区域（Delay ≈ 0, λ ≈
// 1400–1500 nm）出现强信号（红色），对称分布于 Seed 上下，
// 显示相位共轭特征。 (d) 标题 “Negative refraction”：信
// 号集中在 Delay ≈ 0, λ ≈ 1350–1450 nm，形状倾斜，暗示负
// 折射行为。 (e) 标题 “Reflection”：信号主要分布在 Delay
// > 0 区域，且波长向短波移动（蓝移），反映反射过程中的非
// 线性频移。 (f) 标题 “Transmission”：信号集中于 Delay ≈
// 0, λ ≈ 1350–1450 nm，形态较窄，体现透射光谱特征。 子图
// (g) 为二维热图，横轴 x (nm)，范围 -400 到 400 nm；纵轴
// depth (nm)，范围 0 到 100 nm。右侧色标表示归一化能量密
// 度，从 0（深蓝）到 50（深红）。图中分为三层：底部
// glass（0–~30 nm）、中间 ITO（~30–~70 nm）、顶部 air（>
// ~70 nm）。一个矩形框标注 “antenna”，位于 ITO 层内，x ∈
// [-100, 100] nm, depth ∈ [40, 80] nm。两个白点标记位置
// 1（ITO-air 界面附近）和 2（glass-ITO 界面附近），周围
// 有红色/黄色高能区，显示局域场增强。 子图 (h) 为一维折
// 线图，横轴 depth (nm)，范围 0 到 80+ nm；纵轴
// normalised energy density，范围 0 到 60。背景按材料分
// 区着色：glass（浅黄，0–~30 nm）、ITO（浅蓝，~30–~70 nm）、
// ant.（浅紫，~70–~80 nm）、air（浅粉，>80 nm）。曲线显
// 示能量密度在 ITO 层内急剧上升，在 antenna 区域达到峰值
// （约 55），随后在 air 中衰减。 子图 (i)、(j)、(k) 均为
// 实验数据叠加理论拟合的多重曲线图，布局相同： 左侧 Y 轴：
// Normalized power，无具体数值刻度，仅示意相对幅度。 底
// 部 X 轴：Frequency (THz)，范围 214.1 到 249.8 THz。 右
// 侧 Y 轴：Δt (fs)，范围 -100 到 120 fs，对应每条曲线的
// 延迟时间。 多条彩色曲线（彩虹色系）代表不同 Δt 下的频
// 谱，最外侧两条标注 “Only probe”。 黑色虚线为理论拟合包
// 络，标注振荡频率：(i) 4 THz, (j) 5.7 THz, (k) 6.8 THz。
// 顶部标注泵浦强度：(i) \(I_{pump}=0.5\) GW/cm², (j) \(
// I_{pump}=1\) GW/cm², (k) \(I_{pump}=2\) GW/cm²。 趋势：
// 随着泵浦强度增加，振荡频率升高，且频谱展宽加剧，表明非
// 线性效应增强。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/fig1Experimental-01.png", width: 100%)

  ],
  caption: [
    #strong[\(a,b)] Concept of photocarrier excitation and time-refraction in ITO @miyamaruUltrafast2021. (a) A pump pulse transfers energy to the electrons in the conduction band, leading to a temporal variation in the refractive index. (b) As the probe experiences different indices at different delays, its spectral content will be shifted (redshift for negative delay, blueshift for positive). #strong[\(c-f)] Measured time-refraction, phase conjugation and negative refraction signals from a 500 nm thick AZO slab pumped by 105 fs pulses, at an energy of 770 GW/cm $""^2$ in a degenerate pump-probe experiment at 1400 nm~@tunesiTerahertz2021 #strong[\(g)] Strong coupling between a plasmonic antenna and an ENZ thin film~@stefaniniTemporal2021 electric field $| E |^2$ distribution obtained from FDTD for an ITO layer thickness of 40 nm and Au antenna length of 400 nm. #strong[\(h)] Resulting field distribution as a function of metasurface depth. #strong[\(i-k)] Probe spectrum at various delays for a central wavelength of 1304 nm for 50 fs pulses in a strongly-coupled plasmonic antenna-ENZ system @Pang2021NanoLettAdiabatic.  The increase in modulating pump intensities (0.5, 1 and 2 GW/cm $""^2$) leads to a shift near zero delay. Figures adapted from @Zhou2020NatCommBroadband, @Bruno2020AppSciBroad, @Bruno2020PRLNegative and @Pang2021NanoLettAdiabatic.
  ]
) <fig:expFig1>

=== Hybrid platforms for time-varying experiments <hybrid-platforms-for-time-varying-experiments>

To compensate for the lack of interaction volume in a metasurface, good in-coupling and enhancement of the electric field is necessary to achieve strong nonlinear optical modulation. ENZ material-only metasurfaces lack strong resonant behaviour, and this has prompted the community to include additional elements to achieve efficient time modulation. Well-understood and easy-to-realize, plasmonic-ENZ metasurfaces provide light coupling and local field enhancement to otherwise impedance-mismatched ENZ materials.

Plasmonic nanoantennas couple efficiently propagating radiation to their near-field. When plasmonic resonances are excited, electromagnetic hot-spots form in the surrounding media. For this reason, metallic and more particularly Au nanoantennas have been used to couple light from the far-field to a thin ENZ substrate, where the strong field enhancement leads to efficient nonlinear modulation of the medium. In addition, strong coupling of localized plasmon resonances in Au antennas with the plasmonic modes of an ENZ film can be achieved~@Bruno2020PRLNegative (see @fig:expFig1\(g-h)). The coupled antenna-ENZ thin film enhances the field in the ENZ medium, and strong frequency shifts originating from time-refraction, as well as efficient negative refraction, have been measured from ITO films~@Bruno2020PRLNegative @alamLarge2018 @Liu2021ACSPhotPhoton with a record 11.2 THz frequency shift being recorded at a comparatively low power of 4 GW/cm $""^2$ in Pang et al.'s work~@Pang2021NanoLettAdiabatic \[@fig:expFig1\(i-k)\]. Such time-varying metasurfaces are at the moment limited by the low damage threshold of the plasmonic antennas, the damage threshold of ENZ materials such as ITO or AZO being much higher.

In order to circumvent damage threshold constraints, architectures where the optical field is localized in the ENZ layer only have been explored: Au films can be used as a perfectly conducting layer in the near-IR and IR, beneath the ENZ thin film to increase its coupling to free space. Even though this is an impedance-matching effect, it can be understood as a superposition of the suppression of reflection for p-polarized light at the Brewster angle and the suppression of transmission from the reflective layer. Such a system was used by Yang et al.~@Yang2019NatPhysHigh: a layer of In:CdO with an ENZ frequency at 2.1 $mu$ m exhibited large nonlinearities when illuminated at its Brewster angle, with the 9th harmonic being generated and measured from the metasurface. Time-varying effects are noticeable in the harmonic spectrum, with for example the 5th harmonic exhibiting two peaks: a small one at $5 f$ and a large, time-refracted one 48 THz below arising from the modulation of the index by the pump and the shifted frequencies being upconverted (that is a shift of about 2 THz of the probe signal due to time-refraction).

Hybrid plasmonic-ENZ systems thus present an improvement in realising time-varying metasurfaces using the favorable properties of ENZ materials and other TCOs. This calls for further investigation of the implementation of ENZ properties in other types of metasurfaces, such as the multilayered systems presented in @sec:multilayered.

// [figvision-cn] imgs/fig2Exp-01.png
// 子图(a)为三维结构示意图，展示超表面腔体在硅基底上的结
// 构布局。底层为灰色块状硅（Si）材料，其上覆盖一层薄层氧
// 化铝（Al₂O₃），厚度标注为h。氧化铝层上排列多个深灰色矩
// 形纳米结构单元，沿x方向宽度标注为w_x，沿y方向长度标注
// 为w_y，相邻单元间距标注为g。其中一个单元被半透明彩色热
// 图覆盖，显示电磁场分布：红色区域表示高强度，黄色至蓝色
// 表示强度递减，中心有两个明显的高场强热点。从该单元上方
// 垂直入射一束红色螺旋波形光束，标注频率为ω_L；下方透射
// 出一束紫色螺旋波形光束，标注频率为3ω_L，并附有文字“>3ω
// _L”强调其高于三倍频。右上角嵌入一个2×2的显微照片插图，
// 显示四个实际加工的矩形纳米结构单元，呈灰度图像，边缘清
// 晰，排列整齐。 子图(b)包含三个部分：顶部为示意图，中部
// 左侧为频谱图，右侧为时频演化图。顶部示意图从左到右依次
// 描绘：红色正弦波标注“Pump”，经透镜聚焦后进入标有“
// Metasurface cavity”的浅蓝色矩形腔体，腔内出现蓝绿红三
// 色混合波形，输出端再次经透镜发散，产生三束不同颜色波形
// ——红色标注ω(t)，绿色标注3ω(t)，蓝色标注其他频率成分，
// 箭头指示传播方向。中部左侧图为归一化强度-频率曲线图，
// 横轴为Frequency (ω_L)，范围0.95至1.05，纵轴为Intensity
// (arb. un.)，范围0至1。图中有一条宽峰红色曲线标注“Pump”，
// 峰值位于约1.0处；一条窄尖黑色虚线曲线标注“MS”，峰值位
// 于约1.02处，代表超表面共振模式。中部右侧图为频率-时间
// 演化图，横轴为Time (τ)，范围-2至3，纵轴为Frequency (ω₀
// )，范围0.95至1.05。图中用灰度填充表示能量密度分布：左
// 下角有一个小椭圆区域标注ΔΩ，中心附近有一条S形轨迹线标
// 注ω_in(t)，起始于(τ=-1, ω=1)，上升至(τ≈0.5, ω≈1.04)，
// 随后趋于平缓；右侧有一竖直阴影带标注I_out(ω)，覆盖τ>2
// 区域，对应输出信号的时间窗口。 子图(c)为二维热图，横轴
// 为Pump Probe Delay (fs)，范围-1250至250 fs；纵轴为
// Wavelength (nm)，范围940至990 nm。右侧设有垂直色标条，
// 从黑到白对应数值0.5至1.0，代表相对强度或对比度。图中主
// 体为一组同心圆弧状条纹，圆心大致位于(-750 fs, 965 nm)
// 附近，条纹由内向外逐渐变淡，最内圈接近白色（强度~1.0），
// 外圈渐变为深灰色（强度~0.5）。整体呈现随泵浦-探测延迟
// 增加，特定波长处的响应发生周期性振荡衰减的趋势，暗示非
// 线性动力学过程中的相干激发与退相干行为。 子图(d)为三维
// 空间传播示意图，底部为黄色平面基板上规则排列的绿色立方
// 体阵列，构成超表面结构。坐标系标注：x轴水平向右，y轴垂
// 直纸面向里，z轴竖直向上。一束蓝色箭头光束从左上斜向入
// 射，标注频率ω，击中表面一点；从此点发出两束反射/衍射光：
// 一束绿色箭头向左上方，标注ω−Δω和“Fwd”；另一束红色箭头
// 向右上方，标注ω−2Δω和“Bkwd”。表面叠加一条粉红色正弦波
// 形曲线，表示相位调制函数φ(x,t)=Δφcos(Δωt−k_M x)+k_z x，
// 其中k_M为空间调制波矢，k_z为纵向波矢。右侧另有一粉色箭
// 头指向右方，标注“Spatiotemporal modulation”，表明整个
// 系统存在时空联合调制机制。所有元素共同说明通过时空调制
// 实现多阶频率转换及方向选择性辐射的过程。
#pagebreak(weak: true)
#figure(placement: top, [#image("imgs/fig2Exp-01.png", width: 100%)

  ],
  caption: [
    #strong[\(a)] Schematic of an Si metasurface engineered to support collective high-Q Fano resonances~@Husko2009APLUltrafast #strong[\(b)] Schematic of the self-induced blue shift of harmonics in the resulting Si nanoantenna cavity: photons in the antenna will undergo a blueshift due to the rapidly changing permittivity of the medium before being upconverted via third-harmonic generation. #strong[\(c)] Measured spectrum evolution for a 80 fs pump pulse length in a GaAs high-$Q$ metasurface~@Shcherbakov2015NanoLettUltrafast @Makarov2015NanoLettTuning @DellaValle2017ACSPhotNonlinear. The fringes are measured on only one side of the spectrum due to the breaking of time-reversal asymmetry caused by the modulation. (d) Schematic of a nonreciprocal Si metasurface~@Shcherbakov2017NatCommUltrafast the travelling wave modulation breaks the space-time symmetry of the reflection phase change. Figures adapted from @Shcherbakov2019NatCommPhoton, @Karl2020NanoLettFrequency and @Guo2019LightSciAppNonreciprocal.
  ]
) <fig:expFig2>

=== High-index dielectric metasurfaces as time-varying media <high-index-dielectric-metasurfaces-as-time-varying-media>

In the quest for resonant-enhanced materials for time-modulation, high-index dielectrics provide an alternative to ENZ structures, as they offer possibilities for various resonant architectures and a high damage threshold. More in particular, nanoantennas with Mie resonances or bound states in the continuum allow for strong time-modulation by combining efficient coupling to the active medium and a good field enhancement. That is because even though $Delta n \/ n$ is low in a high-index dielectric, the change of phase of the metasurface can be strong when the material is modulated near a resonance. Shifts in the resonance of a photonic crystal~@Husko2009APLUltrafast were demonstrated, as well as in Mie-resonant systems, in a range of materials ranging from Si~@Shcherbakov2015NanoLettUltrafast @Makarov2015NanoLettTuning @DellaValle2017ACSPhotNonlinear to GaAs~@Shcherbakov2017NatCommUltrafast, GaP~@Grinblat2020SciAdvEfficient and Ge~@Lemasters2021AdvOptMatDeep. GaAs and Si exhibited stronger modulation efficiencies as they feature a direct band gap in the visible to near-IR region, while Si relies on intraband transitions, less efficient for this class of materials @Shcherbakov2017NatCommUltrafast.

Time-refraction was observed both in Si~@Shcherbakov2019NatCommPhoton and GaAs~@Karl2020NanoLettFrequency high-$Q$ nanoantenna metasurfaces. Shcherbakov et al.~@Shcherbakov2019NatCommPhoton reported a 8.3 THz shift in the third harmonic signal from a Si metasurface with a collective Fano resonance as shown in @fig:expFig2\(a), i.e. around 2 THz shift in the self-modulated pump signal. As depicted in @fig:expFig2\(b) this is explained by the upconversion to third harmonic of the time-refracted pump field, with the change of index of the nanoantenna cavity originating from the pump itself as well. This is a smaller shift than the best results achieved with combined plasmonic antenna-ENZ systems, but comparable to what was achieved in bulk ITO~@Liu2021ACSPhotPhoton and In:CdO on Au~@Yang2019NatPhysHigh. It is also worth noting that the system operates at 11 GW/cm $""^2$, underlining the higher damage threshold of dielectric antennas in comparison to plasmonic antennas.

Though high-index dielectric antennas exhibit higher damage threshold and provide more flexibility thanks to the tunability of the resonances by nanostructuring, as opposed to bulk ENZ properties, the interplay between the width of the resonance and that of the modulating pulse must be considered carefully. The higher the $Q$ factor, the stronger the potential for a modulation as the field enhancement is higher at resonance, yet if the duration of the modulating optical pulse is made shorter than the resonance lifetime, in order to accelerate the modulation and obtain stronger time-varying effects, its spectral content will exceed the resonance bandwidth and only a modest portion will interact. This calls for nondegenerate pump-probe experiments to show the full-potential of time-varying media: Karl et al.~@Karl2020NanoLettFrequency recorded the clear appearance of fringes in the probe spectrum due to time-varying effects as shown in @fig:expFig2\(c), by independently controlling the pump pulse length via pulse chirping and the spectral content of the probe via spectral filtering of a supercontinuum pulse.

One can also take advantage of the phase-shift induced by a high-index nanoantenna array: Guo et al.~@Guo2019LightSciAppNonreciprocal demonstrated nonreciprocal light reflection in a Si nanobar metasurface. To this end, a spacetime modulation was induced by the interference and beating of two pump beams with a 6 nm difference in central wavelength and a nonreciprocal frequency shift was measured from the reflection of the forward and backward-propagating probe \[@fig:expFig2\(d)\].

Thanks to their strong, tunable resonances, high-index dielectric metasurfaces have proven to be a reliable platform for time-varying experiments. Although third-order nonlinearities in these materials are weaker than in ITO or AZO, and nanostructuring puts a lower cap on damage threshold and interaction volume, these metasurfaces bring concurrence to ENZ media thanks to the maturity of nanoantenna fabrication technology and the control of the scattering phase enabled by such systems.

== New leads for time-varying metasurfaces <new-leads-for-time-varying-metasurfaces>

It is clear that better and more efficient material platforms for time-varying media are sought after and will likely appear in the near future, to allow for more efficient modulations, larger bandwidth, and higher damage thresholds. In this final section we identify a few promising candidates, namely quantum well polaritons, magneto-optical modulation, multilayered ENZ metamaterials and 2D materials, exhibiting the potential to enhance time-modulation effects and we discuss their respective strengths and weaknesses.

=== Quantum well polaritons <quantum-well-polaritons>

Mann et al.~@Mann2021OpticaUltrafast showed in 2021 the pulse-limited modulation of intersubband polaritonic metasurfaces, using the coupling between patch antennas and intersubband transitions in multi-quantum wells (MQWs). The antenna resonance matches the transition dipole moment of the MQWs, which leads to Rabi splitting at low intensities. As the intensity increases, the ground state is depleted, which induces a change in coupling and absorption properties. The system operates at intensities between 70 kW/cm$""^2$ and 700 kW/cm$""^2$, with a change in absorption of order of unity at the antenna resonant frequency. Though the change in reflection is quite weak at such powers (at best 8\% here), it is worth noting that the intensities here are much lower than those used in other nonlinear optical experiments for time-modulation. On the other hand, the recovery time is dictated by the relaxation time of the excited state of the MQWs, here of 1.7 ps. In comparison, the modulation recovery time in unsaturated ITO is 360 fs~@Alam2016ScienceLarge.

=== Magneto-optical modulation <magneto-optical-modulation>

Though the mutual effects of electric and magnetic fields are quite weak, one can consider using the magneto-optical Kerr effect (MOKE) or Faraday effect (MOFE) to achieve ultrafast time-dynamics and thus time-varying physics in a magnetic medium. MOKE (MOFE) consists in the rotation of reflected (transmitted) light by a magnetic field~@Maccaferri2020JofAppPhyNanoscale @Kirilyuk2010RevModPhysUltrafast. A first stone was laid when Beaurepaire et al.~@Beaurepaire1996PRLUltrafast showed in 1996 sub-ps switching of spin in ferromagnets using a MOKE configuration. Ultrafast spin switching was demonstrated without magnetic fields using a circularly-polarized optical pulse~@Kimel2005NatureUltrafast, exploiting the dynamics of the inverse Faraday effect. Particularly, Stanciu et al.~@Stanciu2007PRLAll demonstrated a 40 fs all-optical switching of magnetization. Though in this experiment the origin of the switching was finally found out to be originating from the heating of the medium by the laser pulses, Mangin et al.~@Mangin2014NatMatEngineered later showed helicity-dependent switching in various magnetic media, independently of the threshold switching temperature of the medium. This opened a new path towards ultrafast magnetic memory writing and other applications of optical switching of magnets.

Experiments involving the use of a magnetic field use a common figure of merit, the $delta$ parameter, defined as the percentage change of reflection when the magnetisation is reversed. That is, for a magnetic field $bold(M)$ and a reflection $R$, $delta = [ R ( bold(M) ) - R ( -bold(M) ) ] \/ R ( bold(0) )$. This value is usually quite low in bulk ferromagnetic thin films, ranging from $10^(-5)$ to $10^(-3)$. Nanostructuring can help increase this figure of merit: the coupling of surface plasmon polaritons from an Au grating to a ferromagnetic substrate allows for a stronger MOKE effect~@Belotelov2011NatNanoEnhanced, leading to a $delta$ parameter of up to 24\ %@Belotelov2013NatCommPlasmon. In other works, plasmonic antennas in a magnetic field were used to control the transmission of chiral light~@Zubritskaya2017NanoLettMagnetic, and dielectric nanoantennas were engineered via their electric and magnetic Mie resonances to achieve large Faraday rotation~@Christofi2018OptLettGiant. Yet, these time-modulations of the medium linked to the value of $delta$ do require a switching of the magnetisation, which happens on a much slower scale (100 ps to ns~@Zubritskaya2017NanoLettMagnetic @Landau1935PZSOn) than the optical modulation from the MOKE itself. Hence, the ultrafast aspect of the modulation may only come from the rotation of the polarisation of light at a given, fixed magnetisation.

In a parallel stream of research, ultrafast spin currents have been excited in magnetized thin films and heterostructures using optical pulses, paving the way for THz emitter technologies~@Kampfrath2010NatPhotCoherent.~@Huisman2016NatNanoFemtosecond. Photocurrents were generated on a timescale of 330 fs in Huisman et al.'s work~@Feng2021JofAppPhySpintronic. As the magnetic field does not require switching and can be maintained constant, the modulation can be considered as entirely optical and ultrafast. Qiu et al. demonstrated similar spin current generation in an antiferromagnetic slab in the absence of magnetic field~@Qiu2020NatPhysUltrafast, thanks to second-order optical nonlinearities. For a more detailed review of THz emitters and wave generation the authors recommend the review by Feng et al.@Feng2021JofAppPhySpintronic. While the potential of magneto-optical effects for ultrafast phenomena has been demonstrated, their translation into the framework of time-varying media remains unexplored, which calls for a new push in investigations and experiments in this direction.

=== Multilayered metamaterials <sec:multilayered>

Multilayered metal-dielectric structures are of great interest thanks to their tunability to different regimes via fabrication, such as ENZ or hyperbolic. In addition, their simple architecture for fabrication is well-understood from effective-medium theory~@Orlov2014PhotNanoControlling. Artificial ENZ metamaterials exhibiting Dirac cone-like dispersion~@Moitra2013NatPhotRealization or multilayered thin films make valuable candidates for time-varying experiments, as they exhibit the favorable ENZ physics, are tunable and have the potential to exploit other meta-properties, e.g. good coupling to far-field radiation. Sub-ps modulation of the effective permittivity of a multilayered Au/TiO#sub[2] metamaterial was demonstrated by Rashed et al.~@Rashed2020PRBHot. In parallel, enhancement of nonlinear properties around the ENZ frequency of a multilayered Ag/SiO#sub[2]~@Suresh2020ACSPhotEnhanced, as well as ultrafast modulation of absorption~@Acharyya2021AdvMatIntUltrafast were reported. This enhancement is explained by the dependence of the effective third-order nonlinear susceptibility on the inverse of the medium's effective index, which reaches a minimum in the vicinity of the multilayered structure's ENZ frequency. In a similar spirit, ultrafast modulation of a metal-insulator-metal nanocavity was observed around the low-energy ENZ point~@Kuttruff2020CommPhyUltrafast, but it was found that the switching speed was limited by the carrier density and heat capacity of the metal. The authors suggested the use of TCO-dielectric structures to accelerate the electron dynamics of the process and achieve faster modulation. Alternatively, multilayered ENZ metamaterials can be used to pin down and control the plasmonic resonance of coupled antennas depending on the ENZ frequency~@Habib2020NanoControlling, with optical modulation allowing for control of the antenna resonance via the multilayered substrate.

In a different paradigm, multilayered metal-dielectric antennas have been engineered to support ultra-small mode volumes~@Indukuri2019ASCNanoUltrasmall, and in this way couple light efficiently to a WS#sub[2] monolayer~@Indukuri2020ASCAppNanoMattWS2 WS#sub[2] and 2D materials are a promising class of media for time-varying experiments as we discuss in the following section. Although monolayers feature properties favorable to modulation, their intrinsic atomic-scale thickness limits their coupling to light: hyperbolic metamaterials such as a multilayered metal-dielectric antenna can overcome this barrier and boost optical modulation. Furthermore, efficient second and third harmonic generation was measured from multilayered Au/SiO#sub[2] nanoantennas~@Maccaferri2021ACSPhotEnhanced. The efficiency of the second harmonic was proved to originate from the multiple metal-dielectric interfaces rather than symmetry-breaking, allowing for a polarisation-independent implementation of multilayered antennas.

To sum up, multilayered ENZ metamaterials constitute promising candidates for time-varying experiments as they exhibit ultrafast modulation and strong nonlinear properties, while offering options for nanostructuring and resonance engineering.

=== 2D materials <sec:2dmaterials>

A modern topic in nanophotonics, 2D materials exhibit many interesting properties including high refractive index and ease of nanostructuring~@Verre2019NatNanoTransition, unconventional band structure and carrier dynamics such as Dirac cones~@Castro2009RevModPhysThe, and excitonic physics as well as ultra-high carrier mobility~@Schaibley2016NatRevMatValleytronics, resulting in strong optical nonlinearities useful for material modulation~@You2018NanoNonlinear @Yu2017AdvMat2D. Transition metal dichalcogenides (TMDs), black phosphorus (BP) and graphene feature sub-ps carrier excitation times~@Poellmann2015NatMatResonant @Pogna2016ACSNanoPhoto @Wang2016ACSNanoUltrafast in single layer structures. In particular, TMDs offer excitonic resonances with short recombination times, while monolayer BP exhibits a tunable direct band gap from the visible to the mid-IR. Additionally, BP's anisotropic response has also been shown to undergo modulation under laser excitation~@Ge2015NanolettDynamical.

TMDs exhibit a variety of useful properties for optical modulation~@Autere2018AdvMatNonlinear, with monolayer and low-dimensional TMDs exhibiting stronger nonlinear properties than their bulk counterparts. In Nie et al.'s work~@Nie2014ACSNanoUltrafast, a 10 fs pulse of about 1 GW/cm$""^2$ was shown to excite photocarriers in 20 fs in low-dimensional MoS#sub[2], though the change in transmission was only of 0.8\%. Large second and third-order nonlinearities have also been measured in low dimensional MoS#sub[2]~@Kumar2013PRBSecond @Saynatjoki2017NatCommUltra, MoSe#sub[2]~@Le2016AdPNonlinear, WS#sub[2]~@Janisch2014SciRepExtraordinary @Torres20162DMatThird and WSe#sub[2]~@Ribeiro_20152DMatSecond, as well as strong tunability of the refractive index in WSe#sub[2], MoSe#sub[2] and MoS#sub[2]~@Wang2015PhotResTunable. Additionally, the strong nonlinear properties in MoSe#sub[2] can be exploited thanks to the comparatively high damage threshold of the monolayer as demonstrated by Tam et al.~@Le2016AdPNonlinear. Ultimately, applications are limited by the low-dimensionality of these materials which leads to small interaction volume and short interaction time. On the other hand, nanostructuring can again be used to enhance the response from these systems: enhanced light-matter interaction has been shown in monolayers coupled with plasmonic nanoantennas~@Kern2015ACSPhotNanoantenna @Spreyer2020NanoSecond @Chen2019AppMatToResonance as well as with a Si waveguide~@Chen2017LightSciAppEnhanced. Nonlinear antennas built from bulk TMDs could also provide a platform for time-varying experiments in the same fashion as GaAs or Si~@Busschaert2020ACSPhotTransition. Another alternative would be van der Waals heterostructures, stacked layers of TMDs which have also exhibited short rise times of about 50 fs~@Hong2014NatNanoUltrafast @Ceballos2014ACSNanoUltrafast, with no dependence of the response time on the twisting angle between layers~@Wang2016ACSNanoInterlayer @Zhu2017NanoLettInterfacial. More information on the specific spin and valley dynamics at the origin of the ultrafast dynamics in van der Waals heterostructures can be found in Jin et al.'s review~@Jin2018NatNanoUltrafast.

== Outlook <outlook>

All-optical implementations of time-varying metasurfaces are of great interest for the creation of new miniaturized technologies for the control of light both in space and time. ENZ materials such as ITO and AZO, along with high-index dielectrics, have proven to be solid platforms for time-varying experiments and will surely be the ground for more complex investigations. These nanophotonic architectures can boost both light coupling to the nonlinear medium and field enhancement. Multilayered ENZ metamaterials could provide new solutions to the practical problems posed by the nature of more classical time-varying systems, such as resonance-engineering or high permittivity contrast. New materials and systems could pave the way for further development of time-varying experiments, expanding the spectral range of operation, increasing the efficiency and the damage threshold. Quantum well polaritons and monolayer 2D materials could exhibit time-varying effects at lower energies, while magneto-optical effects would open a new framework including time-varying magnetic effects, which are ignored in current nonlinear optical experiments.

= Conclusions <conclusions>

In this Review Article, we have presented a comprehensive overview of photonic time-varying media. We started by reviewing the basic phenomenological and mathematical considerations rooted in the behaviour of Maxwell's Equations in the presence of temporal material discontinuities, discussing the main directions of ongoing research on electromagnetic time-switching for several applications such as time-reversal, energy manipulation, frequency conversion, bandwidth enhancement and wave routing, amongst many others. We then continued our discussion to consider photonic time-crystals, discussing the basic phenomenology underlying periodic time-scattering and parametric amplification to develop an insight which we deployed in addressing more advanced instances of time-modulation in particular for topological physics, non-Hermitian systems and disorder, concluding with some brief remarks on time-modulated surfaces. We then extended our discussion to combinations of spatial and temporal degrees of freedom, providing an overview of the basic properties of space-time crystals, and their application to nonreciprocity, as well as the engineering of synthetic motion and its applications to optical drag and giant bianisotropic responses, highlighting the concept of luminal amplification and spatiotemporal localization as a new form of wave amplification physically distinct from the conventional parametric gain, and concluding with an overview of the wealth of opportunities and applications for space-time metasurfaces. Finally, we reviewed some of the most successful materials and paradigms for experimental realizations of time-varying effects in the visible and IR, indicating some of the most promising avenues recently unveiled for future optical experiments with time-varying media. While the latter undoubtedly constitute the greatest long-term challenge for this rising field of research, we believe that, as in many other instances of scientific enquiry, the quest for time-varying photonic systems will prove a prolific one from both the point of view of unveiling fundamentally novel wave phenomena and for revealing new and unexpected windows of opportunity for technological advancement.

#heading(level: 2, numbering: none)[Acknowledgments]
<acknowledgments>
E.G. acknowledges funding from the Engineering and Physical Sciences Research Council via an EPSRC Doctoral Prize Fellowship (Grant No. EP/T51780X/1) and a Junior Fellowship of the Simons Society of Fellows (855344,EG). P.A.H. and M. S. acknowledge funding from Fundação para a Ciência e a Tecnologia and Instituto de Telecomunicações under project UIDB/50008/2020 and the CEEC Individual program from Fundação para a Ciência e a Tecnologia with reference CEECIND/02947/2020. R.S. J.P. and S.V. acknowledges funding from the Engineering and Physical Sciences Research Council (EP/V048880). J.P. acknowledges funding from the Gordon and Betty More Foundation. A.A., S.Y. and H.L. acknowledge funding from the Department of Defense, the Simons Foundation and the Air Force Office of Scientific Research MURI program.

#v(0.8em)
#text(12pt, weight: "bold")[References]
#v(0.3em)
#show bibliography: set par(spacing: 1em)
#bibliography("refs.bib", style: "ieee", title: none)
