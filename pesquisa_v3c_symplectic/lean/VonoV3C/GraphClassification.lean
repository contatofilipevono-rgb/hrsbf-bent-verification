import VonoV3C.GraphEdgeRecovery

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

def GraphIsomorphic (adjG adjH : ι → ι → Bool) : Prop :=
  ∃ perm : ι ≃ ι, ∀ i j, adjH i j = adjG (perm i) (perm j)

/-- The recovered input permutation is a directed-graph isomorphism. -/
theorem EA_implies_graph_isomorphic (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH)
    (h : EAEquivalent (graphMap hm adjG) (graphMap hm adjH)) :
    GraphIsomorphic adjG adjH := by
  classical
  rcases h with ⟨A,B,t,L,k,he⟩
  obtain ⟨perm,hp⟩ := EA_recovers_blocks hm adjG adjH A B t L k he
  choose e heblock using hp
  refine ⟨perm, ?_⟩
  intro i j
  by_cases hij : i = j
  · subst j
    rw [hH, hG]
  · exact representation_edges hm adjG adjH A B t L k he perm e heblock i j hij

def reindexLinear {M : Type*} [AddCommGroup M] [Module Scalar M]
    (perm : ι ≃ ι) : (ι → M) ≃ₗ[Scalar] (ι → M) where
  toFun x i := x (perm.symm i)
  invFun x i := x (perm i)
  left_inv := by intro x; funext i; simp
  right_inv := by intro x; funext i; simp
  map_add' := by intro x y; rfl
  map_smul' := by intro c x; rfl

@[simp] theorem reindexLinear_apply {M : Type*} [AddCommGroup M] [Module Scalar M]
    (perm : ι ≃ ι) (x : ι → M) (i : ι) :
    reindexLinear perm x i = x (perm.symm i) := rfl

theorem graphMap_reindex (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool) (perm : ι ≃ ι)
    (hp : ∀ i j, adjH i j = adjG (perm i) (perm j)) (x : Input ι m) :
    graphMap hm adjH x =
      reindexLinear perm.symm (graphMap hm adjG (reindexLinear perm x)) := by
  funext i
  have hc : couplingLinear hm adjG (perm i) (reindexLinear perm x) =
      couplingLinear hm adjH i x := by
    funext l
    by_cases h0 : l = 0
    · simp [couplingLinear, h0]
    · by_cases h1 : l = 1
      · simp [couplingLinear, h0, h1]
      · change (if l = 0 then _ else if l = 1 then _ else _) =
          (if l = 0 then _ else if l = 1 then _ else _)
        simp only [h0, h1, if_false]
        change (∑ j, if adjG (perm i) j then p hm (x (perm.symm j)) else 0) =
          ∑ j, if adjH i j then p hm (x j) else 0
        rw [← perm.sum_comp (fun j => if adjG (perm i) j then p hm (x (perm.symm j)) else 0)]
        simp only [Equiv.symm_apply_apply, ← hp]
  change seed m (x i) + cubic (couplingLinear hm adjH i x) =
    seed m (reindexLinear perm x (perm i)) +
      cubic (couplingLinear hm adjG (perm i) (reindexLinear perm x))
  rw [hc]
  simp

theorem graph_isomorphic_implies_EA (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (h : GraphIsomorphic adjG adjH) :
    EAEquivalent (graphMap hm adjG) (graphMap hm adjH) := by
  rcases h with ⟨perm,hp⟩
  refine ⟨reindexLinear perm, reindexLinear perm.symm, 0, 0, 0, ?_⟩
  intro x
  simpa using graphMap_reindex hm adjG adjH perm hp x

/-- Ordinary EA classes of canonical loopless directed graph representatives.
No assumption on internal symplectic maps or on unidirectionality is imposed. -/
theorem canonical_EA_iff_graph_isomorphic (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH) :
    EAEquivalent (graphMap hm adjG) (graphMap hm adjH) ↔ GraphIsomorphic adjG adjH := by
  constructor
  · exact EA_implies_graph_isomorphic hm adjG adjH hG hH
  · exact graph_isomorphic_implies_EA hm adjG adjH

end VonoV3C.GraphFamily
