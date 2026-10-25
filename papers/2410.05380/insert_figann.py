import os, shutil

base = os.path.dirname(os.path.abspath(__file__))
p = os.path.join(base, "main.typ")
src = open(p, encoding="utf-8").read()

blocks = {}

blocks['#figure(image("imgs/fig-chisq-glob.png", width: 86%),'] = """// [figvision] imgs/fig-chisq-glob.png - 3x2 Delta chi^2 projections (NuFIT 6.0).
// Legend: solid red NO / solid blue IO (IC19 w/o SK-atm); dashed red/blue
// (IC24 with SK-atm).
// Top-left sin^2 theta_12 (0.2-0.4): minima near 0.307; dashed blue minimum
//   raised to Delta chi^2 ~7.5.
// Top-right Delta m^2_21 (6.5-8.5)e-5 eV^2: minima near 7.5, dashed blue ~6.5.
// Mid-left sin^2 theta_23 (0.4-0.65): NO minimum at 0.45 with a local minimum
//   near 0.51 (Delta chi^2 ~5 solid); IO double minimum at 0.45 and 0.57.
// Mid-right Delta m^2_32/31 ([-2.6,-2.3] and [2.4,2.6])e-3 eV^2: IO at -2.5,
//   NO at +2.5, vertical dashed reference lines at +/-2.45.
// Bottom-left sin^2 theta_13 (0.018-0.026): minimum at 0.022.
// Bottom-right delta_CP (0-360 deg): NO minimum at 180, IO minima near 90/270.
"""+'#figure(image("imgs/fig-chisq-glob.png", width: 86%),'

blocks['#figure(image("imgs/fig-region-glob.png", width: 81%),'] = """// [figvision] imgs/fig-region-glob.png - 3x2 global allowed regions (NuFIT 6.0).
// Top row: Delta m^2_31 vs Delta m^2_32 for IO (left) and NO (right), nested
//   1sigma..3sigma contours in cyan, magenta, blue, pink, red and black; star and
//   triangle best-fit markers; dashed horizontal separation at |Delta m^2| ~2.45.
// Middle row: delta_CP vs sin^2 theta_23 (0.3-0.7): IO one elongated lobe near
//   delta ~270 with sin^2 theta_23 ~0.55; NO a multi-lobe structure at 180 and
//   270 spanning sin^2 theta_23 0.45-0.57.
// Bottom row: Delta m^2_21 vs sin^2 theta_12 (ellipses near 7.5 and 0.30) and vs
//   sin^2 theta_13 (near 0.022); same colour coding for the two analysis variants.
"""+'#figure(image("imgs/fig-region-glob.png", width: 81%),'

blocks['#figure(\n  image("src/Figures/fig-nevts.pdf", width: 85%),'] = """// [figvision] src/Figures/fig-nevts.pdf - predicted event rates vs delta_CP.
// 3x2 panels, delta_CP 0-2pi. Left column T2K, right NOvA. Top and middle rows:
// nu_e CCQE samples (T2K ranges 13-25 and 55-110 events; NOvA 22-46 and
// 150-260). Bottom-left: T2K nu_e CC1pi, 6.5-10.5 events.
// Coloured bands span sin^2 theta_23 in [0.44,0.58] (darker edge = 0.58):
// red NO, blue IO. Grey horizontal band = observed +/-1 sigma with dashed
// central line (T2K 15.5, 102, 15.2; NOvA 33, 175 events).
"""+'#figure(\n  image("src/Figures/fig-nevts.pdf", width: 85%),'

