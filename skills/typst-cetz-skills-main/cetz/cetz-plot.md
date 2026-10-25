# cetz-plot — Plotting Extension

**Version:** `@preview/cetz-plot:0.1.3` (requires CeTZ >= 0.4.2)

## Import

```typst
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart
```

## Line Plots

```typst
#cetz.canvas({
  import cetz.draw: *

  plot.plot(
    size: (8, 5),
    x-label: $r$ + " (m)",
    y-label: $E$ + " (N/C)",
    x-tick-step: 1,
    y-tick-step: 100,
    {
      // From data points
      plot.add(((0.5, 400), (1, 100), (2, 25), (3, 11), (4, 6.25)))

      // From function
      plot.add(domain: (0.5, 5), x => 100 / calc.pow(x, 2),
        style: (stroke: red + 1.5pt))
    }
  )
})
```

## plot.plot Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `size` | `(1, 1)` | Plot area size as `(width, height)` |
| `x-label` | `none` | X-axis label |
| `y-label` | `none` | Y-axis label |
| `x-tick-step` | `auto` | X-axis tick interval |
| `y-tick-step` | `auto` | Y-axis tick interval |
| `x-min`, `x-max` | `auto` | X-axis range |
| `y-min`, `y-max` | `auto` | Y-axis range |
| `x-grid` | `false` | Show x grid lines |
| `y-grid` | `false` | Show y grid lines |
| `axis-style` | `"scientific"` | `"scientific"` (box), `"school-book"` (L-shaped), `"left"` |
| `legend` | `auto` | Legend position |
| `legend-style` | `(:)` | Legend styling dict |

## plot.add Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Data | — | Array of `(x, y)` tuples OR a function `x => y` |
| `domain` | `auto` | `(min, max)` for function plots |
| `samples` | `100` | Number of sample points for functions |
| `style` | `auto` | Stroke/fill styling dict |
| `label` | `none` | Legend label |
| `line` | `"line"` | `"line"`, `"spline"`, `"vh"`, `"hv"`, `"hvh"` |
| `mark` | `none` | Data point marks |
| `fill` | `false` | Fill area under curve |

## Axis Styles

```typst
// School-book style (L-shaped axes, common in physics)
plot.plot(axis-style: "school-book", ...)

// Scientific style (box around plot)
plot.plot(axis-style: "scientific", ...)

// Left-only axis
plot.plot(axis-style: "left", ...)
```

## Multiple Series

```typst
plot.plot(size: (8, 5), {
  plot.add(domain: (0, 5), x => calc.pow(x, 2),
    label: $x^2$, style: (stroke: blue))

  plot.add(domain: (0, 5), x => 2 * x + 1,
    label: $2x + 1$, style: (stroke: red + (dash: "dashed")))
})
```

## Charts

### Bar Chart

```typst
chart.barchart(
  size: (8, 5),
  (("A", 10), ("B", 25), ("C", 15)),
  label-key: 0,
  value-key: 1,
)
```

### Pie Chart

```typst
chart.piechart(
  (("Kinetic", 60), ("Potential", 30), ("Thermal", 10)),
  label-key: 0,
  value-key: 1,
  radius: 2,
)
```

## Common Physics Plot Recipes

```typst
// E(r) for point charge — 1/r² decay
plot.plot(
  size: (6, 4),
  axis-style: "school-book",
  x-label: $r$,
  y-label: $E(r)$,
  x-min: 0.3, x-max: 5,
  y-min: 0, y-max: 10,
  {
    plot.add(domain: (0.3, 5), x => 1 / calc.pow(x, 2),
      style: (stroke: blue + 1.5pt))
  }
)

// E(r) for charged sphere — linear inside, 1/r² outside
plot.plot(
  size: (6, 4),
  axis-style: "school-book",
  x-label: $r$,
  y-label: $E(r)$,
  {
    // Inside: linear
    plot.add(((0, 0), (1, 1)), style: (stroke: blue + 1.5pt))
    // Outside: 1/r²
    plot.add(domain: (1, 4), x => 1 / calc.pow(x, 2),
      style: (stroke: blue + 1.5pt))
  }
)
```
