// Cartesian axes with force vectors
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Axes
  line((-0.5, 0), (5, 0), mark: (end: ">"), stroke: 0.7pt)
  line((0, -0.5), (0, 4), mark: (end: ">"), stroke: 0.7pt)
  content((5.3, 0), $x$)
  content((0, 4.3), $y$)

  // Origin
  content((-0.3, -0.3), $O$)

  // Point of application
  let P = (2, 1.5)
  circle(P, radius: 0.08, fill: black)
  content((2.3, 1.2), $P$)

  // Force vectors
  line(P, (4, 2.5), stroke: 1.5pt + red, mark: (end: ">"))
  content((4.3, 2.7), text(fill: red, $arrow(F)_1$))

  line(P, (2, 3.5), stroke: 1.5pt + blue, mark: (end: ">"))
  content((2.4, 3.7), text(fill: blue, $arrow(F)_2$))

  // Resultant (dashed components)
  line(P, (4, 3.5), stroke: 1.5pt + purple, mark: (end: ">"))
  content((4.3, 3.7), text(fill: purple, $arrow(F)_"tot"$))

  // Dashed parallelogram
  line((4, 2.5), (4, 3.5), stroke: (dash: "dashed", paint: gray, thickness: 0.5pt))
  line((2, 3.5), (4, 3.5), stroke: (dash: "dashed", paint: gray, thickness: 0.5pt))
})
