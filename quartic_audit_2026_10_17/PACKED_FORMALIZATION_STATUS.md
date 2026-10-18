# Packed polynomial formalization

The optional `H12PackedCertificate` library builds `H12PackedPolynomial.lean`. Its generic semantics and refutation soundness have been built and replayed by the Lean kernel. Only standard Lean axioms are used. See `reports/LEAN_PACKED_AUDIT.json` and the preserved build/replay logs.

The representation uses 1,333 coefficient slots for constants, 36 variables, and ordered pairs. Duplicate monomials cancel semantically. Proven operations include affine products, substitution, canonicalization, and algebraic refutations with observation preservation. The specialized affine-times-variable operation uses a shifted coefficient row directly. The sequential scan avoids repeated logarithms of large coefficient words; its semantics theorem holds without an input-word bound.

The generated `H12PackedPilot.lean` is limited to subtree 18 of the public decomposition: 11 nodes, 49 states, 48 transitions, and 38 elimination identities. The pilot compiled and all five data modules plus the final proof module passed independent kernel replay. See `reports/LEAN_PACKED_PILOT_AUDIT.json`. A first concrete scan transition passed in about 9.6 seconds; this does not predict the cost of the complete tree.

The complete decomposition has 67,658 nodes and 282,418 linear steps (including all recorded roots). The unconditional nonexistence theorem in Lean is still pending. The existing Python certificate and the generic Lean theorems are distinct results.

Reproduce the generic check from `lean/`:

```
lake build H12PackedCertificate
lake env leanchecker --verbose H12PackedPolynomial
```

Generate the pilot from the repository inputs with `python tools/generate_lean_packed_pilot.py`, then check `lake env lean H12PackedPilot.lean`. The default build still contains the previously audited 28 primary modules. This optional source is a later checkpoint and is not included in the earlier isolated handoff ZIP.


## Verified extensions after the first packed checkpoint

All 164,288 Walsh rejections and their 42 modules have passed the Lean kernel (`LEAN_WITNESS_KERNEL_AUDIT.json`). The concrete subtree-18 pilot has passed build and replay, including its 48 numeric transitions and final no-model theorem. This subtree is limited to contradictory leaves.

`H12PackedTerminal.terminalCheckFast_sound` connects affine packed environments to certified witnesses. The leaf-12 instance verifies all eight candidates of its three free parameters. `H12PackedRoots` proves the representation and observation semantics for all three necessary root charts; its final theorem explicitly requires three concrete refutations. The complete tree remains pending.

`H12PackedSparse` proves exact equality of two sparse implementations to the original scanning substitution. Its binary search for the highest set bit uses 11 levels for words below 2^2048; the direct column implementation avoids reconstructing quadratic monomial masks. The first-transition benchmarks are limited tests, not a complete-tree runtime forecast.

`H12MixedPilot` is a generated instance of subtree 11 in the first chart: 3 nodes, 32 states, 31 transitions, and two Walsh-terminal leaves totaling 16 candidates. Its current audit status is in `reports/LEAN_MIXED_EXTENSION_AUDIT.json`; source generation and build alone are distinct from independent kernel replay.

The optional executable `H12PackedChecker` is proved sound. A raw subtree benchmark is exploratory until its result is recorded. None of these local subtrees proves coverage of all root-chart assignments.


The fixed-equation affine-state theory, both small subtree instances, the 21-node instance, the root-frame instance, and the empty fourth chart have all passed kernel replay. The later row-composition theories and overlapping pilots also passed; see ESTADO_KERNEL_162.md and LEAN_CHECKPOINT_COVERAGE.json. The complete three-root H(12,4) exclusion theorem is still pending.
