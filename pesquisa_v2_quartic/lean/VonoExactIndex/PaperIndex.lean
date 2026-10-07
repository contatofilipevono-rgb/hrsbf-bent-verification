import VonoExactIndex.Seed8
import VonoExactIndex.LinearTransport

namespace VonoExactIndex

/--
The explicit interleaved quartic paper family has both ordinary and relaxed
M-index exactly r, or equivalently n/8 for n = 8r.
-/
theorem paperFr_has_exact_indices (r : Nat) :
    HasMIndex (paperFr r) r ∧
    HasRelaxedMIndex (paperFr r) r ∧
    (8 * r) / 8 = r := by
  let e0 : SeedVec := fun _ => 1
  have he0 : e0 ≠ 0 := by
    intro h
    have h0 := congrFun h 0
    norm_num [e0] at h0
  obtain ⟨hM, hR⟩ := seed8_r_blocks_has_exact_indices r e0 he0
  rw [paperFr_eq_blockSum_comp_linearEquiv]
  exact ⟨HasMIndex.comp_linearEquiv (paperBlockLinearEquiv r)
    (blockSum (fun _ : Fin r => seed)) r hM,
    HasRelaxedMIndex.comp_linearEquiv (paperBlockLinearEquiv r)
      (blockSum (fun _ : Fin r => seed)) r hR,
    paperFr_variable_count r⟩

end VonoExactIndex
