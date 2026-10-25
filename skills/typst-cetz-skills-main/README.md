# typst-cetz-skills

Claude Code skill for the [CeTZ](https://github.com/cetz-package/cetz) Typst drawing package.

Packages distilled reference and examples for CeTZ 0.4.2 and cetz-plot 0.1.3, so Claude can draw diagrams without re-fetching documentation.

## Install

```bash
# via Agent Skills
npx skills add edoardob90/typst-cetz-skills

# or manually:
git clone https://github.com/edoardob90/typst-cetz-skills && cd typst-cetz-skills
mkdir -p ~/.claude/skills

# option 1: full copy
cp -r cetz ~/.claude/skills/

# option 2: sym-link the directory
ln -s $(pwd)/cetz ~/.claude/skills/cetz
```

## Structure

- `cetz/SKILL.md` — entry point with quick start and routing table
- `cetz/canvas.md` — canvas API and coordinate systems
- `cetz/primitives.md` — draw primitives (line, circle, arc, rect, content, bezier, polygon, grid)
- `cetz/marks.md` — arrow marks and symbols
- `cetz/styling.md` — stroke, fill, set-style, style hierarchy
- `cetz/transforms.md` — translate, rotate, scale, group scoping
- `cetz/advanced.md` — intersections, merge-path, anchors, tree library, projections
- `cetz/cetz-plot.md` — cetz-plot plotting extension
- `cetz/examples/` — runnable `.typ` examples (physics diagrams)
