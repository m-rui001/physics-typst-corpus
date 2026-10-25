import re, shutil
p = "papers/2410.05380/main.typ"
shutil.copy(p, p + ".pretablelayout")
s = open(p, encoding="utf-8").read()

start = s.index("#figure(\n  table(\n    columns: 6,")
end_marker = ") <tab:bfranges24>"
end = s.index(end_marker, start) + len(end_marker)

half1 = [
    ("sin2_12", r"$sin^2 theta_12$", "0.307", "0.275", "0.308", "0.275"),
]

rows1 = [
    (r"$sin^2 theta_12$", (r"$0.307_(- 0.011)^(+ 0.012)$", r"$0.275 arrow.r 0.345$", r"$0.308_(- 0.011)^(+ 0.012)$", r"$0.275 arrow.r 0.345$")),
    (r"$theta_12 / degree$", (r"$33.68_(- 0.70)^(+ 0.73)$", r"$31.63 arrow.r 35.95$", r"$33.68_(- 0.70)^(+ 0.73)$", r"$31.63 arrow.r 35.95$")),
    (r"$sin^2 theta_23$", (r"$0.561_(- 0.015)^(+ 0.012)$", r"$0.430 arrow.r 0.596$", r"$0.562_(- 0.015)^(+ 0.012)$", r"$0.437 arrow.r 0.597$")),
    (r"$theta_23 / degree$", (r"$48.5_(- 0.9)^(+ 0.7)$", r"$41.0 arrow.r 50.5$", r"$48.6_(- 0.9)^(+ 0.7)$", r"$41.4 arrow.r 50.6$")),
    (r"$sin^2 theta_13$", (r"$0.02195_(- 0.00058)^(+ 0.00054)$", r"$0.02023 arrow.r 0.02376$", r"$0.02224_(- 0.00057)^(+ 0.00056)$", r"$0.02053 arrow.r 0.02397$")),
    (r"$theta_13 / degree$", (r"$8.52_(- 0.11)^(+ 0.11)$", r"$8.18 arrow.r 8.87$", r"$8.58_(- 0.11)^(+ 0.11)$", r"$8.24 arrow.r 8.91$")),
    (r'$delta_"CP" / degree$', (r"$177_(- 20)^(+ 19)$", r"$96 arrow.r 422$", r"$285_(- 28)^(+ 25)$", r"$201 arrow.r 348$")),
    (r'$frac(Delta m_21^2, 10^(-5) "eV"^2)$', (r"$7.49_(- 0.19)^(+ 0.19)$", r"$6.92 arrow.r 8.05$", r"$7.49_(- 0.19)^(+ 0.19)$", r"$6.92 arrow.r 8.05$")),
    (r'$frac(Delta m_(3 ell)^2, 10^(-3) "eV"^2)$', (r"$+ 2.534_(- 0.023)^(+ 0.025)$", r"$+ 2.463 arrow.r + 2.606$", r"$- 2.510_(- 0.025)^(+ 0.024)$", r"$- 2.584 arrow.r - 2.438$")),
]

rows2 = [
    (r"$sin^2 theta_12$", (r"$0.308_(- 0.011)^(+ 0.012)$", r"$0.275 arrow.r 0.345$", r"$0.308_(- 0.011)^(+ 0.012)$", r"$0.275 arrow.r 0.345$")),
    (r"$theta_12 / degree$", (r"$33.68_(- 0.70)^(+ 0.73)$", r"$31.63 arrow.r 35.95$", r"$33.68_(- 0.70)^(+ 0.73)$", r"$31.63 arrow.r 35.95$")),
    (r"$sin^2 theta_23$", (r"$0.470_(- 0.013)^(+ 0.017)$", r"$0.435 arrow.r 0.585$", r"$0.550_(- 0.015)^(+ 0.012)$", r"$0.440 arrow.r 0.584$")),
    (r"$theta_23 / degree$", (r"$43.3_(- 0.8)^(+ 1.0)$", r"$41.3 arrow.r 49.9$", r"$47.9_(- 0.9)^(+ 0.7)$", r"$41.5 arrow.r 49.8$")),
    (r"$sin^2 theta_13$", (r"$0.02215_(- 0.00058)^(+ 0.00056)$", r"$0.02030 arrow.r 0.02388$", r"$0.02231_(- 0.00056)^(+ 0.00056)$", r"$0.02060 arrow.r 0.02409$")),
    (r"$theta_13 / degree$", (r"$8.56_(- 0.11)^(+ 0.11)$", r"$8.19 arrow.r 8.89$", r"$8.59_(- 0.11)^(+ 0.11)$", r"$8.25 arrow.r 8.93$")),
    (r'$delta_"CP" / degree$', (r"$212_(- 41)^(+ 26)$", r"$124 arrow.r 364$", r"$274_(- 25)^(+ 22)$", r"$201 arrow.r 335$")),
    (r'$frac(Delta m_21^2, 10^(-5) "eV"^2)$', (r"$7.49_(- 0.19)^(+ 0.19)$", r"$6.92 arrow.r 8.05$", r"$7.49_(- 0.19)^(+ 0.19)$", r"$6.92 arrow.r 8.05$")),
    (r'$frac(Delta m_(3 ell)^2, 10^(-3) "eV"^2)$', (r"$+ 2.513_(- 0.019)^(+ 0.021)$", r"$+ 2.451 arrow.r + 2.578$", r"$- 2.484_(- 0.020)^(+ 0.020)$", r"$- 2.547 arrow.r - 2.421$")),
]

def half(label, nohdr, iohdr, rows):
    out = [f"    table.hline(stroke: 1pt),",
           f"    table.cell(colspan: 5, align: left)[*{label}*],",
           f"    [], table.cell(colspan: 2)[{nohdr}], table.cell(colspan: 2)[{iohdr}],",
           "    table.hline(stroke: 0.5pt),",
           "    [], [bfp $plus.minus 1 sigma$], [$3 sigma$ range], [bfp $plus.minus 1 sigma$], [$3 sigma$ range],",
           "    table.hline(stroke: 0.5pt),"]
    for name, vals in rows:
        out.append("    [" + name + "], " + ", ".join("[" + v + "]" for v in vals) + ",")
    return out

block = ["#figure(",
         "  table(",
         "    columns: 5,",
         "    align: center,",
         "    stroke: none,",
         "    inset: (x: 3pt, y: 2.5pt),"]
block += half("IC19 without SK atmospheric data",
              r"Normal Ordering ($Delta chi^2 = 0.6$)",
              "Inverted Ordering (best fit)", rows1)
block += half("IC24 with SK atmospheric data",
              "Normal Ordering (best fit)",
              r"Inverted Ordering ($Delta chi^2 = 6.1$)", rows2)
block += ["    table.hline(stroke: 1pt),",
          "  ),",
          "  caption: [Three-flavor oscillation parameters from our fit to global data for the two variants of the analysis described in the text. The numbers in the 1st (2nd) column are obtained assuming NO (IO), _i.e._, relative to the respective local minimum. Note that $Delta m_(3 ell)^2 equiv Delta m_31^2 > 0$ for NO and $Delta m_(3 ell)^2 equiv Delta m_32^2 < 0$ for IO.],",
          ") <tab:bfranges24>"]

s = s[:start] + "\n".join(block) + s[end:]
open(p, "w", encoding="utf-8", newline="\n").write(s)
print("rewritten table block, chars", end - start)
