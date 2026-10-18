# Packed polynomial formalization

The optional `H12PackedCertificate` library builds `H12PackedPolynomial.lean`. Its generic semantics and refutation soundness have been built and replayed by the Lean kernel. Only standard Lean axioms are used. See `reports/LEAN_PACKED_AUDIT.json` and the preserved build/replay logs.

The representation uses 1,333 coefficient slots for constants, 36 variables, and ordered pairs. Duplicate monomials cancel semantically. Proven operations include affine products, substitution, canonicalization, and algebraic refutations with observation preservation. The specialized affine-times-variable operation uses a shifted coefficient row directly. The sequential scan avoids repeated logarithms of large coefficient words; its semantics theorem holds without an input-word bound.

The generated `H12PackedPilot.lean` is limited to subtree 18 of the public decomposition: 11 nodes, 49 states, 48 transitions, and 38 elimination identities. Generation alone does not establish its theorem. Its proof-check status is recorded separately. A first concrete scan transition passed in about 9.6 seconds; this does not predict the cost of the complete tree.

The complete decomposition has 67,658 nodes and 282,418 linear steps (including all recorded roots). The unconditional nonexistence theorem in Lean is still pending. The existing Python certificate and the generic Lean theorems are distinct results.

Reproduce the generic check from `lean/`:

```
lake build H12PackedCertificate
lake env leanchecker --verbose H12PackedPolynomial
```

Generate the pilot from the repository inputs with `python tools/generate_lean_packed_pilot.py`, then check `lake env lean H12PackedPilot.lean`. The default build still contains the previously audited 28 primary modules. This optional source is a later checkpoint and is not included in the earlier isolated handoff ZIP.
