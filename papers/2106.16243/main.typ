#set heading(supplement: [Sect.])
#show figure.where(kind: figure): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure(supplement: [Table])
#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 5.50cm, right: 5.50cm, top: 2.00cm, bottom: 2.40cm), columns: 1)
#set page(numbering: none, header-ascent: 15pt, header: context {
  if counter(page).get().first() > 1 {
    grid(columns: (1fr, auto),
      text(10pt)[nEXO: 0νββ search beyond $10^28$ year half-life sensitivity],
      align(right, text(10pt, counter(page).display())))
  }
})
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.83em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(14.3pt, weight: "bold", [nEXO: Neutrinoless double beta decay search beyond $10^"28"$ year half-life sensitivity])
  #v(1.2em)
  #text(8.8pt)[
    G Adhikari#super[1], S Al Kharusi#super[2], E Angelico#super[3], G Anton#super[4], I J Arnquist#super[5], I Badhrees#super[6]#super[a], J Bane#super[7], V Belov#super[8], E P Bernard#super[9], T Bhatta#super[10], A Bolotnikov#super[11], P A Breur#super[12], J P Brodsky#super[9], E Brown#super[13], T Brunner#super[2,21], E Caden#super[14]#super[b], G F Cao#super[15]#super[c], L Cao#super[16], C Chambers#super[2], B Chana#super[6], S A Charlebois#super[17], D Chernyak#super[18], M Chiu#super[11], B Cleveland#super[14]#super[§], R Collister#super[6], S A Czyz#super[9], J Dalmasson#super[3], T Daniels#super[20], L Darroch#super[2], R DeVoe#super[3], M L Di Vacri#super[5], J Dilling#super[21,22], Y Y Ding#super[15], A Dolgolenko#super[8], M J Dolinski#super[23], A Dragone#super[12], J Echevers#super[19], M Elbeltagi#super[6], L Fabris#super[24], D Fairbank#super[25], W Fairbank#super[25], J Farine#super[14]#super[§], S Ferrara#super[5], S Feyzbakhsh#super[7], Y S Fu#super[15], G Gallina#super[21,22], P Gautam#super[23], G Giacomini#super[11], W Gillis#super[7], C Gingras#super[2], D Goeldi#super[6], R Gornea#super[6], G Gratta#super[3], C A Hardy#super[3], K Harouaka#super[5], M Heffner#super[9], E W Hoppe#super[5], A House#super[9], A Iverson#super[25], A Jamil#super[26], M Jewell#super[3]#super[d], X S Jiang#super[15], A Karelin#super[8], L J Kaufman#super[12], I Kotov#super[11], R Krücken#super[21,22], A Kuchenkov#super[8], K S Kumar#super[7], Y Lan#super[2], A Larson#super[27], K G Leach#super[28], B G Lenardo#super[3], D S Leonard#super[29], G Li#super[15], S Li#super[19], Z Li#super[15], C Licciardi#super[14]#super[§], R Lindsay#super[30], R MacLellan#super[10], M Mahtab#super[22], P Martel-Dion#super[17], J Masbou#super[31], N Massacret#super[22], T McElroy#super[2]#super[e], K McMichael#super[13], M Medina Peregrina#super[2], T Michel#super[4], B Mong#super[12], D C Moore#super[26], K Murray#super[2], J Nattress#super[24], C R Natzke#super[28], R J Newby#super[24], K Ni#super[1], F Nolet#super[17], O Nusair#super[18], J C Nzobadila Ondze#super[30], K Odgers#super[13], A Odian#super[12], J L Orrell#super[5], G S Ortega#super[5], C T Overman#super[5], S Parent#super[17], A Perna#super[14], A Piepke#super[18], A Pocar#super[7], J-F Pratte#super[17], N Priel#super[3], V Radeka#super[11], E Raguzin#super[11], G J Ramonnye#super[30], T Rao#super[11], H Rasiwala#super[2], S Rescia#super[11], F Retière#super[22], J Ringuette#super[28], V Riot#super[9], T Rossignol#super[17], P C Rowson#super[12], N Roy#super[17], R Saldanha#super[5], S Sangiorgio#super[9], X Shang#super[2], A K Soma#super[23], F Spadoni#super[5], V Stekhanov#super[8], X L Sun#super[15], M Tarka#super[7], S Thibado#super[7], A Tidball#super[13], J Todd#super[25], T Totev#super[2], S Triambak#super[30], R H M Tsang#super[18], T Tsang#super[11], F Vachon#super[17], V Veeraraghavan#super[18], S Viel#super[6], C Vivo-Vilches#super[6], P Vogel#super[33], J-L Vuilleumier#super[34], M Wagenpfeil#super[4], T Wager#super[25], M Walent#super[14], K Wamba#super[35], Q Wang#super[16], W Wei#super[15], L J Wen#super[15], U Wichoski#super[14]#super[§], S Wilde#super[26], M Worcester#super[11], S X Wu#super[3]#super[f], W H Wu#super[15], X Wu#super[16], Q Xia#super[26], W Yan#super[15], H Yang#super[16], L Yang#super[1], O Zeldovich#super[8], J Zhao#super[15] and T Ziegler#super[4]
  ]
  #v(0.8em)
  #text(7pt)[
    #super[1] Physics Department, University of California, San Diego, CA 92093, USA \
    #super[2] Physics Department, McGill University, Montréal, Québec H3A 2T8, Canada \
    #super[3] Physics Department, Stanford University, Stanford, CA 94305, USA \
    #super[4] Erlangen Centre for Astroparticle Physics (ECAP), Friedrich-Alexander University Erlangen-Nürnberg, Erlangen 91058, Germany \
    #super[5] Pacific Northwest National Laboratory, Richland, WA 99352 USA \
    #super[6] Department of Physics, Carleton University, Ottawa, Ontario, K1S 5B6, Canada \
    #super[7] Amherst Center for Fundamental Interactions and Physics Department, University of Massachusetts, Amherst, MA 01003, USA \
    #super[8] Institute for Theoretical and Experimental Physics named by A. I. Alikhanov of National Research Center Kurchatov Institute, Moscow, 117218 Russia \
    #super[9] Lawrence Livermore National Laboratory, Livermore, CA 94550, USA \
    #super[10] Department of Physics and Astronomy, University of Kentucky, Lexington, KY 40506, USA \
    #super[11] Brookhaven National Laboratory, Upton, NY 11973-5000, USA \
    #super[12] SLAC National Accelerator Laboratory, Menlo Park, CA 94025-1003 USA \
    #super[13] Department of Physics, Applied Physics and Astronomy, Rensselaer Polytechnic Institute, Troy, NY 12180 USA \
    #super[14] Department of Physics and Astronomy, Laurentian University, Sudbury ON, P3E 2C6 Canada \
    #super[15] Institute of High Energy Physics, Chinese Academy of Sciences, Beijing, 100049 China \
    #super[16] Institute of Microelectronics of the Chinese Academy of Sciences, Beijing 100029, China \
    #super[17] Université de Sherbrooke, Sherbrooke, Québec J1K 2R1, Canada \
    #super[18] Department of Physics and Astronomy, University of Alabama, Tuscaloosa, AL 35405, USA \
    #super[19] Physics Department, University of Illinois, Urbana, IL 61801, USA \
    #super[20] Department of Physics and Physical Oceanography, University of North Carolina Wilmington, Wilmington, NC 28403, USA \
    #super[21] Department of Physics and Astronomy, University of British Columbia, Vancouver, BC V6T 1Z1, Canada \
    #super[22] TRIUMF, Vancouver, BC V6T 2A3, Canada \
    #super[23] Department of Physics, Drexel University, Philadelphia, PA 19104 USA \
    #super[24] Oak Ridge National Laboratory, Oak Ridge, TN 37831 USA \
    #super[25] Physics Department, Colorado State University, Fort Collins, CO, 80523, USA \
    #super[26] Wright Laboratory, Department of Physics, Yale University, New Haven, CT 06511 USA \
    #super[27] Department of Physics, University of South Dakota, Vermillion SD 57069 USA \
    #super[28] Department of Physics, Colorado School of Mines, Golden, CO 80401, USA \
    #super[29] IBS Center for Underground Physics, Daejeon, 34126 Korea \
    #super[30] Department of Physics and Astronomy, University of the Western Cape, P/B X17 Bellville 7535, South Africa \
    #super[31] SUBATECH, IMT Atlantique, CNRS/IN2P3, Université de Nantes, Nantes 44307, France \
    #super[33] California Institute of Technology, Pasadena, CA 91125 USA \
    #super[34] LHEP, Albert Einstein Center, University of Bern, 3012 Bern, Switzerland \
    #super[35] Skyline College, San Bruno CA 94066, USA
  ]
  #v(0.5em)
  #text(7pt)[
    #super[a] Permanent at: King Abdulaziz City for Science and Technology, Riyadh, Saudi Arabia \
    #super[b] Also at: SNOLAB, Ontario, Canada \
    #super[c] Also at: University of Chinese Academy of Sciences, Beijing, China \
    #super[d] Now at: Yale University, Connecticut, USA \
    #super[e] Now at: University of Alberta, Alberta, Canada \
    #super[f] Now at: Canon Medical Research USA \
    #super[§] Corresponding authors: sangiorgio1\@llnl.gov and caio.licciardi\@snolab.ca
  ]
]
#v(1.6em)


#strong[The nEXO neutrinoless double beta ($0 nu beta beta$) decay experiment is designed to use a time projection chamber and 5000~kg of isotopically enriched liquid xenon to search for the decay in $""^(136) "Xe"$. Progress in the detector design, paired with higher fidelity in its simulation and an advanced data analysis, based on the one used for the final results of EXO-200, produce a sensitivity prediction that exceeds the half-life of $10^"28"$ years. Specifically, improvements have been made in the understanding of production of scintillation photons and charge as well as of their transport and reconstruction in the detector. The more detailed knowledge of the detector construction has been paired with more assays for trace radioactivity in different materials. In particular, the use of custom electroformed copper is now incorporated in the design, leading to a substantial reduction in backgrounds from the intrinsic radioactivity of detector materials. Furthermore, a number of assumptions from previous sensitivity projections have gained further support from interim work validating the nEXO experiment concept. Together these improvements and updates suggest that the nEXO experiment will reach a half-life sensitivity of $1.35 times 10^"28"$~yr at 90\% confidence level in 10 years of data taking, covering the parameter space associated with the inverted neutrino mass ordering, along with a significant portion of the parameter space for the normal ordering scenario, for almost all nuclear matrix elements. The effects of backgrounds deviating from the nominal values used for the projections are also illustrated, concluding that the nEXO design is robust against a number of imperfections of the model.]
#v(1.2em)

#pagebreak()
#set page(margin: (left: 2.11cm, right: 2.33cm, top: 2.24cm, bottom: 2.24cm), columns: 2, header-ascent: 19pt)

= Introduction <sec:intro>

Neutrinoless double beta ($0 nu beta beta$) decay is an undiscovered hypothetical process in which a nucleus with mass $A$ and charge $Z$ undergoes the decay $(A, Z) -> (A, Z + 2) + 2 e^-$ without emission of neutrinos~@PhysRev.56.1184. The search for $0 nu beta beta$ decay is considered one of the most sensitive tests of the Majorana nature of neutrinos~ @PhysRev.56.1184 @doi:10.1142-S0218301311020186. The observation of $0 nu beta beta$ decay would open a portal to new physics beyond the Standard Model by providing the first direct evidence for the violation of lepton number conservation, with possible implications for our understanding of the observed baryon asymmetry in the universe~ @Fukugita:1986hr @Rubakov_1996 @PhysRevD.98.055029 @leptogenesis. Under the standard assumption that the decay is mediated by a light Majorana neutrino, the discovery of the decay would help constrain the absolute neutrino mass scale since the experimentally observable $0 nu beta beta$ decay half-life ($T^(0 nu)_(1/2)$) is inversely proportional to the square of the effective Majorana neutrino mass $angle( m_(beta beta) )$~@Avignone:2007fu.

$""^(136) "Xe"$, one of the even-even nuclei with energetically forbidden $beta$ decay~@Zyla:2020zbs, is an attractive nuclide for a $0 nu beta beta$ decay search due to several reasons. A $0 nu beta beta$ signal would be a collection of events with topology consistent with double-$beta$ decays, homogeneously distributed in the detector, uncorrelated in time with other interactions, and with an average energy consistent with the known $Q$-value of the decay. Since the $""^(136) "Xe"$ double-$beta$ decay energy is $Q_(beta beta) = 2458.10 plus.minus 0.31$~keV~ @PhysRevLett.98.053003 @McCowan:2010zz, it is large compared to $Q$ values of many natural radioactive decays. As a noble gas, it can be made largely free of radioactive contamination through repeated purification. In addition, isotopic separation of $""^(136) "Xe"$ from the 8.9\% natural concentration is relatively inexpensive and has already been carried out at the tonne scale~@zencollaboration2021nylon. While uncertainties still exist in the estimates of nuclear matrix elements (NMEs)~ @Caurier2008 @Rodriguez2010 @Suhonen2010 @Simkovic2013 @Mustonen2013 @Meroni2013 @Vaquero2013 @Engel2014 @Hyvaerinen2015 @Barea2015 @Yao2015 @Horoi2016 @Menendez2018 @Simkovic2018 @Jokiniemi2018 @Fang2018 @Deppisch2020, that govern the $0 nu beta beta$ decay process, the product of the squared NME and phase space factor is expected to be favorable for $""^(136) "Xe"$ in comparison to some other candidate nuclides, such that the sensitivity per unit mass to the underlying physics places it among the top contenders for large scale detectors~@Biller:2021bqx.

The success of the 100-kg scale EXO-200 experiment~ @PhysRevC.89.015502 @PhysRevLett.109.032505 @EXO_Nature @PhysRevLett.120.072701 @PhysRevLett.123.161802 validates using large liquid xenon (LXe) time projection chambers (TPCs) for the search of $0 nu beta beta$ decay. This technique provides a large homogeneous mass of the required isotope with three-dimensional event vertex reconstruction and well understood energy resolution. EXO-200 was the first experiment to observe two-neutrino double-$beta$ decay ($2 nu beta beta$) in $""^(136) "Xe"$~@PhysRevLett.107.212501. EXO-200 then precisely measured its half-life of $(2.165 plus.minus 0.016 ("stat") plus.minus 0.059 ("syst")) times 10^21$~yr~@PhysRevC.89.015502, and set stringent constraints on the $0 nu beta beta$ decay process, limiting the half life to $T^(0 nu)_(1/2) > 3.5 times 10^25$~yr at 90\% confidence level (CL), with corresponding sensitivity of $5.0 times 10^25$~yr using an exposure of 234.1~kg⋅yr~@PhysRevLett.123.161802. Compared to other candidate systems, a LXe TPC offers the further advantage that the active material can be recirculated, and hence its purity can be improved with time.

