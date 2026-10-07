import VonoExactIndex.LowerBound

namespace VonoExactIndex

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]
variable [∀ i, FiniteDimensional (ZMod 2) (W i)]

/--
Abstract exact-index certificate for a disjoint block sum:
every relaxed M-subspace has dimension at most the number of blocks,
and an ordinary M-subspace of exactly that dimension exists.
-/
theorem exact_block_index_certificate
    (f : ∀ i, W i → ZMod 2)
    (hseed : ∀ i (S : Submodule (ZMod 2) (W i)),
      IsRelaxedMSubspace (f i) S → Module.finrank (ZMod 2) S ≤ 1)
    (e : ∀ i, W i)
    (hne : ∀ i, e i ≠ 0) :
    (∀ U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W)),
        IsRelaxedMSubspace (blockSum f) U →
        Module.finrank (ZMod 2) U ≤ Fintype.card ι)
    ∧
    (∃ M : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W)),
        IsMSubspace (blockSum f) M ∧
        Module.finrank (ZMod 2) M = Fintype.card ι) := by
  constructor
  · intro U hU
    exact relaxed_block_finrank_le_card f U hU hseed
  · refine ⟨LinearMap.range (selectedDirectionMap e), ?_, ?_⟩
    · exact selectedDirectionRange_isM f e
    · exact selectedDirectionRange_finrank e hne

/-- Uniform-seed specialization for a finite direct sum of identical blocks. -/
theorem exact_repeated_block_index_certificate
    {W0 : Type*} [AddCommGroup W0] [Module (ZMod 2) W0]
    [FiniteDimensional (ZMod 2) W0]
    (f : W0 → ZMod 2)
    (hseed : ∀ S : Submodule (ZMod 2) W0,
      IsRelaxedMSubspace f S → Module.finrank (ZMod 2) S ≤ 1)
    (e0 : W0) (he0 : e0 ≠ 0) :
    (∀ U : Submodule (ZMod 2) (ι → W0),
        IsRelaxedMSubspace (blockSum (fun _ : ι => f)) U →
        Module.finrank (ZMod 2) U ≤ Fintype.card ι)
    ∧
    (∃ M : Submodule (ZMod 2) (ι → W0),
        IsMSubspace (blockSum (fun _ : ι => f)) M ∧
        Module.finrank (ZMod 2) M = Fintype.card ι) := by
  exact exact_block_index_certificate
    (f := fun _ : ι => f)
    (hseed := fun _ S hS => hseed S hS)
    (e := fun _ : ι => e0)
    (hne := fun _ => he0)

end VonoExactIndex
