import Mathlib

/-!
# HRSBF V1: foundational mathematical predicates (UNCOMPILED DRAFT)

This standalone draft is *not* a formal proof of the Stănică–Maitra conjecture.
It replaces vacuous propositions (e.g. is_bent := True) with actual integer
Walsh sums, rotation symmetry, ANF-based degree, and cubic homogeneity.

Status 2026-10-13:
* Definitions have been reviewed mathematically, NOT compiled against Lean/Mathlib.
* Two small sanity-check examples are proof obligations, NOT a certificate of
  the n=12, n=16, or n=32 claims.
* No Ward divisibility, parity decoupling, or global conjecture theorem is claimed.
* This file is intentionally isolated from existing V1, V2, V3-C manuscripts
  and is not imported by any existing Lean project.
-/

namespace HRSBF_Audit

abbrev Bits (n : ℕ) := Fin n → Bool

/-- Number of positions in the binary scalar product before reduction modulo 2. -/
def dotCount {n : ℕ} (x a : Bits n) : ℕ :=
  ∑ i : Fin n, if x i && a i then 1 else 0

/-- Exact integer Walsh–Hadamard coefficient. -/
def walsh (n : ℕ) (f : Bits n → Bool) (a : Bits n) : ℤ :=
  ∑ x : Bits n,
    (-1 : ℤ) ^
      ((if f x then (1 : ℕ) else 0) + dotCount x a)

/-- Exact bentness: every squared Walsh coefficient equals 2^n. -/
def isBent (n : ℕ) (f : Bits n → Bool) : Prop :=
  ∀ a : Bits n, (walsh n f a) ^ 2 = (2 : ℤ) ^ n

/-- One-step cyclic rotation of Boolean coordinates. -/
def rotate (n : ℕ) (x : Bits n) : Bits n :=
  fun i => x (i + 1)

/-- Invariance under the cyclic shift of input variables. -/
def isRotationSymmetric (n : ℕ) (f : Bits n → Bool) : Prop :=
  ∀ x : Bits n, f (rotate n x) = f x

/-- Nonzero coefficient of the monomial indexed by s in the ANF. -/
def anfNonzero (n : ℕ) (f : Bits n → Bool)
    (s : Finset (Fin n)) : Prop :=
  ((s.powerset.filter
      (fun t => f (fun i => decide (i ∈ t)) = true)).card % 2 = 1)

/-- Exactly algebraic degree three, not merely degree at most three. -/
def isCubic (n : ℕ) (f : Bits n → Bool) : Prop :=
  (∀ s : Finset (Fin n), anfNonzero n f s → s.card ≤ 3) ∧
  (∃ s : Finset (Fin n), anfNonzero n f s ∧ s.card = 3)

/-- Every nonzero ANF monomial has degree exactly three. -/
def isHomogeneousCubic (n : ℕ) (f : Bits n → Bool) : Prop :=
  isCubic n f ∧
    ∀ s : Finset (Fin n), anfNonzero n f s → s.card = 3

/-- Open mathematical target in any chosen dimension. This is a definition, not a theorem. -/
def noHomogeneousRotationSymmetricCubicBent (n : ℕ) : Prop :=
  ¬ ∃ f : Bits n → Bool,
      isRotationSymmetric n f ∧
      isHomogeneousCubic n f ∧
      isBent n f

/-- Specification for a genuine nonhomogeneous cubic RS bent counterexample. -/
def existsNonhomogeneousRotationSymmetricCubicBent (n : ℕ) : Prop :=
  ∃ f : Bits n → Bool,
    isRotationSymmetric n f ∧
    isCubic n f ∧
    ¬ isHomogeneousCubic n f ∧
    isBent n f

/-- Small computational sanity check; not yet compiler-certified. -/
example : isBent 2 (fun x => x 0 && x 1) := by
  decide

/-- A constant function must not satisfy the definition of bentness. -/
example : ¬ isBent 2 (fun _ => true) := by
  decide

end HRSBF_Audit
