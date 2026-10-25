import io
base = r'E:\phys\papers\2104.02565'
O = io.open(base + r'\main.typ.pre_rebuild', encoding='utf-8').read().split('\n')
N = io.open(base + r'\main.typ.new', encoding='utf-8').read().split('\n')
O = [l.replace('[vspace1cm]', '[JUNO Physics and Detector]')
      .replace('JUNO Collaboration~citejunocollaboration', 'JUNO Collaboration') for l in O]
# abstract in the new file sits between the two calls; find it
a = next(i for i, l in enumerate(N) if '*Abstract.*' in l)
abs_block = ['#align(center)[', N[a], ']']
j = next(i for i, l in enumerate(O) if l.startswith('= '))
# keep O up to the line after `#v(1.6em)`, then drop old paragraphs
k = next(i for i, l in enumerate(O) if l.strip() == '#v(1.6em)')
out = O[:k + 1] + ['', *abs_block, ''] + O[j:]
io.open(base + r'\main.typ.splice', 'w', encoding='utf-8', newline='').write('\n'.join(out))
print('old heading', j + 1, 'new head lines', len(out))
