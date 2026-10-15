import Antipodal.DerivativeBridge

/-! Integer Fourier inversion and the exact bent derivative criterion.
No degree or symmetry hypothesis is needed for the spectral identities. -/
namespace HRSBF.Antipodal
open Finset

def walsh {n : ℕ} (f : Vec n → F₂) (b : Vec n) : ℤ :=
  transform (fun x => sign (f x)) b

def IsBent {n : ℕ} (f : Vec n → F₂) : Prop :=
  ∀ b, walsh f b ^ 2 = (Fintype.card (Vec n) : ℤ)

def autocorrelation {n : ℕ} (f : Vec n → F₂) (a : Vec n) : ℤ :=
  ∑ x, sign (derivative f a x)

/-- Unnormalized Fourier inversion, entirely over the integers. -/
theorem transform_inversion {n : ℕ} (A : Vec n → ℤ) (a : Vec n) :
    transform (transform A) a = (Fintype.card (Vec n) : ℤ) * A a := by
  classical
  unfold transform
  simp_rw [sum_mul]
  rw [sum_comm]
  calc
    (∑ x, ∑ b, A x * character b x * character a b) =
        ∑ x, A x * (∑ b, character b x * character b a) := by
      apply sum_congr rfl
      intro x _
      rw [mul_sum]
      apply sum_congr rfl
      intro b _
      rw [show character a b = character b a from congrArg sign (dot_comm a b)]
      ring
    _ = ∑ x, A x * (if x = a then (Fintype.card (Vec n) : ℤ) else 0) := by
      simp_rw [character_orthogonality]
    _ = (Fintype.card (Vec n) : ℤ) * A a := by
      simp [mul_ite, mul_comm]

/-- Wiener--Khinchin identity, with no square-root convention. -/
theorem transform_autocorrelation {n : ℕ} (f : Vec n → F₂) (b : Vec n) :
    transform (autocorrelation f) b = walsh f b ^ 2 := by
  classical
  unfold transform autocorrelation walsh
  simp_rw [sum_mul]
  rw [sum_comm]
  calc
    (∑ x, ∑ a, sign (derivative f a x) * character b a) =
        ∑ x, ∑ y, sign (f y) * sign (f x) * character b (x + y) := by
      apply sum_congr rfl
      intro x _
      have hs := Equiv.sum_comp (Equiv.addLeft x)
        (fun a : Vec n => sign (derivative f a x) * character b a)
      rw [← hs]
      apply sum_congr rfl
      intro y _
      have hxx : x + (x + y) = y := by
        have hxx : x + x = 0 := by
          ext i
          exact CharTwo.add_self_eq_zero (x i)
        rw [← add_assoc, hxx, zero_add]
      simp only [Equiv.coe_addLeft, derivative, hxx, sign_add]
    _ = ∑ x, ∑ y, (sign (f x) * character b x) *
        (sign (f y) * character b y) := by
      apply sum_congr rfl
      intro x _
      apply sum_congr rfl
      intro y _
      rw [character_add]
      ring
    _ = (∑ x, sign (f x) * character b x) ^ 2 := by
      rw [pow_two, sum_mul_sum]

theorem bent_derivative_balanced {n : ℕ} (f : Vec n → F₂)
    (hb : IsBent f) (a : Vec n) (ha : a ≠ 0) :
    (∑ x, sign (derivative f a x)) = 0 := by
  classical
  have hC : (Fintype.card (Vec n) : ℤ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (Vec n) ≠ 0)
  have hinv := transform_inversion (autocorrelation f) a
  have htrans : transform (autocorrelation f) =
      fun _ => (Fintype.card (Vec n) : ℤ) := by
    funext b
    exact (transform_autocorrelation f b).trans (hb b)
  rw [htrans] at hinv
  have hz : transform (fun _ : Vec n => (Fintype.card (Vec n) : ℤ)) a = 0 := by
    unfold transform
    rw [← mul_sum, sum_character, if_neg ha, mul_zero]
  rw [hz] at hinv
  exact (mul_eq_zero.mp hinv.symm).resolve_left hC

theorem bent_of_derivative_balanced {n : ℕ} (f : Vec n → F₂)
    (hbal : ∀ a : Vec n, a ≠ 0 → (∑ x, sign (derivative f a x)) = 0) :
    IsBent f := by
  classical
  intro b
  rw [← transform_autocorrelation]
  have he : autocorrelation f = fun a =>
      if a = 0 then (Fintype.card (Vec n) : ℤ) else 0 := by
    funext a
    split_ifs with ha
    · subst a
      simp [autocorrelation, derivative, CharTwo.add_self_eq_zero, sign]
    · exact hbal a ha
  rw [he]
  simp only [transform, ite_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  simp [character, dot, sign]

theorem bent_iff_derivative_balanced {n : ℕ} (f : Vec n → F₂) :
    IsBent f ↔ ∀ a : Vec n, a ≠ 0 → (∑ x, sign (derivative f a x)) = 0 :=
  ⟨bent_derivative_balanced f, bent_of_derivative_balanced f⟩

/-- Bentness and cyclic invariance supply both analytic hypotheses of
quadratic rigidity for the all-ones derivative. -/
theorem bent_cyclic_cubic_derivative_polar_zero
    (k : ℕ) (hk : 1 ≤ k) (f : Vec (2^k) → F₂)
    (hc : HasCubicRepresentation f) (hb : IsBent f)
    (hs : ∀ x, f (cyclicShift (2^k) x) = f x) :
    ∀ a b, polar (derivative f ones) a b = 0 := by
  have hone : (ones : Vec (2^k)) ≠ 0 := by
    intro he
    have hi : 0 < 2^k := pow_pos (by omega) _
    have hh := congrFun he ⟨0, hi⟩
    norm_num [ones] at hh
  apply balanced_rotation_invariant_quadratic_polar_zero k hk
    (derivative f ones) (fun a b c => cubic_derivative_third_zero f hc ones a b c)
  · intro x
    have hsone : cyclicShift (2^k) ones = (ones : Vec (2^k)) := by rfl
    change f (cyclicShift (2^k) x + ones) + f (cyclicShift (2^k) x) = _
    rw [← hsone, ← map_add, hs, hs]
    rfl
  · exact bent_derivative_balanced f hb ones hone

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.transform_inversion
#print axioms HRSBF.Antipodal.transform_autocorrelation
#print axioms HRSBF.Antipodal.bent_iff_derivative_balanced
#print axioms HRSBF.Antipodal.bent_cyclic_cubic_derivative_polar_zero
