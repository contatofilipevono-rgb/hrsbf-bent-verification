import H12WalshTable

namespace H12WitnessTheory

structure Witness where
  coefficient : Nat
  frequency : Nat
  bits : Nat
  deriving Repr, BEq

def check (w : Witness) : Bool :=
  decide (w.coefficient < 2^43) && decide (w.frequency < 4096) &&
    H12WalshTable.rejectsMod (BitVec.ofNat 43 w.coefficient) w.frequency w.bits

theorem check_sound (w : Witness) (h : check w = true) :
    ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w.coefficient)) := by
  simp only [check, Bool.and_eq_true, decide_eq_true_eq] at h
  exact H12WalshTable.rejectsMod_sound _ _ _ h.2

theorem checked_list_sound (ws : List Witness) (h : ws.all check = true) :
    ∀ w ∈ ws, ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w.coefficient)) := by
  intro w hw
  exact check_sound w (List.all_eq_true.mp h w hw)

#print axioms checked_list_sound
end H12WitnessTheory
