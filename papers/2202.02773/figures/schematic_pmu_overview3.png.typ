#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    set-style(stroke: 0.7pt + black, mark: (end: ">", length: 0.15cm))
    let lbl(x, y, b, a: "center") = content((x, y), b, anchor: a)

    // --- AHWP: five sapphire plates (side view) ---
    group({
      for i in range(5) {
        let x = 3.2 + i * 0.42
        let h = 2.4 - 0.22 * i
        rect((x, -h), (x + 0.22, h), fill: blue.lighten(45% - 8% * i), name: "plate" + str(i))
      }
      line((5.4, 2.6), (1.9, 2.6), mark: (start: "|", end: "|"), stroke: 0.4pt + gray)
      lbl(3.6, 2.95, [*AHWP*]
        + linebreak()
        + [5-layer sapphire plates, ~500#h(0.1em)mm \$phi\$], a: "south")
      // moth-eye AR coatings on two outer surfaces
      for (y, dy) in ((-2.35, 0.16), (2.35, -0.16)) {
        for k in range(7) { line((2.95 + k * 0.38, y), (3.05 + k * 0.38, y + dy), stroke: 0.4pt + blue.darken(30%)) }
      }
      lbl(5.85, 1.55, [*moth-eye* + linebreak() + [*AR layers*]], a: "west", angle: 0deg)
      line((5.6, 1.7), (4.15, 1.7), mark: (end: ">"), stroke: 0.4pt)
      line((5.6, -1.7), (4.15, -1.7), mark: (end: ">"), stroke: 0.4pt)
    }, name: "ahwp-grp")

    // --- leaf-like holder (leaf springs around AHWP) ---
    group({
      for (x0, mx) in ((1.5, 1), (6.5, -1)) {
        line((x0, -2.6), (x0 + 0.35 * mx, -1.7), (x0, -0.8), (x0 + 0.35 * mx, 0.1), (x0, 1.0), stroke: 1.1pt + orange.darken(20%))
        line((x0, -2.75), (x0 + 0.35 * mx, -1.85), (x0, -0.95), (x0 + 0.35 * mx, -0.05), (x0, 0.85), stroke: 0.9pt + orange.darken(20%))
        line((x0, 0.1), (x0 - 0.9 * mx, 1.7), (x0 - 1.9 * mx, 1.55), stroke: 0.9pt + orange.darken(20%))
        line((x0, 0.1), (x0 - 0.9 * mx, -1.5), (x0 - 1.9 * mx, -1.35), stroke: 0.9pt + orange.darken(20%))
      }
      content((7.3, 2.0), [*Leaf-like holder* + linebreak() + [thermal contact, launch-safe]], a: "west")
      line((6.9, 1.9), (6.45, 0.5), mark: (end: ">"), stroke: 0.4pt)
    }, name: "holder")

    // --- rotation axis & rotor ---
    line((3.0, -3.6), (3.0, 3.6), stroke: (paint: gray, thickness: 0.5pt, dash: "dashed"))
    line((0.6, -4.3), (6.2, -4.3), mark: (end: ">"), stroke: 0.6pt + red.darken(20%),
      mark: (end: (symbol: ">", width: 0.3cm)))
    lbl(3.4, -4.65, [*rotor rotation*], a: "north")

    // --- superconducting bearing stack (bottom) ---
    group({
      rect((1.1, -5.4), (5.9, -4.9), radius: 0.08, fill: green.lighten(70%))
      lbl(3.5, -5.15, [*ring YBCO*])
      rect((1.1, -6.0), (5.9, -5.5), radius: 0.08, fill: red.lighten(75%))
      lbl(3.5, -5.75, [*ring magnet*])
      line((3.5, -4.9), (3.5, -4.55), mark: (start: "<", end: ">"), stroke: 0.5pt + gray)
      lbl(6.15, -5.15, [*superconducting* + linebreak() + [*bearing*]], a: "west")
    }, name: "bearing")

    // --- rotation mechanism boxes (top) ---
    let bx(x, y, w, h, title, sub, name) = {
      rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2), radius: 0.12, fill: yellow.lighten(80%), name: name)
      content((x, y + h * 0.14), [*#title*])
      content((x, y - h * 0.22), sub)
    }
    group({
      bx(0.0, 3.9, 2.2, 1.3, "Drive motor", [drives rotor], "bx-motor")
      bx(3.5, 5.2, 2.6, 1.3, "Optical encoder", [monitors rotor position], "bx-enc")
      bx(7.2, 3.9, 2.2, 1.3, "Gripper", [cryogenic holder], "bx-grip")
      // arrows from mechanism onto rotor top
      line((0.2, 3.2), (1.7, 2.75), mark: (end: ">"), stroke: 0.4pt)
      line((3.7, 4.5), (3.6, 2.75), mark: (end: ">"), stroke: 0.4pt)
      line((6.9, 3.4), (5.6, 2.4), mark: (end: ">"), stroke: 0.4pt)
      content((3.5, 2.6), [rotation mechanism], a: "south", stroke: none)
    }, name: "mech")

    // --- launch lock (top plate squeezing rotor) ---
    group({
      rect((0.7, 1.0), (6.3, 0.55), radius: 0.06, fill: gray.lighten(60%))
      for x in (1.0, 2.3, 4.6, 5.9) { line((x, 0.55), (x, -0.35), mark: (end: "|"), stroke: 0.8pt + gray.darken(30%)) }
      lbl(0.45, 0.78, [*Launch lock*], a: "east")
      lbl(0.45, -0.15, [(survives launch impact)], a: "east", angle: 0deg)
    }, name: "lock")

    lbl(6.4, -6.4, [~LFT PMU BBM (schematic)], a: "west", stroke: none)
  }),
  caption: [Schematic overview of the ~LFT PMU BBM and its components.],
) <fig:pmu_overview>
