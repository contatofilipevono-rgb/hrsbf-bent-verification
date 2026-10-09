import VonoV3C

/- Review-only boundary certificates and exact theorem type snapshot.
   This file is not imported by the mathematical library. -/
namespace VonoV3C.RefereeAudit
open GraphFamily

theorem seed_dimension_one_zero (x : Vec 1) : seed 1 x = 0 := by
  simp [seed]

theorem empty_cut (adj : Fin 0 → Fin 0 → Bool) : CutConnected adj := by
  intro S hS
  obtain ⟨i, hi⟩ := hS
  exact Fin.elim0 i

theorem singleton_cut (adj : Fin 1 → Fin 1 → Bool) : CutConnected adj := by
  intro S hS hproper
  exfalso
  apply hproper
  apply Finset.eq_univ_iff_forall.mpr
  intro i
  obtain ⟨j, hj⟩ := hS
  have hij : i = j := Subsingleton.elim _ _
  simpa only [hij] using hj

theorem empty_index (adj : Fin 0 → Fin 0 → Bool) :
    HasVectorRelaxedIndex (graphMap (m := 2) (by decide) adj) 0 := by
  simpa using graph_has_exact_relaxed_index (m := 2) (by decide) adj

theorem singleton_no_split (adj : Fin 1 → Fin 1 → Bool) :
    ¬ HasRelaxedSplit (graphMap (m := 2) (by decide) adj) :=
  graph_no_relaxed_split (by decide) adj (singleton_cut adj)

def bidirected : Fin 2 → Fin 2 → Bool := fun i j => decide (i ≠ j)

theorem bidirected_forward : EdgeDetected (m := 2) (by decide) bidirected 0 1 :=
  (edge_detected_iff (by decide) bidirected 0 1 (by decide)).mpr (by decide)

theorem bidirected_reverse : EdgeDetected (m := 2) (by decide) bidirected 1 0 :=
  (edge_detected_iff (by decide) bidirected 1 0 (by decide)).mpr (by decide)

#check seed_fourth
#check pfaffian_property_A
#check Blocks.recover_blocks_from_quartic
#check representation_fourth
#check representation_output
#check mixed_third
#check canonical_EA_iff_graph_isomorphic
#check graph_fourth_radical_dimension
#check graph_quadratic_exact_index
#check graph_quadratic_ANF_not_EA_product

#print axioms seed_dimension_one_zero
#print axioms empty_cut
#print axioms singleton_cut
#print axioms empty_index
#print axioms singleton_no_split
#print axioms bidirected_forward
#print axioms bidirected_reverse
end VonoV3C.RefereeAudit
