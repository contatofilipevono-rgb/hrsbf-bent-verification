# Certification and reproduction

## Fixed evidence

- Editorial base: `14646e8`, branch `publication/antipodal-submission-ready-2026-10-15`.
- Certified source: `6dd183685ef8a5b033c1bcf8733496d57b853cc7`.
- Lean: `leanprover/lean4:v4.15.0`.
- Mathlib: `9837ca9d65d9de6fad1ef4381750ca688774e608`.
- Historical core CI: [38682075049](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682075049), source `9f186bc871361b263a9356a8d80cbcc837db21de`.
- Historical absolute-Walsh CI: [38682481132](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682481132), source `6dd183685ef8a5b033c1bcf8733496d57b853cc7`.

Both CI statuses and source SHAs were rechecked through the GitHub API on 19 October 2026. The actual earlier signature/axiom logs remain under `research/astra-global-2026-10-15/kernel_logs/`. This editorial pass did not run a new full Lean build or fetch those full historical remote logs again. Their local records were inspected. No claim of a new independent kernel is made.

`git diff --exit-code 6dd183685ef8a5b033c1bcf8733496d57b853cc7 HEAD -- formalization` passed before the editorial commit; the new commits add only editorial material. Project Lean sources therefore remain the existing certified sources.

## Semantic map

All declarations are in `HRSBF.Antipodal`, under `formalization/Antipodal/`.

| Article | Declaration / file | Semantic check |
|---|---|---|
| Canonical coefficients and degree | `anfCoefficient`, `anf_reconstruction`, `HasAlgebraicDegreeAtMostThree` / `CanonicalANF.lean` | Inspected: Boolean Möbius coefficient; no arbitrary coefficient oracle |
| Conventional bentness | `isBent_iff_walsh_absolute` / `WalshNormalization.lean` | Inspected: |W|=2^H iff W²=card(Vec(2H)) |
| Lemma 3 | `odd_order_quadratic_balance_iff` / `OddRestriction.lean` | Same statement; formal quadraticity is vanishing third difference; editorial radical proof differs |
| Corollary 4 | `odd_order_bent_restriction`, with degree bridge in `CubicTransport.lean` | Inspected: actual derivatives, actual fixed space, explicit coordinate equivalence |
| Lemma 5 | `balanced_rotation_invariant_quadratic_polar_zero` / `CyclicQuadraticRigidity.lean` | Inspected: proper radical/image premise discharged in the development |
| Proposition 6 | `not_bent_constant_diagonal_power_two_of_cubic` / `PowerTwoCubic.lean` | Inspected: positive half-dimension encoded by n+1; cubic representation bridge proved |
| Fiber identity | `fiber_polar_eq_derivative_polar` / `LocalRigidity.lean` | Inspected: block swap and diagonal hypotheses retained |
| Half-turn cancellation | `constant_on_halfTurn_fixed_of_antipodal_zero` / `PowerTwoCubic.lean` | Statement needed is constancy; a stronger coefficient-folding equality is not used |
| Theorem 1 | `universal_antipodal_walsh_absolute` / `WalshNormalization.lean` | Exact n=2H, H>0; arbitrary affine terms; actual rotation; canonical pair {0,H} |
| Corollary 2 | `no_homogeneous_cubic_rotation_symmetric_bent_absolute` / `WalshNormalization.lean` | Exact degree-three homogeneity and all positive even dimensions |

The inspected public declarations introduce no assumed diagonal, restriction-bentness, radical containment, finite dimension cutoff, or folding premise. Recorded final axiom lists contain only `propext`, `Classical.choice`, `Quot.sound`. Source scans reject proof shortcuts; these scans supplement, not replace, a kernel build.

## Reproduction levels

Fast editorial controls, from the repository root with Python and `pypdf`:

```sh
python editorial/V1/check_editorial.py
python -X utf8 research/astra-global-2026-10-15/audit_lean_sources.py
```

The first checks finite quadratic/affine cases, source identity and PDF diagnostics. Its universal mathematical claims are justified by the proofs in the article, not by finite examples. The second is the preserved source audit.

Full original Lean verification, in a separate checkout at the certified source:

```sh
cd formalization
lake exe cache get
lake build
lake env lean CheckGlobal.lean
```

The compiler and dependency revision must be pinned as above. This may take substantial resources; no promise of minute-scale fresh compilation is made. The V1 proof is separate from the ongoing H(12,4) Lean 4.35.0 jobs, which must not be used as evidence for this cubic theorem.

PDFs were compiled with portable Tectonic 0.17.0 (official Windows MSVC archive SHA256 `f61ce51f0b0ade1015b7de7ef368541c5424e9756ecbd0d7af97d6d48030845f`). With Tectonic installed:

```sh
cd editorial/V1
tectonic ARTIGO_SIMPLIFICADO.tex
tectonic APENDICE_PROVAS.tex
```

Both sources are complete documents, also usable with an ordinary LaTeX distribution. The wrapper `main.tex` is for the local editor; `appendix/main.tex` selects the appendix. No external image or bibliography file is needed.

## Limits

The new radical-averaging derivation and the shorter editorial organization have not been newly compiled as Lean proofs. The certified final theorem already exists with identical mathematical hypotheses and conclusion. Neither the source scan nor the CI status establishes priority, peer review, or the correctness of other projects. No independent external reviewer participated in this editorial task.
