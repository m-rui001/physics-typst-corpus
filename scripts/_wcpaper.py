import glob, os, re, sys

d = sys.argv[1]
tex = ''
for f in glob.glob(os.path.join(d, 'src', '*.tex')):
    tex += open(f, encoding='utf-8', errors='replace').read()
typ = open(os.path.join(d, 'main.typ'), encoding='utf-8').read()


def words(t):
    t = re.sub(r'\$[^$]*\$', ' MATH ', t)
    t = re.sub(r'\\[A-Za-z]+\*?(\[[^\]]*\])?(\{[^{}]*\})?', ' ', t)
    t = re.sub(r'[{}]', ' ', t)
    return len(re.findall(r"[A-Za-z][A-Za-z'-]+", t))


print('tex words', words(tex))
print('typ words', words(typ))
sec = re.findall(r'^\s*\\section\*?\{([^}]*)\}', tex, re.M)
heads = re.findall(r'^=+\s+(.+)$', typ, re.M)
print('tex sections', len(sec))
print('typ headings', len(heads))
for s in sec:
    key = re.sub(r'[^A-Za-z]', '', s).lower()[:14]
    found = any(key[:10] in re.sub(r'[^A-Za-z]', '', h).lower() for h in heads)
    if not found:
        print('MISSING heading:', s)
