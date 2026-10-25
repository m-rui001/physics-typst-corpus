# Styling

## Inline Styling

All elements accept `stroke` and `fill` directly:

```typst
circle((0, 0), radius: 1, stroke: red, fill: blue.lighten(80%))
line((0, 0), (2, 0), stroke: 2pt + red)
rect((0, 0), (2, 1), stroke: (paint: green, thickness: 1pt, dash: "dashed"))
```

### Stroke Options

```typst
// Simple
stroke: red                          // color only
stroke: 2pt                          // thickness only
stroke: 2pt + red                    // thickness + color
stroke: none                         // no stroke

// Full dictionary
stroke: (
  paint: red,                        // color
  thickness: 1pt,                    // line width
  cap: "round",                      // "butt", "round", "square"
  join: "round",                     // "miter", "round", "bevel"
  dash: "dashed",                    // "solid", "dotted", "dashed", "dash-dotted", or custom array
  miter-limit: 4,                    // miter join limit
)

// Custom dash pattern
stroke: (dash: ((2pt, 1pt, 0.5pt, 1pt)))  // dash-gap-dash-gap pattern
```

### Fill Options

```typst
fill: blue
fill: blue.lighten(50%)
fill: color.mix((green, 20%), white)
fill: gradient.linear(red, blue)           // gradient fill
fill: none                                 // no fill (default)
```

## set-style (Global Defaults)

Apply default styles for all subsequent elements:

```typst
// Global stroke
set-style(stroke: (paint: red, thickness: 2pt))

// Global fill
set-style(fill: blue.lighten(80%))

// Per element type
set-style(circle: (stroke: green, fill: yellow))
set-style(line: (stroke: 1pt + gray))
set-style(content: (frame: "rect", padding: 0.1))
```

### Style Hierarchy

Priority (highest to lowest):
1. **Function parameters** — `circle((0,0), stroke: red)` always wins
2. **Element-type style** — `set-style(circle: (stroke: green))`
3. **Global style** — `set-style(stroke: blue)`

### Style Merging (Important!)

`set-style` MERGES dictionaries, it does NOT replace:

```typst
set-style(stroke: (paint: red, thickness: 2pt))
set-style(stroke: (paint: blue))
// Result: stroke is (paint: blue, thickness: 2pt) — thickness preserved!
```

To fully reset a style, set it to a simple value:

```typst
set-style(stroke: blue)  // replaces entire stroke with just color
```

## Fill Rule

For self-intersecting paths:

```typst
// "non-zero" (default) — standard winding rule
// "even-odd" — alternating fill for overlapping regions
merge-path(fill-rule: "even-odd", { ... })
```

## Common Style Recipes

```typst
// Thin construction line
set-style(line: (stroke: 0.3pt + gray))

// Physics diagram defaults
set-style(
  stroke: 0.7pt + black,
  mark: (end: ">", length: 0.15cm),
  content: (padding: 0.05),
)

// Dashed auxiliary line
line((0, 0), (2, 2), stroke: (dash: "dashed", paint: gray))

// Highlighted region
rect((0, 0), (2, 1), fill: yellow.lighten(80%), stroke: orange)
```
