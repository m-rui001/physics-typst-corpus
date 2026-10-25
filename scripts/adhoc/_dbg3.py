import importlib.util
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
v = "Kn{" + BS + '"o}pfle'
print(repr(v))
print(repr(bn.convert(v, bn.Counter())))
s = open("papers/2106.16243/refs.bib", encoding="utf-8").read()
i = s.find("Kn{")
print(repr(s[i:i + 30]))
print(repr(bn.convert(s[i:i + 30], bn.Counter())))
