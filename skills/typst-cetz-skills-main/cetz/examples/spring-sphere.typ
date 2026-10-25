// Vertical spring with hanging charged sphere and fixed charge below
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ceiling-y = 6
  let spring-top = ceiling-y
  let spring-bottom = 3.5
  let sphere-y = spring-bottom - 0.5
  let charge-y = 0.5

  // Ceiling (hatched line)
  line((-1.5, ceiling-y), (1.5, ceiling-y), stroke: 1pt)
  for x in range(-15, 15, step: 3) {
    let xf = x / 10
    line((xf, ceiling-y), (xf + 0.2, ceiling-y + 0.3), stroke: 0.4pt)
  }

  // Spring (zigzag)
  let coils = 8
  let amplitude = 0.4
  let spring-length = spring-top - spring-bottom
  for i in range(coils * 2) {
    let y1 = spring-top - (i / (coils * 2)) * spring-length
    let y2 = spring-top - ((i + 1) / (coils * 2)) * spring-length
    let x1 = if calc.rem(i, 2) == 0 { -amplitude } else { amplitude }
    let x2 = if calc.rem(i + 1, 2) == 0 { -amplitude } else { amplitude }
    line((x1, y1), (x2, y2), stroke: 0.7pt)
  }

  // Sphere (charge q)
  circle((0, sphere-y), radius: 0.4, fill: blue.lighten(80%), stroke: 0.7pt)
  content((0, sphere-y), text(size: 8pt, $q$))

  // Fixed charge Q below
  circle((0, charge-y), radius: 0.35, fill: blue.lighten(80%), stroke: 0.7pt)
  content((0, charge-y), text(size: 8pt, $Q$))

  // Distance annotations
  // Spring elongation
  line((1.5, spring-bottom), (1.5, spring-top), mark: (start: "|", end: "|"), stroke: 0.4pt)
  content((2.5, (spring-top + spring-bottom) / 2), text(size: 8pt, $2.5 "cm"$))

  // Distance q to Q
  line((1.5, sphere-y), (1.5, charge-y), mark: (start: "|", end: "|"), stroke: 0.4pt)
  content((2.5, (sphere-y + charge-y) / 2), text(size: 8pt, $3.5 "cm"$))
})
