# -*- coding: utf-8 -*-
import io
BS = chr(92)
lines = io.open('main.typ', encoding='utf-8').read().split('\n')
for i, t in enumerate(lines, 1):
    ds = 0
    j = 0
    while j < len(t):
        if t[j] == BS:
            j += 2
            continue
        if t[j] == '$':
            ds += 1
        j += 1
    if ds % 2:
        print(i, ds, t[:160])
