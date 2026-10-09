import VonoV3C.GraphMap
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.Algebra.Field.ZMod

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

end VonoV3C.GraphFamily
