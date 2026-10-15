import Antipodal.CyclicQuadraticRigidity

/-! The fixed-point-free complement needed for odd-order restriction.
This proves that an invariant quadratic has nonzero Gauss sum whenever
its linear symmetry has no nonzero fixed vector. -/
namespace HRSBF.Antipodal

/-- No nonzero fixed vector implies surjectivity of S+I on the polar
radical, not merely surjectivity on the ambient space. -/
theorem fixed_free_radical_image {n : ℕ} (Q : Vec n → F₂)
    (hq : ∀ a b c, third Q a b c = 0)
    (S : Vec n ≃ₗ[F₂] Vec n) (hs : ∀ x, Q (S x) = Q x)
    (hfixed : ∀ x, S x = x → x = 0) :
    ∀ r, polarRadical Q r → ∃ y, r = S y + y := by
  classical
  let R := radicalSubmodule Q hq
  let T : R → R := fun r => ⟨S r + r,
    R.add_mem (radical_stable_under_linear_equiv Q hq S hs r r.property) r.property⟩
  have hinj : Function.Injective T := by
    intro x y hxy
    have he : S (x : Vec n) + x = S (y : Vec n) + y := congrArg Subtype.val hxy
    have hz : S ((x : Vec n) + y) = (x : Vec n) + y := by
      rw [map_add]
      have hh := congrArg (fun z : Vec n => z + (x : Vec n) + S (y : Vec n)) he
      have twice (z : Vec n) : z + z = 0 := by
        ext i
        exact CharTwo.add_self_eq_zero (z i)
      simp only [add_assoc] at hh
      calc
        S (x : Vec n) + S (y : Vec n) =
            (S (x : Vec n) + x) + ((x : Vec n) + S (y : Vec n)) := by
              rw [add_assoc, ← add_assoc (x : Vec n), twice, zero_add]
        _ = (S (y : Vec n) + y) + ((x : Vec n) + S (y : Vec n)) := by rw [he]
        _ = (x : Vec n) + y := by
          have : S (y : Vec n) + S (y : Vec n) = 0 := twice _
          calc
            _ = ((x : Vec n) + y) + (S (y : Vec n) + S (y : Vec n)) := by abel
            _ = _ := by rw [this, add_zero]
    have hzero := hfixed _ hz
    apply Subtype.ext
    have hh := congrArg (fun z : Vec n => z + (y : Vec n)) hzero
    have hyy : (y : Vec n) + y = 0 := by
      ext i
      exact CharTwo.add_self_eq_zero ((y : Vec n) i)
    simpa only [add_assoc, hyy, add_zero, zero_add] using hh
  have hsurj := Finite.surjective_of_injective hinj
  intro r hr
  obtain ⟨y, hy⟩ := hsurj (⟨r, hr⟩ : R)
  exact ⟨y, (congrArg Subtype.val hy).symm⟩

/-- An invariant quadratic on a fixed-point-free cyclic complement is
unbalanced. This includes arbitrary affine and constant terms. -/
theorem fixed_free_invariant_quadratic_unbalanced {n : ℕ}
    (Q : Vec n → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (S : Vec n ≃ₗ[F₂] Vec n) (hs : ∀ x, Q (S x) = Q x)
    (hfixed : ∀ x, S x = x → x = 0) :
    (∑ x : Vec n, sign (Q x)) ≠ 0 := by
  apply quadratic_unbalanced_of_radical_constant Q hq
  exact radical_vanishes_of_image Q S hs (fixed_free_radical_image Q hq S hs hfixed)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.fixed_free_radical_image
#print axioms HRSBF.Antipodal.fixed_free_invariant_quadratic_unbalanced
