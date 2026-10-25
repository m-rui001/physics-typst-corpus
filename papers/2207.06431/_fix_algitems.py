import re, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()

start_anchor = "+ For this outcome, select the set of devices $U$ transitioning upward from the computational subspace. For each $j in U$:"
end_anchor = "Select the Pauli error operator"

i = s.find(start_anchor)
j = s.find(end_anchor, i)
if i < 0 or j < 0:
    sys.exit('anchors missing')
block = s[i:j]
print(repr(block[:400]))

new_block = (
 "+ For this outcome, select the set of devices $U$ transitioning upward from the computational subspace. "
 "For each $j in U$: (a) do partial row reduction as in step 2(ii); (b) drop the first generator $G_1$ "
 "(swap it with $G_m$ and decrement $m$); (c) if the qubit $j$ was entangled with the rest of the system, "
 "replace $G_2[j] = sigma_z$ with the identity operator; (d) with probability $p = 1/2$, flip the sign "
 "of $G_2$; (e) set leakage label $a[j]$ according to its value in $macron(f)$.\n\n+ "
)
s = s[:i] + new_block + s[j:]
open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
