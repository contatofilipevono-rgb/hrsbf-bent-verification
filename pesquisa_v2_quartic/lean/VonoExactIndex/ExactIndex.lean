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


/-- Certificate-style statement that the ordinary M-index of g is exactly d. -/
def HasMIndex
    {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]
    (g : V → ZMod 2) (d : Nat) : Prop :=
  (∀ S : Submodule (ZMod 2) V,
      IsMSubspace g S → Module.finrank (ZMod 2) S ≤ d) ∧
  (∃ S : Submodule (ZMod 2) V,
      IsMSubspace g S ∧ Module.finrank (ZMod 2) S = d)

/-- Certificate-style statement that the relaxed M-index of g is exactly d. -/
def HasRelaxedMIndex
    {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]
    (g : V → ZMod 2) (d : Nat) : Prop :=
  (∀ S : Submodule (ZMod 2) V,
      IsRelaxedMSubspace g S → Module.finrank (ZMod 2) S ≤ d) ∧
  (∃ S : Submodule (ZMod 2) V,
      IsRelaxedMSubspace g S ∧ Module.finrank (ZMod 2) S = d)

/-- The abstract exact-index certificate states both indices directly. -/
theorem exact_block_has_indices
    (f : ∀ i, W i → ZMod 2)
    (hseed : ∀ i (S : Submodule (ZMod 2) (W i)),
      IsRelaxedMSubspace (f i) S → Module.finrank (ZMod 2) S ≤ 1)
    (e : ∀ i, W i) (hne : ∀ i, e i ≠ 0) :
    HasMIndex (blockSum f) (Fintype.card ι) ∧
    HasRelaxedMIndex (blockSum f) (Fintype.card ι) := by
  rcases exact_block_index_certificate f hseed e hne with ⟨hupper, M, hM, hdim⟩
  constructor
  · constructor
    · intro S hS
      exact hupper S (hS.relaxed)
    · exact ⟨M, hM, hdim⟩
  · constructor
    · exact hupper
    · exact ⟨M, hM.relaxed, hdim⟩

end VonoExactIndex
