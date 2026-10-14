import VonoExactIndex.GraphEA

namespace VonoExactIndex.GraphFamily

/-- A connected star for every number of blocks at least two. -/
def starAdj (r : ℕ) (i j : Fin (r + 2)) : Bool := decide (i = 0 ∧ j ≠ 0)

theorem star_cut_connected (r : ℕ) : CutConnected (starAdj r) := by
  classical
  intro I hne hproper
  by_cases hz : (0 : Fin (r + 2)) ∈ I
  · have hex : ∃ j : Fin (r + 2), j ∉ I := by
      by_contra hn
      apply hproper
      apply Finset.eq_univ_of_forall
      intro j
      by_contra hj
      exact hn ⟨j, hj⟩
    obtain ⟨j, hj⟩ := hex
    refine ⟨0, hz, j, hj, Or.inl ?_⟩
    have hj0 : j ≠ 0 := by intro he; subst j; exact hj hz
    simp [starAdj, hj0]
  · obtain ⟨i, hi⟩ := hne
    refine ⟨i, hi, 0, hz, Or.inr ?_⟩
    have hi0 : i ≠ 0 := by intro he; subst i; exact hz hi
    simp [starAdj, hi0]

theorem star_exact_index (r : ℕ) :
    HasVectorRelaxedIndex (graphMap (starAdj r)) (r + 2) := by
  simpa using graph_has_exact_index (starAdj r)

theorem star_no_relaxed_split (r : ℕ) : ¬ HasRelaxedSplit (graphMap (starAdj r)) :=
  graph_no_relaxed_split (starAdj r) (star_cut_connected r)

theorem star_quadratic_exact_index (r : ℕ)
    (Q : Input (Fin (r + 2)) → Fin (r + 2) → ZMod 2)
    (hQ : HasConstantSecondDifferences Q) :
    HasVectorRelaxedIndex (addVector (graphMap (starAdj r)) Q) (r + 2) := by
  simpa using graph_quadratic_exact_index (starAdj r) Q hQ

theorem star_quadratic_no_relaxed_split (r : ℕ)
    (Q : Input (Fin (r + 2)) → Fin (r + 2) → ZMod 2)
    (hQ : HasConstantSecondDifferences Q) :
    ¬ HasRelaxedSplit (addVector (graphMap (starAdj r)) Q) :=
  graph_quadratic_no_relaxed_split (starAdj r) (star_cut_connected r) Q hQ

/-- Explicit ANF perturbations retain both the exact index and the obstruction to EA products. -/
theorem graph_ANF_certified {ι : Type*} [Fintype ι] [DecidableEq ι]
    {κ : Type*} [Fintype κ] (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (c : ι → ZMod 2) (L : Input ι →ₗ[ZMod 2] (ι → ZMod 2))
    (l m : κ → Input ι →ₗ[ZMod 2] ZMod 2) (w : κ → ι → ZMod 2) :
    let Q := fun x i => c i + L x i + ∑ k, w k i * (l k x * m k x)
    HasVectorRelaxedIndex (addVector (graphMap adj) Q) (Fintype.card ι) ∧
      ¬ HasRelaxedSplit (addVector (graphMap adj) Q) := by
  dsimp only
  have hQ := quadratic_ANF_second_constant c L l m w
  exact ⟨graph_quadratic_exact_index adj _ hQ,
    graph_quadratic_no_relaxed_split adj hconn _ hQ⟩

#print axioms star_exact_index
#print axioms star_no_relaxed_split
end VonoExactIndex.GraphFamily
