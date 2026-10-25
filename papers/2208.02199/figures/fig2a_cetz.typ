// Redraw of Figure 2A from arXiv:2208.02199
// "Adiabatic state preparation for a model [2Fe-2S] cluster"
// Panel A: Structure and simplified active space model of [2Fe-2S] cluster.
//
// [Fe2S2] rhombus core (Fe 3d / S 3p active space) capped by four
// thiolate S-CH3 ligands; active space n_act = 12 (10 Fe 3d + 2 S 3p_z).

#import "@preview/cetz:0.4.2"

// ---- palette -------------------------------------------------------------
#let cFe = rgb("#C8813F")   // iron, bronze-orange
#let cS  = rgb("#F2C94C")   // sulfur, golden yellow
#let cC  = rgb("#46B3A6")   // carbon, teal
#let cH  = rgb("#FFFFFF")   // hydrogen, white
#let cStick = rgb("#B9C4CE") // bond sticks, soft slate
#let cInk   = rgb("#2B2F33") // label ink

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  set-style(
    stroke: (cap: "round", join: "round"),
    line: (stroke: 2.4pt + cStick),
  )

  // ---- geometry -----------------------------------------------------------
  // core
  let feL = (-1.15, 0)
  let feR = ( 1.15, 0)
  let sT  = (0,  0.80)
  let sB  = (0, -0.80)

  // ligand arms (thiolate S-CH3), mirrored on both sides
  // each arm: Fe -> S_lig -> C -> (H, H)
  let arm(fe, ang) = {
    let s  = (fe.at(0) + 1.05 * calc.cos(ang), fe.at(1) + 1.05 * calc.sin(ang))
    let a2 = ang + 12deg
    let c  = (s.at(0) + 0.80 * calc.cos(a2), s.at(1) + 0.80 * calc.sin(a2))
    let h1 = (c.at(0) + 0.44 * calc.cos(a2 - 33deg), c.at(1) + 0.44 * calc.sin(a2 - 33deg))
    let h2 = (c.at(0) + 0.44 * calc.cos(a2 + 33deg), c.at(1) + 0.44 * calc.sin(a2 + 33deg))
    (s, c, h1, h2)
  }
  let arms = (
    arm(feL, 115deg), arm(feL, -115deg),
    arm(feR,  65deg), arm(feR,  -65deg),
  )

  // ---- bonds (under the atoms) -------------------------------------------
  // core Fe-S rhombus edges
  line(feL, sT)
  line(sT, feR)
  line(feR, sB)
  line(sB, feL)

  // ---- ligand sticks: arms 0,1 hang off feL; arms 2,3 off feR ---------------
  let feOf = (feL, feL, feR, feR)
  for (i, (s, c, h1, h2)) in arms.enumerate() {
    line(feOf.at(i), s)
    line(s, c)
    line(c, h1)
    line(c, h2)
  }

  // hydrogen
  for ((s, c, h1, h2)) in arms {
    circle(h1, radius: 0.14, fill: cH, stroke: 0.8pt + cStick)
    circle(h2, radius: 0.14, fill: cH, stroke: 0.8pt + cStick)
  }
  // ligand carbons
  for ((s, c, h1, h2)) in arms {
    circle(c, radius: 0.21, fill: cC, stroke: none)
  }
  // ligand sulfurs
  for ((s, c, h1, h2)) in arms {
    circle(s, radius: 0.27, fill: cS, stroke: none)
  }
  // core sulfurs (labeled)
  circle(sT, radius: 0.30, fill: cS, stroke: none)
  circle(sB, radius: 0.30, fill: cS, stroke: none)
  content(sT, text(size: 10pt, fill: cInk, weight: "bold")[S])
  content(sB, text(size: 10pt, fill: cInk, weight: "bold")[S])
  // irons (labeled)
  circle(feL, radius: 0.33, fill: cFe, stroke: none)
  circle(feR, radius: 0.33, fill: cFe, stroke: none)
  content(feL, text(size: 10pt, fill: white, weight: "bold")[Fe])
  content(feR, text(size: 10pt, fill: white, weight: "bold")[Fe])

  // ---- z axis -------------------------------------------------------------
  line((3.25, -0.9), (3.25, 1.55), stroke: 1pt + cInk, mark: (end: ">"))

  // ---- legend -------------------------------------------------------------
  let legY = 2.85
  let chip(x, col, lbl, ink) = {
    circle((x, legY), radius: 0.15, fill: col, stroke: if col == cH { 0.8pt + cStick } else { none })
    content((x + 0.28, legY), text(size: 9pt, fill: ink)[#lbl], anchor: "west")
  }
  chip(-2.6, cFe, [Fe], white)
  chip(-1.55, cS, [S], cInk)
  chip(-0.5, cC, [C], cInk)
  chip(0.55, cH, [H], cInk)

  // ---- panel label & annotation -------------------------------------------
  content((-3.35, 3.25), text(size: 13pt, weight: "bold")[A])
  content((3.25, 1.85), $hat(z)$)
  content((0, -2.95), text(size: 9.5pt)[$n_"act"=12$ (10 Fe $3d$ and 2 S $3p_z$)])
})
