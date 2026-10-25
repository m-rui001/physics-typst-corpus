import shutil, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()
shutil.copy(p, p + '.predropped')

old = "\\_\n\n\\_\n\n\\*\n"
para = ("We tested the validity of the Generalized Twirling Approximation used by the #emph[Pauli+] model "
        "by doing a direct comparison with the equivalent kraus_sim simulation. Specifically, we simulated "
        "the distance-3 $Z$-basis and $X$-basis experiments associated with the West device configuration. "
        "Each 25-round simulation corresponded to 200,000 samples. The classical #emph[Pauli+] simulation "
        "required about 160 seconds (distributed over 16 CPU cores), while the quantum simulation required "
        "~11 hours#footnote[Note that the qsim backend for the kraus_sim simulator has not been optimized "
        "for performance on these system sizes.]. Decoding was implemented using the algorithm in "
        "Ref. @fowler2013optimal, with detection cluster probabilities inferred from the $p_(i j)$ matrix.\n")
print('artifact count', s.count(old))
if s.count(old) != 1:
    sys.exit('artifact mismatch')
s = s.replace(old, para)

old2 = "As can be seen in @fowler2013optimal, there is generally"
new2 = "As can be seen in @fig:quantum_classical_fidelities\u2013@fig:quantum_classical_scatter, there is generally"
print('ref count', s.count(old2))
if s.count(old2) != 1:
    sys.exit('ref mismatch')
s = s.replace(old2, new2)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
