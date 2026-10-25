# Advanced Features

## Named Elements & Anchors

### Naming Elements

Any element can be named for later reference:

```typst
circle((0, 0), radius: 1, name: "c1")
circle((3, 0), radius: 0.5, name: "c2")
line("c1", "c2")  // auto-calculates border intersection points
```

### Anchor Types

**Cardinal anchors** (on bounding box):
`north`, `south`, `east`, `west`, `north-east`, `north-west`, `south-east`, `south-west`, `center`

**Border anchors** (by angle — circles, rects):
```typst
(name: "my-circle", anchor: 45deg)   // point on border at 45°
```

**Path anchors** (by position along path — lines, beziers, arcs):
```typst
(name: "my-line", anchor: 0.0)     // start
(name: "my-line", anchor: 0.5)     // midpoint
(name: "my-line", anchor: 1.0)     // end
```

**Element-specific anchors:**
- Circle: `center` + all border/cardinal
- Arc: `arc-start`, `arc-end`, `arc-center`, `origin`, `chord-center`
- Line (closed): `centroid`
- Content: `base`, `mid`, `text`
- circle-through: `a`, `b`, `c` (the three defining points)

### Shorthand Syntax

```typst
"element.anchor"                    // e.g. "c1.north"
"group.child.anchor"                // nested: "diagram.node.east"
```

## Intersections

Find intersection points between named elements:

```typst
line((0, 0), (2, 2), name: "l1")
line((0, 2), (2, 0), name: "l2")
intersections("ix", "l1", "l2")

// Access intersection points as path anchors
circle(("ix", anchor: 0), radius: 0.1, fill: red)   // first intersection
```

Multiple intersections are indexed 0, 1, 2, etc.

## merge-path

Combine multiple path elements into a single path (for unified fill/stroke):

```typst
merge-path(close: true, fill: blue.lighten(80%), {
  line((0, 0), (2, 0))
  arc((2, 0), start: 0deg, stop: 90deg, radius: 1)
  line((2, 1), (0, 1))
})
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| `body` | — | Path elements to merge |
| `close` | `false` | Close path from end to start |
| `fill` | `none` | Fill the merged path |
| `fill-rule` | `"non-zero"` | `"non-zero"` or `"even-odd"` |

**Note:** Marks from source elements are removed by default — add marks to the merge-path itself.

## Projections (3D Planes)

Project 2D drawing commands onto 3D planes:

```typst
// Draw on the XY plane at z=0
on-xy(z: 0, {
  rect((-1, -1), (1, 1))
  circle((0, 0), radius: 0.5)
})

// Draw on the XZ plane at y=0
on-xz(y: 0, {
  grid((-2, -2), (2, 2), help-lines: true)
})

// Draw on the YZ plane at x=0
on-yz(x: 0, {
  circle((0, 0), radius: 1)
})
```

## Tree Library

Automatic hierarchical tree layout:

```typst
#import cetz.tree

#cetz.canvas({
  import cetz.draw: *
  tree.tree(
    ("root", ("A", "A1", "A2"), ("B", "B1")),
    draw-node: (node, ..) => {
      content((), node.content, frame: "rect", padding: 0.2)
    },
    draw-edge: (from, to, ..) => {
      line(from, to)
    },
    direction: "down",    // "up", "down", "left", "right"
    grow: 1.5,            // depth spacing
    spread: 2,            // sibling spacing
  )
})
```

**Automatic naming:** root = `"0"`, first child = `"0-0"`, grandchild = `"0-0-0"`, etc.

## Layers

Control draw order independently of code order:

```typst
// Elements on higher layers render on top
// Default layer is 0
set-style(..  )  // layers are managed through z-coordinates
```

Use z-coordinates for simple layering:

```typst
// Background grid (drawn first)
grid((0, 0), (4, 3), stroke: 0.3pt + gray)

// Foreground elements (drawn on top)
circle((2, 1.5), radius: 1, fill: white, stroke: black)
```
