import importlib.util
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
for p in ["papers/2104.02565/refs.bib", "papers/2112.03923/refs.bib",
          "papers/2201.09478/refs.bib", "papers/2205.10379/refs.bib",
          "papers/2206.11528/refs.bib", "papers/2105.06980/refs.bib"]:
    res, _ = bn.process(open(p, encoding="utf-8").read())
    print("==", p, res.count(BS))
    for ln in res.splitlines():
        if BS in ln:
            print("  ", repr(ln.strip()[:110]))
