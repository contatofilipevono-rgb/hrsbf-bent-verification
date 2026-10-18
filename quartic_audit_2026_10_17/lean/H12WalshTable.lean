import H12Popcount
import H12FilterLink

namespace H12WalshTable
open H12Walsh H12Restriction H12Truth H12FilterLink H12Weight

set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000

def selectTable (coeff : Nat → Bool) (table : Nat → Nat) : List Nat → Nat
  | [] => 0
  | i::is => (if coeff i then table i else 0) ^^^ selectTable coeff table is

theorem selectTable_semantics (coeff : Nat → Bool) (table : Nat → Nat) (is : List Nat) (x : Nat) :
    (selectTable coeff table is).testBit x =
    combine coeff (familyRows is (fun i x => (table i).testBit x)) x := by
  induction is with
  | nil => simp [selectTable, familyRows, combine]
  | cons i is ih =>
    simp only [selectTable, Nat.testBit_xor, familyRows, List.map_cons, combine]
    rw [ih]
    cases h : coeff i <;> simp [h, familyRows]

def truthTable (c : BitVec 43) : Nat :=
  selectTable c.getLsbD (fun i => basisTables[i]!) (List.range 43)

theorem truthTable_semantics (c : BitVec 43) (x : Nat) (hx : x < 4096) :
    (truthTable c).testBit x = H12.quarticFunction c x := by
  rw [truthTable, selectTable_semantics]
  have he := combine_family_congr_at c.getLsbD (List.range 43)
    (fun i x => (basisTables[i]!).testBit x)
    (fun i x => H12.orbitValue (H12.quarticOrbits[i]!) x)
    x (fun i hi => basis_semantics ⟨i,List.mem_range.mp hi⟩ x hx)
  rw [he, ← originalRows_family, H12FilterBridge.original_combine]

def phaseTable : Nat → Nat → Nat
  | 0, _ => 0
  | n+1, a => phaseTable n a ^^^ (if a.testBit n then planes[n]! else 0)

theorem phaseTable_semantics (n a x : Nat) (hn : n ≤ 12) (hx : x < 4096) :
    (phaseTable n a).testBit x = dotBits n a x := by
  induction n with
  | zero => simp [phaseTable, dotBits]
  | succ n ih =>
    simp only [phaseTable, Nat.testBit_xor, dotBits]
    rw [ih (by omega)]
    cases ha : a.testBit n
    · simp [ha]
    · simp only [ha, ↓reduceIte, Bool.true_and]
      rw [variable_semantics ⟨n,by omega⟩ ⟨x,hx⟩]

def phaseWeight (c : BitVec 43) (a : Nat) : Nat :=
  H12Popcount.fastWeight 12 (truthTable c ^^^ phaseTable 12 a)

theorem phaseWeight_sound (c : BitVec 43) (a : Nat) : phaseWeight c a =
    (List.range 4096).countP (fun x => H12.quarticFunction c x ^^ dotBits 12 a x) := by
  rw [phaseWeight, H12Popcount.fastWeight_sound]
  apply count_congr_on
  intro x hx
  rw [Nat.testBit_xor, truthTable_semantics c x (List.mem_range.mp hx),
    phaseTable_semantics 12 a x (by omega) (List.mem_range.mp hx)]

theorem walsh_as_weight (c : BitVec 43) (a : Nat) :
    walsh (H12.quarticFunction c) a = 4096 - 2 * (phaseWeight c a : Int) := by
  rw [walsh_as_signed_sum, total_sign_weight, phaseWeight_sound, List.length_range]
  rfl

def rejects (c : BitVec 43) (a : Nat) : Bool :=
  (phaseWeight c a != 2016) && (phaseWeight c a != 2080)

theorem rejects_sound (c : BitVec 43) (a : Nat) (hr : rejects c a = true) :
    ¬H12Descent.BentAC (H12.quarticFunction c) := by
  intro hb
  have hw := walsh_as_weight c a
  have hv := bent_walsh_values _ hb a
  simp only [rejects, Bool.and_eq_true, bne_iff_ne] at hr
  rcases hv with hv | hv <;> omega

#print axioms truthTable_semantics
#print axioms phaseWeight_sound
#print axioms rejects_sound

def phaseWeightMod (c : BitVec 43) (a bits : Nat) : Nat :=
  H12Popcount.fastWeightMod 12 bits (truthTable c ^^^ phaseTable 12 a)

theorem phaseWeightMod_sound (c : BitVec 43) (a bits : Nat) (hb : 0 < bits) :
    phaseWeightMod c a bits = phaseWeight c a % 2^bits := by
  rw [phaseWeightMod, phaseWeight, H12Popcount.fastWeightMod_sound _ _ _ hb,
    H12Popcount.fastWeight_sound]

def rejectsMod (c : BitVec 43) (a bits : Nat) : Bool :=
  decide (0 < bits) && (phaseWeightMod c a bits != 2016 % 2^bits) &&
    (phaseWeightMod c a bits != 2080 % 2^bits)

theorem rejectsMod_sound (c : BitVec 43) (a bits : Nat) (hr : rejectsMod c a bits = true) :
    ¬H12Descent.BentAC (H12.quarticFunction c) := by
  intro hb
  have hw := walsh_as_weight c a
  have hv := bent_walsh_values _ hb a
  simp only [rejectsMod, Bool.and_eq_true, decide_eq_true_eq, bne_iff_ne] at hr
  rw [phaseWeightMod_sound c a bits hr.1.1] at hr
  have hp : phaseWeight c a = 2016 ∨ phaseWeight c a = 2080 := by rcases hv with hv | hv <;> omega
  rcases hp with hp | hp
  · exact hr.1.2 (congrArg (fun w => w % 2^bits) hp)
  · exact hr.2 (congrArg (fun w => w % 2^bits) hp)

#print axioms rejectsMod_sound
end H12WalshTable


