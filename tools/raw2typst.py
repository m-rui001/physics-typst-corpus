# -*- coding: utf-8 -*-
"""Convert raw (double-escaped) LaTeX math blocks left by the converter into Typst math.

Usage: python -P tools/raw2typst.py papers/<id>/main.typ [--dry]
"""
import sys, re

SYM = {
    'alpha': 'alpha', 'beta': 'beta', 'gamma': 'gamma', 'delta': 'delta', 'Delta': 'Delta',
    'epsilon': 'epsilon', 'varepsilon': 'epsilon.alt', 'zeta': 'zeta', 'eta': 'eta',
    'theta': 'theta', 'Theta': 'Theta', 'iota': 'iota', 'kappa': 'kappa',
    'lambda': 'lambda', 'Lambda': 'Lambda', 'mu': 'mu', 'nu': 'nu', 'xi': 'xi', 'Xi': 'Xi',
    'pi': 'pi', 'Pi': 'Pi', 'rho': 'rho', 'sigma': 'sigma', 'Sigma': 'Sigma', 'tau': 'tau',
    'upsilon': 'upsilon', 'phi': 'phi', 'varphi': 'phi.alt', 'Phi': 'Phi', 'chi': 'chi',
    'psi': 'psi', 'Psi': 'Psi', 'omega': 'omega', 'Omega': 'Omega',
    'ell': 'ell', 'hbar': 'planck.reduce', 'infty': 'infinity', 'partial': 'partial', 'nabla': 'nabla',
    'pm': 'plus.minus', 'mp': 'minus.plus', 'times': 'times', 'cdot': 'dot.op',
    'otimes': 'times.o', 'oplus': 'plus.o', 'odot': 'dot.o', 'dagger': 'dagger', 'star': 'star', 'sharp': 'sharp', 'flat': 'flat', 'natural': 'natural',
    'circ': 'compose', 'bullet': 'bullet', 'wr': 'wr',
    'leq': 'lt.eq', 'le': 'lt.eq', 'geq': 'gt.eq', 'ge': 'gt.eq', 'neq': 'eq.not', 'ne': 'eq.not',
    'approx': 'approx', 'sim': 'tilde.op', 'simeq': 'tilde.eq', 'propto': 'prop',
    'll': 'lt.double', 'gg': 'gt.double', 'equiv': 'equiv', 'in': 'in', 'notin': 'in.not',
    'subset': 'subset', 'subseteq': 'subset.eq', 'supset': 'supset', 'cup': 'union',
    'cap': 'sect', 'setminus': 'without', 'emptyset': 'emptyset',
    'to': 'arrow.r', 'rightarrow': 'arrow.r', 'leftarrow': 'arrow.l',
    'Rightarrow': 'arrow.r.double', 'Leftarrow': 'arrow.l.double',
    'leftrightarrow': 'arrow.l.r', 'mapsto': 'arrow.r.bar', 'uparrow': 'arrow.t',
    'downarrow': 'arrow.b', 'longrightarrow': 'arrow.r.long',
    'forall': 'forall', 'exists': 'exists', 'neg': 'not', 'land': 'and', 'lor': 'or',
    'langle': 'chevron.l', 'rangle': 'chevron.r', 'lvert': '|', 'rvert': '|', 'vert': '|',
    'lVert': '||', 'rVert': '||', 'Vert': '||', 'mid': '|', 'colon': ':',
    'ldots': 'dots.h', 'dots': 'dots.h', 'cdots': 'dots.c', 'vdots': 'dots.v', 'ddots': 'dots.down',
    'quad': 'quad', 'qquad': 'quad quad', 'prime': "'", 'hbar2': 'planck.reduce',
    'Re': '"Re"', 'Im': '"Im"', 'AA': 'cal(A)', 'ZZ': 'bb(Z)', 'RR': 'bb(R)', 'NN': 'bb(N)',
    'CC': 'bb(C)', 'QQ': 'bb(Q)', 'PP': 'bb(P)',
    'openone': 'bb(1)', 'id': 'bb(1)', 'Tr': '"tr"', 'tr': '"tr"', 'E': '"𝔼"', 'Pr': '"Pr"',
    'd': 'delta', 'l': 'lambda', 'gam': 'gamma', 'gm': 'gamma', 'gmv': 'arrow(gamma)',
    'diff': 'partial', 'ee': 'upright(e)', 'ii': 'upright(i)', 'order': 'cal(O)', 'cO': 'cal(O)',
    'aa': 'tilde(alpha)', 'bb': 'tilde(beta)', 'gg': 'tilde(gamma)',
    'poly': 'op("poly")', 'log': 'log', 'ln': 'ln', 'exp': 'exp', 'sin': 'sin', 'cos': 'cos',
    'tan': 'tan', 'det': 'det', 'dim': 'dim', 'lim': 'lim', 'max': 'max', 'min': 'min',
    'sup': 'sup', 'inf': 'inf', 'arg': 'arg', 'mod': 'mod', 'bmod': 'mod',
    'sum': 'sum', 'prod': 'product', 'int': 'integral', 'iint': 'integral.double',
    'oint': 'integral.cont', 'bigcup': 'union.big', 'bigcap': 'sect.big',
    '|': '|', '{': '{', '}': '}', '&': '&', '%': '%', '$': '$', '#': '#', '_': '_',
    ',': 'thin', ';': 'med', ':': 'med', '!': 'thin', ' ': 'space',
}
# macros that take one braced argument and map to fn(arg)
FUNC1 = {
    'mathcal': 'cal', 'mathbb': 'bb', 'mathfrak': 'frak', 'mathsf': 'sans', 'mathtt': 'mono',
    'mathbf': 'bold', 'boldsymbol': 'bold', 'bm': 'bold', 'bold': 'bold', 'vct': 'bold',
    'vec': 'arrow', 'hat': 'hat', 'widehat': 'hat', 'tilde': 'tilde', 'widetilde': 'tilde',
    'bar': 'overline', 'overline': 'overline', 'underline': 'underline', 'dot': 'dot',
    'ddot': 'dot.double', 'boxed': 'rect', 'sqrt': 'sqrt',
    'Tilde': 'tilde', 'Hat': 'hat', 'Bar': 'overline', 'Vec': 'arrow',
}
TEXTUAL = {'mathrm', 'text', 'textrm', 'textnormal', 'operatorname', 'textup', 'mbox', 'hbox'}
BRAMAC = {'ket', 'bra', 'braket', 'ketbra', 'ketbraq', 'braketq', 'ip', 'abs', 'norm'}
OPNAMES = {'Tr', 'tr', 'E', 'Pr', 'poly', 'log', 'ln', 'exp', 'sin', 'cos', 'tan', 'det',
           'dim', 'lim', 'max', 'min', 'sup', 'inf', 'arg', 'mod'}


