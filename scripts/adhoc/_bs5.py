import importlib.util
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
for p in ["papers/2105.06980/refs.bib", "papers/2206.11528/refs.bib",
          "papers/2104.02565/refs.bib"]:
    res, _ = bn.process(open(p, encoding="utf-8").read())
    print("==", p)
    for m in re.finditer(re.escape(BS) + ".{0,40}", res):
        print("  ", repr(m.group(0)))
