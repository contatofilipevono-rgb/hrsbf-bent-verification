import Antipodal.QuadraticBalanceBridge
import Mathlib.Algebra.Module.LinearMap.End

/-!
Elementary nilpotent Nakayama lemma for one endomorphism, without an
abstract local ring. If R is stable under a nilpotent T and every vector
is R + im(T), then R is the entire space. No finite-dimensionality
assumption is needed beyond the explicit nilpotence index.
-/

namespace HRSBF.Antipodal

theorem nilpotent_stable_decomposition_forces_top
    {V : Type*} [AddCommGroup V] [Module F₂ V]
    (T : Module.End F₂ V) (R : Submodule F₂ V) (m : ℕ)
    (hnil : T ^ m = 0)
    (hstable : ∀ r ∈ R, T r ∈ R)
    (hdecomp : ∀ x : V, ∃ r : V, r ∈ R ∧ ∃ y : V, x = r + T y) :
    R = ⊤ := by
  have hstablePow : ∀ k : ℕ, ∀ r ∈ R, (T ^ k) r ∈ R := by
    intro k
    induction k with
    | zero =>
        intro r hr
        simpa using hr
    | succ k ih =>
        intro r hr
        have ht := hstable r hr
        have hi := ih (T r) ht
        simpa only [pow_succ, Module.End.mul_apply] using hi
  have hiter : ∀ k : ℕ, ∀ x : V,
      ∃ r : V, r ∈ R ∧ ∃ y : V, x = r + (T ^ k) y := by
    intro k
    induction k with
    | zero =>
        intro x
        refine ⟨0, R.zero_mem, x, ?_⟩
        simp
    | succ k ih =>
        intro x
        obtain ⟨r, hr, y, hy⟩ := ih x
        obtain ⟨s, hs, z, hz⟩ := hdecomp y
        refine ⟨r + (T ^ k) s, R.add_mem hr (hstablePow k s hs), z, ?_⟩
        calc
          x = r + (T ^ k) y := hy
          _ = r + (T ^ k) (s + T z) := by rw [hz]
          _ = (r + (T ^ k) s) + (T ^ (k + 1)) z := by
            simp only [map_add, pow_succ, Module.End.mul_apply]
            abel
  ext x
  constructor
  · intro _
    exact Submodule.mem_top
  · intro _
    obtain ⟨r, hr, y, hy⟩ := hiter m x
    have hz : (T ^ m) y = 0 := by rw [hnil]; rfl
    have hx : x = r := by simpa only [hz, add_zero] using hy
    rw [hx]
    exact hr

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.nilpotent_stable_decomposition_forces_top
