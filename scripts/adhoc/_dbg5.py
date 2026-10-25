import importlib.util
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
v = BS + "'{" + BS + "i}n, J. L."
print(repr(v), "->", repr(bn.convert(v, bn.Counter())))
v2 = 'is a key quantity \\", in Bayesian'
print(repr(v2), "->", repr(bn.convert(v2, bn.Counter())))
