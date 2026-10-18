import H12WitnessLabels
namespace H12WitnessIndexLabels
open H12WitnessTheory H12WitnessSearch

def coefficients (tree : Tree) : List Nat := (leaves tree).map (fun w => w.coefficient)

theorem good_of_coefficients (tree : Tree) (ws : List Witness)
    (checked : ws.all check = true)
    (same : coefficients tree = ws.map (fun w => w.coefficient)) : Good tree := by
  intro c hc
  obtain ⟨w, hw, hwc⟩ := lookup_member tree c hc
  have hm : w.coefficient ∈ ws.map (fun x => x.coefficient) := by
    rw [← same]
    exact List.mem_map_of_mem hw
  obtain ⟨actual, ha, he⟩ := List.mem_map.mp hm
  have hr := checked_list_sound ws checked actual ha
  have hec : actual.coefficient = c := he.trans hwc
  rwa [hec] at hr

#print axioms good_of_coefficients
end H12WitnessIndexLabels
