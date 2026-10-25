#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.96cm, top: 2.66cm, bottom: 1.92cm))
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.08em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 1.08em)
#set figure.caption(position: bottom)
#show figure.caption: set text(size: 8.5pt)
#show figure.caption: set par(leading: 0.55em)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(14.3pt, weight: "bold", [Layer Hall effect in a 2D topological Axion antiferromagnet])
  #v(1em)
  #text(10.5pt)[Anyuan Gao1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Yu-Fei Liu1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Chaowei Hu, Jian-Xiang Qiu1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Christian Tzschaschel1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Barun Ghosh1.2 Department of Physics, Indian Institute of Technology, Kanpur, India1.2 Department of Physics, Northeastern University, Boston, MA 02115, USA, Sheng-Chin Ho1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Damien Bérubé1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA, Rui Chen, Haipeng Sun, Zhaowei Zhang1.2 Division of Physics and Applied Physics, School of Physical and Mathematical Sciences, Nanyang Technological University, Singapore 637371, Singapore, Xin-Yue Zhang1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, Yu-Xuan Wang1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, Naizhou Wang1.2 Division of Physics and Applied Physics, School of Physical and Mathematical Sciences, Nanyang Technological University, Singapore 637371, Singapore, Zumeng Huang1.2 Division of Physics and Applied Physics, School of Physical and Mathematical Sciences, Nanyang Technological University, Singapore 637371, Singapore, Claudia Felser1.2 Max Planck Institute for Chemical Physics of Solids, Nöthnitzer Strae 40, 01187 Dresden, Germany, Amit Agarwal, Thomas Ding1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, Hung-Ju Tien1.2 Department of Physics, National Cheng Kung University, Tainan 701, Taiwan, Austin Akey1.2 Center for Nanoscale Systems, Harvard University, Cambridge, MA 02138, USA, Jules Gardener1.2 Center for Nanoscale Systems, Harvard University, Cambridge, MA 02138, USA, Bahadur Singh1.2 Department of Condensed Matter Physics and Materials Science, Tata Institute of Fundamental Research, Colaba, Mumbai 400005, India, Kenji Watanabe1.2 Research Center for Functional Materials, National Institute for Materials Science, 1-1 Namiki, Tsukuba 305-0044, Japan, Takashi Taniguchi1.2 International Center for Materials Nanoarchitectonics, National Institute for Materials Science, 1-1 Namiki, Tsukuba 305-0044, Japan, Kenneth S. Burch1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, David C. Bell1.2 Center for Nanoscale Systems, Harvard University, Cambridge, MA 02138, USA, Brian B. Zhou1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, Weibo Gao1.2 Division of Physics and Applied Physics, School of Physical and Mathematical Sciences, Nanyang Technological University, Singapore 637371, Singapore, Hai-Zhou Lu, Arun Bansil, Hsin Lin, Tay-Rong Chang, Liang Fu1.2 Department of Physics, Massachusetts Institute of Technology, Cambridge, MA 02139, USA, Qiong Ma1.2 Department of Physics, Boston College, Chestnut Hill, MA, USA, Ni Ni1.2 Department of Physics and Astronomy and California NanoSystems Institute, University of California, Los Angeles, Los Angeles, CA 90095, USA., Su-Yang Xu1.2 Department of Chemistry and Chemical Biology, Harvard University, MA 02138, USA]
]
#v(1em)

#strong[While ferromagnets have been known and exploited for millennia, antiferromagnets (AFMs) were only discovered in the 1930s @neel1972magnetism. The elusive nature indicates AFMs' unique properties: At large scale, due to the absence of global magnetization, AFMs may appear to behave like any non-magnetic material; However, such a seemingly mundane macroscopic magnetic property is highly nontrivial at microscopic level, where opposite spin alignment within the AFM unit cell forms a rich internal structure. In topological AFMs, such an internal structure leads to a new possibility, where topology and Berry phase can acquire distinct spatial textures @li2013coupling@gao2014field. Here, we study this exciting possibility in an AFM Axion insulator, even-layered MnBi$""_2$Te$""_4$ flakes, where spatial degrees of freedom correspond to different layers. Remarkably, we report the observation of a new type of Hall effect, the layer Hall effect, where electrons from the top and bottom layers spontaneously deflect in opposite directions. Specifically, under no net electric field, even-layered MnBi$""_2$Te$""_4$ shows no anomalous Hall effect (AHE); However, applying an electric field isolates the response from one layer and leads to the surprising emergence of a large layer-polarized AHE ($tilde.op 50 % e^2 / h$). Such a layer Hall effect uncovers a highly rare layer-locked Berry curvature, which serves as a unique character of the space-time $cal(P T)$-symmetric AFM topological insulator state. Moreover, we found that the layer-locked Berry curvature can be manipulated by the Axion field, $bold(E) dot.op bold(B)$, which drives the system between the opposite AFM states. Our results achieve previously unavailable pathways to detect and manipulate the rich internal spatial structure of fully-compensated topological AFMs @chen2014anomalous@nakatsuji2015large@nayak2016large@mong2010antiferromagnetic@vsmejkal2018topological@tokura2019magnetic@mong2019magnetic@xu2020high@cheong2020seeing. The layer-locked Berry curvature represents a first step towards spatial engineering of Berry phase, such as through layer-specific moiré potential.]

Ever since navigation was achieved by a piece of lodestone, magnetism has played a central role in fundamental research and technology developments. As we enter the quantum era, an important frontier of modern condensed matter is to search for quantum magnets, where electronic correlations, symmetry breakings, Berry phase, etc. interact with magnetism, leading to exotic phenomena that don't exist in conventional magnetic materials. Under such a scope, antiferromagnetism is an elementary yet fascinating type of magnetic order. Antiferromagnets (AFMs) are internally magnetic, but the zero net magnetization makes the magnetism externally invisible. Although the rich internal magnetic structure does not manifest as a global magnetization, it can profoundly affect many other macroscopic properties, leading to novel physics: In strongly-correlated electronic systems, the internal anti-parallel spin structure promotes virtual hopping @lee2006doping, making AFM a favorable ground state in most un-doped Mott insulators. In some multiferroics, the internal AFM spin structures can break spatial symmetries, leading to finite magnetoelectric coupling @fiebig2005revival. In spintronics, the internal spin structure protects the magnetic data from external perturbations, which motivates the fast-developing AFM spintronics @jungwirth2016antiferromagnetic.

Compared to its prominent role in areas above, AFM has not featured prominently in the field of topological materials. However, recent theoretical works @essin2009magnetoelectric@mong2010antiferromagnetic@li2013coupling@gao2014field@tang2016dirac@sivadas2016gate@wang2016generation@Zhang2019a@armitage2019matter@vsmejkal2020crystal@xu2020high@cheong2020seeing@Du2020a@wang2020giant@fei2020giant have increasingly recognized this exciting prospect. A multitude of fundamentally new topological phenomena that uniquely arise from the interplay between AFM and topology, including the condensed matter realization of Axions (a Dark matter candidate) @li2010dynamical, the generation of dissipationless spin current in the absence of a concomitant charge current @wang2016generation, as well as the presence of giant/quantized magneto-electric and magneto-optoelectronic couplings @essin2009magnetoelectric@Zhang2019a@armitage2019matter@wang2020giant@fei2020giant, have been proposed. Further integrating these new topological physics with spintronics can give rise to the topological AFM spintronics @vsmejkal2018topological, where the storage, transportation and manipulation of magnetic data can become much faster, more robust and energy-efficient.

To experimentally fulfill the great potential, crucial open questions, including how topology and Berry curvature are encoded in AFMs and how they can be controlled, remain to be answered. In ferromagnetic topological states, the spontaneous AHE has been widely used to detect the total Berry curvature @nagaosa2010anomalous. By contrast, in AFMs, the existence of spontaneous AHE is extremely rare. Hence, finding AHE in AFMs, by itself, is of great interest. A primary example is the recent breakthrough identifying the sizable spontaneous AHE in non-collinear antiferromagnets Mn$""_3$X (X=Sn or Ge) @chen2014anomalous@nakatsuji2015large@nayak2016large. The sizable spontaneous AHE of Mn$""_3$X therefore directly measures its total Berry curvature. However, as discussed above, the primary characteristic of AFMs is its internal structure. This raises highly intriguing possibilities beyond the spontaneous AHE and the total Berry curvature. We can ask whether topology and Berry phase can acquire distinct spatial structures @li2013coupling@gao2014field and whether such spatially-locked Berry phase can give rise to new kinds of Hall responses. Here, we investigate these exciting possibilities in even-layered MnBi$""_2$Te$""_4$ flakes. We report the observation of a fundamentally new type of Hall effect, the layer Hall effect.

