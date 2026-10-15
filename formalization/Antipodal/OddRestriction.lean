import Antipodal.OddProjector
import Antipodal.Autocorrelation

/-! Quadratic balance transfer to the fixed subspace of an odd-order
linear symmetry. All affine and constant terms are retained. -/
namespace HRSBF.Antipodal
open Finset

section
variable {V : Type*} [AddCommGroup V] [Module F₂ V]

noncomputable def fixedSubspace (S : V ≃ₗ[F₂] V) : Submodule F₂ V where
  carrier := {x | S x = x}
  zero_mem' := map_zero S
  add_mem' := by intro x y hx hy; simp only [Set.mem_setOf_eq] at *; rw [map_add, hx, hy]
  smul_mem' := by intro c x hx; simp only [Set.mem_setOf_eq] at *; rw [map_smul, hx]

@[simp] theorem mem_fixedSubspace (S : V ≃ₗ[F₂] V) (x : V) :
    x ∈ fixedSubspace S ↔ S x = x := Iff.rfl

theorem orbitAverage_right_fixed (S : V ≃ₗ[F₂] V) (m : ℕ)
    (horder : S.toLinearMap ^ m = 1) (x : V) :
    orbitAverage S m (S x) = orbitAverage S m x := by
  have he : orbitAverage S m * S.toLinearMap = orbitAverage S m := by
    unfold orbitAverage
    rw [sum_mul]
    simp_rw [← pow_succ]
    have h1 := sum_range_succ (fun j => S.toLinearMap ^ j) m
    have h2 := sum_range_succ' (fun j => S.toLinearMap ^ j) m
    rw [horder] at h1
    rw [pow_zero] at h2
    exact add_right_cancel (h2.symm.trans h1)
  exact congrArg (fun T : Module.End F₂ V => T x) he

/-- Restriction of S to the actual kernel of the averaging map. -/
noncomputable def kernelSymmetry (S : V ≃ₗ[F₂] V) (m : ℕ)
    (horder : S.toLinearMap ^ m = 1) :
    LinearMap.ker (orbitAverage S m) ≃ₗ[F₂] LinearMap.ker (orbitAverage S m) where
  toFun x := ⟨S x, by
    change orbitAverage S m (S x) = 0
    rw [orbitAverage_right_fixed S m horder]
    exact x.property⟩
  invFun x := ⟨S.symm x, by
    have h := orbitAverage_right_fixed S m horder (S.symm x)
    rw [S.apply_symm_apply] at h
    exact h.symm.trans x.property⟩
  left_inv x := by apply Subtype.ext; exact S.symm_apply_apply x
  right_inv x := by apply Subtype.ext; exact S.apply_symm_apply x
  map_add' x y := by apply Subtype.ext; exact map_add S (x : V) (y : V)
  map_smul' c x := by apply Subtype.ext; exact map_smul S c (x : V)

/-- Actual fixed/kernel decomposition, rather than an assumed splitting. -/
noncomputable def averagingEquiv (S : V ≃ₗ[F₂] V) (m : ℕ)
    (hodd : Odd m) (horder : S.toLinearMap ^ m = 1) :
    (fixedSubspace S × LinearMap.ker (orbitAverage S m)) ≃ V where
  toFun z := z.1.val + z.2.val
  invFun x := (⟨orbitAverage S m x, orbitAverage_fixed S m horder x⟩,
    ⟨x + orbitAverage S m x, (orbitAverage_decomposition S m hodd horder x).2.1⟩)
  left_inv z := by
    have hu := orbitAverage_of_fixed S m hodd z.1.val z.1.property
    have hk : orbitAverage S m z.2.val = 0 := z.2.property
    apply Prod.ext
    · apply Subtype.ext
      change orbitAverage S m (z.1.val + z.2.val) = z.1.val
      rw [map_add, hu, hk, add_zero]
    · apply Subtype.ext
      change z.1.val + z.2.val + orbitAverage S m (z.1.val + z.2.val) = z.2.val
      rw [map_add, hu, hk, add_zero]
      calc
        z.1.val + z.2.val + z.1.val = z.2.val + (z.1.val + z.1.val) := by abel
        _ = z.2.val := by rw [module_twice_zero, add_zero]
  right_inv x := (orbitAverage_decomposition S m hodd horder x).2.2.symm

