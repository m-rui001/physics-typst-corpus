// Extended Data Fig. 1 (src/EDcircuitecho.pdf) redrawn in CeTZ.
// Panel a: CZ-gate echo circuit identity. Panel b: Rb level scheme.
// Panel c: typical circuit + pulse sequence.
// Include this file as the body of a #figure(...).
#import "@preview/cetz:0.4.2"

#align(center)[
  // ---------------- panel a: echo circuit identity ----------------
  #cetz.canvas(length: 0.72cm, padding: (x: 0.4cm, y: 0.3cm), {
    import cetz.draw: *

    let fs = 6pt
    let blk = (paint: black, thickness: 0.8pt)
    let gry = (paint: luma(110), thickness: 0.8pt)
    let red = (paint: rgb("#c8102e"), thickness: 1.0pt)
    let dash = (paint: luma(60), thickness: 0.7pt, dash: "dashed")

    let wire(x1, x2, y) = line((x1, y), (x2, y), stroke: blk)
    let ket(x, y) = content((x, y), text(size: fs)[$|0⟩$], anchor: "east")
    let gbox(x, y, txt, st, w: 1.45, h: 0.32) = {
      rect((x - w / 2, y - h), (x + w / 2, y + h), stroke: st, fill: white)
      content((x, y), text(size: fs, txt), anchor: "center")
    }
    let ctrl(x, y) = circle((x, y), radius: 0.09, fill: black, stroke: none)
    let cz(x, ya, yb) = {
      line((x, ya), (x, yb), stroke: blk)
      ctrl(x, ya)
      ctrl(x, yb)
    }
    let meas(x, y) = {
      rect((x - 0.30, y - 0.30), (x + 0.30, y + 0.30), stroke: blk, fill: white)
      arc((x, y - 0.28), start: 35deg, stop: 145deg, radius: 0.28,
        stroke: (paint: black, thickness: 0.7pt), fill: none, mark: (end: ">"))
    }

    // ---- left circuit: four wires at y = 0 .. 3 ----
    for y in (0, 1, 2, 3) {
      wire(-0.3, 12.85, y)
      ket(-0.55, y)
      gbox(1.0, y, [$Y(pi\/2)$], gry)
      gbox(4.3, y, [$Z(zeta)$], dash, w: 1.15)
      gbox(6.0, y, [$Y(pi)$], red, w: 1.1)
      gbox(7.7, y, [$Z(zeta)$], dash, w: 1.15)
      gbox(9.9, y, [$Z(zeta)$], dash, w: 1.15)
      meas(12.4, y)
    }
    cz(2.85, 2, 3)
    cz(3.05, 0, 1)
    cz(8.85, 1, 2)
    for y in (1, 2, 3) { gbox(11.25, y, [$Y(pi\/2)$], gry) }
    content((5.6, -1.0), text(size: fs)[Systematic and spurious $Z(zeta)$], anchor: "center")

    // ---- equality ----
    content((13.75, 1.5), text(size: 9pt)[$=$], anchor: "center")

    // ---- right circuit: equivalent echo-free form ----
    for y in (0, 1, 2, 3) {
      wire(14.6, 24.4, y)
      ket(14.4, y)
      gbox(15.65, y, [$Y(pi\/2)$], gry)
      gbox(18.45, y, [$Y(pi)$], red, w: 1.1)
      gbox(21.15, y, [$Y(pi)$], red, w: 1.1)
      meas(24.0, y)
    }
    cz(17.0, 2, 3)
    cz(19.7, 0, 1)
    for y in (2, 3) { gbox(22.6, y, [$Y(pi\/2)$], gry) }
  })

  #v(9pt)

  // ---------------- panel b: 87Rb level scheme ----------------
  #cetz.canvas(length: 0.72cm, padding: (x: 0.5cm, y: 0.3cm), {
    import cetz.draw: *

    let fs = 6pt
    let blk = (paint: black, thickness: 0.9pt)
    let lvl(x1, x2, y, st: blk) = line((x1, y), (x2, y), stroke: st)
    let g = (paint: luma(150), thickness: 1.0pt)
    let rd = (paint: rgb("#c8102e"), thickness: 1.1pt)
    let bl = (paint: rgb("#00a5e0"), thickness: 1.1pt)
    let pu = (paint: rgb("#8e44ad"), thickness: 1.1pt)

    // frame
    rect((-0.5, -0.7), (14.4, 8.6), radius: 0.8,
      stroke: (paint: black, thickness: 0.9pt), fill: none)

    // series labels
    content((0.1, 1.0), text(size: fs)[$5S_(1\/2)$], anchor: "west")
    content((0.1, 3.4), text(size: fs)[$5P_(1\/2)$], anchor: "west")
    content((0.1, 5.4), text(size: fs)[$6P_(3\/2)$], anchor: "west")
    content((0.1, 7.75), text(size: fs)[$70S_(1\/2)$], anchor: "west")
    content((0.1, 7.15), text(size: fs)[(Rydberg)], anchor: "west")

    // ---- ground hyperfine manifold ----
    lvl(5.2, 6.3, 0.6)
    lvl(5.2, 6.3, 1.4)
    content((6.55, 0.6), text(size: fs)[$|0⟩ = |F = 1, m_F = 0⟩$], anchor: "west")
    content((6.55, 1.4), text(size: fs)[$|1⟩ = |F = 2, m_F = 0⟩$], anchor: "west")
    line((4.7, 0.6), (4.7, 1.4), stroke: blk, mark: (start: ">", end: ">"))
    content((4.5, 1.0), text(size: fs)[6.8 GHz], anchor: "east")
    content((10.6, 1.0), text(size: fs)[$gamma "B"\/2 pi = 24$ MHz], anchor: "west")

    // ---- 5P1/2 manifold ----
    lvl(5.2, 6.3, 3.4)
    lvl(4.45, 4.9, 3.4, st: g)
    lvl(6.6, 7.05, 3.4, st: g)
    content((7.4, 3.4), text(size: fs)[$180$ GHz], anchor: "west")

    // ---- 6P3/2 manifold ----
    lvl(5.2, 6.3, 5.4)
    lvl(4.45, 4.9, 5.4, st: g)
    lvl(6.6, 7.05, 5.4, st: g)
    content((4.25, 5.4), text(size: fs)[$2$ GHz], anchor: "east")

    // ---- Rydberg 70S1/2 ----
    lvl(5.2, 6.3, 7.75)
    content((5.05, 7.75), text(size: fs)[$m_"j" = -1\/2$], anchor: "east")
    content((5.75, 7.35), text(size: fs)[$|r⟩$], anchor: "center")
    lvl(6.6, 7.05, 7.95, st: g)
    content((7.35, 7.95), text(size: fs)[$m_"j" = +1\/2$], anchor: "west")
    content((9.6, 7.95), text(size: fs)[$gamma "B"\/2 pi = 24$ MHz], anchor: "west")

    // ---- transitions ----
    line((5.45, 1.45), (5.45, 3.3), stroke: rd, mark: (end: ">"))
    line((5.75, 1.45), (5.75, 3.3), stroke: rd, mark: (end: ">"))
    content((6.9, 2.45), text(size: fs)[$sigma^+$ 795 nm], anchor: "west")
    line((5.6, 5.35), (5.6, 3.45), stroke: bl, mark: (end: ">"))
    content((6.9, 4.4), text(size: fs)[$sigma^-$ 420 nm], anchor: "west")
    line((6.05, 5.45), (6.35, 7.7), stroke: pu, mark: (end: ">"))
    content((7.55, 6.6), text(size: fs)[$sigma^+$ 1013 nm], anchor: "west")
  })

  #v(9pt)

  // ---------------- panel c: circuit + pulse sequence ----------------
  #cetz.canvas(length: 0.72cm, padding: (x: 0.5cm, y: 0.3cm), {
    import cetz.draw: *

    let fs = 6pt
    let blk = (paint: black, thickness: 0.8pt)
    let gry = (paint: luma(110), thickness: 0.8pt)
    let red = (paint: rgb("#c8102e"), thickness: 1.0pt)
    let cyn = rgb("#00a5e0")
    let pur = rgb("#9467bd")
    let yel = rgb("#f5d76e")
    let grn = rgb("#5aa05a")

    let gbox(x, y, txt, st, w: 1.5, h: 0.28) = {
      rect((x - w / 2, y - h), (x + w / 2, y + h), stroke: st, fill: white)
      content((x, y), text(size: fs, txt), anchor: "center")
    }
    let ctrl(x, y) = circle((x, y), radius: 0.08, fill: black, stroke: none)
    let cz(x, ya, yb) = {
      line((x, ya), (x, yb), stroke: blk)
      ctrl(x, ya)
      ctrl(x, yb)
    }
    let meas(x, y) = {
      rect((x - 0.26, y - 0.26), (x + 0.26, y + 0.26), stroke: blk, fill: white)
      arc((x, y - 0.24), start: 35deg, stop: 145deg, radius: 0.24,
        stroke: (paint: black, thickness: 0.6pt), fill: none, mark: (end: ">"))
    }
    let bar(x, y, colr, h: 0.55, w: 0.16) = {
      rect((x - w / 2, y), (x + w / 2, y + h), stroke: (paint: colr, thickness: 0.7pt), fill: colr)
    }
    let row(y, lab) = {
      line((3.1, y), (16.3, y), stroke: blk)
      content((2.95, y), text(size: fs, lab), anchor: "east")
    }

    // ---- circuit (wires y = 6.4 .. 8.8) ----
    let ys = (6.4, 7.2, 8.0, 8.8)
    for y in ys {
      line((1.6, y), (14.3, y), stroke: blk)
      content((1.45, y), text(size: fs)[$|0⟩$], anchor: "east")
      gbox(2.9, y, [$Y(pi\/2)$], gry)
      gbox(6.3, y, [$Y(pi)$], red, w: 1.1)
      gbox(10.2, y, [$Y(pi)$], red, w: 1.1)
      meas(13.7, y)
    }
    cz(4.3, 7.2, 8.0)
    cz(8.3, 6.4, 7.2)
    gbox(12.1, 8.8, [$Y(pi\/2)$], gry)
    gbox(12.1, 7.2, [$Y(pi\/2)$], gry)
    // dynamical-decoupling bracket
    line((3.4, 5.95), (3.4, 6.08), stroke: gry)
    line((3.4, 6.08), (12.9, 6.08), stroke: gry)
    line((12.9, 5.95), (12.9, 6.08), stroke: gry)
    content((8.1, 5.8), text(size: 5.5pt)[+ Dynamical decoupling], anchor: "center")

    // ---- Raman (795 nm) ----
    row(4.6, [Raman (795 nm)])
    for dx in (0.0, 0.22, 0.44, 0.66) { bar(4.3 + dx, 4.65, red.paint) }
    content((4.6, 5.45), text(size: fs)[BB1($pi\/2$)], anchor: "center")
    let rbar(x, t) = { bar(x, 4.65, red.paint); content((x + 0.08, 5.45), text(size: fs, t), anchor: "center") }
    rbar(5.9, [X])
    rbar(7.3, [Y])
    rbar(8.8, [X])
    rbar(10.4, [Y])
    rbar(11.7, [Y])
    rbar(12.9, [X])
    rbar(14.1, [Y])
    rbar(15.2, [X])
    bar(15.7, 4.65, red.paint, h: 0.4, w: 0.12)
    bar(15.95, 4.65, red.paint, h: 0.4, w: 0.12)
    content((16.0, 5.5), text(size: fs)[$pi\/4$], anchor: "west")

    // ---- Rydberg (420 nm) ----
    row(3.2, [Rydberg (420 nm)])
    for dx in (0.0, 0.22) { bar(5.0 + dx, 3.25, cyn) }
    content((5.1, 4.0), text(size: fs)[CZ], anchor: "center")
    for dx in (0.0, 0.22) { bar(9.6 + dx, 3.25, cyn) }
    content((9.7, 4.0), text(size: fs)[CZ], anchor: "center")
    for dx in (0.0, 0.22) { bar(15.1 + dx, 3.25, cyn) }
    content((15.2, 4.0), text(size: fs)[$Z(pi)$], anchor: "center")

    // ---- Rydberg (1013 nm) ----
    row(1.8, [Rydberg (1013 nm)])
    rect((3.2, 1.88), (8.7, 2.32), stroke: (paint: pur.darken(25%), thickness: 0.7pt), fill: pur.lighten(35%))

    // ---- Trap light (830 nm) ----
    row(0.4, [Trap light (830 nm)])
    rect((3.2, 0.48), (4.7, 0.92), stroke: (paint: yel.darken(35%), thickness: 0.7pt), fill: yel.lighten(30%))
    rect((5.0, 0.48), (9.1, 0.92), stroke: (paint: yel.darken(35%), thickness: 0.7pt), fill: yel.lighten(30%))
    rect((9.4, 0.48), (16.3, 0.92), stroke: (paint: yel.darken(35%), thickness: 0.7pt), fill: yel.lighten(30%))

    // ---- Movement ----
    row(-1.0, [Movement])
    rect((3.8, -0.92), (8.6, -0.48), stroke: (paint: grn.darken(30%), thickness: 0.7pt), fill: grn.lighten(25%))
    content((6.2, -0.7), text(size: fs)[Change connectivity], anchor: "center")
    rect((8.9, -0.92), (14.4, -0.48), stroke: (paint: grn.darken(30%), thickness: 0.7pt), fill: grn.lighten(25%))
    content((11.65, -0.7), text(size: 4.5pt)[Move qubits 1 and 3 out of experiment zone], anchor: "center")

    // ---- Pushout ----
    row(-2.4, [Pushout $|1 ⟩$ (780 nm)])
    rect((15.1, -2.32), (15.65, -1.85), stroke: (paint: red.paint, thickness: 0.7pt), fill: red.paint)
  })
]
