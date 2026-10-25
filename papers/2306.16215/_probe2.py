import re
s = open('src/ppta_sgwb_arxiv.tex', encoding='utf-8').read()
s = s[s.index(r'\begin{document}'):]
defs = {}
for m in re.finditer(r'\\newcommand\s*\{?\\([A-Za-z]+)\}?\s*\{((?:[^{}]|\{[^{}]*\})*)\}', s):
    defs[m.group(1)] = m.group(2)
print({k: v[:30] for k, v in defs.items()})
i = s.find(r'\affiliation{\swinburne}')
print(repr(s[i:i + 120]))
