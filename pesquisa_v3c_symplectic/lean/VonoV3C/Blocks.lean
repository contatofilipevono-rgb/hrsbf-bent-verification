import VonoV3C.Contraction
import Mathlib.LinearAlgebra.Pi

namespace VonoV3C.Blocks
open VonoV3C
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}
abbrev Input (ι : Type*) (m : ℕ) := ι → Vec m

def PairDependent (a b : Input ι m) : Prop :=
  ∀ i, a i = 0 ∨ b i = 0 ∨ a i = b i

def basisP (hm : 2 ≤ m) : Vec m := Pi.single
  (⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩ : Fin m) (1,0)
def basisQ (hm : 2 ≤ m) : Vec m := Pi.single
  (⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩ : Fin m) (0,1)

private theorem basisP_ne_zero (hm : 2 ≤ m) : basisP hm ≠ 0 := by
  intro h
  have he := congrArg (fun v : Vec m => (v ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩).1) h
  simp [basisP] at he
private theorem basisQ_ne_zero (hm : 2 ≤ m) : basisQ hm ≠ 0 := by
  intro h
  have he := congrArg (fun v : Vec m => (v ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩).2) h
  simp [basisQ] at he
private theorem basisQ_ne_basisP (hm : 2 ≤ m) : basisQ hm ≠ basisP hm := by
  intro h
  have he := congrArg (fun v : Vec m => (v ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hm⟩).1) h
  simp [basisP, basisQ] at he

private theorem exists_other_seed_vector (hm : 2 ≤ m) (v : Vec m) :
    ∃ w : Vec m, w ≠ 0 ∧ w ≠ v := by
  by_cases h : basisP hm = v
  · exact ⟨basisQ hm, basisQ_ne_zero hm, h ▸ basisQ_ne_basisP hm⟩
  · exact ⟨basisP hm, basisP_ne_zero hm, h⟩

/-- Full input coverage and (A) force each block to belong to only one side. -/
theorem projection_partition (hm : 2 ≤ m) (U T : Submodule (ZMod 2) (Input ι m))
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
    obtain ⟨w, hw0, hwv⟩ := exists_other_seed_vector hm (a i)
    have hm : Pi.single i w ∈ U ⊔ T := by rw [hs]; trivial
    rcases Submodule.mem_sup.mp hm with ⟨u, hu, t, ht, heq⟩
    have hi : u i + t i = w := by
      simpa only [Pi.add_apply, Pi.single_eq_same] using congrFun heq i
    rcases hUline u hu with hu0 | huv <;> rcases hTline t ht with ht0 | htv
    · exact hw0 (by simpa [hu0, ht0] using hi.symm)
    · exact hwv (by simpa [hu0, htv] using hi.symm)
    · exact hwv (by simpa [huv, ht0] using hi.symm)
    · have hvv : a i + a i = 0 := vec_add_self (a i)
      exact hw0 (by simpa [huv, htv, hvv] using hi.symm)

omit [Fintype ι] in
/-- An assigned block is wholly contained in that input summand. -/
theorem single_mem_left (U T : Submodule (ZMod 2) (Input ι m)) (hs : U ⊔ T = ⊤)
    (hp : ∀ j, (∀ u ∈ U, u j = 0) ∨ (∀ t ∈ T, t j = 0))
    (i : ι) (hTi : ∀ t ∈ T, t i = 0) (v : Vec m) : Pi.single i v ∈ U := by
  classical
  have hm : Pi.single i v ∈ U ⊔ T := by rw [hs]; trivial
  rcases Submodule.mem_sup.mp hm with ⟨u, hu, t, ht, heq⟩
  have hueq : u = Pi.single i v := by
    funext j
    have hj := congrFun heq j
    change u j + t j = (Pi.single i v : Input ι m) j at hj
    by_cases hji : j = i
    · subst j
      simpa only [hTi t ht, add_zero] using hj
    · have hz : (Pi.single i v : Input ι m) j = 0 := by simp [Pi.single_apply, hji]
      rw [hz] at hj
      rcases hp j with hU | hT
      · simpa only [hz] using hU u hu
      · rw [hT t ht, add_zero] at hj
        exact hj.trans hz.symm
  exact hueq ▸ hu

def blockSpace (i : ι) : Submodule (ZMod 2) (Input ι m) where
  carrier := {x | ∀ j, j ≠ i → x j = 0}
  zero_mem' := by simp
  add_mem' := by intro a b ha hb j hj; simp [Pi.add_apply, ha j hj, hb j hj]
  smul_mem' := by intro c a ha j hj; simp [Pi.smul_apply, ha j hj]

omit [Fintype ι] in
private theorem single_eq_of_support (i : ι) (x : Input ι m)
    (h : ∀ j, j ≠ i → x j = 0) : x = Pi.single i (x i) := by
  funext j
  by_cases hj : j = i
  · subst j; simp
  · simp [Pi.single_apply, hj, h j hj]

