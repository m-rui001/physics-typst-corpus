import io
old = io.open(r'E:\phys\papers\2107.10113\main.typ.presection3', encoding='utf-8').read().split('\n')
new = io.open(r'E:\phys\papers\2107.10113\main.typ', encoding='utf-8').read().split('\n')
oi = next(i for i, l in enumerate(old) if l.startswith('= Introduction'))
ni = next(i for i, l in enumerate(new) if l.startswith('= Introduction'))
out = old[:oi] + new[ni:]
io.open(r'E:\phys\papers\2107.10113\main.typ', 'w', encoding='utf-8', newline='\n').write('\n'.join(out))
print('front', oi, 'body', len(new) - ni, 'total', len(out))
