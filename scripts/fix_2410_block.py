import io, sys, shutil

p = r'E:/phys/papers/2410.05380/main.typ'
src = io.open(p, encoding='utf-8').read()
lines = src.split('\n')

# locate the tab:app24 figure via its closing label line, then backtrack to '#figure('
close = next(i for i, l in enumerate(lines) if l.strip() == ') <tab:app24>')
start = max(i for i in range(close) if lines[i].startswith('#figure('))
assert close - start < 20, (start, close)

close_pg = next(i for i, l in enumerate(lines) if l.strip() == ') <tab:PG24>')
end = max(i for i in range(close_pg) if i > close and lines[i].startswith('#figure('))
assert close_pg - end < 60, (end, close_pg)
# keep one blank line before PG figure
while end > start and lines[end-1].strip() == '':
    end -= 1

old = '\n'.join(lines[start:end])
assert 'tab:app24' in old and 'chi_(upright("PG"))' in old and 'fig:region-cp23' in old, 'slice guard failed'
print('replacing lines', start+1, 'to', end)

new = r'''#figure(
  table(
    columns: 7,
    align: center,
    [], table.cell(colspan: 3)[T2K ($nu$)], [T2K ($macron(nu)$)], [NOvA ($nu$)], [NOvA ($macron(nu)$)],
    [], [CCQE], [CC1 $pi$], [Sum], [], [], [],
    [$cal(N)$], [54], [5], [59], [13], [104], [23],
    [$N_("obs")$], [102], [15], [117], [16], [181], [33],
    [$N_("obs") - N_("bck")$], [81.6], [12.5], [94.2], [10], [117.3], [19],
    [$r = frac(N_("obs") - N_("bck"), cal(N))$], [1.5 (1.6)], [2.5 (2.4)], [1.59 (1.65)], [0.77 (0.61)], [1.13 (1.14)], [0.83 (0.83)],
  ),
  kind: table,
  caption: [Normalization coefficients $cal(N)_nu$ and $cal(N)_(macron(nu))$ in @eq:Nnu and @eq:Nan for approximations used to qualitatively describe the appearance event samples for T2K and NOvA. Numbers in parentheses are the corresponding values for the data set used for NuFIT~5.0.],
) <tab:app24>

From the numbers in the table we observe the following:

- T2K data has $r > 1$ for neutrinos and $r < 1$ for antineutrinos, so the square-bracket in @eq:Nnu has to be enhanced and the one in @eq:Nan suppressed. This can be achieved with $delta_"CP" tilde.equiv 3 pi / 2$, with a better fit in NO. This preference has been present since the first T2K results on $nu_e$ appearance. As can be seen in the last line of @tab:app24, although the preference is somewhat weaker in NuFIT~6.0 than it was in NuFIT~5.0, it is still significant; and the strongest observed effect remains in the lower-statistics CC$1 pi$ sample.
- NOvA antineutrino results have not changed since NuFIT~5.0. They have $r < 1$ and can be accommodated with either NO and $delta_"CP" tilde.equiv pi / 2$, or IO and $delta_"CP" tilde.equiv 3 pi / 2$, with a slightly better fit in NO.
- NOvA neutrino results have now 60% more statistics than in NuFIT~5.0, and they still result in $r tilde 1$. This can also be accommodated with either NO and $delta_"CP" tilde.equiv pi / 2$, or IO and $delta_"CP" tilde.equiv 3 pi / 2$, totally compatible with the NOvA antineutrino results. Altogether, the results from NOvA only show a very mild preference for NO.
- The favored values of $delta_"CP"$ in NO by T2K and NOvA do not agree. Consequently, the combination of both experiments is better described in IO with $delta_"CP" tilde.equiv 3 pi / 2$. This was already the case in NuFIT~5.0, and the tendency has strengthened with the updated results.

This is further illustrated in @fig:compare-dcp24, which shows the $Delta chi^2$ profiles as a function of $delta_"CP"$ for the LBL experiments T2K and NOvA and their combination (we also add the information from MBL reactors and from the IC atmospheric samples which we independently analyzed in NuFIT~5.0 and NuFIT~6.0, and will discuss in @sec:reacatm). Comparing the curves of T2K and NOvA in the upper and lower panels, we see that the main difference is in the NOvA neutrino results. Just by themselves, they disfavor NO and $delta_"CP" tilde.equiv 3 pi / 2$ by about 6 units in $chi^2$ (versus 3 units in NuFIT~5.0), whereas comparing the corresponding curves in the left panels we see that for IO the consistent preference of T2K and NOvA for $delta_"CP" tilde.equiv 3 pi / 2$ is now statistically more significant. Altogether, this drives the preference of the LBL combination for IO, with $Delta chi^2 ( upright("NO") - upright("IO") ) approx 3.2$ versus 1.5 in NuFIT~5.0.

#figure(
  image("imgs/Figures_fig-chisq-viola.pdf.wired.png", width: 100%),
  caption: [$Delta chi^2$ profiles as a function of $delta_"CP"$ for different data sets and combinations as labeled in the figure. In the curves where the reactors $R$ are not included in the combination we have fixed $sin^2 theta_13 = 0.0222$ as well as the solar parameters and minimized with respect to $theta_23$ and $|Delta m^2_(3 ell)|$. When the reactors are included $theta_13$ is also marginalized. Left (right) panels are for IO (NO) and $Delta chi^2$ is shown with respect to the global best-fit point for each curve. Upper panels are for the NuFIT~5.0 data set, whereas lower panels correspond to the current update.],
) <fig:compare-dcp24>

#figure(image("imgs/fig-snq23_dCP.png", width: 70%),
  caption: [
 $1 sigma$ and $2 sigma$ allowed regions (2 dof) for T2K (red shading), NOvA (blue shading) and their combination (black curves). Contours are defined with respect to the local minimum for IO (left) or NO (right). We fix $sin^2 theta_13 = 0.0222$, $sin^2 theta_12 = 0.31$, $Delta m^2_(21)=7.5times 10^{-5}~"eV"$ and minimize with respect to $|Delta m^2_(3 ell)|$.
  ]
) <fig:sq23-dCP24>

The two-dimensional regions for T2K and NOvA in the ($delta_"CP"$, $sin^2 theta_23$) plane for fixed $theta_13$ are shown in @fig:sq23-dCP24. The better consistency for IO is apparent. For NO we find that, unlike in NuFIT~5.0, the $1 sigma$ regions do not overlap. The 2-dimensional projections in the ($delta_"CP"$, $sin^2 theta_23$) plane from the global analysis of all data are shown in @fig:region-cp23, which resemble to a large extent the features from the combination among T2K and NOvA discussed above. We observe, in particular, non-trivial correlations between these two parameters and the MO. For IO, the preference for $delta_"CP" tilde.eq 270 degree$ is highly significant, whereas for NO a more complicated structure in the ($delta_"CP"$, $sin^2 theta_23$) plane, with several local minima, emerges. The octant degeneracy for $theta_23$ is present with $Delta chi^2 < 4$ for both mass orderings and both data variants, showing local minima around $sin^2 theta_23 approx 0.56$ and 0.47.

#figure(image("src/Figures/fig-region-cp23.pdf", width: 90.0%),
  caption: [
  Two-dimensional projection of the allowed six-dimensional region from global data in the plane of ($delta_"CP"$, $sin^2 theta_23$) for IO (left) and NO (right) after minimization with respect to the undisplayed parameters. Regions for both orderings are defined with respect to the global best-fit point. The different contours correspond to $1 sigma$, 90%, $2 sigma$, 99%, $3 sigma$ CL (2 dof). Colored regions (black contours) correspond to the variant with IC19 and without SK-atm (with IC24 and with SK-atm).
  ]
) <fig:region-cp23>

An obvious question to address is whether T2K and NOvA are in tension with each other at a worrisome level. Consistency among different data sets can be quantified with the parameter goodness-of-fit (PG) @Maltoni:2003cu. For a number $N$ of different data sets $i$, each depending on $n_i$ model parameters, and globally depending on $n_("glob")$ parameters, it can be shown that the test statistic

$
  chi_"PG"^2 equiv chi_("min,glob")^2 - sum_i^N chi_("min", i)^2
  = min [ sum_i^N chi_i^2 ] - sum_i chi_("min", i)^2 ,
$

follows a $chi^2$ distribution with $n equiv sum_i n_i - n_("glob")$ degrees of freedom @Maltoni:2003cu.

Applying this test to the full NOvA and T2K samples (including both appearance and disappearance data for neutrinos and antineutrinos) we obtain the values in @tab:PG24. We carry out the analysis separately for each mass ordering, in all cases fixing $Delta m^2_(21)$ and $theta_12$ to their best fit. In the results reported in the upper part of the table $theta_13$ is varied in the minimization, so $n_("T2K") = n_("NOvA") = n_("glob=T2K+NOvA") = 4$ (#emph[i.e.], $Delta m^2_(3 ell)$, $theta_23$, $delta_"CP"$, and $theta_13$). In the lower part $theta_13$ is kept fixed to its best fit so $n_("T2K") = n_("NOvA") = n_("glob=T2K+NOvA") = 3$. From the table we read that, as expected, agreement is better in IO, where irrespective on $theta_13$ the samples are compatible at the $0.5 sigma$ level or better. In NO, compatibility arises at $1.7 sigma$ ($2.0 sigma$) for free (fixed) $theta_13$. This is to be compared with the NuFIT~5.0 results of $1.4 sigma$ ($1.7 sigma$) respectively. We conclude that the tension between T2K and NOvA in NO has slightly strengthened with the new results, reaching at most the $2 sigma$ level.
'''

shutil.copyfile(p, p + '.preblock')
out = '\n'.join(lines[:start]) + '\n' + new + '\n'.join(lines[end:])
io.open(p, 'w', encoding='utf-8', newline='\n').write(out)
print('ok')
