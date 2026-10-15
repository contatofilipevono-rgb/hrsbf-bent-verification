import Antipodal.ANFPermutation

namespace HRSBF.Antipodal
open Finset

/-- Evaluation of a squarefree ANF support. -/
def squarefreeMonomial {n : ℕ} (s : Finset (Fin n)) (x : Vec n) : F₂ := ∏ i ∈ s, x i

theorem squarefreeMonomial_eq_indicator {n : ℕ} (s : Finset (Fin n)) (x : Vec n) :
    squarefreeMonomial s x = if s ⊆ vectorSupport x then 1 else 0 := by
  classical
  split_ifs with hs
  · apply prod_eq_one
    intro i hi
    exact (mem_filter.mp (hs hi)).2
  · have he : ∃ i ∈ s, x i = 0 := by
      have hh : ∃ i ∈ s, i ∉ vectorSupport x := by
        simp only [Finset.subset_iff] at hs
        push_neg at hs
        exact hs
      obtain ⟨i, hi, hni⟩ := hh
      have hz : x i ≠ 1 := by simpa [vectorSupport] using hni
      exact ⟨i, hi, ((by decide : ∀ c : F₂, c = 0 ∨ c = 1) (x i)).resolve_right hz⟩
    exact prod_eq_zero_iff.mpr he

/-- The usual sum-of-monomials ANF evaluation, derived from reconstruction. -/
theorem anf_polynomial_evaluation {n : ℕ} (f : Vec n → F₂) (x : Vec n) :
    (∑ s : Finset (Fin n), anfCoefficient f s * squarefreeMonomial s x) = f x := by
  classical
  simp_rw [squarefreeMonomial_eq_indicator, mul_ite, mul_one, mul_zero]
  rw [← sum_filter]
  have he : univ.filter (fun s : Finset (Fin n) => s ⊆ vectorSupport x) =
      (vectorSupport x).powerset := by ext s; simp
  rw [he]
  exact anf_reconstruction f x

/-- The canonical ANF degree bound supplies the existing cubic interface.
It is not an additional polynomial-structure assumption. -/
theorem hasCubicRepresentation_of_anf_degree {n : ℕ} (f : Vec n → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) : HasCubicRepresentation f := by
  classical
  let active : Finset (Finset (Fin n)) := univ.filter (fun s => anfCoefficient f s = 1)
  let forms : Finset (Fin n) → List (Vec n →ₗ[F₂] F₂) :=
    fun s => s.toList.map (fun i => LinearMap.proj i)
  let p := active.toList.map forms
  have hlength : ∀ m ∈ p, m.length ≤ 3 := by
    intro m hm
    obtain ⟨s, hs, rfl⟩ := List.mem_map.mp hm
    have hs1 : anfCoefficient f s = 1 := (mem_filter.mp (mem_toList.mp hs)).2
    have hcard : s.card ≤ 3 := by
      by_contra hh
      have hz := hd s (by omega)
      rw [hs1] at hz
      exact one_ne_zero hz
    simpa only [forms, List.length_map, Finset.length_toList] using hcard
  have hp := hasCubicRepresentation_of_monomials p hlength
  have heval : monomialSumEval p = f := by
    funext x
    change ((active.toList.map forms).map (fun m => monomialEval m x)).sum = f x
    rw [List.map_map]
    rw [Finset.sum_to_list]
    have hmon (s : Finset (Fin n)) : monomialEval (forms s) x = squarefreeMonomial s x := by
      unfold monomialEval forms
      rw [List.map_map]
      exact Finset.prod_to_list s (fun i => x i)
    change (∑ s ∈ active, monomialEval (forms s) x) = f x
    simp_rw [hmon]
    dsimp only [active]
    rw [sum_filter]
    have hterm (s : Finset (Fin n)) :
        (if anfCoefficient f s = 1 then squarefreeMonomial s x else 0) =
          anfCoefficient f s * squarefreeMonomial s x := by
      have hc := (by decide : ∀ c : F₂, c = 0 ∨ c = 1) (anfCoefficient f s)
      rcases hc with hc | hc <;> simp [hc]
    simp_rw [hterm]
    exact anf_polynomial_evaluation f x
  rw [heval] at hp
  exact hp

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.anf_polynomial_evaluation
#print axioms HRSBF.Antipodal.hasCubicRepresentation_of_anf_degree
