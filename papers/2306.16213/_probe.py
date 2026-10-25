import re
s = open('src/nanograv_15yr_gwb.tex', encoding='utf-8').read()
start = s.index(r'\begin{document}')
s = s[start:]
authors = re.findall(r'\\author(?:\[([^\]]*)\])?\{([^}]*)\}', s)
affs = re.findall(r'\\affiliation\{', s)
print('authors', len(authors), 'affil cmds', len(affs))
print(authors[:4])
print(authors[-3:])
