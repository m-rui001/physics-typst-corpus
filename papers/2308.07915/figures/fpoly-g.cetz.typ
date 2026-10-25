#import "@preview/cetz:0.4.2"

// Monomial lattice for the polynomial g of the [[144,12,12]] code.
// Redrawn from the original TikZ picture in supplemental_v2.tex (table f_polys).
#cetz.canvas(length: 0.34cm, {
  import cetz.draw: *

  // padding guides so tick/axis labels (which do not extend the auto bbox) stay visible
  line((-1.3, -1.3), (6.4, -1.3), stroke: none)
  line((-1.3, -1.3), (-1.3, 3.4), stroke: none)

  set-style(stroke: (paint: black, thickness: 0.6pt))

  // grid: 12 columns (x index 0..11) by 6 rows (y index 0..5)
  for i in range(0, 13) {
    line((i / 2.0, -0.5), (i / 2.0, 3.0))
  }
  for j in range(0, 7) {
    line((-0.5, j / 2.0), (6.0, j / 2.0))
  }

  // filled dots for the monomials with coefficient 1
  for d in ((1, 2), (0, 4), (2, 3), (1, 0), (0, 2), (2, 1)) {
    circle((d.at(0) / 2.0 + 0.25, d.at(1) / 2.0 + 0.25), radius: 0.14,
      fill: black, stroke: none)
  }

  // axis tick labels
  for i in range(0, 12) {
    content((i / 2.0 + 0.25, -0.62), text(6pt)[#i], anchor: "north")
  }
  for j in range(0, 6) {
    content((-0.62, j / 2.0 + 0.25), text(6pt)[#j], anchor: "east")
  }
  // axis names
  content((-0.45, -0.85), $x$, anchor: "north")
  content((-0.85, -0.5), $y$, anchor: "west")
})
