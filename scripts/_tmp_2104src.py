import re
p = r"E:\phys\papers\2104.02565\src\2.7Geoneutrino\section.tex"
s = open(p, encoding="utf-8", errors="replace").read()
for a in ["shown in Fig", "estimated by two methods"]:
    i = s.find(a)
    print(repr(s[i-80:i+700]))
    print("=====")
p2 = r"E:\phys\papers\2104.02565\src\3.10Offline\section.tex"
s2 = open(p2, encoding="utf-8", errors="replace").read()
i = s2.find("Threading")
print(repr(s2[i-120:i+300]))
print("=====")
p3 = r"E:\phys\papers\2104.02565\src\3.11LowBackground\section.tex"
s3 = open(p3, encoding="utf-8", errors="replace").read()
for a in ["target impurity", "tab:bkgBudget"]:
    i = s3.find(a)
    print(repr(s3[max(0,i-150):i+250]))
