import io, os, re, sys, shutil, glob

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
                elif c in '([': depth += 1
                elif c in ')]': depth -= 1
            k += 1
        out.append((j, k, s[j:k]))
        i = k
    return out

def process(path, apply=False, mode='all'):
    s = io.open(path, encoding='utf-8').read()
    two_col = bool(re.search(r'columns:\s*2', s)) or bool(re.search(r'#columns\(2', s))
    if two_col and mode == 'all1':
        return 0
    figs = find_figs(s)
    todo = []
    for a, b, body in figs:
        if 'placement:' in body:
            continue
        if mode == 'all' or mode == 'all1':
            if 'table(' in body and 'image(' not in body:
                continue
            todo.append((a, b, body))
    if todo:
        print(os.path.basename(os.path.dirname(path)), 'todo', len(todo), 'of', len(figs), 'twocol', two_col)
    if apply and todo:
        shutil.copyfile(path, path + '.prefloat2')
        for a, b, body in reversed(todo):
            s = s[:a + len('#figure(')] + 'placement: top, ' + s[a + len('#figure('):]
        io.open(path, 'w', encoding='utf-8', newline='\n').write(s)
    return len(todo)

if __name__ == '__main__':
    apply = 'apply' in sys.argv
    mode = 'all1' if 'all1' in sys.argv else 'all'
    only = [x for x in sys.argv[1:] if not x.startswith('all') and x != 'apply']
    paths = [r'E:\phys\papers\%s\main.typ' % p for p in only] if only else sorted(glob.glob(r'E:\phys\papers\*\main.typ'))
    tot = 0
    for p in paths:
        tot += process(p, apply, mode)
    print('total', tot)
