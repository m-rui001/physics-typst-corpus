import io
import shutil

p = r"E:\phys\papers\2107.00087\main.typ"
shutil.copyfile(p, p + r".precite")
s = io.open(p, encoding="utf-8").read()
pairs = [
    ("are said to belong to the #emph[swampland] \n",
     "are said to belong to the #emph[swampland] @swampland.\n"),
    ("to consider the case of a global $S U ( 2 )$ States in that theory",
     "to consider the case of a global $S U ( 2 )$ @OoguriCERN. States in that theory"),
    ("extended @Gaiotto:2014kfa @Heidenreich:2020pkc.",
     "extended @Gaiotto:2014kfa @Heidenreich:2020pkc @Heidenreich:2021tna."),
    ("as discussed in detail in @Lanza:2020qmt.",
     "as discussed in detail in @Lanza:2020qmt @Lanza:2021qsu."),
    ("Weak Gravity Conjecture in AdS @Crisford:2017zpi @Crisford:2017gsb.",
     "Weak Gravity Conjecture in AdS @Crisford:2017zpi @Crisford:2017gsb @Horowitz:2019eum."),
]
for old, new in pairs:
    n = s.count(old)
    assert n == 1, (old[:50], n)
    s = s.replace(old, new)
io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