/-- The fixed and averaging-kernel summands are orthogonal for every
invariant quadratic, even when its polar is degenerate. -/
theorem fixed_kernel_polar_zero (Q : V → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (S : V ≃ₗ[F₂] V) (hs : ∀ x, Q (S x) = Q x)
    (m : ℕ) (hodd : Odd m) (u k : V)
    (hu : S u = u) (hk : orbitAverage S m k = 0) : polar Q u k = 0 := by
  have hp : ∀ x, polar Q u (S x) = polar Q u x := by
    intro x
    calc
      polar Q u (S x) = polar Q (S u) (S x) := by rw [hu]
      _ = polar Q u x := by simp only [polar, ← map_add, hs, map_zero]
  have hpow (j : ℕ) : polar Q u ((S.toLinearMap ^ j) k) = polar Q u k := by
    induction j with
    | zero => rfl
    | succ j ih =>
      rw [pow_succ']
      change polar Q u (S ((S.toLinearMap ^ j) k)) = _
      rw [hp, ih]
  let L : V →+ F₂ := {
    toFun := polar Q u
    map_zero' := by unfold polar; simp only [add_zero]; ring_nf; simp
    map_add' := quadratic_polar_add_right Q hq u }
  have hc : (m : F₂) = 1 := natCast_eq_one_of_odd_of_two_eq_zero hodd (by decide)
  have he : polar Q u (orbitAverage S m k) = polar Q u k := by
    change L ((∑ j ∈ range m, S.toLinearMap ^ j) k) = _
    simp only [LinearMap.sum_apply, map_sum]
    change (∑ j ∈ range m, polar Q u ((S.toLinearMap ^ j) k)) = _
    simp only [hpow, sum_const, card_range, nsmul_eq_mul, hc, one_mul]
  rw [hk] at he
  have hz : polar Q u 0 = 0 := by unfold polar; simp only [add_zero]; ring_nf; simp
  exact he.symm.trans hz


noncomputable instance fixedSubspaceFintype [Fintype V] (S : V ≃ₗ[F₂] V) :
    Fintype (fixedSubspace S) := Fintype.ofFinite _

noncomputable instance averageKernelFintype [Fintype V]
    (S : V ≃ₗ[F₂] V) (m : ℕ) :
    Fintype (LinearMap.ker (orbitAverage S m)) := Fintype.ofFinite _

/-- The complete odd-order quadratic balance-transfer lemma. -/
theorem odd_order_quadratic_balance_iff [Fintype V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (S : V ≃ₗ[F₂] V) (hs : ∀ x, Q (S x) = Q x)
    (m : ℕ) (hodd : Odd m) (horder : S.toLinearMap ^ m = 1) :
    (∑ x : V, sign (Q x)) = 0 ↔
      (∑ u : fixedSubspace S, sign (Q u)) = 0 := by
  classical
  let K := LinearMap.ker (orbitAverage S m)
  let U := fixedSubspace S
  let qK : K → F₂ := fun x => Q x
  have hqK : ∀ a b c, third qK a b c = 0 := by
    intro a b c
    simpa only [qK, third, Submodule.coe_add, Submodule.coe_zero] using
      hq (a : V) (b : V) (c : V)
  have hsK : ∀ x, qK (kernelSymmetry S m horder x) = qK x := by
    intro x
    exact hs x
  have hfree : ∀ x : K, kernelSymmetry S m horder x = x → x = 0 := by
    intro x hx
    apply Subtype.ext
    exact orbitAverage_kernel_fixed_free S m hodd x x.property
      (congrArg Subtype.val hx)
  have hK : (∑ x : K, sign (qK x)) ≠ 0 :=
    finite_fixed_free_invariant_quadratic_unbalanced qK hqK
      (kernelSymmetry S m horder) hsK hfree
  have hsign : sign (Q 0) ≠ 0 := by
    intro hh
    have hs := sign_sq (Q 0)
    rw [hh] at hs
    norm_num at hs
  have hsplit : (∑ x : V, sign (Q x)) =
      sign (Q 0) * (∑ u : U, sign (Q u)) * (∑ k : K, sign (Q k)) := by
    rw [← Equiv.sum_comp (averagingEquiv S m hodd horder) (fun x => sign (Q x)),
      Fintype.sum_prod_type]
    have he (u : U) (k : K) : sign (Q (u.val + k.val)) =
        sign (Q 0) * sign (Q u.val) * sign (Q k.val) := by
      have hp := fixed_kernel_polar_zero Q hq S hs m hodd u.val k.val u.property k.property
      have hval : Q (u.val + k.val) = Q 0 + Q u.val + Q k.val := by
        unfold polar at hp
        calc
          Q (u.val + k.val) =
              (Q (u.val + k.val) + Q u.val + Q k.val + Q 0) +
                (Q 0 + Q u.val + Q k.val) := by ring_nf; simp
          _ = Q 0 + Q u.val + Q k.val := by rw [hp, zero_add]
      rw [hval, sign_add, sign_add]
    change (∑ u : U, ∑ k : K, sign (Q (u.val + k.val))) = _
    simp_rw [he, ← mul_sum]
    rw [← sum_mul, ← mul_sum]
  rw [hsplit]
  simp only [mul_eq_zero, hsign, hK, or_false, false_or]



/-- Nonzero derivatives of the actual fixed-space restriction are balanced.
Neither invariance alone nor an assumed restricted bentness is used. -/
theorem odd_order_cubic_fixed_derivatives_balanced {n : ℕ}
    (f : Vec n → F₂) (hc : HasCubicRepresentation f) (hb : IsBent f)
    (S : Vec n ≃ₗ[F₂] Vec n) (hs : ∀ x, f (S x) = f x)
    (m : ℕ) (hodd : Odd m) (horder : S.toLinearMap ^ m = 1)
    (a : fixedSubspace S) (ha : a ≠ 0) :
    (∑ x : fixedSubspace S, sign (derivative (fun y : fixedSubspace S => f y) a x)) = 0 := by
  have hane : (a : Vec n) ≠ 0 := by
    intro h
    apply ha
    exact Subtype.ext h
  have hq := fun u v w => cubic_derivative_third_zero f hc (a : Vec n) u v w
  have hsinv : ∀ x, derivative f (a : Vec n) (S x) = derivative f (a : Vec n) x := by
    intro x
    change f (S x + a.val) + f (S x) = f (x + a.val) + f x
    have hafix : S a.val = a.val := a.property
    rw [← hafix, ← map_add, hs, hs]
    rw [hafix]
  exact (odd_order_quadratic_balance_iff (derivative f (a : Vec n)) hq S hsinv
    m hodd horder).mp (bent_derivative_balanced f hb (a : Vec n) hane)

/-- Bentness really survives odd-order fixed-space restriction in any
linear coordinates on that subspace. All balance hypotheses are derived. -/
theorem odd_order_bent_restriction {n d : ℕ}
    (f : Vec n → F₂) (hc : HasCubicRepresentation f) (hb : IsBent f)
    (S : Vec n ≃ₗ[F₂] Vec n) (hs : ∀ x, f (S x) = f x)
    (m : ℕ) (hodd : Odd m) (horder : S.toLinearMap ^ m = 1)
    (e : Vec d ≃ₗ[F₂] fixedSubspace S) :
    IsBent (fun x : Vec d => f (e x)) := by
  apply bent_of_derivative_balanced
  intro a ha
  have hea : e a ≠ 0 := by
    intro h
    apply ha
    apply e.injective
    simpa only [map_zero] using h
  have hbfix := odd_order_cubic_fixed_derivatives_balanced f hc hb S hs m hodd horder (e a) hea
  have heq := Equiv.sum_comp e.toEquiv
    (fun x : fixedSubspace S => sign (derivative (fun y : fixedSubspace S => f y) (e a) x))
  have hval (x : Vec d) :
      derivative (fun y : Vec d => f (e y)) a x =
        derivative (fun y : fixedSubspace S => f y) (e a) (e x) := by
    simp only [derivative, map_add]
  simp_rw [hval]
  exact heq.trans hbfix

end
end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.averagingEquiv
#print axioms HRSBF.Antipodal.fixed_kernel_polar_zero

#print axioms HRSBF.Antipodal.odd_order_quadratic_balance_iff

#print axioms HRSBF.Antipodal.odd_order_cubic_fixed_derivatives_balanced
#print axioms HRSBF.Antipodal.odd_order_bent_restriction
