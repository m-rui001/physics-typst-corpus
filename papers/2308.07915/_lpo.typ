#block[
#emph[Proof.] Write

$ P = sum_(alpha in cal(M)) p_alpha alpha, quad overline(P) = sum_(alpha in cal(M)) overline(p)_alpha alpha, quad Q = sum_(alpha in cal(M)) q_alpha alpha, quad overline(Q) = sum_(alpha in cal(M)) overline(q)_alpha alpha , $

where $p_alpha, overline(p)_alpha, q_alpha, overline(q)_alpha in bb(F)_2$ are coefficients. Pauli operators $X(P, Q)$ and $Z(overline(P), overline(Q))$ overlap on a qubit $q(L, alpha)$ iff $p_alpha overline(p)_alpha = 1$ and overlap on a qubit $q(R, alpha)$ iff $q_alpha overline(q)_alpha = 1$. Thus $X(P, Q)$ and $Z(overline(P), overline(Q))$ anti-commute iff $sum_(alpha in cal(M)) p_alpha overline(p)_alpha + q_alpha overline(q)_alpha$ is odd. We have

$ P overline(P)^T = sum_(alpha in cal(M)) p_alpha overline(p)_alpha 1 + dots quad upright("and") quad Q overline(Q)^T = sum_(alpha in cal(M)) q_alpha overline(q)_alpha 1 + dots $

where dots represent all monomials different from $1$. By linearity,

$ P overline(P)^T + Q overline(Q)^T = sum_(alpha in cal(M)) (p_alpha overline(p)_alpha + q_alpha overline(q)_alpha) 1 + dots . $

Thus $X(P, Q)$ and $Z(overline(P), overline(Q))$ anti-commute iff $P overline(P)^T + Q overline(Q)^T$ contains the monomial $1$.~◻

]

Without loss of generality, we can express logical Pauli matrices as either $X(P, Q)$ or $Z(Q^T, P^T)$ via a choice of $P, Q in bb(F)_2^(cal(M))$. The operator $X(P, Q)$ commutes with the stabilizer $Z(alpha B^T, alpha A^T)$ whenever $1 in.not P(alpha B^T)^T + Q(alpha A^T)^T = alpha^T (P B + Q A)$. This is equivalent to $alpha in.not P B + Q A$. Since we must have $alpha in.not P B + Q A$ for all $alpha$, we see that $X(P, Q)$ commutes with the stabilizer whenever $P B + Q A$ vanishes. Similarly we can derive that $Z(Q^T, P^T)$ commutes with the stabilizer when $P B + Q A = 0$.

We aim to construct a family of solutions to $P B + Q A = 0$ which give rise to a basis of logical qubits defined by a set of operators $(overline(X)_1, overline(X)_2, dots, overline(Z)_1, overline(Z)_2, dots)$ with the correct commutation relations. To do so, let us make some observations about Pauli operators defined via solutions to $P B + Q A = 0$. First, if $P, Q$ are a solution, then so are $alpha P, alpha Q$ for any $alpha in cal(M)$, so each $P, Q$ immediately gives rise to a family of $|cal(M)| = ell m$ logical operators for both $X$ and $Z$. Second, consider using the same $P, Q$ to define both $X(alpha P, alpha Q)$ and $Z(beta Q^T, beta P^T)$. Then these operators always commute because $beta alpha^T in P Q + Q P = 0$ never holds. So we require at least two solutions to $P B + Q A = 0$ to define a set of operators with nontrivial commutation relations.

For reasons described later in @ssec:logical_measurements, we would like a logical $X$ operator with no support on $q(R)$. To this end, we select $f, g, h in bb(F)_2^(cal(M))$ that satisfy $B f = 0$ and $g B + h A = 0$, yielding two solutions to the equation $P B + Q A = 0$ with $P, Q = f, 0$ and $P, Q = g, h$. These yield the following family of logical operators for all $alpha in cal(M)$:

$ overline(X)_alpha := X(alpha f, 0) quad overline(Z)_alpha := Z(alpha h^T, alpha g^T) \
  overline(X)'_alpha := X(alpha g, alpha h) quad overline(Z)'_alpha := Z(0, alpha f^T) $ <eq:logicalpaulis>