Beyond charge, electrons can feature additional degrees of freedom such as spin, valley and layer. Encoding Berry curvature with these novel degrees of freedom may lead to new types of Hall effect. A primary example is the valley Hall effect (Fig.~#ref(<Fig1>, supplement: none)#strong[a]), which has been realized in gapped graphene and transition metal dichalcogenides @xiao2010berry. The layer Hall effect studied here is a novel phenomenon where electrons from the top and bottom layers deflect in opposite directions (Fig.~#ref(<Fig1>, supplement: none)#strong[b]).

MnBi$""_2$Te$""_4$ has recently attracted great interest #cite(<Otrokov2019a>)@Rienks2019@Lee2019a@Yan2019@Zhang2020b@Zhang2019a@Gordon2019@Chen2019@Hao2019@Swatek2020a@Deng2020@Liu2020a@Ge2020@Liu2020b@Deng2020a@Ovchinnikov2020 since it bridges topology, magnetism and 2D van der Waals (vdW) materials. Its crystal lattice consists of septuple layers (SLs) separated by vdW gaps. Each SL contains seven atomic layers in the sequence of Te-Bi-Te-Mn-Te-Bi-Te. Its magnetic ground state is A-type AFM, where Mn spins within each SL are ferromagnetically aligned along the $z$ axis but Mn spins between adjacent SLs are anti-parallel. Moreover, applying a magnetic field along the $z$ axis can drive the AFM first to a spin-flop phase ($gt.eq 4$ T) and then to a fully polarized ferromagnetic phase ($gt.eq 8$ T) @Lee2019a@Yan2019. Therefore, the magnetic and topological states of 2D MnBi$""_2$Te$""_4$ flakes can be categorized into two kinds. The first kind is ferromagnetic or ferromagnetic-like, where the 2D system has unequal number of up-spin-layers and down-spin-layers and therefore features an obvious global magnetization. These systems break $cal(P T)$ symmetry. They include odd-layered and even-layered MnBi$""_2$Te$""_4$ flakes under high magnetic fields as well as odd-layered MnBi$""_2$Te$""_4$ flakes near zero magnetic field. In these ferromagnetic or ferromagnetic-like systems, pioneering works @Deng2020@Liu2020a@Ge2020@Liu2020b@Deng2020a@Ovchinnikov2020 have reported large/quantized AHE and consistently demonstrated the topological Chern insulator state under high magnetic field. On the other hand, the second kind is the fully-compensated AFM, where the 2D system has an equal number of up-spin-layers and down-spin-layers. These systems preserve $cal(P T)$ symmetry. They include even-layered AFM MnBi$""_2$Te$""_4$, which are the focus here. In particular, the even-layered MnBi$""_2$Te$""_4$ is expected to realize the Axion insulator phase, an exotic yet highly rare AFM topological state. Previous works @mogi2017tailoring@xiao2018realization@Liu2020a@Deng2020 have prepared the condition for this phase and observed a highly insulating behavior with zero Hall conductivity. However, the topological and Berry phase properties of the Axion insulator have not been directly probed. We will first focus on presenting the data. Then we will explain how these data demonstrate the layer Hall effect.

We have fabricated high-quality, dual-gated MnBi$""_2$Te$""_4$ devices (Fig.~#ref(<Fig1>, supplement: none)#strong[c]). The dual gating, which has not been explored in MnBi$""_2$Te$""_4$ especially in even-layered devices @Deng2020@Liu2020a@Ge2020@Liu2020b@Deng2020a@Ovchinnikov2020@Zhang2020b, is crucial for our experimental findings here, as it allows independent control of the charge density $n$ and the out-of-plane electric field $E$. Particularly, we can set the charge density $n$ at a desired value and study how the system behaves as we only vary the electric field. By contrast, with a single gate, $n$ and $E$ are intrinsically coupled, making the studies of electric field dependence impractical. Moreover, to address the sensitive chemical nature of 2D MnBi$""_2$Te$""_4$ flakes, we have adapted a high-resolution stencil mask technique (see Methods), enabling us to complete all fabrication processes in an argon environment without exposure to air, chemicals, or heat, therefore preserving the intrinsic nature of the samples. In the main text, we focus on the behavior of a 6SL MnBi$""_2$Te$""_4$ device (see Extended Data Fig.~#ref(<Extended_Data_Figure_QAHE>, supplement: none)#strong[a] for the device image). The overall magnetic behaviors show the expected phase diagram (Fig.~#ref(<Fig1>, supplement: none)#strong[d]), including the high-temperature paramagnetic state, the low-temperature AFM ground state, and the magnetic-field-induced ferromagnetic state; (2) The magnetic-field-induced ferromagnetic state is found to be a topological Chern insulator as demonstrated by the vanishing longitudinal resistance $R_(x x)$ and fully ($100 %$) quantized Hall resistance $R_(y x)$ (Extended Data Figs.~#ref(<Extended_Data_Figure_QAHE>, supplement: none)#strong[b-d]). These behaviors are all consistent with previous works @Deng2020@Liu2020a@Ge2020@Liu2020b@Deng2020a@Ovchinnikov2020.

We now focus on the AFM ground state. The longitudinal resistance $R_(x x)$ (Fig.~#ref(<Fig1>, supplement: none)#strong[e]) as a function of the backgate voltage $V_("BG")$ peaks sharply, signaling insulating behavior at charge neutrality. The Hall resistance $R_(y x)$ (Fig.~#ref(<Fig1>, supplement: none)#strong[f]) features a clear sign-reversal also at charge neutrality. We note that, in order to eliminate the mixing of $R_(x x)$ and $R_(y x)$ signals, the $R_(y x)$ data in the main text are anti-symmetrized following conventions widely-established in the community @nagaosa2010anomalous. These $R_(x x)$ and $R_(y x)$ data allow us to obtain the carrier mobility using two independent methods, the field effect model and Hall effect model. Both methods consistently yield a carrier mobility $tilde.op 1.1 times 10^3$ cm$""^2$/V$dot.op$s, which is among the highest reported in MnBi$""_2$Te$""_4$ @Deng2020@Liu2020a@Ge2020@Liu2020b@Deng2020a@Ovchinnikov2020, highlighting the importance of preserving the intrinsic nature during fabrication. We further study the magnetic-field dependence of $R_(y x)$. As shown in Fig.~#ref(<Fig2>, supplement: none)#strong[a], in the AFM phase, the $R_(y x)$ depends linearly on $B$ field and crosses zero at $B = 0$; The forward and backward scans entirely overlap. These observations confirm that the AFM phase does not support any spontaneous AHE, revealing a vanishing total Berry curvature in even-layered MnBi$""_2$Te$""_4$. As such, the transport measurements above do not show distinct evidence for nontrivial topology/Berry curvature in the AFM phase of 6SL MnBi$""_2$Te$""_4$. In fact, the observed diverging resistance and vanishing AHE are common behaviors of any nonmagnetic semiconductors. A new experimental tuning parameter is needed to uniquely uncover the rich Berry curvature properties in this AFM topological system.

We now explore the electric field dependence of the AFM phase. We turn on a finite electric field and repeat the measurement of Fig.~#ref(<Fig2>, supplement: none)#strong[a], holding the charge density $n$ and other conditions unchanged. Strikingly, as shown in Fig.~#ref(<Fig2>, supplement: none)#strong[b], we observe that the forward and backward scans become clearly separated in the AFM phase, suggesting the emergence of a large AHE upon the application of electric field. We now study how this AHE depends on $E$ field. Figure~#ref(<Fig2>, supplement: none)#strong[c] shows the AHE conductance at $B = 0$ as a function of $E$ field while keeping the charge density $n$ at a fixed value in the electron-doped regime ($n = + 1.5 times 10^12$ cm$""^(- 2)$). Remarkably, we found that the AHE flips sign as the direction of the $E$ field switches. We also change the charge density to the hole-doped regime ($n = - 1.4 times 10^12$ cm$""^(- 2)$) and repeat the measurement (Extended Data Fig.~#ref(<Extended_Data_Figure_Sigma_E_Calculation>, supplement: none)#strong[a]), again, the sign-reversal with respect to $E$ field is observed. We highlight that such an electric-field-reversible AHE has not been achieved previously. It also represents the most fundamental piece of evidence for the layer Hall effect.

We then study how the AHE depends on the charge density $n$. Figure~#ref(<Fig3>, supplement: none)#strong[a] shows the AHE conductance as a function of $n$ while keeping $E$ field fixed. Interestingly, the AHE is found to show opposite signs depending on whether the system is electron-doped or hole-doped. On the other hand, at charge neutrality, the AHE vanishes. We repeat the measurement with smaller $E$. As shown in Fig.~#ref(<Fig3>, supplement: none)#strong[b], we observe a similar dependence on $n$, although the overall magnitude of the AHE reduces significantly. In Extended Data Figs.~#ref(<Extended_Data_Figure_5SL>, supplement: none)#strong[a,b], we present results on odd-layered MnBi$""_2$Te$""_4$ devices. As described above, odd-layered MnBi$""_2$Te$""_4$ is ferromagnetic-like because it has different number of up-spin layers and down-spin layers. As such, it naturally supports AHE without $E$ field. As shown in Extended Data Figs.~#ref(<Extended_Data_Figure_5SL>, supplement: none)#strong[a,b], the AHE in odd-layered MnBi$""_2$Te$""_4$ remains the same sign as one changes the system from hole-doped to electron-doped, consistent with previous results on odd-layered MnBi$""_2$Te$""_4$ @Deng2020 and on ferromagnetic Cr- and V-doped topological insulator films @chang2013experimental@kou2014scale@fan2014magnetization@chang2015high@tokura2019magnetic. The dependence on charge density of the $E$-field-induced AHE in even-layered AFM MnBi$""_2$Te$""_4$, combined with the distinctly different behavior in odd-layered ferromagnetic-like systems, provides important insights into its microscopic origin. Moreover, the AHE's dependence on charge density also demonstrates that the AHE is not a direct measurement of the magnetization @nagaosa2010anomalous@xiao2010berry@matsukura2015control (see VI.6 for detailed discussion).

We further study the temperature dependence of the AHE. As shown in Extended Data Fig.~#ref(<Extended_Data_Figure_Temperature_Dependence>, supplement: none)#strong[b], at $T = 2$ K, the AHE is pronounced. As we increase temperature to 14 K, the AHE persists but weakens. As we further increase temperature to be above the Néel temperature ($T_("N") tilde.op 21$ K), the AHE is found to vanish entirely. Such temperature dependence demonstrates that the observed AHE is a unique response of the magnetically ordered state.

We enumerate here the key essential data, including the absence of the AHE without $E$ field, the emergence of the AHE upon the application of $E$ field, the AHE's sign-reversal with respect to $E$ field, its unique charge density dependence, its temperature dependence, as well as its sharp contrast with respect to the AHE in odd-layered systems. These data are crucial for excluding various extrinsic effects. For instance, defects and inhomogeneities formed during crystal growth may cause one particular Mn-layer to have a much stronger (or weaker) magnetization than the other Mn layers, thereby breaking the full compensation between up-spins and down-spins. This would lead to a finite magnetization and in turn a spontaneous AHE. In that case, the system should be viewed effectively as a (weak) ferromagnet rather than a fully-compensated AFM. However, the sign of the AHE in a ferromagnet is uniquely tied to the direction of the global magnetization, which cannot be significantly altered or switched by an out-of-plane electric field. Therefore, the AHE of a ferromagnet should not respond dramatically to the electric field, let alone reversing its sign when the electric field is flipped.

We now consider the possibility that the observed AHE is the intrinsic response of the topological AFM phase in 6SL MnBi$""_2$Te$""_4$. First, we investigate this possibility from a global symmetry point of view. It has been established that the AHE conductivity arises from the total Berry curvature integrated over all occupied state @nagaosa2010anomalous, i.e., $sigma^("AHE") = integral_("occupied states") Omega$, where $Omega$ is the Berry curvature. Importantly, both $cal(T)$ (time-reversal symmetry) and $cal(P T)$ (the combination of time-reversal and space-inversion symmetries) would force $sigma^("AHE")$ to vanish. Therefore, for a material to support nonzero AHE, both $cal(T)$ and $cal(P T)$ need to be broken. While all magnetic states break $cal(T)$, what is intriguing about the current AFM is that its internal spin structure preserves $cal(P T)$. Such a $cal(T)$-breaking but $cal(P T)$-symmetric AFM provides the distinct symmetry conditions that uniquely enable an $E$-field-induced AHE: (1) In the absence of $E$ field, the $cal(P T)$ symmetry forces the momentum-integrated Berry curvature and therefore the AHE to vanish; (2) The application of $E$ field breaks $cal(P T)$, which, combined with the fact that $cal(T)$ is already broken, leads to the emergence of a finite AHE; (3) Since the $E$ field provides the critical $cal(P T)$-breaking that results in the nonzero AHE, flipping the $E$ field reverses the way in which $cal(P T)$ is broken, which, in turn, reverses the sign of the AHE. This symmetry analysis is consistent with our experimental observations, providing key evidence for the intrinsic nature.

In order to gain insights beyond the global symmetry analysis, we now examine the microscopic mechanism. As a starting point, a nonmagnetic topological insulator features massless Dirac fermions on its top and bottom surfaces (Fig.~#ref(<Fig3>, supplement: none)#strong[e]). Massless Dirac fermions have no Berry curvature ($Omega = 0$) and thus no AHE. The inclusion of a magnetic order gaps these Dirac fermions, leading to giant Berry curvatures in each individual Dirac band (Fig.~#ref(<Fig3>, supplement: none)#strong[f]). Due to combination of the A-type AFM spin structure and the even number of layers, the top and bottom Dirac fermions experience opposite magnetizations and hence open up gaps in the opposite fashion (Fig.~#ref(<Fig3>, supplement: none)#strong[f]). As such, the Berry curvature contributed by the top Dirac fermion exactly cancels out that contributed by the bottom Dirac fermion, giving rise to a layer-locked Berry curvature. Interestingly, $E$ field can strongly break the degeneracy between top and bottom surfaces. $E > 0$ makes the contribution of the bottom layer more dominant, whereas $E < 0$ makes the contribution of the top layer more dominant. In other words, the direction of the $E$ field allows us to selectively probe the contribution from one layer over the opposite.

We now further study the dependence on the charge density $n$. We use the charge neutrality with $sigma^("AHE") = 0$ as a reference point. Importantly, we note that the Berry curvature ($Omega$) of the lowest conduction band and that of the highest valence band are of the same sign in our cases (Fig.~#ref(<Fig3>, supplement: none)#strong[g]). Therefore, going from charge neutrality to the electron-doped regime, we add a certain $Omega$; Going from charge neutrality to the hole-doped regime, we remove the same $Omega$. Consequently, under the same $E$ field, the layer-polarized AHE in the electron-doped regime and in the hole-doped regime has opposite sign, which is consistent with our experimental observations. We highlight that the sign-reversal with $n$ is a unique signature of the layer Hall effect in $cal(P T)$-symmetric AFM topological insulator (i.e., our even-layered MnBi$""_2$Te$""_4$ samples). By contrast, in ferromagnetic or ferromagnetic-like systems where there is already a nonzero magnetization $M$, the AHE has the same sign in both electron-doped and hole-doped regimes (see Extended Data Fig.~#ref(<Extended_Data_Figure_5SL>, supplement: none)).

We now directly compute the band structure, Berry curvature and $sigma^("AHE")$ of 6SL MnBi$""_2$Te$""_4$ using both first-principles calculations and tight-biding model calculations. Figures~#ref(<Fig3>, supplement: none)#strong[c,d] and Extended Data Figs.~#ref(<Extended_Data_Figure_Sigma_E_Calculation>, supplement: none)#strong[c,d] show the first-principles calculated results, which display good agreement with our experimental data on key aspects including the overall magnitude of the $sigma^("AHE")$ and $sigma^("AHE")$'s sign-reversal with respect to $E$ and $n$. We note that the existence of a large layer-polarized AHE arising from a tiny Fermi energy ($lt.eq 100$ meV for our experiments) suggests giant Berry curvature 'per electron', favoring the intrinsic Berry curvature origin over the extrinsic defect scattering origin for the AHE. This is consistent with the magnetic Dirac fermions, where large Berry curvatures are generated near the edges of the band gap. Additionally, we note that theoretical calculations also capture interesting details of our experimental data, such as the weak non-monotonic behavior at relatively large $E$. Overall, our measurements with dual-gated devices therefore uncover unique gate dependencies, consisting of sign-reversals as a function of both $E$ and $n$. These distinct experimental features provide a large parameter space, which allows us to compare them with theoretical analysis and calculations. The $E$-field reversible AHE, taken together with the layer selectivity of the $E$ field, provides convincing evidence for the layer Hall effect and the layer-locked Berry curvature in MnBi$""_2$Te$""_4$. Notably, the layer Hall effect is already present at $E = 0$, although it only manifests itself upon the application of $E$-field.

We now explore how one can manipulate the layer-locked Berry curvature. Because the layer-locked Berry curvature is induced by the AFM order, it can be switched by driving the system between the two opposite AFM states (Fig.~#ref(<Fig4>, supplement: none)#strong[a]). In ferromagnets, it is well known that one can switch between the two states (magnetization up or down) by $B$ field. Similarly, in ferroelectrics, $E$ field can switch between the electric polarization up and down states. Very interestingly, in our $cal(P T)$-symmetric AFM Axion insulator system, neither $B$ nor $E$ alone can accomplish the switching. Rather, the Maxwell's equations in MnBi$""_2$Te$""_4$ are expected to be strongly modified by adding an Axion field term $Delta L = theta frac(e^2, 2 pi h c) bold(E) dot.op bold(B)$ @armitage2019matter@li2010dynamical, leading to unconventional electromagnetic responses. In particular, the AFM order in the Axion insulator state is expected to couple strongly to the Axion $bold(E) dot.op bold(B)$ field @fiebig2005revival@li2010dynamical@wang2019dynamic. Although $Delta L$ can be nonzero in magneto-electric and multiferroic materials @fiebig2005revival@wang2019dynamic (which are by themselves highly rare and of great interest), there are ample additional interest and merits to explore it in a topological Axion insulator @armitage2019matter (see discussions below).

To verify the Axion field $bold(E) dot.op bold(B)$ manipulation, we now examine the hysteresis observed in our $R_(y x)$ $v s$ $B$ data (e.g. Fig.~#ref(<Fig4>, supplement: none)#strong[b]) focusing on the two AFM states. We first study the forward scan (red curve) in Fig.~#ref(<Fig4>, supplement: none)#strong[b]. Starting from $- 8$ T, we increase $B$ field, which controls the magnetism of the system. At $B tilde.eq - 4$ T, the system changes from the spin-flop phase to the AFM phase. On a separate front, a constant, negative $E$ field is always applied in Fig.~#ref(<Fig4>, supplement: none)#strong[b]. Therefore, at $B tilde.eq - 4$ T, the system enters the AFM phase with a positive $bold(E) dot.op bold(B)$ field ($E < 0$ and $B < 0$). This $bold(E) dot.op bold(B)$ field can favor one AFM state over the other. Similarly, for the backward scan (blue curve), the system changes from the spin-flop phase to the AFM phase at $B tilde.eq + 4$ T. In that case, a negative $bold(E) dot.op bold(B)$ is applied near the transition, therefore favoring the opposite AFM state. We note that this control is achieved by going through the meta-magnetic transition from the spin-flop phase to AFM phase with a finite $bold(E) dot.op bold(B)$. As a result, the system changes from spin-flop to a particular AFM state, rather than to both AFM states with equal probability.

To confirm this interpretation, we continue to discuss Fig.~#ref(<Fig4>, supplement: none)#strong[b]. For the forward scan in Fig.~#ref(<Fig4>, supplement: none)#strong[b], when the system enters the AFM phase at $B tilde.eq - 4$ T, it experiences a positive $bold(E) dot.op bold(B)$ field, which favors AFM state I. As we continue to scan forward, from $- 4$ T to $0$ T, the $bold(E) dot.op bold(B)$ field remains positive. However, as we move to the $B > 0$ region, $bold(E) dot.op bold(B)$ turns negative, which favors state II. This negative $bold(E) dot.op bold(B)$ will continue to grow stronger as $B$ increases from $0$ T to $+ 4$ T. At this point, whether state I can be switched to state II depends on whether $bold(E) dot.op bold(B)$ can reach the coercive field $( bold(E) dot.op bold(B) )_("c")$. Interestingly, in Fig.~#ref(<Fig4>, supplement: none)#strong[b], the forward scan shows no sign of switching from state I to II, suggesting that $bold(E) dot.op bold(B)$ fails to reach the coercive field $( bold(E) dot.op bold(B) )_("c")$ all the way until the system is changed from AFM to spin-flop at $B tilde.eq + 4$ T. This allows us to make a prediction: If we can repeat the measurement but apply a stronger $E$ field, then we can expect to reach the coercive field $( bold(E) dot.op bold(B) )_("c")$ at a lower $B$ field. Indeed, this is confirmed by the measurement shown in Fig.~#ref(<Fig4>, supplement: none)#strong[c], where the switching between the AFM state I and AFM state II are observed in both forward and backward scans, beyond which the two scans overlap. This confirms our prediction and provides a powerful validation of our understanding. Therefore, we have demonstrated that the Axion field $bold(E) dot.op bold(B)$ can switch between the AFM states. This, in turn, manipulates the layer-locked Berry curvature, which is monitored by the layer Hall effect.

Such an unconventional pseudo-scalar field paves the way for versatile electrical manipulation. In Fig.~#ref(<Fig4>, supplement: none)#strong[d], we fix the $B$ field at $B = + 1$ T and scan the $E$ field back and forth. Remarkably, we observe clear hysteresis as a function of $E$ field, which shows a rather unconventional butterfly-like shape. This is because the $E$ field has two important roles: First, $E$ and $B$ together provide the $bold(E) dot.op bold(B)$ field that manipulates the AFM states; Second, $E$ is needed to generate the layer-polarized AHE. As such, we can consistently understand the distinct shape of the hysteresis. In Figs.~#ref(<Fig4>, supplement: none)#strong[b,c], we scan $B$. Because $E$ field is fixed, a finite AHE is always generated. This leads to a square-like hysteresis loop where the forward and backward scans are fully separated near $B = 0$. In sharp contrast, in Fig.~#ref(<Fig4>, supplement: none)#strong[d], we scan $E$ with a fixed $B$. At $E = 0$, even though a distinct AFM state is favored, the layer-polarized AHE vanishes because of the absence of $E$ field. This leads to a butterfly-like hysteresis where the forward and backward scans coincide at $E = 0$. Therefore, the observation of clear hysteresis with respect to $E$ and its butterfly shape provide evidence for electrical switching. By sweeping $E$ back and forth, repeatable switching is observed Fig.~#ref(<Fig4>, supplement: none)#strong[e].

While our main goal here is to manipulate the layer-locked Berry curvature by the Axion field $bold(E) dot.op bold(B)$, we note that the electrical detection and control of the AFM order by itself is at the core of modern research in spintronics, magnetoelectrics, and multiferroics @fiebig2005revival@jungwirth2016antiferromagnetic. The prospect of controlling topological magnets is particularly exciting. In our work, first, the Axion field and the layer Hall effect serve as new manipulation and electrical readout methods for the rich internal spatial structures of novel topological AFMs with fully-compensated magnetism. This was not possible previously. Second, we achieve electric control with minimal energy dissipation while retaining the ability to pass a current, offering a new regime that combines the advantages of insulating @fiebig2005revival@matsukura2015control@huang2017layer@jiang2018electric and metallic @jungwirth2016antiferromagnetic@matsukura2015control@liu2012spin@tsai2020electrical spintronics. Third, achieving $bold(E) dot.op bold(B)$ control locally will allow us to engineer topological AFM domain wall and Berry curvature moiré lattice (Extended Data Fig.~#ref(<Extended_Data_Figure_Future>, supplement: none)). These novel topological properties are absent in conventional magneto-electric materials.

Moving forward, our observations suggest many exciting possibilities. First, the layer Hall effect uncovers a unique topological response of fully-compensated AFM Axion insulators, which can be used to distinguish from other materials. For instance, noncentrosymmetric topological materials feature the valley Hall effect @mak2014valley or the nonlinear Hall effect @sodemann2015quantum, ferromagnetic topological materials feature the AHE @nagaosa2010anomalous, whereas the fully-compensated AFM Axion insulators feature the layer Hall effect. Second, the layer Hall effect allows us to understand how Berry phase manifests itself in a fully-compensated AFM with unique Axion topology: Unprecedentedly, Berry curvature is found to acquire a spatial texture. This realization represents the first step towards spatial engineering of Berry phase, such as through layer-specific moié potential (Extended Data Fig.~#ref(<Extended_Data_Figure_Future>, supplement: none)#strong[b]). The spatially-locked Berry curvature can significantly modify the electrical, spin, optical, and optoelectronic properties of topological AFMs, giving rise to novel effects @li2013coupling@sivadas2016gate@wang2016generation@wang2020giant@fei2020giant such as $E$-field-induced magneto-optical effects, dissipationless spin currents and topological AFM domain wall modes. Third, our demonstration of the Axion field $bold(E) dot.op bold(B)$ manipulation of the AFM states indicates strong magneto-electric coupling in even-layered MnBi$""_2$Te$""_4$. Although the magneto-electric coupling is also present in conventional magneto-electric and multiferroic materials such as Cr$""_2$O$""_3$ @fiebig2005revival@Iyama_2013 and CrI$""_3$ @huang2017layer@jiang2018electric, MnBi$""_2$Te$""_4$ is the first magneto-electric system that supports magneto-electric control and nontrivial topology simultaneously. Moreover, conventional magneto-electrics are wide-gap magnetic insulators that do not support electrical transport at all. By contrast, MnBi$""_2$Te$""_4$ features gate tunable charge transport with novel $E$-field induced Hall effect. Further, the magneto-electric coupling in those conventional magneto-electrics mainly arise from localized magnetic ions. By contrast, the magneto-electric coupling in MnBi$""_2$Te$""_4$ is expected to be dominated by the contribution from low-energy topological electrons, leading to the novel quantized Axion coupling @essin2009magnetoelectric@Zhang2019a@armitage2019matter. Finally, the AFM domain walls in even-layered MnBi$""_2$Te$""_4$ are predicted to support layer-spacific topological modes @li2013coupling (Extended Data Fig.~#ref(<Extended_Data_Figure_Future>, supplement: none)#strong[a]). By achieving local control of the AFM domains using piezoelectric or magnetic force tips based on the Axion field $bold(E) dot.op bold(B)$ manipulation, one can design networks of topological conduction channels. Versatile controls of the layer-locked Berry curvatures, as begun in our work, can result in the exciting applications in topological AFM spintronics.

#strong[Methods]

#strong[Crystal growth:] Our bulk crystals were grown by two methods: the Bi$""_2$Te$""_3$ flux method @Yan2019 and solid-state reaction method with extra Mn and I$""_2$. In the Bi$""_2$Te$""_3$ flux method, elemental Mn, Bi and Te were mixed at a molar ratio of $15 : 170 : 270$, loaded in a crucible, and sealed in a quartz tube under one-third atmospheric pressure of Ar. The ampule was first heated to $900^compose$C for $5$ hours. It was then moved to another furnace where it slowly cooled from $597^compose$C to $587^compose$C and stayed for one day at $587^compose$C. Finally, MnBi$""_2$Te$""_4$ were obtained by centrifuging the ampule to separate the crystals from the Bi$""_2$Te$""_3$ flux. In the solid-state reaction method, elemental form of Mn, Bi, Te and I$""_2$ were first mixed at a stoichiometric ratio of $1.5 : 2 : 4 : 0.5$ and sealed in a quartz ampoule under vacuum. The sample was heated to $900^compose$C in 24 hours in a box furnace and stayed at the temperature for over 5 hours to ensure a good mixture. The ampoule was then air quenched and moved to another furnace preheated at $597^compose$C, where it then slowly cooled to $587^compose$C in 72 hours and stayed at the final temperature for two weeks.

#strong[Sample fabrication:] To address the sensitive chemical nature of 2D MnBi$""_2$Te$""_4$ flakes, all fabrication processes were completed in an argon environment without exposure to air, chemicals, or heat. Specifically, the argon-filled glovebox with O$""_2$ and H$""_2$O level below $0.01$ ppm and a dew point below $- 96^compose$C was used. The glovebox was attached to an e-beam evaporator, allowing us to make metal deposition without exposure to air. First, thin flakes of MnBi$""_2$Te$""_4$ were mechanically exfoliated from the bulk crystal onto O$""_2$ plasma cleaned $300$-nm SiO$""_2$/Si wafers using Scotch-tape. Second, the number of layers were determined by the optical contrast of the flakes. This method has been proven effective for a wide range of air-sensitive vdW materials @huang2017layer@deng2018@Deng2020 including MnBi$""_2$Te$""_4$. Specifically, the optical contrast ($C = frac(I_("flake") - I_("substrate"), I_("flake") + I_("substrate"))$) of MnBi$""_2$Te$""_4$ flakes with different thicknesses were first measured based on the optical images taken via a Nikon Eclipse LV150N microscope inside the glovebox (Extended Data Fig.~#ref(<Extended_Data_Figure_Contrast>, supplement: none)). By extracting and averaging individual RGB values over each flake and substrate region, we obtained the optical contrast ($C$). Then the flakes were taken out of the glovebox so that the number of layer was directly determined by atomic force microscopy. As such, a one-to-one correspondence between the optical contrast and the number of layer was established. This process was repeated many times to ensure that the correspondence was reproducible and reliable (see data from different samples in Extended Data Fig.~#ref(<Extended_Data_Figure_Contrast>, supplement: none)). For the flakes eventually selected to make devices, their thickness was determined by this optical contrast. After the transport measurements, their thickness was re-confirmed by atomic force microscopy or transmission electron microscopy. Third, a high-resolution stencil mask technique @zhao2019@deng2018 was adapted. Specifically, the device contact pattern was written onto the exposed SiN membrane via photolithography and etched via reactive ion etching. This technique yields a resolution of $1$ $mu$m. The mask was subsequently held in place using vacuum suction cups and aligned onto the MnBi$""_2$Te$""_4$ crystal by a microscope. Forth, the sample/mask assembly was transferred to an e-beam evaporator for metal evaporation without exposure to air. Fifth, a $20 - 50$ nm BN flake was transferred onto the MnBi$""_2$Te$""_4$ flake as the top gate dielectric. A graphite gate was transferred onto the MnBi$""_2$Te$""_4$/BN heterostructure.

#strong[Electrical transport measurements with dual gating:] Electrical transport measurements were carried out in a PPMS (Quantum Design DynaCool). The base temperature was 1.65 K and maximum magnetic field was 9 T. The magnetic field was applied along the out-of-plane direction. Longitudinal and Hall voltages were measured simultaneously using standard lock-in techniques. The gate voltages were applied by Keithley 2400 source meters. In such dual-gated devices, as established by previous works @zhang2009@taychatanapat2010, the charge density $n$ and electric displacement field $D = epsilon.alt E$ can be controlled independently by the combination of top and bottom gate voltages $V_("TG")$ and $V_("BG")$. Specifically, the charge density can be obtained by $n = frac(epsilon.alt_0 epsilon.alt^("hBN"), e) ( V_("TG") - V_("TG0") ) / h_("T") + frac(epsilon.alt_0 epsilon.alt^("SiO"_2), e) ( V_("BG") - V_("BG0") ) / h_("B")$. The electric displacement field can be obtained by $D = [ epsilon.alt^("SiO"_2) ( V_("BG") - V_("BG0") ) / h_("B") - epsilon.alt^("hBN") ( V_("TG") - V_("TG0") ) / h_("T") ] / 2$. Here, $epsilon.alt_0 = 8.85 times 10^(- 12)$ F/m is the vacuum permittivity; $V_("TG0")$ and $V_("BG0")$ correspond to the gate voltages for the resistance maximum, which is the charge neutrality with no electric field; $epsilon.alt^("hBN") tilde.op 3$ and $epsilon.alt^("SiO"_2) tilde.op 3.9$ are relative dielectric constants for hBN and SiO$""_2$; , $h_("T")$ and $h_("B")$ are the thicknesses of the top hBN layer and bottom SiO$""_2$ layers, respectively.

#strong[First-principles calculations:] First-principles band structure calculations were performed using the projector augmented wave method as implemented in the VASP package @VASP within the generalized gradient approximation (GGA) schemes. 8$times$8$times$4 Monkhorst-Pack $k$-point meshes with an energy cutoff of $400$ eV were adapted for the Brillouin zone integration of bulk MnBi$""_2$Te$""_4$. Experimentally determined lattice parameters were used. In order to treat the localized Mn $3 d$ orbitals, we follow previous first-principle works #cite(<Otrokov2019a>)@Otrokov2019 on MnBi$""_2$Te$""_4$ and used an onsite $U med = med 5.0$ eV. The Wannier model for the bulk structure was built using the Bi $p$ and Te $p$ orbitals #cite(<wannier>). Thin films were modeled by constructing slabs of finite thickness using bulk Wannier model parameters.

#strong[Data availability:] The data that support the plots within this paper and other findings of this study are available from the corresponding author upon reasonable request.

#strong[Acknowledgement:] We gratefully thank Frank Zhao and Philip Kim for allowing us to use their glovebox and sample preparation facilities. We sincerely thank Trond I. Andersen, Giovanni Scuri, Hongkun Park and Mikhail D. Lukin for their help in magnetic measurements. We also thank Frank Zhao, Philip Kim, Yang Gao and Chang Liu for helpful discussions. Work in the Xu group was partly supported by the Center for the Advancement of Topological Semimetals (CATS), an Energy Frontier Research Center (EFRC) funded by the U.S. Department of Energy (DOE) Office of Science, through the Ames Laboratory under contract DE-AC0207CH11358 (fabrication and measurements) and partly through the STC Center for Integrated Quantum Materials (CIQM), National Science Foundation (NSF) award no. ECCS-2025158 (data analysis). SYX acknowledges the Corning Fund for Faculty Development. QM acknowledges support from the CATS, an EFRC funded by the U.S. DOE Office of Science, through the Ames Laboratory under contract DE-AC0207CH11358. CT acknowledges support from the Swiss National Science Foundation under project P2EZP2\_191801. YFL, AA (Akey), JG, DCB, and LF were supported by the STC Center for Integrated Quantum Materials (CIQM), NSF award no. ECCS-2025158. This work was performed in part at the Center for Nanoscale Systems (CNS) Harvard University, a member of the National Nanotechnology Coordinated Infrastructure Network (NNCI), which is supported by the NSF under NSF award no.1541959. Work at UCLA was supported by the U.S. DOE, office of Science, office of Basic Energy Sciences (BES) under Award Number DE-SC0021117 for bulk sample growth, transport and magnetic property measurements. Work at Northeastern University was supported by the US DOE, office of Science, office of BES grant number DE-SC0019275 and benefited from Northeastern University's Advanced Scientific Computation Center (ASCC) and the NERSC supercomputing center through DOE grant number DE-AC02-05CH11231. BG and AA (Agarwal) were supported by the Science Education and Research Board (SERB) and the Department of Science and Technology (DST) of the government of India for financial support, and the computer center IIT Kanpur, for providing the High Performance Computing facility. T-RC was supported by the Young Scholar Fellowship Program from the Ministry of Science and Technology (MOST) in Taiwan, under a MOST grant for the Columbus Program MOST110-2636-M-006-016, NCKU, Taiwan, and National Center for Theoretical Sciences, Taiwan. Work at NCKU was supported by the MOST, Taiwan, under grant MOST107-2627-E-006-001 and Higher Education Sprout Project, Ministry of Education to the Headquarters of University Advancement at NCKU. HL acknowledges the support by the MOST in Taiwan under grant number MOST 109-2112-M-001-014-MY3. HZL was supported by the National Natural Science Foundation of China (11925402), Guangdong province (2016ZT06D348, 2020KCXTD001), the National Key R & D Program (2016YFA0301700), Shenzhen High-level Special Fund (G02206304, G02206404), and the Science, Technology and Innovation Commission of Shenzhen Municipality (ZDSYS20170303165926217, JCYJ20170412152620376, KYTDPT20181011104202253), and Center for Computational Science and Engineering of SUSTech. RC was supported by the China Postdoctoral Science Foundation (Grant No. 2019M661678) and the SUSTech Presidential Postdoctoral Fellowship. CF was supported by the ERC Advanced Grant No. 742068 'TOPMAT' and by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany's Excellence Strategy through Würzburg-Dresden Cluster of Excellence on Complexity and Topology in Quantum Matter - ct.qmat (EXC 2147, project-id 390858490). KSB is grateful for the support of the Office of Naval Research under Award number N00014-20-1-2308. KW and TT acknowledge support from the Elemental Strategy Initiative conducted by the MEXT, Japan, Grant Number JPMXP0112101001 and JSPS KAKENHI Grant Number JP20H00354. ZZ, NW, ZH and WG thank Singapore National Research Foundation through its Competitive Research Program (CRP Award No. NRF-CRP21-2018-0007, NRF-CRP22-2019-0004). X-YZ, Y-XW, and BBZ acknowledge support from the NSF award No. ECCS-2041779.

#strong[Author contributions:] SYX conceived the experiment and supervised the project. AG fabricated the devices with help from YFL, JXQ, DB, CF, KSB and QM. AG performed the transport measurements and analyzed data with help from YFL, CT, JXQ, SCH, DB, TD and QM. CH and NN grew the bulk MnBi$""_2$Te$""_4$ single crystals. ZZ, NW, ZH and WG as well as JXQ, CT and AG performed optical magnetic circular dichroism measurements. X-YZ, Y-XW, and BBZ performed nitrogen-vacancy center magnetometry experiments. BG, RC, HS, AA (Agarwal), CT, SYX, H-ZL, H-JT, BS, AB, HL, LF, T-RC made theoretical studies including first-principles calculations and tight-binding modeling. AA (Akey), JG and DCB performed transmission electron microscope measurements. JXQ performed atomic force microscope measurements. KW and TT grew the bulk hBN single crystals. SYX, AG and QM wrote the manuscript with input from all authors. SYX was responsible for the overall direction, planning and integration among different research units.

#strong[Competing financial interests:] The authors declare no competing financial interests.

// [figvision-cn] imgs/Figure1.png
// 子图 a：这是一张关于谷霍尔效应（Valley Hall effect）的
// 三维示意图。图中展示了一个灰色的矩形薄片，代表二维材料
// 平面。在薄片表面有两个圆形的区域，分别标记为 K 和 K'，
// 代表布里渊区的两个不同的谷。在 K 点处，有一个蓝色的漏
// 斗状曲面隆起，旁边有一条蓝色箭头指示电子沿逆时针方向偏
// 转；在 K' 点处，有一个红色的倒扣碗状曲面凹陷，旁边有一
// 条红色箭头指示电子沿顺时针方向偏转。这两个相反方向的弯
// 曲箭头形象地展示了不同谷的电子在磁场或电场作用下发生相
// 反方向偏转的物理过程。 子图 b：这是一张关于层霍尔效应
// （Layer Hall effect）的三维示意图。图中包含上下两个平
// 行的灰色矩形薄片，分别标记为 Top layer（顶层）和
// Bottom layer（底层）。在顶层上方，有一个红色的漏斗状结
// 构，伴随一个红色的弯曲箭头指示顺时针旋转方向；在底层下
// 方，有一个蓝色的漏斗状结构，伴随一个蓝色的弯曲箭头指示
// 逆时针旋转方向。这表示电子在不同层中表现出相反的自旋或
// 轨道角动量输运特性。 子图 c：这是一张器件结构的三维剖
// 面示意图，展示了用于电学测量的多层堆叠结构。从下至上依
// 次为：最底部是灰色的 Si（硅）基底，其上覆盖一层紫色的
// SiO2（二氧化硅）绝缘层，作为背栅介质；中间是粉紫色的六
// 重层 MnBi2Te4（6-SL MnBi2Te4）薄膜，这是研究的主体材料；
// 在 MnBi2Te4 薄膜上沉积了四个黄色的金属电极块，呈两排排
// 列，用于施加电压和测量电流；再往上是浅蓝色的 BN（氮化
// 硼）层，作为顶栅介质；最顶部是深蓝色的 Graphite（石墨）
// 层，作为顶栅电极。电路连接方面，左侧画出了两个电压源：
// V_BG 连接在 Si 基底和 MnBi2Te4 之间，用于调控背栅电压；
// V_TG 连接在 Graphite 和 MnBi2Te4 之间，用于调控顶栅电
// 压。整个装置构成一个双栅场效应晶体管结构。 子图 d：这
// 是一个二维相图，横坐标为温度 T (K)，范围从 0 到 30 K；
// 纵坐标为外加磁场 B (T)，范围从 0 到 8 T。图中用颜色映
// 射表示纵向电阻 R_xx 的大小，右上角有颜色条标注：白色对
// 应 0 kΩ，红色对应 50 kΩ，蓝色对应 100 kΩ。图中划分出几
// 个磁性相区：左下角蓝色区域标记为 AFM（反铁磁相），上方
// 红色区域标记为 FM（铁磁相），中间过渡带绿色文字标记为
// Spin Flop (SF)（自旋翻转相），右侧淡紫色区域标记为 PM
// （顺磁相）。一条虚线曲线从约 (T=20 K, B=0 T) 开始向上
// 弯曲延伸至 (T≈10 K, B≈4 T)，分隔 AFM 与 SF/PM 区域。另
// 有一条红色箭头指向该虚线末端附近，并标注 T_N = 21 K，
// 表示奈尔温度。整体趋势显示，在低温低场下为反铁磁态，随
// 温度升高或磁场增大依次进入自旋翻转、铁磁或顺磁态。 子
// 图 e：这是一张曲线图，横坐标为背栅电压 V_BG (V)，范围
// 从 -20 V 到 40 V；纵坐标为纵向电阻 R_xx (kΩ)，范围从 0
// 到 200 kΩ。图中绘制了一条由红色实心圆点组成的曲线，呈
// 现明显的尖峰形状。峰值出现在 V_BG ≈ 10 V 处，R_xx 达到
// 最大值接近 200 kΩ。曲线两侧对称下降，在 V_BG < 0 V 和
// V_BG > 20 V 时 R_xx 趋近于 0。图中标注“CNP”并用箭头指
// 向峰值位置，表示电荷中性点。右上角注明实验条件：T =
// 1.7 K，B = 2 T。该曲线表明在特定栅压下材料出现强局域化
// 或能隙打开现象。 子图 f：这是一张曲线图，横坐标为背栅
// 电压 V_BG (V)，范围从 -20 V 到 40 V；纵坐标为横向电阻
// R_yx (kΩ)，范围从 -2 kΩ 到 1 kΩ。图中绘制了一条由蓝色
// 实心圆点组成的 S 形曲线。曲线在 V_BG < 0 V 时约为 +0.8
// kΩ，在 V_BG ≈ 10 V 处穿过零值（由水平虚线标示），并在
// V_BG ≈ 15 V 处达到最小值约 -2.5 kΩ，之后缓慢回升至
// V_BG = 40 V 时的约 -0.8 kΩ。图中标注“CNP”并用箭头指向
// 过零点，即电荷中性点位置。右上角注明实验条件：T = 1.7
// K，B = 2 T。该曲线反映了在磁场下由于贝里曲率导致的非平
// 凡横向输运行为，且符号在 CNP 附近反转，符合拓扑霍尔效
// 应的特征。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering): #it.body]
}

#figure(image("imgs/Figure1.png", width: 14cm),
  caption: [
    #strong[Basic characterizations of the antiferromagnetic 6 septuple layers MnBi$""_2$Te$""_4$.] #strong[a,] Illustration of the valley Hall effect. In certain nonmagnetic quantum materials such as gapped graphene and transition metal dichalcogenides (TMDs), Berry curvature is locked to $K$ and $K'$ valleys. Hence electrons of opposite valleys deflect in opposite directions, leading to the valley Hall effect. #strong[b,] Illustration of the layer Hall effect. In the AFM topological insulator state of even-layered MnBi$""_2$Te$""_4$, Berry curvature is locked to the top and bottom layers. Hence electrons in the top and bottom layers deflect in opposite directions, leading to the layer Hall effect. A bilayer system is adapted for simplicity. #strong[c,] Schematic drawing of our dual-gated devices. #strong[d,] Longitudinal resistance $R_(x x)$ as a function of temperature ($T$) and magnetic field ($B$) with the magnetic states denoted on the data. #strong[e,f,] $R_(x x)$ and $R_(y x)$ as a function of $V_("BG")$ in the AFM phase at $B = 2$ T. $R_(x x)$ as a function of $V_("BG")$ shows a sharp peak. $R_(y x)$ changes sign across charge neutrality.
  ],
  placement: top,
)
<Fig1>

// [figvision-cn] imgs/Figure2.png
// 该图由五个子图（a、b、c、d、e）组成，展示了层霍尔效应
// 的观测结果及理论解释。 子图 a 为曲线图。横坐标为磁场 B，
// 单位为特斯拉 (T)，范围从 -8 T 到 8 T；纵坐标为电阻
// R_yx，单位为千欧姆 (kΩ)，范围从 -10 kΩ 到 15 kΩ。图中
// 包含两条曲线：红色曲线代表正向扫描，蓝色曲线代表反向扫
// 描，两条曲线几乎完全重合，表明在零电场下没有明显的磁滞
// 现象。在磁场接近 0 T 时，电阻值约为 3 kΩ，随着磁场绝对
// 值的增加，电阻呈线性下降趋势。图的右上角标注有“εE = 0
// V/nm”。左下角有一个示意图，显示一个黄色的长方体，标注
// 为“MnBi2Te4”，代表样品材料。 子图 b 为曲线图，布局与子
// 图 a 类似。横坐标为磁场 B (T)，范围 -8 T 到 8 T；纵坐
// 标为电阻 R_yx (kΩ)，范围从 -6 kΩ 到 6 kΩ。图中同样包含
// 红色（正向扫描）和蓝色（反向扫描）两条曲线，但两者之间
// 存在显著差异，形成了明显的磁滞回线。红色曲线在负磁场区
// 域位于下方，蓝色曲线在正磁场区域位于上方。这表明在有限
// 电场下出现了反常霍尔效应。图的右上角标注有“εE = -0.20
// V/nm”。中间有一个示意图，显示一个灰色的箭头指向下方的
// 黄色长方体（MnBi2Te4），箭头旁标注有字母“E”，表示施加
// 了向下的电场。 子图 c 为填充面积图。横坐标为电场 εE，
// 单位为伏特每纳米 (V/nm)，范围从约 -0.3 V/nm 到 0.2 V/
// nm；纵坐标为反常霍尔电导率 σ_AHE_xy，单位为 e²/h，范围
// 从 -0.5 e²/h 到 0.9 e²/h。图中有一条黑色实线描绘数据点，
// 线下方的区域被颜色填充。当电场 εE 小于 0 时，区域填充
// 为淡蓝色，σ_AHE_xy 为负值；当电场 εE 大于 0 时，区域填
// 充为淡红色，σ_AHE_xy 为正值。在 εE = 0 附近，曲线穿过
// 零点。图的左上角标注有电荷密度“n = 1.5×10¹² cm⁻²”。图
// 中有两个粗大的灰色箭头：一个向下的箭头标注“E < 0”，对
// 应蓝色区域；一个向上的箭头标注“E > 0”，对应红色区域。
// 一条水平虚线标示了 σ_AHE_xy = 0 的位置。 子图 d 为三维
// 示意图，解释了 E < 0 时的物理机制。图中显示了两个平行
// 的灰色晶格平面。上层平面中心有一个红色的圆锥形曲面，周
// 围环绕着一个红色的顺时针箭头；下层平面中心有一个蓝色的
// 圆锥形曲面，周围环绕着一个蓝色的逆时针箭头。右侧有一个
// 向下的粗灰色箭头，标注“E < 0”。最右侧有一个垂直的色标
// 条，上半部分为红色并标记“+”，下半部分为蓝色并标记“-”，
// 旁边竖排文字标注“Berry curvature”（贝里曲率）。这表示
// 在向下电场作用下，不同层的贝里曲率符号相反且旋转方向相
// 反。 子图 e 为三维示意图，结构与子图 d 类似，但展示了
// E > 0 的情况。图中同样有两个平行的灰色晶格平面。上层平
// 面中心的红色圆锥形曲面变大且更突出，周围的红色顺时针箭
// 头也更粗大；下层平面的蓝色圆锥形曲面变小，周围的蓝色逆
// 时针箭头也变细。右侧有一个向上的粗灰色箭头，标注“E > 0
// ”。右侧的色标条与子图 d 相同，指示红色代表正贝里曲率，
// 蓝色代表负贝里曲率。这表明在向上电场作用下，顶层的正贝
// 里曲率增强，底层的负贝里曲率减弱，导致净霍尔效应为正。
#figure(image("imgs/Figure2.png", width: 12.2cm),
  caption: [
    #strong[Observation of the layer Hall effect.] #strong[a,] $R_(y x)$ as a function of $B$ field at zero electric field. Red and blue curves denote the forward and backward scans, respectively. The $E = 0$ condition is determined by the maximum of the resistance $R_(x x)$. #strong[b,] Same as panel (#strong[a]) but at a finite electric field $epsilon.alt E = - 0.20$ V/nm, demonstrating the $E$-field induced AHE. #strong[c,] The AHE conductivity (at $B = 0$) $sigma_(x y)^("AHE")$ as a function of $E$ field. The charge density $n$ is set in the electron-doped regime ($n = + 1.5 times 10^12$ cm$""^(- 2)$). #strong[d,e,] Illustration of the layer-locked Berry curvature under opposite $E$ fields. Depending on the $E$ field direction, the Berry curvature contribution from a particular layer dominates. This explains the AHE's sign reversal with respect to $E$ field. The color denotes the sign of the Berry curvature. The size of the rotating arrows denote the magnitude of the total Berry curvature from a particular layer. A bilayer system is adapted for simplicity.
  ],
  placement: top,
)
<Fig2>

// [figvision-cn] imgs/Figure3.png
// 该图包含七个子图（a至g），展示了层霍尔效应随电荷密度的
// 变化以及相关的理论计算和能带结构示意图。 子图 a： 类型：
// 实验数据散点图叠加拟合曲线，右上角带有示意图。 坐标轴：
// 横轴为电荷密度 n，单位 10^12 cm^-2，范围从 -4 到 3；纵
// 轴为反常霍尔电导率 σ_xy^AHE，单位 e^2/h，范围从 -0.3
// 到 0.5。图中有一条水平虚线表示 y=0。 数据与曲线：红色
// 空心圆点代表实验数据点，一条实心红线穿过这些点进行拟合。
// 在低电荷密度区（n < -2），电导率为正值并呈现峰值；随着
// 电荷密度增加，电导率下降并在 n 约为 0 处过零，进入负值
// 区域。 标注文字：右上角标有“Experiment”；底部标有电场
// 强度“eE = -0.20 V/nm”。 示意图：右侧绘制了两个倒置的圆
// 锥体，中间由绿色填充区域连接，示意电子结构。左侧也有类
// 似的两个圆锥体结构。 子图 b： 类型：实验数据散点图叠加
// 拟合曲线，上方带有示意图。 坐标轴：横轴为电荷密度 n，
// 单位 10^12 cm^-2，范围从 -2 到 1；纵轴为反常霍尔电导率
// σ_xy^AHE，单位 e^2/h，范围从 -0.1 到 0.2。图中有一条水
// 平虚线表示 y=0。 数据与曲线：红色空心圆点代表实验数据
// 点，一条实心红线穿过这些点。数据点在整个范围内都非常接
// 近于零，仅在负电荷密度区有微小的正值波动。 标注文字：
// 右上角标有“Experiment”；底部标有电场强度“eE = -0.02 V/
// nm”。 示意图：顶部绘制了两组分离的倒置圆锥体结构，分别
// 位于左右两侧，暗示不同的能带状态。 子图 c： 类型：理论
// 计算曲线图，右上角标有“Calculation”。 坐标轴：横轴为电
// 荷密度 n，单位 10^12 cm^-2，范围从 -4 到 4；纵轴为反常
// 霍尔电导率 σ_xy^AHE，单位 e^2/h，范围从 -0.2 到 0.8。
// 图中有一条水平虚线表示 y=0。 数据与曲线：一条实心红线
// 表示计算结果。在 n < -3 时，电导率维持在约 0.8 的高平
// 台；随后急剧下降，在 n ≈ 0 处过零，并在正电荷密度区变
// 为负值。 标注文字：右上角标有“Calculation”。 子图 d：
// 类型：理论计算曲线图，右上角标有“Calculation”。 坐标轴：
// 横轴为电荷密度 n，单位 10^12 cm^-2，范围从 -4 到 4；纵
// 轴为反常霍尔电导率 σ_xy^AHE，单位 e^2/h，范围从 -0.2
// 到 0.8。图中有一条水平虚线表示 y=0。 数据与曲线：一条
// 实心红线表示计算结果。曲线整体数值较小，在负电荷密度区
// 约为 0.2，随电荷密度增加逐渐下降并趋近于零，未出现明显
// 的符号反转或大幅波动。 标注文字：右上角标有“
// Calculation”。 子图 e： 类型：非磁性拓扑绝缘体（
// Nonmag. TI）的能带交叉示意图。 布局与物体：中心是一个
// 黄色矩形框，内写“Nonmag. TI”。其上下方各有一个由两条交
// 叉虚线构成的“X”形结构，代表狄拉克锥。上方的“X”交点处有
// 一个白色圆圈，下方的“X”交点处有一个黑色实心圆点，表示
// 自旋相反的状态。 含义：展示在无磁序情况下，上下表面态
// 形成简并的狄拉克锥。 子图 f： 类型：反铁磁拓扑绝缘体（
// AFM TI, even）在无外电场下的能带与贝里曲率分布示意图。
// 布局与物体：左侧是两个分开的抛物线型能带，上支开口向上，
// 下支开口向下，均带有红蓝渐变色填充。中间是黄色矩形框，
// 内写“AFM TI (even)”，内部画有多个灰色箭头交替排列，表
// 示反铁磁序。右侧对应位置有两个小的色块，分别显示红蓝分
// 布。底部文字为“No electric field”。 颜色映射：右侧垂直
// 色条标示“Berry curvature”，红色代表正值（+），蓝色代表
// 负值（-）。能带上的颜色表示不同动量处的贝里曲率大小和
// 符号。 子图 g： 类型：反铁磁拓扑绝缘体（AFM TI, even）
// 在外加电场作用下的能带与贝里曲率分布示意图。 布局与物
// 体：结构与子图 f 类似，但在两个能带之间增加了一个向下
// 的粗灰色箭头，旁边标注字母“E”，表示施加了垂直方向的电
// 场。底部文字为"With electric field"。 变化趋势：相比子
// 图 f，能带的弯曲程度和贝里曲率的分布发生了改变，特别是
// 在费米面附近（虚线所示），显示出电场对贝里曲率的调控作
// 用。 颜色映射：同样使用右侧的“Berry curvature”色条，红
// 蓝渐变表示贝里曲率的正负分布。
#figure(image("imgs/Figure3.png", width: 15cm),
  caption: [
    #strong[Charge density dependence of the layer Hall effect and the layer-locked Berry curvature.] #strong[a,b,] The layer Hall effect as a function of charge density $n$ with the $E$ field fixed at $epsilon.alt E = - 0.20$ V/nm (panel #strong[a]) and $epsilon.alt E = - 0.02$ V/nm (panel #strong[b]). The layer Hall effect is observed to show opposite sign in the electron-doped and hole-doped regimes. #strong[c,d,] First-principles calculated AHE conductivity $sigma_(x y)^("AHE")$ as a function of charge density. The theoretically applied electric field ($E^("THY")$) here can be related to the displacement field by $D^("THY") = epsilon.alt^("MnBi"_2 "Te"_4) E^("THY")$. #strong[e-g,] A microscopic picture for the layer Hall effect in 6SL AFM MnBi$""_2$Te$""_4$. #strong[e,] A nonmagnetic topological insulator features massless surface Dirac fermions on its top and bottom layers. #strong[f,] The inclusion of the A-type AFM order gaps the Dirac fermions. The resulting Berry curvature of the top Dirac fermion exactly cancels that of the bottom Dirac fermion. #strong[g,] Applying an $E$ field can break the degeneracy between the top and bottom Dirac fermions, leading to a large layer-polarized AHE, as long as the Fermi level is away from the band gap. The AHE in the electron-doped regime and in the hole-doped regime has opposite sign.
  ],
  placement: top,
)
<Fig3>

// [figvision-cn] imgs/Figure4.png
// 子图 a 为示意图，展示了轴子场对双层反铁磁系统中层锁定
// 贝里曲率的操控机制。图中包含左右两组状态对比和中间的作
// 用原理示意。左侧标记为“State I”，右侧标记为“State II”。
// 每组状态下均画有一个灰色的长方体代表双层材料，内部排列
// 有黑色箭头表示自旋方向：在 State I 中，上下两层的自旋
// 均向下；在 State II 中，上下两层的自旋均向上（注：此处
// 根据图示箭头方向描述，实际物理模型可能涉及相对取向，但
// 视觉上呈现为同向翻转）。在每个状态上方绘制了半透明的球
// 状曲面以表示贝里曲率分布：State I 对应红色曲面，State
// II 对应蓝色曲面。曲面上方绘有粗大的环形箭头表示电流或
// 响应方向：红色曲面配红色向右箭头，蓝色曲面配蓝色向左箭
// 头。图中央竖直排列两个黑色大箭头表示电场 E 与磁场 B 的
// 方向组合，旁边标注文字“Axion field”和“E·B”，并配有弯曲
// 的蓝色箭头表示耦合效应。图最右侧设有垂直色条图例，标注
// “Berry curvature”，上半部分为粉红色标有“+”，下半部分为
// 蓝紫色标有“-”，用于指示贝里曲率的正负符号。该子图传达
// 的核心结论是：通过调节轴子场（即 E·B 项），可在两种反
// 铁磁态之间切换，从而反转层锁定的贝里曲率符号。 子图 b
// 为曲线图，标题为“Finite E, magnetic field manipulation
// ”，横坐标为磁场强度 B，单位特斯拉（T），范围从 -6 T 到
// +6 T；纵坐标为横向电阻 R_yx，单位千欧（kΩ），范围从 -2
// kΩ 到 +2 kΩ。图中包含两条曲线：红色曲线代表正向扫描过
// 程，蓝色曲线代表反向扫描过程。两条曲线均表现出明显的磁
// 滞回线特征。在低场区（约 ±3 T 以内），红色曲线位于正值
// 区域（约 +0.5 至 +1.5 kΩ），蓝色曲线位于负值区域（约
// -0.5 至 -1.5 kΩ），分别对应“State I”和“State II”。在高
// 场区（|B| > 4 T），两条曲线均趋向于零附近，并标注为“SF
// ”（Spin-Flop phase）。图上方标注实验条件“εE = -0.20 V/
// nm”。红色箭头指示从左至右的扫描方向，蓝色箭头指示从右
// 至左的扫描方向。该子图表明：在固定弱电场下，随磁场变化
// 系统可在 SF 相、State I 和 State II 之间可逆切换，且不
// 同磁态对应不同的横向电阻符号，体现层霍尔效应的电学读出
// 能力。 子图 c 同样为曲线图，结构与子图 b 类似，但实验
// 条件更强：标注“εE = -1.1 V/nm”。横坐标仍为 B (T)，范围
// -4 T 至 +4 T；纵坐标 R_yx (kΩ)，范围 -2 kΩ 至 +2 kΩ。
// 图中仅有一条紫红色实线曲线，显示完整的磁滞回线行为。曲
// 线在低场区呈现平台状，高场区下降至负值。图中标注四个区
// 域：“SF → State I → State II → SF”（上排红字）和“SF ←
// State I ← State II ← SF”（下蓝字），分别对应正向和反向
// 扫描路径。在 B ≈ 0 T 附近出现一个小的矩形跳跃结构，用
// 蓝色框标出，可能表示亚稳态或相变临界点。该子图说明：在
// 强电场下，系统仍能实现多态调控，但磁滞窗口变窄，且存在
// 非单调响应，反映电场对磁相边界的调制作用。 子图 d 为曲
// 线图，标题为“Finite B, electric field manipulation”，
// 横坐标为电场 εE，单位 V/nm，范围 -0.5 至 +0.5 V/nm；纵
// 坐标为 R_yx (kΩ)，范围 -1.0 至 +0.5 kΩ。图中包含两条曲
// 线：红色曲线代表正向扫描（从左到右），蓝色曲线代表反向
// 扫描（从右到左），由箭头指示方向。两条曲线形成显著的电
// 滞回线：在 εE < 0 时，R_yx 主要为负值；在 εE > 0 时，
// R_yx 转为正值，中间过渡区出现陡峭跳变。图上方标注实验
// 条件“B = 1 T”。该子图证明：在固定磁场下，仅通过改变电
// 场即可驱动系统在两个具有相反横向电阻的磁态间切换，验证
// 了电场对层锁定贝里曲率的有效操控。 子图 e 为时间序列图，
// 分为上下两个面板，共享同一横坐标“Measurement time (s)”，
// 范围 0 至 800 s。上方面板显示施加的电场 εE (V/nm)，范
// 围 -0.5 至 +0.5 V/nm，呈方波脉冲形式交替变化：蓝色背景
// 区间对应“Prepare state I”，粉色背景区间对应“Prepare
// state II”，中间穿插虚线表示“Reading”阶段。下方面板显示
// 对应的横向电阻 R_yx (kΩ)，范围 -1.0 至 +0.5 kΩ，红色曲
// 线记录实时测量值。可见当电场切换至 Prepare state I 时，
// R_yx 稳定在约 +0.5 kΩ；切换至 Prepare state II 时，
// R_yx 降至约 -0.5 kΩ，且在 Reading 阶段保持稳定无漂移。
// 该子图直观展示：通过周期性施加电场脉冲，可反复、稳定地
// 写入和读取两种磁态，证实该系统具备作为非易失性存储器件
// 的潜力，且电学信号清晰可靠。
#figure(image("imgs/Figure4.png", width: 14cm),
  caption: [
    #strong[Axion field $bold(E) dot.op bold(B)$ manipulation of the layer-locked Berry curvature and electrical readout by the layer Hall effect.] #strong[a,] The Axion field $bold(E) dot.op bold(B)$ @fiebig2005revival@li2010dynamical@wang2019dynamic can switch between the two AFM states (States I and II), which, in turn, reverse the layer-locked Berry curvature. A bilayer system is adapted for simplicity. #strong[b,] $R_(y x) - B$ with $epsilon.alt E = - 0.20$ V/nm. For the forward scan (red curve), at $B tilde.eq - 4$ T, the system changes from the spin-flop phase to the AFM phase with a positive $bold(E) dot.op bold(B)$ ($E < 0$ and $B < 0$), which favors State I. As we keep moving forward to the $B > 0$ region, $bold(E) dot.op bold(B)$ turns negative, which favors State II. However, in this dataset, $bold(E) dot.op bold(B)$ fails to reach the coercive field $( bold(E) dot.op bold(B) )_("c")$. Hence state I persists all the way until the system is changed to spin-flop at $B tilde.eq + 4$ T. The situation is similar for the backward scan (blue curve), except that at $B tilde.eq + 4$ T, the system enters the AFM phase with a negative $bold(E) dot.op bold(B)$ field, which favors State II. #strong[c,] Same as panel (#strong[b]) but with $epsilon.alt E = - 1.1$ V/nm. The much stronger $E$ field leads to a much stronger $bold(E) dot.op bold(B)$ field so that the coercive field $( bold(E) dot.op bold(B) )_("c")$ is reached. This induces additional switch between State I and State II at small $B$. #strong[d,] One can also fix the $B$ field and scan the $E$ field back and forth. Here, $B$ field is fixed at $B = + 1$ T. A clear hysteresis as a function of $E$ field is observed. The hysteresis shows a butterfly-like shape, because $E$ field is also needed to generate the AHE, without which there is no contrast between the opposite AFM states. #strong[e,] By sweeping the $E$ field back and forth, we observe repeatable switching of the AFM states. The $E$ field sweeping is achieved by slow ramping of gate voltage. The measurement time (horizontal axis) only counts the time at the targeted gate voltage. The sweeping time is not shown.
  ],
  placement: top,
)
<Fig4>

// [figvision-cn] imgs/Extended_Data_Figure_Future.png
// 子图a为三维示意图，展示通过顶部和底部栅极电压调控构建
// 的拓扑轴子畴壁结构。该图由上下两层相同的矩形块体构成，
// 每层包含两个区域，分别对应不同的栅极配置。上层左侧区域
// 上方标注“-V Top gate I”，下方无底部栅极；右侧区域上方
// 标注“+V Top gate II”。下层左侧区域下方标注“+V Bottom
// gate I”，右侧区域下方标注“-V Bottom gate II”。每个区域
// 内均有一个半透明锥形曲面：红色锥面带顺时针环形箭头（从
// 俯视视角），蓝色锥面带逆时针环形箭头。在锥面内部及周围
// 分布多个黑色小箭头，表示局域磁化方向或自旋取向——在红色
// 锥区，箭头向下；在蓝色锥区，箭头向上。两层之间用紫色粗
// 箭头连接：上层左与下层右之间有向下的紫箭头，上层右与下
// 层左之间有向上的紫箭头，暗示跨层耦合或电流路径。整个结
// 构右侧有一竖直灰色粗箭头，标有字母“B”，表示外加磁场方
// 向垂直于样品平面（z轴）。所有文字均为黑色无衬线字体，“
// Top gate I/II”、“Bottom gate I/II”位于淡紫色梯形电极区
// 域旁，“-V”和“+V”为电压符号。此图传达的核心结论是：通过
// 对称施加正负栅压，可在上下界面诱导相反手性的轴子场构型
// （红蓝锥面代表不同拓扑荷），并通过中间层实现空间调制，
// 形成可电控的拓扑畴壁结构。 子图b为原子级结构示意图叠加
// 莫尔超晶格势场分布。主体是一个六边形截面的三维晶格模型，
// 表面呈现黑白相间的球棍结构，代表MnBiTe₂/hBN异质结的原
// 子排列。晶格表面均匀分布若干浅青色竖直箭头，指向外法线
// 方向，象征局部贝里曲率矢量或赝磁场方向。在晶格上方悬浮
// 一个半透明白色六边形平面，其上绘制九个红色高斯型斑点，
// 呈3×3网格状排布，中心斑点最亮，边缘渐暗，代表空间调制
// 的贝里曲率莫尔超晶格势能分布。红色斑点位置与下方青色箭
// 头密集区大致对应，表明莫尔图案调控了贝里曲率的局域增强。
// 图中无任何坐标轴、比例尺或数值标签，但整体布局清晰显示：
// 莫尔超晶格（红色斑点）作为外部调制场，作用于底层磁性拓
// 扑材料（黑白血晶格），从而产生空间非均匀的贝里曲率分布
// （青色箭头）。该图旨在说明MnBiTe₂-twisted hBN异质结中，
// 由于晶格失配形成的莫尔势场能够工程化地塑造贝里曲率的空
// 间分布，进而影响电子输运性质。
#figure(image("imgs/Extended_Data_Figure_Future.png", width: 15cm),
  caption: [
    Topological Axion domain wall constructed by the Axion field $bold(E) dot.op bold(B)$ (panel #strong[a]) and spatially modulating Berry curvature moiré superlattice enabled by the MnBi$""_2$Te$""_4$-twisted hBN heterostructure @yasuda2020 (panel #strong[b]).
  ],
  placement: top,
)
<Extended_Data_Figure_Future>

// [figvision-cn] imgs/Extended_Data_Figure_QAHE.png
// 子图a为光学显微镜照片，展示了6SL MnBi2Te4器件的形貌与
// 电路布局。图像中心是一个灰白色的多晶区域，被紫色虚线椭
// 圆圈出并标注为“MnBi2Te4”。从该区域延伸出多条紫灰色的金
// 属电极引线。其中两条较粗的引线分别标注为红色的“Source”
// （源极）和“Drain”（漏极）。一条绿色的实线路径描绘了测
// 量回路：路径的一端连接至左侧电极，引出绿色箭头指向左下
// 方并标注“V_yx”，表示横向电压测量点；另一端连接至右侧电
// 极，引出黄色箭头指向右方并标注“V_xx”，表示纵向电压测量
// 点。图像右下角有一条白色比例尺线段，标注长度为“20 μm”。
// 背景呈现蓝紫色调。 子图b为二维彩色等高线图，展示霍尔电
// 阻R_yx随磁场B和背栅电压V_BG的变化关系。横坐标为磁场B，
// 单位为特斯拉(T)，范围从-8到8 T；纵坐标为背栅电压V_BG，
// 单位为伏特(V)，范围从-60到60 V。颜色映射条位于右下角，
// 标注物理量为R_yx (h/e^2)，数值范围从-1到1。深蓝色代表
// -1，红色代表+1，白色接近0。图中显示在负磁场区域（约-8
// 至-4 T）且V_BG为正时存在大面积红色高值区；在正磁场区域
// （约4至8 T）且V_BG为正时存在大面积蓝色低值区；在V_BG接
// 近0的区域颜色呈浅色过渡。 子图c为二维彩色等高线图，展
// 示纵向电阻R_xx随磁场B和背栅电压V_BG的变化关系。横坐标
// 为磁场B，单位为特斯拉(T)，范围从-8到8 T；纵坐标为背栅
// 电压V_BG，单位为伏特(V)，范围从-60到60 V。颜色映射条位
// 于右下角，标注物理量为R_xx (h/e^2)，数值范围从0到3。深
// 蓝色代表0，黄褐色代表3。图中主体为深蓝色背景，表明大部
// 分区域电阻极低。在V_BG约为20至40 V、磁场B约为-4至4 T的
// 矩形区域内，出现一个明显的亮色岛状结构，中心呈黄褐色，
// 向外逐渐过渡为绿色和蓝色，表明此处纵向电阻显著升高。
// 子图d为双Y轴曲线图，展示在固定温度T=1.72 K和固定磁场B=
// -9 T条件下，纵向电阻R_xx（红色方块点）和霍尔电阻R_yx（
// 蓝色圆点）随背栅电压V_BG的变化。横坐标为V_BG，单位为伏
// 特(V)，范围从0到60 V。左侧纵坐标为R_xx (h/e^2)，范围
// 0.0至0.6，对应红色数据点和红色箭头指示；右侧纵坐标为
// R_yx (h/e^2)，范围0.0至1.0，对应蓝色数据点和蓝色箭头指
// 示。图中包含两条曲线：红色曲线（R_xx）在V_BG从0增至约
// 20 V时上升至峰值约0.4 h/e^2，随后下降并在30至50 V区间
// 维持在接近0的水平，之后再次小幅上升；蓝色曲线（R_yx）
// 在V_BG从0增至约30 V时单调上升至平台值约0.6 h/e^2（由顶
// 部蓝色虚线标示），该平台持续至约50 V后急剧下降。图中用
// 虚线圆圈标出了两个特征点：一个位于红色曲线下降段（约
// V_BG=20 V处），另一个位于蓝色曲线下降段（约V_BG=50 V处）。
// 图中央标注实验条件：“T = 1.72 K, B = -9 T”。
#figure(image("imgs/Extended_Data_Figure_QAHE.png", width: 15cm),
  caption: [
    #strong[a,] Microscope image of our 6SL MnBi$""_2$Te$""_4$ device (the device presented in the main text). The circuit for our transport measurements is noted. #strong[b,c,] Longitudinal $R_(x x)$ (panel #strong[c]) and transverse (Hall) resistance $R_(y x)$ (panel #strong[b]) as a function of $V_("BG")$ and $B$. #strong[d,] $R_(x x)$ and $R_(y x)$ $v s$ $V_("BG")$ at $- 9$ T.
  ],
  placement: top,
)
<Extended_Data_Figure_QAHE>

// [figvision-cn] imgs/Extended_Data_Figure_Sigma_E_Calculation.png
// 该图由四个子图（a、b、c、d）组成，展示了6SL MnBi2Te4中
// 反常霍尔效应（AHE）电导率随外加电场变化的实验测量结果
// 与第一性原理计算结果。 子图a： 类型：曲线图（实验数据）。
// 坐标轴：横轴为归一化电场强度 εE，单位为 V/nm，范围从
// -0.4 到 0；纵轴为反常霍尔电导率 σ_xy^AHE，单位为 e²/h，
// 范围从 -0.8 到 0.4。 曲线与色标：图中有一条黑色实线表
// 示实验测量的电导率随电场的变化，曲线下方的区域被填充颜
// 色。当电导率为正值时（εE < 0），区域填充为浅红色；当电
// 导率为负值时（εE > 0），区域填充为浅蓝色。 标注文字：
// 左上角标注“Experiment”；左下角标注载流子浓度 n = -1.4×
// 10¹² cm⁻²；在纵轴0刻度处有一条水平虚线，在横轴0刻度处
// 有一条垂直虚线。 趋势或结论：在空穴掺杂区（n < 0），随
// 着电场从-0.4 V/nm增加到0 V/nm，σ_xy^AHE 始终为正，数值
// 在0.3至0.5 e²/h之间波动，并在接近0 V/nm时急剧下降穿过
// 零点变为负值。 子图b： 类型：曲线图（实验数据）。 坐标
// 轴：横轴为归一化电场强度 εE，单位为 V/nm，范围从 -0.2
// 到 0.15（约）；纵轴为反常霍尔电导率 σ_xy^AHE，单位为 e
// ²/h，范围从 -0.4 到 0.9（约）。 曲线与色标：图中有一条
// 黑色实线表示实验数据，下方填充颜色。电导率为负值时（εE
// < 0）填充浅蓝色，正值时（εE > 0）填充浅红色。 标注文字：
// 左上角标注“Experiment”；右下角标注载流子浓度 n = 1.5×
// 10¹² cm⁻²；同样包含纵轴0刻度的水平虚线和横轴0刻度的垂
// 直虚线。 趋势或结论：在电子掺杂区（n > 0），当电场为负
// 时，σ_xy^AHE 为负值，绝对值约为0.4 e²/h；当电场越过0点
// 变为正时，电导率迅速上升并转为正值，峰值超过0.8 e²/h。
// 这表明电场可以调控反常霍尔效应的符号和大小。 子图c：
// 类型：曲线图（理论计算）。 坐标轴：横轴为理论电场
// E_THY，单位为 V/nm，范围从 -0.01 到 0.01；纵轴为反常霍
// 尔电导率 σ_xy^AHE，单位为 e²/h，范围从 -0.7 到 0.7（约）。
// 曲线与色标：图中有一条红色实线表示第一性原理计算结果，
// 无填充色。 标注文字：右上角标注“Calculation”；包含纵轴
// 0刻度的水平虚线和横轴0刻度的垂直虚线。 趋势或结论：费
// 米能级位于价带（meV）。计算结果显示，σ_xy^AHE 随电场呈
// 非线性变化，在零场附近近似线性通过原点，但在较大电场下
// 出现复杂的振荡行为，包括一个明显的正向峰值和一个更深的
// 负向谷值。 子图d： 类型：曲线图（理论计算）。 坐标轴：
// 横轴为理论电场 E_THY，单位为 V/nm，范围从 -0.01 到
// 0.01；纵轴为反常霍尔电导率 σ_xy^AHE，单位为 e²/h，范围
// 从 -0.5 到 0.5。 曲线与色标：图中有一条红色实线表示第
// 一性原理计算结果，无填充色。 标注文字：左上角标注“
// Calculation”；包含纵轴0刻度的水平虚线和横轴0刻度的垂直
// 虚线。 趋势或结论：费米能级位于导带。与子图c不同，此处
// 的计算结果显示 σ_xy^AHE 随电场呈现近乎完美的单调递增线
// 性关系，斜率恒定，表明在导带情况下，反常霍尔电导对电场
// 的响应更为简单和直接。
#figure(image("imgs/Extended_Data_Figure_Sigma_E_Calculation.png", width: 14cm),
  caption: [
    #strong[$E$ field dependence of the layer Hall effect in 6SL MnBi$""_2$Te$""_4$. a,] The AHE conductivity $sigma_(x y)^("AHE")$ as a function of $E$ field. The charge density $n$ is set in the hole-doped regime ($n = - 1.4 times 10^12$ cm$""^(- 2)$). #strong[b,] Same as panel (#strong[a]) but $n$ is set in the electron-doped regime ($n = + 1.5 times 10^12$ cm$""^(- 2)$). #strong[c,d,] First-principles calculated AHE conductivity $sigma_(x y)^("AHE")$ as a function of $E$ field. #strong[c,] Fermi level is set in the valence band ($- 10$ meV). #strong[d,] Fermi level is set in the conduction band ($+ 30$ meV).
  ],
  placement: top,
)
<Extended_Data_Figure_Sigma_E_Calculation>

// [figvision-cn] imgs/Extended_Data_Figure_Temperature_Dependence.png
// 子图a为散点曲线图，展示6SL MnBiTe材料在零磁场（B = 0 T）
// 条件下纵向电阻R_xx随温度T的变化关系。横坐标为温度T，单
// 位开尔文（K），范围从0 K到40 K；纵坐标为纵向电阻R_xx，
// 单位千欧姆（kΩ），范围从40 kΩ到90 kΩ。数据点以红色实心
// 圆表示，连接成连续曲线。曲线显示：在低温区（约0–10 K），
// R_xx维持在约48 kΩ的较低水平；随后随温度升高逐渐上升，
// 在约21 K处达到峰值（约85 kΩ），该峰顶位置由一个黑色向
// 上箭头标注并标记为“T_N”，即奈尔温度；之后随温度继续升
// 高，R_xx缓慢下降至约60 kΩ（在35 K附近）。图中右下角标
// 注“B = 0 T”。 子图b为多组叠加曲线图，展示不同温度下横
// 向电阻R_yx随外加磁场B的变化关系。横坐标为磁场B，单位特
// 斯拉（T），范围从-8 T到+8 T；纵坐标为横向电阻R_yx，单
// 位千欧姆（kΩ），范围从-15 kΩ到25 kΩ。共绘制五条曲线，
// 分别对应温度为80 K、35 K、26 K、14 K和2 K，每条曲线旁
// 均标注其对应温度值。所有曲线均呈近似线性负斜率趋势，但
// 斜率大小随温度降低而增大。其中，2 K曲线在低场区（约-4
// T至+4 T）出现明显非线性平台或凹陷结构，且整体偏移量最
// 大。图中用浅黄色垂直带状区域标示出“AFM regime”（反铁磁
// 区域），覆盖磁场范围约-3 T至+3 T。此外，各温度曲线之间
// 沿纵轴方向人为偏移了若干kΩ（根据图注说明为“offset by
// kohm for visibility”），以便区分不同温度下的行为，例如
// 80 K曲线位于最上方，2 K曲线位于最下方。 子图c为散点拟
// 合曲线图，展示异常霍尔效应电阻R_AHE_yx随温度T的变化关
// 系。横坐标为温度T，单位开尔文（K），范围从0 K到80 K；
// 纵坐标为异常霍尔电阻R_AHE_yx，单位千欧姆（kΩ），范围从
// 0 kΩ到0.7 kΩ。数据点以品红色菱形表示，共六个点，分布在
// 0 K、约5 K、约10 K、约25 K、约35 K和80 K处。一条品红色
// 虚线穿过这些点进行拟合。曲线显示：在低温区（<20 K），
// R_AHE_yx随温度升高急剧下降，从约0.65 kΩ降至接近0 kΩ；
// 在20 K以上，R_AHE_yx基本保持为零（在误差范围内）。图中
// 右上角标注实验条件：“B = 0 T”和“εE = 0.6 V/nm”（电场强
// 度）。底部有一条水平虚线位于R_AHE_yx = 0处，作为参考基
// 线。
#figure(image("imgs/Extended_Data_Figure_Temperature_Dependence.png", width: 14cm),
  caption: [
    #strong[Temperature dependent measurements of 6SL MnBi$""_2$Te$""_4$.] #strong[a,] Temperature dependent $R_(x x)$ data showing the Néel temperature $T_("N")$. #strong[b,] $R_(y x) - B$ measurements at different temperatures. Data at different temperatures are offset by $4$ kohm for visibility. #strong[c,] AHE resistance as a function of temperature.
  ],
  placement: top,
)
<Extended_Data_Figure_Temperature_Dependence>

// [figvision-cn] imgs/Opposite_Domain.png
// 该图展示了偶数层MnBi2Te4的示意图电子结构和贝里曲率分布，
// 分为四个子图a、b、c、d。图像右侧有一个垂直的颜色条图例，
// 标题为“Berry curvature”，颜色从底部的蓝色（标记为负号-）
// 渐变到顶部的红色（标记为正号+），表示贝里曲率的符号和
// 相对大小。 子图a： 类型：能带结构曲线图与原子结构示意
// 图的组合。 左侧部分展示了一组能量色散曲线。纵轴代表能
// 量E，横轴代表动量（未标出）。图中包含两条实线抛物线，
// 分别开口向上和向下，在中心处有能隙。这两条抛物线的内侧
// 边缘被着色以表示贝里曲率：上支带的左半部分为蓝色，右半
// 部分为红色；下支带的左半部分为红色，右半部分为蓝色。虚
// 线表示未受扰动的能带轮廓。 中间部分是一个灰色的粗箭头，
// 指向正上方，旁边标注字母“E”，表示外加电场方向向上。 右
// 侧部分是原子层结构示意图。一个黄色矩形框内标注文字“AFM
// TI (even)”。框内有六层灰色圆盘代表原子层，每层上方有一
// 个灰色小箭头表示磁矩方向。磁矩排列方式为反铁磁序：从上
// 至下依次为向上、向下、向上、向下、向上、向下。 在该结
// 构的上方和下方，分别绘制了微小的能带片段示意图，同样显
// 示红蓝相间的贝里曲率分布，且上下对称。 顶部标题文字：“
// Opposite E in same AFM state”（同一AFM态下的相反电场）。
// 此标题横跨子图a和b。 子图b： 类型：同子图a。 左侧部分
// 的能带结构与子图a完全相同，包括形状、颜色和贝里曲率分
// 布（上支带左蓝右红，下支带左红右蓝）。 中间部分是一个
// 灰色的粗箭头，指向正下方，旁边标注字母“E”，表示外加电
// 场方向向下，与子图a相反。 右侧部分的原子层结构示意图与
// 子图a完全相同，磁矩排列仍为反铁磁序（上、下、上、下、
// 上、下）。 顶部标题同子图a。 子图c： 类型：同子图a。
// 左侧部分的能带结构与子图a和b完全相同，贝里曲率分布保持
// 一致（上支带左蓝右红，下支带左红右蓝）。 中间部分是一
// 个灰色的粗箭头，指向正上方，旁边标注字母“E”，表示外加
// 电场方向向上。 右侧部分的原子层结构示意图中，黄色矩形
// 框内标注文字“AFM TI (even)”。磁矩排列方式与子图a不同，
// 为另一种反铁磁构型：从上至下依次为向下、向上、向下、向
// 上、向下、向上。 顶部标题文字：“Opposite AFM states
// under same E”（相同电场下的相反AFM态）。此标题横跨子图
// c和d。 子图d： 类型：同子图a。 左侧部分的能带结构与子
// 图a、b、c完全相同，贝里曲率分布保持一致。 中间部分是一
// 个灰色的粗箭头，指向正上方，旁边标注字母“E”，表示外加
// 电场方向向上，与子图c相同。 右侧部分的原子层结构示意图
// 与子图c完全相同，磁矩排列为向下、向上、向下、向上、向
// 下、向上。 顶部标题同子图c。
#figure(image("imgs/Opposite_Domain.png", width: 16cm),
  caption: [
    Schematic electronic structure and Berry curvature of even-layered MnBi$""_2$Te$""_4$. #strong[a,b,] Same AFM state under opposite $E$ field. #strong[c,d,] opposite AFM states under same $E$ field.
  ],
  placement: top,
)
<Opposite_Domain>

