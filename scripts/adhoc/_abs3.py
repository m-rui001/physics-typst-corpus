import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
text = open("papers/2306.16227/refs.bib", encoding="utf-8").read()
i = text.find("rho" + BS + "_")
print("i", i)
seg = text[i - 12:i + 40]
print(repr(seg))
print([hex(ord(c)) for c in seg])
start = text.rfind("@", 0, i)
print(repr(text[start:start + 120]))
