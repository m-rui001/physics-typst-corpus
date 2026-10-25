// Definition glyphs for the diagonal Z string (dashed red line crossing the two
// upper edges of a triangle) and the off-diagonal X string (wavy teal line along
// the lower edge). Redrawn from Z_parity.png and X_parity.png.
#import "@preview/cetz:0.4.2"
#cetz.canvas(length: 0.6cm, padding: (left: 0.3cm, right: 0.3cm, top: 0.3cm, bottom: 0.6cm), {
  import cetz.draw: *

  let b = 1.6
  let h = b * calc.sin(60deg)
  let teal = rgb("#1f8ba8")
  let red = rgb("#c8102e")

  // Z glyph: triangle + horizontal dashed string across the upper two edges
  line((0.0, 0.0), (b, 0.0), (b / 2.0, h), (0.0, 0.0), stroke: (paint: black, thickness: 1.2pt))
  line((-0.35, h / 2.0), (b + 0.35, h / 2.0), stroke: (paint: red, thickness: 2.2pt, dash: "dashed"))
  content((b / 2.0, -0.35), $Z$, anchor: "north")

  // X glyph: triangle + wavy string along the lower edge
  let ox = 3.0
  line((ox, 0.0), (ox + b, 0.0), (ox + b / 2.0, h), (ox, 0.0), stroke: (paint: black, thickness: 1.2pt))
  let pts = ()
  let n = 60
  for i in range(n + 1) {
    let t = i / n
    let x = ox - 0.25 + t * (b + 0.5)
    let y = 0.0 + 0.22 * calc.sin(2 * calc.pi * 3 * t)
    pts.push((x, y))
  }
  line(..pts, stroke: (paint: teal, thickness: 2.2pt))
  content((ox + b / 2.0, -0.35), $X$, anchor: "north")
})
