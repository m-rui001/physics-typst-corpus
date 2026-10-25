import os, shutil

base = os.path.dirname(os.path.abspath(__file__))
p = os.path.join(base, "main.typ")
src = open(p, encoding="utf-8").read()

blocks = {
"Figure1": """// [figvision] imgs/Figure1.png - three-panel logical-processor schematic.
// (a) Three zones: storage (dense 2D grid, upper left), entangling (centre, two
//     interlaced logical grids), readout (lower right, focused imaging beam).
//     Labels: logical-qubit storage, ancilla reservoir, 1Q/2Q gates, syndrome
//     extraction, local imaging; ~100 um atom transport between zones.
// (b) Left: addressed sites (red) among grey lattice sites. Centre: qubit-state
//     traces vs time 0-60 us, addressed site flips while neighbours stay flat.
//     Right: 80-site heatmap vs time 0-30 us (colour bar 0-1), only the addressed
//     column oscillates.
// (c) Signal chain AOD -> camera -> FPGA (real-time decoding) -> feedforward.
//     Insets: Ramsey fringe (excitation 0-1 vs phase) and camera-count histogram
//     with two peaks near 1780 and 2100 counts and a low-count gap between them.
""",
"Figure2": """// [figvision] imgs/Figure2.png - four panels, surface-code transversal CNOT.
// (a) Two d=7 surface-code blocks |+>_L and |0>_L moved into the entangling zone,
//     interlaced, then a single global Rydberg pulse implements transversal CNOTs
//     (red/purple twin-pair bonds).
// (b) Physical-error circuit: control and target stabilizer tracks with propagated
//     X (control) and Z (target) errors, plus a hyperedge joining the two decoding
//     graphs; ancilla/data rows labelled.
// (c) Logical bitstring probabilities in the XX and ZZ bases for d=7: near-0.5
//     bars at the correct strings (uniform 0000000 / 1111111 combinations) and
//     small residual strings.
// (d) Bell-pair error vs code distance d=3,5,7. Conventional decoding rises
//     0.19 -> 0.25 -> 0.37; correlated decoding falls 0.105 -> 0.08 -> 0.072
//     (open circles, error bars). Right: d=3/5/7 lattices with data (grey),
//     ancillas (dark), X-stabilizer (red) and Z-stabilizer (blue) plaquettes,
//     X_L horizontal and Z_L vertical logical axes.
""",
"Figure3": """// [figvision] imgs/Figure3.png - five panels, fault-tolerant logical GHZ.
// (a) Circuit: nFT encoding of ten colour codes, five ancilla logicals, parallel
//     transversal CNOTs onto five computation logicals, ancillas moved to storage,
//     then C/H/measure blocks for GHZ analysis.
// (b) SPAM infidelity bars (log scale): Logical nFT ~0.02, Physical atom ~0.0065,
//     Logical FT ~0.0009, with error bars.
// (c) Logical GHZ fidelity bars: nFT ~0.55, FT ~0.72, EDFT ~0.99.
// (d) GHZ fidelity vs accepted fraction (1 -> 0) for strategies FT, 1, 2, 3, 4
//     successful flags; fidelity climbs as acceptance drops, arrow "Increasing
//     error detection".
// (e) 3D bar plots Re(rho_logical) and Im(rho_logical) over the 16 logical basis
//     states: dominant 0000/1111 amplitudes with small imaginary parts.
""",
"Figure4": """// [figvision] imgs/Figure4.png - zoned scaling and mid-circuit feedforward.
// (a) Storage zone (large left grid) and entangling zone (right, blocks) with a
//     colour-coded 40-colour-code layout and transport arrows.
// (b) Long circuit of repeated storage-access / move-in / transversal-CNOT /
//     move-out blocks; four rounds build 40 colour codes from 280 physical qubits.
// (c) Logical decoherence vs number of additional encoded groups (0-3) for
//     physical idling, error detection and error correction; correction stays
//     ~1e-3 while physical idling rises to ~1e-2; shaded uncertainty bands.
// (d) Feedforward circuit across entangling, storage and readout zones: mid-circuit
//     X measurement of the middle logical, classical bit (double line) driving
//     conditional logical S gates on the outer logicals.
// (e) Measured logical parities XX and YY: feedforward ~+0.65, no feedforward
//     ~-0.6, no mid-circuit ~+0.6; error bars and dashed ideal markers.
""",
"Figure5": """// [figvision] imgs/Figure5.png - six panels, [[8,3,2]] 3D-code sampling.
// (a) Three logical qubits per cube (Z_L1..Z_L3) with stabilizer panels
//     S_Z1..S_Z4 / S_X1; transversal CCZ, CZ, Z and logical CNOT by physical
//     permutation; eight cubes entangled by transversal CNOTs.
// (b) Bitstring probability spectra (index 0-4096, probability 0-0.002) for raw
//     data, postselected data and ideal theory of a 12-logical circuit;
//     postselection reproduces the theoretical peaks.
// (c) Full syndrome-extraction circuit for 48 logical qubits: three long rails of
//     data/ancilla/flag lines with repeated CNOT and measure blocks.
// (d) Classical simulation runtime per bitstring (log y): measured ~3 us at 6
//     logicals rising to ~1000 s at 48 (points) plus a projected curve.
// (e) XEB vs accepted fraction for 3, 6, 12, 24, 48 logical qubits (rising
//     curves); inset: 48-logical nested cubes on a 4D hypercube.
// (f) Raw (red) and fully error-detected (black) XEB vs number of logical qubits
//     (3-48) with physical upper bound (blue); diagrams of 4D -> 7D hypercube
//     connectivity.
""",
}

for name, block in blocks.items():
    anchor = '#figure(image("imgs/%s.png"),' % name
    marker = "// [figvision] imgs/%s.png" % name
    if marker in src:
        print("skip", name)
        continue
    if anchor not in src:
        print("MISSING", name)
        continue
    src = src.replace(anchor, block + anchor, 1)
    print("inserted", name)

bak = p + ".preFigann"
if not os.path.exists(bak):
    shutil.copy2(p, bak)
open(p, "w", encoding="utf-8", newline="").write(src)
print("done")
