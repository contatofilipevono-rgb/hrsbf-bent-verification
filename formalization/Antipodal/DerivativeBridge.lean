import Antipodal.Main

/-!
Explicit interfaces to the remaining global proof obligations.
These derive nontrivial structural constraints on *every* bent,
rotation-symmetric cubic under a constant-diagonal hypothesis,
but do not assume or assert the universal antipodal theorem.
-/

namespace HRSBF.Antipodal

/-- With a constant diagonal, a rotation-symmetric cubic bent function
must have a derivative with nonzero quadratic polar. The missing
power-of-two rigidity theorem will contradict this. -/
theorem bent_forces_derivative_polar_witness {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hb : IsBentPair g) :
    ∃ a b, polar (derivative g (ones, ones)) a b ≠ 0 := by
  by_contra hno
  have hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0 := by
    intro a b
    by_contra hne
    exact hno ⟨a, b, hne⟩
  exact (not_bent_of_diagonal_and_derivative_polar_zero g hc hrs hd hz) hb

/-- Contrapositive formulation required in the antipodal coefficient bridge:
a bent cubic with zero derivative polar cannot have a constant diagonal. -/
theorem bent_forces_nonconstant_diagonal {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0)
    (hb : IsBentPair g) :
    ∃ u, g (diagonal u) ≠ g 0 := by
  by_contra hno
  have hd : ∀ u, g (diagonal u) = g 0 := by
    intro u
    by_contra hne
    exact hno ⟨u, hne⟩
  exact (not_bent_of_diagonal_and_derivative_polar_zero g hc hrs hd hz) hb

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.bent_forces_derivative_polar_witness
#print axioms HRSBF.Antipodal.bent_forces_nonconstant_diagonal
