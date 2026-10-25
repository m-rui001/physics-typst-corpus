// Ground-state phase diagram of the link-kagome model (redrawn from TikZ).
#import "@preview/cetz:0.4.2"
#cetz.canvas(length: 1cm, padding: (left: 1.2cm, right: 1.4cm, top: 0.5cm, bottom: 0.9cm), {
  import cetz.draw: *

  let X(dx) = (dx - 3.0) * 4.5
  let Y(dy) = dy * 0.35

  // axes
  line((X(3.0), Y(0)), (X(4.1), Y(0)), stroke: (paint: black, thickness: 0.8pt), mark: (end: ">"))
  line((X(3.0), Y(0)), (X(3.0), Y(8)), stroke: (paint: black, thickness: 0.8pt), mark: (end: ">"))
  content((X(4.15), Y(0)), $Delta / Omega$, anchor: "west")
  content((X(3.0), Y(8.2)), $R_"trunc" / a$, anchor: "south")

  // long-range-interaction dashed guide line
  line((X(3.0), Y(6.5)), (X(4.0), Y(6.5)), stroke: (paint: gray, thickness: 0.8pt, dash: "dashed"))

  // left phase boundary (smooth lens edge)
  line(
    (X(3.35), Y(2.1)), (X(3.40), Y(2.65)), (X(3.45), Y(4.0)),
    (X(3.47), Y(5.5)), (X(3.47), Y(6.8)),
    stroke: (paint: black, thickness: 0.9pt),
  )
  // right phase boundary
  line(
    (X(3.70), Y(2.1)), (X(3.62), Y(2.65)), (X(3.52), Y(4.0)), (X(3.47), Y(5.5)),
    stroke: (paint: black, thickness: 0.9pt),
  )

  // DMRG phase-transition dots
  for pt in ((3.47, 6.0), (3.45, 4.0), (3.52, 4.0), (3.40, 2.65), (3.62, 2.65)) {
    circle((X(pt.at(0)), Y(pt.at(1))), radius: 0.05, fill: black, stroke: none)
  }

  // x ticks
  for (dx, lab) in ((3.0, "3"), (3.5, "3.5"), (4.0, "4")) {
    line((X(dx), Y(0)), (X(dx), Y(-0.25)), stroke: (paint: black, thickness: 0.6pt))
    content((X(dx), Y(-0.35)), lab, anchor: "north")
  }
  // y ticks
  for (dy, lab) in ((2.6458, $sqrt(7)$), (4.0, "4"), (6.0, "6")) {
    line((X(3.0), Y(dy)), (X(2.94), Y(dy)), stroke: (paint: black, thickness: 0.6pt))
    content((X(2.9), Y(dy)), lab, anchor: "east")
  }

  // region labels
  content((X(3.22), Y(4.0)), "trivial")
  content((X(3.75), Y(4.0)), "VBS")
  content((X(3.52), Y(2.05)), "SL")
})
