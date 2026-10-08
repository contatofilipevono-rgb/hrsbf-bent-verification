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

/-- On an independent coordinate subspace, every hyperedge has at most
one coordinate that can vary. -/
theorem independent_edge_one_varying {n : Nat}
    (H : Finset (Finset (Fin n))) (I : Finset (Fin n))
    (hI : HypergraphIndependent H I)
    (S : Finset (Fin n)) (hS : S ∈ H) :
    (S ∩ I).card ≤ 1 := by
  classical
  apply Finset.card_le_one.mpr
  intro i hi j hj
  exact hI S hS i (Finset.mem_inter.mp hi).2
    j (Finset.mem_inter.mp hj).2
    (Finset.mem_inter.mp hi).1 (Finset.mem_inter.mp hj).1

/-- If a monomial meets the varying coordinates in at most one place,
its second difference vanishes along any two directions supported there. -/
theorem hyperedge_secondDiff_zero_of_card_le_one {n : Nat}
    (S I : Finset (Fin n)) (hcard : (S ∩ I).card ≤ 1)
    (a b x : Fin n → ZMod 2)
    (ha : a ∈ independentCoordinateSubmodule I)
    (hb : b ∈ independentCoordinateSubmodule I) :
    diff a (diff b (hyperedgeMonomial S)) x = 0 := by
  classical
  have hsplit : (S ∩ I) = ∅ ∨ ∃ i, S ∩ I = {i} := by
    exact Finset.card_le_one.mp hcard
  rcases hsplit with hempty | ⟨i, hone⟩
  · have hzeroa : ∀ j ∈ S, a j = 0 := by
      intro j hj
      apply (mem_independentCoordinateSubmodule I a).mp ha j
      intro hjI
      have : j ∈ S ∩ I := Finset.mem_inter.mpr ⟨hj, hjI⟩
      rw [hempty] at this
      simpa using this
    have hzero : diff a (hyperedgeMonomial S) = 0 := by
      funext y
      simp [diff, hyperedgeMonomial_add_of_zero_on_edge S y a hzeroa]
    have hcomm : diff a (diff b (hyperedgeMonomial S)) =
        diff b (diff a (hyperedgeMonomial S)) := by
      funext y
      simp only [diff]
      have : y + b + a = y + a + b := by abel
      rw [this]
      abel
    rw [hcomm, hzero]
    simp
  · have hother : ∀ j ∈ S, j ≠ i → a j = 0 ∧ b j = 0 := by
      intro j hj hji
      have hjnot : j ∉ I := by
        intro hjI
        have : j ∈ S ∩ I := Finset.mem_inter.mpr ⟨hj, hjI⟩
        rw [hone] at this
        exact hji (Finset.mem_singleton.mp this)
      exact ⟨(mem_independentCoordinateSubmodule I a).mp ha j hjnot,
        (mem_independentCoordinateSubmodule I b).mp hb j hjnot⟩
    have hfact (y : Fin n → ZMod 2) :
        hyperedgeMonomial S y =
          y i * (∏ j ∈ S.erase i, y j) := by
      have hi : i ∈ S := by
        have : i ∈ S ∩ I := by rw [hone]; simp
        exact (Finset.mem_inter.mp this).1
      unfold hyperedgeMonomial
      rw [← Finset.mul_prod_erase S (fun j => y j) hi]
    have hconst (y : Fin n → ZMod 2) (d : Fin n → ZMod 2)
        (hd : ∀ j ∈ S, j ≠ i → d j = 0) :
        (∏ j ∈ S.erase i, (y + d) j) =
          (∏ j ∈ S.erase i, y j) := by
      apply Finset.prod_congr rfl
      intro j hj
      have hjs : j ∈ S := (Finset.mem_erase.mp hj).2
      have hji : j ≠ i := (Finset.mem_erase.mp hj).1
      simp [Pi.add_apply, hd j hjs hji]
    let c : ZMod 2 := ∏ j ∈ S.erase i, x j
    have hvalue (u v : Fin n → ZMod 2) :
        hyperedgeMonomial S (x + u + v) =
          (x i + u i + v i) * c := by
      rw [hfact]
      have hc : (∏ j ∈ S.erase i, (x + u + v) j) = c := by
        apply Finset.prod_congr rfl
        intro j hj
        have hjs : j ∈ S := (Finset.mem_erase.mp hj).2
        have hji : j ≠ i := (Finset.mem_erase.mp hj).1
        have hzeroa := (hother j hjs hji).1
        have hzerob := (hother j hjs hji).2
        simp [Pi.add_apply, hzeroa, hzerob, c]
      rw [hc]
      simp [Pi.add_apply, c]
    simp only [diff]
    rw [show x + a + b = x + b + a by abel]
    rw [hvalue b a, hvalue b 0, hvalue a 0, hvalue 0 0]
    ring

end VonoExactIndex
