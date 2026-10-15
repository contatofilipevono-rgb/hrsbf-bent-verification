import Mathlib.Algebra.CharP.Lemmas
import Antipodal.QuadraticBalanceBridge

/-!
An algebraic characteristic-two identity for power-of-two cyclic maps.
This does not yet prove the geometric fact that every proper invariant
submodule lies in the range of S+I, but it supplies its nilpotent operator.
-/

namespace HRSBF.Antipodal

/-- In characteristic two the operator S+I is nilpotent whenever the
order of S divides a power of two. The order hypothesis is explicit. -/
theorem shift_plus_one_nilpotent {V : Type*} [AddCommGroup V] [Module F₂ V]
    (S : Module.End F₂ V) (k : ℕ)
    (hpow : S ^ (2 ^ k) = 1) :
    (S + 1) ^ (2 ^ k) = 0 := by
  have hcomm : Commute S (1 : Module.End F₂ V) := Commute.one_right S
  rw [Commute.add_pow_char_pow_of_commute 2 k hcomm]
  rw [hpow, one_pow]
  exact CharTwo.add_self_eq_zero (1 : Module.End F₂ V)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.shift_plus_one_nilpotent
