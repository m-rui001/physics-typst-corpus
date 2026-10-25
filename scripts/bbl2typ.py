"""Convert the paper's .bbl into a Typst reference list (refs_body.typ).

refs.bib was scraped from the .bbl with every field collapsed into `title`, so
#bibliography prints garbage. The .bbl itself is clean publisher text.
"""
import io
import re

SRC = 'src/mp_entangle_pr_clean.bbl'
OUT = 'refs_body.typ'
B = chr(92)
WS = (' ', chr(9), chr(10), chr(13))

ACC = {
    'v{Z}': 'Ž', 'v{z}': 'ž', 'v{c}': 'č', 'v{C}': 'Č', 'v{s}': 'š', 'v{S}': 'Š',
    'v{r}': 'ř', 'v{e}': 'ě', 'v{n}': 'ň',
    "'{c}": 'ć', "'{e}": 'é', "'{a}": 'á', "'{i}": 'í', "'{o}": 'ó',
    "'{u}": 'ú', "'{y}": 'ý', "'{n}": 'ń', "'{s}": 'ś', "'{z}": 'ź', "'{C}": 'Ć',
    "'{E}": 'É', "'{A}": 'Á', "'{O}": 'Ó', "'{U}": 'Ú', "'{N}": 'Ń',
    '"{a}': 'ä', '"{o}': 'ö', '"{u}': 'ü', '"{e}': 'ë', '"{i}': 'ï', '"{y}': 'ÿ',
    '"{A}': 'Ä', '"{O}': 'Ö', '"{U}': 'Ü', '"{E}': 'Ë',
    '`{a}': 'à', '`{e}': 'è', '`{i}': 'ì', '`{o}': 'ò', '`{u}': 'ù',
    '^{a}': 'â', '^{e}': 'ê', '^{i}': 'î', '^{o}': 'ô', '^{u}': 'û',
    '~{a}': 'ã', '~{n}': 'ñ', '~{o}': 'õ', '~{A}': 'Ã', '~{N}': 'Ñ',
    'c{c}': 'ç', 'c{C}': 'Ç', 'u{a}': 'ă', 'u{g}': 'ğ', 'k{a}': 'ą', 'k{e}': 'ę',
    'H{o}': 'ő', 'H{u}': 'ű', '.z': 'ż', '.Z': 'Ż', '={a}': 'ā', '={e}': 'ē',
    '={o}': 'ō', '={u}': 'ū',
}


def find_group(s, i):
    """s[i] == '{' -> (content, index after matching '}')."""
    depth = 0
    j = i
    while j < len(s):
        if s[j] == B:
            j += 2
            continue
        if s[j] == '{':
            depth += 1
        elif s[j] == '}':
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
        j += 1
    return s[i + 1:], len(s)


def expand_cmds(s):
    out = []
    i = 0
    while i < len(s):
        if s[i] != B:
            c = s[i]
            out.append({'#': B + '#', '`': B + '`', '_': B + '_', '*': B + '*',
                        '$': B + '$', '[': B + '[', ']': B + ']'}.get(c, c))
            i += 1
            continue
        # single-character accents: \'e  \"u  \`a  \^o  \~n  \=a  \.z
        if i + 1 < len(s) and s[i + 1] in ("'", '"', '`', '^', '~', '=', '.'):
            ch = s[i + 1]
            j = i + 2
            if j < len(s) and s[j] == '{':
                a, j = find_group(s, j)
            elif j < len(s):
                a, j = s[j], j + 1
            else:
                a = ''
            out.append(ACC.get(ch + '{' + a + '}', a))
            i = j
            continue
        if i + 1 < len(s) and not s[i + 1].isalpha():
            c = s[i + 1]
            out.append({'&': '&', '%': '%', '_': B + '_', '{': '', '}': '',
                        ' ': ' '}.get(c, ''))
            i += 2
            continue
        m = re.match(re.escape(B) + r'([A-Za-z]+)\*?', s[i:])
        if not m:
            i += 1
            continue
        name = m.group(1)
        j = i + len(m.group(0))
        while j < len(s) and s[j] in WS:
            j += 1
        if name in ('href', 'url', 'path', 'text', 'textrm', 'textit', 'emph',
                    'textsc', 'textup', 'mathrm', 'mbox', 'hbox', 'textnormal'):
            a, j = find_group(s, j) if j < len(s) and s[j] == '{' else ('', j)
            while j < len(s) and s[j] in WS:
                j += 1
            if name == 'href':
                b, j = find_group(s, j) if j < len(s) and s[j] == '{' else ('', j)
                if a.strip():
                    out.append('#link("' + a.strip() + '")[' + expand_cmds(b) + ']')
                else:
                    out.append(expand_cmds(b))
            else:
                out.append(expand_cmds(a))
            i = j
            continue
        if name in ('newblock', 'newline', 'relax', 'urlprefix', 'noindent', 'par'):
            out.append(' ')
            i = j
            continue
        if name in ('v', 'c', 'u', 'k', 'H', '='):
            if j < len(s) and s[j] == '{':
                a, j = find_group(s, j)
            elif j < len(s):
                a, j = s[j], j + 1
            else:
                a = ''
            out.append(ACC.get(name + '{' + a + '}', a))
            i = j
            continue
        if name == 'ifmmode':
            e = s.find(B + 'else', j)
            f = s.find(B + 'fi', j)
            if e != -1 and (f == -1 or e < f):
                a = s[e + len(B) + 4:f].strip()
            else:
                a = ''
            j = (f + len(B) + 2) if f != -1 else j
            out.append(expand_cmds(a))
            i = j
            continue
        i = j
    return ''.join(out)


def clean(body):
    s = expand_cmds(body)
    s = s.replace('---', '—').replace('--', '–').replace('{}', '')
    s = s.replace('{', '').replace('}', '')
    s = re.sub(r'[ \t\r\n]+', ' ', s).strip()
    return s.rstrip('. ').rstrip() + '.'


text = io.open(SRC, encoding='utf-8', errors='replace').read()
text = text[text.index(B + 'begin{thebibliography}'):]
parts = re.split(re.escape(B) + r'bibitem\{([^}]*)\}', text)
items = []
for k in range(1, len(parts) - 1, 2):
    body = parts[k + 1].split(B + 'end{thebibliography}')[0]
    items.append(clean(body))

lines = ['#heading(level: 1, numbering: none)[References]',
         '#set par(hanging-indent: 1.7em, first-line-indent: 0em, justify: false)',
         '']
for n, it in enumerate(items, 1):
    lines.extend(['[%d] %s' % (n, it), ''])
io.open(OUT, 'w', encoding='utf-8', newline='').write('\n'.join(lines))
print('items', len(items))
print(items[0][:220])
print(items[1][:220])
