import io

P = 'papers/2202.13919/main.typ'
t = io.open(P, encoding='utf-8').read()
orig = t
pairs = [
    ('PA@angle:2017\n', 'PA@angle:2017.\n'),
    ("fields@weinberg:2008 '", "fields@weinberg:2008. '"),
    ('Array@BICEP:2021 The', 'Array@BICEP:2021. The'),
    ('field@gardner:2008 Unlike', 'field@gardner:2008. Unlike'),
    ('data@eskilt:prep\n', 'data@eskilt:prep.\n'),
    ('LFI data@eskilt:prep the', 'LFI data@eskilt:prep: the'),
    ('physics@mukhanov:2016\n', 'physics@mukhanov:2016.\n'),
    ('perturbation@seljak:1997 This', 'perturbation@seljak:1997. This'),
    ('C.L.)@BICEP:2021 This', 'C.L.)@BICEP:2021. This'),
    ('Gaussian@maldacena:2003\n', 'Gaussian@maldacena:2003.\n'),
    ('data@Planck2018IX This', 'data@Planck2018IX. This'),
    ('mission@LiteBIRD:2022\n', 'mission@LiteBIRD:2022.\n'),
    ('Universe@zaldarriaga:1997 The', 'Universe@zaldarriaga:1997. The'),
    ("'@PlanckIntLVII\n", "'@PlanckIntLVII.\n"),
    ('@Planck2018II Parametrising', '@Planck2018II. Parametrising'),
    ('neutrinos@weinberg:2004 The', 'neutrinos@weinberg:2004. The'),
    ("'@lozanov:2019 In", "'@lozanov:2019. In"),
    ('dot(H))$@weinberg:2008\n', 'dot(H))$@weinberg:2008.\n'),
    ('@weinberg:2008 The scalar', '@weinberg:2008. The scalar'),
    ('shown in @fig:cl\n', 'shown in @fig:cl.\n'),
    ('as in @fig:cl\n ]', 'as in @fig:cl.\n ]'),
    ('shown in @fig:gw\n', 'shown in @fig:gw.\n'),
    ('shown in @fig:omega_gw\n', 'shown in @fig:omega_gw.\n'),
    ('effect in @fig:minami $', 'effect in @fig:minami. $'),
    ('equation~( @eq:', ' @eq:'),
    ('equations~( @eq:', ' @eq:'),
    (' and ( @eq:', ' and @eq:'),
    ('(@eq:', '@eq:'),
]
for a, b in pairs:
    n = t.count(a)
    print('%2d  %s' % (n, a.replace('\n', '\\n')[:54]))
    t = t.replace(a, b)
io.open(P + '.prepunct', 'w', encoding='utf-8', newline='\n').write(orig)
io.open(P, 'w', encoding='utf-8', newline='\n').write(t)
