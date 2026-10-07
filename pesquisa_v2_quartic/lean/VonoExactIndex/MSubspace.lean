import VonoExactIndex.BlockSum

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

/-- A subspace on which every second finite difference vanishes. -/
def IsMSubspace (f : V → ZMod 2) (U : Submodule (ZMod 2) V) : Prop :=
  ∀ a ∈ U, ∀ b ∈ U, D[a] (D[b] f) = 0

/-- A subspace on which every second finite difference is constant. -/
def IsRelaxedMSubspace (f : V → ZMod 2) (U : Submodule (ZMod 2) V) : Prop :=
  ∀ a ∈ U, ∀ b ∈ U, ∃ c : ZMod 2, D[a] (D[b] f) = fun _ => c

theorem IsMSubspace.relaxed {f : V → ZMod 2} {U : Submodule (ZMod 2) V}
    (h : IsMSubspace f U) : IsRelaxedMSubspace f U := by
  intro a ha b hb
  refine ⟨0, ?_⟩
  simpa using h a ha b hb

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]

/--
If U is relaxed for a sum on disjoint blocks, then every block projection of U
is relaxed for the corresponding seed function.
-/
theorem relaxed_projection
    (f : ∀ i, W i → ZMod 2)
    (U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W)))
    (hU : IsRelaxedMSubspace (blockSum f) U)
    (i : ι) :
    IsRelaxedMSubspace (f i) (U.map (LinearMap.proj i)) := by
  intro ai hai bi hbi
  rcases hai with ⟨a, haU, rfl⟩
  rcases hbi with ⟨b, hbU, rfl⟩
  rcases hU a haU b hbU with ⟨c, hc⟩
  -- The global constant second derivative decomposes into independent blocks.
  -- Varying only block i shows the i-th block derivative is constant.
  let x0 : BlockVec (ι := ι) (W := W) := fun _ => 0
  let embedAt (y : W i) : BlockVec (ι := ι) (W := W) :=
    Function.update x0 i y
  refine ⟨D[a i] (D[b i] (f i)) 0, ?_⟩
  funext y
  have hglobal_y := congrFun hc (embedAt y)
  have hglobal_0 := congrFun hc x0
  have hdecomp_y := secondDiff_blockSum f a b (embedAt y)
  have hdecomp_0 := secondDiff_blockSum f a b x0
  -- Subtracting the two constant global values cancels every block except i.
  -- Over ZMod 2 subtraction equals addition.
  sorry

end VonoExactIndex
