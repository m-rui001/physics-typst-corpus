import re
import sys

with open('main.typ', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all equation blocks: \$\$\\begin{equation} ... \\end{equation}\$\$
# In the file, these appear as literal: \$\$\\begin{equation}
pattern = re.compile(r'\\\$\$\\\\begin\{equation\}(.*?)\\\\end\{equation\}\\\$\$', re.DOTALL)
blocks = pattern.findall(content)
print(f'Found {len(blocks)} equation blocks')
for i, b in enumerate(blocks):
    print(f'--- Block {i+1} ---')
    print(b.strip()[:400])
    print()
