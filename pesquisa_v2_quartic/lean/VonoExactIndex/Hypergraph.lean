import VonoExactIndex.ExactIndex

/-!
# Quartic hypergraph maps — isolated formalization module

This file introduces the coordinatewise monomial vector map without
changing any of the already checked seed or transport proofs.
The exact-index and EA-indecomposability theorems are not claimed here.
-/

namespace VonoExactIndex

/-- Boolean monomial associated with a finite hyperedge. -/
def hyperedgeMonomial {n : Nat} (S : Finset (Fin n))
    (x : Fin n → ZMod 2) : ZMod 2 :=
  ∏ i ∈ S, x i

/-- Vector-valued hypergraph map: one monomial per output coordinate. -/
def hypergraphMap {n : Nat} (H : Finset (Finset (Fin n)))
    (x : Fin n → ZMod 2) : H → ZMod 2 :=
  fun S => hyperedgeMonomial S.1 x

/-- A set of vertices is independent in the 2-section of a hypergraph. -/
def HypergraphIndependent {n : Nat}
    (H : Finset (Finset (Fin n))) (I : Finset (Fin n)) : Prop :=
  ∀ S ∈ H, ∀ i ∈ I, ∀ j ∈ I, i ∈ S → j ∈ S → i = j

/-- The empty vertex set is always independent. -/
theorem hypergraphIndependent_empty {n : Nat}
    (H : Finset (Finset (Fin n))) :
    HypergraphIndependent H ∅ := by
  intro S hS i hi
  simp at hi

/-- Every hypergraph monomial is one coordinate of its vector map. -/
theorem hypergraphMap_apply {n : Nat}
    (H : Finset (Finset (Fin n))) (x : Fin n → ZMod 2) (S : H) :
    hypergraphMap H x S = hyperedgeMonomial S.1 x := rfl

end VonoExactIndex
