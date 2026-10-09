import VonoExactIndex.GraphClassification
import VonoExactIndex.GraphFunction

/-!
# V3: formally derived inequivalence and common-index consequences

This module does not change the existing V1/V2 theorems.
It states elementary but useful corollaries of the established
canonical graph classification and exact relaxed index.
-/

namespace VonoExactIndex.GraphFamily

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Nonisomorphic loopless digraphs give EA-inequivalent canonical maps. -/
theorem nonisomorphic_implies_not_EA (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH)
    (hnot : ¬ GraphIsomorphic adjG adjH) :
    ¬ EAEquivalent (graphMap adjG) (graphMap adjH) := by
  intro hEA
  exact hnot ((canonical_EA_iff_graph_isomorphic adjG adjH hG hH).mp hEA)

/-- Each canonical graph map has exact relaxed vector index, regardless of edges. -/
theorem canonical_maps_share_exact_index (adjG adjH : ι → ι → Bool) :
    HasVectorRelaxedIndex (graphMap adjG) (Fintype.card ι) ∧
    HasVectorRelaxedIndex (graphMap adjH) (Fintype.card ι) := by
  exact ⟨graph_has_exact_index adjG, graph_has_exact_index adjH⟩

/-- Combined statement: exact same index need not imply EA equivalence. -/
theorem nonisomorphic_same_index_not_EA (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH)
    (hnot : ¬ GraphIsomorphic adjG adjH) :
    HasVectorRelaxedIndex (graphMap adjG) (Fintype.card ι) ∧
    HasVectorRelaxedIndex (graphMap adjH) (Fintype.card ι) ∧
    ¬ EAEquivalent (graphMap adjG) (graphMap adjH) := by
  exact ⟨graph_has_exact_index adjG, graph_has_exact_index adjH,
    nonisomorphic_implies_not_EA adjG adjH hG hH hnot⟩

#print axioms nonisomorphic_same_index_not_EA

end VonoExactIndex.GraphFamily
