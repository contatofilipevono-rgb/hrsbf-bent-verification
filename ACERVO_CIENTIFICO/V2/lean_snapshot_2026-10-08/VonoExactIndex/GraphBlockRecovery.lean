import VonoExactIndex.GraphEATransport

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

def blockSpace (i : ι) : Submodule (ZMod 2) (Input ι) where
  carrier := {x | ∀ j, j ≠ i → x j = 0}
  zero_mem' := by simp
  add_mem' := by intro a b ha hb j hj; simp [Pi.add_apply, ha j hj, hb j hj]
  smul_mem' := by intro c a ha j hj; simp [Pi.smul_apply, ha j hj]

private theorem single_eq_of_support (i : ι) (x : Input ι)
    (h : ∀ j, j ≠ i → x j = 0) : x = Pi.single i (x i) := by
  funext j
  by_cases hj : j = i
  · subst j; simp
  · simp [Pi.single_apply, hj, h j hj]

/-- Preserving the fourth-difference zero-pair relation recovers the full block permutation. -/
theorem recover_blocks (A : Input ι ≃ₗ[ZMod 2] Input ι)
    (hA : ∀ a b, PairDependent a b ↔ PairDependent (A a) (A b)) :
    ∃ p : ι ≃ ι, ∀ i, ∃ e : SeedVec ≃ₗ[ZMod 2] SeedVec,
      ∀ v, A (Pi.single i v) = Pi.single (p i) (e v) := by
  classical
  have hassign (i : ι) : ∃ j : ι, ∀ v : SeedVec,
      A (Pi.single i v) = Pi.single j (A (Pi.single i v) j) := by
    have hunit : (blockUnit i 0 : Input ι) ≠ 0 := by
      intro he
      have hh := congrFun (congrFun he i) 0
      simpa [blockUnit, unitSeed] using hh
    have hnon : A (blockUnit i 0) ≠ 0 := by
      intro he
      apply hunit
      apply A.injective
      simpa using he
    have hex : ∃ j, A (blockUnit i 0) j ≠ 0 := by
      by_contra hn
      apply hnon
      funext j
      by_contra hj
      exact hn ⟨j,hj⟩
    obtain ⟨j,hj⟩ := hex
    let U := (blockSpace j).comap A.toLinearMap
    let T := LinearMap.ker ((LinearMap.proj j).comp A.toLinearMap)
    have memU (x : Input ι) : x ∈ U ↔ ∀ k, k ≠ j → A x k = 0 := Iff.rfl
    have memT (x : Input ι) : x ∈ T ↔ A x j = 0 := Iff.rfl
    have hs : U ⊔ T = ⊤ := by
      apply top_unique
      intro x hx
      apply Submodule.mem_sup.mpr
      refine ⟨A.symm (Pi.single j (A x j)), ?_, A.symm (A x - Pi.single j (A x j)), ?_, ?_⟩
      · apply (memU _).mpr
        intro k hk
        simp [Pi.single_apply, hk]
      · apply (memT _).mpr
        simp
      · rw [← A.symm.map_add]
        have he : Pi.single j (A x j) + (A x - Pi.single j (A x j)) = A x := by abel
        rw [he, A.symm_apply_apply]
    have hp : ∀ a ∈ U, ∀ b ∈ T, ∀ k, a k = 0 ∨ b k = 0 ∨ a k = b k := by
      intro a ha b hb
      apply (hA a b).mpr
      intro k
      by_cases hk : k = j
      · subst k; exact Or.inr (Or.inl ((memT b).mp hb))
      · exact Or.inl ((memU a).mp ha k hk)
    have hpart (k : ι) := projection_partition U T hs hp k
    have hTi : ∀ b ∈ T, b i = 0 := by
      rcases hpart i with hU | hT
      · have hm := single_mem_left T U (by rw [sup_comm]; exact hs)
          (fun k => (hpart k).symm) i hU (unitSeed 0)
        exact False.elim (hj ((memT _).mp hm))
      · exact hT
    refine ⟨j, ?_⟩
    intro v
    have hm := single_mem_left U T hs hpart i hTi v
    exact single_eq_of_support j _ ((memU _).mp hm)
  choose f hf using hassign
  let e (i : ι) : SeedVec →ₗ[ZMod 2] SeedVec :=
    (LinearMap.proj (f i)).comp (A.toLinearMap.comp (LinearMap.single (ZMod 2) (fun _ : ι => SeedVec) i))
  have he (i : ι) (v : SeedVec) : e i v = A (Pi.single i v) (f i) := rfl
  have hinj (i : ι) : Function.Injective (e i) := by
    intro v w hvw
    have hh : A (Pi.single i v) = A (Pi.single i w) := by
      rw [hf i v, hf i w]
      exact congrArg (Pi.single (f i)) hvw
    have hs := A.injective hh
    simpa using congrFun hs i
  have hsurj (i : ι) : Function.Surjective (e i) := Finite.surjective_of_injective (hinj i)
  have hfinj : Function.Injective f := by
    intro i j hij
    by_contra hne
    obtain ⟨w,hw⟩ := hsurj j (e i (unitSeed 0))
    have hh : A (Pi.single i (unitSeed 0)) = A (Pi.single j w) := by
      rw [hf i, hf j]
      change (Pi.single (f i) (e i (unitSeed 0)) : Input ι) = Pi.single (f j) (e j w)
      rw [hij, hw]
    have hs := congrFun (A.injective hh) i
    have hz : unitSeed 0 = 0 := by simpa [Pi.single_apply, hne] using hs
    have hh0 := congrFun hz 0
    simpa [unitSeed] using hh0
  let p : ι ≃ ι := Equiv.ofBijective f ⟨hfinj, Finite.surjective_of_injective hfinj⟩
  refine ⟨p, ?_⟩
  intro i
  refine ⟨LinearEquiv.ofBijective (e i) ⟨hinj i, hsurj i⟩, ?_⟩
  intro v
  exact hf i v

end VonoExactIndex.GraphFamily
