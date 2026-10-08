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

/-- An independent vertex set meets each hyperedge in at most one vertex. -/
theorem independent_edge_unique {n : Nat}
    (H : Finset (Finset (Fin n))) (I : Finset (Fin n))
    (hI : HypergraphIndependent H I)
    (S : Finset (Fin n)) (hS : S ∈ H)
    {i j : Fin n} (hiI : i ∈ I) (hjI : j ∈ I)
    (hiS : i ∈ S) (hjS : j ∈ S) : i = j :=
  hI S hS i hiI j hjI hiS hjS

/-- Independence is inherited by subsets of vertices. -/
theorem hypergraphIndependent_mono {n : Nat}
    (H : Finset (Finset (Fin n))) {I J : Finset (Fin n)}
    (hI : HypergraphIndependent H I) (hJI : J ⊆ I) :
    HypergraphIndependent H J := by
  intro S hS i hi j hj hiS hjS
  exact hI S hS i (hJI hi) j (hJI hj) hiS hjS

end VonoExactIndex
