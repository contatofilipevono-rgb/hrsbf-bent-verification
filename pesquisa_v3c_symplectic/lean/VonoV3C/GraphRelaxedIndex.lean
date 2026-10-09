import VonoV3C.GraphMap
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.LinearAlgebra.Dimension.FreeAndStrongRankCondition
import Mathlib.LinearAlgebra.Basis.VectorSpace
import Mathlib.Algebra.Field.ZMod

open scoped BigOperators
set_option maxHeartbeats 300000
local instance : Fact (Nat.Prime 2) := ⟨by decide⟩

namespace VonoV3C.GraphFamily

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

/-- Every output coordinate has constant second difference on `U`. -/
def IsVectorRelaxed (F : Input ι m → Output ι)
    (U : Submodule Scalar (Input ι m)) : Prop :=
  ∀ i, ∀ a ∈ U, ∀ b ∈ U, ∃ z : Scalar, ∀ x,
    diff a (diff b (fun y => F y i)) x = z

def HasVectorRelaxedIndex (F : Input ι m → Output ι) (r : ℕ) : Prop :=
  (∀ U : Submodule Scalar (Input ι m), IsVectorRelaxed F U →
      Module.finrank Scalar U ≤ r) ∧
    ∃ U : Submodule Scalar (Input ι m), IsVectorRelaxed F U ∧
      Module.finrank Scalar U = r

/-- One internal seed coordinate, disjoint from the two graph-coupling inputs. -/
def relaxedSafeIndex (hm : 2 ≤ m) : Fin m :=
  ⟨1, Nat.lt_of_lt_of_le (by decide : 1 < 2) hm⟩

def relaxedSafeDirection (hm : 2 ≤ m) : Vec m :=
  Pi.single (relaxedSafeIndex hm) (1, 0)

def selectedRelaxedDirections (hm : 2 ≤ m) :
    (ι → Scalar) →ₗ[Scalar] Input ι m where
  toFun α i := α i • relaxedSafeDirection hm
  map_add' := by
    intro α β
    funext i
    simp [add_smul]
  map_smul' := by
    intro c α
    funext i
    simp [mul_smul]

private theorem firstIndex_ne_relaxedSafeIndex (hm : 2 ≤ m) :
    firstIndex hm ≠ relaxedSafeIndex hm := by
  intro h
  have hv := congrArg Fin.val h
  simp [firstIndex, relaxedSafeIndex] at hv

private theorem p_relaxedSafeDirection (hm : 2 ≤ m) :
    p hm (relaxedSafeDirection hm) = 0 := by
  have hzero : relaxedSafeDirection hm (firstIndex hm) = (0, 0) := by
    simp [relaxedSafeDirection, Pi.single_apply,
      firstIndex_ne_relaxedSafeIndex hm]
  change (relaxedSafeDirection hm (firstIndex hm)).1 = 0
  rw [hzero]

private theorem q_relaxedSafeDirection (hm : 2 ≤ m) :
    q hm (relaxedSafeDirection hm) = 0 := by
  have hzero : relaxedSafeDirection hm (firstIndex hm) = (0, 0) := by
    simp [relaxedSafeDirection, Pi.single_apply,
      firstIndex_ne_relaxedSafeIndex hm]
  change (relaxedSafeDirection hm (firstIndex hm)).2 = 0
  rw [hzero]

private theorem p_selectedRelaxedDirections (hm : 2 ≤ m) (α : ι → Scalar)
    (i : ι) : p hm (selectedRelaxedDirections hm α i) = 0 := by
  change (α i • (relaxedSafeDirection hm (firstIndex hm))).1 = 0
  have hzero : relaxedSafeDirection hm (firstIndex hm) = (0, 0) := by
    simp [relaxedSafeDirection, Pi.single_apply,
      firstIndex_ne_relaxedSafeIndex hm]
  rw [hzero]
  simp

private theorem q_selectedRelaxedDirections (hm : 2 ≤ m) (α : ι → Scalar)
    (i : ι) : q hm (selectedRelaxedDirections hm α i) = 0 := by
  change (α i • (relaxedSafeDirection hm (firstIndex hm))).2 = 0
  have hzero : relaxedSafeDirection hm (firstIndex hm) = (0, 0) := by
    simp [relaxedSafeDirection, Pi.single_apply,
      firstIndex_ne_relaxedSafeIndex hm]
  rw [hzero]
  simp

