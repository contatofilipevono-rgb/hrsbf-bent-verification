import Antipodal.LocalRigidity

/-!
The characteristic-two parity mechanism used in the orbit-folding proof.
These statements DO NOT claim the full coefficient transport theorem:
identifying the source and target orbit multiplicities still remains.
-/

namespace HRSBF.Antipodal

/-- Even multiplicity cancels every coefficient in characteristic two. -/
theorem even_orbit_multiplicity_vanishes (m : ℕ) (hm : m % 2 = 0) (a : F₂) :
    m • a = 0 := by
  obtain ⟨k, hk⟩ : ∃ k : ℕ, m = k + k := by omega
  rw [hk, add_smul]
  exact CharTwo.add_self_eq_zero _

/-- Odd multiplicity preserves every coefficient in characteristic two. -/
theorem odd_orbit_multiplicity_preserves (m : ℕ) (hm : m % 2 = 1) (a : F₂) :
    m • a = a := by
  obtain ⟨k, hk⟩ : ∃ k : ℕ, m = k + k + 1 := by omega
  rw [hk, add_smul, add_smul, one_smul, CharTwo.add_self_eq_zero, zero_add]

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.even_orbit_multiplicity_vanishes
#print axioms HRSBF.Antipodal.odd_orbit_multiplicity_preserves
