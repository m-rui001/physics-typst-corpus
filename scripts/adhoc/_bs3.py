import importlib.util
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
for p in ["papers/2306.16227/refs.bib", "papers/2306.16215/refs.bib"]:
    res, _ = bn.process(open(p, encoding="utf-8").read())
    print("==", p)
    import re
    for m in re.finditer(re.escape(BS) + ".{0,25}", res):
        print("  ", repr(m.group(0)))
