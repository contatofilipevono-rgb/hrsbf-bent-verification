import V3OrbitIsomorphism

/-!
# V3: converse from graph isomorphism to a concrete permutation orbit

This module adds the missing converse to the previous orbit-to-isomorphism
lemma. It does not modify existing V1 or V2 sources.
-/

namespace VonoExactIndex.V3Counting

open VonoExactIndex.GraphFamily

/-- The adjacency representation is injective on loopless digraphs. -/
theorem adjacency_injective (r : ℕ) :
    Function.Injective (adjacency r) := by
  intro g h he
  funext e
  have hij : e.1.1 ≠ e.1.2 := e.2
  have hv := congrFun (congrFun he e.1.1) e.1.2
  simpa [adjacency, hij] using hv

/-- Isomorphic loopless digraphs are in the same relabelling orbit. -/
theorem isomorphic_implies_orbit_member (r : ℕ) (g h : LabelledDigraph r)
    (hi : GraphIsomorphic (adjacency r g) (adjacency r h)) :
    h ∈ graphOrbit r g := by
  classical
  obtain ⟨p, hp⟩ := hi
  have hAdj : adjacency r h = adjacency r (relabelGraph r p.symm g) := by
    funext i j
    rw [adjacency_relabel]
    exact hp i j
  have heq : h = relabelGraph r p.symm g :=
    adjacency_injective r hAdj
  simp only [graphOrbit, Finset.mem_image, Finset.mem_univ, true_and]
  exact ⟨p.symm, heq.symm⟩

/-- Graph isomorphism is precisely membership in the relabelling orbit. -/
theorem graph_isomorphic_iff_orbit_member (r : ℕ) (g h : LabelledDigraph r) :
    GraphIsomorphic (adjacency r g) (adjacency r h) ↔
      h ∈ graphOrbit r g := by
  constructor
  · exact isomorphic_implies_orbit_member r g h
  · exact orbit_member_isomorphic r g h

end VonoExactIndex.V3Counting
