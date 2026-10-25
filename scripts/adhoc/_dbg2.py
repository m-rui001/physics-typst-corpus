import inspect
import sys

sys.stdout.reconfigure(encoding="utf-8")
import importlib.util

spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
src = inspect.getsource(bn.convert)
print(src)
