import VonoV3C.GraphMap
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.Algebra.Field.ZMod
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Basis.VectorSpace
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

open scoped BigOperators

local instance : Fact (Nat.Prime 2) := ⟨by decide⟩

namespace VonoV3C.GraphFamily

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

/-- For a fixed first vector, the blockwise quartic radical. -/
def PairKernel (a : Input ι m) : Set (Input ι m) :=
  {b | Blocks.PairDependent a b}

/-- Vanishing of the actual graph map's fourth derivative in a pair of
directions, in every output coordinate and for all remaining directions. -/
def GraphFourthPairZero (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (a b : Input ι m) : Prop :=
  ∀ c d : Input ι m, ∀ i,
    fourth (fun x => graphMap hm adj x i) a b c d 0 = 0

/-- The graph fourth-derivative radical is exactly the blockwise pair
kernel. The graph-dependent cubic terms vanish at order four. -/
theorem mem_pairKernel_iff_graphFourthPairZero (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (a b : Input ι m) :
    b ∈ PairKernel a ↔ GraphFourthPairZero hm adj a b := by
  change Blocks.PairDependent a b ↔ GraphFourthPairZero hm adj a b
  constructor
  · intro h c d i
    change fourth (component hm adj i) a b c d 0 = 0
    rw [fourth_component]
    exact (Blocks.quartic_pair_zero_iff hm a b).2 h c d i
  · intro h
    apply (Blocks.quartic_pair_zero_iff hm a b).1
    intro c d i
    have hh := h c d i
    change fourth (component hm adj i) a b c d 0 = 0 at hh
    rw [fourth_component] at hh
    exact hh

/-- The local radical is unrestricted at zero and a line at a nonzero vector. -/
def blockPairKernel (v : Vec m) : Submodule Scalar (Vec m) :=
  if v = 0 then ⊤ else Submodule.span Scalar {v}

theorem mem_blockPairKernel (v w : Vec m) :
    w ∈ blockPairKernel v ↔ v = 0 ∨ w = 0 ∨ v = w := by
  classical
  by_cases hv : v = 0
  · simp [blockPairKernel, hv]
  · rw [blockPairKernel, if_neg hv, Submodule.mem_span_singleton]
    constructor
    · rintro ⟨c, hc⟩
      rcases scalar_zero_or_one c with hzero | hone
      · right; left
        simpa [hzero] using hc.symm
      · right; right
        simpa [hone] using hc
    · rintro (hzero | hzero | heq)
      · exact False.elim (hv hzero)
      · exact ⟨0, by simp [hzero]⟩
      · exact ⟨1, by simp [heq]⟩

/-- A linear subspace whose underlying set is the previously certified radical. -/
def pairKernelSpace (a : Input ι m) : Submodule Scalar (Input ι m) :=
  Submodule.pi Set.univ (fun i => blockPairKernel (a i))

omit [Fintype ι] [DecidableEq ι] in
theorem mem_pairKernelSpace (a b : Input ι m) :
    b ∈ pairKernelSpace a ↔ b ∈ PairKernel a := by
  simp only [pairKernelSpace, Submodule.mem_pi, Set.mem_univ, forall_const,
    mem_blockPairKernel]
  rfl

theorem mem_pairKernelSpace_iff_graphFourthPairZero (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (a b : Input ι m) :
    b ∈ pairKernelSpace a ↔ GraphFourthPairZero hm adj a b :=
  (mem_pairKernelSpace a b).trans
    (mem_pairKernel_iff_graphFourthPairZero hm adj a b)

/-- The same radical description holds at every base point. -/
theorem mem_pairKernelSpace_iff_graphFourth_zero (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (a b : Input ι m) :
    b ∈ pairKernelSpace a ↔ ∀ c d x : Input ι m, ∀ i,
      fourth (fun y => graphMap hm adj y i) a b c d x = 0 := by
  constructor
  · intro hb c d x i
    have hd : Blocks.PairDependent a b := (mem_pairKernelSpace a b).mp hb
    change fourth (component hm adj i) a b c d x = 0
    rw [fourth_component]
    exact (Blocks.quartic_pair_zero_iff hm a b).mpr hd c d i
  · intro h
    apply (mem_pairKernelSpace_iff_graphFourthPairZero hm adj a b).mpr
    intro c d i
    exact h c d 0 i

/-- Explicit product decomposition, including zero blocks and empty vertex types. -/
def pairKernelPiEquiv (a : Input ι m) :
    pairKernelSpace a ≃ₗ[Scalar] (∀ i, blockPairKernel (a i)) where
  toFun x i := ⟨x.1 i, (Submodule.mem_pi.mp x.2) i (Set.mem_univ i)⟩
  invFun y := ⟨fun i => (y i).1,
    Submodule.mem_pi.mpr (by intro i _; exact (y i).2)⟩
  left_inv x := by rfl
  right_inv y := by rfl
  map_add' x y := by rfl
  map_smul' c x := by rfl

theorem finrank_vec (m : ℕ) : Module.finrank Scalar (Vec m) = 2 * m := by
  rw [Module.finrank_pi_fintype]
  simp [Module.finrank_prod, Module.finrank_self, Nat.mul_comm]

theorem finrank_blockPairKernel (v : Vec m) :
    Module.finrank Scalar (blockPairKernel v) = if v = 0 then 2 * m else 1 := by
  classical
  by_cases hv : v = 0
  · rw [blockPairKernel, if_pos hv, if_pos hv, finrank_top, finrank_vec]
  · rw [blockPairKernel, if_neg hv, if_neg hv]
    exact finrank_span_singleton hv

omit [DecidableEq ι] in
theorem finrank_pairKernelSpace_sum (a : Input ι m) :
    Module.finrank Scalar (pairKernelSpace a) =
      ∑ i, if a i = 0 then 2 * m else 1 := by
  rw [(pairKernelPiEquiv a).finrank_eq, Module.finrank_pi_fintype]
  exact Finset.sum_congr rfl (fun i _ => finrank_blockPairKernel (a i))

/-- Number of nonzero vertex blocks of an input vector. -/
def supportCount (a : Input ι m) : ℕ :=
  (Finset.univ.filter (fun i => a i ≠ 0)).card

omit [DecidableEq ι] in
theorem supportCount_eq_sum (a : Input ι m) :
    supportCount a = ∑ i, if a i ≠ 0 then 1 else 0 := by
  classical
  exact Finset.card_filter (fun i => a i ≠ 0) Finset.univ

/-- Exact radical dimension, uniformly over the finite vertex set. -/
theorem finrank_pairKernelSpace (hm : 2 ≤ m) (a : Input ι m) :
    Module.finrank Scalar (pairKernelSpace a) =
      2 * m * Fintype.card ι - (2 * m - 1) * supportCount a := by
  classical
  have heach (i : ι) :
      (if a i = 0 then 2 * m else 1) +
        (2 * m - 1) * (if a i ≠ 0 then 1 else 0) = 2 * m := by
    by_cases hi : a i = 0
    · simp [hi]
    · simp [hi]
      omega
  have hsum : (∑ i, ((if a i = 0 then 2 * m else 1) +
      (2 * m - 1) * (if a i ≠ 0 then 1 else 0))) = ∑ _i : ι, 2 * m :=
    Finset.sum_congr rfl (fun i _ => heach i)
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← supportCount_eq_sum] at hsum
  simp only [Finset.sum_const, Finset.card_univ, smul_eq_mul] at hsum
  rw [Nat.mul_comm (Fintype.card ι) (2 * m)] at hsum
  rw [finrank_pairKernelSpace_sum]
  omega

/-- The actual graph fourth-derivative radical is a linear subspace with the
claimed dimension. No adjacency or tensor-preservation premise is assumed. -/
theorem graph_fourth_radical_dimension (hm : 2 ≤ m)
    (adj : ι → ι → Bool) (a : Input ι m) :
    ∃ K : Submodule Scalar (Input ι m),
      (∀ b, b ∈ K ↔ ∀ c d x : Input ι m, ∀ i,
        fourth (fun y => graphMap hm adj y i) a b c d x = 0) ∧
      Module.finrank Scalar K =
        2 * m * Fintype.card ι - (2 * m - 1) * supportCount a :=
  ⟨pairKernelSpace a, mem_pairKernelSpace_iff_graphFourth_zero hm adj a,
    finrank_pairKernelSpace hm a⟩

end VonoV3C.GraphFamily