blocks['#figure(\n  image("imgs/Figures_fig-chisq-viola.pdf.wired.png", width: 100%),'] = """// [figvision] imgs/Figures_fig-chisq-viola.pdf.wired.png - Delta chi^2 vs delta_CP.
// 2x2 panels: IO (left) and NO (right); upper NuFIT 5.0, lower NuFIT 6.0.
// Left: IO blue and NO red solid/dashed curves, IO minimum near 90 deg and NO
//   near 270 deg with a shallow second minimum.
// Right: NO curves minimum near 180 deg with a secondary minimum at 270 deg;
//   global (cyan) curve overlaid. Dashed curves use IC24.
"""+'#figure(\n  image("imgs/Figures_fig-chisq-viola.pdf.wired.png", width: 100%),'

blocks['#figure(image("imgs/fig-snq23_dCP.png", width: 70%),'] = """// [figvision] imgs/fig-snq23_dCP.png - T2K/NOvA region in (delta_CP, sin^2 theta_23).
// IO (left) and NO (right); sin^2 theta_23 0.35-0.65, delta_CP 0-360 deg.
// NOvA 1sigma/2sigma blue shading, T2K salmon/red shading, combined contour
// dashed black. IO: compact region near delta ~270 and sin^2 theta_23 ~0.55,
// with a lower lobe at 0.46. NO: broad blue band across all delta_CP with
// combined lobes near 180 and 270 deg.
"""+'#figure(image("imgs/fig-snq23_dCP.png", width: 70%),'

blocks['#figure(image("src/Figures/fig-region-cp23.pdf", width: 90.0%),'] = """// [figvision] src/Figures/fig-region-cp23.pdf - global (delta_CP, sin^2 theta_23).
// IO (left) and NO (right); y 0.35-0.65, x 0-360 deg. Nested 1sigma, 90%, 2sigma,
// 99% and 3sigma contours (cyan, magenta, blue, pink, red) plus a black contour
// for the alternative analysis; star and triangle mark best fits.
// IO: compact lobe at delta ~270, sin^2 theta_23 ~0.55 with a lower lobe at 0.46.
// NO: several lobes near delta ~180 and 270 spanning sin^2 theta_23 0.45-0.55,
// plus a separate region near delta ~0 and sin^2 theta_23 ~0.6.
"""+'#figure(image("src/Figures/fig-region-cp23.pdf", width: 90.0%),'

blocks['#figure(image("src/Figures/fig-region-sample.pdf", width: 90.0%),'] = """// [figvision] src/Figures/fig-region-sample.pdf - 95.45% CL regions.
// Left column (two stacked): Delta m^2_31 (upper) and Delta m^2_32 (lower) vs
// sin^2 theta_23 (0.3-0.7). Contours: Super-K dashed light brown, T2K red,
// NOvA purple, IC19 orange, IC24 orange dashed, MINOS green; filled blue region
// is the accelerator+IC19 combination near (0.5, 2.5e-3 eV^2). Dashed horizontal
// split at zero.
// Right column: the same mass splittings vs sin^2 theta_13 (0.015-0.03) with
// DayaBay salmon, Double-Chooz magenta, RENO purple and the combined black
// filled ellipse near 0.022; "[2sigma]" label at lower right.
"""+'#figure(image("src/Figures/fig-region-sample.pdf", width: 90.0%),'

dma_old = '#figure([#box(image("src/Figures/fig-chisq-dma-noIC.pdf", width: 49.0%)) #box(image("src/Figures/fig-chisq-dma-ic.pdf", width: 49.0%))],'
dma_new = """#figure([
// [figvision] src/Figures/fig-chisq-dma-noIC.pdf - Delta chi^2 vs Delta m^2.
// Two stacked panels: Delta m^2_32 (negative, -3..-2.2) and Delta m^2_31
// (+2.2..3), units 1e-3 eV^2; dashed vertical references at +/-2.5.
// Top: Reactors black, MINOS green, NOvA purple, T2K red, LBL-comb blue; minima
// at -2.55/+2.55 (reactors) and -2.5/+2.5 (others). Bottom: Reactors black plus
// R+MINOS, R+NOvA, R+T2K and R+LBL-comb combinations.
#box(image("src/Figures/fig-chisq-dma-noIC.pdf", width: 49.0%))
// [figvision] src/Figures/fig-chisq-dma-ic.pdf - same axes, IC19 vs IC24.
// Solid = IC19, dashed = IC24. Top: Reactors black, LBL-comb blue, IceCube
// orange (broad, minimum near -2.45), Global cyan (narrow, -2.5/+2.5). Bottom:
// R+ versions; the IceCube curve is shallower and the global curves remain near
// +/-2.5.
#box(image("src/Figures/fig-chisq-dma-ic.pdf", width: 49.0%))],"""

