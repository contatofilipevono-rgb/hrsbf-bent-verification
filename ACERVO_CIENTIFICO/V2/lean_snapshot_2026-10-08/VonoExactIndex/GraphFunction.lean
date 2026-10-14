import VonoExactIndex.SeedPropertyABridge
import VonoExactIndex.LinearTransport

namespace VonoExactIndex.GraphFamily

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
abbrev Input (ι : Type*) := ι → SeedVec
abbrev CubicVec := Fin 3 → ZMod 2

def cubic (x : CubicVec) : ZMod 2 := x 0 * x 1 * x 2

theorem cubic_fourth_zero : ∀ a b c d x : CubicVec,
    diff a (diff b (diff c (diff d cubic))) x = 0 := by
  native_decide

/-- The two local coordinates and the sum of outgoing-neighbor coordinates. -/
def couplingLinear (adj : ι → ι → Bool) (i : ι) :
    Input ι →ₗ[ZMod 2] CubicVec where
  toFun x k := if k = 0 then x i 0 else if k = 1 then x i 1 else
    ∑ j, if adj i j then x j 0 else 0
  map_add' := by
    intro x y
    funext k
    by_cases h0 : k = 0 <;> by_cases h1 : k = 1 <;>
      simp [h0, h1, Pi.add_apply, Finset.sum_add_distrib, ite_add]
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro j hj
    split_ifs <;> simp
  map_smul' := by
    intro t x
    funext k
    by_cases h0 : k = 0 <;> by_cases h1 : k = 1 <;>
      simp [h0, h1, Pi.smul_apply, smul_eq_mul, Finset.mul_sum, mul_ite]

def component (adj : ι → ι → Bool) (i : ι) (x : Input ι) : ZMod 2 :=
  seed (x i) + cubic (couplingLinear adj i x)

def graphMap (adj : ι → ι → Bool) (x : Input ι) : ι → ZMod 2 :=
  fun i => component adj i x

/-- Coordinatewise constancy is constancy of the vector-valued second difference. -/
def IsVectorRelaxed (F : Input ι → ι → ZMod 2)
    (U : Submodule (ZMod 2) (Input ι)) : Prop :=
  ∀ i, IsRelaxedMSubspace (fun x => F x i) U

def HasVectorRelaxedIndex (F : Input ι → ι → ZMod 2) (r : Nat) : Prop :=
  (∀ U : Submodule (ZMod 2) (Input ι), IsVectorRelaxed F U →
    Module.finrank (ZMod 2) U ≤ r) ∧
  ∃ U : Submodule (ZMod 2) (Input ι), IsVectorRelaxed F U ∧
    Module.finrank (ZMod 2) U = r

theorem diff_commute {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]
    (a b : V) (f : V → ZMod 2) : diff a (diff b f) = diff b (diff a f) := by
  funext x
  simp only [diff]
  have hx : x + a + b = x + b + a := by abel
  rw [hx]
  abel

theorem fourthDiff_comp_linear {V W : Type*}
    [AddCommGroup V] [Module (ZMod 2) V]
    [AddCommGroup W] [Module (ZMod 2) W]
    (e : V →ₗ[ZMod 2] W) (a b c d : V) (f : W → ZMod 2) :
    diff a (diff b (diff c (diff d (f ∘ e)))) =
      (diff (e a) (diff (e b) (diff (e c) (diff (e d) f)))) ∘ e := by
  rw [secondDiff_comp_linear e c d f]
  exact secondDiff_comp_linear e a b (diff (e c) (diff (e d) f))

/-- The graph coupling disappears in fourth differences, leaving each seed block. -/
theorem fourth_component (adj : ι → ι → Bool) (i : ι)
    (a b c d x : Input ι) :
    diff a (diff b (diff c (diff d (component adj i)))) x =
      diff (a i) (diff (b i) (diff (c i) (diff (d i) seed))) (x i) := by
  change diff a (diff b (diff c (diff d
    (fun y => (seed ∘ (LinearMap.proj i : Input ι →ₗ[ZMod 2] SeedVec)) y +
      (cubic ∘ couplingLinear adj i) y)))) x = _
  simp only [diff_add]
  rw [fourthDiff_comp_linear, fourthDiff_comp_linear]
  simp only [Function.comp_apply, LinearMap.proj_apply, cubic_fourth_zero, add_zero]

/-- A constant second difference has zero fourth differences, in any directions. -/
theorem fourth_zero_of_second_constant {V : Type*}
    [AddCommGroup V] [Module (ZMod 2) V]
    (f : V → ZMod 2) (a b : V) (h : IsConstant (diff a (diff b f)))
    (c d x : V) : diff a (diff b (diff c (diff d f))) x = 0 := by
  rcases h with ⟨k, hk⟩
  rw [diff_commute b c, diff_commute a c, diff_commute b d, diff_commute a d, hk]
  simp [diff]

