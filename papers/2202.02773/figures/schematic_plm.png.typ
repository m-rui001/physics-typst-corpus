#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    set-style(stroke: 0.75pt + black, mark: (end: ">", length: 0.16cm))
    let cold = blue.darken(30%)
    let warm = rgb("#b06a10")

    // Payload module platform
    rect((3.8, 0.8), (11.2, 1.8), fill: luma(232), stroke: luma(90))
    content((7.5, 1.3), text(9pt)[payload module])

    // Surrounding V-grooves: nested radiative-cooler stages
    line((3.3, 1.8), (4.3, 5.3), (10.7, 5.3), (11.7, 1.8), close: true,
      fill: orange.lighten(88%), stroke: warm + 0.8pt)
    line((4.05, 1.8), (4.85, 4.5), (10.15, 4.5), (10.95, 1.8), close: true,
      fill: orange.lighten(90%), stroke: warm)
    line((4.8, 1.8), (5.4, 3.7), (9.6, 3.7), (10.2, 1.8), close: true,
      fill: orange.lighten(92%), stroke: warm)
    content((7.5, 6.2), text(9pt)[V-grooves: passive coolers (30 K)])
    line((7.5, 6.0), (7.5, 5.45), mark: (end: ">"), stroke: warm)

    // Front: low-frequency crossed-Dragone telescope enclosure
    rect((0.3, 1.8), (3.0, 5.6), radius: 0.08,
      fill: blue.lighten(88%), stroke: cold + 0.8pt)
    circle((1.65, 5.6), radius: (1.0, 0.18), stroke: cold)
    content((0.45, 3.0), (2.85, 5.35), text(9pt)[Low-frequency crossed-Dragone telescope])
    content((1.65, 2.35), text(9pt, fill: cold)[4.8 K enclosure])
    line((0.3, 4.6), (-1.1, 4.6), mark: (end: ">"),
      stroke: (paint: gray, thickness: 0.6pt, dash: "dashed"))

    // Back: mid- and high-frequency on-axis telescope tubes
    rect((11.9, 3.5), (14.7, 4.5),
      radius: (north-east: 0.5, south-east: 0.5, rest: 0),
      fill: blue.lighten(88%), stroke: cold + 0.8pt)
    circle((14.0, 4.0), radius: (0.12, 0.4), stroke: cold)
    content((13.3, 4.85), text(9pt)[Mid-freq. on-axis telescope (4.8 K)])
    rect((11.9, 1.9), (14.7, 2.9),
      radius: (north-east: 0.5, south-east: 0.5, rest: 0),
      fill: blue.lighten(88%), stroke: cold + 0.8pt)
    circle((14.0, 2.4), radius: (0.12, 0.4), stroke: cold)
    content((13.3, 1.55), text(9pt)[High-freq. on-axis telescope (4.8 K)])

    // Viewing-direction hints
    content((0.3, 0.9), text(8pt)[_front_])
    content((15.0, 0.9), text(8pt)[_back_])

    // Temperature legend
    rect((3.0, -0.35), (3.4, -0.05), fill: blue.lighten(88%), stroke: cold)
    content((3.55, -0.2), text(8pt, anchor: "west")[4.8 K])
    rect((5.6, -0.35), (6.0, -0.05), fill: orange.lighten(88%), stroke: warm)
    content((6.15, -0.2), text(8pt, anchor: "west")[30 K"])
    rect((8.2, -0.35), (8.6, -0.05), fill: luma(232), stroke: luma(90))
    content((8.75, -0.2), text(8pt, anchor: "west")[ambient (300 K)])
  }),
  caption: [
    Payload module overview showing the surrounding V-grooves acting as passive
    coolers up to 30 K, with the 4.8-K enclosure of the low-frequency
    crossed-Dragone telescope in the front, and the two 4.8-K tubes of the mid-
    and high-frequency on-axis telescopes in the back.
  ],
)
