# Transformations

Transformations modify the coordinate system for subsequent draw commands. They are cumulative and persist until the canvas ends or they are scoped inside a `group()`.

## translate

Move the origin:

```typst
translate((2, 1))         // shift right 2, up 1
translate((x: 2))         // shift right only
translate((y: -1))        // shift down only
```

## rotate

Rotate the coordinate system:

```typst
rotate(45deg)                             // around z-axis (2D rotation)
rotate((z: 45deg))                        // explicit z-axis
rotate((x: 30deg, y: 45deg, z: 60deg))   // 3D rotations
```

## scale

Scale the coordinate system:

```typst
scale(2)                  // uniform scale
scale((x: 2, y: 0.5))    // non-uniform scale
scale(x: -1)              // mirror horizontally
```

## group — Scoping Transforms

**Critical:** Without `group()`, transforms affect ALL subsequent draws. Always scope transforms:

```typst
// BAD — rotation affects everything after
rotate(45deg)
line((0, 0), (1, 0))    // rotated
circle((2, 0))           // also rotated!

// GOOD — rotation scoped to group
group({
  rotate(45deg)
  line((0, 0), (1, 0))  // rotated
})
circle((2, 0))           // NOT rotated
```

### group Parameters

```typst
group(name: "my-group", anchor: "center", {
  // draw commands
})
```

| Parameter | Default | Description |
|-----------|---------|-------------|
| `name` | `none` | Name for referencing the group and its children |
| `anchor` | `none` | Which anchor of the group aligns to the placement point |

### Accessing Group Children

Named elements inside groups are accessible via dot notation:

```typst
group(name: "diagram", {
  circle((0, 0), radius: 0.5, name: "node")
  content((0, 0), "A")
})

// Reference child anchor
line("diagram.node.east", (3, 0))
```

## Common Patterns

### Repeated Element at Different Positions

```typst
// Draw the same shape at multiple locations
for pos in ((0, 0), (3, 0), (6, 0)) {
  group({
    translate(pos)
    circle((0, 0), radius: 0.5, fill: blue)
    content((0, 0), "+", fill: white)
  })
}
```

### Rotated Labels

```typst
// Label along a diagonal line
group({
  translate((1, 1))
  rotate(45deg)
  content((0, 0.3), $d = 5 "cm"$)
})
```

### Mirror / Symmetry

```typst
// Draw one half, mirror for the other
group({
  line((0, 0), (2, 1))
  circle((2, 1), radius: 0.2)
})
group({
  scale(x: -1)  // mirror horizontally
  line((0, 0), (2, 1))
  circle((2, 1), radius: 0.2)
})
```
