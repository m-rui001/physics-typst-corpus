# Marks (Arrows & Decorations)

Marks are arrow tips or symbols added to path-based elements (line, bezier, arc).

## Basic Usage

```typst
line((0, 0), (2, 0), mark: (end: ">"))                    // arrow at end
line((0, 0), (2, 0), mark: (start: "<", end: ">"))        // both ends
line((0, 0), (2, 0), mark: (end: "stealth"))               // stealth arrow
line((0, 0), (2, 0), mark: (end: "|"))                     // bar at end
```

## Built-in Mark Symbols

| Symbol | Description |
|--------|-------------|
| `">"` | Standard arrow (right/end) |
| `"<"` | Standard arrow (left/start) |
| `"\|"` | Perpendicular bar |
| `"o"` | Circle |
| `"stealth"` | Filled triangle (stealth arrow) |
| `"diamond"` | Diamond shape |
| `"triangle"` | Open triangle |
| `"square"` | Square |
| `"x"` | Cross mark |
| `"*"` | Star/asterisk |

## Mark Configuration

```typst
// Global mark style
set-style(mark: (
  length: 0.2cm,          // mark size along path
  width: 0.15cm,          // mark size perpendicular to path
  scale: 1.0,             // multiplier for length/width
  sep: 0cm,               // gap between mark and path end
  anchor: "tip",          // "tip" (default), "base", or "center"
  fill: auto,             // fill color (auto = inherit from stroke)
  stroke: auto,           // stroke style
  slant: 0,               // shear factor
  harpoon: none,          // true for half-arrow (top only)
  flip: false,            // mirror mark
  reverse: false,         // reverse direction
  transform-shape: true,  // apply element transforms to mark
))
```

## Per-Mark Styling

Override mark style on individual elements:

```typst
// Simple symbol
line((0, 0), (2, 0), mark: (end: ">"))

// Detailed config per mark
line((0, 0), (2, 0), mark: (
  end: (symbol: ">", width: 0.3cm, fill: red),
  start: (symbol: "|", length: 0.15cm),
))

// Multiple marks at same end
line((0, 0), (2, 0), mark: (end: (">" , "|")))
```

## Marks on Other Elements

```typst
// On bezier curves
bezier((0, 0), (2, 0), (1, 1), mark: (end: ">"))

// On arcs
arc((0, 0), start: 0deg, stop: 90deg, mark: (end: ">"))
```

## Common Physics Patterns

```typst
// Force vector
line((0, 0), (2, 1), stroke: red + 1.5pt, mark: (end: ">"))
content((2.3, 1.2), $arrow(F)$)

// Dimension line with bars
line((0, -0.5), (3, -0.5), mark: (start: "|", end: "|"))
content((1.5, -0.8), $d = 3 "cm"$)

// Double arrow (bidirectional)
line((0, 0), (2, 0), mark: (start: "<", end: ">"))
```
