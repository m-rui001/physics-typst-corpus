// EDFigure1 — neutral atom quantum computer architecture (native CeTZ redraw).
// Coordinates are source-image pixels via P(px, py); the canvas is 1727 x 730 px,
// i.e. 17.27 x 7.30 canvas units with y pointing up.
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 0.99cm, {
  import cetz.draw: *

  // ---- helpers -------------------------------------------------------------
  let P(px, py) = (px * 0.01, 7.30 - py * 0.01)
  let tx(body) = text(4.8pt, body)
  let txc(body) = text(4pt, body)
  let txp(body) = text(5.5pt, body)
  let tb(body) = text(6.2pt, weight: "bold", body)
  let ink = black
  let bs = (paint: ink, thickness: 0.7pt)
  let thin = (paint: ink, thickness: 0.55pt)
  let beam = rgb("#ad1c21")
  let bsbeam = (paint: beam, thickness: 0.9pt)
  let bluish = rgb("#2173b8")
  let bsblue = (paint: bluish, thickness: 1.1pt)
  let purple = rgb("#8c339e")
  let cyan = rgb("#007aad")
  let orange = rgb("#c77008")
  let red = rgb("#cc1a1f")
  let glass = rgb("#cce1f2")
  let ent = rgb("#d9eefa")
  let ro = rgb("#fad6d1")
  let ctrl = (paint: luma(120), thickness: 0.55pt)
  let mk(sym, col) = (symbol: sym, fill: col, length: 0.11cm, width: 0.075cm)
  let ah = mk("stealth", ink)
  let ahbeam = mk("stealth", beam)
  let ahblue = mk("stealth", bluish)

  // polarising beam splitter: light-blue square with a diagonal
  let pbs(cx, cy, s) = {
    rect(P(cx - s / 2, cy - s / 2), P(cx + s / 2, cy + s / 2), fill: glass, stroke: bs)
    line(P(cx - s / 2, cy + s / 2), P(cx + s / 2, cy - s / 2), stroke: thin)
  }
  // dichroic: thick blue diagonal
  let dichroic(x0, y0, x1, y1) = line(P(x0, y0), P(x1, y1), stroke: bsblue)
  // objective: rectangle with two chamfered corners (ch > 0: top, ch < 0: bottom)
  let objective(x0, y0, x1, y1, ch) = {
    let c = 0.09
    let xa = x0 * 0.01
    let xb = x1 * 0.01
    let yb = 7.30 - y0 * 0.01
    let ya = 7.30 - y1 * 0.01
    if ch > 0 {
      line((xa + c, yb), (xb - c, yb), (xb, yb - c), (xb, ya), (xa, ya), (xa, yb - c),
        close: true, fill: none, stroke: bs)
    } else {
      line((xa, yb), (xb, yb), (xb, ya + c), (xb - c, ya), (xa + c, ya), (xa, ya + c),
        close: true, fill: none, stroke: bs)
    }
  }
  // three parallel beam lines, optionally with an arrow head pointing left at ax
  let tribeam(x0, y0, x1, ax: 0) = {
    for d in (-1, 0, 1) {
      line(P(x0, y0 + d * 3), P(x1, y0 + d * 3), stroke: bsbeam)
    }
    if ax > 0 {
      line(P(ax - 11, y0), P(ax, y0), stroke: bsbeam, mark: (end: ahbeam))
    }
  }
  // double-headed dimension arrow
  let dim(x0, y0, x1, y1) = line(P(x0, y0), P(x1, y1), stroke: bs, mark: (start: ah, end: ah))
  // miniature dimension arrow (site spacings)
  let ahs = (symbol: "stealth", fill: ink, length: 0.05cm, width: 0.035cm)
  let dims(x0, y0, x1, y1) = line(P(x0, y0), P(x1, y1),
    stroke: (paint: ink, thickness: 0.5pt), mark: (start: ahs, end: ahs))
  // small filled dot (tweezer site)
  let dot(px, py) = circle(P(px, py), radius: 0.016, fill: ink, stroke: none)

  // ==========================================================================
  // panel a — optical layout
  // ==========================================================================
  content(P(11, 0), anchor: "north-west", tb([a]))

  // FPGA and camera
  rect(P(192, 27), P(242, 76), stroke: bs, fill: none)
  rect(P(205, 39), P(229, 63), stroke: thin, fill: luma(225))
  for i in range(4) {
    line(P(200, 43 + i * 6), P(205, 43 + i * 6), stroke: thin)
    line(P(229, 43 + i * 6), P(234, 43 + i * 6), stroke: thin)
    line(P(209 + i * 6, 39), P(209 + i * 6, 34), stroke: thin)
    line(P(209 + i * 6, 63), P(209 + i * 6, 68), stroke: thin)
  }
  content(P(198, 80), anchor: "north-west", tx([FPGA]))
  line(P(242, 53), P(299, 53), stroke: bs)
  rect(P(299, 26), P(351, 75), stroke: bs, fill: none)
  content(P(359, 29), anchor: "north-west", tx([CMOS#linebreak()camera]))
  line(P(312, 92), P(340, 92), P(326, 74), close: true, stroke: bs, fill: none)
  line(P(326, 120), P(326, 97), stroke: bsbeam, mark: (end: ahbeam))
  objective(306, 123, 345, 175, -1)
  content(P(233, 118), anchor: "north-west", tx([Imaging#linebreak()objective]))

  // vacuum chamber
  rect(P(197, 182), P(419, 238), fill: glass, stroke: bs)
  content(P(207, 188), anchor: "north-west", tx([Vacuum#linebreak()chamber]))
  for i in range(3) { for j in range(3) { dot(316 + i * 4, 200 + j * 4) } }
  content(P(338, 195), anchor: "north-west", tx([Atoms]))
  line(P(74, 211), P(192, 211), stroke: bsblue, mark: (end: ahblue))
  content(P(74, 149), anchor: "north-west", tx([420-nm#linebreak()Rydberg beam]))

  // Rydberg and Raman beams entering from the top
  content(P(389, 86), anchor: "north-west", tx([1013-nm#linebreak()Rydberg beam]))
  line(P(460, 128), P(460, 200), stroke: bsbeam, mark: (end: ahbeam))
  dichroic(446, 226, 474, 196)
  content(P(429, 228), anchor: "north-west", tx([Dichroic]))
  pbs(537, 211, 21)
  content(P(522, 230), anchor: "north-west", tx([PBS]))
  content(P(526, 62), anchor: "north-west", tx([Local#linebreak()imaging#linebreak()beam]))
  line(P(537, 102), P(537, 198), stroke: bsbeam, mark: (end: ahbeam))
  line(P(578, 211), P(487, 211), stroke: bsbeam, mark: (end: ahbeam))
  line(P(474, 211), P(424, 211), stroke: bsbeam, mark: (end: ahbeam))
  content(P(586, 178), anchor: "north-west", tx([Global#linebreak()Raman#linebreak()beam]))

  // trapping path
  objective(306, 245, 346, 297, 1)
  content(P(231, 254), anchor: "north-west", tx([Trapping#linebreak()objective]))
  line(P(327, 432), P(327, 252), stroke: bsbeam, mark: (end: ahbeam))
  content(P(79, 284), anchor: "north-west", tx([2D local#linebreak()Raman AOD]))
  rect(P(78, 332), P(125, 356), stroke: bs, fill: none)
  rect(P(100, 356), P(122, 380), stroke: bs, fill: none)
  tribeam(125, 340, 326, ax: 245)
  dichroic(313, 356, 342, 327)
  content(P(353, 311), anchor: "north-west", tx([Dichroic]))
  pbs(327, 385, 21)
  content(P(275, 374), anchor: "north-west", tx([PBS]))
  tribeam(338, 385, 440)
  rect(P(426, 361), P(461, 408), stroke: bs, fill: none)
  rect(P(435, 377), P(450, 392), fill: ink, stroke: bs)
  content(P(468, 374), anchor: "north-west", tx([Static SLM traps]))
  rect(P(295, 434), P(342, 457), stroke: bs, fill: none)
  rect(P(317, 457), P(342, 480), stroke: bs, fill: none)
  content(P(350, 451), anchor: "north-west", tx([2D Moving AOD traps]))

  // classical control lines
  line(P(192, 50), P(45, 50), P(45, 618), stroke: ctrl)
  line(P(192, 56), P(51, 56), P(51, 612), stroke: ctrl)
  line(P(87, 380), P(87, 618), stroke: ctrl)
  line(P(113, 380), P(113, 618), stroke: ctrl)
  line(P(305, 480), P(305, 618), stroke: ctrl)
  line(P(329, 480), P(329, 592), stroke: ctrl)

  // ==========================================================================
  // panel b — 87Rb level structure
  // ==========================================================================
  content(P(631, 0), anchor: "north-west", tb([b]))
  rect(P(664, 26), P(943, 518), stroke: bs, fill: none)
  for y in (53, 159, 265, 342, 426, 489) {
    line(P(757, y), P(805, y), stroke: (paint: ink, thickness: 1.3pt))
  }
  for y in (182, 320) {
    line(P(757, y), P(805, y), stroke: (paint: luma(120), thickness: 1pt, dash: "dashed"))
  }
  content(P(690, 41), anchor: "north-west", txp[$"53"S _"1/2"$])
  content(P(697, 138), anchor: "north-west", txp[$"6"P _"3/2"$])
  content(P(695, 246), anchor: "north-west", txp[$"5"P _"3/2"$])
  content(P(696, 322), anchor: "north-west", txp[$"5"P _"1/2"$])
  content(P(697, 411), anchor: "north-west", txp[$"5"S _"1/2"$])
  content(P(724, 446), anchor: "north-west", txc([6.8 GHz]))
  content(P(819, 43), anchor: "north-west", txp[$| r ⟩$])
  content(P(844, 32), anchor: "north-west", txp([Rydberg#linebreak()state]))
  content(P(818, 418), anchor: "north-west", txp[$| 1 ⟩$])
  content(P(817, 481), anchor: "north-west", txp[$| 0 ⟩$])
  content(P(849, 417), anchor: "north-west", txp([Hyperfine#linebreak()qubit#linebreak()$T _2 > 1$ s]))
  // transitions
  let trans(x0, y0, x1, y1, col) = line(P(x0, y0), P(x1, y1),
    stroke: (paint: col, thickness: 1pt),
    mark: (start: mk("stealth", col), end: mk("stealth", col)))
  trans(764, 57, 764, 178, purple)
  content(P(774, 84), anchor: "north-west", text(5.5pt, fill: purple)[Rydberg#linebreak()1013 nm])
  trans(764, 186, 764, 422, cyan)
  content(P(775, 198), anchor: "north-west", text(5.5pt, fill: cyan)[Rydberg#linebreak()420 nm])
  trans(780, 268, 780, 422, orange)
  content(P(792, 270), anchor: "north-west", text(5.5pt, fill: orange)[Local imaging#linebreak()780 nm])
  trans(796, 486, 791, 292, red)
  content(P(808, 352), anchor: "north-west", text(5.5pt, fill: red)[Raman#linebreak()795 nm])
  trans(772, 424, 772, 491, ink)

  // ==========================================================================
  // panel c — control infrastructure
  // ==========================================================================
  content(P(9, 512), anchor: "north-west", tb([c]))
  rect(P(26, 517), P(943, 706), fill: luma(232),
    stroke: (paint: luma(90), thickness: 0.7pt, dash: "dashed"))
  let aom(x0, y0, x1, y1, lab) = {
    rect(P(x0, y0), P(x1, y1), stroke: bs, fill: none)
    content(P((x0 + x1) / 2, (y0 + y1) / 2), tx(lab))
  }
  aom(420, 536, 482, 588, [Global#linebreak()AOM])
  aom(486, 536, 544, 588, [Local#linebreak()AOM])
  aom(550, 536, 621, 588, [6.8 GHz#linebreak()signal])
  aom(633, 536, 711, 588, [420-nm#linebreak()AOM])
  aom(719, 536, 799, 588, [1013-nm#linebreak()AOM])
  rect(P(269, 566), P(373, 591), stroke: bs, fill: none)
  content(P(296, 567), anchor: "north-west", tx([switch]))
  let awg(x0, x1, lab) = {
    rect(P(x0, 620), P(x1, 653), stroke: bs, fill: none)
    content(P((x0 + x1) / 2, 657), anchor: "north", tx(lab))
  }
  awg(49, 194, [Raman AOD AWG])
  awg(226, 315, [Rearrangement#linebreak()AWG (FIFO)])
  awg(332, 425, [Moving AWG])
  awg(451, 588, [Raman AWG])
  awg(624, 907, [Rydberg AWG#linebreak()& TTL generator])
  let up(x) = line(P(x, 620), P(x, 592), stroke: bs, mark: (end: ah))
  up(461)
  up(513)
  up(576)
  up(672)
  up(759)
  up(824)
  up(881)
  content(P(810, 540), anchor: "north-west", tx([AOD#linebreak()traps]))
  content(P(865, 540), anchor: "north-west", tx([SLM#linebreak()traps]))
  content(P(829, 595), anchor: "north-west", txc([TTL]))
  content(P(887, 595), anchor: "north-west", txc([TTL]))
  line(P(252, 592), P(252, 620), stroke: ctrl)
  line(P(265, 592), P(265, 620), stroke: ctrl)
  line(P(355, 592), P(355, 620), stroke: ctrl)
  line(P(368, 592), P(368, 620), stroke: ctrl)
  content(P(74, 524), anchor: "north-west", txc([x]))
  content(P(118, 523), anchor: "north-west", txc([y]))
  content(P(292, 524), anchor: "north-west", txc([x]))
  content(P(337, 523), anchor: "north-west", txc([y]))

  // ==========================================================================
  // panel d — array layout
  // ==========================================================================
  content(P(983, 0), anchor: "north-west", tb([d]))
  rect(P(1052, 67), P(1707, 165), fill: ent, stroke: (paint: ink, thickness: 1.1pt))
  rect(P(1052, 230), P(1707, 508), fill: none, stroke: (paint: ink, thickness: 1.1pt))
  rect(P(1052, 566), P(1707, 648), fill: ro, stroke: (paint: ink, thickness: 1.1pt))
  content(P(1065, 47), anchor: "north-west", tx([Entangling zone]))
  content(P(1066, 204), anchor: "north-west", tx([Storage zone]))
  content(P(1067, 537), anchor: "north-west", tx([Readout zone]))
  content(P(1396, 49), anchor: "north-west", txc([80 total parallel gate sites (up to 160 qubits in parallel)]))
  // entangling zone: 20 gate sites (atom pairs), 4 rows
  for i in range(20) { for j in range(4) {
    dot(1060 + i * 33.47, 75 + j * 27.3)
    dot(1066 + i * 33.47, 75 + j * 27.3)
  } }
  // storage zone lattice: 39 x 16 sites
  for i in range(39) { for j in range(16) { dot(1060 + i * 16.79, 237 + j * 17.47) } }
  // readout zone lattice: 39 x 4 sites
  for i in range(39) { for j in range(4) { dot(1060 + i * 16.79, 581 + j * 17.4) } }
  // dimension arrows
  let vspan(y0, y1, lab) = {
    dim(1035, y0, 1035, y1)
    content(P(972, (y0 + y1) / 2 - 8), anchor: "north-west", tx(lab))
  }
  vspan(67, 165, [35 um])
  vspan(165, 230, [20 um])
  vspan(230, 508, [100 um])
  vspan(508, 566, [20 um])
  vspan(566, 648, [30 um])
  dim(1052, 665, 1707, 665)
  content(P(1351, 670), anchor: "north-west", tx([230 um]))
  content(P(1388, 79), anchor: "north-west", tx([2 um]))
  content(P(1467, 79), anchor: "north-west", tx([10 um]))
  dims(1465, 97, 1500, 97)
  content(P(1468, 203), anchor: "north-west", txc([2-6 um]))
  dims(1480, 217, 1498, 217)

  // keep the wide labels inside the bounding box
  rect(P(0, 0), P(1727, 730), stroke: none, fill: none)
})
