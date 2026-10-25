// Vector (CeTZ 0.4.2) redraw of Fig. 2 panel b) of Vinuesa & Brunton,
// "Enhancing Computational Fluid Dynamics with Machine Learning" (2110.02085).
// The original raster fused this schematic with the measured vorticity data of
// panel a); panel a) stays a raster and this file supplies only the sketch.
#import "@preview/cetz:0.4.2"

#cetz.canvas(length: 0.62cm, padding: (x: 1.9cm, y: 0.9cm), {
  import cetz.draw: *
  let blue = rgb("#2f6fb0")
  let dkred = rgb("#9b2f2f")
  let orange = rgb("#e07b1a")

  // one rounded "card" holding an n x n inner grid and the two vortical blobs
  let card(cy, n) = {
    let cx = 4.0
    let w = 6.6
    let h = 6.6
    rect((cx - w/2, cy - h/2), (cx + w/2, cy + h/2), radius: 1.0,
      fill: white, stroke: (paint: blue, thickness: 6pt))
    let m = 0.7
    for i in range(n + 1) {
      let gx = -w/2 + m + i * (w - 2*m) / n
      line((cx + gx, cy - h/2 + m), (cx + gx, cy + h/2 - m), stroke: 0.7pt + black)
      let gy = -h/2 + m + i * (h - 2*m) / n
      line((cx - w/2 + m, cy + gy), (cx + w/2 - m, cy + gy), stroke: 0.7pt + black)
    }
    // blue crescent (upper-left), opening toward the lower-right
    catmull((cx + 0.3, cy + 2.2), (cx - 1.4, cy + 2.0), (cx - 2.4, cy + 0.6),
      (cx - 2.2, cy - 0.9), (cx - 1.2, cy - 1.7), (cx - 0.3, cy - 1.0),
      (cx - 1.0, cy + 0.1), (cx - 0.9, cy + 1.0), (cx + 0.2, cy + 1.5),
      (cx + 2.1, cy + 1.9),
      close: true, fill: blue, stroke: (paint: black, thickness: 1pt), z: 5)
    // orange comma (lower-right)
    catmull((cx + 2.0, cy - 0.2), (cx + 1.5, cy - 1.8), (cx + 0.1, cy - 2.3),
      (cx - 1.3, cy - 1.7), (cx - 0.4, cy - 1.5), (cx + 0.5, cy - 1.3),
      (cx + 1.1, cy - 0.3), (cx + 1.5, cy + 0.5),
      close: true, fill: orange, stroke: (paint: black, thickness: 1pt), z: 5)
  }

  content((-0.6, 16.6), anchor: "west", text(size: 15pt, weight: "bold")[b)])
  card(13.0, 5)   // fine grid (top)
  card(4.0, 3)    // coarse grid (bottom)

  // downsampling (down) / super-resolution (up) arrows between the cards
  line((1.1, 9.5), (1.1, 7.4), stroke: (paint: blue, thickness: 0.34cm),
    mark: (end: (symbol: "stealth", length: 0.55cm, width: 0.5cm, fill: blue)))
  line((6.9, 7.4), (6.9, 9.5), stroke: (paint: dkred, thickness: 0.34cm),
    mark: (end: (symbol: "stealth", length: 0.55cm, width: 0.5cm, fill: dkred)))
  content((4.0, 8.9), text(size: 10.5pt, fill: blue)[Downsampling])
  content((4.0, 7.9), text(size: 10.5pt, fill: dkred)[Super-resolution])
})
