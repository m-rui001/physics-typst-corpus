import io, re, shutil

p = r'E:/phys/papers/2410.05380/main.typ'
s = io.open(p, encoding='utf-8').read()
shutil.copyfile(p, p + '.preMO2')

reps = [
 ('6.1$, see Sec.\n', '6.1$, see Sec.~@sec:global24.\n'),
 ('== Sensitivity to the  mass ordering\n== Sensitivity to the neutrino mass ordering <sec:MO>',
  '== Sensitivity to the neutrino mass ordering <sec:MO>'),
 (' $T equiv Delta chi_(upright("IO,NO"))^2 equiv chi_(upright("min,IO"))^2 - chi_(upright("min,NO"))^2 #h(0.17em) .$',
  '$ T equiv Delta chi_(upright("IO,NO"))^2 equiv chi_(upright("min,IO"))^2 - chi_(upright("min,NO"))^2 . $'),
 ('and the global $chi^2$ is given by $chi^2 = chi^2 #scale(x: 120%, y: 120%)[[] p_i ( o theta ) #h(0.17em) d_i #scale(x: 120%, y: 120%)[]]$, then',
  'and the global $chi^2$ is given by $chi^2 = chi^2 [ p_i (o, theta) ; d_i ]$, then'),
 ('@tab:bfranges24\\; we comment on this assumption in @tab:bfranges24.',
  '@tab:bfranges24; we comment on this assumption in Appendix~@sec:app-T.'),
]
for old, new in reps:
    assert s.count(old) == 1, (old[:40], s.count(old))
    s = s.replace(old, new)

new_eq = r'''$
  T_0^"NO" equiv min_theta \{ chi^2 [ p_i ("IO", theta) ; p_i ("NO", theta^"true") ] \} ,
  \
  T_0^"IO" equiv min_theta \{ chi^2 [ p_i ("NO", theta) ; p_i ("IO", theta^"true") ] \} .
$ <eq:T0def>'''
s2, n = re.subn(r'\$T_0\^\(upright\("NO"\)\).*?\$<eq:T0def>', lambda m: new_eq, s, count=1, flags=re.S)
assert n == 1, n
s = s2

io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('ok')
