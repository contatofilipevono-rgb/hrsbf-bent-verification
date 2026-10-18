import H12RowScanEmptyChartProof000

namespace H12RowScanEmptyChart

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem rejected (f : Nat → Bool) (hm : packedModels f rootPS) : ¬H12CertificateBridge.Target (packedObservation f rootObs) :=
  H12AffineRowScanState.reject_identity H12CertificateBridge.Target rootPS rootObs ref0 f hm

#print axioms rejected

theorem rootPS_identity : rootPS = H12PackedRoots.rootPS 3 := by
  exact beq_iff_eq.mp (by decide +kernel : (rootPS == H12PackedRoots.rootPS 3) = true)

theorem rootObs_identity : rootObs = H12PackedRoots.rootEnv 3 := by
  exact beq_iff_eq.mp (by decide +kernel : (rootObs == H12PackedRoots.rootEnv 3) = true)

theorem refutation : H12AffineRowScanState.Refutes H12CertificateBridge.Target (H12PackedRoots.rootPS 3) (H12PackedRoots.rootEnv 3) H12AffineRowScanState.identityEnv := by
  have h := ref0
  rw [rootPS_identity, rootObs_identity] at h
  exact h

#print axioms refutation

end H12RowScanEmptyChart