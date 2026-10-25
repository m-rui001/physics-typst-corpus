#emph[Proof.] It is known~@steane1996multiple @calderbank1996good that $ k = n - sans("rk") H^X - sans("rk") H^Z . $ We claim that $sans("rk") H^X = sans("rk") H^Z$. Indeed, define a self-inverse permutation matrix $C_ell$ of size $ell times ell$ such that the $i$-th column of $C_ell$ has a single nonzero entry equal to one at the row $j = -i med (upright("mod") ell)$. Define $C_m$ similarly and let $C = C_ell otimes C_m$. Since $C_ell S_ell C_ell = S_ell^T$ and $C_m S_m C_m = S_m^T$, one gets

$ A^T = C A C quad upright("and") quad B^T = C B C . $ <ABC2>

Therefore one can write

$ H^Z = [B^T | A^T] = [C B C | C A C] = C [A | B] mat(delim: "[", 0, C; C, 0) = C H^X mat(delim: "[", 0, C; C, 0) . $

Thus $H^Z$ is obtained from $H^X$ by multiplying on the left and on the right by invertible matrices. This implies $sans("rk") H^X = sans("rk") H^Z$. Therefore

$ k & = n - 2 dot.op sans("rk") H^Z = n - 2 (n/2 - dim(sans("ker") (H^Z)^T)) \
  & = n - 2 (n/2 - dim(sans("ker") A sect sans("ker") B)) \
  & = 2 dot.op upright("dim") (sans("ker") A sect sans("ker") B) . $

Here we noted that $H^Z$ has size $(n/2) times n$ and $sans("ker") (H^Z)^T = sans("ker") A sect sans("ker") B$ since $H^Z = [B^T | A^T]$.~◻

It is known~@steane1996multiple @calderbank1996good that a CSS code with check matrices $H^X$ and $H^Z$ has distance $d = min(d^X, d^Z)$, where $d^X$ and $d^Z$ are the code distances for $X$-type and $Z$-type errors defined as

$ d^X = min { |v| : thin v in sans("ker") H^Z without sans("rs") H^X } quad upright("and") quad d^Z = min { |v| : thin v in sans("ker") H^X without sans("rs") H^Z } . $

We claim that $d^Z lt.eq d^X$. Indeed, let $X(f) = product_(j=1)^n X_j^(f_j)$ be a minimum weight logical $X$-type Pauli operator such that $|f| = d^X$. Then $H^Z f = 0$ and $f in.not sans("rs") H^X$. Thus there exists a logical $Z$-type operator $Z(g) = product_(j=1)^n Z_j^(g_j)$ anti-commuting with $X(f)$. In other words, $H^X g = 0$ and $f^T g = 1$. Here, $f$ and $g$ are length-$n$ binary vectors. Write $f = (alpha, beta)$ and $g = (gamma, delta)$, where $alpha, beta, gamma, delta$ are length-$(n/2)$ vectors. Conditions $H^Z f = 0$ and $H^X g = 0$ are equivalent to

$ B^T alpha = A^T beta quad upright("and") quad A gamma = B delta . $ <alpha_beta_gamma_delta>

Here and below all arithmetics is modulo two. Define length-$n$ vectors

$ e = (C delta, C gamma) quad upright("and") quad h = (C beta, C alpha) . $

From Eqs.~(@ABC2, @alpha_beta_gamma_delta) one gets

$ H^X h = [A | B] mat(delim: "[", C beta; C alpha) = A C beta + B C alpha = C (A^T beta + B^T alpha) = 0 . $

Likewise,

$ H^Z e = [B^T | A^T] mat(delim: "[", C delta; C gamma) = B^T C delta + A^T C gamma = C (B delta + A gamma) = 0 . $

Furthermore,

$ h^T e = beta^T C C delta + alpha^T C C gamma = beta^T delta + alpha^T gamma = f^T g = 1 . $

Thus $X(e)$ and $Z(h)$ are non-identity logical operators. It follows that $d^Z lt.eq |h|$. We get

$ d^Z lt.eq |h| = |C beta| + |C alpha| = |beta| + |alpha| = |f| = d^X . $

Thus $d^Z lt.eq d^X$. Similar argument shows that $d^X lt.eq d^Z$, that is, $d^X = d^Z$.

]
