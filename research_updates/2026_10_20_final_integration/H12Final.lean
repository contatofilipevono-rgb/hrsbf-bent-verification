import H12CloudChart0
import H12CloudChart1
import H12CloudChart2
import H12Fourier

/-! Unconditional nonexistence in the explicitly defined 43-orbit quartic
cyclic space on twelve variables. No statement for sixteen variables or
arbitrary even dimensions is asserted here. -/
namespace H12Final

theorem all_chart_refutations (k : Fin 3) :
    H12AffineFastState.Refutes H12CertificateBridge.Target
      (H12PackedRoots.rootPS k.val) (H12PackedRoots.rootEnv k.val)
      H12AffineFastState.identityEnv := by
  rcases k with ⟨k, hk⟩
  have cases : k = 0 ∨ k = 1 ∨ k = 2 := by omega
  rcases cases with h | h | h
  · subst k; exact H12CloudChart0.refutation
  · subst k; exact H12CloudChart1.refutation
  · subst k; exact H12CloudChart2.refutation

theorem no_bent_quartic (c : BitVec 43) :
    ¬ H12Descent.BentAC (H12.quarticFunction c) :=
  H12AffineFastState.no_bent_of_affine_state_refutations all_chart_refutations c

theorem no_flat_quartic (c : BitVec 43) :
    ¬ H12Fourier.WalshFlat (H12.quarticFunction c) := by
  intro hf
  exact no_bent_quartic c (H12Fourier.flat_implies_bent _ hf)

/-- Every coefficient choice has a frequency whose squared Walsh coefficient
differs from 4096, so its Walsh spectrum cannot have constant modulus 64. -/
theorem walsh_witness (c : BitVec 43) :
    ∃ a : Nat, a < 4096 ∧
      H12Walsh.walsh (H12.quarticFunction c) a *
      H12Walsh.walsh (H12.quarticFunction c) a ≠ 4096 := by
  classical
  apply Classical.byContradiction
  intro h
  apply no_flat_quartic c
  intro a ha
  apply Classical.byContradiction
  intro he
  exact h ⟨a, ha, he⟩

#print no_bent_quartic
#print no_flat_quartic
#print axioms all_chart_refutations
#print axioms no_bent_quartic
#print axioms no_flat_quartic
#print axioms walsh_witness
end H12Final
