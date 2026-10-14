import VonoExactIndex.GraphFunction

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Every nontrivial vertex cut has a directed edge crossing in one direction. -/
def CutConnected (adj : ι → ι → Bool) : Prop :=
  ∀ I : Finset ι, I.Nonempty → I ≠ Finset.univ →
    ∃ i ∈ I, ∃ j ∉ I, adj i j = true ∨ adj j i = true

/-- Necessary condition for an EA product split, allowing constant cross differences. -/
def CrossRelaxed (F : Input ι → ι → ZMod 2)
    (U T : Submodule (ZMod 2) (Input ι)) : Prop :=
  ∀ i, ∀ a ∈ U, ∀ b ∈ T, IsConstant (diff a (diff b (fun x => F x i)))

def HasRelaxedSplit (F : Input ι → ι → ZMod 2) : Prop :=
  ∃ U T : Submodule (ZMod 2) (Input ι),
    U ≠ ⊥ ∧ T ≠ ⊥ ∧ U ⊔ T = ⊤ ∧ CrossRelaxed F U T

theorem cross_pair_block_dependent (adj : ι → ι → Bool)
    (U T : Submodule (ZMod 2) (Input ι)) (h : CrossRelaxed (graphMap adj) U T)
    (a : Input ι) (ha : a ∈ U) (b : Input ι) (hb : b ∈ T) (i : ι) :
    a i = 0 ∨ b i = 0 ∨ a i = b i := by
  apply SeedPropertyABridge.seed_property_A
  intro c d
  have hh := fourth_zero_of_second_constant (component adj i) a b
    (h i a ha b hb) (Pi.single i c) (Pi.single i d) 0
  rw [fourth_component] at hh
  simpa only [Pi.single_eq_same, Pi.zero_apply] using hh

private theorem exists_other_seed_vector : ∀ v : SeedVec,
    ∃ w : SeedVec, w ≠ 0 ∧ w ≠ v := by native_decide

/-- Full input coverage and (A) force each block to belong to only one side. -/
theorem projection_partition (U T : Submodule (ZMod 2) (Input ι))
    (hs : U ⊔ T = ⊤)
    (hp : ∀ a ∈ U, ∀ b ∈ T, ∀ i, a i = 0 ∨ b i = 0 ∨ a i = b i)
    (i : ι) :
    (∀ a ∈ U, a i = 0) ∨ (∀ b ∈ T, b i = 0) := by
  classical
  by_cases hz : ∀ a ∈ U, a i = 0
  · exact Or.inl hz
  · right
    intro b hb
    by_contra hbi
    obtain ⟨a, hai⟩ := not_forall.mp hz
    have haU : a ∈ U := by
      by_contra h
      exact hai (fun ha => False.elim (h ha))
    have hai0 : a i ≠ 0 := by
      intro h
      exact hai (fun _ => h)
    have hab : a i = b i := by
      rcases hp a haU b hb i with h | h | h
      · exact False.elim (hai0 h)
      · exact False.elim (hbi h)
      · exact h
    have hUline : ∀ u ∈ U, u i = 0 ∨ u i = a i := by
      intro u hu
      rcases hp u hu b hb i with h | h | h
      · exact Or.inl h
      · exact False.elim (hbi h)
      · exact Or.inr (h.trans hab.symm)
    have hTline : ∀ t ∈ T, t i = 0 ∨ t i = a i := by
      intro t ht
      rcases hp a haU t ht i with h | h | h
      · exact False.elim (hai0 h)
      · exact Or.inl h
      · exact Or.inr h.symm
    obtain ⟨w, hw0, hwv⟩ := exists_other_seed_vector (a i)
    have hm : Pi.single i w ∈ U ⊔ T := by rw [hs]; trivial
    rcases Submodule.mem_sup.mp hm with ⟨u, hu, t, ht, heq⟩
    have hi : u i + t i = w := by
      simpa only [Pi.add_apply, Pi.single_eq_same] using congrFun heq i
    rcases hUline u hu with hu0 | huv <;> rcases hTline t ht with ht0 | htv
    · exact hw0 (by simpa [hu0, ht0] using hi.symm)
    · exact hwv (by simpa [hu0, htv] using hi.symm)
    · exact hwv (by simpa [huv, ht0] using hi.symm)
    · have hvv : a i + a i = 0 := by
        funext k
        exact add_self_zmod2 (a i k)
      exact hw0 (by simpa [huv, htv, hvv] using hi.symm)