private theorem coupling_selectedRelaxedDirections (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (i : ι) (α : ι → Scalar) :
    couplingLinear hm adj i (selectedRelaxedDirections hm α) = 0 := by
  funext k
  by_cases hk0 : k = 0
  · subst k
    simp [couplingLinear, p_selectedRelaxedDirections]
  · by_cases hk1 : k = 1
    · subst k
      simp [couplingLinear, hk0, q_selectedRelaxedDirections]
    · simp [couplingLinear, hk0, hk1, p_selectedRelaxedDirections]

private theorem secondDiff_comp_linear {V W : Type*} [AddCommGroup V]
    [Module Scalar V] [AddCommGroup W] [Module Scalar W]
    (L : V →ₗ[Scalar] W) (a b : V) (f : W → Scalar) :
    diff a (diff b (f ∘ L)) =
      (diff (L a) (diff (L b) f)) ∘ L := by
  rw [diff_comp_linear, diff_comp_linear]

private theorem secondDiff_add {V : Type*} [Add V]
    (a b : V) (f g : V → Scalar) :
    diff a (diff b (fun x => f x + g x)) =
      fun x => diff a (diff b f) x + diff a (diff b g) x := by
  rw [diff_add, diff_add]

private theorem secondDiff_zero_of_pair (a b : Vec m) (f : Vec m → Scalar)
    (h : a = 0 ∨ b = 0 ∨ a = b) :
    diff a (diff b f) = 0 := by
  rcases h with ha | hb | hab
  · subst a
    funext x
    simp [diff]
  · subst b
    funext x
    simp [diff]
  · subst b
    exact diff_self a f

private theorem selectedDirections_pair_dependent (hm : 2 ≤ m)
    (α β : ι → Scalar) (i : ι) :
    selectedRelaxedDirections hm α i = 0 ∨
      selectedRelaxedDirections hm β i = 0 ∨
      selectedRelaxedDirections hm α i = selectedRelaxedDirections hm β i := by
  have hα := scalar_zero_or_one (α i)
  have hβ := scalar_zero_or_one (β i)
  dsimp [selectedRelaxedDirections]
  rcases hα with hα | hα <;> rcases hβ with hβ | hβ
  · left
    rw [hα]
    simp
  · left
    rw [hα]
    simp
  · right; left
    rw [hβ]
    simp
  · right; right
    rw [hα, hβ]

/-- The seed's second difference vanishes for the selected line in each block. -/
private theorem secondDiff_seed_selected (hm : 2 ≤ m) (α β : ι → Scalar)
    (i : ι) :
    diff (selectedRelaxedDirections hm α i)
      (diff (selectedRelaxedDirections hm β i) (seed m)) = 0 :=
  secondDiff_zero_of_pair _ _ _ (selectedDirections_pair_dependent hm α β i)

/-- The graph term is constant along every selected relaxed direction. -/
private theorem secondDiff_component_selected (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (i : ι) (α β : ι → Scalar) (x : Input ι m) :
    diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β) (component hm adj i)) x = 0 := by
  change diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β)
        (fun y => (seed m ∘ (LinearMap.proj i : Input ι m →ₗ[Scalar] Vec m)) y +
          (cubic ∘ couplingLinear hm adj i) y)) x = 0
  have hsx : diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β)
        (seed m ∘ (LinearMap.proj i : Input ι m →ₗ[Scalar] Vec m))) x = 0 := by
    rw [secondDiff_comp_linear]
    change diff (selectedRelaxedDirections hm α i)
      (diff (selectedRelaxedDirections hm β i) (seed m)) (x i) = 0
    exact congrFun (secondDiff_seed_selected hm α β i) (x i)
  have hcx : diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β)
        (cubic ∘ couplingLinear hm adj i)) x = 0 := by
    rw [secondDiff_comp_linear]
    rw [coupling_selectedRelaxedDirections hm adj i α,
      coupling_selectedRelaxedDirections hm adj i β]
    simp [diff]
  rw [secondDiff_add]
  change diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β)
        (seed m ∘ (LinearMap.proj i : Input ι m →ₗ[Scalar] Vec m))) x +
    diff (selectedRelaxedDirections hm α)
      (diff (selectedRelaxedDirections hm β)
        (cubic ∘ couplingLinear hm adj i)) x = 0
  rw [hsx, hcx]
  simp

private theorem selectedRelaxedDirections_injective (hm : 2 ≤ m) :
    Function.Injective (selectedRelaxedDirections (ι := ι) hm) := by
  intro α β h
  funext i
  have hi := congrFun h i
  have hc := congrArg (fun v : Vec m => (v (relaxedSafeIndex hm)).1) hi
  simpa [selectedRelaxedDirections, relaxedSafeDirection,
    Pi.single_apply] using hc

private theorem fourth_zero_of_second_constant {V : Type*}
    [AddCommGroup V] [Module Scalar V]
    (f : V → Scalar) (a b : V)
    (h : ∃ z : Scalar, ∀ x, diff a (diff b f) x = z)
    (c d x : V) : fourth f a b c d x = 0 := by
  rcases h with ⟨z, hz⟩
  have hconst : diff a (diff b f) = fun _ => z := funext hz
  unfold fourth
  rw [diff_comm b c, diff_comm a c, diff_comm b d, diff_comm a d, hconst]
  simp [diff]

