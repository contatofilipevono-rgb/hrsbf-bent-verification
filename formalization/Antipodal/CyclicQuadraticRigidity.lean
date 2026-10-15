import Antipodal.RadicalInvariant
import Antipodal.PowerTwoNilpotence
import Antipodal.NilpotentHyperplane
import Mathlib.Algebra.BigOperators.Fin

namespace HRSBF.Antipodal
open Finset

/-- The actual one-coordinate cyclic rotation, as a linear automorphism. -/
def cyclicShift (n : ℕ) : Vec n ≃ₗ[F₂] Vec n where
  toFun x i := x (finRotate n i)
  invFun x i := x ((finRotate n).symm i)
  left_inv x := by funext i; simp
  right_inv x := by funext i; simp
  map_add' x y := rfl
  map_smul' c x := rfl

/-- Coordinate parity, including all coordinates exactly once. -/
def parity (n : ℕ) : Vec n →ₗ[F₂] F₂ where
  toFun v := ∑ i, v i
  map_add' v w := sum_add_distrib
  map_smul' c v := by simp [Finset.mul_sum]

private def partialSum {n : ℕ} (v : Vec n) (m : ℕ) : F₂ :=
  ∑ j ∈ range m, if h : j < n then v ⟨j,h⟩ else 0

private lemma prefix_succ {n : ℕ} (v : Vec n) (i : Fin n) :
    partialSum v (i.val+1) = partialSum v i.val + v i := by
  simp [partialSum, sum_range_succ, i.isLt]

private lemma prefix_full {n : ℕ} (v : Vec n) : partialSum v n = parity n v := by
  unfold partialSum
  rw [← Fin.sum_univ_eq_sum_range]
  simp [parity]

/-- Constructive wraparound solution of y(i+1)+y(i)=v(i). -/
theorem cyclic_image_of_parity_zero {n : ℕ} (v : Vec n)
    (hv : parity n v = 0) :
    ∃ y, v = cyclicShift n y + y := by
  cases n with
  | zero => exact ⟨0, Subsingleton.elim _ _⟩
  | succ n =>
    let y : Vec (n+1) := fun i => partialSum v i.val
    refine ⟨y, ?_⟩
    funext i
    change v i = y (finRotate (n+1) i) + y i
    by_cases hi : i.val < n
    · rw [show finRotate (n+1) i = ⟨i.val+1, Nat.succ_lt_succ hi⟩ from finRotate_of_lt hi]
      change v i = partialSum v (i.val+1) + partialSum v i.val
      rw [prefix_succ]
      simp [add_assoc, add_comm, add_left_comm, CharTwo.add_self_eq_zero]
    · have he : i = Fin.last n := Fin.ext (by dsimp; omega)
      subst i
      rw [finRotate_last]
      change v (Fin.last n) = partialSum v 0 + partialSum v n
      have hh := prefix_succ v (Fin.last n)
      have hz : partialSum v (n+1) = 0 := (prefix_full v).trans hv
      simp only [Fin.val_last] at hh
      rw [hz] at hh
      have heq := congrArg (fun z : F₂ => z + v (Fin.last n)) hh
      simpa [partialSum, add_assoc, CharTwo.add_self_eq_zero] using heq

theorem parity_cyclicShift {n : ℕ} (v : Vec n) :
    parity n (cyclicShift n v) = parity n v := by
  exact Equiv.sum_comp (finRotate n) v

theorem cyclic_image_iff_parity_zero {n : ℕ} (v : Vec n) :
    (∃ y, v = cyclicShift n y + y) ↔ parity n v = 0 := by
  constructor
  · rintro ⟨y, rfl⟩
    rw [map_add, parity_cyclicShift]
    exact CharTwo.add_self_eq_zero _
  · exact cyclic_image_of_parity_zero v

/-- Exact equality of subspaces, not just one inclusion. -/
theorem cyclic_range_eq_parity_ker (n : ℕ) :
    LinearMap.range ((cyclicShift n).toLinearMap + 1) = LinearMap.ker (parity n) := by
  ext v
  simp only [LinearMap.mem_range, LinearMap.mem_ker]
  exact (show (∃ y, cyclicShift n y + y = v) ↔ parity n v = 0 from
    (exists_congr (fun y => eq_comm)).trans (cyclic_image_iff_parity_zero v))

end HRSBF.Antipodal

namespace HRSBF.Antipodal

