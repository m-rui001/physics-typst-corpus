---
name: cetz
description: CeTZ drawing package for Typst — canvas API, draw primitives, coordinates, marks, styling, and transforms. Use when working with CeTZ diagrams, technical drawings, or physics figures in Typst projects.
user-invocable: false
---

# CeTZ — ein Typst Zeichenpaket

**Version:** `@preview/cetz:0.4.2`
**Related:** `@preview/cetz-plot:0.1.3` (plotting extension)

CeTZ is the foundational drawing library for Typst, inspired by TikZ and Processing. It provides a canvas-based, procedural API for vector graphics.

## Quick Start

```typst
#import "@preview/cetz:0.4.2"

#cetz.canvas({
  import cetz.draw: *
  line((0, 0), (2, 1), mark: (end: ">"))
  circle((2, 1), radius: 0.2, fill: blue)
  content((2, 1.5), $P$)
})
```

**Critical:** Always `import cetz.draw: *` INSIDE the canvas block. Draw functions shadow Typst builtins (`line`, `circle`, `rect`, `content`). Importing at the top level breaks your document.

## Routing Table

Read the relevant file based on what you need:

| Need | File |
|------|------|
| Canvas setup, coordinate systems | [canvas.md](canvas.md) |
| Drawing shapes (line, circle, arc, rect, content, bezier, polygon) | [primitives.md](primitives.md) |
| Arrow tips and marks | [marks.md](marks.md) |
| Colors, strokes, fills, set-style | [styling.md](styling.md) |
| Translate, rotate, scale, groups | [transforms.md](transforms.md) |
| Intersections, merge-path, anchors, tree, projections | [advanced.md](advanced.md) |
| Function plots, axes, charts (cetz-plot) | [cetz-plot.md](cetz-plot.md) |

## Top 5 Gotchas

1. **Import inside canvas** — `import cetz.draw: *` must be inside `cetz.canvas({ ... })`, never at file top level. It shadows `line`, `circle`, `rect`, `content`.

2. **Coordinate units** — 1 unit = `length` parameter of canvas (default `1cm`). Use `canvas(length: 1cm, { ... })` to control.

3. **Transforms persist** — `rotate(45deg)` affects ALL subsequent draws. Scope transforms with `group({ ... })`.

4. **Style merging** — `set-style(stroke: (paint: blue))` MERGES with existing stroke style (keeps previous thickness). It does not replace.

5. **Z-layering** — Higher z-coordinates render on top. Use for controlling draw order.

## Examples

| File | Description |
|------|-------------|
| [charge-triangle.typ](examples/charge-triangle.typ) | Equilateral triangle with labeled point charges |
| [spring-sphere.typ](examples/spring-sphere.typ) | Vertical spring with hanging charged sphere |
| [field-lines.typ](examples/field-lines.typ) | Radial electric field lines from point charge |
| [axes-with-vectors.typ](examples/axes-with-vectors.typ) | Cartesian axes with force/field vectors |
| [function-plot.typ](examples/function-plot.typ) | E(r) function plot with cetz-plot |
