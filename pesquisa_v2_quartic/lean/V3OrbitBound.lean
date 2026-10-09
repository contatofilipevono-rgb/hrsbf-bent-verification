import V3CountingFoundations

/-!
# V3 counting: permutation orbit bound

This module proves a general, reusable finite orbit-size upper bound.
The subsequent quotient-cardinality and EA-class injection remain separate goals.
-/

namespace VonoExactIndex.V3Counting

variable {α β : Type*} [Fintype α] [Fintype β]

/-- An orbit parametrized by a finite set has at most as many elements as parameters. -/
theorem orbit_image_card_le (orbit : α → β) :
    (Finset.univ.image orbit).card ≤ Fintype.card α := by
  classical
  simpa using Finset.card_image_le (s := (Finset.univ : Finset α)) (f := orbit)

/-- The number of labelled representatives obtained by relabelling a graph
    is bounded by the number of permutations, i.e. r factorial. -/
theorem relabellings_card_le_factorial (r : ℕ)
    (relabel : Equiv.Perm (Fin r) → LabelledDigraph r) :
    (Finset.univ.image relabel).card ≤ Nat.factorial r := by
  classical
  calc
    (Finset.univ.image relabel).card ≤ Fintype.card (Equiv.Perm (Fin r)) :=
      orbit_image_card_le relabel
    _ = Nat.factorial r := by simp

end VonoExactIndex.V3Counting
