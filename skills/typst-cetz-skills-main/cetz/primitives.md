# Draw Primitives

All functions are called inside `cetz.canvas({ import cetz.draw: * ... })`.

## line

Draw straight line segments through points.

```typst
line((0, 0), (2, 1))                          // simple line
line((0, 0), (1, 1), (2, 0))                  // polyline
line((0, 0), (1, 1), (2, 0), close: true)     // closed polygon
line((0, 0), (2, 0), mark: (end: ">"))        // with arrow
line("circle-a", "circle-b")                  // between named elements (auto border intersection)
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| `..pts` | — | Two or more coordinates |
| `close` | `false` | Close path (connect last point to first) |
| `name` | `none` | Element name for referencing |
| `mark` | `none` | Arrow marks (see marks.md) |

**Anchors:** Path anchors (0.0–1.0 along path). Closed polygons also have `"centroid"`.

## circle

Draw circles or ellipses.

```typst
circle((0, 0), radius: 1)                     // circle at origin
circle((0, 0), radius: (1.5, 0.8))            // ellipse
circle((0, 0), (1, 1))                        // radius = distance between points
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| Position | — | Center coordinate (or two points for distance-based radius) |
| `radius` | `1` | Number (circle) or `(rx, ry)` tuple (ellipse) |
| `name` | `none` | Element name |
| `anchor` | `"center"` | Default anchor |

**Anchors:** `center`, `north`, `south`, `east`, `west`, diagonal, border (by angle), path.

```typst
// Circle through 3 points
circle-through((0, 0), (1, 0), (0.5, 1))
// Anchors: a, b, c (the three points) + standard circle anchors
```

## arc

Draw circular or elliptical arc segments.

```typst
arc((0, 0), start: 0deg, stop: 90deg, radius: 1)
arc((0, 0), start: 0deg, delta: 45deg, radius: 1)         // angle difference
arc((0, 0), start: 0deg, stop: 180deg, radius: (1, 0.5))  // elliptical
arc((0, 0), start: 0deg, stop: 270deg, mode: "PIE")       // sector
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| Position | — | Arc origin |
| `start` | — | Start angle |
| `stop` | — | End angle (specify `stop` OR `delta`, not both) |
| `delta` | — | Angle sweep |
| `radius` | `1` | Radius or `(rx, ry)` for elliptical |
| `mode` | `"OPEN"` | `"OPEN"` (arc), `"CLOSE"` (chord), `"PIE"` (sector) |
| `name` | `none` | Element name |

**Anchors:** `arc-start`, `arc-end`, `arc-center`, `origin`, `chord-center`.

```typst
// Arc through 3 points
arc-through((0, 0), (1, 1), (2, 0))
```

## rect

Draw rectangles.

```typst
rect((0, 0), (2, 1))                                      // by corners
rect((0, 0), (rel: (2, 1)))                                // relative corner
rect((0, 0), (2, 1), radius: 0.1)                          // rounded corners
rect((0, 0), (2, 1), radius: (north-west: 0.2, rest: 0))  // per-corner rounding
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| `a`, `b` | — | Bottom-left and top-right corners |
| `radius` | `0` | Corner rounding. Number, or dict: `north-west`, `north-east`, `south-west`, `south-east`, `rest` |
| `name` | `none` | Element name |
| `anchor` | `"center"` | Default anchor |

## content

Place Typst content (text, math, markup) at a canvas coordinate.

```typst
content((0, 0), "Hello")                              // centered text
content((0, 0), $arrow(F)$)                            // math
content((0, 0), [*Bold* _italic_])                     // markup
content((0, 0), "Label", anchor: "south")              // text above the point
content((0, 0), "Rotated", angle: 45deg)               // rotated text
content((0, 0), "Framed", frame: "rect", padding: 0.1) // framed text
content((-1, -1), (1, 1), [Large box])                 // text inside rectangle area
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| Position | — | One coord (place at point) or two (fill rectangle) |
| Body | — | Typst content to render |
| `anchor` | `"center"` | Which part of content aligns to the coordinate |
| `angle` | `0deg` | Rotation angle. Can be a coordinate to point toward |
| `frame` | `none` | `"rect"`, `"circle"`, or `none` |
| `padding` | `none` | Spacing inside frame |
| `name` | `none` | Element name |

**Anchors:** Border + `base`, `mid`, `text` anchors.

## bezier

Draw bezier curves with control points.

```typst
bezier((0, 0), (2, 0), (1, 1))                // quadratic (1 control point)
bezier((0, 0), (2, 0), (0.5, 1), (1.5, 1))    // cubic (2 control points)
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| Args | — | Start, end, 1 or 2 control points |
| `mark` | `none` | Arrow marks |
| `name` | `none` | Element name |

## polygon

Draw regular polygons.

```typst
polygon((0, 0), sides: 3)                     // triangle
polygon((0, 0), sides: 6, radius: 1.5)        // hexagon
polygon((0, 0), sides: 4, angle: 45deg)       // rotated square (diamond)
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| `origin` | — | Center coordinate |
| `sides` | — | Number of sides (>= 3) |
| `radius` | `1` | Distance from center to vertex |
| `angle` | `0deg` | Rotation around origin |

## grid

Draw coordinate grids.

```typst
grid((0, 0), (4, 3))                          // default 1-unit grid
grid((0, 0), (4, 3), step: 0.5)               // finer grid
grid((0, 0), (4, 3), help-lines: true)         // thin gray grid lines
```
