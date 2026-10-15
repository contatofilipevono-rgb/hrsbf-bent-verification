import Antipodal.Cyclic
import Antipodal.Fourier
import Antipodal.Polynomial

namespace HRSBF.Antipodal

/-- The completed fiber contradiction, without a dimension-specific enumeration.
The remaining global work must derive the two structural hypotheses hd and hz.
-/
theorem not_bent_of_diagonal_and_derivative_polar_zero {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0) :
    ¬ IsBentPair g := by
  intro hb
  have hr := local_complementary_fiber_rigidity g hc hrs hd hz
  have hones : (ones : Vec (n + 1)) ≠ 0 := by
    intro he
    have he0 := congrFun he (0 : Fin (n + 1))
    norm_num [ones] at he0
  have hbal := complementary_fiber_balance g hb hd ones hones
  have hsum : fiberSum g ones =
      (Fintype.card (Vec (n + 1)) : ℤ) * sign (complementaryFiber g 0) := by
    unfold fiberSum
    change (∑ u, sign (complementaryFiber g u)) = _
    simp_rw [hr]
    simp
  have hc0 : (Fintype.card (Vec (n + 1)) : ℤ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (Vec (n + 1)) ≠ 0)
  have hs0 : sign (complementaryFiber g 0) ≠ 0 := by
    intro hs
    have hh := sign_sq (complementaryFiber g 0)
    rw [hs] at hh
    norm_num at hh
  exact (mul_ne_zero hc0 hs0) (hsum.symm.trans hbal)

/-- Same contradiction with the degree bound supplied by actual monomials. -/
theorem not_bent_of_monomials {n : ℕ}
    (p : List (List (PairSpace (n + 1) →ₗ[F₂] F₂)))
    (hp : ∀ m ∈ p, m.length ≤ 3)
    (hrs : ∀ k x, monomialSumEval p (blockShift k x) = monomialSumEval p x)
    (hd : ∀ u, monomialSumEval p (diagonal u) = monomialSumEval p 0)
    (hz : ∀ a b, polar (derivative (monomialSumEval p) (ones, ones)) a b = 0) :
    ¬ IsBentPair (monomialSumEval p) :=
  not_bent_of_diagonal_and_derivative_polar_zero _
    (hasCubicRepresentation_of_monomials p hp) hrs hd hz

end HRSBF.Antipodal
