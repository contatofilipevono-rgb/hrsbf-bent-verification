import Antipodal.LocalRigidity

namespace HRSBF.Antipodal

section PolynomialBridge
variable {V : Type*} [AddCommGroup V] [Module F₂ V]

/-- A monomial is a product of coordinate linear forms; the empty product is 1. -/
def monomialEval (m : List (V →ₗ[F₂] F₂)) (x : V) : F₂ :=
  (m.map (fun L => L x)).prod

def monomialSumEval (p : List (List (V →ₗ[F₂] F₂))) (x : V) : F₂ :=
  (p.map (fun m => monomialEval m x)).sum

private def affineOne : AffineExpr V := ⟨0, 1⟩
private def affineLinear (L : V →ₗ[F₂] F₂) : AffineExpr V := ⟨L, 0⟩

private def monomialTerm : List (V →ₗ[F₂] F₂) → CubicTerm V
  | [] => (affineOne, affineOne, affineOne)
  | [a] => (affineLinear a, affineOne, affineOne)
  | [a,b] => (affineLinear a, affineLinear b, affineOne)
  | a :: b :: c :: _ => (affineLinear a, affineLinear b, affineLinear c)

private lemma monomialTerm_correct (m : List (V →ₗ[F₂] F₂)) (hm : m.length ≤ 3) (x : V) :
    termEval (monomialTerm m) x = monomialEval m x := by
  cases m with
  | nil => simp [monomialTerm, monomialEval, termEval, affineOne, AffineExpr.eval]
  | cons a m =>
    cases m with
    | nil => simp [monomialTerm, monomialEval, termEval, affineOne, affineLinear, AffineExpr.eval]
    | cons b m =>
      cases m with
      | nil => simp [monomialTerm, monomialEval, termEval, affineOne, affineLinear, AffineExpr.eval]
      | cons c m =>
        have he : m = [] := by simpa using hm
        subst m
        simp [monomialTerm, monomialEval, termEval, affineLinear, AffineExpr.eval, mul_assoc]

/-- This supplies the degree hypothesis from an ordinary sum of monomials of length ≤ 3.
In particular, it applies to ANF written using coordinate projections.
-/
theorem hasCubicRepresentation_of_monomials (p : List (List (V →ₗ[F₂] F₂)))
    (hp : ∀ m ∈ p, m.length ≤ 3) : HasCubicRepresentation (monomialSumEval p) := by
  refine ⟨p.map monomialTerm, ?_⟩
  funext x
  unfold polynomialEval monomialSumEval
  rw [List.map_map]
  congr 1
  apply List.map_congr_left
  intro m hm
  exact (monomialTerm_correct m (hp m hm) x).symm

end PolynomialBridge
end HRSBF.Antipodal
