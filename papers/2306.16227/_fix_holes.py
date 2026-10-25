import re, shutil, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()
shutil.copy(p, p + '.precitesilent')

reps = [
 ("the Chinese PTA  Although",
  "the Chinese PTA @2016ASPC..502...19L. Although"),
 ("$4 sigma$@wm3 @ng15yr @pptadr3 @cptadr1   , strongly",
  "$4 sigma$ @wm3 @ng15yr @pptadr3 @cptadr1, strongly"),
 ("continuous GWs    emerging from the GWB.",
  "continuous GWs @2009mnras.394.2255s @Babak:2011mr @2018MNRAS.477..964K emerging from the GWB."),
 ("quadrupolar correlation  of the common",
  "quadrupolar correlation (usually referred to as HD correlation, from @hd1983) of the common"),
 ("prior to merger   Moreover",
  "prior to merger (e.g. @2017MNRAS.469.4437C @2018Natur.563..214K). Moreover"),
 ("using @eq:sh and  The full procedure is described in @2010MNRAS.402.2308A. @2020PhRvD.102j3023B.",
  "using @eq:sh and @eq:RMS. The full procedure is described in @2010MNRAS.402.2308A @2020PhRvD.102j3023B."),
 ("at sub-pc scales  While",
  "at sub-pc scales (see e.g. @2012JPhCS.363a2035R). While"),
 ("$e approx 0.4 - 0.6$@2011mnras.415.3033r @2021apj...914l..21d,",
  "$e approx 0.4 - 0.6$ @2011mnras.415.3033r @2021apj...914l..21d,"),
 ("extremely eccentric systems @1996newa....1...35q A large",
  "extremely eccentric systems @2010apj...719..851s. A large"),
 ("frequency scale considered    However",
  "frequency scale considered (see e.g. @2021PhLB..81536137G @2023MNRAS.520.1757G @2022PhRvD.106f3512A). However"),
 ("using @2016phrvx...6a1035l @2018cqgra..35p3001c @2018cqgra..35p3001c.",
  "using @2016phrvx...6a1035l @2018cqgra..35p3001c."),
 ("reveal themselves in the data     While",
  "reveal themselves in the data (e.g. @2013CQGra..30v4005C @2013PhRvD..88h4001T @2020PhRvD.102h4039T @2022ApJ...940..173P). While"),
 ("@2014mnras.439.3986r @2017natas...1..886m @2017natas...1..886m.",
  "@2014mnras.439.3986r @2017natas...1..886m."),
]

for old, new in reps:
    n = s.count(old)
    print(n, repr(old[:60]))
    if n != 1:
        sys.exit('count mismatch')
    s = s.replace(old, new)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
