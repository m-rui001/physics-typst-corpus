// ---- supplemental figures and table (from src/anc/supplement.tex) ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 11pt, lang: "en")
#set page(
  paper: "us-letter",
  numbering: "S1",
  margin: (x: 2.2cm, y: 2.2cm),
)
#set par(justify: true)
#set heading(numbering: "S.1")
#set figure(numbering: n => "S" + str(n))
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set text(size: 9pt)

#align(center)[
  #text(size: 14pt, weight: "bold")[
    An Improved Measurement of Neutrino Oscillation Parameters by the NOvA Experiment
  ]
  #v(0.2em)
  #text(size: 14pt, weight: "bold")[--]
  #v(0.2em)
  #text(size: 14pt, weight: "bold")[Supplemental Figures]
]

#v(1.5em)

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    image("imgs/supp/nd_numu_fourpanel_fhc.pdf", width: 100%),
    image("imgs/supp/nd_numu_fourpanel_rhc.pdf", width: 100%),
  ),
  caption: [
    Reconstructed $nu_mu$ CC energy spectra at the ND shown separately for each quartile of reconstructed hadronic energy fraction, in the neutrino beam on the left and the antineutrino beam on the right.
    These samples are used to predict the FD $nu_mu$ CC spectra in @fig:fd-data-figure_supp below.
    The spectra are shown with the simulation normalized to the same exposure as the data, and the systematic error band includes all systematic uncertainties.
  ],
) <fig:nd-data-figure_supp>

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    image("imgs/supp/fd_numu_fourpanel_fhc.pdf", width: 100%),
    image("imgs/supp/fd_numu_fourpanel_rhc.pdf", width: 100%),
  ),
  caption: [
    Reconstructed $nu_mu$ CC energy spectra at the FD shown separately for each quartile of reconstructed hadronic energy fraction, in the neutrino beam on the left and the antineutrino beam on the right.
    The samples shown here, along with the $nu_e$ CC FD samples in Fig.~4, are fit together to extract the oscillation parameters.
  ],
) <fig:fd-data-figure_supp>

#figure(
  [
    (a) #image("imgs/supp/contour_joint_realData_both_onlyNO_dmsq_systs_th23_dm32_NO_fccorr_smooth_zoom.pdf", width: 85%)
    #v(0.6em)
    (b) #image("imgs/supp/contour_joint_realData_both_onlyIO_dmsq_systs_th23_dm32_IO_fccorr_smooth_zoom.pdf", width: 85%)
  ],
  caption: [
    The $1 sigma$, $2 sigma$, and $3 sigma$ FC corrected contours in $Delta m_32^2$ vs. $sin^2 theta_23$ in the (a) normal ordering (NO) and (b) inverted ordering (IO).
    The parameters $delta_("CP")$ and $sin^2 2 theta_13$ are profiled over.
    The best-fit point is shown by a black marker.
  ],
) <fig:dsmq-ssth23-figure_supp>

#figure(
  [
    (a) #image("imgs/supp/contour_joint_realData_both_onlyNO_systs_delta_th23_NO_fccorr_smooth_zoom.pdf", width: 85%)
    #v(0.6em)
    (b) #image("imgs/supp/contour_joint_realData_both_onlyIO_systs_delta_th23_IO_fccorr_smooth_zoom.pdf", width: 85%)
  ],
  caption: [
    The $1 sigma$, $2 sigma$, and $3 sigma$ FC corrected contours in $sin^2 theta_23$ vs $delta_("CP")$ in the (a) normal ordering and (b) inverted ordering (IO).
    The parameters $Delta m_32^2$ and $sin^2 2 theta_13$ are profiled over.
    The best-fit point is shown by a black marker.
  ],
) <fig:dcp-ssth23-figure_supp>

#figure(
  image("imgs/supp/slice_joint_realData_both_systs_fccorr_smooth.pdf", width: 85%),
  caption: [
    Significance of rejection for each value of $delta_("CP")$, under different assumptions of mass ordering and the $sin^2 theta_23$ octant.
    FC corrections are applied and the parameters $Delta m_32^2$, $sin^2 theta_23$, and $sin^2 2 theta_13$ are profiled over.
    Zero significance denotes the best-fit point.
  ],
) <fig:dcp-figure_supp>

#figure(
  image("imgs/supp/slice_joint_realData_both_systs_dmsq_fccorr_smooth.pdf", width: 85%),
  caption: [
    Significance of rejection for each value of $Delta m_32^2$ under different assumptions of mass ordering and the $sin^2 theta_23$ octant.
    FC corrections are applied and the parameters $delta_("CP")$, $sin^2 theta_23$, and $sin^2 2 theta_13$ are profiled over.
    Zero significance denotes the best-fit point.
  ],
) <fig:dmsq-figure_supp>

#figure(
  image("imgs/supp/slice_joint_realData_both_systs_th23_noOct_fccorr_smooth.pdf", width: 85%),
  caption: [
    Significance of rejection for each value of $sin^2 theta_23$, under different assumptions of mass ordering.
    FC corrections are applied and the parameters $delta_("CP")$, $Delta m_32^2$, and $sin^2 2 theta_13$ are profiled over.
    Zero significance denotes the best-fit point.
  ],
) <fig:ssth23-figure_supp>

#pagebreak()

#figure(
  align(center)[
    #table(
      columns: (auto, auto, auto, auto, auto),
      align: (left, center, center, center, center),
      stroke: none,
      table.header(
        table.cell(rowspan: 2)[Parameter],
        table.cell(colspan: 2)[Normal ord.],
        table.cell(colspan: 2)[Inverted ord.],
        [UO], [LO], [UO], [LO],
      ),
      table.hline(),
      [$Delta m_32^2 (10^(-3) "eV"^2)$], [$+2.41_(-0.07)^(+0.07)$], [$+2.39_(-0.05)^(+0.06)$], [$-2.45_(-0.06)^(+0.06)$], [$-2.44_(-0.05)^(+0.06)$],
      [$sin^2 theta_23$], [$0.57_(-0.04)^(+0.03)$], [$0.46_(-0.03)^(+0.03)$], [$0.56_(-0.03)^(+0.04)$], [$0.46_(-0.03)^(+0.03)$],
      [$delta_("CP") (pi)$], [$0.82_(-0.87)^(+0.27)$], [$""^(*) 0.07_(-0.26)^(+0.30)$], [$1.52_(-0.30)^(+0.27)$], [$1.41_(-0.22)^(+0.18)$],
      table.hline(),
      [Rejection significance], [-], [$1.1 sigma$], [$0.9 sigma$], [$1.1 sigma$],
      table.hline(),
    )
  ],
  caption: [
    Summary of oscillation parameter best-fit results for different choices of the mass ordering (Normal or Inverted) and upper or lower $theta_23$ octant (UO, LO), along with the FC corrected significance (in units of $sigma$) at which those combinations are disfavored.
    $""^(*)$For the normal ordering LO fit of $delta_("CP")$, the range 0.84--1.10$pi$ also lies below $1 sigma$, as can be seen in @fig:dcp-figure_supp.
    However, the errors stated below only consider the range which contains the best-fit point for this ordering and octant fit.
  ],
  kind: table,
) <tb:oscillation_parameters_table_errs>
