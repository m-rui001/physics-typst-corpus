import re, sys

src = open('src/nicer_pulse_profile_modeling.tex', encoding='utf-8', errors='replace').read()
body = src[src.index(r'\begin{document}'):src.index(r'\begin{abstract}')]

# strip orcid optional arg and tag macros, expand ~
authors = []      # list of dict(name, affils=[])
pending = []
seen_affil = False
affils = []       # ordered unique

def clean_tex(t):
    t = t.replace(r'\&', '&')
    t = re.sub(r'\\textsuperscript\{([^{}]*)\}', r'#super[\1]', t)
    t = re.sub(r'\\textit\{([^{}]*)\}', r'#emph[\1]', t)
    t = re.sub(r'\\(?:emph|project|NICER|XMM)\{([^{}]*)\}', r'#emph[\1]', t)
    t = t.replace('~', ' ')
    # accents \'{e} \"{u} \'e etc.
    acc = {"'": '\u0301', '`': '\u0300', '"': '\u0308', '^': '\u0302', '~': '\u0303',
           'c': '\u0327', 'v': '\u030c', 'H': '\u030b', 'u': '\u0306', '=': '\u0304'}
    def rep(m):
        mark = acc.get(m.group(1), '')
        base = m.group(2) or m.group(3)
        return base + mark
    t = re.sub(r"\\(['`\"^~c=vHu])(?:\{([A-Za-z])\}|([A-Za-z]))", rep, t)
    t = t.replace(r'\ss', 'ß').replace('{', '').replace('}', '')
    t = re.sub(r'\s+', ' ', t).strip()
    return t

pat = re.compile(r'\\author(?:\[[^\]]*\])?\{((?:[^{}]|\{[^{}]*\})*)\}|\\affil\{((?:[^{}]|\{[^{}]*\})*)\}')
for m in pat.finditer(body):
    if m.group(1) is not None:
        if seen_affil or not pending:
            pending = []
            seen_affil = False
        a = {'name': clean_tex(m.group(1)), 'affils': []}
        authors.append(a); pending.append(a)
    else:
        txt = clean_tex(m.group(2))
        if txt not in affils:
            affils.append(txt)
        for a in pending:
            if txt not in a['affils']:
                a['affils'].append(txt)
        seen_affil = True

assert len(authors) == 30, len(authors)
num = {x: i + 1 for i, x in enumerate(affils)}
auth_str = ', '.join(a['name'] + ('#super[' + ','.join(str(num[x]) for x in a['affils']) + ']' if a['affils'] else '') for a in authors)
aff_str = ' \\\\\n    '.join(f'#super[{num[x]}] {x}' for x in affils)
email = re.search(r'\\email\{([^{}]*)\}', src).group(1).strip().replace('@', r'\@')
corr = re.search(r'\\correspondingauthor\{([^{}]*)\}', src).group(1).strip().replace('~', ' ')

block = f'''#align(center)[
  #text(17pt, weight: "bold", [A NICER VIEW OF THE MASSIVE PULSAR PSR~J0740$+$6620 INFORMED BY RADIO TIMING AND #emph[XMM-NEWTON] SPECTROSCOPY])
  #v(1em)
  #text(9pt)[{auth_str}]
  #v(0.6em)
  #text(7.2pt)[
    {aff_str} \\\\
    Corresponding author: {corr} ({email})
  ]
]
'''
open('_title_block.typ', 'w', encoding='utf-8').write(block)
print(len(authors), len(affils))
print(block)
