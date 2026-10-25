#figure(
  cetz.canvas(length: 0.72cm, {
    import cetz.draw: *
    set-style(
      stroke: 0.7pt + black,
      mark: (end: ">", length: 0.16cm),
      content: (padding: 0.02),
    )

    let horiz(x0) = { x => (x0 + x, x) } // block on main diagonal of panel
    let frame(x0) = rect(
      (x0, 0), (x0 + 2.7, 2.7),
      fill: gray.lighten(88%), stroke: 0.9pt + black, name: "fr" + str(x0),
    )
    let blk(x0, a, b, c) = rect(
      (x0 + a, a), (x0 + b, b),
      fill: c, stroke: 0.5pt + black,
    )

    // shared energy axis
    line((-0.55, 0), (-0.55, 2.7), mark: (end: ">"), stroke: 0.7pt + black)
    content((-0.55, 3.0), $E$, text(size: 8pt))

    // (a) conventional symmetries: few large blocks
    frame(0)
    blk(0, 0, 1.2, blue.lighten(62%))
    blk(0, 1.2, 2.7, orange.lighten(62%))
    content((0.6, 0.6), [$cal(K)_1$], text(size: 7pt))
    content((1.95, 1.95), [$cal(K)_2$], text(size: 7pt))
    content((1.35, -0.45), text(size: 7.5pt)[(a) conventional symmetries])

    // (b) Hilbert space fragmentation: many small blocks
    frame(3.9)
    let sizes = ((0, 0.35), (0.35, 0.72), (0.72, 0.95), (0.95, 1.3),
      (1.3, 1.45), (1.45, 1.85), (1.85, 2.05), (2.05, 2.4), (2.4, 2.7))
    for s in sizes { blk(3.9, s.0, s.1, red.lighten(58%)) }
    content((5.25, -0.45), text(size: 7.5pt)[(b) fragmentation])

    // (c) QMBS: scar tower embedded in thermal continuum
    frame(7.8)
    blk(7.8, 0, 2.7, gray.lighten(70%))
    content((8.05, 0.35), text(size: 7pt, angle: 90deg)[thermal])
    blk(7.8, 0, 0.6, purple.lighten(55%))
    for y in range(0.12, 0.6, step: 0.12) {
      line((7.8 + 0.04, y), (7.8 + 0.56, y), stroke: 0.4pt + purple.darken(20%))
    }
    content((7.8 + 0.3, 1.7), text(size: 7pt, angle: 90deg)[scar tower])
    content((9.15, -0.45), text(size: 7.5pt)[(c) QMBS])
  }),
  caption: [
    Schematic depiction of the block diagonal structure of the Hamiltonian,
    showing the dynamically disconnected "Krylov subspaces" in systems with
    (a) conventional symmetries, (b) Hilbert space fragmentation, and (c) QMBS.
  ],
)
