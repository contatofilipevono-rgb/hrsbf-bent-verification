import H12WitnessSearch

namespace H12WitnessLabels
open H12WitnessTheory H12WitnessSearch

/- The search tree uses only coefficient labels. Its unused fields carry no
   Walsh certificate; rejection is supplied by the separately checked list. -/
def label (coefficient : Nat) : Tree := .leaf ⟨coefficient, 0, 0⟩

theorem label_good (ws : List Witness) (checked : ws.all check = true)
    (j : Nat) (hj : j < ws.length) (coefficient : Nat)
    (he : ((ws[j]'hj).coefficient == coefficient) = true) : Good (label coefficient) := by
  intro c hc
  change (coefficient == c) = true at hc
  have hc' : coefficient = c := beq_iff_eq.mp hc
  have he' : (ws[j]'hj).coefficient = coefficient := beq_iff_eq.mp he
  rw [← hc', ← he']
  exact checked_list_sound ws checked _ (List.getElem_mem hj)

#print axioms label_good
end H12WitnessLabels