// [figvision-cn] imgs/Extended_Data_Figure_DFT.png
// 该图由五个水平排列的子图（a、b、c、d、e）组成，展示了
// 第一性原理计算的能带结构随外加电场变化的函数关系。所有
// 子图共享相同的坐标轴定义：纵轴为能量（Energy），单位是
// 电子伏特（eV），范围从-0.04 eV到0.12 eV；横轴为布里渊
// 区中的高对称点路径，标记为K - Γ - K，其中Γ点位于中心。
// 一条水平的黑色虚线贯穿所有子图，位于纵坐标0.00 eV处，
// 代表费米能级。图像最右侧设有一个垂直的颜色条图例，标题
// 为“Berry curvature”（贝里曲率），颜色渐变从底部的深蓝
// 色（代表负值，标有减号“-”）过渡到顶部的深红色（代表正
// 值，标有加号“+”）。 子图a： 类型：曲线图。 顶部标注文
// 字：“ETHY = 0 V/nm”。 内容：图中包含两条灰色实线绘制的
// 能带。上方是一条开口向上的抛物线形能带，其顶点位于Γ点，
// 能量约为0.04 eV。下方是一条开口向下的抛物线形能带，其
// 顶点也位于Γ点，能量略低于-0.03 eV。这两条能带在Γ点不接
// 触，显示出明显的能隙。由于没有颜色填充，表明此时贝里曲
// 率为零或未被着色。 子图b： 类型：曲线图。 顶部标注文字：
// “ETHY = 0.002 V/nm”。 内容：随着电场开启，上下两条能带
// 开始发生色散变化并相互靠近。上方的能带顶点下降至约0.05
// eV，下方的能带顶点上升至约-0.02 eV。能带线条呈现出颜色
// 梯度：在Γ点附近呈现淡红色，向外侧延伸逐渐变为淡蓝色。
// 这表明在Γ点附近产生了微弱的正贝里曲率，而在远离Γ点的区
// 域产生微弱的负贝里曲率。 子图c： 类型：曲线图。 顶部标
// 注文字：“ETHY = 0.005 V/nm”。 内容：上下能带进一步靠近。
// 上能带顶点降至约0.06 eV，下能带顶点升至约-0.01 eV。颜
// 色对比度增强：在Γ点附近的能带部分显示为明显的红色，而
// 远离Γ点的部分显示为明显的蓝色。这表示正负贝里曲率的强
// 度随电场增加而增大。 子图d： 类型：曲线图。 顶部标注文
// 字：“ETHY = 0.01 V/nm”。 内容：上下能带几乎接触。上能
// 带顶点降至约0.07 eV，下能带顶点升至接近0.00 eV。颜色分
// 布更加显著，Γ点附近的红色区域和外侧的蓝色区域界限分明
// 且颜色饱和度高。 子图e： 类型：曲线图。 顶部标注文字：
// “ETHY = 0.015 V/nm”。 内容：这是展示的最强电场情况。上
// 下能带在Γ点附近发生了显著的相互作用，形成了复杂的能带
// 交叉和反交叉结构。原本单一的抛物线形状变得复杂，特别是
// 在费米能级（0.00 eV）附近出现了多个分裂的能带分支。颜
// 色映射显示了强烈的贝里曲率分布：在能带交叉和弯曲剧烈的
// 区域，红色（正曲率）和蓝色（负曲率）交替出现，形成复杂
// 的图案。 整体趋势与结论： 随着垂直电场（ETHY）从0 V/nm
// 增加到0.015 V/nm，材料的能带结构发生连续演化。主要趋势
// 是价带顶和导带底之间的能隙逐渐减小，最终导致能带在Γ点
// 附近发生重叠或准简并。同时，非零电场的引入打破了系统的
// 某些对称性，诱导产生了空间分布不均匀的贝里曲率（由红蓝
// 颜色表示），且贝里曲率的幅值随电场强度的增加而显著增强。
#figure(image("imgs/Extended_Data_Figure_DFT.png", width: 17cm),
  caption: [
    #strong[First-principles calculated band structures as a function of electric field.]
  ],
  placement: top,
)
<Extended_Data_Figure_DFT>

