import subprocess
L = open('_t.typ', encoding='utf-8').read().split('\n')
head = L[:7]
affs = L[7:-3]
print('aff count', len(affs))

def run(lines):
    open('_b.typ', 'w', encoding='utf-8').write('\n'.join(lines))
    r = subprocess.run(['typst', 'compile', '--root', 'E:/phys', '_b.typ', '_b.pdf'],
                       capture_output=True, text=True, encoding='utf-8', errors='replace')
    return r.returncode == 0, (r.stderr or '').split('\n')[0]

print('author only:', run(L[:5] + ['  #v(0.8em)', ']']))
print('with 1 aff:', run(head + [affs[0]] + ['  ]', ']']))
lo, hi = 0, len(affs)
while hi - lo > 1:
    mid = (lo + hi) // 2
    good, msg = run(head + affs[:mid] + ['  ]', ']'])
    if good:
        lo = mid
    else:
        hi = mid
        print('fail at', mid, msg)
print('last ok', lo, 'first bad', hi)
print('BAD:', repr(affs[hi - 1]))
