import io, shutil
p = r'E:\phys\papers\2104.04119\main.typ'
s = io.open(p, encoding='utf-8').read()
shutil.copyfile(p, p + '.pregord')
reps = [
    ('$ G^("X")(2) = ⟨X_1 X_2⟩', '$ G^((2))_X = ⟨X_1 X_2⟩'),
    ('$ G^("Z")(2) = ⟨Z_1 Z_2⟩', '$ G^((2))_Z = ⟨Z_1 Z_2⟩'),
    ('$ G^("X")(3) = ⟨X_1 X_2 X_3⟩ - G^("X")(2)_12 ⟨X_3⟩ \\\n  quad - G^("X")(2)_23 ⟨X_1⟩ - G^("X")(2)_31 ⟨X_2⟩',
     '$ G^((3))_X = ⟨X_1 X_2 X_3⟩ - G^((2))_(X,12) ⟨X_3⟩ \\\n  quad - G^((2))_(X,23) ⟨X_1⟩ - G^((2))_(X,31) ⟨X_2⟩'),
    ('where $G^("X")(2)_"ij"$', 'where $G^((2))_(X,ij)$'),
]
for old, new in reps:
    n = s.count(old)
    print(n, old[:40].replace('\n', ' '))
    s = s.replace(old, new)
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
