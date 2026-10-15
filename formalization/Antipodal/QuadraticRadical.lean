import Antipodal.Fourier

/-!
A new algebraic bridge toward quadratic rigidity, separated from the
unproved "proper invariant ideal lies in im(S+1)" lemma. The zero-of-Q
statement is dimension-independent and does not hide any spectral claims.
-/

namespace HRSBF.Antipodal
open Finset

private lemma vector_twice_zero {n : ℕ} (x : Vec n) : x + x = 0 := by
  ext i
  exact CharTwo.add_self_eq_zero (x i)

/-- If r lies in the image of S+1, invariance and polar-radicality
force Q(r)=Q(0). No bilinearity of the polar is needed in this step. -/
theorem radical_image_value_zero {n : ℕ}
    (Q : Vec n → F₂) (S : Vec n → Vec n)
    (hshift : ∀ x, Q (S x) = Q x)
    (r y : Vec n) (himage : r = S y + y)
    (hrad : polar Q r y = 0) : Q r = Q 0 := by
  have hry : r + y = S y := by
    rw [himage, add_assoc, vector_twice_zero, add_zero]
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

/-- Algebraic radical-image consequence, later instantiated using the
local-ring description for N a power of two. -/
theorem radical_vanishes_of_image {n : ℕ}
    (Q : Vec n → F₂) (S : Vec n → Vec n)
    (hshift : ∀ x, Q (S x) = Q x)
    (himage : ∀ r, (∀ y, polar Q r y = 0) → ∃ x, r = S x + x) :
    ∀ r, (∀ y, polar Q r y = 0) → Q r = Q 0 := by
  intro r hrad
  obtain ⟨y, hy⟩ := himage r hrad
  exact radical_image_value_zero Q S hshift r y hy (hrad y)

/-- Orthogonality of a nontrivial F₂-additive character: a useful
tool for the quadratic Walsh-square identity (independent of dot bases). -/
theorem sum_sign_additive {n : ℕ} (l : Vec n → F₂)
    (hl : ∀ x y, l (x + y) = l x + l y) :
    (∑ x : Vec n, sign (l x)) =
      if ∀ x, l x = 0 then (Fintype.card (Vec n) : ℤ) else 0 := by
  classical
  split_ifs with hz
  · simp [hz, sign]
  · push_neg at hz
    obtain ⟨a, ha⟩ := hz
    have h01 : ∀ b : F₂, b = 0 ∨ b = 1 := by decide
    have ha1 : l a = 1 := (h01 (l a)).resolve_left ha
    have hshift (x : Vec n) : sign (l (x + a)) = -sign (l x) := by
      rw [hl, sign_add, ha1]
      norm_num [sign]
    have hs := Equiv.sum_comp (Equiv.addRight a) (fun x => sign (l x))
    simp only [Equiv.coe_addRight, hshift] at hs
    rw [sum_neg_distrib] at hs
    omega

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.radical_image_value_zero
#print axioms HRSBF.Antipodal.radical_vanishes_of_image
#print axioms HRSBF.Antipodal.sum_sign_additive
