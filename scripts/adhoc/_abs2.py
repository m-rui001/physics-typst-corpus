import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
text = open("papers/2306.16227/refs.bib", encoding="utf-8").read()
key = BS + BS + BS + BS + "$"
i = text.find(key)
print("found", i)
start = text.rfind("@", 0, i)
print(repr(text[start:start + 300]))
j = text.find("\n}", i)
print(repr(text[j - 200:j + 100]))
