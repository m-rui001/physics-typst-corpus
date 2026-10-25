import io
p = r'E:\phys\papers\2104.02565\main.typ.new'
s = io.open(p, encoding='utf-8').read()
n = s.count('$^')
s = s.replace('$^', '$" "^')
io.open(p, 'w', encoding='utf-8', newline='').write(s)
print('patched', n)
