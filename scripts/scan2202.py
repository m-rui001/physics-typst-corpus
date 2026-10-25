import pymupdf, re, sys

d = pymupdf.open('papers/2202.13919/build/main.pdf')
B = chr(92)
pats = {
    'letterspaced': re.compile(r'\b(?:[A-Za-z] ){3,}[A-Za-z]\b'),
    'upright': re.compile(r'upright\('),
    'empty': re.compile(r'\(\s*\)'),
    'cal': re.compile(r'["]?cal["]|' + B + B + 'cal'),
    'textbrace': re.compile(r'text\{|' + B + B + r'frac|' + B + B + r'left|' + B + B + 'begin'),
    'eqdup': re.compile(r'Eq\. \(Eq\.|Eq\. Eq\.'),
    'figdup': re.compile(r'Figure (?:Figure|Fig\.)|Fig\. Figure'),
    'repl': re.compile('\ufffd'),
}
n = 0
for pno in range(len(d)):
    tx = d[pno].get_text()
    for k, p in pats.items():
        for m in p.finditer(tx):
            s = max(0, m.start() - 55)
            print(pno + 1, k, repr(tx[s:m.end() + 45]).replace('\\n', ' '))
            n += 1
print('hits', n, 'pages', len(d))