// [figvision-cn] imgs/Extended_Data_Figure_Contrast.png
// 子图a包含上下两部分。上半部分为单层MnBi2Te6的原子晶格
// 结构示意图，展示了三种原子的排列方式：紫色球体代表铋（
// Bi）原子，红色球体代表锰（Mn）原子，绿色球体代表碲（Te）
// 原子。这些原子通过连线构成层状六边形网格结构，右侧标注
// 了对应的元素符号及颜色说明。下半部分为光学显微镜照片，
// 展示了在二氧化硅（SiO2）基底上机械剥离得到的少层
// MnBi2Te6薄片。图像背景呈淡紫色，不同厚度的薄片因光学干
// 涉效应呈现出深浅不一的紫色调。图中用黄色字体和箭头标注
// 了不同区域对应的层数，分别为“3SL”、“4SL”、“5SL”、“6SL”、
// “7SL”和“8SL”。右下角有一条白色比例尺，长度为10微米（10
// μm）。 子图b是一个散点图，展示了光学对比度随层数的变化
// 关系。横坐标为“Number of SLs”，表示单层数量（即层数），
// 刻度范围从3到8，单位为整数。纵坐标为“C (%)”，表示光学
// 对比度百分比，刻度范围从-40%到10%，步长为10%，并在0%处
// 画有一条水平虚线。图中绘制了10组独立样品的数据点，每组
// 样品由不同的颜色和形状符号表示，具体对应关系由右下角图
// 例给出：S1为蓝色实心方块，S2为紫色实心圆点，S3为粉色实
// 心正三角形，S4为深红色倒三角形，S5为橙色实心右向三角形，
// S6为橙色空心右向三角形，S7为黄色实心菱形，S8为绿色实心
// 菱形，S9为青色实心菱形，S10为蓝色叉号。数据分布趋势显
// 示，随着层数从3增加到8，光学对比度C呈现单调递增趋势。
// 具体数值上，3层时对比度约为-25%至-42%，4层时约为-23%至
// -33%，5层时约为-12%至-16%，6层时跨越零值线分布在-3%至
// -1%之间，7层时为正值约3%至6%，8层时达到最高约8%至10%。
// 同一层数下不同样品的数据点紧密聚集，表明实验具有良好的
// 重复性和可靠性。
#figure(image("imgs/Extended_Data_Figure_Contrast.png", width: 13cm),
  caption: [
    #strong[a,] Lower: Optical image of few-layer flakes of MnBi$""_2$Te$""_4$ exfoliated on SiO$""_2$ substrate. Upper: Lattice of one SL MnBi$""_2$Te$""_4$. #strong[b,] Optical contrast ($C = frac(I_("flake") - I_("substrate"), I_("flake") + I_("substrate"))$) as a function of number of layers, which was independently determined by atomic force microscope. This process was repeated on many samples (each symbol in the figure represent an independent sample) to ensure a reproducible and reliable correspondence between $C$ and layer number.
  ],
  placement: top,
)
<Extended_Data_Figure_Contrast>