class Conv:
    def __init__(self):
        self.unknown = set()

    def conv(self, s):
        out = []
        i, n = 0, len(s)
        while i < n:
            c = s[i]
            if c == '\\':
                j = i + 1
                if j < n and s[j].isalpha():
                    k = j
                    while k < n and s[k].isalpha():
                        k += 1
                    name = s[j:k]
                    txt, i = self.cmd(name, s, k)
                    if txt and out and out[-1] and (out[-1][-1].isalnum() or out[-1][-1] == '"') and txt[0].isalpha():
                        out.append(' ')
                    out.append(txt)
                else:
                    # escaped char
                    ch = s[j] if j < n else ''
                    i = j + 1
                    if ch in '{}%$#&_':
                        out.append(ch)
                    elif ch == '\\':
                        out.append('\n')
                        if i < n and s[i] == '[':
                            i = s.index(']', i) + 1 if ']' in s[i:] else i
                    elif ch in ',;: ':
                        sp = {' ': 'thin', ',': 'thin', ';': 'med', ':': 'med'}[ch]
                        if out and out[-1] and out[-1][-1].isalnum():
                            out.append(' ')
                        out.append(sp)
                    elif ch == '!':
                        pass
                    else:
                        out.append(ch)
                continue
            if c in '_^':
                i += 1
                arg, i = self.group(s, i)
                out.append(('<sub>' if c == '_' else '') + c + '(' + arg + ')')
                out[-1] = ('_' if c == '_' else '^') + '(' + arg + ')'
                continue
            if c == '{':
                inner, i = self.read_brace(s, i)
                sub = self.conv(inner)
                if sub and out and out[-1] and out[-1][-1].isalnum() and sub[0].isalpha():
                    out.append(' ')
                out.append(sub)
                continue
            if c == '}':
                i += 1
                continue
            if c == '&':
                out.append(' & ')
                i += 1
                continue
            if c == '~':
                out.append(' ')
                i += 1
                continue
            if c == '\n':
                out.append(' ')
                i += 1
                continue
            if c.isdigit() and out and out[-1] and out[-1][-1].isalpha():
                out.append(' ')
            out.append(c)
            i += 1
        return ''.join(out)

    def read_brace(self, s, i):
        assert s[i] == '{'
        d = 0
        j = i
        while j < len(s):
            if s[j] == '{':
                d += 1
            elif s[j] == '}':
                d -= 1
                if d == 0:
                    return s[i + 1:j], j + 1
            j += 1
        return s[i + 1:], len(s)

    def group(self, s, i):
        while i < len(s) and s[i] == ' ':
            i += 1
        if i < len(s) and s[i] == '{':
            inner, i = self.read_brace(s, i)
            return self.conv(inner), i
        if i < len(s) and s[i] == '(':
            d = 0
            j = i
            while j < len(s):
                if s[j] == '(':
                    d += 1
                elif s[j] == ')':
                    d -= 1
                    if d == 0:
                        return self.conv(s[i + 1:j]), j + 1
                j += 1
        # single token
        if i < len(s) and s[i] == '\\':
            j = i + 1
            if j < len(s) and s[j].isalpha():
                k = j
                while k < len(s) and s[k].isalpha():
                    k += 1
                return self.cmd(s[j:k], s, k)
            return s[j] if j < len(s) else '', j + 1
        return (s[i] if i < len(s) else ''), i + 1

    def cmd_text(self, name):
        if name in SYM:
            return SYM[name]
        if name in OPNAMES:
            return '"%s"' % name.lower()
        self.unknown.add(name)
        return 'upright("%s")' % name

    def cmd(self, name, s, i):
        # returns (typst text, index after consumed arguments)
        if name in ('rm', 'bf', 'it') and (i >= len(s) or s[i] != '{'):
            rest = s[i:].strip()
            if name == 'rm':
                if '\\' in rest:
                    pos = rest.index('\\')
                    head = rest[:pos].strip()
                    body = self.conv(rest[pos:])
                    return (('"%s" ' % head if head else '') + body).strip(), len(s)
                return '"%s"' % rest, len(s)
            if name == 'bf':
                return 'bold(%s)' % self.conv(rest), len(s)
            return 'italic(%s)' % self.conv(rest), len(s)
        if name in BRAMAC:
            if name == 'ket':
                a, i = self.group(s, i)
                return '|' + a + ' chevron.r', i
            if name == 'bra':
                a, i = self.group(s, i)
                return 'chevron.l ' + a + '|', i
            if name in ('ketbra', 'ketbraq', 'braket', 'braketq', 'ip', 'abs', 'norm'):
                a, i = self.group(s, i)
                if name in ('ketbraq', 'braketq'):
                    b = a
                else:
                    b, i = self.group(s, i)
                if name == 'ketbra':
                    return '|' + a + ' chevron.r chevron.l ' + b + '|', i
                if name == 'braket' or name == 'ketbraq':
                    return 'chevron.l ' + a + ' thin | thin ' + b + ' chevron.r', i
                if name == 'ip':
                    return 'chevron.l ' + a + ' | ' + b + ' chevron.r', i
                if name == 'abs':
                    return '|' + a + '|', i
                if name == 'norm':
                    return '||' + a + '||', i
        if name in ('frac', 'dfrac', 'tfrac', 'nicefrac'):
            a, i = self.group(s, i)
            b, i = self.group(s, i)
            return 'frac(%s, %s)' % (a, b), i
        if name == 'sqrt':
            if i < len(s) and s[i] == '[':
                j = s.index(']', i)
                deg = self.conv(s[i + 1:j])
                a, i = self.group(s, j + 1)
                return 'root(%s, %s)' % (deg, a), i
            a, i = self.group(s, i)
            return 'sqrt(%s)' % a, i
        if name in TEXTUAL:
            if i < len(s) and s[i] == '{':
                raw, i = self.read_brace(s, i)
            else:
                raw, i = (s[i], i + 1) if i < len(s) else ('', i)
            while raw.startswith('{') and raw.endswith('}'):
                raw = raw[1:-1]
            if '\\' in raw:
                pos = raw.index('\\')
                head = raw[:pos].strip()
                body = self.conv(raw[pos:])
                return (('"%s" ' % head if head else '') + body).strip(), i
            return '"%s"' % raw.strip(), i
        if name in FUNC1:
            a, i = self.group(s, i)
            return '%s(%s)' % (FUNC1[name], a), i
        if name in ('big', 'Big', 'bigg', 'Bigg', 'bigl', 'bigr', 'Bigl', 'Bigr',
                    'biggl', 'biggr', 'Biggl', 'Biggr', 'middle', 'hfill'):
            return '', i
        if name in ('left', 'right'):
            if i < len(s) and s[i] == '.':
                i += 1
            return '', i
        if name in ('hspace', 'vspace'):
            if i < len(s) and s[i] == '{':
                a, i = self.group(s, i)
            return 'thin', i
        if name == 'textcolor':
            a, i = self.group(s, i)
            b, i = self.group(s, i)
            return b, i
        if name == 'label':
            if i < len(s) and s[i] == '{':
                raw, i = self.read_brace(s, i)
            else:
                raw, i = (s[i], i + 1) if i < len(s) else ('', i)
            return '\x00LABEL:' + raw + '\x00', i
        if name in ('nonumber', 'notag'):
            return '\x00NONUMBER\x00', i
        if name in ('tag', 'displaystyle', 'textstyle', 'limits', 'nolimits'):
            if name == 'tag' and i < len(s) and s[i] == '{':
                a, i = self.group(s, i)
            return '', i
        if name in ('begin', 'end'):
            if i < len(s) and s[i] == '{':
                a, i = self.group(s, i)
            return '', i
        if name == 'substack':
            a, i = self.group(s, i)
            return self.conv(a), i
        if name not in SYM:
            for pre in ('lVert', 'rVert', 'lvert', 'rvert', 'langle', 'rangle',
                        'ldots', 'cdots', 'vdots', 'ddots'):
                if name.startswith(pre) and len(name) > len(pre):
                    return SYM[pre] + ' ' + name[len(pre):], i
        return self.cmd_text(name), i