The advantages of the LXe TPC have a greater impact on the experiment as the detector size increases, and the tonne-scale nEXO detector has been designed to exploit these advantages, reaching a $T^(0 nu)_(1/2)$ sensitivity beyond $10^28$~yr with 5000~kg of xenon enriched to 90\% $""^(136) "Xe"$~@nEXOpCDR. Following its predecessor, nEXO will simultaneously measure the signals from both the scintillation light and from the drifting ionization, combining the two to obtain three-dimensional "images" of the energy depositions. Event reconstruction topology forms the basis of discrimination between double-$beta$ decay events and background events which are mainly gamma-induced signals. In a LXe medium the former generally have energy concentrated in one spatial location, or site, with the events distributed uniformly throughout the detector volume, while the latter result in energy deposited in multiple sites, with event rate decreasing exponentially toward the center of the detector due to attenuation in the dense LXe. Internal $alpha$ backgrounds are tagged and eliminated based on their larger track ionization density which results in a large scintillation-to-ionization ratio compared to $beta$-like events. The energy measurement makes use of the anticorrelation~@PhysRevB.20.3486 between scintillation and ionization signals by independent measurements of these quantities~@PhysRevB.68.054201, obtaining a resolution that allows the rejection of the $2 nu beta beta$ decay background to negligible levels for the sensitivities of interest here.

In an initial analysis~@PhysRevC.97.065503, nEXO was shown to reach a $0 nu beta beta$ sensitivity of $9.2 times 10^27$~yr when using a multi-parameter analysis similar to that featured in early analyses of EXO-200 data~ @EXO_Nature @PhysRevLett.120.072701. This report presents an improved sensitivity estimate, applying a more realistic model that reflects advances in the design and understanding of the nEXO performance obtained through ongoing R&D~ @nEXOpCDR @PhysRevC.97.065503 @Li_2019 @Nakarmi_2020 @Jamil:2018tkx @Gallina:2019fxt @Ostrovskiy:2015oja @Wagenpfeil:2019qri @stiegler2020event @NJOYA2020163965. It also includes improved knowledge of the ionization and scintillation production in LXe at MeV energies~@PhysRevC.101.065501 and increased sensitivity in material assay measurements. We also incorporate a deep neural network (DNN) developed to discriminate between signal and background events, following the work done by EXO-200 for their $0 nu beta beta$ decay search using their complete dataset~@PhysRevLett.123.161802. The refined geometrical design of nEXO and its implementation in Monte Carlo (MC) simulations are introduced in @sec:geometry. @sec:simulation describes the MC procedure to simulate and reconstruct nEXO events as well as the development of a $0 nu beta beta$ DNN discriminator. The expected background budget is then discussed in @sec:materials. The discovery potential and half-life sensitivity of nEXO to $0 nu beta beta$ decay are presented in @sec:sensitivity and final results are summarized in @sec:conclusion.


= Refined Geometric Design <sec:geometry>

// [figvision] figures/cryopit-v2.png
// The figure shows a schematic of the Geant4 geometry implementation for MC simulations of the nEXO detector.
// The drawing depicts a cross-section view of the large components external to the TPC vessel. Panel a: This is
// a schematic diagram. The axes are not labelled but the horizontal axis represents the radial distance and the
// vertical axis represents the height. The ranges of the axes are not specified. The objects shown are the
// Underground Lab Wall, Access Tunnel, Support Structure, Outer Vessel, Inner Vessel, TPC Vessel, and a person
// for scale. The layout shows the Support Structure above the Outer Vessel, which is above the Inner Vessel and
// TPC Vessel, all surrounded by Water. The trend shows the large scale layout of the nEXO detector components.
// No series, colours, symbols or line styles are used. Annotations and labels include the names of the objects.
// The message is that this is a large detector with multiple components.
// [figvision] figures/tpc-rendering.png
// The figure shows a schematic of the nEXO detector's Time Projection Chamber (TPC) vessel. The plot is a
// cross-section view of the large components external to and inside the TPC vessel. There are no axes or units
// shown. The main components are: Charge Tiles (green), Charge Tiles Support, SiPMs, SiPM Staves, Field Shaping
// Rings (white), Support Rods and Spacers, and Cathode (purple). The objects and their connections show the
// layout of the detector's internal components. The trend shows the organization and structure of the TPC
// vessel's internal components. However, since there are only one panel in this figure, I will describe it as
// given. The figure is a schematic. There are no axes or units shown on the plot. The main components are:
// Charge Tiles (green), Charge Tiles Support, SiPMs, SiPM Staves, Field Shaping Rings (white), Support Rods and
// Spacers, and Cathode (purple). The drift length is 118.3 cm. The objects and their connections show the layout
// of the detector's internal components. The trend shows the organization and structure of the TPC vessel's
// internal components.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  set text(size: 8pt)
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [*Table #context it.counter.display(it.numbering).* #it.body]
}

#figure(placement: top, scope: "parent", 
  [
    #image("figures/cryopit-v2.png", width: 45%)
    #h(1em)
    #image("figures/tpc-rendering.png", width: 45%)
  ],
  caption: [Visualization of the Geant4 geometry implementation for MC simulations of the nEXO detector. The drawing on the left shows a cross-section view of the large components external to the TPC vessel, including the OD's water and SNOLAB's Cryopit wall. The model on the right shows a close up view of the main components inside the TPC vessel.],
) <fig:g4_geometry>

As shown on the left side of @fig:g4_geometry, the design of the nEXO detector~@nEXOpCDR consists of a TPC vessel filled with enriched LXe and surrounded by ∼33,000~kg of HFE-7000~@HFE-7000, which serves as both thermal bath and radiation shield. A vacuum layer between an inner vessel (IV) and an outer vessel (OV) of the cryostat provides thermal insulation from an active water shield, referred to as the outer detector (OD). Updated dimensions in the TPC vessel and drift region represent the most significant difference in the current geometry with respect to that employed in previous studies~@nEXOpCDR @PhysRevC.97.065503.

In the current design, the TPC vessel is a right copper cylinder with both inner height and diameter equal to 127.7~cm. This represents a small reduction in size compared to @PhysRevC.97.065503, and corresponds to a total mass of 4811~kg of contained LXe when accounting for the volume displaced by internal components and using a density of 3.057~g/cm$""^3$ for the enriched xenon. The total drift length between the cathode and the anode is 118.3~cm as indicated on the right side of @fig:g4_geometry. At the anode, located on the top end of the TPC, charge is collected by 0.6~cm pitch and 9.6~cm long crossed electrode strips arranged as a large array of $9.6 times 9.6$~cm$""^2$ interconnected readout tiles filling the top face of the TPC. A detailed description of the anode is provided in Ref.~@nEXOpCDR @Jewell:2017dzi. The advantage in background discrimination from employing a smaller pitch than that between strips is outweighed by the benefits of reducing the number of digitizing channels by a factor of two, resulting in a significant reduction of cost and mass of readout cabling~@Li_2019.

Electrostatic modeling of the TPC was performed to ensure that the electric field remains below a maximum allowed strength everywhere to prevent breakdown. To achieve 400~V/cm electric field within the field cage region, we require gaps between the vessel end and cathode of 7.5~cm, as well as 7.2~cm spacing between the barrel surface of the xenon vessel and the field shaping rings (FSRs). In this volume, VUV-sensitive silicon photomultipliers (SiPMs) positioned in a "barrel" configuration detect LXe scintillation light. A smaller 1.9~cm gap between the anode and the top of the vessel is provided to accommodate electronics and cabling with sufficient mechanical clearance. The inner radius of the FSRs is 56.7~cm, yielding a fully active TPC LXe mass of 3648~kg. The remaining volume, where only the scintillation light but no ionization from LXe interactions is detected, is referred to as the "skin" Xe region~@stiegler2020event.

#figure(
  table(
    columns: 2,
    stroke: (x, y) => if y == 0 or y == 1 { (top: 0.5pt, bottom: 0.5pt) },
    table.header([*Description*], [*Value*]),
    [Liquid xenon mass in vessel], [4811~kg],
    [Liquid xenon mass in drift region], [3648~kg],
    [Fiducial xenon mass], [3281~kg],
    [TPC drift height], [118.3~cm],
    [TPC drift diameter], [113.3~cm],
    [TPC vessel height], [127.7~cm],
    [TPC vessel diameter], [127.7~cm],
    [Inner vessel diameter\*], [338~cm],
    [Outer vessel diameter\*], [446~cm],
    [Water Tank height], [13.3~m],
    [Water Tank diameter], [12.3~m],
  ),
  caption: [Main dimensions of the nEXO geometry. The two cryostat dimensions marked with a \* indicate values that were not changed from the previous analysis~@PhysRevC.97.065503.],
) <tab:key_params>

Dimensional specifications for the SiPMs and charge readout tiles, as well as for their support structures and electronics are adjusted to the slightly smaller vessel size, along with other minor design adjustments. @tab:key_params summarizes the corresponding primary dimensions. The geometry implemented in MC simulations, built using Geant4 v10.4~@AGOSTINELLI2003250 @1610988 @ALLISON2016186 and described in more detail in Ref.~@PhysRevC.97.065503, has been updated to match these dimensions as specified in the latest engineering model. As described below, we have also added components outside the TPC vessel that were not included in the previous work. The result is the detailed representative model of the experiment shown in @fig:g4_geometry. A full list of the simulated components accounted for in the nEXO background model is discussed in @sec:materials.

The MC geometry now includes the high voltage (HV) feedthrough and two tubes within the HFE-7000 volume that are designed to bring calibration sources near the outside of the TPC vessel. The support structure for both IV and OV have been implemented along with realistic attachments and feedthroughs, and with thicknesses matching recent engineering estimates. In particular, we added additional 0.2~cm and 0.3~cm thick titanium internal liners to both the IV and OV, respectively. They provide the winding mandrel for the carbon-fiber composite (CFC) employed in these vessels. For the IV, the liner also doubles as an adsorption barrier for the HFE-7000. In the model, the liners are made of titanium but other materials are also under consideration. All of these components are modeled as both passive radioactive background shields and background sources through dedicated simulations of decays in the materials. Background contributions from electronics cables, running along the vessel structures outside of the TPC vessel, were found to be negligible, and hence are not included in the simulation.

The OD geometry presented here has been designed for installation in the Cryopit at SNOLAB. The OD consists of a water tank enclosing the OV that serves two purposes: to shield against external radiation, and to tag the passage of nearby muons, which allows for vetoing of cosmogenically-induced events in the TPC. Our MC simulations indicate that a minimum diameter of 11~m and a height of 12~m results in enough water shielding to sufficiently reduce background contributions from the cavern rock and concrete, and to produce nearly maximal muon tagging efficiency when photomultiplier tubes (PMTs) are mounted on the tank wall and used to read out the Cherenkov light in the water. The simulated nEXO geometry contains a water tank, 12.3~m in diameter and 13.3~m in height, which is compatible with the current dimensions of the Cryopit.

= Event Simulation and Reconstruction <sec:simulation>

This work improves the fidelity of the expected detector response to scintillation photons and direct ionization produced in LXe. Electronic waveforms produced by the charge signals are simulated in detail, as well as the reconstructed event energy and topology. The simulation takes into account generation of charge carriers and scintillation photons, their propagation in LXe, and electronic signals captured by readout. We then use the simulated signals and reconstructed energies to determine the event parameters that are input to the $0 nu beta beta$ sensitivity analysis.

== Ionization/scintillation anticorrelation in LXe <sec:anticorr>

A custom version of the Noble Element Simulation Technique (NEST)~@Szydagis:2011tk calculates the number of electrons ($N_Q$) and scintillation photons ($N_P$) produced in each simulated energy deposit in the LXe. These values are stored in a list of hits, along with their generated positions.

NEST version 2.0.1~@nest2.0.1 was modified to correct interface issues with Geant4. Furthermore, two adjustments were made in the model to attain better agreement with EXO-200 results~@PhysRevC.101.065501. First, NEST 2.0.1 included an excess noise correlation in the total number of created electrons and photons (i.e. an inflated Fano factor), which lacked physical motivation and did not agree with the noise model determined by EXO-200. It was therefore removed for this analysis, later versions of NEST incorporated this change. Second, the NEST photoelectric model is replaced by the NEST beta/Compton model which is used for all recoil electron processes. This conforms with EXO-200 results which observed no significant difference in yields between $beta$ decays and photoelectric interactions at energies relevant for nEXO.

While light and charge yields in the fully active TPC region are only mildly affected by these changes, we noticed that regions with high electric field, such as in the skin Xe, are substantially impacted. The electric field used in the modified NEST calculations is considered to be uniform in six different regions of the LXe as indicated in @tab:voltage_regions. Edge regions, where the electric field is not expected to be uniform, are either discarded in the analysis or represent a negligible fraction of the total volume, so that the uniform approximation does not affect the final results.

Some lack of fidelity is expected in the regions outside of the field cage, because the currently available data interpolated in NEST does not reach sufficiently high field values. The skin region has electric fields that vary from 0~V/cm near the anode to over 8000~V/cm near the cathode. While EXO-200 data is used to establish light and charge yields in the 400~V/cm field in the TPC, these data only extend to 600~V/cm and do not reach the higher fields present in the skin region. For this study, the light and charge yields were fixed to their values at 600~V/cm for all greater values of the field. This approach was chosen in order to be conservative, as it leads to slightly higher backgrounds compared to models in which the yields continue to decrease with electric field beyond 600~V/cm. Future work will evaluate the yield dependence at higher field values, which has been reported to be small but nonzero ~@PhysRevB.20.3486 @Doke:1988rq. This could slightly reduce backgrounds compared to this study's model.

#figure(
  table(
    columns: 3,
    [], table.cell(colspan: 2, [Radial Position]),
    [], [Inside FSR], [Outside FSR],
    [Above anode], [0 V/cm], [0 V/cm],
    [Between anode #linebreak and cathode], [400 V/cm], [Linear from #linebreak 0 to 8084 V/cm],
    [Below cathode], [6667 V/cm], [8084 V/cm],
  ),
  caption: [Electric field settings used in NEST's calculations of charge and light yield in the LXe for inside and outside the field shaping rings (FSRs).],
) <tab:voltage_regions>

== Charge signal detection <sec:charge>

The simulation of the charge waveforms follows from the successful procedure in EXO-200 and has been validated in recent R&D data. It starts by modeling the drift of each ionization hit from its initial position to the charge readout strips at the anode. The electrons are drifted at a fixed velocity of 0.171~cm/μs, appropriate for the nominal electric field of 400~V/cm. The corresponding transverse and longitudinal diffusion coefficients, measured in Refs.~@PhysRevC.95.025502 @NJOYA2020163965, are used to appropriately broaden the charge distribution in the $x$, $y$, and $z$ dimensions. Diffusion is applied before binning the electrons into cubic voxels used to calculate the induced charge on each electrode as a function of time~@Li_2019. Charge attenuation depends on the drift distance and assumes an electron lifetime of $tau_e = 10$~ms. The waveforms are simulated for all strips with charge collection as well as for channels within a distance of 1.8~cm to a charge collection strip, prior to adding electronics noise.

// [figvision] figures/waveform_display5.png
// The figure has one panel. It is a plot with a circular boundary showing a top view, with a grid overlay and
// squares outlined by dotted lines representing charge readout tiles. The axes are X and Y coordinates in
// centimeters, ranging from -80 to 80. There are three series of strips: red for collection, blue for
// induction-only, and green for noise. The trend shows a multi-site event with energy deposits in three tiles,
// indicated by red, blue, and green strips and waveforms, with the inset showing the current waveform display.
// The message indicates charge collection, induced charge without collection, and noise triggering the
// reconstruction algorithm.
#figure(placement: top, 
  image("figures/waveform_display5.png", width: 80%),
  caption: [Top view of the charge readout tiles (squares outlined by dotted lines) and current waveform display (inset) showing a multi-site event with energy deposits in three tiles. The red strips and waveforms indicate charge collection, blue strips and waveforms represent induced charge without collection, and the green waveforms only contain noise that triggers the reconstruction algorithm.],
) <fig:charge_waveforms>

