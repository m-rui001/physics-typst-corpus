#figure(
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    set-style(stroke: (paint: black, thickness: 0.55pt))
    // ---- (a) three exchange-coupled macrospins ----
    let spin(x, y, col) = {
      circle((x, y), radius: 0.3, stroke: 0.8pt + col)
      line((x - 0.38, y), (x + 0.36, y), stroke: 1.2pt + col, mark: (end: "stealth"))
    }
    spin(0.75, 3.4, red)
    spin(2.0, 3.4, gray.darken(15%))
    spin(3.25, 3.4, blue)
    line((1.07, 3.4), (1.68, 3.4), stroke: (dash: "dashed"), mark: (start: "|", end: "|"))
    line((2.32, 3.4), (2.93, 3.4), stroke: (dash: "dashed"), mark: (start: "|", end: "|"))
    content((1.38, 3.56), text(size: 7pt, $J$), anchor: "south")
    content((2.62, 3.56), text(size: 7pt, $J$), anchor: "south")
    content((0.75, 2.92), text(size: 7pt, fill: red)[gain])
    content((2.0, 2.92), text(size: 7pt)[neutral])
    content((3.25, 2.92), text(size: 7pt, fill: blue)[loss])
    content((1.95, 2.52), "(a)")
    // ---- (b) gain/neutral/loss heterostructure ----
    let layer(y, col, name) = {
      rect((5.4, y), (8.3, y + 0.62), fill: col.lighten(72%))
      line((5.95, y + 0.31), (7.15, y + 0.31), stroke: 1.2pt + col, mark: (end: "stealth"))
      content((8.45, y + 0.31), text(size: 7pt, fill: col)[#name], anchor: "west")
    }
    layer(3.5, red, [Gain])
    layer(2.88, gray, [Neutral])
    layer(2.26, blue, [Loss])
    line((8.5, 4.32), (9.1, 4.32), mark: (end: "stealth"))
    content((9.2, 4.32), $hat(x)$, anchor: "west")
    content((6.85, 2.52), "(b)")
    // ---- shared legend ----
    line((5.0, 1.78), (5.35, 1.78), stroke: 0.9pt)
    content((5.45, 1.78), text(size: 7pt)[Re $omega$], anchor: "west")
    line((6.6, 1.78), (6.95, 1.78), stroke: (dash: "dashed", thickness: 0.9pt))
    content((7.05, 1.78), text(size: 7pt)[Im $omega$], anchor: "west")
    // ---- (c) eigenvalues vs alpha: macrospin ----
    line((0.5, 0.75), (4.3, 0.75), mark: (end: ">"))
    line((0.5, 0.75), (0.5, 2.35), mark: (end: ">"))
    content((4.45, 0.75), $alpha$, anchor: "west")
    content((0.35, 1.55), $omega$, anchor: "east")
    bezier((0.6, 1.95), (1.3, 1.78), (2.0, 1.56), (2.6, 1.5), stroke: 1pt + blue)
    bezier((0.6, 1.05), (1.3, 1.24), (2.0, 1.46), (2.6, 1.5), stroke: 1pt + blue)
    bezier((2.6, 1.5), (3.2, 1.72), (3.8, 1.83), (4.1, 1.9), stroke: (paint: blue, thickness: 1pt, dash: "dashed"))
    bezier((2.6, 1.5), (3.2, 1.28), (3.8, 1.17), (4.1, 1.1), stroke: (paint: blue, thickness: 1pt, dash: "dashed"))
    circle((2.6, 1.5), radius: 0.05, fill: blue, stroke: none)
    content((0.85, 2.1), text(size: 7pt)[FMR])
    content((2.6, 0.53), text(size: 7pt)[EP2])
    content((3.7, 0.53), text(size: 7pt)[EP3])
    content((2.35, 2.4), "(c)")
    // ---- (d) eigenvalues vs alpha: spin-wave ----
    line((5.2, 0.75), (9.1, 0.75), mark: (end: ">"))
    line((5.2, 0.75), (5.2, 2.35), mark: (end: ">"))
    content((9.25, 0.75), $alpha$, anchor: "west")
    bezier((5.4, 1.9), (6.2, 1.75), (7.0, 1.54), (7.8, 1.52), stroke: 1pt + blue)
    bezier((5.4, 1.15), (6.2, 1.3), (7.0, 1.5), (7.8, 1.52), stroke: 1pt + blue)
    bezier((7.8, 1.52), (8.4, 1.72), (8.85, 1.8), (9.0, 1.86), stroke: (paint: blue, thickness: 1pt, dash: "dashed"))
    bezier((7.8, 1.52), (8.4, 1.32), (8.85, 1.24), (9.0, 1.18), stroke: (paint: blue, thickness: 1pt, dash: "dashed"))
    circle((7.8, 1.52), radius: 0.05, fill: blue, stroke: none)
    line((5.4, 1.52), (8.7, 1.55), stroke: 0.9pt)
    circle((8.7, 1.55), radius: 0.05, fill: black, stroke: none)
    content((7.8, 0.53), text(size: 7pt)[EP2])
    content((8.85, 0.53), text(size: 7pt)[EP3])
    content((5.6, 2.1), text(size: 7pt)[FMR])
    content((7.1, 2.42), text(size: 7pt, $bold(k) = [pi\/30 d, 0]$))
    content((7.15, 2.62), "(d)")
    // ---- (e) splitting vs perturbation ----
    line((10.4, 0.75), (13.5, 0.75), mark: (end: ">"))
    line((10.4, 0.75), (10.4, 2.35), mark: (end: ">"))
    content((13.65, 0.75), $epsilon$, anchor: "west")
    content((10.15, 1.55), $Delta omega$, anchor: "east")
    line((10.5, 0.85), (12.5, 1.95), stroke: 0.9pt)
    bezier((10.5, 0.85), (11.0, 1.75), (11.7, 2.0), (12.5, 2.1), stroke: 0.9pt + red)
    bezier((10.5, 0.85), (10.75, 1.85), (11.2, 2.15), (12.0, 2.25), stroke: 0.9pt + blue)
    content((12.6, 1.9), text(size: 7pt)[Lin. (FMR)], anchor: "west")
    content((12.6, 2.12), text(size: 7pt, fill: red, $epsilon^(1\/2)$ (EP2)), anchor: "west")
    content((12.1, 2.3), text(size: 7pt, fill: blue, $epsilon^(1\/3)$ (EP3)), anchor: "west")
    content((11.95, 0.4), "(e)")
  }),
  caption: [
    (a) Three exchange-coupled macrospins consisting of a gain (red), neutral (gray), and (balanced-)loss (blue) spin. (b) Schematic plot of a ferromagnetic heterostructure with a gain, neutral, and loss layer, denoted by red, gray, and blue colors, respectively; all magnetizations are initially along the $x$ direction. Eigenvalues of the hybrid system versus Gilbert constant $alpha$ for (c) the macrospin version and (d) the spin-wave version at $bold(k) = [pi\/30 d, 0]$. (e) The splitting of eigenfrequencies vs the perturbation $epsilon$ follows linear, $epsilon^(1\/2)$, and $epsilon^(1\/3)$ responses, respectively, at FMR, EP2, and EP3. Source: The figures are adapted from Ref. @YuPRB2020.
  ],
)