/-- Property (A) constrains every projected pair of a relaxed graph subspace. -/
theorem relaxed_pair_block_dependent (adj : ι → ι → Bool)
    (U : Submodule (ZMod 2) (Input ι)) (hU : IsVectorRelaxed (graphMap adj) U)
    (a : Input ι) (ha : a ∈ U) (b : Input ι) (hb : b ∈ U) (i : ι) :
    a i = 0 ∨ b i = 0 ∨ a i = b i := by
  apply SeedPropertyABridge.seed_property_A
  intro c d
  have h := fourth_zero_of_second_constant (component adj i) a b
    (hU i a ha b hb) (Pi.single i c) (Pi.single i d) 0
  rw [fourth_component] at h
  simpa only [Pi.single_eq_same, Pi.zero_apply] using h

/-- Pure linear-algebra consequence of the zero-or-equal pair criterion. -/
theorem finrank_le_one_of_pair_dependence (S : Submodule (ZMod 2) SeedVec)
    (hS : ∀ a ∈ S, ∀ b ∈ S, a = 0 ∨ b = 0 ∨ a = b) :
    Module.finrank (ZMod 2) S ≤ 1 := by
  classical
  apply (_root_.finrank_le_one_iff (K := ZMod 2) (V := S)).2
  by_cases hex : ∃ v : S, v ≠ 0
  · obtain ⟨v, hv⟩ := hex
    refine ⟨v, ?_⟩
    intro w
    rcases hS w.1 w.property v.1 v.property with hw | hv0 | hwv
    · refine ⟨0, ?_⟩
      simpa only [zero_smul] using (Subtype.ext hw).symm
    · exact False.elim (hv (Subtype.ext hv0))
    · refine ⟨1, ?_⟩
      simpa only [one_smul] using (Subtype.ext hwv).symm
  · refine ⟨0, ?_⟩
    intro w
    have hw : w = 0 := by
      by_contra h
      exact hex ⟨w, h⟩
    refine ⟨0, ?_⟩
    simpa only [zero_smul] using hw.symm

theorem graph_relaxed_upper (adj : ι → ι → Bool)
    (U : Submodule (ZMod 2) (Input ι)) (hU : IsVectorRelaxed (graphMap adj) U) :
    Module.finrank (ZMod 2) U ≤ Fintype.card ι := by
  calc
    Module.finrank (ZMod 2) U ≤
        ∑ i, Module.finrank (ZMod 2) (U.map (LinearMap.proj i)) :=
      finrank_le_sum_projection_finrank U
    _ ≤ ∑ _i : ι, 1 := by
      apply Finset.sum_le_sum
      intro i hi
      apply finrank_le_one_of_pair_dependence
      intro a ha b hb
      rcases ha with ⟨a, ha, rfl⟩
      rcases hb with ⟨b, hb, rfl⟩
      exact relaxed_pair_block_dependent adj U hU a ha b hb i
    _ = Fintype.card ι := by simp

/-- The safe coordinate does not occur in any cubic coupling. -/
def safeDirection : SeedVec := fun k => if k = 2 then 1 else 0

theorem safeDirection_ne_zero : safeDirection ≠ 0 := by native_decide

theorem coupling_selected_zero (adj : ι → ι → Bool) (i : ι) (α : ι → ZMod 2) :
    couplingLinear adj i (selectedDirectionMap (fun _ : ι => safeDirection) α) = 0 := by
  funext k
  fin_cases k <;> simp [couplingLinear, selectedDirectionMap, safeDirection,
    Pi.smul_apply, smul_eq_mul]

theorem second_component_selected (adj : ι → ι → Bool) (i : ι)
    (α β : ι → ZMod 2) (x : Input ι) :
    diff (selectedDirectionMap (fun _ : ι => safeDirection) α)
      (diff (selectedDirectionMap (fun _ : ι => safeDirection) β) (component adj i)) x = 0 := by
  change diff (selectedDirectionMap (fun _ : ι => safeDirection) α)
    (diff (selectedDirectionMap (fun _ : ι => safeDirection) β)
      (fun y => (seed ∘ (LinearMap.proj i : Input ι →ₗ[ZMod 2] SeedVec)) y +
        (cubic ∘ couplingLinear adj i) y)) x = 0
  simp only [diff_add]
  rw [secondDiff_comp_linear, secondDiff_comp_linear,
    coupling_selected_zero, coupling_selected_zero]
  change diff (α i • safeDirection) (diff (β i • safeDirection) seed) (x i) +
    diff 0 (diff 0 cubic) (couplingLinear adj i x) = 0
  rw [secondDiff_same_line_zero]
  simp

/-- Exact R2 certificate for every directed-graph coupling, with no assumption (A) left open. -/
theorem graph_has_exact_index (adj : ι → ι → Bool) :
    HasVectorRelaxedIndex (graphMap adj) (Fintype.card ι) := by
  constructor
  · exact graph_relaxed_upper adj
  · refine ⟨LinearMap.range (selectedDirectionMap (fun _ : ι => safeDirection)), ?_, ?_⟩
    · intro i a ha b hb
      rcases ha with ⟨α, rfl⟩
      rcases hb with ⟨β, rfl⟩
      refine ⟨0, ?_⟩
      funext x
      exact second_component_selected adj i α β x
    · exact selectedDirectionRange_finrank (fun _ : ι => safeDirection)
        (fun _ => safeDirection_ne_zero)

#print axioms graph_has_exact_index
end VonoExactIndex.GraphFamily
