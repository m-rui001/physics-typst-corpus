import shutil, re
p = "papers/2102.01111/main.typ"
shutil.copy(p, p + ".preeq32")
s = open(p, encoding="utf-8").read()

start = s.index("- The first typical example is the toroidal compactification")
end_tok = "as given in @mhet."
end = s.index(end_tok, start) + len(end_tok)
new = (
    "- The first typical example is the toroidal compactification of heterotic string theory, "
    "discussed in @sec:evidenceWGC. In this setup, we can compute the whole spectrum perturbatively "
    "including non-BPS states. These states do not saturate the WGC as their mass is strictly smaller "
    "than the charge,\n"
    '  $ m^2_("non-BPS") = frac(2, alpha\') (|q^2| - 2) < frac(2, alpha\') |q^2| = M^2_("BH") ~, $\n'
    "  as given in @mhet."
)
s = s[:start] + new + s[end:]

s = s.replace("> m^2 med", '> m^2_"med"')
s = s.replace('$m_(K K)^2 tilde k^2 M_(K K)^2$', '$m_("KK")^2 tilde k^2 M_("KK")^2$')
s = s.replace('$m^2_(\\str) k T_(\\str)$', '$m_("str")^2 tilde k T_("str")$')

open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
