p = 'main.typ'
s = open(p, encoding='utf-8').read()
old = "  #text(10.5pt)[a,b]\n"
new = (
 "  #text(10.5pt)[Ivan Esteban#super[a,b], M. C. Gonzalez-Garcia#super[c,d,e], "
 "Michele Maltoni#super[f], Ivan Martinez-Soler#super[g], Joao Paulo Pinheiro#super[c], "
 "Thomas Schwetz#super[h]]\n"
 "  #v(0.5em)\n"
 "  #text(8.5pt)[\n"
 "    #super[a] Department of Physics, University of the Basque Country UPV/EHU, Bilbao, Spain.\n"
 "    #super[b] EHU Quantum Center, University of the Basque Country UPV/EHU, Bilbao, Spain.\n"
 "    #super[c] Departament de Física Quàntica i Astrofísica and ICC, Universitat de Barcelona, Barcelona, Spain.\n"
 "    #super[d] ICREA, Barcelona, Spain.\n"
 "    #super[e] C.N. Yang Institute for Theoretical Physics, Stony Brook University, Stony Brook, NY, USA.\n"
 "    #super[f] Instituto de Física Teórica UAM/CSIC, Madrid, Spain.\n"
 "    #super[g] Institute for Particle Physics Phenomenology, Durham University, Durham, UK.\n"
 "    #super[h] Institut für Astroteilchenphysik, KIT, Karlsruhe, Germany.\n"
 "  ]\n"
)
print(s.count(old))
assert s.count(old) == 1
s = s.replace(old, new)
open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