blocks['#figure(image("src/Figures/fig-sun-tension.pdf", width: 90.0%),'] = """// [figvision] src/Figures/fig-sun-tension.pdf - solar vs KamLAND/SNO+ parameters.
// Left: Delta m^2_21 (0-14)e-5 eV^2 vs sin^2 theta_12 (0.2-0.4). Filled solar
// contours for MB22 (best fit black star), dashed void contours for AAG21
// (white-dot best fit), green KamLAND+SNO+ contours (green star), orange MB22
// without SK day-night data, plus cyan/magenta/navy/pink solar CLs; ellipses
// centred near sin^2 theta_12 ~0.30 and Delta m^2_21 ~6-7.5e-5. Annotation
// sin^2 theta_13 = 0.0222.
// Right: Delta chi^2 vs Delta m^2_21 (2-10): MB22m w/o D/N from SK (orange),
// MB22m (red), AAG21 (black dashed), KamLAND (green), SNO+ (blue), KL & SNO+
// (light green); minima near 4.6, 5.9, 6.0, 7.5 and 9 respectively.
"""+'#figure(image("src/Figures/fig-sun-tension.pdf", width: 90.0%),'

blocks['#figure(image("imgs/fig-region-mbeta-K.png", width: 70%),'] = """// [figvision] imgs/fig-region-mbeta-K.png - absolute neutrino mass probes.
// 2x3 log-log panels (NO red, IO blue, grey diagonal reference).
// Top: sum m_nu vs m_light; m_nu_e vs m_light (NO plateau ~0.01 eV, IO ~0.05 eV);
//   m_ee vs m_light (IO band 0.02-0.05 eV; NO band 1e-4-0.02 eV with a notch).
// Bottom: m_nu_e vs sum m_nu; m_ee vs sum m_nu (nested NO/IO wedges); m_ee vs
//   m_nu_e with the same wedge structure. Allowed regions are 95% CL.
"""+'#figure(image("imgs/fig-region-mbeta-K.png", width: 70%),'

blocks['#figure(image("imgs/fig-IC19.png", width: 100%),'] = """// [figvision] imgs/fig-IC19.png - IceCube fit compared with Analysis A.
// Main panel: Delta m^2_32 (2.3-3.0)e-3 eV^2 vs sin^2 theta_23 (0.35-0.65) with
// nested 1sigma/90%/2sigma closed contours; black solid = our fit, blue dashed =
// IceCube Analysis A, almost coincident (best fit sin^2 theta_23 ~0.48, split
// near 2.45e-3). Top strip: Delta chi^2 vs sin^2 theta_23 with minimum ~0.48
// (black and blue dashed). Right strip: Delta chi^2 vs Delta m^2_32 rising
// approximately linearly on both sides.
"""+'#figure(image("imgs/fig-IC19.png", width: 100%),'

count = 0
for old, new in blocks.items():
    if old not in src:
        print("MISSING:", old[:70])
        continue
    if new.split(old)[0] in src and '[figvision]' in src:
        pass
    src = src.replace(old, new, 1)
    count += 1

if dma_old in src:
    src = src.replace(dma_old, dma_new, 1)
    count += 1
else:
    print("MISSING dma composite")

bak = p + ".preFigann"
if not os.path.exists(bak):
    shutil.copy2(p, bak)
open(p, "w", encoding="utf-8", newline="").write(src)
print("inserted", count)
