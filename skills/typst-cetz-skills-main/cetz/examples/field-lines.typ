// Radial electric field lines from a positive point charge
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let n-lines = 8
  let inner-r = 0.4
  let outer-r = 2.5

  // Field lines radiating outward
  for i in range(n-lines) {
    let angle = i * 360deg / n-lines
    let start = (calc.cos(angle) * inner-r, calc.sin(angle) * inner-r)
    let end = (calc.cos(angle) * outer-r, calc.sin(angle) * outer-r)
    line(start, end, stroke: 0.6pt + blue, mark: (end: ">"))
  }

  // Central charge
  circle((0, 0), radius: inner-r, fill: red.lighten(70%), stroke: 0.7pt)
  content((0, 0), text(size: 10pt, weight: "bold", $+$))

  // Label
  content((0, -3), $arrow(E)$ + " field of a positive charge")
})