The frequency spectrum of the noise in the charge electronics, as determined in recent R&D with prototype ASICs, is sampled and added to the waveform after transformation into the time domain. The resulting charge waveform is converted into a time series of the current. A Bessel filter with a cut-off frequency of 300~kHz is then applied to reproduce the analog anti-aliasing filter in the electronics, and the result is down-sampled to the 2~MHz sampling rate of the nEXO electronics design. The simulated current noise is scaled to have an equivalent RMS value as deduced from simulations of the front-end electronics at the nominal design specifications. More details about the waveform simulation can be found in Ref.~@Li_2019. @fig:charge_waveforms shows the simulated waveforms for an example multi-site event with all energy deposits localized in three charge tiles.

A fiducial volume (FV) selection is applied to the position of the outermost energy deposit of each event in the TPC, reconstructed from information of the charge collected in each strip. To reconstruct the $z$ position, the event start time is subtracted from the charge waveform peak timing and the difference is converted into a distance using the fixed electron drift velocity. The outermost energy deposit is found by scanning along the $x$ and $y$ coordinates of strips which collect charge at matching $z$ positions to find the outermost position. Each event is required to have at least one strip hit in both $x$ and $y$, reducing the $0 nu beta beta$ detection efficiency by 3.6\%. The spatial resolution obtained for such deposits is better than the 0.6~cm pitch of the charge-sensing strips in all three dimensions. The relative distance between a deposit and the nearest surface (#emph[i.e.]) the FSRs, the cathode, or the anode planes) is referred to as the event's #emph[standoff distance]. Electric field simulations set a minimum standoff distance of 2~cm required for an event to be within the uniform field, which is also a sufficient condition to reject $beta$ particles from decays on the surface of the nearest components to the FV. With this choice of FV, the LXe mass included in the $0 nu beta beta$ analysis is 3281~kg.

The number of electrons detected in each event is calculated using information from the charge waveforms in a simplified algorithm that retains only the main features of this process, described as follows. The true charge collected on all strips is summed up, corrected for the electron lifetime attenuation, and Gaussian noise with $sigma_Q = 1130$~$e^-$ is added, resulting in the corrected charge of the event ($tilde(N)_Q$). The choice for the electronic noise is an average value obtained from a MC study using simulated waveforms from $0 nu beta beta$ decays. In this study, a trapezoidal filter with optimal integration time was employed to improve the charge energy resolution, which was then used to deduce the equivalent average noise corresponding to this resolution, $sigma_Q$.

== Scintillation energy <sec:scint>

In order to simulate the number of scintillation photons detected for each event, the light collection efficiency $epsilon_("ell")(r,z)$ was calculated as a function of the radial ($r$) and longitudinal ($z$) initial position inside the detector. $epsilon_("ell")(r,z)$ is the product of the photon transport efficiency (PTE), that depends on the initial position, and the photon detection efficiency (PDE) of the SiPMs. In Refs.~@nEXOpCDR @PhysRevC.97.065503, light propagation in the nEXO detector has been studied using Geant4. Photons were generated by point-like isotropic sources in the LXe and tracked through the TPC. Optical photon propagation in Geant4 is computationally expensive. An alternative approach was therefore employed using Chroma running on CUDA-enabled GPUs~@Seibert2011FastOM @chroma, making light propagation simulations up to 300 times faster. Geometries were directly imported into Chroma from standard CAD software allowing an exact remake of the detector geometry without much simplifications.

The optical parameters that are used as input for the simulations have been refined, leveraging recent measurements, and are summarized in @tab:optical_parameters. The LXe index of refraction was calculated using the approach in Ref.~@Hitachi which is in agreement with measurements~@SOLOVOV2004462. Measurements of the absorption ($lambda_"abs"$) and Rayleigh scattering ($lambda_"scat"$) lengths at $175$~nm wavelength~@FUJII2015293, with sufficient sensitivity for the light propagation model, are difficult to obtain. Other large LXe detectors assume $lambda_"abs"$ to be the values 30~m~@Mount:2017qzi and 50~m~@Aprile:2015uzo. Here we conservatively assume $lambda_"abs" = 20$~m that should be easily achieved given the much higher LXe purity imposed by the electron drift requirements and the extrapolation from Ref.~@Baldini:2004ph. Likewise, we conservatively assume $lambda_"scat" = 30$~cm, as supported by Refs.~@SOLOVOV2004462 @Virdee:1991rv @CHEPEL1994500.

#figure(
  table(
    columns: 2,
    table.header([*Parameter*], [*Value*]),
    [LXe refractive index], [1.69],
    [LXe $lambda_"abs"$], [20~m],
    [LXe $lambda_"scat"$], [30~cm],
    [$R_S$(TPC Vessel)], [0\%],
    [$R_S$(Cathode)], [80\%],
    [$R_S$(Anode)], [20\%],
    [$R_S$(Field Rings)], [80\%],
    [$R_S$(Support Rods)], [0\%],
    [$R_S$(SiPM Staves)], [0\%],
    [$R_S$(SiPMs) [$15^degree < theta < 45^degree$]], [25\% - 28\%~@Nakarmi_2020],
  ),
  caption: [Optical parameters and reflectivity values used in the LXe optical simulations.],
) <tab:optical_parameters>

Two surface models are implemented and used for optical simulations depending on the component. A basic model is used for all non-detecting surfaces, including the FSRs, cathode, anode, FSR support rods, SiPM staves and TPC vessel. At the surface of these components, the photon interaction is determined by their coefficients of specular reflectivity ($R_S$) and absorption, while the diffuse reflectivity is always set to zero (the latter being a conservative assumption). In order to increase light collection, the cathode and FSRs components feature a reflective $"Al" + "MgF"_2$ coating with a conservative 80\% specular reflectivity~@vuv_mirror2. The angular dependence of such coatings has been studied using FreeSnell~@freesnell, a thin film optical simulator, and was estimated to be only different by ∼10\% at large angles of incidence compared to a flat 80\% specular reflectivity. For the anode, composed of the gold-plated charge readout tiles, a 20\% specular reflectivity was adopted based on measurements of the intrinsic reflectivity of gold at 175~nm~@doi:10.1063-1.3243762.

// [figvision] figures/pte_vs_reflectivity.png
// The figure contains a single plot. The plot shows Photon Transport Efficiency (PTE) as a function of the
// specular reflectivity of the cathode and the FSRs. The y-axis ranges from 0 to 50% and the x-axis from 0 to
// 100%. There are two series: one with black circles labeled "This work" and another with orange diamonds
// labeled "nEXO pre-CDR". A grey band indicates a systematic error. A vertical dotted line marks 85%
// reflectivity. The trend shows PTE increasing with reflectivity, with "This work" having higher PTE than "nEXO
// pre-CDR" across the range.
#figure(placement: top, 
  image("figures/pte_vs_reflectivity.png", width: 80%),
  caption: [Spatial average PTE inside the fiducial volume as a function of the specular reflectivity of the cathode and the FSRs. The current light simulation results with updated optical parameters (black circles) are compared against results from previous simulations (orange diamonds)~@nEXOpCDR. The grey band indicates a systematic error due to the choice of SiPMs and light simulator. The reflectivity value used in the simulations for this work is indicated by the vertical dotted line.],
) <fig:pte>

// [figvision] figures/lightmap.png
// The figure is a 2D plot showing the Photon Transport Efficiency (PTE) as a function of radial and longitudinal
// positions in the nEXO detector. The x-axis represents the radius in millimeters, ranging from 0 to 600 mm. The
// y-axis represents the longitudinal position, Z, in millimeters, ranging from 0 to 1200 mm. The color bar on
// the right side indicates the PTE as a percentage, ranging from 0% to 50%. The plot is a gradient of colors,
// with purple at the edges (0%) and yellow-green in the center (up to 50%). There are no symbols or line styles,
// but there are dotted blue lines indicating the detector's components. The trend shows that the PTE is higher
// in the center of the detector and lower at the edges. The message is that the PTE varies with position in the
// detector, with the highest efficiency in the center.
#figure(placement: top, 
  image("figures/lightmap.png", width: 80%),
  caption: [Light map of the nEXO detector showing the probability of photons reaching the avalanche region of the SiPMs, #emph[i.e.], the PTE as function of the radial, $r$, and longitudinal, $z$, positions in the detector. TPC components such as the FSRs, the anode and cathode are clearly visible due to their high opacity.],
) <fig:lightmap>

At the detecting SiPM surface, the surface model incorporates recent measurements of the reflectivity and relative PDE as a function of the incidence angle in LXe~@Nakarmi_2020 @Wagenpfeil:2021ynz. The nEXO collaboration is undertaking an extensive campaign for characterizing SiPMs from different vendors to determine the optimal candidate that meets stringent requirements in terms of PDE, correlated avalanche rate, dark noise rate, capacitance per unit area and intrinsic radiopurity ~@nEXOpCDR @Ostrovskiy:2015oja @Jamil:2018tkx @Gallina:2019fxt. In particular, recent results indicate that both the FBK VUV-HD1~@Jamil:2018tkx and Hamamatsu VUV4~@Gallina:2019fxt satisfy such requirements. In order to evaluate the impact of using these different SiPMs, full light propagation simulations were run with each, as well as with different sets of reflectivity data. For each set of SiPM candidate and measured reflectivity data the average PTE within the FV was calculated as a function of reflectivity of the cathode and FSRs. @fig:pte shows the average over all these simulations. The gray band is an error calculated by adding the standard deviation across simulations with different SiPMs and the difference between Chroma and Geant4 of 1.8\% in quadrature. The expected average PTE for nEXO in the current design with 80\% reflectivity on the cathode and FSRs is 33.3(20)~\%. For the MC simulations, we use a conservative PTE lightmap, shown in @fig:lightmap, produced using $5 times 10^11$ photons and the Hamamatsu VUV4 SiPM parameters, which presents the lowest $"PDE" / (1 - R)$ value of 18.6\% as corrected for the reflectivity at near normal incidence in vacuum. This is done to prevent double-counting the effect of reflectivity when combining the PDE and PTE to estimate the total light collection efficiency $epsilon_("ell")(r,z)$. While the PTE is observed to change by about a factor of two between the anode and the center of the LXe volume, the absolute difference in the post-correction energy resolution of $0 nu beta beta$ events between these two regions was found to be only ∼0.1\%.

The corresponding $epsilon_("ell")(r,z)$ from @fig:lightmap is applied to each scintillation hit ($epsilon_"ell"^"hit"$) in an event, and a binomial distribution with $N_P$ trials and $epsilon_"ell"^"hit"$ probability is used to determine the number of detected photons: $N_P^"hit" tilde B (N_P, epsilon_"ell"^"hit")$. The contribution from correlated avalanches, in which a photon-induced avalanche in one cell of a SiPM can induce an avalanche in a neighboring cell, is modelled by a Poisson distribution: $N_Lambda^"hit" tilde "Pois"(Lambda dot N_P^"hit")$, where $Lambda = 0.2$ is the total number of correlated avalanches per avalanche in a time window of 1~μs, conforming with recent measurements~@Jamil:2018tkx @Gallina:2019fxt. The same measurements also show that the dark count rate and other electronics noise can be completely neglected. Therefore, the total number of scintillation photons triggering an avalanche in each event ($N_P^"evt"$) is the sum of $N_P^"hit"$ and $N_Lambda^"hit"$ for all hits. The number of reconstructed photons ($tilde(N)_P$) in each event is obtained by the correction $tilde(N)_P = N_P^"evt" / epsilon_"ell"^"evt" / (1 + Lambda)$, where $epsilon_"ell"^"evt"$ is the energy-weighted average of all $epsilon_"ell"^"hit"$. The position and energy information in this correction are retrieved from the scintillation hits generated by NEST. An additional systematic error due to imperfect knowledge of $epsilon_"ell"^"evt"$ has been added and is assumed to be a 0.5\% relative error. Based on our energy resolution model this is the value below which its contribution to the rotated energy resolution can be considered subdominant. Additional work to better understand position-dependent variations and the resulting requirements for the detector calibration will be part of future studies.

== Energy resolution <sec:eneres>

// [figvision] figures/charge_vs_light.png
// Panel (a) is a two-dimensional histogram or scatter plot showing the relationship between Reconstructed Light
// {N}_{L} (y-axis, range 40 to 160, units 10^{3}) and Reconstructed Charge {N}_{Q} (x-axis, range 40 to 160,
// units 10^{3}). The plot features a colour gradient from blue to red, indicating the density or frequency of
// events, with red being the highest density. Two dashed red lines intersect the plot diagonally, and a solid
// black line with an arrow at each end, labelled "Total energy (keV)", spans from the bottom left to the top
// right, with tick marks at 1400, 2000, 2540, and 3030. The trend shows a positive correlation between {N}_{L}
// and {N}_{Q}, with a concentrated region of high-density events. There is no panel (b) or (c) provided in the
// description.
#figure(placement: top, 
  image("figures/charge_vs_light.png", width: 80%),
  caption: [Reconstructed light and charge signals of all events in the FV from simulated $""^(232) "Th"$ decays in the TPC vessel. The dashed lines indicate the location of the diagonal cut, described in the text. The rotated axis indicates the scale of the rotated energy.],
) <fig:charge_light_cut>

@fig:charge_light_cut shows the spectrum of the reconstructed number of generated photons, $tilde(N)_P$, versus that of the electrons, $tilde(N)_Q$, for simulated $""^(232) "Th"$ decays in the TPC vessel. While the well-known anticorrelation between light and charge signals is clearly visible for the $gamma$ lines, an excess of events with abnormally large light-to-charge ratio is present. This effect is discussed in detail in Ref.~@stiegler2020event, and is caused by events that deposit some energy in the skin Xe. These events can be removed from the analysis using a diagonal cut, shown by the dashed lines, since the distribution of light-to-charge ratio is expected to be approximately a Gaussian around the mean ratio. Using simulated $gamma$-rays from $""^(208) "Tl"$ and $""^(40) "K"$ decays with a single energy deposit inside the field cage, this cut was designed to keep 99\% of events, #emph[i.e.], within 2.57$sigma$ from the mean of the distribution, and was validated with simulated $0 nu beta beta$ events, resulting in a signal efficiency of 99.7\%. This slightly larger-than-expected efficiency is attributed to the topology of $0 nu beta beta$ events, which are more localized than the $gamma$ events used to produce the cut. This is the same reason why events in the figure appear slightly off-centered from the diagonal lines, closer to the top line. The tail at the 2615~keV $""^(208) "Tl"$ peak arises from the cascade of $gamma$ rays in that specific decay and interactions in the skin LXe. These events are not expected to impact the $0 nu beta beta$ sensitivity because the tail is at high energies and does not contribute at energies near $Q_(beta beta)$.

