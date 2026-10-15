import Antipodal.GlobalAntipodal

/-! Finite boundary witnesses only. These checks show that the universal
premises are nonvacuous, including nonzero affine/constant terms. The
universal theorems themselves use no dimension enumeration. -/
namespace HRSBF.Antipodal

def boundaryBent (a c : F₂) (x : Vec 2) : F₂ :=
  x 0 * x 1 + a * (x 0 + x 1) + c

theorem boundaryBent_degree (a c : F₂) : HasAlgebraicDegreeAtMostThree (boundaryBent a c) := by
  intro s hs
  have hcard : s.card ≤ 2 := by
    have hh := Finset.card_le_card (Finset.subset_univ s)
    simpa using hh
  omega

theorem boundaryBent_rotation (a c : F₂) : IsRotationSymmetric (boundaryBent a c) := by
  revert a c
  unfold IsRotationSymmetric boundaryBent rotate
  decide

theorem boundaryBent_bent (a c : F₂) : IsBent (boundaryBent a c) := by
  revert a c
  unfold IsBent walsh transform character dot sign boundaryBent
  decide

theorem universal_premises_nonvacuous :
    ∃ f : Vec 2 → F₂, HasAlgebraicDegreeAtMostThree f ∧ IsRotationSymmetric f ∧ IsBent f :=
  ⟨boundaryBent 1 1, boundaryBent_degree 1 1, boundaryBent_rotation 1 1, boundaryBent_bent 1 1⟩

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.universal_premises_nonvacuous
