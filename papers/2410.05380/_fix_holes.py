import shutil, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()
shutil.copy(p, p + '.preholes')

reps = [
 ("Standard Solar Models @Esteban:2020cvm    are now",
  "Standard Solar Models @B23Fluxes are now"),
 ("Super-Kamiokande @Super-Kamiokande:2023jbt    together",
  "Super-Kamiokande @Super-Kamiokande:2023jbt together"),
 ("phase-IV of Super-Kamiokande @Super-Kamiokande:2023jbt, and the final spectra from Borexino phases-II @Super-Kamiokande:2023jbt    and III",
  "phase-IV of Super-Kamiokande @Cravens:2008aa, and the final spectra from Borexino phases-II @Borexino:2017rsf and III"),
 ("Borexino phases-II @Super-Kamiokande:2023jbt    and III",
  "Borexino phases-II @Borexino:2017rsf and III"),
 ("results from SNO+@DayaBay:2021dqj#cite(<SNO-:nu24>)#cite(<SNO-poster:nu24>)",
  "results from SNO+#cite(<SNO:2024wzq>, <SNO-:nu24>, <SNO-poster:nu24>)"),
 ("@DayaBay:2022orm.  Updates",
  "@DayaBay:2022orm. Updates"),
 ("@IceCube:2019dyb @IceCube:2019dqi  has",
  "@IceCube:2019dyb @IceCube:2019dqi has"),
 ("@IceCube:2019dyb @IceCube:2019dqi  plays",
  "@IceCube:2019dyb @IceCube:2019dqi plays"),
 ("@IceCube:2024xjj @IC:data2024  with",
  "@IceCube:2024xjj @IC:data2024 with"),
 ("@Esteban:2020cvm.    In brief",
  "@B23Fluxes. In brief"),
 ("@Vinyoles:2016djt.   On this front",
  "@Vinyoles:2016djt. On this front"),
]

for item in reps:
    old, new = item[0], item[1]
    want = item[2] if len(item) > 2 else 1
    n = s.count(old)
    print(n, repr(old[:60]))
    if n != want:
        sys.exit('count mismatch: ' + old[:40])
    s = s.replace(old, new)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
