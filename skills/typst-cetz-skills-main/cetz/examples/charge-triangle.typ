// Equilateral triangle with labeled point charges at vertices
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let side = 4
  let h = side * calc.sqrt(3) / 2

  // Triangle vertices
  let A = (0, 0)
  let B = (side, 0)
  let C = (side / 2, h)

  // Draw triangle sides
  line(A, B, stroke: 0.5pt + gray)
  line(B, C, stroke: 0.5pt + gray)
  line(C, A, stroke: 0.5pt + gray)

  // Side label
  content((side / 2, -0.5), $40 "cm"$)

  // Charges at vertices
  for (pos, label, sign) in (
    (A, $A$, "+"),
    (B, $B$, $-$),
    (C, $C$, "+"),
  ) {
    circle(pos, radius: 0.35, fill: if sign == "+" { blue.lighten(80%) } else { red.lighten(80%) }, stroke: 0.7pt)
    content(pos, text(size: 8pt, sign))
  }

  // Vertex labels (offset from charges)
  content((-0.6, -0.3), $A$)
  content((side + 0.6, -0.3), $B$)
  content((side / 2, h + 0.5), $C$)
})
