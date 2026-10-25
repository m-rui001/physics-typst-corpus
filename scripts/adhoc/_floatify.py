import io, os, re, sys, shutil

def find_figs(s):
    out = []
    i = 0
    while True:
        j = s.find('#figure(', i)
        if j < 0:
            break
        ls = s.rfind('\n', 0, j) + 1
        if s[ls:j].lstrip().startswith('//'):
            i = j + 8
            continue
        k = j + len('#figure(')
        depth = 1
        in_str = False
        esc = False
        while k < len(s) and depth:
            c = s[k]
            if in_str:
                if esc: esc = False
                elif c == '\\': esc = True
                elif c == '"': in_str = False
            else:
                if c == '"': in_str = True
                elif c == '(' or c == '[': depth += 1
                elif c == ')' or c == ']': depth -= 1
            k += 1
        out.append((j, k, s[j:k]))
        i = k
    return out

WIDE = re.compile(r'width:\s*(?:100(?:\.0+)?|[789]\d(?:\.\d+)?)\s*%')
def is_wide(body):
    return bool(WIDE.search(body)) or 'scope: "parent"' in body or body.count('image(') >= 2

def process(path, apply=False):
    s = io.open(path, encoding='utf-8').read()
    figs = find_figs(s)
    todo = [(a, b, body) for a, b, body in figs if is_wide(body) and 'placement:' not in body]
    if not todo:
        return 0, len(figs)
    print(os.path.basename(os.path.dirname(path)), 'wide', len(todo), 'of', len(figs))
    if apply:
        shutil.copyfile(path, path + '.prefloat')
        for a, b, body in reversed(todo):
            s = s[:a + len('#figure(')] + 'placement: top, ' + s[a + len('#figure('):]
        io.open(path, 'w', encoding='utf-8', newline='\n').write(s)
    return len(todo), len(figs)

if __name__ == '__main__':
    apply = 'apply' in sys.argv
    only = [x for x in sys.argv[1:] if x != 'apply']
    import glob
    paths = [r'E:\phys\papers\%s\main.typ' % p for p in only] if only else glob.glob(r'E:\phys\papers\*\main.typ')
    tot = 0
    for p in paths:
        n, _ = process(p, apply)
        tot += n
    print('wide total', tot)
