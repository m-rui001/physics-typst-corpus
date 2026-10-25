import io
import re

B = "papers/2105.06980/refs.bib"
s = io.open(B, encoding="utf-8").read()


def strip_cmd(text, cmd):
    pat = "\\" + cmd + "{"
    out = []
    i = 0
    while True:
        j = text.find(pat, i)
        if j < 0:
            out.append(text[i:])
            break
        out.append(text[i:j])
        k = j + len(pat)
        d = 1
        while k < len(text) and d:
            if text[k] == "{":
                d += 1
            elif text[k] == "}":
                d -= 1
            k += 1
        out.append(text[j + len(pat):k - 1])
        i = k
    return "".join(out)


for cmd in ("textit", "emph", "textbf"):
    s = strip_cmd(s, cmd)

s = s.replace(
    'journal = {\\textit{X-PSI: A prototype open-source package for neutron star X-ray Pulsation Simulation and Inference}.}',
    'journal = {Zenodo},')
s = s.replace(
    'journal = {\\textit{X-PSI: A prototype open-source package for neutron star X-ray Pulsation Simulation and Inference}.},\n     year = {2019}',
    'journal = {Zenodo},\n     year = {2019}')
io.open(B, "w", encoding="utf-8").write(s)
print("remaining textit:", s.count("\\textit"), "journal fixed:", "journal = {Zenodo}" in s)
