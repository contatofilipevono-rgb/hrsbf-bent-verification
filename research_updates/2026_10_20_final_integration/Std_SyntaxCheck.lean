import Std
example (k : Fin 3) : k.val = 0 ∨ k.val = 1 ∨ k.val = 2 := by
  rcases k with ⟨k, hk⟩
  have cases : k = 0 ∨ k = 1 ∨ k = 2 := by omega
  exact cases
example (P : Nat → Prop) (hn : ¬ (∀ a, a < 4096 → P a)) :
    ∃ a : Nat, a < 4096 ∧ ¬ P a := by
  classical
  apply Classical.byContradiction
  intro h
  apply hn
  intro a ha
  apply Classical.byContradiction
  intro he
  exact h ⟨a, ha, he⟩
