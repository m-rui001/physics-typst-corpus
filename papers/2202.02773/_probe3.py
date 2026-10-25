L = open('main.typ', encoding='utf-8').read().split('\n')
open('_t.typ', 'w', encoding='utf-8').write('\n'.join(L[14:105]) + '\n')
print(repr(L[17][-120:]))
print(len(L[17]))
