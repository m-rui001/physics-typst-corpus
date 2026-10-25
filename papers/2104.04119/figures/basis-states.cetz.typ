// Four basis states of a fully-blockaded triangle (0 or 1 Rydberg excitation
// on one of the three links). Redrawn from triangle_qubits-02.png.
#import "@preview/cetz:0.4.2"
#cetz.canvas(length: 0.55cm, padding: (left: 0.2cm, right: 0.2cm, top: 0.2cm, bottom: 0.6cm), {
  import cetz.draw: *

  let b = 1.6
  let h = b * calc.sin(60deg)

  let tri(x, hi, name) = {
    let v0 = (x, 0.0)
    let v1 = (x + b, 0.0)
    let v2 = (x + b / 2.0, h)
    line(v0, v1, v2, v0, stroke: (paint: black, thickness: 1.2pt))
    if hi == "bottom" {
      line(v0, v1, stroke: (paint: rgb("#c8102e"), thickness: 3.0pt))
    } else if hi == "left" {
      line(v0, v2, stroke: (paint: rgb("#c8102e"), thickness: 3.0pt))
    } else if hi == "right" {
      line(v1, v2, stroke: (paint: rgb("#c8102e"), thickness: 3.0pt))
    }
    content((x + b / 2.0, -0.35), name, anchor: "north")
  }

  tri(0.0, "none", $T_0$)
  tri(2.3, "bottom", $T_1$)
  tri(4.6, "left", $T_2$)
  tri(6.9, "right", $T_3$)
})
