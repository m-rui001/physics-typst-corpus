import io, shutil
p = r'E:\phys\papers\2107.10113\main.typ'
old = io.open(p + '.presection3', encoding='utf-8').read().split('\n')
new = io.open(r'E:\phys\tmp\conv10113b\main.typ', encoding='utf-8').read()
new = new.replace('"imgs/', '"figures/').split('\n')
oi = next(i for i, l in enumerate(old) if l.startswith('= Introduction'))
ni = next(i for i, l in enumerate(new) if l.startswith('= Introduction'))
shutil.copy(p, p + '.prebalsplice')
out = old[:oi] + new[ni:]
io.open(p, 'w', encoding='utf-8', newline='\n').write('\n'.join(out))
print('front', oi, 'body', len(new) - ni, 'total', len(out))
