import Antipodal.LocalRigidity

/-!
A finite-difference, coordinate-free bridge: a polynomial of algebraic
degree at most two has an additive normalized polar in both arguments.
The zero-third-difference hypothesis is explicit and is not postulated
for all functions.
-/

namespace HRSBF.Antipodal

def IsQuadratic {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) : Prop :=
  ∀ a b c, third Q a b c = 0

theorem quadratic_polar_add_right {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (a b c : V) :
    polar Q a (b + c) = polar Q a b + polar Q a c := by
  have hh := hq a b c
  have hi : third Q a b c =
      polar Q a (b + c) + polar Q a b + polar Q a c := by
    unfold third polar
    simp only [add_assoc]
    ring_nf
    simp
  rw [hi] at hh
  calc
    polar Q a (b + c) =
        (polar Q a (b + c) + polar Q a b + polar Q a c) +
        (polar Q a b + polar Q a c) := by
          ring_nf
          simp
    _ = polar Q a b + polar Q a c := by rw [hh]; simp

theorem polar_symmetric {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (a b : V) :
    polar Q a b = polar Q b a := by
  unfold polar
  rw [add_comm a b]
  ring

theorem quadratic_polar_add_left {V : Type*} [AddCommGroup V] [Module F₂ V]
    (Q : V → F₂) (hq : ∀ a b c, third Q a b c = 0)
    (a b c : V) :
    polar Q (a + b) c = polar Q a c + polar Q b c := by
  rw [polar_symmetric Q (a + b) c, quadratic_polar_add_right Q hq,
    polar_symmetric Q c a, polar_symmetric Q c b]

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.quadratic_polar_add_right
#print axioms HRSBF.Antipodal.quadratic_polar_add_left
