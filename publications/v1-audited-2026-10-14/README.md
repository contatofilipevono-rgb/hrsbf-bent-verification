# Antipodal necessity — audited preprint v1.2

**Author:** Filipe Martins Vono. **Date:** 14 October 2026.

[Read the preprint (PDF)](paper/antipodal_necessity_v1_2.pdf) · [LaTeX source](paper/antipodal_necessity_v1_2.tex) · [Audit and maturity decision](AUDIT.md)

## Mathematical result and publication status

The manuscript presents an algebraic proof that every rotation-symmetric bent Boolean function of degree at most three, in any positive even dimension, contains the antipodal quadratic orbit. Homogeneous cubics therefore cannot be bent. This covers n=16 and n=32, without requiring the proposed extension of the Ward divisibility calculation.

This is a **public preprint for expert review**, not a journal acceptance, not an arXiv submission, and not an assertion of external peer review or absolute bibliographic priority.

The complete argument was already present in the V1 manuscript at the baseline commit `db3d5b9f385dc96adf7df3f0a0483d4c611d90e8`. This release reconstructs that proof, connects it to the corrected package, adds independent exact controls, and makes the verification scope explicit. It does not claim to have discovered this argument on 14 October.

## Three different verification levels

| Item | Status |
|---|---|
| General antipodal theorem and homogeneous cubic corollary | Algebraic proof in the manuscript; reconstructed in this audit; needs external expert scrutiny |
| Explicit nonhomogeneous n=12 certificate and selected supporting lemmas | Compiled and kernel checked with Lean 4.15.0; 543 theorem axiom reports |
| Exhaustive n=12 control across all 33,554,432 candidates ($\deg \le 3$) | Certified on NVIDIA A100 GPU (31.1s); exactly 14,336 bent representatives, 0 omit $P_{12}$, 0 homogeneous bent |
| Quadratic rigidity / complementary-fiber identities in n=32 | Independent exact finite controls, all passing; supports the algebraic argument |
| Full Lean formalization of the general theorem | **Not completed** |
| `BitWalkBridge 32`, universal Ward certificate in n=16, bit-projection hypotheses in selected formal lemmas | **Still pending in Lean**; none is smuggled in as a proved global theorem |

The n=12 example illustrates why homogeneity is essential. It is not a counterexample to a theorem stated for homogeneous functions.

## Reproduce

Exact structural controls (Python 3 standard library only):

```bash
python3 checks/verify_structural.py --output logs/structural_results_reproduced.json
```

The n=32 control checks 65,536 quadratic components and both linear components; constants do not change balance. It separately checks all 155 cubic orbits, 39,680 trilinear basis contractions, rank six for both fiber coefficient maps, and exact equality of their row spaces. The folding controls include n=96, which reduces to t=32.

Kernel verification (Lean 4.15.0):

```bash
python3 checks/verificar_compilacao.py
```

The accompanying `logs/compilacao_arquivo_unico.log` records the real prior compilation of exactly the published formal source: exit code 0 in 416.325 seconds. Its SHA-256 is checked against `logs/resultado_compilacao.json`. Standard axioms `propext`, `Quot.sound`, and `Classical.choice` occur; neither `sorryAx` nor `Lean.ofReduceBool` occurs. The original VM needed a path-discovery compatibility shim; that provenance is preserved in the compilation metadata. Ordinary Linux installations do not normally need it.

PDF compilation:

```bash
cd paper
latexmk -pdf -interaction=nonstopmode -halt-on-error antipodal_necessity_v1_2.tex
```

`SHA256SUMS.txt` covers the release files. Finite computations are validation controls, not a proof by enumeration over all 2^155 cubic functions.

## Literature

The manuscript credits the earlier quadratic/short-cycle antipodal phenomenon, the known nonhomogeneous cubic constructions, and the partial results of Sun–Shi–Liu–Fu (2026). No claim is made to solve homogeneous degrees four and above. See `AUDIT.md` for current-source checks and proof dependencies.
