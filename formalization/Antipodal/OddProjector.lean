import Antipodal.FiniteQuadratic

/-! Explicit averaging projector for an odd-order linear symmetry.
The kernel is fixed-point-free, which is the algebraic prerequisite
for the nonzero quadratic Gauss factor. -/
namespace HRSBF.Antipodal
open Finset

noncomputable def orbitAverage {V : Type*} [AddCommGroup V] [Module F₂ V] (S : V ≃ₗ[F₂] V) (m : ℕ) :
    Module.End F₂ (V) := ∑ j ∈ range m, S.toLinearMap ^ j

theorem orbitAverage_fixed {V : Type*} [AddCommGroup V] [Module F₂ V] (S : V ≃ₗ[F₂] V) (m : ℕ)
    (hm : S.toLinearMap ^ m = 1) (x : V) :
    S (orbitAverage S m x) = orbitAverage S m x := by
  have he : S.toLinearMap * orbitAverage S m = orbitAverage S m := by
    unfold orbitAverage
    rw [mul_sum]
    simp_rw [← pow_succ']
    have h1 := sum_range_succ (fun j => S.toLinearMap ^ j) m
    have h2 := sum_range_succ' (fun j => S.toLinearMap ^ j) m
    rw [hm] at h1
    rw [pow_zero] at h2
    exact add_right_cancel (h2.symm.trans h1)
  exact congrArg (fun T : Module.End F₂ (V) => T x) he

theorem orbitAverage_of_fixed {V : Type*} [AddCommGroup V] [Module F₂ V] (S : V ≃ₗ[F₂] V) (m : ℕ)
    (hm : Odd m) (x : V) (hx : S x = x) : orbitAverage S m x = x := by
  have hp (j : ℕ) : (S.toLinearMap ^ j) x = x := by
    induction j with
    | zero => rfl
    | succ j ih =>
      rw [pow_succ']
      change S ((S.toLinearMap ^ j) x) = x
      rw [ih, hx]
  have hc : (m : F₂) = 1 := natCast_eq_one_of_odd_of_two_eq_zero hm (by decide)
  change (∑ j ∈ range m, S.toLinearMap ^ j) x = x
  simp only [LinearMap.sum_apply, hp, sum_const, card_range]
  rw [← Nat.cast_smul_eq_nsmul F₂, hc, one_smul]

/-- Idempotence follows from the fixed image, with no extra hypothesis. -/
theorem orbitAverage_idempotent {V : Type*} [AddCommGroup V] [Module F₂ V] (S : V ≃ₗ[F₂] V) (m : ℕ)
    (hodd : Odd m) (horder : S.toLinearMap ^ m = 1) :
    orbitAverage S m * orbitAverage S m = orbitAverage S m := by
  apply LinearMap.ext
  intro x
  exact orbitAverage_of_fixed S m hodd _ (orbitAverage_fixed S m horder x)

/-- The averaging kernel contains no nonzero fixed vector. -/
theorem orbitAverage_kernel_fixed_free {V : Type*} [AddCommGroup V] [Module F₂ V]
    (S : V ≃ₗ[F₂] V) (m : ℕ) (hodd : Odd m)
    (x : V) (hx : orbitAverage S m x = 0) (hSx : S x = x) : x = 0 := by
  rw [orbitAverage_of_fixed S m hodd x hSx] at hx
  exact hx

/-- Explicit decomposition into fixed and averaging-kernel parts. -/
theorem orbitAverage_decomposition {V : Type*} [AddCommGroup V] [Module F₂ V]
    (S : V ≃ₗ[F₂] V) (m : ℕ) (hodd : Odd m)
    (horder : S.toLinearMap ^ m = 1) (x : V) :
    S (orbitAverage S m x) = orbitAverage S m x ∧
    orbitAverage S m (x + orbitAverage S m x) = 0 ∧
    x = orbitAverage S m x + (x + orbitAverage S m x) := by
  have hp : orbitAverage S m (orbitAverage S m x) = orbitAverage S m x :=
    congrArg (fun T : Module.End F₂ (V) => T x)
      (orbitAverage_idempotent S m hodd horder)
  have twice (v : V) : v + v = 0 := module_twice_zero v
  refine ⟨orbitAverage_fixed S m horder x, ?_, ?_⟩
  · rw [map_add, hp, twice]
  · have h : orbitAverage S m x + (x + orbitAverage S m x) =
        x + (orbitAverage S m x + orbitAverage S m x) := by abel
    rw [h, twice, add_zero]

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.orbitAverage_fixed
#print axioms HRSBF.Antipodal.orbitAverage_of_fixed
#print axioms HRSBF.Antipodal.orbitAverage_idempotent
#print axioms HRSBF.Antipodal.orbitAverage_kernel_fixed_free
#print axioms HRSBF.Antipodal.orbitAverage_decomposition
