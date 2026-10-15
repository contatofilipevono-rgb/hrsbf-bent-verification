import Antipodal.NilpotentNakayama

/-!
A characteristic-two Nakayama bridge: when range(T) is a hyperplane,
any proper T-invariant submodule is contained in range(T), provided T
is nilpotent. The hyperplane-decomposition hypothesis is explicit and
will be discharged for the concrete cyclic shift using parity.
-/

namespace HRSBF.Antipodal

theorem proper_stable_le_range_of_nilpotent_hyperplane
    {V : Type*} [AddCommGroup V] [Module F₂ V]
    (T : Module.End F₂ V) (R : Submodule F₂ V) (m : ℕ)
    (hnil : T ^ m = 0)
    (hstable : ∀ r ∈ R, T r ∈ R)
    (hspan : ∀ r : V, (¬ ∃ y : V, r = T y) →
      ∀ x : V, ∃ c : F₂, ∃ y : V, x = c • r + T y)
    (hproper : R ≠ ⊤) :
    ∀ r ∈ R, ∃ y : V, r = T y := by
  intro r hr
  by_contra hn
  have hdecomp : ∀ x : V, ∃ s : V, s ∈ R ∧
      ∃ y : V, x = s + T y := by
    intro x
    obtain ⟨c, y, heq⟩ := hspan r hn x
    exact ⟨c • r, R.smul_mem c hr, y, heq⟩
  exact hproper (nilpotent_stable_decomposition_forces_top T R m
    hnil hstable hdecomp)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.proper_stable_le_range_of_nilpotent_hyperplane
