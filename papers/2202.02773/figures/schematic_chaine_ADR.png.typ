#figure(
  canvas(length: 1cm, {
    import cetz.draw: *
    set-style(stroke: (thickness: 1pt, paint: black))
    // Cryostat outline
    rect((-2.4, -4.6), (2.4, 0.2), radius: 0.15, stroke: (thickness: 1.4pt))
    content((0, 0.5), text(size: 9pt, weight: "bold")[Cryostat], anchor: "south")
    // Vacuum-flange / top plate
    rect((-2.2, -0.35), (2.2, 0.05), fill: gray.lighten(40))
    content((1.85, -0.15), text(size: 7pt)[300 K flange], anchor: "east")
    // 5 K stage
    rect((-1.8, -1.35), (1.8, -0.95), radius: 0.06, fill: rgb("#cfe2ff"))
    content((0, -1.15), text(size: 8pt)[5 K plate])
    // Pulse tube above, thermally linked to 5 K plate
    rect((-0.5, 0.35), (0.5, 1.15), radius: 0.08, fill: rgb("#f2f2f2"))
    content((0, 0.75), text(size: 7pt)[Pulse tube])
    line((0, 0.35), (0, -0.9), stroke: (thickness: 2pt, paint: copper.darken(10%)), mark: (start: "|", end: "|"))
    content((0.55, -0.35), text(size: 7pt, fill: copper.darken(10%))[thermal link]) 
    // Vertical thermal links (massless copper rods)
    line((0, -1.35), (0, -2.15), stroke: (thickness: 2.5pt, paint: copper.darken(10%)), mark: (start: "<", end: ">"))
    line((1.1, -1.35), (1.1, -2.15), stroke: (thickness: 1pt, dash: "dashed"))
    // Still stage
    rect((-1.8, -2.55), (1.8, -2.15), radius: 0.06, fill: rgb("#d9ead3"))
    content((0, -2.35), text(size: 8pt)[Still (0.8 K)])
    // Heatswitch from Still
    line((-1.3, -2.55), (-1.3, -3.35), stroke: (thickness: 2pt, paint: copper.darken(10%)), mark: (end: ">"))
    content((-1.75, -2.95), text(size: 7pt)[heat switch], anchor: "east")
    // Vertical link Still -> cold stage
    line((0.6, -2.55), (0.6, -3.35), stroke: (thickness: 2.5pt, paint: copper.darken(10%)), mark: (start: "<", end: ">"))
    // Cold stage (0.1 K)
    rect((-1.4, -3.75), (1.4, -3.35), radius: 0.06, fill: rgb("#d5f0f5"))
    content((0, -3.55), text(size: 8pt)[0.1 K stage])
    // Device at the cold stage
    rect((-0.35, -4.35), (0.35, -3.75), radius: 0.05, fill: white)
    content((0, -4.05), text(size: 7pt)[cold load])
    // Coax line entering from flange down to device
    bezier((-1.9, 0), (-2.6, 0), (-2.6, -4.05), (-0.35, -4.05),
      stroke: (thickness: 1pt, paint: blue.darken(20%)), mark: (end: ">"))
    content((-2.55, -2.2), text(size: 7pt, fill: blue.darken(20%))[coax line], angle: 90deg)
    // Heat-flow arrow alongside chain
    line((2.0, -1.0), (2.0, -3.9), stroke: (thickness: 1pt, paint: red.darken(25%)), mark: (end: "stealth"))
    content((2.3, -2.45), text(size: 7pt, fill: red.darken(25%))[heat flow], angle: 90deg)
  }),
  caption: [Overview of the 5-K to 0.1-K cryogenic chain and thermal links.],
)
