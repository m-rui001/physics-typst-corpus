import re, shutil, io

src = 'src/authors_affiliations_LB_2020.01_key_ptepv2.tex'
raw = open(src, encoding='utf-8', errors='replace').read()

def conv(s):
    s = s.replace("``", '"').replace("''", '"')
    s = re.sub(r'([A-Za-z])`', lambda m: m.group(1) + '\u0300', s)
    s = s.replace('`', '')
    s = s.replace('\\,', ' ').replace('\\&', '&').replace('~', ' ')
    s = s.replace('\\ss', 'ß').replace('\\o ', 'ø').replace('{\\o}', 'ø').replace('\\o', 'ø')
    s = s.replace('{\\l}', 'ł').replace('\\l ', 'ł').replace('{\\i}', 'ı').replace('\\i', 'ı')
    s = s.replace('{\\ae}', 'æ').replace('\\ae', 'æ').replace('{\\AA}', 'Å').replace('\\AA', 'Å')
    # accents: \'e, \'{e}, \'{\i}, \`a, \"o, \~n, \v{s}, \c{c}, \r{a}, \u{g}, \H{o}, \k{a}, \.
    acc = {"'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308', '~': '\u0303',
           'v': '\u030c', 'c': '\u0327', 'r': '\u030a', 'u': '\u0306', 'H': '\u030b',
           'k': '\u0328', '.': '\u0307', '=': '\u0304'}
    def rep(m):
        a = acc[m.group(1)]
        base = m.group(3) or m.group(2) or ''
        return (base + a) if base else m.group(0)
    s = re.sub(r"\\(['`^\"~vcrHu=k])[\{ ]?(?:\{\\i\}|\\i|([A-Za-z])|(\{([A-Za-z])\}))", rep, s)
    # fix case where group4 used
    s = re.sub(r'\\([A-Za-z]+)', r'\1', s)
    s = s.replace('{', '').replace('}', '')
    return re.sub(r'\s+', ' ', s).strip()

authors = re.findall(r'\\author\[([0-9,]+)\]\{([^}]*)\}', raw)
affils = re.findall(r'\\affil\[([0-9]+)\]\{([^}]*)\}', raw)
assert len(authors) == 190, len(authors)
assert len(affils) >= 80, len(affils)

names = []
for nums, name in authors:
    names.append(f"{conv(name)}#super[{nums.replace(',', ',')}]")

body = ["  #text(8.8pt)[", ", ".join(names), "]", "  #v(0.8em)"]
body.append("  #text(7pt)[")
for num, aff in affils:
    body.append(f"    #super[{num}] {conv(aff)} \\")
body.append("  ]")
block = "\n".join(body) + "\n"

mt = open('main.typ', encoding='utf-8').read()
old = "  #text(10.5pt)[1]\n"
assert mt.count(old) == 1, mt.count(old)
shutil.copyfile('main.typ', 'main.typ.preauthors')
mt = mt.replace(old, block)
open('main.typ', 'w', encoding='utf-8').write(mt)
print('authors', len(names), 'affils', len(affils))
print(block[:400])
