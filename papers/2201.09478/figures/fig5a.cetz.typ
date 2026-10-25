// Fig. 4(a) -- scheme of the Bragg spectroscopy: an auxiliary site |d> is coupled
// to the edge of a dissipative Aharonov-Bohm chain. Redrawn in CeTZ from the
// schematic panel (a) of src/fig5.png; the data panels (b)(c)(d) stay rasters.
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 0.95cm, {
  import cetz.draw: *
  let gray = rgb(0.45%, 0.45%, 0.45%)
  let blue = rgb(0.42%, 0.50%, 0.94%)
  let darkblue = rgb(0.16%, 0.24%, 0.72%)
  let green = rgb(0.36%, 0.76%, 0.20%)
  let darkgreen = rgb(0.16%, 0.48%, 0.10%)
  let purple = rgb(0.58%, 0.42%, 0.68%)
  let darkpurple = rgb(0.42%, 0.28%, 0.52%)
  let boxblue = rgb(0.20%, 0.45%, 0.75%)
  let red = rgb(0.85%, 0.20%, 0.15%)
  let bond = (paint: gray, thickness: 1.4pt)
  let fluxr = 0.34

  // auxiliary site d and the weak probe coupling
  circle((0, 0), radius: 0.33, fill: purple, stroke: (paint: darkpurple, thickness: 1pt))
  content((0, 0), [$d$])
  line((0.42, 0), (1.02, 0), stroke: (paint: purple, thickness: 2.2pt), mark: (end: ">"))

  // detuning delta between the two dashed level lines
  for x in (1.32, 1.74) {
    line((x, -0.55), (x, 0.55), stroke: (paint: gray, thickness: 0.8pt, dash: "dashed"))
  }
  line((1.32, 0.30), (1.74, 0.30), stroke: (paint: gray, thickness: 0.8pt),
    mark: (start: "<", end: ">"))
  content((1.53, 0.62), [$delta$])

  // the two unit cells of the dissipative AB chain
  let cell(xa: 0) = {
    let a = (2.25 + xa, 0)
    let b = (4.35 + xa, 0)
    let c = (3.30 + xa, 1.80)
    line(a, b, stroke: bond)
    line(a, c, stroke: bond)
    line(c, b, stroke: bond)
    arc((3.30 + xa, 0.78), radius: fluxr, start: 100deg, stop: -70deg,
      stroke: (paint: red, thickness: 1.1pt), mark: (end: ">"))
    content((3.30 + xa, 0.78), [$phi$])
    circle(a, radius: 0.33, fill: blue, stroke: (paint: darkblue, thickness: 1pt))
    circle(b, radius: 0.33, fill: blue, stroke: (paint: darkblue, thickness: 1pt))
    circle(c, radius: 0.33, fill: green, stroke: (paint: darkgreen, thickness: 1pt))
    content(a, [$a$])
    content(b, [$b$])
    content(c, [$c$])
    content((2.42 + xa, 1.12), [$J_s$])
    content((4.18 + xa, 1.12), [$J_r$])
    content((3.30 + xa, -0.58), [$J_p$])
    line((3.55 + xa, 2.02), (4.28 + xa, 2.62), stroke: (paint: gray, thickness: 1.2pt,
      dash: "dashed"), mark: (end: ">"))
    content((3.62 + xa, 2.78), [$Delta - i gamma$])
  }
  cell(xa: 0)
  line((4.68, 0), (5.27, 0), stroke: bond)
  content((4.98, -0.58), [$J_t$])
  cell(xa: 3.62)

  // continuation of the chain
  content((9.05, 0), [$dots.h(6)$])

  // enclosing box and panel label
  rect((1.12, -0.95), (8.55, 3.05), radius: 0.35, stroke: (paint: boxblue, thickness: 1pt))
  content((0.62, 2.85), [(a)])
})
