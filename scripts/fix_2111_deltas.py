import io, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2111.14241/main.typ'
s = io.open(p, encoding='utf-8').read()
io.open(p + '.predeltasplit', 'w', encoding='utf-8').write(s)
a = '$ Delta cal(S)_x = & sqrt(frac(N S, 2)) sqrt(cosh^2 r + sinh^2 r - 2 sinh r cosh r cos theta)'
assert s.count(a) == 1
i = s.find(a)
end = '$<sq:eq:deltasx>'
j = s.find(end, i) + len(end)
blk = s[i:j]
sep = ' \\\n'
lines = blk.split(sep)
assert len(lines) == 2, len(lines)
x = lines[0].replace(' = & ', ' = ').rstrip()
if x.endswith('\\'):
    x = x[:-1].rstrip()
assert x.endswith(',')
x = x + ' $<sq:eq:deltasx>'
y = lines[1]
assert y.startswith('Delta cal(S)_y = & '), y[:40]
y = y.replace(' = & ', ' = ', 1)
assert y.endswith('$<sq:eq:deltasx>')
y = '$ ' + y[:-len(end)] + '$<sq:eq:deltasy>'
s = s[:i] + x + '\n' + y + s[j:]
s = s.replace('[@sq:eq:deltasx and [[sq:eq:deltasy]]]',
              '[@sq:eq:deltasx and @sq:eq:deltasy]')
s = s.replace('$theta eq.not 0   pi$', '$theta eq.not 0, pi$')
io.open(p, 'w', encoding='utf-8').write(s)
print('split ok')
