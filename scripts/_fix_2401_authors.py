p = 'papers/2401.15951/main.typ'
s = open(p, encoding='utf-8').read()
a1 = 'Jie Zhang#super[1], Gang Xia#super[1], Chun-Wang Wu#super[1], Ting Chen#super[1], Qian Zhang#super[4], Yi Xie#super[1], Wen-Bo Su#super[1], Wei Wu#super[1], Cheng-Wei Qiu#super[5], Ping-Xing Chen#super[1], Weibin Li#super[6], Hui Jing#super[4], Yan-Li Zhou#super[1]'
dup = a1 + ', ' + a1
assert s.count(dup) == 1
s = s.replace(dup, a1)
open(p, 'w', encoding='utf-8').write(s)
print('authors deduped')
