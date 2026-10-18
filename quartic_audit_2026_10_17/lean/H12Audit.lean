import H12PeriodFour
import H12Descent
import H12Quadratic
import H12Orbit
import H12Refutation

/-! A formal connection between the autocorrelation descent and the four-case
classification. This module proves a necessary reduction, not global nonexistence.
-/
namespace H12Audit
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

theorem repeat_xor : ∀ y u : Fin 16,
    H12Descent.repeat4 (y.val ^^^ u.val) =
      H12Descent.repeat4 y.val ^^^ H12Descent.repeat4 u.val := by decide

theorem xor_bounds : ∀ y u : Fin 16, (y.val ^^^ u.val) < 16 := by decide

def PeriodicRepresentation (f : Nat → Bool) (c : BitVec 43) : Prop :=
  ∀ y : Fin 16, f (H12Descent.repeat4 y.val) = (H12.restrictionTable c).getLsbD y.val

theorem quartic_representation (c : BitVec 43) :
    PeriodicRepresentation (H12.quarticFunction c) c := by
  intro y
  exact H12.quartic_periodic c y

theorem fixed_correlation (f : Nat → Bool) (c : BitVec 43)
    (hp : PeriodicRepresentation f c) (u : Fin 16) :
    (H12Descent.fixedPoints.map (H12Descent.derivativeSign f (H12Descent.repeat4 u.val))).sum =
      H12.autocorrelation4 (H12.restrictionTable c) u.val := by
  simp only [H12Descent.fixedPoints, List.map_map, H12.autocorrelation4]
  apply congrArg (fun xs : List Int => xs.sum)
  apply List.map_congr_left
  intro y hy
  have hyl : y < 16 := List.mem_range.mp hy
  have hx := xor_bounds ⟨y,hyl⟩ u
  dsimp [Function.comp_def, H12Descent.derivativeSign]
  rw [hp ⟨y,hyl⟩, ← repeat_xor ⟨y,hyl⟩ u, hp ⟨y ^^^ u.val,hx⟩]

theorem bent_rotational_four_cases (f : Nat → Bool) (c : BitVec 43)
    (hp : PeriodicRepresentation f c)
    (hr : H12Descent.Rotational4 f) (hb : H12Descent.BentAC f) :
    H12.restrictionTable c = 0x6ca0 ∨ H12.restrictionTable c = 0x7ee8 ∨
    H12.restrictionTable c = 0x8000 ∨ H12.restrictionTable c = 0x9668 := by
  apply H12.periodic_reduction
  intro u
  have hd := H12Descent.bent_rotational_descent f hr hb u
  have hu : u.val+1 < 16 := by omega
  rw [fixed_correlation f c hp ⟨u.val+1,hu⟩] at hd
  have hm := Int.emod_eq_zero_of_dvd hd
  simpa [H12.restriction_normal_form] using hm

theorem quartic_bent_four_cases (c : BitVec 43)
    (hb : H12Descent.BentAC (H12.quarticFunction c)) :
    H12.restrictionTable c = 0x6ca0 ∨ H12.restrictionTable c = 0x7ee8 ∨
    H12.restrictionTable c = 0x8000 ∨ H12.restrictionTable c = 0x9668 :=
  bent_rotational_four_cases _ c (quartic_representation c)
    (H12Orbit.quartic_rotational_four c) hb

#print axioms bent_rotational_four_cases
#print axioms quartic_bent_four_cases

theorem pack_fifteen_bits : ∀ a b c d : Bool,
    (H12.pack4 a b c d).toNat = 15 → (b && d) = true := by decide

theorem three_case_parameters (c : BitVec 43)
    (hp : H12Quadratic.Passes c)
    (hm : H12.admissibleMod3 (H12.parameters c).toNat) :
    (H12.parameters c).toNat = 2 ∨ (H12.parameters c).toNat = 3 ∨
      (H12.parameters c).toNat = 8 := by
  have hc := (H12.four_case_classification ⟨(H12.parameters c).toNat,
    (H12.parameters c).isLt⟩).mp hm
  rcases hc with h2 | h3 | h8 | h15
  · exact Or.inl h2
  · exact Or.inr (Or.inl h3)
  · exact Or.inr (Or.inr h8)
  · have ht : (c.getLsbD 40 && c.getLsbD 42) = true := by
      apply pack_fifteen_bits
      exact h15
    have hf := H12Quadratic.short_product_zero c hp
    rw [hf] at ht
    cases ht

theorem necessary_chart_constraints (c : BitVec 43)
    (hp : H12Quadratic.Passes c)
    (hb : H12Descent.BentAC (H12.quarticFunction c)) :
    ((H12.parameters c).toNat = 2 ∨ (H12.parameters c).toNat = 3 ∨
      (H12.parameters c).toNat = 8) ∧
    H12Quadratic.r1 c = false ∧ H12Quadratic.r2 c = false ∧ H12Quadratic.r3 c = false := by
  have hm : H12.admissibleMod3 (H12.parameters c).toNat := by
    intro u
    have hd := H12Descent.bent_rotational_descent _ (H12Orbit.quartic_rotational_four c) hb u
    have hu : u.val+1 < 16 := by omega
    rw [fixed_correlation _ c (quartic_representation c) ⟨u.val+1,hu⟩] at hd
    simpa [H12.restriction_normal_form] using Int.emod_eq_zero_of_dvd hd
  exact ⟨three_case_parameters c hp hm, H12Quadratic.necessary_r1 c hp,
    H12Quadratic.necessary_r2 c hp, H12Quadratic.necessary_r3 c hp⟩

#print axioms necessary_chart_constraints
end H12Audit
