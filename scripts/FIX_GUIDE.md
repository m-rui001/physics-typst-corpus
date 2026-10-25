# Typst conversion fix guide (for sub-agents)

You are repairing an automatically converted arXiv physics paper so that it compiles to a
clean, idiomatic Typst document. Paper directory: `E:\phys\papers\<id>\` with `main.typ`,
`refs.bib`, `imgs/`, `src/` (original LaTeX), `figures/` (extracted TikZ).

## Deterministic first
Before editing by hand, run the whole non-LLM repair chain and read what is left:
```
python -X utf8 E:/phys/scripts/drive.py papers/<id>      # from E:\phys
```
It runs `latexblock → bibfix → keyfix → citefix → holes → bibclean → figtext → scaffold →
spacekey → figwire → bibmerge → citeclose`, then compiles and prints the remaining `error:`
lines. Every stage is idempotent and none of them delete document content, so re-running
after a manual fix is always safe. Never run it on a paper another agent is still editing.

## Loop
1. `typst compile E:\phys\papers\<id>\main.typ E:\phys\papers\<id>\build\main.pdf` (run from the paper dir).
2. Read every reported error, open `main.typ` at the reported line, fix the root cause.
3. Repeat until the compiler reports **zero errors** and the PDF is > 20 KB and has a
   plausible page count (roughly `chars/3000`).

## Rules
- Work on ONE paper per agent, and `cp main.typ main.typ.<yourtag>` before the first edit.
- Errors that look far from their cause are almost always an unclosed `$`: scan per-line
  dollar parity instead of trusting the reported line number.
- `#figure(...)` accepts a SINGLE positional argument. Several panels go in a content
  block — `#figure([\n#image("a.png")\n#image("b.png")\n], caption: […])` — not in
  `stack(dir: tt)` / `grid(...)`, which either fail or collide with pandoc's own `grid` helper.
- A `<label>` bound to a `#block[…]` produces "cannot reference block"; move it onto the
  inner `#figure(…)`. Two `\label`s on one heading collapse: repoint the references, never delete.
- Empty BibLaTeX fields (`year={},`) abort the whole bibliography — `bibclean.py` removes them.
- Never delete content to make it compile. Convert it. Only if a fragment is truly
  unrecoverable, comment that single line out with `// TODO-latex: ` and list it in your report.
- Preserve section order, equations, figure placement and captions.
- Typst 0.15.1 is installed. Local skill docs you should consult before guessing:
  - `E:\phys\skills\claude-skill-typst-main\skills\typst\SKILL.md`
  - `E:\phys\skills\typst-cetz-skills-main\cetz\SKILL.md` (plus primitives.md / marks.md / canvas.md)
- Known-bad symbols in this Typst version: `circle.times`, `plus.circle`, `oplus`, `angle.r`.
  Use Unicode instead: `⊗ ⊕  ⟨ ⟩ ± → ≠ ∞ ∂ `.
- LaTeX leftovers to convert, not strip:
  - `\begin{align} ... \end{align}` → `#set math.equation(numbering: "(1)")` once at the top plus
    `$ ... \& ... $`-style aligned math (`$ a &= b $` blocks, one `$/…$` per equation, label with `<eq:x>`).
  - `\frac{a}{b}` → `frac(a,b)`; `\sqrt{x}` → `sqrt(x)`; `\vec{v}` → `vec(v)`; `\hat{x}` → `hat(x)`;
    `\mathbf{B}` → `bold(B)`; `\text{...}`/`\mathrm{...}` → `"…"`; `\ket{\psi}` → `|psi ⟩`.
  - Author/affiliation blocks that leaked in as literal `$^{1}$` / `\scriptsize` text → rewrite as a
    centered `#align(center)[…]` block with the names in bold and affiliations in small italic text.
- Citations: `@key` must exist in `refs.bib` (or in a `<label>`); otherwise replace with plain
  author-year text. Bibliography line must be `#bibliography("refs.bib", style: "ieee")`.
- Figures: Typst cannot embed PDF/EPS. Every `image(...)` path must resolve to an existing
  `imgs/*.png` or `imgs/*.jpg`; convert with pymupdf if needed:
  `python -X utf8 -c "import pymupdf;d=pymupdf.open('x.pdf');d[0].get_pixmap(dpi=170).save('imgs/x.png')"`
  (find the original under `src/`). Use `#figure(image("imgs/x.png", width: 75%), caption: […]) <fig:x>`.

## CeTZ figures
If `figures/tikz_<n>.tex` exists and `main.typ` still contains the placeholder
`⟨TikZ source: figures/tikz_n.tex⟩`, replace it with a real CeTZ drawing:
`#figure(cetz.canvas({ import cetz.draw: *; … }), caption: […]) <fig:n>`.
`import cetz.draw: *` must be INSIDE the canvas block. Compile the snippet on its own before
inlining it. Keep the geometry, labels and arrow tips of the original TikZ picture.

## Verify visually
After a green compile, render two pages and look at them:
```
python -X utf8 -c "import pymupdf,os;d=pymupdf.open(r'E:\phys\papers\<id>\build\main.pdf');os.makedirs(r'E:\phys\papers\<id>\check',exist_ok=True);[d[p].get_pixmap(dpi=110).save(rf'E:\phys\papers\<id>\check\page{p+1}.png') for p in (0,2)];print(d.page_count)"
```
Open the PNGs and confirm: no raw LaTeX text, no broken math, headings numbered, figures placed.

## Report back
Per paper: compiled (yes/no), page count, PDF size, the fixes you made, and any line you had to
comment out. Update `E:\phys\papers\<id>\report.json` with `"compiled": true/false` and
`"fixed_by": "agent"`.

## Verified facts (do not rediscover)
- Run stages through `drive.py`; if you invoke a script yourself, pass an ABSOLUTE script
  path (the driver's relative-path bug made the whole chain a silent no-op once).
- Typst renders only *cited* bib entries. A big refs.bib is not a page-count problem.
- `python -X utf8 scripts/qc.py papers/<id>` = audit board (pages/cited/entries/unresolved).
- EPS: PyMuPDF cannot open them. Use Ghostscript (`E:\phys\tools\gs10051\bin\gswin64c.exe`)
  with `-dEPSCrop`, cache `_eps/<name>.pdf`, then rasterise at dpi 160 (`missingfig.py`).
- After `holes`/`holes2` inject citations, re-check `$` pairing (`typrepair.py`, `mathbal.py`).
  Fix delimiters; never delete a recovered `@key` to silence an error.
- If a paper cites almost nothing but `src/` is full of `\cite`, the sentences themselves are
  missing: re-convert those chunks from `src/` instead of running more citation repair.
