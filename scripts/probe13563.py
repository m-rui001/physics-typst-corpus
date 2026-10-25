import sys

path = r"E:\phys\papers\2107.13563\main.typ"
s = open(path, encoding="utf-8").read()

def find_close(s, ob):
    depth = 0
    i = ob
    while i < len(s):
        c = s[i]
        if c == "\\\\"[0]:
            i += 2
            continue
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                return i
        i += 1

p = s.index('#place(top')
ob = s.index('[', p)
cb = find_close(s, ob)
print("place close line", s[:cb].count("\n") + 1)
print("context:", repr(s[cb-60:cb+20]))
c = s.index('#columns(2', p)
ob2 = s.index('[', c)
cb2 = find_close(s, ob2)
print("columns close line", s[:cb2].count("\n") + 1, "after place?", cb2 > cb)
