import io
p = r'E:\phys\papers\2312.03982\main.typ'
s = io.open(p, encoding='utf-8').read()
pairs = [
    ('I I Z Z, Z I I Z, I Z I Z', 'I I Z Z}$ $Z I I Z, I Z I Z'),
    ('X X Y Y, Y Y X X, Y X Y X', 'X X Y Y}$ $Y Y X X, Y X Y X'),
]
for old, new in pairs:
    assert s.count(old) == 1, (old, s.count(old))
    s = s.replace(old, new)
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('ok')
