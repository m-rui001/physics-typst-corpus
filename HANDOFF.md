# Handoff — tex→typst corpus (2026-10-21, third pass)

Read this first if you are continuing the goal in a new session.

## Layout is part of the deliverable (new, user-mandated)

A build can pass every content gate and still be wrong: 2408.13687 shipped single-column with
large page-bottom gaps although revtex `reprint` is two-column. Fixed and rendered: letter paper,
full-width title/abstract, `#columns(2, gutter: 0.7cm)[…]` around each body region, `figure*`
outside the region at `width: 100%`, column floats at `width: 100%`, two-column bibliography
(11 pp, E=0 W=0, census 90/90). Probed Typst 0.15.1 facts (do not re-probe): `columns(1)` inside
a two-column page stays column-width and does NOT span; `column-gap`/`#set column`/figure
`column-span:` do not exist; a label after the closing `]` of `#columns` binds to the columns
element ("cannot reference columns"). Details in project memory `typst-layout-facts.md`.

Next: derive the column model for every paper from its `\documentclass` options and
`\onecolumngrid`/`\twocolumngrid` switches, and match it. No `tools/layout_check.py` exists yet —
that is the obvious next tool (TeX columns vs Typst columns, plus bottom-whitespace ratio from
rendered PNGs).

**Tools now exist** (third pass, later):

- `tools/layout_check.py` — per paper: intended columns from `\documentclass` (revtex/aap/aa/
  aastex/mnras two-column; article/iopart/svjour one-column) vs Typst (`set page(columns:)` and
  `#columns(N)`), plus the worst mid-document bottom-whitespace ratio parsed from 30-dpi PGM
  rasters. Grid/table `columns:` are ignored on purpose. `gap` is a number to look at, not a
  defect: a wide float legitimately ends a column early.
- `tools/twocol.py <ids> --apply` — mechanical re-layout: single-column page, body from its first
  heading wrapped in `#columns(2, gutter: 0.6cm)`, `figure*` floats pulled out between regions,
  images without a width forced to `width: 100%` (they would otherwise render at natural pixel
  size inside a column), page switched to `us-letter` (A4 when the class says `a4paper`).
  Backs up to `main.typ.pretwocol` and **auto-reverts** any paper that stops compiling.