// [figvision-cn] imgs/Extended_Data_Figure_5SL.png
// 子图a：曲线图。横坐标为磁场B，单位特斯拉（T），范围从
// -6到6；纵坐标为霍尔电导σ_xy，单位微西门子（μS），范围
// 从-400到200以上。图中包含三条曲线，分别对应三种载流子
// 浓度：蓝色实线代表电子掺杂浓度为1.0×10¹² cm⁻²，红色实
// 线代表空穴掺杂浓度为-1.0×10¹² cm⁻²，黑色实线代表零掺杂
// （0 cm⁻²）。每条曲线在低场区呈现平台状，在高场区出现阶
// 梯式下降或上升结构。所有曲线均未穿过零点，即σ_xy始终为
// 负值，表明反常霍尔效应未发生符号反转。数据沿纵轴平移了
// 约100 μS以增强可读性，但相对趋势保持不变。 子图b：散点
// 连线图。横坐标为载流子浓度n，单位10¹² cm⁻²，范围从-3到
// +1.5；纵坐标为反常霍尔电导σ_xy^AHE，单位微西门子（μS），
// 范围从0到90。数据点为红色实心圆，用红色实线连接。在n <
// 0区域（空穴掺杂），σ_xy^AHE稳定在约45 μS；当n > 0时（
// 电子掺杂），σ_xy^AHE单调上升至峰值约85 μS后略有回落。
// 图中有一条垂直虚线位于n=0处，一条水平虚线位于σ_xy=0处。
// 标注文字“T = 2 K”位于图中央偏下位置，表示测量温度为2开
// 尔文。该图显示无论掺杂类型如何变化，σ_xy^AHE始终保持正
// 值，无符号翻转。 子图c：示意图。左侧为一个交叉点结构，
// 由四条虚线构成X形，中心有一个空心圆圈，象征非磁性拓扑
// 绝缘体（Nonmag. TI）中的狄拉克锥交点。右侧上下各有一个
// 叉号符号，上方叉号内含空心圆，下方叉号内含实心黑点，分
// 别代表自旋向上和向下的态。中间黄色矩形框内标注文字“
// Nonmag. TI”，表示非磁性拓扑绝缘体系统。整体布局对称，
// 强调无磁序时上下表面态等价且无能隙打开。 子图d：能带结
// 构示意图。背景为浅米色。左侧绘制两条抛物线型能带：上部
// 红色曲线开口向下，下部蓝色曲线开口向上，二者在原点附近
// 接近但不接触，形成微小间隙。右侧黄色矩形框内标注“AFM
// TI (odd)”，并配有六个灰色箭头：上三层箭头全部朝上，下
// 三层箭头全部朝下，表示奇数层反铁磁拓扑绝缘体的层间磁矩
// 排列方式。能带颜色映射与右侧色标一致：红色代表正贝里曲
// 率，蓝色代表负贝里曲率。此图示意在奇数层AFM系统中，由
// 于上下表面感受相同磁化方向，导致能隙打开且贝里曲率分布
// 不对称。 子图e：能带结构示意图（同d，但增加能量箭头）。
// 结构与子图d完全相同，包括红色上能带、蓝色下能带、六箭
// 头磁矩排列及“AFM TI (odd)”标签。新增一个灰色粗箭头从底
// 部指向顶部，旁边标注字母“E”，表示外加电场方向向上。该
// 图用于说明在外加电场作用下，系统仍保持相同的磁构型和能
// 带分裂特征。 子图f：能带结构示意图（同d/e，但电场方向
// 相反）。结构与子图d和e基本一致，仅将灰色粗箭头方向改为
// 从上至下，同样标注“E”。其余元素——红蓝能带形状、六箭头
// 磁矩排列、“AFM TI (odd)”标签——均保持不变。这表明即使电
// 场反向，奇数层AFM系统的能隙结构和贝里曲率分布依然维持
// 原样，体现其鲁棒性。 全局色标：位于最右侧，垂直条形，
// 标注“Berry curvature”。顶端为红色（标记“+”），底端为蓝
// 色（标记“-”），中间渐变过渡，用于解释子图d–f中能带颜色
// 的物理意义：红色区域对应正贝里曲率，蓝色区域对应负贝里
// 曲率。
#figure(image("imgs/Extended_Data_Figure_5SL.png", width: 17cm),
  caption: [
    #strong[Experimental data and microscopic picture for odd-layered MnBi$""_2$Te$""_4$.] #strong[a,b] 5SL MnBi$""_2$Te$""_4$'s AHE. In contrast to 6SL, the AHE in 5SL does not change sign as one tunes the charge density from hole-doped regime to electron-doped regime. Data at different $n$ are offset by $200$ $mu$S for visibility. #strong[c-f]. In an odd-layered AFM system, the top and bottom Dirac fermions experience same magnetizations and hence open up gaps in the same fashion. As such, conduction and valence bands have the opposite Berry curvature. Therefore, the AHE remains the same sign in the hole-doped and electron-doped regimes. This conclusion is independent of $E$.
  ],
  placement: top,
)
<Extended_Data_Figure_5SL>

#show bibliography: set text(size: 11pt)
#bibliography("refs.bib", style: "ieee", title: none)