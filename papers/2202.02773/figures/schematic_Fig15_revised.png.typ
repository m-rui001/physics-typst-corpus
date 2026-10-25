#figure(
  cetz.canvas(
    length: 0.78cm,
    {
      import cetz.draw: *
      set-style(
        stroke: (thickness: 0.7pt, paint: luma(28)),
        mark: (length: 0.17cm, width: 0.13cm),
      )
      let tag(c) = text(size: 7.3pt, fill: luma(50), c)
      let hwp = rgb("#5c6673")
      let optic = rgb("#dce8f6")
      let ray = rgb("#2f6bd4")
      let lead = luma(60) + 0.5pt
      content((4.6, 8.9), tag("Sky"), anchor: "south")
      line((4.6, 8.85), (4.6, 8.2), mark: (end: "stealth"), stroke: luma(28) + 1.1pt)
      rect((0, 0.95), (4, 7), radius: 0.12, fill: rgb("#f3f6fa"))
      circle((2, 7), radius: (2, 0.34), fill: rgb("#dae3ed"))
      rect((5, 0.95), (8.2, 7), radius: 0.12, fill: rgb("#f3f6fa"))
      circle((6.6, 7), radius: (1.6, 0.28), fill: rgb("#dae3ed"))
      line((1.15, 6.9), (2, 1.95), stroke: ray + 0.7pt)
      line((2, 6.9), (2, 1.95), stroke: ray + 0.7pt)
      line((2.85, 6.9), (2, 1.95), stroke: ray + 0.7pt)
      line((5.65, 6.9), (6.6, 1.95), stroke: ray + 0.7pt)
      line((6.6, 6.9), (6.6, 1.95), stroke: ray + 0.7pt)
      line((7.55, 6.9), (6.6, 1.95), stroke: ray + 0.7pt)
      rect((0.35, 6.24), (3.65, 6.42), fill: hwp, stroke: none)
      rect((5.25, 6.24), (7.95, 6.42), fill: hwp, stroke: none)
      arc((1.55, 6.78), start: 225deg, stop: 45deg, radius: 0.24,
        mark: (end: ">"), stroke: (paint: hwp, thickness: 0.8pt))
      content((1.45, 7.12), text(size: 7pt, fill: hwp, $omega$))
      arc((6.05, 6.78), start: 225deg, stop: 45deg, radius: 0.2,
        mark: (end: ">"), stroke: (paint: hwp, thickness: 0.8pt))
      content((5.95, 7.1), text(size: 7pt, fill: hwp, $omega$))
      circle((2, 5.05), radius: (1.3, 0.3), stroke: (paint: rgb("#4a6785"), thickness: 0.9pt),
        fill: optic.transparentize(25%))
      circle((2, 3.7), radius: (1.0, 0.22), stroke: (paint: rgb("#4a6785"), thickness: 0.9pt),
        fill: optic.transparentize(25%))
      circle((6.6, 5.05), radius: (1.05, 0.26), stroke: (paint: rgb("#4a6785"), thickness: 0.9pt),
        fill: optic.transparentize(25%))
      circle((6.6, 3.7), radius: (0.8, 0.18), stroke: (paint: rgb("#4a6785"), thickness: 0.9pt),
        fill: optic.transparentize(25%))
      rect((1.2, 1.55), (2.8, 1.86), fill: rgb("#2c3644"), stroke: rgb("#2c3644"))
      rect((5.75, 1.55), (7.45, 1.86), fill: rgb("#2c3644"), stroke: rgb("#2c3644"))
      for x in (1.5, 1.85, 2.2, 2.55) { line((x, 1.58), (x, 1.83), stroke: rgb("#f3f6fa") + 0.7pt) }
      for x in (5.98, 6.3, 6.62, 6.94, 7.26) { line((x, 1.58), (x, 1.83), stroke: rgb("#f3f6fa") + 0.7pt) }
      rect((-2.75, 0.2), (11.1, 0.95), fill: rgb("#e4e8ee"),
        stroke: (paint: luma(55), thickness: 0.7pt))
      content((4.17, 0.57), text(size: 8pt, fill: luma(50), "Mechanical structure (4.8 K)"))
      line((-0.85, 6.33), (0.32, 6.33), stroke: lead)
      content((-0.9, 6.33), tag("HWP"), anchor: "east")
      line((-0.85, 5.05), (0.66, 5.05), stroke: lead)
      content((-0.9, 5.05), $L_1$, anchor: "east")
      line((-0.85, 3.7), (0.97, 3.7), stroke: lead)
      content((-0.9, 3.7), $L_2$, anchor: "east")
      line((-0.85, 1.7), (1.16, 1.7), stroke: lead)
      content((-0.9, 1.7), tag("Focal plane"), anchor: "east")
      line((9.15, 6.33), (8.0, 6.33), stroke: lead)
      content((9.2, 6.33), tag("HWP"), anchor: "west")
      line((9.15, 5.05), (7.7, 5.05), stroke: lead)
      content((9.2, 5.05), $L_1$, anchor: "west")
      line((9.15, 3.7), (7.43, 3.7), stroke: lead)
      content((9.2, 3.7), $L_2$, anchor: "west")
      line((9.15, 1.7), (7.49, 1.7), stroke: lead)
      content((9.2, 1.7), tag("Focal plane"), anchor: "west")
      content((2, 7.9), text(size: 8.4pt, weight: "bold")[*MFT* — 89–224 GHz])
      content((6.6, 7.9), text(size: 8.4pt, weight: "bold")[*HFT* — 166–448 GHz])
      content((2, 7.5), tag([$dia$ 300 mm aperture]))
      content((6.6, 7.5), tag([$dia$ 200 mm aperture]))
    },
  ),
  caption: [Overview of the Mid- and High-Frequency Telescopes.],
)
