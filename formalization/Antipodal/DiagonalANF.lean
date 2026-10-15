import Antipodal.HomogeneousDiagonal

namespace HRSBF.Antipodal
open Finset

/-- The precise canonical diagonal identity needed by the fiber argument:
for degree≤3, absence of every quadratic pair of a free involution makes
the function constant on the involution's fixed vectors. -/
theorem constant_on_fixed_vectors_of_antipodal_absence {n : ℕ}
    (f : Vec n → F₂) (hd : HasAlgebraicDegreeAtMostThree f)
    (e : Equiv.Perm (Fin n)) (he : Function.Involutive e)
    (hfree : ∀ i, e i ≠ i)
    (hinv : ∀ x : Vec n, f (fun i => x (e i)) = f x)
    (hpair : ∀ i, anfCoefficient f {i,e i} = 0)
    (x : Vec n) (hx : ∀ i, x (e i) = x i) : f x = f 0 := by
  classical
  let E : Finset (Fin n) → Finset (Fin n) := fun s => s.map e.toEmbedding
  have hE (s : Finset (Fin n)) : E (E s) = s := by
    ext i
    simp only [E, mem_map]
    constructor
    · rintro ⟨j, ⟨k, hk, hj⟩, hi⟩
      have hh : e (e k) = i := by simpa only [← hj] using hi
      have hki := (he k).symm.trans hh
      simpa only [← hki] using hk
    · intro hi
      exact ⟨e i, ⟨i, hi, rfl⟩, he i⟩
  have hfixed (s : Finset (Fin n)) (hs : s ≠ ∅) (hfix : E s = s) : anfCoefficient f s = 0 := by
    by_contra hc
    have hcard : s.card ≤ 3 := by
      by_contra hh
      exact hc (hd s (by omega))
    have hcases : s.card = 0 ∨ s.card = 1 ∨ s.card = 2 ∨ s.card = 3 := by omega
    rcases hcases with h0 | h1 | h2 | h3
    · exact hs (card_eq_zero.mp h0)
    · obtain ⟨i, rfl⟩ := card_eq_one.mp h1
      have hi : e i ∈ ({i} : Finset (Fin n)) := by
        rw [← hfix]
        exact mem_map.mpr ⟨i, mem_singleton_self i, rfl⟩
      exact hfree i (mem_singleton.mp hi)
    · obtain ⟨i,j,hij,rfl⟩ := card_eq_two.mp h2
      have hei : e i ∈ ({i,j} : Finset (Fin n)) := by
        rw [← hfix]
        exact mem_map.mpr ⟨i, by simp, rfl⟩
      have heij : e i = j := (mem_insert.mp hei).resolve_left (hfree i) |> mem_singleton.mp
      exact hc (by simpa only [heij] using hpair i)
    · exact cubic_support_not_fixed e he hfree s h3 hfix
  let term : Finset (Fin n) → F₂ := fun s => anfCoefficient f s * squarefreeMonomial s x
  have hterm (s : Finset (Fin n)) : term (E s) = term s := by
    change anfCoefficient f (s.map e.toEmbedding) * squarefreeMonomial (s.map e.toEmbedding) x = _
    rw [anfCoefficient_permutation f e hinv]
    unfold squarefreeMonomial
    rw [prod_map]
    congr 1
    apply prod_congr rfl
    intro i hi
    exact hx i
  have hsum : (∑ s ∈ (univ : Finset (Finset (Fin n))).erase ∅, term s) = 0 := by
    apply sum_involution (fun s _ => E s)
    · intro s hs
      rw [hterm, CharTwo.add_self_eq_zero]
    · intro s hs hne hfix
      have hs0 : s ≠ ∅ := (mem_erase.mp hs).1
      have hc0 := hfixed s hs0 hfix
      exact hne (by simp only [term, hc0, zero_mul])
    · intro s hs
      apply mem_erase.mpr
      refine ⟨?_, mem_univ _⟩
      intro hh
      have h := congrArg E hh
      rw [hE] at h
      exact (mem_erase.mp hs).1 h
    · intro s hs
      exact hE s
  have hfull := sum_erase_add (univ : Finset (Finset (Fin n))) term (mem_univ ∅)
  rw [hsum, zero_add] at hfull
  have hempty : term ∅ = f 0 := by
    have hz : supportVector (∅ : Finset (Fin n)) = (0 : Vec n) := by
      funext i
      simp [supportVector]
    simp [term, anfCoefficient, booleanMobius, squarefreeMonomial, hz]
  rw [hempty] at hfull
  exact (anf_polynomial_evaluation f x).symm.trans hfull.symm

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.constant_on_fixed_vectors_of_antipodal_absence
