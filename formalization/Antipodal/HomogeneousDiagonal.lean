import Antipodal.ANFPolynomial

/-! Half-turn cancellation for a homogeneous cubic, formulated for any
fixed-point-free coordinate involution. This is an algebraic diagonal
identity, not a bent nonexistence theorem. -/
namespace HRSBF.Antipodal
open Finset

/-- A support of cardinality three cannot be invariant under a free
coordinate involution: pairing its elements would give 3=0 in F₂. -/
theorem cubic_support_not_fixed {n : ℕ} (e : Equiv.Perm (Fin n))
    (he : Function.Involutive e) (hfree : ∀ i, e i ≠ i)
    (s : Finset (Fin n)) (hcard : s.card = 3) : s.map e.toEmbedding ≠ s := by
  intro hfix
  have hmem (i : Fin n) (hi : i ∈ s) : e i ∈ s := by
    rw [← hfix]
    exact mem_map.mpr ⟨i, hi, rfl⟩
  have hsum : (∑ _i ∈ s, (1 : F₂)) = 0 := by
    apply sum_involution (fun i _ => e i)
    · intro i hi
      decide
    · intro i hi _
      exact hfree i
    · exact hmem
    · intro i hi
      exact he i
  simp only [sum_const, hcard] at hsum
  norm_num at hsum
  exact (by decide : (3 : F₂) ≠ 0) hsum

/-- For invariant homogeneous cubics, every vector fixed by a free
coordinate involution has function value zero. Affine terms are excluded
here precisely by the declared canonical homogeneity hypothesis. -/
theorem homogeneous_cubic_vanishes_on_fixed_vectors {n : ℕ}
    (f : Vec n → F₂) (hf : IsHomogeneousCubic f)
    (e : Equiv.Perm (Fin n)) (he : Function.Involutive e)
    (hfree : ∀ i, e i ≠ i)
    (hinv : ∀ x : Vec n, f (fun i => x (e i)) = f x)
    (x : Vec n) (hx : ∀ i, x (e i) = x i) : f x = 0 := by
  classical
  rw [← anf_polynomial_evaluation f x]
  let E : Finset (Fin n) → Finset (Fin n) := fun s => s.map e.toEmbedding
  have hE (s : Finset (Fin n)) : E (E s) = s := by
    ext i
    simp only [E, mem_map]
    constructor
    · rintro ⟨j, ⟨k, hk, hj⟩, hi⟩
      have hki : k = i := by
        have hh : e (e k) = i := by simpa only [← hj] using hi
        exact (he k).symm.trans hh
      simpa only [← hki] using hk
    · intro hi
      exact ⟨e i, ⟨i, hi, rfl⟩, he i⟩
  have hmon (s : Finset (Fin n)) : squarefreeMonomial (E s) x = squarefreeMonomial s x := by
    unfold squarefreeMonomial E
    rw [prod_map]
    apply prod_congr rfl
    intro i hi
    exact hx i
  have hc (s : Finset (Fin n)) : anfCoefficient f (E s) = anfCoefficient f s :=
    anfCoefficient_permutation f e hinv s
  apply sum_involution (fun s _ => E s)
  · intro s hs
    rw [hc, hmon, CharTwo.add_self_eq_zero]
  · intro s hs hterm hfix
    have hcoeff : anfCoefficient f s ≠ 0 := by
      intro hz
      rw [hz, zero_mul] at hterm
      exact hterm rfl
    have hcard : s.card = 3 := by
      by_contra hh
      exact hcoeff (hf.1 s hh)
    exact cubic_support_not_fixed e he hfree s hcard hfix
  · intro s hs
    exact mem_univ _
  · intro s hs
    exact hE s

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.cubic_support_not_fixed
#print axioms HRSBF.Antipodal.homogeneous_cubic_vanishes_on_fixed_vectors
