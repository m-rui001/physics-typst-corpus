import io, re, sys
path = sys.argv[1]
s = io.open(path, encoding='utf-8').read()
# escape percent signs that follow a digit (percent is a comment char in Typst)
s = re.sub(r'(?<!\\)([0-9])%', r'\1\\%', s)
io.open(path, 'w', encoding='utf-8', newline='\n').write(s)
print('percents:', s.count('\\%'))
