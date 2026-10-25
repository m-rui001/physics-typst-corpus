import io, json, re

p = r'papers/2104.07036/main.typ'
typ = io.open(p, encoding='utf-8').read()
runs = json.load(io.open(r'scripts/holes2104.json', encoding='utf-8'))

MANUAL = {288: '@Kapustin:2006pk', 1112: '@Rudelius:2020orz'}

for o in reversed(runs):
    kind, val = o['kind'], o['val']
    if kind == 'cite':
        keys = [k.strip() for k in re.split(r'[,\s]+', val) if k.strip()]
        rep = ' '.join('@' + k for k in keys)
    elif kind in ('ref', 'eqref'):
        rep = '@' + val.strip()
    else:
        rep = MANUAL.get(o['line'])
        if not rep:
            print('UNHANDLED', o['line'], o['ctx'])
            continue
    typ = typ[:o['start']] + rep + typ[o['end']:]

# drop literal supplement words that duplicate the automatic reference text
typ = re.sub(r'(?:Section|Sec\.)~?\s*(?=@s?sec|@sssec)', '', typ)
typ = re.sub(r'(?:Figure|Fig\.)~?\s*(?=@fig)', '', typ)
typ = re.sub(r'(?:Statement|Lemma|Theorem)~?\s*(?=@(?:stat|lemma|thm))', '', typ)

# front matter
old_start = typ.index('#align(center)[\n  #text(17pt')
old_end = typ.index('ACFI-T21-03') + len('ACFI-T21-03')
front = r'''#align(right)[ACFI-T21-03]
#v(-0.6em)
#align(center)[
  #text(17pt, weight: "bold", [Non-Invertible Global Symmetries and Completeness of the Spectrum])
  #v(0.9em)
  #text(11pt)[Ben Heidenreich#super[1], Jacob McNamara#super[2], Miguel Montero#super[2], Matthew Reece#super[2], Tom Rudelius#super[3,4], and Irene Valenzuela#super[2]]
  #v(0.6em)
  #text(8.5pt)[
    #super[1] Department of Physics, University of Massachusetts, Amherst, MA 01003 USA \
    #super[2] Department of Physics, Harvard University, Cambridge, MA 02138 USA \
    #super[3] Department of Physics, University of California, Berkeley, CA 94720, USA \
    #super[4] School of Natural Sciences, Institute for Advanced Study, Princeton, NJ 08540, USA
  ]
]
#v(0.8em)
#align(center)[#block(width: 86%)[#text(9.5pt)[
  *Abstract.* It is widely believed that consistent theories of quantum gravity satisfy two basic kinematic constraints: they are free from any global symmetry, and they contain a complete spectrum of gauge charges. For compact, abelian gauge groups, completeness follows from the absence of a 1-form global symmetry. However, this correspondence breaks down for more general gauge groups, where the breaking of the 1-form symmetry is insufficient to guarantee a complete spectrum. We show that the correspondence may be restored by broadening our notion of symmetry to include non-invertible topological operators, and prove that their absence is sufficient to guarantee a complete spectrum for any compact, possibly disconnected gauge group. In addition, we prove an analogous statement regarding the completeness of #emph[twist vortices]: codimension-2 objects defined by a discrete holonomy around their worldvolume, such as cosmic strings in four dimensions. We discuss how this correspondence is modified in various, more general contexts, including non-compact gauge groups, Higgsing of gauge theories, and the addition of Chern-Simons terms. Finally, we discuss the implications of our results for the Swampland program, as well as the phenomenological implications of the existence of twist strings.
]]]
#v(0.6em)
#outline(title: [Contents], depth: 2, indent: auto)
#pagebreak()'''
typ = typ[:old_start] + front + typ[old_end:]

# layout: single column, 12pt article, 1in margins
typ = typ.replace('#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")',
                  '#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 11.5pt, lang: "en")')
typ = typ.replace('#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))',
                  '#set page(numbering: "1", paper: "us-letter", margin: 2.54cm)')
typ = typ.replace('#set math.equation(numbering: n => {\n  let h = counter(heading).get()\n  numbering("(1.1)", h.first(), n)\n})',
                  '#set math.equation(numbering: n => {\n  let h = counter(heading).get()\n  numbering("(1.1)", h.first(), n)\n})')

# bibliography at end
typ = typ.rstrip() + '\n\n#bibliography("refs.bib", style: "ieee", title: [References])\n'

io.open(p, 'w', encoding='utf-8', newline='\n').write(typ)
print('done')
