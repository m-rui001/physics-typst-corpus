#import "@preview/cetz:0.4.2": canvas
#import "@preview/cetz-plot:0.1.2": plot
#let d(name) = csv("data/" + name + ".csv", row-type: array).map(r => (float(r.at(0)), float(r.at(1))))
#canvas({
  plot.plot(size: (6, 3), xlabel: [$x$], ylabel: [$rho$], x-min: 0, x-max: 1, y-min: 0, y-max: 1.1,
    legend: "north-east", {
    plot.add(d("shocktube_1-002"), style: (stroke: black), label: [Exact])
    plot.add(d("shocktube_1-000"), style: (stroke: rgb("#0065BD")), label: [HLLC])
  })
})
