import re, io, os
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'src'))
BS = chr(92)
tex = io.open('article_springer.tex', encoding='utf-8', errors='replace').read()
labels = set(re.findall(BS + BS + r'label\{([^}]*)\}', tex))
refs = re.findall(BS + BS + r'(?:ref|eqref|autoref|pageref)\{([^}]*)\}', tex)
print('labels:', sorted(labels))
print()
from collections import Counter
c = Counter(refs)
print('refs used:', dict(c))
print()
print('DANGLING refs (no label):', sorted(set(refs) - labels))
print('UNUSED labels:', sorted(labels - set(refs)))