PROTECT_WORDS = set()
for _v in SYM.values():
    if _v and re.fullmatch(r'[A-Za-z]+(?:\.[A-Za-z]+)*', _v):
        PROTECT_WORDS.add(_v)
for _v in FUNC1.values():
    PROTECT_WORDS.add(_v)
PROTECT_WORDS.update({'frac', 'sqrt', 'root', 'cases', 'mat', 'binom', 'op', 'text', 'upright',
                      'thin', 'med', 'thick', 'quad', 'space', 'limit', 'cond', 'accent'})


def finish(txt):
    store = []

    def keep(m):
        store.append(m.group(0))
        return '\x02' + chr(0xE000 + len(store) - 1) + '\x03'

    txt = re.sub(r'"[^"]*"', keep, txt)
    txt = re.sub(r'\d+(?:\.\d+)?', keep, txt)
    for w in sorted(PROTECT_WORDS, key=len, reverse=True):
        txt = re.sub(r'(?<![A-Za-z0-9])' + re.escape(w) + r'(?![A-Za-z0-9])', keep, txt)
    txt = txt.replace('.', ' . ')
    txt = re.sub(r'[A-Za-z]{2,}', lambda m: ' '.join(m.group(0)), txt)
    txt = re.sub('\x02([\ue000-\uf8ff])\x03', lambda m: store[ord(m.group(1)) - 0xE000], txt)
    return txt


