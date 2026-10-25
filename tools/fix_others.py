import re, sys

path = sys.argv[1]
t = open(path, encoding='utf-8').read()

def convert(val):
    if not re.search(r'(?i)\band\s+others\b', val):
        return None
    names = [x.strip() for x in re.split(r'\s+and\s+|(?<=[.\w])and\s+', val) if x.strip()]
    names = [n for n in names if not re.match(r'(?i)^others\b', n) and n.lower() != 'others']
    shown = []
    for n in names:
        if ', ' in n:
            last, ini = n.split(', ', 1)
            shown.append(ini + ' ' + last)
        else:
            shown.append(n)
    return ', '.join(shown) + ', et al.' if len(shown) > 1 else shown[0] + ' et al.'

def fix(m):
    lit = convert(m.group(2))
    if lit is None:
        return m.group(0)
    return m.group(1) + '{{' + lit + '}}' + m.group(3)

n_before = len(re.findall(r'(?i)\band\s+others\b', t))
t = re.sub(r'(?im)^(\s*author\s*=\s*)\{(.*?)\}(,?)\s*$', fix, t)
t = re.sub(r'(?im)^(\s*author\s*=\s*)"(.*?)"(,?)\s*$', fix, t)
n_after = len(re.findall(r'(?i)\band\s+others\b', t))
open(path, 'w', encoding='utf-8').write(t)
print('before', n_before, 'after', n_after)
