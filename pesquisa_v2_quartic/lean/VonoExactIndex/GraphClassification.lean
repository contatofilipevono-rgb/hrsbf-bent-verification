import VonoExactIndex.GraphEdgeRecovery

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

def Loopless (adj : ι → ι → Bool) : Prop := ∀ i, adj i i = false

def GraphIsomorphic (adjG adjH : ι → ι → Bool) : Prop :=
  ∃ p : ι ≃ ι, ∀ i j, adjH i j = adjG (p i) (p j)

/-- Even a quadratic-corrected equivalence of canonical maps determines the directed graph. -/
theorem quadraticEA_implies_graph_isomorphic (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH)
    (h : QuadraticEA (graphMap adjG) (graphMap adjH)) : GraphIsomorphic adjG adjH := by
  classical
  rcases h with ⟨A,B,t,Q,hQ,he⟩
  obtain ⟨p,hp⟩ := recover_blocks A (representation_pair adjG adjH A B t Q hQ he)
  choose e heblock using hp
  refine ⟨p, ?_⟩
  intro i j
  by_cases hij : i = j
  · subst j
    rw [hH, hG]
  · exact representation_edges adjG adjH A B t Q hQ he p e heblock i j hij

/-- Simultaneous relabeling of finite coordinates as a linear equivalence. -/
def reindexLinear {M : Type*} [AddCommGroup M] [Module (ZMod 2) M]
    (p : ι ≃ ι) : (ι → M) ≃ₗ[ZMod 2] (ι → M) where
  toFun x i := x (p.symm i)
  invFun x i := x (p i)
  left_inv := by intro x; funext i; simp
  right_inv := by intro x; funext i; simp
  map_add' := by intro x y; rfl
  map_smul' := by intro c x; rfl

@[simp] theorem reindexLinear_apply {M : Type*} [AddCommGroup M] [Module (ZMod 2) M]
    (p : ι ≃ ι) (x : ι → M) (i : ι) : reindexLinear p x i = x (p.symm i) := rfl

theorem graphMap_reindex (adjG adjH : ι → ι → Bool) (p : ι ≃ ι)
    (hp : ∀ i j, adjH i j = adjG (p i) (p j)) (x : Input ι) :
    graphMap adjH x = reindexLinear p.symm (graphMap adjG (reindexLinear p x)) := by
  funext i
  have hc : couplingLinear adjG (p i) (reindexLinear p x) = couplingLinear adjH i x := by
    funext k
    fin_cases k
    · simp [couplingLinear]
    · simp [couplingLinear]
    · change (∑ j, if adjG (p i) j then x (p.symm j) 0 else 0) =
        ∑ j, if adjH i j then x j 0 else 0
      rw [← p.sum_comp (fun j => if adjG (p i) j then x (p.symm j) 0 else 0)]
      simp only [Equiv.symm_apply_apply, ← hp]
  change seed (x i) + cubic (couplingLinear adjH i x) =
    seed (reindexLinear p x (p i)) + cubic (couplingLinear adjG (p i) (reindexLinear p x))
  rw [hc]
  simp

theorem graph_isomorphic_implies_EA (adjG adjH : ι → ι → Bool)
    (h : GraphIsomorphic adjG adjH) : EAEquivalent (graphMap adjG) (graphMap adjH) := by
  rcases h with ⟨p,hp⟩
  refine ⟨reindexLinear p, reindexLinear p.symm, 0, 0, 0, ?_⟩
  intro x
  simpa using graphMap_reindex adjG adjH p hp x

/-- Complete EA classification of the canonical loopless directed graph representatives. -/
theorem canonical_EA_iff_graph_isomorphic (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH) :
    EAEquivalent (graphMap adjG) (graphMap adjH) ↔ GraphIsomorphic adjG adjH := by
  constructor
  · intro h
    exact quadraticEA_implies_graph_isomorphic adjG adjH hG hH h.quadratic
  · exact graph_isomorphic_implies_EA adjG adjH

#print axioms recover_blocks
#print axioms canonical_EA_iff_graph_isomorphic
end VonoExactIndex.GraphFamily
