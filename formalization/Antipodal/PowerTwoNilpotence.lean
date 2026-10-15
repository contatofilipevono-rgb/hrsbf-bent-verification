import Antipodal.QuadraticBalanceBridge

/-!
Elementary characteristic-two Frobenius for endomorphisms commuting with 1.
This intentionally avoids requiring a CharP instance for Module.End.
-/

namespace HRSBF.Antipodal

private theorem end_add_self_zero {V : Type*} [AddCommGroup V] [Module F₂ V]
    (A : Module.End F₂ V) : A + A = 0 := by
  ext x
  have h11 : (1 : F₂) + 1 = 0 := by decide
  have hz : ((1 : F₂) + 1) • (A x) = 0 := by rw [h11]; simp
  simpa only [add_smul, one_smul] using hz

private theorem end_add_one_square {V : Type*} [AddCommGroup V] [Module F₂ V]
    (A : Module.End F₂ V) : (A + 1) ^ 2 = A ^ 2 + 1 := by
  calc
    (A + 1) ^ 2 = A * A + (A + A) + 1 := by
      simp only [pow_two, mul_add, add_mul, mul_one, one_mul]
      abel
    _ = A ^ 2 + 1 := by rw [end_add_self_zero]; simp [pow_two]

/-- Characteristic-two nilpotence whenever S has power-of-two order.
The order hypothesis is explicit; the concrete cyclic-shift order is
a separate finite-index proof obligation. -/
theorem shift_plus_one_nilpotent {V : Type*} [AddCommGroup V] [Module F₂ V]
    (S : Module.End F₂ V) (k : ℕ)
    (hpow : S ^ (2 ^ k) = 1) :
    (S + 1) ^ (2 ^ k) = 0 := by
  have hfrob (j : ℕ) : (S + 1) ^ (2 ^ j) = S ^ (2 ^ j) + 1 := by
    induction j with
    | zero => simp
    | succ j ih =>
      calc
        (S + 1) ^ (2 ^ (j + 1)) = ((S + 1) ^ (2 ^ j)) ^ 2 := by
          rw [pow_succ, pow_mul]
        _ = (S ^ (2 ^ j) + 1) ^ 2 := by rw [ih]
        _ = (S ^ (2 ^ j)) ^ 2 + 1 := end_add_one_square _
        _ = S ^ (2 ^ (j + 1)) + 1 := by
          have hm : 2 ^ (j + 1) = (2 ^ j) * 2 := pow_succ 2 j
          rw [hm, pow_mul]
  rw [hfrob, hpow]
  exact end_add_self_zero (1 : Module.End F₂ V)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.shift_plus_one_nilpotent
