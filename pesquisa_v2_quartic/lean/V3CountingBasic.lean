import Mathlib

/-! Basic finite combinatorial counting lemmas for V3. -/

namespace VonoExactIndex.V3Counting

/-- The number of directed off-diagonal potential edges on `Fin r`. -/
theorem edge_positions_card (r : ℕ) :
    (Finset.univ.filter (fun p : Fin r × Fin r => p.1 ≠ p.2)).card = r * (r - 1) := by
  classical
  simp only [Finset.card_filter]
  sorry

end VonoExactIndex.V3Counting