Layout state after the pass — 9 papers two-column, all 0E/0W: 2102.01010 (14 pp), 2107.00724,
2107.13563 (7 pp, and its page 6 still has a 0.85 bottom gap — one page to inspect), 2207.06431,
2306.16213, 2306.16215, 2306.16227, 2312.03982, 2408.13687. Still mismatched: **2105.06980**
(aastex631 twocolumn; every wrapping attempt raises E=1 and the tool self-reverts, so the paper
is back to its clean single-column build — the wrapper opens at its first `= ` heading and the
Delphi hits an unclosed delimiter, cause not yet found; it also has an image that resolves in
the TeX tree but not under `imgs/`), and the three papers with no build: 2112.03708,
2112.03923, 2201.09478. `figure*` detection still reads 0 for papers whose floats live in files
reached through `\input` (2312.03982's wide figures stayed column-width as a result).

Two traps found while doing this: a `re.sub` replacement containing `\1` written as a plain
string inserts chr(1) into every path (the paper then fails to load the file) — use a lambda, the
current `_fit` does; and never run `twocol.py` while `fig_annotate.py --apply` is walking the
same papers — both rewrite whole files, so one silently discards the other's edit.

## Raster figures carry vision annotations (new, user-mandated)

`python -X utf8 tools/fig_annotate.py <id|--all> [--apply] [--workers N]` inserts a
`// [figvision] <path>` comment block (detailed panel-by-panel description) directly before each
`#figure(` that holds a raster image, so the description lives at the figure site and never
reaches the PDF. Model: `opencode/nemotron-3.5-super-vl-free` on `127.0.0.1:10000`
(key in `E:\tools\OpenCode2API-main\config.json`); cache `tools/figvision_cache.json` keyed by
image hash, so re-runs are free; re-runs replace the block instead of duplicating it. Every paper
is recompiled after annotation and its `pdftotext` output compared with the pre-edit build —
expect `text=identical`. 2408.13687 done (6 figures, E=0 W=0, text=identical); the corpus run
(491 raster figures) started 08:43 UTC, log `logs_figvision.txt`. CeTZ figures are out of scope.

## Gates (run these, in this order, from E:\phys)

```
python -X utf8 tools/cite_census.py                 # citation fidelity, every paper
python -X utf8 tools/fig_annotate.py --all          # raster figures (add --apply to annotate)
python -X utf8 tools/elegance.py                    # how hand-written the Typst looks, ranked
python -X utf8 tools/figcheck.py                    # float integrity screen (read docstring first)
python -X utf8 tools/macro_leak.py                  # unexpanded \newcommand leakage
for id in $(ls papers); do [ -f papers/$id/main.typ ] || continue
  typst compile --root . papers/$id/main.typ papers/$id/build/main.pdf 2>papers/$id/build/compile.log
  echo "$id E=$(grep -c '^error' papers/$id/build/compile.log) W=$(grep -c '^warning' papers/$id/build/compile.log)"
done
```

Compile is never the whole check: 0E/0W papers still had dropped `\cite`s, literal macro names,
and invisible equation numbers. Confirm with `pdftotext -enc UTF-8 <pdf> -` and, for math and
figures, rendered PNGs (`pdftoppm -png -r 100`). Text-layer CESU-8 garbage around math spans is
a Typst artifact, not a defect — judge math only from images.

## State verified at 04:15 UTC (third pass)

Corpus compile sweep, all 27 fetched-and-converted papers, measured this pass:

- **0E/0W (22):** 2102.01010(18p) 2102.01111(63) 2104.02565(66) 2104.04119(26) 2104.11260(17)
  2105.06980(50) 2107.13563(9) 2109.00548(57) 2110.02085(19) 2111.08640(47) 2111.14241(99)
  2202.02773(140) 2205.10379(24) 2207.06431(56) 2306.16213(39) 2306.16215(24) 2306.16216(15)
  2306.16227(55) 2308.10681(13) 2312.03982(40) 2408.13687(13) 2410.05380(25)
- **Still failing:** 2308.07915 E=43 (its conversion agent burned its own turn limit while trying to
  write a pandoc converter; a scoped recovery agent is now on it), 2106.16243 E=5, 2107.00724 E=4,
  2112.03923 E=3, 2112.03708 E=1 (finisher dispatched).

Citation census after this pass's three gate fixes (see "Tools"): missing=0 on 21 of the 0E papers.
Open losses: 2106.16243 (51) and 2107.00724 (25) — both still mid-conversion, so expected;
2112.03708 (5), 2308.07915 (5), 2105.06980 (2), 2306.16227 (5), 2202.02773 (1 `komatsu2003`),
2306.16213 (1 `2021apj923l22a`) — the last two are single keys that the stricter scanner newly
exposed, waiting on the elegance agents that own those files (do not double-edit them).

- 2306.16227 is reconciled: 154 reported losses were 149 case-only re-spellings plus 5 real drops;
  `refs.bib` went 6767 → 277 entries, all cited, 273 rendered references, journal macros expanded
  from the paper's own `src/bibliography/journals.tex`.
- 2408.13687's dropped supplement table (`Suppl:table-released-datasets`) is restored with its three
  caption cites, and `Table 2` numbering verified by render on page 3.
- 2111.14241: the two flagged prose passages are now in (one was already present, one was a whole
  two-paragraph block including eq. (96)); its agent also found a **systematic `@fig:autoNN`
  off-by-one** — labels assigned in TeX order while floats were emitted in Typst order — which is a
  silent defect class (compiles clean, census clean) and is under a dedicated agent.
- 2104.04119 done: 0E/0W, 53/53, 3 TikZ→CeTZ redraws, refs rebuilt from `src/SLbib.bib`, two raw
  LaTeX accents fixed in the bib.

## Scratch-file hygiene (this pass)

Dead probe/scratch `.typ` files were sitting at paper roots, where both audit tools read them:
`2105.06980/{fresh,probe6,probe7,_title_block}.typ` (that alone scored 851 → 203 and held raw
double-escaped LaTeX), `2102.01111/{_l792,_t,t}.typ`, `2202.02773/{_b,_min,_t}.typ`,
`2306.16215/{_t,_t2}.typ`, `2107.13563/_t4.typ`. All were **moved, not deleted**, into
`papers/<id>/_work/`, which the tools ignore. Only two non-`main.typ` files in the corpus are live:
`2111.14241/refs_body.typ` (`#include`d) and `2408.13687/supplement.typ` (separate compile).

## Two fixes worth repeating

- **`\citepalias` flattening.** The converter turns `\citepalias{key}{ALIAS}` into literal alias text,
  which loses the reference. Typst's supplement is the faithful form:
  `#cite(<abb-16>, supplement: [NG9gwb])` → renders `[138, NG9gwb]` and credits the entry.
  Applied in 2306.16213:806. Do NOT convert the *prose* alias mentions that follow a
  "henceforth NG12gwb" first use — bare text is what LaTeX prints there.
- **`angle.l`/`angle.r` are illegal inside an aligned display block** (`error: unknown symbol
  modifier`) although they parse in a single-line `$ … $`. Use `angle( x )` for `\langle x \rangle`
  in `&=` blocks. Applied in the 2202.02773 eq.(68) re-splice.

## In-flight sub-agents (as of 04:16 UTC — verify, don't duplicate)

| papers | task |
|---|---|
| 2202.02773 | elegance repair (287 `upright()`, 229 TeX spacing cmds, 280 >600-char lines) |
| 2109.00548 | elegance repair (138 `#h(..em)` fake kerns) |
| 2102.01111 | elegance repair (78 kerns, 54 `upright()`, 114 long lines) |
| 2306.16213 | elegance repair (170 `upright()`, 31 kerns) — must not touch the `\citepalias` fix at :806 |
| 2105.06980 + 2306.16227 | restore the 7 single keys the stricter census newly exposed |
| 2112.03708 | finish to 0E (1 error left) + restore 5 keys |
| 2111.14241 | map and retarget the `@fig:autoNN` off-by-one; report on two open prose questions |
| 2308.07915 | recover from E=43 (defect-family classification first, no converter rewrite) |
| 2112.03923 / 2107.13563 / 2107.10113 / 2107.00724 / 2106.16243 | full conversions, still running |
| corpus QA sampler | read-only render inspection of finished papers, defect table only |

**Finished this pass:** 2306.16227 (bib namespace rebuild), 2408.13687 (supplement table + caption
cites), 2104.04119 (full conversion, 3 CeTZ), 2111.14241 (two dropped prose passages), 2104.02565,
2207.06431, 2312.03982 verified 0E/0W in the sweep.

Each agent was told: back up before editing (`cp -n`), never delete content, gate on 0E/0W **plus**
census **plus** a before/after render comparison, stay inside its own `papers/<id>/`, put scratch in
`_work/`.

## Elegance ("尽量转为优雅的typst代码") is now measurable

`python -X utf8 tools/elegance.py` ranks papers by surviving converter junk. Corpus scores at the
start of the repair round: 2202.02773=847, 2111.14241=636, 2112.03708=366, 2308.07915=352,
2306.16213=318, 2102.01111=314, 2109.00548=220; cleanest are 2107.10113=1, 2106.16243=39 (mid-work),
2308.10681=40. Columns that are **not** defects and were removed or must stay ignored: `~` before a
citation (correct unbreakable space), `upright()` wrapping math or a content block, and a label glued
after `$` when it still attaches and numbers.

`python -X utf8 tools/figcheck.py` screens float integrity (TeX caption ↔ Typst caption pairing).
Read its docstring before acting: `inversions` is NOT a defect (authors float figures freely and
Typst re-numbers consistently), and `lost_float` over-reports for citation-heavy captions — 2111.08640
screens 12/15 lost while every figure renders. Confirm any hit by rendering the page. Full run saved
to `tmp/figcheck-audit.txt`. Genuine hits worth a look after the current agents land: 2102.01111's
three cut-off/`fig:openstring1` captions, 2202.02773 (6 lost / 7 orphan of 73), 2105.06980 (8 lost).

## CeTZ status — verified by render, not by filename

2110.02085: Fig 1/3/4 plus a new split panel `figures/schematic_fig2b.cetz.typ` (data panel kept
raster) — all eyeballed on rendered pages. 2205.10379: Fig 1(b), 2(a,b), 4(a,b) are CeTZ.
2306.16215 and 2306.16216 were inspected figure by figure: **all 18+11 figures are real data
plots** (KDEs, corner plots, violin posteriors, correlation histograms), no TikZ anywhere in `src/`.
The earlier "mostly-schematic" guess was filename-based and wrong — do not retry it. Judge a
figure by rendering it, and never fabricate data points to make a vector drawing.

Papers with actual TikZ/PGF source: 2308.07915 (3), 2104.04119 (3), 2104.02565 (1, done),
2306.16227 (1). Other existing CeTZ: 2202.02773 (5), 2111.14241 (2), 2109.00548 (2).

Rules that were expensive to learn: `include` not `import`; `circle(radius: (rx, ry))` not
`ellipse`; canvas `{…}` is code mode (no `#`) while content blocks need `#`; stroke key is `paint`;
label text does not extend the auto bbox; `calc.*` for math; no `**`.

**`content(..., scale: 0.6)` is a silent no-op in CeTZ 0.4.2.** Text renders at document size, so
every label overflows its box and neighbours overlap, with 0 errors/0 warnings. Only the render
shows it. Scale text with `text(size: 6pt, body)` and size the boxes from measured widths
(`typst query` on `#context measure(...).width.cm()`); a 10.5pt `$Y(pi\/2)$` is 1.17 cm, wider than
a 1.45-unit gate box at `length: 0.52cm`. Rebuilt `papers/2112.03923/figures/EDcircuitecho.cetz.typ`
(Extended Data Fig. 1, three canvases) this way; old version kept as `.prescale`.

**Panel-c style layout lesson:** rows of pulse bars need ≥0.4 cm between label baselines and the
bar tops, and bracket labels need their own line; cramming `BB1`, rotation labels and the
dynamical-decoupling bracket into one 0.3 cm band is what produced the earlier "text soup".

## Queue: fetched, not yet converted

Now all fetched papers are assigned to agents. Newly fetched this pass and queued for a future
round if their agents don't finish: `papers/2206.11528` (quantum many-body scars, quasiparticle
view), `papers/2201.09478` (non-Hermitian skin effect in ultracold atoms), `papers/2105.11445`
(repeating FRB in a globular cluster), `papers/2203.02139` (Majorana neutrino search, inverted
ordering), `papers/2108.08219` (NOvA oscillation parameters), `papers/2204.12771` (long-duration
GRB with a peculiar origin). Probed and rejected as PDF-only (no TeX source): 2205.08037,
2204.10371, 2102.09825.
More candidates: `papers/candidates2.json` (physics, sorted by citations) — `papers/candidates.json`
is the off-topic AI list, skip it. Fetch recipe (many candidates are PDF-only — check first):

