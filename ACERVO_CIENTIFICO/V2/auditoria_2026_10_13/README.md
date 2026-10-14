# V2 audit — 2026-10-13

Isolated research branch forked from the frozen V2 commit **1a921c586903f4adf6cdb9c8668e7813f10512cb**. Original manuscripts and V1/V3-C are unmodified.

## Files

1. **ADENDO_ULTRARRIGIDEZ_CERTIFICADA.md** — corrected global EA rigidity argument conditional on an explicit finite group certificate; counterexample to the overly strong indecomposability biconditional, plus a dependence-graph replacement.
2. **certificar_ultrarrigidez_local.py** — standalone pure-Python GF(2) enumerator of \(\operatorname{Aut}(D^4f)\), the degree-2 modulo symmetry group of \(f\), stabilizers, centroid and kernel data. Execute: \`python3 certificar_ultrarrigidez_local.py\`. Expected: \`Aut_phi_size=1920\`, \`G_le2_size=40\`, both stabilizer sizes 1. A deterministic summary prints group-list SHA-256 hashes.
3. **BURNSIDE_QUADRATIC_EA_CLASSES.md** — exact counting theorem, including arbitrary quadratic perturbations and all weakly connected digraphs, via permutation cycles and Möbius inversion on permutation-invariant set partitions.
4. **contagem_ea_quadraticas.py** — Python 3 standard-library-only exact Burnside count; r=2 and r=3 symbolic checks and r=2..6 enumerations. Execute: \`python3 contagem_ea_quadraticas.py\`.

## Publication gates

- The local symmetry theorem has an independently reproduced **finite computational certificate**, not a Lean kernel proof.
- The global theorem follows from the finite lemma and the V2 tensor-centroid block recovery argument, but still requires adversarial peer review.
- The original text's statement "EA-indecomposable iff G connected for arbitrary Q" is **false** and must not be reused.
- The claimed publication novelty and priority of the new quadratic-class formulas have **not** been established.
- No blanket claim of Lean compilation or journal submission readiness.

**Do not merge into the publication branch before a targeted delta review.**
