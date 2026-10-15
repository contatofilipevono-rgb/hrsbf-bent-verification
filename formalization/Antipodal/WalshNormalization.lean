import Antipodal.GlobalAntipodal

/-! Explicit equivalence to the conventional absolute Walsh definition,
and final statements expressed directly using that definition. -/
namespace HRSBF.Antipodal
open Finset

theorem walsh_eq_sign_sum {n : ℕ} (f : Vec n → F₂) (b : Vec n) :
    walsh f b = ∑ x, sign (f x + dot b x) := by
  simp only [walsh, transform, character, sign_add]

theorem binary_card_even (H : ℕ) :
    (Fintype.card (Vec (2*H)) : ℤ) = ((2 : ℤ)^H)^2 := by
  have hc : (Fintype.card (Vec (2*H)) : ℤ) = (2 : ℤ)^(2*H) := by
    simp [Vec, F₂]
  rw [hc, ← pow_mul]
  congr 1
  omega

theorem isBent_iff_walsh_absolute (H : ℕ) (f : Vec (2*H) → F₂) :
    IsBent f ↔ ∀ b, |∑ x, sign (f x + dot b x)| = (2 : ℤ)^H := by
  have hn : 0 ≤ (2 : ℤ)^H := pow_nonneg (by omega) _
  constructor
  · intro hb b
    have hh := hb b
    rw [binary_card_even] at hh
    have ha := (sq_eq_sq_iff_abs_eq_abs _ _).mp hh
    rw [abs_of_nonneg hn, walsh_eq_sign_sum] at ha
    exact ha
  · intro hb b
    rw [binary_card_even]
    apply (sq_eq_sq_iff_abs_eq_abs _ _).mpr
    rw [abs_of_nonneg hn, walsh_eq_sign_sum]
    exact hb b

/-- The universal theorem with exactly the usual absolute Walsh premise. -/
theorem universal_antipodal_walsh_absolute
    (H : ℕ) (hH : 0 < H) (f : Vec (2*H) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f)
    (hb : ∀ b, |∑ x, sign (f x + dot b x)| = (2 : ℤ)^H) :
    anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 1 :=
  universal_antipodal_2h H hH f hd hs ((isBent_iff_walsh_absolute H f).mpr hb)

theorem no_homogeneous_cubic_rotation_symmetric_bent_absolute
    (H : ℕ) (hH : 0 < H) (f : Vec (2*H) → F₂)
    (hf : IsHomogeneousCubic f) (hs : IsRotationSymmetric f) :
    ¬ (∀ b, |∑ x, sign (f x + dot b x)| = (2 : ℤ)^H) := by
  intro hb
  have hone := universal_antipodal_walsh_absolute H hH f
    (homogeneous_cubic_degree_at_most_three f hf) hs hb
  have hne : (⟨0, by omega⟩ : Fin (2*H)) ≠ ⟨H, by omega⟩ := by
    intro he
    have hv := congrArg Fin.val he
    dsimp at hv
    omega
  have hz := hf.1 {⟨0, by omega⟩, ⟨H, by omega⟩} (by rw [card_pair hne]; decide)
  rw [hone] at hz
  exact one_ne_zero hz

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.isBent_iff_walsh_absolute
#print axioms HRSBF.Antipodal.universal_antipodal_walsh_absolute
#print axioms HRSBF.Antipodal.no_homogeneous_cubic_rotation_symmetric_bent_absolute
