import io, shutil

p = r'E:/phys/papers/2410.05380/main.typ'
lines = io.open(p, encoding='utf-8').read().split('\n')

start = next(i for i, l in enumerate(lines) if l.startswith('#figure(image("imgs/fig-region-mbeta-K.png"'))
end = next(i for i, l in enumerate(lines) if l.startswith('We provide also updated ranges and correlations'))
assert end > start and end - start < 120
old = '\n'.join(lines[start:end+1])
assert '<fig:mprobes24>' in old and '= Summary <sec:conclu>' in old
print('replacing', start+1, end+1)

new = r'''#figure(image("imgs/fig-region-mbeta-K.png", width: 70%),
  caption: [Upper: 95% CL allowed ranges of the three probes of the absolute neutrino mass $sum m_nu$, $m_(nu_e)$, $m_(e e)$ as a function of the mass of the lightest neutrino obtained from projecting the results of the global analysis of oscillation data. The regions are defined with respect to the minimum for each ordering. Lower: Corresponding 95% CL allowed regions (for 2 dof) in the planes ($m_(nu_e)$, $sum m_nu$), ($m_(e e)$, $sum m_nu$), and ($m_(nu_e)$, $m_(e e)$).],
) <fig:mprobes24>

Because of its quantum-interference nature, mass-induced flavor oscillations are sensitive to the phase differences induced by the mass-squared splittings $Delta m^2_(i j)$ and to misalignment between the detection and propagation eigenstates, #emph[i.e.], to the leptonic mixing matrix elements $U_(alpha j)$. They are, however, insensitive to overall shifts of the energy levels, and hence they cannot provide information on the absolute mass scale of the neutrinos other than the obvious lower bound on the masses of the heaviest states involved in the oscillations.

The most model-independent information on the neutrino mass, rather than on mass differences, is obtained from kinematic studies of reactions in which a neutrino or an antineutrino is involved. In the presence of mixing, the most relevant constraint comes from the study of the end point ($E tilde E_0$) of the electron spectrum in Tritium beta decay $^3"H" arrow.r ^3"He" + e^- + macron(nu)_e$. This spectrum can be effectively described by a single parameter, $m_(nu_e)$, if for all neutrino states $E_0 - E >> m_i$:

$ m_(nu_e)^2 equiv frac(sum_i m_i^2 |U_(e i)|^2, sum_i |U_(e i)|^2) = sum_i m_i^2 |U_(e i)|^2 , $ <eq:mbeta>

where the second equality holds if unitarity is assumed. The most recent result on the kinematic search for neutrino mass in tritium decay is from KATRIN @Katrin:2024tvg, which sets an upper limit $m_(nu_e) < 0.45 "eV"$ at 90% CL.

Direct information on neutrino masses can also be obtained from neutrinoless double beta decay $(A, Z) arrow.r (A, Z + 2) + e^- + e^-$. This process violates lepton number by two units, hence in order to induce the $0 nu beta beta$ decay, neutrinos must be Majorana particles. In particular, if the only effective lepton number violation at low energies is induced by a Majorana mass term for neutrinos, the rate of $0 nu beta beta$ decay is proportional to the #emph[effective Majorana mass of $nu_e$]:

$ m_(e e) = abs(sum_i m_i U_(e i)^2) . $

Currently the strongest bound on $0 nu beta beta$ decay lifetimes are obtained with Germanium ($T_(1 \/ 2)^(0 nu) > 1.8 times 10^26 "yr"$) by GERDA @GERDA:2020xhi and with Xenon ($T_(1 \/ 2)^(0 nu) > 3.8 times 10^26 "yr"$) by KamLAND-Zen @KamLAND-Zen:2024eml. Depending on the assumed nuclear matrix elements, these correspond to 90% CL limits of $m_(e e) lt.tilde 0.079$--$0.180$ eV @GERDA:2020xhi and $m_(e e) lt.tilde 0.028$--$0.122$ eV @KamLAND-Zen:2024eml, respectively.

Finally, neutrino masses also have effects in cosmology. In general, cosmological data mostly gives information on the sum of the neutrino masses, $sum m_nu$, while it has very little to say on their mixing structure and on the ordering of the mass states. At present, no positive evidence of the cosmological effect of a non-zero neutrino mass has been observed, which results into upper bounds on $sum m_nu$ in the range of $sum m_nu lt.tilde 0.04$--$0.3$ eV (see, #emph[e.g.], @Jiang:2024viw, @Naredo-Tuero:2024sgf and references therein for post-DESI @DESI:2024mwx global analyses) depending on, #emph[e.g.], the cosmological data included in the analysis, assumptions on the cosmological model, the statistical approach, the treatment of systematics, or parameter priors.

Within the $3 nu$-mixing scenario, for each mass ordering, the values of these observables can be directly predicted in terms of the parameters determined in the global oscillation analysis and a single mass scale, which is usually taken to be the lightest neutrino mass $m_0$. In addition, the prediction for $m_(e e)$ also depends on the unknown Majorana phases:

$
  m_(nu_e) = sqrt(m_1^2 c_13^2 c_12^2 + m_2^2 c_13^2 s_12^2 + m_3^2 s_13^2) ,
  \
  m_(e e) = abs(m_1 c_13^2 c_12^2 e^(2i (alpha_1 - delta_"CP")) + m_2 c_13^2 s_12^2 e^(2i (alpha_2 - delta_"CP")) + m_3 s_13^2) ,
  \
  sum m_nu = m_1 + m_2 + m_3 ,
  \
  "with" quad "NO:" m_1 = m_0 , quad m_2 = sqrt(m_0^2 + Delta m^2_(21)) , quad m_3 = sqrt(m_0^2 + Delta m^2_(3 ell)) ,
  \
  "IO:" m_3 = m_0 , quad m_2 = sqrt(m_0^2 - Delta m^2_(3 ell)) , quad m_1 = sqrt(m_0^2 - Delta m^2_(3 ell) - Delta m^2_(21)) .
$

We show in the upper panels in @fig:mprobes24 the 95% CL allowed ranges for these three probes obtained from the projection of the results of the NuFIT~6.0 global oscillation analysis as a function of $m_0$. The larger width of the regions for the $m_(e e)$ predictions is due to the unknown Majorana phases. The regions are shown including only the information from the oscillation data (void regions) and also in combination with the results from KATRIN (filled regions). For the latter, we build a $chi^2$ function trivially based on their quoted result $m_(nu_e)^2 = -0.14_(- 0.15)^(+ 0.13) "eV"$ under the assumptions of Gaussianity, applicability of Wilks' theorem (despite the physical boundary $m_(nu_e)^2 gt.eq 0$), and quadratic systematics. Under these assumptions, $chi^2 (m_(nu_e)) = (m_(nu_e)^2 + 0.14)^2 \/ 0.13^2$ yields a 90% CL upper bound $m_(nu_e) lt.eq 0.35 "eV"$ which lies in between the bounds $m_(nu_e) lt.eq 0.45 "eV"$ and $m_(nu_e) lt.eq 0.31 "eV"$ obtained by the collaboration with the Lokhov-Tkachov and Feldman-Cousins methods, respectively.

Using the above expressions, one can substitute $m_0$ by any of the three probes in the expressions of the other two. Thus, within the three-neutrino mixing scenario the predicted values for these three probes are strongly correlated. We show in the lower panels in @fig:mprobes24 the present status of these correlations. As those panels show, with a positive determination of two of these probes one can in principle obtain information on the value of the Majorana phases and/or the mass ordering @Fogli:2004as. @Pascoli:2005zb. Furthermore, a sufficiently strong upper bound can provide information about the ordering of the states @Gariazzo:2022ahe.

Quantitatively, the global analysis of oscillation data together with the bound from the KATRIN experiment implies that at 95% CL

$
  0.0085 "eV" lt.eq m_(nu_e) lt.eq 0.4 "eV" quad "for NO", quad 0.048 "eV" lt.eq m_(nu_e) lt.eq 0.4 "eV" quad "for IO",
  \
  0.058 "eV" lt.eq sum m_nu lt.eq 1.2 "eV" quad "for NO", quad 0.098 "eV" lt.eq sum m_nu lt.eq 1.2 "eV" quad "for IO"
$

and for Majorana neutrinos also

$ 0 lt.eq m_(e e) lt.eq 0.41 "eV" quad "for NO", quad 0.015 "eV" lt.eq m_(e e) lt.eq 0.41 "eV" quad "for IO" . $

= Summary <sec:conclu>

We have presented an updated global analysis of world oscillation data up to September 2024 as listed in Appendix~#ref(<sec:appendix-data24>, supplement: none). Our results are presented in two versions: "IC19 w/o SK-atm" including all the data for which enough information is available to perform an independent accurate fit, and "IC24 with SK-atm" which includes $chi^2$ data tables provided by the IceCube and Super Kamiokande collaborations that we add to our own $chi^2$. The global best-fit values as well as $1 sigma$ and $3 sigma$ ranges for all parameters are given in @tab:bfranges24. The main results can be summarized as follows:

- The determination of the parameters $theta_12$, $theta_13$, $Delta m^2_(21)$, and $|Delta m^2_(3 ell)|$ is very stable, with Gaussian $chi^2$ profiles up to high CL. The relative precision at $3 sigma$ for these parameters is about 13%, 8%, 16%, (5--6)%, respectively.
- For $theta_23$ the precision at $3 sigma$ is still about 20%, and the determination suffers from the octant ambiguity. There is a slight preference for the second octant, $theta_23 > 45 degree$, (except for NO and the "IC24 with SK-atm" data) but for all combinations of datasets and mass orderings, the local minimum in the other octant always has $Delta chi^2 < 4$.
- The determination of the leptonic CP phase $delta_"CP"$ strongly depends on the mass ordering. For NO the best-fit point is very close to the CP-conserving value of $180 degree$ (with $Delta chi^2 < 1$), and the $chi^2$ profile is highly non-Gaussian, with some dependence on the two data variants and on the octant of $theta_23$. For IO, the best fit points for both data variants are close to maximal CP violation $delta_"CP" = 270 degree$ (within $1 sigma$), disfavoring CP conservation at $3.6 sigma$ ($4 sigma$) for the "IC19 w/o SK-atm" ("IC24 with SK-atm") analysis.
- Concerning the mass ordering, we find $Delta chi_("IO,NO")^2 = -0.6 (6.1)$ for the "IC19 w/o SK-atm" ("IC24 with SK-atm") analysis. The indecisive result for the "IC19 w/o SK-atm" analysis emerges from opposite trends in the long-baseline accelerator appearance data from T2K and NOvA on the one hand, and in the combination of the disappearance channels from accelerator and reactor experiments on the other hand. In the former case, the tension between T2K and NOvA for NO has reached $2 sigma$ with the latest NOvA update, whereas they are perfectly consistent for IO. Conversely, the determination of $|Delta m^2_(3 ell)|$ from $nu_mu$ and $nu_e$ disappearance agrees better for NO than for IO. While a sensitivity analysis suggests that global "IC19 w/o SK-atm" data has a median sensitivity of $2.5 sigma$ ($2.8 sigma$) to reject NO (IO), the actual result is only $1.7 sigma$ ($1.4 sigma$) for NO (IO) because of the opposite trends in the data. The addition of IC24 and SK-atm data provides additional preference for NO leading to the above quoted result of $Delta chi_("IO,NO")^2 = 6.1$.

We provide also updated ranges and correlations for the effective parameters sensitive to the absolute neutrino mass from $beta$-decay, neutrinoless double-beta decay, and cosmology. All results and supplementary material such as additional figures and data tables are provided at the NuFit webpage @nufit.'''

shutil.copyfile(p, p + '.pretail')
out = '\n'.join(lines[:start]) + '\n' + new + '\n'.join(lines[end+1:])
io.open(p, 'w', encoding='utf-8', newline='\n').write(out)
print('ok')
