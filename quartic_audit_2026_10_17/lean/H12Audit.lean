import H12PeriodFour
import H12Descent

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
    (hr : H12Descent.Rotational4 (H12.quarticFunction c))
    (hb : H12Descent.BentAC (H12.quarticFunction c)) :
    H12.restrictionTable c = 0x6ca0 ∨ H12.restrictionTable c = 0x7ee8 ∨
    H12.restrictionTable c = 0x8000 ∨ H12.restrictionTable c = 0x9668 :=
  bent_rotational_four_cases _ c (quartic_representation c) hr hb

#print axioms bent_rotational_four_cases
#print axioms quartic_bent_four_cases
end H12Audit
