import VonoExactIndex.SeedPropertyAComputations

namespace VonoExactIndex.SeedPropertyABridge

/-- Property (A), now for the exact SeedVec and seed used by the project.
The hypothesis only needs the fourth differences at the zero input. -/
theorem seed_property_A (a b : SeedVec)
    (h : ∀ c d : SeedVec,
      VonoExactIndex.diff a (VonoExactIndex.diff b
        (VonoExactIndex.diff c (VonoExactIndex.diff d VonoExactIndex.seed))) 0 = 0) :
    a = 0 ∨ b = 0 ∨ a = b := by
  obtain ⟨a', ha⟩ := decode_surjective a
  obtain ⟨b', hb⟩ := decode_surjective b
  have hz : ∀ p : Fin 28,
      let ij := QuarticSeedPropertyA.pairs[p.val]!
      QuarticSeedPropertyA.fourth a'.val b'.val (2 ^ ij.1) (2 ^ ij.2) = false := by
    intro p
    let c : Byte := ⟨2 ^ (QuarticSeedPropertyA.pairs[p.val]!).1, (basis_bounds p).1⟩
    let d : Byte := ⟨2 ^ (QuarticSeedPropertyA.pairs[p.val]!).2, (basis_bounds p).2⟩
    have ht := fourth_transport a' b' c d
    rw [ha, hb] at ht
    have hzero : fullFourth a'.val b'.val c.val d.val = 0 :=
      ht.trans (h (decode c.val) (decode d.val))
    have hbool := (fullFourth_matches_quartic_basis a' b' p).symm.trans hzero
    change boolValue (QuarticSeedPropertyA.fourth a'.val b'.val c.val d.val) = 0 at hbool
    change QuarticSeedPropertyA.fourth a'.val b'.val c.val d.val = false
    cases he : QuarticSeedPropertyA.fourth a'.val b'.val c.val d.val with
    | false => rfl
    | true =>
      have hbad : (1 : ZMod 2) = 0 := by
        simpa only [he, boolValue, Bool.true_eq_false, if_false, if_true] using hbool
      exact False.elim (one_ne_zero hbad)
  have hdep := QuarticSeedPropertyA.fourth_basis_zero_implies_dependent a' b' hz
  have hd : a' = 0 ∨ b' = 0 ∨ a' = b' := by
    simp only [QuarticSeedPropertyA.dependent, Bool.or_eq_true,
      Nat.beq_eq_true_eq] at hdep
    rcases hdep with (ha0 | hb0) | hab0
    · exact Or.inl (Fin.ext ha0)
    · exact Or.inr (Or.inl (Fin.ext hb0))
    · exact Or.inr (Or.inr (Fin.ext hab0))
  rcases hd with h0 | h0 | heq
  · left
    rw [← ha, h0]
    exact decode_zero
  · right; left
    rw [← hb, h0]
    exact decode_zero
  · right; right
    rw [← ha, ← hb, heq]


private theorem diff_commute (a b : SeedVec) (f : SeedVec → ZMod 2) :
    VonoExactIndex.diff a (VonoExactIndex.diff b f) =
      VonoExactIndex.diff b (VonoExactIndex.diff a f) := by
  funext x
  simp only [VonoExactIndex.diff]
  have hx : x + a + b = x + b + a := by abel
  rw [hx]
  abel

/-- The new fourth-difference certificate independently excludes constant
second differences along independent seed directions. -/
theorem no_independent_constant_pair_via_property_A (a b : SeedVec)
    (ha : a ≠ 0) (hb : b ≠ 0) (hab : a ≠ b) :
    ¬ IsConstant (VonoExactIndex.diff a (VonoExactIndex.diff b VonoExactIndex.seed)) := by
  rintro ⟨k, hk⟩
  have hd := seed_property_A a b (by
    intro c d
    rw [diff_commute b c, diff_commute a c,
      diff_commute b d, diff_commute a d, hk]
    simp [VonoExactIndex.diff])
  rcases hd with h0 | h0 | heq
  · exact ha h0
  · exact hb h0
  · exact hab heq

theorem relaxed_finrank_le_one_via_property_A
    (S : Submodule (ZMod 2) SeedVec)
    (hS : IsRelaxedMSubspace seed S) :
    Module.finrank (ZMod 2) S ≤ 1 := by
  classical
  apply (_root_.finrank_le_one_iff (K := ZMod 2) (V := S)).2
  by_cases hex : ∃ v : S, v ≠ 0
  · obtain ⟨v, hv⟩ := hex
    refine ⟨v, ?_⟩
    intro w
    by_cases hw : w = 0
    · refine ⟨0, ?_⟩
      simpa only [zero_smul] using hw.symm
    by_cases hwv : w = v
    · refine ⟨1, ?_⟩
      simpa only [one_smul] using hwv.symm
    exfalso
    have hw0 : (w : SeedVec) ≠ 0 := by
      intro h
      exact hw (Subtype.ext h)
    have hv0 : (v : SeedVec) ≠ 0 := by
      intro h
      exact hv (Subtype.ext h)
    have hwv0 : (w : SeedVec) ≠ (v : SeedVec) := by
      intro h
      exact hwv (Subtype.ext h)
    have hc : IsConstant
        (diff (w : SeedVec) (diff (v : SeedVec) seed)) := by
      exact hS w.1 w.property v.1 v.property
    exact no_independent_constant_pair_via_property_A
      (w : SeedVec) (v : SeedVec) hw0 hv0 hwv0 hc
  · refine ⟨0, ?_⟩
    intro w
    have hw : w = 0 := by
      by_contra h
      exact hex ⟨w, h⟩
    refine ⟨0, ?_⟩
    simpa only [zero_smul] using hw.symm


/-- Exact repeated-block indices derived through property (A).
The selected nonzero direction is the same parameter used by the original certificate. -/
theorem exact_indices_via_property_A (r : Nat) (e0 : SeedVec) (he0 : e0 ≠ 0) :
    HasMIndex (blockSum (fun _ : Fin r => VonoExactIndex.seed)) r ∧
    HasRelaxedMIndex (blockSum (fun _ : Fin r => VonoExactIndex.seed)) r := by
  simpa using (exact_block_has_indices
    (f := fun _ : Fin r => VonoExactIndex.seed)
    (hseed := fun _ S hS => relaxed_finrank_le_one_via_property_A S hS)
    (e := fun _ : Fin r => e0)
    (hne := fun _ => he0))

/-- A fixed nonzero direction removes the witness parameter from the final index theorem. -/
def canonicalDirection : SeedVec := fun i => if i = 0 then 1 else 0

theorem canonicalDirection_ne_zero : canonicalDirection ≠ 0 := by
  native_decide

theorem exact_indices_canonical_via_property_A (r : Nat) :
    HasMIndex (blockSum (fun _ : Fin r => VonoExactIndex.seed)) r ∧
    HasRelaxedMIndex (blockSum (fun _ : Fin r => VonoExactIndex.seed)) r := by
  exact exact_indices_via_property_A r canonicalDirection canonicalDirection_ne_zero

#print axioms seed_property_A
#print axioms exact_indices_canonical_via_property_A

end VonoExactIndex.SeedPropertyABridge
