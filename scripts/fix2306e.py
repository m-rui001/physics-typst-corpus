# -*- coding: utf-8 -*-
import io, os, re, shutil

d = r"E:\phys\papers\2306.03903"
p = os.path.join(d, "main.typ")
bak = os.path.join(d, "_work", "main.pre_holes.typ")
if not os.path.exists(bak):
    shutil.copy(p, bak)

s = io.open(p, encoding="utf-8").read()

ads = [
 "1974AandA....37..225M", "1977AandA....56..377C", "1980AandA....81..263O",
 "1985AandA...149..408I", "1986AandA...166...36K", "1993AandA...279....1S",
 "2003AandA...399...23Z", "2007AandA...469..387T", "2015AandA...573A..57M",
 "2016ARAandA..54..401O", "2019ARAandA..57..375S", "2020AandA...636A..20W",
 "2020AandA...641A...6P", "2022AandA...664A.106B",
]
doi = {
 "/mnras/staa972": "10.1093-mnras-staa972",
 "/j.1365-8711.2003.06828.x": "10.1046-j.1365-8711.2003.06828.x",
 "/mnras/189.1.123": "10.1093-mnras-189.1.123",
 "/mnras/194.3.639": "10.1093-mnras-194.3.639",
}

pairs = {}
for k in ads:
    k2 = k.replace("AandA", "A&A")
    pairs[k2[k2.index("&"):]] = k
pairs.update(doi)

# specific holes first
specific = [
 ("#text([]), #text([])) naturally", "(#ref(<eq:cosmomerg>), #ref(<eq:ratescatpure2>))) naturally"),
 ("at large scales#text([]) $", "at large scales~@1976ApJ...203..297S: $"),
 ("in Tab.#text([]).", "in Tab.~@tab:candidate."),
 ("shown in Tab.#text([]) but", "shown in Tab.~@tab:candidate but"),
 ("are shown in Tab.#text([]).", "are shown in Tab.~@tab:candidate."),
 ("axion-like particles#text([])", "axion-like particles~@1978PhRvL..40..223W"),
 ("analysed in Ref.#text([])", "analysed in Ref.~@Bodeker:2020stj"),
]
for a, b in specific:
    if a not in s:
        print("MISS:", a[:50])
    s = s.replace(a, b)

# generic remnant holes
count = 0
for remnant in sorted(pairs, key=len, reverse=True):
    needle = "#text([])" + remnant
    c = s.count(needle)
    if c:
        s = s.replace(needle, "@" + pairs[remnant])
        count += c

io.open(p, "w", encoding="utf-8", newline="\n").write(s)
left = s.count("#text([])")
print("generic replaced", count, "left", left)
