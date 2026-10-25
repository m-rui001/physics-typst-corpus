import re, sys
p = sys.argv[1]
t = open(p, encoding='utf-8').read()
new = {
'zienkiewicz1977finite': """@book{zienkiewicz1977finite,
  author = {O. C. Zienkiewicz and R. L. Taylor and P. Nithiarasu and J. Z. Zhu},
  title = {The Finite Element Method},
  volume = {3},
  publisher = {Elsevier},
  year = {1977},
}""",
'canuto2012spectral': """@book{canuto2012spectral,
  author = {C. Canuto and M. Y. Hussaini and A. Quarteroni and A. T. Zang},
  title = {Spectral Methods in Fluid Dynamics},
  publisher = {Springer},
  year = {2012},
}""",
'Brunton2019book': """@book{Brunton2019book,
  author = {S. L. Brunton and J. N. Kutz},
  title = {Data-Driven Science and Engineering: Machine Learning, Dynamical Systems, and Control},
  publisher = {Cambridge University Press},
  year = {2019},
}""",
'boussinesq': """@book{boussinesq,
  author = {J. V. Boussinesq},
  title = {Th\\'eorie analytique de la chaleur: mise en harmonie avec la thermodynamique et avec la th\\'eorie m\\'ecanique de la lumi\\`ere. T. 2},
  publisher = {Gauthier-Villars},
  year = {1923},
}""",
'ari_etmm': """@inproceedings{ari_etmm,
  author = {G. B. Arivazhagan and L. Guastoni and A. G\\'uemes and A. Ianiro and S. Discetti and P. Schlatter and H. Azizpour and R. Vinuesa},
  title = {Predicting the near-wall region of turbulence through convolutional neural networks},
  booktitle = {Proc. 13th ERCOFTAC Symp. on Engineering Turbulence Modelling and Measurements (ETMM13)},
  year = {2021},
}""",
'pinns_etmm': """@inproceedings{pinns_etmm,
  author = {H. Eivazi and M. Tahani and P. Schlatter and R. Vinuesa},
  title = {Physics-informed neural networks for solving Reynolds-averaged Navier--Stokes equations},
  booktitle = {Proc. 13th ERCOFTAC Symp. on Engineering Turbulence Modelling and Measurements (ETMM13)},
  year = {2021},
}"""}
for k, v in new.items():
    pat = re.compile(r'@\w+\{' + k + r',\n.*?\n\}', re.S)
    if not pat.search(t):
        print('missing', k)
        continue
    t = pat.sub(lambda m: v, t, count=1)
open(p, 'w', encoding='utf-8').write(t)
print('books patched')
