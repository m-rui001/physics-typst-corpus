# Canvas API & Coordinate Systems

## Canvas Function

```typst
#cetz.canvas({
  import cetz.draw: *
  // draw commands
})
```

### Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `body` | — | Code block with draw commands |
| `length` | `1cm` | What 1 coordinate unit equals. Can be a length (`1cm`, `0.5em`) or ratio (`50%`) |
| `debug` | `false` | Show bounding boxes of each element |
| `background` | `none` | Canvas background color |
| `padding` | `none` | Spacing around canvas (number or dict with `top`, `bottom`, `left`, `right`) |
| `baseline` | `none` | Coordinate for baseline alignment (makes canvas behave like inline box) |

### Sizing

Canvas auto-sizes to fit all drawn elements — no explicit width/height needed.

```typst
// Canvas where 1 unit = 0.5cm (smaller drawings)
#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *
  circle((0, 0), radius: 2)  // 1cm actual radius
})

// Inline canvas aligned to text baseline
#cetz.canvas(baseline: (0, 0), length: 0.8em, {
  import cetz.draw: *
  circle((0, 0), radius: 0.5, fill: red)
})
```

## Coordinate Systems

### Cartesian (most common)

```typst
(x, y)          // 2D
(x, y, z)       // 3D
(1cm, 2mm)      // mixed units (converted to canvas units)
```

### Polar

```typst
(angle, radius)           // e.g. (30deg, 2)
(angle, (rx, ry))         // elliptical radius
```

### Relative

Position relative to previous coordinate:

```typst
(rel: (dx, dy))           // relative cartesian
(rel: (angle, dist))      // relative polar
(rel: (1, 0), to: (2, 3)) // relative to specific point
```

### Anchor References

Reference named elements and their anchors:

```typst
"element-name"               // default anchor (usually center)
"element-name.north"         // cardinal anchors: north, south, east, west
"element-name.north-east"    // diagonal anchors
(name: "circle", anchor: 45deg)  // border anchor at angle
(name: "line", anchor: 0.5)      // path anchor: 50% along path
"group.child.south"          // nested anchors
```

### Interpolation

Linear interpolation between two coordinates:

```typst
(a, 50%, b)               // midpoint of a and b
(a, 25%, b)               // 25% from a toward b
((0,0), 0.5, (2,2), angle: 90deg)  // with rotation
```

### Perpendicular

Intersection of horizontal/vertical lines through two points:

```typst
(a, "-|", b)    // horizontal from a, vertical from b
(a, "|-", b)    // vertical from a, horizontal from b
```

### Projection

Project a point onto a line segment:

```typst
((point), "->", (line-start), (line-end))
```

### Barycentric

Weighted combination of named coordinates:

```typst
(bary: (a: 1, b: 2, c: 1))  // weighted average of named anchors
```
