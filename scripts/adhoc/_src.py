import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
s = open("papers/2306.16215/refs.bib", encoding="utf-8").read()
i = s.find("az}, M. C.")
print(repr(s[i - 300:i + 80]))
s2 = open("papers/2306.16227/refs.bib", encoding="utf-8").read()
j = s2.find("dm" + BS)
print(repr(s2[max(0, j - 400):j + 120]))
