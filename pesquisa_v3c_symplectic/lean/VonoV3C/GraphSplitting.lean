import VonoV3C.GraphQuadratic
import VonoV3C.GraphEdgeRecovery

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

/-- Weak connectivity, stated as a directed edge crossing every nontrivial cut. -/
def CutConnected (adj : ι → ι → Bool) : Prop :=
  ∀ I : Finset ι, I.Nonempty → I ≠ Finset.univ →
    ∃ i ∈ I, ∃ j ∉ I, adj i j = true ∨ adj j i = true

def CrossRelaxed (F : Input ι m → Output ι)
    (U T : Submodule Scalar (Input ι m)) : Prop :=
  ∀ i, ∀ a ∈ U, ∀ b ∈ T,
    IsScalarConstant (diff a (diff b (fun x => F x i)))

/-- A necessary condition for a nontrivial EA product decomposition, weakened
to permit constant cross differences. Disjointness is not needed by the obstruction. -/
def HasRelaxedSplit (F : Input ι m → Output ι) : Prop :=
  ∃ U T : Submodule Scalar (Input ι m),
    U ≠ ⊥ ∧ T ≠ ⊥ ∧ U ⊔ T = ⊤ ∧ CrossRelaxed F U T

theorem crossRelaxed_symm (F : Input ι m → Output ι)
    (U T : Submodule Scalar (Input ι m)) (h : CrossRelaxed F U T) :
    CrossRelaxed F T U := by
  intro i a ha b hb
  rw [diff_comm]
  exact h i b hb a ha

theorem cross_relaxed_add_iff (F Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (U T : Submodule Scalar (Input ι m)) :
    CrossRelaxed (addVector F Q) U T ↔ CrossRelaxed F U T := by
  constructor
  · intro h i a ha b hb
    have hs := second_constant_add (fun x => F x i + Q x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)
    have he : (fun x => (F x i + Q x i) + Q x i) = (fun x => F x i) := by
      funext x
      simp [add_assoc]
    rwa [he] at hs
  · intro h i a ha b hb
    exact second_constant_add (fun x => F x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)

theorem fourth_zero_of_constant_second (f : Input ι m → Scalar) (a b : Input ι m)
    (h : IsScalarConstant (diff a (diff b f))) (c d x : Input ι m) :
    fourth f a b c d x = 0 := by
  rcases h with ⟨z, hz⟩
  unfold fourth
  rw [diff_comm b c, diff_comm a c, diff_comm b d, diff_comm a d, hz]
  simp [diff]

theorem cross_pair_block_dependent (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (U T : Submodule Scalar (Input ι m)) (h : CrossRelaxed (graphMap hm adj) U T)
    (a : Input ι m) (ha : a ∈ U) (b : Input ι m) (hb : b ∈ T) (i : ι) :
    a i = 0 ∨ b i = 0 ∨ a i = b i := by
  apply pfaffian_property_A hm
  intro c d
  have hh := fourth_zero_of_constant_second (component hm adj i) a b
    (h i a ha b hb) (Pi.single i c) (Pi.single i d) 0
  rw [fourth_component] at hh
  simpa only [Pi.single_eq_same] using hh

theorem edge_false_of_crossRelaxed (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (U T : Submodule Scalar (Input ι m)) (hc : CrossRelaxed (graphMap hm adj) U T)
    (i j : ι) (hij : i ≠ j)
    (hleft : ∀ v, Pi.single i v ∈ U) (hright : ∀ v, Pi.single j v ∈ T) :
    adj i j = false := by
  have hn : ¬ EdgeDetected hm adj i j := by
    rintro ⟨v, w, z, x, hnon⟩
    apply hnon
    funext k
    rcases hc k (Pi.single i w) (hleft w) (Pi.single j z) (hright z) with ⟨s, hs⟩
    change diff (Pi.single i v) (diff (Pi.single i w)
      (diff (Pi.single j z) (fun y => graphMap hm adj y k))) x = 0
    rw [hs]
    simp [diff]
  have hnt : adj i j ≠ true := fun he => hn ((edge_detected_iff hm adj i j hij).mpr he)
  cases he : adj i j <;> simp_all

/-- Weakly connected canonical graph functions have no nontrivial full-covering
relaxed split, uniformly in m≥2. Reverse arcs are unrestricted. -/
theorem graph_no_relaxed_split (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (hconn : CutConnected adj) : ¬ HasRelaxedSplit (graphMap hm adj) := by
  classical
  rintro ⟨U, T, hU, hT, hs, hc⟩
  have hp (i : ι) : (∀ u ∈ U, u i = 0) ∨ (∀ t ∈ T, t i = 0) :=
    Blocks.projection_partition hm U T hs
      (fun a ha b hb i => cross_pair_block_dependent hm adj U T hc a ha b hb i) i
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
  have hleft (v : Vec m) : Pi.single i v ∈ U :=
    Blocks.single_mem_left U T hs hp i (hTi i hi) v
  have hswap : T ⊔ U = ⊤ := by rw [sup_comm]; exact hs
  have hright (v : Vec m) : Pi.single j v ∈ T :=
    Blocks.single_mem_left T U hswap (fun k => (hp k).symm) j (hUi j hj) v
  rcases hedge with he | he
  · have hn := edge_false_of_crossRelaxed hm adj U T hc i j hij hleft hright
    rw [he] at hn
    exact Bool.noConfusion hn
  · have hn := edge_false_of_crossRelaxed hm adj T U
      (crossRelaxed_symm _ U T hc) j i hij.symm hright hleft
    rw [he] at hn
    exact Bool.noConfusion hn

theorem graph_quadratic_no_relaxed_split (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (hconn : CutConnected adj) (Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) :
    ¬ HasRelaxedSplit (addVector (graphMap hm adj) Q) := by
  rintro ⟨U, T, hU, hT, hs, hc⟩
  exact graph_no_relaxed_split hm adj hconn
    ⟨U, T, hU, hT, hs, (cross_relaxed_add_iff (graphMap hm adj) Q hQ U T).mp hc⟩

end VonoV3C.GraphFamily
