import re, io, subprocess, sys
B = chr(92)
s = io.open('papers/2202.13919/_work/body.tex', encoding='utf-8').read()
# take paragraph containing free EM field
i = s.find('The action of a free EM field')
j = s.find('\n\n', i)
para = s[i:j]

SW = {'cal': 'mathcal', 'rm': 'mathrm', 'bf': 'mathbf', 'it': 'mathit', 'sf': 'mathsf', 'tt': 'mathtt'}

def norm(t):
    def grp(m):
        return B + SW[m.group(1).lstrip(chr(92))] + '{' + m.group(2).strip() + '}'
    t = re.sub(r'\{(\\cal|\\rm|\\bf|\\it|\\sf|\\tt)\s+([^{}]*)\}', grp, t)
    t = re.sub(r'\\(cal|rm|bf|it|sf|tt)\s+([A-Za-z0-9])', lambda m: B + SW[m.group(1)] + '{' + m.group(2) + '}', t)
    t = re.sub(re.escape(B) + r'(tilde|hat|bar|vec|dot|ddot)\s+([A-Za-z0-9])', lambda m: B + m.group(1) + '{' + m.group(2) + '}', t)
    return t

out = subprocess.run(['pandoc', '-f', 'latex', '-t', 'typst', '--wrap=none'],
                     input=norm(para), capture_output=True, text=True, encoding='utf-8')
print(out.stdout)
print('RC', out.returncode)
print(out.stderr[:500])
