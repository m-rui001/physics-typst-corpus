import io

p = "papers/2112.03708/main.typ"
s = open(p, encoding="utf-8").read()

a_old = "as $bb(E) [ | psi ( t ⟩ ⟨ psi ( t ) | ] = rho ( t ) .$ Expectation values"
a_new = ("as\n\n$ bb(E) [ | psi ( t ) ⟩ ⟨ psi ( t ) | ] = rho ( t ) . $ "
         "<eq:mcsolve-convergence>\n\nExpectation values")
b_old = ("obtained from $bb(E) [ ⟨ psi ( t ) | hat(O) | psi ( t ) ⟩ ] = "
         "upright(\"tr\") [ rho ( t ) hat(O) ] .$ We adjust")
b_new = ("obtained from\n\n$ bb(E) [ ⟨ psi ( t ) | hat(O) | psi ( t ) ⟩ ] = "
         "upright(\"tr\") [ rho ( t ) hat(O) ] . $ <eq:mcsolve-convergence-observable>\n\nWe adjust")

assert s.count(a_old) == 1, s.count(a_old)
assert s.count(b_old) == 1, s.count(b_old)
s = s.replace(a_old, a_new).replace(b_old, b_new)
open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
