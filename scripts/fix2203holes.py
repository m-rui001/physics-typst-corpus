import re
p = r"E:\phys\papers\2203.02139\main.typ"
s = open(p, encoding="utf-8").read()
lines = s.split("\n")

def line_fix(i, fn):
    lines[i-1] = fn(lines[i-1])

line_fix(25, lambda l: l.replace("@Asai2020#text([])#text([]).", "@Asai2020."))
line_fix(29, lambda l: l.replace("@Gando2019" + "#text([])"*5, "@Gando2019"))
line_fix(33, lambda l: l.replace("@Allison2006#text([])", "@Allison2006"))
line_fix(53, lambda l: l.replace("@Frekers2013#text([])", "@Frekers2013"))
line_fix(55, lambda l: l.replace("@Zhang2016" + "#text([])"*5, "@Zhang2016"))
line_fix(59, lambda l: l.replace("@Ferrari:898301#text([])", "@Ferrari:898301").replace("@Napolitani2007#text([])", "@Napolitani2007"))

def cap111(l):
    l = l.replace('$""^"130""Te"$#text([])', '$""^"130""Te"$~@Adams2022')
    l = l.replace("(b) Ref.#text([])", "(b) Ref.~@Asaka2020")
    return l.replace("#text([])", "")

def par116(l):
    l = l.replace("theoretical models" + "#text([])"*3, "theoretical models~@Harigaya2012 @Asaka2020 @Asai2020")
    return l.replace("#text([])", "")

line_fix(111, cap111)
line_fix(116, par116)
line_fix(118, lambda l: l.replace("#text([])", ""))

s = "\n".join(lines)
print("remaining holes:", s.count("#text([])"))
open(p, "w", encoding="utf-8", newline="\n").write(s)
