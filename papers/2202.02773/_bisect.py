import subprocess, os
L = open('_t.typ', encoding='utf-8').read().split('\n')
head = L[:7]      # up to #text(7pt)[
tail = L[-1:]     # final ]
affs = L[7:-3]    # affiliation lines (last lines: '  ]', '  ', ']')
print('aff lines', len(affs))
# find culprit: compile prefixes; the first prefix that fails with unclosed at 7:12

def ok(n):
    body = head + affs[:n] + ['  ]']
    open('_b.typ', 'w', encoding='utf-8').write('\n'.join(body))
    r = subprocess.run(['typst', 'compile', '--root', 'E:/phys', '_b.typ', '_b.pdf'],
                       capture_output=True, text=True)
    return r.returncode == 0, r.stderr

lo, hi = 0, len(affs)
print('full ok?', ok(hi)[0])
if not ok(hi)[0]:
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if ok(mid)[0]:
            lo = mid
        else:
            hi = mid
    print('first failing prefix ends at aff line', hi)
    print(repr(affs[hi - 1]))
