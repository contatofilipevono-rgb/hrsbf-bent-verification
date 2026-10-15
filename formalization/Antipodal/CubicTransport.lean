import Antipodal.ANFPolynomial
import Antipodal.OddRestriction

namespace HRSBF.Antipodal

/-- Degree-at-most-three polynomial functions are stable under arbitrary
linear substitutions, including folding and concatenation. -/
theorem hasCubicRepresentation_comp_linear
    {V W : Type*} [AddCommGroup V] [Module F₂ V]
    [AddCommGroup W] [Module F₂ W]
    (f : V → F₂) (hf : HasCubicRepresentation f) (L : W →ₗ[F₂] V) :
    HasCubicRepresentation (fun x => f (L x)) := by
  rcases hf with ⟨p, rfl⟩
  let A : AffineExpr V → AffineExpr W := fun a => ⟨a.linear.comp L, a.constant⟩
  let T : CubicTerm V → CubicTerm W := fun t => (A t.1, A t.2.1, A t.2.2)
  refine ⟨p.map T, ?_⟩
  funext x
  simp only [polynomialEval, List.map_map]
  congr 1

/-- The odd-order restriction theorem with precisely the canonical ANF
degree hypothesis, rather than an additional representation assumption. -/
theorem odd_order_bent_restriction_of_anf_degree {n d : ℕ}
    (f : Vec n → F₂) (hd : HasAlgebraicDegreeAtMostThree f) (hb : IsBent f)
    (S : Vec n ≃ₗ[F₂] Vec n) (hs : ∀ x, f (S x) = f x)
    (m : ℕ) (hodd : Odd m) (horder : S.toLinearMap ^ m = 1)
    (e : Vec d ≃ₗ[F₂] fixedSubspace S) :
    IsBent (fun x : Vec d => f (e x)) :=
  odd_order_bent_restriction f (hasCubicRepresentation_of_anf_degree f hd)
    hb S hs m hodd horder e

theorem homogeneous_cubic_degree_at_most_three {n : ℕ}
    (f : Vec n → F₂) (hf : IsHomogeneousCubic f) : HasAlgebraicDegreeAtMostThree f := by
  intro s hs
  exact hf.1 s (by omega)

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.hasCubicRepresentation_comp_linear
#print axioms HRSBF.Antipodal.odd_order_bent_restriction_of_anf_degree
