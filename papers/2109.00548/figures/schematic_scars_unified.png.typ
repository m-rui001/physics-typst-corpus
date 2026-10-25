#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    set-style(
      stroke: 0.7pt + black,
      mark: (end: ">", length: 0.16cm),
      content: (padding: 0.02),
    )

    // panel: energy axis with arrow + eigenstate lines (y relative to panel origin)
    let panel(x0, y0, ys) = {
      line((x0, y0), (x0, y0 + 2.5), mark: (end: ">"))
      content((x0 - 0.22, y0 + 2.62), text(size: 8pt)[$E$])
      for y in ys { line((x0 + 0.1, y0 + y), (x0 + 2.1, y0 + y), stroke: 0.55pt) }
    }
    // degenerate multiplet: 4 closely stacked lines
    let ysDeg = (0.98, 1.06, 1.14, 1.22)
    // equally spaced tower: 5 levels
    let ysTow = (0.15, 0.7, 1.25, 1.8, 2.35)

    // (a) H_sym: degenerate manifold, viewed by TT or GI formalisms
    panel(0, 4.0, ysDeg)
    content((1.05, 3.62), text(size: 7.5pt)[(a) $H_"sym"$ (TT, GI)])

    // (b) H_SGA: degeneracy lifted into an equally spaced tower
    panel(4.4, 4.0, ysTow)
    line((6.7, 4.7), (6.7, 5.25), mark: (start: "|", end: "|"), stroke: 0.5pt)
    content((6.88, 4.97), text(size: 7pt)[$Delta E$], anchor: "west")
    content((5.45, 3.62), text(size: 7.5pt)[(b) $H_"SGA"$ (TT)])

    // (c) H_qsym: degeneracy of the manifold preserved
    panel(0, 0, ysDeg)
    content((1.05, -0.42), text(size: 7.5pt)[(c) $H_"q-sym"$ (QS, GI)])

    // (d) H_scar: equally spaced tower of QMBS in the spectrum
    panel(4.4, 0, ysTow)
    content((5.45, -0.42), text(size: 7.5pt)[(d) $H_"scar"$])
    content((6.7, 1.25), text(size: 7pt)[tower of QMBS], anchor: "west")

    // horizontal arrows: adding H_lift splits (a)->(b) and (c)->(d)
    for y in (5.1, 1.1) { line((2.35, y), (4.15, y), mark: (end: ">")) }
    content((3.25, 5.35), text(size: 7.5pt)[$+ H_"lift"$])
    content((3.25, 1.35), text(size: 7.5pt)[$+ H_"lift"$])

    // vertical arrows: adding H_ann in (a)->(c) and (b)->(d)
    for x in (3.25, 7.65) { line((x, 3.55), (x, 2.85), mark: (end: ">")) }
    content((3.45, 3.2), text(size: 7.5pt)[$+ H_"ann"$], anchor: "west")
    content((7.85, 3.2), text(size: 7.5pt)[$+ H_"ann"$], anchor: "west")
  }),
  caption: [
    Schematic overview of the symmetry-based unified formalisms for QMBS. The figure only shows the eigenstates of interest, which eventually form the QMBS of $H_"scar"$.
  ],
)
