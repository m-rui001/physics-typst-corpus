import shutil, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()
shutil.copy(p, p + '.preholes3')

reps = [
 ("amplitude of such a GWB  (and references therein).",
  "amplitude of such a GWB (see e.g. @2018cqgra..35p3001c, and references therein)."),
 ("@Hindmarsh:1994re   they are generic",
  "@Hindmarsh:1994re; they are generic"),
 ("in EPTA @Auclair:2019wcv , in NANOGrav  and PPTA",
  "in EPTA @Sanidas:2012ee @Leclere:2023ryt, in NANOGrav @Blasi:2020mfx @Ellis:2020ena and PPTA"),
 ("should smooth out the loops  (for a similar approach).",
  "should smooth out the loops (see the LVK analysis, @LIGOScientific:2021nrg, for a similar approach)."),
 ("some models of inflation     (and references therein) make it possible",
  "some models of inflation (see, for example, @2018jcap...07..007d @2019jcap...06..028b @2020jcap...08..001b @2023epjc...83...82y, and references therein) make it possible"),
 ("cold dark matter candidates  (and reference therein).",
  "cold dark matter candidates @2016PhRvD..94h3504C (and reference therein)."),
]

for old, new in reps:
    n = s.count(old)
    print(n, repr(old[:60]))
    if n != 1:
        sys.exit('count mismatch: ' + old[:40])
    s = s.replace(old, new)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
