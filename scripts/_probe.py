import sys, re
sys.path.insert(0, 'scripts')
import escmath2 as E, resplice

s = open('papers/2308.08546/main.typ', encoding='utf-8').read()
i = s.find('begin{equation}')
a = s.rfind(E.B + '$' + E.B + '$', 0, i)
b = s.find(E.B + '$' + E.B + '$', i)
raw = E.unesc(s[a + 4:b])
raw = E.ENV.sub(r"\\begin{aligned}", raw)
raw = E.ENVEND.sub(r"\\end{aligned}", raw)
raw = re.sub(r"\\label\{[^}]*\}", "", raw)
raw = re.sub(r'\{"([^{}"]*)"\}', r"\\text{\1}", raw)
raw = re.sub(r'"([^"{}]*)"', r"\\text{\1}", raw)
raw = raw.replace("\\*", "*")
print('STAGE', repr(raw[:260]))
out, err = resplice._conv('$' + raw + '$', 'papers/2308.08546/_work')
print('ERR', err[:700])
print('OUT', repr(out[:200]))