// [figvision] figures/energy_res_all_ALL.png
// The figure shows a plot of normalized counts versus energy in keV. The x-axis ranges from 2000 to 3000 keV and
// the y-axis ranges from 10^-4 to 10^0. There are three series: a grey series representing 0 with _E/E = 0.8\%,
// a blue series representing ^{238}U with _E/E = 0.8\%, and an orange series representing ^{232}Th with _E/E =
// 0.9\%. The plot shows broad peaks for ^{238}U and ^{232}Th and a smaller peak for 0. Vertical dashed lines
// indicate the expected center of the peaks and solid lines show their Gaussian fits. The trend shows the energy
// spectra of simulated events for different decays.
#figure(placement: top, 
  image("figures/energy_res_all_ALL.png", width: 80%),
  caption: [Rotated energy spectra of all simulated events in the FV from $0 nu beta beta$ decays and $""^(232) "Th"$ and $""^(238) "U"$ decays on the TPC vessel. The vertical lines indicate the expected center of the peaks while the solid lines show their Gaussian fits. The resolutions are calculated by the fitted $sigma_E / E$. The three spectra are normalized to have the same maximum value.],
) <fig:energy-resol>

The event energy is calculated by $E = (tilde(N)_P + tilde(N)_Q) dot W_q$, where $W_q$ is the average energy to create a single quantum of either charge or light. This approach is equivalent to a $-45^degree$ projection of the event energies onto the rotated energy axis shown in @fig:charge_light_cut, which is nearly optimal for the expected noise in nEXO. @fig:energy-resol shows the rotated energy for simulated events from $""^(232) "Th"$ and $""^(238) "U"$ decays in the TPC vessel as well as from $0 nu beta beta$ decays in the LXe. The energy resolution extracted at the peak energies are $sigma_E / E approx 0.8\%$. These values were found to be similar for $gamma$ events with single or multiple energy deposits. These results are consistent with the model described in Ref.~@nEXOpCDR, and validated with EXO-200 data~@PhysRevC.101.065501. Studies of the dependence of the energy resolution on the electron lifetime show that a 10~ms, 7~ms or 5~ms lifetime calibrated to 10\%, 6\% or 3\% accuracy, respectively, would reduce the overall energy resolution by only 0.03\%, in absolute value, making its contribution subdominant. The effect of the energy resolution on the nEXO $0 nu beta beta$ sensitivity is discussed in @sec:results.

== Deep neural network discrimination <sec:dnn>

Background events in nEXO are expected to be dominated by $gamma$-rays released from decaying nuclides present in and around the detector region. Their interactions in the LXe are primarily Compton scatterings which have the distinct feature of depositing energy in multiple locations, in contrast to $beta$ or double-$beta$ decays that predominantly leave localized deposits ranging only a few millimeters. On the other hand, at the energy of interest, bremsstrahlung radiation from fast electrons produced in $2 nu beta beta$ or $0 nu beta beta$ decays can make such events appear multi-sited and thus difficult to distinguish from gamma backgrounds. Motivated by the recent results of EXO-200~@PhysRevLett.123.161802, as well as analyses using nEXO simulations~@Li_2019, the simulated waveforms are used directly to develop a DNN that focuses on these topological differences in order to discriminate between double-$beta$ and $gamma$ events. The input to the network are two-dimensional time series for strips along the $x$ and $y$ directions. In this input, we also include simulated channels without charge collection but having induction signal height larger than 800~$e^-$. The algorithm implementation is developed with an 18-layer-deep residual network (ResNet-18)~@7780459 using the PyTorch framework~@paszke2017automatic.

The training data consists of two classes of 1.4~million simulated interactions each: $0 nu beta beta$ decay-like events with the sum energy of the two final-state electrons scaled to a uniform distribution between 900~keV and 3600~keV; and $gamma$ rays with uniform energy in the same range. The location of the simulated decays and $gamma$ interactions are drawn uniformly within the field cage. While $0 nu beta beta$ events occur within a very narrow energy range, the training of the DNN with a broad energy spectrum minimizes the correlation between this variable and other background discriminators such as event energy and absolute location in the TPC. It also emphasizes the topological differences between double-$beta$ decays and Compton scatterings that are independent of the background source. This dataset is randomly split, with 85\% of events used for training and 15\% for validation.

// [figvision] figures/dnn_roc_fv.png
// ## Panel description The figure contains a main plot and an inset. ## Main plot The main plot is a line plot
// showing the relationship between signal selection efficiency and background misidentification. The y-axis
// represents signal selection efficiency as a percentage, ranging from 0% to 100%. The x-axis represents
// background misidentification as a percentage, ranging from 0% to 40%. There are two lines: a solid orange line
// representing ^{232}Th in the TPC vessel and a dashed blue line representing ^{238}U in the TPC vessel. Both
// lines show an increasing trend, with the signal selection efficiency rising as the background
// misidentification increases. The trend shows that as the background misidentification increases, the signal
// selection efficiency also increases, but at a decreasing rate. ## Inset The inset is a histogram plot showing
// the distribution of the DNN 0 discriminator for simulated events. The y-axis represents normalized counts on a
// logarithmic scale, ranging from 10^{-4} to 10^{0}. The x-axis represents the DNN 0 discriminator, ranging from
// 0.0 to 1.0. There are three series: a solid orange line representing ^{232}Th in the TPC vessel, a dashed blue
// line representing ^{238}U in the TPC vessel, and a shaded gray area representing 0. The histogram shows that
// the 0 events are concentrated at higher values of the DNN discriminator, while the background events are more
// spread out. The trend shows that the 0 events have a distinct distribution compared to the background events.
#figure(placement: top, 
  image("figures/dnn_roc_fv.png", width: 80%),
  caption: [$0 nu beta beta$ decay signal selection efficiency versus background misidentification obtained with the DNN discriminator for simulated events whose reconstructed energy is within the FWHM around $Q_(beta beta)$. The solid orange (dashed blue) line refers to the $""^(238) "U"$ ($""^(232) "Th"$) backgrounds from the TPC vessel. The inset shows the DNN $0 nu beta beta$ discriminator distribution for these events.],
) <fig:dnn_roc>

@fig:dnn_roc shows the separation achieved between simulated events from $""^(238) "U"$ and $""^(232) "Th"$ $gamma$-rays and $0 nu beta beta$ decays, with event energy within the full width at half maximum (FWHM) around $Q_(beta beta)$, after training and validation are complete. A $0 nu beta beta$ decay selection efficiency of ∼80\% is achieved with only ∼5\% misidentification of $""^(238) "U"$ events. The rejection of $""^(232) "Th"$ events is slightly worse because of the topology of its events overlapping with $Q_(beta beta)$. Almost 50\% of these events are in the outermost 1500~kg of the 3648~kg TPC LXe volume, and consist of energy deposited near the Compton edge for the $""^(208) "Tl"$ 2615 keV $gamma$ ray~@stiegler2020event. As such, a larger fraction of these events consist of just a single recoiling electron rather than multiple energy deposits, and therefore more closely mimic $0 nu beta beta$ single-site interactions than events reconstructed in the full absorption peak of $""^(214) "Bi"$ 2448 keV line (which can be made up of multiple short-range Compton scatterings).

The DNN performance was verified to be stable for reasonable ranges of the electronic noise in the waveforms. In particular, we observe that the obtained performance is equivalent to the separation used in Ref.~@PhysRevC.97.065503 for a binary cut on the DNN discriminator of 0.85, but with an additional 17\% increase in signal detection efficiency. This result suggests a tagging procedure where scores above this value are classified as events with a single energy deposit, referred to as "single-site" (SS-like), and those below the cut contain multiple deposits, #emph[i.e.], "multi-site" (MS-like) events.

= Background Model <sec:materials>

A credible background estimation, founded on radioassay data and coupled with a detailed MC model, is key to an accurate determination of the experiment performance. For this purpose, a comprehensive list of background sources must be built. This process was successfully demonstrated in EXO-200 where the predicted background was found to agree, within uncertainties, with the one derived from the final fit to the data~@PhysRevC.92.015503. The results presented here are based on a robust bottom-up estimation of the backgrounds from individual components and we note that, as far as intrinsic radioactivity is concerned, these results do not involve any extrapolation of materials radiopurity beyond what has been already measured.

Background sources are classified into three main categories for nEXO: intrinsic radioactivity of detector materials, radon outgassing, and radionuclides that form or are introduced during the course of the material production, detector assembly, and operation. Only background components resulting in more than 0.01 SS-like events/(FWHM·yr) in the central 2000~kg are considered here. The background rate in this central mass region provides a simplified reference value for the experiment's performance. This is because an analysis performed with events in that region yields ∼95\% of the experimental sensitivity achieved with the full FV, as presented in Ref.~@PhysRevC.97.065503 and re-validated for this work, although the full mass is required for self-shielding and measuring the background rates.

== Intrinsic radioactivity of detector materials <sec:intrinsic>

