import V3GraphOrbits
import VonoExactIndex.GraphClassification

/-!
# V3: Graph-isomorphism classes are relabelling orbits

This module connects the concrete finite permutation orbit with the
existing graph-isomorphism predicate. No changes to certified V2 modules.
-/

namespace VonoExactIndex.V3Counting

open VonoExactIndex.GraphFamily

/-- Convert an off-diagonal Boolean adjacency matrix to a loopless adjacency. -/
def adjacency (r : ℕ) (g : LabelledDigraph r) (i j : Fin r) : Bool :=
  if h : i = j then false else g ⟨(i,j),h⟩

theorem adjacency_loopless (r : ℕ) (g : LabelledDigraph r) :
    Loopless (adjacency r g) := by
  intro i
  simp [adjacency]

/-- Relabelling the graph corresponds to simultaneous permutation of adjacency indices. -/
theorem adjacency_relabel (r : ℕ) (p : Equiv.Perm (Fin r))
    (g : LabelledDigraph r) (i j : Fin r) :
    adjacency r (relabelGraph r p g) i j =
      adjacency r g (p.symm i) (p.symm j) := by
  by_cases h : i = j
  · subst j
    simp [adjacency]
  · have hp : p.symm i ≠ p.symm j := by
      intro he
      exact h (p.symm.injective he)
    simp [adjacency, relabelGraph, relabelEdge, h, hp]

/-- Every graph in the permutation orbit is isomorphic to its base graph. -/
theorem orbit_member_isomorphic (r : ℕ) (g h : LabelledDigraph r)
    (hh : h ∈ graphOrbit r g) :
    GraphIsomorphic (adjacency r g) (adjacency r h) := by
  classical
  simp only [graphOrbit, Finset.mem_image, Finset.mem_univ, true_and] at hh
  obtain ⟨p, hp⟩ := hh
  subst h
  refine ⟨p.symm, ?_⟩
  intro i j
  exact adjacency_relabel r p g i j

end VonoExactIndex.V3Counting
