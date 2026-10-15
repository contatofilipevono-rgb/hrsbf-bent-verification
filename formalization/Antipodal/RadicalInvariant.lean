import Antipodal.QuadraticBalanceBridge

/-!
The polar radical is a genuine F₂-submodule and is invariant under any
linear automorphism preserving the quadratic. A nonzero polar makes this
submodule proper. This is the exact interface required before applying
the nilpotent cyclic-module argument for dimensions N = 2^k.
-/

namespace HRSBF.Antipodal

private theorem polar_zero_left {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (x : V) : polar Q 0 x = 0 := by
  unfold polar
  simp only [zero_add]
  ring_nf
  simp

/-- The radical of the normalized polar, with no omitted affine terms. -/
def radicalSubmodule {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0) : Submodule F₂ V where
  carrier := {r | ∀ x, polar Q r x = 0}
  zero_mem' := by
    exact polar_zero_left Q
  add_mem' := by
    intro a b ha hb x
    rw [quadratic_polar_add_left Q hq]
    rw [ha x, hb x]
    exact zero_add 0
  smul_mem' := by
    intro c a ha x
    fin_cases c
    · simpa using polar_zero_left Q x
    · simpa using ha x

theorem mem_radicalSubmodule_iff {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0) (r : V) :
    r ∈ radicalSubmodule Q hq ↔ ∀ x, polar Q r x = 0 := Iff.rfl

/-- Invariance of the radical under an arbitrary linear equivalence. -/
theorem radical_stable_under_linear_equiv
    {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (S : V ≃ₗ[F₂] V) (hS : ∀ x, Q (S x) = Q x)
    (r : V) (hr : r ∈ radicalSubmodule Q hq) :
    S r ∈ radicalSubmodule Q hq := by
  rw [mem_radicalSubmodule_iff] at hr ⊢
  intro y
  calc
    polar Q (S r) y =
        polar Q (S r) (S (S.symm y)) := by rw [S.apply_symm_apply]
    _ = polar (fun x => Q (S x)) r (S.symm y) := by
      simp only [polar, map_add, map_zero]
    _ = polar Q r (S.symm y) := by simp only [hS]
    _ = 0 := hr _

/-- A nonzero polar implies its radical is a proper submodule. -/
theorem radical_proper_of_nonzero_polar
    {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (hB : ∃ a b, polar Q a b ≠ 0) :
    radicalSubmodule Q hq ≠ ⊤ := by
  intro htop
  obtain ⟨a, b, hab⟩ := hB
  have ha : a ∈ radicalSubmodule Q hq := by
    rw [htop]
    exact Submodule.mem_top
  exact hab ((mem_radicalSubmodule_iff Q hq a).mp ha b)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.radical_stable_under_linear_equiv
#print axioms HRSBF.Antipodal.radical_proper_of_nonzero_polar
