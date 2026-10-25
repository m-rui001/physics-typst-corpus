#let thmbox(name, body) = figure(
  kind: lower(name),
  supplement: name,
  numbering: "1",
  block(width: 100%, align(left, {
    context [*#name #counter(figure.where(kind: lower(name))).display().*]
    h(0.4em)
    body
  })),
)
#let lemma(body) = thmbox("Lemma", body)
#let dfn(body) = thmbox("Definition", body)

#lemma[The code has parameters.] <lem:a>
#dfn[Code has a toric layout if...] <dfn:a>
#lemma[Second lemma with a list:

+ one

+ two] <lem:b>

See @lem:a, @dfn:a and @lem:b.
