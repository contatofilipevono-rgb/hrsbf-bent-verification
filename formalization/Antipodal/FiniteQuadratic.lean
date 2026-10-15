import Antipodal.FixedFreeQuadratic

/-! Dimension-free finite-module Gauss identities for subspaces in the odd-order reduction.
These extend the existing Vec results; no basis choice is required. -/
namespace HRSBF.Antipodal
open Finset
theorem finite_sum_sign_additive {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (l : V → F₂)
    (hl : ∀ x y, l (x + y) = l x + l y) :
    (∑ x : V, sign (l x)) =
      if ∀ x, l x = 0 then (Fintype.card (V) : ℤ) else 0 := by
  classical
  split_ifs with hz
  · simp [hz, sign]
  · push_neg at hz
    obtain ⟨a, ha⟩ := hz
    have h01 : ∀ b : F₂, b = 0 ∨ b = 1 := by decide
    have ha1 : l a = 1 := (h01 (l a)).resolve_left ha
    have hshift (x : V) : sign (l (x + a)) = -sign (l x) := by
      rw [hl, sign_add, ha1]
      norm_num [sign]
    have hs := Equiv.sum_comp (Equiv.addRight a) (fun x => sign (l x))
    simp only [Equiv.coe_addRight, hshift] at hs
    rw [sum_neg_distrib] at hs
    omega

def finite_polarRadical {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂) (r : V) : Prop :=
  ∀ x, polar Q r x = 0

instance decidableFinitePolarRadical {V : Type*}
    [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂) (r : V) :
    Decidable (finite_polarRadical Q r) := by
  unfold finite_polarRadical
  infer_instance

private lemma finite_quadratic_sign_pair {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂)
    (r x : V) :
    sign (Q (x + r)) * sign (Q x) =
      sign (Q r + Q 0) * sign (polar Q r x) := by
  have heq : Q (x + r) + Q x = (Q r + Q 0) + polar Q r x := by
    unfold polar
    rw [add_comm x r]
    ring_nf
    simp
  calc
    sign (Q (x + r)) * sign (Q x) = sign (Q (x + r) + Q x) := by
      rw [sign_add]
    _ = sign ((Q r + Q 0) + polar Q r x) := by rw [heq]
    _ = sign (Q r + Q 0) * sign (polar Q r x) := sign_add _ _

private lemma finite_square_sum_as_correlation {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂) :
    (∑ x : V, sign (Q x)) ^ 2 =
      ∑ r : V, ∑ x : V,
        sign (Q (x + r)) * sign (Q x) := by
  classical
  calc
    (∑ x : V, sign (Q x)) ^ 2 =
        ∑ x : V, ∑ y : V, sign (Q x) * sign (Q y) := by
          rw [pow_two, sum_mul_sum]
    _ = ∑ x : V, ∑ r : V,
          sign (Q x) * sign (Q (x + r)) := by
          apply sum_congr rfl
          intro x _
          exact (Equiv.sum_comp (Equiv.addLeft x)
            (fun y : V => sign (Q x) * sign (Q y))).symm
    _ = ∑ r : V, ∑ x : V,
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
theorem finite_quadratic_walsh_square {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂)
    (hq : ∀ a b c, third Q a b c = 0) :
    (∑ x : V, sign (Q x)) ^ 2 =
      (Fintype.card (V) : ℤ) *
        ∑ r : V, if finite_polarRadical Q r
          then sign (Q r + Q 0) else 0 := by
  classical
  rw [finite_square_sum_as_correlation]
  have hlin (r : V) :
      (∑ x : V, sign (polar Q r x)) =
       if finite_polarRadical Q r
       then (Fintype.card (V) : ℤ) else 0 := by
    simpa only [finite_polarRadical] using
      (finite_sum_sign_additive (fun x => polar Q r x)
        (quadratic_polar_add_right Q hq r))
  calc
    (∑ r : V, ∑ x : V,
      sign (Q (x + r)) * sign (Q x)) =
        ∑ r : V, ∑ x : V,
          sign (Q r + Q 0) * sign (polar Q r x) := by
          apply sum_congr rfl
          intro r _
          apply sum_congr rfl
          intro x _
          exact finite_quadratic_sign_pair Q r x
    _ = ∑ r : V,
        sign (Q r + Q 0) *
          (if finite_polarRadical Q r then (Fintype.card (V) : ℤ) else 0) := by
          apply sum_congr rfl
          intro r _
          rw [← mul_sum, hlin]
    _ = (Fintype.card (V) : ℤ) *
      ∑ r : V, if finite_polarRadical Q r then sign (Q r + Q 0) else 0 := by
          rw [mul_sum]
          apply sum_congr rfl
          intro r _
          split_ifs <;> ring

theorem finite_quadratic_unbalanced_of_radical_constant {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V]
    (Q : V → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (hconst : ∀ r, finite_polarRadical Q r → Q r = Q 0) :
    (∑ x : V, sign (Q x)) ≠ 0 := by
  classical
  let R : Finset (V) := univ.filter (finite_polarRadical Q)
  have hzero : finite_polarRadical Q 0 := by
    intro x
    unfold polar
    simp only [zero_add]
    ring_nf
    simp
  have hRpos : 0 < R.card := Finset.card_pos.mpr ⟨0, by
    simp only [R, mem_filter, mem_univ, true_and]
    exact hzero⟩
  have hsum :
      (∑ r : V, if finite_polarRadical Q r
          then sign (Q r + Q 0) else 0) = (R.card : ℤ) := by
    calc
      _ = ∑ r ∈ R, sign (Q r + Q 0) := by
        simp [R, Finset.sum_filter]
      _ = ∑ r ∈ R, (1 : ℤ) := by
        apply Finset.sum_congr rfl
        intro r hr
        have hqr := hconst r (Finset.mem_filter.mp hr).2
        simp [hqr, sign, CharTwo.add_self_eq_zero]
      _ = (R.card : ℤ) := by simp
  intro hbal
  have hgauss := finite_quadratic_walsh_square Q hq
  rw [hbal, zero_pow (by omega : (2 : ℕ) ≠ 0), hsum] at hgauss
  have hC : (Fintype.card (V) : ℤ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (V) ≠ 0)
  have hR : (R.card : ℤ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hRpos)
  exact (mul_ne_zero hC hR) hgauss.symm


/-- Every module over F₂ has exponent two, including zero-dimensional modules. -/
theorem module_twice_zero {V : Type*} [AddCommGroup V] [Module F₂ V] (x : V) :
    x + x = 0 := by
  simpa only [f2_num_2, zero_smul] using (two_smul F₂ x).symm

theorem finite_radical_image_value_zero {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (S : V → V)
    (hshift : ∀ x, Q (S x) = Q x)
    (r y : V) (himage : r = S y + y)
    (hrad : polar Q r y = 0) : Q r = Q 0 := by
  have hry : r + y = S y := by
    rw [himage, add_assoc, module_twice_zero, add_zero]
  have hp : Q (S y) + Q r + Q y + Q 0 = 0 := by
    simpa only [polar, hry] using hrad
  rw [hshift y] at hp
  have hz : Q r + Q 0 = 0 := by
    calc
      Q r + Q 0 = Q y + Q r + Q y + Q 0 := by
        ring_nf
        simp
      _ = 0 := hp
  have hq := congrArg (fun a : F₂ => a + Q 0) hz
  simpa only [add_assoc, CharTwo.add_self_eq_zero, add_zero, zero_add] using hq

theorem finite_fixed_free_radical_image {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V] (Q : V → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (S : V ≃ₗ[F₂] V) (hs : ∀ x, Q (S x) = Q x)
    (hfixed : ∀ x, S x = x → x = 0) :
    ∀ r, finite_polarRadical Q r → ∃ y, r = S y + y := by
  classical
  let R := radicalSubmodule Q hq
  let T : R → R := fun r => ⟨S r + r,
    R.add_mem (radical_stable_under_linear_equiv Q hq S hs r r.property) r.property⟩
  have hinj : Function.Injective T := by
    intro x y hxy
    have he : S (x : V) + x = S (y : V) + y := congrArg Subtype.val hxy
    have hz : S ((x : V) + y) = (x : V) + y := by
      rw [map_add]
      have hh := congrArg (fun z : V => z + (x : V) + S (y : V)) he
      have twice (z : V) : z + z = 0 := module_twice_zero z
      simp only [add_assoc] at hh
      calc
        S (x : V) + S (y : V) =
            (S (x : V) + x) + ((x : V) + S (y : V)) := by
              rw [add_assoc, ← add_assoc (x : V), twice, zero_add]
        _ = (S (y : V) + y) + ((x : V) + S (y : V)) := by rw [he]
        _ = (x : V) + y := by
          have : S (y : V) + S (y : V) = 0 := twice _
          calc
            _ = ((x : V) + y) + (S (y : V) + S (y : V)) := by abel
            _ = _ := by rw [this, add_zero]
    have hzero := hfixed _ hz
    apply Subtype.ext
    have hh := congrArg (fun z : V => z + (y : V)) hzero
    have hyy : (y : V) + y = 0 := module_twice_zero _
    simpa only [add_assoc, hyy, add_zero, zero_add] using hh
  have hsurj := Finite.surjective_of_injective hinj
  intro r hr
  obtain ⟨y, hy⟩ := hsurj (⟨r, hr⟩ : R)
  exact ⟨y, (congrArg Subtype.val hy).symm⟩


theorem finite_fixed_free_invariant_quadratic_unbalanced
    {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (S : V ≃ₗ[F₂] V) (hs : ∀ x, Q (S x) = Q x)
    (hfixed : ∀ x, S x = x → x = 0) :
    (∑ x : V, sign (Q x)) ≠ 0 := by
  apply finite_quadratic_unbalanced_of_radical_constant Q hq
  intro r hr
  obtain ⟨y, hy⟩ := finite_fixed_free_radical_image Q hq S hs hfixed r hr
  exact finite_radical_image_value_zero Q S hs r y hy (hr y)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.finite_quadratic_walsh_square
#print axioms HRSBF.Antipodal.finite_fixed_free_invariant_quadratic_unbalanced
