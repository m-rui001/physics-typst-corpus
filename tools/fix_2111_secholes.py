import shutil
p = "papers/2111.14241/main.typ"
shutil.copy(p, p + ".presecholes")
s = open(p, encoding="utf-8").read()
R = [
    ("in Section If not", "in Section~#ref(<sec_outlook>, supplement: none). If not"),
    ("interaction in Section Typically,", "interaction in Section~#ref(<sec_magnon_phonon>, supplement: none). Typically,"),
    ("as introduced in Section covariance matrix is derived",
     "as introduced in Section~#ref(<sec_cvs>, supplement: none). The covariance matrix is derived"),
    ("coupled magnets in Section physics here",
     "coupled magnets in Section~#ref(<sec_coupled_magnets_PT>, supplement: none). The physics here"),
    ("magnon-photon system in Section We expect",
     "magnon-photon system in Section~#ref(<sec_cavity_magnonics_PT>, supplement: none). We expect"),
    ("as introduced in Section Due to",
     "as introduced in Section~#ref(<sec_magnon_phonon>, supplement: none). Due to"),
    ("is the diffusion matrix From the tripartite",
     "is the diffusion matrix~#cite(<VitaliPRL2007>). From the tripartite"),
]
for a, b in R:
    n = s.count(a)
    print(n, a[:50])
    s = s.replace(a, b)
open(p, "w", encoding="utf-8", newline="\n").write(s)
