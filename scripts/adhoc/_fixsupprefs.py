import io, sys
sys.stdout.reconfigure(encoding="utf-8")
p = r"E:\phys\papers\2408.13687\supplement.typ"
s = io.open(p, encoding="utf-8").read()
TH = "\u2006"
pairs = [
    ("one million cycles in Fig. We see", "one million cycles in @fig:latency_vs_block_number_single_run. We see"),
    ("number of cycles are shown in Fig. Stability", "number of cycles are shown in @fig:latency_vs_circuit_depth. Stability"),
    ("preweight correlations strategy described in Section" + TH + " The same thread",
     "preweight correlations strategy described in @sec:preweight_corr. The same thread"),
    ("open green circles in Fig. The solid", "open green circles in @fig:suppl_scalability_plot. The solid"),
    ("dashed green line in Fig. We find", "dashed green line in @fig:suppl_scalability_plot. We find"),
    ("blue dashed line in Fig. The predicted", "blue dashed line in @fig:suppl_scalability_plot. The predicted"),
    ("of the 72-qubit processor, see Fig. There, we observe", "of the 72-qubit processor, see @fig:crossover. There, we observe"),
    ("and another is presented in Fig." + TH + " These events", "and another is presented in @fig:repetition_supplement. These events"),
    ("An example is presented in Fig." + TH + "\n", "An example is presented in @fig:repetition_supplement.\n"),
    ("predicted from a Pauli simulation of the 105-qubit processor based on Fig. Each point",
     "predicted from a Pauli simulation of the 105-qubit processor based on @fig:edcfs. Each point"),
    ("and then averaged over grid and basis, in Fig.\n", "and then averaged over grid and basis, in @fig:one_point.\n"),
]
for old, new in pairs:
    c = s.count(old)
    print(c, repr(old[:60]))
    if c != 1:
        raise SystemExit("count != 1")
    s = s.replace(old, new)
io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