/-- An assigned block is wholly contained in that input summand. -/
theorem single_mem_left (U T : Submodule (ZMod 2) (Input ι)) (hs : U ⊔ T = ⊤)
    (hp : ∀ j, (∀ u ∈ U, u j = 0) ∨ (∀ t ∈ T, t j = 0))
    (i : ι) (hTi : ∀ t ∈ T, t i = 0) (v : SeedVec) : Pi.single i v ∈ U := by
  classical
  have hm : Pi.single i v ∈ U ⊔ T := by rw [hs]; trivial
  rcases Submodule.mem_sup.mp hm with ⟨u, hu, t, ht, heq⟩
  have hueq : u = Pi.single i v := by
    funext j
    have hj := congrFun heq j
    change u j + t j = (Pi.single i v : Input ι) j at hj
    by_cases hji : j = i
    · subst j
      simpa only [hTi t ht, add_zero] using hj
    · have hz : (Pi.single i v : Input ι) j = 0 := by simp [Pi.single_apply, hji]
      rw [hz] at hj
      rcases hp j with hU | hT
      · simpa only [hz] using hU u hu
      · rw [hT t ht, add_zero] at hj
        exact hj.trans hz.symm
  exact hueq ▸ hu

def unitSeed (k : Fin 8) : SeedVec := fun l => if l = k then 1 else 0
def blockUnit (i : ι) (k : Fin 8) : Input ι := Pi.single i (unitSeed k)

private theorem neighbor_sum_unit (adj : ι → ι → Bool) (i j : ι) (p : Fin 8) :
    (∑ k, if adj i k then blockUnit j p k 0 else 0) =
      if adj i j then unitSeed p 0 else 0 := by
  classical
  rw [Finset.sum_eq_single j]
  · simp [blockUnit]
  · intro k hk hkj
    simp [blockUnit, Pi.single_apply, hkj]
  · simp

theorem coupling_unit_self0 (adj : ι → ι → Bool) (i : ι) :
    couplingLinear adj i (blockUnit i 0) = ![1, 0, if adj i i then 1 else 0] := by
  funext k
  fin_cases k
  · simp [couplingLinear, blockUnit, unitSeed]
  · simp [couplingLinear, blockUnit, unitSeed]
  · change (∑ k, if adj i k then blockUnit i 0 k 0 else 0) = _
    simpa [unitSeed] using neighbor_sum_unit adj i i 0

theorem coupling_unit_self1 (adj : ι → ι → Bool) (i : ι) :
    couplingLinear adj i (blockUnit i 1) = ![0, 1, 0] := by
  funext k
  fin_cases k
  · simp [couplingLinear, blockUnit, unitSeed]
  · simp [couplingLinear, blockUnit, unitSeed]
  · change (∑ k, if adj i k then blockUnit i 1 k 0 else 0) = _
    simpa [unitSeed] using neighbor_sum_unit adj i i 1

theorem coupling_unit_other0 (adj : ι → ι → Bool) (i j : ι) (hij : i ≠ j) :
    couplingLinear adj i (blockUnit j 0) = ![0, 0, if adj i j then 1 else 0] := by
  funext k
  fin_cases k
  · simp [couplingLinear, blockUnit, unitSeed, Pi.single_apply, hij, Ne.symm hij]
  · simp [couplingLinear, blockUnit, unitSeed, Pi.single_apply, hij, Ne.symm hij]
  · change (∑ k, if adj i k then blockUnit j 0 k 0 else 0) = _
    simpa [unitSeed] using neighbor_sum_unit adj i j 0

private theorem cubic_mixed_third : ∀ s t : ZMod 2,
    diff ![0, 1, 0] (diff ![1, 0, s] (diff ![0, 0, t] cubic)) 0 = t := by
  native_decide

theorem thirdDiff_comp_linear {V W : Type*}
    [AddCommGroup V] [Module (ZMod 2) V]
    [AddCommGroup W] [Module (ZMod 2) W]
    (e : V →ₗ[ZMod 2] W) (a b c : V) (f : W → ZMod 2) :
    diff a (diff b (diff c (f ∘ e))) =
      (diff (e a) (diff (e b) (diff (e c) f))) ∘ e := by
  rw [secondDiff_comp_linear e b c f]
  exact diff_comp_linear e a (diff (e b) (diff (e c) f))

/-- A directed edge is detected by a mixed third derivative on its two blocks. -/
theorem mixed_third_edge (adj : ι → ι → Bool) (i j : ι) (hij : i ≠ j) :
    diff (blockUnit i 1) (diff (blockUnit i 0) (diff (blockUnit j 0) (component adj i))) 0 =
      if adj i j then 1 else 0 := by
  change diff (blockUnit i 1) (diff (blockUnit i 0) (diff (blockUnit j 0)
    (fun y => (seed ∘ (LinearMap.proj i : Input ι →ₗ[ZMod 2] SeedVec)) y +
      (cubic ∘ couplingLinear adj i) y))) 0 = _
  simp only [diff_add]
  rw [thirdDiff_comp_linear, thirdDiff_comp_linear,
    coupling_unit_self1, coupling_unit_self0, coupling_unit_other0 adj i j hij]
  have hz : (LinearMap.proj i : Input ι →ₗ[ZMod 2] SeedVec) (blockUnit j 0) = 0 := by
    simp [blockUnit, Pi.single_apply, hij, Ne.symm hij]
  rw [hz, diff_zero]
  simp only [Function.comp_apply, map_zero, cubic_mixed_third]
  simp [diff]

end VonoExactIndex.GraphFamily