private theorem relaxed_pair_block_dependent (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (U : Submodule Scalar (Input ι m))
    (hU : IsVectorRelaxed (graphMap hm adj) U)
    (a : Input ι m) (ha : a ∈ U) (b : Input ι m) (hb : b ∈ U)
    (i : ι) : a i = 0 ∨ b i = 0 ∨ a i = b i := by
  apply seed_property_A hm
  intro c d
  have hfourth := fourth_zero_of_second_constant
    (fun x => graphMap hm adj x i) a b (hU i a ha b hb)
    (Pi.single i c) (Pi.single i d) 0
  change fourth (component hm adj i) a b (Pi.single i c) (Pi.single i d) 0 = 0
    at hfourth
  rw [fourth_component] at hfourth
  have hlocal : pfaffian (a i) (b i) c d = 0 := by
    simpa only [Pi.single_eq_same] using hfourth
  calc
    fourth (seed m) (a i) (b i) c d 0 = pfaffian (a i) (b i) c d :=
      seed_fourth (a i) (b i) c d 0
    _ = 0 := hlocal

private theorem finrank_le_one_of_pair_dependence
    (S : Submodule Scalar (Vec m))
    (hS : ∀ a ∈ S, ∀ b ∈ S, a = 0 ∨ b = 0 ∨ a = b) :
    Module.finrank Scalar S ≤ 1 := by
  classical
  apply (_root_.finrank_le_one_iff (K := Scalar) (V := S)).2
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

private def projectionRangeMap
    (U : Submodule Scalar (Input ι m)) :
    U →ₗ[Scalar] (∀ i, U.map (LinearMap.proj i)) where
  toFun := fun u i => ⟨u.1 i, ⟨u, u.2, rfl⟩⟩
  map_add' := by
    intro x y
    ext i j <;> rfl
  map_smul' := by
    intro c x
    ext i j <;> rfl

private theorem projectionRangeMap_injective
    (U : Submodule Scalar (Input ι m)) :
    Function.Injective (projectionRangeMap U) := by
  intro x y h
  apply Subtype.ext
  funext i
  exact congrArg (fun z => (z i).1) h

private theorem finrank_le_sum_projection_finrank
    (U : Submodule Scalar (Input ι m)) :
    Module.finrank Scalar U ≤
      ∑ i, Module.finrank Scalar (U.map (LinearMap.proj i)) := by
  have hinj := projectionRangeMap_injective U
  have hle : Module.finrank Scalar U ≤
      Module.finrank Scalar (∀ i, U.map (LinearMap.proj i)) :=
    LinearMap.finrank_le_finrank_of_injective hinj
  calc
    Module.finrank Scalar U ≤
        Module.finrank Scalar (∀ i, U.map (LinearMap.proj i)) := hle
    _ = ∑ i, Module.finrank Scalar (U.map (LinearMap.proj i)) :=
      Module.finrank_pi_fintype Scalar

/-- The vector relaxed index is at most one per graph vertex. -/
theorem graph_relaxed_upper_bound (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (U : Submodule Scalar (Input ι m))
    (hU : IsVectorRelaxed (graphMap hm adj) U) :
    Module.finrank Scalar U ≤ Fintype.card ι := by
  calc
    Module.finrank Scalar U ≤
        ∑ i, Module.finrank Scalar (U.map (LinearMap.proj i)) :=
      finrank_le_sum_projection_finrank U
    _ ≤ ∑ _i : ι, 1 := by
      apply Finset.sum_le_sum
      intro i hi
      apply finrank_le_one_of_pair_dependence
      intro a ha b hb
      rcases ha with ⟨a, ha, rfl⟩
      rcases hb with ⟨b, hb, rfl⟩
      exact relaxed_pair_block_dependent hm adj U hU a ha b hb i
    _ = Fintype.card ι := by simp

/-- The V3-C graph family has a relaxed subspace of dimension `card ι`. -/
theorem graph_relaxed_lower_bound (hm : 2 ≤ m) (adj : ι → ι → Bool) :
    ∃ U : Submodule Scalar (Input ι m),
      IsVectorRelaxed (graphMap hm adj) U ∧
        Module.finrank Scalar U = Fintype.card ι := by
  refine ⟨LinearMap.range (selectedRelaxedDirections (ι := ι) hm), ?_, ?_⟩
  · intro i a ha b hb
    rcases ha with ⟨α, rfl⟩
    rcases hb with ⟨β, rfl⟩
    refine ⟨0, ?_⟩
    intro x
    exact secondDiff_component_selected hm adj i α β x
  · have hinj := selectedRelaxedDirections_injective (ι := ι) hm
    have hrange := LinearMap.finrank_range_of_inj hinj
    calc
      Module.finrank Scalar (LinearMap.range (selectedRelaxedDirections (ι := ι) hm)) =
          Module.finrank Scalar (ι → Scalar) := hrange
      _ = Fintype.card ι := by
        rw [Module.finrank_pi_fintype]
        simp

/-- Exact relaxed index of the canonical V3-C graph family, uniformly in the
directed adjacency relation. -/
theorem graph_has_exact_relaxed_index (hm : 2 ≤ m) (adj : ι → ι → Bool) :
    HasVectorRelaxedIndex (graphMap hm adj) (Fintype.card ι) := by
  constructor
  · intro U hU
    exact graph_relaxed_upper_bound hm adj U hU
  · exact graph_relaxed_lower_bound hm adj

end VonoV3C.GraphFamily
