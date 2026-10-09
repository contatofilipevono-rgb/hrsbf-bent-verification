import Mathlib

/-!
# V3: finite graph-counting foundations

A loopless directed graph is encoded by its off-diagonal Boolean edge choices.
The result below counts *labelled* graphs exactly. Orbit counting under
vertex permutations is a separate, not-yet-formalized step.
-/

namespace VonoExactIndex.V3Counting

/-- Ordered pairs of distinct vertices: the possible directed edges. -/
abbrev EdgePosition (r : ℕ) := {p : Fin r × Fin r // p.1 ≠ p.2}

/-- A labelled loopless directed graph is a Boolean choice at every edge. -/
abbrev LabelledDigraph (r : ℕ) := EdgePosition r → Bool

/-- Exact number of labelled loopless digraphs, expressed by the edge count. -/
theorem labelledDigraph_card (r : ℕ) :
    Fintype.card (LabelledDigraph r) = 2 ^ Fintype.card (EdgePosition r) := by
  simp [LabelledDigraph, Fintype.card_fun]

end VonoExactIndex.V3Counting
