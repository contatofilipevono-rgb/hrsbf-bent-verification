import Antipodal.Main
import Antipodal.CyclicQuadraticRigidity

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


namespace HRSBF.Antipodal

/-- A cubic derivative is quadratic, with arbitrary affine and constant terms. -/
theorem cubic_derivative_third_zero
    {V : Type*} [AddCommGroup V] [Module F₂ V]
    (g : V → F₂) (hc : HasCubicRepresentation g) (d a b c : V) :
    third (derivative g d) a b c = 0 := by
  have hid (f : V → F₂) : third f a b c =
      polar f a (b+c) + polar f a b + polar f a c := by
    unfold third polar
    simp only [add_assoc]
    ring_nf
    simp
  rw [hid, polar_derivative, polar_derivative, polar_derivative,
    third_add_middle hc]
  ring_nf
  simp

/-- Transfer the unconditional quadratic theorem to a cubic derivative in
linear cyclic coordinates. Balance and rotation remain explicit bridges;
no zero-polar or radical-image hypothesis is assumed. -/
theorem cubic_derivative_polar_zero_in_cyclic_coordinates
    {V : Type*} [AddCommGroup V] [Module F₂ V] [Fintype V]
    (k : ℕ) (hk : 1 ≤ k) (e : Vec (2^k) ≃ₗ[F₂] V)
    (g : V → F₂) (hc : HasCubicRepresentation g) (d : V)
    (hs : ∀ x, derivative g d (e (cyclicShift (2^k) x)) = derivative g d (e x))
    (hbalanced : (∑ x : V, sign (derivative g d x)) = 0) :
    ∀ a b, polar (derivative g d) a b = 0 := by
  let Q : Vec (2^k) → F₂ := fun x => derivative g d (e x)
  have hq : ∀ a b c, third Q a b c = 0 := by
    intro a b c
    simpa only [Q, third, map_add, map_zero] using
      cubic_derivative_third_zero g hc d (e a) (e b) (e c)
  have hbal : (∑ x : Vec (2^k), sign (Q x)) = 0 :=
    (Equiv.sum_comp e.toEquiv (fun x => sign (derivative g d x))).trans hbalanced
  have hz := balanced_rotation_invariant_quadratic_polar_zero k hk Q hq hs hbal
  intro a b
  simpa only [Q, polar, map_add, map_zero, LinearEquiv.apply_symm_apply] using
    hz (e.symm a) (e.symm b)

/-- Integrates Lemma 5.1 with the original fiber contradiction.
The remaining cubic bridges are explicitly visible as hd, hs and hbalanced. -/
theorem not_bent_of_diagonal_and_balanced_cyclic_derivative {n : ℕ}
    (k : ℕ) (hk : 1 ≤ k)
    (e : Vec (2^k) ≃ₗ[F₂] PairSpace (n+1))
    (g : PairSpace (n+1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ j x, g (blockShift j x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hs : ∀ x, derivative g (ones, ones) (e (cyclicShift (2^k) x)) =
      derivative g (ones, ones) (e x))
    (hbalanced : (∑ x : PairSpace (n+1), sign (derivative g (ones, ones) x)) = 0) :
    ¬ IsBentPair g := by
  exact not_bent_of_diagonal_and_derivative_polar_zero g hc hrs hd
    (cubic_derivative_polar_zero_in_cyclic_coordinates k hk e g hc (ones, ones) hs hbalanced)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.cubic_derivative_third_zero
#print axioms HRSBF.Antipodal.cubic_derivative_polar_zero_in_cyclic_coordinates
#print axioms HRSBF.Antipodal.not_bent_of_diagonal_and_balanced_cyclic_derivative