```
curl -sIL https://arxiv.org/e-print/<id> | grep -i '^content-type'   # gzip = has source, pdf = skip
curl -sL https://arxiv.org/e-print/<id> -o /tmp/<id>.gz && tar -xzf /tmp/<id>.gz -C papers/<id>/src
```

## Tools worth reusing

- `tools/cite_census.py` — fidelity gate; **now scans every live `.typ` in the paper dir**, because
  an article plus supplement splits the citation set (that alone cleared 27 of 28 in 2408.13687).
  Normalizes keys to alphanumerics so the converter's `.`/`/`/`&`→`-` renames don't create false
  losses. SKIPs papers with no `#bibliography`.
- `tools/cite_rebind.py <id> [--apply]` — restores mis-bound/dropped cites by anchoring on the ≤4
  TeX words before each `\cite` and claiming citation slots in TeX order against the original line.
  Deterministic, conservative (only overwrites a wrong key cited more than once). NOANCHOR/MULTILINE
  residue needs a human read. Still main.typ-only — widen it if you rely on it for supplements.
- `tools/cite_loss_context.py` — per lost key, the TeX sentence, as a worklist.
- `tools/macro_leak.py` — flags `\newcommand` names surviving as words in main.typ (noisy: many macro
  names are ordinary English words — judge from the printed context).