/-- Preserving the fourth-difference zero-pair relation recovers the full block permutation. -/
theorem recover_blocks (hm : 2 ≤ m) (A : Input ι m ≃ₗ[ZMod 2] Input ι m)
    (hA : ∀ a b, PairDependent a b ↔ PairDependent (A a) (A b)) :
    ∃ p : ι ≃ ι, ∀ i, ∃ e : Vec m ≃ₗ[ZMod 2] Vec m,
      ∀ v, A (Pi.single i v) = Pi.single (p i) (e v) := by
  classical
  have hassign (i : ι) : ∃ j : ι, ∀ v : Vec m,
      A (Pi.single i v) = Pi.single j (A (Pi.single i v) j) := by
    have hunit : (Pi.single i (basisP hm) : Input ι m) ≠ 0 := by
      intro he
      apply basisP_ne_zero hm
      simpa using congrFun he i
    have hnon : A (Pi.single i (basisP hm)) ≠ 0 := by
      intro he
      apply hunit
      apply A.injective
      simpa using he
    have hex : ∃ j, A (Pi.single i (basisP hm)) j ≠ 0 := by
      by_contra hn
      apply hnon
      funext j
      by_contra hj
      exact hn ⟨j,hj⟩
    obtain ⟨j,hj⟩ := hex
    let U := (blockSpace j).comap A.toLinearMap
    let T := LinearMap.ker ((LinearMap.proj j).comp A.toLinearMap)
    have memU (x : Input ι m) : x ∈ U ↔ ∀ k, k ≠ j → A x k = 0 := Iff.rfl
    have memT (x : Input ι m) : x ∈ T ↔ A x j = 0 := Iff.rfl
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
    have hpart (k : ι) := projection_partition hm U T hs hp k
    have hTi : ∀ b ∈ T, b i = 0 := by
      rcases hpart i with hU | hT
      · have hm := single_mem_left T U (by rw [sup_comm]; exact hs)
          (fun k => (hpart k).symm) i hU (basisP hm)
        exact False.elim (hj ((memT _).mp hm))
      · exact hT
    refine ⟨j, ?_⟩
    intro v
    have hm := single_mem_left U T hs hpart i hTi v
    exact single_eq_of_support j _ ((memU _).mp hm)
  choose f hf using hassign
  let e (i : ι) : Vec m →ₗ[ZMod 2] Vec m :=
    (LinearMap.proj (f i)).comp (A.toLinearMap.comp (LinearMap.single (ZMod 2) (fun _ : ι => Vec m) i))
  have he (i : ι) (v : Vec m) : e i v = A (Pi.single i v) (f i) := rfl
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
    obtain ⟨w,hw⟩ := hsurj j (e i (basisP hm))
    have hh : A (Pi.single i (basisP hm)) = A (Pi.single j w) := by
      rw [hf i, hf j]
      change (Pi.single (f i) (e i (basisP hm)) : Input ι m) = Pi.single (f j) (e j w)
      rw [hij, hw]
    have hs := congrFun (A.injective hh) i
    have hz : basisP hm = 0 := by simpa [Pi.single_apply, hne] using hs
    exact basisP_ne_zero hm hz
  let p : ι ≃ ι := Equiv.ofBijective f ⟨hfinj, Finite.surjective_of_injective hfinj⟩
  refine ⟨p, ?_⟩
  intro i
  refine ⟨LinearEquiv.ofBijective (e i) ⟨hinj i, hsurj i⟩, ?_⟩
  intro v
  exact hf i v

/-- The zero-pair relation of the direct sum of quartic polarizations. -/
def QuarticPairZero (a b : Input ι m) : Prop :=
  ∀ c d : Input ι m, ∀ i, pfaffian (a i) (b i) (c i) (d i) = 0

omit [Fintype ι] in
theorem quartic_pair_zero_iff (hm : 2 ≤ m) (a b : Input ι m) :
    QuarticPairZero a b ↔ PairDependent a b := by
  constructor
  · intro h i
    apply pfaffian_property_A hm (a i) (b i)
    intro c d
    have hh := h (Pi.single i c) (Pi.single i d) i
    simpa only [Pi.single_eq_same] using hh
  · intro h c d i
    have hh := (fourth_pair_zero_iff hm (a i) (b i)).mpr (h i)
    simpa only [seed_fourth] using hh (c i) (d i)

/-- Intrinsic recovery from preservation of the quartic zero-pair relation.
This is a linear-algebra theorem; transport by graph EA maps is not asserted here. -/
theorem recover_blocks_from_quartic (hm : 2 ≤ m)
    (A : Input ι m ≃ₗ[ZMod 2] Input ι m)
    (hA : ∀ a b, QuarticPairZero a b ↔ QuarticPairZero (A a) (A b)) :
    ∃ p : ι ≃ ι, ∀ i, ∃ e : Vec m ≃ₗ[ZMod 2] Vec m,
      ∀ v, A (Pi.single i v) = Pi.single (p i) (e v) := by
  apply recover_blocks hm A
  intro a b
  simpa only [quartic_pair_zero_iff hm] using hA a b

end VonoV3C.Blocks
