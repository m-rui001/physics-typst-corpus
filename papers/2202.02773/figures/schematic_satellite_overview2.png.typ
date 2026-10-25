#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    set-style(stroke: (paint: black, thickness: 0.7pt, cap: "round", join: "round"))

    // ---- solar panel wings ----
    line((-1.35, 0), (-1.8, 0), stroke: 1pt)
    line((1.35, 0), (1.8, 0), stroke: 1pt)
    rect((-3.6, -0.85), (-1.8, 0.85), radius: 0.06,
      fill: blue.lighten(75%), stroke: blue.darken(30%))
    rect((1.8, -0.85), (3.6, 0.85), radius: 0.06,
      fill: blue.lighten(75%), stroke: blue.darken(30%))
    line((-3.6, 0), (-1.8, 0), stroke: (paint: blue.darken(30%), thickness: 0.4pt))
    line((1.8, 0), (3.6, 0), stroke: (paint: blue.darken(30%), thickness: 0.4pt))
    for x in (-3.05, -2.5) { line((x, -0.85), (x, 0.85), stroke: (paint: blue.darken(30%), thickness: 0.4pt)) }
    for x in (2.5, 3.05) { line((x, -0.85), (x, 0.85), stroke: (paint: blue.darken(30%), thickness: 0.4pt)) }

    // ---- antenna mast and dish ----
    line((0, 1.5), (0, 2.15))
    circle((0, 2.15), radius: 0.11, fill: black)
    arc((0, 1.7), start: 40deg, stop: 140deg, radius: 0.55, mark: (end: ">"))

    // ---- spacecraft bus ----
    rect((-1.35, -1.5), (1.35, 1.5), radius: 0.08,
      fill: luma(238), stroke: black)

    // ---- payload decks: lft, mft, hft ----
    rect((-1.0, 0.45), (1.0, 1.2), radius: 0.06,
      fill: teal.lighten(80%), stroke: teal.darken(25%))
    rect((-1.0, -0.4), (1.0, 0.45), radius: 0.06,
      fill: green.lighten(80%), stroke: green.darken(25%))
    rect((-1.0, -1.2), (1.0, -0.4), radius: 0.06,
      fill: orange.lighten(80%), stroke: orange.darken(25%))
    content((-1.0, 0.45), (1.0, 1.2), [*lft*])
    content((-1.0, -0.4), (1.0, 0.45), [*mft*])
    content((-1.0, -1.2), (1.0, -0.4), [*hft*])

    // ---- callout arrows to the housed instruments ----
    line((1.4, 1.0), (2.3, 1.55), mark: (end: ">"), stroke: 0.6pt)
    content((2.4, 1.62), [lft], anchor: "west")
    line((1.4, 0.0), (2.3, 0.0), mark: (end: ">"), stroke: 0.6pt)
    content((2.4, 0.0), [mft], anchor: "west")
    line((1.4, -1.0), (2.3, -1.55), mark: (end: ">"), stroke: 0.6pt)
    content((2.4, -1.62), [hft], anchor: "west")

    // ---- bus annotation ----
    content((0, -1.95), [*spacecraft*], anchor: "north")
  }),
  caption: [
    Conceptual design of the spacecraft. The spacecraft houses the lft,
    the mft, and the hft.
  ],
)