- `scripts/drive.py papers/<id>` — the whole non-LLM repair chain, idempotent.
- `E:\arxiv_paper_to_typst\经验记录.md` — 33 rounds of hand-written Chinese Typst/CeTZ conversion
  pitfalls from a sibling project; `blank_bands.py`/`margin_overflow.py` there take `<pdf> <tag>`
  and work cross-project.

## Silent content loss in the converter (found 2026-10-21, fixed)

Two constructs make pandoc discard *whole sentences/floats* with no compile error. Both were
fixed in `scripts/convert.py`; any paper converted before this date must be re-checked.

- **`\edit{... \citet{k} ...}` with nested braces.** The old macro expander used
  `\edit\{([^{}]*)\}`; the regex missed nested braces, pandoc met an unknown `\edit` and
  dropped its entire argument. 2107.10113 lost ~1.5k words this way (5 paragraphs).
  Replaced by `expand_macros()`: balance-aware argument scan, 4 substitution rounds.
- **`\subfloat[cap]{\includegraphics{...}}`.** Pandoc's LaTeX reader has no `\subfloat`
  and drops the whole float, images and `\caption` included. The TeX parent caption already
  names panels (a)/(b)/(c), so the converter now unwraps `\subfloat[..]` before pandoc
  (verified: 3 figures restored in 2107.10113, 19/19 images present).
- **`\odot`.** Pandoc emits `dot.circle`, which Typst 0.15 does not define ("unknown symbol
  modifier"). Converter now writes the literal `⊙`.

Gates added:
- `tools/prose_coverage.py <id|dir>` — difflib alignment of TeX words vs Typst words;
  prints the longest runs present in the TeX but absent from Typst. After the fix
  2107.10113 went 0.903 → 0.972. Corpus baseline is in `tmp/` scan output; anything below
  ~0.85 needs the multi-file/main-tex check before it is called a loss.
- `tools/fig_census.py <id|dir>` — every `\includegraphics` must have an `image()` or a CeTZ
  canvas; lists MISSING with the caption head. 2107.10113 now 19/19, 0 missing.
- `tools/holefill.py <id> [--apply]` — fills `#text([])` holes by anchoring on the preceding
  prose and taking the next cite/ref event (sibling-key case handled). Conservative: fills
  55 of 102 on 2107.10113, leaves ambiguous ones. 178/178 keys after the last two manual fixes.

2107.10113 final state: 36 pages, 0E/0W, 178/178 cites, 19/19 figures, coverage 0.972,
front matter preserved (spliced from `main.typ.presection3`; `figref/secref/eqref` helpers
defined at the top of main.typ).
