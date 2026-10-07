import VonoExactIndex.BlockSum

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

def IsConstant (g : V → ZMod 2) : Prop :=
  ∃ c : ZMod 2, g = fun _ => c

/-- A subspace on which every second finite difference vanishes. -/
def IsMSubspace (f : V → ZMod 2) (U : Submodule (ZMod 2) V) : Prop :=
  ∀ a ∈ U, ∀ b ∈ U, diff a (diff b f) = 0

/-- A subspace on which every second finite difference is constant. -/
def IsRelaxedMSubspace (f : V → ZMod 2) (U : Submodule (ZMod 2) V) : Prop :=
  ∀ a ∈ U, ∀ b ∈ U, IsConstant (diff a (diff b f))

theorem IsMSubspace.relaxed {f : V → ZMod 2} {U : Submodule (ZMod 2) V}
    (h : IsMSubspace f U) : IsRelaxedMSubspace f U := by
  intro a ha b hb
  refine ⟨0, ?_⟩
  simpa using h a ha b hb

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]

/--
A sum of functions on disjoint coordinates can be constant only if every
coordinate function is constant.
-/
theorem coordinate_constant_of_sum_constant
    (g : ∀ i, W i → ZMod 2)
    (h : IsConstant (fun x : BlockVec ι W => ∑ i, g i (x i)))
    (i : ι) :
    IsConstant (g i) := by
  rcases h with ⟨c, hc⟩
  let x0 : BlockVec ι W := fun _ => 0
  refine ⟨g i 0, ?_⟩
  funext y
  let xy : BlockVec ι W := Function.update x0 i y
  have hy : (∑ j, g j (xy j)) = c := by
    simpa using congrFun hc xy
  have h0 : (∑ j, g j (x0 j)) = c := by
    simpa using congrFun hc x0
  have hdiff : (∑ j, g j (xy j)) = (∑ j, g j (x0 j)) := hy.trans h0.symm
  have hsplit_y :
      (∑ j, g j (xy j)) = g i y + ∑ j ∈ Finset.univ.erase i, g j 0 := by
    rw [Finset.sum_eq_add_sum_diff_singleton (s := Finset.univ) (by simp : i ∈ Finset.univ)]
    · simp [xy, x0]
    · simp
  have hsplit_0 :
      (∑ j, g j (x0 j)) = g i 0 + ∑ j ∈ Finset.univ.erase i, g j 0 := by
    rw [Finset.sum_eq_add_sum_diff_singleton (s := Finset.univ) (by simp : i ∈ Finset.univ)]
    · simp [x0]
    · simp
  rw [hsplit_y, hsplit_0] at hdiff
  exact add_right_cancel hdiff

/--
If U is relaxed for a sum on disjoint blocks, every block projection of U is
relaxed for the corresponding block function.
-/
theorem relaxed_projection
    (f : ∀ i, W i → ZMod 2)
    (U : Submodule (ZMod 2) (BlockVec ι W))
    (hU : IsRelaxedMSubspace (blockSum f) U)
    (i : ι) :
    IsRelaxedMSubspace (f i) (U.map (LinearMap.proj i)) := by
  intro ai hai bi hbi
  rcases hai with ⟨a, haU, rfl⟩
  rcases hbi with ⟨b, hbU, rfl⟩
  have hconst := hU a haU b hbU
  rcases hconst with ⟨c, hc⟩
  have hsum : IsConstant
      (fun x : BlockVec ι W =>
        ∑ j, diff (a j) (diff (b j) (f j)) (x j)) := by
    refine ⟨c, ?_⟩
    funext x
    have hx := congrFun hc x
    rw [secondDiff_blockSum] at hx
    exact hx
  exact coordinate_constant_of_sum_constant
    (g := fun j => diff (a j) (diff (b j) (f j))) hsum i

end VonoExactIndex
