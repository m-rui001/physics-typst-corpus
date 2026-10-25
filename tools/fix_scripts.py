import sys, pathlib

def scan(text, stop_dollar):
    out = []
    i = 0
    n = len(text)
    math = False
    cnt = 0
    while i < n:
        c = text[i]
        if not math and c == '/' and i + 1 < n and text[i + 1] == '/':
            j = text.find('\n', i)
            if j < 0:
                out.append(text[i:]); break
            out.append(text[i:j]); i = j; continue
        if c == '\\' and i + 1 < n:
            if math and text[i + 1] in '_^' and i + 2 < n and text[i + 2] == '{':
                k = match_brace(text, i + 2)
                if k is not None:
                    inner = text[i + 3:k].strip()
                    while inner.startswith('{') and inner.endswith('}'):
                        inner = inner[1:-1].strip()
                    out.append(text[i + 1] + '(' + inner + ')')
                    i = k + 1; cnt += 1; continue
            out.append(text[i:i + 2]); i += 2; continue
        if c == '$':
            math = not math
            out.append(c); i += 1; continue
        if math and c in '_^' and i + 1 < n and text[i + 1] == '{':
            k = match_brace(text, i + 1)
            if k is not None:
                inner = text[i + 2:k].strip()
                while inner.startswith('{') and inner.endswith('}'):
                    inner = inner[1:-1].strip()
                out.append(c + '(' + inner + ')')
                i = k + 1; cnt += 1; continue
        out.append(c); i += 1
    return ''.join(out), cnt

def match_brace(text, i):
    depth = 0
    n = len(text)
    k = i
    while k < n:
        ch = text[k]
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
            if depth == 0:
                return k
        elif ch == '\n' and depth > 0:
            pass
        k += 1
    return None

total = 0
for arg in sys.argv[1:]:
    p = pathlib.Path(arg)
    text = p.read_text(encoding='utf-8')
    new, c = scan(text, True)
    if c:
        bak = p.with_suffix(p.suffix + '.prescripts')
        if not bak.exists():
            bak.write_text(text, encoding='utf-8')
        p.write_text(new, encoding='utf-8')
    print(p.parent.name, c, flush=True)
    total += c
print('TOTAL', total)
