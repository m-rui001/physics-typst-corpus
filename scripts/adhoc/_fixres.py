import os

def patch(path, pairs):
    s = open(path, encoding="utf-8").read()
    orig = s
    for old, new in pairs:
        n = s.count(old)
        assert n >= 1, "%s: missing %r" % (os.path.basename(os.path.dirname(path)), old)
        s = s.replace(old, new)
    if s != orig:
        bak = path + ".preres"
        if not os.path.exists(bak):
            open(bak, "w", encoding="utf-8").write(orig)
        open(path, "w", encoding="utf-8").write(s)
        print("patched", path)

# 2212.13969: escaped-math heat equation
patch(r"E:\phys\papers\2212.13969\main.typ", [
    (r'\$u(t,x)= integral\_0^infinity w(t,x,p)"d" p = integral\_(-infinity)^infinity chi(p) w(t,x,p) "d" p\$',
     r'$u(t,x) = integral_0^infinity w(t,x,p) dif p = integral_(-infinity)^infinity chi(p) w(t,x,p) dif p$'),
])

# 2306.03903: escaped-math m f_PBH expressions
patch(r"E:\phys\papers\2306.03903\main.typ", [
    (r'\$m"mspace"{1.5mu}f\_("upright"("PBH")) similar 1\,M\_"odot"\$',
     r'$m f_"PBH" similar 1 M_odot$'),
    (r'\$m"mspace"{1.5mu}f\_("upright"("PBH"))/M\_"odot" = 0.0003\$',
     r'$m f_"PBH" \/ M_odot = 0.0003$'),
    (r'\$m"mspace"{1.5mu}f\_("upright"("PBH"))\$',
     r'$m f_"PBH"$'),
    (r'\$-"mspace"{1.5mu}3\$', r'$-3$'),
    (r'\$w equiv p/ rho"mspace"{1.5mu}c^(2)\$', r'$w equiv p \/ rho c^2$'),
])

# 2308.07915: underscore inside math
patch(r"E:\phys\papers\2308.07915\main.typ", [
    (r'$v in "FF"\_2^n$', r'$v in bb(F)_2^n$'),
    (r'$"ZZ"\_"ell" "times" "ZZ"\_m$', r'$bb(Z)_ell times bb(Z)_m$'),
    (r'$"ZZ"\_j$', r'$bb(Z)_j$'),
])

# 2102.01111: brace artifacts after macro expansion
patch(r"E:\phys\papers\2102.01111\main.typ", [
    (r'$Lambda\_{"EFT"}$', r'$Lambda_"EFT"$'),
    (r'$Lambda\_{"QG"}$', r'$Lambda_"QG"$'),
])

# 2104.11260: author marker
patch(r"E:\phys\papers\2104.11260\main.typ", [
    (r'#super[2,\$]', '#super[2,‡]'),
])

# 2111.14241: bibliography math escapes -> plain unicode
patch(r"E:\phys\papers\2111.14241\refs_body.typ", [
    (r'\$|\$', '|'),
    (r'\$z\_2\$', 'z₂'),
    (r'\$mnf\_2\$', 'MnF₂'),
    (r'\$fef\_2\$', 'FeF₂'),
    (r'tlcucl\$\_3\$', 'TlCuCl₃'),
    (r'\$cs\_2cucl\_4\$', 'Cs₂CuCl₄'),
    (r'\$YIG/Co\$', 'YIG/Co'),
    (r'\$PT\$', 'PT'),
    (r'\$pt/Hz\$', 'pT/√Hz'),
    (r'\$m\_a=58ev\$', 'mₐ = 58 eV'),
    (r'\$CP\$', 'CP'),
])
