p = r"E:\phys\papers\2104.04119\main.typ"
s = open(p, encoding="utf-8").read()
for key in ['sum_{i < j}', 'product_{i in S}', 'sum_{i in cal(D)}']:
    n = s.count(key)
    print(key, n)
