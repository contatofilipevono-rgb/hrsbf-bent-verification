import Antipodal.QuadraticRadical
import Antipodal.QuadraticPolar

/-!
The exact integer quadratic Walsh-square identity. This is valid in
*every finite binary vector dimension* and does not assume rotation
symmetry, a power-of-two dimension, or that the radical is trivial.
The critical hypothesis is vanishing third differences.
-/

namespace HRSBF.Antipodal
open Finset

def polarRadical {n : ℕ} (Q : Vec n → F₂) (r : Vec n) : Prop :=
  ∀ x, polar Q r x = 0

private lemma quadratic_sign_pair {n : ℕ} (Q : Vec n → F₂)
    (r x : Vec n) :
    sign (Q (x + r)) * sign (Q x) =
      sign (Q r + Q 0) * sign (polar Q r x) := by
  have heq : Q (x + r) + Q x = (Q r + Q 0) + polar Q r x := by
    unfold polar
    rw [add_comm x r]
    ring
  calc
    sign (Q (x + r)) * sign (Q x) = sign (Q (x + r) + Q x) := by
      rw [sign_add]
    _ = sign ((Q r + Q 0) + polar Q r x) := by rw [heq]
    _ = sign (Q r + Q 0) * sign (polar Q r x) := sign_add _ _

private lemma square_sum_as_correlation {n : ℕ} (Q : Vec n → F₂) :
    (∑ x : Vec n, sign (Q x)) ^ 2 =
      ∑ r : Vec n, ∑ x : Vec n,
        sign (Q (x + r)) * sign (Q x) := by
  classical
  calc
    (∑ x : Vec n, sign (Q x)) ^ 2 =
        ∑ x : Vec n, ∑ y : Vec n, sign (Q x) * sign (Q y) := by
          rw [pow_two, sum_mul_sum]
    _ = ∑ x : Vec n, ∑ r : Vec n,
          sign (Q x) * sign (Q (x + r)) := by
          apply sum_congr rfl
          intro x _
          exact (Equiv.sum_comp (Equiv.addLeft x)
            (fun y : Vec n => sign (Q x) * sign (Q y))).symm
    _ = ∑ r : Vec n, ∑ x : Vec n,
          sign (Q (x + r)) * sign (Q x) := by
          rw [sum_comm]
          apply sum_congr rfl
          intro r _
          apply sum_congr rfl
          intro x _
          ring

/-- Exact Gauss identity. This is NOT a full proof of quadratic rigidity.
It becomes a contradiction to balance once the radical is shown to lie in
im(S+I), so that Q is constant there and the sum has nonzero magnitude. -/
theorem quadratic_walsh_square {n : ℕ} (Q : Vec n → F₂)
    (hq : ∀ a b c, third Q a b c = 0) :
    (∑ x : Vec n, sign (Q x)) ^ 2 =
      (Fintype.card (Vec n) : ℤ) *
        ∑ r : Vec n, if polarRadical Q r
          then sign (Q r + Q 0) else 0 := by
  classical
  rw [square_sum_as_correlation]
  have hlin (r : Vec n) :
      (∑ x : Vec n, sign (polar Q r x)) =
       if polarRadical Q r
       then (Fintype.card (Vec n) : ℤ) else 0 := by
    exact sum_sign_additive (fun x => polar Q r x)
      (quadratic_polar_add_right Q hq r)
  calc
    (∑ r : Vec n, ∑ x : Vec n,
      sign (Q (x + r)) * sign (Q x)) =
        ∑ r : Vec n, ∑ x : Vec n,
          sign (Q r + Q 0) * sign (polar Q r x) := by
          apply sum_congr rfl
          intro r _
          apply sum_congr rfl
          intro x _
          exact quadratic_sign_pair Q r x
    _ = ∑ r : Vec n,
        sign (Q r + Q 0) *
          (if polarRadical Q r then (Fintype.card (Vec n) : ℤ) else 0) := by
          apply sum_congr rfl
          intro r _
          rw [← mul_sum, hlin]
    _ = (Fintype.card (Vec n) : ℤ) *
      ∑ r : Vec n, if polarRadical Q r then sign (Q r + Q 0) else 0 := by
          rw [mul_sum]
          apply sum_congr rfl
          intro r _
          split_ifs <;> ring

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.quadratic_walsh_square
