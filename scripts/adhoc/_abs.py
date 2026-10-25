import importlib.util
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
text = open("papers/2306.16227/refs.bib", encoding="utf-8").read()
i = text.find("abstract")
# show raw chars
seg = text[i:i + 120]
print([hex(ord(c)) for c in seg[:60]])
print(repr(seg))
print(repr(bn.convert(seg, bn.Counter())))
