# Kernel certificate — universal antipodal theorem

## Source and environment

- Core universal proof source commit: `9f186bc871361b263a9356a8d80cbcc837db21de`.
- Branch: `formal/astra-global-antipodal-2026-10-15`.
- Lean: `leanprover/lean4:v4.15.0`, release commit `11651562caae`.
- Mathlib: `9837ca9d65d9de6fad1ef4381750ca688774e608`, checked from both lake-manifest.json and the actual dependency checkout.
- Core clean CI: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682075049 — **SUCCESS**, completed 2026-10-15 04:36:14 UTC. Job `116248619552`; full job log retrieved and inspected.
- Root library target: `Antipodal`; it imports the global module through `Nonvacuity`. The absolute-normalization module is additionally imported in the final semantic-interface revision.

## Exact core signature

```lean
theorem universal_antipodal
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f)
    (hs : IsRotationSymmetric f) (hb : IsBent f) :
    anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 1
```

There are equivalent proved interfaces in dimension `2*H` and through `antipodalANFCoefficient` in dimension `2*(h+1)`. Every positive even dimension is covered; this is not a power-of-two-only or fixed-dimension theorem.

```lean
theorem no_homogeneous_cubic_rotation_symmetric_bent
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂)
    (hf : IsHomogeneousCubic f) (hs : IsRotationSymmetric f) :
    ¬ IsBent f
```

## Direct conventional Walsh interface

`WalshNormalization.lean` proves equivalence of `IsBent` with the usual absolute Walsh magnitude, including the cardinality normalization `|Vec (2*H)|=(2^H)^2`. It also proves the final statements directly with that premise:

```lean
theorem universal_antipodal_walsh_absolute
    (H : ℕ) (hH : 0 < H) (f : Vec (2*H) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f)
    (hs : IsRotationSymmetric f)
    (hb : ∀ b, |∑ x, sign (f x + dot b x)| = (2 : ℤ)^H) :
    anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 1
```

The ordinary nonexistence corollary is `no_homogeneous_cubic_rotation_symmetric_bent_absolute`.

## Premise audit

| Lean item | Mathematical meaning |
|---|---|
| `F₂`, `Vec N` | `ZMod 2`, `Fin N → ZMod 2` |
| `H>0`, `N=H+H=2*H` | Every positive even dimension, including N=2 |
| `anfCoefficient` | Boolean Mobius coefficient on a squarefree support; reconstruction and uniqueness proved |
| `HasAlgebraicDegreeAtMostThree` | All canonical coefficients of support size greater than 3 vanish |
| `IsRotationSymmetric` | Invariance under the actual one-coordinate cyclic permutation `finRotate N` |
| `IsBent` | For every frequency, the actual integer Walsh square equals the binary-vector cardinality |
| `IsHomogeneousCubic` | All coefficients outside degree 3 vanish and a cubic coefficient is nonzero |
| Target pair `{0,H}` | A unique canonical quadratic coefficient; rotation covariance makes it the antipodal orbit coefficient |

No diagonal, balance, derivative-polar, radical-image, restriction-bentness, fixed-space-coordinate, coefficient-transport or factorization premise is present in the final statement. All needed instances/structures are concrete. `positive_two_power_odd_factor` covers all positive half-dimensions. Explicit `boundaryBent` witnesses show the premises are nonvacuous and allow nonzero affine/constant terms.

## Axiom output

Each of the following prints exactly `[propext, Classical.choice, Quot.sound]`:

- `HRSBF.Antipodal.universal_antipodal`
- `HRSBF.Antipodal.universal_antipodal_canonical`
- `HRSBF.Antipodal.no_homogeneous_cubic_rotation_symmetric_bent`
- `HRSBF.Antipodal.universal_antipodal_walsh_absolute`
- `HRSBF.Antipodal.no_homogeneous_cubic_rotation_symmetric_bent_absolute`

The actual captured local stdout and confirmed remote core-CI excerpts are in `kernel_logs/`; `CheckGlobal.lean` prints the signatures, definitions and axiom lists. CI checks all printed declarations against the three allowed axioms and requires the universal theorem names to be present. `sorryAx` and `Lean.ofReduceBool` are explicitly rejected. A comment/string-aware source scan rejects `sorry`, `admit`, custom `axiom`, `unsafe`, and `native_decide` throughout the project proof modules.

## Reproduce on a clean checkout

```sh
git clone --branch formal/astra-global-antipodal-2026-10-15 https://github.com/contatofilipevono-rgb/hrsbf-bent-verification.git
cd hrsbf-bent-verification/formalization
lake exe cache get
python ../research/astra-global-2026-10-15/audit_lean_sources.py
lake build
lake env lean Antipodal/GlobalAntipodal.lean
lake env lean Antipodal/WalshNormalization.lean
lake env lean CheckGlobal.lean
```

For the immutable core commit, use `git checkout 9f186bc871361b263a9356a8d80cbcc837db21de`; omit WalshNormalization.lean because that semantic-equivalence interface is added in the next revision.

## Executed local checks

- `lake build` on the working source: exit 0.
- Detached clean worktree at core SHA, with **empty project build output** and only pinned dependency caches shared: `lake build`, standalone GlobalAntipodal.lean, and CheckGlobal.lean all exit 0.
- Absolute-normalization interface: standalone Lean and full root build exit 0.
- Source shortcut audit: passed.
- Exact CPU adversarial searches: no counterexamples in the enumerated families; see COUNTEREXAMPLES.md.

The local host required a path-resolution shim for locating executables through `/proc`; it does not change Lean's kernel or proof checking. The independent Ubuntu CI uses ordinary unmodified pinned Lean without that shim.

## Scope boundary

The stronger standalone coefficient-folding equality for arbitrary non-bent RS functions remains separately unformalized. It is not assumed or used by this proof. The formal proof transports the zero-antipodal/constant-diagonal obstruction directly. This certificate concerns the exact global theorem above and its corollary; it is not a journal acceptance or an exhaustive priority certificate.
