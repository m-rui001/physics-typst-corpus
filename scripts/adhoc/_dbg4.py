import importlib.util
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)
tests = ["Mon." + BS + " Not." + BS + " Roy." + BS + " Astron." + BS + " Soc.",
         "Encyclop" + BS + "aedia Inflationaris",
         "Astrophys." + BS + " J."]
for t in tests:
    print(repr(t), "->", repr(bn.convert(t, bn.Counter())))
print("aap" in bn.NAMES, "ae" in bn.NAMES)
print([n for n in bn.NAMES if "ae".startswith(n)][:5])