#figure(scope: "parent",
  table(
    columns: 7,
    inset: 4pt,
    table.header(
      [*Material*], [*Supplier*], [*Method*], [*$""^(238) "U"$* (ppt)], [*$""^(232) "Th"$* (ppt)], [*$""^(40) "K"$* (ppb)], [*$""^(60) "Co"$* (mBq/kg)],
    ),
    [Electroformed Copper#super[†]], [In-house], [ICP-MS], [$< 0.01$], [$< 0.01$], [–], [–],
    [Copper], [Aurubis], [ICP-MS/Ge/], [$0.254 plus.minus 0.008$], [$0.13 plus.minus 0.06$], [$< 6.4$], [$< 0.0033$],
    [], [], [GDMS], [], [], [], [],
    [Sapphire], [GTAT], [NAA], [$< 8.9$], [$6.0 plus.minus 1.1$], [$9.5 plus.minus 2.0$], [–],
    [Quartz], [Heraeus], [NAA], [$< 1.5$], [$< 0.23$], [$0.55 plus.minus 0.03$], [–],
    [SiPM], [FBK], [ICP-MS/NAA], [$0.86 plus.minus 0.05$], [$0.45 plus.minus 0.12$], [–], [–],
    [Epoxy#super[\*†]], [MasterBond], [Ge], [$< 360$], [$< 540$], [$< 930$], [–],
    [AuSn solder#super[†]], [Nippon Micrometal], [ICP-MS], [$90 plus.minus 20$], [$68 plus.minus 14$], [–], [–],
    [Gold wire bonding#super[†]], [Ametek], [ICP-MS], [$< 230$], [$26 plus.minus 8$], [–], [–],
    [Polyimide#super[†]], [Taiflex], [ICP-MS], [$0.71 plus.minus 0.04$], [$0.71 plus.minus 0.20$], [–], [–],
    [], [], [], [pg/cm$""^2$], [pg/cm$""^2$], [], [],
    [HFE-7000#super[\*]], [3M], [NAA], [$< 0.015$], [$< 0.015$], [–], [–],
    [CFC (Resin)#super[†]], [SCC], [Ge], [$< 7.7$], [$< 19$], [$< 31$], [$< 0.03$],
    [CFC (Fiber)#super[†]], [Grafil], [Ge], [$40 plus.minus 15$], [$74 plus.minus 39$], [$810 plus.minus 100$], [$< 0.11$],
    [ASICs (Silicon)#super[†]], [Global Foundry], [ICP-MS], [$0.35 plus.minus 0.13$], [$1.3 plus.minus 0.7$], [–], [–],
    [Titanium#super[†]], [LZ TIMET], [Ge], [$< 12$], [$57 plus.minus 5$], [$< 29$], [$< 0.033$],
    [Water], [SNOLAB], [], [$< 1$], [$< 1$], [$< 1000$], [–],
    [Stainless Steel#super[†]], [GERDA], [Ge], [$< 48$], [$< 200$], [$< 58$], [$16.8 plus.minus 2.4$],
    [HDPE#super[†]], [Dielectric Sci.], [NAA], [$100 plus.minus 19$], [$63.6 plus.minus 2.7$], [$350 plus.minus 10$], [–],
    [PTFE#super[\*†]], [DuPont], [NAA], [$< 0.78$], [$< 0.26$], [$1.8 plus.minus 0.2$], [–],
    [Cond. PE#super[†]], [Quadrant], [ICP-MS], [$224 plus.minus 32$], [$10.1 plus.minus 1.4$], [–], [–],
  ),
  caption: [Materials, analysis method and radioactivity concentrations entering the nEXO background model. Data for entries marked with a \* were taken from the EXO-200 materials certification program. Entries marked with a † are either new or updated from the previous analysis~@PhysRevC.97.065503. Data for titanium, water and stainless steel are from Table~VI of Ref.~@Akerib:2017iwt, Ref.~@Aharmim:2011yq and from Ref.~@Maneschg:2008, respectively. Limits are stated at 90\% CL and were computed using the "flip-flop" method~@Feldman:1997qc.],
) <tab:rad>

The long-lived radionuclides of primary interest for nEXO are $""^(238) "U"$, with a $gamma$-ray at 2448~keV (from $""^(214) "Bi"$ decay) and $""^(232) "Th"$, with a $gamma$-ray at 2615~keV (from $""^(208) "Tl"$ decay). Secular equilibrium is assumed for the decay chains. While $""^(60) "Co"$ and $""^(40) "K"$ are kept in the background model because of their impact on the measurement of $2 nu beta beta$ decays, $""^(137) "Cs"$ is excluded since interactions depositing $< 700$~keV in the TPC are discarded in the analysis. $""^(26) "Al"$, with its $gamma$-ray emission at 2938~keV, is included in the model since it could be present in the sapphire part of the FSR support at levels of $< 0.9$~mBq/kg at 90\% CL. The mass of Al contained in the reflective coatings is very small, so that its contribution to the $""^(26) "Al"$ activity is negligible.

A list of radioassay-based input activity levels for nEXO materials is provided in @tab:rad. The radioassay effort in nEXO is conducted at multiple collaborating labs worldwide, with cross-calibration efforts to ensure standardization and uniformity in the results. The various techniques utilized are detailed in Refs.~@nEXOpCDR @PhysRevC.97.065503. In addition to the new entries due to the refined implementation of the geometry in MC simulations, radioactivity measurements for polyimide in the readout cables and for the ASICs in the electronics were updated from Ref.~@PhysRevC.97.065503. Previously unpublished radioactivity data for the CFC has been utilized in the background estimate for the OV and IV. Electrical connections in the TPC and to the cables bringing signals out of it use gold, epoxy and gold-tin alloy, reproducing the current understanding of the design. Following substantial engineering feasibility studies and R&D on in-house copper electroforming~@Hoppe:2014nva @Abgrall:2016cct, it was concluded that direct electroforming the TPC cylindrical vessel and other components is possible. Therefore this technology of electroformed (EF) copper is now the baseline for nEXO and results in a significantly lower background.

#figure(scope: "parent",
  table(
    columns: 4,
    inset: 4pt,
    table.header(
      [*Component*], [*Nuclides Simulated*], [*Material*], [*Mass or Surface Area*],
    ),
    [Outer Vessel Tank Support#super[†]], [$""^(238) "U"$, $""^(232) "Th"$], [Stainless Steel], [2711~kg],
    [Outer Vessel Support#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [CFC], [690~kg],
    [Outer Vessel], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [CFC], [2700~kg],
    [Outer Vessel Feedthroughs#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Stainless Steel], [12.5~kg],
    [Outer Vessel Liner#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(60) "Co"$], [Titanium], [858.8~kg],
    [Inner Vessel Support#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [CFC], [447~kg],
    [Inner Vessel], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [CFC], [823~kg],
    [Inner Vessel Liner], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Titanium], [323.4~kg],
    [Inner Vessel Feedthroughs#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Titanium], [8~kg],
    [HFE-7000], [$""^(238) "U"$, $""^(232) "Th"$, $""^(222) "Rn"$], [HFE-7000], [31814~kg],
    [TPC Vessel Support#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [83~kg],
    [TPC Vessel], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [447~kg],
    [FSRs], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [68~kg],
    [FSR Support Components], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(26) "Al"$], [Sapphire], [2.59~kg],
    [Cathode], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [12.18~kg],
    [SiPM], [$""^(238) "U"$, $""^(232) "Th"$], [SiPM], [2.91~kg],
    [SiPM Staves], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [132.4~kg],
    [SiPM Module Backing], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$], [Quartz], [11.23~kg],
    [SiPM Electronics], [$""^(238) "U"$, $""^(232) "Th"$], [ASICs], [2.2~kg],
    [SiPM Module Wire bonds], [$""^(238) "U"$, $""^(232) "Th"$], [Gold], [8~g],
    [SiPM Cables], [$""^(238) "U"$, $""^(232) "Th"$], [Polyimide], [$1.53 times 10^4$~cm$""^2$],
    [SiPM Bump Bonds#super[†]], [$""^(238) "U"$, $""^(232) "Th"$], [AuSn], [2.2~g],
    [Charge Module Support], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [34.12~kg],
    [Charge Module Backing], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$], [Quartz], [1.22~kg],
    [Charge Module Electronics], [$""^(238) "U"$, $""^(232) "Th"$], [ASICs], [0.42~kg],
    [Charge Module Cables], [$""^(238) "U"$, $""^(232) "Th"$], [Polyimide], [$0.63 times 10^4$~cm$""^2$],
    [Charge Module Wire bonds], [$""^(238) "U"$, $""^(232) "Th"$], [Gold], [2~g],
    [Charge Module Epoxy], [$""^(238) "U"$, $""^(232) "Th"$], [Epoxy], [1~g],
    [HV Feedthrough Components#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [7.95~kg],
    [HV Feedthrough Components#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$], [PTFE], [0.71~kg],
    [HV Cable#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$], [Conductive PE], [2~g],
    [HV Cable#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$], [HDPE], [0.55~kg],
    [Calibration Guide Tubes#super[†]], [$""^(238) "U"$, $""^(232) "Th"$, $""^(40) "K"$, $""^(60) "Co"$], [Copper], [4.92~kg],
    [TPC LXe Volume], [$""^(137) "Xe"$, $""^(222) "Rn"$, $""^(42) "Ar"$, $2 nu beta beta$, $0 nu beta beta$], [Xenon], [3648~kg],
    [Skin LXe Volume], [$""^(137) "Xe"$, $""^(222) "Rn"$, $""^(42) "Ar"$, $2 nu beta beta$, $0 nu beta beta$], [Xenon], [1163~kg],
  ),
  caption: [List of simulated detector components of the nEXO background model that is used in the sensitivity calculations, along with their material, nuclides simulated, and mass or surface area. Relative to Ref.~@PhysRevC.97.065503, components marked with † were introduced in this analysis, as well as simulations of $""^(60) "Co"$ decays, $""^(222) "Rn"$ in the HFE-7000, and $""^(42) "Ar"$ in the LXe volume. Components simulated but found to contribute negligibly to the background are not listed.],
) <tab:components>

@tab:components shows a complete list of the simulated detector components used in the background model of the sensitivity analysis. Pure $beta$ emitters on TPC surfaces are not included since the short range of $beta$ particles in LXe prevents them from passing the FV selection cut.

Isotopic enrichment efficiently suppresses all species lighter than 136 amu with exception of 134 amu, which makes up the remaining 10\% LXe mass. $""^(134) "Xe"$ double-$beta$ decays with $Q$-value of $825.8 plus.minus 0.9$~keV~@Wang2012 and is not a background for $""^(136) "Xe"$. Continuous xenon recirculation and purification guarantees the extreme purity of the LXe in the detector. While only the direct measurement with the nEXO detector will be able to confirm that the background from impurities in the xenon is negligible, we consider for the purpose of this estimate only intrinsic contaminations that can plausibly be problematic. These are the $""^(136) "Xe"$, which undergoes $2 nu beta beta$, and $""^(42) "Ar"$. The $2 nu beta beta$ decay rate is based on the EXO-200 half-life measurement of $(2.165 plus.minus 0.061) times 10^21$~yr~@PhysRevC.89.015502. The very long half life and the energy resolution of nEXO make this background negligible, even at the largest exposure considered here.

Argon is present in xenon as both are obtained as by-product of atmospheric gas distillation. Among its long-lived isotopes, only $""^(42) "Ar"$ is a concern for nEXO. The decay of its daughter $""^(42) "K"$ results in a $beta$ emission with endpoint energy of 3525~keV, as well as $gamma$ radiation with an energy of 2424~keV (with a branching fraction of 0.02\%). Multiple factors play a role in estimating the expected levels of $""^(42) "Ar"$ in nEXO, some of which are not well known, including the abundance of $""^(42) "Ar"$ relative to $""^(40) "Ar"$ after enrichment, which is difficult to estimate quantitatively because they are both very far from the mass cut used. Here we assume a factor nine enhancement of the isotope $""^(42) "Ar"$ abundance based on the equivalent value for $""^(136) "Xe"$ separation relative to lighter xenon isotopes. Based on measurements of $""^(40) "Ar"$ in enriched xenon by the EXO-200 collaboration~@Dobi:2011zx, the assumptions of a xenon recirculation time of 4 days and 100\% efficient removal of $""^(42) "K"$ by the purifier, and an ionization fraction of 76\% for this isotope (based on measurements of Rn daughters in LXe~@Albert:2015vma), we obtain an internal $""^(42) "K"$ activity of $2.59 times 10^(-9)$~mBq/kg, which we include in the model. Even assuming a five times larger activity, the impact on the sensitivity is negligible.

MC studies confirmed that the background contribution from natural radioactivity in SNOLAB's cryopit rock walls, including those from the layers of concrete and shotcrete result in negligible background contribution and have, therefore, been omitted from the model. Similarly, the contributions from $""^(238) "U"$ and $""^(232) "Th"$ present in the water and the PMTs of the muon veto system can be neglected even if these nuclides leak into the water and are present near the OV surface, which is a conservative assumption.

== Radon outgassing <sec:radon>

As the background from the copper is substantially reduced compared to previous estimates, contributing to the better projected sensitivity, $""^(222) "Rn"$ in the xenon contributes a larger share and is modeled in detail. The current estimate of the $""^(222) "Rn"$ background is experimentally constrained by EXO-200 data, taking into account the emanation from the various detector and recirculation-system components and their relative surface areas. This process results in a steady-state population of $N_"Rn" = 600$ $""^(222) "Rn"$ atoms contained in the xenon.

A number of options exist to mitigate the radon content of the xenon, including the selection of materials and components based on their $""^(222) "Rn"$ emanation rate and the development of surface cleaning protocols. This must be done for all components wetting the xenon. EXO-200 data showed steady-state population of about 200 $""^(222) "Rn"$ atoms present in the TPC throughout the physics runs. These data also indicated that the likely source of this radon was external to the TPC. To identify the principal source, the $""^(222) "Rn"$ production rate of the EXO-200 xenon handling system (piping, pump, purifier) is being radon-assayed in various configurations. A radon background budget will be kept as components are accepted for installation in the detector, and transport models will be used to maintain current predictions of the radon population in the TPC. The xenon handling system will be tested for its $""^(222) "Rn"$ emanation rate during construction to confirm that its components do not exceed the requirements. Ongoing measurements appear to indicate that much of the emanation in EXO-200 occurred in the xenon purifiers. Work is in progress to better understand and reduce such emanation. One of the strengths of a liquid-phase detector such as nEXO is that the external recirculation and purification system can be upgraded, should the need arise. A distillation system could be utilized to reduce this contamination to acceptable levels. The effectiveness of this approach has been demonstrated in previous work~@Aprile:2017kop @Cui:2020bwf.

#figure(
  table(
    columns: 4,
    table.header(
      [Decay Location $ell$], [$f_ell$], [$epsilon_(alpha, ell)$], [$N_("Rn", ell)$],
    ),
    [Cathode top surface], [0.617], [0.5], [185.41],
    [Field rings surfaces], [0.184], [0.49], [56.32],
    [Cathode bottom surface], [0.044], [0.01], [26.37],
    [Skin LXe above anode], [0.012], [0.01], [7.04],
    [Skin LXe under cathode], [0.003], [0.01], [1.65],
    [TPC LXe bulk], [0.128], [0.999], [0.21],
    [Skin LXe barrel], [0.012], [0.98], [0.16],
  ),
  caption: [List of $""^(214) "Bi"$ decay locations $ell$ with the corresponding decay fractions $f_ell$, $alpha$ tagging efficiency $epsilon_(alpha, ell)$, and number of background-contributing atoms $N_("Rn", ell)$ present in steady-state in the LXe.],
) <tab:radon>

In the simulations and data analysis, the treatment of $""^(222) "Rn"$ in the LXe follows the methodology described in Ref.~@stiegler2020event. $beta$ emission from $""^(214) "Bi"$ is followed in fast succession by a $""^(214) "Po"$ $alpha$ decay that can be used to identify the Bi-Po decay chain if the decays are fully contained in the LXe. The efficiency of this approach depends on the choice for the coincidence time window and the location of the $alpha$ decay. @tab:radon shows the fraction ($f_ell$) of radon-related $""^(214) "Bi"$ decays in seven detector areas $ell$ along with the $alpha$ tagging efficiency $epsilon_(alpha, ell)$~@stiegler2020event. The $""^(214) "Bi"$ decays have to be partitioned this way to account for drift of ionized $""^(222) "Rn"$ daughters in different electric field regions of the LXe volume. For a veto time of $Delta t_"BiPo" = 1500$~μs and a $""^(214) "Po"$ half life of 164~μs, the Bi-Po coincidence tagging efficiency is $epsilon_"BiPo" = 99.82\%$. The number of untagged $""^(214) "Bi"$ decays at each location is $N_("Rn", ell) = N_"Rn" dot f_ell dot (1 - epsilon_"BiPo" dot epsilon_(alpha, ell))$.

After application of the BiPo veto, approximately 46\% (277 atoms) of the steady-state population of $""^(222) "Rn"$ atoms in the LXe contribute to the background. Most of the $""^(214) "Bi"$ decays from the $""^(222) "Rn"$ chain are from regions at the edges of the TPC, allowing for optimal exploitation of the standoff and single-site discriminators, and keeping the innermost LXe volume radioquiet while allowing measurement of this background in the outer volume.

$""^(222) "Rn"$ in the HFE-7000 will also result in $""^(214) "Bi"$ decay-related backgrounds, with the relevant emanation primarily originating from the titanium liner of the IV. Using measurements from Ref.~@RadonLZ @RadonXenon1T, this is expected to result in a steady-state population of ∼1500 atoms of $""^(222) "Rn"$ in the HFE-7000. The baseline design of the cryogenic system assumes recirculation of the HFE-7000 in an external heat exchanger. It is assumed that the contribution from such an external system can be kept subdominant to the titanium liner contribution due to its much smaller surface area. The current simulation assumes 1500 Rn atoms uniformly distributed throughout the HFE-7000 volume. The same $""^(222) "Rn"$ mitigation strategies described for the LXe system apply to HFE-7000 system. While this source was added to the model, $""^(222) "Rn"$ in the OD water was not included because it can be readily maintained below $9 times 10^(-9)$~Bq/kg~@Aharmim:2011yq and therefore is a negligible contribution to the background budget.

== Exposure-based backgrounds <sec:exposure-based-bkg>

The backgrounds considered so far are primarily related to contaminants in the material bulk and intrinsic radon outgassing level. Background also arises from the exposure of detector components to cosmogenic radiation, to radon in the air, and to dust. These background contributions are thus a function of the material handling and detector operation.

For cosmogenically-created radionuclides, two separate production pathways are considered: activation while materials are fabricated, transported, or stored above ground and steady-state production underground.

For above-ground activation, a systematic study of possible radionuclides produced by cosmogenic activity, including production rates and hit efficiencies, is currently underway for all detector materials. For the initial effort, the background contribution from cosmogenic isotopes in copper (e.g. $""^(56) "Co"$, $""^(60) "Co"$, $""^(44) "Sc"$, $""^(42) "K"$) was evaluated and found to be acceptable with proper management of above-ground exposure and a sufficient period of cool-down underground before deployment. In addition, xenon spallation products that can be removed by purification are not a concern for nEXO.

Underground cosmogenic activation of detector components was evaluated in a prior work~@PhysRevC.97.065503 using MC simulations. The resulting backgrounds were found to be negligible with the notable exception of those arising from $""^(137) "Xe"$, with a half-life of $T_(1/2)^("137" "Xe") = 3.82$~min~@CARLSON1969267. In particular, $""^(135) "Xe"$ produced through neutron capture in $""^(134) "Xe"$ has an endpoint energy of $1165$~keV~@SINGH2008517 and is not a background for $""^(136) "Xe"$. The $beta$ emission from $""^(137) "Xe"$ decay has an endpoint energy of $4173$~keV~@Browne20072173 and this causes an overlap of the $beta$ spectrum in the region of the $Q_(beta beta)$ value. The contribution from $""^(137) "Xe"$, activated by interactions in the bulk of LXe, was studied using Geant4 MC simulations with $tilde.op 10^7$~muons passing through a cylinder coaxial with the water tank, but with slightly larger dimensions than the OD size, and following energy and angular distributions observed at SNOLAB~@PhysRevD.73.053004. Secondary particles were tracked and the number of $""^(137) "Xe"$ atoms produced from neutron captures was counted. Nuclei are produced with an excited state energy of $4026$~keV~@NSR2012WA38, which is promptly released through $gamma$ emission. These prompt emissions provide a tag for $""^(137) "Xe"$ production by coincidence with the originating muon. The veto efficiency was estimated from the muon tagging efficiency and from the fraction of $""^(136) "Xe"$ neutron-capture events reconstructed with energy within $plus.minus 2 dot$ FWHM of the full de-excitation energy. A 70\% veto efficiency was obtained for $""^(137) "Xe"$ decays near the FV edge, increasing towards the LXe center. Therefore, this value is conservatively applied to reduce the background contribution from $""^(137) "Xe"$ to $(0.85 plus.minus 0.04) times 10^(-3)$~atoms/(kg·yr), uniformly distributed in the LXe volume, without significantly decreasing the livetime, even for a veto time window as long as five $""^(137) "Xe"$ half-lives.

Production of $""^(137) "Xe"$ could also arise from capture of neutrons not of cosmogenic origin. Radiogenic neutrons produced in the cavern walls by $(alpha, n)$ reactions in the rock typically have energies lower than 10~MeV, and do not reach the TPC due to attenuation by the water shielding. However, activation of $""^(136) "Xe"$ during xenon recirculation outside the water tank was evaluated and found to be non-negligible unless special precautions are taken. MC studies indicate that $""^(137) "Xe"$ production in these regions can be mitigated by ensuring sufficient neutron shielding (e.g. a few cm of borated polyethlyene) of the circulation pipes outside the OD. Such shielding is being incorporated into the design of the recirculation system. Fast neutrons can also be created close to the TPC via $(alpha, n)$ reactions by $alpha$-decays from the natural decay series and out-of-equilibrium $""^(210) "Po"$ (e.g., from $""^(222) "Rn"$ daughter plate out) from components inside the water shield. Spontaneous fission contributes relatively little to this background. Cross sections for $(alpha, n)$ reactions at these energies are relevant only in low-$Z$ materials due to the nuclear Coulomb barrier, meaning only certain materials are of particular concern, as well as $""^(222) "Rn"$ exposure during detector construction. MC studies indicate that when U and Th decay chains are the source for these $alpha$ particles, the resulting $""^(137) "Xe"$ production was found to be 100 to 1000 times smaller than the background contributions from $gamma$-rays of the same chain. Under the assumption that the introduction of these backgrounds can be sufficiently controlled during detector design and construction, these processes are neglected in the current model. Radon progeny attachment studies are underway to provide the underpinning for formulating radon reduction specifications for the detector assembly areas. Radon removal devices will be employed during construction to meet this requirement.

Dust can contribute to the nEXO background in two different ways: emission of $gamma$-radiation and, in case it is in contact with the xenon, emanation of $""^(222) "Rn"$. The fractional contribution of either component depends on the, yet unknown, fraction of mobile dust particles. Another source of uncertainty is the make-up of the dust particles. The collaboration developed a dust fallout model to guide this discussion. During construction dust will be measured via witness plates and tape lifts~@diVacri:2020aqc. Particles can then be counted via optical microscopy and their U/Th contents can be measured by inductively coupled plasma mass spectrometry (ICP-MS). nEXO plans to organize its work around improved EXO-200 assembly procedures. The low $""^(222) "Rn"$ content of the xenon in EXO-200 is indirect evidence for the success of its cleanliness protocols. In the current sensitivity estimate it is assumed that dust mainly contributes via $""^(222) "Rn"$ emanation. Its contribution is absorbed in the overall $""^(222) "Rn"$ content presented in @sec:radon.

During detector operation, backgrounds from interactions of neutrinos must also be considered. Among these, the only important contribution arises from electron-neutrino elastic scattering from $""^(8) "B"$ solar neutrinos, uniformly interacting throughout the LXe volume~@PhysRevC.97.065503. This scattering results in $(1.15 plus.minus 0.06) times 10^(-3)$~electrons/(kg·yr) with a continuous energy spectrum having an end point that is above $Q_(beta beta)$~@de_Barros_2011. This contribution is included in the MC model.

== Background budget <sec:bkg-budget>

// [figvision] figures/BackgroundBudgetOverview_Summary_D-024_v11_2021-03-23_2tonne.png
// Panel a: This is a plot showing the fractional background contributions from Bi-214 from Rn-222. The y-axis
// lists locations: Total, Cathode, Field Rings, HFE-7000, TPC LXe, and Skin LXe. The x-axis is % of total SS
// counts/(FWHM·2000kg), on a log scale from 0.1 to 100. There are blue open circles indicating individual
// contributions and a blue solid marker for the total contribution. The trend shows increasing contributions
// from top to bottom locations. Panel b: This plot shows contributions from Intrinsic Radioactivity. The y-axis
// lists: Total, U-238, Th-232, Ar-42, and 2νββ. The x-axis is the same as panel a. Green lines with open circles
// and a solid green marker for total contribution are shown. The trend indicates U-238 has the largest
// contribution. Panel c: This plot shows Exposure-based contributions. The y-axis lists: Total, Xe-137, and
// Solar ν. The x-axis is the same as panel a. Orange circles represent individual contributions and an orange
// solid marker for the total. The trend shows Solar ν and Xe-137 have similar, small contributions.
#figure(placement: top, 
  image("figures/BackgroundBudgetOverview_Summary_D-024_v11_2021-03-23_2tonne.png", width: 88%),
  caption: [SS-like fractional background contributions with energy within $Q_(beta beta)$ ± FWHM/2 and in the inner 2000~kg. The contributions are grouped by category, as described in the text. For each category, the total contribution is shown by the solid marker, while individual contributions are indicated by open circles. Negligible contributions are not shown. For $""^(222) "Rn"$ backgrounds, the breakdown by $""^(214) "Bi"$ decay location (based on @tab:radon) is shown. Breakdown by the individual source terms is given for the other two background categories.],
) <fig:nEXO_background_budget_overview>

// [figvision] figures/BackgroundBudget_Intrinsic_ByComponent_Summary_D-024_v11_2021-03-23_2tonne.png
// The figure has one panel. The plot is a bar chart with a green series. The y-axis lists detector components,
// and the x-axis represents the percentage of total SS counts per FWHM times 2000 kg, ranging from 0.01 to 100.
// The green bars show the fractional background contributions, with error bars indicating uncertainty.
// Annotations and labels include component names on the y-axis and percentage values on the x-axis. The trend
// shows that Support Rods and Spacers, HFE-7000, and Outer Vessel have the highest contributions, while smaller
// components like HV Feedthrough Core (Cable) have lower contributions.
// [figvision] figures/BackgroundBudget_Intrinstic_byMaterial_Summary_D-024_v11_2021-03-23_2tonne.png
// The figure shows a plot of fractional background contributions from intrinsic radioactivity of detector
// materials. a. This panel shows a bar plot with materials on the y-axis and percentage of total SS
// counts/(FWHM·2000kg) on the x-axis, which ranges from 0.01 to 100. The x-axis is logarithmic. There is one
// series of green bars with circular markers and horizontal error bars. Each bar represents a material:
// Polyimide, CFC, Sapphire, HFE-7000, Quartz, HDPE, Titanium, LXe, Copper, SiPM, Silicon, Bonding Wire,
// Stainless Steel, Epoxy, and AuSn. The trend shows that Sapphire, CFC, and Stainless Steel have the highest
// contributions.
#figure(placement: top, scope: "parent", 
  [
    #image("figures/BackgroundBudget_Intrinsic_ByComponent_Summary_D-024_v11_2021-03-23_2tonne.png", width: 49%)
    #h(0.5em)
    #image("figures/BackgroundBudget_Intrinstic_byMaterial_Summary_D-024_v11_2021-03-23_2tonne.png", width: 49%)
  ],
  caption: [Fractional background contributions from intrinsic radioactivity of the detector materials grouped by detector component (left) and material (right) with SS-like topology and energy within $Q_(beta beta)$ ± FWHM/2 and in the inner 2000~kg.],
) <fig:nEXO_background_budgets>

The development of a background budget is valuable for understanding the role of different contributions, optimizing the design, planning contingencies, and focusing resources during detector construction. In order to capture the complex impact of the different background contributions in a synthetic manner, a representative value is computed for each component and their relative contributions are studied. MC simulations are used to evaluate the probability that a decay in a specific detector component will produce an SS-like event, #emph[i.e.], an event with $0 nu beta beta$ DNN discriminator > 0.85, with all energy deposits reconstructed within the inner 2000~kg LXe volume, and event energy within the FWHM of $Q_(beta beta)$~@PhysRevC.97.065503. These probabilities, referred to as the hit efficiencies, are then combined with the radioactivity content from each material using a truncated Gaussian distribution to model the background contributions~@tsang2018treatment. Uncertainties are propagated from the underlying terms. An overview of the relative contributions from each background category is shown in @fig:nEXO_background_budget_overview. For radon outgassing background, only the statistical uncertainty is given. The breakdowns by material and components of the intrinsic background from radioactivity of nEXO's detector materials are shown in @fig:nEXO_background_budgets.

In the current model, the largest background contribution is from $""^(222) "Rn"$, with ∼50\% of the total budget, and more specifically from $""^(222) "Rn"$ deposited on the cathode, which corresponds to ∼30\% of the total budget. This result contrasts with previous nEXO publications where the copper for the TPC construction was dominant. This is the result of the decision to use in-house EF copper which has lower intrinsic activity. Indeed, in a scenario with all copper from the previously assumed commercial material, this material alone would consume ∼50\% of the total background budget, with the TPC vessel remaining the largest individual contributor with ∼20\% of the total budget, instead of its current $< 1\%$ contribution.

Other radio-impurities contained in the current model of nEXO's detector materials account for about 45\% of the background, with exposure-based backgrounds comprising only ∼5\% of the total. Among the backgrounds from intrinsic material contamination, no single component or material appears to dominate. The contribution from the top four components comes with significant uncertainties from the underlying radioassay measurements, with the sapphire entry being particularly noticeable. Efforts are ongoing to improve these assays results, in many cases pushing the limits of available experimental sensitivity. More broadly, the background analysis shown here has been guiding the detector design by informing and prioritizing component design, material selection, radioassay, and overall detector optimization. We discuss the effect from $""^(222) "Rn"$ contamination and cosmogenic $""^(137) "Xe"$ activation in the LXe volume on the nEXO $0 nu beta beta$ sensitivity in @sec:results.

= Sensitivity and Discovery Potential to $0 nu beta beta$ Decay <sec:sensitivity>

The experimental sensitivity to the $0 nu beta beta$ decay half-life of $""^(136) "Xe"$ provides the fundamental metric to determine the experiment's physics reach and guide its design by embedding all the detailed aspects of the design, material selection, and analysis into a single value of interest. The discovery potential and half-life sensitivity of the nEXO experiment to $0 nu beta beta$ is evaluated in a frequentist approach using a binned profile likelihood ratio test. As such, it mimics the analysis that would be performed on real data and maximally exploits the multiparameter measurement capabilities of nEXO.

The procedure to compute the sensitivity follows the methodology outlined in Ref.~@PhysRevC.97.065503. First, probability density functions for each component and background source are constructed from the MC simulations. These are weighted by the radioassay measurements to produce a model of the nEXO measurement. Toy datasets are then generated by sampling events from this model, which is fitted back to the toy data in order to generate confidence intervals on the signal strength. The resulting ensemble of confidence intervals under different signal hypotheses is used to determine either the median $3 sigma$ discovery potential or sensitivity at the 90\% CL to $0 nu beta beta$ decay with nEXO.

== Methodology

We begin by applying selection criteria which mimic an analysis of real data. We select events with reconstructed energies between 1000 and 3500~keV, and require the reconstructed standoff distance to be consistent with the FV defined in @sec:simulation (larger than 2~cm). The "diagonal cut," illustrated by the dashed lines in @fig:charge_light_cut, is then applied to remove events with excess light in the skin. In EXO-200 data, this cut was also sufficient to remove any $alpha$ decays as well as poorly reconstructed $beta$ and $gamma$ events. The detection efficiency for $0 nu beta beta$ decay events after applying these cuts is 96.0\%.

Events passing the cuts are binned into histograms with three dimensions: event energy, standoff distance, and the DNN $0 nu beta beta$ discriminator. A nonuniform binning scheme was developed to employ finer granularity where the signal and background distributions are most different, in order to maximize the discrimination power. The histograms are normalized to produce a set of probability density functions (PDFs), each associated with a component and nuclide pair, that is used to model the experimental data and its analysis.

The relative weight of each PDF is given by:

$ N_"PDF" = M A_s (K / N_"prim") T_"live" $ <eq:expected_counts>

where $M$ is the mass (or surface area) of the particular component, $A_s$ is the specific activity per unit mass (or surface area), $K$ are the number of events passing our analysis cuts, $N_"prim"$ is the number of primary decays generated in the simulation, and $T_"live"$ is the assumed livetime. The hit efficiencies are given by $K / N_"prim"$. By employing input parameters that derive from a detailed engineering design, a robust radioassay program, and detailed high-statistics MC simulations, we feel confident that the PDFs and their normalization provide an accurate representation of the final experiment.

In order to account for the uncertainties in the radioassay measurements, $A_s$ is sampled from a normal distribution truncated at zero each time a new toy experiment is run. Fluctuations are applied at the material level, meaning that two components made of the same material fluctuate together in each toy experiment.

All PDFs for either $""^(238) "U"$ or $""^(232) "Th"$ decays in detector components inside the TPC vessel are grouped together because of the degeneracy in their distributions. The PDFs for $""^(40) "K"$ of all components are grouped together to simplify the calculations, since this nuclide does not contribute with events near $Q_(beta beta)$. In addition, all PDFs at a distance farther than the TPC vessel are grouped into a single "far component". Backgrounds in the liquid xenon itself, specifically $""^(137) "Xe"$ and $""^(42) "K"$ decays, are grouped into a separate component. On the other hand, $2 nu beta beta$ and $""^(222) "Rn"$ decays in the LXe are treated as individual components, as well as the PDF for electron-neutrino elastic scattering from $""^(8) "B"$ solar neutrinos.

// [figvision] figures/all_three_event_distributions_projected_differential_no_data.png
// Panel (a) is a plot showing event distributions versus energy in keV. The y-axis ranges from 10^-2 to 10^6
// counts/keV, and the x-axis ranges from 1000 to 3500 keV. There are multiple series: a grey series for ^{136}Xe
// 2νββ, a blue series for ^{136}Xe 0νββ, and various coloured series for different components such as ^{238}U
// TPC Vessel (red), ^{232}Th TPC Vessel (green), and ^{40}K (yellow). The total sum is shown in black. The trend
// shows a peak around 1500 keV and a decline at higher energies. Panel (b) is a plot of event distributions
// versus DNN, with y-axis ranging from 10^1 to 10^9 counts/unit and x-axis from 0.0 to 1.0. Series include
// ^{232}Th Internals (green), Internal ^{222}Rn (cyan), Solar ν (purple), ^{137}Xe and ^{42}Ar (pink), and
// ^{238}U Internals (red). The ^{136}Xe 0νββ series is shown in blue. The trend shows an increase up to DNN of
// 0.8 then a decline. Panel (c) is a plot of event distributions versus standoff distance in mm, with y-axis
// ranging from 10^-3 to 10^5 counts/mm and x-axis from 0 to 700 mm. Series include ^{136}Xe 0νββ (blue), ^{40}K
// (yellow), and others. The total sum is shown in black. The trend shows a decline with increasing standoff
// distance.
#figure(placement: top, scope: "parent", 
  image("figures/all_three_event_distributions_projected_differential_no_data.png", width: 100%),
  caption: [Nominal model of event distributions in nEXO, projected onto each of the three axes used in the sensitivity analysis: (a) event energy, (b) DNN $0 nu beta beta$ discriminator, and (c) standoff distance. The $0 nu beta beta$ decay signal corresponds to a half-life of $0.74 times 10^28$~yr.],
) <fig:sensitivity_distributions>

// [figvision] figures/all_three_distributions_in_ROI_differential_combined_bkgs.png
// Panel (a) is a plot showing event energy distribution. The x-axis represents energy in keV, ranging from 2000
// to 2800, and the y-axis represents counts per keV. The series are: black points with error bars for the toy
// data sample, a grey filled area for {}^{136}Xe 2, a light purple filled area for {}^{136}Xe 0, a purple line
// for {}^{137}Xe, {}^{42}Ar, Solar , a red line for intrinsic and {}^{222}Rn, and a blue line for the total sum.
// The trend shows a decreasing distribution with increasing energy. Panel (b) is a plot showing the DNN
// discriminator distribution. The x-axis represents DNN values from 0.0 to 1.0, and the y-axis represents counts
// per unit. The series are: black points with error bars for the toy data sample, a light purple filled area and
// line for {}^{136}Xe 0, a red line for intrinsic and {}^{222}Rn, and a blue line for the total sum. The trend
// shows a peak near DNN = 0.8. Panel (c) is a plot showing the standoff distribution. The x-axis represents
// standoff in mm, ranging from 0 to 600, and the y-axis represents counts per mm. An upper x-axis shows enclosed
// mass in kg. The series are: black points with error bars for the toy data sample, a grey filled area for
// {}^{136}Xe 2, a light purple filled area for {}^{136}Xe 0, a purple line for {}^{137}Xe, {}^{42}Ar, Solar , a
// red line for intrinsic and {}^{222}Rn, and a blue line for the total sum. The trend shows a decreasing
// distribution with increasing standoff.
#figure(placement: top, scope: "parent", 
  image("figures/all_three_distributions_in_ROI_differential_combined_bkgs.png", width: 100%),
  caption: [Event distributions for an example of toy dataset (black points) and combined groups of the fitted PDFs projected onto the three axes used in the sensitivity analysis. In (a) the event energy distribution is shown for SS-like events (DNN $> 0.85$) in the central 2000~kg LXe and in the 2000-2800~keV region; (b) the DNN $0 nu beta beta$ discriminator distribution is shown for events with energy within $Q_(beta beta)$ plus.minus FWHM/2 and in the same central volume; and (c) the standoff distance distribution is shown for SS-like events within $Q_(beta beta)$ plus.minus FWHM/2. The $0 nu beta beta$ decay signal corresponds to a half-life of $0.74 times 10^28$~yr.],
) <fig:standoff_in_roi>

The relative contribution of each component to its group PDF is defined by @eq:expected_counts, and the total contribution of that group to the toy event is defined as the sum of the expected counts from each individual component. The full toy model is defined as a distribution where the number of events in the $j$-th bin of the three-dimensional fit space is given by the expression

$ n_j = N_(0 nu) f_(0 nu j) + sum_i N_i f_(i j) $ <eq:bin_values>

where $N_i$ represents the expected number of events from the $i$-th group and $f_(i j)$ is the value of the PDF for the $i$-th group in bin $j$. The $N_i$ are variable parameters — when building a model to generate toy datasets they are fixed at the values computed using @eq:expected_counts, but they are allowed to float when fitting the model to a toy experiment. The projections of the model onto each of the three axes, as well as of the contribution from each group, is depicted in @fig:sensitivity_distributions.

A negative log-likelihood (NLL) is minimized to determine the best fit values for $N_i$ in each toy dataset. The profile likelihood-ratio is used as a test statistic to build confidence intervals for exclusion or discovery of $0 nu beta beta$ decay. The details of the statistical analysis employed in this work are provided in @sec:appendix.

An example of a toy dataset assuming that $0 nu beta beta$ decay exists and has a half-life of $0.74 times 10^28$~yr is presented in @fig:standoff_in_roi. The figure shows the randomized data projected onto the three fitting variables along with the best fitted PDFs, which are grouped together based on similar characteristics.

@fig:standoff_in_roi (a) shows the energy distribution of SS-like events in the central 2000~kg of LXe, where a comparable rate is observed between signal and all background components added together in the region near $Q_(beta beta)$. In @fig:standoff_in_roi (b), the DNN score distribution is shown for events with energy within the FWHM around $Q_(beta beta)$ and in the central 2000~kg of LXe, while (c) shows the standoff distance distribution for SS-like events within the same energy range. There is a region where the signal is dominant over backgrounds in the bins towards $0 nu beta beta$-like DNN score and innermost volumes in the standoff distance, illustrating the $0 nu beta beta$ decay separation power obtained with nEXO.

== Sensitivity results <sec:results>

// [figvision] figures/sens_dp_vs_livetime.png
// The figure has one panel. The plot shows the projection of the median sensitivity and discovery potential to
// decay with nEXO as functions of the detector livetime. The y-axis represents the half-life of 0 in ^{136}Xe
// and ranges from 10^{25} to 10^{28} years on a log scale. The x-axis represents the lifetime and ranges from 0
// to 10 years. There are three series: a blue line for the Median Sensitivity at 90% C.L., an orange line for
// the Median Discovery Potential at 3, and a black circle for EXO-200 Sensitivity at 90% C.L. The blue line
// starts below 10^{25} and increases to 1.35 10^{28} yr at 10 years. The orange line starts below 10^{25} and
// increases to 0.74 10^{28} yr at 10 years. The black circle is at 5.0 10^{25} yr. The trend shows that as the
// detector livetime increases, the half-life of 0 in ^{136}Xe also increases for both median sensitivity and
// discovery potential.
#figure(
  image("figures/sens_dp_vs_livetime.png", width: 45%),
  caption: [Projection of the median sensitivity and $3 sigma$ discovery potential to $0 nu beta beta$ decay with nEXO as functions of the detector livetime. At small livetimes, the experiment is essentially background-free. In this regime, the number of observed counts required to make a $3 sigma$ discovery is smaller than the number of counts that can be excluded at the 90\% CL, leading to a discovery potential that is higher than the sensitivity.],
) <fig:sens_vs_livetime>

// [figvision] figures/discovery_significance_vs_halflife.png
// Panel a: This is a plot showing the relationship between the half-life of 0 in ^{136}Xe and the discovery
// significance. The x-axis represents the half-life in years, ranging from 10^{27} to 10^{29}, and the y-axis
// represents the discovery significance in , ranging from 0 to 6. The black line with dots represents the median
// discovery significance. The grey band indicates the 68% symmetric quantile around the median. An orange box
// shows T_{1/2} = 0.38 10^{28} yr, a blue box shows T_{1/2} = 0.74 10^{28} yr, and a green box shows = 2.4.
// There are also orange, blue, and green dotted lines indicating half-life at 5, half-life at 3, and
// significance at 10^{28} yr, respectively. The trend shows that as the half-life increases, the discovery
// significance decreases.
#figure(
  image("figures/discovery_significance_vs_halflife.png", width: 45%),
  caption: [Projections of the median discovery significance to $0 nu beta beta$ decay with 10 years of nEXO data. The grey band indicates the 68\% symmetric quantile around the median.],
) <fig:dp_sigma_10yr>

@fig:sens_vs_livetime shows the projected $0 nu beta beta$ sensitivity and discovery potential at $3 sigma$ level as functions of livetime. If no signal is observed in a 10~year exposure, the median expected exclusion for nEXO is $T^(0 nu)_(1/2) > 1.35 times 10^28$~yr at the 90\% CL. With one year of data taking this value is $0.2 times 10^28$~yr and exceeds $10^28$~yr after 6.5 years.

For a potential signal, the median $3 sigma$ discovery potential is $T^(0 nu)_(1/2) = 0.74 times 10^28$~yr. These results represent an increase of ∼30-45\% over the previous projections reported in Ref.~@PhysRevC.97.065503. About $1/3$ of the improvement arises from the DNN discrimination power, consistent with results reported by EXO-200~@PhysRevLett.123.161802, and the remaining $2/3$ arises from the reduction of backgrounds, dominated by the choice to use EF copper. The expected discovery significance as a function of the $0 nu beta beta$ decay half-life at the nominal 10~year livetime is presented in @fig:dp_sigma_10yr. We observe that a median significance of $2.4 sigma$ is achieved for a hypothetical $0 nu beta beta$ decay half-life of $10^28$~yr. If $0 nu beta beta$ decay exists with half-life of $< 0.38 times 10^28$~yr then nEXO would be capable of discovery at $5 sigma$ significance in more than 50\% of the possible realizations.

// [figvision] figures/sensitivity_vs_energy_resolution_v11.png
// The figure has one panel. The plot shows the relationship between the half-life and the energy resolution. The
// y-axis represents the half-life in units of 10^{28} years, ranging from 1.0 to 1.5. The x-axis represents the
// energy resolution at Q_{} in percentage, ranging from 0.7 to 1.3. There is one series of blue dots
// representing the 90% CL upper limit. A blue solid line is a linear fit to the calculated points. The trend
// shows that as the energy resolution increases, the half-life decreases. The message is that the half-life
// decreases linearly with increasing energy resolution.
#figure(
  image("figures/sensitivity_vs_energy_resolution_v11.png", width: 45%),
  caption: [Projected median sensitivity to $0 nu beta beta$ decay at 90\% CL with nEXO operating at different energy resolutions. The large marker represents the value at the baseline model, while smaller points represent the calculations with the energy resolution intentionally degraded. The solid line is a linear fit to the calculated points.],
) <fig:sens_vs_eneresol>

The energy resolution obtained in the MC simulations is based on a realistic representation of the detector response but also includes some simplifications, a few of which cannot yet be fully validated at this stage of the experiment design. To quantify the impact of the energy resolution on the experimental sensitivity, we degraded the resolution value at $Q_(beta beta)$ within a conservative range of values and then re-evaluated the sensitivity. The result is shown in @fig:sens_vs_eneresol. As previously reported ~@PhysRevC.97.065503, the $0 nu beta beta$ sensitivity does not degrade substantially, decreasing by ∼15\% for the resolution growing by 50\%.

// [figvision] figures/sensitivity_vs_background_scaling_linear_sameY.png
// Panel (a) is a plot showing the relationship between the half-life (in units of 10^28 years) and the scaling
// of 222Rn. The y-axis ranges from 0.0 to 3.0, with a linear scale, and the x-axis ranges from 0.01 to 10, with
// a log scale. There are two series: a blue line representing sensitivity at 90% C.L. and an orange line
// representing discovery potential at 3σ. Both lines exhibit a downward trend as the 222Rn scaling increases.
// The message is that as 222Rn scaling increases, both sensitivity and discovery potential decrease. Panel (b)
// is a plot showing the relationship between the half-life (in units of 10^28 years) and the scaling of 137Xe.
// The y-axis ranges from 0.0 to 3.0, with a linear scale, and the x-axis ranges from 0.01 to 100, with a log
// scale. There are two series: a blue line representing sensitivity at 90% C.L. and an orange line representing
// discovery potential at 3σ. The blue line remains relatively stable before decreasing, while the orange line
// exhibits a slight downward trend as the 137Xe scaling increases. The message is that as 137Xe scaling
// increases, sensitivity and discovery potential decrease. Panel (c) is a plot showing the relationship between
// the half-life (in units of 10^28 years) and the scaling of γ background. The y-axis ranges from 0.0 to 3.0,
// with a linear scale, and the x-axis ranges from 0.01 to 10, with a log scale. There are two series: a blue
// line representing sensitivity at 90% C.L. and an orange line representing discovery potential at 3σ. Both
// lines exhibit a downward trend as the γ background scaling increases. The message is that as γ background
// scaling increases, both sensitivity and discovery potential decrease.
#figure(placement: top, scope: "parent", 
  image("figures/sensitivity_vs_background_scaling_linear_sameY.png", width: 100%),
  caption: [nEXO median sensitivity and $3 sigma$ discovery potential evaluated for hypothetical variations in background scale from (a) $""^(222) "Rn"$ decays in the LXe, (b) $""^(137) "Xe"$ production, and (c) all $gamma$ background components.],
) <fig:sens_vs_backgrounds>

$""^(222) "Rn"$ decays in the LXe contribute approximately 50\% of the total background budget, as discussed in @sec:materials. Because of the complexity and inherent uncertainty of estimating the nEXO radon content by up-scaling the EXO-200 experience, R&D, at this time focusing on devices to remove xenon contaminants, is ongoing. In particular, online removal could allow even lower levels of radon contamination thus improving the nEXO sensitivity. Therefore, the $0 nu beta beta$ sensitivity and $3 sigma$ discovery potential are also evaluated for values between 100x smaller than the Rn-background design value and up to 10x larger than the design value. The results are shown in @fig:sens_vs_backgrounds (a). In the most pessimistic scenario considered, the sensitivity reach would reduce to just below $10^28$~yr.

Albeit subdominant, backgrounds from $""^(137) "Xe"$ are particularly difficult to reject through their event topology because they arise from $beta$ decays nearly uniformly distributed in the FV. Estimates of cosmogenically-produced $""^(137) "Xe"$ are well understood but more advanced veto techniques than the simple scheme presented in @sec:exposure-based-bkg could further reduce this component. On the other hand, less is known about the $""^(137) "Xe"$ production rate from neutrons from $(alpha, n)$ reactions or spontaneous fission. @fig:sens_vs_backgrounds (b) presents the effect of a possible reduction or increase of $""^(137) "Xe"$ on the median $0 nu beta beta$ sensitivity and discovery potential at $3 sigma$, which are found to remain within ∼10\% of the baseline value up to a fourfold increase in $""^(137) "Xe"$ rates.

During further development of the experiment continued attention will be given to the benefits arising from reduced background and improved detector performance. A broader investigation of the impact from variations in the rate of $gamma$ backgrounds was therefore performed by scaling all $gamma$ background components (including $""^(214) "Bi"$ from out-of-equilibrium $""^(222) "Rn"$) and re-evaluating the $0 nu beta beta$ sensitivity and discovery potential. The results are shown in @fig:sens_vs_backgrounds (c). In particular, a power law fit to these curves, when plotted as a function of background index $B$, yields $T^(0 nu)_(1/2) ∝ B^(-0.22)$ and $T^(0 nu)_(1/2) ∝ B^(-0.26)$ for the sensitivity and discovery potential at $3 sigma$, respectively. The fitted power for the sensitivity represents a substantial improvement compared to the value of $-0.35$ reported in Ref.~@PhysRevC.97.065503, and brings nEXO closer to the background-free regime, where this power is zero.

To appreciate how close nEXO is to be a background-free experiment, we also considered the ideal scenario — wherein all backgrounds are perfectly removed with the exception of $2 nu beta beta$ — to determine the ultimate sensitivity of a LXe TPC experiment of nEXO's size. In this case, even the remaining contributions from $2 nu beta beta$ decays near $Q_(beta beta)$ are highly suppressed by the good energy resolution.

The resulting upper limit at 90\% CL obtained with the approach employed in this work is 1.9~counts, which is smaller than 2.44 counts as expected in the optimal case of a truly zero background experiment~@Feldman:1997qc. Following the approach suggested by the same reference, we used the latter value to calculate the sensitivity reach, which in this case results in $3.6 times 10^28$~yr.

== Comparison to a counting experiment

By incorporating all aspects of the experiment, we consider the $0 nu beta beta$ decay half-life sensitivity the most representative figure-of-merit of the experiment's design and performance. For comparison purposes, it is useful to summarize the complex background spatial distribution and the performance of the multi-parameter fit into a single parameter, as would be the case for a counting experiment.

Compared to our multi-dimensional likelihood analysis, in a counting-experiment analysis, all the information is collapsed into a single bin which only contains events passing all event selection cuts. This corresponds to SS-like events with energy within the range $Q_(beta beta)$ plus.minus FWHM/2 and position within the FV. The fraction of $0 nu beta beta$ events in this more narrowly-defined region of interest is 52.0\%. We assume that both the signal and background distributions are given by independent Poisson distributions with means $s$ and $b$, respectively.

Following the procedure above, one would generate many toy experiments producing different values for the observed number of events $n$ from a Poisson distribution with a mean of either $s + b$, to evaluate the discovery potential, or simply $b$, to obtain the sensitivity reach, and then compute the $p$-value with respect to the null hypothesis. The median significance obtained from the distribution of $p$-values exhibits a counter-intuitive saw-tooth behavior as a function of background $b$ due to the discrete nature of the observable counts. Instead, we follow the procedure outlined in Ref.~@Bhattiprolu:2020mwi, where the $p$-value of the average $n$ over all toy experiments is used to calculate the significance. The use of this so-called Asimov dataset overcomes the above mentioned shortcomings and results in a monotonic dependence of the $p$-value as a function of background.

The above procedure is used to calculate an effective background index for which such a counting experiment would yield the same half-life sensitivity at 90\% CL as the multi-dimensional likelihood analysis presented in the previous section. For nEXO's projected half-life sensitivity of $1.35 times 10^28$~yr at 90\% CL, the effective background index is equal to $b = 7 times 10^(-5)$~cts/(FWHM⋅kg⋅yr). While we have explored alternative methods for calculating the sensitivity~@Kumar:2015tna and discovery potential~@Cowan:2010js in the case of a counting experiment, we found the above method in combination with the Asimov dataset to be the most straightforward and to be neither overly optimistic nor conservative.

= Conclusions <sec:conclusion>

// [figvision] figures/sens_nexo_mmin_10yrs_v29.png
// Panel a. This is a plot showing the 90% CL exclusion sensitivity reach to the effective Majorana neutrino mass
// as a function of the lightest neutrino mass. The y-axis ranges from 10^-3 to 10^0 eV and the x-axis from 10^-4
// to 10^0 eV, both on a log scale. There are two series of curves, one in red for normal ordering (N.O.) and one
// in blue for inverted ordering (I.O.). Each series has a solid and a dashed line. The red series starts at
// around 10^-3 eV and increases to 10^0 eV, while the blue series starts at around 10^-2 eV and increases to
// 10^0 eV. There are also horizontal bands for EXO-200 and nEXO 10 Years, with the darker bands covering ∼68% of
// the NME values. The trend shows that as the lightest neutrino mass increases, the effective Majorana neutrino
// mass also increases. Panel b. No panel b is present in the image. Panel c. No panel c is present in the image.
// However, it seems like the whole figure is one panel with two parts, left and right. Therefore, I will
// describe it as one panel. The figure is a plot showing the 90% CL exclusion sensitivity reach to the effective
// Majorana neutrino mass as a function of the lightest neutrino mass for normal (left) and inverted (right)
// neutrino mass ordering. The y-axis ranges from 10^-3 to 10^0 eV and the x-axis from 10^-4 to 10^0 eV, both on
// a log scale. There are two series of curves, one in red for normal ordering (N.O.) on the left and one in blue
// for inverted ordering (I.O.) on the right. Each series has a solid and a dashed line. The red series starts at
// around 10^-3 eV and increases to 10^0 eV, while the blue series starts at around 10^-2 eV and increases to
// 10^0 eV. There are also horizontal bands for EXO-200 and nEXO 10 Years, with the darker bands covering ∼68% of
// the NME values. The trend shows that as the lightest neutrino mass increases, the effective Majorana neutrino
// mass also increases. The width of the horizontal bands derives from the uncertainty in nuclear matrix
// elements.
#figure(placement: top, 
  image("figures/sens_nexo_mmin_10yrs_v29.png", width: 99%),
  caption: [90\% CL exclusion sensitivity reach to the effective Majorana neutrino mass $angle(m_(beta beta))$ as a function of the lightest neutrino mass for normal (left) and inverted (right) neutrino mass ordering. The width of the horizontal bands derives from the uncertainty in nuclear matrix elements (see text) and the values of $angle(m_(beta beta))$ are calculated using $g_A = 1.27$. The darker bands covers ∼68\% of the NME values. The dashed contours of the normal neutrino mass ordering (NO) and inverted ordering (IO) bands result from the unknown Majorana phases and are, to this date, unconstrained. The outer solid lines incorporate the 90\% CL errors of the three-flavor neutrino fit of Ref.~@Esteban:2020cvm],
) <fig:lobster>

nEXO has been designed to exploit the advantages of the LXe TPC technology to search for $0 nu beta beta$ decay at the tonne scale. In this report we present an updated projection for the nEXO median sensitivity to the $0 nu beta beta$ decay half-life of $""^(136) "Xe"$, resulting in a new baseline-value of $1.35 times 10^28$~yr at 90\% CL in 10 years of livetime. The significant improvement obtained for the sensitivity reach compared to previous reports by the Collaboration results from the success of a comprehensive R&D program along with a refined design of the detector and improved data analysis tools.

// [figvision] figures/mbb_nexo.png
// ## Panel a: Not applicable, as there are only two panels, labelled top and bottom. ## Top panel This is a
// histogram plot. The y-axis is labelled "Counts" and ranges from 0 to 5. The x-axis is labelled " m_{} [meV]"
// and ranges from 0 to 30. There is one series, in blue, representing "Sensitivity, 90% C.L.". The blue series
// has a dashed vertical line at approximately 7 meV, indicating the median. Tick marks on the x-axis indicate
// individual values. The grey area is labelled "Inverted Neutrino Mass Ordering". The trend shows a distribution
// of sensitivity values with a median around 7 meV. ## Bottom panel This is also a histogram plot. The y-axis is
// labelled "Counts" and ranges from 0 to 5. The x-axis is labelled " m_{} [meV]" and ranges from 0 to 30. There
// is one series, in orange, representing "Discovery Potential, 3". The orange series has a dashed vertical line
// at approximately 10 meV, indicating the median. Tick marks on the x-axis indicate individual values. The grey
// area is labelled "Inverted Neutrino Mass Ordering". The trend shows a distribution of discovery potential
// values with a median around 10 meV.
#figure(
  image("figures/mbb_nexo.png", width: 45%),
  caption: [Effective Majorana mass $angle(m_(beta beta))$ sensitivity (top) and discovery potential (bottom) for nEXO for different NMEs, the standard light neutrino exchange mechanism and $g_A = 1.27$. While the $angle(m_(beta beta))$ is not a statistical variable, to guide the eye we also provide the medians of the $angle(m_(beta beta))$ "distributions" (vertical dashed lines of the same color). The individual $angle(m_(beta beta))$ values are indicated by the tick marks on the horizontal axis. The grey area represents the inverted neutrino mass ordering band with the solid and dashed lines corresponding to the lowest possible values of the contours in @fig:lobster.],
) <fig:mbb_hist>

Under the assumption that the $0 nu beta beta$ decay process is mediated by the exchange of a light Majorana neutrino~@Avignone:2007fu, the sensitivity to its half-life can be converted into a coverage region for the effective Majorana neutrino mass $angle(m_(beta beta))$ using:

$ "[" T^(0 nu)_(1/2) "]"^(-1) = angle(m_(beta beta))^2 / m_e^2 G_(0 nu) g_A^4 abs(M^(0 nu))^2 $ <eq:T-m>

where $m_e$ is the electron mass, $g_A$ the axial-vector coupling constant, $G_(0 nu)$ the kinematic phase-space factor, and $M^(0 nu)$ the nuclear matrix element. $angle(m_(beta beta))$ can be expressed in terms of the neutrino mass eigenvalues ($m_i$) and the PMNS neutrino mixing matrix elements ($U_(e i)$) by:

$ angle(m_(beta beta)) = abs(sum_(i=1)^3 U_(e i)^2 m_i) $ <eq:mee>

@fig:lobster shows the nEXO exclusion sensitivity to $angle(m_(beta beta))$ as a function of the lightest neutrino mass. These values are calculated using $g_A = 1.27$ and $G_(0 nu)$ from Ref.~@Kotila:2012zza. The allowed neutrino mass bands are derived from neutrino oscillation parameters in Ref.~@Esteban:2020cvm. The $angle(m_(beta beta))$ exclusion band between 4.7 and 20.3~meV arises from the full range of NMEs @Caurier2008 @Rodriguez2010 @Suhonen2010 @Simkovic2013 @Mustonen2013 @Meroni2013 @Vaquero2013 @Engel2014 @Hyvaerinen2015 @Barea2015 @Yao2015 @Horoi2016 @Menendez2018 @Simkovic2018 @Jokiniemi2018 @Fang2018 @Deppisch2020, represented by a light green band with NREDF~@Vaquero2013 and Deformed-QRPA~@Fang2018 at the minimum and maximum extremes, respectively.

Here we take an agnostic viewpoint and consider all NMEs available in the literature, and remove only those superseded by a more recent publication from the same authors. The $angle(m_(beta beta))$ reach of nEXO fully covers the inverted neutrino mass ordering by extending below 15~meV for all but one of the NMEs, and explores a significant portion of the normal ordering. This is further illustrated in @fig:mbb_hist, where the distribution of effective Majorana neutrino mass sensitivity and discovery potential are shown for the different NMEs.

#set heading(numbering: none)

= Acknowledgments

The authors gratefully acknowledge support for nEXO from the Office of Nuclear Physics within DOE's Office of Science, and NSF in the United States; from NSERC, CFI, FRQNT, NRC, and the McDonald Institute (CFREF) in Canada; from IBS in Korea; from RFBR in Russia; and from CAS and NSFC in China. This work was supported in part by Laboratory Directed Research and Development (LDRD) programs at Brookhaven National Laboratory (BNL), Lawrence Livermore National Laboratory (LLNL), Oak Ridge National Laboratory (ORNL), Pacific Northwest National Laboratory (PNNL), and SLAC National Accelerator Laboratory.

#set heading(numbering: (..nums) => numbering("A", ..nums))
#set heading(supplement: [App.])

= Statistical analysis <sec:appendix>

A binned-likelihood function is built from the model:

$ 𝓛 = "[" ∏_j (n_j^d_j e^(-n_j) / d_j!) "]" times ∏_k e^(-(N_k - N_k')^2 / (2 sigma_k^2)) $ <eq:likelihood>

where $n_j$ and $d_j$ are the expected and observed numbers of events in bin $j$, and the second product (indexed by $k$) contains two Gaussian constraints applied to two parameters in the fit. One of these parameters is the number of events from the $""^(222) "Rn"$ background component, which is expected to have its contribution measured #emph[in-situ] to within 10\% or better as obtained by the EXO-200 collaboration~@PhysRevC.92.015503, while the other constraint is applied to the number of events from $""^(8) "B"$ solar neutrinos, because its rate is tightly constrained by the Super-Kamiokande-IV experiment~@Abe:2016nxk. The NLL is minimized for each toy dataset using the Minuit software package~@1975CoPhC..10..343J @iminuit.

// [figvision] figures/brazil_plot_nominal_case_D024.png
// Panel a: This is a histogram plot showing the distribution of 90% upper limits for 5000 toy datasets. The
// y-axis represents the number of toy datasets, ranging from 0 to 250, and the x-axis represents the 90% upper
// limit on 0νββ events, ranging from 0 to 40. The black line represents the distribution of 90% upper limits. A
// blue dashed line indicates the median value of 6.65 counts. The plot also features three coloured regions:
// green (68% quantile, 2.92 to 11.6), yellow (95% quantile, 1.66 to 17.3), and a lighter shade of yellow (no
// specific label). The trend shows a decreasing distribution of upper limits.
#figure(
  image("figures/brazil_plot_nominal_case_D024.png", width: 50%),
  caption: [Distribution of upper limits $mu_90$ for 5000 toy datasets. The median corresponds to a bound on the $0 nu beta beta$ decay halflife of $T_(1/2)^(0 nu) > 1.35 times 10^28$ years.],
) <fig:90cl_distribution>

The confidence interval to reject the $0 nu beta beta$ decay hypothesis for each toy dataset is built using the profile likelihood ratio test:

$ lambda(mu) = cases(
  -2 space ln (𝓛_mu / 𝓛_hat(mu)), & hat(mu) >= 0
  -2 space ln (𝓛_mu / 𝓛_0), & hat(mu) < 0
) $ <eq:lambda>

where $𝓛_mu$ denotes the likelihood evaluated at a given value $mu$ of the signal hypothesis, #emph[i.e.], the value of $N_(0 nu)$ in @eq:bin_values, and the single hat denotes its global best fit value. In particular, $𝓛_0$ is the likelihood for null signal, $mu = 0$. For each toy experiment, we fit a parabola to $lambda(mu)$ calculated for various $mu$ hypotheses in order to determine the value $mu_90$ for which hypotheses equal or larger are excluded at the 90\% or higher CL This percentile is determined by the critical value $lambda_c(mu)$ calculated as explained below. The distribution of $mu_90$ for a sample toy dataset is shown in @fig:90cl_distribution.

The nearly background-free nature of the nEXO experiment may invalidate Wilks's approximation for the critical value $lambda_c$ of the NLL ratio test statistic that determines the percentiles of its distribution~@Wilks1938. For this reason, we numerically computed $lambda_c(mu)$ at several values of signal hypotheses $mu$ using a frequentist approach that employs MC simulation to generate and fit an ensemble of many toy experiments as suggested in Ref.~@Feldman:1997qc. A third-order spline is used to interpolate $lambda_c(mu)$ for any value of $mu$. This procedure was repeated for the different levels of backgrounds studied in this work, such as varying the detector livetime, and we found that it recovers the Wilk's approximation $lambda_c approx 2.71$ in the limit of large background rates.

// [figvision] figures/null_hypothesis_10yrs_42.png
// Panel a: This is a histogram plot showing sample distributions. The y-axis is labeled "Counts/bin" and ranges
// from 10^0 to 10^5. The x-axis is labeled "Significance of 0νββ signal, ΔNNL" and ranges from 0 to 20. There is
// one grey histogram representing the null hypothesis labeled "No 0νββ". There are also four colored histograms
// for alternative hypotheses: blue for ⟨0νββ⟩ = 8, orange for ⟨0νββ⟩ = 10, green for ⟨0νββ⟩ = 12, and purple for
// ⟨0νββ⟩ = 14. Vertical grey dashed lines are at 1, 2, 3, and 4 σ. Colored vertical lines show the median value
// for each alternative hypothesis. The trend shows that as the significance of the 0νββ signal increases, the
// counts/bin decreases for all hypotheses, with the null hypothesis distribution separated from the alternative
// hypothesis distributions.
#figure(
  image("figures/null_hypothesis_10yrs_42.png", width: 45%),
  caption: [Sample distributions of $q_0$ for the null hypothesis $H_0$ in grey and for alternative hypotheses $H_mu$ in color, with $mu = 8, 10, 12$ and 14. In total $10^5$ and $5 times 10^3$ toy datasets were simulated for the null hypothesis and the alternative hypotheses, respectively. The $p$-value is calculated from counting the number of toy datasets in the distribution for $H_0$ that are above the median value for $H_mu$, shown as vertical colored lines. The grey vertical dashed lines indicate the quantiles corresponding to $1 sigma$, $2 sigma$, $3 sigma$ and $4 sigma$ significance of discovery.],
) <fig:dp_nnl_distribution>

The discovery potential to $0 nu beta beta$ decay is determined from the signal hypothesis $mu$, $H_mu$, which produces an ensemble of toy experiments consistent with a given median significance to reject the null hypothesis, $H_0$. We apply the following test statistic to determine the discovery significance:

$ q_0 = cases(
  -2 space ln (𝓛_0 / 𝓛_hat(mu)) = -2 Delta "NLL", & hat(mu) > 0
  0, & hat(mu) <= 0
) $ <eq:q-zero>

where $q_0$ is null for $hat(mu) <= 0$ to avoid that positive fluctuations in background counts are considered as evidence against $H_0$. This approach requires first building the distribution of $q_0$ for $H_0$, and then evaluating similar distributions for various $H_mu$. The median of each of the latter distributions is compared to the percentiles obtained with $H_0$, and then the matching percentile is converted into a significance following Gaussian $z$-scores. For $z >= 4$, the $q_0$ distribution for $H_0$ is approximated by a $chi^2$ distribution because of the low statistics with these datasets. A linear interpolation is used to obtain the significance for any value of $mu$. An example distribution of significance for $H_0$ and $H_mu$, for $mu = 8, 10, 12$ and 14 is shown in @fig:dp_nnl_distribution.

#show bibliography: set text(size: 8pt)
#bibliography("refs.bib", style: "ieee", title: [References])