/-- The cyclic rotation returns after exactly n steps (order divides n). -/
theorem cyclicShift_pow (n : ℕ) : (cyclicShift n).toLinearMap ^ n = 1 := by
  cases n with
  | zero => simp
  | succ n =>
    have hp (m : ℕ) (x : Vec (n+1)) (i : Fin (n+1)) :
        ((cyclicShift (n+1)).toLinearMap ^ m) x i = x (i + (m : Fin (n+1))) := by
      induction m generalizing i with
      | zero => simp
      | succ m ih =>
        rw [pow_succ']
        change ((cyclicShift (n+1)).toLinearMap ^ m) x (finRotate (n+1) i) = _
        rw [ih, finRotate_succ_apply, Nat.cast_add, Nat.cast_one]
        congr 1
        abel
    apply LinearMap.ext
    intro x
    funext i
    change ((cyclicShift (n+1)).toLinearMap ^ (n+1)) x i = x i
    rw [hp]
    simp

private theorem cyclic_hyperplane_decomposition {n : ℕ}
    (r : Vec n) (hr : ¬ ∃ y, r = cyclicShift n y + y)
    (x : Vec n) : ∃ c : F₂, ∃ y, x = c • r + (cyclicShift n y + y) := by
  have hrp : parity n r = 1 := by
    have hn : parity n r ≠ 0 := fun h => hr (cyclic_image_of_parity_zero r h)
    exact ((by decide : ∀ c : F₂, c = 0 ∨ c = 1) (parity n r)).resolve_left hn
  obtain ⟨y, hy⟩ := cyclic_image_of_parity_zero (x + (parity n x) • r) (by
    rw [map_add, map_smul, hrp]
    simp [CharTwo.add_self_eq_zero])
  refine ⟨parity n x, y, ?_⟩
  rw [← hy]
  have hh : (parity n x) • r + (parity n x) • r = 0 := by
    rw [← add_smul, CharTwo.add_self_eq_zero, zero_smul]
  calc
    x = x + ((parity n x) • r + (parity n x) • r) := by rw [hh, add_zero]
    _ = (parity n x) • r + (x + (parity n x) • r) := by abel

/-- The missing proper-radical image theorem, with no coefficient restrictions. -/
theorem cyclic_quadratic_radical_image (k : ℕ)
    (Q : Vec (2^k) → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (hs : ∀ x, Q (cyclicShift (2^k) x) = Q x)
    (hB : ∃ a b, polar Q a b ≠ 0) :
    ∀ r, polarRadical Q r → ∃ y, r = cyclicShift (2^k) y + y := by
  let S := cyclicShift (2^k)
  let T : Module.End F₂ (Vec (2^k)) := S.toLinearMap + 1
  let R := radicalSubmodule Q hq
  have hnil : T ^ (2^k) = 0 := shift_plus_one_nilpotent S.toLinearMap k (cyclicShift_pow _)
  have hstable : ∀ r ∈ R, T r ∈ R := by
    intro r hr
    exact R.add_mem (radical_stable_under_linear_equiv Q hq S hs r hr) hr
  have hspan : ∀ r : Vec (2^k), (¬ ∃ y, r = T y) →
      ∀ x, ∃ c : F₂, ∃ y, x = c • r + T y := by
    exact cyclic_hyperplane_decomposition
  have hproper : R ≠ ⊤ := radical_proper_of_nonzero_polar Q hq hB
  exact proper_stable_le_range_of_nilpotent_hyperplane T R (2^k) hnil hstable hspan hproper

/-- Universal quadratic rigidity in power-of-two dimension.
`third` and `polar` include the constant term Q(0); affine terms are unrestricted. -/
theorem balanced_rotation_invariant_quadratic_polar_zero
    (k : ℕ) (hk : 1 ≤ k) (Q : Vec (2^k) → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (hs : ∀ x, Q (rotate x) = Q x)
    (hbalanced : (∑ x : Vec (2^k), sign (Q x)) = 0) :
    ∀ u v, polar Q u v = 0 := by
  exact balanced_polar_zero_of_proper_radical_image Q (cyclicShift (2^k)) hq hs
    (cyclic_quadratic_radical_image k Q hq hs) hbalanced

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.cyclicShift_pow
#print axioms HRSBF.Antipodal.cyclic_range_eq_parity_ker
#print axioms HRSBF.Antipodal.cyclic_quadratic_radical_image
#print axioms HRSBF.Antipodal.balanced_rotation_invariant_quadratic_polar_zero
