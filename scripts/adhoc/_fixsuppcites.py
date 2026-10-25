import io, sys
sys.stdout.reconfigure(encoding="utf-8")
p = r"E:\phys\papers\2408.13687\supplement.typ"
s = io.open(p, encoding="utf-8").read()
pairs = [
    ("+ a neural network decoder introduced in Ref.,",
     "+ a neural network decoder introduced in Ref. #cite(<bausch2023learning>),"),
    ("Libra recently introduced in Ref. with an ensemble size of 51",
     "Libra recently introduced in Ref. #cite(<jones2024improved>) with an ensemble size of 51"),
    ("Harmony introduced in Ref. with an ensemble size of 101",
     "Harmony introduced in Ref. #cite(<shutty2024efficient>) with an ensemble size of 101"),
    ("we adopt the hyperparameters from Ref. for the surface code",
     "we adopt the hyperparameters from Ref. #cite(<sivak2024optimization>) for the surface code"),
    ("using ensembles of matching decoders, we use a faster correlated-matching decoder for training. As was shown in , the learned priors",
     "using ensembles of matching decoders #cite(<shutty2024efficient>) #cite(<jones2024improved>), we use a faster correlated-matching decoder #cite(<higgott2023sparse>) for training. As was shown in #cite(<sivak2024optimization>), the learned priors"),
    ("Sparse Blossom, as described in Ref., assumes",
     "Sparse Blossom, as described in Ref. #cite(<higgott2023sparse>), assumes"),
]
for old, new in pairs:
    c = s.count(old)
    print(c, repr(old[:50]))
    if c != 1:
        raise SystemExit("count != 1")
    s = s.replace(old, new)
io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
