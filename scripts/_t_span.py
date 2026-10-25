import io, re, sys
sys.path.insert(0, 'scripts')
from mathclean import clean
s = io.open('papers/2202.13919/main.typ', encoding='utf-8').read()
line = s.split('\n')[258]
ms = list(re.finditer(r'\$([^$\n]*)\$', line))
print('spans on line', len(ms))
for m in ms:
    print('OLD:', m.group(1)[:80])
    print('NEW:', clean(m.group(1))[:80])
