// E(r) plot for a uniformly charged sphere using cetz-plot
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let R = 2  // sphere radius in arbitrary units

  plot.plot(
    size: (8, 5),
    axis-style: "school-book",
    x-label: $r$,
    y-label: $E(r)$,
    x-min: 0,
    x-max: 6,
    y-min: 0,
    y-max: 1.2,
    x-tick-step: 1,
    y-tick-step: 0.5,
    {
      // Inside sphere: E proportional to r
      plot.add(
        domain: (0, R),
        x => x / R,
        style: (stroke: blue + 1.5pt),
        label: "Inside ($r < R$)",
      )

      // Outside sphere: E proportional to 1/r²
      plot.add(
        domain: (R, 6),
        x => calc.pow(R, 2) / calc.pow(x, 2),
        style: (stroke: red + 1.5pt),
        label: "Outside ($r > R$)",
      )
    },
  )

  // Mark R on x-axis
  content((2.8, -0.8), $R$)
})
