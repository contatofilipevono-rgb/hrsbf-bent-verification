import Antipodal.QuadraticGauss

/-!
A conditional completion of the analytic half of quadratic rigidity.
The next theorem is *not* the power-of-two local-ring statement:
the needed radical-image inclusion is explicitly assumed where used.
-/

namespace HRSBF.Antipodal
open Finset

/-- If a Boolean quadratic is constant on its polar radical, its Walsh
sum at frequency zero cannot be balanced. -/
theorem quadratic_unbalanced_of_radical_constant {n : ℕ}
    (Q : Vec n → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (hconst : ∀ r, polarRadical Q r → Q r = Q 0) :
    (∑ x : Vec n, sign (Q x)) ≠ 0 := by
  classical
  let R : Finset (Vec n) := univ.filter (polarRadical Q)
  have hzero : polarRadical Q 0 := by
    intro x
    unfold polar
    simp only [zero_add]
    ring_nf
    simp
  have hRpos : 0 < R.card := Finset.card_pos.mpr ⟨0, by
    simp only [R, mem_filter, mem_univ, true_and]
    exact hzero⟩
  have hsum :
      (∑ r : Vec n, if polarRadical Q r
          then sign (Q r + Q 0) else 0) = (R.card : ℤ) := by
    calc
      _ = ∑ r ∈ R, sign (Q r + Q 0) := by
        simp [R, Finset.sum_filter]
      _ = ∑ r ∈ R, (1 : ℤ) := by
        apply Finset.sum_congr rfl
        intro r hr
        have hqr := hconst r (Finset.mem_filter.mp hr).2
        simp [hqr, sign]
      _ = (R.card : ℤ) := by simp
  intro hbal
  have hgauss := quadratic_walsh_square Q hq
  rw [hbal, zero_pow (by omega : (2 : ℕ) ≠ 0), hsum] at hgauss
  have hC : (Fintype.card (Vec n) : ℤ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (Vec n) ≠ 0)
  have hR : (R.card : ℤ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hRpos)
  exact (mul_ne_zero hC hR) hgauss.symm

/-- The exact analytic consequence of the remaining local-ring inclusion:
a balanced invariant quadratic has zero polar if every nonzero-polar
invariant radical lies in im(S+I). This premise is NOT proved here. -/
theorem balanced_polar_zero_of_proper_radical_image {n : ℕ}
    (Q : Vec n → F₂) (S : Vec n → Vec n)
    (hq : ∀ a b c, third Q a b c = 0)
    (hs : ∀ x, Q (S x) = Q x)
    (himage : (∃ a b, polar Q a b ≠ 0) →
      ∀ r, polarRadical Q r → ∃ y, r = S y + y)
    (hbalanced : (∑ x : Vec n, sign (Q x)) = 0) :
    ∀ a b, polar Q a b = 0 := by
  by_contra hn
  push_neg at hn
  obtain ⟨a, b, hab⟩ := hn
  have hconst : ∀ r, polarRadical Q r → Q r = Q 0 :=
    radical_vanishes_of_image Q S hs (by
      intro r hr
      exact (himage ⟨a, b, hab⟩ r hr))
  exact (quadratic_unbalanced_of_radical_constant Q hq hconst) hbalanced

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.quadratic_unbalanced_of_radical_constant
#print axioms HRSBF.Antipodal.balanced_polar_zero_of_proper_radical_image
