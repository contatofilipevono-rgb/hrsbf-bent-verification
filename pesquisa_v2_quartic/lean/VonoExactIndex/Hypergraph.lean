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

/-- The directions supported on an independent vertex set form a submodule. -/
def independentCoordinateSubmodule {n : Nat} (I : Finset (Fin n)) :
    Submodule (ZMod 2) (Fin n → ZMod 2) where
  carrier := {a | ∀ i, i ∉ I → a i = 0}
  zero_mem' := by
    intro i hi
    rfl
  add_mem' := by
    intro a b ha hb i hi
    simp [ha i hi, hb i hi]
  smul_mem' := by
    intro t a ha i hi
    simp [ha i hi]

/-- A coordinate direction belongs to the independent-coordinate submodule
exactly when it vanishes off the selected vertices. -/
theorem mem_independentCoordinateSubmodule {n : Nat}
    (I : Finset (Fin n)) (a : Fin n → ZMod 2) :
    a ∈ independentCoordinateSubmodule I ↔
      ∀ i, i ∉ I → a i = 0 := Iff.rfl

/-- The product of two Boolean affine factors has zero mixed second
difference if one of the factors is unchanged in both directions. -/
theorem diff_mul_const_right {V : Type*} [AddCommGroup V]
    [Module (ZMod 2) V] (f : V → ZMod 2) (c : ZMod 2)
    (a : V) :
    diff a (fun x => f x * c) = fun x => diff a f x * c := by
  funext x
  simp only [diff]
  ring

/-- A monomial is unchanged under a direction vanishing on its support. -/
theorem hyperedgeMonomial_add_of_zero_on_edge {n : Nat}
    (S : Finset (Fin n)) (x a : Fin n → ZMod 2)
    (ha : ∀ i ∈ S, a i = 0) :
    hyperedgeMonomial S (x + a) = hyperedgeMonomial S x := by
  unfold hyperedgeMonomial
  apply Finset.prod_congr rfl
  intro i hi
  simp [Pi.add_apply, ha i hi]

end VonoExactIndex
