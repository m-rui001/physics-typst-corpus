import io, os, shutil
p = r'E:\phys\papers\2107.10113'
src = r'E:\phys\tmp\conv10113\main.typ'
old = os.path.join(p, 'main.typ')
new = io.open(src, encoding='utf-8').read().replace('imgs/', 'figures/')
bak = os.path.join(p, 'main.typ.presection3')
if not os.path.exists(bak):
    shutil.copy2(old, bak)
io.open(old, 'w', encoding='utf-8', newline='\n').write(new)
print('old lines', sum(1 for _ in io.open(bak, encoding='utf-8')))
print('new lines', new.count('\n'))
