import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
text = open("papers/2104.02565/refs.bib", encoding="utf-8").read()
i = text.find("Yermia")
start = text.rfind("@", 0, i)
seg = text[start:i + 40]
print(repr(seg[:500]))
print("---tail---")
print(repr(seg[-600:]))