def decode(s):
    # The converter doubled every backslash and backslash-escaped specials,
    # so: 4 backslashes = LaTeX row break, 2 backslashes = one real backslash,
    # and a single \_ \% \# \& comes from the bare character.
    out = []
    i, n = 0, len(s)
    while i < n:
        if s.startswith('\\\\\\\\', i):
            out.append('\\\\'); i += 4
        elif s.startswith('\\\\{', i):
            out.append('\\{'); i += 3
        elif s.startswith('\\\\}', i):
            out.append('\\}'); i += 3
        elif s.startswith('\\\\', i):
            out.append('\\'); i += 2
        elif s.startswith('\\_', i) or s.startswith('\\%', i) or s.startswith('\\#', i) or s.startswith('\\&', i):
            out.append(s[i + 1]); i += 2
        else:
            out.append(s[i]); i += 1
    return ''.join(out)


def convert_block(lines):
    body = '\n'.join(lines)
    body = body.strip()
    assert body.startswith('\\$\\$') or body.startswith('$')
    body = body[4:] if body.startswith('\\$\\$') else body[1:]
    body = body[:-4] if body.endswith('\\$\\$') else body.rstrip('$')
    body = decode(body)
    c = Conv()
    txt = c.conv(body)
    labels = re.findall(r'\x00LABEL:([^\x00]*)\x00', txt)
    txt = re.sub(r'\x00LABEL:[^\x00]*\x00', '', txt)
    txt = txt.replace('\x00NONUMBER\x00', '')
    txt = finish(txt)
    # collapse whitespace but keep line breaks from \\
    txt = re.sub(r'[ \t]+', ' ', txt)
    txt = re.sub(r' *\n *', '\n', txt).strip()
    # remove empty lines
    lines_out = [l.strip() for l in txt.split('\n') if l.strip()]
    txt = ' \\\n'.join(lines_out)
    # normalize alignment: '&' inside line
    txt = re.sub(r'&\s*', '& ', txt)
    return txt, labels, c.unknown


def main():
    path = sys.argv[1]
    dry = '--dry' in sys.argv
    L = open(path, encoding='utf-8').read().split('\n')
    out = []
    i = 0
    unknown = set()
    count = 0
    while i < len(L):
        if L[i].startswith('\\$\\$'):
            j = i
            while j < len(L) and not (j > i and L[j].rstrip().endswith('\\$\\$')):
                j += 1
            if L[i].rstrip().endswith('\\$\\$') and j == i:
                j = i
            block = L[i:j + 1]
            txt, labels, unk = convert_block(block)
            unknown |= unk
            labtxt = ''.join(' <%s>' % re.sub(r'[^A-Za-z0-9:._-]', '', l.replace('\\', '')) for l in labels)
            new = '$ ' + txt + ' $' + labtxt
            if dry:
                print('####', i + 1, j + 1)
                print(new.encode('ascii', 'backslashreplace').decode())
            out.append(new)
            count += 1
            i = j + 1
            continue
        out.append(L[i])
        i += 1
    print('converted', count, 'blocks; unknown:', sorted(unknown))
    if not dry:
        open(path, 'w', encoding='utf-8').write('\n'.join(out))


if __name__ == '__main__':
    main()
