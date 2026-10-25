import collections
import glob
import importlib.util
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
tot = collections.Counter()
for f in sorted(glob.glob("papers/*/refs.bib")):
    src = open(f, encoding="utf-8").read()
    res, st = bn.process(src)
    b = res.count(BS)
    bal = res.count("{") - res.count("}")
    if b or bal or src.count("@") != res.count("@") or src.count(" = ") != res.count(" = "):
        print(f, "bs", b, "bal", bal, "@", src.count("@"), res.count("@"))
    for k, v in st.items():
        if k.startswith("left:"):
            tot[k] += v
print("unknown:", tot.most_common(25))
