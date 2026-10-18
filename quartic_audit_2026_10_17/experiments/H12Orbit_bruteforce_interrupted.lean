import H12PeriodFour
import H12Descent

namespace H12Orbit
set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000

def rotateMask1 (mask : Nat) : Nat := ((mask * 2) % 4096) + mask / 2048
def allQuarticMasks : List Nat :=
  (List.range 4096).filter (fun mask =>
    ((List.range 12).filter (fun i => mask.testBit i)).length == 4)

theorem all_supports_partitioned :
    H12Descent.sortFuel 9 H12.quarticOrbits.flatten = allQuarticMasks := by decide +kernel

theorem orbit_closure : ∀ j : Fin 43,
    H12Descent.sortFuel 4 ((H12.quarticOrbits[j.val]!).map rotateMask1) =
      H12.quarticOrbits[j.val]! := by decide +kernel

theorem basis_rotation_four : ∀ j : Fin 43, ∀ x : Fin 4096,
    H12.orbitValue (H12.quarticOrbits[j.val]!) (H12Descent.rotate4 x.val) =
      H12.orbitValue (H12.quarticOrbits[j.val]!) x.val := by decide +kernel

theorem quartic_rotational_four (c : BitVec 43) :
    H12Descent.Rotational4 (H12.quarticFunction c) := by
  intro x hx
  have h : ∀ j : Fin 43,
      H12.orbitValue (H12.quarticOrbits[j.val]!) (H12Descent.rotate4 x) =
        H12.orbitValue (H12.quarticOrbits[j.val]!) x :=
    fun j => basis_rotation_four j ⟨x,hx⟩
  unfold H12.quarticFunction
  simp only [h]

#print axioms all_supports_partitioned
#print axioms orbit_closure
#print axioms quartic_rotational_four
end H12Orbit
