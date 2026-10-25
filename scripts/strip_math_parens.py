import os, shutil

ROOT = 'E:/phys/papers'

def strip_outer(s):
    n = 0
    out = []
    i = 0
    while i < len(s):
        if s[i] in '_^' and i + 2 < len(s) and s[i+1] == '(' and s[i+2] in '( ':
            # require immediate '(' (allow spaces is risky; only exact '(')
            if s[i+2] != '(':
                out.append(s[i]); i += 1; continue
            depth = 0
            j = i + 1
            end = -1
            while j < len(s):
                c = s[j]
                if c == '(':
                    depth += 1
                elif c == ')':
                    depth -= 1
                    if depth == 0:
                        end = j
                        break
                j += 1
            if end > 0:
                out.append(s[i] + '(' + s[i+3:end])
                n += 1
                i = end + 1
                continue
        out.append(s[i])
        i += 1
    return ''.join(out), n

total = 0
for paper in sorted(os.listdir(ROOT)):
    path = os.path.join(ROOT, paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = open(path, encoding='utf-8').read()
    out, n = strip_outer(s)
    if n:
        b = path + '.premathparen'
        if not os.path.exists(b):
            shutil.copy2(path, b)
        open(path, 'w', encoding='utf-8', newline='').write(out)
        print(paper, n)
    total += n
print('TOTAL', total)
