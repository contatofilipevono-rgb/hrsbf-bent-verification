import VonoExactIndex.GraphSplitting

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Connected graph couplings have no nontrivial full-covering relaxed input split. -/
theorem graph_no_relaxed_split (adj : ι → ι → Bool) (hconn : CutConnected adj) :
    ¬ HasRelaxedSplit (graphMap adj) := by
  classical
  rintro ⟨U, T, hU, hT, hs, hc⟩
  have hp : ∀ i, (∀ u ∈ U, u i = 0) ∨ (∀ t ∈ T, t i = 0) := by
    intro i
    exact projection_partition U T hs
      (fun a ha b hb i => cross_pair_block_dependent adj U T hc a ha b hb i) i
  let I : Finset ι := Finset.univ.filter (fun i => ¬ ∀ u ∈ U, u i = 0)
  have memI (i : ι) : i ∈ I ↔ ¬ ∀ u ∈ U, u i = 0 := by simp [I]
  have hTi (i : ι) (hi : i ∈ I) : ∀ t ∈ T, t i = 0 :=
    (hp i).resolve_left ((memI i).mp hi)
  have hUi (i : ι) (hi : i ∉ I) : ∀ u ∈ U, u i = 0 := by
    by_contra h
    exact hi ((memI i).mpr h)
  have hnon : I.Nonempty := by
    by_contra he
    apply hU
    apply (Submodule.eq_bot_iff U).mpr
    intro u hu
    funext i
    apply hUi i _ u hu
    intro hi
    exact he ⟨i, hi⟩
  have hproper : I ≠ Finset.univ := by
    intro he
    apply hT
    apply (Submodule.eq_bot_iff T).mpr
    intro t ht
    funext i
    exact hTi i (by rw [he]; simp) t ht
  obtain ⟨i, hi, j, hj, hedge⟩ := hconn I hnon hproper
  have hij : i ≠ j := by
    intro he
    subst j
    exact hj hi
  have hleft : blockUnit i 0 ∈ U :=
    single_mem_left U T hs hp i (hTi i hi) (unitSeed 0)
  have hswap : T ⊔ U = ⊤ := by rw [sup_comm]; exact hs
  have hright : blockUnit j 0 ∈ T :=
    single_mem_left T U hswap (fun k => (hp k).symm) j (hUi j hj) (unitSeed 0)
  rcases hedge with he | he
  · rcases hc i (blockUnit i 0) hleft (blockUnit j 0) hright with ⟨k, hk⟩
    change diff (blockUnit i 0) (diff (blockUnit j 0) (component adj i)) = fun _ => k at hk
    have hm := mixed_third_edge adj i j hij
    rw [hk] at hm
    have hbad : (1 : ZMod 2) = 0 := by simpa [diff, he] using hm.symm
    exact one_ne_zero hbad
  · rcases hc j (blockUnit i 0) hleft (blockUnit j 0) hright with ⟨k, hk⟩
    have hk' : diff (blockUnit j 0) (diff (blockUnit i 0) (component adj j)) =
        fun _ => k := by
      rw [diff_commute]
      exact hk
    have hm := mixed_third_edge adj j i (Ne.symm hij)
    rw [hk'] at hm
    have hbad : (1 : ZMod 2) = 0 := by simpa [diff, he] using hm.symm
    exact one_ne_zero hbad

#print axioms graph_no_relaxed_split
end VonoExactIndex.GraphFamily
