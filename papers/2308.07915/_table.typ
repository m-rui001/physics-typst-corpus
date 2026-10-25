#block[
#figure(
  align(center)[#table(
    columns: 5,
    align: (center, center, center, center, center),
    stroke: none,
    table.header([$[ [ n, k, d ] ]$], [Net encoding \ Rate $r$], [$ell, m$], [$A$], [$B$]),
    [$[ [ 72, 12, 6 ] ]$], [$1/12$], [$6, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 90, 8, 10 ] ]$], [$1/23$], [$15, 3$], [$x^9 + y + y^2$], [$1 + x^2 + x^7$],
    [$[ [ 108, 8, 10 ] ]$], [$1/27$], [$9, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 144, 12, 12 ] ]$], [$1/24$], [$12, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 288, 12, 18 ] ]$], [$1/48$], [$12, 12$], [$x^3 + y^2 + y^7$], [$y^3 + x + x^2$],
    [$[ [ 360, 12, lt.eq 24 ] ]$], [$1/60$], [$30, 6$], [$x^9 + y + y^2$], [$y^3 + x^25 + x^26$],
    [$[ [ 756, 16, lt.eq 34 ] ]$], [$1/95$], [$21, 18$], [$x^3 + y^10 + y^17$], [$y^5 + x^3 + x^19$],
  )],
  caption: [Small examples of Bivariate Bicycle LDPC codes and their parameters. All codes have weight-6 checks, thickness-2 Tanner graph, and a depth-7 syndrome measurement circuit. Code distance was computed by the mixed integer programming approach of Ref.~@landahl2011fault. Notation $lt.eq d$ indicates that only an upper bound on the code distance is known at the time of this writing. We round $r$ down to the nearest inverse integer. The codes have check matrices $H^X = [A | B]$ and $H^Z = [B^T | A^T]$ with $A$ and $B$ defined in the last two columns. The matrices $x$, $y$ obey $x^ell = y^m = 1$ and $xy = yx$.],
  kind: table,
)
] <table:codes>

#table:codes describes the polynomials $A$ and $B$ that give rise to examples of high-rate, high-distance BB codes found by a numerical search. This includes all codes from @table:codes_intro and two examples of higher distance codes. To the best of our knowledge, all these examples are new. The code $[ [ 360, 12, lt.eq 24 ] ]$ improves upon a code $[ [ 882, 24, lt.eq 24 ] ]$ with weight-6 checks found by Panteleev and Kalachev in~@panteleev2021degenerate (assuming that our distance upper bound is tight). Indeed, taking two independent copies of the 360-qubit code gives parameters $[ [ 720, 24, lt.eq 24 ] ]$.
