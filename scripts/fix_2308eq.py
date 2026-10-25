p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()
bi = s.find('begin{equation}')
start = bi - 6
print('prefix', repr(s[start:bi]))
ei = s.find('end{equation}', bi)
endfull = ei + len('end{equation}') + 4
print('suffix', repr(s[ei:endfull]))
assert s[start:bi] == '\\$\\$\\\\'
assert s[ei + len('end{equation}'):endfull] == '\\$\\$'
new = r'''$
  (dif R_("BH")) / (dif m_1 dif m_2) approx & p_("BH") integral dif M_1 dif M_2 (dif R_h) / (dif M_1 dif M_2) \
  & times p_("occ")(m_1 | M_1, z) p_("occ")(m_2 | M_2, z) ,
$'''
s = s[:start] + new + s[endfull:]
s = s.replace('audible\\" axions', 'audible” axions')
open(p, 'w', encoding='utf-8').write(s)
print('remaining raw tex', s.count('begin{equation}'), 'stray quotes', s.count('\\"'))
